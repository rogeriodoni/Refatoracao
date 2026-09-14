# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Relatorio' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cabecalho' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'ImpTotal' (parent: SIGREDCT): Top original=90 vs migrado 'chk_4c_ImpTotal' Top=5 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ImpCodBarra' (parent: SIGREDCT): Top original=108 vs migrado 'chk_4c_ImpCodBarra' Top=23 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReDct.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (720 linhas total):

*-- Linhas 15 a 34:
15: *   - pgf_4c_Paginas    : PageFrame com Page1 "Parametros" (campos de filtro)
16: *                         Page2 "Dados" (reservada, sem controles de entrada)
17: *   - cmg_4c_Botoes     : CommandGroup Visualizar/Imprimir/Excel/Encerrar
18: *   - chk_4c_ImpTotal   : checkbox Imprimir Totalizacao (Page1)
19: *   - chk_4c_ImpCodBarra: checkbox Imprimir somente Cod. de Barras (Page1)
20: *
21: * Fases concluidas:
22: *   FASE 1-2: SigReDctBO.prg (BO completo com PrepararDados)
23: *   FASE 3  : DEFINE CLASS, propriedades, Init(), InicializarForm(),
24: *             ConfigurarCabecalho(), ConfigurarPageFrame(), Destroy()
25: *   FASE 4  : ConfigurarBotoes(), ConfigurarPaginaLista(), BINDEVENTs,
26: *             todos os handlers de botoes e checkboxes
27: *   FASE 5  : ConfigurarPaginaDados() - Page2 sem campos (frmrelatorio flat)
28: *   FASE 6  : Verificacao de campos/lookups (form nao tem - original so tem 2
29: *             checkboxes). fAltBar2de5() integrada em functions.prg.
30: *==============================================================================
31: 
32: DEFINE CLASS FormSigReDct AS FormBase
33: 
34:     *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=150)

*-- Linhas 63 a 81:
63:         THIS.this_cEmps  = IIF(VARTYPE(par_cEmp) = "C", par_cEmp, "")
64:         THIS.this_cDopes = IIF(VARTYPE(par_cDop) = "C", par_cDop, "")
65:         THIS.this_nNumes = IIF(VARTYPE(par_nNum) = "N", par_nNum, 0)
66:         THIS.Caption = "Impress" + CHR(227) + "o de Documento (" + ;
67:             ALLTRIM(THIS.this_cDopes) + "/" + ALLTRIM(STR(THIS.this_nNumes)) + ")"
68:         RETURN DODEFAULT()
69:     ENDPROC
70: 
71:     *--------------------------------------------------------------------------
72:     * InicializarForm - Monta estrutura base do formulario flat de impressao
73:     *   1. Fundo (Picture) do layout padrao
74:     *   2. Instancia SigReDctBO e sincroniza parametros do documento
75:     *   3. Cabecalho escuro com titulo dinamico do documento
76:     *   (Fases 4+: botoes CommandGroup, checkboxes, BINDEVENTs)
77:     *--------------------------------------------------------------------------
78:     PROTECTED PROCEDURE InicializarForm()
79:         LOCAL loc_lSucesso, loc_lContinuar, loc_oPg
80:         loc_lSucesso   = .F.
81:         loc_lContinuar = .T.

*-- Linhas 98 a 127:
98:                 THIS.this_oRelatorio.this_nNumes = THIS.this_nNumes
99: 
100:                 THIS.ConfigurarCabecalho()
101:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
102:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
103: 
104:                 *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
105:                 THIS.ConfigurarBotoes()
106: 
107:                 *-- PageFrame com pagina de parametros
108:                 THIS.ConfigurarPageFrame()
109: 
110:                 *-- Opcoes de impressao na Page1 (checkboxes ImpTotal/ImpCodBarra)
111:                 THIS.ConfigurarPaginaLista()
112: 
113:                 *-- Page2: sem campos de entrada (frmrelatorio flat)
114:                 THIS.ConfigurarPaginaDados()
115: 
116:                 *-- Vincular Click dos botoes de relatorio
117:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
118:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
119:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
120:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
121: 
122:                 *-- Vincular click dos checkboxes (opcoes mutuamente exclusivas)
123:                 loc_oPg = THIS.pgf_4c_Paginas.Page1
124:                 BINDEVENT(loc_oPg.chk_4c_ImpTotal,    "Click", THIS, "ChkImpTotalClick")
125:                 BINDEVENT(loc_oPg.chk_4c_ImpCodBarra, "Click", THIS, "ChkImpCodBarraClick")
126: 
127:                 THIS.LimparCampos()

*-- Linhas 141 a 187:
141:     *--------------------------------------------------------------------------
142:     * ConfigurarCabecalho - Container escuro superior com titulo do documento
143:     *   Equivalente ao cntSombra do frmrelatorio legado.
144:     *   Original: cntSombra.Top=0, Left=0 (cobrindo largura total do form).
145:     *   Caption dinamico atualizado apos AddObject em InicializarForm().
146:     *--------------------------------------------------------------------------
147:     PROTECTED PROCEDURE ConfigurarCabecalho()
148:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
149:         WITH THIS.cnt_4c_Cabecalho
150:             .Top         = 0
151:             .Left        = 0
152:             .Width       = THIS.Width
153:             .Height      = 80
154:             .BackStyle   = 1
155:             .BackColor   = RGB(100, 100, 100)
156:             .BorderWidth = 0
157:             .Visible     = .T.
158: 
159:             *-- Sombra (deslocada 2px para efeito de profundidade no texto)
160:             .AddObject("lbl_4c_Sombra", "Label")
161:             WITH .lbl_4c_Sombra
162:                 .Top       = 22
163:                 .Left      = 22
164:                 .Width     = THIS.Width
165:                 .Height    = 30
166:                 .Caption   = THIS.Caption
167:                 .FontName  = "Tahoma"
168:                 .FontSize  = 14
169:                 .FontBold  = .T.
170:                 .ForeColor = RGB(0, 0, 0)
171:                 .BackStyle = 0
172:                 .Visible   = .T.
173:             ENDWITH
174: 
175:             *-- Titulo em branco (sobreposto a sombra preta)
176:             .AddObject("lbl_4c_Titulo", "Label")
177:             WITH .lbl_4c_Titulo
178:                 .Top       = 20
179:                 .Left      = 20
180:                 .Width     = THIS.Width
181:                 .Height    = 30
182:                 .Caption   = THIS.Caption
183:                 .FontName  = "Tahoma"
184:                 .FontSize  = 14
185:                 .FontBold  = .T.
186:                 .ForeColor = RGB(255, 255, 255)
187:                 .BackStyle = 0

*-- Linhas 197 a 235:
197:     *   (Tabs ocultas, ActivePage=1) para consistencia com o restante do sistema.
198:     *
199:     *   Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form.
200:     *   Os campos de parametro (checkboxes ImpTotal/ImpCodBarra) sao adicionados
201:     *   a Page1 nas fases seguintes (5-6).
202:     *--------------------------------------------------------------------------
203:     PROTECTED PROCEDURE ConfigurarPageFrame()
204:         LOCAL loc_oPgf
205: 
206:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
207:         loc_oPgf = THIS.pgf_4c_Paginas
208: 
209:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
210:         loc_oPgf.PageCount = 2
211: 
212:         *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
213:         loc_oPgf.Top    = 85
214:         loc_oPgf.Left   = -1
215:         loc_oPgf.Width  = THIS.Width + 2
216:         loc_oPgf.Height = THIS.Height - 85
217:         loc_oPgf.Tabs   = .F.
218: 
219:         *-- Page1: parametros de impressao (checkboxes nas fases seguintes)
220:         loc_oPgf.Page1.Caption   = "Par" + CHR(226) + "metros"
221:         loc_oPgf.Page1.FontName  = "Tahoma"
222:         loc_oPgf.Page1.FontSize  = 8
223:         IF TYPE("gc_4c_CaminhoIcones") = "C" AND !EMPTY(gc_4c_CaminhoIcones)
224:             loc_oPgf.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
225:         ENDIF
226:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
227:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
228: 
229:         *-- Page2: reservada (mantida para consistencia com o padrao do sistema)
230:         loc_oPgf.Page2.Caption   = "Dados"
231:         loc_oPgf.Page2.FontName  = "Tahoma"
232:         loc_oPgf.Page2.FontSize  = 8
233:         IF TYPE("gc_4c_CaminhoIcones") = "C" AND !EMPTY(gc_4c_CaminhoIcones)
234:             loc_oPgf.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
235:         ENDIF

