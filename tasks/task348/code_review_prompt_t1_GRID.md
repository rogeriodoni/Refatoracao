# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-HEADERS] Metodo CarregarGrades redefine RecordSource mas NAO redefine Header1.Caption. Headers ficam com nomes de campo (ex: 'Contas') ao inves de titulos legiveis (ex: 'Conta'). OBRIGATORIO redefinir TODOS os Header1.Caption APOS RecordSource.
- [GRID-HEADERS] Metodo CarregarGradeLeitura redefine RecordSource mas NAO redefine Header1.Caption. Headers ficam com nomes de campo (ex: 'Contas') ao inves de titulos legiveis (ex: 'Conta'). OBRIGATORIO redefinir TODOS os Header1.Caption APOS RecordSource.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBAL.prg) - TRECHOS RELEVANTES PARA PASS GRID (4773 linhas total):

*-- Linhas 452 a 475:
452:         BINDEVENT(loc_oPg1.cmd_4c_Usuario, "Click", THIS, "BtnOrdenarUsuarioClick")
453: 
454:         *-- Grid listagem (Top=175, Left=12, Width=905, Height=390)
455:         *-- RecordSource e ColumnCount FORA do WITH (VFP9: colunas criadas em Columns())
456:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
457:         loc_oPg1.grd_4c_Lista.RecordSource = ""
458:         loc_oPg1.grd_4c_Lista.ColumnCount  = 8
459: 
460:         WITH loc_oPg1.grd_4c_Lista
461:             .Top                = 175
462:             .Left               = 12
463:             .Width              = 905
464:             .Height             = 390
465:             .FontName           = "Verdana"
466:             .FontSize           = 8
467:             .ForeColor          = RGB(90, 90, 90)
468:             .BackColor          = RGB(255, 255, 255)
469:             .GridLineColor      = RGB(238, 238, 238)
470:             .HighlightBackColor = RGB(255, 255, 255)
471:             .HighlightForeColor = RGB(15, 41, 104)
472:             .HighlightStyle     = 2
473:             .DeleteMark         = .F.
474:             .RecordMark         = .F.
475:             .RowHeight          = 16

*-- Linhas 493 a 518:
493:             .Column6.ReadOnly   = .T.
494:             .Column7.ReadOnly   = .T.
495:             .Column8.ReadOnly   = .T.
496:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
497:             .Column2.Header1.Caption = "Data Base"
498:             .Column3.Header1.Caption = "Data Inicial"
499:             .Column4.Header1.Caption = "Data Final"
500:             .Column5.Header1.Caption = "Encerrado"
501:             .Column6.Header1.Caption = "Grupo Est."
502:             .Column7.Header1.Caption = "Conta Est."
503:             .Column8.Header1.Caption = "Usu" + CHR(225) + "rio"
504:         ENDWITH
505: 
506:         THIS.TornarControlesVisiveis(loc_oPg1)
507:     ENDPROC
508: 
509:     *--------------------------------------------------------------------------
510:     * ConfigurarPaginaDados - Cria Page2: parametros de filtro do inventario
511:     *--------------------------------------------------------------------------
512:     PROTECTED PROCEDURE ConfigurarPaginaDados()
513:         LOCAL loc_oPg2, loc_oGrdGGrupo, loc_oGrdGrupo
514: 
515:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
516: 
517:         *-- Container botoes Confirmar/Cancelar (Top=29, Left=842)
518:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")

*-- Linhas 1710 a 1732:
1710:         ENDWITH
1711: 
1712:         *-- grdGGrupo (Top=186, Left=683, Width=238, Height=147)
1713:         loc_oPg2.AddObject("grd_4c_GGrupo", "Grid")
1714:         loc_oPg2.grd_4c_GGrupo.RecordSource = ""
1715:         loc_oPg2.grd_4c_GGrupo.ColumnCount  = 3
1716: 
1717:         loc_oGrdGGrupo = loc_oPg2.grd_4c_GGrupo
1718:         WITH loc_oGrdGGrupo
1719:             .Top                = 186
1720:             .Left               = 683
1721:             .Width              = 238
1722:             .Height             = 147
1723:             .FontName           = "Tahoma"
1724:             .FontSize           = 8
1725:             .ForeColor          = RGB(90, 90, 90)
1726:             .BackColor          = RGB(255, 255, 255)
1727:             .GridLineColor      = RGB(200, 200, 200)
1728:             .HighlightStyle     = 2
1729:             .DeleteMark         = .F.
1730:             .RecordMark         = .F.
1731:             .RowHeight          = 17
1732:             .ScrollBars         = 3

