# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDQUERYS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCADS, GRUPOS, ESTOS, EMPS, SQTDS, CONTAS, EMPDOPNUMS, DISPS, CODCORS, CODTAMS, XBAIXA, DOPES, EMPDOPNOPS, CHKSUBN, NOPS, DATAS, TIPOOPS, COPERS, OPERS, CPROS, PRODUZIR, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCADS, GRUPOS, ESTOS, EMPS, SQTDS, CONTAS, EMPDOPNUMS, DISPS, CODCORS, CODTAMS, XBAIXA, DOPES, EMPDOPNOPS, CHKSUBN, NOPS, DATAS, TIPOOPS, COPERS, OPERS, CPROS, PRODUZIR, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPCADS, GRUPOS, ESTOS, EMPS, SQTDS, CONTAS, EMPDOPNUMS, DISPS, CODCORS, CODTAMS, XBAIXA, DOPES, EMPDOPNOPS, CHKSUBN, NOPS, DATAS, TIPOOPS, COPERS, OPERS, CPROS, PRODUZIR, CITENS

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
  DeleteMark = .F.
  ControlSource = "TmpCabec.Obs"
  ControlSource = "TmpItens.Obs"
Select TmpCabec
	.Column1.ControlSource = 'TmpCabec.Flag'
	.Column2.ControlSource = 'TmpCabec.Dopes'
	.Column3.ControlSource = 'TmpCabec.Numes'
	.Column4.ControlSource = 'TmpCabec.Datas'
	.Column5.ControlSource = 'Iif(IsNull(TmpCabec.Entregas), {}, TmpCabec.Entregas)'
	.Column6.ControlSource = 'TmpCabec.Peso'
	.Column7.ControlSource = 'TmpCabec.Contav'
	.Column8.ControlSource = 'TmpCabec.Conta'
	.Column9.ControlSource = 'Iif(Empty(TmpCabec.Obs ), " ", "*")'
	.Column10.ControlSource = 'TmpCabec.Notas'
ThisForm.getCliente.ControlSource = [TmpCabec.DConta]
	.Column1.ControlSource = 'TmpItens.Cpros'
	.Column6.ControlSource = 'TmpItens.CodCors'
	.Column7.ControlSource = 'TmpItens.CodTams'
	.Column2.ControlSource = 'TmpItens.Qtds'
	.Column3.ControlSource = 'TmpItens.Saldo'
	.Column4.ControlSource = 'TmpItens.Peso'
	.Column5.ControlSource = 'Iif(Empty(TmpItens.Obs ), " ", "*")'
	.Column8.ControlSource = 'TmpItens.Reffs'
Select TmpItens
Select TmpCabec
Select TmpItens
	Select TmpCabec
	Select TmpCabec
Select TmpCabec
lcQuery = [Select * From SigCdCeg Where TpCads <> 1]
If ThisForm.PodataMgr.SqlExecute(lcquery,'TmpCeg') < 1
Select CrSigTempd
Select TmpCeg
		Select CrSigTempd
	Select CrSigTempd
If !ThisForm.Podatamgr2.UpDate('CrSigTempd')
lcQuery = [Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b ]+;
		[Select a.*, b.CodObs as Priors From SigMvEst a, SigTempd b ] +;
