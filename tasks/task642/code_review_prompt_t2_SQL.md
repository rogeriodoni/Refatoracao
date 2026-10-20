# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MARCAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CNOMARQS, NMARCAS

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
Select crGerArq

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpArq.prg) - TRECHOS RELEVANTES PARA PASS SQL (891 linhas total):

*-- Linhas 195 a 251:
195:     * texto (Column2 = arquivo de destino escolhido, Column3 = descricao
196:     * do item). Liga em cursor_4c_Dados - criado aqui como placeholder com
197:     * a MESMA estrutura que SigOpArqBO.CarregarItensGrade usa, para o
198:     * Column.ControlSource ja poder ser definido nesta fase (regra: nunca
199:     * ControlSource de cursor que ainda nao existe).
200:     *==========================================================================
201:     PROTECTED PROCEDURE ConfigurarGrid()
202:         LOCAL loc_oGrid
203: 
204:         IF !USED("cursor_4c_Dados")
205:             SET NULL ON
206:             CREATE CURSOR cursor_4c_Dados ;
207:                 (Codigos C(10), Descricao C(40), Marcas N(1,0), NomArqs C(254))
208:             SET NULL OFF
209:         ENDIF
210: 
211:         THIS.AddObject("grd_4c_Dados", "Grid")
212:         loc_oGrid = THIS.grd_4c_Dados
213: 
214:         *-- ColumnCount/RecordSource FORA do WITH (referencia explicita): o
215:         *-- WITH seguinte acessa .Column1/.Column2/.Column3, e as colunas so
216:         *-- existem depois que estas duas propriedades ja tiverem rodado.
217:         loc_oGrid.ColumnCount  = 3
218:         loc_oGrid.RecordSource = "cursor_4c_Dados"
219: 
220:         WITH loc_oGrid
221:             .Top            = 85
222:             .Left           = 60
223:             .Width          = 469
224:             .Height         = 83
225:             .FontName       = "Tahoma"
226:             .FontSize       = 8
227:             .AllowRowSizing = .F.
228:             .DeleteMark     = .F.
229:             .RecordMark     = .F.
230:             .RowHeight      = 16
231:             .ScrollBars     = 2
232:             .GridLineColor  = RGB(238, 238, 238)
233: 
234:             *-- Column1 = Check1 ("Marcas") - ColumnOrder=3, ou seja exibida
235:             *-- por ULTIMO (a direita), fiel ao dump do SCX legado
236:             .Column1.ControlSource = "cursor_4c_Dados.Marcas"
237:             .Column1.ColumnOrder   = 3
238:             .Column1.Width         = 20
239:             .Column1.Movable       = .F.
240:             .Column1.Resizable     = .F.
241:             .Column1.ReadOnly      = .F.
242:             .Column1.Sparse        = .F.
243:             .Column1.FontName      = "Tahoma"
244:             .Column1.FontSize      = 8
245:             .Column1.Header1.Caption   = ""
246:             .Column1.Header1.FontName  = "Tahoma"
247:             .Column1.Header1.FontSize  = 8
248:             .Column1.Header1.ForeColor = RGB(36, 84, 155)
249: 
250:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
251:             WITH .Column1.chk_4c_Marca

*-- Linhas 275 a 313:
275:             *-- Column2 = Text1 ("Arquivo") - ColumnOrder=1, exibida primeiro
276:             *-- (a esquerda). Mostra o caminho escolhido via PutFile ao
277:             *-- marcar o Check1 (NomArqs) - so leitura na grade.
278:             .Column2.ControlSource = "cursor_4c_Dados.NomArqs"
279:             .Column2.ColumnOrder   = 1
280:             .Column2.Width         = 111
281:             .Column2.Movable       = .F.
282:             .Column2.Resizable     = .F.
283:             .Column2.ReadOnly      = .T.
284:             .Column2.FontName      = "Tahoma"
285:             .Column2.FontSize      = 8
286:             .Column2.Header1.Caption   = "Arquivo"
287:             .Column2.Header1.Alignment = 2
288:             .Column2.Header1.FontName  = "Tahoma"
289:             .Column2.Header1.FontSize  = 8
290:             .Column2.Header1.ForeColor = RGB(36, 84, 155)
291:             .Column2.Text1.BorderStyle = 0
292:             .Column2.Text1.Margin      = 0
293:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
294:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
295: 
296:             *-- Column3 = Text1 ("Nome do Arquivo") - ColumnOrder=2, exibida
297:             *-- ao centro. Mostra a descricao do item (Linha ou Grupo).
298:             .Column3.ControlSource = "cursor_4c_Dados.Descricao"
299:             .Column3.ColumnOrder   = 2
300:             .Column3.Width         = 338
301:             .Column3.Movable       = .F.
302:             .Column3.Resizable     = .F.
303:             .Column3.ReadOnly      = .T.
304:             .Column3.FontName      = "Tahoma"
305:             .Column3.FontSize      = 8
306:             .Column3.Header1.Caption   = "Nome do Arquivo"
307:             .Column3.Header1.Alignment = 2
308:             .Column3.Header1.FontName  = "Tahoma"
309:             .Column3.Header1.FontSize  = 8
310:             .Column3.Header1.ForeColor = RGB(36, 84, 155)
311:             .Column3.Text1.BorderStyle = 0
312:             .Column3.Text1.Margin      = 0
313:             .Column3.Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 467 a 485:
467:     *==========================================================================
468:     * CarregarLista - Popula cursor_4c_Dados via SigOpArqBO.Buscar() (SQL
469:     * para SigCdLin/SigCdGrp, conforme this_nTipos) e repinta a grade.
470:     * RecordSource/ControlSource ja foram definidos uma unica vez em
471:     * ConfigurarGrid() - aqui so GO TOP + Refresh (regra: popular cursor
472:     * nao repinta a grade sozinho).
473:     *==========================================================================
474:     PROCEDURE CarregarLista()
475:         LOCAL loc_lSucesso
476:         loc_lSucesso = .F.
477: 
478:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
479:             loc_lSucesso = THIS.this_oBusinessObject.Buscar("")
480:         ENDIF
481: 
482:         IF USED("cursor_4c_Dados")
483:             GO TOP IN cursor_4c_Dados
484:         ENDIF
485: 


### BO (C:\4c\projeto\app\classes\SigOpArqBO.prg):
*==============================================================================
* SigOpArqBO.prg - Business Object para Geracao de Arquivos (Exportacao)
* Form OPERACIONAL - nao segue padrao CRUD Page1=Lista/Page2=Dados
* Legado: SIGOPARQ.SCX (form filho, compartilhava DataSession com o form pai
*         via Lparameters poForm e operava sobre o cursor crGerArq)
* Tabela principal de referencia (dinamica conforme Tipos): SigCdLin / SigCdGrp
*==============================================================================

