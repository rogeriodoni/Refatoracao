# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 167: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 191: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFis.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1084 linhas total):

*-- Linhas 102 a 383:
102:     PROTECTED PROCEDURE ConfigurarCabecalho()
103:         THIS.AddObject("cnt_4c_Sombra", "Container")
104:         WITH THIS.cnt_4c_Sombra
105:             .Top         = 0
106:             .Left        = -1
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BorderWidth = 0
110:             .BackStyle   = 1
111:             .BackColor   = RGB(100,100,100)
112:             .Visible     = .T.
113:         ENDWITH
114: 
115:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
116:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
117:             .FontBold      = .T.
118:             .FontName      = "Tahoma"
119:             .FontSize      = 18
120:             .FontUnderline = .F.
121:             .WordWrap      = .T.
122:             .Alignment     = 0
123:             .AutoSize      = .F.
124:             .BackStyle     = 0
125:             .Height        = 40
126:             .Left          = 10
127:             .Top           = 18
128:             .Width         = 769
129:             .ForeColor     = RGB(0,0,0)
130:             .Caption       = "Cadastro da Impressora Fiscal"
131:         ENDWITH
132: 
133:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
134:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
135:             .FontBold      = .T.
136:             .FontName      = "Tahoma"
137:             .FontSize      = 18
138:             .WordWrap      = .T.
139:             .Alignment     = 0
140:             .AutoSize      = .F.
141:             .BackStyle     = 0
142:             .Height        = 46
143:             .Left          = 10
144:             .Top           = 17
145:             .Width         = 769
146:             .ForeColor     = RGB(255,255,255)
147:             .Caption       = "Cadastro da Impressora Fiscal"
148:         ENDWITH
149:     ENDPROC
150: 
151:     *==========================================================================
152:     * ConfigurarBotoes
153:     * Botoes Confirmar e Encerrar standalone (Ok e cancela do legado)
154:     * Standalone com Picture requer Themes=.T. + DisabledPicture
155:     *==========================================================================
156:     PROTECTED PROCEDURE ConfigurarBotoes()
157:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
158:         WITH THIS.cmd_4c_Confirmar
159:             .Top             = 3
160:             .Left            = 649
161:             .Width           = 75
162:             .Height          = 75
163:             .Caption         = "Confirmar"
164:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
165:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
166:             .Themes          = .T.
167:             .FontName        = "Comic Sans MS"
168:             .FontBold        = .T.
169:             .FontItalic      = .T.
170:             .FontSize        = 8
171:             .ForeColor       = RGB(90,90,90)
172:             .BackColor       = RGB(255,255,255)
173:             .SpecialEffect   = 0
174:             .PicturePosition = 13
175:             .MousePointer    = 15
176:             .WordWrap        = .T.
177:             .AutoSize        = .F.
178:         ENDWITH
179:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
180: 
181:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
182:         WITH THIS.cmd_4c_Encerrar
183:             .Top             = 3
184:             .Left            = 724
185:             .Width           = 75
186:             .Height          = 75
187:             .Caption         = "Encerrar"
188:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
189:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
190:             .Themes          = .T.
191:             .FontName        = "Comic Sans MS"
192:             .FontBold        = .T.
193:             .FontItalic      = .T.
194:             .FontSize        = 8
195:             .ForeColor       = RGB(90,90,90)
196:             .BackColor       = RGB(255,255,255)
197:             .SpecialEffect   = 0
198:             .PicturePosition = 13
199:             .MousePointer    = 15
200:             .WordWrap        = .T.
201:             .AutoSize        = .F.
202:             .Cancel          = .T.
203:         ENDWITH
204:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
205:     ENDPROC
206: 
207:     *==========================================================================
208:     * ConfigurarCampos
209:     * Labels, Spinner, ComboBoxes, TextBox e CheckBoxes - identicos ao legado
210:     *==========================================================================
211:     PROTECTED PROCEDURE ConfigurarCampos()
212:         *-- Porta de Comunicacao
213:         THIS.AddObject("lbl_4c_Label1", "Label")
214:         WITH THIS.lbl_4c_Label1
215:             .FontName  = "Tahoma"
216:             .FontSize  = 8
217:             .ForeColor = RGB(90,90,90)
218:             .BackStyle = 0
219:             .AutoSize  = .F.
220:             .Left      = 79
221:             .Top       = 101
222:             .Width     = 120
223:             .Height    = 18
224:             .Caption   = "Porta de Comunica" + CHR(231) + CHR(227) + "o : "
225:         ENDWITH
226: 
227:         THIS.AddObject("obj_4c_Spinner1", "Spinner")
228:         WITH THIS.obj_4c_Spinner1
229:             .FontName          = "Tahoma"
230:             .FontSize          = 8
231:             .ForeColor         = RGB(90,90,90)
232:             .Height            = 25
233:             .Left              = 202
234:             .Top               = 96
235:             .Width             = 48
236:             .KeyboardHighValue = 10
237:             .KeyboardLowValue  = 1
238:             .SpinnerHighValue  = 10
239:             .SpinnerLowValue   = 1
240:             .ToolTipText       = "Escolher COM9 para setar USB"
241:             .Value             = 1
242:             .ControlSource     = "CrSigFiFis.Portas"
243:         ENDWITH
244: 
245:         *-- HandShaking
246:         THIS.AddObject("lbl_4c_Label2", "Label")
247:         WITH THIS.lbl_4c_Label2
248:             .FontName  = "Tahoma"
249:             .FontSize  = 8
250:             .ForeColor = RGB(90,90,90)
251:             .BackStyle = 0
252:             .AutoSize  = .F.
253:             .Left      = 124
254:             .Top       = 128
255:             .Width     = 75
256:             .Height    = 18
257:             .Caption   = "HandShaking : "
258:         ENDWITH
259: 
260:         THIS.AddObject("cbo_4c_CmbHand", "ComboBox")
261:         WITH THIS.cbo_4c_CmbHand
262:             .FontName      = "Tahoma"
263:             .FontSize      = 8
264:             .ForeColor     = RGB(90,90,90)
265:             .RowSourceType = 0
266:             .Height        = 24
267:             .Left          = 202
268:             .Top           = 123
269:             .Width         = 141
270:             .ControlSource = "CrSigFiFis.Hands"
271:         ENDWITH
272: 
273:         *-- Settings (ex: 9600,n,8,1)
274:         THIS.AddObject("lbl_4c_Label3", "Label")
275:         WITH THIS.lbl_4c_Label3
276:             .FontName  = "Tahoma"
277:             .FontSize  = 8
278:             .ForeColor = RGB(90,90,90)
279:             .BackStyle = 0
280:             .AutoSize  = .F.
281:             .Left      = 147
282:             .Top       = 153
283:             .Width     = 52
284:             .Height    = 18
285:             .Caption   = "Settings : "
286:         ENDWITH
287: 
288:         THIS.AddObject("txt_4c_Set", "TextBox")
289:         WITH THIS.txt_4c_Set
290:             .FontName      = "Tahoma"
291:             .FontSize      = 8
292:             .ForeColor     = RGB(90,90,90)
293:             .Left          = 202
294:             .Top           = 149
295:             .Width         = 141
296:             .Height        = 23
297:             .Value         = ""
298:             .ControlSource = "CrSigFiFis.Settings"
299:         ENDWITH
300: 
301:         *-- DTRenable
302:         THIS.AddObject("lbl_4c_Label4", "Label")
303:         WITH THIS.lbl_4c_Label4
304:             .FontName  = "Tahoma"
305:             .FontSize  = 8
306:             .ForeColor = RGB(90,90,90)
307:             .BackStyle = 0
308:             .AutoSize  = .F.
309:             .Left      = 134
310:             .Top       = 192
311:             .Width     = 65
312:             .Height    = 18
313:             .Caption   = "DTRenable : "
314:         ENDWITH
315: 
316:         THIS.AddObject("chk_4c_ChkDtr", "CheckBox")
317:         WITH THIS.chk_4c_ChkDtr
318:             .Top           = 191
319:             .Left          = 202
320:             .AutoSize      = .T.
321:             .Alignment     = 0
322:             .BackStyle     = 0
323:             .Caption       = ""
324:             .Value         = 0
325:             .ControlSource = "CrSigFiFis.Dtrs"
326:         ENDWITH
327: 
328:         *-- RTSenable
329:         THIS.AddObject("lbl_4c_Label5", "Label")
330:         WITH THIS.lbl_4c_Label5
331:             .FontName  = "Tahoma"
332:             .FontSize  = 8
333:             .ForeColor = RGB(90,90,90)
334:             .BackStyle = 0
335:             .AutoSize  = .F.
336:             .Left      = 135
337:             .Top       = 212
338:             .Width     = 64
339:             .Height    = 18
340:             .Caption   = "RTSenable : "
341:         ENDWITH
342: 
343:         THIS.AddObject("chk_4c_ChkRts", "CheckBox")
344:         WITH THIS.chk_4c_ChkRts
345:             .Top           = 211
346:             .Left          = 202
347:             .AutoSize      = .T.
348:             .Alignment     = 0
349:             .BackStyle     = 0
350:             .Caption       = ""
351:             .Value         = 0
352:             .ControlSource = "CrSigFiFis.Rtss"
353:         ENDWITH
354: 
355:         *-- Impressora
356:         THIS.AddObject("lbl_4c_Label6", "Label")
357:         WITH THIS.lbl_4c_Label6
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .ForeColor = RGB(90,90,90)
361:             .BackStyle = 0
362:             .AutoSize  = .F.
363:             .Left      = 132
364:             .Top       = 236
365:             .Width     = 67
366:             .Height    = 18
367:             .Caption   = "Impressora : "
368:         ENDWITH
369: 
370:         THIS.AddObject("cbo_4c_CmbImp", "ComboBox")
371:         WITH THIS.cbo_4c_CmbImp
372:             .FontName      = "Tahoma"
373:             .FontSize      = 8
374:             .ForeColor     = RGB(90,90,90)
375:             .RowSourceType = 0
376:             .Height        = 24
377:             .Left          = 202
378:             .Top           = 231
379:             .Width         = 141
380:             .ControlSource = "CrSigFiFis.Imps"
381:         ENDWITH
382: 
383:         THIS.PopularComboBoxes()

