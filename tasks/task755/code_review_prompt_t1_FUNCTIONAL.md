# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (38)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_EMP1. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta024' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta024Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta025' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta025Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta026' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta026Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta027' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta027Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta028' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta028Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta029' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta029Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta030' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta030Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta031' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta031Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta032' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta032Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta033' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta033Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta034' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta034Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta035' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta035Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta036' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta036Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarConta037' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarConta037Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta024' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta024Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta025' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta025Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta026' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta026Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta027' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta027Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta028' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta028Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta029' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta029Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta030' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta030Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta031' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta031Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta032' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta032Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta033' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta033Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta034' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta034Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta035' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta035Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta036' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta036Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarNomeConta037' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarNomeConta037Validado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroContaEquipe()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterNomeConta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.pgf_4c_Job()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ResolverControle()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CampoPreenchido()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValorCheck()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Fontes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [LAYOUT-POSITION] Controle 'lbl_01_019' (parent: SIGOPJOB.pgfPagina.pgPagina1): Left original=417 vs migrado 'lbl_4c_Lbl_01_019a' Left=501 (diff=84px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpJob.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4334 linhas total):

*-- Linhas 49 a 367:
49:     *-- Partes da chave posicional EmpDopNums (Emps(3)+Dopes(20)+Str(Numes,6))
50:     *-- do registro de SigMvJbC sendo editado - equivalentes a TprMvCab.Emps/
51:     *-- Dopes/Jobs do cursor global do form pai legado. Preenchidas pelo
52:     *-- chamador antes do Show() (CREATEOBJECT + atribuicao, ou via Init).
53:     this_cEmps  = ""
54:     this_cDopes = ""
55:     this_nNumes = 0
56: 
57:     *-- Guarda de reentrancia do lookup de contas da Page3 (regra #37/#47):
58:     *-- o picker (FormBuscaAuxiliar) eh MODAL e tira o foco do TextBox de
59:     *-- codigo, o que pode redisparar o proprio LostFocus antes do primeiro
60:     *-- Show() terminar.
61:     this_lEmLookupConta = .F.
62: 
63:     *==========================================================================
64:     * Init - Recebe o form pai e a chave do Job sendo complementado.
65:     * Todos os parametros sao opcionais para permitir abertura standalone
66:     * (menu/teste automatizado) sem um form pai real.
67:     *==========================================================================
68:     PROCEDURE Init(par_oFormPai, par_cEmps, par_cDopes, par_nNumes, par_cContas)
69:         IF VARTYPE(par_oFormPai) = "O"
70:             THIS.this_oFormPai = par_oFormPai
71:             IF PEMSTATUS(par_oFormPai, "this_cModoAtual", 5)
72:                 THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
73:             ENDIF
74:         ENDIF
75:         IF VARTYPE(par_cEmps) = "C"
76:             THIS.this_cEmps = par_cEmps
77:         ENDIF
78:         IF VARTYPE(par_cDopes) = "C"
79:             THIS.this_cDopes = par_cDopes
80:         ENDIF
81:         IF VARTYPE(par_nNumes) = "N"
82:             THIS.this_nNumes = par_nNumes
83:         ENDIF
84:         IF VARTYPE(par_cContas) = "C"
85:             THIS.this_cContas = par_cContas
86:         ENDIF
87: 
88:         RETURN DODEFAULT()
89:     ENDPROC
90: 
91:     *==========================================================================
92:     * InicializarForm - Instancia o SigOpJobBO e cria a estrutura visual base
93:     * (PageFrame de 6 abas + botao de retorno). Carga de dados (CarregarDo-
94:     * Cursor/Buscar), campos de identificacao do Job e os controles de cada
95:     * aba ficam para as Fases 5-6 (TextBoxes de dados).
96:     *==========================================================================
97:     PROTECTED PROCEDURE InicializarForm()
98:         LOCAL loc_lSucesso, loc_oErro
99:         loc_lSucesso = .F.
100: 
101:         TRY
102:             SET DATE TO BRITISH
103:             SET CENTURY ON
104: 
105:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpJobBO")
106:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
107: 
108:                 IF !EMPTY(ALLTRIM(THIS.this_cDopes))
109:                     THIS.Caption = "Complementos : " + ALLTRIM(PROPER(THIS.this_cDopes))
110:                 ENDIF
111: 
112:                 THIS.this_oBusinessObject.this_cEmpDopNums = ;
113:                     THIS.this_oBusinessObject.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
114: 
115:                 *-- Define se o BO vai Inserir (registro novo) ou Atualizar
116:                 *-- (complemento ja gravado) - precisa vir ANTES de CmdRetornarClick
117:                 *-- chamar Salvar(), que exige this_lEmEdicao = .T. (regra do
118:                 *-- BusinessBase: Salvar() sem NovoRegistro/EditarRegistro falha).
119:                 THIS.CarregarOuIniciarRegistro()
120: 
121:                 *-- Parametrizacao da OPERACAO (SigOpCdI) e divisao de notas
122:                 *-- da EMPRESA (SigCdEmp). No legado as duas vem prontas na
123:                 *-- data session do form pai (crSigOpCdI) ou de um
124:                 *-- CursorQuery do proprio Init (LocalEmps); aqui o BO
125:                 *-- carrega. Precisam vir ANTES da configuracao visual porque
126:                 *-- alimentam os captions (AplicarTitulosPersonalizados), a
127:                 *-- marcacao de obrigatoriedade (ChecarCamposObrigatorios) e
128:                 *-- a visibilidade dos blocos de equipe
129:                 *-- (AplicarVisibilidadeEquipes).
130:                 THIS.this_oBusinessObject.CarregarConfiguracaoJob(THIS.this_cDopes)
131:                 THIS.this_oBusinessObject.CarregarDivisaoNotas(THIS.this_cEmps)
132: 
133:                 THIS.ConfigurarPageFrame()
134:                 THIS.ConfigurarCabecalhoJob()
135:                 THIS.ConfigurarAbaBriefing()
136:                 THIS.ConfigurarAbaDesafio()
137:                 THIS.ConfigurarAbaEquipes()
138:                 THIS.ConfigurarAbaMateriais()
139:                 THIS.ConfigurarAbaFinanceiroCampos()
140:                 THIS.ConfigurarAbaApresentacao()
141:                 THIS.ConfigurarBotaoRetornar()
142:                 THIS.ConfigurarGridFontes()
143: 
144:                 *-- Depois de TODOS os controles existirem: o metodo varre a
145:                 *-- arvore e nao enxerga o que ainda nao foi criado.
146:                 THIS.VincularChecagemObrigatorios(THIS)
147: 
148:                 THIS.TornarControlesVisiveis(THIS)
149: 
150:                 *-- DEPOIS de TornarControlesVisiveis, que forca Visible = .T.
151:                 *-- em tudo: aplicado antes, a regra de visibilidade dos
152:                 *-- blocos de equipe seria apagada.
153:                 THIS.AplicarTitulosPersonalizados()
154: 
155:                 THIS.CarregarLista()
156:                 THIS.CarregarCabecalhoJob()
157:                 THIS.BOParaForm()
158: 
159:                 THIS.AplicarVisibilidadeEquipes()
160: 
161:                 *-- Por ultimo: o legado chama ChecaObrigs no Init com o
162:                 *-- cursor ja preenchido, e aqui o equivalente e' depois de
163:                 *-- BOParaForm ter levado os valores para os controles.
164:                 THIS.ChecarCamposObrigatorios()
165: 
166:                 *-- Ultima linha do Init legado: ".pgfPagina.ActivePage =
167:                 *-- .pgfPagina.pgPagina1.PageOrder". Hoje e' equivalente ao
168:                 *-- default do VFP (Page1.PageOrder = 1), mas fica explicito
169:                 *-- porque ActivePage e' o PageOrder e NAO a ordem de
170:                 *-- declaracao (regra #31) - neste PageFrame a Page6 tem
171:                 *-- PageOrder 3, entao presumir a ordem de declaracao aqui
172:                 *-- abriria a aba errada se alguem mexer nos PageOrder.
173:                 THIS.pgf_4c_Job.ActivePage = THIS.pgf_4c_Job.Page1.PageOrder
174: 
175:                 loc_lSucesso = .T.
176:             ELSE
177:                 MsgErro("Falha ao criar SigOpJobBO.", "Erro em InicializarForm")
178:             ENDIF
179:         CATCH TO loc_oErro
180:             MsgErro(loc_oErro.Message + CHR(13) + ;
181:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
182:                     "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
183:         ENDTRY
184: 
185:         RETURN loc_lSucesso
186:     ENDPROC
187: 
188:     *==========================================================================
189:     * CarregarOuIniciarRegistro - Decide se o complemento do Job (SigMvJbC)
190:     * ja existe ou e novo, e prepara o BusinessBase de acordo:
191:     *
192:     *   - EXISTE  -> CarregarDoCursor() preenche as propriedades this_* a
193:     *                partir do registro gravado, depois EditarRegistro()
194:     *                (this_lEmEdicao = .T., this_lNovoRegistro = .F.).
195:     *   - NAO EXISTE -> NovoRegistro() (this_lEmEdicao = .T.,
196:     *                   this_lNovoRegistro = .T.) - os valores ficam nos
197:     *                   defaults declarados no BO (campos em branco).
198:     *
199:     * O legado nao precisa dessa distincao porque o TextBox ja esta ligado
200:     * por ControlSource ao cursor BUFFERED do form pai (sempre existe uma
201:     * linha, em branco ou nao, e o TableUpdate acontece quando o movimento
202:     * inteiro e salvo). Nesta arquitetura o BO grava com SQLEXEC explicito
203:     * em CmdRetornarClick, que exige this_lEmEdicao = .T. (BusinessBase.
204:     * Salvar() recusa gravar fora de edicao) e decide Inserir/Atualizar pelo
205:     * this_lNovoRegistro definido aqui.
206:     *
207:     * Sem conexao (modo de teste/validacao de UI) cai direto em
208:     * NovoRegistro() - ConexaoAtiva() ja devolve .F. nesse caso.
209:     *==========================================================================
210:     PROTECTED PROCEDURE CarregarOuIniciarRegistro()
211:         LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_oErro
212:         loc_cAliasTmp = "cursor_4c_JobTmp"
213: 
214:         TRY
215:             IF USED(loc_cAliasTmp)
216:                 USE IN (loc_cAliasTmp)
217:             ENDIF
218: 
219:             loc_nResultado = -1
220:             IF THIS.this_oBusinessObject.ConexaoAtiva()
221:                 loc_cSQL = "SELECT * FROM SigMvJbC WHERE empdopnums = " + ;
222:                     EscaparSQL(THIS.this_oBusinessObject.this_cEmpDopNums)
223:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)
224:             ENDIF
225: 
226:             IF loc_nResultado >= 0 AND USED(loc_cAliasTmp) AND RECCOUNT(loc_cAliasTmp) > 0
227:                 SELECT (loc_cAliasTmp)
228:                 GO TOP
229:                 THIS.this_oBusinessObject.CarregarDoCursor(loc_cAliasTmp)
230:                 THIS.this_oBusinessObject.EditarRegistro()
231:             ELSE
232:                 THIS.this_oBusinessObject.NovoRegistro()
233:             ENDIF
234: 
235:             IF USED(loc_cAliasTmp)
236:                 USE IN (loc_cAliasTmp)
237:             ENDIF
238:         CATCH TO loc_oErro
239:             MsgErro(loc_oErro.Message + CHR(13) + ;
240:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
241:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarOuIniciarRegistro")
242:         ENDTRY
243:     ENDPROC
244: 
245:     *==========================================================================
246:     * ConfigurarPageFrame - Cria pgf_4c_Job com as 6 abas do legado
247:     * (pgfPagina.pgPagina1..pgPagina6). Tabs=.T. porque o SCX nao tem nenhum
248:     * CommandGroup/OptionGroup navegando entre paginas (so cmdRetornar, que
249:     * fecha o form) - a navegacao eh pelas abas nativas mesmo.
250:     *
251:     * Posicoes EXATAS do dump do SCX legado (tasks\task755\layout.json):
252:     * pgfPagina Top=130, Left=-1, Width=1005, Height=473.
253:     *
254:     * Captions, fonte, cores e Picture de cada Page vem do dump do SCX
255:     * (bloco "Page<N>.*" de SIGOPJOB.pgfPagina) - transcritos LITERALMENTE.
256:     *
257:     * ATENCAO (regra #31): o PageOrder do legado NAO eh a ordem de declaracao.
258:     * pgPagina6 ("Apresentacao") tem PageOrder = 3, e por isso pgPagina3/4/5
259:     * aparecem em 4/5/6. Medido no VFP9 (automation\medir_pageorder_755.prg):
260:     * UMA atribuicao .Page6.PageOrder = 3 empurra Page3/4/5 para 4/5/6 e
261:     * reproduz exatamente a ordem do legado; o acesso por NOME (.Page3,
262:     * .Page6) continua apontando para o mesmo objeto depois disso, entao os
263:     * metodos Configurar*/Carregar* nao mudam.
264:     *
265:     * O PageFrame NAO recebe FontName/FontSize nem as Pages recebem Visible:
266:     * nenhuma das duas classes tem essas propriedades (medido em
267:     * automation\propriedades_baseclasses.txt) e a atribuicao abortaria este
268:     * metodo no meio, deixando o PageFrame sem Caption e invisivel (regra #33).
269:     * A fonte do legado mora na PAGE, que tem FontBold/FontName/FontSize.
270:     *==========================================================================
271:     PROTECTED PROCEDURE ConfigurarPageFrame()
272:         LOCAL loc_oErro, loc_cFundo, loc_nI, loc_oPg
273:         TRY
274:             loc_cFundo = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
275: 
276:             THIS.AddObject("pgf_4c_Job", "PageFrame")
277:             WITH THIS.pgf_4c_Job
278:                 .Top        = 130
279:                 .Left       = -1
280:                 .Width      = 1005
281:                 .Height     = 473
282:                 .PageCount  = 6
283:                 .Tabs       = .T.
284:                 .Visible    = .T.
285: 
286:                 *-- Captions EXATOS do dump (Page<N>.Caption)
287:                 .Page1.Caption = "Briefing"
288:                 .Page2.Caption = "Briefing Continua" + CHR(231) + CHR(227) + "o"
289:                 .Page3.Caption = "Informa" + CHR(231) + CHR(245) + "es Gerais"
290:                 .Page4.Caption = "Informa" + CHR(231) + CHR(245) + "es Gerais Continua" + ;
291:                                  CHR(231) + CHR(227) + "o"
292:                 .Page5.Caption = "Controladoria / Fiscal"
293:                 .Page6.Caption = "Apresenta" + CHR(231) + CHR(227) + "o"
294: 
295:                 *-- Ordem das abas do legado: pgPagina6 vem na 3a posicao
296:                 .Page6.PageOrder = 3
297:             ENDWITH
298: 
299:             *-- Fonte/cores/fundo de cada Page (Page<N>.FontBold/FontName/
300:             *-- FontSize/BackColor/ForeColor/Picture do dump, iguais nas 6)
301:             FOR loc_nI = 1 TO THIS.pgf_4c_Job.PageCount
302:                 loc_oPg = EVALUATE("THIS.pgf_4c_Job.Page" + TRANSFORM(loc_nI))
303:                 WITH loc_oPg
304:                     .FontBold  = .T.
305:                     .FontName  = "Tahoma"
306:                     .FontSize  = 8
307:                     .BackColor = RGB(255, 255, 255)
308:                     .ForeColor = RGB(90, 90, 90)
309:                     *-- Sem guard IF FILE(): .Picture inexistente falha em
310:                     *-- SILENCIO (regra #25) e o guard so esconderia o
311:                     *-- problema. O arquivo foi conferido no acervo legado.
312:                     .Picture = loc_cFundo
313:                 ENDWITH
314:             ENDFOR
315:         CATCH TO loc_oErro
316:             MsgErro(loc_oErro.Message + CHR(13) + ;
317:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
318:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPageFrame")
319:         ENDTRY
320:     ENDPROC
321: 
322:     *==========================================================================
323:     * ConfigurarAbaBriefing - Page1 ("Briefing") - campos Jb_001/002/017..023
324:     * (datas) e Jb_003..008/021..023 (texto). Posicoes EXATAS do dump
325:     * (tasks\task755\layout.json). Nomes conforme tasks\task755\mapeamento.json.
326:     *==========================================================================
327:     PROTECTED PROCEDURE ConfigurarAbaBriefing()
328:         LOCAL loc_oPag, loc_oErro
329:         TRY
330:             loc_oPag = THIS.pgf_4c_Job.Page1
331: 
332:             *-- Apresentacao (data) + Orcamento (data)
333:             loc_oPag.AddObject("lbl_4c_Lbl_01_001", "Label")
334:             WITH loc_oPag.lbl_4c_Lbl_01_001
335:                 .Top = 7
336:                 .Left = 13
337:                 .Width = 90
338:                 .Height = 15
339:                 .Alignment = 0
340:                 .AutoSize = .F.
341:                 .BackStyle = 0
342:                 .ForeColor = RGB(90, 90, 90)
343:                 .FontName = "Tahoma"
344:                 .FontSize = 8
345:                 .Caption = "Apresenta" + CHR(231) + CHR(227) + "o"
346:             ENDWITH
347: 
348:             loc_oPag.AddObject("txt_4c__01_001", "TextBox")
349:             WITH loc_oPag.txt_4c__01_001
350:                 .Top = 22
351:                 .Left = 13
352:                 .Width = 90
353:                 .Height = 23
354:                 .Value = {}
355:             ENDWITH
356: 
357:             loc_oPag.AddObject("lbl_4c_Lbl_01_002", "Label")
358:             WITH loc_oPag.lbl_4c_Lbl_01_002
359:                 .Top = 7
360:                 .Left = 112
361:                 .Width = 90
362:                 .Height = 15
363:                 .Alignment = 0
364:                 .AutoSize = .F.
365:                 .BackStyle = 0
366:                 .ForeColor = RGB(90, 90, 90)
367:                 .FontName = "Tahoma"

*-- Linhas 569 a 709:
569:         CATCH TO loc_oErro
570:             MsgErro(loc_oErro.Message + CHR(13) + ;
571:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
572:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaBriefing")
573:         ENDTRY
574:     ENDPROC
575: 
576:     *==========================================================================
577:     * AdicionarBlocoMemoBriefing - Helper para o par Label+EditBox (482x90)
578:     * repetido 4 vezes em 2 colunas na Page1 (Briefing).
579:     *==========================================================================
580:     PROTECTED PROCEDURE AdicionarBlocoMemoBriefing(par_oPag, par_cNomeEdit, par_cNomeLbl, par_nTop, par_nLeft, par_cCaption)
581:         LOCAL loc_oLbl, loc_oEdt
582: 
583:         par_oPag.AddObject(par_cNomeLbl, "Label")
584:         loc_oLbl = EVALUATE("par_oPag." + par_cNomeLbl)
585:         WITH loc_oLbl
586:             .Top = par_nTop - 15
587:             .Left = par_nLeft
588:             .Width = 482
589:             .Height = 15
590:             .Alignment = 0
591:             .AutoSize = .F.
592:             .BackStyle = 0
593:             .ForeColor = RGB(90, 90, 90)
594:             .FontName = "Tahoma"
595:             .FontSize = 8
596:             .Caption = par_cCaption
597:         ENDWITH
598: 
599:         par_oPag.AddObject(par_cNomeEdit, "EditBox")
600:         loc_oEdt = EVALUATE("par_oPag." + par_cNomeEdit)
601:         WITH loc_oEdt
602:             .Top = par_nTop
603:             .Left = par_nLeft
604:             .Width = 482
605:             .Height = 90
606:             .ScrollBars = 2
607:             .Value = ""
608:         ENDWITH
609:     ENDPROC
610: 
611:     *==========================================================================
612:     * ConfigurarAbaDesafio - Page2 ("Desafio / Objetivos") - campos Jb_009..016,
613:     * todos memos de 482x90 em 2 colunas x 4 linhas (mesmo padrao da Page1).
614:     *==========================================================================
615:     PROTECTED PROCEDURE ConfigurarAbaDesafio()
616:         LOCAL loc_oPag, loc_oErro
617:         TRY
618:             loc_oPag = THIS.pgf_4c_Job.Page2
619: 
620:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_009", "lbl_4c_Lbl_01_009", ;
621:                 23, 13, "Desafio (o que queremos alcan" + CHR(231) + "ar, em " + CHR(250) + "ltima an" + CHR(225) + "lise, para o cliente)")
622:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_010", "lbl_4c_Lbl_01_010", ;
623:                 23, 505, "Objetivos (detalhamento dos objetivos)")
624:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_011", "lbl_4c_Lbl_01_011", ;
625:                 131, 13, "Tom de voz (como " + CHR(233) + " a linguagem que deve ser passada)")
626:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_012", "lbl_4c_Lbl_01_012", ;
627:                 131, 505, "Inspira" + CHR(231) + CHR(245) + "es (o que pode ser trabalhado relacionado ao objetivo e target)")
628:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_013", "lbl_4c_Lbl_01_013", ;
629:                 239, 13, "Cliente (expectativas, coment" + CHR(225) + "rios do cliente sobre o job em reuni" + CHR(227) + "o, fone e-mail)")
630:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_014", "lbl_4c_Lbl_01_014", ;
631:                 239, 505, "Sugest" + CHR(245) + "es / obrigatoriedades e/ou restri" + CHR(231) + CHR(245) + "es")
632:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_015", "lbl_4c_Lbl_01_015", ;
633:                 347, 13, "Comunica" + CHR(231) + CHR(227) + "o / pe" + CHR(231) + "as obrigat" + CHR(243) + "rias")
634:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_016", "lbl_4c_Lbl_01_016", ;
635:                 347, 505, "Informa" + CHR(231) + CHR(245) + "es do local do evento (caracter" + CHR(237) + "sticas, restri" + CHR(231) + CHR(245) + "es de montagem, plantas)")
636:         CATCH TO loc_oErro
637:             MsgErro(loc_oErro.Message + CHR(13) + ;
638:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
639:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaDesafio")
640:         ENDTRY
641:     ENDPROC
642: 
643:     *==========================================================================
644:     * ConfigurarAbaEquipes - Page3, cuja aba se chama "Informacoes Gerais" no
645:     * legado (Page3.Caption do dump; o nome deste metodo descreve o CONTEUDO).
646:     * Traz os dois blocos de equipe do legado (cntEmp1 = "P&G" e
647:     * cntEmp2 = "SRCOM"), cada um com 7 linhas de Funcao / Nome / Codigo, mais
648:     * a faixa "Tipo de Projeto" / "Tipo de Desenvolvimento" abaixo da linha
649:     * divisoria.
650:     *
651:     * Posicoes/propriedades EXATAS do dump (SIGOPJOB.pgfPagina.pgPagina3.*).
652:     * Nomes conforme tasks\task755\mapeamento.json.
653:     *
654:     * Cada linha tem DOIS TextBox, como no legado:
655:     *   get_01_0NNa (Left=2, Width=355)  - NOME da conta, SEM ControlSource no
656:     *                                      SCX (preenchido por codigo a partir
657:     *                                      de SigCdCli.RClis - char(50))
658:     *   get_01_0NN  (Left=360, Width=80) - CODIGO, ControlSource
659:     *                                      "crSigMvJbC.Jb_0NN" (char(10))
660:     * O MaxLength vem da LARGURA DA COLUNA no schema (10 e 50), NUNCA do
661:     * Width em pixels (regra #19).
662:     *
663:     * A ordem de tabulacao do legado entra no NOME antes do CODIGO
664:     * (get_01_024a TabIndex=3, get_01_024 TabIndex=4) - transcrita.
665:     *
666:     * Os lookups (Valid/fwBuscaInt sobre crEquipes nos dois campos de cada
667:     * linha) sao da fase de lookups; aqui entra a superficie de dados.
668:     *==========================================================================
669:     PROTECTED PROCEDURE ConfigurarAbaEquipes()
670:         LOCAL loc_oPag, loc_oCnt, loc_oErro
671:         TRY
672:             loc_oPag = THIS.pgf_4c_Job.Page3
673: 
674:             *------------------------------------------------------------------
675:             * cntEmp1 - "P&G"
676:             *------------------------------------------------------------------
677:             loc_oPag.AddObject("cnt_4c_Emp1", "Container")
678:             WITH loc_oPag.cnt_4c_Emp1
679:                 .Top = 4
680:                 .Left = 23
681:                 .Width = 442
682:                 .Height = 305
683:                 .BackStyle = 0
684:                 .BorderWidth = 0
685:                 .SpecialEffect = 0
686:                 .Visible     = .T.
687:             ENDWITH
688:             loc_oCnt = loc_oPag.cnt_4c_Emp1
689: 
690:             loc_oCnt.AddObject("lbl_4c_Lbl_02_001", "Label")
691:             WITH loc_oCnt.lbl_4c_Lbl_02_001
692:                 .Top = 2
693:                 .Left = 2
694:                 .Width = 40
695:                 .Height = 15
696:                 .Alignment = 0
697:                 .AutoSize = .F.
698:                 .BackStyle = 0
699:                 .ForeColor = RGB(90, 90, 90)
700:                 .FontName = "Tahoma"
701:                 .FontSize = 8
702:                 .FontBold = .T.
703:                 .TabIndex = 1
704:                 .Caption = "P&G"
705:             ENDWITH
706: 
707:             *-- Atendimento
708:             loc_oCnt.AddObject("lbl_4c_Lbl_01_024", "Label")
709:             WITH loc_oCnt.lbl_4c_Lbl_01_024

*-- Linhas 1377 a 1928:
1377:             * No migrado os dois vao no LostFocus do respectivo campo (regra
1378:             * #47 - o handler nao testa tecla, logo nao pode ficar em
1379:             * KeyPress), ligados ao funil THIS.AbrirLookupConta por wrappers
1380:             * finos. O InteractiveChange do campo de codigo reavalia o When
1381:             * do campo de nome da mesma linha.
1382:             *------------------------------------------------------------------
1383:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_024, "LostFocus", THIS, "ValidarConta024")
1384:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_025, "LostFocus", THIS, "ValidarConta025")
1385:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_026, "LostFocus", THIS, "ValidarConta026")
1386:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_027, "LostFocus", THIS, "ValidarConta027")
1387:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_028, "LostFocus", THIS, "ValidarConta028")
1388:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_029, "LostFocus", THIS, "ValidarConta029")
1389:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_030, "LostFocus", THIS, "ValidarConta030")
1390:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_031, "LostFocus", THIS, "ValidarConta031")
1391:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_032, "LostFocus", THIS, "ValidarConta032")
1392:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_033, "LostFocus", THIS, "ValidarConta033")
1393:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_034, "LostFocus", THIS, "ValidarConta034")
1394:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_035, "LostFocus", THIS, "ValidarConta035")
1395:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_036, "LostFocus", THIS, "ValidarConta036")
1396:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_037, "LostFocus", THIS, "ValidarConta037")
1397: 
1398:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_024a, "LostFocus", THIS, "ValidarNomeConta024")
1399:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_025a, "LostFocus", THIS, "ValidarNomeConta025")
1400:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_026a, "LostFocus", THIS, "ValidarNomeConta026")
1401:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_027a, "LostFocus", THIS, "ValidarNomeConta027")
1402:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_028a, "LostFocus", THIS, "ValidarNomeConta028")
1403:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_029a, "LostFocus", THIS, "ValidarNomeConta029")
1404:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_030a, "LostFocus", THIS, "ValidarNomeConta030")
1405:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_031a, "LostFocus", THIS, "ValidarNomeConta031")
1406:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_032a, "LostFocus", THIS, "ValidarNomeConta032")
1407:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_033a, "LostFocus", THIS, "ValidarNomeConta033")
1408:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_034a, "LostFocus", THIS, "ValidarNomeConta034")
1409:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_035a, "LostFocus", THIS, "ValidarNomeConta035")
1410:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_036a, "LostFocus", THIS, "ValidarNomeConta036")
1411:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_037a, "LostFocus", THIS, "ValidarNomeConta037")
1412: 
1413:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_024, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1414:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_025, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1415:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_026, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1416:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_027, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1417:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_028, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1418:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_029, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1419:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_030, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1420:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_031, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1421:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_032, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1422:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_033, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1423:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_034, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1424:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_035, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1425:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_036, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1426:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_037, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1427:         CATCH TO loc_oErro
1428:             MsgErro(loc_oErro.Message + CHR(13) + ;
1429:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1430:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaEquipes")
1431:         ENDTRY
1432:     ENDPROC
1433: 
1434:     *==========================================================================
1435:     * ObterFiltroContaEquipe - Universo do lookup de conta de equipe.
1436:     *
1437:     * O legado NAO busca em SigCdCli inteiro: o Init monta o cursor crEquipes
1438:     * com
1439:     *     Select a.IClis, a.RClis
1440:     *       From SigCdCli a, SigCdGcr b
1441:     *      Where a.Grupos = b.Codigos And b.Coletors = 8   && Atendimento
1442:     * e TODO Locate/fwBuscaInt das 14 linhas roda sobre esse cursor. O filtro
1443:     * eh REGRA DE NEGOCIO (so contas do grupo "Atendimento" podem ocupar os
1444:     * papeis de equipe) e eh transcrito aqui como condicao do 9o parametro
1445:     * (par_cFiltro) do FormBuscaAuxiliar - que o aplica nos TRES caminhos
1446:     * dele: match exato, LIKE prefixo e fallback show-all.
1447:     *
1448:     * Vai como subconsulta (nao JOIN) porque par_cFiltro eh colado dentro de
1449:     * um WHERE sobre uma tabela unica. Colunas conferidas em docs/schema.sql:
1450:     * SigCdCli.grupos char(10), SigCdGcr.codigos char(10),
1451:     * SigCdGcr.coletors numeric(2,0).
1452:     *==========================================================================
1453:     PROTECTED FUNCTION ObterFiltroContaEquipe()
1454:         RETURN "Grupos IN (SELECT Codigos FROM SigCdGcr WHERE Coletors = 8)"
1455:     ENDFUNC
1456: 
1457:     *==========================================================================
1458:     * AbrirLookupConta - Nucleo do lookup de conta (equipe) usado pelas 14
1459:     * linhas da Page3, nos DOIS sentidos que o legado tem.
1460:     *
1461:     * Equivale ao Valid de cada get_01_0NN (campo de CODIGO, par_cCampo =
1462:     * "Iclis") e ao Valid de cada get_01_0NNa (campo de NOME, par_cCampo =
1463:     * "Rclis"): o legado faz Locate em crEquipes pelo campo correspondente e,
1464:     * sem match (Eof), abre fwBuscaInt sobre o MESMO campo. Aqui o papel do
1465:     * crEquipes + fwBuscaInt eh feito pelo FormBuscaAuxiliar canonico (regras
1466:     * #36/#37), que ja executa o match EXATO no proprio Init - por isso NAO se
1467:     * duplica a checagem de existencia com um SQLEXEC proprio antes do picker.
1468:     *
1469:     * Os DOIS campos da linha sao escritos em qualquer um dos caminhos, como
1470:     * no legado (get_01_0NN.Value e get_01_0NNa.Value sao atribuidos juntos),
1471:     * e os dois sao limpos quando nada eh escolhido - transcricao do
1472:     * "If (Lastkey() <> 27) ... Else ... = [] / = [] / EndIf". Nao ha MsgAviso
1473:     * em nenhum ramo: o picker eh o proprio feedback (regra #50).
1474:     *
1475:     * Campo VAZIO nao abre picker: o legado abriria (Padr([],10) nunca casa em
1476:     * crEquipes), mas isso faz o dialogo subir a cada Tab por cada um dos 14
1477:     * papeis nao preenchidos. Mantido o guard de vazio, que eh o padrao do
1478:     * projeto para lookup em LostFocus (regras #47/#50) e ja era o
1479:     * comportamento desta tela.
1480:     *
1481:     * PUBLIC (BINDEVENT exige metodo publico - regra #3). Guarda de
1482:     * reentrancia: o picker eh MODAL, tira o foco do TextBox e redisparia o
1483:     * proprio LostFocus. Save/restore (nao set/clear) porque os wrappers de
1484:     * codigo e de nome compartilham este funil e o restore nao pode liberar a
1485:     * flag cedo demais caso um dia se encadeiem (regra #47).
1486:     *==========================================================================
1487:     PROCEDURE AbrirLookupConta(par_oTxtCod, par_oTxtNome, par_cCampo)
1488:         LOCAL loc_cValor, loc_cCampo, loc_oBusca, loc_lEmLookupAnt, loc_oErro
1489: 
1490:         IF THIS.this_lEmLookupConta
1491:             RETURN
1492:         ENDIF
1493:         IF VARTYPE(par_oTxtCod) != "O" OR VARTYPE(par_oTxtNome) != "O"
1494:             RETURN
1495:         ENDIF
1496: 
1497:         loc_cCampo = IIF(VARTYPE(par_cCampo) = "C" AND !EMPTY(par_cCampo), ;
1498:                          ALLTRIM(par_cCampo), "Iclis")
1499: 
1500:         loc_lEmLookupAnt         = THIS.this_lEmLookupConta
1501:         THIS.this_lEmLookupConta = .T.
1502:         TRY
1503:             *-- O valor pesquisado eh o do campo em que o usuario digitou:
1504:             *-- codigo quando o lookup partiu de get_01_0NN, nome quando
1505:             *-- partiu de get_01_0NNa.
1506:             IF UPPER(loc_cCampo) == "RCLIS"
1507:                 loc_cValor = ALLTRIM(par_oTxtNome.Value)
1508:             ELSE
1509:                 loc_cValor = ALLTRIM(par_oTxtCod.Value)
1510:             ENDIF
1511: 
1512:             IF EMPTY(loc_cValor)
1513:                 *-- Campo de origem vazio: nada a resolver. Limpa so o PAR
1514:                 *-- (codigo vazio nao pode ficar com nome preenchido, e nome
1515:                 *-- vazio com codigo preenchido eh resolvido pelo lookup de
1516:                 *-- codigo), sem abrir dialogo.
1517:                 IF UPPER(loc_cCampo) == "RCLIS"
1518:                     IF EMPTY(ALLTRIM(par_oTxtCod.Value))
1519:                         par_oTxtNome.Value = ""
1520:                     ENDIF
1521:                 ELSE
1522:                     par_oTxtNome.Value = ""
1523:                 ENDIF
1524:             ELSE
1525:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1526:                     "SigCdCli", "cursor_4c_BuscaConta", loc_cCampo, loc_cValor, ;
1527:                     "Sele" + CHR(231) + CHR(227) + "o de Filtros", .F., .T., ;
1528:                     THIS.ObterFiltroContaEquipe())
1529: 
1530:                 IF VARTYPE(loc_oBusca) = "O"
1531:                     IF !loc_oBusca.this_lAchouRegistro
1532:                         *-- Ordem das colunas igual a do legado: o campo
1533:                         *-- pesquisado vem primeiro em cada um dos dois Valid.
1534:                         IF UPPER(loc_cCampo) == "RCLIS"
1535:                             loc_oBusca.mAddColuna("Rclis", "", "Nome")
1536:                             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1537:                         ELSE
1538:                             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1539:                             loc_oBusca.mAddColuna("Rclis", "", "Nome")
1540:                         ENDIF
1541:                         loc_oBusca.Show()
1542:                     ENDIF
1543: 
1544:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1545:                         SELECT cursor_4c_BuscaConta
1546:                         par_oTxtCod.Value  = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Iclis, ""))
1547:                         par_oTxtNome.Value = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Rclis, ""))
1548:                     ELSE
1549:                         *-- Legado: ESC / nada escolhido limpa os DOIS campos
1550:                         *-- da linha, nao so a descricao.
1551:                         par_oTxtCod.Value  = ""
1552:                         par_oTxtNome.Value = ""
1553:                     ENDIF
1554: 
1555:                     IF USED("cursor_4c_BuscaConta")
1556:                         USE IN cursor_4c_BuscaConta
1557:                     ENDIF
1558:                     loc_oBusca.Release()
1559:                 ENDIF
1560:             ENDIF
1561: 
1562:             *-- Legado fecha os dois Valid com ".Refresh" nos dois campos.
1563:             par_oTxtCod.Refresh()
1564:             par_oTxtNome.Refresh()
1565: 
1566:             *-- Reaplica o When de get_01_0NNa, que depende do codigo recem
1567:             *-- resolvido ("Empty(This.Parent.get_01_0NN.Value) And ...").
1568:             THIS.AtualizarEstadoContasEquipe()
1569:         CATCH TO loc_oErro
1570:             MsgErro(loc_oErro.Message + CHR(13) + ;
1571:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1572:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupConta")
1573:         ENDTRY
1574:         THIS.this_lEmLookupConta = loc_lEmLookupAnt
1575:     ENDPROC
1576: 
1577:     *==========================================================================
1578:     * AtualizarEstadoContasEquipe - Reproduz o "PROCEDURE When" dos 14 campos
1579:     * de NOME da Page3:
1580:     *     Return Empty(This.Parent.get_01_0NN.Value) And
1581:     *            InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
1582:     * ou seja: o nome so aceita digitacao enquanto o codigo da MESMA linha
1583:     * esta vazio (resolvido o codigo, a descricao passa a ser so exibicao).
1584:     *
1585:     * Vive num metodo PUBLIC unico chamado pelo funil do lookup, pelo
1586:     * BOParaForm e por BINDEVENT InteractiveChange dos campos de codigo
1587:     * (regra #45.3) - BINDEVENT em "When" nao serve porque o retorno do
1588:     * delegate eh descartado e nao bloquearia a edicao.
1589:     *==========================================================================
1590:     PROCEDURE AtualizarEstadoContasEquipe()
1591:         LOCAL loc_oCnt1, loc_oCnt2, loc_lModoEdicao, loc_oErro
1592: 
1593:         TRY
1594:             loc_oCnt1       = THIS.pgf_4c_Job.Page3.cnt_4c_Emp1
1595:             loc_oCnt2       = THIS.pgf_4c_Job.Page3.cnt_4c_Emp2
1596:             loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1597: 
1598:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_024, loc_oCnt1.txt_4c__01_024a, loc_lModoEdicao)
1599:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_025, loc_oCnt1.txt_4c__01_025a, loc_lModoEdicao)
1600:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_026, loc_oCnt1.txt_4c__01_026a, loc_lModoEdicao)
1601:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_027, loc_oCnt1.txt_4c__01_027a, loc_lModoEdicao)
1602:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_028, loc_oCnt1.txt_4c__01_028a, loc_lModoEdicao)
1603:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_029, loc_oCnt1.txt_4c__01_029a, loc_lModoEdicao)
1604:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_030, loc_oCnt1.txt_4c__01_030a, loc_lModoEdicao)
1605: 
1606:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_031, loc_oCnt2.txt_4c__01_031a, loc_lModoEdicao)
1607:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_032, loc_oCnt2.txt_4c__01_032a, loc_lModoEdicao)
1608:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_033, loc_oCnt2.txt_4c__01_033a, loc_lModoEdicao)
1609:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_034, loc_oCnt2.txt_4c__01_034a, loc_lModoEdicao)
1610:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_035, loc_oCnt2.txt_4c__01_035a, loc_lModoEdicao)
1611:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_036, loc_oCnt2.txt_4c__01_036a, loc_lModoEdicao)
1612:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_037, loc_oCnt2.txt_4c__01_037a, loc_lModoEdicao)
1613:         CATCH TO loc_oErro
1614:             MsgErro(loc_oErro.Message + CHR(13) + ;
1615:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1616:                     "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarEstadoContasEquipe")
1617:         ENDTRY
1618:     ENDPROC
1619: 
1620:     *==========================================================================
1621:     * AjustarNomeContaEquipe - Aplica a UMA linha o When do campo de nome.
1622:     *
1623:     * O campo de CODIGO (get_01_0NN) NAO recebe tratamento: no dump o legado
1624:     * declara nele apenas Valid e LostFocus - nao ha When - logo ele eh
1625:     * sempre editavel, inclusive em VISUALIZAR. Desabilitar por modo seria
1626:     * inventar comportamento que o legado nao tem (PILAR 1).
1627:     *
1628:     * IFs aninhados em vez de AND encadeado porque VFP9 nao faz
1629:     * short-circuit: ALLTRIM teria de ser avaliado mesmo com o modo fora de
1630:     * edicao.
1631:     *==========================================================================
1632:     PROTECTED PROCEDURE AjustarNomeContaEquipe(par_oTxtCod, par_oTxtNome, par_lModoEdicao)
1633:         LOCAL loc_lHabilitaNome
1634:         loc_lHabilitaNome = .F.
1635: 
1636:         IF par_lModoEdicao
1637:             IF EMPTY(ALLTRIM(par_oTxtCod.Value))
1638:                 loc_lHabilitaNome = .T.
1639:             ENDIF
1640:         ENDIF
1641: 
1642:         *-- So atribui quando MUDA: este metodo roda tambem de dentro do
1643:         *-- LostFocus do proprio campo de nome (via AbrirLookupConta), e
1644:         *-- mexer em Enabled no meio de uma transicao de foco sem necessidade
1645:         *-- eh a forma mais facil de criar efeito colateral de foco.
1646:         IF par_oTxtNome.Enabled != loc_lHabilitaNome
1647:             par_oTxtNome.Enabled = loc_lHabilitaNome
1648:         ENDIF
1649:     ENDPROC
1650: 
1651:     *==========================================================================
1652:     * ValidarConta024..037 - Wrappers finos de AbrirLookupConta para o campo
1653:     * de CODIGO de cada uma das 14 linhas de equipe (Page3, cnt_4c_Emp1 /
1654:     * cnt_4c_Emp2) - equivalem ao "PROCEDURE Valid" de get_01_0NN. PUBLIC
1655:     * (BINDEVENT exige - regra #3); sem parametros (LostFocus nao passa
1656:     * nenhum - regra #47).
1657:     *==========================================================================
1658:     PROCEDURE ValidarConta024()
1659:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024, ;
1660:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a, "Iclis")
1661:     ENDPROC
1662: 
1663:     PROCEDURE ValidarConta025()
1664:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025, ;
1665:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025a, "Iclis")
1666:     ENDPROC
1667: 
1668:     PROCEDURE ValidarConta026()
1669:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026, ;
1670:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026a, "Iclis")
1671:     ENDPROC
1672: 
1673:     PROCEDURE ValidarConta027()
1674:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027, ;
1675:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027a, "Iclis")
1676:     ENDPROC
1677: 
1678:     PROCEDURE ValidarConta028()
1679:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028, ;
1680:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028a, "Iclis")
1681:     ENDPROC
1682: 
1683:     PROCEDURE ValidarConta029()
1684:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029, ;
1685:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029a, "Iclis")
1686:     ENDPROC
1687: 
1688:     PROCEDURE ValidarConta030()
1689:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030, ;
1690:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030a, "Iclis")
1691:     ENDPROC
1692: 
1693:     PROCEDURE ValidarConta031()
1694:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031, ;
1695:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031a, "Iclis")
1696:     ENDPROC
1697: 
1698:     PROCEDURE ValidarConta032()
1699:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032, ;
1700:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032a, "Iclis")
1701:     ENDPROC
1702: 
1703:     PROCEDURE ValidarConta033()
1704:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033, ;
1705:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033a, "Iclis")
1706:     ENDPROC
1707: 
1708:     PROCEDURE ValidarConta034()
1709:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034, ;
1710:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034a, "Iclis")
1711:     ENDPROC
1712: 
1713:     PROCEDURE ValidarConta035()
1714:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035, ;
1715:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035a, "Iclis")
1716:     ENDPROC
1717: 
1718:     PROCEDURE ValidarConta036()
1719:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036, ;
1720:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036a, "Iclis")
1721:     ENDPROC
1722: 
1723:     PROCEDURE ValidarConta037()
1724:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037, ;
1725:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037a, "Iclis")
1726:     ENDPROC
1727: 
1728:     *==========================================================================
1729:     * ValidarNomeConta024..037 - Wrappers finos de AbrirLookupConta para o
1730:     * campo de NOME de cada linha de equipe - equivalem ao "PROCEDURE Valid"
1731:     * de get_01_0NNa, que faz "Locate For RClis = Padr(This.Value, 50)" e,
1732:     * sem match, abre fwBuscaInt sobre RClis. Era a METADE do lookup de cada
1733:     * linha que faltava: sem eles o usuario que digitasse o NOME da conta nao
1734:     * tinha como resolver o codigo.
1735:     *==========================================================================
1736:     PROCEDURE ValidarNomeConta024()
1737:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024, ;
1738:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a, "Rclis")
1739:     ENDPROC
1740: 
1741:     PROCEDURE ValidarNomeConta025()
1742:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025, ;
1743:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025a, "Rclis")
1744:     ENDPROC
1745: 
1746:     PROCEDURE ValidarNomeConta026()
1747:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026, ;
1748:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026a, "Rclis")
1749:     ENDPROC
1750: 
1751:     PROCEDURE ValidarNomeConta027()
1752:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027, ;
1753:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027a, "Rclis")
1754:     ENDPROC
1755: 
1756:     PROCEDURE ValidarNomeConta028()
1757:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028, ;
1758:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028a, "Rclis")
1759:     ENDPROC
1760: 
1761:     PROCEDURE ValidarNomeConta029()
1762:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029, ;
1763:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029a, "Rclis")
1764:     ENDPROC
1765: 
1766:     PROCEDURE ValidarNomeConta030()
1767:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030, ;
1768:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030a, "Rclis")
1769:     ENDPROC
1770: 
1771:     PROCEDURE ValidarNomeConta031()
1772:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031, ;
1773:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031a, "Rclis")
1774:     ENDPROC
1775: 
1776:     PROCEDURE ValidarNomeConta032()
1777:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032, ;
1778:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032a, "Rclis")
1779:     ENDPROC
1780: 
1781:     PROCEDURE ValidarNomeConta033()
1782:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033, ;
1783:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033a, "Rclis")
1784:     ENDPROC
1785: 
1786:     PROCEDURE ValidarNomeConta034()
1787:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034, ;
1788:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034a, "Rclis")
1789:     ENDPROC
1790: 
1791:     PROCEDURE ValidarNomeConta035()
1792:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035, ;
1793:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035a, "Rclis")
1794:     ENDPROC
1795: 
1796:     PROCEDURE ValidarNomeConta036()
1797:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036, ;
1798:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036a, "Rclis")
1799:     ENDPROC
1800: 
1801:     PROCEDURE ValidarNomeConta037()
1802:         THIS.AbrirLookupConta(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037, ;
1803:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037a, "Rclis")
1804:     ENDPROC
1805: 
1806:     *==========================================================================
1807:     * ContaEquipeInteractiveChange - Reavalia o When dos campos de nome a cada
1808:     * tecla digitada no campo de codigo (o legado reavalia o When em cada
1809:     * refresh do container). Ligado por BINDEVENT nos 14 campos de codigo.
1810:     *==========================================================================
1811:     PROCEDURE ContaEquipeInteractiveChange()
1812:         THIS.AtualizarEstadoContasEquipe()
1813:     ENDPROC
1814: 
1815:     *==========================================================================
1816:     * ConfigurarTiposProjeto - Blocos "Tipo de Projeto" (Jb_038..041) e "Tipo
1817:     * de Desenvolvimento" (Jb_042..044) da Page3, abaixo da linha divisoria.
1818:     * Sao CheckBoxes independentes no legado (nao OptionGroup): o SCX declara
1819:     * sete checkbox separados, cada um com ControlSource proprio em coluna
1820:     * numeric(1,0) de SigMvJbC - mais de um pode ficar marcado.
1821:     * Posicoes EXATAS do dump.
1822:     *==========================================================================
1823:     PROTECTED PROCEDURE ConfigurarTiposProjeto(par_oPag)
1824:         *-- Tipo de Projeto (coluna da esquerda)
1825:         THIS.AdicionarRotuloSecao(par_oPag, "lbl_4c_Lbl_02_003", 326, 26, 100, ;
1826:             "Tipo de Projeto", 45)
1827:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_038", "lbl_4c_Lbl_01_038", ;
1828:             350, 26, 44, 110, "Pedido do Cliente", 46, 47)
1829:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_039", "lbl_4c_Lbl_01_039", ;
1830:             369, 26, 44, 85, "Concorr" + CHR(234) + "ncia", 48, 49)
1831:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_040", "lbl_4c_Lbl_01_040", ;
1832:             389, 26, 44, 70, "Licita" + CHR(231) + CHR(227) + "o", 50, 51)
1833:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_041", "lbl_4c_Lbl_01_041", ;
1834:             408, 26, 44, 85, "Propriet" + CHR(225) + "rio", 52, 53)
1835: 
1836:         *-- Tipo de Desenvolvimento (coluna da direita)
1837:         THIS.AdicionarRotuloSecao(par_oPag, "lbl_4c_Lbl_02_004", 326, 208, 150, ;
1838:             "Tipo de Desenvolvimento", 54)
1839:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_042", "lbl_4c_Lbl_01_042", ;
1840:             350, 208, 226, 135, "Desenvolvimento Total", 55, 56)
1841:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_043", "lbl_4c_Lbl_01_043", ;
1842:             369, 208, 226, 65, "Produ" + CHR(231) + CHR(227) + "o", 57, 58)
1843:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_044", "lbl_4c_Lbl_01_044", ;
1844:             389, 208, 226, 60, "Cria" + CHR(231) + CHR(227) + "o", 59, 60)
1845:     ENDPROC
1846: 
1847:     *==========================================================================
1848:     * AdicionarRotuloSecao - Label de titulo de bloco (os "lbl_02_NNN" do
1849:     * legado: FontBold = .T., sem Width/Alignment no dump - ver regra #23).
1850:     *==========================================================================
1851:     PROTECTED PROCEDURE AdicionarRotuloSecao(par_oPai, par_cNome, par_nTop, par_nLeft, ;
1852:                                              par_nWidth, par_cCaption, par_nTabIndex)
1853:         LOCAL loc_oLbl
1854: 
1855:         par_oPai.AddObject(par_cNome, "Label")
1856:         loc_oLbl = EVALUATE("par_oPai." + par_cNome)
1857:         WITH loc_oLbl
1858:             .Top = par_nTop
1859:             .Left = par_nLeft
1860:             .Width = par_nWidth
1861:             .Height = 15
1862:             .Alignment = 0
1863:             .AutoSize = .F.
1864:             .BackStyle = 0
1865:             .ForeColor = RGB(90, 90, 90)
1866:             .FontName = "Tahoma"
1867:             .FontSize = 8
1868:             .FontBold = .T.
1869:             .TabIndex = par_nTabIndex
1870:             .Caption = par_cCaption
1871:         ENDWITH
1872:     ENDPROC
1873: 
1874:     *==========================================================================
1875:     * AdicionarCheckBoxRotulado - Par CheckBox (Caption vazio) + Label ao lado,
1876:     * padrao repetido no SCX legado nas Pages 3, 5 e 6.
1877:     *
1878:     * O CheckBox do legado tem Caption = "" e o texto vem num Label separado,
1879:     * entao a caixa recebe Width/Height EXPLICITOS (16x17): AutoSize eh no-op
1880:     * em CheckBox criado por AddObject e a caixa ficaria nos 100x17 do default,
1881:     * cobrindo o Label ao lado. O Label vem DEPOIS da caixa, como no dump
1882:     * (TabIndex do Label eh o maior do par), e a caixa termina antes do Left
1883:     * do Label (26+16=42 < 44), sem sobreposicao.
1884:     *
1885:     * .Value = 0 NUMERICO (nunca .F.): as colunas Jb_0NN sao numeric(1,0) e
1886:     * misturar logico com numerico dispara "Operator/operand type mismatch".
1887:     *==========================================================================
1888:     PROTECTED PROCEDURE AdicionarCheckBoxRotulado(par_oPai, par_cNomeChk, par_cNomeLbl, ;
1889:                                                   par_nTop, par_nLeftChk, par_nLeftLbl, ;
1890:                                                   par_nWidthLbl, par_cCaption, ;
1891:                                                   par_nTabChk, par_nTabLbl)
1892:         LOCAL loc_oChk, loc_oLbl
1893: 
1894:         par_oPai.AddObject(par_cNomeChk, "CheckBox")
1895:         loc_oChk = EVALUATE("par_oPai." + par_cNomeChk)
1896:         WITH loc_oChk
1897:             .Top = par_nTop
1898:             .Left = par_nLeftChk
1899:             .Width = 16
1900:             .Height = 17
1901:             .Alignment = 0
1902:             .AutoSize = .F.
1903:             .BackStyle = 0
1904:             .SpecialEffect = 1
1905:             .TabIndex = par_nTabChk
1906:             .Caption = ""
1907:             .Value = 0
1908:         ENDWITH
1909: 
1910:         par_oPai.AddObject(par_cNomeLbl, "Label")
1911:         loc_oLbl = EVALUATE("par_oPai." + par_cNomeLbl)
1912:         WITH loc_oLbl
1913:             .Top = par_nTop
1914:             .Left = par_nLeftLbl
1915:             .Width = par_nWidthLbl
1916:             .Height = 15
1917:             .Alignment = 0
1918:             .AutoSize = .F.
1919:             .BackStyle = 0
1920:             .ForeColor = RGB(90, 90, 90)
1921:             .FontName = "Tahoma"
1922:             .FontSize = 8
1923:             .TabIndex = par_nTabLbl
1924:             .Caption = par_cCaption
1925:         ENDWITH
1926:     ENDPROC
1927: 
1928:     *==========================================================================

*-- Linhas 1937 a 1980:
1937:     * a regra #25 (icone so do dump confirmado). Os botoes usam Caption
1938:     * textual ("..." / "Abrir") em vez de icone.
1939:     *==========================================================================
1940:     PROTECTED PROCEDURE ConfigurarAbaMateriais()
1941:         LOCAL loc_oPag, loc_oErro
1942:         TRY
1943:             loc_oPag = THIS.pgf_4c_Job.Page4
1944: 
1945:             loc_oPag.AddObject("lbl_4c_Lbl_02_008", "Label")
1946:             WITH loc_oPag.lbl_4c_Lbl_02_008
1947:                 .Top = 14
1948:                 .Left = 13
1949:                 .Width = 150
1950:                 .Height = 15
1951:                 .Alignment = 0
1952:                 .AutoSize = .F.
1953:                 .BackStyle = 0
1954:                 .ForeColor = RGB(90, 90, 90)
1955:                 .FontName = "Tahoma"
1956:                 .FontSize = 8
1957:                 .FontBold = .T.
1958:                 .Caption = "Infos Clientes"
1959:             ENDWITH
1960: 
1961:             THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_045", "lbl_4c_Lbl_01_045", ;
1962:                 "cmd_4c_Btn_01_045", "cmd_4c_Btn_01_045b", 33, 48, "Logomarca", ;
1963:                 "Btn045Click", "Btn045bClick")
1964:             THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_046", "lbl_4c_Lbl_01_046", ;
1965:                 "cmd_4c_Btn_01_046", "cmd_4c_Btn_01_046b", 77, 92, "Manual de Marca", ;
1966:                 "Btn046Click", "Btn046bClick")
1967:             THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_047", "lbl_4c_Lbl_01_047", ;
1968:                 "cmd_4c_Btn_01_047", "cmd_4c_Btn_01_047b", 121, 136, "Imagens", ;
1969:                 "Btn047Click", "Btn047bClick")
1970:             THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_048", "lbl_4c_Lbl_01_048", ;
1971:                 "cmd_4c_Btn_01_048", "cmd_4c_Btn_01_048b", 165, 180, "Refer" + CHR(234) + "ncias", ;
1972:                 "Btn048Click", "Btn048bClick")
1973:             THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_061", "lbl_4c_Lbl_01_061", ;
1974:                 "cmd_4c_Btn_01_061", "cmd_4c_Btn_01_061b", 209, 224, ;
1975:                 "Atas, emails e correspond" + CHR(234) + "ncias de altera" + CHR(231) + CHR(245) + "es e aprova" + CHR(231) + CHR(227) + "o do cliente", ;
1976:                 "Btn061Click", "Btn061bClick")
1977: 
1978:             *-- Avaliacao do Job (memo largo, Jb_058)
1979:             loc_oPag.AddObject("lbl_4c_Lbl_01_058", "Label")
1980:             WITH loc_oPag.lbl_4c_Lbl_01_058

