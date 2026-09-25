# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 180: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 201: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 223: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 246: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGMVDOC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (895 linhas total):

*-- Linhas 57 a 65:
57:         loc_lSucesso   = .F.
58:         loc_lContinuar = .T.
59:         TRY
60:             THIS.Caption = "Emiss" + CHR(227) + "o do Documento"
61: 
62:             IF TYPE("gc_4c_CaminhoIcones") = "U"
63:                 gc_4c_CaminhoIcones = ""
64:             ENDIF
65:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 81 a 90:
81:                 THIS.ConfigurarPageFrame()
82:                 THIS.ConfigurarPaginaLista()
83: 
84:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
85:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
86: 
87:                 *-- Liga os controles de filtro aos handlers e carrega a faixa
88:                 *   inicial de Notas (equivalente ao final do Init legado)
89:                 THIS.ConfigurarPaginaDados()
90:                 THIS.LimparCampos()

*-- Linhas 107 a 145:
107:     PROTECTED PROCEDURE ConfigurarCabecalho()
108:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
109:         WITH THIS.cnt_4c_Cabecalho
110:             .Top         = 0
111:             .Left        = 0
112:             .Width       = THIS.Width
113:             .Height      = 80
114:             .BackStyle   = 1
115:             .BackColor   = RGB(100, 100, 100)
116:             .BorderWidth = 0
117:             .Visible     = .T.
118: 
119:             .AddObject("lbl_4c_Sombra", "Label")
120:             WITH .lbl_4c_Sombra
121:                 .Top       = 22
122:                 .Left      = 22
123:                 .Width     = THIS.Width
124:                 .Height    = 30
125:                 .Caption   = "Emiss" + CHR(227) + "o do Documento"
126:                 .FontName  = "Tahoma"
127:                 .FontSize  = 14
128:                 .FontBold  = .T.
129:                 .ForeColor = RGB(0, 0, 0)
130:                 .BackStyle = 0
131:                 .Visible   = .T.
132:             ENDWITH
133: 
134:             .AddObject("lbl_4c_Titulo", "Label")
135:             WITH .lbl_4c_Titulo
136:                 .Top       = 20
137:                 .Left      = 20
138:                 .Width     = THIS.Width
139:                 .Height    = 30
140:                 .Caption   = "Emiss" + CHR(227) + "o do Documento"
141:                 .FontName  = "Tahoma"
142:                 .FontSize  = 14
143:                 .FontBold  = .T.
144:                 .ForeColor = RGB(255, 255, 255)
145:                 .BackStyle = 0

*-- Linhas 159 a 186:
159:     PROTECTED PROCEDURE ConfigurarBotoes()
160:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
161:         WITH THIS.cmg_4c_Botoes
162:             .Top           = 0
163:             .Left          = 495
164:             .Width         = 310
165:             .Height        = 85
166:             .ButtonCount   = 4
167:             .BackStyle     = 0
168:             .BorderStyle   = 0
169:             .BorderColor   = RGB(136, 189, 188)
170:             .SpecialEffect = 1
171:             .Themes        = .F.
172:             .Visible       = .T.
173: 
174:             WITH .Buttons(1)
175:                 .Top             = 5
176:                 .Left            = 5
177:                 .Width           = 75
178:                 .Height          = 75
179:                 .Caption         = "\<Visualizar"
180:                 .FontName        = "Comic Sans MS"
181:                 .FontSize        = 8
182:                 .FontBold        = .T.
183:                 .FontItalic      = .T.
184:                 .BackColor       = RGB(255, 255, 255)
185:                 .ForeColor       = RGB(90, 90, 90)
186:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 193 a 207:
193:             ENDWITH
194: 
195:             WITH .Buttons(2)
196:                 .Top             = 5
197:                 .Left            = 80
198:                 .Width           = 75
199:                 .Height          = 75
200:                 .Caption         = "\<Imprimir"
201:                 .FontName        = "Comic Sans MS"
202:                 .FontSize        = 8
203:                 .FontBold        = .T.
204:                 .FontItalic      = .T.
205:                 .BackColor       = RGB(255, 255, 255)
206:                 .ForeColor       = RGB(90, 90, 90)
207:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 214 a 229:
214:             ENDWITH
215: 
216:             WITH .Buttons(3)
217:                 .Top             = 5
218:                 .Left            = 155
219:                 .Width           = 75
220:                 .Height          = 75
221:                 .Caption         = "\<Arquivos Email"
222:                 .WordWrap        = .T.
223:                 .FontName        = "Comic Sans MS"
224:                 .FontSize        = 8
225:                 .FontBold        = .T.
226:                 .FontItalic      = .T.
227:                 .BackColor       = RGB(255, 255, 255)
228:                 .ForeColor       = RGB(90, 90, 90)
229:                 .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"

*-- Linhas 236 a 252:
236:             ENDWITH
237: 
238:             WITH .Buttons(4)
239:                 .Top             = 5
240:                 .Left            = 230
241:                 .Width           = 75
242:                 .Height          = 75
243:                 .Caption         = "\<Encerrar"
244:                 .Cancel          = .T.
245:                 .WordWrap        = .T.
246:                 .FontName        = "Comic Sans MS"
247:                 .FontSize        = 8
248:                 .FontBold        = .T.
249:                 .FontItalic      = .T.
250:                 .BackColor       = RGB(255, 255, 255)
251:                 .ForeColor       = RGB(90, 90, 90)
252:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 275 a 289:
275:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
276:         loc_oPgf.PageCount = 1
277: 
278:         loc_oPgf.Top    = 80
279:         loc_oPgf.Left   = -1
280:         loc_oPgf.Width  = THIS.Width + 2
281:         loc_oPgf.Height = THIS.Height - 80
282:         loc_oPgf.Tabs   = .F.
283: 
284:         loc_oPgf.Page1.Caption   = "Filtros"
285:         loc_oPgf.Page1.FontName  = "Tahoma"
286:         loc_oPgf.Page1.FontSize  = 8
287:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
288:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
289:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 322 a 363:
322:         *   SCX: BackStyle=0 / BorderStyle=0 / BorderColor=136,189,188
323:         loc_oPag.AddObject("shp_4c_Shape1", "Shape")
324:         WITH loc_oPag.shp_4c_Shape1
325:             .Top         = 10
326:             .Left        = 203
327:             .Width       = 394
328:             .Height      = 32
329:             .BackStyle   = 0
330:             .BorderStyle = 0
331:             .BorderColor = RGB(136, 189, 188)
332:             .Visible     = .T.
333:         ENDWITH
334: 
335:         *-- Label1 "Documentos de :"
336:         *   SCX declara AutoSize=.T., que eh no-op em Label criado por AddObject:
337:         *   usar Alignment=0 + Width explicita do legado (CLAUDE.md regra #23).
338:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
339:         WITH loc_oPag.lbl_4c_Label1
340:             .Top       = 18
341:             .Left      = 254
342:             .Width     = 96
343:             .Height    = 15
344:             .Caption   = "Documentos de :"
345:             .FontName  = "Tahoma"
346:             .FontSize  = 8
347:             .FontBold  = .T.
348:             .Alignment = 0
349:             .BackStyle = 0
350:             .ForeColor = RGB(90, 90, 90)
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         *-- GetNotaI -> txt_4c_NotaI (Nota Fiscal inicial da faixa)
355:         loc_oPag.AddObject("txt_4c_NotaI", "TextBox")
356:         WITH loc_oPag.txt_4c_NotaI
357:             .Top           = 15
358:             .Left          = 352
359:             .Width         = 60
360:             .Height        = 23
361:             .Value         = 0
362:             .InputMask     = "999999"
363:             .FontName      = "Tahoma"

*-- Linhas 370 a 398:
370:         ENDWITH
371: 
372:         *-- Label2 CHR(224) = "a" crasado (separador da faixa "de X a Y")
373:         loc_oPag.AddObject("lbl_4c_Label2", "Label")
374:         WITH loc_oPag.lbl_4c_Label2
375:             .Top       = 18
376:             .Left      = 419
377:             .Width     = 9
378:             .Height    = 15
379:             .Caption   = CHR(224)
380:             .FontName  = "Tahoma"
381:             .FontSize  = 8
382:             .FontBold  = .T.
383:             .Alignment = 0
384:             .BackStyle = 0
385:             .ForeColor = RGB(90, 90, 90)
386:             .Visible   = .T.
387:         ENDWITH
388: 
389:         *-- GetNotaF -> txt_4c_NotaF (Nota Fiscal final da faixa)
390:         loc_oPag.AddObject("txt_4c_NotaF", "TextBox")
391:         WITH loc_oPag.txt_4c_NotaF
392:             .Top           = 14
393:             .Left          = 434
394:             .Width         = 60
395:             .Height        = 23
396:             .Value         = 0
397:             .InputMask     = "999999"
398:             .FontName      = "Tahoma"

*-- Linhas 776 a 787:
776: 
777:         WITH THIS.this_oRelatorio
778:             IF VARTYPE(loc_oPag.txt_4c_NotaI) = "O"
779:                 loc_oPag.txt_4c_NotaI.Value = .this_nNotaI
780:             ENDIF
781:             IF VARTYPE(loc_oPag.txt_4c_NotaF) = "O"
782:                 loc_oPag.txt_4c_NotaF.Value = .this_nNotaF
783:             ENDIF
784:         ENDWITH
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SIGMVDOCBO.prg):
*==============================================================================
* SIGMVDOCBO.PRG
* Business Object para Relatorio de Emissao do Documento
*
* Herda de: RelatorioBase
* Form: FormSIGMVDOC.prg
* Relatorio original: SIGMVDOC.SCX (frmrelatorio) / SIGCDENT.FRX
*==============================================================================

