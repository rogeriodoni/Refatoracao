# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 293: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf1.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (767 linhas total):

*-- Linhas 69 a 77:
69: 
70:                 *-- Caption a partir do menu corrente
71:                 THIS.this_cCaption = PROMPT()
72:                 THIS.Caption       = THIS.this_cCaption
73: 
74:                 *-- Criar componentes (form OPERACIONAL layout flat sem PageFrame)
75:                 THIS.ConfigurarPaginaLista()
76: 
77:                 *-- BINDEVENT: validacao interativa ao sair do campo DtFinal

*-- Linhas 135 a 143:
135:     *
136:     * Todos os controles do form ja foram criados por ConfigurarPaginaLista()
137:     * nas fases 3-4 (cnt_4c_Cabecalho + cnt_4c_Aguarde + txt_4c_DtInicial +
138:     * txt_4c_DtFinal + lbl_4c_Periodo + cmg_4c_Processar). Este metodo eh
139:     * mantido como no-op documentado para atender o contrato de fases da
140:     * pipeline (que espera ConfigurarPaginaDados em todos os forms migrados).
141:     *
142:     * Se no futuro precisar adicionar campos de "detalhe" (segunda tela), a
143:     * implementacao seguiria o padrao AddObject aqui e a navegacao entre

*-- Linhas 156 a 202:
156:     PROTECTED PROCEDURE ConfigurarCabecalho()
157:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
158:         WITH THIS.cnt_4c_Cabecalho
159:             .Top        = 0
160:             .Left       = 0
161:             .Width      = THIS.Width
162:             .Height     = 80
163:             .BackStyle  = 1
164:             .BackColor  = RGB(100,100,100)
165:             .BorderWidth = 0
166: 
167:             .AddObject("lbl_4c_Sombra", "Label")
168:             WITH .lbl_4c_Sombra
169:                 .Top       = 18
170:                 .Left      = 10
171:                 .Width     = THIS.Width
172:                 .Height    = 40
173:                 .AutoSize  = .F.
174:                 .FontBold  = .T.
175:                 .FontName  = "Tahoma"
176:                 .FontSize  = 18
177:                 .WordWrap  = .T.
178:                 .Alignment = 0
179:                 .BackStyle = 0
180:                 .Caption   = THIS.this_cCaption
181:                 .ForeColor = RGB(0,0,0)
182:             ENDWITH
183: 
184:             .AddObject("lbl_4c_Titulo", "Label")
185:             WITH .lbl_4c_Titulo
186:                 .Top       = 17
187:                 .Left      = 10
188:                 .Width     = THIS.Width
189:                 .Height    = 46
190:                 .AutoSize  = .F.
191:                 .FontBold  = .T.
192:                 .FontName  = "Tahoma"
193:                 .FontSize  = 18
194:                 .WordWrap  = .T.
195:                 .Alignment = 0
196:                 .BackStyle = 0
197:                 .Caption   = THIS.this_cCaption
198:                 .ForeColor = RGB(255,255,255)
199:             ENDWITH
200: 
201:             .Visible = .T.
202:         ENDWITH

*-- Linhas 209 a 247:
209:     *--------------------------------------------------------------------------
210:     PROTECTED PROCEDURE ConfigurarFiltros()
211:         *-- Label "Periodo :"
212:         THIS.AddObject("lbl_4c_Periodo", "Label")
213:         WITH THIS.lbl_4c_Periodo
214:             .Top      = 116
215:             .Left     = 41
216:             .Width    = 50
217:             .Height   = 15
218:             .AutoSize = .F.
219:             .Caption  = "Per" + CHR(237) + "odo :"
220:             .FontName = "Tahoma"
221:             .FontSize = 8
222:         ENDWITH
223: 
224:         *-- Data Inicial (getDtinicial)
225:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
226:         WITH THIS.txt_4c_DtInicial
227:             .Top       = 111
228:             .Left      = 98
229:             .Width     = 79
230:             .Height    = 25
231:             .Format    = "K"
232:             .Value     = {}
233:             .FontName  = "Tahoma"
234:             .FontSize  = 8
235:             .TabIndex  = 1
236:         ENDWITH
237: 
238:         *-- Data Final (getDtfinal)
239:         THIS.AddObject("txt_4c_DtFinal", "TextBox")
240:         WITH THIS.txt_4c_DtFinal
241:             .Top      = 111
242:             .Left     = 180
243:             .Width    = 79
244:             .Height   = 25
245:             .Format   = "K"
246:             .Value    = {}
247:             .FontName = "Tahoma"

*-- Linhas 257 a 299:
257:     PROTECTED PROCEDURE ConfigurarBotoes()
258:         THIS.AddObject("cmg_4c_Processar", "CommandGroup")
259:         WITH THIS.cmg_4c_Processar
260:             .Top         = -2
261:             .Left        = 643
262:             .Width       = 160
263:             .Height      = 85
264:             .ButtonCount = 2
265:             .BackStyle   = 0
266:             .BorderStyle = 0
267:             .SpecialEffect = 1
268: 
269:             WITH .Buttons(1)
270:                 .Top         = 5
271:                 .Left        = 5
272:                 .Width       = 75
273:                 .Height      = 75
274:                 .Caption     = "Processar"
275:                 .Picture     = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
276:                 .FontBold    = .T.
277:                 .FontItalic  = .T.
278:                 .WordWrap    = .T.
279:                 .ForeColor   = RGB(90,90,90)
280:                 .BackColor   = RGB(255,255,255)
281:                 .Themes      = .F.
282:                 .PicturePosition = 13
283:             ENDWITH
284: 
285:             WITH .Buttons(2)
286:                 .Top         = 5
287:                 .Left        = 80
288:                 .Width       = 75
289:                 .Height      = 75
290:                 .Caption     = "Encerrar"
291:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
292:                 .Cancel      = .T.
293:                 .FontBold    = .T.
294:                 .FontItalic  = .T.
295:                 .FontName    = "Comic Sans MS"
296:                 .FontSize    = 8
297:                 .WordWrap    = .T.
298:                 .ForeColor   = RGB(90,90,90)
299:                 .BackColor   = RGB(255,255,255)

*-- Linhas 313 a 358:
313:     PROTECTED PROCEDURE ConfigurarAguarde()
314:         THIS.AddObject("cnt_4c_Aguarde", "Container")
315:         WITH THIS.cnt_4c_Aguarde
316:             .Top        = 99
317:             .Left       = 312
318:             .Width      = 207
319:             .Height     = 49
320:             .BackStyle  = 1
321:             .BackColor  = RGB(255,255,255)
322:             .BorderWidth = 0
323:             .SpecialEffect = 0
324:             .Visible    = .F.
325: 
326:             .AddObject("lbl_4c_Aguarde", "Label")
327:             WITH .lbl_4c_Aguarde
328:                 .Top       = 7
329:                 .Left      = 69
330:                 .Width     = 78
331:                 .Height    = 18
332:                 .AutoSize  = .F.
333:                 .FontBold  = .T.
334:                 .FontName  = "Verdana"
335:                 .FontSize  = 10
336:                 .BackStyle = 0
337:                 .Caption   = "Aguarde..."
338:                 .ForeColor = RGB(255,0,0)
339:                 .Visible   = .T.
340:             ENDWITH
341: 
342:             .AddObject("lbl_4c_Processando", "Label")
343:             WITH .lbl_4c_Processando
344:                 .Top       = 24
345:                 .Left      = 34
346:                 .Width     = 141
347:                 .Height    = 18
348:                 .AutoSize  = .F.
349:                 .FontBold  = .T.
350:                 .FontName  = "Tahoma"
351:                 .FontSize  = 10
352:                 .BackStyle = 0
353:                 .Caption   = "Processando Dados..."
354:                 .ForeColor = RGB(90,90,90)
355:                 .Visible   = .T.
356:             ENDWITH
357:         ENDWITH
358:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrGf1BO.prg):
*==============================================================================
* SigPrGf1BO.prg - Business Object para Falha x Recuperacao por Mes
* Herda de: BusinessBase
* Form OPERACIONAL: selecao de periodo + processamento de SigCdFea
*==============================================================================
DEFINE CLASS SigPrGf1BO AS BusinessBase

    *-- Identificacao
    this_cTabela          = "SigCdFea"
    this_cCampoChave      = ""

    *-- Periodo de filtro
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *-- Empresa
    this_cEmpresa         = ""
    this_cNomeEmpresa     = ""

    *-- Titulos gerados pelo processamento
    this_cTitulo1         = ""
    this_cTitulo2         = ""

    *-- Nome do cursor de resultado produzido por ProcessarDados()
    this_cCursorResultado = "crRel1"

    *-- Mensagem de retorno para o form (equivalente a pcMsg legado)
    this_cMensagem        = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdFea"
        THIS.this_cCampoChave = ""
        THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - Valida datas de filtro (equivalente a mChkValid do legado)
    * Retorna .T. se valido; seta this_cMensagem e retorna .F. se invalido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarPeriodo()
        LOCAL loc_nDifMeses

        THIS.this_cMensagem = ""

        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagem = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagem = "Data Inicial Maior Que a Data Final!!!"
            RETURN .F.
        ENDIF

        IF YEAR(THIS.this_dDtInicial) = YEAR(THIS.this_dDtFinal)
            loc_nDifMeses = MONTH(THIS.this_dDtInicial) - MONTH(THIS.this_dDtFinal) + 1
        ELSE
            loc_nDifMeses = (12 - MONTH(THIS.this_dDtInicial)) + MONTH(THIS.this_dDtFinal) + 1
        ENDIF

        IF loc_nDifMeses > 12
            THIS.this_cMensagem = "Per" + CHR(237) + "odo Ultrapassa Doze Meses!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDados - Gera cursor crRel1 com dados agregados de SigCdFea
    * Equivalente a mProcessamento do legado
    * Retorna .T. se encontrou registros, .F. caso contrario ou em erro
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDados()
        LOCAL loc_lSucesso, loc_lContinuar
        LOCAL loc_cSQL, loc_cNomeEmpresa
        LOCAL loc_cDtIni, loc_cDtFim
        LOCAL loc_cStrgMes, loc_cTitulo1, loc_cTitulo2, loc_cEmpresa
        LOCAL loc_nSaveDecimals, loc_cSaveFixed, loc_cSaveExact

        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        THIS.this_cMensagem = ""

        TRY
            *-- Buscar nome da empresa no SQL Server
            loc_cNomeEmpresa = ""
            IF SQLEXEC(gnConnHandle, ;
                "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmpresa), ;
                "crSigCdEmpGf1") > 0
                IF !EOF("crSigCdEmpGf1")
                    SELECT crSigCdEmpGf1
                    loc_cNomeEmpresa = ALLTRIM(NVL(crSigCdEmpGf1.Razas, ""))
                ENDIF
                USE IN crSigCdEmpGf1
            ENDIF
            THIS.this_cNomeEmpresa = loc_cNomeEmpresa

            *-- Formatar datas para SQL Server
            loc_cDtIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFim = "'" + DTOC(THIS.this_dDtFinal, 1) + " 23:59:59'"

            *-- SQL de busca no SQL Server
            loc_cSQL = "SELECT a.Emps, a.Datas, b.Cemps, b.Razas, a.Falhas, a.Pesoccbs" + ;
                       " FROM SigCdFea a" + ;
                       " LEFT JOIN SigCdEmp b ON b.Cemps = a.Emps" + ;
                       " WHERE a.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ;
                       " AND a.Emps = " + EscaparSQL(THIS.this_cEmpresa)

            IF USED("crTmpRelGf1")
                USE IN crTmpRelGf1
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpRelGf1") < 1
                THIS.this_cMensagem = "Falha na conex" + CHR(227) + "o ao buscar dados de SigCdFea."
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EOF("crTmpRelGf1")
                THIS.this_cMensagem = "Nenhum Registro Encontrado."
                USE IN crTmpRelGf1
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Variaveis para o SELECT VFP local (usar m. prefix nas refs abaixo)
                loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)

                *-- String de nomes de meses, 9 chars por mes (12 * 9 = 108 chars)
                loc_cStrgMes  = "Janeiro  " + "Fevereiro" + "Mar" + CHR(231) + "o    " + ;
                                "Abril    " + "Maio     " + "Junho    " + ;
                                "Julho    " + "Agosto   " + "Setembro " + ;
                                "Outubro  " + "Novembro " + "Dezembro "

                loc_cTitulo1  = "Falha X Recupera" + CHR(231) + CHR(227) + ;
                                "o por M" + CHR(234) + "s da Empresa "

                IF EMPTY(THIS.this_dDtInicial) AND EMPTY(THIS.this_dDtFinal)
                    loc_cTitulo2 = ""
                ELSE
                    IF THIS.this_dDtInicial = THIS.this_dDtFinal
                        loc_cTitulo2 = " [Em " + DTOC(THIS.this_dDtInicial) + "]"
                    ELSE
                        IF EMPTY(THIS.this_dDtInicial)
                            loc_cTitulo2 = " [At" + CHR(233) + " " + DTOC(THIS.this_dDtFinal) + "]"
                        ELSE
                            loc_cTitulo2 = " [De " + DTOC(THIS.this_dDtInicial) + ;
                                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + "]"
                        ENDIF
                    ENDIF
                ENDIF

                THIS.this_cTitulo1 = loc_cTitulo1
                THIS.this_cTitulo2 = loc_cTitulo2

                IF USED("crRel1")
                    USE IN crRel1
                ENDIF

                *-- Salvar configuracoes SET para restaurar apos SELECT
                loc_nSaveDecimals = SET("DECIMALS")
                loc_cSaveFixed    = SET("FIXED")
                loc_cSaveExact    = SET("EXACT")

                SET DECIMALS TO 6
                SET FIXED ON
                SET EXACT ON

                *-- SELECT VFP local: agrega dados de SigCdFea por empresa/mes
                SELECT Emps AS Cemps, ;
                       PADR(DTOS(Datas), 6) AS cAnomess, ;
                       PADR(PADR(SUBSTR(m.loc_cStrgMes, (MONTH(Datas) * 9 - 8), 9), 3) + "./" + ;
                            TRANSFORM(YEAR(Datas), "@L 9999"), 9) AS csTraNomes, ;
                       PADR(m.loc_cTitulo1 + ALLTRIM(NVL(Cemps, "")) + ;
                            " - " + ALLTRIM(NVL(Razas, "")), 100) AS cTitulo1s, ;
                       m.loc_cTitulo2 AS ctitulo2s, ;
                       PADR(ALLTRIM(m.loc_cEmpresa) + " - " + ;
                            ALLTRIM(m.loc_cNomeEmpresa), 100) AS cEmpresas, ;
                       VAL(STR(SUM(Falhas), 16, 2)) AS nFalhas, ;
                       VAL(STR(SUM(Pesoccbs), 16, 2)) AS nPesoccbs ;
                  FROM crTmpRelGf1 ;
                 GROUP BY 1, 2, 3, 4, 5, 6 ;
                  INTO CURSOR crRel1 READWRITE

                SELECT crRel1
                GO TOP

                *-- Restaurar configuracoes SET
                SET DECIMALS TO (loc_nSaveDecimals)
                IF loc_cSaveFixed = "ON"
                    SET FIXED ON
                ELSE
                    SET FIXED OFF
                ENDIF
                IF loc_cSaveExact = "ON"
                    SET EXACT ON
                ELSE
                    SET EXACT OFF
                ENDIF

                USE IN crTmpRelGf1

                loc_lSucesso = !EOF("crRel1")
                IF !loc_lSucesso
                    THIS.this_cMensagem = "Nenhum Registro Encontrado."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em ProcessarDados")
            THIS.this_cMensagem = "Erro no processamento: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades BO a partir do cursor de resultado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmpresa     = NVL(Cemps, "")
            THIS.this_cTitulo1     = NVL(cTitulo1s, "")
            THIS.this_cTitulo2     = NVL(ctitulo2s, "")
            THIS.this_cNomeEmpresa = NVL(cEmpresas, "")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave primaria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL nao insere linhas em SigCdFea diretamente
    * SigCdFea eh populada por outros processos do sistema (movimentacao de
    * producao). Este BO apenas LE e agrega dados para o relatorio de
    * "Falha X Recuperacao por Mes". Bloquear insercao evita gravacao acidental.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        THIS.this_cMensagem = "Form operacional: inser" + CHR(231) + CHR(227) + ;
                              "o direta em SigCdFea n" + CHR(227) + "o " + ;
                              "suportada. Utilize os m" + CHR(243) + "dulos de " + ;
                              "movimenta" + CHR(231) + CHR(227) + "o de produ" + ;
                              CHR(231) + CHR(227) + "o."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Form OPERACIONAL nao atualiza linhas de SigCdFea
    * Bloqueia UPDATE por design: este BO consome dados agregados, nao mantem
    * cadastro. Alteracoes em SigCdFea ocorrem via processos de producao.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        THIS.this_cMensagem = "Form operacional: atualiza" + CHR(231) + CHR(227) + ;
                              "o direta em SigCdFea n" + CHR(227) + "o " + ;
                              "suportada. Utilize os m" + CHR(243) + "dulos de " + ;
                              "movimenta" + CHR(231) + CHR(227) + "o de produ" + ;
                              CHR(231) + CHR(227) + "o."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Form OPERACIONAL nao exclui linhas de SigCdFea
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        THIS.this_cMensagem = "Form operacional: exclus" + CHR(227) + "o direta " + ;
                              "em SigCdFea n" + CHR(227) + "o suportada."
        RETURN .F.
    ENDFUNC

ENDDEFINE

