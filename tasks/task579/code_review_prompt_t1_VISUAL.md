# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [ALINHAMENTO] Botao 'cmd_4c_CmdSair' tem Top=2 mas grupo usa Top=3 (diferenca de 1px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvtit.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (608 linhas total):

*-- Linhas 144 a 154:
144:             THIS.this_oBusinessObject.this_cEmpDopNums = THIS.this_cEmpDopNums
145:             THIS.this_oBusinessObject.this_cOpers      = THIS.this_cOpers
146: 
147:             *-- Init legado: .Caption = [Titulos Gerados - Movimentacao : ] +
148:             *-- Empresa + [ / ] + Operacao + [ / ] + Numero
149:             THIS.Caption = "T" + CHR(237) + "tulos Gerados - Movimenta" + CHR(231) + CHR(227) + "o : " + ;
150:                 THIS.this_cEmpresa + " / " + THIS.this_cOperacao + " / " + THIS.this_cNumero
151: 
152:             *-- Picture = ..\framework\imagens\new_background.jpg no legado -
153:             *-- caminho resolvido via gc_4c_CaminhoFramework (regra CLAUDE.md
154:             *-- #27/Pattern #170 - NUNCA gc_4c_CaminhoBase + "Framework\...").

*-- Linhas 189 a 210:
189:         *-- em runtime; migrado apenas por fidelidade estrutural ao SCX).
190:         THIS.AddObject("shp_4c_Shape1", "Shape")
191:         WITH THIS.shp_4c_Shape1
192:             .Top         = 0
193:             .Left        = 923
194:             .Width       = 75
195:             .Height      = 79
196:             .BackStyle   = 0
197:             .BorderStyle = 0
198:             .BorderColor = RGB(136, 189, 188)
199:         ENDWITH
200: 
201:         *-- Grid de titulos (grdTitulos do legado)
202:         THIS.AddObject("grd_4c_Titulos", "Grid")
203:         WITH THIS.grd_4c_Titulos
204:             .Top           = 83
205:             .Left          = 6
206:             .Width         = 884
207:             .Height        = 467
208:             .ColumnCount   = 7
209:             .FontName      = "Tahoma"
210:             .FontSize      = 8

*-- Linhas 244 a 253:
244:         *-- exibe a descricao com a aparencia normal do fwget.
245:         THIS.AddObject("txt_4c_DGrupos", "TextBox")
246:         WITH THIS.txt_4c_DGrupos
247:             .Top           = 569
248:             .Left          = 6
249:             .Width         = 440
250:             .Height        = 23
251:             .Value         = ""
252:             .ReadOnly      = .T.
253:             .TabStop       = .F.

*-- Linhas 261 a 270:
261: 
262:         THIS.AddObject("txt_4c_DContas", "TextBox")
263:         WITH THIS.txt_4c_DContas
264:             .Top           = 569
265:             .Left          = 450
266:             .Width         = 440
267:             .Height        = 23
268:             .Value         = ""
269:             .ReadOnly      = .T.
270:             .TabStop       = .F.

