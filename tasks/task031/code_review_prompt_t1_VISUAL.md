# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 189: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 208: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 228: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreanr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (865 linhas total):

*-- Linhas 11 a 19:
11: *              txt_4c_EmpresaDesc (get_empresa_desc - razao social, 40 chars)
12: *
13: * Posicoes originais: Width=800, Height=300
14: * PageFrame.Top=85; posicao em Page1 = Top_original - 85
15: *   lbl_periodo     : Top=137, Left=252 -> Page1: Top=52, Left=252
16: *   get_dt_inicial  : Top=132, Left=300 -> Page1: Top=47, Left=300, Width=80
17: *   lbl_periodo_a   : Top=136, Left=384 -> Page1: Top=51, Left=384 (CHR(224) = a-grave)
18: *   get_dt_final    : Top=132, Left=396 -> Page1: Top=47, Left=396, Width=80
19: *   Say1 (cotacao)  : Top=160, Left=222 -> Page1: Top=75, Left=222

*-- Linhas 60 a 68:
60:         loc_lContinuar = .T.
61: 
62:         TRY
63:             THIS.Caption = "Relat" + CHR(243) + "rio de Resultados"
64: 
65:             IF TYPE("gc_4c_CaminhoIcones") = "U"
66:                 gc_4c_CaminhoIcones = ""
67:             ENDIF
68:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 108 a 172:
108:         loc_oCab = THIS.cnt_4c_Cabecalho
109: 
110:         WITH loc_oCab
111:             .Top         = 0
112:             .Left        = 0
113:             .Width       = THIS.Width
114:             .Height      = 80
115:             .BackStyle   = 1
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119: 
120:             .AddObject("lbl_4c_Sombra", "Label")
121:             WITH .lbl_4c_Sombra
122:                 .Top       = 22
123:                 .Left      = 22
124:                 .Width     = THIS.Width
125:                 .Height    = 30
126:                 .Caption   = "Relat" + CHR(243) + "rio de Resultados"
127:                 .FontName  = "Tahoma"
128:                 .FontSize  = 14
129:                 .FontBold  = .T.
130:                 .ForeColor = RGB(0, 0, 0)
131:                 .BackStyle = 0
132:                 .Visible   = .T.
133:             ENDWITH
134: 
135:             .AddObject("lbl_4c_Titulo", "Label")
136:             WITH .lbl_4c_Titulo
137:                 .Top       = 20
138:                 .Left      = 20
139:                 .Width     = THIS.Width
140:                 .Height    = 30
141:                 .Caption   = "Relat" + CHR(243) + "rio de Resultados"
142:                 .FontName  = "Tahoma"
143:                 .FontSize  = 14
144:                 .FontBold  = .T.
145:                 .ForeColor = RGB(255, 255, 255)
146:                 .BackStyle = 0
147:                 .Visible   = .T.
148:             ENDWITH
149: 
150:             *-- Botoes de relatorio (framework frmrelatorio: cmg_4c_Botoes)
151:             .AddObject("cmg_4c_Botoes", "CommandGroup")
152:             WITH .cmg_4c_Botoes
153:                 .Top           = 0
154:                 .Left          = 527
155:                 .Width         = THIS.Width
156:                 .Height        = 80
157:                 .ButtonCount   = 4
158:                 .BackStyle     = 0
159:                 .BorderColor   = RGB(136, 189, 188)
160:                 .SpecialEffect = 1
161:                 .Themes        = .F.
162:                 .Visible       = .T.
163: 
164:                 WITH .Buttons(1)
165:                     .Caption         = "Visualizar"
166:                     .Top             = 5
167:                     .Left            = 5
168:                     .Width           = THIS.Width
169:                     .Height          = 70
170:                     .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
171:                     .PicturePosition = 13
172:                     .FontBold        = .T.

