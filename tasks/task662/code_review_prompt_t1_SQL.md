# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, TIPOCAMPO

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
INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("011-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("012-000 = "+lsNSU)
INSERT INTO crSiTef (Tef) VALUES ("013-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("015-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("022-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("027-000 = ")
	INSERT INTO crSiTef (Tef) VALUES ("029-"+TRANSFORM(lnLinha,"@L 999")+" = "+IIF(lsPos<>0,SUBSTR(lsCupom,1,lsPos-1),lsCupom))
INSERT INTO crSiTef (Tef) VALUES ("028-000 = "+ALLTRIM(STR(lnLinha-2)))
INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
INSERT INTO crSiTef (Tef) VALUES ("030-000 = "+lcMensagem)
INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
SELECT crSitef 
INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
		.AddCursor('SigCdEmp','cEmps','crSigCdEmp','cEmps',.f.,[Select * From SigCdEmp Where cEmps = ?_Empr])

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigproer.prg) - TRECHOS RELEVANTES PARA PASS SQL (1246 linhas total):

*-- Linhas 136 a 154:
136: *   violaria o PILAR 1; metodo vazio eh stub, proibido pela regra de
137: *   completude). SIGPROER eh dialogo de PROTOCOLO: conversa com o PIN-pad
138: *   por DLL declarada no proprio SCX, tem UM unico botao (SAIDA/CANCELA),
139: *   zero Grid/PageFrame/AddCursor-de-grade e zero INSERT/UPDATE/DELETE em
140: *   tabela.
141: *     CarregarLista      - nao ha grade nem cursor de listagem.
142: *     BtnSalvarClick     - nao ha botao de gravar; o resultado da tela sai
143: *                          pelos arquivos de resposta do SiTef
144: *                          (MontarRetorno / RetornoFalha), nao por SQL.
145: *     BtnBuscarClick     - nao ha busca nem lookup (ver FASE 6).
146: *     BtnEncerrarClick   - o unico botao do SCX eh o Cancelar, ja entregue
147: *                          como BtnCancelarClick (FASE 7); renomear faria
148: *                          o nome MENTIR sobre o que o metodo faz.
149: *     HabilitarCampos /
150: *     LimparCampos /
151: *     AjustarBotoesPorModo - nao ha Page1/Page2, nem modo CRUD
152: *                          (INCLUIR/ALTERAR/VISUALIZAR): o dialogo vive um
153: *                          unico estado, do Init ao Release.
154: *==============================================================================

*-- Linhas 1127 a 1192:
1127:             IF USED("crSiTef")
1128:                 USE IN crSiTef
1129:             ENDIF
1130:             CREATE CURSOR crSiTef (tef c(100))
1131: 
1132:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1133:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1134:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1135:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
1136:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1137:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
1138:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = ")
1139:             INSERT INTO crSiTef (Tef) VALUES ("011-000 = ")
1140:             INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + THIS.this_cNSU)
1141:             INSERT INTO crSiTef (Tef) VALUES ("013-000 = ")
1142:             INSERT INTO crSiTef (Tef) VALUES ("015-000 = ")
1143:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
1144:             INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
1145:             INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
1146:             INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
1147:             INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
1148:             INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
1149:             INSERT INTO crSiTef (Tef) VALUES ("022-000 = ")
1150:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
1151:             INSERT INTO crSiTef (Tef) VALUES ("023-000 = ")
1152:             INSERT INTO crSiTef (Tef) VALUES ("027-000 = ")
1153: 
1154:             *-- Quebra o cupom em linhas "029-NNN", uma por CHR(10)
1155:             loc_nPos   = 1
1156:             loc_nLinha = 1
1157:             DO WHILE loc_nPos <> 0
1158:                 loc_nPos = AT(CHR(10), loc_cCupom)
1159:                 INSERT INTO crSiTef (Tef) VALUES ;
1160:                     ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
1161:                      IIF(loc_nPos <> 0, SUBSTR(loc_cCupom, 1, loc_nPos - 1), loc_cCupom))
1162:                 loc_cCupom = SUBSTR(loc_cCupom, loc_nPos + 1)
1163:                 loc_nLinha = loc_nLinha + 1
1164:             ENDDO
1165: 
1166:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
1167:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
1168:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
1169:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1170: 
1171:             SELECT crSiTef
1172:             COPY TO C:\client\Resp\IntPos.001 SDF
1173:             ZAP
1174: 
1175:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1176:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1177:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1178: 
1179:             COPY TO C:\client\Resp\IntPos.STS SDF
1180: 
1181:             USE IN crSiTef
1182:         CATCH TO loc_oErro
1183:             MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
1184:         ENDTRY
1185:     ENDPROC
1186: 
1187:     *==================================================================
1188:     * RetornoFalha - transcricao de SIGPROER.retornofalha. Grava os mesmos
1189:     * dois arquivos SDF de MontarRetorno, com o codigo de recusa
1190:     * ("009-000 = FF" / "010-000 = 05") e a mensagem do erro.
1191:     * Pasta ausente -> gravacao pulada, sem quebrar o cancelamento.
1192:     *==================================================================

*-- Linhas 1203 a 1241:
1203:             IF USED("crSiTef")
1204:                 USE IN crSiTef
1205:             ENDIF
1206:             CREATE CURSOR crSiTef (tef c(100))
1207: 
1208:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1209:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1210:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
1211:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = ")
1212:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
1213:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
1214:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
1215:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
1216:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + loc_cMensagem)
1217:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
1218:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1219: 
1220:             SELECT crSiTef
1221:             COPY TO C:\client\Resp\IntPos.001 SDF
1222:             ZAP
1223: 
1224:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
1225:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = ")
1226:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
1227: 
1228:             COPY TO C:\client\Resp\IntPos.STS SDF
1229: 
1230:             USE IN crSiTef
1231:         CATCH TO loc_oErro
1232:             MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")
1233:         ENDTRY
1234:     ENDPROC
1235: 
1236:     *==================================================================
1237:     * Destroy
1238:     *==================================================================
1239:     PROCEDURE Destroy()
1240:         IF USED("crSiTef")
1241:             USE IN crSiTef


### BO (C:\4c\projeto\app\classes\sigproerBO.prg):
*====================================================================
* sigproerBO.prg
*
* Business Object para Formsigproer (Reimpressao do SiTef)
* Tabela: SigCdEmp (dados da empresa usados para montar o terminal SiTef)
* Herda de: BusinessBase
*
* FASE 1/8: Propriedades e Init()
* FASE 2/8: CRUD (CarregarDoCursor/CarregarPorCodigo/CarregarEmpresaAtual)
*   e protocolo SiTef (DeclararFuncoesSiTef/ReiniciarProtocoloSiTef/
*   ContinuarSiTef)
* FASE 7/8: ConectarSiTef/IniciarSiTef/MontarIdTerminal - transcricao do
*   bloco de hardware de SIGPROER.Init (ConfiguraIntSiTefInterativo +
*   IniciaFuncaoSiTefInterativo), chamado pelo Form.InicializarForm.
*====================================================================

DEFINE CLASS sigproerBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdEmp)
    this_cCemps   = ""    && cemps char(3) - PK da empresa
    this_nNumero  = 0     && nemps numeric(3,0) - usado para montar o ID do terminal SiTef

    *-- Estado do protocolo interativo SiTef (CliSiTef32I.DLL).
    *-- Migrado das variaveis PUBLIC declaradas no SIGPROER.Init legado
    *-- (ProximoComando, TipoCampo, TamanhoMinimo, TamanhoMaximo, Buffer,
    *-- lnContinua). No sistema novo viram properties do BO - PILAR 3: o
    *-- migrado nao cria variavel global nova.
    this_nProximoComando  = 0     && ProximoComando
    this_nTipoCampo       = 0     && TipoCampo
    this_nTamanhoMinimo   = 0     && TamanhoMinimo
    this_nTamanhoMaximo   = 0     && TamanhoMaximo
    this_cBuffer          = ""    && Buffer - buffer de comunicacao com o terminal
    this_nContinua        = 0     && lnContinua
    this_lSiTefDeclarado  = .F.   && .T. quando o DECLARE-DLL do protocolo funcionou

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEmp"
            THIS.this_cCampoChave = "cemps"
            THIS.DeclararFuncoesSiTef()
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigproerBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das 3 funcoes do protocolo
    * interativo, transcrito de SIGPROER.Load (as MESMAS assinaturas, na
    * mesma ordem). Redeclarar a mesma assinatura eh inofensivo em VFP9.
    * O TRY existe para nao derrubar o Init em maquina de desenvolvimento
    * sem o CliSiTef32I.DLL instalado: nesse caso this_lSiTefDeclarado fica
    * .F. e o Form avisa pelo mesmo caminho que o legado usa quando o
    * terminal nao responde (RetornoFalha "Sem comunicacao com SiTef").
    *====================================================================
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

            THIS.this_lSiTefDeclarado = .T.
        CATCH TO loc_oErro
            *-- DLL ausente nesta maquina (dev/teste sem PIN-pad SiTef).
            *-- Nao exibe dialogo aqui: o Init do BO roda dentro do
            *-- InicializarForm do Form e um modal travaria o pipeline
            *-- (CLAUDE.md regra #6). Quem avisa eh o Form, no momento em
            *-- que o usuario realmente aciona o terminal.
            THIS.this_lSiTefDeclarado = .F.
        ENDTRY
    ENDPROC

    *====================================================================
    * ReiniciarProtocoloSiTef - Zera o estado do protocolo. Transcrito do
    * bloco que abre GetSenha.GotFocus / SENHA.GotFocus no legado:
    *   ProximoComando=0 / TipoCampo=0 / TamanhoMinimo=0 /
    *   TamanhoMaximo=0 / Buffer=Replicate(Chr(0),2000) / lnContinua=0
    *====================================================================
    PROCEDURE ReiniciarProtocoloSiTef()
        THIS.this_nProximoComando = 0
        THIS.this_nTipoCampo      = 0
        THIS.this_nTamanhoMinimo  = 0
        THIS.this_nTamanhoMaximo  = 0
        THIS.this_cBuffer         = REPLICATE(CHR(0), 2000)
        THIS.this_nContinua       = 0
    ENDPROC

    *====================================================================
    * ContinuarSiTef - Centraliza as chamadas a ContinuaFuncaoSiTef
    * Interativo espalhadas pelo legado (GetSenha.GotFocus/LostFocus e
    * SENHA.GotFocus/LostFocus).
    *
    * Os 5 primeiros argumentos da DLL sao POR REFERENCIA (@) e VFP9 nao
    * aceita property de objeto em argumento @ - por isso o valor sai das
    * properties para variaveis LOCAL, a DLL eh chamada e o resultado
    * volta para as properties. Mesma tecnica do sigprdftBO.
    *
    * PUBLIC (sem PROTECTED): o Form chama de fora (CLAUDE.md regra #51).
    *====================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), REPLICATE(CHR(0), 2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *====================================================================
    * MontarIdTerminal - Monta o 3o argumento (lsTerminal) de
    * ConfiguraIntSiTefInterativo, transcrito de SIGPROER.Init:
    *   lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) + ;
    *       TRANSFORM(VAL(crSigFiMpF.Cncaixas), "@L 999999")
    *
    * fConverteStr() (SIGFUNCS.PRG) nao foi portada para esta migracao -
    * o equivalente ja adotado em sigprdftBO.CarregarParametrosOperacao
    * (mesma integracao SiTef) eh PADL(ALLTRIM(STR(valor, 5)), 5, "0");
    * mesma convencao aqui, com this_nNumero (nEmps) no lugar de codemps.
    *
    * crSigFiMpF (caixa aberto) nao tem equivalente de "caixa aberto"
    * nesta migracao - mesma ressalva de sigprdftBO: melhor esforco eh o
    * 1o registro de SIGFIMPF da empresa corrente; sem match, fallback
    * "000000" (mesmo comportamento do legado quando a caixa nao eh
    * localizada por SEEK/Requery).
    *====================================================================
    FUNCTION MontarIdTerminal()
        LOCAL loc_cCaixa, loc_oErro
        loc_cCaixa = "000000"

        TRY
            IF USED("cursor_4c_SigFiMpf")
                USE IN cursor_4c_SigFiMpf
            ENDIF

            SQLEXEC(gnConnHandle, ;
                "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                "cursor_4c_SigFiMpf")

            IF USED("cursor_4c_SigFiMpf") AND !EOF("cursor_4c_SigFiMpf")
                loc_cCaixa = TRANSFORM(VAL(TratarNulo(cursor_4c_SigFiMpf.cncaixas, "0")), "@L 999999")
            ENDIF

            IF USED("cursor_4c_SigFiMpf")
                USE IN cursor_4c_SigFiMpf
            ENDIF
        CATCH TO loc_oErro
            loc_cCaixa = "000000"
        ENDTRY

        RETURN PADL(ALLTRIM(STR(THIS.this_nNumero, 5)), 5, "0") + loc_cCaixa
    ENDFUNC

    *====================================================================
    * ConectarSiTef - migrado do bloco ConfiguraIntSiTefInterativo do
    * SIGPROER.Init. Retorna .T. quando a conexao com o servidor SiTef
    * foi estabelecida (retorno 0, igual ao legado).
    *====================================================================
    FUNCTION ConectarSiTef(par_cEndSitef, par_cLoja, par_cTerminal)
        LOCAL loc_nRetorno
        loc_nRetorno = ConfiguraIntSiTefInterativo(par_cEndSitef, par_cLoja, par_cTerminal, 0)
        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *====================================================================
    * IniciarSiTef - migrado do bloco IniciaFuncaoSiTefInterativo do
    * SIGPROER.Init:
    *   IniciaFuncaoSiTefInterativo(Iif(Empty(lsData),114,113), lcValores,
    *       "1", "", "", "", "")
    * par_nModalidade ja vem resolvido do Form (THIS.this_cDataSitef eh
    * quem decide 113/114). Retorna .T. quando o retorno eh 10000 (igual
    * ao legado).
    *====================================================================
    FUNCTION IniciarSiTef(par_nModalidade, par_cValor)
        LOCAL loc_nRetorno
        loc_nRetorno = IniciaFuncaoSiTefInterativo(par_nModalidade, par_cValor, "1", "", "", "", "")
        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCemps)
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
                THIS.this_cCemps  = TratarNulo(cemps, "C")
                THIS.this_nNumero = TratarNulo(nemps, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigproerBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega cemps/nemps de SigCdEmp pelo codigo da
    * empresa. Equivalente ao AddCursor+Requery do Init legado
    * (Select * From SigCdEmp Where cEmps = ?_Empr), usado para montar o
    * ID do terminal SiTef (lcEmp = fConverteStr(CrSigCdEmp.nEmps) e
    * lcIdTerminal = fConverteStr(CrSigCdEmp.nEmps) + ...).
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCemps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cCemps) != "C" OR EMPTY(ALLTRIM(par_cCemps))
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo da empresa n" + CHR(227) + "o informado"
            ELSE
                IF USED("cursor_4c_Emps")
                    USE IN cursor_4c_Emps
                ENDIF

                loc_cSQL = "SELECT cemps, nemps FROM SigCdEmp" + ;
                    " WHERE cemps = " + EscaparSQL(ALLTRIM(par_cCemps))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emps")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Emps") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Emps")
                ELSE
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ALLTRIM(par_cCemps)
                    MostrarErro("Erro ao carregar empresa:" + CHR(13) + CapturarErroSQL(), "sigproerBO.CarregarPorCodigo")
                ENDIF

                IF USED("cursor_4c_Emps")
                    USE IN cursor_4c_Emps
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar empresa:" + CHR(13) + loException.Message, "sigproerBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarEmpresaAtual - Carrega a empresa logada no sistema.
    * Equivalente ao filtro "Where cEmps = ?_Empr" do Init legado.
    * _EMPR eh legado - usar sempre go_4c_Sistema.cCodEmpresa (CLAUDE.md).
    *====================================================================
    PROCEDURE CarregarEmpresaAtual()
        RETURN THIS.CarregarPorCodigo(go_4c_Sistema.cCodEmpresa)
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao - Formsigproer eh a tela de
    * Reimpressao do SiTef: o Init legado so faz AddCursor+Requery
    * (leitura) de SigCdEmp para montar o ID do terminal; MontaRetorno/
    * RetornoFalha gravam arquivos de resposta do SiTef (IntPos.001/
    * IntPos.STS), nunca a tabela SigCdEmp. Nao ha INSERT/UPDATE/DELETE
    * em SigCdEmp no legado, logo o comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto.
    *====================================================================

ENDDEFINE

