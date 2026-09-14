# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [LAYOUT-POSITION] Controle 'Combo10' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=178 vs migrado 'cbo_4c_Combo10' Top=315 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Combo10' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=380 vs migrado 'cbo_4c_Combo10' Left=136 (diff=244px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmbIpiI' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=380 vs migrado 'cbo_4c_CmbIpiI' Left=136 (diff=244px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Combo2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=27 vs migrado 'cbo_4c_Combo2' Top=315 (diff=288px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Combo2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=642 vs migrado 'cbo_4c_Combo2' Left=380 (diff=262px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=127 vs migrado 'obj_4c_Fwoption1' Top=389 (diff=262px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=638 vs migrado 'obj_4c_Fwoption1' Left=686 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=233 vs migrado 'obj_4c_Fwoption2' Top=420 (diff=187px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=231 vs migrado 'obj_4c_Fwoption2' Left=686 (diff=455px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4456 linhas total):

*-- Linhas 63 a 72:
63:                 THIS.ConfigurarPageFrame()
64: 
65:                 *-- Propagar titulo para labels do cabecalho
66:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
67:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
68: 
69:                 *-- Carregar lista inicial (pula se validando UI)
70:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
71:                     THIS.CarregarLista()
72:                 ENDIF

*-- Linhas 91 a 109:
91:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
92:         WITH THIS.pgf_4c_Paginas
93:             .PageCount  = 2
94:             .Top        = -29
95:             .Left       = 0
96:             .Width      = 1000
97:             .Height     = 629
98:             .Tabs       = .F.
99:             .Visible    = .T.
100:         ENDWITH
101: 
102:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
103:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
104:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
105:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
106: 
107:         *-- Configurar Page1 e Page2
108:         THIS.ConfigurarPaginaLista()
109:         THIS.ConfigurarPaginaDados()

*-- Linhas 121 a 161:
121:         *-- Container cabecalho (titulo do formulario - lado esquerdo)
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 31
125:             .Left        = 0
126:             .Width       = 800
127:             .Height      = 85
128:             .BackStyle   = 1
129:             .BackColor   = RGB(53, 53, 53)
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         *-- Label sombra (efeito de sombra no titulo)
135:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
136:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
137:             .Caption   = "Cadastro de CFOP"
138:             .Top       = 15
139:             .Left      = 10
140:             .Width     = 769
141:             .Height    = 40
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .ForeColor = RGB(0, 0, 0)
146:             .BackStyle = 0
147:             .AutoSize  = .F.
148:             .Visible   = .T.
149:         ENDWITH
150: 
151:         *-- Label titulo (branco - sobre a sombra)
152:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
153:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
154:             .Caption   = "Cadastro de CFOP"
155:             .Top       = 18
156:             .Left      = 10
157:             .Width     = 769
158:             .Height    = 46
159:             .FontName  = "Tahoma"
160:             .FontSize  = 16
161:             .FontBold  = .T.

*-- Linhas 168 a 193:
168:         *-- Container botoes CRUD (lado direito - a partir de Left=542)
169:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
170:         WITH loc_oPagina.cnt_4c_Botoes
171:             .Top         = 29
172:             .Left        = 542
173:             .Width       = 390
174:             .Height      = 85
175:             .BackStyle   = 1
176:             .BackColor   = RGB(53, 53, 53)
177:             .BorderWidth = 0
178:             .Visible     = .T.
179:         ENDWITH
180: 
181:         *-- Botao Incluir
182:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
183:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
184:             .Caption         = "Incluir"
185:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
186:             .PicturePosition = 13
187:             .Top             = 5
188:             .Left            = 5
189:             .Width           = 75
190:             .Height          = 75
191:             .FontName        = "Tahoma"
192:             .FontSize        = 8
193:             .FontBold        = .T.

*-- Linhas 203 a 217:
203:         ENDWITH
204: 
205:         *-- Botao Visualizar
206:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
207:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
208:             .Caption         = "Visualizar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 80
213:             .Width           = 75
214:             .Height          = 75
215:             .FontName        = "Tahoma"
216:             .FontSize        = 8
217:             .FontBold        = .T.

*-- Linhas 227 a 241:
227:         ENDWITH
228: 
229:         *-- Botao Alterar
230:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
231:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
232:             .Caption         = "Alterar"
233:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
234:             .PicturePosition = 13
235:             .Top             = 5
236:             .Left            = 155
237:             .Width           = 75
238:             .Height          = 75
239:             .FontName        = "Tahoma"
240:             .FontSize        = 8
241:             .FontBold        = .T.

*-- Linhas 251 a 265:
251:         ENDWITH
252: 
253:         *-- Botao Excluir
254:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
255:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
256:             .Caption         = "Excluir"
257:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
258:             .PicturePosition = 13
259:             .Top             = 5
260:             .Left            = 230
261:             .Width           = 75
262:             .Height          = 75
263:             .FontName        = "Tahoma"
264:             .FontSize        = 8
265:             .FontBold        = .T.

*-- Linhas 275 a 289:
275:         ENDWITH
276: 
277:         *-- Botao Buscar
278:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
279:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
280:             .Caption         = "Buscar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 5
284:             .Left            = 305
285:             .Width           = 75
286:             .Height          = 75
287:             .FontName        = "Tahoma"
288:             .FontSize        = 8
289:             .FontBold        = .T.

*-- Linhas 301 a 326:
301:         *-- Container botao Encerrar (extrema direita)
302:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
303:         WITH loc_oPagina.cnt_4c_Saida
304:             .Top         = 29
305:             .Left        = 935
306:             .Width       = 60
307:             .Height      = 85
308:             .BackStyle   = 1
309:             .BackColor   = RGB(53, 53, 53)
310:             .BorderWidth = 0
311:             .Visible     = .T.
312:         ENDWITH
313: 
314:         *-- Botao Encerrar
315:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
316:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
317:             .Caption         = "Encerrar"
318:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
319:             .PicturePosition = 13
320:             .Top             = 5
321:             .Left            = 5
322:             .Width           = 50
323:             .Height          = 75
324:             .FontName        = "Tahoma"
325:             .FontSize        = 8
326:             .FontBold        = .T.

*-- Linhas 337 a 365:
337: 
338:         *-- Botoes XML (abaixo da barra de cabecalho, compensados +29)
339:         *-- Original: btnExpXML top=85, left=3 -> compensado: 85+29=114
340:         loc_oPagina.AddObject("cmd_4c_ExpXML", "CommandButton")
341:         WITH loc_oPagina.cmd_4c_ExpXML
342:             .Caption       = "  Exporta XML"
343:             .Top           = 114
344:             .Left          = 3
345:             .Width         = 120
346:             .Height        = 40
347:             .FontName      = "Tahoma"
348:             .FontSize      = 8
349:             .ForeColor     = RGB(0, 0, 0)
350:             .BackColor     = RGB(240, 240, 240)
351:             .Themes        = .F.
352:             .SpecialEffect = 0
353:             .Visible       = .T.
354:         ENDWITH
355: 
356:         loc_oPagina.AddObject("cmd_4c_ImpXML", "CommandButton")
357:         WITH loc_oPagina.cmd_4c_ImpXML
358:             .Caption       = "  Importa XML"
359:             .Top           = 114
360:             .Left          = 127
361:             .Width         = 120
362:             .Height        = 40
363:             .FontName      = "Tahoma"
364:             .FontSize      = 8
365:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 372 a 381:
372:         *-- Grid de lista (abaixo dos botoes XML)
373:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
374:         WITH loc_oPagina.grd_4c_Lista
375:             .Top                = 157
376:             .Left               = 0
377:             .Width              = 995
378:             .Height             = 438
379:             .FontName           = "Verdana"
380:             .FontSize           = 8
381:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 394 a 409:
394:         ENDWITH
395: 
396:         *-- BINDEVENT para botoes (PUBLIC para funcionar com BINDEVENT)
397:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
398:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
399:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
400:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
401:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
402:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
403:         BINDEVENT(loc_oPagina.cmd_4c_ExpXML,                   "Click", THIS, "BtnExpXMLClick")
404:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML,                   "Click", THIS, "BtnImpXMLClick")
405:         BINDEVENT(loc_oPagina.grd_4c_Lista,                    "DblClick", THIS, "GrdListaDblClick")
406: 
407:         THIS.TornarControlesVisiveis(loc_oPagina)
408:     ENDPROC
409: 

*-- Linhas 417 a 441:
417:         *-- Container botoes Confirmar/Cancelar (canto superior direito, +29 compensado)
418:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
419:         WITH loc_oPagina.cnt_4c_BotoesAcao
420:             .Top         = 33
421:             .Left        = 842
422:             .Width       = 160
423:             .Height      = 85
424:             .BackStyle   = 1
425:             .BackColor   = RGB(53, 53, 53)
426:             .BorderWidth = 0
427:             .Visible     = .T.
428:         ENDWITH
429: 
430:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
431:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
432:             .Caption         = "Confirmar"
433:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
434:             .PicturePosition = 13
435:             .Top             = 5
436:             .Left            = 5
437:             .Width           = 75
438:             .Height          = 75
439:             .FontName        = "Tahoma"
440:             .FontSize        = 8
441:             .FontBold        = .T.

*-- Linhas 450 a 464:
450:             .Visible         = .T.
451:         ENDWITH
452: 
453:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
454:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
455:             .Caption         = "Cancelar"
456:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
457:             .PicturePosition = 13
458:             .Top             = 5
459:             .Left            = 80
460:             .Width           = 75
461:             .Height          = 75
462:             .FontName        = "Tahoma"
463:             .FontSize        = 8
464:             .FontBold        = .T.

*-- Linhas 478 a 500:
478:         loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
479:         WITH loc_oPagina.pgf_4c_PagDados
480:             .PageCount  = 2
481:             .Top        = 149
482:             .Left       = -1
483:             .Width      = 998
484:             .Height     = 476
485:             .Tabs       = .T.
486:             .Visible    = .T.
487:         ENDWITH
488: 
489:         WITH loc_oPagina.pgf_4c_PagDados.Page1
490:             .Caption    = "Dados Principais"
491:             .BackColor  = RGB(255, 255, 255)
492:         ENDWITH
493: 
494:         WITH loc_oPagina.pgf_4c_PagDados.Page2
495:             .Caption    = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil / Fiscal"
496:             .BackColor  = RGB(255, 255, 255)
497:         ENDWITH
498: 
499:         *-- Campos Page1 - primeira metade (top < 236)
500:         THIS.ConfigurarPaginaDadosParte1()

*-- Linhas 506 a 515:
506:         THIS.ConfigurarPaginaDadosPage2()
507: 
508:         *-- BINDEVENT para botoes de acao
509:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
510:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
511: 
512:         THIS.TornarControlesVisiveis(loc_oPagina)
513:     ENDPROC
514: 
515:     *--------------------------------------------------------------------------

*-- Linhas 535 a 548:
535:                 *-- Configurar colunas APOS RecordSource (redefine headers resetados pelo auto-bind)
536:                 loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.codigos"
537:                 loc_oGrid.Column1.Width            = 80
538:                 loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
539:                 loc_oGrid.Column1.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"
540: 
541:                 loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descricaos"
542:                 loc_oGrid.Column2.Width            = 400
543:                 loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
544:                 loc_oGrid.Column2.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"
545: 
546:                 THIS.FormatarGridLista(loc_oGrid)
547:                 loc_lResultado = .T.
548:             ENDIF

*-- Linhas 860 a 886:
860:         *----------------------------------------------------------------------
861: 
862:         *-- Label Codigo
863:         loc_oPag1.AddObject("lbl_4c_Label1", "Label")
864:         WITH loc_oPag1.lbl_4c_Label1
865:             .Caption   = "C" + CHR(243) + "digo :"
866:             .Top       = 11
867:             .Left      = 91
868:             .Width     = 42
869:             .Height    = 15
870:             .FontName  = "Tahoma"
871:             .FontSize  = 8
872:             .BackStyle = 0
873:             .ForeColor = RGB(90, 90, 90)
874:             .Visible   = .T.
875:         ENDWITH
876: 
877:         *-- Codigo CFOP
878:         loc_oPag1.AddObject("txt_4c_Codigo", "TextBox")
879:         WITH loc_oPag1.txt_4c_Codigo
880:             .Top           = 7
881:             .Left          = 136
882:             .Width         = 91
883:             .Height        = 24
884:             .FontName      = "Tahoma"
885:             .FontSize      = 8
886:             .MaxLength     = 10

*-- Linhas 894 a 949:
894:         loc_oPag1.AddObject("obj_4c_Opc_situacao", "OptionGroup")
895:         WITH loc_oPag1.obj_4c_Opc_situacao
896:             .ButtonCount = 2
897:             .Top         = 11
898:             .Left        = 243
899:             .Width       = 137
900:             .Height      = 17
901:             .BorderStyle = 0
902:             .Visible     = .T.
903:         ENDWITH
904:         WITH loc_oPag1.obj_4c_Opc_situacao.Buttons(1)
905:             .Caption   = "Ativo"
906:             .Left      = 0
907:             .Top       = 0
908:             .AutoSize  = .T.
909:             .FontName  = "Tahoma"
910:             .FontSize  = 8
911:             .ForeColor = RGB(90, 90, 90)
912:             .Themes    = .F.
913:         ENDWITH
914:         WITH loc_oPag1.obj_4c_Opc_situacao.Buttons(2)
915:             .Caption   = "Inativo"
916:             .Left      = 60
917:             .Top       = 0
918:             .AutoSize  = .T.
919:             .FontName  = "Tahoma"
920:             .FontSize  = 8
921:             .ForeColor = RGB(90, 90, 90)
922:             .Themes    = .F.
923:         ENDWITH
924: 
925:         *-- Label Operacao
926:         loc_oPag1.AddObject("lbl_4c_Label3", "Label")
927:         WITH loc_oPag1.lbl_4c_Label3
928:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
929:             .Top       = 11
930:             .Left      = 393
931:             .Width     = 56
932:             .Height    = 15
933:             .FontName  = "Tahoma"
934:             .FontSize  = 8
935:             .BackStyle = 0
936:             .ForeColor = RGB(90, 90, 90)
937:             .Visible   = .T.
938:         ENDWITH
939: 
940:         *-- Combo Operacao (E=Entrada, S=Saida)
941:         loc_oPag1.AddObject("cbo_4c_CmbOperacao", "ComboBox")
942:         WITH loc_oPag1.cbo_4c_CmbOperacao
943:             .Top           = 7
944:             .Left          = 459
945:             .Width         = 107
946:             .Height        = 24
947:             .FontName      = "Tahoma"
948:             .FontSize      = 8
949:             .RowSourceType = 1

*-- Linhas 956 a 982:
956:         ENDWITH
957: 
958:         *-- Label Tipo
959:         loc_oPag1.AddObject("lbl_4c_Label37", "Label")
960:         WITH loc_oPag1.lbl_4c_Label37
961:             .Caption   = "Tipo :"
962:             .Top       = 12
963:             .Left      = 616
964:             .Width     = 35
965:             .Height    = 15
966:             .FontName  = "Tahoma"
967:             .FontSize  = 8
968:             .BackStyle = 0
969:             .ForeColor = RGB(90, 90, 90)
970:             .Visible   = .T.
971:         ENDWITH
972: 
973:         *-- Combo Tipo (1=Compras,2=Dev.Compras,3=Vendas,4=Dev.Vendas,5=Servicos)
974:         loc_oPag1.AddObject("cbo_4c_Cmbtipo", "ComboBox")
975:         WITH loc_oPag1.cbo_4c_Cmbtipo
976:             .Top           = 7
977:             .Left          = 653
978:             .Width         = 151
979:             .Height        = 24
980:             .FontName      = "Tahoma"
981:             .FontSize      = 8
982:             .RowSourceType = 1

*-- Linhas 992 a 1018:
992:         ENDWITH
993: 
994:         *-- Label Digitos Para NF
995:         loc_oPag1.AddObject("lbl_4c_Label24", "Label")
996:         WITH loc_oPag1.lbl_4c_Label24
997:             .Caption   = "D" + CHR(237) + "gitos Para NF :"
998:             .Top       = 12
999:             .Left      = 848
1000:             .Width     = 82
1001:             .Height    = 15
1002:             .FontName  = "Tahoma"
1003:             .FontSize  = 8
1004:             .BackStyle = 0
1005:             .ForeColor = RGB(90, 90, 90)
1006:             .Visible   = .T.
1007:         ENDWITH
1008: 
1009:         *-- Spinner Digitos Para NF (0-6)
1010:         loc_oPag1.AddObject("obj_4c_Ndigito", "Spinner")
1011:         WITH loc_oPag1.obj_4c_Ndigito
1012:             .Top                = 7
1013:             .Left               = 947
1014:             .Width              = 40
1015:             .Height             = 24
1016:             .FontName           = "Tahoma"
1017:             .FontSize           = 8
1018:             .SpinnerHighValue   = 6

