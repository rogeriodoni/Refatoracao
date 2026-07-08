# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cabecalho' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Result' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGREDDP): Top original=149 vs migrado 'lbl_4c_Say4' Top=64 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReDdp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (684 linhas total):

*-- Linhas 75 a 83:
75:         loc_lSucesso   = .F.
76:         loc_lContinuar = .T.
77:         TRY
78:             THIS.Caption = "Demonstrativo de Balan" + CHR(231) + "o"
79: 
80:             IF TYPE("gc_4c_CaminhoIcones") = "U"
81:                 gc_4c_CaminhoIcones = ""
82:             ENDIF
83:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 100 a 109:
100:                 *-- PageFrame com pagina de filtros
101:                 THIS.ConfigurarPageFrame()
102: 
103:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
104:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
105: 
106:                 *-- Labels de filtro na Page1 (Say4 e LblData)
107:                 THIS.ConfigurarPaginaLista()
108: 
109:                 *-- TextBoxes de filtro na Page1 (entradas: Demonstrativo + DtFinal)

*-- Linhas 142 a 220:
142:     PROTECTED PROCEDURE ConfigurarCabecalho()
143:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
144:         WITH THIS.cnt_4c_Cabecalho
145:             .Top         = 0
146:             .Left        = 0
147:             .Width       = THIS.Width
148:             .Height      = 80
149:             .BackStyle   = 1
150:             .BackColor   = RGB(100, 100, 100)
151:             .BorderWidth = 0
152:             .Visible     = .T.
153: 
154:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
155:             .AddObject("lbl_4c_Sombra", "Label")
156:             WITH .lbl_4c_Sombra
157:                 .Top       = 22
158:                 .Left      = 22
159:                 .Width     = THIS.Width
160:                 .Height    = 30
161:                 .Caption   = "Demonstrativo de Balan" + CHR(231) + "o"
162:                 .FontName  = "Tahoma"
163:                 .FontSize  = 14
164:                 .FontBold  = .T.
165:                 .ForeColor = RGB(0, 0, 0)
166:                 .BackStyle = 0
167:                 .Visible   = .T.
168:             ENDWITH
169: 
170:             *-- Titulo em branco (sobre a sombra)
171:             .AddObject("lbl_4c_Titulo", "Label")
172:             WITH .lbl_4c_Titulo
173:                 .Top       = 20
174:                 .Left      = 20
175:                 .Width     = THIS.Width
176:                 .Height    = 30
177:                 .Caption   = "Demonstrativo de Balan" + CHR(231) + "o"
178:                 .FontName  = "Tahoma"
179:                 .FontSize  = 14
180:                 .FontBold  = .T.
181:                 .ForeColor = RGB(255, 255, 255)
182:                 .BackStyle = 0
183:                 .Visible   = .T.
184:             ENDWITH
185:         ENDWITH
186:     ENDPROC
187: 
188:     *--------------------------------------------------------------------------
189:     * ConfigurarBotoes - CommandGroup de botoes de relatorio (btnReport area)
190:     *   Original: btnReport.Top=3, Left=526, Width~273, Height=80
191:     *   Botoes: Visualiza(6), Imprime(72), DocExcel(138), Sair(204)
192:     *   Geometria conforme framework (relatorio_video_26, impressora_26, excel_26, sair_60)
193:     *--------------------------------------------------------------------------
194:     PROTECTED PROCEDURE ConfigurarBotoes()
195:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
196:         WITH THIS.cmg_4c_Botoes
197:             .Top           = 0
198:             .Left          = 529
199:             .Width         = 273
200:             .Height        = 80
201:             .ButtonCount   = 4
202:             .BackStyle     = 0
203:             .BorderStyle   = 0
204:             .BorderColor   = RGB(136, 189, 188)
205:             .SpecialEffect = 1
206:             .Themes        = .F.
207:             .Visible       = .T.
208: 
209:             *-- Visualizar (preview em tela)
210:             WITH .Buttons(1)
211:                 .Top             = 5
212:                 .Left            = 5
213:                 .Width           = 65
214:                 .Height          = 70
215:                 .Caption         = "Visualizar"
216:                 .FontBold        = .T.
217:                 .FontItalic      = .T.
218:                 .BackColor       = RGB(255, 255, 255)
219:                 .ForeColor       = RGB(90, 90, 90)
220:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 228 a 240:
228: 
229:             *-- Imprimir (impressora padrao)
230:             WITH .Buttons(2)
231:                 .Top             = 5
232:                 .Left            = 71
233:                 .Width           = 65
234:                 .Height          = 70
235:                 .Caption         = "Imprimir"
236:                 .FontName        = "Tahoma"
237:                 .FontBold        = .T.
238:                 .FontItalic      = .T.
239:                 .FontSize        = 8
240:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 250 a 262:
250: 
251:             *-- Excel (exportar dados)
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

*-- Linhas 272 a 284:
272: 
273:             *-- Encerrar (fechar form)
274:             WITH .Buttons(4)
275:                 .Top             = 5
276:                 .Left            = 203
277:                 .Width           = 65
278:                 .Height          = 70
279:                 .Caption         = "Encerrar"
280:                 .Cancel          = .T.
281:                 .FontName        = "Tahoma"
282:                 .FontBold        = .T.
283:                 .FontItalic      = .T.
284:                 .FontSize        = 8

*-- Linhas 308 a 322:
308: 
309:         loc_oPgf.PageCount = 1
310: 
311:         loc_oPgf.Top    = 85
312:         loc_oPgf.Left   = -1
313:         loc_oPgf.Width  = THIS.Width + 2
314:         loc_oPgf.Height = THIS.Height - 85
315:         loc_oPgf.Tabs   = .F.
316: 
317:         loc_oPgf.Page1.Caption   = "Filtros"
318:         loc_oPgf.Page1.FontName  = "Tahoma"
319:         loc_oPgf.Page1.FontSize  = 8
320:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
321:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
322:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 337 a 366:
337:         loc_oPg = THIS.pgf_4c_Paginas.Page1
338: 
339:         *-- Label "Tipo : " (Say4 original: Top=149, Left=301)
340:         loc_oPg.AddObject("lbl_4c_Say4", "Label")
341:         WITH loc_oPg.lbl_4c_Say4
342:             .Top       = 64
343:             .Left      = 301
344:             .Width     = 35
345:             .Height    = 17
346:             .Caption   = "Tipo : "
347:             .FontName  = "Tahoma"
348:             .FontSize  = 8
349:             .ForeColor = RGB(90, 90, 90)
350:             .BackStyle = 0
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         *-- Label "Data : " (lbl_vencimento original: Top=174, Left=298, W=35)
355:         loc_oPg.AddObject("lbl_4c_LblData", "Label")
356:         WITH loc_oPg.lbl_4c_LblData
357:             .Top       = 91
358:             .Left      = 298
359:             .Width     = 35
360:             .Height    = 17
361:             .Caption   = "Data : "
362:             .FontName  = "Tahoma"
363:             .FontSize  = 8
364:             .ForeColor = RGB(90, 90, 90)
365:             .BackStyle = 0
366:             .AutoSize  = .T.

*-- Linhas 382 a 391:
382:         *-- TextBox Demonstrativo (Get_Demonstrativo: nome do demonstrativo de balanco)
383:         loc_oPg.AddObject("txt_4c_Demonstrativo", "TextBox")
384:         WITH loc_oPg.txt_4c_Demonstrativo
385:             .Top         = 59
386:             .Left        = 336
387:             .Width       = 154
388:             .Height      = 25
389:             .Value       = ""
390:             .MaxLength   = 20
391:             .Format      = "K"

*-- Linhas 401 a 410:
401:         *-- TextBox Data final (get_dt_final original: Top=171, Left=336, W=80)
402:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
403:         WITH loc_oPg.txt_4c_DtFinal
404:             .Top         = 86
405:             .Left        = 336
406:             .Width       = 80
407:             .Height      = 25
408:             .Value       = {}
409:             .MaxLength   = 10
410:             .Format      = "D"

