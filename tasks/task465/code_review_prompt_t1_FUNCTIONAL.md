# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (104)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [GRID-WITH] Bloco WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource).
- [GRID-WITH] Bloco WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource).
- [LAYOUT-POSITION] Controle 'Op_subn' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=141 vs migrado 'obj_4c_Op_subn' Left=3 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_agregas' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Op_agregas' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_imagem' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=108 vs migrado 'obj_4c_Op_imagem' Left=3 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_boleto' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=108 vs migrado 'obj_4c_Op_boleto' Left=3 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Menu' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=108 vs migrado 'obj_4c_Opt_Menu' Left=3 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjAutos' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=108 vs migrado 'obj_4c_ObjAutos' Left=3 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_BxAuto' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=141 vs migrado 'obj_4c_Op_BxAuto' Left=3 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Objpagamento' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Objpagamento' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjBusEnv' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_ObjBusEnv' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption4' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Fwoption4' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_tipomov' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=302 vs migrado 'obj_4c_Opt_tipomov' Top=2 (diff=300px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_tipomov' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=665 vs migrado 'obj_4c_Opt_tipomov' Left=3 (diff=662px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_Saldo' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Op_Saldo' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_repete' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Op_repete' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GetSequencia' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_GetSequencia' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_inib' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Op_inib' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjMenFalha' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_ObjMenFalha' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjRetrabs' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_ObjRetrabs' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Objnaoconform' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Objnaoconform' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=303 vs migrado 'obj_4c_Fwoption2' Top=92 (diff=211px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=141 vs migrado 'obj_4c_Fwoption2' Left=3 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=656 vs migrado 'obj_4c_Fwoption3' Left=3 (diff=653px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=323 vs migrado 'obj_4c_Fwoption1' Top=71 (diff=252px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=141 vs migrado 'obj_4c_Fwoption1' Left=3 (diff=138px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption5' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Top original=73 vs migrado 'obj_4c_Fwoption5' Top=338 (diff=265px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption5' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=107 vs migrado 'obj_4c_Fwoption5' Left=3 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_compo' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=107 vs migrado 'obj_4c_Opt_compo' Left=3 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption8' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgOperacao): Left original=108 vs migrado 'obj_4c_Fwoption8' Left=3 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_EstOrig' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=468 vs migrado 'obj_4c_Op_EstOrig' Left=3 (diff=465px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_destino' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=94 vs migrado 'obj_4c_Op_destino' Left=3 (diff=91px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_EstDest' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=468 vs migrado 'obj_4c_Op_EstDest' Left=3 (diff=465px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Get_Repete' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=380 vs migrado 'obj_4c_Get_Repete' Left=3 (diff=377px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_origem' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=94 vs migrado 'obj_4c_Op_origem' Left=3 (diff=91px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_vende' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=104 vs migrado 'obj_4c_Op_vende' Left=3 (diff=101px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_ConOSub' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=467 vs migrado 'obj_4c_Op_ConOSub' Left=3 (diff=464px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_ConDSub' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=468 vs migrado 'obj_4c_Op_ConDSub' Left=3 (diff=465px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_BxOEst' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=467 vs migrado 'obj_4c_Op_BxOEst' Left=3 (diff=464px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_BxDEst' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgEstoque): Left original=468 vs migrado 'obj_4c_Op_BxDEst' Left=3 (diff=465px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_grcomp' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=183 vs migrado 'obj_4c_Op_grcomp' Left=3 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_etiq' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_Op_etiq' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_Chkf' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_Chkf' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_GrTrans' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=270 vs migrado 'obj_4c_Op_GrTrans' Top=2 (diff=268px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_GrTrans' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_Op_GrTrans' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjReinop' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_ObjReinop' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptMatPrncDif' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=627 vs migrado 'obj_4c_OptMatPrncDif' Left=3 (diff=624px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=370 vs migrado 'obj_4c_Fwoption3' Top=196 (diff=174px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Fwoption3' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optqtdneg' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Optqtdneg' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_SepPedra' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=69 vs migrado 'obj_4c_Op_SepPedra' Top=2 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_SepPedra' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=183 vs migrado 'obj_4c_Op_SepPedra' Left=3 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Chk_TrfPeso' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=253 vs migrado 'obj_4c_Chk_TrfPeso' Top=2 (diff=251px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Chk_TrfPeso' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Chk_TrfPeso' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_pesobal' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_pesobal' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_env' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_env' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_mens' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_mens' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_PagSer' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_PagSer' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Op_grprod' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=183 vs migrado 'obj_4c_Op_grprod' Left=3 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_compagru' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=183 vs migrado 'obj_4c_Op_compagru' Left=3 (diff=180px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_fix' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Opc_fix' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjChkQP' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=306 vs migrado 'obj_4c_ObjChkQP' Top=2 (diff=304px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjChkQP' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_ObjChkQP' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=215 vs migrado 'obj_4c_Fwoption1' Top=71 (diff=144px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=626 vs migrado 'obj_4c_Fwoption1' Left=3 (diff=623px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optBxPedFins' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_OptBxPedFins' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_quebraimp' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_Opt_quebraimp' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_cravacera' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_Opt_cravacera' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_codlib' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=182 vs migrado 'obj_4c_Opt_codlib' Left=3 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Top original=210 vs migrado 'obj_4c_Fwoption2' Top=92 (diff=118px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgComponente): Left original=181 vs migrado 'obj_4c_Fwoption2' Left=3 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDocumento): Left original=176 vs migrado 'obj_4c_Optiongroup1' Left=3 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDocumento): Left original=176 vs migrado 'obj_4c_Optiongroup2' Left=3 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDocumento): Left original=176 vs migrado 'obj_4c_Optiongroup3' Left=3 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption4' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=180 vs migrado 'obj_4c_Fwoption4' Left=3 (diff=177px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption3' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=180 vs migrado 'obj_4c_Fwoption3' Left=3 (diff=177px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption2' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=181 vs migrado 'obj_4c_Fwoption2' Left=3 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=181 vs migrado 'obj_4c_Fwoption1' Left=3 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption5' (parent: SIGCDMPD.Pagina.Dados.PagDados.PgDiversos): Left original=184 vs migrado 'obj_4c_Fwoption5' Left=3 (diff=181px, tolerancia=30px)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMPD.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5303 linhas total):

*-- Linhas 18 a 114:
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
69:         CATCH TO loException
70:             MostrarErro(loException, "FormMPD.ConfigurarPageFrame")
71:         ENDTRY
72:     ENDPROC
73: 
74:     PROTECTED PROCEDURE ConfigurarContaineresPage1()
75:         LOCAL loc_oPg
76:         loc_oPg = THIS.pgf_4c_Paginas.Page1
77:         TRY
78:             loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
79:             WITH loc_oPg.cnt_4c_Cabecalho
80:                 .Top        = 31
81:                 .Left       = 0
82:                 .Width      = THIS.Width
83:                 .Height     = 80
84:                 .BackColor  = RGB(100, 100, 100)
85:                 .BorderWidth = 0
86:                 .Visible    = .T.
87:                 .AddObject("lbl_4c_Sombra", "Label")
88:                 WITH .lbl_4c_Sombra
89:                     .Top      = 15
90:                     .Left     = 12
91:                     .Width    = THIS.Width
92:                     .Height   = 40
93:                     .AutoSize = .F.
94:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
95:                         "es de Produ" + CHR(231) + CHR(227) + "o"
96:                     .FontName = "Tahoma"
97:                     .FontSize = 16
98:                     .FontBold = .T.
99:                     .ForeColor = RGB(0,0,0)
100:                     .BackStyle = 0
101:                     .Visible  = .T.
102:                 ENDWITH
103:                 .AddObject("lbl_4c_Titulo", "Label")
104:                 WITH .lbl_4c_Titulo
105:                     .Top      = 18
106:                     .Left     = 10
107:                     .Width    = THIS.Width
108:                     .Height   = 46
109:                     .AutoSize = .F.
110:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
111:                         "es de Produ" + CHR(231) + CHR(227) + "o"
112:                     .FontName = "Tahoma"
113:                     .FontSize = 16
114:                     .FontBold = .T.

*-- Linhas 143 a 186:
143:         ENDTRY
144:     ENDPROC
145: 
146:     PROTECTED PROCEDURE ConfigurarContaineresPage2()
147:         LOCAL loc_oPg
148:         loc_oPg = THIS.pgf_4c_Paginas.Page2
149:         TRY
150:             loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
151:             WITH loc_oPg.cnt_4c_Cabecalho
152:                 .Top        = 31
153:                 .Left       = 0
154:                 .Width      = THIS.Width
155:                 .Height     = 80
156:                 .BackColor  = RGB(100, 100, 100)
157:                 .BorderWidth = 0
158:                 .Visible    = .T.
159:                 .AddObject("lbl_4c_Sombra", "Label")
160:                 WITH .lbl_4c_Sombra
161:                     .Top      = 15
162:                     .Left     = 12
163:                     .Width    = THIS.Width
164:                     .Height   = 40
165:                     .AutoSize = .F.
166:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
167:                         "es de Produ" + CHR(231) + CHR(227) + "o"
168:                     .FontName = "Tahoma"
169:                     .FontSize = 16
170:                     .FontBold = .T.
171:                     .ForeColor = RGB(0,0,0)
172:                     .BackStyle = 0
173:                     .Visible  = .T.
174:                 ENDWITH
175:                 .AddObject("lbl_4c_Titulo", "Label")
176:                 WITH .lbl_4c_Titulo
177:                     .Top      = 18
178:                     .Left     = 10
179:                     .Width    = THIS.Width
180:                     .Height   = 46
181:                     .AutoSize = .F.
182:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
183:                         "es de Produ" + CHR(231) + CHR(227) + "o"
184:                     .FontName = "Tahoma"
185:                     .FontSize = 16
186:                     .FontBold = .T.

*-- Linhas 213 a 358:
213:         ENDTRY
214:     ENDPROC
215: 
216:     PROTECTED PROCEDURE ConfigurarPaginaLista()
217:         LOCAL loc_oPg, loc_oCnt
218:         loc_oPg = THIS.pgf_4c_Paginas.Page1
219:         TRY
220:             loc_oCnt = loc_oPg.cnt_4c_Botoes
221:             loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
222:             WITH loc_oCnt.cmd_4c_Incluir
223:                 .Top      = 5
224:                 .Left     = 5
225:                 .Width    = 75
226:                 .Height   = 75
227:                 .Caption  = "Incluir"
228:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
229:                 .FontName = "Tahoma"
230:                 .FontSize = 8
231:                 .Themes   = .F.
232:                 .Visible  = .T.
233:             ENDWITH
234:             BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
235:             loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
236:             WITH loc_oCnt.cmd_4c_Visualizar
237:                 .Top      = 5
238:                 .Left     = 82
239:                 .Width    = 75
240:                 .Height   = 75
241:                 .Caption  = "Visualizar"
242:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
243:                 .FontName = "Tahoma"
244:                 .FontSize = 8
245:                 .Themes   = .F.
246:                 .Visible  = .T.
247:             ENDWITH
248:             BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
249:             loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
250:             WITH loc_oCnt.cmd_4c_Alterar
251:                 .Top      = 5
252:                 .Left     = 159
253:                 .Width    = 75
254:                 .Height   = 75
255:                 .Caption  = "Alterar"
256:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
257:                 .FontName = "Tahoma"
258:                 .FontSize = 8
259:                 .Themes   = .F.
260:                 .Visible  = .T.
261:             ENDWITH
262:             BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
263:             loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
264:             WITH loc_oCnt.cmd_4c_Excluir
265:                 .Top      = 5
266:                 .Left     = 236
267:                 .Width    = 75
268:                 .Height   = 75
269:                 .Caption  = "Excluir"
270:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
271:                 .FontName = "Tahoma"
272:                 .FontSize = 8
273:                 .Themes   = .F.
274:                 .Visible  = .T.
275:             ENDWITH
276:             BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
277:             loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
278:             WITH loc_oCnt.cmd_4c_Buscar
279:                 .Top      = 5
280:                 .Left     = 313
281:                 .Width    = 75
282:                 .Height   = 75
283:                 .Caption  = "Buscar"
284:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
285:                 .FontName = "Tahoma"
286:                 .FontSize = 8
287:                 .Themes   = .F.
288:                 .Visible  = .T.
289:             ENDWITH
290:             BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
291:             loc_oCnt = loc_oPg.cnt_4c_Saida
292:             loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
293:             WITH loc_oCnt.cmd_4c_Encerrar
294:                 .Top      = 5
295:                 .Left     = 5
296:                 .Width    = 75
297:                 .Height   = 75
298:                 .Caption  = "Encerrar"
299:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
300:                 .FontName = "Tahoma"
301:                 .FontSize = 8
302:                 .Themes   = .F.
303:                 .Visible  = .T.
304:             ENDWITH
305:             BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
306:             loc_oPg.AddObject("cmd_4c_CadOpe", "CommandButton")
307:             WITH loc_oPg.cmd_4c_CadOpe
308:                 .Top      = 33
309:                 .Left     = 324
310:                 .Width    = 60
311:                 .Height   = 75
312:                 .Caption  = "Estoque"
313:                 .FontName = "Tahoma"
314:                 .FontSize = 8
315:                 .Themes   = .T.
316:                 .Visible  = .T.
317:             ENDWITH
318:             loc_oPg.AddObject("cmd_4c_ExpXML", "CommandButton")
319:             WITH loc_oPg.cmd_4c_ExpXML
320:                 .Top      = 33
321:                 .Left     = 399
322:                 .Width    = 60
323:                 .Height   = 75
324:                 .Caption  = "Exporta XML"
325:                 .FontName = "Tahoma"
326:                 .FontSize = 8
327:                 .Themes   = .T.
328:                 .Visible  = .T.
329:             ENDWITH
330:             loc_oPg.AddObject("cmd_4c_ImpXML", "CommandButton")
331:             WITH loc_oPg.cmd_4c_ImpXML
332:                 .Top      = 33
333:                 .Left     = 474
334:                 .Width    = 60
335:                 .Height   = 75
336:                 .Caption  = "Importa XML"
337:                 .FontName = "Tahoma"
338:                 .FontSize = 8
339:                 .Themes   = .T.
340:                 .Visible  = .T.
341:             ENDWITH
342:             loc_oPg.AddObject("grd_4c_Lista", "Grid")
343:             WITH loc_oPg.grd_4c_Lista
344:                 .Top          = 117
345:                 .Left         = 26
346:                 .Width        = 890
347:                 .Height       = 450
348:                 .ReadOnly     = .T.
349:                 .GridLines    = 1
350:                 .RowHeight    = 20
351:                 .HeaderHeight = 25
352:                 .ScrollBars   = 3
353:                 .DeleteMark   = .F.
354:                 .Themes       = .F.
355:                 .FontName     = "Verdana"
356:                 .FontSize     = 8
357:                 .ColumnCount  = 4
358:                 .Visible      = .T.

*-- Linhas 364 a 630:
364:         ENDTRY
365:     ENDPROC
366: 
367:     PROCEDURE CarregarLista()
368:         LOCAL loc_lSucesso
369:         loc_lSucesso = .F.
370:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
371:             RETURN .T.
372:         ENDIF
373:         TRY
374:             THIS.this_oBusinessObject.Buscar("")
375:             IF USED("cursor_4c_Dados")
376:                 WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
377:                     .RecordSource            = "cursor_4c_Dados"
378:                     .Column1.ControlSource   = "cursor_4c_Dados.Dopps"
379:                     .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
380:                     .Column1.Width           = 300
381:                     .Column2.ControlSource   = "cursor_4c_Dados.Ndopps"
382:                     .Column2.Header1.Caption = "No. Opera" + CHR(231) + CHR(227) + "o"
383:                     .Column2.Width           = 80
384:                     .Column3.ControlSource   = "cursor_4c_Dados.Ordes"
385:                     .Column3.Header1.Caption = "Ordem"
386:                     .Column3.Width           = 60
387:                     .Column4.ControlSource   = "cursor_4c_Dados.Hists"
388:                     .Column4.Header1.Caption = "Hist" + CHR(243) + "rico"
389:                     .Column4.Width           = 420
390:                 ENDWITH
391:                 loc_lSucesso = .T.
392:             ENDIF
393:             THIS.AjustarBotoesPorModo()
394:         CATCH TO loException
395:             MostrarErro(loException, "FormMPD.CarregarLista")
396:         ENDTRY
397:         RETURN loc_lSucesso
398:     ENDPROC
399: 
400:     PROCEDURE AlternarPagina(par_nPagina)
401:         TRY
402:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
403:             IF par_nPagina = 1
404:                 THIS.this_cModoAtual = "LISTA"
405:             ENDIF
406:         CATCH TO loException
407:             MostrarErro(loException, "FormMPD.AlternarPagina")
408:         ENDTRY
409:     ENDPROC
410: 
411:     PROCEDURE BtnIncluirClick()
412:         TRY
413:             THIS.this_oBusinessObject.NovoRegistro()
414:             THIS.LimparCampos()
415:             THIS.BOParaForm()
416:             THIS.this_cModoAtual = "INCLUIR"
417:             THIS.HabilitarCampos(.T.)
418:             THIS.AlternarPagina(2)
419:         CATCH TO loException
420:             MostrarErro(loException, "FormMPD.BtnIncluirClick")
421:         ENDTRY
422:     ENDPROC
423: 
424:     PROCEDURE BtnVisualizarClick()
425:         LOCAL loc_cDopps
426:         TRY
427:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
428:                 MsgAviso("Selecione um registro.", "Aviso")
429:             ELSE
430:                 loc_cDopps = ALLTRIM(cursor_4c_Dados.Dopps)
431:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopps)
432:                     THIS.this_cModoAtual = "VISUALIZAR"
433:                     THIS.BOParaForm()
434:                     THIS.HabilitarCampos(.F.)
435:                     THIS.AlternarPagina(2)
436:                 ENDIF
437:             ENDIF
438:         CATCH TO loException
439:             MostrarErro(loException, "FormMPD.BtnVisualizarClick")
440:         ENDTRY
441:     ENDPROC
442: 
443:     PROCEDURE BtnAlterarClick()
444:         LOCAL loc_cDopps
445:         TRY
446:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
447:                 MsgAviso("Selecione um registro.", "Aviso")
448:             ELSE
449:                 loc_cDopps = ALLTRIM(cursor_4c_Dados.Dopps)
450:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopps)
451:                     THIS.this_oBusinessObject.EditarRegistro()
452:                     THIS.this_cModoAtual = "ALTERAR"
453:                     THIS.BOParaForm()
454:                     THIS.HabilitarCampos(.T.)
455:                     THIS.AlternarPagina(2)
456:                 ENDIF
457:             ENDIF
458:         CATCH TO loException
459:             MostrarErro(loException, "FormMPD.BtnAlterarClick")
460:         ENDTRY
461:     ENDPROC
462: 
463:     PROCEDURE BtnExcluirClick()
464:         LOCAL loc_cDopps, loc_lConfirma
465:         TRY
466:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
467:                 MsgAviso("Selecione um registro.", "Aviso")
468:             ELSE
469:                 loc_cDopps    = ALLTRIM(cursor_4c_Dados.Dopps)
470:                 loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o?", "Confirmar")
471:                 IF loc_lConfirma
472:                     IF THIS.this_oBusinessObject.Excluir(loc_cDopps)
473:                         THIS.CarregarLista()
474:                     ENDIF
475:                 ENDIF
476:             ENDIF
477:         CATCH TO loException
478:             MostrarErro(loException, "FormMPD.BtnExcluirClick")
479:         ENDTRY
480:     ENDPROC
481: 
482:     PROCEDURE BtnBuscarClick()
483:         LOCAL loc_cFiltro
484:         TRY
485:             loc_cFiltro = INPUTBOX("Pesquisar por descri" + CHR(231) + CHR(227) + "o:", ;
486:                 "Busca", "")
487:             THIS.this_oBusinessObject.Buscar(loc_cFiltro)
488:             IF USED("cursor_4c_Dados")
489:                 WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
490:                     .RecordSource            = "cursor_4c_Dados"
491:                     .Column1.ControlSource   = "cursor_4c_Dados.Dopps"
492:                     .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
493:                     .Column1.Width           = 300
494:                     .Column2.ControlSource   = "cursor_4c_Dados.Ndopps"
495:                     .Column2.Header1.Caption = "No. Opera" + CHR(231) + CHR(227) + "o"
496:                     .Column2.Width           = 80
497:                     .Column3.ControlSource   = "cursor_4c_Dados.Ordes"
498:                     .Column3.Header1.Caption = "Ordem"
499:                     .Column3.Width           = 60
500:                     .Column4.ControlSource   = "cursor_4c_Dados.Hists"
501:                     .Column4.Header1.Caption = "Hist" + CHR(243) + "rico"
502:                     .Column4.Width           = 420
503:                 ENDWITH
504:             ENDIF
505:         CATCH TO loException
506:             MostrarErro(loException, "FormMPD.BtnBuscarClick")
507:         ENDTRY
508:     ENDPROC
509: 
510:     PROCEDURE BtnEncerrarClick()
511:         TRY
512:             THIS.Release()
513:         CATCH TO loException
514:             MostrarErro(loException, "FormMPD.BtnEncerrarClick")
515:         ENDTRY
516:     ENDPROC
517: 
518:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
519:         TRY
520:             par_oGrid.FontName = "Verdana"
521:             par_oGrid.FontSize = 8
522:         CATCH TO loException
523:             MostrarErro(loException, "FormMPD.FormatarGridLista")
524:         ENDTRY
525:     ENDPROC
526: 
527:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
528:         LOCAL loc_nI, loc_oCtrl
529:         TRY
530:             FOR loc_nI = 1 TO par_oContainer.ControlCount
531:                 loc_oCtrl = par_oContainer.Controls(loc_nI)
532:                 IF loc_oCtrl.ControlCount > 0
533:                     THIS.TornarControlesVisiveis(loc_oCtrl)
534:                 ENDIF
535:                 loc_oCtrl.Visible = .T.
536:             ENDFOR
537:         CATCH TO loException
538:             MostrarErro(loException, "FormMPD.TornarControlesVisiveis")
539:         ENDTRY
540:     ENDPROC
541: 
542:     PROTECTED PROCEDURE ConfigurarPaginaDados()
543:         LOCAL loc_oPg, loc_oCnt
544:         loc_oPg = THIS.pgf_4c_Paginas.Page2
545:         TRY
546:             loc_oPg.cnt_4c_Cabecalho.Visible = .F.
547:             loc_oCnt = loc_oPg.cnt_4c_BotoesAcao
548:             loc_oCnt.AddObject("cmd_4c_Salvar", "CommandButton")
549:             WITH loc_oCnt.cmd_4c_Salvar
550:                 .Top      = 5
551:                 .Left     = 5
552:                 .Width    = 75
553:                 .Height   = 75
554:                 .Caption  = "Salvar"
555:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_gravar_60.jpg"
556:                 .FontName = "Tahoma"
557:                 .FontSize = 8
558:                 .Themes   = .F.
559:                 .Visible  = .T.
560:             ENDWITH
561:             BINDEVENT(loc_oCnt.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
562:             loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
563:             WITH loc_oCnt.cmd_4c_Cancelar
564:                 .Top      = 5
565:                 .Left     = 82
566:                 .Width    = 75
567:                 .Height   = 75
568:                 .Caption  = "Encerrar"
569:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
570:                 .FontName = "Tahoma"
571:                 .FontSize = 8
572:                 .Themes   = .F.
573:                 .Visible  = .T.
574:             ENDWITH
575:             BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
576:             loc_oCnt = loc_oPg.cnt_4c_Saida
577:             loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
578:             WITH loc_oCnt.cmd_4c_Encerrar
579:                 .Top      = 5
580:                 .Left     = 5
581:                 .Width    = 75
582:                 .Height   = 75
583:                 .Caption  = "Encerrar"
584:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
585:                 .FontName = "Tahoma"
586:                 .FontSize = 8
587:                 .Themes   = .F.
588:                 .Visible  = .T.
589:             ENDWITH
590:             BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
591:             * Campos de cabecalho da aba Dados (top + 29 compensa pgf_4c_Paginas.Top=-29)
592:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
593:             WITH loc_oPg.lbl_4c_Label1
594:                 .Top       = 74
595:                 .Left      = 64
596:                 .Width     = 58
597:                 .Height    = 15
598:                 .AutoSize  = .F.
599:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
600:                 .BackStyle = 0
601:                 .Visible   = .T.
602:             ENDWITH
603:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
604:             WITH loc_oPg.txt_4c_Desc
605:                 .Top       = 70
606:                 .Left      = 132
607:                 .Width     = 150
608:                 .Height    = 23
609:                 .MaxLength = 40
610:                 .Visible   = .T.
611:             ENDWITH
612:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
613:             WITH loc_oPg.lbl_4c_Label25
614:                 .Top       = 74
615:                 .Left      = 332
616:                 .Width     = 71
617:                 .Height    = 15
618:                 .AutoSize  = .F.
619:                 .Caption   = "N" + CHR(186) + " Opera" + CHR(231) + CHR(227) + "o :"
620:                 .BackStyle = 0
621:                 .Visible   = .T.
622:             ENDWITH
623:             loc_oPg.AddObject("txt_4c_Nope", "TextBox")
624:             WITH loc_oPg.txt_4c_Nope
625:                 .Top      = 70
626:                 .Left     = 416
627:                 .Width    = 29
628:                 .Height   = 23
629:                 .ReadOnly = .T.
630:                 .Visible  = .T.

*-- Linhas 658 a 728:
658:                 .Themes  = .T.
659:                 .Visible = .T.
660:             ENDWITH
661:             BINDEVENT(loc_oPg.obj_4c_CmdGarqicone, "Click", THIS, "CmdGarqiconeClick")
662:             * PageFrame interno: 5 abas (Operacao, Estoque, Componente, Documento, Diversas)
663:             loc_oPg.AddObject("pgf_4c_PagDados", "PageFrame")
664:             WITH loc_oPg.pgf_4c_PagDados
665:                 .Top       = 150
666:                 .Left      = 6
667:                 .Width     = 987
668:                 .Height    = 475
669:                 .PageCount = 5
670:                 .Visible   = .T.
671:                 .Page1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
672:                 .Page2.Caption = "Estoque"
673:                 .Page3.Caption = "Componente"
674:                 .Page4.Caption = "Documento"
675:                 .Page5.Caption = "Diversas"
676:             ENDWITH
677:             THIS.ConfigurarPgOperacao()
678:             THIS.ConfigurarPgEstoque()
679:             THIS.ConfigurarPgComponente()
680:             THIS.ConfigurarPgDocumento()
681:             THIS.ConfigurarPgDiversas()
682:             THIS.TornarControlesVisiveis(loc_oPg)
683:         CATCH TO loException
684:             MostrarErro(loException, "FormMPD.ConfigurarPaginaDados")
685:         ENDTRY
686:     ENDPROC
687: 
688:     PROTECTED PROCEDURE ConfigurarPgOperacao()
689:         LOCAL loc_oPg
690:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
691:         TRY
692:             loc_oPg.AddObject("shp_4c_Shape7", "Shape")
693:             WITH loc_oPg.shp_4c_Shape7
694:                 .Top     = 192
695:                 .Left    = 7
696:                 .Width   = 287
697:                 .Height  = 162
698:                 .Visible = .T.
699:             ENDWITH
700:             * Labels coluna esquerda
701:             loc_oPg.AddObject("lbl_4c_Label36", "Label")
702:             WITH loc_oPg.lbl_4c_Label36
703:                 .Top       = 15
704:                 .Left      = 60
705:                 .Width     = 60
706:                 .Height    = 15
707:                 .AutoSize  = .F.
708:                 .Caption   = "Imagem : "
709:                 .BackStyle = 0
710:                 .Visible   = .T.
711:             ENDWITH
712:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
713:             WITH loc_oPg.lbl_4c_Label2
714:                 .Top       = 34
715:                 .Left      = 68
716:                 .Width     = 60
717:                 .Height    = 15
718:                 .AutoSize  = .F.
719:                 .Caption   = "Boleto : "
720:                 .BackStyle = 0
721:                 .Visible   = .T.
722:             ENDWITH
723:             loc_oPg.AddObject("lbl_4c_Label31", "Label")
724:             WITH loc_oPg.lbl_4c_Label31
725:                 .Top       = 54
726:                 .Left      = 44
727:                 .Width     = 80
728:                 .Height    = 15

*-- Linhas 1135 a 1638:
1135:                 .Themes  = .T.
1136:                 .Visible = .T.
1137:             ENDWITH
1138:             BINDEVENT(loc_oPg.cmd_4c_CmdIcone, "Click", THIS, "CmdIconeClick")
1139:             * OptionGroups coluna esquerda
1140:             loc_oPg.AddObject("obj_4c_Op_imagem", "OptionGroup")
1141:             WITH loc_oPg.obj_4c_Op_imagem
1142:                 .Top         = 13
1143:                 .Left        = 108
1144:                 .Width       = 89
1145:                 .Height      = 20
1146:                 .ButtonCount = 2
1147:                 .Visible     = .T.
1148:                 WITH .Buttons(1)
1149:                     .Left    = 3
1150:                     .Caption = "Sim"
1151:                     .Width   = 40
1152:                 ENDWITH
1153:                 WITH .Buttons(2)
1154:                     .Left    = 46
1155:                     .Caption = "N" + CHR(227) + "o"
1156:                     .Width   = 40
1157:                 ENDWITH
1158:             ENDWITH
1159:             loc_oPg.AddObject("obj_4c_Op_boleto", "OptionGroup")
1160:             WITH loc_oPg.obj_4c_Op_boleto
1161:                 .Top         = 32
1162:                 .Left        = 108
1163:                 .Width       = 130
1164:                 .Height      = 17
1165:                 .ButtonCount = 3
1166:                 .Visible     = .T.
1167:                 WITH .Buttons(1)
1168:                     .Left    = 3
1169:                     .Caption = "Sim"
1170:                     .Width   = 38
1171:                 ENDWITH
1172:                 WITH .Buttons(2)
1173:                     .Left    = 44
1174:                     .Caption = "N" + CHR(227) + "o"
1175:                     .Width   = 38
1176:                 ENDWITH
1177:                 WITH .Buttons(3)
1178:                     .Left    = 88
1179:                     .Caption = "Tela"
1180:                     .Width   = 38
1181:                 ENDWITH
1182:             ENDWITH
1183:             loc_oPg.AddObject("obj_4c_Fwoption8", "OptionGroup")
1184:             WITH loc_oPg.obj_4c_Fwoption8
1185:                 .Top         = 52
1186:                 .Left        = 108
1187:                 .Width       = 89
1188:                 .Height      = 20
1189:                 .ButtonCount = 2
1190:                 .Visible     = .T.
1191:                 WITH .Buttons(1)
1192:                     .Left    = 3
1193:                     .Caption = "Sim"
1194:                     .Width   = 40
1195:                 ENDWITH
1196:                 WITH .Buttons(2)
1197:                     .Left    = 46
1198:                     .Caption = "N" + CHR(227) + "o"
1199:                     .Width   = 40
1200:                 ENDWITH
1201:             ENDWITH
1202:             loc_oPg.AddObject("obj_4c_Fwoption5", "OptionGroup")
1203:             WITH loc_oPg.obj_4c_Fwoption5
1204:                 .Top         = 73
1205:                 .Left        = 107
1206:                 .Width       = 92
1207:                 .Height      = 20
1208:                 .ButtonCount = 2
1209:                 .Visible     = .T.
1210:                 WITH .Buttons(1)
1211:                     .Left    = 3
1212:                     .Caption = "Sim"
1213:                     .Width   = 40
1214:                 ENDWITH
1215:                 WITH .Buttons(2)
1216:                     .Left    = 46
1217:                     .Caption = "N" + CHR(227) + "o"
1218:                     .Width   = 40
1219:                 ENDWITH
1220:             ENDWITH
1221:             loc_oPg.AddObject("obj_4c_Opt_compo", "OptionGroup")
1222:             WITH loc_oPg.obj_4c_Opt_compo
1223:                 .Top         = 90
1224:                 .Left        = 107
1225:                 .Width       = 89
1226:                 .Height      = 20
1227:                 .ButtonCount = 2
1228:                 .Visible     = .T.
1229:                 WITH .Buttons(1)
1230:                     .Left    = 3
1231:                     .Caption = "Sim"
1232:                     .Width   = 40
1233:                 ENDWITH
1234:                 WITH .Buttons(2)
1235:                     .Left    = 46
1236:                     .Caption = "N" + CHR(227) + "o"
1237:                     .Width   = 40
1238:                 ENDWITH
1239:             ENDWITH
1240:             loc_oPg.AddObject("obj_4c_Opt_Menu", "OptionGroup")
1241:             WITH loc_oPg.obj_4c_Opt_Menu
1242:                 .Top         = 114
1243:                 .Left        = 108
1244:                 .Width       = 89
1245:                 .Height      = 20
1246:                 .ButtonCount = 2
1247:                 .Visible     = .T.
1248:                 WITH .Buttons(1)
1249:                     .Left    = 3
1250:                     .Caption = "Sim"
1251:                     .Width   = 40
1252:                 ENDWITH
1253:                 WITH .Buttons(2)
1254:                     .Left    = 46
1255:                     .Caption = "N" + CHR(227) + "o"
1256:                     .Width   = 40
1257:                 ENDWITH
1258:             ENDWITH
1259:             loc_oPg.AddObject("obj_4c_ObjAutos", "OptionGroup")
1260:             WITH loc_oPg.obj_4c_ObjAutos
1261:                 .Top         = 134
1262:                 .Left        = 108
1263:                 .Width       = 193
1264:                 .Height      = 20
1265:                 .ButtonCount = 3
1266:                 .Visible     = .T.
1267:                 WITH .Buttons(1)
1268:                     .Left    = 3
1269:                     .Caption = "Movim."
1270:                     .Width   = 60
1271:                 ENDWITH
1272:                 WITH .Buttons(2)
1273:                     .Left    = 66
1274:                     .Caption = "Encerra"
1275:                     .Width   = 60
1276:                 ENDWITH
1277:                 WITH .Buttons(3)
1278:                     .Left    = 130
1279:                     .Caption = "Nenhum"
1280:                     .Width   = 60
1281:                 ENDWITH
1282:             ENDWITH
1283:             loc_oPg.AddObject("obj_4c_Op_subn", "OptionGroup")
1284:             WITH loc_oPg.obj_4c_Op_subn
1285:                 .Top         = 195
1286:                 .Left        = 141
1287:                 .Width       = 88
1288:                 .Height      = 20
1289:                 .ButtonCount = 2
1290:                 .Visible     = .T.
1291:                 WITH .Buttons(1)
1292:                     .Left    = 3
1293:                     .Caption = "Sim"
1294:                     .Width   = 40
1295:                 ENDWITH
1296:                 WITH .Buttons(2)
1297:                     .Left    = 46
1298:                     .Caption = "N" + CHR(227) + "o"
1299:                     .Width   = 40
1300:                 ENDWITH
1301:             ENDWITH
1302:             loc_oPg.AddObject("obj_4c_Op_BxAuto", "OptionGroup")
1303:             WITH loc_oPg.obj_4c_Op_BxAuto
1304:                 .Top         = 283
1305:                 .Left        = 141
1306:                 .Width       = 88
1307:                 .Height      = 20
1308:                 .ButtonCount = 2
1309:                 .Visible     = .T.
1310:                 WITH .Buttons(1)
1311:                     .Left    = 3
1312:                     .Caption = "Sim"
1313:                     .Width   = 40
1314:                 ENDWITH
1315:                 WITH .Buttons(2)
1316:                     .Left    = 46
1317:                     .Caption = "N" + CHR(227) + "o"
1318:                     .Width   = 40
1319:                 ENDWITH
1320:             ENDWITH
1321:             loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
1322:             WITH loc_oPg.obj_4c_Fwoption2
1323:                 .Top         = 303
1324:                 .Left        = 141
1325:                 .Width       = 88
1326:                 .Height      = 20
1327:                 .ButtonCount = 2
1328:                 .Visible     = .T.
1329:                 WITH .Buttons(1)
1330:                     .Left    = 3
1331:                     .Caption = "Sim"
1332:                     .Width   = 40
1333:                 ENDWITH
1334:                 WITH .Buttons(2)
1335:                     .Left    = 46
1336:                     .Caption = "N" + CHR(227) + "o"
1337:                     .Width   = 40
1338:                 ENDWITH
1339:             ENDWITH
1340:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
1341:             WITH loc_oPg.obj_4c_Fwoption1
1342:                 .Top         = 323
1343:                 .Left        = 141
1344:                 .Width       = 88
1345:                 .Height      = 20
1346:                 .ButtonCount = 2
1347:                 .Visible     = .T.
1348:                 WITH .Buttons(1)
1349:                     .Left    = 3
1350:                     .Caption = "Sim"
1351:                     .Width   = 40
1352:                 ENDWITH
1353:                 WITH .Buttons(2)
1354:                     .Left    = 46
1355:                     .Caption = "N" + CHR(227) + "o"
1356:                     .Width   = 40
1357:                 ENDWITH
1358:             ENDWITH
1359:             * OptionGroups coluna direita
1360:             loc_oPg.AddObject("obj_4c_GetSequencia", "OptionGroup")
1361:             WITH loc_oPg.obj_4c_GetSequencia
1362:                 .Top         = 12
1363:                 .Left        = 656
1364:                 .Width       = 88
1365:                 .Height      = 21
1366:                 .ButtonCount = 2
1367:                 .Visible     = .T.
1368:                 WITH .Buttons(1)
1369:                     .Left    = 3
1370:                     .Caption = "Sim"
1371:                     .Width   = 40
1372:                 ENDWITH
1373:                 WITH .Buttons(2)
1374:                     .Left    = 46
1375:                     .Caption = "N" + CHR(227) + "o"
1376:                     .Width   = 40
1377:                 ENDWITH
1378:             ENDWITH
1379:             loc_oPg.AddObject("obj_4c_Op_agregas", "OptionGroup")
1380:             WITH loc_oPg.obj_4c_Op_agregas
1381:                 .Top         = 33
1382:                 .Left        = 656
1383:                 .Width       = 88
1384:                 .Height      = 20
1385:                 .ButtonCount = 2
1386:                 .Visible     = .T.
1387:                 WITH .Buttons(1)
1388:                     .Left    = 3
1389:                     .Caption = "Sim"
1390:                     .Width   = 40
1391:                 ENDWITH
1392:                 WITH .Buttons(2)
1393:                     .Left    = 46
1394:                     .Caption = "N" + CHR(227) + "o"
1395:                     .Width   = 40
1396:                 ENDWITH
1397:             ENDWITH
1398:             loc_oPg.AddObject("obj_4c_Op_repete", "OptionGroup")
1399:             WITH loc_oPg.obj_4c_Op_repete
1400:                 .Top         = 53
1401:                 .Left        = 656
1402:                 .Width       = 160
1403:                 .Height      = 20
1404:                 .ButtonCount = 3
1405:                 .Visible     = .T.
1406:                 WITH .Buttons(1)
1407:                     .Left    = 3
1408:                     .Caption = "Sim"
1409:                     .Width   = 50
1410:                 ENDWITH
1411:                 WITH .Buttons(2)
1412:                     .Left    = 56
1413:                     .Caption = "N" + CHR(227) + "o"
1414:                     .Width   = 50
1415:                 ENDWITH
1416:                 WITH .Buttons(3)
1417:                     .Left    = 109
1418:                     .Caption = "Por Setor"
1419:                     .Width   = 50
1420:                 ENDWITH
1421:             ENDWITH
1422:             loc_oPg.AddObject("obj_4c_Op_Saldo", "OptionGroup")
1423:             WITH loc_oPg.obj_4c_Op_Saldo
1424:                 .Top         = 73
1425:                 .Left        = 656
1426:                 .Width       = 88
1427:                 .Height      = 20
1428:                 .ButtonCount = 2
1429:                 .Visible     = .T.
1430:                 WITH .Buttons(1)
1431:                     .Left    = 3
1432:                     .Caption = "Sim"
1433:                     .Width   = 40
1434:                 ENDWITH
1435:                 WITH .Buttons(2)
1436:                     .Left    = 46
1437:                     .Caption = "N" + CHR(227) + "o"
1438:                     .Width   = 40
1439:                 ENDWITH
1440:             ENDWITH
1441:             loc_oPg.AddObject("obj_4c_Op_inib", "OptionGroup")
1442:             WITH loc_oPg.obj_4c_Op_inib
1443:                 .Top         = 93
1444:                 .Left        = 656
1445:                 .Width       = 88
1446:                 .Height      = 20
1447:                 .ButtonCount = 2
1448:                 .Visible     = .T.
1449:                 WITH .Buttons(1)
1450:                     .Left    = 3
1451:                     .Caption = "Sim"
1452:                     .Width   = 40
1453:                 ENDWITH
1454:                 WITH .Buttons(2)
1455:                     .Left    = 46
1456:                     .Caption = "N" + CHR(227) + "o"
1457:                     .Width   = 40
1458:                 ENDWITH
1459:             ENDWITH
1460:             loc_oPg.AddObject("obj_4c_ObjMenFalha", "OptionGroup")
1461:             WITH loc_oPg.obj_4c_ObjMenFalha
1462:                 .Top         = 114
1463:                 .Left        = 656
1464:                 .Width       = 88
1465:                 .Height      = 20
1466:                 .ButtonCount = 2
1467:                 .Visible     = .T.
1468:                 WITH .Buttons(1)
1469:                     .Left    = 3
1470:                     .Caption = "Sim"
1471:                     .Width   = 40
1472:                 ENDWITH
1473:                 WITH .Buttons(2)
1474:                     .Left    = 46
1475:                     .Caption = "N" + CHR(227) + "o"
1476:                     .Width   = 40
1477:                 ENDWITH
1478:             ENDWITH
1479:             loc_oPg.AddObject("obj_4c_ObjBusEnv", "OptionGroup")
1480:             WITH loc_oPg.obj_4c_ObjBusEnv
1481:                 .Top         = 135
1482:                 .Left        = 656
1483:                 .Width       = 88
1484:                 .Height      = 20
1485:                 .ButtonCount = 2
1486:                 .Visible     = .T.
1487:                 WITH .Buttons(1)
1488:                     .Left    = 3
1489:                     .Caption = "Sim"
1490:                     .Width   = 40
1491:                 ENDWITH
1492:                 WITH .Buttons(2)
1493:                     .Left    = 46
1494:                     .Caption = "N" + CHR(227) + "o"
1495:                     .Width   = 40
1496:                 ENDWITH
1497:             ENDWITH
1498:             loc_oPg.AddObject("obj_4c_ObjRetrabs", "OptionGroup")
1499:             WITH loc_oPg.obj_4c_ObjRetrabs
1500:                 .Top         = 155
1501:                 .Left        = 656
1502:                 .Width       = 88
1503:                 .Height      = 20
1504:                 .ButtonCount = 2
1505:                 .Visible     = .T.
1506:                 WITH .Buttons(1)
1507:                     .Left    = 3
1508:                     .Caption = "Sim"
1509:                     .Width   = 40
1510:                 ENDWITH
1511:                 WITH .Buttons(2)
1512:                     .Left    = 46
1513:                     .Caption = "N" + CHR(227) + "o"
1514:                     .Width   = 40
1515:                 ENDWITH
1516:             ENDWITH
1517:             loc_oPg.AddObject("obj_4c_Objnaoconform", "OptionGroup")
1518:             WITH loc_oPg.obj_4c_Objnaoconform
1519:                 .Top         = 174
1520:                 .Left        = 656
1521:                 .Width       = 88
1522:                 .Height      = 20
1523:                 .ButtonCount = 2
1524:                 .Visible     = .T.
1525:                 WITH .Buttons(1)
1526:                     .Left    = 3
1527:                     .Caption = "Sim"
1528:                     .Width   = 40
1529:                 ENDWITH
1530:                 WITH .Buttons(2)
1531:                     .Left    = 46
1532:                     .Caption = "N" + CHR(227) + "o"
1533:                     .Width   = 40
1534:                 ENDWITH
1535:             ENDWITH
1536:             loc_oPg.AddObject("obj_4c_Objpagamento", "OptionGroup")
1537:             WITH loc_oPg.obj_4c_Objpagamento
1538:                 .Top         = 192
1539:                 .Left        = 656
1540:                 .Width       = 88
1541:                 .Height      = 20
1542:                 .ButtonCount = 2
1543:                 .Visible     = .T.
1544:                 WITH .Buttons(1)
1545:                     .Left    = 3
1546:                     .Caption = "Sim"
1547:                     .Width   = 40
1548:                 ENDWITH
1549:                 WITH .Buttons(2)
1550:                     .Left    = 46
1551:                     .Caption = "N" + CHR(227) + "o"
1552:                     .Width   = 40
1553:                 ENDWITH
1554:             ENDWITH
1555:             loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
1556:             WITH loc_oPg.obj_4c_Fwoption3
1557:                 .Top         = 212
1558:                 .Left        = 656
1559:                 .Width       = 88
1560:                 .Height      = 20
1561:                 .ButtonCount = 2
1562:                 .Visible     = .T.
1563:                 WITH .Buttons(1)
1564:                     .Left    = 3
1565:                     .Caption = "Sim"
1566:                     .Width   = 40
1567:                 ENDWITH
1568:                 WITH .Buttons(2)
1569:                     .Left    = 46
1570:                     .Caption = "N" + CHR(227) + "o"
1571:                     .Width   = 40
1572:                 ENDWITH
1573:             ENDWITH
1574:             loc_oPg.AddObject("obj_4c_Fwoption4", "OptionGroup")
1575:             WITH loc_oPg.obj_4c_Fwoption4
1576:                 .Top         = 232
1577:                 .Left        = 656
1578:                 .Width       = 155
1579:                 .Height      = 23
1580:                 .ButtonCount = 3
1581:                 .Visible     = .T.
1582:                 WITH .Buttons(1)
1583:                     .Left    = 3
1584:                     .Caption = "Op"
1585:                     .Width   = 47
1586:                 ENDWITH
1587:                 WITH .Buttons(2)
1588:                     .Left    = 53
1589:                     .Caption = "Env"
1590:                     .Width   = 47
1591:                 ENDWITH
1592:                 WITH .Buttons(3)
1593:                     .Left    = 103
1594:                     .Caption = "Nenhum"
1595:                     .Width   = 47
1596:                 ENDWITH
1597:             ENDWITH
1598:             loc_oPg.AddObject("obj_4c_Opt_tipomov", "OptionGroup")
1599:             WITH loc_oPg.obj_4c_Opt_tipomov
1600:                 .Top         = 302
1601:                 .Left        = 665
1602:                 .Width       = 237
1603:                 .Height      = 98
1604:                 .ButtonCount = 11
1605:                 .Visible     = .T.
1606:                 WITH .Buttons(1)
1607:                     .Left    = 3
1608:                     .Top     = 2
1609:                     .Caption = "Envelopagem"
1610:                     .Width   = 100
1611:                     .Height  = 14
1612:                 ENDWITH
1613:                 WITH .Buttons(2)
1614:                     .Left    = 107
1615:                     .Top     = 2
1616:                     .Caption = "Nenhum"
1617:                     .Width   = 100
1618:                     .Height  = 14
1619:                 ENDWITH
1620:                 WITH .Buttons(3)
1621:                     .Left    = 3
1622:                     .Top     = 17
1623:                     .Caption = "Encerra"
1624:                     .Width   = 100
1625:                     .Height  = 14
1626:                 ENDWITH
1627:                 WITH .Buttons(4)
1628:                     .Left    = 107
1629:                     .Top     = 17
1630:                     .Caption = "Dev.Pedra"
1631:                     .Width   = 100
1632:                     .Height  = 14
1633:                 ENDWITH
1634:                 WITH .Buttons(5)
1635:                     .Left    = 3
1636:                     .Top     = 33
1637:                     .Caption = "Sep. Pedra"
1638:                     .Width   = 100

*-- Linhas 1681 a 1816:
1681:                     .Height  = 14
1682:                 ENDWITH
1683:             ENDWITH
1684:             * BINDEVENTs lookups Operacao
1685:             BINDEVENT(loc_oPg.txt_4c_Nivel,    "KeyPress", THIS, "NivelKeyPress")
1686:             BINDEVENT(loc_oPg.txt_4c_Nivel,    "DblClick", THIS, "AbrirLookupNivel")
1687:             BINDEVENT(loc_oPg.txt_4c__Empenho, "KeyPress", THIS, "EmpenhoKeyPress")
1688:             BINDEVENT(loc_oPg.txt_4c__Empenho, "DblClick", THIS, "AbrirLookupEmpenho")
1689:             BINDEVENT(loc_oPg.txt_4c_EmpLanc,  "KeyPress", THIS, "EmpLancKeyPress")
1690:             BINDEVENT(loc_oPg.txt_4c_EmpLanc,  "DblClick", THIS, "AbrirLookupEmpLanc")
1691:         CATCH TO loException
1692:             MostrarErro(loException, "FormMPD.ConfigurarPgOperacao")
1693:         ENDTRY
1694:     ENDPROC
1695: 
1696:     PROCEDURE BtnSalvarClick()
1697:         LOCAL loc_lSucesso
1698:         loc_lSucesso = .F.
1699:         TRY
1700:             THIS.FormParaBO()
1701:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
1702:             IF loc_lSucesso
1703:                 THIS.this_cModoAtual = "LISTA"
1704:                 THIS.AlternarPagina(1)
1705:                 THIS.CarregarLista()
1706:             ENDIF
1707:         CATCH TO loException
1708:             MostrarErro(loException, "FormMPD.BtnSalvarClick")
1709:         ENDTRY
1710:     ENDPROC
1711: 
1712:     PROCEDURE BtnCancelarClick()
1713:         TRY
1714:             THIS.this_cModoAtual = "LISTA"
1715:             THIS.AlternarPagina(1)
1716:             THIS.CarregarLista()
1717:         CATCH TO loException
1718:             MostrarErro(loException, "FormMPD.BtnCancelarClick")
1719:         ENDTRY
1720:     ENDPROC
1721: 
1722:     PROCEDURE CmdGarqiconeClick()
1723:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
1724:         TRY
1725:             loc_cSQL = "SELECT codigos, descrs FROM SigCdIcn ORDER BY codigos"
1726:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Icn")
1727:             IF loc_nResult >= 0
1728:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
1729:                 loc_oFrm.DefinirCursor("cursor_4c_Icn", "codigos", "descrs", CHR(205) + "cone")
1730:                 loc_oFrm.Mostrar()
1731:                 IF loc_oFrm.this_lSelecionou
1732:                     loc_oPg = THIS.pgf_4c_Paginas.Page2
1733:                     loc_oPg.txt_4c_Desc.Value = loc_oFrm.cCodigoSelecionado
1734:                 ENDIF
1735:                 IF USED("cursor_4c_Icn")
1736:                     USE IN cursor_4c_Icn
1737:                 ENDIF
1738:             ELSE
1739:                 MsgErro("Erro ao buscar " + CHR(237) + "cones.", "Erro")
1740:             ENDIF
1741:         CATCH TO loException
1742:             MostrarErro(loException, "FormMPD.CmdGarqiconeClick")
1743:         ENDTRY
1744:     ENDPROC
1745: 
1746:     PROCEDURE CmdIconeClick()
1747:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
1748:         TRY
1749:             loc_cSQL = "SELECT codigos, descrs FROM SigCdIcn ORDER BY codigos"
1750:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Icn2")
1751:             IF loc_nResult >= 0
1752:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
1753:                 loc_oFrm.DefinirCursor("cursor_4c_Icn2", "codigos", "descrs", CHR(205) + "cone Barra")
1754:                 loc_oFrm.Mostrar()
1755:                 IF loc_oFrm.this_lSelecionou
1756:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
1757:                     loc_oPg.txt_4c_ArqIcone.Value = loc_oFrm.cCodigoSelecionado
1758:                     IF !EMPTY(loc_oFrm.cCodigoSelecionado)
1759:                         loc_oPg.img_4c_ImgIcone.Picture = gc_4c_CaminhoIcones + ALLTRIM(loc_oFrm.cCodigoSelecionado)
1760:                     ENDIF
1761:                 ENDIF
1762:                 IF USED("cursor_4c_Icn2")
1763:                     USE IN cursor_4c_Icn2
1764:                 ENDIF
1765:             ELSE
1766:                 MsgErro("Erro ao buscar " + CHR(237) + "cones.", "Erro")
1767:             ENDIF
1768:         CATCH TO loException
1769:             MostrarErro(loException, "FormMPD.CmdIconeClick")
1770:         ENDTRY
1771:     ENDPROC
1772: 
1773:     * ============================================================
1774:     * ConfigurarPgEstoque
1775:     * ============================================================
1776:     PROTECTED PROCEDURE ConfigurarPgEstoque()
1777:         LOCAL loc_oPg
1778:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
1779:         TRY
1780:             * Shapes
1781:             loc_oPg.AddObject("shp_4c_Shape1", "Shape")
1782:             WITH loc_oPg.shp_4c_Shape1
1783:                 .Top = 84
1784:                 .Left = 5
1785:                 .Width = 671
1786:                 .Height = 72
1787:                 .Visible = .T.
1788:             ENDWITH
1789:             loc_oPg.AddObject("shp_4c_Shape3", "Shape")
1790:             WITH loc_oPg.shp_4c_Shape3
1791:                 .Top = 205
1792:                 .Left = 5
1793:                 .Width = 671
1794:                 .Height = 73
1795:                 .Visible = .T.
1796:             ENDWITH
1797:             loc_oPg.AddObject("shp_4c_Shape2", "Shape")
1798:             WITH loc_oPg.shp_4c_Shape2
1799:                 .Top = 317
1800:                 .Left = 10
1801:                 .Width = 303
1802:                 .Height = 29
1803:                 .Visible = .T.
1804:             ENDWITH
1805:             * Labels
1806:             loc_oPg.AddObject("lbl_4c_Label21", "Label")
1807:             WITH loc_oPg.lbl_4c_Label21
1808:                 .Top = 15
1809:                 .Left = 27
1810:                 .Width = 90
1811:                 .Height = 15
1812:                 .AutoSize = .F.
1813:                 .Caption = "Numera" + CHR(231) + CHR(227) + "o : "
1814:                 .BackStyle = 0
1815:                 .Visible = .T.
1816:             ENDWITH

*-- Linhas 2023 a 2287:
2023:                 .BackStyle = 0
2024:                 .Visible = .T.
2025:             ENDWITH
2026:             * OptionGroups
2027:             loc_oPg.AddObject("obj_4c_Op_Numeracao", "OptionGroup")
2028:             WITH loc_oPg.obj_4c_Op_Numeracao
2029:                 .Top = 10
2030:                 .Left = 100
2031:                 .Width = 373
2032:                 .Height = 27
2033:                 .ButtonCount = 4
2034:                 .Visible = .T.
2035:                 WITH .Buttons(1)
2036:                     .Left = 3
2037:                     .Width = 88
2038:                     .Caption = "Manual"
2039:                 ENDWITH
2040:                 WITH .Buttons(2)
2041:                     .Left = 94
2042:                     .Width = 88
2043:                     .Caption = "Autom" + CHR(225) + "tica"
2044:                 ENDWITH
2045:                 WITH .Buttons(3)
2046:                     .Left = 185
2047:                     .Width = 88
2048:                     .Caption = "SubN" + CHR(237) + "vel"
2049:                 ENDWITH
2050:                 WITH .Buttons(4)
2051:                     .Left = 276
2052:                     .Width = 88
2053:                     .Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2054:                 ENDWITH
2055:             ENDWITH
2056:             loc_oPg.AddObject("obj_4c_Op_origem", "OptionGroup")
2057:             WITH loc_oPg.obj_4c_Op_origem
2058:                 .Top = 49
2059:                 .Left = 94
2060:                 .Width = 106
2061:                 .Height = 20
2062:                 .ButtonCount = 2
2063:                 .Visible = .T.
2064:                 WITH .Buttons(1)
2065:                     .Left = 3
2066:                     .Caption = "Sim"
2067:                     .Width = 48
2068:                 ENDWITH
2069:                 WITH .Buttons(2)
2070:                     .Left = 54
2071:                     .Caption = "N" + CHR(227) + "o"
2072:                     .Width = 48
2073:                 ENDWITH
2074:             ENDWITH
2075:             loc_oPg.AddObject("obj_4c_Op_EstOrig", "OptionGroup")
2076:             WITH loc_oPg.obj_4c_Op_EstOrig
2077:                 .Top = 87
2078:                 .Left = 468
2079:                 .Width = 200
2080:                 .Height = 25
2081:                 .ButtonCount = 3
2082:                 .Visible = .T.
2083:                 WITH .Buttons(1)
2084:                     .Left = 3
2085:                     .Width = 62
2086:                     .Caption = "Entrada"
2087:                 ENDWITH
2088:                 WITH .Buttons(2)
2089:                     .Left = 68
2090:                     .Width = 62
2091:                     .Caption = "Sa" + CHR(237) + "da"
2092:                 ENDWITH
2093:                 WITH .Buttons(3)
2094:                     .Left = 133
2095:                     .Width = 62
2096:                     .Caption = "Nenhuma"
2097:                 ENDWITH
2098:             ENDWITH
2099:             loc_oPg.AddObject("obj_4c_Op_ConOSub", "OptionGroup")
2100:             WITH loc_oPg.obj_4c_Op_ConOSub
2101:                 .Top = 110
2102:                 .Left = 467
2103:                 .Width = 201
2104:                 .Height = 25
2105:                 .ButtonCount = 3
2106:                 .Visible = .T.
2107:                 WITH .Buttons(1)
2108:                     .Left = 3
2109:                     .Width = 62
2110:                     .Caption = "Origem"
2111:                 ENDWITH
2112:                 WITH .Buttons(2)
2113:                     .Left = 68
2114:                     .Width = 62
2115:                     .Caption = "Destino"
2116:                 ENDWITH
2117:                 WITH .Buttons(3)
2118:                     .Left = 133
2119:                     .Width = 62
2120:                     .Caption = "Nenhuma"
2121:                 ENDWITH
2122:             ENDWITH
2123:             loc_oPg.AddObject("obj_4c_Op_BxOEst", "OptionGroup")
2124:             WITH loc_oPg.obj_4c_Op_BxOEst
2125:                 .Top = 133
2126:                 .Left = 467
2127:                 .Width = 186
2128:                 .Height = 25
2129:                 .ButtonCount = 2
2130:                 .Visible = .T.
2131:                 WITH .Buttons(1)
2132:                     .Left = 3
2133:                     .Caption = "Prod. Acabado"
2134:                     .Width = 88
2135:                 ENDWITH
2136:                 WITH .Buttons(2)
2137:                     .Left = 94
2138:                     .Caption = "Mat. Prima"
2139:                     .Width = 88
2140:                 ENDWITH
2141:             ENDWITH
2142:             loc_oPg.AddObject("obj_4c_Op_destino", "OptionGroup")
2143:             WITH loc_oPg.obj_4c_Op_destino
2144:                 .Top = 169
2145:                 .Left = 94
2146:                 .Width = 106
2147:                 .Height = 20
2148:                 .ButtonCount = 2
2149:                 .Visible = .T.
2150:                 WITH .Buttons(1)
2151:                     .Left = 3
2152:                     .Caption = "Sim"
2153:                     .Width = 48
2154:                 ENDWITH
2155:                 WITH .Buttons(2)
2156:                     .Left = 54
2157:                     .Caption = "N" + CHR(227) + "o"
2158:                     .Width = 48
2159:                 ENDWITH
2160:             ENDWITH
2161:             loc_oPg.AddObject("obj_4c_Get_Repete", "OptionGroup")
2162:             WITH loc_oPg.obj_4c_Get_Repete
2163:                 .Top = 169
2164:                 .Left = 380
2165:                 .Width = 106
2166:                 .Height = 20
2167:                 .ButtonCount = 2
2168:                 .Visible = .T.
2169:                 WITH .Buttons(1)
2170:                     .Left = 3
2171:                     .Caption = "Sim"
2172:                     .Width = 48
2173:                 ENDWITH
2174:                 WITH .Buttons(2)
2175:                     .Left = 54
2176:                     .Caption = "N" + CHR(227) + "o"
2177:                     .Width = 48
2178:                 ENDWITH
2179:             ENDWITH
2180:             loc_oPg.AddObject("obj_4c_Op_EstDest", "OptionGroup")
2181:             WITH loc_oPg.obj_4c_Op_EstDest
2182:                 .Top = 208
2183:                 .Left = 468
2184:                 .Width = 200
2185:                 .Height = 25
2186:                 .ButtonCount = 3
2187:                 .Visible = .T.
2188:                 WITH .Buttons(1)
2189:                     .Left = 3
2190:                     .Width = 62
2191:                     .Caption = "Entrada"
2192:                 ENDWITH
2193:                 WITH .Buttons(2)
2194:                     .Left = 68
2195:                     .Width = 62
2196:                     .Caption = "Sa" + CHR(237) + "da"
2197:                 ENDWITH
2198:                 WITH .Buttons(3)
2199:                     .Left = 133
2200:                     .Width = 62
2201:                     .Caption = "Nenhuma"
2202:                 ENDWITH
2203:             ENDWITH
2204:             loc_oPg.AddObject("obj_4c_Op_ConDSub", "OptionGroup")
2205:             WITH loc_oPg.obj_4c_Op_ConDSub
2206:                 .Top = 231
2207:                 .Left = 468
2208:                 .Width = 200
2209:                 .Height = 25
2210:                 .ButtonCount = 3
2211:                 .Visible = .T.
2212:                 WITH .Buttons(1)
2213:                     .Left = 3
2214:                     .Width = 62
2215:                     .Caption = "Origem"
2216:                 ENDWITH
2217:                 WITH .Buttons(2)
2218:                     .Left = 68
2219:                     .Width = 62
2220:                     .Caption = "Destino"
2221:                 ENDWITH
2222:                 WITH .Buttons(3)
2223:                     .Left = 133
2224:                     .Width = 62
2225:                     .Caption = "Nenhuma"
2226:                 ENDWITH
2227:             ENDWITH
2228:             loc_oPg.AddObject("obj_4c_Op_BxDEst", "OptionGroup")
2229:             WITH loc_oPg.obj_4c_Op_BxDEst
2230:                 .Top = 254
2231:                 .Left = 468
2232:                 .Width = 187
2233:                 .Height = 25
2234:                 .ButtonCount = 2
2235:                 .Visible = .T.
2236:                 WITH .Buttons(1)
2237:                     .Left = 3
2238:                     .Caption = "Prod. Acabado"
2239:                     .Width = 88
2240:                 ENDWITH
2241:                 WITH .Buttons(2)
2242:                     .Left = 94
2243:                     .Caption = "Mat. Prima"
2244:                     .Width = 88
2245:                 ENDWITH
2246:             ENDWITH
2247:             loc_oPg.AddObject("obj_4c_Op_vende", "OptionGroup")
2248:             WITH loc_oPg.obj_4c_Op_vende
2249:                 .Top = 282
2250:                 .Left = 104
2251:                 .Width = 106
2252:                 .Height = 20
2253:                 .ButtonCount = 2
2254:                 .Visible = .T.
2255:                 WITH .Buttons(1)
2256:                     .Left = 3
2257:                     .Caption = "Sim"
2258:                     .Width = 48
2259:                 ENDWITH
2260:                 WITH .Buttons(2)
2261:                     .Left = 54
2262:                     .Caption = "N" + CHR(227) + "o"
2263:                     .Width = 48
2264:                 ENDWITH
2265:             ENDWITH
2266:             * CheckBoxes
2267:             loc_oPg.AddObject("chk_4c_Chk_Grupoo", "CheckBox")
2268:             WITH loc_oPg.chk_4c_Chk_Grupoo
2269:                 .Top = 89
2270:                 .Left = 53
2271:                 .Width = 20
2272:                 .Height = 19
2273:                 .Caption = ""
2274:                 .Value = 0
2275:                 .Visible = .T.
2276:             ENDWITH
2277:             loc_oPg.AddObject("chk_4c_Chk_Contao", "CheckBox")
2278:             WITH loc_oPg.chk_4c_Chk_Contao
2279:                 .Top = 110
2280:                 .Left = 53
2281:                 .Width = 20
2282:                 .Height = 19
2283:                 .Caption = ""
2284:                 .Value = 0
2285:                 .Visible = .T.
2286:             ENDWITH
2287:             loc_oPg.AddObject("chk_4c_ChkSenhaO", "CheckBox")

*-- Linhas 2469 a 2537:
2469:                     USE IN cursor_4c_Toi
2470:                 ENDIF
2471:             ENDIF
2472:             * BINDEVENTs lookups Estoque
2473:             BINDEVENT(loc_oPg.txt_4c_GrupoOrig, "KeyPress", THIS, "GrupoOrigKeyPress")
2474:             BINDEVENT(loc_oPg.txt_4c_GrupoOrig, "DblClick", THIS, "AbrirLookupGrupoOrig")
2475:             BINDEVENT(loc_oPg.txt_4c_ContaOrig, "KeyPress", THIS, "ContaOrigKeyPress")
2476:             BINDEVENT(loc_oPg.txt_4c_ContaOrig, "DblClick", THIS, "AbrirLookupContaOrig")
2477:             BINDEVENT(loc_oPg.txt_4c_GrupoDest, "KeyPress", THIS, "GrupoDestKeyPress")
2478:             BINDEVENT(loc_oPg.txt_4c_GrupoDest, "DblClick", THIS, "AbrirLookupGrupoDest")
2479:             BINDEVENT(loc_oPg.txt_4c_ContaDest, "KeyPress", THIS, "ContaDestKeyPress")
2480:             BINDEVENT(loc_oPg.txt_4c_ContaDest, "DblClick", THIS, "AbrirLookupContaDest")
2481:             BINDEVENT(loc_oPg.txt_4c_GrupoVend, "KeyPress", THIS, "GrupoVendKeyPress")
2482:             BINDEVENT(loc_oPg.txt_4c_GrupoVend, "DblClick", THIS, "AbrirLookupGrupoVend")
2483:             * BINDEVENTs comportamento interativo Estoque
2484:             BINDEVENT(loc_oPg.obj_4c_Op_origem,  "InteractiveChange", THIS, "OpOrigemChange")
2485:             BINDEVENT(loc_oPg.obj_4c_Op_destino, "InteractiveChange", THIS, "OpDestinoChange")
2486:             BINDEVENT(loc_oPg.obj_4c_Op_vende,   "InteractiveChange", THIS, "OpVendeChange")
2487:             BINDEVENT(loc_oPg.obj_4c_Op_EstOrig, "InteractiveChange", THIS, "OpEstOrigChange")
2488:             BINDEVENT(loc_oPg.obj_4c_Op_EstDest, "InteractiveChange", THIS, "OpEstDestChange")
2489:         CATCH TO loException
2490:             MostrarErro(loException, "FormMPD.ConfigurarPgEstoque")
2491:         ENDTRY
2492:     ENDPROC
2493: 
2494:     * ============================================================
2495:     * ConfigurarPgComponente
2496:     * ============================================================
2497:     PROTECTED PROCEDURE ConfigurarPgComponente()
2498:         LOCAL loc_oPg
2499:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
2500:         TRY
2501:             * Labels
2502:             loc_oPg.AddObject("lbl_4c_Label15", "Label")
2503:             WITH loc_oPg.lbl_4c_Label15
2504:                 .Top = 13
2505:                 .Left = 38
2506:                 .Width = 145
2507:                 .Height = 15
2508:                 .AutoSize = .F.
2509:                 .Caption = "Grade Ordens de Produ" + CHR(231) + CHR(227) + "o : "
2510:                 .BackStyle = 0
2511:                 .Visible = .T.
2512:             ENDWITH
2513:             loc_oPg.AddObject("lbl_4c_Label14", "Label")
2514:             WITH loc_oPg.lbl_4c_Label14
2515:                 .Top = 33
2516:                 .Left = 55
2517:                 .Width = 130
2518:                 .Height = 15
2519:                 .AutoSize = .F.
2520:                 .Caption = "Grade de Componentes : "
2521:                 .BackStyle = 0
2522:                 .Visible = .T.
2523:             ENDWITH
2524:             loc_oPg.AddObject("lbl_4c_Label5", "Label")
2525:             WITH loc_oPg.lbl_4c_Label5
2526:                 .Top = 53
2527:                 .Left = 64
2528:                 .Width = 115
2529:                 .Height = 15
2530:                 .AutoSize = .F.
2531:                 .Caption = "Agrupa Componentes : "
2532:                 .BackStyle = 0
2533:                 .Visible = .T.
2534:             ENDWITH
2535:             loc_oPg.AddObject("lbl_4c_Label8", "Label")
2536:             WITH loc_oPg.lbl_4c_Label8
2537:                 .Top = 73

*-- Linhas 2851 a 3330:
2851:                 .BackStyle = 0
2852:                 .Visible = .T.
2853:             ENDWITH
2854:             * OptionGroups
2855:             loc_oPg.AddObject("obj_4c_Op_grprod", "OptionGroup")
2856:             WITH loc_oPg.obj_4c_Op_grprod
2857:                 .Top = 9
2858:                 .Left = 183
2859:                 .Width = 92
2860:                 .Height = 25
2861:                 .ButtonCount = 2
2862:                 .Visible = .T.
2863:                 WITH .Buttons(1)
2864:                     .Left = 3
2865:                     .Caption = "Sim"
2866:                     .Width = 40
2867:                 ENDWITH
2868:                 WITH .Buttons(2)
2869:                     .Left = 46
2870:                     .Caption = "N" + CHR(227) + "o"
2871:                     .Width = 40
2872:                 ENDWITH
2873:             ENDWITH
2874:             loc_oPg.AddObject("obj_4c_Op_grcomp", "OptionGroup")
2875:             WITH loc_oPg.obj_4c_Op_grcomp
2876:                 .Top = 29
2877:                 .Left = 183
2878:                 .Width = 92
2879:                 .Height = 25
2880:                 .ButtonCount = 2
2881:                 .Visible = .T.
2882:                 WITH .Buttons(1)
2883:                     .Left = 3
2884:                     .Caption = "Sim"
2885:                     .Width = 40
2886:                 ENDWITH
2887:                 WITH .Buttons(2)
2888:                     .Left = 46
2889:                     .Caption = "N" + CHR(227) + "o"
2890:                     .Width = 40
2891:                 ENDWITH
2892:             ENDWITH
2893:             loc_oPg.AddObject("obj_4c_Op_compagru", "OptionGroup")
2894:             WITH loc_oPg.obj_4c_Op_compagru
2895:                 .Top = 49
2896:                 .Left = 183
2897:                 .Width = 178
2898:                 .Height = 25
2899:                 .ButtonCount = 3
2900:                 .Visible = .T.
2901:                 WITH .Buttons(1)
2902:                     .Left = 3
2903:                     .Width = 55
2904:                 ENDWITH
2905:                 WITH .Buttons(2)
2906:                     .Left = 61
2907:                     .Width = 55
2908:                 ENDWITH
2909:                 WITH .Buttons(3)
2910:                     .Left = 119
2911:                     .Width = 55
2912:                 ENDWITH
2913:             ENDWITH
2914:             loc_oPg.AddObject("obj_4c_Op_SepPedra", "OptionGroup")
2915:             WITH loc_oPg.obj_4c_Op_SepPedra
2916:                 .Top = 69
2917:                 .Left = 183
2918:                 .Width = 140
2919:                 .Height = 42
2920:                 .ButtonCount = 4
2921:                 .Visible = .T.
2922:                 WITH .Buttons(1)
2923:                     .Left = 3
2924:                     .Top = 2
2925:                     .Width = 65
2926:                     .Height = 14
2927:                 ENDWITH
2928:                 WITH .Buttons(2)
2929:                     .Left = 71
2930:                     .Top = 2
2931:                     .Width = 65
2932:                     .Height = 14
2933:                 ENDWITH
2934:                 WITH .Buttons(3)
2935:                     .Left = 3
2936:                     .Top = 22
2937:                     .Width = 65
2938:                     .Height = 14
2939:                 ENDWITH
2940:                 WITH .Buttons(4)
2941:                     .Left = 71
2942:                     .Top = 22
2943:                     .Width = 65
2944:                     .Height = 14
2945:                 ENDWITH
2946:             ENDWITH
2947:             loc_oPg.AddObject("obj_4c_OptBxPedFins", "OptionGroup")
2948:             WITH loc_oPg.obj_4c_OptBxPedFins
2949:                 .Top = 142
2950:                 .Left = 182
2951:                 .Width = 107
2952:                 .Height = 25
2953:                 .ButtonCount = 2
2954:                 .Visible = .T.
2955:                 WITH .Buttons(1)
2956:                     .Left = 3
2957:                     .Caption = "Sim"
2958:                     .Width = 48
2959:                 ENDWITH
2960:                 WITH .Buttons(2)
2961:                     .Left = 54
2962:                     .Caption = "N" + CHR(227) + "o"
2963:                     .Width = 48
2964:                 ENDWITH
2965:             ENDWITH
2966:             loc_oPg.AddObject("obj_4c_Op_GrTrans", "OptionGroup")
2967:             WITH loc_oPg.obj_4c_Op_GrTrans
2968:                 .Top = 270
2969:                 .Left = 182
2970:                 .Width = 133
2971:                 .Height = 40
2972:                 .ButtonCount = 3
2973:                 .Visible = .T.
2974:                 WITH .Buttons(1)
2975:                     .Left = 3
2976:                     .Top = 2
2977:                     .Width = 40
2978:                     .Height = 14
2979:                 ENDWITH
2980:                 WITH .Buttons(2)
2981:                     .Left = 46
2982:                     .Top = 2
2983:                     .Width = 40
2984:                     .Height = 14
2985:                 ENDWITH
2986:                 WITH .Buttons(3)
2987:                     .Left = 3
2988:                     .Top = 22
2989:                     .Width = 83
2990:                     .Height = 14
2991:                 ENDWITH
2992:             ENDWITH
2993:             loc_oPg.AddObject("obj_4c_ObjChkQP", "OptionGroup")
2994:             WITH loc_oPg.obj_4c_ObjChkQP
2995:                 .Top = 306
2996:                 .Left = 182
2997:                 .Width = 171
2998:                 .Height = 39
2999:                 .ButtonCount = 4
3000:                 .Visible = .T.
3001:                 WITH .Buttons(1)
3002:                     .Left = 3
3003:                     .Top = 2
3004:                     .Width = 80
3005:                     .Height = 14
3006:                 ENDWITH
3007:                 WITH .Buttons(2)
3008:                     .Left = 86
3009:                     .Top = 2
3010:                     .Width = 80
3011:                     .Height = 14
3012:                 ENDWITH
3013:                 WITH .Buttons(3)
3014:                     .Left = 3
3015:                     .Top = 22
3016:                     .Width = 80
3017:                     .Height = 14
3018:                 ENDWITH
3019:                 WITH .Buttons(4)
3020:                     .Left = 86
3021:                     .Top = 22
3022:                     .Width = 80
3023:                     .Height = 14
3024:                 ENDWITH
3025:             ENDWITH
3026:             loc_oPg.AddObject("obj_4c_ObjReinop", "OptionGroup")
3027:             WITH loc_oPg.obj_4c_ObjReinop
3028:                 .Top = 378
3029:                 .Left = 182
3030:                 .Width = 204
3031:                 .Height = 25
3032:                 .ButtonCount = 3
3033:                 .Visible = .T.
3034:                 WITH .Buttons(1)
3035:                     .Left = 3
3036:                     .Width = 62
3037:                 ENDWITH
3038:                 WITH .Buttons(2)
3039:                     .Left = 68
3040:                     .Width = 62
3041:                 ENDWITH
3042:                 WITH .Buttons(3)
3043:                     .Left = 133
3044:                     .Width = 62
3045:                 ENDWITH
3046:             ENDWITH
3047:             loc_oPg.AddObject("obj_4c_Op_etiq", "OptionGroup")
3048:             WITH loc_oPg.obj_4c_Op_etiq
3049:                 .Top = 356
3050:                 .Left = 182
3051:                 .Width = 275
3052:                 .Height = 25
3053:                 .ButtonCount = 4
3054:                 .Visible = .T.
3055:                 WITH .Buttons(1)
3056:                     .Left = 3
3057:                     .Width = 65
3058:                 ENDWITH
3059:                 WITH .Buttons(2)
3060:                     .Left = 71
3061:                     .Width = 65
3062:                 ENDWITH
3063:                 WITH .Buttons(3)
3064:                     .Left = 139
3065:                     .Width = 65
3066:                 ENDWITH
3067:                 WITH .Buttons(4)
3068:                     .Left = 207
3069:                     .Width = 65
3070:                 ENDWITH
3071:             ENDWITH
3072:             loc_oPg.AddObject("obj_4c_Opt_quebraimp", "OptionGroup")
3073:             WITH loc_oPg.obj_4c_Opt_quebraimp
3074:                 .Top = 412
3075:                 .Left = 182
3076:                 .Width = 92
3077:                 .Height = 25
3078:                 .ButtonCount = 2
3079:                 .Visible = .T.
3080:                 WITH .Buttons(1)
3081:                     .Left = 3
3082:                     .Caption = "Sim"
3083:                     .Width = 40
3084:                 ENDWITH
3085:                 WITH .Buttons(2)
3086:                     .Left = 46
3087:                     .Caption = "N" + CHR(227) + "o"
3088:                     .Width = 40
3089:                 ENDWITH
3090:             ENDWITH
3091:             loc_oPg.AddObject("obj_4c_Opt_codlib", "OptionGroup")
3092:             WITH loc_oPg.obj_4c_Opt_codlib
3093:                 .Top = 229
3094:                 .Left = 182
3095:                 .Width = 92
3096:                 .Height = 25
3097:                 .ButtonCount = 2
3098:                 .Visible = .T.
3099:                 WITH .Buttons(1)
3100:                     .Left = 3
3101:                     .Caption = "Sim"
3102:                     .Width = 40
3103:                 ENDWITH
3104:                 WITH .Buttons(2)
3105:                     .Left = 46
3106:                     .Caption = "N" + CHR(227) + "o"
3107:                     .Width = 40
3108:                 ENDWITH
3109:             ENDWITH
3110:             loc_oPg.AddObject("obj_4c_Opt_cravacera", "OptionGroup")
3111:             WITH loc_oPg.obj_4c_Opt_cravacera
3112:                 .Top = 250
3113:                 .Left = 182
3114:                 .Width = 92
3115:                 .Height = 25
3116:                 .ButtonCount = 2
3117:                 .Visible = .T.
3118:                 WITH .Buttons(1)
3119:                     .Left = 3
3120:                     .Caption = "Sim"
3121:                     .Width = 40
3122:                 ENDWITH
3123:                 WITH .Buttons(2)
3124:                     .Left = 46
3125:                     .Caption = "N" + CHR(227) + "o"
3126:                     .Width = 40
3127:                 ENDWITH
3128:             ENDWITH
3129:             loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
3130:             WITH loc_oPg.obj_4c_Fwoption2
3131:                 .Top = 210
3132:                 .Left = 181
3133:                 .Width = 92
3134:                 .Height = 25
3135:                 .ButtonCount = 2
3136:                 .Visible = .T.
3137:                 WITH .Buttons(1)
3138:                     .Left = 3
3139:                     .Caption = "Sim"
3140:                     .Width = 40
3141:                 ENDWITH
3142:                 WITH .Buttons(2)
3143:                     .Left = 46
3144:                     .Caption = "N" + CHR(227) + "o"
3145:                     .Width = 40
3146:                 ENDWITH
3147:             ENDWITH
3148:             * Right column OptionGroups
3149:             loc_oPg.AddObject("obj_4c_Opc_Chkf", "OptionGroup")
3150:             WITH loc_oPg.obj_4c_Opc_Chkf
3151:                 .Top = 100
3152:                 .Left = 626
3153:                 .Width = 110
3154:                 .Height = 25
3155:                 .ButtonCount = 2
3156:                 .Visible = .T.
3157:                 WITH .Buttons(1)
3158:                     .Left = 3
3159:                     .Caption = "Sim"
3160:                     .Width = 48
3161:                 ENDWITH
3162:                 WITH .Buttons(2)
3163:                     .Left = 54
3164:                     .Caption = "N" + CHR(227) + "o"
3165:                     .Width = 48
3166:                 ENDWITH
3167:             ENDWITH
3168:             loc_oPg.AddObject("obj_4c_Opc_fix", "OptionGroup")
3169:             WITH loc_oPg.obj_4c_Opc_fix
3170:                 .Top = 119
3171:                 .Left = 626
3172:                 .Width = 202
3173:                 .Height = 25
3174:                 .ButtonCount = 3
3175:                 .Visible = .T.
3176:                 WITH .Buttons(1)
3177:                     .Left = 3
3178:                     .Width = 62
3179:                 ENDWITH
3180:                 WITH .Buttons(2)
3181:                     .Left = 68
3182:                     .Width = 62
3183:                 ENDWITH
3184:                 WITH .Buttons(3)
3185:                     .Left = 133
3186:                     .Width = 62
3187:                 ENDWITH
3188:             ENDWITH
3189:             loc_oPg.AddObject("obj_4c_Opc_PagSer", "OptionGroup")
3190:             WITH loc_oPg.obj_4c_Opc_PagSer
3191:                 .Top = 155
3192:                 .Left = 626
3193:                 .Width = 206
3194:                 .Height = 25
3195:                 .ButtonCount = 3
3196:                 .Visible = .T.
3197:                 WITH .Buttons(1)
3198:                     .Left = 3
3199:                     .Width = 62
3200:                 ENDWITH
3201:                 WITH .Buttons(2)
3202:                     .Left = 68
3203:                     .Width = 62
3204:                 ENDWITH
3205:                 WITH .Buttons(3)
3206:                     .Left = 133
3207:                     .Width = 62
3208:                 ENDWITH
3209:             ENDWITH
3210:             loc_oPg.AddObject("obj_4c_Opc_mens", "OptionGroup")
3211:             WITH loc_oPg.obj_4c_Opc_mens
3212:                 .Top = 175
3213:                 .Left = 626
3214:                 .Width = 110
3215:                 .Height = 25
3216:                 .ButtonCount = 2
3217:                 .Visible = .T.
3218:                 WITH .Buttons(1)
3219:                     .Left = 3
3220:                     .Caption = "Sim"
3221:                     .Width = 48
3222:                 ENDWITH
3223:                 WITH .Buttons(2)
3224:                     .Left = 54
3225:                     .Caption = "N" + CHR(227) + "o"
3226:                     .Width = 48
3227:                 ENDWITH
3228:             ENDWITH
3229:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
3230:             WITH loc_oPg.obj_4c_Fwoption1
3231:                 .Top = 215
3232:                 .Left = 626
3233:                 .Width = 209
3234:                 .Height = 25
3235:                 .ButtonCount = 2
3236:                 .Visible = .T.
3237:                 WITH .Buttons(1)
3238:                     .Left = 3
3239:                     .Caption = "Sim"
3240:                     .Width = 96
3241:                 ENDWITH
3242:                 WITH .Buttons(2)
3243:                     .Left = 102
3244:                     .Caption = "N" + CHR(227) + "o"
3245:                     .Width = 96
3246:                 ENDWITH
3247:             ENDWITH
3248:             loc_oPg.AddObject("obj_4c_Opc_env", "OptionGroup")
3249:             WITH loc_oPg.obj_4c_Opc_env
3250:                 .Top = 195
3251:                 .Left = 626
3252:                 .Width = 209
3253:                 .Height = 25
3254:                 .ButtonCount = 3
3255:                 .Visible = .T.
3256:                 WITH .Buttons(1)
3257:                     .Left = 3
3258:                     .Width = 62
3259:                 ENDWITH
3260:                 WITH .Buttons(2)
3261:                     .Left = 68
3262:                     .Width = 62
3263:                 ENDWITH
3264:                 WITH .Buttons(3)
3265:                     .Left = 133
3266:                     .Width = 62
3267:                 ENDWITH
3268:             ENDWITH
3269:             loc_oPg.AddObject("obj_4c_Opc_pesobal", "OptionGroup")
3270:             WITH loc_oPg.obj_4c_Opc_pesobal
3271:                 .Top = 236
3272:                 .Left = 626
3273:                 .Width = 209
3274:                 .Height = 25
3275:                 .ButtonCount = 3
3276:                 .Visible = .T.
3277:                 WITH .Buttons(1)
3278:                     .Left = 3
3279:                     .Width = 62
3280:                 ENDWITH
3281:                 WITH .Buttons(2)
3282:                     .Left = 68
3283:                     .Width = 62
3284:                 ENDWITH
3285:                 WITH .Buttons(3)
3286:                     .Left = 133
3287:                     .Width = 62
3288:                 ENDWITH
3289:             ENDWITH
3290:             loc_oPg.AddObject("obj_4c_Chk_TrfPeso", "OptionGroup")
3291:             WITH loc_oPg.obj_4c_Chk_TrfPeso
3292:                 .Top = 253
3293:                 .Left = 626
3294:                 .Width = 203
3295:                 .Height = 87
3296:                 .ButtonCount = 7
3297:                 .Visible = .T.
3298:                 WITH .Buttons(1)
3299:                     .Left = 3
3300:                     .Top = 2
3301:                     .Width = 95
3302:                     .Height = 14
3303:                 ENDWITH
3304:                 WITH .Buttons(2)
3305:                     .Left = 101
3306:                     .Top = 2
3307:                     .Width = 95
3308:                     .Height = 14
3309:                 ENDWITH
3310:                 WITH .Buttons(3)
3311:                     .Left = 3
3312:                     .Top = 18
3313:                     .Width = 95
3314:                     .Height = 14
3315:                 ENDWITH
3316:                 WITH .Buttons(4)
3317:                     .Left = 101
3318:                     .Top = 18
3319:                     .Width = 95
3320:                     .Height = 14
3321:                 ENDWITH
3322:                 WITH .Buttons(5)
3323:                     .Left = 3
3324:                     .Top = 34
3325:                     .Width = 95
3326:                     .Height = 14
3327:                 ENDWITH
3328:                 WITH .Buttons(6)
3329:                     .Left = 101
3330:                     .Top = 34

*-- Linhas 3338 a 3421:
3338:                     .Height = 14
3339:                 ENDWITH
3340:             ENDWITH
3341:             loc_oPg.AddObject("obj_4c_Optqtdneg", "OptionGroup")
3342:             WITH loc_oPg.obj_4c_Optqtdneg
3343:                 .Top = 351
3344:                 .Left = 626
3345:                 .Width = 291
3346:                 .Height = 25
3347:                 .ButtonCount = 3
3348:                 .Visible = .T.
3349:                 WITH .Buttons(1)
3350:                     .Left = 3
3351:                     .Width = 90
3352:                 ENDWITH
3353:                 WITH .Buttons(2)
3354:                     .Left = 96
3355:                     .Width = 90
3356:                 ENDWITH
3357:                 WITH .Buttons(3)
3358:                     .Left = 189
3359:                     .Width = 90
3360:                 ENDWITH
3361:             ENDWITH
3362:             loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
3363:             WITH loc_oPg.obj_4c_Fwoption3
3364:                 .Top = 370
3365:                 .Left = 626
3366:                 .Width = 110
3367:                 .Height = 25
3368:                 .ButtonCount = 2
3369:                 .Visible = .T.
3370:                 WITH .Buttons(1)
3371:                     .Left = 3
3372:                     .Caption = "Sim"
3373:                     .Width = 48
3374:                 ENDWITH
3375:                 WITH .Buttons(2)
3376:                     .Left = 54
3377:                     .Caption = "N" + CHR(227) + "o"
3378:                     .Width = 48
3379:                 ENDWITH
3380:             ENDWITH
3381:             loc_oPg.AddObject("obj_4c_OptMatPrncDif", "OptionGroup")
3382:             WITH loc_oPg.obj_4c_OptMatPrncDif
3383:                 .Top = 390
3384:                 .Left = 627
3385:                 .Width = 110
3386:                 .Height = 25
3387:                 .ButtonCount = 2
3388:                 .Visible = .T.
3389:                 WITH .Buttons(1)
3390:                     .Left = 3
3391:                     .Caption = "Sim"
3392:                     .Width = 48
3393:                 ENDWITH
3394:                 WITH .Buttons(2)
3395:                     .Left = 54
3396:                     .Caption = "N" + CHR(227) + "o"
3397:                     .Width = 48
3398:                 ENDWITH
3399:             ENDWITH
3400:             * CheckBoxes
3401:             loc_oPg.AddObject("chk_4c_ChkCarQtde", "CheckBox")
3402:             WITH loc_oPg.chk_4c_ChkCarQtde
3403:                 .Top = 105
3404:                 .Left = 199
3405:                 .Width = 160
3406:                 .Height = 19
3407:                 .Caption = "N" + CHR(227) + "o carrega Qtde e Peso"
3408:                 .Value = 0
3409:                 .Visible = .T.
3410:             ENDWITH
3411:             loc_oPg.AddObject("chk_4c_OptChkPeso", "CheckBox")
3412:             WITH loc_oPg.chk_4c_OptChkPeso
3413:                 .Top = 339
3414:                 .Left = 198
3415:                 .Width = 80
3416:                 .Height = 19
3417:                 .Caption = "Checa peso"
3418:                 .Value = 0
3419:                 .Visible = .T.
3420:             ENDWITH
3421:             loc_oPg.AddObject("chk_4c_Chk_LibRein", "CheckBox")

*-- Linhas 3525 a 3585:
3525:                 .AddItem("+")
3526:                 .AddItem("-")
3527:             ENDWITH
3528:             * BINDEVENTs lookups Componente
3529:             BINDEVENT(loc_oPg.txt_4c_TpPadrao, "KeyPress", THIS, "TpPadraoKeyPress")
3530:             BINDEVENT(loc_oPg.txt_4c_TpPadrao, "DblClick", THIS, "AbrirLookupTpPadrao")
3531:             BINDEVENT(loc_oPg.txt_4c_Retalho,  "KeyPress", THIS, "RetalhoKeyPress")
3532:             BINDEVENT(loc_oPg.txt_4c_Retalho,  "DblClick", THIS, "AbrirLookupRetalho")
3533:             BINDEVENT(loc_oPg.txt_4c_GrupoPcc, "KeyPress", THIS, "GrupoPccKeyPress")
3534:             BINDEVENT(loc_oPg.txt_4c_GrupoPcc, "DblClick", THIS, "AbrirLookupGrupoPcc")
3535:             BINDEVENT(loc_oPg.txt_4c__produto,  "KeyPress", THIS, "ProdutoKeyPress")
3536:             BINDEVENT(loc_oPg.txt_4c__produto,  "DblClick", THIS, "AbrirLookupProduto")
3537:         CATCH TO loException
3538:             MostrarErro(loException, "FormMPD.ConfigurarPgComponente")
3539:         ENDTRY
3540:     ENDPROC
3541: 
3542:     * ============================================================
3543:     * ConfigurarPgDocumento
3544:     * ============================================================
3545:     PROTECTED PROCEDURE ConfigurarPgDocumento()
3546:         LOCAL loc_oPg
3547:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page4
3548:         TRY
3549:             loc_oPg.AddObject("shp_4c_Shape1", "Shape")
3550:             WITH loc_oPg.shp_4c_Shape1
3551:                 .Top           = 26
3552:                 .Left          = 23
3553:                 .Width         = 329
3554:                 .Height        = 131
3555:                 .BackStyle     = 0
3556:                 .SpecialEffect = 0
3557:                 .Visible       = .T.
3558:             ENDWITH
3559:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
3560:             WITH loc_oPg.lbl_4c_Label25
3561:                 .Top      = 35
3562:                 .Left     = 33
3563:                 .Width    = 119
3564:                 .Height   = 15
3565:                 .AutoSize = .F.
3566:                 .FontBold = .T.
3567:                 .Caption  = "Impress" + CHR(227) + "o de Boleto"
3568:                 .BackStyle = 0
3569:                 .Visible  = .T.
3570:             ENDWITH
3571:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
3572:             WITH loc_oPg.lbl_4c_Label1
3573:                 .Top = 69
3574:                 .Left = 88
3575:                 .Width = 64
3576:                 .Height = 15
3577:                 .AutoSize = .F.
3578:                 .Caption = "Imprimir OP :"
3579:                 .BackStyle = 0
3580:                 .Visible = .T.
3581:             ENDWITH
3582:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
3583:             WITH loc_oPg.lbl_4c_Label2
3584:                 .Top = 95
3585:                 .Left = 64

*-- Linhas 3601 a 3714:
3601:                 .BackStyle = 0
3602:                 .Visible = .T.
3603:             ENDWITH
3604:             loc_oPg.AddObject("obj_4c_Optiongroup1", "OptionGroup")
3605:             WITH loc_oPg.obj_4c_Optiongroup1
3606:                 .Top = 64
3607:                 .Left = 176
3608:                 .Width = 102
3609:                 .Height = 26
3610:                 .ButtonCount = 2
3611:                 .Visible = .T.
3612:                 WITH .Buttons(1)
3613:                     .Left = 3
3614:                     .Caption = "Sim"
3615:                     .Width = 44
3616:                 ENDWITH
3617:                 WITH .Buttons(2)
3618:                     .Left = 50
3619:                     .Caption = "N" + CHR(227) + "o"
3620:                     .Width = 44
3621:                 ENDWITH
3622:             ENDWITH
3623:             loc_oPg.AddObject("obj_4c_Optiongroup2", "OptionGroup")
3624:             WITH loc_oPg.obj_4c_Optiongroup2
3625:                 .Top = 90
3626:                 .Left = 176
3627:                 .Width = 164
3628:                 .Height = 26
3629:                 .ButtonCount = 3
3630:                 .Visible = .T.
3631:                 WITH .Buttons(1)
3632:                     .Left    = 3
3633:                     .Width   = 50
3634:                     .Caption = "Sim"
3635:                 ENDWITH
3636:                 WITH .Buttons(2)
3637:                     .Left    = 56
3638:                     .Width   = 50
3639:                     .Caption = "N" + CHR(227) + "o"
3640:                 ENDWITH
3641:                 WITH .Buttons(3)
3642:                     .Left    = 109
3643:                     .Width   = 50
3644:                     .Caption = "Pedra"
3645:                 ENDWITH
3646:             ENDWITH
3647:             loc_oPg.AddObject("obj_4c_Optiongroup3", "OptionGroup")
3648:             WITH loc_oPg.obj_4c_Optiongroup3
3649:                 .Top = 116
3650:                 .Left = 176
3651:                 .Width = 102
3652:                 .Height = 26
3653:                 .ButtonCount = 2
3654:                 .Visible = .T.
3655:                 WITH .Buttons(1)
3656:                     .Left = 3
3657:                     .Caption = "Sim"
3658:                     .Width = 44
3659:                 ENDWITH
3660:                 WITH .Buttons(2)
3661:                     .Left = 50
3662:                     .Caption = "N" + CHR(227) + "o"
3663:                     .Width = 44
3664:                 ENDWITH
3665:             ENDWITH
3666:         CATCH TO loException
3667:             MostrarErro(loException, "FormMPD.ConfigurarPgDocumento")
3668:         ENDTRY
3669:     ENDPROC
3670: 
3671:     * ============================================================
3672:     * ConfigurarPgDiversas
3673:     * ============================================================
3674:     PROTECTED PROCEDURE ConfigurarPgDiversas()
3675:         LOCAL loc_oPg
3676:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
3677:         TRY
3678:             * Line
3679:             loc_oPg.AddObject("lin_4c_Line1", "Line")
3680:             WITH loc_oPg.lin_4c_Line1
3681:                 .Top = 11
3682:                 .Left = 591
3683:                 .Width = 0
3684:                 .Height = 418
3685:                 .Visible = .T.
3686:             ENDWITH
3687:             * Labels
3688:             loc_oPg.AddObject("lbl_4c_Label26", "Label")
3689:             WITH loc_oPg.lbl_4c_Label26
3690:                 .Top = 16
3691:                 .Left = 8
3692:                 .Width = 101
3693:                 .Height = 15
3694:                 .AutoSize = .F.
3695:                 .Caption = "Casas Decimais qtd :"
3696:                 .BackStyle = 0
3697:                 .Visible = .T.
3698:             ENDWITH
3699:             loc_oPg.AddObject("lbl_4c_LblObspads", "Label")
3700:             WITH loc_oPg.lbl_4c_LblObspads
3701:                 .Top = 45
3702:                 .Left = 12
3703:                 .Width = 104
3704:                 .Height = 15
3705:                 .AutoSize = .F.
3706:                 .Caption = "Observa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :"
3707:                 .BackStyle = 0
3708:                 .Visible = .T.
3709:             ENDWITH
3710:             loc_oPg.AddObject("lbl_4c_Label6", "Label")
3711:             WITH loc_oPg.lbl_4c_Label6
3712:                 .Top = 45
3713:                 .Left = 160
3714:                 .Width = 22

*-- Linhas 3965 a 4107:
3965:                 .Height = 23
3966:                 .Visible = .T.
3967:             ENDWITH
3968:             * OptionGroups
3969:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
3970:             WITH loc_oPg.obj_4c_Fwoption1
3971:                 .Top = 71
3972:                 .Left = 181
3973:                 .Width = 92
3974:                 .Height = 20
3975:                 .ButtonCount = 2
3976:                 .Visible = .T.
3977:                 WITH .Buttons(1)
3978:                     .Left = 3
3979:                     .Caption = "Sim"
3980:                     .Width = 40
3981:                 ENDWITH
3982:                 WITH .Buttons(2)
3983:                     .Left = 46
3984:                     .Caption = "N" + CHR(227) + "o"
3985:                     .Width = 40
3986:                 ENDWITH
3987:             ENDWITH
3988:             loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
3989:             WITH loc_oPg.obj_4c_Fwoption2
3990:                 .Top = 92
3991:                 .Left = 181
3992:                 .Width = 92
3993:                 .Height = 20
3994:                 .ButtonCount = 2
3995:                 .Visible = .T.
3996:                 WITH .Buttons(1)
3997:                     .Left = 3
3998:                     .Caption = "Sim"
3999:                     .Width = 40
4000:                 ENDWITH
4001:                 WITH .Buttons(2)
4002:                     .Left = 46
4003:                     .Caption = "N" + CHR(227) + "o"
4004:                     .Width = 40
4005:                 ENDWITH
4006:             ENDWITH
4007:             loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
4008:             WITH loc_oPg.obj_4c_Fwoption3
4009:                 .Top = 196
4010:                 .Left = 180
4011:                 .Width = 92
4012:                 .Height = 20
4013:                 .ButtonCount = 2
4014:                 .Visible = .T.
4015:                 WITH .Buttons(1)
4016:                     .Left = 3
4017:                     .Caption = "Sim"
4018:                     .Width = 40
4019:                 ENDWITH
4020:                 WITH .Buttons(2)
4021:                     .Left = 46
4022:                     .Caption = "N" + CHR(227) + "o"
4023:                     .Width = 40
4024:                 ENDWITH
4025:             ENDWITH
4026:             loc_oPg.AddObject("obj_4c_Fwoption4", "OptionGroup")
4027:             WITH loc_oPg.obj_4c_Fwoption4
4028:                 .Top = 220
4029:                 .Left = 180
4030:                 .Width = 92
4031:                 .Height = 20
4032:                 .ButtonCount = 2
4033:                 .Visible = .T.
4034:                 WITH .Buttons(1)
4035:                     .Left = 3
4036:                     .Caption = "Sim"
4037:                     .Width = 40
4038:                 ENDWITH
4039:                 WITH .Buttons(2)
4040:                     .Left = 46
4041:                     .Caption = "N" + CHR(227) + "o"
4042:                     .Width = 40
4043:                 ENDWITH
4044:             ENDWITH
4045:             loc_oPg.AddObject("obj_4c_Fwoption5", "OptionGroup")
4046:             WITH loc_oPg.obj_4c_Fwoption5
4047:                 .Top = 338
4048:                 .Left = 184
4049:                 .Width = 182
4050:                 .Height = 21
4051:                 .ButtonCount = 3
4052:                 .Visible = .T.
4053:                 WITH .Buttons(1)
4054:                     .Left = 3
4055:                     .Width = 55
4056:                 ENDWITH
4057:                 WITH .Buttons(2)
4058:                     .Left = 61
4059:                     .Width = 55
4060:                 ENDWITH
4061:                 WITH .Buttons(3)
4062:                     .Left = 119
4063:                     .Width = 55
4064:                 ENDWITH
4065:             ENDWITH
4066:             loc_oPg.AddObject("obj_4c_Optiongroup1", "OptionGroup")
4067:             WITH loc_oPg.obj_4c_Optiongroup1
4068:                 .Top = 80
4069:                 .Left = 818
4070:                 .Width = 119
4071:                 .Height = 19
4072:                 .ButtonCount = 2
4073:                 .Visible = .T.
4074:                 WITH .Buttons(1)
4075:                     .Left = 3
4076:                     .Caption = "Sim"
4077:                     .Width = 54
4078:                 ENDWITH
4079:                 WITH .Buttons(2)
4080:                     .Left = 60
4081:                     .Caption = "N" + CHR(227) + "o"
4082:                     .Width = 54
4083:                 ENDWITH
4084:             ENDWITH
4085:             * CheckBoxes
4086:             loc_oPg.AddObject("chk_4c_Chk_Pcc", "CheckBox")
4087:             WITH loc_oPg.chk_4c_Chk_Pcc
4088:                 .Top = 12
4089:                 .Left = 604
4090:                 .Width = 200
4091:                 .Height = 19
4092:                 .Caption = "Marcar OP como cancelada"
4093:                 .Value = 0
4094:                 .Visible = .T.
4095:             ENDWITH
4096:             loc_oPg.AddObject("chk_4c_Chk_imp", "CheckBox")
4097:             WITH loc_oPg.chk_4c_Chk_imp
4098:                 .Top = 29
4099:                 .Left = 604
4100:                 .Width = 250
4101:                 .Height = 19
4102:                 .Caption = "Imprimir Somente Peso do Material Principal"
4103:                 .Value = 0
4104:                 .Visible = .T.
4105:             ENDWITH
4106:             loc_oPg.AddObject("chk_4c_Chk_InibAlt", "CheckBox")
4107:             WITH loc_oPg.chk_4c_Chk_InibAlt

*-- Linhas 4143 a 4213:
4143:                 .Value = 0
4144:                 .Visible = .T.
4145:             ENDWITH
4146:             * BINDEVENTs lookups Diversas
4147:             BINDEVENT(loc_oPg.txt_4c_Obspads,   "KeyPress", THIS, "ObspadsKeyPress")
4148:             BINDEVENT(loc_oPg.txt_4c_Obspads,   "DblClick", THIS, "AbrirLookupObspads")
4149:             BINDEVENT(loc_oPg.txt_4c_ObsInis,   "KeyPress", THIS, "ObsInisKeyPress")
4150:             BINDEVENT(loc_oPg.txt_4c_ObsInis,   "DblClick", THIS, "AbrirLookupObsInis")
4151:             BINDEVENT(loc_oPg.txt_4c_ObsFins,   "KeyPress", THIS, "ObsFinsKeyPress")
4152:             BINDEVENT(loc_oPg.txt_4c_ObsFins,   "DblClick", THIS, "AbrirLookupObsFins")
4153:             BINDEVENT(loc_oPg.txt_4c_GruFin,    "KeyPress", THIS, "GruFinKeyPress")
4154:             BINDEVENT(loc_oPg.txt_4c_GruFin,    "DblClick", THIS, "AbrirLookupGruFin")
4155:             BINDEVENT(loc_oPg.txt_4c_OpConta,   "KeyPress", THIS, "OpContaKeyPress")
4156:             BINDEVENT(loc_oPg.txt_4c_OpConta,   "DblClick", THIS, "AbrirLookupOpConta")
4157:             BINDEVENT(loc_oPg.txt_4c_TpOp,      "KeyPress", THIS, "TpOpKeyPress")
4158:             BINDEVENT(loc_oPg.txt_4c_TpOp,      "DblClick", THIS, "AbrirLookupTpOp")
4159:             BINDEVENT(loc_oPg.txt_4c__gruccus,  "KeyPress", THIS, "GruccusKeyPress")
4160:             BINDEVENT(loc_oPg.txt_4c__gruccus,  "DblClick", THIS, "AbrirLookupGruccus")
4161:             BINDEVENT(loc_oPg.txt_4c__contaccus,"KeyPress", THIS, "ContaccusKeyPress")
4162:             BINDEVENT(loc_oPg.txt_4c__contaccus,"DblClick", THIS, "AbrirLookupContaccus")
4163:             BINDEVENT(loc_oPg.txt_4c_Semi,      "KeyPress", THIS, "SemiKeyPress")
4164:             BINDEVENT(loc_oPg.txt_4c_Semi,      "DblClick", THIS, "AbrirLookupSemi")
4165:         CATCH TO loException
4166:             MostrarErro(loException, "FormMPD.ConfigurarPgDiversas")
4167:         ENDTRY
4168:     ENDPROC
4169: 
4170:     * ============================================================
4171:     * FormParaBO
4172:     * ============================================================
4173:     PROCEDURE FormParaBO()
4174:         LOCAL loc_oPD, loc_oPOp, loc_oPEst, loc_oPCom, loc_oPDoc, loc_oPDiv
4175:         TRY
4176:             loc_oPD   = THIS.pgf_4c_Paginas.Page2
4177:             loc_oPOp  = loc_oPD.pgf_4c_PagDados.Page1
4178:             loc_oPEst = loc_oPD.pgf_4c_PagDados.Page2
4179:             loc_oPCom = loc_oPD.pgf_4c_PagDados.Page3
4180:             loc_oPDoc = loc_oPD.pgf_4c_PagDados.Page4
4181:             loc_oPDiv = loc_oPD.pgf_4c_PagDados.Page5
4182:             * Header
4183:             THIS.this_oBusinessObject.this_cDopps  = ALLTRIM(loc_oPD.txt_4c_Desc.Value)
4184:             THIS.this_oBusinessObject.this_nNdopps = ALLTRIM(STR(loc_oPD.txt_4c_Nope.Value))
4185:             THIS.this_oBusinessObject.this_nOrdes  = ALLTRIM(STR(loc_oPD.txt_4c_Ordem.Value))
4186:             * Aba Operacao
4187:             THIS.this_oBusinessObject.this_nImagems    = loc_oPOp.obj_4c_Op_imagem.Value
4188:             THIS.this_oBusinessObject.this_nBoletos    = loc_oPOp.obj_4c_Op_boleto.Value
4189:             THIS.this_oBusinessObject.this_nDocus      = loc_oPOp.obj_4c_Fwoption8.Value
4190:             THIS.this_oBusinessObject.this_nBolops     = loc_oPOp.obj_4c_Fwoption5.Value
4191:             THIS.this_oBusinessObject.this_nBolcomps   = loc_oPOp.obj_4c_Opt_compo.Value
4192:             THIS.this_oBusinessObject.this_nMenus      = loc_oPOp.obj_4c_Opt_Menu.Value
4193:             THIS.this_oBusinessObject.this_nAutos      = loc_oPOp.obj_4c_ObjAutos.Value
4194:             THIS.this_oBusinessObject.this_cHists      = ALLTRIM(loc_oPOp.txt_4c_Hists.Value)
4195:             THIS.this_oBusinessObject.this_nChktemsubn = loc_oPOp.obj_4c_Op_subn.Value
4196:             THIS.this_oBusinessObject.this_cNivels     = ALLTRIM(loc_oPOp.txt_4c_Nivel.Value)
4197:             THIS.this_oBusinessObject.this_cTnivels    = ALLTRIM(loc_oPOp.txt_4c_Titulo.Value)
4198:             THIS.this_oBusinessObject.this_cArtigos    = ALLTRIM(loc_oPOp.txt_4c_Artigo.Value)
4199:             THIS.this_oBusinessObject.this_nBxautos    = loc_oPOp.obj_4c_Op_BxAuto.Value
4200:             THIS.this_oBusinessObject.this_nExclsubns  = loc_oPOp.obj_4c_Fwoption2.Value
4201:             THIS.this_oBusinessObject.this_nChktemsubn = loc_oPOp.obj_4c_Fwoption1.Value
4202:             THIS.this_oBusinessObject.this_nSeqs       = loc_oPOp.obj_4c_GetSequencia.Value
4203:             THIS.this_oBusinessObject.this_nAgregas    = loc_oPOp.obj_4c_Op_agregas.Value
4204:             THIS.this_oBusinessObject.this_nChkfases   = loc_oPOp.obj_4c_Op_repete.Value
4205:             THIS.this_oBusinessObject.this_nCestoqs    = loc_oPOp.obj_4c_Op_Saldo.Value
4206:             THIS.this_oBusinessObject.this_nInibmens   = loc_oPOp.obj_4c_Op_inib.Value
4207:             THIS.this_oBusinessObject.this_nMenfalhas  = loc_oPOp.obj_4c_ObjMenFalha.Value
4208:             THIS.this_oBusinessObject.this_nBuscaenvs  = loc_oPOp.obj_4c_ObjBusEnv.Value
4209:             THIS.this_oBusinessObject.this_nBtnrets    = loc_oPOp.obj_4c_ObjRetrabs.Value
4210:             THIS.this_oBusinessObject.this_nBtnincs    = loc_oPOp.obj_4c_Objnaoconform.Value
4211:             THIS.this_oBusinessObject.this_nBtnpags    = loc_oPOp.obj_4c_Objpagamento.Value
4212:             THIS.this_oBusinessObject.this_nEtiqenvs   = loc_oPOp.obj_4c_Fwoption3.Value
4213:             THIS.this_oBusinessObject.this_nApontas    = loc_oPOp.obj_4c_Fwoption4.Value

*-- Linhas 4284 a 4361:
4284:             THIS.this_oBusinessObject.this_nMatprncdif = loc_oPCom.obj_4c_OptMatPrncDif.Value
4285:             THIS.this_oBusinessObject.this_nChkqtdps   = loc_oPCom.obj_4c_ObjChkQP.Value
4286:             * Aba Documento
4287:             THIS.this_oBusinessObject.this_nDckcabec   = loc_oPDoc.obj_4c_Optiongroup1.Value
4288:             THIS.this_oBusinessObject.this_nDckitens   = loc_oPDoc.obj_4c_Optiongroup2.Value
4289:             THIS.this_oBusinessObject.this_nDckresu    = loc_oPDoc.obj_4c_Optiongroup3.Value
4290:             * Aba Diversas
4291:             THIS.this_oBusinessObject.this_nCasqtds    = loc_oPDiv.obj_4c_Spn_NCqtd.Value
4292:             THIS.this_oBusinessObject.this_nObspads    = ALLTRIM(loc_oPDiv.txt_4c_Obspads.Value)
4293:             THIS.this_oBusinessObject.this_nObsinis    = ALLTRIM(loc_oPDiv.txt_4c_ObsInis.Value)
4294:             THIS.this_oBusinessObject.this_nObsfins    = ALLTRIM(loc_oPDiv.txt_4c_ObsFins.Value)
4295:             THIS.this_oBusinessObject.this_nChkunis    = loc_oPDiv.obj_4c_Fwoption1.Value
4296:             THIS.this_oBusinessObject.this_nEnvelopes  = loc_oPDiv.obj_4c_Fwoption2.Value
4297:             THIS.this_oBusinessObject.this_nAcenvs     = loc_oPDiv.obj_4c_Fwoption3.Value
4298:             THIS.this_oBusinessObject.this_nCtrlotes   = loc_oPDiv.obj_4c_Fwoption4.Value
4299:             THIS.this_oBusinessObject.this_cCodtgops   = ALLTRIM(loc_oPDiv.txt_4c_TpOp.Value)
4300:             THIS.this_oBusinessObject.this_cGrufins    = ALLTRIM(loc_oPDiv.txt_4c_GruFin.Value)
4301:             THIS.this_oBusinessObject.this_cDopcs      = ALLTRIM(loc_oPDiv.txt_4c_OpConta.Value)
4302:             THIS.this_oBusinessObject.this_cGruccus    = ALLTRIM(loc_oPDiv.txt_4c__gruccus.Value)
4303:             THIS.this_oBusinessObject.this_cContaccus  = ALLTRIM(loc_oPDiv.txt_4c__contaccus.Value)
4304:             THIS.this_oBusinessObject.this_cDopsemis   = ALLTRIM(loc_oPDiv.txt_4c_Semi.Value)
4305:             THIS.this_oBusinessObject.this_nChkpesotot = loc_oPDiv.obj_4c_Fwoption5.Value
4306:             THIS.this_oBusinessObject.this_nTpsenexc   = loc_oPDiv.obj_4c_Optiongroup1.Value
4307:             THIS.this_oBusinessObject.this_nPccs       = IIF(loc_oPDiv.chk_4c_Chk_Pcc.Value = 1, 1, 0)
4308:             THIS.this_oBusinessObject.this_nPesmatps   = IIF(loc_oPDiv.chk_4c_Chk_imp.Value = 1, 1, 0)
4309:             THIS.this_oBusinessObject.this_nInibAlts   = IIF(loc_oPDiv.chk_4c_Chk_InibAlt.Value = 1, 1, 0)
4310:             THIS.this_oBusinessObject.this_nChkctdes   = IIF(loc_oPDiv.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
4311:             THIS.this_oBusinessObject.this_nChksenexc  = IIF(loc_oPDiv.chk_4c_Fwcheckbox8.Value = 1, 1, 0)
4312:             THIS.this_oBusinessObject.this_nChkoplts   = IIF(loc_oPDiv.chk_4c_ChkOpLote.Value = 1, 1, 0)
4313:         CATCH TO loException
4314:             MostrarErro(loException, "FormMPD.FormParaBO")
4315:         ENDTRY
4316:     ENDPROC
4317: 
4318:     * ============================================================
4319:     * BOParaForm
4320:     * ============================================================
4321:     PROCEDURE BOParaForm()
4322:         LOCAL loc_oPD, loc_oPOp, loc_oPEst, loc_oPCom, loc_oPDoc, loc_oPDiv, loc_oBO
4323:         TRY
4324:             loc_oBO   = THIS.this_oBusinessObject
4325:             loc_oPD   = THIS.pgf_4c_Paginas.Page2
4326:             loc_oPOp  = loc_oPD.pgf_4c_PagDados.Page1
4327:             loc_oPEst = loc_oPD.pgf_4c_PagDados.Page2
4328:             loc_oPCom = loc_oPD.pgf_4c_PagDados.Page3
4329:             loc_oPDoc = loc_oPD.pgf_4c_PagDados.Page4
4330:             loc_oPDiv = loc_oPD.pgf_4c_PagDados.Page5
4331:             * Header
4332:             loc_oPD.txt_4c_Desc.Value  = loc_oBO.this_cDopps
4333:             loc_oPD.txt_4c_Nope.Value  = loc_oBO.this_nNdopps
4334:             loc_oPD.txt_4c_Ordem.Value = loc_oBO.this_nOrdes
4335:             * Aba Operacao
4336:             loc_oPOp.obj_4c_Op_imagem.Value    = IIF(loc_oBO.this_nImagems > 0, loc_oBO.this_nImagems, 2)
4337:             loc_oPOp.obj_4c_Op_boleto.Value    = IIF(loc_oBO.this_nBoletos > 0, loc_oBO.this_nBoletos, 1)
4338:             loc_oPOp.obj_4c_Fwoption8.Value    = IIF(loc_oBO.this_nDocus > 0, loc_oBO.this_nDocus, 2)
4339:             loc_oPOp.obj_4c_Fwoption5.Value    = IIF(loc_oBO.this_nBolops > 0, loc_oBO.this_nBolops, 2)
4340:             loc_oPOp.obj_4c_Opt_compo.Value    = IIF(loc_oBO.this_nBolcomps > 0, loc_oBO.this_nBolcomps, 2)
4341:             loc_oPOp.obj_4c_Opt_Menu.Value     = IIF(loc_oBO.this_nMenus > 0, loc_oBO.this_nMenus, 2)
4342:             loc_oPOp.obj_4c_ObjAutos.Value     = IIF(loc_oBO.this_nAutos > 0, loc_oBO.this_nAutos, 1)
4343:             loc_oPOp.txt_4c_Hists.Value        = loc_oBO.this_cHists
4344:             loc_oPOp.obj_4c_Op_subn.Value      = IIF(loc_oBO.this_nChktemsubn > 0, loc_oBO.this_nChktemsubn, 2)
4345:             loc_oPOp.txt_4c_Nivel.Value        = loc_oBO.this_cNivels
4346:             loc_oPOp.txt_4c_Titulo.Value       = loc_oBO.this_cTnivels
4347:             loc_oPOp.txt_4c_Artigo.Value       = loc_oBO.this_cArtigos
4348:             loc_oPOp.obj_4c_Op_BxAuto.Value    = IIF(loc_oBO.this_nBxautos > 0, loc_oBO.this_nBxautos, 2)
4349:             loc_oPOp.obj_4c_Fwoption2.Value    = IIF(loc_oBO.this_nExclsubns > 0, loc_oBO.this_nExclsubns, 2)
4350:             loc_oPOp.obj_4c_Fwoption1.Value    = IIF(loc_oBO.this_nChktemsubn > 0, loc_oBO.this_nChktemsubn, 2)
4351:             loc_oPOp.obj_4c_GetSequencia.Value = IIF(loc_oBO.this_nSeqs > 0, loc_oBO.this_nSeqs, 2)
4352:             loc_oPOp.obj_4c_Op_agregas.Value   = IIF(loc_oBO.this_nAgregas > 0, loc_oBO.this_nAgregas, 2)
4353:             loc_oPOp.obj_4c_Op_repete.Value    = IIF(loc_oBO.this_nChkfases > 0, loc_oBO.this_nChkfases, 1)
4354:             loc_oPOp.obj_4c_Op_Saldo.Value     = IIF(loc_oBO.this_nCestoqs > 0, loc_oBO.this_nCestoqs, 2)
4355:             loc_oPOp.obj_4c_Op_inib.Value      = IIF(loc_oBO.this_nInibmens > 0, loc_oBO.this_nInibmens, 2)
4356:             loc_oPOp.obj_4c_ObjMenFalha.Value  = IIF(loc_oBO.this_nMenfalhas > 0, loc_oBO.this_nMenfalhas, 2)
4357:             loc_oPOp.obj_4c_ObjBusEnv.Value    = IIF(loc_oBO.this_nBuscaenvs > 0, loc_oBO.this_nBuscaenvs, 2)
4358:             loc_oPOp.obj_4c_ObjRetrabs.Value   = IIF(loc_oBO.this_nBtnrets > 0, loc_oBO.this_nBtnrets, 2)
4359:             loc_oPOp.obj_4c_Objnaoconform.Value = IIF(loc_oBO.this_nBtnincs > 0, loc_oBO.this_nBtnincs, 2)
4360:             loc_oPOp.obj_4c_Objpagamento.Value = IIF(loc_oBO.this_nBtnpags > 0, loc_oBO.this_nBtnpags, 2)
4361:             loc_oPOp.obj_4c_Fwoption3.Value    = IIF(loc_oBO.this_nEtiqenvs > 0, loc_oBO.this_nEtiqenvs, 2)

*-- Linhas 4439 a 4532:
4439:             loc_oPCom.obj_4c_OptMatPrncDif.Value = IIF(loc_oBO.this_nMatprncdif > 0, loc_oBO.this_nMatprncdif, 2)
4440:             loc_oPCom.obj_4c_ObjChkQP.Value      = IIF(loc_oBO.this_nChkqtdps > 0, loc_oBO.this_nChkqtdps, 1)
4441:             * Aba Documento
4442:             loc_oPDoc.obj_4c_Optiongroup1.Value  = IIF(loc_oBO.this_nDckcabec > 0, loc_oBO.this_nDckcabec, 2)
4443:             loc_oPDoc.obj_4c_Optiongroup2.Value  = IIF(loc_oBO.this_nDckitens > 0, loc_oBO.this_nDckitens, 1)
4444:             loc_oPDoc.obj_4c_Optiongroup3.Value  = IIF(loc_oBO.this_nDckresu > 0, loc_oBO.this_nDckresu, 2)
4445:             * Aba Diversas
4446:             loc_oPDiv.obj_4c_Spn_NCqtd.Value    = loc_oBO.this_nCasqtds
4447:             loc_oPDiv.txt_4c_Obspads.Value       = loc_oBO.this_nObspads
4448:             loc_oPDiv.txt_4c_ObsInis.Value       = loc_oBO.this_nObsinis
4449:             loc_oPDiv.txt_4c_ObsFins.Value       = loc_oBO.this_nObsfins
4450:             loc_oPDiv.obj_4c_Fwoption1.Value     = IIF(loc_oBO.this_nChkunis > 0, loc_oBO.this_nChkunis, 2)
4451:             loc_oPDiv.obj_4c_Fwoption2.Value     = IIF(loc_oBO.this_nEnvelopes > 0, loc_oBO.this_nEnvelopes, 2)
4452:             loc_oPDiv.obj_4c_Fwoption3.Value     = IIF(loc_oBO.this_nAcenvs > 0, loc_oBO.this_nAcenvs, 2)
4453:             loc_oPDiv.obj_4c_Fwoption4.Value     = IIF(loc_oBO.this_nCtrlotes > 0, loc_oBO.this_nCtrlotes, 2)
4454:             loc_oPDiv.txt_4c_TpOp.Value          = loc_oBO.this_cCodtgops
4455:             loc_oPDiv.txt_4c_GruFin.Value        = loc_oBO.this_cGrufins
4456:             loc_oPDiv.txt_4c_OpConta.Value       = loc_oBO.this_cDopcs
4457:             loc_oPDiv.txt_4c__gruccus.Value      = loc_oBO.this_cGruccus
4458:             loc_oPDiv.txt_4c__contaccus.Value    = loc_oBO.this_cContaccus
4459:             loc_oPDiv.txt_4c_Semi.Value          = loc_oBO.this_cDopsemis
4460:             loc_oPDiv.obj_4c_Fwoption5.Value     = IIF(loc_oBO.this_nChkpesotot > 0, loc_oBO.this_nChkpesotot, 1)
4461:             loc_oPDiv.obj_4c_Optiongroup1.Value  = IIF(loc_oBO.this_nTpsenexc > 0, loc_oBO.this_nTpsenexc, 1)
4462:             loc_oPDiv.chk_4c_Chk_Pcc.Value      = loc_oBO.this_nPccs
4463:             loc_oPDiv.chk_4c_Chk_imp.Value       = loc_oBO.this_nPesmatps
4464:             loc_oPDiv.chk_4c_Chk_InibAlt.Value  = loc_oBO.this_nInibAlts
4465:             loc_oPDiv.chk_4c_Fwcheckbox1.Value   = loc_oBO.this_nChkctdes
4466:             loc_oPDiv.chk_4c_Fwcheckbox8.Value   = loc_oBO.this_nChksenexc
4467:             loc_oPDiv.chk_4c_ChkOpLote.Value     = loc_oBO.this_nChkoplts
4468:         CATCH TO loException
4469:             MostrarErro(loException, "FormMPD.BOParaForm")
4470:         ENDTRY
4471:     ENDPROC
4472: 
4473:     * ============================================================
4474:     * HabilitarCampos
4475:     * ============================================================
4476:     PROCEDURE HabilitarCampos(par_lHabilitar)
4477:         LOCAL loc_oPD
4478:         TRY
4479:             loc_oPD = THIS.pgf_4c_Paginas.Page2
4480:             loc_oPD.txt_4c_Desc.Enabled                      = par_lHabilitar
4481:             loc_oPD.txt_4c_Nope.Enabled                      = par_lHabilitar
4482:             loc_oPD.txt_4c_Ordem.Enabled                     = par_lHabilitar
4483:             loc_oPD.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled  = par_lHabilitar
4484:         CATCH TO loException
4485:             MostrarErro(loException, "FormMPD.HabilitarCampos")
4486:         ENDTRY
4487:     ENDPROC
4488: 
4489:     * ============================================================
4490:     * LimparCampos
4491:     * ============================================================
4492:     PROCEDURE LimparCampos()
4493:         LOCAL loc_oPD, loc_oPOp, loc_oPEst, loc_oPCom, loc_oPDoc, loc_oPDiv
4494:         TRY
4495:             loc_oPD   = THIS.pgf_4c_Paginas.Page2
4496:             loc_oPOp  = loc_oPD.pgf_4c_PagDados.Page1
4497:             loc_oPEst = loc_oPD.pgf_4c_PagDados.Page2
4498:             loc_oPCom = loc_oPD.pgf_4c_PagDados.Page3
4499:             loc_oPDoc = loc_oPD.pgf_4c_PagDados.Page4
4500:             loc_oPDiv = loc_oPD.pgf_4c_PagDados.Page5
4501:             loc_oPD.txt_4c_Desc.Value  = ""
4502:             loc_oPD.txt_4c_Nope.Value  = 0
4503:             loc_oPD.txt_4c_Ordem.Value = 0
4504:             loc_oPOp.txt_4c_Hists.Value   = ""
4505:             loc_oPOp.txt_4c_Nivel.Value   = ""
4506:             loc_oPOp.txt_4c_Titulo.Value  = ""
4507:             loc_oPOp.txt_4c_Artigo.Value  = ""
4508:             loc_oPOp.txt_4c_ArqIcone.Value = ""
4509:             loc_oPOp.txt_4c__Empenho.Value = ""
4510:             loc_oPOp.txt_4c_EmpLanc.Value  = ""
4511:             loc_oPEst.txt_4c_GrupoOrig.Value = ""
4512:             loc_oPEst.txt_4c_Dgrupoo.Value = ""
4513:             loc_oPEst.txt_4c_ContaOrig.Value = ""
4514:             loc_oPEst.txt_4c_Dcontao.Value = ""
4515:             loc_oPEst.txt_4c_GrupoDest.Value = ""
4516:             loc_oPEst.txt_4c_Dgrupod.Value = ""
4517:             loc_oPEst.txt_4c_ContaDest.Value = ""
4518:             loc_oPEst.txt_4c_Dcontad.Value = ""
4519:             loc_oPEst.txt_4c_GrupoVend.Value = ""
4520:             loc_oPEst.txt_4c_Dgrupov.Value = ""
4521:             loc_oPEst.txt_4c_Mascos.Value = ""
4522:             loc_oPEst.txt_4c_Mascds.Value = ""
4523:             loc_oPCom.txt_4c_TpPadrao.Value = ""
4524:             loc_oPCom.txt_4c_Retalho.Value = ""
4525:             loc_oPCom.txt_4c_GrupoPcc.Value = ""
4526:             loc_oPCom.txt_4c__produto.Value = ""
4527:             loc_oPCom.txt_4c_Tfalhas.Value  = ""
4528:             loc_oPCom.txt_4c_Difp.Value = 0
4529:             loc_oPCom.txt_4c__limqtd.Value = 0
4530:             loc_oPCom.txt_4c_DifPeso.Value = 0
4531:             loc_oPDiv.txt_4c_Obspads.Value  = 0
4532:             loc_oPDiv.txt_4c_ObsInis.Value = 0

*-- Linhas 4548 a 5303:
4548:     * ============================================================
4549:     * LOOKUP HANDLERS - Operacao
4550:     * ============================================================
4551:     PROCEDURE NivelKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4552:         IF par_nKeyCode = 116
4553:             THIS.AbrirLookupNivel()
4554:         ENDIF
4555:     ENDPROC
4556: 
4557:     PROCEDURE AbrirLookupNivel()
4558:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4559:         TRY
4560:             loc_cSQL = "SELECT Dopps, Ndopps FROM SigCdOpd ORDER BY Dopps"
4561:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nivel")
4562:             IF loc_nResult >= 0
4563:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4564:                 loc_oFrm.DefinirCursor("cursor_4c_Nivel", "Dopps", "Ndopps", "SubN" + CHR(237) + "vel")
4565:                 loc_oFrm.Mostrar()
4566:                 IF loc_oFrm.this_lSelecionou
4567:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4568:                     loc_oPg.txt_4c_Nivel.Value = loc_oFrm.cCodigoSelecionado
4569:                 ENDIF
4570:                 IF USED("cursor_4c_Nivel")
4571:                     USE IN cursor_4c_Nivel
4572:                 ENDIF
4573:             ELSE
4574:                 MsgErro("Erro ao buscar n" + CHR(237) + "veis.", "Erro")
4575:             ENDIF
4576:         CATCH TO loc_oErro
4577:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupNivel")
4578:         ENDTRY
4579:     ENDPROC
4580: 
4581:     PROCEDURE EmpenhoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4582:         IF par_nKeyCode = 116
4583:             THIS.AbrirLookupEmpenho()
4584:         ENDIF
4585:     ENDPROC
4586: 
4587:     PROCEDURE AbrirLookupEmpenho()
4588:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4589:         TRY
4590:             loc_cSQL = "SELECT Dopps, hists FROM SigCdOpd ORDER BY Dopps"
4591:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empenho")
4592:             IF loc_nResult >= 0
4593:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4594:                 loc_oFrm.DefinirCursor("cursor_4c_Empenho", "Dopps", "hists", "Opera" + CHR(231) + CHR(227) + "o Empenho")
4595:                 loc_oFrm.Mostrar()
4596:                 IF loc_oFrm.this_lSelecionou
4597:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4598:                     loc_oPg.txt_4c__Empenho.Value = loc_oFrm.cCodigoSelecionado
4599:                 ENDIF
4600:                 IF USED("cursor_4c_Empenho")
4601:                     USE IN cursor_4c_Empenho
4602:                 ENDIF
4603:             ELSE
4604:                 MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
4605:             ENDIF
4606:         CATCH TO loc_oErro
4607:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupEmpenho")
4608:         ENDTRY
4609:     ENDPROC
4610: 
4611:     PROCEDURE EmpLancKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4612:         IF par_nKeyCode = 116
4613:             THIS.AbrirLookupEmpLanc()
4614:         ENDIF
4615:     ENDPROC
4616: 
4617:     PROCEDURE AbrirLookupEmpLanc()
4618:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4619:         TRY
4620:             loc_cSQL = "SELECT cemps, razas FROM SigCdEmp ORDER BY cemps"
4621:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpLanc")
4622:             IF loc_nResult >= 0
4623:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4624:                 loc_oFrm.DefinirCursor("cursor_4c_EmpLanc", "cemps", "razas", "Empresa")
4625:                 loc_oFrm.Mostrar()
4626:                 IF loc_oFrm.this_lSelecionou
4627:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4628:                     loc_oPg.txt_4c_EmpLanc.Value = loc_oFrm.cCodigoSelecionado
4629:                 ENDIF
4630:                 IF USED("cursor_4c_EmpLanc")
4631:                     USE IN cursor_4c_EmpLanc
4632:                 ENDIF
4633:             ELSE
4634:                 MsgErro("Erro ao buscar empresas.", "Erro")
4635:             ENDIF
4636:         CATCH TO loc_oErro
4637:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupEmpLanc")
4638:         ENDTRY
4639:     ENDPROC
4640: 
4641:     * ============================================================
4642:     * LOOKUP HANDLERS - Estoque
4643:     * ============================================================
4644:     PROCEDURE GrupoOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4645:         IF par_nKeyCode = 116
4646:             THIS.AbrirLookupGrupoOrig()
4647:         ENDIF
4648:     ENDPROC
4649: 
4650:     PROCEDURE AbrirLookupGrupoOrig()
4651:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4652:         TRY
4653:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
4654:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoO")
4655:             IF loc_nResult >= 0
4656:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4657:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoO", "codigos", "descrs", "Grupo Orig.")
4658:                 loc_oFrm.Mostrar()
4659:                 IF loc_oFrm.this_lSelecionou
4660:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4661:                     loc_oPg.txt_4c_GrupoOrig.Value = loc_oFrm.cCodigoSelecionado
4662:                     loc_oPg.txt_4c_Dgrupoo.Value   = loc_oFrm.cDescricaoSelecionada
4663:                 ENDIF
4664:                 IF USED("cursor_4c_GrupoO")
4665:                     USE IN cursor_4c_GrupoO
4666:                 ENDIF
4667:             ELSE
4668:                 MsgErro("Erro ao buscar grupos.", "Erro")
4669:             ENDIF
4670:         CATCH TO loc_oErro
4671:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoOrig")
4672:         ENDTRY
4673:     ENDPROC
4674: 
4675:     PROCEDURE ContaOrigKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4676:         IF par_nKeyCode = 116
4677:             THIS.AbrirLookupContaOrig()
4678:         ENDIF
4679:     ENDPROC
4680: 
4681:     PROCEDURE AbrirLookupContaOrig()
4682:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4683:         TRY
4684:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
4685:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaO")
4686:             IF loc_nResult >= 0
4687:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4688:                 loc_oFrm.DefinirCursor("cursor_4c_ContaO", "codigos", "descrs", "Conta Orig.")
4689:                 loc_oFrm.Mostrar()
4690:                 IF loc_oFrm.this_lSelecionou
4691:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4692:                     loc_oPg.txt_4c_ContaOrig.Value = loc_oFrm.cCodigoSelecionado
4693:                     loc_oPg.txt_4c_Dcontao.Value   = loc_oFrm.cDescricaoSelecionada
4694:                 ENDIF
4695:                 IF USED("cursor_4c_ContaO")
4696:                     USE IN cursor_4c_ContaO
4697:                 ENDIF
4698:             ELSE
4699:                 MsgErro("Erro ao buscar contas.", "Erro")
4700:             ENDIF
4701:         CATCH TO loc_oErro
4702:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupContaOrig")
4703:         ENDTRY
4704:     ENDPROC
4705: 
4706:     PROCEDURE GrupoDestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4707:         IF par_nKeyCode = 116
4708:             THIS.AbrirLookupGrupoDest()
4709:         ENDIF
4710:     ENDPROC
4711: 
4712:     PROCEDURE AbrirLookupGrupoDest()
4713:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4714:         TRY
4715:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
4716:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoD")
4717:             IF loc_nResult >= 0
4718:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4719:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoD", "codigos", "descrs", "Grupo Dest.")
4720:                 loc_oFrm.Mostrar()
4721:                 IF loc_oFrm.this_lSelecionou
4722:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4723:                     loc_oPg.txt_4c_GrupoDest.Value = loc_oFrm.cCodigoSelecionado
4724:                     loc_oPg.txt_4c_Dgrupod.Value   = loc_oFrm.cDescricaoSelecionada
4725:                 ENDIF
4726:                 IF USED("cursor_4c_GrupoD")
4727:                     USE IN cursor_4c_GrupoD
4728:                 ENDIF
4729:             ELSE
4730:                 MsgErro("Erro ao buscar grupos.", "Erro")
4731:             ENDIF
4732:         CATCH TO loc_oErro
4733:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoDest")
4734:         ENDTRY
4735:     ENDPROC
4736: 
4737:     PROCEDURE ContaDestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4738:         IF par_nKeyCode = 116
4739:             THIS.AbrirLookupContaDest()
4740:         ENDIF
4741:     ENDPROC
4742: 
4743:     PROCEDURE AbrirLookupContaDest()
4744:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4745:         TRY
4746:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
4747:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaD")
4748:             IF loc_nResult >= 0
4749:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4750:                 loc_oFrm.DefinirCursor("cursor_4c_ContaD", "codigos", "descrs", "Conta Dest.")
4751:                 loc_oFrm.Mostrar()
4752:                 IF loc_oFrm.this_lSelecionou
4753:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4754:                     loc_oPg.txt_4c_ContaDest.Value = loc_oFrm.cCodigoSelecionado
4755:                     loc_oPg.txt_4c_Dcontad.Value   = loc_oFrm.cDescricaoSelecionada
4756:                 ENDIF
4757:                 IF USED("cursor_4c_ContaD")
4758:                     USE IN cursor_4c_ContaD
4759:                 ENDIF
4760:             ELSE
4761:                 MsgErro("Erro ao buscar contas.", "Erro")
4762:             ENDIF
4763:         CATCH TO loc_oErro
4764:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupContaDest")
4765:         ENDTRY
4766:     ENDPROC
4767: 
4768:     PROCEDURE GrupoVendKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4769:         IF par_nKeyCode = 116
4770:             THIS.AbrirLookupGrupoVend()
4771:         ENDIF
4772:     ENDPROC
4773: 
4774:     PROCEDURE AbrirLookupGrupoVend()
4775:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4776:         TRY
4777:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
4778:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoV")
4779:             IF loc_nResult >= 0
4780:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4781:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoV", "codigos", "descrs", "Grupo Venda")
4782:                 loc_oFrm.Mostrar()
4783:                 IF loc_oFrm.this_lSelecionou
4784:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4785:                     loc_oPg.txt_4c_GrupoVend.Value = loc_oFrm.cCodigoSelecionado
4786:                     loc_oPg.txt_4c_Dgrupov.Value   = loc_oFrm.cDescricaoSelecionada
4787:                 ENDIF
4788:                 IF USED("cursor_4c_GrupoV")
4789:                     USE IN cursor_4c_GrupoV
4790:                 ENDIF
4791:             ELSE
4792:                 MsgErro("Erro ao buscar grupos.", "Erro")
4793:             ENDIF
4794:         CATCH TO loc_oErro
4795:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoVend")
4796:         ENDTRY
4797:     ENDPROC
4798: 
4799:     * ============================================================
4800:     * COMPORTAMENTO INTERATIVO - Estoque
4801:     * ============================================================
4802:     PROCEDURE OpOrigemChange()
4803:         LOCAL loc_oPg, loc_lSim
4804:         TRY
4805:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4806:             loc_lSim = (loc_oPg.obj_4c_Op_origem.Value = 1)
4807:             loc_oPg.txt_4c_GrupoOrig.Enabled   = loc_lSim
4808:             loc_oPg.txt_4c_Dgrupoo.Enabled     = loc_lSim
4809:             loc_oPg.txt_4c_ContaOrig.Enabled   = loc_lSim
4810:             loc_oPg.txt_4c_Dcontao.Enabled     = loc_lSim
4811:             loc_oPg.chk_4c_Chk_Grupoo.Enabled  = loc_lSim
4812:             loc_oPg.chk_4c_Chk_Contao.Enabled  = loc_lSim
4813:             loc_oPg.obj_4c_Op_ConOSub.Enabled  = loc_lSim
4814:         CATCH TO loc_oErro
4815:             MsgErro(loc_oErro.Message, "FormMPD.OpOrigemChange")
4816:         ENDTRY
4817:     ENDPROC
4818: 
4819:     PROCEDURE OpDestinoChange()
4820:         LOCAL loc_oPg, loc_lSim
4821:         TRY
4822:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4823:             loc_lSim = (loc_oPg.obj_4c_Op_destino.Value = 1)
4824:             loc_oPg.obj_4c_Get_Repete.Enabled  = loc_lSim
4825:             loc_oPg.txt_4c_GrupoDest.Enabled   = loc_lSim
4826:             loc_oPg.txt_4c_Dgrupod.Enabled     = loc_lSim
4827:             loc_oPg.txt_4c_ContaDest.Enabled   = loc_lSim
4828:             loc_oPg.txt_4c_Dcontad.Enabled     = loc_lSim
4829:             loc_oPg.chk_4c_Chk_Grupod.Enabled  = loc_lSim
4830:             loc_oPg.chk_4c_Chk_Contad.Enabled  = loc_lSim
4831:             loc_oPg.obj_4c_Op_ConDSub.Enabled  = loc_lSim
4832:         CATCH TO loc_oErro
4833:             MsgErro(loc_oErro.Message, "FormMPD.OpDestinoChange")
4834:         ENDTRY
4835:     ENDPROC
4836: 
4837:     PROCEDURE OpVendeChange()
4838:         LOCAL loc_oPg, loc_lSim
4839:         TRY
4840:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4841:             loc_lSim = (loc_oPg.obj_4c_Op_vende.Value = 1)
4842:             loc_oPg.txt_4c_GrupoVend.Enabled  = loc_lSim
4843:             loc_oPg.txt_4c_Dgrupov.Enabled    = loc_lSim
4844:             loc_oPg.chk_4c_Chk_Grupov.Enabled = loc_lSim
4845:         CATCH TO loc_oErro
4846:             MsgErro(loc_oErro.Message, "FormMPD.OpVendeChange")
4847:         ENDTRY
4848:     ENDPROC
4849: 
4850:     PROCEDURE OpEstOrigChange()
4851:         LOCAL loc_oPg, loc_nOrig, loc_nDest
4852:         TRY
4853:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4854:             loc_nOrig = loc_oPg.obj_4c_Op_EstOrig.Value
4855:             loc_nDest = loc_oPg.obj_4c_Op_EstDest.Value
4856:             IF loc_nOrig <> 3 AND loc_nOrig = loc_nDest
4857:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o de estoque conflitante.")
4858:                 loc_oPg.obj_4c_Op_EstOrig.Value = 3
4859:             ENDIF
4860:         CATCH TO loc_oErro
4861:             MsgErro(loc_oErro.Message, "FormMPD.OpEstOrigChange")
4862:         ENDTRY
4863:     ENDPROC
4864: 
4865:     PROCEDURE OpEstDestChange()
4866:         LOCAL loc_oPg, loc_nOrig, loc_nDest
4867:         TRY
4868:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4869:             loc_nOrig = loc_oPg.obj_4c_Op_EstOrig.Value
4870:             loc_nDest = loc_oPg.obj_4c_Op_EstDest.Value
4871:             IF loc_nDest <> 3 AND loc_nDest = loc_nOrig
4872:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o de estoque conflitante.")
4873:                 loc_oPg.obj_4c_Op_EstDest.Value = 3
4874:             ENDIF
4875:         CATCH TO loc_oErro
4876:             MsgErro(loc_oErro.Message, "FormMPD.OpEstDestChange")
4877:         ENDTRY
4878:     ENDPROC
4879: 
4880:     * ============================================================
4881:     * LOOKUP HANDLERS - Componente
4882:     * ============================================================
4883:     PROCEDURE TpPadraoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4884:         IF par_nKeyCode = 116
4885:             THIS.AbrirLookupTpPadrao()
4886:         ENDIF
4887:     ENDPROC
4888: 
4889:     PROCEDURE AbrirLookupTpPadrao()
4890:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4891:         TRY
4892:             loc_cSQL = "SELECT Cods, Descrs FROM SigOpOpt ORDER BY Cods"
4893:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpPad")
4894:             IF loc_nResult >= 0
4895:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4896:                 loc_oFrm.DefinirCursor("cursor_4c_TpPad", "Cods", "Descrs", "Tipo Padr" + CHR(227) + "o")
4897:                 loc_oFrm.Mostrar()
4898:                 IF loc_oFrm.this_lSelecionou
4899:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
4900:                     loc_oPg.txt_4c_TpPadrao.Value = loc_oFrm.cCodigoSelecionado
4901:                 ENDIF
4902:                 IF USED("cursor_4c_TpPad")
4903:                     USE IN cursor_4c_TpPad
4904:                 ENDIF
4905:             ELSE
4906:                 MsgErro("Erro ao buscar tipos.", "Erro")
4907:             ENDIF
4908:         CATCH TO loc_oErro
4909:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupTpPadrao")
4910:         ENDTRY
4911:     ENDPROC
4912: 
4913:     PROCEDURE RetalhoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4914:         IF par_nKeyCode = 116
4915:             THIS.AbrirLookupRetalho()
4916:         ENDIF
4917:     ENDPROC
4918: 
4919:     PROCEDURE AbrirLookupRetalho()
4920:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4921:         TRY
4922:             loc_cSQL = "SELECT Cods, Descrs FROM SigOpOpt ORDER BY Cods"
4923:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Retalho")
4924:             IF loc_nResult >= 0
4925:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4926:                 loc_oFrm.DefinirCursor("cursor_4c_Retalho", "Cods", "Descrs", "Retalho")
4927:                 loc_oFrm.Mostrar()
4928:                 IF loc_oFrm.this_lSelecionou
4929:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
4930:                     loc_oPg.txt_4c_Retalho.Value = loc_oFrm.cCodigoSelecionado
4931:                 ENDIF
4932:                 IF USED("cursor_4c_Retalho")
4933:                     USE IN cursor_4c_Retalho
4934:                 ENDIF
4935:             ELSE
4936:                 MsgErro("Erro ao buscar retalhos.", "Erro")
4937:             ENDIF
4938:         CATCH TO loc_oErro
4939:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupRetalho")
4940:         ENDTRY
4941:     ENDPROC
4942: 
4943:     PROCEDURE GrupoPccKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4944:         IF par_nKeyCode = 116
4945:             THIS.AbrirLookupGrupoPcc()
4946:         ENDIF
4947:     ENDPROC
4948: 
4949:     PROCEDURE AbrirLookupGrupoPcc()
4950:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4951:         TRY
4952:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
4953:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoPcc")
4954:             IF loc_nResult >= 0
4955:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4956:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoPcc", "codigos", "descrs", "Fase PCC")
4957:                 loc_oFrm.Mostrar()
4958:                 IF loc_oFrm.this_lSelecionou
4959:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
4960:                     loc_oPg.txt_4c_GrupoPcc.Value = loc_oFrm.cCodigoSelecionado
4961:                 ENDIF
4962:                 IF USED("cursor_4c_GrupoPcc")
4963:                     USE IN cursor_4c_GrupoPcc
4964:                 ENDIF
4965:             ELSE
4966:                 MsgErro("Erro ao buscar grupos.", "Erro")
4967:             ENDIF
4968:         CATCH TO loc_oErro
4969:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGrupoPcc")
4970:         ENDTRY
4971:     ENDPROC
4972: 
4973:     PROCEDURE ProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4974:         IF par_nKeyCode = 116
4975:             THIS.AbrirLookupProduto()
4976:         ENDIF
4977:     ENDPROC
4978: 
4979:     PROCEDURE AbrirLookupProduto()
4980:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4981:         TRY
4982:             loc_cSQL = "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros"
4983:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")
4984:             IF loc_nResult >= 0
4985:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4986:                 loc_oFrm.DefinirCursor("cursor_4c_Produto", "cpros", "dpros", "Material Padr" + CHR(227) + "o")
4987:                 loc_oFrm.Mostrar()
4988:                 IF loc_oFrm.this_lSelecionou
4989:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
4990:                     loc_oPg.txt_4c__produto.Value = loc_oFrm.cCodigoSelecionado
4991:                 ENDIF
4992:                 IF USED("cursor_4c_Produto")
4993:                     USE IN cursor_4c_Produto
4994:                 ENDIF
4995:             ELSE
4996:                 MsgErro("Erro ao buscar produtos.", "Erro")
4997:             ENDIF
4998:         CATCH TO loc_oErro
4999:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupProduto")
5000:         ENDTRY
5001:     ENDPROC
5002: 
5003:     * ============================================================
5004:     * LOOKUP HANDLERS - Diversas
5005:     * ============================================================
5006:     PROCEDURE ObspadsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5007:         IF par_nKeyCode = 116
5008:             THIS.AbrirLookupObspads()
5009:         ENDIF
5010:     ENDPROC
5011: 
5012:     PROCEDURE AbrirLookupObspads()
5013:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5014:         TRY
5015:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs ORDER BY Codigos"
5016:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsPad")
5017:             IF loc_nResult >= 0
5018:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5019:                 loc_oFrm.DefinirCursor("cursor_4c_ObsPad", "Codigos", "Descrs", "Observa" + CHR(231) + CHR(227) + "o")
5020:                 loc_oFrm.Mostrar()
5021:                 IF loc_oFrm.this_lSelecionou
5022:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5023:                     loc_oPg.txt_4c_Obspads.Value = loc_oFrm.cCodigoSelecionado
5024:                 ENDIF
5025:                 IF USED("cursor_4c_ObsPad")
5026:                     USE IN cursor_4c_ObsPad
5027:                 ENDIF
5028:             ELSE
5029:                 MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
5030:             ENDIF
5031:         CATCH TO loc_oErro
5032:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupObspads")
5033:         ENDTRY
5034:     ENDPROC
5035: 
5036:     PROCEDURE ObsInisKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5037:         IF par_nKeyCode = 116
5038:             THIS.AbrirLookupObsInis()
5039:         ENDIF
5040:     ENDPROC
5041: 
5042:     PROCEDURE AbrirLookupObsInis()
5043:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5044:         TRY
5045:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs ORDER BY Codigos"
5046:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsIni")
5047:             IF loc_nResult >= 0
5048:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5049:                 loc_oFrm.DefinirCursor("cursor_4c_ObsIni", "Codigos", "Descrs", "Obs. Inicial")
5050:                 loc_oFrm.Mostrar()
5051:                 IF loc_oFrm.this_lSelecionou
5052:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5053:                     loc_oPg.txt_4c_ObsInis.Value = loc_oFrm.cCodigoSelecionado
5054:                 ENDIF
5055:                 IF USED("cursor_4c_ObsIni")
5056:                     USE IN cursor_4c_ObsIni
5057:                 ENDIF
5058:             ELSE
5059:                 MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
5060:             ENDIF
5061:         CATCH TO loc_oErro
5062:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupObsInis")
5063:         ENDTRY
5064:     ENDPROC
5065: 
5066:     PROCEDURE ObsFinsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5067:         IF par_nKeyCode = 116
5068:             THIS.AbrirLookupObsFins()
5069:         ENDIF
5070:     ENDPROC
5071: 
5072:     PROCEDURE AbrirLookupObsFins()
5073:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5074:         TRY
5075:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs ORDER BY Codigos"
5076:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsFin")
5077:             IF loc_nResult >= 0
5078:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5079:                 loc_oFrm.DefinirCursor("cursor_4c_ObsFin", "Codigos", "Descrs", "Obs. Final")
5080:                 loc_oFrm.Mostrar()
5081:                 IF loc_oFrm.this_lSelecionou
5082:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5083:                     loc_oPg.txt_4c_ObsFins.Value = loc_oFrm.cCodigoSelecionado
5084:                 ENDIF
5085:                 IF USED("cursor_4c_ObsFin")
5086:                     USE IN cursor_4c_ObsFin
5087:                 ENDIF
5088:             ELSE
5089:                 MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
5090:             ENDIF
5091:         CATCH TO loc_oErro
5092:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupObsFins")
5093:         ENDTRY
5094:     ENDPROC
5095: 
5096:     PROCEDURE GruFinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5097:         IF par_nKeyCode = 116
5098:             THIS.AbrirLookupGruFin()
5099:         ENDIF
5100:     ENDPROC
5101: 
5102:     PROCEDURE AbrirLookupGruFin()
5103:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5104:         TRY
5105:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5106:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruFin")
5107:             IF loc_nResult >= 0
5108:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5109:                 loc_oFrm.DefinirCursor("cursor_4c_GruFin", "codigos", "descrs", "Grupo Financeiro")
5110:                 loc_oFrm.Mostrar()
5111:                 IF loc_oFrm.this_lSelecionou
5112:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5113:                     loc_oPg.txt_4c_GruFin.Value  = loc_oFrm.cCodigoSelecionado
5114:                     loc_oPg.txt_4c_DGruFin.Value = loc_oFrm.cDescricaoSelecionada
5115:                 ENDIF
5116:                 IF USED("cursor_4c_GruFin")
5117:                     USE IN cursor_4c_GruFin
5118:                 ENDIF
5119:             ELSE
5120:                 MsgErro("Erro ao buscar grupos.", "Erro")
5121:             ENDIF
5122:         CATCH TO loc_oErro
5123:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGruFin")
5124:         ENDTRY
5125:     ENDPROC
5126: 
5127:     PROCEDURE OpContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5128:         IF par_nKeyCode = 116
5129:             THIS.AbrirLookupOpConta()
5130:         ENDIF
5131:     ENDPROC
5132: 
5133:     PROCEDURE AbrirLookupOpConta()
5134:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5135:         TRY
5136:             loc_cSQL = "SELECT Dopes, Ndopes FROM SigOpOpe ORDER BY Dopes"
5137:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpConta")
5138:             IF loc_nResult >= 0
5139:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5140:                 loc_oFrm.DefinirCursor("cursor_4c_OpConta", "Dopes", "Ndopes", "Opera" + CHR(231) + CHR(227) + "o Contas")
5141:                 loc_oFrm.Mostrar()
5142:                 IF loc_oFrm.this_lSelecionou
5143:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5144:                     loc_oPg.txt_4c_OpConta.Value = loc_oFrm.cCodigoSelecionado
5145:                 ENDIF
5146:                 IF USED("cursor_4c_OpConta")
5147:                     USE IN cursor_4c_OpConta
5148:                 ENDIF
5149:             ELSE
5150:                 MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
5151:             ENDIF
5152:         CATCH TO loc_oErro
5153:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupOpConta")
5154:         ENDTRY
5155:     ENDPROC
5156: 
5157:     PROCEDURE TpOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5158:         IF par_nKeyCode = 116
5159:             THIS.AbrirLookupTpOp()
5160:         ENDIF
5161:     ENDPROC
5162: 
5163:     PROCEDURE AbrirLookupTpOp()
5164:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5165:         TRY
5166:             loc_cSQL = "SELECT Codigos, Descrs FROM SigInTgo ORDER BY Codigos"
5167:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpOp")
5168:             IF loc_nResult >= 0
5169:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5170:                 loc_oFrm.DefinirCursor("cursor_4c_TpOp", "Codigos", "Descrs", "Tipo de Ordem")
5171:                 loc_oFrm.Mostrar()
5172:                 IF loc_oFrm.this_lSelecionou
5173:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5174:                     loc_oPg.txt_4c_TpOp.Value = loc_oFrm.cCodigoSelecionado
5175:                 ENDIF
5176:                 IF USED("cursor_4c_TpOp")
5177:                     USE IN cursor_4c_TpOp
5178:                 ENDIF
5179:             ELSE
5180:                 MsgErro("Erro ao buscar tipos.", "Erro")
5181:             ENDIF
5182:         CATCH TO loc_oErro
5183:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupTpOp")
5184:         ENDTRY
5185:     ENDPROC
5186: 
5187:     PROCEDURE GruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5188:         IF par_nKeyCode = 116
5189:             THIS.AbrirLookupGruccus()
5190:         ENDIF
5191:     ENDPROC
5192: 
5193:     PROCEDURE AbrirLookupGruccus()
5194:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5195:         TRY
5196:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5197:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gruccus")
5198:             IF loc_nResult >= 0
5199:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5200:                 loc_oFrm.DefinirCursor("cursor_4c_Gruccus", "codigos", "descrs", "Grupo C.C.")
5201:                 loc_oFrm.Mostrar()
5202:                 IF loc_oFrm.this_lSelecionou
5203:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5204:                     loc_oPg.txt_4c__gruccus.Value  = loc_oFrm.cCodigoSelecionado
5205:                     loc_oPg.txt_4c__dgruccus.Value = loc_oFrm.cDescricaoSelecionada
5206:                 ENDIF
5207:                 IF USED("cursor_4c_Gruccus")
5208:                     USE IN cursor_4c_Gruccus
5209:                 ENDIF
5210:             ELSE
5211:                 MsgErro("Erro ao buscar grupos.", "Erro")
5212:             ENDIF
5213:         CATCH TO loc_oErro
5214:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupGruccus")
5215:         ENDTRY
5216:     ENDPROC
5217: 
5218:     PROCEDURE ContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5219:         IF par_nKeyCode = 116
5220:             THIS.AbrirLookupContaccus()
5221:         ENDIF
5222:     ENDPROC
5223: 
5224:     PROCEDURE AbrirLookupContaccus()
5225:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5226:         TRY
5227:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos"
5228:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contaccus")
5229:             IF loc_nResult >= 0
5230:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5231:                 loc_oFrm.DefinirCursor("cursor_4c_Contaccus", "codigos", "descrs", "Conta C.C.")
5232:                 loc_oFrm.Mostrar()
5233:                 IF loc_oFrm.this_lSelecionou
5234:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5235:                     loc_oPg.txt_4c__contaccus.Value  = loc_oFrm.cCodigoSelecionado
5236:                     loc_oPg.txt_4c__dcontaccus.Value = loc_oFrm.cDescricaoSelecionada
5237:                 ENDIF
5238:                 IF USED("cursor_4c_Contaccus")
5239:                     USE IN cursor_4c_Contaccus
5240:                 ENDIF
5241:             ELSE
5242:                 MsgErro("Erro ao buscar contas.", "Erro")
5243:             ENDIF
5244:         CATCH TO loc_oErro
5245:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupContaccus")
5246:         ENDTRY
5247:     ENDPROC
5248: 
5249:     PROCEDURE SemiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5250:         IF par_nKeyCode = 116
5251:             THIS.AbrirLookupSemi()
5252:         ENDIF
5253:     ENDPROC
5254: 
5255:     PROCEDURE AbrirLookupSemi()
5256:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5257:         TRY
5258:             loc_cSQL = "SELECT Dopps, hists FROM SigCdOpd ORDER BY Dopps"
5259:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Semi")
5260:             IF loc_nResult >= 0
5261:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5262:                 loc_oFrm.DefinirCursor("cursor_4c_Semi", "Dopps", "hists", "Opera" + CHR(231) + CHR(227) + "o Semiacabados")
5263:                 loc_oFrm.Mostrar()
5264:                 IF loc_oFrm.this_lSelecionou
5265:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5266:                     loc_oPg.txt_4c_Semi.Value = loc_oFrm.cCodigoSelecionado
5267:                 ENDIF
5268:                 IF USED("cursor_4c_Semi")
5269:                     USE IN cursor_4c_Semi
5270:                 ENDIF
5271:             ELSE
5272:                 MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
5273:             ENDIF
5274:         CATCH TO loc_oErro
5275:             MostrarErro(loc_oErro, "FormMPD.AbrirLookupSemi")
5276:         ENDTRY
5277:     ENDPROC
5278: 
5279:     PROCEDURE AjustarBotoesPorModo()
5280:         LOCAL loc_oBotoes, loc_lTemSelecao
5281:         TRY
5282:             loc_oBotoes     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
5283:             loc_lTemSelecao = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
5284:             WITH loc_oBotoes
5285:                 .cmd_4c_Incluir.Enabled    = .T.
5286:                 .cmd_4c_Visualizar.Enabled = loc_lTemSelecao
5287:                 .cmd_4c_Alterar.Enabled    = loc_lTemSelecao
5288:                 .cmd_4c_Excluir.Enabled    = loc_lTemSelecao
5289:                 .cmd_4c_Buscar.Enabled     = .T.
5290:             ENDWITH
5291:         CATCH TO loc_oErro
5292:             MsgErro(loc_oErro.Message, "FormMPD.AjustarBotoesPorModo")
5293:         ENDTRY
5294:     ENDPROC
5295: 
5296:     PROCEDURE Destroy()
5297:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
5298:             THIS.this_oBusinessObject = .NULL.
5299:         ENDIF
5300:         DODEFAULT()
5301:     ENDPROC
5302: 
5303: ENDDEFINE


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

