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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLhi.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (732 linhas total):

*-- Linhas 16 a 25:
16: * um dialogo modal de conferencia, nao um cadastro (ver NATUREZA acima). As
17: * fases anteriores entregaram a estrutura base (DEFINE CLASS, Init,
18: * InicializarForm, cabecalho), o grid de lancamentos (grd_4c_Dados, ligado a
19: * cursor_4c_Lancamentos), o label de aviso (lbl_4c_Label1) e os dois botoes do
20: * legado (cmd_4c_Confirma "Ok" / cmd_4c_Cancela "Encerrar").
21: *
22: * FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: o legado tem EXATAMENTE DOIS
23: * botoes (SIGOPLHI.Confirma e SIGOPLHI.Cancela, ambos BaseClass commandbutton
24: * soltos no form) e NENHUMA barra CRUD - o dump nao tem frmcadastro, nao tem
25: * Grupo_Op, nao tem pcEscolha e nao tem botao com verbo de registro. Os

*-- Linhas 43 a 51:
43: *                      Eh por elas que o pai le o resultado do dialogo.
44: *   BOParaForm()     - leva o titulo montado pelo BO para o Caption e para os
45: *                      DOIS labels do cabecalho, exatamente como o Init legado
46: *                      ("cntSombra.lblSombra.Caption = ThisForm.Caption" e
47: *                      idem lblTitulo), e repinta a grade.
48: *   RepintarGrade()  - funil unico de repintura (regra #21a: popular/navegar
49: *                      cursor NAO repinta a grade sozinho).
50: *   BtnOkClick()     - Confirma.Click do legado (Caption "\<Ok").
51: *   BtnCancelarClick() - Cancela.Click do legado (Caption "Encerrar",

*-- Linhas 144 a 154:
144:                 ENDIF
145: 
146:                 IF !EMPTY(THIS.this_oBusinessObject.this_cTituloDialogo)
147:                     THIS.Caption = THIS.this_oBusinessObject.this_cTituloDialogo
148:                 ELSE
149:                     THIS.Caption = "Lan" + CHR(231) + "amentos em Conta Corrente"
150:                 ENDIF
151: 
152:                 THIS.GarantirCursorLancamentos()
153: 
154:                 THIS.ConfigurarCabecalho()

*-- Linhas 177 a 226:
177:     PROTECTED PROCEDURE ConfigurarCabecalho()
178:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
179:         WITH THIS.cnt_4c_Cabecalho
180:             .Top = 0
181:             .Left = 0
182:             .Width = THIS.Width
183:             .Height = 80
184:             .BackColor = RGB(100, 100, 100)
185:             .BorderWidth = 0
186:             .Visible = .T.
187:         ENDWITH
188: 
189:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
190:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
191:             .FontName = "Tahoma"
192:             .FontSize = 18
193:             .FontBold = .T.
194:             .Alignment = 0
195:             .BackStyle = 0
196:             .AutoSize = .F.
197:             .WordWrap = .T.
198:             .Left = 10
199:             .Top = 18
200:             .Width = THIS.Width - 31
201:             .Height = 40
202:             .ForeColor = RGB(0, 0, 0)
203:             .Caption = THIS.Caption
204:             .Visible = .T.
205:         ENDWITH
206: 
207:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
208:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
209:             .FontName = "Tahoma"
210:             .FontSize = 18
211:             .FontBold = .T.
212:             .Alignment = 0
213:             .BackStyle = 0
214:             .AutoSize = .F.
215:             .WordWrap = .T.
216:             .Left = 10
217:             .Top = 17
218:             .Width = THIS.Width - 31
219:             .Height = 46
220:             .ForeColor = RGB(255, 255, 255)
221:             .Caption = THIS.Caption
222:             .Visible = .T.
223:         ENDWITH
224:     ENDPROC
225: 
226:     *--------------------------------------------------------------------------

*-- Linhas 235 a 258:
235:     PROTECTED PROCEDURE ConfigurarBotoes()
236:         THIS.AddObject("cnt_4c_Botoes", "Container")
237:         WITH THIS.cnt_4c_Botoes
238:             .Top = 3
239:             .Left = 645
240:             .Width = 150
241:             .Height = 75
242:             .BackStyle = 0
243:             .BorderWidth = 0
244:             .Visible = .T.
245:         ENDWITH
246: 
247:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Confirma", "CommandButton")
248:         WITH THIS.cnt_4c_Botoes.cmd_4c_Confirma
249:             .Top = 0
250:             .Left = 5
251:             .Width = 75
252:             .Height = 75
253:             .Caption = "\<Ok"
254:             .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
255:             .FontName = "Comic Sans MS"
256:             .FontBold = .T.
257:             .FontItalic = .T.
258:             .FontSize = 8

*-- Linhas 268 a 282:
268:             .Visible = .T.
269:         ENDWITH
270: 
271:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Cancela", "CommandButton")
272:         WITH THIS.cnt_4c_Botoes.cmd_4c_Cancela
273:             .Top = 0
274:             .Left = 80
275:             .Width = 75
276:             .Height = 75
277:             .Caption = "Encerrar"
278:             .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
279:             .FontName = "Comic Sans MS"
280:             .FontBold = .T.
281:             .FontItalic = .T.
282:             .FontSize = 8

*-- Linhas 292 a 324:
292:             .Visible = .T.
293:         ENDWITH
294: 
295:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Confirma, "Click", THIS, "BtnOkClick")
296:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
297:     ENDPROC
298: 
299:     *--------------------------------------------------------------------------
300:     * ConfigurarLabelInfo - Label1 do legado: aviso fixo acima do grid,
301:     * "Lancamentos que serao efetuados em Conta Corrente". Classe say
302:     * (AutoSize=.T. no SCX) - regra #23 do CLAUDE.md: AutoSize eh no-op em
303:     * Label criado por AddObject, entao transcrevemos Width/Height do dump
304:     * (263x15) com AutoSize=.F. explicito.
305:     *--------------------------------------------------------------------------
306:     PROTECTED PROCEDURE ConfigurarLabelInfo()
307:         THIS.AddObject("lbl_4c_Label1", "Label")
308:         WITH THIS.lbl_4c_Label1
309:             .FontName = "Tahoma"
310:             .FontSize = 8
311:             .BackStyle = 0
312:             .AutoSize = .F.
313:             .Alignment = 0
314:             .Left = 117
315:             .Top = 133
316:             .Width = 263
317:             .Height = 15
318:             .ForeColor = RGB(90, 90, 90)
319:             .Caption = "Lan" + CHR(231) + "amentos que ser" + CHR(227) + "o efetuados em Conta Corrente"
320:             .Visible = .T.
321:         ENDWITH
322:     ENDPROC
323: 
324:     *--------------------------------------------------------------------------