DEFINE CLASS SIGMVDOCBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SIGCDENT"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario (faixa de Nota Fiscal)
    this_nNotaI             = 0
    this_nNotaF             = 0

    *-- Cursor principal gerado por PrepararDados (nome exigido pelo FRX legado)
    this_cCursorDados       = "crDados"

    *--------------------------------------------------------------------------
    * Init - Configura identificacao e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela           = ""
        THIS.this_cCampoChave       = ""
        THIS.this_cArquivoRelatorio = "SIGCDENT"
        THIS.this_cTituloRelatorio  = "Emiss" + CHR(227) + "o do Documento"
        THIS.this_cCursorDados      = "crDados"
        THIS.this_nNotaI            = 0
        THIS.this_nNotaF            = 0

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Busca os documentos (Notas Fiscais) da faixa informada
    *
    * O SIGMVDOC.SCX legado eh um dialogo generico de impressao (recebe pRep/pTit
    * e espera encontrar um cursor "crDados" ja aberto pelo chamador); nenhum
    * .prg/.scx legado que povoe esse crDados para pRep="SIGCDENT" sobreviveu no
    * acervo (busca exaustiva no Framework e em C:\4install no vieram vazios).
    * A tabela abaixo (SigMvNfi) foi identificada pelo schema: eh a UNICA tabela
    * com coluna nfis char(6) (mesmo tamanho do InputMask "999999" dos campos
    * GetNotaI/GetNotaF) que tambem tem a coluna "impress" (contador de
    * impressao), condizente com "Emissao do Documento".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult, loc_oErro
        LOCAL loc_cEmpresa, loc_cNotaI, loc_cNotaF

        loc_lSucesso = .F.

        TRY
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            IF THIS.this_nNotaI <= 0 OR THIS.this_nNotaF <= 0
                THIS.this_cMensagemErro = "Informe a faixa de Notas Fiscais (inicial e final)."
            ELSE
                IF THIS.this_nNotaI > THIS.this_nNotaF
                    THIS.this_cMensagemErro = "Nota Inicial maior que a Nota Final!"
                ELSE
                    loc_cNotaI = PADL(ALLTRIM(STR(THIS.this_nNotaI, 6, 0)), 6, "0")
                    loc_cNotaF = PADL(ALLTRIM(STR(THIS.this_nNotaF, 6, 0)), 6, "0")

                    IF USED(THIS.this_cCursorDados)
                        USE IN (THIS.this_cCursorDados)
                    ENDIF

                    loc_cWhere = "emps = " + EscaparSQL(loc_cEmpresa) + ;
                        " AND nfis BETWEEN " + EscaparSQL(loc_cNotaI) + ;
                        " AND " + EscaparSQL(loc_cNotaF)

                    loc_cSQL = "SELECT * FROM SigMvNfi WHERE " + loc_cWhere + " ORDER BY nfis"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar documentos: " + CapturarErroSQL()
                    ELSE
                        IF RECCOUNT(THIS.this_cCursorDados) = 0
                            THIS.this_cMensagemErro = "Nenhum documento encontrado para a faixa de notas informada."
                        ELSE
                            SELECT (THIS.this_cCursorDados)
                            GO TOP
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm (Pattern #117) - Executa REPORT FORM apenas se o FRX
    * existir; isola SET POINT/SEPARATOR/REPORTBEHAVIOR (FRXs legados Fortyus
    * foram desenhados em POINT="." + REPORTBEHAVIOR 80) e restaura o menu
    * principal apos o PREVIEW (Erro63 - _MREPORT corrompe o _MSYSMENU).
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe o documento em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PREVIEW", THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime o documento com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PRINTER_PROMPT", THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta o documento para planilha Excel via REPORT FORM ASCII
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_cFRX, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFRX = FULLPATH(gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio + ".frx")
                IF NOT FILE(loc_cFRX)
                    MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                        loc_cFRX, "Erro")
                ELSE
                    loc_cArquivo = SYS(5) + CURDIR() + "SigMvDoc_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (loc_cFRX) TO FILE (loc_cArquivo) NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao gerar arquivo Excel."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
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
    * ObterChavePrimaria - Identificador da execucao do relatorio (auditoria)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "SIGMVDOC|" + ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
            PADL(ALLTRIM(STR(THIS.this_nNotaI, 6, 0)), 6, "0") + "|" + ;
            PADL(ALLTRIM(STR(THIS.this_nNotaF, 6, 0)), 6, "0")
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o cursor de dados do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

