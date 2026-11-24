*==============================================================================
* VerificarEtiquetasLbx.prg
*
* Valida os 7 arquivos de etiqueta (.lbx/.lbt) que o Formsigreipe
* ("Impressao de Etiquetas") usa em LABEL FORM, e exercita o caminho real
* de cada um com dados de verdade.
*
* CONTEXTO (Erro383 / Erro384): os 7 layouts nunca entraram no acervo. O
* Visualizar morria em "File 'sigmld2.lbx' does not exist.". Toda a cadeia
* a montante ja esta verificada; faltava so o arquivo de layout.
*
* COMO USAR
*   1. Copiar os 14 arquivos (7 .lbx + 7 .lbt) para C:\4c\projeto\app\reports\
*      O .lbt eh o memo do .lbx - sem ele o arquivo nao abre.
*   2. Rodar:
*        "C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe" ;
*            -t C:\4c\automation\VerificarEtiquetasLbx.prg
*   3. Ler C:\4c\automation\verificaretiquetaslbx.txt
*
* O relatorio sai em 3 blocos:
*   [1] presenca   - .lbx e .lbt existem e sao alcancaveis pelo SET PATH
*   [2] estrutura  - cada .lbx abre como DBF e tem registros
*   [3] execucao   - Processamento() + LABEL FORM com os 35 registros reais
*
* O preview roda com NOWAIT so para nao travar a execucao automatica; o
* codigo de producao continua com PREVIEW puro (em LABEL FORM a clausula
* PREVIEW eh incompativel com NOCONSOLE - medido no VFP9).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcLogEtq, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcLogEtq = "C:\4c\automation\verificaretiquetaslbx.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + ;
                         CHR(92) + "verificaretiquetaslbx_dialogs.txt"
STRTOFILE("VERIFICACAO DOS ARQUIVOS DE ETIQUETA (.lbx) - Formsigreipe" + ;
          CHR(13) + CHR(10) + REPLICATE("=", 78) + CHR(13) + CHR(10), gcLogEtq)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

*-- Opcao da tela (OpColunas.Value) -> arquivo de etiqueta
*-- Conferido contra o SCX legado (task128): captions e ordem identicos.
LOCAL ARRAY laEtq[7, 3]
laEtq[1, 1] = 1   && valor em OpColunas
laEtq[1, 2] = "SigMldDn"
laEtq[1, 3] = "3 Colunas"
laEtq[2, 1] = 2
laEtq[2, 2] = "SigMld2"
laEtq[2, 3] = "2 Colunas (padrao da tela)"
laEtq[3, 1] = 3
laEtq[3, 2] = "SigMld3"
laEtq[3, 3] = "9 Linhas"
laEtq[4, 1] = 4
laEtq[4, 2] = "SigMld4"
laEtq[4, 3] = "9 x 3"
laEtq[5, 1] = 5
laEtq[5, 2] = "SigMld5"
laEtq[5, 3] = "A4355"
laEtq[6, 1] = 6
laEtq[6, 2] = "SigMld2C"
laEtq[6, 3] = "2 Cols-Marg"
laEtq[7, 1] = 8
laEtq[7, 2] = "SigMld2K"
laEtq[7, 3] = "Pimaco 6181"
*-- Termica (7) e Termica Z (9) nao usam .lbx: vao por ImprimirTermica()

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()

PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
IF gnConnHandle > 0
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 180)
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)
    IF TYPE("go_4c_Sistema") = "O"
        go_4c_Sistema.cCodEmpresa = "001"
    ENDIF
ENDIF
LogEtq("Conexao SQL ... " + IIF(gnConnHandle > 0, "OK", "FALHOU (handle=" + ;
       TRANSFORM(gnConnHandle) + ")"))
LogEtq("SET PATH tem reports? " + IIF("REPORTS" $ UPPER(SET("PATH")), "SIM", "NAO"))
LogEtq("")

