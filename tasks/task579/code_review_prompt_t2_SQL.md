# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, OPERS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
  Column1.ControlSource = ""
		lcQuery = [Select a.Titulos, a.Vencs, a.Valors, a.Moedas, a.Hists, a.Grupos, ] + ;
					[From SigMvCcr a ] + ;
					[Left Join SigCdGcr b On a.Grupos = b.Codigos ] + ;
					[Left Join SigCdCli c On a.Contas = c.IClis ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [LocalTits]) < 1)
		Select LocalTits
			.Column1.ControlSource = [LocalTits.Titulos]
			.Column2.ControlSource = [Ttod(LocalTits.Vencs)]
			.Column3.ControlSource = [LocalTits.Valors]
			.Column4.ControlSource = [LocalTits.Moedas]
			.Column5.ControlSource = [LocalTits.Hists]
			.Column6.ControlSource = [LocalTits.Grupos]
			.Column7.ControlSource = [LocalTits.Contas]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvtit.prg) - TRECHOS RELEVANTES PARA PASS SQL (608 linhas total):

*-- Linhas 59 a 77:
59: * editaveis que o legado nunca teve) e a regra de completude (ficariam
60: * vazios, sem o que Buscar/Salvar/Cancelar numa tela que so consulta e
61: * imprime). A funcionalidade REAL de consolidacao ja esta implementada:
62: *   - CarregarLista()            -> SqlExecute do Init legado (Fase 3/4)
63: *   - AtualizarDescricoes()      -> AfterRowColChange (Fase 6, espelha o
64: *                                    BO->Form que FormParaBO/BOParaForm
65: *                                    fariam se houvesse campo editavel)
66: *   - BtnSairClick() (Encerrar)  -> cmdSair.Click = ThisForm.Release (F7)
67: *   - BtnIDocClick() (acao)      -> iDoc.Click = Do Form SigReIdt (F7)
68: *   - Destroy()                  -> ThisForm.poDataMgr.Release + libera
69: *                                    cursor_4c_Dados (consolidacao final)
70: * Mesma familia de excecao das licoes "Gate da Fase 8 exigia botao de
71: * acao que o legado nao tem" (SIGMVCTH/SIGMVSBN) - aqui com DOIS botoes
72: * de acao real (nao apenas Release), entao a dispensa passa pelo ramo
73: * $legadoVisualizadorF8 (nao pelo ramo "legadoSemAcao com 1 botao").
74: *
75: * CHAMADA (equivalente a DO FORM SigMvTit WITH pEDN, pOpe do legado):
76: *   loForm = CREATEOBJECT("Formsigmvtit", par_cEmpDopNums, par_cOpers)
77: *   loForm.Show()

*-- Linhas 159 a 197:
159:             THIS.ConfigurarCabecalho()
160:             THIS.ConfigurarPaginaLista()
161: 
162:             *-- Init legado: Return .f. quando SqlExecute(lcQuery, [LocalTits]) < 1
163:             *-- (erro OU zero linhas) - a tela NAO abre. Este form so eh chamado
164:             *-- a partir de uma movimentacao que ja gerou titulos, entao lista
165:             *-- vazia eh anomalia, nao caminho normal (ver CarregarLista).
166:             IF THIS.CarregarLista()
167:                 THIS.TornarControlesVisiveis(THIS)
168:                 loc_lSucesso = .T.
169:             ENDIF
170:         ENDIF
171: 
172:         RETURN loc_lSucesso
173:     ENDPROC
174: 
175:     *==========================================================================
176:     * ConfigurarPaginaLista - Cria a grade de titulos (grdTitulos), os campos
177:     * de descricao readonly (getDGrupos/getDContas + labels) e os botoes OK
178:     * (cmdSair) e Impressao (iDoc), todos direto na Form (layout FLAT, sem
179:     * PageFrame/Page1/Page2 - regra ja fixada na Fase 3). Somente estrutura e
180:     * propriedades que NAO dependem de dado - RecordSource/ControlSource dos
181:     * campos do grid entram em CarregarLista (regra CLAUDE.md #41: Column.
182:     * ControlSource antes do cursor existir derruba o Init).
183:     *==========================================================================
184:     PROTECTED PROCEDURE ConfigurarPaginaLista
185:         LOCAL loc_nCol
186: 
187:         *-- Shape1 do legado - decorativo, atras do botao OK (BackStyle=0 +
188:         *-- BorderStyle=0 = sem preenchimento e sem borda, ou seja, invisivel
189:         *-- em runtime; migrado apenas por fidelidade estrutural ao SCX).
190:         THIS.AddObject("shp_4c_Shape1", "Shape")
191:         WITH THIS.shp_4c_Shape1
192:             .Top         = 0
193:             .Left        = 923
194:             .Width       = 75
195:             .Height      = 79
196:             .BackStyle   = 0
197:             .BorderStyle = 0

*-- Linhas 208 a 226:
208:             .ColumnCount   = 7
209:             .FontName      = "Tahoma"
210:             .FontSize      = 8
211:             .DeleteMark    = .F.
212:             .RecordMark    = .F.
213:             .RowHeight     = 16
214:             .ScrollBars    = 2
215:             .GridLineColor = RGB(238, 238, 238)
216:             .ReadOnly      = .T.
217:         ENDWITH
218: 
219:         *-- Propriedades comuns das 7 colunas (Width/Header1.Caption entram em
220:         *-- CarregarLista, DEPOIS do RecordSource - regra CLAUDE.md Problema 48)
221:         FOR loc_nCol = 1 TO 7
222:             WITH THIS.grd_4c_Titulos.Columns(loc_nCol)
223:                 .FontName          = "Tahoma"
224:                 .FontSize          = 8
225:                 .Movable           = .F.
226:                 .Resizable         = .F.

*-- Linhas 360 a 415:
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
374:                 loc_oGrid = THIS.grd_4c_Titulos
375: 
376:                 loc_oGrid.RecordSource          = "cursor_4c_Dados"
377:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.titulos"
378:                 loc_oGrid.Column2.ControlSource = "TTOD(cursor_4c_Dados.vencs)"
379:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.valors"
380:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moedas"
381:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.hists"
382:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupos"
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
404:                 THIS.AtualizarDescricoes()
405: 
406:                 loc_lSucesso = .T.
407:             ELSE
408:                 MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalTits)")
409:             ENDIF
410:         ENDIF
411: 
412:         RETURN loc_lSucesso
413:     ENDPROC
414: 
415:     *==========================================================================


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

