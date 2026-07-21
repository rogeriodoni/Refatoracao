# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, CPROS, LINHAS, QMINS, SITUAS, DOPES, GLOBALIZAS, EMPDOPNUMS, DIFPRODS, ESTOS, SQTDS, GRUPODS, CONTADS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, CPROS, LINHAS, QMINS, SITUAS, DOPES, GLOBALIZAS, EMPDOPNUMS, DIFPRODS, ESTOS, SQTDS, GRUPODS, CONTADS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, CPROS, LINHAS, QMINS, SITUAS, DOPES, GLOBALIZAS, EMPDOPNUMS, DIFPRODS, ESTOS, SQTDS, GRUPODS, CONTADS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, CPROS, LINHAS, QMINS, SITUAS, DOPES, GLOBALIZAS, EMPDOPNUMS, DIFPRODS, ESTOS, SQTDS, GRUPODS, CONTADS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, GRUPOS, CPROS, LINHAS, QMINS, SITUAS, DOPES, GLOBALIZAS, EMPDOPNUMS, DIFPRODS, ESTOS, SQTDS, GRUPODS, CONTADS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lcQryEest = [Select * From SigMvCab]
lcQryEesti = [Select * From SigMvItn]
lcQrySigCdLin = [Select descs,linhas,pedidos From SigCdLin Order By descs,linhas,pedidos ]
		Select crSigCdLin
	Select crSigCdLin
	If !Seek( This.Value )
	Select crSigCdLin
	If !Seek( This.Value )
