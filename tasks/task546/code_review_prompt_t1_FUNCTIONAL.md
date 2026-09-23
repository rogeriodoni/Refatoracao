# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarFtpSenha' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarFtpSenha(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSenha2' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSenha2(par_nKeyCode, par_nShiftAltCtrl)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormTpt.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1680 linhas total):

*-- Linhas 24 a 146:
24:     *===========================================================================
25:     * Init - Inicializa o formulario
26:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
27:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
28:     *===========================================================================
29:     PROCEDURE Init()
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *===========================================================================
34:     * InicializarForm - Configura estrutura completa
35:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
36:     *===========================================================================
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.this_oBusinessObject = CREATEOBJECT("TptBO")
43: 
44:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
45:                 MostrarErro("Erro ao criar TptBO" + CHR(13) + ;
46:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
47:                     "FormTpt.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Visible = .T.
53:                 THIS.pgf_4c_Paginas.ActivePage = 1
54:                 THIS.this_cModoAtual = "LISTA"
55: 
56:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
57:                     THIS.CarregarLista()
58:                 ENDIF
59: 
60:                 loc_lSucesso = .T.
61:             ENDIF
62: 
63:         CATCH TO loException
64:             MostrarErro("Erro ao inicializar FormTpt:" + CHR(13) + ;
65:                 loException.Message + CHR(13) + ;
66:                 "Linha: " + TRANSFORM(loException.LineNo), ;
67:                 "FormTpt.InicializarForm")
68:         ENDTRY
69: 
70:         RETURN loc_lSucesso
71:     ENDPROC
72: 
73:     *===========================================================================
74:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
75:     * Top=-29 para esconder abas; controles compensam +29 no Top
76:     *===========================================================================
77:     PROTECTED PROCEDURE ConfigurarPageFrame()
78:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
79: 
80:         WITH THIS.pgf_4c_Paginas
81:             .PageCount = 2
82:             .Top       = -29
83:             .Left      = 0
84:             .Width     = THIS.Width
85:             .Height    = THIS.Height + 29
86:             .Tabs      = .F.
87:             .Visible   = .T.
88: 
89:             .Page1.Caption   = "Lista"
90:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
91:             .Page1.BackColor = RGB(255, 255, 255)
92: 
93:             .Page2.Caption   = "Dados"
94:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page2.BackColor = RGB(255, 255, 255)
96:         ENDWITH
97: 
98:         THIS.ConfigurarPaginaLista()
99:         THIS.ConfigurarPaginaDados()
100:     ENDPROC
101: 
102:     *===========================================================================
103:     * ConfigurarPaginaLista - Configura Page1 com Grid e botoes CRUD completos
104:     * Colunas do grid: codigos, descrs, extensao (cursor_4c_Dados do TptBO.Buscar)
105:     *===========================================================================
106:     PROTECTED PROCEDURE ConfigurarPaginaLista()
107:         LOCAL loc_oPagina
108:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
109: 
110:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111: 
112:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
113:         *-- Original: Top=1. Com compensacao +29: Top=31
114:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
115:         WITH loc_oPagina.cnt_4c_Cabecalho
116:             .Top         = 31
117:             .Left        = 0
118:             .Width       = THIS.Width
119:             .Height      = 80
120:             .BackColor   = RGB(100, 100, 100)
121:             .BorderWidth = 0
122:             .Visible     = .T.
123:         ENDWITH
124: 
125:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
126:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
127:             .Caption   = THIS.Caption
128:             .Top       = 15
129:             .Left      = 10
130:             .Width     = 769
131:             .Height    = 40
132:             .FontName  = "Tahoma"
133:             .FontSize  = 16
134:             .FontBold  = .T.
135:             .ForeColor = RGB(0, 0, 0)
136:             .BackStyle = 0
137:             .AutoSize  = .F.
138:             .Visible   = .T.
139:         ENDWITH
140: 
141:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
143:             .Caption   = THIS.Caption
144:             .Top       = 18
145:             .Left      = 10
146:             .Width     = 769

*-- Linhas 190 a 409:
190:             .AutoSize        = .F.
191:             .Visible         = .T.
192:         ENDWITH
193:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
194: 
195:         *-- Botao Visualizar (Left=80) - legado: Consultar
196:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
197:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
198:             .Caption         = "Visualizar"
199:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
200:             .PicturePosition = 13
201:             .Top             = 5
202:             .Left            = 80
203:             .Width           = 75
204:             .Height          = 75
205:             .FontName        = "Tahoma"
206:             .FontBold        = .T.
207:             .FontItalic      = .T.
208:             .FontSize        = 8
209:             .ForeColor       = RGB(90, 90, 90)
210:             .BackColor       = RGB(255, 255, 255)
211:             .Themes          = .F.
212:             .SpecialEffect   = 0
213:             .MousePointer    = 15
214:             .WordWrap        = .T.
215:             .AutoSize        = .F.
216:             .Visible         = .T.
217:         ENDWITH
218:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
219: 
220:         *-- Botao Alterar (Left=155)
221:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:             .PicturePosition = 13
226:             .Top             = 5
227:             .Left            = 155
228:             .Width           = 75
229:             .Height          = 75
230:             .FontName        = "Tahoma"
231:             .FontBold        = .T.
232:             .FontItalic      = .T.
233:             .FontSize        = 8
234:             .ForeColor       = RGB(90, 90, 90)
235:             .BackColor       = RGB(255, 255, 255)
236:             .Themes          = .F.
237:             .SpecialEffect   = 0
238:             .MousePointer    = 15
239:             .WordWrap        = .T.
240:             .AutoSize        = .F.
241:             .Visible         = .T.
242:         ENDWITH
243:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
244: 
245:         *-- Botao Excluir (Left=230)
246:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
247:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
248:             .Caption         = "Excluir"
249:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
250:             .PicturePosition = 13
251:             .Top             = 5
252:             .Left            = 230
253:             .Width           = 75
254:             .Height          = 75
255:             .FontName        = "Tahoma"
256:             .FontBold        = .T.
257:             .FontItalic      = .T.
258:             .FontSize        = 8
259:             .ForeColor       = RGB(90, 90, 90)
260:             .BackColor       = RGB(255, 255, 255)
261:             .Themes          = .F.
262:             .SpecialEffect   = 0
263:             .MousePointer    = 15
264:             .WordWrap        = .T.
265:             .AutoSize        = .F.
266:             .Visible         = .T.
267:         ENDWITH
268:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
269: 
270:         *-- Botao Buscar (Left=305) - legado: procurar
271:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
272:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
273:             .Caption         = "Buscar"
274:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
275:             .PicturePosition = 13
276:             .Top             = 5
277:             .Left            = 305
278:             .Width           = 75
279:             .Height          = 75
280:             .FontName        = "Tahoma"
281:             .FontBold        = .T.
282:             .FontItalic      = .T.
283:             .FontSize        = 8
284:             .ForeColor       = RGB(90, 90, 90)
285:             .BackColor       = RGB(255, 255, 255)
286:             .Themes          = .F.
287:             .SpecialEffect   = 0
288:             .MousePointer    = 15
289:             .WordWrap        = .T.
290:             .AutoSize        = .F.
291:             .Visible         = .T.
292:         ENDWITH
293:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
294: 
295:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
296:         *-- Legado: Grupo_Saida.Left=719, Top=-1. Canonico: Left=917, Top=29, Width=90
297:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
298:         WITH loc_oPagina.cnt_4c_Saida
299:             .Top         = 29
300:             .Left        = 917
301:             .Width       = 90
302:             .Height      = 85
303:             .BackStyle   = 0
304:             .BorderWidth = 0
305:             .Visible     = .T.
306:         ENDWITH
307: 
308:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
309:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .FontName        = "Tahoma"
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .FontSize        = 8
322:             .ForeColor       = RGB(90, 90, 90)
323:             .BackColor       = RGB(255, 255, 255)
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15
327:             .WordWrap        = .T.
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid de listagem de tipos de transporte (Grade no legado)
334:         *-- Original: Grade.Top=133, Left=32, Width=736, Height=433, FontName=Tahoma, FontSize=8, ForeColor=90,90,90
335:         *-- Com compensacao PageFrame +29: Top=162
336:         *-- Colunas do legado (Init/pColuna): Codigos, Descrs, Extensao
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
339:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
340:         WITH loc_oPagina.grd_4c_Lista
341:             .Top                = 162
342:             .Left               = 32
343:             .Width              = 736
344:             .Height             = 433
345:             .FontName           = "Tahoma"
346:             .FontSize           = 8
347:             .ForeColor          = RGB(90, 90, 90)
348:             .BackColor          = RGB(255, 255, 255)
349:             .GridLineColor      = RGB(238, 238, 238)
350:             .HighlightBackColor = RGB(255, 255, 255)
351:             .HighlightForeColor = RGB(15, 41, 104)
352:             .HighlightStyle     = 2
353:             .DeleteMark         = .F.
354:             .RecordMark         = .F.
355:             .RowHeight          = 16
356:             .ScrollBars         = 2
357:             .GridLines          = 3
358:             .Visible            = .T.
359:         ENDWITH
360:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
361: 
362:         THIS.TornarControlesVisiveis(loc_oPagina)
363:     ENDPROC
364: 
365:     *===========================================================================
366:     * ConfigurarPaginaDados - Configura Page2 (estrutura base)
367:     * TextBoxes de dados sao adicionados nas Fases 5-6
368:     *===========================================================================
369:     PROTECTED PROCEDURE ConfigurarPaginaDados()
370:         LOCAL loc_oPagina
371:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
372: 
373:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
374: 
375:         *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
376:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
377:         WITH loc_oPagina.cnt_4c_Cabecalho
378:             .Top           = 29
379:             .Left          = 0
380:             .Width         = THIS.Width
381:             .Height        = 80
382:             .BackColor     = RGB(100, 100, 100)
383:             .BorderWidth   = 0
384:             .SpecialEffect = 0
385:             .Visible       = .T.
386: 
387:             .AddObject("lbl_4c_Sombra", "Label")
388:             WITH .lbl_4c_Sombra
389:                 .Caption   = THIS.Caption
390:                 .Top       = 15
391:                 .Left      = 10
392:                 .Width     = THIS.Width
393:                 .Height    = 40
394:                 .FontName  = "Tahoma"
395:                 .FontSize  = 16
396:                 .FontBold  = .T.
397:                 .ForeColor = RGB(0, 0, 0)
398:                 .BackStyle = 0
399:                 .AutoSize  = .F.
400:                 .Visible   = .T.
401:             ENDWITH
402: 
403:             .AddObject("lbl_4c_Titulo", "Label")
404:             WITH .lbl_4c_Titulo
405:                 .Caption   = THIS.Caption
406:                 .Top       = 18
407:                 .Left      = 10
408:                 .Width     = THIS.Width
409:                 .Height    = 46

*-- Linhas 968 a 1043:
968:             .Value        = ""
969:             .Visible      = .T.
970:         ENDWITH
971:         BINDEVENT(loc_oPagina.txt_4c_Ftpsenha, "KeyPress", THIS, "ValidarFtpSenha")
972: 
973:         *-- Redigita (Get_senha2 / Say14) - confirmacao da senha, NAO gravada (ControlSource vazio no legado)
974:         loc_oPagina.AddObject("lbl_4c_Redigita", "Label")
975:         WITH loc_oPagina.lbl_4c_Redigita
976:             .Caption   = "Redigita :"
977:             .Top       = 491
978:             .Left      = 353
979:             .Width     = 48
980:             .Height    = 15
981:             .FontName  = "Tahoma"
982:             .FontSize  = 8
983:             .ForeColor = RGB(90, 90, 90)
984:             .BackStyle = 0
985:             .Alignment = 0
986:             .AutoSize  = .F.
987:             .Visible   = .T.
988:         ENDWITH
989: 
990:         loc_oPagina.AddObject("txt_4c_Senha2", "TextBox")
991:         WITH loc_oPagina.txt_4c_Senha2
992:             .Top          = 488
993:             .Left         = 408
994:             .Width        = 130
995:             .Height       = 23
996:             .MaxLength    = 20
997:             .PasswordChar = "*"
998:             .FontName     = "Tahoma"
999:             .FontSize     = 8
1000:             .Value        = ""
1001:             .Visible      = .T.
1002:         ENDWITH
1003:         BINDEVENT(loc_oPagina.txt_4c_Senha2, "KeyPress", THIS, "ValidarSenha2")
1004: 
1005:         *-- Pasta para Envio no FTP (Get_dirftpts / Say9) - dirftpts char(60)
1006:         loc_oPagina.AddObject("lbl_4c_DirFtpEnvio", "Label")
1007:         WITH loc_oPagina.lbl_4c_DirFtpEnvio
1008:             .Caption   = "Pasta para Envio :"
1009:             .Top       = 515
1010:             .Left      = 115
1011:             .Width     = 90
1012:             .Height    = 15
1013:             .FontName  = "Tahoma"
1014:             .FontSize  = 8
1015:             .ForeColor = RGB(90, 90, 90)
1016:             .BackStyle = 0
1017:             .Alignment = 0
1018:             .AutoSize  = .F.
1019:             .Visible   = .T.
1020:         ENDWITH
1021: 
1022:         loc_oPagina.AddObject("txt_4c_DirFtpEnvio", "TextBox")
1023:         WITH loc_oPagina.txt_4c_DirFtpEnvio
1024:             .Top       = 513
1025:             .Left      = 208
1026:             .Width     = 330
1027:             .Height    = 23
1028:             .MaxLength = 60
1029:             .FontName  = "Tahoma"
1030:             .FontSize  = 8
1031:             .Value     = ""
1032:             .Visible   = .T.
1033:         ENDWITH
1034: 
1035:         *-- Pasta para Recepcao no FTP (Get_dirftpls / Say11) - dirftpls char(60)
1036:         loc_oPagina.AddObject("lbl_4c_DirFtpRecepcao", "Label")
1037:         WITH loc_oPagina.lbl_4c_DirFtpRecepcao
1038:             .Caption   = "Pasta para Recep" + CHR(231) + CHR(227) + "o :"
1039:             .Top       = 540
1040:             .Left      = 94
1041:             .Width     = 111
1042:             .Height    = 15
1043:             .FontName  = "Tahoma"

*-- Linhas 1128 a 1680:
1128:             .AutoSize        = .F.
1129:             .Visible         = .T.
1130:         ENDWITH
1131:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1132: 
1133:         *-- Botao Cancelar (Left=80)
1134:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
1135:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
1136:             .Caption         = "Encerrar"
1137:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1138:             .PicturePosition = 13
1139:             .Top             = 5
1140:             .Left            = 80
1141:             .Width           = 75
1142:             .Height          = 75
1143:             .FontName        = "Tahoma"
1144:             .FontBold        = .T.
1145:             .FontItalic      = .T.
1146:             .FontSize        = 8
1147:             .ForeColor       = RGB(90, 90, 90)
1148:             .BackColor       = RGB(255, 255, 255)
1149:             .Themes          = .F.
1150:             .SpecialEffect   = 0
1151:             .MousePointer    = 15
1152:             .WordWrap        = .T.
1153:             .AutoSize        = .F.
1154:             .Visible         = .T.
1155:         ENDWITH
1156:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
1157: 
1158:         THIS.TornarControlesVisiveis(loc_oPagina)
1159:     ENDPROC
1160: 
1161:     *===========================================================================
1162:     * CarregarLista - Carrega dados no grid da Page1
1163:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
1164:     * OBRIGATORIO: ControlSource e Headers APOS RecordSource (Problema 2/48)
1165:     * PUBLIC: chamado diretamente pelo TesteAutomatico.prg (regra #3 CLAUDE.md)
1166:     *===========================================================================
1167:     PROCEDURE CarregarLista()
1168:         LOCAL loc_lResultado, loc_oGrid
1169:         loc_lResultado = .F.
1170: 
1171:         TRY
1172:             IF !THIS.this_oBusinessObject.Buscar("")
1173:                 loc_lResultado = .F.
1174:             ELSE
1175:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1176: 
1177:                 loc_oGrid.ColumnCount  = 3
1178:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1179: 
1180:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1181:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1182:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.extensao"
1183: 
1184:                 loc_oGrid.Column1.Width = 100
1185:                 loc_oGrid.Column2.Width = 430
1186:                 loc_oGrid.Column3.Width = 120
1187: 
1188:                 *-- Headers APOS RecordSource (OBRIGATORIO) - captions EXATOS do pColuna legado
1189:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
1190:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1191:                 loc_oGrid.Column3.Header1.Caption = "Extens" + CHR(227) + "o"
1192: 
1193:                 THIS.FormatarGridLista(loc_oGrid)
1194:                 loc_lResultado = .T.
1195:             ENDIF
1196: 
1197:         CATCH TO loException
1198:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
1199:                 "Linha: " + TRANSFORM(loException.LineNo), ;
1200:                 "FormTpt.CarregarLista")
1201:             loc_lResultado = .F.
1202:         ENDTRY
1203: 
1204:         RETURN loc_lResultado
1205:     ENDPROC
1206: 
1207:     *===========================================================================
1208:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1209:     * Ao voltar para Page1, recarrega a lista
1210:     * PUBLIC: chamado diretamente pelo TesteAutomatico.prg (regra #3 CLAUDE.md)
1211:     *===========================================================================
1212:     PROCEDURE AlternarPagina(par_nPagina)
1213:         LOCAL loc_lResultado
1214:         loc_lResultado = .F.
1215: 
1216:         TRY
1217:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1218:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
1219:             ELSE
1220:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1221: 
1222:                 IF par_nPagina = 1
1223:                     THIS.this_cModoAtual = "LISTA"
1224:                     THIS.CarregarLista()
1225:                 ENDIF
1226: 
1227:                 loc_lResultado = .T.
1228:             ENDIF
1229: 
1230:         CATCH TO loException
1231:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
1232:                 "FormTpt.AlternarPagina")
1233:         ENDTRY
1234: 
1235:         RETURN loc_lResultado
1236:     ENDPROC
1237: 
1238:     *===========================================================================
1239:     * BtnIncluirClick - Prepara Page2 para inclusao de novo registro
1240:     * PUBLIC: chamado direto pelo TesteAutomatico.prg (regra #3 CLAUDE.md) e
1241:     * exigido pelo BINDEVENT do botao (Problema 17)
1242:     *===========================================================================
1243:     PROCEDURE BtnIncluirClick()
1244:         THIS.this_oBusinessObject.NovoRegistro()
1245:         THIS.LimparCampos()
1246:         THIS.this_cModoAtual = "INCLUIR"
1247:         THIS.HabilitarCampos(.T.)
1248:         THIS.AjustarBotoesPorModo()
1249:         THIS.AlternarPagina(2)
1250:     ENDPROC
1251: 
1252:     *===========================================================================
1253:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
1254:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17); tambem chamado
1255:     * pelo DblClick da grade
1256:     *===========================================================================
1257:     PROCEDURE BtnVisualizarClick()
1258:         LOCAL loc_cCodigo
1259:         loc_cCodigo = ""
1260: 
1261:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1262:             SELECT cursor_4c_Dados
1263:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1264:         ENDIF
1265: 
1266:         IF EMPTY(loc_cCodigo)
1267:             MsgAviso("Selecione Um Tipo de Transporte Na Grade!!!")
1268:         ELSE
1269:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1270:                 THIS.this_cModoAtual = "VISUALIZAR"
1271:                 THIS.BOParaForm()
1272:                 THIS.HabilitarCampos(.F.)
1273:                 THIS.AjustarBotoesPorModo()
1274:                 THIS.AlternarPagina(2)
1275:             ENDIF
1276:         ENDIF
1277:     ENDPROC
1278: 
1279:     *===========================================================================
1280:     * BtnAlterarClick - Abre Page2 para alterar o registro selecionado na grade
1281:     * PUBLIC: chamado direto pelo TesteAutomatico.prg (regra #3 CLAUDE.md) e
1282:     * exigido pelo BINDEVENT do botao (Problema 17)
1283:     *===========================================================================
1284:     PROCEDURE BtnAlterarClick()
1285:         LOCAL loc_cCodigo
1286:         loc_cCodigo = ""
1287: 
1288:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1289:             SELECT cursor_4c_Dados
1290:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1291:         ENDIF
1292: 
1293:         IF EMPTY(loc_cCodigo)
1294:             MsgAviso("Selecione Um Tipo de Transporte Na Grade!!!")
1295:         ELSE
1296:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1297:                 THIS.this_oBusinessObject.EditarRegistro()
1298:                 THIS.this_cModoAtual = "ALTERAR"
1299:                 THIS.BOParaForm()
1300:                 THIS.HabilitarCampos(.T.)
1301:                 THIS.AjustarBotoesPorModo()
1302:                 THIS.AlternarPagina(2)
1303:             ENDIF
1304:         ENDIF
1305:     ENDPROC
1306: 
1307:     *===========================================================================
1308:     * BtnExcluirClick - Exclui o registro selecionado na grade, com confirmacao
1309:     * this_lErroExibido evita repetir a mensagem: BusinessBase.Excluir() ja
1310:     * chama ExibirFalha() em todo caminho de falha (regra #20 CLAUDE.md)
1311:     * PUBLIC: chamado direto pelo TesteAutomatico.prg (regra #3 CLAUDE.md) e
1312:     * exigido pelo BINDEVENT do botao (Problema 17)
1313:     *===========================================================================
1314:     PROCEDURE BtnExcluirClick()
1315:         LOCAL loc_cCodigo
1316:         loc_cCodigo = ""
1317: 
1318:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1319:             SELECT cursor_4c_Dados
1320:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1321:         ENDIF
1322: 
1323:         IF EMPTY(loc_cCodigo)
1324:             MsgAviso("Selecione Um Tipo de Transporte Na Grade!!!")
1325:         ELSE
1326:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1327:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do Tipo de Transporte [" + loc_cCodigo + "] ?", ;
1328:                         "Confirmar Exclus" + CHR(227) + "o")
1329:                     IF THIS.this_oBusinessObject.Excluir()
1330:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
1331:                         THIS.CarregarLista()
1332:                     ELSE
1333:                         IF !THIS.this_oBusinessObject.this_lErroExibido
1334:                             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
1335:                         ENDIF
1336:                     ENDIF
1337:                 ENDIF
1338:             ENDIF
1339:         ENDIF
1340:     ENDPROC
1341: 
1342:     *===========================================================================
1343:     * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar um Tipo de
1344:     * Transporte pelo codigo e posiciona a grade da Page1 no registro
1345:     * encontrado. PUBLIC: chamado direto pelo TesteAutomatico.prg (regra #3
1346:     * CLAUDE.md) e exigido pelo BINDEVENT do botao (Problema 17)
1347:     *===========================================================================
1348:     PROCEDURE BtnBuscarClick()
1349:         LOCAL loc_oBusca, loc_cCodigo
1350:         loc_cCodigo = ""
1351: 
1352:         TRY
1353:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1354:                 "SigPrTrn", "cursor_4c_BuscaTpt", "codigos", "", ;
1355:                 "Buscar Tipo de Transporte")
1356: 
1357:             IF VARTYPE(loc_oBusca) = "O"
1358:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1359:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1360:                 loc_oBusca.Show()
1361: 
1362:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpt")
1363:                     SELECT cursor_4c_BuscaTpt
1364:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaTpt.codigos)
1365:                 ENDIF
1366: 
1367:                 loc_oBusca.Release()
1368:             ENDIF
1369: 
1370:             IF USED("cursor_4c_BuscaTpt")
1371:                 USE IN cursor_4c_BuscaTpt
1372:             ENDIF
1373: 
1374:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
1375:                 SELECT cursor_4c_Dados
1376:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
1377:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1378:             ENDIF
1379: 
1380:         CATCH TO loException
1381:             MostrarErro("Erro ao buscar tipo de transporte:" + CHR(13) + loException.Message, ;
1382:                 "FormTpt.BtnBuscarClick")
1383:         ENDTRY
1384:     ENDPROC
1385: 
1386:     *===========================================================================
1387:     * BtnEncerrarClick - Fecha o formulario
1388:     * PUBLIC: exigido pelo BINDEVENT do botao (Problema 17)
1389:     *===========================================================================
1390:     PROCEDURE BtnEncerrarClick()
1391:         THIS.Release()
1392:     ENDPROC
1393: 
1394:     *===========================================================================
1395:     * FormParaBO - Transfere os valores dos controles da Page2 para o
1396:     * BusinessObject. txt_4c_Senha2 (redigita) NUNCA e transferido - e apenas
1397:     * confirmacao de digitacao, sem ControlSource no legado (comentario em
1398:     * ConfigurarPaginaDados)
1399:     *===========================================================================
1400:     PROTECTED PROCEDURE FormParaBO()
1401:         LOCAL loc_oPagina, loc_oBO
1402:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1403:         loc_oBO     = THIS.this_oBusinessObject
1404: 
1405:         loc_oBO.this_cCodigo             = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
1406:         loc_oBO.this_cDescricao          = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
1407:         loc_oBO.this_cExtensao           = ALLTRIM(loc_oPagina.txt_4c_Extensao.Value)
1408:         loc_oBO.this_nTransporteOk       = loc_oPagina.txt_4c_TransporteOk.Value
1409:         loc_oBO.this_nProximoTransporte  = loc_oPagina.txt_4c_ProxTransporte.Value
1410:         loc_oBO.this_nProximoRecebe      = loc_oPagina.txt_4c_ProxRecebe.Value
1411:         loc_oBO.this_lNaoChecarSequencia = loc_oPagina.chk_4c_NaoChecarSequencia.Value
1412:         loc_oBO.this_lExecutarMudaConta  = loc_oPagina.chk_4c_ExecutarMudaConta.Value
1413:         loc_oBO.this_cGeracao            = ALLTRIM(loc_oPagina.txt_4c_Geracao.Value)
1414:         loc_oBO.this_cLeitura            = ALLTRIM(loc_oPagina.txt_4c_Leitura.Value)
1415:         loc_oBO.this_cRecepcao           = ALLTRIM(loc_oPagina.txt_4c_Recepcao.Value)
1416:         loc_oBO.this_cArquivar           = ALLTRIM(loc_oPagina.txt_4c_Arquivar.Value)
1417:         loc_oBO.this_cTipoConexao        = ALLTRIM(loc_oPagina.txt_4c_TipoConexao.Value)
1418:         loc_oBO.this_cFtpEndereco        = ALLTRIM(loc_oPagina.txt_4c_FtpEndereco.Value)
1419:         loc_oBO.this_cFtpUsuario         = ALLTRIM(loc_oPagina.txt_4c_FtpUsuario.Value)
1420:         loc_oBO.this_cFtpSenha           = ALLTRIM(loc_oPagina.txt_4c_Ftpsenha.Value)
1421:         loc_oBO.this_cDirFtpEnvio        = ALLTRIM(loc_oPagina.txt_4c_DirFtpEnvio.Value)
1422:         loc_oBO.this_cDirFtpRecepcao     = ALLTRIM(loc_oPagina.txt_4c_DirFtpRecepcao.Value)
1423:         loc_oBO.this_lLimpaDirLocal      = loc_oPagina.chk_4c_LimpaDirLocal.Value
1424:         loc_oBO.this_lLimpaDirFtp        = loc_oPagina.chk_4c_LimpaDirFtp.Value
1425:     ENDPROC
1426: 
1427:     *===========================================================================
1428:     * BOParaForm - Transfere propriedades do BusinessObject para os controles
1429:     * da Page2. txt_4c_Senha2 (redigita) NUNCA e carregado do BO - e apenas
1430:     * confirmacao de digitacao, sem ControlSource no legado (comentario em
1431:     * ConfigurarPaginaDados)
1432:     *===========================================================================
1433:     PROTECTED PROCEDURE BOParaForm()
1434:         LOCAL loc_oPagina, loc_oBO
1435:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1436:         loc_oBO     = THIS.this_oBusinessObject
1437: 
1438:         loc_oPagina.txt_4c_Codigo.Value             = loc_oBO.this_cCodigo
1439:         loc_oPagina.txt_4c_Descricao.Value          = loc_oBO.this_cDescricao
1440:         loc_oPagina.txt_4c_Extensao.Value           = loc_oBO.this_cExtensao
1441:         loc_oPagina.txt_4c_TransporteOk.Value       = loc_oBO.this_nTransporteOk
1442:         loc_oPagina.txt_4c_ProxTransporte.Value     = loc_oBO.this_nProximoTransporte
1443:         loc_oPagina.txt_4c_ProxRecebe.Value         = loc_oBO.this_nProximoRecebe
1444:         loc_oPagina.chk_4c_NaoChecarSequencia.Value = loc_oBO.this_lNaoChecarSequencia
1445:         loc_oPagina.chk_4c_ExecutarMudaConta.Value  = loc_oBO.this_lExecutarMudaConta
1446:         loc_oPagina.txt_4c_Geracao.Value            = loc_oBO.this_cGeracao
1447:         loc_oPagina.txt_4c_Leitura.Value            = loc_oBO.this_cLeitura
1448:         loc_oPagina.txt_4c_Recepcao.Value           = loc_oBO.this_cRecepcao
1449:         loc_oPagina.txt_4c_Arquivar.Value           = loc_oBO.this_cArquivar
1450:         loc_oPagina.txt_4c_TipoConexao.Value        = loc_oBO.this_cTipoConexao
1451:         loc_oPagina.txt_4c_FtpEndereco.Value        = loc_oBO.this_cFtpEndereco
1452:         loc_oPagina.txt_4c_FtpUsuario.Value         = loc_oBO.this_cFtpUsuario
1453:         loc_oPagina.txt_4c_Ftpsenha.Value           = loc_oBO.this_cFtpSenha
1454:         loc_oPagina.txt_4c_Senha2.Value             = ""
1455:         loc_oPagina.txt_4c_DirFtpEnvio.Value        = loc_oBO.this_cDirFtpEnvio
1456:         loc_oPagina.txt_4c_DirFtpRecepcao.Value     = loc_oBO.this_cDirFtpRecepcao
1457:         loc_oPagina.chk_4c_LimpaDirLocal.Value      = loc_oBO.this_lLimpaDirLocal
1458:         loc_oPagina.chk_4c_LimpaDirFtp.Value        = loc_oBO.this_lLimpaDirFtp
1459:     ENDPROC
1460: 
1461:     *===========================================================================
1462:     * HabilitarCampos - Habilita/desabilita os campos editaveis da Page2
1463:     * Codigo (PK) so fica editavel em modo INCLUIR. txt_4c_ProxTransporte e
1464:     * txt_4c_ProxRecebe sao sempre somente-leitura (sequencia calculada,
1465:     * sem Valid no legado - apenas tracking peAntvalue no When)
1466:     *===========================================================================
1467:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1468:         LOCAL loc_oPagina, loc_lCodEditavel
1469:         loc_oPagina     = THIS.pgf_4c_Paginas.Page2
1470:         loc_lCodEditavel = (THIS.this_cModoAtual = "INCLUIR")
1471: 
1472:         loc_oPagina.txt_4c_Codigo.Enabled              = par_lHabilitar AND loc_lCodEditavel
1473:         loc_oPagina.txt_4c_Descricao.Enabled           = par_lHabilitar
1474:         loc_oPagina.txt_4c_Extensao.Enabled            = par_lHabilitar
1475:         loc_oPagina.txt_4c_TransporteOk.Enabled        = par_lHabilitar
1476:         loc_oPagina.txt_4c_ProxTransporte.Enabled      = .F.
1477:         loc_oPagina.txt_4c_ProxRecebe.Enabled          = .F.
1478:         loc_oPagina.chk_4c_NaoChecarSequencia.Enabled  = par_lHabilitar
1479:         loc_oPagina.chk_4c_ExecutarMudaConta.Enabled   = par_lHabilitar
1480:         loc_oPagina.txt_4c_Geracao.Enabled             = par_lHabilitar
1481:         loc_oPagina.txt_4c_Leitura.Enabled             = par_lHabilitar
1482:         loc_oPagina.txt_4c_Recepcao.Enabled            = par_lHabilitar
1483:         loc_oPagina.txt_4c_Arquivar.Enabled            = par_lHabilitar
1484:         loc_oPagina.txt_4c_TipoConexao.Enabled         = par_lHabilitar
1485:         loc_oPagina.txt_4c_FtpEndereco.Enabled         = par_lHabilitar
1486:         loc_oPagina.txt_4c_FtpUsuario.Enabled          = par_lHabilitar
1487:         loc_oPagina.txt_4c_Ftpsenha.Enabled            = par_lHabilitar
1488:         loc_oPagina.txt_4c_Senha2.Enabled              = par_lHabilitar
1489:         loc_oPagina.txt_4c_DirFtpEnvio.Enabled         = par_lHabilitar
1490:         loc_oPagina.txt_4c_DirFtpRecepcao.Enabled      = par_lHabilitar
1491:         loc_oPagina.chk_4c_LimpaDirLocal.Enabled       = par_lHabilitar
1492:         loc_oPagina.chk_4c_LimpaDirFtp.Enabled         = par_lHabilitar
1493:     ENDPROC
1494: 
1495:     *===========================================================================
1496:     * LimparCampos - Limpa todos os campos da Page2 para um novo registro
1497:     *===========================================================================
1498:     PROTECTED PROCEDURE LimparCampos()
1499:         LOCAL loc_oPagina
1500:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1501: 
1502:         loc_oPagina.txt_4c_Codigo.Value             = ""
1503:         loc_oPagina.txt_4c_Descricao.Value          = ""
1504:         loc_oPagina.txt_4c_Extensao.Value           = ""
1505:         loc_oPagina.txt_4c_TransporteOk.Value       = 0
1506:         loc_oPagina.txt_4c_ProxTransporte.Value     = 0
1507:         loc_oPagina.txt_4c_ProxRecebe.Value         = 0
1508:         loc_oPagina.chk_4c_NaoChecarSequencia.Value = 0
1509:         loc_oPagina.chk_4c_ExecutarMudaConta.Value  = 0
1510:         loc_oPagina.txt_4c_Geracao.Value            = ""
1511:         loc_oPagina.txt_4c_Leitura.Value            = ""
1512:         loc_oPagina.txt_4c_Recepcao.Value           = ""
1513:         loc_oPagina.txt_4c_Arquivar.Value           = ""
1514:         loc_oPagina.txt_4c_TipoConexao.Value        = ""
1515:         loc_oPagina.txt_4c_FtpEndereco.Value        = ""
1516:         loc_oPagina.txt_4c_FtpUsuario.Value         = ""
1517:         loc_oPagina.txt_4c_Ftpsenha.Value           = ""
1518:         loc_oPagina.txt_4c_Senha2.Value             = ""
1519:         loc_oPagina.txt_4c_DirFtpEnvio.Value        = ""
1520:         loc_oPagina.txt_4c_DirFtpRecepcao.Value     = ""
1521:         loc_oPagina.chk_4c_LimpaDirLocal.Value      = 0
1522:         loc_oPagina.chk_4c_LimpaDirFtp.Value        = 0
1523:     ENDPROC
1524: 
1525:     *===========================================================================
1526:     * BtnSalvarClick - Confirma a gravacao de Page2 (Incluir/Alterar)
1527:     * PUBLIC: BINDEVENT requer metodo publico. Salvar() SEM parametro - o BO
1528:     * decide INSERT/UPDATE por this_lNovoRegistro (regra #4 do guia).
1529:     * Falha de gravacao ja e reportada pelo BusinessBase (regra #20 CLAUDE.md).
1530:     *===========================================================================
1531:     PROCEDURE BtnSalvarClick()
1532:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1533:             RETURN
1534:         ENDIF
1535: 
1536:         THIS.FormParaBO()
1537: 
1538:         IF THIS.this_oBusinessObject.Salvar()
1539:             MsgInfo("Registro salvo com sucesso!", "Confirmar")
1540:             THIS.AlternarPagina(1)
1541:         ELSE
1542:             IF !THIS.this_oBusinessObject.this_lErroExibido
1543:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
1544:             ENDIF
1545:         ENDIF
1546:     ENDPROC
1547: 
1548:     *===========================================================================
1549:     * BtnCancelarClick - Cancela edicao/visualizacao e volta para a lista
1550:     * PUBLIC: BINDEVENT requer metodo publico.
1551:     *===========================================================================
1552:     PROCEDURE BtnCancelarClick()
1553:         THIS.AlternarPagina(1)
1554:         THIS.this_cModoAtual = "LISTA"
1555:         THIS.CarregarLista()
1556:     ENDPROC
1557: 
1558:     *===========================================================================
1559:     * AjustarBotoesPorModo - Ajusta o botao Confirmar conforme o modo atual
1560:     * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
1561:     * PUBLIC: chamado direto pelo TesteAutomatico.prg (regra #3 CLAUDE.md)
1562:     *===========================================================================
1563:     PROCEDURE AjustarBotoesPorModo()
1564:         LOCAL loc_oBotoesAcao, loc_lEditando
1565:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1566:         loc_lEditando   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1567: 
1568:         loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
1569:         loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1570:     ENDPROC
1571: 
1572:     *===========================================================================
1573:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
1574:     *===========================================================================
1575:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1576:         TRY
1577:             WITH par_oGrid
1578:                 .FontName = "Tahoma"
1579:                 .FontSize = 8
1580:             ENDWITH
1581:         CATCH TO loException
1582:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
1583:                 "FormTpt.FormatarGridLista")
1584:         ENDTRY
1585:     ENDPROC
1586: 
1587:     *===========================================================================
1588:     * ValidarFtpSenha - LostFocus para txt_4c_Ftpsenha. Reproduz o Valid legado:
1589:     * codifica o valor digitado usando fDecriptografar() (funcao do Framework
1590:     * legado Fortyus que, apesar do nome, CODIFICA o valor para gravacao - mesmo
1591:     * padrao ja adotado em FormTme.prg).
1592:     * PUBLIC: obrigatorio para funcionar com BINDEVENT (regra #3 CLAUDE.md)
1593:     *===========================================================================
1594:     PROCEDURE ValidarFtpSenha()
1595:         LOCAL loc_oPg2, loc_cValor
1596: 
1597:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1598:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
1599: 
1600:         IF !EMPTY(loc_cValor)
1601:             loc_oPg2.txt_4c_Ftpsenha.Value = fDecriptografar(loc_cValor)
1602:         ENDIF
1603:     ENDPROC
1604: 
1605:     *===========================================================================
1606:     * ValidarSenha2 - LostFocus para txt_4c_Senha2 (campo "Redigita"). Reproduz
1607:     * o Valid legado: compara a senha ja codificada de txt_4c_Ftpsenha com a
1608:     * codificacao do valor redigitado. Se nao conferir, pergunta se o usuario
1609:     * deseja continuar com a senha em branco:
1610:     *   - Confirmou (Sim): limpa AMBOS os campos (senha + redigita)
1611:     *   - Recusou (Nao): limpa apenas o campo de redigita
1612:     * PUBLIC: obrigatorio para funcionar com BINDEVENT (regra #3 CLAUDE.md)
1613:     *===========================================================================
1614:     PROCEDURE ValidarSenha2()
1615:         LOCAL loc_oPg2, loc_cSenhaCodificada, loc_cRedigitaCodificada
1616: 
1617:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1618: 
1619:         IF !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value))
1620:             loc_cSenhaCodificada    = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
1621:             loc_cRedigitaCodificada = fDecriptografar(ALLTRIM(loc_oPg2.txt_4c_Senha2.Value))
1622: 
1623:             IF loc_cSenhaCodificada != loc_cRedigitaCodificada
1624:                 IF MsgConfirma("A Senha N" + CHR(227) + "o Confere!!! Deseja Continuar Com a Senha em Branco ?", ;
1625:                         "Erro na Confirma" + CHR(231) + CHR(227) + "o da Senha...")
1626:                     *-- Confirmou: limpa senha + redigita
1627:                     loc_oPg2.txt_4c_Ftpsenha.Value = ""
1628:                     loc_oPg2.txt_4c_Senha2.Value    = ""
1629:                 ELSE
1630:                     *-- Recusou: limpa apenas a redigita
1631:                     loc_oPg2.txt_4c_Senha2.Value = ""
1632:                 ENDIF
1633:             ENDIF
1634:         ENDIF
1635:     ENDPROC
1636: 
1637:     *===========================================================================
1638:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1639:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
1640:     *===========================================================================
1641:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1642:         LOCAL loc_nI, loc_oObjeto, loc_nP
1643: 
1644:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1645:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1646: 
1647:             IF VARTYPE(loc_oObjeto) = "O"
1648:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1649:                     loc_oObjeto.Visible = .T.
1650:                 ENDIF
1651: 
1652:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1653:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1654:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1655:                     ENDFOR
1656:                 ENDIF
1657: 
1658:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1659:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1660:                 ENDIF
1661:             ENDIF
1662:         ENDFOR
1663:     ENDPROC
1664: 
1665:     *===========================================================================
1666:     * Destroy - Libera recursos ao fechar o formulario
1667:     *===========================================================================
1668:     PROCEDURE Destroy()
1669:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1670:             THIS.this_oBusinessObject = .NULL.
1671:         ENDIF
1672: 
1673:         IF USED("cursor_4c_Dados")
1674:             USE IN cursor_4c_Dados
1675:         ENDIF
1676: 
1677:         DODEFAULT()
1678:     ENDPROC
1679: 
1680: ENDDEFINE


### BO (C:\4c\projeto\app\classes\TptBO.prg):
*====================================================================
* TptBO.prg
*
* Business Object para Cadastro de Tipos de Transporte
* Tabela: SigPrTrn
* Herda de: BusinessBase
*
* NOTA: O legado (SIGCDTPT) abre a tabela SigPrTrn via
* AddCursor('SigPrTrn', 'Codigos', 'crSigPrTrn', ...) e TODOS os campos
* da Pagina.Dados usam ControlSource = "crSigPrTrn.<campo>". A tabela
* SigPrTro (cidchaves) e um cursor auxiliar usado apenas internamente
* pelo botao "Copiar" (SIGCDTPT.Pagina.Lista.cntCopiar.CmdOk) para
* duplicar registros de subtipos (SigPrTro.tptrans) quando o codigo do
* transporte e alterado - nao e a tabela principal do formulario.
*====================================================================

DEFINE CLASS TptBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTrn)
    this_cCodigo               = ""    && codigos    char(6)  - PK
    this_cDescricao            = ""    && descrs     char(20)
    this_cExtensao             = ""    && extensao   char(3)  - extensao do arquivo de transporte
    this_cGeracao              = ""    && drivets    char(60) - diretorio de geracao do transporte
    this_cLeitura               = ""    && drivels    char(60) - diretorio de leitura do zip
    this_cRecepcao             = ""    && drivers    char(60) - diretorio de recepcao do transporte
    this_cArquivar             = ""    && paths      char(60) - diretorio de arquivamento
    this_cTipoConexao          = ""    && tpconexao  char(1)  - D=Dial-Up / B=Banda Larga
    this_cFtpEndereco          = ""    && ftpend     char(50)
    this_cFtpUsuario           = ""    && ftpusuario char(30)
    this_cFtpSenha             = ""    && ftpsenha   char(20)
    this_cDirFtpEnvio          = ""    && dirftpts   char(60) - pasta de envio no FTP
    this_cDirFtpRecepcao       = ""    && dirftpls   char(60) - pasta de recepcao no FTP
    this_lLimpaDirLocal        = .F.   && locdel     bit      - limpa diretorio local apos envio
    this_lLimpaDirFtp          = .F.   && ftpdel     bit      - limpa diretorio do FTP apos recepcao
    this_nTransporteOk         = 0     && clrarqs    numeric(3,0) - qtde de arquivos p/ considerar transporte ok
    this_lNaoChecarSequencia   = .F.   && nchkseqs   bit      - nao checar sequencia de recepcao
    this_lExecutarMudaConta    = .F.   && exmudcts   numeric(1,0) - executar muda conta na recepcao dos dados

    *-- Propriedades transitorias (nao persistidas em SigPrTrn)
    this_cSenhaRedigita        = ""    && Get_senha2 (ControlSource vazio) - confirmacao da senha do FTP
    this_nProximoTransporte    = 0     && Get_Transp  - proximo numero de transporte (SigSySeq)
    this_nProximoRecebe        = 0     && get_Recebe  - proximo numero de recebimento (SigSySeq)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTrn"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TptBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *
    * NOTA: as colunas 'extens' (char(3)) e 'tipos' (numeric(1,0)) sao
    * NOT NULL na tabela SigPrTrn mas nao existem em NENHUM ponto do
    * codigo fonte legado (nem ControlSource, nem .pColuna, nem Valid) -
    * sao colunas invisiveis (regra #22 do CLAUDE.md). 'extens' e gemea
    * de 'extensao' (que o legado usa de fato via getExtens); 'tipos' nao
    * tem gemea. Nenhuma das duas vira propriedade do BO: sao gravadas
    * com default fixo no INSERT e nunca tocadas no UPDATE.
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo             = TratarNulo(codigos,    "C")
                THIS.this_cDescricao          = TratarNulo(descrs,     "C")
                THIS.this_cExtensao           = TratarNulo(extensao,   "C")
                THIS.this_cGeracao            = TratarNulo(drivets,    "C")
                THIS.this_cLeitura            = TratarNulo(drivels,    "C")
                THIS.this_cRecepcao           = TratarNulo(drivers,    "C")
                THIS.this_cArquivar           = TratarNulo(paths,      "C")
                THIS.this_cTipoConexao        = TratarNulo(tpconexao,  "C")
                THIS.this_cFtpEndereco        = TratarNulo(ftpend,     "C")
                THIS.this_cFtpUsuario         = TratarNulo(ftpusuario, "C")
                THIS.this_cFtpSenha           = TratarNulo(ftpsenha,   "C")
                THIS.this_cDirFtpEnvio        = TratarNulo(dirftpts,   "C")
                THIS.this_cDirFtpRecepcao     = TratarNulo(dirftpls,   "C")
                THIS.this_lLimpaDirLocal      = ConverterParaLogico(locdel)
                THIS.this_lLimpaDirFtp        = ConverterParaLogico(ftpdel)
                THIS.this_nTransporteOk       = TratarNulo(clrarqs,    "N")
                THIS.this_lNaoChecarSequencia = ConverterParaLogico(nchkseqs)
                THIS.this_lExecutarMudaConta  = ConverterParaLogico(exmudcts)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TptBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Transcrito de SIGCDTPT.Pagina.Dados.Grupo_Salva.Salva.Click:
    * Codigo obrigatorio + Codigo Ja Cadastrado (checado so no INSERT)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se codigos ja existe no banco
    * Equivalente ao ChkRegister('SigPrTrn', 'Codigos', ...) do legado
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigPrTrn" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "TptBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrTrn
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTrn (codigos, descrs, extens, tipos, clrarqs,
                    dirftpls, dirftpts, drivels, drivers, drivets, extensao,
                    ftpdel, ftpend, ftpsenha, ftpusuario, locdel, tpconexao,
                    nchkseqs, paths, exmudcts)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL("")>>,
                    <<FormatarNumeroSQL(0, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    <<EscaparSQL(THIS.this_cLeitura)>>,
                    <<EscaparSQL(THIS.this_cRecepcao)>>,
                    <<EscaparSQL(THIS.this_cGeracao)>>,
                    <<EscaparSQL(THIS.this_cExtensao)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirLocal, 1, 0), 0)>>,
                    <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    <<EscaparSQL(THIS.this_cArquivar)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lExecutarMudaConta, 1, 0), 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TptBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrTrn
    * NOTA: 'extens' e 'tipos' nunca sao tocados no UPDATE (regra #22 -
    * colunas invisiveis, sem property, gravadas so uma vez no INSERT)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTrn
                SET descrs      = <<EscaparSQL(THIS.this_cDescricao)>>,
                    clrarqs     = <<FormatarNumeroSQL(THIS.this_nTransporteOk, 0)>>,
                    dirftpls    = <<EscaparSQL(THIS.this_cDirFtpRecepcao)>>,
                    dirftpts    = <<EscaparSQL(THIS.this_cDirFtpEnvio)>>,
                    drivels     = <<EscaparSQL(THIS.this_cLeitura)>>,
                    drivers     = <<EscaparSQL(THIS.this_cRecepcao)>>,
                    drivets     = <<EscaparSQL(THIS.this_cGeracao)>>,
                    extensao    = <<EscaparSQL(THIS.this_cExtensao)>>,
                    ftpdel      = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirFtp, 1, 0), 0)>>,
                    ftpend      = <<EscaparSQL(THIS.this_cFtpEndereco)>>,
                    ftpsenha    = <<EscaparSQL(THIS.this_cFtpSenha)>>,
                    ftpusuario  = <<EscaparSQL(THIS.this_cFtpUsuario)>>,
                    locdel      = <<FormatarNumeroSQL(IIF(THIS.this_lLimpaDirLocal, 1, 0), 0)>>,
                    tpconexao   = <<EscaparSQL(THIS.this_cTipoConexao)>>,
                    nchkseqs    = <<FormatarNumeroSQL(IIF(THIS.this_lNaoChecarSequencia, 1, 0), 0)>>,
                    paths       = <<EscaparSQL(THIS.this_cArquivar)>>,
                    exmudcts    = <<FormatarNumeroSQL(IIF(THIS.this_lExecutarMudaConta, 1, 0), 0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TptBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrTrn
    * NOTA: o dump legado nao mostra override do case Excluir no
    * Grupo_op.Click (usa o comportamento padrao do frmcadastro, sem
    * checagem de dependencia visivel) - transcrito como DELETE simples
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTrn WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TptBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descrs, extensao (colunas
    * exatas do Grid legado: .pColuna('Codigos'...), ('Descrs'...), ('Extensao'...))
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(6), descrs C(20), extensao C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigos, descrs, extensao FROM SigPrTrn"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar tipos de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TptBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT codigos, descrs, extensao, drivets, drivels, drivers,
                    paths, tpconexao, ftpend, ftpusuario, ftpsenha, dirftpts,
                    dirftpls, locdel, ftpdel, clrarqs, nchkseqs, exmudcts
                FROM SigPrTrn WHERE codigos = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo de Transporte n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TptBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

