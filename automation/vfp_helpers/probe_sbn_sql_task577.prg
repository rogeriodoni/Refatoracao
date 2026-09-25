*-- Exercita o caminho SQL REAL do SigMvSbnBO (BuscarSubniveis ->
*-- BuscarItensSubnivel -> BuscarDadosProduto). Nome de coluna invalido
*-- compila limpo e so quebra em RUNTIME (CLAUDE.md #14), entao instanciar
*-- o form em ModoTeste NAO prova nada sobre estas queries.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_cOut, loc_oBO, loc_oErro, loc_nRes, loc_cSaida
LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_nDopes, loc_cChave, loc_cProd
loc_cSaida = "C:\4c\tasks\task577\probe_sbn_sql.txt"
loc_cOut   = ""

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    IF gnConnHandle < 0
        loc_cOut = loc_cOut + "FALHA na conexao SQL" + CHR(13) + CHR(10)
    ELSE
        SQLSETPROP(gnConnHandle, "QueryTimeOut", 120)
        loc_cOut = loc_cOut + "conexao OK (handle " + TRANSFORM(gnConnHandle) + ")" + CHR(13) + CHR(10)

        *-- Acha um subnivel REAL: linha de SigMvPec + a operacao correspondente
        *-- ATENCAO: Codigos/1000000 em SQL Server devolve DECIMAL (114.000002),
        *-- nao 114 - por isso um JOIN direto nessa divisao nunca casa. Usar
        *-- FLOOR para obter o nDopes, invertendo a composicao que o BO faz
        *-- (loc_nCodigo = nDopes * 1000000 + Numes).
        loc_nRes = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 a.EmpSubns, a.Codigos, c.Dopes, c.nDopes " + ;
            "FROM SigMvPec a JOIN SigCdOpe c ON c.nDopes = FLOOR(a.Codigos / 1000000.0) " + ;
            "ORDER BY a.Codigos DESC", "crSemente")

        IF loc_nRes < 1 OR RECCOUNT("crSemente") = 0
            loc_cOut = loc_cOut + "SEM SEMENTE: nao ha linha em SigMvPec para testar" + CHR(13) + CHR(10)
        ELSE
            SELECT crSemente
            GO TOP
            loc_cEmps  = ALLTRIM(crSemente.EmpSubns)
            loc_cDopes = ALLTRIM(crSemente.Dopes)
            loc_nDopes = crSemente.nDopes
            loc_nNumes = crSemente.Codigos - (loc_nDopes * 1000000)
            loc_cOut = loc_cOut + "semente: Emps=[" + loc_cEmps + "] Dopes=[" + loc_cDopes + ;
                "] Numes=" + ALLTRIM(STR(loc_nNumes)) + CHR(13) + CHR(10)

            loc_oBO = CREATEOBJECT("SigMvSbnBO")

            *-- 1) BuscarSubniveis
            IF loc_oBO.BuscarSubniveis(loc_cEmps, loc_cDopes, loc_nNumes)
                loc_cOut = loc_cOut + "BuscarSubniveis      : OK - " + ;
                    ALLTRIM(STR(RECCOUNT(loc_oBO.this_cCursorLista))) + " linha(s)" + CHR(13) + CHR(10)

                SELECT (loc_oBO.this_cCursorLista)
                GO TOP
                loc_oBO.CarregarDoCursor(loc_oBO.this_cCursorLista)
                loc_cOut = loc_cOut + "CarregarDoCursor     : OK - Valos=" + ;
                    TRANSFORM(loc_oBO.this_nValorTotal) + " Status=[" + ;
                    ALLTRIM(loc_oBO.this_cDescStatus) + "]" + CHR(13) + CHR(10)

                *-- 2) BuscarItensSubnivel
                loc_cChave = loc_oBO.MontarChaveEmpDopNums( ;
                    EVALUATE(loc_oBO.this_cCursorLista + ".Emps"), ;
                    EVALUATE(loc_oBO.this_cCursorLista + ".Dopes"), ;
                    EVALUATE(loc_oBO.this_cCursorLista + ".Numes"))
                loc_cOut = loc_cOut + "chave EmpDopNums     : [" + loc_cChave + "]" + CHR(13) + CHR(10)

                IF loc_oBO.BuscarItensSubnivel(loc_cChave)
                    loc_cOut = loc_cOut + "BuscarItensSubnivel  : OK - " + ;
                        ALLTRIM(STR(RECCOUNT(loc_oBO.this_cCursorItens))) + " item(ns)" + CHR(13) + CHR(10)

                    SELECT (loc_oBO.this_cCursorItens)
                    GO TOP
                    IF !EOF()
                        loc_cProd = ALLTRIM(EVALUATE(loc_oBO.this_cCursorItens + ".cpros"))
                        *-- 3) BuscarDadosProduto / BuscarImagemProdutoPorCodigo
                        loc_cOut = loc_cOut + "BuscarDadosProduto   : " + ;
                            IIF(loc_oBO.BuscarDadosProduto(loc_cProd), "OK", "FALHOU: " + loc_oBO.this_cMensagemErro) + ;
                            " (produto [" + loc_cProd + "])" + CHR(13) + CHR(10)
                        loc_cOut = loc_cOut + "BuscarImagemProduto  : " + ;
                            IIF(loc_oBO.BuscarImagemProdutoPorCodigo(loc_cProd), "OK", "FALHOU: " + loc_oBO.this_cMensagemErro) + ;
                            CHR(13) + CHR(10)
                    ENDIF
                ELSE
                    loc_cOut = loc_cOut + "BuscarItensSubnivel  : FALHOU: " + loc_oBO.this_cMensagemErro + CHR(13) + CHR(10)
                ENDIF

                *-- 4) ObterNumeroOS
                loc_cOut = loc_cOut + "ObterNumeroOS        : " + ;
                    TRANSFORM(loc_oBO.ObterNumeroOS(loc_cEmps, loc_cDopes, loc_nNumes)) + ;
                    IIF(EMPTY(loc_oBO.this_cMensagemErro), "", " | msg: " + loc_oBO.this_cMensagemErro) + CHR(13) + CHR(10)
            ELSE
                loc_cOut = loc_cOut + "BuscarSubniveis      : FALHOU: " + loc_oBO.this_cMensagemErro + CHR(13) + CHR(10)
            ENDIF
        ENDIF

        SQLDISCONNECT(gnConnHandle)
    ENDIF

CATCH TO loc_oErro
    loc_cOut = loc_cOut + "EXCECAO: " + loc_oErro.Message + " | linha " + ;
        TRANSFORM(loc_oErro.LineNo) + " | " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, loc_cSaida)
QUIT
