# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGREFUN): Top original=148 vs migrado 'lbl_4c_Label1' Top=63 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGREFUN): Top original=147 vs migrado 'lbl_4c_Label2' Top=62 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ImpObs' (parent: SIGREFUN): Top original=172 vs migrado 'chk_4c_ImpObs' Top=87 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREFUN.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (662 linhas total):

*-- Linhas 16 a 24:
16: *   * ConfigurarBotoes()    (Visualizar / Imprimir / Excel / Encerrar)
17: *   * ConfigurarPageFrame() (PageFrame com 1 pagina - "Filtros")
18: * FASE 4/8 - Form - Campos Filtro e Handlers de Botoes
19: *   * ConfigurarCamposFiltro() (Labels, TextBoxes, CheckBox na Page1)
20: *   * FormParaRelatorio() / LimparCampos() / Validar()
21: *   * BtnVisualizarClick() / BtnImprimirClick() / BtnExcelClick() / BtnCancelarClick()
22: *   * BINDEVENTs dos botoes do relatorio
23: * FASE 5/8 - Form - Campos Principais (N/A para REPORT)
24: *   * Form de relatorio tem layout FLAT (1 pagina de filtros, sem Page2 CRUD)

*-- Linhas 79 a 87:
79:         loc_lSucesso   = .F.
80:         loc_lContinuar = .T.
81:         TRY
82:             THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o tubos fundi" + CHR(231) + CHR(227) + "o"
83: 
84:             IF TYPE("gc_4c_CaminhoIcones") = "U"
85:                 gc_4c_CaminhoIcones = ""
86:             ENDIF
87:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 104 a 117:
104:                 *-- PageFrame com pagina de filtros
105:                 THIS.ConfigurarPageFrame()
106: 
107:                 *-- Campos de filtro (Labels, TextBoxes, CheckBox)
108:                 THIS.ConfigurarCamposFiltro()
109:                 THIS.LimparCampos()
110: 
111:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
112:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
113: 
114:                 *-- Vincular botoes a handlers (metodos PUBLIC obrigatorio)
115:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
116:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
117:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

*-- Linhas 137 a 217:
137:     PROTECTED PROCEDURE ConfigurarCabecalho()
138:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
139:         WITH THIS.cnt_4c_Cabecalho
140:             .Top         = 0
141:             .Left        = 0
142:             .Width       = THIS.Width
143:             .Height      = 80
144:             .BackStyle   = 1
145:             .BackColor   = RGB(100, 100, 100)
146:             .BorderWidth = 0
147:             .Visible     = .T.
148: 
149:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
150:             .AddObject("lbl_4c_Sombra", "Label")
151:             WITH .lbl_4c_Sombra
152:                 .Top       = 22
153:                 .Left      = 22
154:                 .Width     = THIS.Width
155:                 .Height    = 30
156:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o tubos fundi" + CHR(231) + CHR(227) + "o"
157:                 .FontName  = "Tahoma"
158:                 .FontSize  = 14
159:                 .FontBold  = .T.
160:                 .ForeColor = RGB(0, 0, 0)
161:                 .BackStyle = 0
162:                 .Visible   = .T.
163:             ENDWITH
164: 
165:             *-- Titulo em branco (sobre a sombra)
166:             .AddObject("lbl_4c_Titulo", "Label")
167:             WITH .lbl_4c_Titulo
168:                 .Top       = 20
169:                 .Left      = 20
170:                 .Width     = THIS.Width
171:                 .Height    = 30
172:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o tubos fundi" + CHR(231) + CHR(227) + "o"
173:                 .FontName  = "Tahoma"
174:                 .FontSize  = 14
175:                 .FontBold  = .T.
176:                 .ForeColor = RGB(255, 255, 255)
177:                 .BackStyle = 0
178:                 .Visible   = .T.
179:             ENDWITH
180:         ENDWITH
181:     ENDPROC
182: 
183:     *--------------------------------------------------------------------------
184:     * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio (btnReport)
185:     *   Original: btnReport.Left=525, Top=3
186:     *   Geometria EXATA do framework frmrelatorio.vcx:
187:     *     cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
188:     *     Buttons Left: (1)=5, (2)=71, (3)=137, (4)=203 (inc=66)
189:     *   BINDEVENTs Click vinculados em InicializarForm() apos ConfigurarCamposFiltro().
190:     *--------------------------------------------------------------------------
191:     PROTECTED PROCEDURE ConfigurarBotoes()
192:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
193:         WITH THIS.cmg_4c_Botoes
194:             .Top           = 0
195:             .Left          = 529
196:             .Width         = 273
197:             .Height        = 80
198:             .ButtonCount   = 4
199:             .BackStyle     = 0
200:             .BorderStyle   = 0
201:             .BorderColor   = RGB(136, 189, 188)
202:             .SpecialEffect = 1
203:             .Themes        = .F.
204:             .Visible       = .T.
205: 
206:             *-- Visualizar (preview em tela)
207:             WITH .Buttons(1)
208:                 .Top             = 5
209:                 .Left            = 5
210:                 .Width           = 65
211:                 .Height          = 70
212:                 .Caption         = "Visualizar"
213:                 .FontBold        = .T.
214:                 .FontItalic      = .T.
215:                 .BackColor       = RGB(255, 255, 255)
216:                 .ForeColor       = RGB(90, 90, 90)
217:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 225 a 237:
225: 
226:             *-- Imprimir (impressora com dialogo)
227:             WITH .Buttons(2)
228:                 .Top             = 5
229:                 .Left            = 71
230:                 .Width           = 65
231:                 .Height          = 70
232:                 .Caption         = "Imprimir"
233:                 .FontName        = "Tahoma"
234:                 .FontBold        = .T.
235:                 .FontItalic      = .T.
236:                 .FontSize        = 8
237:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 247 a 259:
247: 
248:             *-- Excel (exportar dados)
249:             WITH .Buttons(3)
250:                 .Top             = 5
251:                 .Left            = 137
252:                 .Width           = 65
253:                 .Height          = 70
254:                 .Caption         = "Excel"
255:                 .FontName        = "Tahoma"
256:                 .FontBold        = .T.
257:                 .FontItalic      = .T.
258:                 .FontSize        = 8
259:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 269 a 281:
269: 
270:             *-- Encerrar (fechar form - Cancel=.T. captura ESC)
271:             WITH .Buttons(4)
272:                 .Top             = 5
273:                 .Left            = 203
274:                 .Width           = 65
275:                 .Height          = 70
276:                 .Caption         = "Encerrar"
277:                 .Cancel          = .T.
278:                 .FontName        = "Tahoma"
279:                 .FontBold        = .T.
280:                 .FontItalic      = .T.
281:                 .FontSize        = 8