*-- Linhas 631 a 639:
631:             IF EMPTY(.this_dDtFinal)
632:                 loc_oPg.txt_4c_DtFinal.Value = DATE()
633:             ELSE
634:                 loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
635:             ENDIF
636:         ENDWITH
637:     ENDPROC
638: 
639:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SigReDdpBO.prg):
*==============================================================================
* SIGREDDPBO.PRG
* Business Object para o Relatorio Demonstrativo de Balanco (SigReDdp)
*
* Herda de: RelatorioBase
* Tipo: REPORT
*
* Filtros do formulario:
*   this_cNome     - Nome do demonstrativo (Get_Demonstrativo / SigPrDmo.Nome)
*   this_dDtFinal  - Data de referencia para apuracao do saldo (get_dt_final)
*
* Processamento (PrepararDados):
*   1. Carrega parametro Ouros de SigCdPam
*   2. Carrega clientes de SigCdCli (para lookup IClis -> RClis)
*   3. Busca configuracao do demonstrativo em SigPrDmo (Grupos, Contas)
*   4. Apura saldo inicial via SigCdFcx + SigOpCfe (CPros = Ouros)
*   5. Processa linhas SigCdDpr:
*      - Operas='E'/'S': entradas/saidas de SigCdFes por TpOps
*      - Operas='P'    : pesagens de SigOpCfe por SigCdCli
*      - Operas='H'    : historico de estoque via SigMvEst + SigMvHst
*      - Operas='T'    : insere linha de sub-total/total geral
*   6. Monta cursor_4c_Cabecalho com empresa, titulo e periodo
*   7. Monta cursor_4c_Result com todas as linhas do demonstrativo
*
* Relatorio FRX: SigReDdp.frx (na pasta gc_4c_CaminhoReports)
*==============================================================================

