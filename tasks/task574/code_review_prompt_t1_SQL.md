# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ORIGEM' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CPROS, 0, PNNIVEL, NDOPES, PNNIVEIS, CEMPS, EMPS, DOPES, CODIGOS, QTDS, EMPSUBNS, LNNODE, PNNODEEXP, VALUE, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CRTMPSUB' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CPROS, 0, PNNIVEL, NDOPES, PNNIVEIS, CEMPS, EMPS, DOPES, CODIGOS, QTDS, EMPSUBNS, LNNODE, PNNODEEXP, VALUE, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, CPROS, 0, PNNIVEL, NDOPES, PNNIVEIS, CEMPS, EMPS, DOPES, CODIGOS, QTDS, EMPSUBNS, LNNODE, PNNODEEXP, VALUE, DATAS

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
	lcSqlEstPe = [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, ] + ;
	             [From SigMvPec a ] + ;
	             [Inner Join SigMvCab b on a.EmpDopNums = b.EmpDopNums ] + ;
	             [Left  Join SigMvItn c on a.EmpDopNums = c.EmpDopNums ]+;
			     [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps As EmpSubns, ] + ;
	             [From SigOpDev a ] + ;
	             [Inner Join SigMvCab b on a.EmpDopNums = b.EmpDopNums ] + ;
	             [Left  Join SigMvItn c on a.EmpDopNums = c.EmpDopNums ]+;
	lcSqlEstPe = [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, ] + ;
	             [From SigMvPec a ] + ;
	             [Inner Join SigMvCab b on a.EmpDopNums = b.EmpDopNums ] + ;
	             [Left  Join SigMvItn c on a.EmpDopNums = c.EmpDopNums ]+;
			     [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps As EmpSubns, ] + ;
	             [From SigOpDev a ] + ;
	             [Inner Join SigMvCab b on a.EmpDopNums = b.EmpDopNums ] + ;
	             [Left  Join SigMvItn c on a.EmpDopNums = c.EmpDopNums ]+;
If Thisform.PoDataMgr.SqlExecute(lcSqlEstPe,lcSqlFile) < 1
	lcSqlOpe = [Select Dopes From SigCdOpe Where nDopes = ] + lnDopes
	If Thisform.PoDataMgr.SqlExecute(lcSqlOpe,'crTmpOPe') < 1
	Select &lcSqlFile.
		lcQryBx = [Select a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.Usuars, a.DtAlts, a. Usuals, ] + ;
		          [From SigMvCab a ] + ;
		          [Left Join SigMvItn c On a.EmpDopNums = c.EmpDopNums ] + ;
		If Thisform.PoDataMgr.SqlExecute(lcQryBx,'crTprMvCab') < 1
lcQryEest  = [Select * From SigMvCab Where EmpDopNums = ?lcEmpDopNums]
lcQryEesti = [Select EmpdopNums, cPros, dPros, Sum(Qtds) As Qtds From SigMvItn Where EmpDopNums = ?lcEmpDopNums ] + ;
	ThisForm.poDatamgr.SqlExecute([Select * From SigCdEmp Where cEmps = ']+Alltrim(pcEmps)+['],'crSigCdEmp')
m.loTree1.SelectedStyle = 2
lcQryEest = [Select a.Emps, a.Dopes, a.Numes, a.Notas, a.Datas, a.Datars, a.ChkPagos, Sum(b.qtds) as qtds ] + ;
			  [From SigMvCab a ] + ;
		      [Left Join SigMvItn b on a.EmpDopNums = b.EmpDopNums ] + ;
ThisForm.poDatamgr.SqlExecute(lcQryEest,'crSigMvCab')
Select crSigMvCab
m.loTree1.SelectedStyle = 2
Select crSigMvItn
	Select crSigMvItn
lcSql = [Select nDopes From SigCdOpe Where Dopes = ']+Substr(lcEmpDopNums,4,20)+[']
If Thisform.PoDataMgr.SqlExecute(lcSql,'CrxOpe') < 1
lcQryBx = [Select a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns, Sum(c.Qtds) As Qtds ]+;
          [From SigMvPec a, SigMvCab b, SigMvItn c ]+;
		  [Select a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 As Qtds ]+;
	  	  [From SigMvPec a, SigMvCab b ]+;
		  [Select a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.Emps As EmpSubns, Sum(c.Qtds) As Qtds ]+;
		  [From SigOpDev a, SigMvCab b, SigMvItn c ]+;
ThisForm.poDatamgr.SqlExecute(lcQryBx ,lcBxAlias)
Select &lcBxAlias
Select a.codigos, a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.EmpDopNums, EmpSubns, sum(qtds) as qtds From &lcBxAlias a ;
Select &lcTmpSub
Delete For qtds <> 0
		lcQryBx = [Select usuars, DtAlts, UsuAls ] + ;
		          [From SigMvCab ] + ;
		ThisForm.poDatamgr.SqlExecute(lcQryBx ,'csSigMvCab')
		Select &lcTmpSub
				Select &lcTmpSub
				Select &lcTmpSub
				Select &lcTmpSub
		Select &lcTmpSub
lcSql = [Select Dopes From SigCdOpe Where nDopes = ]+Alltrim(Str(Int(pcCodigo/1000000)))
If Thisform.PoDataMgr.SqlExecute(lcSql,'CrxOpe') < 1
lcQryBx = [Select a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns, Sum(c.Qtds) As Qtds ]+;
          [From SigMvPec a, SigMvCab b, SigMvItn c ]+;
		  [Select a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 As Qtds ]+;
	  	  [From SigMvPec a, SigMvCab b ]+;
		  [Select a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.Emps As EmpSubns, 0 As Qtds ]+;
		  [From SigOpDev a, SigMvCab b ]+;
ThisForm.poDatamgr.SqlExecute(lcQryBx ,lcBxAlias)
Select &lcBxAlias
Select a.codigos, a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.EmpDopNums, EmpSubns, sum(qtds) as qtds From &lcBxAlias a ;
Select &lcTmpSub
Delete For qtds <> 0
		lcQryBx = [Select usuars, DtAlts, UsuAls ] + ;
		          [From SigMvCab ] + ;
		ThisForm.poDatamgr.SqlExecute(lcQryBx ,'csSigMvCab')
		Select &lcTmpSub
				Select &lcTmpSub
				Select &lcTmpSub
		Select &lcTmpSub
lcSqlOpe = [Select nDopes From SigCdOpe Where Dopes = ']+Substr(pcEmpDopNums,4,20)+[']
If Thisform.PoDataMgr.SqlExecute(lcSqlOpe,'crTmpOpe') < 1
	lcSqlEstPe = [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, ] + ;
	             [From SigMvPec a ] + ;
	             [Inner Join SigMvCab b on a.EmpDopNums = b.EmpDopNums ] + ;
	             [Left  Join SigMvItn c on a.EmpDopNums = c.EmpDopNums ]+;
			     [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps As EmpSubns, ] + ;
	             [From SigOpDev a ] + ;
	             [Inner Join SigMvCab b on a.EmpDopNums = b.EmpDopNums ] + ;
	             [Left  Join SigMvItn c on a.EmpDopNums = c.EmpDopNums ]+;
	lcSqlEstPe = [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, ] + ;
	             [From SigMvPec a ] + ;
	             [Inner Join SigMvCab b on a.EmpDopNums = b.EmpDopNums ] + ;
	             [Left  Join SigMvItn c on a.EmpDopNums = c.EmpDopNums ]+;
			     [Select a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps As EmpSubns, ] + ;
	             [From SigOpDev a ] + ;
	             [Inner Join SigMvCab b on a.EmpDopNums = b.EmpDopNums ] + ;
	             [Left  Join SigMvItn c on a.EmpDopNums = c.EmpDopNums ]+;
If Thisform.PoDataMgr.SqlExecute(lcSqlEstPe,lcSqlFile) < 1
			Select &lcSqlFile.
				Select &lcSqlFile.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg) - TRECHOS RELEVANTES PARA PASS SQL (2578 linhas total):

*-- Linhas 108 a 129:
108: * (equivalente a ThisForm.paOperacoes, escopo de FORM - nao reseta entre
109: * cargas, igual ao legado).
110: *
111: * Cada chamada a BO/SQLEXEC troca a work area corrente - por isso todo
112: * SCAN sobre um cursor de nivel se reseleciona apos QUALQUER chamada
113: * aninhada, antes de continuar a leitura da linha ou de deixar o SCAN
114: * avancar (a mesma disciplina do "Select &lcSqlFile."/"Select &lcTmpSub"
115: * espalhado pelo hinivel/subnivel/nohipro/noprod legado - SCAN em VFP nao
116: * preserva sozinho a alias de origem quando o corpo do loop troca de work
117: * area).
118: *
119: * DOIS DESVIOS DELIBERADOS do dump legado, cada um documentado em comentario
120: * no proprio metodo (NoHiPro/NoProd) - ambos looked like erros de
121: * digitacao/copia-e-cola que tornariam o ramo correspondente um no-op
122: * silencioso (nunca desenha nada) se transcritos literalmente, o que
123: * contraria a regra do projeto de paridade funcional completa:
124: *   1. NoHiPro: "If Ascan(ThisForm.paOperacoes,EmpDopNums)" sem "= 0" no
125: *      dump (o par simetrico em NoProd usa "= 0" corretamente) -
126: *      normalizado para "= 0".
127: *   2. NoProd (ramo "pnNivel <> 3"): chamada a HiNivel com 5 argumentos
128: *      (assinatura declarada tem 3) - normalizado para a mesma assinatura
129: *      de 3 argumentos que o SubNivel vizinho, no MESMO bloco, ja usa

*-- Linhas 747 a 765:
747: 
748:     *==========================================================================
749:     * AbrirLookupEmpresa - tenta o match EXATO primeiro (SIGMVMVTBO.
750:     * ValidarEmpresa, equivalente ao Seek/Select do fwBuscaExt); nao achando,
751:     * abre o picker direto (CLAUDE.md - MsgAviso antes do picker eh
752:     * anti-padrao: o campo digitado vira o prefixo de busca).
753:     *==========================================================================
754:     PROTECTED PROCEDURE AbrirLookupEmpresa
755:         LOCAL loc_cValor
756: 
757:         IF !EMPTY(THIS.txt_4c_CEmp.Value)
758:             loc_cValor = ALLTRIM(TRANSFORM(THIS.txt_4c_CEmp.Value))
759: 
760:             IF THIS.this_oBusinessObject.ValidarEmpresa(loc_cValor)
761:                 THIS.txt_4c_CEmp.Value = THIS.this_oBusinessObject.this_cEmps
762:                 RETURN
763:             ENDIF
764: 
765:             THIS.AbrirBuscaEmpresa(loc_cValor)

*-- Linhas 789 a 807:
789:             ENDIF
790: 
791:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
792:                 SELECT cursor_4c_BuscaEmp
793:                 THIS.txt_4c_CEmp.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
794:             ENDIF
795: 
796:             IF USED("cursor_4c_BuscaEmp")
797:                 USE IN cursor_4c_BuscaEmp
798:             ENDIF
799:             loc_oBusca.Release()
800:         ENDIF
801:     ENDPROC
802: 
803:     *==========================================================================
804:     * DopesKeyPress - equivalente a GetDopes.Valid do legado.
805:     *==========================================================================
806:     PROCEDURE DopesKeyPress
807:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

*-- Linhas 869 a 887:
869:             ENDIF
870: 
871:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
872:                 SELECT cursor_4c_BuscaOpe
873:                 THIS.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
874:                 THIS.AtualizarAcessoOficina()
875:             ENDIF
876: 
877:             IF USED("cursor_4c_BuscaOpe")
878:                 USE IN cursor_4c_BuscaOpe
879:             ENDIF
880:             loc_oBusca.Release()
881:         ENDIF
882:     ENDPROC
883: 
884:     *==========================================================================
885:     * AtualizarAcessoOficina - "ThisForm.lAcOficina = fChecaAcesso(
886:     * padl(CsSigCdOpe.nDopes,8,'0'), 'OPPEND')" do legado (fim do
887:     * GetDopes.Valid). fChecaAcesso e' stub global (utils\functions.prg) que

*-- Linhas 1151 a 1169:
1151:     * PrepararArvore - Reproduz o bloco de inicializacao da arvore que o
1152:     * legado repete no inicio de MakeTree e de MakeList:
1153:     *   loTree1.ClearNodes / TipsDisplay = .t. / ExpandOnDClick /
1154:     *   SmallIcons = .t. / PicAlign = 0 / SelectedStyle = 2 / PictureType = 1
1155:     * As tres imagens (indices 1..3 usados em AddPictureNode) sao carregadas
1156:     * uma unica vez, como no Init legado:
1157:     *   AddImage(LoadPicture('\vbmp\Form4.Ico'))    -> 1 (operacao aberta)
1158:     *   AddImage(LoadPicture('\vbmp\depend3.bmp'))  -> 2 (produto/item)
1159:     *   AddImage(LoadPicture('\vbmp\OHist.Ico'))    -> 3 (operacao paga)
1160:     *==========================================================================
1161:     PROTECTED PROCEDURE PrepararArvore()
1162:         LOCAL loc_oErro
1163: 
1164:         IF THIS.ArvoreDisponivel()
1165:             TRY
1166:                 WITH THIS.obj_4c_TreeView
1167:                     IF !THIS.this_lImagensArvore
1168:                         .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "Form4.Ico"))
1169:                         .AddImage(LOADPICTURE(gc_4c_CaminhoIcones + "depend3.bmp"))

*-- Linhas 1176 a 1194:
1176:                     .ExpandOnDClick
1177:                     .SmallIcons    = .T.
1178:                     .PicAlign      = 0
1179:                     .SelectedStyle = 2
1180:                     .PictureType   = 1
1181:                 ENDWITH
1182:             CATCH TO loc_oErro
1183:                 MsgErro("Falha ao preparar a " + CHR(225) + "rvore: " + loc_oErro.Message, "Erro")
1184:             ENDTRY
1185:         ENDIF
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     * CarregarDados - Metodo de carga desta tela (equivalente ao MakeTree do
1190:     * legado). Monta a chave EmpDopNums a partir do filtro, pede os dados ao
1191:     * SIGMVMVTBO e desenha os dois primeiros niveis da arvore:
1192:     *   nivel 1 - a operacao (SigMvCab): Emp - Operacao - Numero - Nota -
1193:     *             Data - Usuario - DtAlt - UsuAlt, NodeCargo = EmpDopNums
1194:     *   nivel 2 - os produtos da operacao (SigMvItn): Produto - Descricao -

*-- Linhas 1222 a 1240:
1222:                 MsgAviso("Empresa, Opera" + CHR(231) + CHR(227) + "o e N" + CHR(250) + ;
1223:                          "mero devem ser informados !!", "Aten" + CHR(231) + CHR(227) + "o")
1224:             ELSE
1225:                 *-- SQLEXEC com handle invalido DISPARA excecao em vez de
1226:                 *-- devolver -1 (medido: "Connection handle is invalid" saindo
1227:                 *-- de SIGMVMVTBO.CarregarOperacao). Sem este TRY o usuario
1228:                 *-- veria o "Program Error" CRU do VFP no lugar do dialogo do
1229:                 *-- sistema. RETURN so DEPOIS do ENDTRY (CLAUDE.md #1).
1230:                 TRY
1231:                     loc_lCarregou = THIS.this_oBusinessObject.CarregarOperacao( ;
1232:                         loc_cEmps, loc_cDopes, loc_nNumes)
1233: 
1234:                     IF loc_lCarregou
1235:                         IF !THIS.this_oBusinessObject.CarregarItens(loc_cEmpDopNums)
1236:                             MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
1237:                                      "Aten" + CHR(231) + CHR(227) + "o")
1238:                         ENDIF
1239: 
1240:                         *-- ThisForm.pcEmpDopNums[1,1] / [1,2] = 1 do MakeTree

*-- Linhas 1278 a 1296:
1278: 
1279:             TRY
1280:                 IF USED("cursor_4c_Cab")
1281:                     SELECT cursor_4c_Cab
1282:                     GO TOP
1283: 
1284:                     *-- Iif(crSigMvCab.ChkPagos, 3, 1) do legado. A coluna bit
1285:                     *-- chega ora Logico ora Numerico conforme o driver, por
1286:                     *-- isso le-se a property ja normalizada pelo BO (#13).
1287:                     loc_nIconeCab = IIF(THIS.this_oBusinessObject.this_lChkPagos, 3, 1)
1288: 
1289:                     loc_cTexto = ALLTRIM(TratarNulo(cursor_4c_Cab.Emps, "")) + " - " + ;
1290:                         ALLTRIM(TratarNulo(cursor_4c_Cab.Dopes, "")) + " - " + ;
1291:                         ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Cab.Numes, 0), "999999")) + " - " + ;
1292:                         ALLTRIM(TratarNulo(cursor_4c_Cab.Notas, "")) + " - " + ;
1293:                         DTOC(ConverterParaData(cursor_4c_Cab.Datas)) + " - " + ;
1294:                         ALLTRIM(TratarNulo(cursor_4c_Cab.Usuars, "")) + " - " + ;
1295:                         DTOC(ConverterParaData(cursor_4c_Cab.DtAlts)) + " - " + ;
1296:                         ALLTRIM(TratarNulo(cursor_4c_Cab.Usuals, ""))

