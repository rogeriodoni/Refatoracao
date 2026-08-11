# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS

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
  ControlSource = "crSigCdPag.descrs"
  ControlSource = "crSigCdPag.grupos"
  ControlSource = "crSigCdPag.relprevs"
select CrSigCdPag
select CrSigCdPag

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpg.prg) - TRECHOS RELEVANTES PARA PASS SQL (1210 linhas total):

*-- Linhas 341 a 359:
341:             .Left               = 12
342:             .Width              = 940
343:             .Height             = 470
344:             .DeleteMark         = .F.
345:             .RecordMark         = .F.
346:             .RowHeight          = 16
347:             .ScrollBars         = 2
348:             .GridLineColor      = RGB(238, 238, 238)
349:             .GridLines          = 3
350:             .HighlightBackColor = RGB(255, 255, 255)
351:             .HighlightForeColor = RGB(15, 41, 104)
352:             .HighlightStyle     = 2
353:             .FontName           = "Verdana"
354:             .FontSize           = 8
355:             .ForeColor          = RGB(90, 90, 90)
356:             .BackColor          = RGB(255, 255, 255)
357:             .Visible            = .T.
358:         ENDWITH
359: 

*-- Linhas 607 a 637:
607:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
608:                     loc_oGrid.ColumnCount  = 3
609: 
610:                     *-- Problema 32: ControlSource e Headers APOS RecordSource (auto-bind reseta)
611:                     WITH loc_oGrid
612:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
613:                         .Column1.Width           = 80
614:                         .Column1.Alignment       = 0
615:                         .Column1.Header1.Caption = "Grupo"
616: 
617:                         .Column2.ControlSource   = "cursor_4c_Dados.descrs"
618:                         .Column2.Width           = 560
619:                         .Column2.Alignment       = 0
620:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
621: 
622:                         .Column3.ControlSource   = "cursor_4c_Dados.relprevs"
623:                         .Column3.Width           = 80
624:                         .Column3.Alignment       = 2
625:                         .Column3.Header1.Caption = "Tipo"
626:                     ENDWITH
627: 
628:                     THIS.FormatarGridLista(loc_oGrid)
629:                     THIS.AjustarBotoesPorModo()
630:                     loc_lResultado = .T.
631:                 ENDIF
632:             ENDIF
633: 
634:         CATCH TO loException
635:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
636:                 "FormFpg.CarregarLista")
637:             loc_lResultado = .F.

*-- Linhas 699 a 717:
699:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
700:                 MsgAviso("Selecione um registro na lista!")
701:             ELSE
702:                 SELECT cursor_4c_Dados
703:                 loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)
704: 
705:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
706:                     THIS.this_cModoAtual = "VISUALIZAR"
707:                     THIS.BOParaForm()
708:                     THIS.HabilitarCampos(.F.)
709:                     THIS.AlternarPagina(2)
710:                     THIS.AjustarBotoesPorModo()
711:                 ENDIF
712:             ENDIF
713:         CATCH TO loException
714:             MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, ;
715:                 "FormFpg.BtnVisualizarClick")
716:         ENDTRY
717:     ENDPROC

*-- Linhas 727 a 745:
727:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
728:                 MsgAviso("Selecione um registro na lista!")
729:             ELSE
730:                 SELECT cursor_4c_Dados
731:                 loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)
732: 
733:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
734:                     THIS.this_oBusinessObject.EditarRegistro()
735:                     THIS.this_cModoAtual = "ALTERAR"
736:                     THIS.BOParaForm()
737:                     THIS.HabilitarCampos(.T.)
738:                     THIS.AlternarPagina(2)
739:                     THIS.AjustarBotoesPorModo()
740:                 ENDIF
741:             ENDIF
742:         CATCH TO loException
743:             MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, ;
744:                 "FormFpg.BtnAlterarClick")
745:         ENDTRY

