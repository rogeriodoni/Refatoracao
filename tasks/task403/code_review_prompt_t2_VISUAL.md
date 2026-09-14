# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGCDEMN.Pagina.Dados): Top original=38 vs migrado 'obj_4c_Opc_situacao' Top=5 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGCDEMN.Pagina.Dados): Left original=504 vs migrado 'obj_4c_Opc_situacao' Left=5 (diff=499px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optRetiras' (parent: SIGCDEMN.Pagina.Dados): Top original=563 vs migrado 'obj_4c_OptRetiras' Top=5 (diff=558px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optRetiras' (parent: SIGCDEMN.Pagina.Dados): Left original=207 vs migrado 'obj_4c_OptRetiras' Left=5 (diff=202px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEmn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2313 linhas total):

*-- Linhas 62 a 73:
62: 
63:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
64:                     THIS.ConfigurarPageFrame()
65:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
66:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
67:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
68:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
69:                     THIS.pgf_4c_Paginas.Visible = .T.
70:                     THIS.pgf_4c_Paginas.ActivePage = 1
71:                     THIS.this_cModoAtual = "LISTA"
72:                     THIS.CarregarLista()
73:                     loc_lResultado = .T.

*-- Linhas 92 a 101:
92: 
93:         WITH THIS.pgf_4c_Paginas
94:             .PageCount  = 2
95:             .Top        = -29
96:             .Left       = 0
97:             .Width      = THIS.Width
98:             .Height     = THIS.Height + 29
99:             .Tabs       = .F.
100:             .Visible    = .T.
101: 

*-- Linhas 120 a 190:
120:     PROTECTED PROCEDURE ConfigurarPaginaLista(par_oPagina)
121: 
122:         *-- Cabecalho escuro com titulo (cntSombra legado)
123:         *-- Compensacao PageFrame: cntSombra.Top=1 + 29 = 30
124:         par_oPagina.AddObject("cnt_4c_Sombra", "Container")
125:         WITH par_oPagina.cnt_4c_Sombra
126:             .Top         = 30
127:             .Left        = 0
128:             .Width       = THIS.Width
129:             .Height      = 80
130:             .BackColor   = RGB(100, 100, 100)
131:             .BorderWidth = 0
132:             .Visible     = .T.
133:         ENDWITH
134: 
135:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
136:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
137:             .Top       = 15
138:             .Left      = 10
139:             .Width     = THIS.Width - 12
140:             .Height    = 40
141:             .Caption   = THIS.Caption
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .ForeColor = RGB(0, 0, 0)
146:             .BackStyle = 0
147:             .AutoSize  = .F.
148:             .Visible   = .T.
149:         ENDWITH
150: 
151:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
152:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
153:             .Top       = 18
154:             .Left      = 10
155:             .Width     = THIS.Width - 12
156:             .Height    = 46
157:             .Caption   = THIS.Caption
158:             .FontName  = "Tahoma"
159:             .FontSize  = 16
160:             .FontBold  = .T.
161:             .ForeColor = RGB(255, 255, 255)
162:             .BackStyle = 0
163:             .AutoSize  = .F.
164:             .Visible   = .T.
165:         ENDWITH
166: 
167:         *-- Container de botoes CRUD (Grupo_op legado)
168:         *-- Grupo_op.Top=-1 + 29 = 28, Left=544
169:         par_oPagina.AddObject("cnt_4c_Botoes", "Container")
170:         WITH par_oPagina.cnt_4c_Botoes
171:             .Top         = 28
172:             .Left        =  542
173:             .Width       = 385
174:             .Height      = 85
175:             .BackStyle = 0
176:             .BorderWidth = 0
177:             .Visible     = .T.
178:         ENDWITH
179: 
180:         *-- Botao Incluir (Inserir legado: Top=5, Left=5)
181:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
182:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
183:             .Caption         = "Incluir"
184:             .Top             = 5
185:             .Left            = 5
186:             .Width           = 75
187:             .Height          = 75
188:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
189:             .PicturePosition = 13
190:             .FontName        = "Tahoma"

*-- Linhas 200 a 215:
200:             .AutoSize        = .F.
201:             .Visible         = .T.
202:         ENDWITH
203:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
204: 
205:         *-- Botao Visualizar (Consultar legado: Top=5, Left=80)
206:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
207:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
208:             .Caption         = "Visualizar"
209:             .Top             = 5
210:             .Left            = 80
211:             .Width           = 75
212:             .Height          = 75
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
214:             .PicturePosition = 13
215:             .FontName        = "Tahoma"

*-- Linhas 225 a 240:
225:             .AutoSize        = .F.
226:             .Visible         = .T.
227:         ENDWITH
228:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
229: 
230:         *-- Botao Alterar (Top=5, Left=155)
231:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
232:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
233:             .Caption         = "Alterar"
234:             .Top             = 5
235:             .Left            = 155
236:             .Width           = 75
237:             .Height          = 75
238:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
239:             .PicturePosition = 13
240:             .FontName        = "Tahoma"

*-- Linhas 250 a 265:
250:             .AutoSize        = .F.
251:             .Visible         = .T.
252:         ENDWITH
253:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
254: 
255:         *-- Botao Excluir (Top=5, Left=230)
256:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
257:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
258:             .Caption         = "Excluir"
259:             .Top             = 5
260:             .Left            = 230
261:             .Width           = 75
262:             .Height          = 75
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
264:             .PicturePosition = 13
265:             .FontName        = "Tahoma"

*-- Linhas 275 a 290:
275:             .AutoSize        = .F.
276:             .Visible         = .T.
277:         ENDWITH
278:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
279: 
280:         *-- Botao Buscar (Procurar legado: Top=5, Left=305)
281:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
282:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
283:             .Caption         = "Buscar"
284:             .Top             = 5
285:             .Left            = 305
286:             .Width           = 75
287:             .Height          = 75
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
289:             .PicturePosition = 13
290:             .FontName        = "Tahoma"

*-- Linhas 300 a 326:
300:             .AutoSize        = .F.
301:             .Visible         = .T.
302:         ENDWITH
303:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
304: 
305:         *-- Container de saida - padrao canonico (Grupo_Saida legado)
306:         par_oPagina.AddObject("cnt_4c_Saida", "Container")
307:         WITH par_oPagina.cnt_4c_Saida
308:             .Top         = 28
309:             .Left        = 917
310:             .Width       = 90
311:             .Height      = 85
312:             .BackStyle   = 0
313:             .BorderWidth = 0
314:             .Visible     = .T.
315:         ENDWITH
316: 
317:         par_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
318:         WITH par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
319:             .Caption         = "Encerrar"
320:             .Top             = 5
321:             .Left            = 5
322:             .Width           = 75
323:             .Height          = 75
324:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
325:             .PicturePosition = 13
326:             .FontName        = "Tahoma"

