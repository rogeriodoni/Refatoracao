*==============================================================================
* SIGREHBRBO.PRG
* Business Object para Relatorio de Codigos de Barras Por Estoque
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrehbrBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Grupo de Estoque (get_cd_grestoque / get_ds_grestoque)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Conta de Estoque (get_cd_estoque / get_ds_estoque)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Fornecedor (getIFors / getDFors)
    this_cIFors         = ""
    this_cDFors         = ""

    *-- Grande Grupo (getCGgps / getDGgps)
    this_cCGgps         = ""
    this_cDGgps         = ""

    *-- Grupo de Produto (Get_Cd_GPro / Get_Ds_GPro)
    this_cCdGPro        = ""
    this_cDsGPro        = ""

    *-- Subgrupo de Produto (get_cd_sgrupo / get_ds_sgrupo)
    this_cCdSgrupo      = ""
    this_cDsSgrupo      = ""

    *-- Produto (get_cd_codigo / get_ds_codigo)
    this_cCdCodigo      = ""
    this_cDsCodigo      = ""

    *-- Codigo de Barras (getCBars)
    this_cCBars         = ""

    *-- Codigo Reduzido (getReduzs)
    this_cReduzs        = ""

    *-- Opcoes de impressao (checkboxes)
    this_nCheck1        = 0    && Venda
    this_nCheck2        = 0    && Custo
    this_nCheck3        = 0    && Duracao (seleciona SigReHb3)
    this_nCheck4        = 0    && Imagem
    this_nCheck5        = 0    && Analitico (seleciona SigReHb2)

    *-- Cursores e caminhos FRX
    this_cCursorDados       = "TmpEti"
    this_cCursorCabecalho   = "csCabecalho"
    this_cFrxBase1          = ""
    this_cFrxBase2          = ""
    this_cFrxBase3          = ""

    *-- Nome da empresa para cabecalho do relatorio
    this_cNomeEmpresa       = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO configurando caminhos dos relatorios FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        THIS.this_cFrxBase1   = gc_4c_CaminhoReports + "SigReHb1.frx"
        THIS.this_cFrxBase2   = gc_4c_CaminhoReports + "SigReHb2.frx"
        THIS.this_cFrxBase3   = gc_4c_CaminhoReports + "SigReHb3.frx"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa query principal e prepara TmpEti para relatorio
    * Equivalente ao metodo "processamento" do original SIGREHBR
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cWhere, loc_cSQL, loc_nResult
        LOCAL loc_cGrupo, loc_cSgrupo, loc_cTVen, loc_cTCus, loc_llIImg
        LOCAL loc_cNEmp, loc_cTits, loc_cSubs

        loc_lSucesso = .F.
        TRY
            loc_cTVen  = IIF(THIS.this_nCheck1 = 1, "S", "N")
            loc_cTCus  = IIF(THIS.this_nCheck2 = 1, "S", "N")
            loc_llIImg = (THIS.this_nCheck4 = 1)

            *-- Obtem nome da empresa para o cabecalho
            loc_cNEmp = THIS.BuscarNomeEmpresa()

            *-- Titulo: "Posicao de Codigo de Barras [(codigo reduzido)]"
            loc_cTits = "Posi" + CHR(231) + CHR(227) + "o de C" + CHR(243) + "digo de Barras"
            IF !EMPTY(ALLTRIM(THIS.this_cReduzs))
                loc_cTits = loc_cTits + " (" + ALLTRIM(THIS.this_cReduzs) + ")"
            ENDIF

            *-- Subtitulo: periodo e filtros aplicados
            loc_cSubs = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                        " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal)
            IF !EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cCdGrEstoque) + ;
                            " - " + ALLTRIM(THIS.this_cDsGrEstoque)
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCdEstoque))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cCdEstoque) + ;
                            " - " + ALLTRIM(THIS.this_cDsEstoque)
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCdCodigo))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cCdCodigo) + ;
                            " - " + ALLTRIM(THIS.this_cDsCodigo)
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cIFors))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cIFors) + ;
                            " - " + ALLTRIM(THIS.this_cDFors)
            ENDIF

            *-- Cria cursor de cabecalho para uso no FRX
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (Empresa C(80), Titulo C(80), SubTitulo C(80), llImpConta L)
            INSERT INTO csCabecalho (Empresa, Titulo, SubTitulo, llImpConta) ;
                VALUES (loc_cNEmp, loc_cTits, loc_cSubs, EMPTY(ALLTRIM(THIS.this_cCdEstoque)))

            *-- Monta clausula WHERE baseada nos filtros
            IF EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_cWhere = "1=1"
            ELSE
                loc_cGrupo = PADR(THIS.this_cCdGrEstoque, 10)
                loc_cWhere = "a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
                loc_cWhere = loc_cWhere + ;
                    " AND a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                    " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")"
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cWhere = loc_cWhere + " AND a.EmpOs = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdEstoque))
                loc_cWhere = loc_cWhere + " AND a.Contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdEstoque))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCGgps))
                loc_cWhere = loc_cWhere + " AND b.Mercs = " + EscaparSQL(ALLTRIM(THIS.this_cCGgps))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdGPro))
                loc_cWhere = loc_cWhere + " AND b.CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cCdGPro))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdSgrupo))
                loc_cSgrupo = PADR(THIS.this_cCdSgrupo, 6)
                loc_cWhere = loc_cWhere + " AND b.SGrus = " + EscaparSQL(loc_cSgrupo)
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdCodigo))
                loc_cWhere = loc_cWhere + " AND a.CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCdCodigo))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cReduzs))
                loc_cWhere = loc_cWhere + " AND Left(a.CodAmss, 3) = " + EscaparSQL(ALLTRIM(THIS.this_cReduzs))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cIFors))
                loc_cWhere = loc_cWhere + " AND b.IFors = " + EscaparSQL(ALLTRIM(THIS.this_cIFors))
            ENDIF

            *-- Monta query principal (quebrada em multiplas linhas para evitar limite VFP9)
            loc_cSQL = "Select a.EmpOs as Emps, a.Grupos, a.Contas, a.CPros, a.CBars, a.Qtds, a.Pesos, "
            loc_cSQL = loc_cSQL + "b.DPros, a.CodCors, a.CodTams, b.CUnis, b.CUniPs, b.PCuss, b.PVens, "
            loc_cSQL = loc_cSQL + "' ' as CVens, ' ' as CCuss, b.FigJpgs, a.Datas, a.CBars as NDias, 0 as Imps, "
            loc_cSQL = loc_cSQL + "d.rClis, Cast(b.dpro3s as char(200)) as dpro3s, b.Reffs, Left(a.CodAmss, 3) as Reds "
            loc_cSQL = loc_cSQL + "From SigOpEtq a "
            loc_cSQL = loc_cSQL + "Left Join SigCdPro b On a.CPros = b.CPros "
            loc_cSQL = loc_cSQL + "Left Join SigCdCli d on d.iClis = a.Contas "
            loc_cSQL = loc_cSQL + "Where " + loc_cWhere + " "
            loc_cSQL = loc_cSQL + "Order By a.EmpOs, a.Grupos, a.Contas, a.CPros, a.CBars"

            IF USED("TmpEti")
                USE IN TmpEti
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEti")
            IF loc_nResult > 0
                SELECT TmpEti
                GO TOP IN TmpEti

                *-- Zera Datas/NDias e define flags de impressao de venda/custo
                UPDATE TmpEti ;
                    SET Datas = {}, ;
                        NDias = 0, ;
                        CVens = loc_cTVen, ;
                        CCuss = loc_cTCus

                *-- Processa historicos (modo Duracao) ou apenas imagens
                IF THIS.this_nCheck3 = 1
                    loc_lSucesso = THIS.ProcessarHistoricosDuracao(loc_llIImg)
                ELSE
                    IF loc_llIImg
                    loc_lSucesso = THIS.ProcessarImagensSimples()
                ELSE
                    loc_lSucesso = .T.
                    ENDIF
                ENDIF

                SELECT TmpEti
                GO TOP IN TmpEti
            ELSE
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o ao buscar dados de etiquetas."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNomeEmpresa - Retorna nome da empresa para o cabecalho do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarNomeEmpresa()
        RETURN ALLTRIM(go_4c_Sistema.cEmpresa)
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarHistoricosDuracao - Para cada item em TmpEti busca o ultimo
    * historico de entrada em SigMvHst e calcula dias de permanencia no estoque
    * Equivalente ao bloco SCAN do modo Duracao (Check3=1) no original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarHistoricosDuracao(par_llIImg)
        LOCAL loc_lSucesso, loc_cKey, loc_cBar, loc_cSQL, loc_nResult
        LOCAL loc_cArq, loc_lHasImg, loc_dDataHis, loc_nDias, loc_cFoto

        loc_lSucesso = .T.
        loc_cKey = SPACE(33)

        IF par_llIImg
            THIS.PrepararCursorBranco()
        ENDIF

        SELECT TmpEti
        GO TOP IN TmpEti

        SCAN
            loc_cBar = ALLTRIM(STR(TmpEti.CBars, 14))

            *-- Marca primeiro registro de cada combinacao produto/conta para imagem
            IF par_llIImg AND (loc_cKey <> TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros)
                loc_cKey = TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros
                REPLACE Imps WITH 1 IN TmpEti
            ENDIF

            *-- Busca ultimo historico de entrada para esta combinacao de barcode+grupo+estoque+cor+tamanho
            loc_cSQL = "Select Datas, Seqs "
            loc_cSQL = loc_cSQL + "From SigMvHst "
            loc_cSQL = loc_cSQL + "Where CodBarras = " + loc_cBar
            loc_cSQL = loc_cSQL + " And Grupos = " + EscaparSQL(ALLTRIM(TmpEti.Grupos))
            loc_cSQL = loc_cSQL + " And Estos = " + EscaparSQL(ALLTRIM(TmpEti.Contas))
            loc_cSQL = loc_cSQL + " And CodCors = " + EscaparSQL(ALLTRIM(TmpEti.CodCors))
            loc_cSQL = loc_cSQL + " And CodTams = " + EscaparSQL(ALLTRIM(TmpEti.CodTams))
            loc_cSQL = loc_cSQL + " And Opers = 'E' "
            loc_cSQL = loc_cSQL + "Order By Seqs Desc"

            IF USED("TmpHis")
                USE IN TmpHis
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHis")
            IF loc_nResult < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao buscar hist" + CHR(243) + "rico.", "Erro")
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o ao buscar hist" + CHR(243) + "rico."
                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                loc_lSucesso = .F.
                EXIT
            ENDIF

            SELECT TmpHis
            GO TOP IN TmpHis

            IF !EOF() AND !EMPTY(TmpHis.Datas)
                loc_dDataHis = TTOD(TmpHis.Datas)
                loc_nDias    = DATE() - loc_dDataHis
                REPLACE Datas WITH TTOD(TmpHis.Datas), ;
                        NDias WITH loc_nDias ;
                        IN TmpEti
            ENDIF

            IF USED("TmpHis")
                USE IN TmpHis
            ENDIF

            IF par_llIImg
                loc_cArq = SYS(2023) + "\SigReHb3_" + ;
                           PADL(ALLTRIM(STR(TmpEti.CBars, 14)), 14, "0") + ".jpg"
                CLEAR RESOURCES
                loc_lHasImg = .F.
                IF !ISNULL(TmpEti.FigJpgs)
                    IF !EMPTY(TmpEti.FigJpgs)
                        IF LEN(ALLTRIM(TmpEti.FigJpgs)) > 10
                            loc_lHasImg = .T.
                        ENDIF
                    ENDIF
                ENDIF
                IF loc_lHasImg
                    loc_cFoto = STRCONV( ;
                        STRTRAN( ;
                            STRTRAN( ;
                                STRTRAN(TmpEti.FigJpgs, "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, loc_cArq)
                ELSE
                    THIS.CopiarImagemBranca(loc_cArq)
                ENDIF
            ENDIF

            SELECT TmpEti
        ENDSCAN

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarImagensSimples - Processa imagens sem busca de historico
    * Usado quando Check4=1 e Check3=0 (imagens sem modo Duracao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarImagensSimples()
        LOCAL loc_lSucesso, loc_cKey, loc_cArq, loc_lHasImg, loc_cFoto

        loc_lSucesso = .T.
        loc_cKey = SPACE(33)
        THIS.PrepararCursorBranco()

        SELECT TmpEti
        GO TOP IN TmpEti

        SCAN
            IF (loc_cKey <> TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros)
                loc_cKey = TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros
                REPLACE Imps WITH 1 IN TmpEti
            ENDIF

            loc_cArq = SYS(2023) + "\SigReHb3_" + ;
                       PADL(ALLTRIM(STR(TmpEti.CBars, 14)), 14, "0") + ".jpg"
            CLEAR RESOURCES
            loc_lHasImg = .F.
            IF !ISNULL(TmpEti.FigJpgs)
                IF !EMPTY(TmpEti.FigJpgs)
                    IF LEN(ALLTRIM(TmpEti.FigJpgs)) > 10
                        loc_lHasImg = .T.
                    ENDIF
                ENDIF
            ENDIF
            IF loc_lHasImg
                loc_cFoto = STRCONV( ;
                    STRTRAN( ;
                        STRTRAN( ;
                            STRTRAN(TmpEti.FigJpgs, "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                STRTOFILE(loc_cFoto, loc_cArq)
            ELSE
                THIS.CopiarImagemBranca(loc_cArq)
            ENDIF
        ENDSCAN

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursorBranco - Cria cursor memo com imagem branca para substituir
    * produtos sem foto no relatorio com imagens (Check4=1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararCursorBranco()
        LOCAL loc_cBrc
        loc_cBrc = gc_4c_CaminhoBase + "BrJpg.JPG"
        IF !FILE(loc_cBrc)
            loc_cBrc = gc_4c_CaminhoReports + "BrJpg.JPG"
        ENDIF
        IF !FILE(loc_cBrc)
            RETURN
        ENDIF
        IF USED("crBranco")
            USE IN crBranco
        ENDIF
        CREATE CURSOR crBranco (Branco M)
        SELECT crBranco
        APPEND BLANK IN crBranco
        APPEND MEMO Branco FROM (loc_cBrc) OVERWRITE
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarImagemBranca - Copia imagem branca para o arquivo destino
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CopiarImagemBranca(par_cArquivo)
        IF USED("crBranco")
            COPY MEMO crBranco.Branco TO (par_cArquivo)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparArquivosImagem - Remove arquivos temporarios de imagem apos impressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparArquivosImagem()
        LOCAL loc_cArq
        loc_cArq = SYS(2023) + "\SigReHb3_*.jpg"
        DELETE FILE &loc_cArq.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em modo preview na tela
    * Equivalente ao metodo "visualizacao" do original SIGREHBR
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nCheck3 = 1
                    REPORT FORM (THIS.this_cFrxBase3) PREVIEW NOCONSOLE
                ELSE
                    IF THIS.this_nCheck5 = 1
                    REPORT FORM (THIS.this_cFrxBase2) PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cFrxBase1) PREVIEW NOCONSOLE
                    ENDIF
                ENDIF
                THIS.LimparArquivosImagem()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    * Equivalente ao metodo "impressao" do original SIGREHBR
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nCheck3 = 1
                    REPORT FORM (THIS.this_cFrxBase3) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    IF THIS.this_nCheck5 = 1
                    REPORT FORM (THIS.this_cFrxBase2) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cFrxBase1) TO PRINTER PROMPT NOCONSOLE
                    ENDIF
                ENDIF
                THIS.LimparArquivosImagem()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Envia relatorio para impressora sem dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nCheck3 = 1
                    REPORT FORM (THIS.this_cFrxBase3) TO PRINTER NOCONSOLE
                ELSE
                    IF THIS.this_nCheck5 = 1
                    REPORT FORM (THIS.this_cFrxBase2) TO PRINTER NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cFrxBase1) TO PRINTER NOCONSOLE
                    ENDIF
                ENDIF
                THIS.LimparArquivosImagem()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE
