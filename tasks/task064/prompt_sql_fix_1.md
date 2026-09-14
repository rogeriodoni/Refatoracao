CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1172: Tabela 'SigReCtb' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~1311: Tabela 'SigReCtb' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.
- [SQL-SCHEMA] Linha ~2020: INSERT coluna 'chave' NAO EXISTE na tabela 'logauditoria'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: logauditoria
CREATE TABLE [dbo].[LogAuditoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Tabela] [varchar](100) NOT NULL,
	[Operacao] [varchar](10) NOT NULL,
	[ChaveRegistro] [varchar](100) NOT NULL,
	[Usuario] [varchar](50) NOT NULL,
	[DataHora] [datetime] NOT NULL,
	[DadosAnteriores] [nvarchar](max) NULL,
	[DadosNovos] [nvarchar](max) NULL,
	[IP] [varchar](50) NULL,
	[Estacao] [varchar](100) NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\FormSIGRECPM.prg):

--- Linhas 1153 a 1193 ---
1153:         ENDIF
1154:     ENDPROC
1155: 
1156:     *==========================================================================
1157:     * LOOKUPS DE CONTA ORIGEM (SigReCtb: contas / descs)
1158:     *==========================================================================
1159: 
1160:     PROCEDURE TeclaContaO(par_nKeyCode, par_nShiftAltCtrl)
1161:         IF INLIST(par_nKeyCode, 13, 9, 115)
1162:             THIS.AbrirBuscaContaO()
1163:         ENDIF
1164:     ENDPROC
1165: 
1166:     PROCEDURE AbrirBuscaContaO()
1167:         LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
1168:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1169:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_ContaO.Value)
1170: 
1171:         IF !EMPTY(loc_cValor)
1172:             loc_cSQL = "SELECT contas, descs FROM SigReCtb WHERE contas = " + ;
1173:                        EscaparSQL(loc_cValor)
1174:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaOVal")
1175:             IF loc_nRes > 0
1176:                 SELECT cursor_4c_ContaOVal
1177:                 IF !EOF()
1178:                     loc_oPag.txt_4c_DContaO.Value = ALLTRIM(descs)
1179:                     USE IN cursor_4c_ContaOVal
1180:                     RETURN
1181:                 ENDIF
1182:             ENDIF
1183:             IF USED("cursor_4c_ContaOVal")
1184:                 USE IN cursor_4c_ContaOVal
1185:             ENDIF
1186:         ENDIF
1187: 
1188:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1189:             "SigReCtb", "cursor_4c_ContaOBusca", "contas", loc_cValor, ;
1190:             "Conta Origem")
1191:         IF VARTYPE(loc_oForm) != "O"
1192:             RETURN
1193:         ENDIF

--- Linhas 1292 a 1332 ---
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     *==========================================================================
1296:     * LOOKUPS DE CONTA DESTINO (SigReCtb: contas / descs)
1297:     *==========================================================================
1298: 
1299:     PROCEDURE TeclaContaD(par_nKeyCode, par_nShiftAltCtrl)
1300:         IF INLIST(par_nKeyCode, 13, 9, 115)
1301:             THIS.AbrirBuscaContaD()
1302:         ENDIF
1303:     ENDPROC
1304: 
1305:     PROCEDURE AbrirBuscaContaD()
1306:         LOCAL loc_oPag, loc_cValor, loc_oForm, loc_cSQL, loc_nRes
1307:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1308:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_ContaD.Value)
1309: 
1310:         IF !EMPTY(loc_cValor)
1311:             loc_cSQL = "SELECT contas, descs FROM SigReCtb WHERE contas = " + ;
1312:                        EscaparSQL(loc_cValor)
1313:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDVal")
1314:             IF loc_nRes > 0
1315:                 SELECT cursor_4c_ContaDVal
1316:                 IF !EOF()
1317:                     loc_oPag.txt_4c_DContaD.Value = ALLTRIM(descs)
1318:                     USE IN cursor_4c_ContaDVal
1319:                     RETURN
1320:                 ENDIF
1321:             ENDIF
1322:             IF USED("cursor_4c_ContaDVal")
1323:                 USE IN cursor_4c_ContaDVal
1324:             ENDIF
1325:         ENDIF
1326: 
1327:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1328:             "SigReCtb", "cursor_4c_ContaDBusca", "contas", loc_cValor, ;
1329:             "Conta Destino")
1330:         IF VARTYPE(loc_oForm) != "O"
1331:             RETURN
1332:         ENDIF



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SIGRECPMBO.prg):

--- BO Linhas 504 a 514 ---
504:         RETURN .F.
505:     ENDPROC
506: 
507:     *--------------------------------------------------------------------------
508:     * ObterChavePrimaria - Retorna identificador do conjunto de filtros atual
509:     * Relatorios nao tem chave de registro - usa-se o hash dos filtros
510:     * para identificar a execucao (util em auditoria/log).
511:     *--------------------------------------------------------------------------
512:     PROCEDURE ObterChavePrimaria()
513:         LOCAL loc_cChave
514:         loc_cChave = "SIGRECPM|" + ;

--- BO Linhas 540 a 550 ---
540: 
541:             loc_cChave    = THIS.ObterChavePrimaria()
542:             loc_cUsuario  = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
543:                                 gc_4c_UsuarioLogado, "SYSTEM")
544: 
545:             loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, Chave, Usuario, DataHora)" + ;
546:                        " VALUES (" + EscaparSQL("SIGRECPM") + ", " + ;
547:                        EscaparSQL(loc_cOperacao) + ", " + ;
548:                        EscaparSQL(loc_cChave) + ", " + ;
549:                        EscaparSQL(loc_cUsuario) + ", GETDATE())"
550: 


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\FormSIGRECPM.prg
- BO: C:\4c\projeto\app\classes\SIGRECPMBO.prg
