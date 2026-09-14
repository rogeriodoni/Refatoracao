# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_XCorNf' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreimc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (649 linhas total):

*-- Linhas 94 a 102:
94:         loc_lSucesso   = .F.
95:         loc_lContinuar = .T.
96:         TRY
97:             THIS.Caption = "Impress" + CHR(227) + "o de Cartas"
98: 
99:             IF TYPE("gc_4c_CaminhoIcones") = "U"
100:                 gc_4c_CaminhoIcones = ""
101:             ENDIF
102:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 120 a 129:
120:                 THIS.ConfigurarFiltros()
121:                 THIS.AtualizarEstadoCampos()
122: 
123:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
124:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
125: 
126:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
127:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
128:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
129: 

*-- Linhas 148 a 186:
148:     PROTECTED PROCEDURE ConfigurarCabecalho()
149:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
150:         WITH THIS.cnt_4c_Cabecalho
151:             .Top         = 0
152:             .Left        = 0
153:             .Width       = THIS.Width
154:             .Height      = 80
155:             .BackStyle   = 1
156:             .BackColor   = RGB(100, 100, 100)
157:             .BorderWidth = 0
158:             .Visible     = .T.
159: 
160:             .AddObject("lbl_4c_Sombra", "Label")
161:             WITH .lbl_4c_Sombra
162:                 .Top       = 22
163:                 .Left      = 22
164:                 .Width     = THIS.Width
165:                 .Height    = 30
166:                 .Caption   = "Impress" + CHR(227) + "o de Cartas"
167:                 .FontName  = "Tahoma"
168:                 .FontSize  = 14
169:                 .FontBold  = .T.
170:                 .ForeColor = RGB(0, 0, 0)
171:                 .BackStyle = 0
172:                 .Visible   = .T.
173:             ENDWITH
174: 
175:             .AddObject("lbl_4c_Titulo", "Label")
176:             WITH .lbl_4c_Titulo
177:                 .Top       = 20
178:                 .Left      = 20
179:                 .Width     = THIS.Width
180:                 .Height    = 30
181:                 .Caption   = "Impress" + CHR(227) + "o de Cartas"
182:                 .FontName  = "Tahoma"
183:                 .FontSize  = 14
184:                 .FontBold  = .T.
185:                 .ForeColor = RGB(255, 255, 255)
186:                 .BackStyle = 0

*-- Linhas 197 a 222:
197:     PROTECTED PROCEDURE ConfigurarBotoes()
198:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
199:         WITH THIS.cmg_4c_Botoes
200:             .Top           = 0
201:             .Left          = 529
202:             .Width         = 273
203:             .Height        = 80
204:             .ButtonCount   = 4
205:             .BackStyle     = 0
206:             .BorderStyle   = 0
207:             .BorderColor   = RGB(136, 189, 188)
208:             .SpecialEffect = 1
209:             .Themes        = .F.
210:             .Visible       = .T.
211: 
212:             WITH .Buttons(1)
213:                 .Top             = 5
214:                 .Left            = 5
215:                 .Width           = 65
216:                 .Height          = 70
217:                 .Caption         = "Visualizar"
218:                 .FontBold        = .T.
219:                 .FontItalic      = .T.
220:                 .BackColor       = RGB(255, 255, 255)
221:                 .ForeColor       = RGB(90, 90, 90)
222:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 229 a 241:
229:             ENDWITH
230: 
231:             WITH .Buttons(2)
232:                 .Top             = 5
233:                 .Left            = 71
234:                 .Width           = 65
235:                 .Height          = 70
236:                 .Caption         = "Imprimir"
237:                 .FontName        = "Tahoma"
238:                 .FontBold        = .T.
239:                 .FontItalic      = .T.
240:                 .FontSize        = 8
241:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 250 a 262:
250:             ENDWITH
251: 
252:             WITH .Buttons(3)
253:                 .Top             = 5
254:                 .Left            = 137
255:                 .Width           = 65
256:                 .Height          = 70
257:                 .Caption         = "Excel"
258:                 .FontName        = "Tahoma"
259:                 .FontBold        = .T.
260:                 .FontItalic      = .T.
261:                 .FontSize        = 8
262:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 271 a 283:
271:             ENDWITH
272: 
273:             WITH .Buttons(4)
274:                 .Top             = 5
275:                 .Left            = 203
276:                 .Width           = 65
277:                 .Height          = 70
278:                 .Caption         = "Encerrar"
279:                 .Cancel          = .T.
280:                 .FontName        = "Tahoma"
281:                 .FontBold        = .T.
282:                 .FontItalic      = .T.
283:                 .FontSize        = 8

