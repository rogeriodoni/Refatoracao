# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-HEADER] Header Caption 'Operaçõo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tab.Desconto, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operaçõo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tab.Desconto, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTbO.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1271 linhas total):

*-- Linhas 88 a 114:
88: 
89:     *--------------------------------------------------------------------------
90:     * ConfigurarPageFrame - Configura PageFrame principal
91:     * PageFrame.Top = -29 (oculta abas) -> compensar +29px nos controles internos
92:     *--------------------------------------------------------------------------
93:     PROTECTED PROCEDURE ConfigurarPageFrame()
94:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
95: 
96:         WITH THIS.pgf_4c_Paginas
97:             .Top       = -29
98:             .Left      = 0
99:             .Width     = 1003
100:             .Height    = 629
101:             .PageCount = 2
102:             .Tabs      = .F.
103:             .Visible   = .T.
104: 
105:             .Page1.Caption   = "Lista"
106:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page1.BackColor = RGB(255, 255, 255)
108: 
109:             .Page2.Caption   = "Dados"
110:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:             .Page2.BackColor = RGB(255, 255, 255)
112:         ENDWITH
113:     ENDPROC
114: 

*-- Linhas 126 a 163:
126:         *-- Container de cabecalho (cntSombra: Top=2 -> 31)
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 31
130:             .Left        = 0
131:             .Width       = 1003
132:             .Height      = 80
133:             .BackStyle   = 1
134:             .BackColor   = RGB(100, 100, 100)
135:             .BorderWidth = 0
136:             .Visible     = .T.
137:         ENDWITH
138: 
139:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
140:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
141:             .Caption   = THIS.Caption
142:             .Top       = 15
143:             .Left      = 10
144:             .Width     = 769
145:             .Height    = 40
146:             .FontName  = "Tahoma"
147:             .FontSize  = 16
148:             .FontBold  = .T.
149:             .BackStyle = 0
150:             .ForeColor = RGB(0, 0, 0)
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = THIS.Caption
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = 769
160:             .Height    = 46
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.

*-- Linhas 171 a 195:
171:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
172:         loc_oBotoes = loc_oPagina.cnt_4c_Botoes
173:         WITH loc_oBotoes
174:             .Top         = 29
175:             .Left        = 542
176:             .Width       = 390
177:             .Height      = 85
178:             .BackColor   = RGB(53, 53, 53)
179:             .BackStyle   = 1
180:             .BorderWidth = 0
181:             .Visible     = .T.
182:         ENDWITH
183: 
184:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
185:         WITH loc_oBotoes.cmd_4c_Incluir
186:             .Caption         = "Incluir"
187:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
188:             .PicturePosition = 13
189:             .Top             = 5
190:             .Left            = 5
191:             .Width           = 75
192:             .Height          = 75
193:             .BackColor       = RGB(255, 255, 255)
194:             .ForeColor       = RGB(90, 90, 90)
195:             .FontName        = "Tahoma"

*-- Linhas 204 a 218:
204:             .Visible         = .T.
205:         ENDWITH
206: 
207:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
208:         WITH loc_oBotoes.cmd_4c_Visualizar
209:             .Caption         = "Visualizar"
210:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
211:             .PicturePosition = 13
212:             .Top             = 5
213:             .Left            = 80
214:             .Width           = 75
215:             .Height          = 75
216:             .BackColor       = RGB(255, 255, 255)
217:             .ForeColor       = RGB(90, 90, 90)
218:             .FontName        = "Tahoma"

*-- Linhas 227 a 241:
227:             .Visible         = .T.
228:         ENDWITH
229: 
230:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
231:         WITH loc_oBotoes.cmd_4c_Alterar
232:             .Caption         = "Alterar"
233:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
234:             .PicturePosition = 13
235:             .Top             = 5
236:             .Left            = 155
237:             .Width           = 75
238:             .Height          = 75
239:             .BackColor       = RGB(255, 255, 255)
240:             .ForeColor       = RGB(90, 90, 90)
241:             .FontName        = "Tahoma"

*-- Linhas 250 a 264:
250:             .Visible         = .T.
251:         ENDWITH
252: 
253:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
254:         WITH loc_oBotoes.cmd_4c_Excluir
255:             .Caption         = "Excluir"
256:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
257:             .PicturePosition = 13
258:             .Top             = 5
259:             .Left            = 230
260:             .Width           = 75
261:             .Height          = 75
262:             .BackColor       = RGB(255, 255, 255)
263:             .ForeColor       = RGB(90, 90, 90)
264:             .FontName        = "Tahoma"

*-- Linhas 273 a 287:
273:             .Visible         = .T.
274:         ENDWITH
275: 
276:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
277:         WITH loc_oBotoes.cmd_4c_Buscar
278:             .Caption         = "Buscar"
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
280:             .PicturePosition = 13
281:             .Top             = 5
282:             .Left            = 305
283:             .Width           = 75
284:             .Height          = 75
285:             .BackColor       = RGB(255, 255, 255)
286:             .ForeColor       = RGB(90, 90, 90)
287:             .FontName        = "Tahoma"

*-- Linhas 296 a 329:
296:             .Visible         = .T.
297:         ENDWITH
298: 
299:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
300:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
301:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
302:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
303:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
304: 
305:         *-- Container de saida (padrao canonico CLAUDE.md regra #10 - PREVALECE sobre legado)
306:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
307:         loc_oSaida = loc_oPagina.cnt_4c_Saida
308:         WITH loc_oSaida
309:             .Top         = 29
310:             .Left        = 917
311:             .Width       = 90
312:             .Height      = 85
313:             .BackStyle   = 0
314:             .BorderWidth = 0
315:             .Visible     = .T.
316:         ENDWITH
317: 
318:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
319:         WITH loc_oSaida.cmd_4c_Encerrar
320:             .Caption         = "Encerrar"
321:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
322:             .PicturePosition = 13
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .BackColor       = RGB(255, 255, 255)
328:             .ForeColor       = RGB(90, 90, 90)
329:             .FontName        = "Tahoma"

*-- Linhas 338 a 357:
338:             .Visible         = .T.
339:         ENDWITH
340: 
341:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
342: 
343:         *-- Grid de lista: vinculos Operacao (dopes) x Tabela de Desconto (tabds/descrs)
344:         *-- cidchaves (PK) permanece no cursor mas nao e exibido em coluna (equivalente
345:         *-- ao GUID gerado por fUniqueIds() no legado - sem significado para o usuario)
346:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
347:         loc_oPagina.grd_4c_Dados.RecordSource = ""
348:         loc_oPagina.grd_4c_Dados.ColumnCount  = 3
349: 
350:         WITH loc_oPagina.grd_4c_Dados
351:             .Top                     = 117
352:             .Left                    = 12
353:             .Width                   = 890
354:             .Height                  = 480
355:             .FontName                = "Verdana"
356:             .FontSize                = 8
357:             .ForeColor               = RGB(90, 90, 90)

*-- Linhas 379 a 390:
379:             *-- "Lista" agrega vinculos de TODAS as operacoes (Buscar com dopes vazio),
380:             *-- entao a coluna e necessaria para o usuario distinguir a qual Operacao
381:             *-- cada linha pertence. Caption usa o mesmo termo ja empregado em
382:             *-- lbl_4c_Operacao ("Operacao : ") - nao e abreviacao nem invencao.
383:             .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
384:             .Column2.Header1.Caption = "Tab.Desconto"
385:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
386:         ENDWITH
387: 
388:         THIS.TornarControlesVisiveis(loc_oPagina)
389:     ENDPROC
390: 

*-- Linhas 422 a 432:
422:                     loc_oGrid.Column3.ReadOnly        = .T.
423:                     *-- Coluna 1 (Operacao/dopes) sem equivalente na grade legado - ver
424:                     *-- justificativa em ConfigurarPaginaLista/grd_4c_Dados acima.
425:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
426:                     loc_oGrid.Column2.Header1.Caption = "Tab.Desconto"
427:                     loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
428: 
429:                     THIS.FormatarGridLista(loc_oGrid)
430: 
431:                     loc_oGrid.Refresh()
432: 

*-- Linhas 490 a 527:
490:         *-- Cabecalho cinza (identico ao da pagina Lista)
491:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
492:         WITH loc_oPagina.cnt_4c_Cabecalho
493:             .Top           = 29
494:             .Left          = 0
495:             .Width         = THIS.Width
496:             .Height        = 80
497:             .BackColor     = RGB(100, 100, 100)
498:             .BorderWidth   = 0
499:             .SpecialEffect = 0
500:             .Visible       = .T.
501: 
502:             .AddObject("lbl_4c_Sombra", "Label")
503:             WITH .lbl_4c_Sombra
504:                 .Caption   = THIS.Caption
505:                 .Top       = 15
506:                 .Left      = 10
507:                 .Width     = THIS.Width
508:                 .Height    = 40
509:                 .FontName  = "Tahoma"
510:                 .FontSize  = 16
511:                 .FontBold  = .T.
512:                 .ForeColor = RGB(0, 0, 0)
513:                 .BackStyle = 0
514:                 .AutoSize  = .F.
515:                 .Visible   = .T.
516:             ENDWITH
517: 
518:             .AddObject("lbl_4c_Titulo", "Label")
519:             WITH .lbl_4c_Titulo
520:                 .Caption   = THIS.Caption
521:                 .Top       = 18
522:                 .Left      = 10
523:                 .Width     = THIS.Width
524:                 .Height    = 46
525:                 .FontName  = "Tahoma"
526:                 .FontSize  = 16
527:                 .FontBold  = .T.

*-- Linhas 536 a 560:
536:         *-- Padrao Framework: grupo_salva Left=834, Top=4 -> 33, Width=160, Height=85
537:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
538:         WITH loc_oPagina.cnt_4c_BotoesAcao
539:             .Top         = 33
540:             .Left        = 834
541:             .Width       = 160
542:             .Height      = 85
543:             .BackStyle = 1
544:             .BackColor = RGB(255, 255, 255)
545:             .BorderWidth = 0
546:             .Visible     = .T.
547:         ENDWITH
548: 
549:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
550:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
551:             .Caption         = "Confirmar"
552:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
553:             .PicturePosition = 13
554:             .Top             = 5
555:             .Left            = 5
556:             .Width           = 75
557:             .Height          = 75
558:             .BackColor       = RGB(255, 255, 255)
559:             .ForeColor       = RGB(90, 90, 90)
560:             .FontName        = "Tahoma"

*-- Linhas 569 a 583:
569:             .Visible         = .T.
570:         ENDWITH
571: 
572:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
573:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
574:             .Caption         = "Encerrar"
575:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
576:             .PicturePosition = 13
577:             .Top             = 5
578:             .Left            = 80
579:             .Width           = 75
580:             .Height          = 75
581:             .BackColor       = RGB(255, 255, 255)
582:             .ForeColor       = RGB(90, 90, 90)
583:             .FontName        = "Tahoma"

*-- Linhas 592 a 616:
592:             .Visible         = .T.
593:         ENDWITH
594: 
595:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
596:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
597: 
598:         *----------------------------------------------------------------------
599:         * CAMPO 1: Operacao (dopes) - FASE 5/8 (parte 1 de 2)
600:         * O legado nao tem um controle proprio para este campo: a operacao vem
601:         * do form pai (crSigCdOpe.Dopes, injetado no Init(poForm,...) da SIGCDTBV)
602:         * e e apenas exibida no Caption. No novo sistema, cada vinculo SigOpTdo
603:         * tem seu proprio "dopes" (this_cDopes do TbOBO), entao o campo aparece
604:         * aqui como somente-leitura para dar visibilidade ao usuario durante
605:         * Incluir/Alterar/Visualizar.
606:         *----------------------------------------------------------------------
607:         loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
608:         WITH loc_oPagina.lbl_4c_Operacao
609:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
610:             .Top       = 160
611:             .Left      = 40
612:             .Width     = 90
613:             .Height    = 17
614:             .FontName  = "Tahoma"
615:             .FontSize  = 8
616:             .FontBold  = .F.

*-- Linhas 624 a 633:
624:         loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
625:         WITH loc_oPagina.txt_4c_Dopes
626:             .Value         = ""
627:             .Top           = 156
628:             .Left          = 135
629:             .Width         = 150
630:             .Height        = 24
631:             .FontName      = "Tahoma"
632:             .FontSize      = 8
633:             .MaxLength     = 20

*-- Linhas 645 a 657:
645:         * com lookup fwBuscaExt em SigOpTdz.Codigos - lookup sera vinculado na
646:         * Fase 7/8). Aqui apenas o TextBox editavel.
647:         *----------------------------------------------------------------------
648:         loc_oPagina.AddObject("lbl_4c_TabelaDesconto", "Label")
649:         WITH loc_oPagina.lbl_4c_TabelaDesconto
650:             .Caption   = "Tab. Desconto : "
651:             .Top       = 191
652:             .Left      = 40
653:             .Width     = 90
654:             .Height    = 17
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .FontBold  = .F.

*-- Linhas 665 a 674:
665:         loc_oPagina.AddObject("txt_4c_Tabds", "TextBox")
666:         WITH loc_oPagina.txt_4c_Tabds
667:             .Value         = ""
668:             .Top           = 187
669:             .Left          = 135
670:             .Width         = 80
671:             .Height        = 24
672:             .FontName      = "Tahoma"
673:             .FontSize      = 8
674:             .MaxLength     = 10

*-- Linhas 693 a 705:
693:         * "Replace Descrs With CrListaRemota.Descrs in LocalTabdO" do legado, que
694:         * so atualizava a coluna auxiliar de exibicao da grade).
695:         *----------------------------------------------------------------------
696:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
697:         WITH loc_oPagina.lbl_4c_Descricao
698:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
699:             .Top       = 222
700:             .Left      = 40
701:             .Width     = 90
702:             .Height    = 17
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .FontBold  = .F.

*-- Linhas 713 a 722:
713:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
714:         WITH loc_oPagina.txt_4c_Descrs
715:             .Value         = ""
716:             .Top           = 218
717:             .Left          = 135
718:             .Width         = 250
719:             .Height        = 24
720:             .FontName      = "Tahoma"
721:             .FontSize      = 8
722:             .MaxLength     = 30

*-- Linhas 1208 a 1217:
1208:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1209: 
1210:         TRY
1211:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1212:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1213:         CATCH TO loException
1214:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
1215:         ENDTRY
1216:     ENDPROC
1217: 


