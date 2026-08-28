# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (745)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_SALVA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [LOSTFOCUS-SEM-GUARDIA] Handler 'SeriesDadosValid' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoSeriesDadosValidValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterControle()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_BuscaSer' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_BuscaSerCp' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_BuscaEmpDest' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_BuscaEmpPad' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_BuscaUni' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_BuscaClf' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormNfl.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (11066 linhas total):

*-- Linhas 22 a 149:
22:     this_cModoAtual      = "LISTA"
23: 
24:     *--------------------------------------------------------------------------
25:     PROCEDURE Init()
26:         RETURN DODEFAULT()
27:     ENDPROC
28: 
29:     *--------------------------------------------------------------------------
30:     PROTECTED PROCEDURE InicializarForm()
31:         LOCAL loc_lSucesso
32:         loc_lSucesso = .F.
33: 
34:         TRY
35:             THIS.Caption = "Configura" + CHR(231) + CHR(227) + "o de Nota Fiscal"
36: 
37:             THIS.this_oBusinessObject = CREATEOBJECT("NflBO")
38: 
39:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
40:                 MsgErro("Erro ao criar NflBO.", "FormNfl")
41:             ELSE
42:                 THIS.ConfigurarPageFrame()
43:                 THIS.ConfigurarPaginaLista()
44: 
45:                 *-- Criar cursores para ControlSource dos controles das 10 abas
46:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
47:                     IF !USED("crSigCnFNf")
48:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCnFNf", "crSigCnFNf") > 0
49:                             APPEND BLANK IN crSigCnFNf
50:                         ENDIF
51:                     ENDIF
52:                     IF !USED("crSigCnFN2")
53:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCnFN2", "crSigCnFN2") > 0
54:                             APPEND BLANK IN crSigCnFN2
55:                         ENDIF
56:                     ENDIF
57:                 ELSE
58:                     IF !USED("crSigCnFNf")
59:                         CREATE CURSOR crSigCnFNf (cidchaves c(20), emps c(3), series c(3))
60:                         APPEND BLANK IN crSigCnFNf
61:                     ENDIF
62:                     IF !USED("crSigCnFN2")
63:                         CREATE CURSOR crSigCnFN2 (cidchaves c(20), emps c(3), series c(3))
64:                         APPEND BLANK IN crSigCnFN2
65:                     ENDIF
66:                 ENDIF
67: 
68:                 THIS.ConfigurarPaginaDados()
69:                 THIS.TornarControlesVisiveis(THIS)
70: 
71:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
72:                     THIS.CarregarLista()
73:                 ENDIF
74: 
75:                 THIS.pgf_4c_Paginas.Visible = .T.
76:                 THIS.pgf_4c_Paginas.ActivePage = 1
77:                 THIS.this_cModoAtual = "LISTA"
78:                 THIS.AjustarBotoesPorModo("LISTA")
79:                 loc_lSucesso = .T.
80:             ENDIF
81:         CATCH TO loc_oErro
82:             MsgErro(loc_oErro.Message, "FormNfl.InicializarForm")
83:         ENDTRY
84: 
85:         RETURN loc_lSucesso
86:     ENDPROC
87: 
88:     *--------------------------------------------------------------------------
89:     PROTECTED PROCEDURE ConfigurarPageFrame()
90:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
91:         WITH THIS.pgf_4c_Paginas
92:             .PageCount   = 2
93:             .Top         = -29
94:             .Left        = 0
95:             .Width       = THIS.Width
96:             .Height      = THIS.Height + 29
97:             .Tabs        = .F.
98:             .Visible     = .T.
99:             .Page1.Caption = "Lista"
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption = "Dados"
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:             .Page1.BackColor = RGB(255, 255, 255)
104:             .Page2.BackColor = RGB(255, 255, 255)
105:         ENDWITH
106:     ENDPROC
107: 
108:     *--------------------------------------------------------------------------
109:     PROTECTED PROCEDURE ConfigurarPaginaLista()
110:         LOCAL loc_oPagina
111:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
112: 
113:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
114:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
115: 
116:         *-- Cabecalho (faixa escura com titulo shadow + titulo principal)
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top       = 2
120:             .Left      = 0
121:             .Width     = THIS.Width
122:             .Height    = 80
123:             .BackColor = RGB(100, 100, 100)
124:             .Visible   = .T.
125:             .AddObject("lbl_4c_Sombra", "Label")
126:             WITH .lbl_4c_Sombra
127:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o de Nota Fiscal"
128:                 .Top       = 35
129:                 .Left      = 22
130:                 .Width     = THIS.Width
131:                 .Height    = 28
132:                 .FontName  = "Tahoma"
133:                 .FontSize  = 16
134:                 .ForeColor = RGB(0, 0, 0)
135:                 .BackStyle = 0
136:                 .Visible   = .T.
137:             ENDWITH
138:             .AddObject("lbl_4c_Titulo", "Label")
139:             WITH .lbl_4c_Titulo
140:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o de Nota Fiscal"
141:                 .Top       = 33
142:                 .Left      = 20
143:                 .Width     = THIS.Width
144:                 .Height    = 28
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 16
147:                 .ForeColor = RGB(255, 255, 255)
148:                 .BackStyle = 0
149:                 .Visible   = .T.

*-- Linhas 376 a 438:
376:             ENDWITH
377:         ENDWITH
378: 
379:         *-- BINDEVENTs (handlers PUBLIC obrigatorio para BINDEVENT funcionar)
380:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
381:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
382:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
383:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
384:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
385:         BINDEVENT(loc_oPagina.cmd_4c_Copia,                    "Click", THIS, "BtnCopiaClick")
386:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
387:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML,                "Click", THIS, "BtnExpXMLClick")
388:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML,                "Click", THIS, "BtnImpXMLClick")
389:         BINDEVENT(loc_oPagina.cnt_4c_copia.cmd_4c_OK,          "Click",    THIS, "CntCopiaOKClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_copia.cmd_4c_Cancela,     "Click",    THIS, "CntCopiaCancelaClick")
391:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_nomedest,    "KeyPress", THIS, "NomedestKeyPress")
392:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_nomedest,    "DblClick", THIS, "NomedestDblClick")
393:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_empDest,     "KeyPress", THIS, "EmpDestKeyPress")
394:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_empDest,     "DblClick", THIS, "EmpDestDblClick")
395:     ENDPROC
396: 
397:     *--------------------------------------------------------------------------
398:     PROTECTED PROCEDURE ConfigurarPaginaDados()
399:         LOCAL loc_oPagina
400:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
401: 
402:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
403:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
404: 
405:         *-- Serie (Top original=27/23, +29 comp)
406:         loc_oPagina.AddObject("lbl_4c_LblSerie", "Label")
407:         WITH loc_oPagina.lbl_4c_LblSerie
408:             .Caption   = "S" + CHR(233) + "rie :"
409:             .Top       = 56
410:             .Left      = 23
411:             .Height    = 15
412:             .Width     = 45
413:             .FontName  = "Tahoma"
414:             .FontSize  = 8
415:             .BackStyle = 0
416:             .ForeColor = RGB(90, 90, 90)
417:             .Visible   = .T.
418:         ENDWITH
419:         loc_oPagina.AddObject("txt_4c_Series", "TextBox")
420:         WITH loc_oPagina.txt_4c_Series
421:             .Top           = 52
422:             .Left          = 65
423:             .Width         = 31
424:             .Height        = 24
425:             .MaxLength     = 3
426:             .FontName      = "Tahoma"
427:             .FontSize      = 8
428:             .SpecialEffect = 1
429:             .Visible       = .T.
430:         ENDWITH
431: 
432:         *-- Proxima Nota Fiscal (Top original=25/21, +29 comp)
433:         loc_oPagina.AddObject("lbl_4c_LblProxNota", "Label")
434:         WITH loc_oPagina.lbl_4c_LblProxNota
435:             .Caption   = "Pr" + CHR(243) + "xima Nota Fiscal :"
436:             .Top       = 54
437:             .Left      = 132
438:             .Width     = 105

*-- Linhas 521 a 564:
521:             .ForeColor = RGB(90, 90, 90)
522:             .Visible   = .T.
523:         ENDWITH
524:         loc_oPagina.AddObject("obj_4c_Op_ItCasas", "OptionGroup")
525:         WITH loc_oPagina.obj_4c_Op_ItCasas
526:             .Top         = 125
527:             .Left        = 242
528:             .Width       = 126
529:             .Height      = 20
530:             .BackStyle   = 0
531:             .BorderStyle = 0
532:             .Value       = 1
533:             .Visible     = .T.
534:             WITH .Buttons(1)
535:                 .Caption   = "2 Casas"
536:                 .Left      = 5
537:                 .Top       = 2
538:                 .AutoSize  = .T.
539:                 .BackStyle = 0
540:                 .ForeColor = RGB(90, 90, 90)
541:             ENDWITH
542:             WITH .Buttons(2)
543:                 .Caption   = "4 Casas"
544:                 .Left      = 68
545:                 .Top       = 2
546:                 .AutoSize  = .T.
547:                 .BackStyle = 0
548:                 .FontName  = "Tahoma"
549:                 .FontSize  = 8
550:                 .ForeColor = RGB(90, 90, 90)
551:             ENDWITH
552:         ENDWITH
553: 
554:         *-- Grupo_Salva (Confirmar + Cancelar), Top original=7, +29 comp
555:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
556:         WITH loc_oPagina.cnt_4c_Salva
557:             .Top         = 36
558:             .Left        = 819
559:             .Width       = 161
560:             .Height      = 85
561:             .BackStyle   = 0
562:             .BorderWidth = 0
563:             .Visible     = .T.
564:             .AddObject("cmd_4c_Confirmar", "CommandButton")

*-- Linhas 626 a 928:
626:         THIS.ConfigurarServicosTab()
627:         THIS.ConfigurarOutrosTab()
628: 
629:         *-- BINDEVENTs Page2 diretos
630:         BINDEVENT(loc_oPagina.txt_4c_Series,                 "LostFocus",    THIS, "SeriesDadosValid")
631:         BINDEVENT(loc_oPagina.txt_4c_Series,                 "KeyPress", THIS, "SeriesKeyPress")
632:         BINDEVENT(loc_oPagina.txt_4c_Series,                 "DblClick", THIS, "SeriesDblClick")
633:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click",   THIS, "ConfirmarClick")
634:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click",   THIS, "CancelarClick")
635: 
636:         *-- BINDEVENTs lookups nas abas internas
637:         LOCAL loc_oAbas, loc_oRdp, loc_nBI, loc_cBI
638:         loc_oAbas = loc_oPagina.pgf_4c_Abas
639: 
640:         *-- EmpPad (Outros, aba 10)
641:         BINDEVENT(loc_oAbas.Page10.txt_4c_EmpPad, "KeyPress", THIS, "EmpPadKeyPress")
642:         BINDEVENT(loc_oAbas.Page10.txt_4c_EmpPad, "DblClick", THIS, "EmpPadDblClick")
643:         BINDEVENT(loc_oAbas.Page10.txt_4c_EmpPad, "KeyPress",    THIS, "EmpPadValid")
644: 
645:         *-- UnPesos (Transporte, aba 6)
646:         BINDEVENT(loc_oAbas.Page6.txt_4c_UnPesos, "KeyPress", THIS, "UnPesosKeyPress")
647:         BINDEVENT(loc_oAbas.Page6.txt_4c_UnPesos, "DblClick", THIS, "UnPesosDblClick")
648:         BINDEVENT(loc_oAbas.Page6.txt_4c_UnPesos, "KeyPress",    THIS, "UnPesosValid")
649: 
650:         *-- CodImp 1-7 (Rodape, aba 7, bloco 1)
651:         loc_oRdp = loc_oAbas.Page7
652:         LOCAL loc_oTxtDin
653:         FOR loc_nBI = 1 TO 7
654:             loc_cBI    = ALLTRIM(STR(loc_nBI))
655:             loc_oTxtDin = THIS.ObterControle(loc_oRdp, "txt_4c_CodImp" + loc_cBI)
656:             IF VARTYPE(loc_oTxtDin) = "O"
657:                 BINDEVENT(loc_oTxtDin, "KeyPress",  THIS, "CodImp"  + loc_cBI + "KeyPress")
658:                 BINDEVENT(loc_oTxtDin, "DblClick",  THIS, "CodImp"  + loc_cBI + "DblClick")
659:                 BINDEVENT(loc_oTxtDin, "LostFocus", THIS, "CodImp"  + loc_cBI + "LostFocus")
660:             ENDIF
661:         ENDFOR
662: 
663:         *-- CodImpB 8-12 (Rodape, aba 7, bloco 2)
664:         FOR loc_nBI = 8 TO 12
665:             loc_cBI    = ALLTRIM(STR(loc_nBI))
666:             loc_oTxtDin = THIS.ObterControle(loc_oRdp, "txt_4c_CodImpB" + loc_cBI)
667:             IF VARTYPE(loc_oTxtDin) = "O"
668:                 BINDEVENT(loc_oTxtDin, "KeyPress",  THIS, "CodImpB" + loc_cBI + "KeyPress")
669:                 BINDEVENT(loc_oTxtDin, "DblClick",  THIS, "CodImpB" + loc_cBI + "DblClick")
670:                 BINDEVENT(loc_oTxtDin, "LostFocus", THIS, "CodImpB" + loc_cBI + "LostFocus")
671:             ENDIF
672:         ENDFOR
673: 
674:         *-- Get_Class (Rodape, aba 7)
675:         BINDEVENT(loc_oRdp.obj_4c_ClsFisTp, "Click", THIS, "ClsFisTpClick")
676:     ENDPROC
677: 
678:     *--------------------------------------------------------------------------
679:     PROCEDURE CarregarLista()
680:         LOCAL loc_lResultado
681:         loc_lResultado = .F.
682: 
683:         TRY
684:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
685:                 loc_lResultado = .T.
686:             ELSE
687:                 loc_lResultado = THIS.this_oBusinessObject.Buscar("")
688:                 IF loc_lResultado AND VARTYPE(THIS.pgf_4c_Paginas) = "O"
689:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
690:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 4
691:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
692:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.emps"
693:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.Razas"
694:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.series"
695:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.cidchaves"
696:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Empr."
697:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Empresa"
698:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.Header1.Caption = "S" + CHR(233) + "rie"
699:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.Header1.Caption = "Chave"
700:                     ENDIF
701:                 ENDIF
702:             ENDIF
703:         CATCH TO loc_oErro
704:             MsgErro(loc_oErro.Message, "FormNfl.CarregarLista")
705:         ENDTRY
706: 
707:         RETURN loc_lResultado
708:     ENDPROC
709: 
710:     *--------------------------------------------------------------------------
711:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
712:         LOCAL loc_lResultado
713:         loc_lResultado = .F.
714: 
715:         TRY
716:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
717:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
718:                 IF par_nPagina = 1
719:                     THIS.this_cModoAtual = "LISTA"
720:                     THIS.AjustarBotoesPorModo("LISTA")
721:                     THIS.CarregarLista()
722:                 ENDIF
723:                 loc_lResultado = .T.
724:             ENDIF
725:         CATCH TO loc_oErro
726:             MsgErro(loc_oErro.Message, "FormNfl.AlternarPagina")
727:         ENDTRY
728: 
729:         RETURN loc_lResultado
730:     ENDPROC
731: 
732:     *--------------------------------------------------------------------------
733:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
734:         WITH par_oGrid
735:             .FontName = "Tahoma"
736:             .FontSize = 8
737:             .SetAll("ForeColor", RGB(90, 90, 90), "Column")
738:         ENDWITH
739:     ENDPROC
740: 
741:     *--------------------------------------------------------------------------
742:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
743:         LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP
744:         FOR loc_nI = 1 TO par_oContainer.ControlCount
745:             loc_oObjeto = par_oContainer.Controls(loc_nI)
746:             IF VARTYPE(loc_oObjeto) = "O"
747:                 loc_cNome = UPPER(loc_oObjeto.Name)
748: 
749:                 IF loc_cNome == "CNT_4C_COPIA"
750:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
751:                         THIS.TornarControlesVisiveis(loc_oObjeto)
752:                     ENDIF
753:                     LOOP
754:                 ENDIF
755: 
756:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
757:                     loc_oObjeto.Visible = .T.
758:                 ENDIF
759: 
760:                 IF PEMSTATUS(loc_oObjeto, "BaseClass", 5) AND UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
761:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
762:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
763:                     ENDFOR
764:                 ENDIF
765: 
766:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
767:                     THIS.TornarControlesVisiveis(loc_oObjeto)
768:                 ENDIF
769:             ENDIF
770:         ENDFOR
771:     ENDPROC
772: 
773:     *--------------------------------------------------------------------------
774:     PROTECTED PROCEDURE LimparCampos()
775:         LOCAL loc_oPag2
776:         TRY
777:             IF USED("crSigCnFNf")
778:                 ZAP IN crSigCnFNf
779:                 APPEND BLANK IN crSigCnFNf
780:             ENDIF
781:             IF USED("crSigCnFN2")
782:                 ZAP IN crSigCnFN2
783:                 APPEND BLANK IN crSigCnFN2
784:             ENDIF
785:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
786:                 loc_oPag2 = THIS.pgf_4c_Paginas.Page2
787:                 IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
788:                     loc_oPag2.txt_4c_Series.Value = ""
789:                 ENDIF
790:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxNota", 5)
791:                     loc_oPag2.txt_4c_ProxNota.Value = ""
792:                 ENDIF
793:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxSelo", 5)
794:                     loc_oPag2.txt_4c_ProxSelo.Value = ""
795:                 ENDIF
796:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxSeloTrans", 5)
797:                     loc_oPag2.txt_4c_ProxSeloTrans.Value = ""
798:                 ENDIF
799:                 IF PEMSTATUS(loc_oPag2, "obj_4c_Op_ItCasas", 5)
800:                     loc_oPag2.obj_4c_Op_ItCasas.Value = 1
801:                 ENDIF
802:                 IF VARTYPE(loc_oPag2.pgf_4c_Abas) = "O"
803:                     IF PEMSTATUS(loc_oPag2.pgf_4c_Abas.Page10, "txt_4c_EmpPad", 5)
804:                         loc_oPag2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value = ""
805:                     ENDIF
806:                 ENDIF
807:             ENDIF
808:         CATCH TO loc_oErro
809:             MsgErro(loc_oErro.Message, "FormNfl.LimparCampos")
810:         ENDTRY
811:     ENDPROC
812: 
813:     *--------------------------------------------------------------------------
814:     * HabilitarCampos - Habilita/desabilita campos de entrada da Page2 (todas as abas)
815:     * par_lHabilitar = .T. para habilitar edicao, .F. para modo VISUALIZAR
816:     * A chave (Series) so eh editavel em modo INCLUIR
817:     *--------------------------------------------------------------------------
818:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
819:         LOCAL loc_oPag2, loc_lChaveEdit
820:         TRY
821:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
822:                 loc_oPag2      = THIS.pgf_4c_Paginas.Page2
823:                 loc_lChaveEdit = (THIS.this_cModoAtual = "INCLUIR")
824: 
825:                 *-- Campos standalone Page2
826:                 IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
827:                     loc_oPag2.txt_4c_Series.Enabled = loc_lChaveEdit
828:                 ENDIF
829:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxNota", 5)
830:                     loc_oPag2.txt_4c_ProxNota.Enabled = par_lHabilitar
831:                 ENDIF
832:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxSelo", 5)
833:                     loc_oPag2.txt_4c_ProxSelo.Enabled = par_lHabilitar
834:                 ENDIF
835:                 IF PEMSTATUS(loc_oPag2, "txt_4c_ProxSeloTrans", 5)
836:                     loc_oPag2.txt_4c_ProxSeloTrans.Enabled = par_lHabilitar
837:                 ENDIF
838:                 IF PEMSTATUS(loc_oPag2, "obj_4c_Op_ItCasas", 5)
839:                     loc_oPag2.obj_4c_Op_ItCasas.Enabled = par_lHabilitar
840:                 ENDIF
841: 
842:                 *-- Recursivamente aplica a todas as abas internas
843:                 IF PEMSTATUS(loc_oPag2, "pgf_4c_Abas", 5)
844:                     THIS.AplicarEnabledRecursivo(loc_oPag2.pgf_4c_Abas, par_lHabilitar)
845:                 ENDIF
846:             ENDIF
847:         CATCH TO loc_oErro
848:             MsgErro(loc_oErro.Message, "FormNfl.HabilitarCampos")
849:         ENDTRY
850:     ENDPROC
851: 
852:     *--------------------------------------------------------------------------
853:     * AplicarEnabledRecursivo - Percorre container e seta Enabled em controles de entrada
854:     *--------------------------------------------------------------------------
855:     PROTECTED PROCEDURE AplicarEnabledRecursivo(par_oContainer, par_lEnabled)
856:         LOCAL loc_nI, loc_oCtrl, loc_cBase, loc_nP
857:         FOR loc_nI = 1 TO par_oContainer.ControlCount
858:             loc_oCtrl = par_oContainer.Controls(loc_nI)
859:             IF VARTYPE(loc_oCtrl) != "O"
860:                 LOOP
861:             ENDIF
862:             IF !PEMSTATUS(loc_oCtrl, "BaseClass", 5)
863:                 LOOP
864:             ENDIF
865:             loc_cBase = UPPER(loc_oCtrl.BaseClass)
866: 
867:             DO CASE
868:                 CASE loc_cBase = "PAGEFRAME"
869:                     FOR loc_nP = 1 TO loc_oCtrl.PageCount
870:                         THIS.AplicarEnabledRecursivo(loc_oCtrl.Pages(loc_nP), par_lEnabled)
871:                     ENDFOR
872:                 CASE INLIST(loc_cBase, "CONTAINER", "PAGE")
873:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
874:                         THIS.AplicarEnabledRecursivo(loc_oCtrl, par_lEnabled)
875:                     ENDIF
876:                 CASE INLIST(loc_cBase, "TEXTBOX", "EDITBOX", "COMBOBOX", "CHECKBOX", "OPTIONGROUP", "SPINNER")
877:                     IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
878:                         loc_oCtrl.Enabled = par_lEnabled
879:                     ENDIF
880:             ENDCASE
881:         ENDFOR
882:     ENDPROC
883: 
884:     *--------------------------------------------------------------------------
885:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD/Salvar/Cancelar
886:     * par_cModo: "LISTA", "INCLUIR", "ALTERAR", "VISUALIZAR"
887:     *--------------------------------------------------------------------------
888:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
889:         LOCAL loc_oPag1, loc_oPag2, loc_oBot, loc_oSal
890:         LOCAL loc_lLista, loc_lEditando, loc_lVisualiza
891:         TRY
892:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
893:                 loc_oPag1      = THIS.pgf_4c_Paginas.Page1
894:                 loc_oPag2      = THIS.pgf_4c_Paginas.Page2
895:                 loc_lLista     = (par_cModo = "LISTA")
896:                 loc_lEditando  = (par_cModo = "INCLUIR" OR par_cModo = "ALTERAR")
897:                 loc_lVisualiza = (par_cModo = "VISUALIZAR")
898: 
899:                 *-- Botoes CRUD Page1
900:                 IF PEMSTATUS(loc_oPag1, "cnt_4c_Botoes", 5)
901:                     loc_oBot = loc_oPag1.cnt_4c_Botoes
902:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Incluir", 5)
903:                         loc_oBot.cmd_4c_Incluir.Enabled    = loc_lLista
904:                     ENDIF
905:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Visualizar", 5)
906:                         loc_oBot.cmd_4c_Visualizar.Enabled = loc_lLista
907:                     ENDIF
908:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Alterar", 5)
909:                         loc_oBot.cmd_4c_Alterar.Enabled    = loc_lLista
910:                     ENDIF
911:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Excluir", 5)
912:                         loc_oBot.cmd_4c_Excluir.Enabled    = loc_lLista
913:                     ENDIF
914:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Buscar", 5)
915:                         loc_oBot.cmd_4c_Buscar.Enabled     = loc_lLista
916:                     ENDIF
917:                 ENDIF
918:                 IF PEMSTATUS(loc_oPag1, "cmd_4c_Copia", 5)
919:                     loc_oPag1.cmd_4c_Copia.Enabled       = loc_lLista
920:                 ENDIF
921:                 IF PEMSTATUS(loc_oPag1, "cmd_4c_BtnExpXML", 5)
922:                     loc_oPag1.cmd_4c_BtnExpXML.Enabled   = loc_lLista
923:                 ENDIF
924:                 IF PEMSTATUS(loc_oPag1, "cmd_4c_BtnImpXML", 5)
925:                     loc_oPag1.cmd_4c_BtnImpXML.Enabled   = loc_lLista
926:                 ENDIF
927: 
928:                 *-- Botoes Confirmar/Cancelar Page2