DEFINE CLASS SigReDdpBO AS RelatorioBase

    *-- Filtros recebidos via FormParaRelatorio()
    this_cNome              = ""    && Nome do demonstrativo (SigPrDmo.Nome)
    this_dDtFinal           = {}    && Data final de referencia para apuracao

    *-- Cursor principal de saida (populado por PrepararDados)
    this_cCursorDados       = "cursor_4c_Result"

    *-- Titulo do relatorio (exibido no cabecalho)
    this_cTituloRelatorio   = ""

    *--------------------------------------------------------------------------
    * Init - Construtor: configura identificacao e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela           = "SigReDdp"
        THIS.this_cCampoChave       = "Nome"
        THIS.this_cTituloRelatorio  = "Demonstrativo de Balan" + CHR(231) + "o"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                loc_cArquivo = gc_4c_CaminhoReports + "SigReDdp.frx"
                REPORT FORM (loc_cArquivo) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(loc_oErro.Message, "Erro em Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                loc_cArquivo = gc_4c_CaminhoReports + "SigReDdp.frx"
                REPORT FORM (loc_cArquivo) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(loc_oErro.Message, "Erro em Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor_4c_Cabecalho e cursor_4c_Result
    * Replica a logica do procedure 'processamento' do form original SIGREDDP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lcConfig, loc_ldFinal
        LOCAL loc_lcCbEmpresa, loc_lcCbTitulo, loc_lcCbPeriodo
        LOCAL loc_lnSaldo, loc_lnSubTotal
        LOCAL loc_lcOuros
        LOCAL loc_lcPrDmoGrupos, loc_lcPrDmoContas
        LOCAL loc_lcNome, loc_lnQtde, loc_lnPeso, loc_lnOrdem
        LOCAL loc_lcDprGrupos, loc_lcDprContas, loc_lcDprTpOps
        LOCAL loc_lcDprOperas, loc_lnDprOrdems
        LOCAL loc_lcDprGruposH, loc_lcDprContasH
        LOCAL loc_lcPGrI, loc_lcPGrF, loc_lcEstos
        LOCAL loc_lcCodigos
        LOCAL loc_oErro

        loc_lSucesso   = .F.
        loc_lnSaldo    = 0
        loc_lnSubTotal = 0
        loc_lcNome     = ""
        loc_lnQtde     = 0
        loc_lnPeso     = 0
        loc_lnOrdem    = 0

        TRY
            loc_lcConfig = ALLTRIM(THIS.this_cNome)
            loc_ldFinal  = THIS.this_dDtFinal

            IF EMPTY(loc_lcConfig) OR EMPTY(loc_ldFinal)
                THIS.this_cMensagemErro = "Preencha o Demonstrativo e a Data"
                ERROR "Filtros invalidos"
            ENDIF

            *-- Limpa cursores de saida de execucao anterior
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Result")
                USE IN cursor_4c_Result
            ENDIF

            *-- 1. Carrega parametro Ouros de SigCdPam
            loc_cSQL = "SELECT Ouros FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar SigCdPam"
                ERROR "Falha SQL"
            ENDIF
            SELECT cursor_4c_SigCdPam
            GO TOP
            loc_lcOuros = ALLTRIM(cursor_4c_SigCdPam.Ouros)
            USE IN cursor_4c_SigCdPam

            *-- 2. Carrega clientes para lookup IClis -> RClis
            loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdCli")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar SigCdCli"
                ERROR "Falha SQL"
            ENDIF
            SELECT cursor_4c_SigCdCli
            INDEX ON IClis TAG IClis

            loc_lcCbEmpresa = go_4c_Sistema.cCodEmpresa

            loc_lcCbTitulo  = "Demonstrativo de Balan" + CHR(231) + "o " + loc_lcConfig
            loc_lcCbPeriodo = "Data : " + DTOC(loc_ldFinal)

            *-- 4. Cria cursores de saida
            CREATE CURSOR cursor_4c_Cabecalho ;
                (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80), SdInicial N(12,3))
            INSERT INTO cursor_4c_Cabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                   VALUES (loc_lcCbEmpresa, loc_lcCbTitulo, loc_lcCbPeriodo)

            CREATE CURSOR cursor_4c_Result ;
                (Ordem N(3), Grupos C(10), Contas C(10), Nome C(50), ;
                 TpOps C(15), Operas C(1), Qtds N(12,3))
            INDEX ON Ordem TAG Ordem

            *-- 5. Busca configuracao do demonstrativo em SigPrDmo
            loc_cSQL = "SELECT Grupos, Contas FROM SigPrDmo " + ;
                       "WHERE Nome = " + EscaparSQL(loc_lcConfig)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrDmo")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar SigPrDmo"
                ERROR "Falha SQL"
            ENDIF
            SELECT cursor_4c_SigPrDmo
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + ;
                                          "o encontrado: " + loc_lcConfig
                USE IN cursor_4c_SigPrDmo
                ERROR "Demonstrativo nao encontrado"
            ENDIF
            loc_lcPrDmoGrupos = ALLTRIM(cursor_4c_SigPrDmo.Grupos)
            loc_lcPrDmoContas = ALLTRIM(cursor_4c_SigPrDmo.Contas)
            USE IN cursor_4c_SigPrDmo

            *-- 6. Apuracao do Saldo Inicial: fecha mais recente via SigCdFcx
            loc_cSQL = "SELECT Emps, Grupos, Contas, Datas, Codigos FROM SigCdFcx " + ;
                       "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND Grupos = " + EscaparSQL(loc_lcPrDmoGrupos) + ;
                       " AND Contas = " + EscaparSQL(loc_lcPrDmoContas) + ;
                       " AND Datas <= " + FormatarDataSQL(loc_ldFinal) + ;
                       " ORDER BY Emps, Grupos, Contas, Datas, Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdFcx")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar SigCdFcx (Saldo Inicial)"
                ERROR "Falha SQL"
            ENDIF

            SELECT cursor_4c_SigCdFcx
            INDEX ON DTOS(Datas) TAG GrConDat
            SET ORDER TO GrConDat DESCENDING
            SET NEAR ON
            SEEK DTOS(loc_ldFinal)
            SET NEAR OFF
            SET ORDER TO GrConDat ASCENDING

            SCAN WHILE Datas <= loc_ldFinal
                loc_lcCodigos = ALLTRIM(STR(cursor_4c_SigCdFcx.Codigos))

                loc_cSQL = "SELECT Emps, Codigos, CPros, Saldos FROM SigOpCfe " + ;
                           "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND Codigos = " + loc_lcCodigos + ;
                           " ORDER BY Emps, Codigos, CPros, Saldos"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpCfe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar SigOpCfe (Saldo)"
                    ERROR "Falha SQL"
                ENDIF

                SELECT cursor_4c_SigOpCfe
                SCAN
                    IF ALLTRIM(cursor_4c_SigOpCfe.CPros) = loc_lcOuros
                        loc_lnQtde  = cursor_4c_SigOpCfe.Saldos
                        loc_lnSaldo = loc_lnSaldo + loc_lnQtde
                        INSERT INTO cursor_4c_Result (Grupos, Contas, TpOps, Qtds) ;
                               VALUES (loc_lcPrDmoGrupos, loc_lcPrDmoContas, ;
                                       "Saldo Inicial", loc_lnQtde)
                    ENDIF
                ENDSCAN
                IF USED("cursor_4c_SigOpCfe")
                    USE IN cursor_4c_SigOpCfe
                ENDIF
                SELECT cursor_4c_SigCdFcx
            ENDSCAN
            IF USED("cursor_4c_SigCdFcx")
                USE IN cursor_4c_SigCdFcx
            ENDIF

            *-- Grava saldo inicial no cabecalho
            SELECT cursor_4c_Cabecalho
            GO TOP
            REPLACE cursor_4c_Cabecalho.SdInicial WITH loc_lnSaldo
            loc_lnSubTotal = loc_lnSaldo

            *-- 7. Busca e processa linhas do demonstrativo (SigCdDpr)
            loc_cSQL = "SELECT Nome, Ordems, Grupos, Contas, Operas, TpOps FROM SigCdDpr " + ;
                       "WHERE Nome = " + EscaparSQL(loc_lcConfig) + ;
                       " ORDER BY Nome, Ordems, Grupos, Contas, Operas, TpOps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdDpr")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar SigCdDpr"
                ERROR "Falha SQL"
            ENDIF

            SELECT cursor_4c_SigCdDpr
            SCAN

                IF ALLTRIM(cursor_4c_SigCdDpr.Operas) = "T"
                    *-- Sub-Total ou Total Geral
                    INSERT INTO cursor_4c_Result (Operas, Qtds, Ordem, Nome) ;
                           VALUES ("T", loc_lnSubTotal, cursor_4c_SigCdDpr.Ordems, ;
                                   IIF(cursor_4c_SigCdDpr.Ordems = 999, ;
                                       "Total Geral", "Sub-Total"))
                    LOOP
                ENDIF

                IF INLIST(ALLTRIM(cursor_4c_SigCdDpr.Operas), "E", "S", "P")
                    *-- Entradas, Saidas ou Pesagens
                    loc_lcDprGrupos = ALLTRIM(cursor_4c_SigCdDpr.Grupos)
                    loc_lcDprContas = ALLTRIM(cursor_4c_SigCdDpr.Contas)
                    loc_lcDprTpOps  = ALLTRIM(cursor_4c_SigCdDpr.TpOps)
                    loc_lcDprOperas = ALLTRIM(cursor_4c_SigCdDpr.Operas)
                    loc_lnDprOrdems = cursor_4c_SigCdDpr.Ordems

                    loc_cSQL = "SELECT Emps, Grupos, Contas, Datas, Codigos FROM SigCdFcx " + ;
                               "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                               " AND Grupos = " + EscaparSQL(loc_lcDprGrupos) + ;
                               " AND Contas = " + EscaparSQL(loc_lcDprContas) + ;
                               " AND Datas <= " + FormatarDataSQL(loc_ldFinal) + ;
                               " ORDER BY Emps, Grupos, Contas, Datas, Codigos"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdFcx")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro ao buscar SigCdFcx (linhas)"
                        ERROR "Falha SQL"
                    ENDIF

                    SELECT cursor_4c_SigCdFcx
                    INDEX ON DTOS(Datas) TAG GrConDat
                    SET ORDER TO GrConDat DESCENDING
                    SET NEAR ON
                    SEEK DTOS(loc_ldFinal)
                    SET NEAR OFF
                    SET ORDER TO GrConDat ASCENDING

                    SCAN WHILE Datas <= loc_ldFinal
                        loc_lcCodigos = ALLTRIM(STR(cursor_4c_SigCdFcx.Codigos))

                        IF loc_lcDprOperas = "P"
                            *-- Pesagens: busca nome do cliente por Contas = IClis
                            IF SEEK(loc_lcDprContas, "cursor_4c_SigCdCli", "IClis")
                                loc_lcNome = ALLTRIM(cursor_4c_SigCdCli.Rclis)
                            ELSE
                                loc_lcNome = ""
                            ENDIF

                            loc_cSQL = "SELECT Emps, Codigos, CPros, Pesagems FROM SigOpCfe " + ;
                                       "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                                       " AND Codigos = " + loc_lcCodigos + ;
                                       " ORDER BY Emps, Codigos, CPros, Pesagems"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpCfe")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Erro ao buscar SigOpCfe (Pesagens)"
                                ERROR "Falha SQL"
                            ENDIF

                            SELECT cursor_4c_SigOpCfe
                            SCAN
                                IF ALLTRIM(cursor_4c_SigOpCfe.CPros) = loc_lcOuros
                                    INSERT INTO cursor_4c_Result ;
                                           (Grupos, Contas, Nome, TpOps, Operas, Qtds, Ordem) ;
                                           VALUES (loc_lcDprGrupos, loc_lcDprContas, ;
                                                   loc_lcNome, "PESAGEM", loc_lcDprOperas, ;
                                                   cursor_4c_SigOpCfe.Pesagems, loc_lnDprOrdems)
                                    loc_lnSubTotal = loc_lnSubTotal - cursor_4c_SigOpCfe.Pesagems
                                ENDIF
                            ENDSCAN
                            IF USED("cursor_4c_SigOpCfe")
                                USE IN cursor_4c_SigOpCfe
                            ENDIF
                            SELECT cursor_4c_SigCdFcx

                        ELSE
                            *-- Entradas (E) ou Saidas (S): busca em SigCdFes por TpOps
                            loc_cSQL = "SELECT Emps, Codigos, CPros, TpOps, " + ;
                                       "PesoEnts, PesoSais FROM SigCdFes " + ;
                                       "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                                       " AND Codigos = " + loc_lcCodigos + ;
                                       " ORDER BY Emps, Codigos, CPros, TpOps, PesoEnts, PesoSais"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdFes")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Erro ao buscar SigCdFes"
                                ERROR "Falha SQL"
                            ENDIF

                            SELECT cursor_4c_SigCdFes
                            SCAN
                                IF ALLTRIM(cursor_4c_SigCdFes.CPros) = loc_lcOuros ;
                                   AND ALLTRIM(cursor_4c_SigCdFes.TpOps) = loc_lcDprTpOps
                                    IF SEEK(loc_lcDprContas, "cursor_4c_SigCdCli", "IClis")
                                        loc_lcNome = ALLTRIM(cursor_4c_SigCdCli.Rclis)
                                    ELSE
                                        loc_lcNome = ""
                                    ENDIF
                                    loc_lnQtde = IIF(loc_lcDprOperas = "E", ;
                                                     cursor_4c_SigCdFes.PesoEnts, ;
                                                     cursor_4c_SigCdFes.PesoSais)
                                    INSERT INTO cursor_4c_Result ;
                                           (Grupos, Contas, Nome, TpOps, Operas, Qtds, Ordem) ;
                                           VALUES (loc_lcDprGrupos, loc_lcDprContas, ;
                                                   loc_lcNome, ;
                                                   ALLTRIM(cursor_4c_SigCdFes.TpOps), ;
                                                   loc_lcDprOperas, loc_lnQtde, loc_lnDprOrdems)
                                    IF loc_lcDprOperas = "E"
                                        loc_lnSubTotal = loc_lnSubTotal + loc_lnQtde
                                    ELSE
                                        loc_lnSubTotal = loc_lnSubTotal - loc_lnQtde
                                    ENDIF
                                ENDIF
                            ENDSCAN
                            IF USED("cursor_4c_SigCdFes")
                                USE IN cursor_4c_SigCdFes
                            ENDIF
                            SELECT cursor_4c_SigCdFcx
                        ENDIF
                    ENDSCAN
                    IF USED("cursor_4c_SigCdFcx")
                        USE IN cursor_4c_SigCdFcx
                    ENDIF
                    SELECT cursor_4c_SigCdDpr

                ELSE
                    *-- Operas = 'H': Historico de estoque via SigMvEst + SigMvHst
                    *-- lnOrdem e lcNome capturados do primeiro registro H do grupo
                    loc_lnPeso  = 0
                    loc_lnOrdem = cursor_4c_SigCdDpr.Ordems

                    IF EMPTY(ALLTRIM(cursor_4c_SigCdDpr.Contas))
                        loc_lcNome = "Saldo das Fases"
                    ELSE
                        IF SEEK(cursor_4c_SigCdDpr.Contas, "cursor_4c_SigCdCli", "IClis")
                            loc_lcNome = ALLTRIM(cursor_4c_SigCdCli.Rclis)
                        ELSE
                            loc_lcNome = ""
                        ENDIF
                    ENDIF

                    *-- SCAN aninhado: acumula peso de todos os registros H consecutivos
                    SCAN WHILE ALLTRIM(cursor_4c_SigCdDpr.Nome) = loc_lcConfig ;
                           AND ALLTRIM(cursor_4c_SigCdDpr.Operas) = "H"

                        loc_lcDprGruposH = ALLTRIM(cursor_4c_SigCdDpr.Grupos)
                        loc_lcDprContasH = ALLTRIM(cursor_4c_SigCdDpr.Contas)
                        loc_lcPGrI = loc_lcDprContasH
                        loc_lcPGrF = IIF(EMPTY(loc_lcDprContasH), ;
                                         REPLICATE(CHR(254), 20), loc_lcDprContasH)

                        *-- Busca estoques em SigMvEst via EmpGruEsts (coluna computada)
                        loc_cSQL = "SELECT Emps, Grupos, Estos, CPros FROM SigMvEst " + ;
                                   "WHERE EmpGruEsts BETWEEN " + ;
                                         EscaparSQL(go_4c_Sistema.cCodEmpresa + ;
                                                    loc_lcDprGruposH + loc_lcPGrI) + ;
                                   " AND " + EscaparSQL(go_4c_Sistema.cCodEmpresa + ;
                                                        loc_lcDprGruposH + loc_lcPGrF) + ;
                                   " AND CPros = " + EscaparSQL(loc_lcOuros) + ;
                                   " AND NOT Sqtds = 0" + ;
                                   " ORDER BY Emps, Grupos, Estos, CPros"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvEst")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Erro ao buscar SigMvEst"
                            ERROR "Falha SQL"
                        ENDIF

                        SELECT cursor_4c_SigMvEst
                        INDEX ON Emps + Grupos + Estos + CPros TAG EmpEstPro
                        SET ORDER TO EmpEstPro
                        SET NEAR ON
                        SEEK go_4c_Sistema.cCodEmpresa + loc_lcDprGruposH + ;
                             loc_lcDprContasH + loc_lcOuros
                        SET NEAR OFF

                        SCAN WHILE go_4c_Sistema.cCodEmpresa + loc_lcDprGruposH = ;
                                        ALLTRIM(Emps) + ALLTRIM(Grupos) ;
                                   AND ALLTRIM(Estos) = loc_lcDprContasH
                            loc_lcEstos = ALLTRIM(cursor_4c_SigMvEst.Estos)

                            *-- Busca saldo mais recente ate loc_ldFinal em SigMvHst
                            loc_cSQL = "SELECT TOP 1 EmpGruEsts, CPros, cIdChaves, Sqtds " + ;
                                       "FROM SigMvHst " + ;
                                       "WHERE EmpGruEsts = " + ;
                                             EscaparSQL(go_4c_Sistema.cCodEmpresa + ;
                                                        loc_lcDprGruposH + loc_lcEstos) + ;
                                       " AND CPros = " + EscaparSQL(loc_lcOuros) + ;
                                       " AND Datas <= " + FormatarDataSQL(loc_ldFinal) + ;
                                       " ORDER BY EmpGruEsts ASC, CPros ASC, cIdChaves DESC"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvHst")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Erro ao buscar SigMvHst"
                                ERROR "Falha SQL"
                            ENDIF

                            SELECT cursor_4c_SigMvHst
                            GO TOP
                            IF !EOF()
                                loc_lnPeso = loc_lnPeso + cursor_4c_SigMvHst.Sqtds
                            ENDIF
                            IF USED("cursor_4c_SigMvHst")
                                USE IN cursor_4c_SigMvHst
                            ENDIF
                            SELECT cursor_4c_SigMvEst
                        ENDSCAN
                        IF USED("cursor_4c_SigMvEst")
                            USE IN cursor_4c_SigMvEst
                        ENDIF
                        SELECT cursor_4c_SigCdDpr
                    ENDSCAN
                    *-- Apos ENDSCAN cursor esta no primeiro registro nao-H (ou EOF)

                    IF loc_lnPeso <> 0
                        INSERT INTO cursor_4c_Result ;
                               (Grupos, Contas, Nome, Operas, Qtds, Ordem) ;
                               VALUES (cursor_4c_SigCdDpr.Grupos, ;
                                       cursor_4c_SigCdDpr.Contas, ;
                                       loc_lcNome, "H", loc_lnPeso, loc_lnOrdem)
                        loc_lnSubTotal = loc_lnSubTotal + loc_lnPeso
                    ENDIF

                    SELECT cursor_4c_SigCdDpr
                    SKIP -1
                ENDIF

            ENDSCAN

            IF USED("cursor_4c_SigCdDpr")
                USE IN cursor_4c_SigCdDpr
            ENDIF
            IF USED("cursor_4c_SigCdCli")
                USE IN cursor_4c_SigCdCli
            ENDIF

            SELECT cursor_4c_Result
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")

            *-- Fecha cursores de saida (dados incompletos)
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Result")
                USE IN cursor_4c_Result
            ENDIF
            *-- Fecha cursores intermediarios
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF
            IF USED("cursor_4c_SigCdCli")
                USE IN cursor_4c_SigCdCli
            ENDIF
            IF USED("cursor_4c_SigPrDmo")
                USE IN cursor_4c_SigPrDmo
            ENDIF
            IF USED("cursor_4c_SigCdFcx")
                USE IN cursor_4c_SigCdFcx
            ENDIF
            IF USED("cursor_4c_SigOpCfe")
                USE IN cursor_4c_SigOpCfe
            ENDIF
            IF USED("cursor_4c_SigCdFes")
                USE IN cursor_4c_SigCdFes
            ENDIF
            IF USED("cursor_4c_SigCdDpr")
                USE IN cursor_4c_SigCdDpr
            ENDIF
            IF USED("cursor_4c_SigMvEst")
                USE IN cursor_4c_SigMvEst
            ENDIF
            IF USED("cursor_4c_SigMvHst")
                USE IN cursor_4c_SigMvHst
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de um cursor
    *
    * Permite recuperar configuracao de filtros previamente salva (ex: historico
    * de relatorios). Mapeia colunas do cursor para propriedades this_cNome e
    * this_dDtFinal deste BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                                      "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            IF !EOF() AND !BOF()
                IF TYPE("Nome") = "C"
                    THIS.this_cNome = ALLTRIM(NVL(EVALUATE("Nome"), ""))
                ENDIF
                IF TYPE("DtFinal") = "D"
                    THIS.this_dDtFinal = NVL(EVALUATE("DtFinal"), {})
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de filtros est" + CHR(225) + " vazio"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de inser" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "Inserir")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de atualiza" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "Atualizar")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao da configuracao atual
    *
    * Como nao ha registro persistido, retorna concatenacao dos filtros
    * atualmente carregados (usado para auditoria/log de execucoes).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF !EMPTY(THIS.this_cNome)
            loc_cChave = "DEMONSTRATIVO=" + ALLTRIM(THIS.this_cNome)
        ENDIF
        IF !EMPTY(THIS.this_dDtFinal)
            IF !EMPTY(loc_cChave)
                loc_cChave = loc_cChave + "|"
            ENDIF
            loc_cChave = loc_cChave + "DTFINAL=" + DTOC(THIS.this_dDtFinal)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *
    * Grava evento de impressao/visualizacao do relatorio em LogAuditoria
    * para rastreabilidade de quem executou o Demonstrativo de Balanco
    * e com quais filtros (nome do demonstrativo + data final).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            IF EMPTY(loc_cUsuario)
                loc_cUsuario = "SISTEMA"
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChaveRegistro, DadosNovos) " + ;
                       "VALUES (" + ;
                       FormatarDataSQL(DATETIME()) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL(NVL(par_cOperacao, "RELATORIO")) + ", " + ;
                       EscaparSQL("SigReDdp") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL("Demonstrativo de Balan" + CHR(231) + "o") + ;
                       ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "RegistrarAuditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