Select crSigCdLin
If !Seek( lcLinha )
	lcQuery = [	Select E.Emps, E.Grupos, E.Estos, E.CPros, E.SQtds,]+;
			  [ From SigMvEst E, SigCdPro P ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTemp1') < 1)
	lcQuery = [ Select CPros, QMins, IFors, PVens, Moevs, Dpros ]+;
		[	From SigCdPro ]+;
		[		Not In (Select empgruests+Cpros as Chave From SigMvEst ) ]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTemp2') < 1)
	Select Emps, Grupos, Estos, CPros, SQtds, QMins, QMins - SQtds As DifProds, IFors, PVens, Moevs, Dpros ;
		From crTemp1 ;
	Select lcEmpresa as Emps, lcGrupo as Grupos, lcConta as Estos, CPros, 000000000.00 as SQtds, QMins,;
		From CrTemp2 ;
	lcQuery = [ Select E.Emps, E.Grupos, E.Estos, E.CPros, E.SQtds, ]+;
			  [ From SigMvEst E, SigCdPro P ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTemp3') < 1)
	Select Emps, Grupos, Estos, CPros, SQtds, 0 as QMins,;
		From crTemp3 ;
Select TmpMinimo
lcQuery = [Select I.CPros, I.Qtds, I.QtBxProds, I.empdopnums, E.empdopnums, E.Grupods, E.Contads, E.Dopes, E.Emps, ] + ;
		  [	From SigMvCab E, SigMvItn I, SigCdOpe O ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTemp4') < 1)
Select CPros, Sum(Qtds - QtBxProds) As Produzindo ;
  From crTemp4 ;
Select TmpPedidos
Select TmpMinimo
Select M.CPros, M.IFors, M.PVens, M.Moevs, M.Dpros,;
	From TmpMinimo M Left Join TmpPedidos P On M.CPros = P.CPros ;
Select TmpProd
Select TmpProd
Select TmpProd
	loBarra.Update( .t. )
		lcQuery = [Select Dopes, GruOrigs, Opers ] + ;
		    [ From SigCdOpe ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdOpe') < 1)
		Select TmpProd
		Insert Into crSigMvCab ( Emps, Dopes, Numes, Datas, Datars, MascNum,;
		Select crSigMvCab
	Insert Into crSigMvItn ( Emps, Dopes, Numes, CItens, CPros, Qtds, Units, Moedas, opers, totas, dpros, EmpDopNums, CidChaves, DtAlts ) ;
	Select crSigMvCab
Select Min(Datas) as Datas From CrSigMvCab Into Cursor TmpGdm
If Not ThisForm.poDataMgr.Update('crSigMvCab')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
If Not ThisForm.poDataMgr.Update('crSigMvItn')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvItn)')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGmi.prg) - TRECHOS RELEVANTES PARA PASS SQL (1169 linhas total):

*-- Linhas 703 a 728:
703:             RETURN
704:         ENDIF
705:         TRY
706:             loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
707:                 EscaparSQL(PADR(loc_cCod, 3))
708:             IF USED("cursor_4c_EmpTmp")
709:                 USE IN cursor_4c_EmpTmp
710:             ENDIF
711:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")
712:             IF loc_nResultado >= 1
713:                 SELECT cursor_4c_EmpTmp
714:                 IF !EOF("cursor_4c_EmpTmp")
715:                     THIS.txt_4c_CdEmpresa.Value = ALLTRIM(NVL(cursor_4c_EmpTmp.Cemps, ""))
716:                     THIS.txt_4c_DsEmpresa.Value = ALLTRIM(NVL(cursor_4c_EmpTmp.Razas, ""))
717:                     USE IN cursor_4c_EmpTmp
718:                     RETURN
719:                 ENDIF
720:                 USE IN cursor_4c_EmpTmp
721:             ENDIF
722:             THIS.AbrirBuscaEmpresa("C", loc_cCod)
723:         CATCH TO loc_oErro
724:             MsgErro(loc_oErro.Message, "Erro TxtCdEmpresaKeyPress")
725:         ENDTRY
726:     ENDPROC
727: 
728:     *==========================================================================

*-- Linhas 744 a 772:
744:         TRY
745:             IF par_cModo = "C"
746:                 loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
747:                     "WHERE Cemps LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
748:             ELSE
749:                 loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
750:                     "WHERE RTRIM(Razas) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
751:             ENDIF
752:             loc_cSQL = "SELECT TOP 200 Cemps, Razas FROM SigCdEmp " + loc_cWhere + " ORDER BY Cemps"
753: 
754:             IF USED("cursor_4c_BuscaEmp")
755:                 USE IN cursor_4c_BuscaEmp
756:             ENDIF
757:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
758:             IF loc_nResultado < 1
759:                 RETURN
760:             ENDIF
761: 
762:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
763:                 "cursor_4c_BuscaEmp", IIF(par_cModo = "C", "Cemps", "Razas"), "", ;
764:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T., .T., "")
765:             loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
766:             loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
767:             loc_oBusca.Show()
768: 
769:             IF loc_oBusca.this_lSelecionou
770:                 THIS.txt_4c_CdEmpresa.Value = ALLTRIM(NVL(cursor_4c_BuscaEmp.Cemps, ""))
771:                 THIS.txt_4c_DsEmpresa.Value = ALLTRIM(NVL(cursor_4c_BuscaEmp.Razas, ""))
772:             ENDIF

*-- Linhas 794 a 819:
794:             RETURN
795:         ENDIF
796:         TRY
797:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
798:                 EscaparSQL(PADR(loc_cCod, 10))
799:             IF USED("cursor_4c_GrTmp")
800:                 USE IN cursor_4c_GrTmp
801:             ENDIF
802:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrTmp")
803:             IF loc_nResultado >= 1
804:                 SELECT cursor_4c_GrTmp
805:                 IF !EOF("cursor_4c_GrTmp")
806:                     THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(NVL(cursor_4c_GrTmp.codigos, ""))
807:                     THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(NVL(cursor_4c_GrTmp.descrs, ""))
808:                     USE IN cursor_4c_GrTmp
809:                     RETURN
810:                 ENDIF
811:                 USE IN cursor_4c_GrTmp
812:             ENDIF
813:             THIS.AbrirBuscaGrEstoque("C", loc_cCod)
814:         CATCH TO loc_oErro
815:             MsgErro(loc_oErro.Message, "Erro TxtCdGrEstoqueKeyPress")
816:         ENDTRY
817:     ENDPROC
818: 
819:     *==========================================================================

*-- Linhas 836 a 864:
836:         TRY
837:             IF par_cModo = "C"
838:                 loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
839:                     "WHERE codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
840:             ELSE
841:                 loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
842:                     "WHERE RTRIM(descrs) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
843:             ENDIF
844:             loc_cSQL = "SELECT TOP 200 codigos, descrs FROM SigCdGcr " + loc_cWhere + " ORDER BY codigos"
845: 
846:             IF USED("cursor_4c_BuscaGcr")
847:                 USE IN cursor_4c_BuscaGcr
848:             ENDIF
849:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")
850:             IF loc_nResultado < 1
851:                 RETURN
852:             ENDIF
853: 
854:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
855:                 "cursor_4c_BuscaGcr", IIF(par_cModo = "C", "codigos", "descrs"), "", ;
856:                 "Sele" + CHR(231) + CHR(227) + "o de Grupo de Estoque", .T., .T., "")
857:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
858:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
859:             loc_oBusca.Show()
860: 
861:             IF loc_oBusca.this_lSelecionou
862:                 THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(NVL(cursor_4c_BuscaGcr.codigos, ""))
863:                 THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(NVL(cursor_4c_BuscaGcr.descrs, ""))
864:             ENDIF

*-- Linhas 887 a 915:
887:             RETURN
888:         ENDIF
889:         TRY
890:             loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
891:                 EscaparSQL(PADR(loc_cCod, 10))
892:             IF !EMPTY(loc_cGrp)
893:                 loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrp, 10))
894:             ENDIF
895:             IF USED("cursor_4c_EstTmp")
896:                 USE IN cursor_4c_EstTmp
897:             ENDIF
898:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstTmp")
899:             IF loc_nResultado >= 1
900:                 SELECT cursor_4c_EstTmp
901:                 IF !EOF("cursor_4c_EstTmp")
902:                     THIS.txt_4c_CdEstoque.Value = ALLTRIM(NVL(cursor_4c_EstTmp.IClis, ""))
903:                     THIS.txt_4c_DsEstoque.Value = ALLTRIM(NVL(cursor_4c_EstTmp.RClis, ""))
904:                     USE IN cursor_4c_EstTmp
905:                     RETURN
906:                 ENDIF
907:                 USE IN cursor_4c_EstTmp
908:             ENDIF
909:             THIS.AbrirBuscaEstoque("C", loc_cGrp, loc_cCod)
910:         CATCH TO loc_oErro
911:             MsgErro(loc_oErro.Message, "Erro TxtCdEstoqueKeyPress")
912:         ENDTRY
913:     ENDPROC
914: 
915:     *==========================================================================

