# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS

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
  ControlSource = "crSigFiChc.Ctr"
  ControlSource = "crSigFiChc.Rde"
  ControlSource = "crSigFiChc.RdeLja"
  ControlSource = "crSigFiChc.Logon"
  ControlSource = "crSigFiChc.Senha"
  ControlSource = "crSigFiChc.Emps"
  ControlSource = "crSigFiChc.VlrMin"
  ControlSource = "crSigFiChc.Razas"
  ControlSource = "crSigFiChc.VlrFixo"
  ControlSource = "crSigFiChc.Tipos"
  ControlSource = "crSigFiChc.cipchps"
  ControlSource = "crSigFiChc.nPortachps"
  ControlSource = "crSigFiChc.cTipos"
  ControlSource = "crSigFiChc.cUsuProxys"
  ControlSource = "crSigFiChc.cSenProxys"
SqlChec = [Select a.*, b.Razas From SigFiChc a Inner Join SigCdEmp b on a.Emps = b.cEmps]
		SqlChec = [Select * From SigFiChc Where Emps = ']+ThisForm.Pagina.Dados.GetEmpresa.Value+[' ]+;
    	ThisForm.poDatamgr.SqlExecute(SqlChec,"csSigFiChc" )
    	Select csSigFiChc
	Select crSigFiChc

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCec.prg) - TRECHOS RELEVANTES PARA PASS SQL (1384 linhas total):

*-- Linhas 332 a 350:
332:             .HighlightBackColor = RGB(255, 255, 255)
333:             .HighlightForeColor = RGB(15, 41, 104)
334:             .HighlightStyle     = 2
335:             .DeleteMark         = .F.
336:             .RecordMark         = .F.
337:             .RowHeight          = 16
338:             .ScrollBars         = 2
339:             .GridLines          = 3
340:             .ReadOnly           = .T.
341:             .Visible            = .T.
342:         ENDWITH
343: 
344:         THIS.TornarControlesVisiveis(loc_oPagina)
345:     ENDPROC
346: 
347:     *--------------------------------------------------------------------------
348:     PROTECTED PROCEDURE ConfigurarPaginaDados()
349:         LOCAL loc_oPagina, loc_oCnt
350:         loc_oPagina = THIS.pgf_4c_Paginas.Page2

*-- Linhas 918 a 938:
918:                 IF THIS.this_oBusinessObject.Buscar("")
919:                     loc_oGrid.ColumnCount = 3
920:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
921:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Emps"
922:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Razas"
923:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Tipos"
924:                     loc_oGrid.Column1.Width          = 50
925:                     loc_oGrid.Column2.Width          = 300
926:                     loc_oGrid.Column3.Width          = 150
927:                     loc_oGrid.Column1.Header1.Caption = "Emp."
928:                     loc_oGrid.Column2.Header1.Caption = "Razao Social"
929:                     loc_oGrid.Column3.Header1.Caption = "Rede"
930:                     THIS.FormatarGridLista(loc_oGrid)
931:                     loc_lResultado = .T.
932:                 ENDIF
933:             ENDIF
934:         CATCH TO loc_oErro
935:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
936:         ENDTRY
937: 
938:         RETURN loc_lResultado

*-- Linhas 985 a 1042:
985:             RETURN
986:         ENDIF
987: 
988:         SELECT cursor_4c_Dados
989:         IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cIdChaves))
990:             THIS.BOParaForm()
991:             THIS.this_cModoAtual = "VISUALIZAR"
992:             THIS.HabilitarCampos(.F.)
993:             THIS.AjustarBotoesPorModo()
994:             THIS.AlternarPagina(2)
995:         ELSE
996:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
997:         ENDIF
998:     ENDPROC
999: 
1000:     *--------------------------------------------------------------------------
1001:     PROCEDURE BtnAlterarClick()
1002:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1003:             MsgAviso("Selecione um registro na lista.", "Aviso")
1004:             RETURN
1005:         ENDIF
1006: 
1007:         SELECT cursor_4c_Dados
1008:         IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cIdChaves))
1009:             THIS.this_oBusinessObject.EditarRegistro()
1010:             THIS.BOParaForm()
1011:             THIS.this_cModoAtual = "ALTERAR"
1012:             THIS.HabilitarCampos(.T.)
1013:             THIS.AjustarBotoesPorModo()
1014:             THIS.AlternarPagina(2)
1015:         ELSE
1016:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
1017:         ENDIF
1018:     ENDPROC
1019: 
1020:     *--------------------------------------------------------------------------
1021:     PROCEDURE BtnExcluirClick()
1022:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1023:             MsgAviso("Selecione um registro na lista.", "Aviso")
1024:             RETURN
1025:         ENDIF
1026: 
1027:         SELECT cursor_4c_Dados
1028:         IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cIdChaves))
1029:             THIS.BOParaForm()
1030:             THIS.this_cModoAtual = "EXCLUIR"
1031:             THIS.HabilitarCampos(.F.)
1032:             THIS.AjustarBotoesPorModo()
1033:             THIS.AlternarPagina(2)
1034:         ELSE
1035:             MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
1036:         ENDIF
1037:     ENDPROC
1038: 
1039:     *--------------------------------------------------------------------------
1040:     PROCEDURE BtnBuscarClick()
1041:         THIS.LimparCampos()
1042:         THIS.this_cModoAtual = "BUSCAR"

*-- Linhas 1176 a 1208:
1176:         ENDIF
1177: 
1178:         TRY
1179:             loc_cSQL = "SELECT cEmps, Razas FROM SigCdEmp WHERE cEmps = " + EscaparSQL(loc_cEmpresa)
1180:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
1181: 
1182:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Emp") > 0
1183:                 SELECT cursor_4c_Emp
1184:                 loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
1185:             ELSE
1186:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1187:                     "cursor_4c_EmpBusca", "cEmps", loc_cEmpresa, "Empresa")
1188:                 IF VARTYPE(loc_oBusca) = "O"
1189:                     loc_oBusca.mAddColuna("cEmps", "", "C" + CHR(243) + "digo")
1190:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1191:                     loc_oBusca.Show()
1192:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_EmpBusca")
1193:                         SELECT cursor_4c_EmpBusca
1194:                         loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_EmpBusca.cEmps)
1195:                         loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_EmpBusca.Razas)
1196:                     ELSE
1197:                         loc_oPagina.txt_4c_Empresa.Value = ""
1198:                     ENDIF
1199:                     loc_oBusca.Release()
1200:                     IF USED("cursor_4c_EmpBusca")
1201:                         USE IN cursor_4c_EmpBusca
1202:                     ENDIF
1203:                 ENDIF
1204:             ENDIF
1205: 
1206:             IF USED("cursor_4c_Emp")
1207:                 USE IN cursor_4c_Emp
1208:             ENDIF


### BO (C:\4c\projeto\app\classes\CecBO.prg):
*==============================================================================
* CecBO.prg - Business Object para Cadastro de Acesso a Consulta Generica
* Tabela: SigFiChc
* PK: cIdChaves (char 20, gerado por fUniqueIds)
*==============================================================================

DEFINE CLASS CecBO AS BusinessBase

    *-- Chave primaria
    this_cIdChaves    = ""   && char(20) PK

    *-- Campos de identificacao / chave composta funcional
    this_cEmps        = ""   && char(3)  Empresa (FK SigCdEmp.cEmps)
    this_cTipos       = ""   && char(20) Tipo de Consulta (CHEQUE PRE / SERASA / ACSP)

    *-- Campos de acesso CHEQUE PRE
    this_cCtr         = ""   && char(100) Contrato
    this_cRde         = ""   && char(100) Codigo da Rede
    this_cRdeLja      = ""   && char(100) Codigo da Loja

    *-- Campos de acesso nao-CHEQUE PRE
    this_cLogon       = ""   && char(8)  Logon
    this_cNSenha      = ""   && char(8)  nSenha (campo interno, armazenado no banco)
    this_cSenha       = ""   && char(8)  Senha de acesso

    *-- Valores de referencia
    this_nVlrMin      = 0    && numeric(11,2) Valor Minimo
    this_nVlrFixo     = 0    && numeric(11,2) Valor Fixo

    *-- Configuracao de conexao
    this_cCipchps     = ""   && char(32) URL / IP Proxy
    this_nPortachps   = 0    && int      Porta
    this_cVersao      = ""   && char(10) Versao

    *-- Consulta Serasa
    this_cCTipos      = ""   && char(2)  Tipo Consulta Serasa (CP / CH)

    *-- Proxy
    this_cUsuProxys   = ""   && char(64) Usuario Proxy
    this_cSenProxys   = ""   && char(20) Senha Proxy

    *-- Campo de exibicao (JOIN com SigCdEmp)
    this_cRazas       = ""   && char(40) Razao Social (SigCdEmp.Razas, somente leitura)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiChc"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros com JOIN para exibir Razao Social
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.Emps, a.Tipos, a.Ctr, a.Rde, a.RdeLja," + ;
                       " a.Logon, a.Senha, a.VlrMin, a.VlrFixo, a.cipchps, a.nPortachps," + ;
                       " a.cTipos, a.cUsuProxys, a.cSenProxys, b.Razas" + ;
                       " FROM SigFiChc a" + ;
                       " INNER JOIN SigCdEmp b ON a.Cemps = b.cEmps"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.Emps = " + EscaparSQL(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Tipos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pela PK (cIdChaves)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.Emps, a.Tipos, a.Ctr, a.Rde, a.RdeLja," + ;
                       " a.Logon, a.Senha, a.VlrMin, a.VlrFixo, a.cipchps, a.nPortachps," + ;
                       " a.cTipos, a.cUsuProxys, a.cSenProxys, b.Razas" + ;
                       " FROM SigFiChc a" + ;
                       " INNER JOIN SigCdEmp b ON a.Cemps = b.cEmps" + ;
                       " WHERE a.cIdChaves = " + EscaparSQL(par_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se ja existe registro com Emps+Tipos
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves FROM SigFiChc" + ;
                       " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Tipos = " + EscaparSQL(THIS.this_cTipos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dupl")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dupl") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves   = TratarNulo(cIdChaves,   "C")
            THIS.this_cEmps       = TratarNulo(Emps,        "C")
            THIS.this_cTipos      = TratarNulo(Tipos,       "C")
            THIS.this_cCtr        = TratarNulo(Ctr,         "C")
            THIS.this_cRde        = TratarNulo(Rde,         "C")
            THIS.this_cRdeLja     = TratarNulo(RdeLja,      "C")
            THIS.this_cLogon      = TratarNulo(Logon,       "C")
            THIS.this_cSenha      = TratarNulo(Senha,       "C")
            THIS.this_nVlrMin     = TratarNulo(VlrMin,      "N")
            THIS.this_nVlrFixo    = TratarNulo(VlrFixo,     "N")
            THIS.this_cCipchps    = TratarNulo(cipchps,     "C")
            THIS.this_nPortachps  = TratarNulo(nPortachps,  "N")
            THIS.this_cCTipos     = TratarNulo(cTipos,      "C")
            THIS.this_cUsuProxys  = TratarNulo(cUsuProxys,  "C")
            THIS.this_cSenProxys  = TratarNulo(cSenProxys,  "C")
            THIS.this_cRazas      = TratarNulo(Razas,       "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigFiChc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIdChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigFiChc" + ;
                       " (cIdChaves, Emps, Tipos, Ctr, Rde, RdeLja," + ;
                       " Logon, Senha, VlrMin, VlrFixo, cipchps, nPortachps," + ;
                       " cTipos, cUsuProxys, cSenProxys)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       EscaparSQL(THIS.this_cCtr) + "," + ;
                       EscaparSQL(THIS.this_cRde) + "," + ;
                       EscaparSQL(THIS.this_cRdeLja) + "," + ;
                       EscaparSQL(THIS.this_cLogon) + "," + ;
                       EscaparSQL(THIS.this_cSenha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVlrMin) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVlrFixo) + "," + ;
                       EscaparSQL(THIS.this_cCipchps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPortachps) + "," + ;
                       EscaparSQL(THIS.this_cCTipos) + "," + ;
                       EscaparSQL(THIS.this_cUsuProxys) + "," + ;
                       EscaparSQL(THIS.this_cSenProxys) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigFiChc (Emps e Tipos sao chave, nao alterar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigFiChc SET" + ;
                       " Ctr = " + EscaparSQL(THIS.this_cCtr) + "," + ;
                       " Rde = " + EscaparSQL(THIS.this_cRde) + "," + ;
                       " RdeLja = " + EscaparSQL(THIS.this_cRdeLja) + "," + ;
                       " Logon = " + EscaparSQL(THIS.this_cLogon) + "," + ;
                       " Senha = " + EscaparSQL(THIS.this_cSenha) + "," + ;
                       " VlrMin = " + FormatarNumeroSQL(THIS.this_nVlrMin) + "," + ;
                       " VlrFixo = " + FormatarNumeroSQL(THIS.this_nVlrFixo) + "," + ;
                       " cipchps = " + EscaparSQL(THIS.this_cCipchps) + "," + ;
                       " nPortachps = " + FormatarNumeroSQL(THIS.this_nPortachps) + "," + ;
                       " cTipos = " + EscaparSQL(THIS.this_cCTipos) + "," + ;
                       " cUsuProxys = " + EscaparSQL(THIS.this_cUsuProxys) + "," + ;
                       " cSenProxys = " + EscaparSQL(THIS.this_cSenProxys) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE da tabela SigFiChc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiChc WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