*-- Linhas 1306 a 1357:
1306:                 ENDIF
1307: 
1308:                 IF USED("cursor_4c_Itens")
1309:                     SELECT cursor_4c_Itens
1310:                     GO TOP
1311: 
1312:                     SCAN
1313:                         loc_cProduto = ALLTRIM(TratarNulo(cursor_4c_Itens.cPros, ""))
1314: 
1315:                         loc_cTexto = loc_cProduto + " - " + ;
1316:                             ALLTRIM(TratarNulo(cursor_4c_Itens.dPros, "")) + " - Qtde : " + ;
1317:                             ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Itens.Qtds, 0), "999,999.99"))
1318: 
1319:                         WITH THIS.obj_4c_TreeView
1320:                             loc_nNo = .AddPictureNode(loc_cTexto, 0, 2, 2, 0, 0)
1321:                             .NodeHeader(loc_nNo)     = .F.
1322:                             .NodeExpanded(loc_nNo)   = .F.
1323:                             .NodeShowChecks(loc_nNo) = .F.
1324:                             .NodeFontBold(loc_nNo)   = 1
1325:                             .NodeCargo(loc_nNo)      = "PRODUTO"
1326:                         ENDWITH
1327: 
1328:                         *-- ThisForm.SubNivel(3,...)/HINivel(3,...) do fim de
1329:                         *-- cada iteracao do Scan crSigMvItn no maketree legado
1330:                         *-- (niveis 3+ - baixas de estoque/producao do produto).
1331:                         *-- Cada chamada troca a work area corrente (SQLEXEC
1332:                         *-- interno do BO) - reselecionar cursor_4c_Itens antes
1333:                         *-- do SKIP implicito do SCAN, senao o loop avanca em
1334:                         *-- OUTRO cursor.
1335:                         THIS.SubNivel(3, par_cEmpDopNums, loc_cProduto)
1336:                         IF USED("cursor_4c_Itens")
1337:                             SELECT cursor_4c_Itens
1338:                         ENDIF
1339: 
1340:                         THIS.HiNivel(3, par_cEmpDopNums, loc_cProduto)
1341:                         IF USED("cursor_4c_Itens")
1342:                             SELECT cursor_4c_Itens
1343:                         ENDIF
1344:                     ENDSCAN
1345:                 ENDIF
1346: 
1347:                 *-- ThisForm.SubNivel(2,...)/HiNivel(2,...) do fim do maketree
1348:                 *-- legado - roda incondicional (com ou sem itens), FORA do
1349:                 *-- IF USED("cursor_4c_Itens") acima.
1350:                 THIS.SubNivel(2, par_cEmpDopNums, .F.)
1351:                 THIS.HiNivel(2, par_cEmpDopNums, .F.)
1352: 
1353:                 *-- loTree1.ReDraw(.t.) + loTree1.Refresh do fim do MakeTree
1354:                 WITH THIS.obj_4c_TreeView
1355:                     .ReDraw(.T.)
1356:                     .Refresh()
1357:                 ENDWITH

*-- Linhas 1370 a 1438:
1370:     * this_nNiveis <= 50 (mesmo teto do legado) e o EmpDopNums nao for
1371:     * "NF - TRF SIMBOLICA" (fim de cadeia no legado).
1372:     *
1373:     * Cada chamada a BO/SQLEXEC troca a work area corrente - por isso o
1374:     * cursor do nivel eh re-selecionado apos qualquer chamada aninhada, antes
1375:     * de continuar a leitura da linha ou de deixar o SCAN avancar (mesma
1376:     * disciplina do "Select &lcSqlFile." espalhado pelo hinivel legado).
1377:     *==========================================================================
1378:     PROTECTED PROCEDURE HiNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
1379:         LOCAL loc_cCursorHi, loc_nCodigos, loc_cEmpSubns, loc_nCodOpe, loc_cDopesOpe
1380:         LOCAL loc_nNumes, loc_cEmpDopFilho, loc_cChaveDedup, loc_nPos
1381:         LOCAL loc_cCursorDet, loc_cTexto, loc_cDtt, loc_nNo, loc_lChkPagos
1382:         LOCAL loc_lTemProduto, loc_oErro
1383: 
1384:         IF !THIS.ArvoreDisponivel()
1385:             RETURN
1386:         ENDIF
1387: 
1388:         loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros))
1389: 
1390:         TRY
1391:             loc_cCursorHi = THIS.this_oBusinessObject.ObterHistoricoNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
1392: 
1393:             IF EMPTY(loc_cCursorHi) OR !USED(loc_cCursorHi)
1394:                 RETURN
1395:             ENDIF
1396: 
1397:             SELECT (loc_cCursorHi)
1398:             SCAN
1399:                 loc_nCodigos  = Codigos
1400:                 loc_cEmpSubns = ALLTRIM(TratarNulo(EmpSubns, ""))
1401: 
1402:                 loc_nCodOpe   = INT(loc_nCodigos / 1000000)
1403:                 loc_cDopesOpe = THIS.this_oBusinessObject.ObterDopesPorCodigo(loc_nCodOpe)
1404:                 loc_nNumes    = VAL(RIGHT(ALLTRIM(TRANSFORM(loc_nCodigos)), 6))
1405: 
1406:                 loc_cEmpDopFilho = loc_cEmpSubns + PADR(loc_cDopesOpe, 20) + STR(loc_nNumes, 6)
1407:                 loc_cChaveDedup  = par_cEmpDopNums + loc_cEmpDopFilho + IIF(loc_lTemProduto, par_cCPros, SPACE(14))
1408: 
1409:                 IF USED(loc_cCursorHi)
1410:                     SELECT (loc_cCursorHi)
1411:                 ENDIF
1412: 
1413:                 loc_nPos = ASCAN(THIS.this_aHistorico, loc_cChaveDedup)
1414: 
1415:                 IF loc_nPos = 0 AND !(loc_cEmpDopFilho == THIS.this_aHistorico[1, 1])
1416:                     DIMENSION THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1) + 1, 2]
1417:                     THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 1] = loc_cChaveDedup
1418:                     THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 2] = par_nNivel
1419: 
1420:                     loc_cCursorDet = THIS.this_oBusinessObject.ObterDetalheNivel(loc_cEmpDopFilho, par_nNivel, par_cCPros)
1421: 
1422:                     IF !EMPTY(loc_cCursorDet) AND USED(loc_cCursorDet) AND !EOF(loc_cCursorDet)
1423:                         SELECT (loc_cCursorDet)
1424: 
1425:                         loc_cDtt = THIS.ObterTextoDataHora(Datas) + " (" + THIS.ObterTextoHora(Datars) + ")"
1426:                         loc_lChkPagos = TratarNulo(ChkPagos, .F.)
1427: 
1428:                         loc_cTexto = "(-) " + ;
1429:                             ALLTRIM(TratarNulo(Emps, "")) + " - " + ;
1430:                             ALLTRIM(TratarNulo(Dopes, "")) + " - " + ;
1431:                             ALLTRIM(TRANSFORM(TratarNulo(Numes, 0), "999999")) + " - " + ;
1432:                             ALLTRIM(TratarNulo(Notas, "")) + " - " + ;
1433:                             loc_cDtt + " - " + ;
1434:                             ALLTRIM(TratarNulo(Usuars, "")) + ;
1435:                             IIF(!ISNULL(Qtds), " - Qtde : " + ALLTRIM(TRANSFORM(TratarNulo(Qtds, 0), "999,999.99")), "") + " - " + ;
1436:                             DTOC(ConverterParaData(TratarNulo(DtAlts, {}))) + " - " + ;
1437:                             ALLTRIM(TratarNulo(Usuals, ""))
1438: 

