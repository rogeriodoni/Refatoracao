# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NMINENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDNCRDS, CDOPES, CNIVELS, ABREVS, CPROS, QTDS, LCDYNFC, DOPES, ICLIS, LOCALENTS, ABREVIS, BLQDESCS, VALUE, CPFS, CGC1, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NMAXENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDNCRDS, CDOPES, CNIVELS, ABREVS, CPROS, QTDS, LCDYNFC, DOPES, ICLIS, LOCALENTS, ABREVIS, BLQDESCS, VALUE, CPFS, CGC1, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LOCENTOBS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDNCRDS, CDOPES, CNIVELS, ABREVS, CPROS, QTDS, LCDYNFC, DOPES, ICLIS, LOCALENTS, ABREVIS, BLQDESCS, VALUE, CPFS, CGC1, CODIGOS

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
  ControlSource = "CsPraze.contaes"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TprMvCabG.CodObs"
  ControlSource = "TprMvCabG.Obses"
lcSql = [Select Dopes, PrazoEnts, LocalEnts, ContaEs, CodObs, ObsEs From SigMvCab Where EmpDnCrds = ']+lcEmpDopNum2+[']
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcSql, 'CsPedAnt') < 1)
Select CsPedAnt
lcSql = [Select a.cDopes, a.cnivels as Dopes, a.nCors, a.padraos, b.abrevs, b.DtEntrs, b.nFiscals, c.nMinEnts, c.nMaxEnts ] + ;
		[from SigCdMop a, SigCdOpe b, SigOpCdc c ]+;
If ThisForm.ParentForm.PoDataMgr.SqlExecute(lcSql,'CsPed') < 1
lcSql = [Select Dopes, chkUteis, MinFretes, MinSeguros, MinDesps From SigOpCdd]
If ThisForm.ParentForm.PoDataMgr.SqlExecute(lcSql,'crTodosOpe2') < 1
Select crTodosOpe2
lcSql = [Select b.dopes, c.LocEntObs, c.chkUteis from SigCdMop a, SigCdOpe b, SigOpCdd c ]+;
If ThisForm.ParentForm.PoDataMgr.SqlExecute(lcSql,'CsPedOpe2') < 1
Select CsPedOpe2
Select Distinct AbrevIs From crTpmMvItn Where Cpros <> ' ' And Qtds <> 0 Into Cursor Itens
Select a.*, 0 as LocEntObs From CsPed a, Itens b Where a.Abrevs = b.AbrevIs Into Cursor CsPedidos ReadWrite
Select CsPedidos
Select CsPedidos
	=Seek(CsPedidos.Dopes,'CsPedOpe2','Dopes')
	Insert Into CsPrazE (Dopes, Abrevs, Prazos, DtEntrs, nMinEnts, nMaxEnts, VlFretes, nFiscals, LocEntObs) Values ;
	Insert Into TprMvCabG (Dopes, Abrevs, CodObs, ObsEs ) Values ;
	=Seek(CsPedidos.Dopes,'CsPedAnt','Dopes')
Select CsPrazE
		.Column3.ControlSource = 'CsPrazE.Dopes'
		.Column2.ControlSource = 'CsPrazE.Prazos'
		.Column1.ControlSource = 'CsPrazE.VlFretes'
		.Column4.ControlSource = 'CsPrazE.DespAces'
		.Column5.ControlSource = 'CsPrazE.VlSeguros'
		Select csPedidos
lcSql = [Select a.Dopes, a.ExibSits, b.ChCtEntrs, DtEntrs, DigObs From SigCdOpe a, SigOpCdc b ]+;
ThisForm.ParentForm.PodataMgr.SqlExecute(lcSql,'LocTmpOpe')
lcSql = [Select Cpfs, Rclis From SigCdCli Where Iclis = ']+lcConta+[']
ThisForm.parentForm.PodataMgr.SqlExecute(lcSql,'CrTmpCli')
=Seek(CsPrazE.Abrevs,'TprMvCabG','Abrevs')
Select CsPrazE
Select CsPrazE
Select CsPrazE
Select CsPrazE
Update crTpmMvItn Set PrzEnts = Ctod(''), ValFrts = 0, DespAces = 0, ValSegs = 0
Select CsPrazE
	=Seek(csPrazE.Dopes, [crTodosOpe2], [Dopes])
		Select csPrazE
	=Seek(csPrazE.Dopes, [crTodosOpe2], [Dopes])
	Update crTpmMvItn Set PrzEnts = CsPrazE.Prazos, ValFrts = CsPrazE.VlFretes, LocalEnts = CsPrazE.LocalEnts, ;
	lcQuery = [Select * From SigCdCli Where Cpfs = ?Cgc1 ]
	lnErro = ThisForm.parentForm.poDataMgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
			Select CrTmpCli
		lcQuery = [Select * From SigCdCli Where ]+Iif(Len(RetCli)=10,[ Iclis = ],[ Cpfs = ])+[ ?RetCli ]
		lnErro = ThisForm.ParentForm.PodataMgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
	lcQuery = [Select Codigos, Descrs ] + ;
			    [From SigCdObs ] + ;
	If (Thisform.parentForm.Podatamgr.SqlExecute(lcQuery, 'crLocalObs') < 1)
	Select crLocalObs
	If Not Seek(This.Value, 'crLocalObs', 'Codigos')
	Select crSigCdObs
		Select TmpOperacao

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormPzo.prg) - TRECHOS RELEVANTES PARA PASS SQL (1932 linhas total):

*-- Linhas 84 a 122:
84: 
85:                     *-- Indexar TprMvCabG por Abrevs para os SEEKs na navegacao
86:                     IF USED("TprMvCabG")
87:                         SELECT TprMvCabG
88:                         INDEX ON Abrevs TAG Abrevs
89:                     ENDIF
90: 
91:                     *-- Construir interface plana (sem PageFrame)
92:                     THIS.ConfigurarCabecalho()
93:                     THIS.ConfigurarPaginaLista()
94:                     THIS.ConfigurarBotaoEncerrar()
95:                     THIS.BindEventos()
96: 
97:                     *-- Atualizar totais iniciais na tela (usando totais da NF do pai)
98:                     THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
99:                     THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
100:                     THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
101:                     THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
102:                     THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal
103:                     THIS.txt_4c_SegI.Value  = THIS.this_oBusinessObject.this_nSegInformado
104: 
105:                     *-- Posicionar na primeira linha e atualizar containers
106:                     IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
107:                         SELECT CsPrazE
108:                         GO TOP
109:                         THIS.AtualizarLinhaGrid(1)
110:                     ENDIF
111: 
112:                     loc_lSucesso = .T.
113:                 ENDIF
114:             ENDIF
115: 
116:         CATCH TO loc_oErro
117:             MsgErro(loc_oErro.Message + CHR(13) + ;
118:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
119:                     "Procedure: " + loc_oErro.Procedure, ;
120:                     "Erro em FormPzo.InicializarForm")
121:         ENDTRY
122: 

*-- Linhas 189 a 207:
189:         *-- 3. Container de entrega (inicialmente oculto ate selecao de linha)
190:         THIS.ConfigurarContainerEntrega()
191: 
192:         *-- 4. Conectar grid ao cursor CsPrazE (RecordSource + ControlSources)
193:         THIS.ConfigurarGridDados()
194: 
195:         *-- 5. Formas decorativas (Shape1/3/4/5 do original SCX)
196:         THIS.ConfigurarFormas()
197:     ENDPROC
198: 
199:     *==========================================================================
200:     * ConfigurarPaginaDados - Campos DADOS parte 1 (totais + observacao)
201:     *   Forma OPERACIONAL sem PageFrame - agrega os controles de dados abaixo
202:     *   do grid: area de totais Frete/Desp/Seguro + container de observacao
203:     *==========================================================================
204:     PROTECTED PROCEDURE ConfigurarPaginaDados()
205:         *-- Area de totais (Frete/Despesas Acessorias/Seguro): 6 labels + 6 textboxes
206:         THIS.ConfigurarAreaTotais()
207: 

*-- Linhas 247 a 265:
247:             .FontSize          = 8
248:             .AllowHeaderSizing = .F.
249:             .AllowRowSizing    = .F.
250:             .DeleteMark        = .F.
251:             .HeaderHeight      = 20
252:             .RowHeight         = 16
253:             .ScrollBars        = 2
254:             .SplitBar          = .F.
255:             .GridLineColor     = RGB(238, 238, 238)
256:             .Themes            = .F.
257:             .Visible           = .T.
258:         ENDWITH
259: 
260:         *-- Column1: Movimentacao (Dopes) - somente leitura
261:         loc_oCol = loc_oGrid.Column1
262:         WITH loc_oCol
263:             .ColumnOrder      = 1
264:             .Width            = 290
265:             .ReadOnly         = .T.

*-- Linhas 357 a 398:
357:     ENDPROC
358: 
359:     *==========================================================================
360:     * ConfigurarGridDados - Define RecordSource/ControlSources e coloracao
361:     *==========================================================================
362:     PROTECTED PROCEDURE ConfigurarGridDados()
363:         LOCAL loc_oGrid
364:         LOCAL loc_cDynFc, loc_nQtdSc, loc_nVez, loc_nCor
365:         loc_oGrid = THIS.grd_4c_Dados
366: 
367:         WITH loc_oGrid
368:             .RecordSource          = "CsPrazE"
369:             .RecordSourceType      = 1
370:             .Column1.ControlSource = "CsPrazE.Dopes"
371:             .Column2.ControlSource = "CsPrazE.Prazos"
372:             .Column3.ControlSource = "CsPrazE.VlFretes"
373:             .Column4.ControlSource = "CsPrazE.DespAces"
374:             .Column5.ControlSource = "CsPrazE.VlSeguros"
375:             .Refresh()
376:         ENDWITH
377: 
378:         *-- Coloracao dinamica por grupo de operacao (nCors diferencia grupos)
379:         IF USED("CsPedidos")
380:             loc_cDynFc = ""
381:             loc_nQtdSc = 0
382:             loc_nVez   = 0
383:             SELECT CsPedidos
384:             SET ORDER TO nCors
385:             GO TOP
386:             SCAN
387:                 loc_nCor   = CsPedidos.nCors
388:                 loc_cDynFc = loc_cDynFc + "Iif(InList(CsPrazE.Abrevs,"
389:                 loc_nQtdSc = loc_nQtdSc + 1
390:                 SCAN WHILE nCors = loc_nCor
391:                     IF loc_nVez > 0
392:                         loc_cDynFc = loc_cDynFc + ","
393:                     ENDIF
394:                     loc_cDynFc = loc_cDynFc + "'" + ALLTRIM(Abrevs) + "'"
395:                     loc_nVez   = loc_nVez + 1
396:                 ENDSCAN
397:                 SKIP -1
398:                 loc_cDynFc = loc_cDynFc + ")," + ALLTRIM(STR(loc_nCor)) + ","

*-- Linhas 747 a 770:
747:             .Visible   = .T.
748:         ENDWITH
749: 
750:         *-- Campo conta de entrega (ControlSource vincula direto ao cursor)
751:         loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
752:         WITH loc_oCnt.txt_4c_Conta
753:             .FontName      = "Arial"
754:             .FontSize      = 8
755:             .ControlSource = "CsPrazE.ContaEs"
756:             .Height        = 21
757:             .Left          = 10
758:             .Margin        = 0
759:             .MaxLength     = 10
760:             .SpecialEffect = 1
761:             .Top           = 33
762:             .Width         = 72
763:             .Visible       = .T.
764:         ENDWITH
765: 
766:         loc_oCnt.AddObject("lbl_4c_LblCpf", "Label")
767:         WITH loc_oCnt.lbl_4c_LblCpf
768:             .FontBold  = .F.
769:             .FontName  = "Tahoma"
770:             .FontSize  = 8

*-- Linhas 918 a 936:
918:         IF !USED("CsPrazE")
919:             RETURN
920:         ENDIF
921:         SELECT CsPrazE
922:         loc_cDopes = ALLTRIM(CsPrazE.Dopes)
923: 
924:         IF THIS.this_oBusinessObject.CarregarInfoLinhaGrid(loc_cDopes)
925:             *-- Alternar visibilidade dos paineis suplementares
926:             THIS.AlternarPagina(THIS.this_oBusinessObject.this_nDtEntrsOpe, ;
927:                                 THIS.this_oBusinessObject.this_nDigObs)
928: 
929:             *-- Atualizar campos de conta de entrega
930:             loc_cConta = ALLTRIM(NVL(CsPrazE.ContaEs, ""))
931:             IF !EMPTY(loc_cConta)
932:                 IF THIS.this_oBusinessObject.CarregarInfoConta(loc_cConta, ;
933:                         THIS.this_oBusinessObject.this_nChCtEntrs)
934:                     THIS.cnt_4c_Entrega.txt_4c_Cpf.Value    = ;
935:                         THIS.this_oBusinessObject.this_cGetCpf
936:                     THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ;

*-- Linhas 954 a 972:
954:         ENDIF
955: 
956:         THIS.Refresh
957:         SELECT CsPrazE
958:     ENDPROC
959: 
960:     *==========================================================================
961:     * AtualizarTotaisNaTela - LostFocus colunas numericas: recalcula totais
962:     *==========================================================================
963:     FUNCTION AtualizarTotaisNaTela()
964:         THIS.this_oBusinessObject.AtualizarTotais()
965:         THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
966:         THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
967:         THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
968:         THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
969:         THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal
970:         THIS.txt_4c_SegI.Value  = THIS.this_oBusinessObject.this_nSegInformado
971:     ENDPROC
972: 

*-- Linhas 1070 a 1095:
1070: 
1071:             IF loc_lContinuar
1072:                 *-- Buscar dados do cliente para abrir FormEnd
1073:                 loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = '" + ;
1074:                            ALLTRIM(loc_cIClis) + "'"
1075:                 IF USED("crTSigDCompCli")
1076:                     USE IN crTSigDCompCli
1077:                 ENDIF
1078:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTSigDCompCli")
1079:                 IF loc_nResult >= 1
1080:                     SELECT crTSigDCompCli
1081:                     GO TOP
1082:                     loc_cGrupo = ALLTRIM(NVL(crTSigDCompCli.Grupos, ""))
1083:                     loc_cNome  = ALLTRIM(NVL(crTSigDCompCli.RClis,  ""))
1084:                     loc_nLocal = NVL(CsPrazE.LocalEnts, 0)
1085: 
1086:                     DO FORM FormEnd WITH ;
1087:                         loc_cGrupo, loc_cIClis, loc_cNome, ;
1088:                         THIS.this_oBusinessObject.this_cEscolha, .NULL., loc_nLocal
1089:                 ENDIF
1090:                 IF USED("crTSigDCompCli")
1091:                     USE IN crTSigDCompCli
1092:                 ENDIF
1093:             ENDIF
1094: 
1095:         CATCH TO loc_oErro

*-- Linhas 1129 a 1155:
1129:         THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = loc_cCpfFmt
1130: 
1131:         TRY
1132:             loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE " + ;
1133:                        "RTRIM(Cpfs) = " + EscaparSQL(ALLTRIM(loc_cCpfFmt))
1134:             IF USED("cursor_4c_BuscaCpf")
1135:                 USE IN cursor_4c_BuscaCpf
1136:             ENDIF
1137:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")
1138: 
1139:             IF loc_nResult >= 1 AND !EOF("cursor_4c_BuscaCpf")
1140:                 SELECT cursor_4c_BuscaCpf
1141:                 GO TOP
1142:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(NVL(cursor_4c_BuscaCpf.IClis, ""))
1143:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.RClis,  ""))
1144:                 IF USED("CsPrazE")
1145:                     REPLACE ContaEs WITH ALLTRIM(cursor_4c_BuscaCpf.IClis) IN CsPrazE
1146:                 ENDIF
1147:                 loc_lSucesso = .T.
1148:             ENDIF
1149:             IF USED("cursor_4c_BuscaCpf")
1150:                 USE IN cursor_4c_BuscaCpf
1151:             ENDIF
1152: 
1153:             IF !loc_lSucesso
1154:                 THIS.AbrirBuscaCpf(loc_cCpfFmt)
1155:             ENDIF

*-- Linhas 1170 a 1204:
1170: 
1171:         TRY
1172:             *-- SQL filtrado por CPF ou codigo (starts-with)
1173:             loc_cSQL = "SELECT IClis AS IClis, Cpfs AS Cpfs, RClis AS RClis " + ;
1174:                        "FROM SigCdCli WHERE RTRIM(Cpfs) LIKE " + ;
1175:                        EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
1176:                        " OR RTRIM(IClis) LIKE " + ;
1177:                        EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
1178:                        " ORDER BY Cpfs"
1179:             IF USED("cursor_4c_BuscaCpf")
1180:                 USE IN cursor_4c_BuscaCpf
1181:             ENDIF
1182:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")
1183:             IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaCpf") = 0
1184:                 IF USED("cursor_4c_BuscaCpf")
1185:                     USE IN cursor_4c_BuscaCpf
1186:                 ENDIF
1187:                 *-- Fallback: lista completa
1188:                 SQLEXEC(gnConnHandle, ;
1189:                     "SELECT IClis AS IClis, Cpfs AS Cpfs, RClis AS RClis FROM SigCdCli ORDER BY Cpfs", ;
1190:                     "cursor_4c_BuscaCpf")
1191:             ENDIF
1192: 
1193:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1194:             IF VARTYPE(loc_oForm) = "O"
1195:                 loc_oForm.DefinirCursor("cursor_4c_BuscaCpf", "IClis", "Cpfs", ;
1196:                     "Busca por CPF / CNPJ")
1197:                 IF loc_oForm.Mostrar()
1198:                     THIS.cnt_4c_Entrega.txt_4c_Cpf.Value   = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1199:                     THIS.cnt_4c_Entrega.txt_4c_Conta.Value = ALLTRIM(loc_oForm.cCodigoSelecionado)
1200:                     IF !EMPTY(loc_oForm.cCodigoSelecionado)
1201:                         THIS.this_oBusinessObject.CarregarInfoConta( ;
1202:                             ALLTRIM(loc_oForm.cCodigoSelecionado), ;
1203:                             THIS.this_oBusinessObject.this_nChCtEntrs)
1204:                         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ;

*-- Linhas 1241 a 1295:
1241: 
1242:         TRY
1243:             *-- Busca exata por nome (RClis)
1244:             loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + ;
1245:                        "RTRIM(RClis) = " + EscaparSQL(loc_cDConta)
1246:             IF USED("cursor_4c_BuscaDConta")
1247:                 USE IN cursor_4c_BuscaDConta
1248:             ENDIF
1249:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDConta")
1250: 
1251:             IF loc_nResult >= 1 AND !EOF("cursor_4c_BuscaDConta")
1252:                 SELECT cursor_4c_BuscaDConta
1253:                 GO TOP
1254:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(NVL(cursor_4c_BuscaDConta.IClis, ""))
1255:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(NVL(cursor_4c_BuscaDConta.RClis, ""))
1256:                 IF USED("CsPrazE")
1257:                     REPLACE ContaEs WITH ALLTRIM(cursor_4c_BuscaDConta.IClis) IN CsPrazE
1258:                 ENDIF
1259:                 THIS.this_oBusinessObject.CarregarInfoConta( ;
1260:                     ALLTRIM(cursor_4c_BuscaDConta.IClis), ;
1261:                     THIS.this_oBusinessObject.this_nChCtEntrs)
1262:                 THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cGetCpf
1263:                 loc_lSucesso = .T.
1264:             ENDIF
1265:             IF USED("cursor_4c_BuscaDConta")
1266:                 USE IN cursor_4c_BuscaDConta
1267:             ENDIF
1268: 
1269:             IF !loc_lSucesso
1270:                 *-- Busca parcial por nome (starts-with) + picker
1271:                 loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli " + ;
1272:                            "WHERE RTRIM(RClis) LIKE " + EscaparSQL(loc_cDConta + "%") + ;
1273:                            " ORDER BY RClis"
1274:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDConta")
1275:                 IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaDConta") = 0
1276:                     IF USED("cursor_4c_BuscaDConta")
1277:                         USE IN cursor_4c_BuscaDConta
1278:                     ENDIF
1279:                     SQLEXEC(gnConnHandle, ;
1280:                         "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY RClis", ;
1281:                         "cursor_4c_BuscaDConta")
1282:                 ENDIF
1283:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1284:                 IF VARTYPE(loc_oForm) = "O"
1285:                     loc_oForm.DefinirCursor("cursor_4c_BuscaDConta", "IClis", "RClis", ;
1286:                         "Busca de Contas")
1287:                     IF loc_oForm.Mostrar()
1288:                         THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(loc_oForm.cCodigoSelecionado)
1289:                         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1290:                         IF !EMPTY(loc_oForm.cCodigoSelecionado)
1291:                             IF USED("CsPrazE")
1292:                                 REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
1293:                             ENDIF
1294:                             THIS.this_oBusinessObject.CarregarInfoConta( ;
1295:                                 ALLTRIM(loc_oForm.cCodigoSelecionado), ;

*-- Linhas 1332 a 1367:
1332:         TRY
1333:             *-- SQL filtrado por codigo ou nome (starts-with)
1334:             IF EMPTY(loc_cFiltro)
1335:                 loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY IClis"
1336:             ELSE
1337:                 loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli " + ;
1338:                            "WHERE RTRIM(IClis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
1339:                            " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
1340:                            " ORDER BY IClis"
1341:             ENDIF
1342: 
1343:             IF USED("cursor_4c_BuscaCli")
1344:                 USE IN cursor_4c_BuscaCli
1345:             ENDIF
1346:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1347:             IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaCli") = 0
1348:                 IF USED("cursor_4c_BuscaCli")
1349:                     USE IN cursor_4c_BuscaCli
1350:                 ENDIF
1351:                 SQLEXEC(gnConnHandle, ;
1352:                     "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY IClis", ;
1353:                     "cursor_4c_BuscaCli")
1354:             ENDIF
1355: 
1356:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1357:             IF VARTYPE(loc_oForm) = "O"
1358:                 loc_oForm.DefinirCursor("cursor_4c_BuscaCli", "IClis", "RClis", ;
1359:                     "Busca de Contas de Entrega")
1360:                 IF loc_oForm.Mostrar()
1361:                     THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(loc_oForm.cCodigoSelecionado)
1362:                     THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1363:                     IF !EMPTY(loc_oForm.cCodigoSelecionado)
1364:                         IF USED("CsPrazE")
1365:                             REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
1366:                         ENDIF
1367:                         THIS.this_oBusinessObject.CarregarInfoConta( ;

*-- Linhas 1466 a 1484:
1466:             ENDIF
1467: 
1468:             *-- Capturar valores da linha corrente para herdar
1469:             SELECT CsPrazE
1470:             loc_cDopes    = ALLTRIM(NVL(CsPrazE.Dopes,    ""))
1471:             loc_cAbrevs   = ALLTRIM(NVL(CsPrazE.Abrevs,   ""))
1472:             loc_dPrazoBase= NVL(CsPrazE.Prazos, DATETIME())
1473:             loc_nDtEntrs  = NVL(CsPrazE.DtEntrs,  0)
1474:             loc_nFiscals  = NVL(CsPrazE.nFiscals, 0)
1475:             loc_cContaEs  = ALLTRIM(NVL(CsPrazE.ContaEs, ""))
1476: 
1477:             *-- Adicionar linha em branco herdando contexto
1478:             APPEND BLANK IN CsPrazE
1479:             REPLACE CsPrazE.Dopes     WITH loc_cDopes    ;
1480:                     CsPrazE.Abrevs    WITH loc_cAbrevs   ;
1481:                     CsPrazE.Prazos    WITH loc_dPrazoBase;
1482:                     CsPrazE.DtEntrs   WITH loc_nDtEntrs  ;
1483:                     CsPrazE.nFiscals  WITH loc_nFiscals  ;
1484:                     CsPrazE.nMinEnts  WITH 0             ;

*-- Linhas 1517 a 1535:
1517:                 RETURN
1518:             ENDIF
1519: 
1520:             SELECT CsPrazE
1521:             IF EOF() OR BOF()
1522:                 GO TOP
1523:             ENDIF
1524: 
1525:             *-- Marcar modo edicao no BO (usado por Confirmar)
1526:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1527:                 THIS.this_oBusinessObject.this_cEscolha = "ALTERAR"
1528:             ENDIF
1529: 
1530:             *-- Atualizar paineis suplementares para a linha atual
1531:             THIS.AtualizarLinhaGrid(1)
1532: 
1533:             *-- Colocar foco na primeira coluna editavel (Frete)
1534:             THIS.grd_4c_Dados.SetFocus
1535:             THIS.grd_4c_Dados.ActiveColumn = 1

*-- Linhas 1558 a 1576:
1558:                 RETURN
1559:             ENDIF
1560: 
1561:             SELECT CsPrazE
1562:             IF EOF() OR BOF()
1563:                 GO TOP
1564:             ENDIF
1565: 
1566:             *-- Marcar modo visualizacao no BO
1567:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1568:                 THIS.this_oBusinessObject.this_cEscolha = "VISUALIZAR"
1569:             ENDIF
1570: 
1571:             *-- Bloquear edicao no grid (todas as colunas ReadOnly)
1572:             THIS.grd_4c_Dados.ReadOnly = .T.
1573: 
1574:             *-- Bloquear campos do painel de entrega e observacao
1575:             THIS.cnt_4c_Entrega.txt_4c_Conta.ReadOnly    = .T.
1576:             THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly   = .T.

*-- Linhas 1603 a 1639:
1603:                 RETURN
1604:             ENDIF
1605: 
1606:             SELECT CsPrazE
1607:             IF EOF() OR BOF()
1608:                 GO TOP
1609:             ENDIF
1610: 
1611:             loc_cDopes = ALLTRIM(NVL(CsPrazE.Dopes, ""))
1612: 
1613:             IF !MsgConfirma("Confirma a exclusao do prazo da operacao " + ;
1614:                             loc_cDopes + " ?", "Confirmacao")
1615:                 RETURN
1616:             ENDIF
1617: 
1618:             *-- Marcar registro para exclusao e purgar do cursor
1619:             DELETE IN CsPrazE
1620:             SET DELETED ON
1621:             PACK
1622: 
1623:             *-- Reposicionar e atualizar interface
1624:             SELECT CsPrazE
1625:             IF RECCOUNT("CsPrazE") > 0
1626:                 GO TOP
1627:                 THIS.grd_4c_Dados.Refresh
1628:                 THIS.AtualizarLinhaGrid(1)
1629:             ELSE
1630:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = ""
1631:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
1632:                 THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
1633:                 THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = 0
1634:                 THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ""
1635:             ENDIF
1636: 
1637:             THIS.AtualizarTotaisNaTela()
1638: 
1639:         CATCH TO loc_oErro

*-- Linhas 1652 a 1697:
1652:         loc_lSucesso = .F.
1653: 
1654:         IF USED("CsPrazE")
1655:             SELECT CsPrazE
1656:             IF RECCOUNT("CsPrazE") > 0
1657:                 GO TOP
1658:                 THIS.grd_4c_Dados.Refresh
1659:                 THIS.AtualizarLinhaGrid(1)
1660:                 THIS.AtualizarTotaisNaTela()
1661:                 loc_lSucesso = .T.
1662:             ENDIF
1663:         ENDIF
1664: 
1665:         RETURN loc_lSucesso
1666:     ENDPROC
1667: 
1668:     *==========================================================================
1669:     * FormParaBO - Copia linha corrente do CsPrazE e containers para o BO
1670:     *   (grid edita cursor diretamente via ControlSource; aqui capturamos
1671:     *    os campos auxiliares visiveis nos containers suplementares)
1672:     *==========================================================================
1673:     FUNCTION FormParaBO()
1674:         LOCAL loc_lSucesso, loc_oErro
1675:         loc_lSucesso = .F.
1676: 
1677:         TRY
1678:             IF !USED("CsPrazE")
1679:                 loc_lSucesso = .F.
1680:             ENDIF
1681: 
1682:             SELECT CsPrazE
1683:             THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(NVL(CsPrazE.Dopes,    ""))
1684:             THIS.this_oBusinessObject.this_cAbrevs    = ALLTRIM(NVL(CsPrazE.Abrevs,   ""))
1685:             THIS.this_oBusinessObject.this_dPrazos    = IIF(ISNULL(CsPrazE.Prazos), DTOT({}), CsPrazE.Prazos)
1686:             THIS.this_oBusinessObject.this_nDtEntrs   = NVL(CsPrazE.DtEntrs,   0)
1687:             THIS.this_oBusinessObject.this_nMinEnts   = NVL(CsPrazE.nMinEnts,  0)
1688:             THIS.this_oBusinessObject.this_nMaxEnts   = NVL(CsPrazE.nMaxEnts,  0)
1689:             THIS.this_oBusinessObject.this_nVlFretes  = NVL(CsPrazE.VlFretes,  0)
1690:             THIS.this_oBusinessObject.this_nFiscals   = NVL(CsPrazE.nFiscals,  0)
1691:             THIS.this_oBusinessObject.this_nLocalEnts = NVL(CsPrazE.LocalEnts, 0)
1692:             THIS.this_oBusinessObject.this_cContaEs   = ALLTRIM(NVL(CsPrazE.ContaEs,  ""))
1693:             THIS.this_oBusinessObject.this_nLocEntObs = NVL(CsPrazE.LocEntObs, 0)
1694:             THIS.this_oBusinessObject.this_nDespAces  = NVL(CsPrazE.DespAces,  0)
1695:             THIS.this_oBusinessObject.this_nVlSeguros = NVL(CsPrazE.VlSeguros, 0)
1696: 
1697:             *-- Container de entrega (quando visivel)

*-- Linhas 1834 a 1852:
1834: 
1835:     *==========================================================================
1836:     * BtnSalvarClick - Sincroniza campos dos containers com BO e atualiza totais
1837:     *   (grid ja edita CsPrazE via ControlSource; aqui persiste auxiliares)
1838:     *==========================================================================
1839:     PROCEDURE BtnSalvarClick()
1840:         LOCAL loc_oErro
1841: 
1842:         TRY
1843:             IF THIS.FormParaBO()
1844:                 THIS.AtualizarTotaisNaTela()
1845:                 THIS.AjustarBotoesPorModo("")
1846:             ENDIF
1847: 
1848:         CATCH TO loc_oErro
1849:             MsgErro(loc_oErro.Message + CHR(13) + ;
1850:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1851:                     "Procedure: " + loc_oErro.Procedure, ;
1852:                     "Erro em FormPzo.BtnSalvarClick")

*-- Linhas 1863 a 1881:
1863:             THIS.LimparCampos()
1864: 
1865:             IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
1866:                 SELECT CsPrazE
1867:                 THIS.AtualizarLinhaGrid(1)
1868:             ENDIF
1869: 
1870:             THIS.grd_4c_Dados.ReadOnly = .F.
1871:             THIS.HabilitarCampos(IIF(VARTYPE(THIS.this_oBusinessObject) = "O", ;
1872:                 THIS.this_oBusinessObject.this_cEscolha, "ALTERAR"))
1873: 
1874:         CATCH TO loc_oErro
1875:             MsgErro(loc_oErro.Message + CHR(13) + ;
1876:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1877:                     "Procedure: " + loc_oErro.Procedure, ;
1878:                     "Erro em FormPzo.BtnCancelarClick")
1879:         ENDTRY
1880:     ENDPROC
1881: 


### BO (C:\4c\projeto\app\classes\PzoBO.prg):
*==============================================================================
* PzoBO.prg - Business Object para Prazo / Conta de Entrega
* Entidade: Pzo (SIGCDPZO - Prazo e Conta de Entrega por Opera??o)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (sub-form de movimenta??o)
*
* Contexto: Sub-form modal chamado por formularios de movimento (ex: SigAtCrp).
* Recebe referencia ao form pai com cursores TprMvCab, CrSigCdOpe, CrSigMvNfi,
* crTpmMvItn, TprMvCabG. Edita CsPrazE (prazos/fretes por opera??o) e grava
* de volta em crTpmMvItn ao confirmar.
*==============================================================================

DEFINE CLASS PzoBO AS BusinessBase

    *-- Identificacao da entidade (referencia principal: SigMvCab)
    this_cTabela         = "SigMvCab"
    this_cCampoChave     = "EmpDnCrds"

    *-- Chave composta do pedido (monta EmpDnCrds = Emps + Dopes + STR(Numes,6))
    this_cEmps           = ""
    this_cDopesParent    = ""
    this_nNumesParent    = 0
    this_cEmpDnCrds      = ""

    *-- Modo de operacao do form pai (INSERIR / ALTERAR / VISUALIZAR)
    this_cEscolha        = ""

    *-- Dados do cabecalho do movimento (TprMvCab) necessarios para validacoes
    this_dDatasParent    = {}
    this_nPrazoEnts      = 0
    this_cLocalEntsParent = ""
    this_cContaEsParent  = ""
    this_nCodObsParent   = 0
    this_cObsEsParent    = ""
    this_cContaDs        = ""
    this_cContaOs        = ""
    this_nValVars        = 0

    *-- Dados da linha corrente do cursor CsPrazE (por opera??o/abreviacao)
    *   Estrutura: CsPrazE (Dopes c(20), Abrevs c(3), Prazos T, DtEntrs n(1),
    *              nMinEnts n(3), nMaxEnts n(3), VlFretes n(12,2), nFiscals n(1),
    *              LocalEnts n(10), ContaEs c(10), LocEntObs n(1),
    *              DespAces n(12,2), VlSeguros n(12,2))
    this_cDopes          = ""
    this_cAbrevs         = ""
    this_dPrazos         = {}
    this_nDtEntrs        = 0
    this_nMinEnts        = 0
    this_nMaxEnts        = 0
    this_nVlFretes       = 0
    this_nFiscals        = 0
    this_nLocalEnts      = 0
    this_cContaEs        = ""
    this_nLocEntObs      = 0
    this_nDespAces       = 0
    this_nVlSeguros      = 0

    *-- Dados da opera??o corrente (LocTmpOpe: SigCdOpe + SigOpCdc)
    this_nExibSits       = 0
    this_nChCtEntrs      = 0
    this_nDtEntrsOpe     = 0
    this_nDigObs         = 0

    *-- Dados de validacao de valores minimos (crTodosOpe2: SigOpCdd)
    this_nChkUteis       = 0
    this_nMinFretes      = 0
    this_nMinSeguros     = 0
    this_nMinDesps       = 0

    *-- Conta de entrega (lookup SigCdCli via LocTmpOpe + CsPrazE.ContaEs)
    this_cGetConta       = ""
    this_cGetDConta      = ""
    this_cGetCpf         = ""

    *-- Observa??o da linha (TprMvCabG: CodObs, ObsEs / Obses)
    this_nCodObs         = 0
    this_cObsEs          = ""

    *-- Totalizadores exibidos no rodape do form
    *   FrtTotal / DespTotal / SegTotal vem de CrSigMvNfi (nota fiscal)
    *   FrtInformado / DespInformado / SegInformado sao somados do CsPrazE
    this_nFrtTotal       = 0
    this_nFrtInformado   = 0
    this_nDespTotal      = 0
    this_nDespInformado  = 0
    this_nSegTotal       = 0
    this_nSegInformado   = 0

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDnCrds"

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cEmpDnCrds
    ENDPROC

    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    *-- Carrega this_ a partir da linha corrente do cursor nomeado.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes     = TratarNulo(Dopes,     "C")
                THIS.this_cAbrevs    = TratarNulo(Abrevs,    "C")
                THIS.this_dPrazos    = IIF(ISNULL(Prazos), DTOT({}), Prazos)
                THIS.this_nDtEntrs   = TratarNulo(DtEntrs,   "N")
                THIS.this_nMinEnts   = TratarNulo(nMinEnts,  "N")
                THIS.this_nMaxEnts   = TratarNulo(nMaxEnts,  "N")
                THIS.this_nVlFretes  = TratarNulo(VlFretes,  "N")
                THIS.this_nFiscals   = TratarNulo(nFiscals,  "N")
                THIS.this_nLocalEnts = TratarNulo(LocalEnts, "N")
                THIS.this_cContaEs   = TratarNulo(ContaEs,   "C")
                THIS.this_nLocEntObs = TratarNulo(LocEntObs, "N")
                THIS.this_nDespAces  = TratarNulo(DespAces,  "N")
                THIS.this_nVlSeguros = TratarNulo(VlSeguros, "N")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION InicializarDados(par_oFormPai)
    *==========================================================================
    *-- Inicializa CsPrazE a partir dos cursores do formulario pai.
    *-- par_oFormPai: referencia ao form pai (ex: Formsigatcrp).
    *-- Pre-requisito: TprMvCab, CrSigCdOpe, CrSigMvNfi, crTpmMvItn abertos.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_nResult, loc_cEmpDopNum
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgErro("Conex" + CHR(227) + "o com banco de dados n" + ;
                        CHR(227) + "o estabelecida.", "Erro")
            ELSE
                IF !USED("TprMvCab")
                    MsgErro("Cursor TprMvCab n" + CHR(227) + "o est" + ;
                            CHR(225) + " aberto.", "Erro")
                ELSE
                    IF !USED("CrSigCdOpe")
                        MsgErro("Cursor CrSigCdOpe n" + CHR(227) + "o est" + ;
                                CHR(225) + " aberto.", "Erro")
                    ELSE
                        *-- Armazenar dados do cabecalho do movimento
                        SELECT TprMvCab
                        THIS.this_cEmps            = ALLTRIM(TprMvCab.Emps)
                        THIS.this_cDopesParent     = ALLTRIM(TprMvCab.Dopes)
                        THIS.this_nNumesParent     = TprMvCab.Numes
                        THIS.this_cEmpDnCrds       = ALLTRIM(TprMvCab.Emps) + ;
                                                     ALLTRIM(TprMvCab.Dopes) + ;
                                                     STR(TprMvCab.Numes, 6)
                        THIS.this_dDatasParent     = TprMvCab.Datas
                        THIS.this_cLocalEntsParent = ALLTRIM(TprMvCab.LocalEnts)
                        THIS.this_cContaEsParent   = ALLTRIM(TprMvCab.ContaEs)
                        THIS.this_nCodObsParent    = TprMvCab.CodObs
                        THIS.this_cObsEsParent     = ALLTRIM(TprMvCab.ObsEs)
                        THIS.this_cContaDs         = ALLTRIM(TprMvCab.ContaDs)
                        THIS.this_cContaOs         = ALLTRIM(TprMvCab.ContaOs)
                        THIS.this_nValVars         = NVL(TprMvCab.ValVars, 0)

                        *-- Carregar totais das notas fiscais
                        IF USED("CrSigMvNfi")
                            SELECT CrSigMvNfi
                            THIS.this_nFrtTotal  = NVL(CrSigMvNfi.VlFretes, 0)
                            THIS.this_nDespTotal = NVL(CrSigMvNfi.DespAces, 0)
                            THIS.this_nSegTotal  = NVL(CrSigMvNfi.VlSeguros, 0)
                        ENDIF

                        *-- Query 1: dados anteriores do movimento em SigMvCab
                        loc_cEmpDopNum = THIS.this_cEmpDnCrds
                        loc_cSQL = "SELECT Dopes, PrazoEnts, LocalEnts, ContaEs, " + ;
                                   "CodObs, ObsEs " + ;
                                   "FROM SigMvCab " + ;
                                   "WHERE EmpDnCrds = '" + ALLTRIM(loc_cEmpDopNum) + "'"
                        IF USED("CsPedAnt")
                            USE IN CsPedAnt
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPedAnt")
                        IF loc_nResult < 1
                            MsgErro("Falha ao carregar dados anteriores (CsPedAnt).", "Erro")
                        ELSE
                            SELECT CsPedAnt
                            INDEX ON Dopes TAG Dopes

                            *-- Query 2: operacoes via SigCdMop + SigCdOpe + SigOpCdc
                            IF USED("CsPed")
                                USE IN CsPed
                            ENDIF
                            loc_cSQL = "SELECT a.cDopes, a.cnivels AS Dopes, " + ;
                                       "a.nCors, a.padraos, " + ;
                                       "b.abrevs, b.DtEntrs, b.nFiscals, " + ;
                                       "c.nMinEnts, c.nMaxEnts " + ;
                                       "FROM SigCdMop a, SigCdOpe b, SigOpCdc c " + ;
                                       "WHERE a.cDopes = '" + ALLTRIM(CrSigCdOpe.Dopes) + "' " + ;
                                       "AND a.cnivels = b.dopes " + ;
                                       "AND b.Abrevs <> ' ' AND b.Dopes = c.Dopes"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPed")
                            IF loc_nResult < 1
                                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(245) + ;
                                        "es do pedido (CsPed).", "Erro")
                            ELSE
                                SELECT CsPed
                                INDEX ON nCors  TAG nCors
                                INDEX ON Abrevs TAG Abrevs

                                *-- Query 3: valores minimos por operacao (SigOpCdd)
                                IF USED("crTodosOpe2")
                                    USE IN crTodosOpe2
                                ENDIF
                                loc_cSQL = "SELECT Dopes, chkUteis, MinFretes, " + ;
                                           "MinSeguros, MinDesps FROM SigOpCdd"
                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTodosOpe2")
                                IF loc_nResult < 1
                                    MsgErro("Falha ao carregar valores m" + CHR(237) + ;
                                            "nimos (crTodosOpe2).", "Erro")
                                ELSE
                                    SELECT crTodosOpe2
                                    INDEX ON Dopes TAG Dopes

                                    *-- Query 4: LocEntObs/chkUteis por operacao
                                    IF USED("CsPedOpe2")
                                        USE IN CsPedOpe2
                                    ENDIF
                                    loc_cSQL = "SELECT b.dopes, c.LocEntObs, c.chkUteis " + ;
                                               "FROM SigCdMop a, SigCdOpe b, SigOpCdd c " + ;
                                               "WHERE a.cDopes = '" + ;
                                               ALLTRIM(CrSigCdOpe.Dopes) + "' " + ;
                                               "AND a.cnivels = b.dopes " + ;
                                               "AND b.Abrevs <> ' ' AND b.Dopes = c.Dopes"
                                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsPedOpe2")
                                    IF loc_nResult < 1
                                        MsgErro("Falha ao carregar dados de opera" + ;
                                                CHR(231) + CHR(227) + "o (CsPedOpe2).", "Erro")
                                    ELSE
                                        SELECT CsPedOpe2
                                        INDEX ON Dopes TAG Dopes

                                        *-- Abreviaturas distintas dos itens do movimento
                                        IF USED("Itens")
                                            USE IN Itens
                                        ENDIF
                                        SELECT DISTINCT AbrevIs FROM crTpmMvItn ;
                                            WHERE Cpros <> ' ' AND Qtds <> 0 ;
                                            INTO CURSOR Itens READWRITE

                                        *-- Montar CsPedidos: CsPed x Itens
                                        IF USED("CsPedidos")
                                            USE IN CsPedidos
                                        ENDIF
                                        SELECT a.*, 0 AS LocEntObs ;
                                            FROM CsPed a, Itens b ;
                                            WHERE a.Abrevs = b.AbrevIs ;
                                            INTO CURSOR CsPedidos READWRITE
                                        SELECT CsPedidos
                                        INDEX ON nCors  TAG nCors
                                        INDEX ON Abrevs TAG Abrevs

                                        *-- Criar CsPrazE
                                        IF USED("CsPrazE")
                                            USE IN CsPrazE
                                        ENDIF
                                        SET NULL ON
                                        CREATE CURSOR CsPrazE ( ;
                                            Dopes     C(20)    NULL, ;
                                            Abrevs    C(3)     NULL, ;
                                            Prazos    T        NULL, ;
                                            DtEntrs   N(1)     NULL, ;
                                            nMinEnts  N(3)     NULL, ;
                                            nMaxEnts  N(3)     NULL, ;
                                            VlFretes  N(12,2)  NULL, ;
                                            nFiscals  N(1)     NULL, ;
                                            LocalEnts N(10)    NULL, ;
                                            ContaEs   C(10)    NULL, ;
                                            LocEntObs N(1)     NULL, ;
                                            DespAces  N(12,2)  NULL, ;
                                            VlSeguros N(12,2)  NULL )
                                        SET NULL OFF

                                        *-- Popular CsPrazE escaneando CsPedidos
                                        SELECT CsPedidos
                                        SCAN
                                            =SEEK(CsPedidos.Dopes, "CsPedOpe2", "Dopes")

                                            INSERT INTO CsPrazE ;
                                                (Dopes, Abrevs, Prazos, DtEntrs, ;
                                                 nMinEnts, nMaxEnts, VlFretes, ;
                                                 nFiscals, LocEntObs) ;
                                                VALUES ( ;
                                                    CsPedidos.Dopes, ;
                                                    CsPedidos.Abrevs, ;
                                                    IIF(EMPTY(TprMvCab.PrazoEnts), ;
                                                        DTOT({}), ;
                                                        TprMvCab.PrazoEnts), ;
                                                    CsPedidos.DtEntrs, ;
                                                    CsPedidos.nMinEnts, ;
                                                    CsPedidos.nMaxEnts, ;
                                                    0, ;
                                                    CsPedidos.nfiscals, ;
                                                    NVL(CsPedOpe2.LocEntObs, 0) )

                                            SELECT CsPedidos

                                            IF INLIST(CsPedidos.DtEntrs, 3, 4, 5, 6)
                                                REPLACE LocalEnts WITH TprMvCab.LocalEnts, ;
                                                        ContaEs   WITH TprMvCab.ContaEs ;
                                                        IN CsPrazE
                                            ENDIF

                                            INSERT INTO TprMvCabG ;
                                                (Dopes, Abrevs, CodObs, ObsEs) ;
                                                VALUES (CsPedidos.Dopes, ;
                                                        CsPedidos.Abrevs, ;
                                                        TprMvCab.CodObs, ;
                                                        TprMvCab.ObsEs)

                                            SELECT CsPedidos

                                            *-- Restaurar prazos/contas do pedido anterior
                                            =SEEK(CsPedidos.Dopes, "CsPedAnt", "Dopes")
                                            IF !EOF("CsPedAnt")
                                                REPLACE Prazos WITH IIF( ;
                                                        EMPTY(TprMvCab.PrazoEnts), ;
                                                        IIF(EMPTY(CsPedAnt.PrazoEnts), ;
                                                            DTOT({}), ;
                                                            CsPedAnt.PrazoEnts), ;
                                                        TprMvCab.PrazoEnts), ;
                                                        LocalEnts WITH CsPedAnt.LocalEnts, ;
                                                        ContaEs   WITH CsPedAnt.ContaEs ;
                                                        IN CsPrazE
                                                REPLACE CodObs WITH CsPedAnt.CodObs, ;
                                                        ObsEs  WITH CsPedAnt.ObsEs ;
                                                        IN TprMvCabG
                                                SELECT CsPedidos
                                            ENDIF
                                        ENDSCAN

                                        SELECT CsPrazE
                                        GO TOP
                                        IF RECCOUNT("CsPrazE") = 0
                                            MsgAviso("N" + CHR(227) + "o h" + ;
                                                     CHR(225) + " opera" + CHR(231) + ;
                                                     CHR(245) + "es de prazo para " + ;
                                                     "este movimento.", "Aviso")
                                        ELSE
                                            THIS.AtualizarTotais()
                                            loc_lSucesso = .T.
                                        ENDIF
                                    ENDIF  && CsPedOpe2
                                ENDIF  && crTodosOpe2
                            ENDIF  && CsPed
                        ENDIF  && CsPedAnt
                    ENDIF  && CrSigCdOpe
                ENDIF  && TprMvCab
            ENDIF  && gnConnHandle

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoLinhaGrid(par_cDopes)
    *==========================================================================
    *-- Carrega dados de SigCdOpe+SigOpCdc para a linha corrente do grid.
    *-- Popula this_nExibSits, this_nChCtEntrs, this_nDtEntrsOpe, this_nDigObs.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Dopes, a.ExibSits, b.ChCtEntrs, b.DtEntrs, b.DigObs " + ;
                       "FROM SigCdOpe a, SigOpCdc b " + ;
                       "WHERE a.Dopes = '" + ALLTRIM(par_cDopes) + "' " + ;
                       "AND a.dopes = b.dopes"
            IF USED("LocTmpOpe")
                USE IN LocTmpOpe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocTmpOpe")
            IF loc_nResult >= 1
                SELECT LocTmpOpe
                GO TOP
                THIS.this_nExibSits   = NVL(LocTmpOpe.ExibSits,  0)
                THIS.this_nChCtEntrs  = NVL(LocTmpOpe.ChCtEntrs, 0)
                THIS.this_nDtEntrsOpe = NVL(LocTmpOpe.DtEntrs,   0)
                THIS.this_nDigObs     = NVL(LocTmpOpe.DigObs,    0)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoLinhaGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Confirmar()
    *==========================================================================
    *-- Valida todos os prazos e atualiza crTpmMvItn com os dados de CsPrazE.
    *-- Retorna .T. se confirmado com sucesso.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_lcMsg, loc_ldDat, loc_ldEnt, loc_tEmpty
        loc_lSucesso = .F.
        loc_tEmpty   = DTOT({})

        TRY
            IF !USED("CsPrazE")
                MsgErro("Cursor CsPrazE n" + CHR(227) + "o est" + CHR(225) + ;
                        " aberto.", "Erro")
            ELSE
                IF !USED("crTpmMvItn")
                    MsgErro("Cursor crTpmMvItn n" + CHR(227) + "o est" + ;
                            CHR(225) + " aberto.", "Erro")
                ELSE
                    *-- Limpar campos de entrega antes de regravar
                    UPDATE crTpmMvItn ;
                        SET PrzEnts   = m.loc_tEmpty, ;
                            ValFrts   = 0, ;
                            LocalEnts = 0, ;
                            ValSegs   = 0, ;
                            ContaEs   = "", ;
                            DespAces  = 0

                    loc_lSucesso = .T.

                    *-- Escanear CsPrazE validando e atualizando crTpmMvItn
                    SELECT CsPrazE
                    SCAN WHILE loc_lSucesso
                        *-- Validar prazo de entrega se operacao exige data
                        IF INLIST(CsPrazE.DtEntrs, 1, 4, 6)
                            IF EMPTY(CsPrazE.Prazos)
                                MsgAviso("Prazo de Entrega da Opera" + CHR(231) + ;
                                         CHR(227) + "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                         " deve ser informado...", ;
                                         "Obrigat" + CHR(243) + "rio")
                                loc_lSucesso = .F.
                            ENDIF

                            IF loc_lSucesso
                                loc_ldDat = TTOD(CsPrazE.Prazos)
                                IF loc_ldDat < THIS.this_dDatasParent
                                    MsgAviso("Prazo de Entrega da Opera" + ;
                                             CHR(231) + CHR(227) + "o " + ;
                                             ALLTRIM(CsPrazE.Dopes) + ;
                                             " deve ser maior que a Data da " + ;
                                             "Movimenta" + CHR(231) + CHR(227) + "o...", ;
                                             "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND CsPrazE.nMinEnts > 0
                                loc_ldEnt = THIS.this_dDatasParent + CsPrazE.nMinEnts
                                IF TTOD(CsPrazE.Prazos) < loc_ldEnt
                                    MsgAviso("Prazo de Entrega M" + CHR(237) + ;
                                             "nimo da Opera" + CHR(231) + CHR(227) + ;
                                             "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                             " " + CHR(233) + " " + DTOC(loc_ldEnt) + ;
                                             "...", "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND CsPrazE.nMaxEnts > 0
                                loc_ldEnt = THIS.this_dDatasParent + CsPrazE.nMaxEnts
                                IF TTOD(CsPrazE.Prazos) > loc_ldEnt
                                    MsgAviso("Prazo de Entrega M" + CHR(225) + ;
                                             "ximo da Opera" + CHR(231) + CHR(227) + ;
                                             "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                             " " + CHR(233) + " " + DTOC(loc_ldEnt) + ;
                                             "...", "Data Inv" + CHR(225) + "lida")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Validar local de entrega obrigatorio
                        IF loc_lSucesso AND CsPrazE.LocEntObs = 1 AND ;
                           INLIST(CsPrazE.DtEntrs, 3, 4, 5, 6) AND ;
                           CsPrazE.LocalEnts = 0
                            MsgAviso("Local de Entrega da Opera" + CHR(231) + ;
                                     CHR(227) + "o " + ALLTRIM(CsPrazE.Dopes) + ;
                                     " n" + CHR(227) + "o Informado!!!", ;
                                     "Obrigat" + CHR(243) + "rio")
                            loc_lSucesso = .F.
                        ENDIF

                        *-- Validar valores minimos (Frete / Desp. Acessorias)
                        IF loc_lSucesso AND USED("crTodosOpe2")
                            =SEEK(CsPrazE.Dopes, "crTodosOpe2", "Dopes")
                            loc_lcMsg = ""
                            IF !EOF("crTodosOpe2")
                                IF !EMPTY(crTodosOpe2.MinFretes) AND ;
                                   (CsPrazE.VlFretes < crTodosOpe2.MinFretes)
                                    loc_lcMsg = loc_lcMsg + ;
                                                IIF(EMPTY(loc_lcMsg), "", " / ") + ;
                                                "Frete"
                                ENDIF
                                IF !EMPTY(crTodosOpe2.MinDesps) AND ;
                                   (CsPrazE.DespAces < crTodosOpe2.MinDesps)
                                    loc_lcMsg = loc_lcMsg + ;
                                                IIF(EMPTY(loc_lcMsg), "", " / ") + ;
                                                "Desp. Acess" + CHR(243) + "rias"
                                ENDIF
                                IF !EMPTY(loc_lcMsg)
                                    MsgAviso("Existem Valores Na Opera" + CHR(231) + ;
                                             CHR(227) + "o Abaixo do M" + CHR(237) + ;
                                             "nimo : " + loc_lcMsg, "ERRO")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF
                            SELECT CsPrazE
                        ENDIF

                        *-- Atualizar crTpmMvItn com dados validados
                        IF loc_lSucesso
                            UPDATE crTpmMvItn SET ;
                                PrzEnts   = CsPrazE.Prazos, ;
                                ValFrts   = CsPrazE.VlFretes, ;
                                LocalEnts = CsPrazE.LocalEnts, ;
                                ValSegs   = CsPrazE.VlSeguros, ;
                                ContaEs   = CsPrazE.ContaEs, ;
                                DespAces  = CsPrazE.DespAces ;
                                WHERE ALLTRIM(AbrevIs) = ALLTRIM(CsPrazE.Abrevs)
                            SELECT CsPrazE
                        ENDIF
                    ENDSCAN

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("ATUALIZAR")
                    ENDIF
                ENDIF  && crTpmMvItn
            ENDIF  && CsPrazE

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Confirmar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE AtualizarTotais()
    *==========================================================================
    *-- Recalcula this_nFrtInformado/this_nDespInformado/this_nSegInformado.
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF USED("CsPrazE")
                SELECT SUM(NVL(VlFretes, 0))  AS TotFrt, ;
                       SUM(NVL(DespAces, 0))  AS TotDesp, ;
                       SUM(NVL(VlSeguros, 0)) AS TotSeg ;
                    FROM CsPrazE ;
                    INTO CURSOR cursor_4c_TotaisPzo READWRITE
                IF USED("cursor_4c_TotaisPzo")
                    SELECT cursor_4c_TotaisPzo
                    GO TOP
                    THIS.this_nFrtInformado  = NVL(TotFrt,  0)
                    THIS.this_nDespInformado = NVL(TotDesp, 0)
                    THIS.this_nSegInformado  = NVL(TotSeg,  0)
                    USE IN cursor_4c_TotaisPzo
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.AtualizarTotais")
        ENDTRY
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoConta(par_cConta, par_nChCtEntrs)
    *==========================================================================
    *-- Carrega dados de cliente (conta de entrega) de SigCdCli.
    *-- Popula this_cGetConta, this_cGetDConta, this_cGetCpf.
    *-- Retorna .T. se encontrou e passou nas validacoes.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cConta)
                THIS.this_cGetConta  = ""
                THIS.this_cGetDConta = ""
                THIS.this_cGetCpf    = ""
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT IClis, RClis, Cpfs FROM SigCdCli " + ;
                           "WHERE IClis = '" + ALLTRIM(par_cConta) + "'"
                IF USED("CrTmpCli")
                    USE IN CrTmpCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrTmpCli")
                IF loc_nResult < 1
                    MsgErro("Falha ao carregar dados do cliente.", "Erro")
                ELSE
                    SELECT CrTmpCli
                    GO TOP
                    IF !EOF("CrTmpCli")
                        *-- Validar conta de entrega (nao pode ser igual a destino/origem)
                        IF par_nChCtEntrs = 1 AND ;
                           ALLTRIM(CrTmpCli.IClis) == ALLTRIM(THIS.this_cContaDs)
                            MsgAviso("Conta de Entrega Tem que ser diferente da " + ;
                                     "Conta de Destino", ;
                                     "Valida" + CHR(231) + CHR(227) + "o")
                        ELSE
                            IF par_nChCtEntrs = 2 AND ;
                               ALLTRIM(CrTmpCli.IClis) == ALLTRIM(THIS.this_cContaOs)
                                MsgAviso("Conta de Entrega Tem que ser diferente da " + ;
                                         "Conta de Origem", ;
                                         "Valida" + CHR(231) + CHR(227) + "o")
                            ELSE
                                THIS.this_cGetConta  = ALLTRIM(CrTmpCli.IClis)
                                THIS.this_cGetDConta = ALLTRIM(CrTmpCli.RClis)
                                THIS.this_cGetCpf    = ALLTRIM(CrTmpCli.Cpfs)
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("CrTmpCli")
                        USE IN CrTmpCli
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoConta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION CarregarInfoObservacao(par_nCodObs, par_cDopesOpe)
    *==========================================================================
    *-- Busca observacao de SigCdObs filtrando pela faixa da operacao.
    *-- Popula this_nCodObs e this_cObsEs. Retorna .T. se encontrou.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        LOCAL loc_nIni, loc_nFim
        loc_lSucesso = .F.

        TRY
            *-- Buscar faixa de observacoes da operacao
            loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
                       "WHERE Dopes = '" + ALLTRIM(par_cDopesOpe) + "'"
            IF USED("LocalOpe")
                USE IN LocalOpe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalOpe")
            IF loc_nResult < 1
                MsgErro("Falha ao carregar dados da opera" + CHR(231) + ;
                        CHR(227) + "o.", "Erro")
            ELSE
                SELECT LocalOpe
                GO TOP
                loc_nIni = IIF(!EOF("LocalOpe") AND !EMPTY(LocalOpe.ObsInis), ;
                               LocalOpe.ObsInis, 0)
                loc_nFim = IIF(!EOF("LocalOpe") AND !EMPTY(LocalOpe.ObsFins), ;
                               LocalOpe.ObsFins, 999)
                IF USED("LocalOpe")
                    USE IN LocalOpe
                ENDIF

                *-- Carregar observacoes na faixa da operacao
                loc_cSQL = "SELECT Codigos, Descrs, Observas FROM SigCdObs " + ;
                           "WHERE Codigos BETWEEN " + TRANSFORM(loc_nIni) + ;
                           " AND " + TRANSFORM(loc_nFim)
                IF USED("crLocalObs")
                    USE IN crLocalObs
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalObs")
                IF loc_nResult < 1
                    MsgErro("Falha ao carregar observa" + CHR(231) + CHR(245) + ;
                            "es (crLocalObs).", "Erro")
                ELSE
                    SELECT crLocalObs
                    INDEX ON Codigos TAG Codigos

                    IF SEEK(par_nCodObs, "crLocalObs", "Codigos")
                        THIS.this_nCodObs = NVL(crLocalObs.Codigos, 0)
                        THIS.this_cObsEs  = ALLTRIM(NVL(crLocalObs.Observas, ""))
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.CarregarInfoObservacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Inserir()
    *==========================================================================
    *-- Operacional: registra auditoria de insercao se CsPrazE inicializado.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("CsPrazE n" + CHR(227) + "o inicializado. " + ;
                        "Chamar InicializarDados() antes de Inserir().", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em PzoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION Atualizar()
    *==========================================================================
    *-- Operacional: delega para Confirmar() que valida e salva CsPrazE.
    *==========================================================================
        RETURN THIS.Confirmar()
    ENDPROC

    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
    *==========================================================================
        LOCAL loc_oErro, loc_cSQL
        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND ;
               !EMPTY(THIS.this_cEmpDnCrds) AND !EMPTY(gc_4c_UsuarioLogado)
                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                           "(DataHora, Usuario, Operacao, Tabela, " + ;
                           "ChavePrimaria, Empresa) " + ;
                           "VALUES (" + ;
                           "GETDATE(), " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL("SigMvCab") + ", " + ;
                           EscaparSQL(THIS.this_cEmpDnCrds) + ", " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

