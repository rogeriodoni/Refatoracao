# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIMPFABS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CNDTTRANSI, CTIPOS, CHEADERS, DATAS, DOPES, CUPFIS, FPAGS, CNNSUS, EMPDOPNUMS, CNIDTEFS, RETSQL, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'X' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CNDTTRANSI, CTIPOS, CHEADERS, DATAS, DOPES, CUPFIS, FPAGS, CNNSUS, EMPDOPNUMS, CNIDTEFS, RETSQL, CIDCHAVES

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
  DeleteMark = .F.
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
	.poDatamgr.SqlExecute([Select ncchequeps,Sistef, NumIps From SigCdPam],"crSigCdPam")
	.poDatamgr.SqlExecute([Select VerSitefs From SigCdPac],"crSigCdPac")
Select crSigCdPam
	SELECT crSigFiMpF
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
INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("022-000 = "+SUBSTR(lsDataHora,7,2)+SUBSTR(lsDataHora,5,2)+SUBSTR(lsDataHora,1,4))
INSERT INTO crSiTef (Tef) VALUES ("023-000 = "+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("023-000 = "+lsFinaliza)
INSERT INTO crSiTef (Tef) VALUES ("027-000 = "+SUBSTR(lsDataHora,9,6))
INSERT INTO crSiTef (Tef) VALUES ("028-000 = 27")
	INSERT INTO crSiTef (Tef) VALUES ("029-"+TRANSFORM(lnLinha,"@L 999")+" = "+IIF(lsPos<>0,SUBSTR(lsCupom,1,lsPos-1),lsCupom))
INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = "+STR(ltIdent,10))
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
	vSql=[Select Distinct a.Cemps, a.cDopes, a.cncupoms, a.cnIdents, a.cCupomNvs, a.cNnsus, a.cNValors, a.cnDtTrans, a.CnHrTrans, a.cStatus, a.FPags ]+;
	     [From SigFiTef a ]+;
	.SqlExecute(vSql,"Selecao")
	lcSql = [Select a.EmpDopNums, a.Notas, b.CupFis From SigMvCab a, SigCdOpe b where a.Datas Between ?llDti And ?llDtf ]+;
	.SqlExecute(lcSql,"Selecao2")
	Select Selecao2
Select Selecao
	=Seek(m.Cemps + Padr(m.Cdopes,20) + Str(Val(m.cncupoms),6),'Selecao2')
	Select Transacao
Select Transacao
	.Column1.ControlSource     = 'Transacao.cCupomnvs'
	.Column2.ControlSource     = 'Transacao.cnnsus'
	.Column3.ControlSource     = 'Transacao.cnValors'
	.Column4.ControlSource     = 'Transacao.CnDtTrans'
	.Column5.ControlSource     = 'Transacao.CnHrTrans'
	.Column6.ControlSource     = 'Transacao.CnCupoms'
	.Column7.ControlSource     = 'Transacao.cDopes'
SELECT Transacao
lcSql=[SELECT * From SigOpFp Where Fpags = ']+Transacao.FPags+[']
ThisFOrm.poDatamgr.SqlExecute(lcSql,"csSigOpFp")
SELECT Transacao
	lcSql=[Update SigFiTef set cStatus = 'CNC', UsuCancs = ']+Usuar+[' Where ctipos = 'R' And cHeaders='CRT' AND CNNSUS = ']+ALLTRIM(Transacao.cnnsus)+[']
	RetSql=ThisFOrm.poDatamgr.SqlExecute(lcSql)
	lcSql=[Select EmpDopNums,Valos,CnIdTefs,cidChaves From SigMvPar where EmpDopNums = ']+Transacao.EmpDopNums+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPar')
	Select LocalPar
		lcsql = [Update SigMvPar Set lCancelas = ?llTrue Where CidChaves = ']+LocalPar.Cidchaves+[']
		RetSql = ThisForm.Podatamgr.sqlexecute(lcSql,'')
SELECT Transacao
SELECT Transacao
lcSql=[SELECT * From SigOpFp Where Fpags = ']+Transacao.FPags+[']
ThisFOrm.poDatamgr.SqlExecute(lcSql,"csSigOpFp")
SELECT Transacao
SELECT Transacao
lcSql=[SELECT * From SigOpFp Where Fpags = ']+Transacao.FPags+[']
ThisFOrm.poDatamgr.SqlExecute(lcSql,"csSigOpFp")
Select Transacao
SELECT Transacao

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigproef.prg) - TRECHOS RELEVANTES PARA PASS SQL (1233 linhas total):

*-- Linhas 23 a 41:
23: * esqueleto de 6 colunas do SCX para 7). Entra tambem a carga de dados da
24: * grade: CarregarDados (funil que o legado chama no fim do Init e no
25: * LostFocus do Dt_Final) + VincularGrade (o bloco "With CntTransa.Grade" do
26: * fim do SqlTrans, com RecordSource/ControlSource/larguras/legendas e o
27: * DynamicForeColor que pinta de vermelho a transacao cancelada); a consulta
28: * em si vive no BO (sigproefBO.BuscarTransacoes). Os campos de periodo
29: * (Cnt_periodo) entram na Fase 5-6 e gravam nas properties de data do BO,
30: * que sao a fonte unica do filtro; os BINDEVENTs de F2/F3/F4/F5 e os Click
31: * dos cinco botoes entram nas Fases 7-8.
32: *
33: * FASE 5/8 (Campos Principais - Parte 1): cria o container de filtro de
34: * periodo (cnt_4c_Periodo, Cnt_periodo do legado) com a primeira metade dos
35: * campos - titulo "Periodo" (lbl_4c_Periodo) e o campo de data inicial
36: * (txt_4c_DataInicial). O separador "a" (Say2) e o campo de data final
37: * entram na Fase 6; os BINDEVENTs de LostFocus/Valid desses campos
38: * continuam nas Fases 7-8, junto com os demais handlers do form.
39: *
40: * FASE 6/8 (Campos Restantes e Lookups): completa cnt_4c_Periodo com o
41: * separador "a" (Say2 -> lbl_4c_Separador) e o segundo campo de data

*-- Linhas 316 a 356:
316:     * metodo Sqltrans do legado (que reescreve o esqueleto de 6 colunas
317:     * desenhado no SCX, elevando ColumnCount para 7 e incluindo a coluna
318:     * "Operacao" - a legenda que o usuario realmente ve eh essa, nao a do
319:     * design-time). RecordSource/ControlSource ficam para a fase de carga
320:     * (CarregarDados/VincularGrade): atribuir Column.ControlSource antes de o
321:     * cursor existir derrubaria o Init - e o RecordSource reseta largura e
322:     * legenda, que por isso sao reaplicadas em VincularGrade.
323:     *--------------------------------------------------------------------------
324:     PROTECTED PROCEDURE ConfigurarGradeDados()
325:         LOCAL loc_oGrd
326: 
327:         THIS.cnt_4c_Transa.AddObject("grd_4c_Dados", "Grid")
328:         loc_oGrd = THIS.cnt_4c_Transa.grd_4c_Dados
329:         WITH loc_oGrd
330:             .Top           = 41
331:             .Left          = 8
332:             .Height        = 230
333:             .Width         = 569
334:             .ColumnCount   = 7
335:             .ScrollBars    = 2
336:             .FontSize      = 8
337:             .HeaderHeight  = 16
338:             .RowHeight     = 15
339:             .GridLineColor = RGB(192,192,192)
340:             .ReadOnly      = .T.
341:             .DeleteMark    = .F.
342:             .RecordMark    = .F.
343:         ENDWITH
344: 
345:         WITH loc_oGrd.Column1
346:             .Width             = 70
347:             .FontSize          = 8
348:             .Movable           = .F.
349:             .Resizable         = .F.
350:             .ReadOnly          = .T.
351:             .Header1.Caption   = "Rede"
352:             .Header1.Alignment = 2
353:             .Header1.FontSize  = 8
354:             .Text1.FontSize    = 8
355:         ENDWITH
356: 

*-- Linhas 770 a 788:
770:             RETURN
771:         ENDIF
772: 
773:         SELECT cursor_4c_Transacao
774:         IF ALLTRIM(NVL(cStatus, "")) == "CNC"
775:             MsgAviso("Transa" + CHR(231) + CHR(227) + "o Cancelada", "Reimprimir")
776:             RETURN
777:         ENDIF
778: 
779:         loc_cNsuOriginal  = ALLTRIM(NVL(cnnsus, ""))
780:         loc_cDataOriginal = SUBSTR(DTOC(cndttrans), 1, 2) + SUBSTR(DTOC(cndttrans), 4, 2) + SUBSTR(DTOC(cndttrans), 7, 4)
781: 
782:         TRY
783:             *-- Legado: SKIP antes de ler os campos usados no DO FORM (ver cabecalho)
784:             SKIP
785: 
786:             loc_oBO.CarregarDoCursor("cursor_4c_Transacao")
787:             loc_oBO.CarregarFormaPagamento()
788: 

*-- Linhas 799 a 825:
799:                     cursor_4c_Transacao.cnvalors, cursor_4c_Transacao.cndttrans, cursor_4c_Transacao.CnHrTrans, loc_oBO.this_cCodEstabs
800:             ENDIF
801: 
802:             SELECT cursor_4c_Transacao
803:             SKIP -1
804:         CATCH TO loc_oErro
805:             MsgErro(loc_oErro.Message + CHR(13) + ;
806:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
807:                     "Procedure: " + loc_oErro.Procedure, ;
808:                     "Erro em BtnReimprimeClick")
809:             IF USED("cursor_4c_Transacao")
810:                 SELECT cursor_4c_Transacao
811:                 SKIP -1
812:             ENDIF
813:         ENDTRY
814: 
815:         THIS.Release()
816:     ENDPROC
817: 
818:     *--------------------------------------------------------------------------
819:     * BtnGerencialClick - cmd_4c_Gerencial.Click. Legado:
820:     *   Resposta=SigPrTef(crSigCdPam.NumIps,110,Transacao.cnValors,"1",
821:     *                      crSigFiMpF.CnCaixas,,"SW000001",0)
822:     *   Release Windows
823:     *
824:     * SigPrTef() eh funcao GLOBAL do legado (protocolo SiTef via DLL do
825:     * pinpad, comando administrativo tipo 110 = "Via Gerencial") que NAO

*-- Linhas 894 a 912:
894:                     "Erro em BtnUltimoClick")
895:         ENDTRY
896: 
897:         SELECT cursor_4c_Transacao
898:         IF RECCOUNT("cursor_4c_Transacao") > 0
899:             GO BOTTOM
900:         ENDIF
901: 
902:         THIS.Release()
903:     ENDPROC
904: 
905:     *--------------------------------------------------------------------------
906:     * ValidarDataInicial - handler do campo de data inicial (Dt_inicial do
907:     * legado). Reune, na ordem em que o legado os executa, o Valid e o
908:     * LostFocus do campo:
909:     *
910:     *   PROCEDURE Valid
911:     *   If This.Value > ThisForm.CntTransa.Cnt_periodo.Dt_inicial.Value
912:     *       ThisForm.CntTransa.Cnt_periodo.Dt_inicial.Value = This.Value

