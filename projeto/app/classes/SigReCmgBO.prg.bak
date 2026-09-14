*==============================================================================
* SigReCmgBO.prg
* Business Object: Grafico Clientes que Mais Compram (SIGRECMG)
* Herda de: BusinessBase
* Tipo: OPERACIONAL - subformulario de exibicao de grafico
* Sem tabela direta (dados vem de TmpResult do formulario pai)
*==============================================================================

DEFINE CLASS SigReCmgBO AS BusinessBase

    *-- Identificacao
    this_cTabela          = ""
    this_cCampoChave      = ""

    *-- Estado do grafico
    this_nNumGrafico      = 0      && Posicao atual do grafico exibido (1-3)
    this_lTodosGraficos   = .F.    && Imprimir todos os graficos em sequencia
    this_nInicioGrafico   = 1      && Grafico inicial para impressao em lote
    this_cChaveAtual      = ""     && Chave selecionada no combo (ordem + nome cliente)

    *-- Titulos do grafico (lidos de TmpResult ao gerar cada grafico)
    this_cTitulo1         = ""
    this_cTitulo2         = ""
    this_cTitulo3         = ""
    this_cTitulo4         = ""
    this_cEmpresaGrafico  = ""

    *==========================================================================
    * Init - Inicializa o BO sem tabela direta (form operacional)
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Obrigatorio para sistema de auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaveAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Atualizar - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * InicializarCursorGrafico - Cria cursor CrGrafico1 se nao existe
    * Estrutura IDENTICA ao original (BeforeOpenTables/mGeraGrafico)
    *==========================================================================
    PROCEDURE InicializarCursorGrafico()
        IF !USED("CrGrafico1")
            SET NULL ON
            CREATE CURSOR CrGrafico1 (;
                gGrafico1s G(4),;
                cChave1s   C(100),;
                cEmpresas  C(128),;
                cTitulo1s  C(64),;
                cTitulo2s  C(64),;
                cTitulo3s  C(64),;
                cTitulo4s  C(64))
            SET NULL OFF
            INDEX ON cChave1s TAG pkchave1
        ENDIF
    ENDPROC

    *==========================================================================
    * ZerarCursorGrafico - Limpa CrGrafico1 para regerar graficos
    *==========================================================================
    PROCEDURE ZerarCursorGrafico()
        IF USED("CrGrafico1")
            SELECT CrGrafico1
            ZAP
        ENDIF
    ENDPROC

    *==========================================================================
    * FecharCursores - Fecha cursores locais do grafico
    *==========================================================================
    PROCEDURE FecharCursores()
        IF USED("CrGrafico1")
            USE IN CrGrafico1
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarClientesTmpResult - Busca clientes distintos de TmpResult
    * Popula par_aClientes com [Ordem, Crclis] ordenado por Ordem
    * Retorna numero de clientes encontrados (0 se TmpResult nao existe)
    *==========================================================================
    PROCEDURE BuscarClientesTmpResult(par_aClientes)
        LOCAL loc_nTotal, loc_oErro
        loc_nTotal = 0

        TRY
            IF USED("TmpResult")
                SELECT DISTINCT Ordem, Crclis ;
                  FROM TmpResult ;
                 ORDER BY Ordem ;
                  INTO ARRAY par_aClientes

                loc_nTotal = ALEN(par_aClientes, 1)
                THIS.this_cChaveAtual = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * ObterTitulosGrafico - Le titulos e empresa de TmpResult pela chave
    * par_cChave1 = item do combo (5 chars ordem + separador + nome cliente)
    * Popula this_cTitulo1..4 e this_cEmpresaGrafico
    *==========================================================================
    PROCEDURE ObterTitulosGrafico(par_cChave1)
        LOCAL loc_nOrdem, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_nOrdem = VAL(LEFT(par_cChave1, 5))

            IF USED("TmpResult")
                SELECT TmpResult
                SET ORDER TO ""
                LOCATE FOR TmpResult.ordem = loc_nOrdem

                IF !EOF()
                    THIS.this_cTitulo1        = ALLTRIM(TmpResult.cTitulo1s)
                    THIS.this_cTitulo2        = ALLTRIM(TmpResult.cTitulo2s)
                    THIS.this_cTitulo3        = ALLTRIM(TmpResult.cTitulo3s)
                    THIS.this_cTitulo4        = ALLTRIM(TmpResult.cTitulo4s)
                    THIS.this_cEmpresaGrafico = ALLTRIM(TmpResult.cEmpresas)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PrepararDadosGrafico - Prepara e insere dados no CrGrafico1
    * par_cChave2     = chave composta (chave1 + nome do eixo para o grafico N)
    * par_nContaGrafico = 1, 2 ou 3
    * par_nQtVal      = 1=Valor, 2=Quantidade (do OptionGroup Opt_SelRel do pai)
    * par_cStrgeixoY  = string do eixo Y com 3 nomes de 10 chars cada
    * Retorna .T. se CrGrafico1 preparado (novo ou ja existente)
    *==========================================================================
    PROCEDURE PrepararDadosGrafico(par_cChave2, par_nContaGrafico, par_nQtVal, par_cStrgeixoY)
        LOCAL loc_lResultado, loc_cStrg1, loc_cStrg2, loc_nVlGrf1
        LOCAL loc_cStrgeixoX, loc_nNlegenda1, loc_nConta2, loc_oErro
        LOCAL loc_cCampValComp, loc_cCampValAno
        loc_lResultado = .F.

        TRY
            THIS.InicializarCursorGrafico()

            *-- Verifica se o grafico ja foi gerado para esta chave
            SELECT CrGrafico1
            LOCATE FOR CrGrafico1.cChave1s = PADR(par_cChave2, 100)

            IF !EOF()
                loc_lResultado = .T.
            ELSE
                IF USED("TmpResult")
                    *-- Titulo do eixo X (nome do tipo de grafico)
                    loc_cStrg1 = CHR(9) + PROPER(ALLTRIM(SUBSTR(par_cStrgeixoY, (par_nContaGrafico * 10 - 9), 10)))

                    *-- Campos conforme tipo Valor/Quantidade
                    loc_cCampValComp = ALLTRIM(SUBSTR("ncomprasordem   " + IIF(par_nQtVal = 1, "nvalcomp", "nqtde   "), (par_nContaGrafico * 8 - 7), 8))
                    loc_cCampValAno  = ALLTRIM(SUBSTR("ncompra ordem   " + IIF(par_nQtVal = 1, "nvalano ", "nqtdano "), (par_nContaGrafico * 8 - 7), 8))

                    *-- Linha geral (total do ranking)
                    loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValComp)
                    loc_cStrg2  = "Geral" + CHR(9) + ;
                                  ALLTRIM(TRANSFORM(IIF(par_nContaGrafico = 2, TmpResult.MaxOrdem - loc_nVlGrf1 + 1, loc_nVlGrf1), "999,999,999,999")) + ;
                                  CHR(13) + CHR(10)

                    *-- Linhas por ano (ate 7 anos)
                    loc_cStrgeixoX = TmpResult.cStrAno1s
                    loc_nNlegenda1 = 7

                    FOR loc_nConta2 = 1 TO loc_nNlegenda1
                        IF !EMPTY(SUBSTR(loc_cStrgeixoX, (loc_nConta2 * 4 - 3), 4))
                            loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValAno + ALLTRIM(STR(loc_nConta2, 20, 0)))
                            loc_cStrg2  = loc_cStrg2 + ;
                                          PROPER(ALLTRIM(SUBSTR(loc_cStrgeixoX, (loc_nConta2 * 4 - 3), 4))) + ;
                                          CHR(9) + ;
                                          ALLTRIM(TRANSFORM(IIF(par_nContaGrafico = 2, TmpResult.MaxOrdem - loc_nVlGrf1 + 1, loc_nVlGrf1), "999,999,999,999")) + ;
                                          CHR(13) + CHR(10)
                        ENDIF
                    ENDFOR

                    *-- Insere estrutura no CrGrafico1 com titulos e dados OLE
                    SELECT CrGrafico1
                    INSERT INTO CrGrafico1 (cChave1s, cTitulo1s, cTitulo2s, cTitulo3s, cTitulo4s, cEmpresas) ;
                        VALUES (par_cChave2, THIS.this_cTitulo1, THIS.this_cTitulo2, ;
                                THIS.this_cTitulo3, THIS.this_cTitulo4, THIS.this_cEmpresaGrafico)
                    APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" DATA (loc_cStrg1 + CHR(13) + CHR(10) + loc_cStrg2)

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * NavGraficoAnterior - Decrementa posicao do grafico (minimo 1)
    * Retorna o numero atual apos decremento
    *==========================================================================
    PROCEDURE NavGraficoAnterior()
        THIS.this_nNumGrafico = MAX(1, THIS.this_nNumGrafico - 1)
        RETURN THIS.this_nNumGrafico
    ENDPROC

    *==========================================================================
    * NavGraficoProximo - Incrementa posicao do grafico (maximo 3)
    * Retorna o numero atual apos incremento
    *==========================================================================
    PROCEDURE NavGraficoProximo()
        THIS.this_nNumGrafico = MIN(3, THIS.this_nNumGrafico + 1)
        RETURN THIS.this_nNumGrafico
    ENDPROC

    *==========================================================================
    * ObterChaveGrafico - Monta chave composta para lookup em CrGrafico1
    * par_cChave1 = item do combo (ordem + separador + cliente)
    * par_nContaGrafico = 1, 2 ou 3
    * par_cStrgeixoY = string do eixo Y (30 chars = 3 nomes de 10)
    *==========================================================================
    PROCEDURE ObterChaveGrafico(par_cChave1, par_nContaGrafico, par_cStrgeixoY)
        RETURN par_cChave1 + SUBSTR(par_cStrgeixoY, (par_nContaGrafico * 10 - 9), 10)
    ENDPROC

ENDDEFINE