### BO (C:\4c\projeto\app\classes\TbOBO.prg):
*============================================================================
* TbOBO.prg - Business Object: Tabelas de Desconto por Operacao
* Migrado de: SIGCDTBV.SCX (SigCdTbO)
* Tabela principal   : SigOpTdo   (chave: cidchaves)
* Tabela relacionada : SigOpTdz   (tabelas de desconto - lookup/join, chave: codigos)
* Tabela pai         : SigCdOpe   (operacao, chave: dopes) - informada pelo form chamador
*============================================================================
DEFINE CLASS TbOBO AS BusinessBase

    *-- Propriedades: SigOpTdo
    this_cCidChaves = ""   && cidchaves   C(20) - Chave Primaria
    this_cDopes     = ""   && dopes       C(20) - FK SigCdOpe.Dopes (operacao pai)
    this_cTabds     = ""   && tabds       C(10) - FK SigOpTdz.Codigos (tabela de desconto)

    *-- Propriedade auxiliar: SigOpTdz (somente exibicao via JOIN, nao persistida em SigOpTdo)
    this_cDescrs    = ""   && descrs      C(30) - Descricao da tabela de desconto (JOIN SigOpTdz)

    *-- Nome do cursor local de detalhe (grid editavel de tabelas de desconto da operacao)
    this_cCursorDetalhe = "cursor_4c_TbODetalhe"

    *-- Flags de controle de alteracao (equivalentes a lHouveIns/lHouveExcl do legado)
    this_lHouveInsercao = .F.
    this_lHouveExclusao = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpTdo"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para um novo registro (chamado por
    * BusinessBase.NovoRegistro()). CRITICO: sem isso, this_cCidChaves de um
    * registro anteriormente carregado (Visualizar/Alterar/Excluir) permanece
    * preenchido e Inserir() reaproveitaria essa PK antiga em vez de gerar uma
    * nova via fUniqueIds().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves = ""
        THIS.this_cDopes     = ""
        THIS.this_cTabds     = ""
        THIS.this_cDescrs    = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT das tabelas de desconto vinculadas a operacao (JOIN SigOpTdz)
    * par_cDopes: codigo da operacao (SigCdOpe.Dopes). Se vazio, retorna TODOS os
    *             vinculos de todas as operacoes (equivalente a listagem geral).
    * Espelha exatamente a query original:
    *   Select a.*,b.Descrs From SigOpTdo a, SigOpTdz b
    *     Where a.Dopes = '<dopes>' And a.Tabds = b.Codigos
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.tabds, b.descrs" + ;
                       " FROM SigOpTdo a" + ;
                       " INNER JOIN SigOpTdz b ON a.tabds = b.codigos"

            IF VARTYPE(par_cDopes) = "C" AND !EMPTY(par_cDopes)
                loc_cSQL = loc_cSQL + ;
                    " WHERE a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.tabds"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT registro por chave primaria (cidchaves) + JOIN descrs
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.tabds, b.descrs" + ;
                       " FROM SigOpTdo a" + ;
                       " INNER JOIN SigOpTdz b ON a.tabds = b.codigos" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = ALLTRIM(TratarNulo(cidchaves, "C"))
                THIS.this_cDopes     = ALLTRIM(TratarNulo(dopes, "C"))
                THIS.this_cTabds     = ALLTRIM(TratarNulo(tabds, "C"))
                *-- descrs so existe quando o SELECT fez JOIN com SigOpTdz (Buscar/CarregarPorCodigo)
                IF TYPE("descrs") = "C"
                    THIS.this_cDescrs = ALLTRIM(TratarNulo(descrs, "C"))
                ELSE
                    THIS.this_cDescrs = ""
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigOpTdo (todas colunas NOT NULL preenchidas)
    * Gera cidchaves automaticamente (equivalente a fUniqueIds() do legado) se
    * ainda nao tiver sido atribuido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpTdo" + ;
                       " (cidchaves, dopes, tabds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       EscaparSQL(THIS.this_cTabds) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                THIS.this_lHouveInsercao = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigOpTdo (dopes/tabds) WHERE cidchaves = chave
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpTdo SET" + ;
                       " dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " tabds = " + EscaparSQL(THIS.this_cTabds) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigOpTdo WHERE cidchaves = chave
    * (Chamado PUBLICAMENTE via THIS.Excluir(), nunca direto - CLAUDE.md regra BO)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpTdo WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                THIS.this_lHouveExclusao = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteVinculoDuplicado - Verifica se a Tabela de Desconto ja esta
    * vinculada a esta Operacao em OUTRO registro. Equivale a validacao de
    * duplicidade de Tabds por Dopes do cmdSair.Click do legado (que escaneava
    * toda a LocalTabdO em memoria antes de gravar em lote); aqui e aplicada no
    * momento do Salvar de cada vinculo individual (par_cCidChavesAtual exclui
    * o proprio registro em edicao, para nao se autoacusar de duplicidade).
    *--------------------------------------------------------------------------
    FUNCTION ExisteVinculoDuplicado(par_cDopes, par_cTabds, par_cCidChavesAtual)
        LOCAL loc_lExiste, loc_cSQL, loc_nResultado
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigOpTdo" + ;
                       " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                       " AND tabds = " + EscaparSQL(ALLTRIM(par_cTabds))

            IF VARTYPE(par_cCidChavesAtual) = "C" AND !EMPTY(par_cCidChavesAtual)
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(ALLTRIM(par_cCidChavesAtual))
            ENDIF

            IF USED("cursor_4c_DupVinc")
                USE IN cursor_4c_DupVinc
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupVinc")
            IF loc_nResultado >= 0
                loc_lExiste = (RECCOUNT("cursor_4c_DupVinc") > 0)
            ELSE
                MsgErro("Erro ao verificar duplicidade do v" + CHR(237) + "nculo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DupVinc")
                USE IN cursor_4c_DupVinc
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ExisteVinculoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarTabelaDescontoDuplicada - Verifica se ha Tabds repetido para a mesma
    * operacao (equivalente ao "Select Tabds,sum(1) as TT ... GROUP by 1 ... TT>1"
    * do cmdSair.Click do legado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarTabelaDescontoDuplicada(par_cDopes)
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResultado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT tabds, COUNT(*) AS Total FROM SigOpTdo" + ;
                       " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                       " GROUP BY tabds HAVING COUNT(*) > 1"

            IF USED("cursor_4c_DupChk")
                TABLEREVERT(.T., "cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_DupChk") > 0
                    loc_lDuplicado = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ValidarTabelaDescontoDuplicada:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

ENDDEFINE