*-- Linhas 1069 a 1087:
1069:     * que o VFP reseta ao trocar RecordSource. Transcreve o bloco
1070:     * "With ThisForm.CntTransa.Grade" do fim do SqlTrans legado.
1071:     *
1072:     * Ordem OBRIGATORIA: ColumnCount -> RecordSource -> ControlSource ->
1073:     * Width -> Header1.Caption. ColumnCount vem ANTES do RecordSource senao a
1074:     * grade auto-expande para as 13 colunas do cursor; e atribuir RecordSource
1075:     * recalcula as larguras para o default 90 e devolve os headers para
1076:     * "Column1"/"Column2"... - por isso largura e legenda sao reaplicadas
1077:     * AQUI, depois do vinculo, e nao apenas em ConfigurarGradeDados.
1078:     *
1079:     * DynamicForeColor pinta de vermelho a transacao cancelada (lCancel),
1080:     * exatamente como o SetAll do legado.
1081:     *--------------------------------------------------------------------------
1082:     PROTECTED PROCEDURE VincularGrade()
1083:         LOCAL loc_oGrd
1084: 
1085:         IF !USED("cursor_4c_Transacao")
1086:             RETURN .F.
1087:         ENDIF

*-- Linhas 1093 a 1117:
1093:             .RecordSource = "cursor_4c_Transacao"
1094:             .ReadOnly     = .T.
1095: 
1096:             .Column1.ControlSource = "cursor_4c_Transacao.ccupomnvs"
1097:             .Column2.ControlSource = "cursor_4c_Transacao.cnnsus"
1098:             .Column3.ControlSource = "cursor_4c_Transacao.cnvalors"
1099:             .Column4.ControlSource = "cursor_4c_Transacao.cndttrans"
1100:             .Column5.ControlSource = "cursor_4c_Transacao.CnHrTrans"
1101:             .Column6.ControlSource = "cursor_4c_Transacao.cnCupoms"
1102:             .Column7.ControlSource = "cursor_4c_Transacao.cDopes"
1103: 
1104:             *-- larguras do legado (reaplicadas APOS o RecordSource)
1105:             .Column1.Width = 70
1106:             .Column2.Width = 78
1107:             .Column3.Width = 75
1108:             .Column4.Width = 65
1109:             .Column5.Width = 55
1110:             .Column6.Width = 60
1111:             .Column7.Width = 120
1112: 
1113:             *-- legendas do legado (resetadas pelo RecordSource)
1114:             .Column1.Header1.Caption = "Rede"
1115:             .Column2.Header1.Caption = "No.Autoriza" + CHR(231) + CHR(227) + "o"
1116:             .Column3.Header1.Caption = "Valor"
1117:             .Column4.Header1.Caption = "Data"

*-- Linhas 1136 a 1154:
1136: 
1137:         *-- Legado: Go Bott no cursor + Grade.Refresh. Popular o cursor NAO
1138:         *-- repinta a grade sozinho (regra #21a).
1139:         SELECT cursor_4c_Transacao
1140:         IF RECCOUNT("cursor_4c_Transacao") > 0
1141:             GO BOTTOM
1142:         ENDIF
1143:         loc_oGrd.Refresh()
1144: 
1145:         *-- Legado: Grade.SetFocus no fim do SqlTrans. Na carga disparada pelo
1146:         *-- Init o form ainda nao esta visivel e SetFocus estouraria; nas
1147:         *-- recargas (troca de periodo) a grade ja esta na tela e recebe o foco.
1148:         IF THIS.Visible AND loc_oGrd.Visible AND loc_oGrd.Enabled
1149:             loc_oGrd.SetFocus()
1150:         ENDIF
1151: 
1152:         RETURN .T.
1153:     ENDPROC
1154: 


### BO (C:\4c\projeto\app\classes\sigproefBO.prg):
*====================================================================
* sigproefBO.prg
*
* Business Object para Selecao/Cancelamento de Transacoes TEF (sigproef)
* Form OPERACIONAL - lista as transacoes TEF (cartao/cheque) efetuadas
* num periodo, permite reimprimir comprovante, cancelar a transacao
* (com baixa no SigMvPar) e emitir relatorio Gerencial do TEF.
* Tabela principal: SigFiTef (cidchaves PK char(20))
* Tabelas relacionadas: SigOpFp, SigCdPam, SigCdPac, SigFiMpF,
*                        SigMvCab, SigCdOpe, SigMvPar
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigproefBO AS BusinessBase

    *-- Parametros do sistema, carregados em Init a partir de SigCdPam/SigCdPac
    *-- (legado: crSigCdPam / crSigCdPac, lidos uma unica vez no Init do form)
    this_nNcChequePs = 0      && SigCdPam.ncchequeps - numeric(1,0)
    this_nSistef     = 0      && SigCdPam.sistef - numeric(1,0), indica uso de TEF
    this_cNumIps     = ""     && SigCdPam.numips - char(15), numero do PDV/caixa no TEF
    this_cVerSitefs  = ""     && SigCdPac.versitefs - char(10), versao do protocolo SiTef instalado

    *-- Dados da impressora fiscal do caixa corrente, carregados a partir de
    *-- SigFiMpF (legado: crSigFiMpF, localizado por CursorQuery em cimpfabs)
    this_cCImpFabs   = ""     && SigFiMpF.cimpfabs - PK, numero de fabricacao decriptografado
    this_cCnCaixas   = ""     && SigFiMpF.cncaixas - char(3), caixa associado a impressora

    *-- Identificacao da operacao/caixa, equivalente as propriedades do
    *-- Form legado (coperacao/nocaixa/nofab), usadas em SqlTrans e nos
    *-- DO FORM de Cancelamento/Reimpressao/Gerencial
    this_cOperacao   = ""     && PADR(NoCaixa + NoFab + 'ADM', 20)
    this_cNoCaixa    = ""     && numero do caixa (mesmo valor de this_cCnCaixas)
    this_cNoFab      = ""     && numero de fabricacao da impressora, ja decriptografado

    *-- Permissao de acesso ao botao Cancelar (fChecaAcesso('SIGPROEF','CANCELA'))
    this_lPermiteCancelar = .F.

    *-- Periodo de pesquisa das transacoes (controles Dt_Inicial/Dt_Final)
    this_dDataInicial = {}
    this_dDataFinal   = {}

    *-- Linha corrente do cursor de transacoes (grid da tela), montada em
    *-- BuscarTransacoes a partir de SigFiTef (Selecao) + SigMvCab/SigCdOpe
    *-- (Selecao2) - usada pelos botoes Cancela/Reimprime/Ultimo/Gerencial
    this_cCEmps       = ""    && SigFiTef.cemps - char(3)
    this_cDopes       = ""    && SigFiTef.cdopes - char(20), documento da operacao
    this_cCnCupoms    = ""    && cnCupoms apos SqlTrans (substituido por SigMvCab.Notas)
    this_cCCupomNvs   = ""    && SigFiTef.ccupomnvs - char(20), rede/bandeira do cartao
    this_cCnNsus      = ""    && SigFiTef.cnnsus - char(12), NSU da transacao TEF
    this_nCnValors    = 0     && SigFiTef.cnvalors - valor da transacao (convertido p/ numerico)
    this_dCnDtTrans   = {}    && SigFiTef.cndttrans - data da transacao (convertida p/ DATE)
    this_cCnHrTrans   = ""    && SigFiTef.cnhrtrans - char(8), hora da transacao (@R xx:xx:xx)
    this_cCStatus     = ""    && SigFiTef.cstatus - char(3), status ('CNC' = cancelada)
    this_cFPags       = ""    && SigFiTef.fpags - char(12), forma de pagamento (FK SigOpFp)
    this_lLCancel     = .F.   && .T. quando this_cCStatus = 'CNC' (uso visual na grade)
    this_nCupFis      = 0     && SigMvCab.cupfis (via SigCdOpe) - 1/3 = cupom nao fiscal
    this_cEmpDopNums  = ""    && SigMvCab.empdopnums - char(29), POSICIONAL (regra #42)
    this_cCnIdents    = ""    && SigFiTef.cnidents - char(10), identificador interno da transacao

    *-- Dados da forma de pagamento (SigOpFp), carregados a partir de
    *-- this_cFPags para montar os parametros dos DO FORM de Cancelamento/
    *-- Reimpressao/Ultimo
    this_cOpers       = ""    && SigOpFp.opers
    this_cLCartao     = ""    && SigOpFp.lcartao - char(1), NAO bit (conferido no schema)
    this_cCodEstabs   = ""    && SigOpFp.codestabs

    *-- Registro de SigMvPar correspondente a transacao (localizado por
    *-- this_cEmpDopNums + this_cCnIdents = SigMvPar.cnidtefs), usado para
    *-- marcar o cancelamento (lcancelas) no ExecutarCancelamento
    this_cCidChavesPar = ""   && SigMvPar.cidchaves
    this_nValosPar     = 0    && SigMvPar.valos
    this_cCnIdTefsPar  = ""   && SigMvPar.cnidtefs

    *-- Resultado/mensagem da ultima operacao SQL (Update/Commit)
    this_cMensagemRetorno = ""

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigFiTef"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "sigproefBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Carrega os parametros gerais usados pelos
    * botoes de acao, equivalente ao bloco do Init legado:
    *   .poDatamgr.SqlExecute([Select ncchequeps,Sistef, NumIps From SigCdPam],"crSigCdPam")
    *   .poDatamgr.SqlExecute([Select VerSitefs From SigCdPac],"crSigCdPac")
    *   ThisForm.CntTransa.Cancela.Visible = fChecaAcesso('SIGPROEF','CANCELA')
    *
    * O "=fLerFiscal()" do Init legado NAO entra aqui: carrega CrSigFiFis/
    * config de impressora fiscal para OUTRAS telas (ex.: SigOpAut) - o
    * proprio sigproef nunca le o resultado em lugar nenhum do dump. Omitir
    * tem o MESMO efeito observavel nesta tela (regra CLAUDE.md #27 -
    * funcao global sem consumo local).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_cSQL = "SELECT ncchequeps, sistef, numips FROM SigCdPam"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Pam") > 0
                SELECT cursor_4c_Pam
                GO TOP
                THIS.this_nNcChequePs = TratarNulo(ncchequeps, 0)
                THIS.this_nSistef     = TratarNulo(sistef, 0)
                THIS.this_cNumIps     = TratarNulo(numips, "")
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF
            loc_cSQL = "SELECT versitefs FROM SigCdPac"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Pac") > 0
                SELECT cursor_4c_Pac
                GO TOP
                THIS.this_cVerSitefs = TratarNulo(versitefs, "")
            ENDIF
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF

            THIS.this_lPermiteCancelar = fChecaAcesso("SIGPROEF", "CANCELA")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarParametrosSistema")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosImpressoraFiscal - Localiza a impressora fiscal do caixa
    * corrente, equivalente ao bloco do Init legado:
    *   lnNoFabr = LeituraFab(oFormulario)
    *   lcNoFabr = fDecriptografar(Alltrim(lnNoFabr))
    *   ThisForm.podatamgr.CursorQuery('SigFiMpF','crSigFiMpF','cimpfabs', lcNoFabr)
    *   Thisform.NoCaixa    = crSigFiMpf.cnCaixas
    *   Thisform.NoFab      = lnNoFabr
    *   Thisform.cOperacao  = PADR(NoCaixa+NoFab+'ADM',20)
    *
    * LeituraFab()/fDecriptografar() (utils\leiturafab.prg/fdecriptografar.prg)
    * sao wrappers de compatibilidade que sempre devolvem "" - o protocolo
    * proprietario da impressora fiscal nao esta no acervo. Com cimpfabs=""
    * a consulta nao casa com nenhuma impressora real - o MESMO efeito
    * pratico que o legado produz quando a leitura da impressora falha.
    *
    * Retorna .F. quando a impressora nao foi localizada (o Form exibe o
    * aviso do legado "Impressora Fiscal Invalida para esta Loja !!"), mas
    * NAO interrompe a abertura: o legado tambem segue adiante (a variavel
    * "ok" fica .F. e nunca eh conferida depois do bloco).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosImpressoraFiscal()
        LOCAL loc_cNoFab, loc_cSQL, loc_nResultado, loc_lEncontrou, loc_oErro
        loc_lEncontrou = .F.

        TRY
            loc_cNoFab = LeituraFab(.NULL.)

            IF VARTYPE(loc_cNoFab) = "C"
                loc_cNoFab = fDecriptografar(ALLTRIM(loc_cNoFab))

                IF USED("cursor_4c_MpF")
                    USE IN cursor_4c_MpF
                ENDIF

                loc_cSQL = "SELECT cimpfabs, cncaixas FROM SigFiMpF" + ;
                           " WHERE cimpfabs = " + EscaparSQL(loc_cNoFab)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MpF")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_MpF") > 0
                    SELECT cursor_4c_MpF
                    GO TOP
                    THIS.this_cCImpFabs = TratarNulo(cimpfabs, "")
                    THIS.this_cCnCaixas = TratarNulo(cncaixas, "")
                    THIS.this_cNoCaixa  = THIS.this_cCnCaixas
                    THIS.this_cNoFab    = loc_cNoFab
                    THIS.this_cOperacao = PADR(THIS.this_cNoCaixa + THIS.this_cNoFab + "ADM", 20)
                    loc_lEncontrou = .T.
                ENDIF

                IF USED("cursor_4c_MpF")
                    USE IN cursor_4c_MpF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDadosImpressoraFiscal")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFormaPagamento - Localiza a forma de pagamento (SigOpFp) da
    * transacao corrente, equivalente ao bloco repetido em Cancela/Reimprime/
    * Ultimo.Click do legado:
    *   lcSql=[SELECT * From SigOpFp Where Fpags = ']+Transacao.FPags+[']
    *   ThisFOrm.poDatamgr.SqlExecute(lcSql,"csSigOpFp")
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFormaPagamento()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        IF USED("cursor_4c_OpFp")
            USE IN cursor_4c_OpFp
        ENDIF

        loc_cSQL = "SELECT opers, lcartao, codestabs FROM SigOpFp" + ;
                   " WHERE fpags = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cFPags, "")))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpFp")

        IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_OpFp") > 0
            SELECT cursor_4c_OpFp
            GO TOP
            THIS.this_cOpers     = TratarNulo(opers, "")
            THIS.this_cLCartao   = TratarNulo(lcartao, "")
            THIS.this_cCodEstabs = TratarNulo(codestabs, "")
            loc_lSucesso = .T.
        ENDIF

        IF USED("cursor_4c_OpFp")
            USE IN cursor_4c_OpFp
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha corrente do cursor de transacoes
    * (grid "Transacao" do legado - Create Cursor em SqlTrans) para as
    * properties this_*, usadas pelos botoes Cancela/Reimprime/Ultimo/
    * Gerencial. Colunas na mesma ordem do CREATE CURSOR do legado.
    *
    * SigFiTef.cemps NAO entra aqui: a consulta legado (Selecao) traz
    * a.Cemps, mas o CREATE CURSOR Transacao nunca declara esse campo, e o
    * Gather Memvar so copia os nomes que o cursor destino possui - ou
    * seja, o legado tambem descarta Cemps nesse ponto. Fidelidade ao
    * legado: nao carregar o que ele mesmo nao carrega.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cDopes      = TratarNulo(cDopes, "")
        THIS.this_cCnCupoms   = TratarNulo(cnCupoms, "")
        THIS.this_cCCupomNvs  = TratarNulo(ccupomnvs, "")
        THIS.this_cCnNsus     = TratarNulo(cnnsus, "")
        THIS.this_nCnValors   = TratarNulo(cnvalors, 0)
        THIS.this_dCnDtTrans  = TratarNulo(cndttrans, {})
        THIS.this_cCnHrTrans  = TratarNulo(CnHrTrans, "")
        THIS.this_cCStatus    = TratarNulo(cStatus, "")
        THIS.this_cFPags      = TratarNulo(FPags, "")
        THIS.this_lLCancel    = TratarNulo(lCancel, .F.)
        THIS.this_nCupFis     = TratarNulo(CupFis, 0)
        THIS.this_cEmpDopNums = TratarNulo(EmpdopNums, "")
        THIS.this_cCnIdents   = TratarNulo(cnIdents, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Guardas do legado antes do cancelamento (inicio do
    * Cancela.Click: Eof() / cStatus = "CNC"). A confirmacao interativa do
    * cupom nao fiscal (CupFis = 3) eh decisao de UX e fica no Form, que so
    * chama Salvar()/Atualizar() depois de o usuario confirmar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(NVL(THIS.this_cCnNsus, "")))
            THIS.this_cMensagemErro = "N" + CHR(227) + "o Existem Transa" + CHR(231) + CHR(245) + "es Efetuadas"
            RETURN .F.
        ENDIF

        IF ALLTRIM(NVL(THIS.this_cCStatus, "")) = "CNC"
            THIS.this_cMensagemErro = "Transa" + CHR(231) + CHR(227) + "o Cancelada"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Executa o cancelamento da transacao TEF, equivalente ao
    * corpo em SQL do Cancela.Click do legado:
    *   Update SigFiTef set cStatus = 'CNC', UsuCancs = Usuar
    *     Where ctipos = 'R' And cHeaders = 'CRT' And cnnsus = <valor>
    * e, se a atualizacao acima teve sucesso, marca a parcela de SigMvPar
    * correspondente (AtualizarParcelaSigMvPar). So confirma com
    * SQLCOMMIT quando as duas gravacoes (ou a ausencia legitima da
    * parcela em SigMvPar) permitirem - replica o "If RetSql > 0" final
    * do legado, que so comita quando nada saiu errado.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigFiTef SET " + ;
                       "cStatus = " + EscaparSQL("CNC") + ", " + ;
                       "UsuCancs = " + EscaparSQL(TratarNulo(gc_4c_UsuarioLogado, "")) + " " + ;
                       "WHERE ctipos = " + EscaparSQL("R") + ;
                       " AND cHeaders = " + EscaparSQL("CRT") + ;
                       " AND cnnsus = " + EscaparSQL(ALLTRIM(THIS.this_cCnNsus))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                IF THIS.AtualizarParcelaSigMvPar()
                    SQLCOMMIT(gnConnHandle)
                    THIS.this_lLCancel = .T.
                    THIS.this_cCStatus = "CNC"
                    loc_lSucesso = .T.
                ELSE
                    SQLROLLBACK(gnConnHandle)
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel atualizar a parcela em SigMvPar:" + ;
                        CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Cancelar Transa" + CHR(231) + CHR(227) + "o")
                ENDIF
            ELSE
                SQLROLLBACK(gnConnHandle)
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel cancelar a transa" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Cancelar Transa" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Cancelar Transa" + CHR(231) + CHR(227) + "o")
        ENDTRY

        IF loc_lSucesso
            THIS.RegistrarAuditoria("ATUALIZAR")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarParcelaSigMvPar - Replica o bloco do legado que localiza a
    * parcela de SigMvPar pela chave posicional EmpDopNums (regra #42 -
    * NUNCA Alltrim nas partes, o valor ja vem completo de SigMvCab) e,
    * achando a linha cujo CnIdTefs bate com o identificador TEF da
    * transacao, marca lCancelas = 1.
    *
    * Retorna .T. quando NAO ha parcela (nada a fazer - legado tambem
    * comita so com o UPDATE de SigFiTef) OU quando a parcela foi marcada
    * com sucesso; .F. somente quando a parcela existe e o UPDATE falhou -
    * nesse caso o chamador reverte a transacao inteira (mesmo "If RetSql
    * > 0" final do legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarParcelaSigMvPar()
        LOCAL loc_cSQL, loc_nResultado, loc_lPodeComitar

        loc_lPodeComitar = .T.

        IF USED("cursor_4c_SigMvParTmp")
            USE IN cursor_4c_SigMvParTmp
        ENDIF

        loc_cSQL = "SELECT EmpDopNums, Valos, CnIdTefs, cidChaves " + ;
                   "FROM SigMvPar " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvParTmp")

        IF loc_nResultado > 0
            SELECT cursor_4c_SigMvParTmp
            LOCATE FOR ALLTRIM(cnidtefs) == ALLTRIM(THIS.this_cCnIdents)
            IF FOUND()
                THIS.this_cCidChavesPar = TratarNulo(cidchaves, "")
                THIS.this_nValosPar     = TratarNulo(valos, 0)
                THIS.this_cCnIdTefsPar  = TratarNulo(cnidtefs, "")

                loc_cSQL = "UPDATE SigMvPar SET lCancelas = 1 " + ;
                           "WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChavesPar)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                loc_lPodeComitar = (loc_nResultado > 0)
            ENDIF
        ENDIF

        IF USED("cursor_4c_SigMvParTmp")
            USE IN cursor_4c_SigMvParTmp
        ENDIF

        RETURN loc_lPodeComitar
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - SigFiTef.cidchaves nao vem na consulta legado
    * (Selecao/Transacao); a chave que o proprio Cancela.Click usa para
    * localizar e atualizar o registro eh cnnsus (Where ... And CNNSUS =
    * <valor>), entao eh essa a chave usada na auditoria deste BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCnNsus, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / ExecutarExclusao - este BO cobre consulta de transacoes
    * TEF e cancelamento (Atualizar); o legado nunca cria nem exclui
    * registro de SigFiTef a partir desta tela (Cancela.Click so faz
    * Update). O comportamento padrao herdado de BusinessBase ja eh o
    * correto para as duas operacoes - por isso nao sao sobrescritas aqui.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * BuscarTransacoes - Carga do cursor de transacoes TEF exibido na grade.
    * Transcreve o corpo de dados do metodo SqlTrans do legado:
    *
    *   1) "Selecao"  -> SigFiTef no periodo (cndttransi entre as duas datas em
    *      DTOS), so transacao de RETORNO (ctipos = "R") de cartao ou cheque
    *      (cHeaders "CRT"/"CHQ") e com NSU preenchido, ordenada por data/hora.
    *   2) "Selecao2" -> SigMvCab x SigCdOpe no mesmo periodo (datas entre o
    *      inicio do primeiro dia e 23:59:59 do ultimo), restrita as operacoes
    *      de cupom (b.cupfis IN (1,3)), indexada por EmpDopNums.
    *   3) cursor_4c_Transacao -> uma linha por transacao, com as conversoes do
    *      legado: hora formatada (@R xx:xx:xx), valor em centavos dividido por
    *      100, data DDMMYYYY convertida para DATE, e Notas/CupFis/EmpDopNums
    *      trazidos de Selecao2 pela chave POSICIONAL de 29 caracteres.
    *
    * A chave de busca em Selecao2 eh POSICIONAL (regra #42): cemps char(3) +
    * cdopes char(20) + STR(cncupoms, 6) = 29 = EmpDopNums char(29). Por isso
    * usa PADR explicito em cada parte - ALLTRIM aqui devolveria ZERO linhas
    * em silencio.
    *
    * O cursor eh criado UMA vez e recarregado com ZAP nas chamadas seguintes:
    * recria-lo derrubaria o RecordSource/ControlSource da grade do form.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_dIni, loc_dFim, loc_cHora, loc_nValor, loc_cDataTxt
        LOCAL loc_dTrans, loc_cChave, loc_cNotas, loc_nCupFis, loc_cEmpDop
        LOCAL loc_cNsu, loc_lTemConexao

        loc_lSucesso            = .F.
        THIS.this_cMensagemErro = ""

        TRY
            *-- Legado: Dt_Inicial/Dt_Final nascem com DATE() no Init do form
            IF EMPTY(THIS.this_dDataInicial)
                THIS.this_dDataInicial = DATE()
            ENDIF
            IF EMPTY(THIS.this_dDataFinal)
                THIS.this_dDataFinal = DATE()
            ENDIF

            loc_dIni = ConverterParaData(THIS.this_dDataInicial)
            loc_dFim = ConverterParaData(THIS.this_dDataFinal)

            *-- Guard do handle, no padrao de DataAccess/BusinessBase: sem ele
            *-- o SQLEXEC estoura com "Variable GNCONNHANDLE is not found" ou
            *-- com erro de handle invalido, mensagem que nao diz nada ao
            *-- usuario. Os dois testes vao em IF ANINHADO, nao em um OR:
            *-- VFP9 NAO faz short-circuit, entao "TYPE(x) != N OR x <= 0"
            *-- avaliaria x <= 0 mesmo com a variavel inexistente - que eh
            *-- exatamente o erro que o guard existe para evitar.
            loc_lTemConexao = .F.
            IF TYPE("gnConnHandle") = "N"
                IF gnConnHandle > 0
                    loc_lTemConexao = .T.
                ENDIF
            ENDIF

            IF !loc_lTemConexao
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados."
                loc_lSucesso = .F.
            ELSE

                *-- 1) Selecao: transacoes TEF do periodo
                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                loc_cSQL = "SELECT DISTINCT a.cemps, a.cdopes, a.cncupoms, a.cnidents," + ;
                           " a.ccupomnvs, a.cnnsus, a.cnvalors, a.cndttrans," + ;
                           " a.cnhrtrans, a.cstatus, a.fpags" + ;
                           " FROM SigFiTef a" + ;
                           " WHERE a.cndttransi BETWEEN " + EscaparSQL(DTOS(loc_dIni)) + ;
                           " AND " + EscaparSQL(DTOS(loc_dFim)) + ;
                           " AND a.ctipos = " + EscaparSQL("R") + ;
                           " AND (a.cheaders = " + EscaparSQL("CRT") + ;
                           " OR a.cheaders = " + EscaparSQL("CHQ") + ")" + ;
                           " AND NOT a.cnnsus = " + EscaparSQL("   ") + ;
                           " ORDER BY a.cndttrans, a.cnhrtrans"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Selecao")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel consultar as transa" + CHR(231) + CHR(245) + "es TEF:" + ;
                        CHR(13) + CapturarErroSQL()
                ELSE
                    *-- 2) Selecao2: cupom/operacao do movimento no mesmo periodo
                    IF USED("cursor_4c_Selecao2")
                        USE IN cursor_4c_Selecao2
                    ENDIF

                    loc_cSQL = "SELECT a.empdopnums, a.notas, b.cupfis" + ;
                               " FROM SigMvCab a, SigCdOpe b" + ;
                               " WHERE a.datas BETWEEN " + FormatarDataSQL(DTOT(loc_dIni)) + ;
                               " AND " + FormatarDataSQL(DTOT(loc_dFim) + 86399) + ;
                               " AND a.dopes = b.dopes" + ;
                               " AND b.cupfis IN (1,3)"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Selecao2")

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel consultar os cupons do per" + CHR(237) + "odo:" + ;
                            CHR(13) + CapturarErroSQL()
                    ELSE
                        SELECT cursor_4c_Selecao2
                        INDEX ON empdopnums TAG empdopnums

                        *-- 3) cursor da grade: estrutura IDENTICA ao Create Cursor
                        *-- Transacao do legado (nomes lidos por CarregarDoCursor)
                        IF USED("cursor_4c_Transacao")
                            SELECT cursor_4c_Transacao
                            ZAP
                        ELSE
                            CREATE CURSOR cursor_4c_Transacao ( ;
                                cDopes     C(20), ;
                                cnCupoms   C(10), ;
                                ccupomnvs  C(20), ;
                                cnnsus     C(12), ;
                                cnvalors   N(12,2), ;
                                cndttrans  D, ;
                                CnHrTrans  C(8), ;
                                cStatus    C(3), ;
                                FPags      C(12), ;
                                lCancel    L, ;
                                CupFis     N(1), ;
                                EmpdopNums C(29), ;
                                cnIdents   C(10))
                            INDEX ON cndttrans TAG Datas
                        ENDIF

                        SELECT cursor_4c_Selecao
                        SCAN
                            loc_cHora    = TRANSFORM(TratarNulo(cnhrtrans, ""), "@R xx:xx:xx")
                            loc_nValor   = ROUND(VAL(STRTRAN(TratarNulo(cnvalors, ""), ",", "")) / 100, 2)
                            loc_cNsu     = SUBSTR(TratarNulo(cnnsus, ""), 1, 12)
                            loc_cDataTxt = TratarNulo(cndttrans, "")

                            *-- cndttrans eh char DDMMYYYY. O legado monta a string
                            *-- dd/mm/aaaa e chama CTOD; o DATE(a,m,d) abaixo produz
                            *-- a MESMA data sem depender do SET DATE em vigor.
                            IF LEN(ALLTRIM(loc_cDataTxt)) >= 8
                                loc_dTrans = DATE(VAL(RIGHT(ALLTRIM(loc_cDataTxt), 4)), ;
                                                  VAL(SUBSTR(loc_cDataTxt, 3, 2)), ;
                                                  VAL(SUBSTR(loc_cDataTxt, 1, 2)))
                            ELSE
                                loc_dTrans = {}
                            ENDIF

                            *-- chave POSICIONAL de 29 chars (regra #42)
                            loc_cChave = PADR(TratarNulo(cemps, ""), 3) + ;
                                         PADR(TratarNulo(cdopes, ""), 20) + ;
                                         STR(VAL(TratarNulo(cncupoms, "")), 6)

                            loc_cNotas  = ""
                            loc_nCupFis = 0
                            loc_cEmpDop = ""

                            *-- O legado faz =Seek(...) e le Selecao2 SEM testar
                            *-- FOUND(): nao achando, a leitura cai em EOF e traz
                            *-- vazio. O IF abaixo produz o MESMO resultado sem ler
                            *-- registro inexistente.
                            IF SEEK(loc_cChave, "cursor_4c_Selecao2", "empdopnums")
                                loc_cNotas  = TratarNulo(cursor_4c_Selecao2.notas, "")
                                loc_nCupFis = TratarNulo(cursor_4c_Selecao2.cupfis, 0)
                                loc_cEmpDop = TratarNulo(cursor_4c_Selecao2.empdopnums, "")
                            ENDIF

                            INSERT INTO cursor_4c_Transacao ( ;
                                cDopes, cnCupoms, ccupomnvs, cnnsus, cnvalors, ;
                                cndttrans, CnHrTrans, cStatus, FPags, lCancel, ;
                                CupFis, EmpdopNums, cnIdents) ;
                            VALUES ( ;
                                TratarNulo(cursor_4c_Selecao.cdopes, ""), ;
                                loc_cNotas, ;
                                TratarNulo(cursor_4c_Selecao.ccupomnvs, ""), ;
                                loc_cNsu, ;
                                loc_nValor, ;
                                loc_dTrans, ;
                                loc_cHora, ;
                                TratarNulo(cursor_4c_Selecao.cstatus, ""), ;
                                TratarNulo(cursor_4c_Selecao.fpags, ""), ;
                                (ALLTRIM(TratarNulo(cursor_4c_Selecao.cstatus, "")) == "CNC"), ;
                                loc_nCupFis, ;
                                loc_cEmpDop, ;
                                TratarNulo(cursor_4c_Selecao.cnidents, ""))
                        ENDSCAN

                        IF USED("cursor_4c_Selecao")
                            USE IN cursor_4c_Selecao
                        ENDIF
                        IF USED("cursor_4c_Selecao2")
                            USE IN cursor_4c_Selecao2
                        ENDIF

                        *-- Legado: Select Transacao / Go Bott (a ultima transacao
                        *-- do periodo fica selecionada ao abrir a tela)
                        SELECT cursor_4c_Transacao
                        IF RECCOUNT("cursor_4c_Transacao") > 0
                            GO BOTTOM
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        IF !loc_lSucesso AND !EMPTY(THIS.this_cMensagemErro)
            MsgErro(THIS.this_cMensagemErro, "Transa" + CHR(231) + CHR(245) + "es TEF")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

