# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (732)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_SALVA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterControle()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=33 vs migrado 'lbl_4c_Label17' Top=171 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=41 vs migrado 'lbl_4c_Label17' Left=365 (diff=324px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=46 vs migrado 'txt_4c_Text19' Top=78 (diff=32px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=41 vs migrado 'txt_4c_Text19' Left=213 (diff=172px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=48 vs migrado 'lbl_4c_Label24' Top=327 (diff=279px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=84 vs migrado 'lbl_4c_Label24' Left=192 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=46 vs migrado 'txt_4c_Text23' Top=174 (diff=128px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=90 vs migrado 'txt_4c_Text23' Left=164 (diff=74px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=65 vs migrado 'lbl_4c_Label35' Top=282 (diff=217px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=41 vs migrado 'lbl_4c_Label35' Left=149 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTpMargem' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=149 vs migrado 'obj_4c_OptTpMargem' Top=5 (diff=144px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTpMargem' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=389 vs migrado 'obj_4c_OptTpMargem' Left=5 (diff=384px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=80 vs migrado 'lbl_4c_Label42' Top=40 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=41 vs migrado 'lbl_4c_Label53' Left=149 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=112 vs migrado 'lbl_4c_Label6' Top=155 (diff=43px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=84 vs migrado 'lbl_4c_Label6' Left=409 (diff=325px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=129 vs migrado 'lbl_4c_Label7' Top=171 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=144 vs migrado 'lbl_4c_Label8' Top=185 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=41 vs migrado 'lbl_4c_Label9' Left=149 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=84 vs migrado 'lbl_4c_Label10' Left=192 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=193 vs migrado 'lbl_4c_Label11' Top=313 (diff=120px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=209 vs migrado 'lbl_4c_Label12' Top=327 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=49 vs migrado 'lbl_4c_Label13' Top=201 (diff=152px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=393 vs migrado 'lbl_4c_Label13' Left=41 (diff=352px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=81 vs migrado 'lbl_4c_Label14' Top=215 (diff=134px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=393 vs migrado 'lbl_4c_Label14' Left=84 (diff=309px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=81 vs migrado 'lbl_4c_Label15' Top=171 (diff=90px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=591 vs migrado 'lbl_4c_Label15' Left=257 (diff=334px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=226 vs migrado 'lbl_4c_Label16' Top=185 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=43 vs migrado 'lbl_4c_Label16' Left=300 (diff=257px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=244 vs migrado 'lbl_4c_Label17' Top=171 (diff=73px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=86 vs migrado 'lbl_4c_Label17' Left=365 (diff=279px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=114 vs migrado 'lbl_4c_Label18' Top=185 (diff=71px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=33 vs migrado 'lbl_4c_Label19' Top=201 (diff=168px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=48 vs migrado 'lbl_4c_Label20' Top=215 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=48 vs migrado 'lbl_4c_Label21' Top=141 (diff=93px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=65 vs migrado 'lbl_4c_Label22' Top=155 (diff=90px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=164 vs migrado 'lbl_4c_Label22' Left=301 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=80 vs migrado 'lbl_4c_Label23' Top=313 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=207 vs migrado 'lbl_4c_Label23' Left=149 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=129 vs migrado 'lbl_4c_Label24' Top=327 (diff=198px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label25' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=144 vs migrado 'lbl_4c_Label25' Top=252 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label25' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=207 vs migrado 'lbl_4c_Label25' Left=42 (diff=165px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label26' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=161 vs migrado 'lbl_4c_Label26' Top=266 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label26' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=164 vs migrado 'lbl_4c_Label26' Left=85 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Top original=176 vs migrado 'lbl_4c_Label27' Top=252 (diff=76px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Cabecalho): Left original=207 vs migrado 'lbl_4c_Label27' Left=149 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=42 vs migrado 'lbl_4c_Label17' Left=365 (diff=323px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=153 vs migrado 'txt_4c_Text19' Top=78 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=42 vs migrado 'txt_4c_Text19' Left=213 (diff=171px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=155 vs migrado 'lbl_4c_Label24' Top=327 (diff=172px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=85 vs migrado 'lbl_4c_Label24' Left=192 (diff=107px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=91 vs migrado 'txt_4c_Text23' Left=164 (diff=73px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=141 vs migrado 'lbl_4c_Label35' Top=282 (diff=141px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=153 vs migrado 'txt_4c_Text3' Top=78 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=150 vs migrado 'txt_4c_Text3' Left=41 (diff=109px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=155 vs migrado 'lbl_4c_Label42' Top=40 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=193 vs migrado 'lbl_4c_Label42' Left=85 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=153 vs migrado 'txt_4c_Text4' Top=78 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=199 vs migrado 'txt_4c_Text4' Left=90 (diff=109px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=141 vs migrado 'lbl_4c_Label53' Top=86 (diff=55px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=366 vs migrado 'lbl_4c_Label53' Left=149 (diff=217px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=153 vs migrado 'txt_4c_Text5' Top=110 (diff=43px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=366 vs migrado 'txt_4c_Text5' Left=41 (diff=325px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=153 vs migrado 'txt_4c_Text6' Top=110 (diff=43px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=415 vs migrado 'txt_4c_Text6' Left=90 (diff=325px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=183 vs migrado 'txt_4c_Text7' Top=142 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=183 vs migrado 'txt_4c_Text8' Top=142 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=149 vs migrado 'txt_4c_Text9' Left=41 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=198 vs migrado 'txt_4c_Text10' Left=90 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=213 vs migrado 'txt_4c_Text13' Top=61 (diff=152px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=41 vs migrado 'txt_4c_Text13' Left=393 (diff=352px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=213 vs migrado 'txt_4c_Text14' Top=93 (diff=120px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=90 vs migrado 'txt_4c_Text14' Left=393 (diff=303px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=183 vs migrado 'txt_4c_Text15' Top=93 (diff=90px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=257 vs migrado 'txt_4c_Text15' Left=592 (diff=335px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=183 vs migrado 'txt_4c_Text16' Top=46 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=306 vs migrado 'txt_4c_Text16' Left=214 (diff=92px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=183 vs migrado 'txt_4c_Text17' Top=46 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=365 vs migrado 'txt_4c_Text17' Left=261 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=183 vs migrado 'txt_4c_Text18' Top=78 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=414 vs migrado 'txt_4c_Text18' Left=164 (diff=250px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=213 vs migrado 'txt_4c_Text19' Top=78 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=149 vs migrado 'txt_4c_Text19' Left=213 (diff=64px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=213 vs migrado 'txt_4c_Text20' Top=97 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=198 vs migrado 'txt_4c_Text20' Left=164 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=258 vs migrado 'txt_4c_Text21' Left=164 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=307 vs migrado 'txt_4c_Text22' Left=213 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=325 vs migrado 'txt_4c_Text11' Top=127 (diff=198px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=41 vs migrado 'txt_4c_Text11' Left=393 (diff=352px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=325 vs migrado 'txt_4c_Text12' Top=46 (diff=279px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Left original=90 vs migrado 'txt_4c_Text12' Left=165 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=325 vs migrado 'txt_4c_Text23' Top=174 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Empresa): Top original=325 vs migrado 'txt_4c_Text24' Top=174 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=25 vs migrado 'lbl_4c_Label17' Top=171 (diff=146px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=87 vs migrado 'lbl_4c_Label17' Left=365 (diff=278px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=37 vs migrado 'txt_4c_Text19' Top=78 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=58 vs migrado 'txt_4c_Text19' Left=213 (diff=155px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=39 vs migrado 'lbl_4c_Label24' Top=327 (diff=288px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=101 vs migrado 'lbl_4c_Label24' Left=192 (diff=91px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=37 vs migrado 'txt_4c_Text23' Top=174 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=107 vs migrado 'txt_4c_Text23' Left=164 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=25 vs migrado 'lbl_4c_Label35' Top=282 (diff=257px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=200 vs migrado 'lbl_4c_Label35' Left=149 (diff=51px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=37 vs migrado 'txt_4c_Text3' Top=78 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=165 vs migrado 'txt_4c_Text3' Left=41 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=208 vs migrado 'lbl_4c_Label42' Left=85 (diff=123px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=37 vs migrado 'txt_4c_Text4' Top=78 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=214 vs migrado 'txt_4c_Text4' Left=90 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=25 vs migrado 'lbl_4c_Label53' Top=86 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=294 vs migrado 'lbl_4c_Label53' Left=149 (diff=145px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=37 vs migrado 'txt_4c_Text5' Top=110 (diff=73px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=273 vs migrado 'txt_4c_Text5' Left=41 (diff=232px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=39 vs migrado 'lbl_4c_Label6' Top=155 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=316 vs migrado 'lbl_4c_Label6' Left=409 (diff=93px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=37 vs migrado 'txt_4c_Text6' Top=110 (diff=73px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=322 vs migrado 'txt_4c_Text6' Left=90 (diff=232px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=39 vs migrado 'lbl_4c_Label7' Top=171 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=56 vs migrado 'txt_4c_Text7' Top=142 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=58 vs migrado 'lbl_4c_Label8' Top=185 (diff=127px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=56 vs migrado 'txt_4c_Text8' Top=142 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=56 vs migrado 'txt_4c_Text9' Top=174 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=165 vs migrado 'txt_4c_Text9' Left=41 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=58 vs migrado 'lbl_4c_Label9' Top=171 (diff=113px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=208 vs migrado 'lbl_4c_Label9' Left=149 (diff=59px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=56 vs migrado 'txt_4c_Text10' Top=174 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=214 vs migrado 'txt_4c_Text10' Left=90 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=56 vs migrado 'txt_4c_Text11' Top=127 (diff=71px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=273 vs migrado 'txt_4c_Text11' Left=393 (diff=120px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=58 vs migrado 'lbl_4c_Label10' Top=185 (diff=127px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=316 vs migrado 'lbl_4c_Label10' Left=192 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=322 vs migrado 'txt_4c_Text12' Left=165 (diff=157px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=58 vs migrado 'lbl_4c_Label11' Top=313 (diff=255px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=58 vs migrado 'txt_4c_Text13' Left=393 (diff=335px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=77 vs migrado 'lbl_4c_Label12' Top=327 (diff=250px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=107 vs migrado 'txt_4c_Text14' Left=393 (diff=286px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=165 vs migrado 'txt_4c_Text15' Left=592 (diff=427px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=77 vs migrado 'lbl_4c_Label13' Top=201 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=208 vs migrado 'lbl_4c_Label13' Left=41 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=77 vs migrado 'lbl_4c_Label14' Top=215 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=316 vs migrado 'lbl_4c_Label14' Left=84 (diff=232px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=322 vs migrado 'txt_4c_Text18' Left=164 (diff=158px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=77 vs migrado 'lbl_4c_Label15' Top=171 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=13 vs migrado 'lbl_4c_Label15' Left=257 (diff=244px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=58 vs migrado 'txt_4c_Text19' Left=213 (diff=155px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=96 vs migrado 'lbl_4c_Label16' Top=185 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=101 vs migrado 'lbl_4c_Label16' Left=300 (diff=199px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=107 vs migrado 'txt_4c_Text20' Left=164 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=94 vs migrado 'txt_4c_Text21' Top=142 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=96 vs migrado 'lbl_4c_Label17' Top=171 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=208 vs migrado 'lbl_4c_Label17' Left=365 (diff=157px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=94 vs migrado 'txt_4c_Text22' Top=142 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=94 vs migrado 'txt_4c_Text23' Top=174 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=273 vs migrado 'txt_4c_Text23' Left=164 (diff=109px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=96 vs migrado 'lbl_4c_Label18' Top=185 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=316 vs migrado 'lbl_4c_Label18' Left=408 (diff=92px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=94 vs migrado 'txt_4c_Text24' Top=174 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=322 vs migrado 'txt_4c_Text24' Left=213 (diff=109px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=96 vs migrado 'lbl_4c_Label19' Top=201 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=13 vs migrado 'lbl_4c_Label19' Left=149 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=115 vs migrado 'lbl_4c_Label20' Top=215 (diff=100px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=101 vs migrado 'lbl_4c_Label20' Left=192 (diff=91px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=208 vs migrado 'lbl_4c_Label21' Left=258 (diff=50px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=115 vs migrado 'lbl_4c_Label22' Top=155 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=115 vs migrado 'lbl_4c_Label23' Top=313 (diff=198px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=13 vs migrado 'lbl_4c_Label23' Left=149 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=134 vs migrado 'lbl_4c_Label24' Top=327 (diff=193px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=101 vs migrado 'lbl_4c_Label24' Left=192 (diff=91px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label25' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=134 vs migrado 'lbl_4c_Label25' Top=252 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label25' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=208 vs migrado 'lbl_4c_Label25' Left=42 (diff=166px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label26' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=134 vs migrado 'lbl_4c_Label26' Top=266 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label26' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=316 vs migrado 'lbl_4c_Label26' Left=85 (diff=231px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=134 vs migrado 'lbl_4c_Label27' Top=252 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=13 vs migrado 'lbl_4c_Label27' Left=149 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label28' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=25 vs migrado 'lbl_4c_Label28' Top=266 (diff=241px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label28' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=395 vs migrado 'lbl_4c_Label28' Left=192 (diff=203px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label29' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=39 vs migrado 'lbl_4c_Label29' Top=282 (diff=243px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label29' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=438 vs migrado 'lbl_4c_Label29' Left=41 (diff=397px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label30' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=25 vs migrado 'lbl_4c_Label30' Top=296 (diff=271px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label30' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=495 vs migrado 'lbl_4c_Label30' Left=84 (diff=411px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label31' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=39 vs migrado 'lbl_4c_Label31' Top=252 (diff=213px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label31' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=538 vs migrado 'lbl_4c_Label31' Left=257 (diff=281px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label32' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=97 vs migrado 'lbl_4c_Label32' Top=266 (diff=169px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label32' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=394 vs migrado 'lbl_4c_Label32' Left=300 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label33' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=111 vs migrado 'lbl_4c_Label33' Top=252 (diff=141px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label33' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=437 vs migrado 'lbl_4c_Label33' Left=365 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label34' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=61 vs migrado 'lbl_4c_Label34' Top=266 (diff=205px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label35' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=75 vs migrado 'lbl_4c_Label35' Top=282 (diff=207px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label35' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=437 vs migrado 'lbl_4c_Label35' Left=149 (diff=288px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label36' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=61 vs migrado 'lbl_4c_Label36' Top=296 (diff=235px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label36' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=495 vs migrado 'lbl_4c_Label36' Left=192 (diff=303px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label37' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=75 vs migrado 'lbl_4c_Label37' Top=127 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label37' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=538 vs migrado 'lbl_4c_Label37' Left=50 (diff=488px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label38' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=153 vs migrado 'lbl_4c_Label38' Top=238 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label38' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=101 vs migrado 'lbl_4c_Label38' Left=52 (diff=49px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label39' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=153 vs migrado 'lbl_4c_Label39' Top=282 (diff=129px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label39' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=208 vs migrado 'lbl_4c_Label39' Left=257 (diff=49px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label40' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=153 vs migrado 'lbl_4c_Label40' Top=296 (diff=143px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label41' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=153 vs migrado 'lbl_4c_Label41' Top=26 (diff=127px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label42' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=172 vs migrado 'lbl_4c_Label42' Top=40 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label43' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=172 vs migrado 'lbl_4c_Label43' Top=26 (diff=146px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label43' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=208 vs migrado 'lbl_4c_Label43' Left=150 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label44' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=172 vs migrado 'lbl_4c_Label44' Top=40 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label44' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=316 vs migrado 'lbl_4c_Label44' Left=193 (diff=123px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label45' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=172 vs migrado 'lbl_4c_Label45' Top=56 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label46' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=191 vs migrado 'lbl_4c_Label46' Top=70 (diff=121px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label47' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=191 vs migrado 'lbl_4c_Label47' Top=56 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label47' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=208 vs migrado 'lbl_4c_Label47' Left=149 (diff=59px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label48' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=191 vs migrado 'lbl_4c_Label48' Top=70 (diff=121px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label48' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=316 vs migrado 'lbl_4c_Label48' Left=192 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label49' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=191 vs migrado 'lbl_4c_Label49' Top=86 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label50' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=210 vs migrado 'lbl_4c_Label50' Top=100 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label51' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=210 vs migrado 'lbl_4c_Label51' Top=56 (diff=154px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label51' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=208 vs migrado 'lbl_4c_Label51' Left=257 (diff=49px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label52' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=210 vs migrado 'lbl_4c_Label52' Top=70 (diff=140px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label53' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Top original=210 vs migrado 'lbl_4c_Label53' Top=86 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label53' (parent: SIGCDNFL.Pagina.Dados.Pagina.Desdobramento): Left original=8 vs migrado 'lbl_4c_Label53' Left=149 (diff=141px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label17' Top=171 (diff=121px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=34 vs migrado 'lbl_4c_Label17' Left=365 (diff=331px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=24 vs migrado 'txt_4c_Text19' Top=78 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=153 vs migrado 'txt_4c_Text19' Left=213 (diff=60px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=62 vs migrado 'txt_4c_Text23' Top=174 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=32 vs migrado 'txt_4c_Text23' Left=164 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label35' Top=282 (diff=232px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=77 vs migrado 'lbl_4c_Label35' Left=149 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label53' Top=86 (diff=36px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=287 vs migrado 'lbl_4c_Label53' Left=149 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=62 vs migrado 'txt_4c_Text6' Top=110 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=293 vs migrado 'txt_4c_Text6' Left=90 (diff=203px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label7' Top=171 (diff=121px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=335 vs migrado 'lbl_4c_Label7' Left=42 (diff=293px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=62 vs migrado 'txt_4c_Text8' Top=142 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=336 vs migrado 'txt_4c_Text8' Left=90 (diff=246px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label9' Top=171 (diff=121px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=422 vs migrado 'lbl_4c_Label9' Left=149 (diff=273px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=62 vs migrado 'txt_4c_Text10' Top=174 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=422 vs migrado 'txt_4c_Text10' Left=90 (diff=332px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label11' Top=313 (diff=263px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=470 vs migrado 'lbl_4c_Label11' Left=41 (diff=429px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=466 vs migrado 'txt_4c_Text12' Left=165 (diff=301px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=85 vs migrado 'lbl_4c_Label13' Top=201 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=32 vs migrado 'txt_4c_Text14' Left=393 (diff=361px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=85 vs migrado 'lbl_4c_Label15' Top=171 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=71 vs migrado 'lbl_4c_Label15' Left=257 (diff=186px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=97 vs migrado 'txt_4c_Text16' Top=46 (diff=51px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=75 vs migrado 'txt_4c_Text16' Left=214 (diff=139px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=85 vs migrado 'lbl_4c_Label17' Top=171 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=116 vs migrado 'lbl_4c_Label17' Left=365 (diff=249px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=118 vs migrado 'txt_4c_Text18' Left=164 (diff=46px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=85 vs migrado 'lbl_4c_Label19' Top=201 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=85 vs migrado 'lbl_4c_Label21' Top=141 (diff=56px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=201 vs migrado 'lbl_4c_Label21' Left=258 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=97 vs migrado 'txt_4c_Text22' Top=142 (diff=45px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label25' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=127 vs migrado 'lbl_4c_Label25' Top=252 (diff=125px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label26' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=162 vs migrado 'lbl_4c_Label26' Top=266 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label26' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=38 vs migrado 'lbl_4c_Label26' Left=85 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=180 vs migrado 'lbl_4c_Label27' Top=252 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=38 vs migrado 'lbl_4c_Label27' Left=149 (diff=111px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label28' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=198 vs migrado 'lbl_4c_Label28' Top=266 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label28' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=38 vs migrado 'lbl_4c_Label28' Left=192 (diff=154px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label29' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=216 vs migrado 'lbl_4c_Label29' Top=282 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label30' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=234 vs migrado 'lbl_4c_Label30' Top=296 (diff=62px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label30' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=38 vs migrado 'lbl_4c_Label30' Left=84 (diff=46px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=28 vs migrado 'lbl_4c_Label24' Top=327 (diff=299px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=18 vs migrado 'lbl_4c_Label24' Left=192 (diff=174px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=137 vs migrado 'lbl_4c_Label23' Top=313 (diff=176px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=199 vs migrado 'lbl_4c_Label23' Left=149 (diff=50px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=142 vs migrado 'lbl_4c_Label42' Top=40 (diff=102px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=38 vs migrado 'lbl_4c_Label42' Left=85 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=138 vs migrado 'txt_4c_Text3' Top=78 (diff=60px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=143 vs migrado 'txt_4c_Text3' Left=41 (diff=102px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=268 vs migrado 'lbl_4c_Label6' Left=409 (diff=141px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=137 vs migrado 'lbl_4c_Label8' Top=185 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=341 vs migrado 'lbl_4c_Label8' Left=85 (diff=256px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=279 vs migrado 'txt_4c_Text7' Left=41 (diff=238px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=149 vs migrado 'txt_4c_Text5' Top=110 (diff=39px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=348 vs migrado 'txt_4c_Text5' Left=41 (diff=307px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label10' Top=185 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=121 vs migrado 'lbl_4c_Label10' Left=192 (diff=71px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=62 vs migrado 'txt_4c_Text9' Top=174 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=118 vs migrado 'txt_4c_Text9' Left=41 (diff=77px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=136 vs migrado 'lbl_4c_Label12' Top=327 (diff=191px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=415 vs migrado 'lbl_4c_Label12' Left=84 (diff=331px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=148 vs migrado 'txt_4c_Text19' Top=78 (diff=70px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=419 vs migrado 'txt_4c_Text19' Left=213 (diff=206px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=150 vs migrado 'lbl_4c_Label20' Top=215 (diff=65px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=462 vs migrado 'lbl_4c_Label20' Left=192 (diff=270px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=468 vs migrado 'txt_4c_Text11' Left=393 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label14' Top=215 (diff=165px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=379 vs migrado 'lbl_4c_Label14' Left=84 (diff=295px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=241 vs migrado 'lbl_4c_Label16' Left=300 (diff=59px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=205 vs migrado 'txt_4c_Text15' Top=93 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=250 vs migrado 'txt_4c_Text15' Left=592 (diff=342px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=293 vs migrado 'lbl_4c_Label18' Left=408 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=205 vs migrado 'txt_4c_Text17' Top=46 (diff=159px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=299 vs migrado 'txt_4c_Text17' Left=261 (diff=38px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label22' Top=155 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=164 vs migrado 'lbl_4c_Label22' Left=301 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=62 vs migrado 'txt_4c_Text21' Top=142 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label24' Top=327 (diff=277px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=62 vs migrado 'txt_4c_Text23' Top=174 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=204 vs migrado 'txt_4c_Text23' Left=164 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label31' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=50 vs migrado 'lbl_4c_Label31' Top=252 (diff=202px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label32' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=85 vs migrado 'lbl_4c_Label32' Top=266 (diff=181px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label32' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=253 vs migrado 'lbl_4c_Label32' Left=300 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label33' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Top original=85 vs migrado 'lbl_4c_Label33' Top=252 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label33' (parent: SIGCDNFL.Pagina.Dados.Pagina.Produtos): Left original=289 vs migrado 'lbl_4c_Label33' Left=365 (diff=76px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=19 vs migrado 'lbl_4c_Label17' Top=171 (diff=152px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=28 vs migrado 'lbl_4c_Label17' Left=365 (diff=337px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=31 vs migrado 'txt_4c_Text19' Top=78 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=39 vs migrado 'txt_4c_Text19' Left=213 (diff=174px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=33 vs migrado 'lbl_4c_Label24' Top=327 (diff=294px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=82 vs migrado 'lbl_4c_Label24' Left=192 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=31 vs migrado 'txt_4c_Text23' Top=174 (diff=143px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=88 vs migrado 'txt_4c_Text23' Left=164 (diff=76px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=19 vs migrado 'lbl_4c_Label35' Top=282 (diff=263px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=31 vs migrado 'txt_4c_Text3' Top=78 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=147 vs migrado 'txt_4c_Text3' Left=41 (diff=106px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=190 vs migrado 'lbl_4c_Label42' Left=85 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=31 vs migrado 'txt_4c_Text4' Top=78 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=196 vs migrado 'txt_4c_Text4' Left=90 (diff=106px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=53 vs migrado 'lbl_4c_Label9' Top=171 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=39 vs migrado 'lbl_4c_Label9' Left=149 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=65 vs migrado 'txt_4c_Text9' Top=174 (diff=109px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=67 vs migrado 'lbl_4c_Label10' Top=185 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=82 vs migrado 'lbl_4c_Label10' Left=192 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=65 vs migrado 'txt_4c_Text10' Top=174 (diff=109px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=53 vs migrado 'lbl_4c_Label11' Top=313 (diff=260px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=147 vs migrado 'lbl_4c_Label11' Left=41 (diff=106px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=65 vs migrado 'txt_4c_Text11' Top=127 (diff=62px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=147 vs migrado 'txt_4c_Text11' Left=393 (diff=246px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=67 vs migrado 'lbl_4c_Label12' Top=327 (diff=260px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=190 vs migrado 'lbl_4c_Label12' Left=84 (diff=106px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=196 vs migrado 'txt_4c_Text12' Left=165 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=53 vs migrado 'lbl_4c_Label13' Top=201 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=255 vs migrado 'lbl_4c_Label13' Left=41 (diff=214px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=255 vs migrado 'txt_4c_Text13' Left=393 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=67 vs migrado 'lbl_4c_Label14' Top=215 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=298 vs migrado 'lbl_4c_Label14' Left=84 (diff=214px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=304 vs migrado 'txt_4c_Text14' Left=393 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=89 vs migrado 'lbl_4c_Label15' Top=171 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=35 vs migrado 'lbl_4c_Label15' Left=257 (diff=222px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=39 vs migrado 'txt_4c_Text15' Left=592 (diff=553px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=103 vs migrado 'lbl_4c_Label16' Top=185 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=82 vs migrado 'lbl_4c_Label16' Left=300 (diff=218px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=101 vs migrado 'txt_4c_Text16' Top=46 (diff=55px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=88 vs migrado 'txt_4c_Text16' Left=214 (diff=126px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=89 vs migrado 'lbl_4c_Label17' Top=171 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=255 vs migrado 'lbl_4c_Label17' Left=365 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=101 vs migrado 'txt_4c_Text17' Top=46 (diff=55px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=103 vs migrado 'lbl_4c_Label18' Top=185 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=298 vs migrado 'lbl_4c_Label18' Left=408 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=304 vs migrado 'txt_4c_Text18' Left=164 (diff=140px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=89 vs migrado 'lbl_4c_Label19' Top=201 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=357 vs migrado 'lbl_4c_Label19' Left=149 (diff=208px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=363 vs migrado 'txt_4c_Text19' Left=213 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=103 vs migrado 'lbl_4c_Label20' Top=215 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=406 vs migrado 'lbl_4c_Label20' Left=192 (diff=214px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=412 vs migrado 'txt_4c_Text20' Left=164 (diff=248px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=180 vs migrado 'lbl_4c_Label21' Top=141 (diff=39px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=44 vs migrado 'lbl_4c_Label21' Left=258 (diff=214px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=193 vs migrado 'txt_4c_Text21' Top=142 (diff=51px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=44 vs migrado 'txt_4c_Text21' Left=164 (diff=120px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=193 vs migrado 'txt_4c_Text22' Top=142 (diff=51px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=93 vs migrado 'txt_4c_Text22' Left=213 (diff=120px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=166 vs migrado 'lbl_4c_Label27' Top=252 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=44 vs migrado 'lbl_4c_Label27' Left=149 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=93 vs migrado 'lbl_4c_Label22' Left=301 (diff=208px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=147 vs migrado 'txt_4c_Text5' Left=41 (diff=106px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=104 vs migrado 'lbl_4c_Label6' Top=155 (diff=51px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=190 vs migrado 'lbl_4c_Label6' Left=409 (diff=219px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=196 vs migrado 'txt_4c_Text6' Left=90 (diff=106px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=125 vs migrado 'lbl_4c_Label7' Top=171 (diff=46px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=139 vs migrado 'lbl_4c_Label8' Top=185 (diff=46px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=125 vs migrado 'lbl_4c_Label23' Top=313 (diff=188px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=137 vs migrado 'txt_4c_Text23' Top=174 (diff=37px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=139 vs migrado 'lbl_4c_Label24' Top=327 (diff=188px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=137 vs migrado 'txt_4c_Text24' Top=174 (diff=37px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label25' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Top original=89 vs migrado 'lbl_4c_Label25' Top=252 (diff=163px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label25' (parent: SIGCDNFL.Pagina.Dados.Pagina.Impostos): Left original=461 vs migrado 'lbl_4c_Label25' Left=42 (diff=419px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=149 vs migrado 'lbl_4c_Label18' Top=185 (diff=36px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=17 vs migrado 'lbl_4c_Label18' Left=408 (diff=391px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=161 vs migrado 'txt_4c_Text19' Top=78 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=17 vs migrado 'txt_4c_Text19' Left=213 (diff=196px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=163 vs migrado 'lbl_4c_Label19' Top=201 (diff=38px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=60 vs migrado 'lbl_4c_Label19' Left=149 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=161 vs migrado 'txt_4c_Text20' Top=97 (diff=64px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=66 vs migrado 'txt_4c_Text20' Left=164 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=149 vs migrado 'lbl_4c_Label20' Top=215 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=124 vs migrado 'lbl_4c_Label20' Left=192 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=124 vs migrado 'txt_4c_Text21' Left=164 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=163 vs migrado 'lbl_4c_Label23' Top=313 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=173 vs migrado 'txt_4c_Text22' Left=213 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=149 vs migrado 'lbl_4c_Label24' Top=327 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=232 vs migrado 'lbl_4c_Label24' Left=192 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=232 vs migrado 'txt_4c_Text23' Left=164 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label25' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=163 vs migrado 'lbl_4c_Label25' Top=252 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label25' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=275 vs migrado 'lbl_4c_Label25' Left=42 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=281 vs migrado 'txt_4c_Text24' Left=213 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label26' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=183 vs migrado 'lbl_4c_Label26' Top=266 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label26' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=17 vs migrado 'lbl_4c_Label26' Left=85 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=197 vs migrado 'lbl_4c_Label27' Top=252 (diff=55px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=60 vs migrado 'lbl_4c_Label27' Left=149 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label28' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=183 vs migrado 'lbl_4c_Label28' Top=266 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label28' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=124 vs migrado 'lbl_4c_Label28' Left=192 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label29' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=197 vs migrado 'lbl_4c_Label29' Top=282 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label29' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=167 vs migrado 'lbl_4c_Label29' Left=41 (diff=126px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label30' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=183 vs migrado 'lbl_4c_Label30' Top=296 (diff=113px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label30' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=232 vs migrado 'lbl_4c_Label30' Left=84 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label31' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=197 vs migrado 'lbl_4c_Label31' Top=252 (diff=55px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=24 vs migrado 'lbl_4c_Label17' Top=171 (diff=147px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=17 vs migrado 'lbl_4c_Label17' Left=365 (diff=348px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=36 vs migrado 'txt_4c_Text19' Top=78 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=17 vs migrado 'txt_4c_Text19' Left=213 (diff=196px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=38 vs migrado 'lbl_4c_Label24' Top=327 (diff=289px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=60 vs migrado 'lbl_4c_Label24' Left=192 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=36 vs migrado 'txt_4c_Text23' Top=174 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=66 vs migrado 'txt_4c_Text23' Left=164 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=24 vs migrado 'lbl_4c_Label35' Top=282 (diff=258px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=36 vs migrado 'txt_4c_Text3' Top=78 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=125 vs migrado 'txt_4c_Text3' Left=41 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=168 vs migrado 'lbl_4c_Label42' Left=85 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=36 vs migrado 'txt_4c_Text4' Top=78 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=174 vs migrado 'txt_4c_Text4' Left=90 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=57 vs migrado 'lbl_4c_Label7' Top=171 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=69 vs migrado 'txt_4c_Text7' Top=142 (diff=73px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=71 vs migrado 'lbl_4c_Label8' Top=185 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=69 vs migrado 'txt_4c_Text8' Top=142 (diff=73px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=57 vs migrado 'lbl_4c_Label9' Top=171 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=69 vs migrado 'txt_4c_Text9' Top=174 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=124 vs migrado 'txt_4c_Text9' Left=41 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=71 vs migrado 'lbl_4c_Label10' Top=185 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=69 vs migrado 'txt_4c_Text10' Top=174 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=173 vs migrado 'txt_4c_Text10' Left=90 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=57 vs migrado 'lbl_4c_Label15' Top=171 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=69 vs migrado 'txt_4c_Text11' Top=127 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=232 vs migrado 'txt_4c_Text11' Left=393 (diff=161px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=71 vs migrado 'lbl_4c_Label16' Top=185 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=281 vs migrado 'txt_4c_Text12' Left=165 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=24 vs migrado 'lbl_4c_Label21' Top=141 (diff=117px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=36 vs migrado 'txt_4c_Text5' Top=110 (diff=74px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=233 vs migrado 'txt_4c_Text5' Left=41 (diff=192px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=38 vs migrado 'lbl_4c_Label22' Top=155 (diff=117px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=36 vs migrado 'txt_4c_Text6' Top=110 (diff=74px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=282 vs migrado 'txt_4c_Text6' Left=90 (diff=192px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=10 vs migrado 'lbl_4c_Label53' Top=86 (diff=76px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=19 vs migrado 'lbl_4c_Label53' Left=149 (diff=130px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=91 vs migrado 'lbl_4c_Label6' Top=155 (diff=64px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=17 vs migrado 'lbl_4c_Label6' Left=409 (diff=392px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=103 vs migrado 'txt_4c_Text13' Top=61 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=17 vs migrado 'txt_4c_Text13' Left=393 (diff=376px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=105 vs migrado 'lbl_4c_Label11' Top=313 (diff=208px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=66 vs migrado 'txt_4c_Text14' Left=393 (diff=327px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=91 vs migrado 'lbl_4c_Label12' Top=327 (diff=236px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=124 vs migrado 'lbl_4c_Label12' Left=84 (diff=40px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=124 vs migrado 'txt_4c_Text15' Left=592 (diff=468px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=105 vs migrado 'lbl_4c_Label13' Top=201 (diff=96px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=167 vs migrado 'lbl_4c_Label13' Left=41 (diff=126px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=103 vs migrado 'txt_4c_Text16' Top=46 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=173 vs migrado 'txt_4c_Text16' Left=214 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=91 vs migrado 'lbl_4c_Label14' Top=215 (diff=124px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=232 vs migrado 'lbl_4c_Label14' Left=84 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=103 vs migrado 'txt_4c_Text17' Top=46 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=105 vs migrado 'lbl_4c_Label17' Top=171 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=275 vs migrado 'lbl_4c_Label17' Left=365 (diff=90px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=281 vs migrado 'txt_4c_Text18' Left=164 (diff=117px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label32' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=136 vs migrado 'lbl_4c_Label32' Top=266 (diff=130px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label32' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=19 vs migrado 'lbl_4c_Label32' Left=300 (diff=281px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label33' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Top original=221 vs migrado 'lbl_4c_Label33' Top=252 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label33' (parent: SIGCDNFL.Pagina.Dados.Pagina.Transporte): Left original=19 vs migrado 'lbl_4c_Label33' Left=365 (diff=346px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=42 vs migrado 'lbl_4c_Label17' Top=171 (diff=129px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=94 vs migrado 'lbl_4c_Label17' Left=365 (diff=271px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=80 vs migrado 'txt_4c_Text19' Left=213 (diff=133px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=56 vs migrado 'lbl_4c_Label24' Top=327 (diff=271px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=123 vs migrado 'lbl_4c_Label24' Left=192 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=54 vs migrado 'txt_4c_Text23' Top=174 (diff=120px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=129 vs migrado 'txt_4c_Text23' Left=164 (diff=35px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=221 vs migrado 'txt_4c_Text3' Left=41 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=73 vs migrado 'txt_4c_Text7' Top=142 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=80 vs migrado 'txt_4c_Text7' Left=41 (diff=39px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=75 vs migrado 'lbl_4c_Label8' Top=185 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=123 vs migrado 'lbl_4c_Label8' Left=85 (diff=38px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=73 vs migrado 'txt_4c_Text8' Top=142 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=129 vs migrado 'txt_4c_Text8' Left=90 (diff=39px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=73 vs migrado 'txt_4c_Text9' Top=174 (diff=101px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=221 vs migrado 'txt_4c_Text9' Left=41 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=92 vs migrado 'txt_4c_Text13' Top=61 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=80 vs migrado 'txt_4c_Text13' Left=393 (diff=313px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=94 vs migrado 'lbl_4c_Label12' Top=327 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=123 vs migrado 'lbl_4c_Label12' Left=84 (diff=39px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=129 vs migrado 'txt_4c_Text14' Left=393 (diff=264px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=221 vs migrado 'txt_4c_Text15' Left=592 (diff=371px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=111 vs migrado 'txt_4c_Text19' Top=78 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=80 vs migrado 'txt_4c_Text19' Left=213 (diff=133px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=113 vs migrado 'lbl_4c_Label16' Top=185 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=123 vs migrado 'lbl_4c_Label16' Left=300 (diff=177px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=129 vs migrado 'txt_4c_Text20' Left=164 (diff=35px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=111 vs migrado 'txt_4c_Text21' Top=142 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=221 vs migrado 'txt_4c_Text21' Left=164 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=132 vs migrado 'lbl_4c_Label20' Top=215 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=123 vs migrado 'lbl_4c_Label20' Left=192 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=151 vs migrado 'lbl_4c_Label24' Top=327 (diff=176px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=123 vs migrado 'lbl_4c_Label24' Left=192 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=41 vs migrado 'lbl_4c_Label35' Top=282 (diff=241px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=222 vs migrado 'lbl_4c_Label35' Left=149 (diff=73px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=202 vs migrado 'lbl_4c_Label42' Top=40 (diff=162px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=213 vs migrado 'txt_4c_Text4' Top=78 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=36 vs migrado 'txt_4c_Text4' Left=90 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=215 vs migrado 'lbl_4c_Label53' Top=86 (diff=129px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=79 vs migrado 'lbl_4c_Label53' Left=149 (diff=70px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=213 vs migrado 'txt_4c_Text5' Top=110 (diff=103px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=85 vs migrado 'txt_4c_Text5' Left=41 (diff=44px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=242 vs migrado 'lbl_4c_Label6' Top=155 (diff=87px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=44 vs migrado 'lbl_4c_Label6' Left=409 (diff=365px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=254 vs migrado 'txt_4c_Text23' Top=174 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text23' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=44 vs migrado 'txt_4c_Text23' Left=164 (diff=120px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=256 vs migrado 'lbl_4c_Label9' Top=171 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=87 vs migrado 'lbl_4c_Label9' Left=149 (diff=62px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=254 vs migrado 'txt_4c_Text24' Top=174 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text24' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=93 vs migrado 'txt_4c_Text24' Left=213 (diff=120px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=242 vs migrado 'lbl_4c_Label10' Top=185 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=242 vs migrado 'lbl_4c_Label13' Top=201 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=251 vs migrado 'lbl_4c_Label13' Left=41 (diff=210px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=254 vs migrado 'txt_4c_Text6' Top=110 (diff=144px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=194 vs migrado 'txt_4c_Text6' Left=90 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=254 vs migrado 'txt_4c_Text10' Top=174 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=256 vs migrado 'txt_4c_Text10' Left=90 (diff=166px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=21 vs migrado 'lbl_4c_Label14' Top=215 (diff=194px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=38 vs migrado 'lbl_4c_Label14' Left=84 (diff=46px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=41 vs migrado 'lbl_4c_Label7' Top=171 (diff=130px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=314 vs migrado 'lbl_4c_Label7' Left=42 (diff=272px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=183 vs migrado 'lbl_4c_Label19' Left=149 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=213 vs migrado 'txt_4c_Text11' Top=127 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=186 vs migrado 'txt_4c_Text11' Left=393 (diff=207px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=215 vs migrado 'lbl_4c_Label11' Top=313 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=229 vs migrado 'lbl_4c_Label11' Left=41 (diff=188px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=213 vs migrado 'txt_4c_Text12' Top=46 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=235 vs migrado 'txt_4c_Text12' Left=165 (diff=70px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=202 vs migrado 'lbl_4c_Label15' Top=171 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=374 vs migrado 'lbl_4c_Label15' Left=257 (diff=117px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=213 vs migrado 'txt_4c_Text16' Top=46 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=343 vs migrado 'txt_4c_Text16' Left=214 (diff=129px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=215 vs migrado 'lbl_4c_Label17' Top=171 (diff=44px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=213 vs migrado 'txt_4c_Text17' Top=46 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=392 vs migrado 'txt_4c_Text17' Left=261 (diff=131px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=510 vs migrado 'lbl_4c_Label18' Left=408 (diff=102px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=213 vs migrado 'txt_4c_Text18' Top=78 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=499 vs migrado 'txt_4c_Text18' Left=164 (diff=335px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=215 vs migrado 'lbl_4c_Label21' Top=141 (diff=74px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=542 vs migrado 'lbl_4c_Label21' Left=258 (diff=284px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=213 vs migrado 'txt_4c_Text22' Top=142 (diff=71px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=548 vs migrado 'txt_4c_Text22' Left=213 (diff=335px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label22' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=123 vs migrado 'lbl_4c_Label22' Left=301 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label25' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=321 vs migrado 'lbl_4c_Label25' Left=42 (diff=279px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label26' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=375 vs migrado 'lbl_4c_Label26' Left=85 (diff=290px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label27' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=42 vs migrado 'lbl_4c_Label27' Top=252 (diff=210px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label28' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=202 vs migrado 'lbl_4c_Label28' Top=266 (diff=64px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label28' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=134 vs migrado 'lbl_4c_Label28' Left=192 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label29' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=202 vs migrado 'lbl_4c_Label29' Top=282 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label29' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=286 vs migrado 'lbl_4c_Label29' Left=41 (diff=245px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label30' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=202 vs migrado 'lbl_4c_Label30' Top=296 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label30' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=440 vs migrado 'lbl_4c_Label30' Left=84 (diff=356px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label31' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=202 vs migrado 'lbl_4c_Label31' Top=252 (diff=50px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label31' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=603 vs migrado 'lbl_4c_Label31' Left=257 (diff=346px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label32' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=440 vs migrado 'lbl_4c_Label32' Left=300 (diff=140px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label33' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=143 vs migrado 'lbl_4c_Label33' Left=365 (diff=222px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label34' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=486 vs migrado 'lbl_4c_Label34' Left=408 (diff=78px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label35' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=542 vs migrado 'lbl_4c_Label35' Left=149 (diff=393px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label36' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=243 vs migrado 'lbl_4c_Label36' Top=296 (diff=53px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label36' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=603 vs migrado 'lbl_4c_Label36' Left=192 (diff=411px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label37' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=42 vs migrado 'lbl_4c_Label37' Top=127 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label37' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=448 vs migrado 'lbl_4c_Label37' Left=50 (diff=398px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label38' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=56 vs migrado 'lbl_4c_Label38' Top=238 (diff=182px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label38' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=479 vs migrado 'lbl_4c_Label38' Left=52 (diff=427px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label40' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=75 vs migrado 'lbl_4c_Label40' Top=296 (diff=221px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label40' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=479 vs migrado 'lbl_4c_Label40' Left=300 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label42' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=94 vs migrado 'lbl_4c_Label42' Top=40 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label42' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=479 vs migrado 'lbl_4c_Label42' Left=85 (diff=394px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label44' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=113 vs migrado 'lbl_4c_Label44' Top=40 (diff=73px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label44' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=479 vs migrado 'lbl_4c_Label44' Left=193 (diff=286px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label46' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=132 vs migrado 'lbl_4c_Label46' Top=70 (diff=62px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label46' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=479 vs migrado 'lbl_4c_Label46' Left=85 (diff=394px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label50' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=41 vs migrado 'lbl_4c_Label50' Top=100 (diff=59px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label50' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=577 vs migrado 'lbl_4c_Label50' Left=84 (diff=493px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label51' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=672 vs migrado 'lbl_4c_Label51' Left=257 (diff=415px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label54' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Top original=42 vs migrado 'lbl_4c_Label54' Top=100 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label54' (parent: SIGCDNFL.Pagina.Dados.Pagina.Rodape): Left original=533 vs migrado 'lbl_4c_Label54' Left=192 (diff=341px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=31 vs migrado 'lbl_4c_Label53' Top=86 (diff=55px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=99 vs migrado 'lbl_4c_Label53' Left=149 (diff=50px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=43 vs migrado 'txt_4c_Text5' Top=110 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=99 vs migrado 'txt_4c_Text5' Left=41 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=45 vs migrado 'lbl_4c_Label6' Top=155 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=142 vs migrado 'lbl_4c_Label6' Left=409 (diff=267px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=43 vs migrado 'txt_4c_Text6' Top=110 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=148 vs migrado 'txt_4c_Text6' Left=90 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=31 vs migrado 'lbl_4c_Label17' Top=171 (diff=140px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=231 vs migrado 'lbl_4c_Label17' Left=365 (diff=134px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=43 vs migrado 'txt_4c_Text19' Top=78 (diff=35px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=45 vs migrado 'lbl_4c_Label24' Top=327 (diff=282px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=274 vs migrado 'lbl_4c_Label24' Left=192 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=43 vs migrado 'txt_4c_Text23' Top=174 (diff=131px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=280 vs migrado 'txt_4c_Text23' Left=164 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=103 vs migrado 'lbl_4c_Label19' Top=201 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=99 vs migrado 'lbl_4c_Label19' Left=149 (diff=50px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=115 vs migrado 'txt_4c_Text19' Top=78 (diff=37px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=99 vs migrado 'txt_4c_Text19' Left=213 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=117 vs migrado 'lbl_4c_Label20' Top=215 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=142 vs migrado 'lbl_4c_Label20' Left=192 (diff=50px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=67 vs migrado 'lbl_4c_Label35' Top=282 (diff=215px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=231 vs migrado 'lbl_4c_Label35' Left=149 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=231 vs migrado 'txt_4c_Text3' Left=41 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=81 vs migrado 'lbl_4c_Label42' Top=40 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=274 vs migrado 'lbl_4c_Label42' Left=85 (diff=189px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=280 vs migrado 'txt_4c_Text4' Left=90 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=138 vs migrado 'lbl_4c_Label7' Top=171 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=99 vs migrado 'lbl_4c_Label7' Left=42 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=99 vs migrado 'txt_4c_Text7' Left=41 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=152 vs migrado 'lbl_4c_Label8' Top=185 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=142 vs migrado 'lbl_4c_Label8' Left=85 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=148 vs migrado 'txt_4c_Text8' Left=90 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=103 vs migrado 'lbl_4c_Label9' Top=171 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=231 vs migrado 'lbl_4c_Label9' Left=149 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=115 vs migrado 'txt_4c_Text9' Top=174 (diff=59px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=231 vs migrado 'txt_4c_Text9' Left=41 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=117 vs migrado 'lbl_4c_Label10' Top=185 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=274 vs migrado 'lbl_4c_Label10' Left=192 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=115 vs migrado 'txt_4c_Text10' Top=174 (diff=59px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=280 vs migrado 'txt_4c_Text10' Left=90 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=67 vs migrado 'lbl_4c_Label11' Top=313 (diff=246px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=98 vs migrado 'lbl_4c_Label11' Left=41 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=79 vs migrado 'txt_4c_Text11' Top=127 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=98 vs migrado 'txt_4c_Text11' Left=393 (diff=295px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=81 vs migrado 'lbl_4c_Label12' Top=327 (diff=246px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Left original=141 vs migrado 'lbl_4c_Label12' Left=84 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Fatura): Top original=79 vs migrado 'txt_4c_Text12' Top=46 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Top original=30 vs migrado 'lbl_4c_Label17' Top=171 (diff=141px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=105 vs migrado 'lbl_4c_Label17' Left=365 (diff=260px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Top original=43 vs migrado 'txt_4c_Text19' Top=78 (diff=35px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=107 vs migrado 'txt_4c_Text19' Left=213 (diff=106px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Top original=45 vs migrado 'lbl_4c_Label24' Top=327 (diff=282px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=150 vs migrado 'lbl_4c_Label24' Left=192 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Top original=43 vs migrado 'txt_4c_Text23' Top=174 (diff=131px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Top original=81 vs migrado 'lbl_4c_Label35' Top=282 (diff=201px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=107 vs migrado 'lbl_4c_Label35' Left=149 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=107 vs migrado 'txt_4c_Text3' Left=41 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Top original=95 vs migrado 'lbl_4c_Label42' Top=40 (diff=55px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=150 vs migrado 'lbl_4c_Label42' Left=85 (diff=65px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=156 vs migrado 'txt_4c_Text4' Left=90 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=107 vs migrado 'lbl_4c_Label53' Left=149 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=107 vs migrado 'txt_4c_Text5' Left=41 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=150 vs migrado 'lbl_4c_Label6' Left=409 (diff=259px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=156 vs migrado 'txt_4c_Text6' Left=90 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Top original=31 vs migrado 'lbl_4c_Label7' Top=171 (diff=140px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=206 vs migrado 'lbl_4c_Label7' Left=42 (diff=164px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Top original=31 vs migrado 'lbl_4c_Label8' Top=185 (diff=154px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=273 vs migrado 'lbl_4c_Label8' Left=85 (diff=188px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Top original=43 vs migrado 'txt_4c_Text7' Top=142 (diff=99px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=214 vs migrado 'txt_4c_Text7' Left=41 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Top original=43 vs migrado 'txt_4c_Text8' Top=142 (diff=99px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.servicos): Left original=273 vs migrado 'txt_4c_Text8' Left=90 (diff=183px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=67 vs migrado 'lbl_4c_Label20' Top=215 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label20' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=156 vs migrado 'lbl_4c_Label20' Left=192 (diff=36px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=65 vs migrado 'txt_4c_Text21' Top=142 (diff=77px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=243 vs migrado 'txt_4c_Text21' Left=164 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=93 vs migrado 'lbl_4c_Label17' Top=171 (diff=78px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=133 vs migrado 'lbl_4c_Label17' Left=365 (diff=232px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=163 vs migrado 'lbl_4c_Label42' Left=85 (diff=78px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=40 vs migrado 'txt_4c_Text3' Top=78 (diff=38px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=243 vs migrado 'txt_4c_Text3' Left=41 (diff=202px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=117 vs migrado 'lbl_4c_Label53' Top=86 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=115 vs migrado 'txt_4c_Text23' Top=174 (diff=59px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text2' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=243 vs migrado 'txt_4c_Text23' Left=164 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=117 vs migrado 'lbl_4c_Label6' Top=155 (diff=38px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=314 vs migrado 'lbl_4c_Label6' Left=409 (diff=95px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=185 vs migrado 'lbl_4c_Label7' Left=42 (diff=143px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=53 vs migrado 'lbl_4c_Label9' Top=171 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=405 vs migrado 'lbl_4c_Label9' Left=149 (diff=256px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=405 vs migrado 'txt_4c_Text4' Left=90 (diff=315px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=67 vs migrado 'lbl_4c_Label10' Top=185 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=448 vs migrado 'lbl_4c_Label10' Left=192 (diff=256px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=65 vs migrado 'txt_4c_Text5' Top=110 (diff=45px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text5' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=454 vs migrado 'txt_4c_Text5' Left=41 (diff=413px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=85 vs migrado 'lbl_4c_Label11' Top=313 (diff=228px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=405 vs migrado 'lbl_4c_Label11' Left=41 (diff=364px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text6' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=405 vs migrado 'txt_4c_Text6' Left=90 (diff=315px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=99 vs migrado 'lbl_4c_Label12' Top=327 (diff=228px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=448 vs migrado 'lbl_4c_Label12' Left=84 (diff=364px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=97 vs migrado 'txt_4c_Text7' Top=142 (diff=45px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text7' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=454 vs migrado 'txt_4c_Text7' Left=41 (diff=413px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=85 vs migrado 'lbl_4c_Label13' Top=201 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=507 vs migrado 'lbl_4c_Label13' Left=41 (diff=466px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=97 vs migrado 'txt_4c_Text8' Top=142 (diff=45px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text8' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=507 vs migrado 'txt_4c_Text8' Left=90 (diff=417px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=99 vs migrado 'lbl_4c_Label14' Top=215 (diff=116px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=550 vs migrado 'lbl_4c_Label14' Left=84 (diff=466px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=97 vs migrado 'txt_4c_Text9' Top=174 (diff=77px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text9' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=556 vs migrado 'txt_4c_Text9' Left=41 (diff=515px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=117 vs migrado 'lbl_4c_Label15' Top=171 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label15' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=405 vs migrado 'lbl_4c_Label15' Left=257 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=129 vs migrado 'txt_4c_Text10' Top=174 (diff=45px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text10' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=405 vs migrado 'txt_4c_Text10' Left=90 (diff=315px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=131 vs migrado 'lbl_4c_Label16' Top=185 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label16' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=448 vs migrado 'lbl_4c_Label16' Left=300 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text11' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=454 vs migrado 'txt_4c_Text11' Left=393 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=117 vs migrado 'lbl_4c_Label17' Top=171 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label17' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=507 vs migrado 'lbl_4c_Label17' Left=365 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=129 vs migrado 'txt_4c_Text12' Top=46 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text12' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=507 vs migrado 'txt_4c_Text12' Left=165 (diff=342px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=131 vs migrado 'lbl_4c_Label18' Top=185 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label18' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=550 vs migrado 'lbl_4c_Label18' Left=408 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=129 vs migrado 'txt_4c_Text13' Top=61 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text13' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=556 vs migrado 'txt_4c_Text13' Left=393 (diff=163px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label57' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=405 vs migrado 'lbl_4c_Label57' Left=50 (diff=355px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label19' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=195 vs migrado 'lbl_4c_Label19' Left=149 (diff=46px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=205 vs migrado 'lbl_4c_Label21' Top=141 (diff=64px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label21' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=123 vs migrado 'lbl_4c_Label21' Left=258 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Top original=203 vs migrado 'txt_4c_Text14' Top=93 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text14' (parent: SIGCDNFL.Pagina.Dados.Pagina.Outros): Left original=243 vs migrado 'txt_4c_Text14' Left=393 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados): Top original=25 vs migrado 'lbl_4c_Label24' Top=327 (diff=302px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDNFL.Pagina.Dados): Left original=132 vs migrado 'lbl_4c_Label24' Left=192 (diff=60px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ProxNota' (parent: SIGCDNFL.Pagina.Dados): Top original=21 vs migrado 'lbl_4c_LblProxNota' Top=54 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ProxNota' (parent: SIGCDNFL.Pagina.Dados): Left original=245 vs migrado 'lbl_4c_LblProxNota' Left=132 (diff=113px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_ItCasas' (parent: SIGCDNFL.Pagina.Dados): Top original=96 vs migrado 'obj_4c_Op_ItCasas' Top=2 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_ItCasas' (parent: SIGCDNFL.Pagina.Dados): Left original=242 vs migrado 'obj_4c_Op_ItCasas' Left=5 (diff=237px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDNFL.Pagina.Dados): Top original=49 vs migrado 'lbl_4c_Label35' Top=282 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ProxSelo' (parent: SIGCDNFL.Pagina.Dados): Top original=45 vs migrado 'lbl_4c_LblProxSeloTrans' Top=102 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ProxSelo' (parent: SIGCDNFL.Pagina.Dados): Left original=245 vs migrado 'lbl_4c_LblProxSeloTrans' Left=108 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDNFL.Pagina.Dados): Top original=73 vs migrado 'lbl_4c_Label8' Top=185 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ProxSeloTrans' (parent: SIGCDNFL.Pagina.Dados): Top original=69 vs migrado 'lbl_4c_LblProxSeloTrans' Top=102 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ProxSeloTrans' (parent: SIGCDNFL.Pagina.Dados): Left original=245 vs migrado 'lbl_4c_LblProxSeloTrans' Left=108 (diff=137px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormNfl.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (11097 linhas total):

