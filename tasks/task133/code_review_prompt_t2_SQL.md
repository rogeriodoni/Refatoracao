# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
Select crTmpJuros
	.DeleteMark = .f.
	.Column1.ControlSource = [Ttod(crTmpJuros.Datas)]
	.Column2.ControlSource = [crTmpJuros.Hists]
	.Column3.ControlSource = [crTmpJuros.Valors]
	.Column4.ControlSource = [crTmpJuros.Moedas]
	.Column5.ControlSource = [crTmpJuros.TaxJuros]
	.Column6.ControlSource = [crTmpJuros.Dias]
	.Column7.ControlSource = [crTmpJuros.Juros]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReJur.prg) - TRECHOS RELEVANTES PARA PASS SQL (1675 linhas total):

*-- Linhas 248 a 390:
248:             .FontSize          = 8
249:             .AllowHeaderSizing = .F.
250:             .AllowRowSizing    = .F.
251:             .DeleteMark        = .F.
252:             .RecordMark        = .F.
253:             .ReadOnly          = .F.
254:             .ScrollBars        = 2
255:             .GridLineColor     = RGB(238, 238, 238)
256:             .RecordSource      = "crTmpJuros"
257: 
258:             *-- Column1: Vencimento - exibe TTOD da data/hora (readonly)
259:             WITH .Column1
260:                 .Width             = 80
261:                 .FontName          = "Tahoma"
262:                 .ReadOnly          = .T.
263:                 .Movable           = .F.
264:                 .Resizable         = .F.
265:                 .ControlSource     = "TTOD(crTmpJuros.Datas)"
266:                 .Header1.Caption   = "Vencimento"
267:                 .Header1.FontName  = "Tahoma"
268:                 .Header1.FontSize  = 8
269:                 .Header1.Alignment = 2
270:                 .Header1.ForeColor = RGB(0, 0, 0)
271:                 .Text1.BorderStyle = 1
272:                 .Text1.Margin      = 0
273:                 .Text1.ForeColor   = RGB(0, 0, 0)
274:             ENDWITH
275: 
276:             *-- Column2: Historico - editavel se AlteraJuros=.T.
277:             WITH .Column2
278:                 .Width             = 336
279:                 .FontName          = "Tahoma"
280:                 .ReadOnly          = !THIS.this_lAlteraJuros
281:                 .Movable           = .F.
282:                 .Resizable         = .F.
283:                 .ControlSource     = "crTmpJuros.Hists"
284:                 .Header1.Caption   = "Hist" + CHR(243) + "rico"
285:                 .Header1.FontName  = "Tahoma"
286:                 .Header1.FontSize  = 8
287:                 .Header1.Alignment = 2
288:                 .Header1.ForeColor = RGB(0, 0, 0)
289:                 .Text1.Margin      = 0
290:             ENDWITH
291: 
292:             *-- Column3: Valor (readonly)
293:             WITH .Column3
294:                 .Width             = 120
295:                 .FontName          = "Tahoma"
296:                 .ReadOnly          = .T.
297:                 .Movable           = .F.
298:                 .Resizable         = .F.
299:                 .ControlSource     = "crTmpJuros.Valors"
300:                 .Header1.Caption   = "Valor"
301:                 .Header1.FontName  = "Tahoma"
302:                 .Header1.FontSize  = 8
303:                 .Header1.Alignment = 2
304:                 .Header1.ForeColor = RGB(0, 0, 0)
305:                 .Text1.BorderStyle = 0
306:                 .Text1.Margin      = 0
307:                 .Text1.ForeColor   = RGB(0, 0, 0)
308:                 .Text1.BackColor   = RGB(255, 255, 255)
309:             ENDWITH
310: 
311:             *-- Column4: Moeda (readonly)
312:             WITH .Column4
313:                 .Width             = 35
314:                 .FontName          = "Tahoma"
315:                 .ReadOnly          = .T.
316:                 .Movable           = .F.
317:                 .Resizable         = .F.
318:                 .ControlSource     = "crTmpJuros.Moedas"
319:                 .Header1.Caption   = "Moe"
320:                 .Header1.FontName  = "Tahoma"
321:                 .Header1.FontSize  = 8
322:                 .Header1.Alignment = 2
323:                 .Header1.ForeColor = RGB(0, 0, 0)
324:                 .Text1.BorderStyle = 0
325:                 .Text1.Margin      = 0
326:                 .Text1.ForeColor   = RGB(0, 0, 0)
327:                 .Text1.BackColor   = RGB(255, 255, 255)
328:             ENDWITH
329: 
330:             *-- Column5: Taxa Juros (readonly)
331:             WITH .Column5
332:                 .Width             = 120
333:                 .FontName          = "Tahoma"
334:                 .ReadOnly          = .T.
335:                 .Movable           = .F.
336:                 .Resizable         = .F.
337:                 .ControlSource     = "crTmpJuros.TaxJuros"
338:                 .Header1.Caption   = "Taxa Juros"
339:                 .Header1.FontName  = "Tahoma"
340:                 .Header1.FontSize  = 8
341:                 .Header1.Alignment = 2
342:                 .Header1.ForeColor = RGB(0, 0, 0)
343:                 .Text1.BorderStyle = 0
344:                 .Text1.Margin      = 0
345:                 .Text1.ForeColor   = RGB(0, 0, 0)
346:                 .Text1.BackColor   = RGB(255, 255, 255)
347:             ENDWITH
348: 
349:             *-- Column6: Dias (readonly)
350:             WITH .Column6
351:                 .Width             = 44
352:                 .FontName          = "Tahoma"
353:                 .ReadOnly          = .T.
354:                 .Movable           = .F.
355:                 .Resizable         = .F.
356:                 .ControlSource     = "crTmpJuros.Dias"
357:                 .Header1.Caption   = "Dias"
358:                 .Header1.FontName  = "Tahoma"
359:                 .Header1.FontSize  = 8
360:                 .Header1.Alignment = 2
361:                 .Header1.ForeColor = RGB(0, 0, 0)
362:                 .Text1.BorderStyle = 0
363:                 .Text1.Margin      = 0
364:                 .Text1.ForeColor   = RGB(0, 0, 0)
365:                 .Text1.BackColor   = RGB(255, 255, 255)
366:             ENDWITH
367: 
368:             *-- Column7: Juros - editavel se AlteraJuros=.T.
369:             WITH .Column7
370:                 .Width             = 120
371:                 .FontName          = "Tahoma"
372:                 .ReadOnly          = !THIS.this_lAlteraJuros
373:                 .Movable           = .F.
374:                 .Resizable         = .F.
375:                 .ControlSource     = "crTmpJuros.Juros"
376:                 .Header1.Caption   = "Juros"
377:                 .Header1.FontName  = "Tahoma"
378:                 .Header1.FontSize  = 8
379:                 .Header1.Alignment = 2
380:                 .Header1.ForeColor = RGB(0, 0, 0)
381:                 .Text1.BorderStyle = 0
382:                 .Text1.Margin      = 0
383:                 .Text1.ForeColor   = RGB(0, 0, 0)
384:                 .Text1.BackColor   = RGB(255, 255, 255)
385:             ENDWITH
386: 
387:             .Visible = .T.
388:         ENDWITH
389: 
390:         THIS.FormatarGridLista(THIS.grd_4c_Dados)