*-- Linhas 179 a 234:
179:                 ENDWITH
180: 
181:                 WITH .Buttons(2)
182:                     .Caption         = "Imprimir"
183:                     .Top             = 5
184:                     .Left            = 71
185:                     .Width           = THIS.Width
186:                     .Height          = 70
187:                     .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
188:                     .PicturePosition = 13
189:                     .FontName        = "Comic Sans MS"
190:                     .FontBold        = .T.
191:                     .FontItalic      = .T.
192:                     .FontSize        = 8
193:                     .BackColor       = RGB(255, 255, 255)
194:                     .ForeColor       = RGB(90, 90, 90)
195:                     .SpecialEffect   = 0
196:                     .MousePointer    = 15
197:                     .Themes          = .F.
198:                 ENDWITH
199: 
200:                 WITH .Buttons(3)
201:                     .Caption         = "Doc. Excel"
202:                     .Top             = 5
203:                     .Left            = 137
204:                     .Width           = THIS.Width
205:                     .Height          = 70
206:                     .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
207:                     .PicturePosition = 13
208:                     .FontName        = "Comic Sans MS"
209:                     .FontBold        = .T.
210:                     .FontItalic      = .T.
211:                     .FontSize        = 8
212:                     .BackColor       = RGB(255, 255, 255)
213:                     .ForeColor       = RGB(90, 90, 90)
214:                     .SpecialEffect   = 0
215:                     .MousePointer    = 15
216:                     .Themes          = .F.
217:                 ENDWITH
218: 
219:                 WITH .Buttons(4)
220:                     .Caption         = "Sair"
221:                     .Top             = 5
222:                     .Left            = 203
223:                     .Width           = THIS.Width
224:                     .Height          = 70
225:                     .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
226:                     .PicturePosition = 13
227:                     .Cancel          = .T.
228:                     .FontName        = "Comic Sans MS"
229:                     .FontBold        = .T.
230:                     .FontItalic      = .T.
231:                     .FontSize        = 8
232:                     .BackColor       = RGB(255, 255, 255)
233:                     .ForeColor       = RGB(90, 90, 90)
234:                     .SpecialEffect   = 0

