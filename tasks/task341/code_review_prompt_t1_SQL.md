# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CEMPS, USUARIOS, C, I

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
  ControlSource = "crSigCdEmp.cemps"
  MultiSelect = .T.
  MultiSelect = .T.
lcQryEmp  = 'Select Cemps, Razas From SigCdEmp'
lcQryEmpU = 'Select * From SigCdAcE'
lcQryUsua = 'Select * From SigCdUsu'
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdAcE Where Emps = ?pEmp], '') < 1)
If Not ThisForm.poDataMgr.Update('crSigCdAcE')
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdAcE Where Emps = ?pEmp], '') < 1)
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdAcE Where Emps = ?pEmp], '') < 1)
If Not ThisForm.poDataMgr.Update('crSigCdAcE')
Select crSigCdEmp
Select crSigCdAcE
			lcSQLCmd = [Select Distinct Usuarios ] + ;
						 [From SigCdUsu ] + ;
					  [(Select Usuarios ] + ;
						 [From SigCdAcE ] + ;
			If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, 'crTmp') < 1)
			Select crTmp
		lcSQLCmd = [Select Distinct Usuarios ] + ;
					 [From SigCdAcE ] + ;
		If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, 'crTmp') < 1)
		Select crTmp
Select crSigCdAcE
Select crLogData
		Insert Into crSigCdAcE From Memvar
Select crLogData
		If .Usuario.Selected(.Usuario.ListIndex)
			Select crLogData
				Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
					Delete 
		Select crLogData
			Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
				Delete 
		If .UsuEmp.Selected( .UsuEmp.ListIndex )
			Select crLogData
				Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
					Delete 
		Select crLogData
			Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
				Delete 

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormACE.prg) - TRECHOS RELEVANTES PARA PASS SQL (1300 linhas total):

*-- Linhas 345 a 363:
345:             .Left               = 26
346:             .Width              = 880
347:             .Height             = 498
348:             .DeleteMark         = .F.
349:             .RecordMark         = .F.
350:             .GridLines          = 3
351:             .GridLineColor      = RGB(238, 238, 238)
352:             .HighlightStyle     = 2
353:             .HighlightBackColor = RGB(255, 255, 255)
354:             .HighlightForeColor = RGB(15, 41, 104)
355:             .RowHeight          = 16
356:             .ScrollBars         = 2
357:             .ReadOnly           = .T.
358:             .Visible            = .T.
359:         ENDWITH
360: 
361:         THIS.TornarControlesVisiveis(loc_oPg1)
362:     ENDPROC
363: 

*-- Linhas 534 a 566:
534:             .Height      = 429
535:             .FontName    = "Courier New"
536:             .FontSize    = 9
537:             .MultiSelect = .T.
538:             .Visible     = .T.
539:         ENDWITH
540:         BINDEVENT(loc_oPg2.lst_4c_Usuario, "DblClick", THIS, "UsuarioDblClick")
541: 
542:         *-- ListBox usuarios com acesso (Usuemp original: top=96, left=418, width=135, height=429 -> top=125)
543:         loc_oPg2.AddObject("lst_4c_Usuemp", "ListBox")
544:         WITH loc_oPg2.lst_4c_Usuemp
545:             .Top         = 125
546:             .Left        = 418
547:             .Width       = 135
548:             .Height      = 429
549:             .FontName    = "Courier New"
550:             .FontSize    = 9
551:             .MultiSelect = .T.
552:             .Visible     = .T.
553:         ENDWITH
554:         BINDEVENT(loc_oPg2.lst_4c_Usuemp, "DblClick", THIS, "UsueEmpDblClick")
555: 
556:         *-- Botao Add um item (cmdAdd original: top=203, left=370, 45x45 -> top=232)
557:         loc_oPg2.AddObject("cmd_4c_CmdAdd", "CommandButton")
558:         WITH loc_oPg2.cmd_4c_CmdAdd
559:             .Caption         = ""
560:             .Picture         = gc_4c_CaminhoIcones + "Cadastro_Seta_Direita_20.jpg"
561:             .PicturePosition = 13
562:             .Top             = 232
563:             .Left            = 370
564:             .Width           = 45
565:             .Height          = 45
566:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 672 a 691:
672: 
673:                     loc_oGrid.ColumnCount = 2
674:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
675:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cemps"
676:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Razas"
677: 
678:                     loc_oGrid.Column1.Width         = 80
679:                     loc_oGrid.Column2.Width         = 795
680: 
681:                     loc_oGrid.Column1.ReadOnly      = .T.
682:                     loc_oGrid.Column2.ReadOnly      = .T.
683: 
684:                     loc_oGrid.Column1.Header1.Caption = "Empresa"
685:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
686: 
687:                     THIS.FormatarGridLista(loc_oGrid)
688:                     loc_lResultado = .T.
689:                 ENDIF
690:             ENDIF
691:         CATCH TO loc_oErro

*-- Linhas 764 a 782:
764:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
765:                 MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
766:             ELSE
767:                 SELECT cursor_4c_Dados
768:                 loc_cEmpresa = ALLTRIM(cursor_4c_Dados.Cemps)
769: 
770:                 THIS.this_oBusinessObject.NovoRegistro()
771:                 THIS.this_oBusinessObject.this_cEmpresa          = loc_cEmpresa
772:                 THIS.this_oBusinessObject.this_cDescricaoEmpresa = ALLTRIM(cursor_4c_Dados.Razas)
773:                 THIS.this_cModoAtual = "INCLUIR"
774:                 THIS.LimparCampos()
775:                 THIS.HabilitarCampos(.T.)
776:                 THIS.BOParaForm()
777:                 THIS.AlternarPagina(2)
778:             ENDIF
779:         CATCH TO loc_oErro
780:             MsgErro(loc_oErro.Message, "FormACE.BtnIncluirClick")
781:         ENDTRY
782:     ENDPROC

*-- Linhas 790 a 831:
790:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
791:                 MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
792:             ELSE
793:                 SELECT cursor_4c_Dados
794:                 loc_cEmpresa = ALLTRIM(cursor_4c_Dados.Cemps)
795:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpresa)
796:                     THIS.this_cModoAtual = "VISUALIZAR"
797:                     THIS.BOParaForm()
798:                     THIS.HabilitarCampos(.F.)
799:                     THIS.AlternarPagina(2)
800:                 ENDIF
801:             ENDIF
802:         CATCH TO loc_oErro
803:             MsgErro(loc_oErro.Message, "FormACE.BtnVisualizarClick")
804:         ENDTRY
805:     ENDPROC
806: 
807:     *--------------------------------------------------------------------------
808:     * BtnAlterarClick - Carrega empresa selecionada para edicao
809:     *--------------------------------------------------------------------------
810:     PROCEDURE BtnAlterarClick()
811:         LOCAL loc_cEmpresa
812:         TRY
813:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
814:                 MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
815:             ELSE
816:                 SELECT cursor_4c_Dados
817:                 loc_cEmpresa = ALLTRIM(cursor_4c_Dados.Cemps)
818:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpresa)
819:                     THIS.this_oBusinessObject.EditarRegistro()
820:                     THIS.this_cModoAtual = "ALTERAR"
821:                     THIS.BOParaForm()
822:                     THIS.HabilitarCampos(.T.)
823:                     THIS.AlternarPagina(2)
824:                 ENDIF
825:             ENDIF
826:         CATCH TO loc_oErro
827:             MsgErro(loc_oErro.Message, "FormACE.BtnAlterarClick")
828:         ENDTRY
829:     ENDPROC
830: 
831:     *--------------------------------------------------------------------------

