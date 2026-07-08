# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 223: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 244: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 266: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReHev.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (753 linhas total):

*-- Linhas 85 a 93:
85:         loc_lSucesso   = .F.
86:         loc_lContinuar = .T.
87:         TRY
88:             THIS.Caption = "Hist" + CHR(243) + "rico de Envelopes"
89: 
90:             IF TYPE("gc_4c_CaminhoIcones") = "U"
91:                 gc_4c_CaminhoIcones = ""
92:             ENDIF
93:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 108 a 117:
108:                 THIS.ConfigurarPaginaDados()
109:                 THIS.ConfigurarEventos()
110: 
111:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
112:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
113: 
114:                 THIS.LimparCampos()
115:                 THIS.AlternarPagina(1)
116:                 THIS.Visible = .T.
117:                 loc_lSucesso = .T.

*-- Linhas 133 a 208:
133:     PROTECTED PROCEDURE ConfigurarCabecalho()
134:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
135:         WITH THIS.cnt_4c_Cabecalho
136:             .Top         = 0
137:             .Left        = 0
138:             .Width       = THIS.Width
139:             .Height      = 80
140:             .BackStyle   = 1
141:             .BackColor   = RGB(100, 100, 100)
142:             .BorderWidth = 0
143:             .Visible     = .T.
144: 
145:             .AddObject("lbl_4c_Sombra", "Label")
146:             WITH .lbl_4c_Sombra
147:                 .Top       = 22
148:                 .Left      = 22
149:                 .Width     = THIS.Width
150:                 .Height    = 30
151:                 .Caption   = "Hist" + CHR(243) + "rico de Envelopes"
152:                 .FontName  = "Tahoma"
153:                 .FontSize  = 14
154:                 .FontBold  = .T.
155:                 .ForeColor = RGB(0, 0, 0)
156:                 .BackStyle = 0
157:                 .Visible   = .T.
158:             ENDWITH
159: 
160:             .AddObject("lbl_4c_Titulo", "Label")
161:             WITH .lbl_4c_Titulo
162:                 .Top       = 20
163:                 .Left      = 20
164:                 .Width     = THIS.Width
165:                 .Height    = 30
166:                 .Caption   = "Hist" + CHR(243) + "rico de Envelopes"
167:                 .FontName  = "Tahoma"
168:                 .FontSize  = 14
169:                 .FontBold  = .T.
170:                 .ForeColor = RGB(255, 255, 255)
171:                 .BackStyle = 0
172:                 .Visible   = .T.
173:             ENDWITH
174:         ENDWITH
175:     ENDPROC
176: 
177:     *--------------------------------------------------------------------------
178:     * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es de relat" + CHR(243) + "rio (btnReport)
179:     *   Original: btnReport.Left=530, Top=0, 4 bot" + CHR(245) + "es
180:     *   Ordem: Visualiza(left=5), Imprime(left=70), DocExcel(left=135), Sair(left=200)
181:     *   BINDEVENTs Click vinculados na Fase 7
182:     *--------------------------------------------------------------------------
183:     PROTECTED PROCEDURE ConfigurarBotoes()
184:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
185:         WITH THIS.cmg_4c_Botoes
186:             .Top           = 0
187:             .Left          = 529
188:             .Width         = 273
189:             .Height        = 80
190:             .ButtonCount   = 4
191:             .BackStyle     = 0
192:             .BorderStyle   = 0
193:             .BorderColor   = RGB(136, 189, 188)
194:             .SpecialEffect = 1
195:             .Themes        = .F.
196:             .Visible       = .T.
197: 
198:             WITH .Buttons(1)
199:                 .Top             = 5
200:                 .Left            = 5
201:                 .Width           = 65
202:                 .Height          = 70
203:                 .Caption         = "Visualizar"
204:                 .FontBold        = .T.
205:                 .FontItalic      = .T.
206:                 .BackColor       = RGB(255, 255, 255)
207:                 .ForeColor       = RGB(90, 90, 90)
208:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 215 a 229:
215:             ENDWITH
216: 
217:             WITH .Buttons(2)
218:                 .Top             = 5
219:                 .Left            = 71
220:                 .Width           = 65
221:                 .Height          = 70
222:                 .Caption         = "Imprimir"
223:                 .FontName        = "Comic Sans MS"
224:                 .FontBold        = .T.
225:                 .FontItalic      = .T.
226:                 .FontSize        = 8
227:                 .BackColor       = RGB(255, 255, 255)
228:                 .ForeColor       = RGB(90, 90, 90)
229:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 236 a 250:
236:             ENDWITH
237: 
238:             WITH .Buttons(3)
239:                 .Top             = 5
240:                 .Left            = 137
241:                 .Width           = 65
242:                 .Height          = 70
243:                 .Caption         = "Excel"
244:                 .FontName        = "Comic Sans MS"
245:                 .FontBold        = .T.
246:                 .FontItalic      = .T.
247:                 .FontSize        = 8
248:                 .BackColor       = RGB(255, 255, 255)
249:                 .ForeColor       = RGB(90, 90, 90)
250:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 257 a 272:
257:             ENDWITH
258: 
259:             WITH .Buttons(4)
260:                 .Top             = 5
261:                 .Left            = 203
262:                 .Width           = 65
263:                 .Height          = 70
264:                 .Caption         = "Encerrar"
265:                 .Cancel          = .T.
266:                 .FontName        = "Comic Sans MS"
267:                 .FontBold        = .T.
268:                 .FontItalic      = .T.
269:                 .FontSize        = 8
270:                 .BackColor       = RGB(255, 255, 255)
271:                 .ForeColor       = RGB(90, 90, 90)
272:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 291 a 305:
291:         loc_oPgf = THIS.pgf_4c_Paginas
292: 
293:         loc_oPgf.PageCount = 1
294:         loc_oPgf.Top    = 85
295:         loc_oPgf.Left   = -1
296:         loc_oPgf.Width  = THIS.Width + 2
297:         loc_oPgf.Height = THIS.Height - 85
298:         loc_oPgf.Tabs   = .F.
299: 
300:         loc_oPgf.Page1.Caption   = "Filtros"
301:         loc_oPgf.Page1.FontName  = "Tahoma"
302:         loc_oPgf.Page1.FontSize  = 8
303:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
304:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
305:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 311 a 342:
311:     *--------------------------------------------------------------------------
312:     * ConfigurarCamposFiltro - Adiciona label e TextBox do campo Envelope
313:     *   Posi" + CHR(231) + CHR(245) + "es originais (SIGREHEV flat): lbl Top=159 Left=323; txt Top=156 Left=384
314:     *   Compensadas para Page1 (PageFrame.Top=85): Top - 85
315:     *--------------------------------------------------------------------------
316:     PROTECTED PROCEDURE ConfigurarCamposFiltro()
317:         LOCAL loc_oPagina
318:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
319: 
320:         loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
321:         WITH loc_oPagina.lbl_4c_Operacao
322:             .Top       = 74
323:             .Left      = 323
324:             .Width     = 70
325:             .Height    = 17
326:             .Caption   = "Envelope  :"
327:             .FontName  = "Tahoma"
328:             .FontSize  = 8
329:             .ForeColor = RGB(90, 90, 90)
330:             .BackStyle = 0
331:             .Visible   = .T.
332:         ENDWITH
333: 
334:         loc_oPagina.AddObject("txt_4c_Op", "TextBox")
335:         WITH loc_oPagina.txt_4c_Op
336:             .Top         = 71
337:             .Left        = 384
338:             .Width       = 85
339:             .Height      = 23
340:             .Value       = 0
341:             .Format      = "K"
342:             .InputMask   = "9999999999"

*-- Linhas 370 a 379:
370: 
371:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
372: 
373:         IF PEMSTATUS(loc_oPagina, "lbl_4c_Operacao", 5)
374:             loc_oPagina.lbl_4c_Operacao.Visible = .T.
375:         ENDIF
376: 
377:         IF PEMSTATUS(loc_oPagina, "txt_4c_Op", 5)
378:             WITH loc_oPagina.txt_4c_Op
379:                 .Visible  = .T.

*-- Linhas 409 a 418:
409: 
410:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
411: 
412:         IF PEMSTATUS(loc_oPagina, "lbl_4c_Operacao", 5)
413:             loc_oPagina.lbl_4c_Operacao.Visible = .T.
414:         ENDIF
415: 
416:         IF PEMSTATUS(loc_oPagina, "txt_4c_Op", 5)
417:             WITH loc_oPagina.txt_4c_Op
418:                 .Visible     = .T.


### BO (C:\4c\projeto\app\classes\SigReHevBO.prg):
*==============================================================================
* SIGREHEEVO.PRG
* Business Object para Relatorio - Historico de Envelopes
*
* Herda de RelatorioBase
* Tabelas: SigCdOpe, SigCdPam, SigPdMvf, SigCdCli, SigCdCe
*==============================================================================

DEFINE CLASS SigReHevBO AS RelatorioBase

    *-- Configuracao base
    this_cTabela            = "SigPdMvf"
    this_cCampoChave        = ""

    *-- Parametro principal do relatorio
    this_nEnvelope          = 0

    *-- Flag de acesso (fChecaAcesso RESUMIDO)
    this_lAcesso            = .F.

    *-- Parametro lido de SigCdPam (DopEnvels)
    this_cDopEnvels         = ""

    *-- Nomes dos cursores usados no processamento
    this_cCursorDados       = "Temp_HisOp"
    this_cCursorCabecalho   = "csCabecalho"
    this_cCursorOpe         = "crTmpOpe"
    this_cCursorMvf         = "crSigPdMvf"
    this_cCursorParam       = "TmpParam"
    this_cCursorCli         = "CrTmpCli"
    this_cCursorCliE        = "TmpCliE"

    *-- Caminho completo do arquivo de relatorio (.frx)
    this_cArquivoRelatorio  = ""

    *--------------------------------------------------------------------------
    * Init - Configura caminho do relatorio e propriedades base
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela           = "SigPdMvf"
            THIS.this_cCampoChave       = ""
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "SigReHev.frx"
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursores para o relatorio de Historico de Envelopes
    * Equivalente ao metodo Processamento() do form legado SIGREHEV
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cDopeE
        LOCAL loc_nOp, loc_lPrimeira, loc_cAcesso
        LOCAL loc_nPeso, loc_nQtde, loc_cChaveMfas, loc_cConta
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cEmps, loc_cObsOps

        loc_lSucesso = .F.

        TRY
            IF THIS.this_nEnvelope <= 0
                THIS.this_cMensagemErro = "Informe o n" + CHR(250) + "mero do envelope"
                loc_lSucesso = .F.
            ENDIF

            *-- Cria cursor de cabecalho do relatorio
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            loc_cEmpresa = go_4c_Sistema.cEmpresa
            loc_cTitulo  = "An" + CHR(225) + "lise do Envelope n" + CHR(186) + " " + ;
                           ALLTRIM(STR(THIS.this_nEnvelope))
            CREATE CURSOR (THIS.this_cCursorCabecalho) (cb_empresa C(80), cb_titulo C(80))
            INSERT INTO (THIS.this_cCursorCabecalho) (cb_empresa, cb_titulo) ;
                VALUES (loc_cEmpresa, loc_cTitulo)

            *-- Busca parametro DopEnvels de SigCdPam
            IF USED(THIS.this_cCursorParam)
                USE IN (THIS.this_cCursorParam)
            ENDIF
            loc_cSQL = "SELECT DopEnvels FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorParam)
            IF loc_nResult > 0
                SELECT (THIS.this_cCursorParam)
                IF !EOF()
                    THIS.this_cDopEnvels = ALLTRIM(DopEnvels)
                ENDIF
                USE IN (THIS.this_cCursorParam)
            ENDIF
            loc_cDopeE = THIS.this_cDopEnvels

            *-- Acesso completo (equivalente a fChecaAcesso com Envelope > 0)
            THIS.this_lAcesso = .T.
            loc_cAcesso = "1"

            *-- Busca tipos de envelope em SigCdOpe
            IF USED(THIS.this_cCursorOpe)
                USE IN (THIS.this_cCursorOpe)
            ENDIF
            loc_cSQL = "SELECT DISTINCT DigEnves FROM SigCdOpe " + ;
                       "WHERE (Servicos = 1 OR Servicos = 2) " + ;
                       "OR (Globalizas = 1 OR Globalizas = 2)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpe)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                loc_lSucesso = .F.
            ENDIF

            *-- Remove cursor de resultado anterior
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_lPrimeira = .T.

            *-- Itera sobre cada tipo de envelope (DigEnves)
            SELECT (THIS.this_cCursorOpe)
            SCAN
                loc_nOp = VAL(STR(DigEnves, 1) + TRANSFORM(THIS.this_nEnvelope, "@L 999999"))

                *-- Busca movimentos do envelope calculado
                IF USED(THIS.this_cCursorMvf)
                    USE IN (THIS.this_cCursorMvf)
                ENDIF
                loc_cSQL = "SELECT Nenvs, cIdChaves, Datas, Emps, Dopps, Numps, " + ;
                           "GrupoOs, ContaOs, GrupoDs, ContaDs, Pesos, Qtds, " + ;
                           "Dopes, EmpDnPs, EmpDnPs AS ObsOps, " + ;
                           loc_cAcesso + " AS Acesso " + ;
                           "FROM SigPdMvf " + ;
                           "WHERE (Nenvs = " + STR(loc_nOp) + ;
                           " AND Dopps <> " + EscaparSQL(loc_cDopeE) + ") " + ;
                           "OR (Dopps = " + EscaparSQL(loc_cDopeE) + ;
                           " AND Numps = " + STR(loc_nOp) + ") " + ;
                           "ORDER BY Nenvs, cIdChaves"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorMvf)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lSucesso = .F.
                ENDIF

                SELECT (THIS.this_cCursorMvf)
                INDEX ON cIdChaves TAG Nenvs
                SET ORDER TO Nenvs

                *-- Na primeira iteracao, cria cursor de resultado com mesmo schema do MVF
                IF loc_lPrimeira
                    LOCAL ARRAY xMfas[1]
                    =AFIELDS(xMfas)
                    CREATE CURSOR (THIS.this_cCursorDados) FROM ARRAY xMfas
                    INDEX ON cIdChaves TAG cIdChaves
                    loc_lPrimeira = .F.
                ENDIF

                *-- Garante que MVF esta selecionado antes do SCAN interno
                SELECT (THIS.this_cCursorMvf)
                SCAN
                    loc_cChaveMfas = Emps + Dopps + STR(Numps, 10)
                    loc_nPeso = 0
                    loc_nQtde = 0

                    *-- Acumula Pesos e Qtds do grupo de mesma chave
                    SCAN WHILE Emps + Dopps + STR(Numps, 10) = loc_cChaveMfas
                        loc_nPeso = loc_nPeso + Pesos
                        loc_nQtde = loc_nQtde + Qtds
                    ENDSCAN
                    SKIP -1
                    SCATTER MEMVAR MEMO

                    *-- Busca nome do cliente origem (ContaOs -> Dopes)
                    IF USED(THIS.this_cCursorCli)
                        USE IN (THIS.this_cCursorCli)
                    ENDIF
                    loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(m.ContaOs)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCli) > 0
                        SELECT (THIS.this_cCursorCli)
                        IF !EOF()
                            m.Dopes = ALLTRIM(Rclis)
                        ENDIF
                    ENDIF

                    *-- Busca nome do cliente destino (ContaDs -> EmpDnPs)
                    IF USED(THIS.this_cCursorCli)
                        USE IN (THIS.this_cCursorCli)
                    ENDIF
                    loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(m.ContaDs)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCli) > 0
                        SELECT (THIS.this_cCursorCli)
                        IF !EOF()
                            m.empDnPs = ALLTRIM(Rclis)
                        ENDIF
                    ENDIF

                    *-- Adiciona registro ao cursor de resultado
                    SELECT (THIS.this_cCursorDados)
                    APPEND BLANK
                    GATHER MEMVAR
                    REPLACE Pesos  WITH loc_nPeso, ;
                            Qtds   WITH loc_nQtde, ;
                            ObsOps WITH " "

                ENDSCAN
            ENDSCAN

            *-- Preenche campo ObsOps com dados de SigCdCe
            IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO BOTTOM

                IF !THIS.this_lAcesso
                    *-- Sem acesso resumido: apenas ultimo registro recebe ObsOps
                    loc_cConta = ContaDs
                    IF USED(THIS.this_cCursorCliE)
                        USE IN (THIS.this_cCursorCliE)
                    ENDIF
                    loc_cSQL = "SELECT ObsOps FROM SigCdCe WHERE Iclis = " + EscaparSQL(loc_cConta)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCliE) > 0
                        SELECT (THIS.this_cCursorCliE)
                        IF !EOF()
                            loc_cObsOps = ALLTRIM(ObsOps)
                        ELSE
                            loc_cObsOps = ""
                        ENDIF
                        SELECT (THIS.this_cCursorDados)
                        REPLACE ObsOps WITH loc_cObsOps
                    ENDIF
                ELSE
                    *-- Com acesso: todos os registros recebem ObsOps de SigCdCe
                    SELECT (THIS.this_cCursorDados)
                    SCAN
                        loc_cConta = ContaDs
                        loc_cEmps  = ALLTRIM(Emps)
                        IF USED(THIS.this_cCursorCliE)
                            USE IN (THIS.this_cCursorCliE)
                        ENDIF
                        loc_cSQL = "SELECT ObsOps FROM SigCdCe WHERE Iclis = " + EscaparSQL(loc_cConta)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCliE) > 0
                            SELECT (THIS.this_cCursorCliE)
                            IF !EOF()
                                loc_cObsOps = ALLTRIM(ObsOps)
                            ELSE
                                loc_cObsOps = ""
                            ENDIF
                        ELSE
                            loc_cObsOps = ""
                        ENDIF
                        SELECT (THIS.this_cCursorDados)
                        IF EMPTY(loc_cObsOps)
                            REPLACE ObsOps WITH ""
                        ELSE
                            REPLACE ObsOps WITH loc_cEmps + " " + loc_cObsOps
                        ENDIF
                    ENDSCAN
                ENDIF

                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em modo preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    REPORT FORM (THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("O Envelope N" + CHR(227) + "o Foi Encontrado!!!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER PROMPT NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("O Envelope N" + CHR(227) + "o Foi Encontrado!!!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Prepara dados e imprime sem dialogo (exportacao/direto)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("O Envelope N" + CHR(227) + "o Foi Encontrado!!!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE

