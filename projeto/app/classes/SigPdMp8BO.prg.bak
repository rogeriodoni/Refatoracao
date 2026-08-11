*==============================================================================
* SigPdMp8BO.prg - Business Object para Relacao de OPs com Nao-Conformidades
* Subformulario para vincular nao-conformidades (SigCdNcf) a OPs de retrabalho
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS SigPdMp8BO AS BusinessBase

    *-- Dados da Operacao selecionada no pai (cursor tmpnens)
    this_cNumps    = ""   && OP number (tmpnens.numps, mask 9999999999)
    this_cEmps     = ""   && Empresa (tmpnens.emps)
    this_cDopps    = ""   && Descricao da operacao (tmpnens.dopps)

    *-- Dados da OP de Retrabalho selecionada (cursor xMfas)
    this_nNopsMfa  = 0    && Numero da OP (xMfas.Nops)
    this_nNenvs    = 0    && Numero do envelope (xMfas.nenvs)
    this_nQtdsMfa  = 0    && Quantidade da OP (xMfas.Qtds)
    this_cCodpds   = ""   && Codigo do produto (xMfas.CodPds)
    this_cDpros    = ""   && Descricao do produto (SigCdPro.DPros)
    this_cFigJpgs  = ""   && Imagem base64 do produto (SigCdPro.FigJpgs)

    *-- Dados da Nao-Conformidade atual (cursor xNensiN)
    this_nNops     = 0    && Numero da OP vinculada (xNensiN.Nops)
    this_cCods     = ""   && Codigo da nao-conformidade (xNensiN.Cods)
    this_nQtds     = 0    && Quantidade com nao-conformidade (xNensiN.Qtds)
    this_cDescs    = ""   && Descricao da nao-conformidade (xNensiN.Descs)
    this_cConta2s  = ""   && Codigo do funcionario responsavel (xNensiN.Conta2s)
    this_nFixos    = 0    && Flag fixo: 2=editavel descricao (xNensiN.Fixos)

    *-- Estado interno do subformulario
    this_cAntValue  = ""   && Valor anterior do campo Cods (anti-loop Valid)
    this_cPcEscolha = ""   && Modo do form pai: INSERIR ou ALTERAR

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "xNensiN"
        THIS.this_cCampoChave = "Nops"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna Nops do registro corrente de xNensiN
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF USED("xNensiN")
            SELECT xNensiN
            loc_cChave = TRANSFORM(NVL(Nops, 0))
        ENDIF
        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de alias de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNops    = NVL(Nops,    0)
            THIS.this_cCods    = ALLTRIM(NVL(Cods,    ""))
            THIS.this_nQtds    = NVL(Qtds,    0)
            THIS.this_cDescs   = ALLTRIM(NVL(Descs,   ""))
            THIS.this_cConta2s = ALLTRIM(NVL(Conta2s, ""))
            THIS.this_nFixos   = NVL(Fixos,   0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados minimos antes de inserir/atualizar
    *==========================================================================
    PROTECTED FUNCTION ValidarDados()
        IF THIS.this_nNops <= 0
            MsgAviso("O n" + CHR(250) + "mero da OP deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarInsercao - INSERT no cursor VFP xNensiN (replica cmdSInserir.Click)
    *==========================================================================
    PROTECTED FUNCTION ExecutarInsercao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                INSERT INTO xNensiN (Nops, Qtds) VALUES (THIS.this_nNops, THIS.this_nQtdsMfa)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarAtualizacao - REPLACE completo no cursor VFP xNensiN
    *==========================================================================
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                REPLACE Cods    WITH THIS.this_cCods,    ;
                        Qtds    WITH THIS.this_nQtds,    ;
                        Fixos   WITH THIS.this_nFixos,   ;
                        Descs   WITH THIS.this_cDescs,   ;
                        Conta2s WITH THIS.this_cConta2s  ;
                        IN xNensiN
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE no cursor VFP xNensiN (replica cmdSexcluir.Click)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                DELETE
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarNcf - Busca NCs em SigCdNcf via SQL Server, indexa cursor por Cods
    * Retorna .T. se par_cCods encontrado (carrega this_cDescs e this_nFixos)
    *         .F. se nao encontrado (form deve abrir FormBuscaAuxiliar)
    *==========================================================================
    FUNCTION BuscarNcf(par_cCods, par_cEmps)
        LOCAL loc_lEncontrado, loc_cSQL, loc_nRet, loc_oErro
        loc_lEncontrado = .F.
        TRY
            loc_cSQL = "SELECT Cods, Descs, Fixos FROM SigCdNcf" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " OR Emps = ' '"

            IF USED("cursor_4c_Ncf")
                TABLEREVERT(.T., "cursor_4c_Ncf")
                USE IN cursor_4c_Ncf
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ncf")
            IF loc_nRet < 1
                MsgErro("Falha ao buscar N" + CHR(227) + "o-Conformidades (SigCdNcf)", "Erro")
            ELSE
                SELECT cursor_4c_Ncf
                INDEX ON Cods TAG Cods
                IF !EMPTY(par_cCods) AND SEEK(par_cCods)
                    THIS.this_cCods  = ALLTRIM(NVL(cursor_4c_Ncf.Cods,  ""))
                    THIS.this_cDescs = ALLTRIM(NVL(cursor_4c_Ncf.Descs, ""))
                    THIS.this_nFixos = NVL(cursor_4c_Ncf.Fixos, 0)
                    loc_lEncontrado  = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar N" + CHR(227) + "o-Conformidade")
        ENDTRY
        RETURN loc_lEncontrado
    ENDFUNC

    *==========================================================================
    * BuscarProduto - Consulta SigCdPro para descricao e imagem do produto
    * Resultado em this_cDpros e this_cFigJpgs
    *==========================================================================
    PROCEDURE BuscarProduto(par_cCodPds)
        LOCAL loc_cSQL, loc_nRet, loc_oErro
        THIS.this_cDpros   = ""
        THIS.this_cFigJpgs = ""
        TRY
            loc_cSQL = "SELECT DPros, FigJpgs FROM SigCdPro WHERE CPros = " + ;
                       EscaparSQL(par_cCodPds)

            IF USED("cursor_4c_Produto")
                TABLEREVERT(.T., "cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")
            IF loc_nRet > 0 AND !EOF("cursor_4c_Produto")
                SELECT cursor_4c_Produto
                THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                THIS.this_cFigJpgs = NVL(FigJpgs, "")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarNcfNoCursor - REPLACE Fixos e Descs no registro corrente de xNensiN
    * Chamado apos selecao/validacao de NC para sincronizar campos relacionados
    *==========================================================================
    PROCEDURE AtualizarNcfNoCursor(par_cCods, par_nFixos, par_cDescs)
        LOCAL loc_oErro
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                REPLACE Fixos WITH par_nFixos, ;
                        Descs WITH par_cDescs  ;
                        IN xNensiN
                THIS.this_nFixos = par_nFixos
                THIS.this_cDescs = par_cDescs
                THIS.this_cCods  = par_cCods
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar NC no cursor")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ContarNcsPorNops - Conta registros NC nao-deletados para a OP par_nNops
    * Retorna 0 se nenhuma NC restante (gatilho para auto-inserir apos Excluir)
    *==========================================================================
    FUNCTION ContarNcsPorNops(par_nNops)
        LOCAL loc_nTotal, loc_oErro
        loc_nTotal = 0
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                SET ORDER TO Nops
                SET KEY TO par_nNops
                COUNT TO loc_nTotal
                SET KEY TO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao contar NCs")
        ENDTRY
        RETURN loc_nTotal
    ENDFUNC

ENDDEFINE
