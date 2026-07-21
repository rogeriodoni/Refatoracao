# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 187: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 209: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRsa.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (594 linhas total):

*-- Linhas 32 a 40:
32:     * Init - Armazena parametros ANTES de DODEFAULT (que chama InicializarForm)
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init(par_cParam, par_nPrior)
35:         THIS.Caption             = "Rec" + CHR(225) + "lculo de Saldos de Produto"
36:         THIS.this_lParametrizado = (TYPE("par_cParam") = "C")
37:         THIS.this_nPrioridade    = IIF(TYPE("par_nPrior") = "N", par_nPrior, 0)
38:         RETURN DODEFAULT()
39:     ENDPROC
40: 

*-- Linhas 99 a 145:
99:     PROTECTED PROCEDURE ConfigurarCabecalho()
100:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
101:         WITH THIS.cnt_4c_Cabecalho
102:             .Top         = 0
103:             .Left        = 0
104:             .Width       = THIS.Width
105:             .Height      = 80
106:             .BackColor   = RGB(100, 100, 100)
107:             .BackStyle   = 1
108:             .BorderWidth = 0
109:             .Visible     = .T.
110:         ENDWITH
111: 
112:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
113:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
114:             .AutoSize  = .F.
115:             .BackStyle = 0
116:             .Caption   = THIS.Caption
117:             .FontBold  = .T.
118:             .FontName  = "Tahoma"
119:             .FontSize  = 18
120:             .ForeColor = RGB(0, 0, 0)
121:             .Height    = 40
122:             .Left      = 10
123:             .Top       = 18
124:             .Width     = THIS.cnt_4c_Cabecalho.Width
125:             .WordWrap  = .T.
126:             .Visible   = .T.
127:         ENDWITH
128: 
129:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
130:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
131:             .AutoSize    = .F.
132:             .BackStyle   = 0
133:             .Caption     = THIS.Caption
134:             .FontBold    = .T.
135:             .FontName    = "Tahoma"
136:             .FontSize    = 18
137:             .ForeColor   = RGB(255, 255, 255)
138:             .Height      = 46
139:             .Left        = 10
140:             .Top         = 17
141:             .Width       = THIS.cnt_4c_Cabecalho.Width
142:             .WordWrap    = .T.
143:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
144:             .Visible     = .T.
145:         ENDWITH

