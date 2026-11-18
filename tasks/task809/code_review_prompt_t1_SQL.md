# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, CODBINS, TIPOCAMPO, PROXIMOCOMANDO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CNCAIXAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, CODBINS, TIPOCAMPO, PROXIMOCOMANDO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABINDEX' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, CODBINS, TIPOCAMPO, PROXIMOCOMANDO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'JAMA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, CODBINS, TIPOCAMPO, PROXIMOCOMANDO

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
  ControlSource = "OPSENHA"
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = "+lsValPago)
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = "+laCartao[VAL(pcCartao)+1])
INSERT INTO crSiTef (Tef) VALUES ("011-000 = "+lsTipTran)
INSERT INTO crSiTef (Tef) VALUES ("012-000 = "+lsNsu)
INSERT INTO crSiTef (Tef) VALUES ("013-000 = "+lsAutoriza)
INSERT INTO crSiTef (Tef) VALUES ("015-000 = "+SUBSTR(lsDataHora,7,2)+SUBSTR(lsDataHora,5,2)+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("018-000 = "+Thisform.Text1.Value)
INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("022-000 = "+SUBSTR(lsDataHora,7,2)+SUBSTR(lsDataHora,5,2)+SUBSTR(lsDataHora,1,4))
INSERT INTO crSiTef (Tef) VALUES ("023-000 = "+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("023-000 = "+Iif(Type('lsFinaliza') = 'C',lsFinaliza,''))
INSERT INTO crSiTef (Tef) VALUES ("027-000 = "+SUBSTR(lsDataHora,9,6))
	INSERT INTO crSiTef (Tef) VALUES (STRTRAN("029-"+TRANSFORM(lnLinha,"@L 999")+" = "+IIF(lsPos<>0,SUBSTR(lsCupom,1,lsPos-1),lsCupom),CHR(0),' '))
INSERT INTO crSiTef (Tef) VALUES ("028-000 = "+ALLTRIM(STR(lnLinha-2)))
INSERT INTO crSiTef (Tef) VALUES ("030-000 = "+Iif(Type("MenRet")='C',MenRet,''))
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = "+lsValPago)
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("030-000 = "+lcMensagem)
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
	.poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers],'crSigOpFp')
	.poDatamgr.SqlExecute([Select * From SigCdEmp Where cEmps = ?_Empr],'crSigCdEmp')
		lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
		ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
			lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 
		lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
		ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
			lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 
		lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
		ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
			lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 
		lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
		ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
			lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 
		lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
		ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
			lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 
		lcQuery = [Select ChkBins From SigOpFp Where FPags = '] + ThisForm.pcOpers + [']
		ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPag])
			lcQuery = [Select CodBins, DataIs, DataFs From SigOpFpb Where FPags = '] + ThisForm.pcOpers + [' ] + ;
			ThisForm.poDatamgr.SqlExecute(lcQuery, [csTmpFPagb]) 

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoptef.prg) - TRECHOS RELEVANTES PARA PASS SQL (3704 linhas total):

