# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (62)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_BOTOES. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [CARGA-DADOS] OptionGroup 'opt_4c_Pagos' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Opcao' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_CotEm' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Cancs' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Concs' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Prorrogs' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_FilGrd2' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCMoes' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCMoesValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDMoes' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDMoesValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCMoesC' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCMoesCValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDMoesC' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDMoesCValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarMoeSaldo' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarMoeSaldoValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCFPublis' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCFPublisValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDFPublis' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDFPublisValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarEspecieNfsFiltro' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarEspecieNfsFiltroValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarTitBansFiltro' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarTitBansFiltroValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterTokenSerializado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterRazaoSocial()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.DataFimDiaSQL()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_RelFinCab' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [NAVEGACAO-PAGINA] Metodo 'BtnCancelarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGOPCGF.pgfPrincipal.pgFiltros): Top original=158 vs migrado 'lbl_4c_Say17' Top=262 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGOPCGF.pgfPrincipal.pgFiltros): Left original=122 vs migrado 'lbl_4c_Say17' Left=451 (diff=329px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGOPCGF.pgfPrincipal.pgFiltros): Left original=119 vs migrado 'lbl_4c_Say20' Left=440 (diff=321px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'getFiltros' (parent: SIGOPCGF.pgfPrincipal.pgFiltros): Left original=190 vs migrado 'obj_4c_GetFiltros' Left=510 (diff=320px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'apaga' (parent: SIGOPCGF.pgfPrincipal.pgFiltros): Top original=335 vs migrado 'cmd_4c_ApagaG2' Top=648 (diff=313px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say25' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=594 vs migrado 'lbl_4c_Say25' Top=210 (diff=384px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say25' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=212 vs migrado 'lbl_4c_Say25' Left=456 (diff=244px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=646 vs migrado 'lbl_4c_Say9' Top=369 (diff=277px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=540 vs migrado 'lbl_4c_Say9' Left=124 (diff=416px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=648 vs migrado 'lbl_4c_Say8' Top=349 (diff=299px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=362 vs migrado 'lbl_4c_Say8' Left=109 (diff=253px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=619 vs migrado 'lbl_4c_Say7' Top=287 (diff=332px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=540 vs migrado 'lbl_4c_Say7' Left=108 (diff=432px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=621 vs migrado 'lbl_4c_Say6' Top=262 (diff=359px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=366 vs migrado 'lbl_4c_Say6' Left=90 (diff=276px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=592 vs migrado 'lbl_4c_Say5' Top=329 (diff=263px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=540 vs migrado 'lbl_4c_Say5' Left=146 (diff=394px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=594 vs migrado 'lbl_4c_Say3' Top=308 (diff=286px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=403 vs migrado 'lbl_4c_Say3' Left=123 (diff=280px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=566 vs migrado 'lbl_4c_Say20' Top=158 (diff=408px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=540 vs migrado 'lbl_4c_Say20' Left=440 (diff=100px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=568 vs migrado 'lbl_4c_Say17' Top=262 (diff=306px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=403 vs migrado 'lbl_4c_Say17' Left=451 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say20' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=594 vs migrado 'lbl_4c_Say20' Top=158 (diff=436px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say20' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=23 vs migrado 'lbl_4c_Say20' Left=440 (diff=417px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=621 vs migrado 'lbl_4c_Say13' Top=210 (diff=411px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=207 vs migrado 'lbl_4c_Say13' Left=145 (diff=62px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=643 vs migrado 'cnt_4c_Botoes' Top=1 (diff=642px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=199 vs migrado 'cnt_4c_Botoes' Left=1 (diff=198px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say11' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=152 vs migrado 'lbl_4c_Say11' Top=236 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say11' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=511 vs migrado 'lbl_4c_Say11' Left=436 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=648 vs migrado 'lbl_4c_Say10' Top=388 (diff=260px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=19 vs migrado 'lbl_4c_Say10' Left=118 (diff=99px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=568 vs migrado 'lbl_4c_Say4' Top=133 (diff=435px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=34 vs migrado 'lbl_4c_Say4' Left=466 (diff=432px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGOPCGF.pgfPrincipal.pgDados): Top original=621 vs migrado 'lbl_4c_Say12' Top=184 (diff=437px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGOPCGF.pgfPrincipal.pgDados): Left original=17 vs migrado 'lbl_4c_Say12' Left=434 (diff=417px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCGF.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5835 linhas total):

*-- Linhas 57 a 296:
57: 
58:     *--------------------------------------------------------------------------
59:     * Guarda de reentrancia dos lookups de Page1 (regra #37/#47 do CLAUDE.md) -
60:     * o picker (FormBuscaAuxiliar) eh MODAL e tira o foco do campo, o que
61:     * redispara o proprio LostFocus; a flag eh ligada dentro de cada
62:     * AbrirLookup*, que eh o funil de todas as entradas daquele campo.
63:     *--------------------------------------------------------------------------
64:     this_lEmLookup = .F.
65: 
66:     *--------------------------------------------------------------------------
67:     * Init - Chama FormBase.Init() que dispara InicializarForm()
68:     *--------------------------------------------------------------------------
69:     PROCEDURE Init()
70:         RETURN DODEFAULT()
71:     ENDPROC
72: 
73:     *--------------------------------------------------------------------------
74:     * InicializarForm - Cria o Business Object e monta a estrutura base
75:     * (PageFrame com as 2 paginas). Grid, filtros, botoes e eventos sao
76:     * adicionados nas fases seguintes.
77:     *--------------------------------------------------------------------------
78:     PROTECTED PROCEDURE InicializarForm()
79:         LOCAL loc_lSucesso, loc_oErro
80:         loc_lSucesso = .F.
81: 
82:         TRY
83:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCGFBO")
84: 
85:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
86:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SIGOPCGFBO", "Erro")
87:             ELSE
88:                 THIS.ConfigurarPageFrame()
89:                 THIS.CriarCursoresFiltros()
90:                 THIS.ConfigurarPaginaFiltros()
91:                 THIS.ConfigurarPaginaDados()
92: 
93:                 THIS.pgf_4c_Paginas.Visible    = .T.
94:                 THIS.pgf_4c_Paginas.ActivePage = 1
95:                 THIS.this_cModoAtual           = "FILTROS"
96: 
97:                 THIS.TornarControlesVisiveis(THIS)
98: 
99:                 *-- Aplica o contrato de digitacao dos PROCEDURE When do
100:                 *-- legado (filtros digitaveis na Page1; campos de detalhe da
101:                 *-- Page2 somente exibicao) - ver HabilitarCampos().
102:                 THIS.HabilitarCampos(.T.)
103: 
104:                 *-- SQL de carga (tipos de operacao + filtros nomeados salvos)
105:                 *-- fica fora do modo de validacao de UI/teste automatizado,
106:                 *-- igual ao padrao CarregarLista() dos forms CRUD.
107:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
108:                    (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
109:                     THIS.CarregarTiposOperacao()
110:                     THIS.CarregarFiltrosSalvos()
111:                 ENDIF
112: 
113:                 loc_lSucesso = .T.
114:             ENDIF
115:         CATCH TO loc_oErro
116:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
117:                     " PROC=" + loc_oErro.Procedure, "Erro")
118:         ENDTRY
119: 
120:         RETURN loc_lSucesso
121:     ENDPROC
122: 
123:     *--------------------------------------------------------------------------
124:     * ConfigurarPageFrame - Cria o PageFrame com as 2 paginas (Filtros/Dados).
125:     * Abas OCULTAS (Tabs = .F., como no legado) - a navegacao entre paginas eh
126:     * feita pelos CommandGroups cmgFiltros/cmgRetornar, criados na Fase 4.
127:     *--------------------------------------------------------------------------
128:     PROTECTED PROCEDURE ConfigurarPageFrame()
129:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
130: 
131:         WITH THIS.pgf_4c_Paginas
132:             .Top       = 0
133:             .Left      = 0
134:             .Width     = THIS.Width
135:             .Height    = THIS.Height
136:             .PageCount = 2
137:             .Tabs      = .F.
138:             .Visible   = .F.
139: 
140:             .Page1.Caption   = "Filtros"
141:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
142:             .Page1.FontName  = "Verdana"
143:             .Page1.FontSize  = 8
144:             .Page1.FontBold  = .T.
145:             .Page1.BackColor = RGB(255, 255, 255)
146:             .Page1.ForeColor = RGB(36, 84, 155)
147: 
148:             .Page2.Caption   = "Dados"
149:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
150:             .Page2.FontName  = "Verdana"
151:             .Page2.FontSize  = 8
152:             .Page2.FontBold  = .T.
153:             .Page2.BackColor = RGB(255, 255, 255)
154:             .Page2.ForeColor = RGB(36, 84, 155)
155:         ENDWITH
156:     ENDPROC
157: 
158:     *--------------------------------------------------------------------------
159:     * TornarControlesVisiveis - Torna visiveis, recursivamente, todos os
160:     * controles filhos (Pages de PageFrame + Controls de Container). AddObject
161:     * cria os controles com Visible=.F. por padrao.
162:     *--------------------------------------------------------------------------
163:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
164:         LOCAL loc_nI, loc_nP, loc_oControl
165: 
166:         FOR loc_nI = 1 TO par_oContainer.ControlCount
167:             loc_oControl = par_oContainer.Controls(loc_nI)
168: 
169:             IF VARTYPE(loc_oControl) = "O"
170:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
171:                     loc_oControl.Visible = .T.
172:                 ENDIF
173: 
174:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
175:                     FOR loc_nP = 1 TO loc_oControl.PageCount
176:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
177:                     ENDFOR
178:                 ENDIF
179: 
180:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
181:                     THIS.TornarControlesVisiveis(loc_oControl)
182:                 ENDIF
183:             ENDIF
184:         ENDFOR
185:     ENDPROC
186: 
187:     *==========================================================================
188:     * FASE 4 - Page1 (pgFiltros): cursores de trabalho, grid completo
189:     * (grdTipo + Grd_Clientes + Grd_Clientes2) e botoes CRUD de linha/filtro.
190:     * Nomes e geometria transcritos de tasks\task691\SIGOPCGF_form_codigo_
191:     * fonte.txt (SECAO 2: PROPRIEDADES CUSTOMIZADAS). AlternarPagina() navega
192:     * entre Filtros/Dados; a consulta financeira completa (LocalDados) e o
193:     * grid/botoes da Page2 ficam para a fase seguinte.
194:     *==========================================================================
195: 
196:     *--------------------------------------------------------------------------
197:     * CriarCursoresFiltros - Cria os cursores placeholder da Page1 ANTES do
198:     * ConfigurarPaginaFiltros() poder bindar os Grids (regra #41 - Column.
199:     * ControlSource exige que o cursor ja exista). Estrutura IDENTICA a que
200:     * CarregarTiposOperacao()/CarregarFiltrosSalvos() (SQLEXEC + SELECT INTO
201:     * CURSOR) recriam depois ("cursor placeholder = cursor real").
202:     *--------------------------------------------------------------------------
203:     PROTECTED PROCEDURE CriarCursoresFiltros()
204:         LOCAL loc_cTipos, loc_cClientes, loc_cClientes2, loc_cFiltros
205: 
206:         loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
207:         loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
208:         loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2
209:         loc_cFiltros   = THIS.this_oBusinessObject.this_cCursorFiltros
210: 
211:         IF !USED(loc_cTipos)
212:             CREATE CURSOR (loc_cTipos) (Imps N(1,0), Dopes C(20), Opers C(2), RealPrevs N(1,0))
213:             INDEX ON Dopes TAG Dopes
214:         ENDIF
215: 
216:         IF !USED(loc_cClientes)
217:             CREATE CURSOR (loc_cClientes) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
218:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
219:             SELECT (loc_cClientes)
220:             APPEND BLANK
221:         ENDIF
222: 
223:         IF !USED(loc_cClientes2)
224:             CREATE CURSOR (loc_cClientes2) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
225:                 CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
226:             SELECT (loc_cClientes2)
227:             APPEND BLANK
228:         ENDIF
229: 
230:         IF !USED(loc_cFiltros)
231:             CREATE CURSOR (loc_cFiltros) (Cidparams C(64), Ctpparams C(1), Mxmls M, Descrs C(40))
232:         ENDIF
233:     ENDPROC
234: 
235:     *--------------------------------------------------------------------------
236:     * ConfigurarPaginaFiltros - Monta todo o conteudo da Page1 (cabecalho,
237:     * campos de filtro, OptionGroups, grades e botoes).
238:     *--------------------------------------------------------------------------
239:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
240:         LOCAL loc_oPag
241:         loc_oPag = THIS.pgf_4c_Paginas.Page1
242: 
243:         THIS.ConfigurarCabecalhoFiltros(loc_oPag)
244:         THIS.ConfigurarCamposFiltros(loc_oPag)
245:         THIS.ConfigurarOptionGroupsFiltros(loc_oPag)
246:         THIS.ConfigurarGradesFiltros(loc_oPag)
247:         THIS.ConfigurarBotoesFiltros(loc_oPag)
248:     ENDPROC
249: 
250:     *--------------------------------------------------------------------------
251:     * ConfigurarCabecalhoFiltros - Faixa de titulo (cntSombra) + CommandGroup
252:     * de navegacao (cmgFiltros: Consultar/Sair). SCX: Top=-3,Left=835,W=173,
253:     * H=110, Buttons 75x75 (Comic Sans MS), icones cadastro_procurar_60.jpg /
254:     * cadastro_sair_60.jpg.
255:     *--------------------------------------------------------------------------
256:     PROTECTED PROCEDURE ConfigurarCabecalhoFiltros(par_oPag)
257:         par_oPag.AddObject("cnt_4c_Sombra", "Container")
258:         WITH par_oPag.cnt_4c_Sombra
259:             .Top         = 0
260:             .Left        = 0
261:             .Width       = THIS.Width
262:             .Height      = 80
263:             .BackColor   = RGB(100, 100, 100)
264:             .BorderWidth = 0
265: 
266:             .AddObject("lbl_4c_Sombra", "Label")
267:             WITH .lbl_4c_Sombra
268:                 .Top       = 25
269:                 .Left      = 10
270:                 .Width     = THIS.Width
271:                 .Height    = 40
272:                 .AutoSize  = .F.
273:                 .BackStyle = 0
274:                 .WordWrap  = .T.
275:                 .FontName  = "Tahoma"
276:                 .FontSize  = 18
277:                 .FontBold  = .T.
278:                 .ForeColor = RGB(0, 0, 0)
279:                 .Caption   = THIS.Caption
280:                 .Visible   = .T.
281:             ENDWITH
282: 
283:             .AddObject("lbl_4c_TituloCabecalho", "Label")
284:             WITH .lbl_4c_TituloCabecalho
285:                 .Top       = 24
286:                 .Left      = 10
287:                 .Width     = THIS.Width
288:                 .Height    = 46
289:                 .AutoSize  = .F.
290:                 .BackStyle = 0
291:                 .WordWrap  = .T.
292:                 .FontName  = "Tahoma"
293:                 .FontSize  = 18
294:                 .FontBold  = .T.
295:                 .ForeColor = RGB(255, 255, 255)
296:                 .Caption   = THIS.Caption

*-- Linhas 351 a 403:
351:             .Visible = .T.
352:         ENDWITH
353: 
354:         BINDEVENT(par_oPag.cmg_4c_Filtros, "Click", THIS, "CmgFiltrosClick")
355:     ENDPROC
356: 
357:     *--------------------------------------------------------------------------
358:     * ConfigurarCamposFiltros - Labels + TextBoxes/CheckBoxes de filtro (datas,
359:     * titulo, titulo banco, especie NF, NF, moedas, saldo, publicidade,
360:     * empresa, filtro nomeado). Geometria e Format/InputMask transcritos do
361:     * dump do SCX legado.
362:     *--------------------------------------------------------------------------
363:     PROTECTED PROCEDURE ConfigurarCamposFiltros(par_oPag)
364:         LOCAL loc_cAte
365:         loc_cAte = "at" + CHR(233)
366: 
367:         *-- Emissao
368:         par_oPag.AddObject("lbl_4c_SayPed", "Label")
369:         WITH par_oPag.lbl_4c_SayPed
370:             .Top = 132
371:             .Left = 139
372:             .Width = 47
373:             .FontName = "Tahoma"
374:             .FontSize = 8
375:             .ForeColor = RGB(90, 90, 90)
376:             .Caption = "Emiss" + CHR(227) + "o :"
377:             .Visible = .T.
378:         ENDWITH
379: 
380:         par_oPag.AddObject("txt_4c_DtEmiI", "TextBox")
381:         WITH par_oPag.txt_4c_DtEmiI
382:             .Top = 128
383:             .Left = 190
384:             .Width = 80
385:             .Height = 23
386:             .Alignment = 3
387:             .Value = {}
388:             .FontName = "Tahoma"
389:             .SpecialEffect = 1
390:             .Visible = .T.
391:         ENDWITH
392: 
393:         par_oPag.AddObject("lbl_4c_Label2", "Label")
394:         WITH par_oPag.lbl_4c_Label2
395:             .Top = 132
396:             .Left = 275
397:             .Width = 18
398:             .FontName = "Tahoma"
399:             .FontSize = 8
400:             .BackStyle = 0
401:             .ForeColor = RGB(90, 90, 90)
402:             .Caption = loc_cAte
403:             .Visible = .T.

*-- Linhas 877 a 920:
877:             .Visible = .T.
878:         ENDWITH
879: 
880:         *-- chkValpags "Valor em aberto" (checkbox ao lado das OptionGroups)
881:         par_oPag.AddObject("chk_4c_ValPends", "CheckBox")
882:         WITH par_oPag.chk_4c_ValPends
883:             .Top = 309
884:             .Left = 409
885:             .Width = 82
886:             .Height = 13
887:             .FontSize = 7
888:             .Alignment = 0
889:             .Caption = "Valor Pendente"
890:             .Value = 0
891:             .SpecialEffect = 1
892:             .Visible = .T.
893:         ENDWITH
894: 
895:         *-- Filtros nomeados (Say14 + getFiltros visivel / getNewFiltro oculto)
896:         par_oPag.AddObject("lbl_4c_Say14", "Label")
897:         WITH par_oPag.lbl_4c_Say14
898:             .Top = 103
899:             .Left = 148
900:             .Width = 38
901:             .FontName = "Tahoma"
902:             .ForeColor = RGB(90, 90, 90)
903:             .Caption = "Filtros :"
904:             .Visible = .T.
905:         ENDWITH
906: 
907:         par_oPag.AddObject("txt_4c_Filtros", "TextBox")
908:         WITH par_oPag.txt_4c_Filtros
909:             .Top = 99
910:             .Left = 190
911:             .Width = 312
912:             .Height = 23
913:             .Value = ""
914:             .Format = "K!"
915:             .BackStyle = 1
916:             .FontName = "Tahoma"
917:             .SpecialEffect = 1
918:             .Visible = .T.
919:         ENDWITH
920: 

*-- Linhas 932 a 1035:
932:             .Visible = .F.
933:         ENDWITH
934: 
935:         BINDEVENT(par_oPag.txt_4c_Filtros, "LostFocus", THIS, "GetFiltrosLostFocus")
936: 
937:         *-- Lookups (regra #47 - LostFocus, nao KeyPress, para nao abrir o
938:         *-- picker a cada tecla). Implementados em AbrirLookup* mais abaixo.
939:         BINDEVENT(par_oPag.txt_4c_CMoes,      "LostFocus", THIS, "ValidarCMoes")
940:         BINDEVENT(par_oPag.txt_4c_DMoes,      "LostFocus", THIS, "ValidarDMoes")
941:         BINDEVENT(par_oPag.txt_4c_CMoesC,     "LostFocus", THIS, "ValidarCMoesC")
942:         BINDEVENT(par_oPag.txt_4c_DMoesC,     "LostFocus", THIS, "ValidarDMoesC")
943:         BINDEVENT(par_oPag.txt_4c_MoeSaldo,   "LostFocus", THIS, "ValidarMoeSaldo")
944:         BINDEVENT(par_oPag.txt_4c_CFPublis,   "LostFocus", THIS, "ValidarCFPublis")
945:         BINDEVENT(par_oPag.txt_4c_DFPublis,   "LostFocus", THIS, "ValidarDFPublis")
946:         BINDEVENT(par_oPag.txt_4c_EspecieNfs, "LostFocus", THIS, "ValidarEspecieNfsFiltro")
947:         BINDEVENT(par_oPag.txt_4c_TitBans,    "LostFocus", THIS, "ValidarTitBansFiltro")
948: 
949:         *-- Textos fixos sobre as duas grades de clientes
950:         par_oPag.AddObject("lbl_4c_Say15", "Label")
951:         WITH par_oPag.lbl_4c_Say15
952:             .Top = 410
953:             .Left = 81
954:             .Width = 351
955:             .FontBold = .T.
956:             .FontSize = 8
957:             .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es abaixo:"
958:             .Visible = .T.
959:         ENDWITH
960: 
961:         par_oPag.AddObject("lbl_4c_Say16", "Label")
962:         WITH par_oPag.lbl_4c_Say16
963:             .Top = 559
964:             .Left = 81
965:             .Width = 574
966:             .FontBold = .T.
967:             .FontSize = 8
968:             .ForeColor = RGB(255, 255, 255)
969:             .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es da grade acima e da grade abaixo contenham :"
970:             .Visible = .T.
971:         ENDWITH
972:     ENDPROC
973: 
974:     *--------------------------------------------------------------------------
975:     * ConfigurarOptionGroupsFiltros - optPagos/optOpcao/optCotEm/optCancs/
976:     * optConcs/optProrrogs/optFilGrd2. Legendas/ordem transcritas do dump
977:     * (regra #45) - a ORDEM do botao e o valor gravado.
978:     *--------------------------------------------------------------------------
979:     PROTECTED PROCEDURE ConfigurarOptionGroupsFiltros(par_oPag)
980:         LOCAL loc_cNao
981:         loc_cNao = "N" + CHR(227) + "o"
982: 
983:         *-- Pagamento
984:         par_oPag.AddObject("lbl_4c_Say3", "Label")
985:         WITH par_oPag.lbl_4c_Say3
986:             .Top = 308
987:             .Left = 123
988:             .Width = 63
989:             .FontName = "Tahoma"
990:             .ForeColor = RGB(90, 90, 90)
991:             .Caption = "Pagamento :"
992:             .Visible = .T.
993:         ENDWITH
994: 
995:         par_oPag.AddObject("opt_4c_Pagos", "OptionGroup")
996:         WITH par_oPag.opt_4c_Pagos
997:             .Top = 303
998:             .Left = 185
999:             .Width = 217
1000:             .Height = 25
1001:             .ButtonCount = 3
1002:             .BackStyle = 0
1003:             .BorderStyle = 0
1004:             .Value = 1
1005:             WITH .Buttons(1)
1006:                 .Top = 5
1007:                 .Left = 5
1008:                 .Width = 43
1009:                 .FontName = "Tahoma"
1010:                 .FontSize = 8
1011:                 .BackStyle = 0
1012:                 .Caption = "Geral"
1013:                 .ForeColor = RGB(90, 90, 90)
1014:             ENDWITH
1015:             WITH .Buttons(2)
1016:                 .Top = 5
1017:                 .Left = 85
1018:                 .Width = 34
1019:                 .FontName = "Tahoma"
1020:                 .FontSize = 8
1021:                 .BackStyle = 0
1022:                 .Caption = "Sim"
1023:                 .ForeColor = RGB(90, 90, 90)
1024:             ENDWITH
1025:             WITH .Buttons(3)
1026:                 .Top = 5
1027:                 .Left = 175
1028:                 .Width = 37
1029:                 .FontName = "Tahoma"
1030:                 .FontSize = 8
1031:                 .BackStyle = 0
1032:                 .Caption = loc_cNao
1033:                 .ForeColor = RGB(90, 90, 90)
1034:             ENDWITH
1035:             .Visible = .T.

*-- Linhas 1045 a 1090:
1045:             .ForeColor = RGB(90, 90, 90)
1046:             .Caption = "Op" + CHR(231) + CHR(227) + "o :"
1047:             .Visible = .T.
1048:         ENDWITH
1049: 
1050:         par_oPag.AddObject("opt_4c_Opcao", "OptionGroup")
1051:         WITH par_oPag.opt_4c_Opcao
1052:             .Top = 324
1053:             .Left = 185
1054:             .Width = 217
1055:             .Height = 25
1056:             .ButtonCount = 3
1057:             .BackStyle = 0
1058:             .BorderStyle = 0
1059:             .Value = 1
1060:             WITH .Buttons(1)
1061:                 .Top = 5
1062:                 .Left = 5
1063:                 .Width = 43
1064:                 .FontName = "Tahoma"
1065:                 .FontSize = 8
1066:                 .BackStyle = 0
1067:                 .Caption = "Geral"
1068:                 .ForeColor = RGB(90, 90, 90)
1069:             ENDWITH
1070:             WITH .Buttons(2)
1071:                 .Top = 5
1072:                 .Left = 85
1073:                 .Width = 34
1074:                 .FontName = "Tahoma"
1075:                 .FontSize = 8
1076:                 .BackStyle = 0
1077:                 .Caption = "Sim"
1078:                 .ForeColor = RGB(90, 90, 90)
1079:             ENDWITH
1080:             WITH .Buttons(3)
1081:                 .Top = 5
1082:                 .Left = 175
1083:                 .Width = 37
1084:                 .FontName = "Tahoma"
1085:                 .FontSize = 8
1086:                 .BackStyle = 0
1087:                 .Caption = loc_cNao
1088:                 .ForeColor = RGB(90, 90, 90)
1089:             ENDWITH
1090:             .Visible = .T.

*-- Linhas 1100 a 1145:
1100:             .ForeColor = RGB(90, 90, 90)
1101:             .Caption = "Convers" + CHR(227) + "o em :"
1102:             .Visible = .T.
1103:         ENDWITH
1104: 
1105:         par_oPag.AddObject("opt_4c_CotEm", "OptionGroup")
1106:         WITH par_oPag.opt_4c_CotEm
1107:             .Top = 282
1108:             .Left = 185
1109:             .Width = 405
1110:             .Height = 25
1111:             .ButtonCount = 5
1112:             .BackStyle = 0
1113:             .BorderStyle = 0
1114:             .Value = 1
1115:             WITH .Buttons(1)
1116:                 .Top = 5
1117:                 .Left = 5
1118:                 .Width = 56
1119:                 .FontName = "Tahoma"
1120:                 .FontSize = 8
1121:                 .BackStyle = 0
1122:                 .Caption = "Emiss" + CHR(227) + "o"
1123:                 .ForeColor = RGB(90, 90, 90)
1124:             ENDWITH
1125:             WITH .Buttons(2)
1126:                 .Top = 5
1127:                 .Left = 85
1128:                 .Width = 73
1129:                 .FontName = "Tahoma"
1130:                 .FontSize = 8
1131:                 .BackStyle = 0
1132:                 .Caption = "Vencimento"
1133:                 .ForeColor = RGB(90, 90, 90)
1134:             ENDWITH
1135:             WITH .Buttons(3)
1136:                 .Top = 5
1137:                 .Left = 175
1138:                 .Width = 76
1139:                 .FontName = "Tahoma"
1140:                 .FontSize = 8
1141:                 .BackStyle = 0
1142:                 .Caption = "Lan" + CHR(231) + "amento"
1143:                 .ForeColor = RGB(90, 90, 90)
1144:             ENDWITH
1145:             WITH .Buttons(4)

*-- Linhas 1175 a 1220:
1175:             .ForeColor = RGB(90, 90, 90)
1176:             .Caption = "Cancelamento :"
1177:             .Visible = .T.
1178:         ENDWITH
1179: 
1180:         par_oPag.AddObject("opt_4c_Cancs", "OptionGroup")
1181:         WITH par_oPag.opt_4c_Cancs
1182:             .Top = 344
1183:             .Left = 185
1184:             .Width = 217
1185:             .Height = 25
1186:             .ButtonCount = 3
1187:             .BackStyle = 0
1188:             .BorderStyle = 0
1189:             .Value = 1
1190:             WITH .Buttons(1)
1191:                 .Top = 5
1192:                 .Left = 5
1193:                 .Width = 43
1194:                 .FontName = "Tahoma"
1195:                 .FontSize = 8
1196:                 .BackStyle = 0
1197:                 .Caption = "Geral"
1198:                 .ForeColor = RGB(90, 90, 90)
1199:             ENDWITH
1200:             WITH .Buttons(2)
1201:                 .Top = 5
1202:                 .Left = 85
1203:                 .Width = 34
1204:                 .FontName = "Tahoma"
1205:                 .FontSize = 8
1206:                 .BackStyle = 0
1207:                 .Caption = "Sim"
1208:                 .ForeColor = RGB(90, 90, 90)
1209:             ENDWITH
1210:             WITH .Buttons(3)
1211:                 .Top = 5
1212:                 .Left = 175
1213:                 .Width = 37
1214:                 .FontName = "Tahoma"
1215:                 .FontSize = 8
1216:                 .BackStyle = 0
1217:                 .Caption = loc_cNao
1218:                 .ForeColor = RGB(90, 90, 90)
1219:             ENDWITH
1220:             .Visible = .T.

*-- Linhas 1230 a 1275:
1230:             .ForeColor = RGB(90, 90, 90)
1231:             .Caption = "Concilia" + CHR(231) + CHR(227) + "o :"
1232:             .Visible = .T.
1233:         ENDWITH
1234: 
1235:         par_oPag.AddObject("opt_4c_Concs", "OptionGroup")
1236:         WITH par_oPag.opt_4c_Concs
1237:             .Top = 364
1238:             .Left = 185
1239:             .Width = 217
1240:             .Height = 25
1241:             .ButtonCount = 3
1242:             .BackStyle = 0
1243:             .BorderStyle = 0
1244:             .Value = 1
1245:             WITH .Buttons(1)
1246:                 .Top = 5
1247:                 .Left = 5
1248:                 .Width = 43
1249:                 .FontName = "Tahoma"
1250:                 .FontSize = 8
1251:                 .BackStyle = 0
1252:                 .Caption = "Geral"
1253:                 .ForeColor = RGB(90, 90, 90)
1254:             ENDWITH
1255:             WITH .Buttons(2)
1256:                 .Top = 5
1257:                 .Left = 85
1258:                 .Width = 34
1259:                 .FontName = "Tahoma"
1260:                 .FontSize = 8
1261:                 .BackStyle = 0
1262:                 .Caption = "Sim"
1263:                 .ForeColor = RGB(90, 90, 90)
1264:             ENDWITH
1265:             WITH .Buttons(3)
1266:                 .Top = 5
1267:                 .Left = 175
1268:                 .Width = 37
1269:                 .FontName = "Tahoma"
1270:                 .FontSize = 8
1271:                 .BackStyle = 0
1272:                 .Caption = loc_cNao
1273:                 .ForeColor = RGB(90, 90, 90)
1274:             ENDWITH
1275:             .Visible = .T.

*-- Linhas 1285 a 1418:
1285:             .ForeColor = RGB(90, 90, 90)
1286:             .Caption = "Prorroga" + CHR(231) + CHR(227) + "o :"
1287:             .Visible = .T.
1288:         ENDWITH
1289: 
1290:         par_oPag.AddObject("opt_4c_Prorrogs", "OptionGroup")
1291:         WITH par_oPag.opt_4c_Prorrogs
1292:             .Top = 383
1293:             .Left = 185
1294:             .Width = 217
1295:             .Height = 25
1296:             .ButtonCount = 3
1297:             .BackStyle = 0
1298:             .BorderStyle = 0
1299:             .Value = 1
1300:             WITH .Buttons(1)
1301:                 .Top = 5
1302:                 .Left = 5
1303:                 .Width = 43
1304:                 .FontName = "Tahoma"
1305:                 .FontSize = 8
1306:                 .BackStyle = 0
1307:                 .Caption = "Geral"
1308:                 .ForeColor = RGB(90, 90, 90)
1309:             ENDWITH
1310:             WITH .Buttons(2)
1311:                 .Top = 5
1312:                 .Left = 85
1313:                 .Width = 34
1314:                 .FontName = "Tahoma"
1315:                 .FontSize = 8
1316:                 .BackStyle = 0
1317:                 .Caption = "Sim"
1318:                 .ForeColor = RGB(90, 90, 90)
1319:             ENDWITH
1320:             WITH .Buttons(3)
1321:                 .Top = 5
1322:                 .Left = 175
1323:                 .Width = 37
1324:                 .FontName = "Tahoma"
1325:                 .FontSize = 8
1326:                 .BackStyle = 0
1327:                 .Caption = loc_cNao
1328:                 .ForeColor = RGB(90, 90, 90)
1329:             ENDWITH
1330:             .Visible = .T.
1331:         ENDWITH
1332: 
1333:         *-- Filtro da grade 2 (Todas/Alguma) - sobre fundo escuro, texto branco
1334:         par_oPag.AddObject("opt_4c_FilGrd2", "OptionGroup")
1335:         WITH par_oPag.opt_4c_FilGrd2
1336:             .Top = 557
1337:             .Left = 748
1338:             .Width = 139
1339:             .Height = 17
1340:             .ButtonCount = 2
1341:             .AutoSize = .F.
1342:             .BackStyle = 0
1343:             .BorderStyle = 0
1344:             .Value = 1
1345:             WITH .Buttons(1)
1346:                 .Top = 1
1347:                 .Left = 5
1348:                 .Width = 58
1349:                 .FontName = "Verdana"
1350:                 .FontSize = 8
1351:                 .FontBold = .T.
1352:                 .BackStyle = 0
1353:                 .Caption = "Todas"
1354:                 .ForeColor = RGB(255, 255, 255)
1355:             ENDWITH
1356:             WITH .Buttons(2)
1357:                 .Top = 1
1358:                 .Left = 68
1359:                 .Width = 68
1360:                 .FontName = "Verdana"
1361:                 .FontSize = 8
1362:                 .FontBold = .T.
1363:                 .BackStyle = 0
1364:                 .Caption = "Alguma"
1365:                 .ForeColor = RGB(255, 255, 255)
1366:             ENDWITH
1367:             .Visible = .T.
1368:         ENDWITH
1369:     ENDPROC
1370: 
1371:     *--------------------------------------------------------------------------
1372:     * ConfigurarGradesFiltros - grdTipo (Column1=Imps checkbox + Column2=Dopes
1373:     * texto, bound a cursor_4c_Tipos) e as duas grades de Grupo/Conta
1374:     * (Grd_Clientes/Grd_Clientes2, 8 colunas: Grupo/NomeGrupo/Conta/Nome +
1375:     * CheckE/CheckP/CheckC/CheckA). ColumnOrder transcrito do dump (a ordem
1376:     * visual NAO segue a ordem numerica das colunas).
1377:     *--------------------------------------------------------------------------
1378:     PROTECTED PROCEDURE ConfigurarGradesFiltros(par_oPag)
1379:         LOCAL loc_cTipos, loc_cClientes, loc_cClientes2
1380:         loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
1381:         loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
1382:         loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2
1383: 
1384:         *-- grdTipo
1385:         par_oPag.AddObject("grd_4c_Tipos", "Grid")
1386:         WITH par_oPag.grd_4c_Tipos
1387:             .Top = 100
1388:             .Left = 624
1389:             .Width = 259
1390:             .Height = 275
1391:             .FontName = "Tahoma"
1392:             .AllowHeaderSizing = .F.
1393:             .AllowRowSizing = .F.
1394:             .DeleteMark = .F.
1395:             .RecordMark = .F.
1396:             .HeaderHeight = 17
1397:             .RowHeight = 17
1398:             .ScrollBars = 2
1399:             .GridLineColor = RGB(238, 238, 238)
1400:             .ColumnCount = 2
1401:             .RecordSource = loc_cTipos
1402: 
1403:             .Column1.ControlSource = loc_cTipos + ".Imps"
1404:             .Column1.Width = 17
1405:             .Column1.Alignment = 0
1406:             .Column1.Sparse = .F.
1407:             .Column1.Header1.Caption = ""
1408:             .Column1.AddObject("Check1", "CheckBox")
1409:             .Column1.Check1.Top = 23
1410:             .Column1.Check1.Left = 35
1411:             .Column1.Check1.Width = 60
1412:             .Column1.Check1.Height = 17
1413:             .Column1.Check1.Caption = ""
1414:             .Column1.CurrentControl = "Check1"
1415: 
1416:             .Column2.ControlSource = loc_cTipos + ".Dopes"
1417:             .Column2.Width = 220
1418:             .Column2.Movable = .F.

*-- Linhas 1426 a 1517:
1426:             .Visible = .T.
1427:         ENDWITH
1428: 
1429:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "KeyPress", THIS, "ChkTipoKeyPress")
1430:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseUp", THIS, "ChkTipoMouseUp")
1431:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseDown", THIS, "ChkTipoMouseDown")
1432:         BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "Click", THIS, "ChkTipoClick")
1433: 
1434:         *-- Grd_Clientes / Grd_Clientes2 (mesma estrutura)
1435:         THIS.ConfigurarGradeClientes(par_oPag, "grd_4c_Clientes", loc_cClientes, 426, 130)
1436:         THIS.ConfigurarGradeClientes(par_oPag, "grd_4c_Clientes2", loc_cClientes2, 575, 112)
1437: 
1438:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "KeyPress",   THIS, "ChkCliEKeyPress")
1439:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "MouseUp",    THIS, "ChkCliEMouseUp")
1440:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "MouseDown",  THIS, "ChkCliEMouseDown")
1441:         BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "Click",      THIS, "ChkCliEClick")
1442:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "KeyPress",   THIS, "ChkCliPKeyPress")
1443:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "MouseUp",    THIS, "ChkCliPMouseUp")
1444:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "MouseDown",  THIS, "ChkCliPMouseDown")
1445:         BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "Click",      THIS, "ChkCliPClick")
1446:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "KeyPress",   THIS, "ChkCliCKeyPress")
1447:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "MouseUp",    THIS, "ChkCliCMouseUp")
1448:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "MouseDown",  THIS, "ChkCliCMouseDown")
1449:         BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "Click",      THIS, "ChkCliCClick")
1450:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "KeyPress",   THIS, "ChkCliAKeyPress")
1451:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "MouseUp",    THIS, "ChkCliAMouseUp")
1452:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "MouseDown",  THIS, "ChkCliAMouseDown")
1453:         BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "Click",      THIS, "ChkCliAClick")
1454: 
1455:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "KeyPress",   THIS, "ChkCli2EKeyPress")
1456:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "MouseUp",    THIS, "ChkCli2EMouseUp")
1457:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "MouseDown",  THIS, "ChkCli2EMouseDown")
1458:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "Click",      THIS, "ChkCli2EClick")
1459:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "KeyPress",   THIS, "ChkCli2PKeyPress")
1460:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "MouseUp",    THIS, "ChkCli2PMouseUp")
1461:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "MouseDown",  THIS, "ChkCli2PMouseDown")
1462:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "Click",      THIS, "ChkCli2PClick")
1463:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "KeyPress",   THIS, "ChkCli2CKeyPress")
1464:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "MouseUp",    THIS, "ChkCli2CMouseUp")
1465:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "MouseDown",  THIS, "ChkCli2CMouseDown")
1466:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "Click",      THIS, "ChkCli2CClick")
1467:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "KeyPress",   THIS, "ChkCli2AKeyPress")
1468:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "MouseUp",    THIS, "ChkCli2AMouseUp")
1469:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "MouseDown",  THIS, "ChkCli2AMouseDown")
1470:         BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "Click",      THIS, "ChkCli2AClick")
1471:     ENDPROC
1472: 
1473:     *--------------------------------------------------------------------------
1474:     * ConfigurarGradeClientes - helper compartilhado por Grd_Clientes e
1475:     * Grd_Clientes2 (mesma estrutura de 8 colunas no legado).
1476:     *--------------------------------------------------------------------------
1477:     PROTECTED PROCEDURE ConfigurarGradeClientes(par_oPag, par_cNomeGrid, par_cCursor, par_nTop, par_nHeight)
1478:         LOCAL loc_oGrid
1479: 
1480:         par_oPag.AddObject(par_cNomeGrid, "Grid")
1481:         loc_oGrid = EVALUATE("par_oPag." + par_cNomeGrid)
1482: 
1483:         WITH loc_oGrid
1484:             .Top = par_nTop
1485:             .Left = 81
1486:             .Width = 802
1487:             .Height = par_nHeight
1488:             .FontName = "Tahoma"
1489:             .AllowHeaderSizing = .F.
1490:             .AllowRowSizing = .F.
1491:             .DeleteMark = .F.
1492:             .RecordMark = .F.
1493:             .ScrollBars = 2
1494:             .GridLineColor = RGB(238, 238, 238)
1495:             .ColumnCount = 8
1496:             .RecordSource = par_cCursor
1497: 
1498:             .Column1.ControlSource = par_cCursor + ".Grupo"
1499:             .Column1.Width = 90
1500:             .Column1.Movable = .F.
1501:             .Column1.Resizable = .F.
1502:             .Column1.Text1.MaxLength = 10
1503:             .Column1.Header1.Caption = "Grupo"
1504:             .Column1.Header1.Alignment = 2
1505:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1506: 
1507:             .Column4.ColumnOrder = 2
1508:             .Column4.ControlSource = par_cCursor + ".NomeGrupo"
1509:             .Column4.Width = 166
1510:             .Column4.Text1.MaxLength = 20
1511:             .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1512:             .Column4.Header1.Alignment = 2
1513:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
1514: 
1515:             .Column2.ColumnOrder = 3
1516:             .Column2.ControlSource = par_cCursor + ".Conta"
1517:             .Column2.Width = 90