*-- Linhas 1027 a 1084:
1027:         ENDWITH
1028: 
1029:         *-- Label Descricao Nota Fiscal
1030:         loc_oPag1.AddObject("lbl_4c_Label2", "Label")
1031:         WITH loc_oPag1.lbl_4c_Label2
1032:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Nota Fiscal :"
1033:             .Top       = 38
1034:             .Left      = 23
1035:             .Width     = 110
1036:             .Height    = 15
1037:             .FontName  = "Tahoma"
1038:             .FontSize  = 8
1039:             .BackStyle = 0
1040:             .ForeColor = RGB(90, 90, 90)
1041:             .Visible   = .T.
1042:         ENDWITH
1043: 
1044:         *-- TextBox Descricao NF
1045:         loc_oPag1.AddObject("txt_4c_Descricao", "TextBox")
1046:         WITH loc_oPag1.txt_4c_Descricao
1047:             .Top           = 34
1048:             .Left          = 136
1049:             .Width         = 430
1050:             .Height        = 24
1051:             .FontName      = "Tahoma"
1052:             .FontSize      = 8
1053:             .MaxLength     = 60
1054:             .SpecialEffect = 1
1055:             .ForeColor     = RGB(90, 90, 90)
1056:             .BorderColor   = RGB(100, 100, 100)
1057:             .Visible       = .T.
1058:         ENDWITH
1059: 
1060:         *-- Label Descricao Consulta
1061:         loc_oPag1.AddObject("lbl_4c_Label29", "Label")
1062:         WITH loc_oPag1.lbl_4c_Label29
1063:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Consulta :"
1064:             .Top       = 65
1065:             .Left      = 33
1066:             .Width     = 100
1067:             .Height    = 15
1068:             .FontName  = "Tahoma"
1069:             .FontSize  = 8
1070:             .BackStyle = 0
1071:             .ForeColor = RGB(90, 90, 90)
1072:             .Visible   = .T.
1073:         ENDWITH
1074: 
1075:         *-- TextBox Descricao Consulta
1076:         loc_oPag1.AddObject("txt_4c_Desc2s", "TextBox")
1077:         WITH loc_oPag1.txt_4c_Desc2s
1078:             .Top           = 61
1079:             .Left          = 136
1080:             .Width         = 430
1081:             .Height        = 24
1082:             .FontName      = "Tahoma"
1083:             .FontSize      = 8
1084:             .MaxLength     = 60

*-- Linhas 1091 a 1100:
1091:         *-- Linha separadora horizontal (shp01)
1092:         loc_oPag1.AddObject("shp_4c_Shp01", "Shape")
1093:         WITH loc_oPag1.shp_4c_Shp01
1094:             .Top         = 92
1095:             .Left        = 3
1096:             .Width       = 984
1097:             .Height      = 1
1098:             .BackStyle   = 1
1099:             .BackColor   = RGB(180, 180, 180)
1100:             .BorderStyle = 0

*-- Linhas 1106 a 1132:
1106:         *----------------------------------------------------------------------
1107: 
1108:         *-- Label ICMS
1109:         loc_oPag1.AddObject("lbl_4c_Label4", "Label")
1110:         WITH loc_oPag1.lbl_4c_Label4
1111:             .Caption   = "I C M S :"
1112:             .Top       = 105
1113:             .Left      = 90
1114:             .Width     = 43
1115:             .Height    = 15
1116:             .FontName  = "Tahoma"
1117:             .FontSize  = 8
1118:             .BackStyle = 0
1119:             .ForeColor = RGB(90, 90, 90)
1120:             .Visible   = .T.
1121:         ENDWITH
1122: 
1123:         *-- Combo ICMS (T=Tributado, I=Isento, O=Outros, N=N.Tributa)
1124:         loc_oPag1.AddObject("cbo_4c_CmbIcms", "ComboBox")
1125:         WITH loc_oPag1.cbo_4c_CmbIcms
1126:             .Top           = 101
1127:             .Left          = 136
1128:             .Width         = 82
1129:             .Height        = 23
1130:             .FontName      = "Tahoma"
1131:             .FontSize      = 8
1132:             .RowSourceType = 1

*-- Linhas 1139 a 1165:
1139:         ENDWITH
1140: 
1141:         *-- Label Incluir ICMS
1142:         loc_oPag1.AddObject("lbl_4c_Label26", "Label")
1143:         WITH loc_oPag1.lbl_4c_Label26
1144:             .Caption   = "Incluir ICMS :"
1145:             .Top       = 105
1146:             .Left      = 311
1147:             .Width     = 66
1148:             .Height    = 15
1149:             .FontName  = "Tahoma"
1150:             .FontSize  = 8
1151:             .BackStyle = 0
1152:             .ForeColor = RGB(90, 90, 90)
1153:             .Visible   = .T.
1154:         ENDWITH
1155: 
1156:         *-- Combo Incluir ICMS (1=Nao, 2=Base, 3=Preco)
1157:         loc_oPag1.AddObject("cbo_4c_Combo3", "ComboBox")
1158:         WITH loc_oPag1.cbo_4c_Combo3
1159:             .Top           = 101
1160:             .Left          = 380
1161:             .Width         = 82
1162:             .Height        = 23
1163:             .FontName      = "Tahoma"
1164:             .FontSize      = 8
1165:             .RowSourceType = 1

*-- Linhas 1172 a 1279:
1172:         ENDWITH
1173: 
1174:         *-- Label ICMS Sobre
1175:         loc_oPag1.AddObject("lbl_4c_Label14", "Label")
1176:         WITH loc_oPag1.lbl_4c_Label14
1177:             .Caption   = "ICMS Sobre :"
1178:             .Top       = 104
1179:             .Left      = 481
1180:             .Width     = 65
1181:             .Height    = 15
1182:             .FontName  = "Tahoma"
1183:             .FontSize  = 8
1184:             .BackStyle = 0
1185:             .ForeColor = RGB(90, 90, 90)
1186:             .Visible   = .T.
1187:         ENDWITH
1188: 
1189:         *-- Label CFOP ST60
1190:         loc_oPag1.AddObject("lbl_4c_Label49", "Label")
1191:         WITH loc_oPag1.lbl_4c_Label49
1192:             .Caption   = "CFOP ST60:"
1193:             .Top       = 102
1194:             .Left      = 614
1195:             .Width     = 60
1196:             .Height    = 15
1197:             .FontName  = "Tahoma"
1198:             .FontSize  = 8
1199:             .BackStyle = 0
1200:             .ForeColor = RGB(90, 90, 90)
1201:             .Visible   = .T.
1202:         ENDWITH
1203: 
1204:         *-- TextBox CFOP ST60 (lookup SigCdCfo)
1205:         loc_oPag1.AddObject("txt_4c_CfoST60", "TextBox")
1206:         WITH loc_oPag1.txt_4c_CfoST60
1207:             .Top           = 101
1208:             .Left          = 690
1209:             .Width         = 82
1210:             .Height        = 23
1211:             .FontName      = "Tahoma"
1212:             .FontSize      = 8
1213:             .MaxLength     = 10
1214:             .SpecialEffect = 1
1215:             .ForeColor     = RGB(90, 90, 90)
1216:             .BorderColor   = RGB(100, 100, 100)
1217:             .Visible       = .T.
1218:         ENDWITH
1219: 
1220:         *-- Label CFOP Subst.Trib.
1221:         loc_oPag1.AddObject("lbl_4c_Label11", "Label")
1222:         WITH loc_oPag1.lbl_4c_Label11
1223:             .Caption   = "CFOP Subst.Trib.:"
1224:             .Top       = 102
1225:             .Left      = 791
1226:             .Width     = 89
1227:             .Height    = 15
1228:             .FontName  = "Tahoma"
1229:             .FontSize  = 8
1230:             .BackStyle = 0
1231:             .ForeColor = RGB(90, 90, 90)
1232:             .Visible   = .T.
1233:         ENDWITH
1234: 
1235:         *-- TextBox CFOP Subst.Trib. (lookup SigCdCfo)
1236:         loc_oPag1.AddObject("txt_4c_CfoST", "TextBox")
1237:         WITH loc_oPag1.txt_4c_CfoST
1238:             .Top           = 101
1239:             .Left          = 887
1240:             .Width         = 82
1241:             .Height        = 23
1242:             .FontName      = "Tahoma"
1243:             .FontSize      = 8
1244:             .MaxLength     = 10
1245:             .SpecialEffect = 1
1246:             .ForeColor     = RGB(90, 90, 90)
1247:             .BorderColor   = RGB(100, 100, 100)
1248:             .Visible       = .T.
1249:         ENDWITH
1250: 
1251:         *-- CheckBox Frete ICMS
1252:         loc_oPag1.AddObject("chk_4c_ObjFreteICM", "CheckBox")
1253:         WITH loc_oPag1.chk_4c_ObjFreteICM
1254:             .Caption       = "Frete"
1255:             .Top           = 102
1256:             .Left          = 549
1257:             .Width         = 44
1258:             .Height        = 15
1259:             .FontName      = "Tahoma"
1260:             .FontSize      = 8
1261:             .BackStyle     = 0
1262:             .ForeColor     = RGB(90, 90, 90)
1263:             .SpecialEffect = 1
1264:             .AutoSize      = .T.
1265:             .Alignment     = 0
1266:             .Visible       = .T.
1267:         ENDWITH
1268: 
1269:         *-- CheckBox Seguro ICMS
1270:         loc_oPag1.AddObject("chk_4c_ObjSegIcm", "CheckBox")
1271:         WITH loc_oPag1.chk_4c_ObjSegIcm
1272:             .Caption       = "Seguro"
1273:             .Top           = 117
1274:             .Left          = 549
1275:             .Width         = 52
1276:             .Height        = 15
1277:             .FontName      = "Tahoma"
1278:             .FontSize      = 8
1279:             .BackStyle     = 0

*-- Linhas 1285 a 1311:
1285:         ENDWITH
1286: 
1287:         *-- Label Sobre Desconto
1288:         loc_oPag1.AddObject("lbl_4c_Label31", "Label")
1289:         WITH loc_oPag1.lbl_4c_Label31
1290:             .Caption   = "Sobre Desconto :"
1291:             .Top       = 131
1292:             .Left      = 48
1293:             .Width     = 85
1294:             .Height    = 15
1295:             .FontName  = "Tahoma"
1296:             .FontSize  = 8
1297:             .BackStyle = 0
1298:             .ForeColor = RGB(90, 90, 90)
1299:             .Visible   = .T.
1300:         ENDWITH
1301: 
1302:         *-- Combo ICMS Sobre Desconto (1=Sim, 2=Nao)
1303:         loc_oPag1.AddObject("cbo_4c_Combo6", "ComboBox")
1304:         WITH loc_oPag1.cbo_4c_Combo6
1305:             .Top           = 127
1306:             .Left          = 136
1307:             .Width         = 82
1308:             .Height        = 23
1309:             .FontName      = "Tahoma"
1310:             .FontSize      = 8
1311:             .RowSourceType = 1

*-- Linhas 1318 a 1344:
1318:         ENDWITH
1319: 
1320:         *-- Label Inclui IPI na Base
1321:         loc_oPag1.AddObject("lbl_4c_Label25", "Label")
1322:         WITH loc_oPag1.lbl_4c_Label25
1323:             .Caption   = "Inclui IPI na Base :"
1324:             .Top       = 132
1325:             .Left      = 285
1326:             .Width     = 92
1327:             .Height    = 15
1328:             .FontName  = "Tahoma"
1329:             .FontSize  = 8
1330:             .BackStyle = 0
1331:             .ForeColor = RGB(90, 90, 90)
1332:             .Visible   = .T.
1333:         ENDWITH
1334: 
1335:         *-- Combo Inclui IPI na Base ICMS (S=Sim, N=Nao)
1336:         loc_oPag1.AddObject("cbo_4c_Combo4", "ComboBox")
1337:         WITH loc_oPag1.cbo_4c_Combo4
1338:             .Top           = 127
1339:             .Left          = 380
1340:             .Width         = 82
1341:             .Height        = 23
1342:             .FontName      = "Tahoma"
1343:             .FontSize      = 8
1344:             .RowSourceType = 1

*-- Linhas 1351 a 1412:
1351:         ENDWITH
1352: 
1353:         *-- Label CFOP Destino
1354:         loc_oPag1.AddObject("lbl_4c_Label19", "Label")
1355:         WITH loc_oPag1.lbl_4c_Label19
1356:             .Caption   = "CFOP Destino :"
1357:             .Top       = 131
1358:             .Left      = 805
1359:             .Width     = 75
1360:             .Height    = 15
1361:             .FontName  = "Tahoma"
1362:             .FontSize  = 8
1363:             .BackStyle = 0
1364:             .ForeColor = RGB(90, 90, 90)
1365:             .Visible   = .T.
1366:         ENDWITH
1367: 
1368:         *-- TextBox CFOP Destino (lookup SigCdCfo)
1369:         loc_oPag1.AddObject("txt_4c_Cfdest", "TextBox")
1370:         WITH loc_oPag1.txt_4c_Cfdest
1371:             .Top           = 127
1372:             .Left          = 887
1373:             .Width         = 82
1374:             .Height        = 23
1375:             .FontName      = "Tahoma"
1376:             .FontSize      = 8
1377:             .MaxLength     = 10
1378:             .SpecialEffect = 1
1379:             .ForeColor     = RGB(90, 90, 90)
1380:             .BorderColor   = RGB(100, 100, 100)
1381:             .Visible       = .T.
1382:         ENDWITH
1383: 
1384:         *-- CheckBox Despesas Acessorias ICMS
1385:         loc_oPag1.AddObject("chk_4c_ObjDespIcm", "CheckBox")
1386:         WITH loc_oPag1.chk_4c_ObjDespIcm
1387:             .Caption       = "Despesas Acess" + CHR(243) + "rias"
1388:             .Top           = 132
1389:             .Left          = 549
1390:             .Width         = 118
1391:             .Height        = 15
1392:             .FontName      = "Tahoma"
1393:             .FontSize      = 8
1394:             .BackStyle     = 0
1395:             .ForeColor     = RGB(90, 90, 90)
1396:             .SpecialEffect = 1
1397:             .AutoSize      = .T.
1398:             .Alignment     = 0
1399:             .Visible       = .T.
1400:         ENDWITH
1401: 
1402:         *-- CheckBox Incluir ICMS no Total NF
1403:         loc_oPag1.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
1404:         WITH loc_oPag1.chk_4c_Fwcheckbox1
1405:             .Caption       = "Incluir ICMS no Total da N.F."
1406:             .Top           = 147
1407:             .Left          = 549
1408:             .Width         = 156
1409:             .Height        = 15
1410:             .FontName      = "Tahoma"
1411:             .FontSize      = 8
1412:             .BackStyle     = 0

*-- Linhas 1418 a 1444:
1418:         ENDWITH
1419: 
1420:         *-- Label Substituicao Tributaria
1421:         loc_oPag1.AddObject("lbl_4c_Label10", "Label")
1422:         WITH loc_oPag1.lbl_4c_Label10
1423:             .Caption   = "Substitui" + CHR(231) + CHR(227) + "o Tribut.:"
1424:             .Top       = 157
1425:             .Left      = 34
1426:             .Width     = 99
1427:             .Height    = 15
1428:             .FontName  = "Tahoma"
1429:             .FontSize  = 8
1430:             .BackStyle = 0
1431:             .ForeColor = RGB(90, 90, 90)
1432:             .Visible   = .T.
1433:         ENDWITH
1434: 
1435:         *-- Combo Substituicao Tributaria (S=Sim, N=Nao)
1436:         loc_oPag1.AddObject("cbo_4c_CmbSTRIB", "ComboBox")
1437:         WITH loc_oPag1.cbo_4c_CmbSTRIB
1438:             .Top           = 153
1439:             .Left          = 136
1440:             .Width         = 82
1441:             .Height        = 23
1442:             .FontName      = "Tahoma"
1443:             .FontSize      = 8
1444:             .RowSourceType = 1

*-- Linhas 1451 a 1508:
1451:         ENDWITH
1452: 
1453:         *-- Label Base Substituicao
1454:         loc_oPag1.AddObject("lbl_4c_Label12", "Label")
1455:         WITH loc_oPag1.lbl_4c_Label12
1456:             .Caption   = "Base Substitui" + CHR(231) + CHR(227) + "o :"
1457:             .Top       = 157
1458:             .Left      = 284
1459:             .Width     = 93
1460:             .Height    = 15
1461:             .FontName  = "Tahoma"
1462:             .FontSize  = 8
1463:             .BackStyle = 0
1464:             .ForeColor = RGB(90, 90, 90)
1465:             .Visible   = .T.
1466:         ENDWITH
1467: 
1468:         *-- TextBox Base Calculo ST (% pbcsts)
1469:         loc_oPag1.AddObject("txt_4c_Bcst", "TextBox")
1470:         WITH loc_oPag1.txt_4c_Bcst
1471:             .Top           = 153
1472:             .Left          = 380
1473:             .Width         = 82
1474:             .Height        = 23
1475:             .FontName      = "Tahoma"
1476:             .FontSize      = 8
1477:             .InputMask     = "999.99"
1478:             .SpecialEffect = 1
1479:             .ForeColor     = RGB(90, 90, 90)
1480:             .BorderColor   = RGB(100, 100, 100)
1481:             .Visible       = .T.
1482:         ENDWITH
1483: 
1484:         *-- Label CFOP Transporte
1485:         loc_oPag1.AddObject("lbl_4c_Label28", "Label")
1486:         WITH loc_oPag1.lbl_4c_Label28
1487:             .Caption   = "CFOP Transporte :"
1488:             .Top       = 157
1489:             .Left      = 788
1490:             .Width     = 92
1491:             .Height    = 15
1492:             .FontName  = "Tahoma"
1493:             .FontSize  = 8
1494:             .BackStyle = 0
1495:             .ForeColor = RGB(90, 90, 90)
1496:             .Visible   = .T.
1497:         ENDWITH
1498: 
1499:         *-- Combo CFOP Transporte (1=Sim, 2=Nao)
1500:         loc_oPag1.AddObject("cbo_4c_Combo5", "ComboBox")
1501:         WITH loc_oPag1.cbo_4c_Combo5
1502:             .Top           = 153
1503:             .Left          = 887
1504:             .Width         = 82
1505:             .Height        = 23
1506:             .FontName      = "Tahoma"
1507:             .FontSize      = 8
1508:             .RowSourceType = 1

*-- Linhas 1514 a 1527:
1514:             .Visible       = .T.
1515:         ENDWITH
1516: 
1517:         *-- CheckBox Soma ICMS Frete no Total NF (Visible=.F. por padrao)
1518:         loc_oPag1.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
1519:         WITH loc_oPag1.chk_4c_Fwcheckbox2
1520:             .Caption       = "Soma ICMS frete no Total da N.F."
1521:             .Top           = 163
1522:             .Left          = 549
1523:             .Width         = 180
1524:             .Height        = 15
1525:             .FontName      = "Tahoma"
1526:             .FontSize      = 8
1527:             .BackStyle     = 0

*-- Linhas 1533 a 1590:
1533:         ENDWITH
1534: 
1535:         *-- Label Situacao Tributaria ICMS
1536:         loc_oPag1.AddObject("lbl_4c_Label22", "Label")
1537:         WITH loc_oPag1.lbl_4c_Label22
1538:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut.:"
1539:             .Top       = 183
1540:             .Left      = 51
1541:             .Width     = 82
1542:             .Height    = 15
1543:             .FontName  = "Tahoma"
1544:             .FontSize  = 8
1545:             .BackStyle = 0
1546:             .ForeColor = RGB(90, 90, 90)
1547:             .Visible   = .T.
1548:         ENDWITH
1549: 
1550:         *-- TextBox Situacao Tributaria ICMS (lookup SigCdIcm)
1551:         loc_oPag1.AddObject("txt_4c_Sittricm", "TextBox")
1552:         WITH loc_oPag1.txt_4c_Sittricm
1553:             .Top           = 179
1554:             .Left          = 136
1555:             .Width         = 31
1556:             .Height        = 22
1557:             .FontName      = "Tahoma"
1558:             .FontSize      = 8
1559:             .MaxLength     = 3
1560:             .SpecialEffect = 1
1561:             .ForeColor     = RGB(90, 90, 90)
1562:             .BorderColor   = RGB(100, 100, 100)
1563:             .Visible       = .T.
1564:         ENDWITH
1565: 
1566:         *-- Label ICMS Incluso no Preco
1567:         loc_oPag1.AddObject("lbl_4c_Label36", "Label")
1568:         WITH loc_oPag1.lbl_4c_Label36
1569:             .Caption   = "ICMS Incluso no Pre" + CHR(231) + "o:"
1570:             .Top       = 182
1571:             .Left      = 264
1572:             .Width     = 113
1573:             .Height    = 15
1574:             .FontName  = "Tahoma"
1575:             .FontSize  = 8
1576:             .BackStyle = 0
1577:             .ForeColor = RGB(90, 90, 90)
1578:             .Visible   = .T.
1579:         ENDWITH
1580: 
1581:         *-- Combo ICMS Incluso no Preco (1=Sim, 2=Nao)
1582:         loc_oPag1.AddObject("cbo_4c_Combo10", "ComboBox")
1583:         WITH loc_oPag1.cbo_4c_Combo10
1584:             .Top           = 315
1585:             .Left          = 136
1586:             .Width         = 82
1587:             .Height        = 23
1588:             .FontName      = "Tahoma"
1589:             .FontSize      = 8
1590:             .RowSourceType = 1

*-- Linhas 1597 a 1623:
1597:         ENDWITH
1598: 
1599:         *-- Label Contribuinte
1600:         loc_oPag1.AddObject("lbl_4c_Label6", "Label")
1601:         WITH loc_oPag1.lbl_4c_Label6
1602:             .Caption   = "Contribuinte :"
1603:             .Top       = 183
1604:             .Left      = 812
1605:             .Width     = 68
1606:             .Height    = 15
1607:             .FontName  = "Tahoma"
1608:             .FontSize  = 8
1609:             .BackStyle = 0
1610:             .ForeColor = RGB(90, 90, 90)
1611:             .Visible   = .T.
1612:         ENDWITH
1613: 
1614:         *-- Combo Contribuinte (S=Sim, N=Nao, O=Outros)
1615:         loc_oPag1.AddObject("cbo_4c_CmbContribuinte", "ComboBox")
1616:         WITH loc_oPag1.cbo_4c_CmbContribuinte
1617:             .Top           = 179
1618:             .Left          = 887
1619:             .Width         = 82
1620:             .Height        = 23
1621:             .FontName      = "Tahoma"
1622:             .FontSize      = 8
1623:             .RowSourceType = 1

*-- Linhas 1630 a 1702:
1630:         ENDWITH
1631: 
1632:         *-- Label Venda Consumidor
1633:         loc_oPag1.AddObject("lbl_4c_Label23", "Label")
1634:         WITH loc_oPag1.lbl_4c_Label23
1635:             .Caption   = "Venda Consumidor :"
1636:             .Top       = 207
1637:             .Left      = 35
1638:             .Width     = 98
1639:             .Height    = 15
1640:             .FontName  = "Tahoma"
1641:             .FontSize  = 8
1642:             .BackStyle = 0
1643:             .ForeColor = RGB(90, 90, 90)
1644:             .Visible   = .T.
1645:         ENDWITH
1646: 
1647:         *-- TextBox Aliquota Venda Consumidor
1648:         loc_oPag1.AddObject("txt_4c_AliqIVCs", "TextBox")
1649:         WITH loc_oPag1.txt_4c_AliqIVCs
1650:             .Top           = 203
1651:             .Left          = 136
1652:             .Width         = 82
1653:             .Height        = 23
1654:             .FontName      = "Tahoma"
1655:             .FontSize      = 8
1656:             .InputMask     = "99.99"
1657:             .SpecialEffect = 1
1658:             .ForeColor     = RGB(90, 90, 90)
1659:             .BorderColor   = RGB(100, 100, 100)
1660:             .Visible       = .T.
1661:         ENDWITH
1662: 
1663:         *-- Label % (Venda Consumidor)
1664:         loc_oPag1.AddObject("lbl_4c_Label13", "Label")
1665:         WITH loc_oPag1.lbl_4c_Label13
1666:             .Caption   = "%"
1667:             .Top       = 207
1668:             .Left      = 219
1669:             .Width     = 13
1670:             .Height    = 15
1671:             .FontName  = "Tahoma"
1672:             .FontSize  = 8
1673:             .BackStyle = 0
1674:             .ForeColor = RGB(90, 90, 90)
1675:             .Visible   = .T.
1676:         ENDWITH
1677: 
1678:         *-- Label Mot Desoneracao ICMS
1679:         loc_oPag1.AddObject("lbl_4c_Label50", "Label")
1680:         WITH loc_oPag1.lbl_4c_Label50
1681:             .Caption   = "Mot Desonera" + CHR(231) + CHR(227) + "o ICMS :"
1682:             .Top       = 206
1683:             .Left      = 256
1684:             .Width     = 121
1685:             .Height    = 15
1686:             .FontName  = "Tahoma"
1687:             .FontSize  = 8
1688:             .BackStyle = 0
1689:             .ForeColor = RGB(90, 90, 90)
1690:             .Visible   = .T.
1691:         ENDWITH
1692: 
1693:         *-- TextBox Motivo Desoneracao ICMS (2 chars numericos)
1694:         loc_oPag1.AddObject("txt_4c_MotDeson", "TextBox")
1695:         WITH loc_oPag1.txt_4c_MotDeson
1696:             .Top           = 203
1697:             .Left          = 381
1698:             .Width         = 26
1699:             .Height        = 23
1700:             .FontName      = "Tahoma"
1701:             .FontSize      = 8
1702:             .InputMask     = "99"

*-- Linhas 1708 a 1734:
1708:         ENDWITH
1709: 
1710:         *-- Label Inibe Valor Unitario
1711:         loc_oPag1.AddObject("lbl_4c_Label21", "Label")
1712:         WITH loc_oPag1.lbl_4c_Label21
1713:             .Caption   = "Inibe Valor Unit" + CHR(225) + "rio na NF Importa" + CHR(231) + CHR(227) + "o :"
1714:             .Top       = 210
1715:             .Left      = 652
1716:             .Width     = 228
1717:             .Height    = 15
1718:             .FontName  = "Tahoma"
1719:             .FontSize  = 8
1720:             .BackStyle = 0
1721:             .ForeColor = RGB(90, 90, 90)
1722:             .Visible   = .T.
1723:         ENDWITH
1724: 
1725:         *-- Combo Inibe Valor Unitario NF Importacao (S=Sim, N=Nao)
1726:         loc_oPag1.AddObject("cbo_4c_Combo9", "ComboBox")
1727:         WITH loc_oPag1.cbo_4c_Combo9
1728:             .Top           = 206
1729:             .Left          = 887
1730:             .Width         = 82
1731:             .Height        = 23
1732:             .FontName      = "Tahoma"
1733:             .FontSize      = 8
1734:             .RowSourceType = 1

*-- Linhas 1757 a 1780:
1757:         *-- Linha separadora shp03 (top=236)
1758:         loc_oPag1.AddObject("shp_4c_Shp03", "Shape")
1759:         WITH loc_oPag1.shp_4c_Shp03
1760:             .Top         = 236
1761:             .Left        = 3
1762:             .Width       = 984
1763:             .Height      = 1
1764:             .BackStyle   = 1
1765:             .BackColor   = RGB(180, 180, 180)
1766:             .BorderStyle = 0
1767:             .Visible     = .T.
1768:         ENDWITH
1769: 
1770:         *-- Label "Especificacoes Para NF-e" (bold Verdana, top=246)
1771:         loc_oPag1.AddObject("lbl_4c_Label38", "Label")
1772:         WITH loc_oPag1.lbl_4c_Label38
1773:             .Caption   = "Especifica" + CHR(231) + CHR(245) + "es Para NF-e"
1774:             .Top       = 246
1775:             .Left      = 498
1776:             .Width     = 167
1777:             .Height    = 15
1778:             .FontName  = "Verdana"
1779:             .FontSize  = 8
1780:             .FontBold  = .T.

*-- Linhas 1788 a 1814:
1788:         *----------------------------------------------------------------------
1789: 
1790:         *-- Label IPI
1791:         loc_oPag1.AddObject("lbl_4c_Label8", "Label")
1792:         WITH loc_oPag1.lbl_4c_Label8
1793:             .Caption   = "I P I :"
1794:             .Top       = 267
1795:             .Left      = 104
1796:             .Width     = 29
1797:             .Height    = 15
1798:             .FontName  = "Tahoma"
1799:             .FontSize  = 8
1800:             .BackStyle = 0
1801:             .ForeColor = RGB(90, 90, 90)
1802:             .Visible   = .T.
1803:         ENDWITH
1804: 
1805:         *-- Combo IPI (T=Tributado, I=Isento, O=Outros)
1806:         loc_oPag1.AddObject("cbo_4c_CmbIpi", "ComboBox")
1807:         WITH loc_oPag1.cbo_4c_CmbIpi
1808:             .Top           = 263
1809:             .Left          = 136
1810:             .Width         = 82
1811:             .Height        = 23
1812:             .FontName      = "Tahoma"
1813:             .FontSize      = 8
1814:             .RowSourceType = 1

*-- Linhas 1821 a 1847:
1821:         ENDWITH
1822: 
1823:         *-- Label IPI Importacao
1824:         loc_oPag1.AddObject("lbl_4c_Label7", "Label")
1825:         WITH loc_oPag1.lbl_4c_Label7
1826:             .Caption   = "IPI Importa" + CHR(231) + CHR(227) + "o :"
1827:             .Top       = 267
1828:             .Left      = 296
1829:             .Width     = 81
1830:             .Height    = 15
1831:             .FontName  = "Tahoma"
1832:             .FontSize  = 8
1833:             .BackStyle = 0
1834:             .ForeColor = RGB(90, 90, 90)
1835:             .Visible   = .T.
1836:         ENDWITH
1837: 
1838:         *-- Combo IPI Importacao - Retira IPI do $ (ipiimpors: S=Sim/N=Nao)
1839:         loc_oPag1.AddObject("cbo_4c_CmbIpiI", "ComboBox")
1840:         WITH loc_oPag1.cbo_4c_CmbIpiI
1841:             .Top           = 263
1842:             .Left          = 136
1843:             .Width         = 82
1844:             .Height        = 23
1845:             .FontName      = "Tahoma"
1846:             .FontSize      = 8
1847:             .RowSourceType = 1

*-- Linhas 1854 a 1942:
1854:         ENDWITH
1855: 
1856:         *-- Label Destaca ICMS na NF (S/N)
1857:         loc_oPag1.AddObject("lbl_4c_Label27", "Label")
1858:         WITH loc_oPag1.lbl_4c_Label27
1859:             .Caption   = "Destaca ICMS na Nota Fiscal (S/N) :"
1860:             .Top       = 270
1861:             .Left      = 769
1862:             .Width     = 174
1863:             .Height    = 15
1864:             .FontName  = "Tahoma"
1865:             .FontSize  = 8
1866:             .BackStyle = 0
1867:             .ForeColor = RGB(90, 90, 90)
1868:             .Visible   = .T.
1869:         ENDWITH
1870: 
1871:         *-- TextBox Destaca ICMS na NF (cgergia1s, 1 char S/N)
1872:         loc_oPag1.AddObject("txt_4c_Gergia1", "TextBox")
1873:         WITH loc_oPag1.txt_4c_Gergia1
1874:             .Top           = 265
1875:             .Left          = 948
1876:             .Width         = 20
1877:             .Height        = 23
1878:             .FontName      = "Tahoma"
1879:             .FontSize      = 8
1880:             .MaxLength     = 1
1881:             .SpecialEffect = 1
1882:             .ForeColor     = RGB(90, 90, 90)
1883:             .BorderColor   = RGB(100, 100, 100)
1884:             .Visible       = .T.
1885:         ENDWITH
1886: 
1887:         *-- Label Aliquota IPI
1888:         loc_oPag1.AddObject("lbl_4c_Label15", "Label")
1889:         WITH loc_oPag1.lbl_4c_Label15
1890:             .Caption   = "Al" + CHR(237) + "quota :"
1891:             .Top       = 293
1892:             .Left      = 85
1893:             .Width     = 48
1894:             .Height    = 15
1895:             .FontName  = "Tahoma"
1896:             .FontSize  = 8
1897:             .BackStyle = 0
1898:             .ForeColor = RGB(90, 90, 90)
1899:             .Visible   = .T.
1900:         ENDWITH
1901: 
1902:         *-- TextBox Aliquota IPI (aliqipis, 99.99)
1903:         loc_oPag1.AddObject("txt_4c_Aliqs", "TextBox")
1904:         WITH loc_oPag1.txt_4c_Aliqs
1905:             .Top           = 289
1906:             .Left          = 136
1907:             .Width         = 82
1908:             .Height        = 23
1909:             .FontName      = "Tahoma"
1910:             .FontSize      = 8
1911:             .InputMask     = "99.99"
1912:             .SpecialEffect = 1
1913:             .ForeColor     = RGB(90, 90, 90)
1914:             .BorderColor   = RGB(100, 100, 100)
1915:             .Visible       = .T.
1916:         ENDWITH
1917: 
1918:         *-- Label Retira IPI do $
1919:         loc_oPag1.AddObject("lbl_4c_Label32", "Label")
1920:         WITH loc_oPag1.lbl_4c_Label32
1921:             .Caption   = "Retira IPI do $ :"
1922:             .Top       = 293
1923:             .Left      = 298
1924:             .Width     = 79
1925:             .Height    = 15
1926:             .FontName  = "Tahoma"
1927:             .FontSize  = 8
1928:             .BackStyle = 0
1929:             .ForeColor = RGB(90, 90, 90)
1930:             .Visible   = .T.
1931:         ENDWITH
1932: 
1933:         *-- Combo Inclui IPI na Base (inclipis, Sim/Nao -> numeric ListIndex)
1934:         loc_oPag1.AddObject("cbo_4c_Combo7", "ComboBox")
1935:         WITH loc_oPag1.cbo_4c_Combo7
1936:             .Top           = 289
1937:             .Left          = 380
1938:             .Width         = 82
1939:             .Height        = 23
1940:             .FontName      = "Tahoma"
1941:             .FontSize      = 8
1942:             .RowSourceType = 1

*-- Linhas 1949 a 1975:
1949:         ENDWITH
1950: 
1951:         *-- Label Nao Creditado
1952:         loc_oPag1.AddObject("lbl_4c_Label20", "Label")
1953:         WITH loc_oPag1.lbl_4c_Label20
1954:             .Caption   = "N" + CHR(227) + "o Creditado :"
1955:             .Top       = 319
1956:             .Left      = 55
1957:             .Width     = 78
1958:             .Height    = 15
1959:             .FontName  = "Tahoma"
1960:             .FontSize  = 8
1961:             .BackStyle = 0
1962:             .ForeColor = RGB(90, 90, 90)
1963:             .Visible   = .T.
1964:         ENDWITH
1965: 
1966:         *-- Combo Nao Creditado (ipincreds, Sim/Nao -> numeric ListIndex)
1967:         loc_oPag1.AddObject("cbo_4c_Combo1", "ComboBox")
1968:         WITH loc_oPag1.cbo_4c_Combo1
1969:             .Top           = 315
1970:             .Left          = 136
1971:             .Width         = 82
1972:             .Height        = 23
1973:             .FontName      = "Tahoma"
1974:             .FontSize      = 8
1975:             .RowSourceType = 1

*-- Linhas 1982 a 2008:
1982:         ENDWITH
1983: 
1984:         *-- Label Acres/Desc na Base
1985:         loc_oPag1.AddObject("lbl_4c_Label17", "Label")
1986:         WITH loc_oPag1.lbl_4c_Label17
1987:             .Caption   = "Acres/Desc na Base :"
1988:             .Top       = 319
1989:             .Left      = 273
1990:             .Width     = 104
1991:             .Height    = 15
1992:             .FontName  = "Tahoma"
1993:             .FontSize  = 8
1994:             .BackStyle = 0
1995:             .ForeColor = RGB(90, 90, 90)
1996:             .Visible   = .T.
1997:         ENDWITH
1998: 
1999:         *-- Combo Acres/Desc na Base (acresipis, S=Sim/N=Nao -> char)
2000:         loc_oPag1.AddObject("cbo_4c_Combo2", "ComboBox")
2001:         WITH loc_oPag1.cbo_4c_Combo2
2002:             .Top           = 315
2003:             .Left          = 380
2004:             .Width         = 82
2005:             .Height        = 23
2006:             .FontName      = "Tahoma"
2007:             .FontSize      = 8
2008:             .RowSourceType = 1

