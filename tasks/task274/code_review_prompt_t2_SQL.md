# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LCARTAO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, TIPOCAMPO, PROXIMOCOMANDO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TCDC' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, TIPOCAMPO, PROXIMOCOMANDO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GARANTIAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, TIPOCAMPO, PROXIMOCOMANDO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, TIPOCAMPO, PROXIMOCOMANDO

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
  ControlSource = "OPSENHA"
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = "+lsValPago)
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = "+laCartao[VAL(lsCartao)+1])
INSERT INTO crSiTef (Tef) VALUES ("011-000 = "+lsTipTran)
INSERT INTO crSiTef (Tef) VALUES ("012-000 = "+lsNsu)
INSERT INTO crSiTef (Tef) VALUES ("013-000 = "+lsAutoriza)
INSERT INTO crSiTef (Tef) VALUES ("015-000 = "+SUBSTR(lsDataHora,7,2)+SUBSTR(lsDataHora,5,2)+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("018-000 = "+ThisForm.Text1.Value)
INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("022-000 = "+SUBSTR(lsDataHora,7,2)+SUBSTR(lsDataHora,5,2)+SUBSTR(lsDataHora,1,4))
INSERT INTO crSiTef (Tef) VALUES ("023-000 = "+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("023-000 = "+lsFinaliza)
INSERT INTO crSiTef (Tef) VALUES ("027-000 = "+SUBSTR(lsDataHora,9,6))
	INSERT INTO crSiTef (Tef) VALUES ("029-"+TRANSFORM(lnLinha,"@L 999")+" = "+IIF(lsPos<>0,SUBSTR(lsCupom,1,lsPos-1),lsCupom))
INSERT INTO crSiTef (Tef) VALUES ("028-000 = "+ALLTRIM(STR(lnLinha-2)))
INSERT INTO crSiTef (Tef) VALUES ("030-000 = "+MenRet)
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = "+lsValPago)
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("030-000 = "+IIF("AGUARDE"$UPPER(lcMensagem),"TRANSACAO CANCELADA",lcMensagem))
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
	.poDatamgr.SqlExecute([Select * From SigOpFp Where FPags = ?lcOpers],'crSigOpFp')
	.poDatamgr.SqlExecute([Select * From SigCdEmp Where cEmps = ?_Empr],'crSigCdEmp')
				SELECT SigTef

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg) - TRECHOS RELEVANTES PARA PASS SQL (2124 linhas total):

*-- Linhas 145 a 183:
145: 
146:     *==========================================================================
147:     * CarregarDadosOperacao - Carrega crSigOpFp e crSigCdEmp via SQL Server
148:     * Migrado de: SIGPRDFT.Init (bloco poDataMgr.SqlExecute)
149:     *==========================================================================
150:     PROTECTED PROCEDURE CarregarDadosOperacao()
151:         LOCAL loc_cSQL, loc_oErro
152:         TRY
153:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
154:                 IF USED("crSigOpFp")
155:                     USE IN crSigOpFp
156:                 ENDIF
157:                 loc_cSQL = "SELECT * FROM SigOpFp WHERE FPags = " + ;
158:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cOpers))
159:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpFp") < 0
160:                     MsgErro("Erro ao carregar dados da opera" + CHR(231) + CHR(227) + "o SiTef", "Erro SQL")
161:                 ENDIF
162: 
163:                 IF USED("crSigCdEmp")
164:                     USE IN crSigCdEmp
165:                 ENDIF
166:                 loc_cSQL = "SELECT * FROM SigCdEmp WHERE cEmps = " + ;
167:                            EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
168:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmp") < 0
169:                     MsgErro("Erro ao carregar dados da empresa", "Erro SQL")
170:                 ENDIF
171: 
172:                 THIS.this_cIdTerminal = "00000" + ALLTRIM(go_4c_Sistema.cCodEmpresa)
173:             ELSE
174:                 MsgErro("Conex" + CHR(227) + "o com banco de dados indispon" + CHR(237) + "vel", ;
175:                         "Erro SiTef")
176:             ENDIF
177:         CATCH TO loc_oErro
178:             MsgErro(loc_oErro.Message, "Erro Carregar Dados Opera" + CHR(231) + CHR(227) + "o")
179:         ENDTRY
180:     ENDPROC
181: 
182:     *==========================================================================
183:     * ConfigurarPageFrame - Orquestra layout root do dialogo TEF (flat)