*-- Linhas 942 a 1194:
942:     ENDPROC
943: 
944:     *--------------------------------------------------------------------------
945:     PROCEDURE BtnIncluirClick()
946:         LOCAL loc_lResultado
947:         loc_lResultado = .F.
948:         TRY
949:             THIS.this_oBusinessObject.NovoRegistro()
950:             THIS.LimparCampos()
951:             THIS.this_cModoAtual = "INCLUIR"
952:             THIS.HabilitarCampos(.T.)
953:             THIS.AjustarBotoesPorModo("INCLUIR")
954:             THIS.AlternarPagina(2)
955:             THIS.this_cModoAtual = "INCLUIR"
956:             loc_lResultado = .T.
957:         CATCH TO loc_oErro
958:             MsgErro(loc_oErro.Message, "FormNfl.BtnIncluirClick")
959:         ENDTRY
960:         RETURN loc_lResultado
961:     ENDPROC
962: 
963:     *--------------------------------------------------------------------------
964:     PROCEDURE BtnVisualizarClick()
965:         LOCAL loc_lResultado, loc_cChave
966:         loc_lResultado = .F.
967:         TRY
968:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
969:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
970:             ELSE
971:                 SELECT cursor_4c_Dados
972:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
973:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
974:                     THIS.BOParaForm()
975:                     THIS.this_cModoAtual = "VISUALIZAR"
976:                     THIS.HabilitarCampos(.F.)
977:                     THIS.AjustarBotoesPorModo("VISUALIZAR")
978:                     THIS.AlternarPagina(2)
979:                     THIS.this_cModoAtual = "VISUALIZAR"
980:                     loc_lResultado = .T.
981:                 ENDIF
982:             ENDIF
983:         CATCH TO loc_oErro
984:             MsgErro(loc_oErro.Message, "FormNfl.BtnVisualizarClick")
985:         ENDTRY
986:         RETURN loc_lResultado
987:     ENDPROC
988: 
989:     *--------------------------------------------------------------------------
990:     PROCEDURE BtnAlterarClick()
991:         LOCAL loc_lResultado, loc_cChave
992:         loc_lResultado = .F.
993:         TRY
994:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
995:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
996:             ELSE
997:                 SELECT cursor_4c_Dados
998:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
999:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1000:                     THIS.this_oBusinessObject.EditarRegistro()
1001:                     THIS.BOParaForm()
1002:                     THIS.this_cModoAtual = "ALTERAR"
1003:                     THIS.HabilitarCampos(.T.)
1004:                     THIS.AjustarBotoesPorModo("ALTERAR")
1005:                     THIS.AlternarPagina(2)
1006:                     THIS.this_cModoAtual = "ALTERAR"
1007:                     loc_lResultado = .T.
1008:                 ENDIF
1009:             ENDIF
1010:         CATCH TO loc_oErro
1011:             MsgErro(loc_oErro.Message, "FormNfl.BtnAlterarClick")
1012:         ENDTRY
1013:         RETURN loc_lResultado
1014:     ENDPROC
1015: 
1016:     *--------------------------------------------------------------------------
1017:     PROCEDURE BtnExcluirClick()
1018:         LOCAL loc_lResultado, loc_cChave, loc_lConfirma
1019:         loc_lResultado = .F.
1020:         TRY
1021:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1022:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
1023:             ELSE
1024:                 SELECT cursor_4c_Dados
1025:                 loc_cChave    = ALLTRIM(cursor_4c_Dados.cidchaves)
1026:                 loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da configura" + CHR(231) + CHR(227) + "o selecionada?", "FormNfl")
1027:                 IF loc_lConfirma
1028:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1029:                         loc_lResultado = THIS.this_oBusinessObject.Excluir()
1030:                         IF loc_lResultado
1031:                             THIS.CarregarLista()
1032:                         ENDIF
1033:                     ENDIF
1034:                 ENDIF
1035:             ENDIF
1036:         CATCH TO loc_oErro
1037:             MsgErro(loc_oErro.Message, "FormNfl.BtnExcluirClick")
1038:         ENDTRY
1039:         RETURN loc_lResultado
1040:     ENDPROC
1041: 
1042:     *--------------------------------------------------------------------------
1043:     PROCEDURE BtnBuscarClick()
1044:         LOCAL loc_lResultado, loc_cFiltro
1045:         loc_lResultado = .F.
1046:         TRY
1047:             loc_cFiltro    = INPUTBOX("Informe s" + CHR(233) + "rie ou empresa:", "Buscar", "")
1048:             loc_lResultado = THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
1049:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1050:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 4
1051:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
1052:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.emps"
1053:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.Razas"
1054:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.series"
1055:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.cidchaves"
1056:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Empr."
1057:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Empresa"
1058:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.Header1.Caption = "S" + CHR(233) + "rie"
1059:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.Header1.Caption = "Chave"
1060:             ENDIF
1061:         CATCH TO loc_oErro
1062:             MsgErro(loc_oErro.Message, "FormNfl.BtnBuscarClick")
1063:         ENDTRY
1064:         RETURN loc_lResultado
1065:     ENDPROC
1066: 
1067:     *--------------------------------------------------------------------------
1068:     PROCEDURE BtnEncerrarClick()
1069:         THIS.Release()
1070:     ENDPROC
1071: 
1072:     *--------------------------------------------------------------------------
1073:     PROCEDURE BtnCopiaClick()
1074:         TRY
1075:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_copia", 5)
1076:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.Visible = .T.
1077:             ENDIF
1078:         CATCH TO loc_oErro
1079:             MsgErro(loc_oErro.Message, "FormNfl.BtnCopiaClick")
1080:         ENDTRY
1081:     ENDPROC
1082: 
1083:     *--------------------------------------------------------------------------
1084:     PROCEDURE BtnExpXMLClick()
1085:         LOCAL loc_oForm
1086:         TRY
1087:             loc_oForm = CREATEOBJECT("FormSigOpXml")
1088:             IF VARTYPE(loc_oForm) = "O"
1089:                 loc_oForm.Show()
1090:             ENDIF
1091:         CATCH TO loc_oErro
1092:             MsgErro(loc_oErro.Message, "FormNfl.BtnExpXMLClick")
1093:         ENDTRY
1094:     ENDPROC
1095: 
1096:     *--------------------------------------------------------------------------
1097:     PROCEDURE BtnImpXMLClick()
1098:         LOCAL loc_oForm
1099:         TRY
1100:             loc_oForm = CREATEOBJECT("FormSigOpXml")
1101:             IF VARTYPE(loc_oForm) = "O"
1102:                 loc_oForm.Show()
1103:             ENDIF
1104:         CATCH TO loc_oErro
1105:             MsgErro(loc_oErro.Message, "FormNfl.BtnImpXMLClick")
1106:         ENDTRY
1107:     ENDPROC
1108: 
1109:     *--------------------------------------------------------------------------
1110:     PROCEDURE CntCopiaOKClick()
1111:         LOCAL loc_lResultado, loc_cSerieOrig, loc_cSerieDest, loc_cEmpDest
1112:         LOCAL loc_oCopia
1113:         loc_lResultado = .F.
1114:         TRY
1115:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1116:                 MsgAviso("Nenhuma configura" + CHR(231) + CHR(227) + "o selecionada para copiar.", "FormNfl")
1117:             ELSE
1118:                 loc_oCopia     = THIS.pgf_4c_Paginas.Page1.cnt_4c_copia
1119:                 loc_cSerieOrig = ALLTRIM(cursor_4c_Dados.series)
1120:                 loc_cSerieDest = ALLTRIM(loc_oCopia.txt_4c_nomedest.Value)
1121:                 loc_cEmpDest   = ALLTRIM(loc_oCopia.txt_4c_empDest.Value)
1122:                 IF EMPTY(loc_cSerieDest)
1123:                     MsgAviso("Informe a s" + CHR(233) + "rie destino.", "FormNfl")
1124:                 ELSE
1125:                     IF EMPTY(loc_cEmpDest)
1126:                     MsgAviso("Informe a empresa destino.", "FormNfl")
1127:                 ELSE
1128:                     loc_lResultado = THIS.this_oBusinessObject.Copiar(loc_cSerieOrig, loc_cSerieDest, loc_cEmpDest)
1129:                     IF loc_lResultado
1130:                         loc_oCopia.Visible = .F.
1131:                         THIS.CarregarLista()
1132:                     ENDIF
1133:                     ENDIF
1134:                 ENDIF
1135:             ENDIF
1136:         CATCH TO loc_oErro
1137:             MsgErro(loc_oErro.Message, "FormNfl.CntCopiaOKClick")
1138:         ENDTRY
1139:         RETURN loc_lResultado
1140:     ENDPROC
1141: 
1142:     *--------------------------------------------------------------------------
1143:     PROCEDURE CntCopiaCancelaClick()
1144:         TRY
1145:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_copia", 5)
1146:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.Visible = .F.
1147:             ENDIF
1148:         CATCH TO loc_oErro
1149:             MsgErro(loc_oErro.Message, "FormNfl.CntCopiaCancelaClick")
1150:         ENDTRY
1151:     ENDPROC
1152: 
1153:     *--------------------------------------------------------------------------
1154:     PROTECTED PROCEDURE ConfigurarCabecalhoTab()
1155:         LOCAL loc_oAba
1156:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1157: 
1158:         *-- Shape decorativo (painel impressora)
1159:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
1160:         WITH loc_oAba.shp_4c_Shape1
1161:             .Top           = 41
1162:             .Left          = 381
1163:             .Height        = 139
1164:             .Width         = 265
1165:             .BackStyle     = 0
1166:             .SpecialEffect = 0
1167:             .Visible       = .T.
1168:         ENDWITH
1169: 
1170:         *===== Coluna esquerda: dimensoes de impressao NF =====
1171: 
1172:         *-- No NF (l1nf x c1nf)
1173:         loc_oAba.AddObject("lbl_4c_Label1", "Label")
1174:         WITH loc_oAba.lbl_4c_Label1
1175:             .Caption   = "N" + CHR(186) + " NF"
1176:             .Top       = 33
1177:             .Left      = 41
1178:             .Width     = 29
1179:             .Height    = 13
1180:             .FontName  = "Tahoma"
1181:             .FontSize  = 7
1182:             .BackStyle = 0
1183:             .ForeColor = RGB(90, 90, 90)
1184:             .Visible   = .T.
1185:         ENDWITH
1186:         loc_oAba.AddObject("txt_4c_Text1", "TextBox")
1187:         WITH loc_oAba.txt_4c_Text1
1188:             .ControlSource = "crSigCnFNf.l1nf"
1189:             .Top           = 46
1190:             .Left          = 41
1191:             .Width         = 41
1192:             .Height        = 18
1193:             .FontName      = "Tahoma"
1194:             .FontSize      = 8

*-- Linhas 1239 a 1260:
1239:             .FontSize  = 7
1240:             .BackStyle = 0
1241:             .ForeColor = RGB(90, 90, 90)
1242:             .Visible   = .T.
1243:         ENDWITH
1244:         loc_oAba.AddObject("txt_4c_Text3", "TextBox")
1245:         WITH loc_oAba.txt_4c_Text3
1246:             .ControlSource = "crSigCnFNf.lnfsai"
1247:             .Top           = 78
1248:             .Left          = 41
1249:             .Width         = 41
1250:             .Height        = 18
1251:             .FontName      = "Tahoma"
1252:             .FontSize      = 8
1253:             .Format        = "K"
1254:             .InputMask     = "999.99"
1255:             .SpecialEffect = 1
1256:             .Margin        = 0
1257:             .Visible       = .T.
1258:         ENDWITH
1259:         loc_oAba.AddObject("lbl_4c_Label4", "Label")
1260:         WITH loc_oAba.lbl_4c_Label4

*-- Linhas 1267 a 1288:
1267:             .FontSize  = 7
1268:             .BackStyle = 0
1269:             .ForeColor = RGB(90, 90, 90)
1270:             .Visible   = .T.
1271:         ENDWITH
1272:         loc_oAba.AddObject("txt_4c_Text4", "TextBox")
1273:         WITH loc_oAba.txt_4c_Text4
1274:             .ControlSource = "crSigCnFNf.cnfsai"
1275:             .Top           = 78
1276:             .Left          = 90
1277:             .Width         = 41
1278:             .Height        = 18
1279:             .FontName      = "Tahoma"
1280:             .FontSize      = 8
1281:             .Format        = "K"
1282:             .InputMask     = "999.99"
1283:             .SpecialEffect = 1
1284:             .Margin        = 0
1285:             .Visible       = .T.
1286:         ENDWITH
1287: 
1288:         *-- NF Entrada (lnfent x cnfent)

*-- Linhas 1297 a 1318:
1297:             .FontSize  = 7
1298:             .BackStyle = 0
1299:             .ForeColor = RGB(90, 90, 90)
1300:             .Visible   = .T.
1301:         ENDWITH
1302:         loc_oAba.AddObject("txt_4c_Text5", "TextBox")
1303:         WITH loc_oAba.txt_4c_Text5
1304:             .ControlSource = "crSigCnFNf.lnfent"
1305:             .Top           = 110
1306:             .Left          = 41
1307:             .Width         = 41
1308:             .Height        = 18
1309:             .FontName      = "Tahoma"
1310:             .FontSize      = 8
1311:             .Format        = "K"
1312:             .InputMask     = "999.99"
1313:             .SpecialEffect = 1
1314:             .Margin        = 0
1315:             .Visible       = .T.
1316:         ENDWITH
1317:         loc_oAba.AddObject("lbl_4c_Label6", "Label")
1318:         WITH loc_oAba.lbl_4c_Label6

*-- Linhas 1325 a 1346:
1325:             .FontSize  = 7
1326:             .BackStyle = 0
1327:             .ForeColor = RGB(90, 90, 90)
1328:             .Visible   = .T.
1329:         ENDWITH
1330:         loc_oAba.AddObject("txt_4c_Text6", "TextBox")
1331:         WITH loc_oAba.txt_4c_Text6
1332:             .ControlSource = "crSigCnFNf.cnfent"
1333:             .Top           = 110
1334:             .Left          = 90
1335:             .Width         = 41
1336:             .Height        = 18
1337:             .FontName      = "Tahoma"
1338:             .FontSize      = 8
1339:             .Format        = "K"
1340:             .InputMask     = "999.99"
1341:             .SpecialEffect = 1
1342:             .Margin        = 0
1343:             .Visible       = .T.
1344:         ENDWITH
1345: 
1346:         *-- Nat. Operacao (lnatop x cnatop)

*-- Linhas 1355 a 1376:
1355:             .FontSize  = 7
1356:             .BackStyle = 0
1357:             .ForeColor = RGB(90, 90, 90)
1358:             .Visible   = .T.
1359:         ENDWITH
1360:         loc_oAba.AddObject("txt_4c_Text7", "TextBox")
1361:         WITH loc_oAba.txt_4c_Text7
1362:             .ControlSource = "crSigCnFNf.lnatop"
1363:             .Top           = 142
1364:             .Left          = 41
1365:             .Width         = 41
1366:             .Height        = 18
1367:             .FontName      = "Tahoma"
1368:             .FontSize      = 8
1369:             .Format        = "K"
1370:             .InputMask     = "999.99"
1371:             .SpecialEffect = 1
1372:             .Margin        = 0
1373:             .Visible       = .T.
1374:         ENDWITH
1375:         loc_oAba.AddObject("lbl_4c_Label8", "Label")
1376:         WITH loc_oAba.lbl_4c_Label8

*-- Linhas 1383 a 1404:
1383:             .FontSize  = 7
1384:             .BackStyle = 0
1385:             .ForeColor = RGB(90, 90, 90)
1386:             .Visible   = .T.
1387:         ENDWITH
1388:         loc_oAba.AddObject("txt_4c_Text8", "TextBox")
1389:         WITH loc_oAba.txt_4c_Text8
1390:             .ControlSource = "crSigCnFNf.cnatop"
1391:             .Top           = 142
1392:             .Left          = 90
1393:             .Width         = 41
1394:             .Height        = 18
1395:             .FontName      = "Tahoma"
1396:             .FontSize      = 8
1397:             .Format        = "K"
1398:             .InputMask     = "999.99"
1399:             .SpecialEffect = 1
1400:             .Margin        = 0
1401:             .Visible       = .T.
1402:         ENDWITH
1403: 
1404:         *-- CFOP (lcfop x ccfop)

*-- Linhas 1413 a 1434:
1413:             .FontSize  = 7
1414:             .BackStyle = 0
1415:             .ForeColor = RGB(90, 90, 90)
1416:             .Visible   = .T.
1417:         ENDWITH
1418:         loc_oAba.AddObject("txt_4c_Text9", "TextBox")
1419:         WITH loc_oAba.txt_4c_Text9
1420:             .ControlSource = "crSigCnFNf.lcfop"
1421:             .Top           = 174
1422:             .Left          = 41
1423:             .Width         = 41
1424:             .Height        = 18
1425:             .FontName      = "Tahoma"
1426:             .FontSize      = 8
1427:             .Format        = "K"
1428:             .InputMask     = "999.99"
1429:             .SpecialEffect = 1
1430:             .Margin        = 0
1431:             .Visible       = .T.
1432:         ENDWITH
1433:         loc_oAba.AddObject("lbl_4c_Label10", "Label")
1434:         WITH loc_oAba.lbl_4c_Label10

*-- Linhas 1441 a 1462:
1441:             .FontSize  = 7
1442:             .BackStyle = 0
1443:             .ForeColor = RGB(90, 90, 90)
1444:             .Visible   = .T.
1445:         ENDWITH
1446:         loc_oAba.AddObject("txt_4c_Text10", "TextBox")
1447:         WITH loc_oAba.txt_4c_Text10
1448:             .ControlSource = "crSigCnFNf.ccfop"
1449:             .Top           = 174
1450:             .Left          = 90
1451:             .Width         = 41
1452:             .Height        = 18
1453:             .FontName      = "Tahoma"
1454:             .FontSize      = 8
1455:             .Format        = "K"
1456:             .InputMask     = "999.99"
1457:             .SpecialEffect = 1
1458:             .Margin        = 0
1459:             .Visible       = .T.
1460:         ENDWITH
1461: 
1462:         *-- Razao Social (LRAZEMP x CRAZEMP, sem ControlSource)

*-- Linhas 1585 a 1606:
1585:             .FontSize  = 7
1586:             .BackStyle = 0
1587:             .ForeColor = RGB(90, 90, 90)
1588:             .Visible   = .T.
1589:         ENDWITH
1590:         loc_oAba.AddObject("txt_4c_Text12", "TextBox")
1591:         WITH loc_oAba.txt_4c_Text12
1592:             .ControlSource = "crSigCnFN2.lxinc"
1593:             .Top           = 46
1594:             .Left          = 165
1595:             .Width         = 41
1596:             .Height        = 18
1597:             .FontName      = "Tahoma"
1598:             .FontSize      = 8
1599:             .Format        = "K"
1600:             .InputMask     = "999.99"
1601:             .SpecialEffect = 1
1602:             .Margin        = 0
1603:             .Visible       = .T.
1604:         ENDWITH
1605:         loc_oAba.AddObject("lbl_4c_Label20", "Label")
1606:         WITH loc_oAba.lbl_4c_Label20

*-- Linhas 1613 a 1634:
1613:             .FontSize  = 7
1614:             .BackStyle = 0
1615:             .ForeColor = RGB(90, 90, 90)
1616:             .Visible   = .T.
1617:         ENDWITH
1618:         loc_oAba.AddObject("txt_4c_Text16", "TextBox")
1619:         WITH loc_oAba.txt_4c_Text16
1620:             .ControlSource = "crSigCnFN2.cxinc"
1621:             .Top           = 46
1622:             .Left          = 214
1623:             .Width         = 41
1624:             .Height        = 18
1625:             .FontName      = "Tahoma"
1626:             .FontSize      = 8
1627:             .Format        = "K"
1628:             .InputMask     = "999.99"
1629:             .SpecialEffect = 1
1630:             .Margin        = 0
1631:             .Visible       = .T.
1632:         ENDWITH
1633:         loc_oAba.AddObject("lbl_4c_Label21", "Label")
1634:         WITH loc_oAba.lbl_4c_Label21

*-- Linhas 1641 a 1662:
1641:             .FontSize  = 7
1642:             .BackStyle = 0
1643:             .ForeColor = RGB(90, 90, 90)
1644:             .Visible   = .T.
1645:         ENDWITH
1646:         loc_oAba.AddObject("txt_4c_Text17", "TextBox")
1647:         WITH loc_oAba.txt_4c_Text17
1648:             .ControlSource = "crSigCnFN2.lenxinc"
1649:             .Top           = 46
1650:             .Left          = 261
1651:             .Width         = 41
1652:             .Height        = 18
1653:             .FontName      = "Tahoma"
1654:             .FontSize      = 8
1655:             .Format        = "K"
1656:             .InputMask     = "99999"
1657:             .SpecialEffect = 1
1658:             .Margin        = 0
1659:             .Visible       = .T.
1660:         ENDWITH
1661: 
1662:         *-- SAC (lsac x csac + contsac)

*-- Linhas 1671 a 1692:
1671:             .FontSize  = 7
1672:             .BackStyle = 0
1673:             .ForeColor = RGB(90, 90, 90)
1674:             .Visible   = .T.
1675:         ENDWITH
1676:         loc_oAba.AddObject("txt_4c_Text18", "TextBox")
1677:         WITH loc_oAba.txt_4c_Text18
1678:             .ControlSource = "crSigCnFN2.lsac"
1679:             .Top           = 78
1680:             .Left          = 164
1681:             .Width         = 41
1682:             .Height        = 18
1683:             .FontName      = "Tahoma"
1684:             .FontSize      = 8
1685:             .Format        = "K"
1686:             .InputMask     = "999.99"
1687:             .SpecialEffect = 1
1688:             .Margin        = 0
1689:             .Visible       = .T.
1690:         ENDWITH
1691:         loc_oAba.AddObject("lbl_4c_Label23", "Label")
1692:         WITH loc_oAba.lbl_4c_Label23

*-- Linhas 1699 a 1735:
1699:             .FontSize  = 7
1700:             .BackStyle = 0
1701:             .ForeColor = RGB(90, 90, 90)
1702:             .Visible   = .T.
1703:         ENDWITH
1704:         loc_oAba.AddObject("txt_4c_Text19", "TextBox")
1705:         WITH loc_oAba.txt_4c_Text19
1706:             .ControlSource = "crSigCnFN2.csac"
1707:             .Top           = 78
1708:             .Left          = 213
1709:             .Width         = 41
1710:             .Height        = 18
1711:             .FontName      = "Tahoma"
1712:             .FontSize      = 8
1713:             .Format        = "K"
1714:             .InputMask     = "999.99"
1715:             .SpecialEffect = 1
1716:             .Margin        = 0
1717:             .Visible       = .T.
1718:         ENDWITH
1719:         loc_oAba.AddObject("txt_4c_Text20", "TextBox")
1720:         WITH loc_oAba.txt_4c_Text20
1721:             .ControlSource = "crSigCnFN2.contsac"
1722:             .Top           = 97
1723:             .Left          = 164
1724:             .Width         = 137
1725:             .Height        = 18
1726:             .MaxLength     = 20
1727:             .FontName      = "Tahoma"
1728:             .FontSize      = 8
1729:             .Format        = "K"
1730:             .SpecialEffect = 1
1731:             .Margin        = 0
1732:             .Visible       = .T.
1733:         ENDWITH
1734: 
1735:         *-- Nat. Operacao Substituicao Tributaria (lnatopsub x cnatopsub)

*-- Linhas 1744 a 1765:
1744:             .FontSize  = 7
1745:             .BackStyle = 0
1746:             .ForeColor = RGB(90, 90, 90)
1747:             .Visible   = .T.
1748:         ENDWITH
1749:         loc_oAba.AddObject("txt_4c_Text21", "TextBox")
1750:         WITH loc_oAba.txt_4c_Text21
1751:             .ControlSource = "crSigCnFN2.lnatopsub"
1752:             .Top           = 142
1753:             .Left          = 164
1754:             .Width         = 41
1755:             .Height        = 18
1756:             .FontName      = "Tahoma"
1757:             .FontSize      = 8
1758:             .Format        = "K"
1759:             .InputMask     = "999.99"
1760:             .SpecialEffect = 1
1761:             .Margin        = 0
1762:             .Visible       = .T.
1763:         ENDWITH
1764:         loc_oAba.AddObject("lbl_4c_Label25", "Label")
1765:         WITH loc_oAba.lbl_4c_Label25

*-- Linhas 1772 a 1793:
1772:             .FontSize  = 7
1773:             .BackStyle = 0
1774:             .ForeColor = RGB(90, 90, 90)
1775:             .Visible   = .T.
1776:         ENDWITH
1777:         loc_oAba.AddObject("txt_4c_Text22", "TextBox")
1778:         WITH loc_oAba.txt_4c_Text22
1779:             .ControlSource = "crSigCnFN2.cnatopsub"
1780:             .Top           = 142
1781:             .Left          = 213
1782:             .Width         = 41
1783:             .Height        = 18
1784:             .FontName      = "Tahoma"
1785:             .FontSize      = 8
1786:             .Format        = "K"
1787:             .InputMask     = "999.99"
1788:             .SpecialEffect = 1
1789:             .Margin        = 0
1790:             .Visible       = .T.
1791:         ENDWITH
1792: 
1793:         *-- CFOP Substituicao Tributaria (lcfopsub x ccfopsub)

*-- Linhas 1802 a 1823:
1802:             .FontSize  = 7
1803:             .BackStyle = 0
1804:             .ForeColor = RGB(90, 90, 90)
1805:             .Visible   = .T.
1806:         ENDWITH
1807:         loc_oAba.AddObject("txt_4c_Text23", "TextBox")
1808:         WITH loc_oAba.txt_4c_Text23
1809:             .ControlSource = "crSigCnFN2.lcfopsub"
1810:             .Top           = 174
1811:             .Left          = 164
1812:             .Width         = 41
1813:             .Height        = 18
1814:             .FontName      = "Tahoma"
1815:             .FontSize      = 8
1816:             .Format        = "K"
1817:             .InputMask     = "999.99"
1818:             .SpecialEffect = 1
1819:             .Margin        = 0
1820:             .Visible       = .T.
1821:         ENDWITH
1822:         loc_oAba.AddObject("lbl_4c_Label27", "Label")
1823:         WITH loc_oAba.lbl_4c_Label27

*-- Linhas 1830 a 1851:
1830:             .FontSize  = 7
1831:             .BackStyle = 0
1832:             .ForeColor = RGB(90, 90, 90)
1833:             .Visible   = .T.
1834:         ENDWITH
1835:         loc_oAba.AddObject("txt_4c_Text24", "TextBox")
1836:         WITH loc_oAba.txt_4c_Text24
1837:             .ControlSource = "crSigCnFN2.ccfopsub"
1838:             .Top           = 174
1839:             .Left          = 213
1840:             .Width         = 41
1841:             .Height        = 18
1842:             .FontName      = "Tahoma"
1843:             .FontSize      = 8
1844:             .Format        = "K"
1845:             .InputMask     = "999.99"
1846:             .SpecialEffect = 1
1847:             .Margin        = 0
1848:             .Visible       = .T.
1849:         ENDWITH
1850: 
1851:         *===== Coluna direita: impressora (dentro do Shape1) =====

*-- Linhas 1862 a 1883:
1862:             .FontSize  = 7
1863:             .BackStyle = 0
1864:             .ForeColor = RGB(90, 90, 90)
1865:             .Visible   = .T.
1866:         ENDWITH
1867:         loc_oAba.AddObject("txt_4c_Text13", "TextBox")
1868:         WITH loc_oAba.txt_4c_Text13
1869:             .ControlSource = "crSigCnFNf.imppads"
1870:             .Top           = 61
1871:             .Left          = 393
1872:             .Width         = 240
1873:             .Height        = 18
1874:             .FontName      = "Tahoma"
1875:             .FontSize      = 8
1876:             .Format        = "K"
1877:             .SpecialEffect = 1
1878:             .Margin        = 0
1879:             .Visible       = .T.
1880:         ENDWITH
1881: 
1882:         *-- Fonte Padrao + Tamanho (sem ControlSource; Text14 abre dialogo fonte)
1883:         loc_oAba.AddObject("lbl_4c_Label14", "Label")

*-- Linhas 1891 a 1938:
1891:             .FontSize  = 7
1892:             .BackStyle = 0
1893:             .ForeColor = RGB(90, 90, 90)
1894:             .Visible   = .T.
1895:         ENDWITH
1896:         loc_oAba.AddObject("txt_4c_Text14", "TextBox")
1897:         WITH loc_oAba.txt_4c_Text14
1898:             .Top           = 93
1899:             .Left          = 393
1900:             .Width         = 192
1901:             .Height        = 18
1902:             .FontName      = "Tahoma"
1903:             .FontSize      = 8
1904:             .Format        = "K"
1905:             .SpecialEffect = 1
1906:             .Margin        = 0
1907:             .Visible       = .T.
1908:         ENDWITH
1909:         loc_oAba.AddObject("lbl_4c_Label15", "Label")
1910:         WITH loc_oAba.lbl_4c_Label15
1911:             .Caption   = "Tamanho"
1912:             .Top       = 81
1913:             .Left      = 591
1914:             .Width     = 41
1915:             .Height    = 13
1916:             .FontName  = "Tahoma"
1917:             .FontSize  = 7
1918:             .BackStyle = 0
1919:             .ForeColor = RGB(90, 90, 90)
1920:             .Visible   = .T.
1921:         ENDWITH
1922:         loc_oAba.AddObject("txt_4c_Text15", "TextBox")
1923:         WITH loc_oAba.txt_4c_Text15
1924:             .ControlSource = "crSigCnFNf.tamanhos"
1925:             .Top           = 93
1926:             .Left          = 592
1927:             .Width         = 41
1928:             .Height        = 18
1929:             .FontName      = "Tahoma"
1930:             .FontSize      = 8
1931:             .Format        = "K"
1932:             .InputMask     = "999"
1933:             .SpecialEffect = 1
1934:             .Margin        = 0
1935:             .Visible       = .T.
1936:         ENDWITH
1937: 
1938:         *-- Tamanho da Folha (Text11, sem ControlSource; abre dialogo)

