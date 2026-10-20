# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIMPFABS, TIPOS, PORTAS, _PNAUTENTICA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FPAGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIMPFABS, TIPOS, PORTAS, _PNAUTENTICA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIMPFABS, TIPOS, PORTAS, _PNAUTENTICA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NDOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIMPFABS, TIPOS, PORTAS, _PNAUTENTICA

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
			ThisForm.ParentForm.poDataMgr.SqlExecute([Select cModelos From SigFiMpF Where cImpFabs = '] + fDecriptografar(lcNoSerie) + ['], [crTmpImpF])
		Select * From crSigSyCom Where Tipos = 'Impressora de Cheque' Into Cursor CrTmpCfCom ReadWrite
		Select CrTmpCfCom
Select CrSigFiFis
	Select CrTmpPar
			Insert into csPgto from Memvar
		Select CrTmpEstPe
				Insert into csPgto from Memvar
Select csPgto
Select csPgto
		.Column1.ControlSource = 'csPgto.marca'
		.Column2.ControlSource = 'csPgto.Obs'
		.Column3.ControlSource = 'csPgto.fPags'
Select csPgto
Select csPgto
			Select csPgto

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpAut.prg) - TRECHOS RELEVANTES PARA PASS SQL (1448 linhas total):

*-- Linhas 273 a 319:
273:     * ColumnCount=3, Column1=Check1 (Marca), Column2/Column3=Text1 (Obs/Fpags),
274:     * os dois ultimos ReadOnly. Cria o cursor cursor_4c_Pagamentos com a MESMA
275:     * estrutura/ordem de campos de SigOpAutBO.this_cCursorPagamentos (regra
276:     * CLAUDE.md: CREATE CURSOR identico em todo lugar onde o mesmo alias
277:     * aparece) - equivale ao Load legado:
278:     *   Create Cursor csPgto (Marca L, Obs C(27), fpags C(12), Printed L,
279:     *                         Autenticas n(1))
280:     *
281:     * Aqui ficam SO as propriedades de desenho do Grd (as que nao dependem do
282:     * cursor). O vinculo (ColumnCount/RecordSource/ControlSource/Width/
283:     * CurrentControl) mora em VincularGrade(), porque tambem tem de rodar
284:     * DEPOIS de cada carga de dados.
285:     *--------------------------------------------------------------------------
286:     PROTECTED PROCEDURE ConfigurarGrid()
287:         LOCAL loc_oErro
288:         TRY
289:             IF !USED("cursor_4c_Pagamentos")
290:                 CREATE CURSOR cursor_4c_Pagamentos (Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))
291:             ENDIF
292: 
293:             THIS.AddObject("grd_4c_Dados", "Grid")
294:             WITH THIS.grd_4c_Dados
295:                 .Top               = 85
296:                 .Left              = 12
297:                 .Width             = 527
298:                 .Height            = 228
299:                 .TabIndex          = 1
300:                 .FontName          = "Tahoma"
301:                 .FontSize          = 8
302:                 .AllowHeaderSizing = .F.
303:                 .AllowRowSizing    = .F.
304:                 .DeleteMark        = .F.
305:                 .RecordMark        = .F.
306:                 .RowHeight         = 16
307:                 .ScrollBars        = 2
308:                 *-- O dump do SCX traz "SplitBar = .F.", mas Grid.SplitBar eh
309:                 *-- READ-ONLY em runtime (medido no VFP9: "Property SPLITBAR
310:                 *-- is read-only") - atribuir aborta o resto deste WITH dentro
311:                 *-- do TRY e as propriedades seguintes somem em silencio. O
312:                 *-- default ja eh .F. sem split, entao omitir eh fiel.
313:                 .Panel             = 1
314:                 .GridLineColor     = RGB(238, 238, 238)
315:                 *-- Grid.ReadOnly ANTES do ReadOnly de cada Column (regra
316:                 *-- CLAUDE.md #18/#46): o do Grid propaga e sobrescreve o das
317:                 *-- colunas. No legado so Column2/Column3 sao ReadOnly;
318:                 *-- Column1 (Marca) tem de aceitar o clique do usuario.
319:                 .ReadOnly          = .F.

*-- Linhas 334 a 369:
334:     *   With ThisForm.Grd
335:     *       .RecordSource          = 'csPgto'
336:     *       .RecordSourceType      = 1
337:     *       .Column1.ControlSource = 'csPgto.marca'
338:     *       .Column2.ControlSource = 'csPgto.Obs'
339:     *       .Column3.ControlSource = 'csPgto.fPags'
340:     *       .Refresh
341:     *   EndWith
342:     *
343:     * PUBLIC e idempotente de proposito: SigOpAutBO.PopularCursorPagamentos()
344:     * faz USE IN + CREATE CURSOR no alias da grade, e derrubar o alias leva o
345:     * Grid a ColumnCount = 0 - retangulo branco sem cabecalho, sem erro e sem
346:     * log, morto pelo resto da vida do form. Por isso TODO caminho que popula
347:     * o cursor chama este metodo depois. O CheckBox da Column1 tambem eh
348:     * reinstalado aqui, porque reconstruir o ColumnCount cria objetos Column
349:     * novos (CurrentControl volta a "Text1").
350:     *
351:     * Ordem obrigatoria: ColumnCount -> RecordSource -> ControlSource ->
352:     * Width/Header (RecordSource recalcula as larguras para o default 90) e,
353:     * na Column1, AddObject -> propriedades do CheckBox -> CurrentControl ->
354:     * ControlSource por ULTIMO (ControlSource antes do AddObject dispara o
355:     * erro 1767).
356:     *--------------------------------------------------------------------------
357:     PROCEDURE VincularGrade()
358:         LOCAL loc_oErro, loc_oGrd, loc_lOk
359:         loc_lOk = .F.
360: 
361:         TRY
362:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Pagamentos")
363:                 loc_oGrd = THIS.grd_4c_Dados
364: 
365:                 *-- ColumnCount so eh reatribuido quando difere do esperado:
366:                 *-- REDUZIR destroi os controles postos por AddObject nas
367:                 *-- Columns (medido no VFP9); subir de 0 - que eh o estado
368:                 *-- depois do alias ser derrubado - eh justamente o caso que
369:                 *-- este metodo existe para consertar. Vem ANTES do

*-- Linhas 411 a 455:
411:                 loc_oGrd.Column1.chk_4c_Marca.Width     = 22
412: 
413:                 loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
414:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Pagamentos.Marca"
415: 
416:                 *-- Column2 - Text1 do legado (csPgto.Obs), ReadOnly/ColumnOrder=3
417:                 loc_oGrd.Column2.FontSize      = 8
418:                 loc_oGrd.Column2.Movable       = .F.
419:                 loc_oGrd.Column2.Resizable     = .F.
420:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Pagamentos.Obs"
421:                 loc_oGrd.Column2.ReadOnly      = .T.
422:                 loc_oGrd.Column2.Text1.FontSize    = 8
423:                 loc_oGrd.Column2.Text1.BorderStyle = 0
424:                 loc_oGrd.Column2.Text1.Margin      = 0
425:                 loc_oGrd.Column2.Text1.ReadOnly    = .T.
426:                 loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
427:                 loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)
428: 
429:                 *-- Column3 - Text1 do legado (csPgto.fPags), ReadOnly/ColumnOrder=2
430:                 loc_oGrd.Column3.FontSize      = 8
431:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Pagamentos.Fpags"
432:                 loc_oGrd.Column3.ReadOnly      = .T.
433:                 loc_oGrd.Column3.Text1.FontSize    = 8
434:                 loc_oGrd.Column3.Text1.BorderStyle = 0
435:                 loc_oGrd.Column3.Text1.Margin      = 0
436:                 loc_oGrd.Column3.Text1.ReadOnly    = .T.
437:                 loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
438:                 loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
439: 
440:                 *-- Width/Header DEPOIS do RecordSource e dos ControlSource,
441:                 *-- senao o VFP devolve as larguras para o default 90
442:                 loc_oGrd.Column1.Width = 17
443:                 loc_oGrd.Column2.Width = 382
444:                 loc_oGrd.Column3.Width = 94
445: 
446:                 *-- Headers sem texto no legado (Caption = "", Alignment = 2)
447:                 loc_oGrd.Column1.Header1.FontSize  = 8
448:                 loc_oGrd.Column1.Header1.Alignment = 2
449:                 loc_oGrd.Column1.Header1.Caption   = ""
450:                 loc_oGrd.Column2.Header1.FontSize  = 8
451:                 loc_oGrd.Column2.Header1.Alignment = 2
452:                 loc_oGrd.Column2.Header1.Caption   = ""
453:                 loc_oGrd.Column3.Header1.FontSize  = 8
454:                 loc_oGrd.Column3.Header1.Alignment = 2
455:                 loc_oGrd.Column3.Header1.Caption   = ""

*-- Linhas 461 a 480:
461:                 loc_oGrd.Column2.ColumnOrder = 3
462: 
463:                 *-- Popular cursor NAO repinta a grade (regra CLAUDE.md #21):
464:                 *-- o legado fecha com Select csPgto / Go Top / .Refresh
465:                 SELECT cursor_4c_Pagamentos
466:                 GO TOP
467:                 loc_oGrd.Refresh()
468: 
469:                 *-- Os 4 handlers do CheckBox sao (re)ligados AQUI, e nao no
470:                 *-- InicializarForm: reconstruir o ColumnCount destroi os
471:                 *-- objetos Column e leva o chk_4c_Marca junto, e com ele os
472:                 *-- BINDEVENT. Ligados uma unica vez na inicializacao, o
473:                 *-- CheckBox ficaria inerte depois da primeira recarga.
474:                 THIS.LigarEventosGrade()
475: 
476:                 loc_lOk = .T.
477:             ENDIF
478:         CATCH TO loc_oErro
479:             MsgErro(loc_oErro.Message + CHR(13) + ;
480:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 546 a 574:
546:     * Aqui o toggle nativo foi suprimido (NODEFAULT nos handlers), entao ele eh
547:     * refeito explicitamente ANTES da regra - o resultado final eh identico.
548:     *
549:     * Marca e Printed sao LOGICOS no cursor (legado: "Create Cursor csPgto
550:     * (Marca L, Obs C(27), fpags C(12), Printed L, Autenticas n(1))"), por isso
551:     * a alternancia eh "!valor" e NAO o IIF(col = 0, 1, 0) usado quando a
552:     * coluna de marcacao eh numerica.
553:     *--------------------------------------------------------------------------
554:     PROCEDURE ValidarMarcacaoLinha()
555:         LOCAL loc_oErro
556: 
557:         TRY
558:             IF USED("cursor_4c_Pagamentos")
559:                 SELECT cursor_4c_Pagamentos
560:                 IF !EOF("cursor_4c_Pagamentos") AND !BOF("cursor_4c_Pagamentos")
561:                     REPLACE cursor_4c_Pagamentos.Marca ;
562:                         WITH !cursor_4c_Pagamentos.Marca
563: 
564:                     IF !cursor_4c_Pagamentos.Printed
565:                         REPLACE cursor_4c_Pagamentos.Marca WITH .T.
566:                     ENDIF
567: 
568:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
569:                         THIS.grd_4c_Dados.Refresh()
570:                     ENDIF
571:                 ENDIF
572:             ENDIF
573:         CATCH TO loc_oErro
574:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 854 a 882:
854:     *--------------------------------------------------------------------------
855:     * CarregarDados - Carga da grade. Equivale ao bloco de consulta do Init
856:     * legado, transcrito do dump:
857:     *   =fLerFiscal() / Select CrSigFiFis / Goto top
858:     *   If Not _pTipo
859:     *       cursorquery('SigMvPar','CrTmpPar','EmpDopNums',lcEDN) + SigOpFp
860:     *   Else
861:     *       cursorquery('SigMvPec','CrTmpEstPe','EmpDopNums',lcEDN) + SigCdOpe
862:     *   EndIf
863:     *   If ( Alltrim(CrSigFiFis.Imps) = 'DARUMA' And _PnAutentica = 1 ) Or ;
864:     *      ( _PnAutentica <> 1 And Not ThisForm.ParentForm.TemAutentica )
865:     *       Zap
866:     *   EndIf
867:     *   Select csPgto / Go Top
868:     *   If Reccount() = 0 / ThisForm.Release / Return .F. / Endif
869:     *   With ThisForm / With .Grd / ... bind ... / EndWith / EndWith
870:     *
871:     * O SQL mora no BO (SigOpAutBO.PopularCursorPagamentos e
872:     * ZerarSeNaoRequerAutenticacao); no form ficam a leitura da configuracao
873:     * de hardware, a regra TemAutentica que vem do form pai, o revinculo da
874:     * grade e a decisao de nao abrir a tela.
875:     *
876:     * Retorna .F. quando nao sobrou linha alguma para autenticar: eh o
877:     * "ThisForm.Release + Return .F." do legado, propagado por InicializarForm
878:     * (CREATEOBJECT devolve .F. e a tela nao abre, sem mensagem - igual ao
879:     * legado, que fecha calado).
880:     *--------------------------------------------------------------------------
881:     PROCEDURE CarregarDados()
882:         LOCAL loc_oErro, loc_lOk, loc_oBO, loc_uTemAut

*-- Linhas 915 a 933:
915:                         *-- autenticacao
916:                         loc_oBO.ZerarSeNaoRequerAutenticacao(THIS.ObterModeloImpressoraFiscal())
917: 
918:                         *-- PopularCursorPagamentos faz USE IN + CREATE CURSOR
919:                         *-- no alias da grade: sem revincular, o Grid fica em
920:                         *-- ColumnCount = 0 e vira um retangulo branco
921:                         THIS.VincularGrade()
922: 
923:                         *-- Legado: If Reccount() = 0 / ThisForm.Release / Return .F.
924:                         loc_lOk = (RECCOUNT("cursor_4c_Pagamentos") > 0)
925:                     ELSE
926:                         IF !EMPTY(loc_oBO.this_cMensagemErro)
927:                             MsgErro(loc_oBO.this_cMensagemErro, ;
928:                                 "Autentica" + CHR(231) + CHR(227) + "o")
929:                         ENDIF
930:                         loc_lOk = .F.
931:                     ENDIF
932:                 ENDIF
933:             ENDIF

*-- Linhas 942 a 960:
942:     ENDPROC
943: 
944:     *--------------------------------------------------------------------------
945:     * ObterModeloImpressoraFiscal - Legado (Init): "=fLerFiscal() / Select
946:     * CrSigFiFis / Goto top", consumido depois em Alltrim(CrSigFiFis.Imps).
947:     *
948:     * fLerFiscal() eh funcao global do Fortyus que NAO existe no acervo
949:     * portado - chama-la daria "File 'flerfiscal.prg' does not exist" em
950:     * runtime (nome desconhecido seguido de "(" nao eh erro de compilacao,
951:     * regra CLAUDE.md #13). O equivalente portado eh
952:     * FisBO.CarregarDeArquivo(), que le o mesmo SetFiscal.Ini e popula o mesmo
953:     * cursor CrSigFiFis; eh usado so quando o cursor ainda nao esta aberto,
954:     * para nao sobrescrever uma configuracao fiscal ja carregada por outra
955:     * tela.
956:     *
957:     * Modelo vazio apenas nao casa com o teste 'DARUMA' do legado - nao
958:     * impede autenticar.
959:     *--------------------------------------------------------------------------
960:     PROTECTED PROCEDURE ObterModeloImpressoraFiscal()

*-- Linhas 971 a 989:
971:             ENDIF
972: 
973:             IF USED("CrSigFiFis")
974:                 SELECT CrSigFiFis
975:                 GO TOP
976:                 IF !EOF() AND VARTYPE(CrSigFiFis.Imps) = "C"
977:                     loc_cModelo = ALLTRIM(CrSigFiFis.Imps)
978:                 ENDIF
979:             ENDIF
980:         CATCH TO loc_oErro
981:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler a " + ;
982:                 "configura" + CHR(231) + CHR(227) + "o da impressora fiscal:" + ;
983:                 CHR(13) + loc_oErro.Message, ;
984:                 "Autentica" + CHR(231) + CHR(227) + "o")
985:             loc_cModelo = ""
986:         ENDTRY
987: 
988:         RETURN loc_cModelo
989:     ENDPROC

*-- Linhas 1061 a 1079:
1061: 
1062:     *--------------------------------------------------------------------------
1063:     * BtnSairClick - cmd_4c_Sair.Click. Legado (Sair.Click):
1064:     *   Select csPgto / If Reccount() > 0 / Go top / Scan
1065:     *       if !(csPgto.Printed)
1066:     *           .Grd.Refresh / .Grd.Column1.SetFocus
1067:     *           MessageBox("Autenticacao Obrigatoria",16,"") / Return
1068:     *       endif
1069:     *   EndScan / EndIf
1070:     *   ldtime = DateTime() / Do While DateTime()-ldtime<=2 / =chrsaw(.5) / EndDo
1071:     *   ThisForm.Release
1072:     *
1073:     * ExisteLinhaNaoAutenticada() (BO) reproduz o Scan/Locate For !Printed.
1074:     * chrsaw(.5) em loop (funcao global do Fortyus nao portada - so dava
1075:     * tempo ao SO processar a tela) -> DOEVENTS no lugar, mesmo efeito
1076:     * pratico. MESSAGEBOX legado -> MsgAviso (regra CLAUDE.md "MESSAGEBOX
1077:     * PROIBIDO").
1078:     *--------------------------------------------------------------------------
1079:     PROCEDURE BtnSairClick()

*-- Linhas 1105 a 1123:
1105:     *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
1106:     *       ThisForm.Sair.Setfocus
1107:     *   Endif
1108:     *   Select csPgto / go Top / Scan
1109:     *       If csPgto.marca
1110:     *           lOk = ThisForm.Autentica(csPgto.Autenticas)
1111:     *           if lOk
1112:     *               Replace csPgto.marca with .f., csPgto.Printed with .t.
1113:     *           EndIf
1114:     *       EndIf
1115:     *   EndScan
1116:     *
1117:     * O legado NAO interrompe o fluxo quando o cursor esta vazio (apenas
1118:     * mostra o aviso e tenta focar Sair; o Scan seguinte nao executa nada
1119:     * num cursor vazio) - mesmo efeito reproduzido aqui.
1120:     *--------------------------------------------------------------------------
1121:     PROCEDURE BtnImprimirClick()
1122:         LOCAL loc_lOk, loc_oErro
1123: 

*-- Linhas 1136 a 1165:
1136:             ENDIF
1137: 
1138:             IF USED("cursor_4c_Pagamentos")
1139:                 SELECT cursor_4c_Pagamentos
1140:                 GO TOP
1141:                 SCAN
1142:                     IF cursor_4c_Pagamentos.Marca
1143:                         loc_lOk = THIS.Autentica(cursor_4c_Pagamentos.Autenticas)
1144:                         IF loc_lOk
1145:                             THIS.this_oBusinessObject.MarcarLinhaAutenticada()
1146:                         ENDIF
1147:                     ENDIF
1148:                 ENDSCAN
1149: 
1150:                 SELECT cursor_4c_Pagamentos
1151:                 GO TOP
1152:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1153:                     THIS.grd_4c_Dados.Refresh()
1154:                 ENDIF
1155:             ENDIF
1156:         CATCH TO loc_oErro
1157:             MsgErro(loc_oErro.Message + CHR(13) + ;
1158:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1159:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.BtnImprimirClick")
1160:         ENDTRY
1161:     ENDPROC
1162: 
1163:     *--------------------------------------------------------------------------
1164:     * FormParaBO - Transferencia FORM -> BO.
1165:     *

*-- Linhas 1175 a 1193:
1175:     *     SigOpAutBO.CarregarDoCursor (o legado le csPgto.marca/.Autenticas
1176:     *     direto do cursor dentro do Scan do botao Imprimir).
1177:     *
1178:     * CarregarDoCursor NAO move o ponteiro (so SELECT + leitura dos campos),
1179:     * por isso FormParaBO pode ser chamado de DENTRO do SCAN de
1180:     * BtnImprimirClick sem quebrar a varredura.
1181:     *
1182:     * Retorna .F. quando o BO ainda nao existe - BtnImprimirClick e Autentica
1183:     * chamam este metodo e nao podem presumir sucesso.
1184:     *
1185:     * PROTECTED EXPLICITO, e nao por estilo: FormBase.prg declara
1186:     * "PROTECTED PROCEDURE FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR
1187:     * o escopo herdado - escrever "PROCEDURE FormParaBO" aqui deixaria o
1188:     * metodo protegido do mesmo jeito e mentiria para quem le. Consequencia
1189:     * pratica: so da para chama-lo por THIS. de dentro da classe; harness que
1190:     * precise exerce-lo tem de faze-lo por uma subclasse (ver
1191:     * automation\ProbeAut644F8.prg), nunca de um script solto - PEMSTATUS com
1192:     * o 3o argumento 5 responde "existe?", nao "da para chamar daqui?".
1193:     *--------------------------------------------------------------------------

*-- Linhas 1231 a 1249:
1231:     *
1232:     * A grade NAO eh repintada a partir das properties this_*Linha*: elas sao
1233:     * uma FOTO da linha corrente (leitura), e quem desenha as linhas eh o
1234:     * ControlSource do Grid ligado ao proprio cursor. Reescrever o cursor a
1235:     * partir da foto sobrescreveria as outras linhas com a corrente.
1236:     *
1237:     * PROTECTED EXPLICITO pela mesma razao de FormParaBO acima (FormBase
1238:     * declara o nome como PROTECTED e o escopo herdado nao se alarga).
1239:     *--------------------------------------------------------------------------
1240:     PROTECTED PROCEDURE BOParaForm()
1241:         LOCAL loc_lOk, loc_oBO, loc_oErro
1242:         loc_lOk = .F.
1243: 
1244:         TRY
1245:             loc_oBO = THIS.this_oBusinessObject
1246: 
1247:             IF VARTYPE(loc_oBO) = "O"
1248:                 IF PEMSTATUS(THIS, "txt_4c_TxtObs", 5)
1249:                     THIS.txt_4c_TxtObs.Value = NVL(loc_oBO.this_cObservacao, "")


### BO (C:\4c\projeto\app\classes\SigOpAutBO.prg):
*====================================================================
* SigOpAutBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPAUT" (Autenticacao de
* comprovantes de pagamento/cheque na impressora fiscal ou na
* impressora de cheque via porta serial/OLE).
*
* O legado abre este form como filho MODAL de outro form (Lparameters
* poform, _pEmps, _pDopes, _pNumes, _pTipo, _pnAutentica), monta um
* cursor LOCAL (csPgto: Marca L, Obs C(27), Fpags C(12), Printed L,
* Autenticas N(1)) a partir de SigMvPar (pagamentos) ou SigMvPec
* (parcelas), conforme _pTipo, e deixa o usuario marcar/autenticar
* cada linha antes de liberar o caixa.
*
* Nao existe uma unica tabela "mestre" - a origem dos dados depende do
* tipo de movimento (_pTipo): SigMvPar quando .F., SigMvPec quando .T.
* THIS.this_cTabela acompanha essa escolha (AtualizarTabelaOrigem).
*
* Referencias legado -> BO:
*   Thisform.toSeek       -> this_cToSeek      (EmpDopNums posicional)
*   Thisform.Primeiravez  -> this_lPrimeiraVez
*   Thisform.tpAutentica  -> this_nTipoAutentica (= Lparameters _pnAutentica)
*   csPgto (cursor local) -> this_cCursorPagamentos ("cursor_4c_Pagamentos")
*
* Thisform.oModem e Thisform.ParentForm permanecem no FORM (sao
* referencias a objetos de UI/OLE do form pai, fora da responsabilidade
* do Business Object).
*
* Herda de: BusinessBase
*
* Fase 2/8 - Nao ha INSERT/UPDATE/DELETE no legado deste dialogo: o unico
* codigo-fonte (Init/autentica/Sair.Click/Fwbtnm1.Click, ver
* tasks\task644\comportamento.json) so CONSULTA SigMvPar/SigMvPec/SigOpFp/
* SigCdOpe/SigMvCab (CursorQuery) e grava no CURSOR LOCAL csPgto (Replace
* marca/Printed) ou na porta serial/impressora fiscal (ImpVerso/Autentica/
* ReAutentica, via ThisForm.oModem) - nunca num INSERT/UPDATE em tabela.
* Por isso Inserir()/Atualizar()/ExecutarExclusao() permanecem SEM
* override: o comportamento padrao herdado de BusinessBase (recusar a
* operacao) ja eh o correto - inventar SQL de gravacao aqui violaria a
* regra de que a lista de colunas vem do schema/legado, nunca de
* suposicao, e este dialogo nunca grava em tabela nenhuma.
*
* Completado em: Fase 2 - PopularCursorPagamentos()/CarregarDoCursor()/
* ObterTextoAutenticacao()/ZerarSeNaoRequerAutenticacao()/
* ExisteLinhaNaoAutenticada()/MarcarLinhaAutenticada()/
* ObterChavePrimaria()
*====================================================================

DEFINE CLASS SigOpAutBO AS BusinessBase

    *-- Parametros recebidos na abertura do dialogo (legado: Lparameters
    *-- poform, _pEmps, _pDopes, _pNumes, _pTipo, _pnAutentica)
    this_cEmps             = ""    && Empresa (SigMvPar.emps / SigMvPec.emps)
    this_cDopes            = ""    && Documento de Operacao (SigCdOpe.dopes)
    this_nNumes            = 0     && Numero do movimento (SigMvPar.numes / SigMvPec.numes)
    this_lTipoPec          = .F.   && .T. = consulta SigMvPec (parcela) / .F. = consulta SigMvPar (pagamento) - legado "_pTipo"
    this_nTipoAutentica    = 0     && Tipo de autenticacao solicitada - legado "_pnAutentica"/"tpAutentica" (1 = impressora fiscal/cheque)

    *-- Estado de controle equivalente ao do form legado
    this_cToSeek           = ""    && Chave posicional EmpDopNums = PADR(Emps,3)+PADR(Dopes,20)+STR(Numes,6) - legado "toSeek"
    this_lPrimeiraVez      = .T.   && Controla a reautenticacao na 1a chamada a impressora fiscal - legado "Primeiravez"
    this_lTemAutentica     = .F.   && Espelha ParentForm.TemAutentica (config exige autenticar antes de liberar)
    this_cObservacao       = ""    && Texto digitado em TxtObs, impresso junto da autenticacao

    *-- Cursor de trabalho (equivalente ao csPgto local do legado:
    *-- Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))
    this_cCursorPagamentos = "cursor_4c_Pagamentos"
    this_nTotalPagamentos  = 0     && RECCOUNT() do cursor apos PopularCursorPagamentos()

    *-- Espelham a linha ATUAL de this_cCursorPagamentos (carregados por
    *-- CarregarDoCursor) - mesmos nomes/tipos das colunas do csPgto legado
    this_lLinhaMarca       = .F.   && Marca (L) - linha selecionada para autenticar
    this_cLinhaObs         = ""    && Obs (C(27)) - texto exibido na coluna 2 do Grd
    this_cLinhaFpags       = ""    && Fpags (C(12)) - forma de pagamento/codigo da parcela
    this_lLinhaImpressa    = .F.   && Printed (L) - .T. apos autenticar com sucesso
    this_nLinhaAutenticas  = 0     && Autenticas (N(1)) - tipo exigido por SigOpFp/SigCdOpe

    *-- Configuracao da porta serial da impressora de cheque (legado:
    *-- crTmpCfCom.Portas/Settings, lido de SigSyCom - ver
    *-- ObterConfigPortaCheque) - consumidos por FormSigOpAut.Autentica()
    this_nPortaCheque      = 0     && SigSyCom.Portas (WHERE Tipos = 'Impressora de Cheque')
    this_cSettingsCheque   = ""    && SigSyCom.Settings (mesma linha)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Parametros equivalentes ao Lparameters poform, _pEmps, _pDopes, _pNumes,
    * _pTipo, _pnAutentica do Init do form legado - o form migrado repassa so
    * os valores escalares; poform/oModem (objetos de UI) ficam no Form.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_lTipoPec, par_nTipoAutentica)
        DODEFAULT("SigMvPar")

        THIS.this_cCampoChave = "cidchaves"

        IF VARTYPE(par_cEmps) = "C"
            THIS.this_cEmps = par_cEmps
        ENDIF

        IF VARTYPE(par_cDopes) = "C"
            THIS.this_cDopes = par_cDopes
        ENDIF

        IF VARTYPE(par_nNumes) = "N"
            THIS.this_nNumes = par_nNumes
        ENDIF

        IF VARTYPE(par_nTipoAutentica) = "N"
            THIS.this_nTipoAutentica = par_nTipoAutentica
        ENDIF

        THIS.this_lPrimeiraVez = .T.

        THIS.AtualizarTabelaOrigem(IIF(VARTYPE(par_lTipoPec) = "L", par_lTipoPec, .F.))
        THIS.AtualizarChaveBusca()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarChaveBusca - Recalcula this_cToSeek (legado "toSeek") a partir
    * de Emps/Dopes/Numes. Chave POSICIONAL (regra CLAUDE.md #42): PADR
    * explicito em cada parte, NUNCA ALLTRIM - o padding faz parte da chave e
    * eh o que casa com a coluna EmpDopNums char(29) de SigMvPar/SigMvPec/
    * SigMvCab (emps char(3) + dopes char(20) + Str(numes,6) = 29).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarChaveBusca()
        THIS.this_cToSeek = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
        RETURN THIS.this_cToSeek
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTabelaOrigem - Define a tabela de origem conforme o tipo de
    * movimento (legado SIGOPAUT.Init: "If Not _pTipo" consulta SigMvPar/
    * pagamentos; senao consulta SigMvPec/parcelas). A chave de filtro nos
    * dois casos eh EmpDopNums (this_cToSeek), a chave primaria eh cidchaves.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTabelaOrigem(par_lTipoPec)
        IF VARTYPE(par_lTipoPec) != "L"
            RETURN .F.
        ENDIF

        THIS.this_lTipoPec = par_lTipoPec

        IF THIS.this_lTipoPec
            THIS.this_cTabela = "SigMvPec"
        ELSE
            THIS.this_cTabela = "SigMvPar"
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Este dialogo nao edita uma unica linha de uma
    * unica tabela (regra PROTECTED/BusinessBase #51): opera sobre VARIAS
    * linhas de SigMvPar/SigMvPec, todas sob o mesmo EmpDopNums. A chave
    * mais proxima de "registro em edicao" eh essa chave posicional - fica
    * disponivel so por completude de contrato (RegistrarAuditoria nunca eh
    * chamado, porque Inserir/Atualizar nao sao sobrescritos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cToSeek)
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularCursorPagamentos - Equivalente ao bloco de consulta do Init()
    * legado: (re)cria this_cCursorPagamentos (csPgto: Marca L, Obs C(27),
    * Fpags C(12), Printed L, Autenticas N(1)) e popula a partir de
    * SigMvPar (this_lTipoPec = .F.) ou SigMvPec (this_lTipoPec = .T.),
    * filtrando por EmpDopNums = this_cToSeek e por this_nTipoAutentica.
    *
    * Fica de fora (responsabilidade do FORM, que tem ParentForm/oModem):
    * - fLerFiscal()/CrSigFiFis (config de impressora fiscal - funcao
    *   global legado nao portada, ver ZerarSeNaoRequerAutenticacao abaixo)
    * - qualquer comunicacao com hardware (porta serial, impressora)
    *--------------------------------------------------------------------------
    FUNCTION PopularCursorPagamentos()
        LOCAL loc_lResultado, loc_nResultado, loc_nAutenticasFpg, loc_nAutenticasOpe
        LOCAL loc_cObs, loc_cFpags, loc_cCodigos10, loc_nDope, loc_nNume, loc_lPular
        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        THIS.AtualizarChaveBusca()

        TRY
            IF USED(THIS.this_cCursorPagamentos)
                USE IN (THIS.this_cCursorPagamentos)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorPagamentos) (Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))

            IF !THIS.this_lTipoPec

                *-- Legado: CursorQuery('SigMvPar','CrTmpPar','EmpDopNums',lcEDN)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Fpags, NCarnes, Outros " + ;
                    "FROM SigMvPar " + ;
                    "WHERE EmpDopNums = " + EscaparSQL(THIS.this_cToSeek), ;
                    "cursor_4c_SigOpAut_Par")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Par")
                    SELECT cursor_4c_SigOpAut_Par
                    SCAN
                        *-- Legado: CursorQuery('SigOpFp','CrTmpFpag','Fpags',CrTmpPar.Fpags)
                        *-- And InList(CrTmpFpag.Autenticas,1,3)
                        IF USED("cursor_4c_SigOpAut_Fpg")
                            USE IN cursor_4c_SigOpAut_Fpg
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT Autenticas FROM SigOpFp WHERE Fpags = " + EscaparSQL(ALLTRIM(cursor_4c_SigOpAut_Par.Fpags)), ;
                            "cursor_4c_SigOpAut_Fpg")

                        IF USED("cursor_4c_SigOpAut_Fpg") AND RECCOUNT("cursor_4c_SigOpAut_Fpg") > 0 ;
                                AND INLIST(cursor_4c_SigOpAut_Fpg.Autenticas, 1, 3)

                            loc_nAutenticasFpg = cursor_4c_SigOpAut_Fpg.Autenticas

                            *-- Legado: If _pnAutentica > 0 And _pnAutentica # m.Autenticas / Loop
                            IF THIS.this_nTipoAutentica <= 0 OR THIS.this_nTipoAutentica = loc_nAutenticasFpg
                                *-- Legado: Padr(Iif(!IsEmpty(NCarnes),'# '+Alltrim(NCarnes)+Iif(!IsEmpty(Outros),'; ',''),'')+Outros,40)
                                loc_cObs = PADR(IIF(!EMPTY(cursor_4c_SigOpAut_Par.NCarnes), ;
                                    "# " + ALLTRIM(cursor_4c_SigOpAut_Par.NCarnes) + ;
                                    IIF(!EMPTY(cursor_4c_SigOpAut_Par.Outros), "; ", ""), "") + ;
                                    cursor_4c_SigOpAut_Par.Outros, 40)

                                SELECT (THIS.this_cCursorPagamentos)
                                APPEND BLANK
                                REPLACE Marca WITH .T., ;
                                    Obs WITH loc_cObs, ;
                                    Fpags WITH cursor_4c_SigOpAut_Par.Fpags, ;
                                    Printed WITH .F., ;
                                    Autenticas WITH loc_nAutenticasFpg
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_SigOpAut_Par
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_SigOpAut_Fpg")
                    USE IN cursor_4c_SigOpAut_Fpg
                ENDIF
                IF USED("cursor_4c_SigOpAut_Par")
                    USE IN cursor_4c_SigOpAut_Par
                ENDIF

            ELSE

                *-- Legado: CursorQuery('SigCdOpe','CrTmpOpe','Dopes',_pDopes,[Autenticas])
                SQLEXEC(gnConnHandle, ;
                    "SELECT Autenticas FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)), ;
                    "cursor_4c_SigOpAut_Ope")
                loc_nAutenticasOpe = IIF(USED("cursor_4c_SigOpAut_Ope") AND RECCOUNT("cursor_4c_SigOpAut_Ope") > 0, ;
                    cursor_4c_SigOpAut_Ope.Autenticas, 0)

                *-- Legado: CursorQuery('SigMvPec','CrTmpEstPe','EmpDopNums',lcEDN)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos FROM SigMvPec WHERE EmpDopNums = " + EscaparSQL(THIS.this_cToSeek), ;
                    "cursor_4c_SigOpAut_Pec")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Pec")
                    SELECT cursor_4c_SigOpAut_Pec
                    SCAN
                        *-- Legado: _nDope = Val(Left(Str(Codigos,10),4)) / _nNume = Val(Right(Str(Codigos,10),6))
                        loc_cCodigos10 = cursor_4c_SigOpAut_Pec.Codigos
                        loc_nDope = VAL(LEFT(loc_cCodigos10, 4))
                        loc_nNume = VAL(RIGHT(loc_cCodigos10, 6))

                        *-- Legado: CursorQuery('SigCdOpe','CrTmpOpe2','ndopes',_ndope,[Dopes,CupFis])
                        IF USED("cursor_4c_SigOpAut_Ope2")
                            USE IN cursor_4c_SigOpAut_Ope2
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT Dopes, CupFis FROM SigCdOpe WHERE Ndopes = " + FormatarNumeroSQL(loc_nDope, 0), ;
                            "cursor_4c_SigOpAut_Ope2")

                        IF USED("cursor_4c_SigOpAut_Ope2") AND RECCOUNT("cursor_4c_SigOpAut_Ope2") > 0
                            loc_lPular = .F.

                            *-- Legado: If ( _pnAutentica>0 And _pnAutentica#m.Autenticas ) Or InList(CrTmpOpe2.CupFis,1,3) / Loop
                            IF THIS.this_nTipoAutentica > 0 AND THIS.this_nTipoAutentica != loc_nAutenticasOpe
                                loc_lPular = .T.
                            ENDIF
                            IF !loc_lPular AND INLIST(cursor_4c_SigOpAut_Ope2.CupFis, 1, 3)
                                loc_lPular = .T.
                            ENDIF

                            IF !loc_lPular
                                *-- Legado: m.Obs = CrTmpOpe2.dopes+' '+Str(_nNume,6) / m.Fpags = Str(CrTmpEstPe.Codigos)
                                loc_cObs   = ALLTRIM(cursor_4c_SigOpAut_Ope2.Dopes) + " " + STR(loc_nNume, 6)
                                loc_cFpags = STR(cursor_4c_SigOpAut_Pec.Codigos)

                                SELECT (THIS.this_cCursorPagamentos)
                                APPEND BLANK
                                REPLACE Marca WITH .T., ;
                                    Obs WITH loc_cObs, ;
                                    Fpags WITH loc_cFpags, ;
                                    Printed WITH .F., ;
                                    Autenticas WITH loc_nAutenticasOpe
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_SigOpAut_Pec
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_SigOpAut_Ope2")
                    USE IN cursor_4c_SigOpAut_Ope2
                ENDIF
                IF USED("cursor_4c_SigOpAut_Pec")
                    USE IN cursor_4c_SigOpAut_Pec
                ENDIF
                IF USED("cursor_4c_SigOpAut_Ope")
                    USE IN cursor_4c_SigOpAut_Ope
                ENDIF

            ENDIF

            SELECT (THIS.this_cCursorPagamentos)
            GO TOP
            THIS.this_nTotalPagamentos = RECCOUNT(THIS.this_cCursorPagamentos)
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar pagamentos/parcelas pendentes de autentica" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ZerarSeNaoRequerAutenticacao - Legado (Init, apos popular csPgto):
    *   If ( Alltrim(CrSigFiFis.Imps)='DARUMA' And _PnAutentica=1 ) Or
    *      (_PnAutentica<>1 And Not ThisForm.ParentForm.TemAutentica )
    *       Zap
    *   EndIf
    * CrSigFiFis.Imps (modelo da impressora fiscal) vem de fLerFiscal(),
    * funcao global do Fortyus NAO portada (config de hardware) - por isso
    * o modelo e o this_lTemAutentica (regra do form pai) sao recebidos
    * como parametro/property, em vez de consultados aqui.
    *--------------------------------------------------------------------------
    PROCEDURE ZerarSeNaoRequerAutenticacao(par_cModeloImpressora)
        LOCAL loc_lZerar
        loc_lZerar = .F.

        IF (UPPER(ALLTRIM(NVL(par_cModeloImpressora, ""))) = "DARUMA" AND THIS.this_nTipoAutentica = 1) ;
                OR (THIS.this_nTipoAutentica != 1 AND !THIS.this_lTemAutentica)
            loc_lZerar = .T.
        ENDIF

        IF loc_lZerar AND USED(THIS.this_cCursorPagamentos)
            SELECT (THIS.this_cCursorPagamentos)
            ZAP
            THIS.this_nTotalPagamentos = 0
        ENDIF

        RETURN loc_lZerar
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA ATUAL de this_cCursorPagamentos
    * (ou de outro alias/cursor com a mesma estrutura) para as properties
    * this_lLinha*/this_cLinha*/this_nLinha* (regra CLAUDE.md #9: SELECT
    * antes de acessar campo, nunca campo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_lLinhaMarca      = TratarNulo(Marca, .F.)
                THIS.this_cLinhaObs        = TratarNulo(Obs, "")
                THIS.this_cLinhaFpags      = TratarNulo(Fpags, "")
                THIS.this_lLinhaImpressa   = TratarNulo(Printed, .F.)
                THIS.this_nLinhaAutenticas = TratarNulo(Autenticas, 0)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarLinhaAutenticada - Legado (Fwbtnm1.Click, apos Autentica() = .T.):
    *   Replace csPgto.marca with .f., csPgto.Printed with .t.
    * Opera sobre a linha ATUAL de this_cCursorPagamentos.
    *--------------------------------------------------------------------------
    PROCEDURE MarcarLinhaAutenticada()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(THIS.this_cCursorPagamentos)
            SELECT (THIS.this_cCursorPagamentos)
            IF !EOF()
                REPLACE Marca WITH .F., Printed WITH .T.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteLinhaNaoAutenticada - Legado (Sair.Click):
    *   Scan / if !(csPgto.Printed) / MessageBox('Autenticacao Obrigatoria') / Return
    * O form chama este metodo antes de liberar o Encerrar/Sair; a mensagem
    * (MsgAviso) e o foco na grade (Grd.Column1.SetFocus) ficam no FORM.
    *--------------------------------------------------------------------------
    FUNCTION ExisteLinhaNaoAutenticada()
        LOCAL loc_lPendente
        loc_lPendente = .F.

        IF USED(THIS.this_cCursorPagamentos)
            SELECT (THIS.this_cCursorPagamentos)
            LOCATE FOR !Printed
            loc_lPendente = FOUND()
        ENDIF

        RETURN loc_lPendente
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTextoAutenticacao - Parte SQL/texto do metodo "autentica" legado
    * (a comunicacao com a impressora/porta serial fica no FORM, que detem
    * ThisForm.oModem/OleComm):
    *   If CursorQuery('SigMvCab','CrTprMvCab','EmpDopNums',toSeek)
    *       _autVal = Padc(DTOC(Date())+"-"+Time()+" - "+Left(ecfs,3)+" - "+notas,60," ")
    *   Else
    *       _autVal = Padc(DTOC(Date())+"-"+Time(),60," ")
    *   EndIf
    *--------------------------------------------------------------------------
    FUNCTION ObterTextoAutenticacao()
        LOCAL loc_cTexto, loc_nResultado

        loc_cTexto = PADC(DTOC(DATE()) + "-" + TIME(), 60, " ")

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND !EMPTY(THIS.this_cToSeek)
            TRY
                IF USED("cursor_4c_SigOpAut_Cab")
                    USE IN cursor_4c_SigOpAut_Cab
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Ecfs, Notas FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(THIS.this_cToSeek), ;
                    "cursor_4c_SigOpAut_Cab")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Cab") AND RECCOUNT("cursor_4c_SigOpAut_Cab") > 0
                    loc_cTexto = PADC(DTOC(DATE()) + "-" + TIME() + " - " + ;
                        LEFT(ALLTRIM(cursor_4c_SigOpAut_Cab.Ecfs), 3) + " - " + ;
                        ALLTRIM(cursor_4c_SigOpAut_Cab.Notas), 60, " ")
                ENDIF

                IF USED("cursor_4c_SigOpAut_Cab")
                    USE IN cursor_4c_SigOpAut_Cab
                ENDIF
            CATCH TO loc_oErro
                loc_cTexto = PADC(DTOC(DATE()) + "-" + TIME(), 60, " ")
            ENDTRY
        ENDIF

        RETURN loc_cTexto
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTipoImpressaoCheque - Legado (autentica, ramo impressora de
    * cheque):
    *   =ThisForm.parentform.PodataMgr.CursorQuery('SigCdPam','CrTmpParam',.f.,.f.,[ImpCheqs])
    * SigCdPam eh tabela de parametros unica do sistema (1 so registro) -
    * sem filtro, le a unica linha.
    *--------------------------------------------------------------------------
    FUNCTION ObterTipoImpressaoCheque()
        LOCAL loc_nResultado, loc_nValor, loc_oErro
        loc_nValor = 0

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                IF USED("cursor_4c_SigOpAut_Pam")
                    USE IN cursor_4c_SigOpAut_Pam
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT ImpCheqs FROM SigCdPam", "cursor_4c_SigOpAut_Pam")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Pam") AND RECCOUNT("cursor_4c_SigOpAut_Pam") > 0
                    loc_nValor = NVL(cursor_4c_SigOpAut_Pam.ImpCheqs, 0)
                ENDIF

                IF USED("cursor_4c_SigOpAut_Pam")
                    USE IN cursor_4c_SigOpAut_Pam
                ENDIF
            CATCH TO loc_oErro
                loc_nValor = 0
            ENDTRY
        ENDIF

        RETURN loc_nValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterConfigPortaCheque - Legado:
    *   Select * From crSigSyCom Where Tipos = 'Impressora de Cheque' Into Cursor CrTmpCfCom
    * crSigSyCom vinha pre-carregado por fLerSettings() (funcao global do
    * Fortyus NAO portada - config de hardware); como SigSyCom tambem
    * existe como tabela do banco com as MESMAS colunas (Tipos/Portas/
    * Settings - ver docs/schema.sql), a consulta eh feita direto por
    * SQLEXEC, substituindo fLerSettings() + o filtro local em UM passo.
    *--------------------------------------------------------------------------
    FUNCTION ObterConfigPortaCheque()
        LOCAL loc_nResultado, loc_lResultado, loc_oErro
        loc_lResultado = .F.
        THIS.this_nPortaCheque    = 0
        THIS.this_cSettingsCheque = ""

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                IF USED("cursor_4c_SigOpAut_Com")
                    USE IN cursor_4c_SigOpAut_Com
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Portas, Settings FROM SigSyCom WHERE Tipos = " + EscaparSQL("Impressora de Cheque"), ;
                    "cursor_4c_SigOpAut_Com")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Com") AND RECCOUNT("cursor_4c_SigOpAut_Com") > 0
                    SELECT cursor_4c_SigOpAut_Com
                    GO TOP
                    THIS.this_nPortaCheque    = NVL(Portas, 0)
                    THIS.this_cSettingsCheque = ALLTRIM(NVL(Settings, ""))
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_SigOpAut_Com")
                    USE IN cursor_4c_SigOpAut_Com
                ENDIF
            CATCH TO loc_oErro
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterModeloInternoPorNumeroFabricacao - Legado:
    *   ThisForm.ParentForm.poDataMgr.SqlExecute([Select cModelos From
    *       SigFiMpF Where cImpFabs = '] + fDecriptografar(lcNoSerie) + ['], [crTmpImpF])
    *   lcModelo = crTmpImpF.cModelos
    * Quando o numero de fabricacao nao identifica nenhuma impressora
    * (leitura/decriptacao de hardware indisponivel neste acervo - ver
    * utils\leiturafab.prg/fdecriptografar.prg), o legado cai em
    * Space(10), que nunca casa com 'MP-7000 TH FI' - mesmo default aqui.
    *--------------------------------------------------------------------------
    FUNCTION ObterModeloInternoPorNumeroFabricacao(par_cNoFabReal)
        LOCAL loc_cModelo, loc_nResultado, loc_oErro
        loc_cModelo = SPACE(10)

        IF !EMPTY(par_cNoFabReal) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                IF USED("cursor_4c_SigOpAut_MpF")
                    USE IN cursor_4c_SigOpAut_MpF
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT cModelos FROM SigFiMpF WHERE cImpFabs = " + EscaparSQL(ALLTRIM(par_cNoFabReal)), ;
                    "cursor_4c_SigOpAut_MpF")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_MpF") AND RECCOUNT("cursor_4c_SigOpAut_MpF") > 0
                    loc_cModelo = NVL(cursor_4c_SigOpAut_MpF.cModelos, SPACE(10))
                ENDIF

                IF USED("cursor_4c_SigOpAut_MpF")
                    USE IN cursor_4c_SigOpAut_MpF
                ENDIF
            CATCH TO loc_oErro
                loc_cModelo = SPACE(10)
            ENDTRY
        ENDIF

        RETURN loc_cModelo
    ENDFUNC

ENDDEFINE