*-- Linhas 249 a 274:
249:     PROTECTED PROCEDURE ConfigurarBotoes()
250:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
251:         WITH THIS.cmg_4c_Botoes
252:             .Top           = 0
253:             .Left          = 529
254:             .Width         = 273
255:             .Height        = 80
256:             .ButtonCount   = 4
257:             .BackStyle     = 0
258:             .BorderStyle   = 0
259:             .BorderColor   = RGB(136, 189, 188)
260:             .SpecialEffect = 1
261:             .Themes        = .F.
262:             .Visible       = .T.
263: 
264:             WITH .Buttons(1)
265:                 .Top             = 5
266:                 .Left            = 5
267:                 .Width           = 65
268:                 .Height          = 70
269:                 .Caption         = "Visualizar"
270:                 .FontBold        = .T.
271:                 .FontItalic      = .T.
272:                 .BackColor       = RGB(255, 255, 255)
273:                 .ForeColor       = RGB(90, 90, 90)
274:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 281 a 293:
281:             ENDWITH
282: 
283:             WITH .Buttons(2)
284:                 .Top             = 5
285:                 .Left            = 71
286:                 .Width           = 65
287:                 .Height          = 70
288:                 .Caption         = "Imprimir"
289:                 .FontName        = "Tahoma"
290:                 .FontBold        = .T.
291:                 .FontItalic      = .T.
292:                 .FontSize        = 8
293:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 302 a 314:
302:             ENDWITH
303: 
304:             WITH .Buttons(3)
305:                 .Top             = 5
306:                 .Left            = 137
307:                 .Width           = 65
308:                 .Height          = 70
309:                 .Caption         = "Excel"
310:                 .FontName        = "Tahoma"
311:                 .FontBold        = .T.
312:                 .FontItalic      = .T.
313:                 .FontSize        = 8
314:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 323 a 335:
323:             ENDWITH
324: 
325:             WITH .Buttons(4)
326:                 .Top             = 5
327:                 .Left            = 203
328:                 .Width           = 65
329:                 .Height          = 70
330:                 .Caption         = "Encerrar"
331:                 .Cancel          = .T.
332:                 .FontName        = "Tahoma"
333:                 .FontBold        = .T.
334:                 .FontItalic      = .T.
335:                 .FontSize        = 8

*-- Linhas 348 a 389:
348: 
349:     *--------------------------------------------------------------------------
350:     * ConfigurarPaginaLista - Adiciona opcoes de impressao a Page1
351:     *   Original SIGREDCT: 2 checkboxes (ImpTotal, ImpCodBarra) no form flat.
352:     *   No novo padrao sao colocados em Page1 do PageFrame.
353:     *   Posicoes: ImpTotal.Top=5, ImpCodBarra.Top=23 (original top=90/108 - 85)
354:     *--------------------------------------------------------------------------
355:     PROTECTED PROCEDURE ConfigurarPaginaLista()
356:         LOCAL loc_oPg
357:         TRY
358:             loc_oPg = THIS.pgf_4c_Paginas.Page1
359: 
360:             *-- Checkbox: Imprimir com Totalizacao (padrao: marcado)
361:             loc_oPg.AddObject("chk_4c_ImpTotal", "CheckBox")
362:             WITH loc_oPg.chk_4c_ImpTotal
363:                 .Top       = 5
364:                 .Left      = 24
365:                 .Width     = 200
366:                 .Height    = 17
367:                 .Caption   = "Imprimir Totaliza" + CHR(231) + CHR(227) + "o"
368:                 .Value     = 1
369:                 .FontName  = "Tahoma"
370:                 .FontSize  = 8
371:                 .ForeColor = RGB(90, 90, 90)
372:                 .BackStyle = 0
373:                 .Themes    = .F.
374:                 .Visible   = .T.
375:             ENDWITH
376: 
377:             *-- Checkbox: Imprimir somente Codigo de Barras (padrao: desmarcado)
378:             loc_oPg.AddObject("chk_4c_ImpCodBarra", "CheckBox")
379:             WITH loc_oPg.chk_4c_ImpCodBarra
380:                 .Top       = 23
381:                 .Left      = 24
382:                 .Width     = 220
383:                 .Height    = 17
384:                 .Caption   = "Imprimir somente Cod. de Barras"
385:                 .Value     = 0
386:                 .FontName  = "Tahoma"
387:                 .FontSize  = 8
388:                 .ForeColor = RGB(90, 90, 90)
389:                 .BackStyle = 0

*-- Linhas 399 a 407:
399:     *--------------------------------------------------------------------------
400:     * ConfigurarPaginaDados - Configura Page2 do PageFrame
401:     *   Formulario frmrelatorio SigReDct e FLAT: todos os controles de selecao
402:     *   (checkboxes ImpTotal e ImpCodBarra) ficam em Page1.
403:     *   Page2 e reservada para consistencia arquitetural do pipeline multi-fase.
404:     *   Configura as propriedades visuais de Page2 (background, fonte, cores)
405:     *   para garantir que a pagina nao exiba visual discrepante caso seja ativada.
406:     *--------------------------------------------------------------------------
407:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 418 a 432:
418:             ENDIF
419: 
420:             *-- Label informativo: relatorio plano, dados gerados em PrepararDados
421:             loc_oPg.AddObject("lbl_4c_InfoDados", "Label")
422:             WITH loc_oPg.lbl_4c_InfoDados
423:                 .Top       = 10
424:                 .Left      = 20
425:                 .Width     = 600
426:                 .Height    = 18
427:                 .Caption   = "Dados gerados automaticamente pelo BO ao Visualizar/Imprimir."
428:                 .FontName  = "Tahoma"
429:                 .FontSize  = 8
430:                 .ForeColor = RGB(90, 90, 90)
431:                 .BackStyle = 0
432:                 .Visible   = .T.

*-- Linhas 573 a 581:
573:     ENDPROC
574: 
575:     *--------------------------------------------------------------------------
576:     * ChkImpTotalClick - Mantem checkboxes mutuamente exclusivos
577:     *   Original ImpTotal.Click: If Value=1 Then impCodBarra.Value=0
578:     *--------------------------------------------------------------------------
579:     PROCEDURE ChkImpTotalClick()
580:         LOCAL loc_oPg
581:         TRY

*-- Linhas 589 a 597:
589:     ENDPROC
590: 
591:     *--------------------------------------------------------------------------
592:     * ChkImpCodBarraClick - Mantem checkboxes mutuamente exclusivos
593:     *   Original ImpCodBarra.Valid: If Value=1 Then ImpTotal.Value=0
594:     *--------------------------------------------------------------------------
595:     PROCEDURE ChkImpCodBarraClick()
596:         LOCAL loc_oPg
597:         TRY


### BO (C:\4c\projeto\app\classes\SigReDctBO.prg):
*==============================================================================
* SIGREDCTBO.PRG
* Business Object para Relatorio Documento de Corte (SigReDct / SigReDc3)
*
* Herda de: RelatorioBase
* Tipo: REPORT
* Uso: Impressao/Visualizacao de documentos de corte com etiquetas de codigo
*      de barras. Recebe parametros de identificacao do documento via
*      FormParaRelatorio(). Gera dois estilos de relatorio conforme opcao:
*        - SigReDct.frx : com totalizacao
*        - SigReDc3.frx : sem totalizacao (somente etiquetas)
*==============================================================================

DEFINE CLASS SigReDctBO AS RelatorioBase

    *-- Parametros de identificacao do documento (recebidos via FormParaRelatorio)
    this_cEmps          = ""    && Codigo da empresa (pEmp)
    this_cDopes         = ""    && Tipo de documento / operacao (pDop)
    this_nNumes         = 0     && Numero do documento (pNum)

    *-- Opcoes de impressao (mapeadas dos checkboxes do form)
    this_nImpTotal      = 0     && 1=Imprimir com totalizacao, 0=sem totalizacao
    this_nImpCodBarra   = 0     && 1=Imprimir somente cod. de barras, 0=normal

    *-- Cursor de saida do relatorio (populado por PrepararDados)
    this_cCursorDados   = "cursor_4c_Relatorio"

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor_4c_Relatorio e cursor_4c_Cabecalho
    * Logica fiel ao PROCEDURE processamento do formulario original SIGREDCT
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_cEdn, loc_cEdn2, loc_cSql, loc_nResult
        LOCAL loc_nOp, loc_nOrdem, loc_nQtdB
        LOCAL loc_cImpCodBarItem, loc_cImpCodBarDoc
        LOCAL loc_cEmp, loc_cCab, loc_cSub

        loc_lSucesso = .F.

        TRY
            *-- Chaves compostas do documento (empresa + tipo + numero)
            loc_cEdn  = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 10)
            loc_cEdn2 = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)

            *-- Cursor principal do relatorio
            CREATE CURSOR cursor_4c_Relatorio (;
                cBars n(14), Cpros c(14), Dpros c(40), Nops n(10), cmats c(14), dMats c(40),;
                qtd1s n(12,3), cUni1s c(3), Peso1s n(12,3), cUnip1s c(3),;
                qtd2s n(12,3), cUni2s c(3), Qtds n(6), Quebras n(10),;
                peso2s n(12,3), cunip2s c(3), PesoFs n(12,3), Ordem n(10),;
                cestos c(1), GrupoOs c(10), ContaOs c(10), Rclis c(40),;
                Qtdb n(6), ImpCodBar c(20))

            INDEX ON STR(Nops,10) + cMats TAG NopMat
            INDEX ON STR(Quebras,10) + STR(Nops,10) + STR(Ordem,10) + STR(Cbars,14) TAG Nops

            *-- SigCdNei: etiquetas agrupadas por NOP e material
            loc_cSql = "SELECT Nops, cmats, SUM(qtds) AS Qtds, SUM(Pesos) AS Pesos, SUM(Peso2s) AS Peso2s " +;
                       "FROM SigCdNei WHERE EmpDnPs = " + EscaparSQL(loc_cEdn) + " GROUP BY nops, cmats"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpNensi")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao consultar SigCdNei"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TmpNensi
            INDEX ON STR(Nops,10) + cmats TAG Nops

            *-- SigOpEtq: etiquetas da operacao
            loc_cSql = "SELECT Nops, cbars, Cpros, Qtds FROM SigOpEtq " +;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn2)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpEti")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao consultar SigOpEtq"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TmpEti
            INDEX ON STR(Nops,10) + STR(Cbars,14) TAG Nops

            *-- Processar cada etiqueta (scan externo)
            SELECT cursor_4c_TmpEti
            SCAN
                loc_nOp    = cursor_4c_TmpEti.Nops
                loc_nOrdem = 0

                *-- Dados do produto da etiqueta atual
                loc_cSql = "SELECT Dpros, cUnis, cUniPs FROM SigCdPro " +;
                           "WHERE Cpros = '" + ALLTRIM(cursor_4c_TmpEti.Cpros) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpProPrd")

                *-- Dados do cliente/pedido para este NOP
                loc_cSql = "SELECT a.Nops, b.GrupoOs, b.ContaOs, c.Rclis " +;
                           "FROM SigOpPic a, SigMvCab b, SigCdCli c " +;
                           "WHERE a.Nops = " + STR(loc_nOp) +;
                           " AND a.EmpDopNums = b.EmpDopNums AND b.ContaOs = c.Iclis"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpCli")

                *-- Codigo de barras desta etiqueta
                loc_cImpCodBarItem = fAltBar2de5(TRANSFORM(cursor_4c_TmpEti.Cbars, "@L 99999999999999"))

                *-- Posicionar TmpNensi no NOP atual
                SELECT cursor_4c_TmpNensi
                SET ORDER TO Nops
                =SEEK(STR(loc_nOp, 10))

                *-- Composicao do produto
                loc_cSql = "SELECT * FROM SigPrCpo " +;
                           "WHERE Cpros = '" + ALLTRIM(cursor_4c_TmpEti.Cpros) + "' ORDER BY Mats"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpCompo")

                loc_nQtdB = 0

                *-- Loop 1: processa todas as etiquetas do NOP atual (TmpEti x TmpNensi sincronizado)
                SELECT cursor_4c_TmpEti
                SCAN WHILE Nops = loc_nOp
                    loc_nQtdB  = loc_nQtdB + cursor_4c_TmpEti.Qtds
                    loc_nOrdem = loc_nOrdem + 1

                    INSERT INTO cursor_4c_Relatorio ;
                        (Nops, cbars, Cpros, Dpros, Ordem, Qtds, GrupoOs, ContaOs, Rclis, Quebras, QtdB, ImpCodBar) VALUES ;
                        (cursor_4c_TmpEti.Nops, cursor_4c_TmpEti.Cbars, cursor_4c_TmpEti.Cpros,;
                         cursor_4c_TmpProPrd.Dpros, loc_nOrdem, 1,;
                         cursor_4c_TmpCli.GrupoOs, cursor_4c_TmpCli.ContaOs, cursor_4c_TmpCli.Rclis,;
                         IIF(THIS.this_nImpTotal <> 1, cursor_4c_TmpEti.Nops, 0),;
                         cursor_4c_TmpEti.Qtds, loc_cImpCodBarItem)

                    SELECT cursor_4c_TmpNensi
                    IF Nops = loc_nOp
                        loc_cSql = "SELECT a.Dpros, a.cUnis, a.cUnips, b.cestos " +;
                                   "FROM SigCdPro a, SigCdUni b " +;
                                   "WHERE a.Cpros = '" + ALLTRIM(cursor_4c_TmpNensi.Cmats) + "'" +;
                                   " AND a.Cunis = b.Cunis"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpProMat")

                        REPLACE cmats   WITH cursor_4c_TmpNensi.Cmats,;
                                Dmats   WITH cursor_4c_TmpProMat.Dpros,;
                                qtd1s   WITH cursor_4c_TmpNensi.Qtds,;
                                cuni1s  WITH cursor_4c_TmpProMat.Cunis,;
                                cUnip1s WITH cursor_4c_TmpProMat.Cunips,;
                                Peso1s  WITH cursor_4c_TmpNensi.Peso2s,;
                                PesoFs  WITH cursor_4c_TmpNensi.Pesos,;
                                Cestos  WITH cursor_4c_TmpProMat.Cestos ;
                                IN cursor_4c_Relatorio

                        SELECT cursor_4c_TmpNensi
                        SKIP
                    ENDIF
                ENDSCAN
                SKIP -1

                *-- Loop 2: materiais adicionais do TmpNensi nao consumidos no loop 1
                SELECT cursor_4c_TmpNensi
                SCAN WHILE Nops = loc_nOp
                    loc_nOrdem = loc_nOrdem + 1

                    INSERT INTO cursor_4c_Relatorio ;
                        (Nops, cbars, Cpros, Dpros, Ordem, GrupoOs, ContaOs, Rclis, Quebras, ImpCodBar) VALUES ;
                        (cursor_4c_TmpEti.Nops, 0, cursor_4c_TmpEti.Cpros, cursor_4c_TmpProPrd.Dpros,;
                         loc_nOrdem, cursor_4c_TmpCli.GrupoOs, cursor_4c_TmpCli.ContaOs,;
                         cursor_4c_TmpCli.Rclis,;
                         IIF(THIS.this_nImpTotal <> 1, cursor_4c_TmpEti.Nops, 0), loc_cImpCodBarItem)

                    loc_cSql = "SELECT a.Dpros, a.cUnis, a.cUnips, b.Cestos " +;
                               "FROM SigCdPro a, SigCdUni b " +;
                               "WHERE a.Cpros = '" + ALLTRIM(cursor_4c_TmpNensi.Cmats) + "'" +;
                               " AND a.Cunis = b.Cunis"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpProMat")

                    REPLACE cmats   WITH cursor_4c_TmpNensi.Cmats,;
                            Dmats   WITH cursor_4c_TmpProMat.Dpros,;
                            qtd1s   WITH cursor_4c_TmpNensi.Qtds,;
                            cuni1s  WITH cursor_4c_TmpProMat.Cunis,;
                            cUnip1s WITH cursor_4c_TmpProMat.Cunips,;
                            Peso1s  WITH cursor_4c_TmpNensi.Peso2s,;
                            cestos  WITH cursor_4c_TmpProMat.Cestos,;
                            PesoFs  WITH cursor_4c_TmpNensi.Pesos ;
                            IN cursor_4c_Relatorio

                ENDSCAN

                *-- Loop 3: composicao do produto (itens da grade de composicao)
                SELECT cursor_4c_TmpCompo
                SCAN
                    SELECT cursor_4c_Relatorio
                    SET ORDER TO NopMat
                    IF NOT SEEK(STR(loc_nOp, 10) + cursor_4c_TmpCompo.mats)
                        loc_cSql = "SELECT Dpros, cUnis, cUnips FROM SigCdPro " +;
                                   "WHERE Cpros = '" + ALLTRIM(cursor_4c_TmpCompo.mats) + "'"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpProMat")
                        loc_nOrdem = loc_nOrdem + 1

                        INSERT INTO cursor_4c_Relatorio ;
                            (Nops, cbars, Cpros, Dpros, Ordem, CMats, dMats, Grupoos, ContaOs, Rclis, Quebras) VALUES ;
                            (cursor_4c_TmpEti.Nops, 0, cursor_4c_TmpEti.Cpros, cursor_4c_TmpProPrd.Dpros,;
                             loc_nOrdem, cursor_4c_TmpCompo.Mats, cursor_4c_TmpProMat.Dpros,;
                             cursor_4c_TmpCli.GrupoOs, cursor_4c_TmpCli.ContaOs, cursor_4c_TmpCli.Rclis,;
                             IIF(THIS.this_nImpTotal <> 1, cursor_4c_TmpEti.Nops, 0))
                    ENDIF

                    SELECT cursor_4c_Relatorio
                    SET ORDER TO NopMat
                    =SEEK(STR(loc_nOp, 10) + cursor_4c_TmpCompo.mats)
                    REPLACE qtd2s   WITH cursor_4c_TmpCompo.Qtds * loc_nQtdB,;
                            cuni2s  WITH cursor_4c_TmpCompo.UniCompos,;
                            cUnip2s WITH cursor_4c_TmpCompo.Cunips,;
                            Peso2s  WITH cursor_4c_TmpCompo.Pesos * loc_nQtdB ;
                            IN cursor_4c_Relatorio

                    SELECT cursor_4c_TmpCompo
                ENDSCAN
            ENDSCAN

            *-- Linha de totalizacao (quando ImpTotal = 1)
            IF THIS.this_nImpTotal = 1
                SELECT 9999999999 AS Nops, SUM(Qtds) AS Qtds, SUM(QtdB) AS Qtdb, SUM(Pesofs) AS PesoFs ;
                    FROM cursor_4c_Relatorio ;
                    INTO CURSOR cursor_4c_Selecao GROUP BY 1

                SELECT cursor_4c_Relatorio
                APPEND BLANK
                REPLACE Nops   WITH cursor_4c_Selecao.Nops,;
                        Qtds   WITH cursor_4c_Selecao.Qtds,;
                        QtdB   WITH cursor_4c_Selecao.Qtdb,;
                        PesoFs WITH cursor_4c_Selecao.Pesofs ;
                        IN cursor_4c_Relatorio
            ENDIF

            *-- Codigo de barras do documento (numero da operacao + numero do doc)
            loc_cSql = "SELECT Ndopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_TmpOpp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpOpp")
                loc_cImpCodBarDoc = fAltBar2de5(;
                    TRANSFORM(cursor_4c_TmpOpp.NDopps, "@L 99") +;
                    TRANSFORM(THIS.this_nNumes, "@L 9999999999"))
            ELSE
                loc_cImpCodBarDoc = ""
            ENDIF

            *-- Nome da empresa
            loc_cEmp = go_4c_Sistema.cCodEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            loc_cCab = ALLTRIM(THIS.this_cDopes) + " - " + STR(THIS.this_nNumes, 10)
            loc_cSub = ""

            *-- Cursor de cabecalho para o relatorio
            CREATE CURSOR cursor_4c_Cabecalho (;
                Titulo c(100), SubTitulo m, NomeEmpresa c(100), ImpCodBar c(20))
            INSERT INTO cursor_4c_Cabecalho (Titulo, SubTitulo, NomeEmpresa, ImpCodBar) ;
                VALUES (loc_cCab, loc_cSub, loc_cEmp, loc_cImpCodBarDoc)

            *-- Posicionar cursor principal para o relatorio
            SELECT cursor_4c_Relatorio
            SET ORDER TO Nops
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nImpTotal = 1
                REPORT FORM (gc_4c_CaminhoReports + "SigReDct") PREVIEW NOCONSOLE
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigReDc3") PREVIEW NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Impressao do relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nImpTotal = 1
                REPORT FORM (gc_4c_CaminhoReports + "SigReDct") TO PRINTER PROMPT NOCONSOLE
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigReDc3") TO PRINTER PROMPT NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararEmail - Posiciona cursor para envio por email
    *--------------------------------------------------------------------------
    PROCEDURE PrepararEmail()
        IF USED("cursor_4c_Relatorio")
            SELECT cursor_4c_Relatorio
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros do documento a partir de um cursor
    * Para relatorios, o cursor pode conter as chaves do documento
    * (Emps, Dopes, Numes) e as opcoes de impressao (ImpTotal, ImpCodBarra).
    * Util quando o relatorio eh invocado a partir de outro form que ja tem
    * o registro selecionado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de origem inv" + CHR(225) + "lido"
                EXIT
            ENDIF

            SELECT (par_cAliasCursor)

            *-- Chaves do documento (obrigatorias)
            THIS.this_cEmps  = TratarNulo(Emps,  "C")
            THIS.this_cDopes = TratarNulo(Dopes, "C")
            THIS.this_nNumes = TratarNulo(Numes, "N")

            *-- Opcoes de impressao (opcionais - se nao existirem no cursor,
            *-- o CATCH abaixo mantem os valores atuais)
            TRY
                THIS.this_nImpTotal    = TratarNulo(ImpTotal,    "N")
                THIS.this_nImpCodBarra = TratarNulo(ImpCodBarra, "N")
            CATCH
                *-- Cursor nao possui colunas de opcoes - usa valores atuais
            ENDTRY

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + ;
                "metros do cursor: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do documento (Emps + Dopes + Numes)
    * Usada para identificacao em logs e mensagens.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmps) + "|" + ;
               ALLTRIM(THIS.this_cDopes) + "|" + ;
               ALLTRIM(STR(THIS.this_nNumes, 10))
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios
    * Relatorios sao operacoes read-only; nao gravam registros no banco.
    * Implementado para satisfazer a interface BO esperada pelo pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o aplic" + CHR(225) + "vel: " + ;
            "relat" + CHR(243) + "rio de documento de corte n" + CHR(227) + ;
            "o realiza inclus" + CHR(227) + "o de registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios
    * Relatorios sao operacoes read-only; nao gravam registros no banco.
    * Implementado para satisfazer a interface BO esperada pelo pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o aplic" + CHR(225) + "vel: " + ;
            "relat" + CHR(243) + "rio de documento de corte n" + CHR(227) + ;
            "o realiza atualiza" + CHR(231) + CHR(227) + "o de registros."
        RETURN .F.
    ENDPROC

ENDDEFINE

