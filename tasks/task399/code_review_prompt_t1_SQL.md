# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, ICLIS

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
  ControlSource = ""
  ControlSource = "crSigCdDis.contas"
  ControlSource = ""
  ControlSource = "crSigCdDis.grupos"
  ControlSource = "crSigCdDis.Tipos"
	SELECT crSigCdDis
	SELECT crSigCdDis
		SELECT crSigCdDis
	SELECT crSigCdDis
		SELECT crSigCdDis
	select crSigCdDis
			select crSigCdDis
		select crSigCdDis
			select crSigCdDis
		select crSigCdDis
	select crSigCdDis

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormDsp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1186 linhas total):

*-- Linhas 336 a 354:
336:             .HighlightBackColor = RGB(255, 255, 255)
337:             .HighlightForeColor = RGB(15, 41, 104)
338:             .HighlightStyle     = 2
339:             .DeleteMark         = .F.
340:             .RecordMark         = .F.
341:             .RowHeight          = 16
342:             .ScrollBars         = 2
343:             .GridLines          = 3
344:             .Visible            = .T.
345: 
346:             .Column1.Width     = 80
347:             .Column1.Alignment = 0
348:             .Column2.Width     = 220
349:             .Column2.Alignment = 0
350:             .Column3.Width     = 100
351:             .Column3.Alignment = 0
352:             .Column4.Width     = 350
353:             .Column4.Alignment = 0
354:             .Column5.Width     = 60

*-- Linhas 641 a 663:
641: 
642:                     loc_oGrd.ColumnCount = 5
643:                     loc_oGrd.RecordSource          = "cursor_4c_Dados"
644:                     loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.Grupos"
645:                     loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.DsGrupos"
646:                     loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.Contas"
647:                     loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.DsConta"
648:                     loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.Tipos"
649: 
650:                     loc_oGrd.Column1.Header1.Caption = "Grupo"
651:                     loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Grupo"
652:                     loc_oGrd.Column3.Header1.Caption = "Conta"
653:                     loc_oGrd.Column4.Header1.Caption = "Nome da Conta"
654:                     loc_oGrd.Column5.Header1.Caption = "Tipo"
655: 
656:                     THIS.FormatarGridLista(loc_oGrd)
657:                     loc_lResultado = .T.
658:                 ENDIF
659:             ENDIF
660:         CATCH TO loc_oErro
661:             MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
662:         ENDTRY
663: 

*-- Linhas 791 a 809:
791:             RETURN
792:         ENDIF
793: 
794:         SELECT cursor_4c_Dados
795:         loc_cChave = ALLTRIM(cursor_4c_Dados.CidChaves)
796: 
797:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
798:             THIS.this_cModoAtual = "VISUALIZAR"
799:             THIS.BOParaForm()
800:             THIS.HabilitarCampos(.F.)
801:             THIS.AjustarBotoesPorModo()
802:             THIS.AlternarPagina(2)
803:         ENDIF
804:     ENDPROC
805: 
806:     *==========================================================================
807:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
808:     *==========================================================================
809:     PROCEDURE BtnAlterarClick()

*-- Linhas 815 a 833:
815:             RETURN
816:         ENDIF
817: 
818:         SELECT cursor_4c_Dados
819:         loc_cChave = ALLTRIM(cursor_4c_Dados.CidChaves)
820: 
821:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
822:             THIS.this_oBusinessObject.EditarRegistro()
823:             THIS.this_cModoAtual = "ALTERAR"
824:             THIS.BOParaForm()
825:             THIS.HabilitarCampos(.T.)
826:             THIS.AjustarBotoesPorModo()
827:             THIS.AlternarPagina(2)
828:         ENDIF
829:     ENDPROC
830: 
831:     *==========================================================================
832:     * BtnExcluirClick - Exclui o registro selecionado na lista
833:     *==========================================================================

*-- Linhas 841 a 859:
841:             RETURN
842:         ENDIF
843: 
844:         SELECT cursor_4c_Dados
845:         loc_cChave = ALLTRIM(cursor_4c_Dados.CidChaves)
846: 
847:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do registro selecionado?", ;
848:             "Excluir Disponibilidade")
849: 
850:         IF loc_lConfirma
851:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
852:                 IF THIS.this_oBusinessObject.Excluir()
853:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
854:                         "Exclus" + CHR(227) + "o")
855:                     THIS.CarregarLista()
856:                 ENDIF
857:             ENDIF
858:         ENDIF
859:     ENDPROC

