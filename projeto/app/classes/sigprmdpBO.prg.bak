*==============================================================================
* sigprmdpBO.prg - Business Object para Substitui??o de Refer?ncias de Produtos
* Tabela: SigOpClC (opera??es de recalculo de custo/estoque)
* Heran?a: BusinessBase
* Data: 2026-07-17
*==============================================================================
* FASE 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigprmdpBO AS BusinessBase

    *-- Chave e tabela principal (SigOpClC: recalculo de custo/estoque)
    this_cTabela      = "SigOpClC"
    this_cCampoChave  = "CidChaves"

    *-- Flags de controle de comportamento (parametros do form original)
    this_lCheckCadPro   = .F.   && Se .T., pula valida??o do produto no SigCdPro
    this_lManterBarra   = .F.   && Se .T., mant?m o c?digo de barras do produto antigo
    this_lCalculaCusto  = .F.   && Se .T., recalcula custo ap?s substitui??o

    *-- Par de c?digos sendo processado no loop atual
    this_cCprosAnt      = ""    && C?digo de produto antigo (Cpros char(14))
    this_cCprosNov      = ""    && C?digo de produto novo (Cpros char(14))

    *-- Atributos do produto antigo capturados antes do processamento
    this_nBarraAnt      = 0     && C?digo de barras (Cbars) do produto antigo

    *-- Estado de progresso do processamento em lote
    this_nTotal         = 0     && Total de pares a processar (csContas * csCampos)
    this_nProcessados   = 0     && Pares j? processados (para barra de progresso)
    this_nErro          = 0     && C?digo do ?ltimo erro de SQL (< 1 = falha)

    *-- Feedback visual do arquivo/campo sendo processado no momento
    this_cArquivoAtual  = ""    && Nome do arquivo DBF sendo atualizado
    this_cCampoAtual    = ""    && Nome do campo sendo atualizado no arquivo

    *-- C?digo do usu?rio logado (capturado no Init para auditoria)
    this_cUsuar         = ""    && Usuar - usu?rio logado

    *--------------------------------------------------------------------------
    * Init - Configura??o inicial do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        this.this_cTabela     = "SigOpClC"
        this.this_cCampoChave = "CidChaves"

        *-- Captura usu?rio logado para auditoria (fGravarLog)
        IF TYPE("gc_4c_UsuarioLogado") = "C" AND !EMPTY(gc_4c_UsuarioLogado)
            this.this_cUsuar = gc_4c_UsuarioLogado
        ENDIF
    ENDPROC


    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor (csContas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCprosAnt = TratarNulo(CprosAnt, "C")
            THIS.this_cCprosNov = TratarNulo(CprosNov, "C")
            THIS.this_nBarraAnt = TratarNulo(BarraAnt, "N")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna campo chave prim?ria de SigOpClC
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCampoChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados m?nimos antes de Inserir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCprosNov)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto novo " + ;
                CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF EMPTY(go_4c_Sistema.cCodEmpresa)
            THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o configurada no sistema."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere pendencia de recalculo em SigOpClC
    * Sobrescreve BusinessBase.Inserir (chamado por Salvar quando lNovoRegistro=.T.)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves) VALUES (" + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                EscaparSQL(THIS.this_cCprosNov) + ", " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa + THIS.this_cCprosNov) + ", " + ;
                FormatarDataSQL(DATE()) + ", " + ;
                EscaparSQL(THIS.this_cUsuar) + ", " + ;
                EscaparSQL(loc_cCidChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao inserir pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cCampoChave = loc_cCidChaves
            THIS.RegistrarAuditoria("INSERT")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir em SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza pendencia em SigOpClC (data/usuario da requisicao)
    * Sobrescreve BusinessBase.Atualizar (chamado por Salvar quando lNovoRegistro=.F.)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCampoChave)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria ausente para atualiza" + CHR(231) + CHR(227) + "o."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigOpClC SET " + ;
                "CPros = " + EscaparSQL(THIS.this_cCprosNov) + ", " + ;
                "EmpCPros = " + EscaparSQL(go_4c_Sistema.cCodEmpresa + THIS.this_cCprosNov) + ", " + ;
                "Datas = " + FormatarDataSQL(DATE()) + ", " + ;
                "Usuars = " + EscaparSQL(THIS.this_cUsuar) + " " + ;
                "WHERE CidChaves = " + EscaparSQL(THIS.this_cCampoChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao atualizar pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove pend?ncia de rec?lculo de SigOpClC
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpClC WHERE CidChaves = " + ;
                EscaparSQL(THIS.this_cCampoChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao excluir pend" + CHR(234) + "ncia de rec" + CHR(225) + "lculo."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir de SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas - Cria cursor local de pares de substitui??o
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("csContas")
                USE IN csContas
            ENDIF

            SET NULL ON
            CREATE CURSOR csContas (CprosAnt C(14) NULL, CprosNov C(14) NULL, Flag L NULL, BarraAnt N(8) NULL)
            SET NULL OFF

            INDEX ON CprosAnt + CprosNov TAG Duplica
            INDEX ON CprosAnt TAG CprosAnt
            INDEX ON CprosNov TAG CprosNov
            SET ORDER TO

            INSERT INTO csContas (CprosAnt, CprosNov) VALUES ("", "")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursor de substitui" + CHR(231) + CHR(245) + "es")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarCalcCustos - Busca configura??o de c?lculo de custos em SigCdPaC
    * Seta this_lCalculaCusto = .T. se CalcCustos <> 3
    *--------------------------------------------------------------------------
    FUNCTION BuscarCalcCustos()
        LOCAL loc_nCalcCustos, loc_oErro, loc_cSQL
        loc_nCalcCustos = 0

        TRY
            loc_cSQL = "SELECT CalcCustos FROM SigCdPaC ORDER BY CalcCustos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CalcCustos") > 0
                IF USED("cursor_4c_CalcCustos") AND RECCOUNT("cursor_4c_CalcCustos") > 0
                    SELECT cursor_4c_CalcCustos
                    loc_nCalcCustos = NVL(CalcCustos, 0)
                ENDIF
                IF USED("cursor_4c_CalcCustos")
                    USE IN cursor_4c_CalcCustos
                ENDIF
            ELSE
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigCdPaC)")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de c" + CHR(225) + "lculo")
        ENDTRY

        THIS.this_lCalculaCusto = (loc_nCalcCustos <> 3)
        RETURN loc_nCalcCustos
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesNoGrid - Valida todos os pares em csContas antes do processamento
    * Retorna "" se OK, mensagem de erro se houver inconsist?ncia
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesNoGrid(par_lCheckCadPro, par_lManterBarra)
        LOCAL loc_cMensagem, loc_oErro, loc_cSQL, loc_nErro, loc_cEstoqsNov
        loc_cMensagem = ""

        TRY
            SELECT csContas
            GO TOP

            IF EOF()
                loc_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
                loc_lSucesso = loc_cMensagem
            ENDIF

            SELECT csContas
            SCAN
                IF EMPTY(csContas.CprosAnt)
                    loc_cMensagem = "Existe Uma Referencia Antiga Inv" + CHR(225) + "lida!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF !par_lCheckCadPro
                    loc_cSQL = "SELECT TOP 1 Cpros, Cbars FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(ALLTRIM(csContas.CprosAnt))
                    loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
                    IF loc_nErro < 1 OR (USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") = 0)
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        loc_cMensagem = "Existe Uma Referencia Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lSucesso = loc_cMensagem
                    ENDIF
                    IF USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                        SELECT cursor_4c_TmpPro
                        REPLACE BarraAnt WITH NVL(cursor_4c_TmpPro.Cbars, 0) IN csContas
                        USE IN cursor_4c_TmpPro
                    ENDIF
                ENDIF

                IF par_lManterBarra AND csContas.BarraAnt = 0
                    loc_cMensagem = "Existe Uma Referencia Antigo Sem Barra !!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF EMPTY(csContas.CprosNov)
                    loc_cMensagem = "Existe Uma Referencia Nova Inv" + CHR(225) + "lida!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                IF csContas.CprosAnt = csContas.CprosNov
                    loc_cMensagem = "Existe Uma Referencia Antiga e Uma Referencia Nova Com o Mesmo C" + CHR(243) + "digo!!!"
                    loc_lSucesso = loc_cMensagem
                ENDIF

                loc_cSQL = "SELECT a.Cgrus, b.Cestoqs FROM SigCdPro a " + ;
                    "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                    "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(csContas.CprosNov))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") > 0
                    IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                        SELECT cursor_4c_LocalPro
                        loc_cEstoqsNov = ALLTRIM(NVL(cursor_4c_LocalPro.Cestoqs, ""))
                        USE IN cursor_4c_LocalPro

                        loc_cSQL = "SELECT a.Cgrus, b.Cestoqs FROM SigCdPro a " + ;
                            "JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                            "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(csContas.CprosAnt))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2") > 0
                            IF USED("cursor_4c_LocalPro2") AND RECCOUNT("cursor_4c_LocalPro2") > 0
                                SELECT cursor_4c_LocalPro2
                                IF ALLTRIM(NVL(cursor_4c_LocalPro2.Cestoqs, "")) <> loc_cEstoqsNov
                                    USE IN cursor_4c_LocalPro2
                                    loc_cMensagem = "Existe Uma Referencia Antiga e Uma Referencia Nova com Controle de Estoque diferente!!!"
                                    loc_lSucesso = loc_cMensagem
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_LocalPro2")
                                USE IN cursor_4c_LocalPro2
                            ENDIF
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            loc_cMensagem = "Erro na valida" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
        ENDTRY

        RETURN loc_cMensagem
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirPendencia - Insere linha em SigOpClC para rec?lculo posterior
    * Chamado no loop de processamento para cada produto/empresa
    *--------------------------------------------------------------------------
    FUNCTION InserirPendencia(par_cEmps, par_cCpros, par_dData)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = fUniqueIds()
            loc_cSQL = "INSERT INTO SigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves) VALUES (" + ;
                EscaparSQL(par_cEmps) + ", " + ;
                EscaparSQL(par_cCpros) + ", " + ;
                EscaparSQL(par_cEmps + par_cCpros) + ", " + ;
                FormatarDataSQL(par_dData) + ", " + ;
                EscaparSQL(THIS.this_cUsuar) + ", " + ;
                EscaparSQL(loc_cCidChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir pend" + CHR(234) + "ncia em SigOpClC")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarXLS - Importa pares de substitui??o de planilha Excel para csContas
    * Retorna n?mero de registros importados com sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarXLS(par_cArquivoXLS, par_lCheckCadPro)
        LOCAL loc_nImportados, loc_oErro, loc_cSQL, loc_cCprosAnt, loc_cCprosNov
        loc_nImportados = 0

        TRY
            IF !FILE(par_cArquivoXLS)
                MsgErro("Arquivo Excel n" + CHR(227) + "o encontrado: " + par_cArquivoXLS, "Erro")
                loc_lSucesso = 0
            ENDIF

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF

            CREATE CURSOR cursor_4c_Importa (CprosAnt C(14), CprosNov C(14))
            INDEX ON CprosAnt TAG CprosAnt

            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivoXLS) TYPE XLS

            SELECT cursor_4c_Importa
            SCAN
                loc_cCprosAnt = ALLTRIM(cursor_4c_Importa.CprosAnt)
                loc_cCprosNov = ALLTRIM(cursor_4c_Importa.CprosNov)

                IF EMPTY(loc_cCprosAnt) OR EMPTY(loc_cCprosNov) OR loc_cCprosAnt = loc_cCprosNov
                    LOOP
                ENDIF

                IF !par_lCheckCadPro
                    loc_cSQL = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
                        EscaparSQL(loc_cCprosAnt)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") < 1
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        LOOP
                    ENDIF
                    IF !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
                        IF USED("cursor_4c_TmpPro")
                            USE IN cursor_4c_TmpPro
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_TmpPro")
                        USE IN cursor_4c_TmpPro
                    ENDIF
                ENDIF

                SELECT csContas
                SET ORDER TO Duplica
                IF !SEEK(loc_cCprosAnt + loc_cCprosNov)
                    APPEND BLANK
                    REPLACE CprosAnt WITH loc_cCprosAnt, CprosNov WITH loc_cCprosNov
                    loc_nImportados = loc_nImportados + 1
                ENDIF
            ENDSCAN

            SELECT csContas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao importar planilha Excel")
        ENDTRY

        RETURN loc_nImportados
    ENDFUNC

ENDDEFINE
