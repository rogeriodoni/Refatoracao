# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 181: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 205: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 229: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 277: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 314: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 429: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 452: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4451 linhas total):

*-- Linhas 87 a 105:
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88:         WITH THIS.pgf_4c_Paginas
89:             .PageCount  = 2
90:             .Top        = -29
91:             .Left       = 0
92:             .Width      = 1000
93:             .Height     = 629
94:             .Tabs       = .F.
95:             .Visible    = .T.
96:         ENDWITH
97: 
98:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
99:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
100:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
101:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
102: 
103:         *-- Configurar Page1 e Page2
104:         THIS.ConfigurarPaginaLista()
105:         THIS.ConfigurarPaginaDados()

*-- Linhas 117 a 157:
117:         *-- Container cabecalho (titulo do formulario - lado esquerdo)
118:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH loc_oPagina.cnt_4c_Cabecalho
120:             .Top         = 31
121:             .Left        = 0
122:             .Width       = 800
123:             .Height      = 85
124:             .BackStyle   = 1
125:             .BackColor   = RGB(53, 53, 53)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         *-- Label sombra (efeito de sombra no titulo)
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = "Cadastro de CFOP"
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = 769
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .AutoSize  = .F.
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         *-- Label titulo (branco - sobre a sombra)
148:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
150:             .Caption   = "Cadastro de CFOP"
151:             .Top       = 18
152:             .Left      = 10
153:             .Width     = 769
154:             .Height    = 46
155:             .FontName  = "Tahoma"
156:             .FontSize  = 16
157:             .FontBold  = .T.

*-- Linhas 164 a 189:
164:         *-- Container botoes CRUD (lado direito - a partir de Left=542)
165:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
166:         WITH loc_oPagina.cnt_4c_Botoes
167:             .Top         = 29
168:             .Left        = 542
169:             .Width       = 390
170:             .Height      = 85
171:             .BackStyle   = 1
172:             .BackColor   = RGB(53, 53, 53)
173:             .BorderWidth = 0
174:             .Visible     = .T.
175:         ENDWITH
176: 
177:         *-- Botao Incluir
178:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
179:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
180:             .Caption         = "Incluir"
181:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
182:             .PicturePosition = 13
183:             .Top             = 5
184:             .Left            = 5
185:             .Width           = 75
186:             .Height          = 75
187:             .FontName        = "Comic Sans MS"
188:             .FontSize        = 8
189:             .FontBold        = .T.

*-- Linhas 199 a 213:
199:         ENDWITH
200: 
201:         *-- Botao Visualizar
202:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
203:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
204:             .Caption         = "Visualizar"
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
206:             .PicturePosition = 13
207:             .Top             = 5
208:             .Left            = 80
209:             .Width           = 75
210:             .Height          = 75
211:             .FontName        = "Comic Sans MS"
212:             .FontSize        = 8
213:             .FontBold        = .T.

*-- Linhas 223 a 237:
223:         ENDWITH
224: 
225:         *-- Botao Alterar
226:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
227:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
228:             .Caption         = "Alterar"
229:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
230:             .PicturePosition = 13
231:             .Top             = 5
232:             .Left            = 155
233:             .Width           = 75
234:             .Height          = 75
235:             .FontName        = "Comic Sans MS"
236:             .FontSize        = 8
237:             .FontBold        = .T.

*-- Linhas 247 a 261:
247:         ENDWITH
248: 
249:         *-- Botao Excluir
250:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
251:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
252:             .Caption         = "Excluir"
253:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
254:             .PicturePosition = 13
255:             .Top             = 5
256:             .Left            = 230
257:             .Width           = 75
258:             .Height          = 75
259:             .FontName        = "Comic Sans MS"
260:             .FontSize        = 8
261:             .FontBold        = .T.

*-- Linhas 271 a 285:
271:         ENDWITH
272: 
273:         *-- Botao Buscar
274:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
275:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
276:             .Caption         = "Buscar"
277:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
278:             .PicturePosition = 13
279:             .Top             = 5
280:             .Left            = 305
281:             .Width           = 75
282:             .Height          = 75
283:             .FontName        = "Comic Sans MS"
284:             .FontSize        = 8
285:             .FontBold        = .T.

*-- Linhas 297 a 322:
297:         *-- Container botao Encerrar (extrema direita)
298:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
299:         WITH loc_oPagina.cnt_4c_Saida
300:             .Top         = 29
301:             .Left        = 935
302:             .Width       = 60
303:             .Height      = 85
304:             .BackStyle   = 1
305:             .BackColor   = RGB(53, 53, 53)
306:             .BorderWidth = 0
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         *-- Botao Encerrar
311:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313:             .Caption         = "Encerrar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 50
319:             .Height          = 75
320:             .FontName        = "Comic Sans MS"
321:             .FontSize        = 8
322:             .FontBold        = .T.

*-- Linhas 333 a 361:
333: 
334:         *-- Botoes XML (abaixo da barra de cabecalho, compensados +29)
335:         *-- Original: btnExpXML top=85, left=3 -> compensado: 85+29=114
336:         loc_oPagina.AddObject("cmd_4c_ExpXML", "CommandButton")
337:         WITH loc_oPagina.cmd_4c_ExpXML
338:             .Caption       = "  Exporta XML"
339:             .Top           = 114
340:             .Left          = 3
341:             .Width         = 120
342:             .Height        = 40
343:             .FontName      = "Tahoma"
344:             .FontSize      = 8
345:             .ForeColor     = RGB(0, 0, 0)
346:             .BackColor     = RGB(240, 240, 240)
347:             .Themes        = .F.
348:             .SpecialEffect = 0
349:             .Visible       = .T.
350:         ENDWITH
351: 
352:         loc_oPagina.AddObject("cmd_4c_ImpXML", "CommandButton")
353:         WITH loc_oPagina.cmd_4c_ImpXML
354:             .Caption       = "  Importa XML"
355:             .Top           = 114
356:             .Left          = 127
357:             .Width         = 120
358:             .Height        = 40
359:             .FontName      = "Tahoma"
360:             .FontSize      = 8
361:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 368 a 377:
368:         *-- Grid de lista (abaixo dos botoes XML)
369:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
370:         WITH loc_oPagina.grd_4c_Lista
371:             .Top                = 157
372:             .Left               = 0
373:             .Width              = 995
374:             .Height             = 438
375:             .FontName           = "Verdana"
376:             .FontSize           = 8
377:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 390 a 405:
390:         ENDWITH
391: 
392:         *-- BINDEVENT para botoes (PUBLIC para funcionar com BINDEVENT)
393:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
395:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
396:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
397:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
398:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
399:         BINDEVENT(loc_oPagina.cmd_4c_ExpXML,                   "Click", THIS, "BtnExpXMLClick")
400:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML,                   "Click", THIS, "BtnImpXMLClick")
401:         BINDEVENT(loc_oPagina.grd_4c_Lista,                    "DblClick", THIS, "GrdListaDblClick")
402: 
403:         THIS.TornarControlesVisiveis(loc_oPagina)
404:     ENDPROC
405: 

*-- Linhas 413 a 437:
413:         *-- Container botoes Confirmar/Cancelar (canto superior direito, +29 compensado)
414:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
415:         WITH loc_oPagina.cnt_4c_BotoesAcao
416:             .Top         = 33
417:             .Left        = 842
418:             .Width       = 160
419:             .Height      = 85
420:             .BackStyle   = 1
421:             .BackColor   = RGB(53, 53, 53)
422:             .BorderWidth = 0
423:             .Visible     = .T.
424:         ENDWITH
425: 
426:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
427:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
428:             .Caption         = "Confirmar"
429:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
430:             .PicturePosition = 13
431:             .Top             = 5
432:             .Left            = 5
433:             .Width           = 75
434:             .Height          = 75
435:             .FontName        = "Comic Sans MS"
436:             .FontSize        = 8
437:             .FontBold        = .T.

*-- Linhas 446 a 460:
446:             .Visible         = .T.
447:         ENDWITH
448: 
449:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
450:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
451:             .Caption         = "Cancelar"
452:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
453:             .PicturePosition = 13
454:             .Top             = 5
455:             .Left            = 80
456:             .Width           = 75
457:             .Height          = 75
458:             .FontName        = "Comic Sans MS"
459:             .FontSize        = 8
460:             .FontBold        = .T.

*-- Linhas 474 a 496:
474:         loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
475:         WITH loc_oPagina.pgf_4c_PagDados
476:             .PageCount  = 2
477:             .Top        = 149
478:             .Left       = -1
479:             .Width      = 998
480:             .Height     = 476
481:             .Tabs       = .T.
482:             .Visible    = .T.
483:         ENDWITH
484: 
485:         WITH loc_oPagina.pgf_4c_PagDados.Page1
486:             .Caption    = "Dados Principais"
487:             .BackColor  = RGB(255, 255, 255)
488:         ENDWITH
489: 
490:         WITH loc_oPagina.pgf_4c_PagDados.Page2
491:             .Caption    = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil / Fiscal"
492:             .BackColor  = RGB(255, 255, 255)
493:         ENDWITH
494: 
495:         *-- Campos Page1 - primeira metade (top < 236)
496:         THIS.ConfigurarPaginaDadosParte1()

*-- Linhas 502 a 511:
502:         THIS.ConfigurarPaginaDadosPage2()
503: 
504:         *-- BINDEVENT para botoes de acao
505:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
506:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
507: 
508:         THIS.TornarControlesVisiveis(loc_oPagina)
509:     ENDPROC
510: 
511:     *--------------------------------------------------------------------------

*-- Linhas 531 a 544:
531:                 *-- Configurar colunas APOS RecordSource (redefine headers resetados pelo auto-bind)
532:                 loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.codigos"
533:                 loc_oGrid.Column1.Width            = 80
534:                 loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
535:                 loc_oGrid.Column1.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"
536: 
537:                 loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descricaos"
538:                 loc_oGrid.Column2.Width            = 400
539:                 loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
540:                 loc_oGrid.Column2.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"
541: 
542:                 THIS.FormatarGridLista(loc_oGrid)
543:                 loc_lResultado = .T.
544:             ENDIF

*-- Linhas 855 a 881:
855:         *----------------------------------------------------------------------
856: 
857:         *-- Label Codigo
858:         loc_oPag1.AddObject("lbl_4c_Label1", "Label")
859:         WITH loc_oPag1.lbl_4c_Label1
860:             .Caption   = "C" + CHR(243) + "digo :"
861:             .Top       = 11
862:             .Left      = 91
863:             .Width     = 42
864:             .Height    = 15
865:             .FontName  = "Tahoma"
866:             .FontSize  = 8
867:             .BackStyle = 0
868:             .ForeColor = RGB(90, 90, 90)
869:             .Visible   = .T.
870:         ENDWITH
871: 
872:         *-- Codigo CFOP
873:         loc_oPag1.AddObject("txt_4c_Codigo", "TextBox")
874:         WITH loc_oPag1.txt_4c_Codigo
875:             .Top           = 7
876:             .Left          = 136
877:             .Width         = 91
878:             .Height        = 24
879:             .FontName      = "Tahoma"
880:             .FontSize      = 8
881:             .MaxLength     = 10

*-- Linhas 889 a 944:
889:         loc_oPag1.AddObject("obj_4c_Opc_situacao", "OptionGroup")
890:         WITH loc_oPag1.obj_4c_Opc_situacao
891:             .ButtonCount = 2
892:             .Top         = 11
893:             .Left        = 243
894:             .Width       = 137
895:             .Height      = 17
896:             .BorderStyle = 0
897:             .Visible     = .T.
898:         ENDWITH
899:         WITH loc_oPag1.obj_4c_Opc_situacao.Buttons(1)
900:             .Caption   = "Ativo"
901:             .Left      = 0
902:             .Top       = 0
903:             .AutoSize  = .T.
904:             .FontName  = "Tahoma"
905:             .FontSize  = 8
906:             .ForeColor = RGB(90, 90, 90)
907:             .Themes    = .F.
908:         ENDWITH
909:         WITH loc_oPag1.obj_4c_Opc_situacao.Buttons(2)
910:             .Caption   = "Inativo"
911:             .Left      = 60
912:             .Top       = 0
913:             .AutoSize  = .T.
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .ForeColor = RGB(90, 90, 90)
917:             .Themes    = .F.
918:         ENDWITH
919: 
920:         *-- Label Operacao
921:         loc_oPag1.AddObject("lbl_4c_Label3", "Label")
922:         WITH loc_oPag1.lbl_4c_Label3
923:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
924:             .Top       = 11
925:             .Left      = 393
926:             .Width     = 56
927:             .Height    = 15
928:             .FontName  = "Tahoma"
929:             .FontSize  = 8
930:             .BackStyle = 0
931:             .ForeColor = RGB(90, 90, 90)
932:             .Visible   = .T.
933:         ENDWITH
934: 
935:         *-- Combo Operacao (E=Entrada, S=Saida)
936:         loc_oPag1.AddObject("cbo_4c_CmbOperacao", "ComboBox")
937:         WITH loc_oPag1.cbo_4c_CmbOperacao
938:             .Top           = 7
939:             .Left          = 459
940:             .Width         = 107
941:             .Height        = 24
942:             .FontName      = "Tahoma"
943:             .FontSize      = 8
944:             .RowSourceType = 1

*-- Linhas 951 a 977:
951:         ENDWITH
952: 
953:         *-- Label Tipo
954:         loc_oPag1.AddObject("lbl_4c_Label37", "Label")
955:         WITH loc_oPag1.lbl_4c_Label37
956:             .Caption   = "Tipo :"
957:             .Top       = 12
958:             .Left      = 616
959:             .Width     = 35
960:             .Height    = 15
961:             .FontName  = "Tahoma"
962:             .FontSize  = 8
963:             .BackStyle = 0
964:             .ForeColor = RGB(90, 90, 90)
965:             .Visible   = .T.
966:         ENDWITH
967: 
968:         *-- Combo Tipo (1=Compras,2=Dev.Compras,3=Vendas,4=Dev.Vendas,5=Servicos)
969:         loc_oPag1.AddObject("cbo_4c_Cmbtipo", "ComboBox")
970:         WITH loc_oPag1.cbo_4c_Cmbtipo
971:             .Top           = 7
972:             .Left          = 653
973:             .Width         = 151
974:             .Height        = 24
975:             .FontName      = "Tahoma"
976:             .FontSize      = 8
977:             .RowSourceType = 1

*-- Linhas 987 a 1013:
987:         ENDWITH
988: 
989:         *-- Label Digitos Para NF
990:         loc_oPag1.AddObject("lbl_4c_Label24", "Label")
991:         WITH loc_oPag1.lbl_4c_Label24
992:             .Caption   = "D" + CHR(237) + "gitos Para NF :"
993:             .Top       = 12
994:             .Left      = 848
995:             .Width     = 82
996:             .Height    = 15
997:             .FontName  = "Tahoma"
998:             .FontSize  = 8
999:             .BackStyle = 0
1000:             .ForeColor = RGB(90, 90, 90)
1001:             .Visible   = .T.
1002:         ENDWITH
1003: 
1004:         *-- Spinner Digitos Para NF (0-6)
1005:         loc_oPag1.AddObject("obj_4c_Ndigito", "Spinner")
1006:         WITH loc_oPag1.obj_4c_Ndigito
1007:             .Top                = 7
1008:             .Left               = 947
1009:             .Width              = 40
1010:             .Height             = 24
1011:             .FontName           = "Tahoma"
1012:             .FontSize           = 8
1013:             .SpinnerHighValue   = 6

*-- Linhas 1022 a 1079:
1022:         ENDWITH
1023: 
1024:         *-- Label Descricao Nota Fiscal
1025:         loc_oPag1.AddObject("lbl_4c_Label2", "Label")
1026:         WITH loc_oPag1.lbl_4c_Label2
1027:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Nota Fiscal :"
1028:             .Top       = 38
1029:             .Left      = 23
1030:             .Width     = 110
1031:             .Height    = 15
1032:             .FontName  = "Tahoma"
1033:             .FontSize  = 8
1034:             .BackStyle = 0
1035:             .ForeColor = RGB(90, 90, 90)
1036:             .Visible   = .T.
1037:         ENDWITH
1038: 
1039:         *-- TextBox Descricao NF
1040:         loc_oPag1.AddObject("txt_4c_Descricao", "TextBox")
1041:         WITH loc_oPag1.txt_4c_Descricao
1042:             .Top           = 34
1043:             .Left          = 136
1044:             .Width         = 430
1045:             .Height        = 24
1046:             .FontName      = "Tahoma"
1047:             .FontSize      = 8
1048:             .MaxLength     = 60
1049:             .SpecialEffect = 1
1050:             .ForeColor     = RGB(90, 90, 90)
1051:             .BorderColor   = RGB(100, 100, 100)
1052:             .Visible       = .T.
1053:         ENDWITH
1054: 
1055:         *-- Label Descricao Consulta
1056:         loc_oPag1.AddObject("lbl_4c_Label29", "Label")
1057:         WITH loc_oPag1.lbl_4c_Label29
1058:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Consulta :"
1059:             .Top       = 65
1060:             .Left      = 33
1061:             .Width     = 100
1062:             .Height    = 15
1063:             .FontName  = "Tahoma"
1064:             .FontSize  = 8
1065:             .BackStyle = 0
1066:             .ForeColor = RGB(90, 90, 90)
1067:             .Visible   = .T.
1068:         ENDWITH
1069: 
1070:         *-- TextBox Descricao Consulta
1071:         loc_oPag1.AddObject("txt_4c_Desc2s", "TextBox")
1072:         WITH loc_oPag1.txt_4c_Desc2s
1073:             .Top           = 61
1074:             .Left          = 136
1075:             .Width         = 430
1076:             .Height        = 24
1077:             .FontName      = "Tahoma"
1078:             .FontSize      = 8
1079:             .MaxLength     = 60

*-- Linhas 1086 a 1095:
1086:         *-- Linha separadora horizontal (shp01)
1087:         loc_oPag1.AddObject("shp_4c_Shp01", "Shape")
1088:         WITH loc_oPag1.shp_4c_Shp01
1089:             .Top         = 92
1090:             .Left        = 3
1091:             .Width       = 984
1092:             .Height      = 1
1093:             .BackStyle   = 1
1094:             .BackColor   = RGB(180, 180, 180)
1095:             .BorderStyle = 0

*-- Linhas 1101 a 1127:
1101:         *----------------------------------------------------------------------
1102: 
1103:         *-- Label ICMS
1104:         loc_oPag1.AddObject("lbl_4c_Label4", "Label")
1105:         WITH loc_oPag1.lbl_4c_Label4
1106:             .Caption   = "I C M S :"
1107:             .Top       = 105
1108:             .Left      = 90
1109:             .Width     = 43
1110:             .Height    = 15
1111:             .FontName  = "Tahoma"
1112:             .FontSize  = 8
1113:             .BackStyle = 0
1114:             .ForeColor = RGB(90, 90, 90)
1115:             .Visible   = .T.
1116:         ENDWITH
1117: 
1118:         *-- Combo ICMS (T=Tributado, I=Isento, O=Outros, N=N.Tributa)
1119:         loc_oPag1.AddObject("cbo_4c_CmbIcms", "ComboBox")
1120:         WITH loc_oPag1.cbo_4c_CmbIcms
1121:             .Top           = 101
1122:             .Left          = 136
1123:             .Width         = 82
1124:             .Height        = 23
1125:             .FontName      = "Tahoma"
1126:             .FontSize      = 8
1127:             .RowSourceType = 1

*-- Linhas 1134 a 1160:
1134:         ENDWITH
1135: 
1136:         *-- Label Incluir ICMS
1137:         loc_oPag1.AddObject("lbl_4c_Label26", "Label")
1138:         WITH loc_oPag1.lbl_4c_Label26
1139:             .Caption   = "Incluir ICMS :"
1140:             .Top       = 105
1141:             .Left      = 311
1142:             .Width     = 66
1143:             .Height    = 15
1144:             .FontName  = "Tahoma"
1145:             .FontSize  = 8
1146:             .BackStyle = 0
1147:             .ForeColor = RGB(90, 90, 90)
1148:             .Visible   = .T.
1149:         ENDWITH
1150: 
1151:         *-- Combo Incluir ICMS (1=Nao, 2=Base, 3=Preco)
1152:         loc_oPag1.AddObject("cbo_4c_Combo3", "ComboBox")
1153:         WITH loc_oPag1.cbo_4c_Combo3
1154:             .Top           = 101
1155:             .Left          = 380
1156:             .Width         = 82
1157:             .Height        = 23
1158:             .FontName      = "Tahoma"
1159:             .FontSize      = 8
1160:             .RowSourceType = 1

*-- Linhas 1167 a 1274:
1167:         ENDWITH
1168: 
1169:         *-- Label ICMS Sobre
1170:         loc_oPag1.AddObject("lbl_4c_Label14", "Label")
1171:         WITH loc_oPag1.lbl_4c_Label14
1172:             .Caption   = "ICMS Sobre :"
1173:             .Top       = 104
1174:             .Left      = 481
1175:             .Width     = 65
1176:             .Height    = 15
1177:             .FontName  = "Tahoma"
1178:             .FontSize  = 8
1179:             .BackStyle = 0
1180:             .ForeColor = RGB(90, 90, 90)
1181:             .Visible   = .T.
1182:         ENDWITH
1183: 
1184:         *-- Label CFOP ST60
1185:         loc_oPag1.AddObject("lbl_4c_Label49", "Label")
1186:         WITH loc_oPag1.lbl_4c_Label49
1187:             .Caption   = "CFOP ST60:"
1188:             .Top       = 102
1189:             .Left      = 614
1190:             .Width     = 60
1191:             .Height    = 15
1192:             .FontName  = "Tahoma"
1193:             .FontSize  = 8
1194:             .BackStyle = 0
1195:             .ForeColor = RGB(90, 90, 90)
1196:             .Visible   = .T.
1197:         ENDWITH
1198: 
1199:         *-- TextBox CFOP ST60 (lookup SigCdCfo)
1200:         loc_oPag1.AddObject("txt_4c_CfoST60", "TextBox")
1201:         WITH loc_oPag1.txt_4c_CfoST60
1202:             .Top           = 101
1203:             .Left          = 690
1204:             .Width         = 82
1205:             .Height        = 23
1206:             .FontName      = "Tahoma"
1207:             .FontSize      = 8
1208:             .MaxLength     = 10
1209:             .SpecialEffect = 1
1210:             .ForeColor     = RGB(90, 90, 90)
1211:             .BorderColor   = RGB(100, 100, 100)
1212:             .Visible       = .T.
1213:         ENDWITH
1214: 
1215:         *-- Label CFOP Subst.Trib.
1216:         loc_oPag1.AddObject("lbl_4c_Label11", "Label")
1217:         WITH loc_oPag1.lbl_4c_Label11
1218:             .Caption   = "CFOP Subst.Trib.:"
1219:             .Top       = 102
1220:             .Left      = 791
1221:             .Width     = 89
1222:             .Height    = 15
1223:             .FontName  = "Tahoma"
1224:             .FontSize  = 8
1225:             .BackStyle = 0
1226:             .ForeColor = RGB(90, 90, 90)
1227:             .Visible   = .T.
1228:         ENDWITH
1229: 
1230:         *-- TextBox CFOP Subst.Trib. (lookup SigCdCfo)
1231:         loc_oPag1.AddObject("txt_4c_CfoST", "TextBox")
1232:         WITH loc_oPag1.txt_4c_CfoST
1233:             .Top           = 101
1234:             .Left          = 887
1235:             .Width         = 82
1236:             .Height        = 23
1237:             .FontName      = "Tahoma"
1238:             .FontSize      = 8
1239:             .MaxLength     = 10
1240:             .SpecialEffect = 1
1241:             .ForeColor     = RGB(90, 90, 90)
1242:             .BorderColor   = RGB(100, 100, 100)
1243:             .Visible       = .T.
1244:         ENDWITH
1245: 
1246:         *-- CheckBox Frete ICMS
1247:         loc_oPag1.AddObject("chk_4c_ObjFreteICM", "CheckBox")
1248:         WITH loc_oPag1.chk_4c_ObjFreteICM
1249:             .Caption       = "Frete"
1250:             .Top           = 102
1251:             .Left          = 549
1252:             .Width         = 44
1253:             .Height        = 15
1254:             .FontName      = "Tahoma"
1255:             .FontSize      = 8
1256:             .BackStyle     = 0
1257:             .ForeColor     = RGB(90, 90, 90)
1258:             .SpecialEffect = 1
1259:             .AutoSize      = .T.
1260:             .Alignment     = 0
1261:             .Visible       = .T.
1262:         ENDWITH
1263: 
1264:         *-- CheckBox Seguro ICMS
1265:         loc_oPag1.AddObject("chk_4c_ObjSegIcm", "CheckBox")
1266:         WITH loc_oPag1.chk_4c_ObjSegIcm
1267:             .Caption       = "Seguro"
1268:             .Top           = 117
1269:             .Left          = 549
1270:             .Width         = 52
1271:             .Height        = 15
1272:             .FontName      = "Tahoma"
1273:             .FontSize      = 8
1274:             .BackStyle     = 0

*-- Linhas 1280 a 1306:
1280:         ENDWITH
1281: 
1282:         *-- Label Sobre Desconto
1283:         loc_oPag1.AddObject("lbl_4c_Label31", "Label")
1284:         WITH loc_oPag1.lbl_4c_Label31
1285:             .Caption   = "Sobre Desconto :"
1286:             .Top       = 131
1287:             .Left      = 48
1288:             .Width     = 85
1289:             .Height    = 15
1290:             .FontName  = "Tahoma"
1291:             .FontSize  = 8
1292:             .BackStyle = 0
1293:             .ForeColor = RGB(90, 90, 90)
1294:             .Visible   = .T.
1295:         ENDWITH
1296: 
1297:         *-- Combo ICMS Sobre Desconto (1=Sim, 2=Nao)
1298:         loc_oPag1.AddObject("cbo_4c_Combo6", "ComboBox")
1299:         WITH loc_oPag1.cbo_4c_Combo6
1300:             .Top           = 127
1301:             .Left          = 136
1302:             .Width         = 82
1303:             .Height        = 23
1304:             .FontName      = "Tahoma"
1305:             .FontSize      = 8
1306:             .RowSourceType = 1

*-- Linhas 1313 a 1339:
1313:         ENDWITH
1314: 
1315:         *-- Label Inclui IPI na Base
1316:         loc_oPag1.AddObject("lbl_4c_Label25", "Label")
1317:         WITH loc_oPag1.lbl_4c_Label25
1318:             .Caption   = "Inclui IPI na Base :"
1319:             .Top       = 132
1320:             .Left      = 285
1321:             .Width     = 92
1322:             .Height    = 15
1323:             .FontName  = "Tahoma"
1324:             .FontSize  = 8
1325:             .BackStyle = 0
1326:             .ForeColor = RGB(90, 90, 90)
1327:             .Visible   = .T.
1328:         ENDWITH
1329: 
1330:         *-- Combo Inclui IPI na Base ICMS (S=Sim, N=Nao)
1331:         loc_oPag1.AddObject("cbo_4c_Combo4", "ComboBox")
1332:         WITH loc_oPag1.cbo_4c_Combo4
1333:             .Top           = 127
1334:             .Left          = 380
1335:             .Width         = 82
1336:             .Height        = 23
1337:             .FontName      = "Tahoma"
1338:             .FontSize      = 8
1339:             .RowSourceType = 1

*-- Linhas 1346 a 1407:
1346:         ENDWITH
1347: 
1348:         *-- Label CFOP Destino
1349:         loc_oPag1.AddObject("lbl_4c_Label19", "Label")
1350:         WITH loc_oPag1.lbl_4c_Label19
1351:             .Caption   = "CFOP Destino :"
1352:             .Top       = 131
1353:             .Left      = 805
1354:             .Width     = 75
1355:             .Height    = 15
1356:             .FontName  = "Tahoma"
1357:             .FontSize  = 8
1358:             .BackStyle = 0
1359:             .ForeColor = RGB(90, 90, 90)
1360:             .Visible   = .T.
1361:         ENDWITH
1362: 
1363:         *-- TextBox CFOP Destino (lookup SigCdCfo)
1364:         loc_oPag1.AddObject("txt_4c_Cfdest", "TextBox")
1365:         WITH loc_oPag1.txt_4c_Cfdest
1366:             .Top           = 127
1367:             .Left          = 887
1368:             .Width         = 82
1369:             .Height        = 23
1370:             .FontName      = "Tahoma"
1371:             .FontSize      = 8
1372:             .MaxLength     = 10
1373:             .SpecialEffect = 1
1374:             .ForeColor     = RGB(90, 90, 90)
1375:             .BorderColor   = RGB(100, 100, 100)
1376:             .Visible       = .T.
1377:         ENDWITH
1378: 
1379:         *-- CheckBox Despesas Acessorias ICMS
1380:         loc_oPag1.AddObject("chk_4c_ObjDespIcm", "CheckBox")
1381:         WITH loc_oPag1.chk_4c_ObjDespIcm
1382:             .Caption       = "Despesas Acess" + CHR(243) + "rias"
1383:             .Top           = 132
1384:             .Left          = 549
1385:             .Width         = 118
1386:             .Height        = 15
1387:             .FontName      = "Tahoma"
1388:             .FontSize      = 8
1389:             .BackStyle     = 0
1390:             .ForeColor     = RGB(90, 90, 90)
1391:             .SpecialEffect = 1
1392:             .AutoSize      = .T.
1393:             .Alignment     = 0
1394:             .Visible       = .T.
1395:         ENDWITH
1396: 
1397:         *-- CheckBox Incluir ICMS no Total NF
1398:         loc_oPag1.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
1399:         WITH loc_oPag1.chk_4c_Fwcheckbox1
1400:             .Caption       = "Incluir ICMS no Total da N.F."
1401:             .Top           = 147
1402:             .Left          = 549
1403:             .Width         = 156
1404:             .Height        = 15
1405:             .FontName      = "Tahoma"
1406:             .FontSize      = 8
1407:             .BackStyle     = 0

*-- Linhas 1413 a 1439:
1413:         ENDWITH
1414: 
1415:         *-- Label Substituicao Tributaria
1416:         loc_oPag1.AddObject("lbl_4c_Label10", "Label")
1417:         WITH loc_oPag1.lbl_4c_Label10
1418:             .Caption   = "Substitui" + CHR(231) + CHR(227) + "o Tribut.:"
1419:             .Top       = 157
1420:             .Left      = 34
1421:             .Width     = 99
1422:             .Height    = 15
1423:             .FontName  = "Tahoma"
1424:             .FontSize  = 8
1425:             .BackStyle = 0
1426:             .ForeColor = RGB(90, 90, 90)
1427:             .Visible   = .T.
1428:         ENDWITH
1429: 
1430:         *-- Combo Substituicao Tributaria (S=Sim, N=Nao)
1431:         loc_oPag1.AddObject("cbo_4c_CmbSTRIB", "ComboBox")
1432:         WITH loc_oPag1.cbo_4c_CmbSTRIB
1433:             .Top           = 153
1434:             .Left          = 136
1435:             .Width         = 82
1436:             .Height        = 23
1437:             .FontName      = "Tahoma"
1438:             .FontSize      = 8
1439:             .RowSourceType = 1

*-- Linhas 1446 a 1503:
1446:         ENDWITH
1447: 
1448:         *-- Label Base Substituicao
1449:         loc_oPag1.AddObject("lbl_4c_Label12", "Label")
1450:         WITH loc_oPag1.lbl_4c_Label12
1451:             .Caption   = "Base Substitui" + CHR(231) + CHR(227) + "o :"
1452:             .Top       = 157
1453:             .Left      = 284
1454:             .Width     = 93
1455:             .Height    = 15
1456:             .FontName  = "Tahoma"
1457:             .FontSize  = 8
1458:             .BackStyle = 0
1459:             .ForeColor = RGB(90, 90, 90)
1460:             .Visible   = .T.
1461:         ENDWITH
1462: 
1463:         *-- TextBox Base Calculo ST (% pbcsts)
1464:         loc_oPag1.AddObject("txt_4c_Bcst", "TextBox")
1465:         WITH loc_oPag1.txt_4c_Bcst
1466:             .Top           = 153
1467:             .Left          = 380
1468:             .Width         = 82
1469:             .Height        = 23
1470:             .FontName      = "Tahoma"
1471:             .FontSize      = 8
1472:             .InputMask     = "999.99"
1473:             .SpecialEffect = 1
1474:             .ForeColor     = RGB(90, 90, 90)
1475:             .BorderColor   = RGB(100, 100, 100)
1476:             .Visible       = .T.
1477:         ENDWITH
1478: 
1479:         *-- Label CFOP Transporte
1480:         loc_oPag1.AddObject("lbl_4c_Label28", "Label")
1481:         WITH loc_oPag1.lbl_4c_Label28
1482:             .Caption   = "CFOP Transporte :"
1483:             .Top       = 157
1484:             .Left      = 788
1485:             .Width     = 92
1486:             .Height    = 15
1487:             .FontName  = "Tahoma"
1488:             .FontSize  = 8
1489:             .BackStyle = 0
1490:             .ForeColor = RGB(90, 90, 90)
1491:             .Visible   = .T.
1492:         ENDWITH
1493: 
1494:         *-- Combo CFOP Transporte (1=Sim, 2=Nao)
1495:         loc_oPag1.AddObject("cbo_4c_Combo5", "ComboBox")
1496:         WITH loc_oPag1.cbo_4c_Combo5
1497:             .Top           = 153
1498:             .Left          = 887
1499:             .Width         = 82
1500:             .Height        = 23
1501:             .FontName      = "Tahoma"
1502:             .FontSize      = 8
1503:             .RowSourceType = 1

*-- Linhas 1509 a 1522:
1509:             .Visible       = .T.
1510:         ENDWITH
1511: 
1512:         *-- CheckBox Soma ICMS Frete no Total NF (Visible=.F. por padrao)
1513:         loc_oPag1.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
1514:         WITH loc_oPag1.chk_4c_Fwcheckbox2
1515:             .Caption       = "Soma ICMS frete no Total da N.F."
1516:             .Top           = 163
1517:             .Left          = 549
1518:             .Width         = 180
1519:             .Height        = 15
1520:             .FontName      = "Tahoma"
1521:             .FontSize      = 8
1522:             .BackStyle     = 0

*-- Linhas 1528 a 1585:
1528:         ENDWITH
1529: 
1530:         *-- Label Situacao Tributaria ICMS
1531:         loc_oPag1.AddObject("lbl_4c_Label22", "Label")
1532:         WITH loc_oPag1.lbl_4c_Label22
1533:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut.:"
1534:             .Top       = 183
1535:             .Left      = 51
1536:             .Width     = 82
1537:             .Height    = 15
1538:             .FontName  = "Tahoma"
1539:             .FontSize  = 8
1540:             .BackStyle = 0
1541:             .ForeColor = RGB(90, 90, 90)
1542:             .Visible   = .T.
1543:         ENDWITH
1544: 
1545:         *-- TextBox Situacao Tributaria ICMS (lookup SigCdIcm)
1546:         loc_oPag1.AddObject("txt_4c_Sittricm", "TextBox")
1547:         WITH loc_oPag1.txt_4c_Sittricm
1548:             .Top           = 179
1549:             .Left          = 136
1550:             .Width         = 31
1551:             .Height        = 22
1552:             .FontName      = "Tahoma"
1553:             .FontSize      = 8
1554:             .MaxLength     = 3
1555:             .SpecialEffect = 1
1556:             .ForeColor     = RGB(90, 90, 90)
1557:             .BorderColor   = RGB(100, 100, 100)
1558:             .Visible       = .T.
1559:         ENDWITH
1560: 
1561:         *-- Label ICMS Incluso no Preco
1562:         loc_oPag1.AddObject("lbl_4c_Label36", "Label")
1563:         WITH loc_oPag1.lbl_4c_Label36
1564:             .Caption   = "ICMS Incluso no Pre" + CHR(231) + "o:"
1565:             .Top       = 182
1566:             .Left      = 264
1567:             .Width     = 113
1568:             .Height    = 15
1569:             .FontName  = "Tahoma"
1570:             .FontSize  = 8
1571:             .BackStyle = 0
1572:             .ForeColor = RGB(90, 90, 90)
1573:             .Visible   = .T.
1574:         ENDWITH
1575: 
1576:         *-- Combo ICMS Incluso no Preco (1=Sim, 2=Nao)
1577:         loc_oPag1.AddObject("cbo_4c_Combo10", "ComboBox")
1578:         WITH loc_oPag1.cbo_4c_Combo10
1579:             .Top           = 178
1580:             .Left          = 380
1581:             .Width         = 82
1582:             .Height        = 23
1583:             .FontName      = "Tahoma"
1584:             .FontSize      = 8
1585:             .RowSourceType = 1

*-- Linhas 1592 a 1618:
1592:         ENDWITH
1593: 
1594:         *-- Label Contribuinte
1595:         loc_oPag1.AddObject("lbl_4c_Label6", "Label")
1596:         WITH loc_oPag1.lbl_4c_Label6
1597:             .Caption   = "Contribuinte :"
1598:             .Top       = 183
1599:             .Left      = 812
1600:             .Width     = 68
1601:             .Height    = 15
1602:             .FontName  = "Tahoma"
1603:             .FontSize  = 8
1604:             .BackStyle = 0
1605:             .ForeColor = RGB(90, 90, 90)
1606:             .Visible   = .T.
1607:         ENDWITH
1608: 
1609:         *-- Combo Contribuinte (S=Sim, N=Nao, O=Outros)
1610:         loc_oPag1.AddObject("cbo_4c_CmbContribuinte", "ComboBox")
1611:         WITH loc_oPag1.cbo_4c_CmbContribuinte
1612:             .Top           = 179
1613:             .Left          = 887
1614:             .Width         = 82
1615:             .Height        = 23
1616:             .FontName      = "Tahoma"
1617:             .FontSize      = 8
1618:             .RowSourceType = 1

*-- Linhas 1625 a 1697:
1625:         ENDWITH
1626: 
1627:         *-- Label Venda Consumidor
1628:         loc_oPag1.AddObject("lbl_4c_Label23", "Label")
1629:         WITH loc_oPag1.lbl_4c_Label23
1630:             .Caption   = "Venda Consumidor :"
1631:             .Top       = 207
1632:             .Left      = 35
1633:             .Width     = 98
1634:             .Height    = 15
1635:             .FontName  = "Tahoma"
1636:             .FontSize  = 8
1637:             .BackStyle = 0
1638:             .ForeColor = RGB(90, 90, 90)
1639:             .Visible   = .T.
1640:         ENDWITH
1641: 
1642:         *-- TextBox Aliquota Venda Consumidor
1643:         loc_oPag1.AddObject("txt_4c_AliqIVCs", "TextBox")
1644:         WITH loc_oPag1.txt_4c_AliqIVCs
1645:             .Top           = 203
1646:             .Left          = 136
1647:             .Width         = 82
1648:             .Height        = 23
1649:             .FontName      = "Tahoma"
1650:             .FontSize      = 8
1651:             .InputMask     = "99.99"
1652:             .SpecialEffect = 1
1653:             .ForeColor     = RGB(90, 90, 90)
1654:             .BorderColor   = RGB(100, 100, 100)
1655:             .Visible       = .T.
1656:         ENDWITH
1657: 
1658:         *-- Label % (Venda Consumidor)
1659:         loc_oPag1.AddObject("lbl_4c_Label13", "Label")
1660:         WITH loc_oPag1.lbl_4c_Label13
1661:             .Caption   = "%"
1662:             .Top       = 207
1663:             .Left      = 219
1664:             .Width     = 13
1665:             .Height    = 15
1666:             .FontName  = "Tahoma"
1667:             .FontSize  = 8
1668:             .BackStyle = 0
1669:             .ForeColor = RGB(90, 90, 90)
1670:             .Visible   = .T.
1671:         ENDWITH
1672: 
1673:         *-- Label Mot Desoneracao ICMS
1674:         loc_oPag1.AddObject("lbl_4c_Label50", "Label")
1675:         WITH loc_oPag1.lbl_4c_Label50
1676:             .Caption   = "Mot Desonera" + CHR(231) + CHR(227) + "o ICMS :"
1677:             .Top       = 206
1678:             .Left      = 256
1679:             .Width     = 121
1680:             .Height    = 15
1681:             .FontName  = "Tahoma"
1682:             .FontSize  = 8
1683:             .BackStyle = 0
1684:             .ForeColor = RGB(90, 90, 90)
1685:             .Visible   = .T.
1686:         ENDWITH
1687: 
1688:         *-- TextBox Motivo Desoneracao ICMS (2 chars numericos)
1689:         loc_oPag1.AddObject("txt_4c_MotDeson", "TextBox")
1690:         WITH loc_oPag1.txt_4c_MotDeson
1691:             .Top           = 203
1692:             .Left          = 381
1693:             .Width         = 26
1694:             .Height        = 23
1695:             .FontName      = "Tahoma"
1696:             .FontSize      = 8
1697:             .InputMask     = "99"

*-- Linhas 1703 a 1729:
1703:         ENDWITH
1704: 
1705:         *-- Label Inibe Valor Unitario
1706:         loc_oPag1.AddObject("lbl_4c_Label21", "Label")
1707:         WITH loc_oPag1.lbl_4c_Label21
1708:             .Caption   = "Inibe Valor Unit" + CHR(225) + "rio na NF Importa" + CHR(231) + CHR(227) + "o :"
1709:             .Top       = 210
1710:             .Left      = 652
1711:             .Width     = 228
1712:             .Height    = 15
1713:             .FontName  = "Tahoma"
1714:             .FontSize  = 8
1715:             .BackStyle = 0
1716:             .ForeColor = RGB(90, 90, 90)
1717:             .Visible   = .T.
1718:         ENDWITH
1719: 
1720:         *-- Combo Inibe Valor Unitario NF Importacao (S=Sim, N=Nao)
1721:         loc_oPag1.AddObject("cbo_4c_Combo9", "ComboBox")
1722:         WITH loc_oPag1.cbo_4c_Combo9
1723:             .Top           = 206
1724:             .Left          = 887
1725:             .Width         = 82
1726:             .Height        = 23
1727:             .FontName      = "Tahoma"
1728:             .FontSize      = 8
1729:             .RowSourceType = 1

*-- Linhas 1752 a 1775:
1752:         *-- Linha separadora shp03 (top=236)
1753:         loc_oPag1.AddObject("shp_4c_Shp03", "Shape")
1754:         WITH loc_oPag1.shp_4c_Shp03
1755:             .Top         = 236
1756:             .Left        = 3
1757:             .Width       = 984
1758:             .Height      = 1
1759:             .BackStyle   = 1
1760:             .BackColor   = RGB(180, 180, 180)
1761:             .BorderStyle = 0
1762:             .Visible     = .T.
1763:         ENDWITH
1764: 
1765:         *-- Label "Especificacoes Para NF-e" (bold Verdana, top=246)
1766:         loc_oPag1.AddObject("lbl_4c_Label38", "Label")
1767:         WITH loc_oPag1.lbl_4c_Label38
1768:             .Caption   = "Especifica" + CHR(231) + CHR(245) + "es Para NF-e"
1769:             .Top       = 246
1770:             .Left      = 498
1771:             .Width     = 167
1772:             .Height    = 15
1773:             .FontName  = "Verdana"
1774:             .FontSize  = 8
1775:             .FontBold  = .T.