*-- Linhas 1947 a 2664:
1947:             .FontSize  = 7
1948:             .BackStyle = 0
1949:             .ForeColor = RGB(90, 90, 90)
1950:             .Visible   = .T.
1951:         ENDWITH
1952:         loc_oAba.AddObject("txt_4c_Text11", "TextBox")
1953:         WITH loc_oAba.txt_4c_Text11
1954:             .Top           = 127
1955:             .Left          = 393
1956:             .Width         = 240
1957:             .Height        = 18
1958:             .MaxLength     = 50
1959:             .FontName      = "Tahoma"
1960:             .FontSize      = 8
1961:             .Format        = "K"
1962:             .SpecialEffect = 1
1963:             .Margin        = 0
1964:             .Visible       = .T.
1965:         ENDWITH
1966: 
1967:         *-- optTpMargem (Sem Margem / Com Margem)
1968:         loc_oAba.AddObject("obj_4c_OptTpMargem", "OptionGroup")
1969:         WITH loc_oAba.obj_4c_OptTpMargem
1970:             .ControlSource = "crSigCnFN2.ntpmargems"
1971:             .Top           = 149
1972:             .Left          = 389
1973:             .Width         = 202
1974:             .Height        = 27
1975:             .BackStyle     = 0
1976:             .BorderStyle   = 0
1977:             .Value         = 1
1978:             .Visible       = .T.
1979:             WITH .Buttons(1)
1980:                 .Caption   = "Sem Margem"
1981:                 .Left      = 5
1982:                 .Top       = 5
1983:                 .AutoSize  = .T.
1984:                 .BackStyle = 0
1985:                 .ForeColor = RGB(90, 90, 90)
1986:             ENDWITH
1987:             WITH .Buttons(2)
1988:                 .Caption   = "Com Margem"
1989:                 .Left      = 105
1990:                 .Top       = 5
1991:                 .AutoSize  = .T.
1992:                 .BackStyle = 0
1993:                 .FontName  = "Tahoma"
1994:                 .FontSize  = 8
1995:                 .ForeColor = RGB(90, 90, 90)
1996:             ENDWITH
1997:         ENDWITH
1998:     ENDPROC
1999: 
2000:     *--------------------------------------------------------------------------
2001:     PROCEDURE ConfirmarClick()
2002:         LOCAL loc_lResultado
2003:         loc_lResultado = .F.
2004:         TRY
2005:             IF THIS.this_cModoAtual != "INCLUIR" AND THIS.this_cModoAtual != "ALTERAR"
2006:                 MsgAviso("Nada a salvar no modo atual.", "FormNfl")
2007:             ELSE
2008:                 THIS.FormParaBO()
2009:                 loc_lResultado = THIS.this_oBusinessObject.Salvar()
2010:                 IF loc_lResultado
2011:                     THIS.this_oBusinessObject.SalvarSigCnFNf()
2012:                     MsgInfo("Configura" + CHR(231) + CHR(227) + "o salva com sucesso.", "FormNfl")
2013:                     THIS.AjustarBotoesPorModo("LISTA")
2014:                     THIS.AlternarPagina(1)
2015:                     THIS.CarregarLista()
2016:                 ENDIF
2017:             ENDIF
2018:         CATCH TO loc_oErro
2019:             MsgErro(loc_oErro.Message, "FormNfl.ConfirmarClick")
2020:         ENDTRY
2021:         RETURN loc_lResultado
2022:     ENDPROC
2023: 
2024:     *--------------------------------------------------------------------------
2025:     PROCEDURE CancelarClick()
2026:         TRY
2027:             THIS.AjustarBotoesPorModo("LISTA")
2028:             THIS.AlternarPagina(1)
2029:         CATCH TO loc_oErro
2030:             MsgErro(loc_oErro.Message, "FormNfl.CancelarClick")
2031:         ENDTRY
2032:     ENDPROC
2033: 
2034:     *--------------------------------------------------------------------------
2035:     PROCEDURE SeriesDadosValid()
2036:         LOCAL loc_lResultado, loc_cVal, loc_nRes
2037:         loc_lResultado = .T.
2038:         TRY
2039:             loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value)
2040:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2041:                 loc_lResultado = .T.
2042:             ENDIF
2043:             loc_nRes = SQLEXEC(gnConnHandle, ;
2044:                 "SELECT cods FROM SigCdSer WHERE cods = " + EscaparSQL(loc_cVal), ;
2045:                 "cursor_4c_ValidSer")
2046:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidSer") = 0
2047:                 THIS.AbrirLookupSeries()
2048:             ENDIF
2049:             IF USED("cursor_4c_ValidSer")
2050:                 USE IN cursor_4c_ValidSer
2051:             ENDIF
2052:         CATCH TO loc_oErro
2053:             MsgErro(loc_oErro.Message, "FormNfl.SeriesDadosValid")
2054:         ENDTRY
2055:         RETURN loc_lResultado
2056:     ENDPROC
2057: 
2058:     *--------------------------------------------------------------------------
2059:     PROCEDURE SeriesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2060:         IF par_nKeyCode = 28
2061:             THIS.AbrirLookupSeries()
2062:         ENDIF
2063:     ENDPROC
2064: 
2065:     *--------------------------------------------------------------------------
2066:     PROCEDURE SeriesDblClick()
2067:         THIS.AbrirLookupSeries()
2068:     ENDPROC
2069: 
2070:     *--------------------------------------------------------------------------
2071:     PROTECTED PROCEDURE AbrirLookupSeries()
2072:         LOCAL loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2073:         TRY
2074:             loc_oCtrl = THIS.pgf_4c_Paginas.Page2.txt_4c_Series
2075:             IF PEMSTATUS(loc_oCtrl, "Enabled", 5) AND !loc_oCtrl.Enabled
2076:                 RETURN
2077:             ENDIF
2078:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2079:             IF !EMPTY(loc_cVal)
2080:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer WHERE UPPER(cods) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY cods"
2081:             ELSE
2082:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer ORDER BY cods"
2083:             ENDIF
2084:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSer")
2085:             IF !USED("cursor_4c_BuscaSer") OR RECCOUNT("cursor_4c_BuscaSer") = 0
2086:                 IF USED("cursor_4c_BuscaSer")
2087:                     USE IN cursor_4c_BuscaSer
2088:                 ENDIF
2089:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdSer ORDER BY cods", "cursor_4c_BuscaSer")
2090:             ENDIF
2091:             IF !USED("cursor_4c_BuscaSer")
2092:                 CREATE CURSOR cursor_4c_BuscaSer (cods c(3), descs c(50))
2093:             ENDIF
2094:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2095:             IF VARTYPE(loc_oBusca) = "O"
2096:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaSer", "cods", "descs", "S" + CHR(233) + "ries")
2097:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2098:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2099:                 loc_oBusca.Mostrar()
2100:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
2101:                     SELECT cursor_4c_BuscaSer
2102:                     loc_oCtrl.Value = ALLTRIM(cods)
2103:                 ENDIF
2104:             ENDIF
2105:             IF USED("cursor_4c_BuscaSer")
2106:                 USE IN cursor_4c_BuscaSer
2107:             ENDIF
2108:         CATCH TO loc_oErro
2109:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupSeries")
2110:         ENDTRY
2111:     ENDPROC
2112: 
2113:     *--------------------------------------------------------------------------
2114:     PROCEDURE NomedestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2115:         IF par_nKeyCode = 28
2116:             THIS.AbrirLookupNomedest()
2117:         ENDIF
2118:     ENDPROC
2119: 
2120:     *--------------------------------------------------------------------------
2121:     PROCEDURE NomedestDblClick()
2122:         THIS.AbrirLookupNomedest()
2123:     ENDPROC
2124: 
2125:     *--------------------------------------------------------------------------
2126:     PROTECTED PROCEDURE AbrirLookupNomedest()
2127:         LOCAL loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2128:         TRY
2129:             loc_oCtrl = THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.txt_4c_nomedest
2130:             loc_cVal  = ALLTRIM(loc_oCtrl.Value)
2131:             IF !EMPTY(loc_cVal)
2132:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer WHERE UPPER(cods) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY cods"
2133:             ELSE
2134:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer ORDER BY cods"
2135:             ENDIF
2136:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSerCp")
2137:             IF !USED("cursor_4c_BuscaSerCp") OR RECCOUNT("cursor_4c_BuscaSerCp") = 0
2138:                 IF USED("cursor_4c_BuscaSerCp")
2139:                     USE IN cursor_4c_BuscaSerCp
2140:                 ENDIF
2141:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdSer ORDER BY cods", "cursor_4c_BuscaSerCp")
2142:             ENDIF
2143:             IF !USED("cursor_4c_BuscaSerCp")
2144:                 CREATE CURSOR cursor_4c_BuscaSerCp (cods c(3), descs c(50))
2145:             ENDIF
2146:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2147:             IF VARTYPE(loc_oBusca) = "O"
2148:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaSerCp", "cods", "descs", "S" + CHR(233) + "rie Destino")
2149:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2150:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2151:                 loc_oBusca.Mostrar()
2152:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSerCp")
2153:                     SELECT cursor_4c_BuscaSerCp
2154:                     loc_oCtrl.Value = ALLTRIM(cods)
2155:                 ENDIF
2156:             ENDIF
2157:             IF USED("cursor_4c_BuscaSerCp")
2158:                 USE IN cursor_4c_BuscaSerCp
2159:             ENDIF
2160:         CATCH TO loc_oErro
2161:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupNomedest")
2162:         ENDTRY
2163:     ENDPROC
2164: 
2165:     *--------------------------------------------------------------------------
2166:     PROCEDURE EmpDestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2167:         IF par_nKeyCode = 28
2168:             THIS.AbrirLookupEmpDest()
2169:         ENDIF
2170:     ENDPROC
2171: 
2172:     *--------------------------------------------------------------------------
2173:     PROCEDURE EmpDestDblClick()
2174:         THIS.AbrirLookupEmpDest()
2175:     ENDPROC
2176: 
2177:     *--------------------------------------------------------------------------
2178:     PROTECTED PROCEDURE AbrirLookupEmpDest()
2179:         LOCAL loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2180:         TRY
2181:             loc_oCtrl = THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.txt_4c_empDest
2182:             loc_cVal  = ALLTRIM(loc_oCtrl.Value)
2183:             IF !EMPTY(loc_cVal)
2184:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE UPPER(CEmps) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CEmps"
2185:             ELSE
2186:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps"
2187:             ENDIF
2188:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDest")
2189:             IF !USED("cursor_4c_BuscaEmpDest") OR RECCOUNT("cursor_4c_BuscaEmpDest") = 0
2190:                 IF USED("cursor_4c_BuscaEmpDest")
2191:                     USE IN cursor_4c_BuscaEmpDest
2192:                 ENDIF
2193:                 SQLEXEC(gnConnHandle, "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", "cursor_4c_BuscaEmpDest")
2194:             ENDIF
2195:             IF !USED("cursor_4c_BuscaEmpDest")
2196:                 CREATE CURSOR cursor_4c_BuscaEmpDest (CEmps c(2), Razas c(60))
2197:             ENDIF
2198:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2199:             IF VARTYPE(loc_oBusca) = "O"
2200:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpDest", "CEmps", "Razas", "Empresa Destino")
2201:                 loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
2202:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2203:                 loc_oBusca.Mostrar()
2204:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDest")
2205:                     SELECT cursor_4c_BuscaEmpDest
2206:                     loc_oCtrl.Value = ALLTRIM(CEmps)
2207:                 ENDIF
2208:             ENDIF
2209:             IF USED("cursor_4c_BuscaEmpDest")
2210:                 USE IN cursor_4c_BuscaEmpDest
2211:             ENDIF
2212:         CATCH TO loc_oErro
2213:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupEmpDest")
2214:         ENDTRY
2215:     ENDPROC
2216: 
2217:     *--------------------------------------------------------------------------
2218:     PROCEDURE EmpPadKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2219:         IF par_nKeyCode = 28
2220:             THIS.AbrirLookupEmpPad()
2221:         ENDIF
2222:     ENDPROC
2223: 
2224:     *--------------------------------------------------------------------------
2225:     PROCEDURE EmpPadDblClick()
2226:         THIS.AbrirLookupEmpPad()
2227:     ENDPROC
2228: 
2229:     *--------------------------------------------------------------------------
2230:     PROCEDURE EmpPadValid(par_nKeyCode, par_nShiftAltCtrl)
2231:         LOCAL loc_lResultado, loc_cVal, loc_nRes
2232:         loc_lResultado = .T.
2233:         TRY
2234:             loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value)
2235:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2236:                 loc_lResultado = .T.
2237:             ENDIF
2238:             loc_nRes = SQLEXEC(gnConnHandle, ;
2239:                 "SELECT CEmps FROM SigCdEmp WHERE CEmps = " + EscaparSQL(loc_cVal), ;
2240:                 "cursor_4c_ValidEmpPad")
2241:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidEmpPad") = 0
2242:                 THIS.AbrirLookupEmpPad()
2243:             ENDIF
2244:             IF USED("cursor_4c_ValidEmpPad")
2245:                 USE IN cursor_4c_ValidEmpPad
2246:             ENDIF
2247:         CATCH TO loc_oErro
2248:             MsgErro(loc_oErro.Message, "FormNfl.EmpPadValid")
2249:         ENDTRY
2250:         RETURN loc_lResultado
2251:     ENDPROC
2252: 
2253:     *--------------------------------------------------------------------------
2254:     PROTECTED PROCEDURE AbrirLookupEmpPad()
2255:         LOCAL loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2256:         TRY
2257:             loc_oCtrl = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page10.txt_4c_EmpPad
2258:             IF PEMSTATUS(loc_oCtrl, "Enabled", 5) AND !loc_oCtrl.Enabled
2259:                 RETURN
2260:             ENDIF
2261:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2262:             IF !EMPTY(loc_cVal)
2263:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE UPPER(CEmps) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CEmps"
2264:             ELSE
2265:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps"
2266:             ENDIF
2267:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpPad")
2268:             IF !USED("cursor_4c_BuscaEmpPad") OR RECCOUNT("cursor_4c_BuscaEmpPad") = 0
2269:                 IF USED("cursor_4c_BuscaEmpPad")
2270:                     USE IN cursor_4c_BuscaEmpPad
2271:                 ENDIF
2272:                 SQLEXEC(gnConnHandle, "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", "cursor_4c_BuscaEmpPad")
2273:             ENDIF
2274:             IF !USED("cursor_4c_BuscaEmpPad")
2275:                 CREATE CURSOR cursor_4c_BuscaEmpPad (CEmps c(2), Razas c(60))
2276:             ENDIF
2277:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2278:             IF VARTYPE(loc_oBusca) = "O"
2279:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpPad", "CEmps", "Razas", "Empresa Padr" + CHR(227) + "o")
2280:                 loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
2281:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2282:                 loc_oBusca.Mostrar()
2283:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpPad")
2284:                     SELECT cursor_4c_BuscaEmpPad
2285:                     loc_oCtrl.Value = ALLTRIM(CEmps)
2286:                 ENDIF
2287:             ENDIF
2288:             IF USED("cursor_4c_BuscaEmpPad")
2289:                 USE IN cursor_4c_BuscaEmpPad
2290:             ENDIF
2291:         CATCH TO loc_oErro
2292:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupEmpPad")
2293:         ENDTRY
2294:     ENDPROC
2295: 
2296:     *--------------------------------------------------------------------------
2297:     PROCEDURE UnPesosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2298:         IF par_nKeyCode = 28
2299:             THIS.AbrirLookupUnPesos()
2300:         ENDIF
2301:     ENDPROC
2302: 
2303:     *--------------------------------------------------------------------------
2304:     PROCEDURE UnPesosDblClick()
2305:         THIS.AbrirLookupUnPesos()
2306:     ENDPROC
2307: 
2308:     *--------------------------------------------------------------------------
2309:     PROCEDURE UnPesosValid(par_nKeyCode, par_nShiftAltCtrl)
2310:         LOCAL loc_lResultado, loc_cVal, loc_nRes
2311:         loc_lResultado = .T.
2312:         TRY
2313:             loc_cVal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page6.txt_4c_UnPesos.Value)
2314:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2315:                 loc_lResultado = .T.
2316:             ENDIF
2317:             loc_nRes = SQLEXEC(gnConnHandle, ;
2318:                 "SELECT CUnis FROM SigCdUni WHERE CUnis = " + EscaparSQL(loc_cVal), ;
2319:                 "cursor_4c_ValidUni")
2320:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidUni") = 0
2321:                 THIS.AbrirLookupUnPesos()
2322:             ENDIF
2323:             IF USED("cursor_4c_ValidUni")
2324:                 USE IN cursor_4c_ValidUni
2325:             ENDIF
2326:         CATCH TO loc_oErro
2327:             MsgErro(loc_oErro.Message, "FormNfl.UnPesosValid")
2328:         ENDTRY
2329:         RETURN loc_lResultado
2330:     ENDPROC
2331: 
2332:     *--------------------------------------------------------------------------
2333:     PROTECTED PROCEDURE AbrirLookupUnPesos()
2334:         LOCAL loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2335:         TRY
2336:             loc_oCtrl = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page6.txt_4c_UnPesos
2337:             IF PEMSTATUS(loc_oCtrl, "Enabled", 5) AND !loc_oCtrl.Enabled
2338:                 RETURN
2339:             ENDIF
2340:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2341:             IF !EMPTY(loc_cVal)
2342:                 loc_cSQL = "SELECT CUnis, DUnis FROM SigCdUni WHERE UPPER(CUnis) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CUnis"
2343:             ELSE
2344:                 loc_cSQL = "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis"
2345:             ENDIF
2346:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUni")
2347:             IF !USED("cursor_4c_BuscaUni") OR RECCOUNT("cursor_4c_BuscaUni") = 0
2348:                 IF USED("cursor_4c_BuscaUni")
2349:                     USE IN cursor_4c_BuscaUni
2350:                 ENDIF
2351:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_BuscaUni")
2352:             ENDIF
2353:             IF !USED("cursor_4c_BuscaUni")
2354:                 CREATE CURSOR cursor_4c_BuscaUni (CUnis c(6), DUnis c(30))
2355:             ENDIF
2356:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2357:             IF VARTYPE(loc_oBusca) = "O"
2358:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaUni", "CUnis", "DUnis", "Unidades de Medida")
2359:                 loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
2360:                 loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
2361:                 loc_oBusca.Mostrar()
2362:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
2363:                     SELECT cursor_4c_BuscaUni
2364:                     loc_oCtrl.Value = ALLTRIM(CUnis)
2365:                 ENDIF
2366:             ENDIF
2367:             IF USED("cursor_4c_BuscaUni")
2368:                 USE IN cursor_4c_BuscaUni
2369:             ENDIF
2370:         CATCH TO loc_oErro
2371:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupUnPesos")
2372:         ENDTRY
2373:     ENDPROC
2374: 
2375:     *--------------------------------------------------------------------------
2376:     PROTECTED PROCEDURE AbrirLookupClsFis(par_cNomeCampo)
2377:         LOCAL loc_oRdp, loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2378:         TRY
2379:             loc_oRdp  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
2380:             loc_oCtrl = THIS.ObterControle(loc_oRdp, par_cNomeCampo)
2381:             IF PEMSTATUS(loc_oCtrl, "Enabled", 5) AND !loc_oCtrl.Enabled
2382:                 RETURN
2383:             ENDIF
2384:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2385:             IF !EMPTY(loc_cVal)
2386:                 loc_cSQL = "SELECT codigos, descricaos FROM SigCdClf WHERE UPPER(codigos) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY codigos"
2387:             ELSE
2388:                 loc_cSQL = "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos"
2389:             ENDIF
2390:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaClf")
2391:             IF !USED("cursor_4c_BuscaClf") OR RECCOUNT("cursor_4c_BuscaClf") = 0
2392:                 IF USED("cursor_4c_BuscaClf")
2393:                     USE IN cursor_4c_BuscaClf
2394:                 ENDIF
2395:                 SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", "cursor_4c_BuscaClf")
2396:             ENDIF
2397:             IF !USED("cursor_4c_BuscaClf")
2398:                 CREATE CURSOR cursor_4c_BuscaClf (codigos c(10), descricaos c(60))
2399:             ENDIF
2400:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2401:             IF VARTYPE(loc_oBusca) = "O"
2402:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaClf", "codigos", "descricaos", "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
2403:                 loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
2404:                 loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2405:                 loc_oBusca.Mostrar()
2406:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
2407:                     SELECT cursor_4c_BuscaClf
2408:                     loc_oCtrl.Value = ALLTRIM(codigos)
2409:                 ENDIF
2410:             ENDIF
2411:             IF USED("cursor_4c_BuscaClf")
2412:                 USE IN cursor_4c_BuscaClf
2413:             ENDIF
2414:         CATCH TO loc_oErro
2415:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupClsFis")
2416:         ENDTRY
2417:     ENDPROC
2418: 
2419:     *--------------------------------------------------------------------------
2420:     PROTECTED PROCEDURE ValidarClsFis(par_cNomeCampo)
2421:         LOCAL loc_lResultado, loc_oRdp, loc_cVal, loc_nRes
2422:         loc_lResultado = .T.
2423:         TRY
2424:             loc_oRdp = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
2425:             loc_cVal = ALLTRIM(loc_oRdp.Value)
2426:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2427:                 loc_lResultado = .T.
2428:             ENDIF
2429:             loc_nRes = SQLEXEC(gnConnHandle, ;
2430:                 "SELECT codigos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cVal), ;
2431:                 "cursor_4c_ValidClf")
2432:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidClf") = 0
2433:                 THIS.AbrirLookupClsFis(par_cNomeCampo)
2434:             ENDIF
2435:             IF USED("cursor_4c_ValidClf")
2436:                 USE IN cursor_4c_ValidClf
2437:             ENDIF
2438:         CATCH TO loc_oErro
2439:             MsgErro(loc_oErro.Message, "FormNfl.ValidarClsFis")
2440:         ENDTRY
2441:         RETURN loc_lResultado
2442:     ENDPROC
2443: 
2444:     *-- CodImp bloco 1 (campos 1-7)
2445:     PROCEDURE CodImp1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2446:         IF par_nKeyCode = 28
2447:             THIS.AbrirLookupClsFis("txt_4c_CodImp1")
2448:         ENDIF
2449:     ENDPROC
2450:     PROCEDURE CodImp1DblClick()
2451:         THIS.AbrirLookupClsFis("txt_4c_CodImp1")
2452:     ENDPROC
2453:     PROCEDURE CodImp1Valid()
2454:         RETURN THIS.ValidarClsFis("txt_4c_CodImp1")
2455:     ENDPROC
2456: 
2457:     PROCEDURE CodImp2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2458:         IF par_nKeyCode = 28
2459:             THIS.AbrirLookupClsFis("txt_4c_CodImp2")
2460:         ENDIF
2461:     ENDPROC
2462:     PROCEDURE CodImp2DblClick()
2463:         THIS.AbrirLookupClsFis("txt_4c_CodImp2")
2464:     ENDPROC
2465:     PROCEDURE CodImp2Valid()
2466:         RETURN THIS.ValidarClsFis("txt_4c_CodImp2")
2467:     ENDPROC
2468: 
2469:     PROCEDURE CodImp3KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2470:         IF par_nKeyCode = 28
2471:             THIS.AbrirLookupClsFis("txt_4c_CodImp3")
2472:         ENDIF
2473:     ENDPROC
2474:     PROCEDURE CodImp3DblClick()
2475:         THIS.AbrirLookupClsFis("txt_4c_CodImp3")
2476:     ENDPROC
2477:     PROCEDURE CodImp3Valid()
2478:         RETURN THIS.ValidarClsFis("txt_4c_CodImp3")
2479:     ENDPROC
2480: 
2481:     PROCEDURE CodImp4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2482:         IF par_nKeyCode = 28
2483:             THIS.AbrirLookupClsFis("txt_4c_CodImp4")
2484:         ENDIF
2485:     ENDPROC
2486:     PROCEDURE CodImp4DblClick()
2487:         THIS.AbrirLookupClsFis("txt_4c_CodImp4")
2488:     ENDPROC
2489:     PROCEDURE CodImp4Valid()
2490:         RETURN THIS.ValidarClsFis("txt_4c_CodImp4")
2491:     ENDPROC
2492: 
2493:     PROCEDURE CodImp5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2494:         IF par_nKeyCode = 28
2495:             THIS.AbrirLookupClsFis("txt_4c_CodImp5")
2496:         ENDIF
2497:     ENDPROC
2498:     PROCEDURE CodImp5DblClick()
2499:         THIS.AbrirLookupClsFis("txt_4c_CodImp5")
2500:     ENDPROC
2501:     PROCEDURE CodImp5Valid()
2502:         RETURN THIS.ValidarClsFis("txt_4c_CodImp5")
2503:     ENDPROC
2504: 
2505:     PROCEDURE CodImp6KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2506:         IF par_nKeyCode = 28
2507:             THIS.AbrirLookupClsFis("txt_4c_CodImp6")
2508:         ENDIF
2509:     ENDPROC
2510:     PROCEDURE CodImp6DblClick()
2511:         THIS.AbrirLookupClsFis("txt_4c_CodImp6")
2512:     ENDPROC
2513:     PROCEDURE CodImp6Valid()
2514:         RETURN THIS.ValidarClsFis("txt_4c_CodImp6")
2515:     ENDPROC
2516: 
2517:     PROCEDURE CodImp7KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2518:         IF par_nKeyCode = 28
2519:             THIS.AbrirLookupClsFis("txt_4c_CodImp7")
2520:         ENDIF
2521:     ENDPROC
2522:     PROCEDURE CodImp7DblClick()
2523:         THIS.AbrirLookupClsFis("txt_4c_CodImp7")
2524:     ENDPROC
2525:     PROCEDURE CodImp7Valid()
2526:         RETURN THIS.ValidarClsFis("txt_4c_CodImp7")
2527:     ENDPROC
2528: 
2529:     *-- CodImpB bloco 2 (campos 8-12)
2530:     PROCEDURE CodImpB8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2531:         IF par_nKeyCode = 28
2532:             THIS.AbrirLookupClsFis("txt_4c_CodImpB8")
2533:         ENDIF
2534:     ENDPROC
2535:     PROCEDURE CodImpB8DblClick()
2536:         THIS.AbrirLookupClsFis("txt_4c_CodImpB8")
2537:     ENDPROC
2538:     PROCEDURE CodImpB8Valid()
2539:         RETURN THIS.ValidarClsFis("txt_4c_CodImpB8")
2540:     ENDPROC
2541: 
2542:     PROCEDURE CodImpB9KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2543:         IF par_nKeyCode = 28
2544:             THIS.AbrirLookupClsFis("txt_4c_CodImpB9")
2545:         ENDIF
2546:     ENDPROC
2547:     PROCEDURE CodImpB9DblClick()
2548:         THIS.AbrirLookupClsFis("txt_4c_CodImpB9")
2549:     ENDPROC
2550:     PROCEDURE CodImpB9Valid()
2551:         RETURN THIS.ValidarClsFis("txt_4c_CodImpB9")
2552:     ENDPROC
2553: 
2554:     PROCEDURE CodImpB10KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2555:         IF par_nKeyCode = 28
2556:             THIS.AbrirLookupClsFis("txt_4c_CodImpB10")
2557:         ENDIF
2558:     ENDPROC
2559:     PROCEDURE CodImpB10DblClick()
2560:         THIS.AbrirLookupClsFis("txt_4c_CodImpB10")
2561:     ENDPROC
2562:     PROCEDURE CodImpB10Valid()
2563:         RETURN THIS.ValidarClsFis("txt_4c_CodImpB10")
2564:     ENDPROC
2565: 
2566:     PROCEDURE CodImpB11KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2567:         IF par_nKeyCode = 28
2568:             THIS.AbrirLookupClsFis("txt_4c_CodImpB11")
2569:         ENDIF
2570:     ENDPROC
2571:     PROCEDURE CodImpB11DblClick()
2572:         THIS.AbrirLookupClsFis("txt_4c_CodImpB11")
2573:     ENDPROC
2574:     PROCEDURE CodImpB11Valid()
2575:         RETURN THIS.ValidarClsFis("txt_4c_CodImpB11")
2576:     ENDPROC
2577: 
2578:     PROCEDURE CodImpB12KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2579:         IF par_nKeyCode = 28
2580:             THIS.AbrirLookupClsFis("txt_4c_CodImpB12")
2581:         ENDIF
2582:     ENDPROC
2583:     PROCEDURE CodImpB12DblClick()
2584:         THIS.AbrirLookupClsFis("txt_4c_CodImpB12")
2585:     ENDPROC
2586:     PROCEDURE CodImpB12Valid()
2587:         RETURN THIS.ValidarClsFis("txt_4c_CodImpB12")
2588:     ENDPROC
2589: 
2590:     *--------------------------------------------------------------------------
2591:     PROCEDURE ClsFisTpClick()
2592:         LOCAL loc_oAba, loc_nI, loc_cN, loc_lLetras, loc_oLbl
2593:         TRY
2594:             loc_oAba    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
2595:             loc_lLetras = (loc_oAba.obj_4c_ClsFisTp.Value = 1)
2596:             FOR loc_nI = 1 TO 7
2597:                 loc_cN  = ALLTRIM(STR(loc_nI))
2598:                 loc_oLbl = THIS.ObterControle(loc_oAba, "lbl_4c_Cod" + loc_cN)
2599:                 IF VARTYPE(loc_oLbl) = "O"
2600:                     IF loc_lLetras
2601:                         loc_oLbl.Caption = CHR(64 + loc_nI)
2602:                     ELSE
2603:                         loc_oLbl.Caption = "C" + CHR(243) + "digo " + loc_cN
2604:                     ENDIF
2605:                 ENDIF
2606:             ENDFOR
2607:             FOR loc_nI = 8 TO 12
2608:                 loc_cN  = ALLTRIM(STR(loc_nI))
2609:                 loc_oLbl = THIS.ObterControle(loc_oAba, "lbl_4c_CodB" + loc_cN)
2610:                 IF VARTYPE(loc_oLbl) = "O"
2611:                     IF loc_lLetras
2612:                         loc_oLbl.Caption = CHR(64 + loc_nI)
2613:                     ELSE
2614:                         loc_oLbl.Caption = "C" + CHR(243) + "digo " + loc_cN
2615:                     ENDIF
2616:                 ENDIF
2617:             ENDFOR
2618:         CATCH TO loc_oErro
2619:             MsgErro(loc_oErro.Message, "FormNfl.ClsFisTpClick")
2620:         ENDTRY
2621:     ENDPROC
2622: 
2623:     *--------------------------------------------------------------------------
2624:     PROTECTED PROCEDURE FormParaBO()
2625:         LOCAL loc_oPag2, loc_oBO
2626:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2627:         loc_oBO   = THIS.this_oBusinessObject
2628: 
2629:         *-- Controles standalone (sem ControlSource)
2630:         IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
2631:             loc_oBO.this_cSeries = ALLTRIM(loc_oPag2.txt_4c_Series.Value)
2632:         ENDIF
2633:         IF VARTYPE(loc_oPag2.pgf_4c_Abas) = "O"
2634:             IF PEMSTATUS(loc_oPag2.pgf_4c_Abas.Page10, "txt_4c_EmpPad", 5)
2635:                 loc_oBO.this_cEmps = ALLTRIM(loc_oPag2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value)
2636:             ENDIF
2637:         ENDIF
2638: 
2639:         *-- Campos de crSigCnFN2 (Empresa, Destinatario, Impostos adicionais, Classes extras)
2640:         IF USED("crSigCnFN2") AND RECCOUNT("crSigCnFN2") > 0
2641:             SELECT crSigCnFN2
2642:             loc_oBO.this_cCtitent      = ALLTRIM(ctitent)
2643:             loc_oBO.this_nLendent      = lendent
2644:             loc_oBO.this_nCendent      = cendent
2645:             loc_oBO.this_nLbaient      = lbaient
2646:             loc_oBO.this_nCbaient      = cbaient
2647:             loc_oBO.this_nLmunent      = lmunent
2648:             loc_oBO.this_nCmunent      = cmunent
2649:             loc_oBO.this_nLestent      = lestent
2650:             loc_oBO.this_nCestent      = cestent
2651:             loc_oBO.this_nLcepent      = lcepent
2652:             loc_oBO.this_nCcepent      = ccepent
2653:             loc_oBO.this_nLfoneent     = lfoneent
2654:             loc_oBO.this_nCfoneent     = cfoneent
2655:             loc_oBO.this_nLiniped      = liniped
2656:             loc_oBO.this_nCiniped      = ciniped
2657:             loc_oBO.this_nLendtite     = lendtite
2658:             loc_oBO.this_nCendtite     = cendtite
2659:             loc_oBO.this_nLempnome     = lempnome
2660:             loc_oBO.this_nCempnome     = cempnome
2661:             loc_oBO.this_nLempcgc      = lempcgc
2662:             loc_oBO.this_nCempcgc      = cempcgc
2663:             loc_oBO.this_nLempiest     = lempiest
2664:             loc_oBO.this_nCempiest     = cempiest

*-- Linhas 2768 a 2847:
2768:     ENDPROC
2769: 
2770:     *--------------------------------------------------------------------------
2771:     PROTECTED PROCEDURE BOParaForm()
2772:         LOCAL loc_lResultado, loc_oPag2, loc_oBO, loc_cChave
2773:         loc_lResultado = .F.
2774:         TRY
2775:             loc_oPag2  = THIS.pgf_4c_Paginas.Page2
2776:             loc_oBO    = THIS.this_oBusinessObject
2777:             loc_cChave = ALLTRIM(loc_oBO.this_cCidchaves)
2778: 
2779:             IF !EMPTY(loc_cChave)
2780:                 IF SQLEXEC(gnConnHandle, ;
2781:                     "SELECT * FROM SigCnFNf WHERE cidchaves = " + EscaparSQL(loc_cChave), ;
2782:                     "crSigCnFNf") <= 0
2783:                     MsgErro("Erro ao recarregar SigCnFNf.", "FormNfl.BOParaForm")
2784:                 ENDIF
2785:                 IF SQLEXEC(gnConnHandle, ;
2786:                     "SELECT * FROM SigCnFN2 WHERE cidchaves = " + EscaparSQL(loc_cChave), ;
2787:                     "crSigCnFN2") <= 0
2788:                     MsgErro("Erro ao recarregar SigCnFN2.", "FormNfl.BOParaForm")
2789:                 ENDIF
2790:             ENDIF
2791: 
2792:             IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
2793:                 loc_oPag2.txt_4c_Series.Value = ALLTRIM(loc_oBO.this_cSeries)
2794:             ENDIF
2795:             IF VARTYPE(loc_oPag2.pgf_4c_Abas) = "O"
2796:                 IF PEMSTATUS(loc_oPag2.pgf_4c_Abas.Page10, "txt_4c_EmpPad", 5)
2797:                     loc_oPag2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value = ALLTRIM(loc_oBO.this_cEmps)
2798:                 ENDIF
2799:             ENDIF
2800:             loc_lResultado = .T.
2801:         CATCH TO loc_oErro
2802:             MsgErro(loc_oErro.Message, "FormNfl.BOParaForm")
2803:         ENDTRY
2804:         RETURN loc_lResultado
2805:     ENDPROC
2806: 
2807:     PROTECTED PROCEDURE ConfigurarEmpresaTab()
2808:         LOCAL loc_oAba
2809:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2810: 
2811:         *-- Secao: Dados/Endereco - Empresa (top=7, shape+header)
2812:         loc_oAba.AddObject("shp_4c_Shape3", "Shape")
2813:         WITH loc_oAba.shp_4c_Shape3
2814:             .Top           = 7
2815:             .Left          = 42
2816:             .Height        = 3
2817:             .Width         = 414
2818:             .BackStyle     = 1
2819:             .SpecialEffect = 1
2820:             .BackColor     = RGB(136, 189, 188)
2821:             .Visible       = .T.
2822:         ENDWITH
2823: 
2824:         loc_oAba.AddObject("lbl_4c_Label57", "Label")
2825:         WITH loc_oAba.lbl_4c_Label57
2826:             .Caption   = "Dados / Endere" + CHR(231) + "o - Empresa"
2827:             .Top       = 11
2828:             .Left      = 50
2829:             .FontBold  = .T.
2830:             .FontName  = "Tahoma"
2831:             .FontSize  = 8
2832:             .BackStyle = 0
2833:             .ForeColor = RGB(90, 90, 90)
2834:             .AutoSize  = .T.
2835:             .Visible   = .T.
2836:         ENDWITH
2837: 
2838:         *-- Empresa - Nome/Razao Social (top=26)
2839:         loc_oAba.AddObject("lbl_4c_Label41", "Label")
2840:         WITH loc_oAba.lbl_4c_Label41
2841:             .Caption   = "Nome / Raz" + CHR(227) + "o Social"
2842:             .Top       = 26
2843:             .Left      = 42
2844:             .FontName  = "Tahoma"
2845:             .FontSize  = 7
2846:             .BackStyle = 0
2847:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 4502 a 4545:
4502:     ENDPROC
4503: 
4504:     *--------------------------------------------------------------------------
4505:     PROTECTED PROCEDURE ConfigurarDesdobramentoTab()
4506:         LOCAL loc_oAba
4507:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
4508: 
4509:         *-- Cabecalho de colunas (top=25)
4510:         loc_oAba.AddObject("lbl_4c_LblNumero", "Label")
4511:         WITH loc_oAba.lbl_4c_LblNumero
4512:             .Caption   = "N" + CHR(250) + "mero"
4513:             .Top       = 25
4514:             .Left      = 87
4515:             .FontName  = "Tahoma"
4516:             .FontSize  = 7
4517:             .BackStyle = 0
4518:             .ForeColor = RGB(90, 90, 90)
4519:             .AutoSize  = .T.
4520:             .Visible   = .T.
4521:         ENDWITH
4522: 
4523:         loc_oAba.AddObject("lbl_4c_LblValor", "Label")
4524:         WITH loc_oAba.lbl_4c_LblValor
4525:             .Caption   = "Valor"
4526:             .Top       = 25
4527:             .Left      = 200
4528:             .FontName  = "Tahoma"
4529:             .FontSize  = 7
4530:             .BackStyle = 0
4531:             .ForeColor = RGB(90, 90, 90)
4532:             .AutoSize  = .T.
4533:             .Visible   = .T.
4534:         ENDWITH
4535: 
4536:         loc_oAba.AddObject("lbl_4c_LblVecto", "Label")
4537:         WITH loc_oAba.lbl_4c_LblVecto
4538:             .Caption   = "Vencimento"
4539:             .Top       = 25
4540:             .Left      = 294
4541:             .FontName  = "Tahoma"
4542:             .FontSize  = 7
4543:             .BackStyle = 0
4544:             .ForeColor = RGB(90, 90, 90)
4545:             .AutoSize  = .T.

