# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, CARACTERIS

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
  ControlSource = "crSigCrRac.Codigos"
  ControlSource = "crSigCrRac.Descrs"
  ControlSource = "crSigCrRac.Grupos"
  ControlSource = "crSigCrRac.Autos"
  ControlSource = "crSigCrRac.Locks"
  ControlSource = "crSigCrRac.Bloqueios"
  ControlSource = "crSigCrRac.Obrigs"
Select crSigCrRac
Select crSigCrRac
	lcQuery = [Select * ] + ;
			    [From SigClCrc ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigClCrc') < 1)
Select crSigCrRac

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCRC.prg) - TRECHOS RELEVANTES PARA PASS SQL (1270 linhas total):

*-- Linhas 346 a 364:
346:             .HighlightBackColor = RGB(255, 255, 255)
347:             .HighlightForeColor = RGB(15, 41, 104)
348:             .HighlightStyle     = 2
349:             .DeleteMark         = .F.
350:             .RecordMark         = .F.
351:             .RowHeight          = 16
352:             .ScrollBars         = 2
353:             .GridLines          = 3
354:             .Visible            = .T.
355:         ENDWITH
356: 
357:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
358: 
359:         THIS.TornarControlesVisiveis(loc_oPagina)
360:     ENDPROC
361: 
362:     *==========================================================================
363:     * ConfigurarPaginaDados - Estrutura da Page2 (Dados)
364:     * cnt_4c_Salva com botoes Confirmar + Cancelar

*-- Linhas 681 a 702:
681:                             loc_oGrid.ColumnCount = 3
682:                             loc_oGrid.RecordSource = "cursor_4c_Dados"
683: 
684:                             *-- ControlSources APOS RecordSource (Problema 48)
685:                             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.grupos"
686:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.codigos"
687:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
688: 
689:                             loc_oGrid.Column1.Width = 80
690:                             loc_oGrid.Column2.Width = 150
691:                             loc_oGrid.Column3.Width = 290
692: 
693:                             *-- Headers OBRIGATORIO apos RecordSource (Problema 2 / Problema 32)
694:                             loc_oGrid.Column1.Header1.Caption = "Grupo"
695:                             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
696:                             loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
697: 
698:                             THIS.FormatarGridLista(loc_oGrid)
699:                         ENDIF
700:                         loc_lSucesso = .T.
701:                     ENDIF
702:                 ENDIF

*-- Linhas 761 a 802:
761:         LOCAL loc_cCodigo
762: 
763:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
764:             SELECT cursor_4c_Dados
765:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
766: 
767:             IF !EMPTY(loc_cCodigo)
768:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
769:                     THIS.BOParaForm()
770:                     THIS.this_cModoAtual = "VISUALIZAR"
771:                     THIS.HabilitarCampos(.F.)
772:                     THIS.AlternarPagina(2)
773:                 ENDIF
774:             ENDIF
775:         ELSE
776:             MsgAviso("Nenhum registro selecionado!")
777:         ENDIF
778:     ENDPROC
779: 
780:     *==========================================================================
781:     * BtnAlterarClick - Carrega registro selecionado para edicao
782:     *==========================================================================
783:     PROCEDURE BtnAlterarClick()
784:         LOCAL loc_cCodigo
785: 
786:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
787:             SELECT cursor_4c_Dados
788:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
789: 
790:             IF !EMPTY(loc_cCodigo)
791:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
792:                     THIS.this_oBusinessObject.EditarRegistro()
793:                     THIS.BOParaForm()
794:                     THIS.this_cModoAtual = "ALTERAR"
795:                     THIS.HabilitarCampos(.T.)
796:                     THIS.AlternarPagina(2)
797:                 ENDIF
798:             ENDIF
799:         ELSE
800:             MsgAviso("Nenhum registro selecionado!")
801:         ENDIF
802:     ENDPROC

*-- Linhas 808 a 826:
808:         LOCAL loc_cCodigo, loc_lConfirma
809: 
810:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
811:             SELECT cursor_4c_Dados
812:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
813: 
814:             IF !EMPTY(loc_cCodigo)
815:                 loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da caracteristica '" + ;
816:                     loc_cCodigo + "'?", "Excluir")
817:                 IF loc_lConfirma
818:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
819:                         IF THIS.this_oBusinessObject.Excluir()
820:                             MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!")
821:                             THIS.CarregarLista()
822:                         ENDIF
823:                     ENDIF
824:                 ENDIF
825:             ENDIF
826:         ELSE

*-- Linhas 846 a 867:
846:                 loc_oBusca.Show()
847: 
848:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCRC")
849:                     SELECT cursor_4c_BuscaCRC
850:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCRC.codigos)
851:                     IF USED("cursor_4c_Dados")
852:                         SELECT cursor_4c_Dados
853:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
854:                     ENDIF
855:                 ENDIF
856: 
857:                 loc_oBusca.Release()
858:             ENDIF
859:         CATCH TO loException
860:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormCRC.BtnBuscarClick")
861:         ENDTRY
862: 
863:         IF USED("cursor_4c_BuscaCRC")
864:             USE IN cursor_4c_BuscaCRC
865:         ENDIF
866:     ENDPROC
867: 

*-- Linhas 1144 a 1162:
1144:                 loc_oBusca.Show()
1145: 
1146:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1147:                     SELECT cursor_4c_BuscaGcr
1148:                     loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGcr.codigos)
1149:                     loc_cDescricao = ALLTRIM(cursor_4c_BuscaGcr.descrs)
1150:                     IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
1151:                         loc_oPag2.txt_4c_Grupo.Value = loc_cCodigo
1152:                     ENDIF
1153:                     IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
1154:                         loc_oPag2.txt_4c_DGrupos.Value   = loc_cDescricao
1155:                         loc_oPag2.txt_4c_DGrupos.Enabled = .F.
1156:                     ENDIF
1157:                 ENDIF
1158: 
1159:                 loc_oBusca.Release()
1160:             ENDIF
1161:         CATCH TO loException
1162:             MostrarErro("Erro ao abrir busca de grupo:" + CHR(13) + loException.Message, ;

*-- Linhas 1196 a 1214:
1196:                 loc_oBusca.Show()
1197: 
1198:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1199:                     SELECT cursor_4c_BuscaGcr
1200:                     loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGcr.codigos)
1201:                     loc_cDescricao = ALLTRIM(cursor_4c_BuscaGcr.descrs)
1202:                     IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
1203:                         loc_oPag2.txt_4c_Grupo.Value = loc_cCodigo
1204:                     ENDIF
1205:                     IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
1206:                         loc_oPag2.txt_4c_DGrupos.Value   = loc_cDescricao
1207:                         loc_oPag2.txt_4c_DGrupos.Enabled = .F.
1208:                     ENDIF
1209:                 ENDIF
1210: 
1211:                 loc_oBusca.Release()
1212:             ENDIF
1213:         CATCH TO loException
1214:             MostrarErro("Erro ao abrir busca de grupo por descri" + CHR(231) + CHR(227) + "o:" + ;


### BO (C:\4c\projeto\app\classes\CRCBO.prg):
*==============================================================================
* CRCBO.prg - Business Object: Caracteristicas de Contas (SigCrRac)
*==============================================================================
* Tarefa   : task382 - Migracao de SIGCDCRC
* Tabela   : SigCrRac
* PK       : Codigos  (char 20)
*==============================================================================

DEFINE CLASS CRCBO AS BusinessBase

    *-- ----------------------------------------------------------------
    *-- Campos da tabela SigCrRac
    *-- ----------------------------------------------------------------
    this_cCodigos   = ""    && codigos   char(20)  PK
    this_cDescrs    = ""    && descrs    char(40)
    this_cGrupos    = ""    && grupos    char(10)  FK -> SigCdGcr.Codigos
    this_nAutos     = 0     && autos     numeric(1,0)
    this_nLocks     = 0     && locks     numeric(1,0)
    this_nBloqueios = 0     && bloqueios numeric(1,0)
    this_nObrigs    = 0     && obrigs    numeric(1,0)
    this_nCodobs    = 0     && codobs    numeric(3,0)
    this_dDtInis    = {}    && dtinis    datetime NULL
    this_dDtFins    = {}    && dtfins    datetime NULL
    this_nOrdems    = 0     && ordems    numeric(3,0)
    this_cRelacs    = ""    && relacs    char(30)
    this_nTipoops   = 0     && tipoops   numeric(2,0)
    this_nTpprocs   = 0     && tpprocs   numeric(2,0)

    *-- Campo auxiliar de UI (descricao do grupo - vem de SigCdGcr.Descrs, nao persiste)
    this_cDGrupos   = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave do BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCrRac"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para o sistema de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos   = TratarNulo(codigos,   "C")
                THIS.this_cDescrs    = TratarNulo(descrs,    "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_nAutos     = TratarNulo(autos,     "N")
                THIS.this_nLocks     = TratarNulo(locks,     "N")
                THIS.this_nBloqueios = TratarNulo(bloqueios, "N")
                THIS.this_nObrigs    = TratarNulo(obrigs,    "N")
                THIS.this_nCodobs    = TratarNulo(codobs,    "N")
                THIS.this_dDtInis    = TratarNulo(dtinis,    "T")
                THIS.this_dDtFins    = TratarNulo(dtfins,    "T")
                THIS.this_nOrdems    = TratarNulo(ordems,    "N")
                THIS.this_cRelacs    = TratarNulo(relacs,    "C")
                THIS.this_nTipoops   = TratarNulo(tipoops,   "N")
                THIS.this_nTpprocs   = TratarNulo(tpprocs,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CRCBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nResultado, loc_cSQL
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!")
            loc_lValido = .F.
            RETURN loc_lValido
        ENDIF

        IF EMPTY(THIS.this_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!")
            loc_lValido = .F.
            RETURN loc_lValido
        ENDIF

        *-- Verificar duplicidade de Codigos (apenas no INSERT)
        IF THIS.this_lNovoRegistro
            TRY
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRac" + ;
                    " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                    SELECT cursor_4c_ChkCod
                    IF cursor_4c_ChkCod.qtd > 0
                        MsgAviso("C" + CHR(243) + "digo da Caracter" + CHR(237) + "stica J" + CHR(225) + " Cadastrado!!!")
                        loc_lValido = .F.
                    ENDIF
                    USE IN cursor_4c_ChkCod
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CRCBO.ValidarDados")
                loc_lValido = .F.
            ENDTRY
        ENDIF

        IF !loc_lValido
            RETURN loc_lValido
        ENDIF

        *-- Verificar duplicidade de Descrs (INSERT e UPDATE - exceto o proprio registro)
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRac" + ;
                " WHERE descrs = " + EscaparSQL(THIS.this_cDescrs)
            IF !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + " AND codigos <> " + EscaparSQL(THIS.this_cCodigos)
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDesc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDesc")
                SELECT cursor_4c_ChkDesc
                IF cursor_4c_ChkDesc.qtd > 0
                    MsgAviso("Descri" + CHR(231) + CHR(227) + "o da Caracter" + CHR(237) + "stica J" + CHR(225) + " Cadastrada!!!")
                    loc_lValido = .F.
                ENDIF
                USE IN cursor_4c_ChkDesc
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "CRCBO.ValidarDados")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCrRac
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCrRac (codigos, descrs, grupos, autos, locks, bloqueios, obrigs, codobs, dtinis, dtfins, ordems, relacs, tipoops, tpprocs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<FormatarNumeroSQL(THIS.this_nAutos,     0)>>,
                    <<FormatarNumeroSQL(THIS.this_nLocks,     0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBloqueios, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObrigs,    0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodobs,    0)>>,
                    <<IIF(EMPTY(THIS.this_dDtInis), "NULL", FormatarDataSQL(THIS.this_dDtInis))>>,
                    <<IIF(EMPTY(THIS.this_dDtFins), "NULL", FormatarDataSQL(THIS.this_dDtFins))>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdems,    0)>>,
                    <<EscaparSQL(THIS.this_cRelacs)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipoops,   0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpprocs,   0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracteristica de conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CRCBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCrRac
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCrRac
                SET descrs    = <<EscaparSQL(THIS.this_cDescrs)>>,
                    grupos    = <<EscaparSQL(THIS.this_cGrupos)>>,
                    autos     = <<FormatarNumeroSQL(THIS.this_nAutos,     0)>>,
                    locks     = <<FormatarNumeroSQL(THIS.this_nLocks,     0)>>,
                    bloqueios = <<FormatarNumeroSQL(THIS.this_nBloqueios, 0)>>,
                    obrigs    = <<FormatarNumeroSQL(THIS.this_nObrigs,    0)>>,
                    codobs    = <<FormatarNumeroSQL(THIS.this_nCodobs,    0)>>,
                    dtinis    = <<IIF(EMPTY(THIS.this_dDtInis), "NULL", FormatarDataSQL(THIS.this_dDtInis))>>,
                    dtfins    = <<IIF(EMPTY(THIS.this_dDtFins), "NULL", FormatarDataSQL(THIS.this_dDtFins))>>,
                    ordems    = <<FormatarNumeroSQL(THIS.this_nOrdems,    0)>>,
                    relacs    = <<EscaparSQL(THIS.this_cRelacs)>>,
                    tipoops   = <<FormatarNumeroSQL(THIS.this_nTipoops,   0)>>,
                    tpprocs   = <<FormatarNumeroSQL(THIS.this_nTpprocs,   0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracteristica de conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CRCBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCrRac
    * Verifica uso em SigClCrc antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se a caracteristica esta sendo utilizada em SigClCrc
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigClCrc" + ;
                " WHERE Caracteris = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCrc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCrc")
                SELECT cursor_4c_ChkCrc
                loc_nUso = cursor_4c_ChkCrc.qtd
                USE IN cursor_4c_ChkCrc
                IF loc_nUso > 0
                    MsgAviso("Caracter" + CHR(237) + "stica Sendo Utilizada!!!")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCrRac WHERE codigos = " + ;
                        EscaparSQL(THIS.this_cCodigos)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir caracteristica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ELSE
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CRCBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros para o grid da Page1
    * Grid original: Grupos(80), Codigos(150), Descrs(290)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (grupos C(10), codigos C(20), descrs C(40))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupos, codigos, descrs FROM SigCrRac"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

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
                        MostrarErro("Erro ao buscar caracteristicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar caracteristicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CRCBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, grupos, autos, locks, bloqueios, obrigs," + ;
                " codobs, dtinis, dtfins, ordems, relacs, tipoops, tpprocs" + ;
                " FROM SigCrRac WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Caracteristica n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar caracteristica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CRCBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoGrupo - Busca descricao de grupo em SigCdGcr pelo codigo
    * Substitui fAcessoContab(Usuar, 'C', ...) do legado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDescricaoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        TRY
            IF !EMPTY(par_cCodigo)
                loc_cSQL = "SELECT descrs FROM SigCdGcr" + ;
                    " WHERE codigos = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrp")
                IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaGrp")
                    IF !EOF("cursor_4c_BuscaGrp")
                        SELECT cursor_4c_BuscaGrp
                        loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrp.descrs)
                    ENDIF
                    USE IN cursor_4c_BuscaGrp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar grupo:" + CHR(13) + loException.Message, "CRCBO.BuscarDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE

