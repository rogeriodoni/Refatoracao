# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALIDARB' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FPAGS, CODBINS

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
lcSql = [Select * From SigOpFpB Where Fpags = ']+ThisForm.Fpagto+[' And CodBins = ']+This.Value+[']
If Thisform.Podatamgr.Sqlexecute(lcSql,'LocalFpagB') < 1
	Select LocalFpagB

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPBIN.prg) - TRECHOS RELEVANTES PARA PASS SQL (498 linhas total):

*-- Linhas 318 a 336:
318:                 .TabIndex  = 2
319:             ENDWITH
320: 
321:             *-- Get_Bin: unico campo editavel do dialogo. Sem ControlSource
322:             *-- (o legado tambem nao tem - This.Value eh lido direto no Valid).
323:             *-- InputMask/MaxLength: coluna real eh SigOpFpb.CodBins char(6)
324:             *-- (docs/schema.sql) - o dump do SCX declara InputMask com 10
325:             *-- "!" (forca maiuscula por posicao); MaxLength = 6 alinha com a
326:             *-- largura real da coluna (regra "MaxLength vem da largura da
327:             *-- coluna no schema"), sem descartar o InputMask do legado.
328:             THIS.AddObject("txt_4c_Bin", "TextBox")
329:             WITH THIS.txt_4c_Bin
330:                 .Value      = ""
331:                 .Alignment  = 3
332:                 .InputMask  = "!!!!!!!!!!"
333:                 .MaxLength  = 6
334:                 .Left       = 283
335:                 .Top        = 147
336:                 .Width      = 58


### BO (C:\4c\projeto\app\classes\SIGOPBINBO.prg):
*==============================================================================
* SIGOPBINBO.prg - Business Object: Valida BIN do Cartao (SIGOPBIN)
* Tabela: SigOpFpb
* PK: cidchaves char(20)
* Herda de: BusinessBase
*
* Origem legado: SIGOPBIN.SCX (form OPERACIONAL modal, WindowType = 1)
*   - Init recebe pPag (condicao de pagamento) e guarda em ThisForm.Fpagto
*   - Get_Bin.Valid consulta SigOpFpB por Fpags + CodBins e, achando registro,
*     confere a vigencia com Between(Dtos(Date()), Dtos(Nvl(Datais, 01/01/1900)),
*     Dtos(Nvl(DataFs, 31/12/9999))); autorizado -> UsuLibs = BIN e ZSen = .T.
*   - Unload devolve Iif(ZSen, "*", " ") + UsuLibs para o form chamador
*
* O legado NAO grava em tabela nenhuma (apenas Select), portanto este BO eh de
* SOMENTE LEITURA: para Inserir/Atualizar/ExecutarExclusao o comportamento
* padrao herdado de BusinessBase ja eh o correto.
*
* O metodo de negocio real (equivalente ao Get_Bin.Valid do legado) eh
* ValidarBin(par_cCodBin) - consulta SigOpFpb, confere a vigencia e resolve
* this_lZSen/this_cUsuLibs; ObterResultadoSaida() equivale ao PROCEDURE Unload.
*==============================================================================
DEFINE CLASS SIGOPBINBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Chave Primaria da tabela SigOpFpb
    *--------------------------------------------------------------------------
    this_cCidChaves = ""    && cidchaves char(20) NOT NULL - PK tecnica Fortyus

    *--------------------------------------------------------------------------
    * Propriedades - Campos da tabela SigOpFpb
    * Nomes das colunas conforme docs/schema.sql (PILAR 2 - schema identico)
    *--------------------------------------------------------------------------
    this_cCodBins = ""      && codbins char(6)  NOT NULL - codigo BIN do cartao
    this_cDescs   = ""      && descs   char(30) NOT NULL - descricao do BIN
    this_dDataIs  = {}      && datais  datetime NULL     - inicio da vigencia
    this_dDataFs  = {}      && datafs  datetime NULL     - fim da vigencia
    this_cFpags   = ""      && fpags   char(12) NOT NULL - condicao de pagamento

    *--------------------------------------------------------------------------
    * Propriedades - Contexto recebido do form chamador
    * Equivale a ThisForm.Fpagto do legado, alimentada pelo parametro pPag
    *--------------------------------------------------------------------------
    this_cFpagto = ""       && condicao de pagamento usada no filtro da consulta

    *--------------------------------------------------------------------------
    * Propriedades - Resultado da validacao (devolvido ao form chamador)
    * Equivalem a ThisForm.UsuLibs e ThisForm.ZSen do legado
    *--------------------------------------------------------------------------
    this_cUsuLibs = ""      && BIN liberado; vazio quando nao houve liberacao
    this_lZSen    = .F.      && .T. = BIN autorizado e dentro da vigencia

    *--------------------------------------------------------------------------
    * Propriedades - Detalhe do resultado (usado nas mensagens ao usuario)
    *--------------------------------------------------------------------------
    this_lRegistroEncontrado = .F.   && Reccount('LocalFpagB') > 0 no legado
    this_lVigenciaValida     = .F.   && resultado do Between() de datas
    this_lFalhaConexao       = .F.   && SqlExecute < 1 no legado

    *--------------------------------------------------------------------------
    * Propriedades - Demais properties declaradas no SCX legado
    * Mantidas para paridade com o contrato do form (ClassInfo do SIGOPBIN)
    *--------------------------------------------------------------------------
    this_lLibFpag2 = .F.    && libfpag2 = .F. no SCX
    this_cLibOpe   = ""      && libope (display "LibOpe" no _memberdata do SCX)

    *--------------------------------------------------------------------------
    * Propriedades - Vigencia
    * Sentinelas transcritas LITERALMENTE do legado (Nvl do Get_Bin.Valid):
    *   Nvl(LocalFpagB.Datais, Ctod('01/01/1900'))
    *   Nvl(LocalFpagB.DataFs, Ctod('31/12/9999'))
    * Literal {^AAAA-MM-DD} nao varia com SET DATE / SET CENTURY
    *--------------------------------------------------------------------------
    this_dDataReferencia      = {}              && Date() do legado
    this_dVigenciaInicioPadrao = {^1900-01-01}   && usada quando datais eh NULL
    this_dVigenciaFimPadrao    = {^9999-12-31}   && usada quando datafs eh NULL

    *--------------------------------------------------------------------------
    * Propriedades - Cursores
    * O legado usa o alias local 'LocalFpagB' (SqlExecute do fSqlConector)
    *--------------------------------------------------------------------------
    this_cCursorDados = ""  && alias do cursor da consulta de BIN

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    * par_cFpagto: condicao de pagamento (equivale ao pPag do Init legado).
    *              Opcional - o form pode informar depois via this_cFpagto.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cFpagto)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Tabela e chave primaria (nomes EXATOS do schema)
            THIS.this_cTabela     = "SigOpFpb"
            THIS.this_cCampoChave = "cidchaves"

            *-- Alias do cursor da consulta (LocalFpagB no legado)
            THIS.this_cCursorDados = "cursor_4c_FpagB"

            *-- Contexto: Fpagto chega do form chamador (pPag do legado)
            IF VARTYPE(par_cFpagto) = "C"
                THIS.this_cFpagto = ALLTRIM(par_cFpagto)
            ELSE
                THIS.this_cFpagto = ""
            ENDIF

            *-- Data de referencia da vigencia (Date() do Get_Bin.Valid)
            THIS.this_dDataReferencia = DATE()

            *-- Estado inicial: nada liberado (ThisForm.UsuLibs = [] do legado)
            THIS.this_cUsuLibs            = ""
            THIS.this_lZSen               = .F.
            THIS.this_lRegistroEncontrado = .F.
            THIS.this_lVigenciaValida     = .F.
            THIS.this_lFalhaConexao       = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SIGOPBINBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia os campos do cursor de consulta (LocalFpagB no
    * legado) para as properties do BO. Chamado por ValidarBin() apos o
    * SQLEXEC confirmar RECCOUNT > 0.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCidChaves = TratarNulo(cidchaves, "")
        THIS.this_cCodBins   = TratarNulo(CodBins, "")
        THIS.this_cDescs     = TratarNulo(Descs, "")
        THIS.this_cFpags     = TratarNulo(Fpags, "")
        THIS.this_dDataIs    = TratarNulo(Datais, {})
        THIS.this_dDataFs    = TratarNulo(DataFs, {})

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarBin - Equivalente ao Get_Bin.Valid do legado.
    *
    * Consulta SigOpFpb por Fpags (this_cFpagto, contexto recebido no Init) +
    * CodBins (par_cCodBin, digitado pelo usuario) e, achando o registro,
    * confere a vigencia com o mesmo Between(Dtos(...)) do legado, usando as
    * sentinelas 01/01/1900 e 31/12/9999 quando Datais/DataFs estao NULL.
    *
    * Resultado fica em this_lZSen/this_cUsuLibs (equivalem a ThisForm.ZSen e
    * ThisForm.UsuLibs) - o form chamador le essas properties (ou chama
    * ObterResultadoSaida()) para decidir o fechamento, igual ao legado faz em
    * ThisForm.Release dentro do proprio Valid.
    *
    * par_cCodBin vazio reproduz "If Empty(This.Value) ... Return .t." do
    * legado: nao faz SQL, so garante o estado default (nao autorizado).
    *--------------------------------------------------------------------------
    FUNCTION ValidarBin(par_cCodBin)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado, ;
            loc_dDataIniVigencia, loc_dDataFimVigencia
        loc_lSucesso = .F.

        THIS.this_cUsuLibs           = ""
        THIS.this_lZSen              = .F.
        THIS.this_lRegistroEncontrado = .F.
        THIS.this_lVigenciaValida    = .F.
        THIS.this_lFalhaConexao      = .F.

        IF EMPTY(par_cCodBin)
            RETURN .T.
        ENDIF

        TRY
            THIS.this_dDataReferencia = DATE()

            loc_cSQL = "SELECT * FROM SigOpFpb" + ;
                " WHERE Fpags = " + EscaparSQL(THIS.this_cFpagto) + ;
                " AND CodBins = " + EscaparSQL(par_cCodBin)

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResultado < 1
                THIS.this_lFalhaConexao = .T.
                THIS.this_lZSen         = .F.
                MsgErro("Falha na Conex" + CHR(227) + "o. Tente Novamente!!!", "SIGOPBINBO.ValidarBin")
            ELSE
                IF RECCOUNT(THIS.this_cCursorDados) > 0
                    THIS.this_lRegistroEncontrado = .T.
                    THIS.CarregarDoCursor(THIS.this_cCursorDados)

                    loc_dDataIniVigencia = IIF(EMPTY(THIS.this_dDataIs), ;
                        THIS.this_dVigenciaInicioPadrao, THIS.this_dDataIs)
                    loc_dDataFimVigencia = IIF(EMPTY(THIS.this_dDataFs), ;
                        THIS.this_dVigenciaFimPadrao, THIS.this_dDataFs)

                    THIS.this_lVigenciaValida = BETWEEN(DTOS(THIS.this_dDataReferencia), ;
                        DTOS(loc_dDataIniVigencia), DTOS(loc_dDataFimVigencia))

                    IF THIS.this_lVigenciaValida
                        THIS.this_cUsuLibs = par_cCodBin
                        THIS.this_lZSen    = .T.
                    ELSE
                        THIS.this_lZSen    = .F.
                    ENDIF
                ELSE
                    THIS.this_lZSen = .F.
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SIGOPBINBO.ValidarBin")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterResultadoSaida - Equivalente ao PROCEDURE Unload do legado:
    *   Return Iif(This.ZSen, [*], [ ]) + This.UsuLibs
    * O form chamador le este retorno no lugar do valor que o legado devolvia
    * via ThisForm ao form pai que abriu o modal.
    *--------------------------------------------------------------------------
    FUNCTION ObterResultadoSaida()
        RETURN IIF(THIS.this_lZSen, "*", " ") + THIS.this_cUsuLibs
    ENDFUNC

ENDDEFINE

