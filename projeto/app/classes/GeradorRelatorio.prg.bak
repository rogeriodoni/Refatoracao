*==============================================================================
* GERADORRELATORIO.PRG
* Classe para criar relatorios FRX programaticamente
*==============================================================================

DEFINE CLASS GeradorRelatorio AS Custom

    *-- Propriedades
    this_cArquivoFRX = ""
    this_cTitulo = ""
    this_cSubtitulo = ""
    this_cCursor = ""
    this_nLarguraPagina = 10.000
    this_nMargemEsquerda = 0.100
    this_nPosicaoAtual = 0.000
    this_nAberto = 0

    *-- Contadores de posicao vertical
    this_nPosPageHeader = 0.000
    this_nPosColHeader = 0.000
    this_nPosDetail = 0.000
    this_nPosPageFooter = 0.000

    *-- Alturas das bandas
    this_nAlturaPageHeader = 1.200
    this_nAlturaColHeader = 0.350
    this_nAlturaDetail = 0.300
    this_nAlturaPageFooter = 0.400

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init
        LPARAMETERS par_cArquivoFRX, par_cTitulo, par_cCursor

        IF VARTYPE(par_cArquivoFRX) = "C" AND !EMPTY(par_cArquivoFRX)
            THIS.this_cArquivoFRX = ALLTRIM(par_cArquivoFRX)
        ENDIF

        IF VARTYPE(par_cTitulo) = "C"
            THIS.this_cTitulo = ALLTRIM(par_cTitulo)
        ENDIF

        IF VARTYPE(par_cCursor) = "C"
            THIS.this_cCursor = ALLTRIM(par_cCursor)
        ENDIF

    ENDPROC

    *--------------------------------------------------------------------------
    * Criar - Cria a estrutura do FRX usando cursor
    *--------------------------------------------------------------------------
    PROCEDURE Criar
        LOCAL loc_cFRT, loc_cArq

        IF EMPTY(THIS.this_cArquivoFRX)
            RETURN
        ENDIF

        loc_cArq = THIS.this_cArquivoFRX

        * Remover arquivos existentes
        IF FILE(loc_cArq)
            DELETE FILE (loc_cArq)
        ENDIF

        loc_cFRT = FORCEEXT(loc_cArq, "frt")
        IF FILE(loc_cFRT)
            DELETE FILE (loc_cFRT)
        ENDIF

        * Criar cursor temporario com estrutura FRX minima
        CREATE CURSOR frx_4c_temp ;
            (platform C(8), uniqueid C(10), timestamp N(10), objtype N(2), objcode N(3), ;
             name M, expr M, vpos N(9,3), hpos N(9,3), height N(9,3), width N(9,3), ;
             style M, picture M, fontface M, fontstyle N(3), fontsize N(3), mode N(3), ;
             ruler N(1), rulerlines N(1), gridv N(2), gridh N(2), pensize N(5), ;
             comment M, tag M)

        THIS.this_nAberto = 1

        * Record 1: Configuracao geral do relatorio
        INSERT INTO frx_4c_temp (platform, uniqueid, objtype, objcode, ruler, rulerlines, gridv, gridh, expr) ;
            VALUES ("WINDOWS", "Report", 1, 53, 0, 0, 12, 12, THIS.this_cCursor)

    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarPageHeader
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarPageHeader
        LPARAMETERS par_nAltura

        IF THIS.this_nAberto = 0
            RETURN
        ENDIF

        IF VARTYPE(par_nAltura) = "N"
            THIS.this_nAlturaPageHeader = par_nAltura
        ENDIF

        THIS.this_nPosPageHeader = 0

        INSERT INTO frx_4c_temp (platform, uniqueid, objtype, objcode, vpos, hpos, height, width) ;
            VALUES ("WINDOWS", "PageHdr", 9, 0, THIS.this_nPosPageHeader, 0, THIS.this_nAlturaPageHeader, THIS.this_nLarguraPagina)

    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarColHeader
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarColHeader
        LPARAMETERS par_nAltura

        IF THIS.this_nAberto = 0
            RETURN
        ENDIF

        IF VARTYPE(par_nAltura) = "N"
            THIS.this_nAlturaColHeader = par_nAltura
        ENDIF

        THIS.this_nPosColHeader = THIS.this_nPosPageHeader + THIS.this_nAlturaPageHeader

        INSERT INTO frx_4c_temp (platform, uniqueid, objtype, objcode, vpos, hpos, height, width) ;
            VALUES ("WINDOWS", "ColHdr", 9, 1, THIS.this_nPosColHeader, 0, THIS.this_nAlturaColHeader, THIS.this_nLarguraPagina)

    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarDetail
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarDetail
        LPARAMETERS par_nAltura

        IF THIS.this_nAberto = 0
            RETURN
        ENDIF

        IF VARTYPE(par_nAltura) = "N"
            THIS.this_nAlturaDetail = par_nAltura
        ENDIF

        THIS.this_nPosDetail = THIS.this_nPosColHeader + THIS.this_nAlturaColHeader

        INSERT INTO frx_4c_temp (platform, uniqueid, objtype, objcode, vpos, hpos, height, width) ;
            VALUES ("WINDOWS", "Detail", 9, 4, THIS.this_nPosDetail, 0, THIS.this_nAlturaDetail, THIS.this_nLarguraPagina)

    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarPageFooter
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarPageFooter
        LPARAMETERS par_nAltura

        IF THIS.this_nAberto = 0
            RETURN
        ENDIF

        IF VARTYPE(par_nAltura) = "N"
            THIS.this_nAlturaPageFooter = par_nAltura
        ENDIF

        THIS.this_nPosPageFooter = THIS.this_nPosDetail + THIS.this_nAlturaDetail

        INSERT INTO frx_4c_temp (platform, uniqueid, objtype, objcode, vpos, hpos, height, width) ;
            VALUES ("WINDOWS", "PageFtr", 9, 7, THIS.this_nPosPageFooter, 0, THIS.this_nAlturaPageFooter, THIS.this_nLarguraPagina)

    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarLabel - Adiciona um texto fixo
    * par_nBanda: 0=PageHeader, 1=ColHeader, 4=Detail, 7=PageFooter
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarLabel
        LPARAMETERS par_cTexto, par_nBanda, par_nTop, par_nLeft, par_nWidth, par_cFonte, par_nTamanho, par_nNegrito
        LOCAL loc_nVPos, loc_nFS

        IF THIS.this_nAberto = 0
            RETURN
        ENDIF

        * Calcular posicao vertical
        DO CASE
            CASE par_nBanda = 0
                loc_nVPos = THIS.this_nPosPageHeader + par_nTop
            CASE par_nBanda = 1
                loc_nVPos = THIS.this_nPosColHeader + par_nTop
            CASE par_nBanda = 4
                loc_nVPos = THIS.this_nPosDetail + par_nTop
            CASE par_nBanda = 7
                loc_nVPos = THIS.this_nPosPageFooter + par_nTop
            OTHERWISE
                loc_nVPos = par_nTop
        ENDCASE

        loc_nFS = 0
        IF VARTYPE(par_nNegrito) = "L" AND par_nNegrito
            loc_nFS = 1
        ENDIF
        IF VARTYPE(par_nNegrito) = "N" AND par_nNegrito = 1
            loc_nFS = 1
        ENDIF

        INSERT INTO frx_4c_temp (platform, uniqueid, objtype, objcode, vpos, hpos, height, width) ;
            VALUES ("WINDOWS", SYS(2015), 5, 0, loc_nVPos, par_nLeft, 0.250, par_nWidth)

        IF EMPTY(par_cFonte)
            par_cFonte = "Arial"
        ENDIF
        IF par_nTamanho = 0
            par_nTamanho = 9
        ENDIF

        REPLACE expr WITH par_cTexto, fontface WITH par_cFonte, fontstyle WITH loc_nFS, fontsize WITH par_nTamanho, mode WITH 0

    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarCampo - Adiciona um campo do cursor
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarCampo
        LPARAMETERS par_cCampo, par_nBanda, par_nTop, par_nLeft, par_nWidth, par_cFonte, par_nTamanho, par_nNegrito
        LOCAL loc_nVPos, loc_nFS

        IF THIS.this_nAberto = 0
            RETURN
        ENDIF

        DO CASE
            CASE par_nBanda = 0
                loc_nVPos = THIS.this_nPosPageHeader + par_nTop
            CASE par_nBanda = 1
                loc_nVPos = THIS.this_nPosColHeader + par_nTop
            CASE par_nBanda = 4
                loc_nVPos = THIS.this_nPosDetail + par_nTop
            CASE par_nBanda = 7
                loc_nVPos = THIS.this_nPosPageFooter + par_nTop
            OTHERWISE
                loc_nVPos = par_nTop
        ENDCASE

        loc_nFS = 0
        IF VARTYPE(par_nNegrito) = "L" AND par_nNegrito
            loc_nFS = 1
        ENDIF
        IF VARTYPE(par_nNegrito) = "N" AND par_nNegrito = 1
            loc_nFS = 1
        ENDIF

        INSERT INTO frx_4c_temp (platform, uniqueid, objtype, objcode, vpos, hpos, height, width) ;
            VALUES ("WINDOWS", SYS(2015), 8, 0, loc_nVPos, par_nLeft, 0.200, par_nWidth)

        IF EMPTY(par_cFonte)
            par_cFonte = "Arial"
        ENDIF
        IF par_nTamanho = 0
            par_nTamanho = 9
        ENDIF

        REPLACE expr WITH par_cCampo, fontface WITH par_cFonte, fontstyle WITH loc_nFS, fontsize WITH par_nTamanho, mode WITH 0

    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarLinha - Adiciona uma linha horizontal
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarLinha
        LPARAMETERS par_nBanda, par_nTop, par_nLeft, par_nWidth, par_nEspessura
        LOCAL loc_nVPos

        IF THIS.this_nAberto = 0
            RETURN
        ENDIF

        DO CASE
            CASE par_nBanda = 0
                loc_nVPos = THIS.this_nPosPageHeader + par_nTop
            CASE par_nBanda = 1
                loc_nVPos = THIS.this_nPosColHeader + par_nTop
            CASE par_nBanda = 4
                loc_nVPos = THIS.this_nPosDetail + par_nTop
            CASE par_nBanda = 7
                loc_nVPos = THIS.this_nPosPageFooter + par_nTop
            OTHERWISE
                loc_nVPos = par_nTop
        ENDCASE

        INSERT INTO frx_4c_temp (platform, uniqueid, objtype, objcode, vpos, hpos, height, width) ;
            VALUES ("WINDOWS", SYS(2015), 6, 0, loc_nVPos, par_nLeft, 0.000, par_nWidth)

        IF par_nEspessura = 0
            par_nEspessura = 1
        ENDIF

        REPLACE pensize WITH par_nEspessura

    ENDPROC

    *--------------------------------------------------------------------------
    * Finalizar - Salva o cursor como tabela FRX
    *--------------------------------------------------------------------------
    PROCEDURE Finalizar
        IF THIS.this_nAberto = 1
            SELECT frx_4c_temp
            COPY TO (THIS.this_cArquivoFRX)
            USE
            THIS.this_nAberto = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY
    *--------------------------------------------------------------------------
    PROCEDURE Destroy
        THIS.Finalizar()
    ENDPROC

ENDDEFINE
