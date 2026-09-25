# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'excluir' (parent: SIGMVATE): Left original=523 vs migrado 'cmd_4c_Excluir' Left=230 (diff=293px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvAte.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1257 linhas total):

*-- Linhas 12 a 32:
12: * Historico de fases:
13: *   Fase 1/2: SigMvAteBO.prg (propriedades + CRUD completo)
14: *   Fase 3:   FormSigMvAte.prg - estrutura base (Init, InicializarForm,
15: *             ConfigurarPageFrame/ConfigurarCabecalho, TornarControlesVisiveis,
16: *             Destroy). Grade + cmg_4c_Botoes (Confirmar/Cancelar) +
17: *             cmd_4c_Incluir + cmd_4c_Excluir ficam para a Fase 4.
18: *==============================================================================
19: DEFINE CLASS FormSigMvAte AS FormBase
20: 
21:     *-- Parametros de entrada recebidos no Init (contexto do documento pai
22:     *-- SigMvCab, equivalente a TprMvCab/pcEscolha do legado)
23:     this_cEmpDopNums  = ""   && empdopnums do documento pai - FK dos atendimentos
24:     this_cEmps        = ""   && empresa do documento pai
25:     this_cGrVends     = ""   && grupo de vendedores aceito (grvends do SigMvCab) - usado no lookup fAcessoContas
26:     this_cModoEscolha = ""   && modo do documento pai: INSERIR/ALTERAR/CONSULTAR - habilita/desabilita Incluir/Excluir na Fase 4
27: 
28:     *-- Business Object
29:     this_oBusinessObject = .NULL.
30: 
31:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGMVATE)
32:     Width        = 618

*-- Linhas 92 a 100:
92:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
93: 
94:             *-- Caption identico ao legado (sem acentos - dispensa CHR())
95:             THIS.Caption = "Registra os atendimentos dos vendedores"
96: 
97:             *-- Cursor placeholder da grade (READWRITE por natureza - CREATE
98:             *-- CURSOR sempre eh atualizavel). Precisa existir ANTES de
99:             *-- ConfigurarPageFrame (RecordSource do grid). A ORDEM dos campos
100:             *-- tem de ser IDENTICA a SigMvAteBO.CarregarAtendimentosDocumento.

*-- Linhas 109 a 118:
109:             THIS.ConfigurarPageFrame()
110: 
111:             *-- Propaga o titulo para os labels do cabecalho
112:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
113:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
114: 
115:             *-- Carrega os atendimentos ja gravados para o documento
116:             *-- (sem conexao em modo de teste de UI)
117:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
118:                 THIS.CarregarLista()

