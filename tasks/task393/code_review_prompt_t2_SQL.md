# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NEMPS, EMPS, DTINI, DTFIN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NEMPS, EMPS, DTINI, DTFIN

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
  ControlSource = "CrSigCdDes.valdes"
  ControlSource = "CrSigCdDes.dtfin"
  ControlSource = "CrSigCdDes.dtini"
  ControlSource = "CrSigCdDes.emps"
  ControlSource = "CrSigCdDes.codigo"
SELECT crSigCdDes
Select * from xlResults Into Cursor localCota ReadWrite 
SELECT localCota
Select Localcota
		lcQuery = 	[Select * From SigcdEmp where nemps = ]+lcEmp+[ ]
		If ThisForm.Podatamgr.Sqlexecute(lcQuery,'localEmp') < 1
		lcQuery = 	[Select * From SigcdDes where emps = ']+lcEmp+[' and dtini = ?ldIni and dtFin = ?ldFin]
		If ThisForm.Podatamgr.Sqlexecute(lcQuery,'crAux') < 1
		Insert Into crSigcdDes (codigo, Emps, dtini, dtfin, valmeta, valcota, valcotac,valdes, dtalts);
	Select LocalCota
If Not ThisForm.poDataMgr.Update([crSigcdDes])
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigcddes)])
	lcQuery = 	[Select * From SigCdDes where emps = ']+CrSigCdDes.emps+[' and ']+lcDat+[' ]+;
	If ThisForm.Podatamgr.Sqlexecute(lcQuery,'crAux1') < 1
	lcQuery = 	[Select * From SigCdDes where emps = ']+CrSigCdDes.emps+[' and ']+lcDat+[' ]+;
	If ThisForm.Podatamgr.Sqlexecute(lcQuery,'crAux2') < 1

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormDES.prg) - TRECHOS RELEVANTES PARA PASS SQL (1500 linhas total):

*-- Linhas 367 a 385:
367:             .HighlightBackColor = RGB(255, 255, 255)
368:             .HighlightForeColor = RGB(15, 41, 104)
369:             .HighlightStyle     = 2
370:             .DeleteMark         = .F.
371:             .RecordMark         = .F.
372:             .RowHeight          = 16
373:             .ScrollBars         = 2
374:             .GridLines          = 3
375:             .ReadOnly           = .T.
376:             .Visible            = .T.
377:         ENDWITH
378: 
379:         *-- Larguras das colunas (captions definidos em CarregarLista apos RecordSource)
380:         loc_oPagina.grd_4c_Lista.Column1.Width = 100
381:         loc_oPagina.grd_4c_Lista.Column2.Width = 75
382:         loc_oPagina.grd_4c_Lista.Column3.Width = 75
383:         loc_oPagina.grd_4c_Lista.Column4.Width = 75
384:         loc_oPagina.grd_4c_Lista.Column5.Width = 100
385:         loc_oPagina.grd_4c_Lista.Column6.Width = 100

*-- Linhas 820 a 840:
820:         ENDIF
821: 
822:         TRY
823:             loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
824:                        " WHERE Cemps = " + EscaparSQL(loc_cEmps)
825:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaEmp")
826: 
827:             IF loc_nRes > 0 AND USED("cursor_4c_ValidaEmp")
828:                 IF RECCOUNT("cursor_4c_ValidaEmp") = 0
829:                     MsgAviso("Empresa '" + loc_cEmps + "' n" + CHR(227) + "o encontrada.", "")
830:                     loc_oPg2.txt_4c_Emps.Value = ""
831:                     loc_oPg2.txt_4c_Emps.SetFocus()
832:                 ENDIF
833:                 USE IN cursor_4c_ValidaEmp
834:             ENDIF
835:         CATCH TO loException
836:             MsgErro("Erro em ValidarEmps:" + CHR(13) + loException.Message, "Erro")
837:             IF USED("cursor_4c_ValidaEmp")
838:                 USE IN cursor_4c_ValidaEmp
839:             ENDIF
840:         ENDTRY

