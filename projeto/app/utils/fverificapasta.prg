*==============================================================================
* fverificapasta.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* frmrelatorio.DocumentoExcel (framework.vcx) protege a gravacao do arquivo com:
*
*     lcExl = thisform.pcarqemail
*     If fVerificaPasta(lcExl, 2)
*         If (Lower(Alltrim(JustExt(lcExl))) = [xls])
*             Copy To (lcExl) Type Xl5
*         Else
*             Copy To (lcExl) Delimited With '' With Character ';'
*         EndIf
*     Else
*         llErr = .t.
*     EndIf
*
* Sem o arquivo o VFP procura 'fverificapasta.prg' no PATH e estoura
*
*     File 'fverificapasta.prg' does not exist.
*
* ao exportar relatorio para Excel/TXT. Familia de isempty.prg / fconfiggeral.prg.
*
* CONTRATO, LIDO DO CALL SITE
* ---------------------------
* Recebe o caminho COMPLETO do arquivo que esta prestes a ser gravado e devolve
* LOGICO: .T. = pode gravar ali, .F. = nao pode (e o chamador marca erro). O
* `On Error llErr = .t.` que cerca o bloco cuida da falha do proprio Copy To -
* esta funcao so responde pela PASTA.
*
* O 2o argumento (2) eh IGNORADO. O fonte legado nao veio no acervo e o unico
* call site sempre passa 2, entao nao ha como saber o que os outros modos
* faziam. Inventar um significado para ele seria pior que ignora-lo: mudaria o
* comportamento do unico caso que se conhece. Se algum dia aparecer chamada com
* outro valor, ESTE comentario eh o aviso de que o modo nao esta implementado.
*
* Regra #13 do CLAUDE.md: em codigo NOSSO use DIRECTORY()/MD direto.
*
* Origem: Erro163_Aba1 (2026-09-18).
*==============================================================================
LPARAMETERS par_cArquivo, par_nModo

LOCAL loc_cPasta, loc_lOk, loc_oErro

loc_lOk = .F.

IF VARTYPE(par_cArquivo) <> "C" OR EMPTY(par_cArquivo)
    RETURN .F.
ENDIF

loc_cPasta = JUSTPATH(ALLTRIM(par_cArquivo))

*-- Arquivo sem caminho grava no diretorio corrente, que existe por definicao
IF EMPTY(loc_cPasta)
    RETURN .T.
ENDIF

TRY
    IF DIRECTORY(loc_cPasta)
        loc_lOk = .T.
    ELSE
        MD (loc_cPasta)
        loc_lOk = DIRECTORY(loc_cPasta)
    ENDIF
CATCH TO loc_oErro
    *-- SEM MsgErro (excecao consciente a regra #9, como em fsqlexec.prg): o
    *-- chamador ja trata o .F. via llErr. Rastro em log.
    IF TYPE("gc_4c_CaminhoBase") = "C"
        STRTOFILE("[" + TTOC(DATETIME()) + "] " + loc_oErro.Message + ;
                  "  pasta: " + loc_cPasta + CHR(13) + CHR(10), ;
                  ADDBS(gc_4c_CaminhoBase) + "fVerificaPasta_Erro.log", 1)
    ENDIF
    loc_lOk = .F.
ENDTRY

RETURN loc_lOk