*-- Linhas 20 a 152:
20: 
21:     this_oBusinessObject        = .NULL.
22:     this_cModoAtual             = "LISTA"
23:     this_cUltimoSeriesValidado  = ""
24: 
25:     *--------------------------------------------------------------------------
26:     PROCEDURE Init()
27:         RETURN DODEFAULT()
28:     ENDPROC
29: 
30:     *--------------------------------------------------------------------------
31:     PROTECTED PROCEDURE InicializarForm()
32:         LOCAL loc_lSucesso
33:         loc_lSucesso = .F.
34: 
35:         TRY
36:             THIS.Caption = "Configura" + CHR(231) + CHR(227) + "o de Nota Fiscal"
37: 
38:             THIS.this_oBusinessObject = CREATEOBJECT("NflBO")
39: 
40:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
41:                 MsgErro("Erro ao criar NflBO.", "FormNfl")
42:             ELSE
43:                 THIS.ConfigurarPageFrame()
44:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
45:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
46:                 THIS.ConfigurarPaginaLista()
47: 
48:                 *-- Criar cursores para ControlSource dos controles das 10 abas
49:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
50:                     IF !USED("crSigCnFNf")
51:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCnFNf", "crSigCnFNf") > 0
52:                             APPEND BLANK IN crSigCnFNf
53:                         ENDIF
54:                     ENDIF
55:                     IF !USED("crSigCnFN2")
56:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCnFN2", "crSigCnFN2") > 0
57:                             APPEND BLANK IN crSigCnFN2
58:                         ENDIF
59:                     ENDIF
60:                 ELSE
61:                     IF !USED("crSigCnFNf")
62:                         CREATE CURSOR crSigCnFNf (cidchaves c(20), emps c(3), series c(3))
63:                         APPEND BLANK IN crSigCnFNf
64:                     ENDIF
65:                     IF !USED("crSigCnFN2")
66:                         CREATE CURSOR crSigCnFN2 (cidchaves c(20), emps c(3), series c(3))
67:                         APPEND BLANK IN crSigCnFN2
68:                     ENDIF
69:                 ENDIF
70: 
71:                 THIS.ConfigurarPaginaDados()
72:                 THIS.TornarControlesVisiveis(THIS)
73: 
74:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
75:                     THIS.CarregarLista()
76:                 ENDIF
77: 
78:                 THIS.pgf_4c_Paginas.Visible = .T.
79:                 THIS.pgf_4c_Paginas.ActivePage = 1
80:                 THIS.this_cModoAtual = "LISTA"
81:                 THIS.AjustarBotoesPorModo("LISTA")
82:                 loc_lSucesso = .T.
83:             ENDIF
84:         CATCH TO loc_oErro
85:             MsgErro(loc_oErro.Message, "FormNfl.InicializarForm")
86:         ENDTRY
87: 
88:         RETURN loc_lSucesso
89:     ENDPROC
90: 
91:     *--------------------------------------------------------------------------
92:     PROTECTED PROCEDURE ConfigurarPageFrame()
93:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
94:         WITH THIS.pgf_4c_Paginas
95:             .PageCount   = 2
96:             .Top         = -29
97:             .Left        = 0
98:             .Width       = THIS.Width
99:             .Height      = THIS.Height + 29
100:             .Tabs        = .F.
101:             .Visible     = .T.
102:             .Page1.Caption = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.Caption = "Dados"
105:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
106:             .Page1.BackColor = RGB(255, 255, 255)
107:             .Page2.BackColor = RGB(255, 255, 255)
108:         ENDWITH
109:     ENDPROC
110: 
111:     *--------------------------------------------------------------------------
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()
113:         LOCAL loc_oPagina
114:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
115: 
116:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
117:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118: 
119:         *-- Cabecalho (faixa escura com titulo shadow + titulo principal)
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top       = 2
123:             .Left      = 0
124:             .Width     = THIS.Width
125:             .Height    = 80
126:             .BackColor = RGB(100, 100, 100)
127:             .Visible   = .T.
128:             .AddObject("lbl_4c_Sombra", "Label")
129:             WITH .lbl_4c_Sombra
130:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o de Nota Fiscal"
131:                 .Top       = 35
132:                 .Left      = 22
133:                 .Width     = THIS.Width
134:                 .Height    = 28
135:                 .FontName  = "Tahoma"
136:                 .FontSize  = 16
137:                 .ForeColor = RGB(0, 0, 0)
138:                 .BackStyle = 0
139:                 .Visible   = .T.
140:             ENDWITH
141:             .AddObject("lbl_4c_Titulo", "Label")
142:             WITH .lbl_4c_Titulo
143:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o de Nota Fiscal"
144:                 .Top       = 33
145:                 .Left      = 20
146:                 .Width     = THIS.Width
147:                 .Height    = 28
148:                 .FontName  = "Tahoma"
149:                 .FontSize  = 16
150:                 .ForeColor = RGB(255, 255, 255)
151:                 .BackStyle = 0
152:                 .Visible   = .T.

