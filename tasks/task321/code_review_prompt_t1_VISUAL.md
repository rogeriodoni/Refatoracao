# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 166: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (830 linhas total):

*-- Linhas 93 a 137:
93:     PROTECTED PROCEDURE ConfigurarPageFrame()
94:         THIS.AddObject("cnt_4c_Sombra", "Container")
95:         WITH THIS.cnt_4c_Sombra
96:             .Top         = 0
97:             .Left        = 0
98:             .Width       = THIS.Width
99:             .Height      = 80
100:             .BorderWidth = 0
101:             .BackStyle   = 1
102:             .BackColor   = RGB(100, 100, 100)
103:             .Visible     = .T.
104:             .AddObject("lbl_4c_LblSombra", "Label")
105:         ENDWITH
106:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
107:             .Top       = 25
108:             .Left      = 10
109:             .Width     = 769
110:             .Height    = 40
111:             .AutoSize  = .F.
112:             .BackStyle = 0
113:             .FontName  = "Tahoma"
114:             .FontSize  = 18
115:             .FontBold  = .T.
116:             .ForeColor = RGB(0, 0, 0)
117:             .Caption   = THIS.Caption
118:             .WordWrap  = .T.
119:         ENDWITH
120:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
121:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
122:             .Top       = 24
123:             .Left      = 10
124:             .Width     = 769
125:             .Height    = 46
126:             .AutoSize  = .F.
127:             .BackStyle = 0
128:             .FontName  = "Tahoma"
129:             .FontSize  = 18
130:             .FontBold  = .T.
131:             .ForeColor = RGB(255, 255, 255)
132:             .Caption   = THIS.Caption
133:             .WordWrap  = .T.
134:         ENDWITH
135:     ENDPROC
136: 
137:     *==========================================================================

*-- Linhas 146 a 172:
146:         THIS.AddObject("cmg_4c_Encerrar", "CommandGroup")
147:         loc_oCmg = THIS.cmg_4c_Encerrar
148:         WITH loc_oCmg
149:             .Top           = -2
150:             .Left          = 717
151:             .Width         = 85
152:             .Height        = 85
153:             .ButtonCount   = 1
154:             .BackStyle     = 0
155:             .BorderStyle   = 0
156:             .SpecialEffect = 1
157:             .Themes        = .F.
158:             .Value         = 0
159:             WITH .Buttons(1)
160:                 .Top             = 5
161:                 .Left            = 5
162:                 .Width           = 75
163:                 .Height          = 75
164:                 .Caption         = "Encerrar"
165:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
166:                 .FontName        = "Comic Sans MS"
167:                 .FontSize        = 8
168:                 .FontBold        = .T.
169:                 .FontItalic      = .T.
170:                 .ForeColor       = RGB(90, 90, 90)
171:                 .BackColor       = RGB(255, 255, 255)
172:                 .Cancel          = .T.

*-- Linhas 180 a 325:
180:         *-- Shape cliente/periodo
181:         THIS.AddObject("shp_4c_Shp_cliente_periodo", "Shape")
182:         WITH THIS.shp_4c_Shp_cliente_periodo
183:             .Top           = 108
184:             .Left          = 132
185:             .Height        = 90
186:             .Width         = 484
187:             .BackStyle     = 0
188:             .SpecialEffect = 1
189:         ENDWITH
190: 
191:         *-- Linha PERIODO
192:         THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
193:         WITH THIS.lbl_4c_Lbl_periodo
194:             .Top      = 121
195:             .Left     = 143
196:             .Caption  = "Per" + CHR(237) + "odo :"
197:             .FontName = "Tahoma"
198:             .FontSize = 8
199:             .BackStyle = 0
200:         ENDWITH
201: 
202:         THIS.AddObject("txt_4c_DtIni", "TextBox")
203:         WITH THIS.txt_4c_DtIni
204:             .Top       = 116
205:             .Left      = 197
206:             .Width     = 80
207:             .Height    = 23
208:             .FontName  = "Tahoma"
209:             .FontSize  = 8
210:             .Enabled   = .F.
211:         ENDWITH
212: 
213:         THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
214:         WITH THIS.lbl_4c_Lbl_periodo_a
215:             .Top      = 121
216:             .Left     = 280
217:             .Caption  = CHR(224)
218:             .FontName = "Tahoma"
219:             .FontSize = 8
220:             .BackStyle = 0
221:         ENDWITH
222: 
223:         THIS.AddObject("txt_4c_DtFin", "TextBox")
224:         WITH THIS.txt_4c_DtFin
225:             .Top       = 116
226:             .Left      = 290
227:             .Width     = 80
228:             .Height    = 23
229:             .FontName  = "Tahoma"
230:             .FontSize  = 8
231:             .Enabled   = .F.
232:         ENDWITH
233: 
234:         *-- Linha GRUPO (Say4 / Get_grupo)
235:         THIS.AddObject("lbl_4c_Label4", "Label")
236:         WITH THIS.lbl_4c_Label4
237:             .Top      = 147
238:             .Left     = 151
239:             .Caption  = "Grupo :"
240:             .FontName = "Tahoma"
241:             .FontSize = 8
242:             .BackStyle = 0
243:         ENDWITH
244: 
245:         THIS.AddObject("txt_4c_Grupo", "TextBox")
246:         WITH THIS.txt_4c_Grupo
247:             .Top       = 144
248:             .Left      = 197
249:             .Width     = 80
250:             .Height    = 23
251:             .FontName  = "Tahoma"
252:             .FontSize  = 8
253:             .Enabled   = .F.
254:         ENDWITH
255: 
256:         *-- Linha CONTA
257:         THIS.AddObject("lbl_4c_Lbl_cliente", "Label")
258:         WITH THIS.lbl_4c_Lbl_cliente
259:             .Top      = 174
260:             .Left     = 152
261:             .Caption  = "Conta :"
262:             .FontName = "Tahoma"
263:             .FontSize = 8
264:             .BackStyle = 0
265:         ENDWITH
266: 
267:         THIS.AddObject("txt_4c_Conta", "TextBox")
268:         WITH THIS.txt_4c_Conta
269:             .Top       = 169
270:             .Left      = 197
271:             .Width     = 80
272:             .Height    = 23
273:             .FontName  = "Courier New"
274:             .FontSize  = 8
275:             .Enabled   = .F.
276:         ENDWITH
277: 
278:         THIS.AddObject("txt_4c_ContaDesc", "TextBox")
279:         WITH THIS.txt_4c_ContaDesc
280:             .Top       = 169
281:             .Left      = 279
282:             .Width     = 290
283:             .Height    = 23
284:             .FontName  = "Tahoma"
285:             .FontSize  = 8
286:             .Enabled   = .F.
287:         ENDWITH
288: 
289:         *-- Shape Operacoes
290:         THIS.AddObject("shp_4c_Shp_operacao", "Shape")
291:         WITH THIS.shp_4c_Shp_operacao
292:             .Top           = 224
293:             .Left          = 133
294:             .Height        = 112
295:             .Width         = 484
296:             .BackStyle     = 0
297:             .SpecialEffect = 1
298:         ENDWITH
299: 
300:         *-- Label Movimentacoes
301:         THIS.AddObject("lbl_4c_Lbl_operacao", "Label")
302:         WITH THIS.lbl_4c_Lbl_operacao
303:             .Top       = 210
304:             .Left      = 143
305:             .Width     = 92
306:             .Height    = 15
307:             .AutoSize  = .F.
308:             .FontName  = "Tahoma"
309:             .FontSize  = 8
310:             .FontBold  = .T.
311:             .BackStyle = 0
312:             .ForeColor = RGB(90, 90, 90)
313:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
314:         ENDWITH
315: 
316:         *-- Grid Operacoes (5 colunas: Emp / Movimentacao / Numero / Data / Valor)
317:         THIS.AddObject("grd_4c_Operacoes", "Grid")
318:         WITH THIS.grd_4c_Operacoes
319:             .Top         = 234
320:             .Left        = 140
321:             .Width       = 469
322:             .Height      = 94
323:             .ColumnCount = 5
324:             .FontName    = "Arial"
325:             .FontSize    = 8

*-- Linhas 334 a 342:
334:             .Movable   = .F.
335:             .Resizable = .F.
336:             .ReadOnly  = .T.
337:             .Header1.Caption   = "Emp."
338:             .Header1.FontName  = "Verdana"
339:             .Header1.FontSize  = 8
340:             .Header1.Alignment = 2
341:             .Header1.ForeColor = RGB(90, 90, 90)
342:             .Text1.BorderStyle = 0

*-- Linhas 349 a 357:
349:             .Movable   = .F.
350:             .Resizable = .F.
351:             .ReadOnly  = .T.
352:             .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
353:             .Header1.FontName  = "Verdana"
354:             .Header1.FontSize  = 8
355:             .Header1.Alignment = 2
356:             .Header1.ForeColor = RGB(90, 90, 90)
357:             .Text1.BorderStyle = 0

*-- Linhas 364 a 372:
364:             .Movable   = .F.
365:             .Resizable = .F.
366:             .ReadOnly  = .T.
367:             .Header1.Caption   = "N" + CHR(250) + "mero"
368:             .Header1.FontName  = "Verdana"
369:             .Header1.FontSize  = 8
370:             .Header1.Alignment = 2
371:             .Header1.ForeColor = RGB(90, 90, 90)
372:             .Text1.BorderStyle = 0

*-- Linhas 379 a 387:
379:             .Movable   = .F.
380:             .Resizable = .F.
381:             .ReadOnly  = .T.
382:             .Header1.Caption   = "Data"
383:             .Header1.FontName  = "Verdana"
384:             .Header1.FontSize  = 8
385:             .Header1.Alignment = 2
386:             .Header1.ForeColor = RGB(90, 90, 90)
387:             .Text1.BorderStyle = 0

*-- Linhas 395 a 444:
395:             .Resizable = .F.
396:             .ReadOnly  = .T.
397:             .Format    = "999,999,999.99"
398:             .Header1.Caption   = "Valor"
399:             .Header1.FontName  = "Verdana"
400:             .Header1.FontSize  = 8
401:             .Header1.Alignment = 2
402:             .Header1.ForeColor = RGB(90, 90, 90)
403:             .Text1.BorderStyle = 0
404:             .Text1.ForeColor   = RGB(0, 0, 0)
405:             .Text1.BackColor   = RGB(255, 255, 255)
406:         ENDWITH
407: 
408:         *-- Shape Itens
409:         THIS.AddObject("shp_4c_Shp_itens", "Shape")
410:         WITH THIS.shp_4c_Shp_itens
411:             .Top           = 354
412:             .Left          = 133
413:             .Height        = 127
414:             .Width         = 511
415:             .BackStyle     = 0
416:             .SpecialEffect = 1
417:         ENDWITH
418: 
419:         *-- Label Itens
420:         THIS.AddObject("lbl_4c_Lbl_itens", "Label")
421:         WITH THIS.lbl_4c_Lbl_itens
422:             .Top       = 339
423:             .Left      = 143
424:             .Width     = 38
425:             .Height    = 15
426:             .AutoSize  = .F.
427:             .FontName  = "Tahoma"
428:             .FontSize  = 8
429:             .FontBold  = .T.
430:             .BackStyle = 0
431:             .ForeColor = RGB(90, 90, 90)
432:             .Caption   = " " + CHR(205) + "tens "
433:         ENDWITH
434: 
435:         *-- Grid Itens (3 colunas: Produto / Descricao / Qtde)
436:         THIS.AddObject("grd_4c_Itens", "Grid")
437:         WITH THIS.grd_4c_Itens
438:             .Top         = 363
439:             .Left        = 140
440:             .Width       = 497
441:             .Height      = 112
442:             .ColumnCount = 3
443:             .FontName    = "Tahoma"
444:             .FontSize    = 8

*-- Linhas 453 a 461:
453:             .Movable   = .F.
454:             .Resizable = .F.
455:             .ReadOnly  = .T.
456:             .Header1.Caption   = "Produto"
457:             .Header1.FontName  = "Tahoma"
458:             .Header1.FontSize  = 8
459:             .Header1.Alignment = 2
460:             .Header1.ForeColor = RGB(90, 90, 90)
461:             .Text1.BorderStyle = 0

*-- Linhas 468 a 476:
468:             .Movable   = .F.
469:             .Resizable = .F.
470:             .ReadOnly  = .T.
471:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
472:             .Header1.FontName  = "Tahoma"
473:             .Header1.FontSize  = 8
474:             .Header1.Alignment = 2
475:             .Header1.ForeColor = RGB(90, 90, 90)
476:             .Text1.BorderStyle = 0

*-- Linhas 483 a 491:
483:             .Movable   = .F.
484:             .Resizable = .F.
485:             .ReadOnly  = .T.
486:             .Header1.Caption   = "Qtde."
487:             .Header1.FontName  = "Tahoma"
488:             .Header1.FontSize  = 8
489:             .Header1.Alignment = 2
490:             .Header1.ForeColor = RGB(90, 90, 90)
491:             .Text1.BorderStyle = 0

