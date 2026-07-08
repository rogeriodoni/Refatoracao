# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 231: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 276: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCgc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (731 linhas total):

*-- Linhas 76 a 84:
76:         loc_lSucesso   = .F.
77:         loc_lContinuar = .T.
78:         TRY
79:             THIS.Caption = "Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras"
80: 
81:             IF TYPE("gc_4c_CaminhoIcones") = "U"
82:                 gc_4c_CaminhoIcones = ""
83:             ENDIF
84:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 111 a 120:
111:                 *-- Vincula handlers dos botoes (deve vir apos ConfigurarBotoes + ConfigurarPaginaFiltros)
112:                 THIS.ConfigurarBindevents()
113: 
114:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
115:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
116: 
117:                 *-- Inicializa campos com valores padrao
118:                 THIS.LimparCampos()
119: 
120:                 THIS.Visible = .T.

*-- Linhas 137 a 215:
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
156:                 .Caption   = "Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras"
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
172:                 .Caption   = "Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras"
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
184:     * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport area)
185:     *   Original: btnReport.Left=525, Top=3, Width=305, Height=85 (+ 4 botoes)
186:     *   Geometria EXATA do framework frmrelatorio: Buttons(1-4), Left increments 66px.
187:     *   BINDEVENTs dos botoes sao vinculados nas fases 7-8.
188:     *--------------------------------------------------------------------------
189:     PROTECTED PROCEDURE ConfigurarBotoes()
190:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
191:         WITH THIS.cmg_4c_Botoes
192:             .Top           = 0
193:             .Left          = 529
194:             .Width         = 273
195:             .Height        = 80
196:             .ButtonCount   = 4
197:             .BackStyle     = 0
198:             .BorderStyle   = 0
199:             .BorderColor   = RGB(136, 189, 188)
200:             .SpecialEffect = 1
201:             .Themes        = .F.
202:             .Visible       = .T.
203: 
204:             *-- Visualizar (preview em tela) - equivale a btnReport.Visualiza
205:             WITH .Buttons(1)
206:                 .Top             = 5
207:                 .Left            = 5
208:                 .Width           = 65
209:                 .Height          = 70
210:                 .Caption         = "Visualizar"
211:                 .FontBold        = .T.
212:                 .FontItalic      = .T.
213:                 .BackColor       = RGB(255, 255, 255)
214:                 .ForeColor       = RGB(90, 90, 90)
215:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 223 a 237:
223: 
224:             *-- Imprimir (impressora com dialogo) - equivale a btnReport.Imprime
225:             WITH .Buttons(2)
226:                 .Top             = 5
227:                 .Left            = 71
228:                 .Width           = 65
229:                 .Height          = 70
230:                 .Caption         = "Imprimir"
231:                 .FontName        = "Comic Sans MS"
232:                 .FontBold        = .T.
233:                 .FontItalic      = .T.
234:                 .FontSize        = 8
235:                 .BackColor       = RGB(255, 255, 255)
236:                 .ForeColor       = RGB(90, 90, 90)
237:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 245 a 259:
245: 
246:             *-- Excel (exportar cursor para XLS) - equivale a btnReport.DocExcel
247:             WITH .Buttons(3)
248:                 .Top             = 5
249:                 .Left            = 137
250:                 .Width           = 65
251:                 .Height          = 70
252:                 .Caption         = "Excel"
253:                 .FontName        = "Comic Sans MS"
254:                 .FontBold        = .T.
255:                 .FontItalic      = .T.
256:                 .FontSize        = 8
257:                 .BackColor       = RGB(255, 255, 255)
258:                 .ForeColor       = RGB(90, 90, 90)
259:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 267 a 282:
267: 
268:             *-- Encerrar (fechar form) - equivale a btnReport.Sair
269:             WITH .Buttons(4)
270:                 .Top             = 5
271:                 .Left            = 203
272:                 .Width           = 65
273:                 .Height          = 70
274:                 .Caption         = "Encerrar"
275:                 .Cancel          = .T.
276:                 .FontName        = "Comic Sans MS"
277:                 .FontBold        = .T.
278:                 .FontItalic      = .T.
279:                 .FontSize        = 8
280:                 .BackColor       = RGB(255, 255, 255)
281:                 .ForeColor       = RGB(90, 90, 90)
282:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 308 a 323:
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

*-- Linhas 340 a 376:
340:         *-- Shape decorativo ao redor do periodo (shpImprimir original: top=156, left=129)
341:         loc_oPag.AddObject("shp_4c_ShpImprimir", "Shape")
342:         WITH loc_oPag.shp_4c_ShpImprimir
343:             .Top         = 71
344:             .Left        = 129
345:             .Width       = 394
346:             .Height      = 50
347:             .BackStyle   = 0
348:             .BorderColor = RGB(128, 128, 128)
349:             .Visible     = .T.
350:         ENDWITH
351: 
352:         *-- Label "Periodo :" (Say1 original: top=174, left=147)
353:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
354:         WITH loc_oPag.lbl_4c_Label1
355:             .Top       = 89
356:             .Left      = 147
357:             .Width     = 48
358:             .Height    = 18
359:             .Caption   = "Per" + CHR(237) + "odo :"
360:             .FontName  = "Tahoma"
361:             .FontSize  = 8
362:             .ForeColor = RGB(90, 90, 90)
363:             .BackStyle = 0
364:             .Visible   = .T.
365:         ENDWITH
366: 
367:         *-- TextBox data inicial (getDtIni original: top=171, left=196)
368:         loc_oPag.AddObject("txt_4c_DtIni", "TextBox")
369:         WITH loc_oPag.txt_4c_DtIni
370:             .Top         = 86
371:             .Left        = 196
372:             .Width       = 82
373:             .Height      = 21
374:             .Value       = {}
375:             .FontName    = "Tahoma"
376:             .FontSize    = 8

*-- Linhas 383 a 409:
383:         ENDWITH
384: 
385:         *-- Label separador "-" (Say4 original: top=174, left=280)
386:         loc_oPag.AddObject("lbl_4c_Label4", "Label")
387:         WITH loc_oPag.lbl_4c_Label4
388:             .Top       = 89
389:             .Left      = 280
390:             .Width     = 10
391:             .Height    = 18
392:             .Caption   = "-"
393:             .FontName  = "Tahoma"
394:             .FontSize  = 8
395:             .ForeColor = RGB(90, 90, 90)
396:             .BackStyle = 0
397:             .Visible   = .T.
398:         ENDWITH
399: 
400:         *-- TextBox data final (getDtFin original: top=171, left=292)
401:         loc_oPag.AddObject("txt_4c_DtFin", "TextBox")
402:         WITH loc_oPag.txt_4c_DtFin
403:             .Top         = 86
404:             .Left        = 292
405:             .Width       = 82
406:             .Height      = 21
407:             .Value       = {}
408:             .FontName    = "Tahoma"
409:             .FontSize    = 8

*-- Linhas 419 a 453:
419:         *   Value=1 -> Emissao ('D'), Value=2 -> Vencimento ('V')
420:         loc_oPag.AddObject("obj_4c_OptDatas", "OptionGroup")
421:         WITH loc_oPag.obj_4c_OptDatas
422:             .Top         = 83
423:             .Left        = 372
424:             .Width       = 148
425:             .Height      = 27
426:             .ButtonCount = 2
427:             .BackStyle   = 0
428:             .BorderStyle = 0
429:             .Value       = 1
430:             .Visible     = .T.
431: 
432:             WITH .Buttons(1)
433:                 .Top       = 5
434:                 .Left      = 5
435:                 .Width     = 44
436:                 .Height    = 17
437:                 .Caption   = "Data"
438:                 .ForeColor = RGB(90, 90, 90)
439:                 .BackStyle = 0
440:                 .Visible   = .T.
441:             ENDWITH
442: 
443:             WITH .Buttons(2)
444:                 .Top       = 5
445:                 .Left      = 60
446:                 .Width     = 83
447:                 .Height    = 17
448:                 .Caption   = "Vencimento"
449:                 .FontName  = "Tahoma"
450:                 .FontSize  = 8
451:                 .ForeColor = RGB(90, 90, 90)
452:                 .BackStyle = 0
453:                 .Visible   = .T.


