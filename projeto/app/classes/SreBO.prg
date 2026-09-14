*====================================================================
* SreBO.prg
*
* Business Object para Cadastro de Serie de Nota Fiscal
* Tabela: SigCdSer
* Chave Primaria: EmpCods (char(6) = Emps + Cods)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SreBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdSer)
    this_cEmpCods    = ""    && empcods  char(6) - PK (concatenacao de Emps + Cods)
    this_cEmps       = ""    && cemps     char(3) - Empresa (FK SigCdEmp.CEmps)
    this_cDEmps      = ""    && Descricao da empresa (SigCdEmp.Razas) - somente exibicao, nao persistido
    this_cCodigo     = ""    && cods     char(3) - Codigo da serie
    this_cDescricao  = ""    && descs    char(20) - Descricao da serie
    this_nImpnfs     = 0     && impnfs   numeric(1,0) - Imprime NF: 1=Sim 2=Nao 3=Eletronica
    this_nTiponfs    = 0     && tiponfs  numeric(1,0) - Tipo NF: 1=Automatico 2=Manual 3=AutomaticoSemAlteracao 4=Documento
    this_cModelos    = ""    && modelos  char(2) - Modelo da nota fiscal
    this_cCtiponfs   = ""    && ctiponfs char(5) - Tipo N.F. (codigo complementar)
    this_nMostecfs   = 0     && mostecfs numeric(1,0) - Mostra Dados ECF Fiscal: 1=Sim 2=Nao
    this_nTpservicos = 0     && tpservicos numeric(1,0) - Servicos: 1=Sim 2=Nao 3=SimComItens
    this_nNnfobrigs  = 0     && nnfobrigs numeric(1,0) - Numeracao de NF: 1=Opcional 2=Obrigatoria
    this_nBlqinss    = 0     && blqinss  numeric(1,0) - Bloquear NF Caso Exista Anterior Nao Impressa
    this_nSelotrans  = 0     && selotrans numeric(1,0) - Selo Transporte: 1=Sim 2=Nao
    this_cInicials   = ""    && inicials char(2) - Selo Transporte Inicial
    this_cFinals     = ""    && finals   char(2) - Selo Transporte Final
    this_cCoddisp    = ""    && coddisp  char(2) - Codigo dispositivo (nao editado neste formulario, mantido por fidelidade de schema)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSer"
            THIS.this_cCampoChave = "EmpCods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SreBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria (EmpCods) para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpCods)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpCods    = TratarNulo(empcods,    "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cCodigo     = TratarNulo(cods,       "C")
                THIS.this_cDescricao  = TratarNulo(descs,      "C")
                THIS.this_nImpnfs     = TratarNulo(impnfs,     "N")
                THIS.this_nTiponfs    = TratarNulo(tiponfs,    "N")
                THIS.this_cModelos    = TratarNulo(modelos,    "C")
                THIS.this_cCtiponfs   = TratarNulo(ctiponfs,   "C")
                THIS.this_nMostecfs   = TratarNulo(mostecfs,   "N")
                THIS.this_nTpservicos = TratarNulo(tpservicos, "N")
                THIS.this_nNnfobrigs  = TratarNulo(nnfobrigs,  "N")
                THIS.this_nBlqinss    = TratarNulo(blqinss,    "N")
                THIS.this_nSelotrans  = TratarNulo(selotrans,  "N")
                THIS.this_cInicials   = TratarNulo(inicials,   "C")
                THIS.this_cFinals     = TratarNulo(finals,     "C")
                THIS.this_cCoddisp    = TratarNulo(coddisp,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SreBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar (reproduz Grupo_Salva.Click)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("S" + CHR(233) + "rie inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            THIS.this_cEmpCods = PADR(ALLTRIM(THIS.this_cEmps), 3) + PADR(ALLTRIM(THIS.this_cCodigo), 3)
            IF THIS.VerificarChaveExistente(THIS.this_cEmpCods)
                MsgAviso("S" + CHR(233) + "rie j" + CHR(225) + " cadastrada.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCtiponfs))
            MsgAviso("Tipo Nota Fiscal.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarChaveExistente - Verifica se EmpCods ja existe (equivalente
    * a ChkRegister('SigCdSer','EmpCods',lcKey) do legado)
    *====================================================================
    PROCEDURE VerificarChaveExistente(par_cEmpCods)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdSer" + ;
                " WHERE empcods = " + EscaparSQL(par_cEmpCods)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkEmpCods")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkEmpCods")
                SELECT cursor_4c_ChkEmpCods
                loc_lExiste = (cursor_4c_ChkEmpCods.qtd > 0)
                USE IN cursor_4c_ChkEmpCods
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar chave:" + CHR(13) + loException.Message, "SreBO.VerificarChaveExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdSer
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cEmpCods = PADR(ALLTRIM(THIS.this_cEmps), 3) + PADR(ALLTRIM(THIS.this_cCodigo), 3)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdSer (empcods, emps, cods, descs, impnfs,
                    tiponfs, modelos, ctiponfs, mostecfs, tpservicos,
                    nnfobrigs, blqinss, selotrans, inicials, finals, coddisp)
                VALUES (
                    <<EscaparSQL(THIS.this_cEmpCods)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<FormatarNumeroSQL(THIS.this_nImpnfs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTiponfs, 0)>>,
                    <<EscaparSQL(THIS.this_cModelos)>>,
                    <<EscaparSQL(THIS.this_cCtiponfs)>>,
                    <<FormatarNumeroSQL(THIS.this_nMostecfs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpservicos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNnfobrigs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBlqinss, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSelotrans, 0)>>,
                    <<EscaparSQL(THIS.this_cInicials)>>,
                    <<EscaparSQL(THIS.this_cFinals)>>,
                    <<EscaparSQL(THIS.this_cCoddisp)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SreBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdSer
    * OBS: empcods/emps/cods sao a chave e nao sao alterados no UPDATE
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdSer
                SET descs      = <<EscaparSQL(THIS.this_cDescricao)>>,
                    impnfs     = <<FormatarNumeroSQL(THIS.this_nImpnfs, 0)>>,
                    tiponfs    = <<FormatarNumeroSQL(THIS.this_nTiponfs, 0)>>,
                    modelos    = <<EscaparSQL(THIS.this_cModelos)>>,
                    ctiponfs   = <<EscaparSQL(THIS.this_cCtiponfs)>>,
                    mostecfs   = <<FormatarNumeroSQL(THIS.this_nMostecfs, 0)>>,
                    tpservicos = <<FormatarNumeroSQL(THIS.this_nTpservicos, 0)>>,
                    nnfobrigs  = <<FormatarNumeroSQL(THIS.this_nNnfobrigs, 0)>>,
                    blqinss    = <<FormatarNumeroSQL(THIS.this_nBlqinss, 0)>>,
                    selotrans  = <<FormatarNumeroSQL(THIS.this_nSelotrans, 0)>>,
                    inicials   = <<EscaparSQL(THIS.this_cInicials)>>,
                    finals     = <<EscaparSQL(THIS.this_cFinals)>>,
                    coddisp    = <<EscaparSQL(THIS.this_cCoddisp)>>
                WHERE empcods = <<EscaparSQL(THIS.this_cEmpCods)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SreBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdSer
    * Verifica uso em Notas Fiscais (SigMvNfi.series) antes de excluir
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar se a serie esta sendo usada em Notas Fiscais
            loc_cSQL = "SELECT COUNT(*) AS nNreg1s FROM SigMvNfi" + ;
                " WHERE series = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkNfi")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkNfi")
                    SELECT cursor_4c_ChkNfi
                    loc_nUso = NVL(cursor_4c_ChkNfi.nNreg1s, 0)
                    USE IN cursor_4c_ChkNfi
                ENDIF

                IF loc_nUso > 0
                    MsgAviso("S" + CHR(233) + "rie n" + CHR(227) + "o pode ser excluida pois est" + CHR(225) + " sendo usada em Notas Fiscais!")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdSer WHERE empcods = " + EscaparSQL(THIS.this_cEmpCods)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SreBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com empcods, emps, cods, descs, ctiponfs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (empcods C(6), emps C(3), cods C(3), descs C(20), ctiponfs C(5))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT empcods, emps, cods, descs, ctiponfs FROM SigCdSer"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY empcods"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SreBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (EmpCods)
    * par_cCodigo eh o EmpCods completo (Emps + Cods, 6 caracteres)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT empcods, emps, cods, descs, impnfs, tiponfs," + ;
                " modelos, ctiponfs, mostecfs, tpservicos, nnfobrigs," + ;
                " blqinss, selotrans, inicials, finals, coddisp" + ;
                " FROM SigCdSer WHERE empcods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("S" + CHR(233) + "rie n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SreBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarDescricaoEmpresa - Retorna Razas (SigCdEmp) para exibicao
    * (equivalente a CursorQuery('SigCdEmp','crSigCdEmp','Cemps',Cemps) do legado)
    *====================================================================
    PROCEDURE BuscarDescricaoEmpresa(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cEmps))
                loc_cSQL = "SELECT razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(par_cEmps)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
                IF loc_nResultado >= 0 AND USED("cursor_4c_Emp")
                    SELECT cursor_4c_Emp
                    IF RECCOUNT() > 0
                        loc_cDescricao = TratarNulo(razas, "C")
                    ENDIF
                    USE IN cursor_4c_Emp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar empresa:" + CHR(13) + loException.Message, "SreBO.BuscarDescricaoEmpresa")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE
