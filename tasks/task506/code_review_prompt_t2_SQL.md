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

### FORM (C:\4c\projeto\app\forms\operacionais\FormPzo.prg) - TRECHOS RELEVANTES PARA PASS SQL (1955 linhas total):

*-- Linhas 84 a 124:
84: 
85:                     *-- Indexar TprMvCabG por Abrevs para os SEEKs na navegacao
86:                     IF USED("TprMvCabG")
87:                         SELECT TprMvCabG
88:                         INDEX ON Abrevs TAG Abrevs
89:                     ENDIF
90: 
91:                     *-- Construir interface plana (sem PageFrame)
92:                     THIS.ConfigurarCabecalho()
93:                     THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
94:                     THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
95:                     THIS.ConfigurarPaginaLista()
96:                     THIS.ConfigurarBotaoEncerrar()
97:                     THIS.BindEventos()
98: 
99:                     *-- Atualizar totais iniciais na tela (usando totais da NF do pai)
100:                     THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
101:                     THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
102:                     THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
103:                     THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
104:                     THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal
105:                     THIS.txt_4c_SegI.Value  = THIS.this_oBusinessObject.this_nSegInformado
106: 
107:                     *-- Posicionar na primeira linha e atualizar containers
108:                     IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
109:                         SELECT CsPrazE
110:                         GO TOP
111:                         THIS.AtualizarLinhaGrid(1)
112:                     ENDIF
113: 
114:                     loc_lSucesso = .T.
115:                 ENDIF
116:             ENDIF
117: 
118:         CATCH TO loc_oErro
119:             MsgErro(loc_oErro.Message + CHR(13) + ;
120:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
121:                     "Procedure: " + loc_oErro.Procedure, ;
122:                     "Erro em FormPzo.InicializarForm")
123:         ENDTRY
124: 

*-- Linhas 191 a 209:
191:         *-- 3. Container de entrega (inicialmente oculto ate selecao de linha)
192:         THIS.ConfigurarContainerEntrega()
193: 
194:         *-- 4. Conectar grid ao cursor CsPrazE (RecordSource + ControlSources)
195:         THIS.ConfigurarGridDados()
196: 
197:         *-- 5. Formas decorativas (Shape1/3/4/5 do original SCX)
198:         THIS.ConfigurarFormas()
199:     ENDPROC
200: 
201:     *==========================================================================
202:     * ConfigurarPaginaDados - Campos DADOS parte 1 (totais + observacao)
203:     *   Forma OPERACIONAL sem PageFrame - agrega os controles de dados abaixo
204:     *   do grid: area de totais Frete/Desp/Seguro + container de observacao
205:     *==========================================================================
206:     PROTECTED PROCEDURE ConfigurarPaginaDados()
207:         *-- Area de totais (Frete/Despesas Acessorias/Seguro): 6 labels + 6 textboxes
208:         THIS.ConfigurarAreaTotais()
209: 

*-- Linhas 249 a 267:
249:             .FontSize          = 8
250:             .AllowHeaderSizing = .F.
251:             .AllowRowSizing    = .F.
252:             .DeleteMark        = .F.
253:             .HeaderHeight      = 20
254:             .RowHeight         = 16
255:             .ScrollBars        = 2
256:             .SplitBar          = .F.
257:             .GridLineColor     = RGB(238, 238, 238)
258:             .Themes            = .F.
259:             .Visible           = .T.
260:         ENDWITH
261: 
262:         *-- Column1: Movimentacao (Dopes) - somente leitura
263:         loc_oCol = loc_oGrid.Column1
264:         WITH loc_oCol
265:             .ColumnOrder      = 1
266:             .Width            = 290
267:             .ReadOnly         = .T.

*-- Linhas 359 a 398:
359:     ENDPROC
360: 
361:     *==========================================================================
362:     * ConfigurarGridDados - Define RecordSource/ControlSources e coloracao
363:     *==========================================================================
364:     PROTECTED PROCEDURE ConfigurarGridDados()
365:         LOCAL loc_oGrid
366:         LOCAL loc_cDynFc, loc_nQtdSc, loc_nVez, loc_nCor
367:         loc_oGrid = THIS.grd_4c_Dados
368: 
369:         loc_oGrid.RecordSource     = "CsPrazE"
370:         loc_oGrid.RecordSourceType = 1
371:         loc_oGrid.Column1.ControlSource = "CsPrazE.Dopes"
372:         loc_oGrid.Column2.ControlSource = "CsPrazE.Prazos"
373:         loc_oGrid.Column3.ControlSource = "CsPrazE.VlFretes"
374:         loc_oGrid.Column4.ControlSource = "CsPrazE.DespAces"
375:         loc_oGrid.Column5.ControlSource = "CsPrazE.VlSeguros"
376:         loc_oGrid.Refresh()
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
964:         LOCAL loc_oErro
965:         TRY
966:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
967:                 THIS.this_oBusinessObject.AtualizarTotais()
968:                 THIS.txt_4c_FrtT.Value  = THIS.this_oBusinessObject.this_nFrtTotal
969:                 THIS.txt_4c_FrtI.Value  = THIS.this_oBusinessObject.this_nFrtInformado
970:                 THIS.txt_4c_DespT.Value = THIS.this_oBusinessObject.this_nDespTotal
971:                 THIS.txt_4c_DespI.Value = THIS.this_oBusinessObject.this_nDespInformado
972:                 THIS.txt_4c_SegT.Value  = THIS.this_oBusinessObject.this_nSegTotal

*-- Linhas 1080 a 1105:
1080: 
1081:             IF loc_lContinuar
1082:                 *-- Buscar dados do cliente para abrir FormEnd
1083:                 loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = '" + ;
1084:                            ALLTRIM(loc_cIClis) + "'"
1085:                 IF USED("crTSigDCompCli")
1086:                     USE IN crTSigDCompCli
1087:                 ENDIF
1088:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTSigDCompCli")
1089:                 IF loc_nResult >= 1
1090:                     SELECT crTSigDCompCli
1091:                     GO TOP
1092:                     loc_cGrupo = ALLTRIM(NVL(crTSigDCompCli.Grupos, ""))
1093:                     loc_cNome  = ALLTRIM(NVL(crTSigDCompCli.RClis,  ""))
1094:                     loc_nLocal = NVL(CsPrazE.LocalEnts, 0)
1095: 
1096:                     DO FORM FormEnd WITH ;
1097:                         loc_cGrupo, loc_cIClis, loc_cNome, ;
1098:                         THIS.this_oBusinessObject.this_cEscolha, .NULL., loc_nLocal
1099:                 ENDIF
1100:                 IF USED("crTSigDCompCli")
1101:                     USE IN crTSigDCompCli
1102:                 ENDIF
1103:             ENDIF
1104: 
1105:         CATCH TO loc_oErro

*-- Linhas 1139 a 1165:
1139:         THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = loc_cCpfFmt
1140: 
1141:         TRY
1142:             loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs FROM SigCdCli WHERE " + ;
1143:                        "RTRIM(Cpfs) = " + EscaparSQL(ALLTRIM(loc_cCpfFmt))
1144:             IF USED("cursor_4c_BuscaCpf")
1145:                 USE IN cursor_4c_BuscaCpf
1146:             ENDIF
1147:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")
1148: 
1149:             IF loc_nResult >= 1 AND !EOF("cursor_4c_BuscaCpf")
1150:                 SELECT cursor_4c_BuscaCpf
1151:                 GO TOP
1152:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(NVL(cursor_4c_BuscaCpf.IClis, ""))
1153:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.RClis,  ""))
1154:                 IF USED("CsPrazE")
1155:                     REPLACE ContaEs WITH ALLTRIM(cursor_4c_BuscaCpf.IClis) IN CsPrazE
1156:                 ENDIF
1157:                 loc_lSucesso = .T.
1158:             ENDIF
1159:             IF USED("cursor_4c_BuscaCpf")
1160:                 USE IN cursor_4c_BuscaCpf
1161:             ENDIF
1162: 
1163:             IF !loc_lSucesso
1164:                 THIS.AbrirBuscaCpf(loc_cCpfFmt)
1165:             ENDIF

*-- Linhas 1180 a 1214:
1180: 
1181:         TRY
1182:             *-- SQL filtrado por CPF ou codigo (starts-with)
1183:             loc_cSQL = "SELECT IClis AS IClis, Cpfs AS Cpfs, RClis AS RClis " + ;
1184:                        "FROM SigCdCli WHERE RTRIM(Cpfs) LIKE " + ;
1185:                        EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
1186:                        " OR RTRIM(IClis) LIKE " + ;
1187:                        EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
1188:                        " ORDER BY Cpfs"
1189:             IF USED("cursor_4c_BuscaCpf")
1190:                 USE IN cursor_4c_BuscaCpf
1191:             ENDIF
1192:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")
1193:             IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaCpf") = 0
1194:                 IF USED("cursor_4c_BuscaCpf")
1195:                     USE IN cursor_4c_BuscaCpf
1196:                 ENDIF
1197:                 *-- Fallback: lista completa
1198:                 SQLEXEC(gnConnHandle, ;
1199:                     "SELECT IClis AS IClis, Cpfs AS Cpfs, RClis AS RClis FROM SigCdCli ORDER BY Cpfs", ;
1200:                     "cursor_4c_BuscaCpf")
1201:             ENDIF
1202: 
1203:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1204:             IF VARTYPE(loc_oForm) = "O"
1205:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaCpf"
1206:                 loc_oForm.DefinirCursor("cursor_4c_BuscaCpf", "IClis", "Cpfs", ;
1207:                     "Busca por CPF / CNPJ")
1208:                 IF loc_oForm.Mostrar()
1209:                     THIS.cnt_4c_Entrega.txt_4c_Cpf.Value   = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1210:                     THIS.cnt_4c_Entrega.txt_4c_Conta.Value = ALLTRIM(loc_oForm.cCodigoSelecionado)
1211:                     IF !EMPTY(loc_oForm.cCodigoSelecionado)
1212:                         THIS.this_oBusinessObject.CarregarInfoConta( ;
1213:                             ALLTRIM(loc_oForm.cCodigoSelecionado), ;
1214:                             THIS.this_oBusinessObject.this_nChCtEntrs)

