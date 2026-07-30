# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS

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
  ControlSource = "crSigPrCrt.cods"
  ControlSource = "crSigPrCrt.descs"
  ControlSource = "crSigPrCrt.fators"
  ControlSource = "crSigPrCrt.Seqs"
  ControlSource = "CrSigPrCrt.Emps"
lcQryCrt = [Select * From SigPrCrt Where Emps = ']+_Empr+[' Or Emps = ' ' ]
		Select crSigPrCrt
Select crSigPrCrt

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCrt.prg) - TRECHOS RELEVANTES PARA PASS SQL (1123 linhas total):

*-- Linhas 360 a 378:
360:                 .HighlightBackColor = RGB(255, 255, 255)
361:                 .HighlightForeColor = RGB(15, 41, 104)
362:                 .HighlightStyle     = 2
363:                 .DeleteMark         = .F.
364:                 .RecordMark         = .F.
365:                 .RowHeight          = 16
366:                 .ScrollBars         = 2
367:                 .GridLines          = 3
368:                 .Column1.Width      = 80
369:                 .Column2.Width      = 220
370:                 .Column3.Width      = 80
371:                 .Column3.Alignment  = 1
372:                 .Visible            = .T.
373:             ENDWITH
374: 
375:             THIS.TornarControlesVisiveis(loc_oPagina)
376: 
377:         CATCH TO loc_oErro
378:             MostrarErro("Erro ao configurar pagina Lista:" + CHR(13) + loc_oErro.Message, "FormCrt.ConfigurarPaginaLista")

*-- Linhas 639 a 660:
639:                     loc_oGrid.ColumnCount = 3
640:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
641: 
642:                     *-- ControlSource APOS RecordSource
643:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
644:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descs"
645:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Fators"
646: 
647:                     *-- Reconfigurar cabecalhos APOS RecordSource (VFP9 reseta cabecalhos)
648:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
649:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
650:                     loc_oGrid.Column3.Header1.Caption = "Fator"
651:                     loc_oGrid.Column3.Header1.Alignment = 1
652: 
653:                     THIS.FormatarGridLista(loc_oGrid)
654:                     loc_lResultado = .T.
655:                 ENDIF
656:             ENDIF
657:         CATCH TO loc_oErro
658:             MsgErro("Erro em FormCrt.CarregarLista: " + loc_oErro.Message, "Erro")
659:         ENDTRY
660: 

*-- Linhas 759 a 777:
759:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
760:             MsgAviso("Nenhum registro selecionado!", "Visualizar")
761:         ELSE
762:             SELECT cursor_4c_Dados
763:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
764: 
765:             TRY
766:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
767:                     THIS.this_cModoAtual = "VISUALIZAR"
768:                     THIS.BOParaForm()
769:                     THIS.HabilitarCampos(.F.)
770:                     THIS.AjustarBotoesPorModo()
771:                     THIS.AlternarPagina(2)
772:                     loc_lResultado = .T.
773:                 ELSE
774:                     MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Visualizar")
775:                 ENDIF
776:             CATCH TO loc_oErro
777:                 MsgErro("Erro ao carregar registro:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 789 a 807:
789:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
790:             MsgAviso("Nenhum registro selecionado!", "Alterar")
791:         ELSE
792:             SELECT cursor_4c_Dados
793:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
794: 
795:             TRY
796:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
797:                     THIS.this_oBusinessObject.EditarRegistro()
798:                     THIS.this_cModoAtual = "ALTERAR"
799:                     THIS.BOParaForm()
800:                     THIS.HabilitarCampos(.T.)
801:                     THIS.AjustarBotoesPorModo()
802:                     THIS.AlternarPagina(2)
803:                     loc_lResultado = .T.
804:                 ELSE
805:                     MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Alterar")
806:                 ENDIF
807:             CATCH TO loc_oErro

*-- Linhas 820 a 838:
820:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
821:             MsgAviso("Nenhum registro selecionado!", "Excluir")
822:         ELSE
823:             SELECT cursor_4c_Dados
824:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
825: 
826:             IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do retrabalho: " + loc_cCodigo + "?", "Excluir")
827:                 TRY
828:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
829:                         IF THIS.this_oBusinessObject.Excluir()
830:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
831:                             THIS.CarregarLista()
832:                             loc_lResultado = .T.
833:                         ELSE
834:                             MsgErro("Erro ao excluir o registro!", "Excluir")
835:                         ENDIF
836:                     ELSE
837:                         MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Excluir")
838:                     ENDIF

*-- Linhas 862 a 884:
862:                 loc_oBusca.Show()
863: 
864:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCrt")
865:                     SELECT cursor_4c_BuscaCrt
866:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCrt.Cods)
867: 
868:                     IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
869:                         SELECT cursor_4c_Dados
870:                         LOCATE FOR ALLTRIM(Cods) = loc_cCodigo
871:                         loc_lResultado = FOUND()
872:                     ENDIF
873:                 ENDIF
874: 
875:                 loc_oBusca.Release()
876:             ENDIF
877:         CATCH TO loc_oErro
878:             MsgErro("Erro ao buscar registro:" + CHR(13) + loc_oErro.Message, "Erro")
879:         ENDTRY
880: 
881:         IF USED("cursor_4c_BuscaCrt")
882:             USE IN cursor_4c_BuscaCrt
883:         ENDIF
884:     ENDPROC

*-- Linhas 902 a 955:
902:             RETURN
903:         ENDIF
904: 
905:         SELECT cursor_4c_Dados
906:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Cods)
907: 
908:         TRY
909:             loc_oJus = CREATEOBJECT("FormJus", loc_cCodigo)
910:             IF VARTYPE(loc_oJus) = "O"
911:                 loc_oJus.Show()
912:             ELSE
913:                 MsgAviso("Formul" + CHR(225) + "rio de Justificativas n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Justificativas")
914:             ENDIF
915:         CATCH TO loc_oErro
916:             MsgAviso("Formul" + CHR(225) + "rio de Justificativas n" + CHR(227) + "o dispon" + CHR(237) + "vel." + CHR(13) + loc_oErro.Message, "Justificativas")
917:         ENDTRY
918:     ENDPROC
919: 
920:     *--------------------------------------------------------------------------
921:     * BtnSalvarClick - Salva o registro (INSERT ou UPDATE via BusinessBase.Salvar)
922:     * Validacoes: codigo nao pode estar vazio em INCLUIR + sem codigo duplicado
923:     *--------------------------------------------------------------------------
924:     PROCEDURE BtnSalvarClick()
925:         LOCAL loc_lResultado, loc_cCodigo, loc_nSQL
926:         loc_lResultado = .F.
927: 
928:         loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)
929: 
930:         *-- Validacoes ANTES do TRY (origem: Salva.Click do legado)
931:         IF THIS.this_cModoAtual = "INCLUIR"
932:             IF EMPTY(loc_cCodigo)
933:                 MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "")
934:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
935:                 RETURN
936:             ENDIF
937: 
938:             *-- Verificar se codigo ja existe (CursorQuery -> SQLEXEC equivalente)
939:             loc_nSQL = SQLEXEC(gnConnHandle, ;
940:                 "SELECT Cods FROM SigPrCrt WHERE Cods = " + EscaparSQL(loc_cCodigo), ;
941:                 "cursor_4c_PesqCrt")
942:             IF loc_nSQL > 0 AND RECCOUNT("cursor_4c_PesqCrt") > 0
943:                 IF USED("cursor_4c_PesqCrt")
944:                     USE IN cursor_4c_PesqCrt
945:                 ENDIF
946:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!", "")
947:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
948:                 RETURN
949:             ENDIF
950:             IF USED("cursor_4c_PesqCrt")
951:                 USE IN cursor_4c_PesqCrt
952:             ENDIF
953:         ENDIF
954: 
955:         THIS.FormParaBO()


### BO (C:\4c\projeto\app\classes\CrtBO.prg):
*==============================================================================
* CRTBO.PRG
* Business Object para Cadastro de Retrabalhos (SigPrCrt)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS CrtBO AS BusinessBase

    *-- Propriedades de dados da tabela SigPrCrt
    this_cCodigo    = ""    && cods   CHAR(6)  - Codigo do Retrabalho (PK)
    this_cDescricao = ""    && descs  CHAR(30) - Descricao
    this_nFator     = 0     && fators NUMERIC  - Fator (9999.99)
    this_nSeq       = 0     && Seqs   NUMERIC  - Sequencia/Ordem
    this_cEmpresa   = ""    && Cemps   CHAR(3)  - Empresa Padrao (FK SigCdEmp)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCrt"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCodigo    = ""
        THIS.this_cDescricao = ""
        THIS.this_nFator     = 0
        THIS.this_nSeq       = 0
        THIS.this_cEmpresa   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,  "C")
            THIS.this_cDescricao = TratarNulo(descs, "C")
            THIS.this_nFator     = TratarNulo(fators,"N")
            THIS.this_nSeq       = TratarNulo(Seqs,  "N")
            THIS.this_cEmpresa   = TratarNulo(Emps,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista retrabalhos (SELECT para o grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs, Fators, Seqs, Emps" + ;
                       " FROM SigPrCrt" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " OR Emps = ' '" + ;
                       " ORDER BY Cods"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Cods, Descs, Fators, Seqs, Emps" + ;
                           " FROM SigPrCrt" + ;
                           " WHERE (Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " OR Emps = ' ')" + ;
                           " AND (Cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " OR Descs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")" + ;
                           " ORDER BY Cods"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar retrabalhos: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs, Fators, Seqs, Emps" + ;
                       " FROM SigPrCrt" + ;
                       " WHERE Cods = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                THIS.this_cMensagemErro = "Retrabalho n" + CHR(227) + "o encontrado."
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        FINALLY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigPrCrt (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrCrt (Cods, Descs, Fators, Seqs, Emps)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFator) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeq) + ", " + ;
                       EscaparSQL(THIS.this_cEmpresa) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigPrCrt (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrCrt SET" + ;
                       " Descs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " Fators = " + FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       " Seqs = " + FormatarNumeroSQL(THIS.this_nSeq) + "," + ;
                       " Emps = " + EscaparSQL(THIS.this_cEmpresa) + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigPrCrt (chamado por BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCrt" + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacoes de negocio antes de Salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            LOCAL loc_lExiste, loc_nVerif
            loc_lExiste = .F.
            TRY
                loc_nVerif = SQLEXEC(gnConnHandle, ;
                    "SELECT Cods FROM SigPrCrt WHERE Cods = " + EscaparSQL(THIS.this_cCodigo), ;
                    "cursor_4c_Verif")
                IF loc_nVerif > 0 AND RECCOUNT("cursor_4c_Verif") > 0
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                    loc_lExiste = .T.
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao verificar c" + CHR(243) + "digo: " + loc_oErro.Message, "Erro")
                loc_lValido = .F.
            FINALLY
                IF USED("cursor_4c_Verif")
                    USE IN cursor_4c_Verif
                ENDIF
            ENDTRY
        ENDIF

        RETURN loc_lValido
    ENDFUNC

ENDDEFINE

