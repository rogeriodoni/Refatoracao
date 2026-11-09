cp /c/4c/refatoracao/projeto/app/classes/sigredocBO.prg .
n=$(grep -n 'MsgErro(loc_oErro.Message, "Erro em PrepararDados")' sigredocBO.prg | cut -d: -f1)
sed -i "${n}s/.*/            STRTOFILE(\"CATCH PrepararDados: \" + loc_oErro.Message + \" linha \" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10), gcOut, .T.)/" sigredocBO.prg
rm -f *.fxp *.FXP
