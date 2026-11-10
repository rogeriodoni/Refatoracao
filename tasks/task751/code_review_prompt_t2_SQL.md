# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (10)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TAG' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EXIBSITS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALVARS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NMINENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PRAZOENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKPRZENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PCESCOLHA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NMAXENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TPVENCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS

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
  ControlSource = "TprMvCab.Qtdes"
  ControlSource = "TprMvCab.Espes"
  ControlSource = "TprMvCab.PLiqs"
  ControlSource = "TprMvCab.PBrus"
  ControlSource = "TprMvCab.ValTrans"
  ControlSource = "TprMvCab.CodObs"
  ControlSource = "TprMvCab.obses"
  ControlSource = "TprMvCab.protats"
  ControlSource = "TprMvCab.contaes"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TprMvCab.mascnum"
  ControlSource = "TprMvCab.notas"
  ControlSource = "TprMvCab.NumeroNota"
  ControlSource = "TprMvCab.ecfs"
  ControlSource = "TprMvCab.nemps"
  ControlSource = "TprMvCab.dtemis"
  ControlSource = "TprMvCab.prazoents"
  ControlSource = "TprMvCab.dtrecs"
  ControlSource = "TprMvCab.PRZCLIS"
  ControlSource = "TprMvCab.nPedClis"
  ControlSource = "TprMvCab.NLivDg"
	Select CrSigMvCab
	Select TprMvCab
	Select CrSigMvCab
	lcSql = [Select a.*, b.TpVencs,b.Entradas,b.dias,b.tVens From SigMvPar a, SigOpFp b where a.EmpDopNums = ']+TprMvCab.EmpDopNums+[' ]+;
	If Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalPar') < 1
	Select LocalPar
				lcQuery = [Select * From SigCdFer ]
				If ThisForm.Parentform.podatamgr.sqlexecute(lcquery,'CrSigCdFer') < 1
				Select CrSigCdFer
				lcSql = [Update SigMvPar Set Vencs = ?ldVenc Where CidChaves = ']+LocalPar.cidchaves+[']
				If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'') < 1
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvPar )')
	llOk = ThisForm.Parentform.PoDataMgr.UpDate('CrSigMvCab')
	Select TprMvCab
			Select * From TmpOperacao Into Cursor crSubDComp
			Select crSubDComp
		lcQuery = [Select ObsPads from SigCdOop where Dopes = ']+crSigCdOpe.Dopes+[' and Cfops = ']+crSigMvNfi.CfoSubs+[']
		lcQuery = [Select ObsPads from SigCdOop where Dopes = ']+crSigCdOpe.Dopes+[' and Cfops = ']+crSigMvNfi.Cfis+[']
	ThisForm.ParentForm.poDataMgr.SQLExecute(lcQuery,[crTmpCfoOp])
		Select TmpOperacao
			Select TmpOperacao
				Select TmpOperacao
					Select TmpOperacao
		Select xPar
					lcQuery = [Select * From SigCdFer ]
					If ThisForm.Parentform.podatamgr.sqlexecute(lcquery,'CrSigCdFer') < 1
					Select CrSigCdFer
		lcSql = [Update SigMvCab Set obses = '] + ALLTRIM(TprMvCab.obses) + [' Where CidChaves = ']+TprMvCab.cidchaves+[']
		If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab )')
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab )')
		lcQuery = [Select ObsInis, ObsFins from SigCdOop where Dopes = ']+crSigCdOpe.Dopes+[' and Cfops = ']+crSigMvNfi.Cfis+['] 
		loCnx.SQLExecute(lcQuery,[crTmpCfoOp])
	lcQuery = [Select Codigos, Descrs ] + ;
			    [From SigCdObs ] + ;
	If (loCnx.SqlExecute(lcQuery, 'crLocalObs') < 1)
	Select crLocalObs
	If Not Seek(This.Value, 'crLocalObs', 'Codigos')
	Select crSigCdObs
	lcQuery = [Select * From SigCdCli Where Cpfs = ?Cgc1 ]
	lnErro = ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
			Select CrTmpCli
		lcQuery = [Select * From SigCdCli Where ]+Iif(Len(RetCli)=10,[ Iclis = ],[ Cpfs = ])+[ ?RetCli ]
		lnErro = ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery,'CrTmpCli')
	Select CrTmpCli
	lcWhere = [Select * From SIGFIMPF Where cimpfabs = ?lcImpf ]
	LnErro = ThisForm.Parentform.Podatamgr.SqlExecute(lcWhere,'CrSIGFIMPF')
		Select CrSIGFIMPF

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopinf.prg) - TRECHOS RELEVANTES PARA PASS SQL (3554 linhas total):

*-- Linhas 14 a 33:
14: *   Lparameters pForm, pData, plAltDireta, plAutomatico
15: * Ela edita um SUBCONJUNTO de colunas do cursor de trabalho do form pai
16: * (TprMvCab, equivalente a SigMvCab) - a maioria dos controles escreve direto
17: * nesse cursor via ControlSource no legado, e o UNICO caminho de gravacao
18: * SQL direta desta tela e o UPDATE pontual de Obses em modo CONSULTAR com
19: * acesso ALTINFO liberado (ver sigopinfBO.Atualizar(), das Fases 1-2).
20: *
21: * FASE 3/8 - ESTRUTURA BASE. Entrega:
22: *   - DEFINE CLASS sobre FormBase com as propriedades visuais do dump
23: *     (Width/Height/Caption/BackColor/FontName/FontSize - analise.json)
24: *   - Init(): recebe os 4 parametros do form pai na MESMA ordem posicional do
25: *     Lparameters legado, guarda-os e delega a FormBase.Init() por
26: *     DODEFAULT(), que chama InicializarForm()
27: *   - InicializarForm(): instancia o sigopinfBO das Fases 1-2 e monta a casca
28: *     visual (cabecalho)
29: *   - SincronizarEscolhaPai(): copia o modo do form pai (this_cModoAtual), tal
30: *     como o Init legado faz com ".pcEscolha = ThisForm.ParentForm.pcEscolha"
31: *     - leitura UNICA no momento da abertura, nao referencia viva
32: *   - DesabilitarFormPai()/ReabilitarFormPai(): o
33: *     "ThisForm.ParentForm.Enabled = .f." do Init legado e o reverso no

*-- Linhas 60 a 95:
60: *
61: * FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1). Entrega a primeira metade dos
62: * containers de dados que pendulam direto no Form (layout.json), todos
63: * COM ControlSource = "TprMvCab.<col>" (igual ao legado - estes controles
64: * escrevem direto no cursor de trabalho do form pai, nao no BO):
65: *   - ConfigurarCamposDocumentos(): cntCodigos/cntDocumentos/cntEcfs/
66: *     cntNemps (mapeamento.json: cnt_4c_Codigos/cnt_4c_Documentos/
67: *     cnt_4c_Ecfs/cnt_4c_Nemps). getCodigos.When sempre .F. (campo nunca
68: *     editavel - MascNum e so exibicao); getDocumentos/GetNumeroNota.When
69: *     depende de crSigCdOpe (cursor do Init legado, ainda nao portado -
70: *     falso seguro ate existir); getNemps.Valid consulta SIGFIMPF via
71: *     fDecriptografar (wrapper utils/fdecriptografar.prg)
72: *   - ConfigurarCamposDatas(): cntEmiss/cntEntregas/cntRecepcaos/
73: *     cntPrzEnts (cnt_4c_Emiss/cnt_4c_Entregas/cnt_4c_Recepcaos/
74: *     cnt_4c_PrzEnts). Os 4 compartilham o mesmo Valid (data minima
75: *     01/01/1900) via ValidarDataMinima(); getEntregas.When e o UNICO
76: *     que so libera em INSERIR (os outros tres liberam em INSERIR E
77: *     ALTERAR) - Prz. Entrega so e alteravel depois pelo cmdEntrega
78: *     (Fase 4, CmdEntregaClick)
79: * FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (PARTE 2). Entrega os 7 containers
80: * que faltavam (todos ainda com ControlSource = "TprMvCab.<col>", como no
81: * legado):
82: *   - ConfigurarVolumes(): cntVolumes (5 campos de transporte), When
83: *     compartilhado (VolumesWhen)
84: *   - ConfigurarObservacao(): cntObservacao - getCodObs com o lookup
85: *     completo do legado (faixa ObsIni/ObsFins de SigCdOpe, fallback
86: *     FormBuscaAuxiliar em SigCdObs), getDesObs com o gate ALTINFO
87: *     (fChecaAcesso) e btnMultObs (abre SigOpIns - fora do acervo,
88: *     AvisarLegadoNaoPortado)
89: *   - ConfigurarProtocolo(): cntProtocolo (reaproveita PadraoIncluirAlterarWhen)
90: *   - ConfigurarEntrega(): cntEntrega - getContas/getDConta/getCpfs com o
91: *     lookup de conta em SigCdCli (checagem de acesso via fAcessoContas em
92: *     modo BACKEND - sem pSt1/pSt2 - regra do projeto contra auto-load de
93: *     UI, FormBuscaAuxiliar para o restante) e cmdEntrega ("Local de
94: *     Entrega", abre SigCdEnd - fora do acervo, AvisarLegadoNaoPortado)
95: *   - ConfigurarPedido()/ConfigurarObs2()/ConfigurarLivre(): cntPedido,

*-- Linhas 163 a 181:
163: *     linhas) - as validacoes de INSERIR/ALTERAR (observacao obrigatoria,
164: *     data de emissao, prazo de entrega minimo/maximo com liberacao via
165: *     SigOpSen, recepcao, cupom fiscal/ECF) e, no ramo ELSE (CONSULTAR),
166: *     o UPDATE pontual de Obses via sigopinfBO.Atualizar() (Fases 1-2) sob
167: *     o mesmo gate ALTINFO (fChecaAcesso) de DesObsWhen (Fase 6). Termina
168: *     chamando THIS.FecharDialogo() - identico ao "ThisForm.Return" do
169: *     final de cada ramo legado.
170: *   - SolicitarLiberacaoPrazoEntrega(): "Do Form SigOpSen With 'LIBPRZENT',
171: *     ... To _Retorno" repetido para os limites Minimo/Maximo - SigOpSen
172: *     NAO existe na nova arquitetura (memoria
173: *     feedback_sigopsen_ausente_gate_autorizacao); tratado FAIL-CLOSED,
174: *     mesmo padrao canonico de FormSigOpEnt.SolicitarLiberacaoPrazo.
175: *   - RecalcularVencimentosParcelas()/CarregarFeriados()/
176: *     AvancarAlemDosFeriados(): laco de feriados do btnSelItens.Click
177: *     (recalculo de vencimento das parcelas em "xPar" quando o Prazo de
178: *     Entrega muda), mesmo padrao de FormSigOpFpg.CarregarFeriados -
179: *     guardado por USED("xPar"): esse cursor pertence ao form PAI (grade
180: *     de parcelas da operacao), que nao existe no acervo desta migracao
181: *     (nenhum caller de Formsigopinf - ver DataSession abaixo); sem ele o

*-- Linhas 190 a 208:
190: *   - ProcessarLancamentoDireto(): ramo "If ThisForm.Direta" do "PROCEDURE
191: *     return" legado (empilha TprMvCab em CrSigMvCab para commit em lote
192: *     + recalculo de SigMvPar). CrSigMvCab e o commit em lote (antigo
193: *     ThisForm.ParentForm.PoDataMgr.UpDate/Commit/RollBack) pertencem ao
194: *     form PAI/orquestrador da operacao, inexistente no acervo - guardado
195: *     por USED("CrSigMvCab"), falso seguro documentado (nao se arrisca
196: *     ZAP em TprMvCab sem ter onde o lote foi persistido).
197: *
198: * NAO ha ConfigurarPageFrame/ConfigurarPaginaLista/ConfigurarPaginaDados nem
199: * AlternarPagina aqui: o SCX legado nao declara PageFrame (nenhuma linha
200: * "BaseClass: pageframe" no dump) e portanto nao ha pagina para configurar
201: * nem para alternar. Inventar Page1=Lista/Page2=Dados que o legado nao tem
202: * violaria o PILAR 1. O layout e FLAT: todos os containers penduram DIRETO
203: * no Form, como no dump (layout.json).
204: *
205: * DataSession: o Init legado faz "Set DataSession To pData" para operar na
206: * MESMA sessao do form pai (edita o cursor TprMvCab dele). Esta classe NAO
207: * sobrescreve DataSession (fica no default VFP9 = 1, "Default"), que e o
208: * equivalente OOP mais proximo - o form nasce na sessao ativa de quem o

*-- Linhas 274 a 292:
274:     * this_cFeriadosCache/this_lFeriadosCarregados - cache de SigCdFer
275:     * ("|AAAAMMDD|...") usado por AvancarAlemDosFeriados()/
276:     * CarregarFeriados(), mesmo padrao de FormSigOpFpg.CarregarFeriados -
277:     * evita um SELECT por parcela dentro do laco de recalculo de
278:     * vencimentos (RecalcularVencimentosParcelas, Fase 8).
279:     *--------------------------------------------------------------------------
280:     this_lValidOk            = .F.
281:     this_cFeriadosCache      = "|"
282:     this_lFeriadosCarregados = .F.
283: 
284:     *--------------------------------------------------------------------------
285:     * this_cUltimoContasLostFocusValidado/this_cUltimoDContaLostFocusValidado/
286:     * this_cUltimoCpfsLostFocusValidado - guardam o valor ja processado por
287:     * ContasLostFocus/DContaLostFocus/CpfsLostFocus. LostFocus dispara TODA
288:     * vez que o campo perde o foco, mesmo sem o usuario ter digitado nada -
289:     * diferente do Valid legado, que so dispara quando o valor MUDA. Sem
290:     * este guard, sair e voltar ao campo sem alterar o valor reabriria o
291:     * lookup/revalidaria o acesso a cada vez.
292:     *--------------------------------------------------------------------------

*-- Linhas 643 a 665:
643:     * (nao e o default inferido da regra #12 - aqui o legado DECLARA esse
644:     * valor, entao e so transcricao).
645:     *
646:     * Todos os TextBox tem ControlSource = "TprMvCab.<col>" - igual ao
647:     * legado, estes controles escrevem direto no cursor de trabalho do
648:     * form pai. Sem TprMvCab aberto (harness/probe headless), a atribuicao
649:     * de ControlSource e pulada (regra: Alias inexistente estoura ao
650:     * atribuir ControlSource, nao so ao exibir) e os campos ficam sem
651:     * binding, inofensivo fora do fluxo real.
652:     *==========================================================================
653:     PROTECTED PROCEDURE ConfigurarCamposDocumentos()
654:         LOCAL loc_oCnt, loc_lTemCursorPai
655:         loc_lTemCursorPai = USED("TprMvCab")
656: 
657:         *-- cnt_4c_Codigos (legado: cntCodigos) -----------------------------
658:         THIS.AddObject("cnt_4c_Codigos", "Container")
659:         loc_oCnt = THIS.cnt_4c_Codigos
660:         WITH loc_oCnt
661:             .Top         = 96
662:             .Left        = 2
663:             .Width       = 67
664:             .Height      = 45
665:             .BackStyle   = 0

*-- Linhas 697 a 715:
697:             .Visible       = .T.
698:         ENDWITH
699:         IF loc_lTemCursorPai
700:             loc_oCnt.txt_4c_Codigos.ControlSource = "TprMvCab.mascnum"
701:         ENDIF
702:         BINDEVENT(loc_oCnt.txt_4c_Codigos, "When", THIS, "CodigosWhen")
703: 
704:         *-- cnt_4c_Documentos (legado: cntDocumentos) -----------------------
705:         THIS.AddObject("cnt_4c_Documentos", "Container")
706:         loc_oCnt = THIS.cnt_4c_Documentos
707:         WITH loc_oCnt
708:             .Top         = 96
709:             .Left        = 69
710:             .Width       = 170
711:             .Height      = 45
712:             .BackStyle   = 0
713:             .BorderWidth = 0
714:             .Visible     = .T.
715:         ENDWITH

*-- Linhas 743 a 761:
743:             .Visible       = .T.
744:         ENDWITH
745:         IF loc_lTemCursorPai
746:             loc_oCnt.txt_4c_Documentos.ControlSource = "TprMvCab.notas"
747:         ENDIF
748:         BINDEVENT(loc_oCnt.txt_4c_Documentos, "When", THIS, "DocumentosWhen")
749: 
750:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
751:         WITH loc_oCnt.lbl_4c_Label1
752:             .FontBold  = .F.
753:             .FontName  = "Tahoma"
754:             .FontSize  = 8
755:             .BackStyle = 0
756:             .Alignment = 0
757:             .AutoSize  = .F.
758:             .Caption   = "Nota"
759:             .Left      = 73
760:             .Top       = 3
761:             .Width     = 25

*-- Linhas 777 a 795:
777:             .Visible       = .T.
778:         ENDWITH
779:         IF loc_lTemCursorPai
780:             loc_oCnt.txt_4c_NumeroNota.ControlSource = "TprMvCab.NumeroNota"
781:         ENDIF
782:         BINDEVENT(loc_oCnt.txt_4c_NumeroNota, "When", THIS, "DocumentosWhen")
783: 
784:         *-- cnt_4c_Ecfs (legado: cntEcfs) ------------------------------------
785:         THIS.AddObject("cnt_4c_Ecfs", "Container")
786:         loc_oCnt = THIS.cnt_4c_Ecfs
787:         WITH loc_oCnt
788:             .Top         = 96
789:             .Left        = 240
790:             .Width       = 65
791:             .Height      = 45
792:             .BackStyle   = 0
793:             .BorderWidth = 0
794:             .Visible     = .T.
795:         ENDWITH

*-- Linhas 826 a 844:
826:             .Visible       = .T.
827:         ENDWITH
828:         IF loc_lTemCursorPai
829:             loc_oCnt.txt_4c_Ecfs.ControlSource = "TprMvCab.ecfs"
830:         ENDIF
831:         BINDEVENT(loc_oCnt.txt_4c_Ecfs, "When", THIS, "PadraoIncluirAlterarWhen")
832: 
833:         *-- cnt_4c_Nemps (legado: cntNemps) ----------------------------------
834:         THIS.AddObject("cnt_4c_Nemps", "Container")
835:         loc_oCnt = THIS.cnt_4c_Nemps
836:         WITH loc_oCnt
837:             .Top         = 96
838:             .Left        = 305
839:             .Width       = 156
840:             .Height      = 45
841:             .BackStyle   = 0
842:             .BorderWidth = 0
843:             .Visible     = .T.
844:         ENDWITH

*-- Linhas 874 a 892:
874:             .Visible       = .T.
875:         ENDWITH
876:         IF loc_lTemCursorPai
877:             loc_oCnt.txt_4c_Nemps.ControlSource = "TprMvCab.nemps"
878:         ENDIF
879:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "When",      THIS, "PadraoIncluirAlterarWhen")
880:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "LostFocus",  THIS, "NempsLostFocus")
881:     ENDPROC
882: 
883:     *==========================================================================
884:     * CodigosWhen - "Return .f." do legado (getCodigos.When): o campo
885:     * Codigo/MascNum e so exibicao, nunca editavel em nenhum modo.
886:     *
887:     * PUBLIC: alvo de BINDEVENT("When").
888:     *==========================================================================
889:     FUNCTION CodigosWhen()
890:         RETURN .F.
891:     ENDFUNC
892: 

*-- Linhas 927 a 964:
927: 
928:     *==========================================================================
929:     * NempsLostFocus - "If Not Empty(This.Value) / lnNoFabr = This.Value /
930:     * lcImpf = fDecriptografar(alltrim(lnNoFabr)) / lcWhere = [Select *
931:     * From SIGFIMPF Where cimpfabs = ?lcImpf ] / ... MessageBox / Return
932:     * .f." do legado (getNemps.Valid). fDecriptografar e o wrapper de
933:     * utils/fdecriptografar.prg (regra #27 - algoritmo original fora do
934:     * acervo, pass-through seguro). Equivalente ao "ao sair do campo" do
935:     * Valid legado - ver regra #47 (lookup/validacao de TextBox solto vai
936:     * em LostFocus, nao em KeyPress).
937:     *
938:     * PUBLIC: alvo de BINDEVENT("LostFocus").
939:     *==========================================================================
940:     PROCEDURE NempsLostFocus()
941:         LOCAL loc_oTxt, loc_cImpf, loc_cSQL, loc_nErro, loc_oErro
942: 
943:         loc_oTxt = THIS.cnt_4c_Nemps.txt_4c_Nemps
944: 
945:         IF !EMPTY(loc_oTxt.Value)
946:             TRY
947:                 loc_cImpf = fDecriptografar(ALLTRIM(loc_oTxt.Value))
948:                 loc_cSQL  = "SELECT * FROM SIGFIMPF WHERE cimpfabs = " + EscaparSQL(loc_cImpf)
949:                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiMpF")
950: 
951:                 IF loc_nErro < 1
952:                     MsgErro("Favor reinicializar o processo." + CHR(13) + ;
953:                         "Falha na Conex" + CHR(227) + "o (SIGFIMPF)", "Erro")
954:                 ELSE
955:                     IF RECCOUNT("cursor_4c_SigFiMpF") = 0
956:                         MsgAviso("Impressora Fiscal n" + CHR(227) + "o Cadastrada!!", ;
957:                             "Aten" + CHR(231) + CHR(227) + "o")
958:                     ENDIF
959:                     IF USED("cursor_4c_SigFiMpF")
960:                         USE IN cursor_4c_SigFiMpF
961:                     ENDIF
962:                 ENDIF
963:             CATCH TO loc_oErro
964:                 MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1021 a 1039:
1021:             .Visible       = .T.
1022:         ENDWITH
1023:         IF loc_lTemCursorPai
1024:             loc_oCnt.txt_4c_Emiss.ControlSource = "TprMvCab.dtemis"
1025:         ENDIF
1026:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "When",      THIS, "PadraoIncluirAlterarWhen")
1027:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "LostFocus",  THIS, "EmissLostFocus")
1028: 
1029:         *-- cnt_4c_Entregas (legado: cntEntregas) ----------------------------
1030:         THIS.AddObject("cnt_4c_Entregas", "Container")
1031:         loc_oCnt = THIS.cnt_4c_Entregas
1032:         WITH loc_oCnt
1033:             .Top         = 147
1034:             .Left        = 88
1035:             .Width       = 86
1036:             .Height      = 45
1037:             .BackStyle   = 0
1038:             .BorderWidth = 0
1039:             .Visible     = .T.

*-- Linhas 1068 a 1086:
1068:             .Visible       = .T.
1069:         ENDWITH
1070:         IF loc_lTemCursorPai
1071:             loc_oCnt.txt_4c_Entregas.ControlSource = "TprMvCab.prazoents"
1072:         ENDIF
1073:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "When",     THIS, "EntregasWhen")
1074:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "LostFocus", THIS, "EntregasLostFocus")
1075: 
1076:         *-- cnt_4c_Recepcaos (legado: cntRecepcaos) --------------------------
1077:         THIS.AddObject("cnt_4c_Recepcaos", "Container")
1078:         loc_oCnt = THIS.cnt_4c_Recepcaos
1079:         WITH loc_oCnt
1080:             .Top         = 147
1081:             .Left        = 174
1082:             .Width       = 86
1083:             .Height      = 45
1084:             .BackStyle   = 0
1085:             .BorderWidth = 0
1086:             .Visible     = .T.

*-- Linhas 1115 a 1133:
1115:             .Visible       = .T.
1116:         ENDWITH
1117:         IF loc_lTemCursorPai
1118:             loc_oCnt.txt_4c_Recepcaos.ControlSource = "TprMvCab.dtrecs"
1119:         ENDIF
1120:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "When",     THIS, "PadraoIncluirAlterarWhen")
1121:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "LostFocus", THIS, "RecepcaosLostFocus")
1122: 
1123:         *-- cnt_4c_PrzEnts (legado: cntPrzEnts) ------------------------------
1124:         THIS.AddObject("cnt_4c_PrzEnts", "Container")
1125:         loc_oCnt = THIS.cnt_4c_PrzEnts
1126:         WITH loc_oCnt
1127:             .Top         = 147
1128:             .Left        = 260
1129:             .Width       = 86
1130:             .Height      = 45
1131:             .BackStyle   = 0
1132:             .BorderWidth = 0
1133:             .Visible     = .T.

*-- Linhas 1162 a 1180:
1162:             .Visible       = .T.
1163:         ENDWITH
1164:         IF loc_lTemCursorPai
1165:             loc_oCnt.txt_4c_PrzEnts.ControlSource = "TprMvCab.PRZCLIS"
1166:         ENDIF
1167:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "When",     THIS, "PadraoIncluirAlterarWhen")
1168:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "LostFocus", THIS, "PrzEntsLostFocus")
1169:     ENDPROC
1170: 
1171:     *==========================================================================
1172:     * EntregasWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR')" do
1173:     * legado (getEntregas.When) - UNICO dos 4 campos de data desta fase que
1174:     * so libera em INSERIR (os outros liberam INSERIR E ALTERAR). Depois do
1175:     * registro incluido, Prz. Entrega so muda pelo cmdEntrega (Fase 4,
1176:     * CmdEntregaClick), que grava TprMvCab.PrazoEnts e espelha no campo.
1177:     *
1178:     * PUBLIC: alvo de BINDEVENT("When").
1179:     *==========================================================================
1180:     FUNCTION EntregasWhen()

*-- Linhas 1246 a 1264:
1246:     * ConfigurarVolumes - cntVolumes (cnt_4c_Volumes): "Transporte" - 5
1247:     * campos de peso/volume do movimento. Geometria do dump (layout.json/
1248:     * sigopinf_form_codigo_fonte.txt SECAO 2). Todos com Alignment = 3
1249:     * (automatico - numerico alinha a direita) e ControlSource direto em
1250:     * TprMvCab, como no legado.
1251:     *==========================================================================
1252:     PROTECTED PROCEDURE ConfigurarVolumes()
1253:         LOCAL loc_oCnt, loc_lTemCursorPai
1254:         loc_lTemCursorPai = USED("TprMvCab")
1255: 
1256:         THIS.AddObject("cnt_4c_Volumes", "Container")
1257:         loc_oCnt = THIS.cnt_4c_Volumes
1258:         WITH loc_oCnt
1259:             .Top         = 264
1260:             .Left        = 488
1261:             .Width       = 509
1262:             .Height      = 66
1263:             .BackStyle   = 0
1264:             .BorderWidth = 0

*-- Linhas 1313 a 1331:
1313:             .Visible       = .T.
1314:         ENDWITH
1315:         IF loc_lTemCursorPai
1316:             loc_oCnt.txt_4c_Qtds.ControlSource = "TprMvCab.Qtdes"
1317:         ENDIF
1318:         BINDEVENT(loc_oCnt.txt_4c_Qtds, "When", THIS, "VolumesWhen")
1319: 
1320:         loc_oCnt.AddObject("lbl_4c_LblEspes", "Label")
1321:         WITH loc_oCnt.lbl_4c_LblEspes
1322:             .FontName  = "Tahoma"
1323:             .FontSize  = 8
1324:             .BackStyle = 0
1325:             .Alignment = 0
1326:             .AutoSize  = .F.
1327:             .Caption   = "Esp" + CHR(233) + "cie"
1328:             .Left      = 57
1329:             .Top       = 23
1330:             .Width     = 85
1331:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1347 a 1365:
1347:             .Visible       = .T.
1348:         ENDWITH
1349:         IF loc_lTemCursorPai
1350:             loc_oCnt.txt_4c_Espes.ControlSource = "TprMvCab.Espes"
1351:         ENDIF
1352:         BINDEVENT(loc_oCnt.txt_4c_Espes, "When", THIS, "VolumesWhen")
1353: 
1354:         loc_oCnt.AddObject("lbl_4c_LblPLiqs", "Label")
1355:         WITH loc_oCnt.lbl_4c_LblPLiqs
1356:             .FontName  = "Tahoma"
1357:             .FontSize  = 8
1358:             .BackStyle = 0
1359:             .Alignment = 0
1360:             .AutoSize  = .F.
1361:             .Caption   = "Peso L" + CHR(237) + "quido"
1362:             .Left      = 147
1363:             .Top       = 23
1364:             .Width     = 75
1365:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1381 a 1399:
1381:             .Visible       = .T.
1382:         ENDWITH
1383:         IF loc_lTemCursorPai
1384:             loc_oCnt.txt_4c_PLiqs.ControlSource = "TprMvCab.PLiqs"
1385:         ENDIF
1386:         BINDEVENT(loc_oCnt.txt_4c_PLiqs, "When", THIS, "VolumesWhen")
1387: 
1388:         loc_oCnt.AddObject("lbl_4c_LblPBrus", "Label")
1389:         WITH loc_oCnt.lbl_4c_LblPBrus
1390:             .FontName  = "Tahoma"
1391:             .FontSize  = 8
1392:             .BackStyle = 0
1393:             .Alignment = 0
1394:             .AutoSize  = .F.
1395:             .Caption   = "Peso Bruto"
1396:             .Left      = 223
1397:             .Top       = 23
1398:             .Width     = 75
1399:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1415 a 1433:
1415:             .Visible       = .T.
1416:         ENDWITH
1417:         IF loc_lTemCursorPai
1418:             loc_oCnt.txt_4c_PBrus.ControlSource = "TprMvCab.PBrus"
1419:         ENDIF
1420:         BINDEVENT(loc_oCnt.txt_4c_PBrus, "When", THIS, "VolumesWhen")
1421: 
1422:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1423:         WITH loc_oCnt.lbl_4c_Label1
1424:             .FontName  = "Tahoma"
1425:             .FontSize  = 8
1426:             .BackStyle = 0
1427:             .Alignment = 0
1428:             .AutoSize  = .F.
1429:             .Caption   = "Valor Transporte"
1430:             .Left      = 299
1431:             .Top       = 23
1432:             .Width     = 100
1433:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1449 a 1467:
1449:             .Visible       = .T.
1450:         ENDWITH
1451:         IF loc_lTemCursorPai
1452:             loc_oCnt.txt_4c_ValTrans.ControlSource = "TprMvCab.ValTrans"
1453:         ENDIF
1454:         BINDEVENT(loc_oCnt.txt_4c_ValTrans, "When", THIS, "VolumesWhen")
1455:     ENDPROC
1456: 
1457:     *==========================================================================
1458:     * VolumesWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')"
1459:     * do legado, texto IDENTICO nos 5 campos de cntVolumes (getQtds/getEspes/
1460:     * getPLiqs/getPBrus/getValTrans.When). Mesmo texto de PadraoIncluirAlterarWhen,
1461:     * mas com nome proprio para documentar a origem (grep direto pelo nome do
1462:     * container na auditoria).
1463:     *
1464:     * PUBLIC: alvo de BINDEVENT("When").
1465:     *==========================================================================
1466:     FUNCTION VolumesWhen()
1467:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

*-- Linhas 1520 a 1557:
1520:             .Visible       = .T.
1521:         ENDWITH
1522:         IF loc_lTemCursorPai
1523:             loc_oCnt.txt_4c_CodObs.ControlSource = "TprMvCab.CodObs"
1524:         ENDIF
1525:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "GotFocus",  THIS, "CodObsGotFocus")
1526:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "LostFocus", THIS, "CodObsLostFocus")
1527:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "When",      THIS, "CodObsWhen")
1528: 
1529:         loc_oCnt.AddObject("obj_4c_GetDesObs", "EditBox")
1530:         WITH loc_oCnt.obj_4c_GetDesObs
1531:             .FontSize      = 8
1532:             .Left          = 3
1533:             .Top           = 46
1534:             .Width         = 453
1535:             .Height        = 254
1536:             .SpecialEffect = 1
1537:             .ForeColor     = RGB(0, 0, 0)
1538:             .BorderColor   = RGB(100, 100, 100)
1539:             .Visible       = .T.
1540:         ENDWITH
1541:         IF loc_lTemCursorPai
1542:             loc_oCnt.obj_4c_GetDesObs.ControlSource = "TprMvCab.obses"
1543:         ENDIF
1544:         BINDEVENT(loc_oCnt.obj_4c_GetDesObs, "When", THIS, "DesObsWhen")
1545: 
1546:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
1547:         WITH loc_oCnt.cmd_4c_BtnMultObs
1548:             .Top          = 5
1549:             .Left         = 135
1550:             .Width        = 24
1551:             .Height       = 24
1552:             .Caption      = ""
1553:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1554:             .ToolTipText  = "Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es"
1555:             .Themes       = .T.
1556:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1557:             .Visible      = .T.

*-- Linhas 1593 a 1611:
1593:     *
1594:     *   If Not Empty(This.Value) And Not (This.Tag = Str(This.Value, 10))
1595:     *       <monta faixa ObsIni/ObsFins de SigCdOpe/SigCdOop>
1596:     *       <Select Codigos, Descrs From SigCdObs Where Codigos Between ...>
1597:     *       Set Near On / If Not Seek(...) -> fwBuscaSel / Set Near Off
1598:     *       This.Value = crLocalObs.Codigos
1599:     *       ThisForm.MontaObs(...)
1600:     *   EndIf
1601:     *
1602:     * A faixa SigCdOop (override por CFOP, dependente de crSigMvNfi/
1603:     * crSigOpCdd) nao esta disponivel nesta tela ainda (cursores de fases
1604:     * seguintes) - falso seguro: a faixa fica so com o ObsIni/ObsFins de
1605:     * SigCdOpe. fwBuscaSel -> FormBuscaAuxiliar (padrao do projeto).
1606:     *
1607:     * PUBLIC: alvo de BINDEVENT("LostFocus").
1608:     *==========================================================================
1609:     PROCEDURE CodObsLostFocus()
1610:         LOCAL loc_oTxt, loc_nPIni, loc_nPFim, loc_cSQL, loc_nErro, ;
1611:               loc_oBusca, loc_oErro, loc_lAchou

*-- Linhas 1619 a 1675:
1619:         loc_nPIni = 0
1620:         loc_nPFim = 999
1621:         IF USED("TprMvCab")
1622:             loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
1623:                 "WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
1624:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
1625: 
1626:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_LocalOpe") > 0
1627:                 loc_nPIni = IIF(!EMPTY(cursor_4c_LocalOpe.ObsInis), cursor_4c_LocalOpe.ObsInis, 0)
1628:                 loc_nPFim = IIF(!EMPTY(cursor_4c_LocalOpe.ObsFins), cursor_4c_LocalOpe.ObsFins, 999)
1629:             ENDIF
1630:             IF USED("cursor_4c_LocalOpe")
1631:                 USE IN cursor_4c_LocalOpe
1632:             ENDIF
1633:         ENDIF
1634: 
1635:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs WHERE Codigos BETWEEN " + ;
1636:             FormatarNumeroSQL(loc_nPIni, 0) + " AND " + FormatarNumeroSQL(loc_nPFim, 0)
1637:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalObs")
1638: 
1639:         IF loc_nErro < 1
1640:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1641:                 "Falha na conex" + CHR(227) + "o (cursor_4c_LocalObs)", "Erro")
1642:             RETURN
1643:         ENDIF
1644: 
1645:         loc_lAchou = .F.
1646:         IF USED("cursor_4c_LocalObs")
1647:             SELECT cursor_4c_LocalObs
1648:             LOCATE FOR Codigos = loc_oTxt.Value
1649:             loc_lAchou = FOUND()
1650:         ENDIF
1651: 
1652:         IF !loc_lAchou
1653:             loc_oBusca = .NULL.
1654:             TRY
1655:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1656:                     "SigCdObs", "cursor_4c_BuscaObs", "Codigos", ;
1657:                     TRANSFORM(loc_oTxt.Value), "Observa" + CHR(231) + CHR(245) + "es", ;
1658:                     .F., .F., ;
1659:                     "Codigos BETWEEN " + FormatarNumeroSQL(loc_nPIni, 0) + " AND " + ;
1660:                         FormatarNumeroSQL(loc_nPFim, 0))
1661:             CATCH TO loc_oErro
1662:                 MsgErro(loc_oErro.Message, "Erro ao abrir busca de observa" + CHR(231) + CHR(245) + "es")
1663:                 loc_oBusca = .NULL.
1664:             ENDTRY
1665: 
1666:             IF VARTYPE(loc_oBusca) = "O"
1667:                 IF !loc_oBusca.this_lAchouRegistro
1668:                     loc_oBusca.mAddColuna("Codigos", "999", "C" + CHR(243) + "d.")
1669:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1670:                     loc_oBusca.Show()
1671:                 ENDIF
1672: 
1673:                 IF loc_oBusca.this_lSelecionou
1674:                     loc_oTxt.Value = VAL(loc_oBusca.cCodigoSelecionado)
1675:                 ELSE

*-- Linhas 1706 a 1726:
1706:     PROTECTED PROCEDURE MontarObservacaoPadrao(par_nCodObs)
1707:         LOCAL loc_cSQL, loc_nErro, loc_cObs, loc_oTxtDesc
1708: 
1709:         loc_cSQL = "SELECT Codigos, Observas FROM SigCdObs WHERE Codigos = " + ;
1710:             FormatarNumeroSQL(par_nCodObs, 0)
1711:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdObs")
1712: 
1713:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SigCdObs") > 0
1714:             loc_cObs     = ALLTRIM(TratarNulo(cursor_4c_SigCdObs.Observas, "C"))
1715:             loc_oTxtDesc = THIS.cnt_4c_Observacao.obj_4c_GetDesObs
1716: 
1717:             IF "#" $ loc_cObs OR "$" $ loc_cObs OR "%" $ loc_cObs OR "!" $ loc_cObs
1718:                 THIS.AvisarLegadoNaoPortado("fMontaObs() / grade de itens (TmpOperacao)", ;
1719:                     "completar a observa" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o com os dados da grade")
1720:             ENDIF
1721: 
1722:             loc_oTxtDesc.Value = loc_cObs
1723:             loc_oTxtDesc.Refresh()
1724:         ENDIF
1725: 
1726:         IF USED("cursor_4c_SigCdObs")

*-- Linhas 1837 a 1855:
1837:             .Visible       = .T.
1838:         ENDWITH
1839:         IF loc_lTemCursorPai
1840:             loc_oCnt.txt_4c_Protocolos.ControlSource = "TprMvCab.protats"
1841:         ENDIF
1842:         BINDEVENT(loc_oCnt.txt_4c_Protocolos, "When", THIS, "PadraoIncluirAlterarWhen")
1843:     ENDPROC
1844: 
1845:     *==========================================================================
1846:     * ConfigurarEntrega - cntEntrega (cnt_4c_Entrega): conta/nome/cpf-cnpj
1847:     * do destinatario da entrega + botao "Local de Entrega". Os tres campos
1848:     * de conta sao intercambiaveis no legado (preencher um resolve os
1849:     * outros dois) - ver ContasLostFocus/DContaLostFocus/CpfsLostFocus.
1850:     *==========================================================================
1851:     PROTECTED PROCEDURE ConfigurarEntrega()
1852:         LOCAL loc_oCnt, loc_lTemCursorPai
1853:         loc_lTemCursorPai = USED("TprMvCab")
1854: 
1855:         THIS.AddObject("cnt_4c_Entrega", "Container")

*-- Linhas 1941 a 1959:
1941:             .Visible       = .T.
1942:         ENDWITH
1943:         IF loc_lTemCursorPai
1944:             loc_oCnt.txt_4c_Contas.ControlSource = "TprMvCab.contaes"
1945:         ENDIF
1946:         BINDEVENT(loc_oCnt.txt_4c_Contas, "LostFocus", THIS, "ContasLostFocus")
1947:         BINDEVENT(loc_oCnt.txt_4c_Contas, "When",      THIS, "PadraoIncluirAlterarWhen")
1948: 
1949:         loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
1950:         WITH loc_oCnt.txt_4c_Cpfs
1951:             .Left          = 77
1952:             .Top           = 40
1953:             .Width         = 131
1954:             .Height        = 23
1955:             .Margin        = 0
1956:             .SpecialEffect = 1
1957:             .ForeColor     = RGB(0, 0, 0)
1958:             .BorderColor   = RGB(100, 100, 100)
1959:             .Visible       = .T.

*-- Linhas 2107 a 2127:
2107:         LOCAL loc_cSQL, loc_nErro, loc_lAchou
2108:         loc_lAchou = .F.
2109: 
2110:         loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs, Situas FROM SigCdCli WHERE " + ;
2111:             par_cCampo + " = " + EscaparSQL(par_cValor)
2112:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaEntrega")
2113: 
2114:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_BuscaContaEntrega") > 0
2115:             IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
2116:                 THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
2117:                     ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
2118:             ELSE
2119:                 THIS.LimparContaEntrega()
2120:             ENDIF
2121:             loc_lAchou = .T.
2122:         ENDIF
2123: 
2124:         IF USED("cursor_4c_BuscaContaEntrega")
2125:             USE IN cursor_4c_BuscaContaEntrega
2126:         ENDIF
2127: 

*-- Linhas 2193 a 2213:
2193:             loc_cSituas = ALLTRIM(TratarNulo(EVALUATE(par_cCursor + ".Situas"), "C"))
2194: 
2195:             IF !EMPTY(loc_cSituas)
2196:                 loc_cSQL = "SELECT Codigos, Descrs, Descr2s, DispMovs, BlqMovs, BlqDescs FROM SigCdCst " + ;
2197:                     "WHERE Codigos = " + EscaparSQL(loc_cSituas)
2198:                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SituacaoConta")
2199: 
2200:                 IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SituacaoConta") > 0
2201:                     IF cursor_4c_SituacaoConta.DispMovs = 1
2202:                         loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
2203:                             cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
2204:                         MsgAviso(loc_cSituas + " - " + loc_cMsg, "Situa" + CHR(231) + CHR(227) + "o")
2205: 
2206:                         IF cursor_4c_SituacaoConta.BlqMovs = 1
2207:                             MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o Bloqueada pela Situa" + CHR(231) + CHR(227) + "o da Conta...", ;
2208:                                 "Aten" + CHR(231) + CHR(227) + "o")
2209:                             loc_lAceita = .F.
2210:                         ENDIF
2211:                     ENDIF
2212: 
2213:                     IF loc_lAceita AND USED("TprMvCab") AND TprMvCab.ValVars < 0 AND cursor_4c_SituacaoConta.BlqDescs = 1

*-- Linhas 2310 a 2330:
2310:             RETURN
2311:         ENDIF
2312: 
2313:         loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2314:             EscaparSQL(ALLTRIM(TprMvCab.ContaEs))
2315:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DCompCli")
2316: 
2317:         IF loc_nErro < 1 OR RECCOUNT("cursor_4c_DCompCli") = 0
2318:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2319:                 "Falha na conex" + CHR(227) + "o (SigCdCli)", "Erro")
2320:         ELSE
2321:             loc_cGrupos = ALLTRIM(cursor_4c_DCompCli.Grupos)
2322:             loc_cIClis  = ALLTRIM(cursor_4c_DCompCli.IClis)
2323:             loc_cRClis  = ALLTRIM(cursor_4c_DCompCli.RClis)
2324: 
2325:             TRY
2326:                 loc_oDlg = CREATEOBJECT("FormSigCdEnd", loc_cGrupos, loc_cIClis, loc_cRClis, ;
2327:                     THIS.this_cPcEscolha, TprMvCab.LocalEnts)
2328:                 IF VARTYPE(loc_oDlg) = "O"
2329:                     loc_oDlg.Show()
2330:                 ENDIF

*-- Linhas 2391 a 2409:
2391:             .Visible       = .T.
2392:         ENDWITH
2393:         IF loc_lTemCursorPai
2394:             loc_oCnt.txt_4c_Pedido.ControlSource = "TprMvCab.nPedClis"
2395:         ENDIF
2396:         BINDEVENT(loc_oCnt.txt_4c_Pedido, "When", THIS, "PedidoWhen")
2397:     ENDPROC
2398: 
2399:     *==========================================================================
2400:     * PedidoWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
2401:     * And Not (crSigCdOpe.PedClis = 5)" do legado (getPedido.When). Sem
2402:     * crSigCdOpe (fases seguintes), falso seguro - mesmo criterio de
2403:     * DocumentosWhen (bloqueia at? o dado confirmar que pode liberar).
2404:     *
2405:     * PUBLIC: alvo de BINDEVENT("When").
2406:     *==========================================================================
2407:     FUNCTION PedidoWhen()
2408:         LOCAL loc_lPermite
2409:         loc_lPermite = .F.

*-- Linhas 2531 a 2549:
2531:             .Visible       = .T.
2532:         ENDWITH
2533:         IF loc_lTemCursorPai
2534:             loc_oCnt.txt_4c_NLivDg.ControlSource = "TprMvCab.NLivDg"
2535:         ENDIF
2536:         BINDEVENT(loc_oCnt.txt_4c_NLivDg, "When", THIS, "PadraoIncluirAlterarWhen")
2537:     ENDPROC
2538: 
2539:     *==========================================================================
2540:     * AtualizarVisibilidadeCmdEntrega - "ThisForm.cmdEntrega.Visible =
2541:     * InList(crSigCdOpe.DtEntrs,1,4,6) And Not InList(ThisForm.pcEscolha,
2542:     * 'INSERIR','EXCLUIR')" do Init legado (linha 2100). crSigCdOpe e
2543:     * carregado pelo CursorQuery do Init legado, ainda nao portado (fases
2544:     * seguintes) - sem o cursor, o botao fica oculto (falso seguro); quem
2545:     * popular crSigCdOpe numa fase posterior deve chamar este metodo de
2546:     * novo para o botao assumir o estado real.
2547:     *
2548:     * PUBLIC: reutilizavel por fases/metodos futuros que alterem
2549:     * this_cPcEscolha ou recarreguem crSigCdOpe.

*-- Linhas 2684 a 2723:
2684:         IF USED("crSigCdOpe")
2685:             USE IN crSigCdOpe
2686:         ENDIF
2687:         loc_cSQL  = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2688:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe")
2689:         IF loc_nErro < 1
2690:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2691:                 "Falha na conex" + CHR(227) + "o (SigCdOpe)", "Erro")
2692:         ENDIF
2693: 
2694:         IF USED("CrSigOpCdc")
2695:             USE IN CrSigOpCdc
2696:         ENDIF
2697:         loc_cSQL  = "SELECT * FROM SigOpCdc WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2698:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdc")
2699:         IF loc_nErro < 1
2700:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2701:                 "Falha na conex" + CHR(227) + "o (SigOpCdc)", "Erro")
2702:         ENDIF
2703: 
2704:         IF USED("CrSigOpCdd")
2705:             USE IN CrSigOpCdd
2706:         ENDIF
2707:         loc_cSQL  = "SELECT * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2708:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdd")
2709:         IF loc_nErro < 1
2710:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2711:                 "Falha na conex" + CHR(227) + "o (SigOpCdd)", "Erro")
2712:         ENDIF
2713:     ENDPROC
2714: 
2715:     *==========================================================================
2716:     * CarregarPrazoEntregaPadrao - "PROCEDURE carregaprzent" do legado:
2717:     * sugere data de entrega padrao QUANDO o campo ainda esta vazio ou
2718:     * ainda e hoje - nunca sobrescreve um prazo que o usuario ja moveu.
2719:     *
2720:     *   If (InList(crSigCdOpe.DtEntrs,1,4,6) And InList(pcEscolha,
2721:     *      'INSERIR','ALTERAR') And (IsEmpty(PrazoEnts) Or
2722:     *      Dtos(PrazoEnts)=Dtos(Date())))
2723:     *       lcCta = Iif(crSigCdOpe.COpers=1, ContaDs, ContaOs)

*-- Linhas 2759 a 2778:
2759:         ENDIF
2760: 
2761:         IF !EMPTY(loc_cConta)
2762:             loc_cSQL  = "SELECT PrazoEnts FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
2763:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrazoCliente")
2764: 
2765:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_PrazoCliente") > 0 ;
2766:                AND cursor_4c_PrazoCliente.PrazoEnts > 0
2767:                 loc_dPrazo = loc_dPrazo + cursor_4c_PrazoCliente.PrazoEnts
2768:                 REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
2769:             ENDIF
2770: 
2771:             IF USED("cursor_4c_PrazoCliente")
2772:                 USE IN cursor_4c_PrazoCliente
2773:             ENDIF
2774:         ENDIF
2775:     ENDPROC
2776: 
2777:     *==========================================================================
2778:     * AtualizarVisibilidadePorOperacao - o corpo do Init legado que liga

*-- Linhas 3049 a 3067:
3049:     *        cupom fiscal-ECF / EditDocs=4]
3050:     *   Else
3051:     *       If fChecaAcesso(..., 'ALTINFO') And pcEscolha = 'CONSULTAR'
3052:     *           Update SigMvCab Set obses = ... Where CidChaves = ...
3053:     *       Endif
3054:     *   Endif
3055:     *   ThisForm.Return
3056:     *
3057:     * Cada "Return"/"Return .f." do legado (saida ANTECIPADA, sem gravar) e
3058:     * um RETURN bare deste metodo - so o CAMINHO FELIZ (fim de qualquer dos
3059:     * dois ramos) chama THIS.FecharDialogo(), equivalente ao "ThisForm.
3060:     * Return" final do legado.
3061:     *
3062:     * Guard de topo: sem TprMvCab/crSigCdOpe (cursores do form pai/Init
3063:     * legado) nao ha o que validar nem gravar - mesmo "falso seguro" das
3064:     * Fases 5-7 (CarregarPrazoEntregaPadrao, AtualizarVisibilidadePorOperacao).
3065:     *
3066:     * PUBLIC: alvo de BINDEVENT("Click") em ConfigurarBotoesAcao (Fase 4).
3067:     *==========================================================================

*-- Linhas 3275 a 3410:
3275:     * RecalcularVencimentosParcelas - laco de recalculo de vencimentos do
3276:     * btnSelItens.Click legado (disparado quando o Prazo de Entrega muda):
3277:     *
3278:     *   Select xPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3279:     *       =CursorQuery('SigOpFp','LocalFpag','fpags',xPar.Fpags,
3280:     *           [TpVencs,Entradas,Dias,tVens])
3281:     *       If LocalFpag.TpVencs = 2
3282:     *           DVenc = (Ttod(TprMvCab.PrazoEnts) + LocalFpag.Entradas)
3283:     *           Scan While Fpags=_lcFpg And cnIdTefs=_lcIdT
3284:     *               [laco de feriados] / Replace Vencs With DVenc
3285:     *               DVenc = Iif(TVen='F', GoMonth(DVenc,1), DVenc+NDia)
3286:     *           EndScan
3287:     *           Skip -1
3288:     *       Endif
3289:     *   EndScan
3290:     *
3291:     * par_cCursor: alias do cursor de parcelas a recalcular, agrupado por
3292:     * Fpags+CnIdTefs (colunas Fpags/CnIdTefs/Parcs/Vencs/CidChaves). "xPar"
3293:     * (parcelas do lancamento corrente, BtnSalvarClick) e "LocalPar"
3294:     * (parcelas de SigMvPar no lancamento direto, ProcessarLancamentoDireto)
3295:     * usam este MESMO metodo - layout de colunas identico, so a origem
3296:     * difere. Falso seguro: sem o cursor (par_cCursor), nao ha o que
3297:     * recalcular.
3298:     *
3299:     * par_lAtualizarBanco = .T. (LocalPar) tambem grava o vencimento no SQL
3300:     * Server ("Update SigMvPar Set Vencs = ... Where CidChaves = ..."),
3301:     * como o legado faz nesse caminho; .F. (xPar) e so cursor em memoria do
3302:     * form pai, igual ao legado.
3303:     *
3304:     * Feriados: AvancarAlemDosFeriados()/CarregarFeriados() reproduzem o
3305:     * MESMO padrao e a MESMA razao de FormSigOpFpg (decisao documentada
3306:     * la: SEEK string-sobre-data do legado nao e reproduzivel ao vivo,
3307:     * reescrito preservando a condicao de parada original).
3308:     *
3309:     * PROTECTED: chamado so por BtnSalvarClick() e ProcessarLancamentoDireto().
3310:     *==========================================================================
3311:     PROTECTED PROCEDURE RecalcularVencimentosParcelas(par_cCursor, par_lAtualizarBanco)
3312:         LOCAL loc_dVenc, loc_nDias, loc_cTipoVenc, loc_cFpgAtual, loc_cIdTefAtual
3313:         LOCAL loc_cSQLFpg, loc_nErro, loc_cSQLUpdate, loc_cCidChave
3314: 
3315:         IF !USED(par_cCursor) OR !USED("TprMvCab") OR EMPTY(TprMvCab.PrazoEnts)
3316:             RETURN
3317:         ENDIF
3318: 
3319:         SELECT (par_cCursor)
3320:         INDEX ON Fpags + CnIdTefs + STR(Parcs, 2) TAG FpagV
3321:         SCAN
3322:             loc_cFpgAtual = Fpags
3323: 
3324:             IF USED("cursor_4c_FpgVenc")
3325:                 USE IN cursor_4c_FpgVenc
3326:             ENDIF
3327:             loc_cSQLFpg = "SELECT TpVencs, Entradas, Dias, tVens FROM SigOpFp " + ;
3328:                 "WHERE Fpags = " + EscaparSQL(loc_cFpgAtual)
3329:             loc_nErro   = SQLEXEC(gnConnHandle, loc_cSQLFpg, "cursor_4c_FpgVenc")
3330:             SELECT (par_cCursor)
3331: 
3332:             IF loc_nErro >= 1 AND USED("cursor_4c_FpgVenc") AND cursor_4c_FpgVenc.TpVencs = 2
3333:                 loc_dVenc       = ConverterParaData(TprMvCab.PrazoEnts) + cursor_4c_FpgVenc.Entradas
3334:                 loc_nDias       = cursor_4c_FpgVenc.Dias
3335:                 loc_cTipoVenc   = cursor_4c_FpgVenc.tVens
3336:                 loc_cFpgAtual   = Fpags
3337:                 loc_cIdTefAtual = CnIdTefs
3338: 
3339:                 SCAN WHILE Fpags = loc_cFpgAtual AND CnIdTefs = loc_cIdTefAtual
3340:                     loc_dVenc = THIS.AvancarAlemDosFeriados(loc_dVenc)
3341:                     REPLACE Vencs WITH loc_dVenc IN (par_cCursor)
3342: 
3343:                     IF par_lAtualizarBanco
3344:                         loc_cCidChave  = CidChaves
3345:                         loc_cSQLUpdate = "UPDATE SigMvPar SET Vencs = " + ;
3346:                             FormatarDataSQL(loc_dVenc) + " WHERE CidChaves = " + ;
3347:                             EscaparSQL(loc_cCidChave)
3348:                         IF SQLEXEC(gnConnHandle, loc_cSQLUpdate) < 1
3349:                             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3350:                                 "Falha na conex" + CHR(227) + "o (Update SigMvPar)", "Erro")
3351:                         ENDIF
3352:                     ENDIF
3353: 
3354:                     loc_dVenc = IIF(loc_cTipoVenc = "F", GOMONTH(loc_dVenc, 1), loc_dVenc + loc_nDias)
3355:                 ENDSCAN
3356:                 SKIP -1
3357:             ENDIF
3358:         ENDSCAN
3359: 
3360:         IF USED("cursor_4c_FpgVenc")
3361:             USE IN cursor_4c_FpgVenc
3362:         ENDIF
3363:     ENDPROC
3364: 
3365:     *==========================================================================
3366:     * CarregarFeriados - Le SigCdFer uma unica vez para this_cFeriadosCache
3367:     * ("|AAAAMMDD|..."), mesmo padrao de FormSigOpFpg.CarregarFeriados -
3368:     * evita um SELECT por parcela dentro do laco de recalculo.
3369:     *==========================================================================
3370:     PROTECTED PROCEDURE CarregarFeriados()
3371:         LOCAL loc_cSQL, loc_nResultado, loc_cLista, loc_oErro
3372: 
3373:         IF THIS.this_lFeriadosCarregados
3374:             RETURN .T.
3375:         ENDIF
3376: 
3377:         loc_cLista = "|"
3378: 
3379:         TRY
3380:             IF USED("cursor_4c_FerLoad")
3381:                 USE IN SELECT("cursor_4c_FerLoad")
3382:             ENDIF
3383: 
3384:             loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"
3385: 
3386:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")
3387: 
3388:             IF loc_nResultado > 0 AND USED("cursor_4c_FerLoad")
3389:                 SELECT cursor_4c_FerLoad
3390:                 SCAN
3391:                     IF !ISNULL(datas) AND !EMPTY(datas)
3392:                         loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
3393:                     ENDIF
3394:                 ENDSCAN
3395:                 USE IN SELECT("cursor_4c_FerLoad")
3396:             ENDIF
3397: 
3398:             THIS.this_cFeriadosCache      = loc_cLista
3399:             THIS.this_lFeriadosCarregados = .T.
3400:         CATCH TO loc_oErro
3401:             THIS.this_cFeriadosCache = "|"
3402:         ENDTRY
3403: 
3404:         RETURN .T.
3405:     ENDPROC
3406: 
3407:     *==========================================================================
3408:     * AvancarAlemDosFeriados - laco de feriados do btnSelItens.Click legado:
3409:     *
3410:     *   lnFer = 0 / Verd = .t.

*-- Linhas 3493 a 3552:
3493:     * ProcessarLancamentoDireto - ramo "If ThisForm.Direta" do "PROCEDURE
3494:     * return" legado:
3495:     *
3496:     *   Select CrSigMvCab / Zap / Select TprMvCab / Scatter Memvar memo /
3497:     *   Select CrSigMvCab / Append Blank / Gather Memvar Memo
3498:     *   lcSql = Select a.*, b.TpVencs,b.Entradas,b.dias,b.tVens From SigMvPar a,
3499:     *       SigOpFp b where a.EmpDopNums = <TprMvCab.EmpDopNums> And a.Fpags = b.fpags
3500:     *   Select LocalPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3501:     *       [recalculo de vencimentos + Update SigMvPar - ver
3502:     *        RecalcularVencimentosParcelas]
3503:     *   EndScan
3504:     *   llOk = UpDate('CrSigMvCab') And Commit() > 0 / If !llOk -> RollBack()
3505:     *   Select TprMvCab / Zap
3506:     *
3507:     * CrSigMvCab (cursor de BATCH do lancamento direto) e o commit em lote
3508:     * (ThisForm.ParentForm.PoDataMgr.UpDate/Commit/RollBack) pertencem ao
3509:     * form PAI/orquestrador da operacao, inexistente nesta migracao (nenhum
3510:     * caller de Formsigopinf no acervo - ver cabecalho do arquivo). Falso
3511:     * seguro: sem CrSigMvCab, o bloco INTEIRO fica de fora - inclusive o
3512:     * recalculo de SigMvPar (que so faz sentido acoplado ao commit em lote)
3513:     * e o "Select TprMvCab / Zap" final, que SEM o lote persistido em outro
3514:     * lugar destruiria os dados do usuario (regra CLAUDE.md #17 - nao
3515:     * reproduzir so a metade de uma formula/fluxo que depende do resto).
3516:     *
3517:     * PROTECTED: so FecharDialogo(), desta mesma classe, chama.
3518:     *==========================================================================
3519:     PROTECTED PROCEDURE ProcessarLancamentoDireto()
3520:         LOCAL loc_cSQL, loc_nErro
3521: 
3522:         IF !THIS.this_lDireta OR !USED("CrSigMvCab") OR !USED("TprMvCab")
3523:             RETURN
3524:         ENDIF
3525: 
3526:         IF EMPTY(TprMvCab.EmpDopNums)
3527:             RETURN
3528:         ENDIF
3529: 
3530:         IF USED("LocalPar")
3531:             USE IN LocalPar
3532:         ENDIF
3533:         loc_cSQL = "SELECT a.*, b.TpVencs, b.Entradas, b.Dias, b.tVens " + ;
3534:             "FROM SigMvPar a, SigOpFp b " + ;
3535:             "WHERE a.EmpDopNums = " + EscaparSQL(TprMvCab.EmpDopNums) + " " + ;
3536:             "AND a.Fpags = b.Fpags"
3537:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "LocalPar")
3538:         IF loc_nErro < 1
3539:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3540:                 "Falha na conex" + CHR(227) + "o ( LocalPar )", "Erro")
3541:             RETURN
3542:         ENDIF
3543: 
3544:         THIS.RecalcularVencimentosParcelas("LocalPar", .T.)
3545: 
3546:         IF USED("LocalPar")
3547:             USE IN LocalPar
3548:         ENDIF
3549: 
3550:         *-- Commit em lote (CrSigMvCab) fora do escopo desta migracao - ver
3551:         *-- comentario de cabecalho do metodo.
3552:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigopinfBO.prg):
*====================================================================
* sigopinfBO.prg
*
* Business Object para o dialogo "Informacoes Gerais" (SIGOPINF)
* Entidade base: SigMvCab (cabecalho do movimento/operacao)
* Herda de: BusinessBase
*
* NOTA: SIGOPINF e um dialogo FILHO, aberto pelo form de cabecalho da
* operacao (ParentForm) e que edita um SUBCONJUNTO de colunas do cursor
* TprMvCab (cursor de trabalho do pai, equivalente a SigMvCab). Este BO
* nao persiste diretamente em SigMvCab - quem grava o cabecalho e o
* form pai, quando a operacao principal e salva (os controles desta
* tela ja escrevem direto em TprMvCab via ControlSource).
*
* O UNICO caminho de gravacao direta no legado (SIGOPINF.cntBotoes.Click,
* ramo Else) acontece em modo CONSULTAR, quando o usuario tem acesso
* ALTINFO liberado: um UPDATE pontual da coluna Obses, pela chave
* CidChaves. E esse caminho que Atualizar() reproduz aqui.
*
* Nomes de coluna confirmados em docs/schema.sql (UTF-16) e no dump
* SIGOPINF.ControlSource (tasks/task751/sigopinf_form_codigo_fonte.txt):
*   cntVolumes.getQtds      -> Qtdes       (numeric)
*   cntVolumes.getEspes     -> Espes       (char)
*   cntVolumes.getPLiqs     -> PLiqs       (numeric)
*   cntVolumes.getPBrus     -> PBrus       (numeric)
*   cntVolumes.getValTrans  -> ValTrans    (numeric)
*   cntObservacao.getCodObs -> CodObs      (numeric)
*   cntObservacao.getDesObs -> Obses       (text/memo)
*   CntObs2.btnMultObs      -> CodObs2     (char)
*   cntProtocolo.getProtocolos -> Protats  (numeric)
*   cntEntrega.getContas    -> ContaEs     (char)
*   cntCodigos.getCodigos   -> MascNum     (char)
*   cntDocumentos.getDocumentos -> Notas   (char)
*   cntDocumentos.GetNumeroNota -> NumeroNota (char)
*   cntEcfs.getEcfs         -> Ecfs        (char)
*   cntNemps.getNemps       -> Nemps       (char)
*   cntEmiss.getEmiss       -> DtEmis      (datetime)
*   cntEntregas.getEntregas -> PrazoEnts   (datetime)
*   cntRecepcaos.getRecepcaos -> DtRecs    (datetime)
*   cntPrzEnts.getPrzEnts   -> PrzClis     (datetime)
*   cntPedido.getPedido     -> nPedClis    (numeric)
*   cntLivre.getNLivDg      -> NLivDg      (numeric)
*====================================================================

DEFINE CLASS sigopinfBO AS BusinessBase

    *-- Identificacao do movimento (TprMvCab - chave posicional)
    this_cEmps        = ""    && TprMvCab.Emps char(3) - empresa
    this_cDopes       = ""    && TprMvCab.Dopes char(20) - tipo de documento/operacao
    this_nNumes       = 0     && TprMvCab.Numes numeric - numero do documento
    this_cEmpDopNums  = ""    && TprMvCab.EmpDopNums char(29) - chave posicional (Emps + Dopes + Str(Numes,6))
    this_cCidChaves   = ""    && TprMvCab.CidChaves char - chave do registro, usada no UPDATE pontual de Obses (modo CONSULTAR + acesso ALTINFO)

    *-- Datas (containers cntEmiss/cntEntregas/cntPrzEnts/cntRecepcaos)
    this_dDatas       = {}    && TprMvCab.Datas - data do movimento (usada em validacoes de prazo; nao editavel nesta tela)
    this_dDtEmis      = {}    && TprMvCab.DtEmis - data de emissao do documento
    this_dPrazoEnts   = {}    && TprMvCab.PrazoEnts - prazo de entrega
    this_dPrzClis     = {}    && TprMvCab.PrzClis - data prometida ao cliente
    this_dRecepcaos   = {}    && TprMvCab.DtRecs - data de recepcao

    *-- Contas (container cntEntrega - conta/nome/cpf-cnpj da entrega)
    this_cContaDs     = ""    && TprMvCab.ContaDs - conta (duplicata)
    this_cContaOs     = ""    && TprMvCab.ContaOs - conta (ordem de servico)
    this_cContaEs     = ""    && TprMvCab.ContaEs - conta de entrega
    this_cDescContaEs = ""    && Nome/razao social da conta de entrega (consulta auxiliar SigCdCli - NAO persistido em TprMvCab)
    this_cCpfContaEs  = ""    && CPF/CNPJ da conta de entrega (consulta auxiliar SigCdCli - NAO persistido em TprMvCab)

    *-- Observacoes (container cntObservacao/CntObs2)
    this_nCodObs      = 0     && TprMvCab.CodObs - codigo da observacao (crSigCdObs.Codigos)
    this_cObses       = ""    && TprMvCab.Obses - texto da observacao (memo)
    this_cCodObs2     = ""    && TprMvCab.CodObs2 - codigos de observacoes de finalidade (lista concatenada)

    *-- Entrega/protocolo/documentos
    this_nLocalEnts   = 0     && TprMvCab.LocalEnts numeric - codigo do endereco alternativo de entrega (SigCdCee.Codigos)
    this_nProtocolos  = 0     && TprMvCab.Protats numeric - protocolo
    this_cCodigos     = ""    && TprMvCab.MascNum - mascara/codigo de referencia da tela (cntCodigos)
    this_cDocumentos  = ""    && TprMvCab.Notas - numero do documento
    this_cNumeroNota  = ""    && TprMvCab.NumeroNota - numero da nota fiscal
    this_cEcfs        = ""    && TprMvCab.Ecfs - identificacao do ECF
    this_cNemps       = ""    && TprMvCab.Nemps - numero de serie da impressora fiscal (criptografado)
    this_nPedido      = 0     && TprMvCab.nPedClis numeric - numero do pedido
    this_nNLivDg      = 0     && TprMvCab.NLivDg numeric - numero do lacre

    *-- Volumes/transporte (container cntVolumes)
    this_nQtds        = 0     && TprMvCab.Qtdes - quantidade de volumes
    this_cEspes       = ""    && TprMvCab.Espes - especie do volume
    this_nPLiqs       = 0     && TprMvCab.PLiqs - peso liquido
    this_nPBrus       = 0     && TprMvCab.PBrus - peso bruto
    this_nValTrans    = 0     && TprMvCab.ValTrans - valor do transporte

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "CidChaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - chave do registro corrente (TprMvCab.CidChaves)
    * Usada por RegistrarAuditoria() apos o UPDATE pontual de Obses.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir do cursor
    * de trabalho do form pai (TprMvCab). Cada campo e lido sob guarda de
    * TYPE() porque o alias recebido pode trazer so um subconjunto das
    * colunas (ex.: cursor de teste automatizado).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Identificacao do movimento
                IF TYPE("Emps") != "U"
                    THIS.this_cEmps = TratarNulo(Emps, "C")
                ENDIF
                IF TYPE("Dopes") != "U"
                    THIS.this_cDopes = TratarNulo(Dopes, "C")
                ENDIF
                IF TYPE("Numes") != "U"
                    THIS.this_nNumes = TratarNulo(Numes, "N")
                ENDIF
                IF TYPE("EmpDopNums") != "U"
                    THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                ENDIF
                IF TYPE("CidChaves") != "U"
                    THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                ENDIF

                *-- Datas
                IF TYPE("Datas") != "U"
                    THIS.this_dDatas = TratarNulo(Datas, "D")
                ENDIF
                IF TYPE("DtEmis") != "U"
                    THIS.this_dDtEmis = TratarNulo(DtEmis, "D")
                ENDIF
                IF TYPE("PrazoEnts") != "U"
                    THIS.this_dPrazoEnts = TratarNulo(PrazoEnts, "D")
                ENDIF
                IF TYPE("PrzClis") != "U"
                    THIS.this_dPrzClis = TratarNulo(PrzClis, "D")
                ENDIF
                IF TYPE("DtRecs") != "U"
                    THIS.this_dRecepcaos = TratarNulo(DtRecs, "D")
                ENDIF

                *-- Contas
                IF TYPE("ContaDs") != "U"
                    THIS.this_cContaDs = TratarNulo(ContaDs, "C")
                ENDIF
                IF TYPE("ContaOs") != "U"
                    THIS.this_cContaOs = TratarNulo(ContaOs, "C")
                ENDIF
                IF TYPE("ContaEs") != "U"
                    THIS.this_cContaEs = TratarNulo(ContaEs, "C")
                ENDIF

                *-- Observacoes
                IF TYPE("CodObs") != "U"
                    THIS.this_nCodObs = TratarNulo(CodObs, "N")
                ENDIF
                IF TYPE("Obses") != "U"
                    THIS.this_cObses = TratarNulo(Obses, "C")
                ENDIF
                IF TYPE("CodObs2") != "U"
                    THIS.this_cCodObs2 = TratarNulo(CodObs2, "C")
                ENDIF

                *-- Entrega/protocolo/documentos
                IF TYPE("LocalEnts") != "U"
                    THIS.this_nLocalEnts = TratarNulo(LocalEnts, "N")
                ENDIF
                IF TYPE("Protats") != "U"
                    THIS.this_nProtocolos = TratarNulo(Protats, "N")
                ENDIF
                IF TYPE("MascNum") != "U"
                    THIS.this_cCodigos = TratarNulo(MascNum, "C")
                ENDIF
                IF TYPE("Notas") != "U"
                    THIS.this_cDocumentos = TratarNulo(Notas, "C")
                ENDIF
                IF TYPE("NumeroNota") != "U"
                    THIS.this_cNumeroNota = TratarNulo(NumeroNota, "C")
                ENDIF
                IF TYPE("Ecfs") != "U"
                    THIS.this_cEcfs = TratarNulo(Ecfs, "C")
                ENDIF
                IF TYPE("Nemps") != "U"
                    THIS.this_cNemps = TratarNulo(Nemps, "C")
                ENDIF
                IF TYPE("nPedClis") != "U"
                    THIS.this_nPedido = TratarNulo(nPedClis, "N")
                ENDIF
                IF TYPE("NLivDg") != "U"
                    THIS.this_nNLivDg = TratarNulo(NLivDg, "N")
                ENDIF

                *-- Volumes/transporte
                IF TYPE("Qtdes") != "U"
                    THIS.this_nQtds = TratarNulo(Qtdes, "N")
                ENDIF
                IF TYPE("Espes") != "U"
                    THIS.this_cEspes = TratarNulo(Espes, "C")
                ENDIF
                IF TYPE("PLiqs") != "U"
                    THIS.this_nPLiqs = TratarNulo(PLiqs, "N")
                ENDIF
                IF TYPE("PBrus") != "U"
                    THIS.this_nPBrus = TratarNulo(PBrus, "N")
                ENDIF
                IF TYPE("ValTrans") != "U"
                    THIS.this_nValTrans = TratarNulo(ValTrans, "N")
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Inserir - Nao aplicavel a este dialogo. O cabecalho do movimento
    * (SigMvCab) e criado pelo form PAI (operacao principal) quando a
    * operacao e salva; SIGOPINF so edita colunas do cursor TprMvCab
    * (ja atualizado em memoria pelos proprios controles via
    * ControlSource) e devolve o controle com ThisForm.Return.
    *====================================================================
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *====================================================================
    * Atualizar - Reproduz o UNICO caminho de gravacao direta do legado
    * (SIGOPINF.cntBotoes.Click, ramo Else): em modo CONSULTAR, com
    * acesso ALTINFO liberado, confirma apenas a observacao (Obses) do
    * cabecalho, pela chave CidChaves. O Form e quem decide, antes de
    * chamar Salvar()/Atualizar(), se o acesso ALTINFO permite a acao -
    * este metodo so executa a gravacao em si.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave do registro n" + CHR(227) + "o informada."
            ELSE
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                           "Obses = " + EscaparSQL(ALLTRIM(THIS.this_cObses)) + " " + ;
                           "WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Erro ao atualizar a observa" + CHR(231) + CHR(227) + "o do movimento."
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                ELSE
                    THIS.RegistrarAuditoria("A")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

