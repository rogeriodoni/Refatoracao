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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopinf.prg) - TRECHOS RELEVANTES PARA PASS SQL (3513 linhas total):

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
284:     *==========================================================================
285:     * Init - Recebe os 4 parametros do form pai e delega a FormBase.Init()
286:     *
287:     * A ordem posicional e IDENTICA ao Lparameters do legado
288:     *   (pForm, pData, plAltDireta, plAutomatico)
289:     * para que a chamada da tela de movimentacao
290:     *   CREATEOBJECT("Formsigopinf", THIS, <sessao>, <direta>, <automatico>)
291:     * seja transcricao direta do "Do Form SIGOPINF With ..." legado.
292:     *

*-- Linhas 630 a 652:
630:     * (nao e o default inferido da regra #12 - aqui o legado DECLARA esse
631:     * valor, entao e so transcricao).
632:     *
633:     * Todos os TextBox tem ControlSource = "TprMvCab.<col>" - igual ao
634:     * legado, estes controles escrevem direto no cursor de trabalho do
635:     * form pai. Sem TprMvCab aberto (harness/probe headless), a atribuicao
636:     * de ControlSource e pulada (regra: Alias inexistente estoura ao
637:     * atribuir ControlSource, nao so ao exibir) e os campos ficam sem
638:     * binding, inofensivo fora do fluxo real.
639:     *==========================================================================
640:     PROTECTED PROCEDURE ConfigurarCamposDocumentos()
641:         LOCAL loc_oCnt, loc_lTemCursorPai
642:         loc_lTemCursorPai = USED("TprMvCab")
643: 
644:         *-- cnt_4c_Codigos (legado: cntCodigos) -----------------------------
645:         THIS.AddObject("cnt_4c_Codigos", "Container")
646:         loc_oCnt = THIS.cnt_4c_Codigos
647:         WITH loc_oCnt
648:             .Top         = 96
649:             .Left        = 2
650:             .Width       = 67
651:             .Height      = 45
652:             .BackStyle   = 0

*-- Linhas 684 a 702:
684:             .Visible       = .T.
685:         ENDWITH
686:         IF loc_lTemCursorPai
687:             loc_oCnt.txt_4c_Codigos.ControlSource = "TprMvCab.mascnum"
688:         ENDIF
689:         BINDEVENT(loc_oCnt.txt_4c_Codigos, "When", THIS, "CodigosWhen")
690: 
691:         *-- cnt_4c_Documentos (legado: cntDocumentos) -----------------------
692:         THIS.AddObject("cnt_4c_Documentos", "Container")
693:         loc_oCnt = THIS.cnt_4c_Documentos
694:         WITH loc_oCnt
695:             .Top         = 96
696:             .Left        = 69
697:             .Width       = 170
698:             .Height      = 45
699:             .BackStyle   = 0
700:             .BorderWidth = 0
701:             .Visible     = .T.
702:         ENDWITH

*-- Linhas 730 a 748:
730:             .Visible       = .T.
731:         ENDWITH
732:         IF loc_lTemCursorPai
733:             loc_oCnt.txt_4c_Documentos.ControlSource = "TprMvCab.notas"
734:         ENDIF
735:         BINDEVENT(loc_oCnt.txt_4c_Documentos, "When", THIS, "DocumentosWhen")
736: 
737:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
738:         WITH loc_oCnt.lbl_4c_Label1
739:             .FontBold  = .F.
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .BackStyle = 0
743:             .Alignment = 0
744:             .AutoSize  = .F.
745:             .Caption   = "Nota"
746:             .Left      = 73
747:             .Top       = 3
748:             .Width     = 25

*-- Linhas 764 a 782:
764:             .Visible       = .T.
765:         ENDWITH
766:         IF loc_lTemCursorPai
767:             loc_oCnt.txt_4c_NumeroNota.ControlSource = "TprMvCab.NumeroNota"
768:         ENDIF
769:         BINDEVENT(loc_oCnt.txt_4c_NumeroNota, "When", THIS, "DocumentosWhen")
770: 
771:         *-- cnt_4c_Ecfs (legado: cntEcfs) ------------------------------------
772:         THIS.AddObject("cnt_4c_Ecfs", "Container")
773:         loc_oCnt = THIS.cnt_4c_Ecfs
774:         WITH loc_oCnt
775:             .Top         = 96
776:             .Left        = 240
777:             .Width       = 65
778:             .Height      = 45
779:             .BackStyle   = 0
780:             .BorderWidth = 0
781:             .Visible     = .T.
782:         ENDWITH

*-- Linhas 813 a 831:
813:             .Visible       = .T.
814:         ENDWITH
815:         IF loc_lTemCursorPai
816:             loc_oCnt.txt_4c_Ecfs.ControlSource = "TprMvCab.ecfs"
817:         ENDIF
818:         BINDEVENT(loc_oCnt.txt_4c_Ecfs, "When", THIS, "PadraoIncluirAlterarWhen")
819: 
820:         *-- cnt_4c_Nemps (legado: cntNemps) ----------------------------------
821:         THIS.AddObject("cnt_4c_Nemps", "Container")
822:         loc_oCnt = THIS.cnt_4c_Nemps
823:         WITH loc_oCnt
824:             .Top         = 96
825:             .Left        = 305
826:             .Width       = 156
827:             .Height      = 45
828:             .BackStyle   = 0
829:             .BorderWidth = 0
830:             .Visible     = .T.
831:         ENDWITH

*-- Linhas 861 a 879:
861:             .Visible       = .T.
862:         ENDWITH
863:         IF loc_lTemCursorPai
864:             loc_oCnt.txt_4c_Nemps.ControlSource = "TprMvCab.nemps"
865:         ENDIF
866:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "When",      THIS, "PadraoIncluirAlterarWhen")
867:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "LostFocus",  THIS, "NempsLostFocus")
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * CodigosWhen - "Return .f." do legado (getCodigos.When): o campo
872:     * Codigo/MascNum e so exibicao, nunca editavel em nenhum modo.
873:     *
874:     * PUBLIC: alvo de BINDEVENT("When").
875:     *==========================================================================
876:     FUNCTION CodigosWhen()
877:         RETURN .F.
878:     ENDFUNC
879: 

*-- Linhas 914 a 951:
914: 
915:     *==========================================================================
916:     * NempsLostFocus - "If Not Empty(This.Value) / lnNoFabr = This.Value /
917:     * lcImpf = fDecriptografar(alltrim(lnNoFabr)) / lcWhere = [Select *
918:     * From SIGFIMPF Where cimpfabs = ?lcImpf ] / ... MessageBox / Return
919:     * .f." do legado (getNemps.Valid). fDecriptografar e o wrapper de
920:     * utils/fdecriptografar.prg (regra #27 - algoritmo original fora do
921:     * acervo, pass-through seguro). Equivalente ao "ao sair do campo" do
922:     * Valid legado - ver regra #47 (lookup/validacao de TextBox solto vai
923:     * em LostFocus, nao em KeyPress).
924:     *
925:     * PUBLIC: alvo de BINDEVENT("LostFocus").
926:     *==========================================================================
927:     PROCEDURE NempsLostFocus()
928:         LOCAL loc_oTxt, loc_cImpf, loc_cSQL, loc_nErro, loc_oErro
929: 
930:         loc_oTxt = THIS.cnt_4c_Nemps.txt_4c_Nemps
931: 
932:         IF !EMPTY(loc_oTxt.Value)
933:             TRY
934:                 loc_cImpf = fDecriptografar(ALLTRIM(loc_oTxt.Value))
935:                 loc_cSQL  = "SELECT * FROM SIGFIMPF WHERE cimpfabs = " + EscaparSQL(loc_cImpf)
936:                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiMpF")
937: 
938:                 IF loc_nErro < 1
939:                     MsgErro("Favor reinicializar o processo." + CHR(13) + ;
940:                         "Falha na Conex" + CHR(227) + "o (SIGFIMPF)", "Erro")
941:                 ELSE
942:                     IF RECCOUNT("cursor_4c_SigFiMpF") = 0
943:                         MsgAviso("Impressora Fiscal n" + CHR(227) + "o Cadastrada!!", ;
944:                             "Aten" + CHR(231) + CHR(227) + "o")
945:                     ENDIF
946:                     IF USED("cursor_4c_SigFiMpF")
947:                         USE IN cursor_4c_SigFiMpF
948:                     ENDIF
949:                 ENDIF
950:             CATCH TO loc_oErro
951:                 MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1008 a 1026:
1008:             .Visible       = .T.
1009:         ENDWITH
1010:         IF loc_lTemCursorPai
1011:             loc_oCnt.txt_4c_Emiss.ControlSource = "TprMvCab.dtemis"
1012:         ENDIF
1013:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "When",      THIS, "PadraoIncluirAlterarWhen")
1014:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "LostFocus",  THIS, "EmissLostFocus")
1015: 
1016:         *-- cnt_4c_Entregas (legado: cntEntregas) ----------------------------
1017:         THIS.AddObject("cnt_4c_Entregas", "Container")
1018:         loc_oCnt = THIS.cnt_4c_Entregas
1019:         WITH loc_oCnt
1020:             .Top         = 147
1021:             .Left        = 88
1022:             .Width       = 86
1023:             .Height      = 45
1024:             .BackStyle   = 0
1025:             .BorderWidth = 0
1026:             .Visible     = .T.

*-- Linhas 1055 a 1073:
1055:             .Visible       = .T.
1056:         ENDWITH
1057:         IF loc_lTemCursorPai
1058:             loc_oCnt.txt_4c_Entregas.ControlSource = "TprMvCab.prazoents"
1059:         ENDIF
1060:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "When",     THIS, "EntregasWhen")
1061:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "LostFocus", THIS, "EntregasLostFocus")
1062: 
1063:         *-- cnt_4c_Recepcaos (legado: cntRecepcaos) --------------------------
1064:         THIS.AddObject("cnt_4c_Recepcaos", "Container")
1065:         loc_oCnt = THIS.cnt_4c_Recepcaos
1066:         WITH loc_oCnt
1067:             .Top         = 147
1068:             .Left        = 174
1069:             .Width       = 86
1070:             .Height      = 45
1071:             .BackStyle   = 0
1072:             .BorderWidth = 0
1073:             .Visible     = .T.

*-- Linhas 1102 a 1120:
1102:             .Visible       = .T.
1103:         ENDWITH
1104:         IF loc_lTemCursorPai
1105:             loc_oCnt.txt_4c_Recepcaos.ControlSource = "TprMvCab.dtrecs"
1106:         ENDIF
1107:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "When",     THIS, "PadraoIncluirAlterarWhen")
1108:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "LostFocus", THIS, "RecepcaosLostFocus")
1109: 
1110:         *-- cnt_4c_PrzEnts (legado: cntPrzEnts) ------------------------------
1111:         THIS.AddObject("cnt_4c_PrzEnts", "Container")
1112:         loc_oCnt = THIS.cnt_4c_PrzEnts
1113:         WITH loc_oCnt
1114:             .Top         = 147
1115:             .Left        = 260
1116:             .Width       = 86
1117:             .Height      = 45
1118:             .BackStyle   = 0
1119:             .BorderWidth = 0
1120:             .Visible     = .T.

*-- Linhas 1149 a 1167:
1149:             .Visible       = .T.
1150:         ENDWITH
1151:         IF loc_lTemCursorPai
1152:             loc_oCnt.txt_4c_PrzEnts.ControlSource = "TprMvCab.PRZCLIS"
1153:         ENDIF
1154:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "When",     THIS, "PadraoIncluirAlterarWhen")
1155:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "LostFocus", THIS, "PrzEntsLostFocus")
1156:     ENDPROC
1157: 
1158:     *==========================================================================
1159:     * EntregasWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR')" do
1160:     * legado (getEntregas.When) - UNICO dos 4 campos de data desta fase que
1161:     * so libera em INSERIR (os outros liberam INSERIR E ALTERAR). Depois do
1162:     * registro incluido, Prz. Entrega so muda pelo cmdEntrega (Fase 4,
1163:     * CmdEntregaClick), que grava TprMvCab.PrazoEnts e espelha no campo.
1164:     *
1165:     * PUBLIC: alvo de BINDEVENT("When").
1166:     *==========================================================================
1167:     FUNCTION EntregasWhen()

