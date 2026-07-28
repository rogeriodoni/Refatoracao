# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, FKCHAVES, PCESCOLHA, EMPS, CODIGOS

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
  ControlSource = "crSigCdClc.grupos"
  ControlSource = "crSigCdClc.codigos"
  ControlSource = "crSigCdClc.descs"
  ControlSource = "crSigCdClc.faixais"
  ControlSource = "crSigCdClc.faixafs"
  ControlSource = "crSigCdClc.Prioridades"
  ControlSource = "crSigCdClc.Emps"
  ControlSource = "crSigCdClc.ClcStatus"
  DeleteMark = .F.
  Column1.ControlSource = "crMotivos.Codigos"
  Column2.ControlSource = "crMotivos.Descrs"
  Column3.ControlSource = "crMotivos.Tipos"
			lcQuery = [Select * From SigCdClc]
				lcQuery = [Select * From SigCdClc] + Iif(Empty(ThisForm.Grupos), [], [ Where Grupos = '] + ThisForm.Grupos + ['])
				lcQuery = [Select * From SigCdClc] + Iif(Empty(ThisForm.Grupos), [], [ Where Not Grupos = '] + ThisForm.Grupos + ['])
	lcQuery = [Select Codigos, Descrs From SigCdGcr]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdGcr]) < 1)
	Select crSigCdGcr
If Not ThisForm.poDataMgr.Update([crSigCdCmt])
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (mSv_Alterar - Update - crSigCdCmt)])
If Not ThisForm.poDataMgr.Update([crSigCdCmt])
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (mSv_Alterar - Update - crSigCdCmt)])
Select crSigCdClc
	lcQuery = [Select a.*, b.Descrs ] + ;
			    [From SigCdCmt a, SigCdFs b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalClaMt]) < 1)
	Select LocalClaMt
		Insert Into crMotivos (Codigos, Descrs, Tipos) ;
	lcQuery = [Select * From SigCdFs]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMDsc]) < 1)
	Select LocalMDsc
		If Not Seek(LocalMDsc.Codigos, [crMotivos], [Codigos])
			Insert Into crMotivos (Codigos, Descrs, Tipos) Values (LocalMDsc.Codigos, LocalMDsc.Descrs, 3)
	Select CrSigCdClc
		SqlClaCo = [Select Descs, FaixaIs, FaixaFs ] + ;
					 [From SigCdClc ]+;
		ThisForm.poDatamgr.SqlExecute(SqlClaCo,'csSigCdClc')
		Select csSigCdClc
	lcQuery = [Delete From SigCdCmt Where fkChaves = '] + crSigCdClc.cIdChaves + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Delete - crSigCdCmt)])
	Select crMotivos
			Insert Into crSigCdCmt (fkChaves, cIdChaves, Codigos, Tipos) ;
	Select crSigCdGcr
Select CrSigCdClc

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCco.prg) - TRECHOS RELEVANTES PARA PASS SQL (1648 linhas total):

*-- Linhas 61 a 79:
61:                 USE IN crMotivos
62:             ENDIF
63:             SET NULL ON
64:             CREATE CURSOR crMotivos (Codigos C(10), Descrs C(40), Tipos N(1))
65:             INDEX ON Codigos TAG Codigos
66:             SET NULL OFF
67: 
68:             *-- Carregar dados iniciais (pula em modo ValidandoUI)
69:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
70:                 THIS.this_oBusinessObject.BuscarParametros()
71:                 THIS.CarregarLista()
72:             ENDIF
73: 
74:             *-- Iniciar na pagina de Lista
75:             THIS.pgf_4c_Paginas.Visible = .T.
76:             THIS.pgf_4c_Paginas.ActivePage = 1
77:             THIS.this_cModoAtual = "LISTA"
78: 
79:             loc_lSucesso = .T.

