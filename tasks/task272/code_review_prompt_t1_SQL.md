# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_TOTA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, EMPDOPNUMS, CMOES, TOTA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, EMPDOPNUMS, CMOES, TOTA

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
  Column1.ControlSource = ""
  Column3.SelectOnEntry = .F.
lcSql = [Select a.*,b.dMoes as Descrs From SIGPRCTC a, SigCdMoe b Where a.EmpDopNums = ']+ThisForm.pcEdn+[' And a.cMoes = b.cMoes ]
ThisForm.ParentForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalCtMoe')
Select LocalCtMoe
	.Column1.ControlSource = 'LocalCtMoe.cMoes'
	.Column2.ControlSource = 'LocalCtMoe.Descrs'
	.Column3.ControlSource = 'LocalCtMoe.Valos'
Select LocalCtMoe
	Delete
		Select LocalCtMoe
		Select cMoes,sum(1) as TT From LocalCtMoe GROUP by 1 Into cursor Totais
		Select Totais
		Select CrSIGPRCTC
		Select LocalCtMoe
			Insert Into CrSIGPRCTC (EmpDopNums,cMoes,pkChaves,Valos) Values ;
				lcDelete = [Delete From SIGPRCTC Where EmpDopNums = ']+ThisForm.pcEdn+[']
				m.lnErro1 = Iif(.poDataMgr.SqlExecute(lcDelete,'')>0,1,-1)
				m.lnErro1 = Iif(.poDataMgr.UpDate('crSIGPRCTC'),1,-1)
Select LocalCtMoe
	Insert Into LocalCtMoe(EmpDopNums, pkChaves) Values (ThisForm.pcEdn,fUniqueIds())
Select LocalCtMoe

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1398 linhas total):

*-- Linhas 395 a 413:
395:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
396:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
397:         loc_oGrid.HighlightStyle     = 2
398:         loc_oGrid.DeleteMark         = .F.
399:         loc_oGrid.RecordMark         = .F.
400:         loc_oGrid.RowHeight          = 16
401:         loc_oGrid.ScrollBars         = 2
402:         loc_oGrid.Visible            = .T.
403: 
404:         WITH loc_oGrid.Column1
405:             .Width           = 100
406:             .Header1.Caption = "Moeda"
407:         ENDWITH
408: 
409:         WITH loc_oGrid.Column2
410:             .Width           = 550
411:             .ReadOnly        = .T.
412:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
413:         ENDWITH

*-- Linhas 662 a 683:
662:                 USE IN cursor_4c_CtMoeTemp
663:             ENDIF
664:             IF USED("cursor_4c_BuscaMoeda")
665:                 USE IN cursor_4c_BuscaMoeda
666:             ENDIF
667:             IF USED("cursor_4c_Totais")
668:                 USE IN cursor_4c_Totais
669:             ENDIF
670:             IF USED("cursor_4c_Dados")
671:                 USE IN cursor_4c_Dados
672:             ENDIF
673: 
674:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
675:                 THIS.this_oBusinessObject = .NULL.
676:             ENDIF
677: 
678:             IF VARTYPE(THIS.this_oParentForm) = "O"
679:                 THIS.this_oParentForm.Enabled = .T.
680:                 THIS.this_oParentForm = .NULL.
681:             ENDIF
682:         CATCH TO loc_oErro
683:             MsgErro("Erro em Destroy:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 722 a 768:
722:                 IF EMPTY(THIS.this_cEmpDopNums)
723:                 IF !USED("cursor_4c_LocalCtMoe")
724:                     SET NULL ON
725:                     CREATE CURSOR cursor_4c_LocalCtMoe ;
726:                         (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
727:                     SET NULL OFF
728:                 ENDIF
729:                 loc_lResultado = .T.
730:             ELSE
731:                 IF THIS.this_oBusinessObject.CarregarParaEdicao(THIS.this_cEmpDopNums)
732:                 loc_lResultado = .T.
733:                 ENDIF
734:                 ENDIF
735:             ENDIF
736: 
737:             IF loc_lResultado AND USED("cursor_4c_LocalCtMoe")
738:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
739:                 loc_oGrid.ColumnCount = 3
740:                 loc_oGrid.RecordSource = "cursor_4c_LocalCtMoe"
741:                 loc_oGrid.ColumnCount  = 3
742: 
743:                 WITH loc_oGrid
744:                     .Column1.ControlSource   = "cursor_4c_LocalCtMoe.cmoes"
745:                     .Column1.Width           = 100
746:                     .Column1.Header1.Caption = "Moeda"
747: 
748:                     .Column2.ControlSource   = "cursor_4c_LocalCtMoe.Descrs"
749:                     .Column2.Width           = 550
750:                     .Column2.ReadOnly        = .T.
751:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
752: 
753:                     .Column3.ControlSource   = "cursor_4c_LocalCtMoe.valos"
754:                     .Column3.Width           = 200
755:                     .Column3.ReadOnly        = .T.
756:                     .Column3.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
757:                 ENDWITH
758: 
759:                 THIS.FormatarGridLista(loc_oGrid)
760:                 THIS.AjustarBotoesPorModo()
761:             ENDIF
762:         CATCH TO loc_oErro
763:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
764:             loc_lResultado = .F.
765:         ENDTRY
766: 
767:         RETURN loc_lResultado
768:     ENDPROC

*-- Linhas 818 a 873:
818: 
819:         TRY
820:             IF THIS.this_oBusinessObject.InserirLinhaLocal(THIS.this_cEmpDopNums)
821:                 SELECT cursor_4c_LocalCtMoe
822:                 GO BOTTOM
823:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
824:                 THIS.this_cModoAtual = "INCLUIR"
825:                 THIS.LimparCampos()
826:                 THIS.HabilitarCampos(.T.)
827:                 loc_lSucesso = .T.
828:             ENDIF
829:         CATCH TO loc_oErro
830:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnIncluirClick")
831:         ENDTRY
832: 
833:         IF loc_lSucesso
834:             THIS.AlternarPagina(2)
835:         ENDIF
836:     ENDPROC
837: 
838:     *--------------------------------------------------------------------------
839:     * BtnVisualizarClick - Navega para Page2 exibindo dados da linha selecionada
840:     *--------------------------------------------------------------------------
841:     PROCEDURE BtnVisualizarClick()
842:         IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
843:            !DELETED("cursor_4c_LocalCtMoe")
844:             THIS.this_cModoAtual = "VISUALIZAR"
845:             THIS.BOParaForm()
846:             THIS.HabilitarCampos(.F.)
847:             THIS.AlternarPagina(2)
848:         ELSE
849:             MsgAviso("Nenhum registro selecionado para visualizar.", "Visualizar")
850:         ENDIF
851:     ENDPROC
852: 
853:     *--------------------------------------------------------------------------
854:     * BtnAlterarClick - Posiciona foco no grid para edicao inline
855:     *--------------------------------------------------------------------------
856:     PROCEDURE BtnAlterarClick()
857:         IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
858:            !DELETED("cursor_4c_LocalCtMoe")
859:             THIS.this_cModoAtual = "ALTERAR"
860:             THIS.BOParaForm()
861:             THIS.HabilitarCampos(.T.)
862:             THIS.AlternarPagina(2)
863:         ELSE
864:             MsgAviso("Nenhum registro selecionado para alterar.", "Alterar")
865:         ENDIF
866:     ENDPROC
867: 
868:     *--------------------------------------------------------------------------
869:     * BtnExcluirClick - Exclui linha corrente do cursor local
870:     *--------------------------------------------------------------------------
871:     PROCEDURE BtnExcluirClick()
872:         TRY
873:             IF !USED("cursor_4c_LocalCtMoe") OR EOF("cursor_4c_LocalCtMoe")

*-- Linhas 908 a 937:
908:                 loc_oBusca.Show()
909: 
910:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
911:                     SELECT cursor_4c_BuscaMoeda
912:                     loc_cCmoes = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
913:                 ENDIF
914:                 loc_oBusca.Release()
915:             ENDIF
916:         CATCH TO loc_oErro
917:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnBuscarClick")
918:         ENDTRY
919: 
920:         IF !EMPTY(loc_cCmoes) AND USED("cursor_4c_LocalCtMoe")
921:             SELECT cursor_4c_LocalCtMoe
922:             LOCATE FOR ALLTRIM(UPPER(cmoes)) == UPPER(loc_cCmoes) AND !DELETED()
923:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
924:         ENDIF
925: 
926:         IF USED("cursor_4c_BuscaMoeda")
927:             USE IN cursor_4c_BuscaMoeda
928:         ENDIF
929:     ENDPROC
930: 
931:     *--------------------------------------------------------------------------
932:     * BtnEncerrarClick - Valida, salva cotacoes e fecha o formulario
933:     * Equivalente ao cmdSair.Click do legado (SIGPRCTC)
934:     *--------------------------------------------------------------------------
935:     PROCEDURE BtnEncerrarClick()
936:         LOCAL loc_lPodeSair, loc_lHouveAlteracao
937:         loc_lPodeSair       = .F.

*-- Linhas 968 a 987:
968: 
969:         TRY
970:             IF par_nColIndex = 1 AND USED("cursor_4c_LocalCtMoe") AND ;
971:                !EOF("cursor_4c_LocalCtMoe") AND !DELETED("cursor_4c_LocalCtMoe")
972:                 SELECT cursor_4c_LocalCtMoe
973:                 loc_cCmoes = ALLTRIM(cmoes)
974:                 IF EMPTY(loc_cCmoes)
975:                     REPLACE Descrs WITH SPACE(15)
976:                 ELSE
977:                     THIS.AbrirBuscaMoeda(loc_cCmoes)
978:                 ENDIF
979:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
980:             ENDIF
981:         CATCH TO loc_oErro
982:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
983:                     "Erro GrdDadosAfterRowColChange")
984:         ENDTRY
985:     ENDPROC
986: 
987:     *--------------------------------------------------------------------------

*-- Linhas 1005 a 1047:
1005:             IF VARTYPE(loc_oBusca) = "O"
1006:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1007:                     IF USED("cursor_4c_BuscaMoeda")
1008:                         SELECT cursor_4c_BuscaMoeda
1009:                         loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1010:                         loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1011:                     ENDIF
1012:                 ELSE
1013:                     IF !loc_oBusca.this_lAchouRegistro
1014:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1015:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1016:                     loc_oBusca.Show()
1017:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
1018:                         SELECT cursor_4c_BuscaMoeda
1019:                         loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1020:                         loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1021:                     ENDIF
1022:                     ENDIF
1023:                 ENDIF
1024:                 loc_oBusca.Release()
1025:             ENDIF
1026:         CATCH TO loc_oErro
1027:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AbrirBuscaMoeda")
1028:         ENDTRY
1029: 
1030:         IF !EMPTY(loc_cCmoes) AND USED("cursor_4c_LocalCtMoe") AND ;
1031:            !EOF("cursor_4c_LocalCtMoe") AND !DELETED("cursor_4c_LocalCtMoe")
1032:             SELECT cursor_4c_LocalCtMoe
1033:             REPLACE cmoes  WITH PADR(loc_cCmoes,  3)
1034:             REPLACE Descrs WITH PADR(loc_cDescrs, 15)
1035:         ENDIF
1036: 
1037:         IF USED("cursor_4c_BuscaMoeda")
1038:             USE IN cursor_4c_BuscaMoeda
1039:         ENDIF
1040:     ENDPROC
1041: 
1042:     *--------------------------------------------------------------------------
1043:     * BtnSalvarClick - Persiste campos da Page2 no cursor local e volta para lista
1044:     *--------------------------------------------------------------------------
1045:     PROCEDURE BtnSalvarClick()
1046:         LOCAL loc_cCmoes, loc_nValos, loc_oPg2
1047:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1067 a 1085:
1067:             MsgAviso("C" + CHR(243) + "digo da moeda obrigat" + CHR(243) + "rio.", "Salvar")
1068:         ELSE
1069:             IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
1070:                !DELETED("cursor_4c_LocalCtMoe")
1071:             THIS.FormParaBO()
1072:             THIS.this_oBusinessObject.this_lHouveInsercao = .T.
1073:             THIS.AlternarPagina(1)
1074:             THIS.CarregarLista()
1075:             ENDIF
1076:         ENDIF
1077:     ENDPROC
1078: 
1079:     *--------------------------------------------------------------------------
1080:     * BtnCancelarClick - Cancela edicao e volta para lista sem salvar
1081:     *--------------------------------------------------------------------------
1082:     PROCEDURE BtnCancelarClick()
1083:         THIS.AlternarPagina(1)
1084:         THIS.CarregarLista()
1085:     ENDPROC

*-- Linhas 1096 a 1115:
1096: 
1097:         TRY
1098:             IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
1099:                !DELETED("cursor_4c_LocalCtMoe")
1100:                 SELECT cursor_4c_LocalCtMoe
1101:                 loc_cCmoes  = ALLTRIM(NVL(cmoes,  ""))
1102:                 loc_cDescrs = ALLTRIM(NVL(Descrs, ""))
1103:                 loc_nValos  = NVL(valos, 0)
1104:             ENDIF
1105: 
1106:             IF PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
1107:                 loc_oPg2.txt_4c_Cmoes.Value = loc_cCmoes
1108:             ENDIF
1109:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
1110:                 loc_oPg2.txt_4c_Descrs.Value = loc_cDescrs
1111:             ENDIF
1112:             IF PEMSTATUS(loc_oPg2, "txt_4c_Valos", 5)
1113:                 loc_oPg2.txt_4c_Valos.Value = loc_nValos
1114:             ENDIF
1115:         CATCH TO loc_oErro

*-- Linhas 1136 a 1155:
1136:             ENDIF
1137: 
1138:             IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe") AND ;
1139:                !DELETED("cursor_4c_LocalCtMoe")
1140:                 SELECT cursor_4c_LocalCtMoe
1141:                 REPLACE cmoes WITH PADR(loc_cCmoes, 3), valos WITH loc_nValos
1142:             ENDIF
1143:         CATCH TO loc_oErro
1144:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message + ;
1145:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1146:         ENDTRY
1147:     ENDPROC
1148: 
1149:     *--------------------------------------------------------------------------
1150:     * CmoesLookupKeyPress - Handler de KeyPress do txt_4c_Cmoes (Page2)
1151:     * Abre picker de moeda ao pressionar F4 (keycode 28)
1152:     *--------------------------------------------------------------------------
1153:     PROCEDURE CmoesLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1154:         IF par_nKeyCode = 28
1155:             THIS.AbrirBuscaMoedaPage2()

*-- Linhas 1223 a 1251:
1223:                 IF VARTYPE(loc_oBusca) = "O"
1224:                     IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1225:                         IF USED("cursor_4c_BuscaMoeda")
1226:                             SELECT cursor_4c_BuscaMoeda
1227:                             loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1228:                             loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1229:                         ENDIF
1230:                     ELSE
1231:                         IF !loc_oBusca.this_lAchouRegistro
1232:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1233:                         loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1234:                         loc_oBusca.Show()
1235:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
1236:                             SELECT cursor_4c_BuscaMoeda
1237:                             loc_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1238:                             loc_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
1239:                         ENDIF
1240:                         ENDIF
1241:                     ENDIF
1242:                     loc_oBusca.Release()
1243:                 ENDIF
1244:             CATCH TO loc_oErro
1245:                 MsgErro("Erro em AbrirBuscaMoedaPage2:" + CHR(13) + loc_oErro.Message + ;
1246:                         " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1247:             ENDTRY
1248: 
1249:             IF !EMPTY(loc_cCmoes) AND PEMSTATUS(loc_oPg2, "txt_4c_Cmoes", 5)
1250:                 loc_oPg2.txt_4c_Cmoes.Value = loc_cCmoes
1251:             ENDIF


### BO (C:\4c\projeto\app\classes\SigPrCtcBO.prg):
*==============================================================================
* SigPrCtcBO.prg - Business Object para Cotacoes por Operacoes
* Herda de BusinessBase
* Tabela principal: sigprctc
* PK: pkchaves (char 20)
* Fase 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS SigPrCtcBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificador composto da operacao (pcEmps + pcDopes + STR(pnNumes,6))
    * Chave de agrupamento de todas as cotacoes da operacao
    *--------------------------------------------------------------------------
    this_cEmpDopNums = ""    && empdopnums char(29) - chave da operacao

    *--------------------------------------------------------------------------
    * Campos da linha corrente de sigprctc
    *--------------------------------------------------------------------------
    this_cCmoes      = ""    && cmoes    char(3)       - codigo da moeda (FK SigCdMoe)
    this_nValos      = 0     && valos    numeric(11,6) - cotacao da moeda
    this_cPkChaves   = ""    && pkchaves char(20)      - chave primaria (PK)
    this_dDtalts     = {}    && dtalts   datetime NULL - data/hora alteracao
    this_cUsuars     = ""    && usuars   char(10)      - usuario que gravou

    *--------------------------------------------------------------------------
    * Campo auxiliar vindo do JOIN com SigCdMoe (nao persistido em sigprctc)
    *--------------------------------------------------------------------------
    this_cDescrs     = ""    && dmoes char(15) - descricao da moeda (SigCdMoe.dmoes)

    *--------------------------------------------------------------------------
    * Controle interno de estado da colecao
    *--------------------------------------------------------------------------
    this_lHouveInsercao  = .F.  && .T. se alguma linha foi inserida na sessao
    this_lHouveExclusao  = .F.  && .T. se alguma linha foi removida na sessao

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "sigprctc"
            THIS.this_cCampoChave = "pkchaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCtcBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria (auditoria)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades de uma linha do cursor
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cCmoes      = TratarNulo(cmoes,      "C")
                THIS.this_nValos      = TratarNulo(valos,      "N")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,   "C")
                THIS.this_cDescrs     = TratarNulo(Descrs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParaEdicao - Carrega cotacoes da operacao em cursor VFP local
    * par_cEmpDopNums: chave da operacao (emps+dopes+numes, 29 chars)
    * Cria cursor_4c_LocalCtMoe para edicao em memoria
    *==========================================================================
    PROCEDURE CarregarParaEdicao(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalCtMoe")
                USE IN cursor_4c_LocalCtMoe
            ENDIF
            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_LocalCtMoe ;
                (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
            SET NULL OFF

            loc_cSQL = "SELECT a.empdopnums, a.cmoes, a.valos, a.pkchaves," + ;
                       " ISNULL(b.dmoes,'') AS Descrs" + ;
                       " FROM sigprctc a" + ;
                       " LEFT JOIN SigCdMoe b ON b.cmoes = a.cmoes" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(ALLTRIM(par_cEmpDopNums))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtMoeTemp")

            IF loc_nResult > 0 AND USED("cursor_4c_CtMoeTemp") AND RECCOUNT("cursor_4c_CtMoeTemp") > 0
                SELECT cursor_4c_LocalCtMoe
                APPEND FROM DBF("cursor_4c_CtMoeTemp")
            ENDIF

            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF

            SELECT cursor_4c_LocalCtMoe
            GO TOP

            THIS.this_lHouveInsercao = .F.
            THIS.this_lHouveExclusao = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarParaEdicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirLinhaLocal - Insere nova linha em branco no cursor local
    * par_cEmpDopNums: chave da operacao para preencher o campo de agrupamento
    *==========================================================================
    PROCEDURE InserirLinhaLocal(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cPkChave
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                SELECT cursor_4c_LocalCtMoe
                LOCATE FOR EMPTY(cmoes) AND !DELETED()
                IF EOF()
                    loc_cPkChave = LEFT(SYS(2015) + PADR(TRANSFORM(RECCOUNT("cursor_4c_LocalCtMoe") + 1), 10, "0"), 20)
                    INSERT INTO cursor_4c_LocalCtMoe (empdopnums, cmoes, valos, pkchaves, Descrs) ;
                        VALUES (ALLTRIM(par_cEmpDopNums), SPACE(3), 0, loc_cPkChave, SPACE(15))
                    GO BOTTOM
                ELSE
                    GO RECNO()
                ENDIF
                THIS.this_lHouveInsercao = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro InserirLinhaLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirLinhaLocal - Remove linha corrente do cursor local (marca deleted)
    *==========================================================================
    PROCEDURE ExcluirLinhaLocal()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                IF !EOF("cursor_4c_LocalCtMoe")
                SELECT cursor_4c_LocalCtMoe
                DELETE
                SKIP
                IF EOF()
                    SKIP -1
                ENDIF
                THIS.this_lHouveExclusao = .T.
                loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExcluirLinhaLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica se ha moedas duplicadas no cursor local
    * Retorna .T. se valido (sem duplicatas), .F. se ha moedas repetidas
    *==========================================================================
    PROCEDURE ValidarDuplicidade()
        LOCAL loc_lValido, loc_cMoesDup
        loc_lValido  = .F.
        loc_cMoesDup = ""

        TRY
            IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                IF USED("cursor_4c_Totais")
                    USE IN cursor_4c_Totais
                ENDIF

                SELECT cmoes, SUM(1) AS tt FROM cursor_4c_LocalCtMoe ;
                    WHERE !DELETED() AND !EMPTY(ALLTRIM(cmoes)) ;
                    GROUP BY cmoes ;
                    INTO CURSOR cursor_4c_Totais

                IF USED("cursor_4c_Totais")
                    SELECT cursor_4c_Totais
                    SCAN
                        IF tt > 1
                            IF !EMPTY(loc_cMoesDup)
                                loc_cMoesDup = loc_cMoesDup + ", "
                            ENDIF
                            loc_cMoesDup = loc_cMoesDup + ALLTRIM(cmoes)
                        ENDIF
                    ENDSCAN
                    USE IN cursor_4c_Totais
                ENDIF

                IF !EMPTY(loc_cMoesDup)
                    MsgErro("Moeda(s) digitada(s) em duplicidade: " + loc_cMoesDup, ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    loc_lValido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ValidarDuplicidade")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BuscarMoeda - Busca moeda por codigo em SigCdMoe
    * par_cCodigo: codigo da moeda (cmoes)
    * Popula cursor_4c_BuscaMoeda; retorna .T. se encontrou codigo exato
    *==========================================================================
    PROCEDURE BuscarMoeda(par_cCodigo)
        LOCAL loc_lEncontrou, loc_cSQL, loc_nResult
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes AS Descrs FROM SigCdMoe" + ;
                       " WHERE cmoes LIKE " + EscaparSQL(ALLTRIM(par_cCodigo) + "%") + ;
                       " ORDER BY cmoes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaMoeda") AND RECCOUNT("cursor_4c_BuscaMoeda") > 0
                SELECT cursor_4c_BuscaMoeda
                GO TOP
                IF RECCOUNT("cursor_4c_BuscaMoeda") = 1 AND ;
                   UPPER(ALLTRIM(cursor_4c_BuscaMoeda.cmoes)) == UPPER(ALLTRIM(par_cCodigo))
                    THIS.this_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    THIS.this_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.Descrs)
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BuscarMoeda")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *==========================================================================
    * AtualizarDescricaoMoeda - Atualiza campo Descrs na linha corrente do cursor local
    *==========================================================================
    PROCEDURE AtualizarDescricaoMoeda(par_cDescrs)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalCtMoe") AND !EOF("cursor_4c_LocalCtMoe")
                SELECT cursor_4c_LocalCtMoe
                REPLACE Descrs WITH PADR(ALLTRIM(par_cDescrs), 15)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AtualizarDescricaoMoeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarCotacoes - Persiste cotacoes no SQL Server (DELETE all + INSERT validas)
    * par_cEmpDopNums: chave da operacao
    * Logica: deleta todos da operacao, re-insere linhas validas do cursor local
    *==========================================================================
    PROCEDURE SalvarCotacoes(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_nLinha, loc_cPkChave
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDuplicidade()
                *-- mensagem ja exibida por ValidarDuplicidade
            ELSE
                IF !USED("cursor_4c_LocalCtMoe")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                *-- Passo 1: Remove todos os registros da operacao no SQL Server
                loc_cSQL = "DELETE FROM sigprctc WHERE empdopnums = " + ;
                           EscaparSQL(ALLTRIM(par_cEmpDopNums))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir cota" + CHR(231) + CHR(245) + "es anteriores:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Passo 2: Re-insere todas as linhas validas do cursor local
                    SELECT cursor_4c_LocalCtMoe
                    GO TOP
                    loc_lSucesso = .T.
                    loc_nLinha   = 0

                    SCAN WHILE loc_lSucesso
                        IF DELETED()
                            LOOP
                        ENDIF
                        IF EMPTY(ALLTRIM(cmoes))
                            LOOP
                        ENDIF

                        loc_nLinha   = loc_nLinha + 1
                        loc_cPkChave = LEFT(SYS(2015) + PADR(TRANSFORM(loc_nLinha), 10, "0"), 20)

                        loc_cSQL = "INSERT INTO sigprctc (empdopnums, cmoes, valos, pkchaves, dtalts, usuars)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cEmpDopNums)) + "," + ;
                                   EscaparSQL(ALLTRIM(cmoes)) + "," + ;
                                   FormatarNumeroSQL(valos) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   "GETDATE()," + ;
                                   EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ;
                                   ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                        IF USED("cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF

                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o da moeda " + ;
                                    ALLTRIM(cmoes) + ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDSCAN

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("SALVAR_COTACOES")
                    ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SalvarCotacoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

