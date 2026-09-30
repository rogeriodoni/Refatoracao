# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, TIPOCAMPO, PROXIMOCOMANDO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABINDEX' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNRETORNO, NSHIFTALTCTRL, LLONERRO1, FPAGS, CEMPS, TIPOCAMPO, PROXIMOCOMANDO

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg) - TRECHOS RELEVANTES PARA PASS SQL (2145 linhas total):

*-- Linhas 13 a 38:
13: * checagem de nome feita por substring:
14: *   - Carregar...Lista / Ajustar...PorModo: nao ha lista nem grade. O dump nao
15: *     tem BaseClass grid nem pageframe, nao tem AddCursor/pColuna, e o
16: *     comportamento.json so registra INSERT no cursor VFP local crSiTef (buffer
17: *     do protocolo, nao exibicao). Tambem nao ha modo: sem pcEscolha, sem
18: *     Grupo_Op, sem Page1/Page2.
19: *   - Btn...Salvar...Click / Btn...Confirmar...Click: nao ha botao de gravar. O
20: *     SCX declara UM unico CommandGroup (SAIDA, ButtonCount = 1, membro interno
21: *     CANCELA, Caption "\<Cancelar"). O que esta tela "grava" sao os arquivos
22: *     SDF de retorno (MontaRetorno/RetornoFalha), disparados pelo protocolo, e
23: *     a string de retorno do Unload - nao ha INSERT/UPDATE em tabela nenhuma.
24: *   - Habilitar...Campos / Limpar...Campos: o legado liga e desliga cada
25: *     controle no PONTO do protocolo em que o SiTef pede aquele dado
26: *     (GetDigitos.GotFocus, Text1.LostFocus, Optiongroup1.InteractiveChange,
27: *     GetDatas.GotFocus...), nao por modo de edicao. Concentrar isso num metodo
28: *     unico inverteria a ordem das habilitacoes e quebraria a negociacao com o
29: *     terminal.
30: *   - Btn...Encerrar...Click / Btn...Buscar...Click: nao existem no SCX. O unico
31: *     botao eh o Cancelar, migrado em BtnCancelarClick.
32: * FormParaBO/BOParaForm EXISTEM e sao reais: os seis campos de captura sao a
33: * ficha desta tela e o BO ja declarava as properties correspondentes.
34: *------------------------------------------------------------------------------
35: 
36: DEFINE CLASS Formsigprdft AS FormBase
37: 
38:     Height      = 370

*-- Linhas 175 a 193:
175: 
176:                 *-- Transfere os parametros recebidos no Init para o BO e busca
177:                 *-- SigOpFp/sigcdemp/SIGFIMPF (migrado de SIGPRDFT.Init WITH
178:                 *-- Thisform / .poDatamgr.SqlExecute ...). Pulado em modo de
179:                 *-- teste headless (sem gnConnHandle real).
180:                 IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
181:                     THIS.this_oBusinessObject.this_cEndSiTef = THIS.this_cEndSiTef
182:                     THIS.this_oBusinessObject.this_nValPago  = THIS.this_nValPago
183:                     THIS.this_oBusinessObject.this_cCupom    = THIS.this_cCupom
184:                     THIS.this_oBusinessObject.this_cCaixa    = THIS.this_cCaixa
185:                     THIS.this_oBusinessObject.this_cDebCred  = THIS.this_cDebCred
186:                     THIS.this_oBusinessObject.this_cTipPagto = THIS.this_cTipPagto
187:                     THIS.this_oBusinessObject.this_nNumParcs = THIS.this_nNumParcs
188:                     THIS.this_oBusinessObject.this_cIdent    = THIS.this_cIdent
189:                     THIS.this_oBusinessObject.this_cOpers    = THIS.this_cOpers
190: 
191:                     THIS.this_oBusinessObject.CarregarParametrosOperacao()
192:                 ENDIF
193: 

*-- Linhas 750 a 788:
750:             IF USED("crSiTef")
751:                 USE IN crSiTef
752:             ENDIF
753:             CREATE CURSOR crSiTef (tef c(100))
754: 
755:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
756:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
757:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
758:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
759:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
760:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
761:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
762:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
763:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
764:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
765:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
766: 
767:             SELECT crSiTef
768:             COPY TO C:\client\Resp\IntPos.001 SDF
769:             ZAP
770: 
771:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
772:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
773:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
774: 
775:             COPY TO C:\client\Resp\IntPos.STS SDF
776: 
777:             USE IN crSiTef
778:         CATCH TO loc_oErro
779:             MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
780:         ENDTRY
781:     ENDPROC
782: 
783:     *--------------------------------------------------------------------------
784:     * MontaRetorno - migrado de SIGPRDFT.montaretorno. Grava os mesmos
785:     * arquivos SDF de RetornoFalha, com os dados COMPLETOS da transacao
786:     * aprovada. Nota fiel ao legado: o 6o parametro recebido eh lsNsu (nao
787:     * lsAutoriza) no unico call-site sem autorizacao capturada - ver
788:     * DigitosGotFocus, onde o legado passa "lsNsu, lsNSU" (mesma variavel,

*-- Linhas 821 a 884:
821:             IF USED("crSiTef")
822:                 USE IN crSiTef
823:             ENDIF
824:             CREATE CURSOR crSiTef (tef c(100))
825: 
826:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
827:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
828:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
829:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
830:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
831:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
832:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(loc_cLsCartao) + 1])
833:             INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_cTipTran)
834:             INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_cNsu)
835:             INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_cAutoriza)
836:             INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + SUBSTR(par_cDataHora, 7, 2) + SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 9, 6))
837:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
838:             INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + THIS.txt_4c_Text1.Value)
839:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
840:             INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
841:             INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
842:             INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
843:             INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + SUBSTR(par_cDataHora, 7, 2) + SUBSTR(par_cDataHora, 5, 2) + SUBSTR(par_cDataHora, 1, 4))
844:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_cDataHora, 9, 6))
845:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_cFinaliza)
846:             INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_cDataHora, 9, 6))
847: 
848:             loc_cCupomRestante = par_cCupom
849:             loc_nPos   = 1
850:             loc_nLinha = 1
851:             DO WHILE loc_nPos != 0
852:                 loc_nPos = AT(CHR(10), loc_cCupomRestante)
853:                 INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
854:                     IIF(loc_nPos != 0, SUBSTR(loc_cCupomRestante, 1, loc_nPos - 1), loc_cCupomRestante))
855:                 loc_cCupomRestante = SUBSTR(loc_cCupomRestante, loc_nPos + 1)
856:                 loc_nLinha = loc_nLinha + 1
857:             ENDDO
858:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
859:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_cMenRet)
860:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
861:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
862: 
863:             SELECT crSiTef
864:             COPY TO C:\client\Resp\IntPos.001 SDF
865:             ZAP
866: 
867:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
868:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
869:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
870: 
871:             COPY TO C:\client\Resp\IntPos.STS SDF
872: 
873:             USE IN crSiTef
874: 
875:             THIS.this_oBusinessObject.this_lTransacaoOk = .T.
876:         CATCH TO loc_oErro
877:             MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
878:         ENDTRY
879:     ENDPROC
880: 
881:     *==========================================================================
882:     * VALIDACOES DE CAMPO
883:     *
884:     * O SCX legado nao tem lookup algum (zero fwBuscaExt / fwBuscaSel /


### BO (C:\4c\projeto\app\classes\sigprdftBO.prg):
*==============================================================================
* SIGPRDFTBO.PRG
* Business Object - Integracao com terminal SiTef (pagamento em cartao de debito)
* Origem: SIGPRDFT.scx (form legado, sem tabela propria - integracao com DLL SiTef)
*==============================================================================

DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Parametros de entrada recebidos do form/tela chamadora (Init original)
    this_cEndSiTef = ""             && Endereco do servidor SiTef (EndSiTef)
    this_nValPago = 0               && Valor a ser pago na transacao (ValPago)
    this_cCupom = ""                && Numero do cupom fiscal (Cupom)
    this_cCaixa = ""                && Identificacao do caixa/PDV (Caixa)
    this_cDebCred = ""              && Indicador Debito/Credito (DebCred)
    this_cTipPagto = ""             && Tipo de pagamento (TipPagto)
    this_nNumParcs = 0              && Numero de parcelas informado na chamada (NumParcs)
    this_cIdent = ""                && Identificador da transacao (lcIdent)
    this_cOpers = ""                && Operador responsavel (pcOpers)

    *-- Campos digitados na tela (mapeados dos controles GetValor/GetDigitos/GetCartao/etc)
    this_nValor = 0                 && GetValor.Value - valor da transacao
    this_cDigitos = ""              && GetDigitos.Value - 4 ultimos digitos do cartao
    this_cCartao = ""               && GetCartao.Value - numero do cartao lido/digitado
    this_cBandeira = "00000"        && ThisForm.pcBandeira - bandeira do cartao
    this_nTipoVenda = 1             && Optiongroup1.Value - 1=A Vista, 2=Parcelado
    this_nParcelas = 0              && Text1.Value - numero de parcelas
    this_dDataParc = {}             && GetDatas.Value - data da 1a parcela/vencimento

    *-- Dados de retorno da transacao TEF (preenchidos apos comunicacao com o PIN-PAD)
    this_cTipoTransacao = ""        && lsTipTran - tipo de transacao retornado pelo SiTef
    this_cDataHoraTef = ""          && lsDataHora - data/hora da transacao no SiTef
    this_cCupomTef = ""             && lsCupom - cupom retornado pelo SiTef
    this_cCartaoTef = ""            && lsCartao - numero de cartao mascarado retornado
    this_cNsu = ""                  && lsNsu - Numero Sequencial Unico da transacao
    this_cAutorizacao = ""          && lsAutoriza - codigo de autorizacao
    this_cFinalizacao = ""          && lsFinaliza - codigo de finalizacao da transacao
    this_cMensagemRetorno = ""      && MenRet - mensagem de retorno do SiTef

    *-- Controle de fluxo/protocolo SiTef
    this_nProximoComando = 0        && ProximoComando - protocolo ContinuaFuncaoSiTefInterativo
    this_nTipoCampo = 0             && TipoCampo
    this_nTamanhoMinimo = 0         && TamanhoMinimo
    this_nTamanhoMaximo = 0         && TamanhoMaximo
    this_cBuffer = ""               && Buffer - buffer de comunicacao com o SiTef
    this_nContinua = 0              && lnContinua
    this_lCancela = .F.             && llCancela - indica cancelamento da operacao
    this_lAbandona = .F.            && ThisForm.abandona - indica abandono da tela
    this_lKeyEsc = .T.              && ThisForm.pckeyesc - habilita ESC para cancelar
    this_lTransacaoOk = .F.         && Indica se a transacao foi concluida com sucesso

    *-- Parametros consultados na operacao de pagamento (SigOpFp/sigcdemp/SIGFIMPF)
    this_lOpFpCartao = .F.          && SigOpFp.lcartao = "S" - forma aceita cartao
    this_lOpFpSaque = .F.           && SigOpFp.lsaque = "S" - permite saque
    this_cOpFpTcdc = "N"            && SigOpFp.tcdc - indica consulta CDC
    this_lOpFpGarantias = .F.       && SigOpFp.garantias = "S"
    this_nOpFpDias = 0              && SigOpFp.dias
    this_nOpFpMesFec = 0            && SigOpFp.mesfec
    this_cIdTerminal = ""           && Empresa+caixa enviado ao SiTef (ConfiguraInt*)

    *-- Estado auxiliar do protocolo (migrado de variaveis PUBLIC/PRIVATE do form legado)
    this_lDataConfirmada = .F.      && DCD - .T. apos ProximoComando=21 confirmar data
    this_cCartaoAux = ""            && ThisForm.lsCartao (legado) - Left(Buffer,5) em TipoCampo=131
    this_cValorSaque = "0,00"       && lcSaque - valor de saque (sub-dialogo SigCsTef nao portado)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Este BO nao possui tabela propria: eh uma integracao com o terminal SiTef
    * (DLL CliSiTef32I.DLL), portanto this_cTabela/this_cCampoChave ficam vazios.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.DeclararFuncoesSiTef()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das 4 funcoes do protocolo interativo
    * (migrado de SIGPRDFT.Load). Redeclarar a mesma assinatura eh inofensivo
    * em VFP9; a falha real (DLL ausente) so aparece quando a funcao eh
    * CHAMADA, nao na declaracao - por isso o TRY aqui eh so para nao derrubar
    * InicializarForm em maquina de desenvolvimento sem o CliSiTef32I.DLL.
    *==========================================================================
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

        TRY
            DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado

            DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
                STRING lsHorario, STRING lsOperador, STRING lsRestricao

            DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
                STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado

            DECLARE INTEGER FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnConfirma, STRING lsCupom, STRING lsData, STRING lsHorario
        CATCH TO loc_oErro
            *-- DLL nao presente nesta maquina (dev/teste sem PIN-pad SiTef) -
            *-- as chamadas reais avisam o usuario via ConectarSiTef/IniciarSiTef.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarParametrosOperacao - Migrado de SIGPRDFT.Init (blocos
    * SqlExecute crSigOpFp/crSigCdEmp) + GotFocus (lcIdTerminal). Le a forma de
    * pagamento (SigOpFp) pelo codigo recebido em this_cOpers e monta o
    * identificador de terminal (empresa+caixa) usado por ConectarSiTef.
    *==========================================================================
    FUNCTION CarregarParametrosOperacao()
        LOCAL loc_lSucesso, loc_oErro, loc_nEmpresa

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF
            SQLEXEC(gnConnHandle, ;
                "SELECT lcartao, lsaque, tcdc, garantias, dias, mesfec FROM SigOpFp " + ;
                "WHERE fpags = " + EscaparSQL(THIS.this_cOpers), ;
                "cursor_4c_SigOpFp")

            IF USED("cursor_4c_SigOpFp") AND !EOF("cursor_4c_SigOpFp")
                THIS.this_lOpFpCartao    = (TratarNulo(cursor_4c_SigOpFp.lcartao, "N") = "S")
                THIS.this_lOpFpSaque     = (TratarNulo(cursor_4c_SigOpFp.lsaque, "N") = "S")
                THIS.this_cOpFpTcdc      = TratarNulo(cursor_4c_SigOpFp.tcdc, "N")
                THIS.this_lOpFpGarantias = (TratarNulo(cursor_4c_SigOpFp.garantias, "N") = "S")
                THIS.this_nOpFpDias      = TratarNulo(cursor_4c_SigOpFp.dias, 0)
                THIS.this_nOpFpMesFec    = TratarNulo(cursor_4c_SigOpFp.mesfec, 0)
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF

            IF loc_lSucesso
                *-- sigcdemp.codemps (numeric) equivale ao SigCdEmp.nEmps legado;
                *-- sigcdemp.cemps (char) eh a chave usada no filtro por empresa.
                IF USED("cursor_4c_SigCdEmpTef")
                    USE IN cursor_4c_SigCdEmpTef
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codemps FROM sigcdemp WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_SigCdEmpTef")

                loc_nEmpresa = 0
                IF USED("cursor_4c_SigCdEmpTef") AND !EOF("cursor_4c_SigCdEmpTef")
                    loc_nEmpresa = TratarNulo(cursor_4c_SigCdEmpTef.codemps, 0)
                ENDIF
                IF USED("cursor_4c_SigCdEmpTef")
                    USE IN cursor_4c_SigCdEmpTef
                ENDIF

                *-- SIGFIMPF.cncaixas (caixa/PDV corrente) - SigFiMpF legado nao
                *-- tem equivalente de "caixa aberto" nesta migracao; melhor
                *-- esforco: 1o registro da empresa. Sem match, terminal fecha
                *-- com "000000" (mesmo fallback do legado quando nao localizado).
                IF USED("cursor_4c_SIGFIMPF")
                    USE IN cursor_4c_SIGFIMPF
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_SIGFIMPF")

                IF USED("cursor_4c_SIGFIMPF") AND !EOF("cursor_4c_SIGFIMPF")
                    THIS.this_cIdTerminal = PADL(ALLTRIM(STR(loc_nEmpresa, 5)), 5, "0") + ;
                        TRANSFORM(VAL(TratarNulo(cursor_4c_SIGFIMPF.cncaixas, "0")), "@L 999999")
                ELSE
                    THIS.this_cIdTerminal = PADL(ALLTRIM(STR(loc_nEmpresa, 5)), 5, "0") + "000000"
                ENDIF
                IF USED("cursor_4c_SIGFIMPF")
                    USE IN cursor_4c_SIGFIMPF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao carregar parametros da operacao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConectarSiTef - Migrado de SIGPRDFT.GetDigitos.GotFocus (bloco
    * ConfiguraIntSiTefInterativo). Retorna .T. se a comunicacao com o
    * servidor SiTef foi estabelecida.
    *==========================================================================
    FUNCTION ConectarSiTef()
        LOCAL loc_nRetorno

        IF EMPTY(THIS.this_cIdTerminal)
            THIS.this_cIdTerminal = "00000000000"
        ENDIF

        loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
            THIS.this_cIdTerminal, THIS.this_cIdTerminal, 0)

        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *==========================================================================
    * IniciarSiTef - Migrado de SIGPRDFT.GetDigitos.GotFocus (bloco
    * IniciaFuncaoSiTefInterativo). par_nModalidade=0 eh a unica modalidade
    * usada pelo legado (cartao de debito/credito).
    *==========================================================================
    FUNCTION IniciarSiTef(par_nModalidade, par_cValor, par_cCupom, par_cData, par_cHora)
        LOCAL loc_nRetorno

        loc_nRetorno = IniciaFuncaoSiTefInterativo(par_nModalidade, par_cValor, par_cCupom, ;
            par_cData, par_cHora, THIS.this_cCaixa, "")

        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *==========================================================================
    * ContinuarSiTef - Migrado das chamadas ContinuaFuncaoSiTefInterativo
    * espalhadas pelo legado (GetDigitos.Valid/GotFocus, GetDatas.Valid/
    * GotFocus, Text1.Valid, SAIDA.CANCELA.Click). Centraliza a chamada por
    * referencia (LOCAL -> DLL -> THIS.this_n*/this_cBuffer) porque VFP9 nao
    * garante passagem por referencia de property de objeto para DLL externa.
    *==========================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), SPACE(2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * FinalizarSiTef - Migrado de SIGPRDFT.GetDatas.Valid (bloco
    * FinalizaTransacaoSiTefInterativo, disparado ao cancelar via senha de
    * supervisor - FormSIGPRSTF).
    *==========================================================================
    FUNCTION FinalizarSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
        RETURN FinalizaTransacaoSiTefInterativo(par_nConfirma, par_cCupom, par_cData, par_cHora)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - SIGPRDFT nao tem cursor nem tabela propria. Os dados
    * digitados na tela (Valor, Digitos, Cartao, TipoVenda, Parcelas, Data)
    * sao atribuidos diretamente as properties this_n*/this_c*/this_d* pelo
    * proprio Form (FormParaBO/BOParaForm), e o retorno da transacao TEF
    * (Nsu/Autorizacao/Finalizacao/etc) vem do protocolo ContinuaFuncaoSiTef
    * Interativo via DLL, nao de um SELECT. Nao ha cursor de banco a
    * percorrer aqui - o comportamento padrao herdado de BusinessBase
    * (no-op, RETURN .T.) ja eh o correto.
    *==========================================================================

    *==========================================================================
    * ObterChavePrimaria - SIGPRDFT nao grava registro nenhum (integracao com
    * o terminal SiTef via CliSiTef32I.DLL - CREATE CURSOR crSiTef eh apenas
    * o buffer de instrucoes do protocolo TEF, nunca persistido no SQL
    * Server). Nao existe chave primaria porque nao existe tabela; retornar
    * vazio mantem RegistrarAuditoria() inofensivo (ela ja aborta quando a
    * chave vem vazia - ver BusinessBase.RegistrarAuditoria).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao: SIGPRDFT eh um dialogo de captura de
    * pagamento em cartao (SIGPRDFT.scx), sem AddCursor, sem tabela e sem SQL
    * de persistencia associados no legado (ver comportamento.json: as unicas
    * queries SQL sao INSERT INTO crSiTef, um cursor LOCAL de memoria usado
    * so para montar o buffer do protocolo ContinuaFuncaoSiTefInterativo, e
    * nunca chega a SQLEXEC/SQL Server). O comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto - nao ha necessidade
    * de sobrescrever esses tres metodos aqui, e RegistrarAuditoria() nunca
    * roda porque Inserir/Atualizar/ExecutarExclusao nunca sao chamados.
    *==========================================================================

ENDDEFINE