*-- Linhas 296 a 323:
296:     * ConfigurarPageFrame - PageFrame com 1 pagina para os campos de filtro
297:     *   O form original SIGREFUN e FLAT, mas no novo padrao os campos sao
298:     *   agrupados em um PageFrame de 1 pagina para consistencia visual.
299:     *   Campos de filtro (TextBoxes, Labels, CheckBox) adicionados em ConfigurarCamposFiltro().
300:     *--------------------------------------------------------------------------
301:     PROTECTED PROCEDURE ConfigurarPageFrame()
302:         LOCAL loc_oPgf
303: 
304:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
305:         loc_oPgf = THIS.pgf_4c_Paginas
306: 
307:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
308:         loc_oPgf.PageCount = 1
309: 
310:         *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
311:         loc_oPgf.Top    = 85
312:         loc_oPgf.Left   = -1
313:         loc_oPgf.Width  = THIS.Width + 2
314:         loc_oPgf.Height = THIS.Height - 85
315:         loc_oPgf.Tabs   = .F.
316: 
317:         *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
318:         loc_oPgf.Page1.Caption   = "Filtros"
319:         loc_oPgf.Page1.FontName  = "Tahoma"
320:         loc_oPgf.Page1.FontSize  = 8
321:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
322:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
323:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 354 a 436:
354: 
355:     *--------------------------------------------------------------------------
356:     * ConfigurarCamposFiltro - Adiciona controles de filtro na Page1
357:     *   Posicoes relativas a Page1 (top original da FLAT form - pgf.Top=85)
358:     *   Layout original: Label2 top=147, GetFundi/f top=144, ImpObs top=172
359:     *--------------------------------------------------------------------------
360:     PROTECTED PROCEDURE ConfigurarCamposFiltro()
361:         LOCAL loc_oPag1
362:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
363: 
364:         *-- Label "N? Fundi??o : " (Label2: top=147->62, left=264, width=78)
365:         loc_oPag1.AddObject("lbl_4c_Label2", "Label")
366:         WITH loc_oPag1.lbl_4c_Label2
367:             .Top       = 62
368:             .Left      = 264
369:             .Width     = 78
370:             .Height    = 17
371:             .Caption   = "N" + CHR(186) + ". Fundi" + CHR(231) + CHR(227) + "o : "
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8
374:             .BackStyle = 0
375:             .ForeColor = RGB(90, 90, 90)
376:             .Visible   = .T.
377:         ENDWITH
378: 
379:         *-- TextBox N? Fundi??o inicial (GetFundi: top=144->59, left=343, width=52)
380:         loc_oPag1.AddObject("txt_4c_Fundi", "TextBox")
381:         WITH loc_oPag1.txt_4c_Fundi
382:             .Top           = 59
383:             .Left          = 343
384:             .Width         = 52
385:             .Height        = 23
386:             .Value         = 0
387:             .InputMask     = "999999"
388:             .SpecialEffect = 1
389:             .FontName      = "Tahoma"
390:             .FontSize      = 8
391:             .Visible       = .T.
392:         ENDWITH
393: 
394:         *-- Label "?" separador de range (Label1: top=148->63, left=404, width=9)
395:         loc_oPag1.AddObject("lbl_4c_Label1", "Label")
396:         WITH loc_oPag1.lbl_4c_Label1
397:             .Top       = 63
398:             .Left      = 404
399:             .Width     = 9
400:             .Height    = 17
401:             .Caption   = CHR(224)
402:             .FontName  = "Tahoma"
403:             .FontSize  = 8
404:             .BackStyle = 0
405:             .ForeColor = RGB(90, 90, 90)
406:             .Visible   = .T.
407:         ENDWITH
408: 
409:         *-- TextBox N? Fundi??o final (GetFundf: top=144->59, left=420, width=52)
410:         loc_oPag1.AddObject("txt_4c_Fundf", "TextBox")
411:         WITH loc_oPag1.txt_4c_Fundf
412:             .Top           = 59
413:             .Left          = 420
414:             .Width         = 52
415:             .Height        = 23
416:             .Value         = 0
417:             .InputMask     = "999999"
418:             .SpecialEffect = 1
419:             .FontName      = "Tahoma"
420:             .FontSize      = 8
421:             .Visible       = .T.
422:         ENDWITH
423: 
424:         *-- CheckBox "Imprimir observa??o do item" (ImpObs: top=172->87, left=343)
425:         loc_oPag1.AddObject("chk_4c_ImpObs", "CheckBox")
426:         WITH loc_oPag1.chk_4c_ImpObs
427:             .Top       = 87
428:             .Left      = 343
429:             .Width     = 153
430:             .Height    = 15
431:             .Caption   = "Imprimir observa" + CHR(231) + CHR(227) + "o do item"
432:             .Value     = 0
433:             .AutoSize  = .T.
434:             .Alignment = 0
435:             .BackStyle = 0
436:             .ForeColor = RGB(90, 90, 90)


### BO (C:\4c\projeto\app\classes\SIGREFUNBO.prg):
*==============================================================================
* SIGREFUNBO.PRG
* Business Object para Relatorio de Tubos Fundicao
*
* Herda de: RelatorioBase
* Entidade: SIGREFUN (Relacao de tubos fundicao)
* Tabelas principais: SigCdFun, SigCdFud, SigCdCor
*==============================================================================

DEFINE CLASS SIGREFUNBO AS RelatorioBase

    *-- Propriedades base (override)
    this_cTabela        = "SigCdFun"
    this_cCampoChave    = "Codigos"
    this_cMensagemErro  = ""

    *-- Filtros do relatorio (mapeados dos controles do form)
    this_nFundI         = 0     && GetFundi - No. Fundicao inicio (InputMask "999999")
    this_nFundF         = 0     && GetFundf - No. Fundicao fim   (InputMask "999999")
    this_lImpObs        = .F.   && ImpObs - Imprimir observacao do item

    *-- Controle interno do relatorio
    this_cNomeRelatorio   = "SIGREFUN"
    this_cCursorDados     = "cursor_4c_Dados"
    this_cTituloRelatorio = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de tubos fundicao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o tubos fundi" + CHR(231) + CHR(227) + "o"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros obrigatorios antes de processar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_nFundI) OR EMPTY(THIS.this_nFundF)
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero de fundi" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Busca e monta dados do relatorio de tubos fundicao
    * Logica original: SigReFun.processamento
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpresa, loc_cTitulo2, loc_nCod, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Cursor de cabecalho para o relatorio
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), ;
                                        Titulo2 C(200), Figura C(10), ImpObs L)

            *-- Nome da empresa a partir do objeto sistema
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            loc_cTitulo2 = "Fundi" + CHR(231) + CHR(227) + "o - " + ;
                           ALLTRIM(STR(THIS.this_nFundI, 6)) + " at" + CHR(233) + " " + ;
                           ALLTRIM(STR(THIS.this_nFundF, 6))

            SELECT csCabecalho
            INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2, ImpObs) ;
                VALUES (loc_cEmpresa, THIS.this_cTituloRelatorio, loc_cTitulo2, THIS.this_lImpObs)

            *-- Cursor de trabalho para montagem do relatorio
            IF USED("Relatorio")
                USE IN Relatorio
            ENDIF
            CREATE CURSOR Relatorio (Codigos N(6), Tubos N(2), bCeras N(12,2), Bases N(12,2), ;
                                      Ceras N(12,2), Metals N(12,2), CodCors C(4), ;
                                      Obss M, Datas D, ObsG M, Qtdos N(10,3), MetalNvs N(12,3))
            INDEX ON STR(Codigos, 6) + STR(Tubos, 2) TAG Tubos
            INDEX ON STR(Codigos, 6) + CodCors + STR(Tubos, 2) TAG Impressao

            *-- Query principal: SigCdFun x SigCdFud x SigCdCor
            loc_cSQL = "SELECT b.*, a.Obss AS ObsG, a.Datas, c.Pesos " + ;
                       "FROM SigCdFun a, SigCdFud b, SigCdCor c " + ;
                       "WHERE a.Codigos BETWEEN " + FormatarNumeroSQL(THIS.this_nFundI) + ;
                       " AND " + FormatarNumeroSQL(THIS.this_nFundF) + ;
                       " AND a.Codigos = b.Codigos" + ;
                       " AND b.Nops = 0 AND b.NNumes = 0 AND b.CodCors = c.Cods" + ;
                       " ORDER BY a.Codigos, b.Tubos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados")

            IF loc_nResult >= 1
                *-- Query secundaria: QtdOs agregado por OS (Nops > 0)
                loc_cSQL = "SELECT b.Codigos, b.Tubos, SUM(b.QtdOs) AS QtdOs " + ;
                           "FROM SigCdFun a, SigCdFud b " + ;
                           "WHERE a.Codigos BETWEEN " + FormatarNumeroSQL(THIS.this_nFundI) + ;
                           " AND " + FormatarNumeroSQL(THIS.this_nFundF) + ;
                           " AND a.Codigos = b.Codigos AND b.Nops > 0 " + ;
                           "GROUP BY b.Codigos, b.Tubos"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTubos")

                IF loc_nResult >= 1
                    *-- Cursor intermediario com transformacoes de tipo
                    SELECT crDados.Codigos, crDados.Tubos, crDados.NNumes, crDados.Nops, ;
                           crDados.Qtds, crDados.QtdOs, crDados.BCeras, crDados.Bases, ;
                           crDados.CodCors, crDados.Metals, crDados.MetalNvs, ;
                           NVL(crDados.Obss, SPACE(100)) AS Obss, ;
                           crDados.TempMets, crDados.TempAmbs, crDados.TempTubs, crDados.TempAgus, ;
                           NVL(crDados.ObsG, SPACE(100)) AS ObsG, ;
                           TTOD(NVL(crDados.Datas, CTOT(""))) AS Datas, ;
                           crDados.Pesos ;
                           FROM crDados ;
                           INTO CURSOR Selecao READWRITE

                    *-- Montar cursor Relatorio via SCAN (logica original preservada)
                    SELECT Selecao
                    GO TOP
                    SCAN
                        loc_nCod = Codigos

                        SELECT Relatorio
                        APPEND BLANK
                        REPLACE Codigos WITH loc_nCod, ;
                                Tubos   WITH 99, ;
                                CodCors WITH "ZZZZ", ;
                                ObsG    WITH Selecao.ObsG

                        SELECT Selecao
                        SCAN WHILE Codigos = loc_nCod
                            SCATTER MEMVAR MEMO
                            m.Ceras = m.bCeras - m.Bases

                            SELECT Relatorio
                            APPEND BLANK
                            GATHER MEMVAR MEMO
                        ENDSCAN
                        SKIP -1
                    ENDSCAN

                    *-- Preencher QtdOs das OS nos registros correspondentes
                    SELECT crTubos
                    SCAN
                        IF SEEK(STR(crTubos.Codigos, 6) + STR(crTubos.Tubos, 2), "Relatorio", "Tubos")
                            REPLACE Relatorio.QtdOs WITH crTubos.QtdOs IN Relatorio
                        ENDIF
                    ENDSCAN

                    SELECT Relatorio
                    GO TOP

                    IF USED("crDados")
                        USE IN crDados
                    ENDIF
                    IF USED("crTubos")
                        USE IN crTubos
                    ENDIF
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar totais de tubos"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar dados de fundi" + CHR(231) + CHR(227) + "o"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cNomeRelatorio) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cNomeRelatorio) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirSilencioso - Imprime relatorio sem dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirSilencioso()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cNomeRelatorio) TO PRINT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores do relatorio ao destruir o objeto
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("Relatorio")
            USE IN Relatorio
        ENDIF
        IF USED("crDados")
            USE IN crDados
        ENDIF
        IF USED("crTubos")
            USE IN crTubos
        ENDIF
        IF USED("Selecao")
            USE IN Selecao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