*-- Linhas 1609 a 1652:
1609:     * SelTudo/Apaga/ApagaG1/G2) e do filtro nomeado (AddFiltro/DelFiltro/
1610:     * RecFiltro/Carregar). Icones e ToolTip transcritos do dump do SCX.
1611:     *--------------------------------------------------------------------------
1612:     PROTECTED PROCEDURE ConfigurarBotoesFiltros(par_oPag)
1613:         *-- grdTipo: Apaga (desmarca tudo) / SelTudo (marca tudo)
1614:         par_oPag.AddObject("cmd_4c_SelTudo", "CommandButton")
1615:         WITH par_oPag.cmd_4c_SelTudo
1616:             .Top = 295
1617:             .Left = 892
1618:             .Width = 40
1619:             .Height = 40
1620:             .FontName = "Verdana"
1621:             .FontSize = 8
1622:             .WordWrap = .T.
1623:             .Caption = ""
1624:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1625:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1626:             .ToolTipText = "Seleciona Tudo"
1627:             .ForeColor = RGB(36, 84, 155)
1628:             .BackColor = RGB(255, 255, 255)
1629:             .Themes = .T.
1630:             .Visible = .T.
1631:         ENDWITH
1632: 
1633:         par_oPag.AddObject("cmd_4c_Apaga", "CommandButton")
1634:         WITH par_oPag.cmd_4c_Apaga
1635:             .Top = 335
1636:             .Left = 892
1637:             .Width = 40
1638:             .Height = 40
1639:             .FontName = "Verdana"
1640:             .FontSize = 8
1641:             .WordWrap = .T.
1642:             .Caption = ""
1643:             .Picture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1644:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1645:             .ToolTipText = "Apaga Tudo"
1646:             .ForeColor = RGB(36, 84, 155)
1647:             .BackColor = RGB(255, 255, 255)
1648:             .Themes = .T.
1649:             .Visible = .T.
1650:         ENDWITH
1651: 
1652:         *-- Grd_Clientes: Inserir/Excluir/ApagaG1

*-- Linhas 1744 a 1765:
1744:             .BackColor = RGB(255, 255, 255)
1745:             .Themes = .T.
1746:             .Visible = .T.
1747:         ENDWITH
1748: 
1749:         par_oPag.AddObject("cmd_4c_ApagaG2", "CommandButton")
1750:         WITH par_oPag.cmd_4c_ApagaG2
1751:             .Top = 648
1752:             .Left = 892
1753:             .Width = 40
1754:             .Height = 40
1755:             .FontName = "Verdana"
1756:             .FontSize = 8
1757:             .WordWrap = .T.
1758:             .Caption = ""
1759:             .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1760:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
1761:             .ToolTipText = "Apaga TODAS as Linhas da Grade"
1762:             .ForeColor = RGB(36, 84, 155)
1763:             .BackColor = RGB(255, 255, 255)
1764:             .Themes = .T.
1765:             .Visible = .T.

*-- Linhas 1843 a 2525:
1843:             .Visible = .T.
1844:         ENDWITH
1845: 
1846:         BINDEVENT(par_oPag.cmd_4c_SelTudo,   "Click", THIS, "SelTudoClick")
1847:         BINDEVENT(par_oPag.cmd_4c_Apaga,     "Click", THIS, "ApagaClick")
1848:         BINDEVENT(par_oPag.cmd_4c_Inserir,   "Click", THIS, "BtnInserirClick")
1849:         BINDEVENT(par_oPag.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
1850:         BINDEVENT(par_oPag.cmd_4c_ApagaG1,   "Click", THIS, "BtnApagaG1Click")
1851:         BINDEVENT(par_oPag.cmd_4c_Inserir2,  "Click", THIS, "BtnInserir2Click")
1852:         BINDEVENT(par_oPag.cmd_4c_Excluir2,  "Click", THIS, "BtnExcluir2Click")
1853:         BINDEVENT(par_oPag.cmd_4c_ApagaG2,   "Click", THIS, "BtnApagaG2Click")
1854:         BINDEVENT(par_oPag.cmd_4c_AddFiltro, "Click", THIS, "CmdAddFiltroClick")
1855:         BINDEVENT(par_oPag.cmd_4c_DelFiltro, "Click", THIS, "CmdDelFiltroClick")
1856:         BINDEVENT(par_oPag.cmd_4c_RecFiltro, "Click", THIS, "BtnRecFiltroClick")
1857:         BINDEVENT(par_oPag.cmd_4c_Carregar,  "Click", THIS, "BtnCarregarClick")
1858:     ENDPROC
1859: 
1860:     *==========================================================================
1861:     * FASE 6 - Lookups de Page1 (Moeda Filtro/Conversao/Saldo, Forma de
1862:     * Publicidade, Especie da NF, Titulo Banco). Transcritos dos PROCEDURE
1863:     * Valid originais (fwbuscaext/fwBuscaSel) - ligados em "LostFocus" (regra
1864:     * #47 do CLAUDE.md), nunca em "KeyPress" sem testar a tecla, para nao
1865:     * abrir o picker a cada caractere digitado. Guarda de reentrancia
1866:     * (this_lEmLookup) porque o picker eh MODAL e redispara o proprio
1867:     * LostFocus ao tirar o foco do campo (regra #37).
1868:     *==========================================================================
1869: 
1870:     *--------------------------------------------------------------------------
1871:     * ValidarCMoes/ValidarDMoes - Moeda Filtro (SigCdMoe.CMoes/DMoes)
1872:     *--------------------------------------------------------------------------
1873:     PROCEDURE ValidarCMoes()
1874:         LOCAL loc_oPag, loc_cValor
1875:         IF THIS.this_lEmLookup
1876:             RETURN
1877:         ENDIF
1878:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1879:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_CMoes.Value)
1880:         IF EMPTY(loc_cValor)
1881:             loc_oPag.txt_4c_DMoes.Value = ""
1882:             RETURN
1883:         ENDIF
1884:         THIS.AbrirLookupMoeda("CMoes", loc_cValor, loc_oPag.txt_4c_CMoes, loc_oPag.txt_4c_DMoes)
1885:     ENDPROC
1886: 
1887:     PROCEDURE ValidarDMoes()
1888:         LOCAL loc_oPag, loc_cValor
1889:         IF THIS.this_lEmLookup
1890:             RETURN
1891:         ENDIF
1892:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1893:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_DMoes.Value)
1894:         IF EMPTY(loc_cValor)
1895:             loc_oPag.txt_4c_CMoes.Value = ""
1896:             RETURN
1897:         ENDIF
1898:         THIS.AbrirLookupMoeda("DMoes", loc_cValor, loc_oPag.txt_4c_CMoes, loc_oPag.txt_4c_DMoes)
1899:     ENDPROC
1900: 
1901:     *--------------------------------------------------------------------------
1902:     * ValidarCMoesC/ValidarDMoesC - Moeda Conversao (SigCdMoe.CMoes/DMoes)
1903:     *--------------------------------------------------------------------------
1904:     PROCEDURE ValidarCMoesC()
1905:         LOCAL loc_oPag, loc_cValor
1906:         IF THIS.this_lEmLookup
1907:             RETURN
1908:         ENDIF
1909:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1910:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_CMoesC.Value)
1911:         IF EMPTY(loc_cValor)
1912:             loc_oPag.txt_4c_DMoesC.Value = ""
1913:             RETURN
1914:         ENDIF
1915:         THIS.AbrirLookupMoeda("CMoes", loc_cValor, loc_oPag.txt_4c_CMoesC, loc_oPag.txt_4c_DMoesC)
1916:     ENDPROC
1917: 
1918:     PROCEDURE ValidarDMoesC()
1919:         LOCAL loc_oPag, loc_cValor
1920:         IF THIS.this_lEmLookup
1921:             RETURN
1922:         ENDIF
1923:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1924:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_DMoesC.Value)
1925:         IF EMPTY(loc_cValor)
1926:             loc_oPag.txt_4c_CMoesC.Value = ""
1927:             RETURN
1928:         ENDIF
1929:         THIS.AbrirLookupMoeda("DMoes", loc_cValor, loc_oPag.txt_4c_CMoesC, loc_oPag.txt_4c_DMoesC)
1930:     ENDPROC
1931: 
1932:     *--------------------------------------------------------------------------
1933:     * AbrirLookupMoeda - Funil compartilhado pelas 2 moedas (Filtro/
1934:     * Conversao). par_cCampoBusca indica qual coluna buscar (CMoes se o
1935:     * usuario editou o codigo, DMoes se editou a descricao) - igual ao par
1936:     * de PROCEDURE Valid simetricos do legado.
1937:     *--------------------------------------------------------------------------
1938:     PROTECTED PROCEDURE AbrirLookupMoeda(par_cCampoBusca, par_cValor, par_oTxtCod, par_oTxtDesc)
1939:         LOCAL loc_oBusca, loc_oErro
1940: 
1941:         THIS.this_lEmLookup = .T.
1942:         TRY
1943:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1944:                 "SigCdMoe", "cursor_4c_BuscaMoeda", par_cCampoBusca, par_cValor, ;
1945:                 "Moedas")
1946: 
1947:             IF VARTYPE(loc_oBusca) = "O"
1948:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1949:                     IF USED("cursor_4c_BuscaMoeda")
1950:                         par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1951:                         par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
1952:                     ENDIF
1953:                 ELSE
1954:                     IF !loc_oBusca.this_lAchouRegistro
1955:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1956:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1957:                         loc_oBusca.Show()
1958:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
1959:                             par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
1960:                             par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
1961:                         ENDIF
1962:                     ENDIF
1963:                 ENDIF
1964:                 loc_oBusca.Release()
1965:             ENDIF
1966:         CATCH TO loc_oErro
1967:             MsgErro("Erro ao buscar moeda: " + loc_oErro.Message, "Erro")
1968:         ENDTRY
1969:         THIS.this_lEmLookup = .F.
1970: 
1971:         IF USED("cursor_4c_BuscaMoeda")
1972:             USE IN cursor_4c_BuscaMoeda
1973:         ENDIF
1974:     ENDPROC
1975: 
1976:     *--------------------------------------------------------------------------
1977:     * ValidarMoeSaldo/AbrirLookupMoedaSaldo - Moeda do Saldo Inicial (so o
1978:     * codigo, sem campo de descricao ao lado - igual ao legado).
1979:     *--------------------------------------------------------------------------
1980:     PROCEDURE ValidarMoeSaldo()
1981:         LOCAL loc_oPag, loc_cValor
1982:         IF THIS.this_lEmLookup
1983:             RETURN
1984:         ENDIF
1985:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1986:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_MoeSaldo.Value)
1987:         IF EMPTY(loc_cValor)
1988:             RETURN
1989:         ENDIF
1990:         THIS.AbrirLookupMoedaSaldo(loc_cValor)
1991:     ENDPROC
1992: 
1993:     PROTECTED PROCEDURE AbrirLookupMoedaSaldo(par_cValor)
1994:         LOCAL loc_oBusca, loc_oErro
1995: 
1996:         THIS.this_lEmLookup = .T.
1997:         TRY
1998:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1999:                 "SigCdMoe", "cursor_4c_BuscaMoeSaldo", "CMoes", par_cValor, ;
2000:                 "Moedas")
2001: 
2002:             IF VARTYPE(loc_oBusca) = "O"
2003:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2004:                     IF USED("cursor_4c_BuscaMoeSaldo")
2005:                         THIS.pgf_4c_Paginas.Page1.txt_4c_MoeSaldo.Value = ALLTRIM(cursor_4c_BuscaMoeSaldo.CMoes)
2006:                     ENDIF
2007:                 ELSE
2008:                     IF !loc_oBusca.this_lAchouRegistro
2009:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2010:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2011:                         loc_oBusca.Show()
2012:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeSaldo")
2013:                             THIS.pgf_4c_Paginas.Page1.txt_4c_MoeSaldo.Value = ALLTRIM(cursor_4c_BuscaMoeSaldo.CMoes)
2014:                         ENDIF
2015:                     ENDIF
2016:                 ENDIF
2017:                 loc_oBusca.Release()
2018:             ENDIF
2019:         CATCH TO loc_oErro
2020:             MsgErro("Erro ao buscar moeda: " + loc_oErro.Message, "Erro")
2021:         ENDTRY
2022:         THIS.this_lEmLookup = .F.
2023: 
2024:         IF USED("cursor_4c_BuscaMoeSaldo")
2025:             USE IN cursor_4c_BuscaMoeSaldo
2026:         ENDIF
2027:     ENDPROC
2028: 
2029:     *--------------------------------------------------------------------------
2030:     * ValidarCFPublis/ValidarDFPublis - Forma de Publicidade (SigCdFpb.Cods/
2031:     * Descs)
2032:     *--------------------------------------------------------------------------
2033:     PROCEDURE ValidarCFPublis()
2034:         LOCAL loc_oPag, loc_cValor
2035:         IF THIS.this_lEmLookup
2036:             RETURN
2037:         ENDIF
2038:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2039:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_CFPublis.Value)
2040:         IF EMPTY(loc_cValor)
2041:             loc_oPag.txt_4c_DFPublis.Value = ""
2042:             RETURN
2043:         ENDIF
2044:         THIS.AbrirLookupPublicidade("Cods", loc_cValor)
2045:     ENDPROC
2046: 
2047:     PROCEDURE ValidarDFPublis()
2048:         LOCAL loc_oPag, loc_cValor
2049:         IF THIS.this_lEmLookup
2050:             RETURN
2051:         ENDIF
2052:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2053:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_DFPublis.Value)
2054:         IF EMPTY(loc_cValor)
2055:             loc_oPag.txt_4c_CFPublis.Value = ""
2056:             RETURN
2057:         ENDIF
2058:         THIS.AbrirLookupPublicidade("Descs", loc_cValor)
2059:     ENDPROC
2060: 
2061:     PROTECTED PROCEDURE AbrirLookupPublicidade(par_cCampoBusca, par_cValor)
2062:         LOCAL loc_oBusca, loc_oPag, loc_oErro
2063:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2064: 
2065:         THIS.this_lEmLookup = .T.
2066:         TRY
2067:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2068:                 "SigCdFpb", "cursor_4c_BuscaPublis", par_cCampoBusca, par_cValor, ;
2069:                 "Forma de Publicidade")
2070: 
2071:             IF VARTYPE(loc_oBusca) = "O"
2072:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2073:                     IF USED("cursor_4c_BuscaPublis")
2074:                         loc_oPag.txt_4c_CFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Cods)
2075:                         loc_oPag.txt_4c_DFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Descs)
2076:                     ENDIF
2077:                 ELSE
2078:                     IF !loc_oBusca.this_lAchouRegistro
2079:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
2080:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2081:                         loc_oBusca.Show()
2082:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPublis")
2083:                             loc_oPag.txt_4c_CFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Cods)
2084:                             loc_oPag.txt_4c_DFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Descs)
2085:                         ENDIF
2086:                     ENDIF
2087:                 ENDIF
2088:                 loc_oBusca.Release()
2089:             ENDIF
2090:         CATCH TO loc_oErro
2091:             MsgErro("Erro ao buscar forma de publicidade: " + loc_oErro.Message, "Erro")
2092:         ENDTRY
2093:         THIS.this_lEmLookup = .F.
2094: 
2095:         IF USED("cursor_4c_BuscaPublis")
2096:             USE IN cursor_4c_BuscaPublis
2097:         ENDIF
2098:     ENDPROC
2099: 
2100:     *--------------------------------------------------------------------------
2101:     * ValidarEspecieNfsFiltro/AbrirLookupEspecieFiltro - Especie da Nota
2102:     * Fiscal (SigCdEsp.Especies), campo unico (sem descricao ao lado).
2103:     *--------------------------------------------------------------------------
2104:     PROCEDURE ValidarEspecieNfsFiltro()
2105:         LOCAL loc_oPag, loc_cValor
2106:         IF THIS.this_lEmLookup
2107:             RETURN
2108:         ENDIF
2109:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2110:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_EspecieNfs.Value)
2111:         IF EMPTY(loc_cValor)
2112:             RETURN
2113:         ENDIF
2114:         THIS.AbrirLookupEspecieFiltro(loc_cValor)
2115:     ENDPROC
2116: 
2117:     PROTECTED PROCEDURE AbrirLookupEspecieFiltro(par_cValor)
2118:         LOCAL loc_oBusca, loc_oErro
2119: 
2120:         THIS.this_lEmLookup = .T.
2121:         TRY
2122:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2123:                 "SigCdEsp", "cursor_4c_BuscaEspecie", "Especies", par_cValor, ;
2124:                 "Esp" + CHR(233) + "cie da Nota Fiscal")
2125: 
2126:             IF VARTYPE(loc_oBusca) = "O"
2127:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2128:                     IF USED("cursor_4c_BuscaEspecie")
2129:                         THIS.pgf_4c_Paginas.Page1.txt_4c_EspecieNfs.Value = ALLTRIM(cursor_4c_BuscaEspecie.Especies)
2130:                     ENDIF
2131:                 ELSE
2132:                     IF !loc_oBusca.this_lAchouRegistro
2133:                         loc_oBusca.mAddColuna("Especies", "", "Esp" + CHR(233) + "cie")
2134:                         loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2135:                         loc_oBusca.Show()
2136:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEspecie")
2137:                             THIS.pgf_4c_Paginas.Page1.txt_4c_EspecieNfs.Value = ALLTRIM(cursor_4c_BuscaEspecie.Especies)
2138:                         ENDIF
2139:                     ENDIF
2140:                 ENDIF
2141:                 loc_oBusca.Release()
2142:             ENDIF
2143:         CATCH TO loc_oErro
2144:             MsgErro("Erro ao buscar esp" + CHR(233) + "cie da nota fiscal: " + loc_oErro.Message, "Erro")
2145:         ENDTRY
2146:         THIS.this_lEmLookup = .F.
2147: 
2148:         IF USED("cursor_4c_BuscaEspecie")
2149:             USE IN cursor_4c_BuscaEspecie
2150:         ENDIF
2151:     ENDPROC
2152: 
2153:     *--------------------------------------------------------------------------
2154:     * ValidarTitBansFiltro/AbrirLookupTitBans - Titulo Banco. Legado busca em
2155:     * GradeOpOpe (cursor local carregado de SigOpFp no Init, Where Situas In
2156:     * ('P','R','A') And Infos='K') via fwBuscaSel; aqui a mesma fonte e
2157:     * filtro vao direto no FormBuscaAuxiliar (SQLEXEC sobre a tabela, regra
2158:     * #36 - 1o argumento eh SEMPRE o handle de conexao).
2159:     *--------------------------------------------------------------------------
2160:     PROCEDURE ValidarTitBansFiltro()
2161:         LOCAL loc_oPag, loc_cValor
2162:         IF THIS.this_lEmLookup
2163:             RETURN
2164:         ENDIF
2165:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
2166:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_TitBans.Value)
2167:         IF EMPTY(loc_cValor)
2168:             RETURN
2169:         ENDIF
2170:         THIS.AbrirLookupTitBans(loc_cValor)
2171:     ENDPROC
2172: 
2173:     PROTECTED PROCEDURE AbrirLookupTitBans(par_cValor)
2174:         LOCAL loc_oBusca, loc_oErro
2175: 
2176:         THIS.this_lEmLookup = .T.
2177:         TRY
2178:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2179:                 "SigOpFp", "cursor_4c_BuscaTitBan", "Fpags", par_cValor, ;
2180:                 "T" + CHR(237) + "tulo Banco", .F., .T., ;
2181:                 "Situas IN ('P','R','A') AND Infos = " + EscaparSQL("K"))
2182: 
2183:             IF VARTYPE(loc_oBusca) = "O"
2184:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2185:                     IF USED("cursor_4c_BuscaTitBan")
2186:                         THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2187:                     ENDIF
2188:                 ELSE
2189:                     IF !loc_oBusca.this_lAchouRegistro
2190:                         loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
2191:                         loc_oBusca.Show()
2192:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTitBan")
2193:                             THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
2194:                         ENDIF
2195:                     ENDIF
2196:                 ENDIF
2197:                 loc_oBusca.Release()
2198:             ENDIF
2199:         CATCH TO loc_oErro
2200:             MsgErro("Erro ao buscar t" + CHR(237) + "tulo banco: " + loc_oErro.Message, "Erro")
2201:         ENDTRY
2202:         THIS.this_lEmLookup = .F.
2203: 
2204:         IF USED("cursor_4c_BuscaTitBan")
2205:             USE IN cursor_4c_BuscaTitBan
2206:         ENDIF
2207:     ENDPROC
2208: 
2209:     *==========================================================================
2210:     * FASE 5 - Page2 (pgDados): fileira de botoes de acao (Movimento/
2211:     * Recebimento/FollowUp/Impressao/Planilha) + CommandGroup cmgRetornar +
2212:     * PRIMEIRA METADE dos campos de detalhe do registro selecionado na grade
2213:     * (Ordem/Nota Fiscal/Especie/Empresa/Emitente/Portador). A segunda metade
2214:     * dos campos (Centro de Custo/Agente Cobrador/Titulo Banco/Historico/
2215:     * Saldo Inicial/grupos/checkbox Totais/memo de filtros) e o grid
2216:     * grdDados1 ficam para a fase seguinte. Nomes e geometria transcritos de
2217:     * tasks\task691\SIGOPCGF_form_codigo_fonte.txt (SECAO 2).
2218:     *==========================================================================
2219: 
2220:     *--------------------------------------------------------------------------
2221:     * ConfigurarPaginaDados - Monta o conteudo da Page2 (resultado da
2222:     * consulta). Chamada a partir de InicializarForm(), apos a Page1.
2223:     *--------------------------------------------------------------------------
2224:     PROTECTED PROCEDURE ConfigurarPaginaDados()
2225:         LOCAL loc_oPag
2226:         loc_oPag = THIS.pgf_4c_Paginas.Page2
2227: 
2228:         THIS.ConfigurarBotoesAcaoDados(loc_oPag)
2229:         THIS.ConfigurarCamposDados1(loc_oPag)
2230:         THIS.ConfigurarCamposDados2(loc_oPag)
2231:         THIS.ConfigurarGradeDados(loc_oPag)
2232:     ENDPROC
2233: 
2234:     *--------------------------------------------------------------------------
2235:     * ConfigurarBotoesAcaoDados - Shape1 (moldura ao redor da fileira de
2236:     * botoes), CommandGroup cmgRetornar (volta para a Page1) e os 6 botoes de
2237:     * acao (Recebimento/Movimento/FollowUp Conta/FollowUp Lancamento/
2238:     * Impressao/Planilha). SCX: Shape1 Top=83,Left=6,W=462,H=88; botoes
2239:     * Top=88, H=75 W=75, FontName="Comic Sans MS".
2240:     *--------------------------------------------------------------------------
2241:     PROTECTED PROCEDURE ConfigurarBotoesAcaoDados(par_oPag)
2242:         par_oPag.AddObject("shp_4c_Shape1", "Shape")
2243:         WITH par_oPag.shp_4c_Shape1
2244:             .Top         = 83
2245:             .Left        = 6
2246:             .Width       = 462
2247:             .Height      = 88
2248:             .BackStyle   = 0
2249:             .BorderStyle = 0
2250:             .BorderColor = RGB(136, 189, 188)
2251:             .Visible     = .T.
2252:         ENDWITH
2253: 
2254:         *-- cmgRetornar - CommandGroup com 1 botao, volta para a Page1 (Filtros)
2255:         par_oPag.AddObject("obj_4c_CmgRetornar", "CommandGroup")
2256:         WITH par_oPag.obj_4c_CmgRetornar
2257:             .Top         = -2
2258:             .Left        = 918
2259:             .Width       = 85
2260:             .Height      = 85
2261:             .ButtonCount = 1
2262:             .BackStyle   = 0
2263:             .BorderStyle = 0
2264:             .Themes      = .F.
2265:             .Visible     = .T.
2266: 
2267:             WITH .Buttons(1)
2268:                 .Top         = 5
2269:                 .Left        = 5
2270:                 .Width       = 75
2271:                 .Height      = 75
2272:                 .FontName    = "Comic Sans MS"
2273:                 .FontSize    = 8
2274:                 .FontBold    = .T.
2275:                 .FontItalic  = .T.
2276:                 .Caption     = "Retornar"
2277:                 .ToolTipText = "Retornar aos Filtros"
2278:                 .ForeColor   = RGB(90, 90, 90)
2279:                 .BackColor   = RGB(255, 255, 255)
2280:                 .Themes      = .F.
2281:                 .Cancel      = .T.
2282:                 .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2283:             ENDWITH
2284:         ENDWITH
2285:         BINDEVENT(par_oPag.obj_4c_CmgRetornar, "Click", THIS, "CmgRetornarClick")
2286: 
2287:         *-- Recebimento
2288:         par_oPag.AddObject("cmd_4c_BtnRecebe", "CommandButton")
2289:         WITH par_oPag.cmd_4c_BtnRecebe
2290:             .Top             = 88
2291:             .Left            = 12
2292:             .Width           = 75
2293:             .Height          = 75
2294:             .FontName        = "Comic Sans MS"
2295:             .FontSize        = 8
2296:             .FontBold        = .T.
2297:             .FontItalic      = .T.
2298:             .Caption         = "\<Recebimento"
2299:             .ToolTipText     = "Recebimentos"
2300:             .ForeColor       = RGB(90, 90, 90)
2301:             .BackColor       = RGB(255, 255, 255)
2302:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
2303:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
2304:             .Themes          = .T.
2305:             .Visible         = .T.
2306:         ENDWITH
2307:         BINDEVENT(par_oPag.cmd_4c_BtnRecebe, "Click", THIS, "BtnRecebeClick")
2308: 
2309:         *-- Movimento
2310:         par_oPag.AddObject("cmd_4c_BtnMovimento", "CommandButton")
2311:         WITH par_oPag.cmd_4c_BtnMovimento
2312:             .Top             = 88
2313:             .Left            = 87
2314:             .Width           = 75
2315:             .Height          = 75
2316:             .FontName        = "Comic Sans MS"
2317:             .FontSize        = 8
2318:             .FontBold        = .T.
2319:             .FontItalic      = .T.
2320:             .Caption         = "\<Movimento"
2321:             .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
2322:             .ForeColor       = RGB(90, 90, 90)
2323:             .BackColor       = RGB(255, 255, 255)
2324:             .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2325:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
2326:             .Themes          = .T.
2327:             .Visible         = .T.
2328:         ENDWITH
2329:         BINDEVENT(par_oPag.cmd_4c_BtnMovimento, "Click", THIS, "BtnMovimentoClick")
2330: 
2331:         *-- Follow-up da Conta
2332:         par_oPag.AddObject("cmd_4c_BtnFollowUpC", "CommandButton")
2333:         WITH par_oPag.cmd_4c_BtnFollowUpC
2334:             .Top             = 88
2335:             .Left            = 162
2336:             .Width           = 75
2337:             .Height          = 75
2338:             .FontName        = "Comic Sans MS"
2339:             .FontSize        = 8
2340:             .FontBold        = .T.
2341:             .FontItalic      = .T.
2342:             .WordWrap        = .T.
2343:             .Caption         = "Follo\<w-up Conta"
2344:             .ToolTipText     = "Follow-up da Conta "
2345:             .ForeColor       = RGB(90, 90, 90)
2346:             .BackColor       = RGB(255, 255, 255)
2347:             .Picture         = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2348:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2349:             .Themes          = .T.
2350:             .Visible         = .T.
2351:         ENDWITH
2352:         BINDEVENT(par_oPag.cmd_4c_BtnFollowUpC, "Click", THIS, "BtnFollowUpCClick")
2353: 
2354:         *-- Follow-up do Lancamento (Titulo)
2355:         par_oPag.AddObject("cmd_4c_BtnFollowUpL", "CommandButton")
2356:         WITH par_oPag.cmd_4c_BtnFollowUpL
2357:             .Top             = 88
2358:             .Left            = 237
2359:             .Width           = 75
2360:             .Height          = 75
2361:             .FontName        = "Comic Sans MS"
2362:             .FontSize        = 8
2363:             .FontBold        = .T.
2364:             .FontItalic      = .T.
2365:             .WordWrap        = .T.
2366:             .Caption         = "Follow-\<up Lan" + CHR(231) + "amento"
2367:             .ToolTipText     = "Follow-up do T" + CHR(237) + "tulo"
2368:             .ForeColor       = RGB(90, 90, 90)
2369:             .BackColor       = RGB(255, 255, 255)
2370:             .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2371:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
2372:             .Themes          = .T.
2373:             .Visible         = .T.
2374:         ENDWITH
2375:         BINDEVENT(par_oPag.cmd_4c_BtnFollowUpL, "Click", THIS, "BtnFollowUpLClick")
2376: 
2377:         *-- Impressao
2378:         par_oPag.AddObject("cmd_4c_BtnImprimir", "CommandButton")
2379:         WITH par_oPag.cmd_4c_BtnImprimir
2380:             .Top             = 88
2381:             .Left            = 312
2382:             .Width           = 75
2383:             .Height          = 75
2384:             .FontName        = "Comic Sans MS"
2385:             .FontSize        = 8
2386:             .FontBold        = .T.
2387:             .FontItalic      = .T.
2388:             .Caption         = "Im\<press" + CHR(227) + "o"
2389:             .ToolTipText     = "Impress" + CHR(227) + "o"
2390:             .ForeColor       = RGB(90, 90, 90)
2391:             .BackColor       = RGB(255, 255, 255)
2392:             .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2393:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2394:             .Themes          = .T.
2395:             .Visible         = .T.
2396:         ENDWITH
2397:         BINDEVENT(par_oPag.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
2398: 
2399:         *-- Planilha (Excel)
2400:         par_oPag.AddObject("cmd_4c_BtnPlanilha", "CommandButton")
2401:         WITH par_oPag.cmd_4c_BtnPlanilha
2402:             .Top             = 88
2403:             .Left            = 387
2404:             .Width           = 75
2405:             .Height          = 75
2406:             .FontName        = "Comic Sans MS"
2407:             .FontSize        = 8
2408:             .FontBold        = .T.
2409:             .FontItalic      = .T.
2410:             .Caption         = "Pla\<nilha"
2411:             .ToolTipText     = "Impress" + CHR(227) + "o"
2412:             .ForeColor       = RGB(90, 90, 90)
2413:             .BackColor       = RGB(255, 255, 255)
2414:             .Picture         = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
2415:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
2416:             .Themes          = .T.
2417:             .Visible         = .T.
2418:         ENDWITH
2419:         BINDEVENT(par_oPag.cmd_4c_BtnPlanilha, "Click", THIS, "BtnPlanilhaClick")
2420:     ENDPROC
2421: 
2422:     *--------------------------------------------------------------------------
2423:     * ConfigurarCamposDados1 - PRIMEIRA METADE dos campos de detalhe:
2424:     * combo de ordem da grade, Nota Fiscal, Especie, Empresa, Emitente e
2425:     * Portador (cada um com codigo + descricao). SCX: faixa Top=152..594,
2426:     * Left=17..992 (abaixo do grdDados1, que fica para a fase seguinte).
2427:     *--------------------------------------------------------------------------
2428:     PROTECTED PROCEDURE ConfigurarCamposDados1(par_oPag)
2429:         *-- Ordem da Grade (Moeda + ...)
2430:         par_oPag.AddObject("lbl_4c_Ordem", "Label")
2431:         WITH par_oPag.lbl_4c_Ordem
2432:             .Top       = 152
2433:             .Left      = 511
2434:             .Width     = 153
2435:             .AutoSize  = .T.
2436:             .FontName  = "Tahoma"
2437:             .FontSize  = 8
2438:             .ForeColor = RGB(90, 90, 90)
2439:             .Caption   = "\<Ordem da Grade (Moeda + ...) "
2440:             .Visible   = .T.
2441:         ENDWITH
2442: 
2443:         par_oPag.AddObject("cbo_4c_Ordem", "ComboBox")
2444:         WITH par_oPag.cbo_4c_Ordem
2445:             .Top               = 170
2446:             .Left              = 510
2447:             .Width             = 182
2448:             .Height            = 23
2449:             .Style             = 2
2450:             .RowSourceType     = 1
2451:             .RowSource         = "Emiss" + CHR(227) + "o,Vencimento,Lan" + CHR(231) + "amento,Baixa,Titulo,Historico,Emitente,Portador"
2452:             .Value             = 1
2453:             .FontName          = "Courier New"
2454:             .SpecialEffect     = 1
2455:             .BorderColor       = RGB(36, 84, 155)
2456:             .DisabledBackColor = RGB(255, 255, 255)
2457:             .DisabledForeColor = RGB(36, 84, 155)
2458:             .ToolTipText       = "Ordem dos Dados da Grade (Sempre Moeda + Ordem Selecionada)"
2459:             .Visible           = .T.
2460:         ENDWITH
2461:         BINDEVENT(par_oPag.cbo_4c_Ordem, "InteractiveChange", THIS, "CboOrdemInteractiveChange")
2462: 
2463:         *-- Nota Fiscal
2464:         par_oPag.AddObject("lbl_4c_NotaFiscal", "Label")
2465:         WITH par_oPag.lbl_4c_NotaFiscal
2466:             .Top       = 594
2467:             .Left      = 23
2468:             .FontName  = "Tahoma"
2469:             .ForeColor = RGB(90, 90, 90)
2470:             .Caption   = "Nota Fiscal :"
2471:             .Visible   = .T.
2472:         ENDWITH
2473: 
2474:         par_oPag.AddObject("txt_4c_NFs", "TextBox")
2475:         WITH par_oPag.txt_4c_NFs
2476:             .Top           = 590
2477:             .Left          = 89
2478:             .Width         = 100
2479:             .Height        = 23
2480:             .Value         = ""
2481:             .Format        = "K!"
2482:             .FontName      = "Tahoma"
2483:             .ForeColor     = RGB(0, 0, 0)
2484:             .SpecialEffect = 1
2485:             *-- legado getNFs: PROCEDURE When -> Return .f. (campo de exibicao)
2486:             .ReadOnly      = .T.
2487:             .Visible       = .T.
2488:         ENDWITH
2489: 
2490:         *-- Especie (da Nota Fiscal)
2491:         par_oPag.AddObject("lbl_4c_Especie", "Label")
2492:         WITH par_oPag.lbl_4c_Especie
2493:             .Top       = 594
2494:             .Left      = 212
2495:             .Width     = 45
2496:             .FontName  = "Tahoma"
2497:             .ForeColor = RGB(90, 90, 90)
2498:             .Caption   = "Esp" + CHR(233) + "cie :"
2499:             .Visible   = .T.
2500:         ENDWITH
2501: 
2502:         par_oPag.AddObject("txt_4c_EspecieNfs", "TextBox")
2503:         WITH par_oPag.txt_4c_EspecieNfs
2504:             .Top           = 590
2505:             .Left          = 262
2506:             .Width         = 52
2507:             .Height        = 23
2508:             .Value         = ""
2509:             .FontName      = "Tahoma"
2510:             .ForeColor     = RGB(0, 0, 0)
2511:             .SpecialEffect = 1
2512:             *-- legado getEspecieNfs (pgDados): When -> Return .f.
2513:             .ReadOnly      = .T.
2514:             .Visible       = .T.
2515:         ENDWITH
2516: 
2517:         *-- Empresa
2518:         par_oPag.AddObject("lbl_4c_Empresa", "Label")
2519:         WITH par_oPag.lbl_4c_Empresa
2520:             .Top       = 621
2521:             .Left      = 207
2522:             .Width     = 50
2523:             .Height    = 15
2524:             .FontName  = "Tahoma"
2525:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 2566 a 2609:
2566:             .ForeColor     = RGB(0, 0, 0)
2567:             .SpecialEffect = 1
2568:             *-- FIEL ao legado: getContEms eh o UNICO campo de detalhe da
2569:             *-- pgDados que NAO declara "PROCEDURE When -> Return .f." no SCX,
2570:             *-- entao continua focavel. Nao transformar em ReadOnly.
2571:             .Visible       = .T.
2572:         ENDWITH
2573: 
2574:         par_oPag.AddObject("lbl_4c_BarraEmitente", "Label")
2575:         WITH par_oPag.lbl_4c_BarraEmitente
2576:             .Top       = 566
2577:             .Left      = 540
2578:             .FontName  = "Tahoma"
2579:             .FontSize  = 10
2580:             .FontBold  = .T.
2581:             .ForeColor = RGB(90, 90, 90)
2582:             .Caption   = "/"
2583:             .Visible   = .T.
2584:         ENDWITH
2585: 
2586:         par_oPag.AddObject("txt_4c_DContEms", "TextBox")
2587:         WITH par_oPag.txt_4c_DContEms
2588:             .Top           = 564
2589:             .Left          = 632
2590:             .Width         = 360
2591:             .Height        = 23
2592:             .Value         = ""
2593:             .FontName      = "Tahoma"
2594:             .FontSize      = 8
2595:             .ForeColor     = RGB(0, 0, 0)
2596:             .SpecialEffect = 1
2597:             *-- legado getDContEms: When -> Return .f.
2598:             .ReadOnly      = .T.
2599:             .Visible       = .T.
2600:         ENDWITH
2601: 
2602:         *-- Portador (codigo + razao social)
2603:         par_oPag.AddObject("lbl_4c_Portador", "Label")
2604:         WITH par_oPag.lbl_4c_Portador
2605:             .Top       = 594
2606:             .Left      = 403
2607:             .FontName  = "Tahoma"
2608:             .ForeColor = RGB(90, 90, 90)
2609:             .Caption   = "Portador :"

*-- Linhas 2661 a 2711:
2661:     * ConfigurarCamposDados1), Centro de Custo, Agente Cobrador, Historico,
2662:     * Titulo Banco, Saldo Inicial, checkbox Totais e memo de filtros
2663:     * aplicados. Todos espelham a linha selecionada em grd_4c_Dados (grid
2664:     * ainda nao criado - PROCEDURE When do legado retorna .F. em TODOS estes
2665:     * campos, ou seja, nunca sao digitaveis pelo usuario) - por isso
2666:     * ReadOnly = .T.. O grid grdDados1 e o preenchimento destes campos
2667:     * (AfterRowColChange) ficam para a fase de eventos/acoes, junto com
2668:     * Processamento/MontaGraded/CalcSaldo/Imprimir/Planilha (regra do SCX:
2669:     * esses sao os metodos customizados do form, listados no ClassInfo).
2670:     *--------------------------------------------------------------------------
2671:     PROTECTED PROCEDURE ConfigurarCamposDados2(par_oPag)
2672:         *-- Grupo do Emitente (ao lado de txt_4c_ContEms, ja criado)
2673:         par_oPag.AddObject("txt_4c_GrupEms", "TextBox")
2674:         WITH par_oPag.txt_4c_GrupEms
2675:             .Top           = 564
2676:             .Left          = 459
2677:             .Width         = 80
2678:             .Height        = 23
2679:             .Value         = ""
2680:             .Format        = "K!"
2681:             .FontName      = "Tahoma"
2682:             .ForeColor     = RGB(0, 0, 0)
2683:             .SpecialEffect = 1
2684:             .ReadOnly      = .T.
2685:             .Visible       = .T.
2686:         ENDWITH
2687: 
2688:         *-- Grupo do Portador (ao lado de txt_4c_Contas, ja criado)
2689:         par_oPag.AddObject("txt_4c_Grupo", "TextBox")
2690:         WITH par_oPag.txt_4c_Grupo
2691:             .Top           = 590
2692:             .Left          = 459
2693:             .Width         = 80
2694:             .Height        = 23
2695:             .Value         = ""
2696:             .Format        = "K!"
2697:             .FontName      = "Tahoma"
2698:             .ForeColor     = RGB(0, 0, 0)
2699:             .SpecialEffect = 1
2700:             .ReadOnly      = .T.
2701:             .Visible       = .T.
2702:         ENDWITH
2703: 
2704:         *-- Centro de Custo (Grupo + codigo + "/" + descricao)
2705:         par_oPag.AddObject("lbl_4c_CentroCusto", "Label")
2706:         WITH par_oPag.lbl_4c_CentroCusto
2707:             .Top       = 621
2708:             .Left      = 366
2709:             .FontName  = "Tahoma"
2710:             .ForeColor = RGB(90, 90, 90)
2711:             .Caption   = "Centro de Custo :"

*-- Linhas 2938 a 3001:
2938:             .BackStyle   = 0
2939:             .Visible     = .T.
2940:         ENDWITH
2941:         BINDEVENT(par_oPag.chk_4c_Totais, "Click", THIS, "ChkTotaisClick")
2942: 
2943:         *-- Memo com a descricao dos filtros aplicados na consulta (somente
2944:         *-- exibicao - alterna altura 66/200 ao clicar, igual ao legado)
2945:         par_oPag.AddObject("obj_4c_GetFiltros", "EditBox")
2946:         WITH par_oPag.obj_4c_GetFiltros
2947:             .Top           = 83
2948:             .Left          = 510
2949:             .Width         = 381
2950:             .Height        = 66
2951:             .Value         = ""
2952:             .ReadOnly      = .T.
2953:             .FontName      = "Tahoma"
2954:             .SpecialEffect = 1
2955:             .Visible       = .T.
2956:         ENDWITH
2957:         BINDEVENT(par_oPag.obj_4c_GetFiltros, "Click", THIS, "GetFiltrosDadosClick")
2958: 
2959:         *-- Botoes (indicadores de status do titulo - Cancelado/Baixado/
2960:         *-- Conciliado/Prorrogado). TextBoxes read-only coloridos, nunca
2961:         *-- digitaveis (PROCEDURE When do legado retorna .f. nos 4).
2962:         par_oPag.AddObject("cnt_4c_Botoes", "Container")
2963:         WITH par_oPag.cnt_4c_Botoes
2964:             .Top         = 643
2965:             .Left        =  542
2966:             .Width       = 115
2967:             .Height      = 24
2968:             .BackStyle   = 0
2969:             .BorderWidth = 0
2970:             .Visible     = .T.
2971: 
2972:             .AddObject("txt_4c_Botao1", "TextBox")
2973:             WITH .txt_4c_Botao1
2974:                 .Top         = 1
2975:                 .Left        = 1
2976:                 .Width       = 29
2977:                 .Height      = 23
2978:                 .Alignment   = 0
2979:                 .Value       = ""
2980:                 .FontBold    = .T.
2981:                 .FontSize    = 12
2982:                 .BackColor   = RGB(255, 0, 0)
2983:                 .ToolTipText = "T" + CHR(237) + "tulo Cancelado"
2984:                 .ReadOnly    = .T.
2985:                 .TabStop     = .F.
2986:                 .Themes      = .F.
2987:                 .Visible     = .T.
2988:             ENDWITH
2989: 
2990:             .AddObject("txt_4c_Botao2", "TextBox")
2991:             WITH .txt_4c_Botao2
2992:                 .Top         = 1
2993:                 .Left        = 29
2994:                 .Width       = 29
2995:                 .Height      = 23
2996:                 .Alignment   = 0
2997:                 .Value       = ""
2998:                 .FontBold    = .T.
2999:                 .FontSize    = 12
3000:                 .BackColor   = RGB(0, 128, 0)
3001:                 .ToolTipText = "T" + CHR(237) + "tulo Baixado"

*-- Linhas 3047 a 3613:
3047:     * GetFiltrosDadosClick - Expande/retrai o memo de filtros aplicados
3048:     * (igual ao Click original do getFiltros da Page2 - alterna Height).
3049:     *--------------------------------------------------------------------------
3050:     PROCEDURE GetFiltrosDadosClick()
3051:         LOCAL loc_oMemo
3052:         loc_oMemo = THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros
3053: 
3054:         IF loc_oMemo.Height = 66
3055:             loc_oMemo.Height = 200
3056:         ELSE
3057:             loc_oMemo.Height = 66
3058:         ENDIF
3059:     ENDPROC
3060: 
3061:     *--------------------------------------------------------------------------
3062:     * CmgRetornarClick / Btn*Click (Page2) - navegacao e acoes. A logica
3063:     * completa (abrir SigCdPgr/SigCdLch, montar relatorio/planilha) e
3064:     * implementada na fase de eventos; aqui o botao ja volta para a Page1
3065:     * (unico comportamento que nao depende de registro selecionado na grade).
3066:     *--------------------------------------------------------------------------
3067:     PROCEDURE CmgRetornarClick()
3068:         *-- cmgRetornar do legado volta para a pagina de filtros. Delega ao
3069:         *-- funil unico de "abandonar a pagina corrente" (BtnCancelarClick).
3070:         THIS.BtnCancelarClick()
3071:     ENDPROC
3072: 
3073:     *--------------------------------------------------------------------------
3074:     * AlternarPagina - FUNIL de navegacao entre Filtros/Dados. Alem de trocar
3075:     * o ActivePage e o modo, repoe o estado que depende da pagina ativa:
3076:     *
3077:     *   - HabilitarCampos(): aplica o contrato de edicao de cada pagina
3078:     *     (filtros editaveis na Page1; campos de exibicao da Page2 sempre
3079:     *     somente-leitura, como os "PROCEDURE When -> Return .f." do legado).
3080:     *   - CarregarLista(): REPINTA a grade de resultado. Processamento()
3081:     *     popula cursor_4c_Dados com a Page2 ainda OCULTA e Refresh em pagina
3082:     *     oculta NAO pinta (regra #21/#46 do CLAUDE.md) - por isso a
3083:     *     repintura tem de acontecer AQUI, DEPOIS do ActivePage.
3084:     *--------------------------------------------------------------------------
3085:     PROCEDURE AlternarPagina(par_nPagina)
3086:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
3087: 
3088:         DO CASE
3089:         CASE par_nPagina = 1
3090:             THIS.this_cModoAtual = "FILTROS"
3091:             THIS.HabilitarCampos(.T.)
3092:         CASE par_nPagina = 2
3093:             THIS.this_cModoAtual = "DADOS"
3094:             THIS.HabilitarCampos(.F.)
3095:             THIS.CarregarLista()
3096:         ENDCASE
3097:     ENDPROC
3098: 
3099:     *--------------------------------------------------------------------------
3100:     * CmgFiltrosClick - Buttons(1)=Consultar valida as 4 faixas de data e
3101:     * segue para a Page2; Buttons(2)=Sair fecha o form (Cancel=.T., tambem
3102:     * dispara por ESC).
3103:     *--------------------------------------------------------------------------
3104:     PROCEDURE CmgFiltrosClick()
3105:         LOCAL loc_oGrupo, loc_nBotao
3106: 
3107:         loc_oGrupo = THIS.pgf_4c_Paginas.Page1.cmg_4c_Filtros
3108:         loc_nBotao = loc_oGrupo.Value
3109: 
3110:         DO CASE
3111:         CASE loc_nBotao = 1
3112:             THIS.BtnBuscarClick()
3113:         CASE loc_nBotao = 2
3114:             THIS.BtnCancelarClick()
3115:         ENDCASE
3116:     ENDPROC
3117: 
3118:     *--------------------------------------------------------------------------
3119:     * ValidarFiltrosData - Transcricao literal das 4 checagens "Inicial nao
3120:     * pode ser maior que a Final" do Click original (Emissao/Vencimento
3121:     * confirmados no dump; Lancamento/Acerto seguem o MESMO padrao simetrico).
3122:     *--------------------------------------------------------------------------
3123:     PROTECTED PROCEDURE ValidarFiltrosData()
3124:         LOCAL loc_oPag
3125:         loc_oPag = THIS.pgf_4c_Paginas.Page1
3126: 
3127:         IF !EMPTY(loc_oPag.txt_4c_DtEmiI.Value) AND !EMPTY(loc_oPag.txt_4c_DtEmiF.Value) AND ;
3128:            (loc_oPag.txt_4c_DtEmiI.Value > loc_oPag.txt_4c_DtEmiF.Value)
3129:             MsgAviso("A Data de Emiss" + CHR(227) + "o Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3130:             loc_oPag.txt_4c_DtEmiI.SetFocus()
3131:             RETURN .F.
3132:         ENDIF
3133: 
3134:         IF !EMPTY(loc_oPag.txt_4c_VencsI.Value) AND !EMPTY(loc_oPag.txt_4c_VencsF.Value) AND ;
3135:            (loc_oPag.txt_4c_VencsI.Value > loc_oPag.txt_4c_VencsF.Value)
3136:             MsgAviso("A Data de Vencimento Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3137:             loc_oPag.txt_4c_VencsI.SetFocus()
3138:             RETURN .F.
3139:         ENDIF
3140: 
3141:         IF !EMPTY(loc_oPag.txt_4c_DatasI.Value) AND !EMPTY(loc_oPag.txt_4c_DatasF.Value) AND ;
3142:            (loc_oPag.txt_4c_DatasI.Value > loc_oPag.txt_4c_DatasF.Value)
3143:             MsgAviso("A Data de Lan" + CHR(231) + "amento Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3144:             loc_oPag.txt_4c_DatasI.SetFocus()
3145:             RETURN .F.
3146:         ENDIF
3147: 
3148:         IF !EMPTY(loc_oPag.txt_4c_DtBxI.Value) AND !EMPTY(loc_oPag.txt_4c_DtBxF.Value) AND ;
3149:            (loc_oPag.txt_4c_DtBxI.Value > loc_oPag.txt_4c_DtBxF.Value)
3150:             MsgAviso("A Data de Acerto Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3151:             loc_oPag.txt_4c_DtBxI.SetFocus()
3152:             RETURN .F.
3153:         ENDIF
3154: 
3155:         RETURN .T.
3156:     ENDPROC
3157: 
3158:     *--------------------------------------------------------------------------
3159:     * ApagaClick/SelTudoClick - grdTipo: desmarca/marca todos os tipos de
3160:     * operacao (equivalente ao Update crSigOpOpe Set Imps=.. do legado).
3161:     *--------------------------------------------------------------------------
3162:     PROCEDURE ApagaClick()
3163:         LOCAL loc_cCursor
3164:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3165: 
3166:         IF USED(loc_cCursor)
3167:             SELECT (loc_cCursor)
3168:             REPLACE ALL Imps WITH 0
3169:             GO TOP
3170:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3171:         ENDIF
3172:     ENDPROC
3173: 
3174:     PROCEDURE SelTudoClick()
3175:         LOCAL loc_cCursor
3176:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
3177: 
3178:         IF USED(loc_cCursor)
3179:             SELECT (loc_cCursor)
3180:             REPLACE ALL Imps WITH 1 FOR !EMPTY(Dopes)
3181:             GO TOP
3182:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3183:         ENDIF
3184:     ENDPROC
3185: 
3186:     *--------------------------------------------------------------------------
3187:     * InserirLinhaGrade/ExcluirLinhaGrade/LimparGrade - CRUD de linha
3188:     * compartilhado pelas duas grades de Grupo/Conta (equivalente aos
3189:     * btnInserir*/btnExcluir*/btnApagaG* do legado sobre TmpCliente/
3190:     * TmpCliente2).
3191:     *--------------------------------------------------------------------------
3192:     PROTECTED PROCEDURE InserirLinhaGrade(par_cCursor, par_oGrid)
3193:         IF !USED(par_cCursor)
3194:             RETURN
3195:         ENDIF
3196: 
3197:         SELECT (par_cCursor)
3198:         GO TOP
3199:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3200:         IF EOF()
3201:             APPEND BLANK
3202:             GO BOTTOM
3203:         ENDIF
3204: 
3205:         par_oGrid.Refresh()
3206:         par_oGrid.SetFocus()
3207:         par_oGrid.Column1.SetFocus()
3208:     ENDPROC
3209: 
3210:     PROTECTED PROCEDURE ExcluirLinhaGrade(par_cCursor, par_oGrid)
3211:         IF !USED(par_cCursor)
3212:             RETURN
3213:         ENDIF
3214: 
3215:         SELECT (par_cCursor)
3216:         IF !EMPTY(Grupo) OR !EMPTY(Conta)
3217:             DELETE
3218:         ENDIF
3219: 
3220:         GO TOP
3221:         LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
3222:         IF EOF()
3223:             APPEND BLANK
3224:             GO BOTTOM
3225:         ENDIF
3226: 
3227:         par_oGrid.Refresh()
3228:         par_oGrid.SetFocus()
3229:         par_oGrid.Column1.SetFocus()
3230:     ENDPROC
3231: 
3232:     PROTECTED PROCEDURE LimparGrade(par_cCursor, par_oGrid)
3233:         IF !USED(par_cCursor)
3234:             RETURN
3235:         ENDIF
3236: 
3237:         ZAP IN (par_cCursor)
3238:         SELECT (par_cCursor)
3239:         APPEND BLANK
3240:         par_oGrid.Refresh()
3241:     ENDPROC
3242: 
3243:     PROCEDURE BtnInserirClick()
3244:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3245:     ENDPROC
3246: 
3247:     PROCEDURE BtnExcluirClick()
3248:         THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3249:     ENDPROC
3250: 
3251:     PROCEDURE BtnInserir2Click()
3252:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3253:     ENDPROC
3254: 
3255:     PROCEDURE BtnExcluir2Click()
3256:         THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3257:     ENDPROC
3258: 
3259:     PROCEDURE BtnApagaG1Click()
3260:         IF MsgConfirma("Confirma a Limpeza de TODOS os Dados Informados na Grade?", "Exclus" + CHR(227) + "o de Linhas da Grade")
3261:             THIS.LimparGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3262:         ENDIF
3263:     ENDPROC
3264: 
3265:     PROCEDURE BtnApagaG2Click()
3266:         IF MsgConfirma("Confirma a Limpeza de TODOS os Dados Informados na Grade?", "Exclus" + CHR(227) + "o de Linhas da Grade")
3267:             THIS.LimparGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3268:         ENDIF
3269:     ENDPROC
3270: 
3271:     *--------------------------------------------------------------------------
3272:     * AlternarFlagGrade - Alterna (0<->1) a coluna de flag de uma linha de
3273:     * grade (equivalente ao padrao de checkbox de Column regra #46/#185 -
3274:     * toggle feito por codigo, nunca pelo binding nativo do CheckBox).
3275:     *--------------------------------------------------------------------------
3276:     PROTECTED PROCEDURE AlternarFlagGrade(par_cCursor, par_cCampo, par_oGrid)
3277:         IF USED(par_cCursor)
3278:             SELECT (par_cCursor)
3279:             IF !EOF()
3280:                 REPLACE (par_cCampo) WITH IIF(EVALUATE(par_cCampo) = 0, 1, 0)
3281:             ENDIF
3282:         ENDIF
3283:         par_oGrid.Refresh()
3284:     ENDPROC
3285: 
3286:     *-- grdTipo.Column1.Check1 (Imps)
3287:     PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3288:         IF INLIST(par_nKeyCode, 13, 32)
3289:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorTipos, "Imps", THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos)
3290:             NODEFAULT
3291:         ENDIF
3292:     ENDPROC
3293:     PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3294:         THIS.ChkTipoKeyPress(13, 0)
3295:         NODEFAULT
3296:     ENDPROC
3297:     PROCEDURE ChkTipoMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3298:         NODEFAULT
3299:     ENDPROC
3300:     PROCEDURE ChkTipoClick()
3301:         NODEFAULT
3302:     ENDPROC
3303: 
3304:     *-- Grd_Clientes.Column5..8 (CheckE/CheckP/CheckC/CheckA)
3305:     PROCEDURE ChkCliEKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3306:         IF INLIST(par_nKeyCode, 13, 32)
3307:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckE", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3308:             NODEFAULT
3309:         ENDIF
3310:     ENDPROC
3311:     PROCEDURE ChkCliEMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3312:         THIS.ChkCliEKeyPress(13, 0)
3313:         NODEFAULT
3314:     ENDPROC
3315:     PROCEDURE ChkCliEMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3316:         NODEFAULT
3317:     ENDPROC
3318:     PROCEDURE ChkCliEClick()
3319:         NODEFAULT
3320:     ENDPROC
3321: 
3322:     PROCEDURE ChkCliPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3323:         IF INLIST(par_nKeyCode, 13, 32)
3324:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckP", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3325:             NODEFAULT
3326:         ENDIF
3327:     ENDPROC
3328:     PROCEDURE ChkCliPMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3329:         THIS.ChkCliPKeyPress(13, 0)
3330:         NODEFAULT
3331:     ENDPROC
3332:     PROCEDURE ChkCliPMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3333:         NODEFAULT
3334:     ENDPROC
3335:     PROCEDURE ChkCliPClick()
3336:         NODEFAULT
3337:     ENDPROC
3338: 
3339:     PROCEDURE ChkCliCKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3340:         IF INLIST(par_nKeyCode, 13, 32)
3341:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckC", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3342:             NODEFAULT
3343:         ENDIF
3344:     ENDPROC
3345:     PROCEDURE ChkCliCMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3346:         THIS.ChkCliCKeyPress(13, 0)
3347:         NODEFAULT
3348:     ENDPROC
3349:     PROCEDURE ChkCliCMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3350:         NODEFAULT
3351:     ENDPROC
3352:     PROCEDURE ChkCliCClick()
3353:         NODEFAULT
3354:     ENDPROC
3355: 
3356:     PROCEDURE ChkCliAKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3357:         IF INLIST(par_nKeyCode, 13, 32)
3358:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckA", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
3359:             NODEFAULT
3360:         ENDIF
3361:     ENDPROC
3362:     PROCEDURE ChkCliAMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3363:         THIS.ChkCliAKeyPress(13, 0)
3364:         NODEFAULT
3365:     ENDPROC
3366:     PROCEDURE ChkCliAMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3367:         NODEFAULT
3368:     ENDPROC
3369:     PROCEDURE ChkCliAClick()
3370:         NODEFAULT
3371:     ENDPROC
3372: 
3373:     *-- Grd_Clientes2.Column5..8 (CheckE/CheckP/CheckC/CheckA)
3374:     PROCEDURE ChkCli2EKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3375:         IF INLIST(par_nKeyCode, 13, 32)
3376:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckE", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3377:             NODEFAULT
3378:         ENDIF
3379:     ENDPROC
3380:     PROCEDURE ChkCli2EMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3381:         THIS.ChkCli2EKeyPress(13, 0)
3382:         NODEFAULT
3383:     ENDPROC
3384:     PROCEDURE ChkCli2EMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3385:         NODEFAULT
3386:     ENDPROC
3387:     PROCEDURE ChkCli2EClick()
3388:         NODEFAULT
3389:     ENDPROC
3390: 
3391:     PROCEDURE ChkCli2PKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3392:         IF INLIST(par_nKeyCode, 13, 32)
3393:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckP", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3394:             NODEFAULT
3395:         ENDIF
3396:     ENDPROC
3397:     PROCEDURE ChkCli2PMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3398:         THIS.ChkCli2PKeyPress(13, 0)
3399:         NODEFAULT
3400:     ENDPROC
3401:     PROCEDURE ChkCli2PMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3402:         NODEFAULT
3403:     ENDPROC
3404:     PROCEDURE ChkCli2PClick()
3405:         NODEFAULT
3406:     ENDPROC
3407: 
3408:     PROCEDURE ChkCli2CKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3409:         IF INLIST(par_nKeyCode, 13, 32)
3410:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckC", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3411:             NODEFAULT
3412:         ENDIF
3413:     ENDPROC
3414:     PROCEDURE ChkCli2CMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3415:         THIS.ChkCli2CKeyPress(13, 0)
3416:         NODEFAULT
3417:     ENDPROC
3418:     PROCEDURE ChkCli2CMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3419:         NODEFAULT
3420:     ENDPROC
3421:     PROCEDURE ChkCli2CClick()
3422:         NODEFAULT
3423:     ENDPROC
3424: 
3425:     PROCEDURE ChkCli2AKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3426:         IF INLIST(par_nKeyCode, 13, 32)
3427:             THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckA", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
3428:             NODEFAULT
3429:         ENDIF
3430:     ENDPROC
3431:     PROCEDURE ChkCli2AMouseUp(par_nButton, par_nShift, par_nX, par_nY)
3432:         THIS.ChkCli2AKeyPress(13, 0)
3433:         NODEFAULT
3434:     ENDPROC
3435:     PROCEDURE ChkCli2AMouseDown(par_nButton, par_nShift, par_nX, par_nY)
3436:         NODEFAULT
3437:     ENDPROC
3438:     PROCEDURE ChkCli2AClick()
3439:         NODEFAULT
3440:     ENDPROC
3441: 
3442:     *--------------------------------------------------------------------------
3443:     * CmdAddFiltroClick - Abre o campo de digitacao do nome de um filtro novo
3444:     * (equivalente ao legado: esconde getFiltros, mostra getNewFiltro).
3445:     *--------------------------------------------------------------------------
3446:     PROCEDURE CmdAddFiltroClick()
3447:         WITH THIS.pgf_4c_Paginas.Page1
3448:             .txt_4c_Filtros.Visible   = .F.
3449:             .txt_4c_NewFiltro.Visible = .T.
3450:             .txt_4c_NewFiltro.Value   = ""
3451:             .txt_4c_NewFiltro.SetFocus()
3452:         ENDWITH
3453:     ENDPROC
3454: 
3455:     *--------------------------------------------------------------------------
3456:     * BtnRecFiltroClick/CmdDelFiltroClick - Gravar/Apagar filtro nomeado em
3457:     * SigSyPar (cidparams = "SIGOPCGF" + nome, padrao determinado para
3458:     * permitir localizar e regravar o mesmo filtro). Substitui o
3459:     * ThisForm.poSigSyPar.fGravaUserCfg() do Framework legado (objeto nao
3460:     * portado) por SQL direto; mxmls guarda os valores atuais dos campos de
3461:     * filtro (SerializarFiltros/RestaurarFiltros), nao o XML original.
3462:     *--------------------------------------------------------------------------
3463:     PROCEDURE BtnRecFiltroClick()
3464:         LOCAL loc_oPag, loc_cNome, loc_cId, loc_cValores, loc_nExiste, loc_cSQL, loc_oErro
3465: 
3466:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
3467:         loc_cNome = IIF(loc_oPag.txt_4c_NewFiltro.Visible, ALLTRIM(loc_oPag.txt_4c_NewFiltro.Value), ALLTRIM(loc_oPag.txt_4c_Filtros.Value))
3468: 
3469:         IF EMPTY(loc_cNome)
3470:             MsgAviso("Informe o nome do filtro antes de grav" + CHR(225) + "-lo.", "Aten" + CHR(231) + CHR(227) + "o")
3471:             RETURN
3472:         ENDIF
3473: 
3474:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3475:             RETURN
3476:         ENDIF
3477: 
3478:         TRY
3479:             loc_cId      = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
3480:             loc_cValores = THIS.SerializarFiltros()
3481:             loc_nExiste  = 0
3482: 
3483:             IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId), "cursor_4c_FiltroExiste") > 0
3484:                 loc_nExiste = cursor_4c_FiltroExiste.nExiste
3485:                 USE IN cursor_4c_FiltroExiste
3486:             ENDIF
3487: 
3488:             IF loc_nExiste > 0
3489:                 loc_cSQL = "UPDATE SigSyPar SET mxmls = " + EscaparSQL(loc_cValores) + ;
3490:                            " WHERE cidparams = " + EscaparSQL(loc_cId)
3491:             ELSE
3492:                 loc_cSQL = "INSERT INTO SigSyPar (cidparams, ctpparams, descrs, mxmls) VALUES (" + ;
3493:                            EscaparSQL(loc_cId) + ", " + EscaparSQL("F") + ", " + ;
3494:                            EscaparSQL(LEFT(loc_cNome, 40)) + ", " + EscaparSQL(loc_cValores) + ")"
3495:             ENDIF
3496: 
3497:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3498:                 loc_oPag.txt_4c_NewFiltro.Visible = .F.
3499:                 loc_oPag.txt_4c_Filtros.Visible   = .T.
3500:                 loc_oPag.txt_4c_Filtros.Value     = loc_cNome
3501:                 THIS.CarregarFiltrosSalvos()
3502:                 MsgInfo("Filtro grav" + CHR(225) + "do com sucesso!", "Confirmar")
3503:             ELSE
3504:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3505:             ENDIF
3506:         CATCH TO loc_oErro
3507:             MsgErro(loc_oErro.Message, "Erro")
3508:         ENDTRY
3509:     ENDPROC
3510: 
3511:     PROCEDURE CmdDelFiltroClick()
3512:         LOCAL loc_oPag, loc_cNome, loc_cId, loc_cSQL, loc_oErro
3513: 
3514:         loc_oPag  = THIS.pgf_4c_Paginas.Page1
3515:         loc_cNome = ALLTRIM(loc_oPag.txt_4c_Filtros.Value)
3516: 
3517:         IF EMPTY(loc_cNome)
3518:             RETURN
3519:         ENDIF
3520: 
3521:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do filtro [" + loc_cNome + "]?", "Excluir Filtro")
3522:             RETURN
3523:         ENDIF
3524: 
3525:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3526:             RETURN
3527:         ENDIF
3528: 
3529:         TRY
3530:             loc_cId  = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
3531:             loc_cSQL = "DELETE FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId)
3532: 
3533:             IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
3534:                 loc_oPag.txt_4c_Filtros.Value = ""
3535:                 THIS.CarregarFiltrosSalvos()
3536:             ELSE
3537:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3538:             ENDIF
3539:         CATCH TO loc_oErro
3540:             MsgErro(loc_oErro.Message, "Erro")
3541:         ENDTRY
3542:     ENDPROC
3543: 
3544:     *--------------------------------------------------------------------------
3545:     * GetFiltrosLostFocus - Ao sair do campo com um nome existente em
3546:     * cursor_4c_Filtros, restaura os valores salvos nos campos de filtro
3547:     * (equivalente ao mLerCfg() do Framework legado).
3548:     *--------------------------------------------------------------------------
3549:     PROCEDURE GetFiltrosLostFocus()
3550:         LOCAL loc_oPag, loc_cNome, loc_cCursor
3551: 
3552:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
3553:         loc_cNome  = ALLTRIM(loc_oPag.txt_4c_Filtros.Value)
3554:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorFiltros
3555: 
3556:         IF EMPTY(loc_cNome) OR !USED(loc_cCursor)
3557:             RETURN
3558:         ENDIF
3559: 
3560:         SELECT (loc_cCursor)
3561:         LOCATE FOR ALLTRIM(Descrs) == loc_cNome
3562: 
3563:         IF FOUND()
3564:             THIS.RestaurarFiltros(ALLTRIM(Mxmls))
3565:         ENDIF
3566:     ENDPROC
3567: 
3568:     *--------------------------------------------------------------------------
3569:     * SerializarFiltros/RestaurarFiltros - Serializacao plana (CHR(9) como
3570:     * separador) dos campos de filtro para gravar/recarregar um filtro
3571:     * nomeado em SigSyPar.Mxmls.
3572:     *--------------------------------------------------------------------------
3573:     PROTECTED PROCEDURE SerializarFiltros()
3574:         LOCAL loc_oBO
3575: 
3576:         *-- FONTE UNICA: captura a tela nas propriedades do BO e serializa a
3577:         *-- partir DELAS, para nao haver duas leituras divergentes dos mesmos
3578:         *-- controles. Ordem e formato das 27 posicoes inalterados.
3579:         THIS.FormParaBO()
3580:         loc_oBO = THIS.this_oBusinessObject
3581: 
3582:         RETURN ;
3583:             TRANSFORM(loc_oBO.this_dDtEmiI)    + CHR(9) + ;
3584:             TRANSFORM(loc_oBO.this_dDtEmiF)    + CHR(9) + ;
3585:             TRANSFORM(loc_oBO.this_dVencsI)    + CHR(9) + ;
3586:             TRANSFORM(loc_oBO.this_dVencsF)    + CHR(9) + ;
3587:             TRANSFORM(loc_oBO.this_dDatasI)    + CHR(9) + ;
3588:             TRANSFORM(loc_oBO.this_dDatasF)    + CHR(9) + ;
3589:             TRANSFORM(loc_oBO.this_dDtBxI)     + CHR(9) + ;
3590:             TRANSFORM(loc_oBO.this_dDtBxF)     + CHR(9) + ;
3591:             ALLTRIM(loc_oBO.this_cTitulos)     + CHR(9) + ;
3592:             ALLTRIM(loc_oBO.this_cTitBans)     + CHR(9) + ;
3593:             ALLTRIM(loc_oBO.this_cEspecieNfs)  + CHR(9) + ;
3594:             ALLTRIM(loc_oBO.this_cNFs)         + CHR(9) + ;
3595:             ALLTRIM(loc_oBO.this_cCMoes)       + CHR(9) + ;
3596:             ALLTRIM(loc_oBO.this_cCMoesC)      + CHR(9) + ;
3597:             ALLTRIM(loc_oBO.this_cMoeSaldo)    + CHR(9) + ;
3598:             TRANSFORM(loc_oBO.this_nSaldo)     + CHR(9) + ;
3599:             ALLTRIM(loc_oBO.this_cCFPublis)    + CHR(9) + ;
3600:             ALLTRIM(loc_oBO.this_cEmpresa)     + CHR(9) + ;
3601:             TRANSFORM(IIF(loc_oBO.this_lBrancos, 1, 0))  + CHR(9) + ;
3602:             TRANSFORM(IIF(loc_oBO.this_lValPends, 1, 0)) + CHR(9) + ;
3603:             TRANSFORM(loc_oBO.this_nPagos)     + CHR(9) + ;
3604:             TRANSFORM(loc_oBO.this_nOpcao)     + CHR(9) + ;
3605:             TRANSFORM(loc_oBO.this_nCotEm)     + CHR(9) + ;
3606:             TRANSFORM(loc_oBO.this_nCancs)     + CHR(9) + ;
3607:             TRANSFORM(loc_oBO.this_nConcs)     + CHR(9) + ;
3608:             TRANSFORM(loc_oBO.this_nProrrogs)  + CHR(9) + ;
3609:             TRANSFORM(loc_oBO.this_nFilGrd2)
3610:     ENDPROC
3611: 
3612:     *--------------------------------------------------------------------------
3613:     * ObterTokenSerializado - Devolve a par_nPos-esima posicao de uma string

*-- Linhas 3619 a 3687:
3619:     * uma posicao vazia por filtro nao preenchido), usar GETWORDNUM faz o
3620:     * filtro nomeado voltar com os valores nos campos ERRADOS, em silencio -
3621:     * medido no VFP9 em 2026-10-24: com 4 posicoes vazias antes dele, o
3622:     * "Titulo" recebia o valor do 21o campo (indice do OptionGroup Pagamento).
3623:     *--------------------------------------------------------------------------
3624:     PROTECTED FUNCTION ObterTokenSerializado(par_cTexto, par_nPos)
3625:         LOCAL loc_nIni, loc_nFim, loc_cToken
3626:         loc_cToken = ""
3627: 
3628:         IF par_nPos <= 1
3629:             loc_nIni = 1
3630:         ELSE
3631:             loc_nFim = AT(CHR(9), par_cTexto, par_nPos - 1)
3632:             loc_nIni = IIF(loc_nFim = 0, 0, loc_nFim + 1)
3633:         ENDIF
3634: 
3635:         IF loc_nIni > 0
3636:             loc_nFim = AT(CHR(9), par_cTexto, par_nPos)
3637:             IF loc_nFim = 0
3638:                 loc_cToken = SUBSTR(par_cTexto, loc_nIni)
3639:             ELSE
3640:                 loc_cToken = SUBSTR(par_cTexto, loc_nIni, loc_nFim - loc_nIni)
3641:             ENDIF
3642:         ENDIF
3643: 
3644:         RETURN loc_cToken
3645:     ENDFUNC
3646: 
3647:     PROTECTED PROCEDURE RestaurarFiltros(par_cSerializado)
3648:         LOCAL loc_oBO, loc_nI
3649:         LOCAL ARRAY loc_aPartes[27]
3650: 
3651:         IF EMPTY(par_cSerializado)
3652:             RETURN
3653:         ENDIF
3654: 
3655:         FOR loc_nI = 1 TO 27
3656:             loc_aPartes[loc_nI] = THIS.ObterTokenSerializado(par_cSerializado, loc_nI)
3657:         ENDFOR
3658: 
3659:         *-- Captura a tela ANTES de sobrescrever: o blob guarda SO as 27
3660:         *-- posicoes de filtro, e o que nao esta nele (descricoes dos lookups,
3661:         *-- nome do filtro, ordem/totalizadores da Page2) tem de voltar ao
3662:         *-- BOParaForm com o valor que ja estava na tela, nao com um residuo.
3663:         THIS.FormParaBO()
3664:         loc_oBO = THIS.this_oBusinessObject
3665: 
3666:         loc_oBO.this_dDtEmiI    = ConverterParaData(loc_aPartes[1])
3667:         loc_oBO.this_dDtEmiF    = ConverterParaData(loc_aPartes[2])
3668:         loc_oBO.this_dVencsI    = ConverterParaData(loc_aPartes[3])
3669:         loc_oBO.this_dVencsF    = ConverterParaData(loc_aPartes[4])
3670:         loc_oBO.this_dDatasI    = ConverterParaData(loc_aPartes[5])
3671:         loc_oBO.this_dDatasF    = ConverterParaData(loc_aPartes[6])
3672:         loc_oBO.this_dDtBxI     = ConverterParaData(loc_aPartes[7])
3673:         loc_oBO.this_dDtBxF     = ConverterParaData(loc_aPartes[8])
3674:         loc_oBO.this_cTitulos   = loc_aPartes[9]
3675:         loc_oBO.this_cTitBans   = loc_aPartes[10]
3676:         loc_oBO.this_cEspecieNfs = loc_aPartes[11]
3677:         loc_oBO.this_cNFs       = loc_aPartes[12]
3678:         loc_oBO.this_cCMoes     = loc_aPartes[13]
3679:         loc_oBO.this_cCMoesC    = loc_aPartes[14]
3680:         loc_oBO.this_cMoeSaldo  = loc_aPartes[15]
3681:         loc_oBO.this_nSaldo     = VAL(loc_aPartes[16])
3682:         loc_oBO.this_cCFPublis  = loc_aPartes[17]
3683:         loc_oBO.this_cEmpresa   = loc_aPartes[18]
3684:         loc_oBO.this_lBrancos   = (VAL(loc_aPartes[19]) = 1)
3685:         loc_oBO.this_lValPends  = (VAL(loc_aPartes[20]) = 1)
3686:         loc_oBO.this_nPagos     = IIF(BETWEEN(VAL(loc_aPartes[21]), 1, 3), VAL(loc_aPartes[21]), 1)
3687:         loc_oBO.this_nOpcao     = IIF(BETWEEN(VAL(loc_aPartes[22]), 1, 3), VAL(loc_aPartes[22]), 1)