*-- Linhas 6174 a 6217:
6174:     ENDPROC
6175: 
6176:     *--------------------------------------------------------------------------
6177:     PROTECTED PROCEDURE ConfigurarProdutosTab()
6178:         LOCAL loc_oAba
6179:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4
6180: 
6181:         *-- Linha inicial dos produtos (top=28)
6182:         loc_oAba.AddObject("lbl_4c_LblLinIni", "Label")
6183:         WITH loc_oAba.lbl_4c_LblLinIni
6184:             .Caption   = "Linha Inicial dos Produtos"
6185:             .Top       = 28
6186:             .Left      = 18
6187:             .FontName  = "Tahoma"
6188:             .FontSize  = 7
6189:             .BackStyle = 0
6190:             .ForeColor = RGB(90, 90, 90)
6191:             .AutoSize  = .T.
6192:             .Visible   = .T.
6193:         ENDWITH
6194: 
6195:         loc_oAba.AddObject("txt_4c_LinIni", "TextBox")
6196:         WITH loc_oAba.txt_4c_LinIni
6197:             .ControlSource = "crSigCnFNf.linprod"
6198:             .Top           = 24
6199:             .Left          = 153
6200:             .Width         = 41
6201:             .Height        = 18
6202:             .FontName      = "Tahoma"
6203:             .FontSize      = 8
6204:             .SpecialEffect = 1
6205:             .Format        = "K"
6206:             .InputMask     = "999.99"
6207:             .Visible       = .T.
6208:         ENDWITH
6209: 
6210:         *-- Codigo (top=50)
6211:         loc_oAba.AddObject("lbl_4c_LblCodigo", "Label")
6212:         WITH loc_oAba.lbl_4c_LblCodigo
6213:             .Caption   = "C" + CHR(243) + "digo"
6214:             .Top       = 50
6215:             .Left      = 34
6216:             .FontName  = "Tahoma"
6217:             .FontSize  = 7

*-- Linhas 7149 a 7192:
7149:     ENDPROC
7150: 
7151:     *--------------------------------------------------------------------------
7152:     PROTECTED PROCEDURE ConfigurarImpostosTab()
7153:         LOCAL loc_oAba
7154:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page5
7155: 
7156:         *-- Base de Calculo ICMS (top=19)
7157:         loc_oAba.AddObject("lbl_4c_LblBcICMS", "Label")
7158:         WITH loc_oAba.lbl_4c_LblBcICMS
7159:             .Caption   = "Base de C" + CHR(225) + "lculo ICMS"
7160:             .Top       = 19
7161:             .Left      = 28
7162:             .FontName  = "Tahoma"
7163:             .FontSize  = 7
7164:             .BackStyle = 0
7165:             .ForeColor = RGB(90, 90, 90)
7166:             .AutoSize  = .T.
7167:             .Visible   = .T.
7168:         ENDWITH
7169: 
7170:         loc_oAba.AddObject("txt_4c_BcICMSL", "TextBox")
7171:         WITH loc_oAba.txt_4c_BcICMSL
7172:             .ControlSource = "crSigCnFNf.lbicm"
7173:             .Top = 31
7174:             .Left = 39
7175:             .Width = 41
7176:             .Height = 18
7177:             .FontName = "Tahoma"
7178:             .FontSize = 8
7179:             .SpecialEffect = 1
7180:             .Format = "K"
7181:             .InputMask = "999.99"
7182:             .Visible = .T.
7183:         ENDWITH
7184: 
7185:         loc_oAba.AddObject("lbl_4c_BcICMSX", "Label")
7186:         WITH loc_oAba.lbl_4c_BcICMSX
7187:             .Caption = "x"
7188:             .Top = 33
7189:             .Left = 82
7190:             .FontName = "Tahoma"
7191:             .FontSize = 7
7192:             .BackStyle = 0

*-- Linhas 7890 a 7933:
7890:     ENDPROC
7891: 
7892:     *--------------------------------------------------------------------------
7893:     PROTECTED PROCEDURE ConfigurarTransporteTab()
7894:         LOCAL loc_oAba
7895:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page6
7896: 
7897:         *-- Shape Transportador (top=7)
7898:         loc_oAba.AddObject("shp_4c_Transp", "Shape")
7899:         WITH loc_oAba.shp_4c_Transp
7900:             .Top = 7
7901:             .Left = 12
7902:             .Width = 315
7903:             .Height = 119
7904:             .Visible = .T.
7905:         ENDWITH
7906: 
7907:         loc_oAba.AddObject("lbl_4c_LblTransp", "Label")
7908:         WITH loc_oAba.lbl_4c_LblTransp
7909:             .Caption = " Transportador "
7910:             .Top = 10
7911:             .Left = 19
7912:             .FontName = "Tahoma"
7913:             .FontSize = 7
7914:             .BackStyle = 0
7915:             .ForeColor = RGB(90,90,90)
7916:             .AutoSize = .T.
7917:             .Visible = .T.
7918:         ENDWITH
7919: 
7920:         *-- Nome/Razao Social transportador (top=24)
7921:         loc_oAba.AddObject("lbl_4c_LblTrNome", "Label")
7922:         WITH loc_oAba.lbl_4c_LblTrNome
7923:             .Caption = "Nome / Raz" + CHR(227) + "o Social"
7924:             .Top = 24
7925:             .Left = 17
7926:             .FontName = "Tahoma"
7927:             .FontSize = 7
7928:             .BackStyle = 0
7929:             .ForeColor = RGB(90,90,90)
7930:             .AutoSize = .T.
7931:             .Visible = .T.
7932:         ENDWITH
7933: 

*-- Linhas 8826 a 8888:
8826:     ENDPROC
8827: 
8828:     *--------------------------------------------------------------------------
8829:     PROTECTED PROCEDURE ConfigurarRodapeTab()
8830:         LOCAL loc_oAba
8831:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
8832: 
8833:         *-- Classificacao Fiscal header (top=21)
8834:         loc_oAba.AddObject("lbl_4c_LblClsFis", "Label")
8835:         WITH loc_oAba.lbl_4c_LblClsFis
8836:             .Caption   = "Class. Fiscal : "
8837:             .Top       = 21
8838:             .Left      = 38
8839:             .FontName  = "Tahoma"
8840:             .FontSize  = 7
8841:             .BackStyle = 0
8842:             .ForeColor = RGB(90, 90, 90)
8843:             .AutoSize  = .T.
8844:             .Visible   = .T.
8845:         ENDWITH
8846: 
8847:         *-- OptionGroup para classificacao fiscal (top=22)
8848:         loc_oAba.AddObject("obj_4c_ClsFisTp", "OptionGroup")
8849:         WITH loc_oAba.obj_4c_ClsFisTp
8850:             .Top         = 22
8851:             .Left        = 115
8852:             .Width       = 149
8853:             .Height      = 19
8854:             .BackStyle   = 0
8855:             .BorderStyle = 0
8856:             .Value       = 1
8857:             .Visible     = .T.
8858:             WITH .Buttons(1)
8859:                 .Caption = "Impressa"
8860:                 .Left    = 2
8861:                 .Top = 2
8862:                 .AutoSize = .T.
8863:                 .BackStyle = 0
8864:                 .ForeColor = RGB(90,90,90)
8865:             ENDWITH
8866:             WITH .Buttons(2)
8867:                 .Caption = "Calculada"
8868:                 .Left    = 60
8869:                 .Top = 2
8870:                 .AutoSize = .T.
8871:                 .BackStyle = 0
8872:                 .FontName = "Tahoma"
8873:                 .FontSize = 7
8874:                 .ForeColor = RGB(90,90,90)
8875:             ENDWITH
8876:         ENDWITH
8877: 
8878:         *-- Shape bloco Codigos 1-7 (top=39, left=17)
8879:         loc_oAba.AddObject("shp_4c_CodBl1", "Shape")
8880:         WITH loc_oAba.shp_4c_CodBl1
8881:             .Top = 39
8882:             .Left = 17
8883:             .Width = 345
8884:             .Height = 155
8885:             .Visible = .T.
8886:         ENDWITH
8887: 
8888:         *-- Cabecalhos do bloco 1-7

*-- Linhas 9844 a 9887:
9844:     ENDPROC
9845: 
9846:     *--------------------------------------------------------------------------
9847:     PROTECTED PROCEDURE ConfigurarFaturaTab()
9848:         LOCAL loc_oAba
9849:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page8
9850: 
9851:         *-- Data de Emissao (top=31)
9852:         loc_oAba.AddObject("lbl_4c_LblFatDtEmi", "Label")
9853:         WITH loc_oAba.lbl_4c_LblFatDtEmi
9854:             .Caption   = "Data de Emiss" + CHR(227) + "o"
9855:             .Top       = 31
9856:             .Left      = 99
9857:             .FontName  = "Tahoma"
9858:             .FontSize  = 7
9859:             .BackStyle = 0
9860:             .ForeColor = RGB(90, 90, 90)
9861:             .AutoSize  = .T.
9862:             .Visible   = .T.
9863:         ENDWITH
9864: 
9865:         loc_oAba.AddObject("txt_4c_FatDtEmiL", "TextBox")
9866:         WITH loc_oAba.txt_4c_FatDtEmiL
9867:             .ControlSource = "crSigCnFNf.ldtemi"
9868:             .Top = 43
9869:             .Left = 99
9870:             .Width = 41
9871:             .Height = 18
9872:             .FontName = "Tahoma"
9873:             .FontSize = 8
9874:             .SpecialEffect = 1
9875:             .Format = "K"
9876:             .InputMask = "999.99"
9877:             .Visible = .T.
9878:         ENDWITH
9879: 
9880:         loc_oAba.AddObject("lbl_4c_FatDtEmiX", "Label")
9881:         WITH loc_oAba.lbl_4c_FatDtEmiX
9882:             .Caption = "x"
9883:             .Top = 45
9884:             .Left = 142
9885:             .FontName = "Tahoma"
9886:             .FontSize = 7
9887:             .BackStyle = 0

*-- Linhas 10249 a 10292:
10249:     ENDPROC
10250: 
10251:     *--------------------------------------------------------------------------
10252:     PROTECTED PROCEDURE ConfigurarServicosTab()
10253:         LOCAL loc_oAba
10254:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page9
10255: 
10256:         *-- Descricao Servicos (top=30)
10257:         loc_oAba.AddObject("lbl_4c_LblSrvDesc", "Label")
10258:         WITH loc_oAba.lbl_4c_LblSrvDesc
10259:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Servi" + CHR(231) + "os"
10260:             .Top       = 30
10261:             .Left      = 105
10262:             .FontName  = "Tahoma"
10263:             .FontSize  = 7
10264:             .BackStyle = 0
10265:             .ForeColor = RGB(90, 90, 90)
10266:             .AutoSize  = .T.
10267:             .Visible   = .T.
10268:         ENDWITH
10269: 
10270:         loc_oAba.AddObject("txt_4c_SrvDescL", "TextBox")
10271:         WITH loc_oAba.txt_4c_SrvDescL
10272:             .ControlSource = "crSigCnFNf.ldescser"
10273:             .Top = 43
10274:             .Left = 107
10275:             .Width = 41
10276:             .Height = 18
10277:             .FontName = "Tahoma"
10278:             .FontSize = 8
10279:             .SpecialEffect = 1
10280:             .Format = "K"
10281:             .InputMask = "999.99"
10282:             .Visible = .T.
10283:         ENDWITH
10284: 
10285:         loc_oAba.AddObject("lbl_4c_SrvDescX", "Label")
10286:         WITH loc_oAba.lbl_4c_SrvDescX
10287:             .Caption = "x"
10288:             .Top = 45
10289:             .Left = 150
10290:             .FontName = "Tahoma"
10291:             .FontSize = 7
10292:             .BackStyle = 0

*-- Linhas 10484 a 10527:
10484:     ENDPROC
10485: 
10486:     *--------------------------------------------------------------------------
10487:     PROTECTED PROCEDURE ConfigurarOutrosTab()
10488:         LOCAL loc_oAba
10489:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page10
10490: 
10491:         *-- Shape (top=37, left=399 -- Dados da Operacao)
10492:         loc_oAba.AddObject("shp_4c_OutShape", "Shape")
10493:         WITH loc_oAba.shp_4c_OutShape
10494:             .Top = 37
10495:             .Left = 399
10496:             .Width = 226
10497:             .Height = 119
10498:             .Visible = .T.
10499:         ENDWITH
10500: 
10501:         loc_oAba.AddObject("lbl_4c_LblDadosOp", "Label")
10502:         WITH loc_oAba.lbl_4c_LblDadosOp
10503:             .Caption   = "Dados da Opera" + CHR(231) + CHR(227) + "o"
10504:             .Top       = 39
10505:             .Left      = 405
10506:             .FontName  = "Tahoma"
10507:             .FontSize  = 7
10508:             .BackStyle = 0
10509:             .ForeColor = RGB(90, 90, 90)
10510:             .AutoSize  = .T.
10511:             .Visible   = .T.
10512:         ENDWITH
10513: 
10514:         *-- Especie Padrao (top=67)
10515:         loc_oAba.AddObject("lbl_4c_LblEspPad", "Label")
10516:         WITH loc_oAba.lbl_4c_LblEspPad
10517:             .Caption = "Esp" + CHR(233) + "cie Padr" + CHR(227) + "o : "
10518:             .Top = 67
10519:             .Left = 156
10520:             .FontName = "Tahoma"
10521:             .FontSize = 7
10522:             .BackStyle = 0
10523:             .ForeColor = RGB(90,90,90)
10524:             .AutoSize = .T.
10525:             .Visible = .T.
10526:         ENDWITH
10527: 

*-- Linhas 11034 a 11066:
11034: 
11035: 
11036:     *--------------------------------------------------------------------------
11037:     PROCEDURE Destroy()
11038:         IF USED("crSigCnFNf")
11039:             USE IN crSigCnFNf
11040:         ENDIF
11041:         IF USED("crSigCnFN2")
11042:             USE IN crSigCnFN2
11043:         ENDIF
11044:         IF USED("cursor_4c_Dados")
11045:             USE IN cursor_4c_Dados
11046:         ENDIF
11047:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
11048:             THIS.this_oBusinessObject = .NULL.
11049:         ENDIF
11050:         DODEFAULT()
11051:     ENDPROC
11052: 
11053:     *--------------------------------------------------------------------------
11054:     PROTECTED FUNCTION ObterControle(par_oConteiner, par_cNome)
11055:         LOCAL loc_nI, loc_oAchado
11056:         loc_oAchado = .NULL.
11057:         FOR loc_nI = 1 TO par_oConteiner.ControlCount
11058:             IF UPPER(par_oConteiner.Controls(loc_nI).Name) = UPPER(par_cNome)
11059:                 loc_oAchado = par_oConteiner.Controls(loc_nI)
11060:                 EXIT
11061:             ENDIF
11062:         ENDFOR
11063:         RETURN loc_oAchado
11064:     ENDPROC
11065: 
11066: ENDDEFINE

