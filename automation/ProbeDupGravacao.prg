*==============================================================================
* ProbeDupGravacao.prg - Prova de GRAVACAO de FormDup (Erro232)
*
* NAO le o codigo: faz o caminho REAL do usuario e confere no banco.
*
*   1) instancia FormDup com conexao real
*   2) BtnIncluirClick (modo INCLUIR, BO.NovoRegistro)
*   3) preenche CADA TextBox da pagina Dados com um valor DISTINTO
*      (valor distinto eh o que denuncia mapeamento TROCADO entre campos)
*   4) BtnSalvarClick -> FormParaBO -> BO.Salvar
*   5) le a linha de volta por SQLEXEC e compara coluna a coluna com o valor
*      digitado no controle que o LEGADO liga aquela coluna (ControlSource do
*      SCX), nao com o que o migrado diz
*   6) APAGA a linha de teste e confere que a tabela voltou ao estado anterior
*
* A serie de teste eh "ZZ9" e a tabela SigCnFDU estava VAZIA (0 linhas) quando
* este probe foi escrito - a limpeza do passo 6 eh conferida, nao presumida.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_dupgrav.txt"

#DEFINE OUT   "C:\4c\automation\probe_dup_gravacao.txt"
#DEFINE SERIE "ZZ9"

LOCAL loc_oForm, loc_oPg, loc_oE, loc_nI, loc_nAntes, loc_nDepois, loc_nErros
LOCAL loc_cC1, loc_cC2, loc_uC3
PUBLIC laMap
DIMENSION laMap[41, 3]

*-- ControlSource do SCX legado: objeto legado / coluna / valor de teste.
*-- Os TextBox migrados se chamam txt_4c_<nome legado>.
STORE "" TO laMap
DO CarregaMapa

STRTOFILE("=== PROBE GRAVACAO - FormDup (Erro232) ===" + CHR(13)+CHR(10), OUT)
STRTOFILE("mapa: " + TRANSFORM(ALEN(laMap,1)) + " linhas, [1,1]=" + TRANSFORM(laMap[1,1]) + " [41,2]=" + TRANSFORM(laMap[41,2]) + CHR(13)+CHR(10), OUT, 1)
loc_nErros = 0

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "DupBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormDup.prg") ADDITIVE

    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
        gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    ENDIF
    STRTOFILE("gnConnHandle = " + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)

    *-- apaga a serie de teste ANTES de medir o baseline (uma rodada anterior
    *-- pode ter deixado a linha para tras)
    = SQLEXEC(gnConnHandle, "DELETE FROM SigCnFDU WHERE series = '" + SERIE + "'", "qD")
    IF USED("qD")
        USE IN qD
    ENDIF

    *-- estado ANTES
    = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigCnFDU", "qA")
    loc_nAntes = qA.n
    USE IN qA
    STRTOFILE("linhas em SigCnFDU ANTES = " + TRANSFORM(loc_nAntes) + CHR(13)+CHR(10), OUT, 1)

    loc_oForm = CREATEOBJECT("FormDup")
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("*** FORM NAO INSTANCIOU ***" + CHR(13)+CHR(10), OUT, 1)
    ELSE
        loc_oForm.BtnIncluirClick()
        STRTOFILE("modo apos Incluir = " + loc_oForm.this_cModoAtual + CHR(13)+CHR(10), OUT, 1)

        loc_oPg = loc_oForm.pgf_4c_Paginas.Page2
        loc_oPg.txt_4c_Series.Value = SERIE

        *-- 3) preenche cada controle com valor DISTINTO
        FOR loc_nI = 1 TO ALEN(laMap, 1)
            IF EMPTY(laMap[loc_nI, 1])
                LOOP
            ENDIF
            IF !PEMSTATUS(loc_oPg, "txt_4c_" + laMap[loc_nI, 1], 5)
                STRTOFILE("  *** controle txt_4c_" + laMap[loc_nI, 1] + " NAO EXISTE" + CHR(13)+CHR(10), OUT, 1)
                loc_nErros = loc_nErros + 1
                LOOP
            ENDIF
            STORE laMap[loc_nI, 3] TO ("loc_oPg.txt_4c_" + laMap[loc_nI, 1] + ".Value")
        NEXT

        *-- 4) grava pelo caminho real
        loc_oForm.BtnSalvarClick()
        STRTOFILE("modo apos Salvar  = " + loc_oForm.this_cModoAtual + CHR(13)+CHR(10)+CHR(13)+CHR(10), OUT, 1)

        *-- 5) le de volta e confere
        IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCnFDU WHERE series = '" + SERIE + "'", "qR") < 1
            STRTOFILE("*** SELECT de volta FALHOU: " + MESSAGE() + CHR(13)+CHR(10), OUT, 1)
            loc_nErros = loc_nErros + 1
        ELSE
            IF RECCOUNT("qR") = 0
                STRTOFILE("*** NAO GRAVOU: nenhuma linha com series = " + SERIE + CHR(13)+CHR(10), OUT, 1)
                loc_nErros = loc_nErros + 1
            ELSE
                STRTOFILE("linha gravada OK - conferindo coluna a coluna:" + CHR(13)+CHR(10), OUT, 1)
                SELECT qR
                GO TOP
                FOR loc_nI = 1 TO ALEN(laMap, 1)
                    IF EMPTY(laMap[loc_nI, 1])
                        LOOP
                    ENDIF
                    loc_cC1 = laMap[loc_nI, 1]
                    loc_cC2 = laMap[loc_nI, 2]
                    loc_uC3 = laMap[loc_nI, 3]
                    loc_nErros = loc_nErros + Confere(loc_cC1, loc_cC2, loc_uC3)
                NEXT
                *-- colunas de contexto
                STRTOFILE("  cemps     = [" + ALLTRIM(TRANSFORM(qR.cemps)) + "]" + CHR(13)+CHR(10), OUT, 1)
                STRTOFILE("  cusuarios = [" + ALLTRIM(TRANSFORM(qR.cusuarios)) + "]" + CHR(13)+CHR(10), OUT, 1)
                STRTOFILE("  ddatas    = [" + TRANSFORM(qR.ddatas) + "]" + CHR(13)+CHR(10), OUT, 1)
                STRTOFILE("  choras    = [" + ALLTRIM(TRANSFORM(qR.choras)) + "]" + CHR(13)+CHR(10), OUT, 1)
            ENDIF
            USE IN qR
        ENDIF

        loc_oForm.Release()
    ENDIF

    *-- 6) limpeza e conferencia do estado final
    = SQLEXEC(gnConnHandle, "DELETE FROM SigCnFDU WHERE series = '" + SERIE + "'", "qD2")
    IF USED("qD2")
        USE IN qD2
    ENDIF
    = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigCnFDU", "qB")
    loc_nDepois = qB.n
    USE IN qB
    STRTOFILE(CHR(13)+CHR(10) + "linhas em SigCnFDU DEPOIS da limpeza = " + TRANSFORM(loc_nDepois) + ;
              IIF(loc_nDepois = loc_nAntes, "  (igual ao estado inicial - OK)", ;
              "  *** SOBROU LIXO ***") + CHR(13)+CHR(10), OUT, 1)
    IF loc_nDepois != loc_nAntes
        loc_nErros = loc_nErros + 1
    ENDIF
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ;
              ", " + loc_oE.Procedure + ")" + CHR(13)+CHR(10), OUT, 1)
    loc_nErros = loc_nErros + 1