*-- Linhas 276 a 346:
276:             .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
277:         ENDWITH
278: 
279:         THIS.AddObject("lbl_4c_Label3", "Label")
280:         WITH THIS.lbl_4c_Label3
281:             .Top       = 554
282:             .Left      = 6
283:             .Width     = 111
284:             .Height    = 15
285:             .AutoSize  = .T.
286:             .FontBold  = .T.
287:             .FontName  = "Tahoma"
288:             .FontSize  = 8
289:             .BackStyle = 0
290:             .ForeColor = RGB(90, 90, 90)
291:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
292:         ENDWITH
293: 
294:         THIS.AddObject("lbl_4c_Label1", "Label")
295:         WITH THIS.lbl_4c_Label1
296:             .Top       = 554
297:             .Left      = 450
298:             .Width     = 110
299:             .Height    = 15
300:             .AutoSize  = .T.
301:             .FontBold  = .T.
302:             .FontName  = "Tahoma"
303:             .FontSize  = 8
304:             .BackStyle = 0
305:             .ForeColor = RGB(90, 90, 90)
306:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
307:         ENDWITH
308: 
309:         *-- Botao OK (cmdSair do legado) - fecha o form. Standalone com
310:         *-- .Picture exige .Themes = .T. + .DisabledPicture (regra CLAUDE.md
311:         *-- Pattern #99), mesmo o legado nao declarando Themes para este botao.
312:         THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
313:         WITH THIS.cmd_4c_CmdSair
314:             .Top             = 2
315:             .Left            = 923
316:             .Width           = 75
317:             .Height          = 75
318:             .Caption         = "OK"
319:             .Cancel          = .T.
320:             .FontBold        = .T.
321:             .FontItalic      = .T.
322:             .FontName        = "Comic Sans MS"
323:             .FontSize        = 8
324:             .WordWrap        = .T.
325:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
326:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
327:             .ForeColor       = RGB(90, 90, 90)
328:             .BackColor       = RGB(255, 255, 255)
329:             .Themes          = .T.
330:             .PicturePosition = 13
331:         ENDWITH
332: 
333:         *-- Botao de Impressao (iDoc do legado) - abre FormSigReIdt para o
334:         *-- titulo da linha corrente da grade
335:         THIS.AddObject("cmd_4c_IDoc", "CommandButton")
336:         WITH THIS.cmd_4c_IDoc
337:             .Top             = 3
338:             .Left            = 847
339:             .Width           = 75
340:             .Height          = 75
341:             .Caption         = "Im\<press" + CHR(227) + "o"
342:             .FontBold        = .T.
343:             .FontItalic      = .T.
344:             .FontName        = "Comic Sans MS"
345:             .FontSize        = 8
346:             .WordWrap        = .T.

*-- Linhas 353 a 373:
353:             .PicturePosition = 13
354:             .ToolTipText     = "Impress" + CHR(227) + "o"
355:         ENDWITH
356: 
357:         BINDEVENT(THIS.grd_4c_Titulos, "AfterRowColChange", THIS, "GrdTitulosAfterRowColChange")
358:         BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "BtnSairClick")
359:         BINDEVENT(THIS.cmd_4c_IDoc,    "Click", THIS, "BtnIDocClick")
360:     ENDPROC
361: 
362:     *==========================================================================
363:     * CarregarLista - Executa sigmvtitBO.Buscar (equivalente a SqlExecute do
364:     * Init legado) e liga a grade ao cursor_4c_Dados. RecordSource reseta
365:     * Width/Header1.Caption das colunas (CLAUDE.md Problema 48) - por isso
366:     * essas duas propriedades sao reaplicadas AQUI, depois do RecordSource.
367:     *==========================================================================
368:     PROCEDURE CarregarLista
369:         LOCAL loc_oGrid, loc_lSucesso
370:         loc_lSucesso = .F.
371: 
372:         IF THIS.this_oBusinessObject.Buscar(THIS.this_cEmpDopNums, THIS.this_cOpers)
373:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

*-- Linhas 383 a 403:
383:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contas"
384: 
385:                 loc_oGrid.Column1.Width = 100
386:                 loc_oGrid.Column1.Header1.Caption = "T" + CHR(237) + "tulo"
387:                 loc_oGrid.Column2.Width = 80
388:                 loc_oGrid.Column2.Header1.Caption = "Vencimento"
389:                 loc_oGrid.Column3.Width = 120
390:                 loc_oGrid.Column3.Header1.Caption = "Valor"
391:                 loc_oGrid.Column4.Width = 31
392:                 loc_oGrid.Column4.Header1.Caption = "Moe"
393:                 loc_oGrid.Column5.Width = 335
394:                 loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"
395:                 loc_oGrid.Column6.Width = 90
396:                 loc_oGrid.Column6.Header1.Caption = "Grupo"
397:                 loc_oGrid.Column7.Width = 90
398:                 loc_oGrid.Column7.Header1.Caption = "Conta"
399: 
400:                 SELECT cursor_4c_Dados
401:                 GO TOP
402:                 loc_oGrid.Refresh()
403: 

*-- Linhas 524 a 572:
524:     PROTECTED PROCEDURE ConfigurarCabecalho
525:         THIS.AddObject("cnt_4c_Sombra", "Container")
526:         WITH THIS.cnt_4c_Sombra
527:             .Top         = 0
528:             .Left        = 0
529:             .Width       = THIS.Width
530:             .Height      = 80
531:             .BackColor   = RGB(100, 100, 100)
532:             .BorderWidth = 0
533:             .SpecialEffect = 0
534:             .Visible     = .T.
535:         ENDWITH
536: 
537:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
538:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
539:             .Top         = 18
540:             .Left        = 10
541:             .Width       = 769
542:             .Height      = 40
543:             .FontName    = "Tahoma"
544:             .FontSize    = 18
545:             .FontBold    = .T.
546:             .WordWrap    = .T.
547:             .Alignment   = 0
548:             .BackStyle   = 0
549:             .ForeColor   = RGB(0, 0, 0)
550:             .Caption     = THIS.Caption
551:         ENDWITH
552: 
553:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
554:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
555:             .Top         = 17
556:             .Left        = 10
557:             .Width       = 769
558:             .Height      = 46
559:             .FontName    = "Tahoma"
560:             .FontSize    = 18
561:             .FontBold    = .T.
562:             .WordWrap    = .T.
563:             .Alignment   = 0
564:             .BackStyle   = 0
565:             .ForeColor   = RGB(255, 255, 255)
566:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
567:             .Caption     = THIS.Caption
568:         ENDWITH
569:     ENDPROC
570: 
571:     *==========================================================================
572:     * TornarControlesVisiveis - Torna todos os controles visiveis apos o


### BO (C:\4c\projeto\app\classes\sigmvtitBO.prg):
*==============================================================================
* sigmvtitBO.prg
*
* Business Object para Formsigmvtit (Titulos Gerados - Movimentacao)
* Tabela principal: SigMvCcr (contas a receber/pagar geradas por movimento)
* Joins: SigCdGcr (descricao do grupo), SigCdCli (descricao da conta)
*
* Form OPERACIONAL de CONSULTA: exibe, por Empresa+Operacao+Numero (chave
* EmpDopNums) e Opers, os titulos gerados na movimentacao. Nao ha
* Inserir/Atualizar/Excluir no legado (SIGMVTIT.SCX so consulta e imprime).
*==============================================================================