*-- Linhas 2003 a 2195:
2003:         CATCH TO loc_oErro
2004:             MsgErro(loc_oErro.Message + CHR(13) + ;
2005:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2006:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaMateriais")
2007:         ENDTRY
2008:     ENDPROC
2009: 
2010:     *==========================================================================
2011:     * AdicionarCampoPastaMaterial - Helper para o padrao repetido 5x na Page4:
2012:     * Label + EditBox (caminho) + botao "Escolher" (GetDir) + botao "Abrir"
2013:     * (Shell.Application), nas posicoes EXATAS do dump (Top do label eh
2014:     * par_nTopLbl, Top do campo/botoes eh par_nTopCampo - a mesma relacao de
2015:     * -15/-9 vista nas 5 linhas do SCX).
2016:     *==========================================================================
2017:     PROTECTED PROCEDURE AdicionarCampoPastaMaterial(par_oPag, par_cNomeEdit, par_cNomeLbl, ;
2018:             par_cNomeBtn, par_cNomeBtnB, par_nTopLbl, par_nTopCampo, par_cCaption, ;
2019:             par_cHandlerBtn, par_cHandlerBtnB)
2020:         LOCAL loc_oLbl, loc_oEdt, loc_oBtn, loc_oBtnB
2021: 
2022:         par_oPag.AddObject(par_cNomeLbl, "Label")
2023:         loc_oLbl = EVALUATE("par_oPag." + par_cNomeLbl)
2024:         WITH loc_oLbl
2025:             .Top = par_nTopLbl
2026:             .Left = 13
2027:             .Width = 888
2028:             .Height = 15
2029:             .Alignment = 0
2030:             .AutoSize = .F.
2031:             .BackStyle = 0
2032:             .ForeColor = RGB(90, 90, 90)
2033:             .FontName = "Tahoma"
2034:             .FontSize = 8
2035:             .Caption = par_cCaption
2036:         ENDWITH
2037: 
2038:         par_oPag.AddObject(par_cNomeEdit, "EditBox")
2039:         loc_oEdt = EVALUATE("par_oPag." + par_cNomeEdit)
2040:         WITH loc_oEdt
2041:             .Top = par_nTopCampo
2042:             .Left = 13
2043:             .Width = 888
2044:             .Height = 23
2045:             .ScrollBars = 0
2046:             .Value = ""
2047:             *-- Legado: "PROCEDURE When / Return .f." - o campo NUNCA recebe
2048:             *-- foco por digitacao, em modo algum; o valor so muda pelos
2049:             *-- botoes "..."/"Abrir" (EscolherPasta/AbrirPasta).
2050:             .ReadOnly = .T.
2051:         ENDWITH
2052: 
2053:         par_oPag.AddObject(par_cNomeBtn, "CommandButton")
2054:         loc_oBtn = EVALUATE("par_oPag." + par_cNomeBtn)
2055:         WITH loc_oBtn
2056:             .Top = par_nTopCampo - 9
2057:             .Left = 905
2058:             .Width = 40
2059:             .Height = 32
2060:             .FontName = "Tahoma"
2061:             .FontSize = 8
2062:             .Caption = "..."
2063:             .ToolTipText = "Selecionar Diret" + CHR(243) + "rio, Pasta ou Caminho de Rede"
2064:         ENDWITH
2065:         BINDEVENT(loc_oBtn, "Click", THIS, par_cHandlerBtn)
2066: 
2067:         par_oPag.AddObject(par_cNomeBtnB, "CommandButton")
2068:         loc_oBtnB = EVALUATE("par_oPag." + par_cNomeBtnB)
2069:         WITH loc_oBtnB
2070:             .Top = par_nTopCampo - 9
2071:             .Left = 947
2072:             .Width = 40
2073:             .Height = 32
2074:             .FontName = "Tahoma"
2075:             .FontSize = 8
2076:             .Caption = "Abrir"
2077:             .ToolTipText = "Abrir no Explorer"
2078:         ENDWITH
2079:         BINDEVENT(loc_oBtnB, "Click", THIS, par_cHandlerBtnB)
2080:     ENDPROC
2081: 
2082:     *==========================================================================
2083:     * EscolherPasta/AbrirPasta - Nucleo dos 10 botoes "..."/"Abrir" da Page4
2084:     * (legado: btn_01_0NN.Click - GetDir + Alltrim; btn_01_0NNb.Click -
2085:     * Shell.Application.Open). PUBLIC (chamados pelos wrappers via THIS.).
2086:     *==========================================================================
2087:     PROCEDURE EscolherPasta(par_oTxt)
2088:         LOCAL loc_cDir
2089:         loc_cDir = GETDIR("", "Selecione o Diret" + CHR(243) + "rio, Pasta ou Caminho de Rede", ;
2090:             "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios")
2091: 
2092:         IF !EMPTY(loc_cDir)
2093:             par_oTxt.Value = ALLTRIM(loc_cDir)
2094:         ELSE
2095:             par_oTxt.Value = ""
2096:         ENDIF
2097:         par_oTxt.Refresh()
2098:     ENDPROC
2099: 
2100:     PROCEDURE AbrirPasta(par_oTxt)
2101:         LOCAL loc_cDir, loc_oApp, loc_oErro
2102:         TRY
2103:             loc_cDir = ALLTRIM(par_oTxt.Value)
2104:             IF !EMPTY(loc_cDir)
2105:                 loc_oApp = CREATEOBJECT("Shell.Application")
2106:                 loc_oApp.Open(loc_cDir)
2107:             ENDIF
2108:         CATCH TO loc_oErro
2109:             MsgErro(loc_oErro.Message, "Erro ao abrir pasta")
2110:         ENDTRY
2111:     ENDPROC
2112: 
2113:     *==========================================================================
2114:     * Btn045Click..Btn061bClick - Wrappers finos de EscolherPasta/AbrirPasta
2115:     * para cada um dos 5 campos de caminho da Page4. PUBLIC (BINDEVENT exige).
2116:     *==========================================================================
2117:     PROCEDURE Btn045Click()
2118:         THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045)
2119:     ENDPROC
2120:     PROCEDURE Btn045bClick()
2121:         THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045)
2122:     ENDPROC
2123:     PROCEDURE Btn046Click()
2124:         THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046)
2125:     ENDPROC
2126:     PROCEDURE Btn046bClick()
2127:         THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046)
2128:     ENDPROC
2129:     PROCEDURE Btn047Click()
2130:         THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047)
2131:     ENDPROC
2132:     PROCEDURE Btn047bClick()
2133:         THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047)
2134:     ENDPROC
2135:     PROCEDURE Btn048Click()
2136:         THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048)
2137:     ENDPROC
2138:     PROCEDURE Btn048bClick()
2139:         THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048)
2140:     ENDPROC
2141:     PROCEDURE Btn061Click()
2142:         THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061)
2143:     ENDPROC
2144:     PROCEDURE Btn061bClick()
2145:         THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061)
2146:     ENDPROC
2147: 
2148:     *==========================================================================
2149:     * ConfigurarAbaFinanceiroCampos - Page5 ("Controladoria / Fiscal"),
2150:     * campos restantes alem da grade "Fontes Pagadoras" (ja criada por
2151:     * ConfigurarGridFontes): titulo de secao, 8 checkboxes (Jb_063..069,075),
2152:     * Codigo de Atividade (Jb_062), Outras Receitas (Jb_070) e Comentarios
2153:     * Financeiros (Jb_071). Posicoes EXATAS do dump.
2154:     *==========================================================================
2155:     PROTECTED PROCEDURE ConfigurarAbaFinanceiroCampos()
2156:         LOCAL loc_oPag, loc_oErro
2157:         TRY
2158:             loc_oPag = THIS.pgf_4c_Job.Page5
2159: 
2160:             THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_009", 21, 15, 330, ;
2161:                 "Modelo Fiscal / Considera" + CHR(231) + CHR(245) + "es Financeiras", 1)
2162: 
2163:             *-- Coluna da esquerda
2164:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_063", "lbl_4c_Lbl_01_063", ;
2165:                 45, 15, 33, 90, "NF de Servi" + CHR(231) + "o", 2, 3)
2166:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_064", "lbl_4c_Lbl_01_064", ;
2167:                 64, 15, 33, 90, "Nota de D" + CHR(233) + "bito", 4, 5)
2168:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_065", "lbl_4c_Lbl_01_065", ;
2169:                 84, 15, 33, 90, "NF de Loca" + CHR(231) + CHR(227) + "o", 6, 7)
2170:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_075", "lbl_4c_Lbl_01_075", ;
2171:                 103, 15, 33, 100, "Conta Corrente", 8, 9)
2172: 
2173:             *-- Coluna do meio
2174:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_066", "lbl_4c_Lbl_01_066", ;
2175:                 45, 174, 192, 100, "Incentivo ICMS", 10, 11)
2176:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_067", "lbl_4c_Lbl_01_067", ;
2177:                 64, 174, 192, 110, "Incentivo Rouanet", 12, 13)
2178:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_068", "lbl_4c_Lbl_01_068", ;
2179:                 84, 174, 192, 90, "Incentivo ISS", 14, 15)
2180:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_069", "lbl_4c_Lbl_01_069", ;
2181:                 103, 174, 192, 80, "Patroc" + CHR(237) + "nio", 16, 17)
2182: 
2183:             *-- Coluna da direita
2184:             loc_oPag.AddObject("lbl_4c_Lbl_01_062", "Label")
2185:             WITH loc_oPag.lbl_4c_Lbl_01_062
2186:                 .Top = 7
2187:                 .Left = 347
2188:                 .Width = 150
2189:                 .Height = 15
2190:                 .Alignment = 0
2191:                 .AutoSize = .F.
2192:                 .BackStyle = 0
2193:                 .ForeColor = RGB(90, 90, 90)
2194:                 .FontName = "Tahoma"
2195:                 .FontSize = 8

*-- Linhas 2261 a 2314:
2261:         CATCH TO loc_oErro
2262:             MsgErro(loc_oErro.Message + CHR(13) + ;
2263:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2264:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaFinanceiroCampos")
2265:         ENDTRY
2266:     ENDPROC
2267: 
2268:     *==========================================================================
2269:     * ConfigurarAbaApresentacao - Page6 ("Apresentacao" no dump): tipo de
2270:     * apresentacao (Jb_049/050), Proposta Comercial (Jb_051/052/053 + Jb_073
2271:     * "Outros"), Proposta Tecnica (Jb_054/055/056 + Jb_074 "Outros") e o memo
2272:     * largo "Documentos Necessarios" (Jb_057). Posicoes EXATAS do dump.
2273:     *==========================================================================
2274:     PROTECTED PROCEDURE ConfigurarAbaApresentacao()
2275:         LOCAL loc_oPag, loc_oErro
2276:         TRY
2277:             loc_oPag = THIS.pgf_4c_Job.Page6
2278: 
2279:             THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_005", 30, 16, 100, "Apresenta" + CHR(231) + CHR(227) + "o", 1)
2280:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_049", "lbl_4c_Lbl_01_049", ;
2281:                 54, 16, 34, 70, "Presencial", 2, 3)
2282:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_050", "lbl_4c_Lbl_01_050", ;
2283:                 73, 16, 34, 70, "Eletr" + CHR(244) + "nica", 4, 5)
2284: 
2285:             THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_006", 30, 233, 150, "Proposta Comercial", 6)
2286:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_051", "lbl_4c_Lbl_01_051", ;
2287:                 54, 233, 251, 65, "Impress" + CHR(227) + "o", 7, 8)
2288:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_052", "lbl_4c_Lbl_01_052", ;
2289:                 73, 233, 251, 30, "CD", 9, 10)
2290:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_053", "lbl_4c_Lbl_01_053", ;
2291:                 93, 233, 251, 50, "Outros", 11, 12)
2292:             loc_oPag.AddObject("obj_4c_Get_01_073", "EditBox")
2293:             WITH loc_oPag.obj_4c_Get_01_073
2294:                 .Top = 114
2295:                 .Left = 233
2296:                 .Width = 360
2297:                 .Height = 23
2298:                 .ScrollBars = 0
2299:                 .TabIndex = 13
2300:                 .Value = ""
2301:             ENDWITH
2302: 
2303:             THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_007", 30, 625, 150, "Proposta T" + CHR(233) + "cnica", 14)
2304:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_054", "lbl_4c_Lbl_01_054", ;
2305:                 54, 625, 643, 65, "Impress" + CHR(227) + "o", 15, 16)
2306:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_055", "lbl_4c_Lbl_01_055", ;
2307:                 73, 625, 643, 30, "CD", 17, 18)
2308:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_056", "lbl_4c_Lbl_01_056", ;
2309:                 93, 625, 643, 50, "Outros", 19, 20)
2310:             loc_oPag.AddObject("obj_4c_Get_01_074", "EditBox")
2311:             WITH loc_oPag.obj_4c_Get_01_074
2312:                 .Top = 114
2313:                 .Left = 625
2314:                 .Width = 360

