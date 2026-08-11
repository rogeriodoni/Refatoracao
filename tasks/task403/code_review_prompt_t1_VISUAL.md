# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 186: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 211: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 236: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 261: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 286: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 322: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 770: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 794: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEmn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2337 linhas total):

*-- Linhas 88 a 97:
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .PageCount  = 2
91:             .Top        = -29
92:             .Left       = 0
93:             .Width      = THIS.Width
94:             .Height     = THIS.Height + 29
95:             .Tabs       = .F.
96:             .Visible    = .T.
97: 

*-- Linhas 115 a 348:
115:     *==========================================================================
116:     PROTECTED PROCEDURE ConfigurarPaginaLista(par_oPagina)
117: 
118:         *-- Cabecalho escuro com titulo (cntSombra legado)
119:         *-- Compensacao PageFrame: cntSombra.Top=1 + 29 = 30
120:         par_oPagina.AddObject("cnt_4c_Sombra", "Container")
121:         WITH par_oPagina.cnt_4c_Sombra
122:             .Top         = 30
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
132:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = THIS.Width - 12
136:             .Height    = 40
137:             .Caption   = THIS.Caption
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .AutoSize  = .F.
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
148:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width - 12
152:             .Height    = 46
153:             .Caption   = THIS.Caption
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.
157:             .ForeColor = RGB(255, 255, 255)
158:             .BackStyle = 0
159:             .AutoSize  = .F.
160:             .Visible   = .T.
161:         ENDWITH
162: 
163:         *-- Container de botoes CRUD (Grupo_op legado)
164:         *-- Grupo_op.Top=-1 + 29 = 28, Left=544
165:         par_oPagina.AddObject("cnt_4c_Botoes", "Container")
166:         WITH par_oPagina.cnt_4c_Botoes
167:             .Top         = 28
168:             .Left        =  542
169:             .Width       = 385
170:             .Height      = 85
171:             .BackStyle = 0
172:             .BorderWidth = 0
173:             .Visible     = .T.
174:         ENDWITH
175: 
176:         *-- Botao Incluir (Inserir legado: Top=5, Left=5)
177:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
178:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
179:             .Caption         = "Incluir"
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
185:             .PicturePosition = 13
186:             .FontName        = "Comic Sans MS"
187:             .FontSize        = 8
188:             .FontBold        = .T.
189:             .FontItalic      = .T.
190:             .ForeColor       = RGB(90, 90, 90)
191:             .BackColor       = RGB(255, 255, 255)
192:             .Themes          = .F.
193:             .SpecialEffect   = 0
194:             .MousePointer    = 15
195:             .WordWrap        = .T.
196:             .AutoSize        = .F.
197:             .Visible         = .T.
198:         ENDWITH
199:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
200: 
201:         *-- Botao Visualizar (Consultar legado: Top=5, Left=80)
202:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
203:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
204:             .Caption         = "Visualizar"
205:             .Top             = 5
206:             .Left            = 80
207:             .Width           = 75
208:             .Height          = 75
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
210:             .PicturePosition = 13
211:             .FontName        = "Comic Sans MS"
212:             .FontSize        = 8
213:             .FontBold        = .T.
214:             .FontItalic      = .T.
215:             .ForeColor       = RGB(90, 90, 90)
216:             .BackColor       = RGB(255, 255, 255)
217:             .Themes          = .F.
218:             .SpecialEffect   = 0
219:             .MousePointer    = 15
220:             .WordWrap        = .T.
221:             .AutoSize        = .F.
222:             .Visible         = .T.
223:         ENDWITH
224:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
225: 
226:         *-- Botao Alterar (Top=5, Left=155)
227:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
228:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
229:             .Caption         = "Alterar"
230:             .Top             = 5
231:             .Left            = 155
232:             .Width           = 75
233:             .Height          = 75
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
235:             .PicturePosition = 13
236:             .FontName        = "Comic Sans MS"
237:             .FontSize        = 8
238:             .FontBold        = .T.
239:             .FontItalic      = .T.
240:             .ForeColor       = RGB(90, 90, 90)
241:             .BackColor       = RGB(255, 255, 255)
242:             .Themes          = .F.
243:             .SpecialEffect   = 0
244:             .MousePointer    = 15
245:             .WordWrap        = .T.
246:             .AutoSize        = .F.
247:             .Visible         = .T.
248:         ENDWITH
249:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
250: 
251:         *-- Botao Excluir (Top=5, Left=230)
252:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
253:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
254:             .Caption         = "Excluir"
255:             .Top             = 5
256:             .Left            = 230
257:             .Width           = 75
258:             .Height          = 75
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
260:             .PicturePosition = 13
261:             .FontName        = "Comic Sans MS"
262:             .FontSize        = 8
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .ForeColor       = RGB(90, 90, 90)
266:             .BackColor       = RGB(255, 255, 255)
267:             .Themes          = .F.
268:             .SpecialEffect   = 0
269:             .MousePointer    = 15
270:             .WordWrap        = .T.
271:             .AutoSize        = .F.
272:             .Visible         = .T.
273:         ENDWITH
274:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
275: 
276:         *-- Botao Buscar (Procurar legado: Top=5, Left=305)
277:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
278:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
279:             .Caption         = "Buscar"
280:             .Top             = 5
281:             .Left            = 305
282:             .Width           = 75
283:             .Height          = 75
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
285:             .PicturePosition = 13
286:             .FontName        = "Comic Sans MS"
287:             .FontSize        = 8
288:             .FontBold        = .T.
289:             .FontItalic      = .T.
290:             .ForeColor       = RGB(90, 90, 90)
291:             .BackColor       = RGB(255, 255, 255)
292:             .Themes          = .F.
293:             .SpecialEffect   = 0
294:             .MousePointer    = 15
295:             .WordWrap        = .T.
296:             .AutoSize        = .F.
297:             .Visible         = .T.
298:         ENDWITH
299:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
300: 
301:         *-- Container de saida - padrao canonico (Grupo_Saida legado)
302:         par_oPagina.AddObject("cnt_4c_Saida", "Container")
303:         WITH par_oPagina.cnt_4c_Saida
304:             .Top         = 28
305:             .Left        = 917
306:             .Width       = 90
307:             .Height      = 85
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         par_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
314:         WITH par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
315:             .Caption         = "Encerrar"
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
321:             .PicturePosition = 13
322:             .FontName        = "Comic Sans MS"
323:             .FontSize        = 8
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .ForeColor       = RGB(90, 90, 90)
327:             .BackColor       = RGB(255, 255, 255)
328:             .Themes          = .F.
329:             .SpecialEffect   = 0
330:             .MousePointer    = 15
331:             .WordWrap        = .T.
332:             .AutoSize        = .F.
333:             .Visible         = .T.
334:         ENDWITH
335: 
336:         BINDEVENT(par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
337: 
338:         *-- Grid da lista (Pagina.Lista.Grade legado: Top=121, Left=12, Width=939, Height=470)
339:         *-- Compensacao PageFrame: Top=121 + 29 = 150
340:         par_oPagina.AddObject("grd_4c_Lista", "Grid")
341:         WITH par_oPagina.grd_4c_Lista
342:             .Top               = 150
343:             .Left              = 12
344:             .Width             = 939
345:             .Height            = 435
346:             .FontName          = "Verdana"
347:             .FontSize          = 8
348:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 393 a 433:
393: 
394:                         loc_oGrid.Column1.ControlSource   = "CrProdutos.cpros"
395:                         loc_oGrid.Column1.Width           = 100
396:                         loc_oGrid.Column1.Header1.Caption = ""
397:                         loc_oGrid.Column1.Header1.Alignment = 2
398:                         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
399:                         loc_oGrid.Column1.Header1.FontSize  = 8
400:                         loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)
401: 
402:                         loc_oGrid.Column2.ControlSource   = "CrProdutos.dpros"
403:                         loc_oGrid.Column2.Width           = 430
404:                         loc_oGrid.Column2.Header1.Caption = "Produto"
405:                         loc_oGrid.Column2.Header1.Alignment = 2
406:                         loc_oGrid.Column2.Header1.FontName  = "Tahoma"
407:                         loc_oGrid.Column2.Header1.FontSize  = 8
408:                         loc_oGrid.Column2.Header1.ForeColor = RGB(90, 90, 90)
409: 
410:                         loc_oGrid.Column3.ControlSource   = "CrProdutos.ifors"
411:                         loc_oGrid.Column3.Width           = 100
412:                         loc_oGrid.Column3.Header1.Caption = ""
413:                         loc_oGrid.Column3.Header1.Alignment = 2
414:                         loc_oGrid.Column3.Header1.FontName  = "Tahoma"
415:                         loc_oGrid.Column3.Header1.FontSize  = 8
416:                         loc_oGrid.Column3.Header1.ForeColor = RGB(90, 90, 90)
417: 
418:                         loc_oGrid.Column4.ControlSource   = "CrProdutos.reffs"
419:                         loc_oGrid.Column4.Width           = 150
420:                         loc_oGrid.Column4.Header1.Caption = ""
421:                         loc_oGrid.Column4.Header1.Alignment = 2
422:                         loc_oGrid.Column4.Header1.FontName  = "Tahoma"
423:                         loc_oGrid.Column4.Header1.FontSize  = 8
424:                         loc_oGrid.Column4.Header1.ForeColor = RGB(90, 90, 90)
425: 
426:                         loc_oGrid.Column5.ControlSource   = "CrProdutos.sgrus"
427:                         loc_oGrid.Column5.Width           = 140
428:                         loc_oGrid.Column5.Header1.Caption = ""
429:                         loc_oGrid.Column5.Header1.Alignment = 2
430:                         loc_oGrid.Column5.Header1.FontName  = "Tahoma"
431:                         loc_oGrid.Column5.Header1.FontSize  = 8
432:                         loc_oGrid.Column5.Header1.ForeColor = RGB(90, 90, 90)
433: 

