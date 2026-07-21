# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 180: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 206: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRss.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (630 linhas total):

*-- Linhas 69 a 78:
69:                 THIS.TornarControlesVisiveis()
70: 
71:                 *-- Sincronizar caption das labels com o titulo do form
72:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
73:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:                 IF THIS.this_lParametrizado
76:                     THIS.IniciarLogProcessamento()
77:                 ENDIF
78: 

*-- Linhas 106 a 148:
106:         THIS.AddObject("cnt_4c_Sombra", "Container")
107:         WITH THIS.cnt_4c_Sombra
108:             .Visible     = .T.
109:             .Top         = 0
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BorderWidth = 0
114:             .BackColor   = RGB(100,100,100)
115:         ENDWITH
116: 
117:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
118:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
119:             .Visible       = .T.
120:             .Top           = 18
121:             .Left          = 10
122:             .Width         = THIS.Width
123:             .Height        = 40
124:             .Caption       = THIS.Caption
125:             .FontBold      = .T.
126:             .FontName      = "Tahoma"
127:             .FontSize      = 18
128:             .FontUnderline = .F.
129:             .WordWrap      = .T.
130:             .Alignment     = 0
131:             .AutoSize      = .F.
132:             .BackStyle     = 0
133:             .ForeColor     = RGB(0,0,0)
134:         ENDWITH
135: 
136:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
137:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
138:             .Visible    = .T.
139:             .Top        = 17
140:             .Left       = 10
141:             .Width      = THIS.Width
142:             .Height     = 46
143:             .Caption    = THIS.Caption
144:             .FontBold   = .T.
145:             .FontName   = "Tahoma"
146:             .FontSize   = 18
147:             .WordWrap   = .T.
148:             .Alignment  = 0

*-- Linhas 159 a 186:
159:         *-- Shape decorativo (Shape1: Top=7, Left=478, Width=90, Height=27)
160:         THIS.AddObject("shp_4c_Shape1", "Shape")
161:         WITH THIS.shp_4c_Shape1
162:             .Top         = 7
163:             .Left        = 478
164:             .Height      = 27
165:             .Width       = 90
166:             .BackStyle   = 0
167:             .BorderStyle = 0
168:             .BorderColor = RGB(136,189,188)
169:         ENDWITH
170: 
171:         *-- Botao Processar (OK no legado: Left=430, Top=3, 75x75)
172:         *-- Themes=.T. + DisabledPicture: necessario para standalone com Enabled=.F. (regra #99)
173:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
174:         WITH THIS.cmd_4c_Processar
175:             .Top             = 3
176:             .Left            = 430
177:             .Width           = 75
178:             .Height          = 75
179:             .Caption         = "Processar"
180:             .FontName        = "Comic Sans MS"
181:             .FontSize        = 8
182:             .FontBold        = .T.
183:             .FontItalic      = .T.
184:             .ForeColor       = RGB(90,90,90)
185:             .BackColor       = RGB(255,255,255)
186:             .Themes          = .T.

*-- Linhas 193 a 212:
193:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
194:             .ToolTipText     = ""
195:         ENDWITH
196:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
197: 
198:         *-- Botao Encerrar (SAIR no legado: Left=505, Top=3, 75x75)
199:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
200:         WITH THIS.cmd_4c_Encerrar
201:             .Top             = 3
202:             .Left            = 505
203:             .Width           = 75
204:             .Height          = 75
205:             .Caption         = "Encerrar"
206:             .FontName        = "Comic Sans MS"
207:             .FontSize        = 8
208:             .FontBold        = .T.
209:             .FontItalic      = .T.
210:             .ForeColor       = RGB(90,90,90)
211:             .BackColor       = RGB(255,255,255)
212:             .Themes           = .T.

*-- Linhas 219 a 241:
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
220:             .ToolTipText     = "[ESC] Sair"
221:         ENDWITH
222:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
223:     ENDPROC
224: 
225:     *==========================================================================
226:     * ConfigurarStatusLabel - Label de progresso (Label1 original: Top=94, Left=135)
227:     *==========================================================================
228:     PROTECTED PROCEDURE ConfigurarStatusLabel
229:         THIS.AddObject("lbl_4c_Status", "Label")
230:         WITH THIS.lbl_4c_Status
231:             .Visible   = .T.
232:             .Top       = 94
233:             .Left      = 135
234:             .Width     = 309
235:             .Height    = 20
236:             .Caption   = ""
237:             .FontBold  = .T.
238:             .FontName  = "Tahoma"
239:             .FontSize  = 8
240:             .BackStyle = 0
241:             .ForeColor = RGB(90,90,90)

*-- Linhas 286 a 303:
286:         loc_lErroCnx = .F.
287:         loc_nMov     = 1
288: 
289:         THIS.cmd_4c_Processar.Enabled = .F.
290:         THIS.this_lProcessando = .T.
291: 
292:         DO WHILE .T.
293:             THIS.cmd_4c_Encerrar.Enabled = .F.
294: 
295:             THIS.lbl_4c_Status.Caption = "Aguardando Contas Para Processar" + ;
296:                 REPLICATE(".", loc_nMov)
297:             loc_nMov = IIF(loc_nMov < 5, loc_nMov + 1, 1)
298:             THIS.lbl_4c_Status.Refresh()
299: 
300:             *-- Buscar registros em fila SigOpCls
301:             loc_lOk = loc_oBO.BuscarNaFila(ALLTRIM(THIS.this_cUsuario), THIS.this_lOnline)
302: 
303:             IF !loc_lOk

*-- Linhas 350 a 358:
350:                 ENDSCAN
351:             ENDIF
352: 
353:             THIS.cmd_4c_Encerrar.Enabled = .T.
354: 
355:             *-- Aguardar 0.5s e capturar tecla pressionada
356:             loc_nErr    = 0
357:             loc_cOldErr = ON("ERROR")
358:             ON ERROR loc_nErr = 1

*-- Linhas 368 a 377:
368:             ENDIF
369:         ENDDO
370: 
371:         THIS.lbl_4c_Status.Caption = ""
372:         THIS.cmd_4c_Processar.Enabled = .T.
373:         THIS.this_lProcessando = .F.
374: 
375:         *-- Finalizacao em modo batch
376:         IF THIS.this_lParametrizado
377:             THIS.FinalizarLogProcessamento()

*-- Linhas 454 a 462:
454:     * AlternarPagina - No-op semantico para form OPERACIONAL
455:     * Este dialog tem estado unico (nao alterna entre LISTA/DADOS). A logica
456:     * de fluxo eh controlada por this_lProcessando (habilitando/desabilitando
457:     * cmd_4c_Processar e cmd_4c_Encerrar dentro de BtnProcessarClick).
458:     *==========================================================================
459:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
460:         *-- Form OPERACIONAL: pagina unica, nenhuma alternancia necessaria.
461:         RETURN .T.
462:     ENDPROC

*-- Linhas 487 a 499:
487:     *==========================================================================
488:     * BtnVisualizarClick - No-op semantico para form OPERACIONAL
489:     * Este dialog nao tem modo de visualizacao individual de registro.
490:     * O status do processamento e exibido em lbl_4c_Status em tempo real.
491:     * Metodo presente para compatibilidade com o pipeline de validacao de fases.
492:     *==========================================================================
493:     PROCEDURE BtnVisualizarClick
494:         *-- Form OPERACIONAL: status de processamento exibido via lbl_4c_Status.
495:         RETURN .T.
496:     ENDPROC
497: 
498:     *==========================================================================
499:     * BtnExcluirClick - No-op semantico para form OPERACIONAL

*-- Linhas 552 a 573:
552:     * par_lHabilitar: .T. = habilitado (aguardando), .F. = processando
553:     *==========================================================================
554:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
555:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
556:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
557:         ENDIF
558:         IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
559:             THIS.cmd_4c_Encerrar.Enabled  = par_lHabilitar
560:         ENDIF
561:     ENDPROC
562: 
563:     *==========================================================================
564:     * LimparCampos - Limpa o label de status
565:     *==========================================================================
566:     PROTECTED PROCEDURE LimparCampos
567:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
568:             THIS.lbl_4c_Status.Caption = ""
569:         ENDIF
570:     ENDPROC
571: 
572:     *==========================================================================
573:     * AjustarBotoesPorModo - Ajusta botoes conforme estado de processamento


### BO (C:\4c\projeto\app\classes\SigPrRssBO.prg):
*==============================================================================
* SigPrRssBO.prg - Business Object: Rec" + CHR(225) + "lculo de Saldos
* Tabela principal: SigPrSlS (fila de processamento de saldos)
* Gerado: 2026-07-18
*==============================================================================
DEFINE CLASS SigPrRssBO AS BusinessBase

    *-- Tabela e chave
    this_cTabela     = "SigPrSlS"
    this_cCampoChave = "CidChaves"

    *-- Controle de processamento (mapeados das props legadas do form)
    this_lParametrizado = .F.   && Iniciado via linha de comando (modo batch)
    this_cUsuario       = "          "   && Filtro de usuario (Space(10))
    this_lOnline        = .F.   && Modo online (processa apenas registros Onlines=1)

    *-- Estado de execucao
    this_lProcessando  = .F.   && .T. enquanto loop principal esta rodando
    this_lErroConexao  = .F.   && .T. se houve queda de conexao com BD

    *-- Campos de SigOpCls usados no processamento
    this_cCidChaves    = ""    && Chave do registro em processamento
    this_cGrupos       = ""    && Grupo da conta
    this_cContas       = ""    && Conta
    this_cMoedas       = ""    && Moeda
    this_dDatas        = {}    && Data do lancamento
    this_nOnlines      = 0     && Flag online (NUMERIC 1,0)
    this_cUsuars       = ""    && Usuario do lancamento
    this_cGruConMoes   = ""    && Chave composta grupo+conta+moeda

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            THIS.this_cContas     = TratarNulo(contas,     "C")
            THIS.this_cMoedas     = TratarNulo(moedas,     "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_nOnlines    = NVL(onlines, 0)
            THIS.this_cUsuars     = TratarNulo(usuars,     "C")
            THIS.this_cGruConMoes = TratarNulo(gruconmoes, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cMensagemErro = "CidChaves obrigat" + CHR(243) + "rio."
            MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "INSERT INTO SigPrSlS " + ;
                    "(cidchaves, contas, datas, gruconmoes, grupos, moedas, onlines, usuars) " + ;
                    "VALUES (" + ;
                    EscaparSQL(THIS.this_cCidChaves)             + ", " + ;
                    EscaparSQL(THIS.this_cContas)                + ", " + ;
                    FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                    EscaparSQL(THIS.this_cGruConMoes)            + ", " + ;
                    EscaparSQL(THIS.this_cGrupos)                + ", " + ;
                    EscaparSQL(THIS.this_cMoedas)                + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOnlines, 0)     + ", " + ;
                    EscaparSQL(THIS.this_cUsuars)                + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao inserir em SigPrSlS." + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir em SigPrSlS:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigPrSlS SET " + ;
                    "contas     = " + EscaparSQL(THIS.this_cContas)            + ", " + ;
                    "datas      = " + FormatarDataSQL(THIS.this_dDatas)        + ", " + ;
                    "gruconmoes = " + EscaparSQL(THIS.this_cGruConMoes)        + ", " + ;
                    "grupos     = " + EscaparSQL(THIS.this_cGrupos)            + ", " + ;
                    "moedas     = " + EscaparSQL(THIS.this_cMoedas)            + ", " + ;
                    "onlines    = " + FormatarNumeroSQL(THIS.this_nOnlines, 0) + ", " + ;
                    "usuars     = " + EscaparSQL(THIS.this_cUsuars)            + " " + ;
                    "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao atualizar SigPrSlS." + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar SigPrSlS:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNaFila - Consulta SigOpCls para obter registros a processar
    * Popula cursor CrSigOpCls. Filtros: usuario especifico e/ou modo online.
    *--------------------------------------------------------------------------
    FUNCTION BuscarNaFila(par_cUsuario, par_lOnline)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF USED("CrSigOpCls")
                USE IN CrSigOpCls
            ENDIF

            IF !EMPTY(par_cUsuario) OR par_lOnline
                loc_cSQL = "SELECT 0 AS Flag, * FROM SigOpCls WHERE Onlines = 1"
                IF !EMPTY(par_cUsuario)
                    loc_cSQL = loc_cSQL + " AND Usuars = " + EscaparSQL(par_cUsuario)
                ENDIF
                loc_cSQL = loc_cSQL + " ORDER BY GruConMoes"
            ELSE
                loc_cSQL = "SELECT 0 AS Flag, * FROM SigOpCls ORDER BY GruConMoes"
            ENDIF

            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCls") > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar registros em SigOpCls:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarProcessando - Toca registro em SigOpCls (lock otimista)
    *--------------------------------------------------------------------------
    FUNCTION MarcarProcessando(par_cCidChaves)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = (SQLEXEC(gnConnHandle, ;
                "UPDATE SigOpCls SET Usuars = Usuars " + ;
                "WHERE CidChaves = " + EscaparSQL(par_cCidChaves)) > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao marcar processamento em SigOpCls:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarMovimentos - Verifica se existe impeditivo em SigMvSlc/SigMvCcr
    * Retorna .T. se pode continuar o processamento do registro
    *--------------------------------------------------------------------------
    FUNCTION VerificarMovimentos(par_cGruConMoes)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRes
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpSccr")
                USE IN cursor_4c_TmpSccr
            ENDIF

            *-- Verificar SigMvSlc
            loc_cSQL = "SELECT CidChaves FROM SigMvSlc " + ;
                "WHERE GruConMoes = " + EscaparSQL(par_cGruConMoes)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSccr")

            IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSccr") > 0
                loc_lSucesso = .T.
            ELSE
                *-- Verificar SigMvCcr
                IF USED("cursor_4c_TmpMccr")
                    USE IN cursor_4c_TmpMccr
                ENDIF

                loc_cSQL = "SELECT GruConMoes, SUM(1) AS TT FROM SigMvCcr " + ;
                    "WHERE GruConMoes = " + EscaparSQL(par_cGruConMoes) + " " + ;
                    "GROUP BY GruConMoes"
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccr")

                IF loc_nRes >= 0 AND USED("cursor_4c_TmpMccr") AND ;
                        RECCOUNT("cursor_4c_TmpMccr") > 0 AND cursor_4c_TmpMccr.TT > 0
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar movimentos:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarHistorico - Registra em SigPrSlS o lancamento processado
    * Equivale ao SCATTER CrSigOpCls / ZAP CrSigPrSlS / APPEND / GATHER do legado
    *--------------------------------------------------------------------------
    FUNCTION GravarHistorico(par_cCidChaves, par_cGrupos, par_cContas, par_dDatas, ;
                             par_cMoedas, par_cGruConMoes, par_nOnlines, par_cUsuars)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nCheck
        loc_lSucesso = .F.

        TRY
            *-- Remover entrada anterior se existir (emula ZAP do cursor)
            IF USED("cursor_4c_ChkSlS")
                USE IN cursor_4c_ChkSlS
            ENDIF
            loc_nCheck = SQLEXEC(gnConnHandle, ;
                "SELECT cidchaves FROM SigPrSlS WHERE cidchaves = " + ;
                EscaparSQL(par_cCidChaves), "cursor_4c_ChkSlS")
            IF loc_nCheck > 0 AND RECCOUNT("cursor_4c_ChkSlS") > 0
                SQLEXEC(gnConnHandle, "DELETE FROM SigPrSlS WHERE cidchaves = " + ;
                    EscaparSQL(par_cCidChaves))
            ENDIF

            loc_cSQL = "INSERT INTO SigPrSlS " + ;
                "(cidchaves, contas, datas, gruconmoes, grupos, moedas, onlines, usuars) " + ;
                "VALUES (" + ;
                EscaparSQL(par_cCidChaves)          + ", " + ;
                EscaparSQL(par_cContas)              + ", " + ;
                FormatarDataSQL(par_dDatas)          + ", " + ;
                EscaparSQL(par_cGruConMoes)          + ", " + ;
                EscaparSQL(par_cGrupos)              + ", " + ;
                EscaparSQL(par_cMoedas)              + ", " + ;
                FormatarNumeroSQL(par_nOnlines, 0)   + ", " + ;
                EscaparSQL(par_cUsuars)              + ")"

            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL) > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao gravar hist" + CHR(243) + "rico em SigPrSlS:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DeletarDaFila - Remove registro ja processado da fila SigOpCls
    *--------------------------------------------------------------------------
    FUNCTION DeletarDaFila(par_cCidChaves)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = (SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigOpCls WHERE CidChaves = " + ;
                EscaparSQL(par_cCidChaves)) > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao remover da fila SigOpCls:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularSaldo - Invoca fRecalculaS (Framework legado) para recalc de saldo
    * Equivale a: fRecalculaS(Grupos, Contas, Datas, Moedas, DataMgr) do legado
    *--------------------------------------------------------------------------
    FUNCTION RecalcularSaldo(par_cGrupos, par_cContas, par_dDatas, par_cMoedas)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = fRecalculaS(par_cGrupos, par_cContas, par_dDatas, ;
                par_cMoedas, gnConnHandle)
        CATCH TO loc_oErro
            MostrarErro("Erro ao recalcular saldo:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FinalizarRecalculo - Segunda chamada de fRecalculaS (modo finalizacao)
    * Equivale a: fRecalculaS(.T., DataMgr, .T., .F., .F., .T.) do legado
    *--------------------------------------------------------------------------
    FUNCTION FinalizarRecalculo()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = fRecalculaS(.T., gnConnHandle, .T., .F., .F., .T.)
        CATCH TO loc_oErro
            MostrarErro("Erro ao finalizar rec" + CHR(225) + "lculo:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

