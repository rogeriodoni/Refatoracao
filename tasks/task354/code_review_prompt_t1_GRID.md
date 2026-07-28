# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-HEADERS] Metodo CarregarGrades redefine RecordSource mas NAO redefine Header1.Caption. Headers ficam com nomes de campo (ex: 'Contas') ao inves de titulos legiveis (ex: 'Conta'). OBRIGATORIO redefinir TODOS os Header1.Caption APOS RecordSource.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCargo.prg) - TRECHOS RELEVANTES PARA PASS GRID (3293 linhas total):

*-- Linhas 332 a 354:
332:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
333: 
334:         *-- Grid lista: ccargs (Cargo) + dcargs (Descricao)
335:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
336:         loc_oPg1.grd_4c_Lista.RecordSource = ""
337:         loc_oPg1.grd_4c_Lista.ColumnCount  = 2
338: 
339:         WITH loc_oPg1.grd_4c_Lista
340:             .Top                     = 117
341:             .Left                    = 12
342:             .Width                   = 890
343:             .Height                  = 480
344:             .FontName                = "Verdana"
345:             .FontSize                = 8
346:             .ForeColor               = RGB(90, 90, 90)
347:             .BackColor               = RGB(255, 255, 255)
348:             .GridLineColor           = RGB(238, 238, 238)
349:             .HighlightBackColor      = RGB(255, 255, 255)
350:             .HighlightForeColor      = RGB(15, 41, 104)
351:             .HighlightStyle          = 2
352:             .DeleteMark              = .F.
353:             .RecordMark              = .F.
354:             .RowHeight               = 16

*-- Linhas 360 a 379:
360:             .Column2.Width           = 760
361:             .Column1.ReadOnly        = .T.
362:             .Column2.ReadOnly        = .T.
363:             .Column1.Header1.Caption = "Cargo"
364:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
365:         ENDWITH
366: 
367:         THIS.TornarControlesVisiveis(loc_oPg1)
368:     ENDPROC
369: 
370:     *--------------------------------------------------------------------------
371:     * ConfigurarPaginaDados - Page2: todos os campos, grids e botoes
372:     *--------------------------------------------------------------------------
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()
374:         LOCAL loc_oPg2, loc_oBotoesAcao, loc_oGridAcesso, loc_oGridCat
375:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
376: 
377:         *-- Botoes Confirmar/Cancelar
378:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
379:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao

*-- Linhas 2021 a 2043:
2021:             .Visible   = .T.
2022:         ENDWITH
2023: 
2024:         loc_oPg2.AddObject("grd_4c_AcessoFinan", "Grid")
2025:         loc_oPg2.grd_4c_AcessoFinan.RecordSource = ""
2026:         loc_oPg2.grd_4c_AcessoFinan.ColumnCount  = 4
2027: 
2028:         loc_oGridAcesso = loc_oPg2.grd_4c_AcessoFinan
2029:         WITH loc_oGridAcesso
2030:             .Top                     = 419
2031:             .Left                    = 66
2032:             .Width                   = 310
2033:             .Height                  = 205
2034:             .FontName                = "Verdana"
2035:             .FontSize                = 8
2036:             .ForeColor               = RGB(90, 90, 90)
2037:             .BackColor               = RGB(255, 255, 255)
2038:             .GridLineColor           = RGB(238, 238, 238)
2039:             .HighlightBackColor      = RGB(255, 255, 255)
2040:             .HighlightForeColor      = RGB(15, 41, 104)
2041:             .HighlightStyle          = 2
2042:             .DeleteMark              = .F.
2043:             .RecordMark              = .F.

*-- Linhas 2050 a 2071:
2050:             .Column2.Width           = 85
2051:             .Column3.Width           = 90
2052:             .Column4.Width           = 55
2053:             .Column1.Header1.Caption = "Grupo"
2054:             .Column2.Header1.Caption = "Conta"
2055:             .Column3.Header1.Caption = "Valor"
2056:             .Column4.Header1.Caption = "Moeda"
2057:         ENDWITH
2058: 
2059:         BINDEVENT(loc_oGridAcesso.Column1.Text1, "KeyPress", THIS, "ValidarGrupoGrade")
2060:         BINDEVENT(loc_oGridAcesso.Column2.Text1, "KeyPress", THIS, "ValidarContaGrade")
2061:         BINDEVENT(loc_oGridAcesso.Column4.Text1, "KeyPress", THIS, "ValidarMoedaGrade")
2062: 
2063:         *-- Botoes Inserir/Excluir linhas da grade de acesso
2064:         loc_oPg2.AddObject("cmd_4c_InserirAcesso", "CommandButton")
2065:         WITH loc_oPg2.cmd_4c_InserirAcesso
2066:             .Caption         = "Inserir"
2067:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2068:             .PicturePosition = 13
2069:             .Top             = 482
2070:             .Left            = 380
2071:             .Width           = 45

*-- Linhas 2127 a 2149:
2127:             .Visible   = .T.
2128:         ENDWITH
2129: 
2130:         loc_oPg2.AddObject("grd_4c_Categorias", "Grid")
2131:         loc_oPg2.grd_4c_Categorias.RecordSource = ""
2132:         loc_oPg2.grd_4c_Categorias.ColumnCount  = 3
2133: 
2134:         loc_oGridCat = loc_oPg2.grd_4c_Categorias
2135:         WITH loc_oGridCat
2136:             .Top                     = 419
2137:             .Left                    = 509
2138:             .Width                   = 310
2139:             .Height                  = 205
2140:             .FontName                = "Verdana"
2141:             .FontSize                = 8
2142:             .ForeColor               = RGB(90, 90, 90)
2143:             .BackColor               = RGB(255, 255, 255)
2144:             .GridLineColor           = RGB(238, 238, 238)
2145:             .HighlightBackColor      = RGB(255, 255, 255)
2146:             .HighlightForeColor      = RGB(15, 41, 104)
2147:             .HighlightStyle          = 2
2148:             .DeleteMark              = .F.
2149:             .RecordMark              = .F.

*-- Linhas 2155 a 2175:
2155:             .Column1.Width           = 60
2156:             .Column2.Width           = 170
2157:             .Column3.Width           = 75
2158:             .Column1.Header1.Caption = "Categoria"
2159:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2160:             .Column3.Header1.Caption = "Tipo"
2161:             .Column2.ReadOnly        = .T.
2162:         ENDWITH
2163: 
2164:         BINDEVENT(loc_oGridCat.Column1.Text1, "KeyPress", THIS, "ValidarCategoriaGrade")
2165:         BINDEVENT(loc_oGridCat.Column3.Text1, "KeyPress", THIS, "ValidarTipoCategoria")
2166: 
2167:         *-- Botoes Inserir/Excluir linhas da grade de categorias
2168:         loc_oPg2.AddObject("cmd_4c_InserirCat", "CommandButton")
2169:         WITH loc_oPg2.cmd_4c_InserirCat
2170:             .Caption         = "Inserir"
2171:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2172:             .PicturePosition = 13
2173:             .Top             = 482
2174:             .Left            = 823
2175:             .Width           = 45

*-- Linhas 2224 a 2343:
2224: 
2225:         TRY
2226:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2227:                 CREATE CURSOR cursor_4c_Dados (ccargs C(10), dcargs C(20))
2228:                 loc_lResultado = .T.
2229:             ELSE
2230:                 IF THIS.this_oBusinessObject.Buscar("")
2231:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2232:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2233: 
2234:                         loc_oGrid.ColumnCount  = 2
2235:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2236:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ccargs"
2237:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dcargs"
2238: 
2239:                         loc_oGrid.Column1.Width = 100
2240:                         loc_oGrid.Column2.Width = 760
2241: 
2242:                         loc_oGrid.Column1.ReadOnly = .T.
2243:                         loc_oGrid.Column2.ReadOnly = .T.
2244: 
2245:                         loc_oGrid.Column1.Header1.Caption = "Cargo"
2246:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2247: 
2248:                         THIS.FormatarGridLista(loc_oGrid)
2249:                     ENDIF
2250:                     loc_lResultado = .T.
2251:                 ENDIF
2252:             ENDIF
2253:         CATCH TO loc_oErro
2254:             MsgErro(loc_oErro.Message, "FormCargo.CarregarLista")
2255:         ENDTRY
2256: 
2257:         RETURN loc_lResultado
2258:     ENDPROC
2259: 
2260:     *--------------------------------------------------------------------------
2261:     * CarregarGrades - Conecta cursores das sub-tabelas aos grids de Page2
2262:     *--------------------------------------------------------------------------
2263:     PROCEDURE CarregarGrades()
2264:         LOCAL loc_oPg2, loc_oGridAcesso, loc_oGridCat
2265:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2266: 
2267:         TRY
2268:             *-- Grid acesso financeiro
2269:             IF PEMSTATUS(loc_oPg2, "grd_4c_AcessoFinan", 5)
2270:                 loc_oGridAcesso = loc_oPg2.grd_4c_AcessoFinan
2271:                 IF USED("cursor_4c_AcessoFinan")
2272:                     loc_oGridAcesso.ColumnCount = 4
2273:                     loc_oGridAcesso.RecordSource = "cursor_4c_AcessoFinan"
2274:                     loc_oGridAcesso.Column1.ControlSource = "cursor_4c_AcessoFinan.grupos"
2275:                     loc_oGridAcesso.Column2.ControlSource = "cursor_4c_AcessoFinan.contas"
2276:                     loc_oGridAcesso.Column3.ControlSource = "cursor_4c_AcessoFinan.valors"
2277:                     loc_oGridAcesso.Column4.ControlSource = "cursor_4c_AcessoFinan.moedas"
2278:                     loc_oGridAcesso.Refresh
2279:                 ENDIF
2280:             ENDIF
2281: 
2282:             *-- Grid categorias
2283:             IF PEMSTATUS(loc_oPg2, "grd_4c_Categorias", 5)
2284:                 loc_oGridCat = loc_oPg2.grd_4c_Categorias
2285:                 IF USED("cursor_4c_Categorias")
2286:                     loc_oGridCat.ColumnCount = 3
2287:                     loc_oGridCat.RecordSource = "cursor_4c_Categorias"
2288:                     loc_oGridCat.Column1.ControlSource = "cursor_4c_Categorias.categoria"
2289:                     loc_oGridCat.Column2.ControlSource = "cursor_4c_Categorias.descs"
2290:                     loc_oGridCat.Column3.ControlSource = "cursor_4c_Categorias.tipo"
2291:                     loc_oGridCat.Refresh
2292:                 ENDIF
2293:             ENDIF
2294:         CATCH TO loc_oErro
2295:             MsgErro(loc_oErro.Message, "FormCargo.CarregarGrades")
2296:         ENDTRY
2297:     ENDPROC
2298: 
2299:     *--------------------------------------------------------------------------
2300:     * AlternarPagina - Alterna entre Lista (1) e Dados (2)
2301:     *--------------------------------------------------------------------------
2302:     PROCEDURE AlternarPagina(par_nPagina)
2303:         LOCAL loc_lResultado
2304:         loc_lResultado = .F.
2305: 
2306:         TRY
2307:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
2308:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2309:                 IF par_nPagina = 1
2310:                     THIS.CarregarLista()
2311:                 ENDIF
2312:                 loc_lResultado = .T.
2313:             ENDIF
2314:         CATCH TO loc_oErro
2315:             MsgErro(loc_oErro.Message, "FormCargo.AlternarPagina")
2316:         ENDTRY
2317: 
2318:         RETURN loc_lResultado
2319:     ENDPROC
2320: 
2321:     *--------------------------------------------------------------------------
2322:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
2323:     *--------------------------------------------------------------------------
2324:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2325:         LOCAL loc_nI, loc_oObjeto, loc_nP
2326: 
2327:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2328:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2329: 
2330:             IF VARTYPE(loc_oObjeto) = "O"
2331:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2332:                     loc_oObjeto.Visible = .T.
2333:                 ENDIF
2334: 
2335:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2336:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2337:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2338:                     ENDFOR
2339:                 ENDIF
2340: 
2341:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2342:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2343:                 ENDIF

*-- Linhas 2607 a 2626:
2607: 
2608:             IF VARTYPE(loc_oBusca) = "O"
2609:                 IF !loc_oBusca.this_lAchouRegistro
2610:                     loc_oBusca.mAddColuna("ccargs", "", "Cargo")
2611:                     loc_oBusca.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
2612:                     loc_oBusca.Show()
2613:                 ENDIF
2614: 
2615:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCargoBase")
2616:                     SELECT cursor_4c_BuscaCargoBase
2617:                     loc_cCargoSelecionado = ALLTRIM(cursor_4c_BuscaCargoBase.ccargs)
2618: 
2619:                     IF !EMPTY(loc_cCargoSelecionado)
2620:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCargoSelecionado)
2621:                             THIS.BOParaForm()
2622:                             *-- Limpa o codigo para o usuario digitar o novo
2623:                             loc_oPg2.txt_4c_Ccargs.Value = ""
2624:                             THIS.CarregarGrades()
2625:                         ENDIF
2626:                     ENDIF

*-- Linhas 2651 a 2670:
2651:         TRY
2652:             SELECT cursor_4c_AcessoFinan
2653:             APPEND BLANK
2654:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Refresh
2655:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Column1.SetFocus
2656:         CATCH TO loc_oErro
2657:             MsgErro(loc_oErro.Message, "FormCargo.BtnInserirAcessoClick")
2658:         ENDTRY
2659:     ENDPROC
2660: 
2661:     *--------------------------------------------------------------------------
2662:     * BtnExcluirAcessoClick - Remove linha da grade de acesso financeiro
2663:     *--------------------------------------------------------------------------
2664:     PROCEDURE BtnExcluirAcessoClick()
2665:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2666:             RETURN
2667:         ENDIF
2668:         IF !USED("cursor_4c_AcessoFinan")
2669:             RETURN
2670:         ENDIF

*-- Linhas 2677 a 2716:
2677:         TRY
2678:             DELETE
2679:             PACK
2680:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Refresh
2681:         CATCH TO loc_oErro
2682:             MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirAcessoClick")
2683:         ENDTRY
2684:     ENDPROC
2685: 
2686:     *--------------------------------------------------------------------------
2687:     * BtnInserirCatClick - Adiciona linha na grade de categorias
2688:     *--------------------------------------------------------------------------
2689:     PROCEDURE BtnInserirCatClick()
2690:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2691:             RETURN
2692:         ENDIF
2693:         IF !USED("cursor_4c_Categorias")
2694:             RETURN
2695:         ENDIF
2696: 
2697:         TRY
2698:             SELECT cursor_4c_Categorias
2699:             APPEND BLANK
2700:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Refresh
2701:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Column1.SetFocus
2702:         CATCH TO loc_oErro
2703:             MsgErro(loc_oErro.Message, "FormCargo.BtnInserirCatClick")
2704:         ENDTRY
2705:     ENDPROC
2706: 
2707:     *--------------------------------------------------------------------------
2708:     * BtnExcluirCatClick - Remove linha da grade de categorias
2709:     *--------------------------------------------------------------------------
2710:     PROCEDURE BtnExcluirCatClick()
2711:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2712:             RETURN
2713:         ENDIF
2714:         IF !USED("cursor_4c_Categorias")
2715:             RETURN
2716:         ENDIF

*-- Linhas 2723 a 2741:
2723:         TRY
2724:             DELETE
2725:             PACK
2726:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Refresh
2727:         CATCH TO loc_oErro
2728:             MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirCatClick")
2729:         ENDTRY
2730:     ENDPROC
2731: 
2732:     *--------------------------------------------------------------------------
2733:     * FormParaBO - Transfere valores do form para o BO
2734:     *--------------------------------------------------------------------------
2735:     PROTECTED PROCEDURE FormParaBO()
2736:         LOCAL loc_oPg2, loc_lResultado
2737:         loc_lResultado = .F.
2738: 
2739:         TRY
2740:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2741: 

*-- Linhas 2932 a 2954:
2932:             loc_oPg2.opt_4c_Tpcomis.Enabled    = par_lHabilitar
2933: 
2934:             *-- Sub-grids: ReadOnly nos modos nao-edicao
2935:             IF PEMSTATUS(loc_oPg2, "grd_4c_AcessoFinan", 5)
2936:                 loc_oPg2.grd_4c_AcessoFinan.ReadOnly = !par_lHabilitar
2937:             ENDIF
2938:             IF PEMSTATUS(loc_oPg2, "grd_4c_Categorias", 5)
2939:                 loc_oPg2.grd_4c_Categorias.ReadOnly = !par_lHabilitar
2940:             ENDIF
2941: 
2942:             *-- Botoes das sub-grades
2943:             IF PEMSTATUS(loc_oPg2, "cmd_4c_InserirAcesso", 5)
2944:                 loc_oPg2.cmd_4c_InserirAcesso.Enabled = par_lHabilitar
2945:             ENDIF
2946:             IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcluirAcesso", 5)
2947:                 loc_oPg2.cmd_4c_ExcluirAcesso.Enabled = par_lHabilitar
2948:             ENDIF
2949:             IF PEMSTATUS(loc_oPg2, "cmd_4c_InserirCat", 5)
2950:                 loc_oPg2.cmd_4c_InserirCat.Enabled = par_lHabilitar
2951:             ENDIF
2952:             IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcluirCat", 5)
2953:                 loc_oPg2.cmd_4c_ExcluirCat.Enabled = par_lHabilitar
2954:             ENDIF

*-- Linhas 2995 a 3014:
2995: 
2996:             IF VARTYPE(loc_oBusca) = "O"
2997:                 IF !loc_oBusca.this_lAchouRegistro
2998:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2999:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3000:                     loc_oBusca.Show()
3001:                 ENDIF
3002: 
3003:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
3004:                     SELECT cursor_4c_BuscaGcr
3005:                     loc_oPg2.txt_4c_Grcomis.Value = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
3006:                 ENDIF
3007: 
3008:                 loc_oBusca.Release()
3009:             ENDIF
3010:         CATCH TO loc_oErro
3011:             MsgErro(loc_oErro.Message, "FormCargo.BuscarGrupoFinan")
3012:         ENDTRY
3013: 
3014:         IF USED("cursor_4c_BuscaGcr")

*-- Linhas 3025 a 3058:
3025:         ENDIF
3026: 
3027:         LOCAL loc_oGrid, loc_cValor, loc_oBusca
3028:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan
3029:         loc_cValor = ALLTRIM(loc_oGrid.Column1.Text1.Value)
3030: 
3031:         IF EMPTY(loc_cValor)
3032:             RETURN
3033:         ENDIF
3034: 
3035:         TRY
3036:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3037:                 "SigCdGcr", "cursor_4c_BuscaGcr2", "Codigos", loc_cValor, ;
3038:                 "Grupo Financeiro")
3039: 
3040:             IF VARTYPE(loc_oBusca) = "O"
3041:                 IF !loc_oBusca.this_lAchouRegistro
3042:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3043:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3044:                     loc_oBusca.Show()
3045:                 ENDIF
3046: 
3047:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
3048:                     SELECT cursor_4c_BuscaGcr2
3049:                     REPLACE grupos WITH ALLTRIM(cursor_4c_BuscaGcr2.Codigos) IN cursor_4c_AcessoFinan
3050:                     loc_oGrid.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
3051:                     loc_oGrid.Refresh
3052:                 ENDIF
3053: 
3054:                 loc_oBusca.Release()
3055:             ENDIF
3056:         CATCH TO loc_oErro
3057:             MsgErro(loc_oErro.Message, "FormCargo.ValidarGrupoGrade")
3058:         ENDTRY

*-- Linhas 3072 a 3106:
3072:         ENDIF
3073: 
3074:         LOCAL loc_oGrid, loc_cValor, loc_cGrupo, loc_oBusca
3075:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan
3076:         loc_cValor = ALLTRIM(loc_oGrid.Column2.Text1.Value)
3077:         loc_cGrupo = ALLTRIM(loc_oGrid.Column1.Text1.Value)
3078: 
3079:         IF EMPTY(loc_cValor)
3080:             RETURN
3081:         ENDIF
3082: 
3083:         TRY
3084:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3085:                 "SigCdGcr", "cursor_4c_BuscaConta", "Codigos", loc_cValor, ;
3086:                 "Conta Financeira")
3087: 
3088:             IF VARTYPE(loc_oBusca) = "O"
3089:                 IF !loc_oBusca.this_lAchouRegistro
3090:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3091:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3092:                     loc_oBusca.Show()
3093:                 ENDIF
3094: 
3095:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
3096:                     SELECT cursor_4c_BuscaConta
3097:                     REPLACE contas WITH ALLTRIM(cursor_4c_BuscaConta.Codigos) IN cursor_4c_AcessoFinan
3098:                     loc_oGrid.Column2.Text1.Value = ALLTRIM(cursor_4c_BuscaConta.Codigos)
3099:                     loc_oGrid.Refresh
3100:                 ENDIF
3101: 
3102:                 loc_oBusca.Release()
3103:             ENDIF
3104:         CATCH TO loc_oErro
3105:             MsgErro(loc_oErro.Message, "FormCargo.ValidarContaGrade")
3106:         ENDTRY