### BO (C:\4c\projeto\app\classes\SigReCgcBO.prg):
*==============================================================================
* SIGRECGCBO.PRG
* Business Object para Relatorio Generico de Compras
* Original: SigReCgc.SCX (frmrelatorio)
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS SigReCgcBO AS RelatorioBase

    *-- Propriedades padrao herdadas (sobrescritas)
    this_cTabela          = "dbHistorico"
    this_cCampoChave      = ""
    this_cMensagemErro    = ""

    *-- Propriedades de filtro (populadas pelo form via FormParaRelatorio)
    *-- Equivalente a ThisForm.getDtIni.Value
    this_dDtIni           = {}
    *-- Equivalente a ThisForm.getDtFin.Value
    this_dDtFin           = {}
    *-- Equivalente a ThisForm.optDatas.Value (1=Data Emissao, 2=Vencimento)
    this_nOptDatas        = 1

    *-- Parametros recebidos do form chamador (pGru, pCon do Init original)
    this_cGrupo           = ""
    this_cConta           = ""

    *-- Caminho do FRX e titulo do relatorio
    this_cArquivoFRX      = ""
    this_cTituloRelatorio = "RELAT" + CHR(211) + "RIO GEN" + CHR(201) + "RICO DE COMPRAS"

    *-- Cursores utilizados pelo relatorio
    this_cCursorDados     = "cursor_4c_TmpRel"
    this_cCursorCabecalho = "cursor_4c_CsCabecalho"
    this_cCursorMoedas    = "cursor_4c_TmpMoe"
    this_cCursorTotal     = "cursor_4c_CsTotal"

    *-- Estado interno
    this_lDadosCarregados = .F.

    *--------------------------------------------------------------------------
    * Init - Construtor do BO
    * Define caminho do FRX (resolvido em runtime via gc_4c_CaminhoReports)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            IF TYPE("gc_4c_CaminhoReports") = "C"
                THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "SigReCgc.frx"
            ELSE
                THIS.this_cArquivoFRX = "reports\SigReCgc.frx"
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores para o relatorio (equivale a processamento)
    * 1. Obtem empresa (SigCdEmp)
    * 2. Obtem descricao da conta (SigCdCli.rclis)
    * 3. Cria cursor_4c_CsCabecalho com titulo/subtitulo/empresa/periodo
    * 4. SQLEXEC dbHistorico filtrado por Datas ou Vencs
    * 5. GROUP BY moedas -> cursor_4c_TmpMoe com soma por moeda
    * 6. Formata total acumulado em cursor_4c_CsTotal (memo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lcDatas, loc_lcCampData, loc_lcEmpresa, loc_lcCon
        LOCAL loc_lcTitulo, loc_lcSubTit, loc_lcPeriodo
        LOCAL loc_nValores, loc_cMoedas

        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""

            *-- Tipo de data (D=Emissao, V=Vencimento)
            loc_lcDatas    = IIF(THIS.this_nOptDatas = 1, "D", "V")
            loc_lcCampData = IIF(THIS.this_nOptDatas = 1, "Datas", "Vencs")

            *-- Razao social da empresa via SigCdEmp
            loc_lcEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                       EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRecGcEmp") > 0
                SELECT cursor_4c_SigRecGcEmp
                IF !EOF()
                    loc_lcEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                                    " - " + ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_SigRecGcEmp
            ENDIF

            *-- Descricao da conta (iclis/rclis de SigCdCli)
            loc_lcCon = ""
            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cSQL = "SELECT TOP 1 rclis FROM SigCdCli WHERE iclis = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cConta))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRecGcCli") > 0
                    SELECT cursor_4c_SigRecGcCli
                    IF !EOF()
                        loc_lcCon = " - " + ALLTRIM(rclis)
                    ENDIF
                    USE IN cursor_4c_SigRecGcCli
                ENDIF
            ENDIF

            *-- Monta strings do cabecalho (CHR() para acentos - regra VFP9)
            loc_lcTitulo  = "RELAT" + CHR(211) + "RIO GEN" + CHR(201) + "RICO DE COMPRAS"
            loc_lcSubTit  = "GRUPO : " + ALLTRIM(THIS.this_cGrupo) + ;
                            "/CONTA : " + ALLTRIM(THIS.this_cConta) + loc_lcCon
            loc_lcPeriodo = "PER" + CHR(205) + "ODO DE " + DTOC(THIS.this_dDtIni) + ;
                            " " + CHR(224) + " " + DTOC(THIS.this_dDtFin)

            *-- Cursor de cabecalho
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                (Titulo C(200), SubTit C(200), Empresa C(80), Periodo C(35), Datar C(1))
            INSERT INTO (THIS.this_cCursorCabecalho) ;
                (Titulo, SubTit, Empresa, Periodo, Datar) ;
                VALUES (loc_lcTitulo, loc_lcSubTit, loc_lcEmpresa, loc_lcPeriodo, loc_lcDatas)

            *-- Dados do historico filtrados por data via SQLEXEC
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            loc_cSQL = "SELECT *, 'X' AS X FROM dbHistorico" + ;
                       " WHERE " + loc_lcCampData + ;
                       " BETWEEN " + FormatarDataSQL(THIS.this_dDtIni) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDtFin) + ;
                       " ORDER BY " + loc_lcCampData
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados do hist" + CHR(243) + "rico"
                loc_lSucesso = .F.
            ENDIF

            *-- Totais por moeda (SELECT nativo no cursor VFP)
            IF USED(THIS.this_cCursorMoedas)
                USE IN (THIS.this_cCursorMoedas)
            ENDIF
            SELECT SUM(valors) AS valores, moedas ;
                FROM (THIS.this_cCursorDados) ;
                GROUP BY moedas ;
                INTO CURSOR (THIS.this_cCursorMoedas) READWRITE

            *-- Cursor de total acumulado formatado por moeda
            IF USED(THIS.this_cCursorTotal)
                USE IN (THIS.this_cCursorTotal)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorTotal) (Total M(4))
            SELECT (THIS.this_cCursorTotal)
            APPEND BLANK

            *-- Itera TmpMoe montando string formatada de totais
            SELECT (THIS.this_cCursorMoedas)
            GO TOP
            DO WHILE !EOF()
                loc_nValores = valores
                loc_cMoedas  = ALLTRIM(moedas)
                SELECT (THIS.this_cCursorTotal)
                REPLACE Total WITH Total + ;
                    TRANSFORM(loc_nValores, "999,999,999,999.99") + ;
                    " " + loc_cMoedas + CHR(13)
                SELECT (THIS.this_cCursorMoedas)
                SKIP
            ENDDO

            *-- Posiciona no inicio para o REPORT FORM
            SELECT (THIS.this_cCursorDados)
            GO TOP

            THIS.this_lDadosCarregados = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora (COM dialogo de impressora)
    * Equivale a PROCEDURE impressao do original
    *--------------------------------------------------------------------------
    FUNCTION Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFRX) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    * Equivale a PROCEDURE visualizacao do original
    *--------------------------------------------------------------------------
    FUNCTION Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores do relatorio se estiverem abertos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursores()
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorMoedas)
            USE IN (THIS.this_cCursorMoedas)
        ENDIF
        IF USED(THIS.this_cCursorTotal)
            USE IN (THIS.this_cCursorTotal)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    * Stub para compatibilidade com RelatorioBase.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * BOs de Relatorio populam dados via PrepararDados() -> cursor_4c_TmpRel,
    * nao precisam carregar registro individual do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao inserem registros no banco.
    * Operacao real e executada por Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao atualizam registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao excluem registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorios nao geram registros de auditoria
    * Override do RelatorioBase para deixar explicito.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta para arquivo XLS
    *   Equivale ao DocExcel do frmrelatorio framework (Buttons(3)).
    *   NAO valida datas: no original "If This.Value # 3" pula a validacao
    *   para o botao DocExcel (botao 3), reproducindo esse comportamento.
    *--------------------------------------------------------------------------
    FUNCTION ExportarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oShell
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados)
                    loc_cArquivo = ADDBS(SYS(5) + SYS(2003)) + ;
                                   "SigReCgc_" + STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    COPY TO (loc_cArquivo) TYPE XLS
                    IF FILE(loc_cArquivo)
                        loc_oShell = CREATEOBJECT("WScript.Shell")
                        IF VARTYPE(loc_oShell) = "O"
                            loc_oShell.Run(SHORTPATH(loc_cArquivo))
                            loc_oShell = .NULL.
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao criar arquivo Excel"
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ExportarExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao encerrar BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

