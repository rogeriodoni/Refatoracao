# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'USUARIOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, TRANSACAOS, PROGS, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NCOMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, TRANSACAOS, PROGS, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, TRANSACAOS, PROGS, CIDCHAVES

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
  ControlSource = ""
ThisForm.poDatamgr.SqlExecute([Select Razas From SigCdEmp Where cEmps = ']+_empr+['],'crSigCdEmp')
Select crCabecalho 
	lcQuery = [Select * From SigOpLog Where Transacaos Like '%]+ThisForm.GetCGrupo.Value+[%' And ]+;
	ThisForm.poDatamgr.SqlExecute(lcQuery,'crDBImp')
	lcQuery = [Select * From SigOpLog Where Transacaos Like '%]+ThisForm.GetCUsuario.Value+[%' And ]+;
	ThisForm.poDatamgr.SqlExecute(lcQuery,'crDBImp')
			lcQuery = [Select * From SigOpLog Where Transacaos Like '%]+lcGrupo+[%' And ]+;
			ThisForm.poDatamgr.SqlExecute(lcQuery,'crDBGru')
			Select * from crDBGru Where cIdChaves Not In (Select cIdChaves From crDBImp) into cursor crDBIns
			Select crDBImp
			Append From Dbf('crDBIns')
Select crDBIMP

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReAac.prg) - TRECHOS RELEVANTES PARA PASS SQL (1190 linhas total):

*-- Linhas 597 a 619:
597:             THIS.AtualizarEstadoCampos()
598:             RETURN
599:         ENDIF
600:         loc_cSQL = "SELECT Usuarios, NComps FROM SigCdUsu WHERE Usuarios = " + ;
601:                    EscaparSQL(loc_cCodigo)
602:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuVal")
603:         IF loc_nResult > 0
604:             SELECT cursor_4c_UsuVal
605:             IF !EOF()
606:                 loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(Usuarios)
607:                 loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(NComps)
608:             ELSE
609:                 THIS.AbrirBuscaCUsuario()
610:             ENDIF
611:             USE IN cursor_4c_UsuVal
612:         ELSE
613:             THIS.AbrirBuscaCUsuario()
614:         ENDIF
615:         THIS.AtualizarEstadoCampos()
616:     ENDPROC
617: 
618:     *--------------------------------------------------------------------------
619:     * ValidarDUsuario - Busca usuario pelo nome digitado (SigCdUsu.NComps)

*-- Linhas 628 a 650:
628:             THIS.AtualizarEstadoCampos()
629:             RETURN
630:         ENDIF
631:         loc_cSQL = "SELECT Usuarios, NComps FROM SigCdUsu WHERE NComps LIKE " + ;
632:                    EscaparSQL(loc_cNome + "%")
633:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuNomVal")
634:         IF loc_nResult > 0
635:             SELECT cursor_4c_UsuNomVal
636:             IF !EOF()
637:                 loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(Usuarios)
638:                 loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(NComps)
639:             ELSE
640:                 THIS.AbrirBuscaDUsuario()
641:             ENDIF
642:             USE IN cursor_4c_UsuNomVal
643:         ELSE
644:             THIS.AbrirBuscaDUsuario()
645:         ENDIF
646:         THIS.AtualizarEstadoCampos()
647:     ENDPROC
648: 
649:     *--------------------------------------------------------------------------
650:     * ValidarCGrupo - Busca grupo pelo codigo digitado (SigCdGrA.Grupos)

*-- Linhas 659 a 681:
659:             THIS.AtualizarEstadoCampos()
660:             RETURN
661:         ENDIF
662:         loc_cSQL = "SELECT Grupos, NComps FROM SigCdGrA WHERE Grupos = " + ;
663:                    EscaparSQL(loc_cCodigo)
664:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrAVal")
665:         IF loc_nResult > 0
666:             SELECT cursor_4c_GrAVal
667:             IF !EOF()
668:                 loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(Grupos)
669:                 loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(NComps)
670:             ELSE
671:                 THIS.AbrirBuscaCGrupo()
672:             ENDIF
673:             USE IN cursor_4c_GrAVal
674:         ELSE
675:             THIS.AbrirBuscaCGrupo()
676:         ENDIF
677:         THIS.AtualizarEstadoCampos()
678:     ENDPROC
679: 
680:     *--------------------------------------------------------------------------
681:     * ValidarDGrupo - Busca grupo pelo nome digitado (SigCdGrA.NComps)

*-- Linhas 690 a 712:
690:             THIS.AtualizarEstadoCampos()
691:             RETURN
692:         ENDIF
693:         loc_cSQL = "SELECT Grupos, NComps FROM SigCdGrA WHERE NComps LIKE " + ;
694:                    EscaparSQL(loc_cNome + "%")
695:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrANomVal")
696:         IF loc_nResult > 0
697:             SELECT cursor_4c_GrANomVal
698:             IF !EOF()
699:                 loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(Grupos)
700:                 loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(NComps)
701:             ELSE
702:                 THIS.AbrirBuscaDGrupo()
703:             ENDIF
704:             USE IN cursor_4c_GrANomVal
705:         ELSE
706:             THIS.AbrirBuscaDGrupo()
707:         ENDIF
708:         THIS.AtualizarEstadoCampos()
709:     ENDPROC
710: 
711:     *==========================================================================
712:     * LOOKUPS FormBuscaAuxiliar (PUBLIC - contrato BINDEVENT DblClick)


### BO (C:\4c\projeto\app\classes\SigReAacBO.prg):
*==============================================================================
* SIGREAACBO.PRG
* Business Object para Relatorio do Log de Acessos
* Herda de RelatorioBase
*
* Tabelas: SigOpLog (dados), SigCdEmp (cabecalho),
*          SigCdUsu (lookup usuario), SigCdGrA (lookup grupo)
* Filtros: Codigo/Nome do Usuario OU Codigo/Nome do Grupo
*==============================================================================

DEFINE CLASS SigReAacBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCUsuario          = ""
    this_cDUsuario          = ""
    this_cCGrupo            = ""
    this_cDGrupo            = ""

    *-- Cursores utilizados
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *-- Configuracao do relatorio
    this_cFRXPath           = ""
    this_cTituloRel         = ""
    this_cSubTitulo         = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                THIS.this_cFRXPath   = gc_4c_CaminhoReports + "RelSigReAac.frx"
                THIS.this_cTituloRel = "Relat" + CHR(243) + "rio do Log de Acessos"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores de cabecalho e dados para o relatorio
    *
    * Logica original (processamento):
    *   1. Valida pelo menos um filtro ativo (grupo OU usuario)
    *   2. Obtem razao social da empresa em SigCdEmp
    *   3. Cria cursor de cabecalho com titulo/subtitulo/empresa
    *   4. Filtro GRUPO: SigOpLog WHERE Transacaos LIKE grupo
    *      AND Progs IN ('CADGRU','CADUSU')
    *   5. Filtro USUARIO: SigOpLog WHERE Transacaos LIKE usuario
    *      AND Progs IN ('CADUSU','CADGRU'), depois enriquece cursor com
    *      registros de grupo associados ao usuario que ainda nao constam
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_lContinuar
        LOCAL loc_cEmpDesc, loc_nRegs, loc_nI, loc_cGrupo, loc_nRec
        LOCAL loc_cCUsuarioEsc, loc_cCGrupoEsc, loc_cGrupoEsc
        loc_lSucesso  = .F.
        loc_lContinuar = .T.
        TRY
            *-- Validar: pelo menos um filtro obrigatorio
            IF EMPTY(THIS.this_cCGrupo) AND EMPTY(THIS.this_cCUsuario)
                THIS.this_cMensagemErro = "Sele" + CHR(231) + CHR(227) + ;
                                          "o n" + CHR(227) + "o Realizada !!!"
                loc_lContinuar = .F.
            ENDIF

            *-- Obter razao social da empresa
            IF loc_lContinuar
                loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE cEmps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRaz")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao obter dados da empresa"
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Montar descricao da empresa para o cabecalho
            IF loc_lContinuar
                IF USED("cursor_4c_EmpRaz") AND RECCOUNT("cursor_4c_EmpRaz") > 0
                    SELECT cursor_4c_EmpRaz
                    loc_cEmpDesc = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(Razas)
                ELSE
                    loc_cEmpDesc = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
                IF USED("cursor_4c_EmpRaz")
                    USE IN cursor_4c_EmpRaz
                ENDIF
            ENDIF

            *-- Recriar cursor de cabecalho
            IF loc_lContinuar
                IF USED(THIS.this_cCursorCabecalho)
                    USE IN (THIS.this_cCursorCabecalho)
                ENDIF
                CREATE CURSOR cursor_4c_Cabecalho (cTitulos C(80), cSubTitulos C(80), Empresa C(80))
                SELECT cursor_4c_Cabecalho
                APPEND BLANK
                REPLACE Empresa WITH loc_cEmpDesc
            ENDIF

            *-- FILTRO POR GRUPO
            IF loc_lContinuar AND !EMPTY(THIS.this_cCGrupo)
                SELECT cursor_4c_Cabecalho
                REPLACE cTitulos WITH "RELATORIO DO LOG DE ALTERA" + ;
                                      CHR(199) + CHR(195) + "O GRUPOS DE ACESSOS"
                REPLACE cSubTitulos WITH "Grupo : " + ;
                                         ALLTRIM(THIS.this_cCGrupo) + " - " + ;
                                         ALLTRIM(THIS.this_cDGrupo)

                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                loc_cCGrupoEsc = STRTRAN(ALLTRIM(THIS.this_cCGrupo), "'", "''")
                loc_cSQL = "SELECT * FROM SigOpLog" + ;
                           " WHERE Transacaos LIKE '%" + loc_cCGrupoEsc + "%'" + ;
                           " AND (Progs = 'CADGRU' OR Progs = 'CADUSU')" + ;
                           " ORDER BY Datars"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar dados do log por grupo"
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- FILTRO POR USUARIO
            IF loc_lContinuar AND !EMPTY(THIS.this_cCUsuario)
                SELECT cursor_4c_Cabecalho
                REPLACE cTitulos WITH "RELATORIO DO LOG DE ALTERA" + ;
                                      CHR(199) + CHR(195) + "O DE ACESSOS DE USUARIOS"
                REPLACE cSubTitulos WITH "Usu" + CHR(225) + "rio : " + ;
                                         ALLTRIM(THIS.this_cCUsuario) + " - " + ;
                                         ALLTRIM(THIS.this_cDUsuario)

                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                loc_cCUsuarioEsc = STRTRAN(ALLTRIM(THIS.this_cCUsuario), "'", "''")
                loc_cSQL = "SELECT * FROM SigOpLog" + ;
                           " WHERE Transacaos LIKE '%" + loc_cCUsuarioEsc + "%'" + ;
                           " AND (Progs = 'CADUSU' OR Progs = 'CADGRU')" + ;
                           " ORDER BY Datars"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar dados do log por usu" + CHR(225) + "rio"
                    loc_lContinuar = .F.
                ENDIF

                *-- Enriquecer: para cada registro que referencia GRUPO,
                *   buscar registros de grupo nao presentes no cursor principal
                IF loc_lContinuar
                    SELECT cursor_4c_Dados
                    GO TOP
                    loc_nRegs = RECCOUNT()
                    loc_nI = 0
                    DO WHILE loc_nI < loc_nRegs
                        loc_nI = loc_nI + 1
                        SELECT cursor_4c_Dados
                        GO loc_nI
                        IF AT('GRUPO : ', UPPER(Transacaos)) > 0
                            loc_cGrupo    = ALLTRIM(SUBSTR(Transacaos, 9, 10))
                            loc_cGrupoEsc = STRTRAN(loc_cGrupo, "'", "''")
                            loc_cSQL = "SELECT * FROM SigOpLog" + ;
                                       " WHERE Transacaos LIKE '%" + loc_cGrupoEsc + "%'" + ;
                                       " AND Transacaos LIKE '%PROG :%'" + ;
                                       " AND Progs = 'CADGRU'" + ;
                                       " ORDER BY Datars"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruAux")
                            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruAux") > 0
                                SELECT * FROM cursor_4c_GruAux ;
                                    WHERE cIdChaves NOT IN ;
                                        (SELECT cIdChaves FROM cursor_4c_Dados) ;
                                    INTO CURSOR cursor_4c_Ins
                                IF RECCOUNT("cursor_4c_Ins") > 0
                                    loc_nRec = RECNO("cursor_4c_Dados")
                                    SELECT cursor_4c_Dados
                                    APPEND FROM DBF("cursor_4c_Ins")
                                    SELECT cursor_4c_Dados
                                    GO loc_nI
                                ENDIF
                                IF USED("cursor_4c_Ins")
                                    USE IN cursor_4c_Ins
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_GruAux")
                                USE IN cursor_4c_GruAux
                            ENDIF
                        ENDIF
                    ENDDO
                ENDIF
            ENDIF

            *-- Posicionar no inicio dos dados
            IF loc_lContinuar
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora (com dialogo de selecao)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) NOCONSOLE TO PRINTER PROMPT
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) NOCONSOLE PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Exporta relatorio para arquivo Excel
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = FORCEPATH("RelLogAcessos_" + ;
                               TRANSFORM(DATE(), "@YMD") + ".xls", ;
                               SYS(5) + CURDIR())
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    COPY TO (loc_cArquivo) TYPE XL5
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo exportado:" + CHR(13) + loc_cArquivo, "Excel")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + ;
                                              "o dispon" + CHR(237) + "vel"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ExportarExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores dos filtros a partir de um cursor
    *
    * Permite recuperar uma configuracao de filtros previamente salva (por
    * exemplo, um conjunto de filtros pre-definidos exibidos em historico de
    * relatorios). Mapeia colunas do cursor para as propriedades de filtro
    * deste BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                                      "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            IF !EOF() AND !BOF()
                IF TYPE("CUsuario") = "C"
                    THIS.this_cCUsuario = ALLTRIM(NVL(EVALUATE("CUsuario"), ""))
                ENDIF
                IF TYPE("DUsuario") = "C"
                    THIS.this_cDUsuario = ALLTRIM(NVL(EVALUATE("DUsuario"), ""))
                ENDIF
                IF TYPE("CGrupo") = "C"
                    THIS.this_cCGrupo = ALLTRIM(NVL(EVALUATE("CGrupo"), ""))
                ENDIF
                IF TYPE("DGrupo") = "C"
                    THIS.this_cDGrupo = ALLTRIM(NVL(EVALUATE("DGrupo"), ""))
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de filtros est" + CHR(225) + " vazio"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva. Caso seja invocado indevidamente pelo Form, o
    * chamador recebera feedback claro.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de inser" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir(), Visualizar() ou " + ;
                                  "ExportarExcel()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "Inserir")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva. Caso seja invocado indevidamente pelo Form, o
    * chamador recebera feedback claro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de atualiza" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir(), Visualizar() ou " + ;
                                  "ExportarExcel()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "Atualizar")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao da configuracao atual
    *
    * Como nao ha registro persistido, retorna concatenacao dos filtros
    * atualmente carregados (usado para auditoria/log de execucoes do
    * relatorio).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF !EMPTY(THIS.this_cCGrupo)
            loc_cChave = "GRUPO=" + ALLTRIM(THIS.this_cCGrupo)
        ENDIF
        IF !EMPTY(THIS.this_cCUsuario)
            IF !EMPTY(loc_cChave)
                loc_cChave = loc_cChave + "|"
            ENDIF
            loc_cChave = loc_cChave + "USUARIO=" + ALLTRIM(THIS.this_cCUsuario)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *
    * Reaproveita a estrutura padrao de auditoria do sistema para gravar
    * eventos de impressao/visualizacao do relatorio, possibilitando
    * rastreabilidade de quem consultou o Log de Acessos e com quais filtros.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            IF EMPTY(loc_cUsuario)
                loc_cUsuario = "SISTEMA"
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChavePrimaria, Observacao) " + ;
                       "VALUES (" + ;
                       FormatarDataSQL(DATETIME()) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL(NVL(par_cOperacao, "RELATORIO")) + ", " + ;
                       EscaparSQL("SigOpLog") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL("Relat" + CHR(243) + "rio do Log de Acessos") + ;
                       ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_EmpRaz")
            USE IN cursor_4c_EmpRaz
        ENDIF
        IF USED("cursor_4c_GruAux")
            USE IN cursor_4c_GruAux
        ENDIF
        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

