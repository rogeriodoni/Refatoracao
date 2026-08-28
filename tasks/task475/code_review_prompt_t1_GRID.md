# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 691: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1047: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormNfl.prg) - TRECHOS RELEVANTES PARA PASS GRID (11058 linhas total):

*-- Linhas 56 a 78:
56:                     ENDIF
57:                 ELSE
58:                     IF !USED("crSigCnFNf")
59:                         CREATE CURSOR crSigCnFNf (cidchaves c(20), emps c(3), series c(3))
60:                         APPEND BLANK IN crSigCnFNf
61:                     ENDIF
62:                     IF !USED("crSigCnFN2")
63:                         CREATE CURSOR crSigCnFN2 (cidchaves c(20), emps c(3), series c(3))
64:                         APPEND BLANK IN crSigCnFN2
65:                     ENDIF
66:                 ENDIF
67: 
68:                 THIS.ConfigurarPaginaDados()
69:                 THIS.TornarControlesVisiveis(THIS)
70: 
71:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
72:                     THIS.CarregarLista()
73:                 ENDIF
74: 
75:                 THIS.pgf_4c_Paginas.Visible = .T.
76:                 THIS.pgf_4c_Paginas.ActivePage = 1
77:                 THIS.this_cModoAtual = "LISTA"
78:                 THIS.AjustarBotoesPorModo("LISTA")

*-- Linhas 267 a 325:
267:         ENDWITH
268: 
269:         *-- Grid Lista (Top=135+29=164 compensado; Width=971 original)
270:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
271:         WITH loc_oPagina.grd_4c_Lista
272:             .Top          = 164
273:             .Left         = 12
274:             .Width        = 971
275:             .Height       = 450
276:             .FontName     = "Tahoma"
277:             .FontSize     = 8
278:             .ColumnCount  = 4
279:             .RecordSource = ""
280:             .ReadOnly     = .T.
281:             .GridLines    = 2
282:             .RecordMark   = .F.
283:             .DeleteMark   = .F.
284:             .Visible      = .T.
285:             WITH .Column1
286:                 .ControlSource   = "cursor_4c_Dados.emps"
287:                 .Width           = 55
288:                 .ReadOnly        = .T.
289:                 .Header1.Caption = "Empr."
290:             ENDWITH
291:             WITH .Column2
292:                 .ControlSource   = "cursor_4c_Dados.Razas"
293:                 .Width           = 220
294:                 .ReadOnly        = .T.
295:                 .Header1.Caption = "Empresa"
296:             ENDWITH
297:             WITH .Column3
298:                 .ControlSource   = "cursor_4c_Dados.series"
299:                 .Width           = 55
300:                 .ReadOnly        = .T.
301:                 .Header1.Caption = "S" + CHR(233) + "rie"
302:             ENDWITH
303:             WITH .Column4
304:                 .ControlSource   = "cursor_4c_Dados.cidchaves"
305:                 .Width           = 641
306:                 .ReadOnly        = .T.
307:                 .Header1.Caption = "Chave"
308:             ENDWITH
309:         ENDWITH
310:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
311: 
312:         *-- Container cntcopia (flutuante, inicialmente oculto)
313:         *-- Top=244+29=273 compensado; Left=257 como no legado
314:         loc_oPagina.AddObject("cnt_4c_copia", "Container")
315:         WITH loc_oPagina.cnt_4c_copia
316:             .Top         = 273
317:             .Left        = 257
318:             .Width       = 484
319:             .Height      = 116
320:             .BackColor   = RGB(240, 240, 240)
321:             .BorderWidth = 1
322:             .Visible     = .F.
323:             .AddObject("lbl_4c_CopSerie", "Label")
324:             WITH .lbl_4c_CopSerie
325:                 .Caption   = "S" + CHR(233) + "rie Dest.:"

*-- Linhas 677 a 710:
677: 
678:     *--------------------------------------------------------------------------
679:     PROCEDURE CarregarLista()
680:         LOCAL loc_lResultado
681:         loc_lResultado = .F.
682: 
683:         TRY
684:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
685:                 loc_lResultado = .T.
686:             ELSE
687:                 loc_lResultado = THIS.this_oBusinessObject.Buscar("")
688:                 IF loc_lResultado AND VARTYPE(THIS.pgf_4c_Paginas) = "O"
689:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
690:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
691:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
692:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Empr."
693:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Empresa"
694:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.Header1.Caption = "S" + CHR(233) + "rie"
695:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.Header1.Caption = "Chave"
696:                     ENDIF
697:                 ENDIF
698:             ENDIF
699:         CATCH TO loc_oErro
700:             MsgErro(loc_oErro.Message, "FormNfl.CarregarLista")
701:         ENDTRY
702: 
703:         RETURN loc_lResultado
704:     ENDPROC
705: 
706:     *--------------------------------------------------------------------------
707:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
708:         LOCAL loc_lResultado
709:         loc_lResultado = .F.
710: 

*-- Linhas 1033 a 1066:
1033:             MsgErro(loc_oErro.Message, "FormNfl.BtnExcluirClick")
1034:         ENDTRY
1035:         RETURN loc_lResultado
1036:     ENDPROC
1037: 
1038:     *--------------------------------------------------------------------------
1039:     PROCEDURE BtnBuscarClick()
1040:         LOCAL loc_lResultado, loc_cFiltro
1041:         loc_lResultado = .F.
1042:         TRY
1043:             loc_cFiltro    = INPUTBOX("Informe s" + CHR(233) + "rie ou empresa:", "Buscar", "")
1044:             loc_lResultado = THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
1045:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1046:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
1047:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
1048:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Empr."
1049:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Empresa"
1050:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.Header1.Caption = "S" + CHR(233) + "rie"
1051:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.Header1.Caption = "Chave"
1052:             ENDIF
1053:         CATCH TO loc_oErro
1054:             MsgErro(loc_oErro.Message, "FormNfl.BtnBuscarClick")
1055:         ENDTRY
1056:         RETURN loc_lResultado
1057:     ENDPROC
1058: 
1059:     *--------------------------------------------------------------------------
1060:     PROCEDURE BtnEncerrarClick()
1061:         THIS.Release()
1062:     ENDPROC
1063: 
1064:     *--------------------------------------------------------------------------
1065:     PROCEDURE BtnCopiaClick()
1066:         TRY

*-- Linhas 2081 a 2105:
2081:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdSer ORDER BY cods", "cursor_4c_BuscaSer")
2082:             ENDIF
2083:             IF !USED("cursor_4c_BuscaSer")
2084:                 CREATE CURSOR cursor_4c_BuscaSer (cods c(3), descs c(50))
2085:             ENDIF
2086:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2087:             IF VARTYPE(loc_oBusca) = "O"
2088:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaSer", "cods", "descs", "S" + CHR(233) + "ries")
2089:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2090:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2091:                 loc_oBusca.Mostrar()
2092:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
2093:                     SELECT cursor_4c_BuscaSer
2094:                     loc_oCtrl.Value = ALLTRIM(cods)
2095:                 ENDIF
2096:             ENDIF
2097:             IF USED("cursor_4c_BuscaSer")
2098:                 USE IN cursor_4c_BuscaSer
2099:             ENDIF
2100:         CATCH TO loc_oErro
2101:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupSeries")
2102:         ENDTRY
2103:     ENDPROC
2104: 
2105:     *--------------------------------------------------------------------------

*-- Linhas 2133 a 2157:
2133:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdSer ORDER BY cods", "cursor_4c_BuscaSerCp")
2134:             ENDIF
2135:             IF !USED("cursor_4c_BuscaSerCp")
2136:                 CREATE CURSOR cursor_4c_BuscaSerCp (cods c(3), descs c(50))
2137:             ENDIF
2138:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2139:             IF VARTYPE(loc_oBusca) = "O"
2140:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaSerCp", "cods", "descs", "S" + CHR(233) + "rie Destino")
2141:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2142:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2143:                 loc_oBusca.Mostrar()
2144:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSerCp")
2145:                     SELECT cursor_4c_BuscaSerCp
2146:                     loc_oCtrl.Value = ALLTRIM(cods)
2147:                 ENDIF
2148:             ENDIF
2149:             IF USED("cursor_4c_BuscaSerCp")
2150:                 USE IN cursor_4c_BuscaSerCp
2151:             ENDIF
2152:         CATCH TO loc_oErro
2153:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupNomedest")
2154:         ENDTRY
2155:     ENDPROC
2156: 
2157:     *--------------------------------------------------------------------------