*==============================================================================
* [1] PRESENCA
*==============================================================================
LOCAL lnI, lcNome, lnFaltando, llTemLbx, llTemLbt
lnFaltando = 0
LogEtq("[1] PRESENCA DOS ARQUIVOS")
LogEtq(REPLICATE("-", 78))
FOR lnI = 1 TO ALEN(laEtq, 1)
    lcNome   = laEtq[lnI, 2]
    llTemLbx = FILE(lcNome + ".lbx")
    llTemLbt = FILE(lcNome + ".lbt")
    IF !llTemLbx OR !llTemLbt
        lnFaltando = lnFaltando + 1
    ENDIF
    LogEtq("  " + PADR(lcNome, 10) + PADR("(" + laEtq[lnI, 3] + ")", 30) + ;
           " .lbx=" + IIF(llTemLbx, "OK     ", "FALTA  ") + ;
           " .lbt=" + IIF(llTemLbt, "OK", "FALTA"))
ENDFOR
LogEtq("")
LogEtq("  Faltando: " + TRANSFORM(lnFaltando) + " de " + ;
       TRANSFORM(ALEN(laEtq, 1)))
LogEtq("")

IF lnFaltando = ALEN(laEtq, 1)
    LogEtq("NENHUM arquivo encontrado - copie os .lbx/.lbt para")
    LogEtq("C:\4c\projeto\app\reports\ e rode de novo.")
    LogEtq("FIM")
    QUIT
ENDIF

*==============================================================================
* [2] ESTRUTURA - um .lbx valido abre como DBF e tem registros
*==============================================================================
LOCAL loErr
LogEtq("[2] ESTRUTURA (abre como DBF?)")
LogEtq(REPLICATE("-", 78))
FOR lnI = 1 TO ALEN(laEtq, 1)
    lcNome = laEtq[lnI, 2]
    IF !FILE(lcNome + ".lbx")
        LogEtq("  " + PADR(lcNome, 10) + " ausente - nao verificado")
        LOOP
    ENDIF
    TRY
        USE (FULLPATH(lcNome + ".lbx")) IN 0 ALIAS lbxTeste SHARED
        LogEtq("  " + PADR(lcNome, 10) + " RECCOUNT=" + ;
               PADL(TRANSFORM(RECCOUNT("lbxTeste")), 5) + ;
               "  FCOUNT=" + PADL(TRANSFORM(FCOUNT("lbxTeste")), 3) + ;
               IIF(RECCOUNT("lbxTeste") = 0, "   <<< VAZIO", ""))
        USE IN lbxTeste
    CATCH TO loErr
        LogEtq("  " + PADR(lcNome, 10) + " ERRO AO ABRIR: " + loErr.Message)
    ENDTRY
ENDFOR
LogEtq("")

*==============================================================================
* [3] EXECUCAO - caminho real com dados de verdade
*==============================================================================
LogEtq("[3] EXECUCAO COM DADOS REAIS")
LogEtq(REPLICATE("-", 78))
GarantirClasse("Formsigreipe")

LOCAL loForm, loPag, lcAntes, lcDepois, lcNovo
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormEtqValidador")
CATCH TO loErr
    LogEtq("  CREATEOBJECT falhou: " + loErr.Message)
ENDTRY

IF VARTYPE(loForm) <> "O"
    LogEtq("  Form nao instanciou - execucao nao verificada.")
    LogEtq("FIM")
    QUIT
ENDIF

SET DATASESSION TO (loForm.DataSessionId)
loPag = loForm.pgf_4c_Paginas.Page1

*-- Filtro com volume conhecido: VENDA tem 35 movimentos no periodo
loPag.txt_4c__nm_operacao.Value = "VENDA"
loPag.txt_4c__dt_inicial.Value  = DATE(2000, 1, 1)
loPag.txt_4c__dt_final.Value    = DATE(2030, 12, 31)
loPag.obj_4c_Opt_conta.Value    = 2
loForm.TxtDtFinalLostFocus()

IF !USED("cursor_4c_Operacoes") OR RECCOUNT("cursor_4c_Operacoes") = 0
    LogEtq("  A grade nao trouxe operacoes - sem dados para exercitar as")
    LogEtq("  etiquetas. Confira se SigMvCab tem movimentos de VENDA.")
    LogEtq("FIM")
    QUIT
ENDIF
SELECT cursor_4c_Operacoes
REPLACE ALL Marcas WITH 1
GO TOP
LogEtq("  Operacoes marcadas na grade: " + TRANSFORM(RECCOUNT("cursor_4c_Operacoes")))
LogEtq("")

FOR lnI = 1 TO ALEN(laEtq, 1)
    lcNome = laEtq[lnI, 2]
    IF !FILE(lcNome + ".lbx")
        LogEtq("  " + PADR(lcNome, 10) + PADR("(" + laEtq[lnI, 3] + ")", 30) + ;
               " ausente - nao executado")
        LOOP
    ENDIF
    loPag.obj_4c_OpColunas.Value = laEtq[lnI, 1]
    lcAntes = IIF(FILE(gc_4c_ArquivoErroTeste), ;
                  FILETOSTR(gc_4c_ArquivoErroTeste), "")
    loForm.RodarEtiqueta(lcNome)
    lcDepois = IIF(FILE(gc_4c_ArquivoErroTeste), ;
                   FILETOSTR(gc_4c_ArquivoErroTeste), "")
    lcNovo = IIF(LEN(lcDepois) > LEN(lcAntes), ;
                 SUBSTR(lcDepois, LEN(lcAntes) + 1), "")
    LogEtq("  " + PADR(lcNome, 10) + PADR("(" + laEtq[lnI, 3] + ")", 30) + ;
           IIF(EMPTY(lcNovo), " OK", ;
               " >>> " + STRTRAN(STRTRAN(lcNovo, CHR(13), " "), CHR(10), "")))
ENDFOR

SET DATASESSION TO 1
LogEtq("")
LogEtq("FIM")
QUIT

*------------------------------------------------------------------------------
PROCEDURE LogEtq(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcLogEtq, 1)
ENDPROC

*------------------------------------------------------------------------------
* Subclasse so para o validador: reaproveita Processamento() do form de
* producao e troca o PREVIEW bloqueante por PREVIEW NOWAIT, para a verificacao
* nao parar esperando o usuario fechar a janela.
*------------------------------------------------------------------------------
DEFINE CLASS FormEtqValidador AS Formsigreipe
    PROCEDURE RodarEtiqueta(par_cEtiqueta)
        LOCAL loErro2
        TRY
            IF THIS.Processamento() AND USED("Relacao") AND RECCOUNT("Relacao") > 0
                SELECT Relacao
                GO TOP
                DO CASE
                    CASE par_cEtiqueta == "SigMldDn"
                        LABEL FORM SigMldDn PREVIEW NOWAIT
                    CASE par_cEtiqueta == "SigMld2"
                        LABEL FORM SigMld2  PREVIEW NOWAIT
                    CASE par_cEtiqueta == "SigMld3"
                        LABEL FORM SigMld3  PREVIEW NOWAIT
                    CASE par_cEtiqueta == "SigMld4"
                        LABEL FORM SigMld4  PREVIEW NOWAIT
                    CASE par_cEtiqueta == "SigMld5"
                        LABEL FORM SigMld5  PREVIEW NOWAIT
                    CASE par_cEtiqueta == "SigMld2C"
                        LABEL FORM SigMld2C PREVIEW NOWAIT
                    CASE par_cEtiqueta == "SigMld2K"
                        LABEL FORM SigMld2K PREVIEW NOWAIT
                ENDCASE
            ELSE
                MsgErro("Processamento() nao produziu registros em Relacao.", ;
                        "Validador " + par_cEtiqueta)
            ENDIF
        CATCH TO loErro2
            MsgErro(loErro2.Message, "Validador " + par_cEtiqueta)
        ENDTRY
    ENDPROC
ENDDEFINE
