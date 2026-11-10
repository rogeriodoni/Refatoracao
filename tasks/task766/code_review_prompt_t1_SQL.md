# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: J, I, CEMPS, EMPS, DATAS

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
  ControlSource = "CrSigCdDes.valmeta"
  ControlSource = "CrSigCdDes.valcota"
  ControlSource = ""
  ControlSource = "CrSigCdDes.dtini"
  ControlSource = "CrSigCdDes.dtfin"
  ControlSource = "CrSigCdDes.valdes"
  ControlSource = "CrSigCdDes.emps"
  ControlSource = "CrSigCdDes.codigo"
Select * From xlResults Into Cursor localMeta Readwrite
Select localMeta
Select * From xlResults Into Cursor localMetaD Readwrite
Select crSigopMet
Select localMeta
	lcQuery = 	[Select * From SigcdEmp where cemps = ']+lcEmp+[' ]
	If Thisform.Podatamgr.Sqlexecute(lcQuery,'localEmp') < 1
		Select localMeta
				lcQuery = 	[Select * From SigopMet where emps = ']+lcEmp+[' and datas = ?ldDataD]
				If Thisform.Podatamgr.Sqlexecute(lcQuery,'crAux') < 1
				Select localMetaD
				Insert Into crSigopMet (ufs, Emps, codemps, nomeloja, DataS, valmeta, valmetad, codigo, usualts, dtalts);
	Select localMeta
If Not Thisform.Podatamgr.Update([crSigOpMet])
	=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPrNfe)])

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigOpMet.prg) - TRECHOS RELEVANTES PARA PASS SQL (1296 linhas total):

*-- Linhas 363 a 381:
363:             .HighlightBackColor = RGB(255, 255, 255)
364:             .HighlightForeColor = RGB(15, 41, 104)
365:             .HighlightStyle     = 2
366:             .DeleteMark         = .F.
367:             .RecordMark         = .F.
368:             .RowHeight          = 16
369:             .ScrollBars         = 2
370:             .GridLines          = 3
371:             .ReadOnly           = .T.
372:             .Visible            = .T.
373:         ENDWITH
374: 
375:         *-- ColumnCount FORA do WITH para criar colunas imediatamente (Problema 36)
376:         loc_oPagina.grd_4c_Lista.ColumnCount = 9
377: 
378:         *-- Colunas espelham o pColuna do Init legado (regra #35b), nao o
379:         *-- header desenhado no SCX: Codigo, Estado, Loja, Nome da Loja, Data,
380:         *-- Vr Meta, Desafio, Usuario, Alteracao
381:         WITH loc_oPagina.grd_4c_Lista

*-- Linhas 427 a 460:
427:     * com Width explicita que termina rente ao campo (CLAUDE.md regra #23).
428:     *
429:     * ATENCAO (divergencia HERDADA do legado - nao e' erro de migracao):
430:     * TODOS os controles desta pagina no SCX apontam ControlSource para o
431:     * cursor CrSigCdDes (tabela SigCdDes), que o Init do legado NUNCA cria -
432:     * ele so faz AddCursor('SigOpMet',...) para a grade da Lista. Logo:
433:     *   - Codigo (char 10) e Empresa (char 3) existem nas DUAS tabelas e
434:     *     casam com SigOpMetBO.this_cCodigo / this_cEmps;
435:     *   - Data Inicial/Final (dtini/dtfin), Meta de Vendas (valmeta), Cota
436:     *     Desconto $ (valcota) e Desconto Aplicado $ (valdes) existem SO em
437:     *     SigCdDes - "valmeta" ali e' column DIFERENTE de SigOpMet.valmeta
438:     *     (this_nValMeta), mera coincidencia de nome entre tabelas distintas
439:     *     (schema conferido em docs/schema.sql: SigCdDes NAO tem FK para
440:     *     SigOpMet). getpdes (Cota Desconto %) tem ControlSource = "" no
441:     *     dump - nem SigCdDes tem coluna "pdes".
442:     * Os controles sao reproduzidos por fidelidade visual, mas NAO devem
443:     * inventar property no BO nem coluna no INSERT/UPDATE para
444:     * dtini/dtfin/valmeta(Dados)/valcota/valdes/pdes - isso violaria o
445:     * PILAR 2. Nao usar ControlSource: a transferencia e' feita por
446:     * FormParaBO/BOParaForm (que tocam apenas Codigo/Empresa).
447:     *===========================================================================
448:     PROTECTED PROCEDURE ConfigurarPaginaDados()
449:         LOCAL loc_oPagina
450:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
451: 
452:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
453: 
454:         *-- Container Cabecalho (faixa tambem na pagina Dados - regra #11) - PRIMEIRO AddObject
455:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
456:         WITH loc_oPagina.cnt_4c_Cabecalho
457:             .Top         = 31
458:             .Left        = 0
459:             .Width       = THIS.Width
460:             .Height      = 80

*-- Linhas 861 a 879:
861:         ENDWITH
862: 
863:         *----------------------------------------------------------------------
864:         * CAMPO 8 (TabIndex 8): Cota Desconto % - getpdes.ControlSource = ""
865:         *   no dump (NEM CrSigCdDes tem coluna "pdes" - campo totalmente
866:         *   orfao, mais fiel ainda ao caso do cabecalho do metodo)
867:         *   Say4:   left=393, top=343 -> 372   Caption "Cota Desconto % : "
868:         *   getpdes: left=492, top=338 -> 367, width=126, height=24
869:         *            Alignment=3, InputMask "999.99"
870:         *----------------------------------------------------------------------
871:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
872:         WITH loc_oPagina.lbl_4c_Label4
873:             .Caption   = "Cota Desconto % : "
874:             .Top       = 372
875:             .Left      = 393
876:             .Width     = 99
877:             .Height    = 17
878:             .FontName  = "Tahoma"
879:             .FontSize  = 8

*-- Linhas 987 a 1013:
987:             IF THIS.this_oBusinessObject.Buscar("")
988:                 loc_oGrid.ColumnCount = 9
989:                 loc_oGrid.RecordSource          = "cursor_4c_Dados"
990:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigo"
991:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ufs"
992:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.emps"
993:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.nomeloja"
994:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.datas"
995:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.valmeta"
996:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.valmetad"
997:                 loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.usualts"
998:                 loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.dtalts"
999: 
1000:                 *-- Reconfigurar headers e larguras APOS RecordSource (reseta captions/Width)
1001:                 loc_oGrid.Column1.Header1.Caption = "Codigo"
1002:                 loc_oGrid.Column2.Header1.Caption = "Estado"
1003:                 loc_oGrid.Column3.Header1.Caption = "Loja"
1004:                 loc_oGrid.Column4.Header1.Caption = "Nome da Loja"
1005:                 loc_oGrid.Column5.Header1.Caption = "Data"
1006:                 loc_oGrid.Column6.Header1.Caption = "Vr Meta"
1007:                 loc_oGrid.Column7.Header1.Caption = "Desafio"
1008:                 loc_oGrid.Column8.Header1.Caption = "Usu" + CHR(225) + "rio"
1009:                 loc_oGrid.Column9.Header1.Caption = "Alteracao"
1010: 
1011:                 loc_oGrid.Column1.Width = 100
1012:                 loc_oGrid.Column2.Width = 75
1013:                 loc_oGrid.Column3.Width = 75

*-- Linhas 1054 a 1072:
1054:         loc_cCodigo = ""
1055: 
1056:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1057:             SELECT cursor_4c_Dados
1058:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1059:         ENDIF
1060: 
1061:         IF EMPTY(loc_cCodigo)
1062:             MsgAviso("Selecione uma meta para visualizar.")
1063:         ELSE
1064:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1065:                 THIS.this_cModoAtual = "VISUALIZAR"
1066:                 THIS.BOParaForm()
1067:                 THIS.HabilitarCampos(.F.)
1068:                 THIS.AjustarBotoesPorModo()
1069:                 THIS.AlternarPagina(2)
1070:             ENDIF
1071:         ENDIF
1072:     ENDPROC

*-- Linhas 1080 a 1098:
1080:         loc_cCodigo = ""
1081: 
1082:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1083:             SELECT cursor_4c_Dados
1084:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1085:         ENDIF
1086: 
1087:         IF EMPTY(loc_cCodigo)
1088:             MsgAviso("Selecione uma meta para alterar.")
1089:         ELSE
1090:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1091:                 THIS.this_oBusinessObject.EditarRegistro()
1092:                 THIS.this_cModoAtual = "ALTERAR"
1093:                 THIS.BOParaForm()
1094:                 THIS.HabilitarCampos(.T.)
1095:                 THIS.AjustarBotoesPorModo()
1096:                 THIS.AlternarPagina(2)
1097:             ENDIF
1098:         ENDIF

*-- Linhas 1107 a 1125:
1107:         loc_cCodigo = ""
1108: 
1109:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1110:             SELECT cursor_4c_Dados
1111:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1112:         ENDIF
1113: 
1114:         IF EMPTY(loc_cCodigo)
1115:             MsgAviso("Selecione uma meta para excluir.")
1116:         ELSE
1117:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1118:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da meta [" + loc_cCodigo + "]?", ;
1119:                     "Confirmar Exclus" + CHR(227) + "o")
1120:                     IF THIS.this_oBusinessObject.Excluir()
1121:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1122:                         THIS.CarregarLista()
1123:                     ENDIF
1124:                 ENDIF
1125:             ENDIF

*-- Linhas 1147 a 1165:
1147: 
1148:     *===========================================================================
1149:     * BtnSalvarClick - Valida e grava a meta (Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar)
1150:     * Salvar() SEM parametro (BusinessBase decide INSERT/UPDATE via
1151:     * this_lNovoRegistro, setado por NovoRegistro()/EditarRegistro()).
1152:     * Regra #20: sem ELSE generico - BusinessBase.Salvar() ja chama
1153:     * ExibirFalha() em todo caminho que falha; so complementar quando
1154:     * this_lErroExibido continuar .F.
1155:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
1156:     *===========================================================================
1157:     PROCEDURE BtnSalvarClick()
1158:         LOCAL loc_oPg
1159: 
1160:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1161: 
1162:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Codigo.Value))
1163:             MsgAviso("Informe o c" + CHR(243) + "digo da meta!")
1164:         ELSE
1165:             IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Emps.Value))