*-- Linhas 754 a 772:
754:             THIS.txt_4c_OPER.Value = "C"
755: 
756:             IF USED("crTmpJuros")
757:                 SELECT crTmpJuros
758:                 loc_cGrupo = ALLTRIM(TratarNulo(Grupos, "C"))
759:                 loc_cConta = ALLTRIM(TratarNulo(Contas, "C"))
760: 
761:                 THIS.txt_4c_Grupo.Value = loc_cGrupo
762: 
763:                 IF !EMPTY(loc_cGrupo)
764:                     loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cGrupo)
765:                     THIS.txt_4c_Dgrupo.Value = loc_cDesc
766:                 ENDIF
767: 
768:                 THIS.txt_4c_Conta.Value = loc_cConta
769: 
770:                 IF !EMPTY(loc_cConta)
771:                     loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cGrupo, loc_cConta)
772:                     THIS.txt_4c_Dconta.Value = loc_cDesc

*-- Linhas 779 a 797:
779:             THIS.txt_4c_SOPER.Value = "D"
780: 
781:             IF USED("crSigCdPam")
782:                 SELECT crSigCdPam
783:                 loc_cGrupo = ALLTRIM(TratarNulo(GrupoPart, "C"))
784:                 loc_cConta = ALLTRIM(TratarNulo(ContaPart, "C"))
785: 
786:                 THIS.txt_4c_SGRUPO.Value = loc_cGrupo
787: 
788:                 IF !EMPTY(loc_cGrupo)
789:                     loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cGrupo)
790:                     THIS.txt_4c_Sdgrupo.Value = loc_cDesc
791:                 ENDIF
792: 
793:                 THIS.txt_4c_SCONTA.Value = loc_cConta
794: 
795:                 IF !EMPTY(loc_cConta)
796:                     loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cGrupo, loc_cConta)
797:                     THIS.txt_4c_SDCONTA.Value = loc_cDesc

