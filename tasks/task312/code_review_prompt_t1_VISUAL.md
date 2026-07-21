# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 185: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 213: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRMEI.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (700 linhas total):

*-- Linhas 63 a 71:
63:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
64: 
65:                 *-- Titulo com acentuacao via CHR (PILAR 1: fidelidade ao caption legado)
66:                 THIS.Caption = "Integra" + CHR(231) + CHR(227) + "o SIS E-Commerce"
67: 
68:                 *-- Carregar configuracoes operacionais de SigCdPam
69:                 loc_cSQL = "SELECT DirLivrosV, CdChepSais, Mascnums, CdChepEnts FROM SigCdPam"
70:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
71:                 IF loc_nRet > 0

*-- Linhas 113 a 191:
113: 
114:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
115:         WITH THIS.cnt_4c_Cabecalho
116:             .Top         = -1
117:             .Left        = -1
118:             .Width       = THIS.Width
119:             .Height      = 80
120:             .BackStyle   = 1
121:             .BackColor   = RGB(100, 100, 100)
122:             .BorderWidth = 0
123:             .Visible     = .T.
124:         ENDWITH
125: 
126:         loc_oCab = THIS.cnt_4c_Cabecalho
127: 
128:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oCab.lbl_4c_Sombra
130:             .Top           = 18
131:             .Left          = 10
132:             .Width         = THIS.Width
133:             .Height        = 40
134:             .AutoSize      = .F.
135:             .FontBold      = .T.
136:             .FontName      = "Tahoma"
137:             .FontSize      = 18
138:             .FontUnderline = .F.
139:             .WordWrap      = .T.
140:             .Alignment     = 0
141:             .BackStyle     = 0
142:             .ForeColor     = RGB(0, 0, 0)
143:             .Caption       = THIS.Caption
144:             .Visible       = .T.
145:         ENDWITH
146: 
147:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oCab.lbl_4c_Titulo
149:             .Top          = 17
150:             .Left         = 10
151:             .Width        = THIS.Width
152:             .Height       = 46
153:             .AutoSize     = .F.
154:             .FontBold     = .T.
155:             .FontName     = "Tahoma"
156:             .FontSize     = 18
157:             .WordWrap     = .T.
158:             .Alignment    = 0
159:             .BackStyle    = 0
160:             .ForeColor    = RGB(255, 255, 255)
161:             .ToolTipText  = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
162:             .Caption      = THIS.Caption
163:             .Visible      = .T.
164:         ENDWITH
165:     ENDPROC
166: 
167:     *--------------------------------------------------------------------------
168:     * ConfigurarBotoes - Botoes Processar e Encerrar sobrepostos ao cabecalho
169:     *--------------------------------------------------------------------------
170:     PROTECTED PROCEDURE ConfigurarBotoes()
171: 
172:         *-- Botao Processar
173:         THIS.AddObject("btn_4c_Processar", "CommandButton")
174:         WITH THIS.btn_4c_Processar
175:             .Top             = 3
176:             .Left            = 340
177:             .Width           = 75
178:             .Height          = 75
179:             .Caption         = "Processar"
180:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
181:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
182:             .ToolTipText     = "Processar"
183:             .FontBold        = .T.
184:             .FontItalic      = .T.
185:             .FontName        = "Comic Sans MS"
186:             .FontSize        = 8
187:             .ForeColor       = RGB(90, 90, 90)
188:             .BackColor       = RGB(255, 255, 255)
189:             .Themes          = .T.
190:             .WordWrap        = .T.
191:             .AutoSize        = .F.

*-- Linhas 199 a 219:
199:         *-- Botao Encerrar
200:         THIS.AddObject("btn_4c_Encerrar", "CommandButton")
201:         WITH THIS.btn_4c_Encerrar
202:             .Top             = 3
203:             .Left            = 420
204:             .Width           = 75
205:             .Height          = 75
206:             .Caption         = "Encerrar"
207:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
208:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
209:             .Cancel          = .T.
210:             .ToolTipText     = "[ESC] Sair"
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .FontName        = "Comic Sans MS"
214:             .FontSize        = 8
215:             .ForeColor       = RGB(90, 90, 90)
216:             .BackColor       = RGB(255, 255, 255)
217:             .Themes          = .T.
218:             .WordWrap        = .T.
219:             .AutoSize        = .F.

*-- Linhas 231 a 267:
231:     PROTECTED PROCEDURE ConfigurarLabels()
232: 
233:         *-- Label de identificacao do sistema (Label2 no legado)
234:         THIS.AddObject("lbl_4c_Info", "Label")
235:         WITH THIS.lbl_4c_Info
236:             .FontBold    = .T.
237:             .FontName    = "Tahoma"
238:             .FontSize    = 8
239:             .BackStyle   = 0
240:             .BorderStyle = 0
241:             .Caption     = "Integra" + CHR(231) + CHR(227) + "o Sis e-Commerce"
242:             .Height      = 20
243:             .Left        = 147
244:             .Top         = 96
245:             .Width       = 205
246:             .ForeColor   = RGB(90, 90, 90)
247:             .BackColor   = RGB(255, 255, 234)
248:             .Visible     = .T.
249:         ENDWITH
250: 
251:         *-- Label de status do processamento (Label1 no legado - atualizado dinamicamente)
252:         THIS.AddObject("lbl_4c_Status", "Label")
253:         WITH THIS.lbl_4c_Status
254:             .FontBold    = .T.
255:             .FontName    = "Tahoma"
256:             .FontSize    = 8
257:             .BackStyle   = 0
258:             .BorderStyle = 0
259:             .Caption     = ""
260:             .Height      = 20
261:             .Left        = 56
262:             .Top         = 114
263:             .Width       = 387
264:             .ForeColor   = RGB(90, 90, 90)
265:             .BackColor   = RGB(255, 255, 234)
266:             .Visible     = .T.
267:         ENDWITH

*-- Linhas 288 a 303:
288:         loc_lnMov = 1
289:         DO WHILE .T.
290:             THIS.btn_4c_Encerrar.Enabled = .F.
291:             THIS.lbl_4c_Status.Caption = "Aguardando Arquivos Para Processar" + REPLICATE(".", loc_lnMov)
292:             loc_lnMov = IIF(loc_lnMov < 5, loc_lnMov + 1, 1)
293: 
294:             loc_llOk1 = THIS.this_oBusinessObject.LerArquivos()
295:             loc_llOk2 = THIS.this_oBusinessObject.GravarArquivos()
296: 
297:             IF !EMPTY(THIS.this_oBusinessObject.this_cUltStatus)
298:                 THIS.lbl_4c_Status.Caption = THIS.this_oBusinessObject.this_cUltStatus
299:             ENDIF
300: 
301:             THIS.btn_4c_Encerrar.Enabled = .T.
302: 
303:             *-- Aguardar 0.5s capturando input do usuario

*-- Linhas 319 a 327:
319:         ENDDO
320: 
321:         SET CURSOR ON
322:         THIS.lbl_4c_Status.Caption = ""
323:         THIS.btn_4c_Processar.Enabled = .T.
324: 
325:         IF THIS.this_lParametrizado
326:             THIS.Release()
327:             QUIT

*-- Linhas 348 a 370:
348: 
349:         THIS.btn_4c_Processar.Enabled = .F.
350:         THIS.btn_4c_Encerrar.Enabled  = .F.
351:         THIS.lbl_4c_Status.Caption    = "Processando novo lote..."
352: 
353:         TRY
354:             loc_llOk1 = THIS.this_oBusinessObject.LerArquivos()
355:             loc_llOk2 = THIS.this_oBusinessObject.GravarArquivos()
356: 
357:             IF !EMPTY(THIS.this_oBusinessObject.this_cUltStatus)
358:                 THIS.lbl_4c_Status.Caption = THIS.this_oBusinessObject.this_cUltStatus
359:             ELSE
360:                 THIS.lbl_4c_Status.Caption = IIF(loc_llOk1 AND loc_llOk2, ;
361:                     "Lote processado com sucesso.", ;
362:                     "Falha no processamento do lote.")
363:             ENDIF
364:         CATCH TO loc_oErro
365:             THIS.lbl_4c_Status.Caption = "Erro: " + loc_oErro.Message
366:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
367:                 " PROC=" + loc_oErro.Procedure, "FormSIGPRMEI.BtnIncluirClick")
368:         ENDTRY
369: 
370:         THIS.btn_4c_Processar.Enabled = .T.

*-- Linhas 436 a 444:
436: 
437:         THIS.btn_4c_Processar.Enabled = .T.
438:         THIS.btn_4c_Encerrar.Enabled  = .T.
439:         THIS.lbl_4c_Status.Caption    = ""
440: 
441:         THIS.Release()
442:     ENDPROC
443: 
444:     *--------------------------------------------------------------------------

*-- Linhas 454 a 463:
454:     * lista" nos forms CRUD - devolve o dialogo ao estado inicial).
455:     *--------------------------------------------------------------------------
456:     PROTECTED PROCEDURE ConfigurarPaginaLista()
457:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
458:             THIS.lbl_4c_Status.Caption = ""
459:         ENDIF
460:         IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
461:             THIS.btn_4c_Processar.Enabled = .T.
462:         ENDIF
463:         IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)

*-- Linhas 476 a 485:
476:     * ConfigurarBotoes + ConfigurarLabels.
477:     *--------------------------------------------------------------------------
478:     PROTECTED PROCEDURE ConfigurarPaginaDados()
479:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
480:             THIS.lbl_4c_Status.Caption = ""
481:         ENDIF
482:         IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
483:             THIS.btn_4c_Processar.Enabled = .T.
484:         ENDIF
485:         IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)

*-- Linhas 593 a 602:
593:             THIS.this_oBusinessObject.this_lParametrizado = .F.
594:             THIS.this_oBusinessObject.this_lProcessando   = .F.
595:         ENDIF
596:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
597:             THIS.lbl_4c_Status.Caption = "Processamento cancelado."
598:         ENDIF
599:         THIS.AjustarBotoesPorModo()
600:     ENDPROC
601: 
602:     *--------------------------------------------------------------------------

*-- Linhas 622 a 631:
622:         LOCAL loc_oBO
623:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
624:             loc_oBO = THIS.this_oBusinessObject
625:             IF PEMSTATUS(THIS, "lbl_4c_Status", 5) AND !EMPTY(ALLTRIM(loc_oBO.this_cUltStatus))
626:                 THIS.lbl_4c_Status.Caption = loc_oBO.this_cUltStatus
627:             ENDIF
628:         ENDIF
629:         RETURN .T.
630:     ENDPROC
631: 

*-- Linhas 651 a 660:
651:     * LimparCampos - Reseta o status do dialogo para o estado inicial
652:     *--------------------------------------------------------------------------
653:     PROTECTED PROCEDURE LimparCampos()
654:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
655:             THIS.lbl_4c_Status.Caption = ""
656:         ENDIF
657:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
658:             THIS.this_oBusinessObject.this_cUltStatus = ""
659:         ENDIF
660:     ENDPROC

