# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_crBranco' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIiv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (544 linhas total):

*-- Linhas 68 a 76:
68:         loc_lSucesso   = .F.
69:         loc_lContinuar = .T.
70:         TRY
71:             THIS.Caption = "Impress" + CHR(227) + "o de Invoice (" + ;
72:                            ALLTRIM(THIS.this_pDop) + "/" + ALLTRIM(STR(THIS.this_pNum)) + ")"
73: 
74:             IF TYPE("gc_4c_CaminhoIcones") = "U"
75:                 gc_4c_CaminhoIcones = ""
76:             ENDIF

*-- Linhas 98 a 107:
98:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
99:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
100: 
101:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
102:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
103:                 THIS.Visible  = .T.
104:                 loc_lSucesso  = .T.
105:             ENDIF
106:         CATCH TO loc_oErro
107:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 118 a 156:
118:     PROTECTED PROCEDURE ConfigurarCabecalho()
119:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH THIS.cnt_4c_Cabecalho
121:             .Top         = 0
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackStyle   = 1
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129: 
130:             .AddObject("lbl_4c_Sombra", "Label")
131:             WITH .lbl_4c_Sombra
132:                 .Top       = 22
133:                 .Left      = 22
134:                 .Width     = THIS.Width
135:                 .Height    = 30
136:                 .Caption   = THIS.Caption
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 14
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(0, 0, 0)
141:                 .BackStyle = 0
142:                 .Visible   = .T.
143:             ENDWITH
144: 
145:             .AddObject("lbl_4c_Titulo", "Label")
146:             WITH .lbl_4c_Titulo
147:                 .Top       = 20
148:                 .Left      = 20
149:                 .Width     = THIS.Width
150:                 .Height    = 30
151:                 .Caption   = THIS.Caption
152:                 .FontName  = "Tahoma"
153:                 .FontSize  = 14
154:                 .FontBold  = .T.
155:                 .ForeColor = RGB(255, 255, 255)
156:                 .BackStyle = 0

*-- Linhas 168 a 193:
168:     PROTECTED PROCEDURE ConfigurarBotoes()
169:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
170:         WITH THIS.cmg_4c_Botoes
171:             .Top           = 0
172:             .Left          = 529
173:             .Width         = 273
174:             .Height        = 80
175:             .ButtonCount   = 4
176:             .BackStyle     = 0
177:             .BorderStyle   = 0
178:             .BorderColor   = RGB(136, 189, 188)
179:             .SpecialEffect = 1
180:             .Themes        = .F.
181:             .Visible       = .T.
182: 
183:             WITH .Buttons(1)
184:                 .Top             = 5
185:                 .Left            = 5
186:                 .Width           = 65
187:                 .Height          = 70
188:                 .Caption         = "Visualizar"
189:                 .FontBold        = .T.
190:                 .FontItalic      = .T.
191:                 .BackColor       = RGB(255, 255, 255)
192:                 .ForeColor       = RGB(90, 90, 90)
193:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 200 a 212:
200:             ENDWITH
201: 
202:             WITH .Buttons(2)
203:                 .Top             = 5
204:                 .Left            = 71
205:                 .Width           = 65
206:                 .Height          = 70
207:                 .Caption         = "Imprimir"
208:                 .FontName        = "Tahoma"
209:                 .FontBold        = .T.
210:                 .FontItalic      = .T.
211:                 .FontSize        = 8
212:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 221 a 233:
221:             ENDWITH
222: 
223:             WITH .Buttons(3)
224:                 .Top             = 5
225:                 .Left            = 137
226:                 .Width           = 65
227:                 .Height          = 70
228:                 .Caption         = "Excel"
229:                 .FontName        = "Tahoma"
230:                 .FontBold        = .T.
231:                 .FontItalic      = .T.
232:                 .FontSize        = 8
233:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 242 a 254:
242:             ENDWITH
243: 
244:             WITH .Buttons(4)
245:                 .Top             = 5
246:                 .Left            = 203
247:                 .Width           = 65
248:                 .Height          = 70
249:                 .Caption         = "Encerrar"
250:                 .Cancel          = .T.
251:                 .FontName        = "Tahoma"
252:                 .FontBold        = .T.
253:                 .FontItalic      = .T.
254:                 .FontSize        = 8

*-- Linhas 277 a 322:
277: 
278:         loc_oPgf.PageCount = 1
279: 
280:         loc_oPgf.Top    = 85
281:         loc_oPgf.Left   = -1
282:         loc_oPgf.Width  = THIS.Width + 2
283:         loc_oPgf.Height = THIS.Height - 85
284:         loc_oPgf.Tabs   = .F.
285: 
286:         loc_oPgf.Page1.Caption   = "Filtros"
287:         loc_oPgf.Page1.FontName  = "Tahoma"
288:         loc_oPgf.Page1.FontSize  = 8
289:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
290:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
291:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
292: 
293:         loc_oPgf.Visible    = .T.
294:         loc_oPgf.ActivePage = 1
295:     ENDPROC
296: 
297:     *--------------------------------------------------------------------------
298:     * ConfigurarPaginaLista - CheckBox "Imprimir Listagem" na Page1
299:     *   Original: chkListagem Top=94, Left=72 (form-relativo)
300:     *   Page1.Top = 94 - 85 = 9 (relativo ao PageFrame)
301:     *--------------------------------------------------------------------------
302:     PROTECTED PROCEDURE ConfigurarPaginaLista()
303:         LOCAL loc_oPg
304:         loc_oPg = THIS.pgf_4c_Paginas.Page1
305: 
306:         loc_oPg.AddObject("chk_4c_Listagem", "CheckBox")
307:         WITH loc_oPg.chk_4c_Listagem
308:             .Top       = 9
309:             .Left      = 72
310:             .Width     = 101
311:             .Height    = 15
312:             .FontName  = "Tahoma"
313:             .FontSize  = 8
314:             .AutoSize  = .T.
315:             .Alignment = 0
316:             .BackStyle = 0
317:             .Caption   = "Imprimir Listagem"
318:             .Value     = 0
319:             .ForeColor = RGB(90, 90, 90)
320:             .Visible   = .T.
321:         ENDWITH
322:     ENDPROC

