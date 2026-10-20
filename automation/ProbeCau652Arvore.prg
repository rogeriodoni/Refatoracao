*==============================================================================
* ProbeCau652Arvore.prg - Mede o ALGORITMO de montagem da arvore do
* FormSIGOPCAU (Fase 4 / task652) contra dados hierarquicos realistas de
* SigCdPrg.descricaos.
*
* POR QUE um harness separado: os nos sao escritos no ctTree.ocx por
* PROPRIEDADE PARAMETRIZADA (.NodeHeader(n) = .T., .NodeCargo(n) = ...),
* que so existe em objeto OLE - uma classe VFP nativa NAO suporta
* atribuicao a membro indexado, entao nao da para stubar o controle e
* chamar THIS.PopularArvore() direto. O laco abaixo eh a MESMA logica de
* FormSIGOPCAU.PopularArvore (incluindo ObterTextoNivel/TextoNivel),
* instrumentada para imprimir a tripla (texto, nivel, icone) de cada no.
*
* O que se quer provar:
*   (1) o laco TERMINA (o DO WHILE .t. do maketree legado tem 3 saidas; um
*       erro de transcricao viraria laco infinito e PENDURARIA a tela);
*   (2) nenhum SUBSTR com tamanho negativo (erro 11 do VFP9);
*   (3) a hierarquia sai coerente: no intermediario aparece UMA vez, folha
*       no nivel certo, icone 1/2/3 conforme o legado.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut, loc_oErro, loc_nLinha, loc_nGuarda
LOCAL loc_cDesc, loc_cDescs, loc_nNivel, loc_nPicture, loc_nUltimo
LOCAL ARRAY loc_aNivel[1]

loc_cOut = "C:\4c\automation\probe_cau652_arvore_result.txt"
STRTOFILE("INICIO", loc_cOut)

CREATE CURSOR cursor_4c_Arvore (programas C(15), parametros C(10), descricaos C(150))

*-- Ordenado por descricaos, como o ORDER BY do BO (c.descricaos, ...)
INSERT INTO cursor_4c_Arvore VALUES ("SIGCDCLI", "", "Cadastros-Clientes")
INSERT INTO cursor_4c_Arvore VALUES ("SIGCDCOR", "", "Cadastros-Produtos-Cores")
INSERT INTO cursor_4c_Arvore VALUES ("SIGCDTAM", "", "Cadastros-Produtos-Tamanhos")
INSERT INTO cursor_4c_Arvore VALUES ("SIGMVMVT", "1", "Movimentos")
INSERT INTO cursor_4c_Arvore VALUES ("SIGREVDA", "", "Relatorios-Vendas-Diario")
INSERT INTO cursor_4c_Arvore VALUES ("SIGREVDB", "", "Relatorios-Vendas-Mensal")
INSERT INTO cursor_4c_Arvore VALUES ("SIGREEST", "", "Relatorios-Estoque")
*-- casos de borda: separador no fim, separador duplo, texto sem separador
INSERT INTO cursor_4c_Arvore VALUES ("SIGBORD1", "", "Ferramentas-")
INSERT INTO cursor_4c_Arvore VALUES ("SIGBORD2", "", "Ferramentas--Backup")
INSERT INTO cursor_4c_Arvore VALUES ("SIGBORD3", "", "Sair")
*-- formato REAL do legado: separador " - " (espaco-hifen-espaco)
INSERT INTO cursor_4c_Arvore VALUES ("SIGCDGRP", "", "Cadastros - Produtos - Grupos")
INSERT INTO cursor_4c_Arvore VALUES ("SIGCDLIN", "", "Cadastros - Produtos - Linhas")
INSERT INTO cursor_4c_Arvore VALUES ("SIGREFCX", "", "Relatorios - Financeiro - Fluxo de Caixa")

loc_nGuarda = 0

