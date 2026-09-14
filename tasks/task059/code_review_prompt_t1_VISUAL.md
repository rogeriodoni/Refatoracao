# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [LAYOUT-POSITION] Controle 'lbl_empresa' (parent: SIGRECOG): Top original=160 vs migrado 'lbl_4c_Lbl_empresa' Top=75 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_vendedor' (parent: SIGRECOG): Top original=187 vs migrado 'lbl_4c_Lbl_vendedor' Top=102 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGRECOG): Top original=133 vs migrado 'lbl_4c_Lbl_periodo' Top=48 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo_a' (parent: SIGRECOG): Top original=136 vs migrado 'lbl_4c_Lbl_periodo_a' Top=51 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGRECOG): Top original=214 vs migrado 'lbl_4c_Label6' Top=129 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecog.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1105 linhas total):

*-- Linhas 56 a 64:
56:         loc_lContinuar = .T.
57: 
58:         TRY
59:             THIS.Caption = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
60:                            "o por Grupo de Produto"
61: 
62:             IF TYPE("gc_4c_CaminhoIcones") = "U"
63:                 gc_4c_CaminhoIcones = ""
64:             ENDIF

*-- Linhas 85 a 94:
85:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
86:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
87: 
88:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
89:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
90: 
91:                 THIS.LimparCampos()
92:                 THIS.Visible = .T.
93:                 loc_lSucesso = .T.
94:             ENDIF

*-- Linhas 110 a 149:
110:     PROTECTED PROCEDURE ConfigurarCabecalho()
111:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
112:         WITH THIS.cnt_4c_Cabecalho
113:             .Top         = 0
114:             .Left        = 0
115:             .Width       = THIS.Width
116:             .Height      = 80
117:             .BackStyle   = 1
118:             .BackColor   = RGB(100, 100, 100)
119:             .BorderWidth = 0
120:             .Visible     = .T.
121: 
122:             .AddObject("lbl_4c_Sombra", "Label")
123:             WITH .lbl_4c_Sombra
124:                 .Top       = 22
125:                 .Left      = 22
126:                 .Width     = THIS.Width
127:                 .Height    = 30
128:                 .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
129:                              "o por Grupo de Produto"
130:                 .FontName  = "Tahoma"
131:                 .FontSize  = 14
132:                 .FontBold  = .T.
133:                 .ForeColor = RGB(0, 0, 0)
134:                 .BackStyle = 0
135:                 .Visible   = .T.
136:             ENDWITH
137: 
138:             .AddObject("lbl_4c_Titulo", "Label")
139:             WITH .lbl_4c_Titulo
140:                 .Top       = 20
141:                 .Left      = 20
142:                 .Width     = THIS.Width
143:                 .Height    = 30
144:                 .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
145:                              "o por Grupo de Produto"
146:                 .FontName  = "Tahoma"
147:                 .FontSize  = 14
148:                 .FontBold  = .T.
149:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 164 a 189:
164:     PROTECTED PROCEDURE ConfigurarBotoes()
165:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
166:         WITH THIS.cmg_4c_Botoes
167:             .Top           = 0
168:             .Left          = 529
169:             .Width         = 273
170:             .Height        = 80
171:             .ButtonCount   = 4
172:             .BackStyle     = 0
173:             .BorderStyle   = 0
174:             .BorderColor   = RGB(136, 189, 188)
175:             .SpecialEffect = 1
176:             .Themes        = .F.
177:             .Visible       = .T.
178: 
179:             WITH .Buttons(1)
180:                 .Top             = 5
181:                 .Left            = 5
182:                 .Width           = 65
183:                 .Height          = 70
184:                 .Caption         = "Visualizar"
185:                 .FontBold        = .T.
186:                 .FontItalic      = .T.
187:                 .BackColor       = RGB(255, 255, 255)
188:                 .ForeColor       = RGB(90, 90, 90)
189:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 196 a 208:
196:             ENDWITH
197: 
198:             WITH .Buttons(2)
199:                 .Top             = 5
200:                 .Left            = 71
201:                 .Width           = 65
202:                 .Height          = 70
203:                 .Caption         = "Imprimir"
204:                 .FontName        = "Tahoma"
205:                 .FontBold        = .T.
206:                 .FontItalic      = .T.
207:                 .FontSize        = 8
208:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 217 a 229:
217:             ENDWITH
218: 
219:             WITH .Buttons(3)
220:                 .Top             = 5
221:                 .Left            = 137
222:                 .Width           = 65
223:                 .Height          = 70
224:                 .Caption         = "Documento"
225:                 .FontName        = "Tahoma"
226:                 .FontBold        = .T.
227:                 .FontItalic      = .T.
228:                 .FontSize        = 8
229:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 238 a 250:
238:             ENDWITH
239: 
240:             WITH .Buttons(4)
241:                 .Top             = 5
242:                 .Left            = 203
243:                 .Width           = 65
244:                 .Height          = 70
245:                 .Caption         = "Encerrar"
246:                 .Cancel          = .T.
247:                 .FontName        = "Tahoma"
248:                 .FontBold        = .T.
249:                 .FontItalic      = .T.
250:                 .FontSize        = 8

*-- Linhas 276 a 290:
276: 
277:         loc_oPgf.PageCount = 1
278: 
279:         loc_oPgf.Top    = 85
280:         loc_oPgf.Left   = -1
281:         loc_oPgf.Width  = THIS.Width + 2
282:         loc_oPgf.Height = THIS.Height - 85
283:         loc_oPgf.Tabs   = .F.
284: 
285:         loc_oPgf.Page1.Caption   = "Filtros"
286:         loc_oPgf.Page1.FontName  = "Tahoma"
287:         loc_oPgf.Page1.FontSize  = 8
288:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
289:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
290:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 306 a 390:
306:     *--------------------------------------------------------------------------
307:     * ConfigurarPaginaDados - Primeira metade dos campos de filtro (Page1)
308:     *   Adiciona: Periodo (dt_inicial + dt_final) e Empresa (codigo + descricao)
309:     *   Compensacao de Top: original - 85 (PageFrame.Top = 85)
310:     *   BINDEVENTs dos campos desta metade tambem sao registrados aqui.
311:     *--------------------------------------------------------------------------
312:     PROTECTED PROCEDURE ConfigurarPaginaDados()
313:         LOCAL loc_oPag
314:         loc_oPag = THIS.pgf_4c_Paginas.Page1
315: 
316:         loc_oPag.AddObject("lbl_4c_Lbl_periodo", "Label")
317:         WITH loc_oPag.lbl_4c_Lbl_periodo
318:             .Top       = 48
319:             .Left      = 206
320:             .Width     = 45
321:             .AutoSize  = .T.
322:             .Caption   = "Per" + CHR(237) + "odo :"
323:             .FontName  = "Tahoma"
324:             .FontSize  = 8
325:             .BackStyle = 0
326:             .ForeColor = RGB(90, 90, 90)
327:             .Visible   = .T.
328:         ENDWITH
329: 
330:         loc_oPag.AddObject("txt_4c__dt_inicial", "TextBox")
331:         WITH loc_oPag.txt_4c__dt_inicial
332:             .Top      = 44
333:             .Left     = 255
334:             .Width    = 80
335:             .Height   = 25
336:             .Value    = {}
337:             .FontName = "Courier New"
338:             .FontSize = 9
339:             .Visible  = .T.
340:         ENDWITH
341: 
342:         loc_oPag.AddObject("lbl_4c_Lbl_periodo_a", "Label")
343:         WITH loc_oPag.lbl_4c_Lbl_periodo_a
344:             .Top       = 51
345:             .Left      = 338
346:             .Width     = 8
347:             .AutoSize  = .T.
348:             .Caption   = CHR(224)
349:             .FontName  = "Tahoma"
350:             .FontSize  = 8
351:             .BackStyle = 0
352:             .ForeColor = RGB(90, 90, 90)
353:             .Visible   = .T.
354:         ENDWITH
355: 
356:         loc_oPag.AddObject("txt_4c__dt_final", "TextBox")
357:         WITH loc_oPag.txt_4c__dt_final
358:             .Top      = 44
359:             .Left     = 349
360:             .Width    = 80
361:             .Height   = 25
362:             .Value    = {}
363:             .FontName = "Courier New"
364:             .FontSize = 9
365:             .Visible  = .T.
366:         ENDWITH
367: 
368:         loc_oPag.AddObject("lbl_4c_Lbl_empresa", "Label")
369:         WITH loc_oPag.lbl_4c_Lbl_empresa
370:             .Top       = 75
371:             .Left      = 201
372:             .Width     = 50
373:             .AutoSize  = .T.
374:             .Caption   = "Empresa :"
375:             .FontName  = "Tahoma"
376:             .FontSize  = 8
377:             .BackStyle = 0
378:             .ForeColor = RGB(90, 90, 90)
379:             .Visible   = .T.
380:         ENDWITH
381: 
382:         loc_oPag.AddObject("txt_4c__empresa", "TextBox")
383:         WITH loc_oPag.txt_4c__empresa
384:             .Top       = 71
385:             .Left      = 255
386:             .Width     = 31
387:             .Height    = 25
388:             .Value     = ""
389:             .MaxLength = 3
390:             .Format    = "K"