*-- Linhas 1252 a 1306:
1252: 
1253:         TRY
1254:             *-- Busca exata por nome (RClis)
1255:             loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE " + ;
1256:                        "RTRIM(RClis) = " + EscaparSQL(loc_cDConta)
1257:             IF USED("cursor_4c_BuscaDConta")
1258:                 USE IN cursor_4c_BuscaDConta
1259:             ENDIF
1260:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDConta")
1261: 
1262:             IF loc_nResult >= 1 AND !EOF("cursor_4c_BuscaDConta")
1263:                 SELECT cursor_4c_BuscaDConta
1264:                 GO TOP
1265:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(NVL(cursor_4c_BuscaDConta.IClis, ""))
1266:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(NVL(cursor_4c_BuscaDConta.RClis, ""))
1267:                 IF USED("CsPrazE")
1268:                     REPLACE ContaEs WITH ALLTRIM(cursor_4c_BuscaDConta.IClis) IN CsPrazE
1269:                 ENDIF
1270:                 THIS.this_oBusinessObject.CarregarInfoConta( ;
1271:                     ALLTRIM(cursor_4c_BuscaDConta.IClis), ;
1272:                     THIS.this_oBusinessObject.this_nChCtEntrs)
1273:                 THIS.cnt_4c_Entrega.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cGetCpf
1274:                 loc_lSucesso = .T.
1275:             ENDIF
1276:             IF USED("cursor_4c_BuscaDConta")
1277:                 USE IN cursor_4c_BuscaDConta
1278:             ENDIF
1279: 
1280:             IF !loc_lSucesso
1281:                 *-- Busca parcial por nome (starts-with) + picker
1282:                 loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli " + ;
1283:                            "WHERE RTRIM(RClis) LIKE " + EscaparSQL(loc_cDConta + "%") + ;
1284:                            " ORDER BY RClis"
1285:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDConta")
1286:                 IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaDConta") = 0
1287:                     IF USED("cursor_4c_BuscaDConta")
1288:                         USE IN cursor_4c_BuscaDConta
1289:                     ENDIF
1290:                     SQLEXEC(gnConnHandle, ;
1291:                         "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY RClis", ;
1292:                         "cursor_4c_BuscaDConta")
1293:                 ENDIF
1294:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1295:                 IF VARTYPE(loc_oForm) = "O"
1296:                     loc_oForm.this_cCursorDestino = "cursor_4c_BuscaDConta"
1297:                     loc_oForm.DefinirCursor("cursor_4c_BuscaDConta", "IClis", "RClis", ;
1298:                         "Busca de Contas")
1299:                     IF loc_oForm.Mostrar()
1300:                         THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(loc_oForm.cCodigoSelecionado)
1301:                         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1302:                         IF !EMPTY(loc_oForm.cCodigoSelecionado)
1303:                             IF USED("CsPrazE")
1304:                                 REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
1305:                             ENDIF
1306:                             THIS.this_oBusinessObject.CarregarInfoConta( ;

*-- Linhas 1354 a 1389:
1354:         TRY
1355:             *-- SQL filtrado por codigo ou nome (starts-with)
1356:             IF EMPTY(loc_cFiltro)
1357:                 loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY IClis"
1358:             ELSE
1359:                 loc_cSQL = "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli " + ;
1360:                            "WHERE RTRIM(IClis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
1361:                            " OR RTRIM(RClis) LIKE " + EscaparSQL(loc_cFiltro + "%") + ;
1362:                            " ORDER BY IClis"
1363:             ENDIF
1364: 
1365:             IF USED("cursor_4c_BuscaCli")
1366:                 USE IN cursor_4c_BuscaCli
1367:             ENDIF
1368:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1369:             IF loc_nResult < 1 OR RECCOUNT("cursor_4c_BuscaCli") = 0
1370:                 IF USED("cursor_4c_BuscaCli")
1371:                     USE IN cursor_4c_BuscaCli
1372:                 ENDIF
1373:                 SQLEXEC(gnConnHandle, ;
1374:                     "SELECT IClis AS IClis, RClis AS RClis FROM SigCdCli ORDER BY IClis", ;
1375:                     "cursor_4c_BuscaCli")
1376:             ENDIF
1377: 
1378:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
1379:             IF VARTYPE(loc_oForm) = "O"
1380:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaCli"
1381:                 loc_oForm.DefinirCursor("cursor_4c_BuscaCli", "IClis", "RClis", ;
1382:                     "Busca de Contas de Entrega")
1383:                 IF loc_oForm.Mostrar()
1384:                     THIS.cnt_4c_Entrega.txt_4c_Conta.Value  = ALLTRIM(loc_oForm.cCodigoSelecionado)
1385:                     THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ALLTRIM(loc_oForm.cDescricaoSelecionada)
1386:                     IF !EMPTY(loc_oForm.cCodigoSelecionado)
1387:                         IF USED("CsPrazE")
1388:                             REPLACE ContaEs WITH ALLTRIM(loc_oForm.cCodigoSelecionado) IN CsPrazE
1389:                         ENDIF

*-- Linhas 1489 a 1507:
1489:             ENDIF
1490: 
1491:             *-- Capturar valores da linha corrente para herdar
1492:             SELECT CsPrazE
1493:             loc_cDopes    = ALLTRIM(NVL(CsPrazE.Dopes,    ""))
1494:             loc_cAbrevs   = ALLTRIM(NVL(CsPrazE.Abrevs,   ""))
1495:             loc_dPrazoBase= NVL(CsPrazE.Prazos, DATETIME())
1496:             loc_nDtEntrs  = NVL(CsPrazE.DtEntrs,  0)
1497:             loc_nFiscals  = NVL(CsPrazE.nFiscals, 0)
1498:             loc_cContaEs  = ALLTRIM(NVL(CsPrazE.ContaEs, ""))
1499: 
1500:             *-- Adicionar linha em branco herdando contexto
1501:             APPEND BLANK IN CsPrazE
1502:             REPLACE CsPrazE.Dopes     WITH loc_cDopes    ;
1503:                     CsPrazE.Abrevs    WITH loc_cAbrevs   ;
1504:                     CsPrazE.Prazos    WITH loc_dPrazoBase;
1505:                     CsPrazE.DtEntrs   WITH loc_nDtEntrs  ;
1506:                     CsPrazE.nFiscals  WITH loc_nFiscals  ;
1507:                     CsPrazE.nMinEnts  WITH 0             ;

*-- Linhas 1540 a 1558:
1540:                 RETURN
1541:             ENDIF
1542: 
1543:             SELECT CsPrazE
1544:             IF EOF() OR BOF()
1545:                 GO TOP
1546:             ENDIF
1547: 
1548:             *-- Marcar modo edicao no BO (usado por Confirmar)
1549:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1550:                 THIS.this_oBusinessObject.this_cEscolha = "ALTERAR"
1551:             ENDIF
1552: 
1553:             *-- Atualizar paineis suplementares para a linha atual
1554:             THIS.AtualizarLinhaGrid(1)
1555: 
1556:             *-- Colocar foco na primeira coluna editavel (Frete)
1557:             THIS.grd_4c_Dados.SetFocus
1558:             THIS.grd_4c_Dados.ActiveColumn = 1

*-- Linhas 1581 a 1599:
1581:                 RETURN
1582:             ENDIF
1583: 
1584:             SELECT CsPrazE
1585:             IF EOF() OR BOF()
1586:                 GO TOP
1587:             ENDIF
1588: 
1589:             *-- Marcar modo visualizacao no BO
1590:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1591:                 THIS.this_oBusinessObject.this_cEscolha = "VISUALIZAR"
1592:             ENDIF
1593: 
1594:             *-- Bloquear edicao no grid (todas as colunas ReadOnly)
1595:             THIS.grd_4c_Dados.ReadOnly = .T.
1596: 
1597:             *-- Bloquear campos do painel de entrega e observacao
1598:             THIS.cnt_4c_Entrega.txt_4c_Conta.ReadOnly    = .T.
1599:             THIS.cnt_4c_Entrega.txt_4c_DConta.ReadOnly   = .T.

*-- Linhas 1626 a 1662:
1626:                 RETURN
1627:             ENDIF
1628: 
1629:             SELECT CsPrazE
1630:             IF EOF() OR BOF()
1631:                 GO TOP
1632:             ENDIF
1633: 
1634:             loc_cDopes = ALLTRIM(NVL(CsPrazE.Dopes, ""))
1635: 
1636:             IF !MsgConfirma("Confirma a exclusao do prazo da operacao " + ;
1637:                             loc_cDopes + " ?", "Confirmacao")
1638:                 RETURN
1639:             ENDIF
1640: 
1641:             *-- Marcar registro para exclusao e purgar do cursor
1642:             DELETE IN CsPrazE
1643:             SET DELETED ON
1644:             PACK
1645: 
1646:             *-- Reposicionar e atualizar interface
1647:             SELECT CsPrazE
1648:             IF RECCOUNT("CsPrazE") > 0
1649:                 GO TOP
1650:                 THIS.grd_4c_Dados.Refresh
1651:                 THIS.AtualizarLinhaGrid(1)
1652:             ELSE
1653:                 THIS.cnt_4c_Entrega.txt_4c_Conta.Value     = ""
1654:                 THIS.cnt_4c_Entrega.txt_4c_DConta.Value    = ""
1655:                 THIS.cnt_4c_Entrega.txt_4c_Cpf.Value       = ""
1656:                 THIS.cnt_4c_Observacao.txt_4c_CodObs.Value = 0
1657:                 THIS.cnt_4c_Observacao.txt_4c_Obs.Value    = ""
1658:             ENDIF
1659: 
1660:             THIS.AtualizarTotaisNaTela()
1661: 
1662:         CATCH TO loc_oErro

*-- Linhas 1675 a 1720:
1675:         loc_lSucesso = .F.
1676: 
1677:         IF USED("CsPrazE")
1678:             SELECT CsPrazE
1679:             IF RECCOUNT("CsPrazE") > 0
1680:                 GO TOP
1681:                 THIS.grd_4c_Dados.Refresh
1682:                 THIS.AtualizarLinhaGrid(1)
1683:                 THIS.AtualizarTotaisNaTela()
1684:                 loc_lSucesso = .T.
1685:             ENDIF
1686:         ENDIF
1687: 
1688:         RETURN loc_lSucesso
1689:     ENDPROC
1690: 
1691:     *==========================================================================
1692:     * FormParaBO - Copia linha corrente do CsPrazE e containers para o BO
1693:     *   (grid edita cursor diretamente via ControlSource; aqui capturamos
1694:     *    os campos auxiliares visiveis nos containers suplementares)
1695:     *==========================================================================
1696:     FUNCTION FormParaBO()
1697:         LOCAL loc_lSucesso, loc_oErro
1698:         loc_lSucesso = .F.
1699: 
1700:         TRY
1701:             IF !USED("CsPrazE")
1702:                 loc_lSucesso = .F.
1703:             ENDIF
1704: 
1705:             SELECT CsPrazE
1706:             THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(NVL(CsPrazE.Dopes,    ""))
1707:             THIS.this_oBusinessObject.this_cAbrevs    = ALLTRIM(NVL(CsPrazE.Abrevs,   ""))
1708:             THIS.this_oBusinessObject.this_dPrazos    = IIF(ISNULL(CsPrazE.Prazos), DTOT({}), CsPrazE.Prazos)
1709:             THIS.this_oBusinessObject.this_nDtEntrs   = NVL(CsPrazE.DtEntrs,   0)
1710:             THIS.this_oBusinessObject.this_nMinEnts   = NVL(CsPrazE.nMinEnts,  0)
1711:             THIS.this_oBusinessObject.this_nMaxEnts   = NVL(CsPrazE.nMaxEnts,  0)
1712:             THIS.this_oBusinessObject.this_nVlFretes  = NVL(CsPrazE.VlFretes,  0)
1713:             THIS.this_oBusinessObject.this_nFiscals   = NVL(CsPrazE.nFiscals,  0)
1714:             THIS.this_oBusinessObject.this_nLocalEnts = NVL(CsPrazE.LocalEnts, 0)
1715:             THIS.this_oBusinessObject.this_cContaEs   = ALLTRIM(NVL(CsPrazE.ContaEs,  ""))
1716:             THIS.this_oBusinessObject.this_nLocEntObs = NVL(CsPrazE.LocEntObs, 0)
1717:             THIS.this_oBusinessObject.this_nDespAces  = NVL(CsPrazE.DespAces,  0)
1718:             THIS.this_oBusinessObject.this_nVlSeguros = NVL(CsPrazE.VlSeguros, 0)
1719: 
1720:             *-- Container de entrega (quando visivel)

*-- Linhas 1857 a 1875:
1857: 
1858:     *==========================================================================
1859:     * BtnSalvarClick - Sincroniza campos dos containers com BO e atualiza totais
1860:     *   (grid ja edita CsPrazE via ControlSource; aqui persiste auxiliares)
1861:     *==========================================================================
1862:     PROCEDURE BtnSalvarClick()
1863:         LOCAL loc_oErro
1864: 
1865:         TRY
1866:             IF THIS.FormParaBO()
1867:                 THIS.AtualizarTotaisNaTela()
1868:                 THIS.AjustarBotoesPorModo("")
1869:             ENDIF
1870: 
1871:         CATCH TO loc_oErro
1872:             MsgErro(loc_oErro.Message + CHR(13) + ;
1873:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1874:                     "Procedure: " + loc_oErro.Procedure, ;
1875:                     "Erro em FormPzo.BtnSalvarClick")

*-- Linhas 1886 a 1904:
1886:             THIS.LimparCampos()
1887: 
1888:             IF USED("CsPrazE") AND RECCOUNT("CsPrazE") > 0
1889:                 SELECT CsPrazE
1890:                 THIS.AtualizarLinhaGrid(1)
1891:             ENDIF
1892: 
1893:             THIS.grd_4c_Dados.ReadOnly = .F.
1894:             THIS.HabilitarCampos(IIF(VARTYPE(THIS.this_oBusinessObject) = "O", ;
1895:                 THIS.this_oBusinessObject.this_cEscolha, "ALTERAR"))
1896: 
1897:         CATCH TO loc_oErro
1898:             MsgErro(loc_oErro.Message + CHR(13) + ;
1899:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1900:                     "Procedure: " + loc_oErro.Procedure, ;
1901:                     "Erro em FormPzo.BtnCancelarClick")
1902:         ENDTRY
1903:     ENDPROC
1904: 


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

