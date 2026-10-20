*==============================================================================
* ProbePpp666F4b.prg - Caminho FELIZ da carga da Fase 4 (task666).
*
* O ProbePpp666F4 provou que a tela ABRE e que a carga recusa direito quando
* o cursor de origem nao existe. Aqui se prova o contrario: com TprMvCab
* populado (o que o form PAI faz antes de abrir este), CarregarDados enche
* a grade MESTRE de verdade.
*
* Instanciar o form NAO pega defeito de carga: num visualizador o equivalente
* a "testar gravando" eh provar que a consulta devolve LINHA - conferir
* RECCOUNT, nao o retorno .T. (regra #42).
*
* TprMvCab eh criado DENTRO da DataSession PRIVADA do form (DataSession = 2):
* criado na sessao do probe ele ficaria invisivel para o form e a medicao
* daria um falso negativo - o mesmo motivo pelo qual o Init assume a
* DataSessionId do pai.
*
* A grade de ITENS depende de SQLEXEC em SigMvItn e o SQL Server
* (192.168.200.10) nao eh alcancavel nesta maquina: o que se mede dela eh que
* a falta de conexao vira recusa com mensagem, nao Program Error cru.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_ppp666_f4b.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_nSessaoProbe, loc_lRet, loc_cTxt
loc_cOut = "C:\4c\automation\probe_ppp666_f4b_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRPPPBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRPPP.prg") ADDITIVE

    loc_oForm = CREATEOBJECT("FormSigPrPpp")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        *-- Entra na sessao PRIVADA do form para criar TprMvCab onde o BO
        *   vai procurar (o pai faria isso ao executar a consulta).
        loc_nSessaoProbe = SET("DATASESSION")
        SET DATASESSION TO loc_oForm.DataSessionId

        STRTOFILE(CHR(13)+CHR(10)+"SESSAO probe=" + TRANSFORM(loc_nSessaoProbe) + ;
                  " form=" + TRANSFORM(loc_oForm.DataSessionId) + ;
                  " TprMvCab antes=" + TRANSFORM(USED("TprMvCab")), loc_cOut, 1)

        *-- Estrutura e nomes de coluna iguais aos de SigMvCab (o legado
        *   fazia Scatter MemVar / Insert From MemVar sobre o registro todo).
        CREATE CURSOR TprMvCab (emps C(3), dopes C(20), numes N(6,0), ;
                                datas T, valos N(11,2))
        INSERT INTO TprMvCab VALUES ("001", "MALOTE", 3, DATETIME(2026,10,15,0,0,0), 1234.56)
        INSERT INTO TprMvCab VALUES ("001", "MALOTE", 7, DATETIME(2026,10,16,0,0,0), 99.90)
        INSERT INTO TprMvCab VALUES ("002", "REMESSA", 1, DATETIME(2026,10,17,0,0,0), 42.00)
        STRTOFILE(CHR(13)+CHR(10)+"TprMvCab criado RECCOUNT=" + ;
                  TRANSFORM(RECCOUNT("TprMvCab")), loc_cOut, 1)

        SET DATASESSION TO (loc_nSessaoProbe)

        *-- A carga que a Fase 4 acrescentou
        loc_lRet = loc_oForm.CarregarDados()

        SET DATASESSION TO loc_oForm.DataSessionId

        loc_cTxt = CHR(13)+CHR(10)+"CarregarDados(com TprMvCab) retorno=" + TRANSFORM(loc_lRet) + ;
                   CHR(13)+CHR(10)+"  cursor_4c_Operacoes existe=" + TRANSFORM(USED("cursor_4c_Operacoes")) + ;
                   " RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Operacoes"), RECCOUNT("cursor_4c_Operacoes"), -1)) + ;
                   CHR(13)+CHR(10)+"  cursor_4c_Itens existe=" + TRANSFORM(USED("cursor_4c_Itens")) + ;
                   " RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Itens"), RECCOUNT("cursor_4c_Itens"), -1)) + ;
                   CHR(13)+CHR(10)+"  MsgBO=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]"
        STRTOFILE(loc_cTxt, loc_cOut, 1)

        *-- RECCOUNT eh o que prova a carga; e a ORDEM tem de ser a do
        *   ORDER BY emps, dopes, numes.
        IF USED("cursor_4c_Operacoes")
            SELECT cursor_4c_Operacoes
            GO TOP
            loc_cTxt = CHR(13)+CHR(10)+"LINHAS DA GRADE MESTRE:"
            SCAN
                loc_cTxt = loc_cTxt + CHR(13)+CHR(10)+"  emps=[" + cursor_4c_Operacoes.emps + ;
                    "] dopes=[" + ALLTRIM(cursor_4c_Operacoes.dopes) + ;
                    "] numes=" + TRANSFORM(cursor_4c_Operacoes.numes) + ;
                    " datas=" + TRANSFORM(TTOD(cursor_4c_Operacoes.datas)) + ;
                    " valos=" + TRANSFORM(cursor_4c_Operacoes.valos)
            ENDSCAN
            STRTOFILE(loc_cTxt, loc_cOut, 1)
        ENDIF

        *-- Propriedades da linha corrente (lidas por CarregarDoCursor) -
        *   eh a chave que o AfterRowColChange da Fase 7-8 vai usar.
        STRTOFILE(CHR(13)+CHR(10)+"LINHA CORRENTE emps=[" + loc_oForm.this_oBusinessObject.this_cEmps + ;
                  "] dopes=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cDopes) + ;
                  "] numes=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nNumes) + ;
                  CHR(13)+CHR(10)+"CHAVE POSICIONAL=[" + ;
                  loc_oForm.this_oBusinessObject.MontarChaveEmpDopNums("001", "MALOTE", 3) + ;
                  "] LEN=" + TRANSFORM(LEN(loc_oForm.this_oBusinessObject.MontarChaveEmpDopNums("001", "MALOTE", 3))), loc_cOut, 1)

        SET DATASESSION TO (loc_nSessaoProbe)

        *-- RepintarGrades deixa a grade MESTRE como area de trabalho corrente
        loc_oForm.RepintarGrades()
        SET DATASESSION TO loc_oForm.DataSessionId
        STRTOFILE(CHR(13)+CHR(10)+"RepintarGrades: alias corrente=[" + ALIAS() + "]" + ;
                  " RECNO=" + TRANSFORM(RECNO()), loc_cOut, 1)
        SET DATASESSION TO (loc_nSessaoProbe)

        *-- Carga chamada DUAS vezes nao duplica linha (ZAP antes do APPEND)
        loc_oForm.CarregarDados()
        SET DATASESSION TO loc_oForm.DataSessionId
        STRTOFILE(CHR(13)+CHR(10)+"2a CARGA RECCOUNT=" + ;
                  TRANSFORM(RECCOUNT("cursor_4c_Operacoes")) + " (esperado 3)", loc_cOut, 1)
        SET DATASESSION TO (loc_nSessaoProbe)

        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT
