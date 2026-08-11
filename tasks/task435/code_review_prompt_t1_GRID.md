# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 571: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFUN.prg) - TRECHOS RELEVANTES PARA PASS GRID (3793 linhas total):

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
108: 
109:                 *-- Valores iniciais dos filtros
110:                 THIS.this_cPEmps  = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
111:                 THIS.this_dDtIni  = DATE()
112:                 THIS.this_dDtFim  = DATE()
113:                 THIS.this_cAntEmpr = THIS.this_cPEmps
114:                 THIS.this_dAntDtI  = THIS.this_dDtIni

*-- Linhas 543 a 628:
543:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
544: 
545:         *----------------------------------------------------------------------
546:         * grd_4c_Dados - Grade principal de listagem
547:         * Original: Grade.Top=157, Left=12, Width=944, Height=434 -> comp +29 = 186
548:         * ColumnCount DEVE ser setado FORA do WITH (nao cria colunas dentro do WITH)
549:         *----------------------------------------------------------------------
550:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
551:         loc_oPagina.grd_4c_Dados.ColumnCount = 6
552:         WITH loc_oPagina.grd_4c_Dados
553:             .Top                = 186
554:             .Left               = 12
555:             .Width              = 944
556:             .Height             = 434
557:             .FontName           = "Tahoma"
558:             .FontSize           = 8
559:             .ForeColor          = RGB(90, 90, 90)
560:             .BackColor          = RGB(255, 255, 255)
561:             .GridLineColor      = RGB(238, 158, 162)
562:             .HighlightBackColor = RGB(255, 255, 255)
563:             .HighlightForeColor = RGB(15, 41, 104)
564:             .HighlightStyle     = 2
565:             .DeleteMark         = .F.
566:             .RecordMark         = .F.
567:             .RowHeight          = 16
568:             .ScrollBars         = 2
569:             .GridLines          = 3
570:             .ReadOnly           = .T.
571:             .RecordSource       = "cursor_4c_Dados"
572:             .RecordSourceType   = 1
573:         ENDWITH
574: 
575:         WITH loc_oPagina.grd_4c_Dados.Column1
576:             .ControlSource   = "cursor_4c_Dados.codigos"
577:             .Width           = 70
578:             .Alignment       = 2
579:             .Header1.Caption = "N" + CHR(186) + " Fundi" + CHR(231) + CHR(227) + "o"
580:         ENDWITH
581: 
582:         WITH loc_oPagina.grd_4c_Dados.Column2
583:             .ControlSource   = "cursor_4c_Dados.emps"
584:             .Width           = 60
585:             .Header1.Caption = "Empresa"
586:         ENDWITH
587: 
588:         WITH loc_oPagina.grd_4c_Dados.Column3
589:             .ControlSource   = "cursor_4c_Dados.datas"
590:             .Width           = 140
591:             .Header1.Caption = "Data"
592:         ENDWITH
593: 
594:         WITH loc_oPagina.grd_4c_Dados.Column4
595:             .ControlSource   = "cursor_4c_Dados.codmaqfs"
596:             .Width           = 100
597:             .Header1.Caption = "M" + CHR(225) + "quina"
598:         ENDWITH
599: 
600:         WITH loc_oPagina.grd_4c_Dados.Column5
601:             .ControlSource   = "cursor_4c_Dados.ntubos"
602:             .Width           = 60
603:             .Alignment       = 2
604:             .Header1.Caption = "Tubos"
605:         ENDWITH
606: 
607:         WITH loc_oPagina.grd_4c_Dados.Column6
608:             .ControlSource   = "cursor_4c_Dados.usuars"
609:             .Width           = 100
610:             .Header1.Caption = "Usu" + CHR(225) + "rio"
611:         ENDWITH
612: 
613:         BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
614: 
615:         THIS.TornarControlesVisiveis(loc_oPagina)
616:     ENDPROC
617: 
618:     *==========================================================================
619:     PROTECTED PROCEDURE ConfigurarPaginaDados()
620:     *==========================================================================
621:         LOCAL loc_oPagina
622:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
623: 
624:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
625:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
626: 
627:         *----------------------------------------------------------------------
628:         * cnt_4c_Salva - Botoes Confirmar/Cancelar (Fase 4 adiciona os botoes)

*-- Linhas 1077 a 1116:
1077:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1078:                         IF THIS.this_oBusinessObject.Excluir()
1079:                             THIS.CarregarLista()
1080:                             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1081:                                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1082:                             ENDIF
1083:                             loc_lSucesso = .T.
1084:                         ENDIF
1085:                     ENDIF
1086:                 ENDIF
1087:             ENDIF
1088:         CATCH TO loc_oErro
1089:             MsgErro("Erro em FormFUN.BtnExcluirClick: " + loc_oErro.Message, "Erro")
1090:         ENDTRY
1091: 
1092:         RETURN loc_lSucesso
1093:     ENDPROC
1094: 
1095:     *==========================================================================
1096:     PROCEDURE BtnBuscarClick()
1097:     *==========================================================================
1098:         TRY
1099:             THIS.CarregarLista()
1100:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1101:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1102:             ENDIF
1103:         CATCH TO loc_oErro
1104:             MsgErro("Erro em FormFUN.BtnBuscarClick: " + loc_oErro.Message, "Erro")
1105:         ENDTRY
1106:     ENDPROC
1107: 
1108:     *==========================================================================
1109:     PROCEDURE BtnSalvarClick()
1110:     *==========================================================================
1111:         LOCAL loc_lSucesso
1112:         loc_lSucesso = .F.
1113: 
1114:         TRY
1115:             THIS.SalvarDadosTubo()
1116:             THIS.FormParaBO()

*-- Linhas 1697 a 1719:
1697:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
1698:                     GO TOP
1699:                 ENDIF
1700:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_Gradenop", 5)
1701:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_Gradenop.Refresh()
1702:                 ENDIF
1703:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
1704:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
1705:                 ENDIF
1706:             ELSE
1707:                 THIS.LimparCamposTubo()
1708:             ENDIF
1709:         CATCH TO loc_oErro
1710:             MsgErro("Erro em FormFUN.ChkTubo " + TRANSFORM(par_nTubo) + ": " + ;
1711:                 loc_oErro.Message, "Erro")
1712:         ENDTRY
1713:     ENDPROC
1714: 
1715:     *==========================================================================
1716:     PROCEDURE LimparCampos()
1717:     *==========================================================================
1718:         LOCAL loc_oCnt1, loc_oCnt2, loc_oCnt3, loc_n, loc_cNomeChk
1719: 

*-- Linhas 2145 a 2195:
2145:             .BackColor = RGB(240, 240, 240)
2146:         ENDWITH
2147: 
2148:         loc_oCnt.AddObject("grd_4c_Gradenop", "Grid")
2149:         loc_oCnt.grd_4c_Gradenop.ColumnCount = 5
2150:         WITH loc_oCnt.grd_4c_Gradenop
2151:             .Top                     = 48
2152:             .Left                    = 7
2153:             .Width                   = 435
2154:             .Height                  = 122
2155:             .RecordSource            = "TmpNop"
2156:             .FontName                = "Tahoma"
2157:             .FontSize                = 8
2158:             .ReadOnly                = .T.
2159:             .GridLines               = 1
2160:             .HeaderHeight            = 17
2161:             .RowHeight               = 17
2162:             .Column1.Header1.Caption = "O.P."
2163:             .Column1.ControlSource   = "TmpNop.Nops"
2164:             .Column1.Width           = 60
2165:             .Column2.Header1.Caption = "Produto"
2166:             .Column2.ControlSource   = "TmpNop.Cpros"
2167:             .Column2.Width           = 110
2168:             .Column3.Header1.Caption = "Qtde"
2169:             .Column3.ControlSource   = "TmpNop.Qtds"
2170:             .Column3.Width           = 60
2171:             .Column4.Header1.Caption = "Pedido"
2172:             .Column4.ControlSource   = "TmpNop.Numes"
2173:             .Column4.Width           = 50
2174:             .Column5.Header1.Caption = "Data Entrega"
2175:             .Column5.ControlSource   = "TmpNop.DtEnts"
2176:             .Column5.Width           = 90
2177:             .RecordMark   = .F.
2178:             .DeleteMark   = .F.
2179:         ENDWITH
2180:         BINDEVENT(loc_oCnt.grd_4c_Gradenop, "AfterRowColChange", THIS, "GradenopAfterRowColChange")
2181: 
2182:         loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
2183:         WITH loc_oCnt.txt_4c_Operacao
2184:             .Value     = ""
2185:             .Left      = 18
2186:             .Top       = 171
2187:             .Width     = 290
2188:             .Height    = 25
2189:             .ReadOnly  = .T.
2190:             .FontName  = "Tahoma"
2191:             .FontSize  = 8
2192:             .BackColor = RGB(240, 240, 240)
2193:         ENDWITH
2194: 
2195:         loc_oCnt.AddObject("cmd_4c_AdicionarNop", "CommandButton")