*-- Linhas 175 a 289:
175:     * Standalone com Picture: Themes=.T. + DisabledPicture obrigatorio
176:     *--------------------------------------------------------------------------
177:     PROTECTED PROCEDURE ConfigurarBotoes()
178:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
179:         WITH THIS.cmd_4c_Processar
180:             .Top             = 3
181:             .Left            = 430
182:             .Height          = 75
183:             .Width           = 75
184:             .Caption         = "Processar"
185:             .FontBold        = .T.
186:             .FontItalic      = .T.
187:             .FontName        = "Comic Sans MS"
188:             .FontSize        = 8
189:             .ForeColor       = RGB(90, 90, 90)
190:             .BackColor       = RGB(255, 255, 255)
191:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
192:             .Themes          = .T.
193:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
194:             .ToolTipText     = "Processar"
195:             .TabIndex        = 2
196:             .Cancel          = .F.
197:             .Visible         = .T.
198:         ENDWITH
199: 
200:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
201:         WITH THIS.cmd_4c_Encerrar
202:             .Top             = 3
203:             .Left            = 505
204:             .Height          = 75
205:             .Width           = 75
206:             .Caption         = "Encerrar"
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .FontName        = "Comic Sans MS"
210:             .FontSize        = 8
211:             .ForeColor       = RGB(90, 90, 90)
212:             .BackColor       = RGB(255, 255, 255)
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
214:             .Themes          = .T.
215:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
216:             .ToolTipText     = "[ESC] Sair"
217:             .TabIndex        = 3
218:             .Cancel          = .T.
219:             .Visible         = .T.
220:         ENDWITH
221: 
222:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
223:         BINDEVENT(THIS.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
224:     ENDPROC
225: 
226:     *--------------------------------------------------------------------------
227:     * ConfigurarLabelProgresso - Label1 do legado: status do processamento
228:     *--------------------------------------------------------------------------
229:     PROTECTED PROCEDURE ConfigurarLabelProgresso()
230:         THIS.AddObject("lbl_4c_Progresso", "Label")
231:         WITH THIS.lbl_4c_Progresso
232:             .AutoSize    = .F.
233:             .BackStyle   = 0
234:             .BackColor   = RGB(255, 255, 234)
235:             .BorderStyle = 0
236:             .Caption     = ""
237:             .FontBold    = .T.
238:             .FontName    = "Tahoma"
239:             .FontSize    = 8
240:             .ForeColor   = RGB(90, 90, 90)
241:             .Height      = 20
242:             .Left        = 136
243:             .Top         = 99
244:             .Width       = 309
245:             .TabIndex    = 4
246:             .Visible     = .T.
247:         ENDWITH
248:     ENDPROC
249: 
250:     *--------------------------------------------------------------------------
251:     * ConfigurarCampoPrioridade - Label2 + txt_4c_Prioridade (Get_Prioridade)
252:     * Modo parametrizado: TextBox ReadOnly (simula PROCEDURE When Return .F.)
253:     * BINDEVENT "Valid" nao funciona em TextBox - usar KeyPress
254:     *--------------------------------------------------------------------------
255:     PROTECTED PROCEDURE ConfigurarCampoPrioridade()
256:         THIS.AddObject("lbl_4c_LblPrioridade", "Label")
257:         WITH THIS.lbl_4c_LblPrioridade
258:             .AutoSize    = .T.
259:             .BackStyle   = 0
260:             .BorderStyle = 0
261:             .Caption     = "Prioridade (0/1) : "
262:             .FontBold    = .T.
263:             .FontName    = "Tahoma"
264:             .FontSize    = 8
265:             .ForeColor   = RGB(90, 90, 90)
266:             .Height      = 15
267:             .Left        = 134
268:             .Top         = 154
269:             .Width       = 102
270:             .TabIndex    = 5
271:             .Visible     = .T.
272:         ENDWITH
273: 
274:         THIS.AddObject("txt_4c_Prioridade", "TextBox")
275:         WITH THIS.txt_4c_Prioridade
276:             .FontBold  = .T.
277:             .FontName  = "Tahoma"
278:             .FontSize  = 8
279:             .Height    = 23
280:             .InputMask = "9"
281:             .Left      = 238
282:             .MaxLength = 1
283:             .TabIndex  = 1
284:             .Top       = 150
285:             .Width     = 17
286:             .Value     = THIS.this_nPrioridade
287:             .ReadOnly  = THIS.this_lParametrizado
288:             .Visible   = .T.
289:         ENDWITH

*-- Linhas 300 a 309:
300:     PROTECTED PROCEDURE ConfigurarPaginaDados()
301:         THIS.AddObject("shp_4c_Shape1", "Shape")
302:         WITH THIS.shp_4c_Shape1
303:             .Top         = 7
304:             .Left        = 480
305:             .Height      = 29
306:             .Width       = 48
307:             .BackStyle   = 0
308:             .BorderStyle = 0
309:             .BorderColor = RGB(136, 189, 188)

*-- Linhas 319 a 339:
319:         LOCAL loc_cSQL, loc_nResult, loc_nTotal, loc_nProcessado
320:         LOCAL loc_nKey, loc_nError, loc_cErro, loc_cCidChaves
321: 
322:         THIS.cmd_4c_Processar.Enabled = .F.
323:         THIS.this_lParar = .F.
324:         SET CURSOR OFF
325: 
326:         loc_nMov        = 1
327:         loc_lErroCnx    = .F.
328:         loc_lProcessando = .T.
329: 
330:         DO WHILE loc_lProcessando AND !THIS.this_lParar
331: 
332:             THIS.cmd_4c_Encerrar.Enabled = .F.
333: 
334:             THIS.lbl_4c_Progresso.Caption = "Aguardando Produtos Para Processar" + ;
335:                                              REPLICATE(".", loc_nMov)
336:             loc_nMov = IIF(loc_nMov < 5, loc_nMov + 1, 1)
337: 
338:             loc_lOk = THIS.this_oBusinessObject.BuscarFila(THIS.this_nPrioridade)
339: 

*-- Linhas 346 a 354:
346: 
347:                 SCAN
348:                     loc_nProcessado = loc_nProcessado + 1
349:                     THIS.lbl_4c_Progresso.Caption = "Aguarde. Processando Produtos (" + ;
350:                         ALLTRIM(STR(loc_nProcessado)) + "/" + ALLTRIM(STR(loc_nTotal)) + ")"
351: 
352:                     loc_cCidChaves = ALLTRIM(CrSigOpClP.CidChaves)
353: 
354:                     *-- Marcar item como em processamento (lock otimista)

*-- Linhas 379 a 387:
379: 
380:                 ENDSCAN
381:             ENDIF
382:             THIS.cmd_4c_Encerrar.Enabled = .T.
383: 
384:             *-- Aguardar breve intervalo: permite que ESC seja detectado
385:             loc_nError = 0
386:             loc_cErro  = ON("Error")
387:             ON ERROR loc_nError = 1

*-- Linhas 398 a 408:
398:         ENDDO
399: 
400:         SET CURSOR ON
401:         THIS.lbl_4c_Progresso.Caption = ""
402:         THIS.cmd_4c_Processar.Enabled = .T.
403:         THIS.cmd_4c_Encerrar.Enabled  = .T.
404: 
405:         IF THIS.this_lParametrizado
406:             THIS.this_oBusinessObject.GravarLog( ;
407:                 "Concluindo o Processamento : Fortyus.Exe (SigOpClS) - Recalculo de Saldos")
408:             THIS.Release()

*-- Linhas 422 a 430:
422:     *--------------------------------------------------------------------------
423:     PROCEDURE BtnEncerrarClick()
424:         THIS.this_lParar = .T.
425:         IF THIS.cmd_4c_Processar.Enabled
426:             THIS.Release()
427:         ENDIF
428:     ENDPROC
429: 
430:     *--------------------------------------------------------------------------

*-- Linhas 573 a 582:
573:         IF VARTYPE(THIS.txt_4c_Prioridade) = "O"
574:             THIS.txt_4c_Prioridade.ReadOnly = THIS.this_lParametrizado OR !par_lHabilitar
575:         ENDIF
576:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
577:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar AND !THIS.this_lParametrizado
578:         ENDIF
579:     ENDPROC
580: 
581:     *--------------------------------------------------------------------------
582:     * LimparCampos - Restaura prioridade ao valor padrao (0)


### BO (C:\4c\projeto\app\classes\SigPrRsaBO.prg):
*==============================================================================
* Classe  : SigPrRsaBO
* Herda de: BusinessBase
* Descricao: BO para recalculo de saldos de produto (SIGPRRSA)
*            Form OPERACIONAL - processa fila SigOpClP chamando fRecalculaP
*            para cada produto na fila, fazendo commit/rollback por item.
*            Suporta modo parametrizado (batch) e modo interativo (loop continuo).
*==============================================================================
DEFINE CLASS SigPrRsaBO AS BusinessBase

    *-- Parametros de execucao
    this_nPrioridade    = 0     && Filtro de prioridade: 0 ou 1
    this_lParametrizado = .F.   && .T. = chamado de batch (Fortyus.Exe), quit apos processar

    *-- Estado do processamento (lido pelo Form para atualizar Label1)
    this_cStatusMsg     = ""    && Mensagem de progresso para o form exibir
    this_nTotalFila     = 0     && Total de registros na fila antes de processar
    this_nProcessados   = 0     && Quantidade processada na iteracao corrente

    *-- Campos do registro corrente de SigOpClP
    this_cCidChaves = ""        && cidchaves char(20) - PK da fila
    this_nPriors    = 0         && priors numeric(1,0) - prioridade (0 ou 1)
    this_cEmps      = ""        && emps char(3) - empresa
    this_cGrupos    = ""        && grupos char(10) - grupo de estoque
    this_cEstos     = ""        && estos char(10) - estoque/localizacao
    this_cCpros     = ""        && cpros char(14) - codigo do produto
    this_dDatas     = {}        && datas datetime - data do movimento
    this_cCodCors   = ""        && codcors char(4) - codigo da cor
    this_cCodTams   = ""        && codtams char(4) - codigo do tamanho
    this_cUsuars    = ""        && usuars char(20) - usuario processador
    this_nTipoestos = 0         && tipoestos numeric(1,0) - tipo de estoque
    this_cEmpestpros = ""       && empestpros char(37) - composite emps+estos+cpros

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - identificador para auditoria operacional
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "RECALCPRSLP"
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - popula propriedades do BO a partir do cursor CrSigOpClP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = NVL(cidchaves, "")
                THIS.this_nPriors    = NVL(priors, 0)
                THIS.this_cEmps      = NVL(emps, "")
                THIS.this_cGrupos    = NVL(grupos, "")
                THIS.this_cEstos     = NVL(estos, "")
                THIS.this_cCpros     = NVL(cpros, "")
                THIS.this_dDatas     = IIF(VARTYPE(datas) = "T", datas, {})
                THIS.this_cCodCors   = NVL(codcors, "")
                THIS.this_cCodTams   = NVL(codtams, "")
                THIS.this_cUsuars    = NVL(usuars, "")
                IF TYPE("tipoestos") != "U"
                    THIS.this_nTipoestos = NVL(tipoestos, 0)
                ENDIF
                IF TYPE("empestpros") != "U"
                    THIS.this_cEmpestpros = NVL(empestpros, "")
                ELSE
                    THIS.this_cEmpestpros = ALLTRIM(THIS.this_cEmps) + ;
                                            ALLTRIM(THIS.this_cEstos) + ;
                                            ALLTRIM(THIS.this_cCpros)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFila - SELECT de SigOpClP filtrado por prioridade em CrSigOpClP
    *--------------------------------------------------------------------------
    FUNCTION BuscarFila(par_nPrioridade)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigOpClP")
                USE IN CrSigOpClP
            ENDIF
            loc_cSQL = "SELECT cidchaves, codcors, codtams, cpros, datas, emps, " + ;
                       "estos, grupos, tipoestos, usuars, priors " + ;
                       "FROM SigOpClP " + ;
                       "WHERE priors = " + FormatarNumeroSQL(par_nPrioridade, 0) + " " + ;
                       "ORDER BY emps, grupos, estos"
            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpClP") > 0)
            IF loc_lSucesso
                THIS.this_nTotalFila = RECCOUNT("CrSigOpClP")
            ELSE
                THIS.this_nTotalFila = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigOpClP (enfileira item para recalculo de saldo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpEstPro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = SYS(2015)
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = gc_4c_UsuarioLogado
            ENDIF
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF
            loc_cEmpEstPro = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                             PADR(ALLTRIM(THIS.this_cEstos), 10) + ;
                             PADR(ALLTRIM(THIS.this_cCpros), 14)
            THIS.this_cEmpestpros = loc_cEmpEstPro
            loc_cSQL = "INSERT INTO SigOpClP " + ;
                       "(cidchaves, codcors, codtams, cpros, datas, empestpros, " + ;
                       "emps, estos, grupos, tipoestos, usuars, priors) VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodCors)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodTams)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(loc_cEmpEstPro) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEstos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipoestos, 0) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INSERT")
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir item na fila de recalculo (SigOpClP)."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigOpClP com todos os campos do item corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpEstPro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cEmpEstPro = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                 PADR(ALLTRIM(THIS.this_cEstos), 10) + ;
                                 PADR(ALLTRIM(THIS.this_cCpros), 14)
                THIS.this_cEmpestpros = loc_cEmpEstPro
                loc_cSQL = "UPDATE SigOpClP SET " + ;
                           "codcors = " + EscaparSQL(ALLTRIM(THIS.this_cCodCors)) + ", " + ;
                           "codtams = " + EscaparSQL(ALLTRIM(THIS.this_cCodTams)) + ", " + ;
                           "cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                           "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "empestpros = " + EscaparSQL(loc_cEmpEstPro) + ", " + ;
                           "emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                           "estos = " + EscaparSQL(ALLTRIM(THIS.this_cEstos)) + ", " + ;
                           "grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                           "tipoestos = " + FormatarNumeroSQL(THIS.this_nTipoestos, 0) + ", " + ;
                           "usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                           "priors = " + FormatarNumeroSQL(THIS.this_nPriors, 0) + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("UPDATE")
                ELSE
                    IF loc_nResult = -3
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o perdida com o banco de dados."
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar item da fila de recalculo (SigOpClP)."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarAtualizacao - UPDATE SigOpClP marcando item como sendo processado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "UPDATE SigOpClP SET usuars = usuars " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                ELSE
                    IF loc_nResult = -3
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o perdida com o banco de dados."
                ELSE
                    THIS.this_cMensagemErro = "Erro ao marcar item como processando."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigOpClP apos processamento bem sucedido
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "DELETE FROM SigOpClP " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao remover item da fila de processamento."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarItem - chama fRecalculaP para o item carregado em this_c*
    *--------------------------------------------------------------------------
    FUNCTION ProcessarItem()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crRecalculaP")
                USE IN crRecalculaP
            ENDIF
            *-- Primeira chamada: calcula saldo do produto especifico
            loc_lSucesso = fRecalculaP( ;
                THIS.this_cEmps, ;
                THIS.this_cGrupos, ;
                THIS.this_cEstos, ;
                THIS.this_cCpros, ;
                THIS.this_dDatas, ;
                THIS.this_cCodCors, ;
                THIS.this_cCodTams )
            IF loc_lSucesso
                *-- Segunda chamada: consolida saldos em fila aguardando processamento
                loc_lSucesso = fRecalculaP(.T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarMovimento - retorna .T. se deve pular exclusao da fila
    *   .T. = nao tem movimento em SigMvEst E tem historico em SigMvHst (loop)
    *   .F. = tem movimento em SigMvEst OU nao tem historico -> pode excluir da fila
    *--------------------------------------------------------------------------
    FUNCTION VerificarMovimento()
        LOCAL loc_lDeveLoop, loc_cChave, loc_cSQL, loc_nResult
        loc_lDeveLoop = .F.
        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ;
                         ALLTRIM(THIS.this_cGrupos) + ;
                         ALLTRIM(THIS.this_cEstos)
            loc_cSQL = "SELECT cidchaves FROM SigMvEst " + ;
                       "WHERE empgruests = " + EscaparSQL(loc_cChave) + " " + ;
                       "AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros))
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEst")
            IF loc_nResult < 1 OR RECCOUNT("TmpEst") = 0
                *-- Sem registro em SigMvEst: verificar SigMvHst
                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                loc_cSQL = "SELECT empgruests, SUM(1) AS TT FROM SigMvHst " + ;
                           "WHERE empgruests = " + EscaparSQL(loc_cChave) + " " + ;
                           "AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + " " + ;
                           "GROUP BY empgruests"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHis")
                IF loc_nResult < 1
                    loc_lDeveLoop = .T.
                ELSE
                    IF USED("TmpHis") AND RECCOUNT("TmpHis") > 0
                    SELECT TmpHis
                    IF NVL(TT, 0) > 0
                        loc_lDeveLoop = .T.
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
            IF USED("TmpHis")
                USE IN TmpHis
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lDeveLoop = .T.
        ENDTRY
        RETURN loc_lDeveLoop
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarLog - escreve linha no Fortyus.Log (modo parametrizado)
    *--------------------------------------------------------------------------
    PROCEDURE GravarLog(par_cMensagem)
        LOCAL loc_cArquivo
        loc_cArquivo = "Fortyus.Log"
        TRY
            IF !EMPTY(par_cMensagem)
                STRTOFILE(par_cMensagem + CHR(10), loc_cArquivo, .T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarLog - cria/limpa Fortyus.Log e grava cabecalho de inicio
    *--------------------------------------------------------------------------
    PROCEDURE IniciarLog(par_cMensagem)
        TRY
            STRTOFILE("", "Fortyus.Log", .T.)
            THIS.GravarLog(REPLICATE("=", 80))
            THIS.GravarLog(par_cMensagem)
            THIS.GravarLog("Data : " + DTOC(DATE()) + " - Hora : " + TIME())
            THIS.GravarLog(REPLICATE("=", 80))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - override para log operacional de recalculo de saldos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Tabela, Operacao, ChaveRegistro, DataHora) VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL("SigOpClP") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

