# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_CONTATO, CNT_4C_AGENDA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Draw()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Branco' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ThisForm.GridFollowUp define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ThisForm.GridFollowUp.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpFlp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2150 linhas total):

*-- Linhas 6 a 49:
6: * de cadastro: todos os containers ficam diretamente no Form, alternados por
7: * Visible conforme o fluxo do legado (SIGOPFLP).
8: *
9: * FASE 3/8: Estrutura base (classe, Init, InicializarForm, containers vazios,
10: * Destroy).
11: * FASE 4/8: Grade de FollowUp (grd_4c_Dados), grupos de botoes de acao
12: * (cmg_4c_Botoes com Incluir/Alterar/Excluir/Imprimir e cmg_4c_Encerrar) e a
13: * carga de dados que os alimenta (CarregarLista + VincularGrade).
14: * FASE 5/8: Campos (TextBoxes/Labels) dos containers de EXIBICAO - metade dos
15: * campos do form: cnt_4c_Agenda (Usuario/Agendamento da linha selecionada),
16: * cnt_4c_GruCon (Grupo/Conta/Razao Social, somente leitura), cnt_4c_Obs
17: * (Observacao da linha selecionada) e cnt_4c_Contato (Telefones/E-mail,
18: * container oculto por fChecaAcesso). Todos SOMENTE EXIBICAO nesta fase - a
19: * atualizacao de valor por linha de grade (AfterRowColChange) e a visibilidade
20: * condicional de cnt_4c_Contato ficam para a fase de eventos (Fases 7-8).
21: * Campos do painel de inclusao/alteracao (cnt_4c__Inserir) ficam para a
22: * Fase 6/8; eventos de Click/KeyPress dos botoes, para as Fases 7-8.
23: * FASE 7/8: Eventos dos botoes de acao sobre o historico selecionado na grade
24: * (cmg_4c_Botoes - cmdApagaitem do legado): BtnIncluirClick (cmdInserir),
25: * BtnAlterarClick (cmdAlterar), BtnExcluirClick (cmdApagar) e
26: * BtnImprimirClick (cmdListar), mais o funil de estado da tela
27: * (AjustarBotoesPorModo) e o bloco de permissoes do Init legado
28: * (AplicarAcessos / AjustarAcoesPorAcesso). O verbo Visualizar da barra CRUD
29: * do framework de cadastro NAO existe neste legado - a barra daqui eh de
30: * LINHA de grade (Incluir/Alterar/Apagar/Listar sobre a linha corrente), e
31: * inventar um botao a mais violaria o PILAR 1.
32: * Nesta fase tambem entraram os dois controles de Agendamento do painel
33: * (txt_4c_Agenda / lbl_4c_LblAgenda, legado Cnt_Inserir.GetAgenda e
34: * lblAgenda): a Fase 6 os perdeu e os Click de Incluir/Alterar que esta fase
35: * transcreve atribuem valor a eles.
36: * FASE 8/8 (FINAL): Confirmar (BtnSalvarClick, cobre INSERIR e ALTERAR via
37: * FormParaBO + NovoRegistro/EditarRegistro + BusinessBase.Salvar) e Cancelar
38: * (BtnCancelarClick) do painel, Encerrar (BtnEncerrarClick ->
39: * SigOpFlpBO.SalvarContato, grava Tel1s/Tel2s/DDDs/EMails em SigCdCli e fecha
40: * o form), BOParaForm (espelha Grupo/Conta/Razao Social em
41: * cnt_4c_GruCon e Telefones/E-mail em cnt_4c_Contato, chamado por
42: * CarregarLista), GridAfterRowColChange (cnt_4c_Obs/cnt_4c_Agenda seguem a
43: * linha corrente da grade) e GridColumnKeyPress (atalhos F2/F3/F4/F6 das
44: * celulas Column1/Column2.Text1, religados em TODA chamada de VincularGrade
45: * porque ColumnCount os recria). SigOpFlpBO ganhou LimparDados (reseta o
46: * historico ao NovoRegistro, evita vazar o registro do Alterar anterior para
47: * o proximo Incluir - regra #32) e SalvarContato.
48: * Validado em runtime contra o SQL Server real (192.168.200.10) em
49: * 2026-11-04: INSERT/UPDATE de SigCdClh e UPDATE idempotente de SigCdCli

*-- Linhas 90 a 212:
90:     Themes       = .F.
91: 
92:     *--------------------------------------------------------------------------
93:     * Init - DODEFAULT() chama FormBase.Init() -> THIS.InicializarForm()
94:     * Os parametros do legado (LParameters pConta, pData, pNoper) precisam
95:     * estar guardados ANTES de DODEFAULT(), pois InicializarForm() roda dentro
96:     * dele e as fases seguintes (carga de dados) dependem de this_cConta/this_nNoper.
97:     *--------------------------------------------------------------------------
98:     PROCEDURE Init(par_cConta, par_dData, par_nNoper)
99:         THIS.this_cConta = IIF(VARTYPE(par_cConta) = "C", par_cConta, SPACE(10))
100:         THIS.this_dData  = IIF(VARTYPE(par_dData) = "D" OR VARTYPE(par_dData) = "T", par_dData, {})
101:         THIS.this_nNoper = IIF(VARTYPE(par_nNoper) = "N", par_nNoper, 0)
102: 
103:         RETURN DODEFAULT()
104:     ENDPROC
105: 
106:     *--------------------------------------------------------------------------
107:     * InicializarForm - Hook chamado por FormBase.Init(). Cria o Business
108:     * Object e a estrutura visual basica do form.
109:     *--------------------------------------------------------------------------
110:     PROTECTED PROCEDURE InicializarForm()
111:         LOCAL loc_lSucesso, loc_oErro
112:         loc_lSucesso = .F.
113: 
114:         TRY
115:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpFlpBO")
116: 
117:             THIS.ConfigurarEstruturaBase()
118: 
119:             *-- Permissoes do Init legado (fChecaAcesso) - DEPOIS da estrutura,
120:             *-- porque TornarControlesVisiveis forca Visible = .T. em tudo o
121:             *-- que nao esta na lista de excecao e o estado por permissao tem
122:             *-- de ser a ultima palavra.
123:             THIS.AplicarAcessos()
124: 
125:             *-- Carga de dados: pulada quando o pipeline esta validando a UI ou
126:             *-- rodando o teste automatizado (sem conexao SQL disponivel).
127:             *-- Falha na carga NAO impede a tela de abrir - igual ao legado, que
128:             *-- so faz "Return" do Init quando a conta vem vazia.
129:             IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
130:                  (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
131:                 THIS.CarregarLista()
132:             ENDIF
133: 
134:             loc_lSucesso = .T.
135:         CATCH TO loc_oErro
136:             THIS.this_cMensagemErro = loc_oErro.Message
137:             MsgErro(loc_oErro.Message + CHR(13) + ;
138:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
139:                 "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpFlp")
140:             loc_lSucesso = .F.
141:         ENDTRY
142: 
143:         RETURN loc_lSucesso
144:     ENDPROC
145: 
146:     *--------------------------------------------------------------------------
147:     * ConfigurarEstruturaBase - Cria a faixa do cabecalho e os containers
148:     * flutuantes vazios (sem campos internos ainda - Fases 5-6).
149:     *--------------------------------------------------------------------------
150:     PROTECTED PROCEDURE ConfigurarEstruturaBase()
151:         THIS.ConfigurarCabecalho()
152:         THIS.ConfigurarContainerInserir()
153:         THIS.ConfigurarBotoesAcao()
154:         THIS.ConfigurarContainerContato()
155:         THIS.ConfigurarContainerAgenda()
156:         THIS.ConfigurarContainerGruCon()
157:         THIS.ConfigurarContainerObs()
158:         THIS.ConfigurarGrid()
159: 
160:         THIS.TornarControlesVisiveis(THIS)
161:     ENDPROC
162: 
163:     *--------------------------------------------------------------------------
164:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra no legado)
165:     *--------------------------------------------------------------------------
166:     PROTECTED PROCEDURE ConfigurarCabecalho()
167:         THIS.AddObject("cnt_4c_Sombra", "Container")
168:         WITH THIS.cnt_4c_Sombra
169:             .Top         = 0
170:             .Left        = 0
171:             .Width       = THIS.Width
172:             .Height      = 80
173:             .BorderWidth = 0
174:             .BackStyle   = 1
175:             .BackColor   = RGB(100, 100, 100)
176:             .Visible     = .T.
177:         ENDWITH
178: 
179:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
180:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
181:             .FontBold   = .T.
182:             .FontName   = "Tahoma"
183:             .FontSize   = 18
184:             .WordWrap   = .T.
185:             .Alignment  = 0
186:             .BackStyle  = 0
187:             .AutoSize   = .F.
188:             .Top        = 18
189:             .Left       = 10
190:             .Width      = 769
191:             .Height     = 40
192:             .ForeColor  = RGB(0, 0, 0)
193:             .Caption    = THIS.Caption
194:         ENDWITH
195: 
196:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
197:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
198:             .FontBold   = .T.
199:             .FontName   = "Tahoma"
200:             .FontSize   = 18
201:             .WordWrap   = .T.
202:             .Alignment  = 0
203:             .BackStyle  = 0
204:             .AutoSize   = .F.
205:             .Top        = 17
206:             .Left       = 10
207:             .Width      = 769
208:             .Height     = 46
209:             .ForeColor  = RGB(255, 255, 255)
210:             .Caption    = THIS.Caption
211:         ENDWITH
212:     ENDPROC

*-- Linhas 221 a 264:
221:     * cancelar o painel) fica para a Fase 7-8 - o botao de Historico (unico
222:     * lookup do form) e implementado aqui.
223:     *--------------------------------------------------------------------------
224:     PROTECTED PROCEDURE ConfigurarContainerInserir()
225:         THIS.AddObject("cnt_4c__Inserir", "Container")
226:         WITH THIS.cnt_4c__Inserir
227:             .Top         = 226
228:             .Left        = 8
229:             .Width       = 984
230:             .Height      = 371
231:             .BackStyle = 1
232:             .BackColor   = RGB(255, 255, 255)
233:             .BorderColor = RGB(90, 90, 90)
234:             .Visible     = .F.
235:         ENDWITH
236: 
237:         *-- Data/Hora (GetData) - preenchido por codigo (DateTime() no Incluir,
238:         *-- CrSigCdClh.Datas no Alterar), nunca digitado em modo livre -
239:         *-- legado: When = (GetUsuario.Value = Usuar Or plAcesso)
240:         THIS.cnt_4c__Inserir.AddObject("txt_4c_Data", "TextBox")
241:         WITH THIS.cnt_4c__Inserir.txt_4c_Data
242:             .Top           = 5
243:             .Left          = 106
244:             .Width         = 150
245:             .Height        = 23
246:             .MaxLength     = 20
247:             .Format        = "K!"
248:             .FontName      = "Tahoma"
249:             .FontSize      = 8
250:             .SpecialEffect = 1
251:             .ForeColor     = RGB(0, 0, 0)
252:             .BorderColor   = RGB(100, 100, 100)
253:             .Value         = {}
254:             .Visible       = .T.
255:         ENDWITH
256: 
257:         THIS.cnt_4c__Inserir.AddObject("lbl_4c_LblData", "Label")
258:         WITH THIS.cnt_4c__Inserir.lbl_4c_LblData
259:             .Caption   = "Data/Hora :"
260:             .Top       = 9
261:             .Left      = 45
262:             .Width     = 58
263:             .Height    = 15
264:             .FontName  = "Tahoma"

*-- Linhas 428 a 617:
428:             .Themes    = .F.
429:             .Visible   = .T.
430:         ENDWITH
431:         BINDEVENT(THIS.cnt_4c__Inserir.cmd_4c_CmdHist, "Click", THIS, "AbrirLookupHistorico")
432: 
433:         *-- Botao Confirmar (BtnOk) - grava o painel (Case INSERIR/ALTERAR do
434:         *-- legado) via BtnSalvarClick
435:         THIS.cnt_4c__Inserir.AddObject("cmd_4c_BtnOk", "CommandButton")
436:         WITH THIS.cnt_4c__Inserir.cmd_4c_BtnOk
437:             .Top       = 265
438:             .Left      = 202
439:             .Width     = 80
440:             .Height    = 100
441:             .FontName  = "Verdana"
442:             .FontSize  = 8
443:             .Picture   = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
444:             .Cancel    = .T.
445:             .Caption   = "Confirmar"
446:             .ForeColor = RGB(36, 84, 155)
447:             .BackColor = RGB(255, 255, 255)
448:             .Themes    = .F.
449:             .Visible   = .T.
450:         ENDWITH
451:         BINDEVENT(THIS.cnt_4c__Inserir.cmd_4c_BtnOk, "Click", THIS, "BtnSalvarClick")
452: 
453:         *-- Botao Cancelar (BtnCancela) - fecha o painel sem gravar via
454:         *-- BtnCancelarClick
455:         THIS.cnt_4c__Inserir.AddObject("cmd_4c_BtnCancela", "CommandButton")
456:         WITH THIS.cnt_4c__Inserir.cmd_4c_BtnCancela
457:             .Top       = 265
458:             .Left      = 283
459:             .Width     = 80
460:             .Height    = 100
461:             .FontName  = "Verdana"
462:             .FontSize  = 8
463:             .Picture   = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
464:             .Cancel    = .T.
465:             .Caption   = "Cancelar"
466:             .ForeColor = RGB(36, 84, 155)
467:             .BackColor = RGB(255, 255, 255)
468:             .Themes    = .F.
469:             .Visible   = .T.
470:         ENDWITH
471:         BINDEVENT(THIS.cnt_4c__Inserir.cmd_4c_BtnCancela, "Click", THIS, "BtnCancelarClick")
472:     ENDPROC
473: 
474:     *--------------------------------------------------------------------------
475:     * AbrirLookupHistorico - Lookup do campo Historico do painel de
476:     * inclusao/alteracao. Transcrito de SIGOPFLP.Cnt_Inserir.CmdHist.Click:
477:     *   SqlExecute([Select * From SigOpIns Where Tipos = 3],"crSigOpIns")
478:     *   Locate For Descrs = GetHist.Value
479:     *   If Eof(): abre fwBuscaInt (migrado: FormBuscaAuxiliar)
480:     *   Se nao ESC: GetHist.Value = Descrs / GetObs.Value = Mensas
481:     * O legado tenta o match exato ANTES de abrir o picker - FormBuscaAuxiliar
482:     * ja faz isso sozinho no Init (this_lAchouRegistro), entao nao duplicamos
483:     * a consulta de existencia aqui (regra #37 - FormBuscaAuxiliar tem
484:     * contrato).
485:     *
486:     * PUBLIC (chamado via BINDEVENT no Click do cmd_4c_CmdHist).
487:     *--------------------------------------------------------------------------
488:     PROCEDURE AbrirLookupHistorico()
489:         LOCAL loc_oBusca, loc_cValorDigitado, loc_oErro
490: 
491:         TRY
492:             loc_cValorDigitado = ALLTRIM(THIS.cnt_4c__Inserir.txt_4c_Hist.Value)
493: 
494:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
495:                 "SigOpIns", ;
496:                 "cursor_4c_BuscaHist", ;
497:                 "descrs", ;
498:                 loc_cValorDigitado, ;
499:                 "Hist" + CHR(243) + "ricos", ;
500:                 .F., .T., "tipos = " + FormatarNumeroSQL(3, 0))
501: 
502:             IF VARTYPE(loc_oBusca) = "O"
503:                 IF !loc_oBusca.this_lAchouRegistro
504:                     loc_oBusca.mAddColuna("descrs", "", "Hist" + CHR(243) + "rico")
505:                     loc_oBusca.mAddColuna("mensas", "", "Mensagem")
506:                     loc_oBusca.Show()
507:                 ENDIF
508: 
509:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaHist")
510:                     SELECT cursor_4c_BuscaHist
511:                     THIS.cnt_4c__Inserir.txt_4c_Hist.Value    = ALLTRIM(cursor_4c_BuscaHist.descrs)
512:                     THIS.cnt_4c__Inserir.obj_4c_GetObs.Value  = TratarNulo(cursor_4c_BuscaHist.mensas, "")
513:                 ENDIF
514: 
515:                 IF USED("cursor_4c_BuscaHist")
516:                     USE IN cursor_4c_BuscaHist
517:                 ENDIF
518: 
519:                 loc_oBusca.Release()
520:             ENDIF
521: 
522:             THIS.cnt_4c__Inserir.txt_4c_Hist.SetFocus()
523:         CATCH TO loc_oErro
524:             MsgErro(loc_oErro.Message + CHR(13) + ;
525:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
526:                 "Procedure: " + loc_oErro.Procedure, "Erro ao buscar Hist" + CHR(243) + "rico")
527:         ENDTRY
528:     ENDPROC
529: 
530:     *--------------------------------------------------------------------------
531:     * ConfigurarBotoesAcao - Grupos de botoes de acao do topo (CommandGroup1 e
532:     * cmdApagaitem no legado). CommandGroup1 tem 1 botao (Encerrar); o Click
533:     * nao e ligado aqui - o legado usa o evento Valid de Command1 para gravar
534:     * contato e fechar o form (logica real na fase de eventos).
535:     * cmdApagaitem tem 4 botoes de acao sobre o historico selecionado na
536:     * grade: Excluir, Imprimir, Incluir, Alterar (ordem exata do legado -
537:     * Command1..Command4).
538:     *--------------------------------------------------------------------------
539:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
540:         THIS.AddObject("cmg_4c_Encerrar", "CommandGroup")
541:         WITH THIS.cmg_4c_Encerrar
542:             .Top           = -2
543:             .Left          = 920
544:             .Width         = 85
545:             .Height        = 85
546:             .ButtonCount   = 1
547:             .BackStyle     = 0
548:             .BorderStyle   = 0
549:             .SpecialEffect = 1
550:             .BorderColor   = RGB(136, 189, 188)
551:             .Themes        = .F.
552:             .Visible       = .T.
553:         ENDWITH
554: 
555:         WITH THIS.cmg_4c_Encerrar.Buttons(1)
556:             .Top             = 5
557:             .Left            = 5
558:             .Width           = 75
559:             .Height          = 75
560:             .Caption         = "Encerrar"
561:             .FontName        = "Comic Sans MS"
562:             .FontBold        = .T.
563:             .FontItalic      = .T.
564:             .FontSize        = 8
565:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
566:             .PicturePosition = 13
567:             .Cancel          = .T.
568:             .Themes          = .F.
569:             .BackColor       = RGB(255, 255, 255)
570:             .ForeColor       = RGB(90, 90, 90)
571:             .Visible         = .T.
572:         ENDWITH
573:         *-- Legado: CommandGroup1.Command1.Valid (grava telefones/e-mail da
574:         *-- conta em SigCdCli e encerra o form) - Valid de CommandGroup nao eh
575:         *-- confiavel via BINDEVENT; Click do unico botao do grupo reproduz o
576:         *-- mesmo gatilho (usuario aciona o botao).
577:         BINDEVENT(THIS.cmg_4c_Encerrar.Buttons(1), "Click", THIS, "BtnEncerrarClick")
578: 
579:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
580:         WITH THIS.cmg_4c_Botoes
581:             .Top           = -2
582:             .Left          = 620
583:             .Width         = 310
584:             .Height        = 85
585:             .ButtonCount   = 4
586:             .BackStyle     = 0
587:             .BorderStyle   = 0
588:             .SpecialEffect = 1
589:             .BorderColor   = RGB(136, 189, 188)
590:             .Themes        = .F.
591:             .Visible       = .T.
592:         ENDWITH
593: 
594:         *-- Buttons(1) = cmdApagar (Excluir)
595:         WITH THIS.cmg_4c_Botoes.Buttons(1)
596:             .Top             = 5
597:             .Left            = 155
598:             .Width           = 75
599:             .Height          = 75
600:             .Caption         = "Excluir"
601:             .FontName        = "Comic Sans MS"
602:             .FontBold        = .T.
603:             .FontItalic      = .T.
604:             .FontSize        = 8
605:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
606:             .PicturePosition = 13
607:             .ToolTipText     = "<F4> Excluir"
608:             .Themes          = .F.
609:             .BackColor       = RGB(255, 255, 255)
610:             .ForeColor       = RGB(90, 90, 90)
611:             .Visible         = .T.
612:         ENDWITH
613: 
614:         *-- Buttons(2) = cmdListar (Imprimir)
615:         WITH THIS.cmg_4c_Botoes.Buttons(2)
616:             .Top             = 5
617:             .Left            = 230

*-- Linhas 676 a 733:
676:         *-- Click dos 4 botoes de acao. Cada Buttons(N) segue a ordem de
677:         *-- declaracao do legado (Apagar=1, Listar=2, Inserir=3, Alterar=4),
678:         *-- que NAO eh a ordem visual esquerda-direita. Todos os handlers sao
679:         *-- PUBLIC - BINDEVENT ignora metodo PROTECTED em silencio (regra #3).
680:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnIncluirClick")
681:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnAlterarClick")
682:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnExcluirClick")
683:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
684:     ENDPROC
685: 
686:     *--------------------------------------------------------------------------
687:     * ConfigurarContainerContato - Painel de telefones/e-mail do cliente
688:     * (CntContato no legado). Visibilidade real depende de fChecaAcesso
689:     * ('SIGOPFLP','CONTATO'), aplicado nas fases de dados/eventos. Gravacao
690:     * (CommandGroup1.Command1.Valid do legado - Update SigCdCli) tambem fica
691:     * para a fase de eventos (botao Encerrar).
692:     *--------------------------------------------------------------------------
693:     PROTECTED PROCEDURE ConfigurarContainerContato()
694:         THIS.AddObject("cnt_4c_Contato", "Container")
695:         WITH THIS.cnt_4c_Contato
696:             .Top         = 164
697:             .Left        = 8
698:             .Width       = 984
699:             .Height      = 57
700:             .BackStyle   = 0
701:             .BorderWidth = 1
702:             .BackColor   = RGB(255, 255, 255)
703:             .BorderColor = RGB(90, 90, 90)
704:             .Visible     = .F.
705:         ENDWITH
706: 
707:         THIS.cnt_4c_Contato.AddObject("lbl_4c_LblFone", "Label")
708:         WITH THIS.cnt_4c_Contato.lbl_4c_LblFone
709:             .Caption   = "Telefones :"
710:             .Top       = 8
711:             .Left      = 48
712:             .Width     = 54
713:             .Height    = 15
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .ForeColor = RGB(90, 90, 90)
717:             .BackStyle = 0
718:             .Alignment = 0
719:             .Visible   = .T.
720:         ENDWITH
721: 
722:         THIS.cnt_4c_Contato.AddObject("txt_4c_DDDs", "TextBox")
723:         WITH THIS.cnt_4c_Contato.txt_4c_DDDs
724:             .Top           = 4
725:             .Left          = 106
726:             .Width         = 38
727:             .Height        = 23
728:             .MaxLength     = 4
729:             .Format        = "K!"
730:             .FontName      = "Tahoma"
731:             .FontSize      = 8
732:             .SpecialEffect = 1
733:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 810 a 853:
810:     * LEITURA (legado: When retorna .F. nos dois) - o valor vem da linha
811:     * corrente da grade (AfterRowColChange), ligado na fase de eventos.
812:     *--------------------------------------------------------------------------
813:     PROTECTED PROCEDURE ConfigurarContainerAgenda()
814:         THIS.AddObject("cnt_4c_Agenda", "Container")
815:         WITH THIS.cnt_4c_Agenda
816:             .Top         = 88
817:             .Left        = 8
818:             .Width       = 551
819:             .Height      = 33
820:             .BackStyle   = 0
821:             .BorderColor = RGB(90, 90, 90)
822:             .Visible     = .T.
823:         ENDWITH
824: 
825:         THIS.cnt_4c_Agenda.AddObject("txt_4c_Usuario", "TextBox")
826:         WITH THIS.cnt_4c_Agenda.txt_4c_Usuario
827:             .Top           = 4
828:             .Left          = 136
829:             .Width         = 80
830:             .Height        = 23
831:             .MaxLength     = 10
832:             .FontName      = "Tahoma"
833:             .FontSize      = 8
834:             .SpecialEffect = 1
835:             .ReadOnly      = .T.
836:             .ForeColor     = RGB(0, 0, 0)
837:             .BorderColor   = RGB(100, 100, 100)
838:             .Value         = ""
839:             .Visible       = .T.
840:         ENDWITH
841: 
842:         THIS.cnt_4c_Agenda.AddObject("lbl_4c_LblUsuario", "Label")
843:         WITH THIS.cnt_4c_Agenda.lbl_4c_LblUsuario
844:             .Caption   = "Usu" + CHR(225) + "rio :"
845:             .Top       = 8
846:             .Left      = 89
847:             .Width     = 43
848:             .Height    = 15
849:             .FontName  = "Tahoma"
850:             .FontSize  = 8
851:             .ForeColor = RGB(90, 90, 90)
852:             .BackStyle = 0
853:             .Alignment = 0

*-- Linhas 892 a 935:
892:     * Enabled = .F., fundo amarelo claro de destaque) - o valor eh resolvido
893:     * uma vez por CarregarDadosCliente/CarregarLista, nunca digitado aqui.
894:     *--------------------------------------------------------------------------
895:     PROTECTED PROCEDURE ConfigurarContainerGruCon()
896:         THIS.AddObject("cnt_4c_GruCon", "Container")
897:         WITH THIS.cnt_4c_GruCon
898:             .Top         = 126
899:             .Left        = 8
900:             .Width       = 984
901:             .Height      = 33
902:             .BackStyle   = 0
903:             .BorderColor = RGB(90, 90, 90)
904:             .Visible     = .T.
905:         ENDWITH
906: 
907:         THIS.cnt_4c_GruCon.AddObject("lbl_4c_LblGrupo", "Label")
908:         WITH THIS.cnt_4c_GruCon.lbl_4c_LblGrupo
909:             .Caption   = "Grupo :"
910:             .Top       = 8
911:             .Left      = 66
912:             .Width     = 36
913:             .Height    = 15
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .ForeColor = RGB(90, 90, 90)
917:             .BackStyle = 0
918:             .Alignment = 0
919:             .Visible   = .T.
920:         ENDWITH
921: 
922:         THIS.cnt_4c_GruCon.AddObject("txt_4c_Grupo", "TextBox")
923:         WITH THIS.cnt_4c_GruCon.txt_4c_Grupo
924:             .Top                = 5
925:             .Left               = 106
926:             .Width              = 80
927:             .Height             = 23
928:             .MaxLength          = 10
929:             .FontName           = "Tahoma"
930:             .FontSize           = 8
931:             .SpecialEffect      = 1
932:             .Enabled            = .F.
933:             .Themes             = .F.
934:             .ForeColor          = RGB(0, 0, 0)
935:             .BackColor          = RGB(251, 247, 170)

*-- Linhas 1004 a 1047:
1004:     * o valor vem da linha corrente da grade (AfterRowColChange), ligado na
1005:     * fase de eventos.
1006:     *--------------------------------------------------------------------------
1007:     PROTECTED PROCEDURE ConfigurarContainerObs()
1008:         THIS.AddObject("cnt_4c_Obs", "Container")
1009:         WITH THIS.cnt_4c_Obs
1010:             .Top         = 487
1011:             .Left        = 8
1012:             .Width       = 984
1013:             .Height      = 110
1014:             .BackStyle   = 0
1015:             .BorderWidth = 1
1016:             .BackColor   = RGB(255, 255, 255)
1017:             .BorderColor = RGB(90, 90, 90)
1018:             .Visible     = .T.
1019:         ENDWITH
1020: 
1021:         THIS.cnt_4c_Obs.AddObject("lbl_4c_LblObs", "Label")
1022:         WITH THIS.cnt_4c_Obs.lbl_4c_LblObs
1023:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1024:             .Top       = 4
1025:             .Left      = 37
1026:             .Width     = 65
1027:             .Height    = 15
1028:             .FontName  = "Tahoma"
1029:             .FontSize  = 8
1030:             .ForeColor = RGB(90, 90, 90)
1031:             .BackStyle = 0
1032:             .Alignment = 0
1033:             .Visible   = .T.
1034:         ENDWITH
1035: 
1036:         THIS.cnt_4c_Obs.AddObject("txt_4c_Obs", "TextBox")
1037:         WITH THIS.cnt_4c_Obs.txt_4c_Obs
1038:             .Top           = 4
1039:             .Left          = 106
1040:             .Width         = 871
1041:             .Height        = 101
1042:             .FontName      = "Tahoma"
1043:             .FontSize      = 8
1044:             .SpecialEffect = 1
1045:             .ReadOnly      = .T.
1046:             .ForeColor     = RGB(0, 0, 0)
1047:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1059 a 1102:
1059:     * tela ("Alias not found") - o vinculo e feito em VincularGrade(), chamado
1060:     * por CarregarLista() depois da consulta.
1061:     *--------------------------------------------------------------------------
1062:     PROTECTED PROCEDURE ConfigurarGrid()
1063:         THIS.AddObject("grd_4c_Dados", "Grid")
1064:         WITH THIS.grd_4c_Dados
1065:             .Top         = 226
1066:             .Left        = 8
1067:             .Width       = 984
1068:             .Height      = 239
1069:             .HeaderHeight       = 0
1070:             .ColumnCount = 2
1071:             .FontName    = "Arial"
1072:             .ReadOnly    = .T.
1073:             .ScrollBars  = 2
1074:             .RecordMark  = .F.
1075:             .DeleteMark  = .F.
1076:             .Visible     = .T.
1077:         ENDWITH
1078: 
1079:         *-- Column1 - Data / Hora
1080:         WITH THIS.grd_4c_Dados.Column1
1081:             .FontName   = "Courier New"
1082:             .Alignment  = 2
1083:             .Width      = 150
1084:             .Movable    = .F.
1085:             .Resizable  = .F.
1086:             .ReadOnly   = .T.
1087:             .Visible    = .T.
1088:         ENDWITH
1089:         WITH THIS.grd_4c_Dados.Column1.Header1
1090:             .FontBold  = .T.
1091:             .FontName  = "Tahoma"
1092:             .FontSize  = 8
1093:             .Alignment = 2
1094:             .Caption   = "Data / Hora"
1095:             .ForeColor = RGB(90, 90, 90)
1096:         ENDWITH
1097:         WITH THIS.grd_4c_Dados.Column1.Text1
1098:             .FontName    = "Courier New"
1099:             .Alignment   = 2
1100:             .BorderStyle = 0
1101:             .ReadOnly    = .T.
1102:             .ForeColor   = RGB(0, 0, 0)

*-- Linhas 1131 a 1978:
1131:         *-- Legado: GridFollowUp.AfterRowColChange (With CntObs/CntAgenda) -
1132:         *-- bind UMA vez aqui porque grd_4c_Dados.Objeto sobrevive a
1133:         *-- VincularGrade (so ColumnCount recria as Columns, nao o Grid).
1134:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")
1135:     ENDPROC
1136: 
1137:     *--------------------------------------------------------------------------
1138:     * CarregarLista - Carga de dados da grade de FollowUp. Reproduz a sequencia
1139:     * do Init legado: resolve Grupo/Razao da conta recebida (lcQryCli), executa
1140:     * a consulta do historico (lStrQuery -> TmpCliH -> CrSigCdClh) e so entao
1141:     * vincula a grade.
1142:     *
1143:     * PUBLIC de proposito: o harness de teste automatizado chama
1144:     * THIS.oForm.CarregarLista() de FORA da classe (PROTECTED falharia em
1145:     * runtime com "Property CARREGARLISTA is not found").
1146:     *--------------------------------------------------------------------------
1147:     PROCEDURE CarregarLista()
1148:         LOCAL loc_lSucesso, loc_oErro
1149:         loc_lSucesso = .F.
1150: 
1151:         TRY
1152:             *-- Legado: "If Empty(pConta) / Return" - sem conta nao ha o que
1153:             *-- consultar; a tela abre vazia.
1154:             IF EMPTY(ALLTRIM(THIS.this_cConta))
1155:                 loc_lSucesso = .F.
1156:             ELSE
1157:                 IF THIS.this_oBusinessObject.CarregarDadosCliente(THIS.this_cConta)
1158:                     *-- Legado: ThisForm.Grupo = CrSigCdCli.Grupos
1159:                     *--         ThisForm.Conta = Padr(pConta,10)
1160:                     THIS.this_cGrupo = THIS.this_oBusinessObject.this_cGrupos
1161:                     THIS.this_cConta = PADR(THIS.this_cConta, 10)
1162: 
1163:                     *-- Legado: With ThisForm.CntGruCon / .GetGrupo.Value = ... /
1164:                     *-- .GetConta.Value = ... / .GetDConta.Value = CrSigCdCli.RClis /
1165:                     *-- .Refresh / EndWith - e os campos de CntContato, que o
1166:                     *-- legado liga por ControlSource direto em crSigCdCli.
1167:                     THIS.BOParaForm()
1168: 
1169:                     IF THIS.this_oBusinessObject.CarregarHistorico( ;
1170:                             THIS.this_cGrupo, THIS.this_cConta, THIS.this_nNoper)
1171:                         THIS.VincularGrade()
1172:                         loc_lSucesso = .T.
1173:                     ENDIF
1174:                 ELSE
1175:                     IF !EMPTY(THIS.this_oBusinessObject.ObterMensagemErro())
1176:                         MsgAviso(THIS.this_oBusinessObject.ObterMensagemErro(), ;
1177:                             "Aten" + CHR(231) + CHR(227) + "o")
1178:                     ENDIF
1179:                 ENDIF
1180:             ENDIF
1181: 
1182:         CATCH TO loc_oErro
1183:             MsgErro(loc_oErro.Message + CHR(13) + ;
1184:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1185:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpFlp.CarregarLista")
1186:             loc_lSucesso = .F.
1187:         ENDTRY
1188: 
1189:         RETURN loc_lSucesso
1190:     ENDPROC
1191: 
1192:     *--------------------------------------------------------------------------
1193:     * VincularGrade - Liga a grade ao cursor de historico. Transcrito do final
1194:     * do Init legado:
1195:     *   With ThisForm.GridFollowUp
1196:     *       .RecordSource = 'CrSigCdClh'
1197:     *       .Column1.ControlSource = 'CrSigCdClh.Datas'
1198:     *       .Column2.ControlSource = 'CrSigCdClh.Hists'
1199:     *       .Refresh
1200:     *   EndWith
1201:     *
1202:     * ORDEM OBRIGATORIA: ColumnCount -> RecordSource -> ControlSource ->
1203:     * Width/Header1.Caption/ReadOnly. Atribuir RecordSource faz o VFP9
1204:     * recalcular as larguras para o default 90 e apagar os captions, por isso
1205:     * eles sao reaplicados DEPOIS do vinculo. Fecha com GO TOP + Refresh, senao
1206:     * a grade fica visualmente vazia com o cursor cheio.
1207:     *--------------------------------------------------------------------------
1208:     PROTECTED PROCEDURE VincularGrade()
1209:         LOCAL loc_oGrid
1210: 
1211:         IF !USED("cursor_4c_Dados")
1212:             RETURN .F.
1213:         ENDIF
1214: 
1215:         loc_oGrid = THIS.grd_4c_Dados
1216: 
1217:         WITH loc_oGrid
1218:             .RecordSource          = ""
1219:             .ColumnCount           = 2
1220:             .RecordSource          = "cursor_4c_Dados"
1221:             .Column1.ControlSource = "cursor_4c_Dados.datas"
1222:             .Column2.ControlSource = "cursor_4c_Dados.hists"
1223:         ENDWITH
1224: 
1225:         *-- Reaplicacao pos-vinculo (RecordSource reseta Width e Caption)
1226:         WITH loc_oGrid.Column1
1227:             .Width     = 150
1228:             .Alignment = 2
1229:             .FontName  = "Courier New"
1230:             .Movable   = .F.
1231:             .Resizable = .F.
1232:         ENDWITH
1233:         loc_oGrid.Column1.Header1.Caption = "Data / Hora"
1234: 
1235:         WITH loc_oGrid.Column2
1236:             .Width     = 802
1237:             .FontName  = "Courier New"
1238:             .Movable   = .F.
1239:             .Resizable = .F.
1240:         ENDWITH
1241:         loc_oGrid.Column2.Header1.Caption = "Hist" + CHR(243) + "rico"
1242: 
1243:         *-- Grid.ReadOnly propaga para as colunas: o ReadOnly da COLUNA vai
1244:         *-- depois (legado: Grid.ReadOnly = .T. e Column1/2.ReadOnly = .T.)
1245:         loc_oGrid.ReadOnly         = .T.
1246:         loc_oGrid.Column1.ReadOnly = .T.
1247:         loc_oGrid.Column2.ReadOnly = .T.
1248: 
1249:         *-- Legado: GridFollowUp.Column1.Text1.KeyPress / Column2.Text1.KeyPress
1250:         *-- (atalhos F2/F3/F4/F6 sobre a linha corrente). Column1/Column2 sao
1251:         *-- RECRIADAS a cada ColumnCount reatribuido acima, entao o bind tem de
1252:         *-- ser refeito em TODA chamada de VincularGrade - religar na mesma
1253:         *-- instancia antiga seria religar em objeto ja destruido.
1254:         BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress", THIS, "GridColumnKeyPress")
1255:         BINDEVENT(loc_oGrid.Column2.Text1, "KeyPress", THIS, "GridColumnKeyPress")
1256: 
1257:         SELECT cursor_4c_Dados
1258:         GO TOP
1259:         loc_oGrid.Refresh()
1260: 
1261:         *-- Legado: .AfterRowColChange() chamado explicitamente apos o
1262:         *-- Refresh, no fim do Init - sincroniza CntObs/CntAgenda com a
1263:         *-- primeira linha sem esperar o usuario navegar na grade.
1264:         THIS.GridAfterRowColChange(1)
1265: 
1266:         RETURN .T.
1267:     ENDPROC
1268: 
1269:     *--------------------------------------------------------------------------
1270:     * BOParaForm - Espelha no form os dados de SigCdCli resolvidos
1271:     * por CarregarDadosCliente. Legado (SIGOPFLP.Init):
1272:     *     With ThisForm.CntGruCon
1273:     *         .GetGrupo.Value  = ThisForm.Grupo
1274:     *         .GetConta.Value  = ThisForm.Conta
1275:     *         .GetDConta.Value = CrSigCdCli.RClis
1276:     *         .Refresh
1277:     *     EndWith
1278:     * Os 4 campos de CntContato (GetTel1/GetTel2/GetDDDs/GetEmail) sao ligados
1279:     * por ControlSource direto em crSigCdCli no legado - aqui sao copiados dos
1280:     * mesmos valores (this_cTel1s/this_cTel2s/this_cDDDs/this_cEmails).
1281:     *--------------------------------------------------------------------------
1282:     PROTECTED PROCEDURE BOParaForm()
1283:         LOCAL loc_oBO
1284: 
1285:         loc_oBO = THIS.this_oBusinessObject
1286:         IF VARTYPE(loc_oBO) = "O"
1287:             IF PEMSTATUS(THIS, "cnt_4c_GruCon", 5)
1288:                 WITH THIS.cnt_4c_GruCon
1289:                     .txt_4c_Grupo.Value  = ALLTRIM(THIS.this_cGrupo)
1290:                     .txt_4c_Conta.Value  = ALLTRIM(THIS.this_cConta)
1291:                     .txt_4c_DConta.Value = ALLTRIM(loc_oBO.this_cRClis)
1292:                 ENDWITH
1293:                 THIS.cnt_4c_GruCon.Refresh()
1294:             ENDIF
1295: 
1296:             *-- SO na PRIMEIRA carga (ver this_lContatoCarregado): depois dela
1297:             *-- o valor na tela e o autoritativo, igual ao legado - onde o
1298:             *-- lcQryCli roda uma unica vez, no Init. Reescrever aqui a cada
1299:             *-- CarregarLista apagaria a digitacao do usuario sem aviso.
1300:             IF PEMSTATUS(THIS, "cnt_4c_Contato", 5) AND !THIS.this_lContatoCarregado
1301:                 WITH THIS.cnt_4c_Contato
1302:                     .txt_4c_Tel1.Value  = ALLTRIM(loc_oBO.this_cTel1s)
1303:                     .txt_4c_Tel2.Value  = ALLTRIM(loc_oBO.this_cTel2s)
1304:                     .txt_4c_DDDs.Value  = ALLTRIM(loc_oBO.this_cDDDs)
1305:                     .txt_4c_Email.Value = ALLTRIM(loc_oBO.this_cEmails)
1306:                 ENDWITH
1307:                 THIS.cnt_4c_Contato.Refresh()
1308:                 THIS.this_lContatoCarregado = .T.
1309:             ENDIF
1310:         ENDIF
1311:     ENDPROC
1312: 
1313:     *--------------------------------------------------------------------------
1314:     * AplicarAcessos - Bloco de permissoes do Init legado (SIGOPFLP.Init),
1315:     * transcrito:
1316:     *     With ThisForm.CmdApagaItem
1317:     *         .CmdInserir.Visible = fChecaAcesso('SIGOPFLP','INSERIR')
1318:     *         .CmdAlterar.Visible = fChecaAcesso('SIGOPFLP','ALTERAR')
1319:     *         .CmdApagar.Visible  = fChecaAcesso('SIGOPFLP','EXCLUIR')
1320:     *         .CmdListar.Visible  = fChecaAcesso('SIGOPFLP','LISTAR')
1321:     *         ... (reempilhamento - ver AjustarAcoesPorAcesso)
1322:     *     EndWith
1323:     *     ThisForm.CntContato.Visible = fChecaAcesso('SIGOPFLP','CONTATO')
1324:     *     ThisForm.plAcesso = fChecaAcesso([SIGOPFLP],[ALTERAR])
1325:     * Mesma ordem do legado: acesso de alteracao, barra de acao e painel de
1326:     * contato.
1327:     *--------------------------------------------------------------------------
1328:     PROTECTED PROCEDURE AplicarAcessos()
1329:         LOCAL loc_oErro
1330: 
1331:         TRY
1332:             *-- plAcesso ANTES do funil: HabilitarCampos o consulta para
1333:             *-- reproduzir o When dos campos do painel.
1334:             THIS.this_lPlAcesso = THIS.ObterAcesso("ALTERAR")
1335: 
1336:             *-- Estado inicial pelo FUNIL, nunca direto no
1337:             *-- AjustarAcoesPorAcesso: com this_cTipo vazio ele deixa o painel
1338:             *-- fechado, a grade e os containers de consulta visiveis, e
1339:             *-- reempilha os botoes de acao por permissao (regra #40).
1340:             THIS.AjustarBotoesPorModo()
1341: 
1342:             THIS.cnt_4c_Contato.Visible = THIS.ObterAcesso("CONTATO")
1343:         CATCH TO loc_oErro
1344:             MsgErro(loc_oErro.Message + CHR(13) + ;
1345:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1346:                 "Procedure: " + loc_oErro.Procedure, "Erro em AplicarAcessos")
1347:         ENDTRY
1348:     ENDPROC
1349: 
1350:     *--------------------------------------------------------------------------
1351:     * ObterAcesso - fChecaAcesso('SIGOPFLP', <operacao>) do legado, com a
1352:     * chamada de 2 argumentos que o legado usa (os outros 3 parametros tem
1353:     * fallback proprio na funcao).
1354:     * Quem responde em runtime eh a funcao do Framework legado
1355:     * (Framework\sigacess.PRG), carregada DEPOIS de utils\functions.prg e por
1356:     * isso vencedora: ela abre conexao propria e consulta SigCdAcu. Sem banco
1357:     * - validacao de UI e teste automatizado - a chamada ficaria pendurada
1358:     * DENTRO do Init, por isso nesses dois modos o acesso eh concedido, pelo
1359:     * mesmo critario que InicializarForm ja usa para pular CarregarLista.
1360:     *--------------------------------------------------------------------------
1361:     PROTECTED PROCEDURE ObterAcesso(par_cOperacao)
1362:         LOCAL loc_lAcesso, loc_uRetorno
1363:         loc_lAcesso = .T.
1364: 
1365:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
1366:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
1367:             loc_uRetorno = fChecaAcesso("SIGOPFLP", par_cOperacao)
1368:             loc_lAcesso  = IIF(VARTYPE(loc_uRetorno) = "L", loc_uRetorno, .T.)
1369:         ENDIF
1370: 
1371:         RETURN loc_lAcesso
1372:     ENDPROC
1373: 
1374:     *--------------------------------------------------------------------------
1375:     * AjustarAcoesPorAcesso - Mostra/esconde e REEMPILHA os 4 botoes de acao
1376:     * conforme a permissao. Legado (SIGOPFLP.Init, With ThisForm.CmdApagaItem):
1377:     *     lcPos = 5 / lcLrg = 80
1378:     *     ... .Visible = fChecaAcesso(...) para os quatro ...
1379:     *     If .CmdInserir.Visible / .CmdInserir.Left = lcPos / lcPos = lcPos + lcLrg / EndIf
1380:     *     (repete para CmdAlterar, CmdApagar e CmdListar - nesta ordem)
1381:     *     If lcPos > 5 / .Width = lcPos + 5 / .Refresh / Else / .Visible = .F. / EndIf
1382:     * A ordem do reempilhamento eh Inserir/Alterar/Apagar/Listar, que NAO eh a
1383:     * ordem de declaracao dos Buttons (Apagar=1, Listar=2, Inserir=3,
1384:     * Alterar=4). Com os quatro visiveis o resultado eh 5/85/165/245 e
1385:     * Width = 325 - esse, e nao o Left estatico do SCX, eh o que o usuario ve,
1386:     * porque o Init legado sobrescreve sempre.
1387:     * WITH .Buttons(N) em UM nivel dentro do WITH do CommandGroup eh seguro:
1388:     * Buttons(N) eh accessor de colecao, nao AddObject (regra #38).
1389:     *--------------------------------------------------------------------------
1390:     PROTECTED PROCEDURE AjustarAcoesPorAcesso()
1391:         LOCAL loc_nPos, loc_nLrg, loc_oErro
1392: 
1393:         TRY
1394:             loc_nPos = 5
1395:             loc_nLrg = 80
1396: 
1397:             WITH THIS.cmg_4c_Botoes
1398:                 *-- O legado nao precisa reexibir o grupo aqui porque so roda
1399:                 *-- este bloco no Init; aqui ele eh o caminho de VOLTA do funil
1400:                 *-- (que esconde a barra enquanto o painel esta aberto), entao
1401:                 *-- a reexibicao tem de ser explicita - quem esconde reabilita
1402:                 *-- no funil de volta (regra #40). O ELSE do fim continua
1403:                 *-- podendo ocultar tudo, quando nao ha acesso a nada.
1404:                 .Visible = .T.
1405: 
1406:                 .Buttons(3).Visible = THIS.ObterAcesso("INSERIR")
1407:                 .Buttons(4).Visible = THIS.ObterAcesso("ALTERAR")
1408:                 .Buttons(1).Visible = THIS.ObterAcesso("EXCLUIR")
1409:                 .Buttons(2).Visible = THIS.ObterAcesso("LISTAR")
1410: 
1411:                 IF .Buttons(3).Visible
1412:                     .Buttons(3).Left = loc_nPos
1413:                     loc_nPos = loc_nPos + loc_nLrg
1414:                 ENDIF
1415:                 IF .Buttons(4).Visible
1416:                     .Buttons(4).Left = loc_nPos
1417:                     loc_nPos = loc_nPos + loc_nLrg
1418:                 ENDIF
1419:                 IF .Buttons(1).Visible
1420:                     .Buttons(1).Left = loc_nPos
1421:                     loc_nPos = loc_nPos + loc_nLrg
1422:                 ENDIF
1423:                 IF .Buttons(2).Visible
1424:                     .Buttons(2).Left = loc_nPos
1425:                     loc_nPos = loc_nPos + loc_nLrg
1426:                 ENDIF
1427: 
1428:                 IF loc_nPos > 5
1429:                     .Width = loc_nPos + 5
1430:                     .Refresh()
1431:                 ELSE
1432:                     .Visible = .F.
1433:                 ENDIF
1434:             ENDWITH
1435:         CATCH TO loc_oErro
1436:             MsgErro(loc_oErro.Message + CHR(13) + ;
1437:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1438:                 "Procedure: " + loc_oErro.Procedure, "Erro em AjustarAcoesPorAcesso")
1439:         ENDTRY
1440:     ENDPROC
1441: 
1442:     *--------------------------------------------------------------------------
1443:     * AjustarBotoesPorModo - FUNIL UNICO de estado da tela, derivado de
1444:     * this_cTipo (legado: ThisForm.Tipo). Reproduz, de uma vez, o bloco que o
1445:     * legado repete em cmdInserir.Click, cmdAlterar.Click, BtnOk.Click e
1446:     * BtnCancela.Click:
1447:     *     CntObs / CntAgenda / GridFollowUp / CmdApagaItem / CommandGroup1
1448:     *         .Visible = .F.  (painel aberto)   /   = .T.  (painel fechado)
1449:     *     Cnt_Inserir.Visible = .T. / .F.
1450:     * O painel flutuante fica em Top = 226, sobre a grade - por isso o legado
1451:     * esconde a grade e os dois containers de consulta enquanto edita.
1452:     * Existir como FUNIL eh o que impede o defeito classico de modo: quem muda
1453:     * o estado dentro de cada botao esquece o caminho de VOLTA e deixa a tela
1454:     * travada (regra #40).
1455:     * PUBLIC: o harness de teste chama THIS.oForm.AjustarBotoesPorModo() de
1456:     * FORA da classe, e PEMSTATUS(..., 5) devolve .T. mesmo para metodo
1457:     * PROTECTED - o teste entraria no branch e a chamada estouraria em runtime
1458:     * com "Property ... is not found" (regra #3).
1459:     *--------------------------------------------------------------------------
1460:     PROCEDURE AjustarBotoesPorModo()
1461:         LOCAL loc_lEditando, loc_oErro
1462: 
1463:         TRY
1464:             loc_lEditando = INLIST(UPPER(ALLTRIM(THIS.this_cTipo)), "INSERIR", "ALTERAR")
1465: 
1466:             IF PEMSTATUS(THIS, "cnt_4c__Inserir", 5)
1467:                 THIS.cnt_4c__Inserir.Visible = loc_lEditando
1468:             ENDIF
1469:             IF PEMSTATUS(THIS, "cnt_4c_Obs", 5)
1470:                 THIS.cnt_4c_Obs.Visible = !loc_lEditando
1471:             ENDIF
1472:             IF PEMSTATUS(THIS, "cnt_4c_Agenda", 5)
1473:                 THIS.cnt_4c_Agenda.Visible = !loc_lEditando
1474:             ENDIF
1475:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1476:                 THIS.grd_4c_Dados.Visible = !loc_lEditando
1477:             ENDIF
1478:             IF PEMSTATUS(THIS, "cmg_4c_Encerrar", 5)
1479:                 THIS.cmg_4c_Encerrar.Visible = !loc_lEditando
1480:             ENDIF
1481: 
1482:             IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
1483:                 IF loc_lEditando
1484:                     THIS.cmg_4c_Botoes.Visible = .F.
1485:                 ELSE
1486:                     *-- Caminho de VOLTA: quem reexibe a barra eh o bloco de
1487:                     *-- permissao, que tambem decide se ela aparece.
1488:                     THIS.AjustarAcoesPorAcesso()
1489:                 ENDIF
1490:             ENDIF
1491: 
1492:             THIS.HabilitarCampos(loc_lEditando)
1493:         CATCH TO loc_oErro
1494:             MsgErro(loc_oErro.Message + CHR(13) + ;
1495:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1496:                 "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
1497:         ENDTRY
1498:     ENDPROC
1499: 
1500:     *--------------------------------------------------------------------------
1501:     * HabilitarCampos - Libera ou trava os campos EDITAVEIS do painel.
1502:     * Legado (When de Cnt_Inserir.GetData / GetAgenda / GetHist / GetObs):
1503:     *     Return(This.Parent.GetUsuario.Value = Usuar or ThisForm.plAcesso)
1504:     * Ou seja: so o autor do registro - ou quem tem acesso de ALTERAR - edita.
1505:     * txt_4c_Usuario fica de fora porque o When dele eh Return(.F.): nasce e
1506:     * continua somente leitura.
1507:     * Chamado SO pelo funil AjustarBotoesPorModo, com o MESMO valor que decide
1508:     * a visibilidade do painel: painel visivel -> campos liberados. Assim nao
1509:     * existe estado em que o painel aparece com os campos travados sem motivo,
1510:     * e a travada no fechamento eh invisivel ao usuario (regra #40).
1511:     * PUBLIC pelo mesmo motivo de AjustarBotoesPorModo (regra #3).
1512:     *--------------------------------------------------------------------------
1513:     PROCEDURE HabilitarCampos(par_lHabilitar)
1514:         LOCAL loc_lHabilitar, loc_lDono, loc_cUsuarioPainel, loc_cUsuarioLogado
1515: 
1516:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)
1517: 
1518:         IF PEMSTATUS(THIS, "cnt_4c__Inserir", 5)
1519:             loc_cUsuarioPainel = ALLTRIM(UPPER(THIS.cnt_4c__Inserir.txt_4c_Usuario.Value))
1520:             loc_cUsuarioLogado = ALLTRIM(UPPER(IIF(VARTYPE(gc_4c_UsuarioLogado) = "C", ;
1521:                 gc_4c_UsuarioLogado, "")))
1522: 
1523:             loc_lDono      = (loc_cUsuarioPainel == loc_cUsuarioLogado) OR THIS.this_lPlAcesso
1524:             loc_lHabilitar = loc_lHabilitar AND loc_lDono
1525: 
1526:             WITH THIS.cnt_4c__Inserir
1527:                 .txt_4c_Data.ReadOnly   = !loc_lHabilitar
1528:                 .txt_4c_Agenda.ReadOnly = !loc_lHabilitar
1529:                 .txt_4c_Hist.ReadOnly   = !loc_lHabilitar
1530:                 .obj_4c_GetObs.ReadOnly = !loc_lHabilitar
1531:             ENDWITH
1532:         ENDIF
1533:     ENDPROC
1534: 
1535:     *--------------------------------------------------------------------------
1536:     * LimparPainelInsercao - Zera os campos do painel flutuante. Legado
1537:     * (cmdInserir.Click): .GetHist.Value = '' / .GetObs.Value = ''.
1538:     * Existe como metodo porque o form, diferente do legado (modal, um
1539:     * registro por vida), nao fecha entre uma operacao e outra: campo residual
1540:     * de um Incluir/Alterar anterior reapareceria no seguinte (regra #32).
1541:     * Nome proprio em vez do hook LimparCampos de FormBase: o hook da base eh
1542:     * PROTECTED e PROTECTED na base vence o override (regra #51), o que
1543:     * deixaria o metodo inalcancavel de fora sem nenhum aviso de compilacao.
1544:     *--------------------------------------------------------------------------
1545:     PROTECTED PROCEDURE LimparPainelInsercao()
1546:         IF PEMSTATUS(THIS, "cnt_4c__Inserir", 5)
1547:             WITH THIS.cnt_4c__Inserir
1548:                 .txt_4c_Data.Value    = {}
1549:                 .txt_4c_Agenda.Value  = {}
1550:                 .txt_4c_Usuario.Value = ""
1551:                 .txt_4c_Hist.Value    = ""
1552:                 .obj_4c_GetObs.Value  = ""
1553:             ENDWITH
1554:         ENDIF
1555:     ENDPROC
1556: 
1557:     *--------------------------------------------------------------------------
1558:     * TemLinhaSelecionada - A grade tem linha corrente utilizavel?
1559:     * Legado: 'Select CrSigCdClh / If !Eof()' no cmdApagar.Click.
1560:     * IFs ANINHADOS de proposito: VFP9 NAO faz short-circuit, entao
1561:     * 'USED(x) AND RECCOUNT(x) > 0' avaliaria o RECCOUNT com o alias FECHADO e
1562:     * estouraria "Alias is not found".
1563:     * PUBLIC: usado pelos handlers e disponivel ao harness de teste (regra #3).
1564:     *--------------------------------------------------------------------------
1565:     PROCEDURE TemLinhaSelecionada()
1566:         LOCAL loc_lTem
1567:         loc_lTem = .F.
1568: 
1569:         IF USED("cursor_4c_Dados")
1570:             IF RECCOUNT("cursor_4c_Dados") > 0
1571:                 IF !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
1572:                     loc_lTem = .T.
1573:                 ENDIF
1574:             ENDIF
1575:         ENDIF
1576: 
1577:         RETURN loc_lTem
1578:     ENDPROC
1579: 
1580:     *--------------------------------------------------------------------------
1581:     * FocarCelulaDataHora - Devolve o foco para a celula "Data / Hora" da
1582:     * grade. Legado, no fim do cmdApagar.Click, do BtnOk.Click e do
1583:     * BtnCancela.Click: 'ThisForm.GridFollowUp.Column1.Text1.SetFocus'.
1584:     * Guardas: SetFocus em controle invisivel ou em grade sem linha estoura -
1585:     * e a grade fica OCULTA enquanto o painel de edicao esta aberto.
1586:     *--------------------------------------------------------------------------
1587:     PROTECTED PROCEDURE FocarCelulaDataHora()
1588:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1589:             IF THIS.grd_4c_Dados.Visible
1590:                 IF THIS.TemLinhaSelecionada()
1591:                     THIS.grd_4c_Dados.Column1.Text1.SetFocus()
1592:                 ENDIF
1593:             ENDIF
1594:         ENDIF
1595:     ENDPROC
1596: 
1597:     *--------------------------------------------------------------------------
1598:     * PreencherPainelDaLinhaSelecionada - Copia a linha corrente da grade para
1599:     * os campos do painel. Legado (cmdAlterar.Click):
1600:     *     .GetData.Value    = CrSigCdClh.Datas
1601:     *     .GetUsuario.Value = CrSigCdClh.Usuars
1602:     *     .GetAgenda.Value  = Iif(!Empty(CrSigCdClh.DatAgens),CrSigCdClh.DatAgens,fDtoSQL(Date(),'00:00:00'))
1603:     *     .GetHist.Value    = CrSigCdClh.Hists
1604:     *     .GetObs.Value     = CrSigCdClh.Obs
1605:     *     .BtnOk.Enabled    = (CrSigCdClh.Usuars = Usuar or ThisForm.plAcesso)
1606:     * Os valores sao os MESMOS que o legado le direto do cursor, so o caminho
1607:     * respeita as camadas (PILAR 3): o chamador ja fez
1608:     * CarregarDoCursor("cursor_4c_Dados") e aqui so se le o BO.
1609:     * this_cCidChave guarda a chave da linha em edicao (legado: pCIdChave),
1610:     * que eh o WHERE do UPDATE.
1611:     *--------------------------------------------------------------------------
1612:     PROTECTED PROCEDURE PreencherPainelDaLinhaSelecionada()
1613:         LOCAL loc_oBO, loc_cUsuarioLogado, loc_lDono
1614: 
1615:         loc_oBO = THIS.this_oBusinessObject
1616:         IF VARTYPE(loc_oBO) = "O"
1617:             loc_cUsuarioLogado = ALLTRIM(UPPER(IIF(VARTYPE(gc_4c_UsuarioLogado) = "C", ;
1618:                 gc_4c_UsuarioLogado, "")))
1619:             loc_lDono = (ALLTRIM(UPPER(loc_oBO.this_cUsuars)) == loc_cUsuarioLogado) OR ;
1620:                 THIS.this_lPlAcesso
1621: 
1622:             THIS.this_cCidChave = ALLTRIM(loc_oBO.this_cCidchaves)
1623: 
1624:             WITH THIS.cnt_4c__Inserir
1625:                 .txt_4c_Data.Value    = loc_oBO.this_dDatas
1626:                 .txt_4c_Usuario.Value = ALLTRIM(loc_oBO.this_cUsuars)
1627:                 .txt_4c_Agenda.Value  = IIF(!EMPTY(loc_oBO.this_dDatagens), ;
1628:                     loc_oBO.this_dDatagens, fDtoSQL(DATE(), "00:00:00"))
1629:                 .txt_4c_Hist.Value    = ALLTRIM(loc_oBO.this_cHists)
1630:                 .obj_4c_GetObs.Value  = loc_oBO.this_cObs
1631:                 .cmd_4c_BtnOk.Enabled = loc_lDono
1632:             ENDWITH
1633:         ENDIF
1634:     ENDPROC
1635: 
1636:     *--------------------------------------------------------------------------
1637:     * GridAfterRowColChange - Espelha a linha corrente da grade nos containers
1638:     * de consulta. Legado (SIGOPFLP.GridFollowUp.AfterRowColChange):
1639:     *     With ThisForm.CntObs
1640:     *         .GetObs.Value = CrSigCdClh.Obs
1641:     *         .Refresh
1642:     *     EndWith
1643:     *     With ThisForm.CntAGenda
1644:     *         .GetUSuario.Value = CrSigCdClh.Usuars
1645:     *         .GetAgenda.Value  = Nvl(CrSigCdClh.DatAgens,{})
1646:     *         .Refresh
1647:     *     EndWith
1648:     * par_nColIndex e exigido pela assinatura do evento (regra #3), mas o
1649:     * legado nao filtra por coluna - qualquer troca de linha ou coluna
1650:     * repinta os dois containers.
1651:     * PUBLIC: ligado por BINDEVENT (regra #3) e chamado manualmente por
1652:     * VincularGrade apos o Refresh inicial.
1653:     *--------------------------------------------------------------------------
1654:     PROCEDURE GridAfterRowColChange(par_nColIndex)
1655:         IF USED("cursor_4c_Dados") AND THIS.TemLinhaSelecionada()
1656:             SELECT cursor_4c_Dados
1657: 
1658:             IF PEMSTATUS(THIS, "cnt_4c_Obs", 5)
1659:                 THIS.cnt_4c_Obs.txt_4c_Obs.Value = TratarNulo(cursor_4c_Dados.obs, "")
1660:                 THIS.cnt_4c_Obs.Refresh()
1661:             ENDIF
1662: 
1663:             IF PEMSTATUS(THIS, "cnt_4c_Agenda", 5)
1664:                 THIS.cnt_4c_Agenda.txt_4c_Usuario.Value = TratarNulo(cursor_4c_Dados.usuars, "")
1665:                 THIS.cnt_4c_Agenda.txt_4c_Agenda.Value   = TratarNulo(cursor_4c_Dados.datagens, {})
1666:                 THIS.cnt_4c_Agenda.Refresh()
1667:             ENDIF
1668:         ENDIF
1669:     ENDPROC
1670: 
1671:     *--------------------------------------------------------------------------
1672:     * GridColumnKeyPress - Atalhos F2/F3/F4/F6 sobre a linha corrente da
1673:     * grade. Legado (SIGOPFLP.GridFollowUp.Column1/Column2.Text1.KeyPress),
1674:     * transcrito (nKeyCode dentro de celula de Grid usa os codigos negativos
1675:     * do VFP9 para teclas de funcao - F2=-1, F3=-2, F4=-3, F6=-5 - DIFERENTE
1676:     * do KeyPress de TextBox fora de Grid, que usa os codigos ASCII/virtuais
1677:     * normais):
1678:     *     Do Case
1679:     *         Case nKeyCode = -1 And .CmdInserir.Enabled = .T. -> NoDefault / .CmdInserir.Click()
1680:     *         Case nKeyCode = -2 And .CmdAlterar.Enabled = .T. -> NoDefault / .CmdAlterar.Click()
1681:     *         Case nKeyCode = -3 And .CmdApagar.Enabled  = .T. -> NoDefault / .CmdApagar.Click()
1682:     *         Case nKeyCode = -5 And .CmdListar.Enabled  = .T. -> NoDefault / .CmdListar.Click()
1683:     *     EndCase
1684:     * Mapeamento dos Buttons de cmg_4c_Botoes (ordem de declaracao, regra do
1685:     * Click): CmdApagar=Buttons(1), CmdListar=Buttons(2), CmdInserir=Buttons(3),
1686:     * CmdAlterar=Buttons(4).
1687:     * PUBLIC: ligado por BINDEVENT em Column1.Text1/Column2.Text1 (regra #3).
1688:     *--------------------------------------------------------------------------
1689:     PROCEDURE GridColumnKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1690:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
1691:             DO CASE
1692:                 CASE par_nKeyCode = -1 AND THIS.cmg_4c_Botoes.Buttons(3).Enabled
1693:                     NODEFAULT
1694:                     THIS.cmg_4c_Botoes.Buttons(3).Click()
1695:                 CASE par_nKeyCode = -2 AND THIS.cmg_4c_Botoes.Buttons(4).Enabled
1696:                     NODEFAULT
1697:                     THIS.cmg_4c_Botoes.Buttons(4).Click()
1698:                 CASE par_nKeyCode = -3 AND THIS.cmg_4c_Botoes.Buttons(1).Enabled
1699:                     NODEFAULT
1700:                     THIS.cmg_4c_Botoes.Buttons(1).Click()
1701:                 CASE par_nKeyCode = -5 AND THIS.cmg_4c_Botoes.Buttons(2).Enabled
1702:                     NODEFAULT
1703:                     THIS.cmg_4c_Botoes.Buttons(2).Click()
1704:             ENDCASE
1705:         ENDIF
1706:     ENDPROC
1707: 
1708:     *--------------------------------------------------------------------------
1709:     * BtnIncluirClick - cmdInserir.Click (Buttons(3) de cmg_4c_Botoes).
1710:     * Legado (SIGOPFLP.cmdApagaitem.cmdInserir.Click), transcrito:
1711:     *     ThisForm.Tipo = 'INSERIR'
1712:     *     CntObs / CntAgenda / GridFollowUp / CmdApagaItem / CommandGroup1
1713:     *         .Visible = .F.                      (-> AjustarBotoesPorModo)
1714:     *     With ThisForm.Cnt_Inserir
1715:     *         .Visible = .T. / .GetData.Value = DateTime()
1716:     *         .GetUsuario.Value = Usuar
1717:     *         .GetAgenda.Value = fDtoSQL(Date(),'00:00:00')
1718:     *         .GetHist.Value = '' / .GetObs.Value = ''
1719:     *         .Refresh / .GetData.SetFocus
1720:     *     EndWith
1721:     *     ThisForm.Draw
1722:     * A gravacao eh do botao Confirmar do painel (Fase 8) - este botao so abre
1723:     * o painel com os defaults do ramo INSERIR.
1724:     * O guard de conta vazia nao esta no legado porque la o Init faz "Return"
1725:     * sem conta e a tela nem monta; aqui ela abre, e sem conta o Incluir
1726:     * gravaria um followup ORFAO (SigCdClh.iclis/grupos sao NOT NULL). Recusar
1727:     * antes de abrir o painel eh mais claro que abrir e avisar depois
1728:     * (regra #50). O BO repete a regra em ValidarDados - fonte unica.
1729:     * PUBLIC: ligado por BINDEVENT e chamado pelo harness (regra #3).
1730:     *--------------------------------------------------------------------------
1731:     PROCEDURE BtnIncluirClick()
1732:         LOCAL loc_oErro
1733: 
1734:         TRY
1735:             IF EMPTY(ALLTRIM(THIS.this_cConta))
1736:                 MsgAviso("Conta n" + CHR(227) + "o informada - abra o FollowUp a " + ;
1737:                     "partir de uma conta.", "Aten" + CHR(231) + CHR(227) + "o")
1738:             ELSE
1739:                 THIS.this_cTipo = "INSERIR"
1740:                 THIS.LimparPainelInsercao()
1741: 
1742:                 *-- Usuario ANTES do funil: HabilitarCampos o compara com o
1743:                 *-- usuario logado para reproduzir o When dos campos.
1744:                 WITH THIS.cnt_4c__Inserir
1745:                     .txt_4c_Data.Value    = DATETIME()
1746:                     .txt_4c_Usuario.Value = IIF(VARTYPE(gc_4c_UsuarioLogado) = "C", ;
1747:                         gc_4c_UsuarioLogado, "")
1748:                     .txt_4c_Agenda.Value  = fDtoSQL(DATE(), "00:00:00")
1749:                     .cmd_4c_BtnOk.Enabled = .T.
1750:                 ENDWITH
1751: 
1752:                 *-- Abre o painel, esconde a consulta e libera os campos pelo
1753:                 *-- funil de modo (regra #40)
1754:                 THIS.AjustarBotoesPorModo()
1755: 
1756:                 THIS.cnt_4c__Inserir.Refresh()
1757:                 THIS.cnt_4c__Inserir.txt_4c_Data.SetFocus()
1758:                 THIS.Draw()
1759:             ENDIF
1760:         CATCH TO loc_oErro
1761:             MsgErro(loc_oErro.Message + CHR(13) + ;
1762:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1763:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnIncluirClick")
1764:         ENDTRY
1765:     ENDPROC
1766: 
1767:     *--------------------------------------------------------------------------
1768:     * BtnAlterarClick - cmdAlterar.Click (Buttons(4) de cmg_4c_Botoes).
1769:     * Legado (SIGOPFLP.cmdApagaitem.cmdAlterar.Click), transcrito:
1770:     *     ThisForm.Tipo = 'ALTERAR'
1771:     *     CntObs / CntAgenda / GridFollowUp / CmdApagaItem / CommandGroup1
1772:     *         .Visible = .F.                      (-> AjustarBotoesPorModo)
1773:     *     With ThisForm.Cnt_Inserir
1774:     *         .Visible = .T. / campos da linha corrente
1775:     *         (-> PreencherPainelDaLinhaSelecionada)
1776:     *         .Refresh / .GetData.SetFocus
1777:     *     EndWith
1778:     *     ThisForm.Draw
1779:     * O legado le CrSigCdClh sem guarda nenhuma; aqui a guarda contra grade
1780:     * vazia eh necessaria porque sem linha corrente o painel abriria com tudo
1781:     * em branco e a alteracao, no Confirmar, cairia num aviso tardio
1782:     * (regra #50).
1783:     * CancelarEdicao() ANTES de CarregarDoCursor normaliza this_lNovoRegistro:
1784:     * se um Incluir anterior falhou ao gravar, a flag ficaria ligada e a
1785:     * gravacao desta alteracao seria recusada (regra #32 - o form nao fecha
1786:     * entre operacoes).
1787:     * PUBLIC: ligado por BINDEVENT e chamado pelo harness (regra #3).
1788:     *--------------------------------------------------------------------------
1789:     PROCEDURE BtnAlterarClick()
1790:         LOCAL loc_oBO, loc_oErro
1791: 
1792:         TRY
1793:             IF !THIS.TemLinhaSelecionada()
1794:                 MsgAviso("Selecione na grade o hist" + CHR(243) + "rico que deseja " + ;
1795:                     "alterar.", "Aten" + CHR(231) + CHR(227) + "o")
1796:             ELSE
1797:                 loc_oBO = THIS.this_oBusinessObject
1798:                 IF VARTYPE(loc_oBO) = "O"
1799:                     loc_oBO.CancelarEdicao()
1800:                     loc_oBO.CarregarDoCursor("cursor_4c_Dados")
1801:                 ENDIF
1802: 
1803:                 THIS.this_cTipo = "ALTERAR"
1804:                 THIS.LimparPainelInsercao()
1805:                 THIS.PreencherPainelDaLinhaSelecionada()
1806: 
1807:                 *-- Abre o painel, esconde a consulta e aplica o When dos
1808:                 *-- campos pelo funil de modo (regra #40)
1809:                 THIS.AjustarBotoesPorModo()
1810: 
1811:                 THIS.cnt_4c__Inserir.Refresh()
1812:                 THIS.cnt_4c__Inserir.txt_4c_Data.SetFocus()
1813:                 THIS.Draw()
1814:             ENDIF
1815:         CATCH TO loc_oErro
1816:             MsgErro(loc_oErro.Message + CHR(13) + ;
1817:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1818:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
1819:         ENDTRY
1820:     ENDPROC
1821: 
1822:     *--------------------------------------------------------------------------
1823:     * BtnExcluirClick - cmdApagar.Click (Buttons(1) de cmg_4c_Botoes).
1824:     * Legado (SIGOPFLP.cmdApagaitem.cmdApagar.Click):
1825:     *     Select CrSigCdClh
1826:     *     If !Eof()
1827:     *         If CrSigCdClh.Usuars <> Usuar -> 'Registro Inserido/Alterado por
1828:     *             outro usuario !!!' e aborta
1829:     *         If !CrSigCdClh.Autos Or Empty(Obs) Or Empty(Datas)
1830:     *             If MessageBox('Deseja realmente excluir este registro ???',
1831:     *                 4+32+256,'Confirma Exclusao') = 6
1832:     *                 Delete From SigCdClh Where CIdChaves = ... / Commit /
1833:     *                 Delete no cursor / Skip / Skip -1
1834:     *         Else -> 'Historico Automatico !!!' e aborta
1835:     *     Select CrSigCdClh / GridFollowUp.Refresh / Column1.Text1.SetFocus
1836:     * As DUAS guardas (autor do registro e historico automatico) e suas
1837:     * mensagens ja estao em SigOpFlpBO.AntesDeExcluir, que eh a fonte unica -
1838:     * aqui so se carrega a linha no BO e se delega para Excluir(), que eh
1839:     * PUBLIC (regra #51: ExecutarExclusao nunca eh chamado de fora do BO).
1840:     * UNICO desvio conhecido: a confirmacao fica ANTES das duas guardas (no
1841:     * legado ela vem depois), entao num registro nao-excluivel o usuario
1842:     * confirma primeiro e so depois le o motivo da recusa. A ordem do legado
1843:     * exigiria expor as guardas do BO ao form, duplicando regra de negocio.
1844:     * PUBLIC: ligado por BINDEVENT e chamado pelo harness (regra #3).
1845:     *--------------------------------------------------------------------------
1846:     PROCEDURE BtnExcluirClick()
1847:         LOCAL loc_oBO, loc_oErro
1848: 
1849:         TRY
1850:             *-- Legado: 'Select CrSigCdClh / If !Eof()' - sem linha corrente o
1851:             *-- Click nao faz nada (nem avisa).
1852:             IF THIS.TemLinhaSelecionada()
1853:                 IF MsgConfirma("Deseja realmente excluir este registro ???", ;
1854:                         "Confirma Exclus" + CHR(227) + "o")
1855:                     loc_oBO = THIS.this_oBusinessObject
1856:                     IF VARTYPE(loc_oBO) = "O"
1857:                         loc_oBO.CancelarEdicao()
1858:                         loc_oBO.CarregarDoCursor("cursor_4c_Dados")
1859: 
1860:                         *-- Falha ou recusa NUNCA eh muda: BusinessBase.Excluir
1861:                         *-- exibe a mensagem em todo caminho (regra #20), por
1862:                         *-- isso nao ha ELSE aqui.
1863:                         loc_oBO.Excluir()
1864:                     ENDIF
1865: 
1866:                     *-- Legado: Delete no cursor + Skip/Skip -1. Aqui a lista
1867:                     *-- eh relida do banco, que tambem reposiciona e repinta a
1868:                     *-- grade (CarregarLista -> VincularGrade, regra #21a).
1869:                     THIS.CarregarLista()
1870:                 ENDIF
1871: 
1872:                 *-- Legado: SetFocus na celula SEMPRE, inclusive quando a
1873:                 *-- exclusao foi recusada ou cancelada.
1874:                 THIS.FocarCelulaDataHora()
1875:             ENDIF
1876:         CATCH TO loc_oErro
1877:             MsgErro(loc_oErro.Message + CHR(13) + ;
1878:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1879:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
1880:         ENDTRY
1881:     ENDPROC
1882: 
1883:     *--------------------------------------------------------------------------
1884:     * BtnImprimirClick - cmdListar.Click (Buttons(2) de cmg_4c_Botoes).
1885:     * Legado (SIGOPFLP.cmdApagaitem.cmdListar.Click), integral:
1886:     *     * Chamada da Impressao do FollowUp
1887:     *     Do Form SigOpFlu With ThisForm.DataSessionId,
1888:     *         ThisForm.CntGruCon.GetGrupo.Value, ThisForm.CntGruCon.GetConta.Value
1889:     * DO FORM nao abre nada no projeto novo (nao existe .scx) e a classe filha
1890:     * nem entraria no indice de carga sob demanda, que eh montado a partir dos
1891:     * CREATEOBJECT - por isso a chamada eh CREATEOBJECT com o nome LITERAL da
1892:     * classe migrada, e os tres argumentos do legado na mesma ordem.
1893:     * SIGOPFLU ainda esta em origem\ (nao migrado): a ausencia fica VISIVEL no
1894:     * CATCH, de proposito - guard de FILE()/PEMSTATUS silenciaria o botao e o
1895:     * usuario clicaria sem nada acontecer. Quando o filho for migrado, este
1896:     * handler passa a funcionar sem alteracao.
1897:     * Show() FORA do TRY: o filho eh modal e, dentro do TRY, qualquer erro de
1898:     * runtime dele cairia neste CATCH, derrubando a referencia LOCAL e
1899:     * fechando a tela filha sozinha (regra #29).
1900:     * PUBLIC: ligado por BINDEVENT (regra #3).
1901:     *--------------------------------------------------------------------------
1902:     PROCEDURE BtnImprimirClick()
1903:         LOCAL loc_oForm, loc_oErro, loc_cGrupo, loc_cConta
1904: 
1905:         loc_oForm  = .NULL.
1906:         loc_cGrupo = ALLTRIM(THIS.cnt_4c_GruCon.txt_4c_Grupo.Value)
1907:         loc_cConta = ALLTRIM(THIS.cnt_4c_GruCon.txt_4c_Conta.Value)
1908: 
1909:         TRY
1910:             loc_oForm = CREATEOBJECT("FormSigOpFlu", THIS.DataSessionId, ;
1911:                 loc_cGrupo, loc_cConta)
1912:         CATCH TO loc_oErro
1913:             loc_oForm = .NULL.
1914:             MsgErro(loc_oErro.Message + CHR(13) + ;
1915:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1916:                 "Procedure: " + loc_oErro.Procedure, ;
1917:                 "Erro ao abrir a impress" + CHR(227) + "o do FollowUp")
1918:         ENDTRY
1919: 
1920:         IF VARTYPE(loc_oForm) = "O"
1921:             loc_oForm.Show()
1922:         ENDIF
1923:     ENDPROC
1924: 
1925:     *--------------------------------------------------------------------------
1926:     * FormParaBO - Copia os campos do painel de inclusao/alteracao para o
1927:     * Business Object, antes de Salvar(). Legado (BtnOk.Click):
1928:     *     Case Tipo = 'INSERIR': ldDatas/ldAgenda/lcHists/lmObs = GetData/
1929:     *         GetAgenda/GetHist/GetObs, mais Grupos/IClis/GruContas/Nopers
1930:     *         (This.Parent eh Cnt_Inserir - os 4 campos sao do painel)
1931:     *     Case Tipo = 'ALTERAR': Replace so Datas/Usuars/DatAgens/Hists/Obs -
1932:     *         Grupos/IClis/GruContas/Autos/Emps/Nopers/Ccargs/Tplancs/Codsits
1933:     *         ja estao no BO (CarregarDoCursor, feito em BtnAlterarClick) e
1934:     *         permanecem como gravados na inclusao.
1935:     * Por isso Grupos/IClis/Nopers so sao atribuidos no ramo INSERIR; no
1936:     * ALTERAR eles ficam intocados (SigOpFlpBO.Atualizar nem os usa no SQL).
1937:     *--------------------------------------------------------------------------
1938:     PROTECTED PROCEDURE FormParaBO()
1939:         LOCAL loc_oBO
1940: 
1941:         loc_oBO = THIS.this_oBusinessObject
1942:         IF VARTYPE(loc_oBO) = "O"
1943:             WITH THIS.cnt_4c__Inserir
1944:                 loc_oBO.this_dDatas    = .txt_4c_Data.Value
1945:                 loc_oBO.this_dDatagens = .txt_4c_Agenda.Value
1946:                 loc_oBO.this_cHists    = ALLTRIM(.txt_4c_Hist.Value)
1947:                 loc_oBO.this_cObs      = .obj_4c_GetObs.Value
1948:             ENDWITH
1949: 
1950:             IF UPPER(ALLTRIM(THIS.this_cTipo)) == "INSERIR"
1951:                 loc_oBO.this_cGrupos    = THIS.this_cGrupo
1952:                 loc_oBO.this_cIclis     = ALLTRIM(THIS.this_cConta)
1953:                 loc_oBO.this_nNopers    = THIS.this_nNoper
1954:                 *-- Forca fUniqueIds() novo dentro de Inserir() - o registro em
1955:                 *-- edicao pode ter vindo de um Alterar anterior na mesma vida
1956:                 *-- do form (regra #32).
1957:                 loc_oBO.this_cCidchaves = ""
1958:             ENDIF
1959: 
1960:             *-- Os 4 campos EDITAVEIS de Cnt_Contato. No legado eles chegam ao
1961:             *-- banco por variavel lida na hora, dentro de
1962:             *-- CommandGroup1.Valid (lcTel1 = CntContato.GetTel1.Value, ...);
1963:             *-- aqui o BO e a fonte unica, entao o espelhamento tela -> BO
1964:             *-- mora neste hook, junto com o do painel. Nao entram no SQL de
1965:             *-- SigCdClh (Inserir/Atualizar nao os usam) - quem os persiste em
1966:             *-- SigCdCli e SalvarContato, no Encerrar.
1967:             IF PEMSTATUS(THIS, "cnt_4c_Contato", 5)
1968:                 WITH THIS.cnt_4c_Contato
1969:                     loc_oBO.this_cTel1s  = ALLTRIM(.txt_4c_Tel1.Value)
1970:                     loc_oBO.this_cTel2s  = ALLTRIM(.txt_4c_Tel2.Value)
1971:                     loc_oBO.this_cDDDs   = ALLTRIM(.txt_4c_DDDs.Value)
1972:                     loc_oBO.this_cEmails = ALLTRIM(.txt_4c_Email.Value)
1973:                 ENDWITH
1974:             ENDIF
1975:         ENDIF
1976:     ENDPROC
1977: 
1978:     *--------------------------------------------------------------------------

*-- Linhas 1995 a 2150:
1995:     * (regra do CancelarEdicao ja feito em BtnAlterarClick).
1996:     * Sem ELSE apos Salvar(): falha ja foi exibida pelo proprio BusinessBase
1997:     * (regra #20) - o painel so fecha quando a gravacao realmente aconteceu.
1998:     * PUBLIC: ligado por BINDEVENT (regra #3).
1999:     *--------------------------------------------------------------------------
2000:     PROCEDURE BtnSalvarClick()
2001:         LOCAL loc_oBO, loc_oErro
2002: 
2003:         TRY
2004:             loc_oBO = THIS.this_oBusinessObject
2005:             IF VARTYPE(loc_oBO) = "O"
2006:                 DO CASE
2007:                     CASE UPPER(ALLTRIM(THIS.this_cTipo)) == "INSERIR"
2008:                         loc_oBO.NovoRegistro()
2009:                     CASE UPPER(ALLTRIM(THIS.this_cTipo)) == "ALTERAR"
2010:                         loc_oBO.EditarRegistro()
2011:                 ENDCASE
2012: 
2013:                 THIS.FormParaBO()
2014: 
2015:                 IF loc_oBO.Salvar()
2016:                     THIS.this_cTipo = ""
2017:                     THIS.AjustarBotoesPorModo()
2018:                     THIS.CarregarLista()
2019:                     THIS.FocarCelulaDataHora()
2020:                 ENDIF
2021:             ENDIF
2022:         CATCH TO loc_oErro
2023:             MsgErro(loc_oErro.Message + CHR(13) + ;
2024:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2025:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
2026:         ENDTRY
2027:     ENDPROC
2028: 
2029:     *--------------------------------------------------------------------------
2030:     * BtnCancelarClick - BtnCancela.Click (Cancelar) do painel de inclusao/
2031:     * alteracao. Legado, transcrito:
2032:     *     This.Parent.Visible = .F.
2033:     *     CntObs/CntAgenda/GridFollowUp/CmdApagaItem/CommandGroup1.Visible = .T.
2034:     *         (-> AjustarBotoesPorModo)
2035:     *     GridFollowUp.Column1.Text1.SetFocus
2036:     * CancelarEdicao() normaliza this_lNovoRegistro/this_lEmEdicao no BO -
2037:     * sem isso, abrir o painel de novo (Incluir/Alterar) herdaria o estado de
2038:     * edicao anterior (regra #32 - o form nao fecha entre uma operacao e
2039:     * outra, diferente do legado modal).
2040:     * PUBLIC: ligado por BINDEVENT (regra #3).
2041:     *--------------------------------------------------------------------------
2042:     PROCEDURE BtnCancelarClick()
2043:         LOCAL loc_oBO, loc_oErro
2044: 
2045:         TRY
2046:             loc_oBO = THIS.this_oBusinessObject
2047:             IF VARTYPE(loc_oBO) = "O"
2048:                 loc_oBO.CancelarEdicao()
2049:             ENDIF
2050: 
2051:             THIS.this_cTipo = ""
2052:             THIS.AjustarBotoesPorModo()
2053:             THIS.FocarCelulaDataHora()
2054:         CATCH TO loc_oErro
2055:             MsgErro(loc_oErro.Message + CHR(13) + ;
2056:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2057:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnCancelarClick")
2058:         ENDTRY
2059:     ENDPROC
2060: 
2061:     *--------------------------------------------------------------------------
2062:     * BtnEncerrarClick - CommandGroup1.Command1.Valid (botao Encerrar) do
2063:     * legado, transcrito:
2064:     *     lcTel1/lcTel2/lcDDDs/lcEMail = CntContato.GetTel1/GetTel2/GetDDDs/
2065:     *         GetEMail.Value
2066:     *     Update SigCdCli Set Tel1s=?,Tel2s=?,DDDs=?,EMails=? Where IClis = ...
2067:     *         (-> SigOpFlpBO.SalvarContato)
2068:     *     If lnErro > 0 / Commit / EndIf
2069:     *     ThisForm.Release
2070:     * O legado grava SEMPRE os 4 campos (mesmo com CntContato oculto por falta
2071:     * de acesso - a Valid do grupo nao checa Visible) e encerra o form mesmo
2072:     * que a gravacao falhe - transcrito fielmente; SigOpFlpBO.SalvarContato ja
2073:     * exibe o erro antes de devolver, igual aos demais metodos de SQL do BO.
2074:     * PUBLIC: ligado por BINDEVENT (regra #3).
2075:     *--------------------------------------------------------------------------
2076:     PROCEDURE BtnEncerrarClick()
2077:         LOCAL loc_oBO, loc_oErro
2078: 
2079:         TRY
2080:             loc_oBO = THIS.this_oBusinessObject
2081:             IF VARTYPE(loc_oBO) = "O" AND PEMSTATUS(THIS, "cnt_4c_Contato", 5)
2082:                 loc_oBO.SalvarContato( ;
2083:                     THIS.cnt_4c_Contato.txt_4c_Tel1.Value, ;
2084:                     THIS.cnt_4c_Contato.txt_4c_Tel2.Value, ;
2085:                     THIS.cnt_4c_Contato.txt_4c_DDDs.Value, ;
2086:                     THIS.cnt_4c_Contato.txt_4c_Email.Value)
2087:             ENDIF
2088:         CATCH TO loc_oErro
2089:             MsgErro(loc_oErro.Message + CHR(13) + ;
2090:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2091:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnEncerrarClick")
2092:         ENDTRY
2093: 
2094:         THIS.Release()
2095:     ENDPROC
2096: 
2097:     *--------------------------------------------------------------------------
2098:     * TornarControlesVisiveis - AddObject cria controles com Visible = .F.
2099:     * por padrao. Torna tudo visivel recursivamente, EXCETO os containers
2100:     * flutuantes que o legado mantem ocultos por padrao (cnt_4c__Inserir e
2101:     * cnt_4c_Contato) - cujos FILHOS, ainda assim, precisam ficar visiveis
2102:     * (senao, quando o container for mostrado mais tarde, aparece vazio).
2103:     *--------------------------------------------------------------------------
2104:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2105:         LOCAL loc_nI, loc_oObjeto, loc_nP
2106: 
2107:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2108:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2109: 
2110:             IF VARTYPE(loc_oObjeto) = "O"
2111:                 IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C__INSERIR", "CNT_4C_CONTATO")
2112:                     *-- Preserva Visible = .F. do proprio container, mas desce
2113:                     *-- a recursao para os filhos dele ficarem prontos.
2114:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2115:                     LOOP
2116:                 ENDIF
2117: 
2118:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2119:                     loc_oObjeto.Visible = .T.
2120:                 ENDIF
2121: 
2122:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2123:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2124:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2125:                     ENDFOR
2126:                 ENDIF
2127: 
2128:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2129:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2130:                 ENDIF
2131:             ENDIF
2132:         ENDFOR
2133:     ENDPROC
2134: 
2135:     *--------------------------------------------------------------------------
2136:     * Destroy - Libera os cursores do BO (legado: ThisForm.poDataMgr.Release no
2137:     * Release) e delega para FormBase.Destroy(), que libera
2138:     * this_oBusinessObject e restaura o menu principal.
2139:     * DODEFAULT() por ULTIMO - sem ele FormBase.Destroy nao roda e os popups do
2140:     * menu principal ficam com cache visual obsoleto.
2141:     *--------------------------------------------------------------------------
2142:     PROCEDURE Destroy()
2143:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2144:             THIS.this_oBusinessObject.FecharCursores()
2145:         ENDIF
2146: 
2147:         DODEFAULT()
2148:     ENDPROC
2149: 
2150: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpFlpBO.prg):
*==============================================================================
* SigOpFlpBO.prg
*
* Business Object para SigOpFlp (Consulta de FollowUp)
* Tabela: SigCdClh
* Chave primaria: cidchaves (gerada via fUniqueIds(), nao e sequencial)
*
* FASE 2/8: Metodos CRUD (CarregarDoCursor, Inserir, Atualizar,
* ExecutarExclusao, ObterChavePrimaria, RegistrarAuditoria)
*==============================================================================

DEFINE CLASS SigOpFlpBO AS BusinessBase

    *-- Propriedades da entidade (mapeiam 1:1 as colunas de SigCdClh)
    this_cCidchaves = ""        && char(20) NOT NULL - PK, gerada via fUniqueIds()
    this_cGrupos    = ""        && char(10) NOT NULL - grupo do cliente/conta
    this_cIclis     = ""        && char(10) NOT NULL - codigo do cliente/conta
    this_cGrucontas = ""        && char(20) NOT NULL - Grupos + IClis concatenados
    this_dDatas     = {}        && datetime NULL     - data/hora do registro de historico
    this_cUsuars    = ""        && char(10) NOT NULL - usuario que gravou/alterou
    this_dDatagens  = {}        && datetime NULL     - data/hora do agendamento
    this_cHists     = ""        && char(250) NOT NULL - historico (tipo/ocorrencia)
    this_cObs       = ""        && text NULL          - observacao (memo)
    this_lAutos     = .F.       && bit NOT NULL        - .T. = historico automatico (nao exclui livremente)
    this_cEmps      = ""        && char(3) NOT NULL   - empresa
    this_nNopers    = 0         && numeric(10,0) NOT NULL - numero da operacao (filtro do FollowUp)
    this_cCcargs    = ""        && char(10) NOT NULL  - cargo/area responsavel
    this_cTplancs   = ""        && char(2) NOT NULL   - tipo de lancamento
    this_cCodsits   = ""        && char(2) NOT NULL   - codigo de situacao

    *-- Dados de SigCdCli resolvidos por CarregarDadosCliente (somente
    *-- exibicao/edicao do painel de Contato - nao sao colunas de SigCdClh)
    this_cRClis     = ""        && char(50) - razao social da conta
    this_cDDDs      = ""        && char(4)  - DDD de contato
    this_cTel1s     = ""        && char(20) - telefone 1
    this_cTel2s     = ""        && char(20) - telefone 2
    this_cEmails    = ""        && char(50) - e-mail de contato

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela      = "SigCdClh"
        THIS.this_cCampoChave  = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades do BO a partir de um cursor
    * posicionado no registro desejado (SELECT * FROM SigCdClh ou subconjunto
    * equivalente). Mapeia TODAS as colunas da tabela.
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar os campos -
    * sintaxe campo nao existe em VFP9.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF()
                    THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                    THIS.this_cGrupos    = TratarNulo(grupos,    "")
                    THIS.this_cIclis     = TratarNulo(iclis,     "")
                    THIS.this_cGrucontas = TratarNulo(grucontas, "")
                    THIS.this_dDatas     = TratarNulo(datas,     {})
                    THIS.this_cUsuars    = TratarNulo(usuars,    "")
                    THIS.this_dDatagens  = TratarNulo(datagens,  {})
                    THIS.this_cHists     = TratarNulo(hists,     "")
                    THIS.this_cObs       = TratarNulo(obs,       "")
                    THIS.this_lAutos     = ConverterParaLogico(autos)
                    THIS.this_cEmps      = TratarNulo(emps,      "")
                    THIS.this_nNopers    = TratarNulo(nopers,    0)

                    *-- Colunas que o legado nem sempre seleciona no cursor de
                    *-- historico (ccargs/tplancs/codsits): guarda defensiva
                    *-- para nao estourar "Variable X is not found" quando o
                    *-- cursor de origem for um subconjunto das colunas.
                    IF TYPE("ccargs") != "U"
                        THIS.this_cCcargs = TratarNulo(ccargs, "")
                    ENDIF
                    IF TYPE("tplancs") != "U"
                        THIS.this_cTplancs = TratarNulo(tplancs, "")
                    ENDIF
                    IF TYPE("codsits") != "U"
                        THIS.this_cCodsits = TratarNulo(codsits, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar hist" + CHR(243) + "rico de FollowUp do cursor:" + ;
                CHR(13) + loException.Message, "SigOpFlpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Zera as propriedades de historico antes de um novo
    * registro (chamado por NovoRegistro(), dentro de BtnSalvarClick). Sem
    * este override, campos sem controle na tela (Ccargs/Tplancs/Codsits)
    * ficariam com o valor do ULTIMO registro carregado por CarregarDoCursor
    * (ex.: um Alterar anterior na mesma vida do form - regra #32) e um
    * Incluir subsequente gravaria essa sobra. Grupos/IClis/Nopers NAO entram
    * aqui porque THIS.PainelParaBO() os repoe explicitamente no ramo
    * INSERIR, a partir do contexto (conta/grupo/operacao) do form.
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves = ""
        THIS.this_dDatas     = {}
        THIS.this_dDatagens  = {}
        THIS.this_cHists     = ""
        THIS.this_cObs       = ""
        THIS.this_lAutos     = .F.
        THIS.this_cCcargs    = ""
        THIS.this_cTplancs   = ""
        THIS.this_cCodsits   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de gravar (transcrito do legado:
    * BtnOk.Click do SIGOPFLP nao valida nada alem dos campos ja exigidos
    * pela tela; Historico e Observacao sao de preenchimento livre)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupos)) OR EMPTY(ALLTRIM(THIS.this_cIclis))
            THIS.this_cMensagemErro = "Grupo/Conta n" + CHR(227) + "o informados para o Hist" + CHR(243) + "rico de FollowUp!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cHists))
            THIS.this_cMensagemErro = "Hist" + CHR(243) + "rico n" + CHR(227) + "o pode ficar em branco!"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro de historico de FollowUp em SigCdClh
    * Transcrito de SIGOPFLP.Cnt_Inserir.BtnOk.Click (Case Tipo = 'INSERIR')
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cGruContas
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cEmps))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            *-- Legado: "Usuars With Usuar" - sempre o usuario logado no momento
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            *-- Legado: "GruContas With lcGrupo + lcConta" (char(10) + char(10))
            loc_cGruContas       = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cIclis, 10)
            THIS.this_cGrucontas = loc_cGruContas

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdClh (grupos, iclis, grucontas, datas, usuars, datagens, hists, obs, autos, emps, nopers, ccargs, tplancs, cidchaves, codsits)
                VALUES (
                    <<EscaparSQL(LEFT(THIS.this_cGrupos, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cIclis, 10))>>,
                    <<EscaparSQL(LEFT(loc_cGruContas, 20))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>,
                    <<FormatarDataSQL(THIS.this_dDatagens)>>,
                    <<EscaparSQL(LEFT(THIS.this_cHists, 250))>>,
                    <<EscaparSQL(THIS.this_cObs)>>,
                    <<FormatarNumeroSQL(IIF(THIS.this_lAutos, 1, 0), 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
                    <<EscaparSQL(LEFT(THIS.this_cCcargs, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cTplancs, 2))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCodsits, 2))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir Hist" + CHR(243) + "rico de FollowUp:" + ;
                    CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao inserir:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente de historico de FollowUp
    * Transcrito de SIGOPFLP.Cnt_Inserir.BtnOk.Click (Case Tipo = 'ALTERAR'):
    * o legado so altera Datas/Usuars/DatAgens/Hists/Obs - Grupos, IClis,
    * GruContas, Autos, Emps, Nopers, Ccargs, Tplancs e Codsits permanecem
    * como gravados na inclusao (nao fazem parte do Replace original).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Legado: "Usuars With Usuar" (tambem no ramo ALTERAR)
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdClh
                SET datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    usuars   = <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>,
                    datagens = <<FormatarDataSQL(THIS.this_dDatagens)>>,
                    hists    = <<EscaparSQL(LEFT(THIS.this_cHists, 250))>>,
                    obs      = <<EscaparSQL(THIS.this_cObs)>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar Hist" + CHR(243) + "rico de FollowUp:" + ;
                    CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao atualizar:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AntesDeExcluir - Guardas transcritas de SIGOPFLP.cmdApagaitem.cmdApagar.
    * Click: (1) so quem gravou/alterou o registro pode excluir; (2) historico
    * AUTOMATICO (Autos=.T.) com Obs e Datas preenchidos nao pode ser excluido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AntesDeExcluir()
        LOCAL loc_lPermitido
        loc_lPermitido = .T.

        IF ALLTRIM(UPPER(THIS.this_cUsuars)) != ALLTRIM(UPPER(NVL(gc_4c_UsuarioLogado, "")))
            THIS.this_cMensagemErro = "Registro Inserido/Alterado por outro usu" + CHR(225) + "rio !!!"
            loc_lPermitido = .F.
        ENDIF

        IF loc_lPermitido AND THIS.this_lAutos AND !EMPTY(THIS.this_cObs) AND !EMPTY(THIS.this_dDatas)
            THIS.this_cMensagemErro = "Hist" + CHR(243) + "rico Autom" + CHR(225) + "tico !!!"
            loc_lPermitido = .F.
        ENDIF

        RETURN loc_lPermitido
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui o registro de historico de FollowUp
    * Transcrito de SIGOPFLP.cmdApagaitem.cmdApagar.Click
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdClh WHERE cidchaves = " + ;
                EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir Hist" + CHR(243) + "rico de FollowUp:" + ;
                    CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao excluir:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.ExecutarExclusao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosCliente - Resolve Grupo / Razao Social / Contato a partir do
    * codigo da conta recebido pelo form.
    * Transcrito de SIGOPFLP.Init (lcQryCli):
    *   Select a.Grupos,a.IClis,a.RClis,a.DDDs,a.Tel1s,a.Tel2s,a.EMails
    *     From SigCdCli a Where a.IClis = ?lcCliente
    * Popula cursor_4c_Cliente (consumido pelos campos de CntGruCon/CntContato)
    * e as properties this_cGrupos / this_cIclis, que sao o filtro do historico.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosCliente(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConta
        loc_lSucesso = .F.
        loc_cConta   = IIF(VARTYPE(par_cConta) = "C", par_cConta, "")

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                *-- USE IN (nao ZAP+APPEND): o SQLEXEC recria o alias com a
                *-- estrutura correta e o form refaz o vinculo da grade logo
                *-- depois, em VincularGrade().
                IF USED("cursor_4c_Cliente")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Cliente") > 1
                        TABLEREVERT(.T., "cursor_4c_Cliente")
                    ENDIF
                    USE IN cursor_4c_Cliente
                ENDIF

                loc_cSQL = "SELECT grupos, iclis, rclis, ddds, tel1s, tel2s, emails" + ;
                    " FROM SigCdCli" + ;
                    " WHERE iclis = " + EscaparSQL(PADR(loc_cConta, 10))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cliente")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_Cliente") AND RECCOUNT("cursor_4c_Cliente") > 0
                        SELECT cursor_4c_Cliente
                        GO TOP
                        THIS.this_cGrupos = TratarNulo(cursor_4c_Cliente.grupos, "")
                        THIS.this_cIclis  = TratarNulo(cursor_4c_Cliente.iclis, "")
                        THIS.this_cRClis  = TratarNulo(cursor_4c_Cliente.rclis, "")
                        THIS.this_cDDDs   = TratarNulo(cursor_4c_Cliente.ddds, "")
                        THIS.this_cTel1s  = TratarNulo(cursor_4c_Cliente.tel1s, "")
                        THIS.this_cTel2s  = TratarNulo(cursor_4c_Cliente.tel2s, "")
                        THIS.this_cEmails = TratarNulo(cursor_4c_Cliente.emails, "")
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Conta [" + ALLTRIM(loc_cConta) + "] n" + ;
                            CHR(227) + "o cadastrada!"
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar dados da conta:" + ;
                        CHR(13) + CapturarErroSQL()
                    MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar dados da conta:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.CarregarDadosCliente")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarContato - Atualiza telefones/e-mail da conta em SigCdCli.
    * Transcrito de SIGOPFLP.CommandGroup1.Command1.Valid (botao Encerrar):
    *   Update SigCdCli Set Tel1s = ?,Tel2s = ?,DDDs = ?,EMails = ?
    *     Where IClis = '<THIS.this_cIclis>'
    * THIS.this_cIclis precisa ja estar resolvido (CarregarDadosCliente).
    *--------------------------------------------------------------------------
    PROCEDURE SalvarContato(par_cTel1, par_cTel2, par_cDDDs, par_cEmail)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cIclis))
                THIS.this_cMensagemErro = "Conta n" + CHR(227) + "o resolvida - " + ;
                    "contato n" + CHR(227) + "o pode ser gravado."
            ELSE
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    UPDATE SigCdCli
                    SET tel1s  = <<EscaparSQL(LEFT(IIF(VARTYPE(par_cTel1) = "C", par_cTel1, ""), 20))>>,
                        tel2s  = <<EscaparSQL(LEFT(IIF(VARTYPE(par_cTel2) = "C", par_cTel2, ""), 20))>>,
                        ddds   = <<EscaparSQL(LEFT(IIF(VARTYPE(par_cDDDs) = "C", par_cDDDs, ""), 4))>>,
                        emails = <<EscaparSQL(LEFT(IIF(VARTYPE(par_cEmail) = "C", par_cEmail, ""), 50))>>
                    WHERE iclis = <<EscaparSQL(PADR(THIS.this_cIclis, 10))>>
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao gravar contato da conta:" + ;
                        CHR(13) + CapturarErroSQL()
                    MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao gravar contato:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.SalvarContato")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarHistorico - Popula cursor_4c_Dados com o historico de FollowUp da
    * conta/grupo informados, que e a fonte da grade GridFollowUp.
    *
    * Transcrito de SIGOPFLP.Init (duas etapas, iguais ao legado):
    *   1) lStrQuery = Select Emps,IClis,Grupos,GruContas,Autos,Usuars,Datas,
    *                  DatAgens,Hists,Obs,CIdChaves,Nopers From SigCdClh
    *                  Where IClis = ?_Conta And Grupos = ?_Grupo   -> TmpCliH
    *   2) Select ...,Nvl(Datas,CrBranco.Datas) As Datas,
    *                Nvl(DatAgens,CrBranco.Datas) As DatAgens,
    *                Nvl(Obs,CrBranco.Obs) As Obs ...
    *        From TmpCliH
    *        Where Iif(ThisForm.Noper = 0,0=0,Nopers = ThisForm.Noper)
    *        Order By Datas Into Cursor CrSigCdClh ReadWrite
    *
    * O cursor CrBranco do legado (Obs memo vazio + Datas datetime vazio) e
    * reproduzido em cursor_4c_Branco: ele garante que o NVL devolva MEMO para
    * Obs (e nao caractere truncado) e data vazia em vez de .NULL. na grade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarHistorico(par_cGrupo, par_cConta, par_nNoper)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cGrupo, loc_cConta, loc_nNoper
        loc_lSucesso = .F.
        loc_cGrupo   = IIF(VARTYPE(par_cGrupo) = "C", par_cGrupo, "")
        loc_cConta   = IIF(VARTYPE(par_cConta) = "C", par_cConta, "")
        loc_nNoper   = IIF(VARTYPE(par_nNoper) = "N", par_nNoper, 0)

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                *-- Legado: Create Cursor CrBranco (Obs m,Datas t)
                *--         Insert Into CrBranco (Obs,Datas) Values ('',{})
                IF !USED("cursor_4c_Branco")
                    CREATE CURSOR cursor_4c_Branco (obs M, datas T)
                    INSERT INTO cursor_4c_Branco (obs, datas) VALUES ("", {})
                ENDIF
                SELECT cursor_4c_Branco
                GO TOP

                *-- Etapa 1: equivalente ao TmpCliH do legado. O SQLEXEC nunca
                *-- vai direto para o alias da grade - isso zeraria o
                *-- ColumnCount dela e a grade viraria um retangulo branco.
                IF USED("cursor_4c_DadosTmp")
                    IF CURSORGETPROP("Buffering", "cursor_4c_DadosTmp") > 1
                        TABLEREVERT(.T., "cursor_4c_DadosTmp")
                    ENDIF
                    USE IN cursor_4c_DadosTmp
                ENDIF

                loc_cSQL = "SELECT emps, iclis, grupos, grucontas, autos, usuars," + ;
                    " datas, datagens, hists, obs, cidchaves, nopers" + ;
                    " FROM SigCdClh" + ;
                    " WHERE iclis = " + EscaparSQL(PADR(loc_cConta, 10)) + ;
                    " AND grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Favor reinicializar o processo !!!" + CHR(13) + ;
                        CapturarErroSQL()
                    MostrarErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o (SigCdClh)")
                ELSE
                    *-- Etapa 2: cursor da grade. USE IN antes de recriar - o
                    *-- vinculo do Grid e refeito em VincularGrade().
                    IF USED("cursor_4c_Dados")
                        IF CURSORGETPROP("Buffering", "cursor_4c_Dados") > 1
                            TABLEREVERT(.T., "cursor_4c_Dados")
                        ENDIF
                        USE IN cursor_4c_Dados
                    ENDIF

                    SELECT emps, iclis, grupos, grucontas, usuars, ;
                           NVL(datas, cursor_4c_Branco.datas)    AS datas, ;
                           NVL(datagens, cursor_4c_Branco.datas) AS datagens, ;
                           hists, ;
                           NVL(obs, cursor_4c_Branco.obs)        AS obs, ;
                           autos, cidchaves, nopers ;
                        FROM cursor_4c_DadosTmp ;
                        WHERE IIF(m.loc_nNoper = 0, 0 = 0, nopers = m.loc_nNoper) ;
                        ORDER BY datas ;
                        INTO CURSOR cursor_4c_Dados READWRITE

                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF

                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        GO TOP
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar hist" + CHR(243) + "rico de FollowUp:" + ;
                CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpFlpBO.CarregarHistorico")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursores - Libera os cursores criados por este BO. Chamado pelo
    * Destroy do form (o legado faz ThisForm.poDataMgr.Release no Release).
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursores()
        LOCAL ARRAY loc_aCursores[4]
        LOCAL loc_nI

        loc_aCursores[1] = "cursor_4c_Dados"
        loc_aCursores[2] = "cursor_4c_DadosTmp"
        loc_aCursores[3] = "cursor_4c_Cliente"
        loc_aCursores[4] = "cursor_4c_Branco"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                IF CURSORGETPROP("Buffering", loc_aCursores[loc_nI]) > 1
                    TABLEREVERT(.T., loc_aCursores[loc_nI])
                ENDIF
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

ENDDEFINE

