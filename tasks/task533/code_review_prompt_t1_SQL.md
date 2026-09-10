# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, CLASSES

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
  ControlSource = "crSigCdCss.nivels"
  ControlSource = "crSigCdCss.descrs"
  ControlSource = "crSigCdCss.classes"
  ControlSource = "crSigCdCss.opbalancos"
  ControlSource = "crSigCdCss.invemisccs"
select CrSigCdCss
	lcSql = [Select * From SigCdGcr Where Classes = ']+CrSigCdCss.Classes+[']
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'csClasses')
	Select csClasses
select CrSigCdCss

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormTCL.prg) - TRECHOS RELEVANTES PARA PASS SQL (1264 linhas total):

*-- Linhas 351 a 369:
351:             .HighlightBackColor = RGB(255, 255, 255)
352:             .HighlightForeColor = RGB(15, 41, 104)
353:             .HighlightStyle     = 2
354:             .DeleteMark         = .F.
355:             .RecordMark         = .F.
356:             .RowHeight          = 16
357:             .ScrollBars         = 2
358:             .GridLines          = 3
359:             .Visible            = .T.
360:         ENDWITH
361:         BINDEVENT(loc_oPg1.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
362: 
363:         THIS.TornarControlesVisiveis(loc_oPg1)
364:     ENDPROC
365: 
366:     *--------------------------------------------------------------------------
367:     * ConfigurarPaginaDados - Page2: faixa de cabecalho + container de botoes
368:     * de acao + primeiros 50% dos campos (Nivel, Classe, Descricao)
369:     * CLAUDE.md regra #11: a faixa deve ser o PRIMEIRO AddObject da pagina;

*-- Linhas 437 a 455:
437:         *-- Compensacao PageFrame.Top=-29: Top_migrado = Top_original + 29
438:         *-- ===================================================================
439: 
440:         *-- txt_4c_Nivel (Get_nivel: ControlSource=crSigCdCss.nivels, Top=175,
441:         *-- Left=448, Width=17, Height=25) - numeric(1,0), dominio [1,2,3]
442:         loc_oPg2.AddObject("txt_4c_Nivel", "TextBox")
443:         WITH loc_oPg2.txt_4c_Nivel
444:             .Top           = 204
445:             .Left          = 448
446:             .Width         = 17
447:             .Height        = 25
448:             .InputMask     = "9"
449:             .SpecialEffect = 1
450:             .BorderColor   = RGB(100, 100, 100)
451:             .ForeColor     = RGB(0, 0, 0)
452:             .FontName      = "Tahoma"
453:             .FontSize      = 8
454:             .Value         = 0
455:             .Visible       = .T.

*-- Linhas 483 a 501:
483:             .Visible   = .T.
484:         ENDWITH
485: 
486:         *-- txt_4c_Classe (Get_classe: ControlSource=crSigCdCss.classes, Top=202,
487:         *-- Left=448, Width=80, Height=25) - char(10), tamanho depende do nivel
488:         loc_oPg2.AddObject("txt_4c_Classe", "TextBox")
489:         WITH loc_oPg2.txt_4c_Classe
490:             .Top           = 231
491:             .Left          = 448
492:             .Width         = 80
493:             .Height        = 25
494:             .MaxLength     = 10
495:             .SpecialEffect = 1
496:             .BorderColor   = RGB(100, 100, 100)
497:             .ForeColor     = RGB(0, 0, 0)
498:             .FontName      = "Tahoma"
499:             .FontSize      = 8
500:             .Value         = ""
501:             .Visible       = .T.

*-- Linhas 515 a 533:
515:             .Visible   = .T.
516:         ENDWITH
517: 
518:         *-- txt_4c_Descr (Get_descr: ControlSource=crSigCdCss.descrs, Top=229,
519:         *-- Left=448, Width=220, Height=25) - char(30)
520:         loc_oPg2.AddObject("txt_4c_Descr", "TextBox")
521:         WITH loc_oPg2.txt_4c_Descr
522:             .Top           = 258
523:             .Left          = 448
524:             .Width         = 220
525:             .Height        = 25
526:             .MaxLength     = 30
527:             .SpecialEffect = 1
528:             .BorderColor   = RGB(100, 100, 100)
529:             .ForeColor     = RGB(0, 0, 0)
530:             .FontName      = "Tahoma"
531:             .FontSize      = 8
532:             .Value         = ""
533:             .Visible       = .T.

*-- Linhas 559 a 577:
559:         *-- referenciada via fwbuscaext/fwBuscaSel/sigacess)
560:         *-- ===================================================================
561: 
562:         *-- opt_4c_OpBalanco (optGreps: ControlSource=crSigCdCss.opbalancos,
563:         *-- Top=255, Left=442, Height=25) - "Incluir em Invent?rio" Sim(1)/Nao(2)
564:         loc_oPg2.AddObject("opt_4c_OpBalanco", "OptionGroup")
565:         WITH loc_oPg2.opt_4c_OpBalanco
566:             .ButtonCount = 2
567:             .Top         = 284
568:             .Left        = 442
569:             .Width       = 95
570:             .Height      = 25
571:             .BackStyle   = 0
572:             .BorderStyle = 0
573:             .Value       = 1
574:             .Visible     = .T.
575:         ENDWITH
576:         WITH loc_oPg2.opt_4c_OpBalanco.Buttons(1)
577:             .Caption   = "Sim"

*-- Linhas 610 a 628:
610:             .Visible   = .T.
611:         ENDWITH
612: 
613:         *-- opt_4c_InvEmisCc (Fwoption1: ControlSource=crSigCdCss.invemisccs,
614:         *-- Top=278, Left=442, Height=25) - "Trocar CC por Emissor" Sim(1)/Nao(2)
615:         loc_oPg2.AddObject("opt_4c_InvEmisCc", "OptionGroup")
616:         WITH loc_oPg2.opt_4c_InvEmisCc
617:             .ButtonCount = 2
618:             .Top         = 307
619:             .Left        = 442
620:             .Width       = 95
621:             .Height      = 25
622:             .BackStyle   = 0
623:             .BorderStyle = 0
624:             .Value       = 1
625:             .Visible     = .T.
626:         ENDWITH
627:         WITH loc_oPg2.opt_4c_InvEmisCc.Buttons(1)
628:             .Caption   = "Sim"

*-- Linhas 805 a 830:
805:                 ELSE
806:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
807: 
808:                     *-- RecordSource ANTES de ControlSource (ColumnCount FORA do WITH)
809:                     loc_oGrid.ColumnCount  = 3
810:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
811: 
812:                     *-- ControlSource APOS RecordSource (auto-bind seria sobrescrito)
813:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.classes"
814:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
815:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nivels"
816: 
817:                     loc_oGrid.Column1.Width = 100
818:                     loc_oGrid.Column2.Width = 319
819:                     loc_oGrid.Column3.Width = 83
820: 
821:                     *-- Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
822:                     loc_oGrid.Column1.Header1.Caption = "Classe"
823:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
824:                     loc_oGrid.Column3.Header1.Caption = "N" + CHR(237) + "vel"
825: 
826:                     THIS.FormatarGridLista(loc_oGrid)
827:                     loc_lResultado = .T.
828:                 ENDIF
829:             ENDIF
830: 

*-- Linhas 1037 a 1055:
1037:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1038:                 MsgAviso("Selecione uma classe para alterar!")
1039:             ELSE
1040:                 SELECT cursor_4c_Dados
1041:                 IF EOF()
1042:                     MsgAviso("Selecione uma classe para alterar!")
1043:                 ELSE
1044:                     loc_cClasse = ALLTRIM(cursor_4c_Dados.classes)
1045: 
1046:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cClasse)
1047:                         THIS.this_oBusinessObject.EditarRegistro()
1048:                         THIS.this_cModoAtual = "ALTERAR"
1049:                         THIS.BOParaForm()
1050:                         THIS.HabilitarCampos(.T.)
1051:                         THIS.AlternarPagina(2)
1052:                     ENDIF
1053:                 ENDIF
1054:             ENDIF
1055:         CATCH TO loc_oErro

*-- Linhas 1068 a 1086:
1068:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1069:                 MsgAviso("Selecione uma classe para visualizar!")
1070:             ELSE
1071:                 SELECT cursor_4c_Dados
1072:                 IF EOF()
1073:                     MsgAviso("Selecione uma classe para visualizar!")
1074:                 ELSE
1075:                     loc_cClasse = ALLTRIM(cursor_4c_Dados.classes)
1076: 
1077:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cClasse)
1078:                         THIS.this_cModoAtual = "VISUALIZAR"
1079:                         THIS.BOParaForm()
1080:                         THIS.HabilitarCampos(.F.)
1081:                         THIS.AlternarPagina(2)
1082:                     ENDIF
1083:                 ENDIF
1084:             ENDIF
1085:         CATCH TO loc_oErro
1086:             MsgErro(loc_oErro.Message, "FormTCL.BtnVisualizarClick")

*-- Linhas 1098 a 1116:
1098:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1099:                 MsgAviso("Selecione uma classe para excluir!")
1100:             ELSE
1101:                 SELECT cursor_4c_Dados
1102:                 IF EOF()
1103:                     MsgAviso("Selecione uma classe para excluir!")
1104:                 ELSE
1105:                     loc_cClasse = ALLTRIM(cursor_4c_Dados.classes)
1106: 
1107:                     IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da classe " + loc_cClasse + "?")
1108:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cClasse)
1109:                             THIS.this_cModoAtual = "EXCLUIR"
1110: 
1111:                             IF THIS.this_oBusinessObject.Excluir()
1112:                                 MsgInfo("Classe exclu" + CHR(237) + "da com sucesso!")
1113:                                 THIS.this_cModoAtual = "LISTA"
1114:                                 THIS.CarregarLista()
1115:                             ELSE
1116:                                 THIS.this_cModoAtual = "LISTA"

*-- Linhas 1140 a 1173:
1140:             IF EMPTY(loc_cClasse)
1141:                 loc_cFiltro = ""
1142:             ELSE
1143:                 loc_cFiltro = "classes LIKE " + EscaparSQL(loc_cClasse + "%") + ;
1144:                     " OR descrs LIKE " + EscaparSQL("%" + loc_cClasse + "%")
1145:             ENDIF
1146: 
1147:             IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1148:                 MsgErro("Erro ao buscar classes!", "FormTCL.BtnBuscarClick")
1149:             ELSE
1150:                 LOCAL loc_oGrid
1151:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1152: 
1153:                 loc_oGrid.ColumnCount  = 3
1154:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1155: 
1156:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.classes"
1157:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1158:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nivels"
1159: 
1160:                 loc_oGrid.Column1.Width = 100
1161:                 loc_oGrid.Column2.Width = 319
1162:                 loc_oGrid.Column3.Width = 83
1163: 
1164:                 loc_oGrid.Column1.Header1.Caption = "Classe"
1165:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1166:                 loc_oGrid.Column3.Header1.Caption = "N" + CHR(237) + "vel"
1167: 
1168:                 THIS.FormatarGridLista(loc_oGrid)
1169:             ENDIF
1170:         CATCH TO loc_oErro
1171:             MsgErro(loc_oErro.Message, "FormTCL.BtnBuscarClick")
1172:         ENDTRY
1173:     ENDPROC

*-- Linhas 1186 a 1204:
1186: 
1187:     *--------------------------------------------------------------------------
1188:     * BtnSalvarClick - Confirma inclusao/alteracao: valida, transfere Form->BO
1189:     * e persiste (Salvar() decide INSERT/UPDATE por this_lNovoRegistro)
1190:     * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
1191:     *--------------------------------------------------------------------------
1192:     PROCEDURE BtnSalvarClick()
1193:         TRY
1194:             THIS.FormParaBO()
1195: 
1196:             IF THIS.this_oBusinessObject.Salvar()
1197:                 MsgInfo("Classe salva com sucesso!")
1198:                 THIS.this_cModoAtual = "LISTA"
1199:                 THIS.AlternarPagina(1)
1200:             ENDIF
1201:         CATCH TO loc_oErro
1202:             MsgErro(loc_oErro.Message, "FormTCL.BtnSalvarClick")
1203:         ENDTRY
1204:     ENDPROC


### BO (C:\4c\projeto\app\classes\TCLBO.prg):
*====================================================================
* TCLBO.prg
*
* Business Object para Cadastro de Classes (SIGCDTCL)
* Tabela: SigCdCss
* Herda de: BusinessBase
*
* NOTA: o codigo fonte original (SIGCDTCL_form_codigo_fonte.txt) usa
* ThisForm.poDataMgr.AddCursor('SigCdCss','classes','crSigCdCss', ...)
* como cursor principal do form. O cursor 'crSigCdGcr' (SigCdGcr) e
* criado no Init original apenas como cursor auxiliar (nao possui
* nenhum controle vinculado no layout) e por isso NAO faz parte das
* propriedades desta entidade.
*====================================================================

DEFINE CLASS TCLBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdCss)
    this_cClasse    = ""    && classes    char(10) - PK
    this_cDescricao = ""    && descrs     char(30)
    this_cFf        = ""    && ff         char(10) - NOT NULL, sem controle no form original (grava SPACE(10))
    this_nNivel     = 0     && nivels     numeric(1,0) - dominio [1,2,3]
    this_nOpBalanco = 0     && opbalancos numeric(1,0) - OptionGroup optGreps  (1=Sim / 2=Nao) "Incluir em Inventario"
    this_nInvEmisCc = 0     && invemisccs numeric(1,0) - OptionGroup Fwoption1 (1=Sim / 2=Nao) "Trocar CC por Emissor"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCss"
            THIS.this_cCampoChave = "classes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TCLBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Valores default para novo registro
    * ff nao tem controle no form original: legado grava SPACE(10)
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cFf = SPACE(10)
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cClasse)
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
                THIS.this_cClasse    = TratarNulo(classes,    "C")
                THIS.this_cDescricao = TratarNulo(descrs,     "C")
                THIS.this_cFf        = TratarNulo(ff,         "C")
                THIS.this_nNivel     = TratarNulo(nivels,     "N")
                THIS.this_nOpBalanco = TratarNulo(opbalancos, "N")
                THIS.this_nInvEmisCc = TratarNulo(invemisccs, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TCLBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Regras extraidas do legado (SIGCDTCL.Pagina.Dados.Get_nivel.Valid
    * e SIGCDTCL.Click do Confirmar - ver comportamento.json)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nTamanhoEsperado, loc_cClasseSemEspacos
        loc_lValido = .T.

        *-- Get_nivel.Valid: nivel fora do dominio [1,2,3]
        IF !INLIST(THIS.this_nNivel, 1, 2, 3)
            MsgAviso("N" + CHR(237) + "vel Inv" + CHR(225) + "lido !!")
            loc_lValido = .F.
        ENDIF

        *-- Get_nivel.Valid: se nivel <> 1, forca "Incluir em Invent" + CHR(225) + "rio" = Sim (1)
        IF loc_lValido AND THIS.this_nNivel != 1
            THIS.this_nOpBalanco = 1
        ENDIF

        IF loc_lValido
            *-- Click Confirmar: tamanho da classe depende do nivel
            *-- nivel 1 -> substr('124',1,1)='1' (1 digito) | nivel 2 -> '2' (2 digitos) | nivel 3 -> '4' (4 digitos)
            loc_cClasseSemEspacos = STRTRAN(ALLTRIM(THIS.this_cClasse), " ", "")
            loc_nTamanhoEsperado  = VAL(SUBSTR("124", THIS.this_nNivel, 1))
            IF LEN(loc_cClasseSemEspacos) != loc_nTamanhoEsperado
                MsgAviso("Classe Inv" + CHR(225) + "lida !!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarClasseExistente(THIS.this_cClasse)
                MsgAviso("Classe j" + CHR(225) + " Cadastrada!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarClasseExistente - Verifica se classes ja existe no banco
    * Equivalente ao ChkRegister('SigCdCss','classes',...) do legado
    *====================================================================
    PROCEDURE VerificarClasseExistente(par_cClasse)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCss" + ;
                " WHERE classes = " + EscaparSQL(par_cClasse)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCla")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCla")
                SELECT cursor_4c_ChkCla
                loc_lExiste = (cursor_4c_ChkCla.qtd > 0)
                USE IN cursor_4c_ChkCla
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar classe:" + CHR(13) + loException.Message, "TCLBO.VerificarClasseExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdCss
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCss (classes, descrs, ff, nivels, opbalancos, invemisccs)
                VALUES (
                    <<EscaparSQL(THIS.this_cClasse)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cFf)>>,
                    <<FormatarNumeroSQL(THIS.this_nNivel, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpBalanco, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nInvEmisCc, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TCLBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdCss
    * classes eh chave primaria - nao entra no SET
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCss
                SET descrs     = <<EscaparSQL(THIS.this_cDescricao)>>,
                    ff         = <<EscaparSQL(THIS.this_cFf)>>,
                    nivels     = <<FormatarNumeroSQL(THIS.this_nNivel, 0)>>,
                    opbalancos = <<FormatarNumeroSQL(THIS.this_nOpBalanco, 0)>>,
                    invemisccs = <<FormatarNumeroSQL(THIS.this_nInvEmisCc, 0)>>
                WHERE classes = <<EscaparSQL(THIS.this_cClasse)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TCLBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdCss
    * Sem verificacao de dependencia no legado (framework generico)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCss WHERE classes = " + EscaparSQL(THIS.this_cClasse)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TCLBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com classes, descrs, nivels (colunas da
    * grade original: pColuna('classes'...), pColuna('descrs'...),
    * pColuna('nivels'...))
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (classes C(10), descrs C(30), nivels N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT classes, descrs, nivels FROM SigCdCss"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY classes"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar classes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TCLBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (classes)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cClasse)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT classes, descrs, ff, nivels, opbalancos, invemisccs" + ;
                " FROM SigCdCss WHERE classes = " + EscaparSQL(par_cClasse)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Classe n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TCLBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