*-- Linhas 337 a 352:
337:             .Visible         = .T.
338:         ENDWITH
339: 
340:         BINDEVENT(par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Grid da lista (Pagina.Lista.Grade legado: Top=121, Left=12, Width=939, Height=470)
343:         *-- Compensacao PageFrame: Top=121 + 29 = 150
344:         par_oPagina.AddObject("grd_4c_Lista", "Grid")
345:         WITH par_oPagina.grd_4c_Lista
346:             .Top               = 150
347:             .Left              = 12
348:             .Width             = 939
349:             .Height            = 435
350:             .FontName          = "Verdana"
351:             .FontSize          = 8
352:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 397 a 437:
397: 
398:                         loc_oGrid.Column1.ControlSource   = "CrProdutos.cpros"
399:                         loc_oGrid.Column1.Width           = 100
400:                         loc_oGrid.Column1.Header1.Caption = ""
401:                         loc_oGrid.Column1.Header1.Alignment = 2
402:                         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
403:                         loc_oGrid.Column1.Header1.FontSize  = 8
404:                         loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)
405: 
406:                         loc_oGrid.Column2.ControlSource   = "CrProdutos.dpros"
407:                         loc_oGrid.Column2.Width           = 430
408:                         loc_oGrid.Column2.Header1.Caption = "Produto"
409:                         loc_oGrid.Column2.Header1.Alignment = 2
410:                         loc_oGrid.Column2.Header1.FontName  = "Tahoma"
411:                         loc_oGrid.Column2.Header1.FontSize  = 8
412:                         loc_oGrid.Column2.Header1.ForeColor = RGB(90, 90, 90)
413: 
414:                         loc_oGrid.Column3.ControlSource   = "CrProdutos.ifors"
415:                         loc_oGrid.Column3.Width           = 100
416:                         loc_oGrid.Column3.Header1.Caption = ""
417:                         loc_oGrid.Column3.Header1.Alignment = 2
418:                         loc_oGrid.Column3.Header1.FontName  = "Tahoma"
419:                         loc_oGrid.Column3.Header1.FontSize  = 8
420:                         loc_oGrid.Column3.Header1.ForeColor = RGB(90, 90, 90)
421: 
422:                         loc_oGrid.Column4.ControlSource   = "CrProdutos.reffs"
423:                         loc_oGrid.Column4.Width           = 150
424:                         loc_oGrid.Column4.Header1.Caption = ""
425:                         loc_oGrid.Column4.Header1.Alignment = 2
426:                         loc_oGrid.Column4.Header1.FontName  = "Tahoma"
427:                         loc_oGrid.Column4.Header1.FontSize  = 8
428:                         loc_oGrid.Column4.Header1.ForeColor = RGB(90, 90, 90)
429: 
430:                         loc_oGrid.Column5.ControlSource   = "CrProdutos.sgrus"
431:                         loc_oGrid.Column5.Width           = 140
432:                         loc_oGrid.Column5.Header1.Caption = ""
433:                         loc_oGrid.Column5.Header1.Alignment = 2
434:                         loc_oGrid.Column5.Header1.FontName  = "Tahoma"
435:                         loc_oGrid.Column5.Header1.FontSize  = 8
436:                         loc_oGrid.Column5.Header1.ForeColor = RGB(90, 90, 90)
437: 

*-- Linhas 707 a 774:
707:         *-- Top = 1 + 29 = 30
708:         par_oPagina.AddObject("cnt_4c_Sombra", "Container")
709:         WITH par_oPagina.cnt_4c_Sombra
710:             .Top         = 30
711:             .Left        = 0
712:             .Width       = THIS.Width
713:             .Height      = 80
714:             .BackColor   = RGB(100, 100, 100)
715:             .BorderWidth = 0
716:             .Visible     = .T.
717:         ENDWITH
718: 
719:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
720:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
721:             .Top       = 15
722:             .Left      = 10
723:             .Width     = THIS.Width - 12
724:             .Height    = 40
725:             .Caption   = THIS.Caption
726:             .FontName  = "Tahoma"
727:             .FontSize  = 16
728:             .FontBold  = .T.
729:             .ForeColor = RGB(0, 0, 0)
730:             .BackStyle = 0
731:             .AutoSize  = .F.
732:             .Visible   = .T.
733:         ENDWITH
734: 
735:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
736:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
737:             .Top       = 18
738:             .Left      = 10
739:             .Width     = THIS.Width - 12
740:             .Height    = 46
741:             .Caption   = THIS.Caption
742:             .FontName  = "Tahoma"
743:             .FontSize  = 16
744:             .FontBold  = .T.
745:             .ForeColor = RGB(255, 255, 255)
746:             .BackStyle = 0
747:             .AutoSize  = .F.
748:             .Visible   = .T.
749:         ENDWITH
750: 
751:         *-- Container de botoes Salvar/Cancelar (Grupo_Salva legado)
752:         *-- Grupo_Salva.Top=8 + 29 = 37, Left=820
753:         par_oPagina.AddObject("cnt_4c_Salva", "Container")
754:         WITH par_oPagina.cnt_4c_Salva
755:             .Top         = 37
756:             .Left        = 820
757:             .Width       = 160
758:             .Height      = 85
759:             .BackStyle   = 0
760:             .BorderWidth = 0
761:             .Visible     = .T.
762:         ENDWITH
763: 
764:         *-- Botao Confirmar/Salvar (Left=5, Top=5, Width=75, Height=75)
765:         par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
766:         WITH par_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
767:             .Caption         = "Confirmar"
768:             .Top             = 5
769:             .Left            = 5
770:             .Width           = 75
771:             .Height          = 75
772:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
773:             .PicturePosition = 13
774:             .FontName        = "Tahoma"

*-- Linhas 786 a 798:
786:         ENDWITH
787: 
788:         *-- Botao Cancelar (Left=80, Top=5, Width=75, Height=75)
789:         par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
790:         WITH par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
791:             .Caption         = "Encerrar"
792:             .Top             = 5
793:             .Left            = 80
794:             .Width           = 75
795:             .Height          = 75
796:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
797:             .PicturePosition = 13
798:             .FontName        = "Tahoma"

*-- Linhas 815 a 827:
815:         *--------------------------------------------------------------------------
816: 
817:         *-- Label "Produto :" (Say1: top=17+29=46, left=199, width=47, height=15)
818:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
819:         WITH par_oPagina.lbl_4c_Label1
820:             .Caption   = "Produto :"
821:             .Top       = 46
822:             .Left      = 199
823:             .Width     = 47
824:             .Height    = 15
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8
827:             .BackStyle = 0

*-- Linhas 834 a 843:
834:         *-- Lookup SigCdPro por cpros (quando INSERIR); readonly em outros modos
835:         par_oPagina.AddObject("txt_4c_Produto", "TextBox")
836:         WITH par_oPagina.txt_4c_Produto
837:             .Top       = 43
838:             .Left      = 251
839:             .Width     = 108
840:             .Height    = 23
841:             .FontName  = "Tahoma"
842:             .FontSize  = 8
843:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 849 a 858:
849:         *-- Lookup SigCdPro por dpros (quando INSERIR); readonly em outros modos
850:         par_oPagina.AddObject("txt_4c_Dpro", "TextBox")
851:         WITH par_oPagina.txt_4c_Dpro
852:             .Top       = 43
853:             .Left      = 361
854:             .Width     = 360
855:             .Height    = 23
856:             .FontName  = "Tahoma"
857:             .FontSize  = 8
858:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 867 a 879:
867:         *--------------------------------------------------------------------------
868: 
869:         *-- Label "Grupo :" (Say8: top=44+29=73, left=208, width=38, height=15)
870:         par_oPagina.AddObject("lbl_4c_Label8", "Label")
871:         WITH par_oPagina.lbl_4c_Label8
872:             .Caption   = "Grupo :"
873:             .Top       = 73
874:             .Left      = 208
875:             .Width     = 38
876:             .Height    = 15
877:             .FontName  = "Tahoma"
878:             .FontSize  = 8
879:             .BackStyle = 0

*-- Linhas 886 a 895:
886:         *-- When=.F. -> sempre readonly (preenchido automaticamente pelo produto)
887:         par_oPagina.AddObject("txt_4c_Cgru", "TextBox")
888:         WITH par_oPagina.txt_4c_Cgru
889:             .Top       = 69
890:             .Left      = 251
891:             .Width     = 31
892:             .Height    = 23
893:             .FontName  = "Tahoma"
894:             .FontSize  = 8
895:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 902 a 962:
902:         *-- When=.F. -> sempre readonly
903:         par_oPagina.AddObject("txt_4c_Dgru", "TextBox")
904:         WITH par_oPagina.txt_4c_Dgru
905:             .Top       = 69
906:             .Left      = 284
907:             .Width     = 150
908:             .Height    = 23
909:             .FontName  = "Tahoma"
910:             .FontSize  = 8
911:             .ForeColor = RGB(90, 90, 90)
912:             .Value     = ""
913:             .ReadOnly  = .T.
914:             .Visible   = .T.
915:         ENDWITH
916: 
917:         *-- Label "Situacao :" (Say19: top=44+29=73, left=456)
918:         par_oPagina.AddObject("lbl_4c_Label19", "Label")
919:         WITH par_oPagina.lbl_4c_Label19
920:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
921:             .Top       = 73
922:             .Left      = 456
923:             .FontName  = "Tahoma"
924:             .FontSize  = 8
925:             .BackStyle = 0
926:             .ForeColor = RGB(90, 90, 90)
927:             .Visible   = .T.
928:         ENDWITH
929: 
930:         *-- OptionGroup Situacao (Opc_situacao: top=38+29=67, left=504, width=117, height=25)
931:         *-- When=.F. -> sempre desabilitado (informativo)
932:         par_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
933:         WITH par_oPagina.obj_4c_Opc_situacao
934:             .ButtonCount = 2
935:             .Top         = 67
936:             .Left        = 504
937:             .Width       = 117
938:             .Height      = 25
939:             .BackStyle   = 0
940:             .BorderStyle = 0
941:             .Value       = 1
942:             .Enabled     = .F.
943:             .Visible     = .T.
944: 
945:             WITH .Buttons(1)
946:                 .Caption   = "Ativa"
947:                 .Left      = 5
948:                 .Top       = 5
949:                 .AutoSize  = .T.
950:                 .ForeColor = RGB(90, 90, 90)
951:                 .Themes    = .F.
952:             ENDWITH
953: 
954:             WITH .Buttons(2)
955:                 .Caption   = "Inativa"
956:                 .Left      = 63
957:                 .Top       = 5
958:                 .AutoSize  = .T.
959:                 .FontName  = "Tahoma"
960:                 .FontSize  = 8
961:                 .ForeColor = RGB(90, 90, 90)
962:                 .Themes    = .F.

*-- Linhas 969 a 981:
969:         *--------------------------------------------------------------------------
970: 
971:         *-- Label "Fornecedor :" (Say11: top=69+29=98, left=182, width=64, height=15)
972:         par_oPagina.AddObject("lbl_4c_Label11", "Label")
973:         WITH par_oPagina.lbl_4c_Label11
974:             .Caption   = "Fornecedor :"
975:             .Top       = 98
976:             .Left      = 182
977:             .Width     = 64
978:             .Height    = 15
979:             .FontName  = "Tahoma"
980:             .FontSize  = 8
981:             .BackStyle = 0

*-- Linhas 988 a 997:
988:         *-- When=PROCURAR: habilitado apenas no modo busca (ReadOnly nos demais)
989:         par_oPagina.AddObject("txt_4c_Ifor", "TextBox")
990:         WITH par_oPagina.txt_4c_Ifor
991:             .Top       = 95
992:             .Left      = 251
993:             .Width     = 80
994:             .Height    = 23
995:             .FontName  = "Tahoma"
996:             .FontSize  = 8
997:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1004 a 1038:
1004:         *-- When=.F. -> sempre readonly
1005:         par_oPagina.AddObject("txt_4c_Dfor", "TextBox")
1006:         WITH par_oPagina.txt_4c_Dfor
1007:             .Top       = 95
1008:             .Left      = 333
1009:             .Width     = 290
1010:             .Height    = 23
1011:             .FontName  = "Tahoma"
1012:             .FontSize  = 8
1013:             .ForeColor = RGB(90, 90, 90)
1014:             .Value     = ""
1015:             .ReadOnly  = .T.
1016:             .Visible   = .T.
1017:         ENDWITH
1018: 
1019:         *-- BINDEVENTs para botoes Confirmar / Cancelar
1020:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1021:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1022: 
1023:         *--------------------------------------------------------------------------
1024:         *-- LINHA 4: Referencia Fornecedor + Qtde Minima
1025:         *-- Compensacao PageFrame +29: top=95->124, top=92->121
1026:         *--------------------------------------------------------------------------
1027: 
1028:         *-- Label "Ref. Fornecedor :" (Say12: top=95+29=124, left=158, w=88, h=15)
1029:         par_oPagina.AddObject("lbl_4c_Label12", "Label")
1030:         WITH par_oPagina.lbl_4c_Label12
1031:             .Caption   = "Ref. Fornecedor :"
1032:             .Top       = 124
1033:             .Left      = 158
1034:             .Width     = 88
1035:             .Height    = 15
1036:             .FontName  = "Tahoma"
1037:             .FontSize  = 8
1038:             .BackStyle = 0

*-- Linhas 1045 a 1070:
1045:         *-- When=PROCURAR: apenas no modo busca; readonly nos demais modos
1046:         par_oPagina.AddObject("txt_4c_Refs", "TextBox")
1047:         WITH par_oPagina.txt_4c_Refs
1048:             .Top       = 121
1049:             .Left      = 251
1050:             .Width     = 150
1051:             .Height    = 23
1052:             .FontName  = "Tahoma"
1053:             .FontSize  = 8
1054:             .ForeColor = RGB(90, 90, 90)
1055:             .Value     = ""
1056:             .ReadOnly  = .T.
1057:             .Visible   = .T.
1058:         ENDWITH
1059: 
1060:         *-- Label "Qtde Minima :" (Say13: top=95+29=124, left=470, w=68, h=15)
1061:         par_oPagina.AddObject("lbl_4c_Label13", "Label")
1062:         WITH par_oPagina.lbl_4c_Label13
1063:             .Caption   = "Qtde M" + CHR(237) + "nima :"
1064:             .Top       = 124
1065:             .Left      = 470
1066:             .Width     = 68
1067:             .Height    = 15
1068:             .FontName  = "Tahoma"
1069:             .FontSize  = 8
1070:             .BackStyle = 0

*-- Linhas 1077 a 1086:
1077:         *-- ReadOnly - calculado automaticamente pelo sistema
1078:         par_oPagina.AddObject("txt_4c_Qmin", "TextBox")
1079:         WITH par_oPagina.txt_4c_Qmin
1080:             .Top       = 121
1081:             .Left      = 543
1082:             .Width     = 80
1083:             .Height    = 23
1084:             .FontName  = "Tahoma"
1085:             .FontSize  = 8
1086:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1095 a 1104:
1095:         *--------------------------------------------------------------------------
1096:         par_oPagina.AddObject("grd_4c_GradeI", "Grid")
1097:         WITH par_oPagina.grd_4c_GradeI
1098:             .Top                = 154
1099:             .Left               = 146
1100:             .Width              = 692
1101:             .Height             = 436
1102:             .FontName           = "Verdana"
1103:             .FontSize           = 8
1104:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 1124 a 1174:
1124:         *-- Configurar colunas (ControlSource sera setado em ConfigurarRecordSourceGrid)
1125:         WITH par_oPagina.grd_4c_GradeI
1126:             .Column1.Width            = 45
1127:             .Column1.Header1.Caption  = "Emp"
1128:             .Column1.Header1.Alignment = 2
1129:             .Column1.ReadOnly         = .F.
1130:             .Column1.Sparse           = .F.
1131: 
1132:             .Column2.Width            = 90
1133:             .Column2.Header1.Caption  = "Qtde. M" + CHR(237) + "nima"
1134:             .Column2.Header1.Alignment = 2
1135:             .Column2.ReadOnly         = .F.
1136:             .Column2.Sparse           = .F.
1137: 
1138:             .Column3.Width            = 70
1139:             .Column3.Header1.Caption  = "Tamanho"
1140:             .Column3.Header1.Alignment = 2
1141:             .Column3.ReadOnly         = .F.
1142:             .Column3.Sparse           = .F.
1143: 
1144:             .Column4.Width            = 55
1145:             .Column4.Header1.Caption  = "Cor"
1146:             .Column4.Header1.Alignment = 2
1147:             .Column4.ReadOnly         = .F.
1148:             .Column4.Sparse           = .F.
1149: 
1150:             .Column5.Width            = 85
1151:             .Column5.Header1.Caption  = "Grupo"
1152:             .Column5.Header1.Alignment = 2
1153:             .Column5.ReadOnly         = .F.
1154:             .Column5.Sparse           = .F.
1155: 
1156:             .Column6.Width            = 85
1157:             .Column6.Header1.Caption  = "Conta"
1158:             .Column6.Header1.Alignment = 2
1159:             .Column6.ReadOnly         = .F.
1160:             .Column6.Sparse           = .F.
1161: 
1162:             .Column7.Width            = 85
1163:             .Column7.Header1.Caption  = "Local"
1164:             .Column7.Header1.Alignment = 2
1165:             .Column7.ReadOnly         = .F.
1166:             .Column7.Sparse           = .F.
1167: 
1168:             .Column8.Width            = 90
1169:             .Column8.Header1.Caption  = "Estoque Alvo"
1170:             .Column8.Header1.Alignment = 2
1171:             .Column8.ReadOnly         = .F.
1172:             .Column8.Sparse           = .F.
1173:         ENDWITH
1174: 

