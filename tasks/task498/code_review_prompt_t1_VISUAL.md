# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 215: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormPgb.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (662 linhas total):

*-- Linhas 82 a 90:
82:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
83: 
84:             *-- Caption via CHR() (proibido literal acentuado em .PRG)
85:             THIS.Caption = "Hist" + CHR(243) + "rico dos barras"
86: 
87:             *-- Cursor placeholder identico ao populado por CarregarHistorico
88:             *-- Precisa existir antes de ConfigurarLayout (ControlSource do txt_4c_Texto)
89:             SET NULL ON
90:             IF USED("cursor_4c_HistoricoPgb")

*-- Linhas 107 a 116:
107:             THIS.ConfigurarPageFrame()
108: 
109:             *-- Propaga titulo para labels do cabecalho
110:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
111:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
112: 
113:             *-- Carrega dados via SP SigPrCtb (sem conexao em modo teste)
114:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
115:                 THIS.CarregarDados()
116:             ENDIF

*-- Linhas 134 a 235:
134:     *   Nome mantido por convencao do orquestrador de migracao.
135:     *   cnt_4c_Cabecalho: cabecalho escuro com shadow + titulo branco
136:     *   shp_4c_Shape2:    separador decorativo no canto superior direito
137:     *   cmd_4c_Encerrar:  botao Encerrar (Cancel=.T. vincula ao ESC)
138:     *   shp_4c_Shape1:    borda do rodape (Shape1 original)
139:     *   txt_4c_Texto:     rodape exibindo campo Dpros do registro corrente
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE ConfigurarPageFrame()
142:         LOCAL loc_oCab, loc_oErro
143:         TRY
144:             *-- Cabecalho escuro (cntSombra original: Top=0 Left=0 W=800 H=80)
145:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
146:             loc_oCab = THIS.cnt_4c_Cabecalho
147:             WITH loc_oCab
148:                 .Top         = 0
149:                 .Left        = 0
150:                 .Width       = THIS.Width
151:                 .Height      = 80
152:                 .BorderWidth = 0
153:                 .BackStyle   = 1
154:                 .BackColor   = RGB(100, 100, 100)
155:             ENDWITH
156: 
157:             *-- Labels dentro do cabecalho (adicionar FORA do WITH para evitar bug
158:             *-- de WITH aninhado com AddObject que ignora props silenciosamente)
159:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
160:             WITH loc_oCab.lbl_4c_Sombra
161:                 .FontBold  = .T.
162:                 .FontName  = "Tahoma"
163:                 .FontSize  = 18
164:                 .WordWrap  = .T.
165:                 .AutoSize  = .F.
166:                 .Alignment = 0
167:                 .BackStyle = 0
168:                 .Caption   = ""
169:                 .Height    = 40
170:                 .Left      = 10
171:                 .Top       = 18
172:                 .Width     = 769
173:                 .ForeColor = RGB(0, 0, 0)
174:             ENDWITH
175: 
176:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
177:             WITH loc_oCab.lbl_4c_Titulo
178:                 .FontBold    = .T.
179:                 .FontName    = "Tahoma"
180:                 .FontSize    = 18
181:                 .WordWrap    = .T.
182:                 .AutoSize    = .F.
183:                 .Alignment   = 0
184:                 .BackStyle   = 0
185:                 .Caption     = ""
186:                 .Height      = 46
187:                 .Left        = 10
188:                 .Top         = 17
189:                 .Width       = 769
190:                 .ForeColor   = RGB(255, 255, 255)
191:                 .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
192:             ENDWITH
193: 
194:             *-- Shape2 decorativo (Top=7, Left=546, H=53, W=18)
195:             THIS.AddObject("shp_4c_Shape2", "Shape")
196:             WITH THIS.shp_4c_Shape2
197:                 .Top         = 7
198:                 .Left        = 546
199:                 .Height      = 53
200:                 .Width       = 18
201:                 .BackStyle   = 0
202:                 .BorderStyle = 0
203:             ENDWITH
204: 
205:             *-- Botao Encerrar (Sa?da original: Top=3, Left=575, W=75, H=75)
206:             *-- Form 650px - botao diretamente no form (sem cnt_4c_Saida container)
207:             THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
208:             WITH THIS.cmd_4c_Encerrar
209:                 .Top        = 3
210:                 .Left       = 575
211:                 .Height     = 75
212:                 .Width      = 75
213:                 .FontBold   = .T.
214:                 .FontItalic = .T.
215:                 .FontName   = "Comic Sans MS"
216:                 .FontSize   = 8
217:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
218:                 .Cancel     = .T.
219:                 .Caption    = "Encerrar"
220:                 .ForeColor  = RGB(90, 90, 90)
221:                 .BackColor  = RGB(255, 255, 255)
222:                 .Themes           = .T.
223:             ENDWITH
224:             BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
225: 
226:             *-- Shape1 borda do rodape (Top=403, Left=81, H=29, W=406)
227:             THIS.AddObject("shp_4c_Shape1", "Shape")
228:             WITH THIS.shp_4c_Shape1
229:                 .Top         = 403
230:                 .Left        = 81
231:                 .Height      = 29
232:                 .Width       = 406
233:                 .BackStyle   = 0
234:                 .BorderStyle = 1
235:             ENDWITH