*-- Linhas 931 a 970:
931:         LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere, loc_cWhereGrp
932:         TRY
933:             loc_cWhereGrp = IIF(EMPTY(ALLTRIM(par_cGrupo)), "", ;
934:                 " AND Grupos = " + EscaparSQL(PADR(ALLTRIM(par_cGrupo), 10)))
935:             IF par_cModo = "C"
936:                 IF EMPTY(ALLTRIM(par_cValor)) AND !EMPTY(ALLTRIM(par_cGrupo))
937:                     loc_cWhere = "WHERE Grupos = " + EscaparSQL(PADR(ALLTRIM(par_cGrupo), 10))
938:                 ELSE
939:                     loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
940:                         "WHERE IClis LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + loc_cWhereGrp)
941:                 ENDIF
942:             ELSE
943:                 IF EMPTY(ALLTRIM(par_cValor)) AND !EMPTY(ALLTRIM(par_cGrupo))
944:                     loc_cWhere = "WHERE Grupos = " + EscaparSQL(PADR(ALLTRIM(par_cGrupo), 10))
945:                 ELSE
946:                     loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
947:                         "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + loc_cWhereGrp)
948:                 ENDIF
949:             ENDIF
950:             loc_cSQL = "SELECT TOP 200 IClis, RClis FROM SigCdCli " + loc_cWhere + " ORDER BY IClis"
951: 
952:             IF USED("cursor_4c_BuscaEst")
953:                 USE IN cursor_4c_BuscaEst
954:             ENDIF
955:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
956:             IF loc_nResultado < 1
957:                 RETURN
958:             ENDIF
959: 
960:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
961:                 "cursor_4c_BuscaEst", IIF(par_cModo = "C", "IClis", "RClis"), "", ;
962:                 "Sele" + CHR(231) + CHR(227) + "o de Estoque", .T., .T., "")
963:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
964:             loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
965:             loc_oBusca.Show()
966: 
967:             IF loc_oBusca.this_lSelecionou
968:                 THIS.txt_4c_CdEstoque.Value = ALLTRIM(NVL(cursor_4c_BuscaEst.IClis, ""))
969:                 THIS.txt_4c_DsEstoque.Value = ALLTRIM(NVL(cursor_4c_BuscaEst.RClis, ""))
970:             ENDIF

*-- Linhas 992 a 1010:
992:             RETURN
993:         ENDIF
994:         IF USED("cursor_4c_SigCdLin")
995:             SELECT cursor_4c_SigCdLin
996:             SET ORDER TO TAG linhas
997:             IF SEEK(PADR(loc_cCod, 10), "cursor_4c_SigCdLin", "linhas")
998:                 THIS.txt_4c_Linha.Value   = ALLTRIM(NVL(cursor_4c_SigCdLin.linhas, ""))
999:                 THIS.txt_4c_DsLinha.Value = ALLTRIM(NVL(cursor_4c_SigCdLin.descs, ""))
1000:                 RETURN
1001:             ENDIF
1002:         ENDIF
1003:         THIS.AbrirBuscaLinha("C", loc_cCod)
1004:     ENDPROC
1005: 
1006:     *==========================================================================
1007:     * TxtDsLinhaKeyPress - Lookup linha de producao por descricao
1008:     *==========================================================================
1009:     PROCEDURE TxtDsLinhaKeyPress
1010:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

