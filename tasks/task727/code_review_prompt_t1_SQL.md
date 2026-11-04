# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABSTOP' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CGRUS, CPROS, IDS, CODIGOS

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
Select Distinct CGrus From crImagens Into Cursor crGrus Order By CGrus
Select crGrus
	lcQuery = [Select CGrus, DGrus, Ids ] + ;
			    [From SigCdGrp ] + ;
	If (ThisForm.poObjForm.poDataMgr.SqlExecute(lcQuery, [LocalGrupo]) < 1)
	Select LocalGrupo
		If Not Seek(LocalGrupo.Ids, [crGrupos], [Grupo])
			Insert Into crGrupos (Grupo) Values (LocalGrupo.Ids)
		Select Distinct CPros ;
		  From crImagens ;
		Select crPros
			lcQuery = [Select CPros, DPros, CUnis, DtIncs, Situas, PesoMs, Icms, ] + ;
					    [From SigCdPro ] + ;
			If (ThisForm.poObjForm.poDataMgr.SqlExecute(lcQuery, [LocalProds]) < 1)
			Select LocalProds
				lcQuery = [Select b.Descrs, b.Ordens ] + ;
						    [From SigPrCar a, SigCrRap b ] + ;
				If (ThisForm.poObjForm.poDataMgr.SqlExecute(lcQuery, [LocalCaracs]) < 1)
				Select LocalCaracs
						If Not Seek(LocalCaracs.Ordens, [crGrupos], [Grupo])
							Insert Into crGrupos (Grupo) Values (LocalCaracs.Ordens)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopecm.prg) - TRECHOS RELEVANTES PARA PASS SQL (949 linhas total):

*-- Linhas 156 a 174:
156:     *==========================================================================
157:     * this_oFormPai - equivale a propriedade customizada poObjForm do legado
158:     * ("ThisForm.poObjForm = oFrm" no Init). No legado ela servia para dois
159:     * fins: executar SQL (poObjForm.poDataMgr.SqlExecute) e alcancar o cursor
160:     * crImagens do chamador. Na arquitetura nova o SQL vai por gnConnHandle
161:     * dentro de sigopecmBO, e crImagens eh visto pela propria data session
162:     * (ver nota de DataSession no cabecalho); a referencia eh preservada para
163:     * o contrato de chamada com o form chamador continuar o mesmo.
164:     *==========================================================================
165:     this_oFormPai = .NULL.
166: 
167:     *==========================================================================
168:     * this_cUltimoProgresso - ultimo texto de progresso recebido do BO
169:     * (equivalente ao Caption de lblResults no legado). Guardado na classe
170:     * porque o BO reporta progresso desde o inicio do Scan e o label
171:     * lbl_4c_LblResults eh um controle da area de campos: assim o texto nunca
172:     * se perde, e quem exibe eh AtualizarProgresso().
173:     *==========================================================================
174:     this_cUltimoProgresso = ""

*-- Linhas 184 a 202:
184:     *   - GerarArquivoExportacao refaz o teste de gravabilidade com
185:     *     STRTOFILE("", arquivo, 0) - o modo 0 eh SOBRESCRITA, logo APAGA
186:     *     os registros td01/td03 que a 1a chamada ja tinha anexado;
187:     *   - ela faz USE IN + SELECT DISTINCT ... INTO CURSOR
188:     *     cursor_4c_GruposSelec, isto eh FECHA e RECRIA justamente o
189:     *     cursor que o SCAN da 1a chamada esta percorrendo;
190:     *   - zera this_nQtdGrupos/this_nQtdProdutos, entao o total reportado
191:     *     ao usuario deixa de corresponder ao arquivo em disco.
192:     * Nada disso aparece na tela: o arquivo sai truncado e o usuario le
193:     * "Arquivo de Produtos Gerado Com Sucesso!!!".
194:     *
195:     * A flag eh liberada no FINALLY do wrapper, nunca no fim do corpo: o
196:     * corpo tem RETURN antecipado na desistencia do MsgConfirma e, com
197:     * set/clear simples, a flag travaria ligada e MATARIA o Processar pelo
198:     * resto da vida do form (regra #47).
199:     *==========================================================================
200:     this_lProcessando = .F.
201: 
202:     *==========================================================================


### BO (C:\4c\projeto\app\classes\sigopecmBO.prg):
*============================================================================
* sigopecmBO.prg - Business Object para Geracao de Arquivo de Exportacao
* Para e-Commerce (SIGOPECM / Formsigopecm)
*
* Form OPERACIONAL (processo em lote, sem tabela propria no banco): gera um
* arquivo de texto de largura fixa (layout "td01"/"td03") a partir dos
* produtos selecionados previamente pelo usuario (cursor crImagens, montado
* pelo form chamador - SIGOPECM.poObjForm) e grava ao lado dele, opcional-
* mente, os JPGs decodificados de SigCdPro.FigJpgs (base64).
*
* crImagens NAO eh criado neste form - quem monta eh SigOpPec.SCT
* (ProximasMigracoes\SigOpPec.SCT, ainda NAO migrado), com pelo menos:
*   Create Cursor CrImagens (Cpros C(14), Cgrus C(3), Cunis C(3), FigJpgs M, ...)
* As duas colunas usadas pelo SIGOPECM sao Cgrus C(3) e Cpros C(14) - usar
* essa estrutura ao criar o cursor placeholder nas proximas fases (nao
* inventar largura diferente).
*
* Fontes de leitura (sem persistencia - o processo so GERA ARQUIVO):
*   - SigCdGrp (CGrus/DGrus/Ids)              -> registro td01 (Grupo)
*   - SigCdPro (CPros/DPros/CUnis/DtIncs/...)  -> registro td03 (Produto)
*   - SigPrCar + SigCrRap (Descrs/Ordens)      -> colecoes/caracteristicas
*     do produto, que tambem geram registros td01 (uma "colecao" por Ordens)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completo em: Fase 2 em diante (metodos de processamento/exportacao)
*============================================================================

DEFINE CLASS sigopecmBO AS BusinessBase

    *==========================================================================
    * Parametros informados na tela (SIGOPECM.getArqTXT/chkImagens)
    *==========================================================================
    this_cArquivo          = ""   && SIGOPECM.getArqTXT.Value - caminho completo do TXT a ser gerado
    *-- SIGOPECM.chkImagens.Value = 1 - espelha o estado da caixa "Exportar
    *-- Imagens" na tela. ATENCAO: o legado NAO CONSULTA esse controle em
    *-- metodo nenhum (conferido no dump inteiro - chkImagens so aparece na
    *-- arvore de objetos e nas propriedades), logo a caixa NAO TEM EFEITO
    *-- no sistema antigo: ele exporta os JPGs sempre que SigCdPro.FigJpgs
    *-- esta preenchido. A property eh mantida porque eh a transcricao fiel
    *-- do controle e deixa a ativacao a um IF de distancia, mas
    *-- GerarArquivoExportacao NAO a usa, de proposito - ativar a caixa eh
    *-- mudar comportamento e exige decisao do cliente (PILAR 1).
    this_lExportarImagens  = .T.

    *==========================================================================
    * Resultado do processamento (SIGOPECM.lblResults / MessageBox final)
    *==========================================================================
    this_nQtdGrupos        = 0    && lnQtd do legado - total de grupos (registros td01) encontrados
    this_nQtdProdutos      = 0    && lnCnt do legado - total de produtos (registros td03) gravados
    this_cMensagemResultado = ""  && espelha o Caption de lblResults durante o Scan

    *==========================================================================
    * Linha corrente lida de cursor por CarregarDoCursor() - equivale as
    * referencias LocalGrupo.<col> / LocalProds.<col> / LocalCaracs.<col> do
    * legado. O tipo de cada property segue o tipo da COLUNA no docs/schema.sql
    * (conferido com Get-Content -Raw, encoding UTF-16 - regra #14), nunca o
    * nome do controle:
    *
    *   SigCdGrp : cgrus char(3)  | dgrus char(20) | ids numeric(10,0)
    *   SigCdPro : cpros char(14) | dpros char(65) | cunis char(3)
    *              dtincs datetime NULL | situas numeric(1,0)
    *              pesoms numeric(8,3) | icms numeric(5,2)
    *              aliqipis numeric(5,2) | clfiscals char(10)
    *              sittricms char(3) | pvens numeric(11,5) | figjpgs text NULL
    *   SigCrRap : descrs char(40) | ordens numeric(6,0)
    *==========================================================================
    this_cCgrus      = ""   && SigCdGrp.cgrus  / crImagens.Cgrus - codigo do grupo
    this_cDgrus      = ""   && SigCdGrp.dgrus  - descricao do grupo (registro td01)
    this_nIds        = 0    && SigCdGrp.ids    - ID do grupo no e-Commerce (registro td01)

    this_cCpros      = ""   && SigCdPro.cpros  / crImagens.Cpros - codigo do produto
    this_cDpros      = ""   && SigCdPro.dpros  - descricao do produto
    this_cCunis      = ""   && SigCdPro.cunis  - unidade
    this_dDtincs     = {}   && SigCdPro.dtincs - data de inclusao (datetime NULL)
    this_nSituas     = 0    && SigCdPro.situas - 2 = inativo ("i"), demais = ativo ("a")
    this_nPesoms     = 0    && SigCdPro.pesoms - peso medio
    this_nIcms       = 0    && SigCdPro.icms   - % de ICMS
    this_nAliqipis   = 0    && SigCdPro.aliqipis - % de IPI
    this_cClfiscals  = ""   && SigCdPro.clfiscals - classificacao fiscal
    this_cSittricms  = ""   && SigCdPro.sittricms - situacao tributaria
    this_nPvens      = 0    && SigCdPro.pvens  - preco de venda
    this_cFigjpgs    = ""   && SigCdPro.figjpgs - imagem em base64 (text NULL)

    this_cDescrs     = ""   && SigCrRap.descrs - descricao da colecao (registro td01)
    this_nOrdens     = 0    && SigCrRap.ordens - ID da colecao (registro td01)

    *==========================================================================
    * Referencia ao form para repintar lblResults.Caption durante o
    * processamento (equivalente ao "ThisForm.lblResults.Caption = ... "
    * repetido dentro do Scan do legado). Fica .NULL. quando o BO eh usado
    * sem interface.
    *==========================================================================
    this_oFormUI = .NULL.

    *==========================================================================
    * Init - Inicializa o Business Object. Sem tabela propria (o processo
    * apenas le SigCdGrp/SigCdPro/SigPrCar/SigCrRap e grava arquivo em disco),
    * entao this_cTabela/this_cCampoChave ficam vazios - igual ao padrao
    * adotado em FAPPBO.prg para forms operacionais sem persistencia.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em sigopecmBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Sem tabela/registro proprio (processo so GERA
    * ARQUIVO), entao nao ha chave primaria para auditar. Explicito aqui (em
    * vez de confiar so no default de BusinessBase) para deixar claro que a
    * ausencia eh decisao, nao esquecimento - mesmo padrao de FAPPBO.prg.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * LimparDados - Zera a linha corrente (as properties alimentadas por
    * CarregarDoCursor). Chamado no inicio de GerarArquivoExportacao e a cada
    * troca de grupo/produto: sem isso, coluna ausente no cursor da vez
    * deixaria o valor do registro ANTERIOR na property e o registro td01/td03
    * sairia com dado de outro produto - divergencia silenciosa, sem erro.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCgrus     = ""
        THIS.this_cDgrus     = ""
        THIS.this_nIds       = 0

        THIS.this_cCpros     = ""
        THIS.this_cDpros     = ""
        THIS.this_cCunis     = ""
        THIS.this_dDtincs    = {}
        THIS.this_nSituas    = 0
        THIS.this_nPesoms    = 0
        THIS.this_nIcms      = 0
        THIS.this_nAliqipis  = 0
        THIS.this_cClfiscals = ""
        THIS.this_cSittricms = ""
        THIS.this_nPvens     = 0
        THIS.this_cFigjpgs   = ""

        THIS.this_cDescrs    = ""
        THIS.this_nOrdens    = 0
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Le a linha CORRENTE de um cursor para as properties
    * deste BO. Equivale as referencias LocalGrupo.<col> / LocalProds.<col> /
    * LocalCaracs.<col> espalhadas pelo Processamento do legado: aqui a leitura
    * acontece em UM lugar so, e o resto do codigo trabalha sobre as
    * properties.
    *
    * Atende os TRES cursores do processo (cada um traz um subconjunto de
    * colunas) e tambem o crImagens montado pelo form chamador:
    *   cursor_4c_DadosGrupo     -> Cgrus, Dgrus, Ids
    *   cursor_4c_DadosProduto   -> Cpros, Dpros, Cunis, Dtincs, Situas,
    *                               Pesoms, Icms, Aliqipis, Clfiscals,
    *                               Sittricms, Pvens, Figjpgs
    *   cursor_4c_Caracteristicas-> Descrs, Ordens
    *   crImagens                -> Cgrus, Cpros
    *
    * Cada coluna eh lida so quando EXISTE no cursor: o teste eh
    * TYPE(alias + ".coluna") != "U", NUNCA PEMSTATUS() - PEMSTATUS exige
    * OBJETO no 1o argumento e com nome de alias dispara o erro 11 do VFP9.
    *
    * O alias corrente eh restaurado no fim: o metodo eh chamado de DENTRO de
    * SCANs (crImagens/grupos/produtos) e nao pode deslocar a area de trabalho
    * de quem chamou.
    *
    * Parametro: par_cAliasCursor - nome do cursor/alias ja aberto e posicionado
    * Retorno: .T. se leu uma linha; .F. se o alias nao existe, nao esta aberto
    *          ou esta em EOF (cursor vazio ou ponteiro no fim).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro, loc_cAlias, loc_cAliasAnterior

        loc_lResultado     = .F.
        loc_cAliasAnterior = ALIAS()
        loc_cAlias         = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- SigCdGrp (grupo) / crImagens
                    IF TYPE(loc_cAlias + ".Cgrus") != "U"
                        THIS.this_cCgrus = ALLTRIM(TratarNulo(Cgrus, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Dgrus") != "U"
                        THIS.this_cDgrus = ALLTRIM(TratarNulo(Dgrus, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Ids") != "U"
                        THIS.this_nIds = TratarNulo(Ids, 0)
                    ENDIF

                    *-- SigCdPro (produto) / crImagens
                    IF TYPE(loc_cAlias + ".Cpros") != "U"
                        THIS.this_cCpros = ALLTRIM(TratarNulo(Cpros, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Dpros") != "U"
                        THIS.this_cDpros = ALLTRIM(TratarNulo(Dpros, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Cunis") != "U"
                        THIS.this_cCunis = ALLTRIM(TratarNulo(Cunis, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Dtincs") != "U"
                        *-- datetime NULL: ConverterParaData normaliza DATE/DATETIME/NULL.
                        *-- TTOD() direto dispara erro 11 quando o valor chega como DATE.
                        THIS.this_dDtincs = ConverterParaData(Dtincs)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Situas") != "U"
                        THIS.this_nSituas = TratarNulo(Situas, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Pesoms") != "U"
                        THIS.this_nPesoms = TratarNulo(Pesoms, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Icms") != "U"
                        THIS.this_nIcms = TratarNulo(Icms, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Aliqipis") != "U"
                        THIS.this_nAliqipis = TratarNulo(Aliqipis, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Clfiscals") != "U"
                        THIS.this_cClfiscals = ALLTRIM(TratarNulo(Clfiscals, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Sittricms") != "U"
                        THIS.this_cSittricms = ALLTRIM(TratarNulo(Sittricms, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Pvens") != "U"
                        THIS.this_nPvens = TratarNulo(Pvens, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".Figjpgs") != "U"
                        *-- text NULL - base64 da imagem, lido CRU (sem ALLTRIM)
                        THIS.this_cFigjpgs = TratarNulo(Figjpgs, "")
                    ENDIF

                    *-- SigCrRap (colecoes/caracteristicas do produto)
                    IF TYPE(loc_cAlias + ".Descrs") != "U"
                        THIS.this_cDescrs = ALLTRIM(TratarNulo(Descrs, ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".Ordens") != "U"
                        THIS.this_nOrdens = TratarNulo(Ordens, 0)
                    ENDIF

                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler o cursor [" + loc_cAlias + "]: " + ;
                loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.

        FINALLY
            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao - este form NUNCA grava em tabela
    * (le SigCdGrp/SigCdPro/SigPrCar/SigCrRap e grava um arquivo em disco);
    * o comportamento padrao herdado de BusinessBase (recusar a operacao) ja
    * eh o correto aqui, entao NAO sao sobrescritos so para preencher metodo.
    * A operacao real do form eh GerarArquivoExportacao(), abaixo.
    *==========================================================================

    *==========================================================================
    * AtualizarProgresso - Repinta o andamento do processamento. Equivale ao
    * "ThisForm.lblResults.Caption = ..." repetido dentro do Scan do legado.
    * Nao sabe o nome do controle: delega para um metodo PUBLIC do form
    * (THIS.this_oFormUI.AtualizarProgresso(cTexto)), que o Form (Fase 3)
    * implementa para repintar o label dele e fazer Refresh().
    *==========================================================================
    PROTECTED PROCEDURE AtualizarProgresso(par_nQtdGrupos, par_nQtdProdutos)
        LOCAL loc_cTexto

        loc_cTexto = "Processando " + ALLTRIM(STR(par_nQtdGrupos, 10)) + " Grupo" + ;
            IIF(par_nQtdGrupos = 1, "", "s") + " / " + ;
            "Produtos Gerados : " + ALLTRIM(STR(par_nQtdProdutos, 10))

        THIS.this_cMensagemResultado = loc_cTexto

        IF VARTYPE(THIS.this_oFormUI) = "O" AND PEMSTATUS(THIS.this_oFormUI, "AtualizarProgresso", 5)
            THIS.this_oFormUI.AtualizarProgresso(loc_cTexto)
        ENDIF
    ENDPROC

    *==========================================================================
    * GerarArquivoExportacao - Equivalente a SIGOPECM.Processamento do legado.
    *
    * Le o cursor crImagens (montado pelo form chamador - ver cabecalho do
    * arquivo) e, para cada Cgrus/Cpros distinto nele, consulta SigCdGrp/
    * SigCdPro/SigPrCar+SigCrRap e grava registros de largura fixa ("td01"
    * para grupos/colecoes, "td03" para produtos) no arquivo THIS.this_cArquivo,
    * alem dos JPGs decodificados de SigCdPro.FigJpgs sempre que a coluna
    * estiver preenchida (o legado nao condiciona isso a nada mais - ver a
    * nota no bloco de exportacao de imagens, adiante).
    *
    * Pre-requisitos (devem ser setados pelo Form ANTES de chamar):
    *   THIS.this_cArquivo         - caminho completo do TXT a ser gerado
    *   THIS.this_oFormUI          - opcional, para repintar o progresso
    * (this_lExportarImagens NAO entra aqui: este metodo nao a le, porque o
    * legado tambem nao - ver a nota na declaracao da property.)
    *
    * Retorno: .T. se o processamento rodou do inicio ao fim (mesmo que
    * nenhum produto tenha sido gerado - igual ao legado, que so muda a
    * mensagem final, nunca o retorno); .F. em falha de validacao ou de SQL.
    *
    * Contrato de erro (mesmo do Inserir()/Atualizar() de BusinessBase):
    *   - falha de SQL exibe o proprio MsgErro aqui e deixa
    *     this_cMensagemErro VAZIO (ja mostrado, Form nao repete);
    *   - falha de validacao (arquivo vazio/nao-gravavel/sem imagens
    *     selecionadas) NAO mostra MsgErro - so preenche this_cMensagemErro,
    *     para o Form decidir a mensagem e o SetFocus.
    *==========================================================================
    PROCEDURE GerarArquivoExportacao()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cChr, loc_cSQL, loc_nResultado
        LOCAL loc_nQtdGrupos, loc_nQtdProdutos
        LOCAL loc_cGru, loc_cDes, loc_cUni, loc_cStr
        LOCAL loc_cRef, loc_cDat, loc_cSit, loc_cPes, loc_cIpi, loc_cIcm, loc_cClf, loc_cTri, loc_cVal, loc_cPre
        LOCAL loc_cGvd, loc_cGr1, loc_cDe1, loc_cUn1
        LOCAL loc_cImg, loc_cFoto

        loc_lResultado = .F.

        *-- Zera a linha corrente (LimparDados tambem limpa this_cMensagemErro
        *-- via DODEFAULT) para o processamento nunca herdar o produto/grupo de
        *-- uma geracao anterior - o form fica aberto entre um Processar e outro
        THIS.LimparDados()

        THIS.this_nQtdGrupos         = 0
        THIS.this_nQtdProdutos       = 0
        THIS.this_cMensagemResultado = ""

        loc_cArquivo = ALLTRIM(NVL(THIS.this_cArquivo, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "O Arquivo a Ser Gerado N" + CHR(227) + "o Foi Informado!!!"
            ELSE
                *-- Testa se o arquivo pode ser criado (igual ao legado)
                STRTOFILE("", loc_cArquivo, 0)

                IF !FILE(loc_cArquivo)
                    THIS.this_cMensagemErro = "O Arquivo N" + CHR(227) + "o Pode Ser Criado!!!"
                ELSE
                    IF !USED("crImagens")
                        THIS.this_cMensagemErro = "Nenhuma imagem selecionada para exportar."
                    ELSE
                        loc_cChr = CHR(13) + CHR(10)

                        IF USED("cursor_4c_GruposSelec")
                            USE IN cursor_4c_GruposSelec
                        ENDIF
                        SELECT DISTINCT Cgrus FROM crImagens ;
                            INTO CURSOR cursor_4c_GruposSelec ;
                            ORDER BY Cgrus

                        IF USED("cursor_4c_ControleGrupos")
                            USE IN cursor_4c_ControleGrupos
                        ENDIF
                        CREATE CURSOR cursor_4c_ControleGrupos (Grupo N(8))
                        INDEX ON Grupo TAG Grupo

                        loc_nQtdGrupos   = RECCOUNT("cursor_4c_GruposSelec")
                        loc_nQtdProdutos = 0

                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                        loc_lResultado = .T.

                        SELECT cursor_4c_GruposSelec
                        SCAN
                            IF !loc_lResultado
                                EXIT
                            ENDIF

                            loc_cSQL = "SELECT Cgrus, Dgrus, Ids" + ;
                                " FROM SigCdGrp" + ;
                                " WHERE Cgrus = " + EscaparSQL(cursor_4c_GruposSelec.Cgrus) + ;
                                "   AND Ids > 0"

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosGrupo")

                            IF loc_nResultado < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalGrupo)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            SELECT cursor_4c_DadosGrupo
                            GO TOP

                            *-- CarregarDoCursor devolve .F. em EOF, o que equivale ao
                            *-- "If Not Eof([LocalGrupo])" do legado
                            IF THIS.CarregarDoCursor("cursor_4c_DadosGrupo")
                                loc_cGru = PADL(THIS.this_nIds, 8, "0")
                                loc_cDes = PADR(THIS.this_cDgrus, 40)
                                loc_cUni = PADR("", 4)

                                *-- td01 - Tabela de Grupos
                                loc_cStr = "td01" + ;           && Tipo - "td01" - Constante - Caracter(4)
                                    loc_cGru + ;                && ID - Numerico(8)
                                    loc_cDes + ;                && Descricao - Caracter(40)
                                    loc_cUni + loc_cChr         && Unidade - Caracter(4)

                                STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                IF !SEEK(THIS.this_nIds, "cursor_4c_ControleGrupos", "Grupo")
                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (THIS.this_nIds)
                                ENDIF

                                *-- Produtos distintos do grupo (crPros do legado)
                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                                SELECT DISTINCT Cpros FROM crImagens ;
                                    WHERE Cgrus = cursor_4c_GruposSelec.Cgrus ;
                                    INTO CURSOR cursor_4c_ProdutosGrupo ;
                                    ORDER BY Cpros

                                SELECT cursor_4c_ProdutosGrupo
                                SCAN
                                    loc_cSQL = "SELECT Cpros, Dpros, Cunis, Dtincs, Situas, Pesoms, Icms," + ;
                                        " Aliqipis, Clfiscals, Sittricms, Pvens, Figjpgs" + ;
                                        " FROM SigCdPro" + ;
                                        " WHERE Cpros = " + EscaparSQL(cursor_4c_ProdutosGrupo.Cpros)

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosProduto")

                                    IF loc_nResultado < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalProds)")
                                        loc_lResultado = .F.
                                        EXIT
                                    ENDIF

                                    SELECT cursor_4c_DadosProduto
                                    GO TOP

                                    IF THIS.CarregarDoCursor("cursor_4c_DadosProduto")
                                        loc_cRef = PADR(CHRTRAN(THIS.this_cCpros, [ */\:?"'<>|], []), 25)
                                        loc_cDes = PADR(THIS.this_cDpros, 60)
                                        loc_cUni = PADR(THIS.this_cCunis, 3)
                                        loc_cDat = DTOC(THIS.this_dDtincs)
                                        loc_cSit = IIF(THIS.this_nSituas = 2, "i", "a")
                                        *-- Pesoms/Pvens: PADL de COLUNA converte o numero com as
                                        *-- decimais DECLARADAS (pesoms numeric(8,3), pvens
                                        *-- numeric(11,5)); de VARIAVEL converteria com SET DECIMALS
                                        *-- (2 por default) e o campo de largura fixa sairia com
                                        *-- outro conteudo. O STR explicito reproduz a coluna.
                                        loc_cPes = STRTRAN(PADL(ALLTRIM(STR(THIS.this_nPesoms, 12, 3)), 8, "0"), ".", ",")
                                        loc_cIpi = PADL(INT(THIS.this_nAliqipis), 2, "0")
                                        loc_cIcm = PADL(INT(THIS.this_nIcms), 2, "0")
                                        loc_cClf = PADR(CHRTRAN(THIS.this_cClfiscals, [ .], []), 8)
                                        loc_cTri = PADR(THIS.this_cSittricms, 3)
                                        loc_cVal = STRTRAN(PADL(ALLTRIM(STR(THIS.this_nPvens, 18, 5)), 8, "0"), ".", ",")
                                        loc_cPre = PADR("00000000" + loc_cVal + "0000^", 400)

                                        loc_cGvd = ""

                                        *-- Colecoes/caracteristicas do produto (SigPrCar + SigCrRap)
                                        loc_cSQL = "SELECT b.Descrs, b.Ordens" + ;
                                            " FROM SigPrCar a, SigCrRap b" + ;
                                            " WHERE a.Cpros = " + EscaparSQL(THIS.this_cCpros) + ;
                                            "   AND a.Codigos = b.Codigos"

                                        IF USED("cursor_4c_Caracteristicas")
                                            USE IN cursor_4c_Caracteristicas
                                        ENDIF
                                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Caracteristicas")

                                        IF loc_nResultado < 1
                                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalCaracs)")
                                            loc_lResultado = .F.
                                            EXIT
                                        ENDIF

                                        SELECT cursor_4c_Caracteristicas
                                        SCAN
                                            *-- Le a linha corrente (Descrs/Ordens) para as
                                            *-- properties; Cpros/Figjpgs do produto NAO sao
                                            *-- tocados (este cursor nao tem essas colunas)
                                            THIS.CarregarDoCursor("cursor_4c_Caracteristicas")

                                            IF !EMPTY(THIS.this_nOrdens)
                                                IF !SEEK(THIS.this_nOrdens, "cursor_4c_ControleGrupos", "Grupo")
                                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (THIS.this_nOrdens)

                                                    loc_cGr1 = PADL(THIS.this_nOrdens, 8, "0")
                                                    loc_cDe1 = PADR(THIS.this_cDescrs, 40)
                                                    loc_cUn1 = PADR("", 4)

                                                    *-- td01 - Tabela de Grupos (colecao)
                                                    loc_cStr = "td01" + loc_cGr1 + loc_cDe1 + loc_cUn1 + loc_cChr

                                                    STRTOFILE(loc_cStr, loc_cArquivo, .T.)
                                                ENDIF
                                                loc_cGvd = loc_cGvd + ALLTRIM(STR(THIS.this_nOrdens, 8)) + "^"
                                            ENDIF
                                        ENDSCAN
                                        loc_cGvd = PADR(ALLTRIM(loc_cGvd), 60)

                                        *-- td03 - Tabela de Produtos
                                        loc_cStr = "td03" + ;               && Tipo - "td03" - Constante - Caracter(4)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            loc_cRef + ;                    && Referencia - Caracter(25)
                                            loc_cDes + ;                    && Descricao - Caracter(60)
                                            loc_cUni + ;                    && Unidade - Caracter(3)
                                            loc_cGru + ;                    && ID Grupo - Numerico(8)
                                            "00000000" + ;                  && ID Subgrupo - Numerico(8)
                                            loc_cDat + ;                    && Data do produto - Data(10)
                                            " " + ;                         && Alternativo - Caracter(1)
                                            "001" + ;                       && Multiplicador - Numerico(3)
                                            PADR(loc_cRef, 20) + ;          && Nome Foto Sem Extensao - Caracter(20)
                                            loc_cSit + ;                    && Status Produto a=ativo/i=inativo - Caracter(1)
                                            "00000000" + ;                  && Desconto Maximo em % - Numerico(8)
                                            "00" + ;                        && Tabela - Caracter(2)
                                            loc_cPes + ;                    && Peso - Numerico(8)
                                            " " + ;                         && Status Foto - Caracter(1)
                                            " " + ;                         && Lancamento - Caracter(1)
                                            loc_cIpi + ;                    && % do IPI - Numerico(2)
                                            "00000000" + ;                  && Valor IPI - Numerico(8)
                                            loc_cIcm + ;                    && % ICMS - Numerico(2)
                                            "00000000" + ;                  && Valor ICMS - Numerico(8)
                                            loc_cClf + ;                    && Classificacao Fiscal - Caracter(8)
                                            loc_cTri + ;                    && Situacao Tributaria - Caracter(3)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            "00000000" + ;                  && Estoque - Numerico(8)
                                            loc_cPre + ;                    && Lista(8)+Preco(8)+QtdeMinima(4)+^ - Caracter(400)
                                            SPACE(20) + ;                   && Codigo de Barras - Caracter(20)
                                            SPACE(64) + ;                   && RESERVADO - Caracter(64)
                                            SPACE(400) + ;                  && Caracteristicas (separador CHR(13)) - Caracter(400)
                                            loc_cGvd + loc_cChr             && Material/Complemento - Caracter(60)

                                        STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                        loc_nQtdProdutos = loc_nQtdProdutos + 1
                                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                                        *-- Exportando as imagens
                                        *-- this_cFigjpgs ja vem sem NULL (TratarNulo em
                                        *-- CarregarDoCursor), por isso o ISNULL do legado
                                        *-- fica coberto pelo EMPTY.
                                        *--
                                        *-- A condicao eh SO esta: o legado NAO consulta
                                        *-- chkImagens em lugar nenhum - no dump do SCX esse
                                        *-- controle aparece apenas na arvore de objetos e no
                                        *-- bloco de propriedades, e o Processamento guarda a
                                        *-- exportacao so com "If Not Empty(LocalProds.FigJpgs)
                                        *-- And Not IsNull(LocalProds.FigJpgs)". Acrescentar
                                        *-- AND this_lExportarImagens aqui seria INVENTAR uma
                                        *-- restricao que o legado nao tem (PILAR 1 / regra
                                        *-- #49): quem desmarcasse "Exportar Imagens" deixaria
                                        *-- de receber os JPGs que o sistema antigo gera.
                                        *-- Ver a nota de this_lExportarImagens: ligar a
                                        *-- caixa eh mudanca de comportamento e precisa de
                                        *-- decisao do cliente, nao de decisao do migrador.
                                        IF !EMPTY(THIS.this_cFigjpgs)
                                            loc_cImg = ALLTRIM(JUSTPATH(loc_cArquivo)) + "\" + ALLTRIM(loc_cRef) + ".Jpg"
                                            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(THIS.this_cFigjpgs, ;
                                                "data:image/png;base64,", ""), ;
                                                "data:image/jpeg;base64,", ""), ;
                                                "data:image/jpg;base64,", ""), 14)
                                            STRTOFILE(loc_cFoto, loc_cImg)
                                        ENDIF
                                    ENDIF

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    IF USED("cursor_4c_Caracteristicas")
                                        USE IN cursor_4c_Caracteristicas
                                    ENDIF
                                ENDSCAN

                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                            ENDIF

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                        ENDSCAN

                        THIS.this_nQtdGrupos   = loc_nQtdGrupos
                        THIS.this_nQtdProdutos = loc_nQtdProdutos

                        IF loc_lResultado
                            IF loc_nQtdProdutos > 0
                                THIS.this_cMensagemResultado = "Arquivo de Produtos Gerado Com Sucesso!!!"
                            ELSE
                                THIS.this_cMensagemResultado = "Aten" + CHR(231) + CHR(227) + "o!!! Arquivo Gerado Sem Produtos!!!"
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo de exporta" + CHR(231) + CHR(227) + "o: " + ;
                loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.

        FINALLY
            IF USED("cursor_4c_GruposSelec")
                USE IN cursor_4c_GruposSelec
            ENDIF
            IF USED("cursor_4c_ProdutosGrupo")
                USE IN cursor_4c_ProdutosGrupo
            ENDIF
            IF USED("cursor_4c_ControleGrupos")
                USE IN cursor_4c_ControleGrupos
            ENDIF
            IF USED("cursor_4c_DadosGrupo")
                USE IN cursor_4c_DadosGrupo
            ENDIF
            IF USED("cursor_4c_DadosProduto")
                USE IN cursor_4c_DadosProduto
            ENDIF
            IF USED("cursor_4c_Caracteristicas")
                USE IN cursor_4c_Caracteristicas
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