*-- Linhas 242 a 251:
242:                 .FontSize      = 8
243:                 .ControlSource = "cursor_4c_HistoricoPgb.Dpros"
244:                 .Height        = 25
245:                 .Left          = 80
246:                 .Top           = 405
247:                 .Width         = 400
248:                 .ReadOnly      = .T.
249:                 .BorderStyle   = 0
250:             ENDWITH
251: 

*-- Linhas 270 a 279:
270:             THIS.AddObject("grd_4c_Dados", "Grid")
271:             loc_oGrd = THIS.grd_4c_Dados
272:             WITH loc_oGrd
273:                 .Top                 = 107
274:                 .Left                = 80
275:                 .Height              = 292
276:                 .Width               = 490
277:                 .ColumnCount         = 7
278:                 .FontName            = "Tahoma"
279:                 .FontSize            = 8

*-- Linhas 303 a 311:
303:                 .BackColor     = RGB(255, 255, 255)
304:                 .ControlSource = "cursor_4c_HistoricoPgb.Datas"
305:             ENDWITH
306:             loc_oGrd.Column1.Header1.Caption   = "Data"
307:             loc_oGrd.Column1.Header1.Alignment = 2
308: 
309:             *-- Column2: Barra (Etiqs)
310:             WITH loc_oGrd.Column2
311:                 .FontName      = "Tahoma"

*-- Linhas 317 a 325:
317:                 .BackColor     = RGB(255, 255, 255)
318:                 .ControlSource = "cursor_4c_HistoricoPgb.Etiqs"
319:             ENDWITH
320:             loc_oGrd.Column2.Header1.Caption   = "Barra"
321:             loc_oGrd.Column2.Header1.Alignment = 2
322: 
323:             *-- Column3: C.Custo (Ccustos)
324:             WITH loc_oGrd.Column3
325:                 .FontName      = "Tahoma"

*-- Linhas 331 a 339:
331:                 .BackColor     = RGB(255, 255, 255)
332:                 .ControlSource = "cursor_4c_HistoricoPgb.Ccustos"
333:             ENDWITH
334:             loc_oGrd.Column3.Header1.Caption   = "C.Custo"
335:             loc_oGrd.Column3.Header1.Alignment = 2
336: 
337:             *-- Column4: C.Custo2 (Ccusto2s)
338:             WITH loc_oGrd.Column4
339:                 .FontName      = "Tahoma"

