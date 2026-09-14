# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 226: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 248: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 271: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreeqe.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (936 linhas total):

*-- Linhas 76 a 84:
76:         loc_lSucesso   = .F.
77:         loc_lContinuar = .T.
78:         TRY
79:             THIS.Caption = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
80: 
81:             IF TYPE("gc_4c_CaminhoIcones") = "U"
82:                 gc_4c_CaminhoIcones = ""
83:             ENDIF
84:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 107 a 116:
107:                 *-- Registrar eventos de interacao (BINDEVENTs)
108:                 THIS.ConfigurarEventos()
109: 
110:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
111:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
112: 
113:                 *-- Carregar defaults do BO (empresa padrao do usuario logado)
114:                 THIS.LimparCampos()
115: 
116:                 THIS.Visible   = .T.

*-- Linhas 133 a 210:
133:     PROTECTED PROCEDURE ConfigurarCabecalho()
134:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
135:         WITH THIS.cnt_4c_Cabecalho
136:             .Top         = 0
137:             .Left        = 0
138:             .Width       = THIS.Width
139:             .Height      = 80
140:             .BackStyle   = 1
141:             .BackColor   = RGB(100, 100, 100)
142:             .BorderWidth = 0
143:             .Visible     = .T.
144: 
145:             *-- Sombra deslocada (efeito 3D sobre texto branco)
146:             .AddObject("lbl_4c_Sombra", "Label")
147:             WITH .lbl_4c_Sombra
148:                 .Top       = 22
149:                 .Left      = 22
150:                 .Width     = THIS.Width
151:                 .Height    = 30
152:                 .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
153:                 .FontName  = "Tahoma"
154:                 .FontSize  = 14
155:                 .FontBold  = .T.
156:                 .ForeColor = RGB(0, 0, 0)
157:                 .BackStyle = 0
158:                 .Visible   = .T.
159:             ENDWITH
160: 
161:             *-- Titulo em branco (sobre a sombra escura)
162:             .AddObject("lbl_4c_Titulo", "Label")
163:             WITH .lbl_4c_Titulo
164:                 .Top       = 20
165:                 .Left      = 20
166:                 .Width     = THIS.Width
167:                 .Height    = 30
168:                 .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
169:                 .FontName  = "Tahoma"
170:                 .FontSize  = 14
171:                 .FontBold  = .T.
172:                 .ForeColor = RGB(255, 255, 255)
173:                 .BackStyle = 0
174:                 .Visible   = .T.
175:             ENDWITH
176:         ENDWITH
177:     ENDPROC
178: 
179:     *--------------------------------------------------------------------------
180:     * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
181:     *   Posicao original: btnReport.Left=527, Top=4
182:     *   Equivalente exato ao btnReport do frmrelatorio do framework.
183:     *--------------------------------------------------------------------------
184:     PROTECTED PROCEDURE ConfigurarBotoes()
185:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
186:         WITH THIS.cmg_4c_Botoes
187:             .Top           = 0
188:             .Left          = 529
189:             .Width         = 273
190:             .Height        = 80
191:             .ButtonCount   = 4
192:             .BackStyle     = 0
193:             .BorderStyle   = 0
194:             .BorderColor   = RGB(136, 189, 188)
195:             .SpecialEffect = 1
196:             .Themes        = .F.
197:             .Visible       = .T.
198: 
199:             *-- Visualizar (preview em tela) - equivalente a Visualiza do legado
200:             WITH .Buttons(1)
201:                 .Top             = 5
202:                 .Left            = 5
203:                 .Width           = 65
204:                 .Height          = 70
205:                 .Caption         = "Visualizar"
206:                 .FontBold        = .T.
207:                 .FontItalic      = .T.
208:                 .BackColor       = RGB(255, 255, 255)
209:                 .ForeColor       = RGB(90, 90, 90)
210:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 218 a 232:
218: 
219:             *-- Imprimir (impressora com prompt) - equivalente a Imprime do legado
220:             WITH .Buttons(2)
221:                 .Top             = 5
222:                 .Left            = 71
223:                 .Width           = 65
224:                 .Height          = 70
225:                 .Caption         = "Imprimir"
226:                 .FontName        = "Comic Sans MS"
227:                 .FontBold        = .T.
228:                 .FontItalic      = .T.
229:                 .FontSize        = 8
230:                 .BackColor       = RGB(255, 255, 255)
231:                 .ForeColor       = RGB(90, 90, 90)
232:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 240 a 254:
240: 
241:             *-- Excel (exportar) - equivalente a DocExcel do legado
242:             WITH .Buttons(3)
243:                 .Top             = 5
244:                 .Left            = 137
245:                 .Width           = 65
246:                 .Height          = 70
247:                 .Caption         = "Excel"
248:                 .FontName        = "Comic Sans MS"
249:                 .FontBold        = .T.
250:                 .FontItalic      = .T.
251:                 .FontSize        = 8
252:                 .BackColor       = RGB(255, 255, 255)
253:                 .ForeColor       = RGB(90, 90, 90)
254:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 262 a 277:
262: 
263:             *-- Encerrar (fechar form) - equivalente a Sair do legado; ESC fecha
264:             WITH .Buttons(4)
265:                 .Top             = 5
266:                 .Left            = 203
267:                 .Width           = 65
268:                 .Height          = 70
269:                 .Caption         = "Encerrar"
270:                 .Cancel          = .T.
271:                 .FontName        = "Comic Sans MS"
272:                 .FontBold        = .T.
273:                 .FontItalic      = .T.
274:                 .FontSize        = 8
275:                 .BackColor       = RGB(255, 255, 255)
276:                 .ForeColor       = RGB(90, 90, 90)
277:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 299 a 313:
299:         *-- PageCount antes de acessar Page1
300:         loc_oPgf.PageCount = 1
301: 
302:         loc_oPgf.Top    = 85
303:         loc_oPgf.Left   = -1
304:         loc_oPgf.Width  = THIS.Width + 2
305:         loc_oPgf.Height = THIS.Height - 85
306:         loc_oPgf.Tabs   = .F.
307: 
308:         loc_oPgf.Page1.Caption   = "Filtros"
309:         loc_oPgf.Page1.FontName  = "Tahoma"
310:         loc_oPgf.Page1.FontSize  = 8
311:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
312:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
313:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 319 a 433:
319:     *--------------------------------------------------------------------------
320:     * ConfigurarPaginaFiltros - Popula Page1 ("Filtros") com os controles
321:     *   equivalentes ao layout original SIGREEQE:
322:     *   - Say5  -> lbl_4c_Empresa  (Top=159, Left=208)
323:     *   - GetEmpresa    -> txt_4c_Empresa    (Top=156, Left=262, Width=36, MaxLength=3)
324:     *   - GetDesEmpresa -> txt_4c_DesEmpresa (Top=156, Left=300, Width=285)
325:     *   - Say1  -> lbl_4c_Agrupa   (Top=186, Left=210)
326:     *   - Opt_Agrupa -> opg_4c_Agrupa (Top=183, Left=258, Barra/Identidade)
327:     *
328:     *   PageFrame.Top=85 -> posicoes relativas: Top -= 85
329:     *--------------------------------------------------------------------------
330:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
331:         LOCAL loc_oPagina
332:         TRY
333:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
334: 
335:             *-- Label "Empresa :" (Say5: Top=159, Left=208)
336:             loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
337:             WITH loc_oPagina.lbl_4c_Empresa
338:                 .Top       = 74
339:                 .Left      = 208
340:                 .Width     = 54
341:                 .Height    = 17
342:                 .Caption   = "Empresa :"
343:                 .FontName  = "Tahoma"
344:                 .FontSize  = 8
345:                 .ForeColor = RGB(90, 90, 90)
346:                 .BackStyle = 0
347:                 .Visible   = .T.
348:             ENDWITH
349: 
350:             *-- Codigo da empresa (GetEmpresa: Top=156, Left=262, Width=36, MaxLength=3)
351:             loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
352:             WITH loc_oPagina.txt_4c_Empresa
353:                 .Top       = 71
354:                 .Left      = 262
355:                 .Width     = 36
356:                 .Height    = 23
357:                 .MaxLength = 3
358:                 .Value     = ""
359:                 .FontName  = "Tahoma"
360:                 .FontSize  = 8
361:                 .Visible   = .T.
362:             ENDWITH
363: 
364:             *-- Descricao da empresa (GetDesEmpresa: Top=156, Left=300, Width=285)
365:             loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
366:             WITH loc_oPagina.txt_4c_DesEmpresa
367:                 .Top      = 71
368:                 .Left     = 300
369:                 .Width    = 285
370:                 .Height   = 23
371:                 .Value    = ""
372:                 .FontName = "Tahoma"
373:                 .FontSize = 8
374:                 .Visible  = .T.
375:             ENDWITH
376: 
377:             *-- Label "Agrupar :" (Say1: Top=186, Left=210)
378:             loc_oPagina.AddObject("lbl_4c_Agrupa", "Label")
379:             WITH loc_oPagina.lbl_4c_Agrupa
380:                 .Top       = 101
381:                 .Left      = 210
382:                 .Width     = 54
383:                 .Height    = 17
384:                 .Caption   = "Agrupar :"
385:                 .FontName  = "Tahoma"
386:                 .FontSize  = 8
387:                 .ForeColor = RGB(90, 90, 90)
388:                 .BackStyle = 0
389:                 .Visible   = .T.
390:             ENDWITH
391: 
392:             *-- OptionGroup agrupamento (Opt_Agrupa: Top=183, Left=258, Value=1)
393:             *-- Buttons(1)="Barra", Buttons(2)="Identidade"
394:             loc_oPagina.AddObject("opg_4c_Agrupa", "OptionGroup")
395:             WITH loc_oPagina.opg_4c_Agrupa
396:                 .Top           = 98
397:                 .Left          = 258
398:                 .Width         = 138
399:                 .Height        = 25
400:                 .ButtonCount   = 2
401:                 .BackStyle     = 0
402:                 .BorderStyle   = 0
403:                 .Value         = 1
404:                 .SpecialEffect = 0
405:                 .Visible       = .T.
406: 
407:                 WITH .Buttons(1)
408:                     .Caption   = "Barra"
409:                     .BackStyle = 0
410:                     .Value     = 1
411:                     .Height    = 15
412:                     .Left      = 5
413:                     .Top       = 5
414:                     .Width     = 44
415:                     .AutoSize  = .T.
416:                     .ForeColor = RGB(90, 90, 90)
417:                     .Themes    = .F.
418:                     .Visible   = .T.
419:                 ENDWITH
420: 
421:                 WITH .Buttons(2)
422:                     .Caption   = "Identidade"
423:                     .FontName  = "Tahoma"
424:                     .FontSize  = 8
425:                     .BackStyle = 0
426:                     .Height    = 15
427:                     .Left      = 63
428:                     .Top       = 5
429:                     .AutoSize  = .T.
430:                     .ForeColor = RGB(90, 90, 90)
431:                     .Themes    = .F.
432:                     .Visible   = .T.
433:                 ENDWITH


### BO (C:\4c\projeto\app\classes\sigreeqeBO.prg):
*==============================================================================
* SIGREEQEBO.PRG
* Business Object para Relatorio de Posicao de Etiquetas por Empresa
*
* Herda de: RelatorioBase
* Origem: SIGREEQE.SCX (frmrelatorio)
* Relatorio FRX: SigReEqe.frx
*
* Filtros do relatorio:
*   - Empresa (codigo + descricao)
*   - Agrupamento: 1=Barra / 2=Identidade
*
* Parametros internos carregados no Init():
*   this_cGrupo  - GrupoEsts de SigCdPam
*   this_cConta  - ContaEsts de SigCdPam
*   this_cTabela - CodTabDs de SigOpTde (tabela de desconto padrao da empresa)
*
* Cursores de apoio carregados no Init():
*   cursor_4c_SigCdEmp  - empresas (cemps, razas, ativas, estas)
*   cursor_4c_SigCdMoe  - moedas (CMoes, ...)
*   cursor_4c_SigCdCot  - cotacoes (CMoes, Datas, ...)
*   cursor_4c_SigCdGrp  - grupos (CGrus, Arreds)
*   cursor_4c_SigCdCfi  - configuracao ICMS (Grupos, Ests, ICMs)
*
* Cursor de resultado produzido por PrepararDados():
*   CsRelatorio - CBars, DPros, Units, SitTribs, Aliqs
*
* Cursor de cabecalho produzido por GerarCabecalho():
*   CsCabecalho - nomeempresa, titulo1, Barra
*==============================================================================

