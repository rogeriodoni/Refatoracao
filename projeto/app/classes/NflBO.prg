*==============================================================================
* NflBO.prg - Business Object de Configuracao de Nota Fiscal
* Tabela principal: SigCnFN2 (PK: cidchaves)
* Tabela auxiliar:  SigCnFNf (posicoes de colunas)
*==============================================================================

DEFINE CLASS NflBO AS BusinessBase

    *-- =========================================================================
    *-- Identificacao / chave primaria
    *-- =========================================================================
    this_cCidchaves    = ""   && char(20) PK
    this_cEmps         = ""   && char(3)  empresa
    this_cSeries       = ""   && char(3)  serie da NF

    *-- =========================================================================
    *-- Cabecalho - Destinatario (posicoes de coluna no formulario impresso)
    *-- =========================================================================
    this_cCtitent      = ""   && char(20)    titulo (ex. "Destinatario/Remetente")
    this_nLendent      = 0    && numeric(9,2) col. inicio logradouro
    this_nCendent      = 0    && numeric(9,2) col. comprimento logradouro
    this_nLbaient      = 0    && numeric(9,2) col. inicio bairro
    this_nCbaient      = 0    && numeric(9,2) col. comprimento bairro
    this_nLmunent      = 0    && numeric(9,2) col. inicio municipio
    this_nCmunent      = 0    && numeric(9,2) col. comprimento municipio
    this_nLestent      = 0    && numeric(9,2) col. inicio estado
    this_nCestent      = 0    && numeric(9,2) col. comprimento estado
    this_nLcepent      = 0    && numeric(9,2) col. inicio CEP
    this_nCcepent      = 0    && numeric(9,2) col. comprimento CEP
    this_nLfoneent     = 0    && numeric(9,2) col. inicio fone
    this_nCfoneent     = 0    && numeric(9,2) col. comprimento fone
    this_nLiniped      = 0    && numeric(9,2) col. inicio inscricao estadual
    this_nCiniped      = 0    && numeric(9,2) col. comprimento inscricao estadual
    this_nLendtite     = 0    && numeric(11,2) col. inicio endereco titulo
    this_nCendtite     = 0    && numeric(11,2) col. comprimento endereco titulo

    *-- =========================================================================
    *-- Empresa emitente (posicoes de coluna no formulario impresso)
    *-- =========================================================================
    this_nLempnome     = 0    && numeric(9,2) col. inicio nome empresa
    this_nCempnome     = 0    && numeric(9,2) col. comprimento nome empresa
    this_nLempcgc      = 0    && numeric(9,2) col. inicio CGC/CNPJ
    this_nCempcgc      = 0    && numeric(9,2) col. comprimento CGC/CNPJ
    this_nLempiest     = 0    && numeric(9,2) col. inicio insc. estadual
    this_nCempiest     = 0    && numeric(9,2) col. comprimento insc. estadual
    this_nLempender    = 0    && numeric(9,2) col. inicio endereco
    this_nCempender    = 0    && numeric(9,2) col. comprimento endereco
    this_nLempbair     = 0    && numeric(9,2) col. inicio bairro
    this_nCempbair     = 0    && numeric(9,2) col. comprimento bairro
    this_nLempmuni     = 0    && numeric(9,2) col. inicio municipio
    this_nCempmuni     = 0    && numeric(9,2) col. comprimento municipio
    this_nLempcep      = 0    && numeric(9,2) col. inicio CEP
    this_nCempcep      = 0    && numeric(9,2) col. comprimento CEP
    this_nLempesta     = 0    && numeric(9,2) col. inicio UF
    this_nCempesta     = 0    && numeric(9,2) col. comprimento UF
    this_nLempfone     = 0    && numeric(9,2) col. inicio fone
    this_nCempfone     = 0    && numeric(9,2) col. comprimento fone

    *-- =========================================================================
    *-- Configuracao geral de impressao
    *-- =========================================================================
    this_nNvias        = 0    && int          numero de vias
    this_nNtpmargems   = 0    && int          tipo de margens
    this_lVseqnota     = .F.  && bit          usa sequencia de nota
    this_cContsac      = ""   && char(20)     contador SAC
    this_nLsac         = 0    && numeric(9,2) col. inicio SAC
    this_nCsac         = 0    && numeric(9,2) col. comprimento SAC
    this_nLxinc        = 0    && numeric(9,2) col. inicio excl. inc.
    this_nCxinc        = 0    && numeric(9,2) col. comprimento excl. inc.
    this_nLenxinc      = 0    && numeric(9,2) col. extensao excl. inc.
    this_nNftgdi1s     = 0    && numeric(9,3) configuracao GDI
    this_nTotfsize     = 0    && numeric(2,0) tamanho total folha
    this_nAtnotar      = 0    && int          campo adicional nota rodape

    *-- =========================================================================
    *-- Desdobramento
    *-- =========================================================================
    this_nCopcrp       = 0    && numeric(9,2) col. posicao corpro
    this_nLopcrp       = 0    && numeric(9,2) col. largura corpro
    this_nCopcvd       = 0    && numeric(9,2) col. posicao covenda
    this_nLopcvd       = 0    && numeric(9,2) col. largura covenda
    this_nCoploc       = 0    && numeric(9,2) col. posicao local
    this_nLoploc       = 0    && numeric(9,2) col. largura local
    this_nCopnrp       = 0    && numeric(9,2) col. posicao nrpro
    this_nLopnrp       = 0    && numeric(9,2) col. largura nrpro
    this_nCopnvd       = 0    && numeric(9,2) col. posicao nvenda
    this_nLopnvd       = 0    && numeric(9,2) col. largura nvenda
    this_nLbipi        = 0    && numeric(9,2) col. inicio base IPI
    this_nCbipi        = 0    && numeric(9,2) col. comprimento base IPI

    *-- =========================================================================
    *-- Produtos - colunas aclas1..aclas7 (posicoes standard)
    *-- =========================================================================
    this_nA2nf         = 0    && int          posicao 2a NF
    this_nAclas1       = 0    && int          posicao coluna classe 1
    this_nAclas2       = 0    && int          posicao coluna classe 2
    this_nAclas3       = 0    && int          posicao coluna classe 3
    this_nAclas4       = 0    && int          posicao coluna classe 4
    this_nAclas5       = 0    && int          posicao coluna classe 5
    this_nAclas6       = 0    && int          posicao coluna classe 6
    this_nAclas7       = 0    && int          posicao coluna classe 7
    this_nAiniped      = 0    && int          posicao coluna inscr. ped.
    this_nAiniped2     = 0    && int          posicao coluna inscr. ped. 2
    this_nAnfselo      = 0    && int          posicao coluna NF selo
    this_nAobs         = 0    && int          posicao coluna observacoes
    this_nAselo        = 0    && int          posicao coluna selo

    *-- =========================================================================
    *-- Produtos - colunas adicionais aclas8..aclas12 (posicoes/larguras)
    *-- =========================================================================
    this_nAclas8       = 0    && int          posicao coluna classe 8
    this_nAclas9       = 0    && int          posicao coluna classe 9
    this_nAclas10      = 0    && int          posicao coluna classe 10
    this_nAclas11      = 0    && int          posicao coluna classe 11
    this_nAclas12      = 0    && int          posicao coluna classe 12
    this_nCclas8       = 0    && numeric(9,2) comprimento classe 8
    this_nCclas9       = 0    && numeric(9,2) comprimento classe 9
    this_nCclas10      = 0    && numeric(9,2) comprimento classe 10
    this_nCclas11      = 0    && numeric(9,2) comprimento classe 11
    this_nCclas12      = 0    && numeric(9,2) comprimento classe 12
    this_nLclas8       = 0    && numeric(9,2) inicio classe 8
    this_nLclas9       = 0    && numeric(9,2) inicio classe 9
    this_nLclas10      = 0    && numeric(9,2) inicio classe 10
    this_nLclas11      = 0    && numeric(9,2) inicio classe 11
    this_nLclas12      = 0    && numeric(9,2) inicio classe 12
    this_lImpc8        = .F.  && bit          imprimir classe 8
    this_lImpc9        = .F.  && bit          imprimir classe 9
    this_lImpc10       = .F.  && bit          imprimir classe 10
    this_lImpc11       = .F.  && bit          imprimir classe 11
    this_lImpc12       = .F.  && bit          imprimir classe 12
    this_cImpclas8     = ""   && char(10)     label coluna classe 8
    this_cImpclas9     = ""   && char(10)     label coluna classe 9
    this_cImpclas10    = ""   && char(10)     label coluna classe 10
    this_cImpclas11    = ""   && char(10)     label coluna classe 11
    this_cImpclas12    = ""   && char(10)     label coluna classe 12

    *-- =========================================================================
    *-- Impostos adicionais (ICMS-ST / CFOP substituto)
    *-- =========================================================================
    this_nLbicmss      = 0    && numeric(9,2) inicio base ICMS-ST
    this_nCbicmss      = 0    && numeric(9,2) comprimento base ICMS-ST
    this_nLvicmss      = 0    && numeric(9,2) inicio valor ICMS-ST
    this_nCvicmss      = 0    && numeric(9,2) comprimento valor ICMS-ST
    this_nLcfopsub     = 0    && numeric(9,2) inicio CFOP substituto
    this_nCcfopsub     = 0    && numeric(9,2) comprimento CFOP substituto
    this_nCcfoppro     = 0    && numeric(9,2) col. CFOP proprio
    this_nLnatopsub    = 0    && numeric(9,2) inicio nat. op. substituto
    this_nCnatopsub    = 0    && numeric(9,2) comprimento nat. op. substituto

    *-- =========================================================================
    *-- Transporte / peso
    *-- =========================================================================
    this_nCpesomet     = 0    && numeric(9,2) comprimento coluna peso liq. metro
    this_cCunipesos    = ""   && char(3)      unidade de peso

    *-- =========================================================================
    *-- Inscricao/pedido adicional
    *-- =========================================================================
    this_nLiniped2     = 0    && numeric(9,2) inicio inscr./pedido 2
    this_nCiniped2     = 0    && numeric(9,2) comprimento inscr./pedido 2

    *===========================================================================
    * Init - Inicializa Business Object
    *===========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCnFN2"
            THIS.this_cCampoChave = "CidChaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "NflBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *===========================================================================
    * Buscar - Lista configuracoes NF de SigCnFNf
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT n.emps, ISNULL(e.Razas,'') AS Razas, n.series, n.cidchaves " + ;
                       "FROM SigCnFNf n " + ;
                       "LEFT JOIN SigCdEmp e ON e.CEMPs = n.emps " + ;
                       "ORDER BY n.emps, n.series"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar lista de NF.", "NflBO.Buscar")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "NflBO.Buscar")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega SigCnFN2 por cidchaves
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT cidchaves,emps,series,ctitent," + ;
                       "lendent,cendent,lbaient,cbaient,lmunent,cmunent," + ;
                       "lestent,cestent,lcepent,ccepent,lfoneent,cfoneent," + ;
                       "liniped,ciniped,lendtite,cendtite," + ;
                       "lempnome,cempnome,lempcgc,cempcgc,lempiest,cempiest," + ;
                       "lempender,cempender,lempbair,cempbair,lempmuni,cempmuni," + ;
                       "lempcep,cempcep,lempesta,cempesta,lempfone,cempfone," + ;
                       "nvias,ntpmargems,vseqnota,contsac," + ;
                       "lsac,csac,lxinc,cxinc,lenxinc,nftgdi1s,totfsize,atnotar," + ;
                       "copcrp,lopcrp,copcvd,lopcvd,coploc,loploc," + ;
                       "copnrp,lopnrp,copnvd,lopnvd,lbipi,cbipi," + ;
                       "a2nf,aclas1,aclas2,aclas3,aclas4,aclas5,aclas6,aclas7," + ;
                       "ainiped,ainiped2,anfselo,aobs,aselo," + ;
                       "aclas8,aclas9,aclas10,aclas11,aclas12," + ;
                       "cclas8,cclas9,cclas10,cclas11,cclas12," + ;
                       "lclas8,lclas9,lclas10,lclas11,lclas12," + ;
                       "impc8,impc9,impc10,impc11,impc12," + ;
                       "impclas8,impclas9,impclas10,impclas11,impclas12," + ;
                       "lbicmss,cbicmss,lvicmss,cvicmss," + ;
                       "lcfopsub,ccfopsub,ccfoppro,lnatopsub,cnatopsub," + ;
                       "cpesomet,cunipesos,liniped2,ciniped2" + ;
                       " FROM SigCnFN2 WHERE cidchaves = " + EscaparSQL(par_cCidchaves)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Registro")
                TABLEREVERT(.T., "cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro") > 0
                IF RECCOUNT("cursor_4c_Registro") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Registro")
                ELSE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o de NF n" + CHR(227) + "o encontrada.", "NflBO.CarregarPorCodigo")
                ENDIF
            ELSE
                MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de NF.", "NflBO.CarregarPorCodigo")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "NflBO.CarregarPorCodigo")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Mapeia cursor SigCnFN2 para propriedades
    *===========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves    = ALLTRIM(cidchaves)
            THIS.this_cEmps         = ALLTRIM(emps)
            THIS.this_cSeries       = ALLTRIM(series)
            THIS.this_cCtitent      = ALLTRIM(ctitent)
            THIS.this_nLendent      = lendent
            THIS.this_nCendent      = cendent
            THIS.this_nLbaient      = lbaient
            THIS.this_nCbaient      = cbaient
            THIS.this_nLmunent      = lmunent
            THIS.this_nCmunent      = cmunent
            THIS.this_nLestent      = lestent
            THIS.this_nCestent      = cestent
            THIS.this_nLcepent      = lcepent
            THIS.this_nCcepent      = ccepent
            THIS.this_nLfoneent     = lfoneent
            THIS.this_nCfoneent     = cfoneent
            THIS.this_nLiniped      = liniped
            THIS.this_nCiniped      = ciniped
            THIS.this_nLendtite     = lendtite
            THIS.this_nCendtite     = cendtite
            THIS.this_nLempnome     = lempnome
            THIS.this_nCempnome     = cempnome
            THIS.this_nLempcgc      = lempcgc
            THIS.this_nCempcgc      = cempcgc
            THIS.this_nLempiest     = lempiest
            THIS.this_nCempiest     = cempiest
            THIS.this_nLempender    = lempender
            THIS.this_nCempender    = cempender
            THIS.this_nLempbair     = lempbair
            THIS.this_nCempbair     = cempbair
            THIS.this_nLempmuni     = lempmuni
            THIS.this_nCempmuni     = cempmuni
            THIS.this_nLempcep      = lempcep
            THIS.this_nCempcep      = cempcep
            THIS.this_nLempesta     = lempesta
            THIS.this_nCempesta     = cempesta
            THIS.this_nLempfone     = lempfone
            THIS.this_nCempfone     = cempfone
            THIS.this_nNvias        = nvias
            THIS.this_nNtpmargems   = ntpmargems
            THIS.this_lVseqnota     = (vseqnota = 1)
            THIS.this_cContsac      = ALLTRIM(contsac)
            THIS.this_nLsac         = lsac
            THIS.this_nCsac         = csac
            THIS.this_nLxinc        = lxinc
            THIS.this_nCxinc        = cxinc
            THIS.this_nLenxinc      = lenxinc
            THIS.this_nNftgdi1s     = nftgdi1s
            THIS.this_nTotfsize     = totfsize
            THIS.this_nAtnotar      = atnotar
            THIS.this_nCopcrp       = copcrp
            THIS.this_nLopcrp       = lopcrp
            THIS.this_nCopcvd       = copcvd
            THIS.this_nLopcvd       = lopcvd
            THIS.this_nCoploc       = coploc
            THIS.this_nLoploc       = loploc
            THIS.this_nCopnrp       = copnrp
            THIS.this_nLopnrp       = lopnrp
            THIS.this_nCopnvd       = copnvd
            THIS.this_nLopnvd       = lopnvd
            THIS.this_nLbipi        = lbipi
            THIS.this_nCbipi        = cbipi
            THIS.this_nA2nf         = a2nf
            THIS.this_nAclas1       = aclas1
            THIS.this_nAclas2       = aclas2
            THIS.this_nAclas3       = aclas3
            THIS.this_nAclas4       = aclas4
            THIS.this_nAclas5       = aclas5
            THIS.this_nAclas6       = aclas6
            THIS.this_nAclas7       = aclas7
            THIS.this_nAiniped      = ainiped
            THIS.this_nAiniped2     = ainiped2
            THIS.this_nAnfselo      = anfselo
            THIS.this_nAobs         = aobs
            THIS.this_nAselo        = aselo
            THIS.this_nAclas8       = aclas8
            THIS.this_nAclas9       = aclas9
            THIS.this_nAclas10      = aclas10
            THIS.this_nAclas11      = aclas11
            THIS.this_nAclas12      = aclas12
            THIS.this_nCclas8       = cclas8
            THIS.this_nCclas9       = cclas9
            THIS.this_nCclas10      = cclas10
            THIS.this_nCclas11      = cclas11
            THIS.this_nCclas12      = cclas12
            THIS.this_nLclas8       = lclas8
            THIS.this_nLclas9       = lclas9
            THIS.this_nLclas10      = lclas10
            THIS.this_nLclas11      = lclas11
            THIS.this_nLclas12      = lclas12
            THIS.this_lImpc8        = (impc8 = 1)
            THIS.this_lImpc9        = (impc9 = 1)
            THIS.this_lImpc10       = (impc10 = 1)
            THIS.this_lImpc11       = (impc11 = 1)
            THIS.this_lImpc12       = (impc12 = 1)
            THIS.this_cImpclas8     = ALLTRIM(impclas8)
            THIS.this_cImpclas9     = ALLTRIM(impclas9)
            THIS.this_cImpclas10    = ALLTRIM(impclas10)
            THIS.this_cImpclas11    = ALLTRIM(impclas11)
            THIS.this_cImpclas12    = ALLTRIM(impclas12)
            THIS.this_nLbicmss      = lbicmss
            THIS.this_nCbicmss      = cbicmss
            THIS.this_nLvicmss      = lvicmss
            THIS.this_nCvicmss      = cvicmss
            THIS.this_nLcfopsub     = lcfopsub
            THIS.this_nCcfopsub     = ccfopsub
            THIS.this_nCcfoppro     = ccfoppro
            THIS.this_nLnatopsub    = lnatopsub
            THIS.this_nCnatopsub    = cnatopsub
            THIS.this_nCpesomet     = cpesomet
            THIS.this_cCunipesos    = ALLTRIM(cunipesos)
            THIS.this_nLiniped2     = liniped2
            THIS.this_nCiniped2     = ciniped2
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro(loException, "NflBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Inserir - INSERT em SigCnFNf (defaults) e SigCnFN2 (dados completos)
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_cNovaChave
        LOCAL loc_cColsNf1, loc_cColsNf2, loc_cColsNf3, loc_cColsNf4
        LOCAL loc_cValsNf, loc_cColsN2, loc_cValsN2a, loc_cValsN2b, loc_cValsN2c
        loc_lResultado = .F.
        TRY
            loc_cNovaChave = PADR(ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cSeries), 20)
            THIS.this_cCidchaves = loc_cNovaChave

            *-- Colunas SigCnFNf em ordem esquematica (255 colunas)
            loc_cColsNf1 = "c1nf,c2nf,caicm,caipi,cbaicob,cbairr,cbicm,ccep,ccepcob,ccfop,ccgc," + ;
                           "cclas1,cclas2,cclas3,cclas4,cclas5,cclas6,cclas7,cclfis,ccodpro," + ;
                           "cdesconto,cdescser,cdespro,cdtemi,cdtemif,cdtsaidas,cdupnum," + ;
                           "cendcob,cender,cesp,cesta,cestcob," + ;
                           "cfat10num,cfat10val,cfat10vec,cfat1num,cfat1val,cfat1vec," + ;
                           "cfat2num,cfat2val,cfat2vec,cfat3num,cfat3val,cfat3vec," + ;
                           "cfat4num,cfat4val,cfat4vec,cfat5num,cfat5val,cfat5vec," + ;
                           "cfat6num,cfat6val,cfat6vec,cfat7num,cfat7val,cfat7vec," + ;
                           "cfat8num,cfat8val,cfat8vec,cfat9num,cfat9val,cfat9vec," + ;
                           "cfatnum,cfatvec,cfone,cfrete,cidchaves,ciest,cmarca,cmuncob,cmuni," + ;
                           "cnatop,cnfent,cnfsai,cnome,cnumero,cobs,cobsi,corigem,coutras," + ;
                           "cpbru,cpespro,cplaca,cplacauf,cpliq,cposfis,cqtde,cqtvol," + ;
                           "cseguro,cstrib,csufras,ctamfolhas,"
            loc_cColsNf2 = "cticm,ctipi,ctnota,ctnotaf,ctnotar,ctpfrete,ctprod,ctqtde," + ;
                           "ctrcgc,ctrend,ctrest,ctrie,ctrmun,ctrnome,cunid," + ;
                           "cvalext,cvaliss,cvalser,cvipi,cvltot,cvluni,emps,esppads," + ;
                           "fatbrutos,impc1,impc2,impc3,impc4,impc5,impc6,impc7," + ;
                           "impclas1,impclas2,impclas3,impclas4,impclas5,impclas6,impclas7,imppads," + ;
                           "l1nf,l2nf,lbaicob,lbairr,lbicm,lcendemp,lcep,lcepcob,lcfop,lcgc," + ;
                           "lclas1,lclas2,lclas3,lclas4,lclas5,lclas6,lclas7,lcrazemp,"
            loc_cColsNf3 = "ldesconto,ldescser,ldtemi,ldtemif,ldtsaidas,ldupnum," + ;
                           "lendcob,lender,lesp,lesta,lestcob,letras," + ;
                           "lfat10num,lfat10val,lfat10vec,lfat1num,lfat1val,lfat1vec," + ;
                           "lfat2num,lfat2val,lfat2vec,lfat3num,lfat3val,lfat3vec," + ;
                           "lfat4num,lfat4val,lfat4vec,lfat5num,lfat5val,lfat5vec," + ;
                           "lfat6num,lfat6val,lfat6vec,lfat7num,lfat7val,lfat7vec," + ;
                           "lfat8num,lfat8val,lfat8vec,lfat9num,lfat9val,lfat9vec," + ;
                           "lfatnum,lfatvec,lfone,lfrete,liest,linprod,lmarca,lmuncob,lmuni," + ;
                           "lnatop,lnfent,lnfsai,lnome,lnumero,lobs,loutras," + ;
                           "lpbru,lplaca,lplacauf,lpliq,lposfis,lqtvol," + ;
                           "lseguro,lsufras,lticm,ltipi,ltnota,ltnotaf,ltnotar," + ;
                           "ltpfrete,ltprod,ltqtde,ltrcgc,ltrend,ltrest,ltrie,ltrmun,ltrnome," + ;
                           "lvalext,lvaliss,lvalser,marpads,"
            loc_cColsNf4 = "ncdser,nldser,oaden,ocor,oemb,oorig,otam,pesovols,pirs,piss,series," + ;
                           "tamanhos,tamcolobs,tamcolobsi,tamdesc,tamlinobs,tamlinobsi," + ;
                           "tipos,tpcasas,lcnfselo,lcselo,vseqnota"

            *-- Valores SigCnFNf: key columns com valor real, resto = 0 ou ''
            *   Ordem exata igual ao lista de colunas acima
            loc_cValsNf = REPLICATE("0,", 66) + ;                     && cols 1-66: c1nf..cfrete
                          EscaparSQL(loc_cNovaChave) + "," + ;         && col 67: cidchaves
                          REPLICATE("0,", 24) + ;                      && cols 68-91: ciest..csufras
                          "''," + ;                                    && col 92: ctamfolhas
                          REPLICATE("0,", 21) + ;                      && cols 93-113: cticm..cvluni
                          EscaparSQL(THIS.this_cEmps) + "," + ;        && col 114: emps
                          "''," + ;                                    && col 115: esppads
                          "0," + ;                                     && col 116: fatbrutos
                          REPLICATE("0,", 7) + ;                       && cols 117-123: impc1-7
                          "'','','','','','','',''," + ;               && cols 124-131: impclas1-7,imppads
                          REPLICATE("0,", 5) + ;                       && cols 132-136: l1nf-lbicm
                          "''," + ;                                    && col 137: lcendemp
                          REPLICATE("0,", 11) + ;                      && cols 138-148: lcep-lclas7
                          "''," + ;                                    && col 149: lcrazemp
                          REPLICATE("0,", 44) + ;                      && cols 150-193: ldesconto-lfatvec
                          REPLICATE("0,", 39) + ;                      && cols 194-232: lfone-lvalser
                          "''," + ;                                    && col 233: marpads
                          REPLICATE("0,", 10) + ;                      && cols 234-243: ncdser-piss
                          EscaparSQL(THIS.this_cSeries) + "," + ;      && col 244: series
                          REPLICATE("0,", 6) + ;                       && cols 245-250: tamanhos-tamlinobsi
                          "''," + ;                                    && col 251: tipos
                          "0," + ;                                     && col 252: tpcasas
                          "'','',0"                                    && cols 253-255: lcnfselo,lcselo,vseqnota

            loc_cSQL = "INSERT INTO SigCnFNf (" + ;
                       loc_cColsNf1 + loc_cColsNf2 + loc_cColsNf3 + loc_cColsNf4 + ") " + ;
                       "VALUES (" + loc_cValsNf + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                MsgErro("Erro ao inserir cabe" + CHR(231) + "alho de NF.", "NflBO.Inserir")
            ELSE
                *-- Colunas SigCnFN2 (113 colunas)
                loc_cColsN2 = "cidchaves,emps,series,ctitent," + ;
                              "lendent,cendent,lbaient,cbaient,lmunent,cmunent," + ;
                              "lestent,cestent,lcepent,ccepent,lfoneent,cfoneent," + ;
                              "liniped,ciniped,lendtite,cendtite," + ;
                              "lempnome,cempnome,lempcgc,cempcgc,lempiest,cempiest," + ;
                              "lempender,cempender,lempbair,cempbair,lempmuni,cempmuni," + ;
                              "lempcep,cempcep,lempesta,cempesta,lempfone,cempfone," + ;
                              "nvias,ntpmargems,vseqnota,contsac," + ;
                              "lsac,csac,lxinc,cxinc,lenxinc,nftgdi1s,totfsize,atnotar," + ;
                              "copcrp,lopcrp,copcvd,lopcvd,coploc,loploc," + ;
                              "copnrp,lopnrp,copnvd,lopnvd,lbipi,cbipi," + ;
                              "a2nf,aclas1,aclas2,aclas3,aclas4,aclas5,aclas6,aclas7," + ;
                              "ainiped,ainiped2,anfselo,aobs,aselo," + ;
                              "aclas8,aclas9,aclas10,aclas11,aclas12," + ;
                              "cclas8,cclas9,cclas10,cclas11,cclas12," + ;
                              "lclas8,lclas9,lclas10,lclas11,lclas12," + ;
                              "impc8,impc9,impc10,impc11,impc12," + ;
                              "impclas8,impclas9,impclas10,impclas11,impclas12," + ;
                              "lbicmss,cbicmss,lvicmss,cvicmss," + ;
                              "lcfopsub,ccfopsub,ccfoppro,lnatopsub,cnatopsub," + ;
                              "cpesomet,cunipesos,liniped2,ciniped2"
                *-- Valores SigCnFN2
                loc_cValsN2a = EscaparSQL(THIS.this_cCidchaves) + "," + ;
                               EscaparSQL(THIS.this_cEmps) + "," + ;
                               EscaparSQL(THIS.this_cSeries) + "," + ;
                               EscaparSQL(THIS.this_cCtitent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLendent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCendent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLbaient) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCbaient) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLmunent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCmunent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLestent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCestent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLcepent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCcepent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLfoneent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCfoneent) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLiniped) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCiniped) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLendtite) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCendtite) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLempnome) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCempnome) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLempcgc) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCempcgc) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLempiest) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCempiest) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLempender) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCempender) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLempbair) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCempbair) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLempmuni) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCempmuni) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLempcep) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCempcep) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLempesta) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCempesta) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLempfone) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCempfone) + "," + ;
                               FormatarNumeroSQL(THIS.this_nNvias) + "," + ;
                               FormatarNumeroSQL(THIS.this_nNtpmargems) + "," + ;
                               IIF(THIS.this_lVseqnota, "1", "0") + "," + ;
                               EscaparSQL(THIS.this_cContsac) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLsac) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCsac) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLxinc) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCxinc) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLenxinc) + "," + ;
                               FormatarNumeroSQL(THIS.this_nNftgdi1s) + "," + ;
                               FormatarNumeroSQL(THIS.this_nTotfsize) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAtnotar) + ","
                loc_cValsN2b = FormatarNumeroSQL(THIS.this_nCopcrp) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLopcrp) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCopcvd) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLopcvd) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCoploc) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLoploc) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCopnrp) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLopnrp) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCopnvd) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLopnvd) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLbipi) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCbipi) + "," + ;
                               FormatarNumeroSQL(THIS.this_nA2nf) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas1) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas2) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas3) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas4) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas5) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas6) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas7) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAiniped) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAiniped2) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAnfselo) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAobs) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAselo) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas8) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas9) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas10) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas11) + "," + ;
                               FormatarNumeroSQL(THIS.this_nAclas12) + ","
                loc_cValsN2c = FormatarNumeroSQL(THIS.this_nCclas8) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCclas9) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCclas10) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCclas11) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCclas12) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLclas8) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLclas9) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLclas10) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLclas11) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLclas12) + "," + ;
                               IIF(THIS.this_lImpc8,  "1", "0") + "," + ;
                               IIF(THIS.this_lImpc9,  "1", "0") + "," + ;
                               IIF(THIS.this_lImpc10, "1", "0") + "," + ;
                               IIF(THIS.this_lImpc11, "1", "0") + "," + ;
                               IIF(THIS.this_lImpc12, "1", "0") + "," + ;
                               EscaparSQL(THIS.this_cImpclas8)  + "," + ;
                               EscaparSQL(THIS.this_cImpclas9)  + "," + ;
                               EscaparSQL(THIS.this_cImpclas10) + "," + ;
                               EscaparSQL(THIS.this_cImpclas11) + "," + ;
                               EscaparSQL(THIS.this_cImpclas12) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLbicmss)   + "," + ;
                               FormatarNumeroSQL(THIS.this_nCbicmss)   + "," + ;
                               FormatarNumeroSQL(THIS.this_nLvicmss)   + "," + ;
                               FormatarNumeroSQL(THIS.this_nCvicmss)   + "," + ;
                               FormatarNumeroSQL(THIS.this_nLcfopsub)  + "," + ;
                               FormatarNumeroSQL(THIS.this_nCcfopsub)  + "," + ;
                               FormatarNumeroSQL(THIS.this_nCcfoppro)  + "," + ;
                               FormatarNumeroSQL(THIS.this_nLnatopsub) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCnatopsub) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCpesomet)  + "," + ;
                               EscaparSQL(THIS.this_cCunipesos) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLiniped2)  + "," + ;
                               FormatarNumeroSQL(THIS.this_nCiniped2)

                loc_cSQL = "INSERT INTO SigCnFN2 (" + loc_cColsN2 + ") VALUES (" + ;
                           loc_cValsN2a + loc_cValsN2b + loc_cValsN2c + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    SQLEXEC(gnConnHandle, "DELETE FROM SigCnFNf WHERE cidchaves = " + EscaparSQL(loc_cNovaChave))
                    MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de NF.", "NflBO.Inserir")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "NflBO.Inserir")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Atualizar - UPDATE em SigCnFN2 com todos os campos (exceto cidchaves)
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_cSeta, loc_cSetb, loc_cSetc, loc_cWhere
        loc_lResultado = .F.
        TRY
            loc_cWhere = " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_cSeta = "UPDATE SigCnFN2 SET " + ;
                        "emps = " + EscaparSQL(THIS.this_cEmps) + "," + ;
                        "series = " + EscaparSQL(THIS.this_cSeries) + "," + ;
                        "ctitent = " + EscaparSQL(THIS.this_cCtitent) + "," + ;
                        "lendent = " + FormatarNumeroSQL(THIS.this_nLendent) + "," + ;
                        "cendent = " + FormatarNumeroSQL(THIS.this_nCendent) + "," + ;
                        "lbaient = " + FormatarNumeroSQL(THIS.this_nLbaient) + "," + ;
                        "cbaient = " + FormatarNumeroSQL(THIS.this_nCbaient) + "," + ;
                        "lmunent = " + FormatarNumeroSQL(THIS.this_nLmunent) + "," + ;
                        "cmunent = " + FormatarNumeroSQL(THIS.this_nCmunent) + "," + ;
                        "lestent = " + FormatarNumeroSQL(THIS.this_nLestent) + "," + ;
                        "cestent = " + FormatarNumeroSQL(THIS.this_nCestent) + "," + ;
                        "lcepent = " + FormatarNumeroSQL(THIS.this_nLcepent) + "," + ;
                        "ccepent = " + FormatarNumeroSQL(THIS.this_nCcepent) + "," + ;
                        "lfoneent = " + FormatarNumeroSQL(THIS.this_nLfoneent) + "," + ;
                        "cfoneent = " + FormatarNumeroSQL(THIS.this_nCfoneent) + "," + ;
                        "liniped = " + FormatarNumeroSQL(THIS.this_nLiniped) + "," + ;
                        "ciniped = " + FormatarNumeroSQL(THIS.this_nCiniped) + "," + ;
                        "lendtite = " + FormatarNumeroSQL(THIS.this_nLendtite) + "," + ;
                        "cendtite = " + FormatarNumeroSQL(THIS.this_nCendtite) + "," + ;
                        "lempnome = " + FormatarNumeroSQL(THIS.this_nLempnome) + "," + ;
                        "cempnome = " + FormatarNumeroSQL(THIS.this_nCempnome) + "," + ;
                        "lempcgc = " + FormatarNumeroSQL(THIS.this_nLempcgc) + "," + ;
                        "cempcgc = " + FormatarNumeroSQL(THIS.this_nCempcgc) + "," + ;
                        "lempiest = " + FormatarNumeroSQL(THIS.this_nLempiest) + "," + ;
                        "cempiest = " + FormatarNumeroSQL(THIS.this_nCempiest) + "," + ;
                        "lempender = " + FormatarNumeroSQL(THIS.this_nLempender) + "," + ;
                        "cempender = " + FormatarNumeroSQL(THIS.this_nCempender) + "," + ;
                        "lempbair = " + FormatarNumeroSQL(THIS.this_nLempbair) + "," + ;
                        "cempbair = " + FormatarNumeroSQL(THIS.this_nCempbair) + "," + ;
                        "lempmuni = " + FormatarNumeroSQL(THIS.this_nLempmuni) + "," + ;
                        "cempmuni = " + FormatarNumeroSQL(THIS.this_nCempmuni) + "," + ;
                        "lempcep = " + FormatarNumeroSQL(THIS.this_nLempcep) + "," + ;
                        "cempcep = " + FormatarNumeroSQL(THIS.this_nCempcep) + "," + ;
                        "lempesta = " + FormatarNumeroSQL(THIS.this_nLempesta) + "," + ;
                        "cempesta = " + FormatarNumeroSQL(THIS.this_nCempesta) + "," + ;
                        "lempfone = " + FormatarNumeroSQL(THIS.this_nLempfone) + "," + ;
                        "cempfone = " + FormatarNumeroSQL(THIS.this_nCempfone) + ","
            loc_cSetb = "nvias = " + FormatarNumeroSQL(THIS.this_nNvias) + "," + ;
                        "ntpmargems = " + FormatarNumeroSQL(THIS.this_nNtpmargems) + "," + ;
                        "vseqnota = " + IIF(THIS.this_lVseqnota, "1", "0") + "," + ;
                        "contsac = " + EscaparSQL(THIS.this_cContsac) + "," + ;
                        "lsac = " + FormatarNumeroSQL(THIS.this_nLsac) + "," + ;
                        "csac = " + FormatarNumeroSQL(THIS.this_nCsac) + "," + ;
                        "lxinc = " + FormatarNumeroSQL(THIS.this_nLxinc) + "," + ;
                        "cxinc = " + FormatarNumeroSQL(THIS.this_nCxinc) + "," + ;
                        "lenxinc = " + FormatarNumeroSQL(THIS.this_nLenxinc) + "," + ;
                        "nftgdi1s = " + FormatarNumeroSQL(THIS.this_nNftgdi1s) + "," + ;
                        "totfsize = " + FormatarNumeroSQL(THIS.this_nTotfsize) + "," + ;
                        "atnotar = " + FormatarNumeroSQL(THIS.this_nAtnotar) + "," + ;
                        "copcrp = " + FormatarNumeroSQL(THIS.this_nCopcrp) + "," + ;
                        "lopcrp = " + FormatarNumeroSQL(THIS.this_nLopcrp) + "," + ;
                        "copcvd = " + FormatarNumeroSQL(THIS.this_nCopcvd) + "," + ;
                        "lopcvd = " + FormatarNumeroSQL(THIS.this_nLopcvd) + "," + ;
                        "coploc = " + FormatarNumeroSQL(THIS.this_nCoploc) + "," + ;
                        "loploc = " + FormatarNumeroSQL(THIS.this_nLoploc) + "," + ;
                        "copnrp = " + FormatarNumeroSQL(THIS.this_nCopnrp) + "," + ;
                        "lopnrp = " + FormatarNumeroSQL(THIS.this_nLopnrp) + "," + ;
                        "copnvd = " + FormatarNumeroSQL(THIS.this_nCopnvd) + "," + ;
                        "lopnvd = " + FormatarNumeroSQL(THIS.this_nLopnvd) + "," + ;
                        "lbipi = " + FormatarNumeroSQL(THIS.this_nLbipi) + "," + ;
                        "cbipi = " + FormatarNumeroSQL(THIS.this_nCbipi) + "," + ;
                        "a2nf = " + FormatarNumeroSQL(THIS.this_nA2nf) + "," + ;
                        "aclas1 = " + FormatarNumeroSQL(THIS.this_nAclas1) + "," + ;
                        "aclas2 = " + FormatarNumeroSQL(THIS.this_nAclas2) + "," + ;
                        "aclas3 = " + FormatarNumeroSQL(THIS.this_nAclas3) + "," + ;
                        "aclas4 = " + FormatarNumeroSQL(THIS.this_nAclas4) + "," + ;
                        "aclas5 = " + FormatarNumeroSQL(THIS.this_nAclas5) + "," + ;
                        "aclas6 = " + FormatarNumeroSQL(THIS.this_nAclas6) + "," + ;
                        "aclas7 = " + FormatarNumeroSQL(THIS.this_nAclas7) + "," + ;
                        "ainiped = " + FormatarNumeroSQL(THIS.this_nAiniped) + "," + ;
                        "ainiped2 = " + FormatarNumeroSQL(THIS.this_nAiniped2) + "," + ;
                        "anfselo = " + FormatarNumeroSQL(THIS.this_nAnfselo) + "," + ;
                        "aobs = " + FormatarNumeroSQL(THIS.this_nAobs) + "," + ;
                        "aselo = " + FormatarNumeroSQL(THIS.this_nAselo) + "," + ;
                        "aclas8 = " + FormatarNumeroSQL(THIS.this_nAclas8) + "," + ;
                        "aclas9 = " + FormatarNumeroSQL(THIS.this_nAclas9) + "," + ;
                        "aclas10 = " + FormatarNumeroSQL(THIS.this_nAclas10) + "," + ;
                        "aclas11 = " + FormatarNumeroSQL(THIS.this_nAclas11) + "," + ;
                        "aclas12 = " + FormatarNumeroSQL(THIS.this_nAclas12) + ","
            loc_cSetc = "cclas8 = " + FormatarNumeroSQL(THIS.this_nCclas8) + "," + ;
                        "cclas9 = " + FormatarNumeroSQL(THIS.this_nCclas9) + "," + ;
                        "cclas10 = " + FormatarNumeroSQL(THIS.this_nCclas10) + "," + ;
                        "cclas11 = " + FormatarNumeroSQL(THIS.this_nCclas11) + "," + ;
                        "cclas12 = " + FormatarNumeroSQL(THIS.this_nCclas12) + "," + ;
                        "lclas8 = " + FormatarNumeroSQL(THIS.this_nLclas8) + "," + ;
                        "lclas9 = " + FormatarNumeroSQL(THIS.this_nLclas9) + "," + ;
                        "lclas10 = " + FormatarNumeroSQL(THIS.this_nLclas10) + "," + ;
                        "lclas11 = " + FormatarNumeroSQL(THIS.this_nLclas11) + "," + ;
                        "lclas12 = " + FormatarNumeroSQL(THIS.this_nLclas12) + "," + ;
                        "impc8 = " + IIF(THIS.this_lImpc8,  "1", "0") + "," + ;
                        "impc9 = " + IIF(THIS.this_lImpc9,  "1", "0") + "," + ;
                        "impc10 = " + IIF(THIS.this_lImpc10, "1", "0") + "," + ;
                        "impc11 = " + IIF(THIS.this_lImpc11, "1", "0") + "," + ;
                        "impc12 = " + IIF(THIS.this_lImpc12, "1", "0") + "," + ;
                        "impclas8 = " + EscaparSQL(THIS.this_cImpclas8) + "," + ;
                        "impclas9 = " + EscaparSQL(THIS.this_cImpclas9) + "," + ;
                        "impclas10 = " + EscaparSQL(THIS.this_cImpclas10) + "," + ;
                        "impclas11 = " + EscaparSQL(THIS.this_cImpclas11) + "," + ;
                        "impclas12 = " + EscaparSQL(THIS.this_cImpclas12) + "," + ;
                        "lbicmss = " + FormatarNumeroSQL(THIS.this_nLbicmss) + "," + ;
                        "cbicmss = " + FormatarNumeroSQL(THIS.this_nCbicmss) + "," + ;
                        "lvicmss = " + FormatarNumeroSQL(THIS.this_nLvicmss) + "," + ;
                        "cvicmss = " + FormatarNumeroSQL(THIS.this_nCvicmss) + "," + ;
                        "lcfopsub = " + FormatarNumeroSQL(THIS.this_nLcfopsub) + "," + ;
                        "ccfopsub = " + FormatarNumeroSQL(THIS.this_nCcfopsub) + "," + ;
                        "ccfoppro = " + FormatarNumeroSQL(THIS.this_nCcfoppro) + "," + ;
                        "lnatopsub = " + FormatarNumeroSQL(THIS.this_nLnatopsub) + "," + ;
                        "cnatopsub = " + FormatarNumeroSQL(THIS.this_nCnatopsub) + "," + ;
                        "cpesomet = " + FormatarNumeroSQL(THIS.this_nCpesomet) + "," + ;
                        "cunipesos = " + EscaparSQL(THIS.this_cCunipesos) + "," + ;
                        "liniped2 = " + FormatarNumeroSQL(THIS.this_nLiniped2) + "," + ;
                        "ciniped2 = " + FormatarNumeroSQL(THIS.this_nCiniped2)

            loc_cSQL = loc_cSeta + loc_cSetb + loc_cSetc + loc_cWhere
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de NF.", "NflBO.Atualizar")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "NflBO.Atualizar")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - DELETE em SigCnFN2 e SigCnFNf por cidchaves
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cWhere
        loc_lResultado = .F.
        TRY
            loc_cWhere = " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            IF SQLEXEC(gnConnHandle, "DELETE FROM SigCnFN2" + loc_cWhere) > 0
                IF SQLEXEC(gnConnHandle, "DELETE FROM SigCnFNf" + loc_cWhere) > 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir cabe" + CHR(231) + "alho de NF.", "NflBO.ExecutarExclusao")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de NF.", "NflBO.ExecutarExclusao")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "NflBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * SalvarSigCnFNf - Persiste cursor crSigCnFNf em SigCnFNf via UPDATE dinamico
    *===========================================================================
    FUNCTION SalvarSigCnFNf()
        LOCAL loc_lResultado, loc_cSQL, loc_cSet, loc_cType, loc_cVal, loc_cField
        LOCAL loc_nI, loc_nTotal
        loc_lResultado = .F.
        TRY
            IF USED("crSigCnFNf") AND RECCOUNT("crSigCnFNf") > 0
                SELECT crSigCnFNf
                loc_cSet   = ""
                loc_nTotal = FCOUNT("crSigCnFNf")
                FOR loc_nI = 1 TO loc_nTotal
                    loc_cField = LOWER(FIELD(loc_nI, "crSigCnFNf"))
                    IF loc_cField = "cidchaves"
                        LOOP
                    ENDIF
                    loc_cType = VARTYPE(EVALUATE(loc_cField))
                    DO CASE
                        CASE loc_cType = "C"
                            loc_cVal = EscaparSQL(ALLTRIM(EVALUATE(loc_cField)))
                        CASE loc_cType = "N"
                            loc_cVal = FormatarNumeroSQL(EVALUATE(loc_cField))
                        CASE loc_cType = "L"
                            loc_cVal = IIF(EVALUATE(loc_cField), "1", "0")
                        OTHERWISE
                            loc_cVal = ""
                    ENDCASE
                    IF !EMPTY(loc_cVal)
                        loc_cSet = loc_cSet + loc_cField + "=" + loc_cVal + ","
                    ENDIF
                ENDFOR
                IF !EMPTY(loc_cSet)
                    loc_cSet = LEFT(loc_cSet, LEN(loc_cSet) - 1)
                    loc_cSQL = "UPDATE SigCnFNf SET " + loc_cSet + ;
                               " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
                    IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao salvar posi" + CHR(231) + CHR(245) + "es de NF.", ;
                                "NflBO.SalvarSigCnFNf")
                    ENDIF
                ELSE
                    loc_lResultado = .T.
                ENDIF
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "NflBO.SalvarSigCnFNf")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
