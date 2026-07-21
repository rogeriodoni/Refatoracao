# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 250: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrPpc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1045 linhas total):

*-- Linhas 98 a 144:
98:     PROTECTED PROCEDURE ConfigurarPageFrame()
99:         THIS.AddObject("cnt_4c_Sombra", "Container")
100:         WITH THIS.cnt_4c_Sombra
101:             .Top         = 0
102:             .Left        = 0
103:             .Width       = THIS.Width
104:             .Height      = 80
105:             .BorderWidth = 0
106:             .BackStyle   = 1
107:             .BackColor   = RGB(100, 100, 100)
108:             .Visible     = .T.
109: 
110:             .AddObject("lbl_4c_LblSombra", "Label")
111:         ENDWITH
112:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
113:             .Top       = 25
114:             .Left      = 10
115:             .Width     = THIS.cnt_4c_Sombra.Width - 20
116:             .Height    = 40
117:             .AutoSize  = .F.
118:             .BackStyle = 0
119:             .FontName  = "Tahoma"
120:             .FontSize  = 18
121:             .FontBold  = .T.
122:             .ForeColor = RGB(0, 0, 0)
123:             .Caption   = "Produtos Por Conta"
124:             .WordWrap  = .T.
125:         ENDWITH
126: 
127:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
128:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
129:             .Top       = 24
130:             .Left      = 10
131:             .Width     = THIS.cnt_4c_Sombra.Width - 20
132:             .Height    = 46
133:             .AutoSize  = .F.
134:             .BackStyle = 0
135:             .FontName  = "Tahoma"
136:             .FontSize  = 18
137:             .FontBold  = .T.
138:             .ForeColor = RGB(255, 255, 255)
139:             .Caption   = "Produtos Por Conta"
140:             .WordWrap  = .T.
141:         ENDWITH
142:     ENDPROC
143: 
144:     *==========================================================================

*-- Linhas 213 a 421:
213:         THIS.AddObject("cmg_4c_Operacao", "CommandGroup")
214:         loc_oCmg = THIS.cmg_4c_Operacao
215:         WITH loc_oCmg
216:             .Top           = -2
217:             .Left          = 502
218:             .Width         = 161
219:             .Height        = 85
220:             .ButtonCount   = 2
221:             .BackStyle     = 0
222:             .BorderStyle   = 0
223:             .SpecialEffect = 1
224:             .Themes        = .F.
225:             .Value         = 1
226:             WITH .Buttons(1)
227:                 .Top             = 5
228:                 .Left            = 5
229:                 .Width           = 75
230:                 .Height          = 75
231:                 .Caption         = "\<Consultar"
232:                 .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
233:                 .FontName        = "Comic Sans MS"
234:                 .FontSize        = 8
235:                 .FontBold        = .T.
236:                 .FontItalic      = .T.
237:                 .ForeColor       = RGB(90, 90, 90)
238:                 .BackColor       = RGB(255, 255, 255)
239:                 .Themes          = .F.
240:                 .WordWrap        = .T.
241:                 .PicturePosition = 13
242:             ENDWITH
243:             WITH .Buttons(2)
244:                 .Top             = 5
245:                 .Left            = 81
246:                 .Width           = 75
247:                 .Height          = 75
248:                 .Caption         = "Encerrar"
249:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
250:                 .FontName        = "Comic Sans MS"
251:                 .FontSize        = 8
252:                 .FontBold        = .T.
253:                 .FontItalic      = .T.
254:                 .ForeColor       = RGB(90, 90, 90)
255:                 .BackColor       = RGB(255, 255, 255)
256:                 .Cancel          = .T.
257:                 .Themes          = .F.
258:                 .WordWrap        = .T.
259:                 .PicturePosition = 13
260:             ENDWITH
261:         ENDWITH
262: 
263:         *-- LINHA GRUPO (legado: Say4 / Get_grupo / Get_DGrupo)
264:         THIS.AddObject("lbl_4c_LblGrupo", "Label")
265:         WITH THIS.lbl_4c_LblGrupo
266:             .Top      = 123
267:             .Left     = 138
268:             .Caption  = "Grupo :"
269:             .FontName = "Tahoma"
270:             .FontSize = 8
271:             .BackStyle = 0
272:         ENDWITH
273: 
274:         THIS.AddObject("txt_4c_Grupo", "TextBox")
275:         WITH THIS.txt_4c_Grupo
276:             .Top      = 120
277:             .Left     = 180
278:             .Width    = 80
279:             .Height   = 23
280:             .FontName = "Tahoma"
281:             .FontSize = 8
282:             .ForeColor = RGB(0, 0, 0)
283:         ENDWITH
284: 
285:         THIS.AddObject("txt_4c_DGrupo", "TextBox")
286:         WITH THIS.txt_4c_DGrupo
287:             .Top       = 120
288:             .Left      = 261
289:             .Width     = 150
290:             .Height    = 23
291:             .MaxLength = 20
292:             .FontName  = "Tahoma"
293:             .FontSize  = 8
294:             .ForeColor = RGB(0, 0, 0)
295:         ENDWITH
296: 
297:         *-- LINHA CONTA (legado: lbl_cliente / get_cliente / get_cliente_desc)
298:         THIS.AddObject("lbl_4c_LblConta", "Label")
299:         WITH THIS.lbl_4c_LblConta
300:             .Top      = 150
301:             .Left     = 138
302:             .Caption  = "Conta :"
303:             .FontName = "Tahoma"
304:             .FontSize = 8
305:             .BackStyle = 0
306:         ENDWITH
307: 
308:         THIS.AddObject("txt_4c_Conta", "TextBox")
309:         WITH THIS.txt_4c_Conta
310:             .Top      = 145
311:             .Left     = 180
312:             .Width    = 80
313:             .FontName = "Tahoma"
314:             .FontSize = 8
315:             .ForeColor = RGB(0, 0, 0)
316:         ENDWITH
317: 
318:         THIS.AddObject("txt_4c_ContaDesc", "TextBox")
319:         WITH THIS.txt_4c_ContaDesc
320:             .Top      = 145
321:             .Left     = 261
322:             .Width    = 290
323:             .FontName = "Tahoma"
324:             .FontSize = 8
325:             .ForeColor = RGB(0, 0, 0)
326:         ENDWITH
327: 
328:         *-- LINHA OPERACAO (legado: lbl_operacao / get_operacao)
329:         THIS.AddObject("lbl_4c_LblOperacao", "Label")
330:         WITH THIS.lbl_4c_LblOperacao
331:             .Top      = 175
332:             .Left     = 120
333:             .Caption  = "Opera" + CHR(231) + CHR(227) + "o :"
334:             .FontName = "Tahoma"
335:             .FontSize = 8
336:             .BackStyle = 0
337:         ENDWITH
338: 
339:         THIS.AddObject("txt_4c_Operacao", "TextBox")
340:         WITH THIS.txt_4c_Operacao
341:             .Top      = 170
342:             .Left     = 180
343:             .Width    = 150
344:             .FontName = "Tahoma"
345:             .FontSize = 8
346:             .ForeColor = RGB(0, 0, 0)
347:         ENDWITH
348: 
349:         *-- LINHA PERIODO (legado: lbl_periodo / get_dt_inicial / lbl_periodo_a / get_dt_final)
350:         THIS.AddObject("lbl_4c_LblPeriodo", "Label")
351:         WITH THIS.lbl_4c_LblPeriodo
352:             .Top      = 200
353:             .Left     = 131
354:             .Caption  = "Periodo :"
355:             .FontName = "Tahoma"
356:             .FontSize = 8
357:             .BackStyle = 0
358:         ENDWITH
359: 
360:         THIS.AddObject("txt_4c_DtIni", "TextBox")
361:         WITH THIS.txt_4c_DtIni
362:             .Top       = 195
363:             .Left      = 180
364:             .Width     = 80
365:             .FontName  = "Tahoma"
366:             .FontSize  = 8
367:             .ForeColor = RGB(0, 0, 0)
368:         ENDWITH
369: 
370:         THIS.AddObject("lbl_4c_LblA", "Label")
371:         WITH THIS.lbl_4c_LblA
372:             .Top      = 200
373:             .Left     = 263
374:             .Caption  = "a"
375:             .FontName = "Tahoma"
376:             .FontSize = 8
377:             .BackStyle = 0
378:         ENDWITH
379: 
380:         THIS.AddObject("txt_4c_DtFin", "TextBox")
381:         WITH THIS.txt_4c_DtFin
382:             .Top       = 195
383:             .Left      = 273
384:             .Width     = 80
385:             .FontName  = "Tahoma"
386:             .FontSize  = 8
387:             .ForeColor = RGB(0, 0, 0)
388:         ENDWITH
389: 
390:         *-- LINHA EMPRESA (legado: lbl_empresa / get_empresa / get_empresa_desc)
391:         THIS.AddObject("lbl_4c_LblEmpresa", "Label")
392:         WITH THIS.lbl_4c_LblEmpresa
393:             .Top      = 225
394:             .Left     = 126
395:             .Caption  = "Empresa :"
396:             .FontName = "Tahoma"
397:             .FontSize = 8
398:             .BackStyle = 0
399:         ENDWITH
400: 
401:         THIS.AddObject("txt_4c_Empresa", "TextBox")
402:         WITH THIS.txt_4c_Empresa
403:             .Top       = 220
404:             .Left      = 180
405:             .Width     = 36
406:             .Height    = 23
407:             .MaxLength = 3
408:             .FontName  = "Tahoma"
409:             .FontSize  = 8
410:             .ForeColor = RGB(0, 0, 0)
411:         ENDWITH
412: 
413:         THIS.AddObject("txt_4c_EmpresaDesc", "TextBox")
414:         WITH THIS.txt_4c_EmpresaDesc
415:             .Top      = 220
416:             .Left     = 217
417:             .Width    = 250
418:             .FontName = "Tahoma"
419:             .FontSize = 8
420:             .ForeColor = RGB(0, 0, 0)
421:         ENDWITH