*-- Linhas 868 a 894:
868: 
869:                     loc_oGrid.RecordSource = "crSigCdDes"
870: 
871:                     *-- ControlSources APOS RecordSource (previne auto-bind sobrescrever)
872:                     loc_oGrid.Column1.ControlSource = "crSigCdDes.codigo"
873:                     loc_oGrid.Column2.ControlSource = "crSigCdDes.emps"
874:                     loc_oGrid.Column3.ControlSource = "crSigCdDes.dtini"
875:                     loc_oGrid.Column4.ControlSource = "crSigCdDes.dtfin"
876:                     loc_oGrid.Column5.ControlSource = "crSigCdDes.valmeta"
877:                     loc_oGrid.Column6.ControlSource = "crSigCdDes.valdes"
878: 
879:                     *-- Captions APOS ControlSource (RecordSource reseta os captions)
880:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
881:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
882:                     loc_oGrid.Column3.Header1.Caption = "Dt Inicio"
883:                     loc_oGrid.Column4.Header1.Caption = "Dt final"
884:                     loc_oGrid.Column5.Header1.Caption = "Vr Meta"
885:                     loc_oGrid.Column6.Header1.Caption = "Vr Desconto"
886: 
887:                     THIS.FormatarGridLista(loc_oGrid)
888:                 ENDIF
889:                 loc_lResultado = .T.
890:             ENDIF
891:         CATCH TO loException
892:             MsgErro("Erro em CarregarLista:" + CHR(13) + loException.Message, "Erro")
893:             loc_lResultado = .F.
894:         ENDTRY

*-- Linhas 1007 a 1025:
1007:             RETURN
1008:         ENDIF
1009: 
1010:         SELECT crSigCdDes
1011:         loc_cCodigo = ALLTRIM(crSigCdDes.codigo)
1012: 
1013:         IF EMPTY(loc_cCodigo)
1014:             MsgAviso("Nenhum registro selecionado.", "")
1015:             RETURN
1016:         ENDIF
1017: 
1018:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1019:             THIS.this_cModoAtual = "VISUALIZAR"
1020:             THIS.BOParaForm()
1021:             THIS.HabilitarCampos(.F.)
1022:             THIS.AjustarBotoesPorModo()
1023:             THIS.AlternarPagina(2)
1024: 
1025:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)

*-- Linhas 1041 a 1059:
1041:             RETURN
1042:         ENDIF
1043: 
1044:         SELECT crSigCdDes
1045:         loc_cCodigo = ALLTRIM(crSigCdDes.codigo)
1046: 
1047:         IF EMPTY(loc_cCodigo)
1048:             MsgAviso("Nenhum registro selecionado.", "")
1049:             RETURN
1050:         ENDIF
1051: 
1052:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1053:             THIS.this_oBusinessObject.EditarRegistro()
1054:             THIS.this_cModoAtual = "ALTERAR"
1055:             THIS.BOParaForm()
1056:             THIS.HabilitarCampos(.T.)
1057:             THIS.AjustarBotoesPorModo()
1058:             THIS.AlternarPagina(2)
1059: 

*-- Linhas 1077 a 1095:
1077:             RETURN
1078:         ENDIF
1079: 
1080:         SELECT crSigCdDes
1081:         loc_cCodigo = ALLTRIM(crSigCdDes.codigo)
1082: 
1083:         IF EMPTY(loc_cCodigo)
1084:             MsgAviso("Nenhum registro selecionado.", "")
1085:             RETURN
1086:         ENDIF
1087: 
1088:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1089:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?" + ;
1090:                 CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo, ;
1091:                 "Excluir")
1092: 
1093:             IF loc_lConfirma
1094:                 IF THIS.this_oBusinessObject.Excluir()
1095:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")

*-- Linhas 1118 a 1136:
1118:                 loc_oBusca.Show()
1119: 
1120:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1121:                     SELECT cursor_4c_BuscaEmp
1122:                     loc_cEmps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1123:                 ENDIF
1124: 
1125:                 loc_oBusca.Release()
1126:             ENDIF
1127: 
1128:             IF USED("cursor_4c_BuscaEmp")
1129:                 USE IN cursor_4c_BuscaEmp
1130:             ENDIF
1131: 
1132:             THIS.this_cFiltroEmps = loc_cEmps
1133:             THIS.CarregarLista()
1134:         CATCH TO loException
1135:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
1136:             IF USED("cursor_4c_BuscaEmp")

*-- Linhas 1156 a 1174:
1156: 
1157:     *==========================================================================
1158:     * BtnConfirmarClick - Salvar registro (chama Inserir ou Atualizar via BO)
1159:     * Legado: fSalvar em Salva.Click - valida campos, faz INSERT/UPDATE e volta lista
1160:     *==========================================================================
1161:     PROCEDURE BtnConfirmarClick()
1162:         TRY
1163:             IF THIS.this_cModoAtual = "VISUALIZAR"
1164:                 THIS.AlternarPagina(1)
1165:                 THIS.this_cModoAtual = "LISTA"
1166:             ELSE
1167:                 IF THIS.FormParaBO()
1168:                     IF THIS.this_oBusinessObject.Salvar()
1169:                         MsgInfo("Registro salvo com sucesso!", "")
1170:                         THIS.this_cModoAtual = "LISTA"
1171:                         THIS.AlternarPagina(1)
1172:                     ENDIF
1173:                 ENDIF
1174:             ENDIF

*-- Linhas 1446 a 1464:
1446:                 MsgAviso("Planilha vazia ou formato inv" + CHR(225) + "lido.", "Aviso")
1447:                 loc_lResultado = .F.
1448:             ELSE
1449:                 SELECT xlResults
1450:                 GO TOP
1451: 
1452:                 SCAN
1453:                     *-- Coluna 1: empresa (numerico)
1454:                     loc_lcField = FIELD(1)
1455:                     loc_lcEmp = ALLTRIM(STR(IIF(INLIST(VARTYPE(&loc_lcField), "N"), &loc_lcField, 0)))
1456: 
1457:                     *-- Coluna 2: periodo YYMM (caracter, ex: "2601" = jan/2026)
1458:                     loc_lcField = FIELD(2)
1459:                     loc_lcMes = PADL(ALLTRIM(IIF(INLIST(VARTYPE(&loc_lcField), "C", "M"), &loc_lcField, "")), 6, "0")
1460: 
1461:                     *-- Coluna 3: valor da cota
1462:                     loc_lcField = FIELD(3)
1463:                     loc_lnCota = IIF(INLIST(VARTYPE(&loc_lcField), "N"), &loc_lcField, 0)
1464: 


### BO (C:\4c\projeto\app\classes\DESBO.prg):
*==============================================================================
* DESBO.prg - Business Object para Cadastro de Cotas de Desconto por Periodo
* Tabela : sigcddes
* Herda de: BusinessBase
* Fase 1 : Propriedades e Init
*==============================================================================