*-- Linhas 1783 a 1809:
1783:         *----------------------------------------------------------------------
1784: 
1785:         *-- Label IPI
1786:         loc_oPag1.AddObject("lbl_4c_Label8", "Label")
1787:         WITH loc_oPag1.lbl_4c_Label8
1788:             .Caption   = "I P I :"
1789:             .Top       = 267
1790:             .Left      = 104
1791:             .Width     = 29
1792:             .Height    = 15
1793:             .FontName  = "Tahoma"
1794:             .FontSize  = 8
1795:             .BackStyle = 0
1796:             .ForeColor = RGB(90, 90, 90)
1797:             .Visible   = .T.
1798:         ENDWITH
1799: 
1800:         *-- Combo IPI (T=Tributado, I=Isento, O=Outros)
1801:         loc_oPag1.AddObject("cbo_4c_CmbIpi", "ComboBox")
1802:         WITH loc_oPag1.cbo_4c_CmbIpi
1803:             .Top           = 263
1804:             .Left          = 136
1805:             .Width         = 82
1806:             .Height        = 23
1807:             .FontName      = "Tahoma"
1808:             .FontSize      = 8
1809:             .RowSourceType = 1

*-- Linhas 1816 a 1842:
1816:         ENDWITH
1817: 
1818:         *-- Label IPI Importacao
1819:         loc_oPag1.AddObject("lbl_4c_Label7", "Label")
1820:         WITH loc_oPag1.lbl_4c_Label7
1821:             .Caption   = "IPI Importa" + CHR(231) + CHR(227) + "o :"
1822:             .Top       = 267
1823:             .Left      = 296
1824:             .Width     = 81
1825:             .Height    = 15
1826:             .FontName  = "Tahoma"
1827:             .FontSize  = 8
1828:             .BackStyle = 0
1829:             .ForeColor = RGB(90, 90, 90)
1830:             .Visible   = .T.
1831:         ENDWITH
1832: 
1833:         *-- Combo IPI Importacao - Retira IPI do $ (ipiimpors: S=Sim/N=Nao)
1834:         loc_oPag1.AddObject("cbo_4c_CmbIpiI", "ComboBox")
1835:         WITH loc_oPag1.cbo_4c_CmbIpiI
1836:             .Top           = 263
1837:             .Left          = 380
1838:             .Width         = 82
1839:             .Height        = 23
1840:             .FontName      = "Tahoma"
1841:             .FontSize      = 8
1842:             .RowSourceType = 1

*-- Linhas 1849 a 1937:
1849:         ENDWITH
1850: 
1851:         *-- Label Destaca ICMS na NF (S/N)
1852:         loc_oPag1.AddObject("lbl_4c_Label27", "Label")
1853:         WITH loc_oPag1.lbl_4c_Label27
1854:             .Caption   = "Destaca ICMS na Nota Fiscal (S/N) :"
1855:             .Top       = 270
1856:             .Left      = 769
1857:             .Width     = 174
1858:             .Height    = 15
1859:             .FontName  = "Tahoma"
1860:             .FontSize  = 8
1861:             .BackStyle = 0
1862:             .ForeColor = RGB(90, 90, 90)
1863:             .Visible   = .T.
1864:         ENDWITH
1865: 
1866:         *-- TextBox Destaca ICMS na NF (cgergia1s, 1 char S/N)
1867:         loc_oPag1.AddObject("txt_4c_Gergia1", "TextBox")
1868:         WITH loc_oPag1.txt_4c_Gergia1
1869:             .Top           = 265
1870:             .Left          = 948
1871:             .Width         = 20
1872:             .Height        = 23
1873:             .FontName      = "Tahoma"
1874:             .FontSize      = 8
1875:             .MaxLength     = 1
1876:             .SpecialEffect = 1
1877:             .ForeColor     = RGB(90, 90, 90)
1878:             .BorderColor   = RGB(100, 100, 100)
1879:             .Visible       = .T.
1880:         ENDWITH
1881: 
1882:         *-- Label Aliquota IPI
1883:         loc_oPag1.AddObject("lbl_4c_Label15", "Label")
1884:         WITH loc_oPag1.lbl_4c_Label15
1885:             .Caption   = "Al" + CHR(237) + "quota :"
1886:             .Top       = 293
1887:             .Left      = 85
1888:             .Width     = 48
1889:             .Height    = 15
1890:             .FontName  = "Tahoma"
1891:             .FontSize  = 8
1892:             .BackStyle = 0
1893:             .ForeColor = RGB(90, 90, 90)
1894:             .Visible   = .T.
1895:         ENDWITH
1896: 
1897:         *-- TextBox Aliquota IPI (aliqipis, 99.99)
1898:         loc_oPag1.AddObject("txt_4c_Aliqs", "TextBox")
1899:         WITH loc_oPag1.txt_4c_Aliqs
1900:             .Top           = 289
1901:             .Left          = 136
1902:             .Width         = 82
1903:             .Height        = 23
1904:             .FontName      = "Tahoma"
1905:             .FontSize      = 8
1906:             .InputMask     = "99.99"
1907:             .SpecialEffect = 1
1908:             .ForeColor     = RGB(90, 90, 90)
1909:             .BorderColor   = RGB(100, 100, 100)
1910:             .Visible       = .T.
1911:         ENDWITH
1912: 
1913:         *-- Label Retira IPI do $
1914:         loc_oPag1.AddObject("lbl_4c_Label32", "Label")
1915:         WITH loc_oPag1.lbl_4c_Label32
1916:             .Caption   = "Retira IPI do $ :"
1917:             .Top       = 293
1918:             .Left      = 298
1919:             .Width     = 79
1920:             .Height    = 15
1921:             .FontName  = "Tahoma"
1922:             .FontSize  = 8
1923:             .BackStyle = 0
1924:             .ForeColor = RGB(90, 90, 90)
1925:             .Visible   = .T.
1926:         ENDWITH
1927: 
1928:         *-- Combo Inclui IPI na Base (inclipis, Sim/Nao -> numeric ListIndex)
1929:         loc_oPag1.AddObject("cbo_4c_Combo7", "ComboBox")
1930:         WITH loc_oPag1.cbo_4c_Combo7
1931:             .Top           = 289
1932:             .Left          = 380
1933:             .Width         = 82
1934:             .Height        = 23
1935:             .FontName      = "Tahoma"
1936:             .FontSize      = 8
1937:             .RowSourceType = 1

*-- Linhas 1944 a 1970:
1944:         ENDWITH
1945: 
1946:         *-- Label Nao Creditado
1947:         loc_oPag1.AddObject("lbl_4c_Label20", "Label")
1948:         WITH loc_oPag1.lbl_4c_Label20
1949:             .Caption   = "N" + CHR(227) + "o Creditado :"
1950:             .Top       = 319
1951:             .Left      = 55
1952:             .Width     = 78
1953:             .Height    = 15
1954:             .FontName  = "Tahoma"
1955:             .FontSize  = 8
1956:             .BackStyle = 0
1957:             .ForeColor = RGB(90, 90, 90)
1958:             .Visible   = .T.
1959:         ENDWITH
1960: 
1961:         *-- Combo Nao Creditado (ipincreds, Sim/Nao -> numeric ListIndex)
1962:         loc_oPag1.AddObject("cbo_4c_Combo1", "ComboBox")
1963:         WITH loc_oPag1.cbo_4c_Combo1
1964:             .Top           = 315
1965:             .Left          = 136
1966:             .Width         = 82
1967:             .Height        = 23
1968:             .FontName      = "Tahoma"
1969:             .FontSize      = 8
1970:             .RowSourceType = 1

*-- Linhas 1977 a 2003:
1977:         ENDWITH
1978: 
1979:         *-- Label Acres/Desc na Base
1980:         loc_oPag1.AddObject("lbl_4c_Label17", "Label")
1981:         WITH loc_oPag1.lbl_4c_Label17
1982:             .Caption   = "Acres/Desc na Base :"
1983:             .Top       = 319
1984:             .Left      = 273
1985:             .Width     = 104
1986:             .Height    = 15
1987:             .FontName  = "Tahoma"
1988:             .FontSize  = 8
1989:             .BackStyle = 0
1990:             .ForeColor = RGB(90, 90, 90)
1991:             .Visible   = .T.
1992:         ENDWITH
1993: 
1994:         *-- Combo Acres/Desc na Base (acresipis, S=Sim/N=Nao -> char)
1995:         loc_oPag1.AddObject("cbo_4c_Combo2", "ComboBox")
1996:         WITH loc_oPag1.cbo_4c_Combo2
1997:             .Top           = 315
1998:             .Left          = 380
1999:             .Width         = 82
2000:             .Height        = 23
2001:             .FontName      = "Tahoma"
2002:             .FontSize      = 8
2003:             .RowSourceType = 1

*-- Linhas 2010 a 2036:
2010:         ENDWITH
2011: 
2012:         *-- Label Base de Calculo IPI
2013:         loc_oPag1.AddObject("lbl_4c_Label5", "Label")
2014:         WITH loc_oPag1.lbl_4c_Label5
2015:             .Caption   = "Base de C" + CHR(225) + "lculo :"
2016:             .Top       = 345
2017:             .Left      = 49
2018:             .Width     = 84
2019:             .Height    = 15
2020:             .FontName  = "Tahoma"
2021:             .FontSize  = 8
2022:             .BackStyle = 0
2023:             .ForeColor = RGB(90, 90, 90)
2024:             .Visible   = .T.
2025:         ENDWITH
2026: 
2027:         *-- Combo Base Calculo IPI (bcipis -> F/P/B/V/G/M)
2028:         loc_oPag1.AddObject("cbo_4c_CmbBIPI", "ComboBox")
2029:         WITH loc_oPag1.cbo_4c_CmbBIPI
2030:             .Top           = 341
2031:             .Left          = 136
2032:             .Width         = 196
2033:             .Height        = 24
2034:             .FontName      = "Tahoma"
2035:             .FontSize      = 8
2036:             .RowSourceType = 1

*-- Linhas 2045 a 2071:
2045:         *-- TextBox % Base Calculo IPI (pbcipis, 999.99)
2046:         loc_oPag1.AddObject("txt_4c_BcIPI", "TextBox")
2047:         WITH loc_oPag1.txt_4c_BcIPI
2048:             .Top           = 341
2049:             .Left          = 380
2050:             .Width         = 82
2051:             .Height        = 23
2052:             .FontName      = "Tahoma"
2053:             .FontSize      = 8
2054:             .InputMask     = "999.99"
2055:             .SpecialEffect = 1
2056:             .ForeColor     = RGB(90, 90, 90)
2057:             .BorderColor   = RGB(100, 100, 100)
2058:             .Visible       = .T.
2059:         ENDWITH
2060: 
2061:         *-- Label Calcula IPI Importacao Origem Mercadoria=2
2062:         loc_oPag1.AddObject("lbl_4c_Label18", "Label")
2063:         WITH loc_oPag1.lbl_4c_Label18
2064:             .Caption   = "Calcula IPI Importa" + CHR(231) + CHR(227) + "o Para Origem Mercadoria=2 :"
2065:             .Top       = 371
2066:             .Left      = 77
2067:             .Width     = 250
2068:             .Height    = 15
2069:             .FontName  = "Tahoma"
2070:             .FontSize  = 8
2071:             .BackStyle = 0

*-- Linhas 2077 a 2086:
2077:         *-- Habilitado apenas se cmbIpiI = Sim
2078:         loc_oPag1.AddObject("cbo_4c_Combo8", "ComboBox")
2079:         WITH loc_oPag1.cbo_4c_Combo8
2080:             .Top           = 367
2081:             .Left          = 380
2082:             .Width         = 82
2083:             .Height        = 23
2084:             .FontName      = "Tahoma"
2085:             .FontSize      = 8
2086:             .RowSourceType = 1

*-- Linhas 2094 a 2157:
2094:         ENDWITH
2095: 
2096:         *-- Label IPI Sobre
2097:         loc_oPag1.AddObject("lbl_4c_Label16", "Label")
2098:         WITH loc_oPag1.lbl_4c_Label16
2099:             .Caption   = "IPI Sobre :"
2100:             .Top       = 395
2101:             .Left      = 69
2102:             .Width     = 54
2103:             .Height    = 15
2104:             .FontName  = "Tahoma"
2105:             .FontSize  = 8
2106:             .BackStyle = 0
2107:             .ForeColor = RGB(90, 90, 90)
2108:             .Visible   = .T.
2109:         ENDWITH
2110: 
2111:         *-- CheckBox Frete IPI
2112:         loc_oPag1.AddObject("chk_4c_ObjFreteIPI", "CheckBox")
2113:         WITH loc_oPag1.chk_4c_ObjFreteIPI
2114:             .Caption       = "Frete"
2115:             .Top           = 395
2116:             .Left          = 137
2117:             .Width         = 44
2118:             .Height        = 15
2119:             .FontName      = "Tahoma"
2120:             .FontSize      = 8
2121:             .BackStyle     = 0
2122:             .ForeColor     = RGB(90, 90, 90)
2123:             .SpecialEffect = 1
2124:             .AutoSize      = .T.
2125:             .Alignment     = 0
2126:             .Visible       = .T.
2127:         ENDWITH
2128: 
2129:         *-- CheckBox Seguro IPI
2130:         loc_oPag1.AddObject("chk_4c_ObjSegIPI", "CheckBox")
2131:         WITH loc_oPag1.chk_4c_ObjSegIPI
2132:             .Caption       = "Seguro"
2133:             .Top           = 395
2134:             .Left          = 188
2135:             .Width         = 52
2136:             .Height        = 15
2137:             .FontName      = "Tahoma"
2138:             .FontSize      = 8
2139:             .BackStyle     = 0
2140:             .ForeColor     = RGB(90, 90, 90)
2141:             .SpecialEffect = 1
2142:             .AutoSize      = .T.
2143:             .Alignment     = 0
2144:             .Visible       = .T.
2145:         ENDWITH
2146: 
2147:         *-- CheckBox Despesas Acessorias IPI
2148:         loc_oPag1.AddObject("chk_4c_ObjDespIPI", "CheckBox")
2149:         WITH loc_oPag1.chk_4c_ObjDespIPI
2150:             .Caption       = "Despesas Acess" + CHR(243) + "rias"
2151:             .Top           = 395
2152:             .Left          = 255
2153:             .Width         = 118
2154:             .Height        = 15
2155:             .FontName      = "Tahoma"
2156:             .FontSize      = 8
2157:             .BackStyle     = 0

*-- Linhas 2167 a 2193:
2167:         *----------------------------------------------------------------------
2168: 
2169:         *-- Label Codigo IPI Sit. Tributaria
2170:         loc_oPag1.AddObject("lbl_4c_Label30", "Label")
2171:         WITH loc_oPag1.lbl_4c_Label30
2172:             .Caption   = "C" + CHR(243) + "digo IPI Sit. Trib.:"
2173:             .Top       = 269
2174:             .Left      = 589
2175:             .Width     = 100
2176:             .Height    = 15
2177:             .FontName  = "Tahoma"
2178:             .FontSize  = 8
2179:             .BackStyle = 0
2180:             .ForeColor = RGB(90, 90, 90)
2181:             .Visible   = .T.
2182:         ENDWITH
2183: 
2184:         *-- TextBox Codigo IPI Sit. Tributaria (ipicst, 2 chars)
2185:         loc_oPag1.AddObject("txt_4c_IPICST", "TextBox")
2186:         WITH loc_oPag1.txt_4c_IPICST
2187:             .Top           = 266
2188:             .Left          = 691
2189:             .Width         = 26
2190:             .Height        = 23
2191:             .FontName      = "Tahoma"
2192:             .FontSize      = 8
2193:             .InputMask     = "99"

*-- Linhas 2199 a 2225:
2199:         ENDWITH
2200: 
2201:         *-- Label Codigo PIS Sit. Tributaria
2202:         loc_oPag1.AddObject("lbl_4c_Label33", "Label")
2203:         WITH loc_oPag1.lbl_4c_Label33
2204:             .Caption   = "C" + CHR(243) + "digo PIS Sit. Trib.:"
2205:             .Top       = 295
2206:             .Left      = 587
2207:             .Width     = 102
2208:             .Height    = 15
2209:             .FontName  = "Tahoma"
2210:             .FontSize  = 8
2211:             .BackStyle = 0
2212:             .ForeColor = RGB(90, 90, 90)
2213:             .Visible   = .T.
2214:         ENDWITH
2215: 
2216:         *-- TextBox Codigo PIS Sit. Tributaria (piscst, 2 chars)
2217:         loc_oPag1.AddObject("txt_4c_PISCST", "TextBox")
2218:         WITH loc_oPag1.txt_4c_PISCST
2219:             .Top           = 291
2220:             .Left          = 691
2221:             .Width         = 26
2222:             .Height        = 23
2223:             .FontName      = "Tahoma"
2224:             .FontSize      = 8
2225:             .InputMask     = "99"

*-- Linhas 2231 a 2257:
2231:         ENDWITH
2232: 
2233:         *-- Label Codigo COFINS Sit. Tributaria
2234:         loc_oPag1.AddObject("lbl_4c_Label34", "Label")
2235:         WITH loc_oPag1.lbl_4c_Label34
2236:             .Caption   = "C" + CHR(243) + "digo COFINS Sit. Trib.:"
2237:             .Top       = 319
2238:             .Left      = 565
2239:             .Width     = 124
2240:             .Height    = 15
2241:             .FontName  = "Tahoma"
2242:             .FontSize  = 8
2243:             .BackStyle = 0
2244:             .ForeColor = RGB(90, 90, 90)
2245:             .Visible   = .T.
2246:         ENDWITH
2247: 
2248:         *-- TextBox Codigo COFINS Sit. Tributaria (cofcst, 2 chars)
2249:         loc_oPag1.AddObject("txt_4c_COFCST", "TextBox")
2250:         WITH loc_oPag1.txt_4c_COFCST
2251:             .Top           = 315
2252:             .Left          = 691
2253:             .Width         = 26
2254:             .Height        = 23
2255:             .FontName      = "Tahoma"
2256:             .FontSize      = 8
2257:             .InputMask     = "99"

*-- Linhas 2263 a 2289:
2263:         ENDWITH
2264: 
2265:         *-- Label Codigo ISSQN Lista Servicos
2266:         loc_oPag1.AddObject("lbl_4c_Label35", "Label")
2267:         WITH loc_oPag1.lbl_4c_Label35
2268:             .Caption   = "C" + CHR(243) + "digo ISSQN Lista Serv.:"
2269:             .Top       = 343
2270:             .Left      = 562
2271:             .Width     = 127
2272:             .Height    = 15
2273:             .FontName  = "Tahoma"
2274:             .FontSize  = 8
2275:             .BackStyle = 0
2276:             .ForeColor = RGB(90, 90, 90)
2277:             .Visible   = .T.
2278:         ENDWITH
2279: 
2280:         *-- TextBox Codigo ISSQN Lista Servicos (issqnl, 5 chars)
2281:         loc_oPag1.AddObject("txt_4c_ISSQNL", "TextBox")
2282:         WITH loc_oPag1.txt_4c_ISSQNL
2283:             .Top           = 339
2284:             .Left          = 691
2285:             .Width         = 42
2286:             .Height        = 23
2287:             .FontName      = "Tahoma"
2288:             .FontSize      = 8
2289:             .InputMask     = "XXXXX"

*-- Linhas 2295 a 2632:
2295:         ENDWITH
2296: 
2297:         *-- Label Codigo Enquadramento IPI
2298:         loc_oPag1.AddObject("lbl_4c_Label9", "Label")
2299:         WITH loc_oPag1.lbl_4c_Label9
2300:             .Caption   = "C" + CHR(243) + "digo Enquadramento IPI:"
2301:             .Top       = 366
2302:             .Left      = 554
2303:             .Width     = 135
2304:             .Height    = 15
2305:             .FontName  = "Tahoma"
2306:             .FontSize  = 8
2307:             .BackStyle = 0
2308:             .ForeColor = RGB(90, 90, 90)
2309:             .Visible   = .T.
2310:         ENDWITH
2311: 
2312:         *-- TextBox Codigo Enquadramento IPI (ipienq, 3 chars)
2313:         loc_oPag1.AddObject("txt_4c_IPIEnq", "TextBox")
2314:         WITH loc_oPag1.txt_4c_IPIEnq
2315:             .Top           = 363
2316:             .Left          = 691
2317:             .Width         = 26
2318:             .Height        = 23
2319:             .FontName      = "Tahoma"
2320:             .FontSize      = 8
2321:             .MaxLength     = 3
2322:             .SpecialEffect = 1
2323:             .ForeColor     = RGB(90, 90, 90)
2324:             .BorderColor   = RGB(100, 100, 100)
2325:             .Visible       = .T.
2326:         ENDWITH
2327: 
2328:         *-- Label Aliquota do PIS
2329:         loc_oPag1.AddObject("lbl_4c_Label39", "Label")
2330:         WITH loc_oPag1.lbl_4c_Label39
2331:             .Caption   = "Al" + CHR(237) + "quota do PIS :"
2332:             .Top       = 295
2333:             .Left      = 827
2334:             .Width     = 82
2335:             .Height    = 15
2336:             .FontName  = "Verdana"
2337:             .FontSize  = 8
2338:             .BackStyle = 0
2339:             .ForeColor = RGB(90, 90, 90)
2340:             .Visible   = .T.
2341:         ENDWITH
2342: 
2343:         *-- TextBox Aliquota do PIS (aliqpis, 999.99)
2344:         loc_oPag1.AddObject("txt_4c_AliqPIS", "TextBox")
2345:         WITH loc_oPag1.txt_4c_AliqPIS
2346:             .Top           = 291
2347:             .Left          = 916
2348:             .Width         = 52
2349:             .Height        = 23
2350:             .FontName      = "Tahoma"
2351:             .FontSize      = 8
2352:             .InputMask     = "999.99"
2353:             .SpecialEffect = 1
2354:             .ForeColor     = RGB(90, 90, 90)
2355:             .BorderColor   = RGB(100, 100, 100)
2356:             .Visible       = .T.
2357:         ENDWITH
2358: 
2359:         *-- Label % (PIS)
2360:         loc_oPag1.AddObject("lbl_4c_Label40", "Label")
2361:         WITH loc_oPag1.lbl_4c_Label40
2362:             .Caption   = "%"
2363:             .Top       = 295
2364:             .Left      = 971
2365:             .Width     = 14
2366:             .Height    = 15
2367:             .FontName  = "Verdana"
2368:             .FontSize  = 8
2369:             .BackStyle = 0
2370:             .ForeColor = RGB(224, 235, 235)
2371:             .Visible   = .T.
2372:         ENDWITH
2373: 
2374:         *-- Label Aliquota do COFINS
2375:         loc_oPag1.AddObject("lbl_4c_Label41", "Label")
2376:         WITH loc_oPag1.lbl_4c_Label41
2377:             .Caption   = "Al" + CHR(237) + "quota do COFINS :"
2378:             .Top       = 319
2379:             .Left      = 785
2380:             .Width     = 124
2381:             .Height    = 15
2382:             .FontName  = "Verdana"
2383:             .FontSize  = 8
2384:             .BackStyle = 0
2385:             .ForeColor = RGB(90, 90, 90)
2386:             .Visible   = .T.
2387:         ENDWITH
2388: 
2389:         *-- TextBox Aliquota do COFINS (aliqcofins, 999.99)
2390:         loc_oPag1.AddObject("txt_4c_AliqCofins", "TextBox")
2391:         WITH loc_oPag1.txt_4c_AliqCofins
2392:             .Top           = 315
2393:             .Left          = 916
2394:             .Width         = 52
2395:             .Height        = 23
2396:             .FontName      = "Tahoma"
2397:             .FontSize      = 8
2398:             .InputMask     = "999.99"
2399:             .SpecialEffect = 1
2400:             .ForeColor     = RGB(90, 90, 90)
2401:             .BorderColor   = RGB(100, 100, 100)
2402:             .Visible       = .T.
2403:         ENDWITH
2404: 
2405:         *-- Label % (COFINS)
2406:         loc_oPag1.AddObject("lbl_4c_Label42", "Label")
2407:         WITH loc_oPag1.lbl_4c_Label42
2408:             .Caption   = "%"
2409:             .Top       = 319
2410:             .Left      = 971
2411:             .Width     = 14
2412:             .Height    = 15
2413:             .FontName  = "Verdana"
2414:             .FontSize  = 8
2415:             .BackStyle = 0
2416:             .ForeColor = RGB(224, 235, 235)
2417:             .Visible   = .T.
2418:         ENDWITH
2419: 
2420:         *-- Label Aliquota do ISSQN
2421:         loc_oPag1.AddObject("lbl_4c_Label44", "Label")
2422:         WITH loc_oPag1.lbl_4c_Label44
2423:             .Caption   = "Al" + CHR(237) + "quota do ISSQN :"
2424:             .Top       = 343
2425:             .Left      = 792
2426:             .Width     = 117
2427:             .Height    = 15
2428:             .FontName  = "Verdana"
2429:             .FontSize  = 8
2430:             .BackStyle = 0
2431:             .ForeColor = RGB(90, 90, 90)
2432:             .Visible   = .T.
2433:         ENDWITH
2434: 
2435:         *-- TextBox Aliquota do ISSQN (aliqissqn, 999.99)
2436:         loc_oPag1.AddObject("txt_4c_AliqISSQN", "TextBox")
2437:         WITH loc_oPag1.txt_4c_AliqISSQN
2438:             .Top           = 339
2439:             .Left          = 916
2440:             .Width         = 52
2441:             .Height        = 23
2442:             .FontName      = "Tahoma"
2443:             .FontSize      = 8
2444:             .InputMask     = "999.99"
2445:             .SpecialEffect = 1
2446:             .ForeColor     = RGB(90, 90, 90)
2447:             .BorderColor   = RGB(100, 100, 100)
2448:             .Visible       = .T.
2449:         ENDWITH
2450: 
2451:         *-- Label % (ISSQN)
2452:         loc_oPag1.AddObject("lbl_4c_Label45", "Label")
2453:         WITH loc_oPag1.lbl_4c_Label45
2454:             .Caption   = "%"
2455:             .Top       = 343
2456:             .Left      = 971
2457:             .Width     = 14
2458:             .Height    = 15
2459:             .FontName  = "Verdana"
2460:             .FontSize  = 8
2461:             .BackStyle = 0
2462:             .ForeColor = RGB(224, 235, 235)
2463:             .Visible   = .T.
2464:         ENDWITH
2465: 
2466:         *-- Label Codigo de Tributacao do ISSQN
2467:         loc_oPag1.AddObject("lbl_4c_Label43", "Label")
2468:         WITH loc_oPag1.lbl_4c_Label43
2469:             .Caption   = "C" + CHR(243) + "digo de Trib. do ISSQN:"
2470:             .Top       = 390
2471:             .Left      = 561
2472:             .Width     = 128
2473:             .Height    = 15
2474:             .FontName  = "Tahoma"
2475:             .FontSize  = 8
2476:             .BackStyle = 0
2477:             .ForeColor = RGB(90, 90, 90)
2478:             .Visible   = .T.
2479:         ENDWITH
2480: 
2481:         *-- OptionGroup Codigo Tributacao ISSQN (ctissqn, 5 botoes: Normal/Retida/Substituta/Isenta/Nao Calcula)
2482:         loc_oPag1.AddObject("obj_4c_Fwoption1", "OptionGroup")
2483:         WITH loc_oPag1.obj_4c_Fwoption1
2484:             .Top         = 389
2485:             .Left        = 686
2486:             .Width       = 297
2487:             .Height      = 34
2488:             .ButtonCount = 5
2489:             .BorderStyle = 0
2490:             .Visible     = .T.
2491:         ENDWITH
2492:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(1)
2493:             .Caption   = "Normal"
2494:             .Left      = 4
2495:             .Top       = 0
2496:             .Height    = 15
2497:             .AutoSize  = .T.
2498:             .FontName  = "Verdana"
2499:             .FontSize  = 8
2500:             .ForeColor = RGB(90, 90, 90)
2501:         ENDWITH
2502:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(2)
2503:             .Caption   = "Retida"
2504:             .Left      = 72
2505:             .Top       = 0
2506:             .Height    = 15
2507:             .AutoSize  = .T.
2508:             .FontName  = "Verdana"
2509:             .FontSize  = 8
2510:             .ForeColor = RGB(90, 90, 90)
2511:         ENDWITH
2512:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(3)
2513:             .Caption   = "Substituta"
2514:             .Left      = 135
2515:             .Top       = 1
2516:             .Width     = 76
2517:             .Height    = 15
2518:             .AutoSize  = .T.
2519:             .FontName  = "Verdana"
2520:             .FontSize  = 8
2521:             .ForeColor = RGB(90, 90, 90)
2522:         ENDWITH
2523:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(4)
2524:             .Caption   = "Isenta"
2525:             .Left      = 219
2526:             .Top       = 1
2527:             .Width     = 52
2528:             .Height    = 17
2529:             .AutoSize  = .T.
2530:             .ForeColor = RGB(90, 90, 90)
2531:         ENDWITH
2532:         WITH loc_oPag1.obj_4c_Fwoption1.Buttons(5)
2533:             .Caption   = "N" + CHR(227) + "o Calcula ISSQN"
2534:             .Left      = 4
2535:             .Top       = 17
2536:             .Width     = 129
2537:             .Height    = 15
2538:             .AutoSize  = .T.
2539:             .FontName  = "Verdana"
2540:             .FontSize  = 8
2541:             .ForeColor = RGB(90, 90, 90)
2542:         ENDWITH
2543: 
2544:         *-- Label Informa Retencao de Tributacao
2545:         loc_oPag1.AddObject("lbl_4c_Label46", "Label")
2546:         WITH loc_oPag1.lbl_4c_Label46
2547:             .Caption   = "Informa Reten" + CHR(231) + CHR(227) + "o de Trib.:"
2548:             .Top       = 425
2549:             .Left      = 556
2550:             .Width     = 133
2551:             .Height    = 15
2552:             .FontName  = "Tahoma"
2553:             .FontSize  = 8
2554:             .BackStyle = 0
2555:             .ForeColor = RGB(90, 90, 90)
2556:             .Visible   = .T.
2557:         ENDWITH
2558: 
2559:         *-- OptionGroup Informa Retencao de Tributacao (rettribs, 2 botoes: Sim/Nao)
2560:         loc_oPag1.AddObject("obj_4c_Fwoption2", "OptionGroup")
2561:         WITH loc_oPag1.obj_4c_Fwoption2
2562:             .Top         = 420
2563:             .Left        = 686
2564:             .Width       = 95
2565:             .Height      = 25
2566:             .ButtonCount = 2
2567:             .BorderStyle = 0
2568:             .Visible     = .T.
2569:         ENDWITH
2570:         WITH loc_oPag1.obj_4c_Fwoption2.Buttons(1)
2571:             .Caption   = "Sim"
2572:             .Left      = 5
2573:             .Top       = 5
2574:             .Height    = 15
2575:             .AutoSize  = .T.
2576:             .FontName  = "Tahoma"
2577:             .FontSize  = 8
2578:             .ForeColor = RGB(90, 90, 90)
2579:         ENDWITH
2580:         WITH loc_oPag1.obj_4c_Fwoption2.Buttons(2)
2581:             .Caption   = "N" + CHR(227) + "o"
2582:             .Left      = 53
2583:             .Top       = 5
2584:             .Height    = 15
2585:             .AutoSize  = .T.
2586:             .FontName  = "Tahoma"
2587:             .FontSize  = 8
2588:             .ForeColor = RGB(90, 90, 90)
2589:         ENDWITH
2590: 
2591:         *-- Label Aliquota do II
2592:         loc_oPag1.AddObject("lbl_4c_Label47", "Label")
2593:         WITH loc_oPag1.lbl_4c_Label47
2594:             .Caption   = "Al" + CHR(237) + "quota do II :"
2595:             .Top       = 425
2596:             .Left      = 820
2597:             .Width     = 89
2598:             .Height    = 15
2599:             .FontName  = "Verdana"
2600:             .FontSize  = 8
2601:             .BackStyle = 0
2602:             .ForeColor = RGB(90, 90, 90)
2603:             .Visible   = .T.
2604:         ENDWITH
2605: 
2606:         *-- TextBox Aliquota do II (aliqii, 999.99)
2607:         loc_oPag1.AddObject("txt_4c_AliqII", "TextBox")
2608:         WITH loc_oPag1.txt_4c_AliqII
2609:             .Top           = 421
2610:             .Left          = 916
2611:             .Width         = 52
2612:             .Height        = 23
2613:             .FontName      = "Tahoma"
2614:             .FontSize      = 8
2615:             .InputMask     = "999.99"
2616:             .SpecialEffect = 1
2617:             .ForeColor     = RGB(90, 90, 90)
2618:             .BorderColor   = RGB(100, 100, 100)
2619:             .Visible       = .T.
2620:         ENDWITH
2621: 
2622:         *-- Label % (II)
2623:         loc_oPag1.AddObject("lbl_4c_Label48", "Label")
2624:         WITH loc_oPag1.lbl_4c_Label48
2625:             .Caption   = "%"
2626:             .Top       = 420
2627:             .Left      = 971
2628:             .Width     = 14
2629:             .Height    = 15
2630:             .FontName  = "Verdana"
2631:             .FontSize  = 8
2632:             .BackStyle = 0

*-- Linhas 2650 a 2722:
2650:         *----------------------------------------------------------------------
2651: 
2652:         *-- Label cabecalho secao Integracao Contabil
2653:         loc_oPag2.AddObject("lbl_4c_LblIntCont", "Label")
2654:         WITH loc_oPag2.lbl_4c_LblIntCont
2655:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
2656:             .Top       = 6
2657:             .Left      = 15
2658:             .Width     = 114
2659:             .Height    = 15
2660:             .FontName  = "Tahoma"
2661:             .FontSize  = 8
2662:             .FontBold  = .T.
2663:             .BackStyle = 0
2664:             .ForeColor = RGB(90, 90, 90)
2665:             .Visible   = .T.
2666:         ENDWITH
2667: 
2668:         *-- Label Valor Contabil
2669:         loc_oPag2.AddObject("lbl_4c_LblValorCont", "Label")
2670:         WITH loc_oPag2.lbl_4c_LblValorCont
2671:             .Caption   = "Valor Cont" + CHR(225) + "bil :"
2672:             .Top       = 34
2673:             .Left      = 84
2674:             .Width     = 75
2675:             .Height    = 15
2676:             .FontName  = "Tahoma"
2677:             .FontSize  = 8
2678:             .BackStyle = 0
2679:             .ForeColor = RGB(90, 90, 90)
2680:             .Visible   = .T.
2681:         ENDWITH
2682: 
2683:         *-- Label DB (Valor Contabil)
2684:         loc_oPag2.AddObject("lbl_4c_LblVcDB", "Label")
2685:         WITH loc_oPag2.lbl_4c_LblVcDB
2686:             .Caption   = "DB"
2687:             .Top       = 34
2688:             .Left      = 247
2689:             .Width     = 15
2690:             .Height    = 15
2691:             .FontName  = "Tahoma"
2692:             .FontSize  = 8
2693:             .BackStyle = 0
2694:             .ForeColor = RGB(90, 90, 90)
2695:             .Visible   = .T.
2696:         ENDWITH
2697: 
2698:         *-- Label CR (Valor Contabil)
2699:         loc_oPag2.AddObject("lbl_4c_LblVcCR", "Label")
2700:         WITH loc_oPag2.lbl_4c_LblVcCR
2701:             .Caption   = "CR"
2702:             .Top       = 34
2703:             .Left      = 344
2704:             .Width     = 16
2705:             .Height    = 15
2706:             .FontName  = "Tahoma"
2707:             .FontSize  = 8
2708:             .BackStyle = 0
2709:             .ForeColor = RGB(90, 90, 90)
2710:             .Visible   = .T.
2711:         ENDWITH
2712: 
2713:         *-- TextBox Valor Contabil DB (contvcds)
2714:         loc_oPag2.AddObject("txt_4c_Vrcds", "TextBox")
2715:         WITH loc_oPag2.txt_4c_Vrcds
2716:             .Top           = 30
2717:             .Left          = 162
2718:             .Width         = 73
2719:             .Height        = 24
2720:             .FontName      = "Tahoma"
2721:             .FontSize      = 8
2722:             .MaxLength     = 9

*-- Linhas 2729 a 2799:
2729:         *-- TextBox Valor Contabil CR (contvccs)
2730:         loc_oPag2.AddObject("txt_4c_Vrccs", "TextBox")
2731:         WITH loc_oPag2.txt_4c_Vrccs
2732:             .Top           = 30
2733:             .Left          = 265
2734:             .Width         = 73
2735:             .Height        = 24
2736:             .FontName      = "Tahoma"
2737:             .FontSize      = 8
2738:             .MaxLength     = 9
2739:             .SpecialEffect = 1
2740:             .ForeColor     = RGB(90, 90, 90)
2741:             .BorderColor   = RGB(100, 100, 100)
2742:             .Visible       = .T.
2743:         ENDWITH
2744: 
2745:         *-- Label IPI
2746:         loc_oPag2.AddObject("lbl_4c_LblIPI", "Label")
2747:         WITH loc_oPag2.lbl_4c_LblIPI
2748:             .Caption   = "IPI :"
2749:             .Top       = 60
2750:             .Left      = 136
2751:             .Width     = 23
2752:             .Height    = 15
2753:             .FontName  = "Tahoma"
2754:             .FontSize  = 8
2755:             .BackStyle = 0
2756:             .ForeColor = RGB(90, 90, 90)
2757:             .Visible   = .T.
2758:         ENDWITH
2759: 
2760:         *-- Label DB (IPI)
2761:         loc_oPag2.AddObject("lbl_4c_LblIpiDB", "Label")
2762:         WITH loc_oPag2.lbl_4c_LblIpiDB
2763:             .Caption   = "DB"
2764:             .Top       = 60
2765:             .Left      = 247
2766:             .Width     = 15
2767:             .Height    = 15
2768:             .FontName  = "Tahoma"
2769:             .FontSize  = 8
2770:             .BackStyle = 0
2771:             .ForeColor = RGB(90, 90, 90)
2772:             .Visible   = .T.
2773:         ENDWITH
2774: 
2775:         *-- Label CR (IPI)
2776:         loc_oPag2.AddObject("lbl_4c_LblIpiCR", "Label")
2777:         WITH loc_oPag2.lbl_4c_LblIpiCR
2778:             .Caption   = "CR"
2779:             .Top       = 60
2780:             .Left      = 344
2781:             .Width     = 16
2782:             .Height    = 15
2783:             .FontName  = "Tahoma"
2784:             .FontSize  = 8
2785:             .BackStyle = 0
2786:             .ForeColor = RGB(90, 90, 90)
2787:             .Visible   = .T.
2788:         ENDWITH
2789: 
2790:         *-- TextBox IPI DB (contipds)
2791:         loc_oPag2.AddObject("txt_4c_Ipids", "TextBox")
2792:         WITH loc_oPag2.txt_4c_Ipids
2793:             .Top           = 56
2794:             .Left          = 162
2795:             .Width         = 73
2796:             .Height        = 24
2797:             .FontName      = "Tahoma"
2798:             .FontSize      = 8
2799:             .MaxLength     = 9

*-- Linhas 2806 a 2876:
2806:         *-- TextBox IPI CR (contipcs)
2807:         loc_oPag2.AddObject("txt_4c_Ipics", "TextBox")
2808:         WITH loc_oPag2.txt_4c_Ipics
2809:             .Top           = 56
2810:             .Left          = 265
2811:             .Width         = 73
2812:             .Height        = 24
2813:             .FontName      = "Tahoma"
2814:             .FontSize      = 8
2815:             .MaxLength     = 9
2816:             .SpecialEffect = 1
2817:             .ForeColor     = RGB(90, 90, 90)
2818:             .BorderColor   = RGB(100, 100, 100)
2819:             .Visible       = .T.
2820:         ENDWITH
2821: 
2822:         *-- Label ICMS
2823:         loc_oPag2.AddObject("lbl_4c_LblICMS", "Label")
2824:         WITH loc_oPag2.lbl_4c_LblICMS
2825:             .Caption   = "ICMS :"
2826:             .Top       = 86
2827:             .Left      = 125
2828:             .Width     = 34
2829:             .Height    = 15
2830:             .FontName  = "Tahoma"
2831:             .FontSize  = 8
2832:             .BackStyle = 0
2833:             .ForeColor = RGB(90, 90, 90)
2834:             .Visible   = .T.
2835:         ENDWITH
2836: 
2837:         *-- Label DB (ICMS)
2838:         loc_oPag2.AddObject("lbl_4c_LblIcmDB", "Label")
2839:         WITH loc_oPag2.lbl_4c_LblIcmDB
2840:             .Caption   = "DB"
2841:             .Top       = 86
2842:             .Left      = 247
2843:             .Width     = 15
2844:             .Height    = 15
2845:             .FontName  = "Tahoma"
2846:             .FontSize  = 8
2847:             .BackStyle = 0
2848:             .ForeColor = RGB(90, 90, 90)
2849:             .Visible   = .T.
2850:         ENDWITH
2851: 
2852:         *-- Label CR (ICMS)
2853:         loc_oPag2.AddObject("lbl_4c_LblIcmCR", "Label")
2854:         WITH loc_oPag2.lbl_4c_LblIcmCR
2855:             .Caption   = "CR"
2856:             .Top       = 86
2857:             .Left      = 344
2858:             .Width     = 16
2859:             .Height    = 15
2860:             .FontName  = "Tahoma"
2861:             .FontSize  = 8
2862:             .BackStyle = 0
2863:             .ForeColor = RGB(90, 90, 90)
2864:             .Visible   = .T.
2865:         ENDWITH
2866: 
2867:         *-- TextBox ICMS DB (conticds)
2868:         loc_oPag2.AddObject("txt_4c_Icmds", "TextBox")
2869:         WITH loc_oPag2.txt_4c_Icmds
2870:             .Top           = 82
2871:             .Left          = 162
2872:             .Width         = 73
2873:             .Height        = 24
2874:             .FontName      = "Tahoma"
2875:             .FontSize      = 8
2876:             .MaxLength     = 9

*-- Linhas 2883 a 2985:
2883:         *-- TextBox ICMS CR (conticcs)
2884:         loc_oPag2.AddObject("txt_4c_Icmcs", "TextBox")
2885:         WITH loc_oPag2.txt_4c_Icmcs
2886:             .Top           = 82
2887:             .Left          = 265
2888:             .Width         = 73
2889:             .Height        = 24
2890:             .FontName      = "Tahoma"
2891:             .FontSize      = 8
2892:             .MaxLength     = 9
2893:             .SpecialEffect = 1
2894:             .ForeColor     = RGB(90, 90, 90)
2895:             .BorderColor   = RGB(100, 100, 100)
2896:             .Visible       = .T.
2897:         ENDWITH
2898: 
2899:         *-- Label Conta de Frete
2900:         loc_oPag2.AddObject("lbl_4c_LblContFrt", "Label")
2901:         WITH loc_oPag2.lbl_4c_LblContFrt
2902:             .Caption   = "Conta de Frete :"
2903:             .Top       = 112
2904:             .Left      = 77
2905:             .Width     = 82
2906:             .Height    = 15
2907:             .FontName  = "Tahoma"
2908:             .FontSize  = 8
2909:             .BackStyle = 0
2910:             .ForeColor = RGB(90, 90, 90)
2911:             .Visible   = .T.
2912:         ENDWITH
2913: 
2914:         *-- TextBox Conta de Frete (contfrt)
2915:         loc_oPag2.AddObject("txt_4c_ContFrt", "TextBox")
2916:         WITH loc_oPag2.txt_4c_ContFrt
2917:             .Top           = 108
2918:             .Left          = 162
2919:             .Width         = 73
2920:             .Height        = 24
2921:             .FontName      = "Tahoma"
2922:             .FontSize      = 8
2923:             .MaxLength     = 9
2924:             .SpecialEffect = 1
2925:             .ForeColor     = RGB(90, 90, 90)
2926:             .BorderColor   = RGB(100, 100, 100)
2927:             .Visible       = .T.
2928:         ENDWITH
2929: 
2930:         *-- Label Conta de Seguro
2931:         loc_oPag2.AddObject("lbl_4c_LblContSeg", "Label")
2932:         WITH loc_oPag2.lbl_4c_LblContSeg
2933:             .Caption   = "Conta de Seguro :"
2934:             .Top       = 138
2935:             .Left      = 69
2936:             .Width     = 90
2937:             .Height    = 15
2938:             .FontName  = "Tahoma"
2939:             .FontSize  = 8
2940:             .BackStyle = 0
2941:             .ForeColor = RGB(90, 90, 90)
2942:             .Visible   = .T.
2943:         ENDWITH
2944: 
2945:         *-- TextBox Conta de Seguro (contseg)
2946:         loc_oPag2.AddObject("txt_4c_ContSeg", "TextBox")
2947:         WITH loc_oPag2.txt_4c_ContSeg
2948:             .Top           = 134
2949:             .Left          = 162
2950:             .Width         = 73
2951:             .Height        = 24
2952:             .FontName      = "Tahoma"
2953:             .FontSize      = 8
2954:             .MaxLength     = 9
2955:             .SpecialEffect = 1
2956:             .ForeColor     = RGB(90, 90, 90)
2957:             .BorderColor   = RGB(100, 100, 100)
2958:             .Visible       = .T.
2959:         ENDWITH
2960: 
2961:         *-- Label Conta de Despesas
2962:         loc_oPag2.AddObject("lbl_4c_LblContDa", "Label")
2963:         WITH loc_oPag2.lbl_4c_LblContDa
2964:             .Caption   = "Conta de Despesas :"
2965:             .Top       = 164
2966:             .Left      = 57
2967:             .Width     = 102
2968:             .Height    = 15
2969:             .FontName  = "Tahoma"
2970:             .FontSize  = 8
2971:             .BackStyle = 0
2972:             .ForeColor = RGB(90, 90, 90)
2973:             .Visible   = .T.
2974:         ENDWITH
2975: 
2976:         *-- TextBox Conta de Despesas (contda)
2977:         loc_oPag2.AddObject("txt_4c_ContDa", "TextBox")
2978:         WITH loc_oPag2.txt_4c_ContDa
2979:             .Top           = 160
2980:             .Left          = 162
2981:             .Width         = 73
2982:             .Height        = 24
2983:             .FontName      = "Tahoma"
2984:             .FontSize      = 8
2985:             .MaxLength     = 9

*-- Linhas 2994 a 3020:
2994:         *----------------------------------------------------------------------
2995: 
2996:         *-- Label Descricao na Integracao
2997:         loc_oPag2.AddObject("lbl_4c_LblDescInteg", "Label")
2998:         WITH loc_oPag2.lbl_4c_LblDescInteg
2999:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o :"
3000:             .Top       = 31
3001:             .Left      = 490
3002:             .Width     = 151
3003:             .Height    = 15
3004:             .FontName  = "Tahoma"
3005:             .FontSize  = 8
3006:             .BackStyle = 0
3007:             .ForeColor = RGB(90, 90, 90)
3008:             .Visible   = .T.
3009:         ENDWITH
3010: 
3011:         *-- Combo Descricao na Integracao (pontedescs)
3012:         loc_oPag2.AddObject("cbo_4c_Combo2", "ComboBox")
3013:         WITH loc_oPag2.cbo_4c_Combo2
3014:             .Top           = 27
3015:             .Left          = 642
3016:             .Width         = 199
3017:             .Height        = 25
3018:             .FontName      = "Tahoma"
3019:             .FontSize      = 8
3020:             .RowSourceType = 1

*-- Linhas 3027 a 3053:
3027:         ENDWITH
3028: 
3029:         *-- Label Pega Conta Contabil da NF
3030:         loc_oPag2.AddObject("lbl_4c_LblCmbFixa", "Label")
3031:         WITH loc_oPag2.lbl_4c_LblCmbFixa
3032:             .Caption   = "Pega Conta Cont" + CHR(225) + "bil da NF :"
3033:             .Top       = 57
3034:             .Left      = 477
3035:             .Width     = 164
3036:             .Height    = 15
3037:             .FontName  = "Tahoma"
3038:             .FontSize  = 8
3039:             .BackStyle = 0
3040:             .ForeColor = RGB(90, 90, 90)
3041:             .Visible   = .T.
3042:         ENDWITH
3043: 
3044:         *-- Combo Pega Conta Contabil da NF (contconts: S=Sim(NF), N=Nao(CFOP), C=C.C.)
3045:         loc_oPag2.AddObject("cbo_4c_CmbFixa", "ComboBox")
3046:         WITH loc_oPag2.cbo_4c_CmbFixa
3047:             .Top           = 53
3048:             .Left          = 642
3049:             .Width         = 132
3050:             .Height        = 25
3051:             .FontName      = "Tahoma"
3052:             .FontSize      = 8
3053:             .RowSourceType = 1

*-- Linhas 3060 a 3072:
3060:         ENDWITH
3061: 
3062:         *-- Label Agrupa CFO na Integracao
3063:         loc_oPag2.AddObject("lbl_4c_LblAgrupas", "Label")
3064:         WITH loc_oPag2.lbl_4c_LblAgrupas
3065:             .Caption   = "Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o :"
3066:             .Top       = 84
3067:             .Left      = 477
3068:             .Width     = 164
3069:             .Height    = 15
3070:             .FontName  = "Tahoma"
3071:             .FontSize  = 8
3072:             .BackStyle = 0

*-- Linhas 3078 a 3123:
3078:         loc_oPag2.AddObject("obj_4c_OptAgrupas", "OptionGroup")
3079:         WITH loc_oPag2.obj_4c_OptAgrupas
3080:             .ButtonCount = 2
3081:             .Top         = 79
3082:             .Left        = 638
3083:             .Width       = 94
3084:             .Height      = 27
3085:             .BorderStyle = 0
3086:             .Visible     = .T.
3087:         ENDWITH
3088:         WITH loc_oPag2.obj_4c_OptAgrupas.Buttons(1)
3089:             .Caption   = "Sim"
3090:             .Left      = 5
3091:             .Top       = 5
3092:             .Width     = 40
3093:             .Height    = 17
3094:             .AutoSize  = .F.
3095:             .FontName  = "Tahoma"
3096:             .FontSize  = 8
3097:             .ForeColor = RGB(90, 90, 90)
3098:             .Themes    = .F.
3099:         ENDWITH
3100:         WITH loc_oPag2.obj_4c_OptAgrupas.Buttons(2)
3101:             .Caption   = "N" + CHR(227) + "o"
3102:             .Left      = 51
3103:             .Top       = 5
3104:             .Width     = 40
3105:             .Height    = 17
3106:             .AutoSize  = .F.
3107:             .FontName  = "Tahoma"
3108:             .FontSize  = 8
3109:             .ForeColor = RGB(90, 90, 90)
3110:             .Themes    = .F.
3111:         ENDWITH
3112: 
3113:         *-- Label Integracao Zerada
3114:         loc_oPag2.AddObject("lbl_4c_LblZeradas", "Label")
3115:         WITH loc_oPag2.lbl_4c_LblZeradas
3116:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
3117:             .Top       = 108
3118:             .Left      = 523
3119:             .Width     = 118
3120:             .Height    = 15
3121:             .FontName  = "Tahoma"
3122:             .FontSize  = 8
3123:             .BackStyle = 0

*-- Linhas 3129 a 3174:
3129:         loc_oPag2.AddObject("obj_4c_OptZeradas", "OptionGroup")
3130:         WITH loc_oPag2.obj_4c_OptZeradas
3131:             .ButtonCount = 2
3132:             .Top         = 103
3133:             .Left        = 638
3134:             .Width       = 94
3135:             .Height      = 27
3136:             .BorderStyle = 0
3137:             .Visible     = .T.
3138:         ENDWITH
3139:         WITH loc_oPag2.obj_4c_OptZeradas.Buttons(1)
3140:             .Caption   = "Sim"
3141:             .Left      = 5
3142:             .Top       = 5
3143:             .Width     = 40
3144:             .Height    = 17
3145:             .AutoSize  = .F.
3146:             .FontName  = "Tahoma"
3147:             .FontSize  = 8
3148:             .ForeColor = RGB(90, 90, 90)
3149:             .Themes    = .F.
3150:         ENDWITH
3151:         WITH loc_oPag2.obj_4c_OptZeradas.Buttons(2)
3152:             .Caption   = "N" + CHR(227) + "o"
3153:             .Left      = 51
3154:             .Top       = 5
3155:             .Width     = 40
3156:             .Height    = 17
3157:             .AutoSize  = .F.
3158:             .FontName  = "Tahoma"
3159:             .FontSize  = 8
3160:             .ForeColor = RGB(90, 90, 90)
3161:             .Themes    = .F.
3162:         ENDWITH
3163: 
3164:         *-- Label Data Lancamento Contabil
3165:         loc_oPag2.AddObject("lbl_4c_LblDtLanc", "Label")
3166:         WITH loc_oPag2.lbl_4c_LblDtLanc
3167:             .Caption   = "Data Lan" + CHR(231) + "amento Contabil :"
3168:             .Top       = 132
3169:             .Left      = 479
3170:             .Width     = 162
3171:             .Height    = 15
3172:             .FontName  = "Tahoma"
3173:             .FontSize  = 8
3174:             .BackStyle = 0

*-- Linhas 3180 a 3225:
3180:         loc_oPag2.AddObject("obj_4c_Fwoption1", "OptionGroup")
3181:         WITH loc_oPag2.obj_4c_Fwoption1
3182:             .ButtonCount = 2
3183:             .Top         = 127
3184:             .Left        = 638
3185:             .Width       = 192
3186:             .Height      = 27
3187:             .BorderStyle = 0
3188:             .Visible     = .T.
3189:         ENDWITH
3190:         WITH loc_oPag2.obj_4c_Fwoption1.Buttons(1)
3191:             .Caption   = "Data Integra" + CHR(231) + CHR(227) + "o"
3192:             .Left      = 5
3193:             .Top       = 5
3194:             .Width     = 97
3195:             .Height    = 15
3196:             .AutoSize  = .F.
3197:             .FontName  = "Tahoma"
3198:             .FontSize  = 8
3199:             .ForeColor = RGB(90, 90, 90)
3200:             .Themes    = .F.
3201:         ENDWITH
3202:         WITH loc_oPag2.obj_4c_Fwoption1.Buttons(2)
3203:             .Caption   = "Data N.F."
3204:             .Left      = 122
3205:             .Top       = 7
3206:             .Width     = 65
3207:             .Height    = 15
3208:             .AutoSize  = .F.
3209:             .FontName  = "Tahoma"
3210:             .FontSize  = 8
3211:             .ForeColor = RGB(90, 90, 90)
3212:             .Themes    = .F.
3213:         ENDWITH
3214: 
3215:         *-- Label Utilizar variacao de CFOP na Integracao
3216:         loc_oPag2.AddObject("lbl_4c_LblUtilvars", "Label")
3217:         WITH loc_oPag2.lbl_4c_LblUtilvars
3218:             .Caption   = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
3219:             .Top       = 156
3220:             .Left      = 390
3221:             .Width     = 251
3222:             .Height    = 15
3223:             .FontName  = "Tahoma"
3224:             .FontSize  = 8
3225:             .BackStyle = 0

*-- Linhas 3231 a 3261:
3231:         loc_oPag2.AddObject("obj_4c_Optutilvars", "OptionGroup")
3232:         WITH loc_oPag2.obj_4c_Optutilvars
3233:             .ButtonCount = 2
3234:             .Top         = 150
3235:             .Left        = 638
3236:             .Width       = 94
3237:             .Height      = 27
3238:             .BorderStyle = 0
3239:             .Visible     = .T.
3240:         ENDWITH
3241:         WITH loc_oPag2.obj_4c_Optutilvars.Buttons(1)
3242:             .Caption   = "Sim"
3243:             .Left      = 5
3244:             .Top       = 5
3245:             .Width     = 40
3246:             .Height    = 17
3247:             .AutoSize  = .F.
3248:             .FontName  = "Tahoma"
3249:             .FontSize  = 8
3250:             .ForeColor = RGB(90, 90, 90)
3251:             .Themes    = .F.
3252:         ENDWITH
3253:         WITH loc_oPag2.obj_4c_Optutilvars.Buttons(2)
3254:             .Caption   = "N" + CHR(227) + "o"
3255:             .Left      = 51
3256:             .Top       = 5
3257:             .Width     = 40
3258:             .Height    = 17
3259:             .AutoSize  = .F.
3260:             .FontName  = "Tahoma"
3261:             .FontSize  = 8

*-- Linhas 3270 a 3309:
3270:         *-- Linha separadora horizontal
3271:         loc_oPag2.AddObject("shp_4c_Sep", "Shape")
3272:         WITH loc_oPag2.shp_4c_Sep
3273:             .Top           = 211
3274:             .Left          = 5
3275:             .Width         = 984
3276:             .Height        = 1
3277:             .BackStyle     = 0
3278:             .BorderWidth   = 1
3279:             .SpecialEffect = 1
3280:             .Visible       = .T.
3281:         ENDWITH
3282: 
3283:         *-- Label cabecalho secao Integracao Fiscal
3284:         loc_oPag2.AddObject("lbl_4c_LblIntFisc", "Label")
3285:         WITH loc_oPag2.lbl_4c_LblIntFisc
3286:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Fiscal"
3287:             .Top       = 217
3288:             .Left      = 18
3289:             .Width     = 99
3290:             .Height    = 15
3291:             .FontName  = "Tahoma"
3292:             .FontSize  = 8
3293:             .FontBold  = .T.
3294:             .BackStyle = 0
3295:             .ForeColor = RGB(90, 90, 90)
3296:             .Visible   = .T.
3297:         ENDWITH
3298: 
3299:         *-- Label Integrar Valor Contabil
3300:         loc_oPag2.AddObject("lbl_4c_LblIntvlrcont", "Label")
3301:         WITH loc_oPag2.lbl_4c_LblIntvlrcont
3302:             .Caption   = "Integrar Valor Cont" + CHR(225) + "bil :"
3303:             .Top       = 239
3304:             .Left      = 115
3305:             .Width     = 118
3306:             .Height    = 15
3307:             .FontName  = "Tahoma"
3308:             .FontSize  = 8
3309:             .BackStyle = 0

*-- Linhas 3315 a 3360:
3315:         loc_oPag2.AddObject("obj_4c_Fwoption2", "OptionGroup")
3316:         WITH loc_oPag2.obj_4c_Fwoption2
3317:             .ButtonCount = 2
3318:             .Top         = 233
3319:             .Left        = 231
3320:             .Width       = 94
3321:             .Height      = 27
3322:             .BorderStyle = 0
3323:             .Visible     = .T.
3324:         ENDWITH
3325:         WITH loc_oPag2.obj_4c_Fwoption2.Buttons(1)
3326:             .Caption   = "Sim"
3327:             .Left      = 5
3328:             .Top       = 5
3329:             .Width     = 40
3330:             .Height    = 17
3331:             .AutoSize  = .F.
3332:             .FontName  = "Tahoma"
3333:             .FontSize  = 8
3334:             .ForeColor = RGB(90, 90, 90)
3335:             .Themes    = .F.
3336:         ENDWITH
3337:         WITH loc_oPag2.obj_4c_Fwoption2.Buttons(2)
3338:             .Caption   = "N" + CHR(227) + "o"
3339:             .Left      = 51
3340:             .Top       = 5
3341:             .Width     = 40
3342:             .Height    = 17
3343:             .AutoSize  = .F.
3344:             .FontName  = "Tahoma"
3345:             .FontSize  = 8
3346:             .ForeColor = RGB(90, 90, 90)
3347:             .Themes    = .F.
3348:         ENDWITH
3349: 
3350:         *-- Label Integrar Valores Icms
3351:         loc_oPag2.AddObject("lbl_4c_LblIntvlricms", "Label")
3352:         WITH loc_oPag2.lbl_4c_LblIntvlricms
3353:             .Caption   = "Integrar Valores Icms :"
3354:             .Top       = 259
3355:             .Left      = 121
3356:             .Width     = 112
3357:             .Height    = 15
3358:             .FontName  = "Tahoma"
3359:             .FontSize  = 8
3360:             .BackStyle = 0

*-- Linhas 3366 a 3411:
3366:         loc_oPag2.AddObject("obj_4c_Fwoption3", "OptionGroup")
3367:         WITH loc_oPag2.obj_4c_Fwoption3
3368:             .ButtonCount = 2
3369:             .Top         = 253
3370:             .Left        = 231
3371:             .Width       = 94
3372:             .Height      = 27
3373:             .BorderStyle = 0
3374:             .Visible     = .T.
3375:         ENDWITH
3376:         WITH loc_oPag2.obj_4c_Fwoption3.Buttons(1)
3377:             .Caption   = "Sim"
3378:             .Left      = 5
3379:             .Top       = 5
3380:             .Width     = 40
3381:             .Height    = 17
3382:             .AutoSize  = .F.
3383:             .FontName  = "Tahoma"
3384:             .FontSize  = 8
3385:             .ForeColor = RGB(90, 90, 90)
3386:             .Themes    = .F.
3387:         ENDWITH
3388:         WITH loc_oPag2.obj_4c_Fwoption3.Buttons(2)
3389:             .Caption   = "N" + CHR(227) + "o"
3390:             .Left      = 51
3391:             .Top       = 5
3392:             .Width     = 40
3393:             .Height    = 17
3394:             .AutoSize  = .F.
3395:             .FontName  = "Tahoma"
3396:             .FontSize  = 8
3397:             .ForeColor = RGB(90, 90, 90)
3398:             .Themes    = .F.
3399:         ENDWITH
3400: 
3401:         *-- Label Integrar Valores Ipi
3402:         loc_oPag2.AddObject("lbl_4c_LblIntvlripi", "Label")
3403:         WITH loc_oPag2.lbl_4c_LblIntvlripi
3404:             .Caption   = "Integrar Valores Ipi :"
3405:             .Top       = 278
3406:             .Left      = 131
3407:             .Width     = 102
3408:             .Height    = 15
3409:             .FontName  = "Tahoma"
3410:             .FontSize  = 8
3411:             .BackStyle = 0

*-- Linhas 3417 a 3462:
3417:         loc_oPag2.AddObject("obj_4c_Fwoption4", "OptionGroup")
3418:         WITH loc_oPag2.obj_4c_Fwoption4
3419:             .ButtonCount = 2
3420:             .Top         = 272
3421:             .Left        = 231
3422:             .Width       = 94
3423:             .Height      = 27
3424:             .BorderStyle = 0
3425:             .Visible     = .T.
3426:         ENDWITH
3427:         WITH loc_oPag2.obj_4c_Fwoption4.Buttons(1)
3428:             .Caption   = "Sim"
3429:             .Left      = 5
3430:             .Top       = 5
3431:             .Width     = 40
3432:             .Height    = 17
3433:             .AutoSize  = .F.
3434:             .FontName  = "Tahoma"
3435:             .FontSize  = 8
3436:             .ForeColor = RGB(90, 90, 90)
3437:             .Themes    = .F.
3438:         ENDWITH
3439:         WITH loc_oPag2.obj_4c_Fwoption4.Buttons(2)
3440:             .Caption   = "N" + CHR(227) + "o"
3441:             .Left      = 51
3442:             .Top       = 5
3443:             .Width     = 40
3444:             .Height    = 17
3445:             .AutoSize  = .F.
3446:             .FontName  = "Tahoma"
3447:             .FontSize  = 8
3448:             .ForeColor = RGB(90, 90, 90)
3449:             .Themes    = .F.
3450:         ENDWITH
3451: 
3452:         *-- Label Movimentacao Fisica de Estoque
3453:         loc_oPag2.AddObject("lbl_4c_LblIndmov", "Label")
3454:         WITH loc_oPag2.lbl_4c_LblIndmov
3455:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
3456:             .Top       = 298
3457:             .Left      = 69
3458:             .Width     = 164
3459:             .Height    = 15
3460:             .FontName  = "Tahoma"
3461:             .FontSize  = 8
3462:             .BackStyle = 0

*-- Linhas 3468 a 3513:
3468:         loc_oPag2.AddObject("obj_4c_Fwoption5", "OptionGroup")
3469:         WITH loc_oPag2.obj_4c_Fwoption5
3470:             .ButtonCount = 2
3471:             .Top         = 292
3472:             .Left        = 231
3473:             .Width       = 94
3474:             .Height      = 27
3475:             .BorderStyle = 0
3476:             .Visible     = .T.
3477:         ENDWITH
3478:         WITH loc_oPag2.obj_4c_Fwoption5.Buttons(1)
3479:             .Caption   = "Sim"
3480:             .Left      = 5
3481:             .Top       = 5
3482:             .Width     = 40
3483:             .Height    = 17
3484:             .AutoSize  = .F.
3485:             .FontName  = "Tahoma"
3486:             .FontSize  = 8
3487:             .ForeColor = RGB(90, 90, 90)
3488:             .Themes    = .F.
3489:         ENDWITH
3490:         WITH loc_oPag2.obj_4c_Fwoption5.Buttons(2)
3491:             .Caption   = "N" + CHR(227) + "o"
3492:             .Left      = 51
3493:             .Top       = 5
3494:             .Width     = 40
3495:             .Height    = 17
3496:             .AutoSize  = .F.
3497:             .FontName  = "Tahoma"
3498:             .FontSize  = 8
3499:             .ForeColor = RGB(90, 90, 90)
3500:             .Themes    = .F.
3501:         ENDWITH
3502: 
3503:         *-- Label Indicacao de Pagamento
3504:         loc_oPag2.AddObject("lbl_4c_LblIndpagto", "Label")
3505:         WITH loc_oPag2.lbl_4c_LblIndpagto
3506:             .Caption   = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
3507:             .Top       = 318
3508:             .Left      = 106
3509:             .Width     = 127
3510:             .Height    = 15
3511:             .FontName  = "Tahoma"
3512:             .FontSize  = 8
3513:             .BackStyle = 0

*-- Linhas 3519 a 3549:
3519:         loc_oPag2.AddObject("obj_4c_Fwoption6", "OptionGroup")
3520:         WITH loc_oPag2.obj_4c_Fwoption6
3521:             .ButtonCount = 2
3522:             .Top         = 312
3523:             .Left        = 231
3524:             .Width       = 94
3525:             .Height      = 27
3526:             .BorderStyle = 0
3527:             .Visible     = .T.
3528:         ENDWITH
3529:         WITH loc_oPag2.obj_4c_Fwoption6.Buttons(1)
3530:             .Caption   = "Sim"
3531:             .Left      = 5
3532:             .Top       = 5
3533:             .Width     = 40
3534:             .Height    = 17
3535:             .AutoSize  = .F.
3536:             .FontName  = "Tahoma"
3537:             .FontSize  = 8
3538:             .ForeColor = RGB(90, 90, 90)
3539:             .Themes    = .F.
3540:         ENDWITH
3541:         WITH loc_oPag2.obj_4c_Fwoption6.Buttons(2)
3542:             .Caption   = "N" + CHR(227) + "o"
3543:             .Left      = 51
3544:             .Top       = 5
3545:             .Width     = 40
3546:             .Height    = 17
3547:             .AutoSize  = .F.
3548:             .FontName  = "Tahoma"
3549:             .FontSize  = 8

*-- Linhas 3924 a 3933:
3924:             loc_oBO.this_nFrticms    = IIF(loc_oPag1.chk_4c_ObjFreteICM.Value, 1, 0)
3925:             loc_oBO.this_nSegicms    = IIF(loc_oPag1.chk_4c_ObjSegIcm.Value, 1, 0)
3926:             loc_oBO.this_nDesicms    = IIF(loc_oPag1.chk_4c_ObjDespIcm.Value, 1, 0)
3927:             loc_oBO.this_nIncicmnfs  = IIF(loc_oPag1.chk_4c_Fwcheckbox1.Value, 1, 0)
3928:             loc_oBO.this_nSomaicmfrete = IIF(loc_oPag1.chk_4c_Fwcheckbox2.Value, 1, 0)
3929:             loc_oBO.this_cSubtribs   = LEFT(UPPER(ALLTRIM(NVL(loc_oPag1.cbo_4c_CmbSTRIB.Value, ""))), 1)
3930:             loc_oBO.this_nPbcsts     = VAL(NVL(loc_oPag1.txt_4c_Bcst.Value, "0"))
3931:             loc_oBO.this_nTransps    = loc_oPag1.cbo_4c_Combo5.ListIndex
3932:             loc_oBO.this_nIcmsincs   = loc_oPag1.cbo_4c_Combo10.ListIndex
3933:             loc_oBO.this_cSittribs   = ALLTRIM(NVL(loc_oPag1.txt_4c_Sittricm.Value, ""))

*-- Linhas 4050 a 4063:
4050:             loc_oPag1.txt_4c_CfoST.Value   = ALLTRIM(NVL(loc_oBO.this_cCfosts,   ""))
4051:             loc_oPag1.txt_4c_Cfdest.Value  = ALLTRIM(NVL(loc_oBO.this_cCoddests, ""))
4052: 
4053:             *-- Checkboxes ICMS
4054:             loc_oPag1.chk_4c_ObjFreteICM.Value   = (loc_oBO.this_nFrticms = 1)
4055:             loc_oPag1.chk_4c_ObjSegIcm.Value     = (loc_oBO.this_nSegicms = 1)
4056:             loc_oPag1.chk_4c_ObjDespIcm.Value    = (loc_oBO.this_nDesicms = 1)
4057:             loc_oPag1.chk_4c_Fwcheckbox1.Value   = (loc_oBO.this_nIncicmnfs = 1)
4058:             loc_oPag1.chk_4c_Fwcheckbox2.Value   = (loc_oBO.this_nSomaicmfrete = 1)
4059: 
4060:             *-- Substituicao / Base ST
4061:             loc_oPag1.cbo_4c_CmbSTRIB.Value  = IIF(UPPER(ALLTRIM(loc_oBO.this_cSubtribs)) = "S", ;
4062:                 "Sim", "N" + CHR(227) + "o")
4063:             loc_oPag1.txt_4c_Bcst.Value       = ALLTRIM(STR(loc_oBO.this_nPbcsts, 6, 2))

*-- Linhas 4224 a 4233:
4224:             loc_oPag1.chk_4c_ObjFreteICM.Value     = 0
4225:             loc_oPag1.chk_4c_ObjSegIcm.Value       = 0
4226:             loc_oPag1.chk_4c_ObjDespIcm.Value      = 0
4227:             loc_oPag1.chk_4c_Fwcheckbox1.Value     = 0
4228:             loc_oPag1.chk_4c_Fwcheckbox2.Value     = 0
4229:             loc_oPag1.cbo_4c_CmbSTRIB.ListIndex    = 2
4230:             loc_oPag1.txt_4c_Bcst.Value            = "  0.00"
4231:             loc_oPag1.txt_4c_Sittricm.Value        = ""
4232:             loc_oPag1.cbo_4c_CmbContribuinte.ListIndex = 2
4233:             loc_oPag1.txt_4c_AliqIVCs.Value        = " 0.00"

*-- Linhas 4344 a 4353:
4344:             loc_oPag1.chk_4c_ObjFreteICM.Enabled    = par_lHabilitar
4345:             loc_oPag1.chk_4c_ObjSegIcm.Enabled      = par_lHabilitar
4346:             loc_oPag1.chk_4c_ObjDespIcm.Enabled     = par_lHabilitar
4347:             loc_oPag1.chk_4c_Fwcheckbox1.Enabled    = par_lHabilitar
4348:             loc_oPag1.chk_4c_Fwcheckbox2.Enabled    = par_lHabilitar
4349: 
4350:             *-- IPI
4351:             loc_oPag1.cbo_4c_CmbIpi.Enabled    = par_lHabilitar
4352:             loc_oPag1.txt_4c_Aliqs.Enabled      = par_lHabilitar
4353:             loc_oPag1.cbo_4c_CmbIpiI.Enabled    = par_lHabilitar

*-- Linhas 4418 a 4439:
4418:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4419: 
4420:             *-- Confirmar: habilitado apenas em INCLUIR/ALTERAR
4421:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lEmEdicao
4422: 
4423:             *-- Cancelar: sempre habilitado em Page2
4424:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
4425: 
4426:             *-- Botoes da Page1 (CRUD): desabilita Alterar/Excluir quando nao ha registro
4427:             LOCAL loc_oPg1
4428:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
4429:             LOCAL loc_lTemRegistro
4430:             loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
4431: 
4432:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
4433:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
4434:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
4435: 
4436:         CATCH TO loc_oErro
4437:             MostrarErro(loc_oErro, "Formcfo.AjustarBotoesPorModo")
4438:         ENDTRY
4439:     ENDPROC


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