ENDTRY

STRTOFILE(CHR(13)+CHR(10) + "=== RESULTADO: " + ;
          IIF(loc_nErros = 0, "GRAVACAO CORRETA", TRANSFORM(loc_nErros) + " PROBLEMA(S)") + ;
          " ===" + CHR(13)+CHR(10), OUT, 1)
QUIT


FUNCTION Confere(par_cCtl, par_cCol, par_uEsperado)
    LOCAL loc_uGravado, loc_lOk, loc_cL
    IF TYPE("qR." + par_cCol) = "U"
        STRTOFILE("  " + PADR(par_cCol, 12) + " *** COLUNA NAO VEIO NO SELECT" + CHR(13)+CHR(10), OUT, 1)
        RETURN 1
    ENDIF
    loc_uGravado = EVALUATE("qR." + par_cCol)
    IF VARTYPE(par_uEsperado) = "N"
        loc_lOk = (ABS(NVL(loc_uGravado, -999) - par_uEsperado) < 0.005)
    ELSE
        loc_lOk = (ALLTRIM(NVL(loc_uGravado, "")) == ALLTRIM(par_uEsperado))
    ENDIF
    loc_cL = "  " + PADR(par_cCol, 12) + " <- txt_4c_" + PADR(par_cCtl, 8) + ;
             " digitado=" + PADL(TRANSFORM(par_uEsperado), 14) + ;
             "  gravado=" + PADL(TRANSFORM(loc_uGravado), 14) + ;
             IIF(loc_lOk, "  OK", "  *** DIVERGE")
    STRTOFILE(loc_cL + CHR(13)+CHR(10), OUT, 1)
    RETURN IIF(loc_lOk, 0, 1)
ENDFUNC


PROCEDURE CarregaMapa
    *-- objeto legado, coluna (ControlSource do SCX), valor de teste DISTINTO
    laMap[1,1]="Text1"
    laMap[1,2]="nlnnotas"
    laMap[1,3]=1.25
    laMap[2,1]="Text2"
    laMap[2,2]="nclnotas"
    laMap[2,3]=2.25
    laMap[3,1]="Text3"
    laMap[3,2]="nlndtvencs"
    laMap[3,3]=3.25
    laMap[4,1]="Text4"
    laMap[4,2]="ncldtvencs"
    laMap[4,3]=4.25
    laMap[5,1]="Text5"
    laMap[5,2]="nlndtdocs"
    laMap[5,3]=5.25
    laMap[6,1]="Text6"
    laMap[6,2]="ncldtdocs"
    laMap[6,3]=6.25
    laMap[7,1]="Text7"
    laMap[7,2]="nlnnrdocs"
    laMap[7,3]=7.25
    laMap[8,1]="Text8"
    laMap[8,2]="nclnrdocs"
    laMap[8,3]=8.25
    laMap[9,1]="Text9"
    laMap[9,2]="nlnvldocs"
    laMap[9,3]=9.25
    laMap[10,1]="Text10"
    laMap[10,2]="nclvldocs"
    laMap[10,3]=10.25
    laMap[11,1]="Text11"
    laMap[11,2]="nlnestclis"
    laMap[11,3]=11.25
    laMap[12,1]="Text12"
    laMap[12,2]="nclestclis"
    laMap[12,3]=12.25
    laMap[13,1]="Text13"
    laMap[13,2]="nlnextens"
    laMap[13,3]=13.25
    laMap[14,1]="Text14"
    laMap[14,2]="nclextens"
    laMap[14,3]=14.25
    laMap[15,1]="Text15"
    laMap[15,2]="nlnrazclis"
    laMap[15,3]=15.25
    laMap[16,1]="Text16"
    laMap[16,2]="nclrazclis"
    laMap[16,3]=16.25
    laMap[17,1]="Text17"
    laMap[17,2]="nlncgcclis"
    laMap[17,3]=17.25
    laMap[18,1]="Text18"
    laMap[18,2]="nclcgcclis"
    laMap[18,3]=18.25
    laMap[19,1]="Text19"
    laMap[19,2]="nlnendcobs"
    laMap[19,3]=19.25
    laMap[20,1]="Text20"
    laMap[20,2]="nclendcobs"
    laMap[20,3]=20.25
    laMap[21,1]="Text21"
    laMap[21,2]="nlnbaicobs"
    laMap[21,3]=21.25
    laMap[22,1]="Text22"
    laMap[22,2]="nclbaicobs"
    laMap[22,3]=22.25
    laMap[23,1]="Text23"
    laMap[23,2]="nlncidcobs"
    laMap[23,3]=23.25
    laMap[24,1]="Text24"
    laMap[24,2]="nclcidcobs"
    laMap[24,3]=24.25
    laMap[25,1]="Text25"
    laMap[25,2]="nlnestcobs"
    laMap[25,3]=25.25
    laMap[26,1]="Text26"
    laMap[26,2]="nclestcobs"
    laMap[26,3]=26.25
    laMap[27,1]="Text27"
    laMap[27,2]="nlncepcobs"
    laMap[27,3]=27.25
    laMap[28,1]="Text28"
    laMap[28,2]="nclcepcobs"
    laMap[28,3]=28.25
    laMap[29,1]="Text32"
    laMap[29,2]="nlpracas"
    laMap[29,3]=29.25
    laMap[30,1]="Text33"
    laMap[30,2]="ncpracas"
    laMap[30,3]=30.25
    laMap[31,1]="Text36"
    laMap[31,2]="nlobs"
    laMap[31,3]=31.25
    laMap[32,1]="Text37"
    laMap[32,2]="ncobs"
    laMap[32,3]=32.25
    laMap[33,1]="Text41"
    laMap[33,2]="nlncods"
    laMap[33,3]=33.25
    laMap[34,1]="Text42"
    laMap[34,2]="nclcods"
    laMap[34,3]=34.25
    laMap[35,1]="Text34"
    laMap[35,2]="lnota"
    laMap[35,3]=35.25
    laMap[36,1]="Text35"
    laMap[36,2]="cnota"
    laMap[36,3]=36.25
    laMap[37,1]="Text38"
    laMap[37,2]="tamcolobs"
    laMap[37,3]=37
    laMap[38,1]="Text39"
    laMap[38,2]="tamlinobs"
    laMap[38,3]=38
    laMap[39,1]="Text31"
    laMap[39,2]="ntamfontes"
    laMap[39,3]=39
    laMap[40,1]="Text29"
    laMap[40,2]="cnomeimps"
    laMap[40,3]="IMPRESSORA_TESTE"
    laMap[41,1]="Text30"
    laMap[41,2]="cfontepdrs"
    laMap[41,3]="FONTE_TESTE"
ENDPROC