*-- Linhas 1457 a 1475:
1457:                 ENDIF
1458: 
1459:                 IF USED(loc_cCursorHi)
1460:                     SELECT (loc_cCursorHi)
1461:                 ENDIF
1462:             ENDSCAN
1463:         CATCH TO loc_oErro
1464:             MsgErro("Falha ao montar hist" + CHR(243) + "rico (n" + CHR(237) + ;
1465:                 "vel " + TRANSFORM(par_nNivel) + "): " + loc_oErro.Message, "Erro")
1466:         ENDTRY
1467:     ENDPROC
1468: 
1469:     *==========================================================================
1470:     * SubNivel - equivalente ao PROCEDURE subnivel do legado: mesma familia
1471:     * de consulta de HiNivel, mas filtrando pelo CODIGO da operacao
1472:     * (nDopes*1000000 + numero) em vez do EmpDopNums, desenhando um no "(+)"
1473:     * por linha nova. Diferente de HiNivel, os dados do no vem direto da
1474:     * linha do cursor (sem uma segunda consulta de detalhe).
1475:     *==========================================================================

*-- Linhas 1497 a 1515:
1497:                 RETURN
1498:             ENDIF
1499: 
1500:             SELECT (loc_cCursorSub)
1501:             SCAN
1502:                 loc_cEmpDopFilho = ALLTRIM(TratarNulo(EmpDopNums, ""))
1503:                 loc_cChaveDedup  = ALLTRIM(TRANSFORM(loc_nCodigo)) + loc_cEmpDopFilho + ;
1504:                     IIF(loc_lTemProduto, par_cCPros, SPACE(6))
1505: 
1506:                 loc_nPos = ASCAN(THIS.this_aHistorico, loc_cChaveDedup)
1507: 
1508:                 IF loc_nPos = 0 AND !(loc_cEmpDopFilho == THIS.this_aHistorico[1, 1])
1509:                     DIMENSION THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1) + 1, 2]
1510:                     THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 1] = loc_cChaveDedup
1511:                     THIS.this_aHistorico[ALEN(THIS.this_aHistorico, 1), 2] = par_nNivel
1512: 
1513:                     loc_cDtt = THIS.ObterTextoDataHora(Datas) + " (" + THIS.ObterTextoHora(Datars) + ")"
1514:                     loc_lChkPagos = TratarNulo(ChkPagos, .F.)
1515: 

*-- Linhas 1539 a 1571:
1539:                         THIS.this_nNiveis = THIS.this_nNiveis + 1
1540: 
1541:                         IF USED(loc_cCursorSub)
1542:                             SELECT (loc_cCursorSub)
1543:                         ENDIF
1544:                         THIS.SubNivel(par_nNivel + 1, loc_cEmpDopFilho, par_cCPros)
1545: 
1546:                         IF USED(loc_cCursorSub)
1547:                             SELECT (loc_cCursorSub)
1548:                         ENDIF
1549:                         THIS.HiNivel(par_nNivel + 1, loc_cEmpDopFilho, par_cCPros)
1550: 
1551:                         THIS.this_nNiveis = THIS.this_nNiveis - 1
1552:                     ENDIF
1553:                 ENDIF
1554: 
1555:                 IF USED(loc_cCursorSub)
1556:                     SELECT (loc_cCursorSub)
1557:                 ENDIF
1558:             ENDSCAN
1559:         CATCH TO loc_oErro
1560:             MsgErro("Falha ao montar sub-n" + CHR(237) + "vel (n" + CHR(237) + ;
1561:                 "vel " + TRANSFORM(par_nNivel) + "): " + loc_oErro.Message, "Erro")
1562:         ENDTRY
1563:     ENDPROC
1564: 
1565:     *==========================================================================
1566:     * NoHiPro - equivalente ao PROCEDURE nohipro do legado: baixas de
1567:     * estoque/producao ligadas ao CODIGO (nDopes*1000000+numero) do
1568:     * EmpDopNums informado, com saldo agregado zero (BO.ObterNoHiPro/
1569:     * DeduplicarSaldo). Cada linha nova (dedup em this_aOperacoes -
1570:     * equivalente a ThisForm.paOperacoes) recursa em NoProd/NoHiPro e, fora
1571:     * do nivel 3, tambem em SubNivel/HiNivel do proximo nivel.

*-- Linhas 1599 a 1617:
1599:                 RETURN
1600:             ENDIF
1601: 
1602:             SELECT (loc_cCursorDedup)
1603:             GO TOP
1604:             loc_cDados1 = "Inicio"
1605: 
1606:             IF !EOF(loc_cCursorDedup)
1607:                 SCAN
1608:                     loc_cEDN      = ALLTRIM(TratarNulo(EmpDopNums, ""))
1609:                     loc_cEmpSubns = ALLTRIM(TratarNulo(EmpSubns, ""))
1610:                     loc_nCodigos  = Codigos
1611:                     loc_lChkPagos = TratarNulo(ChkPagos, .F.)
1612: 
1613:                     IF ASCAN(THIS.this_aOperacoes, loc_cEDN) = 0
1614:                         IF ALEN(THIS.this_aOperacoes, 1) = 1 AND EMPTY(THIS.this_aOperacoes[1])
1615:                             THIS.this_aOperacoes[1] = loc_cEDN
1616:                         ELSE
1617:                             DIMENSION THIS.this_aOperacoes[ALEN(THIS.this_aOperacoes, 1) + 1]

*-- Linhas 1626 a 1689:
1626: 
1627:                         loc_cCursorCab = THIS.this_oBusinessObject.ObterCabecalhoOperacao(loc_cEDN)
1628:                         IF !EMPTY(loc_cCursorCab) AND USED(loc_cCursorCab) AND !EOF(loc_cCursorCab)
1629:                             SELECT (loc_cCursorCab)
1630:                             loc_cDados = loc_cDados + ALLTRIM(TratarNulo(Usuars, "")) + " - " + ;
1631:                                 DTOC(ConverterParaData(TratarNulo(DtAlts, {}))) + " - " + ;
1632:                                 ALLTRIM(TratarNulo(Usuals, ""))
1633:                         ENDIF
1634: 
1635:                         IF USED(loc_cCursorDedup)
1636:                             SELECT (loc_cCursorDedup)
1637:                         ENDIF
1638: 
1639:                         IF loc_cDados != loc_cDados1
1640:                             IF THIS.ArvoreDisponivel()
1641:                                 WITH THIS.obj_4c_TreeView
1642:                                     loc_nNo = .AddPictureNode(loc_cDados, 0, par_nNivel, IIF(loc_lChkPagos, 3, 1), 0, 0)
1643:                                     .NodeHeader(loc_nNo)     = .F.
1644:                                     .NodeExpanded(loc_nNo)   = .F.
1645:                                     .NodeShowChecks(loc_nNo) = .F.
1646:                                     .NodeFontBold(loc_nNo)   = 1
1647:                                     .NodeCargo(loc_nNo)      = loc_cEDN
1648:                                 ENDWITH
1649:                             ENDIF
1650:                             loc_cDados1 = loc_cDados
1651:                         ENDIF
1652: 
1653:                         THIS.NoHiPro(par_nNivel + 1, loc_cEmpSubns, loc_cEDN, par_cCPros)
1654:                         IF USED(loc_cCursorDedup)
1655:                             SELECT (loc_cCursorDedup)
1656:                         ENDIF
1657: 
1658:                         IF par_nNivel != 3
1659:                             THIS.SubNivel(par_nNivel + 1, loc_cEDN, par_cCPros)
1660:                             IF USED(loc_cCursorDedup)
1661:                                 SELECT (loc_cCursorDedup)
1662:                             ENDIF
1663: 
1664:                             THIS.HiNivel(par_nNivel + 1, loc_cEDN, par_cCPros)
1665:                             IF USED(loc_cCursorDedup)
1666:                                 SELECT (loc_cCursorDedup)
1667:                             ENDIF
1668: 
1669:                             THIS.NoProd(par_nNivel + 1, loc_cEmpSubns, loc_nCodigos, par_cCPros)
1670:                         ENDIF
1671:                     ENDIF
1672: 
1673:                     IF USED(loc_cCursorDedup)
1674:                         SELECT (loc_cCursorDedup)
1675:                     ENDIF
1676:                 ENDSCAN
1677:             ENDIF
1678:         CATCH TO loc_oErro
1679:             MsgErro("Falha ao montar baixas (n" + CHR(237) + "vel " + ;
1680:                 TRANSFORM(par_nNivel) + "): " + loc_oErro.Message, "Erro")
1681:         ENDTRY
1682:     ENDPROC
1683: 
1684:     *==========================================================================
1685:     * NoProd - equivalente ao PROCEDURE noprod do legado: mesma logica de
1686:     * NoHiPro, mas filtrando pelo EmpDopNums reconstruido a partir do codigo
1687:     * do produto/operacao (par_nCodigo). Dedup em this_aOperacoes com
1688:     * "= 0" - igual ao dump original (o par simetrico correto de NoHiPro).
1689:     *

*-- Linhas 1720 a 1738:
1720:                 RETURN
1721:             ENDIF
1722: 
1723:             SELECT (loc_cCursorDedup)
1724:             GO TOP
1725:             loc_cDados1 = "Inicio"
1726: 
1727:             IF !EOF(loc_cCursorDedup)
1728:                 SCAN
1729:                     loc_cEDN      = ALLTRIM(TratarNulo(EmpDopNums, ""))
1730:                     loc_cEmpSubns = ALLTRIM(TratarNulo(EmpSubns, ""))
1731:                     loc_nCodigos  = Codigos
1732:                     loc_lChkPagos = TratarNulo(ChkPagos, .F.)
1733: 
1734:                     IF ASCAN(THIS.this_aOperacoes, loc_cEDN) = 0
1735:                         IF ALEN(THIS.this_aOperacoes, 1) = 1 AND EMPTY(THIS.this_aOperacoes[1])
1736:                             THIS.this_aOperacoes[1] = loc_cEDN
1737:                         ELSE
1738:                             DIMENSION THIS.this_aOperacoes[ALEN(THIS.this_aOperacoes, 1) + 1]

*-- Linhas 1747 a 1810:
1747: 
1748:                         loc_cCursorCab = THIS.this_oBusinessObject.ObterCabecalhoOperacao(loc_cEDN)
1749:                         IF !EMPTY(loc_cCursorCab) AND USED(loc_cCursorCab) AND !EOF(loc_cCursorCab)
1750:                             SELECT (loc_cCursorCab)
1751:                             loc_cDados = loc_cDados + ALLTRIM(TratarNulo(Usuars, "")) + " - " + ;
1752:                                 DTOC(ConverterParaData(TratarNulo(DtAlts, {}))) + " - " + ;
1753:                                 ALLTRIM(TratarNulo(Usuals, ""))
1754:                         ENDIF
1755: 
1756:                         IF USED(loc_cCursorDedup)
1757:                             SELECT (loc_cCursorDedup)
1758:                         ENDIF
1759: 
1760:                         IF loc_cDados != loc_cDados1
1761:                             IF THIS.ArvoreDisponivel()
1762:                                 WITH THIS.obj_4c_TreeView
1763:                                     loc_nNo = .AddPictureNode(loc_cDados, 0, par_nNivel, IIF(loc_lChkPagos, 3, 1), 0, 0)
1764:                                     .NodeHeader(loc_nNo)     = .F.
1765:                                     .NodeExpanded(loc_nNo)   = .F.
1766:                                     .NodeShowChecks(loc_nNo) = .F.
1767:                                     .NodeFontBold(loc_nNo)   = 1
1768:                                     .NodeCargo(loc_nNo)      = loc_cEDN
1769:                                 ENDWITH
1770:                             ENDIF
1771:                             loc_cDados1 = loc_cDados
1772:                         ENDIF
1773: 
1774:                         THIS.NoProd(par_nNivel + 1, loc_cEmpSubns, loc_nCodigos, par_cCPros)
1775:                         IF USED(loc_cCursorDedup)
1776:                             SELECT (loc_cCursorDedup)
1777:                         ENDIF
1778: 
1779:                         THIS.NoHiPro(par_nNivel + 1, loc_cEmpSubns, loc_cEDN, par_cCPros)
1780:                         IF USED(loc_cCursorDedup)
1781:                             SELECT (loc_cCursorDedup)
1782:                         ENDIF
1783: 
1784:                         IF par_nNivel != 3
1785:                             THIS.SubNivel(par_nNivel + 1, loc_cEDN, par_cCPros)
1786:                             IF USED(loc_cCursorDedup)
1787:                                 SELECT (loc_cCursorDedup)
1788:                             ENDIF
1789: 
1790:                             THIS.HiNivel(par_nNivel + 1, loc_cEDN, par_cCPros)
1791:                         ENDIF
1792:                     ENDIF
1793: 
1794:                     IF USED(loc_cCursorDedup)
1795:                         SELECT (loc_cCursorDedup)
1796:                     ENDIF
1797:                 ENDSCAN
1798:             ENDIF
1799:         CATCH TO loc_oErro
1800:             MsgErro("Falha ao montar produtos (n" + CHR(237) + "vel " + ;
1801:                 TRANSFORM(par_nNivel) + "): " + loc_oErro.Message, "Erro")
1802:         ENDTRY
1803:     ENDPROC
1804: 
1805:     *==========================================================================
1806:     * CarregarListaPeriodo - Metodo de carga por periodo desta tela
1807:     * (equivalente ao MakeList do legado). Lista, no nivel 1 da arvore, as
1808:     * operacoes de uma Empresa+Operacao dentro do intervalo GetDtI/GetDtF -
1809:     * usado quando o usuario nao informa o Numero e sim um periodo.
1810:     *==========================================================================

*-- Linhas 1855 a 1873:
1855: 
1856:             TRY
1857:                 IF USED("cursor_4c_Lista")
1858:                     SELECT cursor_4c_Lista
1859:                     GO TOP
1860: 
1861:                     SCAN
1862:                         loc_nIcone = IIF(cursor_4c_Lista.ChkPagos, 3, 1)
1863: 
1864:                         loc_cTexto = ALLTRIM(TratarNulo(cursor_4c_Lista.Emps, "")) + " - " + ;
1865:                             ALLTRIM(TratarNulo(cursor_4c_Lista.Dopes, "")) + " - " + ;
1866:                             ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Lista.Numes, 0), "999999")) + " - " + ;
1867:                             ALLTRIM(TratarNulo(cursor_4c_Lista.Notas, "")) + " - " + ;
1868:                             DTOC(ConverterParaData(cursor_4c_Lista.Datas)) + ;
1869:                             IIF(!ISNULL(cursor_4c_Lista.Qtds), " - Qtde : " + ;
1870:                                 ALLTRIM(TRANSFORM(TratarNulo(cursor_4c_Lista.Qtds, 0), "999,999.99")), "")
1871: 
1872:                         WITH THIS.obj_4c_TreeView
1873:                             loc_nNo = .AddPictureNode(loc_cTexto, 0, 1, loc_nIcone, 0, 0)

*-- Linhas 2230 a 2249:
2230:     * O pipeline cobra de TODO form os nomes canonicos FormParaBO/BOParaForm/
2231:     * CarregarLista/BtnCancelarClick + um handler de acao. Este form eh uma
2232:     * CONSULTA em arvore (ver nota no cabecalho): nao tem Page2 de Dados, nem
2233:     * grade de listagem, nem gravacao - o legado nao tem UM SO Insert/Update/
2234:     * Delete/TableUpdate (conferido no dump: zero ocorrencias). Os nomes
2235:     * entram portanto como ADAPTADORES, cada um mapeado para o equivalente
2236:     * REAL nesta tela - nenhum corpo vazio, nenhum botao inventado:
2237:     *
2238:     *   FormParaBO        -> leva o filtro da tela (Empresa/Operacao/Numero/
2239:     *                        Periodo) para as properties do BO, montando a
2240:     *                        chave EmpDopNums; fonte UNICA dessa transferencia
2241:     *   BOParaForm        -> traz o filtro do BO de volta para os 5 campos
2242:     *                        (usado pela navegacao Anterior/Proximo)
2243:     *   CarregarLista     -> "recarrega a superficie consultavel": despacha
2244:     *                        para CarregarDados (arvore de uma operacao,
2245:     *                        MakeTree do legado) ou CarregarListaPeriodo
2246:     *                        (lista por periodo, MakeList do legado)
2247:     *   BtnExecutarClick  -> a acao desta tela: aplicar o filtro e consultar.
2248:     *                        No legado ela nao mora num botao proprio - sai do
2249:     *                        Valid de GetNumes (MakeTree) e de GetDtF


### BO (C:\4c\projeto\app\classes\SIGMVMVTBO.prg):
*==============================================================================
* SIGMVMVTBO.PRG
* Business Object - Acompanhamento Operacional (SIGMVMVT)
* Consulta hierarquica (TreeView) de movimentos por Empresa/Operacao/Numero,
* percorrendo SigMvCab / SigMvItn / SigMvPec / SigOpDev / SigCdOpe.
* Heranca: BusinessBase
*
* NOTA IMPORTANTE (paridade com o legado): o SIGMVMVT eh um formulario de
* CONSULTA (drill-down em arvore) - o codigo fonte original (Init, MakeTree,
* MakeList, HiNivel, SubNivel, NoHiPro, NoProd) faz SOMENTE SELECT nas tabelas
* de movimento. Nao existe, em lugar nenhum do legado, INSERT/UPDATE/DELETE em
* SigMvCab/SigMvItn/SigMvPec/SigOpDev disparado por este formulario - por isso
* Inserir()/Atualizar()/ExecutarExclusao() ficam sobrescritos abaixo apenas
* para documentar essa regra de negocio (BO somente-leitura), e os metodos
* reais adicionados nesta fase sao os de CONSULTA hierarquica que o Form
* (Fase 3) vai usar para montar a arvore.
*==============================================================================

