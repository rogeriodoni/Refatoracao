# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 192: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 213: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 235: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefcd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (958 linhas total):

*-- Linhas 47 a 55:
47:         loc_lSucesso   = .F.
48:         loc_lContinuar = .T.
49:         TRY
50:             THIS.Caption = "Informativo de Vendas Di" + CHR(225) + "rias"
51: 
52:             IF TYPE("gc_4c_CaminhoIcones") = "U"
53:                 gc_4c_CaminhoIcones = ""
54:             ENDIF
55:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 69 a 78:
69:                 THIS.ConfigurarBotoes()
70:                 THIS.ConfigurarPageFrame()
71: 
72:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:                 THIS.ConfigurarPaginaFiltros()
76: 
77:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
78:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

*-- Linhas 103 a 177:
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
121:                 .Caption   = "Informativo de Vendas Di" + CHR(225) + "rias"
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
136:                 .Caption   = "Informativo de Vendas Di" + CHR(225) + "rias"
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 14
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(255, 255, 255)
141:                 .BackStyle = 0
142:                 .Visible   = .T.
143:             ENDWITH
144:         ENDWITH
145:     ENDPROC
146: 
147:     *--------------------------------------------------------------------------
148:     * ConfigurarBotoes - CommandGroup btnReport (framework.vcx frmrelatorio)
149:     *   Original: btnReport.Left=526 -> padrao canonico Left=529
150:     *   Botoes: Visualizar(5), Imprimir(71), Documento(137), Encerrar(203)
151:     *--------------------------------------------------------------------------
152:     PROTECTED PROCEDURE ConfigurarBotoes()
153:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
154:         WITH THIS.cmg_4c_Botoes
155:             .Top           = 0
156:             .Left          = 529
157:             .Width         = 273
158:             .Height        = 80
159:             .ButtonCount   = 4
160:             .BackStyle     = 0
161:             .BorderStyle   = 0
162:             .BorderColor   = RGB(136, 189, 188)
163:             .SpecialEffect = 1
164:             .Themes        = .F.
165:             .Visible       = .T.
166: 
167:             WITH .Buttons(1)
168:                 .Top             = 5
169:                 .Left            = 5
170:                 .Width           = 65
171:                 .Height          = 70
172:                 .Caption         = "Visualizar"
173:                 .FontBold        = .T.
174:                 .FontItalic      = .T.
175:                 .BackColor       = RGB(255, 255, 255)
176:                 .ForeColor       = RGB(90, 90, 90)
177:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 184 a 198:
184:             ENDWITH
185: 
186:             WITH .Buttons(2)
187:                 .Top             = 5
188:                 .Left            = 71
189:                 .Width           = 65
190:                 .Height          = 70
191:                 .Caption         = "Imprimir"
192:                 .FontName        = "Comic Sans MS"
193:                 .FontBold        = .T.
194:                 .FontItalic      = .T.
195:                 .FontSize        = 8
196:                 .BackColor       = RGB(255, 255, 255)
197:                 .ForeColor       = RGB(90, 90, 90)
198:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 205 a 219:
205:             ENDWITH
206: 
207:             WITH .Buttons(3)
208:                 .Top             = 5
209:                 .Left            = 137
210:                 .Width           = 65
211:                 .Height          = 70
212:                 .Caption         = "Documento"
213:                 .FontName        = "Comic Sans MS"
214:                 .FontBold        = .T.
215:                 .FontItalic      = .T.
216:                 .FontSize        = 8
217:                 .BackColor       = RGB(255, 255, 255)
218:                 .ForeColor       = RGB(90, 90, 90)
219:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 226 a 241:
226:             ENDWITH
227: 
228:             WITH .Buttons(4)
229:                 .Top             = 5
230:                 .Left            = 203
231:                 .Width           = 65
232:                 .Height          = 70
233:                 .Caption         = "Encerrar"
234:                 .Cancel          = .T.
235:                 .FontName        = "Comic Sans MS"
236:                 .FontBold        = .T.
237:                 .FontItalic      = .T.
238:                 .FontSize        = 8
239:                 .BackColor       = RGB(255, 255, 255)
240:                 .ForeColor       = RGB(90, 90, 90)
241:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 261 a 275:
261: 
262:         loc_oPgf.PageCount = 1
263: 
264:         loc_oPgf.Top    = 85
265:         loc_oPgf.Left   = -1
266:         loc_oPgf.Width  = THIS.Width + 2
267:         loc_oPgf.Height = THIS.Height - 85
268:         loc_oPgf.Tabs   = .F.
269: 
270:         loc_oPgf.Page1.Caption   = "Filtros"
271:         loc_oPgf.Page1.FontName  = "Tahoma"
272:         loc_oPgf.Page1.FontSize  = 8
273:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
274:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
275:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 281 a 303:
281:     *--------------------------------------------------------------------------
282:     * ConfigurarPaginaFiltros - Filtros na Page1 (Empresa + Periodo)
283:     *   Posicoes convertidas: OriginalTop - PageFrame.Top(85)
284:     *   get_cd_empresa: Top=144 -> Page1.Top=59
285:     *   get_dt_inicial: Top=169 -> Page1.Top=84
286:     *--------------------------------------------------------------------------
287:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
288:         LOCAL loc_oPg
289:         loc_oPg = THIS.pgf_4c_Paginas.Page1
290: 
291:         *-- Label "Empresa :" (original: lbl_empresa, Top=147, Left=224)
292:         loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
293:         WITH loc_oPg.lbl_4c_LblEmpresa
294:             .Top       = 62
295:             .Left      = 224
296:             .Width     = 50
297:             .Height    = 15
298:             .Caption   = "Empresa :"
299:             .FontName  = "Tahoma"
300:             .FontSize  = 8
301:             .FontBold  = .F.
302:             .Alignment = 0
303:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 309 a 318:
309:         *-- Codigo da empresa (get_cd_empresa: Width=31, Left=279, MaxLength=3)
310:         loc_oPg.AddObject("txt_4c_CdEmpresa", "TextBox")
311:         WITH loc_oPg.txt_4c_CdEmpresa
312:             .Top           = 59
313:             .Left          = 279
314:             .Width         = 31
315:             .Height        = 23
316:             .Value         = ""
317:             .MaxLength     = 3
318:             .Format        = "K!"

*-- Linhas 330 a 339:
330:         *   ReadOnly quando codigo da empresa esta preenchido (When original)
331:         loc_oPg.AddObject("txt_4c_DsEmpresa", "TextBox")
332:         WITH loc_oPg.txt_4c_DsEmpresa
333:             .Top           = 59
334:             .Left          = 312
335:             .Width         = 289
336:             .Height        = 23
337:             .Value         = ""
338:             .MaxLength     = 40
339:             .Format        = "K!"

*-- Linhas 348 a 362:
348:         ENDWITH
349: 
350:         *-- Label "Periodo :" (original: lbl_periodo, Top=172, Left=229)
351:         loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
352:         WITH loc_oPg.lbl_4c_LblPeriodo
353:             .Top       = 87
354:             .Left      = 229
355:             .Width     = 45
356:             .Height    = 15
357:             .Caption   = "Per" + CHR(237) + "odo :"
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .FontBold  = .F.
361:             .Alignment = 0
362:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 368 a 377:
368:         *-- Data inicial (get_dt_inicial: Width=80, Left=279, Top=169)
369:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
370:         WITH loc_oPg.txt_4c_DtInicial
371:             .Top           = 84
372:             .Left          = 279
373:             .Width         = 80
374:             .Height        = 23
375:             .Value         = {}
376:             .Format        = "D"
377:             .MaxLength     = 10

*-- Linhas 385 a 412:
385:         ENDWITH
386: 
387:         *-- Separador entre datas (Say1: Caption="a" grave, Top=172, Left=363)
388:         loc_oPg.AddObject("lbl_4c_Sep", "Label")
389:         WITH loc_oPg.lbl_4c_Sep
390:             .Top       = 87
391:             .Left      = 363
392:             .Width     = 10
393:             .Height    = 15
394:             .Caption   = CHR(224)
395:             .FontName  = "Tahoma"
396:             .FontSize  = 8
397:             .FontBold  = .F.
398:             .ForeColor = RGB(90, 90, 90)
399:             .BackStyle = 0
400:             .Visible   = .T.
401:         ENDWITH
402: 
403:         *-- Data final (get_dt_final: Width=80, Left=376, Top=169)
404:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
405:         WITH loc_oPg.txt_4c_DtFinal
406:             .Top           = 84
407:             .Left          = 376
408:             .Width         = 80
409:             .Height        = 23
410:             .Value         = {}
411:             .Format        = "D"
412:             .MaxLength     = 10


