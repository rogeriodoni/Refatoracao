*==============================================================================
* SigOpCfpBO.prg - Business Object para Cfop's Permitidas por Operacao
*
* Form OPERACIONAL (popup filho do Cadastro de Operacoes - SigCdOpe): mantem
* a lista de CFOPs permitidos para uma Operacao (Dopes), com os limites de
* Observacao (Padrao/Inicial/Final) de cada CFOP.
*
* Tabela: SigCdOop (cada registro = um CFOP permitido para uma Operacao)
*   cfops      char(10) NOT NULL - codigo do CFOP permitido
*   cidchaves  char(20) NOT NULL - chave primaria (PK Fortyus, gerada com fUniqueIds())
*   dopes      char(20) NOT NULL - codigo da Operacao (FK SigCdOpe.Dopes)
*   cgrus      char(3)  NOT NULL - grupo (nao exibido na grade, preservado do SELECT *)
*   obspads    numeric(3,0) NOT NULL - observacao padrao
*   obsinis    numeric(3,0) NOT NULL - observacao inicial
*   obsfins    numeric(3,0) NOT NULL - observacao final
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpCfpBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade (mapeamento para a tabela SigCdOop)
    * Cada instancia representa UMA linha da grade de CFOPs permitidos.
    *==========================================================================
    this_cCidChaves  = ""   && cidchaves char(20) - PK Fortyus
    this_cDopes      = ""   && dopes char(20) - codigo da Operacao (FK SigCdOpe.Dopes)
    this_cCfop       = ""   && cfops char(10) - codigo do CFOP permitido
    this_cCgrupo     = ""   && cgrus char(3) - grupo (NOT NULL, nao exibido na grade)
    this_nObsPadrao  = 0    && obspads numeric(3,0) - observacao padrao da operacao
    this_nObsInicial = 0    && obsinis numeric(3,0) - observacao inicial permitida
    this_nObsFinal   = 0    && obsfins numeric(3,0) - observacao final permitida

    *-- Cursor de trabalho do grid (legado "TmpCfoOp") - editavel, recriado
    *-- a cada CarregarCfopsPermitidos(). Nome exposto para o Form vincular
    *-- RecordSource/ControlSource DEPOIS de (re)carregar (igual a FpNBO).
    this_cCursorGrade = "cursor_4c_Dados"

    *==========================================================================
    * Init - Inicializa o Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdOop"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta as propriedades da entidade (NovoRegistro/
    * CancelarEdicao). this_cDopes TAMBEM eh limpo - eh FK para a Operacao
    * (SigCdOpe.Dopes) que o Form (fase do layout) deve repor logo apos
    * THIS.NovoRegistro(), igual ao padrao de SigOpCflBO.this_cNums.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves  = ""
        THIS.this_cDopes      = ""
        THIS.this_cCfop       = ""
        THIS.this_cCgrupo     = ""
        THIS.this_nObsPadrao  = 0
        THIS.this_nObsInicial = 0
        THIS.this_nObsFinal   = 0
    ENDPROC

    *==========================================================================
    * InicializarValoresPadrao - Espelha o ramo do cmdInserir.Click legado:
    *     Insert Into TmpCfoOp (Dopes, CidChaves) Values (crSigCdOpe.Dopes, fUniqueIds())
    * A chave ja nasce com a linha em branco, antes do usuario preencher o
    * CFOP - exatamente como o legado gera a PK na hora de inserir a linha na
    * grade, nao na hora de salvar.
    *==========================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cCidChaves = fUniqueIds()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir de um cursor
    * de SigCdOop (cursor_4c_Dados ou o cursor temporario da grade).
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar os campos -
    * campo nao eh sintaxe valida em VFP9.
    * PUBLIC de proposito (regra #51): o form chama este metodo de FORA, ao
    * posicionar na linha da grade (ex.: BtnExcluirClick/AfterRowColChange).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
                THIS.this_cDopes      = TratarNulo(dopes,     "")
                THIS.this_cCfop       = TratarNulo(cfops,     "")
                THIS.this_cCgrupo     = TratarNulo(cgrus,     "")
                THIS.this_nObsPadrao  = TratarNulo(obspads,   0)
                THIS.this_nObsInicial = TratarNulo(obsinis,   0)
                THIS.this_nObsFinal   = TratarNulo(obsfins,   0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpCfpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarCursorGrade - (Re)cria o cursor de trabalho do grid, vazio,
    * com a mesma estrutura de SigCdOop usada na grade (legado "TmpCfoOp" -
    * "Select * From xCfoOp Into Cursor TmpCfoOp ReadWrite"). Chamado por
    * CarregarCfopsPermitidos() antes de popular - o Form so vincula
    * RecordSource/ControlSource DEPOIS dessa chamada (regra: Column.
    * ControlSource exige que o cursor ja exista).
    *==========================================================================
    PROCEDURE InicializarCursorGrade()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                USE IN (THIS.this_cCursorGrade)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorGrade) ;
                (cidchaves C(20) NULL, dopes C(20) NULL, cfops C(10) NULL, ;
                 cgrus C(3) NULL, obspads N(3,0) NULL, obsinis N(3,0) NULL, obsfins N(3,0) NULL)
            SET NULL OFF

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                "Procedure: " + loException.Procedure, "SigOpCfpBO.InicializarCursorGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCfopsPermitidos - Carrega para THIS.this_cCursorGrade todos os
    * Cfops ja permitidos da Operacao corrente (THIS.this_cDopes), espelhando
    * a consulta do Init legado ("Select * From SigCdOop where Dopes=...").
    * SQLEXEC vai para um cursor TEMPORARIO - nunca direto no cursor do grid
    * (SQLEXEC sobre o alias ligado ao Grid zera o ColumnCount). PUBLIC: o
    * Form chama de fora, apos instanciar o BO (regra #51).
    *==========================================================================
    PROCEDURE CarregarCfopsPermitidos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = THIS.InicializarCursorGrade()
        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF

            loc_cSQL = "SELECT cidchaves, dopes, cfops, cgrus, obspads, obsinis, obsfins" + ;
                " FROM SigCdOop WHERE dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OopTemp")

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorGrade)
                IF RECCOUNT("cursor_4c_OopTemp") > 0
                    APPEND FROM DBF("cursor_4c_OopTemp")
                ENDIF
                GO TOP

                *-- Snapshot das chaves JA existentes em SigCdOop ao abrir o
                *-- dialogo - usado por SalvarGrade() (fase 7/8) para decidir
                *-- Inserir() x Atualizar() x excluir por diferenca, sem
                *-- precisar do Delete+Append em massa do legado.
                IF USED("cursor_4c_OopOriginais")
                    USE IN cursor_4c_OopOriginais
                ENDIF
                SELECT cidchaves FROM (THIS.this_cCursorGrade) ;
                    INTO CURSOR cursor_4c_OopOriginais

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar Cfops permitidos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF
            MostrarErro("Erro ao carregar Cfops permitidos:" + CHR(13) + loException.Message, "SigOpCfpBO.CarregarCfopsPermitidos")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Transcricao das validacoes do legado espalhadas pelos
    * Valid das colunas da grade (Column2/Column3/Column4): a Observacao
    * Inicial nao pode ser maior que a Padrao, e a Observacao Final nao pode
    * ser menor que a Padrao. Empty(0) = .T. em VFP9, entao a checagem so
    * entra em vigor quando os dois lados estao preenchidos - igual ao legado.
    * Chamado por BusinessBase.Salvar(), que exibe a falha via ExibirFalha()
    * quando este metodo devolve .F. (regra #20) - sem MsgAviso proprio aqui.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .F.

        THIS.this_cMensagemErro = ""

        DO CASE
        CASE EMPTY(ALLTRIM(THIS.this_cCfop))
            THIS.this_cMensagemErro = "Cfop n" + CHR(227) + "o informado."
        CASE EMPTY(ALLTRIM(THIS.this_cDopes))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
        CASE !EMPTY(THIS.this_nObsInicial) AND !EMPTY(THIS.this_nObsPadrao) AND ;
             (THIS.this_nObsInicial > THIS.this_nObsPadrao)
            THIS.this_cMensagemErro = "A Observa" + CHR(231) + CHR(227) + "o Inicial N" + ;
                CHR(227) + "o Pode Ser Maior do Que a Padr" + CHR(227) + "o!!!"
        CASE !EMPTY(THIS.this_nObsFinal) AND !EMPTY(THIS.this_nObsPadrao) AND ;
             (THIS.this_nObsFinal < THIS.this_nObsPadrao)
            THIS.this_cMensagemErro = "A Observa" + CHR(231) + CHR(227) + "o Final N" + ;
                CHR(227) + "o Pode Ser Menor do Que a Padr" + CHR(227) + "o!!!"
        OTHERWISE
            loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Inserir - Inclui um CFOP permitido para a Operacao em SigCdOop.
    * Espelha o INSERT em massa do cmdSair.Click legado (Select * From
    * TmpCfoOp / Append From Dbf), aplicado linha a linha pela arquitetura
    * nova. cgrus eh NOT NULL e nao aparece na grade - vem preservado da
    * propriedade (this_cCgrupo), carregada do SELECT * do cursor de origem.
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdOop (cidchaves, dopes, cfops, cgrus, obspads, obsinis, obsfins)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCfop, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCgrupo, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nObsPadrao, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObsInicial, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObsFinal, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao incluir Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpCfpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza um CFOP permitido existente em SigCdOop.
    * dopes e cidchaves sao a chave do registro e NAO sao regraveis; cfops e
    * as tres observacoes (padrao/inicial/final) espelham o que o usuario
    * edita nas colunas da grade. cgrus eh regravado com o mesmo valor
    * carregado (nunca editado na tela), preservando o grupo original.
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdOop
                   SET cfops   = <<EscaparSQL(LEFT(THIS.this_cCfop, 10))>>,
                       cgrus   = <<EscaparSQL(LEFT(THIS.this_cCgrupo, 3))>>,
                       obspads = <<FormatarNumeroSQL(THIS.this_nObsPadrao, 0)>>,
                       obsinis = <<FormatarNumeroSQL(THIS.this_nObsInicial, 0)>>,
                       obsfins = <<FormatarNumeroSQL(THIS.this_nObsFinal, 0)>>
                 WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpCfpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExisteChaveOriginal - .T. se par_cCidChaves ja existia em SigCdOop ao
    * abrir o dialogo (snapshot cursor_4c_OopOriginais, tirado em
    * CarregarCfopsPermitidos). Usado por SalvarGrade() para decidir entre
    * Inserir() e Atualizar() - sem indice em cursor_4c_OopOriginais, por
    * isso LOCATE (poucas linhas, nao precisa de SEEK).
    *==========================================================================
    PROTECTED FUNCTION ExisteChaveOriginal(par_cCidChaves)
        LOCAL loc_lAchou, loc_cAliasAtual

        loc_lAchou = .F.

        IF USED("cursor_4c_OopOriginais")
            loc_cAliasAtual = ALIAS()
            SELECT cursor_4c_OopOriginais
            LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(NVL(par_cCidChaves, ""))
            loc_lAchou = FOUND()
            IF !EMPTY(loc_cAliasAtual) AND USED(loc_cAliasAtual)
                SELECT (loc_cAliasAtual)
            ENDIF
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *==========================================================================
    * SalvarGrade - Persiste as alteracoes da grade de Cfops permitidos
    * (this_cCursorGrade): INSERT para linha nova, UPDATE para linha
    * existente, DELETE para linha removida pelo usuario - resultado final
    * equivalente ao cmdSair.Click legado (Delete From SigCdOop Where
    * Dopes=... seguido de reinsercao INTEGRAL de TmpCfoOp), aqui aplicado
    * linha a linha pelos metodos Inserir/Atualizar/ExecutarExclusao ja
    * existentes (PILAR 3 - arquitetura obrigatoriamente diferente do
    * legado, mesmo resultado final no banco).
    *
    * Validacoes na MESMA ordem do legado:
    *   1. Descarta as linhas em branco do cursor (legado: "Delete For
    *      Cfops = Space(10)") - cmdInserir.Click (fase 7/8) cria a linha
    *      vazia; se o usuario sair sem preencher o Cfop, ela e descartada
    *      em silencio, igual ao legado.
    *   2. Cfop duplicado entre as linhas remanescentes (legado: "Select
    *      Cfops, sum(1) From TmpCfoOp Group by 1 having sum(1) > 1") ->
    *      aborta com o MESMO aviso do legado e devolve .F. SEM alterar o
    *      banco - BtnSairClick (fase 7/8) mantem o dialogo aberto para o
    *      usuario corrigir (legado: "Return .f." no meio do Click).
    *
    * As linhas que existiam ao abrir o dialogo e que nao sobraram no
    * cursor apos a etapa 1 (porque o usuario excluiu, ou porque a linha
    * em branco por acaso reaproveitou uma chave existente - nunca ocorre,
    * cidchaves de linha nova sempre vem de fUniqueIds()) sao EXCLUIDAS do
    * banco.
    *
    * PUBLIC: chamado pelo form em BtnSairClick (regra #51 - Inserir/
    * Atualizar/ExecutarExclusao continuam PROTECTED, acessados so por
    * este metodo, da PROPRIA classe).
    *==========================================================================
    PROCEDURE SalvarGrade()
        LOCAL loc_lSucesso, loc_cCursor, loc_nDuplic

        loc_lSucesso = .T.
        loc_cCursor  = THIS.this_cCursorGrade

        IF !USED(loc_cCursor)
            RETURN .T.
        ENDIF

        TRY
            *-- 1) descarta linhas em branco (legado: Delete For Cfops = Space(10))
            SELECT (loc_cCursor)
            DELETE FOR EMPTY(ALLTRIM(NVL(cfops, "")))

            *-- 2) duplicidade de Cfop entre as linhas remanescentes
            IF USED("cursor_4c_OopDuplic")
                USE IN cursor_4c_OopDuplic
            ENDIF
            SELECT cfops FROM (loc_cCursor) WHERE !DELETED() ;
                GROUP BY cfops HAVING COUNT(*) > 1 INTO CURSOR cursor_4c_OopDuplic

            loc_nDuplic = RECCOUNT("cursor_4c_OopDuplic")

            IF USED("cursor_4c_OopDuplic")
                USE IN cursor_4c_OopDuplic
            ENDIF

            IF loc_nDuplic > 0
                MsgAviso("Existem Cfops em Duplicidade. Favor Acertar!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- 3) INSERT/UPDATE das linhas remanescentes
            IF loc_lSucesso
                SELECT (loc_cCursor)
                SCAN FOR !DELETED()
                    THIS.CarregarDoCursor(loc_cCursor)

                    IF THIS.ExisteChaveOriginal(THIS.this_cCidChaves)
                        loc_lSucesso = THIS.Atualizar()
                    ELSE
                        loc_lSucesso = THIS.Inserir()
                    ENDIF

                    IF !loc_lSucesso
                        EXIT
                    ENDIF

                    SELECT (loc_cCursor)
                ENDSCAN
            ENDIF

            *-- 4) exclui as linhas que existiam antes e nao sobraram no cursor
            IF loc_lSucesso AND USED("cursor_4c_OopOriginais")
                IF USED("cursor_4c_OopRemovidas")
                    USE IN cursor_4c_OopRemovidas
                ENDIF

                SELECT cidchaves FROM cursor_4c_OopOriginais ;
                    WHERE cidchaves NOT IN ;
                        (SELECT cidchaves FROM (loc_cCursor) WHERE !DELETED()) ;
                    INTO CURSOR cursor_4c_OopRemovidas

                SELECT cursor_4c_OopRemovidas
                SCAN
                    THIS.this_cCidChaves = ALLTRIM(cidchaves)
                    loc_lSucesso = THIS.ExecutarExclusao()
                    IF !loc_lSucesso
                        EXIT
                    ENDIF
                    SELECT cursor_4c_OopRemovidas
                ENDSCAN

                IF USED("cursor_4c_OopRemovidas")
                    USE IN cursor_4c_OopRemovidas
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                "Procedure: " + loException.Procedure, "SigOpCfpBO.SalvarGrade")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui o CFOP permitido de SigCdOop.
    * Espelha o cmdExcluir.Click legado (Delete na linha corrente da grade) -
    * aqui aplicado direto na tabela, chave por cidchaves.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdOop WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigOpCfpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
