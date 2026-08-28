# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NDOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES

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
  ControlSource = "crSigOpPed.nDopes"
  ControlSource = "crSigOpPed.Dopes"
  ControlSource = "crSigOpPed.Tpagos"
  ControlSource = "crSigOpPed.Tutils"
		.Pagina.Lista.Grade.Columns(3).ControlSource = [Iif(crSigOpPed.tPagos = 1,'Pagos',Iif(crSigOpPed.tpagos = 2,'Não Pagos','Todos'))]
		.Pagina.Lista.Grade.Columns(4).ControlSource = [Iif(crSigOpPed.tUtils= 1,'Utilizados',Iif(crSigOpPed.tUtils= 2,'Não Utilizados','Todos'))]
Select crSigOpPed
Select crSigOpPed
Select crSigOpPed
		lcQuery = [Select * ] + ;
				    [From SigOpPed ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crBusca]) < 1)
		Select crBusca
		Delete In crSigOpPed
Select crSigOpPed

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormOpd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1292 linhas total):

*-- Linhas 340 a 358:
340:             .HighlightBackColor = RGB(255, 255, 255)
341:             .HighlightForeColor = RGB(15, 41, 104)
342:             .HighlightStyle     = 2
343:             .DeleteMark         = .F.
344:             .RecordMark         = .F.
345:             .RowHeight          = 16
346:             .ScrollBars         = 2
347:             .GridLines          = 3
348:             .ReadOnly           = .T.
349:             .Visible            = .T.
350:         ENDWITH
351: 
352:         *-- ColumnCount fora do WITH para garantir criacao imediata das colunas
353:         loc_oGrid = loc_oPagina.grd_4c_Lista
354:         loc_oGrid.ColumnCount = 4
355: 
356:         WITH loc_oGrid.Column1
357:             .Width     = 31
358:             .ReadOnly  = .T.

*-- Linhas 617 a 660:
617: 
618:     *===========================================================================
619:     * CarregarLista - Busca registros de SigOpPed e vincula ao grid
620:     * CRITICO: RecordSource, ControlSource e Headers sempre re-definidos apos Buscar
621:     *===========================================================================
622:     PROCEDURE CarregarLista()
623:         LOCAL loc_lResultado, loc_oGrid
624:         loc_lResultado = .F.
625: 
626:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
627:             RETURN .T.
628:         ENDIF
629: 
630:         TRY
631:             loc_lResultado = THIS.this_oBusinessObject.Buscar("")
632: 
633:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
634:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
635: 
636:                 IF VARTYPE(loc_oGrid) = "O"
637:                     *-- RecordSource fora de WITH para garantir auto-bind imediato
638:                     loc_oGrid.ColumnCount = 4
639:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
640: 
641:                     *-- ControlSource re-definido APOS RecordSource (auto-bind sobrescreve)
642:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ndopes"
643:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dopes"
644:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.desc_pagos"
645:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.desc_utils"
646: 
647:                     *-- Larguras re-confirmadas
648:                     loc_oGrid.Column1.Width = 31
649:                     loc_oGrid.Column2.Width = 150
650:                     loc_oGrid.Column3.Width = 80
651:                     loc_oGrid.Column4.Width = 108
652: 
653:                     *-- Headers re-definidos APOS RecordSource (reset para nome do campo)
654:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
655:                     loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
656:                     loc_oGrid.Column3.Header1.Caption = "Pagamentos"
657:                     loc_oGrid.Column4.Header1.Caption = "Utilizados"
658: 
659:                     THIS.FormatarGridLista(loc_oGrid)
660:                     loc_oGrid.Refresh()

*-- Linhas 774 a 792:
774:             RETURN
775:         ENDIF
776: 
777:         SELECT cursor_4c_Dados
778:         IF EOF("cursor_4c_Dados")
779:             MsgAviso("Selecione um registro na lista.")
780:             RETURN
781:         ENDIF
782: 
783:         loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)
784: 
785:         TRY
786:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
787:                 THIS.this_cModoAtual = "VISUALIZAR"
788:                 THIS.BOParaForm()
789:                 THIS.HabilitarCampos(.F.)
790:                 loc_lPode = .T.
791:             ENDIF
792:         CATCH TO loException

*-- Linhas 813 a 831:
813:             RETURN
814:         ENDIF
815: 
816:         SELECT cursor_4c_Dados
817:         IF EOF("cursor_4c_Dados")
818:             MsgAviso("Selecione um registro na lista.")
819:             RETURN
820:         ENDIF
821: 
822:         loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)
823: 
824:         TRY
825:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
826:                 THIS.this_oBusinessObject.EditarRegistro()
827:                 THIS.this_cModoAtual = "ALTERAR"
828:                 THIS.BOParaForm()
829:                 THIS.HabilitarCampos(.T.)
830:                 loc_lPode = .T.
831:             ENDIF

