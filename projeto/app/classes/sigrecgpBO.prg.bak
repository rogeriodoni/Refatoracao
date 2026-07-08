*==============================================================================
* SIGRECGPBO.PRG
* BO do Relatorio de Composicao de Produtos (SIGRECGP)
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrecgpBO AS RelatorioBase

    *-- Opcoes selecionadas pelo usuario no form
    this_nOpcRel      = 1    && 1=Comp, 2=Custo/Venda, 3=CompEsp1, 4=CompEsp2, 5=Custo/Venda2
    this_nOpcOrdem    = 1    && 1=Produto, 2=Ref.Fornecedor
    this_nVal         = 0    && Derivado: INLIST(tipo,2) -> 1, else 0

    *-- Referencia ao form pai e filtros
    this_oParentForm  = .NULL.
    this_cEmpEDN      = ""   && Chave empresa+operacao+operacaoid (tipo 5)

    *--------------------------------------------------------------------------
    * Init - Configura identificadores base
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Sem chave para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursor Relatorio com dados de composicao
    * Equivalente ao metodo processamento do legado
    * REQUER que CrProdutos esteja populado pelo form chamador
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nOrdem, loc_nTpRel, loc_lOK
        LOCAL loc_cEmpresa, loc_cTitulo, loc_nResult, loc_cSQL
        LOCAL loc_cGrupo, loc_cProdt, loc_nCnt
        LOCAL loc_cCodPro, loc_lFoundMov, loc_cFotoRel
        LOCAL loc_cFotoBranco, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_nOrdem = THIS.this_nOpcOrdem
            loc_nTpRel = THIS.this_nOpcRel

            THIS.this_nVal = IIF(INLIST(loc_nTpRel, 2) = .T., 1, 0)

            *-- Tipos 3 e 4: processamento especial de composicao especifica
            IF INLIST(loc_nTpRel, 3, 4)
                loc_lSucesso = THIS.PrepararDadosCompEsp1()
            ELSE
                *-- Tipos 1, 2, 5: processamento padrao

                *-- Obter nome da empresa para cabecalho
                loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpHdr")

                IF loc_nResult > 0
                    SELECT cursor_4c_EmpHdr
                    GO TOP
                    loc_cEmpresa = go_4c_Sistema.cCodEmpresa + " - " + ;
                                   IIF(!EMPTY(cursor_4c_EmpHdr.Razas), ;
                                       ALLTRIM(cursor_4c_EmpHdr.Razas), "")
                    USE IN cursor_4c_EmpHdr
                ELSE
                    loc_cEmpresa = go_4c_Sistema.cCodEmpresa
                ENDIF

                loc_cTitulo = "RELAT" + CHR(211) + "RIO DE COMPOSI" + ;
                              CHR(199) + CHR(195) + "O DE PRODUTOS"

                *-- Cursor de cabecalho para o relatorio
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF
                CREATE CURSOR csCabecalho (NomeEmpresa c(80), Titulo c(200), ImpImagem l(1))
                INSERT INTO csCabecalho (NomeEmpresa, Titulo, ImpImagem) ;
                    VALUES (loc_cEmpresa, loc_cTitulo, .T.)

                *-- Imagem em branco para produtos sem foto
                IF USED("CrBranco")
                    USE IN CrBranco
                ENDIF
                CREATE CURSOR CrBranco (Branco M)
                SELECT CrBranco
                APPEND BLANK

                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 carqicones, marqicones FROM SigSyIco", ;
                    "cursor_4c_BrJpg")

                IF loc_nResult > 0
                    SELECT cursor_4c_BrJpg
                    GO TOP
                    IF !EOF() AND !EMPTY(cursor_4c_BrJpg.marqicones)
                        SELECT CrBranco
                        REPLACE Branco WITH cursor_4c_BrJpg.marqicones IN CrBranco
                    ENDIF
                    USE IN cursor_4c_BrJpg
                ENDIF

                IF !EMPTY(CrBranco.Branco)
                    loc_cFotoBranco = STRCONV(STRTRAN(STRTRAN(STRTRAN(CrBranco.Branco, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFotoBranco, SYS(2023) + "\FBRANCOS.JPG")
                ENDIF

                *-- Cursores temporarios de dados
                IF USED("Tmp_Memos")
                    USE IN Tmp_Memos
                ENDIF
                CREATE CURSOR Tmp_Memos (Cids c(1), Imagem m, ValTot m, MoeTot m)

                IF USED("Tmp_Compos")
                    USE IN Tmp_Compos
                ENDIF

                *-- Popula Tmp_Compos conforme tipo de relatorio
                loc_lOK = .T.

                IF INLIST(loc_nTpRel, 5)
                    *-- Tipo 5: dados de composicao filtrados pela operacao
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros,a.mats,a.dcompos,a.cats," + ;
                        "a.qtscons*b.qtds as qtscons,a.unicompos," + ;
                        "a.moeds,a.cgrus,a.obscompos,a.etiqs," + ;
                        "a.vlrcvs,a.qtdcvs*b.qtds as qtdcvs," + ;
                        "a.qtds,a.pcompos,b.totas,b.moedas " + ;
                        "FROM SigPrCpo a, SigMvItN b " + ;
                        "WHERE b.cpros = a.cpros" + ;
                        " AND empdopnums = " + EscaparSQL(THIS.this_cEmpEDN), ;
                        "TmpAux")

                    IF loc_nResult > 0
                        *-- Acumula por material
                        SELECT cpros, mats, MAX(dcompos) as dcompos, ;
                               MAX(cats) as cats, ;
                               SUM(ROUND(qtscons,3)) as qtscons, ;
                               MAX(unicompos) as unicompos, ;
                               MAX(moeds) as moeds, ;
                               MAX(cgrus) as cgrus, ;
                               MAX(obscompos) as obscompos, ;
                               MAX(etiqs) as etiqs, ;
                               SUM(vlrcvs) as vlrcvs, ;
                               SUM(ROUND(qtdcvs,3)) as qtdcvs, ;
                               SUM(qtds) as qtds, ;
                               SUM(pcompos) as pcompos, ;
                               00000000.00 as valtotmoe, ;
                               0 as ps ;
                            FROM TmpAux GROUP BY cpros, mats ;
                            INTO CURSOR AuxCompos READWRITE

                        *-- Totais de consumo por produto
                        SELECT cpros, 'xxxxxxxxxxxxxx' as mats, ;
                               SUM(qtscons) as qtscons ;
                            FROM AuxCompos GROUP BY cpros ;
                            INTO CURSOR AuxCons

                        *-- Totais de qtdcvs por unidade/produto
                        SELECT cpros, 'xxxxxxxxxxxxxx' as mats, ;
                               unicompos, SUM(qtdcvs) as qtdcvs ;
                            FROM AuxCompos GROUP BY cpros, unicompos ;
                            INTO CURSOR AuxMat

                        *-- Totais de valor por moeda/produto
                        SELECT cpros, 'xxxxxxxxxxxxxx' as mats, ;
                               moeds, SUM(vlrcvs*qtdcvs) as valtotmoe ;
                            FROM AuxCompos GROUP BY cpros, moeds ;
                            INTO CURSOR AuxMoe

                        *-- Totais gerais por material
                        SELECT mats, dcompos, unicompos, ;
                               MAX(moeds) as moeds, ;
                               SUM(qtscons) as qtscons, ;
                               SUM(qtdcvs) as qtdcvs, ;
                               SUM(vlrcvs*qtdcvs) as valtotmoe ;
                            FROM AuxCompos GROUP BY mats, dcompos, unicompos ;
                            INTO CURSOR AuxG

                        *-- Consolida qtscons no AuxCompos
                        SELECT AuxCons
                        GO TOP
                        SCAN
                            SELECT AuxCompos
                            LOCATE FOR cpros = AuxCons.cpros AND ;
                                        mats = 'xxxxxxxxxxxxxx' AND qtscons = 0
                            IF !FOUND()
                                APPEND BLANK
                                REPLACE ps WITH 1
                            ENDIF
                            REPLACE mats WITH 'xxxxxxxxxxxxxx', ;
                                    cgrus WITH 'xxx', ;
                                    cpros WITH AuxCons.cpros, ;
                                    qtscons WITH AuxCons.qtscons
                            SELECT AuxCons
                        ENDSCAN

                        *-- Consolida qtdcvs no AuxCompos
                        SELECT AuxMat
                        GO TOP
                        SCAN
                            SELECT AuxCompos
                            LOCATE FOR cpros = AuxMat.cpros AND ;
                                        mats = 'xxxxxxxxxxxxxx' AND ;
                                        unicompos = '   '
                            IF !FOUND()
                                APPEND BLANK
                            ENDIF
                            REPLACE mats WITH 'xxxxxxxxxxxxxx', ;
                                    cgrus WITH 'xxx', ;
                                    cpros WITH AuxMat.cpros, ;
                                    unicompos WITH AuxMat.unicompos, ;
                                    qtdcvs WITH AuxMat.qtdcvs
                            SELECT AuxMat
                        ENDSCAN

                        *-- Consolida valtotmoe no AuxCompos
                        SELECT AuxMoe
                        GO TOP
                        SCAN
                            SELECT AuxCompos
                            LOCATE FOR cpros = AuxMoe.cpros AND ;
                                        mats = 'xxxxxxxxxxxxxx' AND ;
                                        moeds = '   '
                            IF !FOUND()
                                APPEND BLANK
                            ENDIF
                            REPLACE mats WITH 'xxxxxxxxxxxxxx', ;
                                    cgrus WITH 'xxx', ;
                                    cpros WITH AuxMoe.cpros, ;
                                    moeds WITH AuxMoe.moeds, ;
                                    valtotmoe WITH AuxMoe.valtotmoe
                            SELECT AuxMoe
                        ENDSCAN

                        SELECT * FROM AuxCompos ORDER BY cpros, mats ;
                            INTO CURSOR Tmp_Compos READWRITE

                        SELECT cpros, MAX(totas) as totas, MAX(moedas) as moedas ;
                            FROM TmpAux GROUP BY cpros ;
                            INTO CURSOR TmpMov READWRITE

                        *-- Totais por material (variavel publica lida pelo relatorio)
                        PUBLIC pcTotais
                        pcTotais = "TOTAIS POR MATERIAL" + CHR(10)
                        pcTotais = pcTotais + ;
                            "Material      Descricao                       " + ;
                            "           Consumo      Qtde Un      Total" + CHR(10)
                        pcTotais = pcTotais + ;
                            "________________________________________________" + ;
                            "_________________________________________" + CHR(10)
                        SELECT AuxG
                        GO TOP
                        SCAN
                            pcTotais = pcTotais + AuxG.mats + dcompos + ;
                                       TRANSFORM(qtscons, "@R 999999.999") + ;
                                       TRANSFORM(qtdcvs, "@R 999999.999") + ;
                                       " " + unicompos + ;
                                       TRANSFORM(valtotmoe, "@R 9999999.99") + ;
                                       " " + moeds + CHR(10)
                        ENDSCAN
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao buscar dados da opera" + ;
                            CHR(231) + CHR(227) + "o"
                        loc_lOK = .F.
                    ENDIF
                ELSE
                    *-- Tipos 1 e 2: todos os dados de composicao
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros,a.mats,a.dcompos,a.cats," + ;
                        "a.qtscons,a.unicompos,a.moeds,a.cgrus," + ;
                        "a.obscompos,a.etiqs,a.vlrcvs,a.qtdcvs," + ;
                        "a.qtds,a.pcompos," + ;
                        "CAST(0 AS NUMERIC(8,2)) as valtotmoe," + ;
                        "0 as ps " + ;
                        "FROM SigPrCpo a", ;
                        "Tmp_Compos")

                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao buscar composicao dos produtos"
                        loc_lOK = .F.
                    ENDIF
                ENDIF

                IF loc_lOK
                    *-- CsRels: join CrProdutos x Tmp_Compos
                    SELECT a.cpros      AS Codigo, ;
                           a.dpros      AS Descricao, ;
                           SPACE(10)    AS Linha, ;
                           SPACE(3)     AS Unidade, ;
                           000000.00    AS Peso, ;
                           00000000.00  AS PreCusto, ;
                           SPACE(3)     AS MoeCusto, ;
                           00000000.00  AS PreVenda, ;
                           SPACE(3)     AS MoeVenda, ;
                           000000000.00 AS PreIdeal, ;
                           SPACE(3)     AS MoeIdeal, ;
                           c.mats       AS CodMateria, ;
                           c.dcompos    AS DesMateria, ;
                           c.cats       AS Categoria, ;
                           c.qtscons    AS Consumo, ;
                           IIF(loc_nTpRel = 1, c.qtds, c.qtdcvs) AS Quantidade, ;
                           c.unicompos  AS UniMateria, ;
                           IIF(loc_nTpRel = 1, c.pcompos, c.vlrcvs) AS ValMateria, ;
                           c.moeds      AS MoeMateria, ;
                           c.cpros + c.cgrus AS Grupos, ;
                           999999       AS Quadro, ;
                           SPACE(8)     AS OrdImg, ;
                           SPACE(15)    AS RefFor, ;
                           c.obscompos  AS Observa, ;
                           SPACE(6)     AS SubGrupo, ;
                           c.etiqs      AS Imprime, ;
                           c.cgrus      AS GruProd, ;
                           SPACE(20)    AS DesGrupo, ;
                           c.valtotmoe  AS valtotmoe, ;
                           c.ps         AS Ps ;
                        FROM CrProdutos a, Tmp_Compos c ;
                        WHERE a.cpros = c.cpros ;
                            AND IIF(INLIST(loc_nTpRel, 2), c.vlrcvs # 0, .T.) ;
                        ORDER BY a.cpros + c.cgrus ;
                        INTO CURSOR CsRels

                    *-- CsRelatorio: adiciona colunas de memo (imagem, totais)
                    SELECT a.*, b.Imagem, b.ValTot, b.MoeTot ;
                        FROM CsRels a ;
                        FULL JOIN Tmp_Memos b ON b.cids = ' ' ;
                        INTO CURSOR CsRelatorio

                    IF USED("CsRels")
                        USE IN CsRels
                    ENDIF

                    IF USED("Relatorio")
                        USE IN Relatorio
                    ENDIF

                    *-- Abre segunda referencia para permitir sub-SELECTs durante SCAN
                    USE DBF("CsRelatorio") ALIAS Relatorio IN 0 AGAIN

                    *-- Enriquece cada produto com dados detalhados do SQL
                    SELECT Relatorio
                    GO TOP
                    SCAN
                        loc_cCodPro   = Relatorio.Codigo
                        loc_lFoundMov = .F.

                        IF USED("TmpProds")
                            USE IN TmpProds
                        ENDIF

                        IF INLIST(loc_nTpRel, 5) AND USED("TmpMov")
                            SELECT TmpMov
                            LOCATE FOR cpros = loc_cCodPro
                            loc_lFoundMov = FOUND()
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT a.cpros,a.linhas,a.cunis,a.pesoms," + ;
                            "a.custofs,a.moecusfs,a.moecs," + ;
                            "a.pvens,a.moevs,a.pvideals," + ;
                            "a.moedas,a.reffs,a.figjpgs," + ;
                            "a.sgrus,s.descricaos " + ;
                            "FROM SigCdPro a " + ;
                            "LEFT JOIN SigCdPsg s ON a.sgrus = s.codigos " + ;
                            "WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
                            "TmpProds")

                        SELECT TmpProds
                        GO TOP
                        IF !EOF()
                            SELECT Relatorio
                            REPLACE Relatorio.Linha    WITH TmpProds.linhas, ;
                                    Relatorio.Unidade  WITH TmpProds.cunis, ;
                                    Relatorio.Peso     WITH TmpProds.pesoms, ;
                                    Relatorio.PreCusto WITH TmpProds.custofs, ;
                                    Relatorio.MoeCusto WITH ;
                                        IIF(loc_nTpRel = 1, ;
                                            TmpProds.moecusfs, TmpProds.moecs), ;
                                    Relatorio.PreIdeal WITH TmpProds.pvideals, ;
                                    Relatorio.MoeIdeal WITH TmpProds.moedas, ;
                                    Relatorio.Imagem   WITH ;
                                        STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                            TmpProds.figjpgs, ;
                                            "data:image/png;base64,",""), ;
                                            "data:image/jpeg;base64,",""), ;
                                            "data:image/jpg;base64,",""),14), ;
                                    Relatorio.RefFor   WITH TmpProds.reffs, ;
                                    Relatorio.SubGrupo WITH TmpProds.sgrus, ;
                                    Relatorio.DesGrupo WITH TmpProds.descricaos

                            *-- Preco de venda: tipo 5 usa preco da movimentacao
                            IF loc_lFoundMov = .T.
                                REPLACE Relatorio.PreVenda WITH TmpMov.totas, ;
                                        Relatorio.MoeVenda WITH TmpMov.moedas
                            ELSE
                                REPLACE Relatorio.PreVenda WITH TmpProds.pvens, ;
                                        Relatorio.MoeVenda WITH TmpProds.moevs
                            ENDIF
                        ENDIF
                        SELECT Relatorio
                    ENDSCAN

                    *-- Indexa por referencia + grupo + quadro
                    INDEX ON RefFor + Grupos + STR(Quadro, 6) TAG Ordem
                    SET ORDER TO Ordem

                    loc_nCnt   = 0
                    loc_cGrupo = Relatorio.RefFor + Relatorio.Grupos
                    loc_cProdt = SUBSTR(Relatorio.Grupos, 1, 10)

                    *-- Processa imagens, totais por grupo e ordenacao de quadros
                    SELECT Relatorio
                    GO TOP
                    SCAN
                        REPLACE Relatorio.ValTot WITH "", ;
                                Relatorio.MoeTot WITH ""

                        IF EMPTY(Imagem) OR ISNULL(Imagem)
                            REPLACE Relatorio.OrdImg WITH "FBRANCOS"
                        ELSE
                            REPLACE Relatorio.OrdImg WITH "F" + PADL(RECNO(), 7, "0")
                            loc_cFotoRel = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                Relatorio.Imagem, ;
                                "data:image/png;base64,",""), ;
                                "data:image/jpeg;base64,",""), ;
                                "data:image/jpg;base64,",""), 14)
                            STRTOFILE(loc_cFotoRel, SYS(2023) + "\F" + ;
                                      PADL(RECNO(), 7, "0") + ".Jpg")
                        ENDIF

                        IF Relatorio.Imprime = "S" AND loc_nTpRel = 2
                            IF !EMPTY(Relatorio.Observa) AND !ISNULL(Relatorio.Observa)
                                REPLACE Relatorio.DesMateria WITH Relatorio.Observa
                            ELSE
                                IF !EMPTY(Relatorio.DesGrupo) AND !ISNULL(Relatorio.DesGrupo)
                                    REPLACE Relatorio.DesMateria WITH Relatorio.DesGrupo
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Ao mudar de grupo: calcula totais do grupo anterior
                        IF loc_cGrupo # Relatorio.RefFor + Relatorio.Grupos
                            SKIP -1

                            SELECT a.Grupos, a.MoeCusto, ;
                                   SUM(a.Quantidade * a.ValMateria) AS Valor ;
                                FROM CsRelatorio a ;
                                WHERE a.RefFor + a.Grupos = m.loc_cGrupo ;
                                GROUP BY a.Grupos, a.MoeCusto ;
                                INTO CURSOR csMoedas

                            SELECT csMoedas
                            SCAN
                                SELECT Relatorio
                                REPLACE Relatorio.ValTot WITH ;
                                    IIF(EMPTY(ValTot), ;
                                        TRANSFORM(csMoedas.Valor, "999,999.99"), ;
                                        ValTot + CHR(13) + ;
                                        TRANSFORM(csMoedas.Valor, "999,999.99")), ;
                                    Relatorio.MoeTot WITH ;
                                    IIF(EMPTY(MoeTot), ;
                                        csMoedas.MoeCusto, ;
                                        MoeTot + CHR(13) + csMoedas.MoeCusto)
                                SELECT csMoedas
                            ENDSCAN

                            SELECT Relatorio
                            SKIP
                            loc_cGrupo = Relatorio.RefFor + Relatorio.Grupos
                        ENDIF

                        IF loc_cProdt # SUBSTR(Relatorio.Grupos, 1, 10)
                            loc_cProdt = SUBSTR(Relatorio.Grupos, 1, 10)
                            loc_nCnt = 0
                        ENDIF

                        REPLACE Relatorio.Quadro WITH loc_nCnt
                        SELECT Relatorio
                        loc_nCnt = loc_nCnt + 1
                    ENDSCAN

                    *-- Calcula totais do ultimo grupo
                    SELECT Relatorio
                    GO BOTTOM

                    SELECT a.Grupos, a.MoeCusto, ;
                           SUM(a.Quantidade * a.ValMateria) AS Valor ;
                        FROM CsRelatorio a ;
                        WHERE a.RefFor + a.Grupos = m.loc_cGrupo ;
                        GROUP BY a.Grupos, a.MoeCusto ;
                        INTO CURSOR CsMoedas

                    SELECT CsMoedas
                    SCAN
                        SELECT Relatorio
                        REPLACE Relatorio.ValTot WITH ;
                            IIF(EMPTY(ValTot), ;
                                TRANSFORM(CsMoedas.Valor, "999,999.99"), ;
                                ValTot + CHR(13) + TRANSFORM(CsMoedas.Valor, "999,999.99")), ;
                            Relatorio.MoeTot WITH ;
                            IIF(EMPTY(MoeTot), ;
                                CsMoedas.MoeCusto, ;
                                MoeTot + CHR(13) + CsMoedas.MoeCusto)
                        SELECT CsMoedas
                    ENDSCAN

                    *-- Ordenacao final
                    SELECT Relatorio
                    IF loc_nOrdem = 1
                        INDEX ON Grupos + STR(Quadro, 6) TAG Ordem
                    ENDIF
                    SET ORDER TO Ordem
                    GO TOP

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosCompEsp1 - Prepara cursor crProCompos para tipos 3 e 4
    * Equivalente ao metodo proccompesp1 do legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosCompEsp1()
        LOCAL loc_lSucesso, loc_lOK, loc_cEmp, loc_nResult
        LOCAL loc_lcImgJpg, loc_oErro
        LOCAL loc_cCodPro, loc_lcCompos, loc_cMaoObraPro, loc_cMaoObraGarra
        LOCAL loc_lcArquivo, loc_xImg, loc_lcFoto

        loc_lSucesso = .F.

        TRY
            *-- Nome da empresa para o cabecalho
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Razas FROM SigCdEmp", ;
                "cursor_4c_TmpEmp")

            IF loc_nResult > 0
                SELECT cursor_4c_TmpEmp
                GO TOP
                loc_cEmp = IIF(!EOF(), ALLTRIM(cursor_4c_TmpEmp.Razas), "")
                USE IN cursor_4c_TmpEmp
            ELSE
                loc_cEmp = go_4c_Sistema.cCodEmpresa
            ENDIF

            *-- Cursor de cabecalho
            IF USED("Cabecalho")
                USE IN Cabecalho
            ENDIF
            CREATE CURSOR Cabecalho (Empresa c(50), Titulos c(50), lImpTit l)
            INSERT INTO Cabecalho (Empresa, Titulos, lImpTit) ;
                VALUES (loc_cEmp, ;
                    "Composi" + CHR(231) + CHR(227) + "o Espec" + CHR(237) + "fica 1", ;
                    .F.)

            *-- Cursor de resultado da composicao especifica
            IF USED("crProCompos")
                USE IN crProCompos
            ENDIF
            CREATE CURSOR crProCompos ( ;
                cPros c(14), dPros c(40), PesoMs n(12,2), PVens n(12,2), ;
                Compos m, DtIncs d, DataAlts d, CodGarras c(10), ;
                cProdPai c(14), MoeVs c(3), PrecoGarra n(12,2), ;
                PesoGarra n(12,2), MoeGarra c(3), ;
                cMObraPro c(50), cMObraGarra c(50), Colecoes c(10))

            *-- Imagem em branco via SigSyIco
            loc_lcImgJpg = ""
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 carqicones, marqicones FROM SigSyIco", ;
                "cursor_4c_Icone1")

            IF loc_nResult > 0
                SELECT cursor_4c_Icone1
                GO TOP
                IF !EOF()
                    loc_lcImgJpg = NVL(cursor_4c_Icone1.marqicones, "")
                ENDIF
                USE IN cursor_4c_Icone1
            ENDIF

            IF USED("CrBranco")
                USE IN CrBranco
            ENDIF
            CREATE CURSOR CrBranco (branco m)
            SELECT CrBranco
            APPEND BLANK
            IF !EMPTY(loc_lcImgJpg)
                REPLACE Branco WITH loc_lcImgJpg IN CrBranco
            ENDIF

            *-- Verifica cursor de produtos do form chamador
            IF !USED("CrProdutos")
                THIS.this_cMensagemErro = "Cursor CrProdutos n" + CHR(227) + ;
                    "o encontrado. O form chamador deve popular este cursor antes de chamar PrepararDados."
                loc_lSucesso = .F.
                loc_lOK = .F.
            ELSE
                loc_lOK = .T.
            ENDIF

            IF loc_lOK
                *-- Percorre cada produto e monta o cursor de composicao especifica
                SELECT CrProdutos
                GO TOP IN CrProdutos
                SCAN WHILE loc_lOK
                    loc_cCodPro       = CrProdutos.cPros
                    loc_lcCompos      = ""
                    loc_cMaoObraPro   = ""
                    loc_cMaoObraGarra = ""

                    *-- Dados principais do produto e garra
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT b.CPros, MAX(b.dpros) as dpros," + ;
                        " b.PVens, b.PesoMs, b.DtIncs," + ;
                        " MAX(c.DataAlts) as DataAlts, b.Colecoes," + ;
                        " b.CodGarras, b.cProEqs, b.MoeVs," + ;
                        " d.PVens as PrecoGarra," + ;
                        " d.PesoMs as PesoGarra," + ;
                        " d.MoeVs as MoeGarra" + ;
                        " FROM SigCdPro b" + ;
                        " LEFT JOIN SigCdPro d ON d.cPros = b.CodGarras" + ;
                        " LEFT JOIN SigCdPrc c ON c.cPros = b.cPros" + ;
                        " WHERE b.cPros = " + EscaparSQL(loc_cCodPro) + ;
                        " GROUP BY b.cPros, b.PVens, b.PesoMs, b.DtIncs," + ;
                        " b.Colecoes, b.CodGarras, b.cProEqs," + ;
                        " b.MoeVs, d.PVens, d.PesoMs, d.MoeVs" + ;
                        " ORDER BY b.CPros", ;
                        "crTmpPro")

                    IF loc_nResult < 1
                        MsgErro("Falha na conex" + CHR(227) + ;
                            "o ao buscar produto " + loc_cCodPro, ;
                            "PrepararDadosCompEsp1")
                        loc_lOK = .F.
                    ENDIF

                    IF loc_lOK
                        *-- Composicao do produto
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT a.cGrus, a.Mats, a.dCompos, a.Qtds," + ;
                            " a.UniCompos, a.Pesos, a.cUniPs," + ;
                            " b.CustoFs, c.nTipoJoals" + ;
                            " FROM SigPrCpo a" + ;
                            " INNER JOIN SigCdPro b ON b.cPros = a.Mats" + ;
                            " INNER JOIN SigCdGrp c ON c.cGrus = a.cGrus" + ;
                            " WHERE a.cPros = " + EscaparSQL(loc_cCodPro), ;
                            "crTmpCompo")

                        IF loc_nResult < 1
                            MsgErro("Falha na conex" + CHR(227) + ;
                                "o ao buscar composi" + CHR(231) + CHR(227) + ;
                                "o de " + loc_cCodPro, ;
                                "PrepararDadosCompEsp1")
                            loc_lOK = .F.
                        ENDIF
                    ENDIF

                    IF loc_lOK
                        *-- Monta string de composicao e identifica mao de obra
                        SELECT crTmpCompo
                        SCAN
                            IF crTmpCompo.nTipoJoals = 4
                                loc_cMaoObraPro = loc_cMaoObraPro + ;
                                    IIF(!EMPTY(loc_cMaoObraPro), "/", "") + ;
                                    ALLTRIM(crTmpCompo.Mats)
                            ENDIF
                            loc_lcCompos = loc_lcCompos + ;
                                IIF(!EMPTY(loc_lcCompos), CHR(13) + CHR(10), "")
                            loc_lcCompos = loc_lcCompos + crTmpCompo.Mats + "  " + ;
                                LEFT(crTmpCompo.dCompos, 34) + " " + ;
                                TRANSFORM(crTmpCompo.Qtds, "9999.999") + " " + ;
                                crTmpCompo.UniCompos + " " + ;
                                TRANSFORM(crTmpCompo.Pesos, "9999.999") + " " + ;
                                crTmpCompo.cUniPs
                        ENDSCAN

                        *-- Mao de obra da garra (acessorio do produto)
                        SELECT crTmpPro
                        GO TOP
                        IF !EMPTY(crTmpPro.CodGarras)
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT a.Mats" + ;
                                " FROM SigPrCpo a" + ;
                                " INNER JOIN SigCdPro b ON b.cPros = a.Mats" + ;
                                " INNER JOIN SigCdGrp c ON c.cGrus = a.cGrus" + ;
                                " WHERE a.cPros = " + EscaparSQL(crTmpPro.CodGarras) + ;
                                " AND c.nTipoJoals = 4", ;
                                "crMaoObra")

                            IF loc_nResult < 1
                                MsgErro("Falha na conex" + CHR(227) + ;
                                    "o ao buscar m" + CHR(227) + ;
                                    "o de obra da garra", ;
                                    "PrepararDadosCompEsp1")
                                loc_lOK = .F.
                            ELSE
                                SELECT crMaoObra
                                SCAN
                                    loc_cMaoObraGarra = loc_cMaoObraGarra + ;
                                        IIF(!EMPTY(loc_cMaoObraGarra), "/", "") + ;
                                        ALLTRIM(crMaoObra.Mats)
                                ENDSCAN
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lOK
                        *-- Imagem do produto
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT FigJpgs FROM SigCdPro" + ;
                            " WHERE cPros = " + EscaparSQL(loc_cCodPro), ;
                            "cursor_4c_LocPro")

                        *-- Limpa codigo do produto para uso como nome de arquivo
                        SELECT crTmpPro
                        GO TOP
                        loc_xImg = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(STRTRAN( ;
                            crTmpPro.cPros, "/", ""), " ", ""), ".", ""), "\", ""))
                        loc_lcArquivo = SYS(2023) + "\T" + loc_xImg + ".jpg"

                        CLEAR RESOURCES
                        IF loc_nResult > 0
                            SELECT cursor_4c_LocPro
                            GO TOP
                            IF !EOF() AND !EMPTY(cursor_4c_LocPro.FigJpgs)
                                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    cursor_4c_LocPro.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                            ELSE
                                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    CrBranco.Branco, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                            ENDIF
                            USE IN cursor_4c_LocPro
                        ELSE
                            loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                CrBranco.Branco, ;
                                "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                                "data:image/jpg;base64,", ""), 14)
                        ENDIF

                        STRTOFILE(loc_lcFoto, loc_lcArquivo)

                        *-- Insere registro no cursor de resultado
                        SELECT crTmpPro
                        GO TOP
                        INSERT INTO crProCompos ( ;
                            cPros, dPros, PesoMs, PVens, Compos, ;
                            DtIncs, DataAlts, CodGarras, cProdPai, ;
                            MoeVs, PrecoGarra, PesoGarra, MoeGarra, ;
                            cMObraPro, cMObraGarra, Colecoes) ;
                            VALUES ( ;
                            crTmpPro.cPros, crTmpPro.dpros, ;
                            crTmpPro.PesoMs, crTmpPro.PVens, ;
                            loc_lcCompos, ;
                            NVL(crTmpPro.DtIncs, {}), ;
                            NVL(crTmpPro.DataAlts, {}), ;
                            crTmpPro.CodGarras, crTmpPro.cProEqs, ;
                            crTmpPro.MoeVs, ;
                            NVL(crTmpPro.PrecoGarra, 0), ;
                            NVL(crTmpPro.PesoGarra, 0), ;
                            NVL(crTmpPro.MoeGarra, ""), ;
                            loc_cMaoObraPro, loc_cMaoObraGarra, ;
                            crTmpPro.Colecoes)

                        SELECT CrProdutos
                    ENDIF
                ENDSCAN

                IF loc_lOK
                    SELECT crProCompos
                    GO TOP IN crProCompos
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDadosCompEsp1")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime o relatorio em impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_nTpRel, loc_lcApagar, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_nTpRel = THIS.this_nOpcRel

            IF loc_nTpRel = 1
                REPORT FORM SigReCgp TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 2)
                REPORT FORM SigReCg1 TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 5)
                REPORT FORM SigReCg2 TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF loc_nTpRel = 3
                REPORT FORM SigPrCpr TO PRINT PROMPT NOCONSOLE
            ENDIF
            IF loc_nTpRel = 4
                REPORT FORM SigPrCp2 TO PRINT PROMPT NOCONSOLE
            ENDIF

            loc_lcApagar = SYS(2023) + "\F*.Jpg"
            DELETE FILE &loc_lcApagar.

            THIS.LimparCursores()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_nTpRel, loc_lcApagar, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_nTpRel = THIS.this_nOpcRel

            IF loc_nTpRel = 1
                REPORT FORM SigReCgp PREVIEW NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 2)
                REPORT FORM SigReCg1 PREVIEW NOCONSOLE
            ENDIF
            IF INLIST(loc_nTpRel, 5)
                REPORT FORM SigReCg2 PREVIEW NOCONSOLE
            ENDIF
            IF loc_nTpRel = 3
                REPORT FORM SigPrCpr PREVIEW NOCONSOLE
            ENDIF
            IF loc_nTpRel = 4
                REPORT FORM SigPrCp2 PREVIEW NOCONSOLE
            ENDIF

            loc_lcApagar = SYS(2023) + "\F*.Jpg"
            DELETE FILE &loc_lcApagar.

            THIS.LimparCursores()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Libera cursores temporarios e arquivos de imagem
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        LOCAL loc_lcArquivo, loc_xImg

        *-- Remove arquivos de imagem temporarios da CompEsp1 (prefixo T)
        IF USED("crProCompos")
            SELECT crProCompos
            GO TOP
            SCAN
                loc_xImg = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(STRTRAN( ;
                    crProCompos.cPros, "/", ""), " ", ""), ".", ""), "\", ""))
                loc_lcArquivo = SYS(2023) + "\T" + loc_xImg + ".jpg"
                IF FILE(loc_lcArquivo)
                    DELETE FILE (loc_lcArquivo)
                ENDIF
            ENDSCAN
        ENDIF

        *-- Fecha cursores de relatorio
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("Relatorio")
            USE IN Relatorio
        ENDIF
        IF USED("csRelatorio")
            USE IN csRelatorio
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("csMoedas")
            USE IN csMoedas
        ENDIF
        IF USED("CsMoedas")
            USE IN CsMoedas
        ENDIF
        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF
        IF USED("crProCompos")
            USE IN crProCompos
        ENDIF
        IF USED("Tmp_Memos")
            USE IN Tmp_Memos
        ENDIF
        IF USED("Tmp_Compos")
            USE IN Tmp_Compos
        ENDIF
        IF USED("CrBranco")
            USE IN CrBranco
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor de preset
    * Para BO de relatorio, o cursor pode armazenar parametros previamente usados
    * par_cAliasCursor: nome do cursor com colunas de parametros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    *-- SCATTER MEMVAR para acessar colunas dinamicamente
                    SCATTER MEMVAR

                    IF TYPE("m.nOpcRel") = "N"
                        THIS.this_nOpcRel = m.nOpcRel
                    ENDIF
                    IF TYPE("m.nOpcOrdem") = "N"
                        THIS.this_nOpcOrdem = m.nOpcOrdem
                    ENDIF
                    IF TYPE("m.cEmpEDN") = "C"
                        THIS.this_cEmpEDN = ALLTRIM(m.cEmpEDN)
                    ENDIF
                    IF TYPE("m.nVal") = "N"
                        THIS.this_nVal = m.nVal
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o relatorio enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Prepara dados, dispara impressao e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !INLIST(THIS.this_nOpcRel, 1, 2, 3, 4, 5)
                THIS.this_cMensagemErro = "Tipo de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido: " + ;
                    TRANSFORM(THIS.this_nOpcRel)
            ELSE
                IF !THIS.PrepararDados()
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.Imprimir()
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("IMPRESSAO")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o relatorio em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Prepara dados, dispara preview e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !INLIST(THIS.this_nOpcRel, 1, 2, 3, 4, 5)
                THIS.this_cMensagemErro = "Tipo de relat" + CHR(243) + ;
                    "rio inv" + CHR(225) + "lido: " + ;
                    TRANSFORM(THIS.this_nOpcRel)
            ELSE
                IF !THIS.PrepararDados()
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.Visualizar()
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("VISUALIZACAO")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        LOCAL loc_cUsuario, loc_cEmpresa, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cEmpresa = ""
            IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF

            loc_cChave = "EMP=" + loc_cEmpresa + ;
                         ";TIPO=" + ALLTRIM(STR(THIS.this_nOpcRel, 1)) + ;
                         ";ORDEM=" + ALLTRIM(STR(THIS.this_nOpcOrdem, 1)) + ;
                         ";EDN=" + ALLTRIM(THIS.this_cEmpEDN)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCgp") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
