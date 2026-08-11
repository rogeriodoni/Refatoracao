# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, GRUPOS, CONTAS, CODIGOS, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, GRUPOS, CONTAS, CODIGOS, ICLIS

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
  ControlSource = "TmpGcOpe.Dgrus"
  ControlSource = "TmpGcOpe.Rclis"
lcSql = [Select a.*, b.Descrs as Dgrus, c.Rclis From SigCdGcp a, SigCdGcr b, SigCdCli c ]+;
SigCdOpe.PodataMgr.Sqlexecute(lcSql,'xGcOpe')
Select * From xgcOpe Into Cursor TmpGcOpe ReadWrite
Select TmpGcOpe
	.Column1.ControlSource = 'TmpGcOpe.Grupos'
	.Column2.ControlSource = 'TmpGcOpe.Contas'
	.Column3.ControlSource = 'TmpGcOpe.OriDes'
	lcSql = [Select Descrs From SigCdGcr Where Codigos = ']+This.Value+[' ]
	SigCdOpe.Podatamgr.Sqlexecute(lcSql,'LocalGccr')
	lcSql = [Select Rclis From SigCdCli Where Iclis = ']+This.Value+[']
	SigCdOpe.Podatamgr.Sqlexecute(lcSql,'LocalCli')
Update TmpGcOpe Set BlqCts = This.Value
Select TmpGcOpe
	Delete
		Select TmpGcOpe
		Delete For Grupos = '  ' or Contas = '  '
		Select Grupos, Contas, sum(1) From TmpGcOpe Group by 1,2 having sum(1) > 1 Into Cursor SecondKey
		Select SecondKey
		Select CrSigCdGcp
		Append From Dbf('TmpGcOpe')
		lcSql = [Delete From SigCdGcp Where Dopes = ']+CrSigCdOpe.dopes+[']
				m.lnErro1 = SigCdOpe.PodataMgr.Sqlexecute(lcSql,'')
				m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdGcp'),1,-1)
Select TmpGcOpe
	Insert Into TmpGcOpe (Dopes, CidChaves, BlqCts ) Values (crSigCdOpe.Dopes,fUniqueIds(), ThisForm.Opt_Permite.Value )
Select TmpGcOpe

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormGcp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1409 linhas total):

*-- Linhas 274 a 315:
274:                     loc_oGrid = loc_oPg1.grd_4c_Dados
275:                     IF VARTYPE(loc_oGrid) = "O"
276:                         loc_oGrid.RecordSource = "TmpGcOpe"
277:                         loc_oGrid.Column1.ControlSource = "TmpGcOpe.Grupos"
278:                         loc_oGrid.Column2.ControlSource = "TmpGcOpe.Contas"
279:                         loc_oGrid.Column3.ControlSource = "TmpGcOpe.OriDes"
280:                         loc_oGrid.Column1.Header1.Caption = "Grupo"
281:                         loc_oGrid.Column2.Header1.Caption = "Conta"
282:                         loc_oGrid.Column3.Header1.Caption = "O/D/A"
283:                         *-- DynamicForeColor: azul para Permitidas (BlqCts!=2), rosa para Nao Permitidas (BlqCts=2)
284:                         loc_oGrid.SetAll("DynamicForeColor", ;
285:                             "IIF(TmpGcOpe.BlqCts = 2, RGB(255,0,128), RGB(0,0,128))", "Column")
286:                         loc_oGrid.Refresh()
287:                     ENDIF
288: 
289:                     *-- ControlSource dos campos de display (requer TmpGcOpe ativo)
290:                     IF VARTYPE(loc_oCnt) = "O"
291:                         IF VARTYPE(loc_oCnt.txt_4c_Dgru) = "O"
292:                             loc_oCnt.txt_4c_Dgru.ControlSource = "TmpGcOpe.Dgrus"
293:                         ENDIF
294:                         IF VARTYPE(loc_oCnt.txt_4c_DConta) = "O"
295:                             loc_oCnt.txt_4c_DConta.ControlSource = "TmpGcOpe.Rclis"
296:                         ENDIF
297: 
298:                         *-- Valor inicial do OptionGroup baseado no BlqCts do primeiro registro
299:                         IF VARTYPE(loc_oCnt.opt_4c_Permite) = "O"
300:                             SELECT TmpGcOpe
301:                             GO TOP IN TmpGcOpe
302:                             IF !EOF("TmpGcOpe")
303:                                 loc_oCnt.opt_4c_Permite.Value = IIF(TmpGcOpe.BlqCts = 2, 2, 1)
304:                             ENDIF
305:                         ENDIF
306:                     ENDIF
307:                 ENDIF
308:             ENDIF
309:         CATCH TO loException
310:             MostrarErro(loException, "FormGcp.CarregarDados")
311:         ENDTRY
312: 
313:         RETURN loc_lResultado
314:     ENDPROC
315: 

*-- Linhas 560 a 578:
560:             .HighlightBackColor = RGB(255, 255, 255)
561:             .HighlightForeColor = RGB(15, 41, 104)
562:             .HighlightStyle     = 2
563:             .DeleteMark         = .F.
564:             .RecordMark         = .F.
565:             .RowHeight          = 16
566:             .ScrollBars         = 2
567:             .GridLines          = 3
568:             .Visible            = .T.
569:         ENDWITH
570: 
571:         loc_oGrid.Column1.Width          = 60
572:         loc_oGrid.Column1.Header1.Caption = "Grupo"
573:         loc_oGrid.Column2.Width          = 100
574:         loc_oGrid.Column2.Header1.Caption = "Conta"
575:         loc_oGrid.Column3.Width          = 75
576:         loc_oGrid.Column3.Header1.Caption = "O/D/A"
577: 
578:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridDadosAfterRowColChange")

*-- Linhas 617 a 670:
617: 
618:         *-- Verificar se ja ha linha em branco (nao inserir multiplas linhas vazias)
619:         IF USED("TmpGcOpe")
620:             SELECT TmpGcOpe
621:             LOCATE FOR EMPTY(ALLTRIM(Grupos))
622:             IF !EOF()
623:                 loc_oPg1.grd_4c_Dados.Refresh()
624:                 loc_oPg1.grd_4c_Dados.Column1.SetFocus
625:                 RETURN
626:             ENDIF
627:         ENDIF
628: 
629:         *-- Inserir nova linha com valores padrao em branco
630:         THIS.this_lHouveIns = .T.
631: 
632:         INSERT INTO TmpGcOpe ;
633:             (CidChaves, Dopes, Grupos, Contas, OriDes, BlqCts) ;
634:             VALUES ("", THIS.this_cDopesAtual, " ", " ", " ", loc_nBlqCts)
635: 
636:         IF USED("TmpGcOpe")
637:             SELECT TmpGcOpe
638:         ENDIF
639: 
640:         loc_oPg1.grd_4c_Dados.Refresh()
641:         loc_oPg1.grd_4c_Dados.Column1.SetFocus
642:     ENDPROC
643: 
644:     *==========================================================================
645:     * BTNEXCLUIRCLICK - Exclui linha selecionada do TmpGcOpe
646:     * Equivale a cmdExcluir.Click do legado
647:     *==========================================================================
648:     PROCEDURE BtnExcluirClick()
649:         LOCAL loc_oPg1
650:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
651: 
652:         IF USED("TmpGcOpe") AND !EOF("TmpGcOpe")
653:             THIS.this_lHouveExcl = .T.
654:             SELECT TmpGcOpe
655:             DELETE
656:             SKIP
657:             SKIP -1
658:         ENDIF
659: 
660:         loc_oPg1.grd_4c_Dados.Refresh()
661:     ENDPROC
662: 
663:     *==========================================================================
664:     * BTNENCERRARCLICK - Salva mudancas e fecha o popup
665:     * Equivale a cmdSair.Click do legado (inclui validacao de duplicatas via BO)
666:     *==========================================================================
667:     PROCEDURE BtnEncerrarClick()
668:         LOCAL loc_lResultado, loc_nBlqCts, loc_oPg1
669:         loc_lResultado = .T.
670:         loc_nBlqCts    = THIS.this_oBusinessObject.this_nBlqCtsAtual

*-- Linhas 787 a 805:
787:         * Equivale a Get_DConta do legado (When retorna .F. = nao editavel)
788:         * Original: Top=344, Left=104, Width=289, Height=23
789:         * No container (Top=349): relative Top = 344+29-349 = 24
790:         * ControlSource = "TmpGcOpe.Rclis" (setado em CarregarDados)
791:         *----------------------------------------------------------------------
792:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
793:         WITH loc_oCnt.txt_4c_DConta
794:             .Top           = 24
795:             .Left          = 104
796:             .Width         = 289
797:             .Height        = 23
798:             .FontName      = "Tahoma"
799:             .FontSize      = 8
800:             .FontBold      = .T.
801:             .ForeColor     = RGB(90, 90, 90)
802:             .BackColor     = RGB(255, 255, 225)
803:             .Value         = ""
804:             .ReadOnly      = .T.
805:             .SpecialEffect = 1

*-- Linhas 892 a 914:
892: 
893:             IF !EMPTY(loc_cValor)
894:                 *-- Buscar descricao do grupo em SigCdGcr
895:                 loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor)
896:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDesc")
897:                 IF loc_nResult > 0
898:                     IF RECCOUNT("cursor_4c_GrupoDesc") > 0
899:                         SELECT cursor_4c_GrupoDesc
900:                         IF USED("TmpGcOpe")
901:                             REPLACE Dgrus WITH ALLTRIM(cursor_4c_GrupoDesc.Descrs) IN TmpGcOpe
902:                         ENDIF
903:                     ENDIF
904:                     USE IN cursor_4c_GrupoDesc
905:                 ENDIF
906:             ENDIF
907: 
908:             IF loc_cValor != THIS.this_cPeAntValue
909:                 THIS.this_lHouveIns = .T.
910:             ENDIF
911:         CATCH TO loException
912:             MostrarErro(loException, "FormGcp.GridCol1ValidEvent")
913:         ENDTRY
914: 

*-- Linhas 966 a 988:
966: 
967:             IF !EMPTY(loc_cValor)
968:                 *-- Buscar descricao da conta em SigCdCli
969:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor)
970:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDesc")
971:                 IF loc_nResult > 0
972:                     IF RECCOUNT("cursor_4c_ContaDesc") > 0
973:                         SELECT cursor_4c_ContaDesc
974:                         IF USED("TmpGcOpe")
975:                             REPLACE Rclis WITH ALLTRIM(cursor_4c_ContaDesc.Rclis) IN TmpGcOpe
976:                         ENDIF
977:                     ENDIF
978:                     USE IN cursor_4c_ContaDesc
979:                 ENDIF
980:             ENDIF
981: 
982:             IF loc_cValor != THIS.this_cPeAntValue
983:                 THIS.this_lHouveIns = .T.
984:             ENDIF
985:         CATCH TO loException
986:             MostrarErro(loException, "FormGcp.GridCol2ValidEvent")
987:         ENDTRY
988: 

*-- Linhas 1026 a 1044:
1026:             loc_nNovoValue = loc_oCnt.opt_4c_Permite.Value
1027: 
1028:             *-- Atualizar BlqCts em todos os registros do cursor local TmpGcOpe
1029:             UPDATE TmpGcOpe SET BlqCts = loc_nNovoValue
1030:             GO BOTTOM IN TmpGcOpe
1031: 
1032:             loc_oGrid = loc_oPg1.grd_4c_Dados
1033:             IF VARTYPE(loc_oGrid) = "O"
1034:                 loc_oGrid.Refresh()
1035:             ENDIF
1036: 
1037:             IF loc_nNovoValue != loc_nAntValue
1038:                 THIS.this_lHouveIns = .T.
1039:             ENDIF
1040:         CATCH TO loException
1041:             MostrarErro(loException, "FormGcp.OptPermiteInteractiveChange")
1042:         ENDTRY
1043:     ENDPROC
1044: 

*-- Linhas 1061 a 1094:
1061: 
1062:         *-- Evitar linha em branco duplicada
1063:         IF USED("TmpGcOpe")
1064:             SELECT TmpGcOpe
1065:             LOCATE FOR EMPTY(ALLTRIM(Grupos))
1066:             IF !EOF()
1067:                 loc_oPg1.grd_4c_Dados.Refresh()
1068:                 loc_oPg1.grd_4c_Dados.Column1.SetFocus
1069:                 RETURN
1070:             ENDIF
1071:         ENDIF
1072: 
1073:         THIS.this_lHouveIns = .T.
1074:         INSERT INTO TmpGcOpe ;
1075:             (CidChaves, Dopes, Grupos, Contas, OriDes, BlqCts) ;
1076:             VALUES ("", THIS.this_cDopesAtual, " ", " ", " ", loc_nBlqCts)
1077: 
1078:         IF USED("TmpGcOpe")
1079:             SELECT TmpGcOpe
1080:         ENDIF
1081:         loc_oPg1.grd_4c_Dados.Refresh()
1082:         loc_oPg1.grd_4c_Dados.Column1.SetFocus
1083:     ENDPROC
1084: 
1085:     *==========================================================================
1086:     * BTNALTERARCLICK - Coloca a linha corrente do grid em modo de edicao
1087:     * Em forms OPERACIONAL a edicao acontece inline no grid: dar foco na
1088:     * primeira coluna da linha selecionada equivale a "Alterar" do CRUD.
1089:     *==========================================================================
1090:     PROCEDURE BtnAlterarClick()
1091:         LOCAL loc_oPg1, loc_oGrid
1092:         loc_oPg1  = THIS.pgf_4c_Paginas.Page1
1093:         loc_oGrid = loc_oPg1.grd_4c_Dados
1094: 

*-- Linhas 1130 a 1148:
1130:             RETURN
1131:         ENDIF
1132: 
1133:         SELECT TmpGcOpe
1134: 
1135:         *-- Refresh dos campos de display (descricoes Grupo/Conta)
1136:         IF VARTYPE(loc_oCnt) = "O"
1137:             IF VARTYPE(loc_oCnt.txt_4c_Dgru) = "O"
1138:                 loc_oCnt.txt_4c_Dgru.Refresh()
1139:             ENDIF
1140:             IF VARTYPE(loc_oCnt.txt_4c_DConta) = "O"
1141:                 loc_oCnt.txt_4c_DConta.Refresh()
1142:             ENDIF
1143:             *-- Sincroniza OptionGroup com o BlqCts do registro corrente
1144:             IF VARTYPE(loc_oCnt.opt_4c_Permite) = "O"
1145:                 loc_oCnt.opt_4c_Permite.Value = IIF(TmpGcOpe.BlqCts = 2, 2, 1)
1146:             ENDIF
1147:         ENDIF
1148: 

*-- Linhas 1184 a 1207:
1184:                 loc_oBusca.Show()
1185: 
1186:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1187:                     SELECT cursor_4c_BuscaGcr
1188:                     loc_cGrupo  = ALLTRIM(Codigos)
1189:                     loc_cDescrs = ALLTRIM(Descrs)
1190: 
1191:                     IF USED("TmpGcOpe") AND !EOF("TmpGcOpe")
1192:                         SELECT TmpGcOpe
1193:                         REPLACE Grupos WITH loc_cGrupo, Dgrus WITH loc_cDescrs
1194:                         THIS.this_lHouveIns = .T.
1195:                     ENDIF
1196:                 ENDIF
1197: 
1198:                 loc_oBusca.Release()
1199:             ENDIF
1200:         CATCH TO loException
1201:             MostrarErro(loException, "FormGcp.BtnBuscarClick")
1202:         ENDTRY
1203: 
1204:         IF USED("cursor_4c_BuscaGcr")
1205:             USE IN cursor_4c_BuscaGcr
1206:         ENDIF
1207: 

*-- Linhas 1273 a 1291:
1273:             RETURN .F.
1274:         ENDIF
1275: 
1276:         SELECT TmpGcOpe
1277:         THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(CidChaves)
1278:         THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(Dopes)
1279:         THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(Grupos)
1280:         THIS.this_oBusinessObject.this_cContas    = ALLTRIM(Contas)
1281:         THIS.this_oBusinessObject.this_cOriDes    = ALLTRIM(OriDes)
1282:         THIS.this_oBusinessObject.this_nBlqCts    = BlqCts
1283:         THIS.this_oBusinessObject.this_cDgrus     = ALLTRIM(Dgrus)
1284:         THIS.this_oBusinessObject.this_cRclis     = ALLTRIM(Rclis)
1285: 
1286:         RETURN .T.
1287:     ENDPROC
1288: 
1289:     *==========================================================================
1290:     * BOPARAFORM - Transfere dados do BO para os campos de display do formulario
1291:     * OPERACIONAL: atualiza TextBoxes de descricao (Dgru/DConta)