*-- Linhas 2356 a 2425:
2356:         CATCH TO loc_oErro
2357:             MsgErro(loc_oErro.Message + CHR(13) + ;
2358:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2359:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaApresentacao")
2360:         ENDTRY
2361:     ENDPROC
2362: 
2363:     *==========================================================================
2364:     * ConfigurarCabecalhoJob - Bloco de identificacao do Job, criado DIRETO na
2365:     * raiz do form (acima do PageFrame), exatamente como no SCX legado: o
2366:     * SIGOPJOB nao tem o container de cabecalho cinza (cntSombra) do
2367:     * frmcadastro - sao campos soltos na Form.
2368:     *
2369:     * Posicoes/propriedades EXATAS do dump (SIGOPJOB.getCab*/lblCab*/Say3/
2370:     * get_Extra/lbl_Extra). Nomes conforme tasks\task755\mapeamento.json.
2371:     *
2372:     * getCab001/002/005/006/010 sao SOMENTE-LEITURA: o SCX declara
2373:     * "Enabled = .F." explicitamente nos cinco, com DisabledBackColor
2374:     * 255,255,244 (creme) - eh a cor que da a aparencia de campo travado do
2375:     * legado. Quem os preenche eh CarregarCabecalhoJob(), a partir das
2376:     * propriedades this_cCab* do BO.
2377:     *
2378:     * O Label vem SEMPRE antes do campo (a caixa transparente do Label nao
2379:     * pode ficar por cima do controle - regra #23). Os Labels da classe "say"
2380:     * do legado nao declaram Width nem Alignment, entao recebem
2381:     * Alignment = 0 + AutoSize = .F. + Width que caiba o texto, e ForeColor
2382:     * RGB(90,90,90) - sobre o fundo claro da Form, branco seria INVISIVEL
2383:     * (regra #12).
2384:     *==========================================================================
2385:     PROTECTED PROCEDURE ConfigurarCabecalhoJob()
2386:         LOCAL loc_oErro
2387:         TRY
2388:             *-- Linha 1: Job (codigo) + Descricao do Job
2389:             THIS.AddObject("lbl_4c_LblCab001", "Label")
2390:             WITH THIS.lbl_4c_LblCab001
2391:                 .Top = 3
2392:                 .Left = 16
2393:                 .Width = 30
2394:                 .Height = 15
2395:                 .Alignment = 0
2396:                 .AutoSize = .F.
2397:                 .BackStyle = 0
2398:                 .ForeColor = RGB(90, 90, 90)
2399:                 .FontName = "Tahoma"
2400:                 .FontSize = 8
2401:                 .TabIndex = 1
2402:                 .Caption = "Job"
2403:             ENDWITH
2404: 
2405:             THIS.AddObject("txt_4c_Cab001", "TextBox")
2406:             WITH THIS.txt_4c_Cab001
2407:                 .Top = 18
2408:                 .Left = 16
2409:                 .Width = 80
2410:                 .Height = 23
2411:                 .BorderStyle = 1
2412:                 .SpecialEffect = 1
2413:                 .TabIndex = 2
2414:                 .Enabled = .F.
2415:                 .MaxLength = 10
2416:                 .BackColor         = RGB(255, 255, 244)
2417:                 .DisabledBackColor = RGB(255, 255, 244)
2418:                 .Value = ""
2419:             ENDWITH
2420: 
2421:             THIS.AddObject("lbl_4c_LblCab002", "Label")
2422:             WITH THIS.lbl_4c_LblCab002
2423:                 .Top = 3
2424:                 .Left = 99
2425:                 .Width = 60

*-- Linhas 2633 a 2738:
2633:         CATCH TO loc_oErro
2634:             MsgErro(loc_oErro.Message + CHR(13) + ;
2635:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2636:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalhoJob")
2637:         ENDTRY
2638:     ENDPROC
2639: 
2640:     *==========================================================================
2641:     * ConfigurarBotaoRetornar - Cria obj_4c_CmdRetornar (cmdRetornar legado),
2642:     * CommandGroup de 1 botao que fecha o dialogo de Complementos do Job
2643:     * (Click em CmdRetornarClick, regra #3/#45 - BINDEVENT em Buttons(1)).
2644:     * Posicao EXATA do dump: Top=13, Left=907, Width=85, Height=85.
2645:     *==========================================================================
2646:     PROTECTED PROCEDURE ConfigurarBotaoRetornar()
2647:         LOCAL loc_oErro
2648:         TRY
2649:             THIS.AddObject("obj_4c_CmdRetornar", "CommandGroup")
2650:             WITH THIS.obj_4c_CmdRetornar
2651:                 .Top         = 13
2652:                 .Left        = 907
2653:                 .Width       = 85
2654:                 .Height      = 85
2655:                 .ButtonCount = 1
2656:                 .BackStyle   = 0
2657:                 .BorderStyle = 0
2658:                 .Value       = 0
2659:                 .Visible     = .T.
2660: 
2661:                 WITH .Buttons(1)
2662:                     .Top        = 5
2663:                     .Left       = 5
2664:                     .Width      = 75
2665:                     .Height     = 75
2666:                     .FontBold   = .T.
2667:                     .FontItalic = .T.
2668:                     .FontName   = "Comic Sans MS"
2669:                     .FontSize   = 8
2670:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2671:                     .Caption    = "Retornar"
2672:                     .ForeColor  = RGB(90, 90, 90)
2673:                     .BackColor  = RGB(255, 255, 255)
2674:                     .Themes     = .F.
2675:                     .Cancel     = .T.
2676:                 ENDWITH
2677:             ENDWITH
2678:             BINDEVENT(THIS.obj_4c_CmdRetornar.Buttons(1), "Click", THIS, "CmdRetornarClick")
2679:         CATCH TO loc_oErro
2680:             MsgErro(loc_oErro.Message + CHR(13) + ;
2681:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2682:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoRetornar")
2683:         ENDTRY
2684:     ENDPROC
2685: 
2686:     *==========================================================================
2687:     * ConfigurarGridFontes - Cria a secao "Fontes Pagadoras" (grdFontes do
2688:     * legado) na Page5 (Financeiro): label de secao, linha divisoria, grade
2689:     * editavel ligada a cursor_4c_Fontes, botoes Inserir/Excluir (icones
2690:     * cadastro_inserir_26.jpg / cadastro_excluir_26.jpg - transcritos do dump
2691:     * em tasks\task755\SigOpJob_form_codigo_fonte.txt:3677/3689, regra #25)
2692:     * e os totalizadores txt_4c_TotFontes/txt_4c_TotValores (somente leitura).
2693:     *
2694:     * O cursor placeholder nasce ANTES do Grid (regra #41) com a MESMA ordem
2695:     * de colunas do SELECT feito por SigOpJobBO.CarregarFontes(), para o
2696:     * rebind em CarregarLista() nao reordenar nada.
2697:     *==========================================================================
2698:     PROTECTED PROCEDURE ConfigurarGridFontes()
2699:         LOCAL loc_oPagina, loc_oErro
2700:         TRY
2701:             IF USED("cursor_4c_Fontes")
2702:                 USE IN cursor_4c_Fontes
2703:             ENDIF
2704:             CREATE CURSOR cursor_4c_Fontes ;
2705:                 (empdopnums C(29), jbi_autors C(20), jbi_fontes C(50), ;
2706:                  jbi_modelos C(30), jbi_valors N(11,2), pkchaves C(20))
2707: 
2708:             loc_oPagina = THIS.pgf_4c_Job.Page5
2709: 
2710:             loc_oPagina.AddObject("lbl_4c_Lbl_02_010", "Label")
2711:             WITH loc_oPagina.lbl_4c_Lbl_02_010
2712:                 .Top       = 199
2713:                 .Left      = 13
2714:                 .Width     = 200
2715:                 .Height    = 15
2716:                 .Alignment = 0
2717:                 .AutoSize  = .F.
2718:                 .BackStyle = 0
2719:                 .ForeColor = RGB(90, 90, 90)
2720:                 .FontName  = "Tahoma"
2721:                 .FontSize  = 8
2722:                 .Caption   = "Fontes Pagadoras"
2723:                 .Visible   = .T.
2724:             ENDWITH
2725: 
2726:             loc_oPagina.AddObject("lin_4c_Line1", "Line")
2727:             WITH loc_oPagina.lin_4c_Line1
2728:                 .Top     = 194
2729:                 .Left    = 13
2730:                 .Width   = 974
2731:                 .Height  = 0
2732:                 .Visible = .T.
2733:             ENDWITH
2734: 
2735:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
2736:             WITH loc_oPagina.grd_4c_Dados
2737:                 .Top               = 217
2738:                 .Left              = 12

*-- Linhas 2803 a 2945:
2803:                 .Column4.Header1.FontName  = "Verdana"
2804:                 .Column4.Header1.FontSize  = 8
2805:             ENDWITH
2806:             BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdFontesAfterRowColChange")
2807:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "When", THIS, "GrdFontesColumnWhen")
2808:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column2.Text1, "When", THIS, "GrdFontesColumnWhen")
2809:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column3.Text1, "When", THIS, "GrdFontesColumnWhen")
2810:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column4.Text1, "When", THIS, "GrdFontesColumnWhen")
2811:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column4.Text1, "Valid", THIS, "GrdFontesColumn4Valid")
2812: 
2813:             *-- Botao Inserir linha (legado: btnInserir top=217, left=947)
2814:             loc_oPagina.AddObject("cmd_4c_BtnInserir", "CommandButton")
2815:             WITH loc_oPagina.cmd_4c_BtnInserir
2816:                 .Top             = 217
2817:                 .Left            = 947
2818:                 .Width           = 42
2819:                 .Height          = 42
2820:                 .Caption         = ""
2821:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2822:                 .PicturePosition = 13
2823:                 .Themes          = .T.
2824:                 .SpecialEffect   = 0
2825:                 .MousePointer    = 15
2826:                 .ToolTipText     = "Inserir Linha em Branco na Grade"
2827:                 .Visible         = .T.
2828:             ENDWITH
2829:             BINDEVENT(loc_oPagina.cmd_4c_BtnInserir, "Click", THIS, "BtnInserirClick")
2830: 
2831:             *-- Botao Excluir linha (legado: btnExcluir top=257, left=947)
2832:             loc_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
2833:             WITH loc_oPagina.cmd_4c_BtnExcluir
2834:                 .Top             = 257
2835:                 .Left            = 947
2836:                 .Width           = 42
2837:                 .Height          = 42
2838:                 .Caption         = ""
2839:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2840:                 .PicturePosition = 13
2841:                 .Themes          = .T.
2842:                 .SpecialEffect   = 0
2843:                 .MousePointer    = 15
2844:                 .ToolTipText     = "Excluir"
2845:                 .Visible         = .T.
2846:             ENDWITH
2847:             BINDEVENT(loc_oPagina.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirClick")
2848: 
2849:             *-- Totalizadores (somente leitura) - legado: getTotFontes/getTotValores
2850:             loc_oPagina.AddObject("txt_4c_TotFontes", "TextBox")
2851:             WITH loc_oPagina.txt_4c_TotFontes
2852:                 .Top               = 419
2853:                 .Left              = 595
2854:                 .Width             = 150
2855:                 .Height            = 23
2856:                 .Alignment         = 1
2857:                 .BorderStyle       = 1
2858:                 .SpecialEffect     = 1
2859:                 .Enabled           = .F.
2860:                 .Value             = ""
2861:                 .BackColor         = RGB(255, 255, 244)
2862:                 .DisabledBackColor = RGB(255, 255, 244)
2863:                 .Visible           = .T.
2864:             ENDWITH
2865: 
2866:             loc_oPagina.AddObject("txt_4c_TotValores", "TextBox")
2867:             WITH loc_oPagina.txt_4c_TotValores
2868:                 .Top               = 419
2869:                 .Left              = 747
2870:                 .Width             = 174
2871:                 .Height            = 23
2872:                 .Alignment         = 1
2873:                 .BorderStyle       = 1
2874:                 .SpecialEffect     = 1
2875:                 .Enabled           = .F.
2876:                 .Value             = ""
2877:                 .BackColor         = RGB(255, 255, 244)
2878:                 .DisabledBackColor = RGB(255, 255, 244)
2879:                 .Visible           = .T.
2880:             ENDWITH
2881:         CATCH TO loc_oErro
2882:             MsgErro(loc_oErro.Message + CHR(13) + ;
2883:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2884:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGridFontes")
2885:         ENDTRY
2886:     ENDPROC
2887: 
2888:     *==========================================================================
2889:     * CarregarLista - Carrega SigMvJbI (via BO.CarregarFontes) na grade
2890:     * "Fontes Pagadoras" e rebinda RecordSource/ControlSource/Width/Header -
2891:     * RecordSource RESETA essas propriedades (Problema 48), por isso sao
2892:     * reaplicadas aqui, depois do load (legado: PROCEDURE montagrades).
2893:     *
2894:     * Em modo INCLUIR/ALTERAR garante ao menos 1 linha em branco (mesma
2895:     * logica do btnInserir.Click) e exibe os botoes de Inserir/Excluir;
2896:     * em VISUALIZAR eles ficam ocultos e a grade some de edicao via o
2897:     * guard de GrdFontesColumnWhen.
2898:     *
2899:     * PUBLIC de proposito: este e' o FUNIL de carga da lista deste dialogo
2900:     * (a grade "Fontes Pagadoras" e' a unica lista que o SCX legado tem), e
2901:     * o harness de teste chama THIS.oForm.CarregarLista() de FORA da classe
2902:     * - PEMSTATUS devolve .T. para metodo PROTECTED, entao o teste entraria
2903:     * no branch e a chamada estouraria em runtime (regra #3).
2904:     *==========================================================================
2905:     PROCEDURE CarregarLista()
2906:         LOCAL loc_oGrid, loc_cAlias, loc_lModoEdicao, loc_lProsseguir, loc_oErro
2907: 
2908:         TRY
2909:             *-- Guarda SEM "RETURN" dentro do TRY (regra #1): o early-exit vira
2910:             *-- flag e o corpo fica sob o IF.
2911:             loc_lProsseguir = THIS.this_oBusinessObject.CarregarFontes()
2912: 
2913:             IF loc_lProsseguir
2914:                 loc_cAlias      = THIS.this_oBusinessObject.this_cCursorFontes
2915:                 loc_oGrid       = THIS.pgf_4c_Job.Page5.grd_4c_Dados
2916:                 loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2917: 
2918:                 WITH loc_oGrid
2919:                     .RecordSource = loc_cAlias
2920: 
2921:                     .Column1.ControlSource   = loc_cAlias + ".jbi_fontes"
2922:                     .Column1.Width           = 360
2923:                     .Column1.Header1.Caption = "Cliente"
2924: 
2925:                     .Column2.ControlSource   = loc_cAlias + ".jbi_modelos"
2926:                     .Column2.Width           = 220
2927:                     .Column2.Header1.Caption = "Modelo Fiscal"
2928: 
2929:                     .Column3.ControlSource   = loc_cAlias + ".jbi_autors"
2930:                     .Column3.Width           = 150
2931:                     .Column3.Header1.Caption = "N" + CHR(250) + "mero Incentivo"
2932: 
2933:                     .Column4.ControlSource   = loc_cAlias + ".jbi_valors"
2934:                     .Column4.Width           = 174
2935:                     .Column4.Header1.Caption = "Valor"
2936:                 ENDWITH
2937: 
2938:                 SELECT (loc_cAlias)
2939:                 GO TOP
2940: 
2941:                 THIS.pgf_4c_Job.Page5.cmd_4c_BtnInserir.Visible = .F.
2942:                 THIS.pgf_4c_Job.Page5.cmd_4c_BtnExcluir.Visible = .F.
2943: 
2944:                 IF loc_lModoEdicao
2945:                     LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)

*-- Linhas 2959 a 3348:
2959:         CATCH TO loc_oErro
2960:             MsgErro(loc_oErro.Message + CHR(13) + ;
2961:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2962:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
2963:         ENDTRY
2964:     ENDPROC
2965: 
2966:     *==========================================================================
2967:     * CarregarCabecalhoJob - Preenche o bloco de identificacao do Job
2968:     * (equivalente a PROCEDURE carregacabs do SCX legado, que tambem comeca
2969:     * LIMPANDO os getCab antes de recarregar).
2970:     *
2971:     * Os cinco campos sao Enabled = .F.: quem le o banco eh
2972:     * SigOpJobBO.CarregarCabecalho(), e aqui so se espelha o resultado.
2973:     *==========================================================================
2974:     PROTECTED PROCEDURE CarregarCabecalhoJob()
2975:         LOCAL loc_oBO, loc_oErro
2976: 
2977:         TRY
2978:             *-- Limpeza previa (o "For lnClr = 1 To 12 ... Value = []" legado)
2979:             THIS.txt_4c_Cab001.Value = ""
2980:             THIS.txt_4c_Cab002.Value = ""
2981:             THIS.txt_4c_Cab005.Value = ""
2982:             THIS.txt_4c_Cab006.Value = ""
2983:             THIS.txt_4c_Cab010.Value = {}
2984: 
2985:             *-- Guarda de conexao em IF SEPARADO (VFP9 nao garante
2986:             *-- short-circuit em AND) e delegada ao BO.ConexaoAtiva(), que
2987:             *-- testa TYPE antes do valor - sem conexao a variavel
2988:             *-- gnConnHandle pode nem existir.
2989:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2990:                 loc_oBO = THIS.this_oBusinessObject
2991: 
2992:                 IF loc_oBO.ConexaoAtiva()
2993:                     loc_oBO.CarregarCabecalho(THIS.this_cContas)
2994: 
2995:                     THIS.txt_4c_Cab001.Value = loc_oBO.this_cCabJobs
2996:                     THIS.txt_4c_Cab002.Value = loc_oBO.this_cCabJobDesc
2997:                     THIS.txt_4c_Cab005.Value = loc_oBO.this_cCabContas
2998:                     THIS.txt_4c_Cab006.Value = loc_oBO.this_cCabContaDesc
2999:                     THIS.txt_4c_Cab010.Value = ConverterParaData(loc_oBO.this_dCabDataEntrada)
3000:                 ENDIF
3001:             ENDIF
3002: 
3003:             THIS.txt_4c_Cab001.Refresh()
3004:             THIS.txt_4c_Cab002.Refresh()
3005:             THIS.txt_4c_Cab005.Refresh()
3006:             THIS.txt_4c_Cab006.Refresh()
3007:             THIS.txt_4c_Cab010.Refresh()
3008:         CATCH TO loc_oErro
3009:             MsgErro(loc_oErro.Message + CHR(13) + ;
3010:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3011:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarCabecalhoJob")
3012:         ENDTRY
3013:     ENDPROC
3014: 
3015:     *==========================================================================
3016:     * CarregarNomesEquipes - Preenche os 14 campos de NOME da Page3 a partir
3017:     * do codigo gravado em cada campo de codigo (equivalente a PROCEDURE
3018:     * mdadosequipes do SCX legado, que para cada Jb_024..037 nao vazio faz
3019:     * CursorQuery em SigCdCli e joga RClis no campo "a").
3020:     *
3021:     * O legado NAO tem ControlSource nos campos "a": eles sao preenchidos por
3022:     * codigo, e eh isso que se reproduz aqui.
3023:     *==========================================================================
3024:     PROTECTED PROCEDURE CarregarNomesEquipes()
3025:         LOCAL loc_oBO, loc_oCnt1, loc_oCnt2, loc_oErro
3026: 
3027:         TRY
3028:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3029:                 loc_oBO   = THIS.this_oBusinessObject
3030:                 loc_oCnt1 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp1
3031:                 loc_oCnt2 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp2
3032: 
3033:                 loc_oCnt1.txt_4c__01_024a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb024)
3034:                 loc_oCnt1.txt_4c__01_025a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb025)
3035:                 loc_oCnt1.txt_4c__01_026a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb026)
3036:                 loc_oCnt1.txt_4c__01_027a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb027)
3037:                 loc_oCnt1.txt_4c__01_028a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb028)
3038:                 loc_oCnt1.txt_4c__01_029a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb029)
3039:                 loc_oCnt1.txt_4c__01_030a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb030)
3040: 
3041:                 loc_oCnt2.txt_4c__01_031a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb031)
3042:                 loc_oCnt2.txt_4c__01_032a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb032)
3043:                 loc_oCnt2.txt_4c__01_033a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb033)
3044:                 loc_oCnt2.txt_4c__01_034a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb034)
3045:                 loc_oCnt2.txt_4c__01_035a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb035)
3046:                 loc_oCnt2.txt_4c__01_036a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb036)
3047:                 loc_oCnt2.txt_4c__01_037a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb037)
3048:             ENDIF
3049:         CATCH TO loc_oErro
3050:             MsgErro(loc_oErro.Message + CHR(13) + ;
3051:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3052:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarNomesEquipes")
3053:         ENDTRY
3054:     ENDPROC
3055: 
3056:     *==========================================================================
3057:     * ObterNomeConta - SigCdCli.RClis do codigo informado, delegando ao BO.
3058:     * Devolve "" para codigo vazio ou sem conexao (modo de teste/validacao de
3059:     * UI roda com gnConnHandle invalido).
3060:     *==========================================================================
3061:     PROTECTED FUNCTION ObterNomeConta(par_cCodigo)
3062:         LOCAL loc_cNome
3063:         loc_cNome = ""
3064: 
3065:         *-- IFs aninhados, nao AND encadeado: VFP9 nao garante short-circuit,
3066:         *-- e a guarda de conexao tem de vir DEPOIS de provar que o BO existe.
3067:         IF VARTYPE(par_cCodigo) = "C" AND !EMPTY(ALLTRIM(par_cCodigo))
3068:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3069:                 IF THIS.this_oBusinessObject.ConexaoAtiva()
3070:                     loc_cNome = THIS.this_oBusinessObject.ObterRazaoConta(par_cCodigo)
3071:                 ENDIF
3072:             ENDIF
3073:         ENDIF
3074: 
3075:         RETURN loc_cNome
3076:     ENDFUNC
3077: 
3078:     *==========================================================================
3079:     * GrdFontesColumnWhen - Controla editabilidade das 4 colunas da grade
3080:     * "Fontes Pagadoras" (legado: Column1..4.Text1.When, texto identico nas
3081:     * quatro - "Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])").
3082:     *==========================================================================
3083:     PROCEDURE GrdFontesColumnWhen()
3084:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3085:     ENDPROC
3086: 
3087:     *==========================================================================
3088:     * GrdFontesColumn4Valid - Ao sair da coluna Valor com Cliente e Modelo
3089:     * Fiscal preenchidos, garante uma nova linha em branco no final da grade
3090:     * (legado: Column4.Text1.Valid).
3091:     *==========================================================================
3092:     PROCEDURE GrdFontesColumn4Valid()
3093:         LOCAL loc_cAlias
3094: 
3095:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3096:             RETURN .T.
3097:         ENDIF
3098: 
3099:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
3100:         IF !USED(loc_cAlias)
3101:             RETURN .T.
3102:         ENDIF
3103: 
3104:         SELECT (loc_cAlias)
3105:         IF !EMPTY(jbi_fontes) AND !EMPTY(jbi_modelos) AND !EOF()
3106:             SKIP
3107:             IF EOF()
3108:                 INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3109:                     (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3110:             ENDIF
3111:         ENDIF
3112: 
3113:         GO TOP
3114:         THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3115:         GO BOTTOM
3116: 
3117:         RETURN .T.
3118:     ENDPROC
3119: 
3120:     *==========================================================================
3121:     * BtnInserirClick - Insere linha em branco na grade "Fontes Pagadoras"
3122:     * (legado: pgPagina5.btnInserir.Click). So reutiliza linha ja vazia
3123:     * (JBI_Fontes e JBI_Modelos vazios); senao cria uma nova com pkChaves
3124:     * unico (fUniqueIds()).
3125:     *==========================================================================
3126:     PROCEDURE BtnInserirClick()
3127:         *-- Guardas por FLAG, nunca RETURN: RETURN dentro de TRY/ENDTRY (bare
3128:         *-- ou com valor) estoura "RETURN/RETRY statement not allowed in
3129:         *-- TRY/CATCH" em RUNTIME, e so no caminho em que a guarda pega -
3130:         *-- o .prg compila limpo e o caminho feliz passa nos testes (regra #1).
3131:         LOCAL loc_cAlias, loc_lProsseguir, loc_oErro
3132:         loc_lProsseguir = .T.
3133: 
3134:         TRY
3135:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
3136:                 loc_lProsseguir = .F.
3137:             ENDIF
3138: 
3139:             IF loc_lProsseguir
3140:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
3141:                 IF !USED(loc_cAlias)
3142:                     loc_lProsseguir = .F.
3143:                 ENDIF
3144:             ENDIF
3145: 
3146:             IF loc_lProsseguir
3147:                 SELECT (loc_cAlias)
3148:                 LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)
3149:                 IF !FOUND()
3150:                     INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3151:                         (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3152:                 ENDIF
3153: 
3154:                 SELECT (loc_cAlias)
3155:                 GO TOP
3156:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3157:                 GO BOTTOM
3158:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.SetFocus()
3159:                 THIS.GrdFontesAfterRowColChange(1)
3160:             ENDIF
3161:         CATCH TO loc_oErro
3162:             MsgErro(loc_oErro.Message + CHR(13) + ;
3163:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3164:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnInserirClick")
3165:         ENDTRY
3166:     ENDPROC
3167: 
3168:     *==========================================================================
3169:     * BtnExcluirClick - Exclui a linha corrente da grade "Fontes Pagadoras"
3170:     * (legado: pgPagina5.btnExcluir.Click). DELETE sem PACK - SET DELETED ON
3171:     * (config.prg) ja tira a linha da visao do Grid.
3172:     *==========================================================================
3173:     PROCEDURE BtnExcluirClick()
3174:         *-- Guardas por FLAG, nunca RETURN - ver comentario de BtnInserirClick
3175:         *-- (regra #1). Aqui o RETURN era ainda mais perigoso: ele ficava
3176:         *-- ANTES do LockScreen = .T., mas o estouro em runtime deixaria o
3177:         *-- metodo pelo CATCH, que repoe LockScreen = .F.
3178:         LOCAL loc_cAlias, loc_nRec, loc_lProsseguir, loc_oErro
3179:         loc_lProsseguir = .T.
3180: 
3181:         TRY
3182:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
3183:                 loc_lProsseguir = .F.
3184:             ENDIF
3185: 
3186:             IF loc_lProsseguir
3187:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
3188:                 IF !USED(loc_cAlias)
3189:                     loc_lProsseguir = .F.
3190:                 ENDIF
3191:             ENDIF
3192: 
3193:             IF loc_lProsseguir
3194:                 THIS.LockScreen = .T.
3195: 
3196:                 SELECT (loc_cAlias)
3197:                 loc_nRec = RECNO()
3198:                 IF !EOF()
3199:                     DELETE
3200:                 ENDIF
3201: 
3202:                 GO TOP
3203:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3204:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
3205:                     GO (loc_nRec)
3206:                 ELSE
3207:                     GO BOTTOM
3208:                 ENDIF
3209:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3210:                 THIS.GrdFontesAfterRowColChange(1)
3211: 
3212:                 THIS.LockScreen = .F.
3213:             ENDIF
3214:         CATCH TO loc_oErro
3215:             THIS.LockScreen = .F.
3216:             MsgErro(loc_oErro.Message + CHR(13) + ;
3217:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3218:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
3219:         ENDTRY
3220:     ENDPROC
3221: 
3222:     *==========================================================================
3223:     * GrdFontesAfterRowColChange - Recalcula os totalizadores da grade.
3224:     * Uso legitimo de AfterRowColChange (regra #46): nao valida CELULA, so
3225:     * agrega o cursor inteiro - igual ao legado, que tambem chama este
3226:     * evento manualmente apos cada INSERT/DELETE/GO (nao confia em disparo
3227:     * automatico do Grid para recalculo).
3228:     *==========================================================================
3229:     PROCEDURE GrdFontesAfterRowColChange(par_nColIndex)
3230:         THIS.RecalcularTotaisFontes()
3231:     ENDPROC
3232: 
3233:     *==========================================================================
3234:     * RecalcularTotaisFontes - Soma Count(1)/Sum(JBI_Valors) por EmpDopNums,
3235:     * igual ao legado (grdFontes.AfterRowColChange), e espelha nos
3236:     * totalizadores txt_4c_TotFontes/txt_4c_TotValores.
3237:     *==========================================================================
3238:     PROCEDURE RecalcularTotaisFontes()
3239:         LOCAL loc_cAlias, loc_nSoma, loc_nValors, loc_oErro
3240: 
3241:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3242:             RETURN
3243:         ENDIF
3244: 
3245:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
3246:         IF !USED(loc_cAlias)
3247:             RETURN
3248:         ENDIF
3249: 
3250:         TRY
3251:             SELECT empdopnums, COUNT(1) AS Soma, SUM(jbi_valors) AS Valors ;
3252:                 FROM (loc_cAlias) ;
3253:                 GROUP BY empdopnums ;
3254:                 INTO CURSOR cursor_4c_FontesTot
3255: 
3256:             IF RECCOUNT("cursor_4c_FontesTot") > 0
3257:                 GO TOP IN cursor_4c_FontesTot
3258:                 loc_nSoma   = cursor_4c_FontesTot.Soma
3259:                 loc_nValors = cursor_4c_FontesTot.Valors
3260:             ELSE
3261:                 loc_nSoma   = 0
3262:                 loc_nValors = 0
3263:             ENDIF
3264: 
3265:             IF USED("cursor_4c_FontesTot")
3266:                 USE IN cursor_4c_FontesTot
3267:             ENDIF
3268: 
3269:             THIS.pgf_4c_Job.Page5.txt_4c_TotFontes.Value  = TRANSFORM(loc_nSoma, "999,999,999")
3270:             THIS.pgf_4c_Job.Page5.txt_4c_TotValores.Value = TRANSFORM(loc_nValors, "999,999,999,999.99")
3271:             THIS.pgf_4c_Job.Page5.txt_4c_TotFontes.Refresh()
3272:             THIS.pgf_4c_Job.Page5.txt_4c_TotValores.Refresh()
3273:         CATCH TO loc_oErro
3274:             MsgErro(loc_oErro.Message + CHR(13) + ;
3275:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3276:                     "Procedure: " + loc_oErro.Procedure, "Erro em RecalcularTotaisFontes")
3277:         ENDTRY
3278:     ENDPROC
3279: 
3280:     *==========================================================================
3281:     * BOParaForm - Espelha as propriedades this_* do BO nos controles da tela.
3282:     * NESTA FASE cobre o cabecalho de identificacao do Job (raiz do form),
3283:     * Page1 (Briefing), Page2 (Desafio/Objetivos) e Page3 (Equipes). As
3284:     * paginas restantes (Materiais/Financeiro/Apresentacao) sao adicionadas
3285:     * nas proximas fases e este metodo sera estendido junto.
3286:     *==========================================================================
3287:     PROTECTED PROCEDURE BOParaForm()
3288:         LOCAL loc_oBO, loc_oPag1, loc_oPag2, loc_oPag3, loc_oCnt1, loc_oCnt2, loc_oErro
3289: 
3290:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3291:             RETURN
3292:         ENDIF
3293: 
3294:         TRY
3295:             loc_oBO   = THIS.this_oBusinessObject
3296:             loc_oPag1 = THIS.pgf_4c_Job.Page1
3297:             loc_oPag2 = THIS.pgf_4c_Job.Page2
3298: 
3299:             *-- Page1 - Briefing
3300:             loc_oPag1.txt_4c__01_001.Value = ConverterParaData(loc_oBO.this_dJb001)
3301:             loc_oPag1.txt_4c__01_002.Value = ConverterParaData(loc_oBO.this_dJb002)
3302:             loc_oPag1.obj_4c_Get_01_003.Value = loc_oBO.this_cJb003
3303:             loc_oPag1.obj_4c_Get_01_004.Value = loc_oBO.this_cJb004
3304:             loc_oPag1.obj_4c_Get_01_005.Value = loc_oBO.this_cJb005
3305:             loc_oPag1.obj_4c_Get_01_006.Value = loc_oBO.this_cJb006
3306:             loc_oPag1.obj_4c_Get_01_007.Value = loc_oBO.this_cJb007
3307:             loc_oPag1.obj_4c_Get_01_008.Value = loc_oBO.this_cJb008
3308:             loc_oPag1.txt_4c__01_017.Value = ConverterParaData(loc_oBO.this_dJb017)
3309:             loc_oPag1.txt_4c__01_018.Value = ConverterParaData(loc_oBO.this_dJb018)
3310:             loc_oPag1.txt_4c__01_019.Value = ConverterParaData(loc_oBO.this_dJb019)
3311:             loc_oPag1.txt_4c__01_020.Value = ConverterParaData(loc_oBO.this_dJb020)
3312:             loc_oPag1.obj_4c_Get_01_021.Value = loc_oBO.this_cJb021
3313:             loc_oPag1.obj_4c_Get_01_022.Value = loc_oBO.this_cJb022
3314:             loc_oPag1.obj_4c_Get_01_023.Value = loc_oBO.this_cJb023
3315: 
3316:             *-- Page2 - Desafio / Objetivos
3317:             loc_oPag2.obj_4c_Get_01_009.Value = loc_oBO.this_cJb009
3318:             loc_oPag2.obj_4c_Get_01_010.Value = loc_oBO.this_cJb010
3319:             loc_oPag2.obj_4c_Get_01_011.Value = loc_oBO.this_cJb011
3320:             loc_oPag2.obj_4c_Get_01_012.Value = loc_oBO.this_cJb012
3321:             loc_oPag2.obj_4c_Get_01_013.Value = loc_oBO.this_cJb013
3322:             loc_oPag2.obj_4c_Get_01_014.Value = loc_oBO.this_cJb014
3323:             loc_oPag2.obj_4c_Get_01_015.Value = loc_oBO.this_cJb015
3324:             loc_oPag2.obj_4c_Get_01_016.Value = loc_oBO.this_cJb016
3325: 
3326:             *-- Raiz do form - "Briefing Extra" (Jb_072, numeric(1,0)).
3327:             *-- CheckBox.Value eh NUMERICO: comparar explicitamente, nunca
3328:             *-- atribuir a property direto (IIF exige condicao LOGICA).
3329:             THIS.chk_4c_Get_Extra.Value = IIF(loc_oBO.this_nJb072 = 1, 1, 0)
3330: 
3331:             *-- Page3 - Equipes (codigos) e classificacao do Job
3332:             loc_oPag3 = THIS.pgf_4c_Job.Page3
3333:             loc_oCnt1 = loc_oPag3.cnt_4c_Emp1
3334:             loc_oCnt2 = loc_oPag3.cnt_4c_Emp2
3335: 
3336:             loc_oCnt1.txt_4c__01_024.Value = loc_oBO.this_cJb024
3337:             loc_oCnt1.txt_4c__01_025.Value = loc_oBO.this_cJb025
3338:             loc_oCnt1.txt_4c__01_026.Value = loc_oBO.this_cJb026
3339:             loc_oCnt1.txt_4c__01_027.Value = loc_oBO.this_cJb027
3340:             loc_oCnt1.txt_4c__01_028.Value = loc_oBO.this_cJb028
3341:             loc_oCnt1.txt_4c__01_029.Value = loc_oBO.this_cJb029
3342:             loc_oCnt1.txt_4c__01_030.Value = loc_oBO.this_cJb030
3343: 
3344:             loc_oCnt2.txt_4c__01_031.Value = loc_oBO.this_cJb031
3345:             loc_oCnt2.txt_4c__01_032.Value = loc_oBO.this_cJb032
3346:             loc_oCnt2.txt_4c__01_033.Value = loc_oBO.this_cJb033
3347:             loc_oCnt2.txt_4c__01_034.Value = loc_oBO.this_cJb034
3348:             loc_oCnt2.txt_4c__01_035.Value = loc_oBO.this_cJb035

*-- Linhas 3406 a 3514:
3406:         CATCH TO loc_oErro
3407:             MsgErro(loc_oErro.Message + CHR(13) + ;
3408:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3409:                     "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
3410:         ENDTRY
3411:     ENDPROC
3412: 
3413:     *==========================================================================
3414:     * HabilitarCampos - Aplica o "PROCEDURE When" do legado aos campos que so
3415:     * ficam editaveis em INCLUIR/ALTERAR. BINDEVENT em "When" nao funciona
3416:     * (regra #45.3 - o retorno do delegate eh descartado e nao bloqueia a
3417:     * edicao), entao a gate vira .Enabled direto, aplicado uma vez a partir
3418:     * do BOParaForm - este dialogo nao troca de modo depois de aberto
3419:     * (this_cModoAtual vem do form pai no Init e fica fixo pelo resto da
3420:     * vida do form, nao ha AlternarPagina/troca de modo em runtime aqui).
3421:     *
3422:     * Campos SEM When no dump (todos os outros TextBox/EditBox/CheckBox de
3423:     * Jb_003..016, 021..023, 024..044, 049..058, 062..075) ficam sempre
3424:     * editaveis, inclusive em VISUALIZAR - nao inventar gate que o legado
3425:     * nao tem (PILAR 1). A grade "Fontes Pagadoras" ja tem seu proprio guard
3426:     * (GrdFontesColumnWhen) e as equipes da Page3 o seu
3427:     * (AtualizarEstadoContasEquipe/AjustarNomeContaEquipe).
3428:     *==========================================================================
3429:     PROTECTED PROCEDURE HabilitarCampos()
3430:         LOCAL loc_lModoEdicao, loc_oPag1, loc_oPag4, loc_oErro
3431:         loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3432: 
3433:         TRY
3434:             *-- Page1 - as 2 datas de Apresentacao/Orcamento e as 4 do
3435:             *-- Periodo do Evento/Montagem (legado: get_01_001/002/017..020)
3436:             loc_oPag1 = THIS.pgf_4c_Job.Page1
3437:             loc_oPag1.txt_4c__01_001.Enabled = loc_lModoEdicao
3438:             loc_oPag1.txt_4c__01_002.Enabled = loc_lModoEdicao
3439:             loc_oPag1.txt_4c__01_017.Enabled = loc_lModoEdicao
3440:             loc_oPag1.txt_4c__01_018.Enabled = loc_lModoEdicao
3441:             loc_oPag1.txt_4c__01_019.Enabled = loc_lModoEdicao
3442:             loc_oPag1.txt_4c__01_020.Enabled = loc_lModoEdicao
3443: 
3444:             *-- Page4 - botoes "..." (GetDir) dos 5 campos de pasta/arquivo.
3445:             *-- O botao "Abrir" (b) nao tem When no dump - so le o caminho e
3446:             *-- abre o Explorer, inofensivo em qualquer modo; o EditBox e
3447:             *-- ReadOnly sempre (AdicionarCampoPastaMaterial), nao precisa
3448:             *-- gate por modo.
3449:             loc_oPag4 = THIS.pgf_4c_Job.Page4
3450:             loc_oPag4.cmd_4c_Btn_01_045.Enabled = loc_lModoEdicao
3451:             loc_oPag4.cmd_4c_Btn_01_046.Enabled = loc_lModoEdicao
3452:             loc_oPag4.cmd_4c_Btn_01_047.Enabled = loc_lModoEdicao
3453:             loc_oPag4.cmd_4c_Btn_01_048.Enabled = loc_lModoEdicao
3454:             loc_oPag4.cmd_4c_Btn_01_061.Enabled = loc_lModoEdicao
3455: 
3456:             *-- Raiz do form - Contatos com o Cliente (legado: getCabContatos)
3457:             THIS.obj_4c_GetCabContatos.Enabled = loc_lModoEdicao
3458:         CATCH TO loc_oErro
3459:             MsgErro(loc_oErro.Message + CHR(13) + ;
3460:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3461:                     "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
3462:         ENDTRY
3463:     ENDPROC
3464: 
3465:     *==========================================================================
3466:     * FormParaBO - Le os controles da tela para as propriedades this_* do BO.
3467:     * NESTA FASE cobre "Briefing Extra" (raiz), Page1 (Briefing), Page2
3468:     * (Desafio/Objetivos) e Page3 (Equipes) - ver comentario de BOParaForm
3469:     * sobre a extensao nas proximas fases.
3470:     *
3471:     * Os getCab* do cabecalho NAO entram aqui: sao somente-leitura e seus
3472:     * valores vem de SigMvCab/SigCdCli, nao de colunas de SigMvJbC.
3473:     *==========================================================================
3474:     PROTECTED PROCEDURE FormParaBO()
3475:         LOCAL loc_oBO, loc_oPag1, loc_oPag2, loc_oPag3, loc_oCnt1, loc_oCnt2, loc_oErro
3476: 
3477:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3478:             RETURN
3479:         ENDIF
3480: 
3481:         TRY
3482:             loc_oBO   = THIS.this_oBusinessObject
3483:             loc_oPag1 = THIS.pgf_4c_Job.Page1
3484:             loc_oPag2 = THIS.pgf_4c_Job.Page2
3485: 
3486:             *-- Page1 - Briefing
3487:             loc_oBO.this_dJb001 = ConverterParaData(loc_oPag1.txt_4c__01_001.Value)
3488:             loc_oBO.this_dJb002 = ConverterParaData(loc_oPag1.txt_4c__01_002.Value)
3489:             loc_oBO.this_cJb003 = loc_oPag1.obj_4c_Get_01_003.Value
3490:             loc_oBO.this_cJb004 = loc_oPag1.obj_4c_Get_01_004.Value
3491:             loc_oBO.this_cJb005 = loc_oPag1.obj_4c_Get_01_005.Value
3492:             loc_oBO.this_cJb006 = loc_oPag1.obj_4c_Get_01_006.Value
3493:             loc_oBO.this_cJb007 = loc_oPag1.obj_4c_Get_01_007.Value
3494:             loc_oBO.this_cJb008 = loc_oPag1.obj_4c_Get_01_008.Value
3495:             loc_oBO.this_dJb017 = ConverterParaData(loc_oPag1.txt_4c__01_017.Value)
3496:             loc_oBO.this_dJb018 = ConverterParaData(loc_oPag1.txt_4c__01_018.Value)
3497:             loc_oBO.this_dJb019 = ConverterParaData(loc_oPag1.txt_4c__01_019.Value)
3498:             loc_oBO.this_dJb020 = ConverterParaData(loc_oPag1.txt_4c__01_020.Value)
3499:             loc_oBO.this_cJb021 = loc_oPag1.obj_4c_Get_01_021.Value
3500:             loc_oBO.this_cJb022 = loc_oPag1.obj_4c_Get_01_022.Value
3501:             loc_oBO.this_cJb023 = loc_oPag1.obj_4c_Get_01_023.Value
3502: 
3503:             *-- Page2 - Desafio / Objetivos
3504:             loc_oBO.this_cJb009 = loc_oPag2.obj_4c_Get_01_009.Value
3505:             loc_oBO.this_cJb010 = loc_oPag2.obj_4c_Get_01_010.Value
3506:             loc_oBO.this_cJb011 = loc_oPag2.obj_4c_Get_01_011.Value
3507:             loc_oBO.this_cJb012 = loc_oPag2.obj_4c_Get_01_012.Value
3508:             loc_oBO.this_cJb013 = loc_oPag2.obj_4c_Get_01_013.Value
3509:             loc_oBO.this_cJb014 = loc_oPag2.obj_4c_Get_01_014.Value
3510:             loc_oBO.this_cJb015 = loc_oPag2.obj_4c_Get_01_015.Value
3511:             loc_oBO.this_cJb016 = loc_oPag2.obj_4c_Get_01_016.Value
3512: 
3513:             *-- Raiz do form - "Briefing Extra" (Jb_072, numeric(1,0))
3514:             loc_oBO.this_nJb072 = IIF(THIS.chk_4c_Get_Extra.Value = 1, 1, 0)

*-- Linhas 3520 a 3540:
3520:             *-- As colunas Jb_024..037 sao char(10) NOT NULL: ALLTRIM aqui
3521:             *-- (o SQL Server faz blank-padding ANSI em char) e o INSERT/UPDATE
3522:             *-- do BO fecha com PADR(..., 10), o MESMO tamanho do .MaxLength
3523:             *-- destes TextBox.
3524:             loc_oPag3 = THIS.pgf_4c_Job.Page3
3525:             loc_oCnt1 = loc_oPag3.cnt_4c_Emp1
3526:             loc_oCnt2 = loc_oPag3.cnt_4c_Emp2
3527: 
3528:             loc_oBO.this_cJb024 = ALLTRIM(loc_oCnt1.txt_4c__01_024.Value)
3529:             loc_oBO.this_cJb025 = ALLTRIM(loc_oCnt1.txt_4c__01_025.Value)
3530:             loc_oBO.this_cJb026 = ALLTRIM(loc_oCnt1.txt_4c__01_026.Value)
3531:             loc_oBO.this_cJb027 = ALLTRIM(loc_oCnt1.txt_4c__01_027.Value)
3532:             loc_oBO.this_cJb028 = ALLTRIM(loc_oCnt1.txt_4c__01_028.Value)
3533:             loc_oBO.this_cJb029 = ALLTRIM(loc_oCnt1.txt_4c__01_029.Value)
3534:             loc_oBO.this_cJb030 = ALLTRIM(loc_oCnt1.txt_4c__01_030.Value)
3535: 
3536:             loc_oBO.this_cJb031 = ALLTRIM(loc_oCnt2.txt_4c__01_031.Value)
3537:             loc_oBO.this_cJb032 = ALLTRIM(loc_oCnt2.txt_4c__01_032.Value)
3538:             loc_oBO.this_cJb033 = ALLTRIM(loc_oCnt2.txt_4c__01_033.Value)
3539:             loc_oBO.this_cJb034 = ALLTRIM(loc_oCnt2.txt_4c__01_034.Value)
3540:             loc_oBO.this_cJb035 = ALLTRIM(loc_oCnt2.txt_4c__01_035.Value)

*-- Linhas 3585 a 3700:
3585:         CATCH TO loc_oErro
3586:             MsgErro(loc_oErro.Message + CHR(13) + ;
3587:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3588:                     "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
3589:         ENDTRY
3590:     ENDPROC
3591: 
3592:     *==========================================================================
3593:     * TornarControlesVisiveis - Torna visiveis todos os controles criados via
3594:     * AddObject (que nascem com Visible=.F.), percorrendo Pages de PageFrame
3595:     * e Controls de Container/CommandGroup recursivamente.
3596:     *==========================================================================
3597:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3598:         LOCAL loc_nI, loc_oObjeto, loc_nP
3599: 
3600:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3601:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3602: 
3603:             IF VARTYPE(loc_oObjeto) = "O"
3604:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3605:                     loc_oObjeto.Visible = .T.
3606:                 ENDIF
3607: 
3608:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3609:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3610:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3611:                     ENDFOR
3612:                 ENDIF
3613: 
3614:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
3615:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3616:                 ENDIF
3617:             ENDIF
3618:         ENDFOR
3619:     ENDPROC
3620: 
3621:     *==========================================================================
3622:     * VincularChecagemObrigatorios - Liga ChecarCamposObrigatorios ao
3623:     * LostFocus de todo campo digitavel/marcavel da tela.
3624:     *
3625:     * No SCX legado isso esta escrito campo a campo: ~60 "PROCEDURE
3626:     * LostFocus" cujo corpo e' uma linha so, "ThisForm.ChecaObrigs()". O
3627:     * efeito e' que QUALQUER saida de campo repinta a marcacao de
3628:     * obrigatoriedade; reproduzir por varredura da arvore de controles da o
3629:     * mesmo resultado sem repetir 60 BINDEVENTs, e nao pode divergir da
3630:     * lista de campos quando uma aba mudar.
3631:     *
3632:     * LostFocus (nao KeyPress): o legado valida ao SAIR do campo, e o
3633:     * handler nao testa tecla nenhuma (regra #47). ChecarCamposObrigatorios
3634:     * nao tem parametros - LostFocus nao passa nenhum.
3635:     *
3636:     * O Grid fica de FORA: as celulas tem funil proprio
3637:     * (GrdFontesColumn4Valid / GrdFontesAfterRowColChange) e o legado nao
3638:     * liga ChecaObrigs a nenhuma coluna da grade.
3639:     *
3640:     * Os campos de conta da Page3 ganham um SEGUNDO delegate aqui, somado ao
3641:     * ValidarConta0NN/ValidarNomeConta0NN que ja tinham - exatamente como no
3642:     * legado, em que get_01_0NN declara Valid (lookup) E LostFocus
3643:     * (ChecaObrigs). Como este BINDEVENT e' registrado DEPOIS, ele roda
3644:     * DEPOIS do lookup, isto e' com o campo ja resolvido.
3645:     *==========================================================================
3646:     PROTECTED PROCEDURE VincularChecagemObrigatorios(par_oContainer)
3647:         LOCAL loc_nI, loc_oObj, loc_cBase, loc_nP
3648: 
3649:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3650:             loc_oObj = par_oContainer.Controls(loc_nI)
3651: 
3652:             IF VARTYPE(loc_oObj) = "O"
3653:                 loc_cBase = UPPER(loc_oObj.BaseClass)
3654: 
3655:                 DO CASE
3656:                     CASE loc_cBase = "GRID"
3657:                         *-- grade tem funil proprio - ver comentario acima
3658: 
3659:                     CASE INLIST(loc_cBase, "TEXTBOX", "EDITBOX", "CHECKBOX")
3660:                         BINDEVENT(loc_oObj, "LostFocus", THIS, "ChecarCamposObrigatorios")
3661: 
3662:                     CASE loc_cBase = "PAGEFRAME"
3663:                         FOR loc_nP = 1 TO loc_oObj.PageCount
3664:                             THIS.VincularChecagemObrigatorios(loc_oObj.Pages(loc_nP))
3665:                         ENDFOR
3666: 
3667:                     OTHERWISE
3668:                         IF PEMSTATUS(loc_oObj, "ControlCount", 5)
3669:                             IF loc_oObj.ControlCount > 0
3670:                                 THIS.VincularChecagemObrigatorios(loc_oObj)
3671:                             ENDIF
3672:                         ENDIF
3673:                 ENDCASE
3674:             ENDIF
3675:         ENDFOR
3676:     ENDPROC
3677: 
3678:     *==========================================================================
3679:     * ResolverControle - Devolve o objeto de controle no caminho
3680:     * par_cCaminho, SEMPRE relativo a THIS.pgf_4c_Job (ex.:
3681:     * "Page1.txt_4c__01_001", "Page3.cnt_4c_Emp1.txt_4c__01_024").
3682:     *
3683:     * Alcancar membro por NOME em VFP9 se faz com EVALUATE na LEITURA
3684:     * (regra #15/#34) - Controls("nome") estoura, e PEMSTATUS nao protege.
3685:     * O TYPE() antes do EVALUATE evita TRY/CATCH: caminho invalido devolve
3686:     * "U" sem erro, e CATCH aqui seria silencioso ou ruidoso demais (este
3687:     * metodo roda em laco de 69 posicoes).
3688:     *
3689:     * Devolve .NULL. quando o controle nao existe - acontece legitimamente
3690:     * em probe/harness, em que parte da tela pode nao ter sido criada.
3691:     *==========================================================================
3692:     PROTECTED FUNCTION ResolverControle(par_cCaminho)
3693:         LOCAL loc_cExpr
3694: 
3695:         IF VARTYPE(par_cCaminho) != "C"
3696:             RETURN .NULL.
3697:         ENDIF
3698:         IF EMPTY(par_cCaminho)
3699:             RETURN .NULL.
3700:         ENDIF

*-- Linhas 3779 a 3900:
3779:     * PEMSTATUS antes de atribuir porque propriedade que a classe nao tem
3780:     * estoura em runtime e derruba a tela (regra #33).
3781:     *==========================================================================
3782:     PROTECTED PROCEDURE MarcarCampoObrigatorio(par_cCaminho, par_lOk, par_cPropriedade)
3783:         LOCAL loc_oCtrl, loc_nCor
3784: 
3785:         loc_oCtrl = THIS.ResolverControle(par_cCaminho)
3786:         IF VARTYPE(loc_oCtrl) != "O"
3787:             RETURN
3788:         ENDIF
3789: 
3790:         loc_nCor = IIF(par_lOk, RGB(36, 84, 155), RGB(255, 0, 0))
3791: 
3792:         IF par_cPropriedade = "F"
3793:             IF PEMSTATUS(loc_oCtrl, "ForeColor", 5)
3794:                 loc_oCtrl.ForeColor = loc_nCor
3795:             ENDIF
3796:         ELSE
3797:             IF PEMSTATUS(loc_oCtrl, "BorderColor", 5)
3798:                 loc_oCtrl.BorderColor = loc_nCor
3799:             ENDIF
3800:         ENDIF
3801:     ENDPROC
3802: 
3803:     *==========================================================================
3804:     * ChecarCamposObrigatorios - Transcricao de "PROCEDURE checaobrigs" do
3805:     * SCX legado. Devolve "OK" ou "ERRO" e, no caminho, PINTA cada campo
3806:     * conferido de azul (atendido) ou vermelho (em falta).
3807:     *
3808:     * A obrigatoriedade NAO esta no codigo: vem da MASCARA POSICIONAL
3809:     * SigOpCdI.job_mv_obr, em que o caractere da posicao N vale "1" quando o
3810:     * campo N desta lista e obrigatorio NESTA operacao
3811:     * (BO.CampoObrigatorio). Sem mascara carregada nada e' obrigatorio e o
3812:     * metodo devolve "OK" pintando tudo de azul - comportamento neutro.
3813:     *
3814:     * A lista de 69 posicoes e a ORDEM dela sao regra de negocio: e' a
3815:     * mascara que as indexa, logo reordenar ou "compactar" os indices vagos
3816:     * muda qual campo cada "1" da mascara torna obrigatorio (regra #17 -
3817:     * transcrever, nunca reescrever). Por isso os indices sem campo proprio
3818:     * (membros de grupo de CheckBox, conferidos pelo rotulo do grupo) ficam
3819:     * EXPLICITOS na lista, com caminho vazio, em vez de omitidos.
3820:     *
3821:     * DUAS PECULIARIDADES DO LEGADO, PRESERVADAS DE PROPOSITO:
3822:     *
3823:     * 1. O indice 65 ("Outras Receitas") le a mascara na posicao 69, nao na
3824:     *    65 - "Substr(Nvl(crSigOpCdI.JOB_MV_OBR, []), 69, 1)" esta escrito
3825:     *    literalmente assim no SCX.
3826:     *
3827:     * 2. As duas guardas que deveriam DISPENSAR os campos de equipe quando o
3828:     *    bloco esta oculto estao escritas no SCX como
3829:     *    "If InList(22, 23, 24, 25, 26, 27, 28) And Not ...cntEmp1.Visible" -
3830:     *    sem "lnCnt" como primeiro argumento. InList(22, 23, ..., 28) testa
3831:     *    se 22 esta em {23..28}, ou seja e' SEMPRE .F., e a dispensa nunca
3832:     *    acontece no legado. Reproduzido como esta (e nao "corrigido"):
3833:     *    ativar a dispensa mudaria quais campos bloqueiam o retorno, que e'
3834:     *    justamente a regra que esta mascara existe para definir. A terceira
3835:     *    InList do mesmo bloco traz "lnCnt" e funciona - e' ela que pinta
3836:     *    tambem o campo de NOME da linha de equipe.
3837:     *
3838:     * PUBLIC: chamado por BINDEVENT nos LostFocus dos campos (regra #3) e
3839:     * por CmdRetornarClick.
3840:     *==========================================================================
3841:     PROCEDURE ChecarCamposObrigatorios()
3842:         LOCAL loc_cRet, loc_lOks, loc_nI, loc_oBO, loc_lObrig, loc_oErro
3843:         LOCAL ARRAY loc_aCpo[69]
3844: 
3845:         loc_cRet = "OK"
3846: 
3847:         *-- RETURN fora do TRY (regra #1)
3848:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3849:             RETURN loc_cRet
3850:         ENDIF
3851:         loc_oBO = THIS.this_oBusinessObject
3852: 
3853:         *-- Caminhos relativos a THIS.pgf_4c_Job, na MESMA ordem do laCpo
3854:         *-- legado. "" = indice sem campo proprio (membro de grupo).
3855:         *-- Pagina 1 (Briefing)
3856:         loc_aCpo[01] = "Page1.txt_4c__01_001"              && Apresentacao
3857:         loc_aCpo[02] = "Page1.txt_4c__01_002"              && Orcamento
3858:         loc_aCpo[03] = "Page1.txt_4c__01_017"              && Periodo do Evento
3859:         loc_aCpo[04] = "Page1.txt_4c__01_019"              && Periodo de Montagem
3860:         loc_aCpo[05] = "Page1.obj_4c_Get_01_022"           && Publico Estimado
3861:         loc_aCpo[06] = "Page1.obj_4c_Get_01_023"           && Budget Estimado
3862:         loc_aCpo[07] = "Page1.obj_4c_Get_01_021"           && Local do Evento
3863:         loc_aCpo[08] = "Page1.obj_4c_Get_01_003"           && Sobre o que estamos falando
3864:         loc_aCpo[09] = "Page1.obj_4c_Get_01_004"           && Historico
3865:         loc_aCpo[10] = "Page1.obj_4c_Get_01_005"           && Contexto Mercadologico
3866:         loc_aCpo[11] = "Page1.obj_4c_Get_01_006"           && Cenario
3867:         loc_aCpo[12] = "Page1.obj_4c_Get_01_007"           && Target
3868:         loc_aCpo[13] = "Page1.obj_4c_Get_01_008"           && O problema
3869:         *-- Pagina 2 (Briefing Continuacao)
3870:         loc_aCpo[14] = "Page2.obj_4c_Get_01_009"           && Desafio
3871:         loc_aCpo[15] = "Page2.obj_4c_Get_01_010"           && Objetivos
3872:         loc_aCpo[16] = "Page2.obj_4c_Get_01_011"           && Tom de voz
3873:         loc_aCpo[17] = "Page2.obj_4c_Get_01_012"           && Inspiracoes
3874:         loc_aCpo[18] = "Page2.obj_4c_Get_01_013"           && Cliente
3875:         loc_aCpo[19] = "Page2.obj_4c_Get_01_014"           && Sugestoes
3876:         loc_aCpo[20] = "Page2.obj_4c_Get_01_015"           && Comunicacao
3877:         loc_aCpo[21] = "Page2.obj_4c_Get_01_016"           && Infos do local do evento
3878:         *-- Pagina 3 (Informacoes Gerais) - bloco de equipe 1
3879:         loc_aCpo[22] = "Page3.cnt_4c_Emp1.txt_4c__01_024"  && Atendimento
3880:         loc_aCpo[23] = "Page3.cnt_4c_Emp1.txt_4c__01_025"  && Comercial
3881:         loc_aCpo[24] = "Page3.cnt_4c_Emp1.txt_4c__01_028"  && Arquiteto
3882:         loc_aCpo[25] = "Page3.cnt_4c_Emp1.txt_4c__01_026"  && Gerencia de Projeto
3883:         loc_aCpo[26] = "Page3.cnt_4c_Emp1.txt_4c__01_029"  && Orcamento
3884:         loc_aCpo[27] = "Page3.cnt_4c_Emp1.txt_4c__01_027"  && Criacao
3885:         loc_aCpo[28] = "Page3.cnt_4c_Emp1.txt_4c__01_030"  && Montagem
3886:         *-- Pagina 3 - bloco de equipe 2
3887:         loc_aCpo[29] = "Page3.cnt_4c_Emp2.txt_4c__01_031"  && Lider de Projeto
3888:         loc_aCpo[30] = "Page3.cnt_4c_Emp2.txt_4c__01_032"  && Atendimento
3889:         loc_aCpo[31] = "Page3.cnt_4c_Emp2.txt_4c__01_035"  && Planejamento
3890:         loc_aCpo[32] = "Page3.cnt_4c_Emp2.txt_4c__01_033"  && Comercial
3891:         loc_aCpo[33] = "Page3.cnt_4c_Emp2.txt_4c__01_036"  && Producao
3892:         loc_aCpo[34] = "Page3.cnt_4c_Emp2.txt_4c__01_034"  && Criacao
3893:         loc_aCpo[35] = "Page3.cnt_4c_Emp2.txt_4c__01_037"  && Producao Financeira
3894:         *-- Pagina 3 - grupos de CheckBox (conferidos pelo rotulo da secao)
3895:         loc_aCpo[36] = "Page3.lbl_4c_Lbl_02_003"           && Tipo de Projeto
3896:         loc_aCpo[37] = ""                                  && Concorrencia
3897:         loc_aCpo[38] = ""                                  && Licitacao
3898:         loc_aCpo[39] = ""                                  && Proprietario
3899:         loc_aCpo[40] = "Page3.lbl_4c_Lbl_02_004"           && Tipo de Desenvolvimento
3900:         loc_aCpo[41] = ""                                  && Producao

*-- Linhas 4081 a 4143:
4081:         CATCH TO loc_oErro
4082:             MsgErro(loc_oErro.Message + CHR(13) + ;
4083:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4084:                     "Procedure: " + loc_oErro.Procedure, "Erro em ChecarCamposObrigatorios")
4085:         ENDTRY
4086: 
4087:         RETURN loc_cRet
4088:     ENDPROC
4089: 
4090:     *==========================================================================
4091:     * AplicarTitulosPersonalizados - Transcricao de "PROCEDURE carregatits"
4092:     * (titulos de aba/secao) mais o unico site de job_mv_cpo que o SCX usa
4093:     * (o rotulo do "Briefing Extra", dentro de carregacabs).
4094:     *
4095:     * Cada titulo vive num bloco de 50 caracteres numa POSICAO FIXA de
4096:     * SigOpCdI.job_mv_tit, e o legado so sobrescreve o Caption quando vem
4097:     * texto ("If Not Empty(...)") - sem parametrizacao a tela fica com os
4098:     * captions transcritos do SCX. Mesma postura aqui.
4099:     *
4100:     * A posicao 551 existe no legado e esta COMENTADA la ("Nao Colocado na
4101:     * Tela Ainda"); nao ha controle para ela e por isso nao aparece aqui.
4102:     *==========================================================================
4103:     PROTECTED PROCEDURE AplicarTitulosPersonalizados()
4104:         LOCAL loc_oBO, loc_cTexto, loc_oErro
4105: 
4106:         *-- RETURN fora do TRY (regra #1)
4107:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
4108:             RETURN
4109:         ENDIF
4110:         loc_oBO = THIS.this_oBusinessObject
4111: 
4112:         TRY
4113:             *-- 101: Caption da Page1 e, com sufixo, da Page2
4114:             loc_cTexto = loc_oBO.ObterTituloPersonalizado(101)
4115:             IF !EMPTY(loc_cTexto)
4116:                 THIS.pgf_4c_Job.Page1.Caption = loc_cTexto
4117:                 THIS.pgf_4c_Job.Page2.Caption = loc_cTexto + " Continua" + ;
4118:                                                 CHR(231) + CHR(227) + "o"
4119:             ENDIF
4120: 
4121:             *-- 151 / 201: rotulos dos dois blocos de equipe da Page3
4122:             loc_cTexto = loc_oBO.ObterTituloPersonalizado(151)
4123:             IF !EMPTY(loc_cTexto)
4124:                 THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.lbl_4c_Lbl_02_001.Caption = loc_cTexto
4125:             ENDIF
4126: 
4127:             loc_cTexto = loc_oBO.ObterTituloPersonalizado(201)
4128:             IF !EMPTY(loc_cTexto)
4129:                 THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.lbl_4c_Lbl_02_002.Caption = loc_cTexto
4130:             ENDIF
4131: 
4132:             *-- 251 / 301: secoes "Tipo de Projeto" e "Tipo de Desenvolvimento"
4133:             loc_cTexto = loc_oBO.ObterTituloPersonalizado(251)
4134:             IF !EMPTY(loc_cTexto)
4135:                 THIS.pgf_4c_Job.Page3.lbl_4c_Lbl_02_003.Caption = loc_cTexto
4136:             ENDIF
4137: 
4138:             loc_cTexto = loc_oBO.ObterTituloPersonalizado(301)
4139:             IF !EMPTY(loc_cTexto)
4140:                 THIS.pgf_4c_Job.Page3.lbl_4c_Lbl_02_004.Caption = loc_cTexto
4141:             ENDIF
4142: 
4143:             *-- 351: secao "Infos Clientes" da Page4

*-- Linhas 4178 a 4299:
4178:         CATCH TO loc_oErro
4179:             MsgErro(loc_oErro.Message + CHR(13) + ;
4180:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4181:                     "Procedure: " + loc_oErro.Procedure, "Erro em AplicarTitulosPersonalizados")
4182:         ENDTRY
4183:     ENDPROC
4184: 
4185:     *==========================================================================
4186:     * AplicarVisibilidadeEquipes - Mostra/esconde os dois blocos de equipe da
4187:     * Page3 conforme SigCdEmp.divnotas da empresa do movimento. Transcricao
4188:     * do "Do Case" do Init legado:
4189:     *
4190:     *   Case (lnEmp = 2) && Um      -> cntEmp1 visivel, cntEmp2 oculto
4191:     *   Case (lnEmp = 3) && Dois    -> cntEmp2 assume o Left de cntEmp1,
4192:     *                                  cntEmp1 oculto, cntEmp2 visivel
4193:     *   Case (lnEmp = 4) && Nenhuma -> os dois ocultos
4194:     *
4195:     * Nao ha "Otherwise": com divnotas 1 (ou qualquer outro valor) o legado
4196:     * deixa os dois blocos como nasceram, e e' o que acontece aqui.
4197:     *
4198:     * TEM DE RODAR DEPOIS DE TornarControlesVisiveis(), que forca
4199:     * Visible = .T. em tudo e apagaria esta regra - mesma armadilha
4200:     * documentada para toda regra de visibilidade por modo.
4201:     *==========================================================================
4202:     PROTECTED PROCEDURE AplicarVisibilidadeEquipes()
4203:         LOCAL loc_oPag, loc_nDiv, loc_oErro
4204: 
4205:         *-- RETURN fora do TRY (regra #1)
4206:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
4207:             RETURN
4208:         ENDIF
4209: 
4210:         TRY
4211:             loc_oPag = THIS.pgf_4c_Job.Page3
4212:             loc_nDiv = THIS.this_oBusinessObject.this_nDivNotas
4213: 
4214:             DO CASE
4215:                 CASE loc_nDiv = 2
4216:                     loc_oPag.cnt_4c_Emp1.Visible = .T.
4217:                     loc_oPag.cnt_4c_Emp2.Visible = .F.
4218: 
4219:                 CASE loc_nDiv = 3
4220:                     loc_oPag.cnt_4c_Emp2.Left    = loc_oPag.cnt_4c_Emp1.Left
4221:                     loc_oPag.cnt_4c_Emp1.Visible = .F.
4222:                     loc_oPag.cnt_4c_Emp2.Visible = .T.
4223: 
4224:                 CASE loc_nDiv = 4
4225:                     loc_oPag.cnt_4c_Emp1.Visible = .F.
4226:                     loc_oPag.cnt_4c_Emp2.Visible = .F.
4227:             ENDCASE
4228:         CATCH TO loc_oErro
4229:             MsgErro(loc_oErro.Message + CHR(13) + ;
4230:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4231:                     "Procedure: " + loc_oErro.Procedure, "Erro em AplicarVisibilidadeEquipes")
4232:         ENDTRY
4233:     ENDPROC
4234: 
4235:     *==========================================================================
4236:     * CmdRetornarClick - Fecha o dialogo de Complementos do Job (legado:
4237:     * SIGOPJOB.cmdRetornar.btnRetornar.Click). Em INCLUIR/ALTERAR, ANTES de
4238:     * fechar: remove da grade "Fontes Pagadoras" as linhas em branco deixadas
4239:     * pela edicao - transcricao de "Delete From crSigMvJbI Where Empty(
4240:     * JBI_Fontes) Or Empty(JBI_Modelos)" - e GRAVA o complemento (FormParaBO +
4241:     * BO.Salvar() + BO.PersistirFontes()).
4242:     *
4243:     * O legado nao precisa gravar aqui: o TextBox ja esta ligado por
4244:     * ControlSource ao cursor BUFFERED do form pai, e o TableUpdate acontece
4245:     * quando o movimento inteiro e salvo (fora deste dialogo). Nesta
4246:     * arquitetura em camadas o BO grava com SQLEXEC explicito, e so ha um
4247:     * ponto de saida (Retornar) para persistir - fechar sem gravar perderia
4248:     * tudo o que foi digitado. Em VISUALIZAR fecha direto, sem gravar nada
4249:     * (igual ao legado, que tambem so limpa a grade e fecha).
4250:     *
4251:     * Se Salvar()/PersistirFontes() falhar, o dialogo NAO fecha (a falha ja
4252:     * foi exibida pelo proprio BO - regra "CATCH nunca silencioso" /
4253:     * "ExibirFalha") e o usuario pode corrigir e tentar de novo.
4254:     *
4255:     * PUBLIC (BINDEVENT exige - regra #3). THIS.Release() dispara Destroy()
4256:     * na cadeia de heranca, que reabilita THIS.this_oFormPai (equivalente ao
4257:     * "PROCEDURE Release / ThisForm.ParentForm.Enabled = .t." do SCX legado).
4258:     *==========================================================================
4259:     PROCEDURE CmdRetornarClick()
4260:         LOCAL loc_cAlias, loc_lEmEdicao, loc_lSalvou, loc_lProsseguir, loc_oErro
4261:         loc_lEmEdicao   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
4262:         loc_lSalvou     = .T.
4263:         loc_lProsseguir = .T.
4264: 
4265:         *-- Campos obrigatorios em falta: o legado reconfere ChecaObrigs aqui
4266:         *-- (nao confia na marcacao deixada pelos LostFocus) e, se houver
4267:         *-- pendencia, PERGUNTA se o usuario quer corrigir agora. Respondendo
4268:         *-- SIM ele devolve .f. e a tela NAO fecha nem grava - os campos ficam
4269:         *-- vermelhos para conferencia. Respondendo NAO, segue e fecha.
4270:         *-- MsgConfirma devolve LOGICAL, nunca 6 (regra #7).
4271:         IF loc_lEmEdicao
4272:             IF THIS.ChecarCamposObrigatorios() = "ERRO"
4273:                 IF MsgConfirma("Existem Campos Obrigat" + CHR(243) + "rios Que N" + CHR(227) + ;
4274:                                "o Foram Preenchidos!!!" + CHR(13) + ;
4275:                                "Esses Campos Est" + CHR(227) + "o Marcados em Vermelho Para Verifica" + ;
4276:                                CHR(231) + CHR(227) + "o" + CHR(13) + ;
4277:                                "E N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + ;
4278:                                "vel Salvar a Movimenta" + CHR(231) + CHR(227) + "o Sem Preench" + ;
4279:                                CHR(234) + "-los." + CHR(13) + ;
4280:                                "Deseja Corrigir Esses Campos Agora?", ;
4281:                                "Aten" + CHR(231) + CHR(227) + "o!!!")
4282:                     loc_lProsseguir = .F.
4283:                 ENDIF
4284:             ENDIF
4285:         ENDIF
4286: 
4287:         *-- RETURN fora do TRY (regra #1)
4288:         IF !loc_lProsseguir
4289:             RETURN
4290:         ENDIF
4291: 
4292:         TRY
4293:             IF loc_lEmEdicao AND VARTYPE(THIS.this_oBusinessObject) = "O"
4294:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
4295:                 IF USED(loc_cAlias)
4296:                     SELECT (loc_cAlias)
4297:                     DELETE FOR EMPTY(jbi_fontes) OR EMPTY(jbi_modelos)
4298:                     GO BOTTOM
4299:                 ENDIF

*-- Linhas 4309 a 4334:
4309:             loc_lSalvou = .F.
4310:             MsgErro(loc_oErro.Message + CHR(13) + ;
4311:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4312:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdRetornarClick")
4313:         ENDTRY
4314: 
4315:         IF loc_lSalvou
4316:             THIS.Release()
4317:         ENDIF
4318:     ENDPROC
4319: 
4320:     *==========================================================================
4321:     * Destroy - Reabilita o form pai (equivalente ao Click legado de
4322:     * cmdRetornar, repetido aqui para cobrir fechamento pelo X da janela ou
4323:     * ESC) antes de delegar para FormBase.Destroy (libera this_oBusinessObject
4324:     * e restaura o menu principal).
4325:     *==========================================================================
4326:     PROCEDURE Destroy()
4327:         IF VARTYPE(THIS.this_oFormPai) = "O"
4328:             THIS.this_oFormPai.Enabled = .T.
4329:         ENDIF
4330: 
4331:         DODEFAULT()
4332:     ENDPROC
4333: 
4334: ENDDEFINE

