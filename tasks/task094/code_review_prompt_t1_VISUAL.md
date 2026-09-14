# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Envelope' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpRelat' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cabecalho' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEvd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1041 linhas total):

*-- Linhas 64 a 72:
64:         loc_lSucesso   = .F.
65:         loc_lContinuar = .T.
66:         TRY
67:             THIS.Caption = "Demonstrativo de Envelopes Duplicados"
68: 
69:             IF TYPE("gc_4c_CaminhoIcones") = "U"
70:                 gc_4c_CaminhoIcones = ""
71:             ENDIF
72:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 92 a 101:
92:                 THIS.ConfigurarPageFrame()
93:                 THIS.ConfigurarPaginaLista()
94: 
95:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
96:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
97: 
98:                 THIS.LimparCampos()
99:                 THIS.Visible = .T.
100:                 loc_lSucesso = .T.
101:             ENDIF

*-- Linhas 116 a 194:
116:     PROTECTED PROCEDURE ConfigurarCabecalho()
117:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH THIS.cnt_4c_Cabecalho
119:             .Top         = 0
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackStyle   = 1
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127: 
128:             *-- Sombra deslocada 2px para efeito 3D do texto
129:             .AddObject("lbl_4c_Sombra", "Label")
130:             WITH .lbl_4c_Sombra
131:                 .Top       = 22
132:                 .Left      = 22
133:                 .Width     = THIS.Width
134:                 .Height    = 30
135:                 .Caption   = "Demonstrativo de Envelopes Duplicados"
136:                 .FontName  = "Tahoma"
137:                 .FontSize  = 14
138:                 .FontBold  = .T.
139:                 .ForeColor = RGB(0, 0, 0)
140:                 .BackStyle = 0
141:                 .Visible   = .T.
142:             ENDWITH
143: 
144:             *-- Titulo branco (sobre a sombra)
145:             .AddObject("lbl_4c_Titulo", "Label")
146:             WITH .lbl_4c_Titulo
147:                 .Top       = 20
148:                 .Left      = 20
149:                 .Width     = THIS.Width
150:                 .Height    = 30
151:                 .Caption   = "Demonstrativo de Envelopes Duplicados"
152:                 .FontName  = "Tahoma"
153:                 .FontSize  = 14
154:                 .FontBold  = .T.
155:                 .ForeColor = RGB(255, 255, 255)
156:                 .BackStyle = 0
157:                 .Visible   = .T.
158:             ENDWITH
159:         ENDWITH
160:     ENDPROC
161: 
162:     *--------------------------------------------------------------------------
163:     * ConfigurarBotoes - CommandGroup de relatorio (equivalente a btnReport).
164:     *   Original SIGREEVD: btnReport.Left=525, Top=3.
165:     *   Geometria canonica frmrelatorio: cmg_4c_Botoes.Left=529, Top=0.
166:     *   BINDEVENT dos clicks adicionados em InicializarForm (Fase 7).
167:     *--------------------------------------------------------------------------
168:     PROTECTED PROCEDURE ConfigurarBotoes()
169:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
170:         WITH THIS.cmg_4c_Botoes
171:             .Top           = 0
172:             .Left          = 529
173:             .Width         = 273
174:             .Height        = 80
175:             .ButtonCount   = 4
176:             .BackStyle     = 0
177:             .BorderStyle   = 0
178:             .BorderColor   = RGB(136, 189, 188)
179:             .SpecialEffect = 1
180:             .Themes        = .F.
181:             .Visible       = .T.
182: 
183:             *-- Visualizar (preview em tela)
184:             WITH .Buttons(1)
185:                 .Top             = 5
186:                 .Left            = 5
187:                 .Width           = 65
188:                 .Height          = 70
189:                 .Caption         = "Visualizar"
190:                 .FontBold        = .T.
191:                 .FontItalic      = .T.
192:                 .BackColor       = RGB(255, 255, 255)
193:                 .ForeColor       = RGB(90, 90, 90)
194:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 202 a 214:
202: 
203:             *-- Imprimir (impressora)
204:             WITH .Buttons(2)
205:                 .Top             = 5
206:                 .Left            = 71
207:                 .Width           = 65
208:                 .Height          = 70
209:                 .Caption         = "Imprimir"
210:                 .FontName        = "Tahoma"
211:                 .FontBold        = .T.
212:                 .FontItalic      = .T.
213:                 .FontSize        = 8
214:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 224 a 236:
224: 
225:             *-- Excel (exportar)
226:             WITH .Buttons(3)
227:                 .Top             = 5
228:                 .Left            = 137
229:                 .Width           = 65
230:                 .Height          = 70
231:                 .Caption         = "Excel"
232:                 .FontName        = "Tahoma"
233:                 .FontBold        = .T.
234:                 .FontItalic      = .T.
235:                 .FontSize        = 8
236:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 246 a 258:
246: 
247:             *-- Encerrar (ESC fecha o form)
248:             WITH .Buttons(4)
249:                 .Top             = 5
250:                 .Left            = 203
251:                 .Width           = 65
252:                 .Height          = 70
253:                 .Caption         = "Encerrar"
254:                 .Cancel          = .T.
255:                 .FontName        = "Tahoma"
256:                 .FontBold        = .T.
257:                 .FontItalic      = .T.
258:                 .FontSize        = 8

