# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 191: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 216: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSed.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (801 linhas total):

*-- Linhas 8 a 26:
8: *   - DEFINE CLASS + propriedades visuais
9: *   - Init / InicializarForm / Destroy
10: *   - ConfigurarCabecalho (cnt_4c_Cabecalho + labels sombra/titulo)
11: *   - ConfigurarBotoesAcao (cmd_4c_Cmdprocessar "Gerar" + cmd_4c_Sair "Encerrar")
12: *   - ConfigurarPaginaLista (filtros faixa inicial/final + grid 5 colunas + botao Excluir)
13: *   - CarregarDados (chama SedBO.CarregarSedex + vincula cursor ao grid, Pattern #180)
14: *   - Handlers: cmd_4c_CmdprocessarClick / cmd_4c_SairClick / cmd_4c_ExcluirClick
15: *   - TornarControlesVisiveis recursivo (form flat, sem containers flutuantes)
16: *   - Integrado no menu.prg: popMovimentos BAR 121 -> AbrirFormSed()
17: *   - Fase 6: Form plano sem Page2/lookups. LockScreen em exclusao (fidelidade UX).
18: *             Refresh() explicito no grid apos rebinding. Implementacao COMPLETA.
19: *   - Fase 7: Interface publica Btn*Click para controle de modo pelo wrapper
20: *             (equivalente ao pcEscolha legado). BtnExcluirClick delega para
21: *             cmd_4c_ExcluirClick que ja tem a logica completa.
22: *
23: * Layout OPERACIONAL flat (600x400 legado -> 1000x600 sistema novo).
24: * Nao usa PageFrame Lista/Dados do padrao CRUD.
25: *==============================================================================
26: 

*-- Linhas 92 a 102:
92:             THIS.ConfigurarBotoesAcao()
93:             THIS.ConfigurarPaginaLista()
94: 
95:             BINDEVENT(THIS.cmd_4c_Cmdprocessar, "Click", THIS, "cmd_4c_CmdprocessarClick")
96:             BINDEVENT(THIS.cmd_4c_Sair,         "Click", THIS, "cmd_4c_SairClick")
97:             BINDEVENT(THIS.cmd_4c_Excluir,      "Click", THIS, "cmd_4c_ExcluirClick")
98: 
99:             THIS.TornarControlesVisiveis(THIS)
100: 
101:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
102:                 THIS.CarregarDados()

*-- Linhas 122 a 197:
122:     PROTECTED PROCEDURE ConfigurarCabecalho()
123:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
124:         WITH THIS.cnt_4c_Cabecalho
125:             .Top         = 0
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BackStyle   = 1
130:             .BackColor   = RGB(100, 100, 100)
131:             .BorderWidth = 0
132:             .Visible     = .T.
133:         ENDWITH
134: 
135:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblSombra", "Label")
136:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra
137:             .Top        = 18
138:             .Left       = 10
139:             .Width      = THIS.Width - 20
140:             .Height     = 40
141:             .FontName   = "Tahoma"
142:             .FontSize   = 18
143:             .FontBold   = .T.
144:             .ForeColor  = RGB(0, 0, 0)
145:             .BackStyle  = 0
146:             .WordWrap   = .T.
147:             .AutoSize   = .F.
148:             .Caption    = "Etiquetas de Sedex"
149:             .Visible    = .T.
150:         ENDWITH
151: 
152:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblTitulo", "Label")
153:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo
154:             .Top        = 17
155:             .Left       = 10
156:             .Width      = THIS.Width - 20
157:             .Height     = 46
158:             .FontName   = "Tahoma"
159:             .FontSize   = 18
160:             .FontBold   = .T.
161:             .ForeColor  = RGB(255, 255, 255)
162:             .BackStyle  = 0
163:             .WordWrap   = .T.
164:             .AutoSize   = .F.
165:             .Caption    = "Etiquetas de Sedex"
166:             .Visible    = .T.
167:         ENDWITH
168:     ENDPROC
169: 
170:     *==========================================================================
171:     * ConfigurarBotoesAcao - Botoes Gerar e Encerrar (canto superior direito)
172:     * Layout proporcional 600->1000 (originais Left=450 e Left=525):
173:     *   cmd_4c_Cmdprocessar (Gerar)   : Left=750
174:     *   cmd_4c_Sair          (Encerrar): Left=875 (Cancel=.T. p/ ESC)
175:     * Gerar so habilitado em INSERIR/ALTERAR
176:     *==========================================================================
177:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
178:         LOCAL loc_lModoHabilita
179: 
180:         loc_lModoHabilita = INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
181: 
182:         THIS.AddObject("cmd_4c_Cmdprocessar", "CommandButton")
183:         WITH THIS.cmd_4c_Cmdprocessar
184:             .Top             = 3
185:             .Left            = 750
186:             .Width           = 75
187:             .Height          = 75
188:             .Caption         = "Gerar"
189:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
190:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
191:             .FontName        = "Comic Sans MS"
192:             .FontBold        = .T.
193:             .FontItalic      = .T.
194:             .FontSize        = 8
195:             .ForeColor       = RGB(90, 90, 90)
196:             .BackColor       = RGB(255, 255, 255)
197:             .Themes          = .T.

*-- Linhas 203 a 222:
203:             .Visible         = .T.
204:         ENDWITH
205: 
206:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
207:         WITH THIS.cmd_4c_Sair
208:             .Top             = 3
209:             .Left            = 875
210:             .Width           = 75
211:             .Height          = 75
212:             .Caption         = "Encerrar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
214:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
215:             .Cancel          = .T.
216:             .FontName        = "Comic Sans MS"
217:             .FontBold        = .T.
218:             .FontItalic      = .T.
219:             .FontSize        = 8
220:             .ForeColor       = RGB(90, 90, 90)
221:             .BackColor       = RGB(255, 255, 255)
222:             .Themes          = .T.

*-- Linhas 272 a 311:
272:     *==========================================================================
273:     * ConfigurarPaginaLista - Monta area de filtros, grid e botao Excluir
274:     * Form OPERACIONAL flat (sem PageFrame): todo o conteudo vai direto no form.
275:     * Filtros:  lbl_4c_LblFaixa, txt_4c_Faixainicial, lbl_4c_LblAte, txt_4c_Faixafinal
276:     * Grid:     grd_4c_Dados (5 colunas: DtIncs|FaixaInis|FaixaFins|nLivres|nUsadas)
277:     * Botao:    cmd_4c_Excluir (icone-only, direita do grid)
278:     * Escalado de 600x400 (original) para 1000x600 (novo padrao)
279:     *==========================================================================
280:     PROTECTED PROCEDURE ConfigurarPaginaLista()
281:         LOCAL loc_lModoHabilita
282: 
283:         loc_lModoHabilita = INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
284: 
285:         *-- Label "Faixa:"
286:         THIS.AddObject("lbl_4c_LblFaixa", "Label")
287:         WITH THIS.lbl_4c_LblFaixa
288:             .Top       = 101
289:             .Left      = 12
290:             .Width     = 58
291:             .Height    = 15
292:             .FontName  = "Tahoma"
293:             .FontSize  = 8
294:             .Alignment = 0
295:             .BackStyle = 0
296:             .Caption   = "Faixa :"
297:             .ForeColor = RGB(90, 90, 90)
298:             .AutoSize  = .F.
299:             .Visible   = .T.
300:         ENDWITH
301: 
302:         *-- TextBox faixa inicial (MaxLength=14, Format="K!" converte para maiusculo)
303:         THIS.AddObject("txt_4c_Faixainicial", "TextBox")
304:         WITH THIS.txt_4c_Faixainicial
305:             .Top           = 97
306:             .Left          = 74
307:             .Width         = 180
308:             .Height        = 22
309:             .FontName      = "Tahoma"
310:             .FontSize      = 8
311:             .Alignment     = 0

*-- Linhas 324 a 352:
324:         ENDWITH
325: 
326:         *-- Label "ate"
327:         THIS.AddObject("lbl_4c_LblAte", "Label")
328:         WITH THIS.lbl_4c_LblAte
329:             .Top       = 101
330:             .Left      = 260
331:             .Width     = 30
332:             .Height    = 15
333:             .FontName  = "Tahoma"
334:             .FontSize  = 8
335:             .Alignment = 0
336:             .BackStyle = 0
337:             .Caption   = "at" + CHR(233)
338:             .ForeColor = RGB(90, 90, 90)
339:             .AutoSize  = .F.
340:             .Visible   = .T.
341:         ENDWITH
342: 
343:         *-- TextBox faixa final (mesmas propriedades da inicial)
344:         THIS.AddObject("txt_4c_Faixafinal", "TextBox")
345:         WITH THIS.txt_4c_Faixafinal
346:             .Top           = 97
347:             .Left          = 295
348:             .Width         = 180
349:             .Height        = 23
350:             .FontName      = "Tahoma"
351:             .FontSize      = 8
352:             .Alignment     = 0

*-- Linhas 365 a 379:
365:         ENDWITH
366: 
367:         *-- Botao Excluir (icone-only, posicionado a direita do grid - nunca .Enabled=.F.)
368:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
369:         WITH THIS.cmd_4c_Excluir
370:             .Top             = 335
371:             .Left            = 867
372:             .Width           = 75
373:             .Height          = 75
374:             .Caption         = ""
375:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
376:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
377:             .ToolTipText     = "Excluir"
378:             .FontName        = "Verdana"
379:             .FontBold        = .T.

*-- Linhas 390 a 399:
390:         *-- Grid principal (escalado: original Left=35 W=482 H=254 -> novo Left=12 W=860 H=440)
391:         THIS.AddObject("grd_4c_Dados", "Grid")
392:         WITH THIS.grd_4c_Dados
393:             .Top                = 130
394:             .Left               = 12
395:             .Width              = 860
396:             .Height             = 440
397:             .ColumnCount        = 5
398:             .FontName           = "Verdana"
399:             .FontSize           = 8

*-- Linhas 419 a 427:
419:                     .FontName  = "Tahoma"
420:                     .FontSize  = 8
421:                     .Alignment = 2
422:                     .Caption   = "Data Inclus" + CHR(227) + "o"
423:                 ENDWITH
424:                 WITH .Text1
425:                     .BorderStyle = 0
426:                     .Margin      = 0
427:                     .ReadOnly    = .T.

*-- Linhas 440 a 448:
440:                     .FontName  = "Tahoma"
441:                     .FontSize  = 8
442:                     .Alignment = 2
443:                     .Caption   = "Faixa Inicial"
444:                 ENDWITH
445:                 WITH .Text1
446:                     .BorderStyle = 0
447:                     .Margin      = 0
448:                     .ReadOnly    = .T.

*-- Linhas 461 a 469:
461:                     .FontName  = "Tahoma"
462:                     .FontSize  = 8
463:                     .Alignment = 2
464:                     .Caption   = "Faixa Final"
465:                 ENDWITH
466:                 WITH .Text1
467:                     .BorderStyle = 0
468:                     .Margin      = 0
469:                     .ReadOnly    = .T.

*-- Linhas 482 a 490:
482:                     .FontName  = "Tahoma"
483:                     .FontSize  = 8
484:                     .Alignment = 2
485:                     .Caption   = "Livres"
486:                 ENDWITH
487:                 WITH .Text1
488:                     .BorderStyle = 0
489:                     .Margin      = 0
490:                     .ReadOnly    = .T.

*-- Linhas 503 a 511:
503:                     .FontName  = "Tahoma"
504:                     .FontSize  = 8
505:                     .Alignment = 2
506:                     .Caption   = "Usadas"
507:                 ENDWITH
508:                 WITH .Text1
509:                     .BorderStyle = 0
510:                     .Margin      = 0
511:                     .ReadOnly    = .T.

*-- Linhas 542 a 558:
542: 
543:                 *-- Re-configurar apos troca de RecordSource (Pattern #180 / Problema 48)
544:                 loc_oGrid.Column1.Width           = 200
545:                 loc_oGrid.Column1.Header1.Caption = "Faixa Inicial"
546:                 loc_oGrid.Column2.Width           = 200
547:                 loc_oGrid.Column2.Header1.Caption = "Faixa Final"
548:                 loc_oGrid.Column3.Width           = 150
549:                 loc_oGrid.Column3.Header1.Caption = "Livres"
550:                 loc_oGrid.Column4.Width           = 150
551:                 loc_oGrid.Column4.Header1.Caption = "Usadas"
552:                 loc_oGrid.Column5.Width           = 160
553:                 loc_oGrid.Column5.Header1.Caption = "Data Inclus" + CHR(227) + "o"
554: 
555:                 loc_oGrid.Refresh()
556: 
557:                 loc_lSucesso = .T.
558:             ENDIF

*-- Linhas 587 a 598:
587:     ENDPROC
588: 
589:     *==========================================================================
590:     * cmd_4c_CmdprocessarClick - Handler do botao Gerar
591:     * Valida faixas, chama GerarEtiquetas no BO e recarrega grid
592:     *==========================================================================
593:     PROCEDURE cmd_4c_CmdprocessarClick()
594:         LOCAL loc_lSucesso, loc_cFaixaIni, loc_cFaixaFin
595: 
596:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
597:             RETURN
598:         ENDIF

*-- Linhas 614 a 633:
614:     ENDPROC
615: 
616:     *==========================================================================
617:     * cmd_4c_SairClick - Handler do botao Encerrar
618:     *==========================================================================
619:     PROCEDURE cmd_4c_SairClick()
620:         THIS.Release()
621:     ENDPROC
622: 
623:     *==========================================================================
624:     * cmd_4c_ExcluirClick - Handler do botao Excluir
625:     * Le FaixaInis e nUsadas do registro corrente no cursor e chama ExcluirFaixa.
626:     * LockScreen durante delete + reload evita flickering (fidelidade ao legado).
627:     *==========================================================================
628:     PROCEDURE cmd_4c_ExcluirClick()
629:         LOCAL loc_cFaixaIni, loc_nUsadas
630: 
631:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
632:             RETURN
633:         ENDIF

*-- Linhas 666 a 730:
666:         THIS.txt_4c_Faixafinal.Value     = ""
667:         THIS.txt_4c_Faixainicial.Enabled = .T.
668:         THIS.txt_4c_Faixafinal.Enabled   = .T.
669:         THIS.cmd_4c_Cmdprocessar.Enabled = .T.
670:         THIS.txt_4c_Faixainicial.SetFocus()
671:     ENDPROC
672: 
673:     *==========================================================================
674:     * BtnAlterarClick - Configura form para modo ALTERAR habilitando controles
675:     * Interface publica equivalente a pcEscolha='ALTERAR' no wrapper legado.
676:     *==========================================================================
677:     PROCEDURE BtnAlterarClick()
678:         THIS.this_cModoAtual = "ALTERAR"
679:         THIS.txt_4c_Faixainicial.Enabled = .T.
680:         THIS.txt_4c_Faixafinal.Enabled   = .T.
681:         THIS.cmd_4c_Cmdprocessar.Enabled = .T.
682:         THIS.txt_4c_Faixainicial.SetFocus()
683:     ENDPROC
684: 
685:     *==========================================================================
686:     * BtnVisualizarClick - Configura form para modo VISUALIZAR (somente leitura)
687:     * Interface publica equivalente a pcEscolha='VISUALIZAR' no wrapper legado.
688:     *==========================================================================
689:     PROCEDURE BtnVisualizarClick()
690:         THIS.this_cModoAtual = "VISUALIZAR"
691:         THIS.txt_4c_Faixainicial.Enabled = .F.
692:         THIS.txt_4c_Faixafinal.Enabled   = .F.
693:         THIS.cmd_4c_Cmdprocessar.Enabled = .F.
694:     ENDPROC
695: 
696:     *==========================================================================
697:     * BtnExcluirClick - Dispara exclusao da faixa selecionada no grid
698:     * Delega para cmd_4c_ExcluirClick que tem a logica completa com validacao
699:     * de nUsadas > 0 e chamada ao BO.ExcluirFaixa.
700:     *==========================================================================
701:     PROCEDURE BtnExcluirClick()
702:         THIS.cmd_4c_ExcluirClick()
703:     ENDPROC
704: 
705:     *==========================================================================
706:     * BtnBuscarClick - Recarrega grid com dados atuais da empresa
707:     *==========================================================================
708:     PROCEDURE BtnBuscarClick()
709:         THIS.CarregarDados()
710:     ENDPROC
711: 
712:     *==========================================================================
713:     * BtnEncerrarClick - Fecha o formulario (alias publico para cmd_4c_SairClick)
714:     *==========================================================================
715:     PROCEDURE BtnEncerrarClick()
716:         THIS.cmd_4c_SairClick()
717:     ENDPROC
718: 
719:     *==========================================================================
720:     * BtnSalvarClick - Executa geracao de etiquetas (alias publico para "Gerar")
721:     * Mapeia a acao "Salvar" do padrao CRUD para "GerarEtiquetas" deste form
722:     * operacional.
723:     *==========================================================================
724:     PROCEDURE BtnSalvarClick()
725:         THIS.cmd_4c_CmdprocessarClick()
726:     ENDPROC
727: 
728:     *==========================================================================
729:     * BtnCancelarClick - Cancela operacao atual: limpa campos de faixa
730:     * e retorna foco para o primeiro campo editavel.

*-- Linhas 763 a 771:
763: 
764:         THIS.txt_4c_Faixainicial.Enabled = loc_lEdit
765:         THIS.txt_4c_Faixafinal.Enabled   = loc_lEdit
766:         THIS.cmd_4c_Cmdprocessar.Enabled = loc_lEdit
767:     ENDPROC
768: 
769:     *==========================================================================
770:     * LimparCampos - Limpa os campos de faixa inicial e final
771:     *==========================================================================

*-- Linhas 795 a 801:
795: 
796:         THIS.HabilitarCampos(loc_lModoEdicao)
797: 
798:         THIS.cmd_4c_Excluir.Visible = loc_lModoEdicao
799:     ENDPROC
800: 
801: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SedBO.prg):
*==============================================================================
* SedBO.prg - Business Object para Etiquetas de Sedex (SigCdSed)
* Herda de: BusinessBase
* Tabela principal: SigCdSed
* PK: cBarSedexs char(16)
*==============================================================================

DEFINE CLASS SedBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdSed
    *--------------------------------------------------------------------------
    this_cBarSedexs  = ""   && char(16) - codigo de barras sedex (PK)
    this_cEmps       = ""   && char(3)  - codigo empresa
    this_dDtIncs     = {}   && datetime - data inclusao
    this_dDtUsos     = {}   && datetime - data uso da etiqueta
    this_cEmpDopNums = ""   && char(29) - numero DOP/protocolo ('' = livre)
    this_cFaixaFins  = ""   && char(14) - faixa final da geracao
    this_cFaixaInis  = ""   && char(14) - faixa inicial da geracao
    this_nNumEtiqs   = 0    && numeric(8,0) - numero sequencial da etiqueta
    this_nImpress    = 0    && numeric(1,0) - flag impresso

    *--------------------------------------------------------------------------
    * Configuracao do BusinessBase
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdSed"
    this_cCampoChave = "cBarSedexs"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    FUNCTION Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cBarSedexs)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAlias)
        IF USED(par_cAlias)
            SELECT (par_cAlias)
            THIS.this_cBarSedexs  = TratarNulo(cBarSedexs,  "C")
            THIS.this_cEmps       = TratarNulo(cEmps,       "C")
            THIS.this_cFaixaInis  = TratarNulo(FaixaInis,   "C")
            THIS.this_cFaixaFins  = TratarNulo(FaixaFins,   "C")
            THIS.this_nNumEtiqs   = TratarNulo(nNumEtiqs,   "N")
            THIS.this_cEmpDopNums = TratarNulo(EmpDopNums,  "C")
            THIS.this_nImpress    = TratarNulo(nImpress,    "N")
            THIS.this_dDtIncs     = TratarNulo(DtIncs,      "D")
            THIS.this_dDtUsos     = TratarNulo(DtUsos,      "D")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSedex - Carrega cursor_4c_Sedex com dados agrupados por faixa
    * Equivalente ao SELECT do Init legado
    *--------------------------------------------------------------------------
    FUNCTION CarregarSedex(par_cEmps)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Sedex")
                USE IN cursor_4c_Sedex
            ENDIF

            loc_cSQL = "SELECT DtIncs, FaixaInis, FaixaFins, " + ;
                       "SUM(CASE WHEN ISNULL(EmpDopNums,'') = '' THEN 0 ELSE 1 END) AS nUsadas, " + ;
                       "SUM(CASE WHEN ISNULL(EmpDopNums,'') <> '' THEN 0 ELSE 1 END) AS nLivres " + ;
                       "FROM SigCdSed " + ;
                       "WHERE cEmps = " + EscaparSQL(par_cEmps) + " " + ;
                       "GROUP BY DtIncs, FaixaInis, FaixaFins " + ;
                       "ORDER BY DtIncs, FaixaInis, FaixaFins"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sedex")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar etiquetas de Sedex." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.CarregarSedex")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarEtiquetas - Gera etiquetas de Sedex para a faixa informada
    * Equivalente ao cmdprocessar.Click legado
    *--------------------------------------------------------------------------
    FUNCTION GerarEtiquetas(par_cFaixaIni, par_cFaixaFin, par_cEmps)
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_nFaixaIni, loc_nFaixaFin, loc_nX
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cBarEtiq, loc_cServico, loc_cPais
        LOCAL loc_cSeqPadded

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- Extrair numeros sequenciais das faixas (8 digitos numericos)
            loc_nFaixaIni = VAL(THIS.ExtrairNumericos(par_cFaixaIni))
            loc_nFaixaFin = VAL(THIS.ExtrairNumericos(par_cFaixaFin))

            IF loc_nFaixaIni = 0 OR loc_nFaixaFin = 0
                MsgAviso("Faixa inicial e final s" + CHR(227) + "o obrigat" + CHR(243) + "rias.", "Aviso")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND loc_nFaixaFin < loc_nFaixaIni
                MsgAviso("Faixa final deve ser maior ou igual " + CHR(224) + " faixa inicial.", "Aviso")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Verificar se ja existem etiquetas na faixa
                loc_cSQL = "SELECT cBarSedexs FROM SigCdSed " + ;
                           "WHERE nNumEtiqs BETWEEN " + TRANSFORM(loc_nFaixaIni) + ;
                           " AND " + TRANSFORM(loc_nFaixaFin) + ;
                           " AND cEmps = " + EscaparSQL(par_cEmps)

                IF USED("cursor_4c_SedVerif")
                    USE IN cursor_4c_SedVerif
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SedVerif")

                IF loc_nResult <= 0
                    MsgErro("Erro ao verificar etiquetas existentes." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF !EOF("cursor_4c_SedVerif")
                    MsgAviso("J" + CHR(225) + " existe etiquetas geradas na faixa informada.", "Aviso")
                    loc_lContinuar = .F.
                ENDIF

                IF USED("cursor_4c_SedVerif")
                    USE IN cursor_4c_SedVerif
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Servico (2 primeiros chars) e pais (2 ultimos chars da faixa de 14)
                loc_cServico = SUBSTR(par_cFaixaIni, 1, 2)
                loc_cPais    = SUBSTR(par_cFaixaIni, 13, 2)

                *-- Gerar uma etiqueta por numero sequencial
                loc_nX = loc_nFaixaIni
                DO WHILE loc_lContinuar AND loc_nX <= loc_nFaixaFin
                    loc_cSeqPadded = PADL(TRANSFORM(loc_nX), 8, "0")
                    loc_cBarEtiq   = THIS.CalcularBarraSedex(loc_cServico + loc_cSeqPadded + loc_cPais)

                    loc_cSQL = "INSERT INTO SigCdSed " + ;
                               "(cEmps, DtIncs, nNumEtiqs, FaixaInis, FaixaFins, cBarSedexs, EmpDopNums) " + ;
                               "VALUES (" + ;
                               EscaparSQL(par_cEmps) + ", GETDATE(), " + ;
                               FormatarNumeroSQL(loc_nX, 0) + ", " + ;
                               EscaparSQL(par_cFaixaIni) + ", " + ;
                               EscaparSQL(par_cFaixaFin) + ", " + ;
                               EscaparSQL(loc_cBarEtiq) + ", " + ;
                               EscaparSQL("") + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResult <= 0
                        MsgErro("Erro ao inserir etiqueta " + TRANSFORM(loc_nX) + "." + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lContinuar = .F.
                    ELSE
                        loc_nX = loc_nX + 1
                    ENDIF
                ENDDO

                IF loc_lContinuar
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.GerarEtiquetas")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirFaixa - Exclui todas as etiquetas de uma faixa do SQL Server
    * Equivalente ao excluir.Click legado
    * par_nUsadas: numero de etiquetas ja usadas (0 = pode excluir)
    *--------------------------------------------------------------------------
    FUNCTION ExcluirFaixa(par_cFaixaIni, par_cEmps, par_nUsadas)
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            IF par_nUsadas > 0
                MsgAviso("Etiquetas j" + CHR(225) + " usadas na faixa selecionada. " + ;
                         "N" + CHR(227) + "o " + CHR(233) + " permitido exclus" + CHR(227) + "o.", ;
                         "Aviso")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_cSQL = "DELETE FROM SigCdSed " + ;
                           "WHERE cEmps = " + EscaparSQL(par_cEmps) + ;
                           " AND FaixaInis = " + EscaparSQL(par_cFaixaIni)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult <= 0
                    MsgErro("Erro ao excluir etiquetas da faixa." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.ExcluirFaixa")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida propriedades do BO antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_cBarSedexs)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de barras Sedex " + CHR(233) + " obrigat" + CHR(243) + "rio."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cEmps)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cFaixaInis)
            THIS.this_cMensagemErro = "Faixa inicial " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cFaixaFins)
            THIS.this_cMensagemErro = "Faixa final " + CHR(233) + " obrigat" + CHR(243) + "ria."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um novo registro na tabela SigCdSed
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdSed
                    (cBarSedexs, cEmps, DtIncs, DtUsos, EmpDopNums,
                     FaixaFins, FaixaInis, nNumEtiqs, nImpress)
                VALUES (
                    <<EscaparSQL(THIS.this_cBarSedexs)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    GETDATE(),
                    <<FormatarDataSQL(THIS.this_dDtUsos)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<EscaparSQL(THIS.this_cFaixaFins)>>,
                    <<EscaparSQL(THIS.this_cFaixaInis)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumEtiqs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nImpress, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir etiqueta Sedex: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um registro existente na tabela SigCdSed
    * Uso tipico: marcar etiqueta como usada (preencher EmpDopNums/DtUsos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdSed
                SET cEmps      = <<EscaparSQL(THIS.this_cEmps)>>,
                    DtUsos     = <<FormatarDataSQL(THIS.this_dDtUsos)>>,
                    EmpDopNums = <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    FaixaFins  = <<EscaparSQL(THIS.this_cFaixaFins)>>,
                    FaixaInis  = <<EscaparSQL(THIS.this_cFaixaInis)>>,
                    nNumEtiqs  = <<FormatarNumeroSQL(THIS.this_nNumEtiqs, 0)>>,
                    nImpress   = <<FormatarNumeroSQL(THIS.this_nImpress, 0)>>
                WHERE cBarSedexs = <<EscaparSQL(THIS.this_cBarSedexs)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar etiqueta Sedex: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui um registro da tabela SigCdSed pela PK
    * Guard: nao permite excluir etiqueta ja usada (EmpDopNums preenchido)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro, loc_lUsada

        loc_lSucesso = .F.
        loc_lUsada   = .F.

        TRY
            *-- Verificar se a etiqueta ja foi usada
            loc_cSQL = "SELECT EmpDopNums FROM SigCdSed " + ;
                       "WHERE cBarSedexs = " + EscaparSQL(THIS.this_cBarSedexs)

            IF USED("cursor_4c_SedChk")
                USE IN cursor_4c_SedChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SedChk")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao verificar etiqueta: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                IF USED("cursor_4c_SedChk") AND !EOF("cursor_4c_SedChk")
                    loc_lUsada = !EMPTY(NVL(cursor_4c_SedChk.EmpDopNums, ""))
                ENDIF

                IF USED("cursor_4c_SedChk")
                    USE IN cursor_4c_SedChk
                ENDIF

                IF loc_lUsada
                    THIS.this_cMensagemErro = "Etiqueta j" + CHR(225) + " utilizada. N" + CHR(227) + "o " + CHR(233) + " permitido exclus" + CHR(227) + "o."
                    MsgAviso(THIS.this_cMensagemErro, "Aviso")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdSed " + ;
                               "WHERE cBarSedexs = " + EscaparSQL(THIS.this_cBarSedexs)

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao excluir etiqueta Sedex: " + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SedBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExtrairNumericos - Extrai apenas os digitos numericos de uma string
    * Equivalente a fSubstTxt(str, "", "N") do framework legado
    * Retorna os 8 primeiros digitos (numero sequencial da faixa)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExtrairNumericos(par_cTexto)
        LOCAL loc_cResultado, loc_i, loc_cChar

        loc_cResultado = ""

        FOR loc_i = 1 TO LEN(ALLTRIM(par_cTexto))
            loc_cChar = SUBSTR(par_cTexto, loc_i, 1)
            IF ISDIGIT(loc_cChar)
                loc_cResultado = loc_cResultado + loc_cChar
            ENDIF
        ENDFOR

        RETURN SUBSTR(loc_cResultado, 1, 8)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularBarraSedex - Calcula codigo de barras Sedex com digito verificador
    * Equivalente a fBarSedex() do framework legado (Correios Modulo-11)
    * par_cCodigo: 12 chars - Servico(2) + Sequencial(8) + Pais(2)
    * Retorna: 13 chars - Servico(2) + Sequencial(8) + Digito(1) + Pais(2)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CalcularBarraSedex(par_cCodigo)
        LOCAL loc_cServico, loc_cSequencial, loc_cPais
        LOCAL loc_nSoma, loc_nResto, loc_nDigito, loc_i
        LOCAL loc_aPesos[8]

        loc_cServico    = SUBSTR(par_cCodigo, 1, 2)
        loc_cSequencial = SUBSTR(par_cCodigo, 3, 8)
        loc_cPais       = SUBSTR(par_cCodigo, 11, 2)

        *-- Pesos Correios Modulo-11 para Sedex/PAC
        loc_aPesos[1] = 8
        loc_aPesos[2] = 6
        loc_aPesos[3] = 4
        loc_aPesos[4] = 2
        loc_aPesos[5] = 3
        loc_aPesos[6] = 9
        loc_aPesos[7] = 7
        loc_aPesos[8] = 5

        loc_nSoma = 0
        FOR loc_i = 1 TO 8
            loc_nSoma = loc_nSoma + (VAL(SUBSTR(loc_cSequencial, loc_i, 1)) * loc_aPesos[loc_i])
        ENDFOR

        loc_nResto = MOD(loc_nSoma, 11)

        DO CASE
            CASE loc_nResto = 0
                loc_nDigito = 5
            CASE loc_nResto = 1
                loc_nDigito = 0
            OTHERWISE
                loc_nDigito = 11 - loc_nResto
        ENDCASE

        RETURN loc_cServico + loc_cSequencial + TRANSFORM(loc_nDigito) + loc_cPais
    ENDFUNC

ENDDEFINE

