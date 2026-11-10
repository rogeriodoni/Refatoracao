# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, 1, EMPDNPS, CHKSUBN, SEPPEDRAS, NOPS, EMPS, GRUPODS, CONTADS

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  ControlSource = "TmpPends.Obss"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  ControlSource = ""
=Seek(TmpPends.Dopps, 'crSigCdOpd', 'Dopps')
Select LocalNens
lcQuery = [Update SigCdNec ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Marca - Update - SigCdNec)')
=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
=Seek(TmpPends.Dopps, 'crSigCdOpd', 'Dopps')
=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
	Select TmpPends
Select crSigCdPam
Select LocalNens
	lcQuery = [Update SigCdNec ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	Select TmpPends
Select LocalNens
	lcQuery = [Update SigCdNec ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Marca - Update - SigCdNec)')
	Select TmpNens
Select *, 000000.000 as ps2FaseAnt, Space(3) as cUnips, .f. as OsRets, .f. as Retrabs, Space(10) as MatPrincs,;
From CrSigCdNei Where 1=0 Into Cursor xpNensi ReadWrite
Select *, 000000.000 as ps2FaseAnt, Space(3) as cUnips, .f. as OsRets, .f. as Retrabs, Space(10) as MatPrincs,;
From CrSigCdNei Where 1=0 Into Cursor xpNensiT ReadWrite
Select TmpOperacao
Delete All For Empty(Codigos)
=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
=Seek(_DoppsNivel, 'crSigCdOpd', 'Dopps')
lcQuery = [Select Emps, Dopps, Numps, Datas, GrupoOs, ContaOs, ChkSubn, TotPesos, Usuars, Obss ] + ;
		    [From SigCdNec ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNens') < 1)
Select LocalNens
	_Flag = Seek(Val(_NumeroNivel + Transform(LocalNens.Numps, '@L 9999999999')), 'TmpOperacao', 'Codigos')
	Insert Into TmpPends (Flag, Emps, Dopps, Numps, Datas, Grupo, Conta, TPesos, Usuars, Obss) ;
	Select LocalNensi
				Insert Into xPNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, QtFaseAnt, Qtds, PsFaseAnt, ;
					If Not Seek(Str(_Nenv, 10) + _BMat + _TMat, 'xPNensi', 'NEnvTpops')
						Insert Into xPNensi (Emps, Dopps, Numps, Nops, Nenvs, CMats, CDescs, CUnis, ;
					Select xPNensi
				If Not Seek(LocalNensi.Cats, 'xPNensi', 'Cats') Or LocalNensi.FlagIncs
					Insert Into xPNensi (Emps, Dopps, Numps, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, ;
Select xPnensi
	Select xPnensiT
	If NOt Seek(lcEmpDnP + m.Cmats + Str(m.Nops,10))
		Insert Into xPNensit (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, ;
Select TmpPends
	.Seleciona.ControlSource = 'TmpPends.Flag'
	.Codigo.ControlSource    = 'TmpPends.Numps'
	.Data.ControlSource      = 'TmpPends.Datas'
	.Grupo.ControlSource     = 'TmpPends.Grupo'
	.Conta.ControlSource     = 'TmpPends.Conta'
	.Usuario.ControlSource   = 'TmpPends.Usuars'
	.Peso.ControlSource      = 'TmpPends.TPesos'
Select xPnensi
	.column1.controlsource = 'xpnensi.nops'  	&& Ordem de Produção
	.column2.controlsource = 'xpnensi.cmats'  	&& Componente
	.column3.controlsource = 'xpnensi.cgrus' 	&& Grupo
	.column4.controlsource = 'xpnensi.cunis'	&& Unidade
	.column5.controlsource = 'xpnensi.tpops'	&& Tipo de Material
	.column6.controlsource = 'xpnensi.qtds'		&& Peso na Fase Anterior
	.column7.controlsource = 'xpnensi.pesos'	&& Peso Atual ( Balança )
	.column8.controlsource = 'xpnensi.cats'		&& Categoria
	.column9.controlsource = 'xpnensi.nenvs'	&& n. Envelope
Select xPnensiT
	.column1.controlsource = 'xpnensiT.nops'  	&& Ordem de Produção
	.column2.controlsource = 'xpnensiT.cmats'  	&& Componente
	.column3.controlsource = 'xpnensiT.cgrus' 	&& Grupo
	.column4.controlsource = 'xpnensiT.cunis'	&& Unidade
	.column5.controlsource = 'xpnensiT.tpops'	&& Tipo de Material
	.column6.controlsource = 'xpnensiT.qtds'		&& Peso na Fase Anterior
	.column7.controlsource = 'xpnensiT.pesos'	&& Peso Atual ( Balança )
	.column8.controlsource = 'xpnensiT.cats'		&& Categoria
	.column9.controlsource = 'xpnensiT.nenvs'	&& n. Envelope
Select crSigCdNec
	Select TmpPends
Select xPnensit
Select xPnensi
Select TmpPends
Select TmpPends
=Seek(TmpNens.Dopps,  'crSigCdOpd', 'Dopps')
Select TmpPends
	=Seek(TmpPends.Dopps,  'crSigCdOpd', 'Dopps')
	=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
	lcQuery = [Update SigCdNec ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (OK - Update - SigCdNec)')
	Update crSigCdNec ;
	Select LocalMFas
		lcQuery = [Select a.Nops, a.Datas, a.cidChaves From SigPdMvf a ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas2') < 1)
		Select LocalMFas2
			Select TmpNens
		Insert Into xMFas (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, Grupods, ;
		If Not Seek((_NumNivel * 10000000000 ) + xMFas.NEnvs, 'TmpOperacao', 'Codigos')
			Insert Into TmpOperacao (Codigos, EmpDnPs, Autos) Values ((_NumNivel * 10000000000) + xMFas.NEnvs, _ChaveNens, .t.)
		Select LocalOpi
				Insert Into xOpi (Nops, Oper, Qtds, CPros, Indiv, Nenvs, Emps, Dopes, Numes, ;
	lcQuery = [Select * From SigCdNei ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNensI') < 1)
	Select LocalNensi
				Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs,  QtFaseAnt, Qtds, PsFaseAnt, ;
					Select xNensi
						If Not Seek(Str(_Nenv, 10) + _BMat + _TMat, 'xNensi', 'NEnvTpops')
							Insert Into xNensi (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, Cats, TpOps, Servicos) ;
						Select xNensi
				If Not Seek(LocalNensI.Nops, 'xMfas', 'Nops')
					lcQuery = [Select EmpDNPs, Emps, Dopps, Nops ] + ;
								[From SigOpPic ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalOpi') < 1)
					lcQuery = [Select Nops, Qtds, Codpds ] + ;
								[From SigPdMvf ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas') < 1)
					Insert Into xMFas (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
				If Not Seek((_NumNivel * 10000000000) + xMFas.NEnvs, 'TmpOperacao', 'Codigos')
					Insert Into TmpOperacao (Codigos, EmpDnPs, Autos) Values ((_NumNivel * 10000000000) + xMFas.NEnvs, _ChaveNens,.t.)
		Select LocalNensi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpMpn.prg) - TRECHOS RELEVANTES PARA PASS SQL (2130 linhas total):

*-- Linhas 54 a 88:
54: *             SigOpMpnBO.CarregarPendencias, que cria os tres cursores e
55: *             popula TmpPends/xPNensi/xPNensiT). A montagem visual
56: *             (Configurar*) e o bind (Carregar*) ficam SEPARADOS por causa
57: *             da regra #41 - Column.ControlSource de cursor que ainda nao
58: *             existe derruba o Init -, mas rodam na MESMA ordem do Init
59: *             legado: monta, cria cursor, liga.
60: *
61: *   Fase 5:   lbl_4c_Label1 + txt_4c_OpSubNivel (Nivels do nivel para o
62: *             qual a movimentacao de subnivel esta indo - legado:
63: *             "ThisForm.OpSubNivel.Value = crSigCdOpd.Nivels", calculado
64: *             em CarregarGrade() a partir de TmpNens.Dopps/crSigCdOpd -
65: *             cursor do form pai e cursor global, ambos visiveis aqui
66: *             pelo nome por causa da DataSession=1 compartilhada).
67: *   Fase 6:   lbl_4c__Procura/txt_4c_Procura (busca incremental por Numps
68: *             na grade de selecao - legado: Say_Procura/Get_Procura.Valid/
69: *             LostFocus, transcritos em ValidarProcuraNumero/
70: *             TxtProcuraKeyPress/TxtProcuraLostFocus porque BINDEVENT
71: *             "Valid" nao funciona em TextBox, regra do projeto - KeyPress
72: *             com ENTER/TAB simula o Valid) e obj_4c_Mm_obs (EditBox
73: *             read-only, legado: ControlSource = TmpPends.Obss, ligado em
74: *             CarregarGrade() pelo mesmo motivo de regra #41 das grades -
75: *             TmpPends ainda nao existe no momento do AddObject).
76: *   Fase 7:   GarantirCheckBoxSelecionar() + ChkSelecionarInteractiveChange
77: *             (toggle da coluna de selecao - legado: fwcheckbox1.
78: *             InteractiveChange -> ThisForm.Marca()/Desmarca), CmdSelTudoClick/
79: *             CmdApagaClick (Marca/Desmarca em lote - legado: SelTudo.Click/
80: *             apaga.Click), CmdTotalizaClick (alterna grd_4c_Itens com
81: *             grd_4c_Total via this_nContador - legado: Totaliza.Click) e
82: *             GradeAfterRowColChange (reaplica o "Set Key To" das duas
83: *             grades de detalhe quando o usuario troca de pendencia -
84: *             regra #46: sem filtro de coluna, porque recarrega o DETALHE
85: *             da linha corrente). ConfigurarEventosGrade liga tambem o
86: *             GotFocus das colunas de exibicao (Usuario/data/Grupo/Conta/
87: *             Peso) a FocarColunaSelecao, que redireciona sempre para o
88: *             CheckBox (legado: "ThisForm.Grade.Seleciona.fwcheckbox1.

*-- Linhas 193 a 252:
193:     *--------------------------------------------------------------------------
194:     * InicializarForm - fundo do form + cabecalho (SIGOPMPN.cntSombra do
195:     * dump). Grade de selecao, grades de itens/total e botoes de acao sao
196:     * das fases seguintes (regra #41 - Column.ControlSource de cursor que
197:     * ainda nao existe derruba o Init; esses cursores so nascem quando o
198:     * metodo de carga da Fase 4 roda). Chamado automaticamente por
199:     * FormBase.Init() via DODEFAULT().
200:     *--------------------------------------------------------------------------
201:     PROTECTED PROCEDURE InicializarForm()
202:         LOCAL loc_lSucesso, loc_oErro
203:         loc_lSucesso = .F.
204: 
205:         TRY
206:             THIS.LockScreen = .T.
207: 
208:             *-- Fundo do form (imagem do Framework Fortyus legado:
209:             *-- "..\framework\imagens\new_background.jpg" no SCX)
210:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
211: 
212:             *-- Ordem identica ao dump legado (SECAO 1 - arvore de
213:             *-- objetos): cntSombra e o primeiro objeto da arvore
214:             THIS.ConfigurarCabecalho()
215: 
216:             *-- Grade de selecao (TmpPends) + grades de detalhe (xPNensi/
217:             *-- xPNensiT) + botoes de acao (ok/SelTudo/Apaga/Totaliza) -
218:             *-- so a ESTRUTURA visual, SEM RecordSource/ControlSource
219:             *-- (regra #41: Column.ControlSource de cursor que ainda nao
220:             *-- existe derruba o Init e a tela nao abre). Mesma divisao de
221:             *-- FormSigOpMpd.prg.
222:             THIS.ConfigurarGrade()
223:             THIS.ConfigurarGradesDetalhe()
224:             THIS.ConfigurarBotoesAcao()
225:             THIS.ConfigurarEventosBotoes()
226:             THIS.ConfigurarEventosGrade()
227: 
228:             *-- Label1 + OpSubNivel (SIGOPMPN.Label1/OpSubNivel do dump) -
229:             *-- so ESTRUTURA visual aqui; o valor de txt_4c_OpSubNivel eh
230:             *-- preenchido em CarregarGrade() (depende de TmpNens, que e'
231:             *-- do form pai - mesma razao de ConfigurarGrade/CarregarGrade
232:             *-- estarem separados, regra #41)
233:             THIS.ConfigurarCamposComplementares()
234: 
235:             *-- E so DEPOIS a carga, que cria os tres cursores e liga as
236:             *-- grades (legado: tudo isso acontece dentro do MESMO Init,
237:             *-- nesta ordem - montagem, Create Cursor, bind). CarregarGrade
238:             *-- ja chama AjustarBotoesPorModo no fim, porque a visibilidade
239:             *-- de SelTudo/Apaga/Totaliza depende do SepPedras do nivel,
240:             *-- que so eh conhecido depois de consultar crSigCdOpd.
241:             THIS.CarregarGrade()
242: 
243:             THIS.LockScreen = .F.
244: 
245:             loc_lSucesso = .T.
246:         CATCH TO loc_oErro
247:             MsgErro(loc_oErro.Message + CHR(13) + ;
248:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
249:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.InicializarForm")
250:         ENDTRY
251: 
252:         RETURN loc_lSucesso

*-- Linhas 321 a 363:
321:     *--------------------------------------------------------------------------
322:     * ConfigurarGrade - grade de selecao (SIGOPMPN.Grade do dump, 7
323:     * colunas: seleciona/Usuario/codigo/data/Grupo/Conta/Peso). So a
324:     * ESTRUTURA visual: RecordSource/ControlSource de TmpPends ficam no
325:     * metodo de carga de dados (fase posterior - TmpPends nao existe
326:     * ainda, regra #41). ColumnOrder reproduz a ordem VISUAL do dump
327:     * (diferente da ordem de declaracao das Columns).
328:     *
329:     * Column1 "seleciona" embute um CheckBox no legado (fwcheckbox1,
330:     * ControlSource = TmpPends.Flag - Logico). O AddObject do CheckBox
331:     * fica para quando Column1.ControlSource apontar para uma coluna
332:     * Logica de verdade (regra #18 + nota de GarantirCheckBoxSelecionar
333:     * em FormSigOpMpd.prg, mesma familia de tela) - aqui so o
334:     * .ReadOnly de nascimento, espelhando o When do legado (fwcheckbox1.
335:     * When: Return (pcEscolha = 'INSERIR')).
336:     *--------------------------------------------------------------------------
337:     PROTECTED PROCEDURE ConfigurarGrade()
338:         THIS.AddObject("grd_4c_Grade", "Grid")
339: 
340:         WITH THIS.grd_4c_Grade
341:             .Top               = 118
342:             .Left              = 12
343:             .Width             = 668
344:             .Height            = 260
345:             .ColumnCount       = 7
346:             .FontName          = "Courier New"
347:             .AllowHeaderSizing = .F.
348:             .DeleteMark        = .F.
349:             .RecordMark        = .F.
350:             .RowHeight         = 17
351:             .ScrollBars        = 2
352:             *-- Grid.ReadOnly propaga para as colunas - por isso vem ANTES
353:             *-- delas (regra do projeto)
354:             .ReadOnly          = .F.
355:             .Visible           = .T.
356:         ENDWITH
357: 
358:         *-- Column1 "seleciona" - ColumnOrder=1 (default)
359:         WITH THIS.grd_4c_Grade.Column1
360:             .Width     = 15
361:             .FontName  = "Courier New"
362:             .FontSize  = 9
363:             .Movable   = .F.

*-- Linhas 543 a 585:
543:     *--------------------------------------------------------------------------
544:     * ConfigurarGradesDetalhe - grd_4c_Itens (SIGOPMPN.Gradeitem) e
545:     * grd_4c_Total (SIGOPMPN.GradeTotal), ambas com 9 colunas IDENTICAS
546:     * (mesmas ControlSource no legado: Nops/CMats/CGrus/CUnis/TpOps/Qtds/
547:     * Pesos/Cats/NEnvs - mesma ordem). So a ESTRUTURA visual aqui -
548:     * RecordSource/ControlSource ficam no metodo de carga (xPNensi/
549:     * xPNensiT nao existem ainda, regra #41).
550:     *
551:     * grd_4c_Total nasce Visible=.F. (legado, fim do Init:
552:     * "ThisForm.GradeTotal.Visible = .f."); o botao Totaliza alterna as
553:     * duas (fase de handlers - THIS.ok.Click do legado so chama Visible
554:     * em cascata, fica para CmdTotalizaClick em fase posterior).
555:     *--------------------------------------------------------------------------
556:     PROTECTED PROCEDURE ConfigurarGradesDetalhe()
557:         *-- grd_4c_Itens (Gradeitem) ----------------------------------------
558:         THIS.AddObject("grd_4c_Itens", "Grid")
559: 
560:         WITH THIS.grd_4c_Itens
561:             .Top               = 383
562:             .Left              = 12
563:             .Width             = 668
564:             .Height            = 206
565:             .ColumnCount       = 9
566:             .FontSize          = 8
567:             .HeaderHeight      = 16
568:             .RowHeight         = 16
569:             .AllowHeaderSizing = .F.
570:             .DeleteMark        = .F.
571:             .RecordMark        = .F.
572:             .ReadOnly          = .F.
573:             .Visible           = .T.
574:         ENDWITH
575: 
576:         WITH THIS.grd_4c_Itens.Column1
577:             .Width     = 80
578:             .FontName  = "Courier New"
579:             .FontSize  = 8
580:             .Movable   = .F.
581:             .Resizable = .F.
582:             .ReadOnly  = .T.
583:             .Format    = "L"
584:             .InputMask = "9999999999"
585:         ENDWITH

*-- Linhas 790 a 808:
790:             .Height            = 206
791:             .ColumnCount       = 9
792:             .AllowHeaderSizing = .F.
793:             .DeleteMark        = .F.
794:             .RecordMark        = .F.
795:             .ReadOnly          = .F.
796:             .Visible           = .F.
797:         ENDWITH
798: 
799:         WITH THIS.grd_4c_Total.Column1
800:             .Width     = 107
801:             .FontName  = "Courier New"
802:             .Movable   = .F.
803:             .Resizable = .F.
804:             .ReadOnly  = .T.
805:             .Visible   = .T.
806:             .Format    = "L"
807:             .InputMask = "9999999999"
808:         ENDWITH

*-- Linhas 1207 a 1225:
1207:             ENDIF
1208: 
1209:             IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1210:                 SELECT (loc_cAliasAnterior)
1211:             ENDIF
1212:         ENDIF
1213: 
1214:         IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
1215:             THIS.cmd_4c_SelTudo.Visible = loc_lModoIncluir
1216:         ENDIF
1217:         IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
1218:             THIS.cmd_4c_Apaga.Visible = loc_lModoIncluir
1219:         ENDIF
1220:         IF PEMSTATUS(THIS, "cmd_4c_Totaliza", 5)
1221:             THIS.cmd_4c_Totaliza.Visible = (loc_lModoIncluir AND loc_lSeparaPedras)
1222:         ENDIF
1223:     ENDPROC
1224: 
1225:     *--------------------------------------------------------------------------

*-- Linhas 1246 a 1264:
1246:     *
1247:     * obj_4c_Mm_obs (SIGOPMPN.mm_obs do dump) e' o EditBox de observacao -
1248:     * SEMPRE ReadOnly = .T. no legado (simples exibicao, nunca editavel).
1249:     * So a ESTRUTURA aqui: o ControlSource ("TmpPends.Obss") fica em
1250:     * CarregarGrade() pela MESMA razao das colunas das grades (regra #41 -
1251:     * TmpPends ainda nao existe neste ponto do Init).
1252:     *--------------------------------------------------------------------------
1253:     PROTECTED PROCEDURE ConfigurarCamposComplementares()
1254:         THIS.AddObject("lbl_4c_Label1", "Label")
1255:         WITH THIS.lbl_4c_Label1
1256:             .AutoSize  = .F.
1257:             .Top       = 93
1258:             .Left      = 12
1259:             .Width     = 136
1260:             .Height    = 15
1261:             .FontName  = "Tahoma"
1262:             .FontSize  = 8
1263:             .BackStyle = 0
1264:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1327 a 1412:
1327:         BINDEVENT(THIS.txt_4c_Procura, "LostFocus", THIS, "TxtProcuraLostFocus")
1328: 
1329:         *-- obj_4c_Mm_obs (mm_obs) - ReadOnly = .T. de nascimento (igual ao
1330:         *-- dump); ControlSource fica para CarregarGrade() (regra #41)
1331:         THIS.AddObject("obj_4c_Mm_obs", "EditBox")
1332:         WITH THIS.obj_4c_Mm_obs
1333:             .Top               = 192
1334:             .Left              = 690
1335:             .Width             = 301
1336:             .Height            = 184
1337:             .FontName          = "Tahoma"
1338:             .FontSize          = 8
1339:             .ReadOnly          = .T.
1340:             .DisabledBackColor = RGB(255, 255, 220)
1341:             .Visible           = .T.
1342:         ENDWITH
1343:     ENDPROC
1344: 
1345:     *--------------------------------------------------------------------------
1346:     * ValidarProcuraNumero - equivalente ao Valid legado de Get_Procura:
1347:     *
1348:     *   If Not Empty(This.Value)
1349:     *       Select TmpPends / Set Order To Numps / Set Near On
1350:     *       Seek This.Value / Set Near Off
1351:     *       ThisForm.Refresh
1352:     *       If (This.Value = TmpPends.Numps)
1353:     *           This.Value = 0
1354:     *       Else
1355:     *           Return 0
1356:     *       EndIf
1357:     *   EndIf
1358:     *
1359:     * "Return 0" do Valid legado mantem o foco no campo (SET NEAR so achou
1360:     * um vizinho, nao o Numps exato digitado) - aqui devolve .F. para o
1361:     * KeyPress decidir com NODEFAULT (ver TxtProcuraKeyPress). THIS.Refresh()
1362:     * repinta a grade de selecao (posicionada pelo SEEK) e obj_4c_Mm_obs
1363:     * (ControlSource = TmpPends.Obss, muda com o registro corrente).
1364:     *
1365:     * PROTECTED: so chamado de dentro da classe (regra #51 - nao eh metodo
1366:     * que precise ser alcancado de fora, diferente dos handlers de evento).
1367:     *--------------------------------------------------------------------------
1368:     PROTECTED PROCEDURE ValidarProcuraNumero()
1369:         LOCAL loc_lPodeSair, loc_cAliasPends, loc_cAliasAnterior, loc_nValor
1370: 
1371:         loc_lPodeSair   = .T.
1372:         loc_cAliasPends = ""
1373: 
1374:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1375:             loc_cAliasPends = THIS.this_oBusinessObject.this_cCursorPends
1376:         ENDIF
1377: 
1378:         IF !EMPTY(THIS.txt_4c_Procura.Value) AND !EMPTY(loc_cAliasPends) AND USED(loc_cAliasPends)
1379:             loc_nValor         = THIS.txt_4c_Procura.Value
1380:             loc_cAliasAnterior = ALIAS()
1381: 
1382:             SELECT (loc_cAliasPends)
1383:             SET ORDER TO Numps
1384:             SET NEAR ON
1385:             SEEK loc_nValor
1386:             SET NEAR OFF
1387: 
1388:             THIS.Refresh()
1389: 
1390:             IF loc_nValor = EVALUATE(loc_cAliasPends + ".Numps")
1391:                 THIS.txt_4c_Procura.Value = 0
1392:             ELSE
1393:                 loc_lPodeSair = .F.
1394:             ENDIF
1395: 
1396:             IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1397:                 SELECT (loc_cAliasAnterior)
1398:             ENDIF
1399:         ENDIF
1400: 
1401:         RETURN loc_lPodeSair
1402:     ENDPROC
1403: 
1404:     *--------------------------------------------------------------------------
1405:     * TxtProcuraKeyPress - PUBLIC (regra #3: alvo de BINDEVENT). Testa
1406:     * ENTER(13)/TAB(9) para simular o Valid legado (BINDEVENT "Valid" nao
1407:     * funciona em TextBox).
1408:     *
1409:     * TAB: quando ValidarProcuraNumero() devolve .F. (entrada invalida), o
1410:     * NODEFAULT suprime a navegacao padrao do Tab - o campo continua com o
1411:     * foco, igual ao "Return 0" do Valid legado.
1412:     *

*-- Linhas 1478 a 1500:
1478: 
1479:     *--------------------------------------------------------------------------
1480:     * GarantirCheckBoxSelecionar - embute o CheckBox na coluna de selecao da
1481:     * grade (legado: SIGOPMPN.Grade.seleciona.fwcheckbox1, ControlSource =
1482:     * TmpPends.Flag).
1483:     *
1484:     * Vive separado de ConfigurarGrade porque so pode rodar DEPOIS de
1485:     * Column1.ControlSource apontar para TmpPends.Flag, que eh Logico - e
1486:     * TmpPends nasce na carga, nao na montagem da tela (regra #41). Alem
1487:     * disso RecordSource RECRIA os objetos Column, entao a caixa tem de ser
1488:     * reinstalada a CADA rebind: por isso o PEMSTATUS, que torna o metodo
1489:     * idempotente.
1490:     *
1491:     * Os tres comandos sao inseparaveis (regra #18): AddObject so CRIA o
1492:     * objeto - sem CurrentControl a coluna continua desenhando o Text1 dela,
1493:     * e sem Sparse = .F. o CheckBox aparece apenas na linha ativa.
1494:     *
1495:     * O TOGGLE (Click/MouseDown/MouseUp/KeyPress com NODEFAULT, que eh como
1496:     * o legado alterna o valor - ele SUPRIME o toggle nativo e faz o Replace
1497:     * por codigo, ver SIGOPMPN.Grade.seleciona.fwcheckbox1.InteractiveChange
1498:     * -> ThisForm.Marca/Desmarca) eh da fase de EVENTOS. Aqui NAO se chama
1499:     * BINDEVENT: apontar para um handler que ainda nao existe estoura no
1500:     * proprio bind.

*-- Linhas 1530 a 1560:
1530:     * CarregarGrade - funil UNICO de carga e vinculo das TRES grades.
1531:     * Transcricao do trecho final do Init legado: depois de montar TmpPends/
1532:     * xPNensi/xPNensiT, ele faz o "With Thisform.Grade / .RecordSource = ...
1533:     * / .<coluna>.ControlSource = ..." para Grade, Gradeitem e GradeTotal.
1534:     *
1535:     * PUBLIC (regra #3/#51): o harness de teste chama CarregarLista/
1536:     * CarregarGrade de FORA da classe, e PEMSTATUS(...,5) devolve .T. para
1537:     * metodo PROTECTED, entao o teste entraria no branch e a chamada
1538:     * falharia em runtime.
1539:     *
1540:     * SigOpMpnBO.CarregarPendencias() recria os tres cursores do zero (mesma
1541:     * semantica do "Create Cursor" do Init legado) e so DEPOIS as grades sao
1542:     * ligadas - regra #41: Column.ControlSource de cursor que ainda nao
1543:     * existe derruba o Init e a tela nao abre.
1544:     *
1545:     * Ordem obrigatoria por grade: RecordSource -> ControlSource -> (Column1:
1546:     * AddObject do CheckBox) -> Width -> Header1.Caption -> ReadOnly. Mexer
1547:     * em RecordSource RECALCULA as larguras para o default 90 e reseta
1548:     * Header1.Caption, Sparse, CurrentControl e o ReadOnly das colunas (que
1549:     * volta a herdar o do Grid) - por isso tudo isso eh reaplicado AQUI, e
1550:     * nao so em ConfigurarGrade/ConfigurarGradesDetalhe (Problema 48 do
1551:     * FormCor; o ReadOnly da coluna sempre DEPOIS do ReadOnly do Grid).
1552:     *
1553:     * Bypass de SQL em modo teste/ValidarUIFidelity: TmpNens/TmpOperacao sao
1554:     * cursores do form PAI e nao existem em instanciacao headless - as
1555:     * grades ficam com a estrutura montada e sem dado, o que basta para a
1556:     * validacao de UI.
1557:     *--------------------------------------------------------------------------
1558:     PROCEDURE CarregarGrade()
1559:         LOCAL loc_lSucesso, loc_lBypassTeste, loc_oErro
1560:         LOCAL loc_cPends, loc_cPNensi, loc_cPNensiT, loc_cChaveDetalhe

*-- Linhas 1566 a 1630:
1566:             loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
1567:                 (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
1568: 
1569:             *-- Legado (Init, antes do "Create Cursor TmpPends"):
1570:             *-- "=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') / _DoppsNivel =
1571:             *-- crSigCdOpd.Nivels / ThisForm.OpSubNivel.Value = _DoppsNivel"
1572:             *-- - descricao do NIVEL de destino, lida do cursor global
1573:             *-- crSigCdOpd pela chave do nivel corrente do form pai
1574:             *-- (TmpNens.Dopps). TmpNens nao existe em modo teste/
1575:             *-- ValidarUIFidelity headless (cursor do form pai) - o guard
1576:             *-- USED() deixa o campo vazio nesse caso, igual ao resto da
1577:             *-- tela.
1578:             IF PEMSTATUS(THIS, "txt_4c_OpSubNivel", 5)
1579:                 loc_cNivelDestino = ""
1580:                 IF USED("TmpNens") AND USED("crSigCdOpd")
1581:                     loc_cAliasNivelAnt = ALIAS()
1582:                     IF SEEK(TmpNens.Dopps, "crSigCdOpd", "Dopps")
1583:                         loc_cNivelDestino = crSigCdOpd.Nivels
1584:                     ENDIF
1585:                     IF !EMPTY(loc_cAliasNivelAnt) AND USED(loc_cAliasNivelAnt)
1586:                         SELECT (loc_cAliasNivelAnt)
1587:                     ENDIF
1588:                 ENDIF
1589:                 THIS.txt_4c_OpSubNivel.Value = loc_cNivelDestino
1590:             ENDIF
1591: 
1592:             loc_cPends   = THIS.this_oBusinessObject.this_cCursorPends
1593:             loc_cPNensi  = THIS.this_oBusinessObject.this_cCursorPNensi
1594:             loc_cPNensiT = THIS.this_oBusinessObject.this_cCursorPNensiT
1595: 
1596:             IF !loc_lBypassTeste
1597:                 THIS.this_oBusinessObject.CarregarPendencias()
1598:             ENDIF
1599: 
1600:             *-- Grade de selecao (legado: With Thisform.Grade) -------------
1601:             IF USED(loc_cPends)
1602:                 WITH THIS.grd_4c_Grade
1603:                     .RecordSource = loc_cPends
1604: 
1605:                     *-- Mapeamento coluna -> campo transcrito do legado, que
1606:                     *-- liga as colunas pelo NOME (.Seleciona/.Usuario/
1607:                     *-- .Codigo/.Data/.Grupo/.Conta/.Peso); aqui pelo numero
1608:                     *-- da Column correspondente (ver ConfigurarGrade)
1609:                     .Column1.ControlSource = loc_cPends + ".Flag"
1610:                     .Column2.ControlSource = loc_cPends + ".Usuars"
1611:                     .Column3.ControlSource = loc_cPends + ".Numps"
1612:                     .Column4.ControlSource = loc_cPends + ".Datas"
1613:                     .Column5.ControlSource = loc_cPends + ".Grupo"
1614:                     .Column6.ControlSource = loc_cPends + ".Conta"
1615:                     .Column7.ControlSource = loc_cPends + ".TPesos"
1616:                 ENDWITH
1617: 
1618:                 *-- SO AGORA Column1 aponta para Flag (Logico): eh seguro
1619:                 *-- embutir o CheckBox (regra #18)
1620:                 THIS.GarantirCheckBoxSelecionar()
1621: 
1622:                 WITH THIS.grd_4c_Grade
1623:                     .Column1.Width = 15
1624:                     .Column2.Width = 100
1625:                     .Column3.Width = 80
1626:                     .Column4.Width = 75
1627:                     .Column5.Width = 130
1628:                     .Column6.Width = 130
1629:                     .Column7.Width = 100
1630: 

*-- Linhas 1647 a 1677:
1647:                 *-- obj_4c_Mm_obs (mm_obs) - mesma razao de regra #41 das
1648:                 *-- colunas da grade: TmpPends nao existia no momento do
1649:                 *-- AddObject (ConfigurarCamposComplementares), so agora o
1650:                 *-- ControlSource pode apontar para ele
1651:                 IF PEMSTATUS(THIS, "obj_4c_Mm_obs", 5)
1652:                     THIS.obj_4c_Mm_obs.ControlSource = loc_cPends + ".Obss"
1653:                 ENDIF
1654: 
1655:                 *-- Legado, ANTES de qualquer bind de detalhe: "Select
1656:                 *-- TmpPends / Go Bottom". A linha CORRENTE passa a ser a
1657:                 *-- ULTIMA, e eh dela que sai a chave mestre-detalhe logo
1658:                 *-- abaixo - por isso o Go Bottom vem AQUI e nao no fim do
1659:                 *-- metodo: posicionar depois deixaria a grade destacando a
1660:                 *-- ultima pendencia com as grades de baixo mostrando os
1661:                 *-- itens da PRIMEIRA.
1662:                 SELECT (loc_cPends)
1663:                 GO BOTTOM
1664:                 THIS.grd_4c_Grade.Refresh()
1665:             ENDIF
1666: 
1667:             *-- Chave mestre-detalhe: as duas grades de baixo mostram so os
1668:             *-- itens da pendencia CORRENTE. Legado: "Set Key To
1669:             *-- TmpPends.Emps + TmpPends.Dopps + STr(TmpPends.Numps, 10)",
1670:             *-- avaliado com TmpPends na linha em que o Go Bottom o deixou.
1671:             *-- Chave POSICIONAL char(33) - PADR explicito em cada parte,
1672:             *-- NUNCA ALLTRIM (regra #42). Com TmpPends vazio/ausente a
1673:             *-- chave fica vazia e as grades de detalhe nao filtram nada,
1674:             *-- que eh o estado correto de tela sem pendencia selecionada.
1675:             loc_cChaveDetalhe = ""
1676:             IF USED(loc_cPends) AND !EOF(loc_cPends)
1677:                 loc_cChaveDetalhe = PADR(EVALUATE(loc_cPends + ".Emps"), 3) + ;

*-- Linhas 1743 a 1829:
1743:             *-- sem reposicionar de novo, para nao desalinhar da chave
1744:             *-- mestre-detalhe que as grades de baixo ja estao usando.
1745:             IF USED(loc_cPends)
1746:                 SELECT (loc_cPends)
1747:                 THIS.grd_4c_Grade.Refresh()
1748:             ENDIF
1749: 
1750:             *-- Visibilidade de SelTudo/Apaga/Totaliza depende de
1751:             *-- SepPedras, que so eh conhecido depois da carga
1752:             THIS.AjustarBotoesPorModo()
1753: 
1754:             loc_lSucesso = .T.
1755:         CATCH TO loc_oErro
1756:             MsgErro(loc_oErro.Message + CHR(13) + ;
1757:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1758:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CarregarGrade")
1759:         ENDTRY
1760: 
1761:         RETURN loc_lSucesso
1762:     ENDPROC
1763: 
1764:     *--------------------------------------------------------------------------
1765:     * VincularGradeDetalhe - liga UMA das duas grades de detalhe ao seu
1766:     * cursor. As duas tem as MESMAS 9 colunas, nas MESMAS ControlSource do
1767:     * legado (Nops/CMats/CGrus/CUnis/TpOps/Qtds/Pesos/Cats/NEnvs, nessa
1768:     * ordem), por isso o bind eh um metodo unico - so largura e titulo
1769:     * diferem, e ficam no chamador.
1770:     *
1771:     * SET ORDER TO EmpDopNum + SET KEY TO reproduzem o filtro mestre-detalhe
1772:     * do legado ("Select xPnensiT / Set Order to EmpDopNum / Go Top / Set
1773:     * Key To <chave de TmpPends>"). Em xPNensi o legado conta com o indice
1774:     * EmpDopNum estar ativo por ser o ULTIMO criado - aqui a ordem eh
1775:     * explicita, que eh o mesmo efeito sem depender dessa ordem.
1776:     *
1777:     * Todas as 9 colunas voltam a ReadOnly = .T. DEPOIS do RecordSource: as
1778:     * duas grades sao de exibicao (no legado cada Text1 delas tem
1779:     * "When: Return .f.") e o RecordSource faz a coluna herdar de novo o
1780:     * ReadOnly = .F. do Grid.
1781:     *--------------------------------------------------------------------------
1782:     PROTECTED PROCEDURE VincularGradeDetalhe(par_oGrade, par_cCursor, par_cChave)
1783:         LOCAL loc_nI
1784: 
1785:         SELECT (par_cCursor)
1786:         SET ORDER TO EmpDopNum
1787:         GO TOP
1788:         IF EMPTY(par_cChave)
1789:             SET KEY TO
1790:         ELSE
1791:             SET KEY TO par_cChave
1792:         ENDIF
1793: 
1794:         WITH par_oGrade
1795:             .RecordSource = par_cCursor
1796: 
1797:             .Column1.ControlSource = par_cCursor + ".Nops"
1798:             .Column2.ControlSource = par_cCursor + ".CMats"
1799:             .Column3.ControlSource = par_cCursor + ".CGrus"
1800:             .Column4.ControlSource = par_cCursor + ".CUnis"
1801:             .Column5.ControlSource = par_cCursor + ".TpOps"
1802:             .Column6.ControlSource = par_cCursor + ".Qtds"
1803:             .Column7.ControlSource = par_cCursor + ".Pesos"
1804:             .Column8.ControlSource = par_cCursor + ".Cats"
1805:             .Column9.ControlSource = par_cCursor + ".NEnvs"
1806:         ENDWITH
1807: 
1808:         *-- Column.ReadOnly SEMPRE depois do Grid.ReadOnly (o do Grid
1809:         *-- propaga e sobrescreve) - regra #18/#46
1810:         FOR loc_nI = 1 TO par_oGrade.ColumnCount
1811:             par_oGrade.Columns(loc_nI).ReadOnly = .T.
1812:         ENDFOR
1813: 
1814:         SELECT (par_cCursor)
1815:         GO TOP
1816:         par_oGrade.Refresh()
1817:     ENDPROC
1818: 
1819:     *--------------------------------------------------------------------------
1820:     * CarregarLista - nome canonico de carga do projeto; funil unico para
1821:     * CarregarGrade(). PUBLIC pelo mesmo motivo (o harness chama de fora -
1822:     * regra #3).
1823:     *--------------------------------------------------------------------------
1824:     PROCEDURE CarregarLista()
1825:         RETURN THIS.CarregarGrade()
1826:     ENDPROC
1827: 
1828:     *--------------------------------------------------------------------------
1829:     * ChkSelecionarInteractiveChange - legado: SIGOPMPN.Grade.seleciona.

*-- Linhas 1835 a 1991:
1835:     *         This.Value = ThisForm.Marca()
1836:     *     EndIf
1837:     *
1838:     * O ControlSource ja gravou o novo valor em TmpPends.Flag ANTES deste
1839:     * handler disparar. THIS.this_oBusinessObject.CarregarDoCursor() le a
1840:     * linha CORRENTE (this_cEmps/this_cDopps/this_nNumps/this_dDatas), que
1841:     * Marcar()/Desmarcar() usam. Em .T. (marcando), Marcar() pode recusar
1842:     * (duplicidade/numeracao-automatica/data) - nesse caso desfaz o Flag,
1843:     * equivalente a "This.Value = ThisForm.Marca()" quando o retorno eh
1844:     * .F. Quando Marcar() sinaliza this_lFecharAposMarcar (legado:
1845:     * "This.ok.click" dentro do proprio marca, ramo _NumeroAnt), o RETURN
1846:     * fica FORA do TRY (regra #1) e so entao fecha via CmdOkClick.
1847:     *
1848:     * PUBLIC (regra #3: alvo de BINDEVENT).
1849:     *--------------------------------------------------------------------------
1850:     PROCEDURE ChkSelecionarInteractiveChange()
1851:         LOCAL loc_cAlias, loc_lNovoValor, loc_lResultado, loc_lFechar, loc_oErro
1852: 
1853:         loc_lFechar = .F.
1854: 
1855:         TRY
1856:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
1857: 
1858:             IF USED(loc_cAlias)
1859:                 SELECT (loc_cAlias)
1860:                 loc_lNovoValor = ConverterParaLogico(Flag)
1861: 
1862:                 THIS.this_oBusinessObject.CarregarDoCursor()
1863: 
1864:                 IF loc_lNovoValor
1865:                     loc_lResultado = THIS.this_oBusinessObject.Marcar(.F.)
1866: 
1867:                     IF !loc_lResultado
1868:                         SELECT (loc_cAlias)
1869:                         REPLACE Flag WITH .F.
1870:                     ELSE
1871:                         loc_lFechar = THIS.this_oBusinessObject.this_lFecharAposMarcar
1872:                     ENDIF
1873:                 ELSE
1874:                     THIS.this_oBusinessObject.Desmarcar()
1875:                 ENDIF
1876: 
1877:                 IF !loc_lFechar
1878:                     SELECT (loc_cAlias)
1879:                     THIS.grd_4c_Grade.Refresh()
1880:                 ENDIF
1881:             ENDIF
1882:         CATCH TO loc_oErro
1883:             MsgErro(loc_oErro.Message + CHR(13) + ;
1884:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1885:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.ChkSelecionarInteractiveChange")
1886:         ENDTRY
1887: 
1888:         IF loc_lFechar
1889:             THIS.CmdOkClick()
1890:         ENDIF
1891:     ENDPROC
1892: 
1893:     *--------------------------------------------------------------------------
1894:     * CmdSelTudoClick - legado: SIGOPMPN.SelTudo.Click
1895:     *     Select TmpPends
1896:     *     Scan For Not Flag
1897:     *         Replace Flag With ThisForm.Marca(.t.)
1898:     *     EndScan
1899:     *     ThisForm.Grade.Refresh
1900:     *
1901:     * Interrompe o Scan (EXIT) e fecha o dialogo (CmdOkClick) assim que
1902:     * Marcar() sinalizar this_lFecharAposMarcar - mesma semantica do
1903:     * legado, onde "This.ok.click" dentro de marca() libera (Release) o
1904:     * form NO MEIO do Scan.
1905:     *--------------------------------------------------------------------------
1906:     PROCEDURE CmdSelTudoClick()
1907:         LOCAL loc_cAlias, loc_lResultado, loc_lFecharApos, loc_oErro
1908: 
1909:         loc_lFecharApos = .F.
1910: 
1911:         TRY
1912:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
1913: 
1914:             IF USED(loc_cAlias)
1915:                 SELECT (loc_cAlias)
1916:                 SCAN FOR !Flag
1917:                     THIS.this_oBusinessObject.CarregarDoCursor()
1918:                     loc_lResultado = THIS.this_oBusinessObject.Marcar(.T.)
1919: 
1920:                     SELECT (loc_cAlias)
1921:                     REPLACE Flag WITH loc_lResultado
1922: 
1923:                     IF loc_lResultado AND THIS.this_oBusinessObject.this_lFecharAposMarcar
1924:                         loc_lFecharApos = .T.
1925:                         EXIT
1926:                     ENDIF
1927: 
1928:                     SELECT (loc_cAlias)
1929:                 ENDSCAN
1930: 
1931:                 IF !loc_lFecharApos
1932:                     THIS.grd_4c_Grade.Refresh()
1933:                 ENDIF
1934:             ENDIF
1935:         CATCH TO loc_oErro
1936:             MsgErro(loc_oErro.Message + CHR(13) + ;
1937:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1938:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CmdSelTudoClick")
1939:         ENDTRY
1940: 
1941:         IF loc_lFecharApos
1942:             THIS.CmdOkClick()
1943:         ENDIF
1944:     ENDPROC
1945: 
1946:     *--------------------------------------------------------------------------
1947:     * CmdApagaClick - legado: SIGOPMPN.apaga.Click
1948:     *     Select TmpPends
1949:     *     Scan For Flag
1950:     *         Replace Flag With ThisForm.DesMarca()
1951:     *     EndScan
1952:     *     ThisForm.Grade.Refresh
1953:     *
1954:     * DESVIO DOCUMENTADO: "DesMarca()" no legado so tem "Return 0" no
1955:     * caminho de ERRO (falha de SqlExecute); sem RETURN explicito no
1956:     * caminho normal, VFP devolve .T. implicito - logo "Replace Flag With
1957:     * ThisForm.DesMarca()" tende a GRAVAR Flag = .T. de volta (reversao
1958:     * acidental do proprio "apagar"), e no caminho de erro tentaria gravar
1959:     * o NUMERO 0 num campo Logico (type mismatch). Mesmo padrao ja adotado
1960:     * em FormSigOpMpd.CmdApagaClick (mesma familia de tela): zera Flag
1961:     * ANTES de chamar Desmarcar(), sem depender do retorno.
1962:     *--------------------------------------------------------------------------
1963:     PROCEDURE CmdApagaClick()
1964:         LOCAL loc_cAlias, loc_oErro
1965: 
1966:         TRY
1967:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
1968: 
1969:             IF USED(loc_cAlias)
1970:                 SELECT (loc_cAlias)
1971:                 SCAN FOR Flag
1972:                     SELECT (loc_cAlias)
1973:                     REPLACE Flag WITH .F.
1974:                     THIS.this_oBusinessObject.CarregarDoCursor()
1975:                     THIS.this_oBusinessObject.Desmarcar()
1976:                     SELECT (loc_cAlias)
1977:                 ENDSCAN
1978: 
1979:                 THIS.grd_4c_Grade.Refresh()
1980:             ENDIF
1981:         CATCH TO loc_oErro
1982:             MsgErro(loc_oErro.Message + CHR(13) + ;
1983:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1984:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CmdApagaClick")
1985:         ENDTRY
1986:     ENDPROC
1987: 
1988:     *--------------------------------------------------------------------------
1989:     * CmdTotalizaClick - legado: SIGOPMPN.Totaliza.Click. Alterna grd_4c_
1990:     * Itens (Gradeitem) com grd_4c_Total (GradeTotal) via this_nContador
1991:     * (legado: ThisForm.contador/ContaDor).

*-- Linhas 2032 a 2056:
2032:             STR(EVALUATE(loc_cAliasPends + ".Numps"), 10)
2033: 
2034:         IF USED(loc_cAliasPNensiT)
2035:             SELECT (loc_cAliasPNensiT)
2036:             SET KEY TO loc_cChave
2037:             GO TOP
2038:         ENDIF
2039: 
2040:         IF USED(loc_cAliasPNensi)
2041:             SELECT (loc_cAliasPNensi)
2042:             SET KEY TO loc_cChave
2043:             GO TOP
2044:         ENDIF
2045: 
2046:         THIS.grd_4c_Itens.Refresh()
2047:         THIS.obj_4c_Mm_obs.Refresh()
2048:     ENDPROC
2049: 
2050:     *--------------------------------------------------------------------------
2051:     * CmdOkClick - legado: SIGOPMPN.ok.Click. Grava (SigOpMpnBO.
2052:     * ConfirmarMovimentacoes - xMFas/xOpi/xNensi/SigCdNec) e so fecha o
2053:     * dialogo se a gravacao for bem-sucedida: no legado, qualquer "Return
2054:     * 0" dentro do Click aborta ANTES das duas ultimas linhas
2055:     * (ParentForm.Enabled = .t. / ThisForm.Release), ou seja, erro mantem
2056:     * a tela aberta (o MsgErro ja foi mostrado dentro do BO).