*-- Linhas 282 a 296:
282: 
283:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
284:         loc_oPgf.PageCount = 1
285:         loc_oPgf.Top       = 85
286:         loc_oPgf.Left      = -1
287:         loc_oPgf.Width     = THIS.Width + 2
288:         loc_oPgf.Height    = THIS.Height - 85
289:         loc_oPgf.Tabs      = .F.
290: 
291:         loc_oPgf.Page1.Caption   = "Filtros"
292:         loc_oPgf.Page1.FontName  = "Tahoma"
293:         loc_oPgf.Page1.FontSize  = 8
294:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
295:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
296:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 323 a 388:
323:         loc_oPg = THIS.pgf_4c_Paginas.Page1
324: 
325:         *-- GRUPO: Say2 (form Top=134 -> page Top=49), Get_grupo (form Top=132 -> page Top=47)
326:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
327:         WITH loc_oPg.lbl_4c_Label2
328:             .Top       = 49
329:             .Left      = 233
330:             .Width     = 41
331:             .Height    = 18
332:             .Caption   = "Grupo : "
333:             .FontName  = "Tahoma"
334:             .FontSize  = 8
335:             .ForeColor = RGB(90, 90, 90)
336:             .BackStyle = 0
337:             .Visible   = .T.
338:         ENDWITH
339: 
340:         loc_oPg.AddObject("txt_4c_Grupo", "TextBox")
341:         WITH loc_oPg.txt_4c_Grupo
342:             .Top      = 47
343:             .Left     = 277
344:             .Width    = 82
345:             .Height   = 23
346:             .Value    = ""
347:             .FontName = "Tahoma"
348:             .FontSize = 8
349:             .Visible  = .T.
350:         ENDWITH
351: 
352:         *-- CONTA: Say3 (form Top=160 -> page Top=75), Get_conta (form Top=157 -> page Top=72)
353:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
354:         WITH loc_oPg.lbl_4c_Label3
355:             .Top       = 75
356:             .Left      = 233
357:             .Width     = 41
358:             .Height    = 18
359:             .Caption   = "Conta : "
360:             .FontName  = "Tahoma"
361:             .FontSize  = 8
362:             .ForeColor = RGB(90, 90, 90)
363:             .BackStyle = 0
364:             .Visible   = .T.
365:         ENDWITH
366: 
367:         loc_oPg.AddObject("txt_4c_Conta", "TextBox")
368:         WITH loc_oPg.txt_4c_Conta
369:             .Top      = 72
370:             .Left     = 277
371:             .Width    = 82
372:             .Height   = 23
373:             .Value    = ""
374:             .FontName = "Tahoma"
375:             .FontSize = 8
376:             .Visible  = .T.
377:         ENDWITH
378: 
379:         *-- DCONTA (descricao cliente RClis): Get_dconta (form Top=157 -> page Top=72, Left=360 -> 361)
380:         loc_oPg.AddObject("txt_4c_Dconta", "TextBox")
381:         WITH loc_oPg.txt_4c_Dconta
382:             .Top      = 72
383:             .Left     = 361
384:             .Width    = 216
385:             .Height   = 23
386:             .Value    = ""
387:             .FontName = "Tahoma"
388:             .FontSize = 8

