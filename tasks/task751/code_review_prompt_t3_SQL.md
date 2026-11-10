# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (9)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TAG' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EXIBSITS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALVARS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NMINENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PRAZOENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHKPRZENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PCESCOLHA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NMAXENTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TPVENCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, FPAGS, CNIDTEFS, CIDCHAVES, DOPES, CFOPS, DTEMIS, CODIGOS, BLQDESCS, VALUE, ICLIS, CPFS, CGC1, CIMPFABS

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopinf.prg) - TRECHOS RELEVANTES PARA PASS SQL (3573 linhas total):

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

*-- Linhas 652 a 674:
652:     * (nao e o default inferido da regra #12 - aqui o legado DECLARA esse
653:     * valor, entao e so transcricao).
654:     *
655:     * Todos os TextBox tem ControlSource = "TprMvCab.<col>" - igual ao
656:     * legado, estes controles escrevem direto no cursor de trabalho do
657:     * form pai. Sem TprMvCab aberto (harness/probe headless), a atribuicao
658:     * de ControlSource e pulada (regra: Alias inexistente estoura ao
659:     * atribuir ControlSource, nao so ao exibir) e os campos ficam sem
660:     * binding, inofensivo fora do fluxo real.
661:     *==========================================================================
662:     PROTECTED PROCEDURE ConfigurarCamposDocumentos()
663:         LOCAL loc_oCnt, loc_lTemCursorPai
664:         loc_lTemCursorPai = USED("TprMvCab")
665: 
666:         *-- cnt_4c_Codigos (legado: cntCodigos) -----------------------------
667:         THIS.AddObject("cnt_4c_Codigos", "Container")
668:         loc_oCnt = THIS.cnt_4c_Codigos
669:         WITH loc_oCnt
670:             .Top         = 96
671:             .Left        = 2
672:             .Width       = 67
673:             .Height      = 45
674:             .BackStyle   = 0

*-- Linhas 706 a 724:
706:             .Visible       = .T.
707:         ENDWITH
708:         IF loc_lTemCursorPai
709:             loc_oCnt.txt_4c_Codigos.ControlSource = "TprMvCab.mascnum"
710:         ENDIF
711:         BINDEVENT(loc_oCnt.txt_4c_Codigos, "When", THIS, "CodigosWhen")
712: 
713:         *-- cnt_4c_Documentos (legado: cntDocumentos) -----------------------
714:         THIS.AddObject("cnt_4c_Documentos", "Container")
715:         loc_oCnt = THIS.cnt_4c_Documentos
716:         WITH loc_oCnt
717:             .Top         = 96
718:             .Left        = 69
719:             .Width       = 170
720:             .Height      = 45
721:             .BackStyle   = 0
722:             .BorderWidth = 0
723:             .Visible     = .T.
724:         ENDWITH

*-- Linhas 752 a 770:
752:             .Visible       = .T.
753:         ENDWITH
754:         IF loc_lTemCursorPai
755:             loc_oCnt.txt_4c_Documentos.ControlSource = "TprMvCab.notas"
756:         ENDIF
757:         BINDEVENT(loc_oCnt.txt_4c_Documentos, "When", THIS, "DocumentosWhen")
758: 
759:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
760:         WITH loc_oCnt.lbl_4c_Label1
761:             .FontBold  = .F.
762:             .FontName  = "Tahoma"
763:             .FontSize  = 8
764:             .BackStyle = 0
765:             .Alignment = 0
766:             .AutoSize  = .F.
767:             .Caption   = "Nota"
768:             .Left      = 73
769:             .Top       = 3
770:             .Width     = 25

*-- Linhas 786 a 804:
786:             .Visible       = .T.
787:         ENDWITH
788:         IF loc_lTemCursorPai
789:             loc_oCnt.txt_4c_NumeroNota.ControlSource = "TprMvCab.NumeroNota"
790:         ENDIF
791:         BINDEVENT(loc_oCnt.txt_4c_NumeroNota, "When", THIS, "DocumentosWhen")
792: 
793:         *-- cnt_4c_Ecfs (legado: cntEcfs) ------------------------------------
794:         THIS.AddObject("cnt_4c_Ecfs", "Container")
795:         loc_oCnt = THIS.cnt_4c_Ecfs
796:         WITH loc_oCnt
797:             .Top         = 96
798:             .Left        = 240
799:             .Width       = 65
800:             .Height      = 45
801:             .BackStyle   = 0
802:             .BorderWidth = 0
803:             .Visible     = .T.
804:         ENDWITH

*-- Linhas 835 a 853:
835:             .Visible       = .T.
836:         ENDWITH
837:         IF loc_lTemCursorPai
838:             loc_oCnt.txt_4c_Ecfs.ControlSource = "TprMvCab.ecfs"
839:         ENDIF
840:         BINDEVENT(loc_oCnt.txt_4c_Ecfs, "When", THIS, "PadraoIncluirAlterarWhen")
841: 
842:         *-- cnt_4c_Nemps (legado: cntNemps) ----------------------------------
843:         THIS.AddObject("cnt_4c_Nemps", "Container")
844:         loc_oCnt = THIS.cnt_4c_Nemps
845:         WITH loc_oCnt
846:             .Top         = 96
847:             .Left        = 305
848:             .Width       = 156
849:             .Height      = 45
850:             .BackStyle   = 0
851:             .BorderWidth = 0
852:             .Visible     = .T.
853:         ENDWITH

*-- Linhas 883 a 901:
883:             .Visible       = .T.
884:         ENDWITH
885:         IF loc_lTemCursorPai
886:             loc_oCnt.txt_4c_Nemps.ControlSource = "TprMvCab.nemps"
887:         ENDIF
888:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "When",      THIS, "PadraoIncluirAlterarWhen")
889:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "LostFocus",  THIS, "NempsLostFocus")
890:     ENDPROC
891: 
892:     *==========================================================================
893:     * CodigosWhen - "Return .f." do legado (getCodigos.When): o campo
894:     * Codigo/MascNum e so exibicao, nunca editavel em nenhum modo.
895:     *
896:     * PUBLIC: alvo de BINDEVENT("When").
897:     *==========================================================================
898:     FUNCTION CodigosWhen()
899:         RETURN .F.
900:     ENDFUNC
901: 

*-- Linhas 936 a 973:
936: 
937:     *==========================================================================
938:     * NempsLostFocus - "If Not Empty(This.Value) / lnNoFabr = This.Value /
939:     * lcImpf = fDecriptografar(alltrim(lnNoFabr)) / lcWhere = [Select *
940:     * From SIGFIMPF Where cimpfabs = ?lcImpf ] / ... MessageBox / Return
941:     * .f." do legado (getNemps.Valid). fDecriptografar e o wrapper de
942:     * utils/fdecriptografar.prg (regra #27 - algoritmo original fora do
943:     * acervo, pass-through seguro). Equivalente ao "ao sair do campo" do
944:     * Valid legado - ver regra #47 (lookup/validacao de TextBox solto vai
945:     * em LostFocus, nao em KeyPress).
946:     *
947:     * PUBLIC: alvo de BINDEVENT("LostFocus").
948:     *==========================================================================
949:     PROCEDURE NempsLostFocus()
950:         LOCAL loc_oTxt, loc_cImpf, loc_cSQL, loc_nErro, loc_oErro
951: 
952:         loc_oTxt = THIS.cnt_4c_Nemps.txt_4c_Nemps
953: 
954:         IF !EMPTY(loc_oTxt.Value)
955:             TRY
956:                 loc_cImpf = fDecriptografar(ALLTRIM(loc_oTxt.Value))
957:                 loc_cSQL  = "SELECT * FROM SIGFIMPF WHERE cimpfabs = " + EscaparSQL(loc_cImpf)
958:                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiMpF")
959: 
960:                 IF loc_nErro < 1
961:                     MsgErro("Favor reinicializar o processo." + CHR(13) + ;
962:                         "Falha na Conex" + CHR(227) + "o (SIGFIMPF)", "Erro")
963:                 ELSE
964:                     IF RECCOUNT("cursor_4c_SigFiMpF") = 0
965:                         MsgAviso("Impressora Fiscal n" + CHR(227) + "o Cadastrada!!", ;
966:                             "Aten" + CHR(231) + CHR(227) + "o")
967:                     ENDIF
968:                     IF USED("cursor_4c_SigFiMpF")
969:                         USE IN cursor_4c_SigFiMpF
970:                     ENDIF
971:                 ENDIF
972:             CATCH TO loc_oErro
973:                 MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1030 a 1048:
1030:             .Visible       = .T.
1031:         ENDWITH
1032:         IF loc_lTemCursorPai
1033:             loc_oCnt.txt_4c_Emiss.ControlSource = "TprMvCab.dtemis"
1034:         ENDIF
1035:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "When",      THIS, "PadraoIncluirAlterarWhen")
1036:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "LostFocus",  THIS, "EmissLostFocus")
1037: 
1038:         *-- cnt_4c_Entregas (legado: cntEntregas) ----------------------------
1039:         THIS.AddObject("cnt_4c_Entregas", "Container")
1040:         loc_oCnt = THIS.cnt_4c_Entregas
1041:         WITH loc_oCnt
1042:             .Top         = 147
1043:             .Left        = 88
1044:             .Width       = 86
1045:             .Height      = 45
1046:             .BackStyle   = 0
1047:             .BorderWidth = 0
1048:             .Visible     = .T.

*-- Linhas 1077 a 1095:
1077:             .Visible       = .T.
1078:         ENDWITH
1079:         IF loc_lTemCursorPai
1080:             loc_oCnt.txt_4c_Entregas.ControlSource = "TprMvCab.prazoents"
1081:         ENDIF
1082:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "When",     THIS, "EntregasWhen")
1083:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "LostFocus", THIS, "EntregasLostFocus")
1084: 
1085:         *-- cnt_4c_Recepcaos (legado: cntRecepcaos) --------------------------
1086:         THIS.AddObject("cnt_4c_Recepcaos", "Container")
1087:         loc_oCnt = THIS.cnt_4c_Recepcaos
1088:         WITH loc_oCnt
1089:             .Top         = 147
1090:             .Left        = 174
1091:             .Width       = 86
1092:             .Height      = 45
1093:             .BackStyle   = 0
1094:             .BorderWidth = 0
1095:             .Visible     = .T.

*-- Linhas 1124 a 1142:
1124:             .Visible       = .T.
1125:         ENDWITH
1126:         IF loc_lTemCursorPai
1127:             loc_oCnt.txt_4c_Recepcaos.ControlSource = "TprMvCab.dtrecs"
1128:         ENDIF
1129:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "When",     THIS, "PadraoIncluirAlterarWhen")
1130:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "LostFocus", THIS, "RecepcaosLostFocus")
1131: 
1132:         *-- cnt_4c_PrzEnts (legado: cntPrzEnts) ------------------------------
1133:         THIS.AddObject("cnt_4c_PrzEnts", "Container")
1134:         loc_oCnt = THIS.cnt_4c_PrzEnts
1135:         WITH loc_oCnt
1136:             .Top         = 147
1137:             .Left        = 260
1138:             .Width       = 86
1139:             .Height      = 45
1140:             .BackStyle   = 0
1141:             .BorderWidth = 0
1142:             .Visible     = .T.

*-- Linhas 1171 a 1189:
1171:             .Visible       = .T.
1172:         ENDWITH
1173:         IF loc_lTemCursorPai
1174:             loc_oCnt.txt_4c_PrzEnts.ControlSource = "TprMvCab.PRZCLIS"
1175:         ENDIF
1176:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "When",     THIS, "PadraoIncluirAlterarWhen")
1177:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "LostFocus", THIS, "PrzEntsLostFocus")
1178:     ENDPROC
1179: 
1180:     *==========================================================================
1181:     * EntregasWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR')" do
1182:     * legado (getEntregas.When) - UNICO dos 4 campos de data desta fase que
1183:     * so libera em INSERIR (os outros liberam INSERIR E ALTERAR). Depois do
1184:     * registro incluido, Prz. Entrega so muda pelo cmdEntrega (Fase 4,
1185:     * CmdEntregaClick), que grava TprMvCab.PrazoEnts e espelha no campo.
1186:     *
1187:     * PUBLIC: alvo de BINDEVENT("When").
1188:     *==========================================================================
1189:     FUNCTION EntregasWhen()