*-- Linhas 3119 a 3152:
3119:         ENDIF
3120: 
3121:         LOCAL loc_oGrid, loc_cValor, loc_oBusca
3122:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan
3123:         loc_cValor = ALLTRIM(loc_oGrid.Column4.Text1.Value)
3124: 
3125:         IF EMPTY(loc_cValor)
3126:             RETURN
3127:         ENDIF
3128: 
3129:         TRY
3130:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3131:                 "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
3132:                 "Moeda")
3133: 
3134:             IF VARTYPE(loc_oBusca) = "O"
3135:                 IF !loc_oBusca.this_lAchouRegistro
3136:                     loc_oBusca.mAddColuna("CMoes", "", "Moeda")
3137:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3138:                     loc_oBusca.Show()
3139:                 ENDIF
3140: 
3141:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
3142:                     SELECT cursor_4c_BuscaMoe
3143:                     REPLACE moedas WITH ALLTRIM(cursor_4c_BuscaMoe.CMoes) IN cursor_4c_AcessoFinan
3144:                     loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
3145:                     loc_oGrid.Refresh
3146:                 ENDIF
3147: 
3148:                 loc_oBusca.Release()
3149:             ENDIF
3150:         CATCH TO loc_oErro
3151:             MsgErro(loc_oErro.Message, "FormCargo.ValidarMoedaGrade")
3152:         ENDTRY

*-- Linhas 3165 a 3198:
3165:         ENDIF
3166: 
3167:         LOCAL loc_oGridCat, loc_cValor, loc_oBusca
3168:         loc_oGridCat = THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias
3169:         loc_cValor   = ALLTRIM(loc_oGridCat.Column1.Text1.Value)
3170: 
3171:         IF EMPTY(loc_cValor)
3172:             RETURN
3173:         ENDIF
3174: 
3175:         TRY
3176:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3177:                 "SigCdCtg", "cursor_4c_BuscaCtg", "Cods", loc_cValor, ;
3178:                 "Categoria")
3179: 
3180:             IF VARTYPE(loc_oBusca) = "O"
3181:                 IF !loc_oBusca.this_lAchouRegistro
3182:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
3183:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3184:                     loc_oBusca.Show()
3185:                 ENDIF
3186: 
3187:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtg")
3188:                     SELECT cursor_4c_BuscaCtg
3189:                     REPLACE categoria WITH ALLTRIM(cursor_4c_BuscaCtg.Cods), ;
3190:                             descs     WITH ALLTRIM(cursor_4c_BuscaCtg.Descs) ;
3191:                         IN cursor_4c_Categorias
3192:                     loc_oGridCat.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaCtg.Cods)
3193:                     loc_oGridCat.Column2.Text1.Value = ALLTRIM(cursor_4c_BuscaCtg.Descs)
3194:                     loc_oGridCat.Refresh
3195:                 ENDIF
3196: 
3197:                 loc_oBusca.Release()
3198:             ENDIF

*-- Linhas 3236 a 3264:
3236:         ENDIF
3237: 
3238:         LOCAL loc_oGridCat, loc_cValor, loc_oBusca
3239:         loc_oGridCat = THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias
3240:         loc_cValor   = ALLTRIM(loc_oGridCat.Column3.Text1.Value)
3241: 
3242:         TRY
3243:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3244:                 "sigcarct", "cursor_4c_BuscaTipo", "tipo", loc_cValor, ;
3245:                 "Tipo de Categoria")
3246: 
3247:             IF VARTYPE(loc_oBusca) = "O"
3248:                 IF !loc_oBusca.this_lAchouRegistro
3249:                     loc_oBusca.mAddColuna("tipo", "", "Tipo")
3250:                     loc_oBusca.Show()
3251:                 ENDIF
3252: 
3253:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTipo")
3254:                     SELECT cursor_4c_BuscaTipo
3255:                     REPLACE tipo WITH ALLTRIM(cursor_4c_BuscaTipo.tipo) ;
3256:                         IN cursor_4c_Categorias
3257:                     loc_oGridCat.Column3.Text1.Value = ALLTRIM(cursor_4c_BuscaTipo.tipo)
3258:                     loc_oGridCat.Refresh
3259:                 ENDIF
3260: 
3261:                 loc_oBusca.Release()
3262:             ENDIF
3263:         CATCH TO loc_oErro
3264:             MsgErro(loc_oErro.Message, "FormCargo.ValidarTipoCategoria")