*-- Linhas 345 a 353:
345:                 .BackColor     = RGB(255, 255, 255)
346:                 .ControlSource = "cursor_4c_HistoricoPgb.Ccusto2s"
347:             ENDWITH
348:             loc_oGrd.Column4.Header1.Caption   = "C.Custo2"
349:             loc_oGrd.Column4.Header1.Alignment = 2
350: 
351:             *-- Column5: Ocorrencia (Tpoperas) - CHR(234) = e-circunflexo
352:             WITH loc_oGrd.Column5
353:                 .FontName      = "Tahoma"

*-- Linhas 359 a 367:
359:                 .BackColor     = RGB(255, 255, 255)
360:                 .ControlSource = "cursor_4c_HistoricoPgb.Tpoperas"
361:             ENDWITH
362:             loc_oGrd.Column5.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
363:             loc_oGrd.Column5.Header1.Alignment = 2
364: 
365:             *-- Column6: Oper (Tplancs - plano de contas/lancamento)
366:             WITH loc_oGrd.Column6
367:                 .FontName      = "Tahoma"

*-- Linhas 373 a 394:
373:                 .BackColor     = RGB(255, 255, 255)
374:                 .ControlSource = "cursor_4c_HistoricoPgb.Tplancs"
375:             ENDWITH
376:             loc_oGrd.Column6.Header1.Caption   = "Oper"
377:             loc_oGrd.Column6.Header1.Alignment = 2
378: 
379:             *-- Column7: Dt.Base (Dtbases)
380:             WITH loc_oGrd.Column7
381:                 .FontName      = "Tahoma"
382:                 .FontSize      = 8
383:                 .Width         = 66
384:                 .ReadOnly      = .T.
385:                 .ForeColor     = RGB(0, 0, 0)
386:                 .BackColor     = RGB(255, 255, 255)
387:                 .ControlSource = "cursor_4c_HistoricoPgb.Dtbases"
388:             ENDWITH
389:             loc_oGrd.Column7.Header1.Caption   = "Dt.Base"
390:             loc_oGrd.Column7.Header1.Alignment = 2
391: 
392:             *-- RecordSource definido apos todos os ControlSources para evitar auto-bind do VFP
393:             loc_oGrd.ColumnCount = 3
394:             loc_oGrd.RecordSource = "cursor_4c_HistoricoPgb"

*-- Linhas 429 a 443:
429:                     THIS.grd_4c_Dados.Column5.ControlSource   = "cursor_4c_HistoricoPgb.Tpoperas"
430:                     THIS.grd_4c_Dados.Column6.ControlSource   = "cursor_4c_HistoricoPgb.Tplancs"
431:                     THIS.grd_4c_Dados.Column7.ControlSource   = "cursor_4c_HistoricoPgb.Dtbases"
432:                     THIS.grd_4c_Dados.Column1.Header1.Caption = "Data"
433:                     THIS.grd_4c_Dados.Column2.Header1.Caption = "Barra"
434:                     THIS.grd_4c_Dados.Column3.Header1.Caption = "C.Custo"
435:                     THIS.grd_4c_Dados.Column4.Header1.Caption = "C.Custo2"
436:                     THIS.grd_4c_Dados.Column5.Header1.Caption = "Ocorr" + CHR(234) + "ncia"
437:                     THIS.grd_4c_Dados.Column6.Header1.Caption = "Oper"
438:                     THIS.grd_4c_Dados.Column7.Header1.Caption = "Dt.Base"
439:                     THIS.grd_4c_Dados.Refresh()
440:                 ENDIF
441:                 IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
442:                     THIS.txt_4c_Texto.Refresh()
443:                 ENDIF


### BO (C:\4c\projeto\app\classes\PgbBO.prg):
*==============================================================================
* PgbBO.prg - Business Object para Historico dos Barras
* Herda de: BusinessBase
* Form: FormPgb.prg (OPERACIONAL - somente leitura)
*==============================================================================

