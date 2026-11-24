*==============================================================================
* GerarEtiquetasProvisorias.prg
*
* ATENCAO - ARQUIVOS PROVISORIOS, NAO SAO OS DO LEGADO.
*
* Gera os 7 arquivos de etiqueta (.lbx/.lbt) que o Formsigreipe usa em
* LABEL FORM. Os originais do sistema legado (SigMldDn, SigMld2, SigMld3,
* SigMld4, SigMld5, SigMld2C, SigMld2K) NUNCA entraram no acervo - foram
* procurados no disco inteiro e dentro do "4c (1).rar" e nao existem.
*
* O QUE ESTES ARQUIVOS SAO
*   Um bloco de endereco montado a partir das colunas que o cursor Relacao
*   ja traz, para DESTRAVAR o Visualizar e permitir testar o resto da tela:
*   ordenacao (CEP / Alfabetica / Data Nasc. x Crescente / Decrescente),
*   "Imprime Iniciais em Maiusculo", "Usar Nome de Contato se Preenchido",
*   "Imprimir Pais" e "Imprimir Codigo".
*
* O QUE ELES NAO SAO
*   NAO reproduzem a geometria fisica das etiquetas do legado. As medidas
*   abaixo sao aproximacoes a partir do NOME de cada opcao da tela; nao ha
*   no acervo nenhuma fonte para conferi-las. NAO USAR PARA IMPRIMIR EM
*   PAPEL ADESIVO - o alinhamento vai sair errado e isso nao aparece na
*   tela, so no papel. Substituir pelos arquivos reais assim que existirem:
*   basta sobrescrever os .lbx/.lbt em projeto\app\reports\.
*
* COMO RODAR
*   "C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe" ;
*       -t C:\4c\automation\GerarEtiquetasProvisorias.prg
*   Depois validar com automation\VerificarEtiquetasLbx.prg
*
* NOTAS DE FORMATO (medidas no proprio acervo)
*   .lbx tem a MESMA estrutura de um .frx (75 campos) - medido: LABEL FORM
*   aceita um arquivo em formato FRX. Unidade = 1/10000 de polegada.
*   Bandas sao objtype=9 (objcode 1=PageHeader, 4=Detail, 7=PageFooter).
*   O topo da primeira banda fica em 2083,33 (margem padrao), e o topo de
*   cada banda seguinte eh 2083,33 + soma das alturas anteriores.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE TOPO_BANDA  2083.33
#DEFINE ALT_LINHA   1458.33
#DEFINE ESQUELETO   "C:\4c\projeto\app\reports\sigrepe1.frx"
#DEFINE DESTINO     "C:\4c\projeto\app\reports\"

PUBLIC gcLogGer
gcLogGer = "C:\4c\automation\geraretiquetasprovisorias.txt"
STRTOFILE("GERACAO DE ETIQUETAS PROVISORIAS" + CHR(13) + CHR(10) + ;
          REPLICATE("=", 70) + CHR(13) + CHR(10), gcLogGer)

*-- nome | largura da etiqueta | altura da etiqueta | descricao da opcao
LOCAL ARRAY laEtq[7, 4]
laEtq[1, 1] = "SigMldDn"
laEtq[1, 2] = 25000
laEtq[1, 3] = 15000
laEtq[1, 4] = "3 Colunas"
laEtq[2, 1] = "SigMld2"
laEtq[2, 2] = 37500
laEtq[2, 3] = 13300
laEtq[2, 4] = "2 Colunas"
laEtq[3, 1] = "SigMld3"
laEtq[3, 2] = 75000
laEtq[3, 3] = 10000
laEtq[3, 4] = "9 Linhas"
laEtq[4, 1] = "SigMld4"
laEtq[4, 2] = 25000
laEtq[4, 3] = 10000
laEtq[4, 4] = "9 x 3"
laEtq[5, 1] = "SigMld5"
laEtq[5, 2] = 25000
laEtq[5, 3] = 15000
laEtq[5, 4] = "A4355"
laEtq[6, 1] = "SigMld2C"
laEtq[6, 2] = 37500
laEtq[6, 3] = 13300
laEtq[6, 4] = "2 Cols-Marg"
laEtq[7, 1] = "SigMld2K"
laEtq[7, 2] = 25000
laEtq[7, 3] = 15000
laEtq[7, 4] = "Pimaco 6181"

LOCAL lnI, lcNome, lnLarg, lnAlt, llOk
FOR lnI = 1 TO ALEN(laEtq, 1)
    lcNome = laEtq[lnI, 1]
    lnLarg = laEtq[lnI, 2]
    lnAlt  = laEtq[lnI, 3]
    llOk   = GerarUma(lcNome, lnLarg, lnAlt)
    LogGer(PADR(lcNome, 10) + PADR("(" + laEtq[lnI, 4] + ")", 16) + ;
           " " + IIF(llOk, "gerado", "FALHOU"))
ENDFOR

LogGer("")
LogGer("FIM - validar com automation\VerificarEtiquetasLbx.prg")
QUIT

*------------------------------------------------------------------------------
FUNCTION GerarUma(par_cNome, par_nLargura, par_nAltura)
    LOCAL lcAlvo, lcAlvoMemo, loErro, lnDetTopo, llResultado
    llResultado = .F.
    lcAlvo      = DESTINO + par_cNome + ".lbx"
    lcAlvoMemo  = DESTINO + par_cNome + ".lbt"

    TRY
        IF FILE(lcAlvo)
            DELETE FILE (lcAlvo)
        ENDIF
        IF FILE(lcAlvoMemo)
            DELETE FILE (lcAlvoMemo)
        ENDIF

        *-- Clona a estrutura (75 campos) de um FRX real: assim todos os
        *-- defaults de cor/fonte/flags vem corretos, sem invencao.
        USE (ESQUELETO) IN 0 ALIAS skel SHARED
        SELECT skel
        COPY TO (lcAlvo) WITH CDX
        USE IN skel

        USE (lcAlvo) IN 0 ALIAS etq EXCLUSIVE
        SELECT etq

        *-- 1) metadados do relatorio: largura = largura da etiqueta
        LOCATE FOR etq.objtype = 1
        IF FOUND()
            REPLACE etq.width WITH par_nLargura
            REPLACE etq.expr  WITH "ORIENTATION=0" + CHR(13) + CHR(10) + ;
                                   "PAPERSIZE=1"   + CHR(13) + CHR(10) + ;
                                   "COLOR=1"       + CHR(13) + CHR(10)
        ENDIF

        *-- 2) bandas: PageHeader e PageFooter zerados, Detail = altura
        LOCATE FOR etq.objtype = 9 AND etq.objcode = 1
        IF FOUND()
            REPLACE etq.height WITH 0
        ENDIF
        LOCATE FOR etq.objtype = 9 AND etq.objcode = 7
        IF FOUND()
            REPLACE etq.height WITH 0
        ENDIF
        LOCATE FOR etq.objtype = 9 AND etq.objcode = 4
        IF FOUND()
            REPLACE etq.height WITH par_nAltura
        ENDIF

        *-- 3) campos: aproveita o campo que ja existe no esqueleto como molde
        *--    (SCATTER pega os 75 defaults) e some com ele.
        LOCATE FOR etq.objtype = 8
        IF !FOUND()
            USE IN etq
            RETURN .F.
        ENDIF
        SCATTER MEMVAR MEMO
        DELETE
        PACK

        lnDetTopo = TOPO_BANDA

        *-- linha 1: nome (ja vem com Contato/PROPER aplicados pelo Processamento)
        AddCampo(lnDetTopo + 100, par_nLargura - 400, "ALLTRIM(Relacao.RClis)", "")

        *-- linha 2: logradouro, numero e complemento
        AddCampo(lnDetTopo + 100 + ALT_LINHA, par_nLargura - 400, ;
            "ALLTRIM(Relacao.Endes) + " + ;
            "IIF(EMPTY(Relacao.Nums), '', ', ' + ALLTRIM(Relacao.Nums)) + " + ;
            "IIF(EMPTY(Relacao.Compls), '', ' ' + ALLTRIM(Relacao.Compls))", "")

        *-- linha 3: bairro
        AddCampo(lnDetTopo + 100 + ALT_LINHA * 2, par_nLargura - 400, ;
            "ALLTRIM(Relacao.Bairs)", "")

        *-- linha 4: cidade / UF e CEP
        AddCampo(lnDetTopo + 100 + ALT_LINHA * 3, par_nLargura - 400, ;
            "ALLTRIM(Relacao.Cidas) + " + ;
            "IIF(EMPTY(Relacao.Estas), '', '/' + ALLTRIM(Relacao.Estas)) + " + ;
            "IIF(EMPTY(Relacao.Ceps), '', '   CEP: ' + ALLTRIM(Relacao.Ceps))", "")

        *-- linha 5: pais - so quando "Imprimir Pais" = Sim
        AddCampo(lnDetTopo + 100 + ALT_LINHA * 4, par_nLargura - 400, ;
            "ALLTRIM(Relacao.paises)", ;
            "USED('CsCabecalho') AND CsCabecalho.llImpPais AND !EMPTY(Relacao.paises)")

        *-- linha 6: codigo - so quando "Imprimir Codigo" = Sim
        AddCampo(lnDetTopo + 100 + ALT_LINHA * 5, par_nLargura - 400, ;
            "ALLTRIM(Relacao.Codigos)", ;
            "USED('CsCabecalho') AND CsCabecalho.llImpCodigos AND !EMPTY(Relacao.Codigos)")

        USE IN etq
        llResultado = FILE(lcAlvo)

    CATCH TO loErro
        LogGer("   ERRO em " + par_cNome + ": " + loErro.Message)
        IF USED("skel")
            USE IN skel
        ENDIF
        IF USED("etq")
            USE IN etq
        ENDIF
        llResultado = .F.
    ENDTRY

    RETURN llResultado
ENDFUNC

*------------------------------------------------------------------------------
* AddCampo - acrescenta um campo (objtype=8) ao arquivo aberto em "etq",
*   partindo dos defaults do molde: o SCATTER MEMVAR feito em GerarUma deixa
*   as memvars visiveis aqui (PRIVATE enxerga a pilha abaixo).
*   par_cPrintWhen vazio = imprime sempre.
*------------------------------------------------------------------------------
PROCEDURE AddCampo(par_nVpos, par_nWidth, par_cExpr, par_cPrintWhen)
    SELECT etq
    APPEND BLANK
    GATHER MEMVAR MEMO
    REPLACE etq.objtype  WITH 8
    REPLACE etq.objcode  WITH 0
    REPLACE etq.expr     WITH par_cExpr
    REPLACE etq.vpos     WITH par_nVpos
    REPLACE etq.hpos     WITH 200
    REPLACE etq.height   WITH ALT_LINHA
    REPLACE etq.width    WITH par_nWidth
    REPLACE etq.fontface WITH "Arial"
    REPLACE etq.fontsize WITH 9
    REPLACE etq.fontstyle WITH 0
    REPLACE etq.supexpr  WITH par_cPrintWhen
    REPLACE etq.uniqueid WITH "_4CETQ" + RIGHT("0000" + TRANSFORM(RECNO()), 4)
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE LogGer(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcLogGer, 1)
ENDPROC