### BO (C:\4c\projeto\app\classes\sigrefcdBO.prg):
*==============================================================================
* SIGREFCDBO.PRG
* Business Object para Relatorio de Informativo de Vendas Diarias (SIGREFCD)
*
* Herda de RelatorioBase
* Referencia legado: sigrefcd.SCX (frmrelatorio)
* Caption original: "Informativo de Vendas Diarias"
*==============================================================================

DEFINE CLASS sigrefcdBO AS RelatorioBase

    *-- Filtros do relatorio (mapeados dos campos get_* do legado)
    this_cCodEmpresa      = ""   && get_cd_empresa  - codigo da empresa (max 3 chars)
    this_cRazaEmpresa     = ""   && get_ds_empresa  - razao social da empresa (max 40 chars)
    this_dDtInicial       = {}   && get_dt_inicial  - data inicial do periodo
    this_dDtFinal         = {}   && get_dt_final    - data final do periodo

    *-- Variaveis de resultado mapeadas das PUBLIC vars do legado
    *-- (m.reslanca, m.resforma, m.rescheque, m.rescartao, m.resvende,
    *--  m.resconta, m.reslanfor, m.resqtdes, m.ResvDets)
    this_lResLanca        = .F.
    this_lResForma        = .F.
    this_lResCheque       = .F.
    this_lResCartao       = .F.
    this_lResVende        = .F.
    this_lResConta        = .F.
    this_lResLanFor       = .F.
    this_lResQtdes        = .F.
    this_lResvDets        = .F.

    *-- Configuracao do relatorio
    this_cTituloRelatorio = ""
    this_cArquivoFRX      = ""
    this_cMensagemErro    = ""

    *--------------------------------------------------------------------------
    * Init - Configura titulo, FRX e carrega cursores auxiliares do legado
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            IF loc_lSucesso
                THIS.this_cTituloRelatorio = "Informativo de Vendas Di" + CHR(225) + "rias"
                THIS.this_cArquivoFRX      = "SigReFcD"

                *-- Cursor auxiliar de tomadores (usado pelo FRX)
                CREATE CURSOR csSigCdTom (Marca n(1), Descri c(40), Codigos n(2))
                INDEX ON Codigos TAG Codigos

                *-- Cursor de movimento (reutilizado a cada PrepararDados)
                CREATE CURSOR crMovimento (Datas t, Valor N(13,2))
                INDEX ON Datas TAG Datas

                *-- Carrega parametros de operacoes de fechamento (SigCdPam)
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "CrSigCdPam")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdPam"
                    loc_lSucesso = .F.
                ELSE
                    *-- Carrega formas de pagamento (SigOpFp)
                    loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigOpFp", "CrSigOpFp")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao carregar SigOpFp"
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todas as queries e monta cursores para o relatorio
    * Replica logica do PROCEDURE processamento do legado sigrefcd.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_lcEmp, loc_lcOperacao, loc_lcConserto
        LOCAL loc_lcCbEmp, loc_lcTitulo, loc_lcPeriodo
        LOCAL loc_lcEnd1, loc_lcEnd2, loc_lcEnd3
        LOCAL loc_lcQuery
        LOCAL loc_lnValor, loc_lnValPr
        LOCAL pDtI, pDtF, pDtH

        loc_lSucesso = .F.

        TRY
            loc_lcEmp = ALLTRIM(THIS.this_cCodEmpresa)

            *-- Busca dados cadastrais da empresa selecionada
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, endes, numeros, bairs, ceps, cidas, estas, cgcs " + ;
                "FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_lcEmp), ;
                "crSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar dados da empresa"
                loc_lSucesso = .F.
            ENDIF

            *-- Monta strings do cabecalho do relatorio
            SELECT crSigCdEmp
            loc_lcCbEmp   = loc_lcEmp + "-" + ALLTRIM(crSigCdEmp.razas)
            loc_lcTitulo  = "Fechamento de Venda Di" + CHR(225) + "ria"
            loc_lcPeriodo = "Per" + CHR(237) + "odo : " + ;
                            DTOC(THIS.this_dDtInicial) + " a " + DTOC(THIS.this_dDtFinal)
            loc_lcEnd1    = ALLTRIM(crSigCdEmp.endes) + " " + ;
                            ALLTRIM(crSigCdEmp.numeros) + " - " + ;
                            ALLTRIM(crSigCdEmp.bairs)
            loc_lcEnd2    = ALLTRIM(crSigCdEmp.ceps) + " " + ;
                            ALLTRIM(crSigCdEmp.cidas) + " " + ;
                            ALLTRIM(crSigCdEmp.estas)
            loc_lcEnd3    = ALLTRIM(crSigCdEmp.cgcs)

            *-- Cursor de cabecalho para o FRX
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho ;
                (empresa c(240), titulo c(240), End1 c(240), ;
                 End2 c(240), End3 c(240), PERIODO c(80))
            INSERT INTO csCabecalho ;
                (empresa, titulo, End1, End2, End3, Periodo) ;
                VALUES (loc_lcCbEmp, loc_lcTitulo, loc_lcEnd1, ;
                        loc_lcEnd2, loc_lcEnd3, loc_lcPeriodo)

            *-- Variaveis de data parametrizadas para SQLEXEC com ?pDtI/?pDtF
            pDtI = DATETIME(YEAR(THIS.this_dDtInicial), ;
                            MONTH(THIS.this_dDtInicial), ;
                            DAY(THIS.this_dDtInicial), 0, 0, 0)
            pDtF = DATETIME(YEAR(THIS.this_dDtFinal), ;
                            MONTH(THIS.this_dDtFinal), ;
                            DAY(THIS.this_dDtFinal), 23, 59, 59)
            pDtH = DATETIME(YEAR(DATE()), MONTH(DATE()), DAY(DATE()), 23, 59, 59)

            *-- Obtem operacao de fechamento configurada em SigCdPam
            SELECT CrSigCdPam
            GO TOP
            IF !EOF()
                loc_lcOperacao = ALLTRIM(CrSigCdPam.dopes)
                loc_lcConserto = ALLTRIM(CrSigCdPam.opconsers)
            ELSE
                loc_lcOperacao = ""
                loc_lcConserto = ""
            ENDIF

            IF EMPTY(loc_lcOperacao)
                MsgAviso("N" + CHR(227) + "o existe movimenta" + CHR(231) + ;
                         CHR(227) + "o de fechamento configurada!!!", "Aviso")
            ENDIF

            WAIT WINDOW "Aguarde..." NOWAIT NOCLEAR

            *-- Query 1: dados de vendas gerais (csDadosV)
            *-- Inclui movimentos excluindo fpags especificos (garantia, cortesia, etc.)
            loc_lcQuery = ;
                "SELECT case when g.tipoops = 5 then 'M' else d.Infos end as Infos, " + ;
                "c.datas, c.Emps, c.Dopes, c.Numes, c.empdopnums, " + ;
                "c.cidchaves as chaPar, c.fpags, d.fparcs, c.moefpgs, " + ;
                "case when g.tipoops = 5 then (c.valos*c.cotfpgs) * -1 " + ;
                "     else (c.valos*c.cotfpgs) end as valos, " + ;
                "case when g.tipoops = 5 then c.valos * -1 else c.valos end as valosM, " + ;
                "case when d.infos = 'T' then d.formas else e.descrs end as info, " + ;
                "d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente " + ;
                "FROM sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h " + ;
                "WHERE c.datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                IIF(EMPTY(loc_lcEmp), " ", "c.Emps = '" + loc_lcEmp + "' AND ") + ;
                "g.tipoops = h.codigos AND " + ;
                "h.gergdmis = 1 AND " + ;
                "c.fpags = d.fpags AND " + ;
                "d.infos = e.infos AND " + ;
                "g.relfechas = 1 AND " + ;
                "c.dopes = g.dopes AND " + ;
                "c.fpags NOT IN ('garantia','cortesia','pag efetuado'," + ;
                "'aberto r','credito loja','dev loja') " + ;
                "ORDER BY c.cidchaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosV")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de vendas (csDadosV)"
                WAIT CLEAR
                loc_lSucesso = .F.
            ENDIF

            *-- Query 2: vendas com pagamento efetuado/aberto r (csDadosP)
            loc_lcQuery = ;
                "SELECT d.Infos, c.datas, c.Emps, c.Dopes, c.Numes, " + ;
                "c.empdopnums, c.cidchaves as chaPar, c.fpags, " + ;
                "(c.valos*c.cotfpgs) as valos, d.fparcs, " + ;
                "case when d.infos = 'T' then d.formas else e.descrs end as info, " + ;
                "d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente " + ;
                "FROM sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h " + ;
                "WHERE c.datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                IIF(EMPTY(loc_lcEmp), " ", "c.Emps = '" + loc_lcEmp + "' AND ") + ;
                "g.tipoops = h.codigos AND " + ;
                "h.gergdmis = 1 AND " + ;
                "g.tipoops <> 5 AND " + ;
                "c.fpags = d.fpags AND " + ;
                "d.infos = e.infos AND " + ;
                "g.opers <> 1 AND " + ;
                "g.relfechas = 1 AND " + ;
                "c.dopes = g.dopes AND " + ;
                "c.fpags IN ('pag efetuado','aberto r') " + ;
                "ORDER BY c.cidchaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosP")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de pagamentos (csDadosP)"
                WAIT CLEAR
                loc_lSucesso = .F.
            ENDIF

            *-- Query 3: recebimentos (csDadosR)
            loc_lcQuery = ;
                "SELECT DISTINCT d.infos, c.datas, c.Emps, c.Dopes, c.Numes, " + ;
                "c.empdopnums, c.cidchaves as chaPar, c.fpags, " + ;
                "(c.valos*c.cotfpgs) as valos, d.fparcs, " + ;
                "c.valos as valosM, c.moefpgs, " + ;
                "case when d.infos = 'T' then d.formas else e.descrs end as info, " + ;
                "d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente " + ;
                "FROM SigMvccr a, sigmvPar c, sigcdope g, sigcdtom h, " + ;
                "sigopfp d, sigprinf e " + ;
                "WHERE c.datas BETWEEN ?pDtI AND ?pDtF AND " + ;
                IIF(EMPTY(loc_lcEmp), " ", "c.Emps = '" + loc_lcEmp + "' AND ") + ;
                "c.dopes = g.dopes AND " + ;
                "c.dopes = 'RECEBIMENTO' AND " + ;
                "c.nopers = a.nopers AND " + ;
                "g.tipoops = h.codigos AND " + ;
                "g.relfechas = 1 AND " + ;
                "c.fpags = d.fpags AND " + ;
                "d.infos = e.infos " + ;
                "ORDER BY c.cidchaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosR")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na consulta de recebimentos (csDadosR)"
                WAIT CLEAR
                loc_lSucesso = .F.
            ENDIF

            *-- Agrupa csDadosV por datas/chapar -> Curv
            SELECT chapar, Datas, ;
                MAX(Emps) AS Emps, MAX(valos) AS valos, MAX(fparcs) AS fparcs, ;
                MAX(Info) AS Info, MAX(formas) AS formas, MAX(valpends) AS valpends, ;
                MAX(bandeira) AS bandeira, MAX(adquirente) AS adquirente, ;
                MAX(valosM) AS valosM, MAX(moefpgs) AS moefpgs, MAX(Infos) AS Infos ;
                FROM csDadosV GROUP BY Datas, chapar INTO CURSOR Curv

            *-- Cursor vazio Curr com mesma estrutura de csDadosR
            SELECT chapar, Datas, ;
                MAX(Emps) AS Emps, MAX(valos) AS valos, MAX(fparcs) AS fparcs, ;
                MAX(Info) AS Info, MAX(formas) AS formas, MAX(valpends) AS valpends, ;
                MAX(bandeira) AS bandeira, MAX(adquirente) AS adquirente, ;
                MAX(valosM) AS valosM, MAX(moefpgs) AS moefpgs, MAX(Infos) AS Infos ;
                FROM csDadosR WHERE 0=1 GROUP BY Datas, chapar INTO CURSOR Curr

            *-- UNION: categoriza valores em valAv (a vista), valFin (financiado), valRec (recebimento)
            SELECT Infos, Datas, chapar, Emps, Info, formas, bandeira, adquirente, ;
                valos AS valAv, ;
                CAST(0.00 AS numeric(11,2)) AS valFin, ;
                CAST(0.00 AS numeric(11,2)) AS valRec ;
                FROM Curv WHERE fparcs = 1 ;
                UNION ;
                SELECT Infos, Datas, chapar, Emps, Info, formas, bandeira, adquirente, ;
                CAST(0.00 AS numeric(11,2)) AS valAv, ;
                valos AS valFin, ;
                CAST(0.00 AS numeric(11,2)) AS valRec ;
                FROM Curv WHERE !(fparcs = 1) ;
                UNION ;
                SELECT Infos, Datas, chapar, Emps, Info, formas, bandeira, adquirente, ;
                CAST(0.00 AS numeric(11,2)) AS valAv, ;
                CAST(0.00 AS numeric(11,2)) AS valFin, ;
                valos AS valRec ;
                FROM Curr ;
                INTO CURSOR Curt

            *-- Consolida por Infos/Datas/Emps
            SELECT Infos, Datas, Emps, ;
                SUM(valAv) AS valAv, SUM(valFin) AS valFin, SUM(valRec) AS valRec ;
                FROM Curt GROUP BY Datas, Infos, Emps INTO CURSOR curPag

            *-- Adiciona colunas de totalizacao
            SELECT *, valAv + valFin AS valVenda, valAv + valFin + valRec AS valTot ;
                FROM curPag INTO CURSOR curPag

            *-- Totais gerais
            SELECT SUM(valAv) AS valAv, SUM(valFin) AS valFin, ;
                SUM(valRec) AS valRec, SUM(valVenda) AS valVenda, ;
                SUM(valTot) AS valTot ;
                FROM curPag INTO CURSOR curPagT

            *-- Garante crMovimento disponivel e vazio
            IF !USED("crMovimento")
                CREATE CURSOR crMovimento (Datas t, Valor N(13,2))
                INDEX ON Datas TAG Datas
            ENDIF
            ZAP IN crMovimento

            *-- Processa cada linha de curPag aplicando percentuais de SigEmInf
            SELECT curPag
            GO TOP
            SCAN
                *-- Busca percentual por empresa/tipo de informacao
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT PercEmps FROM SigEmInf " + ;
                    "WHERE Emps = '" + ALLTRIM(curPag.Emps) + "'" + ;
                    " AND Infos = '" + ALLTRIM(curPag.Infos) + "'", ;
                    "crInfos")

                loc_lnValor = curPag.valTot

                *-- Aplica percentual se existir configuracao em SigEmInf
                IF loc_nResult > 0
                    SELECT crInfos
                    IF RECCOUNT("crInfos") > 0
                        loc_lnValPr = 0
                        SELECT crInfos
                        SCAN
                            loc_lnValPr = loc_lnValPr + ;
                                          ((loc_lnValor / 100) * crInfos.PercEmps)
                        ENDSCAN
                        loc_lnValor = loc_lnValPr
                    ENDIF
                ENDIF
                IF USED("crInfos")
                    USE IN crInfos
                ENDIF

                *-- Acumula no cursor de movimento
                SELECT crMovimento
                APPEND BLANK
                REPLACE Datas WITH curPag.Datas, ;
                        Valor WITH loc_lnValor IN crMovimento

                SELECT curPag
            ENDSCAN

            *-- Agrega movimento por data (consolida multiplas empresas/tipos)
            SELECT crMovimento
            SELECT datas, SUM(valor) AS Valor ;
                FROM crMovimento GROUP BY datas INTO CURSOR csMovimento READWRITE

            *-- Reconstroi crMovimento com dados consolidados
            ZAP IN crMovimento

            SELECT csMovimento
            GO TOP
            SCAN
                SELECT crMovimento
                APPEND BLANK
                REPLACE Datas WITH csMovimento.Datas, ;
                        Valor WITH csMovimento.Valor IN crMovimento
                SELECT csMovimento
            ENDSCAN

            IF USED("csMovimento")
                USE IN csMovimento
            ENDIF

            *-- Posiciona em crMovimento para o FRX
            SELECT crMovimento
            GO TOP

            WAIT CLEAR

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio (com dialogo de impressora)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM SigReFcD TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
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
                REPORT FORM SigReFcD PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
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
    * Operacoes CRUD - NAO APLICAVEIS a este BO
    * Este BO herda de RelatorioBase (formulario frmrelatorio).
    * Relatorios apenas leem dados para imprimir/visualizar via PrepararDados().
    * Os metodos abaixo existem apenas para satisfazer contratos genericos e
    * sinalizar explicitamente que a operacao nao se aplica a relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + ;
                                  CHR(227) + "o aplic" + CHR(225) + "vel: " + ;
                                  "relat" + CHR(243) + "rio n" + CHR(227) + ;
                                  "o carrega registro para edi" + CHR(231) + ;
                                  CHR(227) + "o."
        RETURN .F.
    ENDPROC

    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inserir " + ;
                                  "n" + CHR(227) + "o se aplica a relat" + ;
                                  CHR(243) + "rios."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Atualizar " + ;
                                  "n" + CHR(227) + "o se aplica a relat" + ;
                                  CHR(243) + "rios."
        RETURN .F.
    ENDPROC

ENDDEFINE