### BO (C:\4c\projeto\app\classes\GcpBO.prg):
*==============================================================================
* GcpBO.prg
* Business Object: Grupos/Contas Permitidas por Operacao (SigCdGcp)
* Herda de: BusinessBase
*
* Tabela principal: SigCdGcp
* Chave primaria  : cidchaves (char 20, gerado via GerarCidChaves)
*
* SigCdGcp schema:
*   cidchaves  char(20) PK
*   contas     char(10) FK SigCdCli.iclis
*   dopes      char(20) FK SigCdOpe.Dopes
*   grupos     char(10) FK SigCdGcr.Codigos
*   orides     char(1)  O=Origem / D=Destino / A=Ambos
*   blqcts     numeric(1,0)  1=Permitidas / 2=Nao Permitidas
*==============================================================================

DEFINE CLASS GcpBO AS BusinessBase

    *-- Identificacao da tabela (exigido pelo BusinessBase)
    this_cTabela     = "SigCdGcp"
    this_cCampoChave = "cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades de dados - mapeamento direto das colunas de SigCdGcp
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && char(20) - chave unica PK
    this_cContas    = ""   && char(10) - codigo da conta/cliente (FK SigCdCli.iclis)
    this_cDopes     = ""   && char(20) - codigo da operacao (FK SigCdOpe.Dopes)
    this_cGrupos    = ""   && char(10) - codigo do grupo contabil (FK SigCdGcr.Codigos)
    this_cOriDes    = ""   && char(1)  - O=Origem / D=Destino / A=Ambos
    this_nBlqCts    = 0    && numeric(1,0) - 1=Permitidas / 2=Nao Permitidas

    *--------------------------------------------------------------------------
    * Propriedades desnormalizadas (preenchidas via JOIN no carregamento)
    *--------------------------------------------------------------------------
    this_cDgrus = ""   && descricao do grupo  (SigCdGcr.Descrs)
    this_cRclis = ""   && nome do cliente/conta (SigCdCli.Rclis)

    *--------------------------------------------------------------------------
    * Propriedades de contexto de colecao
    * Este BO gerencia um CONJUNTO de registros para uma operacao
    *--------------------------------------------------------------------------
    this_cDopesAtual  = ""  && operacao atualmente sendo editada (filtro da colecao)
    this_nBlqCtsAtual = 1   && status da colecao (1=Permitidas / 2=Nao Permitidas)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGcp"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para o sistema de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCidChaves - Gera chave unica de 20 caracteres (substituto de fUniqueIds)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarCidChaves()
        LOCAL loc_cParte1, loc_cParte2
        loc_cParte1 = ALLTRIM(SYS(2015))
        loc_cParte2 = ALLTRIM(SYS(2015))
        RETURN PADR(loc_cParte1 + loc_cParte2, 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cContas    = TratarNulo(contas,    "C")
            THIS.this_cDopes     = TratarNulo(dopes,     "C")
            THIS.this_cGrupos    = TratarNulo(grupos,    "C")
            THIS.this_cOriDes    = TratarNulo(orides,    "C")
            THIS.this_nBlqCts    = TratarNulo(blqcts,    "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigCdGcp com JOIN de descricoes
    * par_cFiltro: filtro adicional WHERE (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = "WHERE 1=1"
            IF !EMPTY(THIS.this_cDopesAtual)
                loc_cWhere = loc_cWhere + " AND a.Dopes = " + EscaparSQL(THIS.this_cDopesAtual)
            ENDIF
            IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = loc_cWhere + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.Contas, a.Dopes, a.Grupos," + ;
                       " a.OriDes, a.BlqCts," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " " + loc_cWhere + ;
                       " ORDER BY a.Grupos, a.Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao buscar grupos/contas:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo CidChaves
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.Contas, a.Dopes, a.Grupos," + ;
                       " a.OriDes, a.BlqCts," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " WHERE a.CidChaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um registro em SigCdGcp (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = THIS.GerarCidChaves()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdGcp" + ;
                       " (CidChaves, Contas, Dopes, Grupos, OriDes, BlqCts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cContas)    + ", " + ;
                       EscaparSQL(THIS.this_cDopes)     + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                       EscaparSQL(THIS.this_cOriDes)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqCts) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro em SigCdGcp (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGcp SET" + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas)         + "," + ;
                       " Dopes  = " + EscaparSQL(THIS.this_cDopes)          + "," + ;
                       " Grupos = " + EscaparSQL(THIS.this_cGrupos)         + "," + ;
                       " OriDes = " + EscaparSQL(THIS.this_cOriDes)         + "," + ;
                       " BlqCts = " + FormatarNumeroSQL(THIS.this_nBlqCts)  + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de um registro (chamado por BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGcp" + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao excluir grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTmpGcOpe - Cria cursor local TmpGcOpe com dados de uma operacao
    * par_cDopes  : codigo da operacao (SigCdOpe.Dopes)
    * par_nBlqCts : BlqCts inicial (1=Permitidas / 2=Nao Permitidas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTmpGcOpe(par_cDopes, par_nBlqCts)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cDopesAtual  = par_cDopes
            THIS.this_nBlqCtsAtual = par_nBlqCts

            IF USED("TmpGcOpe")
                USE IN TmpGcOpe
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpGcOpe ;
                (CidChaves C(20), Dopes C(20), Grupos C(10), Contas C(10), ;
                 Dgrus C(60), Rclis C(80), OriDes C(1), BlqCts N(1))
            SET NULL OFF

            loc_cSQL = "SELECT a.CidChaves, a.Dopes, a.Grupos, a.Contas," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis," + ;
                       " a.OriDes, a.BlqCts" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " WHERE a.Dopes = " + EscaparSQL(par_cDopes) + ;
                       " ORDER BY a.Grupos, a.Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcpTemp")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_GcpTemp") > 0
                    SELECT TmpGcOpe
                    APPEND FROM DBF("cursor_4c_GcpTemp")
                ENDIF
                SELECT TmpGcOpe
                GO TOP
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao carregar grupos/contas da opera" + ;
                            CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_GcpTemp")
                USE IN cursor_4c_GcpTemp
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.CarregarTmpGcOpe")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicatas - Verifica se ha Grupos/Contas duplicados no TmpGcOpe
    * Retorna .T. se NAO ha duplicatas (pode salvar)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicatas()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        TRY
            IF USED("cursor_4c_SecKey")
                USE IN cursor_4c_SecKey
            ENDIF

            SELECT Grupos, Contas, SUM(1) AS Total ;
                FROM TmpGcOpe ;
                GROUP BY Grupos, Contas ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_SecKey NOFILTER

            IF RECCOUNT("cursor_4c_SecKey") > 0
                MostrarErro("Existem Grupos/Contas em duplicidade. Favor acertar!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_SecKey")
                USE IN cursor_4c_SecKey
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarDuplicatas")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarTmpGcOpe - Persiste TmpGcOpe no banco (SigCdGcp) para a operacao
    * Deleta registros antigos da operacao e insere os do TmpGcOpe
    * par_cDopes  : codigo da operacao
    * par_nBlqCts : BlqCts a aplicar em todos os registros
    *--------------------------------------------------------------------------
    PROCEDURE SalvarTmpGcOpe(par_cDopes, par_nBlqCts)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_cChave, loc_cGrupos, loc_cContas, loc_cOriDes, loc_nBlqCts
        loc_lResultado = .F.

        TRY
            IF !USED("TmpGcOpe")
                MostrarErro("Cursor TmpGcOpe n" + CHR(227) + ;
                            "o encontrado!", "Erro")
            ELSE
                *-- Remove linhas em branco do cursor local
                SELECT TmpGcOpe
                DELETE FOR EMPTY(ALLTRIM(Grupos)) OR EMPTY(ALLTRIM(Contas))
                PACK

                *-- Valida duplicatas antes de persistir
                IF !THIS.ValidarDuplicatas()
                    loc_lResultado = .F.
                ELSE
                    *-- Atualiza Dopes e BlqCts em todo o cursor local
                    SELECT TmpGcOpe
                    REPLACE ALL Dopes WITH par_cDopes, BlqCts WITH par_nBlqCts

                    *-- Garante CidChaves em linhas novas
                    GO TOP
                    DO WHILE !EOF()
                        IF EMPTY(ALLTRIM(CidChaves))
                            REPLACE CidChaves WITH THIS.GerarCidChaves()
                        ENDIF
                        SKIP
                    ENDDO

                    *-- Persiste no SQL Server em transacao atomica
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trn")
                    IF USED("cursor_4c_Trn")
                        USE IN cursor_4c_Trn
                    ENDIF

                    *-- Deleta registros antigos da operacao
                    loc_cSQL = "DELETE FROM SigCdGcp WHERE Dopes = " + ;
                               EscaparSQL(par_cDopes)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                    IF USED("cursor_4c_Del")
                        USE IN cursor_4c_Del
                    ENDIF

                    IF loc_nResultado < 0
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
                        IF USED("cursor_4c_Rb")
                            USE IN cursor_4c_Rb
                        ENDIF
                        MostrarErro("Erro ao limpar registros antigos:" + CHR(13) + ;
                                    CapturarErroSQL(), "Erro SQL")
                        loc_lResultado = .F.
                    ELSE
                        *-- Insere linhas do TmpGcOpe
                        SELECT TmpGcOpe
                        GO TOP
                        loc_lResultado = .T.

                        DO WHILE !EOF() AND loc_lResultado
                            loc_cChave  = ALLTRIM(CidChaves)
                            loc_cGrupos = ALLTRIM(Grupos)
                            loc_cContas = ALLTRIM(Contas)
                            loc_cOriDes = ALLTRIM(OriDes)
                            loc_nBlqCts = BlqCts

                            loc_cSQL = "INSERT INTO SigCdGcp" + ;
                                       " (CidChaves, Dopes, Grupos, Contas, OriDes, BlqCts)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cChave)  + ", " + ;
                                       EscaparSQL(par_cDopes)  + ", " + ;
                                       EscaparSQL(loc_cGrupos) + ", " + ;
                                       EscaparSQL(loc_cContas) + ", " + ;
                                       EscaparSQL(loc_cOriDes) + ", " + ;
                                       FormatarNumeroSQL(loc_nBlqCts) + ;
                                       ")"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                            IF USED("cursor_4c_Ins")
                                USE IN cursor_4c_Ins
                            ENDIF

                            IF loc_nResultado < 0
                                MostrarErro("Erro ao inserir linha:" + CHR(13) + ;
                                            CapturarErroSQL(), "Erro SQL")
                                loc_lResultado = .F.
                            ENDIF

                            SKIP
                        ENDDO

                        IF loc_lResultado
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_Cmt")
                            IF USED("cursor_4c_Cmt")
                                USE IN cursor_4c_Cmt
                            ENDIF
                            THIS.RegistrarAuditoria("INSERT")
                        ELSE
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
                            IF USED("cursor_4c_Rb")
                                USE IN cursor_4c_Rb
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
            IF USED("cursor_4c_Rb")
                USE IN cursor_4c_Rb
            ENDIF
            MostrarErro(loException, "GcpBO.SalvarTmpGcOpe")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida Grupo em SigCdGcr e retorna descricao
    * par_cGrupo : codigo a validar
    * par_cDescrs: (BYREF OUTPUT) descricao encontrada
    * Retorna .T. se grupo existe
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_cGrupo, par_cDescrs)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        par_cDescrs    = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cGrupo))
                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF

                loc_cSQL = "SELECT Descrs FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(par_cGrupo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Gcr") > 0
                    SELECT cursor_4c_Gcr
                    par_cDescrs = ALLTRIM(Descrs)
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarGrupo")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida Conta em SigCdCli e retorna Rclis
    * par_cConta : codigo da conta (SigCdCli.Iclis) a validar
    * par_cRclis : (BYREF OUTPUT) nome/razao social do cliente
    * Retorna .T. se conta existe
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta(par_cConta, par_cRclis)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        par_cRclis     = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cConta))
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF

                loc_cSQL = "SELECT Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(par_cConta)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cli") > 0
                    SELECT cursor_4c_Cli
                    par_cRclis = ALLTRIM(Rclis)
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarConta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("TmpGcOpe")
            USE IN TmpGcOpe
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