*-- Linhas 699 a 776:
699:     *==========================================================================
700:     PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPagina)
701: 
702:         *-- Cabecalho escuro com titulo (padrao nova arquitetura em Page2)
703:         *-- Top = 1 + 29 = 30
704:         par_oPagina.AddObject("cnt_4c_Sombra", "Container")
705:         WITH par_oPagina.cnt_4c_Sombra
706:             .Top         = 30
707:             .Left        = 0
708:             .Width       = THIS.Width
709:             .Height      = 80
710:             .BackColor   = RGB(100, 100, 100)
711:             .BorderWidth = 0
712:             .Visible     = .T.
713:         ENDWITH
714: 
715:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
716:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
717:             .Top       = 15
718:             .Left      = 10
719:             .Width     = THIS.Width - 12
720:             .Height    = 40
721:             .Caption   = THIS.Caption
722:             .FontName  = "Tahoma"
723:             .FontSize  = 16
724:             .FontBold  = .T.
725:             .ForeColor = RGB(0, 0, 0)
726:             .BackStyle = 0
727:             .AutoSize  = .F.
728:             .Visible   = .T.
729:         ENDWITH
730: 
731:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
732:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
733:             .Top       = 18
734:             .Left      = 10
735:             .Width     = THIS.Width - 12
736:             .Height    = 46
737:             .Caption   = THIS.Caption
738:             .FontName  = "Tahoma"
739:             .FontSize  = 16
740:             .FontBold  = .T.
741:             .ForeColor = RGB(255, 255, 255)
742:             .BackStyle = 0
743:             .AutoSize  = .F.
744:             .Visible   = .T.
745:         ENDWITH
746: 
747:         *-- Container de botoes Salvar/Cancelar (Grupo_Salva legado)
748:         *-- Grupo_Salva.Top=8 + 29 = 37, Left=820
749:         par_oPagina.AddObject("cnt_4c_Salva", "Container")
750:         WITH par_oPagina.cnt_4c_Salva
751:             .Top         = 37
752:             .Left        = 820
753:             .Width       = 160
754:             .Height      = 85
755:             .BackStyle   = 0
756:             .BorderWidth = 0
757:             .Visible     = .T.
758:         ENDWITH
759: 
760:         *-- Botao Confirmar/Salvar (Left=5, Top=5, Width=75, Height=75)
761:         par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
762:         WITH par_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
763:             .Caption         = "Confirmar"
764:             .Top             = 5
765:             .Left            = 5
766:             .Width           = 75
767:             .Height          = 75
768:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
769:             .PicturePosition = 13
770:             .FontName        = "Comic Sans MS"
771:             .FontSize        = 8
772:             .FontBold        = .T.
773:             .FontItalic      = .T.
774:             .ForeColor       = RGB(90, 90, 90)
775:             .BackColor       = RGB(255, 255, 255)
776:             .Themes          = .F.

*-- Linhas 782 a 800:
782:         ENDWITH
783: 
784:         *-- Botao Cancelar (Left=80, Top=5, Width=75, Height=75)
785:         par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
786:         WITH par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
787:             .Caption         = "Encerrar"
788:             .Top             = 5
789:             .Left            = 80
790:             .Width           = 75
791:             .Height          = 75
792:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
793:             .PicturePosition = 13
794:             .FontName        = "Comic Sans MS"
795:             .FontSize        = 8
796:             .FontBold        = .T.
797:             .FontItalic      = .T.
798:             .ForeColor       = RGB(90, 90, 90)
799:             .BackColor       = RGB(255, 255, 255)
800:             .Themes          = .F.

*-- Linhas 811 a 823:
811:         *--------------------------------------------------------------------------
812: 
813:         *-- Label "Produto :" (Say1: top=17+29=46, left=199, width=47, height=15)
814:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
815:         WITH par_oPagina.lbl_4c_Label1
816:             .Caption   = "Produto :"
817:             .Top       = 46
818:             .Left      = 199
819:             .Width     = 47
820:             .Height    = 15
821:             .FontName  = "Tahoma"
822:             .FontSize  = 8
823:             .BackStyle = 0

*-- Linhas 830 a 839:
830:         *-- Lookup SigCdPro por cpros (quando INSERIR); readonly em outros modos
831:         par_oPagina.AddObject("txt_4c_Produto", "TextBox")
832:         WITH par_oPagina.txt_4c_Produto
833:             .Top       = 43
834:             .Left      = 251
835:             .Width     = 108
836:             .Height    = 23
837:             .FontName  = "Tahoma"
838:             .FontSize  = 8
839:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 845 a 854:
845:         *-- Lookup SigCdPro por dpros (quando INSERIR); readonly em outros modos
846:         par_oPagina.AddObject("txt_4c_Dpro", "TextBox")
847:         WITH par_oPagina.txt_4c_Dpro
848:             .Top       = 43
849:             .Left      = 361
850:             .Width     = 360
851:             .Height    = 23
852:             .FontName  = "Tahoma"
853:             .FontSize  = 8
854:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 863 a 875:
863:         *--------------------------------------------------------------------------
864: 
865:         *-- Label "Grupo :" (Say8: top=44+29=73, left=208, width=38, height=15)
866:         par_oPagina.AddObject("lbl_4c_Label8", "Label")
867:         WITH par_oPagina.lbl_4c_Label8
868:             .Caption   = "Grupo :"
869:             .Top       = 73
870:             .Left      = 208
871:             .Width     = 38
872:             .Height    = 15
873:             .FontName  = "Tahoma"
874:             .FontSize  = 8
875:             .BackStyle = 0

*-- Linhas 882 a 891:
882:         *-- When=.F. -> sempre readonly (preenchido automaticamente pelo produto)
883:         par_oPagina.AddObject("txt_4c_Cgru", "TextBox")
884:         WITH par_oPagina.txt_4c_Cgru
885:             .Top       = 69
886:             .Left      = 251
887:             .Width     = 31
888:             .Height    = 23
889:             .FontName  = "Tahoma"
890:             .FontSize  = 8
891:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 898 a 958:
898:         *-- When=.F. -> sempre readonly
899:         par_oPagina.AddObject("txt_4c_Dgru", "TextBox")
900:         WITH par_oPagina.txt_4c_Dgru
901:             .Top       = 69
902:             .Left      = 284
903:             .Width     = 150
904:             .Height    = 23
905:             .FontName  = "Tahoma"
906:             .FontSize  = 8
907:             .ForeColor = RGB(90, 90, 90)
908:             .Value     = ""
909:             .ReadOnly  = .T.
910:             .Visible   = .T.
911:         ENDWITH
912: 
913:         *-- Label "Situacao :" (Say19: top=44+29=73, left=456)
914:         par_oPagina.AddObject("lbl_4c_Label19", "Label")
915:         WITH par_oPagina.lbl_4c_Label19
916:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
917:             .Top       = 73
918:             .Left      = 456
919:             .FontName  = "Tahoma"
920:             .FontSize  = 8
921:             .BackStyle = 0
922:             .ForeColor = RGB(90, 90, 90)
923:             .Visible   = .T.
924:         ENDWITH
925: 
926:         *-- OptionGroup Situacao (Opc_situacao: top=38+29=67, left=504, width=117, height=25)
927:         *-- When=.F. -> sempre desabilitado (informativo)
928:         par_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
929:         WITH par_oPagina.obj_4c_Opc_situacao
930:             .ButtonCount = 2
931:             .Top         = 67
932:             .Left        = 504
933:             .Width       = 117
934:             .Height      = 25
935:             .BackStyle   = 0
936:             .BorderStyle = 0
937:             .Value       = 1
938:             .Enabled     = .F.
939:             .Visible     = .T.
940: 
941:             WITH .Buttons(1)
942:                 .Caption   = "Ativa"
943:                 .Left      = 5
944:                 .Top       = 5
945:                 .AutoSize  = .T.
946:                 .ForeColor = RGB(90, 90, 90)
947:                 .Themes    = .F.
948:             ENDWITH
949: 
950:             WITH .Buttons(2)
951:                 .Caption   = "Inativa"
952:                 .Left      = 63
953:                 .Top       = 5
954:                 .AutoSize  = .T.
955:                 .FontName  = "Tahoma"
956:                 .FontSize  = 8
957:                 .ForeColor = RGB(90, 90, 90)
958:                 .Themes    = .F.

*-- Linhas 965 a 977:
965:         *--------------------------------------------------------------------------
966: 
967:         *-- Label "Fornecedor :" (Say11: top=69+29=98, left=182, width=64, height=15)
968:         par_oPagina.AddObject("lbl_4c_Label11", "Label")
969:         WITH par_oPagina.lbl_4c_Label11
970:             .Caption   = "Fornecedor :"
971:             .Top       = 98
972:             .Left      = 182
973:             .Width     = 64
974:             .Height    = 15
975:             .FontName  = "Tahoma"
976:             .FontSize  = 8
977:             .BackStyle = 0