*-- Linhas 1194 a 1206:
1194:         *-- Botao Excluir linha do grid (btnExcluir: top=313+29=342, left=843, w=45, h=45)
1195:         *-- Standalone com icone - usar Themes=.T. + DisabledPicture (Problem 29)
1196:         *--------------------------------------------------------------------------
1197:         par_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
1198:         WITH par_oPagina.cmd_4c_BtnExcluir
1199:             .Caption         = ""
1200:             .Top             = 342
1201:             .Left            = 843
1202:             .Width           = 45
1203:             .Height          = 45
1204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1205:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1206:             .PicturePosition = 0

*-- Linhas 1215 a 1281:
1215:             .Enabled         = .F.
1216:             .Visible         = .T.
1217:         ENDWITH
1218:         BINDEVENT(par_oPagina.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirLinhaClick")
1219: 
1220:         *--------------------------------------------------------------------------
1221:         *-- PARTE INFERIOR: "Retiravel :" + OptionGroup optRetiras
1222:         *-- Compensacao PageFrame +29: top=569->598, top=563->592
1223:         *--------------------------------------------------------------------------
1224: 
1225:         *-- Label "Retiravel :" (Say2: top=569+29=598, left=156)
1226:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
1227:         WITH par_oPagina.lbl_4c_Label2
1228:             .Caption   = "Retir" + CHR(225) + "vel :"
1229:             .Top       = 598
1230:             .Left      = 156
1231:             .FontName  = "Tahoma"
1232:             .FontSize  = 8
1233:             .BackStyle = 0
1234:             .ForeColor = RGB(90, 90, 90)
1235:             .Visible   = .T.
1236:         ENDWITH
1237: 
1238:         *-- OptionGroup Retiravel (optRetiras: top=563+29=592, left=207, w=168, h=27, 3 botoes)
1239:         *-- When=.F. no legado: display-only, atualizado via GradeIAfterRowColChange
1240:         par_oPagina.AddObject("obj_4c_OptRetiras", "OptionGroup")
1241:         WITH par_oPagina.obj_4c_OptRetiras
1242:             .ButtonCount = 3
1243:             .Top         = 592
1244:             .Left        = 207
1245:             .Width       = 168
1246:             .Height      = 27
1247:             .BackStyle   = 0
1248:             .BorderStyle = 0
1249:             .Value       = 1
1250:             .Enabled     = .F.
1251:             .Visible     = .T.
1252: 
1253:             WITH .Buttons(1)
1254:                 .Caption   = "Sim"
1255:                 .Left      = 5
1256:                 .Top       = 5
1257:                 .AutoSize  = .T.
1258:                 .ForeColor = RGB(90, 90, 90)
1259:                 .Themes    = .F.
1260:             ENDWITH
1261: 
1262:             WITH .Buttons(2)
1263:                 .Caption   = "N" + CHR(227) + "o"
1264:                 .Left      = 50
1265:                 .Top       = 5
1266:                 .AutoSize  = .T.
1267:                 .FontName  = "Tahoma"
1268:                 .FontSize  = 8
1269:                 .ForeColor = RGB(90, 90, 90)
1270:                 .Themes    = .F.
1271:             ENDWITH
1272: 
1273:             WITH .Buttons(3)
1274:                 .Caption   = "Produto"
1275:                 .Left      = 100
1276:                 .Top       = 5
1277:                 .AutoSize  = .T.
1278:                 .FontName  = "Tahoma"
1279:                 .FontSize  = 8
1280:                 .ForeColor = RGB(90, 90, 90)
1281:                 .Themes    = .F.

*-- Linhas 1491 a 1499:
1491:             loc_oPg2.txt_4c_Qmin.ReadOnly = .T.
1492: 
1493:             loc_oPg2.grd_4c_GradeI.ReadOnly                = !par_lHabilitar
1494:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1495:         CATCH TO loc_oErro
1496:             MsgErro(loc_oErro.Message, "FormEmn.HabilitarCampos")
1497:         ENDTRY
1498:     ENDPROC
1499: 

*-- Linhas 1564 a 1579:
1564:             loc_oGrid.Column8.ControlSource = "CrSigCdMin.qideal"
1565: 
1566:             *-- Resetar headers (RecordSource pode ter limpo as captions)
1567:             loc_oGrid.Column1.Header1.Caption = "Emp"
1568:             loc_oGrid.Column2.Header1.Caption = "Qtde. M" + CHR(237) + "nima"
1569:             loc_oGrid.Column3.Header1.Caption = "Tamanho"
1570:             loc_oGrid.Column4.Header1.Caption = "Cor"
1571:             loc_oGrid.Column5.Header1.Caption = "Grupo"
1572:             loc_oGrid.Column6.Header1.Caption = "Conta"
1573:             loc_oGrid.Column7.Header1.Caption = "Local"
1574:             loc_oGrid.Column8.Header1.Caption = "Estoque Alvo"
1575: 
1576:             *-- Habilitar/desabilitar colunas Tamanho e Cor conforme flags do produto
1577:             loc_oGrid.Column3.ReadOnly = !loc_oBO.this_lTemTam
1578:             loc_oGrid.Column4.ReadOnly = !loc_oBO.this_lTemCor
1579: 

*-- Linhas 2251 a 2259:
2251:             loc_oPg2.obj_4c_OptRetiras.Value = loc_nRetiras
2252: 
2253:             *-- Habilitar excluir linha apenas se empresa preenchida e modo edicao
2254:             loc_oPg2.cmd_4c_BtnExcluir.Enabled = ;
2255:                 (!EMPTY(ALLTRIM(CrSigCdMin.emps)) AND THIS.this_cModoAtual <> "VISUALIZAR")
2256:         CATCH TO loc_oErro
2257:             MsgErro(loc_oErro.Message, "FormEmn.GradeIAfterRowColChange")
2258:         ENDTRY
2259:     ENDPROC

*-- Linhas 2268 a 2284:
2268:             loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2269:             loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2270: 
2271:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
2272:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
2273:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .T.
2274:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .T.
2275:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
2276: 
2277:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
2278:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
2279:             loc_oPg2.cmd_4c_BtnExcluir.Visible             = loc_lEdicao
2280: 
2281:             THIS.HabilitarCampos(loc_lEdicao)
2282:         CATCH TO loc_oErro
2283:             MsgErro(loc_oErro.Message, "FormEmn.AjustarBotoesPorModo")
2284:         ENDTRY


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

