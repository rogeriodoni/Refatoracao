# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FPAGS, VALUE, NPARCS, VALMAXS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FPAGS, VALUE, NPARCS, VALMAXS

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
lcSql = [Select * From SigOpFpI Where Fpags = ']+crTSigfPag.Fpags+[']
If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'xFpagI') < 1
Select xFpagI
	Insert Into CrSigOpFpI From array Memvar
Select xFpagI
	.Column2.ControlSource = 'xFPagi.nparcs'
	.Column3.ControlSource = 'xFPagi.valmins'
	.Column1.ControlSource = 'xFPagi.ValMaxs'
	.Column4.ControlSource = 'xFPagi.Emps'
	Select xFPagI
	Seek (xfPagi.fpags + Str(This.Value,2))
	Select xFPagI
Insert Into xFPagI (fPags) Values ( crTSigfPag.fpags )
Select xFPagi
Select xFPagi
	Delete
	Select nParcs,sum(1) From xFPagi Where nParcs > 0 Or xFPagi.ValMaxs > 0 ;
	Select TT
	Select crSigOpFpi
	Select xFPagi
			Insert Into crSigOpFpi From array memvar
			SELECT crSigOpFpi
			SELECT xFPagi
	Retorno=TSigfpg.podatamgr.Update("crSigOpFpi")

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormFpm.prg) - TRECHOS RELEVANTES PARA PASS SQL (1326 linhas total):

*-- Linhas 296 a 314:
296:                 .ColumnCount   = 4
297:                 .FontName      = "Tahoma"
298:                 .FontSize      = 8
299:                 .DeleteMark    = .F.
300:                 .RecordMark    = .F.
301:                 .RowHeight     = 16
302:                 .ScrollBars    = 2
303:                 .GridLineColor = RGB(238, 238, 238)
304: 
305:                 *-- Column1: Parcelas (nParcs), Width=60
306:                 WITH .Column1
307:                     .Width     = 60
308:                     .Movable   = .F.
309:                     .Resizable = .F.
310:                     .FontName  = "Tahoma"
311:                     .FontSize  = 8
312:                     WITH .Header1
313:                         .FontName  = "Tahoma"
314:                         .FontSize  = 8

*-- Linhas 636 a 669:
636: 
637:     *--------------------------------------------------------------------------
638:     * VincularGrid - Vincula grd_4c_Dados ao cursor_4c_FpagI
639:     * Define ControlSource de cada coluna apos CarregarDados
640:     *--------------------------------------------------------------------------
641:     PROCEDURE VincularGrid()
642:         LOCAL loc_oGrid, loc_oErro
643:         TRY
644:             IF !USED("cursor_4c_FpagI")
645:                 RETURN
646:             ENDIF
647:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
648:             WITH loc_oGrid
649:                 .ColumnCount           = 4
650:                 .RecordSource          = "cursor_4c_FpagI"
651:                 .Column1.ControlSource = "cursor_4c_FpagI.nParcs"
652:                 .Column2.ControlSource = "cursor_4c_FpagI.ValMins"
653:                 .Column3.ControlSource = "cursor_4c_FpagI.ValMaxs"
654:                 .Column4.ControlSource = "cursor_4c_FpagI.Emps"
655:             ENDWITH
656:             loc_oGrid.Column1.Header1.Caption = "Parcelas"
657:             loc_oGrid.Column2.Header1.Caption = "Valor M" + CHR(237) + "nimo"
658:             loc_oGrid.Column3.Header1.Caption = "Valor M" + CHR(225) + "ximo"
659:             loc_oGrid.Column4.Header1.Caption = "Emp"
660:             loc_oGrid.Refresh()
661:         CATCH TO loc_oErro
662:             MsgErro(loc_oErro.Message + CHR(13) + ;
663:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
664:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.VincularGrid")
665:         ENDTRY
666:     ENDPROC
667: 
668:     *--------------------------------------------------------------------------
669:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)

*-- Linhas 687 a 737:
687: 
688:     *--------------------------------------------------------------------------
689:     * BtnInserirClick - Insere nova linha em branco com o fpags corrente
690:     * Original: Insert Into xFPagI (fPags) Values (crTSigfPag.fpags)
691:     *--------------------------------------------------------------------------
692:     PROCEDURE BtnInserirClick()
693:         LOCAL loc_oErro
694:         TRY
695:             IF !USED("cursor_4c_FpagI")
696:                 RETURN
697:             ENDIF
698:             SELECT cursor_4c_FpagI
699:             INSERT INTO cursor_4c_FpagI (Fpags) VALUES (THIS.this_cFpags)
700:             THIS.GravaDados = .T.
701:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column1.SetFocus
702:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
703:         CATCH TO loc_oErro
704:             MsgErro(loc_oErro.Message + CHR(13) + ;
705:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
706:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnInserirClick")
707:         ENDTRY
708:     ENDPROC
709: 
710:     *--------------------------------------------------------------------------
711:     * BtnExcluirClick - Marca linha corrente como excluida
712:     * Original: Delete (marca exclusao no cursor local)
713:     *--------------------------------------------------------------------------
714:     PROCEDURE BtnExcluirClick()
715:         LOCAL loc_oErro
716:         TRY
717:             IF !USED("cursor_4c_FpagI") OR EOF("cursor_4c_FpagI")
718:                 RETURN
719:             ENDIF
720:             SELECT cursor_4c_FpagI
721:             IF !EOF()
722:                 DELETE
723:             ENDIF
724:             THIS.GravaDados = .T.
725:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
726:         CATCH TO loc_oErro
727:             MsgErro(loc_oErro.Message + CHR(13) + ;
728:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
729:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.BtnExcluirClick")
730:         ENDTRY
731:     ENDPROC
732: 
733:     *--------------------------------------------------------------------------
734:     * BtnEncerrarClick - Valida, salva alteracoes e fecha o form
735:     * Original: Valida duplicatas, atualiza crSigOpFpi, commit, Release
736:     *--------------------------------------------------------------------------
737:     PROCEDURE BtnEncerrarClick()

*-- Linhas 762 a 796:
762: 
763:     *--------------------------------------------------------------------------
764:     * ValidarParcelas - Verifica se ha nParcs duplicados no cursor
765:     * Original: SELECT nParcs, sum(1) FROM xFPagi GROUP BY nparcs HAVING sum(1)>1
766:     *--------------------------------------------------------------------------
767:     PROTECTED PROCEDURE ValidarParcelas()
768:         LOCAL loc_lValido, loc_oErro
769:         loc_lValido = .T.
770:         TRY
771:             IF USED("cursor_4c_ValidTT")
772:                 USE IN cursor_4c_ValidTT
773:             ENDIF
774:             IF USED("cursor_4c_FpagI")
775:                 SELECT nParcs, COUNT(*) AS nQtd ;
776:                     FROM cursor_4c_FpagI ;
777:                     WHERE !DELETED() AND (nParcs > 0 OR ValMaxs > 0) ;
778:                     GROUP BY nParcs ;
779:                     HAVING COUNT(*) > 1 ;
780:                     INTO CURSOR cursor_4c_ValidTT READWRITE
781:                 SELECT cursor_4c_ValidTT
782:                 IF RECCOUNT("cursor_4c_ValidTT") > 0
783:                     MsgAviso("Dados Inconsistentes!!!", "Validar")
784:                     loc_lValido = .F.
785:                 ENDIF
786:                 IF USED("cursor_4c_ValidTT")
787:                     USE IN cursor_4c_ValidTT
788:                 ENDIF
789:             ENDIF
790:         CATCH TO loc_oErro
791:             MsgErro(loc_oErro.Message + CHR(13) + ;
792:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
793:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.ValidarParcelas")
794:             loc_lValido = .F.
795:         ENDTRY
796:         RETURN loc_lValido

*-- Linhas 814 a 846:
814: 
815:         LOCAL loc_oGrid, loc_nParcs, loc_nValMaxs, loc_nCurRec, loc_lDuplicado, loc_cEmps, loc_oErro
816:         TRY
817:             SELECT cursor_4c_FpagI
818:             loc_nParcs   = NVL(cursor_4c_FpagI.nParcs, 0)
819:             loc_nValMaxs = NVL(cursor_4c_FpagI.ValMaxs, 0)
820:             loc_oGrid    = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
821: 
822:             *-- Ao sair da coluna 1 (nParcs): validar duplicatas
823:             IF par_nColIndex = 1 AND loc_nParcs > 0
824:                 loc_nCurRec  = RECNO("cursor_4c_FpagI")
825:                 loc_lDuplicado = .F.
826:                 SCAN FOR !DELETED() AND nParcs = loc_nParcs AND RECNO() != loc_nCurRec
827:                     loc_lDuplicado = .T.
828:                     EXIT
829:                 ENDSCAN
830:                 IF loc_lDuplicado
831:                     SELECT cursor_4c_FpagI
832:                     GOTO loc_nCurRec
833:                     MsgAviso("N" + CHR(250) + "mero de Parcelas j" + CHR(225) + ;
834:                         " Digitada para esta Condi" + CHR(231) + CHR(227) + ;
835:                         "o de Pagamento.", "Validar")
836:                     THIS.this_lRedirigindo = .T.
837:                     REPLACE nParcs WITH 0 IN cursor_4c_FpagI
838:                     THIS.this_lRedirigindo = .F.
839:                     loc_nParcs = 0
840:                     loc_oGrid.Refresh()
841:                 ENDIF
842:             ENDIF
843: 
844:             *-- Atualizar ReadOnly por coluna (logica do When original):
845:             *-- Col1 (nParcs):  editavel quando ValMaxs = 0
846:             *-- Col2 (ValMins): editavel quando nParcs > 0

*-- Linhas 859 a 877:
859:             IF par_nColIndex = 4
860:                 loc_cEmps = ALLTRIM(NVL(cursor_4c_FpagI.emps, ""))
861:                 IF !EMPTY(loc_cEmps) AND !THIS.ValidarEmps(loc_cEmps)
862:                     SELECT cursor_4c_FpagI
863:                     REPLACE emps WITH "" IN cursor_4c_FpagI
864:                     loc_oGrid.Refresh()
865:                 ENDIF
866:             ENDIF
867: 
868:         CATCH TO loc_oErro
869:             THIS.this_lRedirigindo = .F.
870:             MsgErro(loc_oErro.Message + CHR(13) + ;
871:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
872:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.GrdDadosAfterRowColChange")
873:         ENDTRY
874:     ENDPROC
875: 
876:     *--------------------------------------------------------------------------
877:     * ValidarEmps - Verifica se codigo de empresa existe em SigCdEmp

*-- Linhas 888 a 908:
888:             IF USED("cursor_4c_EmpValida")
889:                 USE IN cursor_4c_EmpValida
890:             ENDIF
891:             loc_cSQL = "SELECT Cemps FROM SigCdEmp " + ;
892:                        "WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cEmps))
893:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValida") > 0
894:                 IF RECCOUNT("cursor_4c_EmpValida") = 0
895:                     MsgAviso("Empresa " + ALLTRIM(par_cEmps) + ;
896:                         " n" + CHR(227) + "o encontrada em SigCdEmp.", ;
897:                         "Empresa")
898:                     loc_lValido = .F.
899:                 ENDIF
900:                 IF USED("cursor_4c_EmpValida")
901:                     USE IN cursor_4c_EmpValida
902:                 ENDIF
903:             ELSE
904:                 MsgErro("Falha ao verificar empresa " + ALLTRIM(par_cEmps) + ".", ;
905:                     "FormFpm.ValidarEmps")
906:                 loc_lValido = .F.
907:             ENDIF
908:         CATCH TO loc_oErro

*-- Linhas 982 a 1000:
982:                 loc_oGrid.SetFocus
983:                 RETURN
984:             ENDIF
985:             SELECT cursor_4c_FpagI
986:             loc_nParcs   = NVL(cursor_4c_FpagI.nParcs, 0)
987:             loc_nValMaxs = NVL(cursor_4c_FpagI.ValMaxs, 0)
988:             THIS.this_lRedirigindo = .T.
989:             loc_oGrid.Column1.ReadOnly = (loc_nValMaxs <> 0)
990:             loc_oGrid.Column2.ReadOnly = (loc_nParcs = 0)
991:             loc_oGrid.Column3.ReadOnly = (loc_nParcs <> 0)
992:             loc_oGrid.Column4.ReadOnly = (loc_nParcs <> 0)
993:             THIS.this_lRedirigindo = .F.
994:             loc_oGrid.SetFocus
995:             IF !loc_oGrid.Column1.ReadOnly
996:                 loc_oGrid.ActivateCell(RECNO("cursor_4c_FpagI"), 1)
997:             ELSE
998:                 IF !loc_oGrid.Column2.ReadOnly
999:                     loc_oGrid.ActivateCell(RECNO("cursor_4c_FpagI"), 2)
1000:                 ELSE

*-- Linhas 1096 a 1117:
1096:                 THIS.this_oBusinessObject.this_cFpagsAtual = THIS.this_cFpags
1097:             ENDIF
1098:             IF USED("cursor_4c_FpagI")
1099:                 SELECT cursor_4c_FpagI
1100:                 *-- Commit da linha corrente (TABLEUPDATE se ha alteracoes nao salvas)
1101:                 IF GETFLDSTATE(-1, "cursor_4c_FpagI") > 1
1102:                     TABLEUPDATE(.F., .T., "cursor_4c_FpagI")
1103:                 ENDIF
1104:             ENDIF
1105:         CATCH TO loc_oErro
1106:             MsgErro(loc_oErro.Message + CHR(13) + ;
1107:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1108:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.FormParaBO")
1109:         ENDTRY
1110:     ENDPROC
1111: 
1112:     *--------------------------------------------------------------------------
1113:     * BOParaForm - Sincroniza estado do BO para o form
1114:     * Atualiza a Caption (que inclui o fpags corrente) e revincula o grid.
1115:     * Chamado apos operacoes que trocam o fpags no BO (ex: reload de contexto).
1116:     *--------------------------------------------------------------------------
1117:     PROCEDURE BOParaForm()

*-- Linhas 1184 a 1208:
1184:         LOCAL loc_oErro
1185:         TRY
1186:             IF USED("cursor_4c_FpagI")
1187:                 SELECT cursor_4c_FpagI
1188:                 TABLEREVERT(.T., "cursor_4c_FpagI")
1189:                 DELETE ALL
1190:                 *-- Compacta remocoes marcadas (evita SET DELETED clutter no scan)
1191:                 SET DELETED ON
1192:                 PACK
1193:                 SET DELETED OFF
1194:             ENDIF
1195:             THIS.GravaDados = .F.
1196:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1197:         CATCH TO loc_oErro
1198:             MsgErro(loc_oErro.Message + CHR(13) + ;
1199:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1200:                 "Procedure: " + loc_oErro.Procedure, "FormFpm.LimparCampos")
1201:         ENDTRY
1202:     ENDPROC
1203: 
1204:     *--------------------------------------------------------------------------
1205:     * AjustarBotoesPorModo - Ajusta Enabled dos botoes conforme this_cModoAtual
1206:     * LISTA:      Inserir=ON, Excluir=ON, Encerrar=ON, Confirmar/Cancelar=OFF
1207:     * VISUALIZAR: Inserir=OFF, Excluir=OFF, Encerrar=ON, Confirmar/Cancelar=OFF
1208:     * DADOS:      Confirmar=ON, Cancelar=ON, botoes Page1 inativos por contexto


### BO (C:\4c\projeto\app\classes\FpmBO.prg):
*------------------------------------------------------------------------------
* FpmBO.prg - Business Object para Valores Min/Max de Condicao de Pagamento
* Tabela: SigOpFpi
* Origem: SIGCDFPM.SCX (sub-form de SigCdFpm)
*------------------------------------------------------------------------------

DEFINE CLASS FpmBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "SigOpFpi"
    this_cCampoChave = "cidchaves"

    *-- Campos de SigOpFpi
    this_cFpags      = ""  && char(12) - codigo da condicao de pagamento (FK)
    this_nNparcs     = 0   && numeric(2,0) - numero de parcelas
    this_nValmins    = 0   && numeric(11,2) - valor minimo
    this_nValmaxs    = 0   && numeric(11,2) - valor maximo
    this_cEmps       = ""  && char(3) - codigo da empresa
    this_cCidchaves  = ""  && char(20) - chave primaria unica

    *-- Contexto de edicao (recebido do form pai via parametro)
    this_cFpagsAtual = ""  && fpags da condicao em edicao (filtro do SQLEXEC)

    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpFpi"
        THIS.this_cCampoChave = "cidchaves"
        RETURN DODEFAULT()
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorCondicao - Carrega registros de SigOpFpi para cursor do grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorCondicao(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_FpagI")
                TABLEREVERT(.T., "cursor_4c_FpagI")
                USE IN cursor_4c_FpagI
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_FpagI ;
                (fpags    C(12) NULL, ;
                 nparcs   N(2,0) NULL, ;
                 valmins  N(11,2) NULL, ;
                 valmaxs  N(11,2) NULL, ;
                 emps     C(3) NULL, ;
                 cidchaves C(20) NULL)
            SET NULL OFF

            INDEX ON fpags + STR(nparcs, 2) TAG fpags
            INDEX ON nparcs TAG nparcs
            SET ORDER TO

            loc_cSQL = "SELECT fpags, nparcs, valmins, valmaxs, emps, cidchaves " + ;
                       "FROM SigOpFpi " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + ;
                       " ORDER BY nparcs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpagITemp") > 0
                SELECT cursor_4c_FpagI
                APPEND FROM DBF("cursor_4c_FpagITemp")
                IF USED("cursor_4c_FpagITemp")
                    USE IN cursor_4c_FpagITemp
                ENDIF
                SELECT cursor_4c_FpagI
                SET ORDER TO
                GO TOP
                THIS.this_cFpagsAtual = par_cFpags
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_FpagITemp")
                    USE IN cursor_4c_FpagITemp
                ENDIF
                MsgErro("Falha ao carregar parcelas da condi" + CHR(231) + CHR(227) + "o de pagamento.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BuscarPorCondicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinha - Insere nova linha em branco no cursor local do grid
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinha(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            MsgAviso("Cursor de parcelas n" + CHR(227) + "o inicializado.", "Aviso")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT cursor_4c_FpagI
            INSERT INTO cursor_4c_FpagI (fpags, nparcs, valmins, valmaxs, emps) ;
                VALUES (par_cFpags, 0, 0, 0, "")
            GO BOTTOM
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InserirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinha - Marca linha corrente para exclusao no cursor local
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinha()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT cursor_4c_FpagI
            IF !EOF()
                DELETE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExcluirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteNparcs - Verifica se numero de parcelas ja existe no cursor local
    * Usado pelo form para validacao inline na grade
    *--------------------------------------------------------------------------
    PROCEDURE ExisteNparcs(par_nNparcs)
        LOCAL loc_lExiste, loc_nRecNoAtual
        loc_lExiste = .F.

        IF !USED("cursor_4c_FpagI") OR par_nNparcs <= 0
            RETURN loc_lExiste
        ENDIF

        SELECT cursor_4c_FpagI
        loc_nRecNoAtual = RECNO("cursor_4c_FpagI")

        SET ORDER TO fpags
        IF SEEK(cursor_4c_FpagI.fpags + STR(par_nNparcs, 2), "cursor_4c_FpagI", "fpags")
            SKIP
            IF !EOF("cursor_4c_FpagI")
                IF cursor_4c_FpagI.fpags + STR(cursor_4c_FpagI.nparcs, 2) = ;
                   cursor_4c_FpagI.fpags + STR(par_nNparcs, 2)
                    loc_lExiste = .T.
                ENDIF
            ENDIF
        ENDIF

        SET ORDER TO
        IF loc_nRecNoAtual > 0
            GO (loc_nRecNoAtual) IN cursor_4c_FpagI
        ELSE
            GO BOTTOM IN cursor_4c_FpagI
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConsistencia - Valida duplicidade de nparcs antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConsistencia()
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.

        IF !USED("cursor_4c_FpagI")
            RETURN loc_lValido
        ENDIF

        TRY
            SELECT nparcs, SUM(1) AS nTotal ;
                FROM cursor_4c_FpagI ;
                WHERE (nparcs > 0 OR valmaxs > 0) AND !DELETED() ;
                GROUP BY nparcs ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_ValidTT READWRITE

            IF RECCOUNT("cursor_4c_ValidTT") > 0
                MsgAviso("Dados Inconsistentes!!! N" + CHR(250) + "mero de parcelas duplicado.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF

            IF USED("cursor_4c_ValidTT")
                USE IN cursor_4c_ValidTT
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarConsistencia")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Persiste cursor local no SQL Server
    * Delete todos registros existentes e reinsere do cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlteracoes(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cFpags, loc_nNparcs, loc_nValmins, loc_nValmaxs, loc_cEmps
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            MsgAviso("Cursor de parcelas n" + CHR(227) + "o inicializado.", "Aviso")
            RETURN loc_lSucesso
        ENDIF

        TRY
            *-- Deletar registros existentes para esta condicao de pagamento
            loc_cSQL = "DELETE FROM SigOpFpi WHERE fpags = " + EscaparSQL(par_cFpags)
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Falha ao remover parcelas anteriores.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF

            *-- Reinserir do cursor local (apenas linhas validas: nparcs != 0 OU valmaxs != 0)
            IF loc_lSucesso
                SELECT cursor_4c_FpagI
                GO TOP
                DO WHILE !EOF() AND loc_lSucesso
                    IF !DELETED() AND (!EMPTY(cursor_4c_FpagI.nparcs) OR !EMPTY(cursor_4c_FpagI.valmaxs))
                        loc_cFpags   = cursor_4c_FpagI.fpags
                        loc_nNparcs  = cursor_4c_FpagI.nparcs
                        loc_nValmins = cursor_4c_FpagI.valmins
                        loc_nValmaxs = cursor_4c_FpagI.valmaxs
                        loc_cEmps    = cursor_4c_FpagI.emps

                        loc_cSQL = "INSERT INTO SigOpFpi " + ;
                                   "(fpags, nparcs, valmins, valmaxs, emps, cidchaves) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cFpags) + ", " + ;
                                   FormatarNumeroSQL(loc_nNparcs, 0) + ", " + ;
                                   FormatarNumeroSQL(loc_nValmins, 2) + ", " + ;
                                   FormatarNumeroSQL(loc_nValmaxs, 2) + ", " + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   "LEFT(REPLACE(CAST(NEWID() AS varchar(36)), '-', ''), 20))"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Falha ao inserir parcela nParcs=" + ;
                                    TRANSFORM(loc_nNparcs) + ".", "Erro")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                    SKIP
                ENDDO
            ENDIF

            IF loc_lSucesso
                THIS.RegistrarAuditoria("SALVAR")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarAlteracoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cFpags     = TratarNulo(fpags, "C")
            THIS.this_nNparcs    = TratarNulo(nparcs, "N")
            THIS.this_nValmins   = TratarNulo(valmins, "N")
            THIS.this_nValmaxs   = TratarNulo(valmaxs, "N")
            THIS.this_cEmps      = TratarNulo(emps, "C")
            THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *-- ValidarDados: validacao inline feita no grid; satisfaz cadeia BusinessBase
    PROTECTED PROCEDURE ValidarDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Persiste uma linha de SigOpFpi (chave surrogate cidchaves gerada
    * via NEWID SQL Server). Usa propriedades this_c*/this_n* populadas
    * previamente por CarregarDoCursor ou FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpFpi " + ;
                       "(fpags, nparcs, valmins, valmaxs, emps, cidchaves) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNparcs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmins, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmaxs, 2) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       "LEFT(REPLACE(CAST(NEWID() AS varchar(36)), '-', ''), 20))"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INSERIR")
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir parcela nParcs=" + ;
                                          TRANSFORM(THIS.this_nNparcs)
                MsgErro(THIS.this_cMensagemErro, "Erro em Inserir")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de SigOpFpi identificada por this_cCidchaves.
    * Usa propriedades this_n* populadas previamente por CarregarDoCursor ou
    * FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) vazia."
                MsgErro(THIS.this_cMensagemErro, "Erro em Atualizar")
            ELSE
                loc_cSQL = "UPDATE SigOpFpi SET " + ;
                           "nparcs = " + FormatarNumeroSQL(THIS.this_nNparcs, 0) + ", " + ;
                           "valmins = " + FormatarNumeroSQL(THIS.this_nValmins, 2) + ", " + ;
                           "valmaxs = " + FormatarNumeroSQL(THIS.this_nValmaxs, 2) + ", " + ;
                           "emps = " + EscaparSQL(THIS.this_cEmps) + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("ATUALIZAR")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar parcela cidchaves=" + ;
                                              ALLTRIM(THIS.this_cCidchaves)
                    MsgErro(THIS.this_cMensagemErro, "Erro em Atualizar")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove linha de SigOpFpi identificada por this_cCidchaves.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) vazia."
                MsgErro(THIS.this_cMensagemErro, "Erro em ExecutarExclusao")
            ELSE
                loc_cSQL = "DELETE FROM SigOpFpi WHERE cidchaves = " + ;
                           EscaparSQL(THIS.this_cCidchaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("EXCLUIR")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao excluir parcela cidchaves=" + ;
                                              ALLTRIM(THIS.this_cCidchaves)
                    MsgErro(THIS.this_cMensagemErro, "Erro em ExecutarExclusao")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