*-- Linhas 2015 a 2041:
2015:         ENDWITH
2016: 
2017:         *-- Label Base de Calculo IPI
2018:         loc_oPag1.AddObject("lbl_4c_Label5", "Label")
2019:         WITH loc_oPag1.lbl_4c_Label5
2020:             .Caption   = "Base de C" + CHR(225) + "lculo :"
2021:             .Top       = 345
2022:             .Left      = 49
2023:             .Width     = 84
2024:             .Height    = 15
2025:             .FontName  = "Tahoma"
2026:             .FontSize  = 8
2027:             .BackStyle = 0
2028:             .ForeColor = RGB(90, 90, 90)
2029:             .Visible   = .T.
2030:         ENDWITH
2031: 
2032:         *-- Combo Base Calculo IPI (bcipis -> F/P/B/V/G/M)
2033:         loc_oPag1.AddObject("cbo_4c_CmbBIPI", "ComboBox")
2034:         WITH loc_oPag1.cbo_4c_CmbBIPI
2035:             .Top           = 341
2036:             .Left          = 136
2037:             .Width         = 196
2038:             .Height        = 24
2039:             .FontName      = "Tahoma"
2040:             .FontSize      = 8
2041:             .RowSourceType = 1

*-- Linhas 2050 a 2076:
2050:         *-- TextBox % Base Calculo IPI (pbcipis, 999.99)
2051:         loc_oPag1.AddObject("txt_4c_BcIPI", "TextBox")
2052:         WITH loc_oPag1.txt_4c_BcIPI
2053:             .Top           = 341
2054:             .Left          = 380
2055:             .Width         = 82
2056:             .Height        = 23
2057:             .FontName      = "Tahoma"
2058:             .FontSize      = 8
2059:             .InputMask     = "999.99"
2060:             .SpecialEffect = 1
2061:             .ForeColor     = RGB(90, 90, 90)
2062:             .BorderColor   = RGB(100, 100, 100)
2063:             .Visible       = .T.
2064:         ENDWITH
2065: 
2066:         *-- Label Calcula IPI Importacao Origem Mercadoria=2
2067:         loc_oPag1.AddObject("lbl_4c_Label18", "Label")
2068:         WITH loc_oPag1.lbl_4c_Label18
2069:             .Caption   = "Calcula IPI Importa" + CHR(231) + CHR(227) + "o Para Origem Mercadoria=2 :"
2070:             .Top       = 371
2071:             .Left      = 77
2072:             .Width     = 250
2073:             .Height    = 15
2074:             .FontName  = "Tahoma"
2075:             .FontSize  = 8
2076:             .BackStyle = 0

*-- Linhas 2082 a 2091:
2082:         *-- Habilitado apenas se cmbIpiI = Sim
2083:         loc_oPag1.AddObject("cbo_4c_Combo8", "ComboBox")
2084:         WITH loc_oPag1.cbo_4c_Combo8
2085:             .Top           = 367
2086:             .Left          = 380
2087:             .Width         = 82
2088:             .Height        = 23
2089:             .FontName      = "Tahoma"
2090:             .FontSize      = 8
2091:             .RowSourceType = 1

*-- Linhas 2099 a 2162:
2099:         ENDWITH
2100: 
2101:         *-- Label IPI Sobre
2102:         loc_oPag1.AddObject("lbl_4c_Label16", "Label")
2103:         WITH loc_oPag1.lbl_4c_Label16
2104:             .Caption   = "IPI Sobre :"
2105:             .Top       = 395
2106:             .Left      = 69
2107:             .Width     = 54
2108:             .Height    = 15
2109:             .FontName  = "Tahoma"
2110:             .FontSize  = 8
2111:             .BackStyle = 0
2112:             .ForeColor = RGB(90, 90, 90)
2113:             .Visible   = .T.
2114:         ENDWITH
2115: 
2116:         *-- CheckBox Frete IPI
2117:         loc_oPag1.AddObject("chk_4c_ObjFreteIPI", "CheckBox")
2118:         WITH loc_oPag1.chk_4c_ObjFreteIPI
2119:             .Caption       = "Frete"
2120:             .Top           = 395
2121:             .Left          = 137
2122:             .Width         = 44
2123:             .Height        = 15
2124:             .FontName      = "Tahoma"
2125:             .FontSize      = 8
2126:             .BackStyle     = 0
2127:             .ForeColor     = RGB(90, 90, 90)
2128:             .SpecialEffect = 1
2129:             .AutoSize      = .T.
2130:             .Alignment     = 0
2131:             .Visible       = .T.
2132:         ENDWITH
2133: 
2134:         *-- CheckBox Seguro IPI
2135:         loc_oPag1.AddObject("chk_4c_ObjSegIPI", "CheckBox")
2136:         WITH loc_oPag1.chk_4c_ObjSegIPI
2137:             .Caption       = "Seguro"
2138:             .Top           = 395
2139:             .Left          = 188
2140:             .Width         = 52
2141:             .Height        = 15
2142:             .FontName      = "Tahoma"
2143:             .FontSize      = 8
2144:             .BackStyle     = 0
2145:             .ForeColor     = RGB(90, 90, 90)
2146:             .SpecialEffect = 1
2147:             .AutoSize      = .T.
2148:             .Alignment     = 0
2149:             .Visible       = .T.
2150:         ENDWITH
2151: 
2152:         *-- CheckBox Despesas Acessorias IPI
2153:         loc_oPag1.AddObject("chk_4c_ObjDespIPI", "CheckBox")
2154:         WITH loc_oPag1.chk_4c_ObjDespIPI
2155:             .Caption       = "Despesas Acess" + CHR(243) + "rias"
2156:             .Top           = 395
2157:             .Left          = 255
2158:             .Width         = 118
2159:             .Height        = 15
2160:             .FontName      = "Tahoma"
2161:             .FontSize      = 8
2162:             .BackStyle     = 0

*-- Linhas 2172 a 2198:
2172:         *----------------------------------------------------------------------
2173: 
2174:         *-- Label Codigo IPI Sit. Tributaria
2175:         loc_oPag1.AddObject("lbl_4c_Label30", "Label")
2176:         WITH loc_oPag1.lbl_4c_Label30
2177:             .Caption   = "C" + CHR(243) + "digo IPI Sit. Trib.:"
2178:             .Top       = 269
2179:             .Left      = 589
2180:             .Width     = 100
2181:             .Height    = 15
2182:             .FontName  = "Tahoma"
2183:             .FontSize  = 8
2184:             .BackStyle = 0
2185:             .ForeColor = RGB(90, 90, 90)
2186:             .Visible   = .T.
2187:         ENDWITH
2188: 
2189:         *-- TextBox Codigo IPI Sit. Tributaria (ipicst, 2 chars)
2190:         loc_oPag1.AddObject("txt_4c_IPICST", "TextBox")
2191:         WITH loc_oPag1.txt_4c_IPICST
2192:             .Top           = 266
2193:             .Left          = 691
2194:             .Width         = 26
2195:             .Height        = 23
2196:             .FontName      = "Tahoma"
2197:             .FontSize      = 8
2198:             .InputMask     = "99"

*-- Linhas 2204 a 2230:
2204:         ENDWITH
2205: 
2206:         *-- Label Codigo PIS Sit. Tributaria
2207:         loc_oPag1.AddObject("lbl_4c_Label33", "Label")
2208:         WITH loc_oPag1.lbl_4c_Label33
2209:             .Caption   = "C" + CHR(243) + "digo PIS Sit. Trib.:"
2210:             .Top       = 295
2211:             .Left      = 587
2212:             .Width     = 102
2213:             .Height    = 15
2214:             .FontName  = "Tahoma"
2215:             .FontSize  = 8
2216:             .BackStyle = 0
2217:             .ForeColor = RGB(90, 90, 90)
2218:             .Visible   = .T.
2219:         ENDWITH
2220: 
2221:         *-- TextBox Codigo PIS Sit. Tributaria (piscst, 2 chars)
2222:         loc_oPag1.AddObject("txt_4c_PISCST", "TextBox")
2223:         WITH loc_oPag1.txt_4c_PISCST
2224:             .Top           = 291
2225:             .Left          = 691
2226:             .Width         = 26
2227:             .Height        = 23
2228:             .FontName      = "Tahoma"
2229:             .FontSize      = 8
2230:             .InputMask     = "99"

*-- Linhas 2236 a 2262:
2236:         ENDWITH
2237: 
2238:         *-- Label Codigo COFINS Sit. Tributaria
2239:         loc_oPag1.AddObject("lbl_4c_Label34", "Label")
2240:         WITH loc_oPag1.lbl_4c_Label34
2241:             .Caption   = "C" + CHR(243) + "digo COFINS Sit. Trib.:"
2242:             .Top       = 319
2243:             .Left      = 565
2244:             .Width     = 124
2245:             .Height    = 15
2246:             .FontName  = "Tahoma"
2247:             .FontSize  = 8
2248:             .BackStyle = 0
2249:             .ForeColor = RGB(90, 90, 90)
2250:             .Visible   = .T.
2251:         ENDWITH
2252: 
2253:         *-- TextBox Codigo COFINS Sit. Tributaria (cofcst, 2 chars)
2254:         loc_oPag1.AddObject("txt_4c_COFCST", "TextBox")
2255:         WITH loc_oPag1.txt_4c_COFCST
2256:             .Top           = 315
2257:             .Left          = 691
2258:             .Width         = 26
2259:             .Height        = 23
2260:             .FontName      = "Tahoma"
2261:             .FontSize      = 8
2262:             .InputMask     = "99"

*-- Linhas 2268 a 2294:
2268:         ENDWITH
2269: 
2270:         *-- Label Codigo ISSQN Lista Servicos
2271:         loc_oPag1.AddObject("lbl_4c_Label35", "Label")
2272:         WITH loc_oPag1.lbl_4c_Label35
2273:             .Caption   = "C" + CHR(243) + "digo ISSQN Lista Serv.:"
2274:             .Top       = 343
2275:             .Left      = 562
2276:             .Width     = 127
2277:             .Height    = 15
2278:             .FontName  = "Tahoma"
2279:             .FontSize  = 8
2280:             .BackStyle = 0
2281:             .ForeColor = RGB(90, 90, 90)
2282:             .Visible   = .T.
2283:         ENDWITH
2284: 
2285:         *-- TextBox Codigo ISSQN Lista Servicos (issqnl, 5 chars)
2286:         loc_oPag1.AddObject("txt_4c_ISSQNL", "TextBox")
2287:         WITH loc_oPag1.txt_4c_ISSQNL
2288:             .Top           = 339
2289:             .Left          = 691
2290:             .Width         = 42
2291:             .Height        = 23
2292:             .FontName      = "Tahoma"
2293:             .FontSize      = 8
2294:             .InputMask     = "XXXXX"

*-- Linhas 2300 a 2637:
2300:         ENDWITH
2301: 
2302:         *-- Label Codigo Enquadramento IPI
2303:         loc_oPag1.AddObject("lbl_4c_Label9", "Label")
2304:         WITH loc_oPag1.lbl_4c_Label9
2305:             .Caption   = "C" + CHR(243) + "digo Enquadramento IPI:"
2306:             .Top       = 366
2307:             .Left      = 554
2308:             .Width     = 135
2309:             .Height    = 15
2310:             .FontName  = "Tahoma"
2311:             .FontSize  = 8
2312:             .BackStyle = 0
2313:             .ForeColor = RGB(90, 90, 90)
2314:             .Visible   = .T.
2315:         ENDWITH
2316: 
2317:         *-- TextBox Codigo Enquadramento IPI (ipienq, 3 chars)
2318:         loc_oPag1.AddObject("txt_4c_IPIEnq", "TextBox")
2319:         WITH loc_oPag1.txt_4c_IPIEnq
2320:             .Top           = 363
2321:             .Left          = 691
2322:             .Width         = 26
2323:             .Height        = 23
2324:             .FontName      = "Tahoma"
2325:             .FontSize      = 8
2326:             .MaxLength     = 3
2327:             .SpecialEffect = 1
2328:             .ForeColor     = RGB(90, 90, 90)
2329:             .BorderColor   = RGB(100, 100, 100)
2330:             .Visible       = .T.
2331:         ENDWITH
2332: 
2333:         *-- Label Aliquota do PIS
2334:         loc_oPag1.AddObject("lbl_4c_Label39", "Label")
2335:         WITH loc_oPag1.lbl_4c_Label39
2336:             .Caption   = "Al" + CHR(237) + "quota do PIS :"
2337:             .Top       = 295
2338:             .Left      = 827
2339:             .Width     = 82
2340:             .Height    = 15
2341:             .FontName  = "Verdana"
2342:             .FontSize  = 8
2343:             .BackStyle = 0
2344:             .ForeColor = RGB(90, 90, 90)
2345:             .Visible   = .T.
2346:         ENDWITH
2347: 
2348:         *-- TextBox Aliquota do PIS (aliqpis, 999.99)
2349:         loc_oPag1.AddObject("txt_4c_AliqPIS", "TextBox")
2350:         WITH loc_oPag1.txt_4c_AliqPIS
2351:             .Top           = 291
2352:             .Left          = 916
2353:             .Width         = 52
2354:             .Height        = 23
2355:             .FontName      = "Tahoma"
2356:             .FontSize      = 8
2357:             .InputMask     = "999.99"
2358:             .SpecialEffect = 1
2359:             .ForeColor     = RGB(90, 90, 90)
2360:             .BorderColor   = RGB(100, 100, 100)
2361:             .Visible       = .T.
2362:         ENDWITH
2363: 
2364:         *-- Label % (PIS)
2365:         loc_oPag1.AddObject("lbl_4c_Label40", "Label")
2366:         WITH loc_oPag1.lbl_4c_Label40
2367:             .Caption   = "%"
2368:             .Top       = 295
2369:             .Left      = 971
2370:             .Width     = 14
2371:             .Height    = 15
2372:             .FontName  = "Verdana"
2373:             .FontSize  = 8
2374:             .BackStyle = 0
2375:             .ForeColor = RGB(224, 235, 235)
2376:             .Visible   = .T.
2377:         ENDWITH
2378: 
2379:         *-- Label Aliquota do COFINS
2380:         loc_oPag1.AddObject("lbl_4c_Label41", "Label")
2381:         WITH loc_oPag1.lbl_4c_Label41
2382:             .Caption   = "Al" + CHR(237) + "quota do COFINS :"
2383:             .Top       = 319
2384:             .Left      = 785
2385:             .Width     = 124
2386:             .Height    = 15
2387:             .FontName  = "Verdana"
2388:             .FontSize  = 8
2389:             .BackStyle = 0
2390:             .ForeColor = RGB(90, 90, 90)
2391:             .Visible   = .T.
2392:         ENDWITH
2393: 
2394:         *-- TextBox Aliquota do COFINS (aliqcofins, 999.99)
2395:         loc_oPag1.AddObject("txt_4c_AliqCofins", "TextBox")
2396:         WITH loc_oPag1.txt_4c_AliqCofins
2397:             .Top           = 315
2398:             .Left          = 916
2399:             .Width         = 52
2400:             .Height        = 23
2401:             .FontName      = "Tahoma"
2402:             .FontSize      = 8
2403:             .InputMask     = "999.99"
2404:             .SpecialEffect = 1
2405:             .ForeColor     = RGB(90, 90, 90)
2406:             .BorderColor   = RGB(100, 100, 100)
2407:             .Visible       = .T.
2408:         ENDWITH
2409: 
2410:         *-- Label % (COFINS)
2411:         loc_oPag1.AddObject("lbl_4c_Label42", "Label")
2412:         WITH loc_oPag1.lbl_4c_Label42
2413:             .Caption   = "%"
2414:             .Top       = 319
2415:             .Left      = 971
2416:             .Width     = 14
2417:             .Height    = 15
2418:             .FontName  = "Verdana"
2419:             .FontSize  = 8
2420:             .BackStyle = 0
2421:             .ForeColor = RGB(224, 235, 235)
2422:             .Visible   = .T.
2423:         ENDWITH
2424: 
2425:         *-- Label Aliquota do ISSQN
2426:         loc_oPag1.AddObject("lbl_4c_Label44", "Label")
2427:         WITH loc_oPag1.lbl_4c_Label44
2428:             .Caption   = "Al" + CHR(237) + "quota do ISSQN :"
2429:             .Top       = 343
2430:             .Left      = 792
2431:             .Width     = 117
2432:             .Height    = 15
2433:             .FontName  = "Verdana"
2434:             .FontSize  = 8
2435:             .BackStyle = 0
2436:             .ForeColor = RGB(90, 90, 90)
2437:             .Visible   = .T.
2438:         ENDWITH
2439: 
2440:         *-- TextBox Aliquota do ISSQN (aliqissqn, 999.99)
2441:         loc_oPag1.AddObject("txt_4c_AliqISSQN", "TextBox")
2442:         WITH loc_oPag1.txt_4c_AliqISSQN
2443:             .Top           = 339
2444:             .Left          = 916
2445:             .Width         = 52
2446:             .Height        = 23
2447:             .FontName      = "Tahoma"
2448:             .FontSize      = 8
2449:             .InputMask     = "999.99"
2450:             .SpecialEffect = 1
2451:             .ForeColor     = RGB(90, 90, 90)
2452:             .BorderColor   = RGB(100, 100, 100)
2453:             .Visible       = .T.
2454:         ENDWITH
2455: 
2456:         *-- Label % (ISSQN)
2457:         loc_oPag1.AddObject("lbl_4c_Label45", "Label")
2458:         WITH loc_oPag1.lbl_4c_Label45
2459:             .Caption   = "%"
2460:             .Top       = 343
2461:             .Left      = 971
2462:             .Width     = 14
2463:             .Height    = 15
2464:             .FontName  = "Verdana"
2465:             .FontSize  = 8
2466:             .BackStyle = 0
2467:             .ForeColor = RGB(224, 235, 235)
2468:             .Visible   = .T.
2469:         ENDWITH
2470: 
2471:         *-- Label Codigo de Tributacao do ISSQN
2472:         loc_oPag1.AddObject("lbl_4c_Label43", "Label")
2473:         WITH loc_oPag1.lbl_4c_Label43
2474:             .Caption   = "C" + CHR(243) + "digo de Trib. do ISSQN:"
2475:             .Top       = 390
2476:             .Left      = 561
2477:             .Width     = 128
2478:             .Height    = 15
2479:             .FontName  = "Tahoma"
2480:             .FontSize  = 8
2481:             .BackStyle = 0
2482:             .ForeColor = RGB(90, 90, 90)
2483:             .Visible   = .T.
2484:         ENDWITH
2485: 
2486:         *-- OptionGroup Codigo Tributacao ISSQN (ctissqn, 5 botoes: Normal/Retida/Substituta/Isenta/Nao Calcula)
2487:         loc_oPag1.AddObject("obj_4c_Fwoption1", "OptionGroup")
2488:         WITH loc_oPag1.obj_4c_Fwoption1
2489:             .Top         = 389
2490:             .Left        = 686
2491:             .Width       = 297
2492:             .Height      = 34
2493:             .ButtonCount = 5
2494:             .BorderStyle = 0
2495:             .Visible     = .T.
2496:         ENDWITH
2497:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(1)
2498:             .Caption   = "Normal"
2499:             .Left      = 4
2500:             .Top       = 0
2501:             .Height    = 15
2502:             .AutoSize  = .T.
2503:             .FontName  = "Verdana"
2504:             .FontSize  = 8
2505:             .ForeColor = RGB(90, 90, 90)
2506:         ENDWITH
2507:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(2)
2508:             .Caption   = "Retida"
2509:             .Left      = 72
2510:             .Top       = 0
2511:             .Height    = 15
2512:             .AutoSize  = .T.
2513:             .FontName  = "Verdana"
2514:             .FontSize  = 8
2515:             .ForeColor = RGB(90, 90, 90)
2516:         ENDWITH
2517:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(3)
2518:             .Caption   = "Substituta"
2519:             .Left      = 135
2520:             .Top       = 1
2521:             .Width     = 76
2522:             .Height    = 15
2523:             .AutoSize  = .T.
2524:             .FontName  = "Verdana"
2525:             .FontSize  = 8
2526:             .ForeColor = RGB(90, 90, 90)
2527:         ENDWITH
2528:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(4)
2529:             .Caption   = "Isenta"
2530:             .Left      = 219
2531:             .Top       = 1
2532:             .Width     = 52
2533:             .Height    = 17
2534:             .AutoSize  = .T.
2535:             .ForeColor = RGB(90, 90, 90)
2536:         ENDWITH
2537:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(5)
2538:             .Caption   = "N" + CHR(227) + "o Calcula ISSQN"
2539:             .Left      = 4
2540:             .Top       = 17
2541:             .Width     = 129
2542:             .Height    = 15
2543:             .AutoSize  = .T.
2544:             .FontName  = "Verdana"
2545:             .FontSize  = 8
2546:             .ForeColor = RGB(90, 90, 90)
2547:         ENDWITH
2548: 
2549:         *-- Label Informa Retencao de Tributacao
2550:         loc_oPag1.AddObject("lbl_4c_Label46", "Label")
2551:         WITH loc_oPag1.lbl_4c_Label46
2552:             .Caption   = "Informa Reten" + CHR(231) + CHR(227) + "o de Trib.:"
2553:             .Top       = 425
2554:             .Left      = 556
2555:             .Width     = 133
2556:             .Height    = 15
2557:             .FontName  = "Tahoma"
2558:             .FontSize  = 8
2559:             .BackStyle = 0
2560:             .ForeColor = RGB(90, 90, 90)
2561:             .Visible   = .T.
2562:         ENDWITH
2563: 
2564:         *-- OptionGroup Informa Retencao de Tributacao (rettribs, 2 botoes: Sim/Nao)
2565:         loc_oPag1.AddObject("obj_4c_Fwoption2", "OptionGroup")
2566:         WITH loc_oPag1.obj_4c_Fwoption2
2567:             .Top         = 420
2568:             .Left        = 686
2569:             .Width       = 95
2570:             .Height      = 25
2571:             .ButtonCount = 2
2572:             .BorderStyle = 0
2573:             .Visible     = .T.
2574:         ENDWITH
2575:         WITH loc_oPag1.obj_4c_Fwoption2.Buttons(1)
2576:             .Caption   = "Sim"
2577:             .Left      = 5
2578:             .Top       = 5
2579:             .Height    = 15
2580:             .AutoSize  = .T.
2581:             .FontName  = "Tahoma"
2582:             .FontSize  = 8
2583:             .ForeColor = RGB(90, 90, 90)
2584:         ENDWITH
2585:         WITH loc_oPag1.obj_4c_Fwoption2.Buttons(2)
2586:             .Caption   = "N" + CHR(227) + "o"
2587:             .Left      = 53
2588:             .Top       = 5
2589:             .Height    = 15
2590:             .AutoSize  = .T.
2591:             .FontName  = "Tahoma"
2592:             .FontSize  = 8
2593:             .ForeColor = RGB(90, 90, 90)
2594:         ENDWITH
2595: 
2596:         *-- Label Aliquota do II
2597:         loc_oPag1.AddObject("lbl_4c_Label47", "Label")
2598:         WITH loc_oPag1.lbl_4c_Label47
2599:             .Caption   = "Al" + CHR(237) + "quota do II :"
2600:             .Top       = 425
2601:             .Left      = 820
2602:             .Width     = 89
2603:             .Height    = 15
2604:             .FontName  = "Verdana"
2605:             .FontSize  = 8
2606:             .BackStyle = 0
2607:             .ForeColor = RGB(90, 90, 90)
2608:             .Visible   = .T.
2609:         ENDWITH
2610: 
2611:         *-- TextBox Aliquota do II (aliqii, 999.99)
2612:         loc_oPag1.AddObject("txt_4c_AliqII", "TextBox")
2613:         WITH loc_oPag1.txt_4c_AliqII
2614:             .Top           = 421
2615:             .Left          = 916
2616:             .Width         = 52
2617:             .Height        = 23
2618:             .FontName      = "Tahoma"
2619:             .FontSize      = 8
2620:             .InputMask     = "999.99"
2621:             .SpecialEffect = 1
2622:             .ForeColor     = RGB(90, 90, 90)
2623:             .BorderColor   = RGB(100, 100, 100)
2624:             .Visible       = .T.
2625:         ENDWITH
2626: 
2627:         *-- Label % (II)
2628:         loc_oPag1.AddObject("lbl_4c_Label48", "Label")
2629:         WITH loc_oPag1.lbl_4c_Label48
2630:             .Caption   = "%"
2631:             .Top       = 420
2632:             .Left      = 971
2633:             .Width     = 14
2634:             .Height    = 15
2635:             .FontName  = "Verdana"
2636:             .FontSize  = 8
2637:             .BackStyle = 0

