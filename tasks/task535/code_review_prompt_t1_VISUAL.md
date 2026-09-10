# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 187: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 212: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 237: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 262: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 287: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 324: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 821: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 845: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTgp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1224 linhas total):

*-- Linhas 85 a 157:
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .PageCount = 2
88:             .Top       = -29
89:             .Left      = 0
90:             .Width     = THIS.Width
91:             .Height    = THIS.Height + 29
92:             .Tabs      = .F.
93:             .Visible   = .T.
94: 
95:             .Page1.Caption   = "Lista"
96:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page1.BackColor = RGB(255, 255, 255)
98: 
99:             .Page2.Caption   = "Dados"
100:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.BackColor = RGB(255, 255, 255)
102:         ENDWITH
103: 
104:         THIS.ConfigurarPaginaLista()
105:         THIS.ConfigurarPaginaDados()
106:     ENDPROC
107: 
108:     *===========================================================================
109:     * ConfigurarPaginaLista - Configura Page1 (Grid + Botoes CRUD)
110:     * REGRA CLAUDE.md #11: cnt_4c_Cabecalho DEVE ser o PRIMEIRO AddObject da pagina
111:     * REGRA CLAUDE.md #10: cnt_4c_Saida/cmd_4c_Encerrar seguem o padrao canonico
112:     *===========================================================================
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPagina
115:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
116: 
117:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118: 
119:         *-- Container Cabecalho (cntSombra no legado)
120:         *-- Canonico CLAUDE.md #11: Top=29, Left=0, Width=THIS.Width, Height=80
121:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
122:         WITH loc_oPagina.cnt_4c_Cabecalho
123:             .Top         = 29
124:             .Left        = 0
125:             .Width       = THIS.Width
126:             .Height      = 80
127:             .BackColor   = RGB(100, 100, 100)
128:             .BorderWidth = 0
129:             .Visible     = .T.
130:         ENDWITH
131: 
132:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
133:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
134:             .Caption   = THIS.Caption
135:             .Top       = 15
136:             .Left      = 10
137:             .Width     = THIS.Width - 20
138:             .Height    = 40
139:             .FontName  = "Tahoma"
140:             .FontSize  = 16
141:             .FontBold  = .T.
142:             .ForeColor = RGB(0, 0, 0)
143:             .BackStyle = 0
144:             .AutoSize  = .F.
145:             .Visible   = .T.
146:         ENDWITH
147: 
148:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
150:             .Caption   = THIS.Caption
151:             .Top       = 18
152:             .Left      = 10
153:             .Width     = THIS.Width - 20
154:             .Height    = 46
155:             .FontName  = "Tahoma"
156:             .FontSize  = 16
157:             .FontBold  = .T.

*-- Linhas 165 a 351:
165:         *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
166:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
167:         WITH loc_oPagina.cnt_4c_Botoes
168:             .Top         = 29
169:             .Left        = 542
170:             .Width       = 390
171:             .Height      = 85
172:             .BackStyle   = 0
173:             .BorderWidth = 0
174:             .Visible     = .T.
175:         ENDWITH
176: 
177:         *-- Botao Incluir (Left=5)
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
188:             .FontBold        = .T.
189:             .FontItalic      = .T.
190:             .FontSize        = 8
191:             .ForeColor       = RGB(90, 90, 90)
192:             .BackColor       = RGB(255, 255, 255)
193:             .Themes          = .F.
194:             .SpecialEffect   = 0
195:             .MousePointer    = 15
196:             .WordWrap        = .T.
197:             .AutoSize        = .F.
198:             .Visible         = .T.
199:         ENDWITH
200:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
201: 
202:         *-- Botao Visualizar (Left=80)
203:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
204:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
205:             .Caption         = "Visualizar"
206:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
207:             .PicturePosition = 13
208:             .Top             = 5
209:             .Left            = 80
210:             .Width           = 75
211:             .Height          = 75
212:             .FontName        = "Comic Sans MS"
213:             .FontBold        = .T.
214:             .FontItalic      = .T.
215:             .FontSize        = 8
216:             .ForeColor       = RGB(90, 90, 90)
217:             .BackColor       = RGB(255, 255, 255)
218:             .Themes          = .F.
219:             .SpecialEffect   = 0
220:             .MousePointer    = 15
221:             .WordWrap        = .T.
222:             .AutoSize        = .F.
223:             .Visible         = .T.
224:         ENDWITH
225:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
226: 
227:         *-- Botao Alterar (Left=155)
228:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
229:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
230:             .Caption         = "Alterar"
231:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
232:             .PicturePosition = 13
233:             .Top             = 5
234:             .Left            = 155
235:             .Width           = 75
236:             .Height          = 75
237:             .FontName        = "Comic Sans MS"
238:             .FontBold        = .T.
239:             .FontItalic      = .T.
240:             .FontSize        = 8
241:             .ForeColor       = RGB(90, 90, 90)
242:             .BackColor       = RGB(255, 255, 255)
243:             .Themes          = .F.
244:             .SpecialEffect   = 0
245:             .MousePointer    = 15
246:             .WordWrap        = .T.
247:             .AutoSize        = .F.
248:             .Visible         = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
251: 
252:         *-- Botao Excluir (Left=230)
253:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
254:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
255:             .Caption         = "Excluir"
256:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
257:             .PicturePosition = 13
258:             .Top             = 5
259:             .Left            = 230
260:             .Width           = 75
261:             .Height          = 75
262:             .FontName        = "Comic Sans MS"
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .FontSize        = 8
266:             .ForeColor       = RGB(90, 90, 90)
267:             .BackColor       = RGB(255, 255, 255)
268:             .Themes          = .F.
269:             .SpecialEffect   = 0
270:             .MousePointer    = 15
271:             .WordWrap        = .T.
272:             .AutoSize        = .F.
273:             .Visible         = .T.
274:         ENDWITH
275:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
276: 
277:         *-- Botao Buscar (Left=305)
278:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
279:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
280:             .Caption         = "Buscar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 5
284:             .Left            = 305
285:             .Width           = 75
286:             .Height          = 75
287:             .FontName        = "Comic Sans MS"
288:             .FontBold        = .T.
289:             .FontItalic      = .T.
290:             .FontSize        = 8
291:             .ForeColor       = RGB(90, 90, 90)
292:             .BackColor       = RGB(255, 255, 255)
293:             .Themes          = .F.
294:             .SpecialEffect   = 0
295:             .MousePointer    = 15
296:             .WordWrap        = .T.
297:             .AutoSize        = .F.
298:             .Visible         = .T.
299:         ENDWITH
300:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
301: 
302:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
303:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
304:         WITH loc_oPagina.cnt_4c_Saida
305:             .Top         = 29
306:             .Left        = 917
307:             .Width       = 90
308:             .Height      = 85
309:             .BackStyle   = 0
310:             .BorderWidth = 0
311:             .Visible     = .T.
312:         ENDWITH
313: 
314:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
315:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
316:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
317:             .Caption         = "Encerrar"
318:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
319:             .PicturePosition = 13
320:             .Top             = 5
321:             .Left            = 5
322:             .Width           = 75
323:             .Height          = 75
324:             .FontName        = "Comic Sans MS"
325:             .FontBold        = .T.
326:             .FontItalic      = .T.
327:             .FontSize        = 8
328:             .ForeColor       = RGB(90, 90, 90)
329:             .BackColor       = RGB(255, 255, 255)
330:             .Themes          = .F.
331:             .SpecialEffect   = 0
332:             .MousePointer    = 15
333:             .WordWrap        = .T.
334:             .AutoSize        = .F.
335:             .Visible         = .T.
336:         ENDWITH
337:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
338: 
339:         *-- Grid de listagem (legado: Grade.pColuna('Codigos',...,80), pColuna('Descs',...,279))
340:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
343:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
344:         WITH loc_oPagina.grd_4c_Lista
345:             .Top                = 117
346:             .Left               = 26
347:             .Width              = 880
348:             .Height             = 498
349:             .FontName           = "Verdana"
350:             .FontSize           = 8
351:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 391 a 400:
391:                 loc_oGrid.Column2.Width = 770
392: 
393:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
394:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
395:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
396: 
397:                 THIS.FormatarGridLista(loc_oGrid)
398:                 loc_lResultado = .T.
399:             ENDIF
400: 