DEFINE CLASS DESBO AS BusinessBase

    *-- Propriedades da tabela sigcddes
    this_cCodigo   = ""    && codigo   char(10) PK (auto-gerado no Inserir)
    this_cEmps     = ""    && emps     char(3)
    this_dDtini    = {}    && dtini    datetime
    this_dDtfin    = {}    && dtfin    datetime
    this_nValmeta  = 0     && valmeta  numeric(11,2)
    this_nValcota  = 0     && valcota  numeric(11,2) cota desconto R$
    this_nValcotac = 0     && valcotac numeric(11,2) cota (outra moeda)
    this_nValdes   = 0     && valdes   numeric(11,2) desconto aplicado R$ (readonly)
    this_cUsualts  = ""    && usualts  char(10)
    this_dDtalts   = {}    && dtalts   datetime

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcddes"
        THIS.this_cCampoChave = "codigo"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = TratarNulo(codigo,   "C")
            THIS.this_cEmps     = TratarNulo(emps,     "C")
            THIS.this_dDtini    = TratarNulo(dtini,    "T")
            THIS.this_dDtfin    = TratarNulo(dtfin,    "T")
            THIS.this_nValmeta  = TratarNulo(valmeta,  "N")
            THIS.this_nValcota  = TratarNulo(valcota,  "N")
            THIS.this_nValcotac = TratarNulo(valcotac, "N")
            THIS.this_nValdes   = TratarNulo(valdes,   "N")
            THIS.this_cUsualts  = TratarNulo(usualts,  "C")
            THIS.this_dDtalts   = TratarNulo(dtalts,   "T")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * GerarCodigo - Gera codigo unico: emps(3) + YYMM(4) + seq(3) = 10 chars
    *==========================================================================
    PROTECTED FUNCTION GerarCodigo()
        LOCAL loc_cPrefixo, loc_cSQL, loc_nSeq, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_cPrefixo = ALLTRIM(THIS.this_cEmps) + ;
                SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + ;
                PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")

            loc_cSQL = "SELECT COUNT(*) AS cnt FROM sigcddes WHERE codigo LIKE '" + ;
                loc_cPrefixo + "%'"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_nSeq = cursor_4c_GerarCod.cnt + 1
                loc_cCodigo = loc_cPrefixo + PADL(ALLTRIM(STR(loc_nSeq)), 3, "0")
            ENDIF

            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao gerar c" + CHR(243) + "digo")
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *==========================================================================
    * ValidarSobreposicaoPeriodo - Verifica sobreposicao de periodo por empresa
    * par_cCodigoExcluir: codigo a excluir da verificacao (para Atualizar)
    *==========================================================================
    PROTECTED FUNCTION ValidarSobreposicaoPeriodo(par_cEmps, par_dIni, par_dFin, par_cCodigoExcluir)
        LOCAL loc_cSQL, loc_cFiltroExcluir, loc_lSobrepoe
        loc_lSobrepoe = .F.

        TRY
            loc_cFiltroExcluir = ""
            IF !EMPTY(ALLTRIM(par_cCodigoExcluir))
                loc_cFiltroExcluir = " AND codigo <> " + EscaparSQL(par_cCodigoExcluir)
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS cnt FROM sigcddes" + ;
                " WHERE emps = " + EscaparSQL(par_cEmps) + ;
                " AND CONVERT(DATE, dtini) <= CONVERT(DATE, " + FormatarDataSQL(par_dFin) + ")" + ;
                " AND CONVERT(DATE, dtfin) >= CONVERT(DATE, " + FormatarDataSQL(par_dIni) + ")" + ;
                loc_cFiltroExcluir

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sobrepoe") > 0
                SELECT cursor_4c_Sobrepoe
                loc_lSobrepoe = (cursor_4c_Sobrepoe.cnt > 0)
            ENDIF

            IF USED("cursor_4c_Sobrepoe")
                USE IN cursor_4c_Sobrepoe
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao validar per" + CHR(237) + "odo")
            IF USED("cursor_4c_Sobrepoe")
                USE IN cursor_4c_Sobrepoe
            ENDIF
        ENDTRY

        RETURN loc_lSobrepoe
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios e regras de negocio
    * par_lNovoRegistro: .T. = Inserir, .F. = Atualizar
    *==========================================================================
    PROTECTED FUNCTION ValidarDados(par_lNovoRegistro)
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("Empresa n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtini)
            MsgAviso("Data Inicial n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtfin)
            MsgAviso("Data final n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_dDtini > THIS.this_dDtfin
            MsgAviso("As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        LOCAL loc_cCodigoExcluir
        loc_cCodigoExcluir = IIF(par_lNovoRegistro, "", THIS.this_cCodigo)

        IF THIS.ValidarSobreposicaoPeriodo(THIS.this_cEmps, THIS.this_dDtini, THIS.this_dDtfin, loc_cCodigoExcluir)
            MsgAviso("Esse intervalo j" + CHR(225) + " est" + CHR(225) + " cadastrado para essa empresa!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em sigcddes
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodigo
        loc_lSucesso = .F.

        IF !THIS.ValidarDados(.T.)
            RETURN .F.
        ENDIF

        TRY
            loc_cCodigo = THIS.GerarCodigo()
            IF EMPTY(loc_cCodigo)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar c" + CHR(243) + "digo.", "Erro")
            ELSE
                THIS.this_cCodigo  = loc_cCodigo
                THIS.this_cUsualts = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

                loc_cSQL = "INSERT INTO sigcddes" + ;
                    " (codigo, emps, dtini, dtfin, valmeta, valcota, valcotac, valdes, usualts, dtalts)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCodigo)          + ", " + ;
                    EscaparSQL(THIS.this_cEmps)            + ", " + ;
                    FormatarDataSQL(THIS.this_dDtini)      + ", " + ;
                    FormatarDataSQL(THIS.this_dDtfin)      + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValmeta)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValcota)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValcotac) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValdes)   + ", " + ;
                    EscaparSQL(THIS.this_cUsualts)         + ", " + ;
                    "GETDATE())"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em sigcddes
    * Nota: emps/dtini/dtfin NAO editaveis apos criacao (When=INSERIR only)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF !THIS.ValidarDados(.F.)
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cUsualts = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE sigcddes SET" + ;
                " valmeta  = " + FormatarNumeroSQL(THIS.this_nValmeta)  + "," + ;
                " valcota  = " + FormatarNumeroSQL(THIS.this_nValcota)  + "," + ;
                " valcotac = " + FormatarNumeroSQL(THIS.this_nValcotac) + "," + ;
                " usualts  = " + EscaparSQL(THIS.this_cUsualts) + "," + ;
                " dtalts   = GETDATE()" + ;
                " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE de sigcddes (chamado por BusinessBase.Excluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_nValdes > 0
            MsgAviso("Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida. Cota j" + CHR(225) + " utilizada!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM sigcddes WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao excluir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT para grid (cursor crSigCdDes)
    * par_cFiltro: codigo de empresa para filtrar (vazio = todos)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE emps = " + EscaparSQL(ALLTRIM(par_cFiltro))
            ENDIF

            loc_cSQL = "SELECT codigo, emps, dtini, dtfin, valmeta, valcota, valdes, usualts, dtalts" + ;
                " FROM sigcddes" + loc_cWhere + ;
                " ORDER BY emps, dtini"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdDes") >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - SELECT por chave primaria
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, emps, dtini, dtfin, valmeta, valcota, valcotac, valdes, usualts, dtalts" + ;
                " FROM sigcddes WHERE codigo = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado.", "")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao carregar")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