*-- Linhas 379 a 441:
379:             ENDWITH
380:         ENDWITH
381: 
382:         *-- BINDEVENTs (handlers PUBLIC obrigatorio para BINDEVENT funcionar)
383:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
384:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
385:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
386:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
387:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
388:         BINDEVENT(loc_oPagina.cmd_4c_Copia,                    "Click", THIS, "BtnCopiaClick")
389:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
390:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML,                "Click", THIS, "BtnExpXMLClick")
391:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML,                "Click", THIS, "BtnImpXMLClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_copia.cmd_4c_OK,          "Click",    THIS, "CntCopiaOKClick")
393:         BINDEVENT(loc_oPagina.cnt_4c_copia.cmd_4c_Cancela,     "Click",    THIS, "CntCopiaCancelaClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_nomedest,    "KeyPress", THIS, "NomedestKeyPress")
395:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_nomedest,    "DblClick", THIS, "NomedestDblClick")
396:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_empDest,     "KeyPress", THIS, "EmpDestKeyPress")
397:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_empDest,     "DblClick", THIS, "EmpDestDblClick")
398:     ENDPROC
399: 
400:     *--------------------------------------------------------------------------
401:     PROTECTED PROCEDURE ConfigurarPaginaDados()
402:         LOCAL loc_oPagina
403:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
404: 
405:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
406:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
407: 
408:         *-- Serie (Top original=27/23, +29 comp)
409:         loc_oPagina.AddObject("lbl_4c_LblSerie", "Label")
410:         WITH loc_oPagina.lbl_4c_LblSerie
411:             .Caption   = "S" + CHR(233) + "rie :"
412:             .Top       = 56
413:             .Left      = 23
414:             .Height    = 15
415:             .Width     = 45
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .BackStyle = 0
419:             .ForeColor = RGB(90, 90, 90)
420:             .Visible   = .T.
421:         ENDWITH
422:         loc_oPagina.AddObject("txt_4c_Series", "TextBox")
423:         WITH loc_oPagina.txt_4c_Series
424:             .Top           = 52
425:             .Left          = 65
426:             .Width         = 31
427:             .Height        = 24
428:             .MaxLength     = 3
429:             .FontName      = "Tahoma"
430:             .FontSize      = 8
431:             .SpecialEffect = 1
432:             .Visible       = .T.
433:         ENDWITH
434: 
435:         *-- Proxima Nota Fiscal (Top original=25/21, +29 comp)
436:         loc_oPagina.AddObject("lbl_4c_LblProxNota", "Label")
437:         WITH loc_oPagina.lbl_4c_LblProxNota
438:             .Caption   = "Pr" + CHR(243) + "xima Nota Fiscal :"
439:             .Top       = 54
440:             .Left      = 132
441:             .Width     = 105

*-- Linhas 524 a 567:
524:             .ForeColor = RGB(90, 90, 90)
525:             .Visible   = .T.
526:         ENDWITH
527:         loc_oPagina.AddObject("obj_4c_Op_ItCasas", "OptionGroup")
528:         WITH loc_oPagina.obj_4c_Op_ItCasas
529:             .Top         = 125
530:             .Left        = 242
531:             .Width       = 126
532:             .Height      = 20
533:             .BackStyle   = 0
534:             .BorderStyle = 0
535:             .Value       = 1
536:             .Visible     = .T.
537:             WITH .Buttons(1)
538:                 .Caption   = "2 Casas"
539:                 .Left      = 5
540:                 .Top       = 2
541:                 .AutoSize  = .T.
542:                 .BackStyle = 0
543:                 .ForeColor = RGB(90, 90, 90)
544:             ENDWITH
545:             WITH .Buttons(2)
546:                 .Caption   = "4 Casas"
547:                 .Left      = 68
548:                 .Top       = 2
549:                 .AutoSize  = .T.
550:                 .BackStyle = 0
551:                 .FontName  = "Tahoma"
552:                 .FontSize  = 8
553:                 .ForeColor = RGB(90, 90, 90)
554:             ENDWITH
555:         ENDWITH
556: 
557:         *-- Grupo_Salva (Confirmar + Cancelar), Top original=7, +29 comp
558:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
559:         WITH loc_oPagina.cnt_4c_Salva
560:             .Top         = 36
561:             .Left        = 819
562:             .Width       = 161
563:             .Height      = 85
564:             .BackStyle   = 0
565:             .BorderWidth = 0
566:             .Visible     = .T.
567:             .AddObject("cmd_4c_Confirmar", "CommandButton")

*-- Linhas 629 a 935:
629:         THIS.ConfigurarServicosTab()
630:         THIS.ConfigurarOutrosTab()
631: 
632:         *-- BINDEVENTs Page2 diretos
633:         BINDEVENT(loc_oPagina.txt_4c_Series,                 "LostFocus",    THIS, "SeriesDadosValid")
634:         BINDEVENT(loc_oPagina.txt_4c_Series,                 "KeyPress", THIS, "SeriesKeyPress")
635:         BINDEVENT(loc_oPagina.txt_4c_Series,                 "DblClick", THIS, "SeriesDblClick")
636:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click",   THIS, "ConfirmarClick")
637:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click",   THIS, "CancelarClick")
638: 
639:         *-- BINDEVENTs lookups nas abas internas
640:         LOCAL loc_oAbas, loc_oRdp, loc_nBI, loc_cBI
641:         loc_oAbas = loc_oPagina.pgf_4c_Abas
642: 
643:         *-- EmpPad (Outros, aba 10)
644:         BINDEVENT(loc_oAbas.Page10.txt_4c_EmpPad, "KeyPress", THIS, "EmpPadKeyPress")
645:         BINDEVENT(loc_oAbas.Page10.txt_4c_EmpPad, "DblClick", THIS, "EmpPadDblClick")
646:         BINDEVENT(loc_oAbas.Page10.txt_4c_EmpPad, "KeyPress",    THIS, "EmpPadValid")
647: 
648:         *-- UnPesos (Transporte, aba 6)
649:         BINDEVENT(loc_oAbas.Page6.txt_4c_UnPesos, "KeyPress", THIS, "UnPesosKeyPress")
650:         BINDEVENT(loc_oAbas.Page6.txt_4c_UnPesos, "DblClick", THIS, "UnPesosDblClick")
651:         BINDEVENT(loc_oAbas.Page6.txt_4c_UnPesos, "KeyPress",    THIS, "UnPesosValid")
652: 
653:         *-- CodImp 1-7 (Rodape, aba 7, bloco 1)
654:         loc_oRdp = loc_oAbas.Page7
655:         LOCAL loc_oTxtDin
656:         FOR loc_nBI = 1 TO 7
657:             loc_cBI    = ALLTRIM(STR(loc_nBI))
658:             loc_oTxtDin = THIS.ObterControle(loc_oRdp, "txt_4c_CodImp" + loc_cBI)
659:             IF VARTYPE(loc_oTxtDin) = "O"
660:                 BINDEVENT(loc_oTxtDin, "KeyPress",  THIS, "CodImp"  + loc_cBI + "KeyPress")
661:                 BINDEVENT(loc_oTxtDin, "DblClick",  THIS, "CodImp"  + loc_cBI + "DblClick")
662:                 BINDEVENT(loc_oTxtDin, "LostFocus", THIS, "CodImp"  + loc_cBI + "LostFocus")
663:             ENDIF
664:         ENDFOR
665: 
666:         *-- CodImpB 8-12 (Rodape, aba 7, bloco 2)
667:         FOR loc_nBI = 8 TO 12
668:             loc_cBI    = ALLTRIM(STR(loc_nBI))
669:             loc_oTxtDin = THIS.ObterControle(loc_oRdp, "txt_4c_CodImpB" + loc_cBI)
670:             IF VARTYPE(loc_oTxtDin) = "O"
671:                 BINDEVENT(loc_oTxtDin, "KeyPress",  THIS, "CodImpB" + loc_cBI + "KeyPress")
672:                 BINDEVENT(loc_oTxtDin, "DblClick",  THIS, "CodImpB" + loc_cBI + "DblClick")
673:                 BINDEVENT(loc_oTxtDin, "LostFocus", THIS, "CodImpB" + loc_cBI + "LostFocus")
674:             ENDIF
675:         ENDFOR
676: 
677:         *-- Get_Class (Rodape, aba 7)
678:         BINDEVENT(loc_oRdp.obj_4c_ClsFisTp, "Click", THIS, "ClsFisTpClick")
679:     ENDPROC
680: 
681:     *--------------------------------------------------------------------------
682:     PROCEDURE CarregarLista()
683:         LOCAL loc_lResultado
684:         loc_lResultado = .F.
685: 
686:         TRY
687:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
688:                 loc_lResultado = .T.
689:             ELSE
690:                 loc_lResultado = THIS.this_oBusinessObject.Buscar("")
691:                 IF loc_lResultado AND VARTYPE(THIS.pgf_4c_Paginas) = "O"
692:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
693:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 4
694:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
695:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.emps"
696:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.Razas"
697:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.series"
698:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.cidchaves"
699:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Empr."
700:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Empresa"
701:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.Header1.Caption = "S" + CHR(233) + "rie"
702:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.Header1.Caption = "Chave"
703:                     ENDIF
704:                 ENDIF
705:             ENDIF
706:         CATCH TO loc_oErro
707:             MsgErro(loc_oErro.Message, "FormNfl.CarregarLista")
708:         ENDTRY
709: 
710:         RETURN loc_lResultado
711:     ENDPROC
712: 
713:     *--------------------------------------------------------------------------
714:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
715:         LOCAL loc_lResultado
716:         loc_lResultado = .F.
717: 
718:         TRY
719:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
720:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
721:                 IF par_nPagina = 1
722:                     THIS.this_cModoAtual = "LISTA"
723:                     THIS.AjustarBotoesPorModo("LISTA")
724:                     THIS.CarregarLista()
725:                 ENDIF
726:                 loc_lResultado = .T.
727:             ENDIF
728:         CATCH TO loc_oErro
729:             MsgErro(loc_oErro.Message, "FormNfl.AlternarPagina")
730:         ENDTRY
731: 
732:         RETURN loc_lResultado
733:     ENDPROC
734: 
735:     *--------------------------------------------------------------------------
736:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
737:         WITH par_oGrid
738:             .FontName = "Tahoma"
739:             .FontSize = 8
740:             .SetAll("ForeColor", RGB(90, 90, 90), "Column")
741:         ENDWITH
742:     ENDPROC
743: 
744:     *--------------------------------------------------------------------------
745:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
746:         LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP
747:         FOR loc_nI = 1 TO par_oContainer.ControlCount
748:             loc_oObjeto = par_oContainer.Controls(loc_nI)
749:             IF VARTYPE(loc_oObjeto) = "O"
750:                 loc_cNome = UPPER(loc_oObjeto.Name)
751: 
752:                 IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_SALVA")
753:                     LOOP
754:                 ENDIF
755: 
756:                 IF loc_cNome == "CNT_4C_COPIA"
757:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
758:                         THIS.TornarControlesVisiveis(loc_oObjeto)
759:                     ENDIF
760:                     LOOP
761:                 ENDIF
762: 
763:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
764:                     loc_oObjeto.Visible = .T.
765:                 ENDIF
766: 
767:                 IF PEMSTATUS(loc_oObjeto, "BaseClass", 5) AND UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
768:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
769:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
770:                     ENDFOR
771:                 ENDIF
772: 
773:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
774:                     THIS.TornarControlesVisiveis(loc_oObjeto)
775:                 ENDIF
776:             ENDIF
777:         ENDFOR
778:     ENDPROC
779: 
780:     *--------------------------------------------------------------------------
781:     PROTECTED PROCEDURE LimparCampos()
782:         LOCAL loc_oPag2
783:         TRY
784:             IF USED("crSigCnFNf")
785:                 ZAP IN crSigCnFNf
786:                 APPEND BLANK IN crSigCnFNf
787:             ENDIF
788:             IF USED("crSigCnFN2")
789:                 ZAP IN crSigCnFN2
790:                 APPEND BLANK IN crSigCnFN2
791:             ENDIF
792:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
793:                 loc_oPag2 = THIS.pgf_4c_Paginas.Page2
794:                 IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
795:                     loc_oPag2.txt_4c_Series.Value = ""
796:                 ENDIF
797:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxNota", 5)
798:                     loc_oPag2.txt_4c_ProxNota.Value = ""
799:                 ENDIF
800:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxSelo", 5)
801:                     loc_oPag2.txt_4c_ProxSelo.Value = ""
802:                 ENDIF
803:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxSeloTrans", 5)
804:                     loc_oPag2.txt_4c_ProxSeloTrans.Value = ""
805:                 ENDIF
806:                 IF PEMSTATUS(loc_oPag2, "obj_4c_Op_ItCasas", 5)
807:                     loc_oPag2.obj_4c_Op_ItCasas.Value = 1
808:                 ENDIF
809:                 IF VARTYPE(loc_oPag2.pgf_4c_Abas) = "O"
810:                     IF PEMSTATUS(loc_oPag2.pgf_4c_Abas.Page10, "txt_4c_EmpPad", 5)
811:                         loc_oPag2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value = ""
812:                     ENDIF
813:                 ENDIF
814:             ENDIF
815:         CATCH TO loc_oErro
816:             MsgErro(loc_oErro.Message, "FormNfl.LimparCampos")
817:         ENDTRY
818:     ENDPROC
819: 
820:     *--------------------------------------------------------------------------
821:     * HabilitarCampos - Habilita/desabilita campos de entrada da Page2 (todas as abas)
822:     * par_lHabilitar = .T. para habilitar edicao, .F. para modo VISUALIZAR
823:     * A chave (Series) so eh editavel em modo INCLUIR
824:     *--------------------------------------------------------------------------
825:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
826:         LOCAL loc_oPag2, loc_lChaveEdit
827:         TRY
828:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
829:                 loc_oPag2      = THIS.pgf_4c_Paginas.Page2
830:                 loc_lChaveEdit = (THIS.this_cModoAtual = "INCLUIR")
831: 
832:                 *-- Campos standalone Page2
833:                 IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
834:                     loc_oPag2.txt_4c_Series.Enabled = loc_lChaveEdit
835:                 ENDIF
836:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxNota", 5)
837:                     loc_oPag2.txt_4c_ProxNota.Enabled = par_lHabilitar
838:                 ENDIF
839:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxSelo", 5)
840:                     loc_oPag2.txt_4c_ProxSelo.Enabled = par_lHabilitar
841:                 ENDIF
842:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxSeloTrans", 5)
843:                     loc_oPag2.txt_4c_ProxSeloTrans.Enabled = par_lHabilitar
844:                 ENDIF
845:                 IF PEMSTATUS(loc_oPag2, "obj_4c_Op_ItCasas", 5)
846:                     loc_oPag2.obj_4c_Op_ItCasas.Enabled = par_lHabilitar
847:                 ENDIF
848: 
849:                 *-- Recursivamente aplica a todas as abas internas
850:                 IF PEMSTATUS(loc_oPag2, "pgf_4c_Abas", 5)
851:                     THIS.AplicarEnabledRecursivo(loc_oPag2.pgf_4c_Abas, par_lHabilitar)
852:                 ENDIF
853:             ENDIF
854:         CATCH TO loc_oErro
855:             MsgErro(loc_oErro.Message, "FormNfl.HabilitarCampos")
856:         ENDTRY
857:     ENDPROC
858: 
859:     *--------------------------------------------------------------------------
860:     * AplicarEnabledRecursivo - Percorre container e seta Enabled em controles de entrada
861:     *--------------------------------------------------------------------------
862:     PROTECTED PROCEDURE AplicarEnabledRecursivo(par_oContainer, par_lEnabled)
863:         LOCAL loc_nI, loc_oCtrl, loc_cBase, loc_nP
864:         FOR loc_nI = 1 TO par_oContainer.ControlCount
865:             loc_oCtrl = par_oContainer.Controls(loc_nI)
866:             IF VARTYPE(loc_oCtrl) != "O"
867:                 LOOP
868:             ENDIF
869:             IF !PEMSTATUS(loc_oCtrl, "BaseClass", 5)
870:                 LOOP
871:             ENDIF
872:             loc_cBase = UPPER(loc_oCtrl.BaseClass)
873: 
874:             DO CASE
875:                 CASE loc_cBase = "PAGEFRAME"
876:                     FOR loc_nP = 1 TO loc_oCtrl.PageCount
877:                         THIS.AplicarEnabledRecursivo(loc_oCtrl.Pages(loc_nP), par_lEnabled)
878:                     ENDFOR
879:                 CASE INLIST(loc_cBase, "CONTAINER", "PAGE")
880:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
881:                         THIS.AplicarEnabledRecursivo(loc_oCtrl, par_lEnabled)
882:                     ENDIF
883:                 CASE INLIST(loc_cBase, "TEXTBOX", "EDITBOX", "COMBOBOX", "CHECKBOX", "OPTIONGROUP", "SPINNER")
884:                     IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
885:                         loc_oCtrl.Enabled = par_lEnabled
886:                     ENDIF
887:             ENDCASE
888:         ENDFOR
889:     ENDPROC
890: 
891:     *--------------------------------------------------------------------------
892:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD/Salvar/Cancelar
893:     * par_cModo: "LISTA", "INCLUIR", "ALTERAR", "VISUALIZAR"
894:     *--------------------------------------------------------------------------
895:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
896:         LOCAL loc_oPag1, loc_oPag2, loc_oBot, loc_oSal
897:         LOCAL loc_lLista, loc_lEditando, loc_lVisualiza
898:         TRY
899:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
900:                 loc_oPag1      = THIS.pgf_4c_Paginas.Page1
901:                 loc_oPag2      = THIS.pgf_4c_Paginas.Page2
902:                 loc_lLista     = (par_cModo = "LISTA")
903:                 loc_lEditando  = (par_cModo = "INCLUIR" OR par_cModo = "ALTERAR")
904:                 loc_lVisualiza = (par_cModo = "VISUALIZAR")
905: 
906:                 *-- Botoes CRUD Page1
907:                 IF PEMSTATUS(loc_oPag1, "cnt_4c_Botoes", 5)
908:                     loc_oBot = loc_oPag1.cnt_4c_Botoes
909:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Incluir", 5)
910:                         loc_oBot.cmd_4c_Incluir.Enabled    = loc_lLista
911:                     ENDIF
912:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Visualizar", 5)
913:                         loc_oBot.cmd_4c_Visualizar.Enabled = loc_lLista
914:                     ENDIF
915:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Alterar", 5)
916:                         loc_oBot.cmd_4c_Alterar.Enabled    = loc_lLista
917:                     ENDIF
918:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Excluir", 5)
919:                         loc_oBot.cmd_4c_Excluir.Enabled    = loc_lLista
920:                     ENDIF
921:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Buscar", 5)
922:                         loc_oBot.cmd_4c_Buscar.Enabled     = loc_lLista
923:                     ENDIF
924:                 ENDIF
925:                 IF PEMSTATUS(loc_oPag1, "cmd_4c_Copia", 5)
926:                     loc_oPag1.cmd_4c_Copia.Enabled       = loc_lLista
927:                 ENDIF
928:                 IF PEMSTATUS(loc_oPag1, "cmd_4c_BtnExpXML", 5)
929:                     loc_oPag1.cmd_4c_BtnExpXML.Enabled   = loc_lLista
930:                 ENDIF
931:                 IF PEMSTATUS(loc_oPag1, "cmd_4c_BtnImpXML", 5)
932:                     loc_oPag1.cmd_4c_BtnImpXML.Enabled   = loc_lLista
933:                 ENDIF
934: 
935:                 *-- Botoes Confirmar/Cancelar Page2

*-- Linhas 949 a 1201:
949:     ENDPROC
950: 
951:     *--------------------------------------------------------------------------
952:     PROCEDURE BtnIncluirClick()
953:         LOCAL loc_lResultado
954:         loc_lResultado = .F.
955:         TRY
956:             THIS.this_oBusinessObject.NovoRegistro()
957:             THIS.LimparCampos()
958:             THIS.this_cModoAtual = "INCLUIR"
959:             THIS.HabilitarCampos(.T.)
960:             THIS.AjustarBotoesPorModo("INCLUIR")
961:             THIS.AlternarPagina(2)
962:             THIS.this_cModoAtual = "INCLUIR"
963:             loc_lResultado = .T.
964:         CATCH TO loc_oErro
965:             MsgErro(loc_oErro.Message, "FormNfl.BtnIncluirClick")
966:         ENDTRY
967:         RETURN loc_lResultado
968:     ENDPROC
969: 
970:     *--------------------------------------------------------------------------
971:     PROCEDURE BtnVisualizarClick()
972:         LOCAL loc_lResultado, loc_cChave
973:         loc_lResultado = .F.
974:         TRY
975:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
976:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
977:             ELSE
978:                 SELECT cursor_4c_Dados
979:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
980:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
981:                     THIS.BOParaForm()
982:                     THIS.this_cModoAtual = "VISUALIZAR"
983:                     THIS.HabilitarCampos(.F.)
984:                     THIS.AjustarBotoesPorModo("VISUALIZAR")
985:                     THIS.AlternarPagina(2)
986:                     THIS.this_cModoAtual = "VISUALIZAR"
987:                     loc_lResultado = .T.
988:                 ENDIF
989:             ENDIF
990:         CATCH TO loc_oErro
991:             MsgErro(loc_oErro.Message, "FormNfl.BtnVisualizarClick")
992:         ENDTRY
993:         RETURN loc_lResultado
994:     ENDPROC
995: 
996:     *--------------------------------------------------------------------------
997:     PROCEDURE BtnAlterarClick()
998:         LOCAL loc_lResultado, loc_cChave
999:         loc_lResultado = .F.
1000:         TRY
1001:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1002:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
1003:             ELSE
1004:                 SELECT cursor_4c_Dados
1005:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1006:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1007:                     THIS.this_oBusinessObject.EditarRegistro()
1008:                     THIS.BOParaForm()
1009:                     THIS.this_cModoAtual = "ALTERAR"
1010:                     THIS.HabilitarCampos(.T.)
1011:                     THIS.AjustarBotoesPorModo("ALTERAR")
1012:                     THIS.AlternarPagina(2)
1013:                     THIS.this_cModoAtual = "ALTERAR"
1014:                     loc_lResultado = .T.
1015:                 ENDIF
1016:             ENDIF
1017:         CATCH TO loc_oErro
1018:             MsgErro(loc_oErro.Message, "FormNfl.BtnAlterarClick")
1019:         ENDTRY
1020:         RETURN loc_lResultado
1021:     ENDPROC
1022: 
1023:     *--------------------------------------------------------------------------
1024:     PROCEDURE BtnExcluirClick()
1025:         LOCAL loc_lResultado, loc_cChave, loc_lConfirma
1026:         loc_lResultado = .F.
1027:         TRY
1028:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1029:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
1030:             ELSE
1031:                 SELECT cursor_4c_Dados
1032:                 loc_cChave    = ALLTRIM(cursor_4c_Dados.cidchaves)
1033:                 loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da configura" + CHR(231) + CHR(227) + "o selecionada?", "FormNfl")
1034:                 IF loc_lConfirma
1035:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1036:                         loc_lResultado = THIS.this_oBusinessObject.Excluir()
1037:                         IF loc_lResultado
1038:                             THIS.CarregarLista()
1039:                         ENDIF
1040:                     ENDIF
1041:                 ENDIF
1042:             ENDIF
1043:         CATCH TO loc_oErro
1044:             MsgErro(loc_oErro.Message, "FormNfl.BtnExcluirClick")
1045:         ENDTRY
1046:         RETURN loc_lResultado
1047:     ENDPROC
1048: 
1049:     *--------------------------------------------------------------------------
1050:     PROCEDURE BtnBuscarClick()
1051:         LOCAL loc_lResultado, loc_cFiltro
1052:         loc_lResultado = .F.
1053:         TRY
1054:             loc_cFiltro    = INPUTBOX("Informe s" + CHR(233) + "rie ou empresa:", "Buscar", "")
1055:             loc_lResultado = THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
1056:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1057:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 4
1058:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
1059:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.emps"
1060:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.Razas"
1061:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.series"
1062:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.cidchaves"
1063:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Empr."
1064:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Empresa"
1065:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.Header1.Caption = "S" + CHR(233) + "rie"
1066:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.Header1.Caption = "Chave"
1067:             ENDIF
1068:         CATCH TO loc_oErro
1069:             MsgErro(loc_oErro.Message, "FormNfl.BtnBuscarClick")
1070:         ENDTRY
1071:         RETURN loc_lResultado
1072:     ENDPROC
1073: 
1074:     *--------------------------------------------------------------------------
1075:     PROCEDURE BtnEncerrarClick()
1076:         THIS.Release()
1077:     ENDPROC
1078: 
1079:     *--------------------------------------------------------------------------
1080:     PROCEDURE BtnCopiaClick()
1081:         TRY
1082:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_copia", 5)
1083:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.Visible = .T.
1084:             ENDIF
1085:         CATCH TO loc_oErro
1086:             MsgErro(loc_oErro.Message, "FormNfl.BtnCopiaClick")
1087:         ENDTRY
1088:     ENDPROC
1089: 
1090:     *--------------------------------------------------------------------------
1091:     PROCEDURE BtnExpXMLClick()
1092:         LOCAL loc_oForm
1093:         TRY
1094:             loc_oForm = CREATEOBJECT("FormSigOpXml")
1095:             IF VARTYPE(loc_oForm) = "O"
1096:                 loc_oForm.Show()
1097:             ENDIF
1098:         CATCH TO loc_oErro
1099:             MsgErro(loc_oErro.Message, "FormNfl.BtnExpXMLClick")
1100:         ENDTRY
1101:     ENDPROC
1102: 
1103:     *--------------------------------------------------------------------------
1104:     PROCEDURE BtnImpXMLClick()
1105:         LOCAL loc_oForm
1106:         TRY
1107:             loc_oForm = CREATEOBJECT("FormSigOpXml")
1108:             IF VARTYPE(loc_oForm) = "O"
1109:                 loc_oForm.Show()
1110:             ENDIF
1111:         CATCH TO loc_oErro
1112:             MsgErro(loc_oErro.Message, "FormNfl.BtnImpXMLClick")
1113:         ENDTRY
1114:     ENDPROC
1115: 
1116:     *--------------------------------------------------------------------------
1117:     PROCEDURE CntCopiaOKClick()
1118:         LOCAL loc_lResultado, loc_cSerieOrig, loc_cSerieDest, loc_cEmpDest
1119:         LOCAL loc_oCopia
1120:         loc_lResultado = .F.
1121:         TRY
1122:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1123:                 MsgAviso("Nenhuma configura" + CHR(231) + CHR(227) + "o selecionada para copiar.", "FormNfl")
1124:             ELSE
1125:                 loc_oCopia     = THIS.pgf_4c_Paginas.Page1.cnt_4c_copia
1126:                 loc_cSerieOrig = ALLTRIM(cursor_4c_Dados.series)
1127:                 loc_cSerieDest = ALLTRIM(loc_oCopia.txt_4c_nomedest.Value)
1128:                 loc_cEmpDest   = ALLTRIM(loc_oCopia.txt_4c_empDest.Value)
1129:                 IF EMPTY(loc_cSerieDest)
1130:                     MsgAviso("Informe a s" + CHR(233) + "rie destino.", "FormNfl")
1131:                 ELSE
1132:                     IF EMPTY(loc_cEmpDest)
1133:                     MsgAviso("Informe a empresa destino.", "FormNfl")
1134:                 ELSE
1135:                     loc_lResultado = THIS.this_oBusinessObject.Copiar(loc_cSerieOrig, loc_cSerieDest, loc_cEmpDest)
1136:                     IF loc_lResultado
1137:                         loc_oCopia.Visible = .F.
1138:                         THIS.CarregarLista()
1139:                     ENDIF
1140:                     ENDIF
1141:                 ENDIF
1142:             ENDIF
1143:         CATCH TO loc_oErro
1144:             MsgErro(loc_oErro.Message, "FormNfl.CntCopiaOKClick")
1145:         ENDTRY
1146:         RETURN loc_lResultado
1147:     ENDPROC
1148: 
1149:     *--------------------------------------------------------------------------
1150:     PROCEDURE CntCopiaCancelaClick()
1151:         TRY
1152:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_copia", 5)
1153:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.Visible = .F.
1154:             ENDIF
1155:         CATCH TO loc_oErro
1156:             MsgErro(loc_oErro.Message, "FormNfl.CntCopiaCancelaClick")
1157:         ENDTRY
1158:     ENDPROC
1159: 
1160:     *--------------------------------------------------------------------------
1161:     PROTECTED PROCEDURE ConfigurarCabecalhoTab()
1162:         LOCAL loc_oAba
1163:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1164: 
1165:         *-- Shape decorativo (painel impressora)
1166:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
1167:         WITH loc_oAba.shp_4c_Shape1
1168:             .Top           = 41
1169:             .Left          = 381
1170:             .Height        = 139
1171:             .Width         = 265
1172:             .BackStyle     = 0
1173:             .SpecialEffect = 0
1174:             .Visible       = .T.
1175:         ENDWITH
1176: 
1177:         *===== Coluna esquerda: dimensoes de impressao NF =====
1178: 
1179:         *-- No NF (l1nf x c1nf)
1180:         loc_oAba.AddObject("lbl_4c_Label1", "Label")
1181:         WITH loc_oAba.lbl_4c_Label1
1182:             .Caption   = "N" + CHR(186) + " NF"
1183:             .Top       = 33
1184:             .Left      = 41
1185:             .Width     = 29
1186:             .Height    = 13
1187:             .FontName  = "Tahoma"
1188:             .FontSize  = 7
1189:             .BackStyle = 0
1190:             .ForeColor = RGB(90, 90, 90)
1191:             .Visible   = .T.
1192:         ENDWITH
1193:         loc_oAba.AddObject("txt_4c_Text1", "TextBox")
1194:         WITH loc_oAba.txt_4c_Text1
1195:             .ControlSource = "crSigCnFNf.l1nf"
1196:             .Top           = 46
1197:             .Left          = 41
1198:             .Width         = 41
1199:             .Height        = 18
1200:             .FontName      = "Tahoma"
1201:             .FontSize      = 8

*-- Linhas 1246 a 1267:
1246:             .FontSize  = 7
1247:             .BackStyle = 0
1248:             .ForeColor = RGB(90, 90, 90)
1249:             .Visible   = .T.
1250:         ENDWITH
1251:         loc_oAba.AddObject("txt_4c_Text3", "TextBox")
1252:         WITH loc_oAba.txt_4c_Text3
1253:             .ControlSource = "crSigCnFNf.lnfsai"
1254:             .Top           = 78
1255:             .Left          = 41
1256:             .Width         = 41
1257:             .Height        = 18
1258:             .FontName      = "Tahoma"
1259:             .FontSize      = 8
1260:             .Format        = "K"
1261:             .InputMask     = "999.99"
1262:             .SpecialEffect = 1
1263:             .Margin        = 0
1264:             .Visible       = .T.
1265:         ENDWITH
1266:         loc_oAba.AddObject("lbl_4c_Label4", "Label")
1267:         WITH loc_oAba.lbl_4c_Label4

*-- Linhas 1274 a 1295:
1274:             .FontSize  = 7
1275:             .BackStyle = 0
1276:             .ForeColor = RGB(90, 90, 90)
1277:             .Visible   = .T.
1278:         ENDWITH
1279:         loc_oAba.AddObject("txt_4c_Text4", "TextBox")
1280:         WITH loc_oAba.txt_4c_Text4
1281:             .ControlSource = "crSigCnFNf.cnfsai"
1282:             .Top           = 78
1283:             .Left          = 90
1284:             .Width         = 41
1285:             .Height        = 18
1286:             .FontName      = "Tahoma"
1287:             .FontSize      = 8
1288:             .Format        = "K"
1289:             .InputMask     = "999.99"
1290:             .SpecialEffect = 1
1291:             .Margin        = 0
1292:             .Visible       = .T.
1293:         ENDWITH
1294: 
1295:         *-- NF Entrada (lnfent x cnfent)

*-- Linhas 1304 a 1325:
1304:             .FontSize  = 7
1305:             .BackStyle = 0
1306:             .ForeColor = RGB(90, 90, 90)
1307:             .Visible   = .T.
1308:         ENDWITH
1309:         loc_oAba.AddObject("txt_4c_Text5", "TextBox")
1310:         WITH loc_oAba.txt_4c_Text5
1311:             .ControlSource = "crSigCnFNf.lnfent"
1312:             .Top           = 110
1313:             .Left          = 41
1314:             .Width         = 41
1315:             .Height        = 18
1316:             .FontName      = "Tahoma"
1317:             .FontSize      = 8
1318:             .Format        = "K"
1319:             .InputMask     = "999.99"
1320:             .SpecialEffect = 1
1321:             .Margin        = 0
1322:             .Visible       = .T.
1323:         ENDWITH
1324:         loc_oAba.AddObject("lbl_4c_Label6", "Label")
1325:         WITH loc_oAba.lbl_4c_Label6

*-- Linhas 1332 a 1353:
1332:             .FontSize  = 7
1333:             .BackStyle = 0
1334:             .ForeColor = RGB(90, 90, 90)
1335:             .Visible   = .T.
1336:         ENDWITH
1337:         loc_oAba.AddObject("txt_4c_Text6", "TextBox")
1338:         WITH loc_oAba.txt_4c_Text6
1339:             .ControlSource = "crSigCnFNf.cnfent"
1340:             .Top           = 110
1341:             .Left          = 90
1342:             .Width         = 41
1343:             .Height        = 18
1344:             .FontName      = "Tahoma"
1345:             .FontSize      = 8
1346:             .Format        = "K"
1347:             .InputMask     = "999.99"
1348:             .SpecialEffect = 1
1349:             .Margin        = 0
1350:             .Visible       = .T.
1351:         ENDWITH
1352: 
1353:         *-- Nat. Operacao (lnatop x cnatop)

*-- Linhas 1362 a 1383:
1362:             .FontSize  = 7
1363:             .BackStyle = 0
1364:             .ForeColor = RGB(90, 90, 90)
1365:             .Visible   = .T.
1366:         ENDWITH
1367:         loc_oAba.AddObject("txt_4c_Text7", "TextBox")
1368:         WITH loc_oAba.txt_4c_Text7
1369:             .ControlSource = "crSigCnFNf.lnatop"
1370:             .Top           = 142
1371:             .Left          = 41
1372:             .Width         = 41
1373:             .Height        = 18
1374:             .FontName      = "Tahoma"
1375:             .FontSize      = 8
1376:             .Format        = "K"
1377:             .InputMask     = "999.99"
1378:             .SpecialEffect = 1
1379:             .Margin        = 0
1380:             .Visible       = .T.
1381:         ENDWITH
1382:         loc_oAba.AddObject("lbl_4c_Label8", "Label")
1383:         WITH loc_oAba.lbl_4c_Label8

*-- Linhas 1390 a 1411:
1390:             .FontSize  = 7
1391:             .BackStyle = 0
1392:             .ForeColor = RGB(90, 90, 90)
1393:             .Visible   = .T.
1394:         ENDWITH
1395:         loc_oAba.AddObject("txt_4c_Text8", "TextBox")
1396:         WITH loc_oAba.txt_4c_Text8
1397:             .ControlSource = "crSigCnFNf.cnatop"
1398:             .Top           = 142
1399:             .Left          = 90
1400:             .Width         = 41
1401:             .Height        = 18
1402:             .FontName      = "Tahoma"
1403:             .FontSize      = 8
1404:             .Format        = "K"
1405:             .InputMask     = "999.99"
1406:             .SpecialEffect = 1
1407:             .Margin        = 0
1408:             .Visible       = .T.
1409:         ENDWITH
1410: 
1411:         *-- CFOP (lcfop x ccfop)

*-- Linhas 1420 a 1441:
1420:             .FontSize  = 7
1421:             .BackStyle = 0
1422:             .ForeColor = RGB(90, 90, 90)
1423:             .Visible   = .T.
1424:         ENDWITH
1425:         loc_oAba.AddObject("txt_4c_Text9", "TextBox")
1426:         WITH loc_oAba.txt_4c_Text9
1427:             .ControlSource = "crSigCnFNf.lcfop"
1428:             .Top           = 174
1429:             .Left          = 41
1430:             .Width         = 41
1431:             .Height        = 18
1432:             .FontName      = "Tahoma"
1433:             .FontSize      = 8
1434:             .Format        = "K"
1435:             .InputMask     = "999.99"
1436:             .SpecialEffect = 1
1437:             .Margin        = 0
1438:             .Visible       = .T.
1439:         ENDWITH
1440:         loc_oAba.AddObject("lbl_4c_Label10", "Label")
1441:         WITH loc_oAba.lbl_4c_Label10

*-- Linhas 1448 a 1469:
1448:             .FontSize  = 7
1449:             .BackStyle = 0
1450:             .ForeColor = RGB(90, 90, 90)
1451:             .Visible   = .T.
1452:         ENDWITH
1453:         loc_oAba.AddObject("txt_4c_Text10", "TextBox")
1454:         WITH loc_oAba.txt_4c_Text10
1455:             .ControlSource = "crSigCnFNf.ccfop"
1456:             .Top           = 174
1457:             .Left          = 90
1458:             .Width         = 41
1459:             .Height        = 18
1460:             .FontName      = "Tahoma"
1461:             .FontSize      = 8
1462:             .Format        = "K"
1463:             .InputMask     = "999.99"
1464:             .SpecialEffect = 1
1465:             .Margin        = 0
1466:             .Visible       = .T.
1467:         ENDWITH
1468: 
1469:         *-- Razao Social (LRAZEMP x CRAZEMP, sem ControlSource)

*-- Linhas 1592 a 1613:
1592:             .FontSize  = 7
1593:             .BackStyle = 0
1594:             .ForeColor = RGB(90, 90, 90)
1595:             .Visible   = .T.
1596:         ENDWITH
1597:         loc_oAba.AddObject("txt_4c_Text12", "TextBox")
1598:         WITH loc_oAba.txt_4c_Text12
1599:             .ControlSource = "crSigCnFN2.lxinc"
1600:             .Top           = 46
1601:             .Left          = 165
1602:             .Width         = 41
1603:             .Height        = 18
1604:             .FontName      = "Tahoma"
1605:             .FontSize      = 8
1606:             .Format        = "K"
1607:             .InputMask     = "999.99"
1608:             .SpecialEffect = 1
1609:             .Margin        = 0
1610:             .Visible       = .T.
1611:         ENDWITH
1612:         loc_oAba.AddObject("lbl_4c_Label20", "Label")
1613:         WITH loc_oAba.lbl_4c_Label20

*-- Linhas 1620 a 1641:
1620:             .FontSize  = 7
1621:             .BackStyle = 0
1622:             .ForeColor = RGB(90, 90, 90)
1623:             .Visible   = .T.
1624:         ENDWITH
1625:         loc_oAba.AddObject("txt_4c_Text16", "TextBox")
1626:         WITH loc_oAba.txt_4c_Text16
1627:             .ControlSource = "crSigCnFN2.cxinc"
1628:             .Top           = 46
1629:             .Left          = 214
1630:             .Width         = 41
1631:             .Height        = 18
1632:             .FontName      = "Tahoma"
1633:             .FontSize      = 8
1634:             .Format        = "K"
1635:             .InputMask     = "999.99"
1636:             .SpecialEffect = 1
1637:             .Margin        = 0
1638:             .Visible       = .T.
1639:         ENDWITH
1640:         loc_oAba.AddObject("lbl_4c_Label21", "Label")
1641:         WITH loc_oAba.lbl_4c_Label21

*-- Linhas 1648 a 1669:
1648:             .FontSize  = 7
1649:             .BackStyle = 0
1650:             .ForeColor = RGB(90, 90, 90)
1651:             .Visible   = .T.
1652:         ENDWITH
1653:         loc_oAba.AddObject("txt_4c_Text17", "TextBox")
1654:         WITH loc_oAba.txt_4c_Text17
1655:             .ControlSource = "crSigCnFN2.lenxinc"
1656:             .Top           = 46
1657:             .Left          = 261
1658:             .Width         = 41
1659:             .Height        = 18
1660:             .FontName      = "Tahoma"
1661:             .FontSize      = 8
1662:             .Format        = "K"
1663:             .InputMask     = "99999"
1664:             .SpecialEffect = 1
1665:             .Margin        = 0
1666:             .Visible       = .T.
1667:         ENDWITH
1668: 
1669:         *-- SAC (lsac x csac + contsac)

*-- Linhas 1678 a 1699:
1678:             .FontSize  = 7
1679:             .BackStyle = 0
1680:             .ForeColor = RGB(90, 90, 90)
1681:             .Visible   = .T.
1682:         ENDWITH
1683:         loc_oAba.AddObject("txt_4c_Text18", "TextBox")
1684:         WITH loc_oAba.txt_4c_Text18
1685:             .ControlSource = "crSigCnFN2.lsac"
1686:             .Top           = 78
1687:             .Left          = 164
1688:             .Width         = 41
1689:             .Height        = 18
1690:             .FontName      = "Tahoma"
1691:             .FontSize      = 8
1692:             .Format        = "K"
1693:             .InputMask     = "999.99"
1694:             .SpecialEffect = 1
1695:             .Margin        = 0
1696:             .Visible       = .T.
1697:         ENDWITH
1698:         loc_oAba.AddObject("lbl_4c_Label23", "Label")
1699:         WITH loc_oAba.lbl_4c_Label23

*-- Linhas 1706 a 1742:
1706:             .FontSize  = 7
1707:             .BackStyle = 0
1708:             .ForeColor = RGB(90, 90, 90)
1709:             .Visible   = .T.
1710:         ENDWITH
1711:         loc_oAba.AddObject("txt_4c_Text19", "TextBox")
1712:         WITH loc_oAba.txt_4c_Text19
1713:             .ControlSource = "crSigCnFN2.csac"
1714:             .Top           = 78
1715:             .Left          = 213
1716:             .Width         = 41
1717:             .Height        = 18
1718:             .FontName      = "Tahoma"
1719:             .FontSize      = 8
1720:             .Format        = "K"
1721:             .InputMask     = "999.99"
1722:             .SpecialEffect = 1
1723:             .Margin        = 0
1724:             .Visible       = .T.
1725:         ENDWITH
1726:         loc_oAba.AddObject("txt_4c_Text20", "TextBox")
1727:         WITH loc_oAba.txt_4c_Text20
1728:             .ControlSource = "crSigCnFN2.contsac"
1729:             .Top           = 97
1730:             .Left          = 164
1731:             .Width         = 137
1732:             .Height        = 18
1733:             .MaxLength     = 20
1734:             .FontName      = "Tahoma"
1735:             .FontSize      = 8
1736:             .Format        = "K"
1737:             .SpecialEffect = 1
1738:             .Margin        = 0
1739:             .Visible       = .T.
1740:         ENDWITH
1741: 
1742:         *-- Nat. Operacao Substituicao Tributaria (lnatopsub x cnatopsub)