*-- Linhas 984 a 993:
984:         *-- When=PROCURAR: habilitado apenas no modo busca (ReadOnly nos demais)
985:         par_oPagina.AddObject("txt_4c_Ifor", "TextBox")
986:         WITH par_oPagina.txt_4c_Ifor
987:             .Top       = 95
988:             .Left      = 251
989:             .Width     = 80
990:             .Height    = 23
991:             .FontName  = "Tahoma"
992:             .FontSize  = 8
993:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1000 a 1034:
1000:         *-- When=.F. -> sempre readonly
1001:         par_oPagina.AddObject("txt_4c_Dfor", "TextBox")
1002:         WITH par_oPagina.txt_4c_Dfor
1003:             .Top       = 95
1004:             .Left      = 333
1005:             .Width     = 290
1006:             .Height    = 23
1007:             .FontName  = "Tahoma"
1008:             .FontSize  = 8
1009:             .ForeColor = RGB(90, 90, 90)
1010:             .Value     = ""
1011:             .ReadOnly  = .T.
1012:             .Visible   = .T.
1013:         ENDWITH
1014: 
1015:         *-- BINDEVENTs para botoes Confirmar / Cancelar
1016:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1017:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1018: 
1019:         *--------------------------------------------------------------------------
1020:         *-- LINHA 4: Referencia Fornecedor + Qtde Minima
1021:         *-- Compensacao PageFrame +29: top=95->124, top=92->121
1022:         *--------------------------------------------------------------------------
1023: 
1024:         *-- Label "Ref. Fornecedor :" (Say12: top=95+29=124, left=158, w=88, h=15)
1025:         par_oPagina.AddObject("lbl_4c_Label12", "Label")
1026:         WITH par_oPagina.lbl_4c_Label12
1027:             .Caption   = "Ref. Fornecedor :"
1028:             .Top       = 124
1029:             .Left      = 158
1030:             .Width     = 88
1031:             .Height    = 15
1032:             .FontName  = "Tahoma"
1033:             .FontSize  = 8
1034:             .BackStyle = 0

*-- Linhas 1041 a 1066:
1041:         *-- When=PROCURAR: apenas no modo busca; readonly nos demais modos
1042:         par_oPagina.AddObject("txt_4c_Refs", "TextBox")
1043:         WITH par_oPagina.txt_4c_Refs
1044:             .Top       = 121
1045:             .Left      = 251
1046:             .Width     = 150
1047:             .Height    = 23
1048:             .FontName  = "Tahoma"
1049:             .FontSize  = 8
1050:             .ForeColor = RGB(90, 90, 90)
1051:             .Value     = ""
1052:             .ReadOnly  = .T.
1053:             .Visible   = .T.
1054:         ENDWITH
1055: 
1056:         *-- Label "Qtde Minima :" (Say13: top=95+29=124, left=470, w=68, h=15)
1057:         par_oPagina.AddObject("lbl_4c_Label13", "Label")
1058:         WITH par_oPagina.lbl_4c_Label13
1059:             .Caption   = "Qtde M" + CHR(237) + "nima :"
1060:             .Top       = 124
1061:             .Left      = 470
1062:             .Width     = 68
1063:             .Height    = 15
1064:             .FontName  = "Tahoma"
1065:             .FontSize  = 8
1066:             .BackStyle = 0

*-- Linhas 1073 a 1082:
1073:         *-- ReadOnly - calculado automaticamente pelo sistema
1074:         par_oPagina.AddObject("txt_4c_Qmin", "TextBox")
1075:         WITH par_oPagina.txt_4c_Qmin
1076:             .Top       = 121
1077:             .Left      = 543
1078:             .Width     = 80
1079:             .Height    = 23
1080:             .FontName  = "Tahoma"
1081:             .FontSize  = 8
1082:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1091 a 1100:
1091:         *--------------------------------------------------------------------------
1092:         par_oPagina.AddObject("grd_4c_GradeI", "Grid")
1093:         WITH par_oPagina.grd_4c_GradeI
1094:             .Top                = 154
1095:             .Left               = 146
1096:             .Width              = 692
1097:             .Height             = 436
1098:             .FontName           = "Verdana"
1099:             .FontSize           = 8
1100:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 1120 a 1170:
1120:         *-- Configurar colunas (ControlSource sera setado em ConfigurarRecordSourceGrid)
1121:         WITH par_oPagina.grd_4c_GradeI
1122:             .Column1.Width            = 45
1123:             .Column1.Header1.Caption  = "Emp"
1124:             .Column1.Header1.Alignment = 2
1125:             .Column1.ReadOnly         = .F.
1126:             .Column1.Sparse           = .F.
1127: 
1128:             .Column2.Width            = 90
1129:             .Column2.Header1.Caption  = "Qtde. M" + CHR(237) + "nima"
1130:             .Column2.Header1.Alignment = 2
1131:             .Column2.ReadOnly         = .F.
1132:             .Column2.Sparse           = .F.
1133: 
1134:             .Column3.Width            = 70
1135:             .Column3.Header1.Caption  = "Tamanho"
1136:             .Column3.Header1.Alignment = 2
1137:             .Column3.ReadOnly         = .F.
1138:             .Column3.Sparse           = .F.
1139: 
1140:             .Column4.Width            = 55
1141:             .Column4.Header1.Caption  = "Cor"
1142:             .Column4.Header1.Alignment = 2
1143:             .Column4.ReadOnly         = .F.
1144:             .Column4.Sparse           = .F.
1145: 
1146:             .Column5.Width            = 85
1147:             .Column5.Header1.Caption  = "Grupo"
1148:             .Column5.Header1.Alignment = 2
1149:             .Column5.ReadOnly         = .F.
1150:             .Column5.Sparse           = .F.
1151: 
1152:             .Column6.Width            = 85
1153:             .Column6.Header1.Caption  = "Conta"
1154:             .Column6.Header1.Alignment = 2
1155:             .Column6.ReadOnly         = .F.
1156:             .Column6.Sparse           = .F.
1157: 
1158:             .Column7.Width            = 85
1159:             .Column7.Header1.Caption  = "Local"
1160:             .Column7.Header1.Alignment = 2
1161:             .Column7.ReadOnly         = .F.
1162:             .Column7.Sparse           = .F.
1163: 
1164:             .Column8.Width            = 90
1165:             .Column8.Header1.Caption  = "Estoque Alvo"
1166:             .Column8.Header1.Alignment = 2
1167:             .Column8.ReadOnly         = .F.
1168:             .Column8.Sparse           = .F.
1169:         ENDWITH
1170: 