*-- Linhas 837 a 855:
837:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
838:                 MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
839:             ELSE
840:                 SELECT cursor_4c_Dados
841:                 loc_cEmpresa   = ALLTRIM(cursor_4c_Dados.Cemps)
842:                 loc_cDescricao = ALLTRIM(cursor_4c_Dados.Razas)
843: 
844:                 IF MsgConfirma("Confirma exclus" + CHR(227) + "o dos acessos da empresa " + ;
845:                         CHR(13) + loc_cEmpresa + " - " + loc_cDescricao + "?", ;
846:                         "Confirmar Exclus" + CHR(227) + "o")
847:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpresa)
848:                         IF THIS.this_oBusinessObject.Excluir()
849:                             MsgInfo("Acessos exclu" + CHR(237) + "dos com sucesso!", "Sucesso")
850:                             THIS.CarregarLista()
851:                         ENDIF
852:                     ENDIF
853:                 ENDIF
854:             ENDIF
855:         CATCH TO loc_oErro

*-- Linhas 872 a 894:
872:                 loc_oBusca.Show()
873: 
874:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
875:                     SELECT cursor_4c_BuscaEmp
876:                     loc_cFiltro = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
877:                     loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
878:                     IF USED("cursor_4c_Dados")
879:                         SELECT cursor_4c_Dados
880:                         LOCATE FOR ALLTRIM(Cemps) = loc_cFiltro
881:                         loc_oGrid.Refresh()
882:                     ENDIF
883:                 ENDIF
884: 
885:                 loc_oBusca.Release()
886:             ENDIF
887: 
888:             IF USED("cursor_4c_BuscaEmp")
889:                 USE IN cursor_4c_BuscaEmp
890:             ENDIF
891:         CATCH TO loc_oErro
892:             IF VARTYPE(loc_oBusca) = "O"
893:                 loc_oBusca.Release()
894:             ENDIF

*-- Linhas 931 a 949:
931:                 FOR loc_nI = 1 TO loc_oPg2.lst_4c_Usuemp.ListCount
932:                     loc_cUsuario = ALLTRIM(loc_oPg2.lst_4c_Usuemp.List(loc_nI))
933:                     IF !EMPTY(loc_cUsuario)
934:                         INSERT INTO cursor_4c_UsuariosAcesso (Usuarios) VALUES (loc_cUsuario)
935:                     ENDIF
936:                 ENDFOR
937:             ENDIF
938: 
939:             IF THIS.this_oBusinessObject.Salvar()
940:                 MsgInfo("Acessos salvos com sucesso!", "Sucesso")
941:                 THIS.this_cModoAtual = "LISTA"
942:                 THIS.AlternarPagina(1)
943:                 loc_lResultado = .T.
944:             ENDIF
945:         CATCH TO loc_oErro
946:             MsgErro(loc_oErro.Message, "FormACE.BtnSalvarClick")
947:         ENDTRY
948: 
949:         RETURN loc_lResultado

*-- Linhas 980 a 1015:
980:                 IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
981:                     IF THIS.this_oBusinessObject.BuscarUsuariosDisponiveis(loc_cEmpresa)
982:                         IF USED("cursor_4c_UsuariosDispon") AND RECCOUNT("cursor_4c_UsuariosDispon") > 0
983:                             SELECT cursor_4c_UsuariosDispon
984:                             GO TOP
985:                             SCAN
986:                                 loc_oPg2.lst_4c_Usuario.AddItem(ALLTRIM(cursor_4c_UsuariosDispon.Usuarios))
987:                             ENDSCAN
988:                         ENDIF
989:                         IF USED("cursor_4c_UsuariosDispon")
990:                             USE IN cursor_4c_UsuariosDispon
991:                         ENDIF
992:                     ENDIF
993:                 ENDIF
994:             ENDIF
995: 
996:             IF PEMSTATUS(loc_oPg2, "lst_4c_Usuemp", 5)
997:                 loc_oPg2.lst_4c_Usuemp.Clear()
998:                 IF THIS.this_oBusinessObject.BuscarUsuariosComAcesso(loc_cEmpresa)
999:                     IF USED("cursor_4c_UsuariosAcesso") AND RECCOUNT("cursor_4c_UsuariosAcesso") > 0
1000:                         SELECT cursor_4c_UsuariosAcesso
1001:                         GO TOP
1002:                         SCAN
1003:                             loc_oPg2.lst_4c_Usuemp.AddItem(ALLTRIM(cursor_4c_UsuariosAcesso.Usuarios))
1004:                         ENDSCAN
1005:                     ENDIF
1006:                     IF USED("cursor_4c_UsuariosAcesso")
1007:                         USE IN cursor_4c_UsuariosAcesso
1008:                     ENDIF
1009:                 ENDIF
1010:             ENDIF
1011:         CATCH TO loc_oErro
1012:             MsgErro(loc_oErro.Message, "FormACE.BOParaForm")
1013:         ENDTRY
1014:     ENDPROC
1015: 

