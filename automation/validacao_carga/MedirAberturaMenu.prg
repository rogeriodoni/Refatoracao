*-- Mede a abertura real (o Main() do main.prg sem o READ EVENTS)
SET SAFETY OFF
SET RESOURCE OFF
SYS(2335,0)
LOCAL loc_nT, loc_cLog
loc_cLog = "C:\4c\refatoracao\automation\validacao_carga\abertura_menu.txt"
CD C:\4c\refatoracao\projeto\app\start
loc_nT = SECONDS()
DO config.prg
SET PROCEDURE TO (ADDBS(gc_4c_CaminhoBase) + "main.prg") ADDITIVE
ConfigurarAmbiente()
ConfigurarSETs()
ConectarBancoDados()
CriarMenuPrincipal()
STRTOFILE("abertura ate o menu: " + TRANSFORM(SECONDS() - loc_nT, "999.999") + " s, sob demanda=" + ;
          TRANSFORM(gl_4c_CargaSobDemanda) + ", conexao=" + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10), loc_cLog)
QUIT
