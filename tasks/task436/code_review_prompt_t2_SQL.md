# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormGcp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1411 linhas total):

*-- Linhas 276 a 317:
276:                     loc_oGrid = loc_oPg1.grd_4c_Dados
277:                     IF VARTYPE(loc_oGrid) = "O"
278:                         loc_oGrid.RecordSource = "TmpGcOpe"
279:                         loc_oGrid.Column1.ControlSource = "TmpGcOpe.Grupos"
280:                         loc_oGrid.Column2.ControlSource = "TmpGcOpe.Contas"
281:                         loc_oGrid.Column3.ControlSource = "TmpGcOpe.OriDes"
282:                         loc_oGrid.Column1.Header1.Caption = "Grupo"
283:                         loc_oGrid.Column2.Header1.Caption = "Conta"
284:                         loc_oGrid.Column3.Header1.Caption = "O/D/A"
285:                         *-- DynamicForeColor: azul para Permitidas (BlqCts!=2), rosa para Nao Permitidas (BlqCts=2)
286:                         loc_oGrid.SetAll("DynamicForeColor", ;
287:                             "IIF(TmpGcOpe.BlqCts = 2, RGB(255,0,128), RGB(0,0,128))", "Column")
288:                         loc_oGrid.Refresh()
289:                     ENDIF
290: 
291:                     *-- ControlSource dos campos de display (requer TmpGcOpe ativo)
292:                     IF VARTYPE(loc_oCnt) = "O"
293:                         IF VARTYPE(loc_oCnt.txt_4c_Dgru) = "O"
294:                             loc_oCnt.txt_4c_Dgru.ControlSource = "TmpGcOpe.Dgrus"
295:                         ENDIF
296:                         IF VARTYPE(loc_oCnt.txt_4c_DConta) = "O"
297:                             loc_oCnt.txt_4c_DConta.ControlSource = "TmpGcOpe.Rclis"
298:                         ENDIF
299: 
300:                         *-- Valor inicial do OptionGroup baseado no BlqCts do primeiro registro
301:                         IF VARTYPE(loc_oCnt.opt_4c_Permite) = "O"
302:                             SELECT TmpGcOpe
303:                             GO TOP IN TmpGcOpe
304:                             IF !EOF("TmpGcOpe")
305:                                 loc_oCnt.opt_4c_Permite.Value = IIF(TmpGcOpe.BlqCts = 2, 2, 1)
306:                             ENDIF
307:                         ENDIF
308:                     ENDIF
309:                 ENDIF
310:             ENDIF
311:         CATCH TO loException
312:             MostrarErro(loException, "FormGcp.CarregarDados")
313:         ENDTRY
314: 
315:         RETURN loc_lResultado
316:     ENDPROC
317: 

*-- Linhas 562 a 580:
562:             .HighlightBackColor = RGB(255, 255, 255)
563:             .HighlightForeColor = RGB(15, 41, 104)
564:             .HighlightStyle     = 2
565:             .DeleteMark         = .F.
566:             .RecordMark         = .F.
567:             .RowHeight          = 16
568:             .ScrollBars         = 2
569:             .GridLines          = 3
570:             .Visible            = .T.
571:         ENDWITH
572: 
573:         loc_oGrid.Column1.Width          = 60
574:         loc_oGrid.Column1.Header1.Caption = "Grupo"
575:         loc_oGrid.Column2.Width          = 100
576:         loc_oGrid.Column2.Header1.Caption = "Conta"
577:         loc_oGrid.Column3.Width          = 75
578:         loc_oGrid.Column3.Header1.Caption = "O/D/A"
579: 
580:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridDadosAfterRowColChange")

*-- Linhas 619 a 672:
619: 
620:         *-- Verificar se ja ha linha em branco (nao inserir multiplas linhas vazias)
621:         IF USED("TmpGcOpe")
622:             SELECT TmpGcOpe
623:             LOCATE FOR EMPTY(ALLTRIM(Grupos))
624:             IF !EOF()
625:                 loc_oPg1.grd_4c_Dados.Refresh()
626:                 loc_oPg1.grd_4c_Dados.Column1.SetFocus
627:                 RETURN
628:             ENDIF
629:         ENDIF
630: 
631:         *-- Inserir nova linha com valores padrao em branco
632:         THIS.this_lHouveIns = .T.
633: 
634:         INSERT INTO TmpGcOpe ;
635:             (CidChaves, Dopes, Grupos, Contas, OriDes, BlqCts) ;
636:             VALUES ("", THIS.this_cDopesAtual, " ", " ", " ", loc_nBlqCts)
637: 
638:         IF USED("TmpGcOpe")
639:             SELECT TmpGcOpe
640:         ENDIF
641: 
642:         loc_oPg1.grd_4c_Dados.Refresh()
643:         loc_oPg1.grd_4c_Dados.Column1.SetFocus
644:     ENDPROC
645: 
646:     *==========================================================================
647:     * BTNEXCLUIRCLICK - Exclui linha selecionada do TmpGcOpe
648:     * Equivale a cmdExcluir.Click do legado
649:     *==========================================================================
650:     PROCEDURE BtnExcluirClick()
651:         LOCAL loc_oPg1
652:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
653: 
654:         IF USED("TmpGcOpe") AND !EOF("TmpGcOpe")
655:             THIS.this_lHouveExcl = .T.
656:             SELECT TmpGcOpe
657:             DELETE
658:             SKIP
659:             SKIP -1
660:         ENDIF
661: 
662:         loc_oPg1.grd_4c_Dados.Refresh()
663:     ENDPROC
664: 
665:     *==========================================================================
666:     * BTNENCERRARCLICK - Salva mudancas e fecha o popup
667:     * Equivale a cmdSair.Click do legado (inclui validacao de duplicatas via BO)
668:     *==========================================================================
669:     PROCEDURE BtnEncerrarClick()
670:         LOCAL loc_lResultado, loc_nBlqCts, loc_oPg1
671:         loc_lResultado = .T.
672:         loc_nBlqCts    = THIS.this_oBusinessObject.this_nBlqCtsAtual

*-- Linhas 789 a 807:
789:         * Equivale a Get_DConta do legado (When retorna .F. = nao editavel)
790:         * Original: Top=344, Left=104, Width=289, Height=23
791:         * No container (Top=349): relative Top = 344+29-349 = 24
792:         * ControlSource = "TmpGcOpe.Rclis" (setado em CarregarDados)
793:         *----------------------------------------------------------------------
794:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
795:         WITH loc_oCnt.txt_4c_DConta
796:             .Top           = 24
797:             .Left          = 104
798:             .Width         = 289
799:             .Height        = 23
800:             .FontName      = "Tahoma"
801:             .FontSize      = 8
802:             .FontBold      = .T.
803:             .ForeColor     = RGB(90, 90, 90)
804:             .BackColor     = RGB(255, 255, 225)
805:             .Value         = ""
806:             .ReadOnly      = .T.
807:             .SpecialEffect = 1

*-- Linhas 894 a 916:
894: 
895:             IF !EMPTY(loc_cValor)
896:                 *-- Buscar descricao do grupo em SigCdGcr
897:                 loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor)
898:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDesc")
899:                 IF loc_nResult > 0
900:                     IF RECCOUNT("cursor_4c_GrupoDesc") > 0
901:                         SELECT cursor_4c_GrupoDesc
902:                         IF USED("TmpGcOpe")
903:                             REPLACE Dgrus WITH ALLTRIM(cursor_4c_GrupoDesc.Descrs) IN TmpGcOpe
904:                         ENDIF
905:                     ENDIF
906:                     USE IN cursor_4c_GrupoDesc
907:                 ENDIF
908:             ENDIF
909: 
910:             IF loc_cValor != THIS.this_cPeAntValue
911:                 THIS.this_lHouveIns = .T.
912:             ENDIF
913:         CATCH TO loException
914:             MostrarErro(loException, "FormGcp.GridCol1ValidEvent")
915:         ENDTRY
916: 

*-- Linhas 968 a 990:
968: 
969:             IF !EMPTY(loc_cValor)
970:                 *-- Buscar descricao da conta em SigCdCli
971:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor)
972:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDesc")
973:                 IF loc_nResult > 0
974:                     IF RECCOUNT("cursor_4c_ContaDesc") > 0
975:                         SELECT cursor_4c_ContaDesc
976:                         IF USED("TmpGcOpe")
977:                             REPLACE Rclis WITH ALLTRIM(cursor_4c_ContaDesc.Rclis) IN TmpGcOpe
978:                         ENDIF
979:                     ENDIF
980:                     USE IN cursor_4c_ContaDesc
981:                 ENDIF
982:             ENDIF
983: 
984:             IF loc_cValor != THIS.this_cPeAntValue
985:                 THIS.this_lHouveIns = .T.
986:             ENDIF
987:         CATCH TO loException
988:             MostrarErro(loException, "FormGcp.GridCol2ValidEvent")
989:         ENDTRY
990: 

*-- Linhas 1028 a 1046:
1028:             loc_nNovoValue = loc_oCnt.opt_4c_Permite.Value
1029: 
1030:             *-- Atualizar BlqCts em todos os registros do cursor local TmpGcOpe
1031:             UPDATE TmpGcOpe SET BlqCts = loc_nNovoValue
1032:             GO BOTTOM IN TmpGcOpe
1033: 
1034:             loc_oGrid = loc_oPg1.grd_4c_Dados
1035:             IF VARTYPE(loc_oGrid) = "O"
1036:                 loc_oGrid.Refresh()
1037:             ENDIF
1038: 
1039:             IF loc_nNovoValue != loc_nAntValue
1040:                 THIS.this_lHouveIns = .T.
1041:             ENDIF
1042:         CATCH TO loException
1043:             MostrarErro(loException, "FormGcp.OptPermiteInteractiveChange")
1044:         ENDTRY
1045:     ENDPROC
1046: 

*-- Linhas 1063 a 1096:
1063: 
1064:         *-- Evitar linha em branco duplicada
1065:         IF USED("TmpGcOpe")
1066:             SELECT TmpGcOpe
1067:             LOCATE FOR EMPTY(ALLTRIM(Grupos))
1068:             IF !EOF()
1069:                 loc_oPg1.grd_4c_Dados.Refresh()
1070:                 loc_oPg1.grd_4c_Dados.Column1.SetFocus
1071:                 RETURN
1072:             ENDIF
1073:         ENDIF
1074: 
1075:         THIS.this_lHouveIns = .T.
1076:         INSERT INTO TmpGcOpe ;
1077:             (CidChaves, Dopes, Grupos, Contas, OriDes, BlqCts) ;
1078:             VALUES ("", THIS.this_cDopesAtual, " ", " ", " ", loc_nBlqCts)
1079: 
1080:         IF USED("TmpGcOpe")
1081:             SELECT TmpGcOpe
1082:         ENDIF
1083:         loc_oPg1.grd_4c_Dados.Refresh()
1084:         loc_oPg1.grd_4c_Dados.Column1.SetFocus
1085:     ENDPROC
1086: 
1087:     *==========================================================================
1088:     * BTNALTERARCLICK - Coloca a linha corrente do grid em modo de edicao
1089:     * Em forms OPERACIONAL a edicao acontece inline no grid: dar foco na
1090:     * primeira coluna da linha selecionada equivale a "Alterar" do CRUD.
1091:     *==========================================================================
1092:     PROCEDURE BtnAlterarClick()
1093:         LOCAL loc_oPg1, loc_oGrid
1094:         loc_oPg1  = THIS.pgf_4c_Paginas.Page1
1095:         loc_oGrid = loc_oPg1.grd_4c_Dados
1096: 

*-- Linhas 1132 a 1150:
1132:             RETURN
1133:         ENDIF
1134: 
1135:         SELECT TmpGcOpe
1136: 
1137:         *-- Refresh dos campos de display (descricoes Grupo/Conta)
1138:         IF VARTYPE(loc_oCnt) = "O"
1139:             IF VARTYPE(loc_oCnt.txt_4c_Dgru) = "O"
1140:                 loc_oCnt.txt_4c_Dgru.Refresh()
1141:             ENDIF
1142:             IF VARTYPE(loc_oCnt.txt_4c_DConta) = "O"
1143:                 loc_oCnt.txt_4c_DConta.Refresh()
1144:             ENDIF
1145:             *-- Sincroniza OptionGroup com o BlqCts do registro corrente
1146:             IF VARTYPE(loc_oCnt.opt_4c_Permite) = "O"
1147:                 loc_oCnt.opt_4c_Permite.Value = IIF(TmpGcOpe.BlqCts = 2, 2, 1)
1148:             ENDIF
1149:         ENDIF
1150: 

*-- Linhas 1186 a 1209:
1186:                 loc_oBusca.Show()
1187: 
1188:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1189:                     SELECT cursor_4c_BuscaGcr
1190:                     loc_cGrupo  = ALLTRIM(Codigos)
1191:                     loc_cDescrs = ALLTRIM(Descrs)
1192: 
1193:                     IF USED("TmpGcOpe") AND !EOF("TmpGcOpe")
1194:                         SELECT TmpGcOpe
1195:                         REPLACE Grupos WITH loc_cGrupo, Dgrus WITH loc_cDescrs
1196:                         THIS.this_lHouveIns = .T.
1197:                     ENDIF
1198:                 ENDIF
1199: 
1200:                 loc_oBusca.Release()
1201:             ENDIF
1202:         CATCH TO loException
1203:             MostrarErro(loException, "FormGcp.BtnBuscarClick")
1204:         ENDTRY
1205: 
1206:         IF USED("cursor_4c_BuscaGcr")
1207:             USE IN cursor_4c_BuscaGcr
1208:         ENDIF
1209: 

*-- Linhas 1275 a 1293:
1275:             RETURN .F.
1276:         ENDIF
1277: 
1278:         SELECT TmpGcOpe
1279:         THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(CidChaves)
1280:         THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(Dopes)
1281:         THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(Grupos)
1282:         THIS.this_oBusinessObject.this_cContas    = ALLTRIM(Contas)
1283:         THIS.this_oBusinessObject.this_cOriDes    = ALLTRIM(OriDes)
1284:         THIS.this_oBusinessObject.this_nBlqCts    = BlqCts
1285:         THIS.this_oBusinessObject.this_cDgrus     = ALLTRIM(Dgrus)
1286:         THIS.this_oBusinessObject.this_cRclis     = ALLTRIM(Rclis)
1287: 
1288:         RETURN .T.
1289:     ENDPROC
1290: 
1291:     *==========================================================================
1292:     * BOPARAFORM - Transfere dados do BO para os campos de display do formulario
1293:     * OPERACIONAL: atualiza TextBoxes de descricao (Dgru/DConta)


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

            loc_cWhere = ""
            IF !EMPTY(THIS.this_cDopesAtual)
                loc_cWhere = "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopesAtual)
            ENDIF
            IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = "WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
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