### BO (C:\4c\projeto\app\classes\sigprdftBO.prg):
*==============================================================================
* sigprdftBO.prg - Business Object para integracao SiTef (Cartao de Debito)
* Form original: SIGPRDFT.SCX
* Tipo: OPERACIONAL - dialogo modal de transacao TEF
*==============================================================================
DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Identificacao da entidade (sem tabela CRUD - form operacional)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Parametros de inicializacao recebidos via Init do form
    this_cEndSiTef   = ""
    this_nValPago    = 0
    this_cCupom      = ""
    this_cCaixa      = ""
    this_cDebCred    = ""
    this_cTipPagto   = ""
    this_nNumParcs   = 0
    this_cIdent      = ""
    this_cOpers      = ""

    *-- Dados retornados pelo SiTef apos a transacao
    this_cBandeira   = ""
    this_cCartao     = ""
    this_cNsu        = ""
    this_cAutoriza   = ""
    this_cDataHora   = ""
    this_cTipTran    = ""
    this_cFinaliza   = ""
    this_cMsgRetorno = ""

    *-- Flags e estado da transacao
    this_lAbandonou  = .F.
    this_lDCD        = .F.
    this_cSaqueValor = ""
    this_nParcelas   = 0

    *-- Dados do terminal calculados em runtime
    this_cIdTerminal = ""
    this_cValorStr   = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Override obrigatorio de BusinessBase
    * Form OPERACIONAL (dialogo SiTef) nao possui tabela CRUD. Os dados
    * persistidos sao os arquivos IntPos.001/IntPos.STS gerados por
    * MontaRetorno/RetornoFalha, portanto este metodo eh no-op.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".ValPago") = "N"
                    THIS.this_nValPago = NVL(&par_cAliasCursor..ValPago, 0)
                ENDIF
                IF TYPE(par_cAliasCursor + ".Cupom") = "C"
                    THIS.this_cCupom = NVL(&par_cAliasCursor..Cupom, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Caixa") = "C"
                    THIS.this_cCaixa = NVL(&par_cAliasCursor..Caixa, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Ident") = "C"
                    THIS.this_cIdent = NVL(&par_cAliasCursor..Ident, "")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarDoCursor SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Override de BusinessBase para form OPERACIONAL (SiTef)
    * Nao ha tabela CRUD. A persistencia ocorre via arquivos IntPos.001/
    * IntPos.STS gerados por MontaRetorno() apos a transacao SiTef ter
    * sucesso. Este metodo apenas registra a auditoria da operacao.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            THIS.RegistrarAuditoria("INSERT_TEF")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Inserir SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Override de BusinessBase para form OPERACIONAL (SiTef)
    * Nao ha tabela CRUD. Transacoes SiTef nao sao atualizadas apos
    * confirmacao (o protocolo TEF eh append-only). Este metodo apenas
    * registra a auditoria caso seja chamado.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            THIS.RegistrarAuditoria("UPDATE_TEF")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Atualizar SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Registra auditoria da transacao SiTef em LogAuditoria
    * Override que grava informacoes relevantes da transacao mesmo sem tabela
    * de destino (usa NSU + autorizacao como chave logica).
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lOk, loc_oErro

        loc_lOk = .T.
        TRY
            loc_cChave   = ALLTRIM(THIS.this_cNsu) + "|" + ALLTRIM(THIS.this_cAutoriza)
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChavePrimaria, Detalhes) " + ;
                       "VALUES (" + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cUsuario, 50)) + ", " + ;
                       EscaparSQL(LEFT(par_cOperacao, 20)) + ", " + ;
                       EscaparSQL("SIGPRDFT_SITEF") + ", " + ;
                       EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                       EscaparSQL(LEFT("Valor=" + TRANSFORM(THIS.this_nValPago, "@$ 999,999.99") + ;
                                       " Cupom=" + ALLTRIM(THIS.this_cCupom) + ;
                                       " Bandeira=" + ALLTRIM(THIS.this_cBandeira), 500)) + ;
                       ")"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lOk = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * InicializarDLLs - Declara funcoes da DLL CliSiTef32I
    * Migrado de: SIGPRDFT.Load
    *==========================================================================
    PROCEDURE InicializarDLLs()
        LOCAL loc_oErro
        TRY
            DECLARE Integer ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                String lsEndereco, String lsLoja, String lsTerminal, Integer lnReservado
            DECLARE Integer IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnModalidade, String lsValor, String lsCupom, ;
                String lsData, String lsHorario, String lsOperador, String lsRestricao
            DECLARE Integer ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer @lnComando, Integer @lnTipo, Integer @lnMinimo, Integer @lnMaximo, ;
                String @lsBuffer, Integer lnTamanho, Integer lnResultado
            DECLARE Integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnConfirma, String lsCupom, String lsData, String lsHorario
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro DLL SiTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ErroTef - Trata codigos de erro retornados pelo protocolo SiTef
    * Migrado de: SIGPRDFT.errotef
    *==========================================================================
    PROCEDURE ErroTef(par_nRetorno)
        LOCAL loc_cMsgPadrao
        loc_cMsgPadrao = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio"

        IF TYPE("par_nRetorno") <> "N"
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
            RETURN
        ENDIF

        IF par_nRetorno > -1 OR par_nRetorno < -5
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
            RETURN
        ENDIF

        DO CASE
        CASE par_nRetorno = -1
            THIS.RetornoFalha("Modulo Nao Iniciado", THIS.this_nValPago)
        CASE par_nRetorno = -2
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
        CASE par_nRetorno = -3
            THIS.RetornoFalha("Fornecida uma Modalidade Invalida", THIS.this_nValPago)
        CASE par_nRetorno = -4
            THIS.RetornoFalha("Falta Memoria para Rodar a Funcao", THIS.this_nValPago)
        CASE par_nRetorno = -5
            THIS.RetornoFalha("Sem Comunicacao com o SiTef", THIS.this_nValPago)
        ENDCASE
    ENDPROC

    *==========================================================================
    * MontaRetorno - Monta cursor crSiTef e grava arquivos de resposta de SUCESSO
    * Migrado de: SIGPRDFT.montaretorno
    * Par: par_sTipTran  = tipo da transacao (TipoCampo 100)
    *      par_sDataHora = data/hora no formato SiTef (TipoCampo 105)
    *      par_sCupom    = cupom fiscal com linhas separadas por CHR(10)
    *      par_sCartao   = codigo da bandeira selecionada
    *      par_sNsu      = NSU da transacao (TipoCampo 134)
    *      par_sAutoriza = codigo de autorizacao (TipoCampo 135)
    *      par_sFinaliza = dados de finalizacao
    *      par_nValPago  = valor da transacao
    *      par_sMenRet   = mensagem de retorno
    *==========================================================================
    PROCEDURE MontaRetorno(par_sTipTran, par_sDataHora, par_sCupom, par_sCartao, ;
                           par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago, par_sMenRet)
        LOCAL loc_sValPago, loc_sCartaoSel, loc_sCupomWork, loc_sPos, loc_nLinha
        LOCAL loc_laCartao[11]

        loc_sValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        loc_laCartao[1]  = "Outro, nao definido"
        loc_laCartao[2]  = "Visa"
        loc_laCartao[3]  = "Mastercard"
        loc_laCartao[4]  = "Diners"
        loc_laCartao[5]  = "American Express"
        loc_laCartao[6]  = "Sollo"
        loc_laCartao[7]  = "Sidecard (Redecard)"
        loc_laCartao[8]  = "Private Label (Redecard)"
        loc_laCartao[9]  = "Redeshop"
        loc_laCartao[10] = ""
        loc_laCartao[11] = "Fininvest"

        IF VAL(THIS.this_cBandeira) > 10 OR VAL(THIS.this_cBandeira) < 0
            loc_sCartaoSel = "0"
        ELSE
            loc_sCartaoSel = THIS.this_cBandeira
        ENDIF

        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        CREATE CURSOR crSiTef (tef c(100))

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
        INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_laCartao[VAL(loc_sCartaoSel) + 1])
        INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_sTipTran)
        INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_sNsu)
        INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_sAutoriza)
        INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
            SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + ALLTRIM(TRANSFORM(THIS.this_nParcelas, "@L 99")))
        INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
            SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 1, 4))
        INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_sFinaliza)
        INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_sDataHora, 9, 6))

        loc_sPos       = 1
        loc_nLinha     = 1
        loc_sCupomWork = par_sCupom
        DO WHILE loc_sPos <> 0
            loc_sPos = AT(CHR(10), loc_sCupomWork)
            INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
                IIF(loc_sPos <> 0, SUBSTR(loc_sCupomWork, 1, loc_sPos - 1), loc_sCupomWork))
            loc_sCupomWork = SUBSTR(loc_sCupomWork, loc_sPos + 1)
            loc_nLinha = loc_nLinha + 1
        ENDDO
        INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
        INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_sMenRet)
        INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        SET SAFETY OFF
        SELECT crSiTef
        COPY TO C:\client\Resp\IntPos.001 SDF
        ZAP

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        COPY TO C:\client\Resp\IntPos.STS SDF
        SET SAFETY ON

        USE IN crSiTef
    ENDPROC

    *==========================================================================
    * RetornoFalha - Monta cursor crSiTef e grava arquivos de resposta de FALHA
    * Migrado de: SIGPRDFT.retornofalha
    * Par: par_cMensagem = mensagem descritiva da falha
    *      par_nValPago  = valor da transacao (para registro no arquivo)
    *==========================================================================
    PROCEDURE RetornoFalha(par_cMensagem, par_nValPago)
        LOCAL loc_cMensagem, loc_sValPago

        loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
            "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", ;
            par_cMensagem)
        loc_sValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        CREATE CURSOR crSiTef (tef c(100))

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
        INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
        INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
        INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + ;
            IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
        INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        SET SAFETY OFF
        SELECT crSiTef
        COPY TO C:\client\Resp\IntPos.001 SDF
        ZAP

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        COPY TO C:\client\Resp\IntPos.STS SDF
        SET SAFETY ON

        USE IN crSiTef
    ENDPROC

    *==========================================================================
    * ObterRetornoStr - Retorna string de saida do form para o processo chamador
    * Migrado de: SIGPRDFT.Unload (logica de RETURN)
    * Formato: "saque/parcelas/data+bandeira+cartao"
    * Par: par_cSaque   = valor do saque formatado (ex: "0,00")
    *      par_nParcs   = numero de parcelas confirmadas
    *      par_dData    = data da parcela/vencimento
    *==========================================================================
    FUNCTION ObterRetornoStr(par_cSaque, par_nParcs, par_dData)
        LOCAL loc_cSaque, loc_cBandeira, loc_cCartao

        loc_cSaque    = IIF(EMPTY(par_cSaque), "0,00", par_cSaque)
        loc_cBandeira = IIF(EMPTY(THIS.this_cBandeira), "00000", LEFT(THIS.this_cBandeira + "00000", 5))
        loc_cCartao   = IIF(EMPTY(THIS.this_cCartao), "00000", LEFT(THIS.this_cCartao + "00000", 5))

        RETURN loc_cSaque + "/" + ;
               ALLTRIM(TRANSFORM(par_nParcs, "@L 99")) + "/" + ;
               DTOC(par_dData) + ;
               loc_cBandeira + ;
               loc_cCartao
    ENDPROC

ENDDEFINE