*-- Linhas 334 a 352:
334:             .Width              = 990
335:             .Height             = 510
336:             .RecordMark         = .F.
337:             .DeleteMark         = .F.
338:             .GridLineColor      = RGB(238, 238, 238)
339:             .HighlightBackColor = RGB(255, 255, 255)
340:             .HighlightForeColor = RGB(15, 41, 104)
341:             .HighlightStyle     = 2
342:             .RowHeight          = 16
343:             .ScrollBars         = 2
344:             .GridLines          = 3
345:             .FontName           = "Verdana"
346:             .FontSize           = 8
347:             .ForeColor          = RGB(90, 90, 90)
348:             .BackColor          = RGB(255, 255, 255)
349:             .Visible            = .T.
350:         ENDWITH
351:         WITH par_oPagina.grd_4c_Lista.Column1
352:             .Header1.Caption = "Emp"

*-- Linhas 769 a 799:
769:             .Height            = 464
770:             .AllowHeaderSizing = .F.
771:             .AllowRowSizing    = .F.
772:             .DeleteMark        = .F.
773:             .RecordMark        = .F.
774:             .HeaderHeight      = 20
775:             .RowHeight         = 20
776:             .ScrollBars        = 2
777:             .GridLineColor     = RGB(238, 238, 238)
778:             .ReadOnly          = .T.
779:             .Panel             = 1
780:             .Visible           = .T.
781: 
782:             *-- Coluna 1: Codigos (Motivo)
783:             WITH .Column1
784:                 .ControlSource = "crMotivos.Codigos"
785:                 .Width         = 94
786:                 .Movable       = .F.
787:                 .Resizable     = .F.
788:                 .ReadOnly      = .T.
789:                 .FontName      = "Tahoma"
790:                 .FontSize      = 8
791:                 WITH .Header1
792:                     .Caption   = "Motivo"
793:                     .FontName  = "Tahoma"
794:                     .FontSize  = 8
795:                     .Alignment = 2
796:                 ENDWITH
797:                 WITH .Text1
798:                     .FontBold    = .F.
799:                     .FontName    = "Tahoma"

*-- Linhas 809 a 827:
809: 
810:             *-- Coluna 2: Descrs (Descricao)
811:             WITH .Column2
812:                 .ControlSource = "crMotivos.Descrs"
813:                 .Width         = 379
814:                 .Movable       = .F.
815:                 .Resizable     = .F.
816:                 .ReadOnly      = .T.
817:                 .FontName      = "Tahoma"
818:                 .FontSize      = 8
819:                 WITH .Header1
820:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
821:                     .FontName  = "Tahoma"
822:                     .FontSize  = 8
823:                     .Alignment = 2
824:                 ENDWITH
825:                 WITH .Text1
826:                     .FontName    = "Tahoma"
827:                     .FontSize    = 8

*-- Linhas 837 a 855:
837:             *-- Coluna 3: Tipos (OptionGroup: Inserir/Excluir/Nenhum)
838:             *-- Sparse=.F.: OptionGroup sempre visivel em todas as linhas
839:             WITH .Column3
840:                 .ControlSource = "crMotivos.Tipos"
841:                 .Width         = 210
842:                 .Movable       = .F.
843:                 .Resizable     = .F.
844:                 .ReadOnly      = .F.
845:                 .Sparse        = .F.
846:                 .FontName      = "Tahoma"
847:                 .FontSize      = 8
848:                 WITH .Header1
849:                     .Caption   = "Tipo"
850:                     .FontName  = "Tahoma"
851:                     .FontSize  = 8
852:                     .Alignment = 2
853:                 ENDWITH
854:             ENDWITH
855:         ENDWITH

*-- Linhas 926 a 951:
926:                     IF VARTYPE(loc_oGrid) = "O"
927:                         loc_oGrid.ColumnCount = 8
928:                         loc_oGrid.RecordSource              = "cursor_4c_Dados"
929:                         loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.Emps"
930:                         loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.grupos"
931:                         loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.codigos"
932:                         loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.descs"
933:                         loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.Prioridades"
934:                         loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.faixais"
935:                         loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
936:                         loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
937:                         *-- Redefinir headers apos RecordSource (VFP reseta automaticamente)
938:                         loc_oGrid.Column1.Header1.Caption   = "Emp"
939:                         loc_oGrid.Column2.Header1.Caption   = "Grupo"
940:                         loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
941:                         loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(245) + "es"
942:                         loc_oGrid.Column5.Header1.Caption   = "P"
943:                         loc_oGrid.Column6.Header1.Caption   = "Faixa Inicial"
944:                         loc_oGrid.Column7.Header1.Caption   = "Faixa Final"
945:                         loc_oGrid.Column8.Header1.Caption   = "Selecionavel"
946:                         THIS.FormatarGridLista(loc_oGrid)
947:                     ENDIF
948:                 ENDIF
949:             ENDIF
950:         CATCH TO loException
951:             MsgErro("Erro em FormCco.CarregarLista: " + loException.Message, "Erro")

*-- Linhas 1046 a 1064:
1046:         loc_cIdChaves = ""
1047: 
1048:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1049:             SELECT cursor_4c_Dados
1050:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cIdChaves)
1051:         ENDIF
1052: 
1053:         IF EMPTY(loc_cIdChaves)
1054:             MsgAviso("Selecione um registro na lista.", "Visualizar")
1055:             RETURN
1056:         ENDIF
1057: 
1058:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1059:             THIS.this_cModoAtual = "VISUALIZAR"
1060:             THIS.BOParaForm()
1061:             THIS.HabilitarCampos(.F.)
1062:             THIS.AjustarBotoesPorModo()
1063: 
1064:             *-- Carregar motivos para grd_4c_Motivos (fase 6)

*-- Linhas 1079 a 1097:
1079:         loc_cIdChaves = ""
1080: 
1081:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1082:             SELECT cursor_4c_Dados
1083:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cIdChaves)
1084:         ENDIF
1085: 
1086:         IF EMPTY(loc_cIdChaves)
1087:             MsgAviso("Selecione um registro na lista.", "Alterar")
1088:             RETURN
1089:         ENDIF
1090: 
1091:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1092:             THIS.this_oBusinessObject.EditarRegistro()
1093:             THIS.this_cModoAtual = "ALTERAR"
1094:             THIS.BOParaForm()
1095:             THIS.HabilitarCampos(.T.)
1096:             THIS.AjustarBotoesPorModo()
1097: 