### BO (C:\4c\projeto\app\classes\SigPrPpcBO.prg):
*==============================================================================
* SigPrPpcBO.prg - Business Object - Produtos Por Conta
* Form OPERACIONAL: coleta filtros e consulta SigMvCab
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS SigPrPpcBO AS BusinessBase

    *-- Filtros de consulta - Grupo contabil (SigCdGcr)
    this_cGrupo       = ""
    this_cDGrupo      = ""

    *-- Filtros de consulta - Conta/Cliente (SigCdCli)
    this_cConta       = ""
    this_cContaDesc   = ""

    *-- Filtros de consulta - Operacao (SigCdOpe)
    this_cOperacao    = ""

    *-- Filtros de consulta - Periodo
    this_dInicial     = {}
    this_dFinal       = {}

    *-- Filtros de consulta - Empresa (SigCdEmp)
    this_cEmpresa     = ""
    this_cEmpresaDesc = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "Numes"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form OPERACIONAL nao tem chave primaria singular
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_cEmpresa) + TRANSFORM(THIS.this_cOperacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Verifica se grupo existe em SigCdGcr; popula this_cDGrupo
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarGrupo(par_cGrupo)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                       EscaparSQL(ALLTRIM(par_cGrupo))
            IF USED("cursor_4c_GcrVal")
                USE IN cursor_4c_GcrVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
            IF loc_nResult > 0 AND USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
                SELECT cursor_4c_GcrVal
                THIS.this_cDGrupo = ALLTRIM(descrs)
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_GcrVal")
                USE IN cursor_4c_GcrVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarConta - Verifica se conta/cliente existe em SigCdCli; popula this_cContaDesc
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarConta(par_cConta)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                       EscaparSQL(ALLTRIM(par_cConta))
            IF USED("cursor_4c_CliVal")
                USE IN cursor_4c_CliVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliVal")
            IF loc_nResult > 0 AND USED("cursor_4c_CliVal") AND RECCOUNT("cursor_4c_CliVal") > 0
                SELECT cursor_4c_CliVal
                THIS.this_cContaDesc = ALLTRIM(RClis)
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_CliVal")
                USE IN cursor_4c_CliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarOperacao - Verifica se operacao existe em SigCdOpe
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarOperacao(par_cOperacao)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao))
            IF USED("cursor_4c_OpeVal")
                USE IN cursor_4c_OpeVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
            IF loc_nResult > 0 AND USED("cursor_4c_OpeVal") AND RECCOUNT("cursor_4c_OpeVal") > 0
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_OpeVal")
                USE IN cursor_4c_OpeVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Verifica se empresa existe em SigCdEmp; popula this_cEmpresaDesc
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarEmpresa(par_cEmpresa)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa))
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND RECCOUNT("cursor_4c_EmpVal") > 0
                SELECT cursor_4c_EmpVal
                THIS.this_cEmpresaDesc = ALLTRIM(Razas)
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida todos os filtros obrigatorios
    * Retorna "" se tudo valido, ou mensagem de erro descritiva
    *--------------------------------------------------------------------------
    FUNCTION ValidarFiltros()
        LOCAL loc_cErro
        loc_cErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cGrupo))
            RETURN "Grupo inv" + CHR(225) + "lido. Informe um grupo cont" + CHR(225) + "bil."
        ENDIF

        IF !THIS.ValidarGrupo(THIS.this_cGrupo)
            RETURN "Grupo " + CHR(34) + ALLTRIM(THIS.this_cGrupo) + CHR(34) + ;
                   " n" + CHR(227) + "o encontrado em SigCdGcr."
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cConta))
            RETURN "Conta inv" + CHR(225) + "lida. Informe uma conta."
        ENDIF

        IF !THIS.ValidarConta(THIS.this_cConta)
            RETURN "Conta " + CHR(34) + ALLTRIM(THIS.this_cConta) + CHR(34) + ;
                   " n" + CHR(227) + "o encontrada em SigCdCli."
        ENDIF

        IF EMPTY(THIS.this_dInicial)
            RETURN "Data inicial inv" + CHR(225) + "lida."
        ENDIF

        IF EMPTY(THIS.this_dFinal)
            RETURN "Data final inv" + CHR(225) + "lida."
        ENDIF

        IF THIS.this_dInicial > THIS.this_dFinal
            RETURN "Data inicial maior do que a data final."
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
            IF !THIS.ValidarOperacao(THIS.this_cOperacao)
                RETURN "Opera" + CHR(231) + CHR(227) + "o " + CHR(34) + ;
                       ALLTRIM(THIS.this_cOperacao) + CHR(34) + " n" + CHR(227) + "o encontrada."
            ENDIF
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
            IF !THIS.ValidarEmpresa(THIS.this_cEmpresa)
                RETURN "Empresa " + CHR(34) + ALLTRIM(THIS.this_cEmpresa) + CHR(34) + ;
                       " n" + CHR(227) + "o encontrada em SigCdEmp."
            ENDIF
        ENDIF

        RETURN loc_cErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarMovimentacoes - Executa consulta em SigMvCab com os filtros
    * Popula cursor TprMvCab (nome mantido para compatibilidade com SigPrPpp)
    * Retorna qtd de registros encontrados, ou -1 em erro de SQL
    *--------------------------------------------------------------------------
    FUNCTION ConsultarMovimentacoes()
        LOCAL loc_nResultado, loc_cWhere, loc_cSQL, loc_oErro
        LOCAL loc_cDtIniBase, loc_cDtFimBase, loc_cDtIniStr, loc_cDtFimStr
        loc_nResultado = -1
        TRY
            *-- Formata datas: inicio 00:00:00, fim 23:59:59
            loc_cDtIniBase = DTOS(THIS.this_dInicial)
            loc_cDtFimBase = DTOS(THIS.this_dFinal)
            loc_cDtIniStr  = "'" + SUBSTR(loc_cDtIniBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtIniBase,5,2) + "-" + SUBSTR(loc_cDtIniBase,7,2) + "'"
            loc_cDtFimStr  = "'" + SUBSTR(loc_cDtFimBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtFimBase,5,2) + "-" + SUBSTR(loc_cDtFimBase,7,2) + ;
                              " 23:59:59'"

            *-- Monta clausula WHERE adicional com filtros opcionais
            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                loc_cWhere = loc_cWhere + ;
                    " AND GrupoDs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cWhere = loc_cWhere + ;
                    " AND ContaDs = " + EscaparSQL(ALLTRIM(THIS.this_cConta))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
                loc_cWhere = loc_cWhere + " AND Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cOperacao))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
                loc_cWhere = loc_cWhere + " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            ENDIF

            loc_cSQL = "SELECT * FROM SigMvCab" + ;
                       " WHERE Datas BETWEEN " + loc_cDtIniStr + " AND " + loc_cDtFimStr + ;
                       loc_cWhere + ;
                       " ORDER BY Emps, Dopes, Numes"

            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TprMvCab")

            IF loc_nResultado <= 0
                loc_nResultado = 0
            ELSE
                loc_nResultado = RECCOUNT("TprMvCab")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY
        RETURN loc_nResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor de filtros para as props do BO
    * Cursor esperado: crSigTempC (SigTempC) ou similar com colunas de filtro
    * Campos opcionais - so mapeia os que existirem no cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF TYPE(par_cAliasCursor + ".cliente") != "U"
                    THIS.this_cConta = TratarNulo(cliente, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dcliente") != "U"
                    THIS.this_cContaDesc = TratarNulo(dcliente, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".operacao") != "U"
                    THIS.this_cOperacao = TratarNulo(operacao, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".datai") != "U"
                    THIS.this_dInicial = TratarNulo(datai, "D")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dataf") != "U"
                    THIS.this_dFinal = TratarNulo(dataf, "D")
                ENDIF
                IF TYPE(par_cAliasCursor + ".empresa") != "U"
                    THIS.this_cEmpresa = TratarNulo(empresa, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dempresa") != "U"
                    THIS.this_cEmpresaDesc = TratarNulo(dempresa, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".grupo") != "U"
                    THIS.this_cGrupo = TratarNulo(grupo, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dgrupo") != "U"
                    THIS.this_cDGrupo = TratarNulo(dgrupo, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL: executa consulta em SigMvCab com os filtros
    * Nao ha persistencia de registros - a "acao" do form eh consultar
    * movimentacoes que atendem os filtros. Popula cursor TprMvCab (padrao legado).
    * RegistrarAuditoria registra a operacao CONSULTA no LogAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nQtd, loc_cErroFiltros, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cErroFiltros = THIS.ValidarFiltros()
            IF !EMPTY(loc_cErroFiltros)
                THIS.this_cMensagemErro = loc_cErroFiltros
                loc_lSucesso = .F.
            ENDIF

            loc_nQtd = THIS.ConsultarMovimentacoes()

            DO CASE
            CASE loc_nQtd < 0
                THIS.this_cMensagemErro = "Falha ao consultar movimenta" + CHR(231) + CHR(245) + "es."
            CASE loc_nQtd = 0
                THIS.this_cMensagemErro = "Nenhuma movimenta" + CHR(231) + CHR(227) + "o foi encontrada."
            OTHERWISE
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("CONSULTA")
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Form OPERACIONAL nao persiste registros
    * Delega para Inserir() (executa nova consulta) mantendo contrato BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Inserir()
    ENDPROC

ENDDEFINE