### BO (C:\4c\projeto\app\classes\SigOpMetBO.prg):
*====================================================================
* SigOpMetBO.prg
*
* Business Object para Cadastro de Metas por Loja
* Tabela: SigOpMet
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpMetBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigOpMet)
    this_cCodigo    = ""    && codigo   char(10)    - PK
    this_cUfs       = ""    && ufs      char(2)
    this_cEmps      = ""    && emps     char(3)
    this_nCodEmps   = 0     && codemps  numeric(4,0)
    this_cNomeLoja  = ""    && nomeloja char(40)
    this_dDatas     = {}    && datas    datetime
    this_nValMeta   = 0     && valmeta  numeric(10,2)
    this_nValMetaD  = 0     && valmetad numeric(10,2)
    this_cUsuAlts   = ""    && usualts  char(10)
    this_dDtAlts    = {}    && dtalts   datetime

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpMet"
            THIS.this_cCampoChave = "codigo"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo       = TratarNulo(codigo,   "")
                THIS.this_cUfs          = TratarNulo(ufs,      "")
                THIS.this_cEmps         = TratarNulo(emps,     "")
                THIS.this_nCodEmps      = TratarNulo(codemps,  0)
                THIS.this_cNomeLoja     = TratarNulo(nomeloja, "")
                THIS.this_dDatas        = TratarNulo(datas,    {})
                THIS.this_nValMeta      = TratarNulo(valmeta,  0)
                THIS.this_nValMetaD     = TratarNulo(valmetad, 0)
                THIS.this_cUsuAlts      = TratarNulo(usualts,  "")
                THIS.this_dDtAlts       = TratarNulo(dtalts,   {})
                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigOpMet
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsuAlts = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_dDtAlts  = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpMet (codigo, ufs, emps, codemps, nomeloja, datas, valmeta, valmetad, usualts, dtalts)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cUfs)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodEmps, 0)>>,
                    <<EscaparSQL(THIS.this_cNomeLoja)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<FormatarNumeroSQL(THIS.this_nValMeta, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValMetaD, 2)>>,
                    <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    <<FormatarDataSQL(THIS.this_dDtAlts)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir meta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigOpMet
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsuAlts = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_dDtAlts  = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpMet
                SET ufs      = <<EscaparSQL(THIS.this_cUfs)>>,
                    emps     = <<EscaparSQL(THIS.this_cEmps)>>,
                    codemps  = <<FormatarNumeroSQL(THIS.this_nCodEmps, 0)>>,
                    nomeloja = <<EscaparSQL(THIS.this_cNomeLoja)>>,
                    datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    valmeta  = <<FormatarNumeroSQL(THIS.this_nValMeta, 2)>>,
                    valmetad = <<FormatarNumeroSQL(THIS.this_nValMetaD, 2)>>,
                    usualts  = <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    dtalts   = <<FormatarDataSQL(THIS.this_dDtAlts)>>
                WHERE codigo = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar meta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigOpMet
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpMet WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir meta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com as colunas da grade da Lista (pColuna do
    * Init legado): codigo, ufs, emps, nomeloja, datas, valmeta, valmetad,
    * usualts, dtalts. codemps entra tambem (usado pelo lookup de loja).
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigo C(10), ufs C(2), emps C(3), codemps N(4,0), nomeloja C(40), datas T, valmeta N(10,2), valmetad N(10,2), usualts C(10), dtalts T)
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigo, ufs, emps, codemps, nomeloja, datas," + ;
                    " valmeta, valmetad, usualts, dtalts FROM SigOpMet"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigo"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar metas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigo)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, ufs, emps, codemps, nomeloja, datas, valmeta, valmetad, usualts, dtalts" + ;
                " FROM SigOpMet WHERE codigo = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Meta n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar meta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SigOpMetBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