*-- Linhas 1233 a 1251:
1233:     * ConfigurarVolumes - cntVolumes (cnt_4c_Volumes): "Transporte" - 5
1234:     * campos de peso/volume do movimento. Geometria do dump (layout.json/
1235:     * sigopinf_form_codigo_fonte.txt SECAO 2). Todos com Alignment = 3
1236:     * (automatico - numerico alinha a direita) e ControlSource direto em
1237:     * TprMvCab, como no legado.
1238:     *==========================================================================
1239:     PROTECTED PROCEDURE ConfigurarVolumes()
1240:         LOCAL loc_oCnt, loc_lTemCursorPai
1241:         loc_lTemCursorPai = USED("TprMvCab")
1242: 
1243:         THIS.AddObject("cnt_4c_Volumes", "Container")
1244:         loc_oCnt = THIS.cnt_4c_Volumes
1245:         WITH loc_oCnt
1246:             .Top         = 264
1247:             .Left        = 488
1248:             .Width       = 509
1249:             .Height      = 66
1250:             .BackStyle   = 0
1251:             .BorderWidth = 0

*-- Linhas 1300 a 1318:
1300:             .Visible       = .T.
1301:         ENDWITH
1302:         IF loc_lTemCursorPai
1303:             loc_oCnt.txt_4c_Qtds.ControlSource = "TprMvCab.Qtdes"
1304:         ENDIF
1305:         BINDEVENT(loc_oCnt.txt_4c_Qtds, "When", THIS, "VolumesWhen")
1306: 
1307:         loc_oCnt.AddObject("lbl_4c_LblEspes", "Label")
1308:         WITH loc_oCnt.lbl_4c_LblEspes
1309:             .FontName  = "Tahoma"
1310:             .FontSize  = 8
1311:             .BackStyle = 0
1312:             .Alignment = 0
1313:             .AutoSize  = .F.
1314:             .Caption   = "Esp" + CHR(233) + "cie"
1315:             .Left      = 57
1316:             .Top       = 23
1317:             .Width     = 85
1318:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1334 a 1352:
1334:             .Visible       = .T.
1335:         ENDWITH
1336:         IF loc_lTemCursorPai
1337:             loc_oCnt.txt_4c_Espes.ControlSource = "TprMvCab.Espes"
1338:         ENDIF
1339:         BINDEVENT(loc_oCnt.txt_4c_Espes, "When", THIS, "VolumesWhen")
1340: 
1341:         loc_oCnt.AddObject("lbl_4c_LblPLiqs", "Label")
1342:         WITH loc_oCnt.lbl_4c_LblPLiqs
1343:             .FontName  = "Tahoma"
1344:             .FontSize  = 8
1345:             .BackStyle = 0
1346:             .Alignment = 0
1347:             .AutoSize  = .F.
1348:             .Caption   = "Peso L" + CHR(237) + "quido"
1349:             .Left      = 147
1350:             .Top       = 23
1351:             .Width     = 75
1352:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1368 a 1386:
1368:             .Visible       = .T.
1369:         ENDWITH
1370:         IF loc_lTemCursorPai
1371:             loc_oCnt.txt_4c_PLiqs.ControlSource = "TprMvCab.PLiqs"
1372:         ENDIF
1373:         BINDEVENT(loc_oCnt.txt_4c_PLiqs, "When", THIS, "VolumesWhen")
1374: 
1375:         loc_oCnt.AddObject("lbl_4c_LblPBrus", "Label")
1376:         WITH loc_oCnt.lbl_4c_LblPBrus
1377:             .FontName  = "Tahoma"
1378:             .FontSize  = 8
1379:             .BackStyle = 0
1380:             .Alignment = 0
1381:             .AutoSize  = .F.
1382:             .Caption   = "Peso Bruto"
1383:             .Left      = 223
1384:             .Top       = 23
1385:             .Width     = 75
1386:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1402 a 1420:
1402:             .Visible       = .T.
1403:         ENDWITH
1404:         IF loc_lTemCursorPai
1405:             loc_oCnt.txt_4c_PBrus.ControlSource = "TprMvCab.PBrus"
1406:         ENDIF
1407:         BINDEVENT(loc_oCnt.txt_4c_PBrus, "When", THIS, "VolumesWhen")
1408: 
1409:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1410:         WITH loc_oCnt.lbl_4c_Label1
1411:             .FontName  = "Tahoma"
1412:             .FontSize  = 8
1413:             .BackStyle = 0
1414:             .Alignment = 0
1415:             .AutoSize  = .F.
1416:             .Caption   = "Valor Transporte"
1417:             .Left      = 299
1418:             .Top       = 23
1419:             .Width     = 100
1420:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1436 a 1454:
1436:             .Visible       = .T.
1437:         ENDWITH
1438:         IF loc_lTemCursorPai
1439:             loc_oCnt.txt_4c_ValTrans.ControlSource = "TprMvCab.ValTrans"
1440:         ENDIF
1441:         BINDEVENT(loc_oCnt.txt_4c_ValTrans, "When", THIS, "VolumesWhen")
1442:     ENDPROC
1443: 
1444:     *==========================================================================
1445:     * VolumesWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')"
1446:     * do legado, texto IDENTICO nos 5 campos de cntVolumes (getQtds/getEspes/
1447:     * getPLiqs/getPBrus/getValTrans.When). Mesmo texto de PadraoIncluirAlterarWhen,
1448:     * mas com nome proprio para documentar a origem (grep direto pelo nome do
1449:     * container na auditoria).
1450:     *
1451:     * PUBLIC: alvo de BINDEVENT("When").
1452:     *==========================================================================
1453:     FUNCTION VolumesWhen()
1454:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

*-- Linhas 1507 a 1544:
1507:             .Visible       = .T.
1508:         ENDWITH
1509:         IF loc_lTemCursorPai
1510:             loc_oCnt.txt_4c_CodObs.ControlSource = "TprMvCab.CodObs"
1511:         ENDIF
1512:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "GotFocus",  THIS, "CodObsGotFocus")
1513:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "LostFocus", THIS, "CodObsLostFocus")
1514:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "When",      THIS, "CodObsWhen")
1515: 
1516:         loc_oCnt.AddObject("obj_4c_GetDesObs", "EditBox")
1517:         WITH loc_oCnt.obj_4c_GetDesObs
1518:             .FontSize      = 8
1519:             .Left          = 3
1520:             .Top           = 46
1521:             .Width         = 453
1522:             .Height        = 254
1523:             .SpecialEffect = 1
1524:             .ForeColor     = RGB(0, 0, 0)
1525:             .BorderColor   = RGB(100, 100, 100)
1526:             .Visible       = .T.
1527:         ENDWITH
1528:         IF loc_lTemCursorPai
1529:             loc_oCnt.obj_4c_GetDesObs.ControlSource = "TprMvCab.obses"
1530:         ENDIF
1531:         BINDEVENT(loc_oCnt.obj_4c_GetDesObs, "When", THIS, "DesObsWhen")
1532: 
1533:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
1534:         WITH loc_oCnt.cmd_4c_BtnMultObs
1535:             .Top          = 5
1536:             .Left         = 135
1537:             .Width        = 24
1538:             .Height       = 24
1539:             .Caption      = ""
1540:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1541:             .ToolTipText  = "Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es"
1542:             .Themes       = .T.
1543:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1544:             .Visible      = .T.

*-- Linhas 1580 a 1598:
1580:     *
1581:     *   If Not Empty(This.Value) And Not (This.Tag = Str(This.Value, 10))
1582:     *       <monta faixa ObsIni/ObsFins de SigCdOpe/SigCdOop>
1583:     *       <Select Codigos, Descrs From SigCdObs Where Codigos Between ...>
1584:     *       Set Near On / If Not Seek(...) -> fwBuscaSel / Set Near Off
1585:     *       This.Value = crLocalObs.Codigos
1586:     *       ThisForm.MontaObs(...)
1587:     *   EndIf
1588:     *
1589:     * A faixa SigCdOop (override por CFOP, dependente de crSigMvNfi/
1590:     * crSigOpCdd) nao esta disponivel nesta tela ainda (cursores de fases
1591:     * seguintes) - falso seguro: a faixa fica so com o ObsIni/ObsFins de
1592:     * SigCdOpe. fwBuscaSel -> FormBuscaAuxiliar (padrao do projeto).
1593:     *
1594:     * PUBLIC: alvo de BINDEVENT("LostFocus").
1595:     *==========================================================================
1596:     PROCEDURE CodObsLostFocus()
1597:         LOCAL loc_oTxt, loc_nPIni, loc_nPFim, loc_cSQL, loc_nErro, ;
1598:               loc_oBusca, loc_oErro, loc_lAchou

*-- Linhas 1606 a 1662:
1606:         loc_nPIni = 0
1607:         loc_nPFim = 999
1608:         IF USED("TprMvCab")
1609:             loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
1610:                 "WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
1611:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
1612: 
1613:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_LocalOpe") > 0
1614:                 loc_nPIni = IIF(!EMPTY(cursor_4c_LocalOpe.ObsInis), cursor_4c_LocalOpe.ObsInis, 0)
1615:                 loc_nPFim = IIF(!EMPTY(cursor_4c_LocalOpe.ObsFins), cursor_4c_LocalOpe.ObsFins, 999)
1616:             ENDIF
1617:             IF USED("cursor_4c_LocalOpe")
1618:                 USE IN cursor_4c_LocalOpe
1619:             ENDIF
1620:         ENDIF
1621: 
1622:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs WHERE Codigos BETWEEN " + ;
1623:             FormatarNumeroSQL(loc_nPIni, 0) + " AND " + FormatarNumeroSQL(loc_nPFim, 0)
1624:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalObs")
1625: 
1626:         IF loc_nErro < 1
1627:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1628:                 "Falha na conex" + CHR(227) + "o (cursor_4c_LocalObs)", "Erro")
1629:             RETURN
1630:         ENDIF
1631: 
1632:         loc_lAchou = .F.
1633:         IF USED("cursor_4c_LocalObs")
1634:             SELECT cursor_4c_LocalObs
1635:             LOCATE FOR Codigos = loc_oTxt.Value
1636:             loc_lAchou = FOUND()
1637:         ENDIF
1638: 
1639:         IF !loc_lAchou
1640:             loc_oBusca = .NULL.
1641:             TRY
1642:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1643:                     "SigCdObs", "cursor_4c_BuscaObs", "Codigos", ;
1644:                     TRANSFORM(loc_oTxt.Value), "Observa" + CHR(231) + CHR(245) + "es", ;
1645:                     .F., .F., ;
1646:                     "Codigos BETWEEN " + FormatarNumeroSQL(loc_nPIni, 0) + " AND " + ;
1647:                         FormatarNumeroSQL(loc_nPFim, 0))
1648:             CATCH TO loc_oErro
1649:                 MsgErro(loc_oErro.Message, "Erro ao abrir busca de observa" + CHR(231) + CHR(245) + "es")
1650:                 loc_oBusca = .NULL.
1651:             ENDTRY
1652: 
1653:             IF VARTYPE(loc_oBusca) = "O"
1654:                 IF !loc_oBusca.this_lAchouRegistro
1655:                     loc_oBusca.mAddColuna("Codigos", "999", "C" + CHR(243) + "d.")
1656:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1657:                     loc_oBusca.Show()
1658:                 ENDIF
1659: 
1660:                 IF loc_oBusca.this_lSelecionou
1661:                     loc_oTxt.Value = VAL(loc_oBusca.cCodigoSelecionado)
1662:                 ELSE

*-- Linhas 1693 a 1713:
1693:     PROTECTED PROCEDURE MontarObservacaoPadrao(par_nCodObs)
1694:         LOCAL loc_cSQL, loc_nErro, loc_cObs, loc_oTxtDesc
1695: 
1696:         loc_cSQL = "SELECT Codigos, Observas FROM SigCdObs WHERE Codigos = " + ;
1697:             FormatarNumeroSQL(par_nCodObs, 0)
1698:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdObs")
1699: 
1700:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SigCdObs") > 0
1701:             loc_cObs     = ALLTRIM(TratarNulo(cursor_4c_SigCdObs.Observas, "C"))
1702:             loc_oTxtDesc = THIS.cnt_4c_Observacao.obj_4c_GetDesObs
1703: 
1704:             IF "#" $ loc_cObs OR "$" $ loc_cObs OR "%" $ loc_cObs OR "!" $ loc_cObs
1705:                 THIS.AvisarLegadoNaoPortado("fMontaObs() / grade de itens (TmpOperacao)", ;
1706:                     "completar a observa" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o com os dados da grade")
1707:             ENDIF
1708: 
1709:             loc_oTxtDesc.Value = loc_cObs
1710:             loc_oTxtDesc.Refresh()
1711:         ENDIF
1712: 
1713:         IF USED("cursor_4c_SigCdObs")

*-- Linhas 1824 a 1842:
1824:             .Visible       = .T.
1825:         ENDWITH
1826:         IF loc_lTemCursorPai
1827:             loc_oCnt.txt_4c_Protocolos.ControlSource = "TprMvCab.protats"
1828:         ENDIF
1829:         BINDEVENT(loc_oCnt.txt_4c_Protocolos, "When", THIS, "PadraoIncluirAlterarWhen")
1830:     ENDPROC
1831: 
1832:     *==========================================================================
1833:     * ConfigurarEntrega - cntEntrega (cnt_4c_Entrega): conta/nome/cpf-cnpj
1834:     * do destinatario da entrega + botao "Local de Entrega". Os tres campos
1835:     * de conta sao intercambiaveis no legado (preencher um resolve os
1836:     * outros dois) - ver ContasLostFocus/DContaLostFocus/CpfsLostFocus.
1837:     *==========================================================================
1838:     PROTECTED PROCEDURE ConfigurarEntrega()
1839:         LOCAL loc_oCnt, loc_lTemCursorPai
1840:         loc_lTemCursorPai = USED("TprMvCab")
1841: 
1842:         THIS.AddObject("cnt_4c_Entrega", "Container")

*-- Linhas 1928 a 1946:
1928:             .Visible       = .T.
1929:         ENDWITH
1930:         IF loc_lTemCursorPai
1931:             loc_oCnt.txt_4c_Contas.ControlSource = "TprMvCab.contaes"
1932:         ENDIF
1933:         BINDEVENT(loc_oCnt.txt_4c_Contas, "LostFocus", THIS, "ContasLostFocus")
1934:         BINDEVENT(loc_oCnt.txt_4c_Contas, "When",      THIS, "PadraoIncluirAlterarWhen")
1935: 
1936:         loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
1937:         WITH loc_oCnt.txt_4c_Cpfs
1938:             .Left          = 77
1939:             .Top           = 40
1940:             .Width         = 131
1941:             .Height        = 23
1942:             .Margin        = 0
1943:             .SpecialEffect = 1
1944:             .ForeColor     = RGB(0, 0, 0)
1945:             .BorderColor   = RGB(100, 100, 100)
1946:             .Visible       = .T.

*-- Linhas 2066 a 2086:
2066:         LOCAL loc_cSQL, loc_nErro, loc_lAchou
2067:         loc_lAchou = .F.
2068: 
2069:         loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs, Situas FROM SigCdCli WHERE " + ;
2070:             par_cCampo + " = " + EscaparSQL(par_cValor)
2071:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaEntrega")
2072: 
2073:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_BuscaContaEntrega") > 0
2074:             IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
2075:                 THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
2076:                     ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
2077:             ELSE
2078:                 THIS.LimparContaEntrega()
2079:             ENDIF
2080:             loc_lAchou = .T.
2081:         ENDIF
2082: 
2083:         IF USED("cursor_4c_BuscaContaEntrega")
2084:             USE IN cursor_4c_BuscaContaEntrega
2085:         ENDIF
2086: 

*-- Linhas 2152 a 2172:
2152:             loc_cSituas = ALLTRIM(TratarNulo(EVALUATE(par_cCursor + ".Situas"), "C"))
2153: 
2154:             IF !EMPTY(loc_cSituas)
2155:                 loc_cSQL = "SELECT Codigos, Descrs, Descr2s, DispMovs, BlqMovs, BlqDescs FROM SigCdCst " + ;
2156:                     "WHERE Codigos = " + EscaparSQL(loc_cSituas)
2157:                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SituacaoConta")
2158: 
2159:                 IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SituacaoConta") > 0
2160:                     IF cursor_4c_SituacaoConta.DispMovs = 1
2161:                         loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
2162:                             cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
2163:                         MsgAviso(loc_cSituas + " - " + loc_cMsg, "Situa" + CHR(231) + CHR(227) + "o")
2164: 
2165:                         IF cursor_4c_SituacaoConta.BlqMovs = 1
2166:                             MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o Bloqueada pela Situa" + CHR(231) + CHR(227) + "o da Conta...", ;
2167:                                 "Aten" + CHR(231) + CHR(227) + "o")
2168:                             loc_lAceita = .F.
2169:                         ENDIF
2170:                     ENDIF
2171: 
2172:                     IF loc_lAceita AND USED("TprMvCab") AND TprMvCab.ValVars < 0 AND cursor_4c_SituacaoConta.BlqDescs = 1

*-- Linhas 2269 a 2289:
2269:             RETURN
2270:         ENDIF
2271: 
2272:         loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2273:             EscaparSQL(ALLTRIM(TprMvCab.ContaEs))
2274:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DCompCli")
2275: 
2276:         IF loc_nErro < 1 OR RECCOUNT("cursor_4c_DCompCli") = 0
2277:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2278:                 "Falha na conex" + CHR(227) + "o (SigCdCli)", "Erro")
2279:         ELSE
2280:             loc_cGrupos = ALLTRIM(cursor_4c_DCompCli.Grupos)
2281:             loc_cIClis  = ALLTRIM(cursor_4c_DCompCli.IClis)
2282:             loc_cRClis  = ALLTRIM(cursor_4c_DCompCli.RClis)
2283: 
2284:             TRY
2285:                 loc_oDlg = CREATEOBJECT("FormSigCdEnd", loc_cGrupos, loc_cIClis, loc_cRClis, ;
2286:                     THIS.this_cPcEscolha, TprMvCab.LocalEnts)
2287:                 IF VARTYPE(loc_oDlg) = "O"
2288:                     loc_oDlg.Show()
2289:                 ENDIF

*-- Linhas 2350 a 2368:
2350:             .Visible       = .T.
2351:         ENDWITH
2352:         IF loc_lTemCursorPai
2353:             loc_oCnt.txt_4c_Pedido.ControlSource = "TprMvCab.nPedClis"
2354:         ENDIF
2355:         BINDEVENT(loc_oCnt.txt_4c_Pedido, "When", THIS, "PedidoWhen")
2356:     ENDPROC
2357: 
2358:     *==========================================================================
2359:     * PedidoWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
2360:     * And Not (crSigCdOpe.PedClis = 5)" do legado (getPedido.When). Sem
2361:     * crSigCdOpe (fases seguintes), falso seguro - mesmo criterio de
2362:     * DocumentosWhen (bloqueia at? o dado confirmar que pode liberar).
2363:     *
2364:     * PUBLIC: alvo de BINDEVENT("When").
2365:     *==========================================================================
2366:     FUNCTION PedidoWhen()
2367:         LOCAL loc_lPermite
2368:         loc_lPermite = .F.

*-- Linhas 2490 a 2508:
2490:             .Visible       = .T.
2491:         ENDWITH
2492:         IF loc_lTemCursorPai
2493:             loc_oCnt.txt_4c_NLivDg.ControlSource = "TprMvCab.NLivDg"
2494:         ENDIF
2495:         BINDEVENT(loc_oCnt.txt_4c_NLivDg, "When", THIS, "PadraoIncluirAlterarWhen")
2496:     ENDPROC
2497: 
2498:     *==========================================================================
2499:     * AtualizarVisibilidadeCmdEntrega - "ThisForm.cmdEntrega.Visible =
2500:     * InList(crSigCdOpe.DtEntrs,1,4,6) And Not InList(ThisForm.pcEscolha,
2501:     * 'INSERIR','EXCLUIR')" do Init legado (linha 2100). crSigCdOpe e
2502:     * carregado pelo CursorQuery do Init legado, ainda nao portado (fases
2503:     * seguintes) - sem o cursor, o botao fica oculto (falso seguro); quem
2504:     * popular crSigCdOpe numa fase posterior deve chamar este metodo de
2505:     * novo para o botao assumir o estado real.
2506:     *
2507:     * PUBLIC: reutilizavel por fases/metodos futuros que alterem
2508:     * this_cPcEscolha ou recarreguem crSigCdOpe.

*-- Linhas 2643 a 2682:
2643:         IF USED("crSigCdOpe")
2644:             USE IN crSigCdOpe
2645:         ENDIF
2646:         loc_cSQL  = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2647:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe")
2648:         IF loc_nErro < 1
2649:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2650:                 "Falha na conex" + CHR(227) + "o (SigCdOpe)", "Erro")
2651:         ENDIF
2652: 
2653:         IF USED("CrSigOpCdc")
2654:             USE IN CrSigOpCdc
2655:         ENDIF
2656:         loc_cSQL  = "SELECT * FROM SigOpCdc WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2657:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdc")
2658:         IF loc_nErro < 1
2659:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2660:                 "Falha na conex" + CHR(227) + "o (SigOpCdc)", "Erro")
2661:         ENDIF
2662: 
2663:         IF USED("CrSigOpCdd")
2664:             USE IN CrSigOpCdd
2665:         ENDIF
2666:         loc_cSQL  = "SELECT * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2667:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdd")
2668:         IF loc_nErro < 1
2669:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2670:                 "Falha na conex" + CHR(227) + "o (SigOpCdd)", "Erro")
2671:         ENDIF
2672:     ENDPROC
2673: 
2674:     *==========================================================================
2675:     * CarregarPrazoEntregaPadrao - "PROCEDURE carregaprzent" do legado:
2676:     * sugere data de entrega padrao QUANDO o campo ainda esta vazio ou
2677:     * ainda e hoje - nunca sobrescreve um prazo que o usuario ja moveu.
2678:     *
2679:     *   If (InList(crSigCdOpe.DtEntrs,1,4,6) And InList(pcEscolha,
2680:     *      'INSERIR','ALTERAR') And (IsEmpty(PrazoEnts) Or
2681:     *      Dtos(PrazoEnts)=Dtos(Date())))
2682:     *       lcCta = Iif(crSigCdOpe.COpers=1, ContaDs, ContaOs)

*-- Linhas 2718 a 2737:
2718:         ENDIF
2719: 
2720:         IF !EMPTY(loc_cConta)
2721:             loc_cSQL  = "SELECT PrazoEnts FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
2722:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrazoCliente")
2723: 
2724:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_PrazoCliente") > 0 ;
2725:                AND cursor_4c_PrazoCliente.PrazoEnts > 0
2726:                 loc_dPrazo = loc_dPrazo + cursor_4c_PrazoCliente.PrazoEnts
2727:                 REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
2728:             ENDIF
2729: 
2730:             IF USED("cursor_4c_PrazoCliente")
2731:                 USE IN cursor_4c_PrazoCliente
2732:             ENDIF
2733:         ENDIF
2734:     ENDPROC
2735: 
2736:     *==========================================================================
2737:     * AtualizarVisibilidadePorOperacao - o corpo do Init legado que liga

*-- Linhas 3008 a 3026:
3008:     *        cupom fiscal-ECF / EditDocs=4]
3009:     *   Else
3010:     *       If fChecaAcesso(..., 'ALTINFO') And pcEscolha = 'CONSULTAR'
3011:     *           Update SigMvCab Set obses = ... Where CidChaves = ...
3012:     *       Endif
3013:     *   Endif
3014:     *   ThisForm.Return
3015:     *
3016:     * Cada "Return"/"Return .f." do legado (saida ANTECIPADA, sem gravar) e
3017:     * um RETURN bare deste metodo - so o CAMINHO FELIZ (fim de qualquer dos
3018:     * dois ramos) chama THIS.FecharDialogo(), equivalente ao "ThisForm.
3019:     * Return" final do legado.
3020:     *
3021:     * Guard de topo: sem TprMvCab/crSigCdOpe (cursores do form pai/Init
3022:     * legado) nao ha o que validar nem gravar - mesmo "falso seguro" das
3023:     * Fases 5-7 (CarregarPrazoEntregaPadrao, AtualizarVisibilidadePorOperacao).
3024:     *
3025:     * PUBLIC: alvo de BINDEVENT("Click") em ConfigurarBotoesAcao (Fase 4).
3026:     *==========================================================================

*-- Linhas 3234 a 3369:
3234:     * RecalcularVencimentosParcelas - laco de recalculo de vencimentos do
3235:     * btnSelItens.Click legado (disparado quando o Prazo de Entrega muda):
3236:     *
3237:     *   Select xPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3238:     *       =CursorQuery('SigOpFp','LocalFpag','fpags',xPar.Fpags,
3239:     *           [TpVencs,Entradas,Dias,tVens])
3240:     *       If LocalFpag.TpVencs = 2
3241:     *           DVenc = (Ttod(TprMvCab.PrazoEnts) + LocalFpag.Entradas)
3242:     *           Scan While Fpags=_lcFpg And cnIdTefs=_lcIdT
3243:     *               [laco de feriados] / Replace Vencs With DVenc
3244:     *               DVenc = Iif(TVen='F', GoMonth(DVenc,1), DVenc+NDia)
3245:     *           EndScan
3246:     *           Skip -1
3247:     *       Endif
3248:     *   EndScan
3249:     *
3250:     * par_cCursor: alias do cursor de parcelas a recalcular, agrupado por
3251:     * Fpags+CnIdTefs (colunas Fpags/CnIdTefs/Parcs/Vencs/CidChaves). "xPar"
3252:     * (parcelas do lancamento corrente, BtnSalvarClick) e "LocalPar"
3253:     * (parcelas de SigMvPar no lancamento direto, ProcessarLancamentoDireto)
3254:     * usam este MESMO metodo - layout de colunas identico, so a origem
3255:     * difere. Falso seguro: sem o cursor (par_cCursor), nao ha o que
3256:     * recalcular.
3257:     *
3258:     * par_lAtualizarBanco = .T. (LocalPar) tambem grava o vencimento no SQL
3259:     * Server ("Update SigMvPar Set Vencs = ... Where CidChaves = ..."),
3260:     * como o legado faz nesse caminho; .F. (xPar) e so cursor em memoria do
3261:     * form pai, igual ao legado.
3262:     *
3263:     * Feriados: AvancarAlemDosFeriados()/CarregarFeriados() reproduzem o
3264:     * MESMO padrao e a MESMA razao de FormSigOpFpg (decisao documentada
3265:     * la: SEEK string-sobre-data do legado nao e reproduzivel ao vivo,
3266:     * reescrito preservando a condicao de parada original).
3267:     *
3268:     * PROTECTED: chamado so por BtnSalvarClick() e ProcessarLancamentoDireto().
3269:     *==========================================================================
3270:     PROTECTED PROCEDURE RecalcularVencimentosParcelas(par_cCursor, par_lAtualizarBanco)
3271:         LOCAL loc_dVenc, loc_nDias, loc_cTipoVenc, loc_cFpgAtual, loc_cIdTefAtual
3272:         LOCAL loc_cSQLFpg, loc_nErro, loc_cSQLUpdate, loc_cCidChave
3273: 
3274:         IF !USED(par_cCursor) OR !USED("TprMvCab") OR EMPTY(TprMvCab.PrazoEnts)
3275:             RETURN
3276:         ENDIF
3277: 
3278:         SELECT (par_cCursor)
3279:         INDEX ON Fpags + CnIdTefs + STR(Parcs, 2) TAG FpagV
3280:         SCAN
3281:             loc_cFpgAtual = Fpags
3282: 
3283:             IF USED("cursor_4c_FpgVenc")
3284:                 USE IN cursor_4c_FpgVenc
3285:             ENDIF
3286:             loc_cSQLFpg = "SELECT TpVencs, Entradas, Dias, tVens FROM SigOpFp " + ;
3287:                 "WHERE Fpags = " + EscaparSQL(loc_cFpgAtual)
3288:             loc_nErro   = SQLEXEC(gnConnHandle, loc_cSQLFpg, "cursor_4c_FpgVenc")
3289:             SELECT (par_cCursor)
3290: 
3291:             IF loc_nErro >= 1 AND USED("cursor_4c_FpgVenc") AND cursor_4c_FpgVenc.TpVencs = 2
3292:                 loc_dVenc       = ConverterParaData(TprMvCab.PrazoEnts) + cursor_4c_FpgVenc.Entradas
3293:                 loc_nDias       = cursor_4c_FpgVenc.Dias
3294:                 loc_cTipoVenc   = cursor_4c_FpgVenc.tVens
3295:                 loc_cFpgAtual   = Fpags
3296:                 loc_cIdTefAtual = CnIdTefs
3297: 
3298:                 SCAN WHILE Fpags = loc_cFpgAtual AND CnIdTefs = loc_cIdTefAtual
3299:                     loc_dVenc = THIS.AvancarAlemDosFeriados(loc_dVenc)
3300:                     REPLACE Vencs WITH loc_dVenc IN (par_cCursor)
3301: 
3302:                     IF par_lAtualizarBanco
3303:                         loc_cCidChave  = CidChaves
3304:                         loc_cSQLUpdate = "UPDATE SigMvPar SET Vencs = " + ;
3305:                             FormatarDataSQL(loc_dVenc) + " WHERE CidChaves = " + ;
3306:                             EscaparSQL(loc_cCidChave)
3307:                         IF SQLEXEC(gnConnHandle, loc_cSQLUpdate) < 1
3308:                             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3309:                                 "Falha na conex" + CHR(227) + "o (Update SigMvPar)", "Erro")
3310:                         ENDIF
3311:                     ENDIF
3312: 
3313:                     loc_dVenc = IIF(loc_cTipoVenc = "F", GOMONTH(loc_dVenc, 1), loc_dVenc + loc_nDias)
3314:                 ENDSCAN
3315:                 SKIP -1
3316:             ENDIF
3317:         ENDSCAN
3318: 
3319:         IF USED("cursor_4c_FpgVenc")
3320:             USE IN cursor_4c_FpgVenc
3321:         ENDIF
3322:     ENDPROC
3323: 
3324:     *==========================================================================
3325:     * CarregarFeriados - Le SigCdFer uma unica vez para this_cFeriadosCache
3326:     * ("|AAAAMMDD|..."), mesmo padrao de FormSigOpFpg.CarregarFeriados -
3327:     * evita um SELECT por parcela dentro do laco de recalculo.
3328:     *==========================================================================
3329:     PROTECTED PROCEDURE CarregarFeriados()
3330:         LOCAL loc_cSQL, loc_nResultado, loc_cLista, loc_oErro
3331: 
3332:         IF THIS.this_lFeriadosCarregados
3333:             RETURN .T.
3334:         ENDIF
3335: 
3336:         loc_cLista = "|"
3337: 
3338:         TRY
3339:             IF USED("cursor_4c_FerLoad")
3340:                 USE IN SELECT("cursor_4c_FerLoad")
3341:             ENDIF
3342: 
3343:             loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"
3344: 
3345:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")
3346: 
3347:             IF loc_nResultado > 0 AND USED("cursor_4c_FerLoad")
3348:                 SELECT cursor_4c_FerLoad
3349:                 SCAN
3350:                     IF !ISNULL(datas) AND !EMPTY(datas)
3351:                         loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
3352:                     ENDIF
3353:                 ENDSCAN
3354:                 USE IN SELECT("cursor_4c_FerLoad")
3355:             ENDIF
3356: 
3357:             THIS.this_cFeriadosCache      = loc_cLista
3358:             THIS.this_lFeriadosCarregados = .T.
3359:         CATCH TO loc_oErro
3360:             THIS.this_cFeriadosCache = "|"
3361:         ENDTRY
3362: 
3363:         RETURN .T.
3364:     ENDPROC
3365: 
3366:     *==========================================================================
3367:     * AvancarAlemDosFeriados - laco de feriados do btnSelItens.Click legado:
3368:     *
3369:     *   lnFer = 0 / Verd = .t.

*-- Linhas 3452 a 3511:
3452:     * ProcessarLancamentoDireto - ramo "If ThisForm.Direta" do "PROCEDURE
3453:     * return" legado:
3454:     *
3455:     *   Select CrSigMvCab / Zap / Select TprMvCab / Scatter Memvar memo /
3456:     *   Select CrSigMvCab / Append Blank / Gather Memvar Memo
3457:     *   lcSql = Select a.*, b.TpVencs,b.Entradas,b.dias,b.tVens From SigMvPar a,
3458:     *       SigOpFp b where a.EmpDopNums = <TprMvCab.EmpDopNums> And a.Fpags = b.fpags
3459:     *   Select LocalPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3460:     *       [recalculo de vencimentos + Update SigMvPar - ver
3461:     *        RecalcularVencimentosParcelas]
3462:     *   EndScan
3463:     *   llOk = UpDate('CrSigMvCab') And Commit() > 0 / If !llOk -> RollBack()
3464:     *   Select TprMvCab / Zap
3465:     *
3466:     * CrSigMvCab (cursor de BATCH do lancamento direto) e o commit em lote
3467:     * (ThisForm.ParentForm.PoDataMgr.UpDate/Commit/RollBack) pertencem ao
3468:     * form PAI/orquestrador da operacao, inexistente nesta migracao (nenhum
3469:     * caller de Formsigopinf no acervo - ver cabecalho do arquivo). Falso
3470:     * seguro: sem CrSigMvCab, o bloco INTEIRO fica de fora - inclusive o
3471:     * recalculo de SigMvPar (que so faz sentido acoplado ao commit em lote)
3472:     * e o "Select TprMvCab / Zap" final, que SEM o lote persistido em outro
3473:     * lugar destruiria os dados do usuario (regra CLAUDE.md #17 - nao
3474:     * reproduzir so a metade de uma formula/fluxo que depende do resto).
3475:     *
3476:     * PROTECTED: so FecharDialogo(), desta mesma classe, chama.
3477:     *==========================================================================
3478:     PROTECTED PROCEDURE ProcessarLancamentoDireto()
3479:         LOCAL loc_cSQL, loc_nErro
3480: 
3481:         IF !THIS.this_lDireta OR !USED("CrSigMvCab") OR !USED("TprMvCab")
3482:             RETURN
3483:         ENDIF
3484: 
3485:         IF EMPTY(TprMvCab.EmpDopNums)
3486:             RETURN
3487:         ENDIF
3488: 
3489:         IF USED("LocalPar")
3490:             USE IN LocalPar
3491:         ENDIF
3492:         loc_cSQL = "SELECT a.*, b.TpVencs, b.Entradas, b.Dias, b.tVens " + ;
3493:             "FROM SigMvPar a, SigOpFp b " + ;
3494:             "WHERE a.EmpDopNums = " + EscaparSQL(TprMvCab.EmpDopNums) + " " + ;
3495:             "AND a.Fpags = b.Fpags"
3496:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "LocalPar")
3497:         IF loc_nErro < 1
3498:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3499:                 "Falha na conex" + CHR(227) + "o ( LocalPar )", "Erro")
3500:             RETURN
3501:         ENDIF
3502: 
3503:         THIS.RecalcularVencimentosParcelas("LocalPar", .T.)
3504: 
3505:         IF USED("LocalPar")
3506:             USE IN LocalPar
3507:         ENDIF
3508: 
3509:         *-- Commit em lote (CrSigMvCab) fora do escopo desta migracao - ver
3510:         *-- comentario de cabecalho do metodo.
3511:     ENDPROC


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

