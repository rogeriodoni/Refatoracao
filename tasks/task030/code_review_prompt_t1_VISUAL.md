# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cabecalho' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreani.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (663 linhas total):

*-- Linhas 14 a 22:
14: *   lbl_a (a-grave): Top=172, Left=433
15: *   get_dt_final  : Top=168, Left=444, Width=45, InputMask="99/99"
16: *
17: * PageFrame.Top=85 -> posicoes em Page1 = posicao_original - 85
18: *==============================================================================
19: 
20: DEFINE CLASS Formsigreani AS FormBase
21: 
22:     *-- Dimensoes exatas do original: Width=800, Height=300

*-- Linhas 53 a 61:
53:         loc_lSucesso   = .F.
54:         loc_lContinuar = .T.
55:         TRY
56:             THIS.Caption = "Relat" + CHR(243) + "rio de Aniversariantes"
57: 
58:             IF TYPE("gc_4c_CaminhoIcones") = "U"
59:                 gc_4c_CaminhoIcones = ""
60:             ENDIF
61:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 83 a 92:
83:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
84: 
85:                 THIS.LimparCampos()
86:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
87:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
88:                 loc_lSucesso = .T.
89:             ENDIF
90:         CATCH TO loc_oErro
91:             THIS.this_cMensagemErro = loc_oErro.Message
92:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 103 a 141:
103:     PROTECTED PROCEDURE ConfigurarCabecalho()
104:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
105:         WITH THIS.cnt_4c_Cabecalho
106:             .Top         = 0
107:             .Left        = 0
108:             .Width       = THIS.Width
109:             .Height      = 80
110:             .BackStyle   = 1
111:             .BackColor   = RGB(100, 100, 100)
112:             .BorderWidth = 0
113:             .Visible     = .T.
114: 
115:             .AddObject("lbl_4c_Sombra", "Label")
116:             WITH .lbl_4c_Sombra
117:                 .Top       = 22
118:                 .Left      = 22
119:                 .Width     = THIS.Width
120:                 .Height    = 30
121:                 .Caption   = "Relat" + CHR(243) + "rio de Aniversariantes"
122:                 .FontName  = "Tahoma"
123:                 .FontSize  = 14
124:                 .FontBold  = .T.
125:                 .ForeColor = RGB(0, 0, 0)
126:                 .BackStyle = 0
127:                 .Visible   = .T.
128:             ENDWITH
129: 
130:             .AddObject("lbl_4c_Titulo", "Label")
131:             WITH .lbl_4c_Titulo
132:                 .Top       = 20
133:                 .Left      = 20
134:                 .Width     = THIS.Width
135:                 .Height    = 30
136:                 .Caption   = "Relat" + CHR(243) + "rio de Aniversariantes"
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 14
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(255, 255, 255)
141:                 .BackStyle = 0

*-- Linhas 149 a 179:
149:     *   Geometria EXATA do framework frmrelatorio (regras criticas):
150:     *     Top=0, Left=529, Width=273, Height=80, ButtonCount=4
151:     *     Lefts dos botoes: 5 / 71 / 137 / 203 (incrementos de 66)
152:     *   btnReport.Left=526 no original -> arredondado para 529.
153:     *--------------------------------------------------------------------------
154:     PROTECTED PROCEDURE ConfigurarBotoes()
155:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
156:         WITH THIS.cmg_4c_Botoes
157:             .Top           = 0
158:             .Left          = 529
159:             .Width         = 273
160:             .Height        = 80
161:             .ButtonCount   = 4
162:             .BackStyle     = 0
163:             .BorderStyle   = 0
164:             .BorderColor   = RGB(136, 189, 188)
165:             .SpecialEffect = 1
166:             .Themes        = .F.
167:             .Visible       = .T.
168: 
169:             WITH .Buttons(1)
170:                 .Top             = 5
171:                 .Left            = 5
172:                 .Width           = 65
173:                 .Height          = 70
174:                 .Caption         = "Visualizar"
175:                 .FontBold        = .T.
176:                 .FontItalic      = .T.
177:                 .BackColor       = RGB(255, 255, 255)
178:                 .ForeColor       = RGB(90, 90, 90)
179:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 186 a 198:
186:             ENDWITH
187: 
188:             WITH .Buttons(2)
189:                 .Top             = 5
190:                 .Left            = 71
191:                 .Width           = 65
192:                 .Height          = 70
193:                 .Caption         = "Imprimir"
194:                 .FontName        = "Tahoma"
195:                 .FontBold        = .T.
196:                 .FontItalic      = .T.
197:                 .FontSize        = 8
198:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 207 a 219:
207:             ENDWITH
208: 
209:             WITH .Buttons(3)
210:                 .Top             = 5
211:                 .Left            = 137
212:                 .Width           = 65
213:                 .Height          = 70
214:                 .Caption         = "Excel"
215:                 .FontName        = "Tahoma"
216:                 .FontBold        = .T.
217:                 .FontItalic      = .T.
218:                 .FontSize        = 8
219:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 228 a 240:
228:             ENDWITH
229: 
230:             WITH .Buttons(4)
231:                 .Top             = 5
232:                 .Left            = 203
233:                 .Width           = 65
234:                 .Height          = 70
235:                 .Caption         = "Encerrar"
236:                 .Cancel          = .T.
237:                 .FontName        = "Tahoma"
238:                 .FontBold        = .T.
239:                 .FontItalic      = .T.
240:                 .FontSize        = 8

*-- Linhas 265 a 279:
265: 
266:         loc_oPgf.PageCount = 1
267: 
268:         loc_oPgf.Top    = 85
269:         loc_oPgf.Left   = -1
270:         loc_oPgf.Width  = THIS.Width + 2
271:         loc_oPgf.Height = THIS.Height - 85
272:         loc_oPgf.Tabs   = .F.
273: 
274:         loc_oPgf.Page1.Caption   = "Filtros"
275:         loc_oPgf.Page1.FontName  = "Tahoma"
276:         loc_oPgf.Page1.FontSize  = 8
277:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
278:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
279:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 285 a 321:
285:     *--------------------------------------------------------------------------
286:     * ConfigurarPaginaLista - Filtros de periodo (unica pagina do relatorio)
287:     *   Posicoes em Page1 = posicao_original - PageFrame.Top(85):
288:     *   lbl_periodo   (Top=172) -> Page1.Top = 87, Left=333
289:     *   txt_4c_DtInicial (Top=168) -> Page1.Top = 83, Left=384, Width=45
290:     *   lbl_4c_LblA   (Top=172) -> Page1.Top = 87, Left=433
291:     *   txt_4c_DtFinal   (Top=168) -> Page1.Top = 83, Left=444, Width=45
292:     *--------------------------------------------------------------------------
293:     PROTECTED PROCEDURE ConfigurarPaginaLista()
294:         LOCAL loc_oPg
295:         loc_oPg = THIS.pgf_4c_Paginas.Page1
296: 
297:         *-- Label "Periodo :" (lbl_periodo: Left=333, Top=172)
298:         loc_oPg.AddObject("lbl_4c_Periodo", "Label")
299:         WITH loc_oPg.lbl_4c_Periodo
300:             .Top       = 87
301:             .Left      = 333
302:             .AutoSize  = .T.
303:             .Caption   = "Periodo :"
304:             .FontName  = "Tahoma"
305:             .FontSize  = 8
306:             .ForeColor = RGB(90, 90, 90)
307:             .BackStyle = 0
308:             .Visible   = .T.
309:         ENDWITH
310: 
311:         *-- Data Inicial (get_dt_inicial: Left=384, Top=168, Width=45, InputMask="99/99")
312:         *   Value=DATE() (inicializado em LimparCampos) - somente DD/MM e usado
313:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
314:         WITH loc_oPg.txt_4c_DtInicial
315:             .Top           = 83
316:             .Left          = 384
317:             .Width         = 45
318:             .Height        = 23
319:             .Value         = {}
320:             .Format        = "K9"
321:             .InputMask     = "99/99"

*-- Linhas 336 a 361:
336:         ENDWITH
337: 
338:         *-- Label separador "a grave" (lbl_a: Left=433, Top=172) - preposicao "a"
339:         loc_oPg.AddObject("lbl_4c_LblA", "Label")
340:         WITH loc_oPg.lbl_4c_LblA
341:             .Top       = 87
342:             .Left      = 433
343:             .AutoSize  = .T.
344:             .Caption   = CHR(224)
345:             .FontName  = "Tahoma"
346:             .FontSize  = 8
347:             .ForeColor = RGB(90, 90, 90)
348:             .BackStyle = 0
349:             .Visible   = .T.
350:         ENDWITH
351: 
352:         *-- Data Final (get_dt_final: Left=444, Top=168, Width=45, InputMask="99/99")
353:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
354:         WITH loc_oPg.txt_4c_DtFinal
355:             .Top           = 83
356:             .Left          = 444
357:             .Width         = 45
358:             .Height        = 23
359:             .Value         = {}
360:             .Format        = "K9"
361:             .InputMask     = "99/99"

*-- Linhas 587 a 598:
587:             loc_oPg = THIS.pgf_4c_Paginas.Page1
588:             WITH THIS.this_oRelatorio
589:                 IF !EMPTY(.this_dDtInicial)
590:                     loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
591:                 ENDIF
592:                 IF !EMPTY(.this_dDtFinal)
593:                     loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
594:                 ENDIF
595:             ENDWITH
596:         CATCH TO loc_oErro
597:             MsgErro(loc_oErro.Message, "Erro")
598:         ENDTRY


### BO (C:\4c\projeto\app\classes\sigreaniBO.prg):
*==============================================================================
* SIGREANIBO.PRG  (sigreaniBO.prg)
* Business Object para Relatorio de Aniversariantes
* Herda de RelatorioBase
*
* Tabelas: SigCdCli (clientes - aniversarios/casamentos/conjuges)
*          SigCdCe  (empresas  - socios e conjuges de socios)
*          SigCdEmp (cabecalho - razao social da empresa)
* Filtros: DtInicial e DtFinal (somente dia/mes importam)
*
* Logica de PrepararDados:
*   1. Extrai dia/mes e converte para MMDD para comparar com dmnascs/dmcasas/dmconjs
*   2. Busca SigCdCli com aniversario/casamento/conjuge no intervalo MMDD
*   3. Cria cursor_4c_Dados com estrutura identica ao CsRelatorio original
*   4. Para cada cliente: inclui linha de aniversario e linha de conjuge (se aplicavel)
*   5. Busca SigCdCe e inclui socios (DtNasc1s-3s) e conjuges (DtnConj1-3)
*   6. Ordena por MMDD+Iclis via INDEX TAG Impressao
*==============================================================================

