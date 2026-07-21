# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 156: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 192: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprrcu.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (619 linhas total):

*-- Linhas 95 a 162:
95:     PROTECTED PROCEDURE ConfigurarPageFrame()
96:         THIS.AddObject("cnt_4c_Sombra", "Container")
97:         WITH THIS.cnt_4c_Sombra
98:             .Top         = 0
99:             .Left        = 0
100:             .Width       = THIS.Width
101:             .Height      = 80
102:             .BorderWidth = 0
103:             .BackStyle   = 1
104:             .BackColor   = RGB(100, 100, 100)
105:             .Visible     = .T.
106:         ENDWITH
107: 
108:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
109:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
110:             .Top       = 18
111:             .Left      = 10
112:             .Width     = THIS.Width - 20
113:             .Height    = 40
114:             .AutoSize  = .F.
115:             .BackStyle = 0
116:             .FontName  = "Tahoma"
117:             .FontSize  = 18
118:             .FontBold  = .T.
119:             .ForeColor = RGB(0, 0, 0)
120:             .Caption   = THIS.Caption
121:             .WordWrap  = .T.
122:         ENDWITH
123: 
124:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
125:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
126:             .Top       = 17
127:             .Left      = 10
128:             .Width     = THIS.Width - 20
129:             .Height    = 46
130:             .AutoSize  = .F.
131:             .BackStyle = 0
132:             .FontName  = "Tahoma"
133:             .FontSize  = 18
134:             .FontBold  = .T.
135:             .ForeColor = RGB(255, 255, 255)
136:             .Caption   = THIS.Caption
137:             .WordWrap  = .T.
138:         ENDWITH
139:     ENDPROC
140: 
141:     *==========================================================================
142:     * ConfigurarPaginaLista - Botoes de acao (Processar e Encerrar) + Shape decorativo
143:     * OPERACIONAL: sem paginas CRUD, controles direto no form
144:     *==========================================================================
145:     PROTECTED PROCEDURE ConfigurarPaginaLista()
146:         *-- Botao Processar (legado: OK - Left=430)
147:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
148:         WITH THIS.cmd_4c_Processar
149:             .Top             = 3
150:             .Left            = 430
151:             .Width           = 75
152:             .Height          = 75
153:             .Caption         = "Processar"
154:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
155:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
156:             .FontName        = "Comic Sans MS"
157:             .FontSize        = 8
158:             .FontBold        = .T.
159:             .FontItalic      = .T.
160:             .ForeColor       = RGB(90, 90, 90)
161:             .BackColor       = RGB(255, 255, 255)
162:             .Themes          = .T.

*-- Linhas 169 a 198:
169:         *-- Shape decorativo ao redor do botao Encerrar (legado: Shape1 - Top=-5, Left=498)
170:         THIS.AddObject("shp_4c_Shape1", "Shape")
171:         WITH THIS.shp_4c_Shape1
172:             .Top         = -5
173:             .Left        = 498
174:             .Width       = 90
175:             .Height      = 110
176:             .BackStyle   = 0
177:             .BorderStyle = 0
178:             .BorderColor = RGB(136, 189, 188)
179:         ENDWITH
180: 
181:         *-- Botao Encerrar (legado: SAIR - Left=505)
182:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
183:         WITH THIS.cmd_4c_Encerrar
184:             .Top             = 3
185:             .Left            = 505
186:             .Width           = 75
187:             .Height          = 75
188:             .Caption         = "Encerrar"
189:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
190:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
191:             .Cancel          = .T.
192:             .FontName        = "Comic Sans MS"
193:             .FontSize        = 8
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .ForeColor       = RGB(90, 90, 90)
197:             .BackColor       = RGB(255, 255, 255)
198:             .Themes          = .T.

*-- Linhas 214 a 244:
214:         *-- Container do painel de status (agrupa area de dados dinamicos)
215:         THIS.AddObject("cnt_4c_Dados", "Container")
216:         WITH THIS.cnt_4c_Dados
217:             .Top         = 100
218:             .Left        = 0
219:             .Width       = THIS.Width
220:             .Height      = 40
221:             .BorderWidth = 0
222:             .BackStyle   = 0
223:             .Visible     = .T.
224:         ENDWITH
225: 
226:         *-- Label de status (animacao de progresso durante processamento)
227:         THIS.cnt_4c_Dados.AddObject("lbl_4c_Status", "Label")
228:         WITH THIS.cnt_4c_Dados.lbl_4c_Status
229:             .Top       = 8
230:             .Left      = 129
231:             .Width     = 321
232:             .Height    = 16
233:             .AutoSize  = .F.
234:             .BackStyle = 0
235:             .FontName  = "Tahoma"
236:             .FontSize  = 8
237:             .FontBold  = .F.
238:             .ForeColor = RGB(90, 90, 90)
239:             .Caption   = ""
240:             .Alignment = 0
241:         ENDWITH
242:     ENDPROC
243: 
244:     *==========================================================================