*-- Linhas 396 a 405:
396: 
397:         loc_oPag.AddObject("txt_4c__empresa_desc", "TextBox")
398:         WITH loc_oPag.txt_4c__empresa_desc
399:             .Top       = 71
400:             .Left      = 288
401:             .Width     = 290
402:             .Height    = 25
403:             .Value     = ""
404:             .MaxLength = 40
405:             .Format    = "!"

*-- Linhas 423 a 448:
423:         LOCAL loc_oPag
424:         loc_oPag = THIS.pgf_4c_Paginas.Page1
425: 
426:         loc_oPag.AddObject("lbl_4c_Lbl_vendedor", "Label")
427:         WITH loc_oPag.lbl_4c_Lbl_vendedor
428:             .Top       = 102
429:             .Left      = 196
430:             .Width     = 55
431:             .AutoSize  = .T.
432:             .Caption   = "Vendedor :"
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .BackStyle = 0
436:             .ForeColor = RGB(90, 90, 90)
437:             .Visible   = .T.
438:         ENDWITH
439: 
440:         loc_oPag.AddObject("txt_4c__vendedor", "TextBox")
441:         WITH loc_oPag.txt_4c__vendedor
442:             .Top       = 98
443:             .Left      = 255
444:             .Width     = 80
445:             .Height    = 25
446:             .Value     = ""
447:             .MaxLength = 10
448:             .Format    = "!"

*-- Linhas 454 a 492:
454: 
455:         loc_oPag.AddObject("txt_4c__vendedor_desc", "TextBox")
456:         WITH loc_oPag.txt_4c__vendedor_desc
457:             .Top       = 98
458:             .Left      = 337
459:             .Width     = 290
460:             .Height    = 25
461:             .Value     = ""
462:             .MaxLength = 40
463:             .Format    = "!"
464:             .FontName  = "Courier New"
465:             .FontSize  = 9
466:             .Visible   = .T.
467:         ENDWITH
468: 
469:         loc_oPag.AddObject("lbl_4c_Label6", "Label")
470:         WITH loc_oPag.lbl_4c_Label6
471:             .Top       = 129
472:             .Left      = 210
473:             .Width     = 41
474:             .Height    = 15
475:             .AutoSize  = .T.
476:             .Caption   = "Moeda :"
477:             .FontName  = "Tahoma"
478:             .FontSize  = 8
479:             .BackStyle = 0
480:             .ForeColor = RGB(90, 90, 90)
481:             .Visible   = .T.
482:         ENDWITH
483: 
484:         loc_oPag.AddObject("txt_4c_Cmoeda", "TextBox")
485:         WITH loc_oPag.txt_4c_Cmoeda
486:             .Top       = 125
487:             .Left      = 255
488:             .Width     = 31
489:             .Height    = 25
490:             .Value     = ""
491:             .MaxLength = 3
492:             .Format    = "K!"

*-- Linhas 498 a 507:
498: 
499:         loc_oPag.AddObject("txt_4c_Dmoeda", "TextBox")
500:         WITH loc_oPag.txt_4c_Dmoeda
501:             .Top       = 125
502:             .Left      = 288
503:             .Width     = 115
504:             .Height    = 25
505:             .Value     = ""
506:             .MaxLength = 15
507:             .Format    = "K!"


### BO (C:\4c\projeto\app\classes\sigrecogBO.prg):
*==============================================================================
* SIGRECOGBO.PRG
* Business Object - Relatorio de Comissao por Grupo de Produto
*
* Herda de RelatorioBase
* Formulario original: SIGRECOG.SCX (frmrelatorio)
* Tabelas principais: SigMvCab, SigMvItn, SigCdOpe, SigCdEmp, SigCdCli, SigCmGri, SigCdPro
*==============================================================================

DEFINE CLASS sigrecogBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial      = {}
    this_dDtFinal        = {}

    *-- Filtro de empresa
    this_cEmpresa        = ""
    this_cRazaEmpresa    = ""

    *-- Filtro de vendedor
    this_cVendedor       = ""
    this_cNomeVendedor   = ""

    *-- Filtro de moeda (codigo e descricao)
    this_cCmoeda         = ""
    this_cDmoeda         = ""

    *-- Metadados do relatorio
    this_cCaminhoFRX     = ""
    this_cTitulo         = ""
    this_cCursorDados    = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * Init - Configura o BO com caminho FRX, titulo e valores iniciais dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        LOCAL loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela      = "SigMvCab"
            THIS.this_cCampoChave  = "empdopnums"
            THIS.this_cCaminhoFRX  = gc_4c_CaminhoReports + "SigReCog.frx"
            THIS.this_cTitulo      = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o por Grupo de Produto"

            THIS.this_dDtInicial    = DATE()
            THIS.this_dDtFinal      = DATE()
            THIS.this_cEmpresa      = ""
            THIS.this_cRazaEmpresa  = ""
            THIS.this_cVendedor     = ""
            THIS.this_cNomeVendedor = ""
            THIS.this_cCmoeda       = ""
            THIS.this_cDmoeda       = ""

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria para a execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = IIF(EMPTY(THIS.this_cEmpresa), "TODAS", ALLTRIM(THIS.this_cEmpresa))
        loc_cChave = loc_cChave + "/" + DTOC(THIS.this_dDtInicial) + ;
                     "/" + DTOC(THIS.this_dDtFinal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChavePrimaria, " + ;
                       "Usuario, DataHora, Empresa) VALUES (" + ;
                       EscaparSQL("SigReCog") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            *-- Auditoria nunca bloqueia operacao principal
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio
    * Replica a PROCEDURE processamento do SIGRECOG.SCX original
    * Gera cursores: cabecalho, sumitens (intermediario), cursor_4c_MvItn, tempo
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo
        LOCAL loc_cEmpresa, loc_cVendedor, loc_cCmoeda
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cWEmpresa, loc_cWVendedor
        LOCAL loc_cCgrus, loc_nComiss, loc_cDopes, loc_cVends
        LOCAL loc_dDatasItn, loc_cEmps, loc_cRazas, loc_cNVens
        LOCAL loc_nTotas, loc_nValos, loc_cMoedas, loc_cEmpDopNums
        LOCAL loc_nTotItes, loc_nFator, loc_nTots, loc_nCot1, loc_nCot2
        LOCAL loc_cChaveGrupo

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.

                loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
                loc_cVendedor = ALLTRIM(THIS.this_cVendedor)
                loc_cCmoeda   = PADR(ALLTRIM(THIS.this_cCmoeda), 3)

                *-- 1. Busca nome da empresa no cabecalho
                loc_cNomeEmpresa = ""
                IF !EMPTY(loc_cEmpresa)
                    loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                               "WHERE Cemps = " + EscaparSQL(loc_cEmpresa)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crCogEmp") > 0 AND ;
                       !EOF("crCogEmp")
                        SELECT crCogEmp
                        loc_cNomeEmpresa = ALLTRIM(Razas)
                    ENDIF
                    IF USED("crCogEmp")
                        USE IN crCogEmp
                    ENDIF
                ENDIF

                loc_cTitulo  = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                               "o de Vendedor por Grupo de Produto"
                loc_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                               DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                               DTOC(THIS.this_dDtFinal)

                *-- 2. Cria cursor de cabecalho do relatorio
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                CREATE CURSOR cabecalho (pNomeEmpresa C(80), pRelTitulo C(80), pPeriodo C(80))
                INSERT INTO cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo)

                *-- 3. Executa query sumitens: soma totas por empdopnums no periodo
                IF USED("sumitens")
                    USE IN sumitens
                ENDIF
                loc_cSQL = "SELECT a.empdopnums, a.datas, " + ;
                           "SUM(b.totas) AS totites " + ;
                           "FROM SigMvCab a " + ;
                           "INNER JOIN SigMvItn b ON b.empdopnums = a.empdopnums " + ;
                           "WHERE a.datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                           " AND a.datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                           " GROUP BY a.empdopnums, a.datas " + ;
                           " ORDER BY a.empdopnums, a.datas"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "sumitens")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (sumitens)"
                    EXIT
                ENDIF
                SELECT sumitens
                INDEX ON empdopnums TAG empdopnums

                *-- 4. Executa query principal: join com comissoes por grupo de produto
                loc_cWEmpresa  = IIF(EMPTY(loc_cEmpresa), "", " AND a.emps = " + EscaparSQL(loc_cEmpresa))
                loc_cWVendedor = IIF(EMPTY(loc_cVendedor), "", " AND a.vends = " + EscaparSQL(loc_cVendedor))

                IF USED("cursor_4c_MvItn")
                    USE IN cursor_4c_MvItn
                ENDIF

                loc_cSQL = "SELECT d.empdopnums AS empdopnums, " + ;
                           "d.totas AS totas, " + ;
                           "d.moedas AS moedas, " + ;
                           "a.dopes AS dopes, " + ;
                           "a.vends AS vends, " + ;
                           "a.datas AS datas, " + ;
                           "a.emps AS emps, " + ;
                           "a.valos AS valos, " + ;
                           "g.cgrus AS cgrus, " + ;
                           "g.comiss AS comiss, " + ;
                           "e.razas AS razas, " + ;
                           "f.rclis AS nvens " + ;
                           "FROM SigMvItn d " + ;
                           "INNER JOIN SigMvCab a ON d.empdopnums = a.empdopnums " + ;
                           "INNER JOIN SigCdOpe b ON a.dopes = b.dopes " + ;
                           "INNER JOIN SigCdEmp e ON e.cemps = a.emps " + ;
                           "INNER JOIN SigCdCli f ON f.iclis = a.vends " + ;
                           "INNER JOIN SigCdPro h ON d.cpros = h.cpros " + ;
                           "INNER JOIN SigCmGri g ON g.cgrus = h.cgrus " + ;
                           "WHERE a.datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                           " AND a.datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                           " AND b.results = 1 " + ;
                           " AND b.ccomis = 1 " + ;
                           loc_cWEmpresa + ;
                           loc_cWVendedor
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvItn")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_MvItn)"
                    EXIT
                ENDIF

                *-- 5. Cria cursor Tempo: agrupa por cgrus/comiss/dopes/vends/datas/emps
                *--    aplicando conversao de moeda via BuscarCotacao
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                CREATE CURSOR tempo (Cgrus C(3), Comiss N(8,2), Dopes C(20), ;
                                     Vends C(10), Datas D, Emps C(3), ;
                                     Razas C(40), NVens C(50), Tots N(11,2))
                INDEX ON PADR(Cgrus,3) + STR(Comiss,8,2) + PADR(Dopes,20) + ;
                         PADR(Vends,10) + DTOS(Datas) + PADR(Emps,3) TAG grpchave

                SELECT cursor_4c_MvItn
                GO TOP
                SCAN
                    loc_cCgrus      = ALLTRIM(cursor_4c_MvItn.Cgrus)
                    loc_nComiss     = NVL(cursor_4c_MvItn.Comiss, 0)
                    loc_cDopes      = ALLTRIM(cursor_4c_MvItn.Dopes)
                    loc_cVends      = ALLTRIM(cursor_4c_MvItn.Vends)
                    loc_dDatasItn   = CTOD(DTOC(cursor_4c_MvItn.Datas))
                    loc_cEmps       = ALLTRIM(cursor_4c_MvItn.Emps)
                    loc_cRazas      = ALLTRIM(cursor_4c_MvItn.Razas)
                    loc_cNVens      = ALLTRIM(cursor_4c_MvItn.NVens)
                    loc_nTotas      = NVL(cursor_4c_MvItn.Totas, 0)
                    loc_nValos      = NVL(cursor_4c_MvItn.Valos, 0)
                    loc_cMoedas     = PADR(ALLTRIM(NVL(cursor_4c_MvItn.Moedas, "")), 3)
                    loc_cEmpDopNums = ALLTRIM(cursor_4c_MvItn.EmpDopNums)

                    *-- Busca total de itens do documento em sumitens
                    loc_nTotItes = 0
                    SELECT sumitens
                    IF SEEK(PADR(loc_cEmpDopNums, 29), "sumitens", "empdopnums")
                        loc_nTotItes = NVL(sumitens.totites, 0)
                    ENDIF
                    SELECT cursor_4c_MvItn

                    *-- Calcula fator de conversao de moeda
                    IF EMPTY(ALLTRIM(loc_cMoedas)) OR loc_cMoedas = loc_cCmoeda
                        loc_nFator = 1
                    ELSE
                        loc_nCot1  = THIS.BuscarCotacao(ALLTRIM(loc_cMoedas), loc_dDatasItn)
                        loc_nCot2  = IIF(EMPTY(ALLTRIM(loc_cCmoeda)), 1, ;
                                         THIS.BuscarCotacao(ALLTRIM(loc_cCmoeda), loc_dDatasItn))
                        loc_nFator = IIF(loc_nCot2 > 0, loc_nCot1 / loc_nCot2, loc_nCot1)
                    ENDIF

                    *-- Calcula valor de comissao proporcional do item
                    loc_nTots = ROUND(IIF(loc_nTotItes > 0, ;
                                         loc_nTotas / loc_nTotItes, 0) * ;
                                      loc_nValos * loc_nFator, 2)

                    *-- Chave de grupo para SEEK no cursor Tempo
                    loc_cChaveGrupo = PADR(loc_cCgrus, 3) + STR(loc_nComiss, 8, 2) + ;
                                      PADR(loc_cDopes, 20) + PADR(loc_cVends, 10) + ;
                                      DTOS(loc_dDatasItn) + PADR(loc_cEmps, 3)

                    SELECT tempo
                    IF SEEK(loc_cChaveGrupo, "tempo", "grpchave")
                        REPLACE Tots WITH tempo.Tots + loc_nTots IN tempo
                    ELSE
                        INSERT INTO tempo (Cgrus, Comiss, Dopes, Vends, Datas, ;
                                           Emps, Razas, NVens, Tots) ;
                            VALUES (loc_cCgrus, loc_nComiss, loc_cDopes, loc_cVends, ;
                                    loc_dDatasItn, loc_cEmps, ;
                                    loc_cRazas, loc_cNVens, loc_nTots)
                    ENDIF

                    SELECT cursor_4c_MvItn
                ENDSCAN

                *-- Ordena Tempo para o relatorio (Emps, Vends, Cgrus)
                SELECT tempo
                INDEX ON PADR(Emps,3) + PADR(Vends,10) + PADR(Cgrus,3) TAG relchave
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Preparar Dados do Relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Comissao por Grupo de
    * Produto nao ha parametros persistidos: as datas iniciam em DATE() e os
    * demais filtros ficam vazios para selecao via lookup. Mantido por
    * contrato (validador da pipeline e RelatorioBase).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + CHR(227) + ;
                                       "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Comissao por Grupo de Produto eh apenas leitura: consulta SigMvCab,
    * SigMvItn, SigCmGri e gera preview/impressao via REPORT FORM. Retorna
    * .F. para satisfazer o contrato de BO e sinalizar que a operacao nao
    * se aplica a este BO.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Comiss" + CHR(227) + "o por Grupo de Produto (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Ver observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Comiss" + CHR(227) + "o por Grupo de Produto (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores criados por PrepararDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursores()
        IF USED("cabecalho")
            USE IN cabecalho
        ENDIF
        IF USED("sumitens")
            USE IN sumitens
        ENDIF
        IF USED("tempo")
            USE IN tempo
        ENDIF
        IF USED("cursor_4c_MvItn")
            USE IN cursor_4c_MvItn
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime diretamente na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e gera documento (exporta para impressora)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER NOCONSOLE
                THIS.RegistrarAuditoria("EXPORTAR")
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMoedas - Carrega SigCdMoe em cursor para uso nos lookups do form
    * Retorna .T. se sucesso, cursor disponivel como "cursor_4c_Moedas"
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMoedas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Moedas")
                USE IN cursor_4c_Moedas
            ENDIF
            loc_cSQL = "SELECT cmoes, dmoes, cotas, datatrans, fmults, " + ;
                       "nordrels, disfpres, valadics, grumoes, moeqs, " + ;
                       "qtdeqs, submoes " + ;
                       "FROM SigCdMoe " + ;
                       "ORDER BY cmoes, dmoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moedas")
            IF loc_nResult > 0
                SELECT cursor_4c_Moedas
                INDEX ON cmoes TAG cmoes
                INDEX ON dmoes TAG dmoes
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar moedas"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Carregar Moedas")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca taxa de cambio da moeda para a data informada
    * Substitui fBuscarCotacao() do sistema legado
    * Tabela: SigCdCot (cmoes, datas, horas, valos)
    * Retorna 1.0 se moeda nao encontrada (fallback seguro)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nTaxa, loc_cSQL, loc_nResult, loc_cMoeda, loc_cFiltroData

        loc_nTaxa  = 1.0
        loc_cMoeda = ALLTRIM(par_cMoeda)

        IF EMPTY(loc_cMoeda) OR loc_cMoeda = "R"
            RETURN loc_nTaxa
        ENDIF

        IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
            loc_cFiltroData = "datas <= GETDATE()"
        ELSE
            loc_cFiltroData = "datas <= DATEADD(day, 1, " + FormatarDataSQL(par_dData) + ")"
        ENDIF

        loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                   "WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
                   " AND " + loc_cFiltroData + ;
                   " ORDER BY datas DESC, horas DESC"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CogCot")
        IF loc_nResult > 0 AND !EOF("cursor_4c_CogCot")
            SELECT cursor_4c_CogCot
            IF NVL(valos, 0) > 0
                loc_nTaxa = valos
            ENDIF
        ENDIF

        IF USED("cursor_4c_CogCot")
            USE IN cursor_4c_CogCot
        ENDIF

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