DEFINE CLASS sigreaniBO AS RelatorioBase

    *-- Filtros do relatorio (somente dia/mes importam, ano e ignorado)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Cursores utilizados pelo relatorio
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *-- Configuracao do relatorio
    this_cFRXPath           = ""
    this_cTituloRel         = ""
    this_cSubTitulo         = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                IF TYPE("gc_4c_CaminhoReports") = "U"
                    gc_4c_CaminhoReports = ""
                ENDIF
                THIS.this_cFRXPath   = gc_4c_CaminhoReports + "RelSigReAni.frx"
                THIS.this_cTituloRel = "Relat" + CHR(243) + "rio de Aniversariantes"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreaniBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor_4c_Dados e cursor_4c_Cabecalho para o relatorio
    * Replica a logica do PROCEDURE processamento do SCX original:
    *   - Converte datas para MMDD e filtra por dmnascs/dmcasas/dmconjs
    *   - Processa clientes (aniversario + conjuge)
    *   - Processa socios e conjuges de socios via SigCdCe
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_lnDIni, loc_lnMIni, loc_lnDFin, loc_lnMFin
        LOCAL loc_cMmddIni, loc_cMmddFin
        LOCAL loc_lcCbEmpresa, loc_lcCbPeriodo
        LOCAL loc_nX, loc_cNome, loc_cDNasc

        loc_lSucesso = .F.

        TRY
            *-- Validar filtros obrigatorios
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Informe o per" + CHR(237) + "odo inicial e final"
                loc_lSucesso = .F.
            ENDIF

            *-- Extrair dia e mes das datas filtro
            loc_lnDIni = DAY(THIS.this_dDtInicial)
            loc_lnMIni = MONTH(THIS.this_dDtInicial)
            loc_lnDFin = DAY(THIS.this_dDtFinal)
            loc_lnMFin = MONTH(THIS.this_dDtFinal)

            *-- Converter para formato MMDD (mesmo formato de dmnascs/dmcasas/dmconjs)
            loc_cMmddIni = PADL(TRANSFORM(loc_lnMIni), 2, "0") + PADL(TRANSFORM(loc_lnDIni), 2, "0")
            loc_cMmddFin = PADL(TRANSFORM(loc_lnMFin), 2, "0") + PADL(TRANSFORM(loc_lnDFin), 2, "0")

            *-- Limpar cursores de execucao anterior
            THIS.LimparCursores()

            *-- Buscar razao social da empresa para o cabecalho
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")
            IF loc_nResult > 0
                SELECT cursor_4c_Empresa
                IF !EOF()
                    loc_lcCbEmpresa = ALLTRIM(Razas)
                ELSE
                    loc_lcCbEmpresa = ""
                ENDIF
                USE IN cursor_4c_Empresa
            ELSE
                loc_lcCbEmpresa = ""
            ENDIF

            *-- Montar descricao do periodo para cabecalho
            loc_lcCbPeriodo = "Per" + CHR(237) + "odo: " + ;
                              PADL(TRANSFORM(loc_lnDIni), 2, "0") + "/" + ;
                              PADL(TRANSFORM(loc_lnMIni), 2, "0") + ;
                              " " + CHR(224) + " " + ;
                              PADL(TRANSFORM(loc_lnDFin), 2, "0") + "/" + ;
                              PADL(TRANSFORM(loc_lnMFin), 2, "0")

            *-- Criar cursor de cabecalho do relatorio
            CREATE CURSOR cursor_4c_Cabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
            INSERT INTO cursor_4c_Cabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                   VALUES (loc_lcCbEmpresa, ;
                           "Rela" + CHR(231) + CHR(227) + "o de Aniversariantes", ;
                           loc_lcCbPeriodo)

            *-- Buscar clientes com aniversario/casamento/conjuge no intervalo MMDD
            loc_cSQL = "SELECT * FROM SigCdCli WHERE " + ;
                       "(dmnascs >= " + EscaparSQL(loc_cMmddIni) + ;
                       " AND dmnascs <= " + EscaparSQL(loc_cMmddFin) + ")" + ;
                       " OR (dmcasas >= " + EscaparSQL(loc_cMmddIni) + ;
                       " AND dmcasas <= " + EscaparSQL(loc_cMmddFin) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliSource")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar clientes aniversariantes"
                loc_lSucesso = .F.
            ENDIF

            *-- Criar cursor de resultado com mesma estrutura do CsRelatorio original
            CREATE CURSOR cursor_4c_Dados (Emps C(3), mes N(2), dia N(2), Iclis C(10), ;
                                           Rclis C(40), Endes C(60), Bairs C(40), ;
                                           Ceps C(9), Cidas C(30), Estas C(2), ;
                                           Tel1s C(20), Faxs C(20), Nascs D, ;
                                           emails C(50), ContaVens C(10))
            INDEX ON PADL(TRANSFORM(mes),2,"0") + PADL(TRANSFORM(dia),2,"0") + Iclis TAG Impressao

            *-- Processar clientes: aniversario proprio e aniversario do conjuge
            SELECT cursor_4c_CliSource
            SCAN
                SCATTER MEMVAR

                *-- Aniversario do cliente
                IF BETWEEN(DAY(m.Nascs), loc_lnDIni, loc_lnDFin) AND ;
                   BETWEEN(MONTH(m.Nascs), loc_lnMIni, loc_lnMFin)
                    m.mes = MONTH(m.Nascs)
                    m.dia = DAY(m.Nascs)
                    SELECT cursor_4c_Dados
                    APPEND BLANK
                    GATHER MEMVAR
                ENDIF

                *-- Aniversario do conjuge do cliente
                IF BETWEEN(DAY(m.dtncons), loc_lnDIni, loc_lnDFin) AND ;
                   BETWEEN(MONTH(m.dtncons), loc_lnMIni, loc_lnMFin) AND ;
                   !EMPTY(m.conjuges)
                    m.mes   = MONTH(m.dtncons)
                    m.dia   = DAY(m.dtncons)
                    m.Rclis = m.conjuges
                    m.Nascs = m.dtncons
                    SELECT cursor_4c_Dados
                    APPEND BLANK
                    GATHER MEMVAR
                ENDIF

                SELECT cursor_4c_CliSource
            ENDSCAN

            IF USED("cursor_4c_CliSource")
                USE IN cursor_4c_CliSource
            ENDIF

            *-- Buscar socios/empresas para processar aniversarios de socios e seus conjuges
            loc_cSQL = "SELECT * FROM SigCdCe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CeSource")
            IF loc_nResult > 0
                SELECT cursor_4c_CeSource
                INDEX ON Iclis TAG Iclis

                SELECT cursor_4c_CeSource
                SCAN
                    SCATTER MEMVAR

                    *-- Verificar aniversarios dos 3 socios (Socio1s/DtNasc1s ate Socio3s/DtNasc3s)
                    FOR loc_nX = 1 TO 3
                        loc_cNome  = "m.Socio"  + TRANSFORM(loc_nX) + "s"
                        loc_cDNasc = "m.DtNasc" + TRANSFORM(loc_nX) + "s"

                        IF BETWEEN(DAY(&loc_cDNasc.), loc_lnDIni, loc_lnDFin) AND ;
                           BETWEEN(MONTH(&loc_cDNasc.), loc_lnMIni, loc_lnMFin) AND ;
                           !EMPTY(&loc_cNome.)

                            IF !USED("cursor_4c_TmpCli")
                                loc_cSQL = "SELECT * FROM SigCdCli WHERE Iclis = " + ;
                                           EscaparSQL(ALLTRIM(cursor_4c_CeSource.Iclis))
                                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            ENDIF

                            IF USED("cursor_4c_TmpCli")
                                SELECT cursor_4c_TmpCli
                                SCATTER MEMVAR
                                m.mes   = MONTH(&loc_cDNasc.)
                                m.dia   = DAY(&loc_cDNasc.)
                                m.Rclis = &loc_cNome.
                                m.Nascs = &loc_cDNasc.
                                SELECT cursor_4c_Dados
                                APPEND BLANK
                                GATHER MEMVAR
                            ENDIF
                        ENDIF
                    NEXT

                    *-- Verificar aniversarios dos conjuges dos socios (Conj1s/DtnConj1 ate Conj3s/DtnConj3)
                    FOR loc_nX = 1 TO 3
                        loc_cNome  = "m.Conj"   + TRANSFORM(loc_nX) + "s"
                        loc_cDNasc = "m.DtnConj" + TRANSFORM(loc_nX)

                        IF BETWEEN(DAY(&loc_cDNasc.), loc_lnDIni, loc_lnDFin) AND ;
                           BETWEEN(MONTH(&loc_cDNasc.), loc_lnMIni, loc_lnMFin) AND ;
                           !EMPTY(&loc_cNome.)

                            IF !USED("cursor_4c_TmpCli")
                                loc_cSQL = "SELECT * FROM SigCdCli WHERE Iclis = " + ;
                                           EscaparSQL(ALLTRIM(cursor_4c_CeSource.Iclis))
                                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            ENDIF

                            IF USED("cursor_4c_TmpCli")
                                SELECT cursor_4c_TmpCli
                                SCATTER MEMVAR
                                m.mes   = MONTH(&loc_cDNasc.)
                                m.dia   = DAY(&loc_cDNasc.)
                                m.Rclis = &loc_cNome.
                                m.Nascs = &loc_cDNasc.
                                SELECT cursor_4c_Dados
                                APPEND BLANK
                                GATHER MEMVAR
                            ENDIF
                        ENDIF
                    NEXT

                    IF USED("cursor_4c_TmpCli")
                        USE IN cursor_4c_TmpCli
                    ENDIF

                    SELECT cursor_4c_CeSource
                ENDSCAN

                IF USED("cursor_4c_CeSource")
                    USE IN cursor_4c_CeSource
                ENDIF
            ENDIF

            *-- Posicionar no inicio do cursor de resultado para o REPORT FORM
            SELECT cursor_4c_Dados
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF !FILE(THIS.this_cFRXPath)
                    THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                                              CHR(227) + "o encontrado: " + THIS.this_cFRXPath
                    loc_lSucesso = .F.
                ENDIF
                REPORT FORM (THIS.this_cFRXPath) TO PRINTER NOCONSOLE
                THIS.LimparCursores()
                THIS.this_cMensagemErro = ""
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF !FILE(THIS.this_cFRXPath)
                    THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                                              CHR(227) + "o encontrado: " + THIS.this_cFRXPath
                    loc_lSucesso = .F.
                ENDIF
                REPORT FORM (THIS.this_cFRXPath) PREVIEW NOCONSOLE
                THIS.LimparCursores()
                THIS.this_cMensagemErro = ""
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
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
    * LimparCursores - Fecha cursores do relatorio se estiverem abertos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursores()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        IF USED("cursor_4c_CliSource")
            USE IN cursor_4c_CliSource
        ENDIF
        IF USED("cursor_4c_CeSource")
            USE IN cursor_4c_CeSource
        ENDIF
        IF USED("cursor_4c_TmpCli")
            USE IN cursor_4c_TmpCli
        ENDIF
        IF USED("cursor_4c_Empresa")
            USE IN cursor_4c_Empresa
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
    * BOs de Relatorio populam dados via PrepararDados() -> cursor_4c_Dados,
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
    * Destroy - Fecha cursores abertos pelo relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