*-- Linhas 470 a 478:
470:     * SigCdFis eh dialog PLANO sem PageFrame ??? nao ha Page2/Dados fisica.
471:     * Esta rotina mantem o papel arquitetural de "configurar area de edicao de
472:     * dados" delegando para os helpers ja construidos em ConfigurarCampos
473:     * (Spinner Portas, ComboBox HandShaking, TextBox Settings, CheckBox DTR/RTS
474:     * e ComboBox Impressora). Rebinda tambem os ControlSources para garantir
475:     * sincronia com o cursor CrSigFiFis apos qualquer refresh.
476:     *==========================================================================
477:     PROTECTED PROCEDURE ConfigurarPaginaDados()
478:         LOCAL loc_lSucesso

*-- Linhas 920 a 929:
920:             IF PEMSTATUS(THIS, "cbo_4c_CmbImp", 5)
921:                 THIS.cbo_4c_CmbImp.Enabled = loc_lHabilitar
922:             ENDIF
923:             IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
924:                 THIS.cmd_4c_Confirmar.Enabled = loc_lHabilitar
925:             ENDIF
926: 
927:         CATCH TO loc_oErro
928:             MsgErro(loc_oErro.Message + CHR(13) + ;
929:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1025 a 1037:
1025:         LOCAL loc_oErro
1026: 
1027:         TRY
1028:             IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
1029:                 THIS.cmd_4c_Confirmar.Enabled = .T.
1030:             ENDIF
1031:             IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
1032:                 THIS.cmd_4c_Encerrar.Enabled = .T.
1033:             ENDIF
1034: 
1035:         CATCH TO loc_oErro
1036:             MsgErro(loc_oErro.Message + CHR(13) + ;
1037:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;


### BO (C:\4c\projeto\app\classes\FisBO.prg):
*============================================================================
* FisBO.prg - Business Object para Configura" + CHR(231) + CHR(227) + "o de Impressora Fiscal
* Entidade  : Fis  (SIGCDFIS)
* Origem    : SigCdFis.SCX
* Arquitetura: BusinessBase sem tabela SQL - persiste em arquivo local SetFiscal.Ini
*============================================================================

DEFINE CLASS FisBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da "tabela" - form nao tem tabela SQL Server
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * Propriedades - campos do cursor CrSigFiFis
    * CrSigFiFis (Portas n(1), Hands c(20), Settings c(20), Dtrs L, Rtss L, Imps c(20), Termicas L)
    *--------------------------------------------------------------------------
    this_nPorta       = 1     && Porta de comunica" + CHR(231) + CHR(227) + "o COM (1-10; valor 9 = USB)
    this_cHandshaking = ""    && Tipo de HandShaking (c20): "0-None", "1-Xon Xoff", "2-RTS", ""
    this_cSettings    = ""    && Par" + CHR(226) + "metros seriais (c20): ex. "9600,n,8,1"
    this_lDtr         = .F.   && DTR enable
    this_lRts         = .F.   && RTS enable
    this_cImpressora  = ""    && Modelo de impressora fiscal (c20)
    this_lTermica     = .F.   && Impressora t" + CHR(233) + "rmica

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de controle de arquivo
    *--------------------------------------------------------------------------
    this_cArqFiscal   = ""    && Path completo de SetFiscal.Ini (SYS(5)+SYS(2003)+\SetFiscal.Ini)
    this_cArqBema     = ""    && Path de BEMAFI32.INI (%SystemRoot%\system32\BEMAFI32.INI)
    this_cArqDaruma   = ""    && Path de DarumaFramework.xml (SYS(5)+SYS(2003)+\DarumaFramework.xml)

    *==========================================================================
    * Init
    * Configura BO sem tabela SQL. Resolve paths dos arquivos de configuracao.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        TRY
            this_cTabela     = ""
            this_cCampoChave = ""

            *-- Paths dos arquivos de configuracao fiscal
            this_cArqFiscal = SYS(5) + SYS(2003) + "\SetFiscal.Ini"
            this_cArqBema   = GETENV("SystemRoot") + "\system32\BEMAFI32.INI"
            this_cArqDaruma = SYS(5) + SYS(2003) + "\DarumaFramework.xml"

            loc_lSucesso = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarCursor
    * Cria cursor CrSigFiFis com estrutura identica ao legado (Load event)
    *==========================================================================
    PROCEDURE InicializarCursor()
        LOCAL loc_lSucesso

        TRY
            IF USED("CrSigFiFis")
                USE IN CrSigFiFis
            ENDIF

            CREATE CURSOR CrSigFiFis (Portas n(1), Hands c(20), Settings c(20), Dtrs L, Rtss L, Imps c(20), Termicas L)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.InicializarCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDeArquivo
    * Equivalente a fLerFiscal() do legado.
    * Le SetFiscal.Ini e popula cursor CrSigFiFis com valores default.
    *==========================================================================
    PROCEDURE CarregarDeArquivo()
        LOCAL loc_lSucesso

        TRY
            IF !USED("CrSigFiFis")
                THIS.InicializarCursor()
            ENDIF

            SELECT CrSigFiFis
            ZAP

            IF FILE(THIS.this_cArqFiscal)
                APPEND FROM (THIS.this_cArqFiscal) TYPE SDF
            ENDIF

            SELECT CrSigFiFis
            GO TOP

            IF EOF()
                APPEND BLANK
            ENDIF

            IF EMPTY(CrSigFiFis.Settings)
                REPLACE CrSigFiFis.Settings WITH "9600,n,8,1"
            ENDIF

            IF ALLTRIM(CrSigFiFis.Imps) = ""
                REPLACE CrSigFiFis.Imps WITH "Em Branco   "
            ENDIF

            IF ALLTRIM(CrSigFiFis.Hands) = ""
                REPLACE CrSigFiFis.Hands WITH "Em Branco   "
            ENDIF

            THIS.CarregarDoCursor("CrSigFiFis")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.CarregarDeArquivo")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor
    * Mapeia campos do cursor CrSigFiFis para propriedades do BO
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nPorta       = NVL(Portas,   1)
                THIS.this_cHandshaking = ALLTRIM(NVL(Hands,    ""))
                THIS.this_cSettings    = ALLTRIM(NVL(Settings, ""))
                THIS.this_lDtr         = NVL(Dtrs,     .F.)
                THIS.this_lRts         = NVL(Rtss,     .F.)
                THIS.this_cImpressora  = ALLTRIM(NVL(Imps,     ""))
                THIS.this_lTermica     = NVL(Termicas, .F.)
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarConfiguracao
    * Persiste configuracao em SetFiscal.Ini, BEMAFI32.INI e DarumaFramework.xml.
    * Equivalente ao Ok.Click do legado.
    *==========================================================================
    PROCEDURE SalvarConfiguracao()
        LOCAL loc_lSucesso, loc_cConfig, loc_cComs, loc_cNewCon, loc_cPor, loc_cVel

        TRY
            IF !USED("CrSigFiFis")
                MsgErro("Cursor CrSigFiFis n" + CHR(227) + "o inicializado.", ;
                        "Erro em SalvarConfiguracao")
                loc_lSucesso = .F.
            ELSE
                SELECT CrSigFiFis
                GO TOP

                *-- Normalizar "Em Branco" para vazio antes de gravar no arquivo
                IF ALLTRIM(CrSigFiFis.Imps) = "Em Branco"
                    REPLACE CrSigFiFis.Imps WITH ""
                ENDIF

                IF ALLTRIM(CrSigFiFis.Hands) = "Em Branco"
                    REPLACE CrSigFiFis.Hands WITH ""
                ENDIF

                *-- Gravar SetFiscal.Ini via SDF (formato de campo fixo)
                SELECT CrSigFiFis
                GO TOP
                COPY TO (THIS.this_cArqFiscal) TYPE SDF

                *-- Atualizar porta em BEMAFI32.INI (Bematech)
                IF FILE(THIS.this_cArqBema)
                    loc_cConfig = FILETOSTR(THIS.this_cArqBema)
                    loc_cComs   = STREXTRACT(loc_cConfig, "Porta", CHR(13) + CHR(10), 1, 1)
                    loc_cPor    = ALLTRIM(TRANSFORM(THIS.this_nPorta))
                    IF loc_cPor = "9"
                        loc_cNewCon = STRTRAN(loc_cConfig, "Porta" + loc_cComs, "Porta=USB", -1, 1, 1)
                    ELSE
                        loc_cNewCon = STRTRAN(loc_cConfig, "Porta" + loc_cComs, "Porta=COM" + loc_cPor, -1, 1, 1)
                    ENDIF
                    STRTOFILE(loc_cNewCon, THIS.this_cArqBema)
                ENDIF

                *-- Atualizar porta e velocidade em DarumaFramework.xml (Daruma)
                IF FILE(THIS.this_cArqDaruma)
                    loc_cConfig = FILETOSTR(THIS.this_cArqDaruma)
                    loc_cPor    = ALLTRIM(TRANSFORM(THIS.this_nPorta))

                    *-- Atualizar PortaSerial
                    loc_cComs   = STREXTRACT(loc_cConfig, "<PortaSerial>", CHR(13) + CHR(10), 1, 1)
                    loc_cNewCon = STRTRAN(loc_cConfig, "<PortaSerial>" + loc_cComs, ;
                                  "<PortaSerial>COM" + loc_cPor + "</PortaSerial>", -1, 1, 1)

                    *-- Atualizar Velocidade (primeiro campo antes da virgula em Settings)
                    SELECT CrSigFiFis
                    GO TOP
                    IF AT(",", ALLTRIM(CrSigFiFis.Settings)) > 0
                        loc_cVel = SUBSTR(ALLTRIM(CrSigFiFis.Settings), 1, ;
                                   AT(",", ALLTRIM(CrSigFiFis.Settings)) - 1)
                    ELSE
                        loc_cVel = "9600"
                    ENDIF
                    loc_cComs   = STREXTRACT(loc_cNewCon, "<Velocidade>", CHR(13) + CHR(10), 2, 1)
                    loc_cNewCon = STRTRAN(loc_cNewCon, "<Velocidade>" + loc_cComs, ;
                                  "<Velocidade>" + loc_cVel + "</Velocidade>", -1, 1, 1)

                    STRTOFILE(loc_cNewCon, THIS.this_cArqDaruma)
                ENDIF

                *-- Recarregar propriedades do BO apos normalizar
                THIS.CarregarDoCursor("CrSigFiFis")

                THIS.CarregarProcedureFiscal(THIS.this_cImpressora)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.SalvarConfiguracao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarProcedureFiscal
    * Libera procedure fiscal anterior e carrega nova conforme modelo de impressora.
    * Equivalente ao DO CASE de SET PROCEDURE no Ok.Click do legado.
    *==========================================================================
    PROCEDURE CarregarProcedureFiscal(par_cImpressora)
        LOCAL loc_lSucesso

        TRY
            *-- Liberar procedure fiscal previamente carregada
            DO CASE
                CASE ATC("SIGFIOP5", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP5.Prg
                CASE ATC("SIGFIOP4", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP4.Prg
                CASE ATC("SIGFIOP3", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP3.Prg
                CASE ATC("SIGFIOP0", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP0.Prg
                CASE ATC("SIGFIOP2", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP2.Prg
                CASE ATC("SIGFIOP1", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP1.Prg
                CASE ATC("SIGFIOP8", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP8.Prg
            ENDCASE

            *-- Carregar procedure correspondente ao modelo
            DO CASE
                CASE ALLTRIM(par_cImpressora) == "SWEDA"
                    SET PROCEDURE TO SIGFIOP0.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "BEMATECH"
                    SET PROCEDURE TO SIGFIOP1.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "BEMA8501"
                    SET PROCEDURE TO SIGFIOP2.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "DATAREGIS"
                    SET PROCEDURE TO SIGFIOP3.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "NDATAREGIS"
                    SET PROCEDURE TO SIGFIOP4.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "DARUMA"
                    SET PROCEDURE TO SIGFIOP5.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "S/IMPRESSORA"
                    SET PROCEDURE TO SIGFIOP9.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "NSWEDA"
                    SET PROCEDURE TO SIGFIOP8.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "EPSON"
                    SET PROCEDURE TO SIGFIOP7.Prg ADDITIVE
            ENDCASE

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.CarregarProcedureFiscal")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria
    * Form nao possui tabela SQL - retorna vazio
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar
    * Form nao usa SQL - delegam para SalvarConfiguracao
    *==========================================================================
    PROCEDURE Inserir()
        RETURN THIS.SalvarConfiguracao()
    ENDPROC

    PROCEDURE Atualizar()
        RETURN THIS.SalvarConfiguracao()
    ENDPROC

ENDDEFINE