DEFINE CLASS SigOpArqBO AS BusinessBase

    *-- Tipo de exportacao selecionado (Optiongroup1.Value / ParentForm.pnTipos)
    *-- 1 = Linha (SigCdLin, chave linhas)
    *-- 2 = Grupo de Produto (SigCdGrp, chave cgrus)
    this_nTipos = 1

    *--------------------------------------------------------------------------
    * DECISAO DE PROJETO: BO somente-leitura no SQL Server
    *
    * O dump do legado (SigOpArq_form_codigo_fonte.txt) nao grava em nenhuma
    * tabela remota. Os unicos Replace do form (Check1.InteractiveChange e
    * Commandgroup1.Command2.Click) alteram so o cursor LOCAL crGerArq,
    * compartilhado por DataSession com o form pai (Lparameters poForm +
    * ThisForm.DataSessionId = poForm.DataSessionId). O botao "Gerar"
    * (Command1.Click) apenas valida a selecao e confirma com o usuario,
    * terminando em "Release Windows" - sem nenhum Insert/Update/Delete. A
    * gravacao real dos arquivos fica a cargo do form pai, depois deste
    * dialogo fechar.
    *
    * Por isso este BO nao sobrescreve Inserir()/Atualizar() - o
    * comportamento herdado de BusinessBase (que recusa a gravacao) ja eh o
    * correto aqui. CarregarDoCursor() so mapeia this_nTipos (abaixo). A
    * "gravacao" deste form inteira em cursor_4c_Dados (equivalente local a
    * crGerArq) acontece via MarcarItemParaExportacao/DesmarcarItem/
    * LimparSelecoes.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.AtualizarTipoExportacao(1)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTipoExportacao - Troca o tipo de item exportavel (Optiongroup1)
    * e a tabela/chave correspondente. Espelha Optiongroup1.InteractiveChange
    * do legado (ThisForm.ParentForm.pnTipos = This.Value), mas resolve aqui
    * tambem a tabela de origem, que no legado o form pai conhecia de fora.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTipoExportacao(par_nTipos)
        IF VARTYPE(par_nTipos) != "N" OR !INLIST(par_nTipos, 1, 2)
            RETURN .F.
        ENDIF

        THIS.this_nTipos = par_nTipos

        IF THIS.this_nTipos = 2
            THIS.this_cTabela     = "SigCdGrp"
            THIS.this_cCampoChave = "cgrus"
        ELSE
            THIS.this_cTabela     = "SigCdLin"
            THIS.this_cCampoChave = "linhas"
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega this_nTipos de um cursor externo (padrao
    * generico de BusinessBase). Este BO nao tem outras propriedades escalares
    * de entidade - os dados de grade vivem em cursor_4c_Dados, tratado pelos
    * metodos de Buscar/Marcar abaixo.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF TYPE(par_cAliasCursor + ".tipos") != "U"
            THIS.AtualizarTipoExportacao(NVL(EVALUATE(par_cAliasCursor + ".tipos"), 1))
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Popula cursor_4c_Dados com os itens exportaveis do tipo
    * corrente (this_nTipos). Nao ha conceito de filtro no legado (o Grid1
    * sempre lista o universo inteiro do tipo escolhido no Optiongroup1) -
    * par_cFiltro existe so para manter a assinatura canonica do projeto.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        IF THIS.this_nTipos = 2
            RETURN THIS.BuscarGrupos()
        ENDIF

        RETURN THIS.BuscarLinhas()
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhas - Itens exportaveis quando this_nTipos = 1 (SigCdLin)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarLinhas()
        LOCAL loc_cSQL
        loc_cSQL = "SELECT linhas AS Codigos, descs AS Descricao " + ;
                   "FROM SigCdLin " + ;
                   "ORDER BY descs"

        RETURN THIS.CarregarItensGrade(loc_cSQL)
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Itens exportaveis quando this_nTipos = 2 (SigCdGrp)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarGrupos()
        LOCAL loc_cSQL
        loc_cSQL = "SELECT cgrus AS Codigos, dgrus AS Descricao " + ;
                   "FROM SigCdGrp " + ;
                   "ORDER BY dgrus"

        RETURN THIS.CarregarItensGrade(loc_cSQL)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItensGrade - Executa par_cSQL num cursor TEMPORARIO e rebalanca
    * cursor_4c_Dados a partir dele, preservando a estrutura (Marcas/NomArqs)
    * que o Grid da pagina usa - nunca SQLEXEC direto no alias do Grid (regra
    * do projeto: SQLEXEC sobre alias ligado a Grid zera o ColumnCount).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarItensGrade(par_cSQL)
        LOCAL loc_lResultado, loc_nResultado, loc_cCursorTemp
        loc_lResultado  = .F.
        loc_cCursorTemp = "cursor_4c_ItensExpTemp"

        TRY
            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, loc_cCursorTemp)

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF(loc_cCursorTemp)
                ELSE
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (Codigos C(10), Descricao C(40), Marcas N(1,0), NomArqs C(254))
                    SET NULL OFF
                    SELECT cursor_4c_Dados
                    APPEND FROM DBF(loc_cCursorTemp)
                ENDIF

                REPLACE ALL Marcas WITH 0, NomArqs WITH "" IN cursor_4c_Dados
                GO TOP IN cursor_4c_Dados

                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar itens para exporta" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro: " + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "SigOpArqBO.CarregarItensGrade")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarItemParaExportacao - Espelha Check1.InteractiveChange do legado:
    * valida a pasta de destino (DIRECTORY()/MD direto - fverificapasta.prg eh
    * wrapper so para p-code legado compilado, regra do projeto), recusa nome
    * de arquivo repetido entre as linhas e marca o item corrente da grade.
    *--------------------------------------------------------------------------
    PROCEDURE MarcarItemParaExportacao(par_cCaminhoArquivo)
        LOCAL loc_lResultado, loc_cPasta, loc_nRecnoAtual, loc_cCaminho
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            THIS.this_cMensagemErro = "Nenhum item selecionado na grade."
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCaminhoArquivo) != "C" OR EMPTY(ALLTRIM(par_cCaminhoArquivo))
            THIS.this_cMensagemErro = "Destino Inv" + CHR(225) + "lido !!!"
            RETURN .F.
        ENDIF

        loc_cCaminho = ALLTRIM(par_cCaminhoArquivo)
        loc_cPasta   = JUSTPATH(loc_cCaminho)

        TRY
            IF !EMPTY(loc_cPasta) AND !DIRECTORY(loc_cPasta)
                MD (loc_cPasta)
            ENDIF

            IF !EMPTY(loc_cPasta) AND !DIRECTORY(loc_cPasta)
                THIS.this_cMensagemErro = "Local ou Arquivo Inv" + CHR(225) + "lido !!!"
            ELSE
                SELECT cursor_4c_Dados
                loc_nRecnoAtual = RECNO()

                LOCATE FOR ALLTRIM(NomArqs) == loc_cCaminho AND RECNO() != loc_nRecnoAtual
                IF FOUND()
                    THIS.this_cMensagemErro = "Nome Arquivo J" + CHR(225) + " Informado !!!"
                    GOTO loc_nRecnoAtual
                ELSE
                    GOTO loc_nRecnoAtual
                    REPLACE Marcas WITH 1, NomArqs WITH loc_cCaminho
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao validar destino: " + loException.Message
            MsgErro(THIS.this_cMensagemErro, "SigOpArqBO.MarcarItemParaExportacao")
            *-- regra #20: ja mostrou a falha - o chamador nao deve repetir
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarItem - Desfaz a marcacao do item corrente da grade (usado
    * quando a validacao falha, espelhando os "Replace nMarcas With 0" do
    * legado dentro do proprio InteractiveChange).
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarItem()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        REPLACE Marcas WITH 0, NomArqs WITH "" IN cursor_4c_Dados

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteItemSelecionado - Espelha "Locate for nMarcas = 1" do
    * Commandgroup1.Command1/Command2.Click (botoes Gerar/Encerrar).
    *--------------------------------------------------------------------------
    PROCEDURE ExisteItemSelecionado()
        LOCAL loc_nRecnoAtual, loc_lResultado
        loc_lResultado = .F.

        IF USED("cursor_4c_Dados")
            loc_nRecnoAtual = RECNO("cursor_4c_Dados")

            SELECT cursor_4c_Dados
            LOCATE FOR Marcas = 1
            loc_lResultado = FOUND()

            IF BETWEEN(loc_nRecnoAtual, 1, RECCOUNT("cursor_4c_Dados"))
                GOTO loc_nRecnoAtual
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparSelecoes - Espelha "Replace All nMarcas With 0" do
    * Commandgroup1.Command2.Click (Encerrar, apos confirmar o cancelamento).
    *--------------------------------------------------------------------------
    PROCEDURE LimparSelecoes()
        IF !USED("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        REPLACE ALL Marcas WITH 0, NomArqs WITH ""
        GO TOP

        RETURN .T.
    ENDPROC

ENDDEFINE