*-- Linhas 3699 a 3897:
3699:     * (equivalente ao Select 1 as Imps, Dopes, Opers, RealPrevs From SigOpOpe
3700:     * Order By Dopes + Insert Into ...(0, Space(20), 'C') do legado).
3701:     *--------------------------------------------------------------------------
3702:     PROTECTED PROCEDURE CarregarTiposOperacao()
3703:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL
3704: 
3705:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3706:             RETURN
3707:         ENDIF
3708: 
3709:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorTipos
3710:         loc_cCursorTmp = loc_cCursor + "Tmp"
3711:         loc_cSQL       = "SELECT 1 AS Imps, Dopes, Opers, RealPrevs FROM SigOpOpe ORDER BY Dopes"
3712: 
3713:         *-- cursor_4c_Tipos esta ligado a grd_4c_Tipos.RecordSource - SQLEXEC
3714:         *-- direto nele zeraria o ColumnCount (regra do Grid/SQLEXEC). O
3715:         *-- SQLEXEC vai para um cursor TEMPORARIO e o placeholder (criado em
3716:         *-- CriarCursoresFiltros, com a MESMA estrutura/indice) e recarregado
3717:         *-- com ZAP + APPEND FROM DBF, preservando a estrutura do Grid.
3718:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3719:             SELECT (loc_cCursor)
3720:             ZAP
3721:             APPEND FROM DBF(loc_cCursorTmp)
3722:             IF USED(loc_cCursorTmp)
3723:                 USE IN (loc_cCursorTmp)
3724:             ENDIF
3725: 
3726:             SELECT (loc_cCursor)
3727:             APPEND BLANK
3728:             REPLACE Imps WITH 0, Dopes WITH SPACE(20), Opers WITH "C", RealPrevs WITH 0
3729:             GO TOP
3730: 
3731:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
3732:         ENDIF
3733:     ENDPROC
3734: 
3735:     *--------------------------------------------------------------------------
3736:     * CarregarFiltrosSalvos - Popula cursor_4c_Filtros com os filtros
3737:     * nomeados ja gravados em SigSyPar para este form (cidparams iniciando
3738:     * por "SIGOPCGF").
3739:     *--------------------------------------------------------------------------
3740:     PROTECTED PROCEDURE CarregarFiltrosSalvos()
3741:         LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cId
3742: 
3743:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3744:             RETURN
3745:         ENDIF
3746: 
3747:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorFiltros
3748:         loc_cCursorTmp = loc_cCursor + "Tmp"
3749:         loc_cId        = PADR("SIGOPCGF", 8)
3750: 
3751:         loc_cSQL = "SELECT cidparams, ctpparams, descrs, mxmls FROM SigSyPar WHERE LEFT(cidparams, 8) = " + ;
3752:                    EscaparSQL(loc_cId) + " ORDER BY descrs"
3753: 
3754:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
3755:             SELECT (loc_cCursor)
3756:             ZAP
3757:             APPEND FROM DBF(loc_cCursorTmp)
3758:             IF USED(loc_cCursorTmp)
3759:                 USE IN (loc_cCursorTmp)
3760:             ENDIF
3761:             SELECT (loc_cCursor)
3762:             GO TOP
3763:         ENDIF
3764:     ENDPROC
3765: 
3766:     *--------------------------------------------------------------------------
3767:     * BtnCarregarClick/CarregarFPubs - Carrega em grd_4c_Clientes os pares
3768:     * Grupo/Conta vinculados a Forma de Publicidade digitada (equivalente ao
3769:     * ThisForm.CarregarFPubs do legado). A checagem extra de acesso por
3770:     * usuario/conta (fAcessoContas/fChecarInativas no legado) depende de
3771:     * tabelas de controle de acesso do Framework (SigSyAgc/SigCdAcG/
3772:     * SigSyAcc) fora do escopo desta tela de filtro - o filtro principal
3773:     * (FPubls = codigo informado) e o mesmo usado pelo legado para
3774:     * restringir o universo de clientes.
3775:     *--------------------------------------------------------------------------
3776:     PROCEDURE BtnCarregarClick()
3777:         LOCAL loc_oPag
3778:         loc_oPag = THIS.pgf_4c_Paginas.Page1
3779: 
3780:         IF EMPTY(loc_oPag.txt_4c_CFPublis.Value)
3781:             MsgAviso("Forma de Publicidade Para Filtro N" + CHR(227) + "o foi Preenchida!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
3782:             loc_oPag.txt_4c_CFPublis.SetFocus()
3783:             RETURN
3784:         ENDIF
3785: 
3786:         THIS.CarregarFPubs()
3787:         THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, loc_oPag.grd_4c_Clientes)
3788:     ENDPROC
3789: 
3790:     PROTECTED PROCEDURE CarregarFPubs()
3791:         LOCAL loc_oPag, loc_cPub, loc_cCursor, loc_cCursorTmp, loc_cSQL
3792: 
3793:         IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
3794:             RETURN
3795:         ENDIF
3796: 
3797:         loc_oPag       = THIS.pgf_4c_Paginas.Page1
3798:         loc_cPub       = ALLTRIM(loc_oPag.txt_4c_CFPublis.Value)
3799:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorClientes
3800:         loc_cCursorTmp = loc_cCursor + "Tmp"
3801: 
3802:         loc_cSQL = "SELECT a.Grupos AS Grupo, b.Descrs AS NomeGrupo, a.IClis AS Conta, " + ;
3803:                    "a.RClis AS Nome, 0 AS CheckE, 0 AS CheckP, 0 AS CheckC, 0 AS CheckA " + ;
3804:                    "FROM SigCdCli a, SigCdGcr b " + ;
3805:                    "WHERE a.Grupos = b.Codigos AND a.FPubls = " + EscaparSQL(loc_cPub)
3806: 
3807:         *-- cursor_4c_Clientes esta ligado a grd_4c_Clientes.RecordSource -
3808:         *-- ZAP + APPEND FROM DBF preserva a estrutura/binding do Grid.
3809:         IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) > 0
3810:             SELECT (loc_cCursor)
3811:             ZAP
3812:             APPEND FROM DBF(loc_cCursorTmp)
3813:             IF USED(loc_cCursorTmp)
3814:                 USE IN (loc_cCursorTmp)
3815:             ENDIF
3816:             SELECT (loc_cCursor)
3817:             GO TOP
3818:             loc_oPag.grd_4c_Clientes.Refresh()
3819:         ELSE
3820:             MsgAviso("Nenhum cliente encontrado para a Forma de Publicidade [" + loc_cPub + "].", "Aten" + CHR(231) + CHR(227) + "o")
3821:         ENDIF
3822:     ENDPROC
3823: 
3824:     *--------------------------------------------------------------------------
3825:     * ConfigurarGradeDados - cria grd_4c_Dados (grade de resultado da
3826:     * consulta, equivalente a grdDados1/LocalDados do legado). SO estrutura
3827:     * estatica (posicao/tamanho/propriedades de grade) - ColumnCount/
3828:     * RecordSource/ControlSource ficam em MontarGradeDados(), chamado DEPOIS
3829:     * de Processamento() povoar cursor_4c_Dados (regra #41 do CLAUDE.md:
3830:     * ControlSource de cursor que ainda nao existe derruba o Init).
3831:     *--------------------------------------------------------------------------
3832:     PROTECTED PROCEDURE ConfigurarGradeDados(par_oPag)
3833:         par_oPag.AddObject("grd_4c_Dados", "Grid")
3834:         WITH par_oPag.grd_4c_Dados
3835:             .Top               = 202
3836:             .Left              = 7
3837:             .Width             = 986
3838:             .Height            = 355
3839:             .DeleteMark        = .F.
3840:             .RecordMark        = .F.
3841:             .ReadOnly          = .T.
3842:             .AllowHeaderSizing = .F.
3843:             .AllowRowSizing    = .F.
3844:             .GridLineColor     = RGB(238, 238, 238)
3845:             .ScrollBars        = 2
3846:             .Visible           = .T.
3847:         ENDWITH
3848:         BINDEVENT(par_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
3849:     ENDPROC
3850: 
3851:     *--------------------------------------------------------------------------
3852:     * MontarGradeDados - Equivalente a ThisForm.MontaGradeD do legado. Religa
3853:     * as 12 colunas a cursor_4c_Dados. RecordSource reseta Column.Width e
3854:     * Header1.Caption (regra #48) - por isso TUDO e refeito aqui, sempre
3855:     * chamado depois de Processamento() repovoar o cursor.
3856:     *--------------------------------------------------------------------------
3857:     PROTECTED PROCEDURE MontarGradeDados()
3858:         LOCAL loc_oGrid, loc_cCursor, loc_cCor
3859: 
3860:         loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
3861:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
3862: 
3863:         loc_cCor = "IIF(" + loc_cCursor + ".Nopers=9999998, RGB(255,253,179), " + ;
3864:                    "IIF(" + loc_cCursor + ".Nopers=9999999, RGB(221,252,255), " + ;
3865:                    "IIF(" + loc_cCursor + ".SInis=1, RGB(255,202,205), RGB(255,255,255))))"
3866: 
3867:         WITH loc_oGrid
3868:             .RecordSource = ""
3869:             .ColumnCount  = 12
3870:             .RecordSource = loc_cCursor
3871: 
3872:             .Column1.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtEmis)))"
3873:             .Column1.Width           = 64
3874:             .Column1.Header1.Caption = "Emiss" + CHR(227) + "o"
3875: 
3876:             .Column2.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Vencs)))"
3877:             .Column2.Width           = 64
3878:             .Column2.Header1.Caption = "Vencto."
3879: 
3880:             .Column3.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Datas)))"
3881:             .Column3.Width           = 64
3882:             .Column3.Header1.Caption = "Lancto."
3883: 
3884:             .Column4.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtBaixa)))"
3885:             .Column4.Width           = 64
3886:             .Column4.Header1.Caption = "Baixa"
3887: 
3888:             .Column5.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', " + loc_cCursor + ".Titulos)"
3889:             .Column5.Width           = 70
3890:             .Column5.Header1.Caption = "T" + CHR(237) + "tulo"
3891: 
3892:             .Column6.ControlSource   = loc_cCursor + ".Hists"
3893:             .Column6.Width           = 240
3894:             .Column6.Header1.Caption = "Hist" + CHR(243) + "rico"
3895: 
3896:             .Column7.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997, '', " + loc_cCursor + ".Moedas)"
3897:             .Column7.Width           = 20

*-- Linhas 3934 a 3980:
3934:     * GrdDadosAfterRowColChange - equivalente ao AfterRowColChange de
3935:     * grdDados1: carrega a linha corrente (via BO.CarregarDoCursor), espelha
3936:     * os campos de detalhe da Page2 e os 4 indicadores de status (Botao1..4),
3937:     * e habilita/desabilita os botoes de acao conforme o PROCEDURE When do
3938:     * legado (linha "real" x linha sintetica de totalizador).
3939:     *--------------------------------------------------------------------------
3940:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
3941:         LOCAL loc_oPag, loc_oBO, loc_lTot
3942: 
3943:         IF !USED(THIS.this_oBusinessObject.this_cCursorDados)
3944:             RETURN
3945:         ENDIF
3946:         IF !THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorDados)
3947:             RETURN
3948:         ENDIF
3949: 
3950:         loc_oPag = THIS.pgf_4c_Paginas.Page2
3951:         loc_oBO  = THIS.this_oBusinessObject
3952: 
3953:         *-- Bloco de limpeza do AfterRowColChange legado, extraido para o funil
3954:         *-- unico LimparCampos(). O legado limpa SEMPRE as 4 descricoes e, SO
3955:         *-- quando a linha e sintetica (llTot), os outros 14 campos; como o
3956:         *-- ramo "IF !loc_lTot" abaixo reatribui TODOS os 18, limpar os 18 de
3957:         *-- uma vez produz exatamente o mesmo resultado nos dois caminhos.
3958:         THIS.LimparCampos()
3959: 
3960:         loc_lTot = (loc_oBO.this_nLinNopers > 9999997) OR (loc_oBO.this_nLinSInis = 1)
3961: 
3962:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao1.Value = IIF(!loc_lTot AND loc_oBO.this_nLinTitCancs = 1, " X", "")
3963:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao2.Value = IIF(!loc_lTot AND loc_oBO.this_cLinPagos = "0", " X", "")
3964:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao3.Value = IIF(!loc_lTot AND loc_oBO.this_lLinConcs, " X", "")
3965:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao4.Value = IIF(!loc_lTot AND !EMPTY(loc_oBO.this_dLinProrrogs), " X", "")
3966: 
3967:         IF !loc_lTot
3968:             loc_oPag.txt_4c_NFs.Value        = loc_oBO.this_cLinNFs
3969:             loc_oPag.txt_4c_TitBans.Value    = loc_oBO.this_cLinTitBans
3970:             loc_oPag.txt_4c_EspecieNfs.Value = loc_oBO.this_cLinEspecieNfs
3971:             loc_oPag.txt_4c_Hist2s.Value     = loc_oBO.this_cLinHist2s
3972:             loc_oPag.txt_4c_Emps.Value       = loc_oBO.this_cLinEmps
3973:             loc_oPag.txt_4c_ValOcurs.Value   = loc_oBO.this_nLinValOcurs
3974:             loc_oPag.txt_4c_GrupEms.Value    = loc_oBO.this_cLinGrupEms
3975:             loc_oPag.txt_4c_ContEms.Value    = loc_oBO.this_cLinContEms
3976:             loc_oPag.txt_4c_Grupo.Value      = loc_oBO.this_cLinGrupos
3977:             loc_oPag.txt_4c_Contas.Value     = loc_oBO.this_cLinContas
3978:             loc_oPag.txt_4c_SGrupos.Value    = loc_oBO.this_cLinSGrupos
3979:             loc_oPag.txt_4c_SContas.Value    = loc_oBO.this_cLinSContas
3980:             loc_oPag.txt_4c_GrupAges.Value   = loc_oBO.this_cLinGrupAges

*-- Linhas 3986 a 4151:
3986:             loc_oPag.txt_4c_DContAges.Value = THIS.ObterRazaoSocial(loc_oBO.this_cLinContAges)
3987:         ENDIF
3988: 
3989:         *-- PROCEDURE When dos botoes de acao, extraido para o funil unico
3990:         *-- AjustarBotoesPorModo() (tambem chamado por CarregarLista, para a
3991:         *-- PRIMEIRA linha exibida, que nunca dispara AfterRowColChange).
3992:         THIS.AjustarBotoesPorModo()
3993:     ENDPROC
3994: 
3995:     *--------------------------------------------------------------------------
3996:     * ObterRazaoSocial - cache de razao social (IClis/RClis), equivalente ao
3997:     * cursor TmpContas do legado. Consulta SigCdCli SO na primeira vez que o
3998:     * codigo aparece; demais chamadas usam o SEEK no cache local.
3999:     *--------------------------------------------------------------------------
4000:     PROTECTED FUNCTION ObterRazaoSocial(par_cCodigo)
4001:         LOCAL loc_cCursor, loc_cCodigo, loc_cSQL, loc_cResultado
4002:         loc_cResultado = ""
4003:         loc_cCodigo    = ALLTRIM(NVL(par_cCodigo, ""))
4004: 
4005:         IF EMPTY(loc_cCodigo)
4006:             RETURN loc_cResultado
4007:         ENDIF
4008: 
4009:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorContas
4010:         IF !USED(loc_cCursor)
4011:             CREATE CURSOR (loc_cCursor) (IClis C(10), RClis C(50))
4012:             INDEX ON IClis TAG IClis
4013:         ENDIF
4014: 
4015:         SELECT (loc_cCursor)
4016:         IF SEEK(PADR(loc_cCodigo, 10), loc_cCursor, "IClis")
4017:             RETURN ALLTRIM(RClis)
4018:         ENDIF
4019: 
4020:         loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
4021:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RazaoTmp") > 0
4022:             IF !EOF("cursor_4c_RazaoTmp")
4023:                 INSERT INTO (loc_cCursor) (IClis, RClis) VALUES ;
4024:                     (PADR(ALLTRIM(cursor_4c_RazaoTmp.IClis), 10), cursor_4c_RazaoTmp.RClis)
4025:                 loc_cResultado = ALLTRIM(cursor_4c_RazaoTmp.RClis)
4026:             ENDIF
4027:             IF USED("cursor_4c_RazaoTmp")
4028:                 USE IN cursor_4c_RazaoTmp
4029:             ENDIF
4030:         ENDIF
4031: 
4032:         RETURN loc_cResultado
4033:     ENDFUNC
4034: 
4035:     *--------------------------------------------------------------------------
4036:     * CboOrdemInteractiveChange / ChkTotaisClick - equivalentes ao
4037:     * InteractiveChange de cmbOrdem e ao Valid de chkTotais: atualizam
4038:     * this_cOrdem/this_nOrdem e reordenam a grade (OrdenaGrade).
4039:     *--------------------------------------------------------------------------
4040:     PROCEDURE CboOrdemInteractiveChange()
4041:         LOCAL loc_oCbo, loc_oBO
4042:         loc_oCbo = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem
4043:         loc_oBO  = THIS.this_oBusinessObject
4044: 
4045:         DO CASE
4046:         CASE loc_oCbo.Value = 1
4047:             loc_oBO.this_cOrdem = "DtEmis"
4048:         CASE loc_oCbo.Value = 2
4049:             loc_oBO.this_cOrdem = "Vencs"
4050:         CASE loc_oCbo.Value = 3
4051:             loc_oBO.this_cOrdem = "Datas"
4052:         CASE loc_oCbo.Value = 4
4053:             loc_oBO.this_cOrdem = "DtBaixa"
4054:         CASE loc_oCbo.Value = 5
4055:             loc_oBO.this_cOrdem = "Titulos"
4056:         CASE loc_oCbo.Value = 6
4057:             loc_oBO.this_cOrdem = "Hists"
4058:         CASE loc_oCbo.Value = 7
4059:             loc_oBO.this_cOrdem = "ContEms"
4060:         CASE loc_oCbo.Value = 8
4061:             loc_oBO.this_cOrdem = "Contas"
4062:         ENDCASE
4063:         loc_oBO.this_nOrdem = loc_oCbo.Value
4064: 
4065:         THIS.OrdenaGrade()
4066: 
4067:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.SetFocus()
4068:     ENDPROC
4069: 
4070:     PROCEDURE ChkTotaisClick()
4071:         THIS.OrdenaGrade()
4072:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.SetFocus()
4073:     ENDPROC
4074: 
4075:     *--------------------------------------------------------------------------
4076:     * OrdenaGrade - equivalente a ThisForm.OrdenaGrade: alterna entre o TAG
4077:     * filtrado (exclui linhas sinteticas) e o TAG cheio conforme
4078:     * chk_4c_Totais, recalcula os saldos (CalcSaldo/CalcSaldoCta conforme a
4079:     * ordem corrente) e repinta a grade.
4080:     *--------------------------------------------------------------------------
4081:     PROCEDURE OrdenaGrade()
4082:         LOCAL loc_cCursor, loc_cOrd, loc_oBO
4083:         loc_oBO     = THIS.this_oBusinessObject
4084:         loc_cCursor = loc_oBO.this_cCursorDados
4085: 
4086:         IF !USED(loc_cCursor)
4087:             RETURN
4088:         ENDIF
4089: 
4090:         loc_cOrd = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "", "_") + loc_oBO.this_cOrdem
4091: 
4092:         SELECT (loc_cCursor)
4093:         SET ORDER TO TAG (loc_cOrd)
4094: 
4095:         IF INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
4096:             THIS.CalcSaldoCta()
4097:         ELSE
4098:             THIS.CalcSaldo()
4099:         ENDIF
4100: 
4101:         GO TOP IN (loc_cCursor)
4102:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
4103:     ENDPROC
4104: 
4105:     *--------------------------------------------------------------------------
4106:     * CalcSaldo - transcricao literal de ThisForm.CalcSaldo: recalcula
4107:     * Debitos/Creditos/SaldoDia/SaldoTot linha a linha e insere as linhas
4108:     * sinteticas de "Saldo Inicial"/"Saldo da Moeda"/"Saldo do dia" conforme
4109:     * a troca de moeda/data na ordenacao corrente.
4110:     *--------------------------------------------------------------------------
4111:     PROTECTED PROCEDURE CalcSaldo()
4112:         LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
4113:         LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
4114:         LOCAL loc_cMsd, loc_nOrd, loc_dDat, loc_dRla, loc_cMoe, loc_nVal
4115: 
4116:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4117:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
4118:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4119:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4120: 
4121:         SELECT (loc_cCursor)
4122:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4123: 
4124:         loc_nSdD = 0
4125:         loc_nSD1 = 0
4126:         loc_nSC1 = 0
4127:         loc_nSD2 = 0
4128:         loc_nSC2 = 0
4129:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4130:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4131:         loc_nOrd = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value
4132: 
4133:         IF USED(loc_cTotais)
4134:             USE IN (loc_cTotais)
4135:         ENDIF
4136:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4137: 
4138:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4139: 
4140:         SELECT (loc_cCursor)
4141:         GO TOP
4142:         loc_dDat = TTOD(DtEmis)
4143:         DO CASE
4144:         CASE loc_nOrd = 2
4145:             loc_dDat = TTOD(Vencs)
4146:         CASE loc_nOrd = 3
4147:             loc_dDat = TTOD(Datas)
4148:         CASE loc_nOrd = 4
4149:             loc_dDat = TTOD(DtBaixa)
4150:         ENDCASE
4151: 

*-- Linhas 4311 a 4354:
4311:     * (Contas) em vez de por data, com a razao social (ObterRazaoSocial)
4312:     * compondo a linha sintetica de saldo.
4313:     *--------------------------------------------------------------------------
4314:     PROTECTED PROCEDURE CalcSaldoCta()
4315:         LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
4316:         LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
4317:         LOCAL loc_cMsd, loc_dDat, loc_cMoe, loc_cEmi, loc_cPor, loc_nVal
4318: 
4319:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4320:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
4321:         loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
4322:         loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem
4323: 
4324:         SELECT (loc_cCursor)
4325:         REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0
4326: 
4327:         loc_nSdD = 0
4328:         loc_nSD1 = 0
4329:         loc_nSC1 = 0
4330:         loc_nSD2 = 0
4331:         loc_nSC2 = 0
4332:         loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
4333:         loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
4334: 
4335:         IF USED(loc_cTotais)
4336:             USE IN (loc_cTotais)
4337:         ENDIF
4338:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE
4339: 
4340:         DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)
4341: 
4342:         SELECT (loc_cCursor)
4343:         GO TOP
4344:         loc_dDat = TTOD(DtEmis)
4345:         loc_cMoe = ALLTRIM(Moedas)
4346:         loc_cEmi = ALLTRIM(ContEms)
4347:         loc_cPor = ALLTRIM(Contas)
4348: 
4349:         SCAN
4350:             IF (loc_cMoe <> ALLTRIM(Moedas)) OR ;
4351:                (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
4352:                (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor)
4353: 
4354:                 SCATTER MEMVAR

*-- Linhas 4466 a 4576:
4466:     * preenchidos, o grupo usa "<>" e a conta usa "=" em vez de "<>") -
4467:     * regra #17 do CLAUDE.md: transcrever, nunca reescrever.
4468:     *--------------------------------------------------------------------------
4469:     PROTECTED PROCEDURE AplicarFiltroGrupoContaManter(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
4470:         LOCAL loc_cWhere
4471: 
4472:         IF EMPTY(par_cColGrupo)
4473:             RETURN
4474:         ENDIF
4475: 
4476:         DO CASE
4477:         CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4478:             loc_cWhere = par_cColGrupo + " = '" + ALLTRIM(par_cGrupo) + "' AND " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4479:         CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
4480:             loc_cWhere = par_cColGrupo + " = '" + ALLTRIM(par_cGrupo) + "'"
4481:         CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4482:             loc_cWhere = par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4483:         OTHERWISE
4484:             RETURN
4485:         ENDCASE
4486: 
4487:         UPDATE (par_cCursorDados) SET ManterDados = 1 WHERE &loc_cWhere.
4488:     ENDPROC
4489: 
4490:     PROTECTED PROCEDURE AplicarFiltroGrupoContaExcluirTodas(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
4491:         LOCAL loc_cWhere
4492: 
4493:         IF EMPTY(par_cColGrupo)
4494:             RETURN
4495:         ENDIF
4496: 
4497:         DO CASE
4498:         CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4499:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "' OR " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
4500:         CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
4501:             loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "'"
4502:         CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
4503:             loc_cWhere = par_cColConta + " <> '" + ALLTRIM(par_cConta) + "'"
4504:         OTHERWISE
4505:             RETURN
4506:         ENDCASE
4507: 
4508:         UPDATE (par_cCursorDados) SET ManterDados = 0 WHERE &loc_cWhere.
4509:     ENDPROC
4510: 
4511:     *--------------------------------------------------------------------------
4512:     * DataFimDiaSQL - monta o literal SQL Server do limite SUPERIOR de uma
4513:     * faixa de data (23:59:59), equivalente a fDtoSql(valor, [23:59:59]) do
4514:     * legado. Data vazia usa o sentinela 31/12/2099 (igual ao legado).
4515:     *--------------------------------------------------------------------------
4516:     PROTECTED FUNCTION DataFimDiaSQL(par_dData)
4517:         LOCAL loc_dData
4518:         loc_dData = par_dData
4519:         IF EMPTY(loc_dData)
4520:             loc_dData = {^2099-12-31}
4521:         ENDIF
4522:         RETURN "'" + PADL(YEAR(loc_dData), 4, "0") + "-" + PADL(MONTH(loc_dData), 2, "0") + "-" + ;
4523:                PADL(DAY(loc_dData), 2, "0") + " 23:59:59'"
4524:     ENDFUNC
4525: 
4526:     *--------------------------------------------------------------------------
4527:     * Processamento - transcricao do Processamento/ThisForm.Processamento do
4528:     * legado: monta a consulta financeira (SigMvCcr + filtros de Page1),
4529:     * aplica os filtros de Grupo/Conta das duas grades auxiliares, preenche
4530:     * a Data de Baixa e converte moeda quando necessario, cria os indices de
4531:     * ordenacao e deixa cursor_4c_Dados pronto para a Page2. Retorna .T. se
4532:     * encontrou dados (e so nesse caso o CmgFiltrosClick avanca para a
4533:     * Page2); .F. mantem o usuario na Page1 (igual ao ActivePage=1 do
4534:     * legado nos dois pontos de "Dados Nao Encontrados").
4535:     *--------------------------------------------------------------------------
4536:     PROCEDURE Processamento()
4537:         LOCAL loc_oPag1, loc_oBO, loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cRes
4538:         LOCAL loc_cEmp, loc_cDem, loc_cDvc, loc_cDla, loc_cMoe, loc_cPag, loc_cOpc
4539:         LOCAL loc_cCan, loc_cCcl, loc_cTit, loc_cNfs, loc_cTba, loc_cEsp, loc_cOpT
4540:         LOCAL loc_cCodEmp, loc_dDeI, loc_dDeF, loc_dDvI, loc_dDvF, loc_dDlI, loc_dDlF
4541:         LOCAL loc_nFl2, loc_nOpe, loc_lPrimeira, loc_nNop, loc_dPbI, loc_dPbF
4542:         LOCAL loc_cMdO, loc_dTDat, loc_nCtO, loc_nCtD, loc_nVlD, loc_nVlO, loc_nVlP, loc_nVlA
4543: 
4544:         loc_oPag1   = THIS.pgf_4c_Paginas.Page1
4545:         loc_oBO     = THIS.this_oBusinessObject
4546:         loc_cCursor = loc_oBO.this_cCursorDados
4547:         loc_cRes    = ""
4548: 
4549:         *-- Espelha os filtros da tela nas propriedades do BO ANTES de montar
4550:         *-- a consulta, para que o BO reflita exatamente os criterios que
4551:         *-- foram aplicados (consumido por Imprimir/Planilha e pela
4552:         *-- serializacao do filtro nomeado).
4553:         THIS.FormParaBO()
4554: 
4555:         *-- Empresa (EmpCcs tem precedencia sobre Emps - ajuste do legado
4556:         *-- para checar lancamento em outra empresa gravado no EmpCcs)
4557:         loc_cEmp = ""
4558:         IF !EMPTY(loc_oPag1.txt_4c_Empresa.Value)
4559:             loc_cCodEmp = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
4560:             loc_cRes = loc_cRes + " / Empresa: " + loc_cCodEmp
4561:             loc_cEmp = " AND (CASE WHEN a.EmpCcs <> '' AND a.EmpCcs = " + EscaparSQL(loc_cCodEmp) + " THEN 1 " + ;
4562:                        "ELSE CASE WHEN a.EmpCcs = '' AND a.Emps = " + EscaparSQL(loc_cCodEmp) + " THEN 1 ELSE 0 END END) = 1"
4563:         ENDIF
4564: 
4565:         *-- Emissao
4566:         loc_cDem = ""
4567:         IF !EMPTY(loc_oPag1.txt_4c_DtEmiI.Value)
4568:             loc_dDeI = loc_oPag1.txt_4c_DtEmiI.Value
4569:             loc_dDeF = loc_oPag1.txt_4c_DtEmiF.Value
4570:             loc_cDem = " AND (a.DtEmis BETWEEN " + FormatarDataSQL(loc_dDeI) + " AND " + THIS.DataFimDiaSQL(loc_dDeF) + ;
4571:                        IIF(loc_oPag1.chk_4c_Brancos.Value = 0, "", " OR a.DtEmis IS NULL") + ")"
4572:             loc_cRes = loc_cRes + " / Emiss" + CHR(227) + "o: " + DTOC(loc_dDeI) + " a " + ;
4573:                        DTOC(IIF(EMPTY(loc_dDeF), {^2099-12-31}, loc_dDeF))
4574:         ENDIF
4575: 
4576:         *-- Vencimento

*-- Linhas 4608 a 4664:
4608:             loc_cRes = loc_cRes + " / Moeda Filtro: " + ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
4609:         ENDIF
4610: 
4611:         IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
4612:             loc_cRes = loc_cRes + " / Moeda Convers" + CHR(227) + "o: " + ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value) + " (" + ;
4613:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 1, "Emiss" + CHR(227) + "o", ;
4614:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 2, "Vencimento", ;
4615:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 3, "Lan" + CHR(231) + "amento", ;
4616:                        IIF(loc_oPag1.opt_4c_CotEm.Value = 4, "Data Atual", "Data Acerto")))) + ")"
4617:         ENDIF
4618: 
4619:         *-- Pagamento
4620:         loc_cPag = ""
4621:         IF loc_oPag1.opt_4c_Pagos.Value <> 1
4622:             loc_cPag = " AND a.Pagos = " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "'0'", "'1'")
4623:             loc_cRes = loc_cRes + " / Pagamento: " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "Sim", "N" + CHR(227) + "o")
4624:         ENDIF
4625: 
4626:         *-- Opcao (NFs preenchida ou nao)
4627:         loc_cOpc = ""
4628:         IF loc_oPag1.opt_4c_Opcao.Value <> 1
4629:             loc_cOpc = " AND " + IIF(loc_oPag1.opt_4c_Opcao.Value = 2, "LTRIM(RTRIM(a.NFs)) <> ''", "LTRIM(RTRIM(a.NFs)) = ''")
4630:             loc_cRes = loc_cRes + " / Op" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Opcao.Value = 2, "Sim", "N" + CHR(227) + "o")
4631:         ENDIF
4632: 
4633:         *-- Cancelamento
4634:         loc_cCan = ""
4635:         IF loc_oPag1.opt_4c_Cancs.Value <> 1
4636:             loc_cCan = " AND " + IIF(loc_oPag1.opt_4c_Cancs.Value = 2, "", "NOT ") + "a.TitCancs = 1"
4637:             loc_cRes = loc_cRes + " / Cancelamento: " + IIF(loc_oPag1.opt_4c_Cancs.Value = 2, "Sim", "N" + CHR(227) + "o")
4638:         ENDIF
4639: 
4640:         *-- Conciliacao - o legado testa optCancs.Value=3 (nao optConcs) no
4641:         *-- IIF interno; preservado literalmente (regra #17).
4642:         loc_cCcl = ""
4643:         IF loc_oPag1.opt_4c_Concs.Value <> 1
4644:             loc_cCcl = " AND " + IIF(loc_oPag1.opt_4c_Cancs.Value = 3, "", "NOT ") + "a.Concs = 1"
4645:             loc_cRes = loc_cRes + " / Concilia" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Concs.Value = 2, "Sim", "N" + CHR(227) + "o")
4646:         ENDIF
4647: 
4648:         IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
4649:             loc_cRes = loc_cRes + " / Prorroga" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Prorrogs.Value = 2, "Sim", "N" + CHR(227) + "o")
4650:         ENDIF
4651: 
4652:         *-- Titulo / Nota Fiscal / Titulo Banco / Especie
4653:         loc_cTit = ""
4654:         IF !EMPTY(loc_oPag1.txt_4c_Titulos.Value)
4655:             loc_cTit = " AND a.Titulos = " + EscaparSQL(loc_oPag1.txt_4c_Titulos.Value)
4656:             loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo: " + ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
4657:         ENDIF
4658: 
4659:         loc_cNfs = ""
4660:         IF !EMPTY(loc_oPag1.txt_4c_NFs.Value)
4661:             loc_cNfs = " AND a.NFs = " + EscaparSQL(loc_oPag1.txt_4c_NFs.Value)
4662:             loc_cRes = loc_cRes + " / Nota Fiscal: " + ALLTRIM(loc_oPag1.txt_4c_NFs.Value)
4663:         ENDIF
4664: 

*-- Linhas 4753 a 4816:
4753:         SELECT (loc_cCursor)
4754:         GO TOP
4755:         IF EOF()
4756:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
4757:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
4758:             RETURN .F.
4759:         ENDIF
4760: 
4761:         IF loc_oPag1.chk_4c_ValPends.Value = 1
4762:             REPLACE ALL Valors WITH Valors - ValPags
4763:         ENDIF
4764: 
4765:         *-- Filtrando Grupos/Contas informados na grade 1 (cursor_4c_Clientes)
4766:         SELECT (loc_oBO.this_cCursorClientes)
4767:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4768:         IF FOUND()
4769:             UPDATE (loc_cCursor) SET ManterDados = 0
4770: 
4771:             SELECT (loc_oBO.this_cCursorClientes)
4772:             SCAN
4773:                 IF CheckE = 1
4774:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4775:                 ENDIF
4776:                 IF CheckP = 1
4777:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4778:                 ENDIF
4779:                 IF CheckC = 1
4780:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
4781:                 ENDIF
4782:                 IF CheckA = 1
4783:                     THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
4784:                 ENDIF
4785:             ENDSCAN
4786: 
4787:             loc_cRes = loc_cRes + " / Grupos-Contas: "
4788:             SELECT (loc_oBO.this_cCursorClientes)
4789:             SCAN
4790:                 loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
4791:                            IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
4792:                            IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
4793:                            IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
4794:                 loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
4795:             ENDSCAN
4796: 
4797:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4798:         ENDIF
4799: 
4800:         *-- Filtrando Grupos/Contas informados na grade 2 (Todas/Alguma)
4801:         loc_nFl2 = loc_oPag1.opt_4c_FilGrd2.Value
4802:         SELECT (loc_oBO.this_cCursorClientes2)
4803:         LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
4804:         IF FOUND()
4805:             UPDATE (loc_cCursor) SET ManterDados = IIF(loc_nFl2 = 1, 1, 0)
4806: 
4807:             SELECT (loc_oBO.this_cCursorClientes2)
4808:             SCAN
4809:                 IF loc_nFl2 = 1
4810:                     IF CheckE = 1
4811:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
4812:                     ENDIF
4813:                     IF CheckP = 1
4814:                         THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
4815:                     ENDIF
4816:                     IF CheckC = 1

*-- Linhas 4847 a 4868:
4847: 
4848:             DELETE FROM (loc_cCursor) WHERE ManterDados = 0
4849:         ENDIF
4850: 
4851:         *-- Filtrando os Titulos Prorrogados
4852:         IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
4853:             IF loc_oPag1.opt_4c_Prorrogs.Value = 2
4854:                 DELETE FROM (loc_cCursor) WHERE EMPTY(Prorrogs)
4855:             ELSE
4856:                 DELETE FROM (loc_cCursor) WHERE !EMPTY(Prorrogs)
4857:             ENDIF
4858:         ENDIF
4859: 
4860:         *-- Preenchendo a Data da Baixa (titulos em aberto, Pagos = "0")
4861:         SELECT (loc_cCursor)
4862:         SCAN FOR Pagos = "0"
4863:             loc_nNop = Nopers
4864:             loc_cSQL = "SELECT b.DatarCs FROM SigCdPit a, SigCdPgr b " + ;
4865:                        "WHERE a.Nopers = " + FormatarNumeroSQL(loc_nNop, 0) + " AND a.EmpDopNums = b.EmpDopNums " + ;
4866:                        "ORDER BY b.DatarCs DESC"
4867:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
4868:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")

*-- Linhas 4905 a 4931:
4905:             SELECT (loc_cCursor)
4906:             SCAN
4907:                 IF ALLTRIM(Moedas) <> loc_cMdO
4908:                     loc_dTDat = TTOD(DtEmis)
4909:                     DO CASE
4910:                     CASE loc_oPag1.opt_4c_CotEm.Value = 2
4911:                         loc_dTDat = TTOD(Vencs)
4912:                     CASE loc_oPag1.opt_4c_CotEm.Value = 3
4913:                         loc_dTDat = TTOD(Datas)
4914:                     CASE loc_oPag1.opt_4c_CotEm.Value = 4
4915:                         loc_dTDat = DATE()
4916:                     CASE loc_oPag1.opt_4c_CotEm.Value = 5
4917:                         IF !EMPTY(DtBaixa)
4918:                             loc_dTDat = TTOD(DtBaixa)
4919:                         ENDIF
4920:                     ENDCASE
4921:                     IF EMPTY(loc_dTDat)
4922:                         loc_dTDat = TTOD(Datas)
4923:                     ENDIF
4924: 
4925:                     loc_nCtO = fBuscarCotacao(loc_cMdO, loc_dTDat, gnConnHandle)
4926:                     loc_nCtD = fBuscarCotacao(ALLTRIM(Moedas), loc_dTDat, gnConnHandle)
4927:                     loc_nVlD = (Valors   / loc_nCtO) * loc_nCtD
4928:                     loc_nVlO = (ValOcurs / loc_nCtO) * loc_nCtD
4929:                     loc_nVlP = (ValPrev  / loc_nCtO) * loc_nCtD
4930:                     loc_nVlA = (ValPags  / loc_nCtO) * loc_nCtD
4931: 

*-- Linhas 4941 a 5084:
4941:         SELECT (loc_cCursor)
4942:         GO TOP
4943:         IF EOF()
4944:             MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
4945:                       "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
4946:             RETURN .F.
4947:         ENDIF
4948: 
4949:         SELECT (loc_cCursor)
4950:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR (Nopers < 9999997) AND (SInis <> 1)
4951:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR (Nopers < 9999997) AND (SInis <> 1)
4952:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR (Nopers < 9999997) AND (SInis <> 1)
4953:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR (Nopers < 9999997) AND (SInis <> 1)
4954:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR (Nopers < 9999997) AND (SInis <> 1)
4955:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR (Nopers < 9999997) AND (SInis <> 1)
4956:         INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR (Nopers < 9999997) AND (SInis <> 1)
4957:         INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR (Nopers < 9999997) AND (SInis <> 1)
4958: 
4959:         INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG DtEmis
4960:         INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG Vencs
4961:         INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG Datas
4962:         INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG DtBaixa
4963:         INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG Titulos
4964:         INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG Hists
4965:         INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG ContEms
4966:         INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG Contas
4967: 
4968:         loc_oBO.this_cOrdem = "DtEmis"
4969:         loc_oBO.this_nOrdem = 1
4970:         THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value = 1
4971: 
4972:         THIS.MontarGradeDados()
4973:         THIS.OrdenaGrade()
4974: 
4975:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value = loc_cRes
4976:         THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Refresh()
4977: 
4978:         SELECT (loc_cCursor)
4979:         GO TOP
4980: 
4981:         RETURN .T.
4982:     ENDPROC
4983: 
4984:     *--------------------------------------------------------------------------
4985:     * BtnMovimentoClick - equivalente ao Click de btnMovimento: identifica em
4986:     * qual tabela a movimentacao do titulo esta registrada (ChkRegister nao
4987:     * existe em BusinessBase - regra do CLAUDE.md - substituido por
4988:     * SELECT COUNT(*)) e abre a tela legada correspondente via DO FORM.
4989:     *--------------------------------------------------------------------------
4990:     PROCEDURE BtnMovimentoClick()
4991:         LOCAL loc_oBO, loc_cEmpDopNums, loc_nQtd, loc_cSQL
4992: 
4993:         loc_oBO = THIS.this_oBusinessObject
4994: 
4995:         IF loc_oBO.this_cLinTipos = "P" OR EMPTY(loc_oBO.this_nLinNopers)
4996:             RETURN
4997:         ENDIF
4998: 
4999:         loc_cEmpDopNums = PADR(loc_oBO.this_cLinEmps, 3) + PADR(loc_oBO.this_cLinDopes, 20) + STR(loc_oBO.this_nLinNumes, 6)
5000: 
5001:         *-- SigCdPgr (titulo em carteira de pagamento)
5002:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdPgr WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5003:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5004:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5005:         loc_nQtd = 0
5006:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPgr") > 0
5007:             loc_nQtd = cursor_4c_ChkPgr.Nreg
5008:             USE IN cursor_4c_ChkPgr
5009:         ENDIF
5010:         IF loc_nQtd > 0
5011:             DO FORM SigCdPgr WITH LEFT(loc_oBO.this_cLinDopes, 1), .T., loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5012:             RETURN
5013:         ENDIF
5014: 
5015:         *-- SigMvCab (movimento de estoque)
5016:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)
5017:         loc_nQtd = 0
5018:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab") > 0
5019:             loc_nQtd = cursor_4c_ChkMvCab.Nreg
5020:             USE IN cursor_4c_ChkMvCab
5021:         ENDIF
5022:         IF loc_nQtd > 0
5023:             IF WEXIST("FORM_")
5024:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Consultar o Movimento" + CHR(13) + ;
5025:                           "Existe Outra Movimenta" + CHR(231) + CHR(227) + "o Aberta!!!", "Movimento de Estoque Em Uso")
5026:             ELSE
5027:                 DO FORM SigMvExp WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
5028:             ENDIF
5029:             RETURN
5030:         ENDIF
5031: 
5032:         *-- SigOpOpe (titulo vinculado a movimentacao de titulo bancario)
5033:         IF !EMPTY(loc_oBO.this_cLinEmps) AND !EMPTY(loc_oBO.this_cLinDopes) AND !EMPTY(loc_oBO.this_nLinNumes)
5034:             loc_cSQL = "SELECT NDopes, RealPrevs FROM SigOpOpe WHERE Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes)
5035:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpOpe") < 1
5036:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (cursor_4c_ChkOpOpe)")
5037:                 RETURN
5038:             ENDIF
5039:             IF !EOF("cursor_4c_ChkOpOpe")
5040:                 IF fChecaAcesso("C" + PADL(ALLTRIM(TRANSFORM(cursor_4c_ChkOpOpe.NDopes)), 8, "0"), "CONSULTAR")
5041:                     DO FORM SigPgTit WITH loc_oBO.this_cLinDopes, "CONSULTAR", loc_oBO.this_cLinEmps, ;
5042:                              STR(loc_oBO.this_nLinNumes, 6), (cursor_4c_ChkOpOpe.RealPrevs = 2)
5043:                 ELSE
5044:                     MsgAviso("Usu" + CHR(225) + "rio N" + CHR(227) + "o Possui Acesso a Consultar T" + CHR(237) + "tulos!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5045:                 ENDIF
5046:                 IF USED("cursor_4c_ChkOpOpe")
5047:                     USE IN cursor_4c_ChkOpOpe
5048:                 ENDIF
5049:                 RETURN
5050:             ENDIF
5051:             IF USED("cursor_4c_ChkOpOpe")
5052:                 USE IN cursor_4c_ChkOpOpe
5053:             ENDIF
5054:         ENDIF
5055: 
5056:         *-- SigCqChm (cheque)
5057:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCqChm WHERE Emps = " + EscaparSQL(LEFT(loc_oBO.this_cLinVOpers, 3)) + ;
5058:                    " AND Numos = " + FormatarNumeroSQL(VAL(PADL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)), 9)), 0)
5059:         loc_nQtd = 0
5060:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChm") > 0
5061:             loc_nQtd = cursor_4c_ChkChm.Nreg
5062:             USE IN cursor_4c_ChkChm
5063:         ENDIF
5064:         IF loc_nQtd > 0
5065:             DO FORM SigCdLch WITH .T., LEFT(loc_oBO.this_cLinVOpers, 3), VAL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)))
5066:             RETURN
5067:         ENDIF
5068: 
5069:         *-- SigPrCtb (contabilizacao)
5070:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigPrCtb WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
5071:                    " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
5072:                    " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
5073:         loc_nQtd = 0
5074:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtb") > 0
5075:             loc_nQtd = cursor_4c_ChkCtb.Nreg
5076:             USE IN cursor_4c_ChkCtb
5077:         ENDIF
5078:         IF loc_nQtd > 0
5079:             DO FORM SigCdPgb WITH loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
5080:             RETURN
5081:         ENDIF
5082: 
5083:         *-- SigCdNec (necessidade de material vinculada ao movimento)
5084:         loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdNec WHERE EmpDnPs = " + ;

