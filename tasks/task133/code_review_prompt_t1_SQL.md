# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReJur.prg) - TRECHOS RELEVANTES PARA PASS SQL (1679 linhas total):

*-- Linhas 246 a 388:
246:             .FontSize          = 8
247:             .AllowHeaderSizing = .F.
248:             .AllowRowSizing    = .F.
249:             .DeleteMark        = .F.
250:             .RecordMark        = .F.
251:             .ReadOnly          = .F.
252:             .ScrollBars        = 2
253:             .GridLineColor     = RGB(238, 238, 238)
254:             .RecordSource      = "crTmpJuros"
255: 
256:             *-- Column1: Vencimento - exibe TTOD da data/hora (readonly)
257:             WITH .Column1
258:                 .Width             = 80
259:                 .FontName          = "Tahoma"
260:                 .ReadOnly          = .T.
261:                 .Movable           = .F.
262:                 .Resizable         = .F.
263:                 .ControlSource     = "TTOD(crTmpJuros.Datas)"
264:                 .Header1.Caption   = "Vencimento"
265:                 .Header1.FontName  = "Tahoma"
266:                 .Header1.FontSize  = 8
267:                 .Header1.Alignment = 2
268:                 .Header1.ForeColor = RGB(0, 0, 0)
269:                 .Text1.BorderStyle = 1
270:                 .Text1.Margin      = 0
271:                 .Text1.ForeColor   = RGB(0, 0, 0)
272:             ENDWITH
273: 
274:             *-- Column2: Historico - editavel se AlteraJuros=.T.
275:             WITH .Column2
276:                 .Width             = 336
277:                 .FontName          = "Tahoma"
278:                 .ReadOnly          = !THIS.this_lAlteraJuros
279:                 .Movable           = .F.
280:                 .Resizable         = .F.
281:                 .ControlSource     = "crTmpJuros.Hists"
282:                 .Header1.Caption   = "Hist" + CHR(243) + "rico"
283:                 .Header1.FontName  = "Tahoma"
284:                 .Header1.FontSize  = 8
285:                 .Header1.Alignment = 2
286:                 .Header1.ForeColor = RGB(0, 0, 0)
287:                 .Text1.Margin      = 0
288:             ENDWITH
289: 
290:             *-- Column3: Valor (readonly)
291:             WITH .Column3
292:                 .Width             = 120
293:                 .FontName          = "Tahoma"
294:                 .ReadOnly          = .T.
295:                 .Movable           = .F.
296:                 .Resizable         = .F.
297:                 .ControlSource     = "crTmpJuros.Valors"
298:                 .Header1.Caption   = "Valor"
299:                 .Header1.FontName  = "Tahoma"
300:                 .Header1.FontSize  = 8
301:                 .Header1.Alignment = 2
302:                 .Header1.ForeColor = RGB(0, 0, 0)
303:                 .Text1.BorderStyle = 0
304:                 .Text1.Margin      = 0
305:                 .Text1.ForeColor   = RGB(0, 0, 0)
306:                 .Text1.BackColor   = RGB(255, 255, 255)
307:             ENDWITH
308: 
309:             *-- Column4: Moeda (readonly)
310:             WITH .Column4
311:                 .Width             = 35
312:                 .FontName          = "Tahoma"
313:                 .ReadOnly          = .T.
314:                 .Movable           = .F.
315:                 .Resizable         = .F.
316:                 .ControlSource     = "crTmpJuros.Moedas"
317:                 .Header1.Caption   = "Moe"
318:                 .Header1.FontName  = "Tahoma"
319:                 .Header1.FontSize  = 8
320:                 .Header1.Alignment = 2
321:                 .Header1.ForeColor = RGB(0, 0, 0)
322:                 .Text1.BorderStyle = 0
323:                 .Text1.Margin      = 0
324:                 .Text1.ForeColor   = RGB(0, 0, 0)
325:                 .Text1.BackColor   = RGB(255, 255, 255)
326:             ENDWITH
327: 
328:             *-- Column5: Taxa Juros (readonly)
329:             WITH .Column5
330:                 .Width             = 120
331:                 .FontName          = "Tahoma"
332:                 .ReadOnly          = .T.
333:                 .Movable           = .F.
334:                 .Resizable         = .F.
335:                 .ControlSource     = "crTmpJuros.TaxJuros"
336:                 .Header1.Caption   = "Taxa Juros"
337:                 .Header1.FontName  = "Tahoma"
338:                 .Header1.FontSize  = 8
339:                 .Header1.Alignment = 2
340:                 .Header1.ForeColor = RGB(0, 0, 0)
341:                 .Text1.BorderStyle = 0
342:                 .Text1.Margin      = 0
343:                 .Text1.ForeColor   = RGB(0, 0, 0)
344:                 .Text1.BackColor   = RGB(255, 255, 255)
345:             ENDWITH
346: 
347:             *-- Column6: Dias (readonly)
348:             WITH .Column6
349:                 .Width             = 44
350:                 .FontName          = "Tahoma"
351:                 .ReadOnly          = .T.
352:                 .Movable           = .F.
353:                 .Resizable         = .F.
354:                 .ControlSource     = "crTmpJuros.Dias"
355:                 .Header1.Caption   = "Dias"
356:                 .Header1.FontName  = "Tahoma"
357:                 .Header1.FontSize  = 8
358:                 .Header1.Alignment = 2
359:                 .Header1.ForeColor = RGB(0, 0, 0)
360:                 .Text1.BorderStyle = 0
361:                 .Text1.Margin      = 0
362:                 .Text1.ForeColor   = RGB(0, 0, 0)
363:                 .Text1.BackColor   = RGB(255, 255, 255)
364:             ENDWITH
365: 
366:             *-- Column7: Juros - editavel se AlteraJuros=.T.
367:             WITH .Column7
368:                 .Width             = 120
369:                 .FontName          = "Tahoma"
370:                 .ReadOnly          = !THIS.this_lAlteraJuros
371:                 .Movable           = .F.
372:                 .Resizable         = .F.
373:                 .ControlSource     = "crTmpJuros.Juros"
374:                 .Header1.Caption   = "Juros"
375:                 .Header1.FontName  = "Tahoma"
376:                 .Header1.FontSize  = 8
377:                 .Header1.Alignment = 2
378:                 .Header1.ForeColor = RGB(0, 0, 0)
379:                 .Text1.BorderStyle = 0
380:                 .Text1.Margin      = 0
381:                 .Text1.ForeColor   = RGB(0, 0, 0)
382:                 .Text1.BackColor   = RGB(255, 255, 255)
383:             ENDWITH
384: 
385:             .Visible = .T.
386:         ENDWITH
387: 
388:         THIS.FormatarGridLista(THIS.grd_4c_Dados)