DEFINE CLASS sigreeqeBO AS RelatorioBase

    *-- Filtro de empresa (digitado pelo usuario)
    this_cEmpresa       = ""    && Codigo da empresa (GetEmpresa)
    this_cDesEmpresa    = ""    && Descricao da empresa (GetDesEmpresa)

    *-- Parametros internos carregados a partir dos cursores de apoio
    this_cGrupo         = ""    && GrupoEsts de SigCdPam (grupo de estoque)
    this_cConta         = ""    && ContaEsts de SigCdPam (conta de estoque)
    this_cTabela        = ""    && CodTabDs de SigOpTde (tabela de desconto padrao)

    *-- Opcao de agrupamento: 1=Barra, 2=Identidade
    this_nAgrupa        = 1

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de apoio e parametros do sistema
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL

        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            THIS.this_cGrupo      = ""
            THIS.this_cConta      = ""
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

                *-- SigCdPam: grupo e conta de estoque do sistema
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT GrupoEsts, ContaEsts FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdPam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrupo = ALLTRIM(cursor_4c_SigCdPam.GrupoEsts)
                        THIS.this_cConta = ALLTRIM(cursor_4c_SigCdPam.ContaEsts)
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdPam"
                ENDIF

                *-- SigCdEmp: cadastro de empresas
                IF USED("cursor_4c_SigCdEmp")
                    USE IN cursor_4c_SigCdEmp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT CEmps, Razas, Ativas, Estas FROM SigCdEmp", ;
                    "cursor_4c_SigCdEmp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdEmp
                    INDEX ON cemps TAG cemps
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdEmp"
                ENDIF

                *-- SigCdMoe: moedas
                IF USED("cursor_4c_SigCdMoe")
                    USE IN cursor_4c_SigCdMoe
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdMoe", ;
                    "cursor_4c_SigCdMoe")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdMoe
                    INDEX ON CMoes TAG CMoes
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdMoe"
                ENDIF

                *-- SigCdCot: cotacoes de moeda
                IF USED("cursor_4c_SigCdCot")
                    USE IN cursor_4c_SigCdCot
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdCot", ;
                    "cursor_4c_SigCdCot")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdCot
                    INDEX ON CMoes + DTOS(Datas) TAG CMoeData
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCot"
                ENDIF

                *-- SigCdGrp: grupos de produto (fator de arredondamento)
                IF USED("cursor_4c_SigCdGrp")
                    USE IN cursor_4c_SigCdGrp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT CGrus, Arreds FROM SigCdGrp", ;
                    "cursor_4c_SigCdGrp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdGrp
                    INDEX ON CGrus TAG CGrus
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdGrp"
                ENDIF

                *-- SigCdCfi: configuracao fiscal ICMS (grupos x estoque)
                IF USED("cursor_4c_SigCdCfi")
                    USE IN cursor_4c_SigCdCfi
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Grupos, Ests, ICMs FROM SigCdCfi", ;
                    "cursor_4c_SigCdCfi")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdCfi
                    INDEX ON Grupos + Ests TAG GruEstas
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCfi"
                ENDIF

                *-- Empresa padrao: empresa do usuario logado
                THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

                *-- Carregar descricao e tabela de desconto da empresa padrao
                IF !EMPTY(THIS.this_cEmpresa)
                    THIS.ValidarEmpresa()
                ENDIF

            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreeqeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Valida codigo de empresa e carrega descricao + tabela
    * de desconto padrao. Equivalente ao Valid de GetEmpresa/GetDesEmpresa.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_lSucesso, loc_cEmpresa, loc_cSQL, loc_nResult

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)

            IF EMPTY(loc_cEmpresa)
                THIS.this_cDesEmpresa = ""
                THIS.this_cTabela     = ""
                loc_lSucesso = .T.
            ENDIF

            *-- Buscar descricao da empresa
            THIS.this_cDesEmpresa = ""
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    THIS.this_cDesEmpresa = ALLTRIM(cursor_4c_SigCdEmp.Razas)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ;
                        loc_cEmpresa
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            *-- Buscar tabela de desconto padrao da empresa
            THIS.this_cTabela = ""
            loc_cSQL = "SELECT a.Emps, a.CodTabDs, b.Descrs" + ;
                " FROM SigOpTde a, SigOpTdz b" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                " AND a.Padraos = 1 AND b.Codigos = a.CodTabDs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TabDe")
            IF loc_nResult >= 1
                SELECT cursor_4c_TabDe
                GO TOP
                IF !EOF()
                    THIS.this_cTabela = ALLTRIM(cursor_4c_TabDe.CodTabDs)
                ENDIF
                USE IN cursor_4c_TabDe
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra toda a preparacao do relatorio:
    *   1. Valida filtros
    *   2. Gera cabecalho
    *   3. Processa etiquetas
    * Equivalente ao metodo processamento do legado SIGREEQE.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarFiltros()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.GerarCabecalho()
                    loc_lSucesso = .F.
                ELSE
                    IF !THIS.Processar()
                        loc_lSucesso = .F.
                    ELSE
                        IF USED("CsRelatorio")
                            SELECT CsRelatorio
                            GO TOP
                        ENDIF
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de processar.
    * Equivalente as validacoes em btnReport.Click do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            *-- Empresa obrigatoria
            IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
                THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida"
                loc_lSucesso = .F.
            ENDIF

            *-- Tabela de desconto obrigatoria
            IF EMPTY(ALLTRIM(THIS.this_cTabela))
                THIS.this_cMensagemErro = "Empresa com Tabela de Desconto Padr" + ;
                    CHR(227) + "o N" + CHR(227) + "o Informada !!!"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCabecalho - Cria cursor CsCabecalho para o relatorio FRX.
    * Equivalente ao bloco inicial de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarCabecalho()
        LOCAL loc_lSucesso, loc_cNomeEmpresa, loc_cTitulo1, loc_lBarra
        LOCAL loc_cEmpresa

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa     = ALLTRIM(THIS.this_cEmpresa)
            loc_lBarra       = (THIS.this_nAgrupa = 1)

            *-- Nome da empresa
            loc_cNomeEmpresa = loc_cEmpresa
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cNomeEmpresa = loc_cEmpresa + " - " + ;
                        ALLTRIM(cursor_4c_SigCdEmp.Razas)
                ENDIF
            ENDIF

            *-- Titulo: "Posicao de Etiquetas - EMPRESA"
            loc_cTitulo1 = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas" + ;
                IIF(!EMPTY(loc_cEmpresa), " - " + ALLTRIM(loc_cEmpresa), "")

            *-- Criar cursor CsCabecalho
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF

            CREATE CURSOR CsCabecalho ;
                (nomeempresa C(80), titulo1 C(80), Barra L)

            INSERT INTO CsCabecalho (nomeempresa, titulo1, Barra) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo1, loc_lBarra)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Executa as queries e calcula valores das etiquetas.
    * Equivalente a PROCEDURE processamento do legado SIGREEQE.
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cTabela
        LOCAL loc_nAgrupa, loc_nParcs
        LOCAL loc_cFiltroGrupo, loc_cFiltroEsto

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cEstoque  = ALLTRIM(THIS.this_cConta)
            loc_cTabela   = ALLTRIM(THIS.this_cTabela)
            loc_nAgrupa   = THIS.this_nAgrupa
            loc_nParcs    = 0

            *-- Clausulas de filtro opcionais para grupo e estoque
            loc_cFiltroGrupo = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltroGrupo = " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cFiltroEsto = ""
            IF !EMPTY(loc_cEstoque)
                loc_cFiltroEsto = " AND a.Contas = " + EscaparSQL(loc_cEstoque)
            ENDIF

            *-- Fechar cursor de resultado anterior
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            *-- Criar cursor de resultado: estrutura identica ao original
            CREATE CURSOR CsRelatorio ;
                (CBars C(14), DPros C(40), Units N(12,2), SitTribs C(2), Aliqs N(6,2))

            IF loc_nAgrupa = 2
                INDEX ON CBars TAG CBars
            ENDIF

            *-- Numero de parcelas da tabela de desconto
            loc_nParcs = 0
            IF !EMPTY(loc_cTabela)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT NParcs FROM SigOpTdz WHERE Codigos = " + ;
                    EscaparSQL(loc_cTabela), "cursor_4c_TabDz")
                IF loc_nResult >= 1
                    SELECT cursor_4c_TabDz
                    GO TOP
                    IF !EOF()
                        loc_nParcs = NVL(cursor_4c_TabDz.NParcs, 0)
                    ENDIF
                    USE IN cursor_4c_TabDz
                ENDIF
            ENDIF

            *-- Descontos por tipo (tabela SigOpTdt)
            IF USED("cursor_4c_TabDi")
                USE IN cursor_4c_TabDi
            ENDIF
            IF !EMPTY(loc_cTabela)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigOpTdt WHERE Codigos = " + ;
                    EscaparSQL(loc_cTabela), "cursor_4c_TabDi")
                IF loc_nResult >= 1
                    SELECT cursor_4c_TabDi
                    INDEX ON Codigos + STR(Tipos, 1) + CodTips TAG CodTips
                    GO TOP
                ENDIF
            ENDIF

            *-- Query principal: UNION ALL etiquetas (SigOpEtq) + estoque (SigMvEst)
            loc_cSQL = "SELECT '1' AS Ps, a.CPros, a.CBars, b.DPros, b.PVens," + ;
                " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
                " b.Sgrus, b.sittricms, b.CodFinP" + ;
                " FROM SigOpEtq a, SigCdPro b, SigCdUni c" + ;
                " WHERE a.EmpOs = " + EscaparSQL(loc_cEmpresa) + ;
                loc_cFiltroGrupo + loc_cFiltroEsto + ;
                " AND b.CPros = a.CPros" + ;
                " AND b.cUnis = c.cunis AND c.Etiqs = 'S'" + ;
                " UNION ALL" + ;
                " SELECT '2' AS Ps, a.CPros, b.CBars, b.DPros, b.PVens," + ;
                " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
                " b.Sgrus, b.sittricms, b.CodFinP" + ;
                " FROM SigMvEst a, SigCdPro b, SigCdUni c" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + ;
                    " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cEstoque)
                loc_cSQL = loc_cSQL + ;
                    " AND a.Estos = " + EscaparSQL(loc_cEstoque)
            ENDIF

            loc_cSQL = loc_cSQL + ;
                " AND a.CPros = b.CPros" + ;
                " AND b.cUnis = c.cunis AND c.Etiqs <> 'S'" + ;
                " ORDER BY 1, 3, 2, 5, 6, 7, 8"

            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsRel")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao selecionar etiquetas (CsRel)"
                loc_lSucesso = .F.
            ENDIF

            *-- Buscar estado de estoque da empresa (para aliquota ICMS)
            LOCAL loc_cEstas
            loc_cEstas = ""
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cEstas = ALLTRIM(cursor_4c_SigCdEmp.Estas)
                ENDIF
            ENDIF

            *-- Calcular preco unitario com descontos e arredondamento
            SELECT CsRel
            GO TOP
            SCAN
                SCATTER MEMO MEMVAR

                LOCAL loc_nAliqs, loc_nUnits, loc_nDescUnit, loc_nDescTab
                LOCAL loc_cCBars

                loc_nAliqs    = 0
                loc_nDescUnit = 1
                loc_nDescTab  = 1

                *-- Aliquota ICMS para o grupo + estado
                IF USED("cursor_4c_SigCdCfi")
                    SELECT cursor_4c_SigCdCfi
                    IF SEEK(m.CGrus + loc_cEstas, "cursor_4c_SigCdCfi", "GruEstas")
                        loc_nAliqs = cursor_4c_SigCdCfi.ICMs
                    ENDIF
                ENDIF

                *-- Valor unitario convertido para moeda local
                loc_nUnits = m.PVens * fCarregarCambio(m.MoeVs, DATE())

                *-- Verificar desconto na tabela por tipo (produto, finp, grupo, linha, colecao, moeda, uni, cftio, sgru)
                IF USED("cursor_4c_TabDi")
                    IF SEEK(loc_cTabela + "4" + PADR(m.CPros, 14), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "9" + PADR(m.CodFinP, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "1" + PADR(m.CGrus, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "2" + PADR(m.Linhas, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "3" + PADR(m.Colecoes, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "5" + PADR(m.Moevs, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "6" + PADR(m.Cunis, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "7" + PADR(m.Cftios, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "8" + PADR(m.Sgrus, 10), "cursor_4c_TabDi", "CodTips")
                        loc_nDescUnit = loc_nDescUnit - (cursor_4c_TabDi.Descos / 100)
                        loc_nDescTab  = IIF(cursor_4c_TabDi.TExclus = "S", 1, loc_nDescTab)
                    ENDIF
                ENDIF

                *-- Calcular preco final (com parcelas ou sem)
                IF loc_nParcs = 0
                    m.Units = ROUND(loc_nUnits * loc_nDescTab * loc_nDescUnit / 1, 2)
                ELSE
                    LOCAL loc_nPrecoParc
                    loc_nPrecoParc = CEILING(((loc_nUnits * loc_nDescTab * loc_nDescUnit) / 1) / loc_nParcs)
                    m.Units = loc_nPrecoParc * loc_nParcs
                ENDIF

                *-- Arredondamento pelo fator do grupo
                IF USED("cursor_4c_SigCdGrp")
                    SELECT cursor_4c_SigCdGrp
                    IF SEEK(m.CGrus, "cursor_4c_SigCdGrp", "CGrus") AND ;
                            cursor_4c_SigCdGrp.Arreds <> 0
                        LOCAL loc_nFatArred, loc_nSoma
                        loc_nFatArred = cursor_4c_SigCdGrp.Arreds
                        loc_nSoma     = loc_nFatArred
                        DO WHILE loc_nSoma < m.Units
                            loc_nSoma = loc_nSoma + loc_nFatArred
                        ENDDO
                        m.Units = loc_nSoma
                    ENDIF
                ENDIF

                *-- Situacao tributaria e codigo de barras (string)
                m.SitTribs = IIF(EMPTY(m.SitTricms), "00", m.SitTricms)
                loc_cCBars = STR(m.CBars, 14)

                *-- Inserir no cursor de resultado
                IF loc_nAgrupa = 2
                    *-- Identidade: deduplicar por codigo de barras, manter maior preco
                    SELECT CsRelatorio
                    IF !SEEK(loc_cCBars, "CsRelatorio", "CBars")
                        INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
                            VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
                    ELSE
                        IF m.Units > CsRelatorio.Units
                            GATHER MEMVAR FIELDS Units
                        ENDIF
                    ENDIF
                ELSE
                    *-- Barra: inserir todos os registros
                    SELECT CsRelatorio
                    INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
                        VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
                ENDIF

                SELECT CsRel

            ENDSCAN

            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            SELECT CsRelatorio
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Processar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela.
    * Equivalente a PROCEDURE visualizacao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath PREVIEW NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora com prompt.
    * Equivalente a PROCEDURE impressao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath TO PRINTER PROMPT NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Prepara dados e envia para impressora sem prompt.
    * Equivalente a PROCEDURE documento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath TO PRINTER NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ImprimirDireto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresIntermedios - Fecha todos os cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresIntermedios()
        LOCAL loc_aCursores[8], loc_i

        loc_aCursores[1] = "CsRel"
        loc_aCursores[2] = "CsRelatorio"
        loc_aCursores[3] = "CsCabecalho"
        loc_aCursores[4] = "cursor_4c_TabDi"
        loc_aCursores[5] = "cursor_4c_TabDz"
        loc_aCursores[6] = "cursor_4c_SigCdPam"
        loc_aCursores[7] = "cursor_4c_TabDe"
        loc_aCursores[8] = "cursor_4c_EmpVal"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursoresIntermedios()

        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_SigCdMoe")
            USE IN cursor_4c_SigCdMoe
        ENDIF
        IF USED("cursor_4c_SigCdCot")
            USE IN cursor_4c_SigCdCot
        ENDIF
        IF USED("cursor_4c_SigCdGrp")
            USE IN cursor_4c_SigCdGrp
        ENDIF
        IF USED("cursor_4c_SigCdCfi")
            USE IN cursor_4c_SigCdCfi
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