*-- Linhas 2655 a 2727:
2655:         *----------------------------------------------------------------------
2656: 
2657:         *-- Label cabecalho secao Integracao Contabil
2658:         loc_oPag2.AddObject("lbl_4c_LblIntCont", "Label")
2659:         WITH loc_oPag2.lbl_4c_LblIntCont
2660:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
2661:             .Top       = 6
2662:             .Left      = 15
2663:             .Width     = 114
2664:             .Height    = 15
2665:             .FontName  = "Tahoma"
2666:             .FontSize  = 8
2667:             .FontBold  = .T.
2668:             .BackStyle = 0
2669:             .ForeColor = RGB(90, 90, 90)
2670:             .Visible   = .T.
2671:         ENDWITH
2672: 
2673:         *-- Label Valor Contabil
2674:         loc_oPag2.AddObject("lbl_4c_LblValorCont", "Label")
2675:         WITH loc_oPag2.lbl_4c_LblValorCont
2676:             .Caption   = "Valor Cont" + CHR(225) + "bil :"
2677:             .Top       = 34
2678:             .Left      = 84
2679:             .Width     = 75
2680:             .Height    = 15
2681:             .FontName  = "Tahoma"
2682:             .FontSize  = 8
2683:             .BackStyle = 0
2684:             .ForeColor = RGB(90, 90, 90)
2685:             .Visible   = .T.
2686:         ENDWITH
2687: 
2688:         *-- Label DB (Valor Contabil)
2689:         loc_oPag2.AddObject("lbl_4c_LblVcDB", "Label")
2690:         WITH loc_oPag2.lbl_4c_LblVcDB
2691:             .Caption   = "DB"
2692:             .Top       = 34
2693:             .Left      = 247
2694:             .Width     = 15
2695:             .Height    = 15
2696:             .FontName  = "Tahoma"
2697:             .FontSize  = 8
2698:             .BackStyle = 0
2699:             .ForeColor = RGB(90, 90, 90)
2700:             .Visible   = .T.
2701:         ENDWITH
2702: 
2703:         *-- Label CR (Valor Contabil)
2704:         loc_oPag2.AddObject("lbl_4c_LblVcCR", "Label")
2705:         WITH loc_oPag2.lbl_4c_LblVcCR
2706:             .Caption   = "CR"
2707:             .Top       = 34
2708:             .Left      = 344
2709:             .Width     = 16
2710:             .Height    = 15
2711:             .FontName  = "Tahoma"
2712:             .FontSize  = 8
2713:             .BackStyle = 0
2714:             .ForeColor = RGB(90, 90, 90)
2715:             .Visible   = .T.
2716:         ENDWITH
2717: 
2718:         *-- TextBox Valor Contabil DB (contvcds)
2719:         loc_oPag2.AddObject("txt_4c_Vrcds", "TextBox")
2720:         WITH loc_oPag2.txt_4c_Vrcds
2721:             .Top           = 30
2722:             .Left          = 162
2723:             .Width         = 73
2724:             .Height        = 24
2725:             .FontName      = "Tahoma"
2726:             .FontSize      = 8
2727:             .MaxLength     = 9

*-- Linhas 2734 a 2804:
2734:         *-- TextBox Valor Contabil CR (contvccs)
2735:         loc_oPag2.AddObject("txt_4c_Vrccs", "TextBox")
2736:         WITH loc_oPag2.txt_4c_Vrccs
2737:             .Top           = 30
2738:             .Left          = 265
2739:             .Width         = 73
2740:             .Height        = 24
2741:             .FontName      = "Tahoma"
2742:             .FontSize      = 8
2743:             .MaxLength     = 9
2744:             .SpecialEffect = 1
2745:             .ForeColor     = RGB(90, 90, 90)
2746:             .BorderColor   = RGB(100, 100, 100)
2747:             .Visible       = .T.
2748:         ENDWITH
2749: 
2750:         *-- Label IPI
2751:         loc_oPag2.AddObject("lbl_4c_LblIPI", "Label")
2752:         WITH loc_oPag2.lbl_4c_LblIPI
2753:             .Caption   = "IPI :"
2754:             .Top       = 60
2755:             .Left      = 136
2756:             .Width     = 23
2757:             .Height    = 15
2758:             .FontName  = "Tahoma"
2759:             .FontSize  = 8
2760:             .BackStyle = 0
2761:             .ForeColor = RGB(90, 90, 90)
2762:             .Visible   = .T.
2763:         ENDWITH
2764: 
2765:         *-- Label DB (IPI)
2766:         loc_oPag2.AddObject("lbl_4c_LblIpiDB", "Label")
2767:         WITH loc_oPag2.lbl_4c_LblIpiDB
2768:             .Caption   = "DB"
2769:             .Top       = 60
2770:             .Left      = 247
2771:             .Width     = 15
2772:             .Height    = 15
2773:             .FontName  = "Tahoma"
2774:             .FontSize  = 8
2775:             .BackStyle = 0
2776:             .ForeColor = RGB(90, 90, 90)
2777:             .Visible   = .T.
2778:         ENDWITH
2779: 
2780:         *-- Label CR (IPI)
2781:         loc_oPag2.AddObject("lbl_4c_LblIpiCR", "Label")
2782:         WITH loc_oPag2.lbl_4c_LblIpiCR
2783:             .Caption   = "CR"
2784:             .Top       = 60
2785:             .Left      = 344
2786:             .Width     = 16
2787:             .Height    = 15
2788:             .FontName  = "Tahoma"
2789:             .FontSize  = 8
2790:             .BackStyle = 0
2791:             .ForeColor = RGB(90, 90, 90)
2792:             .Visible   = .T.
2793:         ENDWITH
2794: 
2795:         *-- TextBox IPI DB (contipds)
2796:         loc_oPag2.AddObject("txt_4c_Ipids", "TextBox")
2797:         WITH loc_oPag2.txt_4c_Ipids
2798:             .Top           = 56
2799:             .Left          = 162
2800:             .Width         = 73
2801:             .Height        = 24
2802:             .FontName      = "Tahoma"
2803:             .FontSize      = 8
2804:             .MaxLength     = 9

*-- Linhas 2811 a 2881:
2811:         *-- TextBox IPI CR (contipcs)
2812:         loc_oPag2.AddObject("txt_4c_Ipics", "TextBox")
2813:         WITH loc_oPag2.txt_4c_Ipics
2814:             .Top           = 56
2815:             .Left          = 265
2816:             .Width         = 73
2817:             .Height        = 24
2818:             .FontName      = "Tahoma"
2819:             .FontSize      = 8
2820:             .MaxLength     = 9
2821:             .SpecialEffect = 1
2822:             .ForeColor     = RGB(90, 90, 90)
2823:             .BorderColor   = RGB(100, 100, 100)
2824:             .Visible       = .T.
2825:         ENDWITH
2826: 
2827:         *-- Label ICMS
2828:         loc_oPag2.AddObject("lbl_4c_LblICMS", "Label")
2829:         WITH loc_oPag2.lbl_4c_LblICMS
2830:             .Caption   = "ICMS :"
2831:             .Top       = 86
2832:             .Left      = 125
2833:             .Width     = 34
2834:             .Height    = 15
2835:             .FontName  = "Tahoma"
2836:             .FontSize  = 8
2837:             .BackStyle = 0
2838:             .ForeColor = RGB(90, 90, 90)
2839:             .Visible   = .T.
2840:         ENDWITH
2841: 
2842:         *-- Label DB (ICMS)
2843:         loc_oPag2.AddObject("lbl_4c_LblIcmDB", "Label")
2844:         WITH loc_oPag2.lbl_4c_LblIcmDB
2845:             .Caption   = "DB"
2846:             .Top       = 86
2847:             .Left      = 247
2848:             .Width     = 15
2849:             .Height    = 15
2850:             .FontName  = "Tahoma"
2851:             .FontSize  = 8
2852:             .BackStyle = 0
2853:             .ForeColor = RGB(90, 90, 90)
2854:             .Visible   = .T.
2855:         ENDWITH
2856: 
2857:         *-- Label CR (ICMS)
2858:         loc_oPag2.AddObject("lbl_4c_LblIcmCR", "Label")
2859:         WITH loc_oPag2.lbl_4c_LblIcmCR
2860:             .Caption   = "CR"
2861:             .Top       = 86
2862:             .Left      = 344
2863:             .Width     = 16
2864:             .Height    = 15
2865:             .FontName  = "Tahoma"
2866:             .FontSize  = 8
2867:             .BackStyle = 0
2868:             .ForeColor = RGB(90, 90, 90)
2869:             .Visible   = .T.
2870:         ENDWITH
2871: 
2872:         *-- TextBox ICMS DB (conticds)
2873:         loc_oPag2.AddObject("txt_4c_Icmds", "TextBox")
2874:         WITH loc_oPag2.txt_4c_Icmds
2875:             .Top           = 82
2876:             .Left          = 162
2877:             .Width         = 73
2878:             .Height        = 24
2879:             .FontName      = "Tahoma"
2880:             .FontSize      = 8
2881:             .MaxLength     = 9

