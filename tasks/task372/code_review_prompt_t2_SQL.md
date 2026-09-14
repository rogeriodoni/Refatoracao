# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DESCS, ESTADOS, LNERRO1, CODIGOS, CTVENDACS, UFIBGES

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
  pgframeDados.pgframeDados4.cmdApagaitem.Command1.Picture = ..\vbmp\wzdelete.bmp
  pgframeDados.pgFrameDados11.cmdGExcItem.cmdExcItem.Picture = ..\vbmp\wzdelete.bmp
lcQuery = [Select a.Codigos ] + ;
		    [From SigCdMun a, SigCdUfs b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMunic]) < 1)
Select LocalMunic
lcQuery = [Select UFIBGEs ] + ;
		    [From SigCdUfs ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalUF]) < 1)
Select LocalUF
					Select crSigCdPam
					Select crSigCdGcr
						lcQuery = [Select a.Iclis From SigCdCli a] + ;
							lnErro1 = ThisForm.poDataMgr.SQLExecute(lcQuery,'crTmpCli')
							Select crTmpCli

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormCliente.prg) - TRECHOS RELEVANTES PARA PASS SQL (1968 linhas total):

*-- Linhas 87 a 105:
87:             *-- Determinar grupo padrao se nao informado
88:             loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
89:             IF EMPTY(loc_cGrupo) AND USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
90:                 SELECT crSigCdPam
91:                 LOCATE
92:                 IF !EOF("crSigCdPam")
93:                     loc_cGrupo = PADR(crSigCdPam.GrPadClis, 10)
94:                     THIS.this_cGrupo = loc_cGrupo
95:                 ENDIF
96:             ENDIF
97: 
98:             *-- Verificar grupo configurado
99:             IF EMPTY(ALLTRIM(THIS.this_cGrupo))
100:                 MsgAviso("Grupo Padr" + CHR(227) + "o N" + CHR(227) + "o Configurado.")
101:             ELSE
102:                 *-- Definir modo (INSERIR / ALTERAR)
103:                 THIS.mudavend = .T.
104:                 IF EMPTY(ALLTRIM(THIS.this_cCli))
105:                     THIS.pcEscolha       = "INSERIR"

*-- Linhas 356 a 383:
356:         IF THIS.pcEscolha = "INSERIR"
357:             TRY
358:                 IF USED("crSigCdCli")
359:                     SELECT crSigCdCli
360:                     loc_nCodigo  = crSigCdCli.NClis
361:                     loc_nIdConta = crSigCdCli.IdConta
362:                 ELSE
363:                     loc_nCodigo  = 0
364:                     loc_nIdConta = 0
365:                 ENDIF
366: 
367:                 IF USED("crSigCdGcr")
368:                     SELECT crSigCdGcr
369:                     IF crSigCdGcr.TpCods = 1
370:                         IF crSigCdGcr.TpEmps = 1
371:                             = fCanUniqueKey(loc_nCodigo, ALLTRIM(crSigCdGcr.Codigos) + go_4c_Sistema.cCodEmpresa)
372:                         ELSE
373:                             = fCanUniqueKey(loc_nCodigo, ALLTRIM(crSigCdGcr.Codigos))
374:                         ENDIF
375:                     ENDIF
376:                 ENDIF
377:             CATCH TO loc_oErro
378:                 *-- fCanUniqueKey pode nao estar portada; nao bloquear o cancelamento
379:             ENDTRY
380:         ENDIF
381: 
382:         THIS.RetCodCliente = " "
383:         THIS.Release()

*-- Linhas 1300 a 1356:
1300:     *============================================================
1301:     PROCEDURE checaibge
1302:         LPARAMETERS par_cMun, par_cUFs, par_oObC, par_oObU
1303:         LOCAL loc_nRtC, loc_nRtU, loc_cQuery, loc_oErro
1304: 
1305:         loc_nRtC = 9999999
1306:         loc_nRtU = 99
1307: 
1308:         TRY
1309:             *-- Buscar codigo IBGE do municipio
1310:             loc_cQuery = "SELECT a.Codigos " + ;
1311:                         "FROM SigCdMun a, SigCdUfs b " + ;
1312:                         "WHERE RTRIM(a.Descs) = '" + ;
1313:                             PADR(UPPER(ALLTRIM(par_cMun)), 40) + "'" + ;
1314:                         " AND a.UFIBGEs = b.UFIBGEs" + ;
1315:                         " AND b.Estados = '" + PADR(par_cUFs, 2) + "'"
1316: 
1317:             IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalMunic") > 0
1318:                 IF USED("cursor_4c_LocalMunic")
1319:                     SELECT cursor_4c_LocalMunic
1320:                     GO TOP IN cursor_4c_LocalMunic
1321:                     IF !EOF("cursor_4c_LocalMunic")
1322:                         loc_nRtC = INT(VAL(ALLTRIM(TRANSFORM(cursor_4c_LocalMunic.Codigos))))
1323:                     ENDIF
1324:                 ENDIF
1325:             ENDIF
1326: 
1327:             IF USED("cursor_4c_LocalMunic")
1328:                 USE IN cursor_4c_LocalMunic
1329:             ENDIF
1330: 
1331:             par_oObC.Value    = loc_nRtC
1332:             par_oObC.Refresh()
1333:             par_oObC.ForeColor = IIF(loc_nRtC = 9999999, RGB(255,0,0), RGB(0,0,0))
1334: 
1335:             *-- Buscar codigo IBGE da UF
1336:             loc_cQuery = "SELECT UFIBGEs FROM SigCdUfs " + ;
1337:                         "WHERE Estados = '" + PADR(par_cUFs, 2) + "'"
1338: 
1339:             IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalUF") > 0
1340:                 IF USED("cursor_4c_LocalUF")
1341:                     SELECT cursor_4c_LocalUF
1342:                     GO TOP IN cursor_4c_LocalUF
1343:                     IF !EOF("cursor_4c_LocalUF")
1344:                         loc_nRtU = cursor_4c_LocalUF.UFIBGEs
1345:                     ENDIF
1346:                 ENDIF
1347:             ENDIF
1348: 
1349:             IF USED("cursor_4c_LocalUF")
1350:                 USE IN cursor_4c_LocalUF
1351:             ENDIF
1352: 
1353:             par_oObU.Value    = loc_nRtU
1354:             par_oObU.Refresh()
1355:             par_oObU.ForeColor = IIF(loc_nRtU = 99, RGB(255,0,0), RGB(0,0,0))
1356: 

*-- Linhas 1928 a 1946:
1928:                 loc_oBusca.Show()
1929: 
1930:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1931:                     SELECT cursor_4c_BuscaCli
1932:                     GO TOP IN cursor_4c_BuscaCli
1933:                     IF !EOF("cursor_4c_BuscaCli")
1934:                         loc_cCodigoCli = ALLTRIM(cursor_4c_BuscaCli.IClis)
1935:                     ENDIF
1936:                     USE IN cursor_4c_BuscaCli
1937:                     loc_lSelecionou = !EMPTY(loc_cCodigoCli)
1938:                 ENDIF
1939:                 loc_oBusca = .NULL.
1940:             ENDIF
1941: 
1942:             IF loc_lSelecionou
1943:                 THIS.this_cCli       = PADR(loc_cCodigoCli, 10)
1944:                 THIS.pcEscolha       = "ALTERAR"
1945:                 THIS.this_cModoAtual = "ALTERAR"
1946:                 THIS.plaltcd         = .T.

