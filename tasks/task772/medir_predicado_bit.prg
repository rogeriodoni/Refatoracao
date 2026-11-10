*-- Mede se "WHERE !Servicos" (forma original da Fase 1) estoura quando a coluna
*-- chega NUMERICA - que eh o que acontece quando o driver ODBC mapeia o `bit`
*-- do SQL Server para numerico (CLAUDE.md regra #13).
SET SAFETY OFF
SET RESOURCE OFF
SET CONSOLE OFF
SET TALK OFF

LOCAL loc_cLog, loc_cSaida, loc_oErro

loc_cLog = "C:\4c\tasks\task772\medir_predicado_bit_resultado.txt"
loc_cSaida = ""

*-- (A) coluna NUMERICA (como chega via CAST AS INT, e como o driver pode
*--     entregar um `bit` sem cast)
CREATE CURSOR cur_num (EmpDnPs C(10), Servicos N(1,0), Pesos N(9,3))
INSERT INTO cur_num VALUES ("A", 0, 10.0)
INSERT INTO cur_num VALUES ("A", 1, 99.0)

loc_cSaida = loc_cSaida + "COLUNA NUMERICA N(1,0):" + CHR(13) + CHR(10)

TRY
    SELECT EmpDnPs, SUM(Pesos) AS T FROM cur_num WHERE !Servicos INTO CURSOR cr1 GROUP BY 1
    loc_cSaida = loc_cSaida + "  WHERE !Servicos    -> OK, total = " + TRANSFORM(cr1.T) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "  WHERE !Servicos    -> ERRO " + TRANSFORM(loc_oErro.ErrorNo) + ": " + ;
        loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

TRY
    SELECT EmpDnPs, SUM(Pesos) AS T FROM cur_num WHERE Servicos = 0 INTO CURSOR cr2 GROUP BY 1
    loc_cSaida = loc_cSaida + "  WHERE Servicos = 0 -> OK, total = " + TRANSFORM(cr2.T) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "  WHERE Servicos = 0 -> ERRO " + TRANSFORM(loc_oErro.ErrorNo) + ": " + ;
        loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

*-- (B) coluna LOGICA (como o driver entrega o `bit` no outro mapeamento)
CREATE CURSOR cur_log (EmpDnPs C(10), Servicos L, Pesos N(9,3))
INSERT INTO cur_log VALUES ("A", .F., 10.0)
INSERT INTO cur_log VALUES ("A", .T., 99.0)

loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "COLUNA LOGICA L:" + CHR(13) + CHR(10)

TRY
    SELECT EmpDnPs, SUM(Pesos) AS T FROM cur_log WHERE !Servicos INTO CURSOR cr3 GROUP BY 1
    loc_cSaida = loc_cSaida + "  WHERE !Servicos    -> OK, total = " + TRANSFORM(cr3.T) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "  WHERE !Servicos    -> ERRO " + TRANSFORM(loc_oErro.ErrorNo) + ": " + ;
        loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

TRY
    SELECT EmpDnPs, SUM(Pesos) AS T FROM cur_log WHERE Servicos = 0 INTO CURSOR cr4 GROUP BY 1
    loc_cSaida = loc_cSaida + "  WHERE Servicos = 0 -> OK, total = " + TRANSFORM(cr4.T) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "  WHERE Servicos = 0 -> ERRO " + TRANSFORM(loc_oErro.ErrorNo) + ": " + ;
        loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, loc_cLog)

QUIT