If ThisForm.PodataMgr.SqlExecute(lcquery,'TmpEstoque') < 1
Select TmpEstoque
	Select TmpSaldo
	If Not Seek(TmpEstoque.Cpros + TmpEstoque.CodCors + TmpEstoque.CodTams)
		Insert Into TmpSaldo ( CPros, CodCors, CodTams, Saldo, Disps );
	Insert Into TmpSaldg ( Grupos, Estos, CPros, CodCors, CodTams, Saldo, Disps, Priors, Emps );
	lcQuery = [Select EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEest') < 1)
	Select TempEest
		Select TempEestI
				lcQuery = [Select * ] + ;
						    [From SigMvIts ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TempEsti2') < 1)
				Select TempEsti2
					Select TmpSaldo
					If Not Seek(TempEestI.Cpros)
						Insert Into TmpSaldo (Cpros) Value (TempEestI.CPros)
					Select TmpSaldg
					If !Seek( TempEest.Emps + TempEest.GrupoOs + TempEest.ContaOs + TempEesti.Cpros )
						Insert Into TmpSaldg ( Emps, Grupos, Estos, Cpros, Priors )  ;
					Select TempEsti2
						Select TmpSaldo
						If Not Seek(TempEsti2.Cpros + TempEsti2.CodCors + TempEsti2.CodTams)
							Insert Into TmpSaldo (Cpros, CodCors, CodTams) ;
						Select TmpSaldg
						If !Seek( TempEest.Emps + TempEest.GrupoOs + TempEest.ContaOs + TempEsti2.Cpros + TempEsti2.CodCors + TempEsti2.CodTams )
							Insert Into TmpSaldg ( Emps, Grupos, Estos, Cpros, CodCors, CodTams, Priors ) Value ;
Select TmpItens
	Select TmpCabec
	Select TmpOper
	Select TmpItens
		If (TmpOper.ChkObs <> 1 and Not IsEmpty(TmpItens.Obs)) Or Not Seek(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, 'TmpSaldo') Or ;
			=Seek(TmpItens.CPros + TmpItens.CodCors + TmpItens.CodTams, 'TmpSaldo')
		Insert Into TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, Produzir, Obsps, ;
Select TmpSaldo
		Select TmpSaldG
		=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
	lcSql = [Select a.Nops, a.Cpros, a.CodCors, a.CodTams, sum(a.Qtds) as Qtds From SigOpPic a, SigCdNec b ]+;
	=ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpOpi')
	Select TmpOpi
		Select TmpSaldo
		If Not Seek(TmpOpi.Cpros + TmpOpi.CodCors + TmpOpi.CodTams)
			Insert Into TmpSaldo ( CPros, CodCors, CodTams );
		Insert Into TmpFabr (Nops, Cpros, CodCors, CodTams, Qtds, Priors) Values ;
		lcSql = [Select GrupoDs From SigPdMvf Where Nops = ]+Str(TmpOpi.Nops,10)+[ Order by CidChaves Desc ]
		=ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpMfas')
		Select TmpMfas
		If Seek(TmpOpi.Cpros + TmpOpi.CodCors + TmpOpi.CodTams,'TmpFinal','Cpros')
	Select TmpSaldo
			Select TmpFabr
			=Seek(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
	Select Cpros, CodCors, CodTams, Linhas, Sum(Qtds) as Qtds, sum(Saldo) as Saldo, sum(Estoque) as Estoque,;
		sum(Produzir) as Produzir, sum(Fabrs) as Fabrs From TmpFinal ;
		lcSql = [Select a.cpros, a.qtds, b.Caixas, b.copers, b.opers, a.opers ]+;
				[From SigMvItn a, SigCdOpe b, SigMvCab c ]+;
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalEest')
		Select cpros, Sum(qtds*Iif(( Caixas=1 and copers=1) or (caixas<>1 and opers=1) Or (caixas<>1 and opers=3 and opers='E'),1,-1)) as Qtds ;
		From LocalEest Group by 1 Into cursor Vendas ReadWrite
		Select Vendas
	Select TmpFinalG
	Select Selecao
		lcSql = [Select QtMinFabs From SigCdPro Where Cpros = ']+Selecao.Cpros+[']
		ThisForm.PodataMgr.Sqlexecute(lcSql,'CrSigCdPro')
		If Used('Vendas') And Seek(m.Cpros,'Vendas','Cpros')
		Select TmpFinalG
Select TmpItens

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGl2.prg) - TRECHOS RELEVANTES PARA PASS SQL (1369 linhas total):

*-- Linhas 193 a 211:
193:             .FontSize          = 8
194:             .AllowHeaderSizing = .F.
195:             .AllowRowSizing    = .F.
196:             .DeleteMark        = .F.
197:             .RecordMark        = .F.
198:             .RowHeight         = 17
199:             .ScrollBars        = 2
200:             .GridLineColor     = RGB(238,238,238)
201:             .Panel             = 1
202:         ENDWITH
203: 
204:         *-- Configurar colunas da GradeOpe
205:         WITH THIS.grd_4c_GradeOpe
206: 
207:             *-- Col1: Flag (checkbox de selecao)
208:             WITH .Column1
209:                 .Width     = 17
210:                 .Movable   = .F.
211:                 .Resizable = .F.

*-- Linhas 475 a 493:
475:             .FontSize          = 8
476:             .AllowHeaderSizing = .F.
477:             .AllowRowSizing    = .F.
478:             .DeleteMark        = .F.
479:             .RecordMark        = .F.
480:             .RowHeight         = 17
481:             .ScrollBars        = 2
482:             .GridLineColor     = RGB(238,238,238)
483:             .Panel             = 1
484:         ENDWITH
485: 
486:         *-- Configurar colunas da GradeItens
487:         WITH THIS.grd_4c_GradeItens
488: 
489:             *-- Col1: Produto (Cpros) - ColumnOrder=1 (default)
490:             WITH .Column1
491:                 .Width     = 120
492:                 .Movable   = .F.
493:                 .Resizable = .F.

*-- Linhas 760 a 823:
760:     ENDPROC
761: 
762:     *--------------------------------------------------------------------------
763:     * ConfigurarGrades - Define RecordSource e ControlSource das grades
764:     *--------------------------------------------------------------------------
765:     PROTECTED PROCEDURE ConfigurarGrades()
766: 
767:         *-- GradeOperacoes vinculada a TmpCabec
768:         THIS.grd_4c_GradeOpe.RecordSource = "TmpCabec"
769:         WITH THIS.grd_4c_GradeOpe
770:             .Column1.ControlSource  = "TmpCabec.Flag"
771:             .Column2.ControlSource  = "TmpCabec.Dopes"
772:             .Column3.ControlSource  = "TmpCabec.Numes"
773:             .Column4.ControlSource  = "TmpCabec.Datas"
774:             .Column5.ControlSource  = "IIF(ISNULL(TmpCabec.Entregas), {}, TmpCabec.Entregas)"
775:             .Column6.ControlSource  = "TmpCabec.Peso"
776:             .Column7.ControlSource  = "TmpCabec.Contav"
777:             .Column8.ControlSource  = "TmpCabec.Conta"
778:             .Column9.ControlSource  = "IIF(EMPTY(TmpCabec.Obs), ' ', '*')"
779:             .Column10.ControlSource = "TmpCabec.Notas"
780:         ENDWITH
781: 
782:         *-- Cliente (nome do cliente da operacao atual)
783:         THIS.txt_4c_Cliente.ControlSource = "TmpCabec.DConta"
784: 
785:         *-- Obs da operacao (editavel)
786:         THIS.edt_4c_ObsOpe.ControlSource = "TmpCabec.Obs"
787: 
788:         *-- GradeItens vinculada a TmpItens
789:         THIS.grd_4c_GradeItens.RecordSource = "TmpItens"
790:         WITH THIS.grd_4c_GradeItens
791:             .Column1.ControlSource = "TmpItens.Cpros"
792:             .Column2.ControlSource = "TmpItens.Qtds"
793:             .Column3.ControlSource = "TmpItens.Saldo"
794:             .Column4.ControlSource = "TmpItens.Peso"
795:             .Column5.ControlSource = "IIF(EMPTY(TmpItens.Obs), ' ', '*')"
796:             .Column6.ControlSource = "TmpItens.CodCors"
797:             .Column7.ControlSource = "TmpItens.CodTams"
798:             .Column8.ControlSource = "TmpItens.Reffs"
799:         ENDWITH
800: 
801:         *-- Obs dos itens (editavel)
802:         THIS.edt_4c_ObsItens.ControlSource = "TmpItens.Obs"
803: 
804:         *-- Posicionar TmpItens filtrado pelo primeiro registro de TmpCabec
805:         IF USED("TmpItens") AND USED("TmpCabec")
806:             SELECT TmpCabec
807:             GO TOP
808:             SELECT TmpItens
809:             SET ORDER TO EmpDopNum
810:             SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
811:             GO TOP
812:         ENDIF
813: 
814:     ENDPROC
815: 
816:     *--------------------------------------------------------------------------
817:     * RegistrarEventos - BINDEVENT para todos os eventos interativos
818:     *--------------------------------------------------------------------------
819:     PROTECTED PROCEDURE RegistrarEventos()
820: 
821:         BINDEVENT(THIS.grd_4c_GradeOpe, "AfterRowColChange", THIS, "AoMudarLinhaOpe")
822:         BINDEVENT(THIS.grd_4c_GradeOpe.Column2.Header1, "Click", THIS, "AoClicarCabMovi")
823:         BINDEVENT(THIS.grd_4c_GradeOpe.Column5.Header1, "Click", THIS, "AoClicarCabEntrega")

*-- Linhas 855 a 904:
855:     *--------------------------------------------------------------------------
856:     PROCEDURE AoMudarLinhaOpe(par_nColIndex)
857:         IF USED("TmpItens") AND USED("TmpCabec")
858:             SELECT TmpItens
859:             SET ORDER TO EmpDopNum
860:             SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
861:             GO TOP
862:             THIS.txt_4c_Cliente.Refresh()
863:             THIS.edt_4c_ObsOpe.Refresh()
864:             THIS.grd_4c_GradeItens.Refresh()
865:             THIS.edt_4c_ObsItens.Refresh()
866:         ENDIF
867:     ENDPROC
868: 
869:     *--------------------------------------------------------------------------
870:     * AoClicarCabMovi - Click no Header da Coluna 2 (Movimentacao)
871:     * Ordena TmpCabec por EmpDopNum
872:     *--------------------------------------------------------------------------
873:     PROCEDURE AoClicarCabMovi()
874:         IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "EMPDOPNUM"
875:             THIS.AplicarOrdem("EMPDOPNUM")
876:             SELECT TmpCabec
877:             GO TOP
878:             THIS.grd_4c_GradeOpe.Refresh()
879:         ENDIF
880:     ENDPROC
881: 
882:     *--------------------------------------------------------------------------
883:     * AoClicarCabEntrega - Click no Header da Coluna 5 (Entrega)
884:     * Ordena TmpCabec por data de entrega
885:     *--------------------------------------------------------------------------
886:     PROCEDURE AoClicarCabEntrega()
887:         IF USED("TmpCabec") AND UPPER(ORDER("TmpCabec")) <> "ENTREGA"
888:             THIS.AplicarOrdem("ENTREGA")
889:             SELECT TmpCabec
890:             GO TOP
891:             THIS.grd_4c_GradeOpe.Refresh()
892:         ENDIF
893:     ENDPROC
894: 
895:     *--------------------------------------------------------------------------
896:     * AoMudarLinhaItens - AfterRowColChange da GradeItens
897:     * Atualiza editbox de observacao do item
898:     *--------------------------------------------------------------------------
899:     PROCEDURE AoMudarLinhaItens(par_nColIndex)
900:         THIS.edt_4c_ObsItens.Refresh()
901:     ENDPROC
902: 
903:     *--------------------------------------------------------------------------
904:     * AoProcessar - Click do botao Processar

*-- Linhas 1193 a 1211:
1193:         TRY
1194:             IF USED("TmpCabec") AND USED("TmpItens")
1195:                 THIS.AplicarOrdem("")
1196:                 SELECT TmpCabec
1197:                 GO TOP
1198:                 THIS.grd_4c_GradeOpe.Refresh()
1199:                 THIS.AoMudarLinhaOpe(0)
1200:                 THIS.HabilitarCampos()
1201:                 loc_lSucesso = .T.
1202:             ELSE
1203:                 MsgAviso("Cursores TmpCabec/TmpItens n" + CHR(227) + "o disponibilizados pelo form pai.", ;
1204:                          "Aviso")
1205:             ENDIF
1206:         CATCH TO loc_oErro
1207:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
1208:         ENDTRY
1209: 
1210:         RETURN loc_lSucesso
1211:     ENDPROC

*-- Linhas 1234 a 1252:
1234:     *--------------------------------------------------------------------------
1235:     * BOParaForm - Atualiza controles visiveis com o estado atual dos cursores.
1236:     * Para este form OPERACIONAL o estado e gerenciado pelos cursores TmpCabec
1237:     * e TmpItens via ControlSource; basta refreshar os controles visuais.
1238:     *--------------------------------------------------------------------------
1239:     PROTECTED PROCEDURE BOParaForm()
1240:         LOCAL loc_oErro
1241: 
1242:         TRY
1243:             IF USED("TmpCabec")
1244:                 THIS.grd_4c_GradeOpe.Refresh()
1245:                 THIS.txt_4c_Cliente.Refresh()
1246:                 THIS.edt_4c_ObsOpe.Refresh()
1247:             ENDIF
1248:             IF USED("TmpItens")
1249:                 THIS.grd_4c_GradeItens.Refresh()
1250:                 THIS.edt_4c_ObsItens.Refresh()
1251:             ENDIF
1252:         CATCH TO loc_oErro

*-- Linhas 1264 a 1301:
1264: 
1265:         TRY
1266:             IF USED("TmpCabec")
1267:                 SELECT TmpCabec
1268:                 GO TOP
1269:                 SCAN FOR Flag
1270:                     loc_lTemSelecionado = .T.
1271:                     EXIT
1272:                 ENDSCAN
1273:             ENDIF
1274: 
1275:             IF VARTYPE(THIS.cmd_4c_Processar) = "O"
1276:                 THIS.cmd_4c_Processar.Enabled = loc_lTemSelecionado
1277:             ENDIF
1278: 
1279:         CATCH TO loc_oErro
1280:             MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
1281:         ENDTRY
1282:     ENDPROC
1283: 
1284:     *--------------------------------------------------------------------------
1285:     * LimparCampos - Desmarca todas as operacoes de TmpCabec e refresha
1286:     * os controles de observacao que possuem ControlSource vinculado.
1287:     *--------------------------------------------------------------------------
1288:     PROCEDURE LimparCampos()
1289:         LOCAL loc_oErro
1290: 
1291:         TRY
1292:             IF USED("TmpCabec")
1293:                 REPLACE ALL Flag WITH .F. IN TmpCabec
1294:                 THIS.grd_4c_GradeOpe.Refresh()
1295:             ENDIF
1296: 
1297:             IF VARTYPE(THIS.edt_4c_ObsOpe) = "O"
1298:                 THIS.edt_4c_ObsOpe.Refresh()
1299:             ENDIF
1300:             IF VARTYPE(THIS.edt_4c_ObsItens) = "O"
1301:                 THIS.edt_4c_ObsItens.Refresh()


### BO (C:\4c\projeto\app\classes\SigPrGl2BO.prg):
*==============================================================================
* SigPrGl2BO.prg - Business Object: Geracao de Ordens de Producao
* Herda de: BusinessBase
* Tipo: OPERACIONAL (sem CRUD direto - processamento de OPs)
* Tabelas usadas: SigCdCeg, SigMvEst, SigTempd, SigMvCab, SigMvItn,
*                 SigMvIts, SigCdOpe, SigCdPro, SigOpPic, SigCdNec,
*                 SigPdMvf, CrSigTempd (cursor do framework)
* Cursores de entrada (recebidos do form pai):
*   TmpCabec - Cabecalho das operacoes selecionadas
*   TmpItens - Itens das operacoes selecionadas
*   TmpOper  - Tabela de operacoes (tipos de movimentacao)
*   CrSigCdPam, CrSigCdPac - Parametros do sistema
*   CrSigTempd - Cursor temporario de estoques (do framework)
*==============================================================================
DEFINE CLASS SigPrGl2BO AS BusinessBase

    *-- Entidade persistida: SigTempd (tabela de trabalho de sessoes de geracao de OPs)
    this_cTabela     = "SigTempd"
    this_cCampoChave = "CidChaves"

    *-- Estado da sessao de processamento (recebidos do form pai via Init)
    this_lReserva    = .F.    && Flag: reserva automatica de estoque
    this_lAutomatico = .F.    && Flag: processamento automatico (sem confirmacao)
    this_nEmphPdr    = 0      && Empresa padrao para geracao de OPs
    this_nNumeroDaOP = 0      && Numero da OP destino (passado do form pai)
    this_cPorDestino = ""     && Codigo de destino (PorDestino do form pai)
    this_cOrdConta   = ""     && Ordenacao atual do grid de operacoes

    *-- Propriedades da entidade SigTempd (registro de trabalho da sessao)
    this_cCidChaves  = ""     && char(64) PK do registro SigTempd
    this_cCidQuerys  = ""     && char(20) ID de sessao (agrupa varios cidchaves)
    this_cGrupos     = ""     && char(10) Grupo de estoque
    this_cContas     = ""     && char(10) Conta de estoque
    this_cEmps       = ""     && char(3)  Empresa
    this_nCodObs     = 0      && numeric(3,0) Prioridade do centro de estoque

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cTabela     = "SigTempd"
            THIS.this_cCampoChave = "CidChaves"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- Flag: .T. se processamento deve abrir SigPrGlx (com estimados), .F. para SigPrGlp
    this_lTemEstimado = .F.

    *--------------------------------------------------------------------------
    * ProcessarOperacoes - Processa operacoes selecionadas e prepara cursores
    * para o proximo sub-form (SigPrGlx ou SigPrGlp).
    * Parametros: par_lReserva     - flag reserva automatica
    *             par_lAutomatico  - flag processamento automatico
    *             par_nEmphPdr     - empresa padrao
    *             par_nNumeroDaOP  - numero da OP destino
    *             par_cPorDestino  - codigo de destino
    * Retorno: .T. se ok, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarOperacoes(par_lReserva, par_lAutomatico, par_nEmphPdr, par_nNumeroDaOP, par_cPorDestino)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cEmpresa, loc_cCidQuerys
        LOCAL loc_nContador, loc_lcJob
        LOCAL loc_cSQL
        LOCAL loc_xBaixa, loc_nEstoque, loc_nProduzir, loc_nSaldo
        LOCAL loc_lcEdn, loc_nItn
        LOCAL loc_cPEdI, loc_cPEdF
        LOCAL loc_lProduzirTudo, loc_llData
        LOCAL loc_llFalse

        loc_lResultado = .T.
        loc_cEmpresa   = go_4c_Sistema.cCodEmpresa

        TRY
            *-- PASSO 1: Validar selecao e verificar Jobs iguais
            SELECT TmpCabec
            SET ORDER TO EmpDopNum

            loc_nContador = 0
            GO TOP
            loc_lcJob = ALLTRIM(NVL(TmpCabec.Jobs, ""))

            SCAN FOR Flag
                loc_nContador = loc_nContador + 1
                IF ALLTRIM(NVL(TmpCabec.Jobs,"")) <> loc_lcJob
                    MsgAviso("N" + CHR(227) + "o " + CHR(233) + " permitido gerar OPs de opera" + ;
                             CHR(231) + CHR(245) + "es com Jobs diferentes.", "Aviso")
                    loc_lResultado = .F.
                    EXIT
                ENDIF
            ENDSCAN

            IF loc_lResultado AND loc_nContador = 0
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada!", "Aviso")
                loc_lResultado = .F.
            ENDIF

            *-- PASSO 2: Preparar chave de sessao e buscar centros de estoque
            IF loc_lResultado
                loc_cCidQuerys = fUniqueIds()

                loc_cSQL = "SELECT * FROM SigCdCeg WHERE TpCads <> 1"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpCeg") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TmpCeg). Favor reinicializar o processo.", "Erro")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- PASSO 3: Popular SigTempd com prioridades de estoque
            IF loc_lResultado
                loc_cSQL = "DELETE FROM SigTempd WHERE CidQuerys = '" + ALLTRIM(loc_cCidQuerys) + "'"
                SQLEXEC(gnConnHandle, loc_cSQL)

                SELECT TmpCeg
                IF RECCOUNT("TmpCeg") > 0
                    SCAN
                        IF loc_lResultado
                            loc_cSQL = "INSERT INTO SigTempd " + ;
                                "(Grupos, Contas, CodObs, Emps, CidChaves, CidQuerys) VALUES (" + ;
                                EscaparSQL(ALLTRIM(NVL(TmpCeg.Grupos,""))) + ", " + ;
                                EscaparSQL(ALLTRIM(NVL(TmpCeg.Contas,""))) + ", " + ;
                                FormatarNumeroSQL(NVL(TmpCeg.Priors, 0), 0) + ", " + ;
                                EscaparSQL(ALLTRIM(NVL(TmpCeg.Emps,""))) + ", " + ;
                                EscaparSQL(fUniqueIds()) + ", " + ;
                                EscaparSQL(loc_cCidQuerys) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                loc_lResultado = .F.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ELSE
                    IF USED("crSigCdPam")
                        loc_cSQL = "INSERT INTO SigTempd " + ;
                            "(Grupos, Contas, CodObs, Emps, CidChaves, CidQuerys) VALUES (" + ;
                            EscaparSQL(ALLTRIM(NVL(crSigCdPam.GrupoEsts,""))) + ", " + ;
                            EscaparSQL(ALLTRIM(NVL(crSigCdPam.ContaEsts,""))) + ", " + ;
                            "1, " + ;
                            EscaparSQL(ALLTRIM(loc_cEmpresa)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", " + ;
                            EscaparSQL(loc_cCidQuerys) + ")"
                        loc_lResultado = SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                    ENDIF
                ENDIF

                IF !loc_lResultado
                    MsgErro("Falha ao gravar em SigTempd. Favor reinicializar o processo.", "Erro")
                ENDIF
            ENDIF

            *-- PASSO 4: Buscar estoque disponivel via SigMvEst x SigTempd
            IF loc_lResultado
                loc_cSQL = "SELECT a.CPros, a.CodCors, a.CodTams, a.Grupos, a.Estos, " + ;
                    "a.SQtds, a.Emps, b.CodObs AS Priors " + ;
                    "FROM SigMvEst a, SigTempd b " + ;
                    "WHERE a.Grupos = b.Grupos AND a.Estos = b.Contas " + ;
                    "AND a.Emps = b.Emps AND a.Sqtds > 0 " + ;
                    "UNION " + ;
                    "SELECT a.CPros, a.CodCors, a.CodTams, a.Grupos, a.Estos, " + ;
                    "a.SQtds, a.Emps, b.CodObs AS Priors " + ;
                    "FROM SigMvEst a, SigTempd b " + ;
                    "WHERE a.Grupos = b.Grupos AND b.Contas = '' " + ;
                    "AND a.Emps = b.Emps AND a.Sqtds > 0"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpEstoque") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TmpEstoque). Favor reinicializar.", "Erro")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- PASSO 5: Limpar SigTempd desta sessao
            IF loc_lResultado
                loc_cSQL = "DELETE FROM SigTempd WHERE CidQuerys = '" + ALLTRIM(loc_cCidQuerys) + "'"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            *-- PASSO 6: Criar cursores de saldo TmpSaldo e TmpSaldg
            IF loc_lResultado
                SET NULL ON
                CREATE CURSOR TmpSaldo (CPros C(14) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                    Saldo N(12,3) NULL, Disps N(12,3) NULL, Fabrs N(12,3) NULL, DispFs N(12,3) NULL)
                INDEX ON CPros + CodCors + CodTams TAG CPros

                CREATE CURSOR TmpSaldg (Emps C(3) NULL, Grupos C(10) NULL, Estos C(10) NULL, ;
                    CPros C(14) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                    Saldo N(12,3) NULL, Disps N(12,3) NULL, Priors N(2,0) NULL, Reservs N(12,3) NULL)
                INDEX ON CPros + CodCors + CodTams + STR(NVL(Priors,0),2) + Grupos + Estos + Emps TAG CPros
                INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro
                SET NULL OFF

                SELECT TmpEstoque
                SCAN
                    SELECT TmpSaldo
                    IF NOT SEEK(ALLTRIM(NVL(TmpEstoque.CPros,"")) + ;
                                ALLTRIM(NVL(TmpEstoque.CodCors,"")) + ;
                                ALLTRIM(NVL(TmpEstoque.CodTams,"")))
                        INSERT INTO TmpSaldo (CPros, CodCors, CodTams, Saldo, Disps) ;
                            VALUES (NVL(TmpEstoque.CPros,""), NVL(TmpEstoque.CodCors,""), ;
                                    NVL(TmpEstoque.CodTams,""), 0, 0)
                    ENDIF
                    REPLACE Saldo WITH NVL(Saldo,0) + NVL(TmpEstoque.SQtds,0), ;
                            Disps WITH NVL(Disps,0) + NVL(TmpEstoque.SQtds,0)

                    INSERT INTO TmpSaldg (Grupos, Estos, CPros, CodCors, CodTams, ;
                        Saldo, Disps, Priors, Emps) ;
                        VALUES (NVL(TmpEstoque.Grupos,""), NVL(TmpEstoque.Estos,""), ;
                                NVL(TmpEstoque.CPros,""), NVL(TmpEstoque.CodCors,""), ;
                                NVL(TmpEstoque.CodTams,""), NVL(TmpEstoque.SQtds,0), ;
                                NVL(TmpEstoque.SQtds,0), NVL(TmpEstoque.Priors,0), ;
                                NVL(TmpEstoque.Emps,""))
                ENDSCAN
            ENDIF

            *-- PASSO 7: Carregar operacao de transferencia e ajustar saldos por reservas
            IF loc_lResultado AND USED("crSigCdPam") AND !EMPTY(ALLTRIM(crSigCdPam.TransfRes))
                SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdOpe WHERE Dopes = '" + ALLTRIM(crSigCdPam.TransfRes) + "'", ;
                    "crSigCdOpe")

                IF USED("crSigCdOpe") AND !EOF("crSigCdOpe") AND NVL(crSigCdOpe.Estoqs, 0) <> 1
                    loc_cPEdI = ALLTRIM(loc_cEmpresa) + ALLTRIM(crSigCdPam.TransfRes) + STR(0, 6)
                    loc_cPEdF = ALLTRIM(loc_cEmpresa) + ALLTRIM(crSigCdPam.TransfRes) + STR(999999, 6)

                    loc_cSQL = "SELECT EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes " + ;
                        "FROM SigMvCab " + ;
                        "WHERE EmpDopNums BETWEEN '" + ALLTRIM(loc_cPEdI) + "' AND '" + ;
                        ALLTRIM(loc_cPEdF) + "' ORDER BY EmpDopNums"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEest") < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (TempEest). Favor reinicializar.", "Erro")
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- PASSO 7b: Ajustar saldos removendo qtds de reservas em transferencia
            IF loc_lResultado AND USED("TempEest") AND RECCOUNT("TempEest") > 0
                SELECT TempEest
                GO TOP
                SCAN
                    IF loc_lResultado
                        loc_lcEdn = ALLTRIM(NVL(TempEest.EmpDopNums,""))

                        IF SQLEXEC(gnConnHandle, ;
                            "SELECT * FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn), ;
                            "TempEestI") < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (TempEestI).", "Erro")
                            loc_lResultado = .F.
                        ENDIF

                        IF loc_lResultado AND USED("TempEestI") AND RECCOUNT("TempEestI") > 0
                            SELECT TempEestI
                            SCAN
                                IF loc_lResultado AND ;
                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0)) > 0

                                    loc_nItn = NVL(TempEestI.CItens, 0)
                                    loc_cSQL = "SELECT * FROM SigMvIts " + ;
                                        "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn) + " " + ;
                                        "AND CItens = " + FormatarNumeroSQL(loc_nItn, 0)

                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2") < 1
                                        MsgErro("Falha na conex" + CHR(227) + "o (TempEsti2). " + ;
                                                "Favor reinicializar.", "Erro")
                                        loc_lResultado = .F.
                                    ENDIF

                                    IF loc_lResultado
                                        SELECT TempEsti2
                                        GO TOP
                                        IF EOF("TempEsti2")
                                            SELECT TmpSaldo
                                            SET ORDER TO CPros
                                            IF NOT SEEK(ALLTRIM(NVL(TempEestI.CPros,"")))
                                                INSERT INTO TmpSaldo (CPros) ;
                                                    VALUES (NVL(TempEestI.CPros,""))
                                            ENDIF
                                            REPLACE Saldo WITH NVL(Saldo,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0)), ;
                                                    Disps WITH NVL(Disps,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0))

                                            SELECT TmpSaldg
                                            SET ORDER TO GruEstPro
                                            IF !SEEK(ALLTRIM(NVL(TempEest.Emps,"")) + ;
                                                     ALLTRIM(NVL(TempEest.GrupoOs,"")) + ;
                                                     ALLTRIM(NVL(TempEest.ContaOs,"")) + ;
                                                     ALLTRIM(NVL(TempEestI.CPros,"")))
                                                INSERT INTO TmpSaldg (Emps, Grupos, Estos, CPros, Priors) ;
                                                    VALUES (NVL(TempEest.Emps,""), NVL(TempEest.GrupoOs,""), ;
                                                            NVL(TempEest.ContaOs,""), NVL(TempEestI.CPros,""), 99)
                                            ENDIF
                                            REPLACE Saldo WITH NVL(Saldo,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0)), ;
                                                    Disps WITH NVL(Disps,0) - ;
                                                    (NVL(TempEestI.Qtds,0) - NVL(TempEestI.QtBaixas,0))
                                        ELSE
                                            SELECT TempEsti2
                                            SCAN
                                                IF loc_lResultado
                                                    loc_nSaldo = NVL(TempEsti2.Qtds,0) - NVL(TempEsti2.QtBaixas,0)
                                                    SELECT TmpSaldo
                                                    IF NOT SEEK(ALLTRIM(NVL(TempEsti2.CPros,"")) + ;
                                                                ALLTRIM(NVL(TempEsti2.CodCors,"")) + ;
                                                                ALLTRIM(NVL(TempEsti2.CodTams,"")))
                                                        INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                                                            VALUES (NVL(TempEsti2.CPros,""), ;
                                                                    NVL(TempEsti2.CodCors,""), ;
                                                                    NVL(TempEsti2.CodTams,""))
                                                    ENDIF
                                                    REPLACE Saldo WITH NVL(Saldo,0) - loc_nSaldo, ;
                                                            Disps WITH NVL(Disps,0) - loc_nSaldo

                                                    SELECT TmpSaldg
                                                    SET ORDER TO GruEstPro
                                                    IF !SEEK(ALLTRIM(NVL(TempEest.Emps,"")) + ;
                                                             ALLTRIM(NVL(TempEest.GrupoOs,"")) + ;
                                                             ALLTRIM(NVL(TempEest.ContaOs,"")) + ;
                                                             ALLTRIM(NVL(TempEsti2.CPros,"")) + ;
                                                             ALLTRIM(NVL(TempEsti2.CodCors,"")) + ;
                                                             ALLTRIM(NVL(TempEsti2.CodTams,"")))
                                                        INSERT INTO TmpSaldg ;
                                                            (Emps, Grupos, Estos, CPros, CodCors, CodTams, Priors) ;
                                                            VALUES (NVL(TempEest.Emps,""), ;
                                                                    NVL(TempEest.GrupoOs,""), ;
                                                                    NVL(TempEest.ContaOs,""), ;
                                                                    NVL(TempEsti2.CPros,""), ;
                                                                    NVL(TempEsti2.CodCors,""), ;
                                                                    NVL(TempEsti2.CodTams,""), 99)
                                                    ENDIF
                                                    REPLACE Saldo WITH NVL(Saldo,0) - loc_nSaldo, ;
                                                            Disps WITH NVL(Disps,0) - loc_nSaldo
                                                ENDIF
                                            ENDSCAN
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 8: Pre-carregar operacoes para lookup no scan principal
            IF loc_lResultado
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdOpe", "cursor_4c_TmpOpe") >= 1
                    SELECT cursor_4c_TmpOpe
                    INDEX ON Dopes TAG Dopes
                ENDIF
            ENDIF

            *-- PASSO 9: Criar TmpFinal e calcular o que produzir por item
            IF loc_lResultado
                SET NULL ON
                CREATE CURSOR TmpFinal (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6,0) NULL, ;
                    CPros C(14) NULL, Qtds N(10,3) NULL, Peso N(9,3) NULL, ;
                    Saldo N(10,3) NULL, Estoque N(10,3) NULL, Produzir N(10,3) NULL, ;
                    Obs M NULL, Obsps M NULL, Datas D NULL, Entregas D NULL, ;
                    CodCors C(4) NULL, CodTams C(4) NULL, Linhas C(10) NULL, ;
                    Citens N(10,0) NULL, Reffs C(40) NULL, Notas C(6) NULL, ;
                    Dpros C(40) NULL, GrupoDs C(10) NULL, ContaDs C(10) NULL, ;
                    KeySelM L NULL, Fabrs N(10,3) NULL, KeyPdes L NULL, Jobs C(10) NULL)
                INDEX ON CPros + CodCors + CodTams TAG CPros
                SET NULL OFF

                SELECT TmpItens
                SET KEY TO
                SET ORDER TO CPros

                SCAN
                    IF loc_lResultado
                        SELECT TmpCabec
                        SET ORDER TO EmpDopNum
                        SEEK ALLTRIM(NVL(TmpItens.Emps,"")) + ;
                             ALLTRIM(NVL(TmpItens.Dopes,"")) + ;
                             STR(NVL(TmpItens.Numes,0), 6)

                        IF !Flag
                            LOOP
                        ENDIF

                        IF NVL(TmpItens.Saldo,0) > 0
                            loc_nEstoque  = 0
                            loc_nProduzir = 0
                            loc_lProduzirTudo = .F.

                            *-- Verificar condicoes para usar estoque ou produzir tudo
                            IF USED("crSigCdPam") AND EMPTY(ALLTRIM(crSigCdPam.TransfRes))
                                loc_lProduzirTudo = .T.
                            ENDIF

                            IF !loc_lProduzirTudo AND USED("cursor_4c_TmpOpe")
                                SELECT cursor_4c_TmpOpe
                                SET ORDER TO Dopes
                                IF SEEK(ALLTRIM(NVL(TmpItens.Dopes,"")))
                                    IF NVL(cursor_4c_TmpOpe.ChkObs,0) <> 1 AND ;
                                        !EMPTY(ALLTRIM(NVL(TmpItens.Obs,"")))
                                        loc_lProduzirTudo = .T.
                                    ENDIF
                                    IF !loc_lProduzirTudo AND ;
                                        NVL(cursor_4c_TmpOpe.Reservas,0) = 2 AND !par_lReserva
                                        loc_lProduzirTudo = .T.
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF !loc_lProduzirTudo
                                SELECT TmpSaldo
                                SET ORDER TO CPros
                                IF !SEEK(ALLTRIM(NVL(TmpItens.CPros,"")) + ;
                                         ALLTRIM(NVL(TmpItens.CodCors,"")) + ;
                                         ALLTRIM(NVL(TmpItens.CodTams,"")))
                                    loc_lProduzirTudo = .T.
                                ELSE
                                    IF NVL(TmpSaldo.Disps,0) < 0
                                        loc_lProduzirTudo = .T.
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF loc_lProduzirTudo
                                loc_nProduzir = NVL(TmpItens.Saldo,0)
                            ELSE
                                *-- Ja posicionado em TmpSaldo pelo SEEK acima
                                loc_nEstoque = NVL(TmpSaldo.Disps,0)
                                IF NVL(TmpSaldo.Disps,0) >= NVL(TmpItens.Saldo,0)
                                    REPLACE TmpSaldo.Disps WITH ;
                                            NVL(TmpSaldo.Disps,0) - NVL(TmpItens.Saldo,0)
                                ELSE
                                    loc_nProduzir = NVL(TmpItens.Saldo,0) - NVL(TmpSaldo.Disps,0)
                                    REPLACE TmpSaldo.Disps WITH 0
                                ENDIF
                            ENDIF

                            IF SQLEXEC(gnConnHandle, ;
                                "SELECT * FROM SigCdPro WHERE CPros = '" + ;
                                ALLTRIM(NVL(TmpItens.CPros,"")) + "'", "crSigCdPro") < 1
                                MsgErro("Falha ao buscar SigCdPro.", "Erro")
                                loc_lResultado = .F.
                            ENDIF

                            IF loc_lResultado
                                INSERT INTO TmpFinal ;
                                    (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, ;
                                     Estoque, Produzir, Obsps, Obs, Datas, Entregas, ;
                                     CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                                     Dpros, GrupoDs, ContaDs, Jobs) ;
                                    VALUES ;
                                    (NVL(TmpItens.Emps,""), NVL(TmpItens.Dopes,""), ;
                                     NVL(TmpItens.Numes,0), NVL(TmpItens.CPros,""), ;
                                     NVL(TmpItens.Qtds,0), NVL(TmpItens.Peso,0), ;
                                     NVL(TmpItens.Saldo,0), ;
                                     NVL(TmpItens.Saldo,0) - loc_nProduzir, ;
                                     loc_nProduzir, ;
                                     NVL(TmpItens.Obs,""), NVL(TmpCabec.Obs,""), ;
                                     NVL(TmpCabec.Datas,{}), NVL(TmpCabec.Entregas,{}), ;
                                     NVL(TmpItens.CodCors,""), NVL(TmpItens.CodTams,""), ;
                                     NVL(TmpItens.Linhas,""), NVL(TmpItens.CItens,0), ;
                                     NVL(crSigCdPro.Reffs,""), NVL(TmpItens.Notas,""), ;
                                     NVL(TmpItens.Dpros,""), NVL(TmpCabec.Grupods,""), ;
                                     NVL(TmpCabec.Contads,""), NVL(TmpCabec.Jobs,""))
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 10: Redistribuir diferenca de saldo entre grupos/estoques
            IF loc_lResultado
                SELECT TmpSaldo
                SCAN
                    IF NVL(TmpSaldo.Saldo,0) <> NVL(TmpSaldo.Disps,0)
                        loc_xBaixa = NVL(TmpSaldo.Saldo,0) - NVL(TmpSaldo.Disps,0)
                        SELECT TmpSaldg
                        SET ORDER TO CPros
                        =SEEK(ALLTRIM(NVL(TmpSaldo.CPros,"")) + ;
                              ALLTRIM(NVL(TmpSaldo.CodCors,"")) + ;
                              ALLTRIM(NVL(TmpSaldo.CodTams,"")))
                        SCAN WHILE ALLTRIM(NVL(CPros,"")) = ALLTRIM(NVL(TmpSaldo.CPros,"")) AND ;
                                    ALLTRIM(NVL(CodCors,"")) = ALLTRIM(NVL(TmpSaldo.CodCors,"")) AND ;
                                    ALLTRIM(NVL(CodTams,"")) = ALLTRIM(NVL(TmpSaldo.CodTams,"")) AND ;
                                    loc_xBaixa > 0
                            IF NVL(TmpSaldg.Disps,0) >= loc_xBaixa
                                REPLACE TmpSaldg.Disps WITH NVL(TmpSaldg.Disps,0) - loc_xBaixa
                                loc_xBaixa = 0
                            ELSE
                                loc_xBaixa = loc_xBaixa - NVL(TmpSaldg.Disps,0)
                                REPLACE TmpSaldg.Disps WITH 0
                            ENDIF
                        ENDSCAN
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 11: Se ha fabricacao estimada (DopEsts), calcular TmpFinalG
            IF loc_lResultado AND USED("crSigCdPac") AND !EMPTY(ALLTRIM(crSigCdPac.DopEsts))
                THIS.this_lTemEstimado = .T.
                loc_llFalse = .F.

                SET NULL ON
                CREATE CURSOR TmpFabr (Priors N(2,0) NULL, Nops N(10,0) NULL, Fases C(10) NULL, ;
                    CPros C(14) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                    Qtds N(10,3) NULL, Disps N(12,3) NULL, Reservs N(12,3) NULL)
                INDEX ON CPros + CodCors + CodTams + STR(NVL(Priors,0),2) + STR(NVL(Nops,0),10) TAG CPros
                SET NULL OFF

                loc_cSQL = "SELECT a.Nops, a.CPros, a.CodCors, a.CodTams, SUM(a.Qtds) AS Qtds " + ;
                    "FROM SigOpPic a, SigCdNec b " + ;
                    "WHERE a.Dopes = '" + ALLTRIM(crSigCdPac.DopEsts) + "' " + ;
                    "AND a.EmpDopNops = b.EmpDnps " + ;
                    "AND b.Chksubn = " + IIF(loc_llFalse, "1", "0") + " " + ;
                    "AND a.Emps = '" + ALLTRIM(loc_cEmpresa) + "' " + ;
                    "GROUP BY a.Nops, a.CPros, a.CodCors, a.CodTams"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOpi") >= 1 AND ;
                    USED("TmpOpi") AND RECCOUNT("TmpOpi") > 0

                    SELECT TmpOpi
                    SCAN
                        IF loc_lResultado
                            SELECT TmpSaldo
                            SET ORDER TO CPros
                            IF NOT SEEK(ALLTRIM(NVL(TmpOpi.CPros,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodCors,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodTams,"")))
                                INSERT INTO TmpSaldo (CPros, CodCors, CodTams) ;
                                    VALUES (NVL(TmpOpi.CPros,""), NVL(TmpOpi.CodCors,""), ;
                                            NVL(TmpOpi.CodTams,""))
                            ENDIF
                            REPLACE Fabrs WITH NVL(Fabrs,0) + NVL(TmpOpi.Qtds,0), ;
                                    DispFs WITH NVL(DispFs,0) + NVL(TmpOpi.Qtds,0)

                            INSERT INTO TmpFabr (Nops, CPros, CodCors, CodTams, Qtds, Priors) ;
                                VALUES (NVL(TmpOpi.Nops,0), NVL(TmpOpi.CPros,""), ;
                                        NVL(TmpOpi.CodCors,""), NVL(TmpOpi.CodTams,""), ;
                                        NVL(TmpOpi.Qtds,0), 0)

                            loc_cSQL = "SELECT GrupoDs FROM SigPdMvf " + ;
                                "WHERE Nops = " + FormatarNumeroSQL(NVL(TmpOpi.Nops,0), 0) + ;
                                " ORDER BY CidChaves DESC"
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpMfas") >= 1 AND ;
                                USED("TmpMfas") AND RECCOUNT("TmpMfas") > 0
                                SELECT TmpMfas
                                GO TOP
                                REPLACE Fases WITH ALLTRIM(NVL(TmpMfas.GrupoDs,"")) IN TmpFabr
                            ENDIF

                            loc_nEstoque  = 0
                            loc_nProduzir = 0

                            SELECT TmpSaldo
                            IF SEEK(ALLTRIM(NVL(TmpOpi.CPros,"")) + ;
                                    ALLTRIM(NVL(TmpOpi.CodCors,"")) + ;
                                    ALLTRIM(NVL(TmpOpi.CodTams,"")))

                                SELECT TmpFinal
                                IF SEEK(ALLTRIM(NVL(TmpOpi.CPros,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodCors,"")) + ;
                                        ALLTRIM(NVL(TmpOpi.CodTams,"")), "TmpFinal", "CPros")

                                    IF NVL(TmpSaldo.Fabrs,0) >= NVL(TmpFinal.Produzir,0)
                                        loc_nEstoque  = NVL(TmpFinal.Produzir,0)
                                        loc_nProduzir = 0
                                        SELECT TmpSaldo
                                        REPLACE DispFs WITH NVL(DispFs,0) - NVL(TmpFinal.Produzir,0)
                                    ELSE
                                        loc_nEstoque  = NVL(TmpSaldo.Fabrs,0)
                                        loc_nProduzir = NVL(TmpFinal.Produzir,0) - NVL(TmpSaldo.Fabrs,0)
                                        SELECT TmpSaldo
                                        REPLACE DispFs WITH 0
                                    ENDIF

                                    REPLACE Produzir WITH loc_nProduzir, ;
                                            Fabrs WITH loc_nEstoque IN TmpFinal
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN

                    *-- Redistribuir diferenca de fabricacao
                    SELECT TmpSaldo
                    SCAN
                        IF NVL(TmpSaldo.Fabrs,0) <> NVL(TmpSaldo.DispFs,0)
                            loc_xBaixa = NVL(TmpSaldo.Fabrs,0) - NVL(TmpSaldo.DispFs,0)
                            SELECT TmpFabr
                            SET ORDER TO CPros
                            =SEEK(ALLTRIM(NVL(TmpSaldo.CPros,"")) + ;
                                  ALLTRIM(NVL(TmpSaldo.CodCors,"")) + ;
                                  ALLTRIM(NVL(TmpSaldo.CodTams,"")))
                            SCAN WHILE ALLTRIM(NVL(CPros,"")) = ALLTRIM(NVL(TmpSaldo.CPros,"")) AND ;
                                        ALLTRIM(NVL(CodCors,"")) = ALLTRIM(NVL(TmpSaldo.CodCors,"")) AND ;
                                        ALLTRIM(NVL(CodTams,"")) = ALLTRIM(NVL(TmpSaldo.CodTams,"")) AND ;
                                        loc_xBaixa > 0
                                IF (NVL(TmpFabr.Qtds,0) - NVL(TmpFabr.Disps,0)) >= loc_xBaixa
                                    REPLACE TmpFabr.Disps WITH NVL(TmpFabr.Disps,0) + loc_xBaixa
                                    loc_xBaixa = 0
                                ELSE
                                    loc_xBaixa = loc_xBaixa - (NVL(TmpFabr.Qtds,0) - NVL(TmpFabr.Disps,0))
                                    REPLACE TmpFabr.Disps WITH NVL(TmpFabr.Qtds,0)
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDSCAN

                    *-- Criar TmpFinalG com agrupamentos
                    SET NULL ON
                    CREATE CURSOR TmpFinalG (Flag C(1) NULL, CPros C(14) NULL, ;
                        CodCors C(4) NULL, CodTams C(4) NULL, Linhas C(10) NULL, ;
                        Qtds N(10,3) NULL, Saldo N(10,3) NULL, Estoque N(10,3) NULL, ;
                        Produzir N(10,3) NULL, Fabrs N(10,3) NULL, Produzir2 N(10,3) NULL, ;
                        TotVenda N(10,3) NULL, QtdMins N(10,3) NULL, ;
                        KeySelM L NULL, KeySelMP L NULL, UsuLibs C(10) NULL)
                    INDEX ON CPros + CodCors + CodTams TAG CPros
                    SET NULL OFF

                    *-- Calcular vendas recentes se configurado
                    IF NVL(crSigCdPac.nMeses, 0) > 0
                        loc_llData = GOMONTH(DATE(), -INT(crSigCdPac.nMeses))
                        loc_cSQL = "SELECT a.CPros, a.Qtds, b.Caixas, b.Copers, b.Opers, a.Opers " + ;
                            "FROM SigMvItn a, SigCdOpe b, SigMvCab c " + ;
                            "WHERE a.EmpDopNums = c.EmpDopNums " + ;
                            "AND a.Emps = '" + ALLTRIM(loc_cEmpresa) + "' " + ;
                            "AND c.Datas >= ?loc_llData " + ;
                            "AND a.Dopes = b.Dopes AND b.TipoOps IN (4,5)"

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalEest") >= 1
                            SELECT CPros, ;
                                SUM(Qtds * IIF((NVL(Caixas,0)=1 AND NVL(Copers,0)=1) OR ;
                                    (NVL(Caixas,0)<>1 AND NVL(Opers,0)=1) OR ;
                                    (NVL(Caixas,0)<>1 AND NVL(Opers,0)=3), 1, -1)) AS Qtds ;
                                FROM LocalEest ;
                                GROUP BY CPros ;
                                INTO CURSOR Vendas READWRITE
                            SELECT Vendas
                            INDEX ON CPros TAG CPros
                        ENDIF
                    ENDIF

                    *-- Popular TmpFinalG com agrupamentos
                    SELECT CPros, CodCors, CodTams, Linhas, ;
                        SUM(NVL(Qtds,0)) AS Qtds, SUM(NVL(Saldo,0)) AS Saldo, ;
                        SUM(NVL(Estoque,0)) AS Estoque, SUM(NVL(Produzir,0)) AS Produzir, ;
                        SUM(NVL(Fabrs,0)) AS Fabrs ;
                        FROM TmpFinal ;
                        INTO CURSOR Selecao ;
                        GROUP BY CPros, CodCors, CodTams, Linhas

                    SELECT Selecao
                    SCAN
                        IF loc_lResultado
                            SCATTER MEMVAR
                            m.Flag = "+"

                            IF SQLEXEC(gnConnHandle, ;
                                "SELECT QtMinFabs FROM SigCdPro WHERE CPros = '" + ;
                                ALLTRIM(NVL(m.CPros,"")) + "'", "CrSigCdPro") < 1
                                MsgErro("Falha ao buscar QtMinFabs de SigCdPro.", "Erro")
                                loc_lResultado = .F.
                            ENDIF

                            IF loc_lResultado
                                m.QtdMins = 0
                                IF (NVL(crSigCdPac.GerPcps,0) = 2 AND !par_lReserva) OR ;
                                    (NVL(crSigCdPac.GerPcps,0) <> 2 AND par_lReserva)
                                    m.QtdMins = NVL(CrSigCdPro.QtMinFabs, 0)
                                ENDIF

                                m.TotVenda = 0
                                IF USED("Vendas") AND ;
                                    SEEK(ALLTRIM(NVL(m.CPros,"")), "Vendas", "CPros")
                                    m.TotVenda = NVL(Vendas.Qtds, 0)
                                ENDIF

                                m.Produzir2 = IIF(m.QtdMins > 0 AND m.Produzir > 0 AND ;
                                    m.Produzir < m.QtdMins, m.QtdMins - m.Produzir, 0)

                                SELECT TmpFinalG
                                APPEND BLANK
                                GATHER MEMVAR
                            ENDIF
                        ENDIF
                    ENDSCAN
                ENDIF
            ELSE
                THIS.this_lTemEstimado = .F.
            ENDIF

            *-- Restaurar ordem de TmpItens para o form
            IF loc_lResultado AND USED("TmpItens") AND USED("TmpCabec")
                SELECT TmpItens
                SET ORDER TO EmpDopNum
                SET KEY TO ALLTRIM(NVL(TmpCabec.Emps,"")) + ;
                           ALLTRIM(NVL(TmpCabec.Dopes,"")) + ;
                           STR(NVL(TmpCabec.Numes,0), 6)
                GO TOP
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ProcessarOperacoes")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarOperacoes - Aplica ordenacao no cursor TmpCabec e atualiza
    * this_cOrdConta. O form usa this_cOrdConta para atualizar cores dos headers.
    * Parametros: par_cOrdem - "EMPDOPNUM" ou "ENTREGA" (ou vazio para padrao)
    * Retorno: .T. se ok
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarOperacoes(par_cOrdem)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cOrdem

        loc_lResultado = .T.

        TRY
            loc_cOrdem = UPPER(IIF(VARTYPE(par_cOrdem) = "C" AND !EMPTY(par_cOrdem), ;
                                   par_cOrdem, THIS.this_cOrdConta))

            IF USED("TmpCabec")
                SELECT TmpCabec
                IF !EMPTY(loc_cOrdem) AND INLIST(loc_cOrdem, "ENTREGA", "EMPDOPNUM")
                    SET ORDER TO &loc_cOrdem.
                ELSE
                    SET ORDER TO EmpDopNum
                ENDIF
                THIS.this_cOrdConta = UPPER(ORDER("TmpCabec"))
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro OrdenarOperacoes")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega registro SigTempd do cursor para propriedades
    * Usado para reidratar sessao ativa da tabela de trabalho SigTempd.
    * Parametro: par_cAliasCursor - alias do cursor contendo colunas de SigTempd
    * Retorno: .T. se carregou registro valido, .F. se cursor vazio/inexistente
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_oErro

        loc_lResultado = .F.
        loc_cAlias     = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                             par_cAliasCursor, "cursor_4c_SigTempd")

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                IF !EOF() AND !BOF()
                    THIS.this_cCidChaves = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CidChaves"), ""))
                    THIS.this_cCidQuerys = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".CidQuerys"), ""))
                    THIS.this_cGrupos    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Grupos"), ""))
                    THIS.this_cContas    = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Contas"), ""))
                    THIS.this_cEmps      = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".Emps"), ""))
                    THIS.this_nCodObs    = NVL(EVALUATE(loc_cAlias + ".CodObs"), 0)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CarregarDoCursor")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o CidChaves atual (PK da entidade SigTempd)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigTempd para registrar entrada de sessao de OPs.
    * Gera CidChaves/CidQuerys via fUniqueIds() se estiverem vazios.
    * Utilizado no fluxo de geracao para persistir prioridades de estoque
    * que serao consumidas no join com SigMvEst durante ProcessarOperacoes.
    * Retorno: .T. sucesso, .F. erro (mensagem em this_cMensagemErro)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro

        loc_lResultado = .F.

        TRY
            *-- Gerar identificadores se ainda nao definidos
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCidQuerys))
                THIS.this_cCidQuerys = fUniqueIds()
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cEmps))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            loc_cSQL = "INSERT INTO SigTempd " + ;
                "(CidChaves, CidQuerys, Grupos, Contas, CodObs, Emps, Dpros) VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCidQuerys)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCodObs, 0) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                EscaparSQL("") + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                *-- Registra auditoria de insercao (herdado de BusinessBase)
                THIS.RegistrarAuditoria("I")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigTempd. " + ;
                    "Favor reinicializar o processo."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Inserir SigTempd")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigTempd para alterar registro de sessao ativa.
    * Localiza pelo CidChaves atual e sobrescreve Grupos/Contas/CodObs/Emps.
    * Retorno: .T. sucesso, .F. erro (mensagem em this_cMensagemErro)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro

        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia. " + ;
                    "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                    "vel atualizar SigTempd."
            ELSE
                loc_cSQL = "UPDATE SigTempd SET " + ;
                    "Grupos    = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                    "Contas    = " + EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", " + ;
                    "CodObs    = " + FormatarNumeroSQL(THIS.this_nCodObs, 0) + ", " + ;
                    "Emps      = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                    "CidQuerys = " + EscaparSQL(ALLTRIM(THIS.this_cCidQuerys)) + " " + ;
                    "WHERE CidChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                    *-- Registra auditoria de alteracao (herdado de BusinessBase)
                    THIS.RegistrarAuditoria("A")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar registro em SigTempd " + ;
                        "(CidChaves=" + ALLTRIM(THIS.this_cCidChaves) + ")."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Atualizar SigTempd")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigTempd pelo CidChaves atual.
    * Usado para limpar registros de sessao apos processamento concluido.
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro

        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria vazia."
            ELSE
                loc_cSQL = "DELETE FROM SigTempd WHERE CidChaves = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("E")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao excluir SigTempd."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ExecutarExclusao SigTempd")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