*-- Linhas 560 a 598:
560:         *-- Container Cabecalho (identico ao da pagina Lista) - VAZIO nesta fase
561:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
562:         WITH loc_oPagina.cnt_4c_Cabecalho
563:             .Top         = 29
564:             .Left        = 0
565:             .Width       = THIS.Width
566:             .Height      = 80
567:             .BackColor   = RGB(100, 100, 100)
568:             .BorderWidth = 0
569:             .Visible     = .T.
570:         ENDWITH
571: 
572:         *-- Container BotoesAcao (Grupo_Salva legado: Left=615, Top=17, Width=160, Height=85)
573:         *-- Com compensacao PageFrame +29: Top=46
574:         *-- VAZIO nesta fase - botoes Confirmar/Cancelar entram na Fase 6
575:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
576:         WITH loc_oPagina.cnt_4c_BotoesAcao
577:             .Top         = 46
578:             .Left        = 615
579:             .Width       = 160
580:             .Height      = 85
581:             .BackStyle = 1
582:             .BackColor = RGB(255, 255, 255)
583:             .BorderWidth = 0
584:             .Visible     = .T.
585:         ENDWITH
586: 
587:         *-- Label Codigo (lblCodigos legado: Top=158, Left=254, Width=42)
588:         *-- Compensacao PageFrame +29: Top=158+29=187
589:         loc_oPagina.AddObject("lbl_4c_LblCodigos", "Label")
590:         WITH loc_oPagina.lbl_4c_LblCodigos
591:             .Caption   = "C" + CHR(243) + "digo :"
592:             .Top       = 158 + 29
593:             .Left      = 254
594:             .Width     = 42
595:             .Height    = 17
596:             .FontName  = "Tahoma"
597:             .FontSize  = 8
598:             .FontBold  = .F.

*-- Linhas 606 a 615:
606:         *-- InputMask="!!!!!!!!!!" forca maiusculas em char(10); MaxLength=10
607:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
608:         WITH loc_oPagina.txt_4c_Codigos
609:             .Top       = 155 + 29
610:             .Left      = 299
611:             .Width     = 80
612:             .Height    = 23
613:             .MaxLength = 10
614:             .InputMask = "!!!!!!!!!!"
615:             .BackStyle = 1

*-- Linhas 621 a 633:
621:         ENDWITH
622: 
623:         *-- Label Descricao (lblDescrs legado: Top=184, Left=241, Width=55, Alignment=1)
624:         loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
625:         WITH loc_oPagina.lbl_4c_LblDescrs
626:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
627:             .Top       = 184 + 29
628:             .Left      = 241
629:             .Width     = 55
630:             .Height    = 17
631:             .Alignment = 1
632:             .FontName  = "Tahoma"
633:             .FontSize  = 8

*-- Linhas 640 a 649:
640:         *-- TextBox Descricao (Get_Descrs legado: SigInTgo.descs, Format="!K", Width=220)
641:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
642:         WITH loc_oPagina.txt_4c_Descrs
643:             .Top       = 181 + 29
644:             .Left      = 299
645:             .Width     = 220
646:             .Height    = 23
647:             .MaxLength = 30
648:             .Format    = "!K"
649:             .BackStyle = 1

*-- Linhas 655 a 667:
655:         ENDWITH
656: 
657:         *-- Label Operacao de Producao (Say35 legado: Top=212, Left=177)
658:         loc_oPagina.AddObject("lbl_4c_Label35", "Label")
659:         WITH loc_oPagina.lbl_4c_Label35
660:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o :"
661:             .Top       = 212 + 29
662:             .Left      = 177
663:             .Width     = 140
664:             .Height    = 15
665:             .FontName  = "Tahoma"
666:             .FontSize  = 8
667:             .BackStyle = 0

*-- Linhas 673 a 682:
673:         *-- TextBox Operacao de Producao / Dopps (Get_nivel legado: lookup SigCdOpd)
674:         loc_oPagina.AddObject("txt_4c_Nivel", "TextBox")
675:         WITH loc_oPagina.txt_4c_Nivel
676:             .Top       = 208 + 29
677:             .Left      = 299
678:             .Width     = 150
679:             .Height    = 21
680:             .MaxLength = 20
681:             .BackStyle = 1
682:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 693 a 705:
693:         BINDEVENT(loc_oPagina.txt_4c_Nivel, "KeyPress", THIS, "ValidarNivel")
694: 
695:         *-- Label Gerar OP Sem Peso Medio (Say4 legado: Top=245, Left=160, Width=136)
696:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
697:         WITH loc_oPagina.lbl_4c_Label4
698:             .Caption   = "Gerar OP Sem Peso M" + CHR(233) + "dio : "
699:             .Top       = 245 + 29
700:             .Left      = 160
701:             .Width     = 136
702:             .Height    = 15
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .BackStyle = 0