*-- Linhas 756 a 774:
756:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
757:                 MsgAviso("Selecione um registro na lista!")
758:             ELSE
759:                 SELECT cursor_4c_Dados
760:                 loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)
761: 
762:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do grupo '" + ;
763:                     loc_cGrupos + "'?", "Confirmar Exclus" + CHR(227) + "o")
764: 
765:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
766:                         IF THIS.this_oBusinessObject.Excluir()
767:                             MsgInfo("Grupo exclu" + CHR(237) + "do com sucesso!")
768:                             THIS.CarregarLista()
769:                         ENDIF
770:                     ENDIF
771:                 ENDIF
772:             ENDIF
773:         CATCH TO loException
774:             MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;

*-- Linhas 796 a 827:
796:                 loc_oBusca.Show()
797: 
798:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
799:                     SELECT cursor_4c_BuscaFpg
800:                     loc_cGrupos   = ALLTRIM(cursor_4c_BuscaFpg.grupos)
801:                     loc_lSelecionou = .T.
802:                 ENDIF
803: 
804:                 loc_oBusca.Release()
805:             ENDIF
806: 
807:             IF USED("cursor_4c_BuscaFpg")
808:                 USE IN cursor_4c_BuscaFpg
809:             ENDIF
810: 
811:             IF loc_lSelecionou
812:                 THIS.this_oBusinessObject.Buscar("grupos = " + EscaparSQL(loc_cGrupos))
813:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
814:             ENDIF
815: 
816:         CATCH TO loException
817:             MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, ;
818:                 "FormFpg.BtnBuscarClick")
819:             IF USED("cursor_4c_BuscaFpg")
820:                 USE IN cursor_4c_BuscaFpg
821:             ENDIF
822:         ENDTRY
823:     ENDPROC
824: 
825:     *==========================================================================
826:     * BtnEncerrarClick - Fecha o formulario
827:     *==========================================================================

*-- Linhas 1128 a 1146:
1128:         THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cCodigo, "C", "cursor_4c_GcrVal")
1129: 
1130:         IF USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
1131:             SELECT cursor_4c_GcrVal
1132:             loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_GcrVal.descrs)
1133:         ENDIF
1134: 
1135:         IF USED("cursor_4c_GcrVal")
1136:             USE IN cursor_4c_GcrVal
1137:         ENDIF
1138:     ENDPROC
1139: 
1140:     *--------------------------------------------------------------------------
1141:     * ValidarDsGrupo - LostFocus de txt_4c__ds_grupo
1142:     * Valida descricao em SigCdGcr e preenche codigo (equivale fAcessoContab 'D')
1143:     *--------------------------------------------------------------------------
1144:     PROCEDURE ValidarDsGrupo()
1145:         LOCAL loc_oPagina, loc_cDescricao
1146:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1154 a 1172:
1154:         THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cDescricao, "D", "cursor_4c_GcrDVal")
1155: 
1156:         IF USED("cursor_4c_GcrDVal") AND RECCOUNT("cursor_4c_GcrDVal") > 0
1157:             SELECT cursor_4c_GcrDVal
1158:             IF RECCOUNT("cursor_4c_GcrDVal") = 1
1159:                 loc_oPagina.txt_4c__cd_grupo.Value = ALLTRIM(cursor_4c_GcrDVal.codigos)
1160:                 loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_GcrDVal.descrs)
1161:             ELSE
1162:                 THIS.AbrirLookupGrupoGcr()
1163:             ENDIF
1164:         ENDIF
1165: 
1166:         IF USED("cursor_4c_GcrDVal")
1167:             USE IN cursor_4c_GcrDVal
1168:         ENDIF
1169:     ENDPROC
1170: 
1171:     *--------------------------------------------------------------------------
1172:     * AbrirLookupGrupoGcr - Abre FormBuscaAuxiliar para SigCdGcr

*-- Linhas 1189 a 1207:
1189:                 loc_oBusca.Show()
1190: 
1191:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1192:                     SELECT cursor_4c_BuscaGcr
1193:                     loc_oPagina.txt_4c__cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
1194:                     loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
1195:                 ENDIF
1196: 
1197:                 loc_oBusca.Release()
1198:             ENDIF
1199: 
1200:         CATCH TO loException
1201:             MostrarErro("Erro ao abrir lookup Grupo GCR:" + CHR(13) + loException.Message, ;
1202:                 "FormFpg.AbrirLookupGrupoGcr")
1203:         ENDTRY
1204: 
1205:         IF USED("cursor_4c_BuscaGcr")
1206:             USE IN cursor_4c_BuscaGcr
1207:         ENDIF


### BO (C:\4c\projeto\app\classes\FpgBO.prg):
*====================================================================
* FpgBO.prg
*
* Business Object para Cadastro Financeiro de Pagamentos
* Tabela: SigCdPag
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS FpgBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdPag)
    this_cGrupos   = ""    && grupos char(10) - PK
    this_cDescrs   = ""    && descrs char(30)
    this_nRelprevs = 0     && relprevs numeric(1,0) - 1=Real, 2=Previsto

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPag"
            THIS.this_cCampoChave = "grupos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FpgBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cGrupos   = TratarNulo(grupos,   "C")
                THIS.this_cDescrs   = TratarNulo(descrs,   "C")
                THIS.this_nRelprevs = TratarNulo(relprevs, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "FpgBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cGrupos)
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarGrupoExistente(THIS.this_cGrupos)
                MsgAviso("Grupo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarGrupoExistente - Verifica se grupos ja existe no banco
    *====================================================================
    PROCEDURE VerificarGrupoExistente(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPag" + ;
                " WHERE grupos = " + EscaparSQL(par_cGrupos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkGrp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkGrp")
                SELECT cursor_4c_ChkGrp
                loc_lExiste = (cursor_4c_ChkGrp.qtd > 0)
                USE IN cursor_4c_ChkGrp
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar grupo:" + CHR(13) + loException.Message, "FpgBO.VerificarGrupoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdPag (grupos, descrs, relprevs)
                VALUES (
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<FormatarNumeroSQL(THIS.this_nRelprevs, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "FpgBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdPag
                SET descrs   = <<EscaparSQL(THIS.this_cDescrs)>>,
                    relprevs = <<FormatarNumeroSQL(THIS.this_nRelprevs, 0)>>
                WHERE grupos = <<EscaparSQL(THIS.this_cGrupos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "FpgBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPag WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "FpgBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com grupos, descrs, relprevs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (grupos C(10), descrs C(30), relprevs N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupos, descrs, relprevs FROM SigCdPag"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY grupos"

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
                        MostrarErro("Erro ao buscar grupos de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FpgBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (grupos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs, relprevs FROM SigCdPag" + ;
                " WHERE grupos = " + EscaparSQL(par_cGrupos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grupo de pagamento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "FpgBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarGrupoGcr - Busca grupo de conta corrente em SigCdGcr
    * Usado pelo Form para validar/lookup do campo grupos via fAcessoContab
    * Substitui fAcessoContab(Usuar,'C',codigo,...) e
    *          fAcessoContab(Usuar,'D',descricao,...)
    *====================================================================
    PROCEDURE BuscarGrupoGcr(par_cValor, par_cModo, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCursorDest
        loc_lSucesso = .F.
        loc_cCursorDest = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
            par_cCursorDestino, "cursor_4c_BuscaGcr")

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lSucesso = .T.
            ELSE
                DO CASE
                    CASE UPPER(ALLTRIM(par_cModo)) = "C"
                        loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                            " WHERE codigos = " + EscaparSQL(par_cValor)
                    CASE UPPER(ALLTRIM(par_cModo)) = "D"
                        loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                            " WHERE UPPER(RTRIM(descrs)) LIKE UPPER(" + EscaparSQL(par_cValor + "%") + ")"
                    OTHERWISE
                        loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
                ENDCASE

                IF USED(loc_cCursorDest)
                    USE IN (loc_cCursorDest)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorDest)
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar grupo conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar grupo GCR:" + CHR(13) + loException.Message, "FpgBO.BuscarGrupoGcr")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