*-- Linhas 1022 a 1050:
1022:         TRY
1023:             IF par_cModo = "C"
1024:                 loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
1025:                     "WHERE linhas LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
1026:             ELSE
1027:                 loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
1028:                     "WHERE RTRIM(descs) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
1029:             ENDIF
1030:             loc_cSQL = "SELECT TOP 200 linhas, descs FROM SigCdLin " + loc_cWhere + " ORDER BY descs"
1031: 
1032:             IF USED("cursor_4c_BuscaLinha")
1033:                 USE IN cursor_4c_BuscaLinha
1034:             ENDIF
1035:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLinha")
1036:             IF loc_nResultado < 1
1037:                 RETURN
1038:             ENDIF
1039: 
1040:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
1041:                 "cursor_4c_BuscaLinha", IIF(par_cModo = "C", "linhas", "descs"), "", ;
1042:                 "Sele" + CHR(231) + CHR(227) + "o de Linha de Produ" + CHR(231) + CHR(227) + "o", .T., .T., "")
1043:             loc_oBusca.mAddColuna("linhas", "", "C" + CHR(243) + "digo")
1044:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1045:             loc_oBusca.Show()
1046: 
1047:             IF loc_oBusca.this_lSelecionou
1048:                 THIS.txt_4c_Linha.Value   = ALLTRIM(NVL(cursor_4c_BuscaLinha.linhas, ""))
1049:                 THIS.txt_4c_DsLinha.Value = ALLTRIM(NVL(cursor_4c_BuscaLinha.descs, ""))
1050:             ENDIF


### BO (C:\4c\projeto\app\classes\SigPrGmiBO.prg):
*=============================================================================
* SigPrGmiBO.prg - Business Object: Geracao de Pedido de Estoque Minimo
* Herda de BusinessBase
*=============================================================================

DEFINE CLASS SigPrGmiBO AS BusinessBase

    *-- Filtros do formulario
    this_cEmpresa     = ""   && SigCdEmp.Cemps char(3)
    this_cDsEmpresa   = ""   && SigCdEmp.Razas char(40)
    this_cGrEstoque   = ""   && Grupo de Estoque - codigo char(10)
    this_cDsGrEstoque = ""   && Grupo de Estoque - descricao
    this_cEstoque     = ""   && Conta de Estoque - codigo char(10)
    this_cDsEstoque   = ""   && Conta de Estoque - descricao
    this_cLinha       = ""   && SigCdLin.linhas - codigo char(10)
    this_cDsLinha     = ""   && SigCdLin.descs - descricao char(40)
    this_cNegativo    = "N"  && S = somente saldos negativos
    this_dDatai       = {}   && Data de geracao do pedido
    this_cOperacao    = ""   && SigCdLin.pedidos - operacao associada a linha

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor crSigCdLin para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cLinha    = TratarNulo(linhas, "C")
                THIS.this_cDsLinha  = TratarNulo(descs, "C")
                THIS.this_cOperacao = TratarNulo(pedidos, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmpresa, 3) + PADR(THIS.this_cOperacao, 20) + SPACE(6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursorLinhas - Carrega cursor cursor_4c_SigCdLin para lookup
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCursorLinhas()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT descs, linhas, pedidos FROM SigCdLin ORDER BY descs, linhas, pedidos"
            IF USED("cursor_4c_SigCdLin")
                USE IN cursor_4c_SigCdLin
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdLin") > 0
                SELECT cursor_4c_SigCdLin
                INDEX ON DESCS TAG DESCS
                INDEX ON linhas TAG linhas
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar linhas de produ" + CHR(231) + CHR(227) + "o"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios do filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Empresa"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cGrEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar o Grupo de Estoque"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cEstoque))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Conta de Estoque"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cLinha))
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Linha de Produ" + CHR(231) + CHR(227) + "o"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatai)
            THIS.this_cMensagemErro = CHR(201) + " obrigat" + CHR(243) + "rio informar a Data de Gera" + CHR(231) + CHR(227) + "o"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera pedidos de estoque minimo (acao principal do formulario)
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !THIS.ValidarDados()
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF
            loc_lResultado = THIS.ProcessarPedido()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar pedido")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPedido - Logica completa de geracao de pedidos de estoque minimo
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPedido()
        LOCAL loc_lResultado, loc_cSQL, loc_lTransacaoAberta
        LOCAL loc_cEmpresa, loc_cGrEstoque, loc_cEstoque, loc_cLinha, loc_cNegativo
        LOCAL loc_cOperacao, loc_cGruOrigs, loc_nOpers
        LOCAL loc_nNumero, loc_lnItens, loc_cFornece, loc_cEmpDopNums, loc_cMascNum
        LOCAL loc_cOpers, loc_nIncVal, loc_nTotalReg, loc_cChave
        LOCAL loc_loBarra
        LOCAL loc_cScanCPros, loc_cScanIFors, loc_nScanPVens
        LOCAL loc_cScanMoevs, loc_cScanDpros, loc_nScanQtds

        loc_lResultado       = .F.
        loc_lTransacaoAberta = .F.
        loc_loBarra          = .NULL.
        loc_nNumero          = 0
        loc_lnItens          = 0

        TRY
            *-- Copiar propriedades para vars locais
            loc_cEmpresa   = THIS.this_cEmpresa
            loc_cGrEstoque = THIS.this_cGrEstoque
            loc_cEstoque   = THIS.this_cEstoque
            loc_cLinha     = ALLTRIM(THIS.this_cLinha)
            loc_cNegativo  = THIS.this_cNegativo

            *-- Verificar se a linha possui operacao cadastrada
            loc_cSQL = "SELECT linhas, pedidos FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cLinha)
            IF USED("cursor_4c_LinhaOpe")
                USE IN cursor_4c_LinhaOpe
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhaOpe") < 1 OR RECCOUNT("cursor_4c_LinhaOpe") = 0
                MsgAviso("Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o est" + CHR(225) + " cadastrada...", "Aten" + CHR(231) + CHR(227) + "o")
                IF USED("cursor_4c_LinhaOpe")
                    USE IN cursor_4c_LinhaOpe
                ENDIF
                loc_lResultado = .F.
            ENDIF
            SELECT cursor_4c_LinhaOpe
            IF EMPTY(ALLTRIM(pedidos))
                MsgAviso("Esta Linha de Produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o possui uma Opera" + CHR(231) + CHR(227) + "o cadastrada...", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN cursor_4c_LinhaOpe
                loc_lResultado = .F.
            ENDIF
            loc_cOperacao    = ALLTRIM(pedidos)
            THIS.this_cOperacao = loc_cOperacao
            USE IN cursor_4c_LinhaOpe

            *-- Branch: somente negativos ou abaixo do minimo
            IF ALLTRIM(loc_cNegativo) # "S"

                *-- Ramo 1: Produtos com saldo abaixo do estoque minimo
                loc_cSQL = "SELECT E.emps, E.grupos, E.estos, E.cpros, E.sqtds, " + ;
                    "P.linhas, P.situas, P.qmins, P.ifors, P.pvens, P.moevs, P.dpros " + ;
                    "FROM SigMvEst E " + ;
                    "JOIN SigCdPro P ON E.cpros = P.cpros " + ;
                    "WHERE E.emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.grupos = " + EscaparSQL(loc_cGrEstoque) + ;
                    " AND E.estos = " + EscaparSQL(loc_cEstoque) + ;
                    " AND E.sqtds < P.qmins" + ;
                    " AND P.linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.situas = 1 AND P.qmins > 0 " + ;
                    "ORDER BY E.emps, E.grupos, E.estos, E.cpros"
                IF USED("cursor_4c_Temp1")
                    USE IN cursor_4c_Temp1
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp1") < 1
                    MsgErro("Falha na consulta de estoques abaixo do m" + CHR(237) + "nimo", "Erro")
                    loc_lResultado = .F.
                ENDIF

                *-- Produtos que NAO tem registro em SigMvEst para esta empresa/grupo/conta
                loc_cChave = PADR(loc_cEmpresa, 3) + PADR(loc_cGrEstoque, 10) + PADR(loc_cEstoque, 10)
                loc_cSQL = "SELECT cpros, qmins, ifors, pvens, moevs, dpros " + ;
                    "FROM SigCdPro " + ;
                    "WHERE linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND qmins > 0 AND situas = 1 " + ;
                    "AND " + EscaparSQL(loc_cChave) + " + RTRIM(cpros) " + ;
                    "NOT IN (SELECT RTRIM(empgruests) + RTRIM(cpros) FROM SigMvEst)"
                IF USED("cursor_4c_Temp2")
                    USE IN cursor_4c_Temp2
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp2") < 1
                    MsgErro("Falha na consulta de produtos sem estoque cadastrado", "Erro")
                    IF USED("cursor_4c_Temp1")
                        USE IN cursor_4c_Temp1
                    ENDIF
                    loc_lResultado = .F.
                ENDIF

                *-- UNION ALL: abaixo do minimo + sem registro de estoque
                IF USED("TmpMinimo")
                    USE IN TmpMinimo
                ENDIF
                SET NULL ON
                SELECT m.loc_cEmpresa AS Emps, m.loc_cGrEstoque AS Grupos, ;
                       m.loc_cEstoque AS Estos, cpros, sqtds, qmins, ;
                       qmins - sqtds AS DifProds, ifors, pvens, moevs, dpros ;
                    FROM cursor_4c_Temp1 ;
                    WHERE emps = m.loc_cEmpresa AND grupos = m.loc_cGrEstoque ;
                    AND estos = m.loc_cEstoque ;
                    AND sqtds < qmins AND linhas = m.loc_cLinha ;
                    AND situas = 1 AND qmins > 0 ;
                UNION ALL ;
                SELECT m.loc_cEmpresa AS Emps, m.loc_cGrEstoque AS Grupos, ;
                       m.loc_cEstoque AS Estos, cpros, 0.000 AS sqtds, qmins, ;
                       qmins AS DifProds, ifors, pvens, moevs, dpros ;
                    FROM cursor_4c_Temp2 ;
                INTO CURSOR TmpMinimo READWRITE
                SET NULL OFF

                IF USED("cursor_4c_Temp1")
                    USE IN cursor_4c_Temp1
                ENDIF
                IF USED("cursor_4c_Temp2")
                    USE IN cursor_4c_Temp2
                ENDIF

            ELSE

                *-- Ramo 2: Somente produtos com saldo negativo
                loc_cSQL = "SELECT E.emps, E.grupos, E.estos, E.cpros, E.sqtds, " + ;
                    "P.ifors, P.situas, P.linhas, P.pvens, P.moevs, P.dpros " + ;
                    "FROM SigMvEst E " + ;
                    "JOIN SigCdPro P ON E.cpros = P.cpros " + ;
                    "WHERE E.emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND E.grupos = " + EscaparSQL(loc_cGrEstoque) + ;
                    " AND E.estos = " + EscaparSQL(loc_cEstoque) + ;
                    " AND E.sqtds < 0" + ;
                    " AND P.linhas = " + EscaparSQL(loc_cLinha) + ;
                    " AND P.situas = 1 " + ;
                    "ORDER BY E.emps, E.grupos, E.estos, E.cpros"
                IF USED("cursor_4c_Temp3")
                    USE IN cursor_4c_Temp3
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp3") < 1
                    MsgErro("Falha na consulta de estoques negativos", "Erro")
                    loc_lResultado = .F.
                ENDIF

                IF USED("TmpMinimo")
                    USE IN TmpMinimo
                ENDIF
                SET NULL ON
                SELECT m.loc_cEmpresa AS Emps, m.loc_cGrEstoque AS Grupos, ;
                       m.loc_cEstoque AS Estos, cpros, sqtds, 0 AS qmins, ;
                       ABS(sqtds) AS DifProds, ifors, pvens, moevs, dpros ;
                    FROM cursor_4c_Temp3 ;
                INTO CURSOR TmpMinimo READWRITE
                SET NULL OFF

                IF USED("cursor_4c_Temp3")
                    USE IN cursor_4c_Temp3
                ENDIF

            ENDIF

            *-- Verificar se ha produtos para processar
            SELECT TmpMinimo
            GO TOP
            IF EOF()
                MsgAviso("Nenhum produto selecionado...", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN TmpMinimo
                loc_lResultado = .F.
            ENDIF

            *-- Buscar pedidos em andamento para descontar do que precisa pedir
            loc_cSQL = "SELECT I.cpros, I.qtds, I.qtbxprods " + ;
                "FROM SigMvCab E " + ;
                "JOIN SigMvItn I ON E.empdopnums = I.empdopnums " + ;
                "JOIN SigCdOpe O ON E.dopes = O.dopes " + ;
                "WHERE E.emps = " + EscaparSQL(loc_cEmpresa) + ;
                " AND (O.globalizas = 1 OR O.globalizas = 2) " + ;
                " AND E.grupods = " + EscaparSQL(loc_cGrEstoque) + ;
                " AND E.contads = " + EscaparSQL(loc_cEstoque)
            IF USED("cursor_4c_Temp4")
                USE IN cursor_4c_Temp4
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp4")

            *-- Calcular total em producao por produto
            IF USED("TmpPedidos")
                USE IN TmpPedidos
            ENDIF
            IF USED("cursor_4c_Temp4") AND RECCOUNT("cursor_4c_Temp4") > 0
                SELECT cpros, SUM(qtds - qtbxprods) AS Produzindo ;
                    FROM cursor_4c_Temp4 ;
                    GROUP BY cpros ;
                    INTO CURSOR TmpPedidos READWRITE
            ELSE
                CREATE CURSOR TmpPedidos (cpros C(14), Produzindo N(11, 3))
            ENDIF
            IF USED("cursor_4c_Temp4")
                USE IN cursor_4c_Temp4
            ENDIF

            *-- Calcular quantidade a pedir: diferenca - ja em producao
            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF
            SELECT M.cpros, M.ifors, M.pvens, M.moevs, M.dpros, ;
                M.DifProds - IIF(ISNULL(P.Produzindo), 0, P.Produzindo) AS Qtds ;
                FROM TmpMinimo M ;
                LEFT JOIN TmpPedidos P ON M.cpros = P.cpros ;
                WHERE M.DifProds > IIF(ISNULL(P.Produzindo), 0, P.Produzindo) ;
                INTO CURSOR TmpProd READWRITE

            IF USED("TmpPedidos")
                USE IN TmpPedidos
            ENDIF
            IF USED("TmpMinimo")
                USE IN TmpMinimo
            ENDIF

            SELECT TmpProd
            GO TOP
            IF EOF()
                MsgAviso("Nenhum produto selecionado...", "Aten" + CHR(231) + CHR(227) + "o")
                USE IN TmpProd
                loc_lResultado = .F.
            ENDIF

            *-- Ordenar por fornecedor + produto para agrupar por pedido
            INDEX ON ifors + cpros TAG ForProd
            COUNT TO loc_nTotalReg

            *-- Barra de progresso
            loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Pedidos...", loc_nTotalReg)
            loc_loBarra.Show()

            *-- Buscar dados da operacao (grupo de origem e tipo entrada/saida)
            loc_cSQL = "SELECT dopes, gruorigs, opers FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cOperacao)
            IF USED("cursor_4c_SigCdOpe")
                USE IN cursor_4c_SigCdOpe
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpe")
            SELECT cursor_4c_SigCdOpe
            GO TOP
            IF EOF()
                loc_cGruOrigs = "ESTOQUE"
                loc_nOpers    = 0
            ELSE
                loc_cGruOrigs = IIF(EMPTY(ALLTRIM(gruorigs)), "ESTOQUE", ALLTRIM(gruorigs))
                loc_nOpers    = IIF(VARTYPE(opers) = "N", NVL(opers, 0), IIF(ALLTRIM(TRANSFORM(opers)) = "1", 1, 0))
            ENDIF
            IF USED("cursor_4c_SigCdOpe")
                USE IN cursor_4c_SigCdOpe
            ENDIF

            *-- Iniciar transacao SQL Server
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacaoAberta = .T.

            *-- SCAN: gerar cabecalhos e itens de pedido agrupados por fornecedor
            loc_cFornece = REPL(CHR(255), 10)
            loc_nNumero  = 0
            loc_lnItens  = 0

            SELECT TmpProd
            SCAN
                loc_loBarra.Update(.T.)

                *-- Capturar campos do registro corrente antes de SQLEXEC
                loc_cScanCPros  = ALLTRIM(TmpProd.cpros)
                loc_cScanIFors  = ALLTRIM(TmpProd.ifors)
                loc_nScanPVens  = TmpProd.pvens
                loc_cScanMoevs  = ALLTRIM(TmpProd.moevs)
                loc_cScanDpros  = LEFT(ALLTRIM(TmpProd.dpros), 65)
                loc_nScanQtds   = TmpProd.Qtds

                IF loc_cFornece # loc_cScanIFors
                    *-- Novo fornecedor: gerar numero e inserir cabecalho SigMvCab
                    loc_nNumero     = fGerUniqueKey(ALLTRIM(loc_cOperacao) + loc_cEmpresa)
                    loc_cFornece    = loc_cScanIFors
                    loc_cEmpDopNums = loc_cEmpresa + PADR(loc_cOperacao, 20) + STR(loc_nNumero, 6)
                    loc_cMascNum    = ALLTRIM(fGerMascara(loc_nNumero))

                    loc_cSQL = "INSERT INTO SigMvCab " + ;
                        "(emps, dopes, numes, datas, datars, mascnum, " + ;
                        " grupoos, contaos, grupods, contads, usuars, empdopnums, cidchaves, dtalts) " + ;
                        "VALUES (" + ;
                        EscaparSQL(loc_cEmpresa) + ", " + ;
                        EscaparSQL(PADR(loc_cOperacao, 20)) + ", " + ;
                        FormatarNumeroSQL(loc_nNumero, 0) + ", " + ;
                        FormatarDataSQL(THIS.this_dDatai) + ", " + ;
                        FormatarDataSQL(THIS.this_dDatai) + ", " + ;
                        EscaparSQL(LEFT(loc_cMascNum, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cGruOrigs, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cFornece, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cGrEstoque, 10)) + ", " + ;
                        EscaparSQL(LEFT(loc_cEstoque, 10)) + ", " + ;
                        EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
                        EscaparSQL(loc_cEmpDopNums) + ", " + ;
                        EscaparSQL(fUniqueIds()) + ", " + ;
                        "GETDATE())"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Falha ao inserir cabe" + CHR(231) + "alho do pedido (SigMvCab)", "Erro")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAberta = .F.
                        loc_loBarra.Complete(.T.)
                        IF USED("TmpProd")
                            USE IN TmpProd
                        ENDIF
                        loc_lResultado = .F.
                    ENDIF
                    loc_lnItens = 0
                ENDIF

                *-- Inserir item do pedido (SigMvItn)
                loc_lnItens  = loc_lnItens + 1
                loc_cOpers   = IIF(loc_nOpers = 1, "E", "S")
                loc_nIncVal  = loc_nScanPVens * loc_nScanQtds

                loc_cSQL = "INSERT INTO SigMvItn " + ;
                    "(emps, dopes, numes, citens, cpros, qtds, units, moedas, opers, totas, dpros, empdopnums, cidchaves, dtalts) " + ;
                    "VALUES (" + ;
                    EscaparSQL(loc_cEmpresa) + ", " + ;
                    EscaparSQL(PADR(loc_cOperacao, 20)) + ", " + ;
                    FormatarNumeroSQL(loc_nNumero, 0) + ", " + ;
                    FormatarNumeroSQL(loc_lnItens, 0) + ", " + ;
                    EscaparSQL(loc_cScanCPros) + ", " + ;
                    FormatarNumeroSQL(loc_nScanQtds, 3) + ", " + ;
                    FormatarNumeroSQL(loc_nScanPVens, 5) + ", " + ;
                    EscaparSQL(LEFT(loc_cScanMoevs, 3)) + ", " + ;
                    EscaparSQL(loc_cOpers) + ", " + ;
                    FormatarNumeroSQL(loc_nIncVal, 2) + ", " + ;
                    EscaparSQL(loc_cScanDpros) + ", " + ;
                    EscaparSQL(loc_cEmpDopNums) + ", " + ;
                    EscaparSQL(fUniqueIds()) + ", " + ;
                    "GETDATE())"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao inserir item do pedido (SigMvItn)", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacaoAberta = .F.
                    loc_loBarra.Complete(.T.)
                    IF USED("TmpProd")
                        USE IN TmpProd
                    ENDIF
                    loc_lResultado = .F.
                ENDIF

                *-- Atualizar totais do cabecalho
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                    "valinis = valinis + " + FormatarNumeroSQL(loc_nIncVal, 2) + ", " + ;
                    "valos = valos + " + FormatarNumeroSQL(loc_nIncVal, 2) + ", " + ;
                    "dtalts = GETDATE() " + ;
                    "WHERE emps = " + EscaparSQL(loc_cEmpresa) + ;
                    " AND dopes = " + EscaparSQL(PADR(loc_cOperacao, 20)) + ;
                    " AND numes = " + FormatarNumeroSQL(loc_nNumero, 0)
                SQLEXEC(gnConnHandle, loc_cSQL)

                SELECT TmpProd
            ENDSCAN

            *-- Confirmar transacao
            IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") < 1
                MsgErro("Falha ao confirmar a transa" + CHR(231) + CHR(227) + "o", "Erro")
                loc_lTransacaoAberta = .F.
                loc_loBarra.Complete(.T.)
                IF USED("TmpProd")
                    USE IN TmpProd
                ENDIF
                loc_lResultado = .F.
            ENDIF
            loc_lTransacaoAberta = .F.

            loc_loBarra.Complete(.T.)

            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF

            THIS.RegistrarAuditoria("PEDIDO_ESTOQUE_MINIMO")
            loc_lResultado = .T.

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            IF VARTYPE(loc_loBarra) = "O"
                loc_loBarra.Complete(.T.)
            ENDIF
            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF
            IF USED("TmpMinimo")
                USE IN TmpMinimo
            ENDIF
            IF USED("TmpPedidos")
                USE IN TmpPedidos
            ENDIF
            IF USED("cursor_4c_Temp1")
                USE IN cursor_4c_Temp1
            ENDIF
            IF USED("cursor_4c_Temp2")
                USE IN cursor_4c_Temp2
            ENDIF
            IF USED("cursor_4c_Temp3")
                USE IN cursor_4c_Temp3
            ENDIF
            IF USED("cursor_4c_Temp4")
                USE IN cursor_4c_Temp4
            ENDIF
            IF USED("cursor_4c_LinhaOpe")
                USE IN cursor_4c_LinhaOpe
            ENDIF
            IF USED("cursor_4c_SigCdOpe")
                USE IN cursor_4c_SigCdOpe
            ENDIF
            MsgErro(loc_oErro.Message, "Erro no processamento")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora, Empresa) " + ;
                "VALUES (" + ;
                EscaparSQL("SigMvCab") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Falha de auditoria nao interrompe o fluxo principal
        ENDTRY
    ENDPROC

ENDDEFINE