*-- Linhas 712 a 763:
712:         loc_oPagina.AddObject("opt_4c_Opzers", "OptionGroup")
713:         WITH loc_oPagina.opt_4c_Opzers
714:             .ButtonCount = 2
715:             .Top         = 241 + 29
716:             .Left        = 299
717:             .Width       = 105
718:             .Height      = 26
719:             .BackStyle   = 0
720:             .BorderStyle = 0
721:             .Value       = 1
722:             .Visible     = .T.
723:         ENDWITH
724:         WITH loc_oPagina.opt_4c_Opzers.Buttons(1)
725:             .Caption   = "Sim"
726:             .BackStyle = 0
727:             .Left      = 5
728:             .Top       = 4
729:             .Width     = 34
730:             .Height    = 15
731:             .Style     = 0
732:             .AutoSize  = .T.
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .ForeColor = RGB(90, 90, 90)
736:             .Themes    = .F.
737:         ENDWITH
738:         WITH loc_oPagina.opt_4c_Opzers.Buttons(2)
739:             .Caption   = "N" + CHR(227) + "o"
740:             .BackStyle = 0
741:             .Left      = 58
742:             .Top       = 4
743:             .Width     = 37
744:             .Height    = 15
745:             .Style     = 0
746:             .AutoSize  = .T.
747:             .FontName  = "Tahoma"
748:             .FontSize  = 8
749:             .ForeColor = RGB(90, 90, 90)
750:             .Themes    = .F.
751:         ENDWITH
752: 
753:         *-- Label Gerar Entrada do Peso (Say1 legado: Top=268, Left=175, Width=121)
754:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
755:         WITH loc_oPagina.lbl_4c_Label1
756:             .Caption   = "Gerar Entrada do Peso : "
757:             .Top       = 268 + 29
758:             .Left      = 175
759:             .Width     = 121
760:             .Height    = 15
761:             .FontName  = "Tahoma"
762:             .FontSize  = 8
763:             .BackStyle = 0

*-- Linhas 770 a 863:
770:         loc_oPagina.AddObject("opt_4c_Entpes", "OptionGroup")
771:         WITH loc_oPagina.opt_4c_Entpes
772:             .ButtonCount = 2
773:             .Top         = 264 + 29
774:             .Left        = 299
775:             .Width       = 105
776:             .Height      = 26
777:             .BackStyle   = 0
778:             .BorderStyle = 0
779:             .Value       = 1
780:             .Visible     = .T.
781:         ENDWITH
782:         WITH loc_oPagina.opt_4c_Entpes.Buttons(1)
783:             .Caption   = "Sim"
784:             .BackStyle = 0
785:             .Left      = 5
786:             .Top       = 4
787:             .Width     = 34
788:             .Height    = 15
789:             .Style     = 0
790:             .AutoSize  = .T.
791:             .FontName  = "Tahoma"
792:             .FontSize  = 8
793:             .ForeColor = RGB(90, 90, 90)
794:             .Themes    = .F.
795:         ENDWITH
796:         WITH loc_oPagina.opt_4c_Entpes.Buttons(2)
797:             .Caption   = "N" + CHR(227) + "o"
798:             .BackStyle = 0
799:             .Left      = 58
800:             .Top       = 4
801:             .Width     = 37
802:             .Height    = 15
803:             .Style     = 0
804:             .AutoSize  = .T.
805:             .FontName  = "Tahoma"
806:             .FontSize  = 8
807:             .ForeColor = RGB(90, 90, 90)
808:             .Themes    = .F.
809:         ENDWITH
810: 
811:         *-- Botoes Salvar/Cancelar dentro de cnt_4c_BotoesAcao (Grupo_Salva legado)
812:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
813:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
814:             .Caption         = "Confirmar"
815:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
816:             .PicturePosition = 13
817:             .Top             = 5
818:             .Left            = 5
819:             .Width           = 75
820:             .Height          = 75
821:             .FontName        = "Comic Sans MS"
822:             .FontBold        = .T.
823:             .FontItalic      = .T.
824:             .FontSize        = 8
825:             .ForeColor       = RGB(90, 90, 90)
826:             .BackColor       = RGB(255, 255, 255)
827:             .Themes          = .F.
828:             .SpecialEffect   = 0
829:             .MousePointer    = 15
830:             .WordWrap        = .T.
831:             .AutoSize        = .F.
832:             .Visible         = .T.
833:         ENDWITH
834:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
835: 
836:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
837:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
838:             .Caption         = "Encerrar"
839:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
840:             .PicturePosition = 13
841:             .Top             = 5
842:             .Left            = 80
843:             .Width           = 75
844:             .Height          = 75
845:             .FontName        = "Comic Sans MS"
846:             .FontBold        = .T.
847:             .FontItalic      = .T.
848:             .FontSize        = 8
849:             .ForeColor       = RGB(90, 90, 90)
850:             .BackColor       = RGB(255, 255, 255)
851:             .Themes          = .F.
852:             .SpecialEffect   = 0
853:             .MousePointer    = 15
854:             .WordWrap        = .T.
855:             .AutoSize        = .F.
856:             .Visible         = .T.
857:         ENDWITH
858:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
859: 
860:         THIS.TornarControlesVisiveis(loc_oPagina)
861:     ENDPROC
862: 
863:     *===========================================================================

*-- Linhas 1164 a 1173:
1164:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1165: 
1166:         TRY
1167:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
1168:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1169:         CATCH TO loException
1170:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
1171:                 "FormTgp.AjustarBotoesPorModo")
1172:         ENDTRY
1173:     ENDPROC


### BO (C:\4c\projeto\app\classes\TgpBO.prg):
*==============================================================================
* TGPBO.PRG
* Business Object para Tgp (Tipos de Geracao de O.P.)
* Tabela: SigInTgo
*
* PILAR 2 - BANCO: Nomes de tabela/colunas IDENTICOS ao legado (SigInTgo)
* PILAR 3 - CODIGO: Arquitetura em camadas, propriedades this_ tipadas
*==============================================================================

DEFINE CLASS TgpBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento 1:1 com colunas de SigInTgo)
    this_cCodigos = ""              && codigos  - char(10) NOT NULL - Chave primaria
    this_cDescs = ""                && descs    - char(30) NOT NULL - Descricao
    this_nEntpes = 0                && entpes   - numeric(1,0) NOT NULL - Gerar Entrada do Peso (OptionGroup 1/2)
    this_nOpzers = 0                && opzers   - numeric(1,0) NOT NULL - Gerar OP Sem Peso Medio (OptionGroup 1/2)
    this_cDopps = ""                && dopps    - char(20) NOT NULL - Operacao de Producao (lookup SigCdOpd)

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas de BusinessBase
        THIS.this_cTabela = "SigInTgo"
        THIS.this_cCampoChave = "codigos"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos = TratarNulo(codigos, "C")
                THIS.this_cDescs   = TratarNulo(descs,   "C")
                THIS.this_nEntpes  = TratarNulo(entpes,  "N")
                THIS.this_nOpzers  = TratarNulo(opzers,  "N")
                THIS.this_cDopps   = TratarNulo(dopps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TgpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar (espelha PROCEDURE Click do
    * legado: Codigos e Descs obrigatorios + verificacao de codigo duplicado
    * apenas na inclusao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido !!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigos)
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado !!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se codigos ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigInTgo" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "TgpBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigInTgo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigInTgo (codigos, descs, entpes, opzers, dopps)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>,
                    <<FormatarNumeroSQL(THIS.this_nEntpes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpzers, 0)>>,
                    <<EscaparSQL(THIS.this_cDopps)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TgpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigInTgo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigInTgo
                SET descs  = <<EscaparSQL(THIS.this_cDescs)>>,
                    entpes = <<FormatarNumeroSQL(THIS.this_nEntpes, 0)>>,
                    opzers = <<FormatarNumeroSQL(THIS.this_nOpzers, 0)>>,
                    dopps  = <<EscaparSQL(THIS.this_cDopps)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TgpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigInTgo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigInTgo WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TgpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descs (colunas do Grade legado:
    * pColuna('Codigos',...) + pColuna('Descs',...))
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descs C(30))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigos, descs FROM SigInTgo"

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
                    MostrarErro("Erro ao buscar tipos de gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TgpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, entpes, opzers, dopps" + ;
                " FROM SigInTgo WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar tipo de gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TgpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