*-- Linhas 5098 a 5655:
5098:     * recebimento(s) do titulo corrente (SigCdPit/SigCdPgr/SigCdPbx) e, se
5099:     * nao achar, cai no fallback de SigTtCcr - igual ao legado.
5100:     *--------------------------------------------------------------------------
5101:     PROCEDURE BtnRecebeClick()
5102:         LOCAL loc_oBO, loc_cSQL
5103: 
5104:         loc_oBO = THIS.this_oBusinessObject
5105: 
5106:         loc_cSQL = "SELECT DISTINCT a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques " + ;
5107:                    "FROM SigCdPit a, SigCdPgr b, SigCdPbx c " + ;
5108:                    "WHERE a.Nopers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + ;
5109:                    " AND a.EmpDopNums = b.EmpDopNums AND a.EmpDopNums = c.EmpDopNums " + ;
5110:                    "ORDER BY a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques"
5111: 
5112:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5113:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
5114:             RETURN
5115:         ENDIF
5116: 
5117:         IF !EOF("cursor_4c_ConsPgt")
5118:             IF USED("cursor_4c_ConsPgt")
5119:                 USE IN cursor_4c_ConsPgt
5120:             ENDIF
5121:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5122:             RETURN
5123:         ENDIF
5124:         IF USED("cursor_4c_ConsPgt")
5125:             USE IN cursor_4c_ConsPgt
5126:         ENDIF
5127: 
5128:         loc_cSQL = "SELECT Emps, Dopcs AS Dopes, Numcs AS Numes, Nopers, Datas AS DataRcs, 0 AS Acertos, " + ;
5129:                    "'   ' AS Moedas, Dopcs AS Fpags, ' ' AS NCheques " + ;
5130:                    "FROM SigTtCcr " + ;
5131:                    "WHERE NOpers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + " " + ;
5132:                    "ORDER BY Emps, Dopcs, Numcs, Nopers, Datas"
5133: 
5134:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
5135:             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
5136:             RETURN
5137:         ENDIF
5138: 
5139:         IF !EOF("cursor_4c_ConsPgt")
5140:             IF USED("cursor_4c_ConsPgt")
5141:                 USE IN cursor_4c_ConsPgt
5142:             ENDIF
5143:             DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
5144:         ELSE
5145:             IF USED("cursor_4c_ConsPgt")
5146:                 USE IN cursor_4c_ConsPgt
5147:             ENDIF
5148:             MsgAviso("Nenhum Recebimento Localizado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5149:         ENDIF
5150:     ENDPROC
5151: 
5152:     *--------------------------------------------------------------------------
5153:     * BtnFollowUpCClick/BtnFollowUpLClick - equivalentes aos Click de
5154:     * btnFollowUpC/btnFollowUpL: abrem o follow-up da conta (so o emitente)
5155:     * ou do lancamento (emitente + numero da operacao).
5156:     *--------------------------------------------------------------------------
5157:     PROCEDURE BtnFollowUpCClick()
5158:         LOCAL loc_oBO
5159:         loc_oBO = THIS.this_oBusinessObject
5160: 
5161:         IF !EMPTY(loc_oBO.this_cLinContEms)
5162:             DO FORM SigOpFlp WITH loc_oBO.this_cLinContEms, THIS.DataSessionId
5163:         ENDIF
5164:     ENDPROC
5165: 
5166:     PROCEDURE BtnFollowUpLClick()
5167:         LOCAL loc_oBO
5168:         loc_oBO = THIS.this_oBusinessObject
5169: 
5170:         IF !EMPTY(loc_oBO.this_cLinContEms) AND !EMPTY(loc_oBO.this_nLinNopers)
5171:             DO FORM SigOpFlp WITH loc_oBO.this_cLinContEms, THIS.DataSessionId, loc_oBO.this_nLinNopers
5172:         ENDIF
5173:     ENDPROC
5174: 
5175:     *--------------------------------------------------------------------------
5176:     * BtnImprimirClick/BtnPlanilhaClick - delegam para Imprimir()/Planilha(),
5177:     * igual ao Click original (ThisForm.Imprimir / ThisForm.Planilha).
5178:     *--------------------------------------------------------------------------
5179:     PROCEDURE BtnImprimirClick()
5180:         THIS.Imprimir()
5181:     ENDPROC
5182: 
5183:     PROCEDURE BtnPlanilhaClick()
5184:         THIS.Planilha()
5185:     ENDPROC
5186: 
5187:     *--------------------------------------------------------------------------
5188:     * Imprimir - transcricao de ThisForm.Imprimir: monta um cursor reduzido
5189:     * (equivalente a crMccr) com os campos do relatorio, indexa pela ordem
5190:     * corrente e dispara REPORT FORM SigReCgf. O FRX legado nao foi portado
5191:     * para o acervo (nao existe em nenhuma pasta do projeto) - o guard de
5192:     * arquivo abaixo documenta essa pendencia em vez de falhar calado.
5193:     *--------------------------------------------------------------------------
5194:     *-- ============================================================
5195:     *-- PROCEDURE ExecutarReportForm (Pattern #117)
5196:     *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
5197:     *-- exibe MostrarErro descritivo com o path faltante.
5198:     *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
5199:     *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
5200:     *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
5201:     *-- fontes em runtime e mostra asteriscos em campos numericos.
5202:     *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
5203:     *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
5204:     *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
5205:     *-- ============================================================
5206:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
5207:         LOCAL loc_cFRX
5208:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
5209: 
5210:         IF NOT FILE(loc_cFRX)
5211:             MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
5212:                 loc_cFRX + CHR(13) + CHR(13) + ;
5213:                 "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
5214:             RETURN .F.
5215:         ENDIF
5216: 
5217:         *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
5218:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
5219:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
5220:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
5221:                     "Aten" + CHR(231) + CHR(227) + "o")
5222:                 RETURN .F.
5223:             ENDIF
5224:         ENDIF
5225: 
5226:         *-- Isolamento de locale + modo de renderizacao (Pattern #117 / Erro28)
5227:         LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
5228:         loc_cPointOrig    = SET("POINT")
5229:         loc_cSepOrig      = SET("SEPARATOR")
5230:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
5231:         SET POINT TO "."
5232:         SET SEPARATOR TO ","
5233:         SET REPORTBEHAVIOR 80
5234: 
5235:         DO CASE
5236:             CASE par_cModo == "PREVIEW"
5237:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
5238:             CASE par_cModo == "PRINTER_PROMPT"
5239:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
5240:             CASE par_cModo == "PRINTER"
5241:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
5242:         ENDCASE
5243: 
5244:         SET POINT TO (loc_cPointOrig)
5245:         SET SEPARATOR TO (loc_cSepOrig)
5246:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
5247: 
5248:         *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
5249:         *-- que corrompe cache visual do _MSYSMENU. Sem RELEASE + Criar aqui,
5250:         *-- popups renderizam encolhidos apos preview fechar. Mesmo fix do
5251:         *-- FormBase.Destroy (Erro58) precisa rodar no path REPORT PREVIEW.
5252:         TRY
5253:             SET SYSMENU TO DEFAULT
5254:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
5255:             CriarMenuPrincipal()
5256:         CATCH
5257:             *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
5258:         ENDTRY
5259: 
5260:         RETURN .T.
5261:     ENDPROC
5262: 
5263:     PROCEDURE Imprimir()
5264:         LOCAL loc_cCursor, loc_cFrx, loc_cTit, loc_cSub, loc_cRes, loc_cFor
5265: 
5266:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5267: 
5268:         IF !USED(loc_cCursor)
5269:             RETURN
5270:         ENDIF
5271: 
5272:         IF USED("cursor_4c_RelFin")
5273:             USE IN cursor_4c_RelFin
5274:         ENDIF
5275:         SELECT 9999999999 AS Ordem, Nopers, SPACE(1) AS Tipo, SaldoDia AS Saldos, SaldoTot AS SaldosP, Debitos, ;
5276:                Creditos, SPACE(10) AS ContaCobs, Grupos, Contas, ContEms, OrdHs, Hists, Hist2s, NFs, Datas, ;
5277:                Vencs, DtEmis, DtBaixa, Titulos, Moedas, SInis, SPACE(50) AS RClis ;
5278:           FROM (loc_cCursor) ;
5279:           INTO CURSOR cursor_4c_RelFin READWRITE
5280: 
5281:         SELECT cursor_4c_RelFin
5282:         GO TOP
5283:         IF EOF()
5284:             MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Impress" + CHR(227) + "o!!!", "Impress" + CHR(227) + "o")
5285:             USE IN cursor_4c_RelFin
5286:             RETURN
5287:         ENDIF
5288: 
5289:         loc_cTit = "Relat" + CHR(243) + "rio Financeiro"
5290:         loc_cSub = PROPER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Filtros.Value)) + " - Ordem: " + ;
5291:                    PROPER(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.List(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.ListIndex))
5292:         loc_cRes = ALLTRIM(SUBSTR(ALLTRIM(THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value), 2))
5293: 
5294:         IF USED("cursor_4c_RelFinCab")
5295:             USE IN cursor_4c_RelFinCab
5296:         ENDIF
5297:         CREATE CURSOR cursor_4c_RelFinCab (Titulo C(80), SubTitulo C(80), Moeda1 C(80), RodRelCC M(4))
5298:         INSERT INTO cursor_4c_RelFinCab (Titulo, SubTitulo, RodRelCC) VALUES (loc_cTit, loc_cSub, loc_cRes)
5299:         GO TOP IN cursor_4c_RelFinCab
5300: 
5301:         loc_cFor = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "0=0", "(Nopers < 9999997) AND (SInis <> 1)")
5302: 
5303:         SELECT cursor_4c_RelFin
5304:         DO CASE
5305:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtEmis"
5306:             INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR &loc_cFor.
5307:         CASE THIS.this_oBusinessObject.this_cOrdem = "Vencs"
5308:             INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR &loc_cFor.
5309:         CASE THIS.this_oBusinessObject.this_cOrdem = "Datas"
5310:             INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR &loc_cFor.
5311:         CASE THIS.this_oBusinessObject.this_cOrdem = "DtBaixa"
5312:             INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR &loc_cFor.
5313:         CASE THIS.this_oBusinessObject.this_cOrdem = "Titulos"
5314:             INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR &loc_cFor.
5315:         CASE THIS.this_oBusinessObject.this_cOrdem = "Hists"
5316:             INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR &loc_cFor.
5317:         CASE THIS.this_oBusinessObject.this_cOrdem = "ContEms"
5318:             INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR &loc_cFor.
5319:         CASE THIS.this_oBusinessObject.this_cOrdem = "Contas"
5320:             INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR &loc_cFor.
5321:         ENDCASE
5322: 
5323:         SELECT cursor_4c_RelFin
5324:         GO TOP
5325: 
5326:         IF !FILE(FULLPATH(loc_cFrx + ".frx"))
5327:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + FULLPATH(loc_cFrx + ".frx"), "Erro")
5328:         ELSE
5329:             THIS.ExecutarReportForm("SigReCgf", "PREVIEW")
5330:         ENDIF
5331: 
5332:         USE IN cursor_4c_RelFinCab
5333:         USE IN cursor_4c_RelFin
5334: 
5335:         SELECT (loc_cCursor)
5336:         GO TOP
5337:     ENDPROC
5338: 
5339:     *--------------------------------------------------------------------------
5340:     * Planilha - transcricao de ThisForm.Planilha: exporta cursor_4c_Dados
5341:     * para XLS/TXT via PUTFILE + COPY TO, igual ao legado (fVerificaPasta/
5342:     * fLimpaTexto ja portadas em utils/functions.prg).
5343:     *--------------------------------------------------------------------------
5344:     PROCEDURE Planilha()
5345:         LOCAL loc_cCursor, loc_cArq, loc_cDeb, loc_cCrd
5346: 
5347:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5348: 
5349:         IF !USED(loc_cCursor)
5350:             RETURN
5351:         ENDIF
5352: 
5353:         loc_cArq = PUTFILE("Nome da Planilha", "", "XLS;TXT")
5354: 
5355:         IF EMPTY(loc_cArq)
5356:             RETURN
5357:         ENDIF
5358: 
5359:         IF fVerificaPasta(loc_cArq, 2)
5360:             loc_cDeb = fLimpaTexto(STRTRAN(PROPER("D" + CHR(233) + "bito"), " ", "_"))
5361:             loc_cCrd = fLimpaTexto(STRTRAN(PROPER("Cr" + CHR(233) + "dito"), " ", "_"))
5362: 
5363:             IF USED("cursor_4c_RelExcel")
5364:                 USE IN cursor_4c_RelExcel
5365:             ENDIF
5366:             SELECT IIF((Nopers < 9999997) AND (SInis <> 1), SPACE(5), "TOTAL") AS Linhas, ;
5367:                    TTOD(DtEmis) AS Emissao, TTOD(Vencs) AS Vencimento, TTOD(Datas) AS Lancamento, ;
5368:                    TTOD(DtBaixa) AS Baixa, Titulos AS Titulo, NFs AS NF, TitBans AS Bancos, ;
5369:                    EspecieNfs AS Especie, IIF(Pagos = "1", "Baixado ", "Pendente") AS Situacao, ;
5370:                    Hists AS Historico, Hist2s AS Historico2, Moedas AS Moeda, Valors AS Valor, ;
5371:                    Debitos AS Debito, Creditos AS Credito, SaldoDia AS Saldo, SaldoTot AS Acumulado, ;
5372:                    GrupEms AS Grp_Emitente, ContEms AS Cta_Emitente, Grupos AS Grp_Portador, Contas AS Cta_Portador, ;
5373:                    SGrupos AS Grp_CCusto, SContas AS Cta_CCusto, GrupAges AS Grp_Agente, ContAges AS Cta_Agente ;
5374:               FROM (loc_cCursor) ;
5375:               INTO CURSOR cursor_4c_RelExcel
5376: 
5377:             SELECT cursor_4c_RelExcel
5378:             GO TOP
5379: 
5380:             IF LOWER(ALLTRIM(JUSTEXT(loc_cArq))) = "xls"
5381:                 COPY TO (loc_cArq) TYPE XLS
5382:             ELSE
5383:                 COPY TO (loc_cArq) DELIMITED WITH "" WITH CHARACTER ";"
5384:             ENDIF
5385: 
5386:             IF FILE(loc_cArq)
5387:                 MsgInfo("Planilha Gerada Com Sucesso!!!", "Gera" + CHR(231) + CHR(227) + "o de Planilha")
5388:             ENDIF
5389: 
5390:             USE IN cursor_4c_RelExcel
5391:         ELSE
5392:             MsgAviso("Ocorreu Um Erro na Gera" + CHR(231) + CHR(227) + "o da Planilha, Verifique" + CHR(10) + ;
5393:                       "O Diret" + CHR(243) + "rio Ou Se a Planilha Se Encontra Em Uso!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
5394:         ENDIF
5395: 
5396:         SELECT (loc_cCursor)
5397:         GO TOP
5398:     ENDPROC
5399: 
5400:     *==========================================================================
5401:     * FASE 8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
5402:     *
5403:     * Os metodos abaixo sao os FUNIS unicos das acoes que o legado espalha
5404:     * entre os Click/When dos CommandGroups e o AfterRowColChange da grade.
5405:     * NENHUM botao novo foi criado (PILAR 1 / "NUNCA inventar"): cada funil e
5406:     * acionado pelo handler do controle que o SCX legado realmente tem.
5407:     *
5408:     *   BtnBuscarClick       <- cmgFiltros.Buttons(1) "Consultar"
5409:     *   BtnCancelarClick     <- cmgRetornar (volta da Page2) e, na Page1,
5410:     *                           cmgFiltros.Buttons(2) "Sair"
5411:     *   BtnEncerrarClick     <- cmgFiltros.Buttons(2) "Sair" (ThisForm.Release)
5412:     *   CarregarLista        <- repintura da grade de resultado (grdDados1)
5413:     *   LimparCampos         <- bloco de limpeza do AfterRowColChange legado
5414:     *   AjustarBotoesPorModo <- PROCEDURE When de btnMovimento / btnRecebe /
5415:     *                           btnFollowUpC / btnFollowUpL / btnImprimir
5416:     *   HabilitarCampos      <- PROCEDURE When "Return .f." dos campos de
5417:     *                           exibicao da pgDados e "Return Empty(<codigo>)"
5418:     *                           dos campos de descricao dos lookups da pgFiltros
5419:     *   FormParaBO/BOParaForm<- transferencia dos filtros da pgFiltros para as
5420:     *                           propriedades do BO e de volta
5421:     *
5422:     * Esta tela NAO tem botao de gravar: o SCX legado nao declara btnSalvar /
5423:     * btnGravar nem mGravaDados - "Consulta Global Financeira" apura o
5424:     * resultado so no cursor local (LocalDados) e os registros que ela abre
5425:     * pertencem a outras entidades, cada uma com seu proprio BO (ver o
5426:     * cabecalho de SIGOPCGFBO.prg). Por isso nao existe BtnSalvarClick aqui.
5427:     *==========================================================================
5428: 
5429:     *--------------------------------------------------------------------------
5430:     * BtnBuscarClick - Acao principal da tela (cmgFiltros.Buttons(1),
5431:     * "Consultar"): valida as faixas de data, executa a consulta e, so com
5432:     * resultado, passa para a pagina de Dados. AlternarPagina(2) e quem
5433:     * repinta a grade (ver CarregarLista).
5434:     *--------------------------------------------------------------------------
5435:     PROCEDURE BtnBuscarClick()
5436:         LOCAL loc_lResultado
5437:         loc_lResultado = .F.
5438: 
5439:         IF THIS.ValidarFiltrosData()
5440:             IF THIS.Processamento()
5441:                 THIS.AlternarPagina(2)
5442:                 loc_lResultado = .T.
5443:             ENDIF
5444:         ENDIF
5445: 
5446:         RETURN loc_lResultado
5447:     ENDPROC
5448: 
5449:     *--------------------------------------------------------------------------
5450:     * BtnCancelarClick - Funil unico de "abandonar a pagina corrente", com o
5451:     * comportamento que o legado da a cada pagina:
5452:     *   Page2 (Dados)   -> volta para os Filtros   (cmgRetornar.Click)
5453:     *   Page1 (Filtros) -> fecha o form            (cmgFiltros.Buttons(2))
5454:     *--------------------------------------------------------------------------
5455:     PROCEDURE BtnCancelarClick()
5456:         IF THIS.pgf_4c_Paginas.ActivePage = 2
5457:             THIS.AlternarPagina(1)
5458:         ELSE
5459:             THIS.BtnEncerrarClick()
5460:         ENDIF
5461: 
5462:         RETURN .T.
5463:     ENDPROC
5464: 
5465:     *--------------------------------------------------------------------------
5466:     * BtnEncerrarClick - Encerra a tela (ThisForm.Release do Click de
5467:     * cmgFiltros.Buttons(2) "Sair"). FormBase.Destroy() cuida da liberacao do
5468:     * BO e da restauracao dos popups do menu.
5469:     *--------------------------------------------------------------------------
5470:     PROCEDURE BtnEncerrarClick()
5471:         THIS.Release()
5472:     ENDPROC
5473: 
5474:     *--------------------------------------------------------------------------
5475:     * CarregarLista - FUNIL unico de repintura da grade de resultado.
5476:     *
5477:     * Processamento() popula cursor_4c_Dados e chama MontarGradeDados()/
5478:     * OrdenaGrade() com a Page2 ainda OCULTA, e Refresh em pagina oculta NAO
5479:     * pinta (regra #21/#46 do CLAUDE.md) - por isso AlternarPagina(2) chama
5480:     * este metodo DEPOIS de trocar o ActivePage.
5481:     *
5482:     * Tambem sincroniza os campos de detalhe e os botoes de acao com a linha
5483:     * corrente: a PRIMEIRA linha exibida nunca dispara AfterRowColChange, e
5484:     * sem isso ela ficaria com os campos/botoes da consulta anterior.
5485:     *--------------------------------------------------------------------------
5486:     PROCEDURE CarregarLista()
5487:         LOCAL loc_cCursor, loc_lResultado
5488:         loc_lResultado = .F.
5489: 
5490:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
5491:             RETURN .F.
5492:         ENDIF
5493: 
5494:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
5495: 
5496:         IF !USED(loc_cCursor)
5497:             RETURN .F.
5498:         ENDIF
5499: 
5500:         SELECT (loc_cCursor)
5501:         GO TOP
5502:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
5503: 
5504:         IF EOF(loc_cCursor)
5505:             THIS.LimparCampos()
5506:             THIS.AjustarBotoesPorModo()
5507:         ELSE
5508:             THIS.GrdDadosAfterRowColChange(1)
5509:         ENDIF
5510: 
5511:         loc_lResultado = .T.
5512:         RETURN loc_lResultado
5513:     ENDPROC
5514: 
5515:     *--------------------------------------------------------------------------
5516:     * AjustarBotoesPorModo - Reproduz os PROCEDURE When dos botoes de acao da
5517:     * pgDados, que no legado sao reavaliados a cada troca de linha:
5518:     *
5519:     *   btnMovimento / btnRecebe / btnFollowUpC / btnFollowUpL
5520:     *       Return (LocalDados.Nopers < 9999998) And (LocalDados.SInis = 0)
5521:     *   btnImprimir
5522:     *       Return (LocalDados.Nopers < 9999998) And (LocalDados.SInis = 0) ;
5523:     *              Or InList(ThisForm.Ordem, [ContEms], [Contas])
5524:     *
5525:     * Sem linha corrente (cursor vazio) os When do legado leem um registro
5526:     * que nao existe - aqui isso equivale a desabilitar as acoes.
5527:     *--------------------------------------------------------------------------
5528:     PROCEDURE AjustarBotoesPorModo()
5529:         LOCAL loc_oPag, loc_oBO, loc_cCursor, loc_lHabilita
5530: 
5531:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
5532:             RETURN
5533:         ENDIF
5534: 
5535:         loc_oBO     = THIS.this_oBusinessObject
5536:         loc_oPag    = THIS.pgf_4c_Paginas.Page2
5537:         loc_cCursor = loc_oBO.this_cCursorDados
5538: 
5539:         IF !USED(loc_cCursor) OR EOF(loc_cCursor)
5540:             loc_lHabilita = .F.
5541:         ELSE
5542:             loc_lHabilita = (loc_oBO.this_nLinNopers < 9999998) AND (loc_oBO.this_nLinSInis = 0)
5543:         ENDIF
5544: 
5545:         loc_oPag.cmd_4c_BtnMovimento.Enabled = loc_lHabilita
5546:         loc_oPag.cmd_4c_BtnRecebe.Enabled    = loc_lHabilita
5547:         loc_oPag.cmd_4c_BtnFollowUpC.Enabled = loc_lHabilita
5548:         loc_oPag.cmd_4c_BtnFollowUpL.Enabled = loc_lHabilita
5549: 
5550:         *-- O When do Imprimir tambem libera quando a ordem corrente e por
5551:         *-- Emitente/Portador (saldo por conta), mesmo em linha sintetica.
5552:         loc_oPag.cmd_4c_BtnImprimir.Enabled = loc_lHabilita OR ;
5553:             INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
5554:     ENDPROC
5555: 
5556:     *--------------------------------------------------------------------------
5557:     * LimparCampos - Bloco de limpeza que o legado executa no inicio do
5558:     * AfterRowColChange de grdDados1: zera os campos de detalhe da pgDados e
5559:     * os quatro indicadores de status (Botao1..Botao4).
5560:     *
5561:     * O legado limpa SEMPRE as 4 descricoes (getDContEms/getDContas/
5562:     * getDSContas/getDContAges) e, SO quando a linha e sintetica (llTot), os
5563:     * outros 14 campos; como o ramo "If Not llTot" reatribui TODOS os 18,
5564:     * limpar os 18 de uma vez produz o MESMO resultado nos dois caminhos.
5565:     *--------------------------------------------------------------------------
5566:     PROTECTED PROCEDURE LimparCampos()
5567:         LOCAL loc_oPag
5568: 
5569:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5570:             RETURN
5571:         ENDIF
5572: 
5573:         loc_oPag = THIS.pgf_4c_Paginas.Page2
5574: 
5575:         loc_oPag.txt_4c_DContEms.Value   = ""
5576:         loc_oPag.txt_4c_DContas.Value    = ""
5577:         loc_oPag.txt_4c_DSContas.Value   = ""
5578:         loc_oPag.txt_4c_DContAges.Value  = ""
5579: 
5580:         loc_oPag.txt_4c_NFs.Value        = ""
5581:         loc_oPag.txt_4c_TitBans.Value    = ""
5582:         loc_oPag.txt_4c_EspecieNfs.Value = ""
5583:         loc_oPag.txt_4c_Hist2s.Value     = ""
5584:         loc_oPag.txt_4c_Emps.Value       = ""
5585:         loc_oPag.txt_4c_ValOcurs.Value   = 0
5586:         loc_oPag.txt_4c_GrupEms.Value    = ""
5587:         loc_oPag.txt_4c_ContEms.Value    = ""
5588:         loc_oPag.txt_4c_Grupo.Value      = ""
5589:         loc_oPag.txt_4c_Contas.Value     = ""
5590:         loc_oPag.txt_4c_SGrupos.Value    = ""
5591:         loc_oPag.txt_4c_SContas.Value    = ""
5592:         loc_oPag.txt_4c_GrupAges.Value   = ""
5593:         loc_oPag.txt_4c_ContAges.Value   = ""
5594: 
5595:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao1.Value = ""
5596:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao2.Value = ""
5597:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao3.Value = ""
5598:         loc_oPag.cnt_4c_Botoes.txt_4c_Botao4.Value = ""
5599:     ENDPROC
5600: 
5601:     *--------------------------------------------------------------------------
5602:     * HabilitarCampos - Aplica, num lugar so, o contrato de digitacao que o
5603:     * legado expressa nos PROCEDURE When de cada campo:
5604:     *
5605:     *   pgDados : TODOS os campos de detalhe declaram "Return .f." no SCX, ou
5606:     *             seja sao SOMENTE EXIBICAO. UNICA excecao fiel: getContEms,
5607:     *             que NAO declara When e por isso continua focavel.
5608:     *   pgFiltros: os campos de DESCRICAO dos lookups declaram
5609:     *             "Return Empty(This.Parent.get<Codigo>.Value)" - a descricao
5610:     *             so aceita digitacao enquanto o CODIGO esta vazio.
5611:     *
5612:     * par_lHabilitar = .T. na pagina de Filtros (filtros digitaveis) e .F. na
5613:     * pagina de Dados (nada a digitar). Chamado pelo funil AlternarPagina().
5614:     *--------------------------------------------------------------------------
5615:     PROCEDURE HabilitarCampos(par_lHabilitar)
5616:         LOCAL loc_oPag1, loc_oPag2, loc_lFiltros
5617: 
5618:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5619:             RETURN
5620:         ENDIF
5621: 
5622:         loc_lFiltros = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
5623:         loc_oPag1    = THIS.pgf_4c_Paginas.Page1
5624:         loc_oPag2    = THIS.pgf_4c_Paginas.Page2
5625: 
5626:         *-- pgFiltros: campos de filtro digitaveis
5627:         loc_oPag1.txt_4c_DtEmiI.ReadOnly     = !loc_lFiltros
5628:         loc_oPag1.txt_4c_DtEmiF.ReadOnly     = !loc_lFiltros
5629:         loc_oPag1.txt_4c_VencsI.ReadOnly     = !loc_lFiltros
5630:         loc_oPag1.txt_4c_VencsF.ReadOnly     = !loc_lFiltros
5631:         loc_oPag1.txt_4c_DatasI.ReadOnly     = !loc_lFiltros
5632:         loc_oPag1.txt_4c_DatasF.ReadOnly     = !loc_lFiltros
5633:         loc_oPag1.txt_4c_DtBxI.ReadOnly      = !loc_lFiltros
5634:         loc_oPag1.txt_4c_DtBxF.ReadOnly      = !loc_lFiltros
5635:         loc_oPag1.txt_4c_Titulos.ReadOnly    = !loc_lFiltros
5636:         loc_oPag1.txt_4c_TitBans.ReadOnly    = !loc_lFiltros
5637:         loc_oPag1.txt_4c_EspecieNfs.ReadOnly = !loc_lFiltros
5638:         loc_oPag1.txt_4c_NFs.ReadOnly        = !loc_lFiltros
5639:         loc_oPag1.txt_4c_CMoes.ReadOnly      = !loc_lFiltros
5640:         loc_oPag1.txt_4c_CMoesC.ReadOnly     = !loc_lFiltros
5641:         loc_oPag1.txt_4c_MoeSaldo.ReadOnly   = !loc_lFiltros
5642:         loc_oPag1.txt_4c_Saldo.ReadOnly      = !loc_lFiltros
5643:         loc_oPag1.txt_4c_CFPublis.ReadOnly   = !loc_lFiltros
5644:         loc_oPag1.txt_4c_Empresa.ReadOnly    = !loc_lFiltros
5645:         loc_oPag1.txt_4c_Filtros.ReadOnly    = !loc_lFiltros
5646:         loc_oPag1.txt_4c_NewFiltro.ReadOnly  = !loc_lFiltros
5647: 
5648:         *-- pgFiltros: When "Return Empty(<codigo>)" dos campos de descricao
5649:         loc_oPag1.txt_4c_DMoes.ReadOnly    = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CMoes.Value)
5650:         loc_oPag1.txt_4c_DMoesC.ReadOnly   = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
5651:         loc_oPag1.txt_4c_DFPublis.ReadOnly = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CFPublis.Value)
5652: 
5653:         *-- pgDados: "Return .f." em todo campo de detalhe (somente exibicao).
5654:         *-- txt_4c_ContEms fica FORA desta lista de proposito - getContEms e o
5655:         *-- unico campo da pgDados que nao declara When no SCX legado.

*-- Linhas 5669 a 5835:
5669:         loc_oPag2.txt_4c_DContAges.ReadOnly  = .T.
5670:         loc_oPag2.txt_4c_Hist2s.ReadOnly     = .T.
5671:         loc_oPag2.txt_4c_TitBans.ReadOnly    = .T.
5672:         loc_oPag2.txt_4c_ValOcurs.ReadOnly   = .T.
5673: 
5674:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao1.ReadOnly = .T.
5675:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao2.ReadOnly = .T.
5676:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao3.ReadOnly = .T.
5677:         loc_oPag2.cnt_4c_Botoes.txt_4c_Botao4.ReadOnly = .T.
5678:     ENDPROC
5679: 
5680:     *--------------------------------------------------------------------------
5681:     * FormParaBO - Espelha TODOS os filtros da tela nas propriedades do
5682:     * Business Object. E a fonte unica de leitura dos controles de filtro:
5683:     * chamado por Processamento() (antes de montar a consulta), por
5684:     * SerializarFiltros() (gravacao do filtro nomeado em SigSyPar) e por
5685:     * RestaurarFiltros() (para preservar o que nao esta no blob salvo).
5686:     *
5687:     * Conversoes explicitas obrigatorias: CheckBox.Value e NUMERICO (0/1) e
5688:     * nao pode ser atribuido direto a property LOGICA; OptionGroup.Value e o
5689:     * INDICE 1-based e vai para property NUMERICA; o TextBox de valor pode
5690:     * trazer CARACTERE conforme o InputMask, dai o VARTYPE antes de usar.
5691:     *--------------------------------------------------------------------------
5692:     PROTECTED PROCEDURE FormParaBO()
5693:         LOCAL loc_oPag1, loc_oPag2, loc_oBO, loc_xSaldo
5694: 
5695:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5696:             RETURN .F.
5697:         ENDIF
5698: 
5699:         loc_oBO   = THIS.this_oBusinessObject
5700:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
5701:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
5702: 
5703:         *-- Faixas de data (ConverterParaData normaliza DATE/DATETIME/CHAR)
5704:         loc_oBO.this_dDtEmiI = ConverterParaData(loc_oPag1.txt_4c_DtEmiI.Value)
5705:         loc_oBO.this_dDtEmiF = ConverterParaData(loc_oPag1.txt_4c_DtEmiF.Value)
5706:         loc_oBO.this_dVencsI = ConverterParaData(loc_oPag1.txt_4c_VencsI.Value)
5707:         loc_oBO.this_dVencsF = ConverterParaData(loc_oPag1.txt_4c_VencsF.Value)
5708:         loc_oBO.this_dDatasI = ConverterParaData(loc_oPag1.txt_4c_DatasI.Value)
5709:         loc_oBO.this_dDatasF = ConverterParaData(loc_oPag1.txt_4c_DatasF.Value)
5710:         loc_oBO.this_dDtBxI  = ConverterParaData(loc_oPag1.txt_4c_DtBxI.Value)
5711:         loc_oBO.this_dDtBxF  = ConverterParaData(loc_oPag1.txt_4c_DtBxF.Value)
5712: 
5713:         *-- Titulo / Titulo Banco / Especie / Nota Fiscal
5714:         loc_oBO.this_cTitulos    = ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
5715:         loc_oBO.this_cTitBans    = ALLTRIM(loc_oPag1.txt_4c_TitBans.Value)
5716:         loc_oBO.this_cEspecieNfs = ALLTRIM(loc_oPag1.txt_4c_EspecieNfs.Value)
5717:         loc_oBO.this_cNFs        = ALLTRIM(loc_oPag1.txt_4c_NFs.Value)
5718: 
5719:         *-- Moeda de filtro / de conversao / do saldo inicial
5720:         loc_oBO.this_cCMoes    = ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
5721:         loc_oBO.this_cDMoes    = ALLTRIM(loc_oPag1.txt_4c_DMoes.Value)
5722:         loc_oBO.this_cCMoesC   = ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value)
5723:         loc_oBO.this_cDMoesC   = ALLTRIM(loc_oPag1.txt_4c_DMoesC.Value)
5724:         loc_oBO.this_cMoeSaldo = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
5725: 
5726:         loc_xSaldo          = loc_oPag1.txt_4c_Saldo.Value
5727:         loc_oBO.this_nSaldo = IIF(VARTYPE(loc_xSaldo) = "N", loc_xSaldo, VAL(TRANSFORM(loc_xSaldo)))
5728: 
5729:         *-- Forma de Publicidade / Empresa
5730:         loc_oBO.this_cCFPublis = ALLTRIM(loc_oPag1.txt_4c_CFPublis.Value)
5731:         loc_oBO.this_cDFPublis = ALLTRIM(loc_oPag1.txt_4c_DFPublis.Value)
5732:         loc_oBO.this_cEmpresa  = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
5733: 
5734:         *-- CheckBox.Value e NUMERICO - converter antes de ir para property logica
5735:         loc_oBO.this_lBrancos  = (loc_oPag1.chk_4c_Brancos.Value = 1)
5736:         loc_oBO.this_lValPends = (loc_oPag1.chk_4c_ValPends.Value = 1)
5737:         loc_oBO.this_lTotais   = (loc_oPag2.chk_4c_Totais.Value = 1)
5738: 
5739:         *-- OptionGroup.Value e o INDICE 1-based do botao selecionado
5740:         loc_oBO.this_nPagos    = loc_oPag1.opt_4c_Pagos.Value
5741:         loc_oBO.this_nOpcao    = loc_oPag1.opt_4c_Opcao.Value
5742:         loc_oBO.this_nCotEm    = loc_oPag1.opt_4c_CotEm.Value
5743:         loc_oBO.this_nCancs    = loc_oPag1.opt_4c_Cancs.Value
5744:         loc_oBO.this_nConcs    = loc_oPag1.opt_4c_Concs.Value
5745:         loc_oBO.this_nProrrogs = loc_oPag1.opt_4c_Prorrogs.Value
5746:         loc_oBO.this_nFilGrd2  = loc_oPag1.opt_4c_FilGrd2.Value
5747: 
5748:         *-- Filtro nomeado (SigSyPar) e ordem corrente da grade.
5749:         *-- this_cOrdem NAO e escrito aqui: a fonte unica dele e
5750:         *-- CboOrdemInteractiveChange(), que traduz o indice do combo no nome
5751:         *-- da coluna usada pelo SET ORDER TO TAG.
5752:         loc_oBO.this_cFiltros   = ALLTRIM(loc_oPag1.txt_4c_Filtros.Value)
5753:         loc_oBO.this_cNewFiltro = ALLTRIM(loc_oPag1.txt_4c_NewFiltro.Value)
5754:         loc_oBO.this_nOrdem     = loc_oPag2.cbo_4c_Ordem.Value
5755: 
5756:         RETURN .T.
5757:     ENDPROC
5758: 
5759:     *--------------------------------------------------------------------------
5760:     * BOParaForm - Caminho inverso de FormParaBO: repoe na tela os filtros
5761:     * guardados nas propriedades do BO. Usado por RestaurarFiltros() ao
5762:     * carregar um filtro nomeado de SigSyPar.
5763:     *
5764:     * OptionGroup/ComboBox sao 1-based: o valor e sempre validado com BETWEEN
5765:     * para nunca atribuir 0 a um controle de indice (regra dos controles
5766:     * 1-based do CLAUDE.md). CheckBox recebe NUMERICO (1/0), nunca .T./.F.
5767:     *--------------------------------------------------------------------------
5768:     PROTECTED PROCEDURE BOParaForm()
5769:         LOCAL loc_oPag1, loc_oPag2, loc_oBO
5770: 
5771:         IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
5772:             RETURN .F.
5773:         ENDIF
5774: 
5775:         loc_oBO   = THIS.this_oBusinessObject
5776:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
5777:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
5778: 
5779:         loc_oPag1.txt_4c_DtEmiI.Value = ConverterParaData(loc_oBO.this_dDtEmiI)
5780:         loc_oPag1.txt_4c_DtEmiF.Value = ConverterParaData(loc_oBO.this_dDtEmiF)
5781:         loc_oPag1.txt_4c_VencsI.Value = ConverterParaData(loc_oBO.this_dVencsI)
5782:         loc_oPag1.txt_4c_VencsF.Value = ConverterParaData(loc_oBO.this_dVencsF)
5783:         loc_oPag1.txt_4c_DatasI.Value = ConverterParaData(loc_oBO.this_dDatasI)
5784:         loc_oPag1.txt_4c_DatasF.Value = ConverterParaData(loc_oBO.this_dDatasF)
5785:         loc_oPag1.txt_4c_DtBxI.Value  = ConverterParaData(loc_oBO.this_dDtBxI)
5786:         loc_oPag1.txt_4c_DtBxF.Value  = ConverterParaData(loc_oBO.this_dDtBxF)
5787: 
5788:         loc_oPag1.txt_4c_Titulos.Value    = loc_oBO.this_cTitulos
5789:         loc_oPag1.txt_4c_TitBans.Value    = loc_oBO.this_cTitBans
5790:         loc_oPag1.txt_4c_EspecieNfs.Value = loc_oBO.this_cEspecieNfs
5791:         loc_oPag1.txt_4c_NFs.Value        = loc_oBO.this_cNFs
5792: 
5793:         loc_oPag1.txt_4c_CMoes.Value    = loc_oBO.this_cCMoes
5794:         loc_oPag1.txt_4c_DMoes.Value    = loc_oBO.this_cDMoes
5795:         loc_oPag1.txt_4c_CMoesC.Value   = loc_oBO.this_cCMoesC
5796:         loc_oPag1.txt_4c_DMoesC.Value   = loc_oBO.this_cDMoesC
5797:         loc_oPag1.txt_4c_MoeSaldo.Value = loc_oBO.this_cMoeSaldo
5798:         loc_oPag1.txt_4c_Saldo.Value    = loc_oBO.this_nSaldo
5799: 
5800:         loc_oPag1.txt_4c_CFPublis.Value = loc_oBO.this_cCFPublis
5801:         loc_oPag1.txt_4c_DFPublis.Value = loc_oBO.this_cDFPublis
5802:         loc_oPag1.txt_4c_Empresa.Value  = loc_oBO.this_cEmpresa
5803: 
5804:         loc_oPag1.chk_4c_Brancos.Value  = IIF(loc_oBO.this_lBrancos, 1, 0)
5805:         loc_oPag1.chk_4c_ValPends.Value = IIF(loc_oBO.this_lValPends, 1, 0)
5806:         loc_oPag2.chk_4c_Totais.Value   = IIF(loc_oBO.this_lTotais, 1, 0)
5807: 
5808:         loc_oPag1.opt_4c_Pagos.Value    = IIF(BETWEEN(loc_oBO.this_nPagos, 1, 3), loc_oBO.this_nPagos, 1)
5809:         loc_oPag1.opt_4c_Opcao.Value    = IIF(BETWEEN(loc_oBO.this_nOpcao, 1, 3), loc_oBO.this_nOpcao, 1)
5810:         loc_oPag1.opt_4c_CotEm.Value    = IIF(BETWEEN(loc_oBO.this_nCotEm, 1, 5), loc_oBO.this_nCotEm, 1)
5811:         loc_oPag1.opt_4c_Cancs.Value    = IIF(BETWEEN(loc_oBO.this_nCancs, 1, 3), loc_oBO.this_nCancs, 1)
5812:         loc_oPag1.opt_4c_Concs.Value    = IIF(BETWEEN(loc_oBO.this_nConcs, 1, 3), loc_oBO.this_nConcs, 1)
5813:         loc_oPag1.opt_4c_Prorrogs.Value = IIF(BETWEEN(loc_oBO.this_nProrrogs, 1, 3), loc_oBO.this_nProrrogs, 1)
5814:         loc_oPag1.opt_4c_FilGrd2.Value  = IIF(BETWEEN(loc_oBO.this_nFilGrd2, 1, 2), loc_oBO.this_nFilGrd2, 1)
5815: 
5816:         loc_oPag1.txt_4c_Filtros.Value   = loc_oBO.this_cFiltros
5817:         loc_oPag1.txt_4c_NewFiltro.Value = loc_oBO.this_cNewFiltro
5818:         loc_oPag2.cbo_4c_Ordem.Value     = IIF(BETWEEN(loc_oBO.this_nOrdem, 1, 8), loc_oBO.this_nOrdem, 1)
5819: 
5820:         *-- O When "Return Empty(<codigo>)" dos campos de descricao depende do
5821:         *-- codigo que acabou de ser reposto - reavaliar o contrato.
5822:         THIS.HabilitarCampos(THIS.pgf_4c_Paginas.ActivePage = 1)
5823: 
5824:         RETURN .T.
5825:     ENDPROC
5826: 
5827:     *--------------------------------------------------------------------------
5828:     * Destroy - FormBase.Destroy() cuida da liberacao do BusinessObject e da
5829:     * restauracao dos popups do menu (Erro58). DODEFAULT() SEMPRE por ultimo.
5830:     *--------------------------------------------------------------------------
5831:     PROCEDURE Destroy()
5832:         DODEFAULT()
5833:     ENDPROC
5834: 
5835: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPCGFBO.prg):
*============================================================================
* SIGOPCGFBO.prg - Business Object para Consulta Global Financeira
*
* Form OPERACIONAL (sem tabela/PK unica) - consulta sobre titulos financeiros
* (SigCdPit) movimentados contra contas (SigCdCli), com filtros amplos de
* data, titulo, moeda, publicidade, empresa e grupos de contas selecionaveis
* em duas grades auxiliares (equivalentes a TmpCliente/TmpCliente2 do legado).
*
* Legado  : SIGOPCGF.SCX (form generico "form", NAO frmcadastro)
* Cursores de trabalho (equivalentes ao LocalDados/LocalTotais/crSigOpOpe/
* TmpCliente/TmpCliente2/TmpContas/crFiltros do legado):
*   cursor_4c_Dados     - resultado da consulta (um registro por titulo)
*   cursor_4c_Totais    - estrutura vazia usada para acumular totalizadores
*   cursor_4c_Tipos     - tipos de operacao de titulo (SigOpOpe) com flag de
*                         selecao (Imps) para o filtro por tipo de movimento
*   cursor_4c_Clientes  - grade 1 de contas/grupos selecionaveis no filtro
*   cursor_4c_Clientes2 - grade 2 de contas/grupos selecionaveis no filtro
*   cursor_4c_Contas    - cache de contas (IClis/RClis) usado pelas grades
*   cursor_4c_Filtros   - filtros nomeados salvos (SigSyPar)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SIGOPCGFBO AS BusinessBase

    *==========================================================================
    * Nomes dos cursores de trabalho (constantes de instancia - usados pelos
    * metodos de carga/consulta criados nas proximas fases)
    *==========================================================================
    this_cCursorDados     = "cursor_4c_Dados"
    this_cCursorTotais    = "cursor_4c_Totais"
    this_cCursorTipos     = "cursor_4c_Tipos"
    this_cCursorClientes  = "cursor_4c_Clientes"
    this_cCursorClientes2 = "cursor_4c_Clientes2"
    this_cCursorContas    = "cursor_4c_Contas"
    this_cCursorFiltros   = "cursor_4c_Filtros"

    *==========================================================================
    * Filtros de data (getDtEmiI/F, getVencsI/F, getDatasI/F, getDtBxI/F)
    *==========================================================================
    this_dDtEmiI = {}    && Emissao - de
    this_dDtEmiF = {}    && Emissao - ate
    this_dVencsI = {}    && Vencimento - de
    this_dVencsF = {}    && Vencimento - ate
    this_dDatasI = {}    && Lancamento - de
    this_dDatasF = {}    && Lancamento - ate
    this_dDtBxI  = {}    && Baixa - de
    this_dDtBxF  = {}    && Baixa - ate

    *==========================================================================
    * Filtros de texto/codigo (getTitulos, getTitBans, getEspecieNfs, getNFs)
    *==========================================================================
    this_cTitulos    = ""    && Titulo (SigCdPit.Titulos)
    this_cTitBans    = ""    && Titulo Banco (SigCdPgr.FPags, busca local fwBuscaSel)
    this_cEspecieNfs = ""    && Especie da NF - codigo (SigCdEsp.Especies)
    this_cNFs        = ""    && Numero da Nota Fiscal

    *==========================================================================
    * Moeda (getCMoes/getDMoes, getCMoesC/getDMoesC, getMoeSaldo)
    *==========================================================================
    this_cCMoes    = ""    && Moeda Filtro - codigo (SigCdMoe.CMoes)
    this_cDMoes    = ""    && Moeda Filtro - descricao (SigCdMoe.DMoes)
    this_cCMoesC   = ""    && Moeda Conversao - codigo (SigCdMoe.CMoes)
    this_cDMoesC   = ""    && Moeda Conversao - descricao (SigCdMoe.DMoes)
    this_cMoeSaldo = ""    && Moeda do Saldo Inicial - codigo (SigCdMoe.CMoes)
    this_nSaldo    = 0     && Saldo Inicial (valor digitado pelo usuario)

    *==========================================================================
    * Publicidade (getCFPublis/getDFPublis)
    *==========================================================================
    this_cCFPublis = ""    && Forma de Publicidade - codigo (SigCdFpb.Cods)
    this_cDFPublis = ""    && Forma de Publicidade - descricao (SigCdFpb.Descs)

    *==========================================================================
    * Empresa (Get_Empresa)
    *==========================================================================
    this_cEmpresa = ""    && Empresa - codigo (SigCdEmp.Cemps)

    *==========================================================================
    * Flags de filtro (chkBrancos, chkValpags, chkTotais)
    *==========================================================================
    this_lBrancos  = .F.    && Branco (chkBrancos) - filtra lancamentos em branco
    this_lValPends = .F.    && Valor Pendente (chkValpags)
    this_lTotais   = .T.    && Exibir Totalizadores (chkTotais)

    *==========================================================================
    * OptionGroups de filtro - indice 1-based, espelha o Value do grupo
    * (optPagos, optOpcao, optCotEm, optCancs, optConcs, optProrrogs,
    * optFilGrd2)
    *==========================================================================
    this_nPagos    = 1    && Pagamento (3 opcoes)
    this_nOpcao    = 1    && Opcao (3 opcoes)
    this_nCotEm    = 1    && Conversao em (5 opcoes)
    this_nCancs    = 1    && Cancelamento (3 opcoes)
    this_nConcs    = 1    && Conciliacao (3 opcoes)
    this_nProrrogs = 1    && Prorrogacao (3 opcoes)
    this_nFilGrd2  = 1    && Filtro da grade 2 (2 opcoes)

    *==========================================================================
    * Ordenacao da grade de resultado (cmbOrdem.Value + ThisForm.Ordem legado)
    *==========================================================================
    this_nOrdem = 1          && Indice selecionado no combo de ordem
    this_cOrdem = "DtEmis"   && Nome da coluna correspondente, usado no SET ORDER

    *==========================================================================
    * Filtro nomeado (getFiltros/getNewFiltro - SigSyPar)
    *==========================================================================
    this_cFiltros   = ""    && Nome do filtro selecionado/carregado
    this_cNewFiltro = ""    && Nome digitado ao cadastrar um novo filtro

    *==========================================================================
    * Totalizadores calculados sobre cursor_4c_Dados (CalcSaldo/CalcSaldoCta)
    *==========================================================================
    this_nSaldoDia = 0
    this_nSaldoTot = 0
    this_nDebitos  = 0
    this_nCreditos = 0

    *==========================================================================
    * Linha corrente de cursor_4c_Dados (equivalente ao registro corrente de
    * LocalDados no legado) - carregada por CarregarDoCursor() quando o
    * usuario seleciona uma linha na grade, e consumida pelos botoes de
    * acao (Movimento/Recebimento/FollowUp/Imprimir) das proximas fases.
    *==========================================================================
    this_nLinNopers     = 0     && Numero da operacao (chave de navegacao)
    this_cLinTipos      = ""    && Tipo do lancamento
    this_nLinSaldoDia   = 0     && Saldo do dia (linha)
    this_nLinSaldoTot   = 0     && Saldo total/progressivo (linha)
    this_nLinDebitos    = 0     && Debito (linha)
    this_nLinCreditos   = 0     && Credito (linha)
    this_cLinContaCobs  = ""    && Conta cobradora
    this_cLinGrupos     = ""    && Grupo da conta
    this_cLinContas     = ""    && Codigo da conta/portador
    this_cLinContEms    = ""    && Codigo do emitente/cliente
    this_cLinOrdHs      = ""    && Ordem do historico
    this_cLinHists      = ""    && Historico
    this_cLinHist2s     = ""    && Historico complementar
    this_cLinNFs        = ""    && Nota Fiscal
    this_dLinDatas      = {}    && Data de lancamento
    this_dLinVencs      = {}    && Data de vencimento
    this_dLinDtEmis     = {}    && Data de emissao
    this_dLinDtBaixa    = {}    && Data de baixa
    this_cLinTitulos    = ""    && Numero do titulo
    this_cLinMoedas     = ""    && Codigo da moeda
    this_nLinSInis      = 0     && Flag "e totalizador/sintetico" (SInis)
    this_cLinRClis      = ""    && Razao social do cliente/emitente
    this_cLinEmps       = ""    && Empresa (chave de movimento)
    this_cLinDopes      = ""    && Documento de origem (chave de movimento)
    this_nLinNumes      = 0     && Numero do movimento (chave de movimento)
    this_cLinVOpers     = ""    && Movimento vinculado (ContEms+Numos)
    this_nLinAcertos    = 0     && Flag de acerto (usado no Recebimento)
    this_cLinGrupEms    = ""    && Grupo do emitente
    this_cLinSGrupos    = ""    && Grupo do centro de custo
    this_cLinSContas    = ""    && Codigo do centro de custo
    this_cLinGrupAges   = ""    && Grupo do agente cobrador
    this_cLinContAges   = ""    && Codigo do agente cobrador
    this_cLinTitBans    = ""    && Titulo no banco (SigCdPgr.FPags)
    this_cLinEspecieNfs = ""    && Especie da Nota Fiscal
    this_nLinValOcurs   = 0     && Valor ocorrido
    this_nLinTitCancs   = 0     && Flag "titulo cancelado" (Botao1)
    this_cLinPagos      = ""    && Flag/codigo de pagamento - "0"=pendente (Botao2)
    this_lLinConcs      = .F.   && Flag "titulo conciliado" (Botao3)
    this_dLinProrrogs   = {}    && Data de prorrogacao, vazia = nao prorrogado (Botao4)

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Form de consulta sem tabela/PK unica (nao eh CRUD) - this_cTabela e
    * this_cCampoChave ficam vazios de proposito; a consulta principal eh
    * montada dinamicamente (varias tabelas) nos metodos das proximas fases.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha CORRENTE de cursor_4c_Dados (grade
    * de resultado da consulta) para as propriedades this_nLin*/this_cLin*/
    * this_dLin*, equivalente a ler LocalDados.<campo> diretamente no legado
    * (AfterRowColChange/Click dos botoes de acao). Chamado pelo Form sempre
    * que a linha selecionada na grade mudar.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF EOF() OR BOF()
            RETURN .F.
        ENDIF

        THIS.this_nLinNopers    = TratarNulo(Nopers, 0)
        THIS.this_cLinTipos     = TratarNulo(Tipos, "")
        THIS.this_nLinSaldoDia  = TratarNulo(SaldoDia, 0)
        THIS.this_nLinSaldoTot  = TratarNulo(SaldoTot, 0)
        THIS.this_nLinDebitos   = TratarNulo(Debitos, 0)
        THIS.this_nLinCreditos  = TratarNulo(Creditos, 0)
        THIS.this_cLinContaCobs = TratarNulo(ContaCobs, "")
        THIS.this_cLinGrupos    = TratarNulo(Grupos, "")
        THIS.this_cLinContas    = TratarNulo(Contas, "")
        THIS.this_cLinContEms   = TratarNulo(ContEms, "")
        THIS.this_cLinOrdHs     = TratarNulo(OrdHs, "")
        THIS.this_cLinHists     = TratarNulo(Hists, "")
        THIS.this_cLinHist2s    = TratarNulo(Hist2s, "")
        THIS.this_cLinNFs       = TratarNulo(NFs, "")
        THIS.this_dLinDatas     = TratarNulo(Datas, {})
        THIS.this_dLinVencs     = TratarNulo(Vencs, {})
        THIS.this_dLinDtEmis    = TratarNulo(DtEmis, {})
        THIS.this_dLinDtBaixa   = TratarNulo(DtBaixa, {})
        THIS.this_cLinTitulos   = TratarNulo(Titulos, "")
        THIS.this_cLinMoedas    = TratarNulo(Moedas, "")
        THIS.this_nLinSInis     = TratarNulo(SInis, 0)
        THIS.this_cLinRClis     = TratarNulo(RClis, "")

        IF TYPE("Emps") = "C"
            THIS.this_cLinEmps = TratarNulo(Emps, "")
        ENDIF
        IF TYPE("Dopes") = "C"
            THIS.this_cLinDopes = TratarNulo(Dopes, "")
        ENDIF
        IF TYPE("Numes") = "N"
            THIS.this_nLinNumes = TratarNulo(Numes, 0)
        ENDIF
        IF TYPE("VOpers") = "C"
            THIS.this_cLinVOpers = TratarNulo(VOpers, "")
        ENDIF
        IF TYPE("Acertos") = "N"
            THIS.this_nLinAcertos = TratarNulo(Acertos, 0)
        ENDIF
        IF TYPE("GrupEms") = "C"
            THIS.this_cLinGrupEms = TratarNulo(GrupEms, "")
        ENDIF
        IF TYPE("SGrupos") = "C"
            THIS.this_cLinSGrupos = TratarNulo(SGrupos, "")
        ENDIF
        IF TYPE("SContas") = "C"
            THIS.this_cLinSContas = TratarNulo(SContas, "")
        ENDIF
        IF TYPE("GrupAges") = "C"
            THIS.this_cLinGrupAges = TratarNulo(GrupAges, "")
        ENDIF
        IF TYPE("ContAges") = "C"
            THIS.this_cLinContAges = TratarNulo(ContAges, "")
        ENDIF
        IF TYPE("TitBans") = "C"
            THIS.this_cLinTitBans = TratarNulo(TitBans, "")
        ENDIF
        IF TYPE("EspecieNfs") = "C"
            THIS.this_cLinEspecieNfs = TratarNulo(EspecieNfs, "")
        ENDIF
        IF TYPE("ValOcurs") = "N"
            THIS.this_nLinValOcurs = TratarNulo(ValOcurs, 0)
        ENDIF
        IF TYPE("TitCancs") = "N"
            THIS.this_nLinTitCancs = TratarNulo(TitCancs, 0)
        ENDIF
        IF TYPE("Pagos") = "C"
            THIS.this_cLinPagos = TratarNulo(Pagos, "")
        ENDIF
        IF TYPE("Concs") = "L"
            THIS.this_lLinConcs = TratarNulo(Concs, .F.)
        ENDIF
        IF TYPE("Prorrogs") = "D" OR TYPE("Prorrogs") = "T"
            THIS.this_dLinProrrogs = TratarNulo(Prorrogs, {})
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar / ExecutarExclusao
    *
    * SIGOPCGF e um form OPERACIONAL de consulta ("Consulta Global
    * Financeira"): o legado apura o resultado so no cursor local LocalDados
    * (via SqlExecute + filtros), nunca grava numa tabela propria do SQL
    * Server - os dados persistidos que ele le/altera pertencem a outras
    * entidades (SigCdPit/SigMvCab/SigCdPgr/SigSyPar, etc), cada uma com seu
    * proprio BO. Por isso esta tela nao tem INSERT/UPDATE/DELETE proprios;
    * o comportamento padrao herdado de BusinessBase (recusar a operacao e
    * expor THIS.this_cMensagemErro) ja e o correto aqui.
    *==========================================================================
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Esta tela realiza consulta financeira; n" + ;
                                   CHR(227) + "o exclui registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Nao ha registro proprio persistido por esta BO
    * (ver Inserir/Atualizar/ExecutarExclusao acima). Mantido PROTECTED para
    * compatibilidade com a interface de BusinessBase, devolvendo o numero
    * da operacao (Nopers) da linha corrente como chave de referencia.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nLinNopers)
    ENDPROC

ENDDEFINE