*-- Linhas 1048 a 1077:
1048:             IF VARTYPE(loc_oBusca) = "O"
1049:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1050:                     IF USED("cursor_4c_BuscaGrupo")
1051:                         SELECT cursor_4c_BuscaGrupo
1052:                         loc_oPagina.txt_4c_cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1053:                         loc_oPagina.txt_4c_ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1054:                     ENDIF
1055:                 ELSE
1056:                     IF !loc_oBusca.this_lAchouRegistro
1057:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1058:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1059:                     loc_oBusca.Show()
1060: 
1061:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1062:                         SELECT cursor_4c_BuscaGrupo
1063:                         loc_oPagina.txt_4c_cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1064:                         loc_oPagina.txt_4c_ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1065:                     ENDIF
1066:                     ENDIF
1067:                 ENDIF
1068:                 loc_oBusca.Release()
1069:             ENDIF
1070:         CATCH TO loc_oErro
1071:             MsgErro("Erro ao abrir busca de grupo: " + loc_oErro.Message, "Erro")
1072:         ENDTRY
1073: 
1074:         IF USED("cursor_4c_BuscaGrupo")
1075:             USE IN cursor_4c_BuscaGrupo
1076:         ENDIF
1077:     ENDPROC

*-- Linhas 1145 a 1163:
1145:                     loc_oBusca.Show()
1146: 
1147:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1148:                         SELECT cursor_4c_BuscaConta
1149:                         loc_oPagina.txt_4c_cd_conta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
1150:                         loc_oPagina.txt_4c_ds_conta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
1151:                     ENDIF
1152:                     loc_oBusca.Release()
1153:                 ENDIF
1154:             ENDIF
1155:         CATCH TO loc_oErro
1156:             MsgErro("Erro ao abrir busca de conta: " + loc_oErro.Message, "Erro")
1157:         ENDTRY
1158: 
1159:         IF USED("cursor_4c_BuscaConta")
1160:             USE IN cursor_4c_BuscaConta
1161:         ENDIF
1162:     ENDPROC
1163: 


### BO (C:\4c\projeto\app\classes\DspBO.prg):
*==============================================================================
* DspBO.prg - Business Object para Cadastro de Disponibilidades
* Tabela: SigCdDis
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DspBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdDis
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && char(20) PK - gerado por SYS(2015)
    this_cGrupos    = ""   && char(10) FK -> SigCdGcr.Codigos
    this_cContas    = ""   && char(10) FK -> SigCdCli.IClis
    this_nTipos     = 1    && numeric(1,0) 1=Disponibilidade 2=Investimento 3=Emprestimo

    *--------------------------------------------------------------------------
    * Campos auxiliares (nao persistidos - apenas para exibicao no form)
    *--------------------------------------------------------------------------
    this_cDsGrupo   = ""   && descricao do grupo (SigCdGcr.Descrs)
    this_cDsConta   = ""   && descricao da conta (SigCdCli.RClis)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDis"
            THIS.this_cCampoChave = "CidChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de disponibilidades no cursor cursor_4c_Dados
    * par_cFiltro: filtro SQL adicional (vazio = todos)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.Grupos," + ;
                       " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
                       " a.Contas, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
                       " FROM SigCdDis a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = a.Contas AND c.Grupos = a.Grupos"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Contas"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_Dados
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar disponibilidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega disponibilidade pelo CidChaves (PK)
    * par_cCodigo: valor do CidChaves
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.Grupos," + ;
                       " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
                       " a.Contas, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
                       " FROM SigCdDis a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = a.Contas AND c.Grupos = a.Grupos" + ;
                       " WHERE a.CidChaves = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * par_cAliasCursor: nome do cursor (SELECT antes de acessar campos)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                THIS.this_cGrupos    = TratarNulo(Grupos,    "C")
                THIS.this_cContas    = TratarNulo(Contas,    "C")
                THIS.this_nTipos     = TratarNulo(Tipos,     "N")
                THIS.this_cDsGrupo   = TratarNulo(DsGrupos,  "C")
                THIS.this_cDsConta   = TratarNulo(DsConta,   "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Insere nova disponibilidade (PROTECTED)
    * Gera CidChaves via SYS(2015), verifica duplicidade antes de INSERT
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cContas, "")
                MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015), 20)

                loc_cSQL = "INSERT INTO SigCdDis (CidChaves, Grupos, Contas, Tipos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves)            + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cGrupos, 10))     + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cContas, 10))     + ", " + ;
                           FormatarNumeroSQL(THIS.this_nTipos)         + ;
                           ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza disponibilidade existente (PROTECTED)
    * Verifica duplicidade (excluindo o registro atual) antes de UPDATE
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cContas, THIS.this_cCidChaves)
                MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "UPDATE SigCdDis SET" + ;
                           " Grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                           " Contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
                           " Tipos  = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
                           " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui disponibilidade (PROTECTED)
    * Chamado internamente por Excluir() do BusinessBase
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDis WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir disponibilidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com Grupos+Contas
    * par_cGrupos: codigo do grupo
    * par_cContas: codigo da conta
    * par_cExcluirChave: PK a excluir da verificacao (vazio=INSERT, atual=UPDATE)
    * Retorna: .T. se duplicado, .F. se nao existe
    *==========================================================================
    PROCEDURE VerificarDuplicidade(par_cGrupos, par_cContas, par_cExcluirChave)
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Duplic")
                USE IN cursor_4c_Duplic
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDis" + ;
                       " WHERE Grupos = " + EscaparSQL(LEFT(par_cGrupos, 10)) + ;
                       " AND Contas = " + EscaparSQL(par_cContas)

            IF VARTYPE(par_cExcluirChave) = "C" AND !EMPTY(ALLTRIM(par_cExcluirChave))
                loc_cSQL = loc_cSQL + " AND CidChaves <> " + EscaparSQL(par_cExcluirChave)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Duplic") > 0
                SELECT cursor_4c_Duplic
                loc_lDuplicado = (Total > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Duplic")
            USE IN cursor_4c_Duplic
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Valida codigo de grupo e carrega descricao
    * par_cGrupo: codigo do grupo (SigCdGcr.Codigos)
    * Retorna: .T. se valido | Efeito: popula this_cDsGrupo
    *==========================================================================
    PROCEDURE ValidarGrupo(par_cGrupo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_ValGrupo")
                USE IN cursor_4c_ValGrupo
            ENDIF

            IF EMPTY(ALLTRIM(par_cGrupo))
                THIS.this_cDsGrupo = ""
            ELSE
                loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(par_cGrupo)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrupo")

                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValGrupo") > 0
                    SELECT cursor_4c_ValGrupo
                    THIS.this_cDsGrupo = ALLTRIM(cursor_4c_ValGrupo.Descrs)
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cDsGrupo = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ValGrupo")
            USE IN cursor_4c_ValGrupo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarConta - Valida codigo de conta dentro de um grupo
    * par_cGrupo: codigo do grupo (filtro)
    * par_cConta: codigo da conta (SigCdCli.IClis)
    * Retorna: .T. se valida | Efeito: popula this_cDsConta
    *==========================================================================
    PROCEDURE ValidarConta(par_cGrupo, par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_ValConta")
                USE IN cursor_4c_ValConta
            ENDIF

            IF EMPTY(ALLTRIM(par_cConta))
                THIS.this_cDsConta = ""
            ELSE
                loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(par_cConta)

                IF VARTYPE(par_cGrupo) = "C" AND !EMPTY(ALLTRIM(par_cGrupo))
                    loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(LEFT(par_cGrupo, 10))
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")

                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValConta") > 0
                    SELECT cursor_4c_ValConta
                    THIS.this_cDsConta = ALLTRIM(cursor_4c_ValConta.Rclis)
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cDsConta = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar conta: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ValConta")
            USE IN cursor_4c_ValConta
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarGrupos - Popula cursor_4c_BuscaGrupo para lookup de grupos
    * par_cFiltro: prefixo para filtrar por Codigos (vazio = todos)
    *==========================================================================
    PROCEDURE BuscarGrupos(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_cSQL = "SELECT Codigos, RTRIM(Descrs) AS Descrs FROM SigCdGcr"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE Codigos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_BuscaGrupo
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarContas - Popula cursor_4c_BuscaConta para lookup de contas
    * par_cGrupo: grupo para filtrar (vazio = sem filtro de grupo)
    * par_cFiltro: prefixo para filtrar por Iclis (vazio = todos)
    *==========================================================================
    PROCEDURE BuscarContas(par_cGrupo, par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
        loc_lResultado = .F.
        loc_cWhere     = ""

        TRY
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_cSQL = "SELECT Iclis, RTRIM(Rclis) AS Rclis FROM SigCdCli"

            IF VARTYPE(par_cGrupo) = "C" AND !EMPTY(ALLTRIM(par_cGrupo))
                loc_cWhere = " WHERE Grupos = " + EscaparSQL(LEFT(par_cGrupo, 10))
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = " WHERE Iclis LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
                ELSE
                    loc_cWhere = loc_cWhere + " AND Iclis LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
                ENDIF
            ENDIF

            loc_cSQL = loc_cSQL + loc_cWhere + " ORDER BY Iclis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResult >= 0
                GO TOP IN cursor_4c_BuscaConta
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar contas: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