*-- Linhas 752 a 770:
752:             THIS.txt_4c_OPER.Value = "C"
753: 
754:             IF USED("crTmpJuros")
755:                 SELECT crTmpJuros
756:                 loc_cGrupo = ALLTRIM(TratarNulo(Grupos, "C"))
757:                 loc_cConta = ALLTRIM(TratarNulo(Contas, "C"))
758: 
759:                 THIS.txt_4c_Grupo.Value = loc_cGrupo
760: 
761:                 IF !EMPTY(loc_cGrupo)
762:                     loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cGrupo)
763:                     THIS.txt_4c_Dgrupo.Value = loc_cDesc
764:                 ENDIF
765: 
766:                 THIS.txt_4c_Conta.Value = loc_cConta
767: 
768:                 IF !EMPTY(loc_cConta)
769:                     loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cGrupo, loc_cConta)
770:                     THIS.txt_4c_Dconta.Value = loc_cDesc

*-- Linhas 777 a 795:
777:             THIS.txt_4c_SOPER.Value = "D"
778: 
779:             IF USED("crSigCdPam")
780:                 SELECT crSigCdPam
781:                 loc_cGrupo = ALLTRIM(TratarNulo(GrupoPart, "C"))
782:                 loc_cConta = ALLTRIM(TratarNulo(ContaPart, "C"))
783: 
784:                 THIS.txt_4c_SGRUPO.Value = loc_cGrupo
785: 
786:                 IF !EMPTY(loc_cGrupo)
787:                     loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cGrupo)
788:                     THIS.txt_4c_Sdgrupo.Value = loc_cDesc
789:                 ENDIF
790: 
791:                 THIS.txt_4c_SCONTA.Value = loc_cConta
792: 
793:                 IF !EMPTY(loc_cConta)
794:                     loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cGrupo, loc_cConta)
795:                     THIS.txt_4c_SDCONTA.Value = loc_cDesc