*-- Linhas 403 a 466:
403:     *   Form REPORT eh FLAT (1 pagina). Este metodo eh chamado por
404:     *   ConfigurarPaginaLista para completar a Page1 com os filtros de data.
405:     *   Posicoes relativas ao Page1:
406:     *     lbl_4c_Conta (Periodo): form Top=186 -> page Top=101
407:     *     txt_4c_Datai:           form Top=181 -> page Top=96
408:     *     lbl_4c_Label1 ("ate"):  form Top=186 -> page Top=101
409:     *     txt_4c_Dataf:           form Top=181 -> page Top=96
410:     *--------------------------------------------------------------------------
411:     PROTECTED PROCEDURE ConfigurarPaginaDados()
412:         LOCAL loc_oPg
413:         loc_oPg = THIS.pgf_4c_Paginas.Page1
414: 
415:         *-- PERIODO: Say_Conta (form Top=186 -> page Top=101), Get_Datai (form Top=181 -> page Top=96)
416:         loc_oPg.AddObject("lbl_4c_Conta", "Label")
417:         WITH loc_oPg.lbl_4c_Conta
418:             .Top       = 101
419:             .Left      = 226
420:             .Width     = 48
421:             .Height    = 18
422:             .Caption   = "Per" + CHR(237) + "odo : "
423:             .FontName  = "Tahoma"
424:             .FontSize  = 8
425:             .ForeColor = RGB(90, 90, 90)
426:             .BackStyle = 0
427:             .Visible   = .T.
428:         ENDWITH
429: 
430:         loc_oPg.AddObject("txt_4c_Datai", "TextBox")
431:         WITH loc_oPg.txt_4c_Datai
432:             .Top      = 96
433:             .Left     = 277
434:             .Width    = 82
435:             .Height   = 23
436:             .Value    = {}
437:             .Format   = "D"
438:             .FontName = "Tahoma"
439:             .FontSize = 8
440:             .Visible  = .T.
441:         ENDWITH
442: 
443:         *-- Say1 (" ate "): form Top=186 -> page Top=101, Left=360 -> 361
444:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
445:         WITH loc_oPg.lbl_4c_Label1
446:             .Top       = 101
447:             .Left      = 361
448:             .Width     = 24
449:             .Height    = 18
450:             .Caption   = " at" + CHR(233) + " "
451:             .FontName  = "Tahoma"
452:             .FontSize  = 8
453:             .ForeColor = RGB(90, 90, 90)
454:             .BackStyle = 0
455:             .Visible   = .T.
456:         ENDWITH
457: 
458:         loc_oPg.AddObject("txt_4c_Dataf", "TextBox")
459:         WITH loc_oPg.txt_4c_Dataf
460:             .Top      = 96
461:             .Left     = 385
462:             .Width    = 82
463:             .Height   = 23
464:             .Value    = {}
465:             .Format   = "D"
466:             .FontName = "Tahoma"

*-- Linhas 1000 a 1009:
1000:                 loc_oPg.txt_4c_Grupo.Value  = ALLTRIM(.this_cGrupo)
1001:                 loc_oPg.txt_4c_Conta.Value  = ALLTRIM(.this_cConta)
1002:                 loc_oPg.txt_4c_Dconta.Value = ALLTRIM(.this_cDConta)
1003:                 loc_oPg.txt_4c_Datai.Value  = .this_dDatai
1004:                 loc_oPg.txt_4c_Dataf.Value  = .this_dDataf
1005:             ENDWITH
1006:             THIS.AtualizarEstadoCampos()
1007:         CATCH TO loc_oErro
1008:             MsgErro(loc_oErro.Message, "Erro")
1009:         ENDTRY


### BO (C:\4c\projeto\app\classes\SigReEvdBO.prg):
*==============================================================================
* SIGREEVDBO.PRG
* Business Object - Demonstrativo de Envelopes Duplicados
*
* Herda de: RelatorioBase
* Formulario: FormSigReEvd.prg
* Relatorio:  SigReEvd.frx
* Tabelas:    SigCdNec, SigCdNei, SigCdOpd, SigCdCli, SigCdGcr, SigCdEmp
*==============================================================================

DEFINE CLASS SigReEvdBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cGrupo       = ""
    this_cConta       = ""
    this_cDConta      = ""
    this_dDatai       = {}
    this_dDataf       = {}

    *-- Cursor de dados resultado
    this_cCursorDados = "cursor_4c_Dados"

    *-- Propriedades espelhando colunas de cursor_4c_Dados (registro corrente)
    *-- Carregadas por CarregarDoCursor() para inspecao/drill-down do relatorio
    this_nNenvs    = 0
    this_cGrupoOs  = ""
    this_cContaOs  = ""
    this_cRCliOs   = ""
    this_dDatas    = {}
    this_cGrupoDs  = ""
    this_cContaDs  = ""
    this_cRCliDs   = ""
    this_cEmpDnPs  = ""
    this_lRetrabs  = .F.

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de lookup para grupos e clientes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Carregar grupos (SigCdGcr) para lookup de Get_Grupo
            loc_cSQL = "SELECT Codigos, Descrs " + ;
                       "FROM SigCdGcr " + ;
                       "WHERE GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")
            IF loc_nResult >= 1
                *-- Carregar clientes (SigCdCli) para lookup de Get_Conta / Get_DConta
                loc_cSQL = "SELECT IClis, RClis, Inativas " + ;
                           "FROM SigCdCli " + ;
                           "WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Clientes")
                IF loc_nResult >= 1
                    loc_lSucesso = DODEFAULT()
                ELSE
                    MsgErro("Falha ao carregar clientes (SigCdCli)", "SigReEvdBO.Init")
                ENDIF
            ELSE
                MsgErro("Falha ao carregar grupos (SigCdGcr)", "SigReEvdBO.Init")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReEvdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * PrepararDados - Processa envelopes duplicados conforme os filtros.
    * Equivalente ao metodo 'processamento' do form legado SIGREEVD.
    * Popula cursor_4c_Dados (registros a imprimir) e cursor_4c_Cabecalho.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_lcGrupo, loc_lcConta, loc_ldDatai, loc_ldDataf, loc_cDtFSQL
        LOCAL loc_lcCliOs, loc_lcCliDs, loc_lcEmp, loc_lcCab, loc_lcSub
        LOCAL loc_nNenvs, loc_cGrupoOs, loc_cContaOs, loc_dDatas
        LOCAL loc_cGrupoDs, loc_cContaDs, loc_cEmpDnPs, loc_lRetrabs
        loc_lSucesso = .F.
        TRY
            loc_lcGrupo = ALLTRIM(THIS.this_cGrupo)
            loc_lcConta = ALLTRIM(THIS.this_cConta)
            loc_ldDatai = THIS.this_dDatai
            loc_ldDataf = THIS.this_dDataf

            *-- Data final com 23:59:59 para cobrir dia inteiro (Datas eh DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_ldDataf),  4, "0") + "-" + ;
                PADL(MONTH(loc_ldDataf), 2, "0") + "-" + ;
                PADL(DAY(loc_ldDataf),   2, "0") + " 23:59:59'"

            *-- Criar cursores de trabalho locais
            IF USED("cursor_4c_Envelope")
                USE IN cursor_4c_Envelope
            ENDIF
            CREATE CURSOR cursor_4c_Envelope (Nenvs N(10), GrupoDs C(10), Qt N(5))
            INDEX ON STR(Nenvs, 10) + GrupoDs TAG Nenvs

            IF USED("cursor_4c_TmpRelat")
                USE IN cursor_4c_TmpRelat
            ENDIF
            CREATE CURSOR cursor_4c_TmpRelat ( ;
                Nenvs   N(10), GrupoOs C(10), ContaOs C(10), RCliOs C(50), ;
                Datas   D,     GrupoDs C(10), ContaDs C(10), RCliDs C(50), ;
                EmpDnPs C(33), Retrabs L)

            *-- Clausula WHERE com filtros opcionais de grupo e conta
            loc_cWhere = "a.Datas BETWEEN " + FormatarDataSQL(loc_ldDatai) + ;
                         " AND " + loc_cDtFSQL
            IF !EMPTY(loc_lcGrupo)
                loc_cWhere = loc_cWhere + " AND a.GrupoDs = " + EscaparSQL(loc_lcGrupo)
            ENDIF

            *-- Buscar envelopes distintos no periodo/filtros
            loc_cSQL = "SELECT DISTINCT b.Nenvs " + ;
                       "FROM SigCdNec a, SigCdNei b " + ;
                       "WHERE " + loc_cWhere + " AND a.EmpDNps = b.EmpDNps " + ;
                       "ORDER BY b.Nenvs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecBase")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar envelopes (SigCdNec/SigCdNei)"
                MsgErro("Falha ao buscar envelopes (SigCdNec/SigCdNei)", "PrepararDados")
                loc_lSucesso = .F.
            ENDIF

            *-- Processar cada numero de envelope encontrado
            SELECT cursor_4c_NecBase
            SCAN
                IF cursor_4c_NecBase.Nenvs = 0
                    LOOP
                ENDIF

                *-- Buscar itens do envelope em SigCdNei
                loc_cSQL = "SELECT DISTINCT Nenvs, EmpDnPs, Dopps FROM SigCdNei " + ;
                           "WHERE Nenvs = " + TRANSFORM(cursor_4c_NecBase.Nenvs)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensiLoc")
                IF loc_nResult < 1
                    IF USED("cursor_4c_NensiLoc")
                        USE IN cursor_4c_NensiLoc
                    ENDIF
                    SELECT cursor_4c_NecBase
                    LOOP
                ENDIF

                SELECT cursor_4c_NensiLoc
                SCAN
                    *-- Verificar tipo de operacao em SigCdOpd
                    loc_cSQL = "SELECT Dopps, Subns, GrComps, SepPedras FROM SigCdOpd " + ;
                               "WHERE Dopps = " + EscaparSQL(ALLTRIM(cursor_4c_NensiLoc.Dopps))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpp")
                    IF loc_nResult < 1
                        IF USED("cursor_4c_TmpOpp")
                            USE IN cursor_4c_TmpOpp
                        ENDIF
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Pular se operacao nao se qualifica (SepPedras 1/3, Subns!=1, GrComps!=1)
                    SELECT cursor_4c_TmpOpp
                    IF INLIST(cursor_4c_TmpOpp.SepPedras, 1, 3) OR ;
                       cursor_4c_TmpOpp.Subns <> 1 OR ;
                       cursor_4c_TmpOpp.GrComps <> 1
                        USE IN cursor_4c_TmpOpp
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF
                    USE IN cursor_4c_TmpOpp

                    *-- Buscar dados do envelope origem em SigCdNec pelo EmpDnPs
                    loc_cSQL = "SELECT GrupoOs, ContaOs, Datas, GrupoDs, ContaDs, " + ;
                               "EmpDnPs, Retrabs FROM SigCdNec " + ;
                               "WHERE EmpDnPs = " + EscaparSQL(ALLTRIM(cursor_4c_NensiLoc.EmpDnPs))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensLoc")
                    IF loc_nResult < 1
                        IF USED("cursor_4c_NensLoc")
                            USE IN cursor_4c_NensLoc
                        ENDIF
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Pular se sem registro ou grupo reservado de estoque
                    SELECT cursor_4c_NensLoc
                    IF RECCOUNT() = 0 OR ALLTRIM(cursor_4c_NensLoc.GrupoDs) = "TRMOVESTQ"
                        USE IN cursor_4c_NensLoc
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Buscar nome do cliente origem (ContaOs)
                    loc_lcCliOs = ""
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_NensLoc.ContaOs))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCliOs") > 0
                        SELECT cursor_4c_TmpCliOs
                        IF !EOF()
                            loc_lcCliOs = ALLTRIM(cursor_4c_TmpCliOs.RClis)
                        ENDIF
                        USE IN cursor_4c_TmpCliOs
                    ENDIF

                    *-- Buscar nome do cliente destino (ContaDs)
                    loc_lcCliDs = ""
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_NensLoc.ContaDs))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCliDs") > 0
                        SELECT cursor_4c_TmpCliDs
                        IF !EOF()
                            loc_lcCliDs = ALLTRIM(cursor_4c_TmpCliDs.RClis)
                        ENDIF
                        USE IN cursor_4c_TmpCliDs
                    ENDIF

                    *-- Guardar valores antes de mudar work area
                    loc_nNenvs   = cursor_4c_NensiLoc.Nenvs
                    loc_cGrupoOs = ALLTRIM(cursor_4c_NensLoc.GrupoOs)
                    loc_cContaOs = ALLTRIM(cursor_4c_NensLoc.ContaOs)
                    loc_dDatas   = cursor_4c_NensLoc.Datas
                    loc_cGrupoDs = ALLTRIM(cursor_4c_NensLoc.GrupoDs)
                    loc_cContaDs = ALLTRIM(cursor_4c_NensLoc.ContaDs)
                    loc_cEmpDnPs = ALLTRIM(cursor_4c_NensLoc.EmpDnPs)
                    loc_lRetrabs = cursor_4c_NensLoc.Retrabs
                    USE IN cursor_4c_NensLoc

                    *-- Acumular no TmpRelat
                    SELECT cursor_4c_TmpRelat
                    APPEND BLANK
                    REPLACE Nenvs   WITH loc_nNenvs,   ;
                            GrupoOs WITH loc_cGrupoOs, ;
                            ContaOs WITH loc_cContaOs, ;
                            RCliOs  WITH loc_lcCliOs,  ;
                            Datas   WITH loc_dDatas,   ;
                            GrupoDs WITH loc_cGrupoDs, ;
                            ContaDs WITH loc_cContaDs, ;
                            RCliDs  WITH loc_lcCliDs,  ;
                            EmpDnPs WITH loc_cEmpDnPs, ;
                            Retrabs WITH loc_lRetrabs

                    *-- Atualizar contador de duplicados no cursor Envelope
                    SELECT cursor_4c_Envelope
                    SET ORDER TO TAG Nenvs
                    IF !SEEK(STR(loc_nNenvs, 10) + loc_cGrupoDs)
                        APPEND BLANK
                        REPLACE Nenvs   WITH loc_nNenvs, ;
                                GrupoDs WITH loc_cGrupoDs
                    ENDIF
                    REPLACE Qt WITH Qt + 1

                    SELECT cursor_4c_NensiLoc
                ENDSCAN

                IF USED("cursor_4c_NensiLoc")
                    USE IN cursor_4c_NensiLoc
                ENDIF
                SELECT cursor_4c_NecBase
            ENDSCAN

            IF USED("cursor_4c_NecBase")
                USE IN cursor_4c_NecBase
            ENDIF

            *-- Montar cabecalho do relatorio
            loc_lcCab = "Auditoria de Envelopes"
            loc_lcSub = "Per" + CHR(237) + "odo : " + ;
                        ALLTRIM(DTOC(loc_ldDatai)) + " at" + CHR(233) + " " + ;
                        ALLTRIM(DTOC(loc_ldDataf))

            loc_lcEmp = go_4c_Sistema.cCodEmpresa

            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (Titulo C(100), SubTitulo C(100), NomeEmpresa C(100))
            INSERT INTO cursor_4c_Cabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_lcCab, loc_lcSub, loc_lcEmp)

            *-- Cursor final: apenas envelopes realmente duplicados (Qt > 1)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SELECT A.* FROM cursor_4c_TmpRelat A, cursor_4c_Envelope B ;
                WHERE A.Nenvs = B.Nenvs AND A.GrupoDs = B.GrupoDs AND B.Qt > 1 ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY A.Nenvs, A.Datas

            IF USED("cursor_4c_TmpRelat")
                USE IN cursor_4c_TmpRelat
            ENDIF
            IF USED("cursor_4c_Envelope")
                USE IN cursor_4c_Envelope
            ENDIF

            SELECT cursor_4c_Dados
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReEvdBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o registro corrente do cursor de dados do
    * relatorio para as propriedades this_*. Util para drill-down, exportacao
    * registro a registro ou inspecao em testes. Aceita qualquer alias com a
    * mesma estrutura de cursor_4c_Dados (cursor_4c_TmpRelat).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), THIS.this_cCursorDados, par_cAliasCursor)
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o aberto: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Cursor sem registro corrente: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            *-- Mapeamento das colunas do cursor para propriedades do BO.
            *-- Usar TYPE() para tolerar cursores com subset de colunas.
            IF TYPE(loc_cAlias + ".Nenvs") = "N"
                THIS.this_nNenvs = NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".GrupoOs") = "C"
                THIS.this_cGrupoOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".ContaOs") = "C"
                THIS.this_cContaOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ContaOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".RCliOs") = "C"
                THIS.this_cRCliOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".RCliOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Datas") = "D" OR TYPE(loc_cAlias + ".Datas") = "T"
                THIS.this_dDatas = NVL(EVALUATE(loc_cAlias + ".Datas"), {})
            ENDIF
            IF TYPE(loc_cAlias + ".GrupoDs") = "C"
                THIS.this_cGrupoDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".ContaDs") = "C"
                THIS.this_cContaDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ContaDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".RCliDs") = "C"
                THIS.this_cRCliDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".RCliDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".EmpDnPs") = "C"
                THIS.this_cEmpDnPs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".EmpDnPs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Retrabs") = "L"
                THIS.this_lRetrabs = NVL(EVALUATE(loc_cAlias + ".Retrabs"), .F.)
            ELSE
                IF TYPE(loc_cAlias + ".Retrabs") = "N"
                    THIS.this_lRetrabs = (NVL(EVALUATE(loc_cAlias + ".Retrabs"), 0) = 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReEvdBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o gravam registros. " + ;
            "Use PrepararDados() para gerar os dados."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o alteram registros. " + ;
            "Use PrepararDados() para gerar os dados."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para o registro corrente, devolve "Nenvs|GrupoDs"
    * (chave composta que identifica o envelope duplicado no resultado).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cAlias
        loc_cChave = ""
        loc_cAlias = THIS.this_cCursorDados
        IF USED(loc_cAlias)
            SELECT (loc_cAlias)
            IF !EOF() AND !BOF()
                loc_cChave = ALLTRIM(STR(NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0))) + ;
                             "|" + ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoDs"), ""))
            ENDIF
        ENDIF
        IF EMPTY(loc_cChave) AND THIS.this_nNenvs > 0
            loc_cChave = ALLTRIM(STR(THIS.this_nNenvs)) + "|" + ALLTRIM(THIS.this_cGrupoDs)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao em LogAuditoria. Para relatorios
    * registra apenas a operacao "IMPRESSAO" com os filtros aplicados.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_cFiltros, loc_cOper
        loc_lSucesso = .F.
        TRY
            loc_cOper = IIF(EMPTY(par_cOperacao), "IMPRESSAO", ALLTRIM(par_cOperacao))
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "")

            loc_cFiltros = "Grupo=" + ALLTRIM(THIS.this_cGrupo) + ;
                           "; Conta=" + ALLTRIM(THIS.this_cConta) + ;
                           "; DConta=" + ALLTRIM(THIS.this_cDConta) + ;
                           "; Datai=" + DTOC(THIS.this_dDatai) + ;
                           "; Dataf=" + DTOC(THIS.this_dDataf)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(TabelaNome, ChaveRegistro, Operacao, Usuario, DataHora, Detalhes) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigReEvd") + ", " + ;
                       EscaparSQL("RELATORIO") + ", " + ;
                       EscaparSQL(loc_cOper) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cFiltros, 500)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper o relatorio
            THIS.this_cMensagemErro = "Falha auditoria: " + loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_Clientes")
            USE IN cursor_4c_Clientes
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_TmpRelat")
            USE IN cursor_4c_TmpRelat
        ENDIF
        IF USED("cursor_4c_Envelope")
            USE IN cursor_4c_Envelope
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

