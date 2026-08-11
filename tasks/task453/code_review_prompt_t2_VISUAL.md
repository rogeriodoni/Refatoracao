# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (74)
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Tratamento' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_TratamentoTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Inicial' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Final' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Local Ini.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Local Fin.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gde.Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Encerrado' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Data, Barra, Barra Novo, Apurado, Estoque, Diferença, Ocorrencia, T, Dif. Peso. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Top original=115 vs migrado 'lbl_4c_Label1' Top=265 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Top original=92 vs migrado 'lbl_4c_Label5' Top=265 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Left original=231 vs migrado 'lbl_4c_Label5' Left=626 (diff=395px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Top original=43 vs migrado 'lbl_4c_Label3' Top=190 (diff=147px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Top original=18 vs migrado 'lbl_4c_Label4' Top=265 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Left original=270 vs migrado 'lbl_4c_Label4' Left=387 (diff=117px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Top original=68 vs migrado 'lbl_4c_Label2' Top=265 (diff=197px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Custo2): Left original=301 vs migrado 'lbl_4c_Label2' Left=527 (diff=226px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=43 vs migrado 'cmd_4c_BNCancela' Top=5 (diff=38px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=507 vs migrado 'cmd_4c_BNCancela' Left=570 (diff=63px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=7 vs migrado 'lbl_4c_Label3' Top=190 (diff=183px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=16 vs migrado 'lbl_4c_Label3' Left=252 (diff=236px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=149 vs migrado 'lbl_4c_Label8' Top=290 (diff=141px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=337 vs migrado 'lbl_4c_Label8' Left=521 (diff=184px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=17 vs migrado 'lbl_4c_Label2' Top=265 (diff=248px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=383 vs migrado 'lbl_4c_Label2' Left=527 (diff=144px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=123 vs migrado 'lbl_4c_Label7' Top=290 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=344 vs migrado 'lbl_4c_Label7' Left=387 (diff=43px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=46 vs migrado 'lbl_4c_Label5' Top=265 (diff=219px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=294 vs migrado 'lbl_4c_Label5' Left=626 (diff=332px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Top original=68 vs migrado 'lbl_4c_Label4' Top=265 (diff=197px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.CntTratOcor): Left original=317 vs migrado 'lbl_4c_Label4' Left=387 (diff=70px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=45 vs migrado 'cmd_4c_BNCancela' Top=5 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=48 vs migrado 'lbl_4c_Label5' Top=265 (diff=217px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Left original=294 vs migrado 'lbl_4c_Label5' Left=626 (diff=332px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=7 vs migrado 'lbl_4c_Label3' Top=190 (diff=183px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Left original=14 vs migrado 'lbl_4c_Label3' Left=252 (diff=238px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=18 vs migrado 'lbl_4c_Label2' Top=265 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Left original=359 vs migrado 'lbl_4c_Label2' Left=527 (diff=168px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=70 vs migrado 'lbl_4c_Label4' Top=265 (diff=195px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Left original=444 vs migrado 'lbl_4c_Label4' Left=387 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Top original=71 vs migrado 'lbl_4c_Label1' Top=265 (diff=194px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.CntBaixaAuto): Left original=310 vs migrado 'lbl_4c_Label1' Left=249 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Top original=97 vs migrado 'lbl_4c_Label1' Top=265 (diff=168px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Top original=74 vs migrado 'lbl_4c_Label5' Top=265 (diff=191px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Left original=263 vs migrado 'lbl_4c_Label5' Left=626 (diff=363px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Top original=50 vs migrado 'lbl_4c_Label3' Top=190 (diff=140px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Top original=25 vs migrado 'lbl_4c_Label4' Top=265 (diff=240px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Inserir): Left original=289 vs migrado 'lbl_4c_Label4' Left=387 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=831 vs migrado 'cmd_4c_BNCancela' Left=570 (diff=261px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Sair' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=906 vs migrado 'cmd_4c_BNSair' Left=645 (diff=261px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Procurar' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=12 vs migrado 'cnt_4c__Procurar' Top=239 (diff=227px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Procurar' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=163 vs migrado 'cnt_4c__Procurar' Left=17 (diff=146px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=126 vs migrado 'lbl_4c_Label4' Top=265 (diff=139px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=19 vs migrado 'lbl_4c_Label4' Left=387 (diff=368px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=176 vs migrado 'lbl_4c_Label2' Top=265 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=19 vs migrado 'lbl_4c_Label2' Left=527 (diff=508px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=151 vs migrado 'lbl_4c_Label3' Top=190 (diff=39px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=25 vs migrado 'lbl_4c_Label3' Left=252 (diff=227px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=174 vs migrado 'lbl_4c_Label8' Top=290 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=339 vs migrado 'lbl_4c_Label8' Left=521 (diff=182px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=149 vs migrado 'lbl_4c_Label6' Top=290 (diff=141px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=327 vs migrado 'lbl_4c_Label6' Left=230 (diff=97px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=149 vs migrado 'lbl_4c_Label5' Top=265 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=171 vs migrado 'lbl_4c_Label5' Left=626 (diff=455px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Top original=174 vs migrado 'lbl_4c_Label7' Top=290 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1): Left original=201 vs migrado 'lbl_4c_Label7' Left=387 (diff=186px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1.Cnt_Total): Top original=9 vs migrado 'lbl_4c_Label1' Top=265 (diff=256px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1.Cnt_Total): Left original=49 vs migrado 'lbl_4c_Label1' Left=249 (diff=200px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1.Cnt_Total): Top original=32 vs migrado 'lbl_4c_Label2' Top=265 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDINT.Pagina.Tratamento.Cnt_CCusto1.Cnt_Total): Left original=26 vs migrado 'lbl_4c_Label2' Left=527 (diff=501px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Procurar): Top original=22 vs migrado 'lbl_4c_Label4' Top=265 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDINT.Pagina.Tratamento.Cnt_Procurar): Left original=27 vs migrado 'lbl_4c_Label4' Left=387 (diff=360px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formint.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4280 linhas total):

*-- Linhas 71 a 84:
71:                     "Formint.InicializarForm")
72:             ELSE
73:                 *-- Caption com acento (CHR obrigatorio - CLAUDE.md regra 4)
74:                 THIS.Caption = "Tratamento de Invent" + CHR(225) + "rio"
75: 
76:                 THIS.ConfigurarPageFrame()
77: 
78:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
79:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80:                 THIS.pgf_4c_Paginas.Visible = .T.
81:                 THIS.pgf_4c_Paginas.ActivePage = 1
82:                 THIS.this_cModoAtual = "LISTA"
83: 
84:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 108 a 145:
108: 
109:         WITH THIS.pgf_4c_Paginas
110:             .PageCount = 3
111:             .Top       = -29
112:             .Left      = 0
113:             .Width     = 1003
114:             .Height    = THIS.Height + 29
115:             .Tabs      = .F.
116:             .Visible   = .T.
117: 
118:             .Page1.Caption   = "Lista"
119:             .Page1.BackColor = RGB(255, 255, 255)
120:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
121: 
122:             .Page2.Caption   = "Dados"
123:             .Page2.BackColor = RGB(255, 255, 255)
124:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
125: 
126:             .Page3.Caption   = "Tratamento"
127:             .Page3.BackColor = RGB(255, 255, 255)
128:             .Page3.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
129:         ENDWITH
130: 
131:         THIS.ConfigurarPaginaLista()
132:         THIS.ConfigurarPaginaDados()
133:         THIS.ConfigurarPaginaTratamento()
134:     ENDPROC
135: 
136:     *===========================================================================
137:     * ConfigurarPaginaLista - Configura Page1 (Lista de inventarios)
138:     * Original: cntSombra.Top=1 -> +29 = 30
139:     *           Grupo_op.Left=543, Top=-1 -> +29 = 28
140:     *           Grupo_Saida.Left=918 -> canonico Left=917
141:     *===========================================================================
142:     PROTECTED PROCEDURE ConfigurarPaginaLista()
143:         LOCAL loc_oPagina
144:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
145: 

*-- Linhas 153 a 190:
153:         *----------------------------------------------------------------------
154:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
155:         WITH loc_oPagina.cnt_4c_Cabecalho
156:             .Top         = 30
157:             .Left        = 0
158:             .Width       = THIS.Width
159:             .Height      = 80
160:             .BackColor   = RGB(100, 100, 100)
161:             .BorderWidth = 0
162:             .Visible     = .T.
163:         ENDWITH
164: 
165:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
166:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
167:             .Caption   = THIS.Caption
168:             .Top       = 15
169:             .Left      = 10
170:             .Width     = 769
171:             .Height    = 40
172:             .FontName  = "Tahoma"
173:             .FontSize  = 16
174:             .FontBold  = .T.
175:             .ForeColor = RGB(0, 0, 0)
176:             .BackStyle = 0
177:             .AutoSize  = .F.
178:             .Visible   = .T.
179:         ENDWITH
180: 
181:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
182:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
183:             .Caption   = THIS.Caption
184:             .Top       = 18
185:             .Left      = 10
186:             .Width     = 769
187:             .Height    = 46
188:             .FontName  = "Tahoma"
189:             .FontSize  = 16
190:             .FontBold  = .T.

*-- Linhas 201 a 225:
201:         *----------------------------------------------------------------------
202:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
203:         WITH loc_oPagina.cnt_4c_Botoes
204:             .Top         = 28
205:             .Left        =  542
206:             .Width       = 385
207:             .Height      = 85
208:             .BackStyle = 0
209:             .BorderWidth = 0
210:             .Visible     = .T.
211:         ENDWITH
212: 
213:         *-- Botao Balanco (Balan?o - relatorio de inventario)
214:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Balanco", "CommandButton")
215:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Balanco
216:             .Caption         = "Balan" + CHR(231) + "o"
217:             .Picture         = gc_4c_CaminhoIcones + "geral_balanca_60.jpg"
218:             .PicturePosition = 13
219:             .Top             = 5
220:             .Left            = 5
221:             .Width           = 75
222:             .Height          = 75
223:             .FontName        = "Tahoma"
224:             .FontBold        = .T.
225:             .FontItalic      = .T.

*-- Linhas 233 a 250:
233:             .AutoSize        = .F.
234:             .Visible         = .T.
235:         ENDWITH
236:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Balanco, "Click", THIS, "BtnBalancoClick")
237: 
238:         *-- Botao BaixaAuto (Baixa Automatica por ocorrencia)
239:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_BaixaAuto", "CommandButton")
240:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_BaixaAuto
241:             .Caption         = "Bx.Aut."
242:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
243:             .PicturePosition = 13
244:             .Top             = 5
245:             .Left            = 80
246:             .Width           = 75
247:             .Height          = 75
248:             .FontName        = "Tahoma"
249:             .FontBold        = .T.
250:             .FontItalic      = .T.

*-- Linhas 258 a 275:
258:             .AutoSize        = .F.
259:             .Visible         = .T.
260:         ENDWITH
261:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_BaixaAuto, "Click", THIS, "BtnBaixaAutoClick")
262: 
263:         *-- Botao Tratamento (Iniciar tratamento de inventario)
264:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Tratamento", "CommandButton")
265:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Tratamento
266:             .Caption         = "Tratar"
267:             .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 155
271:             .Width           = 75
272:             .Height          = 75
273:             .FontName        = "Tahoma"
274:             .FontBold        = .T.
275:             .FontItalic      = .T.

*-- Linhas 283 a 300:
283:             .AutoSize        = .F.
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Tratamento, "Click", THIS, "BtnTratamentoClick")
287: 
288:         *-- Botao Fechar (Fechar/Encerrar o inventario - operacao de encerramento)
289:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Fechar", "CommandButton")
290:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Fechar
291:             .Caption         = "Encerrar"
292:             .Picture         = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
293:             .PicturePosition = 13
294:             .Top             = 5
295:             .Left            = 230
296:             .Width           = 75
297:             .Height          = 75
298:             .FontName        = "Tahoma"
299:             .FontBold        = .T.
300:             .FontItalic      = .T.

*-- Linhas 308 a 325:
308:             .AutoSize        = .F.
309:             .Visible         = .T.
310:         ENDWITH
311:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Fechar, "Click", THIS, "BtnFecharClick")
312: 
313:         *-- Botao Procurar (Navega para Page2 para entrada de filtros)
314:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Procurar", "CommandButton")
315:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar
316:             .Caption         = "Procurar"
317:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
318:             .PicturePosition = 13
319:             .Top             = 5
320:             .Left            = 305
321:             .Width           = 75
322:             .Height          = 75
323:             .FontName        = "Tahoma"
324:             .FontBold        = .T.
325:             .FontItalic      = .T.

*-- Linhas 333 a 366:
333:             .AutoSize        = .F.
334:             .Visible         = .T.
335:         ENDWITH
336:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")
337: 
338:         *----------------------------------------------------------------------
339:         * Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
340:         * Left=917, Width=90, Height=85 - prevalece sobre original (Left=918)
341:         * Top=29 canonico; BackStyle=0 (transparente)
342:         *----------------------------------------------------------------------
343:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
344:         WITH loc_oPagina.cnt_4c_Saida
345:             .Top         = 29
346:             .Left        = 917
347:             .Width       = 90
348:             .Height      = 85
349:             .BackStyle   = 0
350:             .BorderWidth = 0
351:             .Visible     = .T.
352:         ENDWITH
353: 
354:         *-- Botao Encerrar (canonico CLAUDE.md)
355:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
356:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
357:             .Caption         = "Encerrar"
358:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
359:             .PicturePosition = 13
360:             .Top             = 5
361:             .Left            = 5
362:             .Width           = 75
363:             .Height          = 75
364:             .FontName        = "Tahoma"
365:             .FontBold        = .T.
366:             .FontItalic      = .T.

*-- Linhas 374 a 520:
374:             .AutoSize        = .F.
375:             .Visible         = .T.
376:         ENDWITH
377:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
378: 
379:         *----------------------------------------------------------------------
380:         * Botoes de cabecalho de coluna (sort/foco no grid)
381:         * Top=124+29=153; Height=20 (visual de header de coluna)
382:         * Posicoes e larguras do layout.json
383:         *----------------------------------------------------------------------
384:         loc_oPagina.AddObject("cmd_4c_Processo", "CommandButton")
385:         WITH loc_oPagina.cmd_4c_Processo
386:             .Caption       = "Processo"
387:             .Top           = 153
388:             .Left          = 12
389:             .Width         = 62
390:             .Height        = 20
391:             .FontName      = "Tahoma"
392:             .FontSize      = 8
393:             .FontBold      = .T.
394:             .ForeColor     = RGB(0, 0, 0)
395:             .BackColor     = RGB(192, 192, 192)
396:             .SpecialEffect = 1
397:             .Themes        = .F.
398:             .MousePointer  = 15
399:             .Visible       = .T.
400:         ENDWITH
401:         BINDEVENT(loc_oPagina.cmd_4c_Processo, "Click", THIS, "CmdProcessoClick")
402: 
403:         loc_oPagina.AddObject("cmd_4c_Periodo", "CommandButton")
404:         WITH loc_oPagina.cmd_4c_Periodo
405:             .Caption       = "Per" + CHR(237) + "odo"
406:             .Top           = 153
407:             .Left          = 73
408:             .Width         = 153
409:             .Height        = 20
410:             .FontName      = "Tahoma"
411:             .FontSize      = 8
412:             .FontBold      = .T.
413:             .ForeColor     = RGB(0, 0, 0)
414:             .BackColor     = RGB(192, 192, 192)
415:             .SpecialEffect = 1
416:             .Themes        = .F.
417:             .MousePointer  = 15
418:             .Visible       = .T.
419:         ENDWITH
420:         BINDEVENT(loc_oPagina.cmd_4c_Periodo, "Click", THIS, "CmdPeriodoClick")
421: 
422:         loc_oPagina.AddObject("cmd_4c_Estoque", "CommandButton")
423:         WITH loc_oPagina.cmd_4c_Estoque
424:             .Caption       = "Estoque"
425:             .Top           = 153
426:             .Left          = 225
427:             .Width         = 143
428:             .Height        = 20
429:             .FontName      = "Tahoma"
430:             .FontSize      = 8
431:             .FontBold      = .T.
432:             .ForeColor     = RGB(0, 0, 0)
433:             .BackColor     = RGB(192, 192, 192)
434:             .SpecialEffect = 1
435:             .Themes        = .F.
436:             .MousePointer  = 15
437:             .Visible       = .T.
438:         ENDWITH
439:         BINDEVENT(loc_oPagina.cmd_4c_Estoque, "Click", THIS, "CmdEstoqueClick")
440: 
441:         loc_oPagina.AddObject("cmd_4c_Local", "CommandButton")
442:         WITH loc_oPagina.cmd_4c_Local
443:             .Caption       = "Local"
444:             .Top           = 153
445:             .Left          = 367
446:             .Width         = 163
447:             .Height        = 20
448:             .FontName      = "Tahoma"
449:             .FontSize      = 8
450:             .FontBold      = .T.
451:             .ForeColor     = RGB(0, 0, 0)
452:             .BackColor     = RGB(192, 192, 192)
453:             .SpecialEffect = 1
454:             .Themes        = .F.
455:             .MousePointer  = 15
456:             .Visible       = .T.
457:         ENDWITH
458:         BINDEVENT(loc_oPagina.cmd_4c_Local, "Click", THIS, "CmdLocalClick")
459: 
460:         loc_oPagina.AddObject("cmd_4c_Grupo", "CommandButton")
461:         WITH loc_oPagina.cmd_4c_Grupo
462:             .Caption       = "Grupo"
463:             .Top           = 153
464:             .Left          = 529
465:             .Width         = 69
466:             .Height        = 20
467:             .FontName      = "Tahoma"
468:             .FontSize      = 8
469:             .FontBold      = .T.
470:             .ForeColor     = RGB(0, 0, 0)
471:             .BackColor     = RGB(192, 192, 192)
472:             .SpecialEffect = 1
473:             .Themes        = .F.
474:             .MousePointer  = 15
475:             .Visible       = .T.
476:         ENDWITH
477:         BINDEVENT(loc_oPagina.cmd_4c_Grupo, "Click", THIS, "CmdGrupoClick")
478: 
479:         loc_oPagina.AddObject("cmd_4c_GGrupo", "CommandButton")
480:         WITH loc_oPagina.cmd_4c_GGrupo
481:             .Caption       = "GGrupo"
482:             .Top           = 153
483:             .Left          = 597
484:             .Width         = 69
485:             .Height        = 20
486:             .FontName      = "Tahoma"
487:             .FontSize      = 8
488:             .FontBold      = .T.
489:             .ForeColor     = RGB(0, 0, 0)
490:             .BackColor     = RGB(192, 192, 192)
491:             .SpecialEffect = 1
492:             .Themes        = .F.
493:             .MousePointer  = 15
494:             .Visible       = .T.
495:         ENDWITH
496:         BINDEVENT(loc_oPagina.cmd_4c_GGrupo, "Click", THIS, "CmdGGrupoClick")
497: 
498:         loc_oPagina.AddObject("cmd_4c_Usuario", "CommandButton")
499:         WITH loc_oPagina.cmd_4c_Usuario
500:             .Caption       = "Usu" + CHR(225) + "rio"
501:             .Top           = 153
502:             .Left          = 665
503:             .Width         = 78
504:             .Height        = 20
505:             .FontName      = "Tahoma"
506:             .FontSize      = 8
507:             .FontBold      = .T.
508:             .ForeColor     = RGB(0, 0, 0)
509:             .BackColor     = RGB(192, 192, 192)
510:             .SpecialEffect = 1
511:             .Themes        = .F.
512:             .MousePointer  = 15
513:             .Visible       = .T.
514:         ENDWITH
515:         BINDEVENT(loc_oPagina.cmd_4c_Usuario, "Click", THIS, "CmdUsuarioClick")
516: 
517:         *----------------------------------------------------------------------
518:         * Grid principal de inventarios
519:         * Original: Top=145, Left=12, Width=934, Height=446
520:         * Compensacao +29: Top=174

*-- Linhas 528 a 537:
528:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
529:         loc_oPagina.grd_4c_Dados.ColumnCount = 10
530:         WITH loc_oPagina.grd_4c_Dados
531:             .Top           = 174
532:             .Left          = 12
533:             .Width         = 905
534:             .Height        = 446
535:             .RecordSource  = ""
536:             .ReadOnly      = .T.
537:             .DeleteMark    = .F.

*-- Linhas 603 a 611:
603: 
604:     *===========================================================================
605:     * ConfigurarPaginaDados - Configura Page2 (Filtros para selecao do inventario)
606:     * Original: Grupo_Salva.Left=821, Top=10, Width=160, Height=85
607:     * Com compensacao +29: Top=39
608:     *===========================================================================
609:     PROTECTED PROCEDURE ConfigurarPaginaDados()
610:         LOCAL loc_oPagina
611:         loc_oPagina = THIS.pgf_4c_Paginas.Page2

*-- Linhas 619 a 643:
619:         *----------------------------------------------------------------------
620:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
621:         WITH loc_oPagina.cnt_4c_BotoesAcao
622:             .Top         = 39
623:             .Left        = 821
624:             .Width       = 160
625:             .Height      = 85
626:             .BackStyle   = 0
627:             .BorderWidth = 0
628:             .Visible     = .T.
629:         ENDWITH
630: 
631:         *-- Botao Confirmar (Salva no legado: Left=5, Top=5)
632:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
633:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
634:             .Caption         = "Confirmar"
635:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
636:             .PicturePosition = 13
637:             .Top             = 5
638:             .Left            = 5
639:             .Width           = 75
640:             .Height          = 75
641:             .FontName        = "Tahoma"
642:             .FontBold        = .T.
643:             .FontItalic      = .T.

*-- Linhas 651 a 668:
651:             .AutoSize        = .F.
652:             .Visible         = .T.
653:         ENDWITH
654:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
655: 
656:         *-- Botao Cancelar (Left=80, Top=5)
657:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
658:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
659:             .Caption         = "Encerrar"
660:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
661:             .PicturePosition = 13
662:             .Top             = 5
663:             .Left            = 80
664:             .Width           = 75
665:             .Height          = 75
666:             .FontName        = "Tahoma"
667:             .FontBold        = .T.
668:             .FontItalic      = .T.

*-- Linhas 676 a 717:
676:             .AutoSize        = .F.
677:             .Visible         = .T.
678:         ENDWITH
679:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
680: 
681:         *----------------------------------------------------------------------
682:         * FASE 5/8 - CAMPOS PRINCIPAIS PARTE 1
683:         * Primeira metade dos campos da Page2 (filtros/dados do inventario)
684:         * Compensacao +29 aplicada em todos os Top (PageFrame.Top = -29)
685:         *
686:         * Campos leitura-only: BackColor cinza (230,230,230) + ReadOnly=.T.
687:         * Apenas txt_4c_Codigo eh editavel (para busca por codigo)
688:         *----------------------------------------------------------------------
689: 
690:         *-- txt_4c_Codigo (Get_Codigo: Top=157, Left=303, Width=44 -> +29=186)
691:         *-- Editavel SOMENTE ao procurar (unico campo de entrada na Page2)
692:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
693:         WITH loc_oPagina.txt_4c_Codigo
694:             .Value       = ""
695:             .Top         = 186
696:             .Left        = 303
697:             .Width       = 44
698:             .Height      = 23
699:             .FontName    = "Tahoma"
700:             .FontSize    = 8
701:             .BackColor   = RGB(255, 255, 255)
702:             .ForeColor   = RGB(0, 0, 0)
703:             .BorderStyle = 1
704:             .Visible     = .T.
705:         ENDWITH
706: 
707:         *-- lbl_4c_Label3 (Say3 "Codigo": Top=161, Left=252, Width=42 -> +29=190)
708:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
709:         WITH loc_oPagina.lbl_4c_Label3
710:             .Caption   = "C" + CHR(243) + "digo :"
711:             .Top       = 190
712:             .Left      = 252
713:             .Width     = 42
714:             .Height    = 17
715:             .FontName  = "Tahoma"
716:             .FontSize  = 8
717:             .BackStyle = 0

*-- Linhas 725 a 750:
725:         WITH loc_oPagina.txt_4c_Grupo
726:             .Value       = ""
727:             .ReadOnly    = .T.
728:             .Top         = 211
729:             .Left        = 303
730:             .Width       = 81
731:             .Height      = 23
732:             .FontName    = "Tahoma"
733:             .FontSize    = 8
734:             .BackColor   = RGB(230, 230, 230)
735:             .ForeColor   = RGB(0, 0, 0)
736:             .BorderStyle = 1
737:             .Visible     = .T.
738:         ENDWITH
739: 
740:         *-- lbl_4c_Lbl_Grupos (lbl_grupos "Grupo": Top=186, Left=256, Width=38 -> +29=215)
741:         loc_oPagina.AddObject("lbl_4c_Lbl_Grupos", "Label")
742:         WITH loc_oPagina.lbl_4c_Lbl_Grupos
743:             .Caption   = "Grupo :"
744:             .Top       = 215
745:             .Left      = 256
746:             .Width     = 38
747:             .Height    = 17
748:             .FontName  = "Tahoma"
749:             .FontSize  = 8
750:             .BackStyle = 0

*-- Linhas 758 a 767:
758:         WITH loc_oPagina.txt_4c_DGrupo
759:             .Value       = ""
760:             .ReadOnly    = .T.
761:             .Top         = 211
762:             .Left        = 386
763:             .Width       = 316
764:             .Height      = 23
765:             .FontName    = "Tahoma"
766:             .FontSize    = 8
767:             .BackColor   = RGB(230, 230, 230)

*-- Linhas 776 a 801:
776:         WITH loc_oPagina.txt_4c_Conta
777:             .Value       = ""
778:             .ReadOnly    = .T.
779:             .Top         = 236
780:             .Left        = 303
781:             .Width       = 81
782:             .Height      = 23
783:             .FontName    = "Tahoma"
784:             .FontSize    = 8
785:             .BackColor   = RGB(230, 230, 230)
786:             .ForeColor   = RGB(0, 0, 0)
787:             .BorderStyle = 1
788:             .Visible     = .T.
789:         ENDWITH
790: 
791:         *-- lbl_4c_Label12 (Say12 "Estoque": Top=211, Left=246, Width=48 -> +29=240)
792:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
793:         WITH loc_oPagina.lbl_4c_Label12
794:             .Caption   = "Estoque :"
795:             .Top       = 240
796:             .Left      = 246
797:             .Width     = 48
798:             .Height    = 17
799:             .FontName  = "Tahoma"
800:             .FontSize  = 8
801:             .BackStyle = 0

*-- Linhas 809 a 818:
809:         WITH loc_oPagina.txt_4c_DConta
810:             .Value       = ""
811:             .ReadOnly    = .T.
812:             .Top         = 236
813:             .Left        = 386
814:             .Width       = 316
815:             .Height      = 23
816:             .FontName    = "Tahoma"
817:             .FontSize    = 8
818:             .BackColor   = RGB(230, 230, 230)

*-- Linhas 827 a 836:
827:         WITH loc_oPagina.txt_4c_DataInicial
828:             .Value       = ""
829:             .ReadOnly    = .T.
830:             .Top         = 261
831:             .Left        = 303
832:             .Width       = 81
833:             .Height      = 23
834:             .FontName    = "Tahoma"
835:             .FontSize    = 8
836:             .BackColor   = RGB(230, 230, 230)

*-- Linhas 845 a 885:
845:         WITH loc_oPagina.txt_4c_DataFinal
846:             .Value       = ""
847:             .ReadOnly    = .T.
848:             .Top         = 261
849:             .Left        = 406
850:             .Width       = 81
851:             .Height      = 23
852:             .FontName    = "Tahoma"
853:             .FontSize    = 8
854:             .BackColor   = RGB(230, 230, 230)
855:             .ForeColor   = RGB(0, 0, 0)
856:             .BorderStyle = 1
857:             .Visible     = .T.
858:         ENDWITH
859: 
860:         *-- lbl_4c_Label1 (Say1 "Periodo": Top=236, Left=249, Width=45 -> +29=265)
861:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
862:         WITH loc_oPagina.lbl_4c_Label1
863:             .Caption   = "Per" + CHR(237) + "odo :"
864:             .Top       = 265
865:             .Left      = 249
866:             .Width     = 45
867:             .Height    = 17
868:             .FontName  = "Tahoma"
869:             .FontSize  = 8
870:             .BackStyle = 0
871:             .ForeColor = RGB(90, 90, 90)
872:             .Visible   = .T.
873:         ENDWITH
874: 
875:         *-- lbl_4c_Label4 (Say4 separador periodo: Top=236, Left=387, Width=14 -> +29=265)
876:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
877:         WITH loc_oPagina.lbl_4c_Label4
878:             .Caption   = " - "
879:             .Top       = 265
880:             .Left      = 387
881:             .Width     = 14
882:             .Height    = 17
883:             .FontName  = "Tahoma"
884:             .FontSize  = 8
885:             .BackStyle = 0

*-- Linhas 893 a 902:
893:         WITH loc_oPagina.txt_4c_LocalInicial
894:             .Value       = ""
895:             .ReadOnly    = .T.
896:             .Top         = 261
897:             .Left        = 569
898:             .Width       = 56
899:             .Height      = 23
900:             .FontName    = "Tahoma"
901:             .FontSize    = 8
902:             .BackColor   = RGB(230, 230, 230)

*-- Linhas 911 a 951:
911:         WITH loc_oPagina.txt_4c_LocalFinal
912:             .Value       = ""
913:             .ReadOnly    = .T.
914:             .Top         = 261
915:             .Left        = 646
916:             .Width       = 56
917:             .Height      = 23
918:             .FontName    = "Tahoma"
919:             .FontSize    = 8
920:             .BackColor   = RGB(230, 230, 230)
921:             .ForeColor   = RGB(0, 0, 0)
922:             .BorderStyle = 1
923:             .Visible     = .T.
924:         ENDWITH
925: 
926:         *-- lbl_4c_Label2 (Say2 "Local": Top=236, Left=527, Width=33 -> +29=265)
927:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
928:         WITH loc_oPagina.lbl_4c_Label2
929:             .Caption   = "Local :"
930:             .Top       = 265
931:             .Left      = 527
932:             .Width     = 33
933:             .Height    = 17
934:             .FontName  = "Tahoma"
935:             .FontSize  = 8
936:             .BackStyle = 0
937:             .ForeColor = RGB(90, 90, 90)
938:             .Visible   = .T.
939:         ENDWITH
940: 
941:         *-- lbl_4c_Label5 (Say5 separador local: Top=236, Left=626, Width=14 -> +29=265)
942:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
943:         WITH loc_oPagina.lbl_4c_Label5
944:             .Caption   = " - "
945:             .Top       = 265
946:             .Left      = 626
947:             .Width     = 14
948:             .Height    = 17
949:             .FontName  = "Tahoma"
950:             .FontSize  = 8
951:             .BackStyle = 0

*-- Linhas 965 a 974:
965:         WITH loc_oPagina.txt_4c_FornecInicial
966:             .Value       = ""
967:             .ReadOnly    = .T.
968:             .Top         = 286
969:             .Left        = 303
970:             .Width       = 81
971:             .Height      = 23
972:             .FontName    = "Tahoma"
973:             .FontSize    = 8
974:             .BackColor   = RGB(230, 230, 230)

*-- Linhas 982 a 1022:
982:         WITH loc_oPagina.txt_4c_FornecFinal
983:             .Value       = ""
984:             .ReadOnly    = .T.
985:             .Top         = 286
986:             .Left        = 406
987:             .Width       = 81
988:             .Height      = 23
989:             .FontName    = "Tahoma"
990:             .FontSize    = 8
991:             .BackColor   = RGB(230, 230, 230)
992:             .ForeColor   = RGB(0, 0, 0)
993:             .BorderStyle = 1
994:             .Visible     = .T.
995:         ENDWITH
996: 
997:         *-- lbl_4c_Label6 (Say6 "Fornecedor": Top=261, Left=230, Width=64, Height=15 -> +29=290)
998:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
999:         WITH loc_oPagina.lbl_4c_Label6
1000:             .Caption   = "Fornecedor :"
1001:             .Top       = 290
1002:             .Left      = 230
1003:             .Width     = 64
1004:             .Height    = 15
1005:             .FontName  = "Tahoma"
1006:             .FontSize  = 8
1007:             .BackStyle = 0
1008:             .ForeColor = RGB(90, 90, 90)
1009:             .Visible   = .T.
1010:         ENDWITH
1011: 
1012:         *-- lbl_4c_Label7 (Say7 separador fornecedor: Top=261, Left=387, Width=14 -> +29=290)
1013:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
1014:         WITH loc_oPagina.lbl_4c_Label7
1015:             .Caption   = " - "
1016:             .Top       = 290
1017:             .Left      = 387
1018:             .Width     = 14
1019:             .Height    = 17
1020:             .FontName  = "Tahoma"
1021:             .FontSize  = 8
1022:             .BackStyle = 0

*-- Linhas 1029 a 1038:
1029:         WITH loc_oPagina.txt_4c_GrupoInicial
1030:             .Value       = ""
1031:             .ReadOnly    = .T.
1032:             .Top         = 153
1033:             .Left        = 529
1034:             .Width       = 34
1035:             .Height      = 23
1036:             .FontName    = "Tahoma"
1037:             .FontSize    = 8
1038:             .BackColor   = RGB(230, 230, 230)

*-- Linhas 1046 a 1086:
1046:         WITH loc_oPagina.txt_4c_GrupoFinal
1047:             .Value       = ""
1048:             .ReadOnly    = .T.
1049:             .Top         = 286
1050:             .Left        = 646
1051:             .Width       = 34
1052:             .Height      = 23
1053:             .FontName    = "Tahoma"
1054:             .FontSize    = 8
1055:             .BackColor   = RGB(230, 230, 230)
1056:             .ForeColor   = RGB(0, 0, 0)
1057:             .BorderStyle = 1
1058:             .Visible     = .T.
1059:         ENDWITH
1060: 
1061:         *-- lbl_4c_Label8 (Say8 "Grupo": Top=261, Left=521, Width=38 -> +29=290)
1062:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
1063:         WITH loc_oPagina.lbl_4c_Label8
1064:             .Caption   = "Grupo :"
1065:             .Top       = 290
1066:             .Left      = 521
1067:             .Width     = 38
1068:             .Height    = 17
1069:             .FontName  = "Tahoma"
1070:             .FontSize  = 8
1071:             .BackStyle = 0
1072:             .ForeColor = RGB(90, 90, 90)
1073:             .Visible   = .T.
1074:         ENDWITH
1075: 
1076:         *-- lbl_4c_Label9 (Say9 separador grupo: Top=261, Left=626, Width=14 -> +29=290)
1077:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
1078:         WITH loc_oPagina.lbl_4c_Label9
1079:             .Caption   = " - "
1080:             .Top       = 290
1081:             .Left      = 626
1082:             .Width     = 14
1083:             .Height    = 17
1084:             .FontName  = "Tahoma"
1085:             .FontSize  = 8
1086:             .BackStyle = 0

*-- Linhas 1093 a 1102:
1093:         WITH loc_oPagina.txt_4c_PrecoInicial
1094:             .Value       = ""
1095:             .ReadOnly    = .T.
1096:             .Top         = 311
1097:             .Left        = 303
1098:             .Width       = 81
1099:             .Height      = 23
1100:             .FontName    = "Tahoma"
1101:             .FontSize    = 8
1102:             .BackColor   = RGB(230, 230, 230)

*-- Linhas 1110 a 1150:
1110:         WITH loc_oPagina.txt_4c_PrecoFinal
1111:             .Value       = ""
1112:             .ReadOnly    = .T.
1113:             .Top         = 311
1114:             .Left        = 406
1115:             .Width       = 81
1116:             .Height      = 23
1117:             .FontName    = "Tahoma"
1118:             .FontSize    = 8
1119:             .BackColor   = RGB(230, 230, 230)
1120:             .ForeColor   = RGB(0, 0, 0)
1121:             .BorderStyle = 1
1122:             .Visible     = .T.
1123:         ENDWITH
1124: 
1125:         *-- lbl_4c_Label10 (Say10 "Valor": Top=286, Left=261, Width=33 -> +29=315)
1126:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
1127:         WITH loc_oPagina.lbl_4c_Label10
1128:             .Caption   = "Valor :"
1129:             .Top       = 315
1130:             .Left      = 261
1131:             .Width     = 33
1132:             .Height    = 15
1133:             .FontName  = "Tahoma"
1134:             .FontSize  = 8
1135:             .BackStyle = 0
1136:             .ForeColor = RGB(90, 90, 90)
1137:             .Visible   = .T.
1138:         ENDWITH
1139: 
1140:         *-- lbl_4c_Label11 (Say11 separador preco: Top=286, Left=387, Width=14 -> +29=315)
1141:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
1142:         WITH loc_oPagina.lbl_4c_Label11
1143:             .Caption   = " - "
1144:             .Top       = 315
1145:             .Left      = 387
1146:             .Width     = 14
1147:             .Height    = 17
1148:             .FontName  = "Tahoma"
1149:             .FontSize  = 8
1150:             .BackStyle = 0

*-- Linhas 1157 a 1166:
1157:         WITH loc_oPagina.txt_4c_GGrupoInicial
1158:             .Value       = ""
1159:             .ReadOnly    = .T.
1160:             .Top         = 311
1161:             .Left        = 569
1162:             .Width       = 34
1163:             .Height      = 23
1164:             .FontName    = "Tahoma"
1165:             .FontSize    = 8
1166:             .BackColor   = RGB(230, 230, 230)

*-- Linhas 1174 a 1214:
1174:         WITH loc_oPagina.txt_4c_GGrupoFinal
1175:             .Value       = ""
1176:             .ReadOnly    = .T.
1177:             .Top         = 311
1178:             .Left        = 646
1179:             .Width       = 34
1180:             .Height      = 23
1181:             .FontName    = "Tahoma"
1182:             .FontSize    = 8
1183:             .BackColor   = RGB(230, 230, 230)
1184:             .ForeColor   = RGB(0, 0, 0)
1185:             .BorderStyle = 1
1186:             .Visible     = .T.
1187:         ENDWITH
1188: 
1189:         *-- lbl_4c_Label13 (Say13 "Gde.Grupo": Top=286, Left=494, Width=61 -> +29=315)
1190:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
1191:         WITH loc_oPagina.lbl_4c_Label13
1192:             .Caption   = "Gde.Grupo :"
1193:             .Top       = 315
1194:             .Left      = 494
1195:             .Width     = 61
1196:             .Height    = 17
1197:             .FontName  = "Tahoma"
1198:             .FontSize  = 8
1199:             .BackStyle = 0
1200:             .ForeColor = RGB(90, 90, 90)
1201:             .Visible   = .T.
1202:         ENDWITH
1203: 
1204:         *-- lbl_4c_Label14 (Say14 separador ggrup: Top=286, Left=626, Width=14 -> +29=315)
1205:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
1206:         WITH loc_oPagina.lbl_4c_Label14
1207:             .Caption   = " - "
1208:             .Top       = 315
1209:             .Left      = 626
1210:             .Width     = 14
1211:             .Height    = 17
1212:             .FontName  = "Tahoma"
1213:             .FontSize  = 8
1214:             .BackStyle = 0

*-- Linhas 1236 a 1493:
1236:         *==========================================================================
1237:         loc_oPagina.AddObject("cnt_4c__CCusto1", "Container")
1238:         WITH loc_oPagina.cnt_4c__CCusto1
1239:             .Top        = 29
1240:             .Left       = 0
1241:             .Width      = 1000
1242:             .Height     = 197
1243:             .Visible    = .F.
1244:             .BackColor  = RGB(240, 240, 240)
1245:             .BorderWidth = 1
1246:         ENDWITH
1247: 
1248:         loc_oCnt = loc_oPagina.cnt_4c__CCusto1
1249: 
1250:         *-- Botoes do painel superior
1251:         loc_oCnt.AddObject("cmd_4c_Sobra", "CommandButton")
1252:         WITH loc_oCnt.cmd_4c_Sobra
1253:             .Top = 5
1254:             .Left = 12
1255:             .Width = 75
1256:             .Height = 75
1257:             .Caption = "\<Sobra"
1258:             .FontName = "Tahoma"
1259:             .FontSize = 9
1260:             .Visible = .T.
1261:         ENDWITH
1262: 
1263:         loc_oCnt.AddObject("chk_4c_RepeteObs", "CheckBox")
1264:         WITH loc_oCnt.chk_4c_RepeteObs
1265:             .Top = 12
1266:             .Left = 88
1267:             .Width = 75
1268:             .Height = 75
1269:             .Caption = "\<Repete Obs"
1270:             .Value = 0
1271:             .FontName = "Tahoma"
1272:             .FontSize = 8
1273:             .Visible = .T.
1274:         ENDWITH
1275: 
1276:         loc_oCnt.AddObject("cmd_4c_Procurar", "CommandButton")
1277:         WITH loc_oCnt.cmd_4c_Procurar
1278:             .Top = 5
1279:             .Left = 163
1280:             .Width = 75
1281:             .Height = 75
1282:             .Caption = "Procurar"
1283:             .FontName = "Tahoma"
1284:             .FontSize = 9
1285:             .Visible = .T.
1286:         ENDWITH
1287: 
1288:         loc_oCnt.AddObject("cmd_4c_BarraNovo", "CommandButton")
1289:         WITH loc_oCnt.cmd_4c_BarraNovo
1290:             .Top = 5
1291:             .Left = 238
1292:             .Width = 75
1293:             .Height = 75
1294:             .Caption = "Novo \<Barra"
1295:             .FontName = "Tahoma"
1296:             .FontSize = 9
1297:             .Visible = .F.
1298:         ENDWITH
1299: 
1300:         loc_oCnt.AddObject("cmd_4c_CancelaCnt", "CommandButton")
1301:         WITH loc_oCnt.cmd_4c_CancelaCnt
1302:             .Top = 5
1303:             .Left = 831
1304:             .Width = 75
1305:             .Height = 75
1306:             .Caption = "\<Cancela"
1307:             .FontName = "Tahoma"
1308:             .FontSize = 9
1309:             .Visible = .F.
1310:         ENDWITH
1311: 
1312:         loc_oCnt.AddObject("cmd_4c_SairCnt", "CommandButton")
1313:         WITH loc_oCnt.cmd_4c_SairCnt
1314:             .Top = 5
1315:             .Left = 906
1316:             .Width = 75
1317:             .Height = 75
1318:             .Caption = "OK"
1319:             .FontName = "Tahoma"
1320:             .FontSize = 9
1321:             .Visible = .T.
1322:         ENDWITH
1323: 
1324:         *-- Indicador de tipo
1325:         loc_oCnt.AddObject("lbl_4c_Tp", "Label")
1326:         WITH loc_oCnt.lbl_4c_Tp
1327:             .Caption   = "[L]idos, [N]" + CHR(227) + "o lidos, [S]aldos"
1328:             .Top = 32
1329:             .Left = 340
1330:             .Width = 220
1331:             .Height = 17
1332:             .FontName = "Tahoma"
1333:             .FontSize = 8
1334:             .BackStyle = 0
1335:             .ForeColor = RGB(0, 0, 128)
1336:             .Visible = .T.
1337:         ENDWITH
1338: 
1339:         *-- Sub-container cnt_4c__Total (contadores de ocorrencias)
1340:         loc_oCnt.AddObject("cnt_4c__Total", "Container")
1341:         WITH loc_oCnt.cnt_4c__Total
1342:             .Top = 52
1343:             .Left = 340
1344:             .Width = 194
1345:             .Height = 58
1346:             .BackColor = RGB(220, 220, 220)
1347:             .BorderWidth = 1
1348:             .Visible = .T.
1349:         ENDWITH
1350: 
1351:         loc_oCnt.cnt_4c__Total.AddObject("lbl_4c_TotCOcLbl", "Label")
1352:         WITH loc_oCnt.cnt_4c__Total.lbl_4c_TotCOcLbl
1353:             .Caption = "Ocorr" + CHR(234) + "ncias :"
1354:             .Top = 9
1355:             .Left = 49
1356:             .Width = 66
1357:             .Height = 15
1358:             .FontName = "Tahoma"
1359:             .FontSize = 8
1360:             .BackStyle = 0
1361:             .Visible = .T.
1362:         ENDWITH
1363: 
1364:         loc_oCnt.cnt_4c__Total.AddObject("lbl_4c_TotSOcLbl", "Label")
1365:         WITH loc_oCnt.cnt_4c__Total.lbl_4c_TotSOcLbl
1366:             .Caption = "Sem Ocorr" + CHR(234) + "ncias :"
1367:             .Top = 32
1368:             .Left = 26
1369:             .Width = 89
1370:             .Height = 15
1371:             .FontName = "Tahoma"
1372:             .FontSize = 8
1373:             .BackStyle = 0
1374:             .Visible = .T.
1375:         ENDWITH
1376: 
1377:         loc_oCnt.cnt_4c__Total.AddObject("txt_4c_TotCOc", "TextBox")
1378:         WITH loc_oCnt.cnt_4c__Total.txt_4c_TotCOc
1379:             .Value = 0
1380:             .ReadOnly = .T.
1381:             .Top = 6
1382:             .Left = 117
1383:             .Width = 71
1384:             .Height = 21
1385:             .FontName = "Tahoma"
1386:             .FontSize = 8
1387:             .BackColor = RGB(255, 255, 200)
1388:             .Visible = .T.
1389:         ENDWITH
1390: 
1391:         loc_oCnt.cnt_4c__Total.AddObject("txt_4c_TotSOc", "TextBox")
1392:         WITH loc_oCnt.cnt_4c__Total.txt_4c_TotSOc
1393:             .Value = 0
1394:             .ReadOnly = .T.
1395:             .Top = 29
1396:             .Left = 117
1397:             .Width = 71
1398:             .Height = 21
1399:             .FontName = "Tahoma"
1400:             .FontSize = 8
1401:             .BackColor = RGB(255, 255, 200)
1402:             .Visible = .T.
1403:         ENDWITH
1404: 
1405:         *-- Labels do painel superior
1406:         loc_oCnt.AddObject("lbl_4c_Descr", "Label")
1407:         WITH loc_oCnt.lbl_4c_Descr
1408:             .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
1409:             .Top = 126
1410:             .Left = 19
1411:             .Width = 55
1412:             .Height = 15
1413:             .FontName = "Tahoma"
1414:             .FontSize = 8
1415:             .BackStyle = 0
1416:             .Visible = .T.
1417:         ENDWITH
1418: 
1419:         loc_oCnt.AddObject("lbl_4c_CCustoLbl", "Label")
1420:         WITH loc_oCnt.lbl_4c_CCustoLbl
1421:             .Caption = "C. Custo :"
1422:             .Top = 151
1423:             .Left = 25
1424:             .Width = 51
1425:             .Height = 15
1426:             .FontName = "Tahoma"
1427:             .FontSize = 8
1428:             .BackStyle = 0
1429:             .Visible = .T.
1430:         ENDWITH
1431: 
1432:         loc_oCnt.AddObject("lbl_4c_CCusto2Lbl", "Label")
1433:         WITH loc_oCnt.lbl_4c_CCusto2Lbl
1434:             .Caption = "C. Custo2 :"
1435:             .Top = 149
1436:             .Left = 171
1437:             .Width = 57
1438:             .Height = 15
1439:             .FontName = "Tahoma"
1440:             .FontSize = 8
1441:             .BackStyle = 0
1442:             .Visible = .T.
1443:         ENDWITH
1444: 
1445:         loc_oCnt.AddObject("lbl_4c_DifLbl", "Label")
1446:         WITH loc_oCnt.lbl_4c_DifLbl
1447:             .Caption = "Diferen" + CHR(231) + "a :"
1448:             .Top = 149
1449:             .Left = 327
1450:             .Width = 55
1451:             .Height = 15
1452:             .FontName = "Tahoma"
1453:             .FontSize = 8
1454:             .BackStyle = 0
1455:             .Visible = .T.
1456:         ENDWITH
1457: 
1458:         loc_oCnt.AddObject("lbl_4c_PesRealLbl", "Label")
1459:         WITH loc_oCnt.lbl_4c_PesRealLbl
1460:             .Caption = "Peso Real :"
1461:             .Top = 176
1462:             .Left = 19
1463:             .Width = 56
1464:             .Height = 15
1465:             .FontName = "Tahoma"
1466:             .FontSize = 8
1467:             .BackStyle = 0
1468:             .Visible = .T.
1469:         ENDWITH
1470: 
1471:         loc_oCnt.AddObject("lbl_4c_PesoLbl", "Label")
1472:         WITH loc_oCnt.lbl_4c_PesoLbl
1473:             .Caption = "Peso :"
1474:             .Top = 174
1475:             .Left = 201
1476:             .Width = 32
1477:             .Height = 15
1478:             .FontName = "Tahoma"
1479:             .FontSize = 8
1480:             .BackStyle = 0
1481:             .Visible = .T.
1482:         ENDWITH
1483: 
1484:         loc_oCnt.AddObject("lbl_4c_UsarsLbl", "Label")
1485:         WITH loc_oCnt.lbl_4c_UsarsLbl
1486:             .Caption = "Usu" + CHR(225) + "rio :"
1487:             .Top = 174
1488:             .Left = 339
1489:             .Width = 45
1490:             .Height = 15
1491:             .FontName = "Tahoma"
1492:             .FontSize = 8
1493:             .BackStyle = 0

*-- Linhas 1499 a 1631:
1499:         WITH loc_oCnt.txt_4c_DPro
1500:             .Value = ""
1501:             .ReadOnly = .F.
1502:             .Top = 121
1503:             .Left = 87
1504:             .Width = 389
1505:             .Height = 23
1506:             .FontName = "Tahoma"
1507:             .FontSize = 8
1508:             .Visible = .T.
1509:         ENDWITH
1510: 
1511:         loc_oCnt.AddObject("txt_4c_CCusto", "TextBox")
1512:         WITH loc_oCnt.txt_4c_CCusto
1513:             .Value = ""
1514:             .ReadOnly = .T.
1515:             .Top = 146
1516:             .Left = 87
1517:             .Width = 80
1518:             .Height = 23
1519:             .FontName = "Tahoma"
1520:             .FontSize = 8
1521:             .BackColor = RGB(230, 230, 230)
1522:             .Visible = .T.
1523:         ENDWITH
1524: 
1525:         loc_oCnt.AddObject("txt_4c_CCusto2", "TextBox")
1526:         WITH loc_oCnt.txt_4c_CCusto2
1527:             .Value = ""
1528:             .ReadOnly = .T.
1529:             .Top = 146
1530:             .Left = 240
1531:             .Width = 80
1532:             .Height = 23
1533:             .FontName = "Tahoma"
1534:             .FontSize = 8
1535:             .BackColor = RGB(230, 230, 230)
1536:             .Visible = .T.
1537:         ENDWITH
1538: 
1539:         loc_oCnt.AddObject("txt_4c_Dif", "TextBox")
1540:         WITH loc_oCnt.txt_4c_Dif
1541:             .Value = 0
1542:             .ReadOnly = .T.
1543:             .Top = 146
1544:             .Left = 395
1545:             .Width = 81
1546:             .Height = 23
1547:             .FontName = "Tahoma"
1548:             .FontSize = 8
1549:             .BackColor = RGB(230, 230, 230)
1550:             .Visible = .T.
1551:         ENDWITH
1552: 
1553:         loc_oCnt.AddObject("txt_4c_PesReal", "TextBox")
1554:         WITH loc_oCnt.txt_4c_PesReal
1555:             .Value = 0
1556:             .ReadOnly = .T.
1557:             .Top = 171
1558:             .Left = 87
1559:             .Width = 80
1560:             .Height = 23
1561:             .FontName = "Tahoma"
1562:             .FontSize = 8
1563:             .BackColor = RGB(230, 230, 230)
1564:             .Visible = .T.
1565:         ENDWITH
1566: 
1567:         loc_oCnt.AddObject("txt_4c_Peso", "TextBox")
1568:         WITH loc_oCnt.txt_4c_Peso
1569:             .Value = 0
1570:             .ReadOnly = .T.
1571:             .Top = 171
1572:             .Left = 240
1573:             .Width = 80
1574:             .Height = 23
1575:             .FontName = "Tahoma"
1576:             .FontSize = 8
1577:             .BackColor = RGB(230, 230, 230)
1578:             .Visible = .T.
1579:         ENDWITH
1580: 
1581:         loc_oCnt.AddObject("txt_4c_Usuars", "TextBox")
1582:         WITH loc_oCnt.txt_4c_Usuars
1583:             .Value = ""
1584:             .ReadOnly = .T.
1585:             .Top = 171
1586:             .Left = 395
1587:             .Width = 81
1588:             .Height = 23
1589:             .FontName = "Tahoma"
1590:             .FontSize = 8
1591:             .BackColor = RGB(230, 230, 230)
1592:             .Visible = .T.
1593:         ENDWITH
1594: 
1595:         loc_oCnt.AddObject("edt_4c_ObsCnt1", "EditBox")
1596:         WITH loc_oCnt.edt_4c_ObsCnt1
1597:             .Value = ""
1598:             .Top = 121
1599:             .Left = 484
1600:             .Width = 507
1601:             .Height = 73
1602:             .FontName = "Tahoma"
1603:             .FontSize = 8
1604:             .Visible = .T.
1605:         ENDWITH
1606: 
1607:         *-- BINDEVENTS cnt_4c__CCusto1
1608:         BINDEVENT(loc_oCnt.cmd_4c_Sobra,      "Click",     THIS, "BtnSobraClick")
1609:         BINDEVENT(loc_oCnt.cmd_4c_Procurar,   "Click",     THIS, "BtnProcurarCntClick")
1610:         BINDEVENT(loc_oCnt.cmd_4c_BarraNovo,  "Click",     THIS, "BtnBarraNovoCntClick")
1611:         BINDEVENT(loc_oCnt.cmd_4c_CancelaCnt, "Click",     THIS, "BtnCancelaCntClick")
1612:         BINDEVENT(loc_oCnt.cmd_4c_SairCnt,    "Click",     THIS, "BtnSairCntClick")
1613:         BINDEVENT(loc_oCnt.txt_4c_DPro,       "KeyPress", THIS, "GetDProLostFocus")
1614: 
1615:         *==========================================================================
1616:         *-- grd_4c_Dados (GrdBalanco): Top=210+29=239, Left=17, W=972, H=364
1617:         *-- RecordSource definido fora do WITH (evita "Unknown member COLUMN1")
1618:         *==========================================================================
1619:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
1620:         loc_oGrid = loc_oPagina.grd_4c_Dados
1621:         loc_oGrid.RecordSource = ""
1622:         loc_oGrid.ColumnCount  = 10
1623: 
1624:         WITH loc_oGrid
1625:             .Top         = 239
1626:             .Left        = 17
1627:             .Width       = 972
1628:             .Height      = 364
1629:             .Visible     = .F.
1630:             .ReadOnly    = .F.
1631:             .FontName    = "Tahoma"

*-- Linhas 1640 a 1987:
1640:         WITH loc_oGrid.Column1
1641:             .Width = 120
1642:             .ReadOnly = .T.
1643:             .Header1.Caption = "Produto"
1644:         ENDWITH
1645:         WITH loc_oGrid.Column2
1646:             .Width = 80 
1647:             .ReadOnly = .T.
1648:             .Header1.Caption = "Data"
1649:         ENDWITH
1650:         WITH loc_oGrid.Column3
1651:             .Width = 100
1652:             .ReadOnly = .T.
1653:             .Header1.Caption = "Barra"
1654:         ENDWITH
1655:         WITH loc_oGrid.Column4
1656:             .Width = 80 
1657:             .ReadOnly = .T.
1658:             .Header1.Caption = "Barra Novo"
1659:         ENDWITH
1660:         WITH loc_oGrid.Column5
1661:             .Width = 65 
1662:             .ReadOnly = .T.
1663:             .Header1.Caption = "Apurado"
1664:         ENDWITH
1665:         WITH loc_oGrid.Column6
1666:             .Width = 65 
1667:             .ReadOnly = .T.
1668:             .Header1.Caption = "Estoque"
1669:         ENDWITH
1670:         WITH loc_oGrid.Column7
1671:             .Width = 65 
1672:             .ReadOnly = .T.
1673:             .Header1.Caption = "Diferen" + CHR(231) + "a"
1674:         ENDWITH
1675:         WITH loc_oGrid.Column8
1676:             .Width = 80 
1677:             .ReadOnly = .F.
1678:             .Sparse = .F.
1679:             .Header1.Caption = "Ocorrencia"
1680:         ENDWITH
1681:         WITH loc_oGrid.Column9
1682:             .Width = 20 
1683:             .ReadOnly = .T.
1684:             .Header1.Caption = "T"
1685:         ENDWITH
1686:         WITH loc_oGrid.Column10
1687:             .Width = 70
1688:             .ReadOnly = .T.
1689:             .Header1.Caption = "Dif. Peso"
1690:         ENDWITH
1691: 
1692:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdBalancoAfterRowColChange")
1693:         BINDEVENT(loc_oGrid.Column8.Text1, "When",      THIS, "GrdColOcorWhen")
1694:         BINDEVENT(loc_oGrid.Column8.Text1, "Valid",     THIS, "GrdColOcorValid")
1695:         BINDEVENT(loc_oGrid.Column8.Text1, "KeyPress", THIS, "GrdColOcorLostFocus")
1696: 
1697:         *==========================================================================
1698:         *-- cnt_4c__Custo2 (painel Novo Barra): Top=210+29=239
1699:         *==========================================================================
1700:         loc_oPagina.AddObject("cnt_4c__Custo2", "Container")
1701:         WITH loc_oPagina.cnt_4c__Custo2
1702:             .Top = 239
1703:             .Left = 17
1704:             .Width = 972
1705:             .Height = 364
1706:             .Visible = .F.
1707:             .BackColor = RGB(240, 240, 240)
1708:             .BorderWidth = 1
1709:         ENDWITH
1710: 
1711:         loc_oCnt = loc_oPagina.cnt_4c__Custo2
1712: 
1713:         loc_oCnt.AddObject("lbl_4c_BNlbl4", "Label")
1714:         WITH loc_oCnt.lbl_4c_BNlbl4
1715:             .Caption = "Barra Novo :"
1716:             .Top = 18
1717:             .Left = 270
1718:             .Width = 63
1719:             .Height = 15
1720:             .FontName = "Tahoma"
1721:             .FontSize = 8
1722:             .BackStyle = 0
1723:             .Visible = .T.
1724:         ENDWITH
1725:         loc_oCnt.AddObject("lbl_4c_BNlbl3", "Label")
1726:         WITH loc_oCnt.lbl_4c_BNlbl3
1727:             .Caption = "Centro de Custo :"
1728:             .Top = 43
1729:             .Left = 245
1730:             .Width = 88
1731:             .Height = 15
1732:             .FontName = "Tahoma"
1733:             .FontSize = 8
1734:             .BackStyle = 0
1735:             .Visible = .T.
1736:         ENDWITH
1737:         loc_oCnt.AddObject("lbl_4c_BNlbl2", "Label")
1738:         WITH loc_oCnt.lbl_4c_BNlbl2
1739:             .Caption = "Peso :"
1740:             .Top = 68
1741:             .Left = 301
1742:             .Width = 32
1743:             .Height = 15
1744:             .FontName = "Tahoma"
1745:             .FontSize = 8
1746:             .BackStyle = 0
1747:             .Visible = .T.
1748:         ENDWITH
1749:         loc_oCnt.AddObject("lbl_4c_BNlbl5", "Label")
1750:         WITH loc_oCnt.lbl_4c_BNlbl5
1751:             .Caption = "C" + CHR(243) + "digo Justificativa :"
1752:             .Top = 92
1753:             .Left = 231
1754:             .Width = 102
1755:             .Height = 15
1756:             .FontName = "Tahoma"
1757:             .FontSize = 8
1758:             .BackStyle = 0
1759:             .Visible = .T.
1760:         ENDWITH
1761:         loc_oCnt.AddObject("lbl_4c_BNlbl1", "Label")
1762:         WITH loc_oCnt.lbl_4c_BNlbl1
1763:             .Caption = "Observa" + CHR(231) + CHR(227) + "o :"
1764:             .Top = 115
1765:             .Left = 266
1766:             .Width = 67
1767:             .Height = 15
1768:             .FontName = "Tahoma"
1769:             .FontSize = 8
1770:             .BackStyle = 0
1771:             .Visible = .T.
1772:         ENDWITH
1773: 
1774:         loc_oCnt.AddObject("txt_4c_GetBarNovo", "TextBox")
1775:         WITH loc_oCnt.txt_4c_GetBarNovo
1776:             .Value = ""
1777:             .Top = 14
1778:             .Left = 339
1779:             .Width = 108
1780:             .Height = 23
1781:             .FontName = "Tahoma"
1782:             .FontSize = 8
1783:             .Visible = .T.
1784:         ENDWITH
1785:         loc_oCnt.AddObject("txt_4c_BNCCusto", "TextBox")
1786:         WITH loc_oCnt.txt_4c_BNCCusto
1787:             .Value = ""
1788:             .ReadOnly = .T.
1789:             .Top = 39
1790:             .Left = 339
1791:             .Width = 80
1792:             .Height = 23
1793:             .FontName = "Tahoma"
1794:             .FontSize = 8
1795:             .BackColor = RGB(230, 230, 230)
1796:             .Visible = .T.
1797:         ENDWITH
1798:         loc_oCnt.AddObject("txt_4c_BNPesReal", "TextBox")
1799:         WITH loc_oCnt.txt_4c_BNPesReal
1800:             .Value = 0
1801:             .ReadOnly = .T.
1802:             .Top = 64
1803:             .Left = 339
1804:             .Width = 80
1805:             .Height = 23
1806:             .FontName = "Tahoma"
1807:             .FontSize = 8
1808:             .BackColor = RGB(230, 230, 230)
1809:             .Visible = .T.
1810:         ENDWITH
1811:         loc_oCnt.AddObject("txt_4c_GetJustif", "TextBox")
1812:         WITH loc_oCnt.txt_4c_GetJustif
1813:             .Value = ""
1814:             .Top = 89
1815:             .Left = 339
1816:             .Width = 80
1817:             .Height = 21
1818:             .FontName = "Tahoma"
1819:             .FontSize = 8
1820:             .Visible = .T.
1821:         ENDWITH
1822:         loc_oCnt.AddObject("edt_4c_BNObs", "EditBox")
1823:         WITH loc_oCnt.edt_4c_BNObs
1824:             .Value = ""
1825:             .Top = 112
1826:             .Left = 339
1827:             .Width = 390
1828:             .Height = 101
1829:             .FontName = "Tahoma"
1830:             .FontSize = 8
1831:             .Visible = .T.
1832:         ENDWITH
1833:         loc_oCnt.AddObject("cmd_4c_BNCancela", "CommandButton")
1834:         WITH loc_oCnt.cmd_4c_BNCancela
1835:             .Top = 5
1836:             .Left = 570
1837:             .Width = 75
1838:             .Height = 75
1839:             .Caption = "Cancelar"
1840:             .FontName = "Tahoma"
1841:             .FontSize = 9
1842:             .Visible = .T.
1843:         ENDWITH
1844:         loc_oCnt.AddObject("cmd_4c_BNSair", "CommandButton")
1845:         WITH loc_oCnt.cmd_4c_BNSair
1846:             .Top = 5
1847:             .Left = 645
1848:             .Width = 75
1849:             .Height = 75
1850:             .Caption = "OK"
1851:             .FontName = "Tahoma"
1852:             .FontSize = 9
1853:             .Visible = .T.
1854:         ENDWITH
1855: 
1856:         BINDEVENT(loc_oCnt.txt_4c_GetJustif, "LostFocus", THIS, "GetJustifValid")
1857:         BINDEVENT(loc_oCnt.cmd_4c_BNCancela, "Click", THIS, "BtnBNCancelaClick")
1858:         BINDEVENT(loc_oCnt.cmd_4c_BNSair,    "Click", THIS, "BtnBNSairClick")
1859: 
1860:         *==========================================================================
1861:         *-- cnt_4c_TratOcor (Tratamento por Ocorrencia): Top=210+29=239
1862:         *==========================================================================
1863:         loc_oPagina.AddObject("cnt_4c_TratOcor", "Container")
1864:         WITH loc_oPagina.cnt_4c_TratOcor
1865:             .Top = 239
1866:             .Left = 17
1867:             .Width = 972
1868:             .Height = 364
1869:             .Visible = .F.
1870:             .BackColor = RGB(240, 240, 240)
1871:             .BorderWidth = 1
1872:         ENDWITH
1873: 
1874:         loc_oCnt = loc_oPagina.cnt_4c_TratOcor
1875: 
1876:         loc_oCnt.AddObject("lbl_4c_TOlbl3", "Label")
1877:         WITH loc_oCnt.lbl_4c_TOlbl3
1878:             .Caption = "Tratamento Por Ocorr" + CHR(234) + "ncia"
1879:             .Top = 7
1880:             .Left = 16
1881:             .Width = 200
1882:             .Height = 17
1883:             .FontName = "Tahoma"
1884:             .FontSize = 10
1885:             .FontBold = .T.
1886:             .BackStyle = 0
1887:             .Visible = .T.
1888:         ENDWITH
1889:         loc_oCnt.AddObject("lbl_4c_TOlbl5", "Label")
1890:         WITH loc_oCnt.lbl_4c_TOlbl5
1891:             .Caption = "Tipo Ocorr" + CHR(234) + "ncia :"
1892:             .Top = 46
1893:             .Left = 294
1894:             .Width = 84
1895:             .Height = 15
1896:             .FontName = "Tahoma"
1897:             .FontSize = 8
1898:             .BackStyle = 0
1899:             .Visible = .T.
1900:         ENDWITH
1901:         loc_oCnt.AddObject("lbl_4c_TOlbl4", "Label")
1902:         WITH loc_oCnt.lbl_4c_TOlbl4
1903:             .Caption = "Ocorr" + CHR(234) + "ncia :"
1904:             .Top = 68
1905:             .Left = 317
1906:             .Width = 61
1907:             .Height = 15
1908:             .FontName = "Tahoma"
1909:             .FontSize = 8
1910:             .BackStyle = 0
1911:             .Visible = .T.
1912:         ENDWITH
1913:         loc_oCnt.AddObject("lbl_4c_TOlbl7", "Label")
1914:         WITH loc_oCnt.lbl_4c_TOlbl7
1915:             .Caption = "Tipos :"
1916:             .Top = 123
1917:             .Left = 344
1918:             .Width = 34
1919:             .Height = 15
1920:             .FontName = "Tahoma"
1921:             .FontSize = 8
1922:             .BackStyle = 0
1923:             .Visible = .T.
1924:         ENDWITH
1925:         loc_oCnt.AddObject("lbl_4c_TOlbl8", "Label")
1926:         WITH loc_oCnt.lbl_4c_TOlbl8
1927:             .Caption = "Ordem :"
1928:             .Top = 149
1929:             .Left = 337
1930:             .Width = 41
1931:             .Height = 15
1932:             .FontName = "Tahoma"
1933:             .FontSize = 8
1934:             .BackStyle = 0
1935:             .Visible = .T.
1936:         ENDWITH
1937: 
1938:         loc_oCnt.AddObject("txt_4c_TOcor", "TextBox")
1939:         WITH loc_oCnt.txt_4c_TOcor
1940:             .Value = ""
1941:             .Top = 43
1942:             .Left = 383
1943:             .Width = 80
1944:             .Height = 21
1945:             .FontName = "Tahoma"
1946:             .FontSize = 8
1947:             .Visible = .T.
1948:         ENDWITH
1949: 
1950:         loc_oCnt.AddObject("opt_4c_SemOcor", "OptionGroup")
1951:         WITH loc_oCnt.opt_4c_SemOcor
1952:             .Top = 66
1953:             .Left = 379
1954:             .Width = 114
1955:             .Height = 49
1956:             .ButtonCount = 3
1957:             .Value = 1
1958:             .BackStyle = 0
1959:             .Visible = .T.
1960:         ENDWITH
1961:         WITH loc_oCnt.opt_4c_SemOcor
1962:             .Buttons(1).Caption = "Lidos"
1963:             .Buttons(1).Top = 0
1964:             .Buttons(1).Left = 0
1965:             .Buttons(1).Width = 55
1966:             .Buttons(1).Height = 17
1967:             .Buttons(2).Caption = "N" + CHR(227) + "o Lidos"
1968:             .Buttons(2).Top = 16
1969:             .Buttons(2).Left = 0
1970:             .Buttons(2).Width = 55
1971:             .Buttons(2).Height = 17
1972:             .Buttons(3).Caption = "Saldos"
1973:             .Buttons(3).Top = 32
1974:             .Buttons(3).Left = 0
1975:             .Buttons(3).Width = 55
1976:             .Buttons(3).Height = 17
1977:         ENDWITH
1978: 
1979:         loc_oCnt.AddObject("cmb_4c_Tipos", "ComboBox")
1980:         WITH loc_oCnt.cmb_4c_Tipos
1981:             .Top = 118
1982:             .Left = 383
1983:             .Width = 115
1984:             .Height = 24
1985:             .Style = 2
1986:             .FontName = "Tahoma"
1987:             .FontSize = 8

*-- Linhas 1994 a 2342:
1994: 
1995:         loc_oCnt.AddObject("cmb_4c_Ordem", "ComboBox")
1996:         WITH loc_oCnt.cmb_4c_Ordem
1997:             .Top = 144
1998:             .Left = 383
1999:             .Width = 115
2000:             .Height = 24
2001:             .Style = 2
2002:             .FontName = "Tahoma"
2003:             .FontSize = 8
2004:             .Visible = .T.
2005:         ENDWITH
2006:         loc_oCnt.cmb_4c_Ordem.AddItem("Barra")
2007:         loc_oCnt.cmb_4c_Ordem.AddItem("Produto")
2008:         loc_oCnt.cmb_4c_Ordem.Value = "Barra"
2009: 
2010:         loc_oCnt.AddObject("cmd_4c_BtnTratOcor", "CommandButton")
2011:         WITH loc_oCnt.cmd_4c_BtnTratOcor
2012:             .Top = 45
2013:             .Left = 582
2014:             .Width = 75
2015:             .Height = 75
2016:             .Caption = "OK"
2017:             .FontName = "Tahoma"
2018:             .FontSize = 9
2019:             .Visible = .T.
2020:         ENDWITH
2021:         loc_oCnt.AddObject("cmd_4c_TOCancela", "CommandButton")
2022:         WITH loc_oCnt.cmd_4c_TOCancela
2023:             .Top = 45
2024:             .Left = 507
2025:             .Width = 75
2026:             .Height = 75
2027:             .Caption = "Cancelar"
2028:             .FontName = "Tahoma"
2029:             .FontSize = 9
2030:             .Visible = .T.
2031:         ENDWITH
2032: 
2033:         BINDEVENT(loc_oCnt.txt_4c_TOcor,       "LostFocus", THIS, "GetTOcorCntTratValid")
2034:         BINDEVENT(loc_oCnt.cmd_4c_BtnTratOcor, "Click", THIS, "BtnTratOcorClick")
2035:         BINDEVENT(loc_oCnt.cmd_4c_TOCancela,   "Click", THIS, "BtnTOCancelaClick")
2036: 
2037:         *==========================================================================
2038:         *-- cnt_4c_BaixaAuto (Baixa Automatica por Ocorrencia): Top=210+29=239
2039:         *==========================================================================
2040:         loc_oPagina.AddObject("cnt_4c_BaixaAuto", "Container")
2041:         WITH loc_oPagina.cnt_4c_BaixaAuto
2042:             .Top = 239
2043:             .Left = 17
2044:             .Width = 972
2045:             .Height = 364
2046:             .Visible = .F.
2047:             .BackColor = RGB(240, 240, 240)
2048:             .BorderWidth = 1
2049:         ENDWITH
2050: 
2051:         loc_oCnt = loc_oPagina.cnt_4c_BaixaAuto
2052: 
2053:         loc_oCnt.AddObject("lbl_4c_BAlbl3", "Label")
2054:         WITH loc_oCnt.lbl_4c_BAlbl3
2055:             .Caption = "Baixa Autom" + CHR(225) + "tica por Ocorr" + CHR(234) + "ncia"
2056:             .Top = 7
2057:             .Left = 14
2058:             .Width = 250
2059:             .Height = 17
2060:             .FontName = "Tahoma"
2061:             .FontSize = 10
2062:             .FontBold = .T.
2063:             .BackStyle = 0
2064:             .Visible = .T.
2065:         ENDWITH
2066:         loc_oCnt.AddObject("lbl_4c_BAlbl5", "Label")
2067:         WITH loc_oCnt.lbl_4c_BAlbl5
2068:             .Caption = "Ocorr" + CHR(234) + "ncia :"
2069:             .Top = 48
2070:             .Left = 294
2071:             .Width = 61
2072:             .Height = 15
2073:             .FontName = "Tahoma"
2074:             .FontSize = 8
2075:             .BackStyle = 0
2076:             .Visible = .T.
2077:         ENDWITH
2078:         loc_oCnt.AddObject("lbl_4c_BAlbl1", "Label")
2079:         WITH loc_oCnt.lbl_4c_BAlbl1
2080:             .Caption = "Per" + CHR(237) + "odo :"
2081:             .Top = 71
2082:             .Left = 310
2083:             .Width = 45
2084:             .Height = 15
2085:             .FontName = "Tahoma"
2086:             .FontSize = 8
2087:             .BackStyle = 0
2088:             .Visible = .T.
2089:         ENDWITH
2090:         loc_oCnt.AddObject("lbl_4c_BAlbl4", "Label")
2091:         WITH loc_oCnt.lbl_4c_BAlbl4
2092:             .Caption = " - "
2093:             .Top = 70
2094:             .Left = 444
2095:             .Width = 14
2096:             .Height = 17
2097:             .FontName = "Tahoma"
2098:             .FontSize = 8
2099:             .BackStyle = 0
2100:             .Visible = .T.
2101:         ENDWITH
2102: 
2103:         loc_oCnt.AddObject("txt_4c_BATOcor", "TextBox")
2104:         WITH loc_oCnt.txt_4c_BATOcor
2105:             .Value = ""
2106:             .Top = 45
2107:             .Left = 360
2108:             .Width = 80
2109:             .Height = 21
2110:             .FontName = "Tahoma"
2111:             .FontSize = 8
2112:             .Visible = .T.
2113:         ENDWITH
2114:         loc_oCnt.AddObject("txt_4c_BAData", "TextBox")
2115:         WITH loc_oCnt.txt_4c_BAData
2116:             .Value = {}
2117:             .Top = 68
2118:             .Left = 360
2119:             .Width = 80
2120:             .Height = 21
2121:             .FontName = "Tahoma"
2122:             .FontSize = 8
2123:             .Format = "D"
2124:             .Visible = .T.
2125:         ENDWITH
2126:         loc_oCnt.AddObject("txt_4c_BADataF", "TextBox")
2127:         WITH loc_oCnt.txt_4c_BADataF
2128:             .Value = {}
2129:             .Top = 68
2130:             .Left = 454
2131:             .Width = 80
2132:             .Height = 21
2133:             .FontName = "Tahoma"
2134:             .FontSize = 8
2135:             .Format = "D"
2136:             .Visible = .T.
2137:         ENDWITH
2138:         loc_oCnt.AddObject("cmd_4c_OkBaixaAuto", "CommandButton")
2139:         WITH loc_oCnt.cmd_4c_OkBaixaAuto
2140:             .Top = 45
2141:             .Left = 626
2142:             .Width = 75
2143:             .Height = 75
2144:             .Caption = "OK"
2145:             .FontName = "Tahoma"
2146:             .FontSize = 9
2147:             .Visible = .T.
2148:         ENDWITH
2149:         loc_oCnt.AddObject("cmd_4c_BACancela", "CommandButton")
2150:         WITH loc_oCnt.cmd_4c_BACancela
2151:             .Top = 45
2152:             .Left = 551
2153:             .Width = 75
2154:             .Height = 75
2155:             .Caption = "Cancelar"
2156:             .FontName = "Tahoma"
2157:             .FontSize = 9
2158:             .Visible = .T.
2159:         ENDWITH
2160: 
2161:         BINDEVENT(loc_oCnt.txt_4c_BATOcor,    "LostFocus", THIS, "GetTOcorBaixaAutoValid")
2162:         BINDEVENT(loc_oCnt.cmd_4c_OkBaixaAuto,"Click", THIS, "OkBaixaAutoClick")
2163:         BINDEVENT(loc_oCnt.cmd_4c_BACancela,  "Click", THIS, "BtnBACancelaClick")
2164: 
2165:         *==========================================================================
2166:         *-- cnt_4c__Inserir (painel Inserir item de sobra): Top=210+29=239
2167:         *==========================================================================
2168:         loc_oPagina.AddObject("cnt_4c__Inserir", "Container")
2169:         WITH loc_oPagina.cnt_4c__Inserir
2170:             .Top = 239
2171:             .Left = 17
2172:             .Width = 972
2173:             .Height = 364
2174:             .Visible = .F.
2175:             .BackColor = RGB(240, 240, 240)
2176:             .BorderWidth = 1
2177:         ENDWITH
2178: 
2179:         loc_oCnt = loc_oPagina.cnt_4c__Inserir
2180: 
2181:         loc_oCnt.AddObject("lbl_4c_IBlbl4", "Label")
2182:         WITH loc_oCnt.lbl_4c_IBlbl4
2183:             .Caption = "Barra :"
2184:             .Top = 25
2185:             .Left = 289
2186:             .Width = 35
2187:             .Height = 15
2188:             .FontName = "Tahoma"
2189:             .FontSize = 8
2190:             .BackStyle = 0
2191:             .Visible = .T.
2192:         ENDWITH
2193:         loc_oCnt.AddObject("lbl_4c_IBlbl3", "Label")
2194:         WITH loc_oCnt.lbl_4c_IBlbl3
2195:             .Caption = "C. Custo :"
2196:             .Top = 50
2197:             .Left = 273
2198:             .Width = 51
2199:             .Height = 15
2200:             .FontName = "Tahoma"
2201:             .FontSize = 8
2202:             .BackStyle = 0
2203:             .Visible = .T.
2204:         ENDWITH
2205:         loc_oCnt.AddObject("lbl_4c_IBlbl5", "Label")
2206:         WITH loc_oCnt.lbl_4c_IBlbl5
2207:             .Caption = "Ocorr" + CHR(234) + "ncia :"
2208:             .Top = 74
2209:             .Left = 263
2210:             .Width = 61
2211:             .Height = 15
2212:             .FontName = "Tahoma"
2213:             .FontSize = 8
2214:             .BackStyle = 0
2215:             .Visible = .T.
2216:         ENDWITH
2217:         loc_oCnt.AddObject("lbl_4c_IBlbl1", "Label")
2218:         WITH loc_oCnt.lbl_4c_IBlbl1
2219:             .Caption = "Observa" + CHR(231) + CHR(227) + "o :"
2220:             .Top = 97
2221:             .Left = 257
2222:             .Width = 67
2223:             .Height = 15
2224:             .FontName = "Tahoma"
2225:             .FontSize = 8
2226:             .BackStyle = 0
2227:             .Visible = .T.
2228:         ENDWITH
2229: 
2230:         loc_oCnt.AddObject("txt_4c_IBarra", "TextBox")
2231:         WITH loc_oCnt.txt_4c_IBarra
2232:             .Value = ""
2233:             .Top = 21
2234:             .Left = 329
2235:             .Width = 108
2236:             .Height = 23
2237:             .FontName = "Tahoma"
2238:             .FontSize = 8
2239:             .Visible = .T.
2240:         ENDWITH
2241:         loc_oCnt.AddObject("txt_4c_ICCusto", "TextBox")
2242:         WITH loc_oCnt.txt_4c_ICCusto
2243:             .Value = ""
2244:             .ReadOnly = .T.
2245:             .Top = 46
2246:             .Left = 329
2247:             .Width = 80
2248:             .Height = 23
2249:             .FontName = "Tahoma"
2250:             .FontSize = 8
2251:             .BackColor = RGB(230, 230, 230)
2252:             .Visible = .T.
2253:         ENDWITH
2254:         loc_oCnt.AddObject("txt_4c_IOcor", "TextBox")
2255:         WITH loc_oCnt.txt_4c_IOcor
2256:             .Value = ""
2257:             .Top = 71
2258:             .Left = 329
2259:             .Width = 80
2260:             .Height = 21
2261:             .FontName = "Tahoma"
2262:             .FontSize = 8
2263:             .Visible = .T.
2264:         ENDWITH
2265:         loc_oCnt.AddObject("edt_4c_IBObs", "EditBox")
2266:         WITH loc_oCnt.edt_4c_IBObs
2267:             .Value = ""
2268:             .Top = 94
2269:             .Left = 329
2270:             .Width = 220
2271:             .Height = 101
2272:             .FontName = "Tahoma"
2273:             .FontSize = 8
2274:             .Visible = .T.
2275:         ENDWITH
2276:         loc_oCnt.AddObject("cmd_4c_CntInsere", "CommandButton")
2277:         WITH loc_oCnt.cmd_4c_CntInsere
2278:             .Top = 21
2279:             .Left = 562
2280:             .Width = 75
2281:             .Height = 75
2282:             .Caption = "Inserir"
2283:             .FontName = "Tahoma"
2284:             .FontSize = 9
2285:             .Enabled = .F.
2286:             .Visible = .T.
2287:         ENDWITH
2288:         loc_oCnt.AddObject("cmd_4c_CntSairIns", "CommandButton")
2289:         WITH loc_oCnt.cmd_4c_CntSairIns
2290:             .Top = 21
2291:             .Left = 637
2292:             .Width = 75
2293:             .Height = 75
2294:             .Caption = "OK"
2295:             .FontName = "Tahoma"
2296:             .FontSize = 9
2297:             .Visible = .T.
2298:         ENDWITH
2299: 
2300:         BINDEVENT(loc_oCnt.txt_4c_IBarra,     "LostFocus", THIS, "GetIBarraValid")
2301:         BINDEVENT(loc_oCnt.txt_4c_IOcor,      "LostFocus", THIS, "GetIOcorValid")
2302:         BINDEVENT(loc_oCnt.cmd_4c_CntInsere,  "Click", THIS, "CntInsereClick")
2303:         BINDEVENT(loc_oCnt.cmd_4c_CntSairIns, "Click", THIS, "CntSairInsClick")
2304: 
2305:         *==========================================================================
2306:         *-- cnt_4c__Procurar (painel Procurar por Barra): Top=210+29=239
2307:         *==========================================================================
2308:         loc_oPagina.AddObject("cnt_4c__Procurar", "Container")
2309:         WITH loc_oPagina.cnt_4c__Procurar
2310:             .Top = 239
2311:             .Left = 17
2312:             .Width = 972
2313:             .Height = 364
2314:             .Visible = .F.
2315:             .BackColor = RGB(240, 240, 240)
2316:             .BorderWidth = 1
2317:         ENDWITH
2318: 
2319:         loc_oCnt = loc_oPagina.cnt_4c__Procurar
2320: 
2321:         loc_oCnt.AddObject("lbl_4c_PrBarra", "Label")
2322:         WITH loc_oCnt.lbl_4c_PrBarra
2323:             .Caption = "Barra :"
2324:             .Top = 22
2325:             .Left = 27
2326:             .Width = 35
2327:             .Height = 15
2328:             .FontName = "Tahoma"
2329:             .FontSize = 8
2330:             .BackStyle = 0
2331:             .Visible = .T.
2332:         ENDWITH
2333:         loc_oCnt.AddObject("txt_4c_GetBusca", "TextBox")
2334:         WITH loc_oCnt.txt_4c_GetBusca
2335:             .Value = ""
2336:             .Top = 18
2337:             .Left = 71
2338:             .Width = 108
2339:             .Height = 23
2340:             .FontName = "Tahoma"
2341:             .FontSize = 8
2342:             .Visible = .T.

*-- Linhas 2379 a 2396:
2379:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.usuars"
2380:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.encerras"
2381:                     *-- Problem 6/32: Headers DEVEM ser redefinidos apos RecordSource
2382:                     loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
2383:                     loc_oGrid.Column2.Header1.Caption  = "Inicial"
2384:                     loc_oGrid.Column3.Header1.Caption  = "Final"
2385:                     loc_oGrid.Column4.Header1.Caption  = "Conta"
2386:                     loc_oGrid.Column5.Header1.Caption  = "Local Ini."
2387:                     loc_oGrid.Column6.Header1.Caption  = "Local Fin."
2388:                     loc_oGrid.Column7.Header1.Caption  = "Grupo"
2389:                     loc_oGrid.Column8.Header1.Caption  = "Gde.Grupo"
2390:                     loc_oGrid.Column9.Header1.Caption  = "Usu" + CHR(225) + "rio"
2391:                     loc_oGrid.Column10.Header1.Caption = "Encerrado"
2392:                     *-- Larguras aproximadas do original
2393:                     loc_oGrid.Column1.Width  = 60
2394:                     loc_oGrid.Column2.Width  = 75
2395:                     loc_oGrid.Column3.Width  = 75
2396:                     loc_oGrid.Column4.Width  = 70

*-- Linhas 2520 a 2539:
2520:             loc_oPg2.txt_4c_DGrupo.Value         = ""
2521:             loc_oPg2.txt_4c_Conta.Value          = ALLTRIM(.this_cContas)
2522:             loc_oPg2.txt_4c_DConta.Value         = ""
2523:             loc_oPg2.txt_4c_DataInicial.Value    = .this_dDataInis
2524:             loc_oPg2.txt_4c_DataFinal.Value      = .this_dDataFims
2525:             loc_oPg2.txt_4c_LocalInicial.Value   = ALLTRIM(.this_cLocalis)
2526:             loc_oPg2.txt_4c_LocalFinal.Value     = ALLTRIM(.this_cLocalfs)
2527:             loc_oPg2.txt_4c_FornecInicial.Value  = ALLTRIM(.this_cIforis)
2528:             loc_oPg2.txt_4c_FornecFinal.Value    = ALLTRIM(.this_cIforfs)
2529:             loc_oPg2.txt_4c_GrupoInicial.Value   = ALLTRIM(.this_cCgruis)
2530:             loc_oPg2.txt_4c_GrupoFinal.Value     = ALLTRIM(.this_cCgrufs)
2531:             loc_oPg2.txt_4c_GGrupoInicial.Value  = ALLTRIM(.this_cCggruis)
2532:             loc_oPg2.txt_4c_GGrupoFinal.Value    = ALLTRIM(.this_cCggrufs)
2533:             loc_oPg2.txt_4c_PrecoInicial.Value   = .this_nPrecois
2534:             loc_oPg2.txt_4c_PrecoFinal.Value     = .this_nPrecofs
2535:         ENDWITH
2536:     ENDPROC
2537: 
2538:     *===========================================================================
2539:     * LimparCampos - Limpa todos os campos de entrada da Page2

*-- Linhas 2727 a 2791:
2727:                     " WHERE a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
2728:                     " AND a.Codigos = " + TRANSFORM(THIS.this_nCodigoSel) + ;
2729:                     " ORDER BY a.Barras"
2730: 
2731:                 *-- Fechar cursor temporario de chamada anterior, se existir
2732:                 IF USED("cursor_4c_TratamentoTemp")
2733:                     USE IN cursor_4c_TratamentoTemp
2734:                 ENDIF
2735: 
2736:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TratamentoTemp")
2737: 
2738:                 IF loc_nResult < 0
2739:                     MostrarErro("Erro ao carregar itens:" + CHR(13) + ;
2740:                         CapturarErroSQL(), "Formint.CarregarGradeTratamento")
2741:                 ELSE
2742:                     loc_oPg3  = THIS.pgf_4c_Paginas.Page3
2743:                     loc_oGrid = loc_oPg3.grd_4c_Dados
2744: 
2745:                     IF USED("cursor_4c_Tratamento")
2746:                         *-- Grid ja vinculado: repopular sem fechar o RecordSource cursor
2747:                         SELECT cursor_4c_Tratamento
2748:                         ZAP
2749:                         APPEND FROM DBF(DBF("cursor_4c_TratamentoTemp"))
2750:                         USE IN cursor_4c_TratamentoTemp
2751:                         SELECT cursor_4c_Tratamento
2752:                         GO TOP
2753:                         loc_oGrid.Refresh()
2754:                     ELSE
2755:                         *-- Primeira carga: precisa do cursor com nome correto
2756:                         USE IN cursor_4c_TratamentoTemp
2757:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tratamento")
2758:                         IF loc_nResult < 0
2759:                             MostrarErro("Erro ao carregar itens:" + CHR(13) + ;
2760:                                 CapturarErroSQL(), "Formint.CarregarGradeTratamento")
2761:                         ELSE
2762:                             *-- Vincular cursor ao grid (somente na primeira carga)
2763:                             loc_oGrid.ColumnCount = 10
2764:                             loc_oGrid.RecordSource = "cursor_4c_Tratamento"
2765:                             loc_oGrid.Column1.ControlSource  = "cursor_4c_Tratamento.Produto"
2766:                             loc_oGrid.Column2.ControlSource  = "cursor_4c_Tratamento.Datas"
2767:                             loc_oGrid.Column3.ControlSource  = "cursor_4c_Tratamento.Barras"
2768:                             loc_oGrid.Column4.ControlSource  = "cursor_4c_Tratamento.BarraNovos"
2769:                             loc_oGrid.Column5.ControlSource  = "cursor_4c_Tratamento.Apurado"
2770:                             loc_oGrid.Column6.ControlSource  = "cursor_4c_Tratamento.Estoque"
2771:                             loc_oGrid.Column7.ControlSource  = "cursor_4c_Tratamento.Faltas"
2772:                             loc_oGrid.Column8.ControlSource  = "cursor_4c_Tratamento.Ocorrencia"
2773:                             loc_oGrid.Column9.ControlSource  = "cursor_4c_Tratamento.Tipos"
2774:                             loc_oGrid.Column10.ControlSource = "cursor_4c_Tratamento.PesReals"
2775: 
2776:                             *-- Headers DEVEM ser redefinidos apos RecordSource (VFP9 reseta para nome do campo)
2777:                             loc_oGrid.Column1.Header1.Caption  = "Produto"
2778:                             loc_oGrid.Column2.Header1.Caption  = "Data"
2779:                             loc_oGrid.Column3.Header1.Caption  = "Barra"
2780:                             loc_oGrid.Column4.Header1.Caption  = "Barra Novo"
2781:                             loc_oGrid.Column5.Header1.Caption  = "Apurado"
2782:                             loc_oGrid.Column6.Header1.Caption  = "Estoque"
2783:                             loc_oGrid.Column7.Header1.Caption  = "Diferen" + CHR(231) + "a"
2784:                             loc_oGrid.Column8.Header1.Caption  = "Ocorrencia"
2785:                             loc_oGrid.Column9.Header1.Caption  = "T"
2786:                             loc_oGrid.Column10.Header1.Caption = "Dif. Peso"
2787:                         ENDIF
2788:                     ENDIF
2789: 
2790:                     IF loc_nResult >= 0
2791:                         *-- Ajuste dinamico da coluna Dif. Peso (trtporpeso)

*-- Linhas 2801 a 2837:
2801:                         ENDIF
2802: 
2803:                         *-- Calcular totais iniciais de ocorrencias
2804:                         loc_nTotCOc = 0
2805:                         loc_nTotSOc = 0
2806:                         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
2807:                             SELECT cursor_4c_Tratamento
2808:                             GO TOP
2809:                             SCAN
2810:                                 IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia))
2811:                                     loc_nTotCOc = loc_nTotCOc + 1
2812:                                 ELSE
2813:                                     loc_nTotSOc = loc_nTotSOc + 1
2814:                                 ENDIF
2815:                             ENDSCAN
2816:                         ENDIF
2817: 
2818:                         WITH loc_oPg3.cnt_4c__CCusto1.cnt_4c__Total
2819:                             .txt_4c_TotCOc.Value = loc_nTotCOc
2820:                             .txt_4c_TotSOc.Value = loc_nTotSOc
2821:                             .Visible     = .T.
2822:                         ENDWITH
2823: 
2824:                         *-- Exibir grid e painel de controles
2825:                         loc_oPg3.cnt_4c__CCusto1.Visible = .T.
2826:                         loc_oGrid.Visible = .T.
2827:                         loc_oGrid.Refresh()
2828:                         loc_oGrid.SetFocus()
2829: 
2830:                         *-- Resetar caption do botao Sair
2831:                         loc_oPg3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "OK"
2832:                         loc_oPg3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .F.
2833: 
2834:                         loc_lResultado = .T.
2835:                     ENDIF
2836:                 ENDIF
2837:             ENDIF

*-- Linhas 2901 a 2921:
2901:                     "CNT_4C__CUSTO2", ;
2902:                     "CNT_4C_TRATOCOR", ;
2903:                     "CNT_4C_BAIXAAUTO", ;
2904:                     "CNT_4C__INSERIR", ;
2905:                     "CNT_4C__CCUSTO1", ;
2906:                     "CNT_4C__PROCURAR")
2907:                     *-- Recursao nos filhos mas nao torna container visivel
2908:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2909:                         THIS.TornarControlesVisiveis(loc_oObjeto)
2910:                     ENDIF
2911:                     LOOP
2912:                 ENDIF
2913: 
2914:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2915:                     loc_oObjeto.Visible = .T.
2916:                 ENDIF
2917: 
2918:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2919:                     LOCAL loc_nP
2920:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2921:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))

*-- Linhas 3286 a 3406:
3286:         ENDIF
3287: 
3288:         IF USED("cursor_4c_Dados")
3289:             USE IN cursor_4c_Dados
3290:         ENDIF
3291:         IF USED("cursor_4c_Tratamento")
3292:             USE IN cursor_4c_Tratamento
3293:         ENDIF
3294:         IF USED("cursor_4c_TratamentoTemp")
3295:             USE IN cursor_4c_TratamentoTemp
3296:         ENDIF
3297:         IF USED("cursor_4c_Ocorr")
3298:             USE IN cursor_4c_Ocorr
3299:         ENDIF
3300:         IF USED("CrSigCdBal")
3301:             USE IN CrSigCdBal
3302:         ENDIF
3303:         IF USED("CsTratamento")
3304:             USE IN CsTratamento
3305:         ENDIF
3306: 
3307:         DODEFAULT()
3308:     ENDPROC
3309: 
3310:     *===========================================================================
3311:     * GrdBalancoAfterRowColChange - Exibe painel de controles com dados do item
3312:     *===========================================================================
3313:     PROCEDURE GrdBalancoAfterRowColChange(par_nColIndex)
3314:         LOCAL loc_oCnt
3315: 
3316:         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3317:             SELECT cursor_4c_Tratamento
3318: 
3319:             loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
3320:             WITH loc_oCnt
3321:                 .Visible             = .T.
3322:                 .txt_4c_DPro.Value   = TratarNulo(cursor_4c_Tratamento.Produto,  "C")
3323:                 .txt_4c_CCusto.Value = TratarNulo(cursor_4c_Tratamento.CCustos,  "C")
3324:                 .txt_4c_Dif.Value    = TratarNulo(cursor_4c_Tratamento.Faltas,   "N")
3325:                 .txt_4c_Usuars.Value = TratarNulo(cursor_4c_Tratamento.Usuars,   "C")
3326:                 .txt_4c_PesReal.Value = TratarNulo(cursor_4c_Tratamento.PesReals, "N")
3327:                 .edt_4c_ObsCnt1.Value = TratarNulo(cursor_4c_Tratamento.Obs, "C")
3328:                 .Refresh()
3329:             ENDWITH
3330: 
3331:             WITH THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3332:                 .Column8.ReadOnly       = .F.
3333:                 .Column8.Text1.ReadOnly = .F.
3334:                 .Refresh()
3335:             ENDWITH
3336:         ENDIF
3337:     ENDPROC
3338: 
3339:     *===========================================================================
3340:     * GrdColOcorWhen - Salva valor atual antes da edicao (Column8)
3341:     *===========================================================================
3342:     PROCEDURE GrdColOcorWhen()
3343:         IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3344:             THIS.this_cOldValue = ALLTRIM(TratarNulo(cursor_4c_Tratamento.Ocorrencia, "C"))
3345:         ENDIF
3346:     ENDPROC
3347: 
3348:     *===========================================================================
3349:     * GrdColOcorValid - Valida e abre lookup de Ocorrencia (Column8)
3350:     *===========================================================================
3351:     PROCEDURE GrdColOcorValid()
3352:         LOCAL loc_lResultado, loc_oGrid, loc_cOcor
3353:         loc_lResultado = .T.
3354: 
3355:         TRY
3356:             loc_oGrid = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3357:             loc_cOcor = ALLTRIM(loc_oGrid.Column8.Text1.Value)
3358: 
3359:             WITH THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
3360:                 .cmd_4c_BarraNovo.Visible = .F.
3361:             ENDWITH
3362: 
3363:             IF !EMPTY(loc_cOcor) AND loc_cOcor != THIS.this_cOldValue
3364:                 loc_lResultado = THIS.AbrirLookupOcorrencia("O", "<>", loc_cOcor, ;
3365:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1)
3366:             ENDIF
3367: 
3368:             *-- Atualizar usuario no painel
3369:             IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3370:                 THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.txt_4c_Usuars.Value = ;
3371:                     ALLTRIM(gc_4c_UsuarioLogado)
3372:             ENDIF
3373:         CATCH TO loException
3374:             MsgErro("Erro em GrdColOcorValid:" + CHR(13) + ;
3375:                 loException.Message + CHR(13) + ;
3376:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3377:                 "Formint.GrdColOcorValid")
3378:             loc_lResultado = .F.
3379:         ENDTRY
3380: 
3381:         RETURN loc_lResultado
3382:     ENDPROC
3383: 
3384:     *===========================================================================
3385:     * GrdColOcorLostFocus - Atualiza contadores apos saida do campo (Column8)
3386:     *===========================================================================
3387:     PROCEDURE GrdColOcorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3388:         LOCAL loc_cNovo, loc_oTotal, loc_nCOc, loc_nSOc
3389: 
3390:         TRY
3391:             IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3392:                 loc_cNovo  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.Value)
3393:                 loc_oTotal = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cnt_4c__Total
3394:                 loc_nCOc   = loc_oTotal.txt_4c_TotCOc.Value
3395:                 loc_nSOc   = loc_oTotal.txt_4c_TotSOc.Value
3396: 
3397:                 IF !EMPTY(THIS.this_cOldValue) AND EMPTY(loc_cNovo)
3398:                     loc_nCOc = loc_nCOc - 1
3399:                     loc_nSOc = loc_nSOc + 1
3400:                 ELSE
3401:                     IF EMPTY(THIS.this_cOldValue) AND !EMPTY(loc_cNovo)
3402:                         loc_nCOc = loc_nCOc + 1
3403:                         loc_nSOc = loc_nSOc - 1
3404:                     ENDIF
3405:                 ENDIF
3406: 

*-- Linhas 3443 a 3451:
3443:             loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir
3444:             WITH loc_oCnt
3445:                 .Visible = .T.
3446:                 .cmd_4c_CntInsere.Enabled = .F.
3447:                 .txt_4c_IBarra.Value = ""
3448:                 .txt_4c_ICCusto.Value = ""
3449:                 .txt_4c_IOcor.Value = ""
3450:                 .edt_4c_IBObs.Value = ""
3451:                 .Refresh()

*-- Linhas 3465 a 3488:
3465:         TRY
3466:             loc_oPg3 = THIS.pgf_4c_Paginas.Page3
3467:             WITH loc_oPg3
3468:                 .cnt_4c__CCusto1.Visible   = .F.
3469:                 .grd_4c_Dados.Visible      = .F.
3470:                 .cnt_4c__Procurar.Visible  = .T.
3471:                 .cnt_4c__Procurar.Refresh()
3472:                 .cnt_4c__Procurar.txt_4c_GetBusca.Value = ""
3473:                 .cnt_4c__Procurar.txt_4c_GetBusca.SetFocus()
3474:             ENDWITH
3475:         CATCH TO loException
3476:             MsgErro("Erro em BtnProcurarCntClick:" + CHR(13) + loException.Message, ;
3477:                 "Formint.BtnProcurarCntClick")
3478:         ENDTRY
3479:     ENDPROC
3480: 
3481:     *===========================================================================
3482:     * BtnBarraNovoCntClick - Exibe painel de novo barra
3483:     *===========================================================================
3484:     PROCEDURE BtnBarraNovoCntClick()
3485:         LOCAL loc_oCnt
3486:         TRY
3487:             loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2
3488:             WITH loc_oCnt

*-- Linhas 3535 a 3584:
3535:         loc_lValido    = .T.
3536: 
3537:         TRY
3538:             loc_cCaption = ALLTRIM(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption)
3539: 
3540:             IF loc_cCaption = "\<Grava" OR loc_cCaption = "Grava"
3541:                 *-- Validar: todo lancamento com Ocorrencia deve ter Obs
3542:                 IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3543:                     SELECT cursor_4c_Tratamento
3544:                     GO TOP
3545:                     SCAN
3546:                         IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) AND ;
3547:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs)) AND ;
3548:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs2s))
3549:                             MsgAviso("Existem lan" + CHR(231) + "amentos com Ocorr" + CHR(234) + ;
3550:                                 "ncia sem Observa" + CHR(231) + CHR(227) + "o !!!", ;
3551:                                 "Valida" + CHR(231) + CHR(227) + "o")
3552:                             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3553:                             loc_lValido = .F.
3554:                             EXIT
3555:                         ENDIF
3556:                     ENDSCAN
3557: 
3558:                     IF loc_lValido
3559:                         *-- Gravar cada linha na tabela SigIvTrT
3560:                         SELECT cursor_4c_Tratamento
3561:                         GO TOP
3562:                         SCAN
3563:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3564:                                 " Ocorrencia = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) + ;
3565:                                 ", Obs = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs)) + ;
3566:                                 ", Obs2s = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs2s)) + ;
3567:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3568:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3569:                                 " AND CIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.CIdChaves))
3570:                             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3571:                             IF loc_nResult < 0
3572:                                 MostrarErro("Erro ao gravar item:" + CHR(13) + ;
3573:                                     CapturarErroSQL(), "Formint.BtnSairCntClick")
3574:                                 loc_lValido = .F.
3575:                                 EXIT
3576:                             ENDIF
3577:                         ENDSCAN
3578:                     ENDIF
3579: 
3580:                     IF loc_lValido
3581:                     *-- Marcar inventario como tratado
3582:                     loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3583:                         " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3584:                         " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)

*-- Linhas 3655 a 3678:
3655:         LOCAL loc_oCnt2, loc_cObs2s
3656:         TRY
3657:             loc_oCnt2 = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2
3658:             loc_cObs2s = ALLTRIM(loc_oCnt2.edt_4c_BNObs.Value)
3659: 
3660:             IF !EMPTY(loc_cObs2s) AND USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3661:                 SELECT cursor_4c_Tratamento
3662:                 REPLACE cursor_4c_Tratamento.Obs2s WITH loc_cObs2s
3663:                 REPLACE cursor_4c_Tratamento.BarraNovos WITH ALLTRIM(loc_oCnt2.txt_4c_GetBarNovo.Value)
3664:             ENDIF
3665: 
3666:             loc_oCnt2.Visible = .F.
3667:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3668:             THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3669:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3670:             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3671:         CATCH TO loException
3672:             MsgErro("Erro em BtnBNSairClick:" + CHR(13) + loException.Message, ;
3673:                 "Formint.BtnBNSairClick")
3674:         ENDTRY
3675:     ENDPROC
3676: 
3677:     *===========================================================================
3678:     * GetTOcorCntTratValid - Lookup de Ocorrencia no painel TratOcor (Tipos='O')

*-- Linhas 3721 a 3771:
3721: 
3722:             IF EMPTY(loc_cOcor)
3723:                 MsgAviso("Informe a Ocorr" + CHR(234) + "ncia para o Tratamento.", ;
3724:                     "Campo Obrigat" + CHR(243) + "rio")
3725:             ELSE
3726:                 IF !USED("cursor_4c_Tratamento") OR RECCOUNT("cursor_4c_Tratamento") = 0
3727:                     MsgAviso("Nenhum item para tratar.", "Tratamento")
3728:                 ELSE
3729:                     SELECT cursor_4c_Tratamento
3730:                     GO TOP
3731:                     SCAN
3732:                         LOCAL loc_lAplicar
3733:                         loc_lAplicar = .F.
3734: 
3735:                         DO CASE
3736:                         CASE loc_nSemOcor = 1   && Lidos
3737:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "L")
3738:                         CASE loc_nSemOcor = 2   && Nao lidos
3739:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "N")
3740:                         CASE loc_nSemOcor = 3   && Saldos
3741:                             loc_lAplicar = (cursor_4c_Tratamento.Tipos = "S")
3742:                         OTHERWISE
3743:                             loc_lAplicar = .T.
3744:                         ENDCASE
3745: 
3746:                         IF loc_cTipos = "Entrada"
3747:                             loc_lAplicar = loc_lAplicar AND (cursor_4c_Tratamento.Faltas < 0)
3748:                         ELSE
3749:                             IF loc_cTipos = "Sa" + CHR(237) + "da"
3750:                                 loc_lAplicar = loc_lAplicar AND (cursor_4c_Tratamento.Faltas > 0)
3751:                             ENDIF
3752:                         ENDIF
3753: 
3754:                         IF loc_lAplicar
3755:                             REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3756:                             REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3757:                         ENDIF
3758:                     ENDSCAN
3759: 
3760:                     loc_oCnt.Visible = .F.
3761:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
3762:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
3763:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
3764:                     loc_lResultado = .T.
3765:                 ENDIF
3766:             ENDIF
3767:         CATCH TO loException
3768:             MsgErro("Erro em BtnTratOcorClick:" + CHR(13) + ;
3769:                 loException.Message + CHR(13) + ;
3770:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3771:                 "Formint.BtnTratOcorClick")

*-- Linhas 3844 a 3874:
3844:                     loc_cSQL = "SELECT TOP 1 Operacaos FROM SigBaOco" + ;
3845:                         " WHERE Tipos = 'O' AND Autos = 'S'" + ;
3846:                         " AND Codigos = " + EscaparSQL(loc_cOcor)
3847:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")
3848: 
3849:                     IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3850:                         SELECT cursor_4c_Tratamento
3851:                         GO TOP
3852:                         SCAN
3853:                             LOCAL loc_cCidChave, loc_cBarras
3854:                             loc_cCidChave = ALLTRIM(cursor_4c_Tratamento.CIdChaves)
3855:                             loc_cBarras   = ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras))
3856: 
3857:                             *-- Aplicar ocorrencia no cursor local
3858:                             REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3859:                             REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3860: 
3861:                             *-- Gravar na tabela SigIvTrT
3862:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3863:                                 " Ocorrencia = " + EscaparSQL(loc_cOcor) + ;
3864:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3865:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3866:                                 " AND CIdChaves = " + EscaparSQL(loc_cCidChave)
3867:                             SQLEXEC(gnConnHandle, loc_cSQL)
3868:                         ENDSCAN
3869: 
3870:                         *-- Marcar inventario como tratado
3871:                         loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3872:                             " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3873:                             " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
3874:                         SQLEXEC(gnConnHandle, loc_cSQL)

*-- Linhas 3935 a 3943:
3935:                     SELECT cursor_4c_Ocorr
3936:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.txt_4c_IBarra.Value = ;
3937:                         ALLTRIM(cursor_4c_Ocorr.CBars)
3938:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.cmd_4c_CntInsere.Enabled = .T.
3939:                 ELSE
3940:                     MsgAviso("C" + CHR(243) + "digo de Barra n" + CHR(227) + "o encontrado!", ;
3941:                         "Barra Inv" + CHR(225) + "lida")
3942:                     loc_lResultado = .F.
3943:                 ENDIF

*-- Linhas 4002 a 4033:
4002: 
4003:             IF EMPTY(loc_cBarra)
4004:                 MsgAviso("Informe o C" + CHR(243) + "digo de Barra.", "Campo Obrigat" + CHR(243) + "rio")
4005:             ELSE
4006:                 *-- Inserir no cursor local (ReadWrite permite APPEND BLANK)
4007:                 IF USED("cursor_4c_Tratamento")
4008:                     SELECT cursor_4c_Tratamento
4009:                     APPEND BLANK
4010:                     REPLACE cursor_4c_Tratamento.Emps       WITH ALLTRIM(go_4c_Sistema.cCodEmpresa)
4011:                     REPLACE cursor_4c_Tratamento.Codigos    WITH THIS.this_nCodigoSel
4012:                     REPLACE cursor_4c_Tratamento.Barras     WITH VAL(loc_cBarra)
4013:                     REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
4014:                     REPLACE cursor_4c_Tratamento.Obs        WITH loc_cObs
4015:                     REPLACE cursor_4c_Tratamento.Tipos      WITH "L"
4016:                     REPLACE cursor_4c_Tratamento.Apurado    WITH 1
4017:                     REPLACE cursor_4c_Tratamento.Estoque    WITH 0
4018:                     REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
4019: 
4020:                     THIS.this_nCItens = THIS.this_nCItens + 1
4021: 
4022:                     *-- Limpar campos para proximo item
4023:                     loc_oCnt.txt_4c_IBarra.Value = ""
4024:                     loc_oCnt.txt_4c_IOcor.Value  = ""
4025:                     loc_oCnt.edt_4c_IBObs.Value  = ""
4026:                     loc_oCnt.cmd_4c_CntInsere.Enabled = .F.
4027:                     loc_oCnt.txt_4c_IBarra.SetFocus()
4028: 
4029:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
4030:                     loc_lResultado = .T.
4031:                 ENDIF
4032:             ENDIF
4033:         CATCH TO loException

*-- Linhas 4055 a 4081:
4055:     PROCEDURE GetBuscaValid(par_nKeyCode, par_nShiftAltCtrl)
4056:         LOCAL loc_lResultado, loc_cBarra, loc_oPr
4057:         loc_lResultado = .T.
4058: 
4059:         TRY
4060:             loc_oPr    = THIS.pgf_4c_Paginas.Page3.cnt_4c__Procurar
4061:             loc_cBarra = ALLTRIM(loc_oPr.txt_4c_GetBusca.Value)
4062: 
4063:             IF !EMPTY(loc_cBarra) AND USED("cursor_4c_Tratamento")
4064:                 SELECT cursor_4c_Tratamento
4065:                 GO TOP
4066:                 LOCATE FOR ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras)) = loc_cBarra
4067:                 IF FOUND()
4068:                     *-- Mostrar grid e painel, ocultar procurar
4069:                     loc_oPr.Visible = .F.
4070:                     THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .T.
4071:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible    = .T.
4072:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
4073:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
4074:                 ELSE
4075:                     MsgAviso("Barra '" + loc_cBarra + "' n" + CHR(227) + "o encontrada.", ;
4076:                         "Busca")
4077:                 ENDIF
4078:             ENDIF
4079:         CATCH TO loException
4080:             MsgErro("Erro em GetBuscaValid:" + CHR(13) + loException.Message, ;
4081:                 "Formint.GetBuscaValid")

*-- Linhas 4224 a 4271:
4224:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
4225:                 loc_oCntBot = loc_oPg1.cnt_4c_Botoes
4226: 
4227:                 IF PEMSTATUS(loc_oCntBot, "cmd_4c_Incluir", 5)
4228:                     loc_oCntBot.cmd_4c_Incluir.Enabled = (loc_cModo = "LISTA")
4229:                 ENDIF
4230:                 IF PEMSTATUS(loc_oCntBot, "cmd_4c_Alterar", 5)
4231:                     loc_oCntBot.cmd_4c_Alterar.Enabled = ;
4232:                         (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
4233:                 ENDIF
4234:                 IF PEMSTATUS(loc_oCntBot, "cmd_4c_Visualizar", 5)
4235:                     loc_oCntBot.cmd_4c_Visualizar.Enabled = ;
4236:                         (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
4237:                 ENDIF
4238:                 IF PEMSTATUS(loc_oCntBot, "cmd_4c_Excluir", 5)
4239:                     loc_oCntBot.cmd_4c_Excluir.Enabled = ;
4240:                         (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
4241:                 ENDIF
4242:                 IF PEMSTATUS(loc_oCntBot, "cmd_4c_Buscar", 5)
4243:                     loc_oCntBot.cmd_4c_Buscar.Enabled = (loc_cModo = "LISTA")
4244:                 ENDIF
4245:             ENDIF
4246: 
4247:             *-- Container de saida sempre habilitado (permite fechar em qualquer modo)
4248:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Saida", 5)
4249:                 loc_oCntSaida = loc_oPg1.cnt_4c_Saida
4250:                 IF PEMSTATUS(loc_oCntSaida, "cmd_4c_Encerrar", 5)
4251:                     loc_oCntSaida.cmd_4c_Encerrar.Enabled = .T.
4252:                 ENDIF
4253:             ENDIF
4254: 
4255:             *-- Botoes operacionais especificos da Page1 (Balanco/BaixaAuto/Tratamento/Fechar)
4256:             IF PEMSTATUS(loc_oPg1, "cmd_4c_BtnBalanco", 5)
4257:                 loc_oPg1.cmd_4c_BtnBalanco.Enabled    = (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
4258:             ENDIF
4259:             IF PEMSTATUS(loc_oPg1, "cmd_4c_BtnBaixaAuto", 5)
4260:                 loc_oPg1.cmd_4c_BtnBaixaAuto.Enabled  = (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
4261:             ENDIF
4262:             IF PEMSTATUS(loc_oPg1, "cmd_4c_BtnTratamento", 5)
4263:                 loc_oPg1.cmd_4c_BtnTratamento.Enabled = (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
4264:             ENDIF
4265:             IF PEMSTATUS(loc_oPg1, "cmd_4c_BtnFechar", 5)
4266:                 loc_oPg1.cmd_4c_BtnFechar.Enabled     = (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
4267:             ENDIF
4268:         CATCH TO loException
4269:             *-- Silenciar apenas erros de acesso a propriedades (form pode estar em construcao);
4270:             *-- demais erros seguem para o log para nao mascarar defeitos.
4271:             IF !("Property" $ loException.Message)


### BO (C:\4c\projeto\app\classes\intBO.prg):
*==============================================================================
* intBO.prg - Business Object para Tratamento de Invent?rio (SIGCDBAL)
* Herda de: BusinessBase
* Tabela principal: SIGCDBAL
* PK: cidchaves (char 20)
*==============================================================================
DEFINE CLASS intBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SIGCDBAL
    *--------------------------------------------------------------------------
    this_cCIdChaves  = ""    && cidchaves char(20) - chave prim?ria
    this_nCodigos    = 0     && codigos numeric(4,0) - c?digo do invent?rio
    this_cEmps       = ""    && emps char(3) - empresa
    this_dDataInis   = {}    && datainis datetime - data inicial do invent?rio
    this_dDataFims   = {}    && datafims datetime - data final do invent?rio
    this_dDataTrans  = {}    && datatrans datetime - data da transa??o
    this_dDtBases    = {}    && dtbases datetime - data base
    this_cGrupos     = ""    && grupos char(10) - grupo principal
    this_cLocalis    = ""    && localis char(10) - local inicial
    this_cLocalfs    = ""    && localfs char(10) - local final
    this_cLocals     = ""    && locals char(10) - local
    this_cIforis     = ""    && iforis char(10) - fornecedor inicial
    this_cIforfs     = ""    && iforfs char(10) - fornecedor final
    this_cCgruis     = ""    && cgruis char(3) - c?digo grupo inicial
    this_cCgrufs     = ""    && cgrufs char(3) - c?digo grupo final
    this_cCggruis    = ""    && cggruis char(3) - c?digo grande grupo inicial
    this_cCggrufs    = ""    && cggrufs char(3) - c?digo grande grupo final
    this_nPrecois    = 0     && precois numeric(8,2) - pre?o inicial
    this_nPrecofs    = 0     && precofs numeric(8,2) - pre?o final
    this_cContas     = ""    && contas char(10) - conta
    this_cUsuars     = ""    && usuars char(10) - usu?rio
    this_cColecoesi  = ""    && colecoesi char(10) - cole??o inicial
    this_cColecoesf  = ""    && colecoesf char(10) - cole??o final
    this_cCprosi     = ""    && cprosi char(14) - produto inicial (barra)
    this_cCprosf     = ""    && cprosf char(14) - produto final (barra)
    this_cSgrusi     = ""    && sgrusi char(6) - sub-grupo inicial
    this_cSgrusf     = ""    && sgrusf char(6) - sub-grupo final
    this_cCfinpsi    = ""    && cfinpsi char(3) - fin press inicial
    this_cCfinpsf    = ""    && cfinpsf char(3) - fin press final
    this_nNTrans     = 0     && ntrans numeric(6,0) - n?mero da transa??o
    this_nAgrupas    = 0     && agrupas numeric(1,0) - agrupar
    this_nSepEstqs   = 0     && sepestqs numeric(1,0) - separar estoques
    this_nTrtPorPeso = 0     && trtporpeso numeric(1,0) - tratamento por peso
    this_nLeitGructa = 0     && leitgructa numeric(1,0) - leitura por grupo conta
    this_nFilBarras  = 0     && filbarras numeric(1,0) - filtrar por barras
    this_cMFilGGrp   = ""    && mfilggrp memo - filtro grande grupos
    this_cMFilGrupo  = ""    && mfilgrupo memo - filtro grupos
    this_cObs        = ""    && obs memo - observa??o

    *-- Campos calculados / controle
    this_lEncerras   = .F.   && encerras bit - invent?rio encerrado
    this_lTratas     = .F.   && tratas bit - invent?rio tratado

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDBAL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista inventarios da empresa atual
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmp
        loc_lSucesso = .F.
        loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                           " FROM SIGCDBAL" + ;
                           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
                           " ORDER BY codigos, cidchaves"
            ELSE
                loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                           " FROM SIGCDBAL" + ;
                           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
                           " AND codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
                           " ORDER BY codigos, cidchaves"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega inventario pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                       " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                       " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                       " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                       " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                       " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
                       " mfilggrp, mfilgrupo, obs" + ;
                       " FROM SIGCDBAL" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorNumero - Carrega inventario pelo codigos + empresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorNumero(par_nCodigos, par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                       " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                       " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                       " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                       " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                       " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
                       " mfilggrp, mfilgrupo, obs" + ;
                       " FROM SIGCDBAL" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
                       " AND emps = " + EscaparSQL(par_cEmps)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCIdChaves   = TratarNulo(cidchaves,    "C")
            THIS.this_nCodigos     = TratarNulo(codigos,      "N")
            THIS.this_cEmps        = TratarNulo(emps,         "C")
            THIS.this_cGrupos      = TratarNulo(grupos,       "C")
            THIS.this_cContas      = TratarNulo(contas,       "C")
            THIS.this_dDtBases     = TratarNulo(dtbases,      "D")
            THIS.this_dDataInis    = TratarNulo(datainis,     "D")
            THIS.this_dDataFims    = TratarNulo(datafims,     "D")
            THIS.this_dDataTrans   = TratarNulo(datatrans,    "D")
            THIS.this_lEncerras    = (TratarNulo(encerras,    "N") = 1)
            THIS.this_lTratas      = (TratarNulo(tratas,      "N") = 1)
            THIS.this_nAgrupas     = TratarNulo(agrupas,      "N")
            THIS.this_nSepEstqs    = TratarNulo(sepestqs,     "N")
            THIS.this_nTrtPorPeso  = TratarNulo(trtporpeso,   "N")
            THIS.this_nLeitGructa  = TratarNulo(leitgructa,   "N")
            THIS.this_nFilBarras   = TratarNulo(filbarras,    "N")
            THIS.this_cLocalis     = TratarNulo(localis,      "C")
            THIS.this_cLocalfs     = TratarNulo(localfs,      "C")
            THIS.this_cLocals      = TratarNulo(locals,       "C")
            THIS.this_cIforis      = TratarNulo(iforis,       "C")
            THIS.this_cIforfs      = TratarNulo(iforfs,       "C")
            THIS.this_cCgruis      = TratarNulo(cgruis,       "C")
            THIS.this_cCgrufs      = TratarNulo(cgrufs,       "C")
            THIS.this_cCggruis     = TratarNulo(cggruis,      "C")
            THIS.this_cCggrufs     = TratarNulo(cggrufs,      "C")
            THIS.this_cColecoesi   = TratarNulo(colecoesi,    "C")
            THIS.this_cColecoesf   = TratarNulo(colecoesf,    "C")
            THIS.this_cCprosi      = TratarNulo(cprosi,       "C")
            THIS.this_cCprosf      = TratarNulo(cprosf,       "C")
            THIS.this_cSgrusi      = TratarNulo(sgrusi,       "C")
            THIS.this_cSgrusf      = TratarNulo(sgrusf,       "C")
            THIS.this_cCfinpsi     = TratarNulo(cfinpsi,      "C")
            THIS.this_cCfinpsf     = TratarNulo(cfinpsf,      "C")
            THIS.this_nPrecois     = TratarNulo(precois,      "N")
            THIS.this_nPrecofs     = TratarNulo(precofs,      "N")
            THIS.this_nNTrans      = TratarNulo(ntrans,       "N")
            THIS.this_cUsuars      = TratarNulo(usuars,       "C")
            *-- Campos TEXT/memo (podem nao estar no cursor de listagem)
            IF !EMPTY(FIELD("mfilggrp", par_cAliasCursor))
                THIS.this_cMFilGGrp  = TratarNulo(mfilggrp,  "C")
                THIS.this_cMFilGrupo = TratarNulo(mfilgrupo, "C")
                THIS.this_cObs       = TratarNulo(obs,       "C")
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoCodigo - Obtem proximo codigo disponivel para a empresa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarProximoCodigo(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_nCodigo
        loc_nCodigo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox_cod" + ;
                       " FROM SIGCDBAL WHERE emps = " + EscaparSQL(par_cEmps)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nCodigo = cursor_4c_ProxCod.prox_cod
            ENDIF

            IF USED("cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF
        ENDTRY

        RETURN loc_nCodigo
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SIGCDBAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigo, loc_cEmp
        loc_lSucesso = .F.
        loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        TRY
            *-- Gerar chave UUID e proximo codigo sequencial
            THIS.this_cCIdChaves = ""
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCIdChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCIdChaves)
                MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_nCodigo = THIS.GerarProximoCodigo(loc_cEmp)
                IF loc_nCodigo = 0
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo do invent" + CHR(225) + "rio.", "Erro")
                    loc_lSucesso = .F.
                ELSE
                    THIS.this_nCodigos = loc_nCodigo
                    THIS.this_cEmps    = loc_cEmp
                    THIS.this_cUsuars  = ALLTRIM(gc_4c_UsuarioLogado)

                    loc_cSQL = "INSERT INTO SIGCDBAL (" + ;
                               " cidchaves, codigos, emps, grupos, contas, dtbases," + ;
                               " datainis, datafims, encerras, tratas, agrupas, sepestqs," + ;
                               " trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                               " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                               " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                               " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                               ") VALUES (" + ;
                               EscaparSQL(THIS.this_cCIdChaves) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                               EscaparSQL(THIS.this_cEmps) + "," + ;
                               EscaparSQL(THIS.this_cGrupos) + "," + ;
                               EscaparSQL(THIS.this_cContas) + "," + ;
                               FormatarDataSQL(THIS.this_dDtBases) + "," + ;
                               FormatarDataSQL(THIS.this_dDataInis) + "," + ;
                               FormatarDataSQL(THIS.this_dDataFims) + "," + ;
                               IIF(THIS.this_lEncerras, "1", "0") + "," + ;
                               IIF(THIS.this_lTratas, "1", "0") + "," + ;
                               FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
                               FormatarNumeroSQL(THIS.this_nSepEstqs) + "," + ;
                               FormatarNumeroSQL(THIS.this_nTrtPorPeso) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLeitGructa) + "," + ;
                               FormatarNumeroSQL(THIS.this_nFilBarras) + "," + ;
                               EscaparSQL(THIS.this_cLocalis) + "," + ;
                               EscaparSQL(THIS.this_cLocalfs) + "," + ;
                               EscaparSQL(THIS.this_cIforis) + "," + ;
                               EscaparSQL(THIS.this_cIforfs) + "," + ;
                               EscaparSQL(THIS.this_cCgruis) + "," + ;
                               EscaparSQL(THIS.this_cCgrufs) + "," + ;
                               EscaparSQL(THIS.this_cCggruis) + "," + ;
                               EscaparSQL(THIS.this_cCggrufs) + "," + ;
                               EscaparSQL(THIS.this_cColecoesi) + "," + ;
                               EscaparSQL(THIS.this_cColecoesf) + "," + ;
                               EscaparSQL(THIS.this_cCprosi) + "," + ;
                               EscaparSQL(THIS.this_cCprosf) + "," + ;
                               EscaparSQL(THIS.this_cSgrusi) + "," + ;
                               EscaparSQL(THIS.this_cSgrusf) + "," + ;
                               EscaparSQL(THIS.this_cCfinpsi) + "," + ;
                               EscaparSQL(THIS.this_cCfinpsf) + "," + ;
                               FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
                               FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
                               FormatarNumeroSQL(THIS.this_nNTrans) + "," + ;
                               EscaparSQL(THIS.this_cLocals) + "," + ;
                               EscaparSQL(THIS.this_cUsuars) + ;
                               ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SIGCDBAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " dtbases = " + FormatarDataSQL(THIS.this_dDtBases) + "," + ;
                       " datainis = " + FormatarDataSQL(THIS.this_dDataInis) + "," + ;
                       " datafims = " + FormatarDataSQL(THIS.this_dDataFims) + "," + ;
                       " encerras = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
                       " tratas = " + IIF(THIS.this_lTratas, "1", "0") + "," + ;
                       " agrupas = " + FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
                       " sepestqs = " + FormatarNumeroSQL(THIS.this_nSepEstqs) + "," + ;
                       " trtporpeso = " + FormatarNumeroSQL(THIS.this_nTrtPorPeso) + "," + ;
                       " leitgructa = " + FormatarNumeroSQL(THIS.this_nLeitGructa) + "," + ;
                       " filbarras = " + FormatarNumeroSQL(THIS.this_nFilBarras) + "," + ;
                       " localis = " + EscaparSQL(THIS.this_cLocalis) + "," + ;
                       " localfs = " + EscaparSQL(THIS.this_cLocalfs) + "," + ;
                       " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " iforis = " + EscaparSQL(THIS.this_cIforis) + "," + ;
                       " iforfs = " + EscaparSQL(THIS.this_cIforfs) + "," + ;
                       " cgruis = " + EscaparSQL(THIS.this_cCgruis) + "," + ;
                       " cgrufs = " + EscaparSQL(THIS.this_cCgrufs) + "," + ;
                       " cggruis = " + EscaparSQL(THIS.this_cCggruis) + "," + ;
                       " cggrufs = " + EscaparSQL(THIS.this_cCggrufs) + "," + ;
                       " colecoesi = " + EscaparSQL(THIS.this_cColecoesi) + "," + ;
                       " colecoesf = " + EscaparSQL(THIS.this_cColecoesf) + "," + ;
                       " cprosi = " + EscaparSQL(THIS.this_cCprosi) + "," + ;
                       " cprosf = " + EscaparSQL(THIS.this_cCprosf) + "," + ;
                       " sgrusi = " + EscaparSQL(THIS.this_cSgrusi) + "," + ;
                       " sgrusf = " + EscaparSQL(THIS.this_cSgrusf) + "," + ;
                       " cfinpsi = " + EscaparSQL(THIS.this_cCfinpsi) + "," + ;
                       " cfinpsf = " + EscaparSQL(THIS.this_cCfinpsf) + "," + ;
                       " precois = " + FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
                       " precofs = " + FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
                       " usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE do inventario e registros filhos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigos, loc_cEmps
        loc_lSucesso = .F.
        loc_nCodigos = THIS.this_nCodigos
        loc_cEmps    = ALLTRIM(THIS.this_cEmps)

        TRY
            *-- Remover registros filhos: SigIvTrB (itens do balanco)
            loc_cSQL = "DELETE FROM SigIvTrB" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover registros filhos: SigIvTrH (historico de leitura)
            loc_cSQL = "DELETE FROM SigIvTrH" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover registros filhos: SigIvTrE (etiquetas)
            loc_cSQL = "DELETE FROM SigIvTrE" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover o inventario principal
            loc_cSQL = "DELETE FROM SIGCDBAL" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEncerramento - Marca/desmarca inventario como encerrado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEncerramento(par_lEncerrar, par_dDatafim)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " encerras = " + IIF(par_lEncerrar, "1", "0") + "," + ;
                       " datafims = " + FormatarDataSQL(par_dDatafim) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.this_lEncerras = par_lEncerrar
                THIS.this_dDataFims = par_dDatafim
                THIS.RegistrarAuditoria("ENCERRAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTratamento - Marca inventario como tratado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTratamento(par_lTratar)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " tratas = " + IIF(par_lTratar, "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.this_lTratas = par_lTratar
                THIS.RegistrarAuditoria("TRATAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao marcar tratamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao marcar tratamento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Obtem cotacao de cambio para uma moeda
    * Substitui fCarregarCambio() do legado (nao portada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCambio(par_nValor, par_cMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_nCotacao, loc_nValorConv
        loc_nCotacao  = 1
        loc_nValorConv = par_nValor

        TRY
            IF !EMPTY(ALLTRIM(par_cMoeda)) AND ALLTRIM(par_cMoeda) <> "RS" AND ALLTRIM(par_cMoeda) <> "BRL"
                loc_cSQL = "SELECT TOP 1 a.Valos" + ;
                           " FROM SigCdCot a" + ;
                           " WHERE a.CMoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                           " ORDER BY a.Datas DESC"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cambio")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cambio") > 0
                    SELECT cursor_4c_Cambio
                    loc_nCotacao = TratarNulo(Valos, "N")
                    IF loc_nCotacao > 0
                        loc_nValorConv = par_nValor * loc_nCotacao
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Cambio")
                    USE IN cursor_4c_Cambio
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar c" + CHR(226) + "mbio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Cambio")
                USE IN cursor_4c_Cambio
            ENDIF
        ENDTRY

        RETURN loc_nValorConv
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Verifica se grupo de estoque eh valido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lValido
        loc_lValido = .F.

        TRY
            IF !EMPTY(ALLTRIM(par_cGrupos))
                loc_cSQL = "SELECT TOP 1 Codigos FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cGrupos))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGru")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValGru") > 0
                    loc_lValido = .T.
                ENDIF

                IF USED("cursor_4c_ValGru")
                    USE IN cursor_4c_ValGru
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValGru")
                USE IN cursor_4c_ValGru
            ENDIF
        ENDTRY

        RETURN loc_lValido
    ENDPROC

ENDDEFINE