*-- Linhas 1739 a 1759:
1739:             .Column1.Sparse     = .F.
1740:             .Column2.ReadOnly   = .T.
1741:             .Column3.ReadOnly   = .T.
1742:             .Column1.Header1.Caption = ""
1743:             .Column2.Header1.Caption = "Cod."
1744:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1745:         ENDWITH
1746: 
1747:         *-- CheckBox em Column1 do grdGGrupo com propriedades explicitas
1748:         loc_oGrdGGrupo.Column1.AddObject("chk_4c_Check1", "CheckBox")
1749:         WITH loc_oGrdGGrupo.Column1.chk_4c_Check1
1750:             .Caption   = ""
1751:             .Alignment = 0
1752:             .ReadOnly  = .F.
1753:             .Visible   = .T.
1754:             .Top       = 9
1755:             .Left      = 2
1756:             .Height    = 17
1757:             .Width     = 22
1758:         ENDWITH
1759: 

*-- Linhas 1813 a 1835:
1813:         ENDWITH
1814: 
1815:         *-- grdgrupo (Top=359, Left=683, Width=238, Height=147)
1816:         loc_oPg2.AddObject("grd_4c_Grupos", "Grid")
1817:         loc_oPg2.grd_4c_Grupos.RecordSource = ""
1818:         loc_oPg2.grd_4c_Grupos.ColumnCount  = 3
1819: 
1820:         loc_oGrdGrupo = loc_oPg2.grd_4c_Grupos
1821:         WITH loc_oGrdGrupo
1822:             .Top                = 359
1823:             .Left               = 683
1824:             .Width              = 238
1825:             .Height             = 147
1826:             .FontName           = "Tahoma"
1827:             .FontSize           = 8
1828:             .ForeColor          = RGB(90, 90, 90)
1829:             .BackColor          = RGB(255, 255, 255)
1830:             .GridLineColor      = RGB(200, 200, 200)
1831:             .HighlightStyle     = 2
1832:             .DeleteMark         = .F.
1833:             .RecordMark         = .F.
1834:             .RowHeight          = 17
1835:             .ScrollBars         = 3

*-- Linhas 1842 a 1862:
1842:             .Column1.Sparse     = .F.
1843:             .Column2.ReadOnly   = .T.
1844:             .Column3.ReadOnly   = .T.
1845:             .Column1.Header1.Caption = ""
1846:             .Column2.Header1.Caption = "Cod."
1847:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1848:         ENDWITH
1849: 
1850:         *-- CheckBox em Column1 do grdgrupo com propriedades explicitas
1851:         loc_oGrdGrupo.Column1.AddObject("chk_4c_check12", "CheckBox")
1852:         WITH loc_oGrdGrupo.Column1.chk_4c_check12
1853:             .Caption   = ""
1854:             .Alignment = 0
1855:             .ReadOnly  = .F.
1856:             .Visible   = .T.
1857:             .Top       = 9
1858:             .Left      = 2
1859:             .Height    = 17
1860:             .Width     = 22
1861:         ENDWITH
1862: 

*-- Linhas 2271 a 2293:
2271:         ENDWITH
2272: 
2273:         *-- GradeLeitura (Top=136, Left=98, Width=641, Height=293)
2274:         loc_oPg3.AddObject("grd_4c_Dados", "Grid")
2275:         loc_oPg3.grd_4c_Dados.RecordSource = ""
2276:         loc_oPg3.grd_4c_Dados.ColumnCount  = 8
2277: 
2278:         loc_oGrd = loc_oPg3.grd_4c_Dados
2279:         WITH loc_oGrd
2280:             .Top                = 136
2281:             .Left               = 98
2282:             .Width              = 641
2283:             .Height             = 293
2284:             .FontName           = "Tahoma"
2285:             .FontSize           = 8
2286:             .ForeColor          = RGB(90, 90, 90)
2287:             .BackColor          = RGB(255, 255, 255)
2288:             .GridLineColor      = RGB(200, 200, 200)
2289:             .HighlightStyle     = 2
2290:             .DeleteMark         = .F.
2291:             .RecordMark         = .F.
2292:             .RowHeight          = 17
2293:             .ScrollBars         = 3

*-- Linhas 2310 a 2335:
2310:             .Column6.ReadOnly   = .T.
2311:             .Column7.ReadOnly   = .T.
2312:             .Column8.ReadOnly   = .T.
2313:             .Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
2314:             .Column2.Header1.Caption = "Produto"
2315:             .Column3.Header1.Caption = "Qtd(1)"
2316:             .Column4.Header1.Caption = "Local"
2317:             .Column5.Header1.Caption = "Cor"
2318:             .Column6.Header1.Caption = "Tam"
2319:             .Column7.Header1.Caption = "Qtd(2)"
2320:             .Column8.Header1.Caption = "Barra"
2321:         ENDWITH
2322: 
2323:         *-- ShpFigura (area imagem): Top=139, Left=744, Width=247, Height=224
2324:         loc_oPg3.AddObject("shp_4c_ShpFigura", "Shape")
2325:         WITH loc_oPg3.shp_4c_ShpFigura
2326:             .Top         = 139
2327:             .Left        = 744
2328:             .Width       = 247
2329:             .Height      = 224
2330:             .BorderColor = RGB(150, 150, 150)
2331:             .BorderStyle = 1
2332:             .FillColor   = RGB(200, 200, 200)
2333:             .Visible     = .T.
2334:         ENDWITH
2335: 

*-- Linhas 2950 a 2974:
2950:                 loc_lResultado = .T.
2951:             ENDIF
2952: 
2953:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2954: 
2955:             IF !THIS.this_oBusinessObject.Buscar("")
2956:                 loc_lResultado = .F.
2957:             ELSE
2958:                 loc_oGrid.ColumnCount = 8
2959:                 loc_oGrid.RecordSource              = "cursor_4c_Dados"
2960:                 loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.codigos"
2961:                 loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.dtbases"
2962:                 loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.datainis"
2963:                 loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.datafims"
2964:                 loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.encerras"
2965:                 loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.grupos"
2966:                 loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.contas"
2967:                 loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.usuars"
2968:                 loc_oGrid.Refresh()
2969:                 loc_lResultado = .T.
2970:             ENDIF
2971:         CATCH TO loc_oErro
2972:             MsgErro(loc_oErro.Message, "FormBAL.CarregarLista")
2973:         ENDTRY
2974: 

*-- Linhas 3138 a 3223:
3138:     ENDPROC
3139: 
3140:     *--------------------------------------------------------------------------
3141:     * CarregarGrades - Carrega grdGGrupo (Grandes Grupos) e grd_4c_Grupos
3142:     *--------------------------------------------------------------------------
3143:     PROCEDURE CarregarGrades()
3144:         LOCAL loc_cSQL, loc_nRes, loc_cMfilggrp, loc_cMfilgrupo
3145:         loc_cMfilggrp  = ALLTRIM(THIS.this_oBusinessObject.this_cMfilggrp)
3146:         loc_cMfilgrupo = ALLTRIM(THIS.this_oBusinessObject.this_cMfilgrupo)
3147: 
3148:         TRY
3149:             *-- Carregar Grandes Grupos (SigCdGpr)
3150:             IF USED("cursor_4c_GGrupos")
3151:                 USE IN cursor_4c_GGrupos
3152:             ENDIF
3153: 
3154:             loc_cSQL = "SELECT 0 AS nMarcas, codigos AS GGrupos, descs AS Descricaos" + ;
3155:                        " FROM SigCdGpr ORDER BY codigos"
3156:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GGrupos")
3157: 
3158:             IF loc_nRes >= 0
3159:                 *-- Restaurar marcacoes salvas (formato: "cod1,cod2,cod3")
3160:                 IF !EMPTY(loc_cMfilggrp)
3161:                     SELECT cursor_4c_GGrupos
3162:                     SCAN
3163:                         IF "," + ALLTRIM(cursor_4c_GGrupos.GGrupos) + "," $ "," + loc_cMfilggrp + ","
3164:                             REPLACE nMarcas WITH 1 IN cursor_4c_GGrupos
3165:                         ENDIF
3166:                         SELECT cursor_4c_GGrupos
3167:                     ENDSCAN
3168:                 ENDIF
3169: 
3170:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.ColumnCount = 3
3171:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.RecordSource              = "cursor_4c_GGrupos"
3172:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column1.ControlSource     = "cursor_4c_GGrupos.nMarcas"
3173:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column2.ControlSource     = "cursor_4c_GGrupos.GGrupos"
3174:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column3.ControlSource     = "cursor_4c_GGrupos.Descricaos"
3175:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3176:             ENDIF
3177: 
3178:             *-- Carregar Grupos Produto (SigCdGrp)
3179:             IF USED("cursor_4c_GruposProd")
3180:                 USE IN cursor_4c_GruposProd
3181:             ENDIF
3182: 
3183:             loc_cSQL = "SELECT 0 AS nMarcas, cgrus AS Codigos, descs AS Descricaos" + ;
3184:                        " FROM SigCdGrp ORDER BY cgrus"
3185:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposProd")
3186: 
3187:             IF loc_nRes >= 0
3188:                 *-- Restaurar marcacoes salvas
3189:                 IF !EMPTY(loc_cMfilgrupo)
3190:                     SELECT cursor_4c_GruposProd
3191:                     SCAN
3192:                         IF "," + ALLTRIM(cursor_4c_GruposProd.Codigos) + "," $ "," + loc_cMfilgrupo + ","
3193:                             REPLACE nMarcas WITH 1 IN cursor_4c_GruposProd
3194:                         ENDIF
3195:                         SELECT cursor_4c_GruposProd
3196:                     ENDSCAN
3197:                 ENDIF
3198: 
3199:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.ColumnCount = 3
3200:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.RecordSource              = "cursor_4c_GruposProd"
3201:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column1.ControlSource     = "cursor_4c_GruposProd.nMarcas"
3202:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column2.ControlSource     = "cursor_4c_GruposProd.Codigos"
3203:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column3.ControlSource     = "cursor_4c_GruposProd.Descricaos"
3204:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3205:             ENDIF
3206:         CATCH TO loc_oErro
3207:             MsgErro(loc_oErro.Message, "FormBAL.CarregarGrades")
3208:         ENDTRY
3209:     ENDPROC
3210: 
3211:     *--------------------------------------------------------------------------
3212:     * ObterMfilGGrupo - Gera string CSV de grandes grupos marcados
3213:     *--------------------------------------------------------------------------
3214:     PROTECTED PROCEDURE ObterMfilGGrupo()
3215:         LOCAL loc_cLista
3216:         loc_cLista = ""
3217: 
3218:         TRY
3219:             IF USED("cursor_4c_GGrupos")
3220:                 SELECT cursor_4c_GGrupos
3221:                 SCAN
3222:                     IF cursor_4c_GGrupos.nMarcas = 1
3223:                         loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GGrupos.GGrupos)

*-- Linhas 3257 a 3342:
3257:     ENDPROC
3258: 
3259:     *--------------------------------------------------------------------------
3260:     * CarregarGradeLeitura - Carrega historico de leituras do inventario
3261:     *--------------------------------------------------------------------------
3262:     PROCEDURE CarregarGradeLeitura()
3263:         LOCAL loc_cSQL, loc_nRes, loc_nCodigos, loc_cEmps, loc_oGrd
3264:         loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
3265:         loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
3266:         loc_oGrd     = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3267: 
3268:         TRY
3269:             IF USED("cursor_4c_Historico")
3270:                 USE IN cursor_4c_Historico
3271:             ENDIF
3272: 
3273:             loc_cSQL = "SELECT a.cbars, a.cpros, a.lidos AS Qtds, a.localis, a.codcors," + ;
3274:                        " a.codtams, a.lidos2 AS Qtds2, ISNULL(b.cbars_old, 0) AS BarsOld" + ;
3275:                        " FROM SigIvTrH a" + ;
3276:                        " LEFT JOIN SigOpEta b ON a.cbars = b.cbars_new" + ;
3277:                        " WHERE a.emps = " + EscaparSQL(loc_cEmps) + ;
3278:                        " AND a.codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
3279:                        " ORDER BY a.cidchaves"
3280: 
3281:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Historico")
3282: 
3283:             IF loc_nRes >= 0
3284:                 loc_oGrd.ColumnCount = 8
3285:                 loc_oGrd.RecordSource          = "cursor_4c_Historico"
3286:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Historico.cbars"
3287:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Historico.cpros"
3288:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Historico.Qtds"
3289:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Historico.localis"
3290:                 loc_oGrd.Column5.ControlSource = "cursor_4c_Historico.codcors"
3291:                 loc_oGrd.Column6.ControlSource = "cursor_4c_Historico.codtams"
3292:                 loc_oGrd.Column7.ControlSource = "cursor_4c_Historico.Qtds2"
3293:                 loc_oGrd.Column8.ControlSource = "cursor_4c_Historico.BarsOld"
3294:                 loc_oGrd.Refresh()
3295: 
3296:                 THIS.AtualizarTotalLeitura()
3297:             ELSE
3298:                 MsgErro("Erro ao carregar leituras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3299:             ENDIF
3300:         CATCH TO loc_oErro
3301:             MsgErro(loc_oErro.Message, "FormBAL.CarregarGradeLeitura")
3302:         ENDTRY
3303:     ENDPROC
3304: 
3305:     *--------------------------------------------------------------------------
3306:     * AtualizarTotalLeitura - Atualiza contadores de lidos e quantidade
3307:     *--------------------------------------------------------------------------
3308:     PROCEDURE AtualizarTotalLeitura()
3309:         LOCAL loc_nLidos, loc_nQtde, loc_cSQL, loc_nRes
3310: 
3311:         TRY
3312:             IF USED("cursor_4c_Historico")
3313:                 SELECT COUNT(*) AS Lidos, SUM(Qtds) AS Qtde FROM cursor_4c_Historico ;
3314:                     INTO CURSOR cursor_4c_Totais READWRITE
3315: 
3316:                 IF USED("cursor_4c_Totais")
3317:                     SELECT cursor_4c_Totais
3318:                     loc_nLidos = IIF(ISNULL(cursor_4c_Totais.Lidos), 0, cursor_4c_Totais.Lidos)
3319:                     loc_nQtde  = IIF(ISNULL(cursor_4c_Totais.Qtde),  0, cursor_4c_Totais.Qtde)
3320:                     USE IN cursor_4c_Totais
3321:                 ENDIF
3322: 
3323:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Lidos.Value = loc_nLidos
3324:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Qtde.Value  = loc_nQtde
3325:             ENDIF
3326:         CATCH TO loc_oErro
3327:             MsgErro(loc_oErro.Message, "FormBAL.AtualizarTotalLeitura")
3328:         ENDTRY
3329:     ENDPROC
3330: 
3331:     *--------------------------------------------------------------------------
3332:     * InicializarLeitura - Configura Page3 para o inventario selecionado
3333:     *--------------------------------------------------------------------------
3334:     PROTECTED PROCEDURE InicializarLeitura()
3335:         LOCAL loc_oPg3, loc_oBO
3336:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
3337:         loc_oBO  = THIS.this_oBusinessObject
3338: 
3339:         TRY
3340:             loc_oPg3.txt_4c_Codigo.Value = loc_oBO.this_nCodigos
3341:             loc_oPg3.txt_4c_Grupo.Value  = ALLTRIM(loc_oBO.this_cGrupos)
3342:             loc_oPg3.txt_4c_Conta.Value  = ALLTRIM(loc_oBO.this_cContas)

*-- Linhas 3432 a 3451:
3432:             loc_oPg2.txt_4c__UniFim.ReadOnly        = !par_lHabilitar
3433:             loc_oPg2.txt_4c_ObsPes.ReadOnly         = !par_lHabilitar
3434:             loc_oPg2.obj_4c_GetObs.ReadOnly         = !par_lHabilitar
3435:             loc_oPg2.grd_4c_GGrupo.ReadOnly         = !par_lHabilitar
3436:             loc_oPg2.grd_4c_Grupos.ReadOnly         = !par_lHabilitar
3437:         CATCH TO loc_oErro
3438:             MsgErro(loc_oErro.Message, "FormBAL.HabilitarCamposDados")
3439:         ENDTRY
3440:     ENDPROC
3441: 
3442:     *--------------------------------------------------------------------------
3443:     * LimparCamposDados - Limpa campos da Page2
3444:     *--------------------------------------------------------------------------
3445:     PROCEDURE LimparCamposDados()
3446:         LOCAL loc_oPg2
3447:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3448: 
3449:         TRY
3450:             loc_oPg2.txt_4c_Codigo.Value          = 0
3451:             loc_oPg2.txt_4c_DBase.Value           = {}

*-- Linhas 3584 a 3602:
3584:     PROCEDURE BtnConsultaClick()
3585:         TRY
3586:             THIS.CarregarLista()
3587:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3588:         CATCH TO loc_oErro
3589:             MsgErro(loc_oErro.Message, "FormBAL.BtnConsultaClick")
3590:         ENDTRY
3591:     ENDPROC
3592: 
3593:     *--------------------------------------------------------------------------
3594:     * BtnExportaClick - Exporta dados do inventario para Excel
3595:     *--------------------------------------------------------------------------
3596:     PROCEDURE BtnExportaClick()
3597:         LOCAL loc_cCidchaves, loc_cArquivo
3598: 
3599:         TRY
3600:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
3601:             IF EMPTY(loc_cCidchaves)
3602:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para exportar.", "Aten" + CHR(231) + CHR(227) + "o")

*-- Linhas 3653 a 3671:
3653:         TRY
3654:             IF USED("cursor_4c_Dados")
3655:                 SELECT cursor_4c_Dados
3656:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3657:             ENDIF
3658:         CATCH TO loc_oErro
3659:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarPeriodoClick")
3660:         ENDTRY
3661:     ENDPROC
3662: 
3663:     PROCEDURE BtnOrdenarEstoqueClick()
3664:         TRY
3665:             THIS.CarregarLista()
3666:         CATCH TO loc_oErro
3667:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarEstoqueClick")
3668:         ENDTRY
3669:     ENDPROC
3670: 
3671:     PROCEDURE BtnOrdenarLocalClick()

*-- Linhas 3775 a 3838:
3775:             IF USED("cursor_4c_GGrupos")
3776:                 SELECT cursor_4c_GGrupos
3777:                 REPLACE ALL nMarcas WITH 1
3778:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3779:             ENDIF
3780:         CATCH TO loc_oErro
3781:             MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGGrupoClick")
3782:         ENDTRY
3783:     ENDPROC
3784: 
3785:     *--------------------------------------------------------------------------
3786:     * BtnDesmarcarTodosGGrupoClick - Desmarca todos os grandes grupos
3787:     *--------------------------------------------------------------------------
3788:     PROCEDURE BtnDesmarcarTodosGGrupoClick()
3789:         TRY
3790:             IF USED("cursor_4c_GGrupos")
3791:                 SELECT cursor_4c_GGrupos
3792:                 REPLACE ALL nMarcas WITH 0
3793:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3794:             ENDIF
3795:         CATCH TO loc_oErro
3796:             MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGGrupoClick")
3797:         ENDTRY
3798:     ENDPROC
3799: 
3800:     *--------------------------------------------------------------------------
3801:     * BtnSelecionarTodosGrupoClick - Marca todos os grupos de produto
3802:     *--------------------------------------------------------------------------
3803:     PROCEDURE BtnSelecionarTodosGrupoClick()
3804:         TRY
3805:             IF USED("cursor_4c_GruposProd")
3806:                 SELECT cursor_4c_GruposProd
3807:                 REPLACE ALL nMarcas WITH 1
3808:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3809:             ENDIF
3810:         CATCH TO loc_oErro
3811:             MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGrupoClick")
3812:         ENDTRY
3813:     ENDPROC
3814: 
3815:     *--------------------------------------------------------------------------
3816:     * BtnDesmarcarTodosGrupoClick - Desmarca todos os grupos de produto
3817:     *--------------------------------------------------------------------------
3818:     PROCEDURE BtnDesmarcarTodosGrupoClick()
3819:         TRY
3820:             IF USED("cursor_4c_GruposProd")
3821:                 SELECT cursor_4c_GruposProd
3822:                 REPLACE ALL nMarcas WITH 0
3823:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3824:             ENDIF
3825:         CATCH TO loc_oErro
3826:             MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGrupoClick")
3827:         ENDTRY
3828:     ENDPROC
3829: 
3830:     *==========================================================================
3831:     * HANDLERS - Page3 (Leitura)
3832:     *==========================================================================
3833: 
3834:     *--------------------------------------------------------------------------
3835:     * BtnGravarClick - Salva item de leitura em SigIvTrH
3836:     *--------------------------------------------------------------------------
3837:     PROCEDURE BtnGravarClick()
3838:         LOCAL loc_cSQL, loc_nRes, loc_lSucesso

