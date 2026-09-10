*==============================================================================
* popular_sigcdfs_teste.prg
*
* Popula SigCdFs (motivos de desconto/acrescimo) com linhas de TESTE, para que
* a grade de motivos do FormCco "Cadastro de Classificacao de Contas" tenha o
* que exibir. Sem isso a grade abre vazia por falta de dado, nao por defeito de
* codigo (Erro158).
*
* ATENCAO: o banco DB_MBAHIA tem DADO REAL (1.504 clientes, 162 tabelas
* populadas). As linhas abaixo sao FABRICADAS por nao existir dump de origem
* do SigCdFs. Elas aparecerao tambem no cadastro FormMda (SigCdMda) e no
* FormDCC para todos que usam este ambiente - por isso vao com prefixo TESTE
* no codigo e na descricao, e ha o rollback em despopular_sigcdfs_teste.prg.
*
* Semantica dos campos (do cadastro legado SIGCDMDA):
*   tipos    char(1)      "D" = Desconto, "A" = Acrescimo (GetTipos.Valid)
*   tpdescs  numeric(1,0) 1 = Geral, 2 = por Produto (OptTpDescs)
*   limdescs numeric(5,2) limite de desconto em %
*   ggrus    char(3)      grupo    | sgrus char(6) subgrupo
*   blqbonus/blqtabds/chkbins/chkdtanivs numeric(1,0) flags
*   perinis/perfins datetime NULL   vigencia
*
* Uso: DO popular_sigcdfs_teste.prg
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

=SQLSETPROP(0, "ConnectTimeOut", 20)
=SQLSETPROP(0, "DispLogin", 3)
=SQLSETPROP(0, "DispWarnings", .F.)

lnH = SQLSTRINGCONNECT("Driver={SQL Server};Server=192.168.200.10;" + ;
                       "Database=DB_MBAHIA;Uid=4control;Pwd=f2016jstcr%@;")
IF lnH <= 0
    MsgErro("Nao foi possivel conectar ao banco.", "Popular SigCdFs")
    RETURN
ENDIF

*-- guard: nao roda duas vezes nem por cima de dado real
IF SQLEXEC(lnH, "SELECT COUNT(*) AS qtd FROM SigCdFs", "cChk") < 0
    MsgErro("Falha ao consultar SigCdFs.", "Popular SigCdFs")
    =SQLDISCONNECT(lnH)
    RETURN
ENDIF
lnJa = cChk.qtd
USE IN cChk
IF lnJa > 0
    MsgAviso("SigCdFs ja tem " + TRANSFORM(lnJa) + " linha(s). Nada foi feito." + CHR(13) + ;
             "Rode despopular_sigcdfs_teste.prg antes, se quiser recriar.", "Popular SigCdFs")
    =SQLDISCONNECT(lnH)
    RETURN
ENDIF

*-- codigo | descricao | tipo (D/A) | tpdescs (1=Geral,2=Produto) | limite %
DIMENSION laFs[6, 5]
laFs[1,1] = "TESTE01"
laFs[1,2] = "TESTE - Desconto Promocional"
laFs[1,3] = "D"
laFs[1,4] = 1
laFs[1,5] = 10.00

laFs[2,1] = "TESTE02"
laFs[2,2] = "TESTE - Desconto Fidelidade"
laFs[2,3] = "D"
laFs[2,4] = 1
laFs[2,5] = 5.00

laFs[3,1] = "TESTE03"
laFs[3,2] = "TESTE - Desconto por Produto"
laFs[3,3] = "D"
laFs[3,4] = 2
laFs[3,5] = 15.00

laFs[4,1] = "TESTE04"
laFs[4,2] = "TESTE - Acrescimo Financeiro"
laFs[4,3] = "A"
laFs[4,4] = 1
laFs[4,5] = 0.00

laFs[5,1] = "TESTE05"
laFs[5,2] = "TESTE - Acrescimo por Frete"
laFs[5,3] = "A"
laFs[5,4] = 1
laFs[5,5] = 0.00

laFs[6,1] = "TESTE06"
laFs[6,2] = "TESTE - Desconto Avaria"
laFs[6,3] = "D"
laFs[6,4] = 2
laFs[6,5] = 20.00

lnOk  = 0
lnErr = 0

FOR i = 1 TO ALEN(laFs, 1)
    lcSQL = "INSERT INTO SigCdFs" + ;
            " (codigos, descrs, tipos, blqbonus, blqtabds, chkbins," + ;
            "  chkdtanivs, ggrus, limdescs, perfins, perinis, sgrus, tpdescs)" + ;
            " VALUES (" + ;
            "'" + laFs[i,1] + "'," + ;
            "'" + laFs[i,2] + "'," + ;
            "'" + laFs[i,3] + "'," + ;
            "0, 0, 0, 0, '', " + ;
            TRANSFORM(laFs[i,5]) + ", NULL, NULL, '', " + ;
            TRANSFORM(laFs[i,4]) + ")"

    IF SQLEXEC(lnH, lcSQL) >= 0
        lnOk = lnOk + 1
    ELSE
        lnErr = lnErr + 1
        MsgErro("Falha ao inserir " + laFs[i,1] + ":" + CHR(13) + CapturarErroSQL(), "Popular SigCdFs")
    ENDIF
ENDFOR

=SQLDISCONNECT(lnH)

MsgInfo("SigCdFs populada com linhas de TESTE." + CHR(13) + ;
        "Inseridas: " + TRANSFORM(lnOk) + "   Falhas: " + TRANSFORM(lnErr) + CHR(13) + CHR(13) + ;
        "Para reverter: DO despopular_sigcdfs_teste.prg", "Popular SigCdFs")