*-- Linhas 154 a 202:
154:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
155:         loc_oCab = THIS.cnt_4c_Cabecalho
156:         WITH loc_oCab
157:             .Top         = 0
158:             .Left        = 0
159:             .Width       = THIS.Width
160:             .Height      = 80
161:             .BorderWidth = 0
162:             .BackStyle   = 1
163:             .BackColor   = RGB(100, 100, 100)
164:         ENDWITH
165: 
166:         *-- Labels adicionados FORA do WITH do container: WITH aninhado com
167:         *-- AddObject ignora propriedades silenciosamente (CLAUDE.md #33)
168:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
169:         WITH loc_oCab.lbl_4c_Sombra
170:             .FontBold  = .T.
171:             .FontName  = "Tahoma"
172:             .FontSize  = 18
173:             .WordWrap  = .T.
174:             .AutoSize  = .F.
175:             .Alignment = 0
176:             .BackStyle = 0
177:             .Caption   = ""
178:             .Height    = 40
179:             .Left      = 10
180:             .Top       = 18
181:             .Width     = 769
182:             .ForeColor = RGB(0, 0, 0)
183:         ENDWITH
184: 
185:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
186:         WITH loc_oCab.lbl_4c_Titulo
187:             .FontBold  = .T.
188:             .FontName  = "Tahoma"
189:             .FontSize  = 18
190:             .WordWrap  = .T.
191:             .AutoSize  = .F.
192:             .Alignment = 0
193:             .BackStyle = 0
194:             .Caption   = ""
195:             .Height    = 46
196:             .Left      = 10
197:             .Top       = 17
198:             .Width     = 769
199:             .ForeColor = RGB(255, 255, 255)
200:         ENDWITH
201:     ENDPROC
202: 

*-- Linhas 215 a 268:
215:             THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
216:             loc_oCmg = THIS.cmg_4c_Botoes
217:             WITH loc_oCmg
218:                 .Top           = -2
219:                 .Left          = 462
220:                 .Width         = 160
221:                 .Height        = 85
222:                 .ButtonCount   = 2
223:                 .AutoSize      = .T.
224:                 .BackStyle     = 0
225:                 .BorderStyle   = 0
226:                 .SpecialEffect = 1
227:                 .BorderColor   = RGB(136, 189, 188)
228:                 .Themes        = .F.
229:                 .Value         = 0
230: 
231:                 WITH .Buttons(1)
232:                     .Top          = 5
233:                     .Left         = 80
234:                     .Width        = 75
235:                     .Height       = 75
236:                     .FontName     = "Comic Sans MS"
237:                     .FontSize     = 8
238:                     .FontBold     = .T.
239:                     .FontItalic   = .T.
240:                     .WordWrap     = .T.
241:                     .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
242:                     .Caption      = "Cancelar"
243:                     .Cancel       = .T.
244:                     .MousePointer = 15
245:                     .ToolTipText  = "[Esc] Encerrar"
246:                     .SpecialEffect = 0
247:                     .ForeColor    = RGB(90, 90, 90)
248:                     .BackColor    = RGB(255, 255, 255)
249:                     .Themes       = .F.
250:                 ENDWITH
251: 
252:                 WITH .Buttons(2)
253:                     .Top          = 5
254:                     .Left         = 5
255:                     .Width        = 75
256:                     .Height       = 75
257:                     .FontName     = "Comic Sans MS"
258:                     .FontSize     = 8
259:                     .FontBold     = .T.
260:                     .FontItalic   = .T.
261:                     .WordWrap     = .T.
262:                     .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
263:                     .Caption      = "Confirmar"
264:                     .MousePointer = 15
265:                     .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
266:                     .ForeColor    = RGB(90, 90, 90)
267:                     .BackColor    = RGB(255, 255, 255)
268:                     .Themes       = .F.

*-- Linhas 276 a 285:
276:             THIS.AddObject("grd_4c_Dados", "Grid")
277:             loc_oGrd = THIS.grd_4c_Dados
278:             WITH loc_oGrd
279:                 .Top                = 96
280:                 .Left               = 50
281:                 .Width              = 463
282:                 .Height             = 234
283:                 .ColumnCount        = 3
284:                 .FontName           = "Verdana"
285:                 .FontSize           = 8

*-- Linhas 304 a 312:
304:                 .Resizable = .F.
305:                 .ReadOnly  = .F.
306:             ENDWITH
307:             loc_oGrd.Column1.Header1.Caption   = "Vendedor"
308:             loc_oGrd.Column1.Header1.Alignment = 2
309:             WITH loc_oGrd.Column1.Text1
310:                 .FontName    = "Verdana"
311:                 .FontSize    = 8
312:                 .BorderStyle = 0

*-- Linhas 329 a 337:
329:                 .Width    = 250
330:                 .ReadOnly = .F.
331:             ENDWITH
332:             loc_oGrd.Column2.Header1.Caption   = "Descricao"
333:             loc_oGrd.Column2.Header1.Alignment = 2
334:             WITH loc_oGrd.Column2.Text1
335:                 .BorderStyle = 0
336:                 .InputMask   = ""
337:                 .Margin      = 0

*-- Linhas 346 a 354:
346:                 .Width    = 80
347:                 .ReadOnly = .F.
348:             ENDWITH
349:             loc_oGrd.Column3.Header1.Caption   = "Atendimentos"
350:             loc_oGrd.Column3.Header1.Alignment = 2
351:             WITH loc_oGrd.Column3.Text1
352:                 .BorderStyle = 0
353:                 .Format      = "999,999,999.99"
354:                 .InputMask   = "999"

*-- Linhas 364 a 374:
364:             loc_oGrd.Column1.ControlSource  = "cursor_4c_LocalVen.CodVends"
365:             loc_oGrd.Column2.ControlSource  = "cursor_4c_LocalVen.DesVends"
366:             loc_oGrd.Column3.ControlSource  = "cursor_4c_LocalVen.NAtends"
367:             loc_oGrd.Column1.Header1.Caption = "Vendedor"
368:             loc_oGrd.Column2.Header1.Caption = "Descricao"
369:             loc_oGrd.Column3.Header1.Caption = "Atendimentos"
370:             loc_oGrd.Column1.Width           = 110
371:             loc_oGrd.Column2.Width           = 250
372:             loc_oGrd.Column3.Width           = 80
373:             *-- Gate do When legado da coluna Descricao: "Return EMPTY(
374:             *-- localven.codvends)". Column NAO tem DynamicReadOnly em VFP9,

*-- Linhas 384 a 440:
384:             *-- Botoes standalone Incluir/Excluir - habilitados so em
385:             *-- INSERIR/ALTERAR, equivalente ao When legado
386:             *-- "Return(INLIST(Thisform.pcEscolha,'INSERIR','ALTERAR'))"
387:             THIS.AddObject("cmd_4c_Incluir", "CommandButton")
388:             WITH THIS.cmd_4c_Incluir
389:                 .Top             = 182
390:                 .Left = 5
391:                 .Width           = 45
392:                 .Height          = 45
393:                 .FontBold        = .T.
394:                 .FontName        = "Verdana"
395:                 .FontSize        = 8
396:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
397:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
398:                 .Caption         = ""
399:                 .ToolTipText     = "Inserir"
400:                 .ForeColor       = RGB(36, 84, 155)
401:                 .BackColor       = RGB(255, 255, 255)
402:                 .Themes          = .T.
403:                 .Enabled         = INLIST(THIS.this_cModoEscolha, "INSERIR", "ALTERAR")
404:             ENDWITH
405:             BINDEVENT(THIS.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
406: 
407:             THIS.AddObject("cmd_4c_Excluir", "CommandButton")
408:             WITH THIS.cmd_4c_Excluir
409:                 .Top             = 227
410:                 .Left = 230
411:                 .Width           = 45
412:                 .Height          = 45
413:                 .FontBold        = .T.
414:                 .FontName        = "Verdana"
415:                 .FontSize        = 8
416:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
417:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
418:                 .Caption         = ""
419:                 .ToolTipText     = "Excluir"
420:                 .ForeColor       = RGB(36, 84, 155)
421:                 .BackColor       = RGB(255, 255, 255)
422:                 .Themes          = .T.
423:                 .Enabled         = INLIST(THIS.this_cModoEscolha, "INSERIR", "ALTERAR")
424:             ENDWITH
425:             BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
426: 
427:         CATCH TO loc_oErro
428:             MsgErro(loc_oErro.Message + CHR(13) + ;
429:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
430:                 "Procedure: " + loc_oErro.Procedure, "FormSigMvAte.ConfigurarPaginaLista")
431:         ENDTRY
432:     ENDPROC
433: 
434:     *--------------------------------------------------------------------------
435:     * CarregarLista - (Re)carrega os atendimentos ja gravados do documento no
436:     * cursor_4c_LocalVen via BO e rebinda a grade (o BO fecha/recria o
437:     * cursor, entao RecordSource/ControlSource/Header/Width precisam ser
438:     * reaplicados - "Column.Width vai por ultimo").
439:     *--------------------------------------------------------------------------
440:     PROCEDURE CarregarLista()

*-- Linhas 450 a 460:
450:                 THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_LocalVen.CodVends"
451:                 THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_LocalVen.DesVends"
452:                 THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_LocalVen.NAtends"
453:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "Vendedor"
454:                 THIS.grd_4c_Dados.Column2.Header1.Caption = "Descricao"
455:                 THIS.grd_4c_Dados.Column3.Header1.Caption = "Atendimentos"
456:                 THIS.grd_4c_Dados.Column1.Width           = 110
457:                 THIS.grd_4c_Dados.Column2.Width           = 250
458:                 THIS.grd_4c_Dados.Column3.Width           = 80
459:                 SELECT cursor_4c_LocalVen
460:                 GO TOP

*-- Linhas 714 a 723:
714:                 IF VARTYPE(loc_oBusca) = "O"
715:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaVenGrade"
716:                     loc_oBusca.this_cTitulo        = loc_cTitulo
717:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
718:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
719:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
720:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
721:                     loc_oBusca.Show()
722: 
723:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVenGrade") AND USED("cursor_4c_LocalVen")


### BO (C:\4c\projeto\app\classes\SigMvAteBO.prg):
*====================================================================
* SigMvAteBO.prg
*
* Business Object para Atendimentos de Vendedores por Documento
* Tabela: SigMvAte
* Herda de: BusinessBase
*
* Form OPERACIONAL chamado a partir de um documento de movimento
* (SigMvCab): permite escolher, na grade, os vendedores que
* atenderam o pedido/documento e quantos atendimentos cada um teve.
* Ao Confirmar, o legado apaga os registros de SigMvAte do documento
* (empdopnums) e reinsere as linhas atuais da grade.
*====================================================================

DEFINE CLASS SigMvAteBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvAte)
    this_cCodVends   = ""    && codvends   char(10) - codigo do vendedor
    this_cEmps       = ""    && emps       char(3)  - empresa do documento
    this_cEmpDopNums = ""    && empdopnums char(29) - chave do documento pai (SigMvCab)
    this_nAtends     = 0     && natends    numeric(4,0) - quantidade de atendimentos
    this_cPkChaves   = ""    && pkchaves   char(20) - PK

    *-- Propriedade de exibicao (NAO persistida - descricao do vendedor,
    *-- obtida via lookup em SigCdCli.rclis Where grupos = this_cGrVends
    *-- and iclis = this_cCodVends)
    this_cDescVends  = ""

    *-- Contexto do documento pai (TprMvCab no legado), necessario para
    *-- filtrar/validar os vendedores deste documento nas proximas fases
    this_cGrVends    = ""    && grvends do SigMvCab - grupo de vendedores aceito

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvAte"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvAteBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Reseta as propriedades da entidade
    * (chamado por NovoRegistro() antes de cada Inserir() do laco de
    * Confirmar - sem isso this_cPkChaves manteria o valor da linha
    * anterior e o segundo INSERT colidiria no indice unico)
    *====================================================================
    PROCEDURE LimparDados()
        THIS.this_cCodVends   = ""
        THIS.this_cEmps       = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_nAtends     = 0
        THIS.this_cPkChaves   = ""
        THIS.this_cDescVends  = ""
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    * (usado ao percorrer a grade local de atendimentos - ver Formcomp.
    * cursor tipico: crSigMvAte, populado via SELECT * FROM SigMvAte)
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodVends   = TratarNulo(codvends,   "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_nAtends     = TratarNulo(natends,    "N")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigMvAteBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * Inserir - Grava novo atendimento de vendedor para o documento
    * (equivale ao INSERT INTO crSigmvAte (...) do legado, feito para
    * cada linha da grade nao-zerada ao Confirmar; gera pkchaves novo)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvAte (codvends, emps, empdopnums, natends, pkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodVends)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<FormatarNumeroSQL(THIS.this_nAtends, 0)>>,
                    <<EscaparSQL(THIS.this_cPkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigMvAteBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza a quantidade de atendimentos do vendedor
    * para o documento (o legado nunca faz UPDATE de linha - apaga e
    * reinsere a grade inteira -, mas o metodo eh mantido para permitir
    * corrigir uma linha isolada sem afetar as demais do documento)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvAte
                SET codvends   = <<EscaparSQL(THIS.this_cCodVends)>>,
                    emps       = <<EscaparSQL(THIS.this_cEmps)>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    natends    = <<FormatarNumeroSQL(THIS.this_nAtends, 0)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigMvAteBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui o atendimento do vendedor pela pkchaves
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvAte
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigMvAteBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirTodosDoDocumento - Apaga TODOS os atendimentos ja gravados
    * para o documento (empdopnums), replicando o
    * "Delete all for empdopnums = pcEDN" do legado antes de reinserir
    * a grade atual ao Confirmar (ver FormSigMvAte.BtnConfirmarClick)
    *====================================================================
    PROCEDURE ExcluirTodosDoDocumento(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvAte
                WHERE empdopnums = <<EscaparSQL(par_cEmpDopNums)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir atendimentos do documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir atendimentos do documento:" + CHR(13) + loException.Message, "SigMvAteBO.ExcluirTodosDoDocumento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarAtendimentosDocumento - Popula cursor_4c_LocalVen (cursor
    * local, editavel) com os vendedores ja gravados em SigMvAte para o
    * documento informado, buscando a descricao (Rclis) de cada vendedor
    * em SigCdCli filtrado pelo grupo de vendedores do documento.
    * Equivale ao trecho do Init do legado:
    *   SELECT codvends, SPACE(40) as desVends, nAtends FROM crSigmvate
    *   INTO CURSOR LocalVen READWRITE
    *   SCAN
    *       (busca RClis em SigCdCli where grupos=... and iclis=...)
    *   ENDSCAN
    * IMPORTANTE: a ordem dos campos do CREATE CURSOR abaixo tem de ser
    * IDENTICA ao cursor placeholder criado em
    * FormSigMvAte.InicializarForm (CodVends, DesVends, NAtends).
    *====================================================================
    PROCEDURE CarregarAtendimentosDocumento(par_cEmpDopNums, par_cGrVends)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cDesc

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_AtendTemp")
                USE IN cursor_4c_AtendTemp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT codvends, natends FROM SigMvAte
                WHERE empdopnums = <<EscaparSQL(par_cEmpDopNums)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AtendTemp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_LocalVen")
                    USE IN cursor_4c_LocalVen
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_LocalVen ;
                    (CodVends C(10) NULL, DesVends C(40) NULL, NAtends N(4,0) NULL)
                SET NULL OFF

                IF USED("cursor_4c_AtendTemp")
                    SELECT cursor_4c_AtendTemp
                    GO TOP
                    SCAN
                        loc_cDesc = THIS.ObterDescricaoVendedor(par_cGrVends, ;
                            TratarNulo(cursor_4c_AtendTemp.codvends, "C"))

                        INSERT INTO cursor_4c_LocalVen (CodVends, DesVends, NAtends) ;
                            VALUES (TratarNulo(cursor_4c_AtendTemp.codvends, "C"), ;
                                    loc_cDesc, ;
                                    TratarNulo(cursor_4c_AtendTemp.natends, "N"))
                    ENDSCAN
                    USE IN cursor_4c_AtendTemp
                ENDIF

                SELECT cursor_4c_LocalVen
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar atendimentos do documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar atendimentos:" + CHR(13) + loException.Message, "SigMvAteBO.CarregarAtendimentosDocumento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterDescricaoVendedor - Busca a razao social (Rclis) do vendedor
    * em SigCdCli, filtrando pelo grupo de vendedores do documento
    * (equivale a SqlExecute("Select rclis From SigCdCli where grupos =
    * ... and iclis = ...") do legado). Retorna "" se nao encontrado -
    * PUBLIC porque o Form chama para revalidar codigos digitados na grade.
    *====================================================================
    PROCEDURE ObterDescricaoVendedor(par_cGrVends, par_cCodVends)
        LOCAL loc_cSQL, loc_nResultado, loc_cRetorno

        loc_cRetorno = ""

        IF EMPTY(par_cCodVends)
            RETURN loc_cRetorno
        ENDIF

        TRY
            IF USED("cursor_4c_VenTemp")
                USE IN cursor_4c_VenTemp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT rclis FROM SigCdCli
                WHERE grupos = <<EscaparSQL(par_cGrVends)>>
                  AND iclis  = <<EscaparSQL(par_cCodVends)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenTemp")

            IF loc_nResultado > 0 AND USED("cursor_4c_VenTemp") AND RECCOUNT("cursor_4c_VenTemp") > 0
                loc_cRetorno = TratarNulo(cursor_4c_VenTemp.rclis, "C")
            ENDIF

            IF USED("cursor_4c_VenTemp")
                USE IN cursor_4c_VenTemp
            ENDIF
        CATCH TO loException
            loc_cRetorno = ""
        ENDTRY

        RETURN loc_cRetorno
    ENDPROC

ENDDEFINE