*-- Linhas 542 a 565:
542:                 THIS.grd_4c_Operacoes.column4.ControlSource = "cursor_4c_Operacoes.Datas"
543:                 THIS.grd_4c_Operacoes.column5.ControlSource = "cursor_4c_Operacoes.Valos"
544:                 *-- Restaurar cabecalhos: RecordSource reseta Header1.Caption para "columnN"
545:                 THIS.grd_4c_Operacoes.Column1.Header1.Caption = "Emp."
546:                 THIS.grd_4c_Operacoes.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
547:                 THIS.grd_4c_Operacoes.Column3.Header1.Caption = "N" + CHR(250) + "mero"
548:                 THIS.grd_4c_Operacoes.Column4.Header1.Caption = "Data"
549:                 THIS.grd_4c_Operacoes.Column5.Header1.Caption = "Valor"
550: 
551:                 *-- ColumnCount ANTES de RecordSource
552:                 THIS.grd_4c_Itens.ColumnCount           = 3
553:                 THIS.grd_4c_Itens.RecordSource          = "cursor_4c_Itens"
554:                 THIS.grd_4c_Itens.column1.ControlSource = "cursor_4c_Itens.Cpros"
555:                 THIS.grd_4c_Itens.column2.ControlSource = "cursor_4c_Itens.Dpros"
556:                 THIS.grd_4c_Itens.column3.ControlSource = "cursor_4c_Itens.Qtds"
557:                 *-- Restaurar cabecalhos
558:                 THIS.grd_4c_Itens.Column1.Header1.Caption = "Produto"
559:                 THIS.grd_4c_Itens.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
560:                 THIS.grd_4c_Itens.Column3.Header1.Caption = "Qtde."
561:             ENDIF
562:         CATCH TO loc_oErro
563:             MsgErro(loc_oErro.Message + CHR(13) + ;
564:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
565:                     "Proc: " + loc_oErro.Procedure, "Erro CarregarDados")