DEFINE CLASS SIGMVMVTBO AS BusinessBase

    *-- Filtro de selecao da operacao (espelha GetcEmp/GetDopes/GetNumes do legado)
    this_cEmps  = ""     && SigMvCab.emps  char(3)  - empresa
    this_cDopes = ""     && SigMvCab.dopes char(20) - codigo da operacao (FK SigCdOpe.Dopes)
    this_nNumes = 0      && SigMvCab.numes numeric(6,0) - numero da operacao

    *-- Filtro de periodo (usado em MakeList - GetDtI/GetDtF do legado)
    this_dDtI = {}       && Data inicial do periodo
    this_dDtF = {}       && Data final do periodo

    *-- Chave composta usada em todas as consultas hierarquicas (WHERE EmpDopNums = ...)
    * Formato: PADR(Emps,3) + PADR(Dopes,20) + STR(Numes,6)
    this_cEmpDopNums = ""

    *-- Dados do registro-raiz carregado (SigMvCab), preenchidos por CarregarDoCursor
    this_cCidChaves = ""    && SigMvCab.cidchaves char(20) - PK
    this_cNotas     = ""    && SigMvCab.notas     char(6)
    this_dDatas     = {}    && SigMvCab.datas     datetime
    this_dDatars    = {}    && SigMvCab.datars    datetime
    this_lChkPagos  = .F.   && SigMvCab.chkpagos  bit
    this_cUsuars    = ""    && SigMvCab.usuars    char(10)
    this_dDtAlts    = {}    && SigMvCab.dtalts    datetime
    this_cUsuals    = ""    && SigMvCab.usuals    char(10)

    *-- Flags de controle (espelham propriedades do form legado)
    this_lAcOficina  = .F.   && ThisForm.lacoficina - acesso a producao/oficina (fChecaAcesso)
    this_lAutomatico = .F.   && ThisForm.Automatico - form aberto ja com Emps/Dopes/Numes definidos
    this_nNiveis     = 0     && ThisForm.pnNiveis - contador de profundidade da recursao da arvore

    *-- Mensagem tecnica devolvida por SQLEXEC quando a conexao/consulta falha
    this_cMensagemSQL = ""

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigMvCab")

        THIS.this_cCampoChave = "EmpDopNums"

        THIS.this_cEmps  = ""
        THIS.this_cDopes = ""
        THIS.this_nNumes = 0

        THIS.this_dDtI = {}
        THIS.this_dDtF = {}

        THIS.this_cEmpDopNums = ""

        THIS.this_cCidChaves = ""
        THIS.this_cNotas     = ""
        THIS.this_dDatas     = {}
        THIS.this_dDatars    = {}
        THIS.this_lChkPagos  = .F.
        THIS.this_cUsuars    = ""
        THIS.this_dDtAlts    = {}
        THIS.this_cUsuals    = ""

        THIS.this_lAcOficina  = .F.
        THIS.this_lAutomatico = .F.
        THIS.this_nNiveis     = 0

        THIS.this_cMensagemSQL = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor (registro de SigMvCab) para
    * as propriedades this_. Segue o padrao canonico: SELECT (alias) antes de
    * acessar os campos diretamente (nunca campo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCidChaves  = ALLTRIM(TratarNulo(cidchaves, ""))
        THIS.this_cEmps       = ALLTRIM(TratarNulo(emps, ""))
        THIS.this_cDopes      = ALLTRIM(TratarNulo(dopes, ""))
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_cEmpDopNums = ALLTRIM(TratarNulo(empdopnums, ""))
        THIS.this_cNotas      = ALLTRIM(TratarNulo(notas, ""))
        THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
        THIS.this_dDatars     = ConverterParaData(TratarNulo(datars, {}))
        THIS.this_lChkPagos   = TratarNulo(chkpagos, .F.)
        THIS.this_cUsuars     = ALLTRIM(TratarNulo(usuars, ""))
        THIS.this_dDtAlts     = ConverterParaData(TratarNulo(dtalts, {}))
        THIS.this_cUsuals     = ALLTRIM(TratarNulo(usuals, ""))

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave de negocio usada nesta tela (EmpDopNums),
    * consistente com o que o legado usa em TODAS as consultas hierarquicas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - o Acompanhamento Operacional eh
    * consulta pura (drill-down); o legado nunca grava nem exclui a partir
    * desta tela. Mantidos sobrescritos apenas para deixar a regra explicita -
    * nenhum botao do form (Fase 3) chama Salvar()/Excluir() deste BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Acompanhamento Operacional " + CHR(233) + ;
            " tela de consulta - n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Acompanhamento Operacional " + CHR(233) + ;
            " tela de consulta - n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Acompanhamento Operacional " + CHR(233) + ;
            " tela de consulta - n" + CHR(227) + "o exclui registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - equivalente ao lookup de GetcEmp.Valid (fwBuscaExt) e ao
    * "Select * From SigCdEmp Where cEmps = ?" do Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lAchou

        loc_lAchou = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_cMensagemSQL  = ""

        IF EMPTY(ALLTRIM(TratarNulo(par_cEmps, "")))
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_Emp")
            USE IN cursor_4c_Emp
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cEmps))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")

        IF loc_nResultado > 0 AND !EOF("cursor_4c_Emp")
            loc_lAchou = .T.
            THIS.this_cEmps = ALLTRIM(cursor_4c_Emp.Cemps)
        ELSE
            THIS.this_cMensagemSQL  = CapturarErroSQL()
            THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada."
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOperacao - equivalente ao lookup de GetDopes.Valid (fwBuscaExt).
    * O acesso a producao/oficina (fChecaAcesso) permanece responsabilidade do
    * Form, que grava o resultado em THIS.this_lAcOficina apos chamar este
    * metodo (mesma divisao do legado, onde a checagem fica no proprio Valid).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOperacao(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lAchou

        loc_lAchou = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_cMensagemSQL  = ""

        IF EMPTY(ALLTRIM(TratarNulo(par_cDopes, "")))
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF

        loc_cSQL = "SELECT Dopes, nDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")

        IF loc_nResultado > 0 AND !EOF("cursor_4c_Ope")
            loc_lAchou = .T.
            THIS.this_cDopes = ALLTRIM(cursor_4c_Ope.Dopes)
        ELSE
            THIS.this_cMensagemSQL  = CapturarErroSQL()
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada."
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCodigoOperacao - Select nDopes From SigCdOpe Where Dopes = ?
    * Retorna -1 quando nao encontra (o codigo nDopes real eh sempre >= 0).
    *--------------------------------------------------------------------------
    PROCEDURE ObterCodigoOperacao(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_nCodigo

        loc_nCodigo = -1

        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF

        loc_cSQL = "SELECT nDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")

        IF loc_nResultado > 0 AND !EOF("cursor_4c_Ope")
            loc_nCodigo = cursor_4c_Ope.nDopes
        ELSE
            THIS.this_cMensagemSQL = CapturarErroSQL()
        ENDIF

        RETURN loc_nCodigo
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDopesPorCodigo - Select Dopes From SigCdOpe Where nDopes = ?
    * (caminho inverso de ObterCodigoOperacao, usado por NoProd)
    *--------------------------------------------------------------------------
    PROCEDURE ObterDopesPorCodigo(par_nCodigoOperacao)
        LOCAL loc_cSQL, loc_nResultado, loc_cDopes

        loc_cDopes = ""

        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF

        loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE nDopes = " + FormatarNumeroSQL(par_nCodigoOperacao, 0)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")

        IF loc_nResultado > 0 AND !EOF("cursor_4c_Ope")
            loc_cDopes = ALLTRIM(cursor_4c_Ope.Dopes)
        ELSE
            THIS.this_cMensagemSQL = CapturarErroSQL()
        ENDIF

        RETURN loc_cDopes
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - equivalente ao Init (AddCursor crSigMvCab) + trecho
    * inicial do MakeTree (Requery + Go Top + Eof = "Operacao Nao Localizada").
    * Monta this_cEmpDopNums a partir de Emps/Dopes/Numes e busca o registro.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacao(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_cMensagemSQL  = ""

        THIS.this_cEmps  = ALLTRIM(TratarNulo(par_cEmps, ""))
        THIS.this_cDopes = ALLTRIM(TratarNulo(par_cDopes, ""))
        THIS.this_nNumes = TratarNulo(par_nNumes, 0)

        THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

        IF USED("cursor_4c_Cab")
            USE IN cursor_4c_Cab
        ENDIF

        loc_cSQL = "SELECT * FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cab")

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL  = CapturarErroSQL()
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Localizada !!"
        ELSE
            SELECT cursor_4c_Cab
            GO TOP
            IF EOF("cursor_4c_Cab")
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Localizada !!"
            ELSE
                THIS.CarregarDoCursor("cursor_4c_Cab")
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - equivalente a lcQryEesti do Init / trecho de MakeTree que
    * percorre crSigMvItn (nivel 2 da arvore: produto/quantidade).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_cChave

        loc_cChave = ALLTRIM(TratarNulo(par_cEmpDopNums, THIS.this_cEmpDopNums))
        THIS.this_cMensagemSQL = ""

        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF

        loc_cSQL = "SELECT EmpDopNums, cPros, dPros, SUM(Qtds) AS Qtds " + ;
            "FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cChave) + " " + ;
            "GROUP BY EmpDopNums, cPros, dPros " + ;
            "ORDER BY EmpDopNums, cPros, dPros"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL  = CapturarErroSQL()
            THIS.this_cMensagemErro = "Erro ao carregar itens da opera" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorPeriodo - equivalente a MakeList: lista as operacoes de uma
    * Empresa+Operacao dentro do periodo informado (nivel 1 da arvore, quando
    * o form nao abre ja "Automatico" com Emps/Dopes/Numes definidos).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorPeriodo(par_cEmps, par_cDopes, par_dDtIni, par_dDtFim)
        LOCAL loc_cSQL, loc_nResultado, loc_cDtIniSQL, loc_cDtFimSQL

        THIS.this_cEmps  = ALLTRIM(TratarNulo(par_cEmps, ""))
        THIS.this_cDopes = ALLTRIM(TratarNulo(par_cDopes, ""))
        THIS.this_dDtI   = ConverterParaData(par_dDtIni)
        THIS.this_dDtF   = ConverterParaData(par_dDtFim)
        THIS.this_cMensagemSQL = ""

        loc_cDtIniSQL = FormatarDataSQL(THIS.this_dDtI)

        * Fim do periodo com hora 23:59:59 (fDtoSQL(..., '23:59:59') do legado)
        loc_cDtFimSQL = FormatarDataSQL(THIS.this_dDtF)
        IF loc_cDtFimSQL != "NULL"
            loc_cDtFimSQL = LEFT(loc_cDtFimSQL, LEN(loc_cDtFimSQL) - 1) + " 23:59:59'"
        ENDIF

        IF USED("cursor_4c_Lista")
            USE IN cursor_4c_Lista
        ENDIF

        loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Notas, a.Datas, a.Datars, a.ChkPagos, SUM(b.Qtds) AS Qtds " + ;
            "FROM SigMvCab a " + ;
            "LEFT JOIN SigMvItn b ON a.EmpDopNums = b.EmpDopNums " + ;
            "WHERE a.Emps = " + EscaparSQL(THIS.this_cEmps) + " " + ;
            "AND a.Dopes = " + EscaparSQL(THIS.this_cDopes) + " " + ;
            "AND a.Datas BETWEEN " + loc_cDtIniSQL + " AND " + loc_cDtFimSQL + " " + ;
            "GROUP BY a.Datas, a.Datars, a.Emps, a.Dopes, a.Numes, a.Notas, a.ChkPagos " + ;
            "ORDER BY a.Datas, a.Datars, a.Emps, a.Dopes, a.Numes, a.Notas, a.ChkPagos"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL  = CapturarErroSQL()
            THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(245) + "es no per" + CHR(237) + "odo."
            RETURN .F.
        ENDIF

        IF EOF("cursor_4c_Lista")
            THIS.this_cMensagemErro = "N" + CHR(227) + "o Foi Localizada Nenhuma Opera" + CHR(231) + CHR(227) + "o"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDetalheNivel - equivalente a lcQryBx dentro de HiNivel: dados de
    * cabecalho (SigMvCab) + quantidade (SigMvItn) de UM EmpDopNums, usados
    * para montar o texto do no da arvore.
    *--------------------------------------------------------------------------
    PROCEDURE ObterDetalheNivel(par_cEmpDopNums, par_nNivel, par_cCPros)
        LOCAL loc_cSQL, loc_nResultado, loc_lTemProduto

        loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros) AND par_nNivel = 3)
        THIS.this_cMensagemSQL = ""

        IF USED("cursor_4c_Detalhe")
            USE IN cursor_4c_Detalhe
        ENDIF

        loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.Usuars, a.DtAlts, a.Usuals, " + ;
            "c.EmpDopNums, SUM(c.Qtds) AS Qtds " + ;
            "FROM SigMvCab a " + ;
            "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
            "WHERE " + IIF(loc_lTemProduto, "c.Cpros = " + EscaparSQL(par_cCPros) + " AND ", "") + ;
            "a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
            "GROUP BY a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.Usuars, a.DtAlts, a.Usuals, c.EmpDopNums"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Detalhe")

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN "cursor_4c_Detalhe"
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterHistoricoNivel - equivalente a HiNivel: historico de baixa/producao
    * (SigMvPec + SigMvCab + SigMvItn, UNION ALL SigOpDev + SigMvCab + SigMvItn)
    * de um EmpDopNums. Retorna o NOME do cursor (cursor_4c_HiEstPe<nivel>)
    * para o Form fazer SELECT/SCAN, ou "" se falhar.
    *--------------------------------------------------------------------------
    PROCEDURE ObterHistoricoNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
        LOCAL loc_cSQL, loc_cCursor, loc_nResultado, loc_lTemProduto

        loc_cCursor = "cursor_4c_HiEstPe" + TRANSFORM(par_nNivel)
        loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros))
        THIS.this_cMensagemSQL = ""

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
            "SUM(c.Qtds) AS Qtds " + ;
            "FROM SigMvPec a " + ;
            "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
            "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
            IIF(loc_lTemProduto, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "AND 0 = 1 ") + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps AS EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
            "SUM(c.Qtds) AS Qtds " + ;
            "FROM SigOpDev a " + ;
            "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
            "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
            IIF(loc_lTemProduto AND par_nNivel = 3, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "") + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
            "ORDER BY b.Datas, b.Datars, b.EmpDopNums, 14"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN loc_cCursor
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterSubNivel - equivalente a SubNivel: mesma consulta de HiNivel, mas
    * filtrando por a.Codigos (nDopes*1000000 + numero) em vez de EmpDopNums.
    * Retorna o NOME do cursor (cursor_4c_SubEstPe<nivel>), ou "" se falhar.
    *--------------------------------------------------------------------------
    PROCEDURE ObterSubNivel(par_nNivel, par_cEmpDopNums, par_cCPros)
        LOCAL loc_nCodOpe, loc_nCodigo, loc_cCursor, loc_cSQL, loc_nResultado, loc_lTemProduto

        THIS.this_cMensagemSQL = ""

        loc_nCodOpe = THIS.ObterCodigoOperacao(SUBSTR(par_cEmpDopNums, 4, 20))
        IF loc_nCodOpe < 0
            RETURN ""
        ENDIF

        loc_nCodigo = loc_nCodOpe * 1000000 + VAL(RIGHT(par_cEmpDopNums, 6))
        loc_cCursor = "cursor_4c_SubEstPe" + TRANSFORM(par_nNivel)
        loc_lTemProduto = (VARTYPE(par_cCPros) = "C" AND !EMPTY(par_cCPros))

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
            "SUM(c.Qtds) AS Qtds " + ;
            "FROM SigMvPec a " + ;
            "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
            "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
            "WHERE a.Codigos = " + FormatarNumeroSQL(loc_nCodigo, 0) + " " + ;
            "AND a.EmpSubns = " + EscaparSQL(LEFT(par_cEmpDopNums, 3)) + " " + ;
            IIF(loc_lTemProduto, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "AND 0 = 1 ") + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, a.EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, a.Emps AS EmpSubns, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals, " + ;
            "SUM(c.Qtds) AS Qtds " + ;
            "FROM SigOpDev a " + ;
            "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
            "LEFT JOIN SigMvItn c ON a.EmpDopNums = c.EmpDopNums " + ;
            "WHERE a.Codigos = " + FormatarNumeroSQL(loc_nCodigo, 0) + " " + ;
            IIF(loc_lTemProduto AND par_nNivel = 3, "AND c.Cpros = " + EscaparSQL(par_cCPros) + " ", "") + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, " + ;
            "b.Datas, b.Datars, b.Notas, b.ChkPagos, b.EmpDopNums, b.Usuars, b.DtAlts, b.Usuals " + ;
            "ORDER BY b.Datas, b.Datars, b.EmpDopNums, 14"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN loc_cCursor
    ENDPROC

    *--------------------------------------------------------------------------
    * DeduplicarSaldo - equivalente ao trecho comum de NoHiPro/NoProd:
    *   Select ... Sum(qtds) As qtds From <cursor origem> Group By ...
    *       Into Cursor crTmpSub<nivel> ReadWrite
    *   Delete For qtds <> 0
    * (mantem so as combinacoes cujo saldo agregado eh ZERO). PROTECTED: eh
    * detalhe interno de ObterNoHiPro/ObterNoProd, nao chamado pelo Form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DeduplicarSaldo(par_cCursorOrigem, par_nNivel)
        LOCAL loc_cCursorDedup

        loc_cCursorDedup = "cursor_4c_TmpSub" + TRANSFORM(par_nNivel)

        IF USED(loc_cCursorDedup)
            USE IN (loc_cCursorDedup)
        ENDIF

        SELECT a.codigos, a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.EmpDopNums, EmpSubns, SUM(qtds) AS qtds ;
            FROM (par_cCursorOrigem) a ;
            GROUP BY a.codigos, a.Emps, a.Dopes, a.Numes, a.Datas, a.Datars, a.Notas, a.ChkPagos, a.EmpDopNums, EmpSubns ;
            INTO CURSOR (loc_cCursorDedup) READWRITE

        SELECT (loc_cCursorDedup)
        DELETE FOR qtds <> 0
        GO TOP

        RETURN loc_cCursorDedup
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCabecalhoOperacao - equivalente a csSigMvCab dentro de NoHiPro/
    * NoProd: Usuars/DtAlts/Usuals de UM EmpDopNums, usados no texto do no.
    *--------------------------------------------------------------------------
    PROCEDURE ObterCabecalhoOperacao(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado

        THIS.this_cMensagemSQL = ""

        IF USED("cursor_4c_CabInfo")
            USE IN cursor_4c_CabInfo
        ENDIF

        loc_cSQL = "SELECT Usuars, DtAlts, Usuals FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabInfo")

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN "cursor_4c_CabInfo"
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNoHiPro - equivalente a NoHiPro: baixas de estoque/producao ligadas
    * ao CODIGO (nDopes*1000000 + numero) do EmpDopNums informado, com o
    * agrupamento+filtro de saldo zero (DeduplicarSaldo). Retorna o NOME do
    * cursor deduplicado (cursor_4c_TmpSub<nivel>), ou "" se falhar.
    *--------------------------------------------------------------------------
    PROCEDURE ObterNoHiPro(par_nNivel, par_cEmps, par_cEmpDopNums, par_cCPros)
        LOCAL loc_nCodOpe, loc_cCodigo, loc_cCursor, loc_cSQL, loc_nResultado

        THIS.this_cMensagemSQL = ""

        loc_nCodOpe = THIS.ObterCodigoOperacao(SUBSTR(par_cEmpDopNums, 4, 20))
        IF loc_nCodOpe < 0
            RETURN ""
        ENDIF

        loc_cCodigo = FormatarNumeroSQL(loc_nCodOpe * 1000000 + VAL(RIGHT(par_cEmpDopNums, 6)), 0)
        loc_cCursor = "cursor_4c_BxEst" + TRANSFORM(par_nNivel)

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns, SUM(c.Qtds) AS Qtds " + ;
            "FROM SigMvPec a, SigMvCab b, SigMvItn c " + ;
            "WHERE a.Codigos = " + loc_cCodigo + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "AND a.EmpDopNums = c.EmpDopNums " + ;
            "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
            "FROM SigMvPec a, SigMvCab b " + ;
            "WHERE a.Codigos = " + loc_cCodigo + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.Emps AS EmpSubns, SUM(c.Qtds) AS Qtds " + ;
            "FROM SigOpDev a, SigMvCab b, SigMvItn c " + ;
            "WHERE a.Codigos = " + loc_cCodigo + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "AND a.EmpDopNums = c.EmpDopNums " + ;
            "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN THIS.DeduplicarSaldo(loc_cCursor, par_nNivel)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNoProd - equivalente a NoProd: mesma logica de ObterNoHiPro, mas
    * filtrando por EmpDopNums reconstruido a partir do codigo do produto/
    * operacao (par_nCodigo). Retorna o NOME do cursor deduplicado
    * (cursor_4c_TmpSub<nivel>), ou "" se falhar.
    *--------------------------------------------------------------------------
    PROCEDURE ObterNoProd(par_nNivel, par_cEmps, par_nCodigo, par_cCPros)
        LOCAL loc_nCodOpe, loc_cDopes, loc_nNumero, loc_cEmpDopNums, loc_cCursor, loc_cSQL, loc_nResultado

        THIS.this_cMensagemSQL = ""

        loc_nCodOpe = INT(par_nCodigo / 1000000)
        loc_cDopes  = THIS.ObterDopesPorCodigo(loc_nCodOpe)
        IF EMPTY(loc_cDopes)
            RETURN ""
        ENDIF

        loc_nNumero     = MOD(par_nCodigo, 1000000)
        loc_cEmpDopNums = par_cEmps + PADR(loc_cDopes, 20) + STR(loc_nNumero, 6)
        loc_cCursor     = "cursor_4c_BxEstProd" + TRANSFORM(par_nNivel)

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        loc_cSQL = "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns, SUM(c.Qtds) AS Qtds " + ;
            "FROM SigMvPec a, SigMvCab b, SigMvItn c " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "AND a.EmpDopNums = c.EmpDopNums " + ;
            "AND c.Cpros = " + EscaparSQL(par_cCPros) + " " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, c.EmpDopNums, a.EmpSubns " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns, 0 AS Qtds " + ;
            "FROM SigMvPec a, SigMvCab b " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "AND a.EmpSubns = " + EscaparSQL(par_cEmps) + " " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.EmpSubns " + ;
            "UNION ALL " + ;
            "SELECT a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums, a.Emps AS EmpSubns, 0 AS Qtds " + ;
            "FROM SigOpDev a, SigMvCab b " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + " " + ;
            "AND a.EmpDopNums = b.EmpDopNums " + ;
            "GROUP BY a.Codigos, a.Emps, a.Dopes, a.Numes, b.Datas, b.Datars, b.Notas, b.ChkPagos, a.EmpDopNums"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResultado < 0
            THIS.this_cMensagemSQL = CapturarErroSQL()
            RETURN ""
        ENDIF

        RETURN THIS.DeduplicarSaldo(loc_cCursor, par_nNivel)
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - fecha os cursores auxiliares de escopo fixo (os numerados por
    * nivel de recursao sao fechados pelo proprio Form conforme a arvore eh
    * percorrida, ja que o nivel maximo eh dinamico - ate 50, igual ao legado).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores[6], loc_nI

        loc_aCursores[1] = "cursor_4c_Cab"
        loc_aCursores[2] = "cursor_4c_Itens"
        loc_aCursores[3] = "cursor_4c_Lista"
        loc_aCursores[4] = "cursor_4c_Ope"
        loc_aCursores[5] = "cursor_4c_Emp"
        loc_aCursores[6] = "cursor_4c_CabInfo"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