*-- Linhas 2185 a 2209:
2185:                 SQLEXEC(gnConnHandle, "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", "cursor_4c_BuscaEmpDest")
2186:             ENDIF
2187:             IF !USED("cursor_4c_BuscaEmpDest")
2188:                 CREATE CURSOR cursor_4c_BuscaEmpDest (CEmps c(2), Razas c(60))
2189:             ENDIF
2190:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2191:             IF VARTYPE(loc_oBusca) = "O"
2192:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpDest", "CEmps", "Razas", "Empresa Destino")
2193:                 loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
2194:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2195:                 loc_oBusca.Mostrar()
2196:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDest")
2197:                     SELECT cursor_4c_BuscaEmpDest
2198:                     loc_oCtrl.Value = ALLTRIM(CEmps)
2199:                 ENDIF
2200:             ENDIF
2201:             IF USED("cursor_4c_BuscaEmpDest")
2202:                 USE IN cursor_4c_BuscaEmpDest
2203:             ENDIF
2204:         CATCH TO loc_oErro
2205:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupEmpDest")
2206:         ENDTRY
2207:     ENDPROC
2208: 
2209:     *--------------------------------------------------------------------------

*-- Linhas 2264 a 2288:
2264:                 SQLEXEC(gnConnHandle, "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", "cursor_4c_BuscaEmpPad")
2265:             ENDIF
2266:             IF !USED("cursor_4c_BuscaEmpPad")
2267:                 CREATE CURSOR cursor_4c_BuscaEmpPad (CEmps c(2), Razas c(60))
2268:             ENDIF
2269:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2270:             IF VARTYPE(loc_oBusca) = "O"
2271:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpPad", "CEmps", "Razas", "Empresa Padr" + CHR(227) + "o")
2272:                 loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
2273:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2274:                 loc_oBusca.Mostrar()
2275:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpPad")
2276:                     SELECT cursor_4c_BuscaEmpPad
2277:                     loc_oCtrl.Value = ALLTRIM(CEmps)
2278:                 ENDIF
2279:             ENDIF
2280:             IF USED("cursor_4c_BuscaEmpPad")
2281:                 USE IN cursor_4c_BuscaEmpPad
2282:             ENDIF
2283:         CATCH TO loc_oErro
2284:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupEmpPad")
2285:         ENDTRY
2286:     ENDPROC
2287: 
2288:     *--------------------------------------------------------------------------

*-- Linhas 2343 a 2367:
2343:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_BuscaUni")
2344:             ENDIF
2345:             IF !USED("cursor_4c_BuscaUni")
2346:                 CREATE CURSOR cursor_4c_BuscaUni (CUnis c(6), DUnis c(30))
2347:             ENDIF
2348:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2349:             IF VARTYPE(loc_oBusca) = "O"
2350:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaUni", "CUnis", "DUnis", "Unidades de Medida")
2351:                 loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
2352:                 loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
2353:                 loc_oBusca.Mostrar()
2354:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
2355:                     SELECT cursor_4c_BuscaUni
2356:                     loc_oCtrl.Value = ALLTRIM(CUnis)
2357:                 ENDIF
2358:             ENDIF
2359:             IF USED("cursor_4c_BuscaUni")
2360:                 USE IN cursor_4c_BuscaUni
2361:             ENDIF
2362:         CATCH TO loc_oErro
2363:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupUnPesos")
2364:         ENDTRY
2365:     ENDPROC
2366: 
2367:     *--------------------------------------------------------------------------

*-- Linhas 2387 a 2411:
2387:                 SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", "cursor_4c_BuscaClf")
2388:             ENDIF
2389:             IF !USED("cursor_4c_BuscaClf")
2390:                 CREATE CURSOR cursor_4c_BuscaClf (codigos c(10), descricaos c(60))
2391:             ENDIF
2392:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2393:             IF VARTYPE(loc_oBusca) = "O"
2394:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaClf", "codigos", "descricaos", "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
2395:                 loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
2396:                 loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2397:                 loc_oBusca.Mostrar()
2398:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
2399:                     SELECT cursor_4c_BuscaClf
2400:                     loc_oCtrl.Value = ALLTRIM(codigos)
2401:                 ENDIF
2402:             ENDIF
2403:             IF USED("cursor_4c_BuscaClf")
2404:                 USE IN cursor_4c_BuscaClf
2405:             ENDIF
2406:         CATCH TO loc_oErro
2407:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupClsFis")
2408:         ENDTRY
2409:     ENDPROC
2410: 
2411:     *--------------------------------------------------------------------------