*-- Linhas 1751 a 1772:
1751:             .FontSize  = 7
1752:             .BackStyle = 0
1753:             .ForeColor = RGB(90, 90, 90)
1754:             .Visible   = .T.
1755:         ENDWITH
1756:         loc_oAba.AddObject("txt_4c_Text21", "TextBox")
1757:         WITH loc_oAba.txt_4c_Text21
1758:             .ControlSource = "crSigCnFN2.lnatopsub"
1759:             .Top           = 142
1760:             .Left          = 164
1761:             .Width         = 41
1762:             .Height        = 18
1763:             .FontName      = "Tahoma"
1764:             .FontSize      = 8
1765:             .Format        = "K"
1766:             .InputMask     = "999.99"
1767:             .SpecialEffect = 1
1768:             .Margin        = 0
1769:             .Visible       = .T.
1770:         ENDWITH
1771:         loc_oAba.AddObject("lbl_4c_Label25", "Label")
1772:         WITH loc_oAba.lbl_4c_Label25

*-- Linhas 1779 a 1800:
1779:             .FontSize  = 7
1780:             .BackStyle = 0
1781:             .ForeColor = RGB(90, 90, 90)
1782:             .Visible   = .T.
1783:         ENDWITH
1784:         loc_oAba.AddObject("txt_4c_Text22", "TextBox")
1785:         WITH loc_oAba.txt_4c_Text22
1786:             .ControlSource = "crSigCnFN2.cnatopsub"
1787:             .Top           = 142
1788:             .Left          = 213
1789:             .Width         = 41
1790:             .Height        = 18
1791:             .FontName      = "Tahoma"
1792:             .FontSize      = 8
1793:             .Format        = "K"
1794:             .InputMask     = "999.99"
1795:             .SpecialEffect = 1
1796:             .Margin        = 0
1797:             .Visible       = .T.
1798:         ENDWITH
1799: 
1800:         *-- CFOP Substituicao Tributaria (lcfopsub x ccfopsub)

*-- Linhas 1809 a 1830:
1809:             .FontSize  = 7
1810:             .BackStyle = 0
1811:             .ForeColor = RGB(90, 90, 90)
1812:             .Visible   = .T.
1813:         ENDWITH
1814:         loc_oAba.AddObject("txt_4c_Text23", "TextBox")
1815:         WITH loc_oAba.txt_4c_Text23
1816:             .ControlSource = "crSigCnFN2.lcfopsub"
1817:             .Top           = 174
1818:             .Left          = 164
1819:             .Width         = 41
1820:             .Height        = 18
1821:             .FontName      = "Tahoma"
1822:             .FontSize      = 8
1823:             .Format        = "K"
1824:             .InputMask     = "999.99"
1825:             .SpecialEffect = 1
1826:             .Margin        = 0
1827:             .Visible       = .T.
1828:         ENDWITH
1829:         loc_oAba.AddObject("lbl_4c_Label27", "Label")
1830:         WITH loc_oAba.lbl_4c_Label27

*-- Linhas 1837 a 1858:
1837:             .FontSize  = 7
1838:             .BackStyle = 0
1839:             .ForeColor = RGB(90, 90, 90)
1840:             .Visible   = .T.
1841:         ENDWITH
1842:         loc_oAba.AddObject("txt_4c_Text24", "TextBox")
1843:         WITH loc_oAba.txt_4c_Text24
1844:             .ControlSource = "crSigCnFN2.ccfopsub"
1845:             .Top           = 174
1846:             .Left          = 213
1847:             .Width         = 41
1848:             .Height        = 18
1849:             .FontName      = "Tahoma"
1850:             .FontSize      = 8
1851:             .Format        = "K"
1852:             .InputMask     = "999.99"
1853:             .SpecialEffect = 1
1854:             .Margin        = 0
1855:             .Visible       = .T.
1856:         ENDWITH
1857: 
1858:         *===== Coluna direita: impressora (dentro do Shape1) =====

*-- Linhas 1869 a 1890:
1869:             .FontSize  = 7
1870:             .BackStyle = 0
1871:             .ForeColor = RGB(90, 90, 90)
1872:             .Visible   = .T.
1873:         ENDWITH
1874:         loc_oAba.AddObject("txt_4c_Text13", "TextBox")
1875:         WITH loc_oAba.txt_4c_Text13
1876:             .ControlSource = "crSigCnFNf.imppads"
1877:             .Top           = 61
1878:             .Left          = 393
1879:             .Width         = 240
1880:             .Height        = 18
1881:             .FontName      = "Tahoma"
1882:             .FontSize      = 8
1883:             .Format        = "K"
1884:             .SpecialEffect = 1
1885:             .Margin        = 0
1886:             .Visible       = .T.
1887:         ENDWITH
1888: 
1889:         *-- Fonte Padrao + Tamanho (sem ControlSource; Text14 abre dialogo fonte)
1890:         loc_oAba.AddObject("lbl_4c_Label14", "Label")

*-- Linhas 1898 a 1945:
1898:             .FontSize  = 7
1899:             .BackStyle = 0
1900:             .ForeColor = RGB(90, 90, 90)
1901:             .Visible   = .T.
1902:         ENDWITH
1903:         loc_oAba.AddObject("txt_4c_Text14", "TextBox")
1904:         WITH loc_oAba.txt_4c_Text14
1905:             .Top           = 93
1906:             .Left          = 393
1907:             .Width         = 192
1908:             .Height        = 18
1909:             .FontName      = "Tahoma"
1910:             .FontSize      = 8
1911:             .Format        = "K"
1912:             .SpecialEffect = 1
1913:             .Margin        = 0
1914:             .Visible       = .T.
1915:         ENDWITH
1916:         loc_oAba.AddObject("lbl_4c_Label15", "Label")
1917:         WITH loc_oAba.lbl_4c_Label15
1918:             .Caption   = "Tamanho"
1919:             .Top       = 81
1920:             .Left      = 591
1921:             .Width     = 41
1922:             .Height    = 13
1923:             .FontName  = "Tahoma"
1924:             .FontSize  = 7
1925:             .BackStyle = 0
1926:             .ForeColor = RGB(90, 90, 90)
1927:             .Visible   = .T.
1928:         ENDWITH
1929:         loc_oAba.AddObject("txt_4c_Text15", "TextBox")
1930:         WITH loc_oAba.txt_4c_Text15
1931:             .ControlSource = "crSigCnFNf.tamanhos"
1932:             .Top           = 93
1933:             .Left          = 592
1934:             .Width         = 41
1935:             .Height        = 18
1936:             .FontName      = "Tahoma"
1937:             .FontSize      = 8
1938:             .Format        = "K"
1939:             .InputMask     = "999"
1940:             .SpecialEffect = 1
1941:             .Margin        = 0
1942:             .Visible       = .T.
1943:         ENDWITH
1944: 
1945:         *-- Tamanho da Folha (Text11, sem ControlSource; abre dialogo)

*-- Linhas 1954 a 2695:
1954:             .FontSize  = 7
1955:             .BackStyle = 0
1956:             .ForeColor = RGB(90, 90, 90)
1957:             .Visible   = .T.
1958:         ENDWITH
1959:         loc_oAba.AddObject("txt_4c_Text11", "TextBox")
1960:         WITH loc_oAba.txt_4c_Text11
1961:             .Top           = 127
1962:             .Left          = 393
1963:             .Width         = 240
1964:             .Height        = 18
1965:             .MaxLength     = 50
1966:             .FontName      = "Tahoma"
1967:             .FontSize      = 8
1968:             .Format        = "K"
1969:             .SpecialEffect = 1
1970:             .Margin        = 0
1971:             .Visible       = .T.
1972:         ENDWITH
1973: 
1974:         *-- optTpMargem (Sem Margem / Com Margem)
1975:         loc_oAba.AddObject("obj_4c_OptTpMargem", "OptionGroup")
1976:         WITH loc_oAba.obj_4c_OptTpMargem
1977:             .ControlSource = "crSigCnFN2.ntpmargems"
1978:             .Top           = 149
1979:             .Left          = 389
1980:             .Width         = 202
1981:             .Height        = 27
1982:             .BackStyle     = 0
1983:             .BorderStyle   = 0
1984:             .Value         = 1
1985:             .Visible       = .T.
1986:             WITH .Buttons(1)
1987:                 .Caption   = "Sem Margem"
1988:                 .Left      = 5
1989:                 .Top       = 5
1990:                 .AutoSize  = .T.
1991:                 .BackStyle = 0
1992:                 .ForeColor = RGB(90, 90, 90)
1993:             ENDWITH
1994:             WITH .Buttons(2)
1995:                 .Caption   = "Com Margem"
1996:                 .Left      = 105
1997:                 .Top       = 5
1998:                 .AutoSize  = .T.
1999:                 .BackStyle = 0
2000:                 .FontName  = "Tahoma"
2001:                 .FontSize  = 8
2002:                 .ForeColor = RGB(90, 90, 90)
2003:             ENDWITH
2004:         ENDWITH
2005:     ENDPROC
2006: 
2007:     *--------------------------------------------------------------------------
2008:     PROCEDURE ConfirmarClick()
2009:         LOCAL loc_lResultado
2010:         loc_lResultado = .F.
2011:         TRY
2012:             IF THIS.this_cModoAtual != "INCLUIR" AND THIS.this_cModoAtual != "ALTERAR"
2013:                 MsgAviso("Nada a salvar no modo atual.", "FormNfl")
2014:             ELSE
2015:                 THIS.FormParaBO()
2016:                 loc_lResultado = THIS.this_oBusinessObject.Salvar()
2017:                 IF loc_lResultado
2018:                     THIS.this_oBusinessObject.SalvarSigCnFNf()
2019:                     MsgInfo("Configura" + CHR(231) + CHR(227) + "o salva com sucesso.", "FormNfl")
2020:                     THIS.AjustarBotoesPorModo("LISTA")
2021:                     THIS.AlternarPagina(1)
2022:                     THIS.CarregarLista()
2023:                 ENDIF
2024:             ENDIF
2025:         CATCH TO loc_oErro
2026:             MsgErro(loc_oErro.Message, "FormNfl.ConfirmarClick")
2027:         ENDTRY
2028:         RETURN loc_lResultado
2029:     ENDPROC
2030: 
2031:     *--------------------------------------------------------------------------
2032:     PROCEDURE CancelarClick()
2033:         TRY
2034:             THIS.AjustarBotoesPorModo("LISTA")
2035:             THIS.AlternarPagina(1)
2036:         CATCH TO loc_oErro
2037:             MsgErro(loc_oErro.Message, "FormNfl.CancelarClick")
2038:         ENDTRY
2039:     ENDPROC
2040: 
2041:     *--------------------------------------------------------------------------
2042:     PROCEDURE SeriesDadosValid()
2043:         LOCAL loc_lResultado, loc_cVal, loc_nRes
2044:         loc_lResultado = .T.
2045:         TRY
2046:             loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value)
2047:             IF loc_cVal == THIS.this_cUltimoSeriesValidado
2048:                 loc_lResultado = loc_lResultado
2049:             ENDIF
2050:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2051:                 loc_lResultado = .T.
2052:             ELSE
2053:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2054:                     "SELECT cods FROM SigCdSer WHERE cods = " + EscaparSQL(loc_cVal), ;
2055:                     "cursor_4c_ValidSer")
2056:                 IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidSer") = 0
2057:                     THIS.AbrirLookupSeries()
2058:                 ELSE
2059:                     THIS.this_cUltimoSeriesValidado = loc_cVal
2060:                 ENDIF
2061:                 IF USED("cursor_4c_ValidSer")
2062:                     USE IN cursor_4c_ValidSer
2063:                 ENDIF
2064:             ENDIF
2065:         CATCH TO loc_oErro
2066:             MsgErro(loc_oErro.Message, "FormNfl.SeriesDadosValid")
2067:         ENDTRY
2068:         RETURN loc_lResultado
2069:     ENDPROC
2070: 
2071:     *--------------------------------------------------------------------------
2072:     PROCEDURE SeriesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2073:         IF par_nKeyCode = 28
2074:             THIS.AbrirLookupSeries()
2075:         ENDIF
2076:     ENDPROC
2077: 
2078:     *--------------------------------------------------------------------------
2079:     PROCEDURE SeriesDblClick()
2080:         THIS.AbrirLookupSeries()
2081:     ENDPROC
2082: 
2083:     *--------------------------------------------------------------------------
2084:     PROTECTED PROCEDURE AbrirLookupSeries()
2085:         LOCAL loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2086:         TRY
2087:             loc_oCtrl = THIS.pgf_4c_Paginas.Page2.txt_4c_Series
2088:             IF PEMSTATUS(loc_oCtrl, "Enabled", 5) AND !loc_oCtrl.Enabled
2089:                 RETURN
2090:             ENDIF
2091:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2092:             IF !EMPTY(loc_cVal)
2093:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer WHERE UPPER(cods) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY cods"
2094:             ELSE
2095:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer ORDER BY cods"
2096:             ENDIF
2097:             SET NULL ON
2098:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSer")
2099:             IF !USED("cursor_4c_BuscaSer") OR RECCOUNT("cursor_4c_BuscaSer") = 0
2100:                 IF USED("cursor_4c_BuscaSer")
2101:                     USE IN cursor_4c_BuscaSer
2102:                 ENDIF
2103:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdSer ORDER BY cods", "cursor_4c_BuscaSer")
2104:             ENDIF
2105:             IF !USED("cursor_4c_BuscaSer")
2106:                 CREATE CURSOR cursor_4c_BuscaSer (cods c(3), descs c(50))
2107:             ENDIF
2108:             SET NULL OFF
2109:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2110:             IF VARTYPE(loc_oBusca) = "O"
2111:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSer"
2112:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaSer", "cods", "descs", "S" + CHR(233) + "ries")
2113:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2114:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2115:                 loc_oBusca.Mostrar()
2116:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
2117:                     SELECT cursor_4c_BuscaSer
2118:                     loc_oCtrl.Value = ALLTRIM(cods)
2119:                 ENDIF
2120:             ENDIF
2121:             IF USED("cursor_4c_BuscaSer")
2122:                 USE IN cursor_4c_BuscaSer
2123:             ENDIF
2124:         CATCH TO loc_oErro
2125:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupSeries")
2126:         ENDTRY
2127:     ENDPROC
2128: 
2129:     *--------------------------------------------------------------------------
2130:     PROCEDURE NomedestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2131:         IF par_nKeyCode = 28
2132:             THIS.AbrirLookupNomedest()
2133:         ENDIF
2134:     ENDPROC
2135: 
2136:     *--------------------------------------------------------------------------
2137:     PROCEDURE NomedestDblClick()
2138:         THIS.AbrirLookupNomedest()
2139:     ENDPROC
2140: 
2141:     *--------------------------------------------------------------------------
2142:     PROTECTED PROCEDURE AbrirLookupNomedest()
2143:         LOCAL loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2144:         TRY
2145:             loc_oCtrl = THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.txt_4c_nomedest
2146:             loc_cVal  = ALLTRIM(loc_oCtrl.Value)
2147:             IF !EMPTY(loc_cVal)
2148:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer WHERE UPPER(cods) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY cods"
2149:             ELSE
2150:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer ORDER BY cods"
2151:             ENDIF
2152:             SET NULL ON
2153:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSerCp")
2154:             IF !USED("cursor_4c_BuscaSerCp") OR RECCOUNT("cursor_4c_BuscaSerCp") = 0
2155:                 IF USED("cursor_4c_BuscaSerCp")
2156:                     USE IN cursor_4c_BuscaSerCp
2157:                 ENDIF
2158:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdSer ORDER BY cods", "cursor_4c_BuscaSerCp")
2159:             ENDIF
2160:             IF !USED("cursor_4c_BuscaSerCp")
2161:                 CREATE CURSOR cursor_4c_BuscaSerCp (cods c(3), descs c(50))
2162:             ENDIF
2163:             SET NULL OFF
2164:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2165:             IF VARTYPE(loc_oBusca) = "O"
2166:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSerCp"
2167:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaSerCp", "cods", "descs", "S" + CHR(233) + "rie Destino")
2168:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2169:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2170:                 loc_oBusca.Mostrar()
2171:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSerCp")
2172:                     SELECT cursor_4c_BuscaSerCp
2173:                     loc_oCtrl.Value = ALLTRIM(cods)
2174:                 ENDIF
2175:             ENDIF
2176:             IF USED("cursor_4c_BuscaSerCp")
2177:                 USE IN cursor_4c_BuscaSerCp
2178:             ENDIF
2179:         CATCH TO loc_oErro
2180:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupNomedest")
2181:         ENDTRY
2182:     ENDPROC
2183: 
2184:     *--------------------------------------------------------------------------
2185:     PROCEDURE EmpDestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2186:         IF par_nKeyCode = 28
2187:             THIS.AbrirLookupEmpDest()
2188:         ENDIF
2189:     ENDPROC
2190: 
2191:     *--------------------------------------------------------------------------
2192:     PROCEDURE EmpDestDblClick()
2193:         THIS.AbrirLookupEmpDest()
2194:     ENDPROC
2195: 
2196:     *--------------------------------------------------------------------------
2197:     PROTECTED PROCEDURE AbrirLookupEmpDest()
2198:         LOCAL loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2199:         TRY
2200:             loc_oCtrl = THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.txt_4c_empDest
2201:             loc_cVal  = ALLTRIM(loc_oCtrl.Value)
2202:             IF !EMPTY(loc_cVal)
2203:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE UPPER(CEmps) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CEmps"
2204:             ELSE
2205:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps"
2206:             ENDIF
2207:             SET NULL ON
2208:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDest")
2209:             IF !USED("cursor_4c_BuscaEmpDest") OR RECCOUNT("cursor_4c_BuscaEmpDest") = 0
2210:                 IF USED("cursor_4c_BuscaEmpDest")
2211:                     USE IN cursor_4c_BuscaEmpDest
2212:                 ENDIF
2213:                 SQLEXEC(gnConnHandle, "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", "cursor_4c_BuscaEmpDest")
2214:             ENDIF
2215:             IF !USED("cursor_4c_BuscaEmpDest")
2216:                 CREATE CURSOR cursor_4c_BuscaEmpDest (CEmps c(2), Razas c(60))
2217:             ENDIF
2218:             SET NULL OFF
2219:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2220:             IF VARTYPE(loc_oBusca) = "O"
2221:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDest"
2222:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpDest", "CEmps", "Razas", "Empresa Destino")
2223:                 loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
2224:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2225:                 loc_oBusca.Mostrar()
2226:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDest")
2227:                     SELECT cursor_4c_BuscaEmpDest
2228:                     loc_oCtrl.Value = ALLTRIM(CEmps)
2229:                 ENDIF
2230:             ENDIF
2231:             IF USED("cursor_4c_BuscaEmpDest")
2232:                 USE IN cursor_4c_BuscaEmpDest
2233:             ENDIF
2234:         CATCH TO loc_oErro
2235:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupEmpDest")
2236:         ENDTRY
2237:     ENDPROC
2238: 
2239:     *--------------------------------------------------------------------------
2240:     PROCEDURE EmpPadKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2241:         IF par_nKeyCode = 28
2242:             THIS.AbrirLookupEmpPad()
2243:         ENDIF
2244:     ENDPROC
2245: 
2246:     *--------------------------------------------------------------------------
2247:     PROCEDURE EmpPadDblClick()
2248:         THIS.AbrirLookupEmpPad()
2249:     ENDPROC
2250: 
2251:     *--------------------------------------------------------------------------
2252:     PROCEDURE EmpPadValid(par_nKeyCode, par_nShiftAltCtrl)
2253:         LOCAL loc_lResultado, loc_cVal, loc_nRes
2254:         loc_lResultado = .T.
2255:         TRY
2256:             loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value)
2257:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2258:                 loc_lResultado = .T.
2259:             ENDIF
2260:             loc_nRes = SQLEXEC(gnConnHandle, ;
2261:                 "SELECT CEmps FROM SigCdEmp WHERE CEmps = " + EscaparSQL(loc_cVal), ;
2262:                 "cursor_4c_ValidEmpPad")
2263:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidEmpPad") = 0
2264:                 THIS.AbrirLookupEmpPad()
2265:             ENDIF
2266:             IF USED("cursor_4c_ValidEmpPad")
2267:                 USE IN cursor_4c_ValidEmpPad
2268:             ENDIF
2269:         CATCH TO loc_oErro
2270:             MsgErro(loc_oErro.Message, "FormNfl.EmpPadValid")
2271:         ENDTRY
2272:         RETURN loc_lResultado
2273:     ENDPROC
2274: 
2275:     *--------------------------------------------------------------------------
2276:     PROTECTED PROCEDURE AbrirLookupEmpPad()
2277:         LOCAL loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2278:         TRY
2279:             loc_oCtrl = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page10.txt_4c_EmpPad
2280:             IF PEMSTATUS(loc_oCtrl, "Enabled", 5) AND !loc_oCtrl.Enabled
2281:                 RETURN
2282:             ENDIF
2283:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2284:             IF !EMPTY(loc_cVal)
2285:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE UPPER(CEmps) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CEmps"
2286:             ELSE
2287:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps"
2288:             ENDIF
2289:             SET NULL ON
2290:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpPad")
2291:             IF !USED("cursor_4c_BuscaEmpPad") OR RECCOUNT("cursor_4c_BuscaEmpPad") = 0
2292:                 IF USED("cursor_4c_BuscaEmpPad")
2293:                     USE IN cursor_4c_BuscaEmpPad
2294:                 ENDIF
2295:                 SQLEXEC(gnConnHandle, "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", "cursor_4c_BuscaEmpPad")
2296:             ENDIF
2297:             IF !USED("cursor_4c_BuscaEmpPad")
2298:                 CREATE CURSOR cursor_4c_BuscaEmpPad (CEmps c(2), Razas c(60))
2299:             ENDIF
2300:             SET NULL OFF
2301:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2302:             IF VARTYPE(loc_oBusca) = "O"
2303:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpPad"
2304:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpPad", "CEmps", "Razas", "Empresa Padr" + CHR(227) + "o")
2305:                 loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
2306:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2307:                 loc_oBusca.Mostrar()
2308:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpPad")
2309:                     SELECT cursor_4c_BuscaEmpPad
2310:                     loc_oCtrl.Value = ALLTRIM(CEmps)
2311:                 ENDIF
2312:             ENDIF
2313:             IF USED("cursor_4c_BuscaEmpPad")
2314:                 USE IN cursor_4c_BuscaEmpPad
2315:             ENDIF
2316:         CATCH TO loc_oErro
2317:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupEmpPad")
2318:         ENDTRY
2319:     ENDPROC
2320: 
2321:     *--------------------------------------------------------------------------
2322:     PROCEDURE UnPesosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2323:         IF par_nKeyCode = 28
2324:             THIS.AbrirLookupUnPesos()
2325:         ENDIF
2326:     ENDPROC
2327: 
2328:     *--------------------------------------------------------------------------
2329:     PROCEDURE UnPesosDblClick()
2330:         THIS.AbrirLookupUnPesos()
2331:     ENDPROC
2332: 
2333:     *--------------------------------------------------------------------------
2334:     PROCEDURE UnPesosValid(par_nKeyCode, par_nShiftAltCtrl)
2335:         LOCAL loc_lResultado, loc_cVal, loc_nRes
2336:         loc_lResultado = .T.
2337:         TRY
2338:             loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page6.txt_4c_UnPesos.Value)
2339:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2340:                 loc_lResultado = .T.
2341:             ENDIF
2342:             loc_nRes = SQLEXEC(gnConnHandle, ;
2343:                 "SELECT CUnis FROM SigCdUni WHERE CUnis = " + EscaparSQL(loc_cVal), ;
2344:                 "cursor_4c_ValidUni")
2345:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidUni") = 0
2346:                 THIS.AbrirLookupUnPesos()
2347:             ENDIF
2348:             IF USED("cursor_4c_ValidUni")
2349:                 USE IN cursor_4c_ValidUni
2350:             ENDIF
2351:         CATCH TO loc_oErro
2352:             MsgErro(loc_oErro.Message, "FormNfl.UnPesosValid")
2353:         ENDTRY
2354:         RETURN loc_lResultado
2355:     ENDPROC
2356: 
2357:     *--------------------------------------------------------------------------
2358:     PROTECTED PROCEDURE AbrirLookupUnPesos()
2359:         LOCAL loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2360:         TRY
2361:             loc_oCtrl = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page6.txt_4c_UnPesos
2362:             IF PEMSTATUS(loc_oCtrl, "Enabled", 5) AND !loc_oCtrl.Enabled
2363:                 RETURN
2364:             ENDIF
2365:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2366:             IF !EMPTY(loc_cVal)
2367:                 loc_cSQL = "SELECT CUnis, DUnis FROM SigCdUni WHERE UPPER(CUnis) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CUnis"
2368:             ELSE
2369:                 loc_cSQL = "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis"
2370:             ENDIF
2371:             SET NULL ON
2372:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUni")
2373:             IF !USED("cursor_4c_BuscaUni") OR RECCOUNT("cursor_4c_BuscaUni") = 0
2374:                 IF USED("cursor_4c_BuscaUni")
2375:                     USE IN cursor_4c_BuscaUni
2376:                 ENDIF
2377:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_BuscaUni")
2378:             ENDIF
2379:             IF !USED("cursor_4c_BuscaUni")
2380:                 CREATE CURSOR cursor_4c_BuscaUni (CUnis c(6), DUnis c(30))
2381:             ENDIF
2382:             SET NULL OFF
2383:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2384:             IF VARTYPE(loc_oBusca) = "O"
2385:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUni"
2386:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaUni", "CUnis", "DUnis", "Unidades de Medida")
2387:                 loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
2388:                 loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
2389:                 loc_oBusca.Mostrar()
2390:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
2391:                     SELECT cursor_4c_BuscaUni
2392:                     loc_oCtrl.Value = ALLTRIM(CUnis)
2393:                 ENDIF
2394:             ENDIF
2395:             IF USED("cursor_4c_BuscaUni")
2396:                 USE IN cursor_4c_BuscaUni
2397:             ENDIF
2398:         CATCH TO loc_oErro
2399:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupUnPesos")
2400:         ENDTRY
2401:     ENDPROC
2402: 
2403:     *--------------------------------------------------------------------------
2404:     PROTECTED PROCEDURE AbrirLookupClsFis(par_cNomeCampo)
2405:         LOCAL loc_oRdp, loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2406:         TRY
2407:             loc_oRdp  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
2408:             loc_oCtrl = THIS.ObterControle(loc_oRdp, par_cNomeCampo)
2409:             IF PEMSTATUS(loc_oCtrl, "Enabled", 5) AND !loc_oCtrl.Enabled
2410:                 RETURN
2411:             ENDIF
2412:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2413:             IF !EMPTY(loc_cVal)
2414:                 loc_cSQL = "SELECT codigos, descricaos FROM SigCdClf WHERE UPPER(codigos) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY codigos"
2415:             ELSE
2416:                 loc_cSQL = "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos"
2417:             ENDIF
2418:             SET NULL ON
2419:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaClf")
2420:             IF !USED("cursor_4c_BuscaClf") OR RECCOUNT("cursor_4c_BuscaClf") = 0
2421:                 IF USED("cursor_4c_BuscaClf")
2422:                     USE IN cursor_4c_BuscaClf
2423:                 ENDIF
2424:                 SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", "cursor_4c_BuscaClf")
2425:             ENDIF
2426:             IF !USED("cursor_4c_BuscaClf")
2427:                 CREATE CURSOR cursor_4c_BuscaClf (codigos c(10), descricaos c(60))
2428:             ENDIF
2429:             SET NULL OFF
2430:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2431:             IF VARTYPE(loc_oBusca) = "O"
2432:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaClf"
2433:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaClf", "codigos", "descricaos", "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
2434:                 loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
2435:                 loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2436:                 loc_oBusca.Mostrar()
2437:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
2438:                     SELECT cursor_4c_BuscaClf
2439:                     loc_oCtrl.Value = ALLTRIM(codigos)
2440:                 ENDIF
2441:             ENDIF
2442:             IF USED("cursor_4c_BuscaClf")
2443:                 USE IN cursor_4c_BuscaClf
2444:             ENDIF
2445:         CATCH TO loc_oErro
2446:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupClsFis")
2447:         ENDTRY
2448:     ENDPROC
2449: 
2450:     *--------------------------------------------------------------------------
2451:     PROTECTED PROCEDURE ValidarClsFis(par_cNomeCampo)
2452:         LOCAL loc_lResultado, loc_oRdp, loc_cVal, loc_nRes
2453:         loc_lResultado = .T.
2454:         TRY
2455:             loc_oRdp = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
2456:             loc_cVal = ALLTRIM(loc_oRdp.Value)
2457:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2458:                 loc_lResultado = .T.
2459:             ENDIF
2460:             loc_nRes = SQLEXEC(gnConnHandle, ;
2461:                 "SELECT codigos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cVal), ;
2462:                 "cursor_4c_ValidClf")
2463:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidClf") = 0
2464:                 THIS.AbrirLookupClsFis(par_cNomeCampo)
2465:             ENDIF
2466:             IF USED("cursor_4c_ValidClf")
2467:                 USE IN cursor_4c_ValidClf
2468:             ENDIF
2469:         CATCH TO loc_oErro
2470:             MsgErro(loc_oErro.Message, "FormNfl.ValidarClsFis")
2471:         ENDTRY
2472:         RETURN loc_lResultado
2473:     ENDPROC
2474: 
2475:     *-- CodImp bloco 1 (campos 1-7)
2476:     PROCEDURE CodImp1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2477:         IF par_nKeyCode = 28
2478:             THIS.AbrirLookupClsFis("txt_4c_CodImp1")
2479:         ENDIF
2480:     ENDPROC
2481:     PROCEDURE CodImp1DblClick()
2482:         THIS.AbrirLookupClsFis("txt_4c_CodImp1")
2483:     ENDPROC
2484:     PROCEDURE CodImp1Valid()
2485:         RETURN THIS.ValidarClsFis("txt_4c_CodImp1")
2486:     ENDPROC
2487: 
2488:     PROCEDURE CodImp2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2489:         IF par_nKeyCode = 28
2490:             THIS.AbrirLookupClsFis("txt_4c_CodImp2")
2491:         ENDIF
2492:     ENDPROC
2493:     PROCEDURE CodImp2DblClick()
2494:         THIS.AbrirLookupClsFis("txt_4c_CodImp2")
2495:     ENDPROC
2496:     PROCEDURE CodImp2Valid()
2497:         RETURN THIS.ValidarClsFis("txt_4c_CodImp2")
2498:     ENDPROC
2499: 
2500:     PROCEDURE CodImp3KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2501:         IF par_nKeyCode = 28
2502:             THIS.AbrirLookupClsFis("txt_4c_CodImp3")
2503:         ENDIF
2504:     ENDPROC
2505:     PROCEDURE CodImp3DblClick()
2506:         THIS.AbrirLookupClsFis("txt_4c_CodImp3")
2507:     ENDPROC
2508:     PROCEDURE CodImp3Valid()
2509:         RETURN THIS.ValidarClsFis("txt_4c_CodImp3")
2510:     ENDPROC
2511: 
2512:     PROCEDURE CodImp4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2513:         IF par_nKeyCode = 28
2514:             THIS.AbrirLookupClsFis("txt_4c_CodImp4")
2515:         ENDIF
2516:     ENDPROC
2517:     PROCEDURE CodImp4DblClick()
2518:         THIS.AbrirLookupClsFis("txt_4c_CodImp4")
2519:     ENDPROC
2520:     PROCEDURE CodImp4Valid()
2521:         RETURN THIS.ValidarClsFis("txt_4c_CodImp4")
2522:     ENDPROC
2523: 
2524:     PROCEDURE CodImp5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2525:         IF par_nKeyCode = 28
2526:             THIS.AbrirLookupClsFis("txt_4c_CodImp5")
2527:         ENDIF
2528:     ENDPROC
2529:     PROCEDURE CodImp5DblClick()
2530:         THIS.AbrirLookupClsFis("txt_4c_CodImp5")
2531:     ENDPROC
2532:     PROCEDURE CodImp5Valid()
2533:         RETURN THIS.ValidarClsFis("txt_4c_CodImp5")
2534:     ENDPROC
2535: 
2536:     PROCEDURE CodImp6KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2537:         IF par_nKeyCode = 28
2538:             THIS.AbrirLookupClsFis("txt_4c_CodImp6")
2539:         ENDIF
2540:     ENDPROC
2541:     PROCEDURE CodImp6DblClick()
2542:         THIS.AbrirLookupClsFis("txt_4c_CodImp6")
2543:     ENDPROC
2544:     PROCEDURE CodImp6Valid()
2545:         RETURN THIS.ValidarClsFis("txt_4c_CodImp6")
2546:     ENDPROC
2547: 
2548:     PROCEDURE CodImp7KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2549:         IF par_nKeyCode = 28
2550:             THIS.AbrirLookupClsFis("txt_4c_CodImp7")
2551:         ENDIF
2552:     ENDPROC
2553:     PROCEDURE CodImp7DblClick()
2554:         THIS.AbrirLookupClsFis("txt_4c_CodImp7")
2555:     ENDPROC
2556:     PROCEDURE CodImp7Valid()
2557:         RETURN THIS.ValidarClsFis("txt_4c_CodImp7")
2558:     ENDPROC
2559: 
2560:     *-- CodImpB bloco 2 (campos 8-12)
2561:     PROCEDURE CodImpB8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2562:         IF par_nKeyCode = 28
2563:             THIS.AbrirLookupClsFis("txt_4c_CodImpB8")
2564:         ENDIF
2565:     ENDPROC
2566:     PROCEDURE CodImpB8DblClick()
2567:         THIS.AbrirLookupClsFis("txt_4c_CodImpB8")
2568:     ENDPROC
2569:     PROCEDURE CodImpB8Valid()
2570:         RETURN THIS.ValidarClsFis("txt_4c_CodImpB8")
2571:     ENDPROC
2572: 
2573:     PROCEDURE CodImpB9KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2574:         IF par_nKeyCode = 28
2575:             THIS.AbrirLookupClsFis("txt_4c_CodImpB9")
2576:         ENDIF
2577:     ENDPROC
2578:     PROCEDURE CodImpB9DblClick()
2579:         THIS.AbrirLookupClsFis("txt_4c_CodImpB9")
2580:     ENDPROC
2581:     PROCEDURE CodImpB9Valid()
2582:         RETURN THIS.ValidarClsFis("txt_4c_CodImpB9")
2583:     ENDPROC
2584: 
2585:     PROCEDURE CodImpB10KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2586:         IF par_nKeyCode = 28
2587:             THIS.AbrirLookupClsFis("txt_4c_CodImpB10")
2588:         ENDIF
2589:     ENDPROC
2590:     PROCEDURE CodImpB10DblClick()
2591:         THIS.AbrirLookupClsFis("txt_4c_CodImpB10")
2592:     ENDPROC
2593:     PROCEDURE CodImpB10Valid()
2594:         RETURN THIS.ValidarClsFis("txt_4c_CodImpB10")
2595:     ENDPROC
2596: 
2597:     PROCEDURE CodImpB11KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2598:         IF par_nKeyCode = 28
2599:             THIS.AbrirLookupClsFis("txt_4c_CodImpB11")
2600:         ENDIF
2601:     ENDPROC
2602:     PROCEDURE CodImpB11DblClick()
2603:         THIS.AbrirLookupClsFis("txt_4c_CodImpB11")
2604:     ENDPROC
2605:     PROCEDURE CodImpB11Valid()
2606:         RETURN THIS.ValidarClsFis("txt_4c_CodImpB11")
2607:     ENDPROC
2608: 
2609:     PROCEDURE CodImpB12KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2610:         IF par_nKeyCode = 28
2611:             THIS.AbrirLookupClsFis("txt_4c_CodImpB12")
2612:         ENDIF
2613:     ENDPROC
2614:     PROCEDURE CodImpB12DblClick()
2615:         THIS.AbrirLookupClsFis("txt_4c_CodImpB12")
2616:     ENDPROC
2617:     PROCEDURE CodImpB12Valid()
2618:         RETURN THIS.ValidarClsFis("txt_4c_CodImpB12")
2619:     ENDPROC
2620: 
2621:     *--------------------------------------------------------------------------
2622:     PROCEDURE ClsFisTpClick()
2623:         LOCAL loc_oAba, loc_nI, loc_cN, loc_lLetras, loc_oLbl
2624:         TRY
2625:             loc_oAba    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
2626:             loc_lLetras = (loc_oAba.obj_4c_ClsFisTp.Value = 1)
2627:             FOR loc_nI = 1 TO 7
2628:                 loc_cN  = ALLTRIM(STR(loc_nI))
2629:                 loc_oLbl = THIS.ObterControle(loc_oAba, "lbl_4c_Cod" + loc_cN)
2630:                 IF VARTYPE(loc_oLbl) = "O"
2631:                     IF loc_lLetras
2632:                         loc_oLbl.Caption = CHR(64 + loc_nI)
2633:                     ELSE
2634:                         loc_oLbl.Caption = "C" + CHR(243) + "digo " + loc_cN
2635:                     ENDIF
2636:                 ENDIF
2637:             ENDFOR
2638:             FOR loc_nI = 8 TO 12
2639:                 loc_cN  = ALLTRIM(STR(loc_nI))
2640:                 loc_oLbl = THIS.ObterControle(loc_oAba, "lbl_4c_CodB" + loc_cN)
2641:                 IF VARTYPE(loc_oLbl) = "O"
2642:                     IF loc_lLetras
2643:                         loc_oLbl.Caption = CHR(64 + loc_nI)
2644:                     ELSE
2645:                         loc_oLbl.Caption = "C" + CHR(243) + "digo " + loc_cN
2646:                     ENDIF
2647:                 ENDIF
2648:             ENDFOR
2649:         CATCH TO loc_oErro
2650:             MsgErro(loc_oErro.Message, "FormNfl.ClsFisTpClick")
2651:         ENDTRY
2652:     ENDPROC
2653: 
2654:     *--------------------------------------------------------------------------
2655:     PROTECTED PROCEDURE FormParaBO()
2656:         LOCAL loc_oPag2, loc_oBO
2657:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2658:         loc_oBO   = THIS.this_oBusinessObject
2659: 
2660:         *-- Controles standalone (sem ControlSource)
2661:         IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
2662:             loc_oBO.this_cSeries = ALLTRIM(loc_oPag2.txt_4c_Series.Value)
2663:         ENDIF
2664:         IF VARTYPE(loc_oPag2.pgf_4c_Abas) = "O"
2665:             IF PEMSTATUS(loc_oPag2.pgf_4c_Abas.Page10, "txt_4c_EmpPad", 5)
2666:                 loc_oBO.this_cEmps = ALLTRIM(loc_oPag2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value)
2667:             ENDIF
2668:         ENDIF
2669: 
2670:         *-- Campos de crSigCnFN2 (Empresa, Destinatario, Impostos adicionais, Classes extras)
2671:         IF USED("crSigCnFN2") AND RECCOUNT("crSigCnFN2") > 0
2672:             SELECT crSigCnFN2
2673:             loc_oBO.this_cCtitent      = ALLTRIM(ctitent)
2674:             loc_oBO.this_nLendent      = lendent
2675:             loc_oBO.this_nCendent      = cendent
2676:             loc_oBO.this_nLbaient      = lbaient
2677:             loc_oBO.this_nCbaient      = cbaient
2678:             loc_oBO.this_nLmunent      = lmunent
2679:             loc_oBO.this_nCmunent      = cmunent
2680:             loc_oBO.this_nLestent      = lestent
2681:             loc_oBO.this_nCestent      = cestent
2682:             loc_oBO.this_nLcepent      = lcepent
2683:             loc_oBO.this_nCcepent      = ccepent
2684:             loc_oBO.this_nLfoneent     = lfoneent
2685:             loc_oBO.this_nCfoneent     = cfoneent
2686:             loc_oBO.this_nLiniped      = liniped
2687:             loc_oBO.this_nCiniped      = ciniped
2688:             loc_oBO.this_nLendtite     = lendtite
2689:             loc_oBO.this_nCendtite     = cendtite
2690:             loc_oBO.this_nLempnome     = lempnome
2691:             loc_oBO.this_nCempnome     = cempnome
2692:             loc_oBO.this_nLempcgc      = lempcgc
2693:             loc_oBO.this_nCempcgc      = cempcgc
2694:             loc_oBO.this_nLempiest     = lempiest
2695:             loc_oBO.this_nCempiest     = cempiest

*-- Linhas 2799 a 2878:
2799:     ENDPROC
2800: 
2801:     *--------------------------------------------------------------------------
2802:     PROTECTED PROCEDURE BOParaForm()
2803:         LOCAL loc_lResultado, loc_oPag2, loc_oBO, loc_cChave
2804:         loc_lResultado = .F.
2805:         TRY
2806:             loc_oPag2  = THIS.pgf_4c_Paginas.Page2
2807:             loc_oBO    = THIS.this_oBusinessObject
2808:             loc_cChave = ALLTRIM(loc_oBO.this_cCidchaves)
2809: 
2810:             IF !EMPTY(loc_cChave)
2811:                 IF SQLEXEC(gnConnHandle, ;
2812:                     "SELECT * FROM SigCnFNf WHERE cidchaves = " + EscaparSQL(loc_cChave), ;
2813:                     "crSigCnFNf") <= 0
2814:                     MsgErro("Erro ao recarregar SigCnFNf.", "FormNfl.BOParaForm")
2815:                 ENDIF
2816:                 IF SQLEXEC(gnConnHandle, ;
2817:                     "SELECT * FROM SigCnFN2 WHERE cidchaves = " + EscaparSQL(loc_cChave), ;
2818:                     "crSigCnFN2") <= 0
2819:                     MsgErro("Erro ao recarregar SigCnFN2.", "FormNfl.BOParaForm")
2820:                 ENDIF
2821:             ENDIF
2822: 
2823:             IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
2824:                 loc_oPag2.txt_4c_Series.Value = ALLTRIM(loc_oBO.this_cSeries)
2825:             ENDIF
2826:             IF VARTYPE(loc_oPag2.pgf_4c_Abas) = "O"
2827:                 IF PEMSTATUS(loc_oPag2.pgf_4c_Abas.Page10, "txt_4c_EmpPad", 5)
2828:                     loc_oPag2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value = ALLTRIM(loc_oBO.this_cEmps)
2829:                 ENDIF
2830:             ENDIF
2831:             loc_lResultado = .T.
2832:         CATCH TO loc_oErro
2833:             MsgErro(loc_oErro.Message, "FormNfl.BOParaForm")
2834:         ENDTRY
2835:         RETURN loc_lResultado
2836:     ENDPROC
2837: 
2838:     PROTECTED PROCEDURE ConfigurarEmpresaTab()
2839:         LOCAL loc_oAba
2840:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2841: 
2842:         *-- Secao: Dados/Endereco - Empresa (top=7, shape+header)
2843:         loc_oAba.AddObject("shp_4c_Shape3", "Shape")
2844:         WITH loc_oAba.shp_4c_Shape3
2845:             .Top           = 7
2846:             .Left          = 42
2847:             .Height        = 3
2848:             .Width         = 414
2849:             .BackStyle     = 1
2850:             .SpecialEffect = 1
2851:             .BackColor     = RGB(136, 189, 188)
2852:             .Visible       = .T.
2853:         ENDWITH
2854: 
2855:         loc_oAba.AddObject("lbl_4c_Label57", "Label")
2856:         WITH loc_oAba.lbl_4c_Label57
2857:             .Caption   = "Dados / Endere" + CHR(231) + "o - Empresa"
2858:             .Top       = 11
2859:             .Left      = 50
2860:             .FontBold  = .T.
2861:             .FontName  = "Tahoma"
2862:             .FontSize  = 8
2863:             .BackStyle = 0
2864:             .ForeColor = RGB(90, 90, 90)
2865:             .AutoSize  = .T.
2866:             .Visible   = .T.
2867:         ENDWITH
2868: 
2869:         *-- Empresa - Nome/Razao Social (top=26)
2870:         loc_oAba.AddObject("lbl_4c_Label41", "Label")
2871:         WITH loc_oAba.lbl_4c_Label41
2872:             .Caption   = "Nome / Raz" + CHR(227) + "o Social"
2873:             .Top       = 26
2874:             .Left      = 42
2875:             .FontName  = "Tahoma"
2876:             .FontSize  = 7
2877:             .BackStyle = 0
2878:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 4533 a 4576:
4533:     ENDPROC
4534: 
4535:     *--------------------------------------------------------------------------
4536:     PROTECTED PROCEDURE ConfigurarDesdobramentoTab()
4537:         LOCAL loc_oAba
4538:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
4539: 
4540:         *-- Cabecalho de colunas (top=25)
4541:         loc_oAba.AddObject("lbl_4c_LblNumero", "Label")
4542:         WITH loc_oAba.lbl_4c_LblNumero
4543:             .Caption   = "N" + CHR(250) + "mero"
4544:             .Top       = 25
4545:             .Left      = 87
4546:             .FontName  = "Tahoma"
4547:             .FontSize  = 7
4548:             .BackStyle = 0
4549:             .ForeColor = RGB(90, 90, 90)
4550:             .AutoSize  = .T.
4551:             .Visible   = .T.
4552:         ENDWITH
4553: 
4554:         loc_oAba.AddObject("lbl_4c_LblValor", "Label")
4555:         WITH loc_oAba.lbl_4c_LblValor
4556:             .Caption   = "Valor"
4557:             .Top       = 25
4558:             .Left      = 200
4559:             .FontName  = "Tahoma"
4560:             .FontSize  = 7
4561:             .BackStyle = 0
4562:             .ForeColor = RGB(90, 90, 90)
4563:             .AutoSize  = .T.
4564:             .Visible   = .T.
4565:         ENDWITH
4566: 
4567:         loc_oAba.AddObject("lbl_4c_LblVecto", "Label")
4568:         WITH loc_oAba.lbl_4c_LblVecto
4569:             .Caption   = "Vencimento"
4570:             .Top       = 25
4571:             .Left      = 294
4572:             .FontName  = "Tahoma"
4573:             .FontSize  = 7
4574:             .BackStyle = 0
4575:             .ForeColor = RGB(90, 90, 90)
4576:             .AutoSize  = .T.

*-- Linhas 6205 a 6248:
6205:     ENDPROC
6206: 
6207:     *--------------------------------------------------------------------------
6208:     PROTECTED PROCEDURE ConfigurarProdutosTab()
6209:         LOCAL loc_oAba
6210:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4
6211: 
6212:         *-- Linha inicial dos produtos (top=28)
6213:         loc_oAba.AddObject("lbl_4c_LblLinIni", "Label")
6214:         WITH loc_oAba.lbl_4c_LblLinIni
6215:             .Caption   = "Linha Inicial dos Produtos"
6216:             .Top       = 28
6217:             .Left      = 18
6218:             .FontName  = "Tahoma"
6219:             .FontSize  = 7
6220:             .BackStyle = 0
6221:             .ForeColor = RGB(90, 90, 90)
6222:             .AutoSize  = .T.
6223:             .Visible   = .T.
6224:         ENDWITH
6225: 
6226:         loc_oAba.AddObject("txt_4c_LinIni", "TextBox")
6227:         WITH loc_oAba.txt_4c_LinIni
6228:             .ControlSource = "crSigCnFNf.linprod"
6229:             .Top           = 24
6230:             .Left          = 153
6231:             .Width         = 41
6232:             .Height        = 18
6233:             .FontName      = "Tahoma"
6234:             .FontSize      = 8
6235:             .SpecialEffect = 1
6236:             .Format        = "K"
6237:             .InputMask     = "999.99"
6238:             .Visible       = .T.
6239:         ENDWITH
6240: 
6241:         *-- Codigo (top=50)
6242:         loc_oAba.AddObject("lbl_4c_LblCodigo", "Label")
6243:         WITH loc_oAba.lbl_4c_LblCodigo
6244:             .Caption   = "C" + CHR(243) + "digo"
6245:             .Top       = 50
6246:             .Left      = 34
6247:             .FontName  = "Tahoma"
6248:             .FontSize  = 7

*-- Linhas 7180 a 7223:
7180:     ENDPROC
7181: 
7182:     *--------------------------------------------------------------------------
7183:     PROTECTED PROCEDURE ConfigurarImpostosTab()
7184:         LOCAL loc_oAba
7185:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page5
7186: 
7187:         *-- Base de Calculo ICMS (top=19)
7188:         loc_oAba.AddObject("lbl_4c_LblBcICMS", "Label")
7189:         WITH loc_oAba.lbl_4c_LblBcICMS
7190:             .Caption   = "Base de C" + CHR(225) + "lculo ICMS"
7191:             .Top       = 19
7192:             .Left      = 28
7193:             .FontName  = "Tahoma"
7194:             .FontSize  = 7
7195:             .BackStyle = 0
7196:             .ForeColor = RGB(90, 90, 90)
7197:             .AutoSize  = .T.
7198:             .Visible   = .T.
7199:         ENDWITH
7200: 
7201:         loc_oAba.AddObject("txt_4c_BcICMSL", "TextBox")
7202:         WITH loc_oAba.txt_4c_BcICMSL
7203:             .ControlSource = "crSigCnFNf.lbicm"
7204:             .Top = 31
7205:             .Left = 39
7206:             .Width = 41
7207:             .Height = 18
7208:             .FontName = "Tahoma"
7209:             .FontSize = 8
7210:             .SpecialEffect = 1
7211:             .Format = "K"
7212:             .InputMask = "999.99"
7213:             .Visible = .T.
7214:         ENDWITH
7215: 
7216:         loc_oAba.AddObject("lbl_4c_BcICMSX", "Label")
7217:         WITH loc_oAba.lbl_4c_BcICMSX
7218:             .Caption = "x"
7219:             .Top = 33
7220:             .Left = 82
7221:             .FontName = "Tahoma"
7222:             .FontSize = 7
7223:             .BackStyle = 0

*-- Linhas 7921 a 7964:
7921:     ENDPROC
7922: 
7923:     *--------------------------------------------------------------------------
7924:     PROTECTED PROCEDURE ConfigurarTransporteTab()
7925:         LOCAL loc_oAba
7926:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page6
7927: 
7928:         *-- Shape Transportador (top=7)
7929:         loc_oAba.AddObject("shp_4c_Transp", "Shape")
7930:         WITH loc_oAba.shp_4c_Transp
7931:             .Top = 7
7932:             .Left = 12
7933:             .Width = 315
7934:             .Height = 119
7935:             .Visible = .T.
7936:         ENDWITH
7937: 
7938:         loc_oAba.AddObject("lbl_4c_LblTransp", "Label")
7939:         WITH loc_oAba.lbl_4c_LblTransp
7940:             .Caption = " Transportador "
7941:             .Top = 10
7942:             .Left = 19
7943:             .FontName = "Tahoma"
7944:             .FontSize = 7
7945:             .BackStyle = 0
7946:             .ForeColor = RGB(90,90,90)
7947:             .AutoSize = .T.
7948:             .Visible = .T.
7949:         ENDWITH
7950: 
7951:         *-- Nome/Razao Social transportador (top=24)
7952:         loc_oAba.AddObject("lbl_4c_LblTrNome", "Label")
7953:         WITH loc_oAba.lbl_4c_LblTrNome
7954:             .Caption = "Nome / Raz" + CHR(227) + "o Social"
7955:             .Top = 24
7956:             .Left = 17
7957:             .FontName = "Tahoma"
7958:             .FontSize = 7
7959:             .BackStyle = 0
7960:             .ForeColor = RGB(90,90,90)
7961:             .AutoSize = .T.
7962:             .Visible = .T.
7963:         ENDWITH
7964: 

*-- Linhas 8857 a 8919:
8857:     ENDPROC
8858: 
8859:     *--------------------------------------------------------------------------
8860:     PROTECTED PROCEDURE ConfigurarRodapeTab()
8861:         LOCAL loc_oAba
8862:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
8863: 
8864:         *-- Classificacao Fiscal header (top=21)
8865:         loc_oAba.AddObject("lbl_4c_LblClsFis", "Label")
8866:         WITH loc_oAba.lbl_4c_LblClsFis
8867:             .Caption   = "Class. Fiscal : "
8868:             .Top       = 21
8869:             .Left      = 38
8870:             .FontName  = "Tahoma"
8871:             .FontSize  = 7
8872:             .BackStyle = 0
8873:             .ForeColor = RGB(90, 90, 90)
8874:             .AutoSize  = .T.
8875:             .Visible   = .T.
8876:         ENDWITH
8877: 
8878:         *-- OptionGroup para classificacao fiscal (top=22)
8879:         loc_oAba.AddObject("obj_4c_ClsFisTp", "OptionGroup")
8880:         WITH loc_oAba.obj_4c_ClsFisTp
8881:             .Top         = 22
8882:             .Left        = 115
8883:             .Width       = 149
8884:             .Height      = 19
8885:             .BackStyle   = 0
8886:             .BorderStyle = 0
8887:             .Value       = 1
8888:             .Visible     = .T.
8889:             WITH .Buttons(1)
8890:                 .Caption = "Impressa"
8891:                 .Left    = 2
8892:                 .Top = 2
8893:                 .AutoSize = .T.
8894:                 .BackStyle = 0
8895:                 .ForeColor = RGB(90,90,90)
8896:             ENDWITH
8897:             WITH .Buttons(2)
8898:                 .Caption = "Calculada"
8899:                 .Left    = 60
8900:                 .Top = 2
8901:                 .AutoSize = .T.
8902:                 .BackStyle = 0
8903:                 .FontName = "Tahoma"
8904:                 .FontSize = 7
8905:                 .ForeColor = RGB(90,90,90)
8906:             ENDWITH
8907:         ENDWITH
8908: 
8909:         *-- Shape bloco Codigos 1-7 (top=39, left=17)
8910:         loc_oAba.AddObject("shp_4c_CodBl1", "Shape")
8911:         WITH loc_oAba.shp_4c_CodBl1
8912:             .Top = 39
8913:             .Left = 17
8914:             .Width = 345
8915:             .Height = 155
8916:             .Visible = .T.
8917:         ENDWITH
8918: 
8919:         *-- Cabecalhos do bloco 1-7

*-- Linhas 9875 a 9918:
9875:     ENDPROC
9876: 
9877:     *--------------------------------------------------------------------------
9878:     PROTECTED PROCEDURE ConfigurarFaturaTab()
9879:         LOCAL loc_oAba
9880:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page8
9881: 
9882:         *-- Data de Emissao (top=31)
9883:         loc_oAba.AddObject("lbl_4c_LblFatDtEmi", "Label")
9884:         WITH loc_oAba.lbl_4c_LblFatDtEmi
9885:             .Caption   = "Data de Emiss" + CHR(227) + "o"
9886:             .Top       = 31
9887:             .Left      = 99
9888:             .FontName  = "Tahoma"
9889:             .FontSize  = 7
9890:             .BackStyle = 0
9891:             .ForeColor = RGB(90, 90, 90)
9892:             .AutoSize  = .T.
9893:             .Visible   = .T.
9894:         ENDWITH
9895: 
9896:         loc_oAba.AddObject("txt_4c_FatDtEmiL", "TextBox")
9897:         WITH loc_oAba.txt_4c_FatDtEmiL
9898:             .ControlSource = "crSigCnFNf.ldtemi"
9899:             .Top = 43
9900:             .Left = 99
9901:             .Width = 41
9902:             .Height = 18
9903:             .FontName = "Tahoma"
9904:             .FontSize = 8
9905:             .SpecialEffect = 1
9906:             .Format = "K"
9907:             .InputMask = "999.99"
9908:             .Visible = .T.
9909:         ENDWITH
9910: 
9911:         loc_oAba.AddObject("lbl_4c_FatDtEmiX", "Label")
9912:         WITH loc_oAba.lbl_4c_FatDtEmiX
9913:             .Caption = "x"
9914:             .Top = 45
9915:             .Left = 142
9916:             .FontName = "Tahoma"
9917:             .FontSize = 7
9918:             .BackStyle = 0

*-- Linhas 10280 a 10323:
10280:     ENDPROC
10281: 
10282:     *--------------------------------------------------------------------------
10283:     PROTECTED PROCEDURE ConfigurarServicosTab()
10284:         LOCAL loc_oAba
10285:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page9
10286: 
10287:         *-- Descricao Servicos (top=30)
10288:         loc_oAba.AddObject("lbl_4c_LblSrvDesc", "Label")
10289:         WITH loc_oAba.lbl_4c_LblSrvDesc
10290:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Servi" + CHR(231) + "os"
10291:             .Top       = 30
10292:             .Left      = 105
10293:             .FontName  = "Tahoma"
10294:             .FontSize  = 7
10295:             .BackStyle = 0
10296:             .ForeColor = RGB(90, 90, 90)
10297:             .AutoSize  = .T.
10298:             .Visible   = .T.
10299:         ENDWITH
10300: 
10301:         loc_oAba.AddObject("txt_4c_SrvDescL", "TextBox")
10302:         WITH loc_oAba.txt_4c_SrvDescL
10303:             .ControlSource = "crSigCnFNf.ldescser"
10304:             .Top = 43
10305:             .Left = 107
10306:             .Width = 41
10307:             .Height = 18
10308:             .FontName = "Tahoma"
10309:             .FontSize = 8
10310:             .SpecialEffect = 1
10311:             .Format = "K"
10312:             .InputMask = "999.99"
10313:             .Visible = .T.
10314:         ENDWITH
10315: 
10316:         loc_oAba.AddObject("lbl_4c_SrvDescX", "Label")
10317:         WITH loc_oAba.lbl_4c_SrvDescX
10318:             .Caption = "x"
10319:             .Top = 45
10320:             .Left = 150
10321:             .FontName = "Tahoma"
10322:             .FontSize = 7
10323:             .BackStyle = 0

*-- Linhas 10515 a 10558:
10515:     ENDPROC
10516: 
10517:     *--------------------------------------------------------------------------
10518:     PROTECTED PROCEDURE ConfigurarOutrosTab()
10519:         LOCAL loc_oAba
10520:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page10
10521: 
10522:         *-- Shape (top=37, left=399 -- Dados da Operacao)
10523:         loc_oAba.AddObject("shp_4c_OutShape", "Shape")
10524:         WITH loc_oAba.shp_4c_OutShape
10525:             .Top = 37
10526:             .Left = 399
10527:             .Width = 226
10528:             .Height = 119
10529:             .Visible = .T.
10530:         ENDWITH
10531: 
10532:         loc_oAba.AddObject("lbl_4c_LblDadosOp", "Label")
10533:         WITH loc_oAba.lbl_4c_LblDadosOp
10534:             .Caption   = "Dados da Opera" + CHR(231) + CHR(227) + "o"
10535:             .Top       = 39
10536:             .Left      = 405
10537:             .FontName  = "Tahoma"
10538:             .FontSize  = 7
10539:             .BackStyle = 0
10540:             .ForeColor = RGB(90, 90, 90)
10541:             .AutoSize  = .T.
10542:             .Visible   = .T.
10543:         ENDWITH
10544: 
10545:         *-- Especie Padrao (top=67)
10546:         loc_oAba.AddObject("lbl_4c_LblEspPad", "Label")
10547:         WITH loc_oAba.lbl_4c_LblEspPad
10548:             .Caption = "Esp" + CHR(233) + "cie Padr" + CHR(227) + "o : "
10549:             .Top = 67
10550:             .Left = 156
10551:             .FontName = "Tahoma"
10552:             .FontSize = 7
10553:             .BackStyle = 0
10554:             .ForeColor = RGB(90,90,90)
10555:             .AutoSize = .T.
10556:             .Visible = .T.
10557:         ENDWITH
10558: 

*-- Linhas 11065 a 11097:
11065: 
11066: 
11067:     *--------------------------------------------------------------------------
11068:     PROCEDURE Destroy()
11069:         IF USED("crSigCnFNf")
11070:             USE IN crSigCnFNf
11071:         ENDIF
11072:         IF USED("crSigCnFN2")
11073:             USE IN crSigCnFN2
11074:         ENDIF
11075:         IF USED("cursor_4c_Dados")
11076:             USE IN cursor_4c_Dados
11077:         ENDIF
11078:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
11079:             THIS.this_oBusinessObject = .NULL.
11080:         ENDIF
11081:         DODEFAULT()
11082:     ENDPROC
11083: 
11084:     *--------------------------------------------------------------------------
11085:     PROTECTED FUNCTION ObterControle(par_oConteiner, par_cNome)
11086:         LOCAL loc_nI, loc_oAchado
11087:         loc_oAchado = .NULL.
11088:         FOR loc_nI = 1 TO par_oConteiner.ControlCount
11089:             IF UPPER(par_oConteiner.Controls(loc_nI).Name) = UPPER(par_cNome)
11090:                 loc_oAchado = par_oConteiner.Controls(loc_nI)
11091:                 EXIT
11092:             ENDIF
11093:         ENDFOR
11094:         RETURN loc_oAchado
11095:     ENDPROC
11096: 
11097: ENDDEFINE