### BO (C:\4c\projeto\app\classes\SIGPRPPPBO.prg):
*==============================================================================
* SIGPRPPPBO.prg - Business Object: Resultado de Pesquisa de Produtos por Conta
* Form OPERACIONAL sub-form: exibe movimentacoes e itens filtrados pelo pai
* Tabela base: SigMvCab / SigMvItn / SigCdPro
* Aberto por: FormSigPrPpc (passa TprMvCab populado + referencia THIS)
*==============================================================================
DEFINE CLASS SIGPRPPPBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros de filtro recebidos do form pai (FormSigPrPpc)
    * Espelham os campos exibidos nos controles somente-leitura do form
    *--------------------------------------------------------------------------
    this_cGrupo       = ""   && Codigo do grupo contabil (SigCdGcr.codigos)
    this_cConta       = ""   && Codigo da conta/cliente (SigCdCli.IClis)
    this_cContaDesc   = ""   && Descricao da conta (SigCdCli.RClis)
    this_dInicial     = {}   && Data inicial do periodo de consulta
    this_dFinal       = {}   && Data final do periodo de consulta

    *--------------------------------------------------------------------------
    * Estado interno do grid de operacoes
    * Evita recarregar grd_4c_Itens quando o usuario nao muda de linha
    *--------------------------------------------------------------------------
    this_nLinhaAnterior = 0  && Ultima linha ativa em grd_4c_Operacoes

    *--------------------------------------------------------------------------
    * Chave unica para operacoes na tabela SigTempC
    * Gerado por fUniqueIds() em CarregarMovimentos() e limpo ao encerrar
    *--------------------------------------------------------------------------
    this_cChavePesquisa = ""

    *--------------------------------------------------------------------------
    * Init - Operacional de pesquisa. Registra tabela consultada (SigMvItn) para
    * auditoria via BusinessBase.RegistrarAuditoria (usa this_cTabela).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvItn"
        THIS.this_cCampoChave = "cIdQuerys"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave da pesquisa em curso concatenada
    * com Grupo|Conta para rastrear filtros aplicados na auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(NVL(THIS.this_cGrupo, "")) + "|" + ;
                     ALLTRIM(NVL(THIS.this_cConta, "")) + "|" + ;
                     ALLTRIM(NVL(THIS.this_cChavePesquisa, ""))
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - OPERACIONAL: nao grava em tabela propria (form eh somente-leitura).
    * Executa CarregarMovimentos (pipeline SQL) + registra auditoria "CONSULTA".
    * Chamado por FormSigPrPpc antes de exibir o form para materializar dados.
    * Retorno: .T. se a consulta foi executada e auditada com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Auditoria obrigatoria da consulta (INSERT em LogAuditoria)
            THIS.RegistrarAuditoria("CONSULTA")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar auditoria da consulta: " + ;
                                      loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - OPERACIONAL: nao ha UPDATE em tabela propria. Regenera a chave
    * de pesquisa (novo cIdQuerys), reexecuta o pipeline e registra REFRESH.
    * Usado quando o usuario altera filtros e redispara a consulta.
    * Retorno: .T. se auditoria foi registrada com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Auditoria obrigatoria do refresh (INSERT em LogAuditoria)
            THIS.RegistrarAuditoria("REFRESH")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar auditoria do refresh: " + ;
                                      loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia filtros opcionais de um cursor para as props
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".cgrus") != "U"
                    THIS.this_cGrupo = TratarNulo(cgrus, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".IClis") != "U"
                    THIS.this_cConta = TratarNulo(IClis, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".RClis") != "U"
                    THIS.this_cContaDesc = TratarNulo(RClis, "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMovimentos - Pipeline principal de carga:
    *   1. Insere cabecalhos em SIGTEMPC (staging SQL Server)
    *   2. JOIN SIGTEMPC x SigMvItn x SigCdPro -> cursor_4c_MvItn indexado
    *   3. Popula cursor_4c_Operacoes a partir do cursor de origem (VFP)
    *   4. Cria cursor_4c_Itens e preenche com a primeira operacao
    * par_cCursorOrigem: nome do cursor VFP com cabecalhos (estrutura SigMvCab)
    *   deve ter: Emps C(3), Dopes C(20), Numes N(6,0), Datas D/T, Valos N(11,2)
    *--------------------------------------------------------------------------
    FUNCTION CarregarMovimentos(par_cCursorOrigem)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cCursorOrigem) OR RECCOUNT(par_cCursorOrigem) = 0
                THIS.this_cMensagemErro = "Nenhum registro para carregar."
            ELSE
                THIS.this_cChavePesquisa = SYS(2015)

                *-- Insere cabecalhos em SIGTEMPC (ponte VFP->SQL Server para JOIN)
                *-- dpros: NOT NULL no schema, usar string vazia como placeholder
                SELECT (par_cCursorOrigem)
                GO TOP
                DO WHILE !EOF()
                    SQLEXEC(gnConnHandle, ;
                        "INSERT INTO SIGTEMPC (EmpDopNums, cIdQuerys, cIdChaves, dpros)" + ;
                        " VALUES (" + ;
                        EscaparSQL(Emps + Dopes + STR(Numes, 6)) + ", " + ;
                        EscaparSQL(THIS.this_cChavePesquisa) + ", " + ;
                        EscaparSQL(SYS(2015)) + ", " + ;
                        "'')")
                    SKIP
                ENDDO

                *-- Busca itens com descricao atualizada de SigCdPro
                loc_cSQL = "SELECT b.Emps, b.Dopes, b.Numes, b.Cpros, " + ;
                           "ISNULL(p.dpros, b.Dpros) AS Dpros, b.Qtds " + ;
                           "FROM SIGTEMPC a " + ;
                           "INNER JOIN SigMvItn b ON a.empdopnums = b.empdopnums " + ;
                           "LEFT JOIN SigCdPro p ON b.cpros = p.cpros " + ;
                           "WHERE a.cidquerys = " + EscaparSQL(THIS.this_cChavePesquisa) + ;
                           " ORDER BY b.Emps, b.Dopes, b.Numes, b.Cpros"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvItnRaw")
                THIS.LimparSIGTEMPC(THIS.this_cChavePesquisa)

                IF loc_nResult >= 0
                    *-- Cria cursor indexado cursor_4c_MvItn para lookup por operacao
                    IF USED("cursor_4c_MvItn")
                        USE IN cursor_4c_MvItn
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_MvItn ;
                        (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6,0) NULL, ;
                         Cpros C(14) NULL, Dpros C(65) NULL, Qtds N(9,3) NULL)
                    SET NULL OFF

                    IF USED("cursor_4c_MvItnRaw") AND RECCOUNT("cursor_4c_MvItnRaw") > 0
                        SELECT cursor_4c_MvItn
                        APPEND FROM DBF("cursor_4c_MvItnRaw")
                    ENDIF
                    IF USED("cursor_4c_MvItnRaw")
                        USE IN cursor_4c_MvItnRaw
                    ENDIF

                    SELECT cursor_4c_MvItn
                    INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

                    *-- Popula cursor_4c_Operacoes diretamente do cursor de origem (VFP)
                    IF USED("cursor_4c_Operacoes")
                        USE IN cursor_4c_Operacoes
                    ENDIF
                    SELECT Emps, Dopes, Numes, Datas, Valos ;
                        FROM (par_cCursorOrigem) ;
                        ORDER BY Emps, Dopes, Numes ;
                        INTO CURSOR cursor_4c_Operacoes READWRITE

                    *-- Cria cursor_4c_Itens placeholder vazio
                    IF USED("cursor_4c_Itens")
                        USE IN cursor_4c_Itens
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Itens ;
                        (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6,0) NULL, ;
                         Cpros C(14) NULL, Dpros C(65) NULL, Qtds N(9,3) NULL)
                    SET NULL OFF

                    *-- Preenche itens da primeira operacao imediatamente
                    IF RECCOUNT("cursor_4c_Operacoes") > 0
                        SELECT cursor_4c_Operacoes
                        GO TOP
                        THIS.CarregarItensPorOperacao(cursor_4c_Operacoes.Emps, ;
                                                      cursor_4c_Operacoes.Dopes, ;
                                                      cursor_4c_Operacoes.Numes)
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao consultar itens de movimenta" + ;
                                              CHR(231) + CHR(245) + "es."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.LimparSIGTEMPC(THIS.this_cChavePesquisa)
            MsgErro(loc_oErro.Message, "Erro ao carregar movimenta" + CHR(231) + CHR(245) + "es")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensPorOperacao - Preenche cursor_4c_Itens com os itens da
    * operacao selecionada no grid superior (AfterRowColChange do form)
    * Faz SEEK em cursor_4c_MvItn (indexado por Emps+Dopes+STR(Numes,6))
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensPorOperacao(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_lSucesso, loc_cChaveSeek, loc_oErro
        LOCAL loc_cEmp, loc_cDop, loc_nNum, loc_cCpro, loc_cDpro, loc_nQtd
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_MvItn") AND USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                ZAP

                loc_cChaveSeek = par_cEmps + par_cDopes + STR(par_nNumes, 6)

                SELECT cursor_4c_MvItn
                SET ORDER TO EmpDopNum
                SET NEAR ON
                SEEK loc_cChaveSeek
                SET NEAR OFF

                DO WHILE !EOF("cursor_4c_MvItn") AND ;
                         cursor_4c_MvItn.Emps + cursor_4c_MvItn.Dopes + ;
                         STR(cursor_4c_MvItn.Numes, 6) = loc_cChaveSeek

                    loc_cEmp  = cursor_4c_MvItn.Emps
                    loc_cDop  = cursor_4c_MvItn.Dopes
                    loc_nNum  = cursor_4c_MvItn.Numes
                    loc_cCpro = cursor_4c_MvItn.Cpros
                    loc_cDpro = cursor_4c_MvItn.Dpros
                    loc_nQtd  = cursor_4c_MvItn.Qtds

                    INSERT INTO cursor_4c_Itens (Emps, Dopes, Numes, Cpros, Dpros, Qtds) ;
                        VALUES (loc_cEmp, loc_cDop, loc_nNum, loc_cCpro, loc_cDpro, loc_nQtd)

                    SELECT cursor_4c_MvItn
                    SKIP
                ENDDO

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar itens")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparSIGTEMPC - Remove registros temporarios da sessao em SIGTEMPC
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparSIGTEMPC(par_cChave)
        LOCAL loc_oErro
        TRY
            IF !EMPTY(par_cChave)
                SQLEXEC(gnConnHandle, "DELETE FROM SIGTEMPC WHERE cidquerys = " + ;
                        EscaparSQL(par_cChave))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar SIGTEMPC")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparRecursos - Fecha cursores temporarios ao encerrar o form
    *--------------------------------------------------------------------------
    PROCEDURE LimparRecursos()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF
            IF USED("cursor_4c_MvItn")
                USE IN cursor_4c_MvItn
            ENDIF
            IF USED("cursor_4c_MvItnRaw")
                USE IN cursor_4c_MvItnRaw
            ENDIF
            IF !EMPTY(THIS.this_cChavePesquisa)
                THIS.LimparSIGTEMPC(THIS.this_cChavePesquisa)
                THIS.this_cChavePesquisa = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao liberar recursos")
        ENDTRY
    ENDPROC

ENDDEFINE