*-- Linhas 1190 a 1202:
1190:         *-- Botao Excluir linha do grid (btnExcluir: top=313+29=342, left=843, w=45, h=45)
1191:         *-- Standalone com icone - usar Themes=.T. + DisabledPicture (Problem 29)
1192:         *--------------------------------------------------------------------------
1193:         par_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
1194:         WITH par_oPagina.cmd_4c_BtnExcluir
1195:             .Caption         = ""
1196:             .Top             = 342
1197:             .Left            = 843
1198:             .Width           = 45
1199:             .Height          = 45
1200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1201:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1202:             .PicturePosition = 0

*-- Linhas 1211 a 1277:
1211:             .Enabled         = .F.
1212:             .Visible         = .T.
1213:         ENDWITH
1214:         BINDEVENT(par_oPagina.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirLinhaClick")
1215: 
1216:         *--------------------------------------------------------------------------
1217:         *-- PARTE INFERIOR: "Retiravel :" + OptionGroup optRetiras
1218:         *-- Compensacao PageFrame +29: top=569->598, top=563->592
1219:         *--------------------------------------------------------------------------
1220: 
1221:         *-- Label "Retiravel :" (Say2: top=569+29=598, left=156)
1222:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
1223:         WITH par_oPagina.lbl_4c_Label2
1224:             .Caption   = "Retir" + CHR(225) + "vel :"
1225:             .Top       = 598
1226:             .Left      = 156
1227:             .FontName  = "Tahoma"
1228:             .FontSize  = 8
1229:             .BackStyle = 0
1230:             .ForeColor = RGB(90, 90, 90)
1231:             .Visible   = .T.
1232:         ENDWITH
1233: 
1234:         *-- OptionGroup Retiravel (optRetiras: top=563+29=592, left=207, w=168, h=27, 3 botoes)
1235:         *-- When=.F. no legado: display-only, atualizado via GradeIAfterRowColChange
1236:         par_oPagina.AddObject("obj_4c_OptRetiras", "OptionGroup")
1237:         WITH par_oPagina.obj_4c_OptRetiras
1238:             .ButtonCount = 3
1239:             .Top         = 592
1240:             .Left        = 207
1241:             .Width       = 168
1242:             .Height      = 27
1243:             .BackStyle   = 0
1244:             .BorderStyle = 0
1245:             .Value       = 1
1246:             .Enabled     = .F.
1247:             .Visible     = .T.
1248: 
1249:             WITH .Buttons(1)
1250:                 .Caption   = "Sim"
1251:                 .Left      = 5
1252:                 .Top       = 5
1253:                 .AutoSize  = .T.
1254:                 .ForeColor = RGB(90, 90, 90)
1255:                 .Themes    = .F.
1256:             ENDWITH
1257: 
1258:             WITH .Buttons(2)
1259:                 .Caption   = "N" + CHR(227) + "o"
1260:                 .Left      = 50
1261:                 .Top       = 5
1262:                 .AutoSize  = .T.
1263:                 .FontName  = "Tahoma"
1264:                 .FontSize  = 8
1265:                 .ForeColor = RGB(90, 90, 90)
1266:                 .Themes    = .F.
1267:             ENDWITH
1268: 
1269:             WITH .Buttons(3)
1270:                 .Caption   = "Produto"
1271:                 .Left      = 100
1272:                 .Top       = 5
1273:                 .AutoSize  = .T.
1274:                 .FontName  = "Tahoma"
1275:                 .FontSize  = 8
1276:                 .ForeColor = RGB(90, 90, 90)
1277:                 .Themes    = .F.

*-- Linhas 1487 a 1495:
1487:             loc_oPg2.txt_4c_Qmin.ReadOnly = .T.
1488: 
1489:             loc_oPg2.grd_4c_GradeI.ReadOnly                = !par_lHabilitar
1490:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1491:         CATCH TO loc_oErro
1492:             MsgErro(loc_oErro.Message, "FormEmn.HabilitarCampos")
1493:         ENDTRY
1494:     ENDPROC
1495: 

*-- Linhas 1560 a 1575:
1560:             loc_oGrid.Column8.ControlSource = "CrSigCdMin.qideal"
1561: 
1562:             *-- Resetar headers (RecordSource pode ter limpo as captions)
1563:             loc_oGrid.Column1.Header1.Caption = "Emp"
1564:             loc_oGrid.Column2.Header1.Caption = "Qtde. M" + CHR(237) + "nima"
1565:             loc_oGrid.Column3.Header1.Caption = "Tamanho"
1566:             loc_oGrid.Column4.Header1.Caption = "Cor"
1567:             loc_oGrid.Column5.Header1.Caption = "Grupo"
1568:             loc_oGrid.Column6.Header1.Caption = "Conta"
1569:             loc_oGrid.Column7.Header1.Caption = "Local"
1570:             loc_oGrid.Column8.Header1.Caption = "Estoque Alvo"
1571: 
1572:             *-- Habilitar/desabilitar colunas Tamanho e Cor conforme flags do produto
1573:             loc_oGrid.Column3.ReadOnly = !loc_oBO.this_lTemTam
1574:             loc_oGrid.Column4.ReadOnly = !loc_oBO.this_lTemCor
1575: 

*-- Linhas 2275 a 2283:
2275:             loc_oPg2.obj_4c_OptRetiras.Value = loc_nRetiras
2276: 
2277:             *-- Habilitar excluir linha apenas se empresa preenchida e modo edicao
2278:             loc_oPg2.cmd_4c_BtnExcluir.Enabled = ;
2279:                 (!EMPTY(ALLTRIM(CrSigCdMin.emps)) AND THIS.this_cModoAtual <> "VISUALIZAR")
2280:         CATCH TO loc_oErro
2281:             MsgErro(loc_oErro.Message, "FormEmn.GradeIAfterRowColChange")
2282:         ENDTRY
2283:     ENDPROC

*-- Linhas 2292 a 2308:
2292:             loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2293:             loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2294: 
2295:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
2296:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
2297:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .T.
2298:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .T.
2299:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
2300: 
2301:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
2302:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
2303:             loc_oPg2.cmd_4c_BtnExcluir.Visible             = loc_lEdicao
2304: 
2305:             THIS.HabilitarCampos(loc_lEdicao)
2306:         CATCH TO loc_oErro
2307:             MsgErro(loc_oErro.Message, "FormEmn.AjustarBotoesPorModo")
2308:         ENDTRY


### BO (C:\4c\projeto\app\classes\EmnBO.prg):
*==============================================================================
* EmnBO.prg - Business Object para Estoque Alvo (Minimo por Produto/Empresa)
* Tabela: SigCdMin
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS EmnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades do cabecalho do produto (SigCdPro + lookups)
    *--------------------------------------------------------------------------
    this_cCPros     = ""    && Codigo do produto          char(14)
    this_cDPros     = ""    && Descricao do produto
    this_cCGrus     = ""    && Codigo do grupo do produto
    this_cDGrus     = ""    && Descricao do grupo do produto
    this_cIFors     = ""    && Codigo do fornecedor
    this_cRClis     = ""    && Razao social do fornecedor
    this_cReffs     = ""    && Referencia do fornecedor
    this_nQMins     = 0     && Quantidade minima geral   numeric(8,2)
    this_nSituas    = 1     && Situacao: 1=Ativo, 2=Inativo

    *--------------------------------------------------------------------------
    * Propriedades de um item do grid (linha de SigCdMin)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""    && Chave unica / PRIMARY KEY  char(20)
    this_cEmps      = ""    && Empresa                    char(3)
    this_cLocals    = ""    && Local                      char(10)
    this_nQMinsItem = 0     && Quantidade minima          numeric(8,2)
    this_cCodTams   = ""    && Codigo do tamanho          char(4)
    this_cCodCores  = ""    && Codigo da cor              char(4)
    this_cOrdems    = ""    && Ordem                      char(1)
    this_cContas    = ""    && Conta                      char(10)
    this_cGrupos    = ""    && Grupo                      char(10)
    this_nQIdeal    = 0     && Quantidade ideal            numeric(7,2)
    this_nRetiras   = 1     && Retiravel: 1=Sim, 2=Nao, 3=Produto  numeric(1,0)
    this_nPIdeal    = 0     && Preco ideal                numeric(7,3)
    this_nPMins     = 0     && Preco minimo               numeric(7,3)

    *--------------------------------------------------------------------------
    * Flags de produto (determinam habilitacao de colunas na grade)
    *--------------------------------------------------------------------------
    this_lTemCor    = .F.   && Produto tem variacoes de cor
    this_lTemTam    = .F.   && Produto tem variacoes de tamanho
    this_nTipoEstos = 0     && Tipo de estoque do grupo do produto

    *--------------------------------------------------------------------------
    * Controle de modo externo (form chamado por outro form)
    *--------------------------------------------------------------------------
    this_cProdutoExterno = ""   && Codigo do produto fixado externamente
    this_cModoExterno    = ""   && Modo de operacao externo (INSERIR/ALTERAR)

    *--------------------------------------------------------------------------
    * Cursor principal do grid (preserva nome legado para compatibilidade)
    *--------------------------------------------------------------------------
    this_cCursorGrid  = "CrSigCdMin"   && Cursor do grid de minimos por empresa
    this_cCursorLista = "CrProdutos"   && Cursor da lista de produtos (Page1)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMin"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico usando NEWID() do SQL Server
    *==========================================================================
    FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nRes
        loc_cChave = ""

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36),NEWID()),'-',''),20) AS id", ;
                "cursor_4c_NewId")
            IF loc_nRes > 0 AND USED("cursor_4c_NewId") AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                GO TOP
                loc_cChave = ALLTRIM(cursor_4c_NewId.id)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.GerarChaveUnica")
        ENDTRY

        IF USED("cursor_4c_NewId")
            USE IN cursor_4c_NewId
        ENDIF

        IF EMPTY(loc_cChave)
            loc_cChave = LEFT(DTOS(DATE()) + STRTRAN(TRANSFORM(SECONDS()), ".", "") + SYS(2015), 20)
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de um cursor de SigCdMin
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor) AND RECCOUNT(par_cAliasCursor) > 0
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCPros     = TratarNulo(cpros,     "C")
                THIS.this_cEmps      = TratarNulo(emps,      "C")
                THIS.this_cLocals    = TratarNulo(locals,    "C")
                THIS.this_nQMinsItem = TratarNulo(qmins,     "N")
                THIS.this_cCodTams   = TratarNulo(codtams,   "C")
                THIS.this_cCodCores  = TratarNulo(codcores,  "C")
                THIS.this_cOrdems    = TratarNulo(ordems,    "C")
                THIS.this_cContas    = TratarNulo(contas,    "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_nQIdeal    = TratarNulo(qideal,    "N")
                THIS.this_nRetiras   = TratarNulo(retiras,   "N")
                THIS.this_nPIdeal    = TratarNulo(pideal,    "N")
                THIS.this_nPMins     = TratarNulo(pmins,     "N")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista produtos que possuem estoque alvo configurado
    *          Retorna cursor CrProdutos para a grade da Page1
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        IF USED("CrProdutos")
            USE IN CrProdutos
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cFiltro))
            ENDIF

            loc_cSQL = loc_cSQL + " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CrProdutos")

            IF loc_nRes > 0
                SELECT CrProdutos
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar produtos: " + CapturarErroSQL(), "EmnBO.Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarItens - Carrega grid de itens para um produto especifico
    *               Retorna cursor CrSigCdMin (com colunas do JOIN)
    *               Tambem cria CsCabec e seta flags lTemCor/lTemTam
    *==========================================================================
    PROCEDURE BuscarItens(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        IF USED("CrSigCdMin")
            USE IN CrSigCdMin
        ENDIF
        IF USED("CsCabec")
            USE IN CsCabec
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, a.emps, a.locals, a.qmins, a.codtams, a.codcores," + ;
                " a.ordems, a.cidchaves, a.contas, a.grupos, a.qideal, a.retiras," + ;
                " a.pideal, a.pmins," + ;
                " b.dpros, b.ifors, b.reffs, b.cgrus, b.situas, c.rclis, g.dgrus" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = b.ifors" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = b.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ;
                " ORDER BY a.emps, a.codtams, a.codcores"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdMin")

            IF loc_nRes > 0
                SELECT CrSigCdMin
                GO TOP

                *-- Criar CsCabec com dados de cabecalho do produto
                THIS.CarregarCabecalho()

                *-- Atualizar flags de cor/tamanho
                THIS.BuscarFlags(par_cCPros)

                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar itens do produto: " + CapturarErroSQL(), "EmnBO.BuscarItens")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.BuscarItens")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarFlags - Carrega flags lTemCor/lTemTam de SigCdPro x SigCdGrp
    *==========================================================================
    PROCEDURE BuscarFlags(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        THIS.this_lTemCor    = .F.
        THIS.this_lTemTam    = .F.
        THIS.this_nTipoEstos = 0

        IF EMPTY(ALLTRIM(par_cCPros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT b.cores, b.tams, b.tipoestos" + ;
                " FROM SigCdPro a" + ;
                " INNER JOIN SigCdGrp b ON b.cgrus = a.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros))

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Flags")

            IF loc_nRes > 0 AND USED("cursor_4c_Flags") AND RECCOUNT("cursor_4c_Flags") > 0
                SELECT cursor_4c_Flags
                GO TOP
                THIS.this_nTipoEstos = TratarNulo(tipoestos, "N")
                THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR (TratarNulo(cores, "N") = 1)
                THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR (TratarNulo(tams,  "N") = 1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.BuscarFlags")
        ENDTRY

        IF USED("cursor_4c_Flags")
            USE IN cursor_4c_Flags
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarCabecalho - Cria cursor CsCabec com dados de cabecalho do produto
    *                     a partir do CrSigCdMin ja carregado
    *==========================================================================
    PROTECTED PROCEDURE CarregarCabecalho()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED("CsCabec")
            USE IN CsCabec
        ENDIF

        TRY
            IF USED("CrSigCdMin") AND RECCOUNT("CrSigCdMin") > 0
                SELECT DISTINCT cpros, dpros, cgrus, dgrus, ifors, rclis, reffs, qmins, qideal, situas ;
                    FROM CrSigCdMin ;
                    INTO CURSOR CsCabec READWRITE
                GO TOP IN CsCabec
            ELSE
                CREATE CURSOR CsCabec ( ;
                    cpros    C(14), dpros C(65), cgrus  C(3), ;
                    dgrus    C(20), ifors C(10), rclis  C(50), ;
                    reffs    C(20), qmins N(8,2), qideal N(7,2), ;
                    situas   N(1,0))
                INSERT INTO CsCabec (cpros, dpros, cgrus, dgrus, ifors, rclis, reffs, qmins, qideal, situas) ;
                    VALUES (SPACE(14), SPACE(65), SPACE(3), SPACE(20), SPACE(10), SPACE(50), SPACE(20), 0, 0, 1)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarCabecalho")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega propriedades de cabecalho para um produto
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCPros))
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.cgrus, b.situas," + ;
                " c.rclis, g.dgrus, a.qmins, a.qideal" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = b.ifors" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = b.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ;
                " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.cgrus, b.situas, c.rclis, g.dgrus, a.qmins, a.qideal"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cabec")

            IF loc_nRes > 0 AND USED("cursor_4c_Cabec") AND RECCOUNT("cursor_4c_Cabec") > 0
                SELECT cursor_4c_Cabec
                GO TOP
                THIS.this_cCPros    = ALLTRIM(TratarNulo(cpros,  "C"))
                THIS.this_cDPros    = ALLTRIM(TratarNulo(dpros,  "C"))
                THIS.this_cIFors    = ALLTRIM(TratarNulo(ifors,  "C"))
                THIS.this_cReffs    = ALLTRIM(TratarNulo(reffs,  "C"))
                THIS.this_cCGrus    = ALLTRIM(TratarNulo(cgrus,  "C"))
                THIS.this_nSituas   = TratarNulo(situas, "N")
                THIS.this_cRClis    = ALLTRIM(TratarNulo(rclis,  "C"))
                THIS.this_cDGrus    = ALLTRIM(TratarNulo(dgrus,  "C"))
                THIS.this_nQMins    = TratarNulo(qmins,  "N")
                THIS.this_nQIdeal   = TratarNulo(qideal, "N")
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Cabec")
            USE IN cursor_4c_Cabec
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * SalvarGrid - Salva todos os itens do grid no SQL Server
    *              Estrategia: DELETE todos os itens do produto, INSERT novos
    *              Apenas linhas com emps preenchido sao salvas
    *==========================================================================
    PROTECTED PROCEDURE SalvarGrid(par_cCPros)
        LOCAL loc_lResultado, loc_nRes, loc_lTransacao
        LOCAL loc_cSQL, loc_cCidChaves
        loc_lResultado = .F.
        loc_lTransacao = .F.

        IF EMPTY(ALLTRIM(par_cCPros))
            MsgAviso("C" + CHR(243) + "digo do produto inv" + CHR(225) + "lido para SalvarGrid.")
            RETURN .F.
        ENDIF

        IF !USED("CrSigCdMin")
            MsgErro("Cursor CrSigCdMin n" + CHR(227) + "o encontrado.", "EmnBO.SalvarGrid")
            RETURN .F.
        ENDIF

        TRY
            *-- Iniciar transacao
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            *-- Deletar todos os registros existentes para este produto
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdMin WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCPros)), ;
                "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nRes < 0
                MsgErro("Erro ao excluir registros antigos: " + CapturarErroSQL(), "EmnBO.SalvarGrid")
            ELSE
                *-- Inserir linhas validas do cursor local
                loc_lResultado = .T.
                SELECT CrSigCdMin
                GO TOP

                SCAN FOR !DELETED()
                    IF !EMPTY(ALLTRIM(CrSigCdMin.emps))
                        *-- Gerar cidchaves se necessario
                        loc_cCidChaves = ALLTRIM(CrSigCdMin.cidchaves)
                        IF EMPTY(loc_cCidChaves)
                            loc_cCidChaves = THIS.GerarChaveUnica()
                        ENDIF

                        loc_cSQL = "INSERT INTO SigCdMin" + ;
                            " (cpros, emps, locals, qmins, codtams, codcores," + ;
                            " ordems, cidchaves, contas, grupos, qideal, retiras, pideal, pmins)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(CrSigCdMin.cpros))    + ", " + ;
                            EscaparSQL(ALLTRIM(CrSigCdMin.emps))     + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.locals),   10)) + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.qmins)      + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.codtams),   4)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.codcores),  4)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.ordems),    1)) + ", " + ;
                            EscaparSQL(LEFT(loc_cCidChaves,               20)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.contas),   10)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.grupos),   10)) + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.qideal)     + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.retiras)    + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.pideal)     + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.pmins)      + ;
                            ")"

                        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                        IF USED("cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF

                        IF loc_nRes < 0
                            MsgErro("Erro ao inserir item: " + CapturarErroSQL(), "EmnBO.SalvarGrid")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN

                IF loc_lResultado
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransacao = .F.
                    THIS.RegistrarAuditoria("SAVE")
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo), "EmnBO.SalvarGrid")
            loc_lResultado = .F.
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Chamado pelo BusinessBase.Salvar() para novo produto
    *           Delega para SalvarGrid
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.SalvarGrid(THIS.this_cCPros)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Chamado pelo BusinessBase.Salvar() para produto existente
    *             Delega para SalvarGrid
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.SalvarGrid(THIS.this_cCPros)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui TODOS os itens SigCdMin de um produto
    *                    Chamado via BusinessBase.Excluir()
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCPros))
                MsgAviso("C" + CHR(243) + "digo do produto inv" + CHR(225) + "lido.")
            ELSE
                loc_cSQL = "DELETE FROM SigCdMin WHERE cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Exc")

                IF USED("cursor_4c_Exc")
                    USE IN cursor_4c_Exc
                ENDIF

                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir: " + CapturarErroSQL(), "EmnBO.ExecutarExclusao")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarCopia - Cria cursor CsCopia com comparacao de itens entre empresas
    *                  Cores Vermelho(0/naoexiste-dest) Preto(0/existe) Azul(2/naoexiste-orig)
    *==========================================================================
    PROCEDURE ProcessarCopia(par_cEmpO, par_cEmpD, par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        LOCAL loc_cFiltroO, loc_cFiltroD, loc_cFiltroProd
        loc_lResultado = .F.

        IF USED("CsCopia")
            USE IN CsCopia
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cEmpO)) OR EMPTY(ALLTRIM(par_cEmpD))
                MsgErro("Empresas Origem e Destino s" + CHR(227) + "o obrigat" + CHR(243) + "rias.", "EmnBO.ProcessarCopia")
            ELSE
                loc_cFiltroO   = EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3))
                loc_cFiltroD   = EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))
                loc_cFiltroProd = ""
                IF !EMPTY(ALLTRIM(par_cCPros))
                    loc_cFiltroProd = " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCPros), 14))
                ENDIF

                *-- Itens que existem na Origem mas NAO no Destino (marcas=1, existes=0)
                loc_cSQL = "SELECT CAST(1 AS int) AS marcas, CAST(0 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroO + loc_cFiltroProd + ;
                    " AND (a.cpros + a.codtams + a.codcores) NOT IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroD + ")" + ;
                    " UNION ALL" + ;
                    " SELECT CAST(0 AS int) AS marcas, CAST(1 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroO + loc_cFiltroProd + ;
                    " AND a.cpros + a.codtams + a.codcores IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroD + ")" + ;
                    " UNION ALL" + ;
                    " SELECT CAST(0 AS int) AS marcas, CAST(2 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroD + loc_cFiltroProd + ;
                    " AND a.cpros + a.codtams + a.codcores NOT IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroO + ")"

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CsCopia")

                IF loc_nRes > 0
                    SELECT CsCopia
                    GO TOP
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao processar c" + CHR(243) + "pia: " + CapturarErroSQL(), "EmnBO.ProcessarCopia")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.ProcessarCopia")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CopiarItens - Copia itens marcados de CsCopia para empresa destino
    *               Apenas linhas marcas=1 E existes=0 sao copiadas
    *==========================================================================
    PROCEDURE CopiarItens(par_cEmpD)
        LOCAL loc_lResultado, loc_nRes, loc_nCopias, loc_nTotal
        LOCAL loc_cSQL, loc_cCidChaves, loc_lTransacao
        loc_lResultado = .F.
        loc_nCopias    = 0
        loc_nTotal     = 0
        loc_lTransacao = .F.

        TRY
            IF !USED("CsCopia") OR RECCOUNT("CsCopia") = 0
                MsgErro("Cursor CsCopia vazio. Execute ProcessarCopia primeiro.", "EmnBO.CopiarItens")
            ELSE
                IF EMPTY(ALLTRIM(par_cEmpD))
                MsgErro("Empresa Destino inv" + CHR(225) + "lida.", "EmnBO.CopiarItens")
            ELSE
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.
                loc_lResultado = .T.

                SELECT CsCopia
                COUNT FOR !DELETED() TO loc_nTotal
                GO TOP

                SCAN FOR !DELETED() AND CsCopia.marcas = 1 AND CsCopia.existes = 0
                    loc_cCidChaves = THIS.GerarChaveUnica()

                    loc_cSQL = "INSERT INTO SigCdMin" + ;
                        " (cpros, emps, locals, qmins, qideal, codtams, codcores," + ;
                        " cidchaves, contas, grupos, ordems, retiras, pideal, pmins)" + ;
                        " VALUES (" + ;
                        EscaparSQL(ALLTRIM(CsCopia.cpros))               + ", " + ;
                        EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))          + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.locals),  10))   + ", " + ;
                        FormatarNumeroSQL(CsCopia.qmins)                 + ", " + ;
                        FormatarNumeroSQL(CsCopia.qideal)                + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.codtams), 4))    + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.codcores), 4))   + ", " + ;
                        EscaparSQL(LEFT(loc_cCidChaves, 20))             + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.contas), 10))    + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.grupos), 10))    + ", " + ;
                        "' ', 1, 0, 0)"

                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Copia")
                    IF USED("cursor_4c_Copia")
                        USE IN cursor_4c_Copia
                    ENDIF

                    IF loc_nRes >= 0
                        loc_nCopias = loc_nCopias + 1
                    ELSE
                        MsgErro("Erro ao copiar item: " + CapturarErroSQL(), "EmnBO.CopiarItens")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_lResultado
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransacao = .F.
                    MsgInfo("Foram copiados " + TRANSFORM(loc_nCopias) + " de " + ;
                        TRANSFORM(loc_nTotal) + " registros.")
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacao = .F.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CopiarItens")
            loc_lResultado = .F.
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

