# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, FKCHAVES, PCESCOLHA, EMPS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, FKCHAVES, PCESCOLHA, EMPS, CODIGOS

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCco.prg) - TRECHOS RELEVANTES PARA PASS SQL (1647 linhas total):

*-- Linhas 59 a 77:
59:                 USE IN crMotivos
60:             ENDIF
61:             SET NULL ON
62:             CREATE CURSOR crMotivos (Codigos C(10), Descrs C(40), Tipos N(1))
63:             INDEX ON Codigos TAG Codigos
64:             SET NULL OFF
65: 
66:             *-- Carregar dados iniciais (pula em modo ValidandoUI)
67:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
68:                 THIS.this_oBusinessObject.BuscarParametros()
69:                 THIS.CarregarLista()
70:             ENDIF
71: 
72:             *-- Iniciar na pagina de Lista
73:             THIS.pgf_4c_Paginas.Visible = .T.
74:             THIS.pgf_4c_Paginas.ActivePage = 1
75:             THIS.this_cModoAtual = "LISTA"
76: 
77:             loc_lSucesso = .T.

*-- Linhas 332 a 350:
332:             .Width              = 990
333:             .Height             = 510
334:             .RecordMark         = .F.
335:             .DeleteMark         = .F.
336:             .GridLineColor      = RGB(238, 238, 238)
337:             .HighlightBackColor = RGB(255, 255, 255)
338:             .HighlightForeColor = RGB(15, 41, 104)
339:             .HighlightStyle     = 2
340:             .RowHeight          = 16
341:             .ScrollBars         = 2
342:             .GridLines          = 3
343:             .FontName           = "Verdana"
344:             .FontSize           = 8
345:             .ForeColor          = RGB(90, 90, 90)
346:             .BackColor          = RGB(255, 255, 255)
347:             .Visible            = .T.
348:         ENDWITH
349:         WITH par_oPagina.grd_4c_Lista.Column1
350:             .Header1.Caption = "Empresa"

*-- Linhas 767 a 797:
767:             .Height            = 464
768:             .AllowHeaderSizing = .F.
769:             .AllowRowSizing    = .F.
770:             .DeleteMark        = .F.
771:             .RecordMark        = .F.
772:             .HeaderHeight      = 20
773:             .RowHeight         = 20
774:             .ScrollBars        = 2
775:             .GridLineColor     = RGB(238, 238, 238)
776:             .ReadOnly          = .T.
777:             .Panel             = 1
778:             .Visible           = .T.
779: 
780:             *-- Coluna 1: Codigos (Motivo)
781:             WITH .Column1
782:                 .ControlSource = "crMotivos.Codigos"
783:                 .Width         = 94
784:                 .Movable       = .F.
785:                 .Resizable     = .F.
786:                 .ReadOnly      = .T.
787:                 .FontName      = "Tahoma"
788:                 .FontSize      = 8
789:                 WITH .Header1
790:                     .Caption   = "Motivo"
791:                     .FontName  = "Tahoma"
792:                     .FontSize  = 8
793:                     .Alignment = 2
794:                 ENDWITH
795:                 WITH .Text1
796:                     .FontBold    = .F.
797:                     .FontName    = "Tahoma"

*-- Linhas 807 a 825:
807: 
808:             *-- Coluna 2: Descrs (Descricao)
809:             WITH .Column2
810:                 .ControlSource = "crMotivos.Descrs"
811:                 .Width         = 379
812:                 .Movable       = .F.
813:                 .Resizable     = .F.
814:                 .ReadOnly      = .T.
815:                 .FontName      = "Tahoma"
816:                 .FontSize      = 8
817:                 WITH .Header1
818:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
819:                     .FontName  = "Tahoma"
820:                     .FontSize  = 8
821:                     .Alignment = 2
822:                 ENDWITH
823:                 WITH .Text1
824:                     .FontName    = "Tahoma"
825:                     .FontSize    = 8

*-- Linhas 835 a 853:
835:             *-- Coluna 3: Tipos (OptionGroup: Inserir/Excluir/Nenhum)
836:             *-- Sparse=.F.: OptionGroup sempre visivel em todas as linhas
837:             WITH .Column3
838:                 .ControlSource = "crMotivos.Tipos"
839:                 .Width         = 210
840:                 .Movable       = .F.
841:                 .Resizable     = .F.
842:                 .ReadOnly      = .F.
843:                 .Sparse        = .F.
844:                 .FontName      = "Tahoma"
845:                 .FontSize      = 8
846:                 WITH .Header1
847:                     .Caption   = "Tipo"
848:                     .FontName  = "Tahoma"
849:                     .FontSize  = 8
850:                     .Alignment = 2
851:                 ENDWITH
852:             ENDWITH
853:         ENDWITH

*-- Linhas 924 a 949:
924:                     IF VARTYPE(loc_oGrid) = "O"
925:                         loc_oGrid.ColumnCount = 8
926:                         loc_oGrid.RecordSource              = "cursor_4c_Dados"
927:                         loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.Emps"
928:                         loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.grupos"
929:                         loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.codigos"
930:                         loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.descs"
931:                         loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.Prioridades"
932:                         loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.faixais"
933:                         loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
934:                         loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
935:                         *-- Redefinir headers apos RecordSource (VFP reseta automaticamente)
936:                         loc_oGrid.Column1.Header1.Caption   = "Empresa"
937:                         loc_oGrid.Column2.Header1.Caption   = "Grupo"
938:                         loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
939:                         loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
940:                         loc_oGrid.Column5.Header1.Caption   = "Prior."
941:                         loc_oGrid.Column6.Header1.Caption   = "Faixa De"
942:                         loc_oGrid.Column7.Header1.Caption   = "Faixa At" + CHR(233)
943:                         loc_oGrid.Column8.Header1.Caption   = "Selecio."
944:                         THIS.FormatarGridLista(loc_oGrid)
945:                     ENDIF
946:                 ENDIF
947:             ENDIF
948:         CATCH TO loException
949:             MsgErro("Erro em FormCco.CarregarLista: " + loException.Message, "Erro")

*-- Linhas 1044 a 1062:
1044:         loc_cIdChaves = ""
1045: 
1046:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1047:             SELECT cursor_4c_Dados
1048:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cIdChaves)
1049:         ENDIF
1050: 
1051:         IF EMPTY(loc_cIdChaves)
1052:             MsgAviso("Selecione um registro na lista.", "Visualizar")
1053:             RETURN
1054:         ENDIF
1055: 
1056:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1057:             THIS.this_cModoAtual = "VISUALIZAR"
1058:             THIS.BOParaForm()
1059:             THIS.HabilitarCampos(.F.)
1060:             THIS.AjustarBotoesPorModo()
1061: 
1062:             *-- Carregar motivos para grd_4c_Motivos (fase 6)

*-- Linhas 1077 a 1095:
1077:         loc_cIdChaves = ""
1078: 
1079:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1080:             SELECT cursor_4c_Dados
1081:             loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cIdChaves)
1082:         ENDIF
1083: 
1084:         IF EMPTY(loc_cIdChaves)
1085:             MsgAviso("Selecione um registro na lista.", "Alterar")
1086:             RETURN
1087:         ENDIF
1088: 
1089:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1090:             THIS.this_oBusinessObject.EditarRegistro()
1091:             THIS.this_cModoAtual = "ALTERAR"
1092:             THIS.BOParaForm()
1093:             THIS.HabilitarCampos(.T.)
1094:             THIS.AjustarBotoesPorModo()
1095: 

*-- Linhas 1113 a 1131:
1113:         loc_cDescricao = ""
1114: 
1115:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1116:             SELECT cursor_4c_Dados
1117:             loc_cIdChaves  = ALLTRIM(cursor_4c_Dados.cIdChaves)
1118:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.descs)
1119:         ENDIF
1120: 
1121:         IF EMPTY(loc_cIdChaves)
1122:             MsgAviso("Selecione um registro na lista.", "Excluir")
1123:             RETURN
1124:         ENDIF
1125: 
1126:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1127:             RETURN
1128:         ENDIF
1129: 
1130:         IF THIS.this_oBusinessObject.VerificarVinculoCli( ;
1131:                 THIS.this_oBusinessObject.this_cGrupos, ;

*-- Linhas 1162 a 1197:
1162:             RETURN
1163:         ENDIF
1164: 
1165:         loc_cFiltro = "(codigos LIKE " + EscaparSQL("%" + ALLTRIM(loc_cBusca) + "%") + ;
1166:                       " OR descs LIKE " + EscaparSQL("%" + ALLTRIM(loc_cBusca) + "%") + ")"
1167: 
1168:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1169:             loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1170:             IF loc_lSucesso AND USED("cursor_4c_Dados")
1171:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1172:                 IF VARTYPE(loc_oGrid) = "O"
1173:                     loc_oGrid.ColumnCount = 8
1174:                     loc_oGrid.RecordSource              = "cursor_4c_Dados"
1175:                     loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.Emps"
1176:                     loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.grupos"
1177:                     loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.codigos"
1178:                     loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.descs"
1179:                     loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.Prioridades"
1180:                     loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.faixais"
1181:                     loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.faixafs"
1182:                     loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.ClcStatus"
1183:                     loc_oGrid.Column1.Header1.Caption   = "Empresa"
1184:                     loc_oGrid.Column2.Header1.Caption   = "Grupo"
1185:                     loc_oGrid.Column3.Header1.Caption   = "C" + CHR(243) + "digo"
1186:                     loc_oGrid.Column4.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1187:                     loc_oGrid.Column5.Header1.Caption   = "Prior."
1188:                     loc_oGrid.Column6.Header1.Caption   = "Faixa De"
1189:                     loc_oGrid.Column7.Header1.Caption   = "Faixa At" + CHR(233)
1190:                     loc_oGrid.Column8.Header1.Caption   = "Selecio."
1191:                     THIS.FormatarGridLista(loc_oGrid)
1192:                 ENDIF
1193:             ENDIF
1194:         ENDIF
1195:     ENDPROC
1196: 
1197:     *==========================================================================


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