*-- Linhas 47 a 65:
47: *            NumParcs, lcIdent, pcOpers
48: *   .poDatamgr = CreateObject("fSqlConector",...) + pnIdconn > 0
49: *                                       -> THIS.ValidarParametros()
50: *   .poDatamgr.SqlExecute(SigOpFp...) + SqlExecute(SigCdEmp...)
51: *                                       -> sigoptefBO.BuscarParametrosPagamento()
52: *                                          (chamado por THIS.CarregarParametrosPagamento())
53: *   If crSigOpFp.lCartao = "N" / Container1.Label1.Caption = ...
54: *                                       -> THIS.AtualizarTextosDaTela()
55: *                                          (hook BOParaForm delega para ela)
56: *
57: *   O retorno da tela (equivalente ao Unload legado, usado via "DO FORM ...
58: *   TO var") acompanha os handlers de interacao com o SiTef, nas fases 7 e 8.
59: *
60: * FASE 4/8 - Campos de Captura e Botao de Saida
61: *   Este form OPERACIONAL nao tem lista nem PageFrame (ver layout.json: raiz
62: *   "Class: form"/"BaseClass: form", ZERO objeto BaseClass grid/pageframe) -
63: *   o template generico "Grid + 6 botoes CRUD" desta fase NAO SE APLICA aqui
64: *   (inventar essa superficie violaria o PILAR 1), mesmo criterio ja usado
65: *   nos irmaos desta familia (Formsigopdtf.prg/task725 - "Sitef - Cartao de

*-- Linhas 1026 a 1044:
1026:     * nao reconhece CommandGroup e gera "obj_4c_SAIDA" no mapeamento.json -
1027:     * corrigido junto com este arquivo).
1028:     *
1029:     * ControlSource = "OPSENHA" do dump NAO transcrito - artefato de
1030:     * template do Form Designer (o grupo tem 1 unico botao, nao ha o que
1031:     * refletir).
1032:     *
1033:     * O Click (BINDEVENT) fica para a fase que entrega os eventos de botao
1034:     * (6-8): o CANCELA.Click do legado chama ContinuaFuncaoSiTefInterativo
1035:     * (precisa da DECLARE DLL + do estado do protocolo, nenhum dos dois
1036:     * existe ainda) e ThisForm.RetornoFalha (metodo que tambem ainda nao
1037:     * existe) - amarrar o Click agora criaria um handler incompleto.
1038:     *--------------------------------------------------------------------------
1039:     PROTECTED PROCEDURE ConfigurarBotaoSaida()
1040:         THIS.AddObject("cmg_4c_Saida", "CommandGroup")
1041:         WITH THIS.cmg_4c_Saida
1042:             .AutoSize    = .T.
1043:             .ButtonCount = 1
1044:             .Top         = -2

*-- Linhas 1347 a 1385:
1347:                 USE IN cursor_4c_RespostaSiTef
1348:             ENDIF
1349: 
1350:             CREATE CURSOR cursor_4c_RespostaSiTef (Tef C(100))
1351: 
1352:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
1353:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1354:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("002-000 = ")
1355:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
1356:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("004-000 = 0")
1357:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("009-000 = FF")
1358:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("010-000 = 05")
1359:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("028-000 = 0")
1360:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("030-000 = " + loc_cMensagem)
1361:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("150-000 = 00000000")
1362:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")
1363: 
1364:             SELECT cursor_4c_RespostaSiTef
1365:             COPY TO C:\client\Resp\IntPos.001 SDF
1366:             ZAP
1367: 
1368:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
1369:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1370:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")
1371: 
1372:             COPY TO C:\client\Resp\IntPos.STS SDF
1373: 
1374:             USE IN cursor_4c_RespostaSiTef
1375: 
1376:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1377:                 THIS.this_oBusinessObject.RegistrarTransacaoTef("TEF_FALHA")
1378:             ENDIF
1379: 
1380:             loc_lSucesso = .T.
1381:         CATCH TO loc_oErro
1382:             IF USED("cursor_4c_RespostaSiTef")
1383:                 USE IN cursor_4c_RespostaSiTef
1384:             ENDIF
1385:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1444 a 1515:
1444:                 USE IN cursor_4c_RespostaSiTef
1445:             ENDIF
1446: 
1447:             CREATE CURSOR cursor_4c_RespostaSiTef (Tef C(100))
1448: 
1449:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
1450:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1451:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("002-000 = ")
1452:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
1453:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("004-000 = 0")
1454:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("009-000 = 0")
1455:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(loc_cCartaoCod) + 1])
1456:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("011-000 = " + TratarNulo(par_cTipTran, ""))
1457:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("012-000 = " + TratarNulo(par_cNsu, ""))
1458:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("013-000 = " + TratarNulo(par_cAutoriza, ""))
1459:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("015-000 = " + SUBSTR(par_cDataHora, 7, 2) + ;
1460:                 SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 9, 6))
1461:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("017-000 = 0")
1462:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("018-000 = " + TratarNulo(THIS.txt_4c_Text1.Value, ""))
1463:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("017-000 = ")
1464:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("019-000 = ")
1465:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("020-000 = ")
1466:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("021-000 = 0")
1467:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("022-000 = " + SUBSTR(par_cDataHora, 7, 2) + ;
1468:                 SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 1, 4))
1469:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_cDataHora, 9, 6))
1470:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("023-000 = " + ;
1471:                 IIF(VARTYPE(par_cFinaliza) = "C", par_cFinaliza, ""))
1472:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_cDataHora, 9, 6))
1473: 
1474:             *-- DO WHILE lsPos<>0 / lsPos=AT(CHR(10),lsCupom) / ... quebra o
1475:             *-- cupom em linhas numeradas "029-NNN"
1476:             loc_cCupomRestante = TratarNulo(par_cCupom, "")
1477:             loc_nPos   = 1
1478:             loc_nLinha = 1
1479:             DO WHILE loc_nPos != 0
1480:                 loc_nPos = AT(CHR(10), loc_cCupomRestante)
1481:                 loc_cLinhaCupom = IIF(loc_nPos != 0, SUBSTR(loc_cCupomRestante, 1, loc_nPos - 1), loc_cCupomRestante)
1482:                 INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ( ;
1483:                     STRTRAN("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + loc_cLinhaCupom, CHR(0), " "))
1484:                 loc_cCupomRestante = SUBSTR(loc_cCupomRestante, loc_nPos + 1)
1485:                 loc_nLinha = loc_nLinha + 1
1486:             ENDDO
1487: 
1488:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
1489:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("030-000 = " + ;
1490:                 IIF(VARTYPE(par_cMenRet) = "C", par_cMenRet, ""))
1491:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("150-000 = 00000000")
1492:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")
1493: 
1494:             SELECT cursor_4c_RespostaSiTef
1495:             COPY TO C:\client\Resp\IntPos.001 SDF
1496:             ZAP
1497: 
1498:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("000-000 = CRT")
1499:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
1500:             INSERT INTO cursor_4c_RespostaSiTef (Tef) VALUES ("999-999 = 0")
1501: 
1502:             COPY TO C:\client\Resp\IntPos.STS SDF
1503: 
1504:             USE IN cursor_4c_RespostaSiTef
1505: 
1506:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1507:                 THIS.this_oBusinessObject.RegistrarTransacaoTef("TEF_APROVADO")
1508:             ENDIF
1509: 
1510:             loc_lSucesso = .T.
1511:         CATCH TO loc_oErro
1512:             IF USED("cursor_4c_RespostaSiTef")
1513:                 USE IN cursor_4c_RespostaSiTef
1514:             ENDIF
1515:             MsgErro(loc_oErro.Message + CHR(13) + ;


### BO (C:\4c\projeto\app\classes\sigoptefBO.prg):
*====================================================================
* sigoptefBO.prg
*
* Business Object para Formsigoptef (Cartao de Credito / TEF - SiTef)
* Form OPERACIONAL sem tabela principal propria: a transacao e feita
* via DLL do SiTef (CliSiTef32I.DLL); o BO so resolve os parametros
* vindos da forma de pagamento (SigOpFp) e da empresa (SigCdEmp) que
* alimentam a integracao TEF.
*
* Tabela: (nenhuma - form nao persiste registro proprio)
*====================================================================

DEFINE CLASS sigoptefBO AS BusinessBase

	*-- Parametros recebidos no Init do form legado (PARAMETERS EndSiTef,
	*-- ValPago, Cupom, Caixa, DebCred, TipPagto, NumParcs, lcIdent, pcOpers)
	this_cEndSiTef = ""        && Endereco/IP do servidor SiTef
	this_nValPago = 0          && Valor a ser pago na transacao
	this_cCupom = ""           && Numero do cupom fiscal (formatado @L 999999)
	this_cCaixa = ""           && Identificacao do caixa (PDV)
	this_cDebCred = ""         && "D"/"C"/"O" - Debito/Credito/Outro
	this_cTipPagto = ""        && Tipo de pagamento (ex.: "E" = especie)
	this_nNumParcs = 0         && Numero de parcelas
	this_cIdent = ""           && Identificador unico da transacao (ltIdent)
	this_cOpers = ""           && Codigo da forma de pagamento (SigOpFp.fpags)

	*-- Derivados a partir dos parametros/lookup (preenchidos no Init)
	this_cIdTerminal = ""      && Identificacao do terminal (CodEstabs ou "00000"+empresa)
	this_cCemps = ""           && Codigo da empresa (SigCdEmp.cemps)

	*-- Espelho de colunas de SigOpFp usadas pela integracao TEF
	this_cFpags = ""           && SigOpFp.fpags (mesmo valor de this_cOpers, apos lookup)
	this_cLCartao = ""         && SigOpFp.lcartao ("S"=cartao digitado manual, "N"=cartao magnetico)
	this_cCodEstabs = ""       && SigOpFp.codestabs
	this_cGarantias = ""       && SigOpFp.garantias
	this_cLSaque = ""          && SigOpFp.lsaque
	this_cTcdc = ""            && SigOpFp.tcdc
	this_nChkBins = 0          && SigOpFp.chkbins

	*====================================================================
	* ESTADO DO PROTOCOLO INTERATIVO DO SiTef (FASE 6/8)
	*
	* No legado estas sao variaveis PUBLIC declaradas no Init do form
	* (sigoptef_form_codigo_fonte.txt:838-839):
	*     Public ProximoComando, TipoCampo, TamanhoMinimo, TamanhoMaximo,
	*            Buffer, lnContinua, ltIdent, lnParcs, lnciclos
	* e lidas/escritas por TODOS os metodos que conversam com a DLL
	* (GetDigitos.Valid/GotFocus, GetParcela.LostFocus, GetCartao.GotFocus,
	* GetCodSeg.LostFocus, Text1.Valid e SAIDA.CANCELA.Click). Como sao UM
	* estado compartilhado, ficam aqui - no BO - e nao espalhadas pelo Form:
	* assim cada chamada a ContinuaFuncaoSiTefInterativo passa pelo mesmo
	* ponto (ContinuarSiTef) e o estado nunca sai de sincronia. Mesmo
	* recorte dos irmaos desta familia (sigopdtfBO, sigprdftBO, SigOpCtfBO).
	*====================================================================
	this_nProximoComando = 0   && ProximoComando  (@lnComando  da DLL)
	this_nTipoCampo      = 0   && TipoCampo       (@lnTipo)
	this_nTamanhoMinimo  = 0   && TamanhoMinimo   (@lnMinimo)
	this_nTamanhoMaximo  = 0   && TamanhoMaximo   (@lnMaximo)
	this_cBuffer         = ""  && Buffer          (@lsBuffer, 2000 bytes)
	this_nContinua       = 0   && lnContinua (ultimo argumento de Continua...)
	this_nCiclos         = 0   && lnCiclos (contador de voltas do laco)

	*-- Acumuladores de UMA passagem pelo laco (FASE 8/8). No legado sao
	*-- PRIVATE declaradas de novo a cada Valid/GotFocus/LostFocus
	*-- (lsTipTran, lsDataHora, lsCupom, lsNsu, lsAutoriza, lsFinaliza,
	*-- mensagem, lsMRet); aqui moram no BO (mesmo estado compartilhado do
	*-- protocolo) e sao zeradas no INICIO de cada handler por
	*-- ZerarAcumuladoresProtocolo(), nunca entre uma chamada a
	*-- ContinuarSiTef e a proxima dentro do MESMO handler.
	this_cTipTran         = "" && lsTipTran  (TipoCampo=100)
	this_cDataHoraTef     = "" && lsDataHora (TipoCampo=105)
	this_cCupomRetorno    = "" && lsCupom    (TipoCampo=121/122, acumulado)
	this_cNsu             = "" && lsNsu      (TipoCampo=134)
	this_cAutoriza        = "" && lsAutoriza (TipoCampo=135)
	this_cFinaliza        = "" && lsFinaliza (ultimo Buffer quando lnRetorno<>0)
	this_cMensagemRetorno = "" && mensagem/lsMensagem (ultimo Buffer "generico")
	this_cMRet            = "" && lsMRet (ProximoComando=3)

	*-- Resultado do DECLARE das funcoes da CliSiTef32I.DLL. A estacao de
	*-- desenvolvimento e a do pipeline nao tem a DLL do SiTef; sem esta
	*-- flag o DECLARE que falha derrubaria o Init do BO e, por tabela, a
	*-- tela inteira (licao "DECLARE DLL carrega na hora e mata o form").
	this_lSiTefDisponivel = .F.

	*-- Transacao abandonada pelo operador (ESC / botao Cancelar). Lida
	*-- pelos lacos do protocolo para nao insistir com o terminal.
	this_lCancelado = .F.

	*-- lcIdTerminal do legado (3o argumento "lsTerminal" do
	*-- ConfiguraIntSiTefInterativo), montado em GetDigitos.GotFocus e
	*-- GetCartao.GotFocus como
	*--     fConverteStr(CrSigCdEmp.nEmps) + TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")
	*-- Resolvido por CarregarIdentificacaoTerminal().
	this_nEmps          = 0        && SigCdEmp.nemps  (numeric(3,0))
	this_cIdCaixa       = "000000" && SIGFIMPF.cncaixas formatado "@L 999999"
	this_cTerminalSiTef = ""       && nEmps + cncaixas - identificacao do PDV

	*--------------------------------------------------------------------
	* Campos DIGITADOS NA TELA, transferidos por Formsigoptef.FormParaBO()
	* no inicio de cada passagem pelo laco de protocolo. No legado cada
	* handler lia "This.Value" na hora de montar o Buffer
	* (GetDigitos.Valid, GetParcela.LostFocus, GetCartao.GotFocus,
	* GetCodSeg.LostFocus, Text1.Valid); aqui o valor chega pelo hook, e
	* eh DESTAS properties que MontarBufferSiTef monta o que vai para a
	* CliSiTef32I.DLL - a tela nao eh lida de dentro dos lacos.
	*
	* this_cValorPago eh o conteudo EXIBIDO em GetValor (When -> .f. no
	* legado, portanto nao digitavel): entra aqui pelo mesmo hook por ser
	* o valor que o operador confere antes de autorizar, e eh o texto
	* usado nas linhas "003-000" do arquivo de resposta ao PDV.
	*--------------------------------------------------------------------
	this_cValorPago        = ""  && GetValor.Value    (exibicao, "99999999999,99")
	this_cDigitosCartao    = ""  && GetDigitos.Value  (4 ultimos digitos)
	this_cRespParcelamento = ""  && GetParcela.Value  ("1"=Lojista, "2"=Administradora)
	this_cNumeroCartao     = ""  && GetCartao.Value   (ate 19 digitos)
	this_cCodSeguranca     = ""  && GetCodSeg.Value   (CVV / "0"=inexistente, "1"=ilegivel)
	this_cQtdParcelas      = ""  && Text1.Value       (numero de parcelas digitado)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		*-- Nao ha tabela principal: a transacao TEF nao persiste registro proprio
		THIS.this_cTabela = ""
		THIS.this_cCampoChave = ""

		*-- FASE 6/8: DECLARE-DLL das quatro funcoes do protocolo
		*-- interativo (equivalente ao PROCEDURE Load do SCX legado).
		THIS.DeclararFuncoesSiTef()

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia para as propriedades this_* os dados da
	* forma de pagamento (SigOpFp) carregados em cursor por SQLEXEC.
	* Espelha o bloco do Init legado que le crSigOpFp apos o
	* SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers]).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado

		loc_lResultado = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cFpags     = TratarNulo(fpags, "")
			THIS.this_cLCartao   = TratarNulo(lcartao, "")
			THIS.this_cCodEstabs = TratarNulo(codestabs, "")
			THIS.this_cGarantias = TratarNulo(garantias, "")
			THIS.this_cLSaque    = TratarNulo(lsaque, "")
			THIS.this_cTcdc      = TratarNulo(tcdc, "")
			THIS.this_nChkBins   = TratarNulo(chkbins, 0)

			*-- this_cOpers eh o codigo recebido como parametro no Init do form
			*-- (equivalente a pcOpers do legado); this_cFpags eh a PK lida de
			*-- volta de SigOpFp - mantemos this_cOpers como a fonte unica
			*-- quando ainda nao foi atribuido
			IF EMPTY(THIS.this_cOpers)
				THIS.this_cOpers = THIS.this_cFpags
			ENDIF

			loc_lResultado = .T.
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarParametrosPagamento - Replica o bloco WITH ThisForm do Init
	* legado (sigoptef_form_codigo_fonte.txt:866-892): busca a forma de
	* pagamento informada (SigOpFp) e os dados da empresa logada
	* (SigCdEmp), para alimentar a integracao com a DLL do SiTef.
	* Usado pelo Form antes de abrir a sessao com o terminal TEF.
	*====================================================================
	PROCEDURE BuscarParametrosPagamento()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado

		loc_lResultado = .F.

		IF USED("cursor_4c_SigOpFp")
			USE IN cursor_4c_SigOpFp
		ENDIF
		IF USED("cursor_4c_SigCdEmp")
			USE IN cursor_4c_SigCdEmp
		ENDIF

		*-- .poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers],'crSigOpFp')
		loc_cSQL = "SELECT * FROM SigOpFp WHERE fpags = " + EscaparSQL(THIS.this_cOpers)
		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFp")

		IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_SigOpFp") > 0
			THIS.CarregarDoCursor("cursor_4c_SigOpFp")

			*-- .poDatamgr.SqlExecute([Select * From SigCdEmp Where cEmps = ?_Empr],'crSigCdEmp')
			loc_cSQL = "SELECT * FROM SigCdEmp WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdEmp")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_SigCdEmp") > 0
				SELECT cursor_4c_SigCdEmp
				THIS.this_cCemps = TratarNulo(cemps, "")

				*-- If Empty(crSigOpFp.CodEstabs) / lsIdTerminal="00000"+_Empr / Else / crSigOpFp.CodEstabs / Endif
				IF EMPTY(THIS.this_cCodEstabs)
					THIS.this_cIdTerminal = "00000" + THIS.this_cCemps
				ELSE
					THIS.this_cIdTerminal = THIS.this_cCodEstabs
				ENDIF

				loc_lResultado = .T.
			ELSE
				THIS.this_cMensagemErro = "Empresa " + ALLTRIM(go_4c_Sistema.cCodEmpresa) + " n" + CHR(227) + "o cadastrada em SigCdEmp."
			ENDIF
		ELSE
			THIS.this_cMensagemErro = "Forma de pagamento " + ALLTRIM(THIS.this_cOpers) + " n" + CHR(227) + "o cadastrada em SigOpFp."
		ENDIF

		IF USED("cursor_4c_SigOpFp")
			USE IN cursor_4c_SigOpFp
		ENDIF
		IF USED("cursor_4c_SigCdEmp")
			USE IN cursor_4c_SigCdEmp
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Este BO nao persiste registro proprio: a
	* transacao e feita pela DLL do SiTef (CliSiTef32I.DLL), fora do
	* SQL Server (regra PILAR 2 - nao ha tabela para criar so para dar
	* uma PK a este BO). A chave usada em RegistrarAuditoria() eh o
	* identificador unico da transacao (equivalente ao ltIdent recebido
	* no Init legado), com a forma de pagamento como fallback enquanto
	* a transacao ainda nao tem identificador atribuido.
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		IF !EMPTY(THIS.this_cIdent)
			RETURN ALLTRIM(THIS.this_cIdent)
		ENDIF
		RETURN ALLTRIM(THIS.this_cOpers)
	ENDPROC

	*====================================================================
	* RegistrarTransacaoTef - Registra em auditoria o resultado da
	* transacao TEF (aprovada/negada/cancelada pelo usuario). Chamado
	* pelo Form apos o retorno da DLL do SiTef - no legado esse ponto
	* correspondia so a escrita dos arquivos de resposta do PDV
	* (MontaRetorno/RetornoFalha, montaretorno/retornofalha do
	* sigoptef_form_codigo_fonte.txt); aqui tambem fica o registro de
	* auditoria do evento, usando o par_cOperacao como descricao
	* (ex.: "TEF_APROVADO", "TEF_NEGADO", "TEF_CANCELADO").
	*====================================================================
	PROCEDURE RegistrarTransacaoTef(par_cOperacao)
		RETURN THIS.RegistrarAuditoria(par_cOperacao)
	ENDPROC

	*====================================================================
	* CAMADA DE ACESSO A CliSiTef32I.DLL (FASE 6/8)
	*
	* Equivale ao PROCEDURE Load do SCX legado (DECLARE das quatro funcoes)
	* mais a CENTRALIZACAO das chamadas que o legado espalha por sete
	* metodos diferentes. Os lacos de protocolo que CONSOMEM esta camada
	* (GetDigitos.Valid/GotFocus, GetParcela.LostFocus, GetCartao.GotFocus,
	* GetCodSeg.LostFocus e Text1.Valid) sao escopo das fases 7-8: sao
	* cinco variantes do MESMO dialogo com o terminal, compartilhando o
	* estado declarado no topo desta classe, e dividi-los produziria
	* pedaco de maquina de estado que nao faz nada sozinho. Mesmo recorte
	* dos irmaos desta familia (sigopdtfBO, sigprdftBO, SigOpCtfBO), onde
	* esta camada tambem mora no BO e nasce antes do laco.
	*====================================================================

	*====================================================================
	* DeclararFuncoesSiTef - PROCEDURE Load do legado
	* (sigoptef_form_codigo_fonte.txt:813-819), as QUATRO declaracoes, na
	* mesma ordem e com as mesmas assinaturas.
	*
	* TRY/CATCH obrigatorio: DECLARE ... IN "<arquivo>.DLL" NAO eh
	* declaracao preguicosa - o VFP9 tenta CARREGAR a biblioteca na hora
	* e, na estacao sem o PIN-pad (desenvolvimento/pipeline), estoura
	* "Cannot load 32-bit DLL CliSiTef32I.DLL." ali mesmo. Sem o TRY o
	* erro sobe pelo Init do BO, CREATEOBJECT("sigoptefBO") devolve .F., o
	* Form ve VARTYPE != "O" e A TELA NAO ABRE, exibindo so "VARTYPE
	* retornou: L" (licao "DECLARE DLL carrega na hora e mata o form").
	*
	* CATCH sem MsgErro de proposito: biblioteca ausente nao eh erro a
	* reportar na abertura da tela. Quem avisa eh o proprio caminho do
	* legado - this_lSiTefDisponivel = .F. faz ConectarSiTef() devolver
	* .F. e o laco cai no ramo "Sem comunicacao com SiTef" que o legado ja
	* tem para ConfiguraIntSiTefInterativo <> 0. Chamar a funcao sem o
	* DECLARE seria pior: o VFP passaria a procurar
	* "continuafuncaositefinterativo.prg" no PATH (regra #13) e a mensagem
	* nao citaria nem DLL nem SiTef.
	*
	* PROTECTED: chamado so pelo Init desta classe (regra #51).
	*====================================================================
	PROTECTED PROCEDURE DeclararFuncoesSiTef()
		LOCAL loc_oErro

		THIS.this_lSiTefDisponivel = .F.

		TRY
			DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
				STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado

			DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
				INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
				STRING lsHorario, STRING lsOperador, STRING lsRestricao

			DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
				INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
				STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado

			DECLARE INTEGER FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
				INTEGER lnConfirma, STRING lsCupom, STRING lsData, STRING lsHorario

			THIS.this_lSiTefDisponivel = .T.
		CATCH TO loc_oErro
			*-- Estacao sem a CliSiTef32I.DLL. Ver o cabecalho acima: a
			*-- flag fica .F. e cada wrapper devolve o valor de FALHA que
			*-- o proprio legado ja trata.
			THIS.this_cMensagemErro = loc_oErro.Message
		ENDTRY
	ENDPROC

	*====================================================================
	* ZerarAcumuladoresProtocolo - FASE 8/8. Reproduz o "PRIVATE lsNsu,
	* lsAutoriza, lsDataHora, lsTipTran, lsCupom, lsFinaliza" que o legado
	* declara de novo no TOPO de cada Valid/GotFocus/LostFocus que inicia
	* uma passagem pelo laco - chamado por esses handlers (Form) antes de
	* montar o primeiro Buffer da passagem, nunca no meio dela.
	*====================================================================
	PROCEDURE ZerarAcumuladoresProtocolo()
		THIS.this_cTipTran         = ""
		THIS.this_cDataHoraTef     = ""
		THIS.this_cCupomRetorno    = ""
		THIS.this_cNsu             = ""
		THIS.this_cAutoriza        = ""
		THIS.this_cFinaliza        = ""
		THIS.this_cMensagemRetorno = ""
		THIS.this_cMRet            = ""
	ENDPROC

	*====================================================================
	* AplicarCamposDigitados - recebe de Formsigoptef.FormParaBO() o que
	* esta NA TELA e guarda nas properties que os lacos do protocolo leem.
	*
	* Cada argumento eh OPCIONAL e o teste eh por PCOUNT(), nao por tipo:
	* parametro OMITIDO chega ao VFP9 como Logico .F., entao um
	* "VARTYPE() = 'L'" tomaria a omissao por um valor e sobrescreveria a
	* property com o texto de um .F. - exatamente o que a tela nao pediu.
	* Argumento PRESENTE mas de tipo inesperado vira "" por NormalizarTexto.
	*
	* A normalizacao para Caractere acontece aqui porque o TextBox de
	* parcelas nasce NUMERICO quando o chamador ja informa NumParcs, e
	* concatenar numero com string estoura "Operator/operand type
	* mismatch" dentro do laco - longe daqui, dificil de atribuir.
	*====================================================================
	PROCEDURE AplicarCamposDigitados(par_cValorPago, par_cDigitos, ;
			par_cRespParcelamento, par_cNumeroCartao, ;
			par_cCodSeguranca, par_cQtdParcelas)

		IF PCOUNT() >= 1
			THIS.this_cValorPago = THIS.NormalizarTexto(par_cValorPago)
		ENDIF
		IF PCOUNT() >= 2
			THIS.this_cDigitosCartao = THIS.NormalizarTexto(par_cDigitos)
		ENDIF
		IF PCOUNT() >= 3
			THIS.this_cRespParcelamento = THIS.NormalizarTexto(par_cRespParcelamento)
		ENDIF
		IF PCOUNT() >= 4
			THIS.this_cNumeroCartao = THIS.NormalizarTexto(par_cNumeroCartao)
		ENDIF
		IF PCOUNT() >= 5
			THIS.this_cCodSeguranca = THIS.NormalizarTexto(par_cCodSeguranca)
		ENDIF
		IF PCOUNT() >= 6
			THIS.this_cQtdParcelas = THIS.NormalizarTexto(par_cQtdParcelas)
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* NormalizarTexto - devolve SEMPRE Caractere, sem espaco nas pontas.
	* Character passa direto; Numeric vai por TRANSFORM (nunca ALLTRIM
	* direto num numerico, que estoura erro 11); Logico vira "S"/"N";
	* qualquer outro tipo (inclusive NULL) vira "".
	*====================================================================
	PROTECTED FUNCTION NormalizarTexto(par_uValor)
		LOCAL loc_cTexto

		IF ISNULL(par_uValor)
			RETURN ""
		ENDIF

		DO CASE
			CASE VARTYPE(par_uValor) = "C"
				loc_cTexto = ALLTRIM(par_uValor)
			CASE VARTYPE(par_uValor) = "N"
				loc_cTexto = ALLTRIM(TRANSFORM(par_uValor))
			CASE VARTYPE(par_uValor) = "L"
				loc_cTexto = IIF(par_uValor, "S", "N")
			OTHERWISE
				loc_cTexto = ""
		ENDCASE

		RETURN loc_cTexto
	ENDFUNC

	*====================================================================
	* CarregarIdentificacaoTerminal - resolve o lcIdTerminal que o legado
	* monta em GetDigitos.GotFocus / GetCartao.GotFocus:
	*     lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) + ;
	*                    TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")
	*
	* crSigFiMpF eh cursor GLOBAL do Framework legado (impressora fiscal
	* do caixa) e NAO eh populado em ponto algum deste dump - o SCX
	* contava com a tela de venda te-lo aberto. Em vez de depender de
	* cursor global nao documentado, consulta SIGFIMPF pela empresa
	* corrente e, quando o parametro "Caixa" recebido no Init bate com
	* algum SIGFIMPF.cncaixas dessa empresa, usa esse registro; senao cai
	* no 1o registro da empresa e, na falta de qualquer um, em "000000".
	* Mesmo criterio (e mesmos fallbacks) de
	* sigopdtfBO.CarregarIdentificacaoTerminal.
	*
	* Colunas conferidas em docs/schema.sql (lido com Get-Content -Raw,
	* regra #14): SigCdEmp.nemps numeric(3,0), SIGFIMPF.cncaixas char(3),
	* SIGFIMPF.emps char(3) - "emps" SEM o C inicial nesta tabela
	* (regra #48: o prefixo da tabela nao decide o nome da coluna).
	*
	* NAO derruba o form quando a consulta falha: os fallbacks acima sao o
	* mesmo desfecho pratico do legado com os cursores globais vazios.
	*====================================================================
	FUNCTION CarregarIdentificacaoTerminal()
		LOCAL loc_oErro, loc_cSQL

		THIS.this_nEmps    = 0
		THIS.this_cIdCaixa = "000000"

		TRY
			IF USED("cursor_4c_EmpTef")
				USE IN cursor_4c_EmpTef
			ENDIF

			loc_cSQL = "SELECT nemps FROM SigCdEmp WHERE cemps = " + ;
				EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
			SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTef")

			IF USED("cursor_4c_EmpTef") AND !EOF("cursor_4c_EmpTef")
				THIS.this_nEmps = TratarNulo(cursor_4c_EmpTef.nemps, 0)
			ENDIF

			IF USED("cursor_4c_EmpTef")
				USE IN cursor_4c_EmpTef
			ENDIF

			IF USED("cursor_4c_MpfTef")
				USE IN cursor_4c_MpfTef
			ENDIF

			loc_cSQL = "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + ;
				EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))

			IF !EMPTY(ALLTRIM(THIS.this_cCaixa))
				loc_cSQL = loc_cSQL + " AND cncaixas = " + ;
					EscaparSQL(ALLTRIM(THIS.this_cCaixa))
			ENDIF

			SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MpfTef")

			IF USED("cursor_4c_MpfTef") AND !EOF("cursor_4c_MpfTef")
				THIS.this_cIdCaixa = TRANSFORM(VAL(TratarNulo(cursor_4c_MpfTef.cncaixas, "0")), "@L 999999")
			ENDIF

			IF USED("cursor_4c_MpfTef")
				USE IN cursor_4c_MpfTef
			ENDIF
		CATCH TO loc_oErro
			*-- Sem tabela/registro/conexao: seguem os fallbacks acima.
			THIS.this_cMensagemErro = loc_oErro.Message
		ENDTRY

		THIS.this_cTerminalSiTef = fConverteStr(THIS.this_nEmps) + THIS.this_cIdCaixa

		RETURN .T.
	ENDFUNC

	*====================================================================
	* ConectarSiTef - encapsula a chamada que o legado faz em
	* GetDigitos.GotFocus e GetCartao.GotFocus:
	*     IF ConfiguraIntSiTefInterativo(lsEndSitef,lsIdTerminal,lcIdTerminal,0) <> 0
	*         Thisform.RetornoFalha("Sem comunicacao com SiTef")
	*
	* Argumentos, na ordem da DLL:
	*   lsEndereco  = lsEndSiTef   -> this_cEndSiTef (parametro EndSiTef)
	*   lsLoja      = lsIdTerminal -> this_cIdTerminal (SigOpFp.codestabs,
	*                 ou "00000" + empresa quando vazio - ja resolvido em
	*                 BuscarParametrosPagamento). NAO confundir com o
	*                 numero do caixa: este argumento identifica a LOJA no
	*                 servidor SiTef, e enviar o caixa aqui faz o servidor
	*                 recusar a conexao ou credenciar na loja errada.
	*   lsTerminal  = lcIdTerminal -> this_cTerminalSiTef (empresa+caixa)
	*   lnReservado = 0 (literal no legado)
	*
	* Devolve .T. quando a conexao foi aceita (retorno 0 da DLL), para o
	* chamador escrever "IF !ConectarSiTef()" no lugar do "<> 0" do
	* legado. Sem a DLL carregada devolve .F. sem chamar nada - o laco cai
	* no mesmo ramo "Sem comunicacao com SiTef".
	*====================================================================
	FUNCTION ConectarSiTef()
		LOCAL loc_nRetorno

		IF !THIS.this_lSiTefDisponivel
			RETURN .F.
		ENDIF

		IF EMPTY(THIS.this_cTerminalSiTef)
			THIS.CarregarIdentificacaoTerminal()
		ENDIF

		loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
			ALLTRIM(THIS.this_cIdTerminal), THIS.this_cTerminalSiTef, 0)

		RETURN (loc_nRetorno = 0)
	ENDFUNC

	*====================================================================
	* IniciarSiTef - encapsula a chamada que o legado faz logo apos
	* conectar (GetDigitos.GotFocus / GetCartao.GotFocus):
	*     lcValpago = ALLTRIM(TRANSFORM(lnValPago,"99999999.99"))
	*     lcValPago = STRTRAN(lcValPago,".",",")
	*     IF IniciaFuncaoSiTefInterativo(0,lcValPago,lsCupom,lcData,lchora,lsCaixa,"") <> 10000
	*
	* A modalidade (1o argumento) eh 0 LITERAL no legado e a restricao
	* (ultimo) eh string vazia. O valor vai com VIRGULA decimal - eh o
	* formato que o protocolo exige, nao um descuido de localizacao.
	* par_cData/par_cHora chegam ja formatados pelo chamador (o legado
	* repete o mesmo calculo em cada ponto que inicia a transacao; os dois
	* helpers estao em ObterDataSiTef/ObterHoraSiTef, abaixo).
	*
	* Devolve .T. quando a DLL responde 10000 (= transacao iniciada, siga
	* para o laco de Continua...), espelhando o teste "<> 10000" do legado.
	*====================================================================
	FUNCTION IniciarSiTef(par_cData, par_cHora)
		LOCAL loc_cValPago, loc_cData, loc_cHora, loc_nRetorno

		IF !THIS.this_lSiTefDisponivel
			RETURN .F.
		ENDIF

		loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_nValPago, "99999999.99")), ".", ",")
		loc_cData    = IIF(VARTYPE(par_cData) = "C" AND !EMPTY(par_cData), par_cData, THIS.ObterDataSiTef())
		loc_cHora    = IIF(VARTYPE(par_cHora) = "C" AND !EMPTY(par_cHora), par_cHora, THIS.ObterHoraSiTef())

		loc_nRetorno = IniciaFuncaoSiTefInterativo(0, loc_cValPago, THIS.this_cCupom, ;
			loc_cData, loc_cHora, ALLTRIM(THIS.this_cCaixa), "")

		RETURN (loc_nRetorno = 10000)
	ENDFUNC

	*====================================================================
	* ContinuarSiTef - encapsula TODAS as chamadas a
	* ContinuaFuncaoSiTefInterativo do legado (GetDigitos.Valid,
	* GetParcela.LostFocus, GetCodSeg.LostFocus, GetCartao.GotFocus,
	* Text1.Valid e SAIDA.CANCELA.Click).
	*
	* Os cinco primeiros argumentos sao POR REFERENCIA (@) e a DLL escreve
	* neles o proximo passo do protocolo. VFP9 nao passa property por
	* referencia, entao o estado eh copiado para LOCAL, passado com @ e
	* copiado de volta - por isso toda chamada tem de vir por aqui: fazer
	* a chamada direta em cada handler deixaria copias do estado fora de
	* sincronia.
	*
	* Buffer nunca pode ir vazio: o 6o argumento eh LEN(buffer) e a DLL
	* escreve nele ate esse tamanho - o legado sempre mantem 2000 bytes.
	*
	* par_nContinua ausente reusa o this_nContinua corrente, que eh como o
	* legado se comporta (lnContinua eh variavel PUBLIC, preservada entre
	* as voltas do laco).
	*====================================================================
	FUNCTION ContinuarSiTef(par_nContinua)
		LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
			loc_nTamanhoMaximo, loc_cBuffer, loc_nContinua, loc_nRetorno

		IF !THIS.this_lSiTefDisponivel
			*-- -1 eh "Modulo Nao Iniciado" na tabela de erros do proprio
			*-- legado (ver ProcessarErroTef no Form) - o codigo certo para
			*-- "nao ha como conversar com o equipamento".
			RETURN -1
		ENDIF

		loc_nContinua = IIF(VARTYPE(par_nContinua) = "N", par_nContinua, THIS.this_nContinua)

		loc_nProximoComando = THIS.this_nProximoComando
		loc_nTipoCampo      = THIS.this_nTipoCampo
		loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
		loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
		loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), REPLICATE(CHR(0), 2000), THIS.this_cBuffer)

		loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
			@loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), loc_nContinua)

		THIS.this_nProximoComando = loc_nProximoComando
		THIS.this_nTipoCampo      = loc_nTipoCampo
		THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
		THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
		THIS.this_cBuffer         = loc_cBuffer
		THIS.this_nContinua       = loc_nContinua

		RETURN loc_nRetorno
	ENDFUNC

	*====================================================================
	* FinalizarTransacaoSiTef - 4a funcao declarada pelo Load legado.
	* Assinatura: (lnConfirma, lsCupom, lsData, lsHorario). lnConfirma = 0
	* DESFAZ a transacao em aberto no terminal; 1 confirma.
	*
	* Nenhum metodo do dump deste form a CHAMA - o SCX a declara junto das
	* outras tres (mesmo Load do irmao SIGOPDTF, onde ela eh usada). O
	* wrapper existe porque a DECLARACAO existe: sem ele, quem precisar
	* desfazer a transacao chamaria a funcao solta e, faltando o DECLARE,
	* o VFP procuraria "finalizatransacaositefinterativo.prg" no PATH
	* (regra #13). Nao ha caminho novo inventado aqui - so o acesso a uma
	* funcao que o proprio legado ja declara.
	*====================================================================
	FUNCTION FinalizarTransacaoSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
		LOCAL loc_nRetorno

		IF !THIS.this_lSiTefDisponivel
			RETURN -1
		ENDIF

		loc_nRetorno = FinalizaTransacaoSiTefInterativo( ;
			IIF(VARTYPE(par_nConfirma) = "N", par_nConfirma, 0), ;
			IIF(VARTYPE(par_cCupom) = "C" AND !EMPTY(par_cCupom), par_cCupom, "1"), ;
			IIF(VARTYPE(par_cData) = "C" AND !EMPTY(par_cData), par_cData, THIS.ObterDataSiTef()), ;
			IIF(VARTYPE(par_cHora) = "C" AND !EMPTY(par_cHora), par_cHora, THIS.ObterHoraSiTef()))

		RETURN loc_nRetorno
	ENDFUNC

	*====================================================================
	* MontarBufferSiTef - carrega this_cBuffer com o valor que o operador
	* digitou, completado com CHR(0) ate os 2000 bytes que
	* ContinuaFuncaoSiTefInterativo espera. Migrado do padrao repetido em
	* cada Valid/LostFocus do legado:
	*     Buffer=Alltrim(This.Value)+REPLICATE(CHR(0),2000-LEN(Alltrim(This.Value)))
	*
	* par_nComplemento permite reproduzir as variantes LITERAIS do legado
	* (ex.: Buffer = '0' + Replicate(Chr(0),1999) na resposta ao comando
	* 20, onde o complemento eh 1999 e nao 2000 - LEN(Buffer)).
	*====================================================================
	FUNCTION MontarBufferSiTef(par_cValor, par_nComplemento)
		LOCAL loc_cValor, loc_nComplemento

		IF VARTYPE(par_cValor) = "C"
			loc_cValor = ALLTRIM(par_cValor)
		ELSE
			loc_cValor = ALLTRIM(TRANSFORM(par_cValor))
		ENDIF

		IF VARTYPE(par_nComplemento) = "N" AND par_nComplemento > 0
			loc_nComplemento = par_nComplemento
		ELSE
			loc_nComplemento = 2000 - LEN(loc_cValor)
		ENDIF

		IF loc_nComplemento < 0
			loc_nComplemento = 0
		ENDIF

		THIS.this_cBuffer = loc_cValor + REPLICATE(CHR(0), loc_nComplemento)

		RETURN THIS.this_cBuffer
	ENDFUNC

	*====================================================================
	* ObterDataSiTef / ObterHoraSiTef - os dois formatos que o legado
	* monta a mao em cada ponto que inicia a transacao:
	*     lcData = STR(YEAR(DATE()),4)+SUBSTR(DTOC(DATE()),4,2)+SUBSTR(DTOC(DATE()),1,2)
	*     lchora = STRTRAN(TIME(),":","")
	* ou seja AAAAMMDD e HHMMSS, sem separador.
	*
	* A transcricao NAO usa SUBSTR(DTOC(...)): DTOC depende de SET DATE, e
	* um SET DATE diferente no processo trocaria mes por dia EM SILENCIO.
	* DTOS(DATE()) devolve AAAAMMDD por definicao, independente de SET
	* DATE - exatamente o que o legado pretendia montar. Na hora, TIME()
	* devolve HH:MM:SS fixo; o LEFT(...,8) descarta os centesimos que
	* TIME(1) traria e que o legado nao usa.
	*====================================================================
	FUNCTION ObterDataSiTef()
		RETURN DTOS(DATE())
	ENDFUNC

	FUNCTION ObterHoraSiTef()
		RETURN STRTRAN(LEFT(TIME(), 8), ":", "")
	ENDFUNC

	*====================================================================
	* ValidarBinCartao - migrado do bloco "IF TipoCampo = 136" que aparece
	* DUAS vezes no GetDigitos.Valid legado:
	*     lcQuery = [Select ChkBins From SigOpFp Where FPags = ']+ThisForm.pcOpers+[']
	*     If csTmpFPag.ChkBins = 1
	*         lcQuery = [Select CodBins,DataIs,DataFs From SigOpFpb Where FPags = '...'
	*                    And CodBins = ']+Alltrim(Strtran(Buffer,Chr(0),''))+[']
	*         If Eof() Or Not Between(Dtos(Date()),Dtos(Nvl(DataIs,Ctod('01/01/1900'))), ;
	*                                               Dtos(Nvl(DataFs,Ctod('31/12/9999'))))
	*             ... "Cartao Invalido para esta Condicao de Pagamento" e aborta
	*
	* ChkBins ja foi lido para this_nChkBins em CarregarDoCursor - nao se
	* reconsulta SigOpFp a cada volta do laco. Com a checagem DESLIGADA
	* (ChkBins <> 1) o legado nao consulta nada e segue a transacao, por
	* isso o retorno eh .T. nesse caso.
	*
	* O BIN chega do buffer da DLL com CHR(0) de enchimento - o STRTRAN
	* abaixo eh o mesmo do legado, e sem ele o WHERE nunca casaria.
	*
	* datais/datafs sao datetime (docs/schema.sql): ConverterParaData
	* normaliza os dois lados antes do DTOS, porque comparar DATE com
	* DATETIME dispara erro 11 (regra #16).
	*====================================================================
	FUNCTION ValidarBinCartao(par_cBin)
		LOCAL loc_oErro, loc_cSQL, loc_cBin, loc_lValido, loc_dIni, loc_dFim

		IF THIS.this_nChkBins != 1
			RETURN .T.
		ENDIF

		loc_cBin    = ALLTRIM(STRTRAN(IIF(VARTYPE(par_cBin) = "C", par_cBin, ""), CHR(0), ""))
		loc_lValido = .F.

		TRY
			IF USED("cursor_4c_SigOpFpb")
				USE IN cursor_4c_SigOpFpb
			ENDIF

			loc_cSQL = "SELECT codbins, datais, datafs FROM SigOpFpb" + ;
				" WHERE fpags = " + EscaparSQL(ALLTRIM(THIS.this_cOpers)) + ;
				" AND codbins = " + EscaparSQL(loc_cBin)

			SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFpb")

			IF USED("cursor_4c_SigOpFpb") AND !EOF("cursor_4c_SigOpFpb")
				loc_dIni = ConverterParaData(TratarNulo(cursor_4c_SigOpFpb.datais, CTOD("01/01/1900")))
				loc_dFim = ConverterParaData(TratarNulo(cursor_4c_SigOpFpb.datafs, CTOD("31/12/9999")))

				IF EMPTY(loc_dIni)
					loc_dIni = CTOD("01/01/1900")
				ENDIF
				IF EMPTY(loc_dFim)
					loc_dFim = CTOD("31/12/9999")
				ENDIF

				loc_lValido = BETWEEN(DTOS(DATE()), DTOS(loc_dIni), DTOS(loc_dFim))
			ENDIF

			IF USED("cursor_4c_SigOpFpb")
				USE IN cursor_4c_SigOpFpb
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro ao validar o BIN do cart" + CHR(227) + "o")
		ENDTRY

		RETURN loc_lValido
	ENDFUNC

	*====================================================================
	* Inserir() / Atualizar() / ExecutarExclusao() - este formulario nao
	* grava registro proprio no banco (a transacao e feita pela DLL do
	* SiTef, fora do SQL Server - ver cabecalho deste arquivo); o
	* comportamento padrao herdado de BusinessBase ja eh o correto para
	* este BO, entao esses tres metodos nao sao sobrescritos aqui.
	*====================================================================

ENDDEFINE

