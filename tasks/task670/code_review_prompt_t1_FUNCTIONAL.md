# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (24)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCdEmpresaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCdEmpresaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDsEmpresaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDsEmpresaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarOperacaoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarOperacaoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarIndustriaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarIndustriaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCodProdutoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCodProdutoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDescProdutoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDescProdutoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCdGrEstoqueLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCdGrEstoqueLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDsGrEstoqueLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDsGrEstoqueLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarCdEstoqueLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarCdEstoqueLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDsEstoqueLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDsEstoqueLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGrandeGrupoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGrandeGrupoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGrupoProdutoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGrupoProdutoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDescGrupoProdutoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDescGrupoProdutoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarSubgrupoCodLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarSubgrupoCodLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarSubgrupoDescLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarSubgrupoDescLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGrupoVendaCodLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGrupoVendaCodLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGrupoVendaDescLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGrupoVendaDescLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarLinhaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarLinhaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarLocalProdutoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarLocalProdutoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarLocalEtiquetaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarLocalEtiquetaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarPromocaoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarPromocaoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRRET): Top original=240 vs migrado 'lbl_4c_Label17' Top=394 (diff=154px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRRET): Left original=636 vs migrado 'lbl_4c_Label17' Left=227 (diff=409px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRet.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2501 linhas total):

*-- Linhas 11 a 63:
11: * analise completa.
12: *
13: * Fase 1/2 (ja concluidas): SigPrRetBO.prg (propriedades + metodos de carga)
14: * Fase 3 (ja concluida): estrutura base do Form - Init/InicializarForm e o
15: *   cabecalho (cntSombra do legado).
16: * Fase 4 (ja concluida): CommandGroup "sair" (Consulta/Digitacao/Arquivadas/
17: *   Encerrar - estrutura visual; Click entra nas fases 7/8).
18: * Fase 5 (ja concluida): primeira metade dos campos de filtro (Periodo,
19: *   Empresa, Operacao, Chk_Preco, Codigo/Etiquetas, Grupo Estoque).
20: * Fase 6 (ja concluida): segunda metade dos campos de filtro (Industria,
21: *   Estoque, Grande Grupo, Grupo/Subgrupo Produto, Grupo Venda, Linha,
22: *   Local do Produto/Etiqueta, Promocao, Ordem, Marca) + TODOS os lookups
23: *   (BINDEVENT "LostFocus" + THIS.AbrirLookupCanonico de FormBase) e as
24: *   dependencias entre campos (AjustarDependenciasCampos, equivalente aos
25: *   "When" do legado).
26: *
27: * Fase 7 (ja concluida): EVENTOS PRINCIPAIS do CommandGroup "sair" - os
28: * QUATRO botoes reais do legado (Consulta/Encerrar/Digitacao/Arquivadas) e
29: * FormParaBO(). Nao ha barra CRUD (Incluir/Alterar/Visualizar/Excluir)
30: * porque o legado NAO tem essa barra: o SCX herda de "form" puro (nao de
31: * frmcadastro), nao tem Grupo_Op nem pcEscolha - inventar os quatro verbos
32: * violaria o PILAR 1.
33: *
34: * Fase 8 (este arquivo): EVENTOS AUXILIARES e CONSOLIDACAO.
35: *
36: *   1) BOParaForm() - sentido inverso de FormParaBO(), campo a campo. Quem
37: *      alimenta o BO por fora da digitacao precisa dele para a tela mostrar
38: *      o que vai ser consultado;
39: *   2) AplicarFixaEmpresa() / FixarEmpresaNaTela() - a regra "fixa empresa"
40: *      do Init do legado (SigCdPac.fixaemp = 1 trava o campo Empresa na
41: *      empresa do sistema e resolve a Razao Social). Estava inteiramente
42: *      ausente: o BO ja tinha CarregarParametros() e this_nFixaEmpresa, mas
43: *      NADA no form os chamava, entao o filtro Empresa ficava livre numa
44: *      instalacao que o legado trava - divergencia silenciosa, sem erro na
45: *      tela;
46: *   3) AjustarDependenciasCampos() - os 14 "When" do SCX, revisados um a um
47: *      contra o dump. Dois estavam errados: get_ds_empresa tinha a condicao
48: *      INVERTIDA (a Razao Social, que eh a via alternativa de busca, ficava
49: *      desabilitada justamente com o codigo vazio - e preencher o codigo ja
50: *      preenche a descricao, entao o campo era inalcancavel) e
51: *      get_Ds_GrEstoque nao tinha condicao nenhuma;
52: *   4) DespacharImpressao() - funil unico do "Do Form SigOpIpE With
53: *      ThisForm" dos tres botoes de acao, com TRY cobrindo SO a chamada e
54: *      com a ausencia de SigOpIpE reportada por NOME;
55: *   5) BtnDigitacaoClick / BtnArquivadasClick - o reset de filtros passou a
56: *      sair de SigPrRetBO.LimparDados() (reset COMPLETO) em vez da copia da
57: *      lista do legado: o legado eh modal e recria as PRIVATE a cada clique,
58: *      o form migrado nao fecha entre um clique e outro, e o que a lista do
59: *      legado nao cita (Industria, SubGrupo, Linha, Local, Localizacao,
60: *      Qtd. de Etiquetas) vazava de uma CONSULTA anterior.
61: *
62: * NAO SE APLICAM a esta tela, e por isso NAO foram inventados:
63: *   - CarregarLista / FormatarGridLista: o SCX nao tem Grid, nem PageFrame,

*-- Linhas 103 a 231:
103:     this_oBusinessObject = .NULL.
104: 
105:     *--------------------------------------------------------------------------
106:     * Guarda de reentrancia para os lookups (FormBuscaAuxiliar eh MODAL e
107:     * dispara LostFocus de novo ao tirar/devolver o foco - regra #47/#37)
108:     *--------------------------------------------------------------------------
109:     this_lEmLookup = .F.
110: 
111:     *--------------------------------------------------------------------------
112:     * this_cTipo - equivalente a ThisForm.Tipo do legado (propriedade custom
113:     * do SCX): sinaliza para SigOpIpE (fora do escopo) qual dos tres botoes
114:     * (Consulta/Digitacao/Arquivadas) disparou a chamada.
115:     *--------------------------------------------------------------------------
116:     this_cTipo = ""
117: 
118:     *==========================================================================
119:     * Init
120:     * DODEFAULT() -> FormBase.Init() -> InicializarForm()
121:     * FormBase.Init() tambem corrige SET DATE/CENTURY para DataSession=2
122:     *==========================================================================
123:     PROCEDURE Init()
124:         RETURN DODEFAULT()
125:     ENDPROC
126: 
127:     *==========================================================================
128:     * InicializarForm
129:     * Cria o Business Object e monta a estrutura visual base (cabecalho).
130:     * Campos de filtro e botoes de acao sao adicionados nas proximas fases.
131:     *==========================================================================
132:     PROTECTED PROCEDURE InicializarForm()
133:         LOCAL loc_lSucesso, loc_oErro
134: 
135:         loc_lSucesso = .F.
136: 
137:         TRY
138:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrRetBO")
139: 
140:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
141:                 MsgErro("Erro ao criar SigPrRetBO." + CHR(13) + ;
142:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
143:                         "Erro em FormSigPrRet.InicializarForm")
144:             ELSE
145:                 IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
146:                     THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
147:                 ENDIF
148: 
149:                 THIS.ConfigurarPageFrame()
150: 
151:                 *-- Regra "fixa empresa" do Init do legado (SigCdPac.fixaemp)
152:                 THIS.AplicarFixaEmpresa()
153: 
154:                 THIS.TornarControlesVisiveis(THIS)
155: 
156:                 loc_lSucesso = .T.
157:             ENDIF
158: 
159:         CATCH TO loc_oErro
160:             MsgErro(loc_oErro.Message + CHR(13) + ;
161:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
162:                     "Procedure: " + loc_oErro.Procedure, ;
163:                     "Erro em FormSigPrRet.InicializarForm")
164:         ENDTRY
165: 
166:         RETURN loc_lSucesso
167:     ENDPROC
168: 
169:     *==========================================================================
170:     * ConfigurarPageFrame
171:     * SigPrRet (SCX legado, Width=1000 Height=600) eh dialogo PLANO sem
172:     * PageFrame real (PILAR 1: manter layout flat identico ao legado em vez
173:     * de introduzir abas artificialmente). Orquestra a montagem visual
174:     * delegando para os helpers dedicados por regiao.
175:     *==========================================================================
176:     PROTECTED PROCEDURE ConfigurarPageFrame()
177:         THIS.ConfigurarCabecalho()
178:         THIS.ConfigurarBotoesAcao()
179:         THIS.ConfigurarPaginaDados()
180:         THIS.ConfigurarEventosLookup()
181:         THIS.ConfigurarEventosBotoes()
182:         THIS.AjustarDependenciasCampos()
183:     ENDPROC
184: 
185:     *==========================================================================
186:     * ConfigurarCabecalho
187:     * Container cinza escuro com titulos sobrepostos (cntSombra do legado)
188:     * Nomes conforme mapeamento.json: cnt_4c_Sombra / lbl_4c_LblSombra /
189:     * lbl_4c_LblTitulo.
190:     *==========================================================================
191:     PROTECTED PROCEDURE ConfigurarCabecalho()
192:         THIS.AddObject("cnt_4c_Sombra", "Container")
193:         WITH THIS.cnt_4c_Sombra
194:             .Top         = 0
195:             .Left        = 0
196:             .Width       = THIS.Width
197:             .Height      = 80
198:             .BorderWidth = 0
199:             .BackStyle   = 1
200:             .BackColor   = RGB(100,100,100)
201:             .Visible     = .T.
202:         ENDWITH
203: 
204:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
205:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
206:             .FontBold      = .T.
207:             .FontName      = "Tahoma"
208:             .FontSize      = 18
209:             .FontUnderline = .F.
210:             .WordWrap      = .T.
211:             .Alignment     = 0
212:             .AutoSize      = .F.
213:             .BackStyle     = 0
214:             .Height        = 40
215:             .Left          = 10
216:             .Top           = 18
217:             .Width         = THIS.Width - 20
218:             .ForeColor     = RGB(0,0,0)
219:             .Caption       = THIS.Caption
220:             .Visible       = .T.
221:         ENDWITH
222: 
223:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
224:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
225:             .FontBold      = .T.
226:             .FontName      = "Tahoma"
227:             .FontSize      = 18
228:             .WordWrap      = .T.
229:             .Alignment     = 0
230:             .AutoSize      = .F.
231:             .BackStyle     = 0

*-- Linhas 259 a 302:
259:     * (7 e 8), apos os campos de filtro que esses metodos leem existirem
260:     * no form.
261:     *==========================================================================
262:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
263:         THIS.AddObject("obj_4c_Sair", "CommandGroup")
264:         WITH THIS.obj_4c_Sair
265:             .AutoSize     = .T.
266:             .Top          = -2
267:             .Left         = 689
268:             .Width        = 313
269:             .Height       = 85
270:             .ButtonCount  = 4
271:             .BackStyle    = 0
272:             .BorderStyle  = 0
273:             .SpecialEffect = 1
274:             .BorderColor  = RGB(136,189,188)
275:             .Themes       = .F.
276:             .Value        = 1
277:         ENDWITH
278: 
279:         WITH THIS.obj_4c_Sair.Buttons(1)
280:             .AutoSize   = .F.
281:             .Top        = 5
282:             .Left       = 5
283:             .Height     = 75
284:             .Width      = 75
285:             .FontBold   = .T.
286:             .FontItalic = .T.
287:             .FontName   = "Comic Sans MS"
288:             .FontSize   = 8
289:             .WordWrap   = .T.
290:             .Picture    = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
291:             .Caption    = "\<Consulta"
292:             .ForeColor  = RGB(90,90,90)
293:             .BackColor  = RGB(255,255,255)
294:             .Themes     = .F.
295:         ENDWITH
296: 
297:         WITH THIS.obj_4c_Sair.Buttons(2)
298:             .AutoSize   = .F.
299:             .Top        = 5
300:             .Left       = 233
301:             .Height     = 75
302:             .Width      = 75

*-- Linhas 353 a 442:
353:     *==========================================================================
354:     * ConfigurarEventosBotoes
355:     * Liga os 4 botoes do CommandGroup "sair" aos handlers reais (Fase 7/8).
356:     * BINDEVENT direto em cada Buttons(N) (nao em obj_4c_Sair.Click) porque
357:     * cada botao do legado tinha o PROPRIO Click (consulta.Click/sair.Click/
358:     * btnDigitacao.Click/Arquivadas.Click), nao um Click unico de grupo com
359:     * Do Case Value. Handlers precisam ser PUBLIC (regra #3).
360:     *==========================================================================
361:     PROTECTED PROCEDURE ConfigurarEventosBotoes()
362:         BINDEVENT(THIS.obj_4c_Sair.Buttons(1), "Click", THIS, "BtnConsultaClick")
363:         BINDEVENT(THIS.obj_4c_Sair.Buttons(2), "Click", THIS, "BtnEncerrarClick")
364:         BINDEVENT(THIS.obj_4c_Sair.Buttons(3), "Click", THIS, "BtnDigitacaoClick")
365:         BINDEVENT(THIS.obj_4c_Sair.Buttons(4), "Click", THIS, "BtnArquivadasClick")
366:     ENDPROC
367: 
368:     *==========================================================================
369:     * ConfigurarPaginaDados
370:     * SigPrRet nao tem PageFrame (dialogo FLAT - ver ConfigurarPageFrame): os
371:     * campos de filtro vao direto em THIS, nas mesmas coordenadas do SCX
372:     * legado (cntSombra/cabecalho ja ocupa Top=0..80, por isso nenhum campo
373:     * precisa de compensacao de offset).
374:     *
375:     * Fase 5/8: primeira metade dos campos (ordenados por Top no dump do
376:     * SCX, mantendo juntos label+campo da mesma linha). Segunda metade
377:     * (Industria, Estoque, Grupo/Subgrupo Produto, Grande Grupo, Colecao,
378:     * Linha, Local, Promocao, Ordem, Marca) entra na Fase 6/8.
379:     *==========================================================================
380:     PROTECTED PROCEDURE ConfigurarPaginaDados()
381:         THIS.ConfigurarCamposPeriodo()
382:         THIS.ConfigurarCamposEmpresa()
383:         THIS.ConfigurarCamposOperacao()
384:         THIS.ConfigurarCamposIndustria()
385:         THIS.ConfigurarCamposCodigoEtiquetas()
386:         THIS.ConfigurarCamposGrupoEstoque()
387:         THIS.ConfigurarCamposEstoque()
388:         THIS.ConfigurarCamposGrandeGrupo()
389:         THIS.ConfigurarCamposGrupoProduto()
390:         THIS.ConfigurarCamposSubgrupoProduto()
391:         THIS.ConfigurarCamposGrupoVenda()
392:         THIS.ConfigurarCamposLinha()
393:         THIS.ConfigurarCamposLocal()
394:         THIS.ConfigurarCamposPromocao()
395:         THIS.ConfigurarCamposOrdemMarca()
396:     ENDPROC
397: 
398:     *==========================================================================
399:     * ConfigurarCamposPeriodo
400:     * Linha "Periodo : [Get_Datai] ate [Get_Dataf]" (Top=107/111 no SCX)
401:     *==========================================================================
402:     PROTECTED PROCEDURE ConfigurarCamposPeriodo()
403:         THIS.AddObject("lbl_4c_Label5", "Label")
404:         WITH THIS.lbl_4c_Label5
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8
407:             .BackStyle = 0
408:             .Alignment = 0
409:             .AutoSize  = .F.
410:             .Top       = 111
411:             .Left      = 253
412:             .Width     = 48
413:             .Height    = 15
414:             .TabIndex  = 31
415:             .ForeColor = RGB(90,90,90)
416:             .Caption   = "Per" + CHR(237) + "odo :"
417:         ENDWITH
418: 
419:         THIS.AddObject("txt_4c_Datai", "TextBox")
420:         WITH THIS.txt_4c_Datai
421:             .FontName      = "Tahoma"
422:             .Alignment     = 3
423:             .BorderStyle   = 1
424:             .SpecialEffect = 1
425:             .Top           = 107
426:             .Left          = 303
427:             .Width         = 80
428:             .Height        = 23
429:             .TabIndex      = 1
430:             .ForeColor     = RGB(0,0,0)
431:             .Value         = {}
432:         ENDWITH
433: 
434:         THIS.AddObject("lbl_4c_Label6", "Label")
435:         WITH THIS.lbl_4c_Label6
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8
438:             .BackStyle = 0
439:             .Alignment = 0
440:             .AutoSize  = .F.
441:             .Top       = 111
442:             .Left      = 388

*-- Linhas 466 a 509:
466:     * ConfigurarCamposEmpresa
467:     * Linha "Empresa : [get_cd_empresa] [get_ds_empresa]" (Top=132/136)
468:     *==========================================================================
469:     PROTECTED PROCEDURE ConfigurarCamposEmpresa()
470:         THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
471:         WITH THIS.lbl_4c_Lbl_empresa
472:             .FontName  = "Tahoma"
473:             .BackStyle = 0
474:             .Alignment = 0
475:             .AutoSize  = .F.
476:             .Top       = 136
477:             .Left      = 248
478:             .Width     = 50
479:             .Height    = 15
480:             .TabIndex  = 33
481:             .ForeColor = RGB(90,90,90)
482:             .Caption   = "Empresa :"
483:         ENDWITH
484: 
485:         THIS.AddObject("txt_4c__cd_empresa", "TextBox")
486:         WITH THIS.txt_4c__cd_empresa
487:             .FontName      = "Tahoma"
488:             .Alignment     = 0
489:             .BackStyle     = 1
490:             .BorderStyle   = 1
491:             .SpecialEffect = 1
492:             .Format        = "K"
493:             .MaxLength     = 3
494:             .Top           = 132
495:             .Left          = 303
496:             .Width         = 31
497:             .Height        = 23
498:             .TabIndex      = 3
499:             .ForeColor     = RGB(0,0,0)
500:             .Value         = ""
501:         ENDWITH
502: 
503:         THIS.AddObject("txt_4c__ds_empresa", "TextBox")
504:         WITH THIS.txt_4c__ds_empresa
505:             .FontName      = "Tahoma"
506:             .BorderStyle   = 1
507:             .SpecialEffect = 1
508:             .Format        = "K"
509:             .MaxLength     = 40

*-- Linhas 522 a 565:
522:     * Linha "Opera" + CHR(231) + CHR(227) + "o : [nm_operacao] [Numero]
523:     * at" + CHR(233) + " [Numerof] [Chk_Preco]" (Top=157/162)
524:     *==========================================================================
525:     PROTECTED PROCEDURE ConfigurarCamposOperacao()
526:         THIS.AddObject("lbl_4c_Label9", "Label")
527:         WITH THIS.lbl_4c_Label9
528:             .FontName  = "Tahoma"
529:             .FontBold  = .F.
530:             .FontSize  = 8
531:             .BackStyle = 0
532:             .Alignment = 0
533:             .AutoSize  = .F.
534:             .Top       = 162
535:             .Left      = 242
536:             .Width     = 58
537:             .Height    = 15
538:             .TabIndex  = 34
539:             .ForeColor = RGB(90,90,90)
540:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
541:         ENDWITH
542: 
543:         THIS.AddObject("txt_4c__nm_operacao", "TextBox")
544:         WITH THIS.txt_4c__nm_operacao
545:             .FontBold      = .F.
546:             .FontItalic    = .F.
547:             .FontName      = "Tahoma"
548:             .FontSize      = 9
549:             .FontUnderline = .F.
550:             .Alignment     = 0
551:             .BackStyle     = 1
552:             .BorderStyle   = 1
553:             .SpecialEffect = 1
554:             .Format        = "K!"
555:             .MaxLength     = 20
556:             .Top           = 157
557:             .Left          = 303
558:             .Width         = 150
559:             .Height        = 25
560:             .TabIndex      = 5
561:             .ForeColor     = RGB(0,0,0)
562:             .Value         = ""
563:         ENDWITH
564: 
565:         THIS.AddObject("txt_4c_Numero", "TextBox")

*-- Linhas 611 a 657:
611:             .Value         = 0
612:         ENDWITH
613: 
614:         *-- Chk_Preco (OptionGroup legado): Sim/Nao/Ideal/Atual - 90,90,90
615:         *-- transcrito do dump; NUNCA setar ButtonsValue (regra CLAUDE.md
616:         *-- #OptionGroup.Buttons(N).Value) - so o Value do grupo importa.
617:         THIS.AddObject("obj_4c_Chk_Preco", "OptionGroup")
618:         WITH THIS.obj_4c_Chk_Preco
619:             .AutoSize    = .T.
620:             .ButtonCount = 4
621:             .BackStyle   = 0
622:             .BorderStyle = 0
623:             .Top         = 157
624:             .Left        = 606
625:             .Width       = 200
626:             .Height      = 25
627:             .TabIndex    = 36
628:             .Value       = 2
629:         ENDWITH
630: 
631:         WITH THIS.obj_4c_Chk_Preco.Buttons(1)
632:             .FontName  = "Tahoma"
633:             .FontSize  = 8
634:             .BackStyle = 0
635:             .AutoSize  = .T.
636:             .Top       = 5
637:             .Left      = 5
638:             .Width     = 34
639:             .Height    = 15
640:             .ForeColor = RGB(90,90,90)
641:             .Caption   = "Sim"
642:         ENDWITH
643: 
644:         WITH THIS.obj_4c_Chk_Preco.Buttons(2)
645:             .FontName  = "Tahoma"
646:             .FontSize  = 8
647:             .BackStyle = 0
648:             .AutoSize  = .T.
649:             .Top       = 5
650:             .Left      = 50
651:             .Width     = 37
652:             .Height    = 15
653:             .ForeColor = RGB(90,90,90)
654:             .Caption   = "N" + CHR(227) + "o"
655:         ENDWITH
656: 
657:         WITH THIS.obj_4c_Chk_Preco.Buttons(3)

*-- Linhas 686 a 729:
686:     * Linha "C" + CHR(243) + "digo : [Get_cod] [Get_dcod]" (Top=211/215) e
687:     * linha "Etiquetas : [Etii] [Etif] / Ou [qtdEti] Etiquetas" (Top=236/240)
688:     *==========================================================================
689:     PROTECTED PROCEDURE ConfigurarCamposCodigoEtiquetas()
690:         THIS.AddObject("lbl_4c_Label2", "Label")
691:         WITH THIS.lbl_4c_Label2
692:             .FontName  = "Tahoma"
693:             .BackStyle = 0
694:             .Alignment = 0
695:             .AutoSize  = .F.
696:             .Top       = 215
697:             .Left      = 256
698:             .Width     = 45
699:             .Height    = 15
700:             .TabIndex  = 38
701:             .ForeColor = RGB(90,90,90)
702:             .Caption   = "C" + CHR(243) + "digo :"
703:         ENDWITH
704: 
705:         *-- Lookup (SigCdPro CPros/DPros, fwBuscaExt no legado) entra na
706:         *-- fase de eventos - aqui so a estrutura visual do campo.
707:         THIS.AddObject("txt_4c_Cod", "TextBox")
708:         WITH THIS.txt_4c_Cod
709:             .FontName      = "Tahoma"
710:             .BorderStyle   = 1
711:             .SpecialEffect = 1
712:             .MaxLength     = 14
713:             .Top           = 211
714:             .Left          = 303
715:             .Width         = 108
716:             .Height        = 23
717:             .TabIndex      = 9
718:             .ForeColor     = RGB(0,0,0)
719:             .Value         = ""
720:         ENDWITH
721: 
722:         THIS.AddObject("txt_4c_Dcod", "TextBox")
723:         WITH THIS.txt_4c_Dcod
724:             .FontName      = "Tahoma"
725:             .BorderStyle   = 1
726:             .SpecialEffect = 1
727:             .Top           = 211
728:             .Left          = 413
729:             .Width         = 290

*-- Linhas 847 a 890:
847:     * ConfigurarCamposGrupoEstoque
848:     * Linha "Grupo Estoque : [Cd_GrEstoque] [Ds_GrEstoque]" (Top=261/266)
849:     *==========================================================================
850:     PROTECTED PROCEDURE ConfigurarCamposGrupoEstoque()
851:         THIS.AddObject("lbl_4c_Label7", "Label")
852:         WITH THIS.lbl_4c_Label7
853:             .FontName  = "Tahoma"
854:             .BackStyle = 0
855:             .Alignment = 0
856:             .AutoSize  = .F.
857:             .Top       = 266
858:             .Left      = 218
859:             .Width     = 80
860:             .Height    = 15
861:             .TabIndex  = 43
862:             .ForeColor = RGB(90,90,90)
863:             .Caption   = "Grupo Estoque :"
864:         ENDWITH
865: 
866:         THIS.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
867:         WITH THIS.txt_4c__Cd_GrEstoque
868:             .FontName      = "Tahoma"
869:             .BorderStyle   = 1
870:             .SpecialEffect = 1
871:             .Format        = "K"
872:             .MaxLength     = 10
873:             .Top           = 261
874:             .Left          = 303
875:             .Width         = 80
876:             .Height        = 25
877:             .TabIndex      = 14
878:             .ForeColor     = RGB(0,0,0)
879:             .Value         = SPACE(10)
880:         ENDWITH
881: 
882:         THIS.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
883:         WITH THIS.txt_4c__Ds_GrEstoque
884:             .FontName      = "Tahoma"
885:             .BorderStyle   = 1
886:             .SpecialEffect = 1
887:             .Format        = "K"
888:             .MaxLength     = 20
889:             .Top           = 261
890:             .Left          = 384

*-- Linhas 902 a 985:
902:     * exclusivo com Operacao (ConfigurarCamposOperacao) - ver
903:     * AjustarDependenciasCampos().
904:     *==========================================================================
905:     PROTECTED PROCEDURE ConfigurarCamposIndustria()
906:         THIS.AddObject("lbl_4c_Label20", "Label")
907:         WITH THIS.lbl_4c_Label20
908:             .FontName  = "Tahoma"
909:             .BackStyle = 0
910:             .Alignment = 0
911:             .AutoSize  = .F.
912:             .Top       = 189
913:             .Left      = 246
914:             .Width     = 50
915:             .Height    = 15
916:             .TabIndex  = 51
917:             .ForeColor = RGB(90,90,90)
918:             .Caption   = "Ind" + CHR(250) + "stria :"
919:         ENDWITH
920: 
921:         *-- Lookup contra SigCdOpd.dopps (mesma tabela de Operacao - ver
922:         *-- AbrirLookupOperacaoIndustria)
923:         THIS.AddObject("txt_4c__nm_industria", "TextBox")
924:         WITH THIS.txt_4c__nm_industria
925:             .FontName      = "Tahoma"
926:             .BorderStyle   = 1
927:             .SpecialEffect = 1
928:             .MaxLength     = 20
929:             .Top           = 184
930:             .Left          = 303
931:             .Width         = 150
932:             .Height        = 25
933:             .TabIndex      = 8
934:             .ForeColor     = RGB(0,0,0)
935:             .Value         = ""
936:         ENDWITH
937:     ENDPROC
938: 
939:     *==========================================================================
940:     * ConfigurarCamposEstoque
941:     * Linha "Estoque : [get_cd_estoque] [get_ds_estoque]" (Top=288/293)
942:     * fAcessoContas(legado) -> SigCdCli (Iclis/Rclis), filtrado pelo Grupo
943:     * de Estoque (txt_4c__Cd_GrEstoque) - ver AbrirBuscaEstoque.
944:     *==========================================================================
945:     PROTECTED PROCEDURE ConfigurarCamposEstoque()
946:         THIS.AddObject("lbl_4c_Label8", "Label")
947:         WITH THIS.lbl_4c_Label8
948:             .FontName  = "Tahoma"
949:             .BackStyle = 0
950:             .Alignment = 0
951:             .AutoSize  = .F.
952:             .Top       = 293
953:             .Left      = 250
954:             .Width     = 50
955:             .Height    = 15
956:             .TabIndex  = 56
957:             .ForeColor = RGB(90,90,90)
958:             .Caption   = "Estoque :"
959:         ENDWITH
960: 
961:         THIS.AddObject("txt_4c__cd_estoque", "TextBox")
962:         WITH THIS.txt_4c__cd_estoque
963:             .FontName      = "Tahoma"
964:             .BorderStyle   = 1
965:             .SpecialEffect = 1
966:             .Format        = "K"
967:             .MaxLength     = 10
968:             .Top           = 288
969:             .Left          = 303
970:             .Width         = 80
971:             .Height        = 25
972:             .TabIndex      = 16
973:             .ForeColor     = RGB(0,0,0)
974:             .Value         = ""
975:         ENDWITH
976: 
977:         THIS.AddObject("txt_4c__ds_estoque", "TextBox")
978:         WITH THIS.txt_4c__ds_estoque
979:             .FontName      = "Tahoma"
980:             .BorderStyle   = 1
981:             .SpecialEffect = 1
982:             .Format        = "K"
983:             .MaxLength     = 20
984:             .Top           = 288
985:             .Left          = 384

*-- Linhas 996 a 1077:
996:     * Linha "Grande Grupo : [get_gde_grupo]" (Top=315/319)
997:     * fwBuscaExt(legado) -> SigCdGpr.Codigos/Descs
998:     *==========================================================================
999:     PROTECTED PROCEDURE ConfigurarCamposGrandeGrupo()
1000:         THIS.AddObject("lbl_4c_Label15", "Label")
1001:         WITH THIS.lbl_4c_Label15
1002:             .FontName  = "Tahoma"
1003:             .BackStyle = 0
1004:             .Alignment = 0
1005:             .AutoSize  = .F.
1006:             .Top       = 319
1007:             .Left      = 222
1008:             .Width     = 76
1009:             .Height    = 15
1010:             .TabIndex  = 57
1011:             .ForeColor = RGB(90,90,90)
1012:             .Caption   = "Grande Grupo :"
1013:         ENDWITH
1014: 
1015:         THIS.AddObject("txt_4c__gde_grupo", "TextBox")
1016:         WITH THIS.txt_4c__gde_grupo
1017:             .FontName      = "Tahoma"
1018:             .BorderStyle   = 1
1019:             .SpecialEffect = 1
1020:             .Format        = "K"
1021:             .MaxLength     = 3
1022:             .Top           = 315
1023:             .Left          = 303
1024:             .Width         = 31
1025:             .Height        = 23
1026:             .TabIndex      = 18
1027:             .ForeColor     = RGB(0,0,0)
1028:             .Value         = ""
1029:         ENDWITH
1030:     ENDPROC
1031: 
1032:     *==========================================================================
1033:     * ConfigurarCamposGrupoProduto
1034:     * Linha "Grupo Produto : [getCgru] [getDgru]" (Top=340/344)
1035:     * fwBuscaExt(legado) -> SigCdGrp.CGrus/DGrus
1036:     *==========================================================================
1037:     PROTECTED PROCEDURE ConfigurarCamposGrupoProduto()
1038:         THIS.AddObject("lbl_4c_Label11", "Label")
1039:         WITH THIS.lbl_4c_Label11
1040:             .FontName  = "Tahoma"
1041:             .BackStyle = 0
1042:             .Alignment = 0
1043:             .AutoSize  = .F.
1044:             .Top       = 344
1045:             .Left      = 219
1046:             .Width     = 79
1047:             .Height    = 15
1048:             .TabIndex  = 58
1049:             .ForeColor = RGB(90,90,90)
1050:             .Caption   = "Grupo Produto :"
1051:         ENDWITH
1052: 
1053:         THIS.AddObject("txt_4c_Cgru", "TextBox")
1054:         WITH THIS.txt_4c_Cgru
1055:             .FontName      = "Tahoma"
1056:             .BorderStyle   = 1
1057:             .SpecialEffect = 1
1058:             .Format        = "K"
1059:             .MaxLength     = 3
1060:             .Top           = 340
1061:             .Left          = 303
1062:             .Width         = 31
1063:             .Height        = 23
1064:             .TabIndex      = 19
1065:             .ForeColor     = RGB(0,0,0)
1066:             .Value         = ""
1067:         ENDWITH
1068: 
1069:         THIS.AddObject("txt_4c_Dgru", "TextBox")
1070:         WITH THIS.txt_4c_Dgru
1071:             .FontName      = "Tahoma"
1072:             .BorderStyle   = 1
1073:             .SpecialEffect = 1
1074:             .Format        = "K"
1075:             .MaxLength     = 40
1076:             .Top           = 340
1077:             .Left          = 336

*-- Linhas 1089 a 1132:
1089:     * fwBuscaExt(legado) -> SigCdPsg.Codigos/Descricaos, filtrado por
1090:     * CGrus = Padr(getCgru.Value, 3) - ver AbrirBuscaSubgrupo*.
1091:     *==========================================================================
1092:     PROTECTED PROCEDURE ConfigurarCamposSubgrupoProduto()
1093:         THIS.AddObject("lbl_4c_Label21", "Label")
1094:         WITH THIS.lbl_4c_Label21
1095:             .FontName  = "Tahoma"
1096:             .BackStyle = 0
1097:             .Alignment = 0
1098:             .AutoSize  = .F.
1099:             .Top       = 370
1100:             .Left      = 202
1101:             .Width     = 96
1102:             .Height    = 15
1103:             .TabIndex  = 59
1104:             .ForeColor = RGB(90,90,90)
1105:             .Caption   = "Subgrupo Produto :"
1106:         ENDWITH
1107: 
1108:         THIS.AddObject("txt_4c_CSGru", "TextBox")
1109:         WITH THIS.txt_4c_CSGru
1110:             .FontName      = "Tahoma"
1111:             .BorderStyle   = 1
1112:             .SpecialEffect = 1
1113:             .Format        = "K"
1114:             .MaxLength     = 10
1115:             .Top           = 366
1116:             .Left          = 303
1117:             .Width         = 80
1118:             .Height        = 21
1119:             .TabIndex      = 21
1120:             .ForeColor     = RGB(0,0,0)
1121:             .Value         = ""
1122:         ENDWITH
1123: 
1124:         THIS.AddObject("txt_4c_DSGru", "TextBox")
1125:         WITH THIS.txt_4c_DSGru
1126:             .FontName      = "Tahoma"
1127:             .BorderStyle   = 1
1128:             .SpecialEffect = 1
1129:             .Format        = "K"
1130:             .MaxLength     = 40
1131:             .Top           = 366
1132:             .Left          = 385

*-- Linhas 1144 a 1187:
1144:     * SCX diz "Grupo Venda" mas o lookup legado consulta SigCdCol
1145:     * (Colecoes/Descs) - transcrito literal (PILAR 1 - rotulo nao se corrige).
1146:     *==========================================================================
1147:     PROTECTED PROCEDURE ConfigurarCamposGrupoVenda()
1148:         THIS.AddObject("lbl_4c_Label17", "Label")
1149:         WITH THIS.lbl_4c_Label17
1150:             .FontName  = "Tahoma"
1151:             .BackStyle = 0
1152:             .Alignment = 0
1153:             .AutoSize  = .F.
1154:             .Top       = 394
1155:             .Left      = 227
1156:             .Width     = 71
1157:             .Height    = 15
1158:             .TabIndex  = 60
1159:             .ForeColor = RGB(90,90,90)
1160:             .Caption   = "Grupo Venda :"
1161:         ENDWITH
1162: 
1163:         THIS.AddObject("txt_4c_Col", "TextBox")
1164:         WITH THIS.txt_4c_Col
1165:             .FontName      = "Tahoma"
1166:             .BorderStyle   = 1
1167:             .SpecialEffect = 1
1168:             .Format        = "K"
1169:             .MaxLength     = 10
1170:             .Top           = 390
1171:             .Left          = 303
1172:             .Width         = 80
1173:             .Height        = 23
1174:             .TabIndex      = 23
1175:             .ForeColor     = RGB(0,0,0)
1176:             .Value         = ""
1177:         ENDWITH
1178: 
1179:         THIS.AddObject("txt_4c_DCol", "TextBox")
1180:         WITH THIS.txt_4c_DCol
1181:             .FontName      = "Tahoma"
1182:             .BorderStyle   = 1
1183:             .SpecialEffect = 1
1184:             .Format        = "K"
1185:             .MaxLength     = 40
1186:             .Top           = 390
1187:             .Left          = 385

*-- Linhas 1198 a 1280:
1198:     * Linha "Linha : [GetLin]" (Top=415/419)
1199:     * fwBuscaExt(legado) -> SigCdLin.linhas/descs
1200:     *==========================================================================
1201:     PROTECTED PROCEDURE ConfigurarCamposLinha()
1202:         THIS.AddObject("lbl_4c_Label16", "Label")
1203:         WITH THIS.lbl_4c_Label16
1204:             .FontName  = "Tahoma"
1205:             .BackStyle = 0
1206:             .Alignment = 0
1207:             .AutoSize  = .F.
1208:             .Top       = 419
1209:             .Left      = 264
1210:             .Width     = 34
1211:             .Height    = 15
1212:             .TabIndex  = 61
1213:             .ForeColor = RGB(90,90,90)
1214:             .Caption   = "Linha :"
1215:         ENDWITH
1216: 
1217:         THIS.AddObject("txt_4c_Lin", "TextBox")
1218:         WITH THIS.txt_4c_Lin
1219:             .FontName      = "Tahoma"
1220:             .BorderStyle   = 1
1221:             .SpecialEffect = 1
1222:             .Format        = "K"
1223:             .MaxLength     = 10
1224:             .Top           = 415
1225:             .Left          = 303
1226:             .Width         = 80
1227:             .Height        = 23
1228:             .TabIndex      = 25
1229:             .ForeColor     = RGB(0,0,0)
1230:             .Value         = ""
1231:         ENDWITH
1232:     ENDPROC
1233: 
1234:     *==========================================================================
1235:     * ConfigurarCamposLocal
1236:     * Linha "Local do Produto : [Get_Local]" (Top=440/444) e linha
1237:     * "Local da Etiqueta : [getLocalizas]" (Top=465/469) - ambas consultam
1238:     * SigPrLcl.Codigos/Descricaos (fwBuscaExt no legado).
1239:     *==========================================================================
1240:     PROTECTED PROCEDURE ConfigurarCamposLocal()
1241:         THIS.AddObject("lbl_4c_Label14", "Label")
1242:         WITH THIS.lbl_4c_Label14
1243:             .FontName  = "Tahoma"
1244:             .BackStyle = 0
1245:             .Alignment = 0
1246:             .AutoSize  = .F.
1247:             .Top       = 444
1248:             .Left      = 209
1249:             .Width     = 89
1250:             .Height    = 15
1251:             .TabIndex  = 62
1252:             .ForeColor = RGB(90,90,90)
1253:             .Caption   = "Local do Produto :"
1254:         ENDWITH
1255: 
1256:         THIS.AddObject("txt_4c_Local", "TextBox")
1257:         WITH THIS.txt_4c_Local
1258:             .FontName      = "Tahoma"
1259:             .BorderStyle   = 1
1260:             .SpecialEffect = 1
1261:             .Format        = "K"
1262:             .MaxLength     = 10
1263:             .Top           = 440
1264:             .Left          = 303
1265:             .Width         = 80
1266:             .Height        = 23
1267:             .TabIndex      = 26
1268:             .ForeColor     = RGB(0,0,0)
1269:             .Value         = ""
1270:         ENDWITH
1271: 
1272:         THIS.AddObject("lbl_4c_Label19", "Label")
1273:         WITH THIS.lbl_4c_Label19
1274:             .FontName  = "Tahoma"
1275:             .BackStyle = 0
1276:             .Alignment = 0
1277:             .AutoSize  = .F.
1278:             .Top       = 469
1279:             .Left      = 207
1280:             .Width     = 91

*-- Linhas 1307 a 1406:
1307:     * fwBuscaExt(legado) -> SigPrPmc.promos (coluna unica - codigo e
1308:     * descricao sao a mesma coisa)
1309:     *==========================================================================
1310:     PROTECTED PROCEDURE ConfigurarCamposPromocao()
1311:         THIS.AddObject("lbl_4c_Label18", "Label")
1312:         WITH THIS.lbl_4c_Label18
1313:             .FontName  = "Tahoma"
1314:             .BackStyle = 0
1315:             .Alignment = 0
1316:             .AutoSize  = .F.
1317:             .Top       = 494
1318:             .Left      = 242
1319:             .Width     = 58
1320:             .Height    = 15
1321:             .TabIndex  = 64
1322:             .ForeColor = RGB(90,90,90)
1323:             .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
1324:         ENDWITH
1325: 
1326:         THIS.AddObject("txt_4c__promos", "TextBox")
1327:         WITH THIS.txt_4c__promos
1328:             .FontName      = "Tahoma"
1329:             .BorderStyle   = 1
1330:             .SpecialEffect = 1
1331:             .MaxLength     = 15
1332:             .Top           = 490
1333:             .Left          = 303
1334:             .Width         = 185
1335:             .Height        = 23
1336:             .TabIndex      = 28
1337:             .ForeColor     = RGB(0,0,0)
1338:             .Value         = ""
1339:         ENDWITH
1340:     ENDPROC
1341: 
1342:     *==========================================================================
1343:     * ConfigurarCamposOrdemMarca
1344:     * OptionGroup "Ordem :" (Get_Ordem, 5 botoes: Produto/Etiqueta/
1345:     * Operacao/Referencia Fornecedor/Categoria + Grupo - Top=513/516) e
1346:     * OptionGroup "Marca :" (Opt_Marcas, 2 botoes: Sim/Nao - Top=531/536).
1347:     * Legendas e Lefts/Widths transcritos literal do dump do SCX (regra
1348:     * #45 - NUNCA inventar legenda/ordem de OptionGroup).
1349:     *==========================================================================
1350:     PROTECTED PROCEDURE ConfigurarCamposOrdemMarca()
1351:         THIS.AddObject("lbl_4c_Label3", "Label")
1352:         WITH THIS.lbl_4c_Label3
1353:             .FontName  = "Tahoma"
1354:             .BackStyle = 0
1355:             .Alignment = 0
1356:             .AutoSize  = .F.
1357:             .Top       = 516
1358:             .Left      = 257
1359:             .Width     = 40
1360:             .Height    = 15
1361:             .TabIndex  = 65
1362:             .ForeColor = RGB(90,90,90)
1363:             .Caption   = "Ordem :"
1364:         ENDWITH
1365: 
1366:         THIS.AddObject("obj_4c_Get_Ordem", "OptionGroup")
1367:         WITH THIS.obj_4c_Get_Ordem
1368:             .ButtonCount = 5
1369:             .BackStyle   = 0
1370:             .BorderStyle = 0
1371:             .Top         = 513
1372:             .Left        = 297
1373:             .Width       = 513
1374:             .Height      = 20
1375:             .TabIndex    = 29
1376:             .Value       = 1
1377:         ENDWITH
1378: 
1379:         WITH THIS.obj_4c_Get_Ordem.Buttons(1)
1380:             .FontName  = "Tahoma"
1381:             .FontSize  = 8
1382:             .BackStyle = 0
1383:             .Top       = 2
1384:             .Left      = 5
1385:             .Width     = 63
1386:             .Height    = 15
1387:             .ForeColor = RGB(90,90,90)
1388:             .Caption   = "Produto"
1389:         ENDWITH
1390: 
1391:         WITH THIS.obj_4c_Get_Ordem.Buttons(2)
1392:             .FontName  = "Tahoma"
1393:             .FontSize  = 8
1394:             .BackStyle = 0
1395:             .Top       = 2
1396:             .Left      = 71
1397:             .Width     = 65
1398:             .Height    = 15
1399:             .ForeColor = RGB(90,90,90)
1400:             .Caption   = "Etiqueta"
1401:         ENDWITH
1402: 
1403:         WITH THIS.obj_4c_Get_Ordem.Buttons(3)
1404:             .FontName  = "Tahoma"
1405:             .FontSize  = 8
1406:             .BackStyle = 0

*-- Linhas 1452 a 2418:
1452:             .Caption   = "Marca :"
1453:         ENDWITH
1454: 
1455:         THIS.AddObject("obj_4c_Opt_Marcas", "OptionGroup")
1456:         WITH THIS.obj_4c_Opt_Marcas
1457:             .AutoSize    = .T.
1458:             .ButtonCount = 2
1459:             .BackStyle   = 0
1460:             .BorderStyle = 0
1461:             .Top         = 531
1462:             .Left        = 297
1463:             .Width       = 118
1464:             .Height      = 27
1465:             .TabIndex    = 30
1466:             .Value       = 1
1467:         ENDWITH
1468: 
1469:         WITH THIS.obj_4c_Opt_Marcas.Buttons(1)
1470:             .FontName  = "Tahoma"
1471:             .FontSize  = 8
1472:             .BackStyle = 0
1473:             .Top       = 5
1474:             .Left      = 5
1475:             .Width     = 42
1476:             .Height    = 17
1477:             .ForeColor = RGB(90,90,90)
1478:             .Caption   = "Sim"
1479:         ENDWITH
1480: 
1481:         WITH THIS.obj_4c_Opt_Marcas.Buttons(2)
1482:             .FontName  = "Tahoma"
1483:             .FontSize  = 8
1484:             .BackStyle = 0
1485:             .Top       = 5
1486:             .Left      = 71
1487:             .Width     = 42
1488:             .Height    = 17
1489:             .ForeColor = RGB(90,90,90)
1490:             .Caption   = "N" + CHR(227) + "o"
1491:         ENDWITH
1492:     ENDPROC
1493: 
1494:     *==========================================================================
1495:     * ConfigurarEventosLookup
1496:     * Registra todos os BINDEVENT "LostFocus" dos campos com lookup/
1497:     * validacao cruzada (regra #47 - NUNCA em "KeyPress" sem testar tecla).
1498:     * Handlers tem de ser PUBLIC (regra #3 - BINDEVENT so dispara metodo
1499:     * PUBLIC).
1500:     *==========================================================================
1501:     PROTECTED PROCEDURE ConfigurarEventosLookup()
1502:         BINDEVENT(THIS.txt_4c__cd_empresa,    "LostFocus", THIS, "ValidarCdEmpresaLostFocus")
1503:         BINDEVENT(THIS.txt_4c__ds_empresa,    "LostFocus", THIS, "ValidarDsEmpresaLostFocus")
1504:         BINDEVENT(THIS.txt_4c__nm_operacao,   "LostFocus", THIS, "ValidarOperacaoLostFocus")
1505:         BINDEVENT(THIS.txt_4c__nm_industria,  "LostFocus", THIS, "ValidarIndustriaLostFocus")
1506:         BINDEVENT(THIS.txt_4c_Datai,          "LostFocus", THIS, "ValidarDataiLostFocus")
1507:         BINDEVENT(THIS.txt_4c_Dataf,          "LostFocus", THIS, "ValidarDatafLostFocus")
1508:         BINDEVENT(THIS.txt_4c_Cod,            "LostFocus", THIS, "ValidarCodProdutoLostFocus")
1509:         BINDEVENT(THIS.txt_4c_Dcod,           "LostFocus", THIS, "ValidarDescProdutoLostFocus")
1510:         BINDEVENT(THIS.txt_4c_Etii,           "LostFocus", THIS, "ValidarEtiiLostFocus")
1511:         BINDEVENT(THIS.txt_4c_Etif,           "LostFocus", THIS, "ValidarEtifLostFocus")
1512:         BINDEVENT(THIS.txt_4c__Cd_GrEstoque,  "LostFocus", THIS, "ValidarCdGrEstoqueLostFocus")
1513:         BINDEVENT(THIS.txt_4c__Ds_GrEstoque,  "LostFocus", THIS, "ValidarDsGrEstoqueLostFocus")
1514:         BINDEVENT(THIS.txt_4c__cd_estoque,    "LostFocus", THIS, "ValidarCdEstoqueLostFocus")
1515:         BINDEVENT(THIS.txt_4c__ds_estoque,    "LostFocus", THIS, "ValidarDsEstoqueLostFocus")
1516:         BINDEVENT(THIS.txt_4c__gde_grupo,     "LostFocus", THIS, "ValidarGrandeGrupoLostFocus")
1517:         BINDEVENT(THIS.txt_4c_Cgru,           "LostFocus", THIS, "ValidarGrupoProdutoLostFocus")
1518:         BINDEVENT(THIS.txt_4c_Dgru,           "LostFocus", THIS, "ValidarDescGrupoProdutoLostFocus")
1519:         BINDEVENT(THIS.txt_4c_CSGru,          "LostFocus", THIS, "ValidarSubgrupoCodLostFocus")
1520:         BINDEVENT(THIS.txt_4c_DSGru,          "LostFocus", THIS, "ValidarSubgrupoDescLostFocus")
1521:         BINDEVENT(THIS.txt_4c_Col,            "LostFocus", THIS, "ValidarGrupoVendaCodLostFocus")
1522:         BINDEVENT(THIS.txt_4c_DCol,           "LostFocus", THIS, "ValidarGrupoVendaDescLostFocus")
1523:         BINDEVENT(THIS.txt_4c_Lin,            "LostFocus", THIS, "ValidarLinhaLostFocus")
1524:         BINDEVENT(THIS.txt_4c_Local,          "LostFocus", THIS, "ValidarLocalProdutoLostFocus")
1525:         BINDEVENT(THIS.txt_4c_Localizas,      "LostFocus", THIS, "ValidarLocalEtiquetaLostFocus")
1526:         BINDEVENT(THIS.txt_4c__promos,        "LostFocus", THIS, "ValidarPromocaoLostFocus")
1527:     ENDPROC
1528: 
1529:     *==========================================================================
1530:     * AjustarDependenciasCampos
1531:     * Reproduz os "When" do legado (campo so eh editavel sob certa
1532:     * condicao). Chamado apos cada LostFocus relevante e uma vez na
1533:     * inicializacao.
1534:     *
1535:     * Os 14 "When" do SCX, transcritos LITERALMENTE:
1536:     *   get_dcod          Empty(get_cod.Value)
1537:     *   get_ds_empresa    Empty(get_cd_empresa.Value)
1538:     *   get_nm_operacao   Empty(get_nm_industria.Value)
1539:     *   get_nm_industria  Empty(get_nm_operacao.Value)
1540:     *   Get_Numero        Not Empty(get_nm_operacao) or Not Empty(get_nm_industria)
1541:     *   Get_Numerof       (idem Get_Numero)
1542:     *   Get_qtdEti        Empty(get_Etif.Value)
1543:     *   get_cd_estoque    Not Empty(get_cd_grestoque.Value)
1544:     *   get_ds_estoque    Empty(get_cd_estoque) And Not Empty(get_cd_grestoque)
1545:     *   get_Ds_GrEstoque  Empty(get_cd_grestoque.Value)
1546:     *   getDgru           .F. quando Not Empty(GetCgru.Value)
1547:     *   GetCSGru          !Empty(getCgru.Value)
1548:     *   GetDSGru          !Empty(getCgru.Value) And Empty(GetCSGru.Value)
1549:     *   GetDCol           Empty(GetCol.Value)
1550:     *
1551:     * O campo de DESCRICAO de um par codigo/descricao eh editavel enquanto o
1552:     * CODIGO esta VAZIO (eh a via alternativa de busca: digita-se um OU o
1553:     * outro). Inverter esse sentido desabilita a descricao justamente no
1554:     * estado em que ela seria usada - e, como preencher o codigo ja preenche
1555:     * a descricao pelo lookup, o campo ficaria inalcancavel para sempre.
1556:     *
1557:     * Empresa: nao tem "When" no SCX, mas o Init do legado a TRAVA quando
1558:     * SigCdPac.fixaemp = 1 ("get_Cd_Empresa.enabled = .F."). Como este metodo
1559:     * roda a cada LostFocus, a trava tem de ser reafirmada AQUI - repor
1560:     * .Enabled = .T. sem olhar o parametro destravaria no primeiro LostFocus
1561:     * o campo que o Init acabou de travar.
1562:     *==========================================================================
1563:     PROTECTED PROCEDURE AjustarDependenciasCampos()
1564:         LOCAL loc_lTemOperacao, loc_lTemIndustria, loc_lFixaEmpresa, loc_lTemGrEstoque
1565: 
1566:         loc_lFixaEmpresa = .F.
1567:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1568:             loc_lFixaEmpresa = (THIS.this_oBusinessObject.this_nFixaEmpresa = 1)
1569:         ENDIF
1570: 
1571:         THIS.txt_4c__cd_empresa.Enabled = !loc_lFixaEmpresa
1572:         THIS.txt_4c__ds_empresa.Enabled = EMPTY(ALLTRIM(THIS.txt_4c__cd_empresa.Value))
1573: 
1574:         loc_lTemOperacao  = !EMPTY(ALLTRIM(THIS.txt_4c__nm_operacao.Value))
1575:         loc_lTemIndustria = !EMPTY(ALLTRIM(THIS.txt_4c__nm_industria.Value))
1576:         THIS.txt_4c__nm_industria.Enabled = !loc_lTemOperacao
1577:         THIS.txt_4c__nm_operacao.Enabled  = !loc_lTemIndustria
1578:         THIS.txt_4c_Numero.Enabled        = loc_lTemOperacao OR loc_lTemIndustria
1579:         THIS.txt_4c_Numerof.Enabled       = loc_lTemOperacao OR loc_lTemIndustria
1580: 
1581:         THIS.txt_4c_Dcod.Enabled = EMPTY(ALLTRIM(THIS.txt_4c_Cod.Value))
1582: 
1583:         THIS.txt_4c_QtdEti.Enabled = EMPTY(THIS.txt_4c_Etif.Value)
1584: 
1585:         loc_lTemGrEstoque = !EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value))
1586:         THIS.txt_4c__Ds_GrEstoque.Enabled = !loc_lTemGrEstoque
1587:         THIS.txt_4c__cd_estoque.Enabled   = loc_lTemGrEstoque
1588:         THIS.txt_4c__ds_estoque.Enabled   = EMPTY(ALLTRIM(THIS.txt_4c__cd_estoque.Value)) AND ;
1589:                                             loc_lTemGrEstoque
1590: 
1591:         THIS.txt_4c_Dgru.Enabled  = EMPTY(ALLTRIM(THIS.txt_4c_Cgru.Value))
1592:         THIS.txt_4c_CSGru.Enabled = !EMPTY(ALLTRIM(THIS.txt_4c_Cgru.Value))
1593:         THIS.txt_4c_DSGru.Enabled = !EMPTY(ALLTRIM(THIS.txt_4c_Cgru.Value)) AND ;
1594:                                      EMPTY(ALLTRIM(THIS.txt_4c_CSGru.Value))
1595: 
1596:         THIS.txt_4c_DCol.Enabled = EMPTY(ALLTRIM(THIS.txt_4c_Col.Value))
1597:     ENDPROC
1598: 
1599:     *==========================================================================
1600:     * ValidarCdEmpresaLostFocus / ValidarDsEmpresaLostFocus
1601:     * fAcessoEmpresa(legado) -> SigCdEmp.Cemps/Razas (regra CLAUDE.md
1602:     * "fAcessoEmpresa() NAO EXISTE" - substituicao canonica AbrirLookupCanonico)
1603:     *==========================================================================
1604:     PROCEDURE ValidarCdEmpresaLostFocus()
1605:         LOCAL loc_cValor
1606: 
1607:         IF THIS.this_lEmLookup
1608:             RETURN
1609:         ENDIF
1610:         THIS.this_lEmLookup = .T.
1611: 
1612:         loc_cValor = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
1613:         IF !EMPTY(loc_cValor)
1614:             THIS.AbrirLookupCanonico("SigCdEmp", "Cemps", "Razas", ;
1615:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;
1616:                 THIS.txt_4c__cd_empresa, THIS.txt_4c__ds_empresa)
1617:         ELSE
1618:             THIS.txt_4c__ds_empresa.Value = ""
1619:         ENDIF
1620: 
1621:         THIS.AjustarDependenciasCampos()
1622:         THIS.this_lEmLookup = .F.
1623:     ENDPROC
1624: 
1625:     PROCEDURE ValidarDsEmpresaLostFocus()
1626:         LOCAL loc_cValor
1627: 
1628:         IF THIS.this_lEmLookup
1629:             RETURN
1630:         ENDIF
1631:         THIS.this_lEmLookup = .T.
1632: 
1633:         loc_cValor = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
1634:         IF !EMPTY(loc_cValor)
1635:             THIS.AbrirLookupCanonico("SigCdEmp", "Razas", "Cemps", ;
1636:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa", loc_cValor, ;
1637:                 THIS.txt_4c__ds_empresa, THIS.txt_4c__cd_empresa)
1638:         ENDIF
1639: 
1640:         THIS.AjustarDependenciasCampos()
1641:         THIS.this_lEmLookup = .F.
1642:     ENDPROC
1643: 
1644:     *==========================================================================
1645:     * AbrirLookupOperacaoIndustria
1646:     * Compartilhado por Operacao e Industria (regra #27 - fAcessoMovmto eh
1647:     * funcao global do legado indisponivel na nova arquitetura; ambos os
1648:     * campos do SCX validam contra a MESMA tabela SigCdOpd.dopps - o
1649:     * Valid de get_nm_industria faz SEEK/fwBuscaInt sobre SigCdOpd.dopps, e
1650:     * get_nm_operacao.Valid chama fAcessoMovmto sobre o mesmo dominio).
1651:     *==========================================================================
1652:     PROTECTED PROCEDURE AbrirLookupOperacaoIndustria(par_oTxt)
1653:         LOCAL loc_cValor
1654: 
1655:         loc_cValor = ALLTRIM(par_oTxt.Value)
1656:         IF !EMPTY(loc_cValor)
1657:             THIS.AbrirLookupCanonico("SigCdOpd", "dopps", "dopps", ;
1658:                 "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o", ;
1659:                 loc_cValor, par_oTxt, .NULL.)
1660:         ENDIF
1661:     ENDPROC
1662: 
1663:     PROCEDURE ValidarOperacaoLostFocus()
1664:         IF THIS.this_lEmLookup
1665:             RETURN
1666:         ENDIF
1667:         THIS.this_lEmLookup = .T.
1668:         THIS.AbrirLookupOperacaoIndustria(THIS.txt_4c__nm_operacao)
1669:         THIS.AjustarDependenciasCampos()
1670:         THIS.this_lEmLookup = .F.
1671:     ENDPROC
1672: 
1673:     PROCEDURE ValidarIndustriaLostFocus()
1674:         IF THIS.this_lEmLookup
1675:             RETURN
1676:         ENDIF
1677:         THIS.this_lEmLookup = .T.
1678:         THIS.AbrirLookupOperacaoIndustria(THIS.txt_4c__nm_industria)
1679:         THIS.AjustarDependenciasCampos()
1680:         THIS.this_lEmLookup = .F.
1681:     ENDPROC
1682: 
1683:     *==========================================================================
1684:     * ValidarDataiLostFocus / ValidarDatafLostFocus
1685:     * Data Final nao pode ser menor que a Data Inicial (transcrito literal
1686:     * de Get_Dataf.Valid do legado)
1687:     *==========================================================================
1688:     PROCEDURE ValidarDataiLostFocus()
1689:         THIS.AjustarDependenciasCampos()
1690:     ENDPROC
1691: 
1692:     PROCEDURE ValidarDatafLostFocus()
1693:         IF !EMPTY(THIS.txt_4c_Datai.Value) AND !EMPTY(THIS.txt_4c_Dataf.Value) AND ;
1694:            THIS.txt_4c_Dataf.Value < THIS.txt_4c_Datai.Value
1695:             MsgAviso("Data Final Deve Ser Maior Que a Inicial!!!", "Aten" + CHR(231) + CHR(227) + "o")
1696:             THIS.txt_4c_Dataf.SetFocus()
1697:         ENDIF
1698:     ENDPROC
1699: 
1700:     *==========================================================================
1701:     * ValidarCodProdutoLostFocus / ValidarDescProdutoLostFocus
1702:     * fwBuscaExt(legado) -> SigCdPro.CPros/DPros
1703:     *==========================================================================
1704:     PROCEDURE ValidarCodProdutoLostFocus()
1705:         LOCAL loc_cValor
1706: 
1707:         IF THIS.this_lEmLookup
1708:             RETURN
1709:         ENDIF
1710:         THIS.this_lEmLookup = .T.
1711: 
1712:         loc_cValor = ALLTRIM(THIS.txt_4c_Cod.Value)
1713:         IF !EMPTY(loc_cValor)
1714:             THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", "Produtos", ;
1715:                 loc_cValor, THIS.txt_4c_Cod, THIS.txt_4c_Dcod)
1716:         ELSE
1717:             THIS.txt_4c_Dcod.Value = ""
1718:         ENDIF
1719: 
1720:         THIS.AjustarDependenciasCampos()
1721:         THIS.this_lEmLookup = .F.
1722:     ENDPROC
1723: 
1724:     PROCEDURE ValidarDescProdutoLostFocus()
1725:         LOCAL loc_cValor
1726: 
1727:         IF THIS.this_lEmLookup
1728:             RETURN
1729:         ENDIF
1730:         THIS.this_lEmLookup = .T.
1731: 
1732:         loc_cValor = ALLTRIM(THIS.txt_4c_Dcod.Value)
1733:         IF !EMPTY(loc_cValor)
1734:             THIS.AbrirLookupCanonico("SigCdPro", "DPros", "CPros", "Produtos", ;
1735:                 loc_cValor, THIS.txt_4c_Dcod, THIS.txt_4c_Cod)
1736:         ENDIF
1737: 
1738:         THIS.AjustarDependenciasCampos()
1739:         THIS.this_lEmLookup = .F.
1740:     ENDPROC
1741: 
1742:     *==========================================================================
1743:     * ValidarEtiiLostFocus / ValidarEtifLostFocus
1744:     * Faixa de codigo de barras - transcrito literal do Valid legado:
1745:     * busca em SigOpEtq (com fallback na troca de codigo SigOpEta) e avisa
1746:     * se a etiqueta nao esta cadastrada. NAO eh lookup FormBuscaAuxiliar -
1747:     * eh SQL direto (SigOpEtq.cbars numeric(14,0)).
1748:     *==========================================================================
1749:     PROCEDURE ValidarEtiiLostFocus()
1750:         LOCAL loc_cSQL, loc_nResultado
1751: 
1752:         IF THIS.txt_4c_Etii.Value = 0
1753:             THIS.AjustarDependenciasCampos()
1754:             RETURN
1755:         ENDIF
1756: 
1757:         loc_cSQL = "SELECT a.CPros, a.CBars " + ;
1758:                    "FROM SigOpEtq a " + ;
1759:                    "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
1760:                    "WHERE (a.CBars = " + FormatarNumeroSQL(THIS.txt_4c_Etii.Value, 0) + ;
1761:                    " OR b.cbars_old = " + FormatarNumeroSQL(THIS.txt_4c_Etii.Value, 0) + ")"
1762: 
1763:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiqs")
1764:         IF loc_nResultado < 1 OR !USED("cursor_4c_Etiqs") OR RECCOUNT("cursor_4c_Etiqs") = 0
1765:             MsgAviso("Etiqueta N" + CHR(227) + "o Cadastrada!!!", "Aten" + CHR(231) + CHR(227) + "o")
1766:             THIS.txt_4c_Etii.Value = 0
1767:         ELSE
1768:             SELECT cursor_4c_Etiqs
1769:             GO TOP
1770:             THIS.txt_4c_Etii.Value = cursor_4c_Etiqs.CBars
1771:         ENDIF
1772:         IF USED("cursor_4c_Etiqs")
1773:             USE IN cursor_4c_Etiqs
1774:         ENDIF
1775: 
1776:         IF THIS.txt_4c_Etif.Value = 0 AND THIS.txt_4c_Etii.Value != 0
1777:             THIS.txt_4c_Etif.Value = THIS.txt_4c_Etii.Value
1778:         ENDIF
1779: 
1780:         THIS.AjustarDependenciasCampos()
1781:     ENDPROC
1782: 
1783:     PROCEDURE ValidarEtifLostFocus()
1784:         LOCAL loc_cSQL, loc_nResultado
1785: 
1786:         IF THIS.txt_4c_Etif.Value = 0
1787:             THIS.AjustarDependenciasCampos()
1788:             RETURN
1789:         ENDIF
1790: 
1791:         loc_cSQL = "SELECT a.CPros, a.CBars " + ;
1792:                    "FROM SigOpEtq a " + ;
1793:                    "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
1794:                    "WHERE (a.CBars = " + FormatarNumeroSQL(THIS.txt_4c_Etif.Value, 0) + ;
1795:                    " OR b.cbars_old = " + FormatarNumeroSQL(THIS.txt_4c_Etif.Value, 0) + ")"
1796: 
1797:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiqs")
1798:         IF loc_nResultado < 1 OR !USED("cursor_4c_Etiqs") OR RECCOUNT("cursor_4c_Etiqs") = 0
1799:             MsgAviso("Etiqueta N" + CHR(227) + "o Cadastrada!!!", "Aten" + CHR(231) + CHR(227) + "o")
1800:             THIS.txt_4c_Etif.Value = 0
1801:         ELSE
1802:             SELECT cursor_4c_Etiqs
1803:             GO TOP
1804:             THIS.txt_4c_Etif.Value = cursor_4c_Etiqs.CBars
1805:         ENDIF
1806:         IF USED("cursor_4c_Etiqs")
1807:             USE IN cursor_4c_Etiqs
1808:         ENDIF
1809: 
1810:         THIS.AjustarDependenciasCampos()
1811:     ENDPROC
1812: 
1813:     *==========================================================================
1814:     * ValidarCdGrEstoqueLostFocus / ValidarDsGrEstoqueLostFocus
1815:     * fAcessoContab(legado) -> SigCdGcr.codigos/descrs, filtrado por
1816:     * Estoques = 1 (Grupo de Estoque, nao Grupo CC generico)
1817:     *==========================================================================
1818:     PROCEDURE ValidarCdGrEstoqueLostFocus()
1819:         LOCAL loc_cValor
1820: 
1821:         IF THIS.this_lEmLookup
1822:             RETURN
1823:         ENDIF
1824:         THIS.this_lEmLookup = .T.
1825: 
1826:         loc_cValor = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
1827:         IF !EMPTY(loc_cValor)
1828:             THIS.AbrirLookupCanonico("SigCdGcr", "codigos", "descrs", ;
1829:                 "Grupo de Estoque", loc_cValor, ;
1830:                 THIS.txt_4c__Cd_GrEstoque, THIS.txt_4c__Ds_GrEstoque, "Estoques = 1")
1831:         ELSE
1832:             THIS.txt_4c__Ds_GrEstoque.Value = ""
1833:         ENDIF
1834: 
1835:         THIS.AjustarDependenciasCampos()
1836:         THIS.this_lEmLookup = .F.
1837:     ENDPROC
1838: 
1839:     PROCEDURE ValidarDsGrEstoqueLostFocus()
1840:         LOCAL loc_cValor
1841: 
1842:         IF THIS.this_lEmLookup
1843:             RETURN
1844:         ENDIF
1845:         THIS.this_lEmLookup = .T.
1846: 
1847:         loc_cValor = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
1848:         IF !EMPTY(loc_cValor)
1849:             THIS.AbrirLookupCanonico("SigCdGcr", "descrs", "codigos", ;
1850:                 "Grupo de Estoque", loc_cValor, ;
1851:                 THIS.txt_4c__Ds_GrEstoque, THIS.txt_4c__Cd_GrEstoque, "Estoques = 1")
1852:         ELSE
1853:             THIS.txt_4c__Cd_GrEstoque.Value = ""
1854:         ENDIF
1855: 
1856:         THIS.AjustarDependenciasCampos()
1857:         THIS.this_lEmLookup = .F.
1858:     ENDPROC
1859: 
1860:     *==========================================================================
1861:     * ValidarCdEstoqueLostFocus / ValidarDsEstoqueLostFocus
1862:     * fAcessoContas(legado) -> SigCdCli.Iclis/Rclis, filtrado pelo Grupo de
1863:     * Estoque corrente (txt_4c__Cd_GrEstoque)
1864:     *==========================================================================
1865:     PROCEDURE ValidarCdEstoqueLostFocus()
1866:         LOCAL loc_cValor, loc_cGrupo, loc_cFiltro
1867: 
1868:         IF THIS.this_lEmLookup
1869:             RETURN
1870:         ENDIF
1871:         THIS.this_lEmLookup = .T.
1872: 
1873:         loc_cValor = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
1874:         loc_cGrupo = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
1875:         IF !EMPTY(loc_cValor)
1876:             loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "Grupos = " + EscaparSQL(loc_cGrupo), "")
1877:             THIS.AbrirLookupCanonico("SigCdCli", "Iclis", "Rclis", "Estoque", ;
1878:                 loc_cValor, THIS.txt_4c__cd_estoque, THIS.txt_4c__ds_estoque, loc_cFiltro)
1879:         ELSE
1880:             THIS.txt_4c__ds_estoque.Value = ""
1881:         ENDIF
1882: 
1883:         THIS.AjustarDependenciasCampos()
1884:         THIS.this_lEmLookup = .F.
1885:     ENDPROC
1886: 
1887:     PROCEDURE ValidarDsEstoqueLostFocus()
1888:         LOCAL loc_cValor, loc_cGrupo, loc_cFiltro
1889: 
1890:         IF THIS.this_lEmLookup
1891:             RETURN
1892:         ENDIF
1893:         THIS.this_lEmLookup = .T.
1894: 
1895:         loc_cValor = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
1896:         loc_cGrupo = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
1897:         IF !EMPTY(loc_cValor)
1898:             loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "Grupos = " + EscaparSQL(loc_cGrupo), "")
1899:             THIS.AbrirLookupCanonico("SigCdCli", "Rclis", "Iclis", "Estoque", ;
1900:                 loc_cValor, THIS.txt_4c__ds_estoque, THIS.txt_4c__cd_estoque, loc_cFiltro)
1901:         ELSE
1902:             THIS.txt_4c__cd_estoque.Value = ""
1903:         ENDIF
1904: 
1905:         THIS.AjustarDependenciasCampos()
1906:         THIS.this_lEmLookup = .F.
1907:     ENDPROC
1908: 
1909:     *==========================================================================
1910:     * ValidarGrandeGrupoLostFocus - fwBuscaExt(legado) -> SigCdGpr.Codigos/Descs
1911:     * (sem campo de descricao na tela - legado tambem so grava o codigo)
1912:     *==========================================================================
1913:     PROCEDURE ValidarGrandeGrupoLostFocus()
1914:         LOCAL loc_cValor
1915: 
1916:         IF THIS.this_lEmLookup
1917:             RETURN
1918:         ENDIF
1919:         THIS.this_lEmLookup = .T.
1920: 
1921:         loc_cValor = ALLTRIM(THIS.txt_4c__gde_grupo.Value)
1922:         IF !EMPTY(loc_cValor)
1923:             THIS.AbrirLookupCanonico("SigCdGpr", "Codigos", "Descs", "Grande Grupo", ;
1924:                 loc_cValor, THIS.txt_4c__gde_grupo, .NULL.)
1925:         ENDIF
1926: 
1927:         THIS.AjustarDependenciasCampos()
1928:         THIS.this_lEmLookup = .F.
1929:     ENDPROC
1930: 
1931:     *==========================================================================
1932:     * ValidarGrupoProdutoLostFocus / ValidarDescGrupoProdutoLostFocus
1933:     * fwBuscaExt(legado) -> SigCdGrp.CGrus/DGrus
1934:     *==========================================================================
1935:     PROCEDURE ValidarGrupoProdutoLostFocus()
1936:         LOCAL loc_cValor
1937: 
1938:         IF THIS.this_lEmLookup
1939:             RETURN
1940:         ENDIF
1941:         THIS.this_lEmLookup = .T.
1942: 
1943:         loc_cValor = ALLTRIM(THIS.txt_4c_Cgru.Value)
1944:         IF !EMPTY(loc_cValor)
1945:             THIS.AbrirLookupCanonico("SigCdGrp", "CGrus", "DGrus", "Grupos", ;
1946:                 loc_cValor, THIS.txt_4c_Cgru, THIS.txt_4c_Dgru)
1947:         ELSE
1948:             THIS.txt_4c_Dgru.Value = ""
1949:         ENDIF
1950: 
1951:         THIS.AjustarDependenciasCampos()
1952:         THIS.this_lEmLookup = .F.
1953:     ENDPROC
1954: 
1955:     PROCEDURE ValidarDescGrupoProdutoLostFocus()
1956:         LOCAL loc_cValor
1957: 
1958:         IF THIS.this_lEmLookup
1959:             RETURN
1960:         ENDIF
1961:         THIS.this_lEmLookup = .T.
1962: 
1963:         loc_cValor = ALLTRIM(THIS.txt_4c_Dgru.Value)
1964:         IF !EMPTY(loc_cValor)
1965:             THIS.AbrirLookupCanonico("SigCdGrp", "DGrus", "CGrus", "Grupos", ;
1966:                 loc_cValor, THIS.txt_4c_Dgru, THIS.txt_4c_Cgru)
1967:         ENDIF
1968: 
1969:         THIS.AjustarDependenciasCampos()
1970:         THIS.this_lEmLookup = .F.
1971:     ENDPROC
1972: 
1973:     *==========================================================================
1974:     * ValidarSubgrupoCodLostFocus / ValidarSubgrupoDescLostFocus
1975:     * fwBuscaExt(legado) -> SigCdPsg.Codigos/Descricaos, filtrado por
1976:     * CGrus = Padr(getCgru.Value, 3) - so habilitado com Grupo Produto
1977:     * preenchido (ver AjustarDependenciasCampos)
1978:     *==========================================================================
1979:     PROCEDURE ValidarSubgrupoCodLostFocus()
1980:         LOCAL loc_cValor, loc_cFiltro
1981: 
1982:         IF THIS.this_lEmLookup
1983:             RETURN
1984:         ENDIF
1985:         THIS.this_lEmLookup = .T.
1986: 
1987:         loc_cValor  = ALLTRIM(THIS.txt_4c_CSGru.Value)
1988:         loc_cFiltro = "CGrus = " + EscaparSQL(PADR(ALLTRIM(THIS.txt_4c_Cgru.Value), 3))
1989:         IF !EMPTY(loc_cValor)
1990:             THIS.AbrirLookupCanonico("SigCdPsg", "Codigos", "Descricaos", "Sub-Grupos", ;
1991:                 loc_cValor, THIS.txt_4c_CSGru, THIS.txt_4c_DSGru, loc_cFiltro)
1992:         ELSE
1993:             THIS.txt_4c_DSGru.Value = ""
1994:         ENDIF
1995: 
1996:         THIS.AjustarDependenciasCampos()
1997:         THIS.this_lEmLookup = .F.
1998:     ENDPROC
1999: 
2000:     PROCEDURE ValidarSubgrupoDescLostFocus()
2001:         LOCAL loc_cValor, loc_cFiltro
2002: 
2003:         IF THIS.this_lEmLookup
2004:             RETURN
2005:         ENDIF
2006:         THIS.this_lEmLookup = .T.
2007: 
2008:         loc_cValor  = ALLTRIM(THIS.txt_4c_DSGru.Value)
2009:         loc_cFiltro = "CGrus = " + EscaparSQL(PADR(ALLTRIM(THIS.txt_4c_Cgru.Value), 3))
2010:         IF !EMPTY(loc_cValor)
2011:             THIS.AbrirLookupCanonico("SigCdPsg", "Descricaos", "Codigos", "Sub-Grupos", ;
2012:                 loc_cValor, THIS.txt_4c_DSGru, THIS.txt_4c_CSGru, loc_cFiltro)
2013:         ELSE
2014:             THIS.txt_4c_CSGru.Value = ""
2015:         ENDIF
2016: 
2017:         THIS.AjustarDependenciasCampos()
2018:         THIS.this_lEmLookup = .F.
2019:     ENDPROC
2020: 
2021:     *==========================================================================
2022:     * ValidarGrupoVendaCodLostFocus / ValidarGrupoVendaDescLostFocus
2023:     * fwBuscaExt(legado) -> SigCdCol.Colecoes/Descs
2024:     *==========================================================================
2025:     PROCEDURE ValidarGrupoVendaCodLostFocus()
2026:         LOCAL loc_cValor
2027: 
2028:         IF THIS.this_lEmLookup
2029:             RETURN
2030:         ENDIF
2031:         THIS.this_lEmLookup = .T.
2032: 
2033:         loc_cValor = ALLTRIM(THIS.txt_4c_Col.Value)
2034:         IF !EMPTY(loc_cValor)
2035:             THIS.AbrirLookupCanonico("SigCdCol", "Colecoes", "Descs", "Sele" + CHR(231) + CHR(227) + "o", ;
2036:                 loc_cValor, THIS.txt_4c_Col, THIS.txt_4c_DCol)
2037:         ELSE
2038:             THIS.txt_4c_DCol.Value = ""
2039:         ENDIF
2040: 
2041:         THIS.AjustarDependenciasCampos()
2042:         THIS.this_lEmLookup = .F.
2043:     ENDPROC
2044: 
2045:     PROCEDURE ValidarGrupoVendaDescLostFocus()
2046:         LOCAL loc_cValor
2047: 
2048:         IF THIS.this_lEmLookup
2049:             RETURN
2050:         ENDIF
2051:         THIS.this_lEmLookup = .T.
2052: 
2053:         loc_cValor = ALLTRIM(THIS.txt_4c_DCol.Value)
2054:         IF !EMPTY(loc_cValor)
2055:             THIS.AbrirLookupCanonico("SigCdCol", "Descs", "Colecoes", "Sele" + CHR(231) + CHR(227) + "o", ;
2056:                 loc_cValor, THIS.txt_4c_DCol, THIS.txt_4c_Col)
2057:         ENDIF
2058: 
2059:         THIS.AjustarDependenciasCampos()
2060:         THIS.this_lEmLookup = .F.
2061:     ENDPROC
2062: 
2063:     *==========================================================================
2064:     * ValidarLinhaLostFocus - fwBuscaExt(legado) -> SigCdLin.linhas/descs
2065:     * (sem campo de descricao na tela)
2066:     *==========================================================================
2067:     PROCEDURE ValidarLinhaLostFocus()
2068:         LOCAL loc_cValor
2069: 
2070:         IF THIS.this_lEmLookup
2071:             RETURN
2072:         ENDIF
2073:         THIS.this_lEmLookup = .T.
2074: 
2075:         loc_cValor = ALLTRIM(THIS.txt_4c_Lin.Value)
2076:         IF !EMPTY(loc_cValor)
2077:             THIS.AbrirLookupCanonico("SigCdLin", "linhas", "descs", "Sele" + CHR(231) + CHR(227) + "o", ;
2078:                 loc_cValor, THIS.txt_4c_Lin, .NULL.)
2079:         ENDIF
2080: 
2081:         THIS.AjustarDependenciasCampos()
2082:         THIS.this_lEmLookup = .F.
2083:     ENDPROC
2084: 
2085:     *==========================================================================
2086:     * ValidarLocalProdutoLostFocus / ValidarLocalEtiquetaLostFocus
2087:     * fwBuscaExt(legado) -> SigPrLcl.Codigos/Descricaos (sem campo de
2088:     * descricao na tela - legado tambem so grava o codigo)
2089:     *==========================================================================
2090:     PROCEDURE ValidarLocalProdutoLostFocus()
2091:         LOCAL loc_cValor
2092: 
2093:         IF THIS.this_lEmLookup
2094:             RETURN
2095:         ENDIF
2096:         THIS.this_lEmLookup = .T.
2097: 
2098:         loc_cValor = ALLTRIM(THIS.txt_4c_Local.Value)
2099:         IF !EMPTY(loc_cValor)
2100:             THIS.AbrirLookupCanonico("SigPrLcl", "Codigos", "Descricaos", "Sele" + CHR(231) + CHR(227) + "o", ;
2101:                 loc_cValor, THIS.txt_4c_Local, .NULL.)
2102:         ENDIF
2103: 
2104:         THIS.AjustarDependenciasCampos()
2105:         THIS.this_lEmLookup = .F.
2106:     ENDPROC
2107: 
2108:     PROCEDURE ValidarLocalEtiquetaLostFocus()
2109:         LOCAL loc_cValor
2110: 
2111:         IF THIS.this_lEmLookup
2112:             RETURN
2113:         ENDIF
2114:         THIS.this_lEmLookup = .T.
2115: 
2116:         loc_cValor = ALLTRIM(THIS.txt_4c_Localizas.Value)
2117:         IF !EMPTY(loc_cValor)
2118:             THIS.AbrirLookupCanonico("SigPrLcl", "Codigos", "Descricaos", "Sele" + CHR(231) + CHR(227) + "o", ;
2119:                 loc_cValor, THIS.txt_4c_Localizas, .NULL.)
2120:         ENDIF
2121: 
2122:         THIS.AjustarDependenciasCampos()
2123:         THIS.this_lEmLookup = .F.
2124:     ENDPROC
2125: 
2126:     *==========================================================================
2127:     * ValidarPromocaoLostFocus - fwBuscaExt(legado) -> SigPrPmc.promos
2128:     * (coluna unica - codigo e descricao sao a mesma coisa)
2129:     *==========================================================================
2130:     PROCEDURE ValidarPromocaoLostFocus()
2131:         LOCAL loc_cValor
2132: 
2133:         IF THIS.this_lEmLookup
2134:             RETURN
2135:         ENDIF
2136:         THIS.this_lEmLookup = .T.
2137: 
2138:         loc_cValor = ALLTRIM(THIS.txt_4c__promos.Value)
2139:         IF !EMPTY(loc_cValor)
2140:             THIS.AbrirLookupCanonico("SigPrPmc", "promos", "promos", "Promo" + CHR(231) + CHR(227) + "o", ;
2141:                 loc_cValor, THIS.txt_4c__promos, .NULL.)
2142:         ENDIF
2143: 
2144:         THIS.AjustarDependenciasCampos()
2145:         THIS.this_lEmLookup = .F.
2146:     ENDPROC
2147: 
2148:     *==========================================================================
2149:     * FormParaBO - transcreve TODOS os campos de filtro da tela para as
2150:     * propriedades do BO (ja declaradas nas Fases 1-2), no INSTANTE do
2151:     * clique - equivalente ao bloco de variaveis PRIVATE do consulta.Click
2152:     * legado:
2153:     *   pcCdProduto = ThisForm.get_cod.Value        / pcDsProduto = ...get_dcod.Value
2154:     *   pdDtInicial = ThisForm.Get_datai.Value       / pdDtFinal = Iif(IsEmpty(...Get_dataf.Value), Ctod([31/12/9999]), ...)
2155:     *   pnEtiqIni/pnEtiqFim/pnOrdem/pcestoque/pcgrestoque/pcOperacao/
2156:     *   pcindustria/pnNumero/pnNumerof/OptMarca/pcGrupo/pcSGrus/pcColecoes/
2157:     *   pcGdeGrupo/pcEmpresa/pnQtdEti/pcLinha/pcDepto/pcLocaliza/pcPromos
2158:     *
2159:     * Usado so por BtnConsultaClick - Digitacao/Arquivadas NAO leem a tela
2160:     * (o legado reseta a maior parte dos filtros para esses dois modos, ver
2161:     * comentario de cada Btn*Click).
2162:     *==========================================================================
2163:     PROTECTED PROCEDURE FormParaBO()
2164:         WITH THIS.this_oBusinessObject
2165:             .this_cCodigo      = ALLTRIM(THIS.txt_4c_Cod.Value)
2166:             .this_cDescricao   = ALLTRIM(THIS.txt_4c_Dcod.Value)
2167:             .this_dDataIni     = THIS.txt_4c_Datai.Value
2168:             .this_dDataFim     = IIF(EMPTY(THIS.txt_4c_Dataf.Value), CTOD("31/12/9999"), THIS.txt_4c_Dataf.Value)
2169:             .this_nEtiquetaIni = THIS.txt_4c_Etii.Value
2170:             .this_nEtiquetaFim = THIS.txt_4c_Etif.Value
2171:             .this_nQtdEtiqueta = THIS.txt_4c_QtdEti.Value
2172:             .this_cGrEstoque   = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
2173:             .this_cEstoque     = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
2174:             .this_cOperacao    = ALLTRIM(THIS.txt_4c__nm_operacao.Value)
2175:             .this_cIndustria   = ALLTRIM(THIS.txt_4c__nm_industria.Value)
2176:             .this_nNumero      = THIS.txt_4c_Numero.Value
2177:             .this_nNumerof     = THIS.txt_4c_Numerof.Value
2178:             .this_cEmpresa     = ALLTRIM(THIS.txt_4c__cd_empresa.Value)
2179:             .this_cDsEmpresa   = ALLTRIM(THIS.txt_4c__ds_empresa.Value)
2180:             .this_cGrupo       = ALLTRIM(THIS.txt_4c_Cgru.Value)
2181:             .this_cDsGrupo     = ALLTRIM(THIS.txt_4c_Dgru.Value)
2182:             .this_cSubGrupo    = ALLTRIM(THIS.txt_4c_CSGru.Value)
2183:             .this_cDsSubGrupo  = ALLTRIM(THIS.txt_4c_DSGru.Value)
2184:             .this_cGrandeGrupo = ALLTRIM(THIS.txt_4c__gde_grupo.Value)
2185:             .this_cLinha       = ALLTRIM(THIS.txt_4c_Lin.Value)
2186:             .this_cLocal       = ALLTRIM(THIS.txt_4c_Local.Value)
2187:             .this_cLocalizacao = ALLTRIM(THIS.txt_4c_Localizas.Value)
2188:             .this_cColecao     = ALLTRIM(THIS.txt_4c_Col.Value)
2189:             .this_cDsColecao   = ALLTRIM(THIS.txt_4c_DCol.Value)
2190:             .this_cPromocao    = ALLTRIM(THIS.txt_4c__promos.Value)
2191:             .this_nOrdem       = THIS.obj_4c_Get_Ordem.Value
2192:             .this_nMarca       = THIS.obj_4c_Opt_Marcas.Value
2193:             .this_nPreco       = THIS.obj_4c_Chk_Preco.Value
2194:         ENDWITH
2195:     ENDPROC
2196: 
2197:     *==========================================================================
2198:     * BtnConsultaClick - equivalente a SIGPRRET.sair.consulta.Click: monta o
2199:     * filtro completo da tela (FormParaBO), marca THIS.this_cTipo = 'CONSULTA'
2200:     * (equivalente a ThisForm.Tipo) e delega para a tela de impressao
2201:     * (fora do escopo desta migracao - ver comentario no topo do arquivo).
2202:     *==========================================================================
2203:     PROCEDURE BtnConsultaClick()
2204:         THIS.FormParaBO()
2205:         THIS.DespacharImpressao("CONSULTA")
2206:     ENDPROC
2207: 
2208:     *==========================================================================
2209:     * BtnEncerrarClick - equivalente a SIGPRRET.sair.sair.Click: "ThisForm.
2210:     * Release" - unico caminho de saida da tela (form Flat, sem Page2/Dados
2211:     * para cancelar).
2212:     *==========================================================================
2213:     PROCEDURE BtnEncerrarClick()
2214:         THIS.Release()
2215:     ENDPROC
2216: 
2217:     *==========================================================================
2218:     * BtnDigitacaoClick - equivalente a SIGPRRET.sair.btnDigitacao.Click.
2219:     *
2220:     * O legado NAO le a tela aqui: o Click declara um bloco PRIVATE proprio e
2221:     * zera os filtros um a um (Space()/{}/0), deixando apenas DUAS excecoes
2222:     * lidas da tela - "pnOrdem = ThisForm.Get_Ordem.Value" e
2223:     * "pcPromos = Thisform.Get_Promos.Value".
2224:     *
2225:     * O reset vai por LimparDados() do BO em vez de repetir aquela lista aqui,
2226:     * por causa do CICLO DE VIDA: no legado cada Click cria as PRIVATE do zero
2227:     * e as que ele nao cita simplesmente NAO EXISTEM quando SigOpIpE roda. No
2228:     * sistema novo o BO eh LONGO - o form nao fecha entre um clique e outro -,
2229:     * entao copiar so a lista do legado deixaria Industria, SubGrupo, Linha,
2230:     * Local, Localizacao e Qtd. de Etiquetas com o valor de uma CONSULTA
2231:     * anterior, e a digitacao sairia filtrada por criterio que o usuario nao
2232:     * pediu, sem erro nenhum na tela. LimparDados() repoe o estado inicial
2233:     * INTEIRO (e preserva this_nFixaEmpresa, que eh parametro, nao filtro).
2234:     *==========================================================================
2235:     PROCEDURE BtnDigitacaoClick()
2236:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2237:             RETURN
2238:         ENDIF
2239: 
2240:         THIS.this_oBusinessObject.LimparDados()
2241: 
2242:         WITH THIS.this_oBusinessObject
2243:             *-- "OptMarca = 1" do legado (LimparDados ja repoe o mesmo 1,
2244:             *-- explicito aqui porque eh linha do bloco transcrito)
2245:             .this_nMarca    = 1
2246: 
2247:             *-- As DUAS excecoes do legado, lidas da tela
2248:             .this_nOrdem    = THIS.obj_4c_Get_Ordem.Value
2249:             .this_cPromocao = ALLTRIM(THIS.txt_4c__promos.Value)
2250:         ENDWITH
2251: 
2252:         THIS.DespacharImpressao("DIGITACAO")
2253:     ENDPROC
2254: 
2255:     *==========================================================================
2256:     * BtnArquivadasClick - equivalente a SIGPRRET.sair.Arquivadas.Click.
2257:     *
2258:     * Mesmo reset de BtnDigitacaoClick, com UMA diferenca transcrita literal
2259:     * do legado: "pnOrdem = 1" - a Ordem vem FIXA em 1, NAO da tela, ao
2260:     * contrario de btnDigitacao. Promocao continua lida da tela.
2261:     *==========================================================================
2262:     PROCEDURE BtnArquivadasClick()
2263:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2264:             RETURN
2265:         ENDIF
2266: 
2267:         THIS.this_oBusinessObject.LimparDados()
2268: 
2269:         WITH THIS.this_oBusinessObject
2270:             *-- "OptMarca = 1" / "pnOrdem = 1" - os dois FIXOS no legado
2271:             .this_nMarca    = 1
2272:             .this_nOrdem    = 1
2273: 
2274:             *-- Unica excecao lida da tela
2275:             .this_cPromocao = ALLTRIM(THIS.txt_4c__promos.Value)
2276:         ENDWITH
2277: 
2278:         THIS.DespacharImpressao("ARQUIVADAS")
2279:     ENDPROC
2280: 
2281:     *==========================================================================
2282:     * AplicarFixaEmpresa - Regra "fixa empresa" do Init do legado.
2283:     *
2284:     * Transcreve o bloco (mena - 02/04/2017) do SIGPRRET.Init:
2285:     *   m.lcMcrSql1 = [select a.* from SigCdPac a ]
2286:     *   m.lnErro1   = .poDatamgr.Sqlexecute(m.lcMcrSql1,'crSigCdpac')
2287:     *   IF crSigCdpac.fixaemp = 1
2288:     *       ThisForm.get_Cd_Empresa.value   = _empr
2289:     *       ThisForm.get_Cd_Empresa.enabled = .F.
2290:     *       fAcessoEmpresa(Usuar, 'C', _empr, ThisForm.get_Cd_Empresa, ThisForm.get_Ds_Empresa)
2291:     *   ENDIF
2292:     *
2293:     * _EMPR eh LEGADO e NAO se usa (CLAUDE.md) - o equivalente eh
2294:     * go_4c_Sistema.cCodEmpresa. fAcessoEmpresa tambem nao foi portada; aqui
2295:     * o codigo eh EXATO e nao ha nada a escolher, por isso a resolucao da
2296:     * Razao Social vai por SigPrRetBO.CarregarEmpresa() (consulta direta) e
2297:     * nao pelo picker de AbrirLookupCanonico, que SEMPRE abre dialogo.
2298:     *
2299:     * Sem o parametro aplicado o campo Empresa fica livre e a consulta sai
2300:     * com a empresa errada, sem erro nenhum na tela.
2301:     *==========================================================================
2302:     PROTECTED PROCEDURE AplicarFixaEmpresa()
2303:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2304:             RETURN
2305:         ENDIF
2306: 
2307:         *-- Harness de UI/teste roda sem conexao (gnConnHandle = 0/-1 de
2308:         *-- proposito): nao ha parametro a ler e o SQLEXEC so geraria ruido.
2309:         IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
2310:            (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
2311:             RETURN
2312:         ENDIF
2313: 
2314:         IF THIS.this_oBusinessObject.CarregarParametros()
2315:             THIS.FixarEmpresaNaTela()
2316:         ENDIF
2317:     ENDPROC
2318: 
2319:     *==========================================================================
2320:     * FixarEmpresaNaTela - Segunda metade de AplicarFixaEmpresa, separada
2321:     * porque o parametro SigCdPac.fixaemp eh lido UMA vez (no Init) e a trava
2322:     * precisa poder ser reafirmada sem reconsultar o banco.
2323:     *==========================================================================
2324:     PROTECTED PROCEDURE FixarEmpresaNaTela()
2325:         LOCAL loc_cEmpresa
2326: 
2327:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2328:             RETURN
2329:         ENDIF
2330: 
2331:         IF THIS.this_oBusinessObject.this_nFixaEmpresa != 1
2332:             RETURN
2333:         ENDIF
2334: 
2335:         loc_cEmpresa = ""
2336:         IF TYPE("go_4c_Sistema") = "O"
2337:             loc_cEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
2338:         ENDIF
2339: 
2340:         IF EMPTY(loc_cEmpresa)
2341:             MsgAviso("Par" + CHR(226) + "metro 'fixa empresa' est" + CHR(225) + ;
2342:                      " ligado em SigCdPac, mas a empresa do sistema n" + CHR(227) + ;
2343:                      "o est" + CHR(225) + " definida." + CHR(13) + ;
2344:                      "O filtro Empresa fica liberado.", ;
2345:                      "Aten" + CHR(231) + CHR(227) + "o")
2346:             RETURN
2347:         ENDIF
2348: 
2349:         *-- Resolve a Razao Social no BO e pinta o estado do BO na tela
2350:         THIS.this_oBusinessObject.this_cEmpresa = loc_cEmpresa
2351:         THIS.this_oBusinessObject.CarregarEmpresa(loc_cEmpresa)
2352:         THIS.BOParaForm()
2353: 
2354:         *-- A trava (get_Cd_Empresa.enabled = .F.) sai de
2355:         *-- AjustarDependenciasCampos, que le this_nFixaEmpresa - fonte unica,
2356:         *-- para o primeiro LostFocus nao destravar o campo de novo.
2357:         THIS.AjustarDependenciasCampos()
2358:     ENDPROC
2359: 
2360:     *==========================================================================
2361:     * BOParaForm - Pinta na tela o estado dos filtros guardado no BO.
2362:     *
2363:     * Inverso EXATO de FormParaBO(), campo a campo. Quem alimenta o BO por
2364:     * outro caminho que nao a digitacao (hoje: a regra "fixa empresa" do Init,
2365:     * que resolve a Razao Social a partir do codigo da empresa do sistema)
2366:     * precisa deste sentido para que a tela mostre o que vai ser consultado.
2367:     *
2368:     * this_dDataFim tem tratamento proprio: FormParaBO grava a SENTINELA
2369:     * 31/12/9999 quando o usuario deixa a Data Final em branco (transcrito de
2370:     * "Iif(IsEmpty(...Get_dataf.Value), Ctod([31/12/9999]), ...)"). Pintar
2371:     * essa sentinela de volta exibiria uma data que o legado NUNCA mostra, por
2372:     * isso ela volta para a tela como vazia.
2373:     *
2374:     * Os OptionGroups recebem INDICE 1-based: nunca 0, senao a tela perde a
2375:     * selecao que o SCX entrega por design (Get_Ordem=1, Opt_Marcas=1,
2376:     * Chk_Preco=2).
2377:     *==========================================================================
2378:     PROTECTED PROCEDURE BOParaForm()
2379:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2380:             RETURN
2381:         ENDIF
2382: 
2383:         WITH THIS.this_oBusinessObject
2384:             THIS.txt_4c_Cod.Value           = .this_cCodigo
2385:             THIS.txt_4c_Dcod.Value          = .this_cDescricao
2386:             THIS.txt_4c_Datai.Value         = .this_dDataIni
2387:             THIS.txt_4c_Dataf.Value         = IIF(.this_dDataFim = CTOD("31/12/9999"), ;
2388:                                                   {}, .this_dDataFim)
2389:             THIS.txt_4c_Etii.Value          = .this_nEtiquetaIni
2390:             THIS.txt_4c_Etif.Value          = .this_nEtiquetaFim
2391:             THIS.txt_4c_QtdEti.Value        = .this_nQtdEtiqueta
2392:             THIS.txt_4c__Cd_GrEstoque.Value = .this_cGrEstoque
2393:             THIS.txt_4c__Ds_GrEstoque.Value = .this_cDsGrEstoque
2394:             THIS.txt_4c__cd_estoque.Value   = .this_cEstoque
2395:             THIS.txt_4c__ds_estoque.Value   = .this_cDsEstoque
2396:             THIS.txt_4c__nm_operacao.Value  = .this_cOperacao
2397:             THIS.txt_4c__nm_industria.Value = .this_cIndustria
2398:             THIS.txt_4c_Numero.Value        = .this_nNumero
2399:             THIS.txt_4c_Numerof.Value       = .this_nNumerof
2400:             THIS.txt_4c__cd_empresa.Value   = .this_cEmpresa
2401:             THIS.txt_4c__ds_empresa.Value   = .this_cDsEmpresa
2402:             THIS.txt_4c_Cgru.Value          = .this_cGrupo
2403:             THIS.txt_4c_Dgru.Value          = .this_cDsGrupo
2404:             THIS.txt_4c_CSGru.Value         = .this_cSubGrupo
2405:             THIS.txt_4c_DSGru.Value         = .this_cDsSubGrupo
2406:             THIS.txt_4c__gde_grupo.Value    = .this_cGrandeGrupo
2407:             THIS.txt_4c_Lin.Value           = .this_cLinha
2408:             THIS.txt_4c_Local.Value         = .this_cLocal
2409:             THIS.txt_4c_Localizas.Value     = .this_cLocalizacao
2410:             THIS.txt_4c_Col.Value           = .this_cColecao
2411:             THIS.txt_4c_DCol.Value          = .this_cDsColecao
2412:             THIS.txt_4c__promos.Value       = .this_cPromocao
2413: 
2414:             THIS.obj_4c_Get_Ordem.Value  = IIF(.this_nOrdem >= 1, .this_nOrdem, 1)
2415:             THIS.obj_4c_Opt_Marcas.Value = IIF(.this_nMarca >= 1, .this_nMarca, 1)
2416:             THIS.obj_4c_Chk_Preco.Value  = IIF(.this_nPreco >= 1, .this_nPreco, 2)
2417:         ENDWITH
2418:     ENDPROC

*-- Linhas 2439 a 2501:
2439:     *     aqui qualquer erro de runtime DA OUTRA TELA e o reportaria com o
2440:     *     nome do metodo errado.
2441:     *==========================================================================
2442:     PROTECTED PROCEDURE DespacharImpressao(par_cTipo)
2443:         LOCAL loc_oErro, loc_lDisponivel
2444: 
2445:         *-- Equivalente a ThisForm.Tipo do legado
2446:         THIS.this_cTipo = par_cTipo
2447: 
2448:         loc_lDisponivel = FILE("SigOpIpE.scx")
2449:         IF !loc_lDisponivel AND TYPE("gc_4c_CaminhoForms") = "C"
2450:             loc_lDisponivel = FILE(gc_4c_CaminhoForms + "SigOpIpE.scx")
2451:         ENDIF
2452: 
2453:         IF !loc_lDisponivel
2454:             MsgAviso("A tela de etiquetas (SigOpIpE) ainda n" + CHR(227) + "o foi migrada." + ;
2455:                      CHR(13) + "Os filtros desta tela foram montados e o modo '" + ;
2456:                      ALLTRIM(par_cTipo) + "' foi definido, mas a " + ;
2457:                      "impress" + CHR(227) + "o n" + CHR(227) + "o pode prosseguir.", ;
2458:                      "Impress" + CHR(227) + "o de Etiquetas")
2459:         ELSE
2460:             TRY
2461:                 DO FORM SigOpIpE WITH THIS
2462:             CATCH TO loc_oErro
2463:                 MsgErro(loc_oErro.Message + CHR(13) + ;
2464:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2465:                         "Procedure: " + loc_oErro.Procedure, ;
2466:                         "Erro em SigOpIpE (modo " + ALLTRIM(par_cTipo) + ")")
2467:             ENDTRY
2468:         ENDIF
2469:     ENDPROC
2470: 
2471:     *==========================================================================
2472:     * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
2473:     * FILTRO: nenhum container flutuante neste form
2474:     *==========================================================================
2475:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2476:         LOCAL loc_i, loc_oControl
2477: 
2478:         FOR loc_i = 1 TO par_oContainer.ControlCount
2479:             loc_oControl = par_oContainer.Controls(loc_i)
2480:             IF VARTYPE(loc_oControl) = "O"
2481:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2482:                     loc_oControl.Visible = .T.
2483:                 ENDIF
2484:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2485:                     THIS.TornarControlesVisiveis(loc_oControl)
2486:                 ENDIF
2487:             ENDIF
2488:         ENDFOR
2489:     ENDPROC
2490: 
2491:     *==========================================================================
2492:     * Destroy - libera o Business Object e delega ao FormBase
2493:     *==========================================================================
2494:     PROCEDURE Destroy()
2495:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2496:             THIS.this_oBusinessObject = .NULL.
2497:         ENDIF
2498:         DODEFAULT()
2499:     ENDPROC
2500: 
2501: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrRetBO.prg):
*============================================================================
* SigPrRetBO.prg - Business Object para Impressao de Etiquetas (Estoque)
*
* Tela OPERACIONAL (sem CRUD) que monta filtros para impressao de etiquetas
* de produto em lote. Nao existe uma unica tabela "mestre" editada pela
* tela: os filtros cruzam Produto (SigCdPro), Grupo (SigCdGrp/SigCdGpr),
* SubGrupo (SigCdPsg), Grupo Estoque, Operacao, Industria, Empresa
* (SigCdEmp), Local (SigPrLcl), Linha (SigCdLin), Colecao (SigCdCol),
* Promocao (SigPrPmc) e a faixa de etiquetas gravadas em SigOpEtq.
*
* Tabela de referencia (par par_cTabela/par_cCampoChave da BusinessBase):
*   SigCdPro (PK: CPros) - produto filtrado para impressao
*
* Form somente-leitura/filtro: nao grava registro nenhum. Os botoes do
* legado (Consulta/Digitacao/Arquivadas) apenas coletam os filtros acima e
* abrem outro formulario (Do Form SigOpIpE With ThisForm) que realiza a
* impressao propriamente dita - fora do escopo desta migracao (SigPrRet).
*
* Conferido no dump legado (tasks\task670\SigPrRet_form_codigo_fonte.txt):
* ZERO ocorrencias de TABLEUPDATE(), de .AddCursor( e de Insert Into /
* Update / Delete From sobre qualquer tabela - o unico alvo de escrita eh o
* cursor LOCAL csEtiqDig, criado pelo proprio Load. Por isso este BO NAO
* sobrescreve Inserir() / Atualizar() / ExecutarExclusao() / Salvar() /
* Excluir() / RegistrarAuditoria(): o comportamento padrao herdado de
* BusinessBase (recusar a operacao e reportar a recusa pelo ExibirFalha)
* ja eh o correto para esta tela. Sobrescrever esses metodos aqui seria
* fabricar gravacao que o legado nunca executa e violar o PILAR 2.
*
* Os metodos de LEITURA abaixo (CarregarPorCodigo / CarregarDoCursor /
* CarregarOperacoes / CarregarParametros) transcrevem as consultas que o
* legado faz no Init e nos Valid dos campos.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de carga (CRUD aplicavel a esta tela)
*============================================================================

DEFINE CLASS SigPrRetBO AS BusinessBase

    *==========================================================================
    * Produto (SigCdPro) - filtro de codigo/descricao do produto
    *==========================================================================
    this_cCodigo     = ""   && char(14) - SigCdPro.cpros (PK sigcdpro_cpros)
    this_cDescricao  = ""   && char(65) - SigCdPro.dpros

    *==========================================================================
    * Periodo (data base de inclusao/alteracao do produto)
    *==========================================================================
    this_dDataIni = {}      && Data inicial do periodo
    this_dDataFim = {}      && Data final do periodo

    *==========================================================================
    * Faixa de etiquetas (SigOpEtq / codigo de barras)
    *==========================================================================
    this_nEtiquetaIni = 0   && Etiqueta inicial (faixa numerica de codigo de barras)
    this_nEtiquetaFim = 0   && Etiqueta final (faixa numerica de codigo de barras)
    this_nQtdEtiqueta = 0   && Quantidade de etiquetas a imprimir (alternativa a faixa)
    this_nEtiquetaResolvida = 0   && Saida de ValidarFaixaEtiqueta() - codigo de barras RESOLVIDO

    *==========================================================================
    * Grupo Estoque (filtro + descricao)
    *==========================================================================
    this_cGrEstoque   = ""  && Codigo do Grupo de Estoque
    this_cDsGrEstoque = ""  && Descricao do Grupo de Estoque (exibicao)

    *==========================================================================
    * Estoque (filtro + descricao)
    *==========================================================================
    this_cEstoque   = ""    && Codigo do Estoque
    this_cDsEstoque = ""    && Descricao do Estoque (exibicao)

    *==========================================================================
    * Operacao / Industria (SigCdOpd)
    *==========================================================================
    this_cOperacao  = ""    && Operacao (SigCdOpd.dopps)
    this_cIndustria = ""    && Industria (SigCdOpd.dopps - filtro paralelo)
    this_nNumero    = 0     && Numero vinculado a Operacao
    this_nNumerof   = 0     && Numero vinculado a Industria

    *==========================================================================
    * Empresa (SigCdEmp)
    *==========================================================================
    this_cEmpresa   = ""    && Codigo da Empresa (SigCdEmp.Cemps)
    this_cDsEmpresa = ""    && Razao Social da Empresa (SigCdEmp.Razas, exibicao)

    *==========================================================================
    * Grupo Produto (SigCdGrp) + SubGrupo (SigCdPsg)
    *==========================================================================
    this_cGrupo      = ""   && Codigo do Grupo Produto (SigCdGrp.CGrus)
    this_cDsGrupo    = ""   && Descricao do Grupo Produto (SigCdGrp.DGrus, exibicao)
    this_cSubGrupo   = ""   && Codigo do SubGrupo (SigCdPsg.Codigos)
    this_cDsSubGrupo = ""   && Descricao do SubGrupo (SigCdPsg.Descricaos, exibicao)

    *==========================================================================
    * Grande Grupo (SigCdGpr)
    *==========================================================================
    this_cGrandeGrupo = ""  && Codigo do Grande Grupo (SigCdGpr.Codigos)

    *==========================================================================
    * Linha (SigCdLin) e Local (SigPrLcl)
    *==========================================================================
    this_cLinha = ""        && Codigo da Linha (SigCdLin.linhas)
    this_cLocal = ""        && Codigo do Local do Produto (SigPrLcl.Codigos)

    *==========================================================================
    * Colecao (SigCdCol)
    *==========================================================================
    this_cColecao   = ""    && Codigo da Colecao (SigCdCol.Colecoes)
    this_cDsColecao = ""    && Descricao da Colecao (SigCdCol.Descs, exibicao)

    *==========================================================================
    * Promocao (SigPrPmc) e Localizacao da Etiqueta (SigPrLcl)
    *==========================================================================
    this_cPromocao    = ""  && Codigo da Promocao (SigPrPmc.promos)
    this_cLocalizacao = ""  && Codigo do Local da Etiqueta (SigPrLcl.Codigos)

    *==========================================================================
    * Opcoes de impressao (OptionGroups do legado)
    *==========================================================================
    this_nOrdem = 1         && Get_Ordem - ordem de impressao (1..5 conforme legado)
    this_nMarca = 1         && Opt_Marcas - 1=Todas as marcas, 2=Marca especifica
    this_nPreco = 2         && Chk_Preco - opcao de preco impresso na etiqueta (1..4) - SCX default = 2

    *==========================================================================
    * Parametros do sistema (SigCdPac)
    *==========================================================================
    * numeric(1,0): a propriedade eh NUMERICA de proposito. Achatar a coluna
    * em logico perderia o valor real gravado pelo legado.
    this_nFixaEmpresa = 0   && SigCdPac.fixaemp - 1 trava o campo Empresa em go_4c_Sistema.cCodEmpresa

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPro"
            THIS.this_cCampoChave = "CPros"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Le o produto (SigCdPro) pelo codigo digitado no
    * campo "Codigo :" (Get_cod) e preenche this_cCodigo / this_cDescricao.
    *
    * Equivalente ao trecho do legado que, achando o produto, devolve o par
    * codigo/descricao para a tela (Get_cod.Valid / Get_dcod.Valid):
    *   This.Value                 = crListaRemota.CPros
    *   This.Parent.get_dcod.Value = crListaRemota.DPros
    *
    * par_cCodigo - conteudo do campo Codigo (SigCdPro.cpros - char(14))
    *
    * Retorna .T. quando o produto existe. Devolve .F. SEM exibir dialogo
    * quando nao existe, para o Form abrir o picker de produtos: o legado
    * nunca avisa "produto nao encontrado", ele abre o browse do fwBuscaExt.
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cCodigo

        loc_lSucesso = .F.
        loc_cCodigo  = ALLTRIM(NVL(par_cCodigo, ""))

        TRY
            IF !EMPTY(loc_cCodigo)
                loc_cSQL = "SELECT cpros, dpros FROM SigCdPro " + ;
                           " WHERE cpros = " + EscaparSQL(loc_cCodigo)

                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

                IF loc_nResult < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Erro ao consultar o produto:" + CHR(13) + ;
                            THIS.this_cMensagemErro, "Erro SQL")
                ELSE
                    IF USED("cursor_4c_Produto") AND RECCOUNT("cursor_4c_Produto") > 0
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Produto")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Transfere o registro CORRENTE de um cursor com a
    * forma de SigCdPro para as propriedades do BO.
    *
    * Usado em dois caminhos, ambos vindos do legado:
    *   (a) CarregarPorCodigo() acima (consulta exata por cpros);
    *   (b) o cursor devolvido pelo picker de produtos de Get_cod.Valid /
    *       Get_dcod.Valid (fwBuscaExt sobre SigCdPro -> crListaRemota).
    *
    * Mapeia as DUAS colunas que esta tela usa de SigCdPro - exatamente as
    * que o legado transfere para os TextBoxes (CPros e DPros). As demais
    * propriedades do BO sao filtros de OUTRAS tabelas (SigCdGrp, SigCdPsg,
    * SigCdGpr, SigCdCol, SigCdLin, SigPrLcl, SigPrPmc, SigCdEmp) e cada uma
    * eh preenchida pelo lookup da sua propria tabela.
    *
    * par_cAliasCursor - alias do cursor posicionado no registro desejado
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias

        loc_lSucesso = .F.
        loc_cAlias   = ALLTRIM(NVL(par_cAliasCursor, ""))

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF()
                    * TYPE() e nao PEMSTATUS(): PEMSTATUS exige OBJETO no 1o
                    * argumento e dispara o erro 11 do VFP9 com alias de cursor.
                    IF TYPE(loc_cAlias + ".cpros") == "C"
                        THIS.this_cCodigo = ALLTRIM(TratarNulo(cpros, ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".dpros") == "C"
                        THIS.this_cDescricao = ALLTRIM(TratarNulo(dpros, ""))
                    ENDIF

                    loc_lSucesso = !EMPTY(THIS.this_cCodigo)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarOperacoes - Popula o cursor consultado pelos campos
    * "Operacao :" (get_nm_operacao) e "Industria :" (get_nm_industria).
    *
    * Transcreve o bloco do Init do legado:
    *   m.lcMcrSql1 = [select a.* from SigCdOpd a ]
    *   m.lnErro1   = .poDatamgr.Sqlexecute(m.lcMcrSql1,'SigCdOpd')
    *   If Used('SigCdOpd') / Select('SigCdOpd') / Index On dopps Tag dopps
    *
    * Duas diferencas tecnicas em relacao ao legado, sem mudar comportamento:
    *   - o cursor eh recriado com READWRITE, porque cursor de SQLEXEC nasce
    *     somente-leitura e o INDEX ON precisa de cursor gravavel;
    *   - sao lidas as duas colunas que a tela usa de SigCdOpd (dopps no SEEK
    *     do Valid e ndopps na coluna de codigo do browse); o "a.*" do legado
    *     traria as colunas text (obscab/obsresu) sem nenhum uso aqui.
    *
    * Retorna .T. quando o cursor ficou disponivel e indexado por dopps.
    *==========================================================================
    FUNCTION CarregarOperacoes()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT dopps, ndopps FROM SigCdOpd"

            IF USED("cursor_4c_OperacoesTmp")
                USE IN cursor_4c_OperacoesTmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTmp")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar as Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_Operacoes")
                    USE IN cursor_4c_Operacoes
                ENDIF

                SELECT * FROM cursor_4c_OperacoesTmp ;
                    INTO CURSOR cursor_4c_Operacoes READWRITE

                INDEX ON dopps TAG dopps
                SET ORDER TO TAG dopps
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_OperacoesTmp")
                USE IN cursor_4c_OperacoesTmp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarParametros - Le o parametro "fixa empresa" (SigCdPac.fixaemp)
    * e guarda em THIS.this_nFixaEmpresa.
    *
    * Transcreve o bloco do Init do legado (mena - 02/04/2017):
    *   m.lcMcrSql1 = [select a.* from SigCdPac a ]
    *   m.lnErro1   = .poDatamgr.Sqlexecute(m.lcMcrSql1,'crSigCdpac')
    *   IF crSigCdpac.fixaemp = 1   && trava o campo Empresa em _EMPR
    *
    * O legado le a PRIMEIRA linha de SigCdPac (tabela de parametros), por
    * isso o GO TOP sem filtro. O VARTYPE eh testado porque coluna de um
    * digito pode chegar do driver ODBC como Logico em vez de Numerico.
    *
    * Retorna .T. quando o parametro foi lido.
    *==========================================================================
    FUNCTION CarregarParametros()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT fixaemp FROM SigCdPac"

            IF USED("cursor_4c_Parametros")
                USE IN cursor_4c_Parametros
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Parametros")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar os par" + CHR(226) + "metros do sistema:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_Parametros") AND RECCOUNT("cursor_4c_Parametros") > 0
                    SELECT cursor_4c_Parametros
                    GO TOP

                    IF VARTYPE(cursor_4c_Parametros.fixaemp) = "N"
                        THIS.this_nFixaEmpresa = NVL(cursor_4c_Parametros.fixaemp, 0)
                    ELSE
                        THIS.this_nFixaEmpresa = IIF(NVL(cursor_4c_Parametros.fixaemp, .F.), 1, 0)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Parametros")
                USE IN cursor_4c_Parametros
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.CarregarParametros")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarFaixaEtiqueta - Resolve o codigo de barras digitado (aceita tanto
    * o codigo ANTIGO quanto o NOVO, via o mapeamento de sigopeta) e confere
    * se a etiqueta existe em SigOpEtq.
    *
    * Equivalente ao bloco do legado (Get_Etii.Valid / Get_Etif.Valid):
    *   lStrQuery = Select a.CPros, a.CBars From SigOpEtq a
    *               Left Join sigopeta b On a.cpros = b.cpros And a.cbars = b.cbars_new
    *               Where (a.CBars = <cod> Or b.cbars_old = <cod>)
    *   ThisForm.poDataMgr.CursorQuery('SigOpEtq', 'TmpEti', 'CBars', <resolvido>)
    *   If Eof('TmpEti') ... MsgAviso('Etiqueta Nao Cadastrada!!!') ...
    *
    * par_nCodigoDigitado - codigo de barras digitado pelo usuario (numerico,
    *   ate 14 digitos, igual ao InputMask do legado)
    *
    * Retorna .T. se a etiqueta existe. THIS.this_nEtiquetaResolvida recebe o
    * codigo de barras RESOLVIDO (identico ao digitado quando nao ha
    * mapeamento antigo->novo em sigopeta) para o Form atualizar o TextBox.
    *==========================================================================
    FUNCTION ValidarFaixaEtiqueta(par_nCodigoDigitado)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cBarcode

        loc_lSucesso = .F.
        THIS.this_nEtiquetaResolvida = NVL(par_nCodigoDigitado, 0)

        TRY
            loc_cBarcode = ALLTRIM(STR(NVL(par_nCodigoDigitado, 0), 14))

            loc_cSQL = "SELECT a.cpros, a.cbars FROM SigOpEtq a " + ;
                       "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                       "WHERE (a.cbars = " + loc_cBarcode + " OR b.cbars_old = " + loc_cBarcode + ")"

            IF USED("cursor_4c_Etiquetas")
                USE IN cursor_4c_Etiquetas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiquetas")

            IF loc_nResult >= 0 AND USED("cursor_4c_Etiquetas") AND RECCOUNT("cursor_4c_Etiquetas") > 0
                SELECT cursor_4c_Etiquetas
                GO TOP
                THIS.this_nEtiquetaResolvida = cursor_4c_Etiquetas.cbars
                loc_lSucesso = .T.
            ELSE
                MsgAviso("Etiqueta N" + CHR(227) + "o Cadastrada!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF USED("cursor_4c_Etiquetas")
                USE IN cursor_4c_Etiquetas
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.ValidarFaixaEtiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * LimparDados - Devolve TODOS os filtros ao estado inicial da tela.
    *
    * Transcreve o bloco de valores iniciais do Init do legado (SIGPRRET.Init,
    * dentro do "If (.poDataMgr.pnIdconn > 0)"):
    *   .get_cod.Value   = Space(10)   .get_dcod.Value  = Space(40)
    *   .get_datai.Value = {}          .get_dataf.Value = {}
    *   .get_etii.Value  = 0           .get_etif.Value  = 0
    *   .get_qtdEti.Value       = 0
    *   .get_cd_estoque.Value   = Space(10)
    *   .get_cd_grestoque.Value = Space(10)
    *   .get_ds_estoque.Value   = Space(20)
    *   .get_ds_grestoque.Value = Space(40)
    *   .get_gde_grupo.Value    = Space(3)
    *
    * Os demais filtros (Operacao/Industria, Numero, Empresa, Grupo/SubGrupo,
    * Linha, Local, Colecao, Promocao, Localizacao) NAO aparecem naquele bloco
    * porque o legado eh MODAL e vive uma unica sessao - eles nascem com o
    * default de design do SCX e nunca sao reaproveitados. O form migrado NAO
    * fecha entre uma consulta e outra, entao o reset tem de ser COMPLETO
    * (mesma armadilha da regra #32: ciclo de vida diferente exige reset
    * explicito) - por isso a segunda metade do metodo, que repoe exatamente
    * o default de design de cada controle do SCX.
    *
    * this_nFixaEmpresa fica de FORA de proposito: eh parametro de sistema
    * (SigCdPac.fixaemp), nao filtro da tela - zera-lo aqui destravaria o
    * campo Empresa que o legado trava.
    *==========================================================================
    PROCEDURE LimparDados()
        *-- Bloco de valores iniciais do Init do legado
        THIS.this_cCodigo        = ""
        THIS.this_cDescricao     = ""
        THIS.this_dDataIni       = {}
        THIS.this_dDataFim       = {}
        THIS.this_nEtiquetaIni   = 0
        THIS.this_nEtiquetaFim   = 0
        THIS.this_nQtdEtiqueta   = 0
        THIS.this_cEstoque       = ""
        THIS.this_cGrEstoque     = ""
        THIS.this_cDsEstoque     = ""
        THIS.this_cDsGrEstoque   = ""
        THIS.this_cGrandeGrupo   = ""

        *-- Default de design do SCX para o resto dos filtros
        THIS.this_cOperacao      = ""
        THIS.this_cIndustria     = ""
        THIS.this_nNumero        = 0
        THIS.this_nNumerof       = 0
        THIS.this_cEmpresa       = ""
        THIS.this_cDsEmpresa     = ""
        THIS.this_cGrupo         = ""
        THIS.this_cDsGrupo       = ""
        THIS.this_cSubGrupo      = ""
        THIS.this_cDsSubGrupo    = ""
        THIS.this_cLinha         = ""
        THIS.this_cLocal         = ""
        THIS.this_cColecao       = ""
        THIS.this_cDsColecao     = ""
        THIS.this_cPromocao      = ""
        THIS.this_cLocalizacao   = ""

        *-- OptionGroups: Value de design do SCX (Get_Ordem=1, Opt_Marcas=1,
        *-- Chk_Preco=2). Sao INDICES 1-based, nunca 0 (regra #45).
        THIS.this_nOrdem         = 1
        THIS.this_nMarca         = 1
        THIS.this_nPreco         = 2

        *-- Saida de ValidarFaixaEtiqueta, nao eh filtro digitado
        THIS.this_nEtiquetaResolvida = 0

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarEmpresa - Resolve a Razao Social de UMA empresa pelo codigo,
    * SEM abrir dialogo de selecao.
    *
    * Necessario para a regra "fixa empresa" do Init do legado, que resolve a
    * descricao de um codigo JA conhecido:
    *   IF crSigCdpac.fixaemp = 1
    *       ThisForm.get_Cd_Empresa.value   = _empr
    *       ThisForm.get_Cd_Empresa.enabled = .F.
    *       fAcessoEmpresa(Usuar, 'C', _empr, ThisForm.get_Cd_Empresa, ThisForm.get_Ds_Empresa)
    *   ENDIF
    *
    * fAcessoEmpresa NAO foi portada (regra "fAcessoEmpresa() NAO EXISTE"); a
    * substituicao canonica para o modo LOOKUP eh o bloco FormBuscaAuxiliar
    * sobre SigCdEmp, mas ele SEMPRE mostra o picker - inadequado no Init, onde
    * o codigo eh exato e nao ha nada a escolher. Dai esta consulta direta.
    *
    * Colunas: SigCdEmp.Cemps (char(3), PK) e SigCdEmp.Razas (char(40)) - os
    * nomes canonicos da tabela (Emps/NComps NAO existem nela).
    *
    * Retorna .T. quando a empresa existe; this_cEmpresa/this_cDsEmpresa
    * recebem codigo e razao social.
    *==========================================================================
    FUNCTION CarregarEmpresa(par_cCodigo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cCodigo

        loc_lSucesso = .F.
        loc_cCodigo  = ALLTRIM(IIF(VARTYPE(par_cCodigo) = "C", par_cCodigo, ""))

        IF EMPTY(loc_cCodigo)
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                       " WHERE RTRIM(Cemps) = " + EscaparSQL(loc_cCodigo)

            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao carregar a Empresa:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_Empresa") AND RECCOUNT("cursor_4c_Empresa") > 0
                    SELECT cursor_4c_Empresa
                    GO TOP
                    THIS.this_cEmpresa   = ALLTRIM(TratarNulo(cursor_4c_Empresa.Cemps, ""))
                    THIS.this_cDsEmpresa = ALLTRIM(TratarNulo(cursor_4c_Empresa.Razas, ""))
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigPrRetBO.CarregarEmpresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro de referencia desta tela.
    *
    * SigCdPro tem PRIMARY KEY CLUSTERED em cpros (char(14)), que eh a propria
    * propriedade THIS.this_cCodigo carregada por CarregarDoCursor().
    *
    * Continua PROTECTED como na BusinessBase: metodo protegido na classe base
    * permanece protegido na subclasse, e chama-lo de fora do BO dispararia
    * "Property OBTERCHAVEPRIMARIA is not found" em runtime.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCodigo, ""))
    ENDFUNC

ENDDEFINE