*-- Linhas 1255 a 1273:
1255:     * ConfigurarVolumes - cntVolumes (cnt_4c_Volumes): "Transporte" - 5
1256:     * campos de peso/volume do movimento. Geometria do dump (layout.json/
1257:     * sigopinf_form_codigo_fonte.txt SECAO 2). Todos com Alignment = 3
1258:     * (automatico - numerico alinha a direita) e ControlSource direto em
1259:     * TprMvCab, como no legado.
1260:     *==========================================================================
1261:     PROTECTED PROCEDURE ConfigurarVolumes()
1262:         LOCAL loc_oCnt, loc_lTemCursorPai
1263:         loc_lTemCursorPai = USED("TprMvCab")
1264: 
1265:         THIS.AddObject("cnt_4c_Volumes", "Container")
1266:         loc_oCnt = THIS.cnt_4c_Volumes
1267:         WITH loc_oCnt
1268:             .Top         = 264
1269:             .Left        = 488
1270:             .Width       = 509
1271:             .Height      = 66
1272:             .BackStyle   = 0
1273:             .BorderWidth = 0

*-- Linhas 1322 a 1340:
1322:             .Visible       = .T.
1323:         ENDWITH
1324:         IF loc_lTemCursorPai
1325:             loc_oCnt.txt_4c_Qtds.ControlSource = "TprMvCab.Qtdes"
1326:         ENDIF
1327:         BINDEVENT(loc_oCnt.txt_4c_Qtds, "When", THIS, "VolumesWhen")
1328: 
1329:         loc_oCnt.AddObject("lbl_4c_LblEspes", "Label")
1330:         WITH loc_oCnt.lbl_4c_LblEspes
1331:             .FontName  = "Tahoma"
1332:             .FontSize  = 8
1333:             .BackStyle = 0
1334:             .Alignment = 0
1335:             .AutoSize  = .F.
1336:             .Caption   = "Esp" + CHR(233) + "cie"
1337:             .Left      = 57
1338:             .Top       = 23
1339:             .Width     = 85
1340:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1356 a 1374:
1356:             .Visible       = .T.
1357:         ENDWITH
1358:         IF loc_lTemCursorPai
1359:             loc_oCnt.txt_4c_Espes.ControlSource = "TprMvCab.Espes"
1360:         ENDIF
1361:         BINDEVENT(loc_oCnt.txt_4c_Espes, "When", THIS, "VolumesWhen")
1362: 
1363:         loc_oCnt.AddObject("lbl_4c_LblPLiqs", "Label")
1364:         WITH loc_oCnt.lbl_4c_LblPLiqs
1365:             .FontName  = "Tahoma"
1366:             .FontSize  = 8
1367:             .BackStyle = 0
1368:             .Alignment = 0
1369:             .AutoSize  = .F.
1370:             .Caption   = "Peso L" + CHR(237) + "quido"
1371:             .Left      = 147
1372:             .Top       = 23
1373:             .Width     = 75
1374:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1390 a 1408:
1390:             .Visible       = .T.
1391:         ENDWITH
1392:         IF loc_lTemCursorPai
1393:             loc_oCnt.txt_4c_PLiqs.ControlSource = "TprMvCab.PLiqs"
1394:         ENDIF
1395:         BINDEVENT(loc_oCnt.txt_4c_PLiqs, "When", THIS, "VolumesWhen")
1396: 
1397:         loc_oCnt.AddObject("lbl_4c_LblPBrus", "Label")
1398:         WITH loc_oCnt.lbl_4c_LblPBrus
1399:             .FontName  = "Tahoma"
1400:             .FontSize  = 8
1401:             .BackStyle = 0
1402:             .Alignment = 0
1403:             .AutoSize  = .F.
1404:             .Caption   = "Peso Bruto"
1405:             .Left      = 223
1406:             .Top       = 23
1407:             .Width     = 75
1408:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1424 a 1442:
1424:             .Visible       = .T.
1425:         ENDWITH
1426:         IF loc_lTemCursorPai
1427:             loc_oCnt.txt_4c_PBrus.ControlSource = "TprMvCab.PBrus"
1428:         ENDIF
1429:         BINDEVENT(loc_oCnt.txt_4c_PBrus, "When", THIS, "VolumesWhen")
1430: 
1431:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1432:         WITH loc_oCnt.lbl_4c_Label1
1433:             .FontName  = "Tahoma"
1434:             .FontSize  = 8
1435:             .BackStyle = 0
1436:             .Alignment = 0
1437:             .AutoSize  = .F.
1438:             .Caption   = "Valor Transporte"
1439:             .Left      = 299
1440:             .Top       = 23
1441:             .Width     = 100
1442:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1458 a 1476:
1458:             .Visible       = .T.
1459:         ENDWITH
1460:         IF loc_lTemCursorPai
1461:             loc_oCnt.txt_4c_ValTrans.ControlSource = "TprMvCab.ValTrans"
1462:         ENDIF
1463:         BINDEVENT(loc_oCnt.txt_4c_ValTrans, "When", THIS, "VolumesWhen")
1464:     ENDPROC
1465: 
1466:     *==========================================================================
1467:     * VolumesWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')"
1468:     * do legado, texto IDENTICO nos 5 campos de cntVolumes (getQtds/getEspes/
1469:     * getPLiqs/getPBrus/getValTrans.When). Mesmo texto de PadraoIncluirAlterarWhen,
1470:     * mas com nome proprio para documentar a origem (grep direto pelo nome do
1471:     * container na auditoria).
1472:     *
1473:     * PUBLIC: alvo de BINDEVENT("When").
1474:     *==========================================================================
1475:     FUNCTION VolumesWhen()
1476:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

*-- Linhas 1529 a 1566:
1529:             .Visible       = .T.
1530:         ENDWITH
1531:         IF loc_lTemCursorPai
1532:             loc_oCnt.txt_4c_CodObs.ControlSource = "TprMvCab.CodObs"
1533:         ENDIF
1534:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "GotFocus",  THIS, "CodObsGotFocus")
1535:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "LostFocus", THIS, "CodObsLostFocus")
1536:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "When",      THIS, "CodObsWhen")
1537: 
1538:         loc_oCnt.AddObject("obj_4c_GetDesObs", "EditBox")
1539:         WITH loc_oCnt.obj_4c_GetDesObs
1540:             .FontSize      = 8
1541:             .Left          = 3
1542:             .Top           = 46
1543:             .Width         = 453
1544:             .Height        = 254
1545:             .SpecialEffect = 1
1546:             .ForeColor     = RGB(0, 0, 0)
1547:             .BorderColor   = RGB(100, 100, 100)
1548:             .Visible       = .T.
1549:         ENDWITH
1550:         IF loc_lTemCursorPai
1551:             loc_oCnt.obj_4c_GetDesObs.ControlSource = "TprMvCab.obses"
1552:         ENDIF
1553:         BINDEVENT(loc_oCnt.obj_4c_GetDesObs, "When", THIS, "DesObsWhen")
1554: 
1555:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
1556:         WITH loc_oCnt.cmd_4c_BtnMultObs
1557:             .Top          = 20
1558:             .Left         = 135
1559:             .Width        = 24
1560:             .Height       = 24
1561:             .Caption      = ""
1562:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1563:             .ToolTipText  = "Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es"
1564:             .Themes       = .T.
1565:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1566:             .Visible      = .T.

*-- Linhas 1602 a 1620:
1602:     *
1603:     *   If Not Empty(This.Value) And Not (This.Tag = Str(This.Value, 10))
1604:     *       <monta faixa ObsIni/ObsFins de SigCdOpe/SigCdOop>
1605:     *       <Select Codigos, Descrs From SigCdObs Where Codigos Between ...>
1606:     *       Set Near On / If Not Seek(...) -> fwBuscaSel / Set Near Off
1607:     *       This.Value = crLocalObs.Codigos
1608:     *       ThisForm.MontaObs(...)
1609:     *   EndIf
1610:     *
1611:     * A faixa SigCdOop (override por CFOP, dependente de crSigMvNfi/
1612:     * crSigOpCdd) nao esta disponivel nesta tela ainda (cursores de fases
1613:     * seguintes) - falso seguro: a faixa fica so com o ObsIni/ObsFins de
1614:     * SigCdOpe. fwBuscaSel -> FormBuscaAuxiliar (padrao do projeto).
1615:     *
1616:     * PUBLIC: alvo de BINDEVENT("LostFocus").
1617:     *==========================================================================
1618:     PROCEDURE CodObsLostFocus()
1619:         LOCAL loc_oTxt, loc_nPIni, loc_nPFim, loc_cSQL, loc_nErro, ;
1620:               loc_oBusca, loc_oErro, loc_lAchou, loc_cValor

*-- Linhas 1634 a 1690:
1634:         loc_nPIni = 0
1635:         loc_nPFim = 999
1636:         IF USED("TprMvCab")
1637:             loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
1638:                 "WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
1639:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
1640: 
1641:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_LocalOpe") > 0
1642:                 loc_nPIni = IIF(!EMPTY(cursor_4c_LocalOpe.ObsInis), cursor_4c_LocalOpe.ObsInis, 0)
1643:                 loc_nPFim = IIF(!EMPTY(cursor_4c_LocalOpe.ObsFins), cursor_4c_LocalOpe.ObsFins, 999)
1644:             ENDIF
1645:             IF USED("cursor_4c_LocalOpe")
1646:                 USE IN cursor_4c_LocalOpe
1647:             ENDIF
1648:         ENDIF
1649: 
1650:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs WHERE Codigos BETWEEN " + ;
1651:             FormatarNumeroSQL(loc_nPIni, 0) + " AND " + FormatarNumeroSQL(loc_nPFim, 0)
1652:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalObs")
1653: 
1654:         IF loc_nErro < 1
1655:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1656:                 "Falha na conex" + CHR(227) + "o (cursor_4c_LocalObs)", "Erro")
1657:             RETURN
1658:         ENDIF
1659: 
1660:         loc_lAchou = .F.
1661:         IF USED("cursor_4c_LocalObs")
1662:             SELECT cursor_4c_LocalObs
1663:             LOCATE FOR Codigos = loc_oTxt.Value
1664:             loc_lAchou = FOUND()
1665:         ENDIF
1666: 
1667:         IF !loc_lAchou
1668:             loc_oBusca = .NULL.
1669:             TRY
1670:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1671:                     "SigCdObs", "cursor_4c_BuscaObs", "Codigos", ;
1672:                     TRANSFORM(loc_oTxt.Value), "Observa" + CHR(231) + CHR(245) + "es", ;
1673:                     .F., .F., ;
1674:                     "Codigos BETWEEN " + FormatarNumeroSQL(loc_nPIni, 0) + " AND " + ;
1675:                         FormatarNumeroSQL(loc_nPFim, 0))
1676:             CATCH TO loc_oErro
1677:                 MsgErro(loc_oErro.Message, "Erro ao abrir busca de observa" + CHR(231) + CHR(245) + "es")
1678:                 loc_oBusca = .NULL.
1679:             ENDTRY
1680: 
1681:             IF VARTYPE(loc_oBusca) = "O"
1682:                 IF !loc_oBusca.this_lAchouRegistro
1683:                     loc_oBusca.mAddColuna("Codigos", "999", "C" + CHR(243) + "d.")
1684:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1685:                     loc_oBusca.Show()
1686:                 ENDIF
1687: 
1688:                 IF loc_oBusca.this_lSelecionou
1689:                     loc_oTxt.Value = VAL(loc_oBusca.cCodigoSelecionado)
1690:                 ELSE

*-- Linhas 1725 a 1745:
1725:     PROTECTED PROCEDURE MontarObservacaoPadrao(par_nCodObs)
1726:         LOCAL loc_cSQL, loc_nErro, loc_cObs, loc_oTxtDesc
1727: 
1728:         loc_cSQL = "SELECT Codigos, Observas FROM SigCdObs WHERE Codigos = " + ;
1729:             FormatarNumeroSQL(par_nCodObs, 0)
1730:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdObs")
1731: 
1732:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SigCdObs") > 0
1733:             loc_cObs     = ALLTRIM(TratarNulo(cursor_4c_SigCdObs.Observas, "C"))
1734:             loc_oTxtDesc = THIS.cnt_4c_Observacao.obj_4c_GetDesObs
1735: 
1736:             IF "#" $ loc_cObs OR "$" $ loc_cObs OR "%" $ loc_cObs OR "!" $ loc_cObs
1737:                 THIS.AvisarLegadoNaoPortado("fMontaObs() / grade de itens (TmpOperacao)", ;
1738:                     "completar a observa" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o com os dados da grade")
1739:             ENDIF
1740: 
1741:             loc_oTxtDesc.Value = loc_cObs
1742:             loc_oTxtDesc.Refresh()
1743:         ENDIF
1744: 
1745:         IF USED("cursor_4c_SigCdObs")

*-- Linhas 1856 a 1874:
1856:             .Visible       = .T.
1857:         ENDWITH
1858:         IF loc_lTemCursorPai
1859:             loc_oCnt.txt_4c_Protocolos.ControlSource = "TprMvCab.protats"
1860:         ENDIF
1861:         BINDEVENT(loc_oCnt.txt_4c_Protocolos, "When", THIS, "PadraoIncluirAlterarWhen")
1862:     ENDPROC
1863: 
1864:     *==========================================================================
1865:     * ConfigurarEntrega - cntEntrega (cnt_4c_Entrega): conta/nome/cpf-cnpj
1866:     * do destinatario da entrega + botao "Local de Entrega". Os tres campos
1867:     * de conta sao intercambiaveis no legado (preencher um resolve os
1868:     * outros dois) - ver ContasLostFocus/DContaLostFocus/CpfsLostFocus.
1869:     *==========================================================================
1870:     PROTECTED PROCEDURE ConfigurarEntrega()
1871:         LOCAL loc_oCnt, loc_lTemCursorPai
1872:         loc_lTemCursorPai = USED("TprMvCab")
1873: 
1874:         THIS.AddObject("cnt_4c_Entrega", "Container")

*-- Linhas 1960 a 1978:
1960:             .Visible       = .T.
1961:         ENDWITH
1962:         IF loc_lTemCursorPai
1963:             loc_oCnt.txt_4c_Contas.ControlSource = "TprMvCab.contaes"
1964:         ENDIF
1965:         BINDEVENT(loc_oCnt.txt_4c_Contas, "LostFocus", THIS, "ContasLostFocus")
1966:         BINDEVENT(loc_oCnt.txt_4c_Contas, "When",      THIS, "PadraoIncluirAlterarWhen")
1967: 
1968:         loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
1969:         WITH loc_oCnt.txt_4c_Cpfs
1970:             .Left          = 77
1971:             .Top           = 40
1972:             .Width         = 131
1973:             .Height        = 23
1974:             .Margin        = 0
1975:             .SpecialEffect = 1
1976:             .ForeColor     = RGB(0, 0, 0)
1977:             .BorderColor   = RGB(100, 100, 100)
1978:             .Visible       = .T.

*-- Linhas 2126 a 2146:
2126:         LOCAL loc_cSQL, loc_nErro, loc_lAchou
2127:         loc_lAchou = .F.
2128: 
2129:         loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs, Situas FROM SigCdCli WHERE " + ;
2130:             par_cCampo + " = " + EscaparSQL(par_cValor)
2131:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaEntrega")
2132: 
2133:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_BuscaContaEntrega") > 0
2134:             IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
2135:                 THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
2136:                     ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
2137:             ELSE
2138:                 THIS.LimparContaEntrega()
2139:             ENDIF
2140:             loc_lAchou = .T.
2141:         ENDIF
2142: 
2143:         IF USED("cursor_4c_BuscaContaEntrega")
2144:             USE IN cursor_4c_BuscaContaEntrega
2145:         ENDIF
2146: 

*-- Linhas 2212 a 2232:
2212:             loc_cSituas = ALLTRIM(TratarNulo(EVALUATE(par_cCursor + ".Situas"), "C"))
2213: 
2214:             IF !EMPTY(loc_cSituas)
2215:                 loc_cSQL = "SELECT Codigos, Descrs, Descr2s, DispMovs, BlqMovs, BlqDescs FROM SigCdCst " + ;
2216:                     "WHERE Codigos = " + EscaparSQL(loc_cSituas)
2217:                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SituacaoConta")
2218: 
2219:                 IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SituacaoConta") > 0
2220:                     IF cursor_4c_SituacaoConta.DispMovs = 1
2221:                         loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
2222:                             cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
2223:                         MsgAviso(loc_cSituas + " - " + loc_cMsg, "Situa" + CHR(231) + CHR(227) + "o")
2224: 
2225:                         IF cursor_4c_SituacaoConta.BlqMovs = 1
2226:                             MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o Bloqueada pela Situa" + CHR(231) + CHR(227) + "o da Conta...", ;
2227:                                 "Aten" + CHR(231) + CHR(227) + "o")
2228:                             loc_lAceita = .F.
2229:                         ENDIF
2230:                     ENDIF
2231: 
2232:                     IF loc_lAceita AND USED("TprMvCab") AND TprMvCab.ValVars < 0 AND cursor_4c_SituacaoConta.BlqDescs = 1

*-- Linhas 2329 a 2349:
2329:             RETURN
2330:         ENDIF
2331: 
2332:         loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2333:             EscaparSQL(ALLTRIM(TprMvCab.ContaEs))
2334:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DCompCli")
2335: 
2336:         IF loc_nErro < 1 OR RECCOUNT("cursor_4c_DCompCli") = 0
2337:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2338:                 "Falha na conex" + CHR(227) + "o (SigCdCli)", "Erro")
2339:         ELSE
2340:             loc_cGrupos = ALLTRIM(cursor_4c_DCompCli.Grupos)
2341:             loc_cIClis  = ALLTRIM(cursor_4c_DCompCli.IClis)
2342:             loc_cRClis  = ALLTRIM(cursor_4c_DCompCli.RClis)
2343: 
2344:             TRY
2345:                 loc_oDlg = CREATEOBJECT("FormSigCdEnd", loc_cGrupos, loc_cIClis, loc_cRClis, ;
2346:                     THIS.this_cPcEscolha, TprMvCab.LocalEnts)
2347:                 IF VARTYPE(loc_oDlg) = "O"
2348:                     loc_oDlg.Show()
2349:                 ENDIF

*-- Linhas 2410 a 2428:
2410:             .Visible       = .T.
2411:         ENDWITH
2412:         IF loc_lTemCursorPai
2413:             loc_oCnt.txt_4c_Pedido.ControlSource = "TprMvCab.nPedClis"
2414:         ENDIF
2415:         BINDEVENT(loc_oCnt.txt_4c_Pedido, "When", THIS, "PedidoWhen")
2416:     ENDPROC
2417: 
2418:     *==========================================================================
2419:     * PedidoWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
2420:     * And Not (crSigCdOpe.PedClis = 5)" do legado (getPedido.When). Sem
2421:     * crSigCdOpe (fases seguintes), falso seguro - mesmo criterio de
2422:     * DocumentosWhen (bloqueia at? o dado confirmar que pode liberar).
2423:     *
2424:     * PUBLIC: alvo de BINDEVENT("When").
2425:     *==========================================================================
2426:     FUNCTION PedidoWhen()
2427:         LOCAL loc_lPermite
2428:         loc_lPermite = .F.

*-- Linhas 2550 a 2568:
2550:             .Visible       = .T.
2551:         ENDWITH
2552:         IF loc_lTemCursorPai
2553:             loc_oCnt.txt_4c_NLivDg.ControlSource = "TprMvCab.NLivDg"
2554:         ENDIF
2555:         BINDEVENT(loc_oCnt.txt_4c_NLivDg, "When", THIS, "PadraoIncluirAlterarWhen")
2556:     ENDPROC
2557: 
2558:     *==========================================================================
2559:     * AtualizarVisibilidadeCmdEntrega - "ThisForm.cmdEntrega.Visible =
2560:     * InList(crSigCdOpe.DtEntrs,1,4,6) And Not InList(ThisForm.pcEscolha,
2561:     * 'INSERIR','EXCLUIR')" do Init legado (linha 2100). crSigCdOpe e
2562:     * carregado pelo CursorQuery do Init legado, ainda nao portado (fases
2563:     * seguintes) - sem o cursor, o botao fica oculto (falso seguro); quem
2564:     * popular crSigCdOpe numa fase posterior deve chamar este metodo de
2565:     * novo para o botao assumir o estado real.
2566:     *
2567:     * PUBLIC: reutilizavel por fases/metodos futuros que alterem
2568:     * this_cPcEscolha ou recarreguem crSigCdOpe.

*-- Linhas 2703 a 2742:
2703:         IF USED("crSigCdOpe")
2704:             USE IN crSigCdOpe
2705:         ENDIF
2706:         loc_cSQL  = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2707:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe")
2708:         IF loc_nErro < 1
2709:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2710:                 "Falha na conex" + CHR(227) + "o (SigCdOpe)", "Erro")
2711:         ENDIF
2712: 
2713:         IF USED("CrSigOpCdc")
2714:             USE IN CrSigOpCdc
2715:         ENDIF
2716:         loc_cSQL  = "SELECT * FROM SigOpCdc WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2717:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdc")
2718:         IF loc_nErro < 1
2719:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2720:                 "Falha na conex" + CHR(227) + "o (SigOpCdc)", "Erro")
2721:         ENDIF
2722: 
2723:         IF USED("CrSigOpCdd")
2724:             USE IN CrSigOpCdd
2725:         ENDIF
2726:         loc_cSQL  = "SELECT * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2727:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdd")
2728:         IF loc_nErro < 1
2729:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2730:                 "Falha na conex" + CHR(227) + "o (SigOpCdd)", "Erro")
2731:         ENDIF
2732:     ENDPROC
2733: 
2734:     *==========================================================================
2735:     * CarregarPrazoEntregaPadrao - "PROCEDURE carregaprzent" do legado:
2736:     * sugere data de entrega padrao QUANDO o campo ainda esta vazio ou
2737:     * ainda e hoje - nunca sobrescreve um prazo que o usuario ja moveu.
2738:     *
2739:     *   If (InList(crSigCdOpe.DtEntrs,1,4,6) And InList(pcEscolha,
2740:     *      'INSERIR','ALTERAR') And (IsEmpty(PrazoEnts) Or
2741:     *      Dtos(PrazoEnts)=Dtos(Date())))
2742:     *       lcCta = Iif(crSigCdOpe.COpers=1, ContaDs, ContaOs)

*-- Linhas 2778 a 2797:
2778:         ENDIF
2779: 
2780:         IF !EMPTY(loc_cConta)
2781:             loc_cSQL  = "SELECT PrazoEnts FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
2782:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrazoCliente")
2783: 
2784:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_PrazoCliente") > 0 ;
2785:                AND cursor_4c_PrazoCliente.PrazoEnts > 0
2786:                 loc_dPrazo = loc_dPrazo + cursor_4c_PrazoCliente.PrazoEnts
2787:                 REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
2788:             ENDIF
2789: 
2790:             IF USED("cursor_4c_PrazoCliente")
2791:                 USE IN cursor_4c_PrazoCliente
2792:             ENDIF
2793:         ENDIF
2794:     ENDPROC
2795: 
2796:     *==========================================================================
2797:     * AtualizarVisibilidadePorOperacao - o corpo do Init legado que liga

*-- Linhas 3068 a 3086:
3068:     *        cupom fiscal-ECF / EditDocs=4]
3069:     *   Else
3070:     *       If fChecaAcesso(..., 'ALTINFO') And pcEscolha = 'CONSULTAR'
3071:     *           Update SigMvCab Set obses = ... Where CidChaves = ...
3072:     *       Endif
3073:     *   Endif
3074:     *   ThisForm.Return
3075:     *
3076:     * Cada "Return"/"Return .f." do legado (saida ANTECIPADA, sem gravar) e
3077:     * um RETURN bare deste metodo - so o CAMINHO FELIZ (fim de qualquer dos
3078:     * dois ramos) chama THIS.FecharDialogo(), equivalente ao "ThisForm.
3079:     * Return" final do legado.
3080:     *
3081:     * Guard de topo: sem TprMvCab/crSigCdOpe (cursores do form pai/Init
3082:     * legado) nao ha o que validar nem gravar - mesmo "falso seguro" das
3083:     * Fases 5-7 (CarregarPrazoEntregaPadrao, AtualizarVisibilidadePorOperacao).
3084:     *
3085:     * PUBLIC: alvo de BINDEVENT("Click") em ConfigurarBotoesAcao (Fase 4).
3086:     *==========================================================================

*-- Linhas 3294 a 3429:
3294:     * RecalcularVencimentosParcelas - laco de recalculo de vencimentos do
3295:     * btnSelItens.Click legado (disparado quando o Prazo de Entrega muda):
3296:     *
3297:     *   Select xPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3298:     *       =CursorQuery('SigOpFp','LocalFpag','fpags',xPar.Fpags,
3299:     *           [TpVencs,Entradas,Dias,tVens])
3300:     *       If LocalFpag.TpVencs = 2
3301:     *           DVenc = (Ttod(TprMvCab.PrazoEnts) + LocalFpag.Entradas)
3302:     *           Scan While Fpags=_lcFpg And cnIdTefs=_lcIdT
3303:     *               [laco de feriados] / Replace Vencs With DVenc
3304:     *               DVenc = Iif(TVen='F', GoMonth(DVenc,1), DVenc+NDia)
3305:     *           EndScan
3306:     *           Skip -1
3307:     *       Endif
3308:     *   EndScan
3309:     *
3310:     * par_cCursor: alias do cursor de parcelas a recalcular, agrupado por
3311:     * Fpags+CnIdTefs (colunas Fpags/CnIdTefs/Parcs/Vencs/CidChaves). "xPar"
3312:     * (parcelas do lancamento corrente, BtnSalvarClick) e "LocalPar"
3313:     * (parcelas de SigMvPar no lancamento direto, ProcessarLancamentoDireto)
3314:     * usam este MESMO metodo - layout de colunas identico, so a origem
3315:     * difere. Falso seguro: sem o cursor (par_cCursor), nao ha o que
3316:     * recalcular.
3317:     *
3318:     * par_lAtualizarBanco = .T. (LocalPar) tambem grava o vencimento no SQL
3319:     * Server ("Update SigMvPar Set Vencs = ... Where CidChaves = ..."),
3320:     * como o legado faz nesse caminho; .F. (xPar) e so cursor em memoria do
3321:     * form pai, igual ao legado.
3322:     *
3323:     * Feriados: AvancarAlemDosFeriados()/CarregarFeriados() reproduzem o
3324:     * MESMO padrao e a MESMA razao de FormSigOpFpg (decisao documentada
3325:     * la: SEEK string-sobre-data do legado nao e reproduzivel ao vivo,
3326:     * reescrito preservando a condicao de parada original).
3327:     *
3328:     * PROTECTED: chamado so por BtnSalvarClick() e ProcessarLancamentoDireto().
3329:     *==========================================================================
3330:     PROTECTED PROCEDURE RecalcularVencimentosParcelas(par_cCursor, par_lAtualizarBanco)
3331:         LOCAL loc_dVenc, loc_nDias, loc_cTipoVenc, loc_cFpgAtual, loc_cIdTefAtual
3332:         LOCAL loc_cSQLFpg, loc_nErro, loc_cSQLUpdate, loc_cCidChave
3333: 
3334:         IF !USED(par_cCursor) OR !USED("TprMvCab") OR EMPTY(TprMvCab.PrazoEnts)
3335:             RETURN
3336:         ENDIF
3337: 
3338:         SELECT (par_cCursor)
3339:         INDEX ON Fpags + CnIdTefs + STR(Parcs, 2) TAG FpagV
3340:         SCAN
3341:             loc_cFpgAtual = Fpags
3342: 
3343:             IF USED("cursor_4c_FpgVenc")
3344:                 USE IN cursor_4c_FpgVenc
3345:             ENDIF
3346:             loc_cSQLFpg = "SELECT TpVencs, Entradas, Dias, tVens FROM SigOpFp " + ;
3347:                 "WHERE Fpags = " + EscaparSQL(loc_cFpgAtual)
3348:             loc_nErro   = SQLEXEC(gnConnHandle, loc_cSQLFpg, "cursor_4c_FpgVenc")
3349:             SELECT (par_cCursor)
3350: 
3351:             IF loc_nErro >= 1 AND USED("cursor_4c_FpgVenc") AND cursor_4c_FpgVenc.TpVencs = 2
3352:                 loc_dVenc       = ConverterParaData(TprMvCab.PrazoEnts) + cursor_4c_FpgVenc.Entradas
3353:                 loc_nDias       = cursor_4c_FpgVenc.Dias
3354:                 loc_cTipoVenc   = cursor_4c_FpgVenc.tVens
3355:                 loc_cFpgAtual   = Fpags
3356:                 loc_cIdTefAtual = CnIdTefs
3357: 
3358:                 SCAN WHILE Fpags = loc_cFpgAtual AND CnIdTefs = loc_cIdTefAtual
3359:                     loc_dVenc = THIS.AvancarAlemDosFeriados(loc_dVenc)
3360:                     REPLACE Vencs WITH loc_dVenc IN (par_cCursor)
3361: 
3362:                     IF par_lAtualizarBanco
3363:                         loc_cCidChave  = CidChaves
3364:                         loc_cSQLUpdate = "UPDATE SigMvPar SET Vencs = " + ;
3365:                             FormatarDataSQL(loc_dVenc) + " WHERE CidChaves = " + ;
3366:                             EscaparSQL(loc_cCidChave)
3367:                         IF SQLEXEC(gnConnHandle, loc_cSQLUpdate) < 1
3368:                             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3369:                                 "Falha na conex" + CHR(227) + "o (Update SigMvPar)", "Erro")
3370:                         ENDIF
3371:                     ENDIF
3372: 
3373:                     loc_dVenc = IIF(loc_cTipoVenc = "F", GOMONTH(loc_dVenc, 1), loc_dVenc + loc_nDias)
3374:                 ENDSCAN
3375:                 SKIP -1
3376:             ENDIF
3377:         ENDSCAN
3378: 
3379:         IF USED("cursor_4c_FpgVenc")
3380:             USE IN cursor_4c_FpgVenc
3381:         ENDIF
3382:     ENDPROC
3383: 
3384:     *==========================================================================
3385:     * CarregarFeriados - Le SigCdFer uma unica vez para this_cFeriadosCache
3386:     * ("|AAAAMMDD|..."), mesmo padrao de FormSigOpFpg.CarregarFeriados -
3387:     * evita um SELECT por parcela dentro do laco de recalculo.
3388:     *==========================================================================
3389:     PROTECTED PROCEDURE CarregarFeriados()
3390:         LOCAL loc_cSQL, loc_nResultado, loc_cLista, loc_oErro
3391: 
3392:         IF THIS.this_lFeriadosCarregados
3393:             RETURN .T.
3394:         ENDIF
3395: 
3396:         loc_cLista = "|"
3397: 
3398:         TRY
3399:             IF USED("cursor_4c_FerLoad")
3400:                 USE IN SELECT("cursor_4c_FerLoad")
3401:             ENDIF
3402: 
3403:             loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer"
3404: 
3405:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")
3406: 
3407:             IF loc_nResultado > 0 AND USED("cursor_4c_FerLoad")
3408:                 SELECT cursor_4c_FerLoad
3409:                 SCAN
3410:                     IF !ISNULL(datas) AND !EMPTY(datas)
3411:                         loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
3412:                     ENDIF
3413:                 ENDSCAN
3414:                 USE IN SELECT("cursor_4c_FerLoad")
3415:             ENDIF
3416: 
3417:             THIS.this_cFeriadosCache      = loc_cLista
3418:             THIS.this_lFeriadosCarregados = .T.
3419:         CATCH TO loc_oErro
3420:             THIS.this_cFeriadosCache = "|"
3421:         ENDTRY
3422: 
3423:         RETURN .T.
3424:     ENDPROC
3425: 
3426:     *==========================================================================
3427:     * AvancarAlemDosFeriados - laco de feriados do btnSelItens.Click legado:
3428:     *
3429:     *   lnFer = 0 / Verd = .t.

*-- Linhas 3512 a 3571:
3512:     * ProcessarLancamentoDireto - ramo "If ThisForm.Direta" do "PROCEDURE
3513:     * return" legado:
3514:     *
3515:     *   Select CrSigMvCab / Zap / Select TprMvCab / Scatter Memvar memo /
3516:     *   Select CrSigMvCab / Append Blank / Gather Memvar Memo
3517:     *   lcSql = Select a.*, b.TpVencs,b.Entradas,b.dias,b.tVens From SigMvPar a,
3518:     *       SigOpFp b where a.EmpDopNums = <TprMvCab.EmpDopNums> And a.Fpags = b.fpags
3519:     *   Select LocalPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3520:     *       [recalculo de vencimentos + Update SigMvPar - ver
3521:     *        RecalcularVencimentosParcelas]
3522:     *   EndScan
3523:     *   llOk = UpDate('CrSigMvCab') And Commit() > 0 / If !llOk -> RollBack()
3524:     *   Select TprMvCab / Zap
3525:     *
3526:     * CrSigMvCab (cursor de BATCH do lancamento direto) e o commit em lote
3527:     * (ThisForm.ParentForm.PoDataMgr.UpDate/Commit/RollBack) pertencem ao
3528:     * form PAI/orquestrador da operacao, inexistente nesta migracao (nenhum
3529:     * caller de Formsigopinf no acervo - ver cabecalho do arquivo). Falso
3530:     * seguro: sem CrSigMvCab, o bloco INTEIRO fica de fora - inclusive o
3531:     * recalculo de SigMvPar (que so faz sentido acoplado ao commit em lote)
3532:     * e o "Select TprMvCab / Zap" final, que SEM o lote persistido em outro
3533:     * lugar destruiria os dados do usuario (regra CLAUDE.md #17 - nao
3534:     * reproduzir so a metade de uma formula/fluxo que depende do resto).
3535:     *
3536:     * PROTECTED: so FecharDialogo(), desta mesma classe, chama.
3537:     *==========================================================================
3538:     PROTECTED PROCEDURE ProcessarLancamentoDireto()
3539:         LOCAL loc_cSQL, loc_nErro
3540: 
3541:         IF !THIS.this_lDireta OR !USED("CrSigMvCab") OR !USED("TprMvCab")
3542:             RETURN
3543:         ENDIF
3544: 
3545:         IF EMPTY(TprMvCab.EmpDopNums)
3546:             RETURN
3547:         ENDIF
3548: 
3549:         IF USED("LocalPar")
3550:             USE IN LocalPar
3551:         ENDIF
3552:         loc_cSQL = "SELECT a.*, b.TpVencs, b.Entradas, b.Dias, b.tVens " + ;
3553:             "FROM SigMvPar a, SigOpFp b " + ;
3554:             "WHERE a.EmpDopNums = " + EscaparSQL(TprMvCab.EmpDopNums) + " " + ;
3555:             "AND a.Fpags = b.Fpags"
3556:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "LocalPar")
3557:         IF loc_nErro < 1
3558:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3559:                 "Falha na conex" + CHR(227) + "o ( LocalPar )", "Erro")
3560:             RETURN
3561:         ENDIF
3562: 
3563:         THIS.RecalcularVencimentosParcelas("LocalPar", .T.)
3564: 
3565:         IF USED("LocalPar")
3566:             USE IN LocalPar
3567:         ENDIF
3568: 
3569:         *-- Commit em lote (CrSigMvCab) fora do escopo desta migracao - ver
3570:         *-- comentario de cabecalho do metodo.
3571:     ENDPROC


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