*-- Linhas 264 a 273:
264:     * ConfigurarBINDEVENTs - Vincula Click dos botoes aos handlers
265:     *==========================================================================
266:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
267:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
268:         BINDEVENT(THIS.cmd_4c_Encerrar,  "Click", THIS, "CmdEncerrarClick")
269:     ENDPROC
270: 
271:     *==========================================================================
272:     * AlternarPagina - Alterna estado operacional do form
273:     * OPERACIONAL sem PageFrame: alterna entre IDLE e PROCESSANDO ajustando

*-- Linhas 280 a 302:
280: 
281:         DO CASE
282:             CASE loc_cEstado = "PROCESSANDO"
283:                 THIS.cmd_4c_Processar.Enabled = .F.
284:                 THIS.cmd_4c_Encerrar.Enabled  = .F.
285:                 THIS.this_lProcessando        = .T.
286: 
287:             CASE loc_cEstado = "AGUARDANDO"
288:                 *-- Entre ciclos de scan: usuario pode interromper com ESC
289:                 THIS.cmd_4c_Processar.Enabled = .F.
290:                 THIS.cmd_4c_Encerrar.Enabled  = .T.
291:                 THIS.this_lProcessando        = .T.
292: 
293:             CASE loc_cEstado = "IDLE"
294:                 THIS.cmd_4c_Processar.Enabled = .T.
295:                 THIS.cmd_4c_Encerrar.Enabled  = .T.
296:                 THIS.this_lProcessando        = .F.
297:                 THIS.cnt_4c_Dados.lbl_4c_Status.Caption    = ""
298:         ENDCASE
299: 
300:         THIS.Refresh()
301:     ENDPROC
302: 

*-- Linhas 328 a 338:
328:         SET CURSOR OFF
329: 
330:         DO WHILE .T.
331:             THIS.cmd_4c_Encerrar.Enabled = .F.
332: 
333:             THIS.cnt_4c_Dados.lbl_4c_Status.Caption = "Aguardando Produtos Para Processar" + REPLICATE(".", loc_nMov)
334:             THIS.Refresh()
335:             loc_nMov = IIF(loc_nMov < 5, loc_nMov + 1, 1)
336: 
337:             *-- Busca proximos itens da fila SigOpClC
338:             loc_lOk = THIS.this_oBusinessObject.BuscarProdutosPendentes(gnConnHandle)

*-- Linhas 567 a 595:
567: 
568:         DO CASE
569:             CASE loc_cModo = "PROCESSANDO"
570:                 THIS.cmd_4c_Processar.Enabled = .F.
571:                 THIS.cmd_4c_Encerrar.Enabled  = .F.
572: 
573:             CASE loc_cModo = "AGUARDANDO"
574:                 THIS.cmd_4c_Processar.Enabled = .F.
575:                 THIS.cmd_4c_Encerrar.Enabled  = .T.
576: 
577:             OTHERWISE
578:                 THIS.cmd_4c_Processar.Enabled = .T.
579:                 THIS.cmd_4c_Encerrar.Enabled  = .T.
580:         ENDCASE
581:     ENDPROC
582: 
583:     *==========================================================================
584:     * LimparCampos - Limpa mensagem de status e reseta estado interno
585:     * OPERACIONAL: sem campos de dados editaveis
586:     *==========================================================================
587:     PROCEDURE LimparCampos()
588:         IF VARTYPE(THIS.cnt_4c_Dados) = "O"
589:             IF VARTYPE(THIS.cnt_4c_Dados.lbl_4c_Status) = "O"
590:                 THIS.cnt_4c_Dados.lbl_4c_Status.Caption = ""
591:             ENDIF
592:         ENDIF
593:         THIS.this_lProcessando  = .F.
594:         THIS.this_cMensagemErro = ""
595:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigprrcuBO.prg):
*==============================================================================
* sigprrcuBO.prg - Business Object: Recalculo de Custos de Produto
* Herda de: BusinessBase
* Tabela principal: SigOpClC (fila de recalculo de custos em lote)
*==============================================================================
DEFINE CLASS sigprrcuBO AS BusinessBase

    *-- Estado do processamento
    this_lParametrizado = .F.    && .T. quando acionado via Fortyus.Exe
    this_lErroConexao   = .F.    && .T. se houve queda de conexao durante o loop
    this_lProcessando   = .F.    && .T. enquanto loop de processamento esta ativo
    this_cArquivoLog    = ""     && Caminho do arquivo de log (Fortyus.Log)
    this_nContadorAnima = 0      && Contador de animacao dos pontos no label de status

    *-- Campos de SigOpClC
    this_cCidChave  = ""    && CidChaves PK (uniqueidentifier)
    this_cEmps      = ""    && Empresa
    this_cCpros     = ""    && Codigo do Produto
    this_dDatas     = {}    && Data de referencia
    this_cUsuars    = ""    && Usuario que enfileirou
    this_cEmpCpros  = ""    && Emps + Cpros (chave de ordenacao)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpClC"
        THIS.this_cCampoChave = "CidChaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChave
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChave  = TratarNulo(CidChaves, "C")
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            THIS.this_cCpros     = TratarNulo(Cpros,     "C")
            THIS.this_dDatas     = TratarNulo(Datas,     "D")
            THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
            THIS.this_cEmpCpros  = TratarNulo(EmpCpros,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cCpros)
                THIS.this_cMensagemErro = "Empresa e produto s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
            ELSE
                THIS.this_cEmpCpros = RTRIM(THIS.this_cEmps) + RTRIM(THIS.this_cCpros)

                loc_cSQL = "INSERT INTO SigOpClC (CidChaves, Emps, Cpros, Datas, Usuars, EmpCpros) VALUES (" + ;
                           "NEWID(), " + ;
                           EscaparSQL(THIS.this_cEmps) + ", " + ;
                           EscaparSQL(THIS.this_cCpros) + ", " + ;
                           FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(THIS.this_cEmpCpros) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao inserir item na fila de recalculo."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChave)
                THIS.this_cMensagemErro = "Chave n" + CHR(227) + "o informada para atualiza" + CHR(231) + CHR(227) + "o."
            ELSE
                loc_cSQL = "UPDATE SigOpClC SET Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                           " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChave)

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("ATUALIZAR")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar item na fila de recalculo."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Carrega itens da fila SigOpClC em cursor local (CrSigOpClC) para recalculo
    * par_nHandle: handle de conexao SQL (da transacao ativa do form)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutosPendentes(par_nHandle)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF USED("CrSigOpClC")
                USE IN CrSigOpClC
            ENDIF
            loc_cSQL = "SELECT 0 AS Flag, * FROM SigOpClC ORDER BY EmpCpros"
            loc_nRet = SQLEXEC(par_nHandle, loc_cSQL, "CrSigOpClC")
            loc_lSucesso = (loc_nRet > 0)

            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao buscar produtos pendentes."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarEmProcessamento - UPDATE SigOpClC para criar lock transacional
    * par_nHandle:   handle de conexao (transacao ativa)
    * par_cCidChave: CidChaves do item a marcar
    * Retorna: 1 sucesso | 0 falha | -3 queda de conexao
    *--------------------------------------------------------------------------
    PROCEDURE MarcarEmProcessamento(par_nHandle, par_cCidChave)
        LOCAL loc_cSQL, loc_nRet
        loc_cSQL = "UPDATE SigOpClC SET Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                   " WHERE CidChaves = " + EscaparSQL(par_cCidChave)
        loc_nRet = SQLEXEC(par_nHandle, loc_cSQL)
        RETURN loc_nRet
    ENDPROC

    *--------------------------------------------------------------------------
    * RemoverDaFila - DELETE FROM SigOpClC apos processamento bem-sucedido
    * par_nHandle:   handle de conexao (transacao ativa)
    * par_cCidChave: CidChaves do item processado
    *--------------------------------------------------------------------------
    PROCEDURE RemoverDaFila(par_nHandle, par_cCidChave)
        LOCAL loc_cSQL, loc_nRet
        loc_cSQL = "DELETE FROM SigOpClC WHERE CidChaves = " + EscaparSQL(par_cCidChave)
        loc_nRet = SQLEXEC(par_nHandle, loc_cSQL)
        RETURN (loc_nRet > 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarRecalculo - Chama fRecalculaC para recalcular custo do produto
    * par_cEmps:  empresa (usa go_4c_Sistema.cCodEmpresa se vazio)
    * par_cCpros: codigo do produto
    * par_dDatas: data de referencia
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarRecalculo(par_cEmps, par_cCpros, par_dDatas)
        LOCAL loc_lSucesso, loc_oErro, loc_cEmps
        loc_lSucesso = .F.

        TRY
            loc_cEmps = IIF(EMPTY(par_cEmps), go_4c_Sistema.cCodEmpresa, par_cEmps)

            loc_lSucesso = fRecalculaC(loc_cEmps, par_cCpros, par_dDatas)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarRecalculoFinal - Segunda chamada de fRecalculaC (commit calculo)
    * par_nHandle: handle de conexao da transacao ativa
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarRecalculoFinal(par_nHandle)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = fRecalculaC(.T., .T., .F., par_nHandle, .T.)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarLog - Escreve cabecalho no arquivo Fortyus.Log
    *--------------------------------------------------------------------------
    PROCEDURE IniciarLog()
        LOCAL loc_cLinha

        THIS.this_cArquivoLog = "Fortyus.Log"
        STRTOFILE("", THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Iniciando o Processamento : Fortyus.Exe (SigOpClC) - Recalculo de Custos"
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConcluirLog - Escreve rodape no arquivo Fortyus.Log
    *--------------------------------------------------------------------------
    PROCEDURE ConcluirLog()
        LOCAL loc_cLinha

        STRTOFILE("", THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Concluindo o Processamento : Prod2005.Exe (SigOpClC) - Recalculo de Custos"
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarEntradaLog - Escreve uma linha no arquivo de log
    *--------------------------------------------------------------------------
    PROCEDURE GravarEntradaLog(par_cMensagem)
        IF !EMPTY(THIS.this_cArquivoLog)
            STRTOFILE(par_cMensagem + CHR(10), THIS.this_cArquivoLog, .T.)
        ENDIF
    ENDPROC

ENDDEFINE