*-- Linhas 248 a 271:
248:     *--------------------------------------------------------------------------
249:     * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
250:     *   Form: Width=800, Height=300
251:     *   Cabecalho Height=80; PageFrame.Top=85, Height=300-85=215, Width=802
252:     *--------------------------------------------------------------------------
253:     PROTECTED PROCEDURE ConfigurarPageFrame()
254:         LOCAL loc_oPgf
255: 
256:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
257:         loc_oPgf = THIS.pgf_4c_Paginas
258: 
259:         loc_oPgf.PageCount = 1
260:         loc_oPgf.Top       = 85
261:         loc_oPgf.Left      = -1
262:         loc_oPgf.Width     = THIS.Width + 2
263:         loc_oPgf.Height    = THIS.Height - 85
264:         loc_oPgf.Tabs      = .F.
265: 
266:         loc_oPgf.Page1.Caption   = "Filtros"
267:         loc_oPgf.Page1.FontName  = "Tahoma"
268:         loc_oPgf.Page1.FontSize  = 8
269:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
270:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
271:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 317 a 429:
317:         LOCAL loc_oPagina
318:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
319: 
320:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
321:         WITH loc_oPagina.lbl_4c_Periodo
322:             .Top       = 52
323:             .Left      = 252
324:             .Width     = 45
325:             .Height    = 18
326:             .Caption   = "Per" + CHR(237) + "odo :"
327:             .FontName  = "Tahoma"
328:             .FontSize  = 8
329:             .ForeColor = RGB(90, 90, 90)
330:             .BackStyle = 0
331:             .Visible   = .T.
332:         ENDWITH
333: 
334:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
335:         WITH loc_oPagina.txt_4c_DtInicial
336:             .Top         = 47
337:             .Left        = 300
338:             .Width       = 80
339:             .Height      = 23
340:             .Value       = {}
341:             .FontName    = "Tahoma"
342:             .FontSize    = 8
343:             .ForeColor   = RGB(90, 90, 90)
344:             .BorderStyle = 1
345:             .Visible     = .T.
346:         ENDWITH
347:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
348: 
349:         loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
350:         WITH loc_oPagina.lbl_4c_PeriodoA
351:             .Top       = 51
352:             .Left      = 384
353:             .Width     = 8
354:             .Height    = 18
355:             .Caption   = CHR(224)
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .ForeColor = RGB(90, 90, 90)
359:             .BackStyle = 0
360:             .Visible   = .T.
361:         ENDWITH
362: 
363:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
364:         WITH loc_oPagina.txt_4c_DtFinal
365:             .Top         = 47
366:             .Left        = 396
367:             .Width       = 80
368:             .Height      = 23
369:             .Value       = {}
370:             .FontName    = "Tahoma"
371:             .FontSize    = 8
372:             .ForeColor   = RGB(90, 90, 90)
373:             .BorderStyle = 1
374:             .Visible     = .T.
375:         ENDWITH
376:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")
377: 
378:         loc_oPagina.AddObject("lbl_4c_DtCotacao", "Label")
379:         WITH loc_oPagina.lbl_4c_DtCotacao
380:             .Top       = 75
381:             .Left      = 222
382:             .Width     = 75
383:             .Height    = 18
384:             .Caption   = "Data Cota" + CHR(231) + CHR(227) + "o :"
385:             .FontName  = "Tahoma"
386:             .FontSize  = 8
387:             .ForeColor = RGB(90, 90, 90)
388:             .BackStyle = 0
389:             .Visible   = .T.
390:         ENDWITH
391: 
392:         loc_oPagina.AddObject("txt_4c_DtCotacao", "TextBox")
393:         WITH loc_oPagina.txt_4c_DtCotacao
394:             .Top         = 72
395:             .Left        = 300
396:             .Width       = 80
397:             .Height      = 23
398:             .Value       = {}
399:             .FontName    = "Tahoma"
400:             .FontSize    = 8
401:             .ForeColor   = RGB(90, 90, 90)
402:             .BorderStyle = 1
403:             .Visible     = .T.
404:         ENDWITH
405:         BINDEVENT(loc_oPagina.txt_4c_DtCotacao, "KeyPress", THIS, "TeclaDtCotacao")
406: 
407:         loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
408:         WITH loc_oPagina.lbl_4c_Empresa
409:             .Top       = 102
410:             .Left      = 247
411:             .Width     = 50
412:             .Height    = 18
413:             .Caption   = "Empresa :"
414:             .FontName  = "Tahoma"
415:             .FontSize  = 8
416:             .ForeColor = RGB(90, 90, 90)
417:             .BackStyle = 0
418:             .Visible   = .T.
419:         ENDWITH
420: 
421:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
422:         WITH loc_oPagina.txt_4c_Empresa
423:             .Top         = 97
424:             .Left        = 300
425:             .Width       = 31
426:             .Height      = 23
427:             .Value       = ""
428:             .FontName    = "Tahoma"
429:             .FontSize    = 8

*-- Linhas 436 a 445:
436: 
437:         loc_oPagina.AddObject("txt_4c_EmpresaDesc", "TextBox")
438:         WITH loc_oPagina.txt_4c_EmpresaDesc
439:             .Top         = 97
440:             .Left        = 333
441:             .Width       = 290
442:             .Height      = 23
443:             .Value       = ""
444:             .FontName    = "Tahoma"
445:             .FontSize    = 8

*-- Linhas 650 a 667:
650:                 loc_oPg = THIS.pgf_4c_Paginas.Page1
651:                 WITH THIS.this_oRelatorio
652:                     IF !EMPTY(.this_dDtInicial)
653:                         loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
654:                     ENDIF
655:                     IF !EMPTY(.this_dDtFinal)
656:                         loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
657:                     ENDIF
658:                     IF !EMPTY(.this_dDtCotacao)
659:                         loc_oPg.txt_4c_DtCotacao.Value = .this_dDtCotacao
660:                     ENDIF
661:                     loc_oPg.txt_4c_Empresa.Value     = .this_cEmpresa
662:                     loc_oPg.txt_4c_EmpresaDesc.Value = .this_cEmpresaDesc
663:                 ENDWITH
664:             ENDIF
665:         CATCH TO loc_oErro
666:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
667:         ENDTRY