TRY
    loc_aNivel[1] = ""
    SELECT cursor_4c_Arvore
    SCAN
        loc_cDesc = ALLTRIM(descricaos)
        STRTOFILE(CHR(13)+CHR(10)+"LINHA [" + loc_cDesc + "]", loc_cOut, 1)

        IF AT("-", loc_cDesc) = 0
            STRTOFILE(CHR(13)+CHR(10)+"   NO texto=[" + ALLTRIM(loc_cDesc) + ;
                      "] nivel=1 icone=1", loc_cOut, 1)
            loc_aNivel[1] = loc_cDesc
        ELSE
            IF !ISNULL(loc_cDesc)
                loc_nNivel = 1
                DO WHILE .T.
                    loc_nGuarda = loc_nGuarda + 1
                    IF loc_nGuarda > 10000
                        STRTOFILE(CHR(13)+CHR(10)+"   *** LACO INFINITO DETECTADO ***", loc_cOut, 1)
                        EXIT
                    ENDIF

                    IF ALEN(loc_aNivel) < loc_nNivel
                        DIMENSION loc_aNivel[loc_nNivel]
                        loc_aNivel[loc_nNivel] = ""
                        EXIT
                    ENDIF

                    loc_cDescs = ObterTextoNivelTeste(loc_cDesc, loc_nNivel)

                    IF VARTYPE(loc_aNivel[loc_nNivel]) = "L" AND !loc_aNivel[loc_nNivel]
                        loc_aNivel[loc_nNivel] = ""
                        EXIT
                    ENDIF

                    IF UPPER(TextoNivelTeste(loc_aNivel[loc_nNivel])) == UPPER(loc_cDescs)
                        loc_nNivel = loc_nNivel + 1
                    ELSE
                        DIMENSION loc_aNivel[loc_nNivel]
                        loc_aNivel[loc_nNivel] = ""
                        EXIT
                    ENDIF
                ENDDO

                DO WHILE AT("-", loc_cDesc, loc_nNivel) <> 0
                    loc_nGuarda = loc_nGuarda + 1
                    IF loc_nGuarda > 10000
                        STRTOFILE(CHR(13)+CHR(10)+"   *** LACO INFINITO DETECTADO ***", loc_cOut, 1)
                        EXIT
                    ENDIF

                    loc_nUltimo = ALEN(loc_aNivel)

                    IF TextoNivelTeste(loc_aNivel[loc_nUltimo]) <> ;
                       ALLTRIM(LEFT(loc_cDesc, AT("-", loc_cDesc, loc_nNivel) - 1))
                        loc_cDescs = ObterTextoNivelTeste(loc_cDesc, loc_nNivel)
                        loc_aNivel[loc_nUltimo] = loc_cDescs
                        loc_nPicture = 3
                        STRTOFILE(CHR(13)+CHR(10)+"   NO texto=[" + ALLTRIM(loc_cDescs) + ;
                                  "] nivel=" + TRANSFORM(loc_nNivel) + ;
                                  " icone=" + TRANSFORM(loc_nPicture), loc_cOut, 1)
                    ENDIF

                    loc_nNivel = loc_nNivel + 1
                    DIMENSION loc_aNivel[ALEN(loc_aNivel) + 1]
                    loc_aNivel[ALEN(loc_aNivel)] = ""
                ENDDO

                loc_aNivel[ALEN(loc_aNivel)] = ;
                    ALLTRIM(LEFT(loc_cDesc, AT("-", loc_cDesc, loc_nNivel) - 1))

                loc_cDescs   = ALLTRIM(SUBSTR(loc_cDesc, ;
                    IIF(loc_nNivel = 1, 1, AT("-", loc_cDesc, loc_nNivel - 1) + 1), ;
                    LEN(loc_cDesc)))
                loc_nPicture = IIF(loc_nNivel = 1, 1, 2)
                STRTOFILE(CHR(13)+CHR(10)+"   NO texto=[" + ALLTRIM(loc_cDescs) + ;
                          "] nivel=" + TRANSFORM(loc_nNivel) + ;
                          " icone=" + TRANSFORM(loc_nPicture) + " (folha)", loc_cOut, 1)
                loc_aNivel[loc_nNivel] = loc_cDescs
            ENDIF
        ENDIF
    ENDSCAN

    STRTOFILE(CHR(13)+CHR(10)+"ITERACOES=" + TRANSFORM(loc_nGuarda), loc_cOut, 1)
    STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo), loc_cOut, 1)
ENDTRY

QUIT

*-- Copias de FormSIGOPCAU.ObterTextoNivel / .TextoNivel
FUNCTION ObterTextoNivelTeste(par_cDesc, par_nNivel)
    LOCAL loc_nIni, loc_nFim
    loc_nIni = IIF(par_nNivel = 1, 1, AT("-", par_cDesc, par_nNivel - 1) + 1)
    loc_nFim = AT("-", par_cDesc, par_nNivel)
    IF loc_nFim = 0 OR (loc_nFim - loc_nIni - 1) <= 0
        RETURN ""
    ENDIF
    RETURN ALLTRIM(SUBSTR(par_cDesc, loc_nIni, loc_nFim - loc_nIni - 1))
ENDFUNC

FUNCTION TextoNivelTeste(par_uElemento)
    IF VARTYPE(par_uElemento) = "C"
        RETURN par_uElemento
    ENDIF
    RETURN ""
ENDFUNC