*-- Linhas 1072 a 1095:
1072:             IF EMPTY(loc_cEmpresa)
1073:                 loc_oPg2.txt_4c_DEmpresa.Value = ""
1074:             ELSE
1075:                 loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
1076:                               EscaparSQL(PADR(loc_cEmpresa, 3))
1077:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaEmp")
1078: 
1079:                 IF loc_nResult > 0 AND USED("cursor_4c_ValidaEmp") AND RECCOUNT("cursor_4c_ValidaEmp") > 0
1080:                     SELECT cursor_4c_ValidaEmp
1081:                     loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_ValidaEmp.Razas)
1082:                 ELSE
1083:                     loc_oPg2.txt_4c_DEmpresa.Value = ""
1084:                     THIS.AbrirBuscaEmpresa()
1085:                 ENDIF
1086: 
1087:                 IF USED("cursor_4c_ValidaEmp")
1088:                     USE IN cursor_4c_ValidaEmp
1089:                 ENDIF
1090:             ENDIF
1091:         CATCH TO loc_oErro
1092:             MsgErro(loc_oErro.Message, "FormACE.ValidarEmpresa")
1093:             IF USED("cursor_4c_ValidaEmp")
1094:                 USE IN cursor_4c_ValidaEmp
1095:             ENDIF

*-- Linhas 1113 a 1131:
1113:                 loc_oBusca.Show()
1114: 
1115:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1116:                     SELECT cursor_4c_BuscaEmpresa
1117:                     loc_oPg2.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1118:                     loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
1119:                 ENDIF
1120: 
1121:                 loc_oBusca.Release()
1122:             ENDIF
1123: 
1124:             IF USED("cursor_4c_BuscaEmpresa")
1125:                 USE IN cursor_4c_BuscaEmpresa
1126:             ENDIF
1127:         CATCH TO loc_oErro
1128:             MsgErro(loc_oErro.Message, "FormACE.AbrirBuscaEmpresa")
1129:             IF USED("cursor_4c_BuscaEmpresa")
1130:                 USE IN cursor_4c_BuscaEmpresa
1131:             ENDIF

*-- Linhas 1144 a 1162:
1144:         TRY
1145:             IF PEMSTATUS(loc_oPg2, "lst_4c_Usuario", 5) AND PEMSTATUS(loc_oPg2, "lst_4c_Usuemp", 5)
1146:                 loc_nIdx = loc_oPg2.lst_4c_Usuario.ListIndex
1147:                 IF loc_nIdx >= 1 AND loc_oPg2.lst_4c_Usuario.Selected(loc_nIdx)
1148:                     loc_cUsuario = ALLTRIM(loc_oPg2.lst_4c_Usuario.List(loc_nIdx))
1149:                     loc_oPg2.lst_4c_Usuario.RemoveItem(loc_nIdx)
1150:                     loc_oPg2.lst_4c_Usuemp.AddItem(loc_cUsuario)
1151:                 ENDIF
1152:             ENDIF
1153:         CATCH TO loc_oErro
1154:             MsgErro(loc_oErro.Message, "FormACE.CmdAddClick")
1155:         ENDTRY
1156:     ENDPROC
1157: 
1158:     *--------------------------------------------------------------------------
1159:     * CmdAddAllClick - Move todos de lst_4c_Usuario para lst_4c_Usuemp
1160:     *--------------------------------------------------------------------------
1161:     PROCEDURE CmdAddAllClick()
1162:         LOCAL loc_oPg2, loc_nI, loc_nTotal

*-- Linhas 1192 a 1210:
1192:         TRY
1193:             IF PEMSTATUS(loc_oPg2, "lst_4c_Usuemp", 5) AND PEMSTATUS(loc_oPg2, "lst_4c_Usuario", 5)
1194:                 loc_nIdx = loc_oPg2.lst_4c_Usuemp.ListIndex
1195:                 IF loc_nIdx >= 1 AND loc_oPg2.lst_4c_Usuemp.Selected(loc_nIdx)
1196:                     loc_cUsuario = ALLTRIM(loc_oPg2.lst_4c_Usuemp.List(loc_nIdx))
1197:                     loc_oPg2.lst_4c_Usuemp.RemoveItem(loc_nIdx)
1198:                     loc_oPg2.lst_4c_Usuario.AddItem(loc_cUsuario)
1199:                 ENDIF
1200:             ENDIF
1201:         CATCH TO loc_oErro
1202:             MsgErro(loc_oErro.Message, "FormACE.CmdRemoveClick")
1203:         ENDTRY
1204:     ENDPROC
1205: 
1206:     *--------------------------------------------------------------------------
1207:     * CmdRemoveAllClick - Move todos de lst_4c_Usuemp para lst_4c_Usuario
1208:     *--------------------------------------------------------------------------
1209:     PROCEDURE CmdRemoveAllClick()
1210:         LOCAL loc_oPg2, loc_nI, loc_nTotal


### BO (C:\4c\projeto\app\classes\ACEBO.prg):
*==============================================================================
* ACEBO.PRG
* Business Object para Acesso de Empresas (SIGCDACE)
*
* Tabela Principal : SigCdEmp  - Lista de empresas (Cemps, Razas)
* Tabela de Acesso : SigCdAcE  - Mapeamento empresa-usuario
*                                (emps char(3), usuarios char(10), pkchaves char(13))
* Tabela de Usuarios: SigCdUsu - Cadastro de usuarios (usuarios char(10))
*
* Logica: Gerencia quais usuarios tem acesso a cada empresa.
*         Inserir/Atualizar = DELETE + re-INSERT em SigCdAcE por empresa.
*         Excluir           = DELETE todos os acessos da empresa em SigCdAcE.
*         Buscar            = SELECT de empresas em SigCdEmp (exibicao no grid).
*==============================================================================

DEFINE CLASS ACEBO AS BusinessBase

    *-- Propriedades da empresa (SigCdEmp)
    this_cEmpresa            = ""   && Cemps/emps CHAR(3)  - Codigo da empresa (PK)
    this_cDescricaoEmpresa   = ""   && Razas       CHAR(40) - Descricao da empresa

    *-- Nome do cursor que o Form preenche com os usuarios com acesso antes de Salvar()
    this_cCursorUsuariosAcesso = "cursor_4c_UsuariosAcesso"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEmp"
        THIS.this_cCampoChave = "Cemps"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpresa
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados da empresa de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpresa          = TratarNulo(Cemps, "C")
                THIS.this_cDescricaoEmpresa = TratarNulo(Razas, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades de dados
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cEmpresa          = ""
        THIS.this_cDescricaoEmpresa = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo da empresa obrigat" + CHR(243) + "rio"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista empresas no grid (SELECT de SigCdEmp)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                           " WHERE Cemps LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " OR Razas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega dados de uma empresa pelo codigo Cemps
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cEmpresa) != "C" OR EMPTY(ALLTRIM(par_cEmpresa))
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo da empresa n" + CHR(227) + "o informado"
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ALLTRIM(par_cEmpresa)
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUsuariosDisponiveis - Usuarios sem acesso a esta empresa
    * Retorna cursor_4c_UsuariosDispon (campo: Usuarios)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUsuariosDisponiveis(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_UsuariosDispon")
                USE IN cursor_4c_UsuariosDispon
            ENDIF

            loc_cSQL = "SELECT DISTINCT Usuarios FROM SigCdUsu" + ;
                       " WHERE NOT cativos = 'N'" + ;
                       " AND Usuarios NOT IN" + ;
                       " (SELECT Usuarios FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa)) + ")" + ;
                       " ORDER BY Usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosDispon")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUsuariosComAcesso - Usuarios com acesso a esta empresa
    * Retorna cursor_4c_UsuariosAcesso (campo: Usuarios)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUsuariosComAcesso(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_UsuariosAcesso")
                USE IN cursor_4c_UsuariosAcesso
            ENDIF

            loc_cSQL = "SELECT DISTINCT Usuarios FROM SigCdAcE" + ;
                       " WHERE emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                       " ORDER BY Usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosAcesso")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursorAcesso - Cria cursor vazio para o Form preencher com usuarios
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursorAcesso()
        TRY
            IF USED("cursor_4c_UsuariosAcesso")
                USE IN cursor_4c_UsuariosAcesso
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_UsuariosAcesso (Usuarios C(10))
            SET NULL OFF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT: DELETE acessos antigos + INSERT novos (PROTECTED)
    * O Form preenche cursor_4c_UsuariosAcesso antes de chamar Salvar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nI
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcE")
            IF USED("cursor_4c_DelAcE")
                USE IN cursor_4c_DelAcE
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UsuariosAcesso") AND RECCOUNT("cursor_4c_UsuariosAcesso") > 0
                    loc_nI = 0
                    SELECT cursor_4c_UsuariosAcesso
                    GO TOP
                    SCAN
                        loc_nI = loc_nI + 1
                        loc_cSQL = "INSERT INTO SigCdAcE (usuarios, emps, pkchaves) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_UsuariosAcesso.Usuarios)) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cEmpresa)) + ", " + ;
                                   EscaparSQL(LEFT(SYS(2015) + SYS(2015), 13)) + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcE")
                        IF USED("cursor_4c_InsAcE")
                            USE IN cursor_4c_InsAcE
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE: mesma logica do Inserir (DELETE + re-INSERT) (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nI
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcE")
            IF USED("cursor_4c_DelAcE")
                USE IN cursor_4c_DelAcE
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UsuariosAcesso") AND RECCOUNT("cursor_4c_UsuariosAcesso") > 0
                    loc_nI = 0
                    SELECT cursor_4c_UsuariosAcesso
                    GO TOP
                    SCAN
                        loc_nI = loc_nI + 1
                        loc_cSQL = "INSERT INTO SigCdAcE (usuarios, emps, pkchaves) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_UsuariosAcesso.Usuarios)) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cEmpresa)) + ", " + ;
                                   EscaparSQL(LEFT(SYS(2015) + SYS(2015), 13)) + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcE")
                        IF USED("cursor_4c_InsAcE")
                            USE IN cursor_4c_InsAcE
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove todos os acessos da empresa (PROTECTED)
    * Nao deleta a empresa em si (SigCdEmp), apenas os registros em SigCdAcE
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
                MsgErro("Empresa n" + CHR(227) + "o selecionada para exclus" + CHR(227) + "o", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelExcl")
                IF USED("cursor_4c_DelExcl")
                    USE IN cursor_4c_DelExcl
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