*-- Linhas 1115 a 1133:
1115:         loc_cDescricao = ""
1116: 
1117:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1118:             SELECT cursor_4c_Dados
1119:             loc_cIdChaves  = ALLTRIM(cursor_4c_Dados.cIdChaves)
1120:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.descs)
1121:         ENDIF
1122: 
1123:         IF EMPTY(loc_cIdChaves)
1124:             MsgAviso("Selecione um registro na lista.", "Excluir")
1125:             RETURN
1126:         ENDIF
1127: 
1128:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1129:             RETURN
1130:         ENDIF
1131: 
1132:         IF THIS.this_oBusinessObject.VerificarVinculoCli( ;
1133:                 THIS.this_oBusinessObject.this_cGrupos, ;

*-- Linhas 1164 a 1198:
1164:             RETURN
1165:         ENDIF
1166: 
1167:         loc_cFiltro = "codigos LIKE " + EscaparSQL("%" + ALLTRIM(loc_cBusca) + "%")
1168: 
1169:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1170:             loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1171:             IF loc_lSucesso AND USED("cursor_4c_Dados")
1172:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1173:                 IF VARTYPE(loc_oGrid) = "O"
1174:                     loc_oGrid.ColumnCount = 8
1175:                     loc_oGrid.RecordSource              = "cursor_4c_Dados"
1176:                     loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.Emps"
1177:                     loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.grupos"
1178:                     loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.codigos"
1179:                     loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.descs"
1180:                     loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.Prioridades"
1181:                     loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.faixais"
1182:                     loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
1183:                     loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
1184:                     loc_oGrid.Column1.Header1.Caption   = "Emp"
1185:                     loc_oGrid.Column2.Header1.Caption   = "Grupo"
1186:                     loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
1187:                     loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(245) + "es"
1188:                     loc_oGrid.Column5.Header1.Caption   = "P"
1189:                     loc_oGrid.Column6.Header1.Caption   = "Faixa Inicial"
1190:                     loc_oGrid.Column7.Header1.Caption   = "Faixa Final"
1191:                     loc_oGrid.Column8.Header1.Caption   = "Selecionavel"
1192:                     THIS.FormatarGridLista(loc_oGrid)
1193:                 ENDIF
1194:             ENDIF
1195:         ENDIF
1196:     ENDPROC
1197: 
1198:     *==========================================================================


### BO (C:\4c\projeto\app\classes\CcoBO.prg):
*==============================================================================
* CcoBO.prg - Business Object para Classificacao de Contas (SigCdClc)
* Tabela principal : SigCdClc
* Tabela detalhe  : SigCdCmt (motivos/tipos da classificacao)
* Chave primaria  : cIdChaves (UUID gerado por fUniqueIds)
*==============================================================================
DEFINE CLASS CcoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdClc
    *--------------------------------------------------------------------------
    this_cIdChaves      = ""    && cIdChaves   C     - chave primaria (UUID)
    this_cEmps          = ""    && Emps        C(3)  - empresa
    this_cGrupos        = ""    && grupos      C(10) - grupo de conta corrente (FK SigCdGcr)
    this_cCodigos       = ""    && codigos     C(80) - codigo da classificacao
    this_cDescs         = ""    && descs       C(220)- descricao
    this_nPrioridades   = 0     && Prioridades N(2)  - prioridade
    this_nFaixaIs       = 0     && faixais     N(12,2) - faixa inicial
    this_nFaixaFs       = 0     && faixafs     N(12,2) - faixa final
    this_nClcStatus     = 1     && ClcStatus   N(1)  - 1=Sim (selecionavel), 2=Nao

    *--------------------------------------------------------------------------
    * Nomes dos cursores auxiliares
    *--------------------------------------------------------------------------
    this_cCursorMotivos = "crMotivos"    && cursor local de motivos (SigCdCmt + SigCdFs)
    this_cCursorGrupos  = "crSigCdGcr"  && cursor de grupos (SigCdGcr)

    *--------------------------------------------------------------------------
    * Contexto de filtragem (definido pelo Form conforme parametro pCli do legado)
    *--------------------------------------------------------------------------
    this_cGruposFiltro   = ""    && grupo padrao (de SigCdPam.GrPadClis)
    this_lClientesFiltro = .F.   && .T. = filtrar pelo grupo, .F. = excluir o grupo

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdClc"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro(loException.Message, "CcoBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor aberto
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves    = TratarNulo(cIdChaves,   "C")
                THIS.this_cEmps        = TratarNulo(Emps,        "C")
                THIS.this_cGrupos      = TratarNulo(grupos,      "C")
                THIS.this_cCodigos     = TratarNulo(codigos,     "C")
                THIS.this_cDescs       = TratarNulo(descs,       "C")
                THIS.this_nPrioridades = TratarNulo(Prioridades, "N")
                THIS.this_nFaixaIs     = TratarNulo(faixais,     "N")
                THIS.this_nFaixaFs     = TratarNulo(faixafs,     "N")
                THIS.this_nClcStatus   = TratarNulo(ClcStatus,   "N")
                IF THIS.this_nClcStatus = 0
                    THIS.this_nClcStatus = 1
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.CarregarDoCursor: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT de SigCdClc para o grid (cursor_4c_Dados)
    * Aplica filtro de grupo conforme this_cGruposFiltro / this_lClientesFiltro
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cGruposFiltro))
                IF THIS.this_lClientesFiltro
                    loc_cWhere = " WHERE grupos = " + EscaparSQL(THIS.this_cGruposFiltro)
                ELSE
                    loc_cWhere = " WHERE NOT grupos = " + EscaparSQL(THIS.this_cGruposFiltro)
                ENDIF
            ENDIF

            IF !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = " WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus" + ;
                       " FROM SigCdClc" + loc_cWhere + ;
                       " ORDER BY grupos, codigos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(245) + "es: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cIdChaves)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus" + ;
                       " FROM SigCdClc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarParametros - Carrega GrPadClis de SigCdPam
    * Popula this_cGruposFiltro
    *==========================================================================
    FUNCTION BuscarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrPadClis FROM SigCdPam"

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Pam") > 0
                SELECT cursor_4c_Pam
                THIS.this_cGruposFiltro = PADR(TratarNulo(GrPadClis, "C"), 10)
                loc_lSucesso = .T.
            ELSE
                THIS.this_cGruposFiltro = ""
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.BuscarParametros: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarGrupos - Carrega SigCdGcr para lookup (cursor crSigCdGcr)
    *==========================================================================
    FUNCTION BuscarGrupos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"

            IF USED("crSigCdGcr")
                USE IN crSigCdGcr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGcr")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.BuscarGrupos: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarMotivosClassif - Carrega motivos de uma classificacao (SigCdCmt + SigCdFs)
    * Popula cursor crMotivos (Codigos C10, Descrs C40, Tipos N1)
    * par_cIdChaves: cIdChaves da classificacao
    *==========================================================================
    FUNCTION CarregarMotivosClassif(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ClaMt")
                USE IN cursor_4c_ClaMt
            ENDIF

            loc_cSQL = "SELECT a.Codigos, b.Descrs, a.Tipos" + ;
                       " FROM SigCdCmt a, SigCdFs b" + ;
                       " WHERE a.fkChaves = " + EscaparSQL(par_cIdChaves) + ;
                       " AND a.Codigos = b.codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClaMt")
            IF loc_nResultado >= 0
                SELECT crMotivos
                ZAP IN crMotivos
                SELECT cursor_4c_ClaMt
                SCAN
                    INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                        VALUES (cursor_4c_ClaMt.Codigos, cursor_4c_ClaMt.Descrs, cursor_4c_ClaMt.Tipos)
                ENDSCAN
                IF USED("cursor_4c_ClaMt")
                    USE IN cursor_4c_ClaMt
                ENDIF
                GO TOP IN crMotivos
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_ClaMt")
                    USE IN cursor_4c_ClaMt
                ENDIF
                MsgErro("Erro ao carregar motivos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_ClaMt")
                USE IN cursor_4c_ClaMt
            ENDIF
            MsgErro("Erro em CcoBO.CarregarMotivosClassif: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CompletarMotivosFS - Adiciona ao cursor crMotivos os motivos de SigCdFs
    * ausentes (com Tipos=3, Nenhum). Usado em modo INSERIR/ALTERAR.
    *==========================================================================
    FUNCTION CompletarMotivosFS()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodigos
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_MdSc")
                USE IN cursor_4c_MdSc
            ENDIF

            loc_cSQL = "SELECT codigos, descrs FROM SigCdFs ORDER BY codigos"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MdSc")

            IF loc_nResultado >= 0
                SELECT cursor_4c_MdSc
                SCAN
                    loc_cCodigos = ALLTRIM(cursor_4c_MdSc.codigos)
                    IF !USED("crMotivos") OR EOF("crMotivos")
                        INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                            VALUES (loc_cCodigos, cursor_4c_MdSc.descrs, 3)
                    ELSE
                        SELECT crMotivos
                        GO TOP IN crMotivos
                        LOCATE FOR ALLTRIM(crMotivos.Codigos) = loc_cCodigos
                        IF EOF("crMotivos")
                            INSERT INTO crMotivos (Codigos, Descrs, Tipos) ;
                                VALUES (loc_cCodigos, cursor_4c_MdSc.descrs, 3)
                        ENDIF
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_MdSc")
                    USE IN cursor_4c_MdSc
                ENDIF
                GO TOP IN crMotivos
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_MdSc")
                    USE IN cursor_4c_MdSc
                ENDIF
                MsgErro("Erro ao carregar motivos FS: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_MdSc")
                USE IN cursor_4c_MdSc
            ENDIF
            MsgErro("Erro em CcoBO.CompletarMotivosFS: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * VerificarDuplicidade - Verifica se grupo+codigos+emps ja existe em SigCdClc
    * Retorna .T. se JA EXISTE (duplicado), .F. se pode inserir
    *==========================================================================
    FUNCTION VerificarDuplicidade(par_cEmps, par_cGrupos, par_cCodigos, par_cIdChavesExcluir)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            IF VARTYPE(par_cIdChavesExcluir) != "C"
                par_cIdChavesExcluir = ""
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdClc" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " AND grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND codigos = " + EscaparSQL(par_cCodigos)

            IF !EMPTY(ALLTRIM(par_cIdChavesExcluir))
                loc_cSQL = loc_cSQL + " AND NOT cIdChaves = " + EscaparSQL(par_cIdChavesExcluir)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lExiste = (cursor_4c_Dup.qtd > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
            MsgErro("Erro em CcoBO.VerificarDuplicidade: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *==========================================================================
    * VerificarFaixaSobreposta - Verifica se faixa sobrepe outra existente
    * Retorna "" se OK, ou mensagem descricao do conflito
    *==========================================================================
    FUNCTION VerificarFaixaSobreposta(par_cEmps, par_cGrupos, par_nFaixaI, par_nFaixaF, par_cIdChavesExcluir)
        LOCAL loc_cSQL, loc_nResultado, loc_cMensagem
        loc_cMensagem = ""

        TRY
            IF VARTYPE(par_cIdChavesExcluir) != "C"
                par_cIdChavesExcluir = ""
            ENDIF

            loc_cSQL = "SELECT descs, faixais, faixafs FROM SigCdClc" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " AND grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND NOT cIdChaves = " + EscaparSQL(par_cIdChavesExcluir) + ;
                       " AND (" + ;
                       "   (" + FormatarNumeroSQL(par_nFaixaI) + " BETWEEN faixais AND faixafs)" + ;
                       "   OR (" + FormatarNumeroSQL(par_nFaixaF) + " BETWEEN faixais AND faixafs)" + ;
                       "   OR (faixais BETWEEN " + FormatarNumeroSQL(par_nFaixaI) + " AND " + FormatarNumeroSQL(par_nFaixaF) + ")" + ;
                       "   OR (faixafs BETWEEN " + FormatarNumeroSQL(par_nFaixaI) + " AND " + FormatarNumeroSQL(par_nFaixaF) + ")" + ;
                       ")"

            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Faixa")
            IF loc_nResultado >= 0 AND !EOF("cursor_4c_Faixa")
                SELECT cursor_4c_Faixa
                loc_cMensagem = "Faixa Cadastrada no C" + CHR(243) + "digo " + ;
                    ALLTRIM(cursor_4c_Faixa.descs) + CHR(13) + ;
                    "Valor : " + ALLTRIM(STR(cursor_4c_Faixa.faixais, 12, 2)) + ;
                    " " + CHR(224) + " " + ALLTRIM(STR(cursor_4c_Faixa.faixafs, 12, 2))
            ENDIF

            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_Faixa")
                USE IN cursor_4c_Faixa
            ENDIF
            MsgErro("Erro em CcoBO.VerificarFaixaSobreposta: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_cMensagem
    ENDFUNC

    *==========================================================================
    * VerificarVinculoCli - Verifica se classificacao tem conta vinculada em SigCdCli
    * Retorna .T. se existir vinculo (bloqueio de exclusao)
    *==========================================================================
    FUNCTION VerificarVinculoCli(par_cGrupos, par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lTemVinculo
        loc_lTemVinculo = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCli" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos) + ;
                       " AND codigos = " + EscaparSQL(par_cCodigos)

            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VinCli")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VinCli") > 0
                SELECT cursor_4c_VinCli
                loc_lTemVinculo = (cursor_4c_VinCli.qtd > 0)
            ENDIF

            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_VinCli")
                USE IN cursor_4c_VinCli
            ENDIF
            MsgErro("Erro em CcoBO.VerificarVinculoCli: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lTemVinculo
    ENDFUNC

    *==========================================================================
    * SalvarMotivos - Delete + Insert de SigCdCmt para a classificacao atual
    * par_cIdChaves: cIdChaves da classificacao
    * par_cCursorMotivos: nome do cursor com os motivos a salvar
    *   (colunas: Codigos C10, Descrs C40, Tipos N1 - tipos 1 e 2 sao salvos)
    *==========================================================================
    FUNCTION SalvarMotivos(par_cIdChaves, par_cCursorMotivos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cIdMot
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmt WHERE fkChaves = " + EscaparSQL(par_cIdChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir motivos antigos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorMotivos)
                    SELECT (par_cCursorMotivos)
                    GO TOP
                    SCAN
                        IF INLIST(Tipos, 1, 2)
                            loc_cIdMot = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdCmt (fkChaves, cIdChaves, Codigos, Tipos)" + ;
                                       " VALUES (" + EscaparSQL(par_cIdChaves) + ;
                                       ", " + EscaparSQL(loc_cIdMot) + ;
                                       ", " + EscaparSQL(ALLTRIM(Codigos)) + ;
                                       ", " + FormatarNumeroSQL(Tipos) + ")"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao gravar motivo: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                                EXIT
                            ENDIF
                        ENDIF
                    ENDSCAN
                    loc_lSucesso = .T.
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.SalvarMotivos: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT INTO SigCdClc (chamado pelo BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
                THIS.this_cIdChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdClc" + ;
                       " (cIdChaves, Emps, grupos, codigos, descs," + ;
                       " Prioridades, faixais, faixafs, ClcStatus)" + ;
                       " VALUES (" + EscaparSQL(THIS.this_cIdChaves) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cCodigos, 80)) + ;
                       ", " + EscaparSQL(LEFT(THIS.this_cDescs, 220)) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nPrioridades) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nFaixaIs) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nFaixaFs) + ;
                       ", " + FormatarNumeroSQL(THIS.this_nClcStatus) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE SigCdClc (chamado pelo BusinessBase.Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdClc SET" + ;
                       " Emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ;
                       ", grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ;
                       ", codigos = " + EscaparSQL(LEFT(THIS.this_cCodigos, 80)) + ;
                       ", descs = " + EscaparSQL(LEFT(THIS.this_cDescs, 220)) + ;
                       ", Prioridades = " + FormatarNumeroSQL(THIS.this_nPrioridades) + ;
                       ", faixais = " + FormatarNumeroSQL(THIS.this_nFaixaIs) + ;
                       ", faixafs = " + FormatarNumeroSQL(THIS.this_nFaixaFs) + ;
                       ", ClcStatus = " + FormatarNumeroSQL(THIS.this_nClcStatus) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE SigCdClc + cascade SigCdCmt
    * (chamado pelo BusinessBase.Excluir via PublicExcluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmt WHERE fkChaves = " + EscaparSQL(THIS.this_cIdChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir motivos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigCdClc WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o: " + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CcoBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

