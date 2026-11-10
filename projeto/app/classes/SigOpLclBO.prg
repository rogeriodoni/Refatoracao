*====================================================================
* SigOpLclBO.prg
*
* Business Object para Selecao de Localizacao de Estoque
* (atribuicao da localizacao fisica - Base/Nivel2/Nivel3/Nivel4 - aos
* itens marcados numa grade de movimentacao fornecida pelo form
* chamador, via cursor crTpmMvItn na data session compartilhada)
*
* Tabelas: SigLcNv1 (Base), SigLcNv2, SigLcNv3, SigLcNv4 (hierarquia
* de localizacao - cada nivel 2/3/4 guarda em Nivel um XML com os
* codigos validos do nivel anterior, expandido em cursor pelo
* equivalente a ReverterXML do legado)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpLclBO AS BusinessBase

    *-- Contexto recebido do form chamador (equivalente a pcEscolha/pcOrigem
    *-- do Init legado) - define o modo da tela (INSERIR/ALTERAR/outro) e
    *-- qual coluna de crTpmMvItn recebe a localizacao (Localos quando
    *-- this_cOrigem = 'ORIGEM', Locals nos demais casos)
    this_cEscolha    = ""   && pcEscolha legado - modo da tela chamadora
    this_cOrigem     = ""   && pcOrigem legado - 'ORIGEM' ou outro

    *-- Nivel 1 (Base) - SigLcNv1.cods char(2) / descs char(20)
    this_cBase       = ""
    this_cDescBase   = ""

    *-- Nivel 2 - SigLcNv2.cods char(2) / descs char(20)
    this_cNvl2       = ""
    this_cDescNvl2   = ""

    *-- Nivel 3 - SigLcNv3.cods char(2) / descs char(20)
    this_cNvl3       = ""
    this_cDescNvl3   = ""

    *-- Nivel 4 - SigLcNv4.cods char(4) / descs char(20)
    this_cNvl4       = ""
    this_cDescNvl4   = ""

    *-- Localizacao composta (Base+Nvl2+Nvl3+Nvl4), igual ao lcLocaliza
    *-- do btnLocalizar.Click legado - gravada em csLocals.Locals e
    *-- depois propagada para crTpmMvItn.Locals/Localos
    this_cLocalizacaoMontada = ""

    *-- .T. quando ha pelo menos uma linha de crItensLoc com Marcas <> 0
    *-- (equivalente ao guard do btnLocalizar.When/do When do Check1)
    this_lTemItensSelecionados = .F.

    *-- ITEM corrente da grade (linha de cursor_4c_Itens, que espelha
    *-- crTpmMvItn). Alimentadas por CarregarDoCursor e usadas por
    *-- ObterChavePrimaria/RegistrarAuditoria.
    *-- cItens eh NUMERIC: SigMvItn.cItens eh numeric(10,0)
    this_nCItens     = 0
    this_cCpros      = ""    && SigMvItn.cpros   char(14)
    this_cDpros      = ""    && SigMvItn.dpros   char(65)
    this_cLocalItem  = ""    && SigMvItn.locals / localos char(10)
    this_cCategoria  = ""    && SigCdPro.categoria char(6)
    this_nMarcas     = 0     && marca de selecao da grade (0/1)

    *-- Quantidade de itens efetivamente gravados pelo ultimo Inserir()
    *-- (linhas acrescentadas a cursor_4c_Locais) e pelo ultimo Atualizar()
    *-- (linhas propagadas para crTpmMvItn). Usadas pelo form para decidir
    *-- se houve o que gravar - NUNCA reportar sucesso sem gravacao.
    this_nItensGravados    = 0
    this_nItensConfirmados = 0

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigLcNv1"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * FecharCursor - fecha alias com guarda de BUFFERING (regra #52)
    *
    * TABLEREVERT sem buffering NAO eh no-op: estoura erro 1586 "Function
    * requires row or table buffering mode". Cursor nascido de CREATE
    * CURSOR / SELECT ... INTO CURSOR vem com Buffering = 1, e USE IN
    * fecha o alias mesmo com buffer sujo - por isso o TABLEREVERT so
    * acontece quando ha buffering de verdade.
    *====================================================================
    PROTECTED PROCEDURE FecharCursor(par_cAlias)
        IF VARTYPE(par_cAlias) = "C" AND !EMPTY(ALLTRIM(par_cAlias))
            IF USED(par_cAlias)
                IF CURSORGETPROP("Buffering", par_cAlias) > 1
                    TABLEREVERT(.T., par_cAlias)
                ENDIF
                USE IN (par_cAlias)
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * MarcaComoNumero / ComoTexto - leitura TIPO-SEGURA de coluna de XML
    *
    * O cursor que sai do fXmlToCursor tem os tipos ditados pelo XML, e o
    * XMLTOCURSOR nativo INFERE tipo quando o XML nao traz schema XSD.
    * MEDIDO no VFP9 em 2026-11-08 (automation\medir_xml_schema.prg), com o
    * mesmo cursor de origem (Cods C(2)="01", Marcas N(1)=1):
    *
    *   XML COM schema -> Marcas=N, Cods=C "01", Codigo=C "0001"   (fiel)
    *   XML SEM schema -> Marcas=L, Cods=N 1,    Codigo=N 1        (estragado)
    *
    * O legado funciona com "Scan For CrAux.Marcas <> 0" e grava CrAux.Cods
    * em coluna char, logo o XML gravado em producao TRAZ schema. Mas um
    * registro sem schema faria "Marcas <> 0" estourar
    * "Operator/operand type mismatch" e abortar a expansao INTEIRA - os
    * cursores de nivel ficariam vazios e os lookups da tela nao mostrariam
    * nada, sem erro visivel. Estes dois helpers absorvem essa variacao de
    * tipo; a semantica para o XML normal (com schema) eh identica.
    *====================================================================
    PROTECTED PROCEDURE MarcaComoNumero(par_uValor)
        LOCAL loc_nMarca, loc_cTipo

        loc_nMarca = 0
        loc_cTipo  = VARTYPE(par_uValor)

        DO CASE
            CASE ISNULL(par_uValor)
                loc_nMarca = 0
            CASE loc_cTipo = "N"
                loc_nMarca = IIF(par_uValor <> 0, 1, 0)
            CASE loc_cTipo = "L"
                loc_nMarca = IIF(par_uValor, 1, 0)
            CASE loc_cTipo = "C"
                *-- "1"/"S"/"T"/".T." contam como marcado
                loc_nMarca = IIF(INLIST(UPPER(LEFT(ALLTRIM(par_uValor) + " ", 1)), "1", "S", "T"), 1, 0)
            OTHERWISE
                loc_nMarca = 0
        ENDCASE

        RETURN loc_nMarca
    ENDPROC

    PROTECTED PROCEDURE ComoTexto(par_uValor)
        LOCAL loc_cTexto, loc_cTipo

        loc_cTexto = ""
        loc_cTipo  = VARTYPE(par_uValor)

        DO CASE
            CASE ISNULL(par_uValor)
                loc_cTexto = ""
            CASE loc_cTipo = "C"
                loc_cTexto = par_uValor
            CASE loc_cTipo = "N"
                loc_cTexto = ALLTRIM(TRANSFORM(par_uValor))
            CASE loc_cTipo = "L"
                loc_cTexto = IIF(par_uValor, "1", "0")
            OTHERWISE
                loc_cTexto = ""
        ENDCASE

        RETURN loc_cTexto
    ENDPROC

    *====================================================================
    * ObterPrefixoTemp - prefixo dos arquivos temporarios de imagem
    *
    * Legado: Sys(2023) + [\] + goSistema.Sys2015Tmp + Sys(2015) + [.jpg]
    * A property Sys2015Tmp foi acrescentada ao go_4c_Sistema no config.prg;
    * o PEMSTATUS aqui eh so para nao estourar "Property SYS2015TMP is not
    * found" num ambiente com config antigo em memoria (medido no VFP9:
    * leitura de property ausente em objeto Empty eh erro, nao .NULL.).
    *====================================================================
    PROTECTED PROCEDURE ObterPrefixoTemp()
        LOCAL loc_cPrefixo
        loc_cPrefixo = "4c_tmp_"
        IF TYPE("go_4c_Sistema") = "O"
            IF PEMSTATUS(go_4c_Sistema, "Sys2015Tmp", 5)
                loc_cPrefixo = ALLTRIM(NVL(go_4c_Sistema.Sys2015Tmp, "4c_tmp_"))
            ENDIF
        ENDIF
        RETURN loc_cPrefixo
    ENDPROC

    *====================================================================
    * CriarCursorLocalizacoes - cria o cursor das atribuicoes ja feitas na
    *                           tela e ainda nao confirmadas
    *
    * Equivale ao csLocals do Init legado:
    *     Create Cursor csLocals(cItens n(4), Cpros c(14), Locals c(10))
    *
    * DESVIO DELIBERADO: cItens vai como N(10,0) e nao N(4). A coluna de
    * origem eh SigMvItn.cItens numeric(10,0); com N(4) todo item acima de
    * 9999 estouraria no APPEND. Nao eh formula de negocio (regra #17), eh
    * largura de buffer - e casar com o schema eh a regra da casa.
    * Cpros c(14) e Locals c(10) batem com SigMvItn.cpros / .locals.
    *====================================================================
    PROCEDURE CriarCursorLocalizacoes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.FecharCursor("cursor_4c_Locais")
            CREATE CURSOR cursor_4c_Locais (cItens N(10, 0), Cpros C(14), Locals C(10))
            loc_lSucesso = USED("cursor_4c_Locais")
        CATCH TO loc_oErro
            MsgErro("Erro ao criar o cursor de localiza" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarItens - monta o cursor da grade a partir de crTpmMvItn
    *
    * Legado (Init):
    *   Select 0 as Marcas, Cpros, Dpros, cItens,
    *          Iif(ThisForm.pcOrigem='ORIGEM', LocalOs, Locals) as Locals,
    *          Space(10) as Categoria
    *     from crTpmMvItn Where Not Empty(Cpros) Into Cursor crItensLoc ReadWrite
    *   + por item: Select Categoria From SigCdPro where Cpros = '<item>'
    *
    * crTpmMvItn eh o cursor do form CHAMADOR (contrato externo) - conserva
    * o nome do legado de proposito; os demais seguem o PILAR 3.
    *
    * Os TRES tags (cItens / Cpros / Categoria) sao criados aqui, um por
    * coluna, para que OrdenarItens possa fazer SET ORDER TO TAG <coluna>.
    *====================================================================
    PROCEDURE CarregarItens(par_cOrigem)
        LOCAL loc_lSucesso, loc_cColLocal, loc_cSQL, loc_nResultado, loc_lProsseguir

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        IF PCOUNT() >= 1 AND VARTYPE(par_cOrigem) = "C"
            THIS.this_cOrigem = par_cOrigem
        ENDIF

        TRY
            IF !USED("crTpmMvItn")
                THIS.this_cMensagemErro = "O cursor de itens do movimento (crTpmMvItn) n" + ;
                                          CHR(227) + "o est" + CHR(225) + " aberto."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Legado: a coluna de origem muda conforme pcOrigem
                loc_cColLocal = IIF(ALLTRIM(UPPER(NVL(THIS.this_cOrigem, ""))) == "ORIGEM", ;
                                    "LocalOs", "Locals")

                THIS.FecharCursor("cursor_4c_Itens")

                SELECT 0 AS Marcas, Cpros, Dpros, cItens, ;
                       &loc_cColLocal. AS Locals, SPACE(10) AS Categoria ;
                    FROM crTpmMvItn ;
                    WHERE !EMPTY(Cpros) ;
                    INTO CURSOR cursor_4c_Itens READWRITE

                *-- Categoria de cada produto (SigCdPro.categoria char(6)).
                *-- Uma consulta por item, como o legado - a grade eh pequena
                *-- e assim o resultado nao divergir do original.
                IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 ;
                        AND TYPE("gnConnHandle") = "N"
                    IF gnConnHandle > 0
                        SELECT cursor_4c_Itens
                        GO TOP
                        SCAN
                            loc_cSQL = "SELECT Categoria FROM SigCdPro WHERE Cpros = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Itens.Cpros))

                            THIS.FecharCursor("cursor_4c_Prod")
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Prod")

                            IF loc_nResultado > 0 AND USED("cursor_4c_Prod")
                                IF RECCOUNT("cursor_4c_Prod") > 0
                                    REPLACE Categoria ;
                                        WITH TratarNulo(cursor_4c_Prod.Categoria, "") ;
                                        IN cursor_4c_Itens
                                ENDIF
                            ENDIF

                            *-- volta para o alias do SCAN (o SQLEXEC trocou a
                            *-- area de trabalho corrente)
                            SELECT cursor_4c_Itens
                        ENDSCAN
                        THIS.FecharCursor("cursor_4c_Prod")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    INDEX ON cItens    TAG cItens
                    INDEX ON Cpros     TAG Cpros
                    INDEX ON Categoria TAG Categoria
                    SET ORDER TO TAG cItens
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF

                THIS.ContarItensSelecionados()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar os itens do movimento:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarNiveis - le a hierarquia de localizacao e expande o XML
    *
    * Legado (Init): quatro Select * From SigLcNv1..4 para csNivel1..4,
    * quatro cursores "vazios com estrutura" crSigLcNv1..4 (com a coluna
    * extra Codigo) e tres chamadas ReverterXML.
    *
    * crSigLcNv1 nasce vazio e NUNCA eh populado - o nivel 1 nao tem pai, e
    * a busca da Base vai direto na tabela remota SigLcNv1. Fica criado por
    * fidelidade ao legado.
    *====================================================================
    PROCEDURE CarregarNiveis()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_nI, loc_nResultado
        LOCAL loc_cTabela, loc_cDestino

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            IF TYPE("gnConnHandle") != "N"
                loc_lProsseguir = .F.
            ELSE
                IF gnConnHandle <= 0
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF !loc_lProsseguir
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                                          CHR(227) + "o dispon" + CHR(237) + "vel."
            ENDIF

            IF loc_lProsseguir
                *-- SQLEXEC recebe o nome do cursor como STRING: nao precisa macro
                FOR loc_nI = 1 TO 4
                    loc_cTabela  = "SigLcNv" + TRANSFORM(loc_nI)
                    loc_cDestino = "cursor_4c_Nivel" + TRANSFORM(loc_nI)

                    THIS.FecharCursor(loc_cDestino)
                    loc_nResultado = SQLEXEC(gnConnHandle, "SELECT * FROM " + loc_cTabela, loc_cDestino)

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao ler " + loc_cTabela + ":" + CHR(13) + ;
                                                  CapturarErroSQL()
                        loc_lProsseguir = .F.
                        EXIT
                    ENDIF
                ENDFOR
            ENDIF

            IF loc_lProsseguir
                *-- Cursores expandidos: estrutura do nivel + a coluna Codigo.
                *-- SPACE(4) cobre o maior codigo da hierarquia (SigLcNv4.cods
                *-- eh char(4); os niveis 1 a 3 sao char(2)).
                THIS.FecharCursor("cursor_4c_LcNv1")
                THIS.FecharCursor("cursor_4c_LcNv2")
                THIS.FecharCursor("cursor_4c_LcNv3")
                THIS.FecharCursor("cursor_4c_LcNv4")

                SELECT *, SPACE(4) AS Codigo FROM cursor_4c_Nivel1 WHERE 1 = 0 ;
                    INTO CURSOR cursor_4c_LcNv1 READWRITE
                SELECT *, SPACE(4) AS Codigo FROM cursor_4c_Nivel2 WHERE 1 = 0 ;
                    INTO CURSOR cursor_4c_LcNv2 READWRITE
                SELECT *, SPACE(4) AS Codigo FROM cursor_4c_Nivel3 WHERE 1 = 0 ;
                    INTO CURSOR cursor_4c_LcNv3 READWRITE
                SELECT *, SPACE(4) AS Codigo FROM cursor_4c_Nivel4 WHERE 1 = 0 ;
                    INTO CURSOR cursor_4c_LcNv4 READWRITE

                *-- Cada nivel N guarda em <nivel> um XML com os codigos do
                *-- nivel N-1 que o habilitam
                THIS.ReverterXML("cursor_4c_Nivel2", "cursor_4c_Nivel1", "cursor_4c_LcNv2")
                THIS.ReverterXML("cursor_4c_Nivel3", "cursor_4c_Nivel2", "cursor_4c_LcNv3")
                THIS.ReverterXML("cursor_4c_Nivel4", "cursor_4c_Nivel3", "cursor_4c_LcNv4")

                loc_lSucesso = USED("cursor_4c_LcNv2") AND USED("cursor_4c_LcNv3") ;
                               AND USED("cursor_4c_LcNv4")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar os n" + CHR(237) + "veis de localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ReverterXML - expande o XML da coluna <nivel> em linhas
    *
    * Transcrito do PROCEDURE reverterxml legado. Para cada linha do nivel,
    * o XML de <nivel> eh carregado em cursor_4c_Aux e as entradas marcadas
    * (Marcas <> 0) viram linhas no cursor de destino, onde:
    *     Cods   = codigo do nivel ANTERIOR (o pai que habilita)
    *     Codigo = codigo do PROPRIO nivel
    *     Descs  = descricao do PROPRIO nivel
    *
    * par_cNivAnt existe so para reposicionar aquele cursor no fim, como no
    * legado.
    *====================================================================
    PROCEDURE ReverterXML(par_cCursor, par_cNivAnt, par_cCurDest)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_nOldSel, loc_cXML
        LOCAL loc_cCodAux, loc_cChaveAux

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_nOldSel     = SELECT()
        loc_cCodAux     = ""
        loc_cChaveAux   = ""

        TRY
            IF VARTYPE(par_cCursor) != "C" OR VARTYPE(par_cCurDest) != "C"
                loc_lProsseguir = .F.
            ELSE
                IF !USED(par_cCursor) OR !USED(par_cCurDest)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF !loc_lProsseguir
                THIS.this_cMensagemErro = "Cursores de n" + CHR(237) + "vel n" + CHR(227) + ;
                                          "o dispon" + CHR(237) + "veis para expandir o XML."
            ENDIF

            IF loc_lProsseguir
                THIS.FecharCursor("cursor_4c_Aux")

                SELECT cidchaves, Cods, Descs, 0 AS Marcas, SPACE(4) AS Codigo ;
                    FROM &par_cCursor. ;
                    WHERE 1 = 0 ;
                    INTO CURSOR cursor_4c_Aux READWRITE

                SELECT &par_cCursor.
                GO TOP

                SCAN
                    loc_cXML = NVL(&par_cCursor..Nivel, "")
                    ZAP IN cursor_4c_Aux

                    IF !EMPTY(loc_cXML)
                        *-- fXmlToCursor: wrapper em utils\fxmltocursor.prg
                        *-- (funcao global do legado Fortyus, regra #27)
                        = fXmlToCursor(loc_cXML, "cursor_4c_Aux", .F.)

                        IF USED("cursor_4c_Aux")
                            SELECT cursor_4c_Aux
                            *-- Legado: Scan For CrAux.Marcas <> 0
                            *-- O teste vai pelo MarcaComoNumero para nao
                            *-- estourar quando o XML nao trouxe schema e o
                            *-- Marcas chegou como Logico.
                            SCAN
                                IF THIS.MarcaComoNumero(cursor_4c_Aux.Marcas) <> 0
                                    loc_cCodAux   = THIS.ComoTexto(cursor_4c_Aux.Cods)
                                    loc_cChaveAux = THIS.ComoTexto(cursor_4c_Aux.CidChaves)

                                    SELECT &par_cCurDest.
                                    APPEND BLANK
                                    REPLACE Cods      WITH loc_cCodAux, ;
                                            Descs     WITH &par_cCursor..Descs, ;
                                            CidChaves WITH loc_cChaveAux, ;
                                            Codigo    WITH &par_cCursor..Cods

                                    SELECT cursor_4c_Aux
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDIF

                    *-- volta para o alias do SCAN externo
                    SELECT &par_cCursor.
                ENDSCAN

                IF VARTYPE(par_cNivAnt) = "C"
                    IF USED(par_cNivAnt)
                        SELECT &par_cNivAnt.
                        GO TOP
                    ENDIF
                ENDIF

                THIS.FecharCursor("cursor_4c_Aux")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao expandir a hierarquia de localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarNivelFiltrado - filhos de um nivel, para o lookup do form
    *
    * Legado (getNvl2/3/4.Valid):
    *   Select * From CrSigLcNvN Where Cods = lcNivel Into Cursor LocalNivel Readwrite
    *   Select LocalNivel / Index On Codigo Tag Codigo
    *
    * Deixa cursor_4c_LocalNivel aberto e indexado por Codigo - o form faz o
    * SEEK e, nao achando, abre o browse de selecao.
    *
    * MEDIDO no VFP9 (2026-11-08): com SET EXACT ON (que o config.prg liga),
    * "Cods = '01'" CASA coluna char(4) contendo "01  " - os brancos a
    * direita sao ignorados. Por isso o WHERE do legado pode ser transcrito
    * como esta, sem ALLTRIM na coluna (que estragaria o Rushmore).
    *====================================================================
    PROCEDURE CarregarNivelFiltrado(par_cCursorNivel, par_cCodigoPai)
        LOCAL loc_nQtd, loc_cFiltro, loc_lProsseguir

        loc_nQtd        = 0
        loc_lProsseguir = .T.

        TRY
            IF VARTYPE(par_cCursorNivel) != "C"
                loc_lProsseguir = .F.
            ELSE
                IF !USED(par_cCursorNivel)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cFiltro = IIF(VARTYPE(par_cCodigoPai) = "C", ALLTRIM(par_cCodigoPai), "")

                THIS.FecharCursor("cursor_4c_LocalNivel")

                SELECT * FROM &par_cCursorNivel. ;
                    WHERE Cods = m.loc_cFiltro ;
                    INTO CURSOR cursor_4c_LocalNivel READWRITE

                IF USED("cursor_4c_LocalNivel")
                    SELECT cursor_4c_LocalNivel
                    INDEX ON Codigo TAG Codigo
                    GO TOP
                    loc_nQtd = RECCOUNT("cursor_4c_LocalNivel")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao filtrar o n" + CHR(237) + "vel de localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_nQtd = 0
        ENDTRY

        RETURN loc_nQtd
    ENDPROC

    *====================================================================
    * ValidarNiveis - transcricao do PROCEDURE validacao legado
    *
    * O legado exige o nivel seguinte SOMENTE quando aquele nivel tem
    * filhos para o pai escolhido - e a condicao que CERCA cada checagem
    * faz parte da regra (regra #21b), por isso vai transcrita inteira:
    *   nivel 2: Reccount(crSigLcNv2) > 0 e Nvl2 vazio
    *   nivel 3: Reccount(crSigLcNv3) > 0 e Nvl3 vazio e Nvl2 PREENCHIDO
    *   nivel 4: Reccount(crSigLcNv4) > 0 e Nvl4 vazio e Nvl3 PREENCHIDO
    *
    * par_lExibirMensagem = .T. (default) reproduz o MessageBox do legado;
    * .F. so preenche this_cMensagemErro, para o caminho do Salvar da
    * BusinessBase exibir uma unica vez (regra #20).
    *====================================================================
    PROCEDURE ValidarNiveis(par_lExibirMensagem)
        LOCAL loc_lValido, loc_lExibir, loc_nOldSel, loc_cMsg

        loc_lValido = .T.
        loc_cMsg    = ""
        loc_nOldSel = SELECT()
        loc_lExibir = IIF(PCOUNT() >= 1 AND VARTYPE(par_lExibirMensagem) = "L", ;
                          par_lExibirMensagem, .T.)

        *-- Base eh sempre obrigatoria
        IF EMPTY(ALLTRIM(NVL(THIS.this_cBase, "")))
            loc_cMsg    = "Informar a Base da Localiza" + CHR(231) + CHR(227) + "o."
            loc_lValido = .F.
        ENDIF

        *-- Segundo nivel
        IF loc_lValido AND USED("cursor_4c_LcNv2") ;
                AND EMPTY(ALLTRIM(NVL(THIS.this_cNvl2, "")))
            IF RECCOUNT("cursor_4c_LcNv2") > 0
                IF THIS.CarregarNivelFiltrado("cursor_4c_LcNv2", ALLTRIM(NVL(THIS.this_cBase, ""))) > 0
                    loc_cMsg    = "Informar o Segundo N" + CHR(237) + "vel da Localiza" + ;
                                  CHR(231) + CHR(227) + "o."
                    loc_lValido = .F.
                ENDIF
            ENDIF
        ENDIF

        *-- Terceiro nivel (so cobrado quando o segundo foi informado)
        IF loc_lValido AND USED("cursor_4c_LcNv3") ;
                AND EMPTY(ALLTRIM(NVL(THIS.this_cNvl3, ""))) ;
                AND !EMPTY(ALLTRIM(NVL(THIS.this_cNvl2, "")))
            IF RECCOUNT("cursor_4c_LcNv3") > 0
                IF THIS.CarregarNivelFiltrado("cursor_4c_LcNv3", ALLTRIM(NVL(THIS.this_cNvl2, ""))) > 0
                    loc_cMsg    = "Informar o Terceiro N" + CHR(237) + "vel da Localiza" + ;
                                  CHR(231) + CHR(227) + "o."
                    loc_lValido = .F.
                ENDIF
            ENDIF
        ENDIF

        *-- Quarto nivel (so cobrado quando o terceiro foi informado)
        IF loc_lValido AND USED("cursor_4c_LcNv4") ;
                AND EMPTY(ALLTRIM(NVL(THIS.this_cNvl4, ""))) ;
                AND !EMPTY(ALLTRIM(NVL(THIS.this_cNvl3, "")))
            IF RECCOUNT("cursor_4c_LcNv4") > 0
                IF THIS.CarregarNivelFiltrado("cursor_4c_LcNv4", ALLTRIM(NVL(THIS.this_cNvl3, ""))) > 0
                    loc_cMsg    = "Informar o Quarto N" + CHR(237) + "vel da Localiza" + ;
                                  CHR(231) + CHR(227) + "o."
                    loc_lValido = .F.
                ENDIF
            ENDIF
        ENDIF

        THIS.this_cMensagemErro = loc_cMsg

        IF !loc_lValido AND loc_lExibir
            MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * MontarLocalizacao - concatena os quatro niveis
    *
    * Legado (btnLocalizar.Click):
    *   lcLocaliza = Alltrim(lcLoc1)+Alltrim(lcLoc2)+Alltrim(lcLoc3)+Alltrim(lcLoc4)
    *
    * TRANSCRITO LITERALMENTE (regra #17): o ALLTRIM em cada parte eh do
    * legado. As larguras somam exatamente os 10 chars do destino
    * (2+2+2+4 = SigMvItn.locals char(10)) quando todos os codigos vem do
    * lookup, que eh como a tela os preenche.
    *====================================================================
    PROCEDURE MontarLocalizacao()
        THIS.this_cLocalizacaoMontada = ALLTRIM(NVL(THIS.this_cBase, "")) + ;
                                        ALLTRIM(NVL(THIS.this_cNvl2, "")) + ;
                                        ALLTRIM(NVL(THIS.this_cNvl3, "")) + ;
                                        ALLTRIM(NVL(THIS.this_cNvl4, ""))
        RETURN THIS.this_cLocalizacaoMontada
    ENDPROC

    *====================================================================
    * ContarItensSelecionados - quantos itens estao marcados
    *
    * COUNT move o ponteiro, por isso o RECNO eh reposto no fim: a grade
    * chama isto no AfterRowColChange e perder a linha corrente faria o
    * cursor "pular" sozinho.
    *====================================================================
    PROCEDURE ContarItensSelecionados()
        LOCAL loc_nQtd, loc_nRec, loc_nOldSel

        loc_nQtd    = 0
        loc_nOldSel = SELECT()

        IF USED("cursor_4c_Itens")
            loc_nRec = RECNO("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            COUNT FOR Marcas <> 0 TO loc_nQtd
            IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Itens")
                GO loc_nRec IN cursor_4c_Itens
            ENDIF
        ENDIF

        THIS.this_lTemItensSelecionados = (loc_nQtd > 0)

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_nQtd
    ENDPROC

    *====================================================================
    * MarcarTodosItens - SelTudo.Click (1) e apaga.Click (0) do legado
    *   Replace All crItensLoc.Marcas with <0|1> / Go Top
    *====================================================================
    PROCEDURE MarcarTodosItens(par_nValor)
        LOCAL loc_nMarca, loc_lSucesso, loc_nOldSel

        loc_lSucesso = .F.
        loc_nOldSel  = SELECT()
        loc_nMarca   = 0

        IF PCOUNT() >= 1 AND VARTYPE(par_nValor) = "N"
            loc_nMarca = IIF(par_nValor <> 0, 1, 0)
        ENDIF

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            REPLACE ALL Marcas WITH loc_nMarca
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        THIS.ContarItensSelecionados()

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AlternarMarcaItem - toggle do Check1 da coluna 3
    *   Replace crItensLoc.Marcas With IIf(crItensLoc.Marcas == 0,1,0)
    *====================================================================
    PROCEDURE AlternarMarcaItem()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Itens")
            IF !EOF("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
                REPLACE Marcas WITH IIF(cursor_4c_Itens.Marcas = 0, 1, 0) IN cursor_4c_Itens
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        THIS.ContarItensSelecionados()

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * OrdenarItens - OptOrdem.Valid do legado
    *   Value = 1 -> Index on Cpros ; senao -> Index on Categoria
    *
    * Os tags ja existem (criados em CarregarItens), entao aqui basta
    * trocar a ordem corrente - mais barato que reindexar e com o mesmo
    * efeito visual.
    *====================================================================
    PROCEDURE OrdenarItens(par_nOpcao)
        LOCAL loc_lSucesso, loc_nOldSel
        loc_lSucesso = .F.
        loc_nOldSel  = SELECT()

        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            IF VARTYPE(par_nOpcao) = "N" AND par_nOpcao = 1
                SET ORDER TO TAG Cpros
            ELSE
                SET ORDER TO TAG Categoria
            ENDIF
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarFotoProduto - grava a foto do produto num arquivo temporario
    *
    * Legado (grdItens.AfterRowColChange): le SigCdPro.FigJpgs, remove os
    * prefixos data-URI, decodifica base64 UMA vez (STRCONV ..., 14) e
    * grava em Sys(2023). Decodificar duas vezes corrompe a imagem.
    *
    * Devolve o caminho do arquivo, ou "" quando nao ha foto - o form usa o
    * retorno vazio para esconder a Image.
    *
    * DESVIO DELIBERADO no CATCH: aqui NAO entra MsgErro. Este metodo roda
    * a cada troca de linha da grade; um modal por linha com foto corrompida
    * deixaria a tela inutilizavel. O erro fica registrado em
    * this_cMensagemErro (com LineNo/Procedure), portanto diagnosticavel -
    * eh o que a regra #9 quer evitar, CATCH que engole sem deixar rastro.
    *====================================================================
    PROCEDURE BuscarFotoProduto(par_cCpros)
        LOCAL loc_cArquivo, loc_cSQL, loc_nResultado, loc_cBase64, loc_cBinario
        LOCAL loc_lProsseguir

        loc_cArquivo    = ""
        loc_lProsseguir = .T.

        TRY
            IF VARTYPE(par_cCpros) != "C"
                loc_lProsseguir = .F.
            ELSE
                IF EMPTY(ALLTRIM(par_cCpros))
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND TYPE("gnConnHandle") = "N"
                IF gnConnHandle <= 0
                    loc_lProsseguir = .F.
                ENDIF
            ELSE
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                THIS.FecharCursor("cursor_4c_Foto")

                loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + ;
                           EscaparSQL(ALLTRIM(par_cCpros))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Foto")

                IF loc_nResultado > 0 AND USED("cursor_4c_Foto")
                    IF RECCOUNT("cursor_4c_Foto") > 0
                        SELECT cursor_4c_Foto
                        GO TOP
                        loc_cBase64 = TratarNulo(cursor_4c_Foto.FigJpgs, "")

                        IF !EMPTY(loc_cBase64)
                            loc_cBase64 = STRTRAN(loc_cBase64, "data:image/png;base64,",  "")
                            loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpeg;base64,", "")
                            loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpg;base64,",  "")

                            *-- UMA conversao base64 -> binario
                            loc_cBinario = STRCONV(loc_cBase64, 14)
                            loc_cArquivo = ADDBS(SYS(2023)) + THIS.ObterPrefixoTemp() + ;
                                           SYS(2015) + ".jpg"

                            CLEAR RESOURCES
                            STRTOFILE(loc_cBinario, loc_cArquivo)

                            IF !FILE(loc_cArquivo)
                                loc_cArquivo = ""
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                THIS.FecharCursor("cursor_4c_Foto")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar a foto do produto: " + ;
                                      loc_oErro.Message + ;
                                      " (Linha " + TRANSFORM(loc_oErro.LineNo) + ;
                                      ", Procedure " + loc_oErro.Procedure + ")"
            loc_cArquivo = ""
        ENDTRY

        RETURN loc_cArquivo
    ENDPROC

    *====================================================================
    * LimparNiveis - zera os quatro niveis e suas descricoes
    *
    * Legado: btnLimpar.Click e o final do btnLocalizar.Click limpam os
    * oito campos da esquerda para a direita.
    *====================================================================
    PROCEDURE LimparNiveis()
        THIS.this_cBase     = ""
        THIS.this_cDescBase = ""
        THIS.this_cNvl2     = ""
        THIS.this_cDescNvl2 = ""
        THIS.this_cNvl3     = ""
        THIS.this_cDescNvl3 = ""
        THIS.this_cNvl4     = ""
        THIS.this_cDescNvl4 = ""
        THIS.this_cLocalizacaoMontada = ""
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - carrega a linha corrente do cursor de itens
    *
    * Mapeia TODAS as colunas da grade (Marcas, Cpros, Dpros, cItens,
    * Locals, Categoria). Cada coluna eh testada com TYPE() antes de ser
    * lida, para que o metodo tambem sirva para crTpmMvItn, que nao tem
    * Marcas nem Categoria (PEMSTATUS nao funciona sobre alias de cursor -
    * exige objeto).
    *
    * Sem parametro, usa cursor_4c_Itens.
    *====================================================================
    PROCEDURE CarregarDoCursor(pcCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_nOldSel, loc_cColLocal

        loc_lSucesso = .F.
        loc_nOldSel  = SELECT()
        loc_cAlias   = "cursor_4c_Itens"

        IF PCOUNT() >= 1 AND VARTYPE(pcCursor) = "C"
            IF !EMPTY(ALLTRIM(pcCursor))
                loc_cAlias = ALLTRIM(pcCursor)
            ENDIF
        ENDIF

        IF USED(loc_cAlias)
            IF RECCOUNT(loc_cAlias) > 0 AND !EOF(loc_cAlias)
                SELECT (loc_cAlias)

                IF TYPE(loc_cAlias + ".Marcas") != "U"
                    THIS.this_nMarcas = TratarNulo(EVALUATE(loc_cAlias + ".Marcas"), 0)
                ENDIF

                IF TYPE(loc_cAlias + ".Cpros") != "U"
                    THIS.this_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Cpros"), ""))
                ENDIF

                IF TYPE(loc_cAlias + ".Dpros") != "U"
                    THIS.this_cDpros = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Dpros"), ""))
                ENDIF

                IF TYPE(loc_cAlias + ".cItens") != "U"
                    THIS.this_nCItens = TratarNulo(EVALUATE(loc_cAlias + ".cItens"), 0)
                ENDIF

                IF TYPE(loc_cAlias + ".Categoria") != "U"
                    THIS.this_cCategoria = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Categoria"), ""))
                ENDIF

                *-- Em crTpmMvItn a localizacao do item mora em Localos quando
                *-- a tela foi aberta com pcOrigem = 'ORIGEM' (igual ao IIF do
                *-- Init legado); cursor_4c_Itens ja traz a coluna resolvida
                *-- como Locals.
                loc_cColLocal = "Locals"
                IF ALLTRIM(UPPER(NVL(THIS.this_cOrigem, ""))) == "ORIGEM"
                    IF TYPE(loc_cAlias + ".Localos") != "U"
                        loc_cColLocal = "Localos"
                    ENDIF
                ENDIF

                IF TYPE(loc_cAlias + "." + loc_cColLocal) != "U"
                    THIS.this_cLocalItem = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + "." + loc_cColLocal), ""))
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - chamado por BusinessBase.Salvar
    *
    * Preenche this_cMensagemErro e NAO exibe nada: quem exibe eh o
    * ExibirFalha do Salvar (regra #20), senao a mensagem sai duas vezes.
    *====================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        THIS.this_cMensagemErro = ""

        *-- .F. = nao exibir aqui
        loc_lValido = THIS.ValidarNiveis(.F.)

        IF loc_lValido
            IF THIS.ContarItensSelecionados() = 0
                THIS.this_cMensagemErro = "Selecione ao menos um item da grade antes de " + ;
                                          "atribuir a localiza" + CHR(231) + CHR(227) + "o."
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - grava a localizacao dos itens marcados
    *
    * Transcricao do btnLocalizar.Click legado, que eh onde esta tela
    * "grava": para cada item marcado em crItensLoc acrescenta uma linha em
    * csLocals (item, produto, localizacao montada) e remove o item da
    * grade. A escrita eh em CURSOR - esta tela NAO tem INSERT/UPDATE em
    * tabela do SQL Server em lugar nenhum do legado, e inventar um
    * violaria a regra #22 (a lista de colunas vem do schema, nunca de
    * adivinhacao).
    *
    * O guard de modo eh o When dos botoes do legado:
    *   Return (InList(ThisForm.pcEscolha,[INSERIR],[ALTERAR]))
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_nOldSel, loc_nQtd

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_nOldSel     = SELECT()
        THIS.this_nItensGravados = 0

        *-- Mesmo reset que BusinessBase.Salvar() faz na entrada: sem ele um
        *-- this_lErroExibido = .T. de uma falha ANTERIOR faria o form calar a
        *-- mensagem desta chamada (o guard do chamador eh justamente essa flag)
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF !INLIST(ALLTRIM(UPPER(NVL(THIS.this_cEscolha, ""))), "INSERIR", "ALTERAR")
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                          "o permitida no modo atual."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !USED("cursor_4c_Itens") OR !USED("cursor_4c_Locais")
                    THIS.this_cMensagemErro = "Cursores de trabalho n" + CHR(227) + "o est" + ;
                                              CHR(227) + "o abertos."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nQtd = THIS.ContarItensSelecionados()
                IF loc_nQtd = 0
                    THIS.this_cMensagemErro = "Selecione ao menos um item da grade antes de " + ;
                                              "atribuir a localiza" + CHR(231) + CHR(227) + "o."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.MontarLocalizacao()

                *-- Legado: Scan For Marcas <> 0 / Select csLocals / Append Blank
                SELECT cursor_4c_Itens
                GO TOP
                SCAN FOR Marcas <> 0
                    SELECT cursor_4c_Locais
                    APPEND BLANK
                    REPLACE cItens WITH cursor_4c_Itens.cItens, ;
                            Cpros  WITH cursor_4c_Itens.Cpros, ;
                            Locals WITH THIS.this_cLocalizacaoMontada

                    THIS.this_nItensGravados = THIS.this_nItensGravados + 1

                    *-- volta para o alias do SCAN
                    SELECT cursor_4c_Itens
                ENDSCAN

                *-- Legado: Delete From crItensLoc Where Marcas <> 0
                *-- (SET DELETED ON esconde as linhas da grade)
                DELETE FROM cursor_4c_Itens WHERE Marcas <> 0

                SELECT cursor_4c_Itens
                GO TOP

                loc_lSucesso = (THIS.this_nItensGravados > 0)

                IF loc_lSucesso
                    *-- auditoria ANTES de limpar os niveis: ObterChavePrimaria
                    *-- usa a localizacao montada
                    THIS.RegistrarAuditoria("INSERT")

                    *-- Legado limpa os oito campos no fim do btnLocalizar.Click
                    THIS.LimparNiveis()
                    THIS.ContarItensSelecionados()
                ELSE
                    THIS.this_cMensagemErro = "Nenhum item foi localizado."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            *-- A subclasse exibe o proprio erro e deixa this_cMensagemErro
            *-- VAZIA, senao o Salvar da base exibiria de novo (regra #20)
            MsgErro("Erro ao gravar a localiza" + CHR(231) + CHR(227) + "o dos itens:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            THIS.this_cMensagemErro = ""
            THIS.this_lErroExibido  = .T.
            loc_lSucesso = .F.
        ENDTRY

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - propaga as localizacoes para o cursor do form chamador
    *
    * Transcricao do btnConfirmar.Click legado:
    *   Select csLocals / Scan
    *       If pcOrigem = 'ORIGEM'
    *           Update crTpmMvItn set Localos = csLocals.Locals where cItens = csLocals.cItens
    *       Else
    *           Update crTpmMvItn set Locals  = csLocals.Locals where cItens = csLocals.cItens
    *   EndScan / Select crTpmMvItn / Go top
    *
    * this_nItensConfirmados conta as linhas REALMENTE afetadas (_TALLY), e
    * nao as iteracoes: o form tem de consultar esse contador antes de dizer
    * "gravado com sucesso" - csLocals vazio significa fechar sem mudanca,
    * que o legado permite.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_nOldSel, loc_cColDestino
        LOCAL loc_nItem, loc_cLocal

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_nOldSel     = SELECT()
        THIS.this_nItensConfirmados = 0

        *-- Mesmo reset que BusinessBase.Salvar() faz na entrada (ver Inserir)
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF !USED("crTpmMvItn")
                THIS.this_cMensagemErro = "O cursor de itens do movimento (crTpmMvItn) n" + ;
                                          CHR(227) + "o est" + CHR(225) + " aberto."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !USED("cursor_4c_Locais")
                    THIS.this_cMensagemErro = "O cursor de localiza" + CHR(231) + CHR(245) + ;
                                              "es n" + CHR(227) + "o est" + CHR(225) + " aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Coluna de destino conforme pcOrigem, igual ao legado
                loc_cColDestino = IIF(ALLTRIM(UPPER(NVL(THIS.this_cOrigem, ""))) == "ORIGEM", ;
                                      "Localos", "Locals")

                SELECT cursor_4c_Locais
                GO TOP
                SCAN
                    loc_nItem  = cursor_4c_Locais.cItens
                    loc_cLocal = cursor_4c_Locais.Locals

                    UPDATE crTpmMvItn ;
                        SET &loc_cColDestino. = m.loc_cLocal ;
                        WHERE cItens = m.loc_nItem

                    IF _TALLY > 0
                        THIS.this_nItensConfirmados = THIS.this_nItensConfirmados + _TALLY
                    ENDIF

                    *-- volta para o alias do SCAN
                    SELECT cursor_4c_Locais
                ENDSCAN

                SELECT crTpmMvItn
                GO TOP

                loc_lSucesso = .T.

                IF THIS.this_nItensConfirmados > 0
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao confirmar a localiza" + CHR(231) + CHR(227) + "o dos itens:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            THIS.this_cMensagemErro = ""
            THIS.this_lErroExibido  = .T.
            loc_lSucesso = .F.
        ENDTRY

        IF loc_nOldSel > 0
            SELECT (loc_nOldSel)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - identificacao do registro para a auditoria
    *
    * Esta tela nao grava em tabela: a "chave" util no LogAuditoria eh o
    * que identifica a atribuicao feita - item, localizacao montada e
    * origem. LogAuditoria.ChaveRegistro eh varchar(100), por isso o LEFT.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ALLTRIM(NVL(THIS.this_cLocalizacaoMontada, ""))

        IF THIS.this_nCItens > 0
            loc_cChave = ALLTRIM(TRANSFORM(THIS.this_nCItens)) + "/" + loc_cChave
        ENDIF

        IF !EMPTY(ALLTRIM(NVL(THIS.this_cOrigem, "")))
            loc_cChave = loc_cChave + "/" + ALLTRIM(THIS.this_cOrigem)
        ENDIF

        RETURN LEFT(loc_cChave, 100)
    ENDPROC

    *====================================================================
    * LimparDados - zera o estado da tela
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.LimparNiveis()

        THIS.this_nCItens    = 0
        THIS.this_cCpros     = ""
        THIS.this_cDpros     = ""
        THIS.this_cLocalItem = ""
        THIS.this_cCategoria = ""
        THIS.this_nMarcas    = 0

        THIS.this_lTemItensSelecionados = .F.
        THIS.this_nItensGravados        = 0
        THIS.this_nItensConfirmados     = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * Destroy - fecha os cursores de trabalho
    *
    * Legado (Release): Use In crItensLoc / Use In csLocals. crTpmMvItn NAO
    * eh fechado aqui - pertence ao form chamador.
    *====================================================================
    PROCEDURE Destroy()
        THIS.FecharCursor("cursor_4c_Itens")
        THIS.FecharCursor("cursor_4c_Locais")
        THIS.FecharCursor("cursor_4c_Aux")
        THIS.FecharCursor("cursor_4c_LocalNivel")
        THIS.FecharCursor("cursor_4c_Prod")
        THIS.FecharCursor("cursor_4c_Foto")
        THIS.FecharCursor("cursor_4c_Nivel1")
        THIS.FecharCursor("cursor_4c_Nivel2")
        THIS.FecharCursor("cursor_4c_Nivel3")
        THIS.FecharCursor("cursor_4c_Nivel4")
        THIS.FecharCursor("cursor_4c_LcNv1")
        THIS.FecharCursor("cursor_4c_LcNv2")
        THIS.FecharCursor("cursor_4c_LcNv3")
        THIS.FecharCursor("cursor_4c_LcNv4")

        DODEFAULT()
    ENDPROC

ENDDEFINE
