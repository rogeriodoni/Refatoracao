# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (130)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Op_subn' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=195 vs migrado 'obj_4c_Op_subn' Top=2 (diff=193px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_subn' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=141 vs migrado 'obj_4c_Op_subn' Left=3 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_agregas' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=33 vs migrado 'obj_4c_Op_agregas' Top=2 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_agregas' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Op_agregas' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_imagem' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=108 vs migrado 'obj_4c_Op_imagem' Left=3 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_boleto' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=108 vs migrado 'obj_4c_Op_boleto' Left=3 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Menu' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=114 vs migrado 'obj_4c_Opt_Menu' Top=2 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Menu' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=108 vs migrado 'obj_4c_Opt_Menu' Left=3 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjAutos' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=134 vs migrado 'obj_4c_ObjAutos' Top=2 (diff=132px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjAutos' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=108 vs migrado 'obj_4c_ObjAutos' Left=3 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_BxAuto' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=283 vs migrado 'obj_4c_Op_BxAuto' Top=2 (diff=281px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_BxAuto' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=141 vs migrado 'obj_4c_Op_BxAuto' Left=3 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Objpagamento' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=192 vs migrado 'obj_4c_Objpagamento' Top=2 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Objpagamento' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Objpagamento' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjBusEnv' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=135 vs migrado 'obj_4c_ObjBusEnv' Top=2 (diff=133px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjBusEnv' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_ObjBusEnv' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption4' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=232 vs migrado 'obj_4c_Fwoption4' Top=2 (diff=230px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption4' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Fwoption4' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_tipomov' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=302 vs migrado 'obj_4c_Opt_tipomov' Top=2 (diff=300px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_tipomov' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=665 vs migrado 'obj_4c_Opt_tipomov' Left=3 (diff=662px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Saldo' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=73 vs migrado 'obj_4c_Op_Saldo' Top=2 (diff=71px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Saldo' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Op_Saldo' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_repete' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=53 vs migrado 'obj_4c_Op_repete' Top=2 (diff=51px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_repete' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Op_repete' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GetSequencia' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_GetSequencia' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_inib' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=93 vs migrado 'obj_4c_Op_inib' Top=2 (diff=91px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_inib' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Op_inib' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjMenFalha' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=114 vs migrado 'obj_4c_ObjMenFalha' Top=2 (diff=112px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjMenFalha' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_ObjMenFalha' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjRetrabs' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=155 vs migrado 'obj_4c_ObjRetrabs' Top=2 (diff=153px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjRetrabs' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_ObjRetrabs' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Objnaoconform' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=174 vs migrado 'obj_4c_Objnaoconform' Top=2 (diff=172px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Objnaoconform' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Objnaoconform' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=303 vs migrado 'obj_4c_Fwoption2' Top=2 (diff=301px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=141 vs migrado 'obj_4c_Fwoption2' Left=3 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=212 vs migrado 'obj_4c_Fwoption3' Top=2 (diff=210px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Fwoption3' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=323 vs migrado 'obj_4c_Fwoption1' Top=2 (diff=321px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=141 vs migrado 'obj_4c_Fwoption1' Left=3 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption5' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=73 vs migrado 'obj_4c_Fwoption5' Top=2 (diff=71px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption5' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=107 vs migrado 'obj_4c_Fwoption5' Left=3 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_compo' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=90 vs migrado 'obj_4c_Opt_compo' Top=2 (diff=88px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_compo' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=107 vs migrado 'obj_4c_Opt_compo' Left=3 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption8' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=52 vs migrado 'obj_4c_Fwoption8' Top=2 (diff=50px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption8' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=108 vs migrado 'obj_4c_Fwoption8' Left=3 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_EstOrig' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Top original=87 vs migrado 'obj_4c_Op_EstOrig' Top=2 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_EstOrig' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=468 vs migrado 'obj_4c_Op_EstOrig' Left=3 (diff=465px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_destino' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Top original=169 vs migrado 'obj_4c_Op_destino' Top=2 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_destino' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=94 vs migrado 'obj_4c_Op_destino' Left=3 (diff=91px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_EstDest' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Top original=208 vs migrado 'obj_4c_Op_EstDest' Top=2 (diff=206px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_EstDest' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=468 vs migrado 'obj_4c_Op_EstDest' Left=3 (diff=465px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Get_Repete' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Top original=169 vs migrado 'obj_4c_Get_Repete' Top=2 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Get_Repete' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=380 vs migrado 'obj_4c_Get_Repete' Left=3 (diff=377px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_origem' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Top original=49 vs migrado 'obj_4c_Op_origem' Top=2 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_origem' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=94 vs migrado 'obj_4c_Op_origem' Left=3 (diff=91px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_vende' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Top original=282 vs migrado 'obj_4c_Op_vende' Top=2 (diff=280px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_vende' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=104 vs migrado 'obj_4c_Op_vende' Left=3 (diff=101px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_ConOSub' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Top original=110 vs migrado 'obj_4c_Op_ConOSub' Top=2 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_ConOSub' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=467 vs migrado 'obj_4c_Op_ConOSub' Left=3 (diff=464px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_ConDSub' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Top original=231 vs migrado 'obj_4c_Op_ConDSub' Top=2 (diff=229px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_ConDSub' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=468 vs migrado 'obj_4c_Op_ConDSub' Left=3 (diff=465px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_BxOEst' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Top original=133 vs migrado 'obj_4c_Op_BxOEst' Top=2 (diff=131px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_BxOEst' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=467 vs migrado 'obj_4c_Op_BxOEst' Left=3 (diff=464px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_BxDEst' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Top original=254 vs migrado 'obj_4c_Op_BxDEst' Top=2 (diff=252px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_BxDEst' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=468 vs migrado 'obj_4c_Op_BxDEst' Left=3 (diff=465px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_grcomp' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=183 vs migrado 'obj_4c_Op_grcomp' Left=3 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_etiq' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=356 vs migrado 'obj_4c_Op_etiq' Top=2 (diff=354px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_etiq' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_Op_etiq' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_Chkf' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=100 vs migrado 'obj_4c_Opc_Chkf' Top=2 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_Chkf' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_Chkf' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_GrTrans' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=270 vs migrado 'obj_4c_Op_GrTrans' Top=2 (diff=268px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_GrTrans' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_Op_GrTrans' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjReinop' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=378 vs migrado 'obj_4c_ObjReinop' Top=2 (diff=376px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjReinop' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_ObjReinop' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptMatPrncDif' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=390 vs migrado 'obj_4c_OptMatPrncDif' Top=2 (diff=388px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptMatPrncDif' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=627 vs migrado 'obj_4c_OptMatPrncDif' Left=3 (diff=624px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=370 vs migrado 'obj_4c_Fwoption3' Top=2 (diff=368px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Fwoption3' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optqtdneg' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=351 vs migrado 'obj_4c_Optqtdneg' Top=2 (diff=349px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optqtdneg' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Optqtdneg' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_SepPedra' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=69 vs migrado 'obj_4c_Op_SepPedra' Top=2 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_SepPedra' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=183 vs migrado 'obj_4c_Op_SepPedra' Left=3 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Chk_TrfPeso' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=253 vs migrado 'obj_4c_Chk_TrfPeso' Top=2 (diff=251px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Chk_TrfPeso' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Chk_TrfPeso' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_pesobal' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=236 vs migrado 'obj_4c_Opc_pesobal' Top=2 (diff=234px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_pesobal' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_pesobal' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_env' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=195 vs migrado 'obj_4c_Opc_env' Top=2 (diff=193px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_env' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_env' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_mens' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=175 vs migrado 'obj_4c_Opc_mens' Top=2 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_mens' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_mens' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_PagSer' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=155 vs migrado 'obj_4c_Opc_PagSer' Top=2 (diff=153px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_PagSer' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_PagSer' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_grprod' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=183 vs migrado 'obj_4c_Op_grprod' Left=3 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_compagru' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=49 vs migrado 'obj_4c_Op_compagru' Top=2 (diff=47px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_compagru' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=183 vs migrado 'obj_4c_Op_compagru' Left=3 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_fix' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=119 vs migrado 'obj_4c_Opc_fix' Top=2 (diff=117px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_fix' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_fix' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjChkQP' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=306 vs migrado 'obj_4c_ObjChkQP' Top=2 (diff=304px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjChkQP' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_ObjChkQP' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=215 vs migrado 'obj_4c_Fwoption1' Top=2 (diff=213px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Fwoption1' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optBxPedFins' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=142 vs migrado 'obj_4c_OptBxPedFins' Top=2 (diff=140px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optBxPedFins' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_OptBxPedFins' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_quebraimp' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=412 vs migrado 'obj_4c_Opt_quebraimp' Top=2 (diff=410px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_quebraimp' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_Opt_quebraimp' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_cravacera' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=250 vs migrado 'obj_4c_Opt_cravacera' Top=2 (diff=248px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_cravacera' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_Opt_cravacera' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_codlib' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=229 vs migrado 'obj_4c_Opt_codlib' Top=2 (diff=227px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_codlib' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_Opt_codlib' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=210 vs migrado 'obj_4c_Fwoption2' Top=2 (diff=208px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=181 vs migrado 'obj_4c_Fwoption2' Left=3 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDocumento): Top original=64 vs migrado 'obj_4c_Optiongroup1' Top=2 (diff=62px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDocumento): Left original=176 vs migrado 'obj_4c_Optiongroup1' Left=3 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDocumento): Top original=90 vs migrado 'obj_4c_Optiongroup2' Top=2 (diff=88px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDocumento): Left original=176 vs migrado 'obj_4c_Optiongroup2' Left=3 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDocumento): Top original=116 vs migrado 'obj_4c_Optiongroup3' Top=2 (diff=114px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDocumento): Left original=176 vs migrado 'obj_4c_Optiongroup3' Left=3 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption4' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Top original=220 vs migrado 'obj_4c_Fwoption4' Top=2 (diff=218px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption4' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=180 vs migrado 'obj_4c_Fwoption4' Left=3 (diff=177px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Top original=196 vs migrado 'obj_4c_Fwoption3' Top=2 (diff=194px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=180 vs migrado 'obj_4c_Fwoption3' Left=3 (diff=177px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Top original=92 vs migrado 'obj_4c_Fwoption2' Top=2 (diff=90px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=181 vs migrado 'obj_4c_Fwoption2' Left=3 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Top original=71 vs migrado 'obj_4c_Fwoption1' Top=2 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=181 vs migrado 'obj_4c_Fwoption1' Left=3 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption5' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Top original=338 vs migrado 'obj_4c_Fwoption5' Top=2 (diff=336px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption5' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=184 vs migrado 'obj_4c_Fwoption5' Left=3 (diff=181px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Top original=80 vs migrado 'obj_4c_Optiongroup1' Top=2 (diff=78px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=818 vs migrado 'obj_4c_Optiongroup1' Left=3 (diff=815px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMPD.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5657 linhas total):

*-- Linhas 18 a 118:
18:     this_oBusinessObject = .NULL.
19:     this_cModoAtual      = "LISTA"
20: 
21:     PROCEDURE Init()
22:         RETURN DODEFAULT()
23:     ENDPROC
24: 
25:     PROTECTED PROCEDURE InicializarForm()
26:         LOCAL loc_lSucesso
27:         loc_lSucesso = .F.
28:         TRY
29:             THIS.Caption = "Movimenta" + CHR(231) + CHR(245) + ;
30:                 "es de Produ" + CHR(231) + CHR(227) + "o"
31:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
32:             THIS.this_oBusinessObject = CREATEOBJECT("MPDBO")
33:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
34:                 MostrarErro("Erro ao criar MPDBO", "FormMPD.InicializarForm")
35:             ELSE
36:                 THIS.ConfigurarPageFrame()
37:                 THIS.pgf_4c_Paginas.Visible = .T.
38:                 THIS.pgf_4c_Paginas.ActivePage = 1
39:                 THIS.this_cModoAtual = "LISTA"
40:                 loc_lSucesso = .T.
41:             ENDIF
42:         CATCH TO loException
43:             MostrarErro(loException, "FormMPD.InicializarForm")
44:             loc_lSucesso = .F.
45:         ENDTRY
46:         RETURN loc_lSucesso
47:     ENDPROC
48: 
49:     PROTECTED PROCEDURE ConfigurarPageFrame()
50:         TRY
51:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
52:             WITH THIS.pgf_4c_Paginas
53:                 .PageCount = 2
54:                 .Top       = -29
55:                 .Left      = 0
56:                 .Width     = THIS.Width
57:                 .Height    = THIS.Height + 29
58:                 .Tabs      = .F.
59:                 .Visible   = .T.
60:                 .Page1.Caption = "Lista"
61:                 .Page2.Caption = "Dados"
62:                 .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
63:                 .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
64:             ENDWITH
65:             THIS.ConfigurarContaineresPage1()
66:             THIS.ConfigurarContaineresPage2()
67:             THIS.ConfigurarPaginaLista()
68:             THIS.ConfigurarPaginaDados()
69:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
70:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
71:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
72:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
73:         CATCH TO loException
74:             MostrarErro(loException, "FormMPD.ConfigurarPageFrame")
75:         ENDTRY
76:     ENDPROC
77: 
78:     PROTECTED PROCEDURE ConfigurarContaineresPage1()
79:         LOCAL loc_oPg
80:         loc_oPg = THIS.pgf_4c_Paginas.Page1
81:         TRY
82:             loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
83:             WITH loc_oPg.cnt_4c_Cabecalho
84:                 .Top        = 31
85:                 .Left       = 0
86:                 .Width      = THIS.Width
87:                 .Height     = 80
88:                 .BackColor  = RGB(100, 100, 100)
89:                 .BorderWidth = 0
90:                 .Visible    = .T.
91:                 .AddObject("lbl_4c_Sombra", "Label")
92:                 WITH .lbl_4c_Sombra
93:                     .Top      = 15
94:                     .Left     = 12
95:                     .Width    = THIS.Width
96:                     .Height   = 40
97:                     .AutoSize = .F.
98:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
99:                         "es de Produ" + CHR(231) + CHR(227) + "o"
100:                     .FontName = "Tahoma"
101:                     .FontSize = 16
102:                     .FontBold = .T.
103:                     .ForeColor = RGB(0,0,0)
104:                     .BackStyle = 0
105:                     .Visible  = .T.
106:                 ENDWITH
107:                 .AddObject("lbl_4c_Titulo", "Label")
108:                 WITH .lbl_4c_Titulo
109:                     .Top      = 18
110:                     .Left     = 10
111:                     .Width    = THIS.Width
112:                     .Height   = 46
113:                     .AutoSize = .F.
114:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
115:                         "es de Produ" + CHR(231) + CHR(227) + "o"
116:                     .FontName = "Tahoma"
117:                     .FontSize = 16
118:                     .FontBold = .T.

*-- Linhas 147 a 190:
147:         ENDTRY
148:     ENDPROC
149: 
150:     PROTECTED PROCEDURE ConfigurarContaineresPage2()
151:         LOCAL loc_oPg
152:         loc_oPg = THIS.pgf_4c_Paginas.Page2
153:         TRY
154:             loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
155:             WITH loc_oPg.cnt_4c_Cabecalho
156:                 .Top        = 31
157:                 .Left       = 0
158:                 .Width      = THIS.Width
159:                 .Height     = 80
160:                 .BackColor  = RGB(100, 100, 100)
161:                 .BorderWidth = 0
162:                 .Visible    = .T.
163:                 .AddObject("lbl_4c_Sombra", "Label")
164:                 WITH .lbl_4c_Sombra
165:                     .Top      = 15
166:                     .Left     = 12
167:                     .Width    = THIS.Width
168:                     .Height   = 40
169:                     .AutoSize = .F.
170:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
171:                         "es de Produ" + CHR(231) + CHR(227) + "o"
172:                     .FontName = "Tahoma"
173:                     .FontSize = 16
174:                     .FontBold = .T.
175:                     .ForeColor = RGB(0,0,0)
176:                     .BackStyle = 0
177:                     .Visible  = .T.
178:                 ENDWITH
179:                 .AddObject("lbl_4c_Titulo", "Label")
180:                 WITH .lbl_4c_Titulo
181:                     .Top      = 18
182:                     .Left     = 10
183:                     .Width    = THIS.Width
184:                     .Height   = 46
185:                     .AutoSize = .F.
186:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
187:                         "es de Produ" + CHR(231) + CHR(227) + "o"
188:                     .FontName = "Tahoma"
189:                     .FontSize = 16
190:                     .FontBold = .T.

*-- Linhas 217 a 349:
217:         ENDTRY
218:     ENDPROC
219: 
220:     PROTECTED PROCEDURE ConfigurarPaginaLista()
221:         LOCAL loc_oPg, loc_oCnt
222:         loc_oPg = THIS.pgf_4c_Paginas.Page1
223:         TRY
224:             loc_oCnt = loc_oPg.cnt_4c_Botoes
225:             loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
226:             WITH loc_oCnt.cmd_4c_Incluir
227:                 .Top      = 5
228:                 .Left     = 5
229:                 .Width    = 75
230:                 .Height   = 75
231:                 .Caption  = "Incluir"
232:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
233:                 .FontName = "Tahoma"
234:                 .FontSize = 8
235:                 .Themes   = .F.
236:                 .Visible  = .T.
237:             ENDWITH
238:             BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
239:             loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
240:             WITH loc_oCnt.cmd_4c_Visualizar
241:                 .Top      = 5
242:                 .Left     = 82
243:                 .Width    = 75
244:                 .Height   = 75
245:                 .Caption  = "Visualizar"
246:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
247:                 .FontName = "Tahoma"
248:                 .FontSize = 8
249:                 .Themes   = .F.
250:                 .Visible  = .T.
251:             ENDWITH
252:             BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
253:             loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
254:             WITH loc_oCnt.cmd_4c_Alterar
255:                 .Top      = 5
256:                 .Left     = 159
257:                 .Width    = 75
258:                 .Height   = 75
259:                 .Caption  = "Alterar"
260:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
261:                 .FontName = "Tahoma"
262:                 .FontSize = 8
263:                 .Themes   = .F.
264:                 .Visible  = .T.
265:             ENDWITH
266:             BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
267:             loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
268:             WITH loc_oCnt.cmd_4c_Excluir
269:                 .Top      = 5
270:                 .Left     = 236
271:                 .Width    = 75
272:                 .Height   = 75
273:                 .Caption  = "Excluir"
274:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
275:                 .FontName = "Tahoma"
276:                 .FontSize = 8
277:                 .Themes   = .F.
278:                 .Visible  = .T.
279:             ENDWITH
280:             BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
281:             loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
282:             WITH loc_oCnt.cmd_4c_Buscar
283:                 .Top      = 5
284:                 .Left     = 313
285:                 .Width    = 75
286:                 .Height   = 75
287:                 .Caption  = "Buscar"
288:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
289:                 .FontName = "Tahoma"
290:                 .FontSize = 8
291:                 .Themes   = .F.
292:                 .Visible  = .T.
293:             ENDWITH
294:             BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
295:             loc_oCnt = loc_oPg.cnt_4c_Saida
296:             loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
297:             WITH loc_oCnt.cmd_4c_Encerrar
298:                 .Top      = 5
299:                 .Left     = 5
300:                 .Width    = 75
301:                 .Height   = 75
302:                 .Caption  = "Encerrar"
303:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
304:                 .FontName = "Tahoma"
305:                 .FontSize = 8
306:                 .Themes   = .F.
307:                 .Visible  = .T.
308:             ENDWITH
309:             BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
310:             loc_oPg.AddObject("cmd_4c_CadOpe", "CommandButton")
311:             WITH loc_oPg.cmd_4c_CadOpe
312:                 .Top      = 33
313:                 .Left     = 324
314:                 .Width    = 60
315:                 .Height   = 75
316:                 .Caption  = "Estoque"
317:                 .FontName = "Tahoma"
318:                 .FontSize = 8
319:                 .Themes   = .T.
320:                 .Visible  = .T.
321:             ENDWITH
322:             loc_oPg.AddObject("cmd_4c_ExpXML", "CommandButton")
323:             WITH loc_oPg.cmd_4c_ExpXML
324:                 .Top      = 33
325:                 .Left     = 399
326:                 .Width    = 60
327:                 .Height   = 75
328:                 .Caption  = "Exporta XML"
329:                 .FontName = "Tahoma"
330:                 .FontSize = 8
331:                 .Themes   = .T.
332:                 .Visible  = .T.
333:             ENDWITH
334:             loc_oPg.AddObject("cmd_4c_ImpXML", "CommandButton")
335:             WITH loc_oPg.cmd_4c_ImpXML
336:                 .Top      = 33
337:                 .Left     = 474
338:                 .Width    = 60
339:                 .Height   = 75
340:                 .Caption  = "Importa XML"
341:                 .FontName = "Tahoma"
342:                 .FontSize = 8
343:                 .Themes   = .T.
344:                 .Visible  = .T.
345:             ENDWITH
346:             loc_oPg.AddObject("grd_4c_Lista", "Grid")
347:             WITH loc_oPg.grd_4c_Lista
348:                 .Top          = 117
349:                 .Left         = 26

*-- Linhas 368 a 638:
368:         ENDTRY
369:     ENDPROC
370: 
371:     PROCEDURE CarregarLista()
372:         LOCAL loc_lSucesso
373:         loc_lSucesso = .F.
374:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
375:             RETURN .T.
376:         ENDIF
377:         TRY
378:             THIS.this_oBusinessObject.Buscar("")
379:             IF USED("cursor_4c_Dados")
380:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
381:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
382:                 WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
383:                     .Column1.ControlSource   = "cursor_4c_Dados.Dopps"
384:                     .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
385:                     .Column1.Width           = 300
386:                     .Column2.ControlSource   = "cursor_4c_Dados.Ndopps"
387:                     .Column2.Header1.Caption = "No. Opera" + CHR(231) + CHR(227) + "o"
388:                     .Column2.Width           = 80
389:                     .Column3.ControlSource   = "cursor_4c_Dados.Ordes"
390:                     .Column3.Header1.Caption = "Ordem"
391:                     .Column3.Width           = 60
392:                     .Column4.ControlSource   = "cursor_4c_Dados.Hists"
393:                     .Column4.Header1.Caption = "Hist" + CHR(243) + "rico"
394:                     .Column4.Width           = 420
395:                 ENDWITH
396:                 loc_lSucesso = .T.
397:             ENDIF
398:             THIS.AjustarBotoesPorModo()
399:         CATCH TO loException
400:             MostrarErro(loException, "FormMPD.CarregarLista")
401:         ENDTRY
402:         RETURN loc_lSucesso
403:     ENDPROC
404: 
405:     PROCEDURE AlternarPagina(par_nPagina)
406:         TRY
407:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
408:             IF par_nPagina = 1
409:                 THIS.this_cModoAtual = "LISTA"
410:             ENDIF
411:         CATCH TO loException
412:             MostrarErro(loException, "FormMPD.AlternarPagina")
413:         ENDTRY
414:     ENDPROC
415: 
416:     PROCEDURE BtnIncluirClick()
417:         TRY
418:             THIS.this_oBusinessObject.NovoRegistro()
419:             THIS.LimparCampos()
420:             THIS.BOParaForm()
421:             THIS.this_cModoAtual = "INCLUIR"
422:             THIS.HabilitarCampos(.T.)
423:             THIS.AlternarPagina(2)
424:         CATCH TO loException
425:             MostrarErro(loException, "FormMPD.BtnIncluirClick")
426:         ENDTRY
427:     ENDPROC
428: 
429:     PROCEDURE BtnVisualizarClick()
430:         LOCAL loc_cDopps
431:         TRY
432:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
433:                 MsgAviso("Selecione um registro.", "Aviso")
434:             ELSE
435:                 loc_cDopps = ALLTRIM(cursor_4c_Dados.Dopps)
436:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopps)
437:                     THIS.this_cModoAtual = "VISUALIZAR"
438:                     THIS.BOParaForm()
439:                     THIS.HabilitarCampos(.F.)
440:                     THIS.AlternarPagina(2)
441:                 ENDIF
442:             ENDIF
443:         CATCH TO loException
444:             MostrarErro(loException, "FormMPD.BtnVisualizarClick")
445:         ENDTRY
446:     ENDPROC
447: 
448:     PROCEDURE BtnAlterarClick()
449:         LOCAL loc_cDopps
450:         TRY
451:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
452:                 MsgAviso("Selecione um registro.", "Aviso")
453:             ELSE
454:                 loc_cDopps = ALLTRIM(cursor_4c_Dados.Dopps)
455:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopps)
456:                     THIS.this_oBusinessObject.EditarRegistro()
457:                     THIS.this_cModoAtual = "ALTERAR"
458:                     THIS.BOParaForm()
459:                     THIS.HabilitarCampos(.T.)
460:                     THIS.AlternarPagina(2)
461:                 ENDIF
462:             ENDIF
463:         CATCH TO loException
464:             MostrarErro(loException, "FormMPD.BtnAlterarClick")
465:         ENDTRY
466:     ENDPROC
467: 
468:     PROCEDURE BtnExcluirClick()
469:         LOCAL loc_cDopps, loc_lConfirma
470:         TRY
471:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
472:                 MsgAviso("Selecione um registro.", "Aviso")
473:             ELSE
474:                 loc_cDopps    = ALLTRIM(cursor_4c_Dados.Dopps)
475:                 loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o?", "Confirmar")
476:                 IF loc_lConfirma
477:                     IF THIS.this_oBusinessObject.Excluir(loc_cDopps)
478:                         THIS.CarregarLista()
479:                     ENDIF
480:                 ENDIF
481:             ENDIF
482:         CATCH TO loException
483:             MostrarErro(loException, "FormMPD.BtnExcluirClick")
484:         ENDTRY
485:     ENDPROC
486: 
487:     PROCEDURE BtnBuscarClick()
488:         LOCAL loc_cFiltro
489:         TRY
490:             loc_cFiltro = INPUTBOX("Pesquisar por descri" + CHR(231) + CHR(227) + "o:", ;
491:                 "Busca", "")
492:             THIS.this_oBusinessObject.Buscar(loc_cFiltro)
493:             IF USED("cursor_4c_Dados")
494:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
495:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
496:                 WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
497:                     .Column1.ControlSource   = "cursor_4c_Dados.Dopps"
498:                     .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
499:                     .Column1.Width           = 300
500:                     .Column2.ControlSource   = "cursor_4c_Dados.Ndopps"
501:                     .Column2.Header1.Caption = "No. Opera" + CHR(231) + CHR(227) + "o"
502:                     .Column2.Width           = 80
503:                     .Column3.ControlSource   = "cursor_4c_Dados.Ordes"
504:                     .Column3.Header1.Caption = "Ordem"
505:                     .Column3.Width           = 60
506:                     .Column4.ControlSource   = "cursor_4c_Dados.Hists"
507:                     .Column4.Header1.Caption = "Hist" + CHR(243) + "rico"
508:                     .Column4.Width           = 420
509:                 ENDWITH
510:             ENDIF
511:         CATCH TO loException
512:             MostrarErro(loException, "FormMPD.BtnBuscarClick")
513:         ENDTRY
514:     ENDPROC
515: 
516:     PROCEDURE BtnEncerrarClick()
517:         TRY
518:             THIS.Release()
519:         CATCH TO loException
520:             MostrarErro(loException, "FormMPD.BtnEncerrarClick")
521:         ENDTRY
522:     ENDPROC
523: 
524:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
525:         TRY
526:             par_oGrid.FontName = "Verdana"
527:             par_oGrid.FontSize = 8
528:         CATCH TO loException
529:             MostrarErro(loException, "FormMPD.FormatarGridLista")
530:         ENDTRY
531:     ENDPROC
532: 
533:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
534:         LOCAL loc_nI, loc_oCtrl
535:         TRY
536:             FOR loc_nI = 1 TO par_oContainer.ControlCount
537:                 loc_oCtrl = par_oContainer.Controls(loc_nI)
538:                 IF !INLIST(LOWER(loc_oCtrl.Name), "cnt_4c_cabecalho")
539:                     loc_oCtrl.Visible = .T.
540:                     IF loc_oCtrl.ControlCount > 0
541:                         THIS.TornarControlesVisiveis(loc_oCtrl)
542:                     ENDIF
543:                 ENDIF
544:             ENDFOR
545:         CATCH TO loException
546:             MostrarErro(loException, "FormMPD.TornarControlesVisiveis")
547:         ENDTRY
548:     ENDPROC
549: 
550:     PROTECTED PROCEDURE ConfigurarPaginaDados()
551:         LOCAL loc_oPg, loc_oCnt
552:         loc_oPg = THIS.pgf_4c_Paginas.Page2
553:         TRY
554:             loc_oPg.cnt_4c_Cabecalho.Visible = .F.
555:             loc_oCnt = loc_oPg.cnt_4c_BotoesAcao
556:             loc_oCnt.AddObject("cmd_4c_Salvar", "CommandButton")
557:             WITH loc_oCnt.cmd_4c_Salvar
558:                 .Top      = 5
559:                 .Left     = 5
560:                 .Width    = 75
561:                 .Height   = 75
562:                 .Caption  = "Salvar"
563:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_gravar_60.jpg"
564:                 .FontName = "Tahoma"
565:                 .FontSize = 8
566:                 .Themes   = .F.
567:                 .Visible  = .T.
568:             ENDWITH
569:             BINDEVENT(loc_oCnt.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
570:             loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
571:             WITH loc_oCnt.cmd_4c_Cancelar
572:                 .Top      = 5
573:                 .Left     = 82
574:                 .Width    = 75
575:                 .Height   = 75
576:                 .Caption  = "Encerrar"
577:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
578:                 .FontName = "Tahoma"
579:                 .FontSize = 8
580:                 .Themes   = .F.
581:                 .Visible  = .T.
582:             ENDWITH
583:             BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
584:             loc_oCnt = loc_oPg.cnt_4c_Saida
585:             loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
586:             WITH loc_oCnt.cmd_4c_Encerrar
587:                 .Top      = 5
588:                 .Left     = 5
589:                 .Width    = 75
590:                 .Height   = 75
591:                 .Caption  = "Encerrar"
592:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
593:                 .FontName = "Tahoma"
594:                 .FontSize = 8
595:                 .Themes   = .F.
596:                 .Visible  = .T.
597:             ENDWITH
598:             BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
599:             * Campos de cabecalho da aba Dados (top + 29 compensa pgf_4c_Paginas.Top=-29)
600:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
601:             WITH loc_oPg.lbl_4c_Label1
602:                 .Top       = 74
603:                 .Left      = 64
604:                 .Width     = 58
605:                 .Height    = 15
606:                 .AutoSize  = .F.
607:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
608:                 .BackStyle = 0
609:                 .Visible   = .T.
610:             ENDWITH
611:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
612:             WITH loc_oPg.txt_4c_Desc
613:                 .Top       = 70
614:                 .Left      = 132
615:                 .Width     = 150
616:                 .Height    = 23
617:                 .MaxLength = 40
618:                 .Visible   = .T.
619:             ENDWITH
620:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
621:             WITH loc_oPg.lbl_4c_Label25
622:                 .Top       = 74
623:                 .Left      = 332
624:                 .Width     = 71
625:                 .Height    = 15
626:                 .AutoSize  = .F.
627:                 .Caption   = "N" + CHR(186) + " Opera" + CHR(231) + CHR(227) + "o :"
628:                 .BackStyle = 0
629:                 .Visible   = .T.
630:             ENDWITH
631:             loc_oPg.AddObject("txt_4c_Nope", "TextBox")
632:             WITH loc_oPg.txt_4c_Nope
633:                 .Top      = 70
634:                 .Left     = 416
635:                 .Width    = 29
636:                 .Height   = 23
637:                 .ReadOnly = .T.
638:                 .Visible  = .T.

*-- Linhas 666 a 736:
666:                 .Themes  = .T.
667:                 .Visible = .T.
668:             ENDWITH
669:             BINDEVENT(loc_oPg.obj_4c_CmdGarqicone, "Click", THIS, "CmdGarqiconeClick")
670:             * PageFrame interno: 5 abas (Operacao, Estoque, Componente, Documento, Diversas)
671:             loc_oPg.AddObject("pgf_4c_PagDados", "PageFrame")
672:             WITH loc_oPg.pgf_4c_PagDados
673:                 .Top       = 150
674:                 .Left      = 6
675:                 .Width     = 987
676:                 .Height    = 475
677:                 .PageCount = 5
678:                 .Visible   = .T.
679:                 .Page1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
680:                 .Page2.Caption = "Estoque"
681:                 .Page3.Caption = "Componente"
682:                 .Page4.Caption = "Documento"
683:                 .Page5.Caption = "Diversas"
684:             ENDWITH
685:             THIS.ConfigurarPgOperacao()
686:             THIS.ConfigurarPgEstoque()
687:             THIS.ConfigurarPgComponente()
688:             THIS.ConfigurarPgDocumento()
689:             THIS.ConfigurarPgDiversas()
690:             THIS.TornarControlesVisiveis(loc_oPg)
691:         CATCH TO loException
692:             MostrarErro(loException, "FormMPD.ConfigurarPaginaDados")
693:         ENDTRY
694:     ENDPROC
695: 
696:     PROTECTED PROCEDURE ConfigurarPgOperacao()
697:         LOCAL loc_oPg
698:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
699:         TRY
700:             loc_oPg.AddObject("shp_4c_Shape7", "Shape")
701:             WITH loc_oPg.shp_4c_Shape7
702:                 .Top     = 192
703:                 .Left    = 7
704:                 .Width   = 287
705:                 .Height  = 162
706:                 .Visible = .T.
707:             ENDWITH
708:             * Labels coluna esquerda
709:             loc_oPg.AddObject("lbl_4c_Label36", "Label")
710:             WITH loc_oPg.lbl_4c_Label36
711:                 .Top       = 15
712:                 .Left      = 60
713:                 .Width     = 60
714:                 .Height    = 15
715:                 .AutoSize  = .F.
716:                 .Caption   = "Imagem : "
717:                 .BackStyle = 0
718:                 .Visible   = .T.
719:             ENDWITH
720:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
721:             WITH loc_oPg.lbl_4c_Label2
722:                 .Top       = 34
723:                 .Left      = 68
724:                 .Width     = 60
725:                 .Height    = 15
726:                 .AutoSize  = .F.
727:                 .Caption   = "Boleto : "
728:                 .BackStyle = 0
729:                 .Visible   = .T.
730:             ENDWITH
731:             loc_oPg.AddObject("lbl_4c_Label31", "Label")
732:             WITH loc_oPg.lbl_4c_Label31
733:                 .Top       = 54
734:                 .Left      = 44
735:                 .Width     = 80
736:                 .Height    = 15

*-- Linhas 1143 a 1746:
1143:                 .Themes  = .T.
1144:                 .Visible = .T.
1145:             ENDWITH
1146:             BINDEVENT(loc_oPg.cmd_4c_CmdIcone, "Click", THIS, "CmdIconeClick")
1147:             * OptionGroups coluna esquerda
1148:             loc_oPg.AddObject("obj_4c_Op_imagem", "OptionGroup")
1149:             WITH loc_oPg.obj_4c_Op_imagem
1150:                 .Top         = 13
1151:                 .Left        = 108
1152:                 .Width       = 89
1153:                 .Height      = 20
1154:                 .ButtonCount = 2
1155:                 .Visible     = .T.
1156:                 WITH .Buttons(1)
1157:                     .Top     = 2
1158:                     .Left    = 3
1159:                     .Caption = "Sim"
1160:                     .Width   = 40
1161:                     .AutoSize = .F.
1162:                 ENDWITH
1163:                 WITH .Buttons(2)
1164:                     .Top     = 2
1165:                     .Left    = 46
1166:                     .Caption = "N" + CHR(227) + "o"
1167:                     .Width   = 40
1168:                     .AutoSize = .F.
1169:                 ENDWITH
1170:             ENDWITH
1171:             loc_oPg.AddObject("obj_4c_Op_boleto", "OptionGroup")
1172:             WITH loc_oPg.obj_4c_Op_boleto
1173:                 .Top         = 32
1174:                 .Left        = 108
1175:                 .Width       = 130
1176:                 .Height      = 17
1177:                 .ButtonCount = 3
1178:                 .Visible     = .T.
1179:                 WITH .Buttons(1)
1180:                     .Top     = 2
1181:                     .Left    = 3
1182:                     .Caption = "Sim"
1183:                     .Width   = 38
1184:                     .AutoSize = .F.
1185:                 ENDWITH
1186:                 WITH .Buttons(2)
1187:                     .Top     = 2
1188:                     .Left    = 44
1189:                     .Caption = "N" + CHR(227) + "o"
1190:                     .Width   = 38
1191:                     .AutoSize = .F.
1192:                 ENDWITH
1193:                 WITH .Buttons(3)
1194:                     .Top     = 2
1195:                     .Left    = 88
1196:                     .Caption = "Tela"
1197:                     .Width   = 38
1198:                     .AutoSize = .F.
1199:                 ENDWITH
1200:             ENDWITH
1201:             loc_oPg.AddObject("obj_4c_Fwoption8", "OptionGroup")
1202:             WITH loc_oPg.obj_4c_Fwoption8
1203:                 .Top         = 52
1204:                 .Left        = 108
1205:                 .Width       = 89
1206:                 .Height      = 20
1207:                 .ButtonCount = 2
1208:                 .Visible     = .T.
1209:                 WITH .Buttons(1)
1210:                     .Top     = 2
1211:                     .Left    = 3
1212:                     .Caption = "Sim"
1213:                     .Width   = 40
1214:                     .AutoSize = .F.
1215:                 ENDWITH
1216:                 WITH .Buttons(2)
1217:                     .Top     = 2
1218:                     .Left    = 46
1219:                     .Caption = "N" + CHR(227) + "o"
1220:                     .Width   = 40
1221:                     .AutoSize = .F.
1222:                 ENDWITH
1223:             ENDWITH
1224:             loc_oPg.AddObject("obj_4c_Fwoption5", "OptionGroup")
1225:             WITH loc_oPg.obj_4c_Fwoption5
1226:                 .Top         = 73
1227:                 .Left        = 107
1228:                 .Width       = 92
1229:                 .Height      = 20
1230:                 .ButtonCount = 2
1231:                 .Visible     = .T.
1232:                 WITH .Buttons(1)
1233:                     .Top     = 2
1234:                     .Left    = 3
1235:                     .Caption = "Sim"
1236:                     .Width   = 40
1237:                     .AutoSize = .F.
1238:                 ENDWITH
1239:                 WITH .Buttons(2)
1240:                     .Top     = 2
1241:                     .Left    = 46
1242:                     .Caption = "N" + CHR(227) + "o"
1243:                     .Width   = 40
1244:                     .AutoSize = .F.
1245:                 ENDWITH
1246:             ENDWITH
1247:             loc_oPg.AddObject("obj_4c_Opt_compo", "OptionGroup")
1248:             WITH loc_oPg.obj_4c_Opt_compo
1249:                 .Top         = 90
1250:                 .Left        = 107
1251:                 .Width       = 89
1252:                 .Height      = 20
1253:                 .ButtonCount = 2
1254:                 .Visible     = .T.
1255:                 WITH .Buttons(1)
1256:                     .Top     = 2
1257:                     .Left    = 3
1258:                     .Caption = "Sim"
1259:                     .Width   = 40
1260:                     .AutoSize = .F.
1261:                 ENDWITH
1262:                 WITH .Buttons(2)
1263:                     .Top     = 2
1264:                     .Left    = 46
1265:                     .Caption = "N" + CHR(227) + "o"
1266:                     .Width   = 40
1267:                     .AutoSize = .F.
1268:                 ENDWITH
1269:             ENDWITH
1270:             loc_oPg.AddObject("obj_4c_Opt_Menu", "OptionGroup")
1271:             WITH loc_oPg.obj_4c_Opt_Menu
1272:                 .Top         = 114
1273:                 .Left        = 108
1274:                 .Width       = 89
1275:                 .Height      = 20
1276:                 .ButtonCount = 2
1277:                 .Visible     = .T.
1278:                 WITH .Buttons(1)
1279:                     .Top     = 2
1280:                     .Left    = 3
1281:                     .Caption = "Sim"
1282:                     .Width   = 40
1283:                     .AutoSize = .F.
1284:                 ENDWITH
1285:                 WITH .Buttons(2)
1286:                     .Top     = 2
1287:                     .Left    = 46
1288:                     .Caption = "N" + CHR(227) + "o"
1289:                     .Width   = 40
1290:                     .AutoSize = .F.
1291:                 ENDWITH
1292:             ENDWITH
1293:             loc_oPg.AddObject("obj_4c_ObjAutos", "OptionGroup")
1294:             WITH loc_oPg.obj_4c_ObjAutos
1295:                 .Top         = 134
1296:                 .Left        = 108
1297:                 .Width       = 193
1298:                 .Height      = 20
1299:                 .ButtonCount = 3
1300:                 .Visible     = .T.
1301:                 WITH .Buttons(1)
1302:                     .Top     = 2
1303:                     .Left    = 3
1304:                     .Caption = "Movim."
1305:                     .Width   = 60
1306:                     .AutoSize = .F.
1307:                 ENDWITH
1308:                 WITH .Buttons(2)
1309:                     .Top     = 2
1310:                     .Left    = 66
1311:                     .Caption = "Encerra"
1312:                     .Width   = 60
1313:                     .AutoSize = .F.
1314:                 ENDWITH
1315:                 WITH .Buttons(3)
1316:                     .Top     = 2
1317:                     .Left    = 130
1318:                     .Caption = "Nenhum"
1319:                     .Width   = 60
1320:                     .AutoSize = .F.
1321:                 ENDWITH
1322:             ENDWITH
1323:             loc_oPg.AddObject("obj_4c_Op_subn", "OptionGroup")
1324:             WITH loc_oPg.obj_4c_Op_subn
1325:                 .Top         = 195
1326:                 .Left        = 141
1327:                 .Width       = 88
1328:                 .Height      = 20
1329:                 .ButtonCount = 2
1330:                 .Visible     = .T.
1331:                 WITH .Buttons(1)
1332:                     .Top     = 2
1333:                     .Left    = 3
1334:                     .Caption = "Sim"
1335:                     .Width   = 40
1336:                     .AutoSize = .F.
1337:                 ENDWITH
1338:                 WITH .Buttons(2)
1339:                     .Top     = 2
1340:                     .Left    = 46
1341:                     .Caption = "N" + CHR(227) + "o"
1342:                     .Width   = 40
1343:                     .AutoSize = .F.
1344:                 ENDWITH
1345:             ENDWITH
1346:             loc_oPg.AddObject("obj_4c_Op_BxAuto", "OptionGroup")
1347:             WITH loc_oPg.obj_4c_Op_BxAuto
1348:                 .Top         = 283
1349:                 .Left        = 141
1350:                 .Width       = 88
1351:                 .Height      = 20
1352:                 .ButtonCount = 2
1353:                 .Visible     = .T.
1354:                 WITH .Buttons(1)
1355:                     .Top     = 2
1356:                     .Left    = 3
1357:                     .Caption = "Sim"
1358:                     .Width   = 40
1359:                     .AutoSize = .F.
1360:                 ENDWITH
1361:                 WITH .Buttons(2)
1362:                     .Top     = 2
1363:                     .Left    = 46
1364:                     .Caption = "N" + CHR(227) + "o"
1365:                     .Width   = 40
1366:                     .AutoSize = .F.
1367:                 ENDWITH
1368:             ENDWITH
1369:             loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
1370:             WITH loc_oPg.obj_4c_Fwoption2
1371:                 .Top         = 303
1372:                 .Left        = 141
1373:                 .Width       = 88
1374:                 .Height      = 20
1375:                 .ButtonCount = 2
1376:                 .Visible     = .T.
1377:                 WITH .Buttons(1)
1378:                     .Top     = 2
1379:                     .Left    = 3
1380:                     .Caption = "Sim"
1381:                     .Width   = 40
1382:                     .AutoSize = .F.
1383:                 ENDWITH
1384:                 WITH .Buttons(2)
1385:                     .Top     = 2
1386:                     .Left    = 46
1387:                     .Caption = "N" + CHR(227) + "o"
1388:                     .Width   = 40
1389:                     .AutoSize = .F.
1390:                 ENDWITH
1391:             ENDWITH
1392:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
1393:             WITH loc_oPg.obj_4c_Fwoption1
1394:                 .Top         = 323
1395:                 .Left        = 141
1396:                 .Width       = 88
1397:                 .Height      = 20
1398:                 .ButtonCount = 2
1399:                 .Visible     = .T.
1400:                 WITH .Buttons(1)
1401:                     .Top     = 2
1402:                     .Left    = 3
1403:                     .Caption = "Sim"
1404:                     .Width   = 40
1405:                     .AutoSize = .F.
1406:                 ENDWITH
1407:                 WITH .Buttons(2)
1408:                     .Top     = 2
1409:                     .Left    = 46
1410:                     .Caption = "N" + CHR(227) + "o"
1411:                     .Width   = 40
1412:                     .AutoSize = .F.
1413:                 ENDWITH
1414:             ENDWITH
1415:             * OptionGroups coluna direita
1416:             loc_oPg.AddObject("obj_4c_GetSequencia", "OptionGroup")
1417:             WITH loc_oPg.obj_4c_GetSequencia
1418:                 .Top         = 12
1419:                 .Left        = 656
1420:                 .Width       = 88
1421:                 .Height      = 21
1422:                 .ButtonCount = 2
1423:                 .Visible     = .T.
1424:                 WITH .Buttons(1)
1425:                     .Top     = 2
1426:                     .Left    = 3
1427:                     .Caption = "Sim"
1428:                     .Width   = 40
1429:                     .AutoSize = .F.
1430:                 ENDWITH
1431:                 WITH .Buttons(2)
1432:                     .Top     = 2
1433:                     .Left    = 46
1434:                     .Caption = "N" + CHR(227) + "o"
1435:                     .Width   = 40
1436:                     .AutoSize = .F.
1437:                 ENDWITH
1438:             ENDWITH
1439:             loc_oPg.AddObject("obj_4c_Op_agregas", "OptionGroup")
1440:             WITH loc_oPg.obj_4c_Op_agregas
1441:                 .Top         = 33
1442:                 .Left        = 656
1443:                 .Width       = 88
1444:                 .Height      = 20
1445:                 .ButtonCount = 2
1446:                 .Visible     = .T.
1447:                 WITH .Buttons(1)
1448:                     .Top     = 2
1449:                     .Left    = 3
1450:                     .Caption = "Sim"
1451:                     .Width   = 40
1452:                     .AutoSize = .F.
1453:                 ENDWITH
1454:                 WITH .Buttons(2)
1455:                     .Top     = 2
1456:                     .Left    = 46
1457:                     .Caption = "N" + CHR(227) + "o"
1458:                     .Width   = 40
1459:                     .AutoSize = .F.
1460:                 ENDWITH
1461:             ENDWITH
1462:             loc_oPg.AddObject("obj_4c_Op_repete", "OptionGroup")
1463:             WITH loc_oPg.obj_4c_Op_repete
1464:                 .Top         = 53
1465:                 .Left        = 656
1466:                 .Width       = 160
1467:                 .Height      = 20
1468:                 .ButtonCount = 3
1469:                 .Visible     = .T.
1470:                 WITH .Buttons(1)
1471:                     .Top     = 2
1472:                     .Left    = 3
1473:                     .Caption = "Sim"
1474:                     .Width   = 50
1475:                     .AutoSize = .F.
1476:                 ENDWITH
1477:                 WITH .Buttons(2)
1478:                     .Top     = 2
1479:                     .Left    = 56
1480:                     .Caption = "N" + CHR(227) + "o"
1481:                     .Width   = 50
1482:                     .AutoSize = .F.
1483:                 ENDWITH
1484:                 WITH .Buttons(3)
1485:                     .Top     = 2
1486:                     .Left    = 109
1487:                     .Caption = "Por Setor"
1488:                     .Width   = 50
1489:                     .AutoSize = .F.
1490:                 ENDWITH
1491:             ENDWITH
1492:             loc_oPg.AddObject("obj_4c_Op_Saldo", "OptionGroup")
1493:             WITH loc_oPg.obj_4c_Op_Saldo
1494:                 .Top         = 73
1495:                 .Left        = 656
1496:                 .Width       = 88
1497:                 .Height      = 20
1498:                 .ButtonCount = 2
1499:                 .Visible     = .T.
1500:                 WITH .Buttons(1)
1501:                     .Top     = 2
1502:                     .Left    = 3
1503:                     .Caption = "Sim"
1504:                     .Width   = 40
1505:                     .AutoSize = .F.
1506:                 ENDWITH
1507:                 WITH .Buttons(2)
1508:                     .Top     = 2
1509:                     .Left    = 46
1510:                     .Caption = "N" + CHR(227) + "o"
1511:                     .Width   = 40
1512:                     .AutoSize = .F.
1513:                 ENDWITH
1514:             ENDWITH
1515:             loc_oPg.AddObject("obj_4c_Op_inib", "OptionGroup")
1516:             WITH loc_oPg.obj_4c_Op_inib
1517:                 .Top         = 93
1518:                 .Left        = 656
1519:                 .Width       = 88
1520:                 .Height      = 20
1521:                 .ButtonCount = 2
1522:                 .Visible     = .T.
1523:                 WITH .Buttons(1)
1524:                     .Top     = 2
1525:                     .Left    = 3
1526:                     .Caption = "Sim"
1527:                     .Width   = 40
1528:                     .AutoSize = .F.
1529:                 ENDWITH
1530:                 WITH .Buttons(2)
1531:                     .Top     = 2
1532:                     .Left    = 46
1533:                     .Caption = "N" + CHR(227) + "o"
1534:                     .Width   = 40
1535:                     .AutoSize = .F.
1536:                 ENDWITH
1537:             ENDWITH
1538:             loc_oPg.AddObject("obj_4c_ObjMenFalha", "OptionGroup")
1539:             WITH loc_oPg.obj_4c_ObjMenFalha
1540:                 .Top         = 114
1541:                 .Left        = 656
1542:                 .Width       = 88
1543:                 .Height      = 20
1544:                 .ButtonCount = 2
1545:                 .Visible     = .T.
1546:                 WITH .Buttons(1)
1547:                     .Top     = 2
1548:                     .Left    = 3
1549:                     .Caption = "Sim"
1550:                     .Width   = 40
1551:                     .AutoSize = .F.
1552:                 ENDWITH
1553:                 WITH .Buttons(2)
1554:                     .Top     = 2
1555:                     .Left    = 46
1556:                     .Caption = "N" + CHR(227) + "o"
1557:                     .Width   = 40
1558:                     .AutoSize = .F.
1559:                 ENDWITH
1560:             ENDWITH
1561:             loc_oPg.AddObject("obj_4c_ObjBusEnv", "OptionGroup")
1562:             WITH loc_oPg.obj_4c_ObjBusEnv
1563:                 .Top         = 135
1564:                 .Left        = 656
1565:                 .Width       = 88
1566:                 .Height      = 20
1567:                 .ButtonCount = 2
1568:                 .Visible     = .T.
1569:                 WITH .Buttons(1)
1570:                     .Top     = 2
1571:                     .Left    = 3
1572:                     .Caption = "Sim"
1573:                     .Width   = 40
1574:                     .AutoSize = .F.
1575:                 ENDWITH
1576:                 WITH .Buttons(2)
1577:                     .Top     = 2
1578:                     .Left    = 46
1579:                     .Caption = "N" + CHR(227) + "o"
1580:                     .Width   = 40
1581:                     .AutoSize = .F.
1582:                 ENDWITH
1583:             ENDWITH
1584:             loc_oPg.AddObject("obj_4c_ObjRetrabs", "OptionGroup")
1585:             WITH loc_oPg.obj_4c_ObjRetrabs
1586:                 .Top         = 155
1587:                 .Left        = 656
1588:                 .Width       = 88
1589:                 .Height      = 20
1590:                 .ButtonCount = 2
1591:                 .Visible     = .T.
1592:                 WITH .Buttons(1)
1593:                     .Top     = 2
1594:                     .Left    = 3
1595:                     .Caption = "Sim"
1596:                     .Width   = 40
1597:                     .AutoSize = .F.
1598:                 ENDWITH
1599:                 WITH .Buttons(2)
1600:                     .Top     = 2
1601:                     .Left    = 46
1602:                     .Caption = "N" + CHR(227) + "o"
1603:                     .Width   = 40
1604:                     .AutoSize = .F.
1605:                 ENDWITH
1606:             ENDWITH
1607:             loc_oPg.AddObject("obj_4c_Objnaoconform", "OptionGroup")
1608:             WITH loc_oPg.obj_4c_Objnaoconform
1609:                 .Top         = 174
1610:                 .Left        = 656
1611:                 .Width       = 88
1612:                 .Height      = 20
1613:                 .ButtonCount = 2
1614:                 .Visible     = .T.
1615:                 WITH .Buttons(1)
1616:                     .Top     = 2
1617:                     .Left    = 3
1618:                     .Caption = "Sim"
1619:                     .Width   = 40
1620:                     .AutoSize = .F.
1621:                 ENDWITH
1622:                 WITH .Buttons(2)
1623:                     .Top     = 2
1624:                     .Left    = 46
1625:                     .Caption = "N" + CHR(227) + "o"
1626:                     .Width   = 40
1627:                     .AutoSize = .F.
1628:                 ENDWITH
1629:             ENDWITH
1630:             loc_oPg.AddObject("obj_4c_Objpagamento", "OptionGroup")
1631:             WITH loc_oPg.obj_4c_Objpagamento
1632:                 .Top         = 192
1633:                 .Left        = 656
1634:                 .Width       = 88
1635:                 .Height      = 20
1636:                 .ButtonCount = 2
1637:                 .Visible     = .T.
1638:                 WITH .Buttons(1)
1639:                     .Top     = 2
1640:                     .Left    = 3
1641:                     .Caption = "Sim"
1642:                     .Width   = 40
1643:                     .AutoSize = .F.
1644:                 ENDWITH
1645:                 WITH .Buttons(2)
1646:                     .Top     = 2
1647:                     .Left    = 46
1648:                     .Caption = "N" + CHR(227) + "o"
1649:                     .Width   = 40
1650:                     .AutoSize = .F.
1651:                 ENDWITH
1652:             ENDWITH
1653:             loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
1654:             WITH loc_oPg.obj_4c_Fwoption3
1655:                 .Top         = 212
1656:                 .Left        = 656
1657:                 .Width       = 88
1658:                 .Height      = 20
1659:                 .ButtonCount = 2
1660:                 .Visible     = .T.
1661:                 WITH .Buttons(1)
1662:                     .Top     = 2
1663:                     .Left    = 3
1664:                     .Caption = "Sim"
1665:                     .Width   = 40
1666:                     .AutoSize = .F.
1667:                 ENDWITH
1668:                 WITH .Buttons(2)
1669:                     .Top     = 2
1670:                     .Left    = 46
1671:                     .Caption = "N" + CHR(227) + "o"
1672:                     .Width   = 40
1673:                     .AutoSize = .F.
1674:                 ENDWITH
1675:             ENDWITH
1676:             loc_oPg.AddObject("obj_4c_Fwoption4", "OptionGroup")
1677:             WITH loc_oPg.obj_4c_Fwoption4
1678:                 .Top         = 232
1679:                 .Left        = 656
1680:                 .Width       = 155
1681:                 .Height      = 23
1682:                 .ButtonCount = 3
1683:                 .Visible     = .T.
1684:                 WITH .Buttons(1)
1685:                     .Top     = 2
1686:                     .Left    = 3
1687:                     .Caption = "Op"
1688:                     .Width   = 47
1689:                     .AutoSize = .F.
1690:                 ENDWITH
1691:                 WITH .Buttons(2)
1692:                     .Top     = 2
1693:                     .Left    = 53
1694:                     .Caption = "Env"
1695:                     .Width   = 47
1696:                     .AutoSize = .F.
1697:                 ENDWITH
1698:                 WITH .Buttons(3)
1699:                     .Top     = 2
1700:                     .Left    = 103
1701:                     .Caption = "Nenhum"
1702:                     .Width   = 47
1703:                     .AutoSize = .F.
1704:                 ENDWITH
1705:             ENDWITH
1706:             loc_oPg.AddObject("obj_4c_Opt_tipomov", "OptionGroup")
1707:             WITH loc_oPg.obj_4c_Opt_tipomov
1708:                 .Top         = 302
1709:                 .Left        = 665
1710:                 .Width       = 237
1711:                 .Height      = 98
1712:                 .ButtonCount = 11
1713:                 .Visible     = .T.
1714:                 WITH .Buttons(1)
1715:                     .Left    = 3
1716:                     .Top     = 2
1717:                     .Caption = "Envelopagem"
1718:                     .Width   = 100
1719:                     .Height  = 14
1720:                     .AutoSize = .F.
1721:                 ENDWITH
1722:                 WITH .Buttons(2)
1723:                     .Left    = 107
1724:                     .Top     = 2
1725:                     .Caption = "Nenhum"
1726:                     .Width   = 100
1727:                     .Height  = 14
1728:                     .AutoSize = .F.
1729:                 ENDWITH
1730:                 WITH .Buttons(3)
1731:                     .Left    = 3
1732:                     .Top     = 17
1733:                     .Caption = "Encerra"
1734:                     .Width   = 100
1735:                     .Height  = 14
1736:                     .AutoSize = .F.
1737:                 ENDWITH
1738:                 WITH .Buttons(4)
1739:                     .Left    = 107
1740:                     .Top     = 17
1741:                     .Caption = "Dev.Pedra"
1742:                     .Width   = 100
1743:                     .Height  = 14
1744:                     .AutoSize = .F.
1745:                 ENDWITH
1746:                 WITH .Buttons(5)

*-- Linhas 1800 a 1937:
1800:                     .AutoSize = .F.
1801:                 ENDWITH
1802:             ENDWITH
1803:             * BINDEVENTs lookups Operacao
1804:             BINDEVENT(loc_oPg.txt_4c_Nivel,    "KeyPress", THIS, "NivelKeyPress")
1805:             BINDEVENT(loc_oPg.txt_4c_Nivel,    "DblClick", THIS, "AbrirLookupNivel")
1806:             BINDEVENT(loc_oPg.txt_4c__Empenho, "KeyPress", THIS, "EmpenhoKeyPress")
1807:             BINDEVENT(loc_oPg.txt_4c__Empenho, "DblClick", THIS, "AbrirLookupEmpenho")
1808:             BINDEVENT(loc_oPg.txt_4c_EmpLanc,  "KeyPress", THIS, "EmpLancKeyPress")
1809:             BINDEVENT(loc_oPg.txt_4c_EmpLanc,  "DblClick", THIS, "AbrirLookupEmpLanc")
1810:         CATCH TO loException
1811:             MostrarErro(loException, "FormMPD.ConfigurarPgOperacao")
1812:         ENDTRY
1813:     ENDPROC
1814: 
1815:     PROCEDURE BtnSalvarClick()
1816:         LOCAL loc_lSucesso
1817:         loc_lSucesso = .F.
1818:         TRY
1819:             THIS.FormParaBO()
1820:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
1821:             IF loc_lSucesso
1822:                 THIS.this_cModoAtual = "LISTA"
1823:                 THIS.AlternarPagina(1)
1824:                 THIS.CarregarLista()
1825:             ENDIF
1826:         CATCH TO loException
1827:             MostrarErro(loException, "FormMPD.BtnSalvarClick")
1828:         ENDTRY
1829:     ENDPROC
1830: 
1831:     PROCEDURE BtnCancelarClick()
1832:         TRY
1833:             THIS.this_cModoAtual = "LISTA"
1834:             THIS.AlternarPagina(1)
1835:             THIS.CarregarLista()
1836:         CATCH TO loException
1837:             MostrarErro(loException, "FormMPD.BtnCancelarClick")
1838:         ENDTRY
1839:     ENDPROC
1840: 
1841:     PROCEDURE CmdGarqiconeClick()
1842:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
1843:         TRY
1844:             loc_cSQL = "SELECT codigos, descrs FROM SigCdIcn ORDER BY codigos"
1845:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Icn")
1846:             IF loc_nResult >= 0
1847:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
1848:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Icn"
1849:                 loc_oFrm.DefinirCursor("cursor_4c_Icn", "codigos", "descrs", CHR(205) + "cone")
1850:                 loc_oFrm.Mostrar()
1851:                 IF loc_oFrm.this_lSelecionou
1852:                     loc_oPg = THIS.pgf_4c_Paginas.Page2
1853:                     loc_oPg.txt_4c_Desc.Value = loc_oFrm.cCodigoSelecionado
1854:                 ENDIF
1855:                 IF USED("cursor_4c_Icn")
1856:                     USE IN cursor_4c_Icn
1857:                 ENDIF
1858:             ELSE
1859:                 MsgErro("Erro ao buscar " + CHR(237) + "cones.", "Erro")
1860:             ENDIF
1861:         CATCH TO loException
1862:             MostrarErro(loException, "FormMPD.CmdGarqiconeClick")
1863:         ENDTRY
1864:     ENDPROC
1865: 
1866:     PROCEDURE CmdIconeClick()
1867:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
1868:         TRY
1869:             loc_cSQL = "SELECT codigos, descrs FROM SigCdIcn ORDER BY codigos"
1870:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Icn2")
1871:             IF loc_nResult >= 0
1872:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
1873:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Icn2"
1874:                 loc_oFrm.DefinirCursor("cursor_4c_Icn2", "codigos", "descrs", CHR(205) + "cone Barra")
1875:                 loc_oFrm.Mostrar()
1876:                 IF loc_oFrm.this_lSelecionou
1877:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
1878:                     loc_oPg.txt_4c_ArqIcone.Value = loc_oFrm.cCodigoSelecionado
1879:                     IF !EMPTY(loc_oFrm.cCodigoSelecionado)
1880:                         loc_oPg.img_4c_ImgIcone.Picture = gc_4c_CaminhoIcones + ALLTRIM(loc_oFrm.cCodigoSelecionado)
1881:                     ENDIF
1882:                 ENDIF
1883:                 IF USED("cursor_4c_Icn2")
1884:                     USE IN cursor_4c_Icn2
1885:                 ENDIF
1886:             ELSE
1887:                 MsgErro("Erro ao buscar " + CHR(237) + "cones.", "Erro")
1888:             ENDIF
1889:         CATCH TO loException
1890:             MostrarErro(loException, "FormMPD.CmdIconeClick")
1891:         ENDTRY
1892:     ENDPROC
1893: 
1894:     * ============================================================
1895:     * ConfigurarPgEstoque
1896:     * ============================================================
1897:     PROTECTED PROCEDURE ConfigurarPgEstoque()
1898:         LOCAL loc_oPg
1899:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
1900:         TRY
1901:             * Shapes
1902:             loc_oPg.AddObject("shp_4c_Shape1", "Shape")
1903:             WITH loc_oPg.shp_4c_Shape1
1904:                 .Top = 84
1905:                 .Left = 5
1906:                 .Width = 671
1907:                 .Height = 72
1908:                 .Visible = .T.
1909:             ENDWITH
1910:             loc_oPg.AddObject("shp_4c_Shape3", "Shape")
1911:             WITH loc_oPg.shp_4c_Shape3
1912:                 .Top = 205
1913:                 .Left = 5
1914:                 .Width = 671
1915:                 .Height = 73
1916:                 .Visible = .T.
1917:             ENDWITH
1918:             loc_oPg.AddObject("shp_4c_Shape2", "Shape")
1919:             WITH loc_oPg.shp_4c_Shape2
1920:                 .Top = 317
1921:                 .Left = 10
1922:                 .Width = 303
1923:                 .Height = 29
1924:                 .Visible = .T.
1925:             ENDWITH
1926:             * Labels
1927:             loc_oPg.AddObject("lbl_4c_Label21", "Label")
1928:             WITH loc_oPg.lbl_4c_Label21
1929:                 .Top = 15
1930:                 .Left = 27
1931:                 .Width = 90
1932:                 .Height = 15
1933:                 .AutoSize = .F.
1934:                 .Caption = "Numera" + CHR(231) + CHR(227) + "o : "
1935:                 .BackStyle = 0
1936:                 .Visible = .T.
1937:             ENDWITH

*-- Linhas 2144 a 2460:
2144:                 .BackStyle = 0
2145:                 .Visible = .T.
2146:             ENDWITH
2147:             * OptionGroups
2148:             loc_oPg.AddObject("obj_4c_Op_Numeracao", "OptionGroup")
2149:             WITH loc_oPg.obj_4c_Op_Numeracao
2150:                 .Top = 10
2151:                 .Left = 100
2152:                 .Width = 373
2153:                 .Height = 27
2154:                 .ButtonCount = 4
2155:                 .Visible = .T.
2156:                 WITH .Buttons(1)
2157:                     .Top  = 2
2158:                     .Left = 3
2159:                     .Width = 88
2160:                     .Caption = "Manual"
2161:                     .AutoSize = .F.
2162:                 ENDWITH
2163:                 WITH .Buttons(2)
2164:                     .Top  = 2
2165:                     .Left = 94
2166:                     .Width = 88
2167:                     .Caption = "Autom" + CHR(225) + "tica"
2168:                     .AutoSize = .F.
2169:                 ENDWITH
2170:                 WITH .Buttons(3)
2171:                     .Top  = 2
2172:                     .Left = 185
2173:                     .Width = 88
2174:                     .Caption = "SubN" + CHR(237) + "vel"
2175:                     .AutoSize = .F.
2176:                 ENDWITH
2177:                 WITH .Buttons(4)
2178:                     .Top  = 2
2179:                     .Left = 276
2180:                     .Width = 88
2181:                     .Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2182:                     .AutoSize = .F.
2183:                 ENDWITH
2184:             ENDWITH
2185:             loc_oPg.AddObject("obj_4c_Op_origem", "OptionGroup")
2186:             WITH loc_oPg.obj_4c_Op_origem
2187:                 .Top = 49
2188:                 .Left = 94
2189:                 .Width = 106
2190:                 .Height = 20
2191:                 .ButtonCount = 2
2192:                 .Visible = .T.
2193:                 WITH .Buttons(1)
2194:                     .Top = 2
2195:                     .Left = 3
2196:                     .Caption = "Sim"
2197:                     .Width = 48
2198:                     .AutoSize = .F.
2199:                 ENDWITH
2200:                 WITH .Buttons(2)
2201:                     .Top = 2
2202:                     .Left = 54
2203:                     .Caption = "N" + CHR(227) + "o"
2204:                     .Width = 48
2205:                     .AutoSize = .F.
2206:                 ENDWITH
2207:             ENDWITH
2208:             loc_oPg.AddObject("obj_4c_Op_EstOrig", "OptionGroup")
2209:             WITH loc_oPg.obj_4c_Op_EstOrig
2210:                 .Top = 87
2211:                 .Left = 468
2212:                 .Width = 200
2213:                 .Height = 25
2214:                 .ButtonCount = 3
2215:                 .Visible = .T.
2216:                 WITH .Buttons(1)
2217:                     .Top = 2
2218:                     .Left = 3
2219:                     .Width = 62
2220:                     .Caption = "Entrada"
2221:                     .AutoSize = .F.
2222:                 ENDWITH
2223:                 WITH .Buttons(2)
2224:                     .Top = 2
2225:                     .Left = 68
2226:                     .Width = 62
2227:                     .Caption = "Sa" + CHR(237) + "da"
2228:                     .AutoSize = .F.
2229:                 ENDWITH
2230:                 WITH .Buttons(3)
2231:                     .Top = 2
2232:                     .Left = 133
2233:                     .Width = 62
2234:                     .Caption = "Nenhuma"
2235:                     .AutoSize = .F.
2236:                 ENDWITH
2237:             ENDWITH
2238:             loc_oPg.AddObject("obj_4c_Op_ConOSub", "OptionGroup")
2239:             WITH loc_oPg.obj_4c_Op_ConOSub
2240:                 .Top = 110
2241:                 .Left = 467
2242:                 .Width = 201
2243:                 .Height = 25
2244:                 .ButtonCount = 3
2245:                 .Visible = .T.
2246:                 WITH .Buttons(1)
2247:                     .Top = 2
2248:                     .Left = 3
2249:                     .Width = 62
2250:                     .Caption = "Origem"
2251:                     .AutoSize = .F.
2252:                 ENDWITH
2253:                 WITH .Buttons(2)
2254:                     .Top = 2
2255:                     .Left = 68
2256:                     .Width = 62
2257:                     .Caption = "Destino"
2258:                     .AutoSize = .F.
2259:                 ENDWITH
2260:                 WITH .Buttons(3)
2261:                     .Top = 2
2262:                     .Left = 133
2263:                     .Width = 62
2264:                     .Caption = "Nenhuma"
2265:                     .AutoSize = .F.
2266:                 ENDWITH
2267:             ENDWITH
2268:             loc_oPg.AddObject("obj_4c_Op_BxOEst", "OptionGroup")
2269:             WITH loc_oPg.obj_4c_Op_BxOEst
2270:                 .Top = 133
2271:                 .Left = 467
2272:                 .Width = 186
2273:                 .Height = 25
2274:                 .ButtonCount = 2
2275:                 .Visible = .T.
2276:                 WITH .Buttons(1)
2277:                     .Top = 2
2278:                     .Left = 3
2279:                     .Caption = "Prod. Acabado"
2280:                     .Width = 88
2281:                     .AutoSize = .F.
2282:                 ENDWITH
2283:                 WITH .Buttons(2)
2284:                     .Top = 2
2285:                     .Left = 94
2286:                     .Caption = "Mat. Prima"
2287:                     .Width = 88
2288:                     .AutoSize = .F.
2289:                 ENDWITH
2290:             ENDWITH
2291:             loc_oPg.AddObject("obj_4c_Op_destino", "OptionGroup")
2292:             WITH loc_oPg.obj_4c_Op_destino
2293:                 .Top = 169
2294:                 .Left = 94
2295:                 .Width = 106
2296:                 .Height = 20
2297:                 .ButtonCount = 2
2298:                 .Visible = .T.
2299:                 WITH .Buttons(1)
2300:                     .Top = 2
2301:                     .Left = 3
2302:                     .Caption = "Sim"
2303:                     .Width = 48
2304:                     .AutoSize = .F.
2305:                 ENDWITH
2306:                 WITH .Buttons(2)
2307:                     .Top = 2
2308:                     .Left = 54
2309:                     .Caption = "N" + CHR(227) + "o"
2310:                     .Width = 48
2311:                     .AutoSize = .F.
2312:                 ENDWITH
2313:             ENDWITH
2314:             loc_oPg.AddObject("obj_4c_Get_Repete", "OptionGroup")
2315:             WITH loc_oPg.obj_4c_Get_Repete
2316:                 .Top = 169
2317:                 .Left = 380
2318:                 .Width = 106
2319:                 .Height = 20
2320:                 .ButtonCount = 2
2321:                 .Visible = .T.
2322:                 WITH .Buttons(1)
2323:                     .Top = 2
2324:                     .Left = 3
2325:                     .Caption = "Sim"
2326:                     .Width = 48
2327:                     .AutoSize = .F.
2328:                 ENDWITH
2329:                 WITH .Buttons(2)
2330:                     .Top = 2
2331:                     .Left = 54
2332:                     .Caption = "N" + CHR(227) + "o"
2333:                     .Width = 48
2334:                     .AutoSize = .F.
2335:                 ENDWITH
2336:             ENDWITH
2337:             loc_oPg.AddObject("obj_4c_Op_EstDest", "OptionGroup")
2338:             WITH loc_oPg.obj_4c_Op_EstDest
2339:                 .Top = 208
2340:                 .Left = 468
2341:                 .Width = 200
2342:                 .Height = 25
2343:                 .ButtonCount = 3
2344:                 .Visible = .T.
2345:                 WITH .Buttons(1)
2346:                     .Top = 2
2347:                     .Left = 3
2348:                     .Width = 62
2349:                     .Caption = "Entrada"
2350:                     .AutoSize = .F.
2351:                 ENDWITH
2352:                 WITH .Buttons(2)
2353:                     .Top = 2
2354:                     .Left = 68
2355:                     .Width = 62
2356:                     .Caption = "Sa" + CHR(237) + "da"
2357:                     .AutoSize = .F.
2358:                 ENDWITH
2359:                 WITH .Buttons(3)
2360:                     .Top = 2
2361:                     .Left = 133
2362:                     .Width = 62
2363:                     .Caption = "Nenhuma"
2364:                     .AutoSize = .F.
2365:                 ENDWITH
2366:             ENDWITH
2367:             loc_oPg.AddObject("obj_4c_Op_ConDSub", "OptionGroup")
2368:             WITH loc_oPg.obj_4c_Op_ConDSub
2369:                 .Top = 231
2370:                 .Left = 468
2371:                 .Width = 200
2372:                 .Height = 25
2373:                 .ButtonCount = 3
2374:                 .Visible = .T.
2375:                 WITH .Buttons(1)
2376:                     .Top = 2
2377:                     .Left = 3
2378:                     .Width = 62
2379:                     .Caption = "Origem"
2380:                     .AutoSize = .F.
2381:                 ENDWITH
2382:                 WITH .Buttons(2)
2383:                     .Top = 2
2384:                     .Left = 68
2385:                     .Width = 62
2386:                     .Caption = "Destino"
2387:                     .AutoSize = .F.
2388:                 ENDWITH
2389:                 WITH .Buttons(3)
2390:                     .Top = 2
2391:                     .Left = 133
2392:                     .Width = 62
2393:                     .Caption = "Nenhuma"
2394:                     .AutoSize = .F.
2395:                 ENDWITH
2396:             ENDWITH
2397:             loc_oPg.AddObject("obj_4c_Op_BxDEst", "OptionGroup")
2398:             WITH loc_oPg.obj_4c_Op_BxDEst
2399:                 .Top = 254
2400:                 .Left = 468
2401:                 .Width = 187
2402:                 .Height = 25
2403:                 .ButtonCount = 2
2404:                 .Visible = .T.
2405:                 WITH .Buttons(1)
2406:                     .Top = 2
2407:                     .Left = 3
2408:                     .Caption = "Prod. Acabado"
2409:                     .Width = 88
2410:                     .AutoSize = .F.
2411:                 ENDWITH
2412:                 WITH .Buttons(2)
2413:                     .Top = 2
2414:                     .Left = 94
2415:                     .Caption = "Mat. Prima"
2416:                     .Width = 88
2417:                     .AutoSize = .F.
2418:                 ENDWITH
2419:             ENDWITH
2420:             loc_oPg.AddObject("obj_4c_Op_vende", "OptionGroup")
2421:             WITH loc_oPg.obj_4c_Op_vende
2422:                 .Top = 282
2423:                 .Left = 104
2424:                 .Width = 106
2425:                 .Height = 20
2426:                 .ButtonCount = 2
2427:                 .Visible = .T.
2428:                 WITH .Buttons(1)
2429:                     .Top = 2
2430:                     .Left = 3
2431:                     .Caption = "Sim"
2432:                     .Width = 48
2433:                     .AutoSize = .F.
2434:                 ENDWITH
2435:                 WITH .Buttons(2)
2436:                     .Top = 2
2437:                     .Left = 54
2438:                     .Caption = "N" + CHR(227) + "o"
2439:                     .Width = 48
2440:                     .AutoSize = .F.
2441:                 ENDWITH
2442:             ENDWITH
2443:             * CheckBoxes
2444:             loc_oPg.AddObject("chk_4c_Chk_Grupoo", "CheckBox")
2445:             WITH loc_oPg.chk_4c_Chk_Grupoo
2446:                 .Top = 89
2447:                 .Left = 53
2448:                 .Width = 20
2449:                 .Height = 19
2450:                 .Caption = ""
2451:                 .Value = 0
2452:                 .Visible = .T.
2453:             ENDWITH
2454:             loc_oPg.AddObject("chk_4c_Chk_Contao", "CheckBox")
2455:             WITH loc_oPg.chk_4c_Chk_Contao
2456:                 .Top = 110
2457:                 .Left = 53
2458:                 .Width = 20
2459:                 .Height = 19
2460:                 .Caption = ""

*-- Linhas 2646 a 2714:
2646:                     USE IN cursor_4c_Toi
2647:                 ENDIF
2648:             ENDIF
2649:             * BINDEVENTs lookups Estoque
2650:             BINDEVENT(loc_oPg.txt_4c_GrupoOrig, "KeyPress", THIS, "GrupoOrigKeyPress")
2651:             BINDEVENT(loc_oPg.txt_4c_GrupoOrig, "DblClick", THIS, "AbrirLookupGrupoOrig")
2652:             BINDEVENT(loc_oPg.txt_4c_ContaOrig, "KeyPress", THIS, "ContaOrigKeyPress")
2653:             BINDEVENT(loc_oPg.txt_4c_ContaOrig, "DblClick", THIS, "AbrirLookupContaOrig")
2654:             BINDEVENT(loc_oPg.txt_4c_GrupoDest, "KeyPress", THIS, "GrupoDestKeyPress")
2655:             BINDEVENT(loc_oPg.txt_4c_GrupoDest, "DblClick", THIS, "AbrirLookupGrupoDest")
2656:             BINDEVENT(loc_oPg.txt_4c_ContaDest, "KeyPress", THIS, "ContaDestKeyPress")
2657:             BINDEVENT(loc_oPg.txt_4c_ContaDest, "DblClick", THIS, "AbrirLookupContaDest")
2658:             BINDEVENT(loc_oPg.txt_4c_GrupoVend, "KeyPress", THIS, "GrupoVendKeyPress")
2659:             BINDEVENT(loc_oPg.txt_4c_GrupoVend, "DblClick", THIS, "AbrirLookupGrupoVend")
2660:             * BINDEVENTs comportamento interativo Estoque
2661:             BINDEVENT(loc_oPg.obj_4c_Op_origem,  "InteractiveChange", THIS, "OpOrigemChange")
2662:             BINDEVENT(loc_oPg.obj_4c_Op_destino, "InteractiveChange", THIS, "OpDestinoChange")
2663:             BINDEVENT(loc_oPg.obj_4c_Op_vende,   "InteractiveChange", THIS, "OpVendeChange")
2664:             BINDEVENT(loc_oPg.obj_4c_Op_EstOrig, "InteractiveChange", THIS, "OpEstOrigChange")
2665:             BINDEVENT(loc_oPg.obj_4c_Op_EstDest, "InteractiveChange", THIS, "OpEstDestChange")
2666:         CATCH TO loException
2667:             MostrarErro(loException, "FormMPD.ConfigurarPgEstoque")
2668:         ENDTRY
2669:     ENDPROC
2670: 
2671:     * ============================================================
2672:     * ConfigurarPgComponente
2673:     * ============================================================
2674:     PROTECTED PROCEDURE ConfigurarPgComponente()
2675:         LOCAL loc_oPg
2676:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
2677:         TRY
2678:             * Labels
2679:             loc_oPg.AddObject("lbl_4c_Label15", "Label")
2680:             WITH loc_oPg.lbl_4c_Label15
2681:                 .Top = 13
2682:                 .Left = 38
2683:                 .Width = 145
2684:                 .Height = 15
2685:                 .AutoSize = .F.
2686:                 .Caption = "Grade Ordens de Produ" + CHR(231) + CHR(227) + "o : "
2687:                 .BackStyle = 0
2688:                 .Visible = .T.
2689:             ENDWITH
2690:             loc_oPg.AddObject("lbl_4c_Label14", "Label")
2691:             WITH loc_oPg.lbl_4c_Label14
2692:                 .Top = 33
2693:                 .Left = 55
2694:                 .Width = 130
2695:                 .Height = 15
2696:                 .AutoSize = .F.
2697:                 .Caption = "Grade de Componentes : "
2698:                 .BackStyle = 0
2699:                 .Visible = .T.
2700:             ENDWITH
2701:             loc_oPg.AddObject("lbl_4c_Label5", "Label")
2702:             WITH loc_oPg.lbl_4c_Label5
2703:                 .Top = 53
2704:                 .Left = 64
2705:                 .Width = 115
2706:                 .Height = 15
2707:                 .AutoSize = .F.
2708:                 .Caption = "Agrupa Componentes : "
2709:                 .BackStyle = 0
2710:                 .Visible = .T.
2711:             ENDWITH
2712:             loc_oPg.AddObject("lbl_4c_Label8", "Label")
2713:             WITH loc_oPg.lbl_4c_Label8
2714:                 .Top = 73

*-- Linhas 3028 a 3602:
3028:                 .BackStyle = 0
3029:                 .Visible = .T.
3030:             ENDWITH
3031:             * OptionGroups
3032:             loc_oPg.AddObject("obj_4c_Op_grprod", "OptionGroup")
3033:             WITH loc_oPg.obj_4c_Op_grprod
3034:                 .Top = 9
3035:                 .Left = 183
3036:                 .Width = 92
3037:                 .Height = 25
3038:                 .ButtonCount = 2
3039:                 .Visible = .T.
3040:                 WITH .Buttons(1)
3041:                     .Top = 2
3042:                     .Left = 3
3043:                     .Caption = "Sim"
3044:                     .Width = 40
3045:                     .AutoSize = .F.
3046:                 ENDWITH
3047:                 WITH .Buttons(2)
3048:                     .Top = 2
3049:                     .Left = 46
3050:                     .Caption = "N" + CHR(227) + "o"
3051:                     .Width = 40
3052:                     .AutoSize = .F.
3053:                 ENDWITH
3054:             ENDWITH
3055:             loc_oPg.AddObject("obj_4c_Op_grcomp", "OptionGroup")
3056:             WITH loc_oPg.obj_4c_Op_grcomp
3057:                 .Top = 29
3058:                 .Left = 183
3059:                 .Width = 92
3060:                 .Height = 25
3061:                 .ButtonCount = 2
3062:                 .Visible = .T.
3063:                 WITH .Buttons(1)
3064:                     .Top = 2
3065:                     .Left = 3
3066:                     .Caption = "Sim"
3067:                     .Width = 40
3068:                     .AutoSize = .F.
3069:                 ENDWITH
3070:                 WITH .Buttons(2)
3071:                     .Top = 2
3072:                     .Left = 46
3073:                     .Caption = "N" + CHR(227) + "o"
3074:                     .Width = 40
3075:                     .AutoSize = .F.
3076:                 ENDWITH
3077:             ENDWITH
3078:             loc_oPg.AddObject("obj_4c_Op_compagru", "OptionGroup")
3079:             WITH loc_oPg.obj_4c_Op_compagru
3080:                 .Top = 49
3081:                 .Left = 183
3082:                 .Width = 178
3083:                 .Height = 25
3084:                 .ButtonCount = 3
3085:                 .Visible = .T.
3086:                 WITH .Buttons(1)
3087:                     .Top = 2
3088:                     .Left = 3
3089:                     .Width = 55
3090:                     .AutoSize = .F.
3091:                 ENDWITH
3092:                 WITH .Buttons(2)
3093:                     .Top = 2
3094:                     .Left = 61
3095:                     .Width = 55
3096:                     .AutoSize = .F.
3097:                 ENDWITH
3098:                 WITH .Buttons(3)
3099:                     .Top = 2
3100:                     .Left = 119
3101:                     .Width = 55
3102:                     .AutoSize = .F.
3103:                 ENDWITH
3104:             ENDWITH
3105:             loc_oPg.AddObject("obj_4c_Op_SepPedra", "OptionGroup")
3106:             WITH loc_oPg.obj_4c_Op_SepPedra
3107:                 .Top = 69
3108:                 .Left = 183
3109:                 .Width = 140
3110:                 .Height = 42
3111:                 .ButtonCount = 4
3112:                 .Visible = .T.
3113:                 WITH .Buttons(1)
3114:                     .Left = 3
3115:                     .Top = 2
3116:                     .Width = 65
3117:                     .Height = 14
3118:                     .AutoSize = .F.
3119:                 ENDWITH
3120:                 WITH .Buttons(2)
3121:                     .Left = 71
3122:                     .Top = 2
3123:                     .Width = 65
3124:                     .Height = 14
3125:                     .AutoSize = .F.
3126:                 ENDWITH
3127:                 WITH .Buttons(3)
3128:                     .Left = 3
3129:                     .Top = 22
3130:                     .Width = 65
3131:                     .Height = 14
3132:                     .AutoSize = .F.
3133:                 ENDWITH
3134:                 WITH .Buttons(4)
3135:                     .Left = 71
3136:                     .Top = 22
3137:                     .Width = 65
3138:                     .Height = 14
3139:                     .AutoSize = .F.
3140:                 ENDWITH
3141:             ENDWITH
3142:             loc_oPg.AddObject("obj_4c_OptBxPedFins", "OptionGroup")
3143:             WITH loc_oPg.obj_4c_OptBxPedFins
3144:                 .Top = 142
3145:                 .Left = 182
3146:                 .Width = 107
3147:                 .Height = 25
3148:                 .ButtonCount = 2
3149:                 .Visible = .T.
3150:                 WITH .Buttons(1)
3151:                     .Top = 2
3152:                     .Left = 3
3153:                     .Caption = "Sim"
3154:                     .Width = 48
3155:                     .AutoSize = .F.
3156:                 ENDWITH
3157:                 WITH .Buttons(2)
3158:                     .Top = 2
3159:                     .Left = 54
3160:                     .Caption = "N" + CHR(227) + "o"
3161:                     .Width = 48
3162:                     .AutoSize = .F.
3163:                 ENDWITH
3164:             ENDWITH
3165:             loc_oPg.AddObject("obj_4c_Op_GrTrans", "OptionGroup")
3166:             WITH loc_oPg.obj_4c_Op_GrTrans
3167:                 .Top = 270
3168:                 .Left = 182
3169:                 .Width = 133
3170:                 .Height = 40
3171:                 .ButtonCount = 3
3172:                 .Visible = .T.
3173:                 WITH .Buttons(1)
3174:                     .Left = 3
3175:                     .Top = 2
3176:                     .Width = 40
3177:                     .Height = 14
3178:                     .AutoSize = .F.
3179:                 ENDWITH
3180:                 WITH .Buttons(2)
3181:                     .Left = 46
3182:                     .Top = 2
3183:                     .Width = 40
3184:                     .Height = 14
3185:                     .AutoSize = .F.
3186:                 ENDWITH
3187:                 WITH .Buttons(3)
3188:                     .Left = 3
3189:                     .Top = 22
3190:                     .Width = 83
3191:                     .Height = 14
3192:                     .AutoSize = .F.
3193:                 ENDWITH
3194:             ENDWITH
3195:             loc_oPg.AddObject("obj_4c_ObjChkQP", "OptionGroup")
3196:             WITH loc_oPg.obj_4c_ObjChkQP
3197:                 .Top = 306
3198:                 .Left = 182
3199:                 .Width = 171
3200:                 .Height = 39
3201:                 .ButtonCount = 4
3202:                 .Visible = .T.
3203:                 WITH .Buttons(1)
3204:                     .Left = 3
3205:                     .Top = 2
3206:                     .Width = 80
3207:                     .Height = 14
3208:                     .AutoSize = .F.
3209:                 ENDWITH
3210:                 WITH .Buttons(2)
3211:                     .Left = 86
3212:                     .Top = 2
3213:                     .Width = 80
3214:                     .Height = 14
3215:                     .AutoSize = .F.
3216:                 ENDWITH
3217:                 WITH .Buttons(3)
3218:                     .Left = 3
3219:                     .Top = 22
3220:                     .Width = 80
3221:                     .Height = 14
3222:                     .AutoSize = .F.
3223:                 ENDWITH
3224:                 WITH .Buttons(4)
3225:                     .Left = 86
3226:                     .Top = 22
3227:                     .Width = 80
3228:                     .Height = 14
3229:                     .AutoSize = .F.
3230:                 ENDWITH
3231:             ENDWITH
3232:             loc_oPg.AddObject("obj_4c_ObjReinop", "OptionGroup")
3233:             WITH loc_oPg.obj_4c_ObjReinop
3234:                 .Top = 378
3235:                 .Left = 182
3236:                 .Width = 204
3237:                 .Height = 25
3238:                 .ButtonCount = 3
3239:                 .Visible = .T.
3240:                 WITH .Buttons(1)
3241:                     .Top = 2
3242:                     .Left = 3
3243:                     .Width = 62
3244:                     .AutoSize = .F.
3245:                 ENDWITH
3246:                 WITH .Buttons(2)
3247:                     .Top = 2
3248:                     .Left = 68
3249:                     .Width = 62
3250:                     .AutoSize = .F.
3251:                 ENDWITH
3252:                 WITH .Buttons(3)
3253:                     .Top = 2
3254:                     .Left = 133
3255:                     .Width = 62
3256:                     .AutoSize = .F.
3257:                 ENDWITH
3258:             ENDWITH
3259:             loc_oPg.AddObject("obj_4c_Op_etiq", "OptionGroup")
3260:             WITH loc_oPg.obj_4c_Op_etiq
3261:                 .Top = 356
3262:                 .Left = 182
3263:                 .Width = 275
3264:                 .Height = 25
3265:                 .ButtonCount = 4
3266:                 .Visible = .T.
3267:                 WITH .Buttons(1)
3268:                     .Top = 2
3269:                     .Left = 3
3270:                     .Width = 65
3271:                     .AutoSize = .F.
3272:                 ENDWITH
3273:                 WITH .Buttons(2)
3274:                     .Top = 2
3275:                     .Left = 71
3276:                     .Width = 65
3277:                     .AutoSize = .F.
3278:                 ENDWITH
3279:                 WITH .Buttons(3)
3280:                     .Top = 2
3281:                     .Left = 139
3282:                     .Width = 65
3283:                     .AutoSize = .F.
3284:                 ENDWITH
3285:                 WITH .Buttons(4)
3286:                     .Top = 2
3287:                     .Left = 207
3288:                     .Width = 65
3289:                     .AutoSize = .F.
3290:                 ENDWITH
3291:             ENDWITH
3292:             loc_oPg.AddObject("obj_4c_Opt_quebraimp", "OptionGroup")
3293:             WITH loc_oPg.obj_4c_Opt_quebraimp
3294:                 .Top = 412
3295:                 .Left = 182
3296:                 .Width = 92
3297:                 .Height = 25
3298:                 .ButtonCount = 2
3299:                 .Visible = .T.
3300:                 WITH .Buttons(1)
3301:                     .Top = 2
3302:                     .Left = 3
3303:                     .Caption = "Sim"
3304:                     .Width = 40
3305:                     .AutoSize = .F.
3306:                 ENDWITH
3307:                 WITH .Buttons(2)
3308:                     .Top = 2
3309:                     .Left = 46
3310:                     .Caption = "N" + CHR(227) + "o"
3311:                     .Width = 40
3312:                     .AutoSize = .F.
3313:                 ENDWITH
3314:             ENDWITH
3315:             loc_oPg.AddObject("obj_4c_Opt_codlib", "OptionGroup")
3316:             WITH loc_oPg.obj_4c_Opt_codlib
3317:                 .Top = 229
3318:                 .Left = 182
3319:                 .Width = 92
3320:                 .Height = 25
3321:                 .ButtonCount = 2
3322:                 .Visible = .T.
3323:                 WITH .Buttons(1)
3324:                     .Top = 2
3325:                     .Left = 3
3326:                     .Caption = "Sim"
3327:                     .Width = 40
3328:                     .AutoSize = .F.
3329:                 ENDWITH
3330:                 WITH .Buttons(2)
3331:                     .Top = 2
3332:                     .Left = 46
3333:                     .Caption = "N" + CHR(227) + "o"
3334:                     .Width = 40
3335:                     .AutoSize = .F.
3336:                 ENDWITH
3337:             ENDWITH
3338:             loc_oPg.AddObject("obj_4c_Opt_cravacera", "OptionGroup")
3339:             WITH loc_oPg.obj_4c_Opt_cravacera
3340:                 .Top = 250
3341:                 .Left = 182
3342:                 .Width = 92
3343:                 .Height = 25
3344:                 .ButtonCount = 2
3345:                 .Visible = .T.
3346:                 WITH .Buttons(1)
3347:                     .Top = 2
3348:                     .Left = 3
3349:                     .Caption = "Sim"
3350:                     .Width = 40
3351:                     .AutoSize = .F.
3352:                 ENDWITH
3353:                 WITH .Buttons(2)
3354:                     .Top = 2
3355:                     .Left = 46
3356:                     .Caption = "N" + CHR(227) + "o"
3357:                     .Width = 40
3358:                     .AutoSize = .F.
3359:                 ENDWITH
3360:             ENDWITH
3361:             loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
3362:             WITH loc_oPg.obj_4c_Fwoption2
3363:                 .Top = 210
3364:                 .Left = 181
3365:                 .Width = 92
3366:                 .Height = 25
3367:                 .ButtonCount = 2
3368:                 .Visible = .T.
3369:                 WITH .Buttons(1)
3370:                     .Top = 2
3371:                     .Left = 3
3372:                     .Caption = "Sim"
3373:                     .Width = 40
3374:                     .AutoSize = .F.
3375:                 ENDWITH
3376:                 WITH .Buttons(2)
3377:                     .Top = 2
3378:                     .Left = 46
3379:                     .Caption = "N" + CHR(227) + "o"
3380:                     .Width = 40
3381:                     .AutoSize = .F.
3382:                 ENDWITH
3383:             ENDWITH
3384:             * Right column OptionGroups
3385:             loc_oPg.AddObject("obj_4c_Opc_Chkf", "OptionGroup")
3386:             WITH loc_oPg.obj_4c_Opc_Chkf
3387:                 .Top = 100
3388:                 .Left = 626
3389:                 .Width = 110
3390:                 .Height = 25
3391:                 .ButtonCount = 2
3392:                 .Visible = .T.
3393:                 WITH .Buttons(1)
3394:                     .Top = 2
3395:                     .Left = 3
3396:                     .Caption = "Sim"
3397:                     .Width = 48
3398:                     .AutoSize = .F.
3399:                 ENDWITH
3400:                 WITH .Buttons(2)
3401:                     .Top = 2
3402:                     .Left = 54
3403:                     .Caption = "N" + CHR(227) + "o"
3404:                     .Width = 48
3405:                     .AutoSize = .F.
3406:                 ENDWITH
3407:             ENDWITH
3408:             loc_oPg.AddObject("obj_4c_Opc_fix", "OptionGroup")
3409:             WITH loc_oPg.obj_4c_Opc_fix
3410:                 .Top = 119
3411:                 .Left = 626
3412:                 .Width = 202
3413:                 .Height = 25
3414:                 .ButtonCount = 3
3415:                 .Visible = .T.
3416:                 WITH .Buttons(1)
3417:                     .Top = 2
3418:                     .Left = 3
3419:                     .Width = 62
3420:                     .AutoSize = .F.
3421:                 ENDWITH
3422:                 WITH .Buttons(2)
3423:                     .Top = 2
3424:                     .Left = 68
3425:                     .Width = 62
3426:                     .AutoSize = .F.
3427:                 ENDWITH
3428:                 WITH .Buttons(3)
3429:                     .Top = 2
3430:                     .Left = 133
3431:                     .Width = 62
3432:                     .AutoSize = .F.
3433:                 ENDWITH
3434:             ENDWITH
3435:             loc_oPg.AddObject("obj_4c_Opc_PagSer", "OptionGroup")
3436:             WITH loc_oPg.obj_4c_Opc_PagSer
3437:                 .Top = 155
3438:                 .Left = 626
3439:                 .Width = 206
3440:                 .Height = 25
3441:                 .ButtonCount = 3
3442:                 .Visible = .T.
3443:                 WITH .Buttons(1)
3444:                     .Top = 2
3445:                     .Left = 3
3446:                     .Width = 62
3447:                     .AutoSize = .F.
3448:                 ENDWITH
3449:                 WITH .Buttons(2)
3450:                     .Top = 2
3451:                     .Left = 68
3452:                     .Width = 62
3453:                     .AutoSize = .F.
3454:                 ENDWITH
3455:                 WITH .Buttons(3)
3456:                     .Top = 2
3457:                     .Left = 133
3458:                     .Width = 62
3459:                     .AutoSize = .F.
3460:                 ENDWITH
3461:             ENDWITH
3462:             loc_oPg.AddObject("obj_4c_Opc_mens", "OptionGroup")
3463:             WITH loc_oPg.obj_4c_Opc_mens
3464:                 .Top = 175
3465:                 .Left = 626
3466:                 .Width = 110
3467:                 .Height = 25
3468:                 .ButtonCount = 2
3469:                 .Visible = .T.
3470:                 WITH .Buttons(1)
3471:                     .Top = 2
3472:                     .Left = 3
3473:                     .Caption = "Sim"
3474:                     .Width = 48
3475:                     .AutoSize = .F.
3476:                 ENDWITH
3477:                 WITH .Buttons(2)
3478:                     .Top = 2
3479:                     .Left = 54
3480:                     .Caption = "N" + CHR(227) + "o"
3481:                     .Width = 48
3482:                     .AutoSize = .F.
3483:                 ENDWITH
3484:             ENDWITH
3485:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
3486:             WITH loc_oPg.obj_4c_Fwoption1
3487:                 .Top = 215
3488:                 .Left = 626
3489:                 .Width = 209
3490:                 .Height = 25
3491:                 .ButtonCount = 2
3492:                 .Visible = .T.
3493:                 WITH .Buttons(1)
3494:                     .Top = 2
3495:                     .Left = 3
3496:                     .Caption = "Sim"
3497:                     .Width = 96
3498:                     .AutoSize = .F.
3499:                 ENDWITH
3500:                 WITH .Buttons(2)
3501:                     .Top = 2
3502:                     .Left = 102
3503:                     .Caption = "N" + CHR(227) + "o"
3504:                     .Width = 96
3505:                     .AutoSize = .F.
3506:                 ENDWITH
3507:             ENDWITH
3508:             loc_oPg.AddObject("obj_4c_Opc_env", "OptionGroup")
3509:             WITH loc_oPg.obj_4c_Opc_env
3510:                 .Top = 195
3511:                 .Left = 626
3512:                 .Width = 209
3513:                 .Height = 25
3514:                 .ButtonCount = 3
3515:                 .Visible = .T.
3516:                 WITH .Buttons(1)
3517:                     .Top = 2
3518:                     .Left = 3
3519:                     .Width = 62
3520:                     .AutoSize = .F.
3521:                 ENDWITH
3522:                 WITH .Buttons(2)
3523:                     .Top = 2
3524:                     .Left = 68
3525:                     .Width = 62
3526:                     .AutoSize = .F.
3527:                 ENDWITH
3528:                 WITH .Buttons(3)
3529:                     .Top = 2
3530:                     .Left = 133
3531:                     .Width = 62
3532:                     .AutoSize = .F.
3533:                 ENDWITH
3534:             ENDWITH
3535:             loc_oPg.AddObject("obj_4c_Opc_pesobal", "OptionGroup")
3536:             WITH loc_oPg.obj_4c_Opc_pesobal
3537:                 .Top = 236
3538:                 .Left = 626
3539:                 .Width = 209
3540:                 .Height = 25
3541:                 .ButtonCount = 3
3542:                 .Visible = .T.
3543:                 WITH .Buttons(1)
3544:                     .Top = 2
3545:                     .Left = 3
3546:                     .Width = 62
3547:                     .AutoSize = .F.
3548:                 ENDWITH
3549:                 WITH .Buttons(2)
3550:                     .Top = 2
3551:                     .Left = 68
3552:                     .Width = 62
3553:                     .AutoSize = .F.
3554:                 ENDWITH
3555:                 WITH .Buttons(3)
3556:                     .Top = 2
3557:                     .Left = 133
3558:                     .Width = 62
3559:                     .AutoSize = .F.
3560:                 ENDWITH
3561:             ENDWITH
3562:             loc_oPg.AddObject("obj_4c_Chk_TrfPeso", "OptionGroup")
3563:             WITH loc_oPg.obj_4c_Chk_TrfPeso
3564:                 .Top = 253
3565:                 .Left = 626
3566:                 .Width = 203
3567:                 .Height = 87
3568:                 .ButtonCount = 7
3569:                 .Visible = .T.
3570:                 WITH .Buttons(1)
3571:                     .Left = 3
3572:                     .Top = 2
3573:                     .Width = 95
3574:                     .Height = 14
3575:                     .AutoSize = .F.
3576:                 ENDWITH
3577:                 WITH .Buttons(2)
3578:                     .Left = 101
3579:                     .Top = 2
3580:                     .Width = 95
3581:                     .Height = 14
3582:                     .AutoSize = .F.
3583:                 ENDWITH
3584:                 WITH .Buttons(3)
3585:                     .Left = 3
3586:                     .Top = 18
3587:                     .Width = 95
3588:                     .Height = 14
3589:                     .AutoSize = .F.
3590:                 ENDWITH
3591:                 WITH .Buttons(4)
3592:                     .Left = 101
3593:                     .Top = 18
3594:                     .Width = 95
3595:                     .Height = 14
3596:                     .AutoSize = .F.
3597:                 ENDWITH
3598:                 WITH .Buttons(5)
3599:                     .Left = 3
3600:                     .Top = 34
3601:                     .Width = 95
3602:                     .Height = 14

*-- Linhas 3617 a 3710:
3617:                     .AutoSize = .F.
3618:                 ENDWITH
3619:             ENDWITH
3620:             loc_oPg.AddObject("obj_4c_Optqtdneg", "OptionGroup")
3621:             WITH loc_oPg.obj_4c_Optqtdneg
3622:                 .Top = 351
3623:                 .Left = 626
3624:                 .Width = 291
3625:                 .Height = 25
3626:                 .ButtonCount = 3
3627:                 .Visible = .T.
3628:                 WITH .Buttons(1)
3629:                     .Top = 2
3630:                     .Left = 3
3631:                     .Width = 90
3632:                     .AutoSize = .F.
3633:                 ENDWITH
3634:                 WITH .Buttons(2)
3635:                     .Top = 2
3636:                     .Left = 96
3637:                     .Width = 90
3638:                     .AutoSize = .F.
3639:                 ENDWITH
3640:                 WITH .Buttons(3)
3641:                     .Top = 2
3642:                     .Left = 189
3643:                     .Width = 90
3644:                     .AutoSize = .F.
3645:                 ENDWITH
3646:             ENDWITH
3647:             loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
3648:             WITH loc_oPg.obj_4c_Fwoption3
3649:                 .Top = 370
3650:                 .Left = 626
3651:                 .Width = 110
3652:                 .Height = 25
3653:                 .ButtonCount = 2
3654:                 .Visible = .T.
3655:                 WITH .Buttons(1)
3656:                     .Top = 2
3657:                     .Left = 3
3658:                     .Caption = "Sim"
3659:                     .Width = 48
3660:                     .AutoSize = .F.
3661:                 ENDWITH
3662:                 WITH .Buttons(2)
3663:                     .Top = 2
3664:                     .Left = 54
3665:                     .Caption = "N" + CHR(227) + "o"
3666:                     .Width = 48
3667:                     .AutoSize = .F.
3668:                 ENDWITH
3669:             ENDWITH
3670:             loc_oPg.AddObject("obj_4c_OptMatPrncDif", "OptionGroup")
3671:             WITH loc_oPg.obj_4c_OptMatPrncDif
3672:                 .Top = 390
3673:                 .Left = 627
3674:                 .Width = 110
3675:                 .Height = 25
3676:                 .ButtonCount = 2
3677:                 .Visible = .T.
3678:                 WITH .Buttons(1)
3679:                     .Top = 2
3680:                     .Left = 3
3681:                     .Caption = "Sim"
3682:                     .Width = 48
3683:                     .AutoSize = .F.
3684:                 ENDWITH
3685:                 WITH .Buttons(2)
3686:                     .Top = 2
3687:                     .Left = 54
3688:                     .Caption = "N" + CHR(227) + "o"
3689:                     .Width = 48
3690:                     .AutoSize = .F.
3691:                 ENDWITH
3692:             ENDWITH
3693:             * CheckBoxes
3694:             loc_oPg.AddObject("chk_4c_ChkCarQtde", "CheckBox")
3695:             WITH loc_oPg.chk_4c_ChkCarQtde
3696:                 .Top = 105
3697:                 .Left = 199
3698:                 .Width = 160
3699:                 .Height = 19
3700:                 .Caption = "N" + CHR(227) + "o carrega Qtde e Peso"
3701:                 .Value = 0
3702:                 .Visible = .T.
3703:             ENDWITH
3704:             loc_oPg.AddObject("chk_4c_OptChkPeso", "CheckBox")
3705:             WITH loc_oPg.chk_4c_OptChkPeso
3706:                 .Top = 339
3707:                 .Left = 198
3708:                 .Width = 80
3709:                 .Height = 19
3710:                 .Caption = "Checa peso"

*-- Linhas 3818 a 3878:
3818:                 .AddItem("+")
3819:                 .AddItem("-")
3820:             ENDWITH
3821:             * BINDEVENTs lookups Componente
3822:             BINDEVENT(loc_oPg.txt_4c_TpPadrao, "KeyPress", THIS, "TpPadraoKeyPress")
3823:             BINDEVENT(loc_oPg.txt_4c_TpPadrao, "DblClick", THIS, "AbrirLookupTpPadrao")
3824:             BINDEVENT(loc_oPg.txt_4c_Retalho,  "KeyPress", THIS, "RetalhoKeyPress")
3825:             BINDEVENT(loc_oPg.txt_4c_Retalho,  "DblClick", THIS, "AbrirLookupRetalho")
3826:             BINDEVENT(loc_oPg.txt_4c_GrupoPcc, "KeyPress", THIS, "GrupoPccKeyPress")
3827:             BINDEVENT(loc_oPg.txt_4c_GrupoPcc, "DblClick", THIS, "AbrirLookupGrupoPcc")
3828:             BINDEVENT(loc_oPg.txt_4c__produto,  "KeyPress", THIS, "ProdutoKeyPress")
3829:             BINDEVENT(loc_oPg.txt_4c__produto,  "DblClick", THIS, "AbrirLookupProduto")
3830:         CATCH TO loException
3831:             MostrarErro(loException, "FormMPD.ConfigurarPgComponente")
3832:         ENDTRY
3833:     ENDPROC
3834: 
3835:     * ============================================================
3836:     * ConfigurarPgDocumento
3837:     * ============================================================
3838:     PROTECTED PROCEDURE ConfigurarPgDocumento()
3839:         LOCAL loc_oPg
3840:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page4
3841:         TRY
3842:             loc_oPg.AddObject("shp_4c_Shape1", "Shape")
3843:             WITH loc_oPg.shp_4c_Shape1
3844:                 .Top           = 26
3845:                 .Left          = 23
3846:                 .Width         = 329
3847:                 .Height        = 131
3848:                 .BackStyle     = 0
3849:                 .SpecialEffect = 0
3850:                 .Visible       = .T.
3851:             ENDWITH
3852:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
3853:             WITH loc_oPg.lbl_4c_Label25
3854:                 .Top      = 35
3855:                 .Left     = 33
3856:                 .Width    = 119
3857:                 .Height   = 15
3858:                 .AutoSize = .F.
3859:                 .FontBold = .T.
3860:                 .Caption  = "Impress" + CHR(227) + "o de Boleto"
3861:                 .BackStyle = 0
3862:                 .Visible  = .T.
3863:             ENDWITH
3864:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
3865:             WITH loc_oPg.lbl_4c_Label1
3866:                 .Top = 69
3867:                 .Left = 88
3868:                 .Width = 64
3869:                 .Height = 15
3870:                 .AutoSize = .F.
3871:                 .Caption = "Imprimir OP :"
3872:                 .BackStyle = 0
3873:                 .Visible = .T.
3874:             ENDWITH
3875:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
3876:             WITH loc_oPg.lbl_4c_Label2
3877:                 .Top = 95
3878:                 .Left = 64

*-- Linhas 3894 a 4021:
3894:                 .BackStyle = 0
3895:                 .Visible = .T.
3896:             ENDWITH
3897:             loc_oPg.AddObject("obj_4c_Optiongroup1", "OptionGroup")
3898:             WITH loc_oPg.obj_4c_Optiongroup1
3899:                 .Top = 64
3900:                 .Left = 176
3901:                 .Width = 102
3902:                 .Height = 26
3903:                 .ButtonCount = 2
3904:                 .Visible = .T.
3905:                 WITH .Buttons(1)
3906:                     .Top = 2
3907:                     .Left = 3
3908:                     .Caption = "Sim"
3909:                     .Width = 44
3910:                     .AutoSize = .F.
3911:                 ENDWITH
3912:                 WITH .Buttons(2)
3913:                     .Top = 2
3914:                     .Left = 50
3915:                     .Caption = "N" + CHR(227) + "o"
3916:                     .Width = 44
3917:                     .AutoSize = .F.
3918:                 ENDWITH
3919:             ENDWITH
3920:             loc_oPg.AddObject("obj_4c_Optiongroup2", "OptionGroup")
3921:             WITH loc_oPg.obj_4c_Optiongroup2
3922:                 .Top = 90
3923:                 .Left = 176
3924:                 .Width = 164
3925:                 .Height = 26
3926:                 .ButtonCount = 3
3927:                 .Visible = .T.
3928:                 WITH .Buttons(1)
3929:                     .Top     = 2
3930:                     .Left    = 3
3931:                     .Width   = 50
3932:                     .Caption = "Sim"
3933:                     .AutoSize = .F.
3934:                 ENDWITH
3935:                 WITH .Buttons(2)
3936:                     .Top     = 2
3937:                     .Left    = 56
3938:                     .Width   = 50
3939:                     .Caption = "N" + CHR(227) + "o"
3940:                     .AutoSize = .F.
3941:                 ENDWITH
3942:                 WITH .Buttons(3)
3943:                     .Top     = 2
3944:                     .Left    = 109
3945:                     .Width   = 50
3946:                     .Caption = "Pedra"
3947:                     .AutoSize = .F.
3948:                 ENDWITH
3949:             ENDWITH
3950:             loc_oPg.AddObject("obj_4c_Optiongroup3", "OptionGroup")
3951:             WITH loc_oPg.obj_4c_Optiongroup3
3952:                 .Top = 116
3953:                 .Left = 176
3954:                 .Width = 102
3955:                 .Height = 26
3956:                 .ButtonCount = 2
3957:                 .Visible = .T.
3958:                 WITH .Buttons(1)
3959:                     .Top = 2
3960:                     .Left = 3
3961:                     .Caption = "Sim"
3962:                     .Width = 44
3963:                     .AutoSize = .F.
3964:                 ENDWITH
3965:                 WITH .Buttons(2)
3966:                     .Top = 2
3967:                     .Left = 50
3968:                     .Caption = "N" + CHR(227) + "o"
3969:                     .Width = 44
3970:                     .AutoSize = .F.
3971:                 ENDWITH
3972:             ENDWITH
3973:         CATCH TO loException
3974:             MostrarErro(loException, "FormMPD.ConfigurarPgDocumento")
3975:         ENDTRY
3976:     ENDPROC
3977: 
3978:     * ============================================================
3979:     * ConfigurarPgDiversas
3980:     * ============================================================
3981:     PROTECTED PROCEDURE ConfigurarPgDiversas()
3982:         LOCAL loc_oPg
3983:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
3984:         TRY
3985:             * Line
3986:             loc_oPg.AddObject("lin_4c_Line1", "Line")
3987:             WITH loc_oPg.lin_4c_Line1
3988:                 .Top = 11
3989:                 .Left = 591
3990:                 .Width = 0
3991:                 .Height = 418
3992:                 .Visible = .T.
3993:             ENDWITH
3994:             * Labels
3995:             loc_oPg.AddObject("lbl_4c_Label26", "Label")
3996:             WITH loc_oPg.lbl_4c_Label26
3997:                 .Top = 16
3998:                 .Left = 8
3999:                 .Width = 101
4000:                 .Height = 15
4001:                 .AutoSize = .F.
4002:                 .Caption = "Casas Decimais qtd :"
4003:                 .BackStyle = 0
4004:                 .Visible = .T.
4005:             ENDWITH
4006:             loc_oPg.AddObject("lbl_4c_LblObspads", "Label")
4007:             WITH loc_oPg.lbl_4c_LblObspads
4008:                 .Top = 45
4009:                 .Left = 12
4010:                 .Width = 104
4011:                 .Height = 15
4012:                 .AutoSize = .F.
4013:                 .Caption = "Observa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :"
4014:                 .BackStyle = 0
4015:                 .Visible = .T.
4016:             ENDWITH
4017:             loc_oPg.AddObject("lbl_4c_Label6", "Label")
4018:             WITH loc_oPg.lbl_4c_Label6
4019:                 .Top = 45
4020:                 .Left = 160
4021:                 .Width = 22

*-- Linhas 4272 a 4436:
4272:                 .Height = 23
4273:                 .Visible = .T.
4274:             ENDWITH
4275:             * OptionGroups
4276:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
4277:             WITH loc_oPg.obj_4c_Fwoption1
4278:                 .Top = 71
4279:                 .Left = 181
4280:                 .Width = 92
4281:                 .Height = 20
4282:                 .ButtonCount = 2
4283:                 .Visible = .T.
4284:                 WITH .Buttons(1)
4285:                     .Top = 2
4286:                     .Left = 3
4287:                     .Caption = "Sim"
4288:                     .Width = 40
4289:                     .AutoSize = .F.
4290:                 ENDWITH
4291:                 WITH .Buttons(2)
4292:                     .Top = 2
4293:                     .Left = 46
4294:                     .Caption = "N" + CHR(227) + "o"
4295:                     .Width = 40
4296:                     .AutoSize = .F.
4297:                 ENDWITH
4298:             ENDWITH
4299:             loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
4300:             WITH loc_oPg.obj_4c_Fwoption2
4301:                 .Top = 92
4302:                 .Left = 181
4303:                 .Width = 92
4304:                 .Height = 20
4305:                 .ButtonCount = 2
4306:                 .Visible = .T.
4307:                 WITH .Buttons(1)
4308:                     .Top = 2
4309:                     .Left = 3
4310:                     .Caption = "Sim"
4311:                     .Width = 40
4312:                     .AutoSize = .F.
4313:                 ENDWITH
4314:                 WITH .Buttons(2)
4315:                     .Top = 2
4316:                     .Left = 46
4317:                     .Caption = "N" + CHR(227) + "o"
4318:                     .Width = 40
4319:                     .AutoSize = .F.
4320:                 ENDWITH
4321:             ENDWITH
4322:             loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
4323:             WITH loc_oPg.obj_4c_Fwoption3
4324:                 .Top = 196
4325:                 .Left = 180
4326:                 .Width = 92
4327:                 .Height = 20
4328:                 .ButtonCount = 2
4329:                 .Visible = .T.
4330:                 WITH .Buttons(1)
4331:                     .Top = 2
4332:                     .Left = 3
4333:                     .Caption = "Sim"
4334:                     .Width = 40
4335:                     .AutoSize = .F.
4336:                 ENDWITH
4337:                 WITH .Buttons(2)
4338:                     .Top = 2
4339:                     .Left = 46
4340:                     .Caption = "N" + CHR(227) + "o"
4341:                     .Width = 40
4342:                     .AutoSize = .F.
4343:                 ENDWITH
4344:             ENDWITH
4345:             loc_oPg.AddObject("obj_4c_Fwoption4", "OptionGroup")
4346:             WITH loc_oPg.obj_4c_Fwoption4
4347:                 .Top = 220
4348:                 .Left = 180
4349:                 .Width = 92
4350:                 .Height = 20
4351:                 .ButtonCount = 2
4352:                 .Visible = .T.
4353:                 WITH .Buttons(1)
4354:                     .Top = 2
4355:                     .Left = 3
4356:                     .Caption = "Sim"
4357:                     .Width = 40
4358:                     .AutoSize = .F.
4359:                 ENDWITH
4360:                 WITH .Buttons(2)
4361:                     .Top = 2
4362:                     .Left = 46
4363:                     .Caption = "N" + CHR(227) + "o"
4364:                     .Width = 40
4365:                     .AutoSize = .F.
4366:                 ENDWITH
4367:             ENDWITH
4368:             loc_oPg.AddObject("obj_4c_Fwoption5", "OptionGroup")
4369:             WITH loc_oPg.obj_4c_Fwoption5
4370:                 .Top = 338
4371:                 .Left = 184
4372:                 .Width = 182
4373:                 .Height = 21
4374:                 .ButtonCount = 3
4375:                 .Visible = .T.
4376:                 WITH .Buttons(1)
4377:                     .Top = 2
4378:                     .Left = 3
4379:                     .Width = 55
4380:                     .AutoSize = .F.
4381:                 ENDWITH
4382:                 WITH .Buttons(2)
4383:                     .Top = 2
4384:                     .Left = 61
4385:                     .Width = 55
4386:                     .AutoSize = .F.
4387:                 ENDWITH
4388:                 WITH .Buttons(3)
4389:                     .Top = 2
4390:                     .Left = 119
4391:                     .Width = 55
4392:                     .AutoSize = .F.
4393:                 ENDWITH
4394:             ENDWITH
4395:             loc_oPg.AddObject("obj_4c_Optiongroup1", "OptionGroup")
4396:             WITH loc_oPg.obj_4c_Optiongroup1
4397:                 .Top = 80
4398:                 .Left = 818
4399:                 .Width = 119
4400:                 .Height = 19
4401:                 .ButtonCount = 2
4402:                 .Visible = .T.
4403:                 WITH .Buttons(1)
4404:                     .Top = 2
4405:                     .Left = 3
4406:                     .Caption = "Sim"
4407:                     .Width = 54
4408:                     .AutoSize = .F.
4409:                 ENDWITH
4410:                 WITH .Buttons(2)
4411:                     .Top = 2
4412:                     .Left = 60
4413:                     .Caption = "N" + CHR(227) + "o"
4414:                     .Width = 54
4415:                     .AutoSize = .F.
4416:                 ENDWITH
4417:             ENDWITH
4418:             * CheckBoxes
4419:             loc_oPg.AddObject("chk_4c_Chk_Pcc", "CheckBox")
4420:             WITH loc_oPg.chk_4c_Chk_Pcc
4421:                 .Top = 12
4422:                 .Left = 604
4423:                 .Width = 200
4424:                 .Height = 19
4425:                 .Caption = "Marcar OP como cancelada"
4426:                 .Value = 0
4427:                 .Visible = .T.
4428:             ENDWITH
4429:             loc_oPg.AddObject("chk_4c_Chk_imp", "CheckBox")
4430:             WITH loc_oPg.chk_4c_Chk_imp
4431:                 .Top = 29
4432:                 .Left = 604
4433:                 .Width = 250
4434:                 .Height = 19
4435:                 .Caption = "Imprimir Somente Peso do Material Principal"
4436:                 .Value = 0

*-- Linhas 4476 a 4546:
4476:                 .Value = 0
4477:                 .Visible = .T.
4478:             ENDWITH
4479:             * BINDEVENTs lookups Diversas
4480:             BINDEVENT(loc_oPg.txt_4c_Obspads,   "KeyPress", THIS, "ObspadsKeyPress")
4481:             BINDEVENT(loc_oPg.txt_4c_Obspads,   "DblClick", THIS, "AbrirLookupObspads")
4482:             BINDEVENT(loc_oPg.txt_4c_ObsInis,   "KeyPress", THIS, "ObsInisKeyPress")
4483:             BINDEVENT(loc_oPg.txt_4c_ObsInis,   "DblClick", THIS, "AbrirLookupObsInis")
4484:             BINDEVENT(loc_oPg.txt_4c_ObsFins,   "KeyPress", THIS, "ObsFinsKeyPress")
4485:             BINDEVENT(loc_oPg.txt_4c_ObsFins,   "DblClick", THIS, "AbrirLookupObsFins")
4486:             BINDEVENT(loc_oPg.txt_4c_GruFin,    "KeyPress", THIS, "GruFinKeyPress")
4487:             BINDEVENT(loc_oPg.txt_4c_GruFin,    "DblClick", THIS, "AbrirLookupGruFin")
4488:             BINDEVENT(loc_oPg.txt_4c_OpConta,   "KeyPress", THIS, "OpContaKeyPress")
4489:             BINDEVENT(loc_oPg.txt_4c_OpConta,   "DblClick", THIS, "AbrirLookupOpConta")
4490:             BINDEVENT(loc_oPg.txt_4c_TpOp,      "KeyPress", THIS, "TpOpKeyPress")
4491:             BINDEVENT(loc_oPg.txt_4c_TpOp,      "DblClick", THIS, "AbrirLookupTpOp")
4492:             BINDEVENT(loc_oPg.txt_4c__gruccus,  "KeyPress", THIS, "GruccusKeyPress")
4493:             BINDEVENT(loc_oPg.txt_4c__gruccus,  "DblClick", THIS, "AbrirLookupGruccus")
4494:             BINDEVENT(loc_oPg.txt_4c__contaccus,"KeyPress", THIS, "ContaccusKeyPress")
4495:             BINDEVENT(loc_oPg.txt_4c__contaccus,"DblClick", THIS, "AbrirLookupContaccus")
4496:             BINDEVENT(loc_oPg.txt_4c_Semi,      "KeyPress", THIS, "SemiKeyPress")
4497:             BINDEVENT(loc_oPg.txt_4c_Semi,      "DblClick", THIS, "AbrirLookupSemi")
4498:         CATCH TO loException
4499:             MostrarErro(loException, "FormMPD.ConfigurarPgDiversas")
4500:         ENDTRY
4501:     ENDPROC
4502: 
4503:     * ============================================================
4504:     * FormParaBO
4505:     * ============================================================
4506:     PROCEDURE FormParaBO()
4507:         LOCAL loc_oPD, loc_oPOp, loc_oPEst, loc_oPCom, loc_oPDoc, loc_oPDiv
4508:         TRY
4509:             loc_oPD   = THIS.pgf_4c_Paginas.Page2
4510:             loc_oPOp  = loc_oPD.pgf_4c_PagDados.Page1
4511:             loc_oPEst = loc_oPD.pgf_4c_PagDados.Page2
4512:             loc_oPCom = loc_oPD.pgf_4c_PagDados.Page3
4513:             loc_oPDoc = loc_oPD.pgf_4c_PagDados.Page4
4514:             loc_oPDiv = loc_oPD.pgf_4c_PagDados.Page5
4515:             * Header
4516:             THIS.this_oBusinessObject.this_cDopps  = ALLTRIM(loc_oPD.txt_4c_Desc.Value)
4517:             THIS.this_oBusinessObject.this_nNdopps = ALLTRIM(STR(loc_oPD.txt_4c_Nope.Value))
4518:             THIS.this_oBusinessObject.this_nOrdes  = ALLTRIM(STR(loc_oPD.txt_4c_Ordem.Value))
4519:             * Aba Operacao
4520:             THIS.this_oBusinessObject.this_nImagems    = loc_oPOp.obj_4c_Op_imagem.Value
4521:             THIS.this_oBusinessObject.this_nBoletos    = loc_oPOp.obj_4c_Op_boleto.Value
4522:             THIS.this_oBusinessObject.this_nDocus      = loc_oPOp.obj_4c_Fwoption8.Value
4523:             THIS.this_oBusinessObject.this_nBolops     = loc_oPOp.obj_4c_Fwoption5.Value
4524:             THIS.this_oBusinessObject.this_nBolcomps   = loc_oPOp.obj_4c_Opt_compo.Value
4525:             THIS.this_oBusinessObject.this_nMenus      = loc_oPOp.obj_4c_Opt_Menu.Value
4526:             THIS.this_oBusinessObject.this_nAutos      = loc_oPOp.obj_4c_ObjAutos.Value
4527:             THIS.this_oBusinessObject.this_cHists      = ALLTRIM(loc_oPOp.txt_4c_Hists.Value)
4528:             THIS.this_oBusinessObject.this_nChktemsubn = loc_oPOp.obj_4c_Op_subn.Value
4529:             THIS.this_oBusinessObject.this_cNivels     = ALLTRIM(loc_oPOp.txt_4c_Nivel.Value)
4530:             THIS.this_oBusinessObject.this_cTnivels    = ALLTRIM(loc_oPOp.txt_4c_Titulo.Value)
4531:             THIS.this_oBusinessObject.this_cArtigos    = ALLTRIM(loc_oPOp.txt_4c_Artigo.Value)
4532:             THIS.this_oBusinessObject.this_nBxautos    = loc_oPOp.obj_4c_Op_BxAuto.Value
4533:             THIS.this_oBusinessObject.this_nExclsubns  = loc_oPOp.obj_4c_Fwoption2.Value
4534:             THIS.this_oBusinessObject.this_nChktemsubn = loc_oPOp.obj_4c_Fwoption1.Value
4535:             THIS.this_oBusinessObject.this_nSeqs       = loc_oPOp.obj_4c_GetSequencia.Value
4536:             THIS.this_oBusinessObject.this_nAgregas    = loc_oPOp.obj_4c_Op_agregas.Value
4537:             THIS.this_oBusinessObject.this_nChkfases   = loc_oPOp.obj_4c_Op_repete.Value
4538:             THIS.this_oBusinessObject.this_nCestoqs    = loc_oPOp.obj_4c_Op_Saldo.Value
4539:             THIS.this_oBusinessObject.this_nInibmens   = loc_oPOp.obj_4c_Op_inib.Value
4540:             THIS.this_oBusinessObject.this_nMenfalhas  = loc_oPOp.obj_4c_ObjMenFalha.Value
4541:             THIS.this_oBusinessObject.this_nBuscaenvs  = loc_oPOp.obj_4c_ObjBusEnv.Value
4542:             THIS.this_oBusinessObject.this_nBtnrets    = loc_oPOp.obj_4c_ObjRetrabs.Value
4543:             THIS.this_oBusinessObject.this_nBtnincs    = loc_oPOp.obj_4c_Objnaoconform.Value
4544:             THIS.this_oBusinessObject.this_nBtnpags    = loc_oPOp.obj_4c_Objpagamento.Value
4545:             THIS.this_oBusinessObject.this_nEtiqenvs   = loc_oPOp.obj_4c_Fwoption3.Value
4546:             THIS.this_oBusinessObject.this_nApontas    = loc_oPOp.obj_4c_Fwoption4.Value

*-- Linhas 4617 a 4694:
4617:             THIS.this_oBusinessObject.this_nMatprncdif = loc_oPCom.obj_4c_OptMatPrncDif.Value
4618:             THIS.this_oBusinessObject.this_nChkqtdps   = loc_oPCom.obj_4c_ObjChkQP.Value
4619:             * Aba Documento
4620:             THIS.this_oBusinessObject.this_nDckcabec   = loc_oPDoc.obj_4c_Optiongroup1.Value
4621:             THIS.this_oBusinessObject.this_nDckitens   = loc_oPDoc.obj_4c_Optiongroup2.Value
4622:             THIS.this_oBusinessObject.this_nDckresu    = loc_oPDoc.obj_4c_Optiongroup3.Value
4623:             * Aba Diversas
4624:             THIS.this_oBusinessObject.this_nCasqtds    = loc_oPDiv.obj_4c_Spn_NCqtd.Value
4625:             THIS.this_oBusinessObject.this_nObspads    = ALLTRIM(loc_oPDiv.txt_4c_Obspads.Value)
4626:             THIS.this_oBusinessObject.this_nObsinis    = ALLTRIM(loc_oPDiv.txt_4c_ObsInis.Value)
4627:             THIS.this_oBusinessObject.this_nObsfins    = ALLTRIM(loc_oPDiv.txt_4c_ObsFins.Value)
4628:             THIS.this_oBusinessObject.this_nChkunis    = loc_oPDiv.obj_4c_Fwoption1.Value
4629:             THIS.this_oBusinessObject.this_nEnvelopes  = loc_oPDiv.obj_4c_Fwoption2.Value
4630:             THIS.this_oBusinessObject.this_nAcenvs     = loc_oPDiv.obj_4c_Fwoption3.Value
4631:             THIS.this_oBusinessObject.this_nCtrlotes   = loc_oPDiv.obj_4c_Fwoption4.Value
4632:             THIS.this_oBusinessObject.this_cCodtgops   = ALLTRIM(loc_oPDiv.txt_4c_TpOp.Value)
4633:             THIS.this_oBusinessObject.this_cGrufins    = ALLTRIM(loc_oPDiv.txt_4c_GruFin.Value)
4634:             THIS.this_oBusinessObject.this_cDopcs      = ALLTRIM(loc_oPDiv.txt_4c_OpConta.Value)
4635:             THIS.this_oBusinessObject.this_cGruccus    = ALLTRIM(loc_oPDiv.txt_4c__gruccus.Value)
4636:             THIS.this_oBusinessObject.this_cContaccus  = ALLTRIM(loc_oPDiv.txt_4c__contaccus.Value)
4637:             THIS.this_oBusinessObject.this_cDopsemis   = ALLTRIM(loc_oPDiv.txt_4c_Semi.Value)
4638:             THIS.this_oBusinessObject.this_nChkpesotot = loc_oPDiv.obj_4c_Fwoption5.Value
4639:             THIS.this_oBusinessObject.this_nTpsenexc   = loc_oPDiv.obj_4c_Optiongroup1.Value
4640:             THIS.this_oBusinessObject.this_nPccs       = IIF(loc_oPDiv.chk_4c_Chk_Pcc.Value = 1, 1, 0)
4641:             THIS.this_oBusinessObject.this_nPesmatps   = IIF(loc_oPDiv.chk_4c_Chk_imp.Value = 1, 1, 0)
4642:             THIS.this_oBusinessObject.this_nInibAlts   = IIF(loc_oPDiv.chk_4c_Chk_InibAlt.Value = 1, 1, 0)
4643:             THIS.this_oBusinessObject.this_nChkctdes   = IIF(loc_oPDiv.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
4644:             THIS.this_oBusinessObject.this_nChksenexc  = IIF(loc_oPDiv.chk_4c_Fwcheckbox8.Value = 1, 1, 0)
4645:             THIS.this_oBusinessObject.this_nChkoplts   = IIF(loc_oPDiv.chk_4c_ChkOpLote.Value = 1, 1, 0)
4646:         CATCH TO loException
4647:             MostrarErro(loException, "FormMPD.FormParaBO")
4648:         ENDTRY
4649:     ENDPROC
4650: 
4651:     * ============================================================
4652:     * BOParaForm
4653:     * ============================================================
4654:     PROCEDURE BOParaForm()
4655:         LOCAL loc_oPD, loc_oPOp, loc_oPEst, loc_oPCom, loc_oPDoc, loc_oPDiv, loc_oBO
4656:         TRY
4657:             loc_oBO   = THIS.this_oBusinessObject
4658:             loc_oPD   = THIS.pgf_4c_Paginas.Page2
4659:             loc_oPOp  = loc_oPD.pgf_4c_PagDados.Page1
4660:             loc_oPEst = loc_oPD.pgf_4c_PagDados.Page2
4661:             loc_oPCom = loc_oPD.pgf_4c_PagDados.Page3
4662:             loc_oPDoc = loc_oPD.pgf_4c_PagDados.Page4
4663:             loc_oPDiv = loc_oPD.pgf_4c_PagDados.Page5
4664:             * Header
4665:             loc_oPD.txt_4c_Desc.Value  = loc_oBO.this_cDopps
4666:             loc_oPD.txt_4c_Nope.Value  = loc_oBO.this_nNdopps
4667:             loc_oPD.txt_4c_Ordem.Value = loc_oBO.this_nOrdes
4668:             * Aba Operacao
4669:             loc_oPOp.obj_4c_Op_imagem.Value    = IIF(loc_oBO.this_nImagems > 0, loc_oBO.this_nImagems, 2)
4670:             loc_oPOp.obj_4c_Op_boleto.Value    = IIF(loc_oBO.this_nBoletos > 0, loc_oBO.this_nBoletos, 1)
4671:             loc_oPOp.obj_4c_Fwoption8.Value    = IIF(loc_oBO.this_nDocus > 0, loc_oBO.this_nDocus, 2)
4672:             loc_oPOp.obj_4c_Fwoption5.Value    = IIF(loc_oBO.this_nBolops > 0, loc_oBO.this_nBolops, 2)
4673:             loc_oPOp.obj_4c_Opt_compo.Value    = IIF(loc_oBO.this_nBolcomps > 0, loc_oBO.this_nBolcomps, 2)
4674:             loc_oPOp.obj_4c_Opt_Menu.Value     = IIF(loc_oBO.this_nMenus > 0, loc_oBO.this_nMenus, 2)
4675:             loc_oPOp.obj_4c_ObjAutos.Value     = IIF(loc_oBO.this_nAutos > 0, loc_oBO.this_nAutos, 1)
4676:             loc_oPOp.txt_4c_Hists.Value        = loc_oBO.this_cHists
4677:             loc_oPOp.obj_4c_Op_subn.Value      = IIF(loc_oBO.this_nChktemsubn > 0, loc_oBO.this_nChktemsubn, 2)
4678:             loc_oPOp.txt_4c_Nivel.Value        = loc_oBO.this_cNivels
4679:             loc_oPOp.txt_4c_Titulo.Value       = loc_oBO.this_cTnivels
4680:             loc_oPOp.txt_4c_Artigo.Value       = loc_oBO.this_cArtigos
4681:             loc_oPOp.obj_4c_Op_BxAuto.Value    = IIF(loc_oBO.this_nBxautos > 0, loc_oBO.this_nBxautos, 2)
4682:             loc_oPOp.obj_4c_Fwoption2.Value    = IIF(loc_oBO.this_nExclsubns > 0, loc_oBO.this_nExclsubns, 2)
4683:             loc_oPOp.obj_4c_Fwoption1.Value    = IIF(loc_oBO.this_nChktemsubn > 0, loc_oBO.this_nChktemsubn, 2)
4684:             loc_oPOp.obj_4c_GetSequencia.Value = IIF(loc_oBO.this_nSeqs > 0, loc_oBO.this_nSeqs, 2)
4685:             loc_oPOp.obj_4c_Op_agregas.Value   = IIF(loc_oBO.this_nAgregas > 0, loc_oBO.this_nAgregas, 2)
4686:             loc_oPOp.obj_4c_Op_repete.Value    = IIF(loc_oBO.this_nChkfases > 0, loc_oBO.this_nChkfases, 1)
4687:             loc_oPOp.obj_4c_Op_Saldo.Value     = IIF(loc_oBO.this_nCestoqs > 0, loc_oBO.this_nCestoqs, 2)
4688:             loc_oPOp.obj_4c_Op_inib.Value      = IIF(loc_oBO.this_nInibmens > 0, loc_oBO.this_nInibmens, 2)
4689:             loc_oPOp.obj_4c_ObjMenFalha.Value  = IIF(loc_oBO.this_nMenfalhas > 0, loc_oBO.this_nMenfalhas, 2)
4690:             loc_oPOp.obj_4c_ObjBusEnv.Value    = IIF(loc_oBO.this_nBuscaenvs > 0, loc_oBO.this_nBuscaenvs, 2)
4691:             loc_oPOp.obj_4c_ObjRetrabs.Value   = IIF(loc_oBO.this_nBtnrets > 0, loc_oBO.this_nBtnrets, 2)
4692:             loc_oPOp.obj_4c_Objnaoconform.Value = IIF(loc_oBO.this_nBtnincs > 0, loc_oBO.this_nBtnincs, 2)
4693:             loc_oPOp.obj_4c_Objpagamento.Value = IIF(loc_oBO.this_nBtnpags > 0, loc_oBO.this_nBtnpags, 2)
4694:             loc_oPOp.obj_4c_Fwoption3.Value    = IIF(loc_oBO.this_nEtiqenvs > 0, loc_oBO.this_nEtiqenvs, 2)

*-- Linhas 4772 a 4865:
4772:             loc_oPCom.obj_4c_OptMatPrncDif.Value = IIF(loc_oBO.this_nMatprncdif > 0, loc_oBO.this_nMatprncdif, 2)
4773:             loc_oPCom.obj_4c_ObjChkQP.Value      = IIF(loc_oBO.this_nChkqtdps > 0, loc_oBO.this_nChkqtdps, 1)
4774:             * Aba Documento
4775:             loc_oPDoc.obj_4c_Optiongroup1.Value  = IIF(loc_oBO.this_nDckcabec > 0, loc_oBO.this_nDckcabec, 2)
4776:             loc_oPDoc.obj_4c_Optiongroup2.Value  = IIF(loc_oBO.this_nDckitens > 0, loc_oBO.this_nDckitens, 1)
4777:             loc_oPDoc.obj_4c_Optiongroup3.Value  = IIF(loc_oBO.this_nDckresu > 0, loc_oBO.this_nDckresu, 2)
4778:             * Aba Diversas
4779:             loc_oPDiv.obj_4c_Spn_NCqtd.Value    = loc_oBO.this_nCasqtds
4780:             loc_oPDiv.txt_4c_Obspads.Value       = loc_oBO.this_nObspads
4781:             loc_oPDiv.txt_4c_ObsInis.Value       = loc_oBO.this_nObsinis
4782:             loc_oPDiv.txt_4c_ObsFins.Value       = loc_oBO.this_nObsfins
4783:             loc_oPDiv.obj_4c_Fwoption1.Value     = IIF(loc_oBO.this_nChkunis > 0, loc_oBO.this_nChkunis, 2)
4784:             loc_oPDiv.obj_4c_Fwoption2.Value     = IIF(loc_oBO.this_nEnvelopes > 0, loc_oBO.this_nEnvelopes, 2)
4785:             loc_oPDiv.obj_4c_Fwoption3.Value     = IIF(loc_oBO.this_nAcenvs > 0, loc_oBO.this_nAcenvs, 2)
4786:             loc_oPDiv.obj_4c_Fwoption4.Value     = IIF(loc_oBO.this_nCtrlotes > 0, loc_oBO.this_nCtrlotes, 2)
4787:             loc_oPDiv.txt_4c_TpOp.Value          = loc_oBO.this_cCodtgops
4788:             loc_oPDiv.txt_4c_GruFin.Value        = loc_oBO.this_cGrufins
4789:             loc_oPDiv.txt_4c_OpConta.Value       = loc_oBO.this_cDopcs
4790:             loc_oPDiv.txt_4c__gruccus.Value      = loc_oBO.this_cGruccus
4791:             loc_oPDiv.txt_4c__contaccus.Value    = loc_oBO.this_cContaccus
4792:             loc_oPDiv.txt_4c_Semi.Value          = loc_oBO.this_cDopsemis
4793:             loc_oPDiv.obj_4c_Fwoption5.Value     = IIF(loc_oBO.this_nChkpesotot > 0, loc_oBO.this_nChkpesotot, 1)
4794:             loc_oPDiv.obj_4c_Optiongroup1.Value  = IIF(loc_oBO.this_nTpsenexc > 0, loc_oBO.this_nTpsenexc, 1)
4795:             loc_oPDiv.chk_4c_Chk_Pcc.Value      = loc_oBO.this_nPccs
4796:             loc_oPDiv.chk_4c_Chk_imp.Value       = loc_oBO.this_nPesmatps
4797:             loc_oPDiv.chk_4c_Chk_InibAlt.Value  = loc_oBO.this_nInibAlts
4798:             loc_oPDiv.chk_4c_Fwcheckbox1.Value   = loc_oBO.this_nChkctdes
4799:             loc_oPDiv.chk_4c_Fwcheckbox8.Value   = loc_oBO.this_nChksenexc
4800:             loc_oPDiv.chk_4c_ChkOpLote.Value     = loc_oBO.this_nChkoplts
4801:         CATCH TO loException
4802:             MostrarErro(loException, "FormMPD.BOParaForm")
4803:         ENDTRY
4804:     ENDPROC
4805: 
4806:     * ============================================================
4807:     * HabilitarCampos
4808:     * ============================================================
4809:     PROCEDURE HabilitarCampos(par_lHabilitar)
4810:         LOCAL loc_oPD
4811:         TRY
4812:             loc_oPD = THIS.pgf_4c_Paginas.Page2
4813:             loc_oPD.txt_4c_Desc.Enabled                      = par_lHabilitar
4814:             loc_oPD.txt_4c_Nope.Enabled                      = par_lHabilitar
4815:             loc_oPD.txt_4c_Ordem.Enabled                     = par_lHabilitar
4816:             loc_oPD.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled  = par_lHabilitar
4817:         CATCH TO loException
4818:             MostrarErro(loException, "FormMPD.HabilitarCampos")
4819:         ENDTRY
4820:     ENDPROC
4821: 
4822:     * ============================================================
4823:     * LimparCampos
4824:     * ============================================================
4825:     PROCEDURE LimparCampos()
4826:         LOCAL loc_oPD, loc_oPOp, loc_oPEst, loc_oPCom, loc_oPDoc, loc_oPDiv
4827:         TRY
4828:             loc_oPD   = THIS.pgf_4c_Paginas.Page2
4829:             loc_oPOp  = loc_oPD.pgf_4c_PagDados.Page1
4830:             loc_oPEst = loc_oPD.pgf_4c_PagDados.Page2
4831:             loc_oPCom = loc_oPD.pgf_4c_PagDados.Page3
4832:             loc_oPDoc = loc_oPD.pgf_4c_PagDados.Page4
4833:             loc_oPDiv = loc_oPD.pgf_4c_PagDados.Page5
4834:             loc_oPD.txt_4c_Desc.Value  = ""
4835:             loc_oPD.txt_4c_Nope.Value  = 0
4836:             loc_oPD.txt_4c_Ordem.Value = 0
4837:             loc_oPOp.txt_4c_Hists.Value   = ""
4838:             loc_oPOp.txt_4c_Nivel.Value   = ""
4839:             loc_oPOp.txt_4c_Titulo.Value  = ""
4840:             loc_oPOp.txt_4c_Artigo.Value  = ""
4841:             loc_oPOp.txt_4c_ArqIcone.Value = ""
4842:             loc_oPOp.txt_4c__Empenho.Value = ""
4843:             loc_oPOp.txt_4c_EmpLanc.Value  = ""
4844:             loc_oPEst.txt_4c_GrupoOrig.Value = ""
4845:             loc_oPEst.txt_4c_Dgrupoo.Value = ""
4846:             loc_oPEst.txt_4c_ContaOrig.Value = ""
4847:             loc_oPEst.txt_4c_Dcontao.Value = ""
4848:             loc_oPEst.txt_4c_GrupoDest.Value = ""
4849:             loc_oPEst.txt_4c_Dgrupod.Value = ""
4850:             loc_oPEst.txt_4c_ContaDest.Value = ""
4851:             loc_oPEst.txt_4c_Dcontad.Value = ""
4852:             loc_oPEst.txt_4c_GrupoVend.Value = ""
4853:             loc_oPEst.txt_4c_Dgrupov.Value = ""
4854:             loc_oPEst.txt_4c_Mascos.Value = ""
4855:             loc_oPEst.txt_4c_Mascds.Value = ""
4856:             loc_oPCom.txt_4c_TpPadrao.Value = ""
4857:             loc_oPCom.txt_4c_Retalho.Value = ""
4858:             loc_oPCom.txt_4c_GrupoPcc.Value = ""
4859:             loc_oPCom.txt_4c__produto.Value = ""
4860:             loc_oPCom.txt_4c_Tfalhas.Value  = ""
4861:             loc_oPCom.txt_4c_Difp.Value = 0
4862:             loc_oPCom.txt_4c__limqtd.Value = 0
4863:             loc_oPCom.txt_4c_DifPeso.Value = 0
4864:             loc_oPDiv.txt_4c_Obspads.Value  = 0
4865:             loc_oPDiv.txt_4c_ObsInis.Value = 0

*-- Linhas 4881 a 5657:
4881:     * ============================================================
4882:     * LOOKUP HANDLERS - Operacao
4883:     * ============================================================
4884:     PROCEDURE NivelKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4885:         IF par_nKeyCode = 116
4886:             THIS.AbrirLookupNivel()
4887:         ENDIF
4888:     ENDPROC
4889: 
4890:     PROCEDURE AbrirLookupNivel()
4891:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4892:         TRY
4893:             loc_cSQL = "SELECT Dopps, Ndopps FROM SigCdOpd ORDER BY Dopps"
4894:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nivel")
4895:             IF loc_nResult >= 0
4896:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4897:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Nivel"
4898:                 loc_oFrm.DefinirCursor("cursor_4c_Nivel", "Dopps", "Ndopps", "SubN" + CHR(237) + "vel")
4899:                 loc_oFrm.Mostrar()
4900:                 IF loc_oFrm.this_lSelecionou
4901:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4902:                     loc_oPg.txt_4c_Nivel.Value = loc_oFrm.cCodigoSelecionado
4903:                 ENDIF
4904:                 IF USED("cursor_4c_Nivel")
4905:                     USE IN cursor_4c_Nivel
4906:                 ENDIF
4907:             ELSE
4908:                 MsgErro("Erro ao buscar n" + CHR(237) + "veis.", "Erro")
4909:             ENDIF
4910:         CATCH TO loc_oErro
4911:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupNivel")
4912:         ENDTRY
4913:     ENDPROC
4914: 
4915:     PROCEDURE EmpenhoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4916:         IF par_nKeyCode = 116
4917:             THIS.AbrirLookupEmpenho()
4918:         ENDIF
4919:     ENDPROC
4920: 
4921:     PROCEDURE AbrirLookupEmpenho()
4922:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4923:         TRY
4924:             loc_cSQL = "SELECT Dopps, hists FROM SigCdOpd ORDER BY Dopps"
4925:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empenho")
4926:             IF loc_nResult >= 0
4927:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4928:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Empenho"
4929:                 loc_oFrm.DefinirCursor("cursor_4c_Empenho", "Dopps", "hists", "Opera" + CHR(231) + CHR(227) + "o Empenho")
4930:                 loc_oFrm.Mostrar()
4931:                 IF loc_oFrm.this_lSelecionou
4932:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4933:                     loc_oPg.txt_4c__Empenho.Value = loc_oFrm.cCodigoSelecionado
4934:                 ENDIF
4935:                 IF USED("cursor_4c_Empenho")
4936:                     USE IN cursor_4c_Empenho
4937:                 ENDIF
4938:             ELSE
4939:                 MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
4940:             ENDIF
4941:         CATCH TO loc_oErro
4942:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupEmpenho")
4943:         ENDTRY
4944:     ENDPROC
4945: 
4946:     PROCEDURE EmpLancKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4947:         IF par_nKeyCode = 116
4948:             THIS.AbrirLookupEmpLanc()
4949:         ENDIF
4950:     ENDPROC
4951: 
4952:     PROCEDURE AbrirLookupEmpLanc()
4953:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4954:         TRY
4955:             loc_cSQL = "SELECT cemps, razas FROM SigCdEmp ORDER BY cemps"
4956:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpLanc")
4957:             IF loc_nResult >= 0
4958:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4959:                 loc_oFrm.this_cCursorDestino = "cursor_4c_EmpLanc"
4960:                 loc_oFrm.DefinirCursor("cursor_4c_EmpLanc", "cemps", "razas", "Empresa")
4961:                 loc_oFrm.Mostrar()
4962:                 IF loc_oFrm.this_lSelecionou
4963:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4964:                     loc_oPg.txt_4c_EmpLanc.Value = loc_oFrm.cCodigoSelecionado
4965:                 ENDIF
4966:                 IF USED("cursor_4c_EmpLanc")
4967:                     USE IN cursor_4c_EmpLanc
4968:                 ENDIF
4969:             ELSE
4970:                 MsgErro("Erro ao buscar empresas.", "Erro")
4971:             ENDIF
4972:         CATCH TO loc_oErro
4973:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupEmpLanc")
4974:         ENDTRY
4975:     ENDPROC
4976: 
4977:     * ============================================================
4978:     * LOOKUP HANDLERS - Estoque
4979:     * ============================================================
4980:     PROCEDURE GrupoOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4981:         IF par_nKeyCode = 116
4982:             THIS.AbrirLookupGrupoOrig()
4983:         ENDIF
4984:     ENDPROC
4985: 
4986:     PROCEDURE AbrirLookupGrupoOrig()
4987:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4988:         TRY
4989:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
4990:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoO")
4991:             IF loc_nResult >= 0
4992:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4993:                 loc_oFrm.this_cCursorDestino = "cursor_4c_GrupoO"
4994:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoO", "codigos", "descrs", "Grupo Orig.")
4995:                 loc_oFrm.Mostrar()
4996:                 IF loc_oFrm.this_lSelecionou
4997:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4998:                     loc_oPg.txt_4c_GrupoOrig.Value = loc_oFrm.cCodigoSelecionado
4999:                     loc_oPg.txt_4c_Dgrupoo.Value   = loc_oFrm.cDescricaoSelecionada
5000:                 ENDIF
5001:                 IF USED("cursor_4c_GrupoO")
5002:                     USE IN cursor_4c_GrupoO
5003:                 ENDIF
5004:             ELSE
5005:                 MsgErro("Erro ao buscar grupos.", "Erro")
5006:             ENDIF
5007:         CATCH TO loc_oErro
5008:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoOrig")
5009:         ENDTRY
5010:     ENDPROC
5011: 
5012:     PROCEDURE ContaOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5013:         IF par_nKeyCode = 116
5014:             THIS.AbrirLookupContaOrig()
5015:         ENDIF
5016:     ENDPROC
5017: 
5018:     PROCEDURE AbrirLookupContaOrig()
5019:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5020:         TRY
5021:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5022:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaO")
5023:             IF loc_nResult >= 0
5024:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5025:                 loc_oFrm.this_cCursorDestino = "cursor_4c_ContaO"
5026:                 loc_oFrm.DefinirCursor("cursor_4c_ContaO", "codigos", "descrs", "Conta Orig.")
5027:                 loc_oFrm.Mostrar()
5028:                 IF loc_oFrm.this_lSelecionou
5029:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
5030:                     loc_oPg.txt_4c_ContaOrig.Value = loc_oFrm.cCodigoSelecionado
5031:                     loc_oPg.txt_4c_Dcontao.Value   = loc_oFrm.cDescricaoSelecionada
5032:                 ENDIF
5033:                 IF USED("cursor_4c_ContaO")
5034:                     USE IN cursor_4c_ContaO
5035:                 ENDIF
5036:             ELSE
5037:                 MsgErro("Erro ao buscar contas.", "Erro")
5038:             ENDIF
5039:         CATCH TO loc_oErro
5040:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupContaOrig")
5041:         ENDTRY
5042:     ENDPROC
5043: 
5044:     PROCEDURE GrupoDestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5045:         IF par_nKeyCode = 116
5046:             THIS.AbrirLookupGrupoDest()
5047:         ENDIF
5048:     ENDPROC
5049: 
5050:     PROCEDURE AbrirLookupGrupoDest()
5051:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5052:         TRY
5053:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5054:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoD")
5055:             IF loc_nResult >= 0
5056:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5057:                 loc_oFrm.this_cCursorDestino = "cursor_4c_GrupoD"
5058:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoD", "codigos", "descrs", "Grupo Dest.")
5059:                 loc_oFrm.Mostrar()
5060:                 IF loc_oFrm.this_lSelecionou
5061:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
5062:                     loc_oPg.txt_4c_GrupoDest.Value = loc_oFrm.cCodigoSelecionado
5063:                     loc_oPg.txt_4c_Dgrupod.Value   = loc_oFrm.cDescricaoSelecionada
5064:                 ENDIF
5065:                 IF USED("cursor_4c_GrupoD")
5066:                     USE IN cursor_4c_GrupoD
5067:                 ENDIF
5068:             ELSE
5069:                 MsgErro("Erro ao buscar grupos.", "Erro")
5070:             ENDIF
5071:         CATCH TO loc_oErro
5072:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoDest")
5073:         ENDTRY
5074:     ENDPROC
5075: 
5076:     PROCEDURE ContaDestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5077:         IF par_nKeyCode = 116
5078:             THIS.AbrirLookupContaDest()
5079:         ENDIF
5080:     ENDPROC
5081: 
5082:     PROCEDURE AbrirLookupContaDest()
5083:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5084:         TRY
5085:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5086:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaD")
5087:             IF loc_nResult >= 0
5088:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5089:                 loc_oFrm.this_cCursorDestino = "cursor_4c_ContaD"
5090:                 loc_oFrm.DefinirCursor("cursor_4c_ContaD", "codigos", "descrs", "Conta Dest.")
5091:                 loc_oFrm.Mostrar()
5092:                 IF loc_oFrm.this_lSelecionou
5093:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
5094:                     loc_oPg.txt_4c_ContaDest.Value = loc_oFrm.cCodigoSelecionado
5095:                     loc_oPg.txt_4c_Dcontad.Value   = loc_oFrm.cDescricaoSelecionada
5096:                 ENDIF
5097:                 IF USED("cursor_4c_ContaD")
5098:                     USE IN cursor_4c_ContaD
5099:                 ENDIF
5100:             ELSE
5101:                 MsgErro("Erro ao buscar contas.", "Erro")
5102:             ENDIF
5103:         CATCH TO loc_oErro
5104:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupContaDest")
5105:         ENDTRY
5106:     ENDPROC
5107: 
5108:     PROCEDURE GrupoVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5109:         IF par_nKeyCode = 116
5110:             THIS.AbrirLookupGrupoVend()
5111:         ENDIF
5112:     ENDPROC
5113: 
5114:     PROCEDURE AbrirLookupGrupoVend()
5115:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5116:         TRY
5117:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5118:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoV")
5119:             IF loc_nResult >= 0
5120:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5121:                 loc_oFrm.this_cCursorDestino = "cursor_4c_GrupoV"
5122:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoV", "codigos", "descrs", "Grupo Venda")
5123:                 loc_oFrm.Mostrar()
5124:                 IF loc_oFrm.this_lSelecionou
5125:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
5126:                     loc_oPg.txt_4c_GrupoVend.Value = loc_oFrm.cCodigoSelecionado
5127:                     loc_oPg.txt_4c_Dgrupov.Value   = loc_oFrm.cDescricaoSelecionada
5128:                 ENDIF
5129:                 IF USED("cursor_4c_GrupoV")
5130:                     USE IN cursor_4c_GrupoV
5131:                 ENDIF
5132:             ELSE
5133:                 MsgErro("Erro ao buscar grupos.", "Erro")
5134:             ENDIF
5135:         CATCH TO loc_oErro
5136:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoVend")
5137:         ENDTRY
5138:     ENDPROC
5139: 
5140:     * ============================================================
5141:     * COMPORTAMENTO INTERATIVO - Estoque
5142:     * ============================================================
5143:     PROCEDURE OpOrigemChange()
5144:         LOCAL loc_oPg, loc_lSim
5145:         TRY
5146:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
5147:             loc_lSim = (loc_oPg.obj_4c_Op_origem.Value = 1)
5148:             loc_oPg.txt_4c_GrupoOrig.Enabled   = loc_lSim
5149:             loc_oPg.txt_4c_Dgrupoo.Enabled     = loc_lSim
5150:             loc_oPg.txt_4c_ContaOrig.Enabled   = loc_lSim
5151:             loc_oPg.txt_4c_Dcontao.Enabled     = loc_lSim
5152:             loc_oPg.chk_4c_Chk_Grupoo.Enabled  = loc_lSim
5153:             loc_oPg.chk_4c_Chk_Contao.Enabled  = loc_lSim
5154:             loc_oPg.obj_4c_Op_ConOSub.Enabled  = loc_lSim
5155:         CATCH TO loc_oErro
5156:             MsgErro(loc_oErro.Message, "FormMPD.OpOrigemChange")
5157:         ENDTRY
5158:     ENDPROC
5159: 
5160:     PROCEDURE OpDestinoChange()
5161:         LOCAL loc_oPg, loc_lSim
5162:         TRY
5163:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
5164:             loc_lSim = (loc_oPg.obj_4c_Op_destino.Value = 1)
5165:             loc_oPg.obj_4c_Get_Repete.Enabled  = loc_lSim
5166:             loc_oPg.txt_4c_GrupoDest.Enabled   = loc_lSim
5167:             loc_oPg.txt_4c_Dgrupod.Enabled     = loc_lSim
5168:             loc_oPg.txt_4c_ContaDest.Enabled   = loc_lSim
5169:             loc_oPg.txt_4c_Dcontad.Enabled     = loc_lSim
5170:             loc_oPg.chk_4c_Chk_Grupod.Enabled  = loc_lSim
5171:             loc_oPg.chk_4c_Chk_Contad.Enabled  = loc_lSim
5172:             loc_oPg.obj_4c_Op_ConDSub.Enabled  = loc_lSim
5173:         CATCH TO loc_oErro
5174:             MsgErro(loc_oErro.Message, "FormMPD.OpDestinoChange")
5175:         ENDTRY
5176:     ENDPROC
5177: 
5178:     PROCEDURE OpVendeChange()
5179:         LOCAL loc_oPg, loc_lSim
5180:         TRY
5181:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
5182:             loc_lSim = (loc_oPg.obj_4c_Op_vende.Value = 1)
5183:             loc_oPg.txt_4c_GrupoVend.Enabled  = loc_lSim
5184:             loc_oPg.txt_4c_Dgrupov.Enabled    = loc_lSim
5185:             loc_oPg.chk_4c_Chk_Grupov.Enabled = loc_lSim
5186:         CATCH TO loc_oErro
5187:             MsgErro(loc_oErro.Message, "FormMPD.OpVendeChange")
5188:         ENDTRY
5189:     ENDPROC
5190: 
5191:     PROCEDURE OpEstOrigChange()
5192:         LOCAL loc_oPg, loc_nOrig, loc_nDest
5193:         TRY
5194:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
5195:             loc_nOrig = loc_oPg.obj_4c_Op_EstOrig.Value
5196:             loc_nDest = loc_oPg.obj_4c_Op_EstDest.Value
5197:             IF loc_nOrig <> 3 AND loc_nOrig = loc_nDest
5198:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o de estoque conflitante.")
5199:                 loc_oPg.obj_4c_Op_EstOrig.Value = 3
5200:             ENDIF
5201:         CATCH TO loc_oErro
5202:             MsgErro(loc_oErro.Message, "FormMPD.OpEstOrigChange")
5203:         ENDTRY
5204:     ENDPROC
5205: 
5206:     PROCEDURE OpEstDestChange()
5207:         LOCAL loc_oPg, loc_nOrig, loc_nDest
5208:         TRY
5209:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
5210:             loc_nOrig = loc_oPg.obj_4c_Op_EstOrig.Value
5211:             loc_nDest = loc_oPg.obj_4c_Op_EstDest.Value
5212:             IF loc_nDest <> 3 AND loc_nDest = loc_nOrig
5213:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o de estoque conflitante.")
5214:                 loc_oPg.obj_4c_Op_EstDest.Value = 3
5215:             ENDIF
5216:         CATCH TO loc_oErro
5217:             MsgErro(loc_oErro.Message, "FormMPD.OpEstDestChange")
5218:         ENDTRY
5219:     ENDPROC
5220: 
5221:     * ============================================================
5222:     * LOOKUP HANDLERS - Componente
5223:     * ============================================================
5224:     PROCEDURE TpPadraoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5225:         IF par_nKeyCode = 116
5226:             THIS.AbrirLookupTpPadrao()
5227:         ENDIF
5228:     ENDPROC
5229: 
5230:     PROCEDURE AbrirLookupTpPadrao()
5231:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5232:         TRY
5233:             loc_cSQL = "SELECT Cods, Descrs FROM SigOpOpt ORDER BY Cods"
5234:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpPad")
5235:             IF loc_nResult >= 0
5236:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5237:                 loc_oFrm.this_cCursorDestino = "cursor_4c_TpPad"
5238:                 loc_oFrm.DefinirCursor("cursor_4c_TpPad", "Cods", "Descrs", "Tipo Padr" + CHR(227) + "o")
5239:                 loc_oFrm.Mostrar()
5240:                 IF loc_oFrm.this_lSelecionou
5241:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
5242:                     loc_oPg.txt_4c_TpPadrao.Value = loc_oFrm.cCodigoSelecionado
5243:                 ENDIF
5244:                 IF USED("cursor_4c_TpPad")
5245:                     USE IN cursor_4c_TpPad
5246:                 ENDIF
5247:             ELSE
5248:                 MsgErro("Erro ao buscar tipos.", "Erro")
5249:             ENDIF
5250:         CATCH TO loc_oErro
5251:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupTpPadrao")
5252:         ENDTRY
5253:     ENDPROC
5254: 
5255:     PROCEDURE RetalhoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5256:         IF par_nKeyCode = 116
5257:             THIS.AbrirLookupRetalho()
5258:         ENDIF
5259:     ENDPROC
5260: 
5261:     PROCEDURE AbrirLookupRetalho()
5262:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5263:         TRY
5264:             loc_cSQL = "SELECT Cods, Descrs FROM SigOpOpt ORDER BY Cods"
5265:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Retalho")
5266:             IF loc_nResult >= 0
5267:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5268:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Retalho"
5269:                 loc_oFrm.DefinirCursor("cursor_4c_Retalho", "Cods", "Descrs", "Retalho")
5270:                 loc_oFrm.Mostrar()
5271:                 IF loc_oFrm.this_lSelecionou
5272:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
5273:                     loc_oPg.txt_4c_Retalho.Value = loc_oFrm.cCodigoSelecionado
5274:                 ENDIF
5275:                 IF USED("cursor_4c_Retalho")
5276:                     USE IN cursor_4c_Retalho
5277:                 ENDIF
5278:             ELSE
5279:                 MsgErro("Erro ao buscar retalhos.", "Erro")
5280:             ENDIF
5281:         CATCH TO loc_oErro
5282:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupRetalho")
5283:         ENDTRY
5284:     ENDPROC
5285: 
5286:     PROCEDURE GrupoPccKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5287:         IF par_nKeyCode = 116
5288:             THIS.AbrirLookupGrupoPcc()
5289:         ENDIF
5290:     ENDPROC
5291: 
5292:     PROCEDURE AbrirLookupGrupoPcc()
5293:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5294:         TRY
5295:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5296:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoPcc")
5297:             IF loc_nResult >= 0
5298:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5299:                 loc_oFrm.this_cCursorDestino = "cursor_4c_GrupoPcc"
5300:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoPcc", "codigos", "descrs", "Fase PCC")
5301:                 loc_oFrm.Mostrar()
5302:                 IF loc_oFrm.this_lSelecionou
5303:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
5304:                     loc_oPg.txt_4c_GrupoPcc.Value = loc_oFrm.cCodigoSelecionado
5305:                 ENDIF
5306:                 IF USED("cursor_4c_GrupoPcc")
5307:                     USE IN cursor_4c_GrupoPcc
5308:                 ENDIF
5309:             ELSE
5310:                 MsgErro("Erro ao buscar grupos.", "Erro")
5311:             ENDIF
5312:         CATCH TO loc_oErro
5313:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoPcc")
5314:         ENDTRY
5315:     ENDPROC
5316: 
5317:     PROCEDURE ProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5318:         IF par_nKeyCode = 116
5319:             THIS.AbrirLookupProduto()
5320:         ENDIF
5321:     ENDPROC
5322: 
5323:     PROCEDURE AbrirLookupProduto()
5324:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5325:         TRY
5326:             loc_cSQL = "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros"
5327:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")
5328:             IF loc_nResult >= 0
5329:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5330:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Produto"
5331:                 loc_oFrm.DefinirCursor("cursor_4c_Produto", "cpros", "dpros", "Material Padr" + CHR(227) + "o")
5332:                 loc_oFrm.Mostrar()
5333:                 IF loc_oFrm.this_lSelecionou
5334:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
5335:                     loc_oPg.txt_4c__produto.Value = loc_oFrm.cCodigoSelecionado
5336:                 ENDIF
5337:                 IF USED("cursor_4c_Produto")
5338:                     USE IN cursor_4c_Produto
5339:                 ENDIF
5340:             ELSE
5341:                 MsgErro("Erro ao buscar produtos.", "Erro")
5342:             ENDIF
5343:         CATCH TO loc_oErro
5344:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupProduto")
5345:         ENDTRY
5346:     ENDPROC
5347: 
5348:     * ============================================================
5349:     * LOOKUP HANDLERS - Diversas
5350:     * ============================================================
5351:     PROCEDURE ObspadsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5352:         IF par_nKeyCode = 116
5353:             THIS.AbrirLookupObspads()
5354:         ENDIF
5355:     ENDPROC
5356: 
5357:     PROCEDURE AbrirLookupObspads()
5358:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5359:         TRY
5360:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs ORDER BY Codigos"
5361:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsPad")
5362:             IF loc_nResult >= 0
5363:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5364:                 loc_oFrm.this_cCursorDestino = "cursor_4c_ObsPad"
5365:                 loc_oFrm.DefinirCursor("cursor_4c_ObsPad", "Codigos", "Descrs", "Observa" + CHR(231) + CHR(227) + "o")
5366:                 loc_oFrm.Mostrar()
5367:                 IF loc_oFrm.this_lSelecionou
5368:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5369:                     loc_oPg.txt_4c_Obspads.Value = loc_oFrm.cCodigoSelecionado
5370:                 ENDIF
5371:                 IF USED("cursor_4c_ObsPad")
5372:                     USE IN cursor_4c_ObsPad
5373:                 ENDIF
5374:             ELSE
5375:                 MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
5376:             ENDIF
5377:         CATCH TO loc_oErro
5378:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupObspads")
5379:         ENDTRY
5380:     ENDPROC
5381: 
5382:     PROCEDURE ObsInisKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5383:         IF par_nKeyCode = 116
5384:             THIS.AbrirLookupObsInis()
5385:         ENDIF
5386:     ENDPROC
5387: 
5388:     PROCEDURE AbrirLookupObsInis()
5389:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5390:         TRY
5391:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs ORDER BY Codigos"
5392:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsIni")
5393:             IF loc_nResult >= 0
5394:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5395:                 loc_oFrm.this_cCursorDestino = "cursor_4c_ObsIni"
5396:                 loc_oFrm.DefinirCursor("cursor_4c_ObsIni", "Codigos", "Descrs", "Obs. Inicial")
5397:                 loc_oFrm.Mostrar()
5398:                 IF loc_oFrm.this_lSelecionou
5399:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5400:                     loc_oPg.txt_4c_ObsInis.Value = loc_oFrm.cCodigoSelecionado
5401:                 ENDIF
5402:                 IF USED("cursor_4c_ObsIni")
5403:                     USE IN cursor_4c_ObsIni
5404:                 ENDIF
5405:             ELSE
5406:                 MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
5407:             ENDIF
5408:         CATCH TO loc_oErro
5409:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupObsInis")
5410:         ENDTRY
5411:     ENDPROC
5412: 
5413:     PROCEDURE ObsFinsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5414:         IF par_nKeyCode = 116
5415:             THIS.AbrirLookupObsFins()
5416:         ENDIF
5417:     ENDPROC
5418: 
5419:     PROCEDURE AbrirLookupObsFins()
5420:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5421:         TRY
5422:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs ORDER BY Codigos"
5423:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsFin")
5424:             IF loc_nResult >= 0
5425:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5426:                 loc_oFrm.this_cCursorDestino = "cursor_4c_ObsFin"
5427:                 loc_oFrm.DefinirCursor("cursor_4c_ObsFin", "Codigos", "Descrs", "Obs. Final")
5428:                 loc_oFrm.Mostrar()
5429:                 IF loc_oFrm.this_lSelecionou
5430:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5431:                     loc_oPg.txt_4c_ObsFins.Value = loc_oFrm.cCodigoSelecionado
5432:                 ENDIF
5433:                 IF USED("cursor_4c_ObsFin")
5434:                     USE IN cursor_4c_ObsFin
5435:                 ENDIF
5436:             ELSE
5437:                 MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
5438:             ENDIF
5439:         CATCH TO loc_oErro
5440:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupObsFins")
5441:         ENDTRY
5442:     ENDPROC
5443: 
5444:     PROCEDURE GruFinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5445:         IF par_nKeyCode = 116
5446:             THIS.AbrirLookupGruFin()
5447:         ENDIF
5448:     ENDPROC
5449: 
5450:     PROCEDURE AbrirLookupGruFin()
5451:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5452:         TRY
5453:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5454:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruFin")
5455:             IF loc_nResult >= 0
5456:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5457:                 loc_oFrm.this_cCursorDestino = "cursor_4c_GruFin"
5458:                 loc_oFrm.DefinirCursor("cursor_4c_GruFin", "codigos", "descrs", "Grupo Financeiro")
5459:                 loc_oFrm.Mostrar()
5460:                 IF loc_oFrm.this_lSelecionou
5461:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5462:                     loc_oPg.txt_4c_GruFin.Value  = loc_oFrm.cCodigoSelecionado
5463:                     loc_oPg.txt_4c_DGruFin.Value = loc_oFrm.cDescricaoSelecionada
5464:                 ENDIF
5465:                 IF USED("cursor_4c_GruFin")
5466:                     USE IN cursor_4c_GruFin
5467:                 ENDIF
5468:             ELSE
5469:                 MsgErro("Erro ao buscar grupos.", "Erro")
5470:             ENDIF
5471:         CATCH TO loc_oErro
5472:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGruFin")
5473:         ENDTRY
5474:     ENDPROC
5475: 
5476:     PROCEDURE OpContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5477:         IF par_nKeyCode = 116
5478:             THIS.AbrirLookupOpConta()
5479:         ENDIF
5480:     ENDPROC
5481: 
5482:     PROCEDURE AbrirLookupOpConta()
5483:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5484:         TRY
5485:             loc_cSQL = "SELECT Dopes, Ndopes FROM SigOpOpe ORDER BY Dopes"
5486:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpConta")
5487:             IF loc_nResult >= 0
5488:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5489:                 loc_oFrm.this_cCursorDestino = "cursor_4c_OpConta"
5490:                 loc_oFrm.DefinirCursor("cursor_4c_OpConta", "Dopes", "Ndopes", "Opera" + CHR(231) + CHR(227) + "o Contas")
5491:                 loc_oFrm.Mostrar()
5492:                 IF loc_oFrm.this_lSelecionou
5493:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5494:                     loc_oPg.txt_4c_OpConta.Value = loc_oFrm.cCodigoSelecionado
5495:                 ENDIF
5496:                 IF USED("cursor_4c_OpConta")
5497:                     USE IN cursor_4c_OpConta
5498:                 ENDIF
5499:             ELSE
5500:                 MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
5501:             ENDIF
5502:         CATCH TO loc_oErro
5503:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupOpConta")
5504:         ENDTRY
5505:     ENDPROC
5506: 
5507:     PROCEDURE TpOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5508:         IF par_nKeyCode = 116
5509:             THIS.AbrirLookupTpOp()
5510:         ENDIF
5511:     ENDPROC
5512: 
5513:     PROCEDURE AbrirLookupTpOp()
5514:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5515:         TRY
5516:             loc_cSQL = "SELECT Codigos, Descrs FROM SigInTgo ORDER BY Codigos"
5517:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpOp")
5518:             IF loc_nResult >= 0
5519:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5520:                 loc_oFrm.this_cCursorDestino = "cursor_4c_TpOp"
5521:                 loc_oFrm.DefinirCursor("cursor_4c_TpOp", "Codigos", "Descrs", "Tipo de Ordem")
5522:                 loc_oFrm.Mostrar()
5523:                 IF loc_oFrm.this_lSelecionou
5524:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5525:                     loc_oPg.txt_4c_TpOp.Value = loc_oFrm.cCodigoSelecionado
5526:                 ENDIF
5527:                 IF USED("cursor_4c_TpOp")
5528:                     USE IN cursor_4c_TpOp
5529:                 ENDIF
5530:             ELSE
5531:                 MsgErro("Erro ao buscar tipos.", "Erro")
5532:             ENDIF
5533:         CATCH TO loc_oErro
5534:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupTpOp")
5535:         ENDTRY
5536:     ENDPROC
5537: 
5538:     PROCEDURE GruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5539:         IF par_nKeyCode = 116
5540:             THIS.AbrirLookupGruccus()
5541:         ENDIF
5542:     ENDPROC
5543: 
5544:     PROCEDURE AbrirLookupGruccus()
5545:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5546:         TRY
5547:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5548:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gruccus")
5549:             IF loc_nResult >= 0
5550:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5551:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Gruccus"
5552:                 loc_oFrm.DefinirCursor("cursor_4c_Gruccus", "codigos", "descrs", "Grupo C.C.")
5553:                 loc_oFrm.Mostrar()
5554:                 IF loc_oFrm.this_lSelecionou
5555:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5556:                     loc_oPg.txt_4c__gruccus.Value  = loc_oFrm.cCodigoSelecionado
5557:                     loc_oPg.txt_4c__dgruccus.Value = loc_oFrm.cDescricaoSelecionada
5558:                 ENDIF
5559:                 IF USED("cursor_4c_Gruccus")
5560:                     USE IN cursor_4c_Gruccus
5561:                 ENDIF
5562:             ELSE
5563:                 MsgErro("Erro ao buscar grupos.", "Erro")
5564:             ENDIF
5565:         CATCH TO loc_oErro
5566:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGruccus")
5567:         ENDTRY
5568:     ENDPROC
5569: 
5570:     PROCEDURE ContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5571:         IF par_nKeyCode = 116
5572:             THIS.AbrirLookupContaccus()
5573:         ENDIF
5574:     ENDPROC
5575: 
5576:     PROCEDURE AbrirLookupContaccus()
5577:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5578:         TRY
5579:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5580:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contaccus")
5581:             IF loc_nResult >= 0
5582:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5583:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Contaccus"
5584:                 loc_oFrm.DefinirCursor("cursor_4c_Contaccus", "codigos", "descrs", "Conta C.C.")
5585:                 loc_oFrm.Mostrar()
5586:                 IF loc_oFrm.this_lSelecionou
5587:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5588:                     loc_oPg.txt_4c__contaccus.Value  = loc_oFrm.cCodigoSelecionado
5589:                     loc_oPg.txt_4c__dcontaccus.Value = loc_oFrm.cDescricaoSelecionada
5590:                 ENDIF
5591:                 IF USED("cursor_4c_Contaccus")
5592:                     USE IN cursor_4c_Contaccus
5593:                 ENDIF
5594:             ELSE
5595:                 MsgErro("Erro ao buscar contas.", "Erro")
5596:             ENDIF
5597:         CATCH TO loc_oErro
5598:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupContaccus")
5599:         ENDTRY
5600:     ENDPROC
5601: 
5602:     PROCEDURE SemiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5603:         IF par_nKeyCode = 116
5604:             THIS.AbrirLookupSemi()
5605:         ENDIF
5606:     ENDPROC
5607: 
5608:     PROCEDURE AbrirLookupSemi()
5609:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5610:         TRY
5611:             loc_cSQL = "SELECT Dopps, hists FROM SigCdOpd ORDER BY Dopps"
5612:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Semi")
5613:             IF loc_nResult >= 0
5614:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5615:                 loc_oFrm.this_cCursorDestino = "cursor_4c_Semi"
5616:                 loc_oFrm.DefinirCursor("cursor_4c_Semi", "Dopps", "hists", "Opera" + CHR(231) + CHR(227) + "o Semiacabados")
5617:                 loc_oFrm.Mostrar()
5618:                 IF loc_oFrm.this_lSelecionou
5619:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5620:                     loc_oPg.txt_4c_Semi.Value = loc_oFrm.cCodigoSelecionado
5621:                 ENDIF
5622:                 IF USED("cursor_4c_Semi")
5623:                     USE IN cursor_4c_Semi
5624:                 ENDIF
5625:             ELSE
5626:                 MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
5627:             ENDIF
5628:         CATCH TO loc_oErro
5629:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupSemi")
5630:         ENDTRY
5631:     ENDPROC
5632: 
5633:     PROCEDURE AjustarBotoesPorModo()
5634:         LOCAL loc_oBotoes, loc_lTemSelecao
5635:         TRY
5636:             loc_oBotoes     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
5637:             loc_lTemSelecao = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
5638:             WITH loc_oBotoes
5639:                 .cmd_4c_Incluir.Enabled    = .T.
5640:                 .cmd_4c_Visualizar.Enabled = loc_lTemSelecao
5641:                 .cmd_4c_Alterar.Enabled    = loc_lTemSelecao
5642:                 .cmd_4c_Excluir.Enabled    = loc_lTemSelecao
5643:                 .cmd_4c_Buscar.Enabled     = .T.
5644:             ENDWITH
5645:         CATCH TO loc_oErro
5646:             MsgErro(loc_oErro.Message, "FormMPD.AjustarBotoesPorModo")
5647:         ENDTRY
5648:     ENDPROC
5649: 
5650:     PROCEDURE Destroy()
5651:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
5652:             THIS.this_oBusinessObject = .NULL.
5653:         ENDIF
5654:         DODEFAULT()
5655:     ENDPROC
5656: 
5657: ENDDEFINE


### BO (C:\4c\projeto\app\classes\MPDBO.prg):
* MPDBO.prg
* BO: Movimentacoes de Producao (SigCdOpd)

DEFINE CLASS MPDBO AS BusinessBase

  * ============================================================
  * IDENTIFICACAO
  * ============================================================
  this_cDopps      = ""    && char(20) - codigo da operacao (chave de negocio)
  this_nNdopps     = 0     && numeric(3) - numero da operacao
  this_nOrdes      = 0     && numeric(3) - ordem
  this_cCidchaves  = ""    && char(20) - PK tecnica do banco

  * ============================================================
  * ABA OPERACAO
  * ============================================================
  this_nSubns      = 0     && numeric(1) - tem subnivel (1=Sim 2=Nao)
  this_cNivels     = ""    && char(20) - subnivel
  this_cTnivels    = ""    && char(15) - titulo do subnivel
  this_cArtigos    = ""    && char(1)  - artigo do subnivel
  this_cCarqIcones = ""    && char(64) - arquivo icone
  this_nImagems    = 0     && numeric(1) - usa imagem
  this_nBoletos    = 0     && numeric(1) - gera boleto
  this_nMenus      = 0     && numeric(1) - exibe no menu
  this_nAutos      = 0     && numeric(1) - lancamento automatico
  this_nBxautos    = 0     && numeric(1) - baixa automatica
  this_nBtnpags    = 0     && numeric(1) - botao pagamento
  this_nBuscaenvs  = 0     && numeric(1) - busca envio
  this_nApontas    = 0     && numeric(1) - apontamento
  this_nChkdests   = 0     && numeric(2) - checkdests
  this_nCestoqs    = 0     && numeric(1) - centraliza estoques
  this_nChkfases   = 0     && numeric(1) - check fases
  this_nSeqs       = 0     && numeric(1) - sequencia
  this_nInibmens   = 0     && numeric(1) - inibe mensagem
  this_cHists      = ""    && char(30) - historico
  this_nMenfalhas  = 0     && numeric(1) - mensagem de falhas
  this_nBtnrets    = 0     && numeric(1) - botao retrabalho
  this_nBtnincs    = 0     && numeric(1) - botao inserir componente
  this_nExclsubns  = 0     && numeric(1) - excluir subnivel
  this_nEtiqenvs   = 0     && numeric(1) - etiqueta envio
  this_nChktemsubn = 0     && numeric(1) - tem subnivel check
  this_cDopemphs   = ""    && char(20) - operacao empenho
  this_cEmplancs   = ""    && char(3)  - empresa lancamento
  this_nBolops     = 0     && numeric(1) - boleto operacao
  this_nBolcomps   = 0     && numeric(1) - boleto componente
  this_nAgregas    = 0     && numeric(1) - agrega
  this_nTipoops    = 0     && numeric(2) - tipo operacao

  * ============================================================
  * ABA ESTOQUE
  * ============================================================
  this_nDocus      = 0     && numeric(1) - documentos
  this_nEstorigs   = 0     && numeric(1) - estoque origem
  this_nDestinos   = 0     && numeric(1) - destino
  this_nEstdests   = 0     && numeric(1) - estoque destino
  this_nCrepls     = 0     && numeric(1) - crepls
  this_nOrigems    = 0     && numeric(1) - origem (1=usa)
  this_nVends      = 0     && numeric(1) - venda
  this_nFixgorigs  = 0     && bit - fixa grupo origem
  this_nFixcorigs  = 0     && bit - fixa conta origem
  this_nFixgdests  = 0     && bit - fixa grupo destino
  this_nFixcdests  = 0     && bit - fixa conta destino
  this_nConosubs   = 0     && numeric(1) - con ori sub
  this_nCondsubs   = 0     && numeric(1) - con dest sub
  this_nBxoests    = 0     && numeric(1) - baixa estoque origem
  this_nBxdests    = 0     && numeric(1) - baixa estoque destino
  this_cGruorigs   = ""    && char(10) - grupo origem
  this_cGrudests   = ""    && char(10) - grupo destino
  this_cGrvends    = ""    && char(10) - grupo venda
  this_cConorigs   = ""    && char(10) - conta origem
  this_cCondests   = ""    && char(10) - conta destino
  this_nFixgvends  = 0     && bit - fixa grupo venda
  this_nSenhaos    = 0     && numeric(1) - senha origem
  this_nSenhads    = 0     && numeric(1) - senha destino
  this_cMascos     = ""    && char(10) - mascara origem
  this_cMascds     = ""    && char(10) - mascara destino
  this_nNumeras    = 0     && numeric(1) - numeracao

  * ============================================================
  * ABA COMPONENTE
  * ============================================================
  this_nGrcomps    = 0     && numeric(1) - grade componente
  this_nEtiqs      = 0     && numeric(1) - etiqueta
  this_nChkfunds   = 0     && numeric(1) - check fundo
  this_nGrodns     = 0     && numeric(1) - grade ordem
  this_nReinops    = 0     && numeric(1) - reinoperacao
  this_nMatprncdif = 0     && numeric(1) - mat principal diferente
  this_nResumopop  = 0     && numeric(1) - resumo op
  this_nQtdnegs    = 0     && numeric(1) - quantidade negativa
  this_nSeppedras  = 0     && numeric(1) - separacao pedras (1/3/4=sim)
  this_nTrfpesas   = 0     && numeric(1) - transfere pesas
  this_cPqs        = ""    && char(1) - pqs
  this_nPesobals   = 0     && numeric(1) - peso balanca
  this_nEnvobrigs  = 0     && numeric(1) - envio obrigatorio
  this_nMensagens  = 0     && numeric(1) - mensagens
  this_nPagservs   = 0     && numeric(1) - pagamento servico
  this_nGrprods    = 0     && numeric(1) - grade produto
  this_nCompagrus  = 0     && numeric(1) - componente agrupado
  this_nPesofixs   = 0     && numeric(1) - peso fixo
  this_nChkqtdps   = 0     && numeric(1) - chk qtd pcs
  this_cTppadraos  = ""    && char(15) - tipo padrao
  this_cRetalhos   = ""    && char(15) - retalho
  this_nValobrigs  = 0     && numeric(1) - valor obrigatorio
  this_nBxpedfins  = 0     && numeric(1) - baixa ped fins
  this_cPccfases   = ""    && char(10) - pcc fases
  this_nLimqtds    = 0     && numeric(9,3) - limite quantidade
  this_nDiflancs   = 0     && numeric(4,2) - diferenca lancamentos
  this_nDifpesags  = 0     && numeric(9,3) - diferenca pesagem
  this_nSinals     = 0     && numeric(1) - sinal
  this_nLibrpqs    = 0     && numeric(1) - libera pqs
  this_nAgseps     = 0     && numeric(1) - agrupamento separacao
  this_nQuebras    = 0     && numeric(1) - quebra
  this_nCravcers   = 0     && numeric(1) - cravacao cera
  this_nSolcdlbs   = 0     && numeric(1) - sol cd libs
  this_nNcarqtds   = 0     && numeric(1) - n car qtds
  this_cMatpads    = ""    && char(14) - material padrao
  this_nChkpesos   = 0     && numeric(1) - check pesos
  this_nChkmtprs   = 0     && numeric(1) - check mat principal
  this_nChkmetal   = 0     && numeric(1) - check metal

  * ============================================================
  * ABA DOCUMENTO
  * ============================================================
  this_nDckcabec   = 0     && numeric(1) - dck cabecalho
  this_nDckitens   = 0     && numeric(1) - dck itens
  this_nDckresu    = 0     && numeric(1) - dck resumo

  * ============================================================
  * ABA DIVERSAS
  * ============================================================
  this_nCasqtds    = 0     && numeric(2) - casas decimais qtd
  this_nObspads    = 0     && numeric(3) - obs padrao
  this_nObsinis    = 0     && numeric(3) - obs iniciais
  this_nObsfins    = 0     && numeric(3) - obs finais
  this_nCtrlotes   = 0     && numeric(1) - controle lotes
  this_nAcenvs     = 0     && numeric(1) - ac envios
  this_nEnvelopes  = 0     && numeric(1) - envelopes
  this_nChkunis    = 0     && numeric(1) - check unidade
  this_cGrufins    = ""    && char(10) - grupo financeiro
  this_nChkpesotot = 0     && numeric(1) - check peso total
  this_cDopcs      = ""    && char(20) - dop cs
  this_nPccs       = 0     && bit - pccs
  this_nPesmatps   = 0     && bit - peso mat principal
  this_nInibAlts   = 0     && bit - inibe alteracao
  this_nChkctdes   = 0     && numeric(1) - check ct des
  this_cCodtgops   = ""    && char(10) - cod tg ops
  this_cGruccus    = ""    && char(10) - grupo custo cus
  this_cContaccus  = ""    && char(10) - conta custo cus
  this_nChkoplts   = 0     && numeric(1) - check op lotes
  this_cDopsemis   = ""    && char(20) - dop semis
  this_nChksenexc  = 0     && numeric(1) - check senha exclusao
  this_nTpsenexc   = 0     && numeric(1) - tipo senha exclusao

  * ============================================================
  * INIT
  * ============================================================
  FUNCTION Init()
    DODEFAULT()
    this_cTabela     = "SigCdOpd"
    this_cCampoChave = "Dopps"
  ENDFUNC

  *--------------------------------------------------------------------------
  FUNCTION ObterChavePrimaria()
    RETURN THIS.this_cDopps
  ENDFUNC

  *--------------------------------------------------------------------------
  PROCEDURE Buscar(par_cFiltro)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "SELECT Dopps, Ndopps, Ordes, hists FROM SigCdOpd"
      IF !EMPTY(ALLTRIM(par_cFiltro))
        loc_cSQL = loc_cSQL + " WHERE Dopps LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
      ENDIF
      loc_cSQL = loc_cSQL + " ORDER BY Ndopps, Ordes"
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
      IF loc_nResultado >= 0
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROCEDURE CarregarPorCodigo(par_cDopps)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "SELECT * FROM SigCdOpd WHERE Dopps = " + EscaparSQL(par_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
      IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
        THIS.this_lNovoRegistro = .F.
      ENDIF
      IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
      IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
      ENDIF
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    LOCAL loc_lSucesso
    loc_lSucesso = .F.
    IF USED(par_cAliasCursor)
      SELECT (par_cAliasCursor)
      THIS.this_cDopps        = TratarNulo(Dopps,        "C")
      THIS.this_nNdopps       = TratarNulo(Ndopps,       "N")
      THIS.this_nOrdes        = TratarNulo(Ordes,        "N")
      THIS.this_cCidchaves    = TratarNulo(Cidchaves,    "C")
      THIS.this_nSubns        = TratarNulo(subns,        "N")
      THIS.this_nAgregas      = TratarNulo(agregas,      "N")
      THIS.this_cNivels       = TratarNulo(nivels,       "C")
      THIS.this_cTnivels      = TratarNulo(Tnivels,      "C")
      THIS.this_cArtigos      = TratarNulo(Artigos,      "C")
      THIS.this_cCarqIcones   = TratarNulo(cArqIcones,   "C")
      THIS.this_nImagems      = TratarNulo(imagems,      "N")
      THIS.this_nBoletos      = TratarNulo(boletos,      "N")
      THIS.this_nMenus        = TratarNulo(menus,        "N")
      THIS.this_nAutos        = TratarNulo(autos,        "N")
      THIS.this_nBxautos      = TratarNulo(bxautos,      "N")
      THIS.this_nBtnpags      = TratarNulo(btnpags,      "N")
      THIS.this_nBuscaenvs    = TratarNulo(BuscaEnvs,    "N")
      THIS.this_nApontas      = TratarNulo(apontas,      "N")
      THIS.this_nChkdests     = TratarNulo(ChkDests,     "N")
      THIS.this_nCestoqs      = TratarNulo(cestoqs,      "N")
      THIS.this_nChkfases     = TratarNulo(chkfases,     "N")
      THIS.this_nSeqs         = TratarNulo(seqs,         "N")
      THIS.this_nInibmens     = TratarNulo(Inibmens,     "N")
      THIS.this_cHists        = TratarNulo(hists,        "C")
      THIS.this_nMenfalhas    = TratarNulo(Menfalhas,    "N")
      THIS.this_nBtnrets      = TratarNulo(btnrets,      "N")
      THIS.this_nBtnincs      = TratarNulo(btnincs,      "N")
      THIS.this_nExclsubns    = TratarNulo(exclsubns,    "N")
      THIS.this_nEtiqenvs     = TratarNulo(etiqenvs,     "N")
      THIS.this_nChktemsubn   = TratarNulo(chkTemSubn,   "N")
      THIS.this_cDopemphs     = TratarNulo(dopemphs,     "C")
      THIS.this_cEmplancs     = TratarNulo(emplancs,     "C")
      THIS.this_nBolops       = TratarNulo(bolops,       "N")
      THIS.this_nBolcomps     = TratarNulo(bolcomps,     "N")
      THIS.this_nTipoops      = TratarNulo(tipoops,      "N")
      THIS.this_nDocus        = TratarNulo(Docus,        "N")
      THIS.this_nEstorigs     = TratarNulo(EstOrigs,     "N")
      THIS.this_nDestinos     = TratarNulo(Destinos,     "N")
      THIS.this_nEstdests     = TratarNulo(EstDests,     "N")
      THIS.this_nCrepls       = TratarNulo(CRepls,       "N")
      THIS.this_nOrigems      = TratarNulo(Origems,      "N")
      THIS.this_nVends        = TratarNulo(Vends,        "N")
      THIS.this_nFixgorigs    = TratarNulo(FixGOrigs,    "N")
      THIS.this_nFixcorigs    = TratarNulo(FixCOrigs,    "N")
      THIS.this_nFixgdests    = TratarNulo(FixGDests,    "N")
      THIS.this_nFixcdests    = TratarNulo(FixCDests,    "N")
      THIS.this_nConosubs     = TratarNulo(conosubs,     "N")
      THIS.this_nCondsubs     = TratarNulo(condsubs,     "N")
      THIS.this_nBxoests      = TratarNulo(BxOEsts,      "N")
      THIS.this_nBxdests      = TratarNulo(BxDEsts,      "N")
      THIS.this_cGruorigs     = TratarNulo(GruOrigs,     "C")
      THIS.this_cGrudests     = TratarNulo(GruDests,     "C")
      THIS.this_cGrvends      = TratarNulo(grvends,      "C")
      THIS.this_cConorigs     = TratarNulo(ConOrigs,     "C")
      THIS.this_cCondests     = TratarNulo(ConDests,     "C")
      THIS.this_nFixgvends    = TratarNulo(FixGVends,    "N")
      THIS.this_nSenhaos      = TratarNulo(Senhaos,      "N")
      THIS.this_nSenhads      = TratarNulo(Senhads,      "N")
      THIS.this_cMascos       = TratarNulo(mascos,       "C")
      THIS.this_cMascds       = TratarNulo(mascds,       "C")
      THIS.this_nNumeras      = TratarNulo(Numeras,      "N")
      THIS.this_nGrcomps      = TratarNulo(grcomps,      "N")
      THIS.this_nEtiqs        = TratarNulo(etiqs,        "N")
      THIS.this_nChkfunds     = TratarNulo(chkfunds,     "N")
      THIS.this_nGrodns       = TratarNulo(grodns,       "N")
      THIS.this_nReinops      = TratarNulo(reinops,      "N")
      THIS.this_nMatprncdif   = TratarNulo(MatPrncDif,   "N")
      THIS.this_nResumopop    = TratarNulo(ResumoPOp,    "N")
      THIS.this_nQtdnegs      = TratarNulo(QtdNegs,      "N")
      THIS.this_nSeppedras    = TratarNulo(seppedras,    "N")
      THIS.this_nTrfpesas     = TratarNulo(trfpesas,     "N")
      THIS.this_cPqs          = TratarNulo(Pqs,          "C")
      THIS.this_nPesobals     = TratarNulo(PesoBals,     "N")
      THIS.this_nEnvobrigs    = TratarNulo(EnvObrigs,    "N")
      THIS.this_nMensagens    = TratarNulo(mensagens,    "N")
      THIS.this_nPagservs     = TratarNulo(pagservs,     "N")
      THIS.this_nGrprods      = TratarNulo(grprods,      "N")
      THIS.this_nCompagrus    = TratarNulo(compagrus,    "N")
      THIS.this_nPesofixs     = TratarNulo(pesofixs,     "N")
      THIS.this_nChkqtdps     = TratarNulo(CHKQTDPS,    "N")
      THIS.this_cTppadraos    = TratarNulo(TpPadraos,    "C")
      THIS.this_cRetalhos     = TratarNulo(retalhos,     "C")
      THIS.this_nValobrigs    = TratarNulo(ValObrigs,    "N")
      THIS.this_nBxpedfins    = TratarNulo(BxPedFins,    "N")
      THIS.this_cPccfases     = TratarNulo(PccFases,     "C")
      THIS.this_nLimqtds      = TratarNulo(LimQtds,      "N")
      THIS.this_nDiflancs     = TratarNulo(diflancs,     "N")
      THIS.this_nDifpesags    = TratarNulo(difpesags,    "N")
      THIS.this_nSinals       = TratarNulo(Sinals,       "N")
      THIS.this_nLibrpqs      = TratarNulo(Librpqs,      "N")
      THIS.this_nAgseps       = TratarNulo(agseps,       "N")
      THIS.this_nQuebras      = TratarNulo(quebras,      "N")
      THIS.this_nCravcers     = TratarNulo(CravCers,     "N")
      THIS.this_nSolcdlbs     = TratarNulo(SolCdlbs,    "N")
      THIS.this_nNcarqtds     = TratarNulo(nCarQtds,    "N")
      THIS.this_cMatpads      = TratarNulo(MatPads,     "C")
      THIS.this_nChkpesos     = TratarNulo(chkPesos,    "N")
      THIS.this_nChkmtprs     = TratarNulo(ChkMtPrs,    "N")
      THIS.this_nChkmetal     = TratarNulo(chkMetal,    "N")
      THIS.this_nDckcabec     = TratarNulo(dckcabec,    "N")
      THIS.this_nDckitens     = TratarNulo(dckItens,    "N")
      THIS.this_nDckresu      = TratarNulo(dckResu,     "N")
      THIS.this_nCasqtds      = TratarNulo(CasQtds,    "N")
      THIS.this_nObspads      = TratarNulo(obspads,     "N")
      THIS.this_nObsinis      = TratarNulo(obsinis,     "N")
      THIS.this_nObsfins      = TratarNulo(obsfins,     "N")
      THIS.this_nCtrlotes     = TratarNulo(CtrLotes,    "N")
      THIS.this_nAcenvs       = TratarNulo(AcEnvs,      "N")
      THIS.this_nEnvelopes    = TratarNulo(envelopes,   "N")
      THIS.this_nChkunis      = TratarNulo(chkunis,     "N")
      THIS.this_cGrufins      = TratarNulo(grufins,     "C")
      THIS.this_nChkpesotot   = TratarNulo(chkPesoTot, "N")
      THIS.this_cDopcs        = TratarNulo(dopcs,       "C")
      THIS.this_nPccs         = TratarNulo(pccs,        "N")
      THIS.this_nPesmatps     = TratarNulo(pesmatps,    "N")
      THIS.this_nInibAlts     = TratarNulo(InibAlts,    "N")
      THIS.this_nChkctdes     = TratarNulo(ChkCtDes,   "N")
      THIS.this_cCodtgops     = TratarNulo(CodTgOps,   "C")
      THIS.this_cGruccus      = TratarNulo(gruccus,    "C")
      THIS.this_cContaccus    = TratarNulo(contaccus,  "C")
      THIS.this_nChkoplts     = TratarNulo(chkoplts,   "N")
      THIS.this_cDopsemis     = TratarNulo(dopsemis,   "C")
      THIS.this_nChksenexc    = TratarNulo(chksenexc,  "N")
      THIS.this_nTpsenexc     = TratarNulo(tpsenexc,   "N")
      loc_lSucesso = .T.
    ENDIF
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE Inserir()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "INSERT INTO SigCdOpd (" + ;
                 "Dopps, Ndopps, Ordes, Cidchaves," + ;
                 " subns, agregas, nivels, Tnivels, Artigos, cArqIcones," + ;
                 " imagems, boletos, menus, autos, bxautos, btnpags, BuscaEnvs," + ;
                 " apontas, ChkDests, cestoqs, chkfases, seqs, Inibmens, hists," + ;
                 " Menfalhas, btnrets, btnincs, exclsubns, etiqenvs, chkTemSubn," + ;
                 " dopemphs, emplancs, bolops, bolcomps, tipoops," + ;
                 " Docus, EstOrigs, Destinos, EstDests, CRepls, Origems, Vends," + ;
                 " FixGOrigs, FixCOrigs, FixGDests, FixCDests, conosubs, condsubs," + ;
                 " BxOEsts, BxDEsts, GruOrigs, GruDests, grvends, ConOrigs, ConDests," + ;
                 " FixGVends, Senhaos, Senhads, mascos, mascds, Numeras," + ;
                 " grcomps, etiqs, chkfunds, grodns, reinops, MatPrncDif, ResumoPOp," + ;
                 " QtdNegs, seppedras, trfpesas, Pqs, PesoBals, EnvObrigs, mensagens," + ;
                 " pagservs, grprods, compagrus, pesofixs, CHKQTDPS, TpPadraos, retalhos," + ;
                 " ValObrigs, BxPedFins, PccFases, LimQtds, diflancs, difpesags, Sinals," + ;
                 " Librpqs, agseps, quebras, CravCers, SolCdlbs, nCarQtds, MatPads," + ;
                 " chkPesos, ChkMtPrs, chkMetal," + ;
                 " dckcabec, dckItens, dckResu," + ;
                 " CasQtds, obspads, obsinis, obsfins, CtrLotes, AcEnvs, envelopes," + ;
                 " chkunis, grufins, chkPesoTot, dopcs, pccs, pesmatps, InibAlts," + ;
                 " ChkCtDes, CodTgOps, gruccus, contaccus, chkoplts, dopsemis, chksenexc, tpsenexc" + ;
                 ") VALUES (" + ;
                 EscaparSQL(THIS.this_cDopps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNdopps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nOrdes) + "," + ;
                 EscaparSQL(THIS.this_cCidchaves) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSubns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAgregas) + "," + ;
                 EscaparSQL(THIS.this_cNivels) + "," + ;
                 EscaparSQL(THIS.this_cTnivels) + "," + ;
                 EscaparSQL(THIS.this_cArtigos) + "," + ;
                 EscaparSQL(THIS.this_cCarqIcones) + "," + ;
                 FormatarNumeroSQL(THIS.this_nImagems) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBoletos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMenus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAutos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxautos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnpags) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBuscaenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nApontas) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCestoqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkfases) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSeqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nInibmens) + "," + ;
                 EscaparSQL(THIS.this_cHists) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMenfalhas) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnrets) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnincs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nExclsubns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEtiqenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChktemsubn) + "," + ;
                 EscaparSQL(THIS.this_cDopemphs) + "," + ;
                 EscaparSQL(THIS.this_cEmplancs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBolops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBolcomps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTipoops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDocus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEstorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDestinos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEstdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCrepls) + "," + ;
                 FormatarNumeroSQL(THIS.this_nOrigems) + "," + ;
                 FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixcorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixcdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nConosubs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCondsubs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxoests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxdests) + "," + ;
                 EscaparSQL(THIS.this_cGruorigs) + "," + ;
                 EscaparSQL(THIS.this_cGrudests) + "," + ;
                 EscaparSQL(THIS.this_cGrvends) + "," + ;
                 EscaparSQL(THIS.this_cConorigs) + "," + ;
                 EscaparSQL(THIS.this_cCondests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgvends) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSenhaos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSenhads) + "," + ;
                 EscaparSQL(THIS.this_cMascos) + "," + ;
                 EscaparSQL(THIS.this_cMascds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNumeras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrcomps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEtiqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkfunds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrodns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nReinops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMatprncdif) + "," + ;
                 FormatarNumeroSQL(THIS.this_nResumopop) + "," + ;
                 FormatarNumeroSQL(THIS.this_nQtdnegs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSeppedras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                 EscaparSQL(THIS.this_cPqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesobals) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEnvobrigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMensagens) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPagservs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrprods) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesofixs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkqtdps) + "," + ;
                 EscaparSQL(THIS.this_cTppadraos) + "," + ;
                 EscaparSQL(THIS.this_cRetalhos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nValobrigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxpedfins) + "," + ;
                 EscaparSQL(THIS.this_cPccfases) + "," + ;
                 FormatarNumeroSQL(THIS.this_nLimqtds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDiflancs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                 FormatarNumeroSQL(THIS.this_nLibrpqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAgseps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nQuebras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCravcers) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSolcdlbs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNcarqtds) + "," + ;
                 EscaparSQL(THIS.this_cMatpads) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkpesos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkmtprs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkmetal) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckcabec) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckitens) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckresu) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCasqtds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObspads) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObsinis) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObsfins) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAcenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEnvelopes) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkunis) + "," + ;
                 EscaparSQL(THIS.this_cGrufins) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkpesotot) + "," + ;
                 EscaparSQL(THIS.this_cDopcs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPccs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesmatps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nInibAlts) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkctdes) + "," + ;
                 EscaparSQL(THIS.this_cCodtgops) + "," + ;
                 EscaparSQL(THIS.this_cGruccus) + "," + ;
                 EscaparSQL(THIS.this_cContaccus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkoplts) + "," + ;
                 EscaparSQL(THIS.this_cDopsemis) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChksenexc) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTpsenexc) + ;
                 ")"
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("INSERT")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE Atualizar()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "UPDATE SigCdOpd SET" + ;
                 " Ndopps = " + FormatarNumeroSQL(THIS.this_nNdopps) + "," + ;
                 " Ordes = " + FormatarNumeroSQL(THIS.this_nOrdes) + "," + ;
                 " subns = " + FormatarNumeroSQL(THIS.this_nSubns) + "," + ;
                 " agregas = " + FormatarNumeroSQL(THIS.this_nAgregas) + "," + ;
                 " nivels = " + EscaparSQL(THIS.this_cNivels) + "," + ;
                 " Tnivels = " + EscaparSQL(THIS.this_cTnivels) + "," + ;
                 " Artigos = " + EscaparSQL(THIS.this_cArtigos) + "," + ;
                 " cArqIcones = " + EscaparSQL(THIS.this_cCarqIcones) + "," + ;
                 " imagems = " + FormatarNumeroSQL(THIS.this_nImagems) + "," + ;
                 " boletos = " + FormatarNumeroSQL(THIS.this_nBoletos) + "," + ;
                 " menus = " + FormatarNumeroSQL(THIS.this_nMenus) + "," + ;
                 " autos = " + FormatarNumeroSQL(THIS.this_nAutos) + "," + ;
                 " bxautos = " + FormatarNumeroSQL(THIS.this_nBxautos) + "," + ;
                 " btnpags = " + FormatarNumeroSQL(THIS.this_nBtnpags) + "," + ;
                 " BuscaEnvs = " + FormatarNumeroSQL(THIS.this_nBuscaenvs) + "," + ;
                 " apontas = " + FormatarNumeroSQL(THIS.this_nApontas) + "," + ;
                 " ChkDests = " + FormatarNumeroSQL(THIS.this_nChkdests) + "," + ;
                 " cestoqs = " + FormatarNumeroSQL(THIS.this_nCestoqs) + "," + ;
                 " chkfases = " + FormatarNumeroSQL(THIS.this_nChkfases) + "," + ;
                 " seqs = " + FormatarNumeroSQL(THIS.this_nSeqs) + "," + ;
                 " Inibmens = " + FormatarNumeroSQL(THIS.this_nInibmens) + "," + ;
                 " hists = " + EscaparSQL(THIS.this_cHists) + "," + ;
                 " Menfalhas = " + FormatarNumeroSQL(THIS.this_nMenfalhas) + "," + ;
                 " btnrets = " + FormatarNumeroSQL(THIS.this_nBtnrets) + "," + ;
                 " btnincs = " + FormatarNumeroSQL(THIS.this_nBtnincs) + "," + ;
                 " exclsubns = " + FormatarNumeroSQL(THIS.this_nExclsubns) + "," + ;
                 " etiqenvs = " + FormatarNumeroSQL(THIS.this_nEtiqenvs) + "," + ;
                 " chkTemSubn = " + FormatarNumeroSQL(THIS.this_nChktemsubn) + "," + ;
                 " dopemphs = " + EscaparSQL(THIS.this_cDopemphs) + "," + ;
                 " emplancs = " + EscaparSQL(THIS.this_cEmplancs) + "," + ;
                 " bolops = " + FormatarNumeroSQL(THIS.this_nBolops) + "," + ;
                 " bolcomps = " + FormatarNumeroSQL(THIS.this_nBolcomps) + "," + ;
                 " tipoops = " + FormatarNumeroSQL(THIS.this_nTipoops) + "," + ;
                 " Docus = " + FormatarNumeroSQL(THIS.this_nDocus) + "," + ;
                 " EstOrigs = " + FormatarNumeroSQL(THIS.this_nEstorigs) + "," + ;
                 " Destinos = " + FormatarNumeroSQL(THIS.this_nDestinos) + "," + ;
                 " EstDests = " + FormatarNumeroSQL(THIS.this_nEstdests) + "," + ;
                 " CRepls = " + FormatarNumeroSQL(THIS.this_nCrepls) + "," + ;
                 " Origems = " + FormatarNumeroSQL(THIS.this_nOrigems) + "," + ;
                 " Vends = " + FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                 " FixGOrigs = " + FormatarNumeroSQL(THIS.this_nFixgorigs) + "," + ;
                 " FixCOrigs = " + FormatarNumeroSQL(THIS.this_nFixcorigs) + "," + ;
                 " FixGDests = " + FormatarNumeroSQL(THIS.this_nFixgdests) + "," + ;
                 " FixCDests = " + FormatarNumeroSQL(THIS.this_nFixcdests) + "," + ;
                 " conosubs = " + FormatarNumeroSQL(THIS.this_nConosubs) + "," + ;
                 " condsubs = " + FormatarNumeroSQL(THIS.this_nCondsubs) + "," + ;
                 " BxOEsts = " + FormatarNumeroSQL(THIS.this_nBxoests) + "," + ;
                 " BxDEsts = " + FormatarNumeroSQL(THIS.this_nBxdests) + "," + ;
                 " GruOrigs = " + EscaparSQL(THIS.this_cGruorigs) + "," + ;
                 " GruDests = " + EscaparSQL(THIS.this_cGrudests) + "," + ;
                 " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                 " ConOrigs = " + EscaparSQL(THIS.this_cConorigs) + "," + ;
                 " ConDests = " + EscaparSQL(THIS.this_cCondests) + "," + ;
                 " FixGVends = " + FormatarNumeroSQL(THIS.this_nFixgvends) + "," + ;
                 " Senhaos = " + FormatarNumeroSQL(THIS.this_nSenhaos) + "," + ;
                 " Senhads = " + FormatarNumeroSQL(THIS.this_nSenhads) + "," + ;
                 " mascos = " + EscaparSQL(THIS.this_cMascos) + "," + ;
                 " mascds = " + EscaparSQL(THIS.this_cMascds) + "," + ;
                 " Numeras = " + FormatarNumeroSQL(THIS.this_nNumeras) + "," + ;
                 " grcomps = " + FormatarNumeroSQL(THIS.this_nGrcomps) + "," + ;
                 " etiqs = " + FormatarNumeroSQL(THIS.this_nEtiqs) + "," + ;
                 " chkfunds = " + FormatarNumeroSQL(THIS.this_nChkfunds) + "," + ;
                 " grodns = " + FormatarNumeroSQL(THIS.this_nGrodns) + "," + ;
                 " reinops = " + FormatarNumeroSQL(THIS.this_nReinops) + "," + ;
                 " MatPrncDif = " + FormatarNumeroSQL(THIS.this_nMatprncdif) + "," + ;
                 " ResumoPOp = " + FormatarNumeroSQL(THIS.this_nResumopop) + "," + ;
                 " QtdNegs = " + FormatarNumeroSQL(THIS.this_nQtdnegs) + "," + ;
                 " seppedras = " + FormatarNumeroSQL(THIS.this_nSeppedras) + "," + ;
                 " trfpesas = " + FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                 " Pqs = " + EscaparSQL(THIS.this_cPqs) + "," + ;
                 " PesoBals = " + FormatarNumeroSQL(THIS.this_nPesobals) + "," + ;
                 " EnvObrigs = " + FormatarNumeroSQL(THIS.this_nEnvobrigs) + "," + ;
                 " mensagens = " + FormatarNumeroSQL(THIS.this_nMensagens) + "," + ;
                 " pagservs = " + FormatarNumeroSQL(THIS.this_nPagservs) + "," + ;
                 " grprods = " + FormatarNumeroSQL(THIS.this_nGrprods) + "," + ;
                 " compagrus = " + FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                 " pesofixs = " + FormatarNumeroSQL(THIS.this_nPesofixs) + "," + ;
                 " CHKQTDPS = " + FormatarNumeroSQL(THIS.this_nChkqtdps) + "," + ;
                 " TpPadraos = " + EscaparSQL(THIS.this_cTppadraos) + "," + ;
                 " retalhos = " + EscaparSQL(THIS.this_cRetalhos) + "," + ;
                 " ValObrigs = " + FormatarNumeroSQL(THIS.this_nValobrigs) + "," + ;
                 " BxPedFins = " + FormatarNumeroSQL(THIS.this_nBxpedfins) + "," + ;
                 " PccFases = " + EscaparSQL(THIS.this_cPccfases) + "," + ;
                 " LimQtds = " + FormatarNumeroSQL(THIS.this_nLimqtds) + "," + ;
                 " diflancs = " + FormatarNumeroSQL(THIS.this_nDiflancs) + "," + ;
                 " difpesags = " + FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                 " Sinals = " + FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                 " Librpqs = " + FormatarNumeroSQL(THIS.this_nLibrpqs) + "," + ;
                 " agseps = " + FormatarNumeroSQL(THIS.this_nAgseps) + "," + ;
                 " quebras = " + FormatarNumeroSQL(THIS.this_nQuebras) + "," + ;
                 " CravCers = " + FormatarNumeroSQL(THIS.this_nCravcers) + "," + ;
                 " SolCdlbs = " + FormatarNumeroSQL(THIS.this_nSolcdlbs) + "," + ;
                 " nCarQtds = " + FormatarNumeroSQL(THIS.this_nNcarqtds) + "," + ;
                 " MatPads = " + EscaparSQL(THIS.this_cMatpads) + "," + ;
                 " chkPesos = " + FormatarNumeroSQL(THIS.this_nChkpesos) + "," + ;
                 " ChkMtPrs = " + FormatarNumeroSQL(THIS.this_nChkmtprs) + "," + ;
                 " chkMetal = " + FormatarNumeroSQL(THIS.this_nChkmetal) + "," + ;
                 " dckcabec = " + FormatarNumeroSQL(THIS.this_nDckcabec) + "," + ;
                 " dckItens = " + FormatarNumeroSQL(THIS.this_nDckitens) + "," + ;
                 " dckResu = " + FormatarNumeroSQL(THIS.this_nDckresu) + "," + ;
                 " CasQtds = " + FormatarNumeroSQL(THIS.this_nCasqtds) + "," + ;
                 " obspads = " + FormatarNumeroSQL(THIS.this_nObspads) + "," + ;
                 " obsinis = " + FormatarNumeroSQL(THIS.this_nObsinis) + "," + ;
                 " obsfins = " + FormatarNumeroSQL(THIS.this_nObsfins) + "," + ;
                 " CtrLotes = " + FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                 " AcEnvs = " + FormatarNumeroSQL(THIS.this_nAcenvs) + "," + ;
                 " envelopes = " + FormatarNumeroSQL(THIS.this_nEnvelopes) + "," + ;
                 " chkunis = " + FormatarNumeroSQL(THIS.this_nChkunis) + "," + ;
                 " grufins = " + EscaparSQL(THIS.this_cGrufins) + "," + ;
                 " chkPesoTot = " + FormatarNumeroSQL(THIS.this_nChkpesotot) + "," + ;
                 " dopcs = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                 " pccs = " + FormatarNumeroSQL(THIS.this_nPccs) + "," + ;
                 " pesmatps = " + FormatarNumeroSQL(THIS.this_nPesmatps) + "," + ;
                 " InibAlts = " + FormatarNumeroSQL(THIS.this_nInibAlts) + "," + ;
                 " ChkCtDes = " + FormatarNumeroSQL(THIS.this_nChkctdes) + "," + ;
                 " CodTgOps = " + EscaparSQL(THIS.this_cCodtgops) + "," + ;
                 " gruccus = " + EscaparSQL(THIS.this_cGruccus) + "," + ;
                 " contaccus = " + EscaparSQL(THIS.this_cContaccus) + "," + ;
                 " chkoplts = " + FormatarNumeroSQL(THIS.this_nChkoplts) + "," + ;
                 " dopsemis = " + EscaparSQL(THIS.this_cDopsemis) + "," + ;
                 " chksenexc = " + FormatarNumeroSQL(THIS.this_nChksenexc) + "," + ;
                 " tpsenexc = " + FormatarNumeroSQL(THIS.this_nTpsenexc) + ;
                 " WHERE Dopps = " + EscaparSQL(THIS.this_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("UPDATE")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE ExecutarExclusao()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "DELETE FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("DELETE")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

ENDDEFINE