*-- Linhas 853 a 871:
853:             RETURN
854:         ENDIF
855: 
856:         SELECT cursor_4c_Dados
857:         IF EOF("cursor_4c_Dados")
858:             MsgAviso("Selecione um registro na lista.")
859:             RETURN
860:         ENDIF
861: 
862:         loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)
863: 
864:         loc_lConfirmado = MsgConfirma("Confirma exclus" + CHR(227) + "o da opera" + ;
865:             CHR(231) + CHR(227) + "o '" + loc_cDopes + "'?", "Excluir")
866: 
867:         IF !loc_lConfirmado
868:             RETURN
869:         ENDIF
870: 
871:         TRY

*-- Linhas 1058 a 1081:
1058:         ENDIF
1059: 
1060:         TRY
1061:             loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe WHERE Ndopes = " + ;
1062:                 TRANSFORM(loc_nNopes)
1063:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaOpe")
1064: 
1065:             IF loc_nRes > 0 AND USED("cursor_4c_ValidaOpe") AND RECCOUNT("cursor_4c_ValidaOpe") > 0
1066:                 SELECT cursor_4c_ValidaOpe
1067:                 loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_ValidaOpe.Ndopes
1068:                 loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_ValidaOpe.Dopes)
1069:                 IF USED("cursor_4c_ValidaOpe")
1070:                     USE IN cursor_4c_ValidaOpe
1071:                 ENDIF
1072:             ELSE
1073:                 IF USED("cursor_4c_ValidaOpe")
1074:                     USE IN cursor_4c_ValidaOpe
1075:                 ENDIF
1076:                 THIS.AbrirBuscaNopes()
1077:             ENDIF
1078: 
1079:         CATCH TO loException
1080:             IF USED("cursor_4c_ValidaOpe")
1081:                 USE IN cursor_4c_ValidaOpe

*-- Linhas 1093 a 1124:
1093:         loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
1094: 
1095:         TRY
1096:             loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe ORDER BY Ndopes"
1097:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
1098: 
1099:             IF loc_nRes >= 0
1100:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1101:                 IF VARTYPE(loc_oBusca) = "O"
1102:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
1103:                     loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
1104:                     loc_oBusca.mAddColuna("Ndopes", "", "C" + CHR(243) + "digo")
1105:                     loc_oBusca.mAddColuna("Dopes", "", "Descri" + CHR(231) + CHR(227) + "o")
1106:                     loc_oBusca.Show()
1107: 
1108:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1109:                         SELECT cursor_4c_BuscaOpe
1110:                         loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
1111:                         loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1112:                     ENDIF
1113:                     loc_oBusca.Release()
1114:                 ENDIF
1115:             ELSE
1116:                 MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1117:                     CapturarErroSQL(), "FormOpd.AbrirBuscaNopes")
1118:             ENDIF
1119: 
1120:         CATCH TO loException
1121:             MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
1122:                 "FormOpd.AbrirBuscaNopes")
1123:         ENDTRY
1124: 

*-- Linhas 1147 a 1170:
1147:         ENDIF
1148: 
1149:         TRY
1150:             loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe WHERE Dopes LIKE " + ;
1151:                 EscaparSQL(loc_cDopes + "%") + " ORDER BY Dopes"
1152:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
1153: 
1154:             IF loc_nRes > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
1155:                 SELECT cursor_4c_BuscaOpe
1156:                 GO TOP
1157:                 IF RECCOUNT("cursor_4c_BuscaOpe") = 1
1158:                     loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
1159:                     loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1160:                     IF USED("cursor_4c_BuscaOpe")
1161:                         USE IN cursor_4c_BuscaOpe
1162:                     ENDIF
1163:                 ELSE
1164:                     THIS.AbrirBuscaDopes()
1165:                 ENDIF
1166:             ELSE
1167:                 IF USED("cursor_4c_BuscaOpe")
1168:                     USE IN cursor_4c_BuscaOpe
1169:                 ENDIF
1170:                 THIS.AbrirBuscaDopes()

*-- Linhas 1189 a 1225:
1189: 
1190:         TRY
1191:             IF !USED("cursor_4c_BuscaOpe")
1192:                 loc_cSQL = "SELECT Ndopes, Dopes FROM SigCdOpe ORDER BY Dopes"
1193:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
1194:                 IF loc_nRes < 0
1195:                     MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1196:                         CapturarErroSQL(), "FormOpd.AbrirBuscaDopes")
1197:                     RETURN
1198:                 ENDIF
1199:             ENDIF
1200: 
1201:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1202:             IF VARTYPE(loc_oBusca) = "O"
1203:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
1204:                 loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
1205:                 loc_oBusca.mAddColuna("Ndopes", "", "C" + CHR(243) + "digo")
1206:                 loc_oBusca.mAddColuna("Dopes", "", "Descri" + CHR(231) + CHR(227) + "o")
1207:                 loc_oBusca.Show()
1208: 
1209:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1210:                     SELECT cursor_4c_BuscaOpe
1211:                     loc_oPagina2.txt_4c_Nopes.Value = cursor_4c_BuscaOpe.Ndopes
1212:                     loc_oPagina2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1213:                 ENDIF
1214:                 loc_oBusca.Release()
1215:             ENDIF
1216: 
1217:         CATCH TO loException
1218:             MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
1219:                 "FormOpd.AbrirBuscaDopes")
1220:         ENDTRY
1221: 
1222:         IF USED("cursor_4c_BuscaOpe")
1223:             USE IN cursor_4c_BuscaOpe
1224:         ENDIF
1225:     ENDPROC


### BO (C:\4c\projeto\app\classes\OpdBO.prg):
*==============================================================================
* OpdBO.prg - Business Object para Opera??es de Pedido (SigOpPed)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS OpdBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (mapeamento das colunas de SigOpPed)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && cidchaves char(20) - identificador interno
    this_cDopes     = ""   && dopes     char(20) - PK: descri��o da opera��o
    this_nNdopes    = 0    && ndopes    numeric(10,0) - c�digo num�rico
    this_nTpagos    = 0    && tpagos    numeric(10,0) - tipo pagamento (1=Pagos,2=N�o Pagos,3=Todos)
    this_nTutils    = 0    && tutils    numeric(10,0) - tipo utiliza��o (1=Utilizados,2=N�o Utilizados,3=Todos)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = "SigOpPed"
                THIS.this_cCampoChave = "Dopes"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDopes     = TratarNulo(dopes,     "C")
                THIS.this_nNdopes    = TratarNulo(ndopes,    "N")
                THIS.this_nTpagos    = TratarNulo(tpagos,   "N")
                THIS.this_nTutils    = TratarNulo(tutils,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "OpdBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cDopes)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Opera" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nTpagos < 1
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Pagamento!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_nTutils < 1
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Utiliza" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDopesExistente(THIS.this_cDopes)
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + " Cadastrada!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDopesExistente - Verifica se dopes ja existe em SigOpPed
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDopesExistente(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpPed" + ;
                " WHERE dopes = " + EscaparSQL(par_cDopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpd")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOpd")
                SELECT cursor_4c_ChkOpd
                loc_lExiste = (cursor_4c_ChkOpd.qtd > 0)
                USE IN cursor_4c_ChkOpd
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "OpdBO.VerificarDopesExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigOpPed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves se nao definido (equivalente ao fUniqueIds() do legado)
            loc_cCidChaves = ALLTRIM(THIS.this_cCidChaves)
            IF EMPTY(loc_cCidChaves)
                loc_cCidChaves = PADR(ALLTRIM(THIS.this_cDopes), 20)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpPed (cidchaves, dopes, ndopes, tpagos, tutils)
                VALUES (
                    <<EscaparSQL(PADR(loc_cCidChaves, 20))>>,
                    <<EscaparSQL(THIS.this_cDopes)>>,
                    <<FormatarNumeroSQL(THIS.this_nNdopes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpagos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTutils, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChaves = loc_cCidChaves
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "OpdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigOpPed
    * Nota: dopes e a PK, nao pode ser alterado - apenas ndopes, tpagos, tutils
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpPed
                SET ndopes = <<FormatarNumeroSQL(THIS.this_nNdopes, 0)>>,
                    tpagos = <<FormatarNumeroSQL(THIS.this_nTpagos, 0)>>,
                    tutils = <<FormatarNumeroSQL(THIS.this_nTutils, 0)>>
                WHERE dopes = <<EscaparSQL(THIS.this_cDopes)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "OpdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigOpPed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpPed WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "OpdBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com ndopes, dopes, tpagos, tutils
    * Grid colunas 3 e 4 usam IIF no ControlSource para exibir texto
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (ndopes N(10,0), dopes C(20), tpagos N(10,0), tutils N(10,0), desc_pagos C(20), desc_utils C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT ndopes, dopes, tpagos, tutils," + ;
                    " CASE WHEN tpagos = 1 THEN 'Pagos'" + ;
                    " WHEN tpagos = 2 THEN 'Nao Pagos' ELSE 'Todos' END AS desc_pagos," + ;
                    " CASE WHEN tutils = 1 THEN 'Utilizados'" + ;
                    " WHEN tutils = 2 THEN 'Nao Utilizados' ELSE 'Todos' END AS desc_utils" + ;
                    " FROM SigOpPed"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY ndopes"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "OpdBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (dopes)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, dopes, ndopes, tpagos, tutils" + ;
                " FROM SigOpPed WHERE dopes = " + EscaparSQL(par_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "OpdBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