*-- Linhas 1122 a 1140:
1122: 
1123:             IF loc_oBusca.this_lSelecionou
1124:                 IF USED("cursor_4c_BuscaGrupoD")
1125:                     SELECT cursor_4c_BuscaGrupoD
1126:                     loc_cCodigo    = ALLTRIM(TratarNulo(Codigos, "C"))
1127:                     loc_cDescricao = ALLTRIM(TratarNulo(Descrs, "C"))
1128:                     THIS.txt_4c_Grupo.Value  = loc_cCodigo
1129:                     THIS.txt_4c_Dgrupo.Value = loc_cDescricao
1130:                 ENDIF
1131:             ENDIF
1132: 
1133:             IF USED("cursor_4c_BuscaGrupoD")
1134:                 USE IN cursor_4c_BuscaGrupoD
1135:             ENDIF
1136:             loc_oBusca.Release()
1137: 
1138:         CATCH TO loc_oErro
1139:             MsgErro("Erro ao abrir lookup de grupo d" + CHR(233) + "bito:" + CHR(13) + ;
1140:                     "Erro: " + loc_oErro.Message + CHR(13) + ;

*-- Linhas 1172 a 1190:
1172: 
1173:             IF loc_oBusca.this_lSelecionou
1174:                 IF USED("cursor_4c_BuscaContaD")
1175:                     SELECT cursor_4c_BuscaContaD
1176:                     loc_cCodigo    = ALLTRIM(TratarNulo(IClis, "C"))
1177:                     loc_cDescricao = ALLTRIM(TratarNulo(RClis, "C"))
1178:                     THIS.txt_4c_Conta.Value  = loc_cCodigo
1179:                     THIS.txt_4c_Dconta.Value = loc_cDescricao
1180:                 ENDIF
1181:             ENDIF
1182: 
1183:             IF USED("cursor_4c_BuscaContaD")
1184:                 USE IN cursor_4c_BuscaContaD
1185:             ENDIF
1186:             loc_oBusca.Release()
1187:             THIS.AtualizarHabilitacaoDescricoes()
1188: 
1189:         CATCH TO loc_oErro
1190:             MsgErro("Erro ao abrir lookup de conta d" + CHR(233) + "bito:" + CHR(13) + ;

*-- Linhas 1221 a 1239:
1221: 
1222:             IF loc_oBusca.this_lSelecionou
1223:                 IF USED("cursor_4c_BuscaGrupoC")
1224:                     SELECT cursor_4c_BuscaGrupoC
1225:                     loc_cCodigo    = ALLTRIM(TratarNulo(Codigos, "C"))
1226:                     loc_cDescricao = ALLTRIM(TratarNulo(Descrs, "C"))
1227:                     THIS.txt_4c_SGRUPO.Value  = loc_cCodigo
1228:                     THIS.txt_4c_Sdgrupo.Value = loc_cDescricao
1229:                 ENDIF
1230:             ENDIF
1231: 
1232:             IF USED("cursor_4c_BuscaGrupoC")
1233:                 USE IN cursor_4c_BuscaGrupoC
1234:             ENDIF
1235:             loc_oBusca.Release()
1236: 
1237:         CATCH TO loc_oErro
1238:             MsgErro("Erro ao abrir lookup de grupo cr" + CHR(233) + "dito:" + CHR(13) + ;
1239:                     "Erro: " + loc_oErro.Message + CHR(13) + ;

*-- Linhas 1271 a 1289:
1271: 
1272:             IF loc_oBusca.this_lSelecionou
1273:                 IF USED("cursor_4c_BuscaContaC")
1274:                     SELECT cursor_4c_BuscaContaC
1275:                     loc_cCodigo    = ALLTRIM(TratarNulo(IClis, "C"))
1276:                     loc_cDescricao = ALLTRIM(TratarNulo(RClis, "C"))
1277:                     THIS.txt_4c_SCONTA.Value  = loc_cCodigo
1278:                     THIS.txt_4c_SDCONTA.Value = loc_cDescricao
1279:                 ENDIF
1280:             ENDIF
1281: 
1282:             IF USED("cursor_4c_BuscaContaC")
1283:                 USE IN cursor_4c_BuscaContaC
1284:             ENDIF
1285:             loc_oBusca.Release()
1286:             THIS.AtualizarHabilitacaoDescricoes()
1287: 
1288:         CATCH TO loc_oErro
1289:             MsgErro("Erro ao abrir lookup de conta cr" + CHR(233) + "dito:" + CHR(13) + ;

*-- Linhas 1357 a 1375:
1357:             ELSE
1358:                 IF THIS.this_lAlteraJuros AND VARTYPE(THIS.grd_4c_Dados) = "O"
1359:                     IF USED("crTmpJuros") AND RECCOUNT("crTmpJuros") > 0
1360:                         SELECT crTmpJuros
1361:                         GO TOP
1362:                     ENDIF
1363:                     THIS.grd_4c_Dados.SetFocus
1364:                 ENDIF
1365:             ENDIF
1366:         CATCH TO loc_oErro
1367:             MsgErro("Erro ao posicionar foco para inclus" + CHR(227) + "o:" + CHR(13) + ;
1368:                     "Erro: " + loc_oErro.Message + CHR(13) + ;
1369:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1370:                     "FormSigReJur.BtnIncluirClick")
1371:         ENDTRY
1372:     ENDPROC
1373: 
1374:     *==========================================================================
1375:     * BtnAlterarClick - Form OPERACIONAL: posiciona foco na grade para edicao

*-- Linhas 1388 a 1406:
1388: 
1389:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1390:                 IF USED("crTmpJuros") AND RECCOUNT("crTmpJuros") > 0
1391:                     SELECT crTmpJuros
1392:                     IF EOF()
1393:                         GO TOP
1394:                     ENDIF
1395:                 ENDIF
1396:                 THIS.grd_4c_Dados.SetFocus
1397:             ENDIF
1398:         CATCH TO loc_oErro
1399:             MsgErro("Erro ao ativar modo altera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1400:                     "Erro: " + loc_oErro.Message + CHR(13) + ;
1401:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1402:                     "FormSigReJur.BtnAlterarClick")
1403:         ENDTRY
1404:     ENDPROC
1405: 
1406:     *==========================================================================

*-- Linhas 1445 a 1498:
1445:             RETURN
1446:         ENDIF
1447: 
1448:         SELECT crTmpJuros
1449:         IF RECCOUNT() = 0 OR EOF() OR BOF()
1450:             MsgAviso("Nenhum registro selecionado.", ;
1451:                      "Aten" + CHR(231) + CHR(227) + "o")
1452:             RETURN
1453:         ENDIF
1454: 
1455:         loc_lConfirma = MsgConfirma("Confirma zerar os juros desta linha?", ;
1456:                                     "Confirma" + CHR(231) + CHR(227) + "o")
1457:         IF !loc_lConfirma
1458:             RETURN
1459:         ENDIF
1460: 
1461:         TRY
1462:             SELECT crTmpJuros
1463:             REPLACE Hists WITH SPACE(LEN(Hists))
1464:             REPLACE Juros WITH 0
1465:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1466:                 THIS.grd_4c_Dados.Refresh
1467:             ENDIF
1468:         CATCH TO loc_oErro
1469:             MsgErro("Erro ao zerar juros da linha:" + CHR(13) + ;
1470:                     "Erro: " + loc_oErro.Message + CHR(13) + ;
1471:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1472:                     "FormSigReJur.BtnExcluirClick")
1473:         ENDTRY
1474:     ENDPROC
1475: 
1476:     *==========================================================================
1477:     * CarregarLista - Refresca o grid de juros a partir de crTmpJuros
1478:     *==========================================================================
1479:     PROCEDURE CarregarLista()
1480:         LOCAL loc_oErro
1481:         TRY
1482:             IF USED("crTmpJuros") AND VARTYPE(THIS.grd_4c_Dados) = "O"
1483:                 SELECT crTmpJuros
1484:                 GO TOP
1485:                 THIS.grd_4c_Dados.Refresh
1486:             ENDIF
1487:         CATCH TO loc_oErro
1488:             MsgErro("Erro ao carregar lista:" + CHR(13) + ;
1489:                     "Erro: " + loc_oErro.Message + CHR(13) + ;
1490:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1491:                     "FormSigReJur.CarregarLista")
1492:         ENDTRY
1493:     ENDPROC
1494: 
1495:     *==========================================================================
1496:     * AjustarBotoesPorModo - Form OPERACIONAL sem modos: nao altera botoes
1497:     *==========================================================================
1498:     PROCEDURE AjustarBotoesPorModo()

*-- Linhas 1601 a 1619:
1601:                 loc_cContaD = ALLTRIM(THIS.txt_4c_Conta.Value)
1602: 
1603:                 IF !EMPTY(loc_cGrupoD) OR !EMPTY(loc_cContaD)
1604:                     SELECT crTmpJuros
1605:                     GO TOP
1606:                     DO WHILE !EOF()
1607:                         IF !EMPTY(loc_cGrupoD)
1608:                             REPLACE Grupos WITH loc_cGrupoD
1609:                         ENDIF
1610:                         IF !EMPTY(loc_cContaD)
1611:                             REPLACE Contas WITH loc_cContaD
1612:                         ENDIF
1613:                         SKIP
1614:                     ENDDO
1615:                 ENDIF
1616:             ENDIF
1617:         CATCH TO loc_oErro
1618:             MsgErro("Erro ao propagar dados para cursor:" + CHR(13) + ;
1619:                     "Erro: " + loc_oErro.Message + CHR(13) + ;


### BO (C:\4c\projeto\app\classes\SigReJurBO.prg):
*==========================================================================
* SigReJurBO.prg - Business Object para Lancamento de Juros
* Herda de: BusinessBase
* Formulario: FormSigReJur (OPERACIONAL)
* Cursor de trabalho: crTmpJuros (passado pelo form pai via DataSession)
* Tarefa: task133
*==========================================================================

DEFINE CLASS SigReJurBO AS BusinessBase

    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Lado Debito: indicador de operacao, codigo/descricao do grupo contabil e conta
    this_cOper   = ""
    this_cGrupo  = ""
    this_cDGrupo = ""
    this_cConta  = ""
    this_cDConta = ""

    *-- Lado Credito: indicador de operacao, codigo/descricao do grupo contabil e conta
    this_cSOper   = ""
    this_cSGrupo  = ""
    this_cSDGrupo = ""
    this_cSConta  = ""
    this_cSDConta = ""

    *-- Flags de permissao carregadas via fChecaAcesso no Init do form
    this_lAlteraContas = .F.
    this_lAlteraJuros  = .F.

    *-- Campos do cursor compartilhado crTmpJuros (linha de juros sendo editada)
    this_dData     = {}
    this_cHist     = ""
    this_nValor    = 0
    this_cMoeda    = ""
    this_nTaxJuros = 0
    this_nDias     = 0
    this_nJuros    = 0

    *-- Alias do cursor compartilhado (default = crTmpJuros do form pai)
    this_cAliasCursor = "crTmpJuros"

    *--------------------------------------------------------------------------
    PROCEDURE Init
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional nao tem chave primaria propria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor crTmpJuros
    * par_cAliasCursor = alias do cursor crTmpJuros (lado debito)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cOper  = "C"
                THIS.this_cGrupo = TratarNulo(Grupos, "C")
                THIS.this_cConta = TratarNulo(Contas, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar cursor de juros:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), "SigReJurBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosPam - Carrega contabilizacao padrao do cursor crSigCdPam
    * par_cAliasCursor = alias do cursor crSigCdPam (lado credito)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosPam(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cSOper  = "D"
                THIS.this_cSGrupo = TratarNulo(GrupoPart, "C")
                THIS.this_cSConta = TratarNulo(ContaPart, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar par" + CHR(226) + "metros de contabiliza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), "SigReJurBO.CarregarDadosPam")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoGrupo - Retorna descricao do grupo contabil (SigCdGcr.Descrs)
    * par_cCodigo = codigo do grupo (Codigos)
    * Retorna string com descricao ou "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_oErro
        loc_cDescricao = ""

        IF EMPTY(ALLTRIM(par_cCodigo))
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrDescTmp")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_GrDescTmp") > 0
                SELECT cursor_4c_GrDescTmp
                loc_cDescricao = TratarNulo(Descrs, "C")
            ENDIF
            IF USED("cursor_4c_GrDescTmp")
                USE IN cursor_4c_GrDescTmp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o de grupo:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, "SigReJurBO.BuscarDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoConta - Retorna descricao da conta corrente (SigCdCli.RClis)
    * par_cGrupo = codigo do grupo (Grupos)
    * par_cConta = codigo da conta (IClis)
    * Retorna string com descricao ou "" se nao encontrada
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoConta(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_oErro
        loc_cDescricao = ""

        IF EMPTY(ALLTRIM(par_cConta))
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli" + ;
                       " WHERE IClis = " + EscaparSQL(par_cConta)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaDescTmp")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CtaDescTmp") > 0
                SELECT cursor_4c_CtaDescTmp
                loc_cDescricao = TratarNulo(RClis, "C")
            ENDIF
            IF USED("cursor_4c_CtaDescTmp")
                USE IN cursor_4c_CtaDescTmp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o de conta:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, "SigReJurBO.BuscarDescricaoConta")
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarContaAtiva - Verifica se conta corrente esta ativa em SigCdCli
    * par_cConta = codigo da conta (IClis)
    * Retorna .T. se conta esta ATIVA (Inativas = 0), .F. se inativa ou inexistente
    *--------------------------------------------------------------------------
    FUNCTION VerificarContaAtiva(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lAtiva, loc_oErro
        loc_lAtiva = .F.

        IF EMPTY(ALLTRIM(par_cConta))
            RETURN loc_lAtiva
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Inativas FROM SigCdCli" + ;
                       " WHERE IClis = " + EscaparSQL(par_cConta)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaAtivaTmp")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CtaAtivaTmp") > 0
                SELECT cursor_4c_CtaAtivaTmp
                *-- Inativas NUMERIC(1,0): 0=ATIVA, 1+=INATIVA
                IF VARTYPE(Inativas) = "L"
                    loc_lAtiva = !Inativas
                ELSE
                    IF VARTYPE(Inativas) = "L"
                        loc_lAtiva = !Inativas
                    ELSE
                        IF VARTYPE(Inativas) = "L"
                            loc_lAtiva = !Inativas
                        ELSE
                            IF VARTYPE(Inativas) = "L"
                                loc_lAtiva = !Inativas
                            ELSE
                                loc_lAtiva = (NVL(Inativas, 0) = 0)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_CtaAtivaTmp")
                USE IN cursor_4c_CtaAtivaTmp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar conta inativa:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, "SigReJurBO.VerificarContaAtiva")
        ENDTRY

        RETURN loc_lAtiva
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarAcessoGrupo - Verifica se grupo contabil existe em SigCdGcr
    * par_cCodigo = codigo do grupo (Codigos)
    * Retorna .T. se grupo existe, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION VerificarAcessoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lAcesso, loc_nQtd, loc_oErro
        loc_lAcesso = .F.

        IF EMPTY(ALLTRIM(par_cCodigo))
            RETURN loc_lAcesso
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcGrpTmp")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_AcGrpTmp") > 0
                SELECT cursor_4c_AcGrpTmp
                loc_nQtd = NVL(nExiste, 0)
                loc_lAcesso = (loc_nQtd > 0)
            ENDIF
            IF USED("cursor_4c_AcGrpTmp")
                USE IN cursor_4c_AcGrpTmp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar acesso ao grupo:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, "SigReJurBO.VerificarAcessoGrupo")
        ENDTRY

        RETURN loc_lAcesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarAcessoConta - Verifica se conta existe para o grupo informado em SigCdCli
    * par_cGrupo = codigo do grupo (Grupos)
    * par_cConta = codigo da conta (IClis)
    * Retorna .T. se conta existe no grupo, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION VerificarAcessoConta(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lAcesso, loc_nQtd, loc_oErro
        loc_lAcesso = .F.

        IF EMPTY(ALLTRIM(par_cConta))
            RETURN loc_lAcesso
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli" + ;
                       " WHERE IClis = " + EscaparSQL(par_cConta)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcCtaTmp")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_AcCtaTmp") > 0
                SELECT cursor_4c_AcCtaTmp
                loc_nQtd = NVL(nExiste, 0)
                loc_lAcesso = (loc_nQtd > 0)
            ENDIF
            IF USED("cursor_4c_AcCtaTmp")
                USE IN cursor_4c_AcCtaTmp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar acesso " + CHR(224) + " conta:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, "SigReJurBO.VerificarAcessoConta")
        ENDTRY

        RETURN loc_lAcesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - APPEND BLANK na linha de juros no cursor compartilhado crTmpJuros
    * REGRA: Form OPERACIONAL ? edicao por cursor compartilhado (DataSession do form pai),
    *        NAO ha SQL INSERT em tabela. Persistencia ocorre quando o form pai
    *        consome crTmpJuros (rotina de lancamento de juros do framework SIG).
    * Retorna .T. se sucesso, .F. caso contrario.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        loc_cAlias   = THIS.this_cAliasCursor

        TRY
            IF !USED(loc_cAlias)
                MostrarErro("Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
                            "SigReJurBO.Inserir")
            ELSE
                SELECT (loc_cAlias)
                APPEND BLANK

                REPLACE Datas    WITH THIS.this_dData     IN (loc_cAlias)
                REPLACE Hists    WITH THIS.this_cHist     IN (loc_cAlias)
                REPLACE Valors   WITH THIS.this_nValor    IN (loc_cAlias)
                REPLACE Moedas   WITH THIS.this_cMoeda    IN (loc_cAlias)
                REPLACE TaxJuros WITH THIS.this_nTaxJuros IN (loc_cAlias)
                REPLACE Dias     WITH THIS.this_nDias     IN (loc_cAlias)
                REPLACE Juros    WITH THIS.this_nJuros    IN (loc_cAlias)
                REPLACE Grupos   WITH THIS.this_cGrupo    IN (loc_cAlias)
                REPLACE Contas   WITH THIS.this_cConta    IN (loc_cAlias)

                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir linha de juros:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SigReJurBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - REPLACE da linha corrente no cursor compartilhado crTmpJuros
    * REGRA: Forma operacional permite editar apenas Hists (col 2) e Juros (col 7)
    *        diretamente no grid. Este metodo persiste todos os campos da linha
    *        corrente a partir das propriedades do BO ? util quando edicao acontece
    *        fora do grid (formularios secundarios, validacoes complementares).
    * Retorna .T. se sucesso, .F. caso contrario.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        loc_cAlias   = THIS.this_cAliasCursor

        TRY
            IF !USED(loc_cAlias)
                MostrarErro("Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
                            "SigReJurBO.Atualizar")
            ELSE
                SELECT (loc_cAlias)
                IF EOF() OR BOF() OR RECNO() <= 0
                    MostrarErro("N" + CHR(227) + "o h" + CHR(225) + " registro corrente em " + loc_cAlias + " para atualizar.", ;
                                "SigReJurBO.Atualizar")
                ELSE
                    REPLACE Datas    WITH THIS.this_dData     IN (loc_cAlias)
                    REPLACE Hists    WITH THIS.this_cHist     IN (loc_cAlias)
                    REPLACE Valors   WITH THIS.this_nValor    IN (loc_cAlias)
                    REPLACE Moedas   WITH THIS.this_cMoeda    IN (loc_cAlias)
                    REPLACE TaxJuros WITH THIS.this_nTaxJuros IN (loc_cAlias)
                    REPLACE Dias     WITH THIS.this_nDias     IN (loc_cAlias)
                    REPLACE Juros    WITH THIS.this_nJuros    IN (loc_cAlias)
                    REPLACE Grupos   WITH THIS.this_cGrupo    IN (loc_cAlias)
                    REPLACE Contas   WITH THIS.this_cConta    IN (loc_cAlias)

                    THIS.RegistrarAuditoria("ATUALIZAR")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar linha de juros:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SigReJurBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Sobrescreve auditoria para form operacional
    * Como nao ha persistencia em tabela SQL propria, grava log em LogAuditoria
    * com a chave composta (Grupo + Conta + Data) para rastreabilidade da
    * linha de juros editada/inserida no cursor compartilhado.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_nResultado, loc_oErro

        TRY
            loc_cChave = ALLTRIM(THIS.this_cGrupo) + "|" + ;
                         ALLTRIM(THIS.this_cConta) + "|" + ;
                         DTOC(THIS.this_dData)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, ChavePrimaria, Operacao, Usuario, DataHora, Empresa) " + ;
                       "VALUES (" + ;
                       EscaparSQL("crTmpJuros") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Falha ao registrar auditoria de " + par_cOperacao + " em crTmpJuros.", ;
                            "SigReJurBO.RegistrarAuditoria")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao registrar auditoria:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, ;
                        "SigReJurBO.RegistrarAuditoria")
        ENDTRY
    ENDPROC

ENDDEFINE