*-- Linhas 304 a 318:
304:         loc_oPgf = THIS.pgf_4c_Paginas
305: 
306:         loc_oPgf.PageCount = 1
307:         loc_oPgf.Top    = 80
308:         loc_oPgf.Left   = -1
309:         loc_oPgf.Width  = THIS.Width + 2
310:         loc_oPgf.Height = THIS.Height - 80
311:         loc_oPgf.Tabs   = .F.
312: 
313:         loc_oPgf.Page1.Caption   = "Filtros"
314:         loc_oPgf.Page1.FontName  = "Tahoma"
315:         loc_oPgf.Page1.FontSize  = 8
316:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
317:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
318:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 333 a 418:
333:         LOCAL loc_oPag
334:         loc_oPag = THIS.pgf_4c_Paginas.Page1
335: 
336:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
337:         WITH loc_oPag.lbl_4c_Label1
338:             .Top       = 16
339:             .Left      = 323
340:             .Width     = 32
341:             .Height    = 17
342:             .Caption   = "Nota :"
343:             .FontName  = "Tahoma"
344:             .FontSize  = 8
345:             .BackStyle = 0
346:             .ForeColor = RGB(90, 90, 90)
347:             .Visible   = .T.
348:         ENDWITH
349: 
350:         loc_oPag.AddObject("txt_4c_NotaIni", "TextBox")
351:         WITH loc_oPag.txt_4c_NotaIni
352:             .Top         = 12
353:             .Left        = 357
354:             .Width       = 52
355:             .Height      = 23
356:             .Value       = ""
357:             .MaxLength   = 6
358:             .FontName    = "Tahoma"
359:             .FontSize    = 8
360:             .ForeColor   = RGB(0, 0, 0)
361:             .BackColor   = RGB(255, 255, 255)
362:             .BorderStyle = 1
363:             .Visible     = .T.
364:         ENDWITH
365: 
366:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
367:         WITH loc_oPag.lbl_4c_Label2
368:             .Top       = 15
369:             .Left      = 414
370:             .Width     = 10
371:             .Height    = 17
372:             .Caption   = "a"
373:             .FontName  = "Tahoma"
374:             .FontSize  = 8
375:             .BackStyle = 0
376:             .ForeColor = RGB(90, 90, 90)
377:             .Visible   = .T.
378:         ENDWITH
379: 
380:         loc_oPag.AddObject("txt_4c_NotaFim", "TextBox")
381:         WITH loc_oPag.txt_4c_NotaFim
382:             .Top         = 12
383:             .Left        = 424
384:             .Width       = 52
385:             .Height      = 23
386:             .Value       = ""
387:             .MaxLength   = 6
388:             .FontName    = "Tahoma"
389:             .FontSize    = 8
390:             .ForeColor   = RGB(0, 0, 0)
391:             .BackColor   = RGB(255, 255, 255)
392:             .BorderStyle = 1
393:             .Visible     = .T.
394:         ENDWITH
395: 
396:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
397:         WITH loc_oPag.lbl_4c_Label3
398:             .Top       = 48
399:             .Left      = 349
400:             .Width     = 95
401:             .Height    = 17
402:             .Caption   = "N" + CHR(250) + "mero de c" + CHR(243) + "pias :"
403:             .FontName  = "Tahoma"
404:             .FontSize  = 8
405:             .BackStyle = 0
406:             .ForeColor = RGB(90, 90, 90)
407:             .Visible   = .T.
408:         ENDWITH
409: 
410:         loc_oPag.AddObject("txt_4c_Copias", "TextBox")
411:         WITH loc_oPag.txt_4c_Copias
412:             .Top         = 44
413:             .Left        = 445
414:             .Width       = 31
415:             .Height      = 23
416:             .Value       = 1
417:             .InputMask   = "999"
418:             .MaxLength   = 3


