SET SAFETY OFF
SET RESOURCE OFF
LOCAL c
c = "handle0 antes config=" + TRANSFORM(SQLGETPROP(0, "Transactions"))
CD "C:\4c\refatoracao\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
c = c + " | handle0 apos config=" + TRANSFORM(SQLGETPROP(0, "Transactions"))
h = SQLSTRINGCONNECT(ObterStringConexao())
c = c + " | nova conexao=" + TRANSFORM(SQLGETPROP(h, "Transactions"))
=SQLDISCONNECT(h)
STRTOFILE(c, "C:\4c\refatoracao\automation\erro365\probe\trans_out.txt")
QUIT
