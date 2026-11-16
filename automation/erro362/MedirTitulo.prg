SET SAFETY OFF
SET RESOURCE OFF
LOCAL c, t
t = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque  por Grupo de Produto/Faixa de Valor"
c = "w14=" + TRANSFORM(TXTWIDTH(t, "Tahoma", 14, "B") * FONTMETRIC(6, "Tahoma", 14, "B")) + ;
    " h14=" + TRANSFORM(FONTMETRIC(1, "Tahoma", 14, "B")) + ;
    " w16=" + TRANSFORM(TXTWIDTH(t, "Tahoma", 16, "B") * FONTMETRIC(6, "Tahoma", 16, "B")) + ;
    " h16=" + TRANSFORM(FONTMETRIC(1, "Tahoma", 16, "B"))
STRTOFILE(c, "C:\4c\refatoracao\automation\erro362\medida_titulo.txt")
QUIT