### BO (C:\4c\projeto\app\classes\sigreimcBO.prg):
*==============================================================================
* SIGREIMCBO.PRG
* Business Object para Relatorio de Impressao de Cartas (SIGREIMC)
* Herda de RelatorioBase
*
* Tabela principal: SigNfCor (join SigMvNfi, SigCdCli, SigCcOco)
* Relatorio FRX: SigReImc.frx
*
* Filtros:
*   - Empresa     (cemps)
*   - Serie       (cseries)
*   - Emissao De  (data inicial emissao NF)
*   - Emissao Ate (data final emissao NF)
*   - EDNs        (empdopnums de SigMvNfi - opcional)
*   - Nota Ini    (cnfis inicial)
*   - Nota Fim    (cnfis final)
*   - Copias      (numero de vias da carta - default: SigCdPam.viacarta)
*==============================================================================

DEFINE CLASS sigreimcBO AS RelatorioBase

    *-- Filtro: empresa e serie
    this_cEmp           = ""
    this_cSerie         = ""

    *-- Filtro: periodo de emissao da NF
    this_dEmisDe        = {}
    this_dEmisAte       = {}

    *-- Filtro: EDN (empdopnums de SigMvNfi)
    *   Quando preenchido, filtra apenas NFs com esse EDN
    *   Corresponde a propriedade custom 'edns' do form legado SIGREIMC
    this_cEDNs          = ""

    *-- Flag derivada de EDNs: .T. = filtrar por EDNs, .F. = sem filtro EDN
    *   Equivale a variavel pEmpEdns do Init() legado
    this_lEmpEdns       = .F.

    *-- Filtro: faixa de notas fiscais (cnfis)
    this_cNotaIni       = ""
    this_cNotaFim       = ""

    *-- Numero de vias/copias da carta
    *   Valor padrao carregado de SigCdPam.viacarta em InicializarFiltros()
    this_nCopias        = 1

    *-- Nome do cursor de saida populado por PrepararDados()
    *   Estrutura: cemps, cseries, cnfis, noccors, mretifs, clifors, emis,
    *              correcs, rclis, razaos, endes, cidas, estas, nums, compls,
    *              cdescrs, numvias
    this_cCursorDados   = "cursor_4c_XCorNf"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de impressao de cartas
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigNfCor"
        THIS.this_cCampoChave = "cnfis"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega parametros iniciais (viacarta de SigCdPam).
    * Chamado pelo form em InicializarForm().
    * Equivalente ao bloco do Init() legado que faz Requery de CrSigCdPam
    * e le SigCdPam.viacarta para preencher GetCopias.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT viacarta FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult > 0
                SELECT cursor_4c_Pam
                IF !EOF()
                    THIS.this_nCopias = NVL(viacarta, 1)
                    IF THIS.this_nCopias < 1
                        THIS.this_nCopias = 1
                    ENDIF
                ENDIF
                USE IN cursor_4c_Pam
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor XCorNf com as cartas a imprimir.
    * Replica a logica do procedure 'processamento' do form legado SIGREIMC:
    *   1. Executa query em SigNfCor/SigMvNfi/SigCdCli/SigCcOco -> CrSigNfCor
    *   2. Replica each record this_nCopias vezes com numvias sequencial
    * Chamado por Imprimir() e Visualizar() do form antes de REPORT FORM.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_dEmisDe, loc_dEmisAte
        LOCAL loc_cEmpsFmt, loc_cSeriesFmt, loc_cNFisDeF, loc_cNFisAteFmt
        LOCAL loc_nVia, loc_nCopias
        loc_lSucesso = .F.
        TRY
            *-- Valores dos filtros
            loc_dEmisDe  = THIS.this_dEmisDe
            loc_dEmisAte = THIS.this_dEmisAte
            IF EMPTY(loc_dEmisDe)
                loc_dEmisDe = CTOD("01/01/1900")
            ENDIF
            IF EMPTY(loc_dEmisAte)
                loc_dEmisAte = DATE()
            ENDIF

            loc_cEmpsFmt   = EscaparSQL(THIS.this_cEmp)
            loc_cSeriesFmt = EscaparSQL(THIS.this_cSerie)
            loc_cNFisDeF   = EscaparSQL(THIS.this_cNotaIni)
            loc_cNFisAteFmt = EscaparSQL(PADR(THIS.this_cNotaFim, 6, CHR(254)))

            *-- Monta SQL base para NF Cor (espelha lcQryCorNf do Init() legado)
            loc_cSQL = "SELECT f.cemps, f.cseries, f.cnfis, f.noccors," + ;
                       " f.mretifs, n.clifors, n.emis, n.correcs," + ;
                       " c.rclis, c.razaos, c.endes, c.cidas, c.estas," + ;
                       " c.nums, c.compls, o.cdescrs" + ;
                       " FROM SigNfCor f, SigMvNfi n, SigCdCli c, SigCcOco o" + ;
                       " WHERE f.cnfis = n.nfis" + ;
                       " AND f.cemps = n.emps" + ;
                       " AND f.cseries = n.series"

            IF THIS.this_lEmpEdns .AND. !EMPTY(THIS.this_cEDNs)
                loc_cSQL = loc_cSQL + ;
                    " AND n.empdopnums = " + EscaparSQL(THIS.this_cEDNs)
            ENDIF

            loc_cSQL = loc_cSQL + ;
                " AND n.clifors = c.iclis" + ;
                " AND f.noccors = o.ncodigos" + ;
                " AND f.cemps = " + loc_cEmpsFmt + ;
                " AND f.cseries = " + loc_cSeriesFmt + ;
                " AND f.cnfis BETWEEN " + loc_cNFisDeF + ;
                " AND " + loc_cNFisAteFmt + ;
                " AND n.emis BETWEEN " + FormatarDataSQL(loc_dEmisDe) + ;
                " AND " + FormatarDataSQL(loc_dEmisAte) + ;
                " ORDER BY cemps, cseries, cnfis, noccors"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NfCorBase")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar notas fiscais"
                loc_lSucesso = .F.
            ENDIF

            *-- Cria cursor de saida com estrutura identica ao XCorNf do legado
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            CREATE CURSOR cursor_4c_XCorNf ;
                (cemps C(3), cseries C(3), cnfis C(6), noccors N(3), ;
                 mretifs M NULL, clifors C(10), emis D, correcs L, ;
                 rclis C(50), razaos C(50), endes C(60), ;
                 cidas C(30), estas C(2), nums C(10), compls C(25), ;
                 cdescrs C(30), numvias N(8))

            *-- Replica cada NF o numero de copias solicitado (numvias sequencial)
            loc_nCopias = THIS.this_nCopias
            IF loc_nCopias < 1
                loc_nCopias = 1
            ENDIF

            SELECT cursor_4c_NfCorBase
            GO TOP
            SCAN
                FOR loc_nVia = 1 TO loc_nCopias
                    SELECT cursor_4c_NfCorBase
                    SCATTER MEMVAR MEMO
                    SELECT cursor_4c_XCorNf
                    APPEND BLANK
                    GATHER MEMVAR MEMO
                    REPLACE numvias WITH loc_nVia
                ENDFOR
                SELECT cursor_4c_NfCorBase
            ENDSCAN

            USE IN cursor_4c_NfCorBase

            *-- Ordena cursor de saida por empresa/serie/nota/via
            SELECT cursor_4c_XCorNf
            INDEX ON cemps + cseries + cnfis + STR(numvias, 8) TAG XCorNfIdx

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            loc_cFrx = gc_4c_CaminhoReports + "SigReImc.frx"
            IF !FILE(loc_cFrx)
                THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + ;
                    "rio n" + CHR(227) + "o encontrado: " + loc_cFrx
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_XCorNf
            REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            loc_cFrx = gc_4c_CaminhoReports + "SigReImc.frx"
            IF !FILE(loc_cFrx)
                THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + ;
                    "rio n" + CHR(227) + "o encontrado: " + loc_cFrx
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_XCorNf
            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursor de saida
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_XCorNf")
            USE IN cursor_4c_XCorNf
        ENDIF
        IF USED("cursor_4c_NfCorBase")
            USE IN cursor_4c_NfCorBase
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