*-- Linhas 2268 a 2303:
2268:         ENDWITH
2269:         BINDEVENT(loc_oCnt.txt_4c_Trf, "KeyPress", THIS, "TrfLostFocus")
2270: 
2271:         loc_oCnt.AddObject("grd_4c_GradeTrf", "Grid")
2272:         loc_oCnt.grd_4c_GradeTrf.ColumnCount = 2
2273:         WITH loc_oCnt.grd_4c_GradeTrf
2274:             .Top                     = 216
2275:             .Left                    = 209
2276:             .Width                   = 233
2277:             .Height                  = 122
2278:             .RecordSource            = "TmpTrf"
2279:             .FontName                = "Tahoma"
2280:             .FontSize                = 8
2281:             .ReadOnly                = .T.
2282:             .GridLines               = 1
2283:             .HeaderHeight            = 17
2284:             .RowHeight               = 17
2285:             .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2286:             .Column1.ControlSource   = "TmpTrf.Dopes"
2287:             .Column1.Width           = 155
2288:             .Column2.Header1.Caption = "Numes"
2289:             .Column2.ControlSource   = "TmpTrf.Numes"
2290:             .Column2.Width           = 55
2291:             .RecordMark   = .F.
2292:             .DeleteMark   = .F.
2293:         ENDWITH
2294: 
2295:         loc_oCnt.AddObject("cmd_4c_RemoverTrf", "CommandButton")
2296:         WITH loc_oCnt.cmd_4c_RemoverTrf
2297:             .Caption         = ""
2298:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2299:             .PicturePosition = 4
2300:             .Top             = 297
2301:             .Left            = 165
2302:             .Width           = 40
2303:             .Height          = 40

*-- Linhas 2694 a 2731:
2694:             .ForeColor = RGB(36, 84, 155)
2695:         ENDWITH
2696: 
2697:         loc_oCnt.AddObject("grd_4c_TmpTot", "Grid")
2698:         loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
2699:         WITH loc_oCnt.grd_4c_TmpTot
2700:             .Top                     = 49
2701:             .Left                    = 28
2702:             .Width                   = 354
2703:             .Height                  = 122
2704:             .FontName                = "Tahoma"
2705:             .FontSize                = 8
2706:             .ReadOnly                = .T.
2707:             .GridLines               = 1
2708:             .HeaderHeight            = 17
2709:             .RowHeight               = 17
2710:             .Column1.Header1.Caption = "Tipo " + CHR(193) + "rvore"
2711:             .Column1.Width           = 80
2712:             .Column2.Header1.Caption = "Metal Real"
2713:             .Column2.Width           = 80
2714:             .Column3.Header1.Caption = "Metal Novo"
2715:             .Column3.Width           = 80
2716:             .Column4.Header1.Caption = "Metal Ligado"
2717:             .Column4.Width           = 80
2718:             .RecordMark   = .F.
2719:             .DeleteMark   = .F.
2720:         ENDWITH
2721: 
2722:         loc_oCnt.AddObject("cmd_4c_Retornar", "CommandButton")
2723:         WITH loc_oCnt.cmd_4c_Retornar
2724:             .Caption         = "Retornar"
2725:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_26.jpg"
2726:             .PicturePosition = 13
2727:             .Top             = 11
2728:             .Left            = 415
2729:             .Width           = 75
2730:             .Height          = 75
2731:             .FontName        = "Tahoma"

*-- Linhas 2885 a 2904:
2885:                 "Selecionar Cor", ;
2886:                 .T., .T., "")
2887:             IF VARTYPE(loc_oBusca) = "O"
2888:                 loc_oBusca.mAddColuna("cgrus", "9999", "C" + CHR(243) + "digo")
2889:                 loc_oBusca.mAddColuna("descs", "X(30)", "Descri" + CHR(231) + CHR(227) + "o")
2890:                 loc_oBusca.Show()
2891:                 THIS.ValidarCor()
2892:             ENDIF
2893:         CATCH TO loc_oErro
2894:             MsgErro("Erro em FormFUN.AbrirLookupCor: " + loc_oErro.Message, "Erro")
2895:         ENDTRY
2896:     ENDPROC
2897: 
2898:     *==========================================================================
2899:     PROCEDURE ValidarCor(par_nKeyCode, par_nShiftAltCtrl)
2900:     *==========================================================================
2901:         LOCAL loc_oCnt5, loc_cCodCor, loc_nResultado, loc_lSucesso
2902:         loc_lSucesso = .F.
2903: 
2904:         TRY