*-- Linhas 336 a 345:
336: 
337:         THIS.AddObject("grd_4c_Dados", "Grid")
338:         WITH THIS.grd_4c_Dados
339:             .Top = 152
340:             .Left = 114
341:             .Width = 571
342:             .Height = 158
343:             .FontName = "Tahoma"
344:             .FontSize = 8
345:             .AllowHeaderSizing = .F.

*-- Linhas 361 a 421:
361:             .ReadOnly = .T.
362:             .FontName = "Tahoma"
363:             .FontSize = 8
364:             .Header1.Caption = "Grupo"
365:             .Header1.Alignment = 2
366:             .Header1.ForeColor = RGB(90, 90, 90)
367:         ENDWITH
368: 
369:         WITH THIS.grd_4c_Dados.Column2
370:             .ControlSource = loc_cAlias + ".Contas"
371:             .Width = 65
372:             .Movable = .F.
373:             .Resizable = .F.
374:             .ReadOnly = .T.
375:             .FontName = "Tahoma"
376:             .FontSize = 8
377:             .Header1.Caption = "Conta"
378:             .Header1.Alignment = 2
379:             .Header1.ForeColor = RGB(90, 90, 90)
380:         ENDWITH
381: 
382:         WITH THIS.grd_4c_Dados.Column3
383:             .ControlSource = loc_cAlias + ".Hists"
384:             .Width = 290
385:             .Movable = .F.
386:             .Resizable = .F.
387:             .ReadOnly = .F.
388:             .FontName = "Tahoma"
389:             .FontSize = 8
390:             .Header1.Caption = "Hist" + CHR(243) + "rico"
391:             .Header1.Alignment = 2
392:             .Header1.ForeColor = RGB(90, 90, 90)
393:         ENDWITH
394: 
395:         WITH THIS.grd_4c_Dados.Column4
396:             .ControlSource = loc_cAlias + ".Valor"
397:             .Width = 83
398:             .Movable = .F.
399:             .Resizable = .F.
400:             .ReadOnly = .T.
401:             .FontName = "Tahoma"
402:             .FontSize = 8
403:             .Header1.Caption = "Valor"
404:             .Header1.Alignment = 2
405:             .Header1.ForeColor = RGB(90, 90, 90)
406:         ENDWITH
407: 
408:         WITH THIS.grd_4c_Dados.Column5
409:             .ControlSource = loc_cAlias + ".Moeda"
410:             .Width = 25
411:             .Movable = .F.
412:             .Resizable = .F.
413:             .ReadOnly = .T.
414:             .FontName = "Tahoma"
415:             .FontSize = 8
416:             .Header1.Caption = "Moe"
417:             .Header1.Alignment = 2
418:             .Header1.ForeColor = RGB(90, 90, 90)
419:         ENDWITH
420: 
421:         THIS.grd_4c_Dados.Visible = .T.

*-- Linhas 568 a 577:
568:     * (SigOpLhiBO.MontarTitulo, "Lancamentos para <Dopes> - <MascNum>") para o
569:     * Caption do form e para os DOIS labels do cabecalho, reproduzindo o Init
570:     * legado:
571:     *     ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
572:     *     ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
573:     * e fecha repintando a grade pelo funil unico (regra #21a).
574:     *
575:     * Titulo vazio NAO sobrescreve o Caption ja montado pelo InicializarForm -
576:     * o dialogo pode ser aberto sem o cursor de contexto (instanciacao isolada),
577:     * e nesse caso o fallback generico deve permanecer.

*-- Linhas 585 a 601:
585:         TRY
586:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
587:                 IF !EMPTY(THIS.this_oBusinessObject.this_cTituloDialogo)
588:                     THIS.Caption = THIS.this_oBusinessObject.this_cTituloDialogo
589:                 ENDIF
590:             ENDIF
591: 
592:             loc_cTitulo = THIS.Caption
593: 
594:             IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
595:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
596:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
597:             ENDIF
598: 
599:             THIS.RepintarGrade()
600:             loc_lSucesso = .T.
601:         CATCH TO loc_oErro


### BO (C:\4c\projeto\app\classes\SigOpLhiBO.prg):
*==============================================================================
* SIGOPLHIBO.PRG
* Business Object para o dialogo de Lancamentos em Conta Corrente
* (SIGOPLHI - dialogo filho MODAL aberto pelo form pai SIGCDPGR via
*  "Do Form SigOpLhi With ThisForm", NAO acessivel direto pelo menu)
*
* Tabela de contexto : SigCdPgr (programacao de pagamento/recebimento)
* Chave Real (PK)    : cidchaves  CHAR(20)
*
* NATUREZA DESTE DIALOGO (lido do legado, SIGCDPGR linhas 13197-13460):
*   O form PAI monta em memoria o cursor local TmpLanca com os lancamentos
*   que serao efetuados em Conta Corrente:
*
*     Create Cursor TmpLanca ( Grupos c(10), Contas c(10), Moeda c(3),
*                              Cotacaos n(14,4), GrupoC c(10), ContaC c(10),
*                              MoedaC c(3), CotacaoC n(14,4), Hists c(40),
*                              Valor n(12,2), ValPag n(12,2), Tipos c(1),
*                              ValorC n(12,2), ValPagC n(12,2), Hist2s c(40))
*     Index on Grupos + Contas + Moeda + Tipos + GrupoC + ContaC + MoedaC
*              + Hists + Hist2s Tag GruConMoe
*
*   e so entao abre este dialogo (somente quando !Eof() e
*   PgRecParam.MudaHists = 1). O usuario CONFERE a lista e pode EDITAR a
*   coluna Historico (Hists) - e a unica Column do grid sem ReadOnly = .T.
*   no SCX. Ao sair:
*     Confirma ("Ok")      -> ThisForm.Release (o pai segue e, quando
*                             crSigCdPac.UniHists = 1, le de volta
*                             ThisForm.HistoricoCliente = TmpLanca.Hists)
*     Cancela ("Encerrar") -> ThisForm.ParentForm.CanceladoExterno = .T.
*                             + ThisForm.Release (o pai aborta a baixa)
*
*   Portanto o destino de TODA escrita deste dialogo eh o CURSOR LOCAL do pai -
*   nao existe Insert Into / Update / Delete From / TableUpdate / AddCursor
*   sobre tabela do SQL Server em nenhum metodo do SIGOPLHI. O acesso remoto
*   do legado se resume a LEITURA de crSigCdPgr (Dopes + MascNum) para montar
*   o Caption. Por isso este BO NAO sobrescreve Inserir()/Atualizar()/
*   ExecutarExclusao(): o comportamento padrao herdado de BusinessBase (recusar
*   a operacao e reportar pelo ExibirFalha do Salvar) ja eh o correto, e
*   inventar INSERT/UPDATE aqui violaria a regra #22 do CLAUDE.md (a lista de
*   colunas vem do schema, nunca de adivinhacao).
*
* CAPTION DO LEGADO (Init do SIGOPLHI):
*   'Lancamentos para ' + Alltrim(crSigCdPgr.Dopes) + ' - '
*                       + Alltrim(crSigCdPgr.MascNum)
*   e o mesmo texto vai para cntSombra.lblSombra.Caption e lblTitulo.Caption.
*
* ATENCAO AO DUMP DO SCX (divergencia herdada, confirmada no legado):
*   Grade.Column3.ControlSource       = "HISTS"  <- vale este (a Column manda)
*   Grade.Column3.Text1.ControlSource = "Nomes"  <- residuo: TmpLanca NAO tem
*                                                   coluna Nomes
*==============================================================================

DEFINE CLASS SigOpLhiBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTEXTO - SigCdPgr (crSigCdPgr no legado)
    * Somente leitura: alimenta o Caption / titulo do dialogo.
    * O sufixo "Pgr" existe porque SigCdPgr TAMBEM tem as colunas grupos e
    * contas, que colidiriam com as colunas homonimas de TmpLanca abaixo.
    *--------------------------------------------------------------------------
    this_cDopes             = ""   && dopes      CHAR(20)      - tipo de documento
    this_cMascNum           = ""   && mascnum    CHAR(6)       - numero mascarado
    this_cCidChaves         = ""   && cidchaves  CHAR(20)      - chave primaria real
    this_cEmps              = ""   && emps       CHAR(3)       - empresa
    this_nNumes             = 0    && numes      NUMERIC(6,0)  - numero do documento
    this_cGruposPgr         = ""   && grupos     CHAR(10)      - grupo da programacao
    this_cContasPgr         = ""   && contas     CHAR(10)      - conta da programacao
    this_cEmpDopNums        = ""   && empdopnums CHAR(29)      - chave posicional

    *--------------------------------------------------------------------------
    * LINHA CORRENTE DO CURSOR DE LANCAMENTOS (TmpLanca)
    * Nomes espelhados coluna a coluna para eliminar divergencia de
    * nomenclatura entre Form e BO (CLAUDE.md / Pattern #177).
    * As colunas sem sufixo sao o lado principal do lancamento; as terminadas
    * em "C" sao a contrapartida.
    *--------------------------------------------------------------------------
    this_cGrupos            = ""   && Grupos     CHAR(10)      - grupo da conta (grid "Grupo")
    this_cContas            = ""   && Contas     CHAR(10)      - conta (grid "Conta")
    this_cMoeda             = ""   && Moeda      CHAR(3)       - moeda (grid "Moe")
    this_nCotacaos          = 0    && Cotacaos   NUMERIC(14,4) - cotacao da moeda
    this_cGrupoC            = ""   && GrupoC     CHAR(10)      - grupo da contrapartida
    this_cContaC            = ""   && ContaC     CHAR(10)      - conta da contrapartida
    this_cMoedaC            = ""   && MoedaC     CHAR(3)       - moeda da contrapartida
    this_nCotacaoC          = 0    && CotacaoC   NUMERIC(14,4) - cotacao da contrapartida
    this_cHists             = ""   && Hists      CHAR(40)      - historico (grid, EDITAVEL)
    this_cHist2s            = ""   && Hist2s     CHAR(40)      - historico complementar
    this_nValor             = 0    && Valor      NUMERIC(12,2) - valor (grid "Valor")
    this_nValPag            = 0    && ValPag     NUMERIC(12,2) - valor pago
    this_cTipos             = ""   && Tipos      CHAR(1)       - tipo do lancamento
    this_nValorC            = 0    && ValorC     NUMERIC(12,2) - valor da contrapartida
    this_nValPagC           = 0    && ValPagC    NUMERIC(12,2) - valor pago da contrapartida

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    * this_cCursorLancamentos : alias migrado de TmpLanca. O cursor eh criado e
    *   populado pelo form PAI; este dialogo apenas o exibe e edita o Hists.
    * this_lCanceladoExterno  : espelha ThisForm.ParentForm.CanceladoExterno do
    *   legado - .T. quando o usuario saiu pelo botao Encerrar (Cancela).
    *--------------------------------------------------------------------------
    this_cCursorLancamentos = "cursor_4c_Lancamentos"
    this_cTituloDialogo     = ""
    this_lCanceladoExterno  = .F.
    this_nTotalLancamentos  = 0

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * DODEFAULT() sem parametro: nao instancia DataAccess, porque este dialogo
    * nao grava em tabela remota (ver cabecalho). this_cTabela e
    * this_cCampoChave apontam para a tabela de CONTEXTO, lida para montar o
    * titulo do dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdPgr"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da tabela de contexto (cidchaves).
    * PROTECTED por contrato da BusinessBase (CLAUDE.md regra #51): nunca
    * chamar de fora do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia o cursor de CONTEXTO (SigCdPgr, crSigCdPgr no
    * legado) para as propriedades this_c*/this_n* que identificam o registro
    * pai e alimentam o titulo do dialogo. Chamado pelo Form a partir do
    * cursor de contexto que o form PAI ja mantem aberto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cDopes      = TratarNulo(dopes, "")
        THIS.this_cMascNum    = TratarNulo(mascnum, "")
        THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
        THIS.this_cEmps       = TratarNulo(emps, "")
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_cGruposPgr  = TratarNulo(grupos, "")
        THIS.this_cContasPgr  = TratarNulo(contas, "")
        THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")

        THIS.MontarTitulo()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarTitulo - Reproduz o Caption do Init legado:
    *   'Lancamentos para ' + Alltrim(Dopes) + ' - ' + Alltrim(MascNum)
    * Alimenta this_cTituloDialogo, usado pelo Form no Caption do form e nos
    * dois labels do cabecalho (lbl_4c_Sombra / lbl_4c_Titulo).
    *--------------------------------------------------------------------------
    PROCEDURE MontarTitulo()
        THIS.this_cTituloDialogo = "Lan" + CHR(231) + "amentos para " + ;
            ALLTRIM(THIS.this_cDopes) + " - " + ALLTRIM(THIS.this_cMascNum)

        RETURN THIS.this_cTituloDialogo
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLinhaAtual - Copia a linha CORRENTE do cursor de lancamentos
    * (TmpLanca no legado) para as propriedades this_* da linha. O Grid
    * continua ligado DIRETO ao cursor via ControlSource - este metodo existe
    * para o Form consultar/validar a linha corrente fora do Grid (regra #46:
    * validacao de celula vai no Valid do TextBox da coluna, nunca em
    * AfterRowColChange).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLinhaAtual(par_cAliasLancamentos)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos), ;
            par_cAliasLancamentos, THIS.this_cCursorLancamentos)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)

        THIS.this_cGrupos   = TratarNulo(Grupos, "")
        THIS.this_cContas   = TratarNulo(Contas, "")
        THIS.this_cMoeda    = TratarNulo(Moeda, "")
        THIS.this_nCotacaos = TratarNulo(Cotacaos, 0)
        THIS.this_cGrupoC   = TratarNulo(GrupoC, "")
        THIS.this_cContaC   = TratarNulo(ContaC, "")
        THIS.this_cMoedaC   = TratarNulo(MoedaC, "")
        THIS.this_nCotacaoC = TratarNulo(CotacaoC, 0)
        THIS.this_cHists    = TratarNulo(Hists, "")
        THIS.this_cHist2s   = TratarNulo(Hist2s, "")
        THIS.this_nValor    = TratarNulo(Valor, 0)
        THIS.this_nValPag   = TratarNulo(ValPag, 0)
        THIS.this_cTipos    = TratarNulo(Tipos, "")
        THIS.this_nValorC   = TratarNulo(ValorC, 0)
        THIS.this_nValPagC  = TratarNulo(ValPagC, 0)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarHistorico - Grava o novo texto de Historico na linha CORRENTE do
    * cursor de lancamentos. Eh a UNICA coluna editavel do grid no legado
    * (Grade.Column3 sem ReadOnly = .T. no SCX) - Grupo/Conta/Valor/Moe sao
    * somente leitura (Column1/2/4/5 com ReadOnly = .T.).
    *--------------------------------------------------------------------------
    PROCEDURE GravarHistorico(par_cAliasLancamentos, par_cNovoHistorico)
        LOCAL loc_cAlias, loc_cValor

        loc_cAlias = IIF(VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos), ;
            par_cAliasLancamentos, THIS.this_cCursorLancamentos)
        loc_cValor = IIF(VARTYPE(par_cNovoHistorico) = "C", par_cNovoHistorico, "")

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        REPLACE Hists WITH loc_cValor IN (loc_cAlias)
        THIS.this_cHists = loc_cValor

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ContarLancamentos - Total de linhas do cursor de lancamentos. O form PAI
    * so abre este dialogo quando !Eof() (ver cabecalho) - o Form usa este
    * metodo para confirmar que ha o que exibir antes de tornar o grid ativo.
    *--------------------------------------------------------------------------
    PROCEDURE ContarLancamentos(par_cAliasLancamentos)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos), ;
            par_cAliasLancamentos, THIS.this_cCursorLancamentos)

        IF !USED(loc_cAlias)
            THIS.this_nTotalLancamentos = 0
        ELSE
            THIS.this_nTotalLancamentos = RECCOUNT(loc_cAlias)
        ENDIF

        RETURN THIS.this_nTotalLancamentos
    ENDPROC

ENDDEFINE