*-- Linhas 1120 a 1138:
1120: 
1121:             IF loc_oBusca.this_lSelecionou
1122:                 IF USED("cursor_4c_BuscaGrupoD")
1123:                     SELECT cursor_4c_BuscaGrupoD
1124:                     loc_cCodigo    = ALLTRIM(TratarNulo(Codigos, "C"))
1125:                     loc_cDescricao = ALLTRIM(TratarNulo(Descrs, "C"))
1126:                     THIS.txt_4c_Grupo.Value  = loc_cCodigo
1127:                     THIS.txt_4c_Dgrupo.Value = loc_cDescricao
1128:                 ENDIF
1129:             ENDIF
1130: 
1131:             IF USED("cursor_4c_BuscaGrupoD")
1132:                 USE IN cursor_4c_BuscaGrupoD
1133:             ENDIF
1134:             loc_oBusca.Release()
1135: 
1136:         CATCH TO loc_oErro
1137:             MsgErro("Erro ao abrir lookup de grupo d" + CHR(233) + "bito:" + CHR(13) + ;
1138:                     "Erro: " + loc_oErro.Message + CHR(13) + ;

*-- Linhas 1165 a 1191:
1165:                 "Buscar Conta D" + CHR(233) + "bito")
1166: 
1167:             IF !EMPTY(loc_cGrupo)
1168:                 loc_oBusca.this_cFiltroExtra = "Grupos = " + EscaparSQL(loc_cGrupo)
1169:             ENDIF
1170:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1171:             loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
1172:             loc_oBusca.Show()
1173: 
1174:             IF loc_oBusca.this_lSelecionou
1175:                 IF USED("cursor_4c_BuscaContaD")
1176:                     SELECT cursor_4c_BuscaContaD
1177:                     loc_cCodigo    = ALLTRIM(TratarNulo(IClis, "C"))
1178:                     loc_cDescricao = ALLTRIM(TratarNulo(RClis, "C"))
1179:                     THIS.txt_4c_Conta.Value  = loc_cCodigo
1180:                     THIS.txt_4c_Dconta.Value = loc_cDescricao
1181:                 ENDIF
1182:             ENDIF
1183: 
1184:             IF USED("cursor_4c_BuscaContaD")
1185:                 USE IN cursor_4c_BuscaContaD
1186:             ENDIF
1187:             loc_oBusca.Release()
1188:             THIS.AtualizarHabilitacaoDescricoes()
1189: 
1190:         CATCH TO loc_oErro
1191:             MsgErro("Erro ao abrir lookup de conta d" + CHR(233) + "bito:" + CHR(13) + ;

*-- Linhas 1222 a 1240:
1222: 
1223:             IF loc_oBusca.this_lSelecionou
1224:                 IF USED("cursor_4c_BuscaGrupoC")
1225:                     SELECT cursor_4c_BuscaGrupoC
1226:                     loc_cCodigo    = ALLTRIM(TratarNulo(Codigos, "C"))
1227:                     loc_cDescricao = ALLTRIM(TratarNulo(Descrs, "C"))
1228:                     THIS.txt_4c_SGRUPO.Value  = loc_cCodigo
1229:                     THIS.txt_4c_Sdgrupo.Value = loc_cDescricao
1230:                 ENDIF
1231:             ENDIF
1232: 
1233:             IF USED("cursor_4c_BuscaGrupoC")
1234:                 USE IN cursor_4c_BuscaGrupoC
1235:             ENDIF
1236:             loc_oBusca.Release()
1237: 
1238:         CATCH TO loc_oErro
1239:             MsgErro("Erro ao abrir lookup de grupo cr" + CHR(233) + "dito:" + CHR(13) + ;
1240:                     "Erro: " + loc_oErro.Message + CHR(13) + ;

*-- Linhas 1267 a 1293:
1267:                 "Buscar Conta Cr" + CHR(233) + "dito")
1268: 
1269:             IF !EMPTY(loc_cGrupo)
1270:                 loc_oBusca.this_cFiltroExtra = "Grupos = " + EscaparSQL(loc_cGrupo)
1271:             ENDIF
1272:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1273:             loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
1274:             loc_oBusca.Show()
1275: 
1276:             IF loc_oBusca.this_lSelecionou
1277:                 IF USED("cursor_4c_BuscaContaC")
1278:                     SELECT cursor_4c_BuscaContaC
1279:                     loc_cCodigo    = ALLTRIM(TratarNulo(IClis, "C"))
1280:                     loc_cDescricao = ALLTRIM(TratarNulo(RClis, "C"))
1281:                     THIS.txt_4c_SCONTA.Value  = loc_cCodigo
1282:                     THIS.txt_4c_SDCONTA.Value = loc_cDescricao
1283:                 ENDIF
1284:             ENDIF
1285: 
1286:             IF USED("cursor_4c_BuscaContaC")
1287:                 USE IN cursor_4c_BuscaContaC
1288:             ENDIF
1289:             loc_oBusca.Release()
1290:             THIS.AtualizarHabilitacaoDescricoes()
1291: 
1292:         CATCH TO loc_oErro
1293:             MsgErro("Erro ao abrir lookup de conta cr" + CHR(233) + "dito:" + CHR(13) + ;

*-- Linhas 1361 a 1379:
1361:             ELSE
1362:                 IF THIS.this_lAlteraJuros AND VARTYPE(THIS.grd_4c_Dados) = "O"
1363:                     IF USED("crTmpJuros") AND RECCOUNT("crTmpJuros") > 0
1364:                         SELECT crTmpJuros
1365:                         GO TOP
1366:                     ENDIF
1367:                     THIS.grd_4c_Dados.SetFocus
1368:                 ENDIF
1369:             ENDIF
1370:         CATCH TO loc_oErro
1371:             MsgErro("Erro ao posicionar foco para inclus" + CHR(227) + "o:" + CHR(13) + ;
1372:                     "Erro: " + loc_oErro.Message + CHR(13) + ;
1373:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1374:                     "FormSigReJur.BtnIncluirClick")
1375:         ENDTRY
1376:     ENDPROC
1377: 
1378:     *==========================================================================
1379:     * BtnAlterarClick - Form OPERACIONAL: posiciona foco na grade para edicao

*-- Linhas 1392 a 1410:
1392: 
1393:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1394:                 IF USED("crTmpJuros") AND RECCOUNT("crTmpJuros") > 0
1395:                     SELECT crTmpJuros
1396:                     IF EOF()
1397:                         GO TOP
1398:                     ENDIF
1399:                 ENDIF
1400:                 THIS.grd_4c_Dados.SetFocus
1401:             ENDIF
1402:         CATCH TO loc_oErro
1403:             MsgErro("Erro ao ativar modo altera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1404:                     "Erro: " + loc_oErro.Message + CHR(13) + ;
1405:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1406:                     "FormSigReJur.BtnAlterarClick")
1407:         ENDTRY
1408:     ENDPROC
1409: 
1410:     *==========================================================================

*-- Linhas 1449 a 1502:
1449:             RETURN
1450:         ENDIF
1451: 
1452:         SELECT crTmpJuros
1453:         IF RECCOUNT() = 0 OR EOF() OR BOF()
1454:             MsgAviso("Nenhum registro selecionado.", ;
1455:                      "Aten" + CHR(231) + CHR(227) + "o")
1456:             RETURN
1457:         ENDIF
1458: 
1459:         loc_lConfirma = MsgConfirma("Confirma zerar os juros desta linha?", ;
1460:                                     "Confirma" + CHR(231) + CHR(227) + "o")
1461:         IF !loc_lConfirma
1462:             RETURN
1463:         ENDIF
1464: 
1465:         TRY
1466:             SELECT crTmpJuros
1467:             REPLACE Hists WITH SPACE(LEN(Hists))
1468:             REPLACE Juros WITH 0
1469:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1470:                 THIS.grd_4c_Dados.Refresh
1471:             ENDIF
1472:         CATCH TO loc_oErro
1473:             MsgErro("Erro ao zerar juros da linha:" + CHR(13) + ;
1474:                     "Erro: " + loc_oErro.Message + CHR(13) + ;
1475:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1476:                     "FormSigReJur.BtnExcluirClick")
1477:         ENDTRY
1478:     ENDPROC
1479: 
1480:     *==========================================================================
1481:     * CarregarLista - Refresca o grid de juros a partir de crTmpJuros
1482:     *==========================================================================
1483:     PROCEDURE CarregarLista()
1484:         LOCAL loc_oErro
1485:         TRY
1486:             IF USED("crTmpJuros") AND VARTYPE(THIS.grd_4c_Dados) = "O"
1487:                 SELECT crTmpJuros
1488:                 GO TOP
1489:                 THIS.grd_4c_Dados.Refresh
1490:             ENDIF
1491:         CATCH TO loc_oErro
1492:             MsgErro("Erro ao carregar lista:" + CHR(13) + ;
1493:                     "Erro: " + loc_oErro.Message + CHR(13) + ;
1494:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1495:                     "FormSigReJur.CarregarLista")
1496:         ENDTRY
1497:     ENDPROC
1498: 
1499:     *==========================================================================
1500:     * AjustarBotoesPorModo - Form OPERACIONAL sem modos: nao altera botoes
1501:     *==========================================================================
1502:     PROCEDURE AjustarBotoesPorModo()

*-- Linhas 1605 a 1623:
1605:                 loc_cContaD = ALLTRIM(THIS.txt_4c_Conta.Value)
1606: 
1607:                 IF !EMPTY(loc_cGrupoD) OR !EMPTY(loc_cContaD)
1608:                     SELECT crTmpJuros
1609:                     GO TOP
1610:                     DO WHILE !EOF()
1611:                         IF !EMPTY(loc_cGrupoD)
1612:                             REPLACE Grupos WITH loc_cGrupoD
1613:                         ENDIF
1614:                         IF !EMPTY(loc_cContaD)
1615:                             REPLACE Contas WITH loc_cContaD
1616:                         ENDIF
1617:                         SKIP
1618:                     ENDDO
1619:                 ENDIF
1620:             ENDIF
1621:         CATCH TO loc_oErro
1622:             MsgErro("Erro ao propagar dados para cursor:" + CHR(13) + ;
1623:                     "Erro: " + loc_oErro.Message + CHR(13) + ;


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
                       " WHERE Grupos = " + EscaparSQL(par_cGrupo) + ;
                       " AND   IClis  = " + EscaparSQL(par_cConta)
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
                        loc_lAtiva = (NVL(Inativas, 0) = 0)
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
                       " WHERE Grupos = " + EscaparSQL(par_cGrupo) + ;
                       " AND   IClis  = " + EscaparSQL(par_cConta)
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