DEFINE CLASS PgbBO AS BusinessBase

    *-- Parametros de entrada recebidos pelo form
    this_cEmps  = ""   && Codigo da empresa
    this_cDopes = ""   && Codigo da operacao/documento
    this_nNumes = 0    && Numero do documento

    *-- Descricao exibida no rodape (campo dpros do cursor)
    this_cDescricao = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()

        this_cTabela     = "SigPrCtb"
        this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional nao tem PK unica
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarHistorico - Executa SP SigPrCtb para carregar historico de barras
    *   par_cEmps  = codigo empresa (3 chars)
    *   par_cDopes = codigo operacao/documento
    *   par_nNumes = numero do documento
    * Retorna .T. se ok, .F. se erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarHistorico(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_lSucesso, loc_oErro, loc_cParam, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            *-- Cursor placeholder identico ao que o SQLEXEC vai popular
            SET NULL ON
            IF USED("cursor_4c_HistoricoPgb")
                USE IN cursor_4c_HistoricoPgb
            ENDIF
            CREATE CURSOR cursor_4c_HistoricoPgb ;
                (Datas    D    NULL, ;
                 Etiqs    C(30) NULL, ;
                 Ccustos  C(20) NULL, ;
                 Ccusto2s C(20) NULL, ;
                 Tpoperas C(40) NULL, ;
                 Tplancs  C(10) NULL, ;
                 Dtbases  D    NULL, ;
                 Dpros    C(60) NULL)
            SET NULL OFF

            *-- Parametro concatenado igual ao legado: Emp + Dope + STR(Nume, 6)
            loc_cParam = ALLTRIM(par_cEmps) + ALLTRIM(par_cDopes) + STR(par_nNumes, 6)
            loc_cSQL   = "EXEC SigPrCtb @EmpdopNums = " + EscaparSQL(loc_cParam)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistPgbTemp")

            IF loc_nResult > 0
                SELECT cursor_4c_HistoricoPgb
                ZAP
                APPEND FROM DBF("cursor_4c_HistPgbTemp")
                IF USED("cursor_4c_HistPgbTemp")
                    USE IN cursor_4c_HistPgbTemp
                ENDIF
                SELECT cursor_4c_HistoricoPgb
                IF RECCOUNT() > 0
                    GO BOTTOM
                ENDIF
                loc_lSucesso = .T.
            ELSE
                LOCAL loc_aErroSQL[1]
                AERROR(loc_aErroSQL)
                MsgErro("Erro ao carregar hist" + CHR(243) + "rico de barras:" + CHR(13) + ;
                        loc_aErroSQL[2], "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarHistorico")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o registro corrente do cursor de historico
    *   para as propriedades da instancia (Text1 do rodape mostra Dpros)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         par_cAliasCursor, "cursor_4c_HistoricoPgb")

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor de hist" + CHR(243) + "rico n" + CHR(227) + ;
                                      "o est" + CHR(225) + " aberto: " + loc_cAlias
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        IF RECCOUNT() = 0 OR EOF()
            RETURN .F.
        ENDIF

        *-- Rodape do form legado (Text1) exibe Dpros do registro corrente
        IF TYPE(loc_cAlias + ".Dpros") = "C"
            THIS.this_cDescricao = TratarNulo(EVALUATE(loc_cAlias + ".Dpros"), "C")
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Form de historico eh SOMENTE LEITURA
    *   Historico de barras eh populado por SP SigPrCtb, nunca por INSERT direto.
    *   Chamada indevida (via BusinessBase.Salvar) informa o motivo e retorna .F.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de hist" + CHR(243) + ;
                                  "rico dos barras " + CHR(233) + " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de INSER" + CHR(199) + ;
                                  CHR(195) + "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Form de historico eh SOMENTE LEITURA
    *   Registros vem da SP SigPrCtb; UPDATE direto nao eh suportado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de hist" + CHR(243) + ;
                                  "rico dos barras " + CHR(233) + " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de ATUALIZA" + CHR(199) + ;
                                  CHR(195) + "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Form de historico eh SOMENTE LEITURA
    *   Registros historicos nao devem ser removidos manualmente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de hist" + CHR(243) + ;
                                  "rico dos barras " + CHR(233) + " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de EXCLUS" + CHR(195) + ;
                                  "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

ENDDEFINE

