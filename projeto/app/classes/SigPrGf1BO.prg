*============================================================================
* SigPrGf1BO.prg - Business Object para "Falha X Recuperacao por Mes da
* Empresa" (SIGPRGF1)
*
* Form OPERACIONAL (SIGPRGF1 / FormSigPrGf1): tela de FILTRO que recebe um
* periodo (Data Inicial/Data Final, limitado a 12 meses) e dispara um
* processamento que agrega SigCdFea (Falhas/Pesoccbs) por mes da empresa
* corrente, gravando o resultado num cursor. Nao ha CRUD - o form apenas
* filtra e processa, depois abre SigPrGf2 (grafico) com o resultado.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): SigCdFea e
* SigCdEmp sao apenas consultadas para compor o relatorio.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrGf1BO AS BusinessBase

    *==========================================================================
    * Filtro de periodo - SIGPRGF1.getDtInicial/getDtFinal
    *==========================================================================
    this_dDataInicial = {}   && getDtInicial.Value - inicio do periodo
    this_dDataFinal   = {}   && getDtFinal.Value   - fim do periodo

    *==========================================================================
    * Empresa corrente (equivalente a _Empr do legado - CLAUDE.md regra:
    * NUNCA usar _EMPR, usar go_4c_Sistema.cCodEmpresa) e sua descricao,
    * lida de SigCdEmp (CursorQuery('SigCdEmp','crSigCdEmp','Cemps',_Empr,
    * 'Razas') do mProcessamento legado)
    *==========================================================================
    this_cEmpresa     = SPACE(3)    && go_4c_Sistema.cCodEmpresa - SigCdEmp.Cemps
    this_cNomeEmpresa = SPACE(40)   && SigCdEmp.Razas

    *==========================================================================
    * Titulos do relatorio/grafico (mProcessamento monta lcTitulo1/lcTitulo2)
    *==========================================================================
    this_cTitulo1 = ""   && "Falha X Recuperacao por Mes da Empresa " + emp + " - " + razao
    this_cTitulo2 = ""   && faixa de periodo formatada: "[De dd/mm/aaaa a dd/mm/aaaa]"

    *==========================================================================
    * Resultado do processamento (crRel1 do legado - agregado por mes)
    *==========================================================================
    this_cCursorResultado = ""   && nome do cursor com o resultado agregado
    this_nTotalRegistros  = 0    && RECCOUNT do cursor resultado (equivale ao "Not Eof()" legado)
    this_lProcessado      = .F.  && .T. quando mProcessamento rodou com sucesso e ha registros

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela proprietaria (form
    * apenas filtra/processa), entao this_cTabela/this_cCampoChave ficam
    * vazios. Carrega valores padrao de periodo (equivalente ao Init legado:
    * getDtInicial = 1o dia do mes corrente, getDtFinal = ultimo dia do mes
    * corrente) e a empresa corrente.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro, loc_dHoje
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_dHoje = DATE()
            THIS.this_dDataInicial = DATE(YEAR(loc_dHoje), MONTH(loc_dHoje), 1)
            THIS.this_dDataFinal   = GOMONTH(THIS.this_dDataInicial, 1) - 1

            IF TYPE("go_4c_Sistema.cCodEmpresa") = "C"
                THIS.this_cEmpresa = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DECISAO DE PROJETO (Fase 2 - Metodos CRUD):
    *
    * SigPrGf1 e um form OPERACIONAL de FILTRO/PROCESSAMENTO, sem tabela
    * propria e sem gravacao em banco (this_cTabela fica vazio - ver Init
    * acima). O legado (mProcessamento) so faz LEITURA de SigCdFea/SigCdEmp
    * e agrega o resultado num cursor LOCAL (crRel1, via "Into Cursor ...
    * ReadWrite"); nao ha TableUpdate, AddCursor nem Insert/Update/Delete
    * contra tabela remota.
    *
    * Por isso este BO NAO sobrescreve CarregarDoCursor(), Inserir() e
    * Atualizar(): o comportamento herdado de BusinessBase (CarregarDoCursor
    * generico, Inserir()/Atualizar() recusando a operacao) ja e o correto
    * para um BO somente-leitura. Os metodos reais do form ficam em
    * ValidarPeriodo() (equivalente a mChkValid) e Processar() (equivalente
    * a mProcessamento), implementados abaixo.
    *==========================================================================

    *==========================================================================
    * ValidarPeriodo - Equivalente a SIGPRGF1.mChkValid do legado. Valida o
    * par de datas (getDtInicial/getDtFinal) antes de processar: data final
    * preenchida, data final >= data inicial e periodo nao ultrapassando 12
    * meses. Preenche this_cMensagemErro e retorna .F. no primeiro erro (o
    * SetFocus no campo invalido fica por conta do Form, que le a mensagem
    * e decide qual controle focar).
    *==========================================================================
    FUNCTION ValidarPeriodo()

        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "Data Inicial Maior Que a Data Final!!!"
            RETURN .F.
        ENDIF

        IF ((YEAR(THIS.this_dDataInicial) = YEAR(THIS.this_dDataFinal) AND ;
            (MONTH(THIS.this_dDataInicial) - MONTH(THIS.this_dDataFinal) + 1) > 12) OR ;
            (YEAR(THIS.this_dDataInicial) != YEAR(THIS.this_dDataFinal) AND ;
            ((12 - MONTH(THIS.this_dDataInicial)) + MONTH(THIS.this_dDataFinal) + 1) > 12))
            THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Ultrapassa Doze Meses!!!"
            RETURN .F.
        ENDIF

        THIS.this_cMensagemErro = ""
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * Processar - Equivalente a SIGPRGF1.mProcessamento do legado. Busca a
    * empresa corrente em SigCdEmp, consulta SigCdFea no periodo informado
    * (filtrado por Emps) e agrega Falhas/Pesoccbs por mes num cursor local
    * (this_cCursorResultado), no mesmo formato que o legado monta para
    * alimentar o grafico do SigPrGf2.
    *==========================================================================
    FUNCTION Processar()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nResultado, ;
              loc_cDtIni, loc_cDtFim, loc_cStrgMes, loc_cTitulo1, loc_cTitulo2, ;
              loc_cEmpresaAtual, loc_cNomeEmpresa, ;
              loc_nDecimals, loc_cFixed, loc_cExact

        loc_lResultado = .F.

        *-- Contexto numerico/de comparacao do mProcessamento legado, salvo e
        *-- restaurado igual la ("m.lnDecimals = Set('Decimals',1)" etc. +
        *-- "Set Decimals To 6 / Set Fixed On / Set Exact On"). Nao eh detalhe
        *-- decorativo: o form roda com DataSession = 2 (transcrito do SCX) e a
        *-- datasession privada nasce com esses SETs no default do VFP, nao no
        *-- do sistema - a agregacao abaixo (VAL(STR(SUM(...), 16, 2)) e o
        *-- GROUP BY) tem de ver o mesmo contexto que o legado via.
        *-- Medido no VFP9: SET("Decimals") devolve NUMERIC e SET("Fixed")/
        *-- SET("Exact") devolvem CHARACTER - por isso nenhum deles vai
        *-- envolvido em VAL() (VAL sobre numerico dispara erro 11).
        loc_nDecimals = SET("Decimals")
        loc_cFixed    = SET("Fixed")
        loc_cExact    = SET("Exact")

        SET DECIMALS TO 6
        SET FIXED ON
        SET EXACT ON

        TRY
            THIS.this_lProcessado     = .F.
            THIS.this_nTotalRegistros = 0
            THIS.this_cMensagemErro   = ""

            IF USED("cursor_4c_TmpRel")
                USE IN cursor_4c_TmpRel
            ENDIF
            IF USED("cursor_4c_Resultado")
                USE IN cursor_4c_Resultado
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            * Empresa corrente (equivalente a CursorQuery('SigCdEmp','crSigCdEmp',
            * 'Cemps',_Empr,'Razas') do legado)
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(THIS.this_cEmpresa)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o com o Servidor de Banco de Dados (SigCdEmp): " + CapturarErroSQL()
            ELSE
                IF loc_nResultado > 0 AND !EOF("cursor_4c_Emp")
                    THIS.this_cNomeEmpresa = TratarNulo(cursor_4c_Emp.Razas, "")
                ELSE
                    THIS.this_cNomeEmpresa = ""
                ENDIF

                * Faixa de datas (Datas eh datetime; limite final vai ate 23:59:59,
                * igual a fDtoSQL(m.ldData2, '23:59:59') do legado)
                loc_cDtIni = FormatarDataSQL(THIS.this_dDataInicial)
                loc_cDtFim = "'" + PADL(YEAR(THIS.this_dDataFinal), 4, "0") + "-" + ;
                                   PADL(MONTH(THIS.this_dDataFinal), 2, "0") + "-" + ;
                                   PADL(DAY(THIS.this_dDataFinal), 2, "0") + " 23:59:59'"

                loc_cSQL = "SELECT a.Emps, a.Datas, b.Cemps, b.Razas, a.Falhas, a.Pesoccbs " + ;
                           "FROM SigCdFea a LEFT JOIN SigCdEmp b ON b.Cemps = a.Emps " + ;
                           "WHERE a.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " " + ;
                           "AND a.Emps = " + EscaparSQL(THIS.this_cEmpresa)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRel")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (" + CapturarErroSQL() + ")"
                ELSE
                    * Mes por extenso, blocos de 9 caracteres (transcrito do legado -
                    * "Mar?o" com CHR(231) no lugar do cedilha)
                    loc_cStrgMes = "Janeiro  Fevereiro" + "Mar" + CHR(231) + "o    " + ;
                                   "Abril    Maio     Junho    Julho    Agosto   Setembro Outubro  Novembro Dezembro "

                    loc_cTitulo1 = "Falha X Recupera" + CHR(231) + CHR(227) + "o por M" + CHR(234) + "s da Empresa "

                    IF EMPTY(THIS.this_dDataInicial) AND EMPTY(THIS.this_dDataFinal)
                        loc_cTitulo2 = ""
                    ELSE
                        IF THIS.this_dDataInicial = THIS.this_dDataFinal
                            loc_cTitulo2 = " [Em " + DTOC(THIS.this_dDataInicial) + "]"
                        ELSE
                            IF EMPTY(THIS.this_dDataInicial)
                                loc_cTitulo2 = " [At" + CHR(233) + " " + DTOC(THIS.this_dDataFinal) + "]"
                            ELSE
                                loc_cTitulo2 = " [De " + DTOC(THIS.this_dDataInicial) + " " + CHR(224) + " " + DTOC(THIS.this_dDataFinal) + "]"
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_cEmpresaAtual = ALLTRIM(THIS.this_cEmpresa)
                    loc_cNomeEmpresa  = ALLTRIM(TratarNulo(THIS.this_cNomeEmpresa, ""))

                    SELECT Emps AS Cemps, ;
                           PADR(DTOS(Datas), 6) AS cAnomess, ;
                           PADR(PADR(SUBSTR(m.loc_cStrgMes, (MONTH(Datas) * 9 - 8), 9), 3) + "./" + TRANSFORM(YEAR(Datas), "@L 9999"), 9) AS csTraNomes, ;
                           PADR(m.loc_cTitulo1 + ALLTRIM(NVL(Cemps, "")) + " - " + ALLTRIM(NVL(Razas, "")), 100) AS cTitulo1s, ;
                           m.loc_cTitulo2 AS ctitulo2s, ;
                           PADR(m.loc_cEmpresaAtual + " - " + m.loc_cNomeEmpresa, 100) AS cEmpresas, ;
                           VAL(STR(SUM(Falhas), 16, 2)) AS nFalhas, ;
                           VAL(STR(SUM(Pesoccbs), 16, 2)) AS nPesoccbs ;
                      FROM cursor_4c_TmpRel ;
                     GROUP BY 1, 2, 3, 4, 5, 6 ;
                      INTO CURSOR cursor_4c_Resultado READWRITE

                    IF USED("cursor_4c_TmpRel")
                        USE IN cursor_4c_TmpRel
                    ENDIF

                    SELECT cursor_4c_Resultado
                    GO TOP

                    THIS.this_cCursorResultado = "cursor_4c_Resultado"
                    THIS.this_cTitulo1         = loc_cTitulo1
                    THIS.this_cTitulo2         = loc_cTitulo2
                    THIS.this_nTotalRegistros  = RECCOUNT("cursor_4c_Resultado")
                    THIS.this_lProcessado      = (THIS.this_nTotalRegistros > 0)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        *-- Restauracao do contexto (igual ao fim do mProcessamento legado).
        *-- Fica FORA do TRY para valer tambem quando o CATCH dispara - caso
        *-- contrario um erro no meio do processamento deixaria a datasession
        *-- com DECIMALS 6 / FIXED ON para o resto da vida da tela.
        *-- "&loc_cFixed." eh macro-substituicao do proprio valor lido do SET
        *-- ("ON"/"OFF"), como no legado; sem prefixo "m." (o VFP le o nome da
        *-- macro ate o primeiro ponto, e "&m.loc_cFixed." tentaria expandir a
        *-- variavel "m").
        SET DECIMALS TO loc_nDecimals
        SET FIXED &loc_cFixed.
        SET EXACT &loc_cExact.

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