*-- Linhas 2888 a 2990:
2888:         *-- TextBox ICMS CR (conticcs)
2889:         loc_oPag2.AddObject("txt_4c_Icmcs", "TextBox")
2890:         WITH loc_oPag2.txt_4c_Icmcs
2891:             .Top           = 82
2892:             .Left          = 265
2893:             .Width         = 73
2894:             .Height        = 24
2895:             .FontName      = "Tahoma"
2896:             .FontSize      = 8
2897:             .MaxLength     = 9
2898:             .SpecialEffect = 1
2899:             .ForeColor     = RGB(90, 90, 90)
2900:             .BorderColor   = RGB(100, 100, 100)
2901:             .Visible       = .T.
2902:         ENDWITH
2903: 
2904:         *-- Label Conta de Frete
2905:         loc_oPag2.AddObject("lbl_4c_LblContFrt", "Label")
2906:         WITH loc_oPag2.lbl_4c_LblContFrt
2907:             .Caption   = "Conta de Frete :"
2908:             .Top       = 112
2909:             .Left      = 77
2910:             .Width     = 82
2911:             .Height    = 15
2912:             .FontName  = "Tahoma"
2913:             .FontSize  = 8
2914:             .BackStyle = 0
2915:             .ForeColor = RGB(90, 90, 90)
2916:             .Visible   = .T.
2917:         ENDWITH
2918: 
2919:         *-- TextBox Conta de Frete (contfrt)
2920:         loc_oPag2.AddObject("txt_4c_ContFrt", "TextBox")
2921:         WITH loc_oPag2.txt_4c_ContFrt
2922:             .Top           = 108
2923:             .Left          = 162
2924:             .Width         = 73
2925:             .Height        = 24
2926:             .FontName      = "Tahoma"
2927:             .FontSize      = 8
2928:             .MaxLength     = 9
2929:             .SpecialEffect = 1
2930:             .ForeColor     = RGB(90, 90, 90)
2931:             .BorderColor   = RGB(100, 100, 100)
2932:             .Visible       = .T.
2933:         ENDWITH
2934: 
2935:         *-- Label Conta de Seguro
2936:         loc_oPag2.AddObject("lbl_4c_LblContSeg", "Label")
2937:         WITH loc_oPag2.lbl_4c_LblContSeg
2938:             .Caption   = "Conta de Seguro :"
2939:             .Top       = 138
2940:             .Left      = 69
2941:             .Width     = 90
2942:             .Height    = 15
2943:             .FontName  = "Tahoma"
2944:             .FontSize  = 8
2945:             .BackStyle = 0
2946:             .ForeColor = RGB(90, 90, 90)
2947:             .Visible   = .T.
2948:         ENDWITH
2949: 
2950:         *-- TextBox Conta de Seguro (contseg)
2951:         loc_oPag2.AddObject("txt_4c_ContSeg", "TextBox")
2952:         WITH loc_oPag2.txt_4c_ContSeg
2953:             .Top           = 134
2954:             .Left          = 162
2955:             .Width         = 73
2956:             .Height        = 24
2957:             .FontName      = "Tahoma"
2958:             .FontSize      = 8
2959:             .MaxLength     = 9
2960:             .SpecialEffect = 1
2961:             .ForeColor     = RGB(90, 90, 90)
2962:             .BorderColor   = RGB(100, 100, 100)
2963:             .Visible       = .T.
2964:         ENDWITH
2965: 
2966:         *-- Label Conta de Despesas
2967:         loc_oPag2.AddObject("lbl_4c_LblContDa", "Label")
2968:         WITH loc_oPag2.lbl_4c_LblContDa
2969:             .Caption   = "Conta de Despesas :"
2970:             .Top       = 164
2971:             .Left      = 57
2972:             .Width     = 102
2973:             .Height    = 15
2974:             .FontName  = "Tahoma"
2975:             .FontSize  = 8
2976:             .BackStyle = 0
2977:             .ForeColor = RGB(90, 90, 90)
2978:             .Visible   = .T.
2979:         ENDWITH
2980: 
2981:         *-- TextBox Conta de Despesas (contda)
2982:         loc_oPag2.AddObject("txt_4c_ContDa", "TextBox")
2983:         WITH loc_oPag2.txt_4c_ContDa
2984:             .Top           = 160
2985:             .Left          = 162
2986:             .Width         = 73
2987:             .Height        = 24
2988:             .FontName      = "Tahoma"
2989:             .FontSize      = 8
2990:             .MaxLength     = 9

*-- Linhas 2999 a 3025:
2999:         *----------------------------------------------------------------------
3000: 
3001:         *-- Label Descricao na Integracao
3002:         loc_oPag2.AddObject("lbl_4c_LblDescInteg", "Label")
3003:         WITH loc_oPag2.lbl_4c_LblDescInteg
3004:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o :"
3005:             .Top       = 31
3006:             .Left      = 490
3007:             .Width     = 151
3008:             .Height    = 15
3009:             .FontName  = "Tahoma"
3010:             .FontSize  = 8
3011:             .BackStyle = 0
3012:             .ForeColor = RGB(90, 90, 90)
3013:             .Visible   = .T.
3014:         ENDWITH
3015: 
3016:         *-- Combo Descricao na Integracao (pontedescs)
3017:         loc_oPag2.AddObject("cbo_4c_Combo2", "ComboBox")
3018:         WITH loc_oPag2.cbo_4c_Combo2
3019:             .Top           = 315
3020:             .Left          = 380
3021:             .Width         = 199
3022:             .Height        = 25
3023:             .FontName      = "Tahoma"
3024:             .FontSize      = 8
3025:             .RowSourceType = 1

*-- Linhas 3032 a 3058:
3032:         ENDWITH
3033: 
3034:         *-- Label Pega Conta Contabil da NF
3035:         loc_oPag2.AddObject("lbl_4c_LblCmbFixa", "Label")
3036:         WITH loc_oPag2.lbl_4c_LblCmbFixa
3037:             .Caption   = "Pega Conta Cont" + CHR(225) + "bil da NF :"
3038:             .Top       = 57
3039:             .Left      = 642
3040:             .Width     = 164
3041:             .Height    = 15
3042:             .FontName  = "Tahoma"
3043:             .FontSize  = 8
3044:             .BackStyle = 0
3045:             .ForeColor = RGB(90, 90, 90)
3046:             .Visible   = .T.
3047:         ENDWITH
3048: 
3049:         *-- Combo Pega Conta Contabil da NF (contconts: S=Sim(NF), N=Nao(CFOP), C=C.C.)
3050:         loc_oPag2.AddObject("cbo_4c_CmbFixa", "ComboBox")
3051:         WITH loc_oPag2.cbo_4c_CmbFixa
3052:             .Top           = 53
3053:             .Left          = 642
3054:             .Width         = 132
3055:             .Height        = 25
3056:             .FontName      = "Tahoma"
3057:             .FontSize      = 8
3058:             .RowSourceType = 1

*-- Linhas 3065 a 3077:
3065:         ENDWITH
3066: 
3067:         *-- Label Agrupa CFO na Integracao
3068:         loc_oPag2.AddObject("lbl_4c_LblAgrupas", "Label")
3069:         WITH loc_oPag2.lbl_4c_LblAgrupas
3070:             .Caption   = "Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o :"
3071:             .Top       = 84
3072:             .Left      = 477
3073:             .Width     = 164
3074:             .Height    = 15
3075:             .FontName  = "Tahoma"
3076:             .FontSize  = 8
3077:             .BackStyle = 0

*-- Linhas 3083 a 3128:
3083:         loc_oPag2.AddObject("obj_4c_OptAgrupas", "OptionGroup")
3084:         WITH loc_oPag2.obj_4c_OptAgrupas
3085:             .ButtonCount = 2
3086:             .Top         = 79
3087:             .Left        = 638
3088:             .Width       = 94
3089:             .Height      = 27
3090:             .BorderStyle = 0
3091:             .Visible     = .T.
3092:         ENDWITH
3093:         WITH loc_oPag2.obj_4c_OptAgrupas.Buttons(1)
3094:             .Caption   = "Sim"
3095:             .Left      = 5
3096:             .Top       = 5
3097:             .Width     = 40
3098:             .Height    = 17
3099:             .AutoSize  = .F.
3100:             .FontName  = "Tahoma"
3101:             .FontSize  = 8
3102:             .ForeColor = RGB(90, 90, 90)
3103:             .Themes    = .F.
3104:         ENDWITH
3105:         WITH loc_oPag2.obj_4c_OptAgrupas.Buttons(2)
3106:             .Caption   = "N" + CHR(227) + "o"
3107:             .Left      = 51
3108:             .Top       = 5
3109:             .Width     = 40
3110:             .Height    = 17
3111:             .AutoSize  = .F.
3112:             .FontName  = "Tahoma"
3113:             .FontSize  = 8
3114:             .ForeColor = RGB(90, 90, 90)
3115:             .Themes    = .F.
3116:         ENDWITH
3117: 
3118:         *-- Label Integracao Zerada
3119:         loc_oPag2.AddObject("lbl_4c_LblZeradas", "Label")
3120:         WITH loc_oPag2.lbl_4c_LblZeradas
3121:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
3122:             .Top       = 108
3123:             .Left      = 523
3124:             .Width     = 118
3125:             .Height    = 15
3126:             .FontName  = "Tahoma"
3127:             .FontSize  = 8
3128:             .BackStyle = 0

*-- Linhas 3134 a 3179:
3134:         loc_oPag2.AddObject("obj_4c_OptZeradas", "OptionGroup")
3135:         WITH loc_oPag2.obj_4c_OptZeradas
3136:             .ButtonCount = 2
3137:             .Top         = 103
3138:             .Left        = 638
3139:             .Width       = 94
3140:             .Height      = 27
3141:             .BorderStyle = 0
3142:             .Visible     = .T.
3143:         ENDWITH
3144:         WITH loc_oPag2.obj_4c_OptZeradas.Buttons(1)
3145:             .Caption   = "Sim"
3146:             .Left      = 5
3147:             .Top       = 5
3148:             .Width     = 40
3149:             .Height    = 17
3150:             .AutoSize  = .F.
3151:             .FontName  = "Tahoma"
3152:             .FontSize  = 8
3153:             .ForeColor = RGB(90, 90, 90)
3154:             .Themes    = .F.
3155:         ENDWITH
3156:         WITH loc_oPag2.obj_4c_OptZeradas.Buttons(2)
3157:             .Caption   = "N" + CHR(227) + "o"
3158:             .Left      = 51
3159:             .Top       = 5
3160:             .Width     = 40
3161:             .Height    = 17
3162:             .AutoSize  = .F.
3163:             .FontName  = "Tahoma"
3164:             .FontSize  = 8
3165:             .ForeColor = RGB(90, 90, 90)
3166:             .Themes    = .F.
3167:         ENDWITH
3168: 
3169:         *-- Label Data Lancamento Contabil
3170:         loc_oPag2.AddObject("lbl_4c_LblDtLanc", "Label")
3171:         WITH loc_oPag2.lbl_4c_LblDtLanc
3172:             .Caption   = "Data Lan" + CHR(231) + "amento Contabil :"
3173:             .Top       = 132
3174:             .Left      = 479
3175:             .Width     = 162
3176:             .Height    = 15
3177:             .FontName  = "Tahoma"
3178:             .FontSize  = 8
3179:             .BackStyle = 0

*-- Linhas 3185 a 3230:
3185:         loc_oPag2.AddObject("obj_4c_Fwoption1", "OptionGroup")
3186:         WITH loc_oPag2.obj_4c_Fwoption1
3187:             .ButtonCount = 2
3188:             .Top         = 389
3189:             .Left        = 686
3190:             .Width       = 192
3191:             .Height      = 27
3192:             .BorderStyle = 0
3193:             .Visible     = .T.
3194:         ENDWITH
3195:         WITH loc_oPag2.obj_4c_Fwoption1.Buttons(1)
3196:             .Caption   = "Data Integra" + CHR(231) + CHR(227) + "o"
3197:             .Left      = 5
3198:             .Top       = 5
3199:             .Width     = 97
3200:             .Height    = 15
3201:             .AutoSize  = .F.
3202:             .FontName  = "Tahoma"
3203:             .FontSize  = 8
3204:             .ForeColor = RGB(90, 90, 90)
3205:             .Themes    = .F.
3206:         ENDWITH
3207:         WITH loc_oPag2.obj_4c_Fwoption1.Buttons(2)
3208:             .Caption   = "Data N.F."
3209:             .Left      = 122
3210:             .Top       = 7
3211:             .Width     = 65
3212:             .Height    = 15
3213:             .AutoSize  = .F.
3214:             .FontName  = "Tahoma"
3215:             .FontSize  = 8
3216:             .ForeColor = RGB(90, 90, 90)
3217:             .Themes    = .F.
3218:         ENDWITH
3219: 
3220:         *-- Label Utilizar variacao de CFOP na Integracao
3221:         loc_oPag2.AddObject("lbl_4c_LblUtilvars", "Label")
3222:         WITH loc_oPag2.lbl_4c_LblUtilvars
3223:             .Caption   = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
3224:             .Top       = 156
3225:             .Left      = 390
3226:             .Width     = 251
3227:             .Height    = 15
3228:             .FontName  = "Tahoma"
3229:             .FontSize  = 8
3230:             .BackStyle = 0

*-- Linhas 3236 a 3266:
3236:         loc_oPag2.AddObject("obj_4c_Optutilvars", "OptionGroup")
3237:         WITH loc_oPag2.obj_4c_Optutilvars
3238:             .ButtonCount = 2
3239:             .Top         = 150
3240:             .Left        = 638
3241:             .Width       = 94
3242:             .Height      = 27
3243:             .BorderStyle = 0
3244:             .Visible     = .T.
3245:         ENDWITH
3246:         WITH loc_oPag2.obj_4c_Optutilvars.Buttons(1)
3247:             .Caption   = "Sim"
3248:             .Left      = 5
3249:             .Top       = 5
3250:             .Width     = 40
3251:             .Height    = 17
3252:             .AutoSize  = .F.
3253:             .FontName  = "Tahoma"
3254:             .FontSize  = 8
3255:             .ForeColor = RGB(90, 90, 90)
3256:             .Themes    = .F.
3257:         ENDWITH
3258:         WITH loc_oPag2.obj_4c_Optutilvars.Buttons(2)
3259:             .Caption   = "N" + CHR(227) + "o"
3260:             .Left      = 51
3261:             .Top       = 5
3262:             .Width     = 40
3263:             .Height    = 17
3264:             .AutoSize  = .F.
3265:             .FontName  = "Tahoma"
3266:             .FontSize  = 8

*-- Linhas 3275 a 3314:
3275:         *-- Linha separadora horizontal
3276:         loc_oPag2.AddObject("shp_4c_Sep", "Shape")
3277:         WITH loc_oPag2.shp_4c_Sep
3278:             .Top           = 211
3279:             .Left          = 5
3280:             .Width         = 984
3281:             .Height        = 1
3282:             .BackStyle     = 0
3283:             .BorderWidth   = 1
3284:             .SpecialEffect = 1
3285:             .Visible       = .T.
3286:         ENDWITH
3287: 
3288:         *-- Label cabecalho secao Integracao Fiscal
3289:         loc_oPag2.AddObject("lbl_4c_LblIntFisc", "Label")
3290:         WITH loc_oPag2.lbl_4c_LblIntFisc
3291:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Fiscal"
3292:             .Top       = 217
3293:             .Left      = 18
3294:             .Width     = 99
3295:             .Height    = 15
3296:             .FontName  = "Tahoma"
3297:             .FontSize  = 8
3298:             .FontBold  = .T.
3299:             .BackStyle = 0
3300:             .ForeColor = RGB(90, 90, 90)
3301:             .Visible   = .T.
3302:         ENDWITH
3303: 
3304:         *-- Label Integrar Valor Contabil
3305:         loc_oPag2.AddObject("lbl_4c_LblIntvlrcont", "Label")
3306:         WITH loc_oPag2.lbl_4c_LblIntvlrcont
3307:             .Caption   = "Integrar Valor Cont" + CHR(225) + "bil :"
3308:             .Top       = 239
3309:             .Left      = 115
3310:             .Width     = 118
3311:             .Height    = 15
3312:             .FontName  = "Tahoma"
3313:             .FontSize  = 8
3314:             .BackStyle = 0

*-- Linhas 3320 a 3365:
3320:         loc_oPag2.AddObject("obj_4c_Fwoption2", "OptionGroup")
3321:         WITH loc_oPag2.obj_4c_Fwoption2
3322:             .ButtonCount = 2
3323:             .Top         = 420
3324:             .Left        = 686
3325:             .Width       = 94
3326:             .Height      = 27
3327:             .BorderStyle = 0
3328:             .Visible     = .T.
3329:         ENDWITH
3330:         WITH loc_oPag2.obj_4c_Fwoption2.Buttons(1)
3331:             .Caption   = "Sim"
3332:             .Left      = 5
3333:             .Top       = 5
3334:             .Width     = 40
3335:             .Height    = 17
3336:             .AutoSize  = .F.
3337:             .FontName  = "Tahoma"
3338:             .FontSize  = 8
3339:             .ForeColor = RGB(90, 90, 90)
3340:             .Themes    = .F.
3341:         ENDWITH
3342:         WITH loc_oPag2.obj_4c_Fwoption2.Buttons(2)
3343:             .Caption   = "N" + CHR(227) + "o"
3344:             .Left      = 51
3345:             .Top       = 5
3346:             .Width     = 40
3347:             .Height    = 17
3348:             .AutoSize  = .F.
3349:             .FontName  = "Tahoma"
3350:             .FontSize  = 8
3351:             .ForeColor = RGB(90, 90, 90)
3352:             .Themes    = .F.
3353:         ENDWITH
3354: 
3355:         *-- Label Integrar Valores Icms
3356:         loc_oPag2.AddObject("lbl_4c_LblIntvlricms", "Label")
3357:         WITH loc_oPag2.lbl_4c_LblIntvlricms
3358:             .Caption   = "Integrar Valores Icms :"
3359:             .Top       = 259
3360:             .Left      = 121
3361:             .Width     = 112
3362:             .Height    = 15
3363:             .FontName  = "Tahoma"
3364:             .FontSize  = 8
3365:             .BackStyle = 0

*-- Linhas 3371 a 3416:
3371:         loc_oPag2.AddObject("obj_4c_Fwoption3", "OptionGroup")
3372:         WITH loc_oPag2.obj_4c_Fwoption3
3373:             .ButtonCount = 2
3374:             .Top         = 253
3375:             .Left        = 231
3376:             .Width       = 94
3377:             .Height      = 27
3378:             .BorderStyle = 0
3379:             .Visible     = .T.
3380:         ENDWITH
3381:         WITH loc_oPag2.obj_4c_Fwoption3.Buttons(1)
3382:             .Caption   = "Sim"
3383:             .Left      = 5
3384:             .Top       = 5
3385:             .Width     = 40
3386:             .Height    = 17
3387:             .AutoSize  = .F.
3388:             .FontName  = "Tahoma"
3389:             .FontSize  = 8
3390:             .ForeColor = RGB(90, 90, 90)
3391:             .Themes    = .F.
3392:         ENDWITH
3393:         WITH loc_oPag2.obj_4c_Fwoption3.Buttons(2)
3394:             .Caption   = "N" + CHR(227) + "o"
3395:             .Left      = 51
3396:             .Top       = 5
3397:             .Width     = 40
3398:             .Height    = 17
3399:             .AutoSize  = .F.
3400:             .FontName  = "Tahoma"
3401:             .FontSize  = 8
3402:             .ForeColor = RGB(90, 90, 90)
3403:             .Themes    = .F.
3404:         ENDWITH
3405: 
3406:         *-- Label Integrar Valores Ipi
3407:         loc_oPag2.AddObject("lbl_4c_LblIntvlripi", "Label")
3408:         WITH loc_oPag2.lbl_4c_LblIntvlripi
3409:             .Caption   = "Integrar Valores Ipi :"
3410:             .Top       = 278
3411:             .Left      = 131
3412:             .Width     = 102
3413:             .Height    = 15
3414:             .FontName  = "Tahoma"
3415:             .FontSize  = 8
3416:             .BackStyle = 0

*-- Linhas 3422 a 3467:
3422:         loc_oPag2.AddObject("obj_4c_Fwoption4", "OptionGroup")
3423:         WITH loc_oPag2.obj_4c_Fwoption4
3424:             .ButtonCount = 2
3425:             .Top         = 272
3426:             .Left        = 231
3427:             .Width       = 94
3428:             .Height      = 27
3429:             .BorderStyle = 0
3430:             .Visible     = .T.
3431:         ENDWITH
3432:         WITH loc_oPag2.obj_4c_Fwoption4.Buttons(1)
3433:             .Caption   = "Sim"
3434:             .Left      = 5
3435:             .Top       = 5
3436:             .Width     = 40
3437:             .Height    = 17
3438:             .AutoSize  = .F.
3439:             .FontName  = "Tahoma"
3440:             .FontSize  = 8
3441:             .ForeColor = RGB(90, 90, 90)
3442:             .Themes    = .F.
3443:         ENDWITH
3444:         WITH loc_oPag2.obj_4c_Fwoption4.Buttons(2)
3445:             .Caption   = "N" + CHR(227) + "o"
3446:             .Left      = 51
3447:             .Top       = 5
3448:             .Width     = 40
3449:             .Height    = 17
3450:             .AutoSize  = .F.
3451:             .FontName  = "Tahoma"
3452:             .FontSize  = 8
3453:             .ForeColor = RGB(90, 90, 90)
3454:             .Themes    = .F.
3455:         ENDWITH
3456: 
3457:         *-- Label Movimentacao Fisica de Estoque
3458:         loc_oPag2.AddObject("lbl_4c_LblIndmov", "Label")
3459:         WITH loc_oPag2.lbl_4c_LblIndmov
3460:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
3461:             .Top       = 298
3462:             .Left      = 69
3463:             .Width     = 164
3464:             .Height    = 15
3465:             .FontName  = "Tahoma"
3466:             .FontSize  = 8
3467:             .BackStyle = 0

*-- Linhas 3473 a 3518:
3473:         loc_oPag2.AddObject("obj_4c_Fwoption5", "OptionGroup")
3474:         WITH loc_oPag2.obj_4c_Fwoption5
3475:             .ButtonCount = 2
3476:             .Top         = 292
3477:             .Left        = 231
3478:             .Width       = 94
3479:             .Height      = 27
3480:             .BorderStyle = 0
3481:             .Visible     = .T.
3482:         ENDWITH
3483:         WITH loc_oPag2.obj_4c_Fwoption5.Buttons(1)
3484:             .Caption   = "Sim"
3485:             .Left      = 5
3486:             .Top       = 5
3487:             .Width     = 40
3488:             .Height    = 17
3489:             .AutoSize  = .F.
3490:             .FontName  = "Tahoma"
3491:             .FontSize  = 8
3492:             .ForeColor = RGB(90, 90, 90)
3493:             .Themes    = .F.
3494:         ENDWITH
3495:         WITH loc_oPag2.obj_4c_Fwoption5.Buttons(2)
3496:             .Caption   = "N" + CHR(227) + "o"
3497:             .Left      = 51
3498:             .Top       = 5
3499:             .Width     = 40
3500:             .Height    = 17
3501:             .AutoSize  = .F.
3502:             .FontName  = "Tahoma"
3503:             .FontSize  = 8
3504:             .ForeColor = RGB(90, 90, 90)
3505:             .Themes    = .F.
3506:         ENDWITH
3507: 
3508:         *-- Label Indicacao de Pagamento
3509:         loc_oPag2.AddObject("lbl_4c_LblIndpagto", "Label")
3510:         WITH loc_oPag2.lbl_4c_LblIndpagto
3511:             .Caption   = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
3512:             .Top       = 318
3513:             .Left      = 106
3514:             .Width     = 127
3515:             .Height    = 15
3516:             .FontName  = "Tahoma"
3517:             .FontSize  = 8
3518:             .BackStyle = 0

*-- Linhas 3524 a 3554:
3524:         loc_oPag2.AddObject("obj_4c_Fwoption6", "OptionGroup")
3525:         WITH loc_oPag2.obj_4c_Fwoption6
3526:             .ButtonCount = 2
3527:             .Top         = 312
3528:             .Left        = 231
3529:             .Width       = 94
3530:             .Height      = 27
3531:             .BorderStyle = 0
3532:             .Visible     = .T.
3533:         ENDWITH
3534:         WITH loc_oPag2.obj_4c_Fwoption6.Buttons(1)
3535:             .Caption   = "Sim"
3536:             .Left      = 5
3537:             .Top       = 5
3538:             .Width     = 40
3539:             .Height    = 17
3540:             .AutoSize  = .F.
3541:             .FontName  = "Tahoma"
3542:             .FontSize  = 8
3543:             .ForeColor = RGB(90, 90, 90)
3544:             .Themes    = .F.
3545:         ENDWITH
3546:         WITH loc_oPag2.obj_4c_Fwoption6.Buttons(2)
3547:             .Caption   = "N" + CHR(227) + "o"
3548:             .Left      = 51
3549:             .Top       = 5
3550:             .Width     = 40
3551:             .Height    = 17
3552:             .AutoSize  = .F.
3553:             .FontName  = "Tahoma"
3554:             .FontSize  = 8

*-- Linhas 3929 a 3938:
3929:             loc_oBO.this_nFrticms    = IIF(loc_oPag1.chk_4c_ObjFreteICM.Value, 1, 0)
3930:             loc_oBO.this_nSegicms    = IIF(loc_oPag1.chk_4c_ObjSegIcm.Value, 1, 0)
3931:             loc_oBO.this_nDesicms    = IIF(loc_oPag1.chk_4c_ObjDespIcm.Value, 1, 0)
3932:             loc_oBO.this_nIncicmnfs  = IIF(loc_oPag1.chk_4c_Fwcheckbox1.Value, 1, 0)
3933:             loc_oBO.this_nSomaicmfrete = IIF(loc_oPag1.chk_4c_Fwcheckbox2.Value, 1, 0)
3934:             loc_oBO.this_cSubtribs   = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbSTRIB.Value, ""))), 1)
3935:             loc_oBO.this_nPbcsts     = VAL(NVL(loc_oPag1.txt_4c_Bcst.Value, "0"))
3936:             loc_oBO.this_nTransps    = loc_oPag1.cbo_4c_Combo5.ListIndex
3937:             loc_oBO.this_nIcmsincs   = loc_oPag1.cbo_4c_Combo10.ListIndex
3938:             loc_oBO.this_cSittribs   = ALLTRIM(NVL(loc_oPag1.txt_4c_Sittricm.Value, ""))

*-- Linhas 4055 a 4068:
4055:             loc_oPag1.txt_4c_CfoST.Value   = ALLTRIM(NVL(loc_oBO.this_cCfosts,   ""))
4056:             loc_oPag1.txt_4c_Cfdest.Value  = ALLTRIM(NVL(loc_oBO.this_cCoddests, ""))
4057: 
4058:             *-- Checkboxes ICMS
4059:             loc_oPag1.chk_4c_ObjFreteICM.Value   = (loc_oBO.this_nFrticms = 1)
4060:             loc_oPag1.chk_4c_ObjSegIcm.Value     = (loc_oBO.this_nSegicms = 1)
4061:             loc_oPag1.chk_4c_ObjDespIcm.Value    = (loc_oBO.this_nDesicms = 1)
4062:             loc_oPag1.chk_4c_Fwcheckbox1.Value   = (loc_oBO.this_nIncicmnfs = 1)
4063:             loc_oPag1.chk_4c_Fwcheckbox2.Value   = (loc_oBO.this_nSomaicmfrete = 1)
4064: 
4065:             *-- Substituicao / Base ST
4066:             loc_oPag1.cbo_4c_CmbSTRIB.Value  = IIF(UPPER(ALLTRIM(loc_oBO.this_cSubtribs)) = "S", ;
4067:                 "Sim", "N" + CHR(227) + "o")
4068:             loc_oPag1.txt_4c_Bcst.Value       = ALLTRIM(STR(loc_oBO.this_nPbcsts, 6, 2))

*-- Linhas 4229 a 4238:
4229:             loc_oPag1.chk_4c_ObjFreteICM.Value     = 0
4230:             loc_oPag1.chk_4c_ObjSegIcm.Value       = 0
4231:             loc_oPag1.chk_4c_ObjDespIcm.Value      = 0
4232:             loc_oPag1.chk_4c_Fwcheckbox1.Value     = 0
4233:             loc_oPag1.chk_4c_Fwcheckbox2.Value     = 0
4234:             loc_oPag1.cbo_4c_CmbSTRIB.ListIndex    = 2
4235:             loc_oPag1.txt_4c_Bcst.Value            = "  0.00"
4236:             loc_oPag1.txt_4c_Sittricm.Value        = ""
4237:             loc_oPag1.cbo_4c_CmbContribuinte.ListIndex = 2
4238:             loc_oPag1.txt_4c_AliqIVCs.Value        = " 0.00"

*-- Linhas 4349 a 4358:
4349:             loc_oPag1.chk_4c_ObjFreteICM.Enabled    = par_lHabilitar
4350:             loc_oPag1.chk_4c_ObjSegIcm.Enabled      = par_lHabilitar
4351:             loc_oPag1.chk_4c_ObjDespIcm.Enabled     = par_lHabilitar
4352:             loc_oPag1.chk_4c_Fwcheckbox1.Enabled    = par_lHabilitar
4353:             loc_oPag1.chk_4c_Fwcheckbox2.Enabled    = par_lHabilitar
4354: 
4355:             *-- IPI
4356:             loc_oPag1.cbo_4c_CmbIpi.Enabled    = par_lHabilitar
4357:             loc_oPag1.txt_4c_Aliqs.Enabled      = par_lHabilitar
4358:             loc_oPag1.cbo_4c_CmbIpiI.Enabled    = par_lHabilitar

*-- Linhas 4423 a 4444:
4423:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4424: 
4425:             *-- Confirmar: habilitado apenas em INCLUIR/ALTERAR
4426:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEmEdicao
4427: 
4428:             *-- Cancelar: sempre habilitado em Page2
4429:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
4430: 
4431:             *-- Botoes da Page1 (CRUD): desabilita Alterar/Excluir quando nao ha registro
4432:             LOCAL loc_oPg1
4433:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
4434:             LOCAL loc_lTemRegistro
4435:             loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
4436: 
4437:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
4438:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
4439:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
4440: 
4441:         CATCH TO loc_oErro
4442:             MostrarErro(loc_oErro, "Formcfo.AjustarBotoesPorModo")
4443:         ENDTRY
4444:     ENDPROC


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*==============================================================================
* cfoBO.prg - Business Object para CFOP (C" + CHR(243) + "digo Fiscal de Opera" + CHR(231) + CHR(245) + "es)
* Data: 2026-04-11
* Tabela: SIGCDCFO | PK: codigos
*==============================================================================

DEFINE CLASS cfoBO AS BusinessBase

    *-- === DADOS PRINCIPAIS ===
    this_cCodigos       = ""   && codigos    CHAR(10)      - C" + CHR(243) + "digo CFOP (PK)
    this_cDescricaos    = ""   && descricaos CHAR(60)      - Descri" + CHR(231) + CHR(227) + "o Nota Fiscal
    this_cDesc2s        = ""   && desc2s     CHAR(60)      - Descri" + CHR(231) + CHR(227) + "o Consulta
    this_nSituas        = 1    && situas     NUMERIC(1,0)  - Situa" + CHR(231) + CHR(227) + "o (1=Ativo, 0=Inativo)
    this_nTipos         = 0    && tipos      NUMERIC(1,0)  - Tipo (0=Compras,1=Dev.Comp.,2=Vendas,3=Dev.Vend.,4=Serv.)
    this_cOperacaos     = ""   && operacaos  CHAR(1)       - Opera" + CHR(231) + CHR(227) + "o (E=Entrada, S=Sa" + CHR(237) + "da)
    this_nNdigitos      = 0    && ndigitos   NUMERIC(2,0)  - D" + CHR(237) + "gitos Para NF

    *-- === ICMS ===
    this_cIcms          = ""   && icms       CHAR(1)       - ICMS (regime)
    this_nInclicms      = 0    && inclicms   NUMERIC(1,0)  - Incluir ICMS (0=N" + CHR(227) + "o,1=Sim,2=Base,3=Pre" + CHR(231) + "o)
    this_nIcmsincs      = 0    && icmsincs   NUMERIC(1,0)  - ICMS Incluso no Pre" + CHR(231) + "o (Sim/N" + CHR(227) + "o)
    this_nIcmsdscs      = 0    && icmsdscs   NUMERIC(1,0)  - ICMS Sobre Desconto
    this_cSittribs      = ""   && sittribs   CHAR(3)       - Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS (lookup SigCdIcm)
    this_nPbcsts        = 0    && pbcsts     NUMERIC(5,2)  - % Base de C" + CHR(225) + "lculo ST
    this_cSubtribs      = ""   && subtribs   CHAR(1)       - Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria (Sim/N" + CHR(227) + "o)
    this_cCfosts        = ""   && cfosts     CHAR(10)      - CFOP Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria
    this_cCoddests      = ""   && coddests   CHAR(10)      - CFOP Destino
    this_cCfost60s      = ""   && cfost60s   CHAR(10)      - CFOP ST60
    this_nAliqivcs      = 0    && aliqivcs   NUMERIC(4,2)  - Al" + CHR(237) + "quota Venda Consumidor
    this_nDesicms       = 0    && desicms    NUMERIC(1,0)  - Desp. Acess. ICMS (Sim/N" + CHR(227) + "o)
    this_nFrticms       = 0    && frticms    NUMERIC(1,0)  - Frete ICMS (Sim/N" + CHR(227) + "o)
    this_nSegicms       = 0    && segicms    NUMERIC(1,0)  - Seguro ICMS (Sim/N" + CHR(227) + "o)
    this_nIncicmnfs     = 0    && incicmnfs  NUMERIC(1,0)  - Incluir ICMS no Total NF (Sim/N" + CHR(227) + "o)
    this_nSomaicmfrete  = 0    && somaicmfrete NUMERIC(1,0) - Soma ICMS Frete no Total NF
    this_cCgergia1s     = ""   && cgergia1s  CHAR(1)       - Destaca ICMS na Nota Fiscal (S/N)
    this_cUnitimps      = ""   && unitimps   CHAR(1)       - Inibe Valor Unit" + CHR(225) + "rio NF Importa" + CHR(231) + CHR(227) + "o
    this_cMotdeson      = ""   && motdeson   CHAR(2)       - Motivo Desonera" + CHR(231) + CHR(227) + "o ICMS

    *-- === IPI ===
    this_cIpis          = ""   && ipis       CHAR(1)       - IPI
    this_nAliqipis      = 0    && aliqipis   NUMERIC(4,2)  - Al" + CHR(237) + "quota IPI
    this_nInclipis      = 0    && inclipis   NUMERIC(1,0)  - Incluir IPI na Base
    this_cIpiIcms       = ""   && ipi_icms   CHAR(1)       - IPI Importa" + CHR(231) + CHR(227) + "o
    this_cBcipis        = ""   && bcipis     CHAR(1)       - Base de C" + CHR(225) + "lculo IPI
    this_nPbcipis       = 0    && pbcipis    NUMERIC(5,2)  - % Base de C" + CHR(225) + "lculo IPI
    this_nIpincreds     = 0    && ipincreds  NUMERIC(1,0)  - N" + CHR(227) + "o Creditado
    this_cAcresipis     = ""   && acresipis  CHAR(1)       - Acres/Desc na Base IPI
    this_cIpiimpors     = ""   && ipiimpors  CHAR(1)       - Retira IPI do $
    this_cIpiom2s       = ""   && ipiom2s    CHAR(1)       - Calcula IPI Import. Origem Merc.=2
    this_nDesipis       = 0    && desipis    NUMERIC(1,0)  - Desp. Acess. IPI (Sim/N" + CHR(227) + "o)
    this_nFrtipis       = 0    && frtipis    NUMERIC(1,0)  - Frete IPI (Sim/N" + CHR(227) + "o)
    this_nSegipis       = 0    && segipis    NUMERIC(1,0)  - Seguro IPI (Sim/N" + CHR(227) + "o)

    *-- === ESPECIFICACOES NF-e ===
    this_cIpicst        = ""   && ipicst     CHAR(2)       - C" + CHR(243) + "digo IPI Sit. Tribut" + CHR(225) + "ria
    this_cPiscst        = ""   && piscst     CHAR(2)       - C" + CHR(243) + "digo PIS Sit. Tribut" + CHR(225) + "ria
    this_cCofcst        = ""   && cofcst     CHAR(2)       - C" + CHR(243) + "digo COFINS Sit. Tribut" + CHR(225) + "ria
    this_cIssqnl        = ""   && issqnl     CHAR(5)       - C" + CHR(243) + "digo ISSQN Lista Serv.
    this_nAliqpis       = 0    && aliqpis    NUMERIC(5,2)  - Al" + CHR(237) + "quota do PIS
    this_nAliqcofins    = 0    && aliqcofins NUMERIC(5,2)  - Al" + CHR(237) + "quota do COFINS
    this_nAliqissqn     = 0    && aliqissqn  NUMERIC(5,2)  - Al" + CHR(237) + "quota do ISSQN
    this_nCtissqn       = 0    && ctissqn    NUMERIC(1,0)  - C" + CHR(243) + "d. Trib. ISSQN (0=Normal,1=Retida,2=Substituta,3=Isenta)
    this_nRettribs      = 0    && rettribs   NUMERIC(1,0)  - Informa Reten" + CHR(231) + CHR(227) + "o de Trib. (Sim/N" + CHR(227) + "o)
    this_nAliqii        = 0    && aliqii     NUMERIC(5,2)  - Al" + CHR(237) + "quota do II
    this_cIpienq        = ""   && ipienq     CHAR(3)       - C" + CHR(243) + "digo Enquadramento IPI
    this_cContribs      = ""   && contribs   CHAR(1)       - Contribuinte

    *-- === INTEGRACAO CONTABIL ===
    this_cContvcds      = ""   && contvcds   CHAR(9)       - Conta Valor Cont" + CHR(225) + "bil DB
    this_cContvccs      = ""   && contvccs   CHAR(9)       - Conta Valor Cont" + CHR(225) + "bil CR
    this_cConticds      = ""   && conticds   CHAR(9)       - Conta ICMS DB
    this_cConticcs      = ""   && conticcs   CHAR(9)       - Conta ICMS CR
    this_cContipds      = ""   && contipds   CHAR(9)       - Conta IPI DB
    this_cContipcs      = ""   && contipcs   CHAR(9)       - Conta IPI CR
    this_cContfrt       = ""   && contfrt    CHAR(9)       - Conta de Frete
    this_cContseg       = ""   && contseg    CHAR(9)       - Conta de Seguro
    this_cContda        = ""   && contda     CHAR(9)       - Conta de Despesas
    this_cContconts     = ""   && contconts  CHAR(1)       - Tipo contabiliza" + CHR(231) + CHR(227) + "o (fixa/din" + CHR(226) + "mica)

    *-- === INTEGRACAO FISCAL ===
    this_nPontedescs    = 0    && pontedescs NUMERIC(1,0)  - Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o (0=N" + CHR(227) + "o,1=CFOP,2=Obs)
    this_nAgrupas       = 0    && agrupas    NUMERIC(1,0)  - Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o (Sim/N" + CHR(227) + "o)
    this_nZeradas       = 0    && zeradas    NUMERIC(1,0)  - Integra" + CHR(231) + CHR(227) + "o Zerada (Sim/N" + CHR(227) + "o)
    this_nDtintfis      = 0    && dtintfis   NUMERIC(1,0)  - Data Lan" + CHR(231) + "amento Cont" + CHR(225) + "bil (0=Integra" + CHR(231) + CHR(227) + "o, 1=NF)
    this_nUtilvars      = 0    && utilvars   NUMERIC(1,0)  - Utilizar Varia" + CHR(231) + CHR(227) + "o CFOP na Integra" + CHR(231) + CHR(227) + "o
    this_nIntvlrcont    = 0    && intvlrcont NUMERIC(1,0)  - Integrar Valor Cont" + CHR(225) + "bil (Sim/N" + CHR(227) + "o)
    this_nIntvlricms    = 0    && intvlricms NUMERIC(1,0)  - Integrar Valores ICMS (Sim/N" + CHR(227) + "o)
    this_nIntvlripi     = 0    && intvlripi  NUMERIC(1,0)  - Integrar Valores IPI (Sim/N" + CHR(227) + "o)
    this_nIndmov        = 0    && indmov     NUMERIC(1,0)  - Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque (Sim/N" + CHR(227) + "o)
    this_nIndpagto      = 0    && indpagto   NUMERIC(1,0)  - Indica" + CHR(231) + CHR(227) + "o de Pagamento (Sim/N" + CHR(227) + "o)

    *-- === OUTROS ===
    this_nTransps       = 0    && transps    NUMERIC(1,0)  - CFOP Transporte (Sim/N" + CHR(227) + "o)
    this_nTiporecs      = 0    && tiporecs   NUMERIC(1,0)  - Tipo Recibo
    this_nObspads       = 0    && obspads    NUMERIC(3,0)  - Obs. Padr" + CHR(227) + "o

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDCFO"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Dados Principais
                THIS.this_cCodigos       = TratarNulo(codigos,      "C")
                THIS.this_cDescricaos    = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s        = TratarNulo(desc2s,       "C")
                THIS.this_nSituas        = TratarNulo(situas,       "N")
                THIS.this_nTipos         = TratarNulo(tipos,        "N")
                THIS.this_cOperacaos     = TratarNulo(operacaos,    "C")
                THIS.this_nNdigitos      = TratarNulo(ndigitos,     "N")

                *-- ICMS
                THIS.this_cIcms          = TratarNulo(icms,         "C")
                THIS.this_nInclicms      = TratarNulo(inclicms,     "N")
                THIS.this_nIcmsincs      = TratarNulo(icmsincs,     "N")
                THIS.this_nIcmsdscs      = TratarNulo(icmsdscs,     "N")
                THIS.this_cSittribs      = TratarNulo(sittribs,     "C")
                THIS.this_nPbcsts        = TratarNulo(pbcsts,       "N")
                THIS.this_cSubtribs      = TratarNulo(subtribs,     "C")
                THIS.this_cCfosts        = TratarNulo(cfosts,       "C")
                THIS.this_cCoddests      = TratarNulo(coddests,     "C")
                THIS.this_cCfost60s      = TratarNulo(cfost60s,     "C")
                THIS.this_nAliqivcs      = TratarNulo(aliqivcs,     "N")
                THIS.this_nDesicms       = TratarNulo(desicms,      "N")
                THIS.this_nFrticms       = TratarNulo(frticms,      "N")
                THIS.this_nSegicms       = TratarNulo(segicms,      "N")
                THIS.this_nIncicmnfs     = TratarNulo(incicmnfs,    "N")
                THIS.this_nSomaicmfrete  = TratarNulo(somaicmfrete, "N")
                THIS.this_cCgergia1s     = TratarNulo(cgergia1s,    "C")
                THIS.this_cUnitimps      = TratarNulo(unitimps,     "C")
                THIS.this_cMotdeson      = TratarNulo(motdeson,     "C")

                *-- IPI
                THIS.this_cIpis          = TratarNulo(ipis,         "C")
                THIS.this_nAliqipis      = TratarNulo(aliqipis,     "N")
                THIS.this_nInclipis      = TratarNulo(inclipis,     "N")
                THIS.this_cIpiIcms       = TratarNulo(ipi_icms,     "C")
                THIS.this_cBcipis        = TratarNulo(bcipis,       "C")
                THIS.this_nPbcipis       = TratarNulo(pbcipis,      "N")
                THIS.this_nIpincreds     = TratarNulo(ipincreds,    "N")
                THIS.this_cAcresipis     = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors     = TratarNulo(ipiimpors,    "C")
                THIS.this_cIpiom2s       = TratarNulo(ipiom2s,      "C")
                THIS.this_nDesipis       = TratarNulo(desipis,      "N")
                THIS.this_nFrtipis       = TratarNulo(frtipis,      "N")
                THIS.this_nSegipis       = TratarNulo(segipis,      "N")

                *-- Especifica" + CHR(231) + CHR(245) + "es NF-e
                THIS.this_cIpicst        = TratarNulo(ipicst,       "C")
                THIS.this_cPiscst        = TratarNulo(piscst,       "C")
                THIS.this_cCofcst        = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl        = TratarNulo(issqnl,       "C")
                THIS.this_nAliqpis       = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqcofins    = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqissqn     = TratarNulo(aliqissqn,    "N")
                THIS.this_nCtissqn       = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs      = TratarNulo(rettribs,     "N")
                THIS.this_nAliqii        = TratarNulo(aliqii,       "N")
                THIS.this_cIpienq        = TratarNulo(ipienq,       "C")
                THIS.this_cContribs      = TratarNulo(contribs,     "C")

                *-- Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil
                THIS.this_cContvcds      = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs      = TratarNulo(contvccs,     "C")
                THIS.this_cConticds      = TratarNulo(conticds,     "C")
                THIS.this_cConticcs      = TratarNulo(conticcs,     "C")
                THIS.this_cContipds      = TratarNulo(contipds,     "C")
                THIS.this_cContipcs      = TratarNulo(contipcs,     "C")
                THIS.this_cContfrt       = TratarNulo(contfrt,      "C")
                THIS.this_cContseg       = TratarNulo(contseg,      "C")
                THIS.this_cContda        = TratarNulo(contda,       "C")
                THIS.this_cContconts     = TratarNulo(contconts,    "C")

                *-- Integra" + CHR(231) + CHR(227) + "o Fiscal
                THIS.this_nPontedescs    = TratarNulo(pontedescs,   "N")
                THIS.this_nAgrupas       = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas       = TratarNulo(zeradas,      "N")
                THIS.this_nDtintfis      = TratarNulo(dtintfis,     "N")
                THIS.this_nUtilvars      = TratarNulo(utilvars,     "N")
                THIS.this_nIntvlrcont    = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms    = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi     = TratarNulo(intvlripi,    "N")
                THIS.this_nIndmov        = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto      = TratarNulo(indpagto,     "N")

                *-- Outros
                THIS.this_nTransps       = TratarNulo(transps,      "N")
                THIS.this_nTiporecs      = TratarNulo(tiporecs,     "N")
                THIS.this_nObspads       = TratarNulo(obspads,      "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SIGCDCFO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCDCFO (" + ;
                "codigos, descricaos, desc2s, situas, tipos, operacaos, ndigitos," + ;
                " icms, inclicms, icmsincs, icmsdscs, sittribs, pbcsts, subtribs," + ;
                " cfosts, coddests, cfost60s, aliqivcs, desicms, frticms, segicms," + ;
                " incicmnfs, somaicmfrete, cgergia1s, unitimps, motdeson," + ;
                " ipis, aliqipis, inclipis, ipi_icms, bcipis, pbcipis, ipincreds," + ;
                " acresipis, ipiimpors, ipiom2s, desipis, frtipis, segipis," + ;
                " ipicst, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn," + ;
                " ctissqn, rettribs, aliqii, ipienq, contribs," + ;
                " contvcds, contvccs, conticds, conticcs, contipds, contipcs," + ;
                " contfrt, contseg, contda, contconts," + ;
                " pontedescs, agrupas, zeradas, dtintfis, utilvars," + ;
                " intvlrcont, intvlricms, intvlripi, indmov, indpagto," + ;
                " transps, tiporecs, obspads" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cCodigos) + ", " + ;
                EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                EscaparSQL(THIS.this_cIcms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                EscaparSQL(THIS.this_cSittribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                EscaparSQL(THIS.this_cCfosts) + ", " + ;
                EscaparSQL(THIS.this_cCoddests) + ", " + ;
                EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpiIcms) + ", " + ;
                EscaparSQL(THIS.this_cBcipis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpicst) + ", " + ;
                EscaparSQL(THIS.this_cPiscst) + ", " + ;
                EscaparSQL(THIS.this_cCofcst) + ", " + ;
                EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                EscaparSQL(THIS.this_cIpienq) + ", " + ;
                EscaparSQL(THIS.this_cContribs) + ", " + ;
                EscaparSQL(THIS.this_cContvcds) + ", " + ;
                EscaparSQL(THIS.this_cContvccs) + ", " + ;
                EscaparSQL(THIS.this_cConticds) + ", " + ;
                EscaparSQL(THIS.this_cConticcs) + ", " + ;
                EscaparSQL(THIS.this_cContipds) + ", " + ;
                EscaparSQL(THIS.this_cContipcs) + ", " + ;
                EscaparSQL(THIS.this_cContfrt) + ", " + ;
                EscaparSQL(THIS.this_cContseg) + ", " + ;
                EscaparSQL(THIS.this_cContda) + ", " + ;
                EscaparSQL(THIS.this_cContconts) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDtintfis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObspads, 0) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SIGCDCFO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDCFO SET " + ;
                "descricaos    = " + EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                "desc2s        = " + EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                "situas        = " + FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                "tipos         = " + FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                "operacaos     = " + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                "ndigitos      = " + FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                "icms          = " + EscaparSQL(THIS.this_cIcms) + ", " + ;
                "inclicms      = " + FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                "icmsincs      = " + FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                "icmsdscs      = " + FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                "sittribs      = " + EscaparSQL(THIS.this_cSittribs) + ", " + ;
                "pbcsts        = " + FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                "subtribs      = " + EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                "cfosts        = " + EscaparSQL(THIS.this_cCfosts) + ", " + ;
                "coddests      = " + EscaparSQL(THIS.this_cCoddests) + ", " + ;
                "cfost60s      = " + EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                "aliqivcs      = " + FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                "desicms       = " + FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                "frticms       = " + FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                "segicms       = " + FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                "incicmnfs     = " + FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                "somaicmfrete  = " + FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                "cgergia1s     = " + EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                "unitimps      = " + EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                "motdeson      = " + EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                "ipis          = " + EscaparSQL(THIS.this_cIpis) + ", " + ;
                "aliqipis      = " + FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                "inclipis      = " + FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                "ipi_icms      = " + EscaparSQL(THIS.this_cIpiIcms) + ", " + ;
                "bcipis        = " + EscaparSQL(THIS.this_cBcipis) + ", " + ;
                "pbcipis       = " + FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                "ipincreds     = " + FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                "acresipis     = " + EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                "ipiimpors     = " + EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                "ipiom2s       = " + EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                "desipis       = " + FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                "frtipis       = " + FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                "segipis       = " + FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                "ipicst        = " + EscaparSQL(THIS.this_cIpicst) + ", " + ;
                "piscst        = " + EscaparSQL(THIS.this_cPiscst) + ", " + ;
                "cofcst        = " + EscaparSQL(THIS.this_cCofcst) + ", " + ;
                "issqnl        = " + EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                "aliqpis       = " + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                "aliqcofins    = " + FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                "aliqissqn     = " + FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                "ctissqn       = " + FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                "rettribs      = " + FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                "aliqii        = " + FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                "ipienq        = " + EscaparSQL(THIS.this_cIpienq) + ", " + ;
                "contribs      = " + EscaparSQL(THIS.this_cContribs) + ", " + ;
                "contvcds      = " + EscaparSQL(THIS.this_cContvcds) + ", " + ;
                "contvccs      = " + EscaparSQL(THIS.this_cContvccs) + ", " + ;
                "conticds      = " + EscaparSQL(THIS.this_cConticds) + ", " + ;
                "conticcs      = " + EscaparSQL(THIS.this_cConticcs) + ", " + ;
                "contipds      = " + EscaparSQL(THIS.this_cContipds) + ", " + ;
                "contipcs      = " + EscaparSQL(THIS.this_cContipcs) + ", " + ;
                "contfrt       = " + EscaparSQL(THIS.this_cContfrt) + ", " + ;
                "contseg       = " + EscaparSQL(THIS.this_cContseg) + ", " + ;
                "contda        = " + EscaparSQL(THIS.this_cContda) + ", " + ;
                "contconts     = " + EscaparSQL(THIS.this_cContconts) + ", " + ;
                "pontedescs    = " + FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                "agrupas       = " + FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                "zeradas       = " + FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                "dtintfis      = " + FormatarNumeroSQL(THIS.this_nDtintfis, 0) + ", " + ;
                "utilvars      = " + FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                "intvlrcont    = " + FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                "intvlricms    = " + FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                "intvlripi     = " + FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                "indmov        = " + FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                "indpagto      = " + FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                "transps       = " + FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                "tiporecs      = " + FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                "obspads       = " + FormatarNumeroSQL(THIS.this_nObspads, 0) + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SIGCDCFO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDCFO WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descricaos, situas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Sem conexao: criar cursor vazio para nao bloquear o grid
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT codigos, descricaos, situas FROM SIGCDCFO"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Protecao de grid: se cursor ja esta aberto (grid vinculado), usar ZAP+APPEND
            IF USED("cursor_4c_Dados")
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, desc2s, situas, tipos, operacaos, ndigitos," + ;
                " icms, inclicms, icmsincs, icmsdscs, sittribs, pbcsts, subtribs," + ;
                " cfosts, coddests, cfost60s, aliqivcs, desicms, frticms, segicms," + ;
                " incicmnfs, somaicmfrete, cgergia1s, unitimps, motdeson," + ;
                " ipis, aliqipis, inclipis, ipi_icms, bcipis, pbcipis, ipincreds," + ;
                " acresipis, ipiimpors, ipiom2s, desipis, frtipis, segipis," + ;
                " ipicst, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn," + ;
                " ctissqn, rettribs, aliqii, ipienq, contribs," + ;
                " contvcds, contvccs, conticds, conticcs, contipds, contipcs," + ;
                " contfrt, contseg, contda, contconts," + ;
                " pontedescs, agrupas, zeradas, dtintfis, utilvars," + ;
                " intvlrcont, intvlricms, intvlripi, indmov, indpagto," + ;
                " transps, tiporecs, obspads" + ;
                " FROM SIGCDCFO WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave prim" + CHR(225) + "ria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Validar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCfopPorCodigo - Busca CFOP para lookup (usado em validacoes de campos)
    * Retorna .T. se encontrou, cursor cursor_4c_BuscaCfo com os dados
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCfopPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos FROM SIGCDCFO" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_BuscaCfo")
                USE IN cursor_4c_BuscaCfo
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCfo")

            IF loc_nResultado >= 0
                loc_lSucesso = (RECCOUNT("cursor_4c_BuscaCfo") > 0)
            ELSE
                MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar CFOP:" + CHR(13) + loException.Message, "cfoBO.BuscarCfopPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarIcmPorCodigo - Busca Situacao Tributaria ICMS para lookup
    * Retorna .T. se encontrou, cursor cursor_4c_BuscaIcm com os dados
    *--------------------------------------------------------------------------
    PROCEDURE BuscarIcmPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos FROM SigCdIcm" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_BuscaIcm")
                USE IN cursor_4c_BuscaIcm
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaIcm")

            IF loc_nResultado >= 0
                loc_lSucesso = (RECCOUNT("cursor_4c_BuscaIcm") > 0)
            ELSE
                MostrarErro("Erro ao buscar ICM:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar ICM:" + CHR(13) + loException.Message, "cfoBO.BuscarIcmPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

