*============================================================================
* SigPrGf2BO.prg - Business Object para "Grafico de Falha X Recuperacao
* Mensal" (SIGPRGF2)
*
* Form OPERACIONAL (SIGPRGF2 / FormSigPrGf2): tela de EXIBICAO de grafico
* (MSGraph.Chart via OleBoundControl), aberta pelo form pai (equivalente ao
* SIGPRGF1/FormSigPrGf1) que ja processou e deixou pronto um cursor agregado
* por mes (crRel1 no legado; normalmente SigPrGf1BO.this_cCursorResultado no
* sistema novo). O SIGPRGF2 nao processa dados novos contra o banco - ele so
* agrupa/formata o que ja veio no cursor de origem, monta as series do
* grafico (Falha/Recuperacao) por mes e mantem um cache por chave (empresa)
* para nao recalcular ao trocar no combo.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server, so agrega o cursor de origem.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrGf2BO AS BusinessBase

    *==========================================================================
    * Cursor de origem (crRel1 do legado) - resultado agregado por mes,
    * fornecido pelo form pai. NAO e populado por este BO; apenas consultado
    * (Select Distinct .../ Scan While ... do mGeraGrafico legado).
    *==========================================================================
    this_cCursorOrigem = ""

    *==========================================================================
    * Cursor com as chaves distintas do cursor de origem, para popular o
    * combo "Grupo / Vendedor :" (cmbChave1 - equivalente a "Select Distinct
    * a.cEmps From crRel1 a Order By 1 Into Array laVendedor" do legado).
    * Usamos cursor em vez de ARRAY para nao depender de escopo de m.array.
    *==========================================================================
    this_cCursorChaves = ""

    *==========================================================================
    * Cursor cache dos graficos ja gerados por chave (equivalente a
    * crGrafico1: gGrafico1s g(4)/cChave1s c(100)/cempresas c(254)/
    * ctitulo1s c(128)). A parte binaria do OLE (Append General ... Class
    * 'MSGraph.Chart') e responsabilidade do Form (glue com o OleBoundControl);
    * este BO cuida so da chave/titulos/series text-based.
    *==========================================================================
    this_cCursorGrafico = ""

    *==========================================================================
    * Chave (empresa) atualmente selecionada no combo (cChave1s do legado)
    *==========================================================================
    this_cChaveAtual = ""

    *==========================================================================
    * Titulos do grafico da chave atual (cTitulo1s/ctitulo2s do cursor de
    * origem - mGeraGrafico monta m.lcTitulo1 = AllTrim(cTitulo1s) + Chr(13)
    * + AllTrim(ctitulo2s))
    *==========================================================================
    this_cTitulo1      = ""
    this_cTitulo2      = ""
    this_cEmpresaAtual = ""

    *==========================================================================
    * Series do grafico (lnNgrupos fixo = 2: Falha e Recuperacao) e a
    * contagem de meses agregados na chave atual (lnNmeses)
    *==========================================================================
    this_nTotalGrupos = 2
    this_nTotalMeses  = 0

    *==========================================================================
    * Strings TAB-separadas com rotulos de mes e valores das duas series
    * (lcStrg1/lcStrg2/lcStrg3 do mGeraGrafico legado). O Form usa essas
    * strings para montar o Data() do Append General no OleBoundControl.
    *==========================================================================
    this_cLabelsMeses      = ""
    this_cSerieFalha       = ""
    this_cSerieRecuperacao = ""

    *==========================================================================
    * Flags de estado
    *==========================================================================
    this_lChaveEmCache  = .F.  && .T. quando a chave ja tinha grafico no cache (Locate achou)
    this_lGraficoGerado = .F.  && .T. quando ha dados validos para desenhar o grafico

    *==========================================================================
    * Init - Nao ha tabela proprietaria (form so exibe/agrega o que o form
    * pai processou), entao this_cTabela/this_cCampoChave ficam vazios.
    * Inicializa os nomes canonicos dos cursores de trabalho deste BO.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cCursorChaves  = "cursor_4c_Chaves"
            THIS.this_cCursorGrafico = "cursor_4c_Grafico"

            THIS.this_nTotalGrupos = 2
            THIS.this_nTotalMeses  = 0

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Decisao de arquitetura (Fase 2 - CRUD): SIGPRGF2 eh um VISUALIZADOR de
    * grafico (Falha X Recuperacao Mensal) que so agrega/formata o cursor de
    * origem (crRel1 no legado, this_cCursorOrigem aqui) recebido do form pai
    * (equivalente ao SigPrGf1). O dump do legado nao tem NENHUM Insert
    * Into/Update/Delete From contra tabela do SQL Server: o unico Insert Into
    * do metodo mgeragrafico grava no cursor LOCAL crGrafico1 (cache de
    * graficos ja montados por chave), que aqui vira THIS.this_cCursorGrafico
    * dentro de GerarGrafico(). CarregarDoCursor() mapeia as colunas desse
    * cache; Inserir()/Atualizar()/ExecutarExclusao() NAO sao sobrescritos
    * neste BO porque o comportamento padrao herdado de BusinessBase (recusar
    * a operacao) ja eh o correto para um BO sem tabela proprietaria.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia uma linha do cursor de cache de graficos
    * (this_cCursorGrafico, layout identico ao crGrafico1 legado) para as
    * propriedades do BO. Usado apos LOCATE/SEEK em GerarGrafico() ou por
    * quem precisar inspecionar uma linha ja posicionada do cache.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cChaveAtual      = ALLTRIM(TratarNulo(cChave1s, ""))
            THIS.this_cEmpresaAtual    = TratarNulo(cEmpresas, "")
            THIS.this_cTitulo1         = TratarNulo(cTitulo1s, "")
            THIS.this_cLabelsMeses     = TratarNulo(cLabelsMeses, "")
            THIS.this_cSerieFalha      = TratarNulo(cSerieFalha, "")
            THIS.this_cSerieRecuperacao = TratarNulo(cSerieRecuperacao, "")
            THIS.this_nTotalMeses      = OCCURS(CHR(9), THIS.this_cLabelsMeses)

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do grafico atualmente selecionado (equivalente
    * ao cChave1s do cache legado). Nao ha tabela proprietaria neste BO; a
    * chave existe so para identificar a linha do cache de graficos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChaveAtual)
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularChaves - Monta THIS.this_cCursorChaves com as chaves distintas do
    * cursor de origem (equivalente a "Select Distinct a.cEmps From crRel1
    * Order By 1 Into Array laVendedor" do mGeraGrafico legado). O Form usa
    * este cursor para popular o combo "Grupo / Vendedor :" (cmbChave1).
    *--------------------------------------------------------------------------
    PROCEDURE PopularChaves()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED(THIS.this_cCursorChaves)
                    USE IN (THIS.this_cCursorChaves)
                ENDIF

                SELECT DISTINCT ALLTRIM(cEmps) AS Chaves ;
                    FROM (THIS.this_cCursorOrigem) ;
                    ORDER BY 1 ;
                    INTO CURSOR (THIS.this_cCursorChaves) READWRITE

                IF RECCOUNT(THIS.this_cCursorChaves) > 0
                    GO TOP IN (THIS.this_cCursorChaves)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarGrafico - Equivalente ao mGeraGrafico legado (parte de dados: o
    * desenho do OLE/MSGraph.Chart fica por conta do Form). Se a chave ja
    * esta no cache (this_cCursorGrafico), so recarrega as propriedades a
    * partir dele (LOCATE, igual ao "Locate For crGrafico1.cChave1s==..." do
    * legado). Senao, varre this_cCursorOrigem (equivalente ao "Scan While
    * crRel1.cEmps==m.lcChave1" do legado), monta os rotulos de mes e as duas
    * series (Falha/Recuperacao) separados por TAB e grava a linha nova no
    * cache - so entao Insert Into acontece, e sempre no cursor LOCAL, nunca
    * no SQL Server.
    *--------------------------------------------------------------------------
    PROCEDURE GerarGrafico(par_cChave)
        LOCAL loc_lResultado, loc_oErro, loc_cChavePad, loc_cTitulo1, ;
              loc_cEmpresa, loc_cLabelsMeses, loc_cSerieFalha, ;
              loc_cSerieRecuperacao, loc_nMeses, loc_cPointAntigo, ;
              loc_cSeparAntigo

        loc_lResultado           = .F.
        THIS.this_lChaveEmCache  = .F.
        THIS.this_lGraficoGerado = .F.

        TRY
            IF EMPTY(par_cChave) OR !USED(THIS.this_cCursorOrigem)
                THIS.this_cMensagemErro = "Chave n" + CHR(227) + "o informada ou cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                loc_cChavePad = PADR(ALLTRIM(par_cChave), 100)
                THIS.this_cChaveAtual = ALLTRIM(par_cChave)

                IF !USED(THIS.this_cCursorGrafico)
                    CREATE CURSOR (THIS.this_cCursorGrafico) ;
                        (cChave1s C(100), cEmpresas C(254), cTitulo1s M, ;
                         cLabelsMeses M, cSerieFalha M, cSerieRecuperacao M)
                    INDEX ON cChave1s TAG cChave1s
                ENDIF

                SELECT (THIS.this_cCursorGrafico)
                LOCATE FOR cChave1s == loc_cChavePad

                IF FOUND()
                    THIS.this_lChaveEmCache     = .T.
                    THIS.this_cEmpresaAtual     = TratarNulo(cEmpresas, "")
                    THIS.this_cTitulo1          = TratarNulo(cTitulo1s, "")
                    * cTitulo2s nao existe no cache (crGrafico1 legado so guarda
                    * o titulo ja concatenado) - fica vazio ate a proxima geracao
                    THIS.this_cTitulo2          = ""
                    THIS.this_cLabelsMeses      = TratarNulo(cLabelsMeses, "")
                    THIS.this_cSerieFalha       = TratarNulo(cSerieFalha, "")
                    THIS.this_cSerieRecuperacao = TratarNulo(cSerieRecuperacao, "")
                    THIS.this_nTotalMeses       = OCCURS(CHR(9), THIS.this_cLabelsMeses)
                    THIS.this_lGraficoGerado    = .T.
                    loc_lResultado = .T.
                ELSE
                    SELECT (THIS.this_cCursorOrigem)
                    LOCATE FOR ALLTRIM(cEmps) == ALLTRIM(par_cChave)

                    IF !FOUND()
                        THIS.this_cMensagemErro = "Nenhum registro encontrado para a chave [" + ALLTRIM(par_cChave) + "]."
                    ELSE
                        loc_cTitulo1 = ALLTRIM(cTitulo1s) + CHR(13) + ALLTRIM(cTitulo2s)
                        THIS.this_cTitulo2 = ALLTRIM(TratarNulo(cTitulo2s, ""))
                        loc_cEmpresa = TratarNulo(cEmpresas, "")

                        loc_cLabelsMeses      = ""
                        loc_cSerieFalha       = "Falha"
                        loc_cSerieRecuperacao = "Recupera" + CHR(231) + CHR(227) + "o"
                        loc_nMeses = 0

                        * Isolamento de locale igual ao mGeraGrafico legado -
                        * TRANSFORM abaixo usa picture fixa "999,999,999.99"
                        loc_cPointAntigo = SET("POINT")
                        loc_cSeparAntigo = SET("SEPARATOR")
                        SET POINT TO ","
                        SET SEPARATOR TO "."

                        TRY
                            SCAN WHILE ALLTRIM(cEmps) == ALLTRIM(par_cChave)
                                loc_nMeses = loc_nMeses + 1
                                loc_cLabelsMeses      = loc_cLabelsMeses + CHR(9) + ALLTRIM(TratarNulo(cStranomes, ""))
                                loc_cSerieFalha       = loc_cSerieFalha + CHR(9) + ALLTRIM(TRANSFORM(NVL(nFalhas, 0), "999,999,999.99"))
                                loc_cSerieRecuperacao = loc_cSerieRecuperacao + CHR(9) + ALLTRIM(TRANSFORM(NVL(nPesoccbs, 0), "999,999,999.99"))
                            ENDSCAN
                        FINALLY
                            SET POINT TO (loc_cPointAntigo)
                            SET SEPARATOR TO (loc_cSeparAntigo)
                        ENDTRY

                        SELECT (THIS.this_cCursorGrafico)
                        INSERT INTO (THIS.this_cCursorGrafico) ;
                            (cChave1s, cEmpresas, cTitulo1s, cLabelsMeses, cSerieFalha, cSerieRecuperacao) ;
                            VALUES (loc_cChavePad, loc_cEmpresa, loc_cTitulo1, loc_cLabelsMeses, loc_cSerieFalha, loc_cSerieRecuperacao)

                        THIS.this_cTitulo1          = loc_cTitulo1
                        THIS.this_cEmpresaAtual     = loc_cEmpresa
                        THIS.this_cLabelsMeses      = loc_cLabelsMeses
                        THIS.this_cSerieFalha       = loc_cSerieFalha
                        THIS.this_cSerieRecuperacao = loc_cSerieRecuperacao
                        THIS.this_nTotalMeses       = loc_nMeses
                        THIS.this_lChaveEmCache     = .F.
                        THIS.this_lGraficoGerado    = .T.
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores locais deste BO (nunca tocam SQL Server)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !EMPTY(THIS.this_cCursorChaves) AND USED(THIS.this_cCursorChaves)
            USE IN (THIS.this_cCursorChaves)
        ENDIF

        IF !EMPTY(THIS.this_cCursorGrafico) AND USED(THIS.this_cCursorGrafico)
            USE IN (THIS.this_cCursorGrafico)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