### BO (C:\4c\projeto\app\classes\sigreanrBO.prg):
*==============================================================================
* SIGREANRBO.PRG
* Business Object para Relatorio de Resultados
*
* Herda de RelatorioBase
* Form: Formsigreanr.prg
* Relatorio: SigReAnr.frx (REPORT FORM SigReAnr)
*
* Filtros: Periodo (DtInicial/DtFinal), Data Cotacao, Empresa
* Tabelas: SigCdOpe, SigMvCab, SigMvPar, SigCdEmp, SigCdMoe, SigCdCli, SigCdCot
* Cursores de saida (referenciados pelo .FRX):
*   TmpFinal   - dados principais por cliente/grupo/conta
*   TmpCabec   - cabecalho de colunas de moeda por empresa
*   dbCabecalho - titulo, periodo e nome da empresa
* Variaveis PUBLIC (referenciadas pelo .FRX):
*   _TotalTit, _TotalVal, _TotalGTit, _TotalGVal, _TotalGCot
*==============================================================================

DEFINE CLASS sigreanrBO AS RelatorioBase

    *-- Filtros do relatorio (entradas do form)
    this_dDtInicial     = {}
    this_dDtFinal       = {}
    this_dDtCotacao     = {}
    this_cEmpresa       = ""
    this_cEmpresaDesc   = ""

    *-- Configuracao do relatorio
    this_cArquivoFRX    = ""
    this_cTitulo        = ""

    *-- Cursor principal de saida (compativel com .FRX original)
    this_cCursorDados   = "TmpFinal"

    *--------------------------------------------------------------------------
    * Init - Configura arquivo FRX e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "SigReAnr.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Resultados"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio
    * Replica a PROCEDURE processamento do SIGREANR.SCX original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo
        LOCAL loc_cEmpresa, loc_cDopAtual, loc_nCOpers, loc_cEmpAtual
        LOCAL loc_lcQuery, loc_nResult
        LOCAL loc_lcEdn, loc_cGrupo, loc_cConta, loc_cTipoOper, loc_nValor
        LOCAL loc_nConta1, loc_nConta2, loc_lnNOrdRels
        LOCAL loc_nTotalGeral, loc_nCot1
        LOCAL loc_cTotalTit, loc_cTotalVal, loc_cTotalGTit, loc_cTotalGVal, loc_cTotalGCot
        LOCAL loc_cRazas, loc_cNomeCli

        loc_lSucesso     = .F.

        TRY
            DO WHILE .T.

                loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)

                *-- Busca nome da empresa corrente (cabecalho do relatorio)
                loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                              "WHERE Cemps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdEmpHdr")
                loc_cNomeEmpresa = ""
                IF loc_nResult > 0 AND !EOF("crSigCdEmpHdr")
                    SELECT crSigCdEmpHdr
                    loc_cNomeEmpresa = ALLTRIM(Razas)
                ENDIF
                IF USED("crSigCdEmpHdr")
                    USE IN crSigCdEmpHdr
                ENDIF

                loc_cTitulo  = "Relat" + CHR(243) + "rio de Resultados - Empresa : " + ;
                               IIF(EMPTY(loc_cEmpresa), "Todas", loc_cEmpresa)
                loc_cPeriodo = "Per" + CHR(237) + "odo : " + ;
                               DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                               DTOC(THIS.this_dDtFinal)

                *-- Cursor de cabecalho do relatorio (dbCabecalho)
                IF USED("dbCabecalho")
                    USE IN dbCabecalho
                ENDIF
                CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                           Cabecalho C(200), Campo1 C(20), Campo2 C(20), ;
                                           Campo3 C(20), Campo4 C(20), Campo5 C(20), TotalGeral M(4))
                INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo)

                *-- Cursor acumulador de valores por cliente/grupo/conta/moeda
                IF USED("TmpCli")
                    USE IN TmpCli
                ENDIF
                CREATE CURSOR TmpCli (Grupo C(10), Conta C(10), TipoOper C(1), ;
                                      Emps C(3), Valor N(12,2), Moeda C(3))

                *-- Busca operacoes com fechamento habilitado (RelFechas = 1)
                loc_lcQuery = "SELECT Dopes, COpers FROM SigCdOpe " + ;
                              "WHERE RelFechas = 1 ORDER BY Dopes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdOpe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdOpe)"
                    EXIT
                ENDIF

                *-- Busca empresas (filtradas ou todas)
                IF EMPTY(loc_cEmpresa)
                    loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp"
                ELSE
                    loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                                  "WHERE Cemps = " + EscaparSQL(loc_cEmpresa)
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdEmp")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdEmp)"
                    EXIT
                ENDIF
                SELECT crSigCdEmp
                INDEX ON Cemps TAG Cemps

                *-- Loop externo: para cada operacao (tipo de lancamento)
                SELECT crSigCdOpe
                SCAN
                    loc_cDopAtual = ALLTRIM(crSigCdOpe.Dopes)
                    loc_nCOpers   = crSigCdOpe.COpers

                    WAIT WINDOW "Processando Opera" + CHR(231) + CHR(245) + "es: " + ;
                                loc_cDopAtual + "..." NOWAIT

                    *-- Loop interno: para cada empresa
                    SELECT crSigCdEmp
                    SCAN
                        loc_cEmpAtual = ALLTRIM(crSigCdEmp.Cemps)

                        *-- Movimentos no periodo para esta empresa/operacao
                        loc_lcQuery = "SELECT Emps, Dopes, Numes, GrupoDs, ContaDs, GrupoOs, ContaOs " + ;
                                      "FROM SigMvCab " + ;
                                      "WHERE Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                                      " AND Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                                      " AND Emps = " + EscaparSQL(loc_cEmpAtual) + ;
                                      " AND Dopes = " + EscaparSQL(loc_cDopAtual)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCab")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigMvCab)"
                            EXIT
                        ENDIF

                        *-- Para cada movimento, acumula parcelas em TmpCli
                        SELECT crSigMvCab
                        SCAN
                            IF NVL(loc_nCOpers, 0) = 1
                                loc_cGrupo    = crSigMvCab.GrupoDs
                                loc_cConta    = crSigMvCab.ContaDs
                                loc_cTipoOper = "1"
                            ELSE
                                loc_cGrupo    = crSigMvCab.GrupoOs
                                loc_cConta    = crSigMvCab.ContaOs
                                loc_cTipoOper = "2"
                            ENDIF

                            loc_lcEdn = ALLTRIM(crSigMvCab.Emps) + ;
                                        ALLTRIM(crSigMvCab.Dopes) + ;
                                        STR(crSigMvCab.Numes, 6)

                            *-- Parcelas de pagamento deste movimento
                            loc_lcQuery = "SELECT MoeFpgs, Valos FROM SigMvPar " + ;
                                          "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn)
                            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvPar")
                            IF loc_nResult > 0
                                SELECT crSigMvPar
                                SCAN
                                    loc_nValor = crSigMvPar.Valos * IIF(NVL(loc_nCOpers, 0) = 1, 1, -1)
                                    INSERT INTO TmpCli (Grupo, Conta, TipoOper, Emps, Valor, Moeda) ;
                                        VALUES (loc_cGrupo, loc_cConta, loc_cTipoOper, ;
                                                crSigMvCab.Emps, loc_nValor, crSigMvPar.MoeFpgs)
                                ENDSCAN
                            ENDIF
                            IF USED("crSigMvPar")
                                USE IN crSigMvPar
                            ENDIF
                            SELECT crSigMvCab
                        ENDSCAN

                        IF USED("crSigMvCab")
                            USE IN crSigMvCab
                        ENDIF

                        IF !EMPTY(THIS.this_cMensagemErro)
                            EXIT
                        ENDIF
                        SELECT crSigCdEmp
                    ENDSCAN

                    IF !EMPTY(THIS.this_cMensagemErro)
                        EXIT
                    ENDIF
                    SELECT crSigCdOpe
                ENDSCAN
                WAIT CLEAR

                IF !EMPTY(THIS.this_cMensagemErro)
                    EXIT
                ENDIF

                *-- Indexa TmpCli para busca por empresa/grupo/conta
                SELECT TmpCli
                INDEX ON Emps + Grupo + Conta + TipoOper TAG EmpDopCon

                *-- Cursor de cabecalho de colunas de moeda por empresa
                IF USED("TmpCabec")
                    USE IN TmpCabec
                ENDIF
                CREATE CURSOR TmpCabec (Emps C(3), Op11 C(3), Op12 C(3), Op13 C(3), ;
                                        Op21 C(3), Op22 C(3), Op23 C(3))
                INDEX ON Emps TAG Emps

                *-- Busca moedas com sua ordem de exibicao no relatorio
                loc_lcQuery = "SELECT CMoes, NOrdRels, Cotas FROM SigCdMoe"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdMoe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdMoe)"
                    EXIT
                ENDIF
                SELECT crSigCdMoe
                INDEX ON CMoes TAG CMoes

                *-- Combinacoes distintas de empresa/tipo/moeda presentes em TmpCli
                SELECT DISTINCT a.Emps, a.TipoOper, ;
                       IIF(EMPTY(b.NOrdRels), 9, b.NOrdRels) AS NOrdRels, a.Moeda ;
                  FROM TmpCli a, crSigCdMoe b ;
                 WHERE a.Moeda = b.CMoes ;
                  INTO CURSOR Operas

                *-- Atribui moedas as colunas Op11..Op13 (tipo 1) e Op21..Op23 (tipo 2)
                loc_nConta1 = 0
                loc_nConta2 = 0
                SELECT Operas
                SCAN
                    IF !SEEK(ALLTRIM(Operas.Emps), "TmpCabec", "Emps")
                        INSERT INTO TmpCabec (Emps) VALUES (Operas.Emps)
                        SELECT TmpCabec
                        SEEK ALLTRIM(Operas.Emps) ORDER TAG Emps
                        loc_nConta1 = 0
                        loc_nConta2 = 0
                    ENDIF

                    IF ALLTRIM(Operas.TipoOper) = "1"
                        loc_nConta1 = loc_nConta1 + 1
                        IF loc_nConta1 <= 3
                            DO CASE
                            CASE loc_nConta1 = 1
                                REPLACE Op11 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta1 = 2
                                REPLACE Op12 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta1 = 3
                                REPLACE Op13 WITH Operas.Moeda IN TmpCabec
                            ENDCASE
                        ENDIF
                    ELSE
                        loc_nConta2 = loc_nConta2 + 1
                        IF loc_nConta2 <= 3
                            DO CASE
                            CASE loc_nConta2 = 1
                                REPLACE Op21 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta2 = 2
                                REPLACE Op22 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta2 = 3
                                REPLACE Op23 WITH Operas.Moeda IN TmpCabec
                            ENDCASE
                        ENDIF
                    ENDIF
                    SELECT Operas
                ENDSCAN

                *-- Cursor de totais por moeda
                IF USED("TmpTotal")
                    USE IN TmpTotal
                ENDIF
                CREATE CURSOR TmpTotal (Moeda C(3), Valor N(12,2), NOrdRels N(1))
                INDEX ON Moeda TAG Moeda

                *-- Cursor final de dados do relatorio (compativel com SigReAnr.frx)
                IF USED("TmpFinal")
                    USE IN TmpFinal
                ENDIF
                CREATE CURSOR TmpFinal (Emps C(3), Grupo C(10), Conta C(10), Datas D, ;
                                        NomeCli C(40), Razas C(40), ;
                                        Valor1 N(12,2), Moeda1 C(3), ;
                                        Valor2 N(12,2), Moeda2 C(3), ;
                                        Valor3 N(12,2), Moeda3 C(3), ;
                                        Valor4 N(12,2), Moeda4 C(3), ;
                                        Valor5 N(12,2), Moeda5 C(3), ;
                                        Valor6 N(12,2), Moeda6 C(3))
                INDEX ON Emps + Grupo + Conta + DTOS(Datas) TAG EmpConDat

                *-- Popula TmpFinal acumulando valores por moeda/tipo de operacao
                SELECT TmpCli
                WAIT WINDOW "Processando Clientes..." NOWAIT
                GO TOP
                SCAN
                    *-- Posiciona TmpCabec na empresa do registro atual
                    = SEEK(ALLTRIM(TmpCli.Emps), "TmpCabec", "Emps")

                    *-- Busca razao social da empresa
                    = SEEK(ALLTRIM(TmpCli.Emps), "crSigCdEmp", "Cemps")
                    loc_cRazas = IIF(FOUND("crSigCdEmp"), ALLTRIM(crSigCdEmp.Razas), "")

                    *-- Busca nome do cliente (conta)
                    loc_lcQuery = "SELECT IClis, RClis FROM SigCdCli " + ;
                                  "WHERE IClis = " + EscaparSQL(ALLTRIM(TmpCli.Conta))
                    loc_cNomeCli = ""
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdCli") > 0 AND ;
                       !EOF("crSigCdCli")
                        SELECT crSigCdCli
                        loc_cNomeCli = ALLTRIM(RClis)
                    ENDIF
                    IF USED("crSigCdCli")
                        USE IN crSigCdCli
                    ENDIF

                    *-- Localiza ou cria linha em TmpFinal para este cliente
                    IF !SEEK(ALLTRIM(TmpCli.Emps) + ALLTRIM(TmpCli.Grupo) + ALLTRIM(TmpCli.Conta), ;
                             "TmpFinal", "EmpConDat")
                        INSERT INTO TmpFinal (Emps, Grupo, Conta, NomeCli, Razas) ;
                            VALUES (TmpCli.Emps, TmpCli.Grupo, TmpCli.Conta, ;
                                    loc_cNomeCli, loc_cRazas)
                    ENDIF

                    *-- Acumula valor na coluna de moeda correspondente ao tipo de operacao
                    DO CASE
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op11)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor1 WITH TmpFinal.Valor1 + TmpCli.Valor, ;
                                Moeda1 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op12)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor2 WITH TmpFinal.Valor2 + TmpCli.Valor, ;
                                Moeda2 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op13)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor3 WITH TmpFinal.Valor3 + TmpCli.Valor, ;
                                Moeda3 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op21)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor4 WITH TmpFinal.Valor4 + TmpCli.Valor, ;
                                Moeda4 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op22)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor5 WITH TmpFinal.Valor5 + TmpCli.Valor, ;
                                Moeda5 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op23)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor6 WITH TmpFinal.Valor6 + TmpCli.Valor, ;
                                Moeda6 WITH TmpCli.Moeda IN TmpFinal
                    ENDCASE

                    *-- Acumula total por moeda em TmpTotal
                    IF !SEEK(ALLTRIM(TmpCli.Moeda), "TmpTotal", "Moeda")
                        = SEEK(ALLTRIM(TmpCli.Moeda), "crSigCdMoe", "CMoes")
                        loc_lnNOrdRels = IIF(FOUND("crSigCdMoe"), crSigCdMoe.NOrdRels, 9)
                        INSERT INTO TmpTotal (Moeda, NOrdRels) ;
                            VALUES (TmpCli.Moeda, loc_lnNOrdRels)
                        = SEEK(ALLTRIM(TmpCli.Moeda), "TmpTotal", "Moeda")
                    ENDIF
                    REPLACE Valor WITH TmpTotal.Valor + TmpCli.Valor IN TmpTotal

                    SELECT TmpCli
                ENDSCAN
                WAIT CLEAR

                *-- Adiciona moedas sem cotacao que ainda nao constam em TmpTotal
                SELECT crSigCdMoe
                SCAN FOR !Cotas
                    IF !SEEK(ALLTRIM(crSigCdMoe.CMoes), "TmpTotal", "Moeda")
                        loc_lnNOrdRels = crSigCdMoe.NOrdRels
                        INSERT INTO TmpTotal (Moeda, NOrdRels) ;
                            VALUES (crSigCdMoe.CMoes, loc_lnNOrdRels)
                        = SEEK(ALLTRIM(crSigCdMoe.CMoes), "TmpTotal", "Moeda")
                    ENDIF
                    SELECT crSigCdMoe
                ENDSCAN

                *-- Calcula totais parciais por moeda com cotacao na data informada
                loc_cTotalTit  = ""
                loc_cTotalVal  = ""
                loc_nTotalGeral = 0

                SELECT TmpTotal
                SCAN
                    loc_cTotalTit  = loc_cTotalTit + "Total em " + ;
                                     ALLTRIM(TmpTotal.Moeda) + " : " + CHR(13) + CHR(10)
                    loc_cTotalVal  = loc_cTotalVal + ;
                                     TRANSFORM(TmpTotal.Valor, "999,999,999.99") + ;
                                     CHR(13) + CHR(10)
                    loc_nCot1 = THIS.BuscarCotacao(ALLTRIM(TmpTotal.Moeda), THIS.this_dDtCotacao)
                    loc_nTotalGeral = loc_nTotalGeral + ROUND(TmpTotal.Valor * loc_nCot1, 2)
                    SELECT TmpTotal
                ENDSCAN

                *-- Calcula totais gerais convertidos para cada moeda
                loc_cTotalGTit = ""
                loc_cTotalGVal = ""
                loc_cTotalGCot = ""

                SELECT TmpTotal
                SCAN
                    loc_nCot1 = THIS.BuscarCotacao(ALLTRIM(TmpTotal.Moeda), THIS.this_dDtCotacao)
                    loc_cTotalGTit = loc_cTotalGTit + "Total Geral " + ;
                                     ALLTRIM(TmpTotal.Moeda) + " : " + CHR(13) + CHR(10)
                    IF loc_nCot1 > 0
                        loc_cTotalGVal = loc_cTotalGVal + ;
                                         TRANSFORM(ROUND(loc_nTotalGeral / loc_nCot1, 2), ;
                                                   "999,999,999.99") + CHR(13) + CHR(10)
                    ELSE
                        loc_cTotalGVal = loc_cTotalGVal + "0.00" + CHR(13) + CHR(10)
                    ENDIF
                    loc_cTotalGCot = loc_cTotalGCot + ;
                                     TRANSFORM(loc_nCot1, "99,999.999999") + CHR(13) + CHR(10)
                    SELECT TmpTotal
                ENDSCAN

                *-- Publica variaveis para o relatorio .FRX
                PUBLIC _TotalTit, _TotalVal, _TotalGTit, _TotalGVal, _TotalGCot
                _TotalTit  = loc_cTotalTit
                _TotalVal  = loc_cTotalVal
                _TotalGTit = loc_cTotalGTit
                _TotalGVal = loc_cTotalGVal
                _TotalGCot = loc_cTotalGCot

                *-- Relacao TmpFinal -> TmpCabec para o relatorio
                SELECT TmpFinal
                SET RELATION TO Emps INTO TmpCabec
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
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotAnr")
        IF loc_nResult > 0 AND !EOF("cursor_4c_CotAnr")
            SELECT cursor_4c_CotAnr
            IF NVL(valos, 0) > 0
                loc_nTaxa = valos
            ENDIF
        ENDIF

        IF USED("cursor_4c_CotAnr")
            USE IN cursor_4c_CotAnr
        ENDIF

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime diretamente na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
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
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e gera documento (imprime para arquivo)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER NOCONSOLE
                THIS.RegistrarAuditoria("EXPORTAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao
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

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREANR") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter um contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao - em vez de silenciar com herda padrao.
    *
    * Para relatorios, o fluxo correto eh:
    *   - PrepararDados() monta os cursores de saida (TmpFinal, TmpCabec,
    *     TmpCli, TmpTotal, dbCabecalho) via SQLEXEC sobre o periodo filtrado
    *   - Imprimir() / Visualizar() / GerarExcel() consomem esses cursores
    *     atraves do .FRX SigReAnr
    *
    * Qualquer chamada a uma destas rotinas em runtime indica uso incorreto
    * da API e deve falhar de forma observavel (mensagem de erro + retorno .F.).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos e cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("TmpFinal")
            SELECT TmpFinal
            SET RELATION TO
            USE IN TmpFinal
        ENDIF
        IF USED("TmpCabec")
            USE IN TmpCabec
        ENDIF
        IF USED("TmpCli")
            USE IN TmpCli
        ENDIF
        IF USED("TmpTotal")
            USE IN TmpTotal
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("crSigCdOpe")
            USE IN crSigCdOpe
        ENDIF
        IF USED("crSigCdEmp")
            USE IN crSigCdEmp
        ENDIF
        IF USED("crSigCdMoe")
            USE IN crSigCdMoe
        ENDIF
        IF USED("Operas")
            USE IN Operas
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

