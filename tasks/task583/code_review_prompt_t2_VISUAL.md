# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (842 linhas total):

*-- Linhas 103 a 111:
103:     * Init - define Caption com CHR() antes de delegar ao FormBase
104:     *--------------------------------------------------------------------------
105:     PROCEDURE Init()
106:         THIS.Caption = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
107: 
108:         *-- NAO atribuir ShowWindow aqui: eh READ-ONLY em runtime (ver o
109:         *-- comentario na declaracao da classe). O harness headless nao precisa
110:         *-- de ajuste nenhum - o TestFormWrapper baixa WindowType para 0 por
111:         *-- conta propria antes do Show(), e ShowWindow so tem efeito no Show().

*-- Linhas 173 a 222:
173:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
174:         loc_oCab = THIS.cnt_4c_Cabecalho
175:         WITH loc_oCab
176:             .Top         = 0
177:             .Left        = 0
178:             .Width       = THIS.Width
179:             .Height      = 80
180:             .BackColor   = RGB(100,100,100)
181:             .BackStyle   = 1
182:             .BorderWidth = 0
183:         ENDWITH
184: 
185:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
186:         WITH loc_oCab.lbl_4c_Sombra
187:             .AutoSize      = .F.
188:             .Width         = loc_oCab.Width - 20
189:             .Height        = 40
190:             .Top           = 18
191:             .Left          = 10
192:             .FontName      = "Tahoma"
193:             .FontSize      = 18
194:             .FontBold      = .T.
195:             .FontUnderline = .F.
196:             .Alignment     = 0
197:             .BackStyle     = 0
198:             .WordWrap      = .T.
199:             .ForeColor     = RGB(0,0,0)
200:             .Caption       = THIS.Caption
201:         ENDWITH
202: 
203:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
204:         WITH loc_oCab.lbl_4c_Titulo
205:             .AutoSize      = .F.
206:             .Width         = loc_oCab.Width - 20
207:             .Height        = 46
208:             .Top           = 17
209:             .Left          = 10
210:             .FontName      = "Tahoma"
211:             .FontSize      = 18
212:             .FontBold      = .T.
213:             .Alignment     = 0
214:             .BackStyle     = 0
215:             .WordWrap      = .T.
216:             .ForeColor     = RGB(255,255,255)
217:             .Caption       = THIS.Caption
218:         ENDWITH
219:     ENDPROC
220: 
221:     *--------------------------------------------------------------------------
222:     * ConfigurarGrid - cria a grade de divisao de quantidade (SIGPRAOP.Grade

*-- Linhas 241 a 250:
241:         loc_oGrid.ColumnCount  = 5
242:         loc_oGrid.RecordSource = "cursor_4c_DivOp"
243:         WITH loc_oGrid
244:             .Top           = 142
245:             .Left          = 50
246:             .Width         = 442
247:             .Height        = 207
248:             .FontName      = "Arial"
249:             .FontSize      = 8
250:             .GridLines     = 3

*-- Linhas 263 a 310:
263:             .Column1.Resizable       = .F.
264:             .Column1.FontName        = "Arial"
265:             .Column1.FontSize        = 8
266:             .Column1.Header1.Caption = "Pedido"
267: 
268:             .Column2.ControlSource   = "cursor_4c_DivOp.CodCors"
269:             .Column2.Width           = 38
270:             .Column2.ReadOnly        = .T.
271:             .Column2.Movable         = .F.
272:             .Column2.Resizable       = .F.
273:             .Column2.FontName        = "Arial"
274:             .Column2.FontSize        = 8
275:             .Column2.Header1.Caption = "Cor"
276: 
277:             .Column3.ControlSource   = "cursor_4c_DivOp.CodTams"
278:             .Column3.Width           = 38
279:             .Column3.ReadOnly        = .T.
280:             .Column3.Movable         = .F.
281:             .Column3.Resizable       = .F.
282:             .Column3.FontName        = "Arial"
283:             .Column3.FontSize        = 8
284:             .Column3.Header1.Caption = "Tam"
285: 
286:             .Column4.ControlSource   = "cursor_4c_DivOp.Qtds"
287:             .Column4.Width           = 80
288:             .Column4.Alignment       = 1
289:             .Column4.InputMask       = "999,999.999"
290:             .Column4.ReadOnly        = .T.
291:             .Column4.Movable         = .F.
292:             .Column4.Resizable       = .F.
293:             .Column4.FontName        = "Arial"
294:             .Column4.FontSize        = 8
295:             .Column4.Header1.Caption = "Qtd.Atual"
296: 
297:             .Column5.ControlSource   = "cursor_4c_DivOp.QtdDivs"
298:             .Column5.Width           = 80
299:             .Column5.Format          = "K"
300:             .Column5.ReadOnly        = .F.
301:             .Column5.Movable         = .F.
302:             .Column5.Resizable       = .F.
303:             .Column5.FontName        = "Arial"
304:             .Column5.FontSize        = 8
305:             .Column5.Header1.Caption = "Quantidade"
306:         ENDWITH
307: 
308:         *-- Legado: Grade.AfterRowColChange -> ThisForm.Get_obss.Refresh
309:         *-- (o EditBox de observacoes eh ligado por ControlSource direto ao
310:         *-- cursor - so precisa ser avisado para redesenhar ao mudar de linha)

*-- Linhas 329 a 379:
329:         THIS.AddObject("cmg_4c_Grupo_Conf", "CommandGroup")
330:         loc_oGrp = THIS.cmg_4c_Grupo_Conf
331:         WITH loc_oGrp
332:             .Top          = -2
333:             .Left         = 544
334:             .Width        = 160
335:             .Height       = 85
336:             .ButtonCount  = 2
337:             .BackStyle    = 0
338:             .BorderStyle  = 0
339:             .SpecialEffect = 1
340:             .Themes        = .F.
341: 
342:             WITH .Buttons(1)
343:                 .Top        = 5
344:                 .Left       = 5
345:                 .Width      = 75
346:                 .Height     = 75
347:                 .FontName   = "Comic Sans MS"
348:                 .FontSize   = 8
349:                 .FontBold   = .T.
350:                 .FontItalic = .T.
351:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
352:                 *-- DisabledPicture: CarregarDados alterna .Enabled deste botao
353:                 *-- (legado: Get_OP.When desliga, Get_OP.Valid religa ao achar
354:                 *-- a O.P.) - sem DisabledPicture o icone some no estado cinza
355:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
356:                 *-- "\<Confirmar" preserva a tecla de acesso Alt+C do legado
357:                 .Caption    = "\<Confirmar"
358:                 .ForeColor  = RGB(90, 90, 90)
359:                 .BackColor  = RGB(255, 255, 255)
360:                 .Themes     = .F.
361:             ENDWITH
362: 
363:             WITH .Buttons(2)
364:                 .Top        = 5
365:                 .Left       = 80
366:                 .Width      = 75
367:                 .Height     = 75
368:                 .FontName   = "Comic Sans MS"
369:                 .FontSize   = 8
370:                 .FontBold   = .T.
371:                 .FontItalic = .T.
372:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
373:                 .Cancel     = .T.
374:                 .Caption    = "Encerrar"
375:                 .ForeColor  = RGB(90, 90, 90)
376:                 .BackColor  = RGB(255, 255, 255)
377:                 .Themes     = .F.
378:             ENDWITH
379:         ENDWITH

*-- Linhas 418 a 480:
418:     * igual ao ThisForm.Get_obss.Refresh do legado.
419:     *--------------------------------------------------------------------------
420:     PROTECTED PROCEDURE ConfigurarCampos()
421:         THIS.AddObject("lbl_4c_Label1", "Label")
422:         WITH THIS.lbl_4c_Label1
423:             .Top       = 93
424:             .Left      = 70
425:             .Width     = 31
426:             .Height    = 15
427:             .AutoSize  = .F.
428:             .Alignment = 0
429:             .BackStyle = 0
430:             .FontName  = "Tahoma"
431:             .FontSize  = 8
432:             .ForeColor = RGB(90, 90, 90)
433:             .Caption   = "O.P. :"
434:         ENDWITH
435: 
436:         THIS.AddObject("txt_4c_OP", "TextBox")
437:         WITH THIS.txt_4c_OP
438:             .Top        = 90
439:             .Left       = 107
440:             .Width      = 96
441:             .Height     = 23
442:             .InputMask  = "999999999999"
443:             .MaxLength  = 12
444:             .Value      = ""
445:         ENDWITH
446: 
447:         THIS.AddObject("lbl_4c_Label2", "Label")
448:         WITH THIS.lbl_4c_Label2
449:             .Top       = 117
450:             .Left      = 50
451:             .Width     = 47
452:             .Height    = 15
453:             .AutoSize  = .F.
454:             .Alignment = 0
455:             .BackStyle = 0
456:             .FontName  = "Tahoma"
457:             .FontSize  = 8
458:             .ForeColor = RGB(90, 90, 90)
459:             .Caption   = "Produto :"
460:         ENDWITH
461: 
462:         THIS.AddObject("txt_4c_Produto", "TextBox")
463:         WITH THIS.txt_4c_Produto
464:             .Top      = 114
465:             .Left     = 107
466:             .Width    = 96
467:             .Height   = 23
468:             .ReadOnly = .T.
469:             .Value    = ""
470:         ENDWITH
471: 
472:         THIS.AddObject("edt_4c_Obss", "EditBox")
473:         WITH THIS.edt_4c_Obss
474:             .Top               = 356
475:             .Left              = 48
476:             .Width             = 443
477:             .Height            = 70
478:             .ReadOnly          = .T.
479:             .ControlSource     = "cursor_4c_DivOp.Obss"
480:             .DisabledBackColor = RGB(255, 255, 255)


### BO (C:\4c\projeto\app\classes\SigPrAopBO.prg):
*============================================================================
* SigPrAopBO.prg - Business Object para Altera??o de Quantidade da O.P.
*
* Tabela principal : SigOpPic  (PK: cIdChaves char(20))
* Tabelas relacionadas:
*   - SigCdNec (EmpDNps = _Empr + DoppPads + Str(Nops,10)) -> ChkSubn (O.P. encerrada?)
*   - SigPdMvf (Nops, cIdChaves, CodPds, Qtds) -> produto e saldo total da O.P.
*   - SigCdPam (DoppPads, MascNums) -> parametros do sistema
*
* Form OPERACIONAL: permite dividir a quantidade de itens (Dopes+Numes) de
* uma Ordem de Producao ja liberada em novas sequencias (SeqDivs), gravando
* de volta em SigOpPic e atualizando o saldo total em SigPdMvf.
*
* O legado (Grupo_Conf.Salva.Click) NUNCA insere um novo registro em SigOpPic
* ou SigPdMvf - ele apenas redistribui a quantidade Qtds/SeqDivs entre linhas
* JA existentes (criadas em outro processo, fora deste form). Por isso este BO
* nao sobrescreve Inserir(): o comportamento padrao herdado de BusinessBase
* (recusar a operacao) ja eh o correto para esta entidade neste form.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos CRUD (CarregarDoCursor/Atualizar/
*                ObterChavePrimaria/RegistrarAuditoria) + carga de itens
*                da O.P. (BuscarItensPorOP, equivalente ao Get_OP.Valid legado)
*============================================================================

DEFINE CLASS SigPrAopBO AS BusinessBase

    *==========================================================================
    * Propriedades de cabecalho - digitadas/exibidas nos campos Get_OP/Get_Produto
    *==========================================================================
    this_nNops        = 0     && numeric(10) - Numero da O.P. (Get_OP.Value)
    this_cCodProduto  = ""    && char(10)    - Codigo do produto (SigPdMvf.CodPds, exibido em Get_Produto)

    *==========================================================================
    * Propriedades de estado - resultado da validacao da O.P. digitada
    *==========================================================================
    this_lOPLocalizada = .F.  && .T. quando a O.P. foi encontrada em SigCdNec e esta liberada
    this_lOPEncerrada  = .F.  && .T. quando SigCdNec.ChkSubn indica O.P. ja encerrada

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init
    *==========================================================================
    this_cDoppPads = ""       && char(20)     - Grupo/departamento padrao (SigCdPam.DoppPads), usado para montar EmpDNps
    this_nMascNums = 0        && numeric(1,0) - Tipo de mascara de numeracao (SigCdPam.MascNums), usado na formatacao do Pedido na grade

    *==========================================================================
    * Cursor de trabalho - grade de divisao de quantidade (equivalente ao
    * Temp_DivOp do legado). Criado/populado por BuscarItensPorOP().
    *==========================================================================
    this_cCursorItens = "cursor_4c_DivOp"

    *==========================================================================
    * Propriedades de item - espelham TODAS as colunas de SigOpPic usadas
    * neste form. Populadas por CarregarDoCursor() a partir de uma linha do
    * cursor (chave primaria = this_cIdChaves, casa com this_cCampoChave).
    *==========================================================================
    this_cIdChaves = ""       && char(20)     - SigOpPic.cIdChaves (PK)
    this_cDopes    = ""       && char(20)     - SigOpPic.Dopes
    this_nNumes    = 0        && numeric(6,0) - SigOpPic.Numes
    this_nQtds     = 0        && numeric(9,3) - SigOpPic.Qtds
    this_nSeqDivs  = 0        && numeric(3,0) - SigOpPic.SeqDivs
    this_dDataEs   = {}       && datetime     - SigOpPic.DataEs
    this_cObs      = ""       && text/memo    - SigOpPic.Obss
    this_cCpros    = ""       && char(14)     - SigOpPic.Cpros
    this_cCodCors  = ""       && char(4)      - SigOpPic.CodCors
    this_cCodTams  = ""       && char(4)      - SigOpPic.CodTams
    this_nCitens   = 0        && numeric(10,0)- SigOpPic.Citens

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela, chave primaria
    * e parametros do sistema (SigCdPam.DoppPads/MascNums), equivalente ao
    * ThisForm.poDataMgr.CursorQuery('SigCdPam', 'crSigCdPam', ...) do legado.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "cIdChaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                SQLEXEC(gnConnHandle, "SELECT DoppPads, MascNums FROM SigCdPam", "cursor_4c_SigCdPam")

                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cDoppPads = PADR(TratarNulo(cursor_4c_SigCdPam.DoppPads, ""), 20)
                    THIS.this_nMascNums = TratarNulo(cursor_4c_SigCdPam.MascNums, 0)
                ENDIF

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
            ENDIF

            *-- Cria o cursor de trabalho vazio ja no Init, para que o Grid
            *-- do form possa ligar Column.ControlSource/RecordSource nele
            *-- durante InicializarForm (o cursor so recebe linhas de verdade
            *-- quando o usuario digitar uma O.P. valida em BuscarItensPorOP)
            THIS.CriarCursorItens()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CriarCursorItens - Cria (ou ESVAZIA) o cursor local de divisao de
    * quantidade. Estrutura TRANSCRITA do legado (Create Cursor Temp_DivOp,
    * PROCEDURE Load do SIGPRAOP): mesma ordem, tipos e tamanhos de campo em
    * TODOS os lugares onde o cursor eh criado (unico ponto de criacao).
    *
    * Cursor JA existente eh esvaziado com ZAP, NUNCA fechado e recriado: o
    * legado tambem faz "Zap In Temp_DivOp" no inicio do Get_OP.Valid, e por um
    * motivo que vale igual aqui - fechar o alias DERRUBA o binding de quem
    * aponta para ele (grd_4c_Dados.RecordSource + as 5 Column.ControlSource +
    * edt_4c_Obss.ControlSource, todos ligados em InicializarForm). Recriando,
    * o usuario digitava a O.P. e a grade ficava permanentemente vazia mesmo
    * com o cursor cheio - sem erro e sem log, porque o CREATE CURSOR funciona.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorItens()
        LOCAL loc_cSafety

        IF USED("cursor_4c_DivOp")
            *-- Legado: Zap In Temp_DivOp (preserva a estrutura e o binding).
            *
            *-- SET SAFETY OFF em volta eh OBRIGATORIO, nao precaucao: com
            *-- SAFETY ON o ZAP abre o dialogo modal "Zap ... Are you sure?" e
            *-- CONGELA a tela. O form eh DataSession = 2, e SET SAFETY eh
            *-- escopado por data session: medido no VFP9 (2026-09-26), dentro
            *-- da datasession privada o SAFETY vale ON mesmo com SET SAFETY OFF
            *-- no main.prg - mesmo mecanismo que reseta SET DATE/CENTURY ali.
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT cursor_4c_DivOp
            ZAP IN cursor_4c_DivOp
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ELSE
            SET NULL ON
            CREATE CURSOR cursor_4c_DivOp (Qtds N(12,3), QtdDivs N(12,3), Dopes C(20), Numes N(6), ;
                Dataes D NULL, Obss M NULL, Nops N(10), SeqDivs N(3), Cpros C(10), CodCors C(4), ;
                CodTams C(4), Citens N(10))
            SET NULL OFF
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarItensPorOP - Valida a O.P. digitada e carrega os itens no cursor
    * de trabalho. Equivalente ao PROCEDURE Valid do Get_OP no legado:
    *   - monta EmpDNps = _Empr + DoppPads + Str(Nops,10) (chave POSICIONAL:
    *     as partes NAO sao ALLTRIM'adas, o padding faz parte da chave)
    *   - consulta SigCdNec por EmpDNps: se nao achar ou estiver encerrada
    *     (ChkSubn), preenche mensagem de erro e retorna sem carregar nada
    *   - achando e nao encerrada, busca o produto em SigPdMvf e os itens
    *     da O.P. em SigOpPic, populando cursor_4c_DivOp com QtdDivs = Qtds
    *     (valor inicial igual ao atual) e SeqDivs sequencial (Citens local)
    *
    * Retorno: .T. quando a consulta foi executada sem erro tecnico (mesmo
    * que a O.P. nao exista ou esteja encerrada - nesses casos this_cMensagemErro
    * e this_lOPEncerrada/this_lOPLocalizada indicam o motivo); .F. em erro
    * tecnico (falha de conexao/SQL).
    *==========================================================================
    PROCEDURE BuscarItensPorOP(par_nNops)
        LOCAL loc_lSucesso, loc_cPEdn, loc_nResultado, loc_nCItem, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_lOPLocalizada = .F.
        THIS.this_lOPEncerrada  = .F.
        THIS.this_cCodProduto   = ""
        THIS.this_nNops         = 0

        THIS.CriarCursorItens()

        IF VARTYPE(par_nNops) != "N" OR par_nNops = 0
            RETURN .T.
        ENDIF

        TRY
            loc_cPEdn = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(THIS.this_cDoppPads, 20) + STR(par_nNops, 10)

            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ChkSubn FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cPEdn), ;
                "cursor_4c_SigCdNec")

            IF loc_nResultado > 0 AND USED("cursor_4c_SigCdNec") AND !EOF("cursor_4c_SigCdNec")

                IF !cursor_4c_SigCdNec.ChkSubn
                    THIS.this_lOPLocalizada = .T.
                    THIS.this_nNops         = par_nNops

                    IF USED("cursor_4c_SigPdMvfOp")
                        USE IN cursor_4c_SigPdMvfOp
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT CodPds FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(loc_cPEdn), ;
                        "cursor_4c_SigPdMvfOp")
                    IF USED("cursor_4c_SigPdMvfOp") AND !EOF("cursor_4c_SigPdMvfOp")
                        THIS.this_cCodProduto = TratarNulo(cursor_4c_SigPdMvfOp.CodPds, "")
                    ENDIF
                    IF USED("cursor_4c_SigPdMvfOp")
                        USE IN cursor_4c_SigPdMvfOp
                    ENDIF

                    IF USED("cursor_4c_SigOpPicOp")
                        USE IN cursor_4c_SigOpPicOp
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Dopes, Numes, Qtds, DataEs, Obss, Cpros, CodCors, CodTams, Citens " + ;
                        "FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(par_nNops, 0), ;
                        "cursor_4c_SigOpPicOp")

                    loc_nCItem = 1
                    IF USED("cursor_4c_SigOpPicOp")
                        SELECT cursor_4c_SigOpPicOp
                        SCAN
                            INSERT INTO cursor_4c_DivOp ;
                                (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, Nops, SeqDivs, Cpros, CodCors, CodTams, Citens) ;
                                VALUES ( ;
                                    cursor_4c_SigOpPicOp.Dopes, cursor_4c_SigOpPicOp.Numes, cursor_4c_SigOpPicOp.Qtds, ;
                                    cursor_4c_SigOpPicOp.Qtds, cursor_4c_SigOpPicOp.DataEs, cursor_4c_SigOpPicOp.Obss, ;
                                    par_nNops, loc_nCItem, cursor_4c_SigOpPicOp.Cpros, cursor_4c_SigOpPicOp.CodCors, ;
                                    cursor_4c_SigOpPicOp.CodTams, cursor_4c_SigOpPicOp.Citens)
                            loc_nCItem = loc_nCItem + 1
                        ENDSCAN
                        USE IN cursor_4c_SigOpPicOp
                    ENDIF

                    SELECT cursor_4c_DivOp
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_lOPEncerrada  = .T.
                    THIS.this_cMensagemErro = "O.P. J" + CHR(225) + " Foi Encerrada!!!"
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "O.P. N" + CHR(227) + "o Localizada!!!"
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de uma linha de SigOpPic
    * (identificada por cIdChaves) para as propriedades this_ do BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cIdChaves = TratarNulo(cIdChaves, "")
        THIS.this_nNops     = TratarNulo(Nops, 0)
        THIS.this_cDopes    = TratarNulo(Dopes, "")
        THIS.this_nNumes    = TratarNulo(Numes, 0)
        THIS.this_nQtds     = TratarNulo(Qtds, 0)
        THIS.this_nSeqDivs  = TratarNulo(SeqDivs, 0)
        THIS.this_dDataEs   = ConverterParaData(DataEs)
        THIS.this_cObs      = TratarNulo(Obss, "")
        THIS.this_cCpros    = TratarNulo(Cpros, "")
        THIS.this_cCodCors  = TratarNulo(CodCors, "")
        THIS.this_cCodTams  = TratarNulo(CodTams, "")
        THIS.this_nCitens   = TratarNulo(Citens, 0)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro "corrente" para auditoria.
    * Durante Atualizar(), this_cIdChaves eh reposicionado a cada UPDATE bem
    * sucedido (SigOpPic ou SigPdMvf), de forma que RegistrarAuditoria()
    * sempre registre a linha que acabou de ser gravada.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * Atualizar - Confirma a divisao de quantidade (Grupo_Conf.Salva.Click do
    * legado). Passos, na mesma ordem do legado:
    *   1) Recarrega os itens ATUAIS da O.P. (cursor_4c_SigOpPicAtu)
    *   2) Zera SeqDivs de TODOS os itens da O.P. (banco + cursor local)
    *   3) Para cada linha de cursor_4c_DivOp, localiza o primeiro item com
    *      mesmo Dopes+Numes e SeqDivs=0 e grava Qtds/SeqDivs nele
    *   4) Recalcula o saldo total (Sum Qtds) e grava em SigPdMvf
    *   5) Commit (ou Rollback se qualquer passo falhar) - transacao manual,
    *      equivalente ao ThisForm.poDataMgr.Commit() do legado
    *
    * SET EXACT OFF durante o processamento: os SEEKs usam apenas PARTE da
    * chave composta do indice local (Nops, ou Nops+Citens) - com SET EXACT
    * ON (config.prg) o SEEK exigiria a chave INTEIRA e nunca casaria.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lOk, loc_nOP, loc_cSQL, loc_oErro, loc_cSetExactAnt
        LOCAL loc_nQtdDivs, loc_nSeqDivs, loc_nCitens, loc_cDopes, loc_nNumes
        LOCAL loc_nQtdTotal, loc_cChaveAtual

        loc_lSucesso = .F.
        loc_lOk      = .T.
        THIS.this_cMensagemErro = ""

        IF THIS.this_nNops = 0
            THIS.this_cMensagemErro = "O.P. n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_DivOp") OR RECCOUNT("cursor_4c_DivOp") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " itens para gravar."
            RETURN .F.
        ENDIF

        loc_nOP = THIS.this_nNops

        TRY
            loc_cSetExactAnt = SET("EXACT")
            SET EXACT OFF

            *-- 1) Recarrega os itens ATUAIS da O.P. direto do banco
            IF USED("cursor_4c_SigOpPicAtu")
                USE IN cursor_4c_SigOpPicAtu
            ENDIF
            SQLEXEC(gnConnHandle, ;
                "SELECT Nops, cIdChaves, Dopes, Numes, SeqDivs, Qtds, Citens FROM SigOpPic " + ;
                "WHERE Nops = " + FormatarNumeroSQL(loc_nOP, 0), "cursor_4c_SigOpPicAtu")

            IF !USED("cursor_4c_SigOpPicAtu")
                THIS.this_cMensagemErro = "Falha ao consultar os itens da O.P."
                loc_lOk = .F.
            ENDIF

            *-- 2) Zera SeqDivs de TODOS os itens da O.P. (banco + cursor local),
            *--    reproduzindo o Scan While Nops=lnOp / Replace SeqDivs With 0
            IF loc_lOk
                SELECT cursor_4c_SigOpPicAtu
                INDEX ON STR(Nops, 10) + STR(Citens, 10) + cIdChaves TAG Nops
                SET ORDER TO Nops
                SEEK STR(loc_nOP, 10)
                SCAN WHILE loc_lOk AND Nops = loc_nOP
                    loc_cChaveAtual = cIdChaves
                    REPLACE SeqDivs WITH 0 IN cursor_4c_SigOpPicAtu

                    loc_cSQL = "UPDATE SigOpPic SET SeqDivs = 0 WHERE cIdChaves = " + EscaparSQL(loc_cChaveAtual)
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigOpPic 1)")
                        loc_lOk = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 3) Distribui a quantidade de cada linha do grid (cursor_4c_DivOp) no
            *--    primeiro item da O.P. com mesmo Dopes+Numes ainda com SeqDivs=0
            IF loc_lOk
                SELECT cursor_4c_DivOp
                SCAN WHILE loc_lOk
                    loc_nQtdDivs = cursor_4c_DivOp.QtdDivs
                    loc_nSeqDivs = cursor_4c_DivOp.SeqDivs
                    loc_nCitens  = cursor_4c_DivOp.Citens
                    loc_cDopes   = cursor_4c_DivOp.Dopes
                    loc_nNumes   = cursor_4c_DivOp.Numes
                    loc_cChaveAtual = ""

                    SELECT cursor_4c_SigOpPicAtu
                    SET ORDER TO Nops ASCENDING
                    SEEK STR(loc_nOP, 10) + STR(loc_nCitens, 10)
                    SCAN FOR Nops = loc_nOP AND Citens = loc_nCitens
                        IF (Dopes + STR(Numes, 6) = loc_cDopes + STR(loc_nNumes, 6)) AND SeqDivs = 0
                            REPLACE Qtds WITH loc_nQtdDivs, SeqDivs WITH loc_nSeqDivs IN cursor_4c_SigOpPicAtu
                            loc_cChaveAtual = cIdChaves
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF !EMPTY(loc_cChaveAtual)
                        loc_cSQL = "UPDATE SigOpPic SET Qtds = " + FormatarNumeroSQL(loc_nQtdDivs, 3) + ;
                                   ", SeqDivs = " + FormatarNumeroSQL(loc_nSeqDivs, 0) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(loc_cChaveAtual)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigOpPic 2)")
                            loc_lOk = .F.
                        ELSE
                            THIS.this_cIdChaves = loc_cChaveAtual
                            THIS.RegistrarAuditoria("ATUALIZAR")
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_DivOp
                ENDSCAN
            ENDIF

            *-- 4) Recalcula o saldo total da O.P. (Sum Qtds To lnQtd do legado)
            *--    e grava em SigPdMvf
            IF loc_lOk
                SELECT cursor_4c_SigOpPicAtu
                SUM Qtds TO loc_nQtdTotal

                IF USED("cursor_4c_SigPdMvfAtu")
                    USE IN cursor_4c_SigPdMvfAtu
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT Nops, cIdChaves FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(loc_nOP, 0), ;
                    "cursor_4c_SigPdMvfAtu")

                IF USED("cursor_4c_SigPdMvfAtu")
                    SELECT cursor_4c_SigPdMvfAtu
                    INDEX ON STR(Nops, 10) + cIdChaves TAG Nops
                    SET ORDER TO Nops DESCENDING
                    IF SEEK(STR(loc_nOP, 10))
                        loc_cSQL = "UPDATE SigPdMvf SET Qtds = " + FormatarNumeroSQL(loc_nQtdTotal, 3) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(cursor_4c_SigPdMvfAtu.cIdChaves)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigPdMvf)")
                            loc_lOk = .F.
                        ELSE
                            *-- Auditoria com a tabela correta (SigPdMvf), restaurando
                            *-- this_cTabela = "SigOpPic" logo em seguida
                            THIS.this_cTabela   = "SigPdMvf"
                            THIS.this_cIdChaves = cursor_4c_SigPdMvfAtu.cIdChaves
                            THIS.RegistrarAuditoria("ATUALIZAR")
                            THIS.this_cTabela   = "SigOpPic"
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- 5) Commit ou rollback da transacao manual
            IF loc_lOk
                SQLCOMMIT(gnConnHandle)
                ZAP IN cursor_4c_DivOp
                loc_lSucesso = .T.
            ELSE
                SQLROLLBACK(gnConnHandle)
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigOpPicAtu")
                USE IN cursor_4c_SigOpPicAtu
            ENDIF
            IF USED("cursor_4c_SigPdMvfAtu")
                USE IN cursor_4c_SigPdMvfAtu
            ENDIF

            SET EXACT &loc_cSetExactAnt.

        CATCH TO loc_oErro
            IF VARTYPE(loc_cSetExactAnt) = "C" AND !EMPTY(loc_cSetExactAnt)
                SET EXACT &loc_cSetExactAnt.
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Destroy - Libera os cursores de trabalho abertos por este BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_DivOp")
            USE IN cursor_4c_DivOp
        ENDIF
        IF USED("cursor_4c_SigCdPam")
            USE IN cursor_4c_SigCdPam
        ENDIF
        IF USED("cursor_4c_SigCdNec")
            USE IN cursor_4c_SigCdNec
        ENDIF
        IF USED("cursor_4c_SigPdMvfOp")
            USE IN cursor_4c_SigPdMvfOp
        ENDIF
        IF USED("cursor_4c_SigOpPicOp")
            USE IN cursor_4c_SigOpPicOp
        ENDIF
        IF USED("cursor_4c_SigOpPicAtu")
            USE IN cursor_4c_SigOpPicAtu
        ENDIF
        IF USED("cursor_4c_SigPdMvfAtu")
            USE IN cursor_4c_SigPdMvfAtu
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

