# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDsp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1189 linhas total):

*-- Linhas 339 a 357:
339:             .HighlightBackColor = RGB(255, 255, 255)
340:             .HighlightForeColor = RGB(15, 41, 104)
341:             .HighlightStyle     = 2
342:             .DeleteMark         = .F.
343:             .RecordMark         = .F.
344:             .RowHeight          = 16
345:             .ScrollBars         = 2
346:             .GridLines          = 3
347:             .Visible            = .T.
348: 
349:             .Column1.Width     = 80
350:             .Column1.Alignment = 0
351:             .Column2.Width     = 220
352:             .Column2.Alignment = 0
353:             .Column3.Width     = 100
354:             .Column3.Alignment = 0
355:             .Column4.Width     = 350
356:             .Column4.Alignment = 0
357:             .Column5.Width     = 60

*-- Linhas 644 a 666:
644: 
645:                     loc_oGrd.ColumnCount = 5
646:                     loc_oGrd.RecordSource          = "cursor_4c_Dados"
647:                     loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.Grupos"
648:                     loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.DsGrupos"
649:                     loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.Iclis"
650:                     loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.DsConta"
651:                     loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.Tipos"
652: 
653:                     loc_oGrd.Column1.Header1.Caption = "Grupo"
654:                     loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Grupo"
655:                     loc_oGrd.Column3.Header1.Caption = "Conta"
656:                     loc_oGrd.Column4.Header1.Caption = "Nome da Conta"
657:                     loc_oGrd.Column5.Header1.Caption = "Tipo"
658: 
659:                     THIS.FormatarGridLista(loc_oGrd)
660:                     loc_lResultado = .T.
661:                 ENDIF
662:             ENDIF
663:         CATCH TO loc_oErro
664:             MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
665:         ENDTRY
666: 

*-- Linhas 794 a 812:
794:             RETURN
795:         ENDIF
796: 
797:         SELECT cursor_4c_Dados
798:         loc_cChave = ALLTRIM(cursor_4c_Dados.Codigos)
799: 
800:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
801:             THIS.this_cModoAtual = "VISUALIZAR"
802:             THIS.BOParaForm()
803:             THIS.HabilitarCampos(.F.)
804:             THIS.AjustarBotoesPorModo()
805:             THIS.AlternarPagina(2)
806:         ENDIF
807:     ENDPROC
808: 
809:     *==========================================================================
810:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
811:     *==========================================================================
812:     PROCEDURE BtnAlterarClick()

*-- Linhas 818 a 836:
818:             RETURN
819:         ENDIF
820: 
821:         SELECT cursor_4c_Dados
822:         loc_cChave = ALLTRIM(cursor_4c_Dados.Codigos)
823: 
824:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
825:             THIS.this_oBusinessObject.EditarRegistro()
826:             THIS.this_cModoAtual = "ALTERAR"
827:             THIS.BOParaForm()
828:             THIS.HabilitarCampos(.T.)
829:             THIS.AjustarBotoesPorModo()
830:             THIS.AlternarPagina(2)
831:         ENDIF
832:     ENDPROC
833: 
834:     *==========================================================================
835:     * BtnExcluirClick - Exclui o registro selecionado na lista
836:     *==========================================================================

*-- Linhas 844 a 862:
844:             RETURN
845:         ENDIF
846: 
847:         SELECT cursor_4c_Dados
848:         loc_cChave = ALLTRIM(cursor_4c_Dados.Codigos)
849: 
850:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do registro selecionado?", ;
851:             "Excluir Disponibilidade")
852: 
853:         IF loc_lConfirma
854:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
855:                 IF THIS.this_oBusinessObject.Excluir()
856:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
857:                         "Exclus" + CHR(227) + "o")
858:                     THIS.CarregarLista()
859:                 ENDIF
860:             ENDIF
861:         ENDIF
862:     ENDPROC

*-- Linhas 1051 a 1080:
1051:             IF VARTYPE(loc_oBusca) = "O"
1052:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1053:                     IF USED("cursor_4c_BuscaGrupo")
1054:                         SELECT cursor_4c_BuscaGrupo
1055:                         loc_oPagina.txt_4c_cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1056:                         loc_oPagina.txt_4c_ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1057:                     ENDIF
1058:                 ELSE
1059:                     IF !loc_oBusca.this_lAchouRegistro
1060:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1061:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1062:                     loc_oBusca.Show()
1063: 
1064:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1065:                         SELECT cursor_4c_BuscaGrupo
1066:                         loc_oPagina.txt_4c_cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1067:                         loc_oPagina.txt_4c_ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1068:                     ENDIF
1069:                     ENDIF
1070:                 ENDIF
1071:                 loc_oBusca.Release()
1072:             ENDIF
1073:         CATCH TO loc_oErro
1074:             MsgErro("Erro ao abrir busca de grupo: " + loc_oErro.Message, "Erro")
1075:         ENDTRY
1076: 
1077:         IF USED("cursor_4c_BuscaGrupo")
1078:             USE IN cursor_4c_BuscaGrupo
1079:         ENDIF
1080:     ENDPROC

*-- Linhas 1148 a 1166:
1148:                     loc_oBusca.Show()
1149: 
1150:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1151:                         SELECT cursor_4c_BuscaConta
1152:                         loc_oPagina.txt_4c_cd_conta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
1153:                         loc_oPagina.txt_4c_ds_conta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
1154:                     ENDIF
1155:                     loc_oBusca.Release()
1156:                 ENDIF
1157:             ENDIF
1158:         CATCH TO loc_oErro
1159:             MsgErro("Erro ao abrir busca de conta: " + loc_oErro.Message, "Erro")
1160:         ENDTRY
1161: 
1162:         IF USED("cursor_4c_BuscaConta")
1163:             USE IN cursor_4c_BuscaConta
1164:         ENDIF
1165:     ENDPROC
1166: 


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
    this_cCodigos   = ""   && char(20) PK - gerado por SYS(2015)
    this_cGrupos    = ""   && char(10) FK -> SigCdGcr.Codigos
    this_cIclis     = ""   && char(10) FK -> SigCdCli.IClis
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
            THIS.this_cCampoChave = "Codigos"
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

            loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
                       " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
                       " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
                       " FROM SigCdDis a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Iclis"

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
    * CarregarPorCodigo - Carrega disponibilidade pelo Codigos (PK)
    * par_cCodigo: valor do Codigos
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.Codigos, a.Grupos," + ;
                       " RTRIM(ISNULL(b.Descrs,'')) AS DsGrupos," + ;
                       " a.Iclis, RTRIM(ISNULL(c.Rclis,'')) AS DsConta, a.Tipos" + ;
                       " FROM SigCdDis a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = a.Iclis" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigo)

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
                THIS.this_cCodigos   = TratarNulo(Codigos,  "C")
                THIS.this_cGrupos    = TratarNulo(Grupos,   "C")
                THIS.this_cIclis     = TratarNulo(Iclis,    "C")
                THIS.this_nTipos     = TratarNulo(Tipos,    "N")
                THIS.this_cDsGrupo   = TratarNulo(DsGrupos, "C")
                THIS.this_cDsConta   = TratarNulo(DsConta,  "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Insere nova disponibilidade (PROTECTED)
    * Gera Codigos via SYS(2015), verifica duplicidade antes de INSERT
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cIclis, "")
                MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.this_cCodigos = LEFT(SYS(2015) + SYS(2015), 20)

                loc_cSQL = "INSERT INTO SigCdDis (Codigos, Grupos, Iclis, Tipos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCodigos)               + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cGrupos, 10))      + ", " + ;
                           EscaparSQL(LEFT(THIS.this_cIclis, 10))       + ", " + ;
                           FormatarNumeroSQL(THIS.this_nTipos)          + ;
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
            IF THIS.VerificarDuplicidade(THIS.this_cGrupos, THIS.this_cIclis, THIS.this_cCodigos)
                MsgErro("Disponibilidade j" + CHR(225) + " est" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "UPDATE SigCdDis SET" + ;
                           " Grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                           " Iclis  = " + EscaparSQL(LEFT(THIS.this_cIclis, 10))  + "," + ;
                           " Tipos  = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
                           " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

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
            loc_cSQL = "DELETE FROM SigCdDis WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

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
        RETURN THIS.this_cCodigos
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com Iclis
    * par_cGrupos: reservado (nao utilizado no filtro SQL)
    * par_cContas: codigo da conta (Iclis)
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
                       " WHERE Iclis = " + EscaparSQL(par_cContas)

            IF VARTYPE(par_cExcluirChave) = "C" AND !EMPTY(ALLTRIM(par_cExcluirChave))
                loc_cSQL = loc_cSQL + " AND Codigos <> " + EscaparSQL(par_cExcluirChave)
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
    * ValidarConta - Valida codigo de conta (SigCdCli.IClis)
    * par_cGrupo: nao utilizado no filtro SQL
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
    * par_cGrupo: nao utilizado no filtro SQL
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

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE Iclis LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
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