*-- Linhas 2982 a 3001:
2982:                 "Selecionar " + CHR(193) + "rvore", ;
2983:                 .T., .T., "")
2984:             IF VARTYPE(loc_oBusca) = "O"
2985:                 loc_oBusca.mAddColuna("codigos", "X(10)", "C" + CHR(243) + "digo")
2986:                 loc_oBusca.mAddColuna("descs",   "X(40)", "Descri" + CHR(231) + CHR(227) + "o")
2987:                 loc_oBusca.Show()
2988:                 THIS.ValidarArvore()
2989:             ENDIF
2990:         CATCH TO loc_oErro
2991:             MsgErro("Erro em FormFUN.AbrirLookupArvore: " + loc_oErro.Message, "Erro")
2992:         ENDTRY
2993:     ENDPROC
2994: 
2995:     *==========================================================================
2996:     PROCEDURE ValidarArvore(par_nKeyCode, par_nShiftAltCtrl)
2997:     *==========================================================================
2998:         LOCAL loc_oPg2, loc_cCodArv, loc_cDescs, loc_lSucesso
2999:         loc_lSucesso = .F.
3000: 
3001:         TRY

*-- Linhas 3089 a 3108:
3089:                 "Selecionar " + CHR(193) + "rvore", ;
3090:                 .T., .T., "")
3091:             IF VARTYPE(loc_oBusca) = "O"
3092:                 loc_oBusca.mAddColuna("codigos", "X(10)", "C" + CHR(243) + "digo")
3093:                 loc_oBusca.mAddColuna("descs",   "X(40)", "Descri" + CHR(231) + CHR(227) + "o")
3094:                 loc_oBusca.Show()
3095:                 THIS.ValidarArvore()
3096:             ENDIF
3097:         CATCH TO loc_oErro
3098:             MsgErro("Erro em FormFUN.AbrirLookupArvoreDesc: " + loc_oErro.Message, "Erro")
3099:         ENDTRY
3100:     ENDPROC
3101: 
3102:     *==========================================================================
3103:     PROCEDURE CalcMetal()
3104:     *==========================================================================
3105:         LOCAL loc_oCnt5, loc_oPg2, loc_cCodArv, loc_cFormula
3106:         LOCAL loc_nBCeras, loc_nBases, loc_nCeras, loc_nPesoMetal, loc_nMetalNovo, loc_nPercs
3107:         LOCAL loc_lSucesso
3108:         loc_lSucesso = .F.

*-- Linhas 3435 a 3454:
3435:                     ENDIF
3436:                 ENDFOR
3437: 
3438:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
3439:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
3440:                 ENDIF
3441:             ENDIF
3442:             loc_lSucesso = .T.
3443:         CATCH TO loc_oErro
3444:             MsgErro("Erro em FormFUN.TuboLostFocus: " + loc_oErro.Message, "Erro")
3445:         ENDTRY
3446: 
3447:         RETURN loc_lSucesso
3448:     ENDPROC
3449: 
3450:     *==========================================================================
3451:     PROCEDURE TrfLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3452:     *==========================================================================
3453:         LOCAL loc_oCnt3, loc_cTrf, loc_nResultado, loc_lSucesso
3454:         LOCAL loc_nTuboAtual, loc_lRep, loc_nNNumes, loc_nT

*-- Linhas 3500 a 3519:
3500:                             ENDFOR
3501:                         ENDIF
3502: 
3503:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5)
3504:                             loc_oCnt3.grd_4c_GradeTrf.Refresh()
3505:                         ENDIF
3506:                     ENDIF
3507:                     loc_oCnt3.txt_4c_Trf.Value = ""
3508:                     loc_lSucesso = .T.
3509:                 ELSE
3510:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o '" + loc_cTrf + ;
3511:                         "' n" + CHR(227) + "o encontrada.", ;
3512:                         "Opera" + CHR(231) + CHR(227) + "o")
3513:                     loc_oCnt3.txt_4c_Trf.Value = ""
3514:                 ENDIF
3515: 
3516:                 IF USED("cursor_4c_BuscaTrf")
3517:                     USE IN cursor_4c_BuscaTrf
3518:                 ENDIF
3519:             ENDIF

*-- Linhas 3581 a 3600:
3581:                                         loc_dDtEnt)
3582:                         ENDIF
3583: 
3584:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_Gradenop", 5)
3585:                             loc_oCnt3.grd_4c_Gradenop.Refresh()
3586:                         ENDIF
3587:                     ENDIF
3588: 
3589:                     loc_oCnt3.txt_4c_Nop.Value  = 0
3590:                     loc_oCnt3.txt_4c_QtTb.Value = 0
3591:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3592:                         loc_oCnt3.txt_4c_Qtd.Value = 0
3593:                     ENDIF
3594:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3595:                         loc_oCnt3.txt_4c_Pecas.Value = 0
3596:                     ENDIF
3597:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3598:                         loc_oCnt3.txt_4c_Operacao.Value = ""
3599:                     ENDIF
3600: 

*-- Linhas 3627 a 3653:
3627:             loc_oCnt3     = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3628:             loc_nTuboAtual = THIS.this_nTuboAtual
3629: 
3630:             IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5) AND USED("TmpTrf")
3631:                 SELECT TmpTrf
3632:                 IF !EOF("TmpTrf") AND TmpTrf.Tubos = loc_nTuboAtual
3633:                     DELETE
3634:                     SET FILTER TO
3635:                     PACK NOOPTIMIZE
3636:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
3637:                     GO TOP
3638:                     loc_oCnt3.grd_4c_GradeTrf.Refresh()
3639:                 ENDIF
3640:             ENDIF
3641:             loc_lSucesso = .T.
3642:         CATCH TO loc_oErro
3643:             MsgErro("Erro em FormFUN.RemoverTrfClick: " + loc_oErro.Message, "Erro")
3644:         ENDTRY
3645: 
3646:         RETURN loc_lSucesso
3647:     ENDPROC
3648: 
3649:     *==========================================================================
3650:     PROCEDURE GradenopAfterRowColChange(par_nColIndex)
3651:     *==========================================================================
3652:         LPARAMETERS par_nColIndex
3653:         LOCAL loc_oCnt3, loc_lSucesso

*-- Linhas 3692 a 3727:
3692:                 GROUP BY TmpCera.CodArvs, TmpCera.Descs ;
3693:                 INTO CURSOR cursor_4c_TmpTot NOFILTER
3694:             ELSE
3695:                 CREATE CURSOR cursor_4c_TmpTot ( ;
3696:                     CodArvs        C(10), ;
3697:                     Descs          C(40), ;
3698:                     PesoRealTotal  N(12,2), ;
3699:                     MetalNovoTotal N(12,2), ;
3700:                     PesoMetalTotal N(12,2) ;
3701:                 )
3702:             ENDIF
3703: 
3704:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Total
3705:             IF PEMSTATUS(loc_oCnt, "grd_4c_TmpTot", 5)
3706:                 loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
3707:                 loc_oCnt.grd_4c_TmpTot.RecordSource            = "cursor_4c_TmpTot"
3708:                 loc_oCnt.grd_4c_TmpTot.Column1.ControlSource   = "cursor_4c_TmpTot.CodArvs"
3709:                 loc_oCnt.grd_4c_TmpTot.Column2.ControlSource   = "cursor_4c_TmpTot.PesoRealTotal"
3710:                 loc_oCnt.grd_4c_TmpTot.Column3.ControlSource   = "cursor_4c_TmpTot.MetalNovoTotal"
3711:                 loc_oCnt.grd_4c_TmpTot.Column4.ControlSource   = "cursor_4c_TmpTot.PesoMetalTotal"
3712:                 loc_oCnt.grd_4c_TmpTot.Refresh()
3713:             ENDIF
3714: 
3715:             loc_oCnt.Visible = .T.
3716:             loc_oCnt.ZOrder(0)
3717:             loc_lSucesso = .T.
3718:         CATCH TO loc_oErro
3719:             MsgErro("Erro em FormFUN.BtnTotalClick: " + loc_oErro.Message, "Erro")
3720:         ENDTRY
3721: 
3722:         RETURN loc_lSucesso
3723:     ENDPROC
3724: 
3725:     *==========================================================================
3726:     PROCEDURE BtnCancelarTotalClick()
3727:     *==========================================================================