DEFINE CLASS sigmvtitBO AS BusinessBase

    *-- Chave de filtro recebida pelo form (LParameters pEDN, pOpe do legado)
    this_cEmpresa    = ""    && Empresa: Alltrim(Substr(pEDN, 01, 03))
    this_cOperacao   = ""    && Operacao (Dopes): Alltrim(Substr(pEDN, 04, 20))
    this_cNumero     = ""    && Numero: Alltrim(Substr(pEDN, 24, 06))
    this_cEmpDopNums = ""    && pEDN completo - char(29), usado no WHERE a.EmpDopNums =
    this_cOpers      = ""    && pOpe - char(1), usado no WHERE a.Opers =

    *-- Propriedades de dados do registro corrente da grade (SigMvCcr + joins)
    this_cTitulos  = ""      && SigMvCcr.titulos char(10)
    this_dVencs    = {}      && SigMvCcr.vencs datetime -> exibido via Ttod()
    this_nValors   = 0       && SigMvCcr.valors numeric(11,2)
    this_cMoedas   = ""      && SigMvCcr.moedas char(3)
    this_cHists    = ""      && SigMvCcr.hists char(60)
    this_cGrupos   = ""      && SigMvCcr.grupos char(10)
    this_cDGrupos  = ""      && SigCdGcr.descrs char(40) (Left Join por Grupos = Codigos)
    this_cContas   = ""      && SigMvCcr.contas char(10)
    this_cDContas  = ""      && SigCdCli.rclis char(50) (Left Join por Contas = Iclis)
    this_cDopcs    = ""      && SigMvCcr.dopcs char(20) (usado no botao de impressao - iDoc)
    this_nNumcs    = 0       && SigMvCcr.numcs numeric(6,0) (usado no botao de impressao - iDoc)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        THIS.this_cTabela = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Buscar - Popula cursor_4c_Dados com os titulos gerados na movimentacao
    *
    * Espelha literalmente a query do Init do legado (SIGMVTIT.SCX):
    *   Select a.Titulos, a.Vencs, a.Valors, a.Moedas, a.Hists, a.Grupos,
    *          b.Descrs as DGrupos, a.Contas, c.RClis as DContas, a.Dopcs, a.Numcs
    *   From SigMvCcr a
    *   Left Join SigCdGcr b On a.Grupos = b.Codigos
    *   Left Join SigCdCli c On a.Contas = c.IClis
    *   Where a.EmpDopNums = ?pEDN And a.Opers = ?pOpe
    *   Order By a.Vencs, a.Titulos, a.Grupos, a.Contas
    *
    * par_cEmpDopNums: chave POSICIONAL char(29) ja montada pelo form CHAMADOR
    * (Empresa char(3) + Operacao char(20) + Numero str(6)). NUNCA aplicar
    * ALLTRIM nela - o padding faz parte da chave (mesma familia do Erro177).
    *==========================================================================
    PROCEDURE Buscar(par_cEmpDopNums, par_cOpers)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    *-- vencs eh T (datetime), NAO D: SigMvCcr.vencs eh
                    *-- datetime no schema, e a grade liga a coluna via
                    *-- ControlSource = "TTOD(cursor_4c_Dados.vencs)". Com D
                    *-- aqui o TTOD receberia um DATE e estouraria o erro 11
                    *-- em runtime (regra CLAUDE.md #16) - o fallback tem de
                    *-- ter a MESMA estrutura que o SQLEXEC produz.
                    CREATE CURSOR cursor_4c_Dados (titulos C(10), vencs T, valors N(11,2), ;
                        moedas C(3), hists C(60), grupos C(10), dgrupos C(40), ;
                        contas C(10), dcontas C(50), dopcs C(20), numcs N(6,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_cSQL = "SELECT a.titulos, a.vencs, a.valors, a.moedas, a.hists, a.grupos, " + ;
                    "b.descrs AS dgrupos, a.contas, c.rclis AS dcontas, a.dopcs, a.numcs " + ;
                    "FROM SigMvCcr a " + ;
                    "LEFT JOIN SigCdGcr b ON a.grupos = b.codigos " + ;
                    "LEFT JOIN SigCdCli c ON a.contas = c.iclis " + ;
                    "WHERE a.empdopnums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
                    "AND a.opers = " + EscaparSQL(par_cOpers) + " " + ;
                    "ORDER BY a.vencs, a.titulos, a.grupos, a.contas"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        GO TOP
                    ENDIF
                ELSE
                    MostrarErro("Erro ao buscar t" + CHR(237) + "tulos gerados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "sigmvtitBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do registro corrente de
    * cursor_4c_Dados (equivalente ao AfterRowColChange do legado, que
    * espelhava LocalTits.DGrupos/DContas nos GETs de descricao)
    *
    * PUBLIC de proposito: BusinessBase.CarregarDoCursor eh PUBLIC e o form
    * chama este metodo de FORA da classe (AtualizarDescricoes). Declarar
    * PROTECTED aqui estreitaria a visibilidade da base e a chamada falharia em
    * RUNTIME com "Property CARREGARDOCURSOR is not found" - mesma armadilha da
    * regra CLAUDE.md #3 (PEMSTATUS so verifica existencia, nao escopo).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF()
                    THIS.this_cTitulos  = TratarNulo(titulos,  "")
                    THIS.this_dVencs    = ConverterParaData(vencs)
                    THIS.this_nValors   = TratarNulo(valors,   0)
                    THIS.this_cMoedas   = TratarNulo(moedas,   "")
                    THIS.this_cHists    = TratarNulo(hists,    "")
                    THIS.this_cGrupos   = TratarNulo(grupos,   "")
                    THIS.this_cDGrupos  = TratarNulo(dgrupos,  "")
                    THIS.this_cContas   = TratarNulo(contas,   "")
                    THIS.this_cDContas  = TratarNulo(dcontas,  "")
                    THIS.this_cDopcs    = TratarNulo(dopcs,    "")
                    THIS.this_nNumcs    = TratarNulo(numcs,    0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigmvtitBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Identificador do registro corrente da grade, usado
    * apenas se algum dia a base chamar RegistrarAuditoria (form eh consulta,
    * nao grava nada por conta propria)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cTitulos
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao: SIGMVTIT eh um form de CONSULTA
    * (visualizador de titulos gerados na movimentacao, aberto via DO FORM
    * com Empresa/Operacao/Numero). O legado (SIGMVTIT.SCX) nao tem nenhum
    * INSERT/UPDATE/DELETE - so exibe a grade e imprime (botao iDoc chama
    * outro form, SigReIdt). O comportamento padrao herdado de BusinessBase
    * (recusar a operacao) ja eh o correto - nao ha necessidade de
    * sobrescrever esses tres metodos aqui.
    *==========================================================================

ENDDEFINE

