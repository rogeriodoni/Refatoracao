# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (149)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_MTPRIMA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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
- [CARGA-DADOS] OptionGroup 'opt_4c_Prodvars' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TotGrupo2' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdCompo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdSubCp' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdRelogios' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdConsP' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrDTEMP' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GradFase' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdMatrizes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdDesigner' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdArquivos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdServico' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_PrfExist' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Total ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Grp, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Arquivos Para Designer, Data de Início, Data de Conclusão, Tarefa, Serviços, Código, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Produto, Descrição, Grupo, Subgrp., Ref. Fornecedor, Usuário, I, Empresa, Quantidade, Material, Un, Valor, Qtde., Total, Moe, Observação, E, Consumo, Ord, Moeda, Tam, Grp, Período, Valor Custo GR, Ordem, Fase, Utilização, Uni. Produtiva, Matriz, Local, Qtde, Componente, Uni, Ord., Cat., Agrupamento, Tempo %, Item, Qtd, Etiq, Arquivos Para Designer, Data de Início, Data de Conclusão, Tarefa, Serviços, Código, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label19' Top=504 (diff=472px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Left original=49 vs migrado 'lbl_4c_Label19' Left=18 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=39 vs migrado 'lbl_4c_Say5' Top=158 (diff=119px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=30 vs migrado 'lbl_4c_Say5' Left=98 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say19' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=101 vs migrado 'lbl_4c_Say19' Top=459 (diff=358px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=18 vs migrado 'lbl_4c_Say19' Top=459 (diff=441px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=108 vs migrado 'lbl_4c_Say19' Left=71 (diff=37px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=68 vs migrado 'lbl_4c_Say26' Top=409 (diff=341px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=30 vs migrado 'lbl_4c_Say26' Left=86 (diff=56px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=18 vs migrado 'lbl_4c_Say36' Top=481 (diff=463px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=223 vs migrado 'lbl_4c_Say36' Left=84 (diff=139px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Top original=18 vs migrado 'lbl_4c_Say46' Top=384 (diff=366px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Lista.CntAcabado): Left original=431 vs migrado 'lbl_4c_Say46' Left=84 (diff=347px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=85 vs migrado 'cnt_4c_Botoes' Top=29 (diff=56px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=9 vs migrado 'cnt_4c_Botoes' Left=542 (diff=533px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Top original=5 vs migrado 'lbl_4c_Label8' Top=514 (diff=509px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Left original=8 vs migrado 'lbl_4c_Label8' Left=158 (diff=150px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say19' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=287 vs migrado 'lbl_4c_Say19' Top=459 (diff=172px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say19' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=798 vs migrado 'lbl_4c_Say19' Left=71 (diff=727px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=311 vs migrado 'lbl_4c_Say36' Top=481 (diff=170px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=551 vs migrado 'lbl_4c_Say36' Left=84 (diff=467px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=335 vs migrado 'lbl_4c_Say46' Top=384 (diff=49px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=510 vs migrado 'lbl_4c_Say46' Left=84 (diff=426px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=121 vs migrado 'lbl_4c_Label2' Top=442 (diff=321px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=47 vs migrado 'lbl_4c_Label2' Left=421 (diff=374px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=190 vs migrado 'lbl_4c_Say8' Top=258 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=167 vs migrado 'lbl_4c_Say19' Top=459 (diff=292px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=589 vs migrado 'lbl_4c_Say19' Left=71 (diff=518px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=120 vs migrado 'lbl_4c_Say26' Top=409 (diff=289px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=565 vs migrado 'lbl_4c_Say26' Left=86 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=144 vs migrado 'lbl_4c_Say10' Top=233 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=397 vs migrado 'lbl_4c_Say5' Top=158 (diff=239px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=354 vs migrado 'lbl_4c_Say5' Left=98 (diff=256px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=239 vs migrado 'lbl_4c_Say7' Top=283 (diff=44px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=563 vs migrado 'lbl_4c_Say7' Left=71 (diff=492px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=330 vs migrado 'obj_4c_Fwoption1' Top=123 (diff=207px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=899 vs migrado 'obj_4c_Fwoption1' Left=204 (diff=695px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=191 vs migrado 'lbl_4c_Say13' Top=133 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=558 vs migrado 'lbl_4c_Say13' Left=32 (diff=526px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say21' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=215 vs migrado 'lbl_4c_Say21' Top=434 (diff=219px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say21' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=774 vs migrado 'lbl_4c_Say21' Left=69 (diff=705px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say26' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=263 vs migrado 'lbl_4c_Say26' Top=409 (diff=146px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say26' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=816 vs migrado 'lbl_4c_Say26' Left=86 (diff=730px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say36' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=191 vs migrado 'lbl_4c_Say36' Top=481 (diff=290px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say36' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=788 vs migrado 'lbl_4c_Say36' Left=84 (diff=704px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=514 vs migrado 'lbl_4c_Say8' Top=258 (diff=256px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=158 vs migrado 'lbl_4c_Say8' Left=71 (diff=87px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeGRUPO' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=41 vs migrado 'grd_4c_GradeGrupo2' Top=468 (diff=427px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeGRUPO' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=619 vs migrado 'grd_4c_GradeGrupo2' Left=35 (diff=584px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=442 vs migrado 'lbl_4c_Say26' Top=409 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=421 vs migrado 'lbl_4c_Say26' Left=86 (diff=335px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=514 vs migrado 'lbl_4c_Say13' Top=133 (diff=381px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=476 vs migrado 'lbl_4c_Say13' Left=32 (diff=444px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=404 vs migrado 'lbl_4c_Say36' Top=481 (diff=77px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=40 vs migrado 'lbl_4c_Say36' Left=84 (diff=44px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=404 vs migrado 'lbl_4c_Say5' Top=158 (diff=246px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=466 vs migrado 'lbl_4c_Say5' Left=98 (diff=368px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=269 vs migrado 'lbl_4c_Say46' Top=384 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=33 vs migrado 'lbl_4c_Say46' Left=84 (diff=51px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=555 vs migrado 'lbl_4c_Say7' Top=283 (diff=272px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=272 vs migrado 'lbl_4c_Say7' Left=71 (diff=201px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=555 vs migrado 'lbl_4c_Say9' Top=208 (diff=347px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Left original=158 vs migrado 'lbl_4c_Say9' Left=57 (diff=101px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao): Top original=553 vs migrado 'lbl_4c_Say10' Top=233 (diff=320px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=380 vs migrado 'lbl_4c_Say5' Top=158 (diff=222px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=280 vs migrado 'lbl_4c_Say19' Top=459 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=103 vs migrado 'lbl_4c_Say19' Left=71 (diff=32px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=305 vs migrado 'lbl_4c_Say26' Top=409 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=330 vs migrado 'lbl_4c_Say36' Top=481 (diff=151px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=522 vs migrado 'lbl_4c_Say7' Top=283 (diff=239px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=123 vs migrado 'lbl_4c_Say7' Left=71 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=355 vs migrado 'lbl_4c_Say8' Top=258 (diff=97px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=263 vs migrado 'lbl_4c_Say8' Left=71 (diff=192px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=411 vs migrado 'lbl_4c_Say46' Left=84 (diff=327px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=380 vs migrado 'lbl_4c_Say13' Top=133 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=511 vs migrado 'lbl_4c_Say13' Left=32 (diff=479px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=384 vs migrado 'lbl_4c_Say9' Top=208 (diff=176px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=756 vs migrado 'lbl_4c_Say9' Left=57 (diff=699px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=547 vs migrado 'lbl_4c_Say10' Top=233 (diff=314px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=148 vs migrado 'lbl_4c_Say10' Left=73 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say19' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Top original=178 vs migrado 'lbl_4c_Say19' Top=459 (diff=281px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say19' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais): Left original=117 vs migrado 'lbl_4c_Say19' Left=71 (diff=46px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=508 vs migrado 'lbl_4c_Say19' Top=459 (diff=49px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=527 vs migrado 'lbl_4c_Say19' Left=71 (diff=456px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'inserir' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=129 vs migrado 'cmd_4c_InserirMtz' Top=302 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'inserir' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=950 vs migrado 'cmd_4c_InserirMtz' Left=778 (diff=172px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'excluir' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=169 vs migrado 'cmd_4c_ExcluirMtz' Top=342 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'excluir' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=950 vs migrado 'cmd_4c_ExcluirMtz' Left=778 (diff=172px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=308 vs migrado 'lbl_4c_Say26' Top=409 (diff=101px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Left original=44 vs migrado 'lbl_4c_Say26' Left=86 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=308 vs migrado 'obj_4c_Fwoption1' Top=123 (diff=185px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=183 vs migrado 'lbl_4c_Say46' Top=384 (diff=201px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP): Top original=505 vs migrado 'lbl_4c_Say7' Top=283 (diff=222px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP): Left original=23 vs migrado 'lbl_4c_Say7' Left=71 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP): Top original=501 vs migrado 'lbl_4c_Say19' Top=459 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP): Left original=643 vs migrado 'lbl_4c_Say19' Left=71 (diff=572px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'grdCompo' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Top original=178 vs migrado 'grd_4c_GrdCompo' Top=117 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Top original=159 vs migrado 'lbl_4c_Say19' Top=459 (diff=300px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Left original=107 vs migrado 'lbl_4c_Say19' Left=71 (diff=36px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Left original=480 vs migrado 'lbl_4c_Say26' Left=86 (diff=394px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Top original=445 vs migrado 'lbl_4c_Say36' Top=481 (diff=36px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto): Left original=35 vs migrado 'lbl_4c_Say36' Left=84 (diff=49px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner): Top original=265 vs migrado 'lbl_4c_Say19' Top=459 (diff=194px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner): Left original=583 vs migrado 'lbl_4c_Say19' Left=71 (diff=512px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner): Top original=556 vs migrado 'lbl_4c_Say46' Top=384 (diff=172px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner): Left original=23 vs migrado 'lbl_4c_Say46' Left=84 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner): Top original=580 vs migrado 'lbl_4c_Say5' Top=158 (diff=422px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner): Left original=56 vs migrado 'lbl_4c_Say5' Left=98 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say19' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner): Top original=504 vs migrado 'lbl_4c_Say19' Top=459 (diff=45px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say19' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner): Left original=18 vs migrado 'lbl_4c_Say19' Left=71 (diff=53px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (11438 linhas total):

*-- Linhas 30 a 573:
30:     *===========================================================================
31:     * Init - Inicializa o formulario
32:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
33:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
34:     *===========================================================================
35:     PROCEDURE Init()
36:         RETURN DODEFAULT()
37:     ENDPROC
38: 
39:     *===========================================================================
40:     * InicializarForm - Configura estrutura completa
41:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
42:     *===========================================================================
43:     PROTECTED PROCEDURE InicializarForm()
44:         LOCAL loc_lSucesso, loException
45:         loc_lSucesso = .F.
46: 
47:         TRY
48:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
49: 
50:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
51:                 MostrarErro("Erro ao criar ProdutoBO" + CHR(13) + ;
52:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
53:                     "FormProduto.InicializarForm")
54:             ELSE
55:                 THIS.ConfigurarPageFrame()
56: 
57:                 *-- Propagar Caption para labels do cabecalho (Problema 44)
58:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra") = "O"
59:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 ENDIF
61:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
62:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63:                 ENDIF
64: 
65:                 THIS.pgf_4c_Paginas.Visible = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual = "LISTA"
68: 
69:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
70:                     THIS.CarregarLista()
71:                 ENDIF
72: 
73:                 loc_lSucesso = .T.
74:             ENDIF
75: 
76:         CATCH TO loException
77:             MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
78:                 loException.Message + CHR(13) + ;
79:                 "Linha: " + TRANSFORM(loException.LineNo), ;
80:                 "FormProduto.InicializarForm")
81:         ENDTRY
82: 
83:         RETURN loc_lSucesso
84:     ENDPROC
85: 
86:     *===========================================================================
87:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
88:     * Top=-29 para esconder abas; controles compensam +29 no Top
89:     *===========================================================================
90:     PROTECTED PROCEDURE ConfigurarPageFrame()
91:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
92: 
93:         WITH THIS.pgf_4c_Paginas
94:             .PageCount = 2
95:             .Top       = -29
96:             .Left      = 0
97:             .Width     = THIS.Width
98:             .Height    = THIS.Height + 29
99:             .Tabs      = .F.
100:             .Visible   = .T.
101: 
102:             .Page1.Caption   = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page1.BackColor = RGB(255, 255, 255)
105: 
106:             .Page2.Caption   = "Dados"
107:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page2.BackColor = RGB(255, 255, 255)
109:         ENDWITH
110: 
111:         THIS.ConfigurarPaginaLista()
112:         THIS.ConfigurarPaginaDados()
113:     ENDPROC
114: 
115:     *===========================================================================
116:     * ConfigurarPaginaLista - Configura Page1 completa: cabecalho + botoes + grid
117:     * FASE 4: Grid e botoes CRUD adicionados ao esqueleto da Fase 3
118:     *===========================================================================
119:     PROTECTED PROCEDURE ConfigurarPaginaLista()
120:         LOCAL loc_oPagina
121:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
122: 
123:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
124: 
125:         *-- Container Cabecalho (cntSombra no legado)
126:         *-- Original: Top=1. Com compensacao +29: Top=31
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 31
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = THIS.Caption
141:             .Top       = 15
142:             .Left      = 10
143:             .Width     = 769
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .AutoSize  = .F.
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = THIS.Caption
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = 769
160:             .Height    = 46
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.
164:             .ForeColor = RGB(255, 255, 255)
165:             .BackStyle = 0
166:             .AutoSize  = .F.
167:             .Visible   = .T.
168:         ENDWITH
169: 
170:         *-- Container Botoes CRUD (Grupo_op legado: Left=552, Top=-1, Width=385, Height=85)
171:         *-- Canonico: Left=542, Top=29, Width=390, Height=85
172:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
173:         WITH loc_oPagina.cnt_4c_Botoes
174:             .Top         = 29
175:             .Left        = 542
176:             .Width       = 390
177:             .Height      = 85
178:             .BackStyle = 1
179:             .BackColor = RGB(255, 255, 255)
180:             .BorderWidth = 0
181:             .Visible     = .T.
182:         ENDWITH
183: 
184:         *-- Botao Incluir (Inserir no legado)
185:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
186:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
187:             .Caption         = "Incluir"
188:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
189:             .PicturePosition = 13
190:             .Top             = 5
191:             .Left            = 5
192:             .Width           = 75
193:             .Height          = 75
194:             .FontName        = "Tahoma"
195:             .FontBold        = .T.
196:             .FontItalic      = .T.
197:             .FontSize        = 8
198:             .ForeColor       = RGB(90, 90, 90)
199:             .BackColor       = RGB(255, 255, 255)
200:             .Themes          = .F.
201:             .SpecialEffect   = 0
202:             .MousePointer    = 15
203:             .WordWrap        = .T.
204:             .AutoSize        = .F.
205:             .Visible         = .T.
206:         ENDWITH
207:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
208: 
209:         *-- Botao Visualizar (Consultar no legado)
210:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
211:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
212:             .Caption         = "Visualizar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
214:             .PicturePosition = 13
215:             .Top             = 5
216:             .Left            = 80
217:             .Width           = 75
218:             .Height          = 75
219:             .FontName        = "Tahoma"
220:             .FontBold        = .T.
221:             .FontItalic      = .T.
222:             .FontSize        = 8
223:             .ForeColor       = RGB(90, 90, 90)
224:             .BackColor       = RGB(255, 255, 255)
225:             .Themes          = .F.
226:             .SpecialEffect   = 0
227:             .MousePointer    = 15
228:             .WordWrap        = .T.
229:             .AutoSize        = .F.
230:             .Visible         = .T.
231:         ENDWITH
232:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
233: 
234:         *-- Botao Alterar
235:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
236:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
237:             .Caption         = "Alterar"
238:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
239:             .PicturePosition = 13
240:             .Top             = 5
241:             .Left            = 155
242:             .Width           = 75
243:             .Height          = 75
244:             .FontName        = "Tahoma"
245:             .FontBold        = .T.
246:             .FontItalic      = .T.
247:             .FontSize        = 8
248:             .ForeColor       = RGB(90, 90, 90)
249:             .BackColor       = RGB(255, 255, 255)
250:             .Themes          = .F.
251:             .SpecialEffect   = 0
252:             .MousePointer    = 15
253:             .WordWrap        = .T.
254:             .AutoSize        = .F.
255:             .Visible         = .T.
256:         ENDWITH
257:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
258: 
259:         *-- Botao Excluir
260:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
261:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
262:             .Caption         = "Excluir"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
264:             .PicturePosition = 13
265:             .Top             = 5
266:             .Left            = 230
267:             .Width           = 75
268:             .Height          = 75
269:             .FontName        = "Tahoma"
270:             .FontBold        = .T.
271:             .FontItalic      = .T.
272:             .FontSize        = 8
273:             .ForeColor       = RGB(90, 90, 90)
274:             .BackColor       = RGB(255, 255, 255)
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .MousePointer    = 15
278:             .WordWrap        = .T.
279:             .AutoSize        = .F.
280:             .Visible         = .T.
281:         ENDWITH
282:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
283: 
284:         *-- Botao Buscar (Procurar no legado)
285:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
287:             .Caption         = "Buscar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
289:             .PicturePosition = 13
290:             .Top             = 5
291:             .Left            = 305
292:             .Width           = 75
293:             .Height          = 75
294:             .FontName        = "Tahoma"
295:             .FontBold        = .T.
296:             .FontItalic      = .T.
297:             .FontSize        = 8
298:             .ForeColor       = RGB(90, 90, 90)
299:             .BackColor       = RGB(255, 255, 255)
300:             .Themes          = .F.
301:             .SpecialEffect   = 0
302:             .MousePointer    = 15
303:             .WordWrap        = .T.
304:             .AutoSize        = .F.
305:             .Visible         = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
308: 
309:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
310:         *-- Legado: Grupo_Saida.Left=927, Top=-1. Canonico: Left=917, Top=29, Width=90
311:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
312:         WITH loc_oPagina.cnt_4c_Saida
313:             .Top         = 29
314:             .Left        = 917
315:             .Width       = 90
316:             .Height      = 85
317:             .BackStyle = 1
318:             .BackColor = RGB(255, 255, 255)
319:             .BorderWidth = 0
320:             .Visible     = .T.
321:         ENDWITH
322: 
323:         *-- Botao Encerrar - PADRAO CANONICO
324:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
325:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
326:             .Caption         = "Encerrar"
327:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
328:             .PicturePosition = 13
329:             .Top             = 5
330:             .Left            = 5
331:             .Width           = 75
332:             .Height          = 75
333:             .FontName        = "Tahoma"
334:             .FontBold        = .T.
335:             .FontItalic      = .T.
336:             .FontSize        = 8
337:             .ForeColor       = RGB(90, 90, 90)
338:             .BackColor       = RGB(255, 255, 255)
339:             .Themes          = .F.
340:             .SpecialEffect   = 0
341:             .MousePointer    = 15
342:             .WordWrap        = .T.
343:             .AutoSize        = .F.
344:             .Visible         = .T.
345:         ENDWITH
346:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
347: 
348:         *-- Grid de listagem de produtos
349:         *-- Original: Grade.Top=173, Left=11, Width=972, Height=422, ColumnCount=7
350:         *-- Top nao precisa de compensacao pois grade esta dentro da page (coordenadas relativas)
351:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
352:         *-- ColumnCount FORA do WITH (auto-bind VFP9)
353:         loc_oPagina.grd_4c_Lista.ColumnCount = 7
354:         WITH loc_oPagina.grd_4c_Lista
355:             .Top                = 117
356:             .Left               = 11
357:             .Width              = 972
358:             .Height             = 422
359:             .FontName           = "Tahoma"
360:             .FontSize           = 8
361:             .ForeColor          = RGB(90, 90, 90)
362:             .BackColor          = RGB(255, 255, 255)
363:             .GridLineColor      = RGB(238, 238, 238)
364:             .HighlightBackColor = RGB(255, 255, 255)
365:             .HighlightForeColor = RGB(15, 41, 104)
366:             .HighlightStyle     = 2
367:             .DeleteMark         = .F.
368:             .RecordMark         = .F.
369:             .RowHeight          = 18
370:             .ScrollBars         = 3
371:             .GridLines          = 3
372:             .AllowHeaderSizing  = .F.
373:             .AllowRowSizing     = .F.
374:             .Visible            = .T.
375:         ENDWITH
376:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
377: 
378:         THIS.TornarControlesVisiveis(loc_oPagina)
379:     ENDPROC
380: 
381:     *===========================================================================
382:     * ConfigurarPaginaDados - Configura Page2: BotoesAcao + pgf_4c_Dados (8 abas)
383:     * FASE 5: Implementacao completa com todos os campos de SigCdPro
384:     *===========================================================================
385:     PROTECTED PROCEDURE ConfigurarPaginaDados()
386:         LOCAL loc_oPagina
387:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
388: 
389:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
390: 
391:         *-- Container BotoesAcao (original: Top=85, Left=9, Width=160, Height=85)
392:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
393:         WITH loc_oPagina.cnt_4c_BotoesAcao
394:             .Top         = 85
395:             .Left        = 9
396:             .Width       = 160
397:             .Height      = 85
398:             .BackStyle = 1
399:             .BackColor = RGB(255, 255, 255)
400:             .BorderWidth = 0
401:             .Visible     = .T.
402:         ENDWITH
403: 
404:         *-- Botao Salvar
405:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
406:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
407:             .Caption         = "Salvar"
408:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
409:             .PicturePosition = 13
410:             .Top             = 5
411:             .Left            = 5
412:             .Width           = 70
413:             .Height          = 75
414:             .FontName        = "Tahoma"
415:             .FontBold        = .T.
416:             .FontItalic      = .T.
417:             .FontSize        = 8
418:             .ForeColor       = RGB(90, 90, 90)
419:             .BackColor       = RGB(255, 255, 255)
420:             .Themes          = .F.
421:             .SpecialEffect   = 0
422:             .MousePointer    = 15
423:             .WordWrap        = .T.
424:             .AutoSize        = .F.
425:             .Visible         = .T.
426:         ENDWITH
427:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
428: 
429:         *-- Botao Cancelar
430:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
431:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
432:             .Caption         = "Encerrar"
433:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
434:             .PicturePosition = 13
435:             .Top             = 5
436:             .Left            = 80
437:             .Width           = 75
438:             .Height          = 75
439:             .FontName        = "Tahoma"
440:             .FontBold        = .T.
441:             .FontItalic      = .T.
442:             .FontSize        = 8
443:             .ForeColor       = RGB(90, 90, 90)
444:             .BackColor       = RGB(255, 255, 255)
445:             .Themes          = .F.
446:             .SpecialEffect   = 0
447:             .MousePointer    = 15
448:             .WordWrap        = .T.
449:             .AutoSize        = .F.
450:             .Visible         = .T.
451:         ENDWITH
452:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
453: 
454:         *-- pgf_4c_Dados: PageFrame interno com 8 abas (original: pgframeDados)
455:         *-- Original: Top=-58(abas ocultas), Width=1009, Height=656
456:         *-- Novo: abas visiveis abaixo dos BotoesAcao
457:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
458:         loc_oPagina.pgf_4c_Dados.PageCount = 8
459:         WITH loc_oPagina.pgf_4c_Dados
460:             .Top     = 120
461:             .Left    = 0
462:             .Width   = THIS.Width
463:             .Height  = 500
464:             .Tabs    = .T.
465:             .Visible = .T.
466: 
467:             .Page1.Caption = "Dados Principais"
468:             .Page2.Caption = "Custos"
469:             .Page3.Caption = "Dados Fiscais"
470:             .Page4.Caption = "Processos"
471:             .Page5.Caption = "Consumo"
472:             .Page6.Caption = "Composi" + CHR(231) + CHR(227) + "o"
473:             .Page7.Caption = "Designer"
474:             .Page8.Caption = "Servi" + CHR(231) + "os"
475:         ENDWITH
476: 
477:         *-- Tab 1: Dados Principais (campos principais de SigCdPro)
478:         THIS.ConfigurarPgDados(loc_oPagina.pgf_4c_Dados.Page1)
479: 
480:         *-- Tabs 2-8: label descritivo de cada aba
481:         THIS.ConfigurarPgpgCusto(loc_oPagina.pgf_4c_Dados.Page2)
482:         THIS.ConfigurarPgpgDadosFiscais(loc_oPagina.pgf_4c_Dados.Page3)
483:         THIS.ConfigurarPgPgDadosFaseP(loc_oPagina.pgf_4c_Dados.Page4)
484:         THIS.ConfigurarPgPgDadosConsP(loc_oPagina.pgf_4c_Dados.Page5)
485:         THIS.ConfigurarPgpgComposicao(loc_oPagina.pgf_4c_Dados.Page6)
486:         THIS.ConfigurarPgpgDesigner(loc_oPagina.pgf_4c_Dados.Page7)
487:         THIS.ConfigurarPgpgServico(loc_oPagina.pgf_4c_Dados.Page8)
488: 
489:         THIS.TornarControlesVisiveis(loc_oPagina)
490:     ENDPROC
491: 
492:     *===========================================================================
493:     * ConfigurarPgDados - Configura Tab1 "Dados Principais" do pgf_4c_Dados
494:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgDados
495:     * Coordenadas originais preservadas (relativas ao page content)
496:     *===========================================================================
497:     PROTECTED PROCEDURE ConfigurarPgDados(par_oPg)
498:         LOCAL loc_oPg
499:         loc_oPg = par_oPg
500:         loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
501: 
502:         *-- Situacao (opc_situacao: Top=114, Left=758, situas=numeric)
503:         loc_oPg.AddObject("opt_4c_Situacao", "OptionGroup")
504:         WITH loc_oPg.opt_4c_Situacao
505:             .ButtonCount = 2
506:             .Value       = 1
507:             .Top         = 114
508:             .Left        = 758
509:             .Width       = 156
510:             .Height      = 25
511:             .BackStyle   = 0
512:             .BorderStyle = 0
513:             .Visible     = .T.
514:             .Option1.Caption   = "Ativo"
515:             .Option1.FontName  = "Tahoma"
516:             .Option1.FontSize  = 8
517:             .Option1.BackStyle = 0
518:             .Option1.ForeColor = RGB(90, 90, 90)
519:             .Option1.Top       = 5
520:             .Option1.Left      = 5
521:             .Option1.Height    = 15
522:             .Option1.AutoSize  = .T.
523:             .Option2.Caption   = "Inativo"
524:             .Option2.FontName  = "Tahoma"
525:             .Option2.FontSize  = 8
526:             .Option2.BackStyle = 0
527:             .Option2.ForeColor = RGB(90, 90, 90)
528:             .Option2.Top       = 5
529:             .Option2.Left      = 80
530:             .Option2.Height    = 15
531:             .Option2.AutoSize  = .T.
532:         ENDWITH
533:         BINDEVENT(loc_oPg.opt_4c_Situacao, "InteractiveChange", THIS, "OptSituacaoInteractiveChange")
534: 
535:         *-- Data da Situacao (getDtSituas: Top=115, Left=918, readonly)
536:         loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
537:         WITH loc_oPg.txt_4c_DtSituas
538:             .Top           = 115
539:             .Left          = 918
540:             .Width         = 80
541:             .Height        = 23
542:             .FontName      = "Tahoma"
543:             .FontSize      = 8
544:             .SpecialEffect = 1
545:             .Value         = {}
546:             .Enabled       = .F.
547:             .BackColor     = RGB(240, 240, 240)
548:             .ToolTipText   = "Data da Situa" + CHR(231) + CHR(227) + "o"
549:             .Visible       = .T.
550:         ENDWITH
551: 
552:         *-- Label "Produto:"
553:         loc_oPg.AddObject("lbl_4c_LbCpros", "Label")
554:         WITH loc_oPg.lbl_4c_LbCpros
555:             .Caption   = "Produto :"
556:             .Top       = 121
557:             .Left      = 47
558:             .Width     = 53
559:             .Height    = 15
560:             .FontName  = "Tahoma"
561:             .FontBold  = .T.
562:             .FontSize  = 8
563:             .ForeColor = RGB(90, 90, 90)
564:             .BackStyle = 0
565:             .AutoSize  = .T.
566:             .Visible   = .T.
567:         ENDWITH
568: 
569:         *-- Codigo do Produto (getCpro: Top=117, Left=102, Width=108)
570:         loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
571:         WITH loc_oPg.txt_4c_Cpros
572:             .Top           = 117
573:             .Left          = 102

*-- Linhas 653 a 789:
653:             .MaxLength     = 3
654:             .Visible       = .T.
655:         ENDWITH
656:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TxtCgrusKeyPress")
657:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "ValidarCgrus")
658: 
659:         *-- Descricao do Grupo (getDgru: Top=186, Left=134, Width=171, readonly)
660:         loc_oPg.AddObject("txt_4c_Dgrus", "TextBox")
661:         WITH loc_oPg.txt_4c_Dgrus
662:             .Top           = 186
663:             .Left          = 134
664:             .Width         = 171
665:             .Height        = 22
666:             .FontName      = "Tahoma"
667:             .FontSize      = 8
668:             .SpecialEffect = 1
669:             .ReadOnly      = .T.
670:             .BackColor     = RGB(240, 240, 240)
671:             .Visible       = .T.
672:         ENDWITH
673: 
674:         *-- Label "Subgrupo:"
675:         loc_oPg.AddObject("lbl_4c_LbSGrus", "Label")
676:         WITH loc_oPg.lbl_4c_LbSGrus
677:             .Caption   = "Subgrupo :"
678:             .Top       = 213
679:             .Left      = 45
680:             .Width     = 55
681:             .Height    = 15
682:             .FontName  = "Tahoma"
683:             .FontSize  = 8
684:             .ForeColor = RGB(90, 90, 90)
685:             .BackStyle = 0
686:             .AutoSize  = .T.
687:             .Visible   = .T.
688:         ENDWITH
689: 
690:         *-- Codigo do Sub-grupo (GetCSGru: Top=209, Left=102, Width=52, MaxLength=6)
691:         loc_oPg.AddObject("txt_4c_SGrus", "TextBox")
692:         WITH loc_oPg.txt_4c_SGrus
693:             .Top           = 209
694:             .Left          = 102
695:             .Width         = 52
696:             .Height        = 22
697:             .FontName      = "Tahoma"
698:             .FontSize      = 8
699:             .SpecialEffect = 1
700:             .MaxLength     = 6
701:             .Visible       = .T.
702:         ENDWITH
703:         BINDEVENT(loc_oPg.txt_4c_SGrus, "KeyPress", THIS, "ValidarSGrus")
704: 
705:         *-- Descricao do Sub-grupo (GetDsGru: Top=209, Left=155, Width=150, readonly)
706:         loc_oPg.AddObject("txt_4c_DsGrus", "TextBox")
707:         WITH loc_oPg.txt_4c_DsGrus
708:             .Top           = 209
709:             .Left          = 155
710:             .Width         = 150
711:             .Height        = 22
712:             .FontName      = "Tahoma"
713:             .FontSize      = 8
714:             .SpecialEffect = 1
715:             .ReadOnly      = .T.
716:             .BackColor     = RGB(240, 240, 240)
717:             .Visible       = .T.
718:         ENDWITH
719: 
720:         *-- Label "Linha:"
721:         loc_oPg.AddObject("lbl_4c_LbLinhas", "Label")
722:         WITH loc_oPg.lbl_4c_LbLinhas
723:             .Caption   = "Linha :"
724:             .Top       = 236
725:             .Left      = 66
726:             .Width     = 34
727:             .Height    = 15
728:             .FontName  = "Tahoma"
729:             .FontSize  = 8
730:             .ForeColor = RGB(90, 90, 90)
731:             .BackStyle = 0
732:             .AutoSize  = .T.
733:             .Visible   = .T.
734:         ENDWITH
735: 
736:         *-- Codigo da Linha (GetLin: Top=232, Left=102, Width=80)
737:         loc_oPg.AddObject("txt_4c_Linhas", "TextBox")
738:         WITH loc_oPg.txt_4c_Linhas
739:             .Top           = 232
740:             .Left          = 102
741:             .Width         = 80
742:             .Height        = 22
743:             .FontName      = "Tahoma"
744:             .FontSize      = 8
745:             .SpecialEffect = 1
746:             .MaxLength     = 10
747:             .Visible       = .T.
748:         ENDWITH
749:         BINDEVENT(loc_oPg.txt_4c_Linhas, "KeyPress", THIS, "ValidarLinhas")
750: 
751:         *-- Descricao da Linha (GetDLin: Top=232, Left=183, Width=196, readonly)
752:         loc_oPg.AddObject("txt_4c_DLinhas", "TextBox")
753:         WITH loc_oPg.txt_4c_DLinhas
754:             .Top           = 232
755:             .Left          = 183
756:             .Width         = 196
757:             .Height        = 22
758:             .FontName      = "Tahoma"
759:             .FontSize      = 8
760:             .SpecialEffect = 1
761:             .ReadOnly      = .T.
762:             .BackColor     = RGB(240, 240, 240)
763:             .Visible       = .T.
764:         ENDWITH
765: 
766:         *-- Label "Obs Pessoal:" (right column)
767:         loc_oPg.AddObject("lbl_4c_LbObspes", "Label")
768:         WITH loc_oPg.lbl_4c_LbObspes
769:             .Caption   = "Obs Pessoal :"
770:             .Top       = 239
771:             .Left      = 563
772:             .Width     = 67
773:             .Height    = 15
774:             .FontName  = "Tahoma"
775:             .FontSize  = 8
776:             .ForeColor = RGB(90, 90, 90)
777:             .BackStyle = 0
778:             .AutoSize  = .T.
779:             .Visible   = .T.
780:         ENDWITH
781: 
782:         *-- Obs Pessoal (getObs1: Top=235, Left=633, Width=159, MaxLength=30)
783:         loc_oPg.AddObject("txt_4c_Obspes", "TextBox")
784:         WITH loc_oPg.txt_4c_Obspes
785:             .Top           = 235
786:             .Left          = 633
787:             .Width         = 159
788:             .Height        = 23
789:             .FontName      = "Tahoma"

*-- Linhas 852 a 1019:
852:             .MaxLength     = 10
853:             .Visible       = .T.
854:         ENDWITH
855:         BINDEVENT(loc_oPg.txt_4c_Colecoes, "KeyPress", THIS, "ValidarColecoes")
856: 
857:         *-- Descricao Colecao (GetDCol: Top=255, Left=183, Width=318, readonly)
858:         loc_oPg.AddObject("txt_4c_DColecoes", "TextBox")
859:         WITH loc_oPg.txt_4c_DColecoes
860:             .Top           = 255
861:             .Left          = 183
862:             .Width         = 318
863:             .Height        = 22
864:             .FontName      = "Tahoma"
865:             .FontSize      = 8
866:             .SpecialEffect = 1
867:             .ReadOnly      = .T.
868:             .BackColor     = RGB(240, 240, 240)
869:             .Visible       = .T.
870:         ENDWITH
871: 
872:         *-- Label "Fornecedor:"
873:         loc_oPg.AddObject("lbl_4c_LbIfors", "Label")
874:         WITH loc_oPg.lbl_4c_LbIfors
875:             .Caption   = "Fornecedor :"
876:             .Top       = 305
877:             .Left      = 36
878:             .Width     = 64
879:             .Height    = 15
880:             .FontName  = "Tahoma"
881:             .FontSize  = 8
882:             .ForeColor = RGB(90, 90, 90)
883:             .BackStyle = 0
884:             .AutoSize  = .T.
885:             .Visible   = .T.
886:         ENDWITH
887: 
888:         *-- Codigo Fornecedor (getIfor: Top=301, Left=102, Width=80, MaxLength=10)
889:         loc_oPg.AddObject("txt_4c_Ifors", "TextBox")
890:         WITH loc_oPg.txt_4c_Ifors
891:             .Top           = 301
892:             .Left          = 102
893:             .Width         = 80
894:             .Height        = 22
895:             .FontName      = "Tahoma"
896:             .FontSize      = 8
897:             .SpecialEffect = 1
898:             .MaxLength     = 10
899:             .Visible       = .T.
900:         ENDWITH
901:         BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "TxtIforsKeyPress")
902:         BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "ValidarIfors")
903: 
904:         *-- Descricao Fornecedor (getDfor: Top=301, Left=183, Width=318, readonly)
905:         loc_oPg.AddObject("txt_4c_Dfors", "TextBox")
906:         WITH loc_oPg.txt_4c_Dfors
907:             .Top           = 301
908:             .Left          = 183
909:             .Width         = 318
910:             .Height        = 22
911:             .FontName      = "Tahoma"
912:             .FontSize      = 8
913:             .SpecialEffect = 1
914:             .ReadOnly      = .T.
915:             .BackColor     = RGB(240, 240, 240)
916:             .Visible       = .T.
917:         ENDWITH
918: 
919:         *-- Label "Cor:"
920:         loc_oPg.AddObject("lbl_4c_LbCodCors", "Label")
921:         WITH loc_oPg.lbl_4c_LbCodCors
922:             .Caption   = "Cor :"
923:             .Top       = 328
924:             .Left      = 361
925:             .Width     = 25
926:             .Height    = 15
927:             .FontName  = "Tahoma"
928:             .FontSize  = 8
929:             .ForeColor = RGB(90, 90, 90)
930:             .BackStyle = 0
931:             .AutoSize  = .T.
932:             .Visible   = .T.
933:         ENDWITH
934: 
935:         *-- Codigo Cor (getCor: Top=324, Left=390, Width=38)
936:         loc_oPg.AddObject("txt_4c_CodCors", "TextBox")
937:         WITH loc_oPg.txt_4c_CodCors
938:             .Top           = 324
939:             .Left          = 390
940:             .Width         = 38
941:             .Height        = 22
942:             .FontName      = "Tahoma"
943:             .FontSize      = 8
944:             .SpecialEffect = 1
945:             .MaxLength     = 4
946:             .Visible       = .T.
947:         ENDWITH
948:         BINDEVENT(loc_oPg.txt_4c_CodCors, "KeyPress", THIS, "ValidarCodCors")
949: 
950:         *-- Label "Tam:"
951:         loc_oPg.AddObject("lbl_4c_LbCodTams", "Label")
952:         WITH loc_oPg.lbl_4c_LbCodTams
953:             .Caption   = "Tam:"
954:             .Top       = 328
955:             .Left      = 431
956:             .Width     = 30
957:             .Height    = 15
958:             .FontName  = "Tahoma"
959:             .FontSize  = 8
960:             .ForeColor = RGB(90, 90, 90)
961:             .BackStyle = 0
962:             .AutoSize  = .T.
963:             .Visible   = .T.
964:         ENDWITH
965: 
966:         *-- Codigo Tamanho (getTam: Top=324, Left=463, Width=38)
967:         loc_oPg.AddObject("txt_4c_CodTams", "TextBox")
968:         WITH loc_oPg.txt_4c_CodTams
969:             .Top           = 324
970:             .Left          = 463
971:             .Width         = 38
972:             .Height        = 22
973:             .FontName      = "Tahoma"
974:             .FontSize      = 8
975:             .SpecialEffect = 1
976:             .MaxLength     = 4
977:             .Visible       = .T.
978:         ENDWITH
979:         BINDEVENT(loc_oPg.txt_4c_CodTams, "KeyPress", THIS, "ValidarCodTams")
980: 
981:         *-- Label "Ref. Fornecedor:"
982:         loc_oPg.AddObject("lbl_4c_LbReffs", "Label")
983:         WITH loc_oPg.lbl_4c_LbReffs
984:             .Caption   = "Ref. Fornecedor :"
985:             .Top       = 327
986:             .Left      = 12
987:             .Width     = 88
988:             .Height    = 15
989:             .FontName  = "Tahoma"
990:             .FontSize  = 8
991:             .ForeColor = RGB(90, 90, 90)
992:             .BackStyle = 0
993:             .AutoSize  = .T.
994:             .Visible   = .T.
995:         ENDWITH
996: 
997:         *-- Ref. Fornecedor (getRefs: Top=324, Left=102, Width=221, MaxLength=40)
998:         loc_oPg.AddObject("txt_4c_Reffs", "TextBox")
999:         WITH loc_oPg.txt_4c_Reffs
1000:             .Top           = 324
1001:             .Left          = 102
1002:             .Width         = 221
1003:             .Height        = 22
1004:             .FontName      = "Tahoma"
1005:             .FontSize      = 8
1006:             .SpecialEffect = 1
1007:             .MaxLength     = 40
1008:             .Visible       = .T.
1009:         ENDWITH
1010: 
1011:         *-- Label "Valor de Custo:"
1012:         loc_oPg.AddObject("lbl_4c_LbCustofs", "Label")
1013:         WITH loc_oPg.lbl_4c_LbCustofs
1014:             .Caption   = "Valor de Custo :"
1015:             .Top       = 311
1016:             .Left      = 551
1017:             .Width     = 79
1018:             .Height    = 15
1019:             .FontName  = "Tahoma"

*-- Linhas 1180 a 1269:
1180:             .ToolTipText   = "Acabamento"
1181:             .Visible       = .T.
1182:         ENDWITH
1183:         BINDEVENT(loc_oPg.txt_4c_CodAcbs, "KeyPress", THIS, "ValidarCodAcbs")
1184: 
1185:         *-- Descricao do Acabamento (get_Dacb: Top=370, Left=134, Width=150, readonly)
1186:         loc_oPg.AddObject("txt_4c_DAcbs", "TextBox")
1187:         WITH loc_oPg.txt_4c_DAcbs
1188:             .Top           = 370
1189:             .Left          = 134
1190:             .Width         = 150
1191:             .Height        = 22
1192:             .FontName      = "Tahoma"
1193:             .FontSize      = 8
1194:             .SpecialEffect = 1
1195:             .ReadOnly      = .T.
1196:             .BackColor     = RGB(240, 240, 240)
1197:             .Visible       = .T.
1198:         ENDWITH
1199: 
1200:         *-- Label "Unidades (1):"
1201:         loc_oPg.AddObject("lbl_4c_LbCunis", "Label")
1202:         WITH loc_oPg.lbl_4c_LbCunis
1203:             .Caption   = "Unidades (1) :"
1204:             .Top       = 420
1205:             .Left      = 30
1206:             .Width     = 70
1207:             .Height    = 15
1208:             .FontName  = "Tahoma"
1209:             .FontSize  = 8
1210:             .ForeColor = RGB(90, 90, 90)
1211:             .BackStyle = 0
1212:             .AutoSize  = .T.
1213:             .Visible   = .T.
1214:         ENDWITH
1215: 
1216:         *-- Unidade de Medida (Get_Cuni: Top=416, Left=102, Width=31, MaxLength=3)
1217:         loc_oPg.AddObject("txt_4c_Cunis", "TextBox")
1218:         WITH loc_oPg.txt_4c_Cunis
1219:             .Top           = 416
1220:             .Left          = 102
1221:             .Width         = 31
1222:             .Height        = 22
1223:             .FontName      = "Tahoma"
1224:             .FontSize      = 8
1225:             .SpecialEffect = 1
1226:             .MaxLength     = 3
1227:             .Visible       = .T.
1228:         ENDWITH
1229:         BINDEVENT(loc_oPg.txt_4c_Cunis, "KeyPress", THIS, "ValidarCunis")
1230: 
1231:         *-- Descricao da Unidade (Get_Duni: Top=416, Left=134, Width=150, readonly)
1232:         loc_oPg.AddObject("txt_4c_Dunis", "TextBox")
1233:         WITH loc_oPg.txt_4c_Dunis
1234:             .Top           = 416
1235:             .Left          = 134
1236:             .Width         = 150
1237:             .Height        = 22
1238:             .FontName      = "Tahoma"
1239:             .FontSize      = 8
1240:             .SpecialEffect = 1
1241:             .ReadOnly      = .T.
1242:             .BackColor     = RGB(240, 240, 240)
1243:             .Visible       = .T.
1244:         ENDWITH
1245: 
1246:         *-- Label "Data / Usuario"
1247:         loc_oPg.AddObject("lbl_4c_LbDtIncs", "Label")
1248:         WITH loc_oPg.lbl_4c_LbDtIncs
1249:             .Caption   = "Data / Usu" + CHR(225) + "rio"
1250:             .Top       = 420
1251:             .Left      = 827
1252:             .Width     = 84
1253:             .Height    = 15
1254:             .FontName  = "Tahoma"
1255:             .FontBold  = .T.
1256:             .FontSize  = 8
1257:             .ForeColor = RGB(90, 90, 90)
1258:             .BackStyle = 0
1259:             .AutoSize  = .T.
1260:             .Visible   = .T.
1261:         ENDWITH
1262: 
1263:         *-- Data de Inclusao (Get_DtIncs: Top=569->adaptar, Left=827, Width=79, readonly)
1264:         loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
1265:         WITH loc_oPg.txt_4c_DtIncs
1266:             .Value         = {}
1267:             .Top           = 437
1268:             .Left          = 827
1269:             .Width         = 79

*-- Linhas 1298 a 1395:
1298:     *===========================================================================
1299:     * ConfigurarPgDadosInfo - Configura label descritivo em aba do pgf_4c_Dados
1300:     *===========================================================================
1301:     PROTECTED PROCEDURE ConfigurarPgDadosInfo(par_oPg, par_cConteudo)
1302:         par_oPg.AddObject("lbl_4c_StubInfo", "Label")
1303:         WITH par_oPg.lbl_4c_StubInfo
1304:             .Caption   = par_cConteudo
1305:             .Top       = 50
1306:             .Left      = 30
1307:             .Width     = 600
1308:             .Height    = 30
1309:             .FontName  = "Tahoma"
1310:             .FontSize  = 10
1311:             .FontBold  = .F.
1312:             .ForeColor = RGB(120, 120, 120)
1313:             .BackStyle = 0
1314:             .AutoSize  = .T.
1315:             .Visible   = .T.
1316:         ENDWITH
1317:     ENDPROC
1318: 
1319:     *===========================================================================
1320:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1321:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
1322:     *===========================================================================
1323:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1324:         LOCAL loc_nI, loc_oObjeto, loc_nP
1325: 
1326:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1327:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1328: 
1329:             IF VARTYPE(loc_oObjeto) = "O"
1330:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1331:                     loc_oObjeto.Visible = .T.
1332:                 ENDIF
1333: 
1334:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1335:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1336:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1337:                     ENDFOR
1338:                 ENDIF
1339: 
1340:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1341:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1342:                 ENDIF
1343:             ENDIF
1344:         ENDFOR
1345:     ENDPROC
1346: 
1347:     *===========================================================================
1348:     * CarregarLista - Carrega dados no grid da Page1
1349:     * CRITICO: Definir ControlSources APOS RecordSource (auto-bind)
1350:     *===========================================================================
1351:     PROCEDURE CarregarLista()
1352:         LOCAL loc_lResultado, loc_oGrid
1353:         loc_lResultado = .F.
1354: 
1355:         TRY
1356:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1357:                 CREATE CURSOR cursor_4c_Dados (cpros C(14), dpros C(65), cgrus C(3), ;
1358:                     sgrus C(6), linhas C(10), tipos C(1), situas N(1,0), ifors C(10), ;
1359:                     pvens N(11,5), pcuss N(11,5), custofs N(11,3), cunis C(3), ;
1360:                     matprincs C(14), codcors C(4), codtams C(4), reffs C(40), ;
1361:                     colecoes C(10), idpro N(10,0))
1362:                 loc_lResultado = .T.
1363:             ELSE
1364:                 IF !THIS.this_oBusinessObject.Buscar("")
1365:                     loc_lResultado = .F.
1366:                 ELSE
1367:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1368: 
1369:                 *-- RecordSource e ColumnCount FORA do WITH (auto-bind VFP9)
1370:                 loc_oGrid.ColumnCount  = 7
1371:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1372: 
1373:                 *-- ControlSources APOS RecordSource (OBRIGATORIO - auto-bind sobrescreve)
1374:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
1375:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
1376:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
1377:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
1378:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
1379:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.colecoes"
1380:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.situas"
1381: 
1382:                 *-- Widths (originais: 110, 408, 40, 70, 150, 100, 16)
1383:                 loc_oGrid.Column1.Width = 110
1384:                 loc_oGrid.Column2.Width = 408
1385:                 loc_oGrid.Column3.Width = 40
1386:                 loc_oGrid.Column4.Width = 70
1387:                 loc_oGrid.Column5.Width = 150
1388:                 loc_oGrid.Column6.Width = 100
1389:                 loc_oGrid.Column7.Width = 40
1390: 
1391:                 *-- Headers APOS RecordSource (RecordSource reseta captions)
1392:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1393:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1394:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
1395:                 loc_oGrid.Column4.Header1.Caption = "Subgrp."

*-- Linhas 1433 a 1814:
1433:     *===========================================================================
1434:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1435:     *===========================================================================
1436:     PROCEDURE AlternarPagina(par_nPagina)
1437:         LOCAL loc_lResultado
1438:         loc_lResultado = .F.
1439: 
1440:         TRY
1441:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1442:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
1443:             ELSE
1444:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1445: 
1446:                 IF par_nPagina = 1
1447:                     THIS.this_cModoAtual = "LISTA"
1448:                     THIS.CarregarLista()
1449:                 ENDIF
1450: 
1451:                 loc_lResultado = .T.
1452:             ENDIF
1453: 
1454:         CATCH TO loException
1455:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
1456:                 "FormProduto.AlternarPagina")
1457:         ENDTRY
1458: 
1459:         RETURN loc_lResultado
1460:     ENDPROC
1461: 
1462:     *===========================================================================
1463:     * FormatarGridLista - Formata visual do grid de lista
1464:     *===========================================================================
1465:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1466:         TRY
1467:             WITH par_oGrid
1468:                 .FontName = "Tahoma"
1469:                 .FontSize = 8
1470:             ENDWITH
1471:         CATCH TO loException
1472:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
1473:                 "FormProduto.FormatarGridLista")
1474:         ENDTRY
1475:     ENDPROC
1476: 
1477:     *===========================================================================
1478:     * BtnIncluirClick - Abre Page2 para incluir novo produto
1479:     * PUBLIC: BINDEVENT requer metodo publico
1480:     *===========================================================================
1481:     PROCEDURE BtnIncluirClick()
1482:         THIS.this_oBusinessObject.NovoRegistro()
1483:         THIS.LimparCampos()
1484:         THIS.this_cModoAtual = "INCLUIR"
1485:         THIS.HabilitarCampos(.T.)
1486:         THIS.AjustarBotoesPorModo()
1487:         THIS.AlternarPagina(2)
1488:     ENDPROC
1489: 
1490:     *===========================================================================
1491:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
1492:     * PUBLIC: BINDEVENT requer metodo publico
1493:     *===========================================================================
1494:     PROCEDURE BtnVisualizarClick()
1495:         LOCAL loc_cCodigo
1496:         loc_cCodigo = ""
1497: 
1498:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1499:             SELECT cursor_4c_Dados
1500:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1501:         ENDIF
1502: 
1503:         IF EMPTY(loc_cCodigo)
1504:             MsgAviso("Selecione um produto para visualizar.")
1505:         ELSE
1506:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1507:                 THIS.this_cModoAtual = "VISUALIZAR"
1508:                 THIS.BOParaForm()
1509:                 THIS.HabilitarCampos(.F.)
1510:                 THIS.AjustarBotoesPorModo()
1511:                 THIS.AlternarPagina(2)
1512:             ENDIF
1513:         ENDIF
1514:     ENDPROC
1515: 
1516:     *===========================================================================
1517:     * BtnAlterarClick - Abre Page2 para alterar produto selecionado
1518:     * PUBLIC: BINDEVENT requer metodo publico
1519:     *===========================================================================
1520:     PROCEDURE BtnAlterarClick()
1521:         LOCAL loc_cCodigo
1522:         loc_cCodigo = ""
1523: 
1524:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1525:             SELECT cursor_4c_Dados
1526:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1527:         ENDIF
1528: 
1529:         IF EMPTY(loc_cCodigo)
1530:             MsgAviso("Selecione um produto para alterar.")
1531:         ELSE
1532:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1533:                 THIS.this_oBusinessObject.EditarRegistro()
1534:                 THIS.this_cModoAtual = "ALTERAR"
1535:                 THIS.BOParaForm()
1536:                 THIS.HabilitarCampos(.T.)
1537:                 THIS.AjustarBotoesPorModo()
1538:                 THIS.AlternarPagina(2)
1539:             ENDIF
1540:         ENDIF
1541:     ENDPROC
1542: 
1543:     *===========================================================================
1544:     * BtnExcluirClick - Exclui produto selecionado com confirmacao
1545:     * PUBLIC: BINDEVENT requer metodo publico
1546:     *===========================================================================
1547:     PROCEDURE BtnExcluirClick()
1548:         LOCAL loc_cCodigo, loc_cDescricao
1549:         loc_cCodigo    = ""
1550:         loc_cDescricao = ""
1551: 
1552:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1553:             SELECT cursor_4c_Dados
1554:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
1555:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)
1556:         ENDIF
1557: 
1558:         IF EMPTY(loc_cCodigo)
1559:             MsgAviso("Selecione um produto para excluir.")
1560:         ELSE
1561:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1562:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto [" + ;
1563:                     loc_cCodigo + "] - " + loc_cDescricao + "?", ;
1564:                     "Confirmar Exclus" + CHR(227) + "o")
1565:                     IF THIS.this_oBusinessObject.Excluir()
1566:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso!")
1567:                         THIS.CarregarLista()
1568:                     ENDIF
1569:                 ENDIF
1570:             ENDIF
1571:         ENDIF
1572:     ENDPROC
1573: 
1574:     *===========================================================================
1575:     * BtnBuscarClick - Busca produto pelo codigo ou descricao
1576:     * PUBLIC: BINDEVENT requer metodo publico
1577:     *===========================================================================
1578:     PROCEDURE BtnBuscarClick()
1579:         LOCAL loc_oBusca, loc_cCodigo, loc_nRet, loException
1580:         loc_cCodigo = ""
1581: 
1582:         TRY
1583:             loc_nRet = SQLEXEC(gnConnHandle, ;
1584:                 "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
1585:                 "cursor_4c_BuscaProduto")
1586: 
1587:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaProduto")
1588:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1589:                 IF VARTYPE(loc_oBusca) = "O"
1590:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProduto"
1591:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProduto", "cpros", "dpros", ;
1592:                         "Buscar Produto")
1593:                     loc_oBusca.Mostrar()
1594:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado)
1595:                         loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1596:                     ENDIF
1597:                     loc_oBusca = .NULL.
1598:                 ENDIF
1599:             ENDIF
1600: 
1601:             IF USED("cursor_4c_BuscaProduto")
1602:                 USE IN cursor_4c_BuscaProduto
1603:             ENDIF
1604: 
1605:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
1606:                 SELECT cursor_4c_Dados
1607:                 LOCATE FOR ALLTRIM(cpros) == loc_cCodigo
1608:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1609:             ENDIF
1610: 
1611:         CATCH TO loException
1612:             IF USED("cursor_4c_BuscaProduto")
1613:                 USE IN cursor_4c_BuscaProduto
1614:             ENDIF
1615:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
1616:                 "FormProduto.BtnBuscarClick")
1617:         ENDTRY
1618:     ENDPROC
1619: 
1620:     *===========================================================================
1621:     * BtnEncerrarClick - Fecha o formulario
1622:     * PUBLIC: BINDEVENT requer metodo publico
1623:     *===========================================================================
1624:     PROCEDURE BtnEncerrarClick()
1625:         THIS.Release()
1626:     ENDPROC
1627: 
1628:     *===========================================================================
1629:     * LimparCampos - Limpa todos os campos de entrada do pgDados.Page1
1630:     *===========================================================================
1631:     PROTECTED PROCEDURE LimparCampos()
1632:         LOCAL loc_oPg, loException
1633:         TRY
1634:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1635:             WITH loc_oPg
1636:                 .txt_4c_Cpros.Value     = ""
1637:                 .txt_4c_Dpros.Value     = ""
1638:                 .txt_4c_Cbars.Value     = 0
1639:                 .opt_4c_Situacao.Value  = 1
1640:                 .txt_4c_DtSituas.Value  = {}
1641:                 .txt_4c_Cgrus.Value     = ""
1642:                 .txt_4c_Dgrus.Value     = ""
1643:                 .txt_4c_SGrus.Value     = ""
1644:                 .txt_4c_DsGrus.Value    = ""
1645:                 .txt_4c_Linhas.Value    = ""
1646:                 .txt_4c_DLinhas.Value   = ""
1647:                 .txt_4c_Obspes.Value    = ""
1648:                 .txt_4c_Obspeds.Value   = ""
1649:                 .txt_4c_Colecoes.Value  = ""
1650:                 .txt_4c_DColecoes.Value = ""
1651:                 .txt_4c_Ifors.Value     = ""
1652:                 .txt_4c_Dfors.Value     = ""
1653:                 .txt_4c_Reffs.Value     = ""
1654:                 .txt_4c_CodCors.Value   = ""
1655:                 .txt_4c_CodTams.Value   = ""
1656:                 .txt_4c_Custofs.Value   = 0
1657:                 .txt_4c_MoeCusfs.Value  = ""
1658:                 .txt_4c_Pvens.Value     = 0
1659:                 .txt_4c_Moevs.Value     = ""
1660:                 .txt_4c_Fvendas.Value   = 0
1661:                 .txt_4c_Moepvs.Value    = ""
1662:                 .txt_4c_CodAcbs.Value   = ""
1663:                 .txt_4c_DAcbs.Value     = ""
1664:                 .txt_4c_Cunis.Value     = ""
1665:                 .txt_4c_Dunis.Value     = ""
1666:                 .txt_4c_DtIncs.Value    = {}
1667:                 .txt_4c_DtAlts.Value    = {}
1668:             ENDWITH
1669:         CATCH TO loException
1670:             MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, ;
1671:                 "FormProduto.LimparCampos")
1672:         ENDTRY
1673:     ENDPROC
1674: 
1675:     *===========================================================================
1676:     * HabilitarCampos - Habilita/desabilita campos de entrada por modo
1677:     * par_lHabilitar=.T. em INCLUIR/ALTERAR, .F. em VISUALIZAR
1678:     *===========================================================================
1679:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1680:         LOCAL loc_oPg, loc_lModoIncluir, loException
1681:         TRY
1682:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1683:             loc_lModoIncluir = (THIS.this_cModoAtual == "INCLUIR")
1684: 
1685:             WITH loc_oPg
1686:                 *-- Codigo do produto: somente editavel em INCLUIR (PK nao pode mudar em ALTERAR)
1687:                 .txt_4c_Cpros.Enabled    = par_lHabilitar AND loc_lModoIncluir
1688:                 *-- Demais campos de entrada
1689:                 .txt_4c_Dpros.Enabled    = par_lHabilitar
1690:                 .txt_4c_Cbars.Enabled    = par_lHabilitar
1691:                 .opt_4c_Situacao.Enabled = par_lHabilitar
1692:                 .txt_4c_Cgrus.Enabled    = par_lHabilitar
1693:                 .txt_4c_SGrus.Enabled    = par_lHabilitar
1694:                 .txt_4c_Linhas.Enabled   = par_lHabilitar
1695:                 .txt_4c_Obspes.Enabled   = par_lHabilitar
1696:                 .txt_4c_Obspeds.Enabled  = par_lHabilitar
1697:                 .txt_4c_Colecoes.Enabled = par_lHabilitar
1698:                 .txt_4c_Ifors.Enabled    = par_lHabilitar
1699:                 .txt_4c_Reffs.Enabled    = par_lHabilitar
1700:                 .txt_4c_CodCors.Enabled  = par_lHabilitar
1701:                 .txt_4c_CodTams.Enabled  = par_lHabilitar
1702:                 .txt_4c_CodAcbs.Enabled  = par_lHabilitar
1703:                 .txt_4c_Cunis.Enabled    = par_lHabilitar
1704:             ENDWITH
1705: 
1706:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5)
1707:                 WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1708:                     .cmd_4c_Salvar.Enabled = par_lHabilitar
1709:                     .Visible     = .T.
1710:                 ENDWITH
1711:             ENDIF
1712: 
1713:         CATCH TO loException
1714:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
1715:                 "FormProduto.HabilitarCampos")
1716:         ENDTRY
1717:     ENDPROC
1718: 
1719:     *===========================================================================
1720:     * AjustarBotoesPorModo - Ajusta botoes por modo atual
1721:     *===========================================================================
1722:     PROCEDURE AjustarBotoesPorModo()
1723:         LOCAL loc_lEhLista
1724:         loc_lEhLista = (THIS.this_cModoAtual == "LISTA")
1725: 
1726:         TRY
1727:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
1728:                 WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1729:                     IF PEMSTATUS(.cmd_4c_Incluir, "Enabled", 5)
1730:                         .cmd_4c_Incluir.Enabled   = loc_lEhLista
1731:                         .cmd_4c_Alterar.Enabled   = loc_lEhLista
1732:                         .cmd_4c_Excluir.Enabled   = loc_lEhLista
1733:                         .cmd_4c_Visualizar.Enabled = loc_lEhLista
1734:                         .cmd_4c_Buscar.Enabled    = loc_lEhLista
1735:                     ENDIF
1736:                     .Visible     = .T.
1737:                 ENDWITH
1738:             ENDIF
1739:         CATCH TO loException
1740:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
1741:                 "FormProduto.AjustarBotoesPorModo")
1742:         ENDTRY
1743:     ENDPROC
1744: 
1745:     *===========================================================================
1746:     * FormParaBO - Transfere valores do pgDados.Page1 para o BO
1747:     *===========================================================================
1748:     PROTECTED PROCEDURE FormParaBO()
1749:         LOCAL loc_oPg, loc_oBO, loException
1750:         TRY
1751:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1752:             loc_oBO = THIS.this_oBusinessObject
1753: 
1754:             loc_oBO.this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
1755:             loc_oBO.this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpros.Value)
1756:             loc_oBO.this_nCbars    = loc_oPg.txt_4c_Cbars.Value
1757:             loc_oBO.this_nSituas   = loc_oPg.opt_4c_Situacao.Value
1758:             loc_oBO.this_cCgrus    = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
1759:             loc_oBO.this_cSgrus    = ALLTRIM(loc_oPg.txt_4c_SGrus.Value)
1760:             loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
1761:             loc_oBO.this_cObspes   = ALLTRIM(loc_oPg.txt_4c_Obspes.Value)
1762:             loc_oBO.this_cObspeds  = ALLTRIM(loc_oPg.txt_4c_Obspeds.Value)
1763:             loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
1764:             loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
1765:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Reffs.Value)
1766:             loc_oBO.this_cCodcors  = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)
1767:             loc_oBO.this_cCodtams  = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
1768:             loc_oBO.this_nCustofs  = loc_oPg.txt_4c_Custofs.Value
1769:             loc_oBO.this_nPvens    = loc_oPg.txt_4c_Pvens.Value
1770:             loc_oBO.this_nFvendas  = loc_oPg.txt_4c_Fvendas.Value
1771:             loc_oBO.this_cCodacbs  = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
1772:             loc_oBO.this_cCunis    = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
1773: 
1774:             *-- Campos da aba FaseP (Page4 de pgf_4c_Dados)
1775:             LOCAL loc_oPgFP
1776:             loc_oPgFP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
1777:             IF PEMSTATUS(loc_oPgFP, "txt_4c_QminFabs", 5)
1778:                 loc_oBO.this_nQtminfabs  = loc_oPgFP.txt_4c_QminFabs.Value
1779:                 loc_oBO.this_cCodgarras  = ALLTRIM(loc_oPgFP.txt_4c_CodGarras.Value)
1780:                 loc_oBO.this_cConquilhas = ALLTRIM(loc_oPgFP.txt_4c_Conquilhas.Value)
1781:                 loc_oBO.this_nPesobris   = loc_oPgFP.txt_4c_PesoBris.Value
1782:                 loc_oBO.this_nPesometal  = loc_oPgFP.txt_4c_PesoMetal.Value
1783:                 loc_oBO.this_nPesopdrs   = loc_oPgFP.txt_4c_PesoPdrs.Value
1784:                 loc_oBO.this_cCodcors    = ALLTRIM(loc_oPgFP.txt_4c_CodCorsFP.Value)
1785:                 loc_oBO.this_cCodtams    = ALLTRIM(loc_oPgFP.txt_4c_CodTamsFP.Value)
1786:                 loc_oBO.this_cCodacbs    = ALLTRIM(loc_oPgFP.txt_4c_CodAcbsFP.Value)
1787:                 loc_oBO.this_nCravcers   = IIF(loc_oPgFP.chk_4c_CravCera.Value = 1, 1, 0)
1788:                 loc_oBO.this_nVarias     = IIF(loc_oPgFP.chk_4c_Varias.Value = 1, 1, 0)
1789:                 loc_oBO.this_nDiasgar    = loc_oPgFP.txt_4c_DiasGar.Value
1790:                 loc_oBO.this_nTents      = loc_oPgFP.txt_4c_TEnts.Value
1791:                 loc_oBO.this_nVolumes    = loc_oPgFP.txt_4c_Volumes.Value
1792:                 loc_oBO.this_nLtminsv    = loc_oPgFP.txt_4c_LtMinsV.Value
1793:                 loc_oBO.this_nProdvars   = loc_oPgFP.opt_4c_Prodvars.Value
1794: 
1795:                 *-- Flush obs do EditBox para o cursor da linha selecionada antes de salvar
1796:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase") AND ;
1797:                         PEMSTATUS(loc_oPgFP, "edt_4c_Obs", 5)
1798:                     SELECT cursor_4c_GradFase
1799:                     REPLACE cursor_4c_GradFase.obs WITH loc_oPgFP.edt_4c_Obs.Value
1800:                 ENDIF
1801:             ENDIF
1802: 
1803:             *-- Campos da aba Dados Fiscais (Page3 de pgf_4c_Dados)
1804:             LOCAL loc_oPgFisc, loc_nIpiIdx
1805:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
1806:             IF PEMSTATUS(loc_oPgFisc, "txt_4c_Clfiscal", 5)
1807:                 loc_oBO.this_cClfiscals  = ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)
1808:                 loc_oBO.this_cOrigmercs  = ALLTRIM(loc_oPgFisc.txt_4c_Origmerc.Value)
1809:                 loc_oBO.this_cSittricms  = ALLTRIM(loc_oPgFisc.txt_4c_Sittricm.Value)
1810:                 loc_oBO.this_nIcms       = loc_oPgFisc.txt_4c_Icms.Value
1811:                 loc_oBO.this_cTptribs    = ALLTRIM(loc_oPgFisc.txt_4c_TpTrib.Value)
1812:                 loc_oBO.this_cIats       = ALLTRIM(loc_oPgFisc.txt_4c_Iat.Value)
1813:                 loc_oBO.this_nAliqipis   = loc_oPgFisc.txt_4c_AliqIPI.Value
1814:                 loc_oBO.this_cExtipi     = ALLTRIM(loc_oPgFisc.txt_4c_Extipi.Value)

*-- Linhas 1845 a 1888:
1845:     *===========================================================================
1846:     * BOParaForm - Transfere propriedades do BO para os campos do pgDados.Page1
1847:     *===========================================================================
1848:     PROTECTED PROCEDURE BOParaForm()
1849:         LOCAL loc_oPg, loc_oBO, loException
1850:         TRY
1851:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1852:             loc_oBO = THIS.this_oBusinessObject
1853: 
1854:             loc_oPg.txt_4c_Cpros.Value     = ALLTRIM(loc_oBO.this_cCpros)
1855:             loc_oPg.txt_4c_Dpros.Value     = ALLTRIM(loc_oBO.this_cDpros)
1856:             loc_oPg.txt_4c_Cbars.Value     = loc_oBO.this_nCbars
1857:             loc_oPg.opt_4c_Situacao.Value  = IIF(loc_oBO.this_nSituas = 1, 1, 2)
1858:             loc_oPg.txt_4c_DtSituas.Value  = IIF(EMPTY(loc_oBO.this_dDtsituas), {}, ;
1859:                 TTOD(loc_oBO.this_dDtsituas))
1860:             loc_oPg.txt_4c_Cgrus.Value     = ALLTRIM(loc_oBO.this_cCgrus)
1861:             loc_oPg.txt_4c_Dgrus.Value     = ""
1862:             loc_oPg.txt_4c_SGrus.Value     = ALLTRIM(loc_oBO.this_cSgrus)
1863:             loc_oPg.txt_4c_DsGrus.Value    = ""
1864:             loc_oPg.txt_4c_Linhas.Value    = ALLTRIM(loc_oBO.this_cLinhas)
1865:             loc_oPg.txt_4c_DLinhas.Value   = ""
1866:             loc_oPg.txt_4c_Obspes.Value    = ALLTRIM(loc_oBO.this_cObspes)
1867:             loc_oPg.txt_4c_Obspeds.Value   = ALLTRIM(loc_oBO.this_cObspeds)
1868:             loc_oPg.txt_4c_Colecoes.Value  = ALLTRIM(loc_oBO.this_cColecoes)
1869:             loc_oPg.txt_4c_DColecoes.Value = ""
1870:             loc_oPg.txt_4c_Ifors.Value     = ALLTRIM(loc_oBO.this_cIfors)
1871:             loc_oPg.txt_4c_Dfors.Value     = ""
1872:             loc_oPg.txt_4c_Reffs.Value     = ALLTRIM(loc_oBO.this_cReffs)
1873:             loc_oPg.txt_4c_CodCors.Value   = ALLTRIM(loc_oBO.this_cCodcors)
1874:             loc_oPg.txt_4c_CodTams.Value   = ALLTRIM(loc_oBO.this_cCodtams)
1875:             loc_oPg.txt_4c_Custofs.Value   = loc_oBO.this_nCustofs
1876:             loc_oPg.txt_4c_MoeCusfs.Value  = ALLTRIM(loc_oBO.this_cMoecusfs)
1877:             loc_oPg.txt_4c_Pvens.Value     = loc_oBO.this_nPvens
1878:             loc_oPg.txt_4c_Moevs.Value     = ALLTRIM(loc_oBO.this_cMoevs)
1879:             loc_oPg.txt_4c_Fvendas.Value   = loc_oBO.this_nFvendas
1880:             loc_oPg.txt_4c_Moepvs.Value    = ALLTRIM(loc_oBO.this_cMoepvs)
1881:             loc_oPg.txt_4c_CodAcbs.Value   = ALLTRIM(loc_oBO.this_cCodacbs)
1882:             loc_oPg.txt_4c_DAcbs.Value     = ""
1883:             loc_oPg.txt_4c_Cunis.Value     = ALLTRIM(loc_oBO.this_cCunis)
1884:             loc_oPg.txt_4c_Dunis.Value     = ""
1885:             loc_oPg.txt_4c_DtIncs.Value    = IIF(EMPTY(loc_oBO.this_dDtincs), {}, ;
1886:                 TTOD(loc_oBO.this_dDtincs))
1887:             loc_oPg.txt_4c_DtAlts.Value    = IIF(EMPTY(loc_oBO.this_dDtalts), {}, ;
1888:                 TTOD(loc_oBO.this_dDtalts))

*-- Linhas 1912 a 1932:
1912:                 loc_oPgFP.txt_4c_LtMinsV.Value     = loc_oBO.this_nLtminsv
1913:                 loc_oPgFP.txt_4c_DtUcp.Value       = IIF(EMPTY(loc_oBO.this_dUltcomps), "", ;
1914:                     TRANSFORM(TTOD(loc_oBO.this_dUltcomps), "@YL"))
1915:                 loc_oPgFP.txt_4c_VUcp.Value        = loc_oBO.this_nVultcomps
1916:                 loc_oPgFP.txt_4c_MUcp.Value        = ALLTRIM(loc_oBO.this_cMultcomps)
1917:                 loc_oPgFP.opt_4c_Prodvars.Value    = IIF(loc_oBO.this_nProdvars = 1, 1, 2)
1918:                 *-- Carregar grids de FaseP
1919:                 THIS.CarregarFaseP()
1920:                 *-- Carregar grid de Servicos (Page8)
1921:                 THIS.CarregarServicos()
1922:             ENDIF
1923: 
1924:             *-- Preencher controles da aba Dados Fiscais (Page3 de pgf_4c_Dados)
1925:             LOCAL loc_oPgFisc
1926:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
1927:             IF PEMSTATUS(loc_oPgFisc, "txt_4c_Clfiscal", 5)
1928:                 loc_oPgFisc.txt_4c_Clfiscal.Value    = ALLTRIM(loc_oBO.this_cClfiscals)
1929:                 loc_oPgFisc.txt_4c_Dclfiscal.Value   = ""
1930:                 loc_oPgFisc.txt_4c_Origmerc.Value    = ALLTRIM(loc_oBO.this_cOrigmercs)
1931:                 loc_oPgFisc.txt_4c_Dorigmerc.Value   = ""
1932:                 loc_oPgFisc.txt_4c_Sittricm.Value    = ALLTRIM(loc_oBO.this_cSittricms)

*-- Linhas 1973 a 2101:
1973: 
1974:     *===========================================================================
1975:     * BtnSalvarClick - Confirma e salva o produto
1976:     * PUBLIC: BINDEVENT requer metodo publico
1977:     *===========================================================================
1978:     PROCEDURE BtnSalvarClick()
1979:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1980:             RETURN
1981:         ENDIF
1982: 
1983:         IF !THIS.ValidarCampos()
1984:             RETURN
1985:         ENDIF
1986: 
1987:         THIS.FormParaBO()
1988: 
1989:         IF THIS.this_oBusinessObject.Salvar()
1990:             MsgInfo("Produto salvo com sucesso!")
1991:             THIS.AlternarPagina(1)
1992:         ENDIF
1993:     ENDPROC
1994: 
1995:     *===========================================================================
1996:     * BtnCancelarClick - Cancela e volta para lista
1997:     * PUBLIC: BINDEVENT requer metodo publico
1998:     *===========================================================================
1999:     PROCEDURE BtnCancelarClick()
2000:         THIS.AlternarPagina(1)
2001:         THIS.this_cModoAtual = "LISTA"
2002:         THIS.CarregarLista()
2003:     ENDPROC
2004: 
2005:     *===========================================================================
2006:     * Destroy - Libera recursos ao fechar o formulario
2007:     *===========================================================================
2008:     PROCEDURE Destroy()
2009:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2010:             THIS.this_oBusinessObject = .NULL.
2011:         ENDIF
2012: 
2013:         IF USED("cursor_4c_Dados")
2014:             USE IN cursor_4c_Dados
2015:         ENDIF
2016: 
2017:         IF USED("cursor_4c_BuscaProduto")
2018:             USE IN cursor_4c_BuscaProduto
2019:         ENDIF
2020: 
2021:         IF USED("cursor_4c_GrdCompo")
2022:             USE IN cursor_4c_GrdCompo
2023:         ENDIF
2024:         IF USED("cursor_4c_GrdSubCp")
2025:             USE IN cursor_4c_GrdSubCp
2026:         ENDIF
2027:         IF USED("cursor_4c_GrdRelogios")
2028:             USE IN cursor_4c_GrdRelogios
2029:         ENDIF
2030:         IF USED("TotGrupo")
2031:             USE IN TotGrupo
2032:         ENDIF
2033: 
2034:         IF USED("cursor_4c_GrdConsP")
2035:             USE IN cursor_4c_GrdConsP
2036:         ENDIF
2037:         IF USED("cursor_4c_GrDTEMP")
2038:             USE IN cursor_4c_GrDTEMP
2039:         ENDIF
2040:         IF USED("cursor_4c_GradFase")
2041:             USE IN cursor_4c_GradFase
2042:         ENDIF
2043:         IF USED("cursor_4c_GrdMatrizes")
2044:             USE IN cursor_4c_GrdMatrizes
2045:         ENDIF
2046:         IF USED("cursor_4c_TotGrupo2")
2047:             USE IN cursor_4c_TotGrupo2
2048:         ENDIF
2049: 
2050:         IF USED("cursor_4c_GrdServico")
2051:             USE IN cursor_4c_GrdServico
2052:         ENDIF
2053: 
2054:         DODEFAULT()
2055:     ENDPROC
2056: 
2057:     *===========================================================================
2058:     * CarregarDescricoes - Popula campos de descricao lookup (silencioso, sem dialog)
2059:     * Chamado de BOParaForm para carregar descricoes ao exibir registro existente
2060:     *===========================================================================
2061:     PROTECTED PROCEDURE CarregarDescricoes()
2062:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2063:         TRY
2064:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2065: 
2066:             *-- Grupo (SigCdGrp: cgrus/dgrus)
2067:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2068:             IF !EMPTY(loc_cCod)
2069:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2070:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
2071:                     "cursor_4c_LkpDesc")
2072:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2073:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpDesc.dgrus)
2074:                 ENDIF
2075:                 IF USED("cursor_4c_LkpDesc")
2076:                     USE IN cursor_4c_LkpDesc
2077:                 ENDIF
2078:             ENDIF
2079: 
2080:             *-- Linha (SigCdLin: linhas/descs)
2081:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
2082:             IF !EMPTY(loc_cCod)
2083:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2084:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
2085:                     "cursor_4c_LkpDesc")
2086:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2087:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
2088:                 ENDIF
2089:                 IF USED("cursor_4c_LkpDesc")
2090:                     USE IN cursor_4c_LkpDesc
2091:                 ENDIF
2092:             ENDIF
2093: 
2094:             *-- Colecao/Grupo de Venda (SigCdCol: colecoes/descs)
2095:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
2096:             IF !EMPTY(loc_cCod)
2097:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2098:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
2099:                     "cursor_4c_LkpDesc")
2100:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2101:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpDesc.descs)

*-- Linhas 2160 a 2203:
2160:     * CarregarDescricoesFiscais - Popula campos descricao da aba Dados Fiscais
2161:     * Chamado de BOParaForm ao exibir registro existente
2162:     *===========================================================================
2163:     PROTECTED PROCEDURE CarregarDescricoesFiscais()
2164:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2165:         TRY
2166:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
2167:             IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
2168:                 RETURN
2169:             ENDIF
2170: 
2171:             *-- Classificacao Fiscal (SigCdClf: codigos/descricaos)
2172:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
2173:             IF !EMPTY(loc_cCod)
2174:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2175:                     "SELECT descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
2176:                     "cursor_4c_LkpFiscDesc")
2177:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2178:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
2179:                 ENDIF
2180:                 IF USED("cursor_4c_LkpFiscDesc")
2181:                     USE IN cursor_4c_LkpFiscDesc
2182:                 ENDIF
2183:             ENDIF
2184: 
2185:             *-- Origem Mercadoria (SIGCDORG: codigos/descricaos)
2186:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
2187:             IF !EMPTY(loc_cCod)
2188:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2189:                     "SELECT descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
2190:                     "cursor_4c_LkpFiscDesc")
2191:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2192:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
2193:                 ENDIF
2194:                 IF USED("cursor_4c_LkpFiscDesc")
2195:                     USE IN cursor_4c_LkpFiscDesc
2196:                 ENDIF
2197:             ENDIF
2198: 
2199:             *-- Situacao Tributaria ICMS (SIGCDICM: codigos/descricaos)
2200:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
2201:             IF !EMPTY(loc_cCod)
2202:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2203:                     "SELECT descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;

*-- Linhas 2252 a 2812:
2252:     *===========================================================================
2253:     * ValidarCampos - Valida campos obrigatorios antes de salvar
2254:     *===========================================================================
2255:     PROTECTED PROCEDURE ValidarCampos()
2256:         LOCAL loc_oPg, loc_lValido, loException
2257:         loc_lValido = .F.
2258:         TRY
2259:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2260: 
2261:             IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cpros.Value))
2262:                 MsgAviso("C" + CHR(243) + "digo do produto " + CHR(233) + " obrigat" + CHR(243) + "rio!")
2263:                 loc_oPg.txt_4c_Cpros.SetFocus()
2264:             ELSE
2265:                 IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Dpros.Value))
2266:                     MsgAviso("Descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria!")
2267:                     loc_oPg.txt_4c_Dpros.SetFocus()
2268:                 ELSE
2269:                     loc_lValido = .T.
2270:                 ENDIF
2271:             ENDIF
2272:         CATCH TO loException
2273:             MostrarErro("Erro ao validar campos:" + CHR(13) + loException.Message, ;
2274:                 "FormProduto.ValidarCampos")
2275:         ENDTRY
2276:         RETURN loc_lValido
2277:     ENDPROC
2278: 
2279:     *===========================================================================
2280:     * TxtCgrusKeyPress - F4 abre busca de grupo
2281:     * PUBLIC: BINDEVENT requer metodo publico
2282:     * KeyDown nao e bindavel via BINDEVENT em VFP9 - usar KeyPress
2283:     * F4 em KeyPress: par_nKeyCode = 0 (teclas de funcao nao tem ASCII)
2284:     *===========================================================================
2285:     PROCEDURE TxtCgrusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2286:         IF par_nKeyCode = 0
2287:             THIS.AbrirBuscaGrupo()
2288:         ENDIF
2289:     ENDPROC
2290: 
2291:     *===========================================================================
2292:     * TxtIforsKeyPress - F4 abre busca de fornecedor
2293:     * PUBLIC: BINDEVENT requer metodo publico
2294:     * KeyDown nao e bindavel via BINDEVENT em VFP9 - usar KeyPress
2295:     *===========================================================================
2296:     PROCEDURE TxtIforsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2297:         IF par_nKeyCode = 0
2298:             THIS.AbrirBuscaFornecedor()
2299:         ENDIF
2300:     ENDPROC
2301: 
2302:     *===========================================================================
2303:     * ValidarCgrus - LostFocus: valida cgrus e popula dgrus (SigCdGrp)
2304:     * PUBLIC: BINDEVENT requer metodo publico
2305:     *===========================================================================
2306:     PROCEDURE ValidarCgrus(par_nKeyCode, par_nShiftAltCtrl)
2307:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2308:         TRY
2309:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2310:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2311: 
2312:             IF EMPTY(loc_cCod)
2313:                 loc_oPg.txt_4c_Dgrus.Value = ""
2314:             ELSE
2315:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2316:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
2317:                     "cursor_4c_LkpCgrus")
2318: 
2319:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCgrus") AND !EOF("cursor_4c_LkpCgrus")
2320:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpCgrus.dgrus)
2321:                     USE IN cursor_4c_LkpCgrus
2322:                 ELSE
2323:                     IF USED("cursor_4c_LkpCgrus")
2324:                         USE IN cursor_4c_LkpCgrus
2325:                     ENDIF
2326:                     loc_oPg.txt_4c_Cgrus.Value = ""
2327:                     loc_oPg.txt_4c_Dgrus.Value = ""
2328:                     THIS.AbrirBuscaGrupo()
2329:                 ENDIF
2330:             ENDIF
2331: 
2332:         CATCH TO loException
2333:             IF USED("cursor_4c_LkpCgrus")
2334:                 USE IN cursor_4c_LkpCgrus
2335:             ENDIF
2336:             MostrarErro("Erro ao validar grupo:" + CHR(13) + loException.Message, ;
2337:                 "FormProduto.ValidarCgrus")
2338:         ENDTRY
2339:     ENDPROC
2340: 
2341:     *===========================================================================
2342:     * ValidarSGrus - LostFocus: sgrus sem tabela de descricao, apenas aceita valor
2343:     * PUBLIC: BINDEVENT requer metodo publico
2344:     *===========================================================================
2345:     PROCEDURE ValidarSGrus(par_nKeyCode, par_nShiftAltCtrl)
2346:         LOCAL loc_oPg
2347:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2348:         loc_oPg.txt_4c_DsGrus.Value = ""
2349:     ENDPROC
2350: 
2351:     *===========================================================================
2352:     * ValidarLinhas - LostFocus: valida linhas e popula DLinhas (SigCdLin)
2353:     * PUBLIC: BINDEVENT requer metodo publico
2354:     *===========================================================================
2355:     PROCEDURE ValidarLinhas(par_nKeyCode, par_nShiftAltCtrl)
2356:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2357:         TRY
2358:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2359:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
2360: 
2361:             IF EMPTY(loc_cCod)
2362:                 loc_oPg.txt_4c_DLinhas.Value = ""
2363:             ELSE
2364:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2365:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
2366:                     "cursor_4c_LkpLinha")
2367: 
2368:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpLinha") AND !EOF("cursor_4c_LkpLinha")
2369:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpLinha.descs)
2370:                     USE IN cursor_4c_LkpLinha
2371:                 ELSE
2372:                     IF USED("cursor_4c_LkpLinha")
2373:                         USE IN cursor_4c_LkpLinha
2374:                     ENDIF
2375:                     loc_oPg.txt_4c_Linhas.Value  = ""
2376:                     loc_oPg.txt_4c_DLinhas.Value = ""
2377:                     MsgAviso("Linha n" + CHR(227) + "o encontrada.")
2378:                 ENDIF
2379:             ENDIF
2380: 
2381:         CATCH TO loException
2382:             IF USED("cursor_4c_LkpLinha")
2383:                 USE IN cursor_4c_LkpLinha
2384:             ENDIF
2385:             MostrarErro("Erro ao validar linha:" + CHR(13) + loException.Message, ;
2386:                 "FormProduto.ValidarLinhas")
2387:         ENDTRY
2388:     ENDPROC
2389: 
2390:     *===========================================================================
2391:     * ValidarColecoes - LostFocus: valida colecao e popula DColecoes (SigCdCol)
2392:     * PUBLIC: BINDEVENT requer metodo publico
2393:     *===========================================================================
2394:     PROCEDURE ValidarColecoes(par_nKeyCode, par_nShiftAltCtrl)
2395:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2396:         TRY
2397:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2398:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
2399: 
2400:             IF EMPTY(loc_cCod)
2401:                 loc_oPg.txt_4c_DColecoes.Value = ""
2402:             ELSE
2403:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2404:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
2405:                     "cursor_4c_LkpColecao")
2406: 
2407:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpColecao") AND !EOF("cursor_4c_LkpColecao")
2408:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpColecao.descs)
2409:                     USE IN cursor_4c_LkpColecao
2410:                 ELSE
2411:                     IF USED("cursor_4c_LkpColecao")
2412:                         USE IN cursor_4c_LkpColecao
2413:                     ENDIF
2414:                     loc_oPg.txt_4c_Colecoes.Value  = ""
2415:                     loc_oPg.txt_4c_DColecoes.Value = ""
2416:                     MsgAviso("Grupo de venda n" + CHR(227) + "o encontrado.")
2417:                 ENDIF
2418:             ENDIF
2419: 
2420:         CATCH TO loException
2421:             IF USED("cursor_4c_LkpColecao")
2422:                 USE IN cursor_4c_LkpColecao
2423:             ENDIF
2424:             MostrarErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
2425:                 loException.Message, "FormProduto.ValidarColecoes")
2426:         ENDTRY
2427:     ENDPROC
2428: 
2429:     *===========================================================================
2430:     * ValidarIfors - LostFocus: valida fornecedor e popula Dfors (SigCdFor)
2431:     * PUBLIC: BINDEVENT requer metodo publico
2432:     *===========================================================================
2433:     PROCEDURE ValidarIfors(par_nKeyCode, par_nShiftAltCtrl)
2434:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2435:         TRY
2436:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2437:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2438: 
2439:             IF EMPTY(loc_cCod)
2440:                 loc_oPg.txt_4c_Dfors.Value = ""
2441:             ELSE
2442:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2443:                     "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
2444:                     "cursor_4c_LkpForn")
2445: 
2446:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpForn") AND !EOF("cursor_4c_LkpForn")
2447:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpForn.dfors)
2448:                     USE IN cursor_4c_LkpForn
2449:                 ELSE
2450:                     IF USED("cursor_4c_LkpForn")
2451:                         USE IN cursor_4c_LkpForn
2452:                     ENDIF
2453:                     loc_oPg.txt_4c_Ifors.Value = ""
2454:                     loc_oPg.txt_4c_Dfors.Value = ""
2455:                     THIS.AbrirBuscaFornecedor()
2456:                 ENDIF
2457:             ENDIF
2458: 
2459:         CATCH TO loException
2460:             IF USED("cursor_4c_LkpForn")
2461:                 USE IN cursor_4c_LkpForn
2462:             ENDIF
2463:             MostrarErro("Erro ao validar fornecedor:" + CHR(13) + loException.Message, ;
2464:                 "FormProduto.ValidarIfors")
2465:         ENDTRY
2466:     ENDPROC
2467: 
2468:     *===========================================================================
2469:     * ValidarCodCors - LostFocus: valida codigo de cor (SigCdCor)
2470:     * PUBLIC: BINDEVENT requer metodo publico
2471:     *===========================================================================
2472:     PROCEDURE ValidarCodCors(par_nKeyCode, par_nShiftAltCtrl)
2473:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2474:         TRY
2475:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2476:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)
2477: 
2478:             IF !EMPTY(loc_cCod)
2479:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2480:                     "SELECT cods FROM SigCdCor WHERE cods = " + EscaparSQL(loc_cCod), ;
2481:                     "cursor_4c_LkpCor")
2482: 
2483:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCor") AND !EOF("cursor_4c_LkpCor")
2484:                     USE IN cursor_4c_LkpCor
2485:                 ELSE
2486:                     IF USED("cursor_4c_LkpCor")
2487:                         USE IN cursor_4c_LkpCor
2488:                     ENDIF
2489:                     loc_oPg.txt_4c_CodCors.Value = ""
2490:                     MsgAviso("Cor n" + CHR(227) + "o encontrada.")
2491:                 ENDIF
2492:             ENDIF
2493: 
2494:         CATCH TO loException
2495:             IF USED("cursor_4c_LkpCor")
2496:                 USE IN cursor_4c_LkpCor
2497:             ENDIF
2498:             MostrarErro("Erro ao validar cor:" + CHR(13) + loException.Message, ;
2499:                 "FormProduto.ValidarCodCors")
2500:         ENDTRY
2501:     ENDPROC
2502: 
2503:     *===========================================================================
2504:     * ValidarCodTams - LostFocus: valida codigo de tamanho (SigCdTam)
2505:     * PUBLIC: BINDEVENT requer metodo publico
2506:     *===========================================================================
2507:     PROCEDURE ValidarCodTams(par_nKeyCode, par_nShiftAltCtrl)
2508:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2509:         TRY
2510:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2511:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
2512: 
2513:             IF !EMPTY(loc_cCod)
2514:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2515:                     "SELECT cods FROM SigCdTam WHERE cods = " + EscaparSQL(loc_cCod), ;
2516:                     "cursor_4c_LkpTam")
2517: 
2518:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpTam") AND !EOF("cursor_4c_LkpTam")
2519:                     USE IN cursor_4c_LkpTam
2520:                 ELSE
2521:                     IF USED("cursor_4c_LkpTam")
2522:                         USE IN cursor_4c_LkpTam
2523:                     ENDIF
2524:                     loc_oPg.txt_4c_CodTams.Value = ""
2525:                     MsgAviso("Tamanho n" + CHR(227) + "o encontrado.")
2526:                 ENDIF
2527:             ENDIF
2528: 
2529:         CATCH TO loException
2530:             IF USED("cursor_4c_LkpTam")
2531:                 USE IN cursor_4c_LkpTam
2532:             ENDIF
2533:             MostrarErro("Erro ao validar tamanho:" + CHR(13) + loException.Message, ;
2534:                 "FormProduto.ValidarCodTams")
2535:         ENDTRY
2536:     ENDPROC
2537: 
2538:     *===========================================================================
2539:     * ValidarCodAcbs - LostFocus: valida acabamento e popula DAcbs (SigCdAca)
2540:     * PUBLIC: BINDEVENT requer metodo publico
2541:     *===========================================================================
2542:     PROCEDURE ValidarCodAcbs(par_nKeyCode, par_nShiftAltCtrl)
2543:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2544:         TRY
2545:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2546:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
2547: 
2548:             IF EMPTY(loc_cCod)
2549:                 loc_oPg.txt_4c_DAcbs.Value = ""
2550:             ELSE
2551:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2552:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
2553:                     "cursor_4c_LkpAcab")
2554: 
2555:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpAcab") AND !EOF("cursor_4c_LkpAcab")
2556:                     loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpAcab.descrs)
2557:                     USE IN cursor_4c_LkpAcab
2558:                 ELSE
2559:                     IF USED("cursor_4c_LkpAcab")
2560:                         USE IN cursor_4c_LkpAcab
2561:                     ENDIF
2562:                     loc_oPg.txt_4c_CodAcbs.Value = ""
2563:                     loc_oPg.txt_4c_DAcbs.Value   = ""
2564:                     MsgAviso("Acabamento n" + CHR(227) + "o encontrado.")
2565:                 ENDIF
2566:             ENDIF
2567: 
2568:         CATCH TO loException
2569:             IF USED("cursor_4c_LkpAcab")
2570:                 USE IN cursor_4c_LkpAcab
2571:             ENDIF
2572:             MostrarErro("Erro ao validar acabamento:" + CHR(13) + loException.Message, ;
2573:                 "FormProduto.ValidarCodAcbs")
2574:         ENDTRY
2575:     ENDPROC
2576: 
2577:     *===========================================================================
2578:     * ValidarCunis - LostFocus: valida unidade e popula Dunis (SigCdUni)
2579:     * PUBLIC: BINDEVENT requer metodo publico
2580:     *===========================================================================
2581:     PROCEDURE ValidarCunis(par_nKeyCode, par_nShiftAltCtrl)
2582:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2583:         TRY
2584:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2585:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
2586: 
2587:             IF EMPTY(loc_cCod)
2588:                 loc_oPg.txt_4c_Dunis.Value = ""
2589:             ELSE
2590:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2591:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
2592:                     "cursor_4c_LkpUni")
2593: 
2594:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpUni") AND !EOF("cursor_4c_LkpUni")
2595:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpUni.dunis)
2596:                     USE IN cursor_4c_LkpUni
2597:                 ELSE
2598:                     IF USED("cursor_4c_LkpUni")
2599:                         USE IN cursor_4c_LkpUni
2600:                     ENDIF
2601:                     loc_oPg.txt_4c_Cunis.Value = ""
2602:                     loc_oPg.txt_4c_Dunis.Value = ""
2603:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada.")
2604:                 ENDIF
2605:             ENDIF
2606: 
2607:         CATCH TO loException
2608:             IF USED("cursor_4c_LkpUni")
2609:                 USE IN cursor_4c_LkpUni
2610:             ENDIF
2611:             MostrarErro("Erro ao validar unidade:" + CHR(13) + loException.Message, ;
2612:                 "FormProduto.ValidarCunis")
2613:         ENDTRY
2614:     ENDPROC
2615: 
2616:     *===========================================================================
2617:     * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para selecionar grupo (SigCdGrp)
2618:     * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
2619:     *===========================================================================
2620:     PROCEDURE AbrirBuscaGrupo()
2621:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
2622:         TRY
2623:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2624:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2625: 
2626:             loc_nRet = SQLEXEC(gnConnHandle, ;
2627:                 "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus LIKE '" + ;
2628:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cgrus", ;
2629:                 "cursor_4c_GrpBusca")
2630: 
2631:             IF loc_nRet <= 0 OR !USED("cursor_4c_GrpBusca") OR EOF("cursor_4c_GrpBusca")
2632:                 IF USED("cursor_4c_GrpBusca")
2633:                     USE IN cursor_4c_GrpBusca
2634:                 ENDIF
2635:                 SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", ;
2636:                     "cursor_4c_GrpBusca")
2637:             ENDIF
2638: 
2639:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2640:             IF VARTYPE(loc_oBusca) = "O"
2641:                 loc_oBusca.this_cCursorDestino = "cursor_4c_GrpBusca"
2642:                 loc_oBusca.DefinirCursor("cursor_4c_GrpBusca", "cgrus", "dgrus", ;
2643:                     "Buscar Grupo de Produto")
2644:                 loc_oBusca.Mostrar()
2645: 
2646:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2647:                     loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2648:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2649:                 ENDIF
2650:                 loc_oBusca = .NULL.
2651:             ENDIF
2652: 
2653:             IF USED("cursor_4c_GrpBusca")
2654:                 USE IN cursor_4c_GrpBusca
2655:             ENDIF
2656: 
2657:         CATCH TO loException
2658:             IF USED("cursor_4c_GrpBusca")
2659:                 USE IN cursor_4c_GrpBusca
2660:             ENDIF
2661:             MostrarErro("Erro ao buscar grupo:" + CHR(13) + loException.Message, ;
2662:                 "FormProduto.AbrirBuscaGrupo")
2663:         ENDTRY
2664:     ENDPROC
2665: 
2666:     *===========================================================================
2667:     * AbrirBuscaFornecedor - Abre FormBuscaAuxiliar para selecionar fornecedor
2668:     * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
2669:     *===========================================================================
2670:     PROCEDURE AbrirBuscaFornecedor()
2671:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
2672:         TRY
2673:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2674:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2675: 
2676:             loc_nRet = SQLEXEC(gnConnHandle, ;
2677:                 "SELECT ifors, dfors FROM SigCdFor WHERE ifors LIKE '" + ;
2678:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY dfors", ;
2679:                 "cursor_4c_FornBusca")
2680: 
2681:             IF loc_nRet <= 0 OR !USED("cursor_4c_FornBusca") OR EOF("cursor_4c_FornBusca")
2682:                 IF USED("cursor_4c_FornBusca")
2683:                     USE IN cursor_4c_FornBusca
2684:                 ENDIF
2685:                 SQLEXEC(gnConnHandle, "SELECT ifors, dfors FROM SigCdFor ORDER BY dfors", ;
2686:                     "cursor_4c_FornBusca")
2687:             ENDIF
2688: 
2689:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2690:             IF VARTYPE(loc_oBusca) = "O"
2691:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FornBusca"
2692:                 loc_oBusca.DefinirCursor("cursor_4c_FornBusca", "ifors", "dfors", ;
2693:                     "Buscar Fornecedor")
2694:                 loc_oBusca.Mostrar()
2695: 
2696:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2697:                     loc_oPg.txt_4c_Ifors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2698:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2699:                 ENDIF
2700:                 loc_oBusca = .NULL.
2701:             ENDIF
2702: 
2703:             IF USED("cursor_4c_FornBusca")
2704:                 USE IN cursor_4c_FornBusca
2705:             ENDIF
2706: 
2707:         CATCH TO loException
2708:             IF USED("cursor_4c_FornBusca")
2709:                 USE IN cursor_4c_FornBusca
2710:             ENDIF
2711:             MostrarErro("Erro ao buscar fornecedor:" + CHR(13) + loException.Message, ;
2712:                 "FormProduto.AbrirBuscaFornecedor")
2713:         ENDTRY
2714:     ENDPROC
2715: 
2716:     *===========================================================================
2717:     * OptSituacaoInteractiveChange - Atualiza DtSituas ao mudar Situacao
2718:     * PUBLIC: BINDEVENT requer metodo publico
2719:     *===========================================================================
2720:     PROCEDURE OptSituacaoInteractiveChange()
2721:         LOCAL loc_oPg, loException
2722:         TRY
2723:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2724:             IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
2725:                 loc_oPg.txt_4c_DtSituas.Value = DATE()
2726:             ENDIF
2727:         CATCH TO loException
2728:             MostrarErro("Erro ao atualizar data da situa" + CHR(231) + CHR(227) + "o:" + ;
2729:                 CHR(13) + loException.Message, "FormProduto.OptSituacaoInteractiveChange")
2730:         ENDTRY
2731:     ENDPROC
2732: 
2733:     *===========================================================================
2734:     * ConfigurarPgpgDadosFiscais - Configura Page3 "Dados Fiscais" do pgf_4c_Dados
2735:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais
2736:     * 64 objetos: labels, textboxes, editbox, combobox, optiongroup, grid, button
2737:     *===========================================================================
2738:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais(par_oPg)
2739:         LOCAL loc_oPg, loc_oGrid, loc_oErro
2740:         TRY
2741:             loc_oPg = par_oPg
2742:             loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
2743: 
2744:             *-- Cursor placeholder para grd_4c_Cmv (RecordSource = TotGrupo2)
2745:             IF !USED("cursor_4c_TotGrupo2")
2746:                 CREATE CURSOR cursor_4c_TotGrupo2 ( ;
2747:                     Grupo    C(3), ValGrupo N(12,3), Moeda C(3), Estimado N(1,0))
2748:             ENDIF
2749: 
2750:             *====================================================================
2751:             *  SECAO: Configuracao / Tipo produto (topo)
2752:             *====================================================================
2753: 
2754:             *-- lbl_4c_Label29: "Configuracao :" (Say29, top=128, left=129)
2755:             loc_oPg.AddObject("lbl_4c_Label29", "Label")
2756:             WITH loc_oPg.lbl_4c_Label29
2757:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o :"
2758:                 .Top       = 128
2759:                 .Left      = 129
2760:                 .Width     = 73
2761:                 .Height    = 15
2762:                 .FontName  = "Tahoma"
2763:                 .FontSize  = 8
2764:                 .ForeColor = RGB(90, 90, 90)
2765:                 .BackStyle = 0
2766:                 .AutoSize  = .T.
2767:                 .Visible   = .T.
2768:             ENDWITH
2769: 
2770:             *-- obj_4c_Fwoption1: OptionGroup "Importado / Nacional" (Fwoption1, top=123, left=204)
2771:             *-- ControlSource: TpCodPro (nao existe no schema atual - UI-only)
2772:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
2773:             WITH loc_oPg.obj_4c_Fwoption1
2774:                 .ButtonCount  = 2
2775:                 .Top          = 123
2776:                 .Left         = 204
2777:                 .Width        = 151
2778:                 .Height       = 24
2779:                 .BackStyle    = 0
2780:                 .BorderStyle  = 0
2781:                 .Value        = 1
2782:                 .AutoSize     = .F.
2783:                 .Visible      = .T.
2784: 
2785:                 .Buttons(1).Caption   = "Importado"
2786:                 .Buttons(1).FontName  = "Tahoma"
2787:                 .Buttons(1).FontSize  = 8
2788:                 .Buttons(1).ForeColor = RGB(90, 90, 90)
2789:                 .Buttons(1).BackStyle = 0
2790:                 .Buttons(1).Left      = 5
2791:                 .Buttons(1).Top       = 5
2792:                 .Buttons(1).Height    = 15
2793:                 .Buttons(1).AutoSize  = .T.
2794: 
2795:                 .Buttons(2).Caption   = "Nacional"
2796:                 .Buttons(2).FontName  = "Tahoma"
2797:                 .Buttons(2).FontSize  = 8
2798:                 .Buttons(2).ForeColor = RGB(90, 90, 90)
2799:                 .Buttons(2).BackStyle = 0
2800:                 .Buttons(2).Left      = 86
2801:                 .Buttons(2).Top       = 5
2802:                 .Buttons(2).Height    = 15
2803:                 .Buttons(2).AutoSize  = .T.
2804:             ENDWITH
2805: 
2806:             *====================================================================
2807:             *  SECAO: Codigo Importado / Nacional / DCR
2808:             *====================================================================
2809: 
2810:             *-- lbl_4c_Label14: "Codigo Importado :" (Say14, top=154, left=107)
2811:             loc_oPg.AddObject("lbl_4c_Label14", "Label")
2812:             WITH loc_oPg.lbl_4c_Label14

*-- Linhas 2954 a 3238:
2954:                 .SpecialEffect = 1
2955:                 .Visible       = .T.
2956:             ENDWITH
2957:             BINDEVENT(loc_oPg.txt_4c__gruccus, "LostFocus",    THIS, "TxtGruccusValid")
2958:             BINDEVENT(loc_oPg.txt_4c__gruccus, "KeyPress", THIS, "TxtGruccusKeyPress")
2959: 
2960:             *-- txt_4c__dgruccus: Descricao Grupo CC (get_dgruccus, top=225, left=288)
2961:             loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
2962:             WITH loc_oPg.txt_4c__dgruccus
2963:                 .Top           = 225
2964:                 .Left          = 288
2965:                 .Width         = 318
2966:                 .Height        = 23
2967:                 .FontName      = "Tahoma"
2968:                 .FontSize      = 8
2969:                 .SpecialEffect = 1
2970:                 .Visible       = .T.
2971:             ENDWITH
2972:             BINDEVENT(loc_oPg.txt_4c__dgruccus, "When",    THIS, "TxtDgruccusWhen")
2973:             BINDEVENT(loc_oPg.txt_4c__dgruccus, "LostFocus",   THIS, "TxtDgruccusValid")
2974:             BINDEVENT(loc_oPg.txt_4c__dgruccus, "KeyPress",THIS, "TxtDgruccusKeyPress")
2975: 
2976:             *-- lbl_4c_Label17: "Conta C.C. :" (Say17, top=253, left=139)
2977:             loc_oPg.AddObject("lbl_4c_Label17", "Label")
2978:             WITH loc_oPg.lbl_4c_Label17
2979:                 .Caption   = "Conta C.C. :"
2980:                 .Top       = 253
2981:                 .Left      = 139
2982:                 .Width     = 63
2983:                 .Height    = 15
2984:                 .FontName  = "Tahoma"
2985:                 .FontSize  = 8
2986:                 .ForeColor = RGB(90, 90, 90)
2987:                 .BackStyle = 0
2988:                 .AutoSize  = .T.
2989:                 .Visible   = .T.
2990:             ENDWITH
2991: 
2992:             *-- txt_4c__contaccus: Conta CC (get_contaccus, top=250, left=206)
2993:             loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
2994:             WITH loc_oPg.txt_4c__contaccus
2995:                 .Top           = 250
2996:                 .Left          = 206
2997:                 .Width         = 80
2998:                 .Height        = 23
2999:                 .FontName      = "Tahoma"
3000:                 .FontSize      = 8
3001:                 .SpecialEffect = 1
3002:                 .Visible       = .T.
3003:             ENDWITH
3004:             BINDEVENT(loc_oPg.txt_4c__contaccus, "When",    THIS, "TxtContaccusWhen")
3005:             BINDEVENT(loc_oPg.txt_4c__contaccus, "LostFocus",   THIS, "TxtContaccusValid")
3006:             BINDEVENT(loc_oPg.txt_4c__contaccus, "KeyPress",THIS, "TxtContaccusKeyPress")
3007: 
3008:             *-- txt_4c__dcontaccus: Descricao Conta CC (get_dcontaccus, top=250, left=288)
3009:             loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
3010:             WITH loc_oPg.txt_4c__dcontaccus
3011:                 .Top           = 250
3012:                 .Left          = 288
3013:                 .Width         = 318
3014:                 .Height        = 23
3015:                 .FontName      = "Tahoma"
3016:                 .FontSize      = 8
3017:                 .SpecialEffect = 1
3018:                 .Visible       = .T.
3019:             ENDWITH
3020:             BINDEVENT(loc_oPg.txt_4c__dcontaccus, "When",    THIS, "TxtDcontaccusWhen")
3021:             BINDEVENT(loc_oPg.txt_4c__dcontaccus, "LostFocus",   THIS, "TxtDcontaccusValid")
3022:             BINDEVENT(loc_oPg.txt_4c__dcontaccus, "KeyPress",THIS, "TxtDcontaccusKeyPress")
3023: 
3024:             *====================================================================
3025:             *  SECAO: Classificacao Fiscal / Origem Mercadoria / ICMS
3026:             *====================================================================
3027: 
3028:             *-- lbl_4c_Label1: "Classificacao Fiscal :" (Say1, top=280, left=103)
3029:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
3030:             WITH loc_oPg.lbl_4c_Label1
3031:                 .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
3032:                 .Top       = 280
3033:                 .Left      = 103
3034:                 .Width     = 99
3035:                 .FontName  = "Tahoma"
3036:                 .FontSize  = 8
3037:                 .ForeColor = RGB(90, 90, 90)
3038:                 .BackStyle = 0
3039:                 .AutoSize  = .T.
3040:                 .Visible   = .T.
3041:             ENDWITH
3042: 
3043:             *-- txt_4c_Clfiscal: Classificacao Fiscal (getClfiscal, top=275, left=206)
3044:             loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
3045:             WITH loc_oPg.txt_4c_Clfiscal
3046:                 .Top           = 275
3047:                 .Left          = 206
3048:                 .Width         = 94
3049:                 .Height        = 23
3050:                 .FontName      = "Tahoma"
3051:                 .FontSize      = 8
3052:                 .SpecialEffect = 1
3053:                 .MaxLength     = 10
3054:                 .Visible       = .T.
3055:             ENDWITH
3056:             BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress",    THIS, "ValidarClfiscal")
3057:             BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TxtClfiscalKeyPress")
3058: 
3059:             *-- txt_4c_Dclfiscal: Descricao Classificacao Fiscal (getDclfiscal, top=275, left=303)
3060:             loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
3061:             WITH loc_oPg.txt_4c_Dclfiscal
3062:                 .Top           = 275
3063:                 .Left          = 303
3064:                 .Width         = 303
3065:                 .Height        = 23
3066:                 .FontName      = "Tahoma"
3067:                 .FontSize      = 8
3068:                 .SpecialEffect = 1
3069:                 .Visible       = .T.
3070:             ENDWITH
3071:             BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "When",    THIS, "TxtDclfiscalWhen")
3072:             BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress",   THIS, "ValidarDclfiscal")
3073:             BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress",THIS, "TxtDclfiscalKeyPress")
3074: 
3075:             *-- lbl_4c_Label2: "Origem da Mercadoria :" (Say2, top=305, left=88)
3076:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
3077:             WITH loc_oPg.lbl_4c_Label2
3078:                 .Caption   = "Origem da Mercadoria :"
3079:                 .Top       = 305
3080:                 .Left      = 88
3081:                 .Width     = 114
3082:                 .FontName  = "Tahoma"
3083:                 .FontSize  = 8
3084:                 .ForeColor = RGB(90, 90, 90)
3085:                 .BackStyle = 0
3086:                 .AutoSize  = .T.
3087:                 .Visible   = .T.
3088:             ENDWITH
3089: 
3090:             *-- txt_4c_Origmerc: Origem Mercadoria (getOrigmerc, top=300, left=206)
3091:             loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
3092:             WITH loc_oPg.txt_4c_Origmerc
3093:                 .Top           = 300
3094:                 .Left          = 206
3095:                 .Width         = 17
3096:                 .Height        = 23
3097:                 .FontName      = "Tahoma"
3098:                 .FontSize      = 8
3099:                 .SpecialEffect = 1
3100:                 .MaxLength     = 1
3101:                 .Visible       = .T.
3102:             ENDWITH
3103:             BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress",    THIS, "ValidarOrigmerc")
3104:             BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress", THIS, "TxtOrigmercKeyPress")
3105: 
3106:             *-- txt_4c_Dorigmerc: Descricao Origem (getDorigmerc, top=300, left=226)
3107:             loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
3108:             WITH loc_oPg.txt_4c_Dorigmerc
3109:                 .Top           = 300
3110:                 .Left          = 226
3111:                 .Width         = 380
3112:                 .Height        = 23
3113:                 .FontName      = "Tahoma"
3114:                 .FontSize      = 8
3115:                 .SpecialEffect = 1
3116:                 .Visible       = .T.
3117:             ENDWITH
3118:             BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "When",    THIS, "TxtDorigmercWhen")
3119:             BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress",   THIS, "ValidarDorigmerc")
3120:             BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress",THIS, "TxtDorigmercKeyPress")
3121: 
3122:             *-- lbl_4c_Label3: "Situacao Tributaria ICMS :" (Say3, top=330, left=75)
3123:             loc_oPg.AddObject("lbl_4c_Label3", "Label")
3124:             WITH loc_oPg.lbl_4c_Label3
3125:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
3126:                 .Top       = 330
3127:                 .Left      = 75
3128:                 .Width     = 127
3129:                 .FontName  = "Tahoma"
3130:                 .FontSize  = 8
3131:                 .ForeColor = RGB(90, 90, 90)
3132:                 .BackStyle = 0
3133:                 .AutoSize  = .T.
3134:                 .Visible   = .T.
3135:             ENDWITH
3136: 
3137:             *-- txt_4c_Sittricm: Situacao Tributaria ICMS (getSittricm, top=325, left=206)
3138:             loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
3139:             WITH loc_oPg.txt_4c_Sittricm
3140:                 .Top           = 325
3141:                 .Left          = 206
3142:                 .Width         = 31
3143:                 .Height        = 23
3144:                 .FontName      = "Tahoma"
3145:                 .FontSize      = 8
3146:                 .SpecialEffect = 1
3147:                 .MaxLength     = 3
3148:                 .Visible       = .T.
3149:             ENDWITH
3150:             BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress",    THIS, "ValidarSittricm")
3151:             BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress", THIS, "TxtSittricmKeyPress")
3152: 
3153:             *-- txt_4c_Dsittricm: Descricao Situacao ICMS (getDsittricm, top=325, left=240)
3154:             loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
3155:             WITH loc_oPg.txt_4c_Dsittricm
3156:                 .Top           = 325
3157:                 .Left          = 240
3158:                 .Width         = 366
3159:                 .Height        = 23
3160:                 .FontName      = "Tahoma"
3161:                 .FontSize      = 8
3162:                 .SpecialEffect = 1
3163:                 .Visible       = .T.
3164:             ENDWITH
3165:             BINDEVENT(loc_oPg.txt_4c_Dsittricm, "When",    THIS, "TxtDsittricmWhen")
3166:             BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress",   THIS, "ValidarDsittricm")
3167:             BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress",THIS, "TxtDsittricmKeyPress")
3168: 
3169:             *-- lbl_4c_Label6: "Codigo de Servicos para ICMS :" (Say6, top=355, left=49)
3170:             loc_oPg.AddObject("lbl_4c_Label6", "Label")
3171:             WITH loc_oPg.lbl_4c_Label6
3172:                 .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
3173:                 .Top       = 355
3174:                 .Left      = 49
3175:                 .Width     = 153
3176:                 .FontName  = "Tahoma"
3177:                 .FontSize  = 8
3178:                 .ForeColor = RGB(90, 90, 90)
3179:                 .BackStyle = 0
3180:                 .AutoSize  = .T.
3181:                 .Visible   = .T.
3182:             ENDWITH
3183: 
3184:             *-- txt_4c_Codigo: Codigo Servicos (Get_CodServs, top=350, left=206)
3185:             loc_oPg.AddObject("txt_4c_Codigo", "TextBox")
3186:             WITH loc_oPg.txt_4c_Codigo
3187:                 .Top           = 350
3188:                 .Left          = 206
3189:                 .Width         = 38
3190:                 .Height        = 23
3191:                 .FontName      = "Tahoma"
3192:                 .FontSize      = 8
3193:                 .SpecialEffect = 1
3194:                 .MaxLength     = 4
3195:                 .Visible       = .T.
3196:             ENDWITH
3197:             BINDEVENT(loc_oPg.txt_4c_Codigo, "KeyPress",    THIS, "ValidarCodServsFiscal")
3198:             BINDEVENT(loc_oPg.txt_4c_Codigo, "KeyPress", THIS, "TxtCodServsFiscalKeyPress")
3199: 
3200:             *-- lbl_4c_Label8: "Aliquota ICMS :" (Say8, top=355, left=263)
3201:             loc_oPg.AddObject("lbl_4c_Label8", "Label")
3202:             WITH loc_oPg.lbl_4c_Label8
3203:                 .Caption   = "Al" + CHR(237) + "quota ICMS :"
3204:                 .Top       = 355
3205:                 .Left      = 263
3206:                 .Width     = 76
3207:                 .Height    = 15
3208:                 .FontName  = "Tahoma"
3209:                 .FontSize  = 8
3210:                 .ForeColor = RGB(90, 90, 90)
3211:                 .BackStyle = 0
3212:                 .AutoSize  = .T.
3213:                 .Visible   = .T.
3214:             ENDWITH
3215: 
3216:             *-- txt_4c_Icms: Aliquota ICMS (getIcms, top=350, left=342)
3217:             loc_oPg.AddObject("txt_4c_Icms", "TextBox")
3218:             WITH loc_oPg.txt_4c_Icms
3219:                 .Top           = 350
3220:                 .Left          = 342
3221:                 .Width         = 45
3222:                 .Height        = 23
3223:                 .FontName      = "Tahoma"
3224:                 .FontSize      = 8
3225:                 .SpecialEffect = 1
3226:                 .InputMask     = "99.99"
3227:                 .Value         = 0
3228:                 .Visible       = .T.
3229:             ENDWITH
3230: 
3231:             *-- lbl_4c_Label4: "Tipo de Tributacao :" (Say4, top=355, left=411)
3232:             loc_oPg.AddObject("lbl_4c_Label4", "Label")
3233:             WITH loc_oPg.lbl_4c_Label4
3234:                 .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
3235:                 .Top       = 355
3236:                 .Left      = 411
3237:                 .Width     = 98
3238:                 .FontName  = "Tahoma"

*-- Linhas 3256 a 3332:
3256:                 .MaxLength     = 4
3257:                 .Visible       = .T.
3258:             ENDWITH
3259:             BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress",    THIS, "ValidarTpTrib")
3260:             BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress", THIS, "TxtTpTribKeyPress")
3261: 
3262:             *-- lbl_4c_Label41: "IAT :" (Say41, top=354, left=558)
3263:             loc_oPg.AddObject("lbl_4c_Label41", "Label")
3264:             WITH loc_oPg.lbl_4c_Label41
3265:                 .Caption   = "IAT :"
3266:                 .Top       = 354
3267:                 .Left      = 558
3268:                 .Width     = 26
3269:                 .Height    = 15
3270:                 .FontName  = "Tahoma"
3271:                 .FontSize  = 8
3272:                 .ForeColor = RGB(90, 90, 90)
3273:                 .BackStyle = 0
3274:                 .AutoSize  = .T.
3275:                 .Visible   = .T.
3276:             ENDWITH
3277: 
3278:             *-- txt_4c_Iat: IAT - Indicador Arredondamento/Truncamento (getiat, top=350, left=589)
3279:             loc_oPg.AddObject("txt_4c_Iat", "TextBox")
3280:             WITH loc_oPg.txt_4c_Iat
3281:                 .Top           = 350
3282:                 .Left          = 589
3283:                 .Width         = 17
3284:                 .Height        = 23
3285:                 .FontName      = "Tahoma"
3286:                 .FontSize      = 8
3287:                 .SpecialEffect = 1
3288:                 .MaxLength     = 1
3289:                 .Visible       = .T.
3290:             ENDWITH
3291:             BINDEVENT(loc_oPg.txt_4c_Iat, "KeyPress",    THIS, "ValidarIat")
3292:             BINDEVENT(loc_oPg.txt_4c_Iat, "KeyPress", THIS, "TxtIatKeyPress")
3293: 
3294:             *-- lbl_4c_Label42: "[A]rredondamento [T]runcamento" (Say42, top=354, left=609)
3295:             loc_oPg.AddObject("lbl_4c_Label42", "Label")
3296:             WITH loc_oPg.lbl_4c_Label42
3297:                 .Caption   = "[A]rredondamento [T]runcamento"
3298:                 .Top       = 354
3299:                 .Left      = 609
3300:                 .Width     = 165
3301:                 .Height    = 15
3302:                 .FontName  = "Tahoma"
3303:                 .FontSize  = 8
3304:                 .ForeColor = RGB(90, 90, 90)
3305:                 .BackStyle = 0
3306:                 .AutoSize  = .T.
3307:                 .Visible   = .T.
3308:             ENDWITH
3309: 
3310:             *====================================================================
3311:             *  SECAO: IPI (Situacao Tributaria / Aliquota / Excecao TIPI)
3312:             *====================================================================
3313: 
3314:             *-- lbl_4c_Label5: "Situacao Tributaria IPI :" (Say5, top=380, left=86)
3315:             loc_oPg.AddObject("lbl_4c_Label5", "Label")
3316:             WITH loc_oPg.lbl_4c_Label5
3317:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
3318:                 .Top       = 380
3319:                 .Left      = 86
3320:                 .Width     = 116
3321:                 .Height    = 15
3322:                 .FontName  = "Tahoma"
3323:                 .FontSize  = 8
3324:                 .ForeColor = RGB(90, 90, 90)
3325:                 .BackStyle = 0
3326:                 .AutoSize  = .T.
3327:                 .Visible   = .T.
3328:             ENDWITH
3329: 
3330:             *-- cbo_4c_CmbIpi: Situacao Tributaria IPI combo (cmbIpi, top=375, left=206)
3331:             *-- Itens: "", "Tributado" (T), "Isento" (I), "Outros" (O)
3332:             loc_oPg.AddObject("cbo_4c_CmbIpi", "ComboBox")

*-- Linhas 3346 a 3454:
3346:             loc_oPg.cbo_4c_CmbIpi.AddItem("\<" + PADR("Tributado", 9))
3347:             loc_oPg.cbo_4c_CmbIpi.AddItem("\<" + PADR("Isento", 9))
3348:             loc_oPg.cbo_4c_CmbIpi.AddItem("\<" + PADR("Outros", 9))
3349:             BINDEVENT(loc_oPg.cbo_4c_CmbIpi, "When", THIS, "CboIpiWhen")
3350: 
3351:             *-- lbl_4c__AliqIPI: "Aliquota de IPI :" (Say_AliqIPI, top=380, left=340)
3352:             loc_oPg.AddObject("lbl_4c__AliqIPI", "Label")
3353:             WITH loc_oPg.lbl_4c__AliqIPI
3354:                 .Caption   = "Al" + CHR(237) + "quota de IPI :"
3355:                 .Top       = 380
3356:                 .Left      = 340
3357:                 .Width     = 80
3358:                 .Height    = 15
3359:                 .FontName  = "Tahoma"
3360:                 .FontSize  = 8
3361:                 .ForeColor = RGB(90, 90, 90)
3362:                 .BackStyle = 0
3363:                 .AutoSize  = .T.
3364:                 .Visible   = .T.
3365:             ENDWITH
3366: 
3367:             *-- txt_4c_AliqIPI: Aliquota IPI (Get_AliqIPI, top=375, left=425)
3368:             loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
3369:             WITH loc_oPg.txt_4c_AliqIPI
3370:                 .Top           = 375
3371:                 .Left          = 425
3372:                 .Width         = 45
3373:                 .Height        = 25
3374:                 .FontName      = "Tahoma"
3375:                 .FontSize      = 8
3376:                 .SpecialEffect = 1
3377:                 .InputMask     = "99.99"
3378:                 .Value         = 0
3379:                 .Visible       = .T.
3380:             ENDWITH
3381:             BINDEVENT(loc_oPg.txt_4c_AliqIPI, "KeyPress",    THIS, "ValidarAliqIPI")
3382:             BINDEVENT(loc_oPg.txt_4c_AliqIPI, "KeyPress", THIS, "TxtAliqIPIKeyPress")
3383: 
3384:             *-- lbl_4c_Label13: "Excecao da TIPI :" (Say13, top=380, left=511)
3385:             loc_oPg.AddObject("lbl_4c_Label13", "Label")
3386:             WITH loc_oPg.lbl_4c_Label13
3387:                 .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
3388:                 .Top       = 380
3389:                 .Left      = 511
3390:                 .Width     = 87
3391:                 .Height    = 15
3392:                 .FontName  = "Tahoma"
3393:                 .FontSize  = 8
3394:                 .ForeColor = RGB(90, 90, 90)
3395:                 .BackStyle = 0
3396:                 .AutoSize  = .T.
3397:                 .Visible   = .T.
3398:             ENDWITH
3399: 
3400:             *-- txt_4c_Extipi: Excecao TIPI (getextipi, top=375, left=601)
3401:             *-- When: enabled only when SigCdClf.IpiProds = 'S'
3402:             loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
3403:             WITH loc_oPg.txt_4c_Extipi
3404:                 .Top           = 375
3405:                 .Left          = 601
3406:                 .Width         = 35
3407:                 .Height        = 25
3408:                 .FontName      = "Tahoma"
3409:                 .FontSize      = 8
3410:                 .SpecialEffect = 1
3411:                 .MaxLength     = 3
3412:                 .Visible       = .T.
3413:             ENDWITH
3414:             BINDEVENT(loc_oPg.txt_4c_Extipi, "When", THIS, "TxtExtipipWhen")
3415: 
3416:             *====================================================================
3417:             *  SECAO: Descricao Fiscal (memo) + Botao gerar descricao
3418:             *====================================================================
3419: 
3420:             *-- lbl_4c_Label18: "Descricao Fiscal :" (Say18, top=405, left=118)
3421:             loc_oPg.AddObject("lbl_4c_Label18", "Label")
3422:             WITH loc_oPg.lbl_4c_Label18
3423:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
3424:                 .Top       = 405
3425:                 .Left      = 118
3426:                 .Width     = 84
3427:                 .Height    = 15
3428:                 .FontName  = "Tahoma"
3429:                 .FontSize  = 8
3430:                 .ForeColor = RGB(90, 90, 90)
3431:                 .BackStyle = 0
3432:                 .AutoSize  = .T.
3433:                 .Visible   = .T.
3434:             ENDWITH
3435: 
3436:             *-- obj_4c_Mgetdescfi: Descricao Fiscal editbox/memo (mgetdescfi, top=402, left=206)
3437:             loc_oPg.AddObject("obj_4c_Mgetdescfi", "EditBox")
3438:             WITH loc_oPg.obj_4c_Mgetdescfi
3439:                 .Top           = 402
3440:                 .Left          = 206
3441:                 .Width         = 509
3442:                 .Height        = 89
3443:                 .FontName      = "Tahoma"
3444:                 .FontSize      = 8
3445:                 .ScrollBars    = 2
3446:                 .Visible       = .T.
3447:             ENDWITH
3448: 
3449:             *-- cmd_4c_BtnDescFis: Botao gerar descricao fiscal (btnDescFis, top=423, left=162)
3450:             loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
3451:             WITH loc_oPg.cmd_4c_BtnDescFis
3452:                 .Caption         = ""
3453:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
3454:                 .PicturePosition = 0

*-- Linhas 3462 a 3541:
3462:                 .MousePointer    = 15
3463:                 .Visible         = .T.
3464:             ENDWITH
3465:             BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "CmdBtnDescFisClick")
3466: 
3467:             *====================================================================
3468:             *  SECAO: Valor Grama / Grid CMV (Custo Medio Vendido)
3469:             *====================================================================
3470: 
3471:             *-- lbl_4c_Label9: "Valor do Grama Produzido" (Say9, top=384, left=756)
3472:             loc_oPg.AddObject("lbl_4c_Label9", "Label")
3473:             WITH loc_oPg.lbl_4c_Label9
3474:                 .Caption   = "Valor do Grama Produzido"
3475:                 .Top       = 384
3476:                 .Left      = 756
3477:                 .Width     = 125
3478:                 .Height    = 15
3479:                 .FontName  = "Tahoma"
3480:                 .FontSize  = 8
3481:                 .ForeColor = RGB(90, 90, 90)
3482:                 .BackStyle = 0
3483:                 .AutoSize  = .T.
3484:                 .Visible   = .T.
3485:             ENDWITH
3486: 
3487:             *-- grd_4c_Cmv: Grid Custo Medio Vendido (grdCmv, top=402, left=754, 3 colunas)
3488:             *-- ReadOnly: todos os When retornam .F. (grid somente leitura)
3489:             loc_oPg.AddObject("grd_4c_Cmv", "Grid")
3490:             WITH loc_oPg.grd_4c_Cmv
3491:                 .Top        = 402
3492:                 .Left       = 754
3493:                 .Width      = 223
3494:                 .Height     = 141
3495:                 .FontName   = "Courier New"
3496:                 .FontSize   = 8
3497:                 .RecordMark = .T.
3498:                 .RowHeight  = 17
3499:                 .DeleteMark = .F.
3500:                 .ReadOnly   = .T.
3501:                 .Visible    = .T.
3502:             ENDWITH
3503:             loc_oPg.grd_4c_Cmv.ColumnCount  = 3
3504:             loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_TotGrupo2"
3505:             loc_oGrid = loc_oPg.grd_4c_Cmv
3506: 
3507:             loc_oGrid.Column1.ControlSource   = "cursor_4c_TotGrupo2.Grupo"
3508:             loc_oGrid.Column1.Width           = 59
3509:             loc_oGrid.Column1.Movable         = .F.
3510:             loc_oGrid.Column1.Resizable       = .F.
3511:             loc_oGrid.Column1.ReadOnly        = .T.
3512:             loc_oGrid.Column1.FontName        = "Courier New"
3513:             loc_oGrid.Column1.FontSize        = 8
3514:             loc_oGrid.Column1.Header1.Caption = "Per" + CHR(237) + "odo"
3515: 
3516:             loc_oGrid.Column2.ControlSource   = "cursor_4c_TotGrupo2.ValGrupo"
3517:             loc_oGrid.Column2.Width           = 100
3518:             loc_oGrid.Column2.Movable         = .F.
3519:             loc_oGrid.Column2.Resizable       = .F.
3520:             loc_oGrid.Column2.ReadOnly        = .T.
3521:             loc_oGrid.Column2.InputMask       = "999,999,999.999"
3522:             loc_oGrid.Column2.FontName        = "Courier New"
3523:             loc_oGrid.Column2.FontSize        = 8
3524:             loc_oGrid.Column2.Header1.Caption = "Valor Custo GR"
3525: 
3526:             loc_oGrid.Column3.ControlSource   = "cursor_4c_TotGrupo2.Moeda"
3527:             loc_oGrid.Column3.Width           = 31
3528:             loc_oGrid.Column3.ReadOnly        = .T.
3529:             loc_oGrid.Column3.Header1.Caption = "Moe"
3530: 
3531:             *====================================================================
3532:             *  SECAO: Descricao ECF / Metal / Teor
3533:             *====================================================================
3534: 
3535:             *-- lbl_4c_Label12: "Descricao ECF :" (Say12, top=497, left=125)
3536:             loc_oPg.AddObject("lbl_4c_Label12", "Label")
3537:             WITH loc_oPg.lbl_4c_Label12
3538:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
3539:                 .Top       = 497
3540:                 .Left      = 125
3541:                 .Width     = 77

*-- Linhas 3590 a 3679:
3590:                 .MaxLength     = 2
3591:                 .Visible       = .T.
3592:             ENDWITH
3593:             BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress",    THIS, "ValidarMetal")
3594:             BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TxtMetalKeyPress")
3595: 
3596:             *-- txt_4c_DesMetal: Descricao Metal (Get_DesMetal, top=493, left=564)
3597:             loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
3598:             WITH loc_oPg.txt_4c_DesMetal
3599:                 .Top           = 493
3600:                 .Left          = 564
3601:                 .Width         = 150
3602:                 .Height        = 23
3603:                 .FontName      = "Tahoma"
3604:                 .FontSize      = 8
3605:                 .SpecialEffect = 1
3606:                 .ReadOnly      = .T.
3607:                 .Visible       = .T.
3608:             ENDWITH
3609: 
3610:             *-- lbl_4c_Label15: "Teor :" (Say15, top=522, left=502)
3611:             loc_oPg.AddObject("lbl_4c_Label15", "Label")
3612:             WITH loc_oPg.lbl_4c_Label15
3613:                 .Caption   = "Teor :"
3614:                 .Top       = 522
3615:                 .Left      = 502
3616:                 .Width     = 31
3617:                 .FontName  = "Tahoma"
3618:                 .FontSize  = 8
3619:                 .ForeColor = RGB(90, 90, 90)
3620:                 .BackStyle = 0
3621:                 .AutoSize  = .T.
3622:                 .Visible   = .T.
3623:             ENDWITH
3624: 
3625:             *-- txt_4c_Teor: Codigo Teor (Get_teor, top=518, left=537)
3626:             loc_oPg.AddObject("txt_4c_Teor", "TextBox")
3627:             WITH loc_oPg.txt_4c_Teor
3628:                 .Top           = 518
3629:                 .Left          = 537
3630:                 .Width         = 24
3631:                 .Height        = 23
3632:                 .FontName      = "Tahoma"
3633:                 .FontSize      = 8
3634:                 .SpecialEffect = 1
3635:                 .MaxLength     = 2
3636:                 .Visible       = .T.
3637:             ENDWITH
3638:             BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress",    THIS, "ValidarTeor")
3639:             BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TxtTeorKeyPress")
3640: 
3641:             *-- txt_4c_DesTeor: Descricao Teor (Get_DesTeor, top=518, left=564)
3642:             loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
3643:             WITH loc_oPg.txt_4c_DesTeor
3644:                 .Top           = 518
3645:                 .Left          = 564
3646:                 .Width         = 150
3647:                 .Height        = 23
3648:                 .FontName      = "Tahoma"
3649:                 .FontSize      = 8
3650:                 .SpecialEffect = 1
3651:                 .ReadOnly      = .T.
3652:                 .Visible       = .T.
3653:             ENDWITH
3654: 
3655:             *====================================================================
3656:             *  SECAO: Valor Estimado / Moeda / IPPT/CST
3657:             *====================================================================
3658: 
3659:             *-- lbl_4c_Label7: "Valor Estimado :" (Say7, top=522, left=123)
3660:             loc_oPg.AddObject("lbl_4c_Label7", "Label")
3661:             WITH loc_oPg.lbl_4c_Label7
3662:                 .Caption   = "Valor Estimado :"
3663:                 .Top       = 522
3664:                 .Left      = 123
3665:                 .Width     = 79
3666:                 .Height    = 15
3667:                 .FontName  = "Tahoma"
3668:                 .FontSize  = 8
3669:                 .ForeColor = RGB(90, 90, 90)
3670:                 .BackStyle = 0
3671:                 .AutoSize  = .T.
3672:                 .Visible   = .T.
3673:             ENDWITH
3674: 
3675:             *-- txt_4c_Valor: Valor Estimado (getValor, top=518, left=206)
3676:             loc_oPg.AddObject("txt_4c_Valor", "TextBox")
3677:             WITH loc_oPg.txt_4c_Valor
3678:                 .Top           = 518
3679:                 .Left          = 206

*-- Linhas 3701 a 3981:
3701:                 .MaxLength     = 3
3702:                 .Visible       = .T.
3703:             ENDWITH
3704:             BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress",    THIS, "ValidarMvalorFiscal")
3705:             BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress", THIS, "TxtMvalorFiscalKeyPress")
3706: 
3707:             *-- lbl_4c_Label10: "IPPT/CST :" (Say10, top=547, left=148)
3708:             loc_oPg.AddObject("lbl_4c_Label10", "Label")
3709:             WITH loc_oPg.lbl_4c_Label10
3710:                 .Caption   = "IPPT/CST :"
3711:                 .Top       = 547
3712:                 .Left      = 148
3713:                 .Width     = 54
3714:                 .Height    = 15
3715:                 .FontName  = "Tahoma"
3716:                 .FontSize  = 8
3717:                 .ForeColor = RGB(90, 90, 90)
3718:                 .BackStyle = 0
3719:                 .AutoSize  = .T.
3720:                 .Visible   = .T.
3721:             ENDWITH
3722: 
3723:             *-- txt_4c_IPPTCST: IPPT/CST (getIPPTCST, top=543, left=206)
3724:             *-- ReadOnly: When retorna .F. no legado
3725:             loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
3726:             WITH loc_oPg.txt_4c_IPPTCST
3727:                 .Top           = 543
3728:                 .Left          = 206
3729:                 .Width         = 108
3730:                 .Height        = 23
3731:                 .FontName      = "Tahoma"
3732:                 .FontSize      = 8
3733:                 .SpecialEffect = 1
3734:                 .ReadOnly      = .T.
3735:                 .Visible       = .T.
3736:             ENDWITH
3737: 
3738:         CATCH TO loc_oErro
3739:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Dados Fiscais:" + ;
3740:                 CHR(13) + loc_oErro.Message + CHR(13) + ;
3741:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
3742:                 "FormProduto.ConfigurarPgpgDadosFiscais")
3743:         ENDTRY
3744:     ENDPROC
3745: 
3746:     *===========================================================================
3747:     * ConfigurarPgpgCusto - Configura Page2 "Custos" do pgf_4c_Dados
3748:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
3749:     * grdCompo(12 colunas) + cmdgCompo(2 botoes) + cmbTipos + GradeGRUPO2(3 colunas)
3750:     *===========================================================================
3751:     PROTECTED PROCEDURE ConfigurarPgpgCusto(par_oPg)
3752:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oErro
3753:         TRY
3754:             loc_oPg = par_oPg
3755: 
3756:             *-- Cursors placeholder para os grids (ANTES de RecordSource)
3757:             *-- Reutiliza cursor_4c_GrdCompo e TotGrupo criados por pgComposicao se existirem
3758:             IF !USED("cursor_4c_GrdCompo")
3759:                 CREATE CURSOR cursor_4c_GrdCompo ( ;
3760:                     cpros    C(14), dpros    C(65),  cunis  C(5),  ;
3761:                     valor    N(14,3), qtdes  N(10,3), total N(14,3), ;
3762:                     moeda    C(3),  obs      C(80),  estoc  C(1),   ;
3763:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
3764:                     ords     N(5,0), matprinc C(14))
3765:             ENDIF
3766:             IF !USED("TotGrupo")
3767:                 CREATE CURSOR TotGrupo (Grupo C(10), ValGrupo N(14,3), Moeda C(3))
3768:             ENDIF
3769: 
3770:             *-- lbl_4c_Label1: "Tipo :" (Say1, top=159, left=107)
3771:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
3772:             WITH loc_oPg.lbl_4c_Label1
3773:                 .Caption   = "Tipo :"
3774:                 .Top       = 159
3775:                 .Left      = 107
3776:                 .Width     = 29
3777:                 .Height    = 15
3778:                 .FontName  = "Tahoma"
3779:                 .FontSize  = 8
3780:                 .ForeColor = RGB(90, 90, 90)
3781:                 .BackStyle = 0
3782:                 .AutoSize  = .T.
3783:                 .Visible   = .T.
3784:             ENDWITH
3785: 
3786:             *-- cbo_4c_CmbTipos: combo de tipos de composicao (cmbTipos, top=154, left=143)
3787:             loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
3788:             WITH loc_oPg.cbo_4c_CmbTipos
3789:                 .Top           = 154
3790:                 .Left          = 143
3791:                 .Width         = 187
3792:                 .Height        = 23
3793:                 .FontName      = "Tahoma"
3794:                 .FontSize      = 8
3795:                 .SpecialEffect = 1
3796:                 .Style         = 2
3797:                 .Visible       = .T.
3798:             ENDWITH
3799:             BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
3800: 
3801:             *-- grd_4c_GrdCusto: grade principal de custo (grdCompo, top=178, left=34, 12 colunas)
3802:             loc_oPg.AddObject("grd_4c_GrdCusto", "Grid")
3803:             WITH loc_oPg.grd_4c_GrdCusto
3804:                 .Top        = 178
3805:                 .Left       = 34
3806:                 .Width      = 813
3807:                 .Height     = 230
3808:                 .FontName   = "Tahoma"
3809:                 .FontSize   = 8
3810:                 .RecordMark = .F.
3811:                 .RowHeight  = 16
3812:                 .ScrollBars = 2
3813:                 .DeleteMark = .F.
3814:                 .Visible    = .T.
3815:             ENDWITH
3816:             loc_oPg.grd_4c_GrdCusto.ColumnCount  = 12
3817:             loc_oPg.grd_4c_GrdCusto.RecordSource = "cursor_4c_GrdCompo"
3818:             loc_oGrid = loc_oPg.grd_4c_GrdCusto
3819: 
3820:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdCompo.cpros"
3821:             loc_oGrid.Column1.Width           = 90
3822:             loc_oGrid.Column1.ColumnOrder     = 1
3823:             loc_oGrid.Column1.Movable         = .F.
3824:             loc_oGrid.Column1.Resizable       = .F.
3825:             loc_oGrid.Column1.Header1.Caption = "Item"
3826: 
3827:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdCompo.dpros"
3828:             loc_oGrid.Column2.Width           = 175
3829:             loc_oGrid.Column2.ColumnOrder     = 2
3830:             loc_oGrid.Column2.Movable         = .F.
3831:             loc_oGrid.Column2.Resizable       = .F.
3832:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3833: 
3834:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdCompo.cunis"
3835:             loc_oGrid.Column3.Width           = 30
3836:             loc_oGrid.Column3.ColumnOrder     = 3
3837:             loc_oGrid.Column3.Movable         = .F.
3838:             loc_oGrid.Column3.Resizable       = .F.
3839:             loc_oGrid.Column3.Header1.Caption = "Un"
3840: 
3841:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GrdCompo.valor"
3842:             loc_oGrid.Column4.Width           = 75
3843:             loc_oGrid.Column4.ColumnOrder     = 4
3844:             loc_oGrid.Column4.Movable         = .F.
3845:             loc_oGrid.Column4.Resizable       = .F.
3846:             loc_oGrid.Column4.InputMask       = "9999999.999"
3847:             loc_oGrid.Column4.Header1.Caption = "Valor"
3848: 
3849:             loc_oGrid.Column5.ControlSource   = "cursor_4c_GrdCompo.qtdes"
3850:             loc_oGrid.Column5.Width           = 55
3851:             loc_oGrid.Column5.ColumnOrder     = 5
3852:             loc_oGrid.Column5.Movable         = .F.
3853:             loc_oGrid.Column5.Resizable       = .F.
3854:             loc_oGrid.Column5.InputMask       = "9999.999"
3855:             loc_oGrid.Column5.Header1.Caption = "Qtd"
3856: 
3857:             loc_oGrid.Column6.ControlSource   = "cursor_4c_GrdCompo.total"
3858:             loc_oGrid.Column6.Width           = 75
3859:             loc_oGrid.Column6.ColumnOrder     = 6
3860:             loc_oGrid.Column6.Movable         = .F.
3861:             loc_oGrid.Column6.Resizable       = .F.
3862:             loc_oGrid.Column6.InputMask       = "9999999.999"
3863:             loc_oGrid.Column6.Header1.Caption = "Total"
3864: 
3865:             loc_oGrid.Column7.ControlSource   = "cursor_4c_GrdCompo.moeda"
3866:             loc_oGrid.Column7.Width           = 30
3867:             loc_oGrid.Column7.ColumnOrder     = 7
3868:             loc_oGrid.Column7.Header1.Caption = "Moe"
3869: 
3870:             loc_oGrid.Column8.ControlSource   = "cursor_4c_GrdCompo.obs"
3871:             loc_oGrid.Column8.Width           = 100
3872:             loc_oGrid.Column8.ColumnOrder     = 8
3873:             loc_oGrid.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
3874: 
3875:             loc_oGrid.Column9.ControlSource   = "cursor_4c_GrdCompo.estoc"
3876:             loc_oGrid.Column9.Width           = 25
3877:             loc_oGrid.Column9.ColumnOrder     = 9
3878:             loc_oGrid.Column9.Format          = "M"
3879:             loc_oGrid.Column9.InputMask       = "N,S"
3880:             loc_oGrid.Column9.Header1.Caption = "Etiq"
3881: 
3882:             loc_oGrid.Column10.ControlSource   = "cursor_4c_GrdCompo.consumo"
3883:             loc_oGrid.Column10.Width           = 55
3884:             loc_oGrid.Column10.ColumnOrder     = 10
3885:             loc_oGrid.Column10.InputMask       = "99999"
3886:             loc_oGrid.Column10.Header1.Caption = "Consumo"
3887: 
3888:             loc_oGrid.Column11.ControlSource   = "cursor_4c_GrdCompo.qtdes2"
3889:             loc_oGrid.Column11.Width           = 55
3890:             loc_oGrid.Column11.ColumnOrder     = 11
3891:             loc_oGrid.Column11.Movable         = .F.
3892:             loc_oGrid.Column11.Resizable       = .F.
3893:             loc_oGrid.Column11.Header1.Caption = "Qtd"
3894: 
3895:             loc_oGrid.Column12.ControlSource   = "cursor_4c_GrdCompo.cunis2"
3896:             loc_oGrid.Column12.Width           = 30
3897:             loc_oGrid.Column12.ColumnOrder     = 12
3898:             loc_oGrid.Column12.Movable         = .F.
3899:             loc_oGrid.Column12.Resizable       = .F.
3900:             loc_oGrid.Column12.ReadOnly        = .T.
3901:             loc_oGrid.Column12.Header1.Caption = "Un"
3902: 
3903:             BINDEVENT(loc_oPg.grd_4c_GrdCusto, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
3904: 
3905:             *-- cmg_4c_CmdgCusto: 2 botoes de controle (cmdgCompo, top=240, left=851)
3906:             loc_oPg.AddObject("cmg_4c_CmdgCusto", "CommandGroup")
3907:             WITH loc_oPg.cmg_4c_CmdgCusto
3908:                 .Top         = 240
3909:                 .Left        = 851
3910:                 .Width       = 50
3911:                 .Height      = 90
3912:                 .BackStyle   = 0
3913:                 .BorderStyle = 0
3914:                 .Value       = 1
3915:                 .BackColor   = RGB(162, 214, 242)
3916:                 .ButtonCount = 2
3917:                 .Visible     = .T.
3918:             ENDWITH
3919:             WITH loc_oPg.cmg_4c_CmdgCusto
3920:                 .Command1.Top          = 5
3921:                 .Command1.Left         = 5
3922:                 .Command1.Height       = 40
3923:                 .Command1.Width        = 40
3924:                 .Command1.Caption      = ""
3925:                 .Command1.Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
3926:                 .Command1.ToolTipText  = "Inserir Item"
3927:                 .Command1.Style        = 0
3928:                 .Command1.SpecialEffect = 0
3929:                 .Command1.BackColor    = RGB(255, 255, 255)
3930:                 .Command2.Top          = 45
3931:                 .Command2.Left         = 5
3932:                 .Command2.Height       = 40
3933:                 .Command2.Width        = 40
3934:                 .Command2.Caption      = ""
3935:                 .Command2.Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3936:                 .Command2.ToolTipText  = "Excluir Item"
3937:                 .Command2.Style        = 0
3938:                 .Command2.SpecialEffect = 0
3939:                 .Command2.BackColor    = RGB(255, 255, 255)
3940:             ENDWITH
3941:             BINDEVENT(loc_oPg.cmg_4c_CmdgCusto, "Click", THIS, "CmgCustoClick")
3942: 
3943:             *-- lbl_4c_Label16: "Descricao :" (Say16, top=415, left=53)
3944:             loc_oPg.AddObject("lbl_4c_Label16", "Label")
3945:             WITH loc_oPg.lbl_4c_Label16
3946:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3947:                 .Top       = 415
3948:                 .Left      = 53
3949:                 .Width     = 55
3950:                 .Height    = 15
3951:                 .FontName  = "Tahoma"
3952:                 .FontSize  = 8
3953:                 .ForeColor = RGB(90, 90, 90)
3954:                 .BackStyle = 0
3955:                 .AutoSize  = .T.
3956:                 .Visible   = .T.
3957:             ENDWITH
3958: 
3959:             *-- txt_4c_Desc: descricao do material (Get_Desc, top=412, left=116, readonly)
3960:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
3961:             WITH loc_oPg.txt_4c_Desc
3962:                 .Top           = 412
3963:                 .Left          = 116
3964:                 .Width         = 304
3965:                 .Height        = 21
3966:                 .FontName      = "Tahoma"
3967:                 .FontSize      = 8
3968:                 .SpecialEffect = 1
3969:                 .ReadOnly      = .T.
3970:                 .BackColor     = RGB(240, 240, 240)
3971:                 .Value         = ""
3972:                 .Visible       = .T.
3973:             ENDWITH
3974: 
3975:             *-- lbl_4c_Label2: "Grupo :" (Say2, top=415, left=480)
3976:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
3977:             WITH loc_oPg.lbl_4c_Label2
3978:                 .Caption   = "Grupo :"
3979:                 .Top       = 415
3980:                 .Left      = 480
3981:                 .Width     = 38

*-- Linhas 4030 a 4068:
4030:                 .BorderWidth = 1
4031:                 .BackStyle   = 1
4032:                 .Visible     = .T.
4033:             ENDWITH
4034: 
4035:             *-- grd_4c_GradeGrupo2: grade de resumo por grupo (GradeGRUPO2, top=468, left=35)
4036:             loc_oPg.AddObject("grd_4c_GradeGrupo2", "Grid")
4037:             WITH loc_oPg.grd_4c_GradeGrupo2
4038:                 .Top          = 468
4039:                 .Left         = 35
4040:                 .Width        = 195
4041:                 .Height       = 141
4042:                 .FontName     = "Verdana"
4043:                 .FontSize     = 8
4044:                 .DeleteMark   = .F.
4045:                 .HeaderHeight = 14
4046:                 .ReadOnly     = .T.
4047:                 .RecordMark   = .F.
4048:                 .RowHeight    = 16
4049:                 .Visible      = .T.
4050:             ENDWITH
4051:             loc_oPg.grd_4c_GradeGrupo2.ColumnCount  = 3
4052:             loc_oPg.grd_4c_GradeGrupo2.RecordSource = "TotGrupo"
4053:             loc_oGrid2 = loc_oPg.grd_4c_GradeGrupo2
4054: 
4055:             loc_oGrid2.Column1.ControlSource   = "TotGrupo.Grupo"
4056:             loc_oGrid2.Column1.Width           = 35
4057:             loc_oGrid2.Column1.Movable         = .F.
4058:             loc_oGrid2.Column1.Resizable       = .F.
4059:             loc_oGrid2.Column1.ReadOnly        = .T.
4060:             loc_oGrid2.Column1.Header1.Caption = "Grp"
4061: 
4062:             loc_oGrid2.Column2.ControlSource   = "TotGrupo.ValGrupo"
4063:             loc_oGrid2.Column2.Width           = 120
4064:             loc_oGrid2.Column2.Movable         = .F.
4065:             loc_oGrid2.Column2.Resizable       = .F.
4066:             loc_oGrid2.Column2.ReadOnly        = .T.
4067:             loc_oGrid2.Column2.InputMask       = "999,999,999.999"
4068:             loc_oGrid2.Column2.Header1.Caption = "Total "

*-- Linhas 4084 a 4238:
4084:     * ConfigurarPgpgComposicao - Configura Page6 "Composicao" do pgf_4c_Dados
4085:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao
4086:     *===========================================================================
4087:     PROTECTED PROCEDURE ConfigurarPgpgComposicao(par_oPg)
4088:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oGrid3, loc_oGradeGrupo, loc_oCnt, loc_oErro
4089:         TRY
4090:             loc_oPg = par_oPg
4091: 
4092:             *-- Cursors placeholder para os grids (ANTES de RecordSource)
4093:             IF !USED("cursor_4c_GrdCompo")
4094:                 CREATE CURSOR cursor_4c_GrdCompo ( ;
4095:                     cpros    C(14), dpros   C(65), cunis   C(5),  ;
4096:                     valor    N(14,3), qtdes N(10,3), total  N(14,3), ;
4097:                     moeda    C(3),  obs    C(80),  estoc   C(1),  ;
4098:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
4099:                     ords     N(5,0), matprinc C(14))
4100:             ENDIF
4101:             IF !USED("cursor_4c_GrdSubCp")
4102:                 CREATE CURSOR cursor_4c_GrdSubCp ( ;
4103:                     cpros    C(14), dpros   C(65), cunis   C(5),  ;
4104:                     valor    N(14,3), qtdes N(10,3), total  N(14,3), ;
4105:                     moeda    C(3),  obs    C(80),  estoc   C(1),  ;
4106:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
4107:                     ords     N(5,0), matprinc C(14), tamanho C(10))
4108:             ENDIF
4109:             IF !USED("cursor_4c_GrdRelogios")
4110:                 CREATE CURSOR cursor_4c_GrdRelogios ( ;
4111:                     grp C(5), descricao C(60), produto C(14), descprod C(60))
4112:             ENDIF
4113:             IF !USED("TotGrupo")
4114:                 CREATE CURSOR TotGrupo (Grupo C(10), ValGrupo N(14,3), Moeda C(3))
4115:             ENDIF
4116: 
4117:             *-- grdCompo: grade principal de composicao (14 colunas)
4118:             loc_oPg.AddObject("grd_4c_GrdCompo", "Grid")
4119:             WITH loc_oPg.grd_4c_GrdCompo
4120:                 .Top        = 117
4121:                 .Left       = 6
4122:                 .Width      = 943
4123:                 .Height     = 147
4124:                 .FontName   = "Tahoma"
4125:                 .FontSize   = 8
4126:                 .RecordMark = .F.
4127:                 .RowHeight  = 16
4128:                 .ScrollBars = 2
4129:                 .TabStop    = .F.
4130:                 .Visible    = .T.
4131:             ENDWITH
4132:             loc_oPg.grd_4c_GrdCompo.ColumnCount  = 14
4133:             loc_oPg.grd_4c_GrdCompo.RecordSource = "cursor_4c_GrdCompo"
4134:             loc_oGrid = loc_oPg.grd_4c_GrdCompo
4135: 
4136:             loc_oGrid.Column1.ControlSource  = "cursor_4c_GrdCompo.cpros"
4137:             loc_oGrid.Column1.Width          = 108
4138:             loc_oGrid.Column1.ColumnOrder    = 1
4139:             loc_oGrid.Column1.Movable        = .F.
4140:             loc_oGrid.Column1.Resizable      = .F.
4141:             loc_oGrid.Column1.Header1.Caption = "Material"
4142: 
4143:             loc_oGrid.Column2.ControlSource  = "cursor_4c_GrdCompo.dpros"
4144:             loc_oGrid.Column2.Width          = 187
4145:             loc_oGrid.Column2.ColumnOrder    = 2
4146:             loc_oGrid.Column2.Movable        = .F.
4147:             loc_oGrid.Column2.Resizable      = .F.
4148:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4149: 
4150:             loc_oGrid.Column3.ControlSource  = "cursor_4c_GrdCompo.cunis"
4151:             loc_oGrid.Column3.Width          = 24
4152:             loc_oGrid.Column3.ColumnOrder    = 4
4153:             loc_oGrid.Column3.Movable        = .F.
4154:             loc_oGrid.Column3.Resizable      = .F.
4155:             loc_oGrid.Column3.Header1.Caption = "Un"
4156: 
4157:             loc_oGrid.Column4.ControlSource  = "cursor_4c_GrdCompo.valor"
4158:             loc_oGrid.Column4.Width          = 73
4159:             loc_oGrid.Column4.ColumnOrder    = 7
4160:             loc_oGrid.Column4.Movable        = .F.
4161:             loc_oGrid.Column4.Resizable      = .F.
4162:             loc_oGrid.Column4.InputMask      = "9999999.999"
4163:             loc_oGrid.Column4.Header1.Caption = "Valor"
4164: 
4165:             loc_oGrid.Column5.ControlSource  = "cursor_4c_GrdCompo.qtdes"
4166:             loc_oGrid.Column5.Width          = 59
4167:             loc_oGrid.Column5.ColumnOrder    = 3
4168:             loc_oGrid.Column5.Movable        = .F.
4169:             loc_oGrid.Column5.Resizable      = .F.
4170:             loc_oGrid.Column5.InputMask      = "9999.999"
4171:             loc_oGrid.Column5.Header1.Caption = "Qtde."
4172: 
4173:             loc_oGrid.Column6.ControlSource  = "cursor_4c_GrdCompo.total"
4174:             loc_oGrid.Column6.Width          = 58
4175:             loc_oGrid.Column6.ColumnOrder    = 9
4176:             loc_oGrid.Column6.InputMask      = "9999999.999"
4177:             loc_oGrid.Column6.Header1.Caption = "Total"
4178: 
4179:             loc_oGrid.Column7.ControlSource  = "cursor_4c_GrdCompo.moeda"
4180:             loc_oGrid.Column7.Width          = 31
4181:             loc_oGrid.Column7.ColumnOrder    = 8
4182:             loc_oGrid.Column7.Header1.Caption = "Moe"
4183: 
4184:             loc_oGrid.Column8.ControlSource  = "cursor_4c_GrdCompo.obs"
4185:             loc_oGrid.Column8.Width          = 80
4186:             loc_oGrid.Column8.ColumnOrder    = 10
4187:             loc_oGrid.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
4188: 
4189:             loc_oGrid.Column9.ControlSource  = "cursor_4c_GrdCompo.estoc"
4190:             loc_oGrid.Column9.Width          = 14
4191:             loc_oGrid.Column9.ColumnOrder    = 12
4192:             loc_oGrid.Column9.Format         = "M"
4193:             loc_oGrid.Column9.InputMask      = "N,S"
4194:             loc_oGrid.Column9.Header1.Caption = "E"
4195: 
4196:             loc_oGrid.Column10.ControlSource  = "cursor_4c_GrdCompo.consumo"
4197:             loc_oGrid.Column10.Width          = 58
4198:             loc_oGrid.Column10.ColumnOrder    = 13
4199:             loc_oGrid.Column10.InputMask      = "99999"
4200:             loc_oGrid.Column10.Header1.Caption = "Consumo"
4201: 
4202:             loc_oGrid.Column11.ControlSource  = "cursor_4c_GrdCompo.qtdes2"
4203:             loc_oGrid.Column11.Width          = 59
4204:             loc_oGrid.Column11.ColumnOrder    = 5
4205:             loc_oGrid.Column11.Movable        = .F.
4206:             loc_oGrid.Column11.Resizable      = .F.
4207:             loc_oGrid.Column11.Header1.Caption = "Qtde."
4208: 
4209:             loc_oGrid.Column12.ControlSource  = "cursor_4c_GrdCompo.cunis2"
4210:             loc_oGrid.Column12.Width          = 24
4211:             loc_oGrid.Column12.ColumnOrder    = 6
4212:             loc_oGrid.Column12.Movable        = .F.
4213:             loc_oGrid.Column12.ReadOnly       = .T.
4214:             loc_oGrid.Column12.Header1.Caption = "Un"
4215: 
4216:             loc_oGrid.Column13.ControlSource  = "cursor_4c_GrdCompo.ords"
4217:             loc_oGrid.Column13.Width          = 24
4218:             loc_oGrid.Column13.ColumnOrder    = 14
4219:             loc_oGrid.Column13.Format         = "K"
4220:             loc_oGrid.Column13.InputMask      = "99"
4221:             loc_oGrid.Column13.Header1.Caption = "Ord"
4222: 
4223:             loc_oGrid.Column14.ControlSource  = "cursor_4c_GrdCompo.matprinc"
4224:             loc_oGrid.Column14.Width          = 108
4225:             loc_oGrid.Column14.ColumnOrder    = 11
4226:             loc_oGrid.Column14.Header1.Caption = "Material"
4227: 
4228:             *-- cmg_4c_CmdgCompo: 5 botoes de controle da composicao
4229:             loc_oPg.AddObject("cmg_4c_CmdgCompo", "CommandGroup")
4230:             WITH loc_oPg.cmg_4c_CmdgCompo
4231:                 .Top         = 114
4232:                 .Left        = 947
4233:                 .Width       = 50
4234:                 .Height      = 210
4235:                 .BackStyle   = 0
4236:                 .BorderStyle = 0
4237:                 .Value       = 1
4238:                 .BackColor   = RGB(162, 214, 242)

*-- Linhas 4289 a 4421:
4289:                 .Command5.ToolTipText = "Atualizar Pesos"
4290:                 .Command5.BackColor = RGB(255, 255, 255)
4291:             ENDWITH
4292:             BINDEVENT(loc_oPg.cmg_4c_CmdgCompo, "Click", THIS, "CmgCompoClick")
4293: 
4294:             *-- grdsubcp: grade de subcomposicao (15 colunas)
4295:             loc_oPg.AddObject("grd_4c_GrdSubCp", "Grid")
4296:             WITH loc_oPg.grd_4c_GrdSubCp
4297:                 .Top        = 317
4298:                 .Left       = 6
4299:                 .Width      = 943
4300:                 .Height     = 83
4301:                 .FontName   = "Tahoma"
4302:                 .FontSize   = 8
4303:                 .RecordMark = .F.
4304:                 .RowHeight  = 16
4305:                 .ScrollBars = 2
4306:                 .TabStop    = .F.
4307:                 .Visible    = .T.
4308:             ENDWITH
4309:             loc_oPg.grd_4c_GrdSubCp.ColumnCount  = 15
4310:             loc_oPg.grd_4c_GrdSubCp.RecordSource = "cursor_4c_GrdSubCp"
4311:             loc_oGrid2 = loc_oPg.grd_4c_GrdSubCp
4312: 
4313:             loc_oGrid2.Column1.ControlSource  = "cursor_4c_GrdSubCp.cpros"
4314:             loc_oGrid2.Column1.Width          = 108
4315:             loc_oGrid2.Column1.ColumnOrder    = 1
4316:             loc_oGrid2.Column1.Movable        = .F.
4317:             loc_oGrid2.Column1.Resizable      = .F.
4318:             loc_oGrid2.Column1.Header1.Caption = "Material"
4319: 
4320:             loc_oGrid2.Column2.ControlSource  = "cursor_4c_GrdSubCp.dpros"
4321:             loc_oGrid2.Column2.Width          = 149
4322:             loc_oGrid2.Column2.ColumnOrder    = 2
4323:             loc_oGrid2.Column2.Movable        = .F.
4324:             loc_oGrid2.Column2.Resizable      = .F.
4325:             loc_oGrid2.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4326: 
4327:             loc_oGrid2.Column3.ControlSource  = "cursor_4c_GrdSubCp.cunis"
4328:             loc_oGrid2.Column3.Width          = 24
4329:             loc_oGrid2.Column3.ColumnOrder    = 4
4330:             loc_oGrid2.Column3.Movable        = .F.
4331:             loc_oGrid2.Column3.Resizable      = .F.
4332:             loc_oGrid2.Column3.Header1.Caption = "Un"
4333: 
4334:             loc_oGrid2.Column4.ControlSource  = "cursor_4c_GrdSubCp.valor"
4335:             loc_oGrid2.Column4.Width          = 73
4336:             loc_oGrid2.Column4.ColumnOrder    = 7
4337:             loc_oGrid2.Column4.Movable        = .F.
4338:             loc_oGrid2.Column4.Resizable      = .F.
4339:             loc_oGrid2.Column4.InputMask      = "9999999.999"
4340:             loc_oGrid2.Column4.Header1.Caption = "Valor"
4341: 
4342:             loc_oGrid2.Column5.ControlSource  = "cursor_4c_GrdSubCp.qtdes"
4343:             loc_oGrid2.Column5.Width          = 59
4344:             loc_oGrid2.Column5.ColumnOrder    = 3
4345:             loc_oGrid2.Column5.Movable        = .F.
4346:             loc_oGrid2.Column5.Resizable      = .F.
4347:             loc_oGrid2.Column5.InputMask      = "9999.999"
4348:             loc_oGrid2.Column5.Header1.Caption = "Qtde."
4349: 
4350:             loc_oGrid2.Column6.ControlSource  = "cursor_4c_GrdSubCp.total"
4351:             loc_oGrid2.Column6.Width          = 58
4352:             loc_oGrid2.Column6.ColumnOrder    = 9
4353:             loc_oGrid2.Column6.InputMask      = "9999999.999"
4354:             loc_oGrid2.Column6.Header1.Caption = "Total"
4355: 
4356:             loc_oGrid2.Column7.ControlSource  = "cursor_4c_GrdSubCp.moeda"
4357:             loc_oGrid2.Column7.Width          = 31
4358:             loc_oGrid2.Column7.ColumnOrder    = 8
4359:             loc_oGrid2.Column7.Header1.Caption = "Moe"
4360: 
4361:             loc_oGrid2.Column8.ControlSource  = "cursor_4c_GrdSubCp.obs"
4362:             loc_oGrid2.Column8.Width          = 80
4363:             loc_oGrid2.Column8.ColumnOrder    = 10
4364:             loc_oGrid2.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
4365: 
4366:             loc_oGrid2.Column9.ControlSource  = "cursor_4c_GrdSubCp.estoc"
4367:             loc_oGrid2.Column9.Width          = 14
4368:             loc_oGrid2.Column9.ColumnOrder    = 12
4369:             loc_oGrid2.Column9.Format         = "M"
4370:             loc_oGrid2.Column9.InputMask      = "N,S"
4371:             loc_oGrid2.Column9.Header1.Caption = "E"
4372: 
4373:             loc_oGrid2.Column10.ControlSource  = "cursor_4c_GrdSubCp.consumo"
4374:             loc_oGrid2.Column10.Width          = 58
4375:             loc_oGrid2.Column10.ColumnOrder    = 13
4376:             loc_oGrid2.Column10.InputMask      = "99999"
4377:             loc_oGrid2.Column10.Header1.Caption = "Consumo"
4378: 
4379:             loc_oGrid2.Column11.ControlSource  = "cursor_4c_GrdSubCp.qtdes2"
4380:             loc_oGrid2.Column11.Width          = 59
4381:             loc_oGrid2.Column11.ColumnOrder    = 5
4382:             loc_oGrid2.Column11.Movable        = .F.
4383:             loc_oGrid2.Column11.Resizable      = .F.
4384:             loc_oGrid2.Column11.Header1.Caption = "Qtde."
4385: 
4386:             loc_oGrid2.Column12.ControlSource  = "cursor_4c_GrdSubCp.cunis2"
4387:             loc_oGrid2.Column12.Width          = 24
4388:             loc_oGrid2.Column12.ColumnOrder    = 6
4389:             loc_oGrid2.Column12.Movable        = .F.
4390:             loc_oGrid2.Column12.ReadOnly       = .T.
4391:             loc_oGrid2.Column12.Header1.Caption = "Un"
4392: 
4393:             loc_oGrid2.Column13.ControlSource  = "cursor_4c_GrdSubCp.ords"
4394:             loc_oGrid2.Column13.Width          = 24
4395:             loc_oGrid2.Column13.ColumnOrder    = 14
4396:             loc_oGrid2.Column13.Format         = "K"
4397:             loc_oGrid2.Column13.InputMask      = "99"
4398:             loc_oGrid2.Column13.Header1.Caption = "Ord"
4399: 
4400:             loc_oGrid2.Column14.ControlSource  = "cursor_4c_GrdSubCp.matprinc"
4401:             loc_oGrid2.Column14.Width          = 108
4402:             loc_oGrid2.Column14.ColumnOrder    = 11
4403:             loc_oGrid2.Column14.Header1.Caption = "Material"
4404:             loc_oGrid2.Column14.Header1.BackColor = RGB(240, 240, 240)
4405: 
4406:             loc_oGrid2.Column15.ControlSource  = "cursor_4c_GrdSubCp.tamanho"
4407:             loc_oGrid2.Column15.Width          = 38
4408:             loc_oGrid2.Column15.Header1.Caption = "Tam"
4409:             loc_oGrid2.Column15.Header1.ToolTipText = "Tamanho"
4410: 
4411:             *-- cmg_4c_CmdgSubCp: 2 botoes de subcomposicao
4412:             loc_oPg.AddObject("cmg_4c_CmdgSubCp", "CommandGroup")
4413:             WITH loc_oPg.cmg_4c_CmdgSubCp
4414:                 .Top         = 314
4415:                 .Left        = 947
4416:                 .Width       = 50
4417:                 .Height      = 90
4418:                 .BackStyle   = 0
4419:                 .BorderStyle = 0
4420:                 .Value       = 1
4421:                 .BackColor   = RGB(162, 214, 242)

*-- Linhas 4444 a 4503:
4444:                 .Command2.SpecialEffect = 0
4445:                 .Command2.BackColor = RGB(255, 255, 255)
4446:             ENDWITH
4447:             BINDEVENT(loc_oPg.cmg_4c_CmdgSubCp, "Click", THIS, "CmgSubCpClick")
4448: 
4449:             *-- grdRelogios: grade de relogios (inicialmente oculta)
4450:             loc_oPg.AddObject("grd_4c_GrdRelogios", "Grid")
4451:             WITH loc_oPg.grd_4c_GrdRelogios
4452:                 .Top        = 117
4453:                 .Left       = 6
4454:                 .Width      = 943
4455:                 .Height     = 307
4456:                 .FontName   = "Verdana"
4457:                 .FontSize   = 8
4458:                 .RecordMark = .F.
4459:                 .RowHeight  = 16
4460:                 .ScrollBars = 2
4461:                 .TabStop    = .F.
4462:                 .Visible    = .F.
4463:             ENDWITH
4464:             loc_oPg.grd_4c_GrdRelogios.ColumnCount  = 4
4465:             loc_oPg.grd_4c_GrdRelogios.RecordSource = "cursor_4c_GrdRelogios"
4466:             loc_oGrid3 = loc_oPg.grd_4c_GrdRelogios
4467: 
4468:             loc_oGrid3.Column1.ControlSource  = "cursor_4c_GrdRelogios.grp"
4469:             loc_oGrid3.Column1.Width          = 31
4470:             loc_oGrid3.Column1.ColumnOrder    = 1
4471:             loc_oGrid3.Column1.Movable        = .F.
4472:             loc_oGrid3.Column1.Resizable      = .F.
4473:             loc_oGrid3.Column1.Header1.Caption = "Grp"
4474: 
4475:             loc_oGrid3.Column2.ControlSource  = "cursor_4c_GrdRelogios.descricao"
4476:             loc_oGrid3.Column2.Width          = 150
4477:             loc_oGrid3.Column2.Movable        = .F.
4478:             loc_oGrid3.Column2.Resizable      = .F.
4479:             loc_oGrid3.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4480: 
4481:             loc_oGrid3.Column3.ControlSource  = "cursor_4c_GrdRelogios.produto"
4482:             loc_oGrid3.Column3.Width          = 115
4483:             loc_oGrid3.Column3.ColumnOrder    = 3
4484:             loc_oGrid3.Column3.Movable        = .F.
4485:             loc_oGrid3.Column3.Resizable      = .F.
4486:             loc_oGrid3.Column3.Header1.Caption = "Produto"
4487: 
4488:             loc_oGrid3.Column4.ControlSource  = "cursor_4c_GrdRelogios.descprod"
4489:             loc_oGrid3.Column4.Width          = 290
4490:             loc_oGrid3.Column4.ColumnOrder    = 4
4491:             loc_oGrid3.Column4.Movable        = .F.
4492:             loc_oGrid3.Column4.Resizable      = .F.
4493:             loc_oGrid3.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4494: 
4495:             *-- GradeGRUPO: grade de totais por grupo
4496:             loc_oPg.AddObject("grd_4c_GradeGrupo", "Grid")
4497:             WITH loc_oPg.grd_4c_GradeGrupo
4498:                 .Top          = 41
4499:                 .Left         = 619
4500:                 .Width        = 215
4501:                 .Height       = 68
4502:                 .FontName     = "Verdana"
4503:                 .FontSize     = 8

*-- Linhas 4533 a 4613:
4533:             loc_oGradeGrupo.Column3.Resizable      = .F.
4534:             loc_oGradeGrupo.Column3.ReadOnly       = .T.
4535:             loc_oGradeGrupo.Column3.Header1.Caption = "Moeda"
4536: 
4537:             *-- BINDEVENT para grids
4538:             BINDEVENT(loc_oPg.grd_4c_GrdCompo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
4539:             BINDEVENT(loc_oPg.grd_4c_GrdSubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
4540: 
4541:             *-- Say4: "Obs. da OF :"
4542:             loc_oPg.AddObject("lbl_4c_Label4", "Label")
4543:             WITH loc_oPg.lbl_4c_Label4
4544:                 .Caption   = "Obs. da OF :"
4545:                 .FontName  = "Tahoma"
4546:                 .FontSize  = 8
4547:                 .BackStyle = 0
4548:                 .Height    = 15
4549:                 .Left      = 33
4550:                 .Top       = 269
4551:                 .Width     = 64
4552:                 .ForeColor = RGB(90, 90, 90)
4553:                 .Visible   = .T.
4554:             ENDWITH
4555: 
4556:             *-- getObsOFs: observacao da ordem de fabricacao
4557:             loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
4558:             WITH loc_oPg.txt_4c_ObsOFs
4559:                 .FontName  = "Tahoma"
4560:                 .FontSize  = 8
4561:                 .Format    = "K!"
4562:                 .Height    = 21
4563:                 .Left      = 99
4564:                 .MaxLength = 120
4565:                 .SpecialEffect = 1
4566:                 .Top       = 266
4567:                 .Width     = 850
4568:                 .BackColor = RGB(240, 240, 240)
4569:                 .Value     = ""
4570:                 .Visible   = .T.
4571:             ENDWITH
4572:             BINDEVENT(loc_oPg.txt_4c_ObsOFs, "When", THIS, "TxtObsOFsWhen")
4573:             BINDEVENT(loc_oPg.txt_4c_ObsOFs, "KeyPress", THIS, "TxtObsOFsKeyPress")
4574: 
4575:             *-- Say16: "Descricao :" (para Get_Desc)
4576:             loc_oPg.AddObject("lbl_4c_Label16", "Label")
4577:             WITH loc_oPg.lbl_4c_Label16
4578:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4579:                 .FontName  = "Tahoma"
4580:                 .FontSize  = 8
4581:                 .BackStyle = 0
4582:                 .Height    = 15
4583:                 .Left      = 40
4584:                 .Top       = 293
4585:                 .Width     = 55
4586:                 .ForeColor = RGB(90, 90, 90)
4587:                 .Visible   = .T.
4588:             ENDWITH
4589: 
4590:             *-- Get_Desc: descricao do produto na composicao principal
4591:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
4592:             WITH loc_oPg.txt_4c_Desc
4593:                 .FontName  = "Tahoma"
4594:                 .FontSize  = 8
4595:                 .Height    = 21
4596:                 .Left      = 99
4597:                 .SpecialEffect = 1
4598:                 .Top       = 290
4599:                 .Width     = 298
4600:                 .BackColor = RGB(240, 240, 240)
4601:                 .Value     = ""
4602:                 .Visible   = .T.
4603:             ENDWITH
4604: 
4605:             *-- Say15: "Material Principal :"
4606:             loc_oPg.AddObject("lbl_4c_Label15", "Label")
4607:             WITH loc_oPg.lbl_4c_Label15
4608:                 .Caption   = "Material Principal :"
4609:                 .FontName  = "Tahoma"
4610:                 .FontSize  = 8
4611:                 .BackStyle = 0
4612:                 .Height    = 15
4613:                 .Left      = 418

*-- Linhas 4767 a 4828:
4767:                 .BackColor     = RGB(255, 255, 255)
4768:                 .Visible       = .T.
4769:             ENDWITH
4770:             BINDEVENT(loc_oPg.chk_4c_ChkLiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
4771: 
4772:             *-- chkLiberaVenda: cadeado de liberacao de edicao de venda
4773:             loc_oPg.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
4774:             WITH loc_oPg.chk_4c_ChkLiberaVenda
4775:                 .Top           = 431
4776:                 .Left          = 383
4777:                 .Height        = 35
4778:                 .Width         = 35
4779:                 .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
4780:                 .Alignment     = 0
4781:                 .Caption       = ""
4782:                 .Value         = 0
4783:                 .SpecialEffect = 0
4784:                 .Style         = 1
4785:                 .BackColor     = RGB(255, 255, 255)
4786:                 .Visible       = .T.
4787:             ENDWITH
4788:             BINDEVENT(loc_oPg.chk_4c_ChkLiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
4789: 
4790:             *==============================================================
4791:             *-- SECAO CUSTO (Left < 380)
4792:             *==============================================================
4793: 
4794:             *-- lblCompra: "Preco de Custo (Moeda 1)"
4795:             loc_oPg.AddObject("lbl_4c_LblCompra", "Label")
4796:             WITH loc_oPg.lbl_4c_LblCompra
4797:                 .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
4798:                 .FontName  = "Tahoma"
4799:                 .FontSize  = 8
4800:                 .BackStyle = 0
4801:                 .Height    = 15
4802:                 .Left      = 7
4803:                 .Top       = 474
4804:                 .Width     = 127
4805:                 .ForeColor = RGB(90, 90, 90)
4806:                 .Visible   = .T.
4807:             ENDWITH
4808: 
4809:             *-- getPcus: preco de custo
4810:             loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
4811:             WITH loc_oPg.txt_4c_Pcus
4812:                 .Alignment     = 3
4813:                 .Format        = "K"
4814:                 .Height        = 23
4815:                 .InputMask     = "999,999.99999"
4816:                 .Left          = 7
4817:                 .SpecialEffect = 1
4818:                 .Top           = 489
4819:                 .Width         = 115
4820:                 .Value         = 0
4821:                 .Visible       = .T.
4822:             ENDWITH
4823: 
4824:             *-- txt_4c_Moec: moeda de custo (lookup SigCdMoe)
4825:             loc_oPg.AddObject("txt_4c_Moec", "TextBox")
4826:             WITH loc_oPg.txt_4c_Moec
4827:                 .Format        = "K"
4828:                 .Height        = 23

*-- Linhas 4834 a 4926:
4834:                 .Value         = ""
4835:                 .Visible       = .T.
4836:             ENDWITH
4837:             BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress", THIS, "ValidarMoec")
4838:             BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress", THIS, "TxtMoecKeyPress")
4839: 
4840:             *-- Say22: "MKP" (custo)
4841:             loc_oPg.AddObject("lbl_4c_Label22", "Label")
4842:             WITH loc_oPg.lbl_4c_Label22
4843:                 .Caption   = "MKP"
4844:                 .FontName  = "Tahoma"
4845:                 .FontSize  = 8
4846:                 .BackStyle = 0
4847:                 .Height    = 15
4848:                 .Left      = 7
4849:                 .Top       = 514
4850:                 .Width     = 22
4851:                 .ForeColor = RGB(90, 90, 90)
4852:                 .Visible   = .T.
4853:             ENDWITH
4854: 
4855:             *-- Get_cmkpc: codigo MKP custo (lookup SigPrFti)
4856:             loc_oPg.AddObject("txt_4c_Cmkpc", "TextBox")
4857:             WITH loc_oPg.txt_4c_Cmkpc
4858:                 .Height        = 23
4859:                 .Left          = 7
4860:                 .MaxLength     = 2
4861:                 .SpecialEffect = 1
4862:                 .Top           = 529
4863:                 .Width         = 24
4864:                 .Value         = ""
4865:                 .Visible       = .T.
4866:             ENDWITH
4867:             BINDEVENT(loc_oPg.txt_4c_Cmkpc, "KeyPress", THIS, "ValidarCmkpc")
4868:             BINDEVENT(loc_oPg.txt_4c_Cmkpc, "KeyPress", THIS, "TxtCmkpcKeyPress")
4869: 
4870:             *-- chkPlanCus: planejamento custo
4871:             loc_oPg.AddObject("chk_4c_ChkPlanCus", "CheckBox")
4872:             WITH loc_oPg.chk_4c_ChkPlanCus
4873:                 .Top           = 528
4874:                 .Left          = 34
4875:                 .Height        = 25
4876:                 .Width         = 25
4877:                 .Picture       = gc_4c_CaminhoIcones + "geral_datas_26.jpg"
4878:                 .Alignment     = 0
4879:                 .Caption       = ""
4880:                 .Value         = 0
4881:                 .SpecialEffect = 1
4882:                 .Style         = 1
4883:                 .BackColor     = RGB(162, 214, 242)
4884:                 .Visible       = .T.
4885:             ENDWITH
4886:             BINDEVENT(loc_oPg.chk_4c_ChkPlanCus, "Click", THIS, "ChkPlanCusClick")
4887: 
4888:             *-- lblValAdics: "Valor Adicional" (custo)
4889:             loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
4890:             WITH loc_oPg.lbl_4c_LblValAdics
4891:                 .Caption   = "Valor Adicional"
4892:                 .FontName  = "Tahoma"
4893:                 .FontSize  = 8
4894:                 .BackStyle = 0
4895:                 .Height    = 15
4896:                 .Left      = 62
4897:                 .Top       = 514
4898:                 .Width     = 71
4899:                 .ForeColor = RGB(90, 90, 90)
4900:                 .Visible   = .T.
4901:             ENDWITH
4902: 
4903:             *-- get_pftioc: valor adicional custo
4904:             loc_oPg.AddObject("txt_4c__pftioc", "TextBox")
4905:             WITH loc_oPg.txt_4c__pftioc
4906:                 .Alignment     = 3
4907:                 .Height        = 23
4908:                 .InputMask     = "999,999.99999"
4909:                 .Left          = 62
4910:                 .SpecialEffect = 1
4911:                 .Top           = 529
4912:                 .Width         = 94
4913:                 .Value         = 0
4914:                 .Visible       = .T.
4915:             ENDWITH
4916: 
4917:             *-- lblCuVda: "Fator de Custo (Moeda 2)"
4918:             loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
4919:             WITH loc_oPg.lbl_4c_LblCuVda
4920:                 .Caption   = "Fator de Custo (Moeda 2)"
4921:                 .FontName  = "Tahoma"
4922:                 .FontSize  = 8
4923:                 .BackStyle = 0
4924:                 .Height    = 15
4925:                 .Left      = 158
4926:                 .Top       = 474

*-- Linhas 4956 a 5044:
4956:                 .Value         = ""
4957:                 .Visible       = .T.
4958:             ENDWITH
4959:             BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress", THIS, "ValidarMoepc")
4960:             BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress", THIS, "TxtMoepcKeyPress")
4961: 
4962:             *-- Say8: "Total "
4963:             loc_oPg.AddObject("lbl_4c_Label8", "Label")
4964:             WITH loc_oPg.lbl_4c_Label8
4965:                 .Caption   = "Total "
4966:                 .FontName  = "Tahoma"
4967:                 .FontSize  = 8
4968:                 .BackStyle = 0
4969:                 .Height    = 15
4970:                 .Left      = 158
4971:                 .Top       = 514
4972:                 .Width     = 29
4973:                 .ForeColor = RGB(90, 90, 90)
4974:                 .Visible   = .T.
4975:             ENDWITH
4976: 
4977:             *-- getCustof: total custo
4978:             loc_oPg.AddObject("txt_4c_Custof", "TextBox")
4979:             WITH loc_oPg.txt_4c_Custof
4980:                 .Alignment     = 3
4981:                 .Height        = 23
4982:                 .InputMask     = "999,999.99999"
4983:                 .Left          = 159
4984:                 .SpecialEffect = 1
4985:                 .Top           = 529
4986:                 .Width         = 109
4987:                 .Value         = 0
4988:                 .Visible       = .T.
4989:             ENDWITH
4990: 
4991:             *-- txt_4c_Moecusf: moeda total custo (lookup SigCdMoe)
4992:             loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
4993:             WITH loc_oPg.txt_4c_Moecusf
4994:                 .Height        = 23
4995:                 .Left          = 270
4996:                 .MaxLength     = 3
4997:                 .SpecialEffect = 1
4998:                 .Top           = 529
4999:                 .Width         = 31
5000:                 .Value         = ""
5001:                 .Visible       = .T.
5002:             ENDWITH
5003:             BINDEVENT(loc_oPg.txt_4c_Moecusf, "KeyPress", THIS, "ValidarMoecusf")
5004:             BINDEVENT(loc_oPg.txt_4c_Moecusf, "KeyPress", THIS, "TxtMoecusfKeyPress")
5005: 
5006:             *-- Say6: "Peso Medio"
5007:             loc_oPg.AddObject("lbl_4c_Label6", "Label")
5008:             WITH loc_oPg.lbl_4c_Label6
5009:                 .Caption   = "Peso M" + CHR(233) + "dio"
5010:                 .FontName  = "Tahoma"
5011:                 .FontSize  = 8
5012:                 .BackStyle = 0
5013:                 .Height    = 15
5014:                 .Left      = 8
5015:                 .Top       = 553
5016:                 .Width     = 56
5017:                 .ForeColor = RGB(90, 90, 90)
5018:                 .Visible   = .T.
5019:             ENDWITH
5020: 
5021:             *-- getPesom: peso medio
5022:             loc_oPg.AddObject("txt_4c_Peso", "TextBox")
5023:             WITH loc_oPg.txt_4c_Peso
5024:                 .Alignment     = 3
5025:                 .Format        = "K"
5026:                 .Height        = 23
5027:                 .InputMask     = "99,999.999"
5028:                 .Left          = 8
5029:                 .MaxLength     = 10
5030:                 .SpecialEffect = 1
5031:                 .Top           = 568
5032:                 .Width         = 79
5033:                 .Value         = 0
5034:                 .Visible       = .T.
5035:             ENDWITH
5036: 
5037:             *-- Say10: "Var. Peso %"
5038:             loc_oPg.AddObject("lbl_4c_Label10", "Label")
5039:             WITH loc_oPg.lbl_4c_Label10
5040:                 .Caption   = "Var. Peso %"
5041:                 .FontName  = "Tahoma"
5042:                 .FontSize  = 8
5043:                 .BackStyle = 0
5044:                 .Height    = 15

*-- Linhas 5184 a 5398:
5184:                 .Value         = ""
5185:                 .Visible       = .T.
5186:             ENDWITH
5187:             BINDEVENT(loc_oPg.txt_4c_Ftio, "KeyPress", THIS, "ValidarFtio")
5188:             BINDEVENT(loc_oPg.txt_4c_Ftio, "KeyPress", THIS, "TxtFtioKeyPress")
5189: 
5190:             *-- getStatus: status do produto (lookup SigCdPst)
5191:             loc_oPg.AddObject("txt_4c_Status", "TextBox")
5192:             WITH loc_oPg.txt_4c_Status
5193:                 .Format        = "K"
5194:                 .Height        = 23
5195:                 .Left          = 384
5196:                 .MaxLength     = 3
5197:                 .SpecialEffect = 1
5198:                 .Top           = 529
5199:                 .Width         = 31
5200:                 .Value         = ""
5201:                 .Visible       = .T.
5202:             ENDWITH
5203:             BINDEVENT(loc_oPg.txt_4c_Status, "KeyPress", THIS, "ValidarStatus")
5204:             BINDEVENT(loc_oPg.txt_4c_Status, "KeyPress", THIS, "TxtStatusKeyPress")
5205: 
5206:             *-- Say24: "Sts"
5207:             loc_oPg.AddObject("lbl_4c_Label24", "Label")
5208:             WITH loc_oPg.lbl_4c_Label24
5209:                 .Caption   = "Sts"
5210:                 .FontName  = "Tahoma"
5211:                 .FontSize  = 8
5212:                 .BackStyle = 0
5213:                 .Height    = 15
5214:                 .Left      = 384
5215:                 .Top       = 514
5216:                 .Width     = 17
5217:                 .ForeColor = RGB(90, 90, 90)
5218:                 .Visible   = .T.
5219:             ENDWITH
5220: 
5221:             *-- chkPlanVen: planejamento venda
5222:             loc_oPg.AddObject("chk_4c_ChkPlanVen", "CheckBox")
5223:             WITH loc_oPg.chk_4c_ChkPlanVen
5224:                 .Top           = 528
5225:                 .Left          = 447
5226:                 .Height        = 25
5227:                 .Width         = 25
5228:                 .Picture       = gc_4c_CaminhoIcones + "geral_datas_26.jpg"
5229:                 .Alignment     = 0
5230:                 .Caption       = ""
5231:                 .Value         = 0
5232:                 .SpecialEffect = 0
5233:                 .Style         = 1
5234:                 .BackColor     = RGB(162, 214, 242)
5235:                 .Visible       = .T.
5236:             ENDWITH
5237:             BINDEVENT(loc_oPg.chk_4c_ChkPlanVen, "Click", THIS, "ChkPlanVenClick")
5238: 
5239:             *-- Chk_Pvenda: copia preco ideal para atual
5240:             loc_oPg.AddObject("chk_4c_Chk_Pvenda", "CheckBox")
5241:             WITH loc_oPg.chk_4c_Chk_Pvenda
5242:                 .Top           = 567
5243:                 .Left          = 447
5244:                 .Height        = 25
5245:                 .Width         = 25
5246:                 .Picture       = gc_4c_CaminhoIcones + "a_arrow1.bmp"
5247:                 .Alignment     = 0
5248:                 .Caption       = ""
5249:                 .Value         = 0
5250:                 .SpecialEffect = 0
5251:                 .Style         = 1
5252:                 .BackColor     = RGB(255, 255, 255)
5253:                 .Visible       = .T.
5254:             ENDWITH
5255:             BINDEVENT(loc_oPg.chk_4c_Chk_Pvenda, "Click", THIS, "ChkPvendaClick")
5256: 
5257:             *-- Say13: "Valor Adicional" (venda)
5258:             loc_oPg.AddObject("lbl_4c_Label13", "Label")
5259:             WITH loc_oPg.lbl_4c_Label13
5260:                 .Caption   = "Valor Adicional"
5261:                 .FontName  = "Tahoma"
5262:                 .FontSize  = 8
5263:                 .BackStyle = 0
5264:                 .Height    = 15
5265:                 .Left      = 476
5266:                 .Top       = 514
5267:                 .Width     = 71
5268:                 .ForeColor = RGB(90, 90, 90)
5269:                 .Visible   = .T.
5270:             ENDWITH
5271: 
5272:             *-- Get_Pftio: valor adicional venda
5273:             loc_oPg.AddObject("txt_4c_Pftio", "TextBox")
5274:             WITH loc_oPg.txt_4c_Pftio
5275:                 .Alignment     = 3
5276:                 .Height        = 23
5277:                 .InputMask     = "999,999.99999"
5278:                 .Left          = 476
5279:                 .SpecialEffect = 1
5280:                 .Top           = 529
5281:                 .Width         = 105
5282:                 .Value         = 0
5283:                 .Visible       = .T.
5284:             ENDWITH
5285: 
5286:             *-- Get_mftio: moeda valor adicional venda (lookup SigCdMoe)
5287:             loc_oPg.AddObject("txt_4c_Mftio", "TextBox")
5288:             WITH loc_oPg.txt_4c_Mftio
5289:                 .Height        = 23
5290:                 .Left          = 584
5291:                 .MaxLength     = 3
5292:                 .SpecialEffect = 1
5293:                 .Top           = 529
5294:                 .Width         = 31
5295:                 .Value         = ""
5296:                 .Visible       = .T.
5297:             ENDWITH
5298:             BINDEVENT(loc_oPg.txt_4c_Mftio, "KeyPress", THIS, "ValidarMftio")
5299:             BINDEVENT(loc_oPg.txt_4c_Mftio, "KeyPress", THIS, "TxtMftioKeyPress")
5300: 
5301:             *-- Say12: "Fator"
5302:             loc_oPg.AddObject("lbl_4c_Label12", "Label")
5303:             WITH loc_oPg.lbl_4c_Label12
5304:                 .Caption   = "Fator"
5305:                 .FontName  = "Tahoma"
5306:                 .FontSize  = 8
5307:                 .BackStyle = 0
5308:                 .Height    = 15
5309:                 .Left      = 618
5310:                 .Top       = 514
5311:                 .Width     = 28
5312:                 .ForeColor = RGB(90, 90, 90)
5313:                 .Visible   = .T.
5314:             ENDWITH
5315: 
5316:             *-- getFvenda: fator de venda
5317:             loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
5318:             WITH loc_oPg.txt_4c_Fvenda
5319:                 .Alignment     = 3
5320:                 .Height        = 23
5321:                 .InputMask     = "99,999.99999"
5322:                 .Left          = 618
5323:                 .SpecialEffect = 1
5324:                 .Top           = 529
5325:                 .Width         = 105
5326:                 .Value         = 0
5327:                 .Visible       = .T.
5328:             ENDWITH
5329: 
5330:             *-- getMoepv: moeda fator de venda (lookup SigCdMoe)
5331:             loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
5332:             WITH loc_oPg.txt_4c_Moepv
5333:                 .Height        = 23
5334:                 .Left          = 726
5335:                 .MaxLength     = 3
5336:                 .SpecialEffect = 1
5337:                 .Top           = 529
5338:                 .Width         = 31
5339:                 .Value         = ""
5340:                 .Visible       = .T.
5341:             ENDWITH
5342:             BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "ValidarMoepv")
5343:             BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "TxtMoepvKeyPress")
5344: 
5345:             *-- getMoeda: moeda de venda ideal (lookup SigCdMoe)
5346:             loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
5347:             WITH loc_oPg.txt_4c_Moeda
5348:                 .Height        = 23
5349:                 .Left          = 584
5350:                 .MaxLength     = 3
5351:                 .SpecialEffect = 1
5352:                 .Top           = 489
5353:                 .Width         = 31
5354:                 .Value         = ""
5355:                 .Visible       = .T.
5356:             ENDWITH
5357:             BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
5358:             BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaKeyPress")
5359: 
5360:             *-- lblIdeal: "Preco Ideal (Moeda 1)"
5361:             loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
5362:             WITH loc_oPg.lbl_4c_LblIdeal
5363:                 .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
5364:                 .FontName  = "Tahoma"
5365:                 .FontSize  = 8
5366:                 .BackStyle = 0
5367:                 .Height    = 15
5368:                 .Left      = 476
5369:                 .Top       = 475
5370:                 .Width     = 111
5371:                 .ForeColor = RGB(90, 90, 90)
5372:                 .Visible   = .T.
5373:             ENDWITH
5374: 
5375:             *-- getPvideal: preco ideal
5376:             loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
5377:             WITH loc_oPg.txt_4c_Pvideal
5378:                 .Alignment     = 3
5379:                 .Height        = 23
5380:                 .InputMask     = "999,999.99999"
5381:                 .Left          = 476
5382:                 .SpecialEffect = 1
5383:                 .Top           = 489
5384:                 .Width         = 105
5385:                 .Value         = 0
5386:                 .Visible       = .T.
5387:             ENDWITH
5388: 
5389:             *-- lblFIdeals: "Fator Ideal"
5390:             loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
5391:             WITH loc_oPg.lbl_4c_LblFIdeals
5392:                 .Caption   = "Fator Ideal"
5393:                 .FontName  = "Tahoma"
5394:                 .FontSize  = 8
5395:                 .BackStyle = 0
5396:                 .Height    = 15
5397:                 .Left      = 618
5398:                 .Top       = 475

*-- Linhas 5485 a 5529:
5485:                 .Value         = ""
5486:                 .Visible       = .T.
5487:             ENDWITH
5488:             BINDEVENT(loc_oPg.txt_4c_Moev, "KeyPress", THIS, "ValidarMoev")
5489:             BINDEVENT(loc_oPg.txt_4c_Moev, "KeyPress", THIS, "TxtMoevKeyPress")
5490: 
5491:             *-- lblFAtuals: "Fator Atual"
5492:             loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
5493:             WITH loc_oPg.lbl_4c_LblFAtuals
5494:                 .Caption   = "Fator Atual"
5495:                 .FontName  = "Tahoma"
5496:                 .FontSize  = 8
5497:                 .BackStyle = 0
5498:                 .Height    = 15
5499:                 .Left      = 618
5500:                 .Top       = 553
5501:                 .Width     = 56
5502:                 .ForeColor = RGB(90, 90, 90)
5503:                 .Visible   = .T.
5504:             ENDWITH
5505: 
5506:             *-- getFAtuals: fator atual
5507:             loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
5508:             WITH loc_oPg.txt_4c_FAtuals
5509:                 .Alignment     = 3
5510:                 .Height        = 23
5511:                 .InputMask     = "999,999.99999"
5512:                 .Left          = 618
5513:                 .SpecialEffect = 1
5514:                 .Top           = 568
5515:                 .Width         = 105
5516:                 .Value         = 0
5517:                 .Visible       = .T.
5518:             ENDWITH
5519: 
5520:             *-- Say25: "Financeiro"
5521:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
5522:             WITH loc_oPg.lbl_4c_Label25
5523:                 .Caption   = "Financeiro"
5524:                 .FontName  = "Tahoma"
5525:                 .FontSize  = 8
5526:                 .BackStyle = 0
5527:                 .Height    = 15
5528:                 .Left      = 727
5529:                 .Top       = 553

*-- Linhas 5563 a 5606:
5563:                 .BackColor     = RGB(255, 255, 255)
5564:                 .Visible       = .T.
5565:             ENDWITH
5566:             BINDEVENT(loc_oPg.cmd_4c_CmdCalcVals, "Click", THIS, "CmdCalcValsClick")
5567: 
5568:             *==============================================================
5569:             *-- cntMtPrima: container de informacoes de materia prima
5570:             *==============================================================
5571:             loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
5572:             WITH loc_oPg.cnt_4c_MtPrima
5573:                 .Top           = 471
5574:                 .Left          = 785
5575:                 .Width         = 211
5576:                 .Height        = 124
5577:                 .BackStyle     = 0
5578:                 .BorderWidth   = 0
5579:                 .SpecialEffect = 0
5580:                 .Visible       = .T.
5581:             ENDWITH
5582:             loc_oCnt = loc_oPg.cnt_4c_MtPrima
5583: 
5584:             loc_oCnt.AddObject("lbl_4c_LblCompos", "Label")
5585:             WITH loc_oCnt.lbl_4c_LblCompos
5586:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
5587:                 .FontBold  = .F.
5588:                 .FontName  = "Tahoma"
5589:                 .FontSize  = 8
5590:                 .BackStyle = 0
5591:                 .Height    = 15
5592:                 .Left      = 6
5593:                 .Top       = 6
5594:                 .Width     = 66
5595:                 .ForeColor = RGB(90, 90, 90)
5596:                 .Visible   = .T.
5597:             ENDWITH
5598: 
5599:             loc_oCnt.AddObject("txt_4c_Compos", "TextBox")
5600:             WITH loc_oCnt.txt_4c_Compos
5601:                 .FontName            = "Tahoma"
5602:                 .Height              = 23
5603:                 .Left                = 6
5604:                 .SpecialEffect       = 1
5605:                 .Top                 = 20
5606:                 .Width               = 202

*-- Linhas 5745 a 6371:
5745:     * GrdCons: 9 colunas (top=149, left=6, width=987, height=347)
5746:     * grDTEMP: 2 colunas (top=500, left=821, width=172, height=107)
5747:     *===========================================================================
5748:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPg)
5749:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oErro
5750:         TRY
5751:             loc_oPg = par_oPg
5752:             loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
5753: 
5754:             *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
5755:             IF !USED("cursor_4c_GrdConsP")
5756:                 CREATE CURSOR cursor_4c_GrdConsP ( ;
5757:                     mats      C(14), qtds     N(8,3),  unicompos C(3), ;
5758:                     grupos    C(10), dscgrp   C(20),   ordems    N(2,0), ;
5759:                     qtscons   N(8,3), cats    C(6),    dcats     C(15))
5760:             ENDIF
5761:             IF !USED("cursor_4c_GrDTEMP")
5762:                 CREATE CURSOR cursor_4c_GrDTEMP (grupos C(10), tempopct N(8,3))
5763:             ENDIF
5764: 
5765:             *-- grd_4c_GrdConsP: grade principal de consumo por processo (9 colunas)
5766:             *-- Original GrdCons: top=149, left=6, width=987, height=347, columnCount=9
5767:             loc_oPg.AddObject("grd_4c_GrdConsP", "Grid")
5768:             WITH loc_oPg.grd_4c_GrdConsP
5769:                 .Top        = 149
5770:                 .Left       = 6
5771:                 .Width      = 987
5772:                 .Height     = 347
5773:                 .FontName   = "Tahoma"
5774:                 .FontSize   = 8
5775:                 .RecordMark = .F.
5776:                 .DeleteMark = .F.
5777:                 .RowHeight  = 18
5778:                 .ScrollBars = 3
5779:                 .GridLines  = 3
5780:                 .GridLineColor      = RGB(238, 238, 238)
5781:                 .HighlightBackColor = RGB(255, 255, 255)
5782:                 .HighlightForeColor = RGB(15, 41, 104)
5783:                 .HighlightStyle     = 2
5784:                 .AllowHeaderSizing  = .F.
5785:                 .AllowRowSizing     = .F.
5786:                 .Visible    = .T.
5787:             ENDWITH
5788:             loc_oPg.grd_4c_GrdConsP.ColumnCount  = 9
5789:             loc_oPg.grd_4c_GrdConsP.RecordSource = "cursor_4c_GrdConsP"
5790:             loc_oGrid = loc_oPg.grd_4c_GrdConsP
5791: 
5792:             *-- Column1: Componente (mats C14) - somente leitura (When=.F. original)
5793:             loc_oGrid.Column1.ControlSource    = "cursor_4c_GrdConsP.mats"
5794:             loc_oGrid.Column1.Width            = 130
5795:             loc_oGrid.Column1.ReadOnly         = .T.
5796:             loc_oGrid.Column1.Movable          = .F.
5797:             loc_oGrid.Column1.Resizable        = .F.
5798:             loc_oGrid.Column1.Header1.Caption  = "Componente"
5799: 
5800:             *-- Column2: Qtde. (qtds N8.3) - somente leitura (When=.F. original)
5801:             loc_oGrid.Column2.ControlSource    = "cursor_4c_GrdConsP.qtds"
5802:             loc_oGrid.Column2.Width            = 65
5803:             loc_oGrid.Column2.ReadOnly         = .T.
5804:             loc_oGrid.Column2.Movable          = .F.
5805:             loc_oGrid.Column2.Resizable        = .F.
5806:             loc_oGrid.Column2.InputMask        = "9999.999"
5807:             loc_oGrid.Column2.Header1.Caption  = "Qtde."
5808: 
5809:             *-- Column3: Uni (unicompos C3) - somente leitura (When=.F. original)
5810:             loc_oGrid.Column3.ControlSource    = "cursor_4c_GrdConsP.unicompos"
5811:             loc_oGrid.Column3.Width            = 38
5812:             loc_oGrid.Column3.ReadOnly         = .T.
5813:             loc_oGrid.Column3.Movable          = .F.
5814:             loc_oGrid.Column3.Resizable        = .F.
5815:             loc_oGrid.Column3.Header1.Caption  = "Uni"
5816: 
5817:             *-- Column4: Fase (grupos C10) - editavel, lookup SigCdGcr
5818:             *-- Original When: Return(Inlist(ThisForm.pcEscolha,'INSERIR','ALTERAR'))
5819:             loc_oGrid.Column4.ControlSource    = "cursor_4c_GrdConsP.grupos"
5820:             loc_oGrid.Column4.Width            = 80
5821:             loc_oGrid.Column4.ReadOnly         = .F.
5822:             loc_oGrid.Column4.Movable          = .F.
5823:             loc_oGrid.Column4.Resizable        = .F.
5824:             loc_oGrid.Column4.Header1.Caption  = "Fase"
5825:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdConsPCol4FaseValid")
5826: 
5827:             *-- Column5: Descricao fase (dscgrp C20) - editavel, lookup SigCdGcr por descrs
5828:             *-- Original When: Return(Inlist(...) And Empty(Column4.Text1.Value))
5829:             loc_oGrid.Column5.ControlSource    = "cursor_4c_GrdConsP.dscgrp"
5830:             loc_oGrid.Column5.Width            = 180
5831:             loc_oGrid.Column5.ReadOnly         = .F.
5832:             loc_oGrid.Column5.Movable          = .F.
5833:             loc_oGrid.Column5.Resizable        = .F.
5834:             loc_oGrid.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
5835:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdConsPCol5DescFaseValid")
5836: 
5837:             *-- Column6: Ord. (ordems N2) - somente leitura (When=.F. original)
5838:             loc_oGrid.Column6.ControlSource    = "cursor_4c_GrdConsP.ordems"
5839:             loc_oGrid.Column6.Width            = 40
5840:             loc_oGrid.Column6.ReadOnly         = .T.
5841:             loc_oGrid.Column6.Movable          = .F.
5842:             loc_oGrid.Column6.Resizable        = .F.
5843:             loc_oGrid.Column6.InputMask        = "99"
5844:             loc_oGrid.Column6.Header1.Caption  = "Ord."
5845: 
5846:             *-- Column7: Consumo (qtscons N8.3) - editavel
5847:             *-- Original When: Return Inlist(ThisForm.pcEscolha,'INSERIR','ALTERAR')
5848:             loc_oGrid.Column7.ControlSource    = "cursor_4c_GrdConsP.qtscons"
5849:             loc_oGrid.Column7.Width            = 75
5850:             loc_oGrid.Column7.ReadOnly         = .F.
5851:             loc_oGrid.Column7.Movable          = .F.
5852:             loc_oGrid.Column7.Resizable        = .F.
5853:             loc_oGrid.Column7.InputMask        = "9999.999"
5854:             loc_oGrid.Column7.Header1.Caption  = "Consumo"
5855: 
5856:             *-- Column8: Cat. (cats C6) - editavel, lookup SigCdCat por Cods
5857:             *-- Original When: Return(InList(ThisForm.pcEscolha,"INSERIR","ALTERAR"))
5858:             loc_oGrid.Column8.ControlSource    = "cursor_4c_GrdConsP.cats"
5859:             loc_oGrid.Column8.Width            = 55
5860:             loc_oGrid.Column8.ReadOnly         = .F.
5861:             loc_oGrid.Column8.Movable          = .F.
5862:             loc_oGrid.Column8.Resizable        = .F.
5863:             loc_oGrid.Column8.Header1.Caption  = "Cat."
5864:             BINDEVENT(loc_oGrid.Column8.Text1, "Valid", THIS, "GrdConsPCol8CatValid")
5865: 
5866:             *-- Column9: Descricao Cat. (dcats C15) - somente leitura
5867:             loc_oGrid.Column9.ControlSource    = "cursor_4c_GrdConsP.dcats"
5868:             loc_oGrid.Column9.Width            = 185
5869:             loc_oGrid.Column9.ReadOnly         = .T.
5870:             loc_oGrid.Column9.Movable          = .F.
5871:             loc_oGrid.Column9.Resizable        = .F.
5872:             loc_oGrid.Column9.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
5873: 
5874:             BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdConsPAfterRowColChange")
5875: 
5876:             *-- lbl_4c_Label7: "Qtde Componentes :" (Say7: top=505, left=23, w=105)
5877:             loc_oPg.AddObject("lbl_4c_Label7", "Label")
5878:             WITH loc_oPg.lbl_4c_Label7
5879:                 .Caption   = "Qtde Componentes : "
5880:                 .Top       = 505
5881:                 .Left      = 23
5882:                 .Width     = 105
5883:                 .Height    = 15
5884:                 .FontName  = "Tahoma"
5885:                 .FontSize  = 8
5886:                 .ForeColor = RGB(90, 90, 90)
5887:                 .BackStyle = 0
5888:                 .Visible   = .T.
5889:             ENDWITH
5890: 
5891:             *-- txt_4c_Qtcpnt: quantidade componentes (Getqtcpnt: top=500, left=132, w=31, h=23)
5892:             *-- Original When: Return InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
5893:             loc_oPg.AddObject("txt_4c_Qtcpnt", "TextBox")
5894:             WITH loc_oPg.txt_4c_Qtcpnt
5895:                 .Top               = 500
5896:                 .Left              = 132
5897:                 .Width             = 31
5898:                 .Height            = 23
5899:                 .FontName          = "Tahoma"
5900:                 .FontSize          = 8
5901:                 .SpecialEffect     = 1
5902:                 .InputMask         = "99"
5903:                 .Value             = 0
5904:                 .Enabled           = .F.
5905:                 .DisabledBackColor = RGB(255, 255, 255)
5906:                 .DisabledForeColor = RGB(0, 0, 0)
5907:                 .Visible           = .T.
5908:             ENDWITH
5909:             BINDEVENT(loc_oPg.txt_4c_Qtcpnt, "When", THIS, "TxtQtcpntWhen")
5910: 
5911:             *-- chk_4c_ChkFund: (chkFund: top=525, left=11, w=182, h=15)
5912:             *-- Original caption: "Nao Checar Cadastro de Fundicao"
5913:             loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
5914:             WITH loc_oPg.chk_4c_ChkFund
5915:                 .Caption   = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
5916:                 .Top       = 525
5917:                 .Left      = 11
5918:                 .Width     = 182
5919:                 .Height    = 15
5920:                 .FontName  = "Tahoma"
5921:                 .FontSize  = 8
5922:                 .ForeColor = RGB(90, 90, 90)
5923:                 .BackStyle = 0
5924:                 .Value     = 0
5925:                 .Visible   = .T.
5926:             ENDWITH
5927:             BINDEVENT(loc_oPg.chk_4c_ChkFund, "Click", THIS, "ChkFundClick")
5928: 
5929:             *-- lbl_4c_Label1: "Tempo Producao por Agrupamento :" (Say1: top=501, left=643, w=176)
5930:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
5931:             WITH loc_oPg.lbl_4c_Label1
5932:                 .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
5933:                 .Top       = 501
5934:                 .Left      = 643
5935:                 .Width     = 176
5936:                 .Height    = 15
5937:                 .FontName  = "Tahoma"
5938:                 .FontSize  = 8
5939:                 .ForeColor = RGB(90, 90, 90)
5940:                 .BackStyle = 0
5941:                 .Visible   = .T.
5942:             ENDWITH
5943: 
5944:             *-- grd_4c_GrDTEMP: grade tempo producao por agrupamento
5945:             *-- Original grDTEMP: top=500, left=821, w=172, h=107, 2 colunas (ambas readonly)
5946:             loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
5947:             WITH loc_oPg.grd_4c_GrDTEMP
5948:                 .Top        = 500
5949:                 .Left       = 821
5950:                 .Width      = 172
5951:                 .Height     = 107
5952:                 .FontName   = "Tahoma"
5953:                 .FontSize   = 8
5954:                 .RecordMark = .F.
5955:                 .DeleteMark = .F.
5956:                 .RowHeight  = 18
5957:                 .ScrollBars = 2
5958:                 .GridLines  = 3
5959:                 .AllowHeaderSizing = .F.
5960:                 .AllowRowSizing    = .F.
5961:                 .Visible    = .T.
5962:             ENDWITH
5963:             loc_oPg.grd_4c_GrDTEMP.ColumnCount  = 2
5964:             loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
5965:             loc_oGrid2 = loc_oPg.grd_4c_GrDTEMP
5966: 
5967:             *-- Column1: Agrupamento (grupos C10) - somente leitura (When=.F. original)
5968:             loc_oGrid2.Column1.ControlSource    = "cursor_4c_GrDTEMP.grupos"
5969:             loc_oGrid2.Column1.Width            = 100
5970:             loc_oGrid2.Column1.ReadOnly         = .T.
5971:             loc_oGrid2.Column1.Header1.Caption  = "Agrupamento"
5972: 
5973:             *-- Column2: Tempo % (tempopct N8.3) - somente leitura (When=.F. original)
5974:             loc_oGrid2.Column2.ControlSource    = "cursor_4c_GrDTEMP.tempopct"
5975:             loc_oGrid2.Column2.Width            = 72
5976:             loc_oGrid2.Column2.ReadOnly         = .T.
5977:             loc_oGrid2.Column2.InputMask        = "9999.99"
5978:             loc_oGrid2.Column2.Header1.Caption  = "Tempo %"
5979: 
5980:         CATCH TO loc_oErro
5981:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Consumo por Processo:" + ;
5982:                 CHR(13) + loc_oErro.Message, "FormProduto.ConfigurarPgPgDadosConsP")
5983:         ENDTRY
5984:     ENDPROC
5985: 
5986:     *===========================================================================
5987:     * Handlers de BINDEVENT para pgDadosConsP (Page5)
5988:     * Todos PUBLIC - requerido pelo BINDEVENT
5989:     *===========================================================================
5990: 
5991:     *-- Controla acesso ao campo Qtde Componentes
5992:     *-- Original When: Return InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
5993:     PROCEDURE TxtQtcpntWhen()
5994:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
5995:     ENDPROC
5996: 
5997:     *-- Checkbox "Nao Checar Cadastro de Fundicao"
5998:     PROCEDURE ChkFundClick()
5999:         LOCAL loc_oPg, loException
6000:         TRY
6001:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
6002:             IF PEMSTATUS(loc_oPg, "chk_4c_ChkFund", 5) AND VARTYPE(THIS.this_oBusinessObject) = "O"
6003:                 THIS.this_oBusinessObject.this_lChkfunds = (loc_oPg.chk_4c_ChkFund.Value = 1)
6004:             ENDIF
6005:         CATCH TO loException
6006:             MostrarErro("Erro ao atualizar ChkFund:" + CHR(13) + loException.Message, ;
6007:                 "FormProduto.ChkFundClick")
6008:         ENDTRY
6009:     ENDPROC
6010: 
6011:     *-- Column4 (Fase/Grupos): Valid - lookup SigCdGcr por codigos
6012:     *-- Original: fwBuscaInt crSigCdPrf GrpOrdem (Grupos+Ordems)
6013:     PROCEDURE GrdConsPCol4FaseValid()
6014:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6015:             RETURN .T.
6016:         ENDIF
6017:         LOCAL loc_cGrupos, loc_nRet, loc_lSucesso, loException
6018:         loc_lSucesso = .T.
6019:         TRY
6020:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6021:                 loc_cGrupos = ALLTRIM(cursor_4c_GrdConsP.grupos)
6022:                 IF !EMPTY(loc_cGrupos)
6023:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6024:                         "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupos), ;
6025:                         "cursor_4c_GcrFase")
6026:                     IF loc_nRet > 0 AND USED("cursor_4c_GcrFase") AND !EOF("cursor_4c_GcrFase")
6027:                         SELECT cursor_4c_GrdConsP
6028:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(cursor_4c_GcrFase.descrs)
6029:                         IF USED("cursor_4c_GcrFase")
6030:                             USE IN cursor_4c_GcrFase
6031:                         ENDIF
6032:                     ELSE
6033:                         IF USED("cursor_4c_GcrFase")
6034:                             USE IN cursor_4c_GcrFase
6035:                         ENDIF
6036:                         THIS.AbrirBuscaFaseConsP()
6037:                     ENDIF
6038:                 ENDIF
6039:             ENDIF
6040:         CATCH TO loException
6041:             IF USED("cursor_4c_GcrFase")
6042:                 USE IN cursor_4c_GcrFase
6043:             ENDIF
6044:             MostrarErro("Erro ao validar Fase:" + CHR(13) + loException.Message, ;
6045:                 "FormProduto.GrdConsPCol4FaseValid")
6046:         ENDTRY
6047:         RETURN loc_lSucesso
6048:     ENDPROC
6049: 
6050:     *-- Column5 (Descricao Fase/dscgrp): Valid - lookup SigCdGcr por descrs
6051:     *-- Original: fwBuscaInt crSigCdPrf Descrs
6052:     PROCEDURE GrdConsPCol5DescFaseValid()
6053:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6054:             RETURN .T.
6055:         ENDIF
6056:         LOCAL loc_cDescrs, loc_nRet, loc_lSucesso, loException
6057:         loc_lSucesso = .T.
6058:         TRY
6059:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6060:                 loc_cDescrs = ALLTRIM(cursor_4c_GrdConsP.dscgrp)
6061:                 IF !EMPTY(loc_cDescrs)
6062:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6063:                         "SELECT codigos, descrs FROM SigCdGcr WHERE descrs = " + EscaparSQL(loc_cDescrs), ;
6064:                         "cursor_4c_GcrDescFase")
6065:                     IF loc_nRet > 0 AND USED("cursor_4c_GcrDescFase") AND !EOF("cursor_4c_GcrDescFase")
6066:                         SELECT cursor_4c_GrdConsP
6067:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(cursor_4c_GcrDescFase.codigos)
6068:                         IF USED("cursor_4c_GcrDescFase")
6069:                             USE IN cursor_4c_GcrDescFase
6070:                         ENDIF
6071:                     ELSE
6072:                         IF USED("cursor_4c_GcrDescFase")
6073:                             USE IN cursor_4c_GcrDescFase
6074:                         ENDIF
6075:                         THIS.AbrirBuscaDescFaseConsP()
6076:                     ENDIF
6077:                 ENDIF
6078:             ENDIF
6079:         CATCH TO loException
6080:             IF USED("cursor_4c_GcrDescFase")
6081:                 USE IN cursor_4c_GcrDescFase
6082:             ENDIF
6083:             MostrarErro("Erro ao validar Descri" + CHR(231) + CHR(227) + "o Fase:" + ;
6084:                 CHR(13) + loException.Message, "FormProduto.GrdConsPCol5DescFaseValid")
6085:         ENDTRY
6086:         RETURN loc_lSucesso
6087:     ENDPROC
6088: 
6089:     *-- Column8 (Cat./cats): Valid - lookup SigCdCat por Cods
6090:     *-- Original: fwBuscaExt SigCdCat CrListaRemota Cods
6091:     PROCEDURE GrdConsPCol8CatValid()
6092:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6093:             RETURN .T.
6094:         ENDIF
6095:         LOCAL loc_cCats, loc_nRet, loc_lSucesso, loException
6096:         loc_lSucesso = .T.
6097:         TRY
6098:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6099:                 loc_cCats = ALLTRIM(cursor_4c_GrdConsP.cats)
6100:                 IF EMPTY(loc_cCats)
6101:                     SELECT cursor_4c_GrdConsP
6102:                     REPLACE cursor_4c_GrdConsP.dcats WITH ""
6103:                 ELSE
6104:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6105:                         "SELECT cods, descs FROM SigCdCat WHERE cods = " + EscaparSQL(loc_cCats), ;
6106:                         "cursor_4c_CatBusca")
6107:                     IF loc_nRet > 0 AND USED("cursor_4c_CatBusca") AND !EOF("cursor_4c_CatBusca")
6108:                         SELECT cursor_4c_GrdConsP
6109:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(cursor_4c_CatBusca.descs)
6110:                         IF USED("cursor_4c_CatBusca")
6111:                             USE IN cursor_4c_CatBusca
6112:                         ENDIF
6113:                     ELSE
6114:                         IF USED("cursor_4c_CatBusca")
6115:                             USE IN cursor_4c_CatBusca
6116:                         ENDIF
6117:                         THIS.AbrirBuscaCatConsP()
6118:                     ENDIF
6119:                 ENDIF
6120:             ENDIF
6121:         CATCH TO loException
6122:             IF USED("cursor_4c_CatBusca")
6123:                 USE IN cursor_4c_CatBusca
6124:             ENDIF
6125:             MostrarErro("Erro ao validar Categoria:" + CHR(13) + loException.Message, ;
6126:                 "FormProduto.GrdConsPCol8CatValid")
6127:         ENDTRY
6128:         RETURN loc_lSucesso
6129:     ENDPROC
6130: 
6131:     *-- AfterRowColChange: atualiza colunas de descricao ao navegar no grid
6132:     PROCEDURE GrdConsPAfterRowColChange(par_nColIndex)
6133:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6134:             RETURN
6135:         ENDIF
6136:         LOCAL loc_nRet, loException
6137:         TRY
6138:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6139:                 *-- Atualizar dcats (Column9) se cats (Column8) foi preenchido
6140:                 IF !EMPTY(ALLTRIM(cursor_4c_GrdConsP.cats)) AND EMPTY(ALLTRIM(cursor_4c_GrdConsP.dcats))
6141:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6142:                         "SELECT descs FROM SigCdCat WHERE cods = " + EscaparSQL(ALLTRIM(cursor_4c_GrdConsP.cats)), ;
6143:                         "cursor_4c_GCatDesc")
6144:                     IF loc_nRet > 0 AND USED("cursor_4c_GCatDesc") AND !EOF("cursor_4c_GCatDesc")
6145:                         SELECT cursor_4c_GrdConsP
6146:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(cursor_4c_GCatDesc.descs)
6147:                     ENDIF
6148:                     IF USED("cursor_4c_GCatDesc")
6149:                         USE IN cursor_4c_GCatDesc
6150:                     ENDIF
6151:                 ENDIF
6152:                 *-- Atualizar dscgrp (Column5) se grupos (Column4) foi preenchido e dscgrp vazio
6153:                 IF !EMPTY(ALLTRIM(cursor_4c_GrdConsP.grupos)) AND EMPTY(ALLTRIM(cursor_4c_GrdConsP.dscgrp))
6154:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6155:                         "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(ALLTRIM(cursor_4c_GrdConsP.grupos)), ;
6156:                         "cursor_4c_GFaseDesc")
6157:                     IF loc_nRet > 0 AND USED("cursor_4c_GFaseDesc") AND !EOF("cursor_4c_GFaseDesc")
6158:                         SELECT cursor_4c_GrdConsP
6159:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(cursor_4c_GFaseDesc.descrs)
6160:                     ENDIF
6161:                     IF USED("cursor_4c_GFaseDesc")
6162:                         USE IN cursor_4c_GFaseDesc
6163:                     ENDIF
6164:                 ENDIF
6165:             ENDIF
6166:         CATCH TO loException
6167:             IF USED("cursor_4c_GCatDesc")
6168:                 USE IN cursor_4c_GCatDesc
6169:             ENDIF
6170:             IF USED("cursor_4c_GFaseDesc")
6171:                 USE IN cursor_4c_GFaseDesc
6172:             ENDIF
6173:             MostrarErro("Erro ao atualizar descri" + CHR(231) + CHR(245) + "es do grid ConsP:" + ;
6174:                 CHR(13) + loException.Message, "FormProduto.GrdConsPAfterRowColChange")
6175:         ENDTRY
6176:     ENDPROC
6177: 
6178:     *===========================================================================
6179:     * AbrirBuscaFaseConsP - Lookup de fase/processo para Column4 de GrdConsP
6180:     * Tabela: SigCdGcr (codigos C10, descrs C40)
6181:     *===========================================================================
6182:     PROCEDURE AbrirBuscaFaseConsP()
6183:         LOCAL loc_oBusca, loc_cValAtual, loc_nRet, loException
6184:         TRY
6185:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6186:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.grupos)
6187: 
6188:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6189:                     "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE " + ;
6190:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
6191:                     "cursor_4c_FaseBusca")
6192: 
6193:                 IF loc_nRet <= 0 OR !USED("cursor_4c_FaseBusca") OR EOF("cursor_4c_FaseBusca")
6194:                     IF USED("cursor_4c_FaseBusca")
6195:                         USE IN cursor_4c_FaseBusca
6196:                     ENDIF
6197:                     SQLEXEC(gnConnHandle, "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
6198:                         "cursor_4c_FaseBusca")
6199:                 ENDIF
6200: 
6201:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6202:                 IF VARTYPE(loc_oBusca) = "O"
6203:                     loc_oBusca.DefinirCursor("cursor_4c_FaseBusca", "codigos", "descrs", ;
6204:                         "Buscar Fase/Processo")
6205:                     loc_oBusca.Mostrar()
6206:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6207:                         SELECT cursor_4c_GrdConsP
6208:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6209:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6210:                     ENDIF
6211:                     loc_oBusca = .NULL.
6212:                 ENDIF
6213: 
6214:                 IF USED("cursor_4c_FaseBusca")
6215:                     USE IN cursor_4c_FaseBusca
6216:                 ENDIF
6217:             ENDIF
6218:         CATCH TO loException
6219:             IF USED("cursor_4c_FaseBusca")
6220:                 USE IN cursor_4c_FaseBusca
6221:             ENDIF
6222:             MostrarErro("Erro ao buscar Fase:" + CHR(13) + loException.Message, ;
6223:                 "FormProduto.AbrirBuscaFaseConsP")
6224:         ENDTRY
6225:     ENDPROC
6226: 
6227:     *===========================================================================
6228:     * AbrirBuscaDescFaseConsP - Lookup de fase por descricao para Column5 de GrdConsP
6229:     * Tabela: SigCdGcr (codigos C10, descrs C40)
6230:     *===========================================================================
6231:     PROCEDURE AbrirBuscaDescFaseConsP()
6232:         LOCAL loc_oBusca, loc_cValAtual, loc_nRet, loException
6233:         TRY
6234:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6235:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.dscgrp)
6236: 
6237:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6238:                     "SELECT descrs, codigos FROM SigCdGcr WHERE descrs LIKE " + ;
6239:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY descrs", ;
6240:                     "cursor_4c_DescFaseBusca")
6241: 
6242:                 IF loc_nRet <= 0 OR !USED("cursor_4c_DescFaseBusca") OR EOF("cursor_4c_DescFaseBusca")
6243:                     IF USED("cursor_4c_DescFaseBusca")
6244:                         USE IN cursor_4c_DescFaseBusca
6245:                     ENDIF
6246:                     SQLEXEC(gnConnHandle, "SELECT descrs, codigos FROM SigCdGcr ORDER BY descrs", ;
6247:                         "cursor_4c_DescFaseBusca")
6248:                 ENDIF
6249: 
6250:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6251:                 IF VARTYPE(loc_oBusca) = "O"
6252:                     loc_oBusca.DefinirCursor("cursor_4c_DescFaseBusca", "descrs", "codigos", ;
6253:                         "Buscar Fase por Descri" + CHR(231) + CHR(227) + "o")
6254:                     loc_oBusca.Mostrar()
6255:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6256:                         SELECT cursor_4c_GrdConsP
6257:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6258:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6259:                     ENDIF
6260:                     loc_oBusca = .NULL.
6261:                 ENDIF
6262: 
6263:                 IF USED("cursor_4c_DescFaseBusca")
6264:                     USE IN cursor_4c_DescFaseBusca
6265:                 ENDIF
6266:             ENDIF
6267:         CATCH TO loException
6268:             IF USED("cursor_4c_DescFaseBusca")
6269:                 USE IN cursor_4c_DescFaseBusca
6270:             ENDIF
6271:             MostrarErro("Erro ao buscar Fase por descri" + CHR(231) + CHR(227) + "o:" + ;
6272:                 CHR(13) + loException.Message, "FormProduto.AbrirBuscaDescFaseConsP")
6273:         ENDTRY
6274:     ENDPROC
6275: 
6276:     *===========================================================================
6277:     * AbrirBuscaCatConsP - Lookup de categoria para Column8 de GrdConsP
6278:     * Tabela: SigCdCat (cods C6, descs C15)
6279:     *===========================================================================
6280:     PROCEDURE AbrirBuscaCatConsP()
6281:         LOCAL loc_oBusca, loc_cValAtual, loc_nRet, loException
6282:         TRY
6283:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6284:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.cats)
6285: 
6286:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6287:                     "SELECT cods, descs FROM SigCdCat WHERE cods LIKE " + ;
6288:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY cods", ;
6289:                     "cursor_4c_CatBusca")
6290: 
6291:                 IF loc_nRet <= 0 OR !USED("cursor_4c_CatBusca") OR EOF("cursor_4c_CatBusca")
6292:                     IF USED("cursor_4c_CatBusca")
6293:                         USE IN cursor_4c_CatBusca
6294:                     ENDIF
6295:                     SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCat ORDER BY cods", ;
6296:                         "cursor_4c_CatBusca")
6297:                 ENDIF
6298: 
6299:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6300:                 IF VARTYPE(loc_oBusca) = "O"
6301:                     loc_oBusca.DefinirCursor("cursor_4c_CatBusca", "cods", "descs", "Buscar Categoria")
6302:                     loc_oBusca.Mostrar()
6303:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6304:                         SELECT cursor_4c_GrdConsP
6305:                         REPLACE cursor_4c_GrdConsP.cats  WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6306:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6307:                     ENDIF
6308:                     loc_oBusca = .NULL.
6309:                 ENDIF
6310: 
6311:                 IF USED("cursor_4c_CatBusca")
6312:                     USE IN cursor_4c_CatBusca
6313:                 ENDIF
6314:             ENDIF
6315:         CATCH TO loException
6316:             IF USED("cursor_4c_CatBusca")
6317:                 USE IN cursor_4c_CatBusca
6318:             ENDIF
6319:             MostrarErro("Erro ao buscar Categoria:" + CHR(13) + loException.Message, ;
6320:                 "FormProduto.AbrirBuscaCatConsP")
6321:         ENDTRY
6322:     ENDPROC
6323: 
6324:     *===========================================================================
6325:     * Handlers de BINDEVENT para pgCusto (Page2)
6326:     * Todos PUBLIC - requerido pelo BINDEVENT
6327:     *===========================================================================
6328: 
6329:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
6330:         LOCAL loc_oPg, loc_nRet, loException
6331:         TRY
6332:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
6333:             IF !USED("cursor_4c_GrdCompo") OR EOF("cursor_4c_GrdCompo")
6334:                 RETURN
6335:             ENDIF
6336:             IF !EMPTY(cursor_4c_GrdCompo.cpros)
6337:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6338:                     "SELECT dpros FROM SigCdPro WHERE cpros = '" + ;
6339:                     EscaparSQL(ALLTRIM(cursor_4c_GrdCompo.cpros)) + "", ;
6340:                     "cursor_4c_DescCusto")
6341:                 IF loc_nRet > 0 AND USED("cursor_4c_DescCusto") AND !EOF("cursor_4c_DescCusto")
6342:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6343:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_DescCusto.dpros)
6344:                     ENDIF
6345:                     USE IN cursor_4c_DescCusto
6346:                 ENDIF
6347:             ELSE
6348:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6349:                     loc_oPg.txt_4c_Desc.Value = ""
6350:                 ENDIF
6351:             ENDIF
6352:             IF !EMPTY(cursor_4c_GrdCompo.cpros)
6353:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6354:                     "SELECT b.dgrus FROM SigCdPro a " + ;
6355:                     "INNER JOIN SigCdGrp b ON a.cgrus = b.cgrus " + ;
6356:                     "WHERE a.cpros = " + EscaparSQL(ALLTRIM(cursor_4c_GrdCompo.cpros)) + "", ;
6357:                     "cursor_4c_GruCusto")
6358:                 IF loc_nRet > 0 AND USED("cursor_4c_GruCusto") AND !EOF("cursor_4c_GruCusto")
6359:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
6360:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCusto.dgrus)
6361:                     ENDIF
6362:                     USE IN cursor_4c_GruCusto
6363:                 ENDIF
6364:             ELSE
6365:                 IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
6366:                     loc_oPg.txt_4c_DGruCompos.Value = ""
6367:                 ENDIF
6368:             ENDIF
6369:         CATCH TO loException
6370:             IF USED("cursor_4c_DescCusto")
6371:                 USE IN cursor_4c_DescCusto

*-- Linhas 6378 a 7115:
6378:         ENDTRY
6379:     ENDPROC
6380: 
6381:     PROCEDURE CmgCustoClick()
6382:         LOCAL loc_oPg, loc_nBotao
6383:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
6384:         loc_nBotao = loc_oPg.cmg_4c_CmdgCusto.Value
6385:         DO CASE
6386:         CASE loc_nBotao = 1
6387:             THIS.CmdCustoInserirClick()
6388:         CASE loc_nBotao = 2
6389:             THIS.CmdCustoExcluirClick()
6390:         ENDCASE
6391:     ENDPROC
6392: 
6393:     PROCEDURE CmdCustoInserirClick()
6394:         LOCAL loException
6395:         TRY
6396:             IF !USED("cursor_4c_GrdCompo")
6397:                 RETURN
6398:             ENDIF
6399:             SELECT cursor_4c_GrdCompo
6400:             APPEND BLANK
6401:         CATCH TO loException
6402:             MostrarErro("Erro ao inserir item de custo:" + CHR(13) + loException.Message, ;
6403:                 "FormProduto.CmdCustoInserirClick")
6404:         ENDTRY
6405:     ENDPROC
6406: 
6407:     PROCEDURE CmdCustoExcluirClick()
6408:         LOCAL loc_lConfirma, loException
6409:         TRY
6410:             IF !USED("cursor_4c_GrdCompo") OR EOF("cursor_4c_GrdCompo")
6411:                 RETURN
6412:             ENDIF
6413:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste item de custo?")
6414:             IF loc_lConfirma
6415:                 SELECT cursor_4c_GrdCompo
6416:                 DELETE
6417:                 IF !EOF()
6418:                     SKIP
6419:                     SKIP -1
6420:                 ENDIF
6421:             ENDIF
6422:         CATCH TO loException
6423:             MostrarErro("Erro ao excluir item de custo:" + CHR(13) + loException.Message, ;
6424:                 "FormProduto.CmdCustoExcluirClick")
6425:         ENDTRY
6426:     ENDPROC
6427: 
6428:     PROCEDURE CboTiposCustoInteractiveChange()
6429:         LOCAL loc_oPg, loc_cTipo, loException
6430:         TRY
6431:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
6432:             IF PEMSTATUS(loc_oPg, "cbo_4c_CmbTipos", 5) AND USED("cursor_4c_GrdCompo")
6433:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
6434:                 SELECT cursor_4c_GrdCompo
6435:                 IF EMPTY(loc_cTipo)
6436:                     SET FILTER TO
6437:                 ELSE
6438:                     SET FILTER TO ALLTRIM(cursor_4c_GrdCompo.cunis) = loc_cTipo
6439:                 ENDIF
6440:                 GO TOP
6441:                 IF PEMSTATUS(loc_oPg, "grd_4c_GrdCusto", 5)
6442:                     loc_oPg.grd_4c_GrdCusto.Refresh()
6443:                 ENDIF
6444:             ENDIF
6445:         CATCH TO loException
6446:             MostrarErro("Erro ao filtrar tipos de custo:" + CHR(13) + loException.Message, ;
6447:                 "FormProduto.CboTiposCustoInteractiveChange")
6448:         ENDTRY
6449:     ENDPROC
6450: 
6451:     *===========================================================================
6452:     * Handlers de BINDEVENT para pgComposicao
6453:     * Todos PUBLIC - requerido pelo BINDEVENT
6454:     *===========================================================================
6455: 
6456:     PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
6457:         LOCAL loc_oPg, loException
6458:         TRY
6459:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6460:             IF USED("cursor_4c_GrdCompo") AND !EOF("cursor_4c_GrdCompo") AND !BOF("cursor_4c_GrdCompo")
6461:                 SELECT cursor_4c_GrdCompo
6462:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6463:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_GrdCompo.dpros)
6464:                 ENDIF
6465:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
6466:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_GrdCompo.matprinc)
6467:                 ENDIF
6468:             ENDIF
6469:         CATCH TO loException
6470:             MostrarErro("Erro ao navegar composicao:" + CHR(13) + loException.Message, ;
6471:                 "FormProduto.GrdCompoAfterRowColChange")
6472:         ENDTRY
6473:     ENDPROC
6474: 
6475:     PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
6476:         LOCAL loc_oPg, loException
6477:         TRY
6478:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6479:             IF USED("cursor_4c_GrdSubCp") AND !EOF("cursor_4c_GrdSubCp") AND !BOF("cursor_4c_GrdSubCp")
6480:                 SELECT cursor_4c_GrdSubCp
6481:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
6482:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_GrdSubCp.dpros)
6483:                 ENDIF
6484:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
6485:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_GrdSubCp.matprinc)
6486:                 ENDIF
6487:             ENDIF
6488:         CATCH TO loException
6489:             MostrarErro("Erro ao navegar subcomposicao:" + CHR(13) + loException.Message, ;
6490:                 "FormProduto.GrdSubCpAfterRowColChange")
6491:         ENDTRY
6492:     ENDPROC
6493: 
6494:     PROCEDURE CmgCompoClick()
6495:         LOCAL loc_oPg, loc_nBotao
6496:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6497:         loc_nBotao = loc_oPg.cmg_4c_CmdgCompo.Value
6498:         DO CASE
6499:         CASE loc_nBotao = 1
6500:             THIS.CmdCompoInserirClick()
6501:         CASE loc_nBotao = 2
6502:             THIS.CmdCompoExcluirClick()
6503:         CASE loc_nBotao = 3
6504:             THIS.CmdCompoAtualizaClick()
6505:         CASE loc_nBotao = 4
6506:             THIS.CmdCompoPrecoClick()
6507:         CASE loc_nBotao = 5
6508:             THIS.CmdAtuPesosClick()
6509:         ENDCASE
6510:     ENDPROC
6511: 
6512:     PROCEDURE CmgSubCpClick()
6513:         LOCAL loc_oPg, loc_nBotao
6514:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6515:         loc_nBotao = loc_oPg.cmg_4c_CmdgSubCp.Value
6516:         DO CASE
6517:         CASE loc_nBotao = 1
6518:             THIS.CmdSubCpInserirClick()
6519:         CASE loc_nBotao = 2
6520:             THIS.CmdSubCpExcluirClick()
6521:         ENDCASE
6522:     ENDPROC
6523: 
6524:     PROCEDURE CmdCompoInserirClick()
6525:         MsgInfo("Inserir item de composi" + CHR(231) + CHR(227) + "o - a implementar")
6526:     ENDPROC
6527: 
6528:     PROCEDURE CmdCompoExcluirClick()
6529:         MsgInfo("Excluir item de composi" + CHR(231) + CHR(227) + "o - a implementar")
6530:     ENDPROC
6531: 
6532:     PROCEDURE CmdCompoAtualizaClick()
6533:         MsgInfo("Atualizar custo da composi" + CHR(231) + CHR(227) + "o - a implementar")
6534:     ENDPROC
6535: 
6536:     PROCEDURE CmdCompoPrecoClick()
6537:         MsgInfo("Atualizar pre" + CHR(231) + "o da composi" + CHR(231) + CHR(227) + "o - a implementar")
6538:     ENDPROC
6539: 
6540:     PROCEDURE CmdAtuPesosClick()
6541:         MsgInfo("Atualizar pesos - a implementar")
6542:     ENDPROC
6543: 
6544:     PROCEDURE CmdSubCpInserirClick()
6545:         MsgInfo("Inserir subcomponente - a implementar")
6546:     ENDPROC
6547: 
6548:     PROCEDURE CmdSubCpExcluirClick()
6549:         MsgInfo("Excluir subcomponente - a implementar")
6550:     ENDPROC
6551: 
6552:     PROCEDURE ChkLiberaCustoClick()
6553:         LOCAL loc_oPg, loc_lLibera, loException
6554:         TRY
6555:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6556:             loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1)
6557:             IF loc_lLibera
6558:                 loc_oPg.chk_4c_ChkLiberaCusto.Picture = gc_4c_CaminhoIcones + "geral_lock_off_34.jpg"
6559:             ELSE
6560:                 loc_oPg.chk_4c_ChkLiberaCusto.Picture = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
6561:             ENDIF
6562:             IF PEMSTATUS(loc_oPg, "txt_4c_Pcus", 5)
6563:                 loc_oPg.txt_4c_Pcus.ReadOnly   = !loc_lLibera
6564:             ENDIF
6565:             IF PEMSTATUS(loc_oPg, "txt_4c_Fcusto", 5)
6566:                 loc_oPg.txt_4c_Fcusto.ReadOnly = !loc_lLibera
6567:             ENDIF
6568:             IF PEMSTATUS(loc_oPg, "txt_4c_Custof", 5)
6569:                 loc_oPg.txt_4c_Custof.ReadOnly = !loc_lLibera
6570:             ENDIF
6571:             IF PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
6572:                 loc_oPg.txt_4c_Cmkpc.ReadOnly  = !loc_lLibera
6573:             ENDIF
6574:         CATCH TO loException
6575:             MostrarErro("Erro ao alternar bloqueio de custo:" + CHR(13) + loException.Message, ;
6576:                 "FormProduto.ChkLiberaCustoClick")
6577:         ENDTRY
6578:     ENDPROC
6579: 
6580:     PROCEDURE ChkLiberaVendaClick()
6581:         LOCAL loc_oPg, loc_lLibera, loException
6582:         TRY
6583:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6584:             loc_lLibera = (loc_oPg.chk_4c_ChkLiberaVenda.Value = 1)
6585:             IF loc_lLibera
6586:                 loc_oPg.chk_4c_ChkLiberaVenda.Picture = gc_4c_CaminhoIcones + "geral_lock_off_34.jpg"
6587:             ELSE
6588:                 loc_oPg.chk_4c_ChkLiberaVenda.Picture = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
6589:             ENDIF
6590:             IF PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
6591:                 loc_oPg.txt_4c_Pven.ReadOnly   = !loc_lLibera
6592:             ENDIF
6593:             IF PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
6594:                 loc_oPg.txt_4c_Fvenda.ReadOnly = !loc_lLibera
6595:             ENDIF
6596:             IF PEMSTATUS(loc_oPg, "txt_4c_Margem", 5)
6597:                 loc_oPg.txt_4c_Margem.ReadOnly = !loc_lLibera
6598:             ENDIF
6599:             IF PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
6600:                 loc_oPg.txt_4c_Ftio.ReadOnly   = !loc_lLibera
6601:             ENDIF
6602:         CATCH TO loException
6603:             MostrarErro("Erro ao alternar bloqueio de venda:" + CHR(13) + loException.Message, ;
6604:                 "FormProduto.ChkLiberaVendaClick")
6605:         ENDTRY
6606:     ENDPROC
6607: 
6608:     PROCEDURE ChkPlanCusClick()
6609:         LOCAL loc_oPg, loc_lAtivo, loException
6610:         TRY
6611:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6612:             loc_lAtivo = (loc_oPg.chk_4c_ChkPlanCus.Value = 1)
6613:             IF PEMSTATUS(loc_oPg, "txt_4c__pftioc", 5)
6614:                 IF loc_lAtivo
6615:                     loc_oPg.txt_4c__pftioc.BackColor = RGB(255, 255, 0)
6616:                     loc_oPg.txt_4c__pftioc.ReadOnly  = .F.
6617:                 ELSE
6618:                     loc_oPg.txt_4c__pftioc.BackColor = RGB(240, 240, 240)
6619:                     loc_oPg.txt_4c__pftioc.ReadOnly  = .T.
6620:                 ENDIF
6621:             ENDIF
6622:         CATCH TO loException
6623:             MostrarErro("Erro ao alternar planejamento de custo:" + CHR(13) + loException.Message, ;
6624:                 "FormProduto.ChkPlanCusClick")
6625:         ENDTRY
6626:     ENDPROC
6627: 
6628:     PROCEDURE ChkPlanVenClick()
6629:         LOCAL loc_oPg, loc_lAtivo, loException
6630:         TRY
6631:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6632:             loc_lAtivo = (loc_oPg.chk_4c_ChkPlanVen.Value = 1)
6633:             IF PEMSTATUS(loc_oPg, "txt_4c_Pftio", 5)
6634:                 IF loc_lAtivo
6635:                     loc_oPg.txt_4c_Pftio.BackColor = RGB(255, 255, 0)
6636:                     loc_oPg.txt_4c_Pftio.ReadOnly  = .F.
6637:                 ELSE
6638:                     loc_oPg.txt_4c_Pftio.BackColor = RGB(240, 240, 240)
6639:                     loc_oPg.txt_4c_Pftio.ReadOnly  = .T.
6640:                 ENDIF
6641:             ENDIF
6642:         CATCH TO loException
6643:             MostrarErro("Erro ao alternar planejamento de venda:" + CHR(13) + loException.Message, ;
6644:                 "FormProduto.ChkPlanVenClick")
6645:         ENDTRY
6646:     ENDPROC
6647: 
6648:     PROCEDURE ChkPvendaClick()
6649:         LOCAL loc_oPg, loException
6650:         TRY
6651:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6652:             IF PEMSTATUS(loc_oPg, "txt_4c_Pvideal", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
6653:                 loc_oPg.txt_4c_Pven.Value = loc_oPg.txt_4c_Pvideal.Value
6654:             ENDIF
6655:             IF PEMSTATUS(loc_oPg, "txt_4c_FIdeals", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
6656:                 loc_oPg.txt_4c_Fvenda.Value = loc_oPg.txt_4c_FIdeals.Value
6657:             ENDIF
6658:             IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Moec", 5)
6659:                 loc_oPg.txt_4c_Moev.Value = loc_oPg.txt_4c_Moec.Value
6660:             ENDIF
6661:             IF PEMSTATUS(loc_oPg, "chk_4c_Chk_Pvenda", 5)
6662:                 loc_oPg.chk_4c_Chk_Pvenda.Value = 0
6663:             ENDIF
6664:         CATCH TO loException
6665:             MostrarErro("Erro ao copiar pre" + CHR(231) + "o ideal:" + CHR(13) + loException.Message, ;
6666:                 "FormProduto.ChkPvendaClick")
6667:         ENDTRY
6668:     ENDPROC
6669: 
6670:     PROCEDURE CmdCalcValsClick()
6671:         MsgInfo("Calcular valores pelas moedas - a implementar")
6672:     ENDPROC
6673: 
6674:     PROCEDURE TxtObsOFsWhen()
6675:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
6676:     ENDPROC
6677: 
6678:     PROCEDURE TxtObsOFsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6679:         LOCAL loc_oPg, loException
6680:         IF par_nKeyCode = 13
6681:             TRY
6682:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6683:                 IF USED("cursor_4c_GrdCompo") AND !EOF("cursor_4c_GrdCompo") AND ;
6684:                         PEMSTATUS(loc_oPg, "txt_4c_ObsOFs", 5)
6685:                     SELECT cursor_4c_GrdCompo
6686:                     REPLACE cursor_4c_GrdCompo.obs WITH ;
6687:                         ALLTRIM(loc_oPg.txt_4c_ObsOFs.Value)
6688:                 ENDIF
6689:             CATCH TO loException
6690:                 MostrarErro("Erro ao salvar obs OFs:" + CHR(13) + loException.Message, ;
6691:                     "FormProduto.TxtObsOFsKeyPress")
6692:             ENDTRY
6693:         ENDIF
6694:     ENDPROC
6695: 
6696:     *-- Validacoes/lookups de moeda (SigCdMoe: cmoeds, dmoeds)
6697: 
6698:     PROCEDURE ValidarMoec(par_nKeyCode, par_nShiftAltCtrl)
6699:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6700:             RETURN
6701:         ENDIF
6702:         LOCAL loc_oPg, loc_cCod
6703:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6704:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moec", 5)
6705:             RETURN
6706:         ENDIF
6707:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moec.Value)
6708:         IF EMPTY(loc_cCod)
6709:             RETURN
6710:         ENDIF
6711:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moec")
6712:     ENDPROC
6713: 
6714:     PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6715:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6716:             THIS.ValidarMoec()
6717:         ENDIF
6718:     ENDPROC
6719: 
6720:     PROCEDURE ValidarMoepc(par_nKeyCode, par_nShiftAltCtrl)
6721:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6722:             RETURN
6723:         ENDIF
6724:         LOCAL loc_oPg, loc_cCod
6725:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6726:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moepc", 5)
6727:             RETURN
6728:         ENDIF
6729:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepc.Value)
6730:         IF EMPTY(loc_cCod)
6731:             RETURN
6732:         ENDIF
6733:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moepc")
6734:     ENDPROC
6735: 
6736:     PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6737:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6738:             THIS.ValidarMoepc()
6739:         ENDIF
6740:     ENDPROC
6741: 
6742:     PROCEDURE ValidarMoecusf(par_nKeyCode, par_nShiftAltCtrl)
6743:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6744:             RETURN
6745:         ENDIF
6746:         LOCAL loc_oPg, loc_cCod
6747:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6748:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moecusf", 5)
6749:             RETURN
6750:         ENDIF
6751:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moecusf.Value)
6752:         IF EMPTY(loc_cCod)
6753:             RETURN
6754:         ENDIF
6755:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moecusf")
6756:     ENDPROC
6757: 
6758:     PROCEDURE TxtMoecusfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6759:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6760:             THIS.ValidarMoecusf()
6761:         ENDIF
6762:     ENDPROC
6763: 
6764:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
6765:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6766:             RETURN
6767:         ENDIF
6768:         LOCAL loc_oPg, loc_cCod
6769:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6770:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
6771:             RETURN
6772:         ENDIF
6773:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
6774:         IF EMPTY(loc_cCod)
6775:             RETURN
6776:         ENDIF
6777:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moeda")
6778:     ENDPROC
6779: 
6780:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6781:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6782:             THIS.ValidarMoeda()
6783:         ENDIF
6784:     ENDPROC
6785: 
6786:     PROCEDURE ValidarMoepv(par_nKeyCode, par_nShiftAltCtrl)
6787:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6788:             RETURN
6789:         ENDIF
6790:         LOCAL loc_oPg, loc_cCod
6791:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6792:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
6793:             RETURN
6794:         ENDIF
6795:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepv.Value)
6796:         IF EMPTY(loc_cCod)
6797:             RETURN
6798:         ENDIF
6799:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moepv")
6800:     ENDPROC
6801: 
6802:     PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6803:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6804:             THIS.ValidarMoepv()
6805:         ENDIF
6806:     ENDPROC
6807: 
6808:     PROCEDURE ValidarMoev(par_nKeyCode, par_nShiftAltCtrl)
6809:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6810:             RETURN
6811:         ENDIF
6812:         LOCAL loc_oPg, loc_cCod
6813:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6814:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
6815:             RETURN
6816:         ENDIF
6817:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moev.Value)
6818:         IF EMPTY(loc_cCod)
6819:             RETURN
6820:         ENDIF
6821:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moev")
6822:     ENDPROC
6823: 
6824:     PROCEDURE TxtMoevKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6825:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6826:             THIS.ValidarMoev()
6827:         ENDIF
6828:     ENDPROC
6829: 
6830:     PROCEDURE ValidarMftio(par_nKeyCode, par_nShiftAltCtrl)
6831:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6832:             RETURN
6833:         ENDIF
6834:         LOCAL loc_oPg, loc_cCod
6835:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6836:         IF !PEMSTATUS(loc_oPg, "txt_4c_Mftio", 5)
6837:             RETURN
6838:         ENDIF
6839:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Mftio.Value)
6840:         IF EMPTY(loc_cCod)
6841:             RETURN
6842:         ENDIF
6843:         THIS.AbrirBuscaMoedaCompo("txt_4c_Mftio")
6844:     ENDPROC
6845: 
6846:     PROCEDURE TxtMftioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6847:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6848:             THIS.ValidarMftio()
6849:         ENDIF
6850:     ENDPROC
6851: 
6852:     *-- Validacoes/lookups de feitio/markup (SigPrFti: cods, descs)
6853: 
6854:     PROCEDURE ValidarFtio(par_nKeyCode, par_nShiftAltCtrl)
6855:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6856:             RETURN
6857:         ENDIF
6858:         LOCAL loc_oPg, loc_cCod
6859:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6860:         IF !PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
6861:             RETURN
6862:         ENDIF
6863:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ftio.Value)
6864:         IF EMPTY(loc_cCod)
6865:             RETURN
6866:         ENDIF
6867:         THIS.AbrirBuscaFeitioCompo("txt_4c_Ftio")
6868:     ENDPROC
6869: 
6870:     PROCEDURE TxtFtioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6871:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6872:             THIS.ValidarFtio()
6873:         ENDIF
6874:     ENDPROC
6875: 
6876:     PROCEDURE ValidarCmkpc(par_nKeyCode, par_nShiftAltCtrl)
6877:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6878:             RETURN
6879:         ENDIF
6880:         LOCAL loc_oPg, loc_cCod
6881:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6882:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
6883:             RETURN
6884:         ENDIF
6885:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value)
6886:         IF EMPTY(loc_cCod)
6887:             RETURN
6888:         ENDIF
6889:         THIS.AbrirBuscaFeitioCompo("txt_4c_Cmkpc")
6890:     ENDPROC
6891: 
6892:     PROCEDURE TxtCmkpcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6893:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6894:             THIS.ValidarCmkpc()
6895:         ENDIF
6896:     ENDPROC
6897: 
6898:     *-- Validacao/lookup de status (SigCdPst: cods, descs)
6899: 
6900:     PROCEDURE ValidarStatus(par_nKeyCode, par_nShiftAltCtrl)
6901:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6902:             RETURN
6903:         ENDIF
6904:         LOCAL loc_oPg, loc_cCod
6905:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6906:         IF !PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
6907:             RETURN
6908:         ENDIF
6909:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Status.Value)
6910:         IF EMPTY(loc_cCod)
6911:             RETURN
6912:         ENDIF
6913:         THIS.AbrirBuscaStatusCompo()
6914:     ENDPROC
6915: 
6916:     PROCEDURE TxtStatusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6917:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6918:             THIS.ValidarStatus()
6919:         ENDIF
6920:     ENDPROC
6921: 
6922:     *===========================================================================
6923:     * AbrirBuscaMoedaCompo - Lookup de moeda para campos da pgComposicao
6924:     * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
6925:     *===========================================================================
6926:     PROCEDURE AbrirBuscaMoedaCompo(par_cCampoDestino)
6927:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
6928:         TRY
6929:             loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6930:             loc_cValAtual = ""
6931:             IF PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
6932:                 loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
6933:             ENDIF
6934: 
6935:             loc_nRet = SQLEXEC(gnConnHandle, ;
6936:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds LIKE " + ;
6937:                 EscaparSQL(ALLTRIM(loc_cValAtual) + "%") + " ORDER BY cmoeds", ;
6938:                 "cursor_4c_MoedaBusca")
6939: 
6940:             IF loc_nRet <= 0 OR !USED("cursor_4c_MoedaBusca") OR EOF("cursor_4c_MoedaBusca")
6941:                 IF USED("cursor_4c_MoedaBusca")
6942:                     USE IN cursor_4c_MoedaBusca
6943:                 ENDIF
6944:                 SQLEXEC(gnConnHandle, "SELECT cmoeds, dmoeds FROM SigCdMoe ORDER BY cmoeds", ;
6945:                     "cursor_4c_MoedaBusca")
6946:             ENDIF
6947: 
6948:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6949:             IF VARTYPE(loc_oBusca) = "O"
6950:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MoedaBusca"
6951:                 loc_oBusca.DefinirCursor("cursor_4c_MoedaBusca", "cmoeds", "dmoeds", "Buscar Moeda")
6952:                 loc_oBusca.Mostrar()
6953:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
6954:                     loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
6955:                 ENDIF
6956:                 loc_oBusca = .NULL.
6957:             ENDIF
6958: 
6959:             IF USED("cursor_4c_MoedaBusca")
6960:                 USE IN cursor_4c_MoedaBusca
6961:             ENDIF
6962:         CATCH TO loException
6963:             IF USED("cursor_4c_MoedaBusca")
6964:                 USE IN cursor_4c_MoedaBusca
6965:             ENDIF
6966:             MostrarErro("Erro ao buscar moeda:" + CHR(13) + loException.Message, ;
6967:                 "FormProduto.AbrirBuscaMoedaCompo")
6968:         ENDTRY
6969:     ENDPROC
6970: 
6971:     *===========================================================================
6972:     * AbrirBuscaFeitioCompo - Lookup de feitio/markup para campos da pgComposicao
6973:     * SigPrFti: cods (char 2), descs (char 20)
6974:     *===========================================================================
6975:     PROCEDURE AbrirBuscaFeitioCompo(par_cCampoDestino)
6976:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
6977:         TRY
6978:             loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6979:             loc_cValAtual = ""
6980:             IF PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
6981:                 loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
6982:             ENDIF
6983: 
6984:             loc_nRet = SQLEXEC(gnConnHandle, ;
6985:                 "SELECT cods, descs FROM SigPrFti WHERE cods LIKE '" + ;
6986:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
6987:                 "cursor_4c_FeitioBusca")
6988: 
6989:             IF loc_nRet <= 0 OR !USED("cursor_4c_FeitioBusca") OR EOF("cursor_4c_FeitioBusca")
6990:                 IF USED("cursor_4c_FeitioBusca")
6991:                     USE IN cursor_4c_FeitioBusca
6992:                 ENDIF
6993:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigPrFti ORDER BY cods", ;
6994:                     "cursor_4c_FeitioBusca")
6995:             ENDIF
6996: 
6997:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6998:             IF VARTYPE(loc_oBusca) = "O"
6999:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FeitioBusca"
7000:                 loc_oBusca.DefinirCursor("cursor_4c_FeitioBusca", "cods", "descs", "Buscar Feitio/MKP")
7001:                 loc_oBusca.Mostrar()
7002:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
7003:                     loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
7004:                 ENDIF
7005:                 loc_oBusca = .NULL.
7006:             ENDIF
7007: 
7008:             IF USED("cursor_4c_FeitioBusca")
7009:                 USE IN cursor_4c_FeitioBusca
7010:             ENDIF
7011:         CATCH TO loException
7012:             IF USED("cursor_4c_FeitioBusca")
7013:                 USE IN cursor_4c_FeitioBusca
7014:             ENDIF
7015:             MostrarErro("Erro ao buscar feitio:" + CHR(13) + loException.Message, ;
7016:                 "FormProduto.AbrirBuscaFeitioCompo")
7017:         ENDTRY
7018:     ENDPROC
7019: 
7020:     *===========================================================================
7021:     * AbrirBuscaStatusCompo - Lookup de status para campo txt_4c_Status
7022:     * SigCdPst: cods (char 3), descs (char 20)
7023:     *===========================================================================
7024:     PROCEDURE AbrirBuscaStatusCompo()
7025:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
7026:         TRY
7027:             loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7028:             loc_cValAtual = ""
7029:             IF PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
7030:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Status.Value)
7031:             ENDIF
7032: 
7033:             loc_nRet = SQLEXEC(gnConnHandle, ;
7034:                 "SELECT cods, descs FROM SigCdPst WHERE cods LIKE '" + ;
7035:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
7036:                 "cursor_4c_StatusBusca")
7037: 
7038:             IF loc_nRet <= 0 OR !USED("cursor_4c_StatusBusca") OR EOF("cursor_4c_StatusBusca")
7039:                 IF USED("cursor_4c_StatusBusca")
7040:                     USE IN cursor_4c_StatusBusca
7041:                 ENDIF
7042:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdPst ORDER BY cods", ;
7043:                     "cursor_4c_StatusBusca")
7044:             ENDIF
7045: 
7046:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
7047:             IF VARTYPE(loc_oBusca) = "O"
7048:                 loc_oBusca.this_cCursorDestino = "cursor_4c_StatusBusca"
7049:                 loc_oBusca.DefinirCursor("cursor_4c_StatusBusca", "cods", "descs", "Buscar Status")
7050:                 loc_oBusca.Mostrar()
7051:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
7052:                     loc_oPg.txt_4c_Status.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
7053:                 ENDIF
7054:                 loc_oBusca = .NULL.
7055:             ENDIF
7056: 
7057:             IF USED("cursor_4c_StatusBusca")
7058:                 USE IN cursor_4c_StatusBusca
7059:             ENDIF
7060:         CATCH TO loException
7061:             IF USED("cursor_4c_StatusBusca")
7062:                 USE IN cursor_4c_StatusBusca
7063:             ENDIF
7064:             MostrarErro("Erro ao buscar status:" + CHR(13) + loException.Message, ;
7065:                 "FormProduto.AbrirBuscaStatusCompo")
7066:         ENDTRY
7067:     ENDPROC
7068: 
7069:     *===========================================================================
7070:     * ConfigurarPgPgDadosFaseP - Configura Page4 "Processos" do pgf_4c_Dados
7071:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP
7072:     * GradFase: 5 colunas (top=129, left=527, width=420, height=168)
7073:     * grdMatrizes: 3 colunas (top=305, left=527, width=245, height=192)
7074:     *===========================================================================
7075:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPg)
7076:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oErro
7077:         TRY
7078:             loc_oPg = par_oPg
7079:             loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
7080: 
7081:             *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
7082:             IF !USED("cursor_4c_GradFase")
7083:                 CREATE CURSOR cursor_4c_GradFase ( ;
7084:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
7085:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
7086:             ENDIF
7087:             IF !USED("cursor_4c_GrdMatrizes")
7088:                 CREATE CURSOR cursor_4c_GrdMatrizes ( ;
7089:                     cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
7090:             ENDIF
7091: 
7092:             *-- shp_4c_Fig: Shape moldura da figura do produto
7093:             *-- Original shpFig: top=129, left=231, width=244, height=148
7094:             loc_oPg.AddObject("shp_4c_Fig", "Shape")
7095:             WITH loc_oPg.shp_4c_Fig
7096:                 .Top           = 129
7097:                 .Left          = 231
7098:                 .Width         = 244
7099:                 .Height        = 148
7100:                 .BackStyle     = 0
7101:                 .BorderWidth   = 2
7102:                 .SpecialEffect = 0
7103:                 .Visible       = .T.
7104:             ENDWITH
7105: 
7106:             *-- img_4c_ImgFig: Imagem da figura do produto
7107:             *-- Original ImgFigJpg: top=130, left=232, width=241, height=146
7108:             loc_oPg.AddObject("img_4c_ImgFig", "Image")
7109:             WITH loc_oPg.img_4c_ImgFig
7110:                 .Top     = 130
7111:                 .Left    = 232
7112:                 .Width   = 241
7113:                 .Height  = 146
7114:                 .Stretch = 1
7115:                 .Visible = .T.

*-- Linhas 7132 a 7345:
7132:                 .Themes          = .F.
7133:                 .Visible         = .T.
7134:             ENDWITH
7135:             BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaFasePClick")
7136: 
7137:             *-- cmd_4c_Figura: Capturar imagem do produto (arquivo)
7138:             *-- Original cmdgFigura: top=169, left=482, width=40, height=40
7139:             loc_oPg.AddObject("cmd_4c_Figura", "CommandButton")
7140:             WITH loc_oPg.cmd_4c_Figura
7141:                 .Top             = 169
7142:                 .Left            = 482
7143:                 .Width           = 40
7144:                 .Height          = 40
7145:                 .Caption         = ""
7146:                 .Picture         = gc_4c_CaminhoIcones + "geral_picture_26.jpg"
7147:                 .PicturePosition = 14
7148:                 .SpecialEffect   = 0
7149:                 .MousePointer    = 15
7150:                 .ToolTipText     = "Capturar Imagem do Produto"
7151:                 .Themes          = .F.
7152:                 .Visible         = .T.
7153:             ENDWITH
7154:             BINDEVENT(loc_oPg.cmd_4c_Figura, "Click", THIS, "CmdFiguraFasePClick")
7155: 
7156:             *-- cmd_4c_FigCam: Capturar imagem via WebCam
7157:             *-- Original cmdgFigCam: top=209, left=482, width=40, height=40
7158:             loc_oPg.AddObject("cmd_4c_FigCam", "CommandButton")
7159:             WITH loc_oPg.cmd_4c_FigCam
7160:                 .Top             = 209
7161:                 .Left            = 482
7162:                 .Width           = 40
7163:                 .Height          = 40
7164:                 .Caption         = ""
7165:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
7166:                 .PicturePosition = 14
7167:                 .SpecialEffect   = 0
7168:                 .MousePointer    = 15
7169:                 .ToolTipText     = "Capturar Imagem do Produto - WebCam"
7170:                 .Themes          = .F.
7171:                 .Visible         = .T.
7172:             ENDWITH
7173:             BINDEVENT(loc_oPg.cmd_4c_FigCam, "Click", THIS, "CmdFigCamFasePClick")
7174: 
7175:             *-- grd_4c_GradFase: Grade de Fases de Producao (5 colunas)
7176:             *-- Original GradFase: top=129, left=527, width=420, height=168, columnCount=5
7177:             loc_oPg.AddObject("grd_4c_GradFase", "Grid")
7178:             WITH loc_oPg.grd_4c_GradFase
7179:                 .Top               = 129
7180:                 .Left              = 527
7181:                 .Width             = 420
7182:                 .Height            = 168
7183:                 .FontName          = "Tahoma"
7184:                 .FontSize          = 8
7185:                 .RecordMark        = .F.
7186:                 .DeleteMark        = .F.
7187:                 .HeaderHeight      = 20
7188:                 .RowHeight         = 18
7189:                 .ScrollBars        = 2
7190:                 .GridLines         = 3
7191:                 .GridLineColor     = RGB(238, 238, 238)
7192:                 .HighlightBackColor = RGB(255, 255, 255)
7193:                 .HighlightForeColor = RGB(15, 41, 104)
7194:                 .HighlightStyle    = 2
7195:                 .AllowHeaderSizing = .F.
7196:                 .AllowRowSizing    = .F.
7197:                 .Visible           = .T.
7198:             ENDWITH
7199:             loc_oPg.grd_4c_GradFase.ColumnCount  = 5
7200:             loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
7201:             loc_oGrid = loc_oPg.grd_4c_GradFase
7202: 
7203:             *-- Column1: Ordem (ordems N2,0) - width=45
7204:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GradFase.ordems"
7205:             loc_oGrid.Column1.Width           = 45
7206:             loc_oGrid.Column1.ReadOnly        = .F.
7207:             loc_oGrid.Column1.Movable         = .F.
7208:             loc_oGrid.Column1.Resizable       = .F.
7209:             loc_oGrid.Column1.Header1.Caption = "Ordem"
7210:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "GrdFaseCol1OrdValid")
7211: 
7212:             *-- Column2: Fase/Grupo (grupos C10) - lookup SigCdGcr, width=80
7213:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GradFase.grupos"
7214:             loc_oGrid.Column2.Width           = 80
7215:             loc_oGrid.Column2.ReadOnly        = .F.
7216:             loc_oGrid.Column2.Movable         = .F.
7217:             loc_oGrid.Column2.Resizable       = .F.
7218:             loc_oGrid.Column2.Header1.Caption = "Fase"
7219:             BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "GrdFaseCol2FaseValid")
7220: 
7221:             *-- Column3: Utilizacao (minutos N9,1) - width=70
7222:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GradFase.minutos"
7223:             loc_oGrid.Column3.Width           = 70
7224:             loc_oGrid.Column3.ReadOnly        = .F.
7225:             loc_oGrid.Column3.Movable         = .F.
7226:             loc_oGrid.Column3.Resizable       = .F.
7227:             loc_oGrid.Column3.InputMask       = "99,999.9"
7228:             loc_oGrid.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
7229: 
7230:             *-- Column4: Uni. Produtiva (uniprdts C10) - lookup SigCdUpd, width=84
7231:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GradFase.uniprdts"
7232:             loc_oGrid.Column4.Width           = 84
7233:             loc_oGrid.Column4.ReadOnly        = .F.
7234:             loc_oGrid.Column4.Movable         = .F.
7235:             loc_oGrid.Column4.Resizable       = .F.
7236:             loc_oGrid.Column4.Header1.Caption = "Uni. Produtiva"
7237:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdFaseCol4UniPrdtValid")
7238: 
7239:             *-- Column5: Material (matprdts C15) - lookup SigOpOpt, width=115
7240:             loc_oGrid.Column5.ControlSource   = "cursor_4c_GradFase.matprdts"
7241:             loc_oGrid.Column5.Width           = 115
7242:             loc_oGrid.Column5.ReadOnly        = .F.
7243:             loc_oGrid.Column5.Movable         = .F.
7244:             loc_oGrid.Column5.Resizable       = .F.
7245:             loc_oGrid.Column5.Header1.Caption = "Material"
7246:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdFaseCol5MatPrdtValid")
7247: 
7248:             BINDEVENT(loc_oGrid, "BeforeRowColChange", THIS, "GrdFaseBeforeRowColChange")
7249:             BINDEVENT(loc_oGrid, "AfterRowColChange",  THIS, "GrdFaseAfterRowColChange")
7250: 
7251:             *-- cmd_4c_InserirFase: Inserir fase na GradFase
7252:             *-- Original inserir: top=129, left=950, width=40, height=40
7253:             loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
7254:             WITH loc_oPg.cmd_4c_InserirFase
7255:                 .Top             = 129
7256:                 .Left            = 950
7257:                 .Width           = 40
7258:                 .Height          = 40
7259:                 .Caption         = ""
7260:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
7261:                 .PicturePosition = 14
7262:                 .SpecialEffect   = 0
7263:                 .MousePointer    = 15
7264:                 .Themes          = .F.
7265:                 .Visible         = .T.
7266:             ENDWITH
7267:             BINDEVENT(loc_oPg.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")
7268: 
7269:             *-- cmd_4c_ExcluirFase: Excluir fase da GradFase
7270:             *-- Original excluir: top=169, left=950, width=40, height=40
7271:             loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
7272:             WITH loc_oPg.cmd_4c_ExcluirFase
7273:                 .Top             = 169
7274:                 .Left            = 950
7275:                 .Width           = 40
7276:                 .Height          = 40
7277:                 .Caption         = ""
7278:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
7279:                 .PicturePosition = 14
7280:                 .SpecialEffect   = 0
7281:                 .MousePointer    = 15
7282:                 .ToolTipText     = "Excluir"
7283:                 .Themes          = .F.
7284:                 .Visible         = .T.
7285:             ENDWITH
7286:             BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")
7287: 
7288:             *-- cmd_4c_Alternativa: Alternativa de insercao na GradFase
7289:             *-- Original Alternativa: top=209, left=950, width=40, height=40
7290:             loc_oPg.AddObject("cmd_4c_Alternativa", "CommandButton")
7291:             WITH loc_oPg.cmd_4c_Alternativa
7292:                 .Top             = 209
7293:                 .Left            = 950
7294:                 .Width           = 40
7295:                 .Height          = 40
7296:                 .Caption         = ""
7297:                 .Picture         = gc_4c_CaminhoIcones + "geral_pn_cfg_26.jpg"
7298:                 .PicturePosition = 14
7299:                 .SpecialEffect   = 0
7300:                 .MousePointer    = 15
7301:                 .ToolTipText     = "Alternativa"
7302:                 .Themes          = .F.
7303:                 .Visible         = .T.
7304:             ENDWITH
7305:             BINDEVENT(loc_oPg.cmd_4c_Alternativa, "Click", THIS, "BtnAlternativaFaseClick")
7306: 
7307:             *--------------------------------------------------------------
7308:             *-- Area esquerda: campos do produto (pesos, tamanhos, etc.)
7309:             *--------------------------------------------------------------
7310: 
7311:             *-- lbl_4c_Say13: "Qtd. Min. Producao :"
7312:             *-- Original Say13: top=133, left=32, width=102
7313:             loc_oPg.AddObject("lbl_4c_Say13", "Label")
7314:             WITH loc_oPg.lbl_4c_Say13
7315:                 .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
7316:                 .FontName  = "Tahoma"
7317:                 .FontSize  = 8
7318:                 .BackStyle = 0
7319:                 .Height    = 15
7320:                 .Left      = 32
7321:                 .Top       = 133
7322:                 .Width     = 102
7323:                 .ForeColor = RGB(90, 90, 90)
7324:                 .Visible   = .T.
7325:             ENDWITH
7326: 
7327:             *-- txt_4c_QminFabs: Quantidade minima de fabricacao (getQmin)
7328:             *-- Original getQmin: top=129, left=137, width=80, height=23, ControlSource=crSigCdPro.qtminFabs
7329:             loc_oPg.AddObject("txt_4c_QminFabs", "TextBox")
7330:             WITH loc_oPg.txt_4c_QminFabs
7331:                 .Top           = 129
7332:                 .Left          = 137
7333:                 .Width         = 80
7334:                 .Height        = 23
7335:                 .FontName      = "Tahoma"
7336:                 .FontSize      = 8
7337:                 .InputMask     = "999,999.99"
7338:                 .MaxLength     = 10
7339:                 .SpecialEffect = 1
7340:                 .Value         = 0
7341:                 .Visible       = .T.
7342:             ENDWITH
7343: 
7344:             *-- lbl_4c_Say5: "Garra :"
7345:             *-- Original Say5: top=158, left=98, width=36

*-- Linhas 7403 a 7446:
7403:                 .Value         = ""
7404:                 .Visible       = .T.
7405:             ENDWITH
7406:             BINDEVENT(loc_oPg.txt_4c_Conquilhas, "KeyPress", THIS, "ValidarConquilhaFaseP")
7407: 
7408:             *-- lbl_4c_Say9: "Peso Brilhante :"
7409:             *-- Original Say9: top=208, left=57, width=77
7410:             loc_oPg.AddObject("lbl_4c_Say9", "Label")
7411:             WITH loc_oPg.lbl_4c_Say9
7412:                 .Caption   = "Peso Brilhante :"
7413:                 .FontName  = "Tahoma"
7414:                 .FontSize  = 8
7415:                 .BackStyle = 0
7416:                 .Height    = 15
7417:                 .Left      = 57
7418:                 .Top       = 208
7419:                 .Width     = 77
7420:                 .ForeColor = RGB(90, 90, 90)
7421:                 .Visible   = .T.
7422:             ENDWITH
7423: 
7424:             *-- txt_4c_PesoBris: Peso Brilhante (getPesoBris)
7425:             *-- Original getPesoBris: top=204, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoBris
7426:             loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
7427:             WITH loc_oPg.txt_4c_PesoBris
7428:                 .Top           = 204
7429:                 .Left          = 137
7430:                 .Width         = 80
7431:                 .Height        = 23
7432:                 .FontName      = "Tahoma"
7433:                 .FontSize      = 8
7434:                 .InputMask     = "99,999.999"
7435:                 .MaxLength     = 10
7436:                 .SpecialEffect = 1
7437:                 .Value         = 0
7438:                 .Visible       = .T.
7439:             ENDWITH
7440: 
7441:             *-- lbl_4c_Say10: "Peso Metal :"
7442:             *-- Original Say10: top=233, left=73, width=61
7443:             loc_oPg.AddObject("lbl_4c_Say10", "Label")
7444:             WITH loc_oPg.lbl_4c_Say10
7445:                 .Caption   = "Peso Metal :"
7446:                 .FontName  = "Tahoma"

*-- Linhas 7533 a 7576:
7533:                 .Value         = ""
7534:                 .Visible       = .T.
7535:             ENDWITH
7536:             BINDEVENT(loc_oPg.txt_4c_CodCorsFP, "KeyPress", THIS, "ValidarCorFaseP")
7537: 
7538:             *-- chk_4c_CravCera: Cravacao em Cera (opc_CravCera)
7539:             *-- Original opc_CravCera: top=283, left=180, ControlSource=crSigCdPro.CravCers
7540:             loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
7541:             WITH loc_oPg.chk_4c_CravCera
7542:                 .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
7543:                 .Top           = 283
7544:                 .Left          = 180
7545:                 .FontName      = "Tahoma"
7546:                 .FontSize      = 8
7547:                 .BackStyle     = 0
7548:                 .AutoSize      = .T.
7549:                 .Alignment     = 0
7550:                 .Value         = 0
7551:                 .SpecialEffect = 1
7552:                 .ForeColor     = RGB(90, 90, 90)
7553:                 .Visible       = .T.
7554:             ENDWITH
7555: 
7556:             *-- lbl_4c_Say2: "Tamanho Padrao :"
7557:             *-- Original Say2: top=308, left=44
7558:             loc_oPg.AddObject("lbl_4c_Say2", "Label")
7559:             WITH loc_oPg.lbl_4c_Say2
7560:                 .Caption   = "Tamanho Padr" + CHR(227) + "o :"
7561:                 .FontName  = "Tahoma"
7562:                 .FontSize  = 8
7563:                 .BackStyle = 0
7564:                 .Left      = 44
7565:                 .Top       = 308
7566:                 .ForeColor = RGB(90, 90, 90)
7567:                 .Visible   = .T.
7568:             ENDWITH
7569: 
7570:             *-- txt_4c_CodTamsFP: Tamanho Padrao (getTam) - espelha Page1 CodTams
7571:             *-- Original getTam: top=304, left=137, width=38, ControlSource=crSigCdPro.CodTams
7572:             loc_oPg.AddObject("txt_4c_CodTamsFP", "TextBox")
7573:             WITH loc_oPg.txt_4c_CodTamsFP
7574:                 .Top           = 304
7575:                 .Left          = 137
7576:                 .Width         = 38

*-- Linhas 7582 a 7625:
7582:                 .Value         = ""
7583:                 .Visible       = .T.
7584:             ENDWITH
7585:             BINDEVENT(loc_oPg.txt_4c_CodTamsFP, "KeyPress", THIS, "ValidarTamFaseP")
7586: 
7587:             *-- chk_4c_Varias: Peso Variavel (fwoption1)
7588:             *-- Original fwoption1: top=308, left=180, ControlSource=crSigCdPro.Varias
7589:             loc_oPg.AddObject("chk_4c_Varias", "CheckBox")
7590:             WITH loc_oPg.chk_4c_Varias
7591:                 .Caption       = "Peso Vari" + CHR(225) + "vel"
7592:                 .Top           = 308
7593:                 .Left          = 180
7594:                 .FontName      = "Tahoma"
7595:                 .FontSize      = 8
7596:                 .BackStyle     = 0
7597:                 .AutoSize      = .T.
7598:                 .Alignment     = 0
7599:                 .Value         = 0
7600:                 .SpecialEffect = 1
7601:                 .ForeColor     = RGB(90, 90, 90)
7602:                 .Visible       = .T.
7603:             ENDWITH
7604: 
7605:             *-- lbl_4c_Acabamento: "Acabamento :"
7606:             *-- Original lblAcabamento: top=333, left=15, width=119, Alignment=1
7607:             loc_oPg.AddObject("lbl_4c_Acabamento", "Label")
7608:             WITH loc_oPg.lbl_4c_Acabamento
7609:                 .Caption   = "Acabamento :"
7610:                 .FontName  = "Tahoma"
7611:                 .FontSize  = 8
7612:                 .BackStyle = 0
7613:                 .Alignment = 1
7614:                 .Height    = 15
7615:                 .Left      = 15
7616:                 .Top       = 333
7617:                 .Width     = 119
7618:                 .ForeColor = RGB(90, 90, 90)
7619:                 .Visible   = .T.
7620:             ENDWITH
7621: 
7622:             *-- txt_4c_CodAcbsFP: Codigo de Acabamento (get_codacb)
7623:             *-- Original get_codacb: top=329, left=137, width=38, ControlSource=crSigCdPro.codAcbs
7624:             loc_oPg.AddObject("txt_4c_CodAcbsFP", "TextBox")
7625:             WITH loc_oPg.txt_4c_CodAcbsFP

*-- Linhas 7634 a 7677:
7634:                 .Value         = ""
7635:                 .Visible       = .T.
7636:             ENDWITH
7637:             BINDEVENT(loc_oPg.txt_4c_CodAcbsFP, "KeyPress", THIS, "ValidarAcabamentoFaseP")
7638: 
7639:             *-- txt_4c_DacbFP: Descricao Acabamento (get_Dacb) - somente leitura
7640:             *-- Original get_Dacb: top=329, left=177, width=207, height=23
7641:             loc_oPg.AddObject("txt_4c_DacbFP", "TextBox")
7642:             WITH loc_oPg.txt_4c_DacbFP
7643:                 .Top           = 329
7644:                 .Left          = 177
7645:                 .Width         = 207
7646:                 .Height        = 23
7647:                 .FontName      = "Tahoma"
7648:                 .FontSize      = 8
7649:                 .SpecialEffect = 1
7650:                 .ReadOnly      = .T.
7651:                 .Value         = ""
7652:                 .Visible       = .T.
7653:             ENDWITH
7654: 
7655:             *-- lbl_4c_Label9: "Entrega :"
7656:             *-- Original Label9: top=359, left=87, width=47
7657:             loc_oPg.AddObject("lbl_4c_Label9", "Label")
7658:             WITH loc_oPg.lbl_4c_Label9
7659:                 .Caption   = "Entrega :"
7660:                 .FontName  = "Tahoma"
7661:                 .FontSize  = 8
7662:                 .BackStyle = 0
7663:                 .Height    = 15
7664:                 .Left      = 87
7665:                 .Top       = 359
7666:                 .Width     = 47
7667:                 .ForeColor = RGB(90, 90, 90)
7668:                 .Visible   = .T.
7669:             ENDWITH
7670: 
7671:             *-- txt_4c_TEnts: Tempo de Entrega em Dias (getTEnts)
7672:             *-- Original getTEnts: top=355, left=137, width=31, height=23, ControlSource=crSigCdPro.tents
7673:             loc_oPg.AddObject("txt_4c_TEnts", "TextBox")
7674:             WITH loc_oPg.txt_4c_TEnts
7675:                 .Top           = 355
7676:                 .Left          = 137
7677:                 .Width         = 31

*-- Linhas 7908 a 7955:
7908:                 .Width     = 50
7909:                 .ForeColor = RGB(90, 90, 90)
7910:                 .Visible   = .T.
7911:             ENDWITH
7912: 
7913:             *-- opt_4c_Prodvars: Variacao p/ e-commerce Sim/Nao (Fwoption2)
7914:             *-- Original Fwoption2: top=482, left=132, width=93, height=15, ControlSource=crSigCdPro.prodvars
7915:             loc_oPg.AddObject("opt_4c_Prodvars", "OptionGroup")
7916:             WITH loc_oPg.opt_4c_Prodvars
7917:                 .ButtonCount = 2
7918:                 .Value       = 1
7919:                 .Top         = 482
7920:                 .Left        = 132
7921:                 .Width       = 93
7922:                 .Height      = 15
7923:                 .BackStyle   = 0
7924:                 .BorderStyle = 0
7925:                 .Visible     = .T.
7926:                 .Option1.Caption   = "Sim"
7927:                 .Option1.FontName  = "Tahoma"
7928:                 .Option1.FontSize  = 8
7929:                 .Option1.BackStyle = 0
7930:                 .Option1.ForeColor = RGB(90, 90, 90)
7931:                 .Option1.Alignment = 2
7932:                 .Option1.Top       = 0
7933:                 .Option1.Left      = 5
7934:                 .Option1.Height    = 15
7935:                 .Option1.AutoSize  = .T.
7936:                 .Option2.Caption   = "N" + CHR(227) + "o"
7937:                 .Option2.FontName  = "Tahoma"
7938:                 .Option2.FontSize  = 8
7939:                 .Option2.BackStyle = 0
7940:                 .Option2.ForeColor = RGB(90, 90, 90)
7941:                 .Option2.Alignment = 2
7942:                 .Option2.Top       = 0
7943:                 .Option2.Left      = 47
7944:                 .Option2.Height    = 15
7945:                 .Option2.AutoSize  = .T.
7946:             ENDWITH
7947: 
7948:             *--------------------------------------------------------------
7949:             *-- Area direita: descricao da fase, observacoes
7950:             *--------------------------------------------------------------
7951: 
7952:             *-- lbl_4c_Say1Desc: "Descricao :" (rotulo de Get_Desc)
7953:             *-- Original Say1: top=508, left=527, width=67
7954:             loc_oPg.AddObject("lbl_4c_Say1Desc", "Label")
7955:             WITH loc_oPg.lbl_4c_Say1Desc

*-- Linhas 8024 a 8274:
8024:                 .Height  = 110
8025:                 .Stretch = 1
8026:                 .Visible = .T.
8027:             ENDWITH
8028: 
8029:             *-- cmd_4c_InserirMtz: Inserir linha na grdMatrizes
8030:             *-- Original btnInsereMtx: top=302, left=778, width=39, height=40
8031:             loc_oPg.AddObject("cmd_4c_InserirMtz", "CommandButton")
8032:             WITH loc_oPg.cmd_4c_InserirMtz
8033:                 .Top             = 302
8034:                 .Left            = 778
8035:                 .Width           = 39
8036:                 .Height          = 40
8037:                 .Caption         = ""
8038:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
8039:                 .PicturePosition = 14
8040:                 .SpecialEffect   = 0
8041:                 .MousePointer    = 15
8042:                 .Themes          = .F.
8043:                 .Visible         = .T.
8044:             ENDWITH
8045:             BINDEVENT(loc_oPg.cmd_4c_InserirMtz, "Click", THIS, "BtnInserirMtzClick")
8046: 
8047:             *-- cmd_4c_ExcluirMtz: Excluir linha da grdMatrizes
8048:             *-- Original btnExcluiMtz: top=342, left=778, width=39, height=40
8049:             loc_oPg.AddObject("cmd_4c_ExcluirMtz", "CommandButton")
8050:             WITH loc_oPg.cmd_4c_ExcluirMtz
8051:                 .Top             = 342
8052:                 .Left            = 778
8053:                 .Width           = 39
8054:                 .Height          = 40
8055:                 .Caption         = ""
8056:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
8057:                 .PicturePosition = 14
8058:                 .SpecialEffect   = 0
8059:                 .MousePointer    = 15
8060:                 .ToolTipText     = "Excluir"
8061:                 .Themes          = .F.
8062:                 .Visible         = .T.
8063:             ENDWITH
8064:             BINDEVENT(loc_oPg.cmd_4c_ExcluirMtz, "Click", THIS, "BtnExcluirMtzClick")
8065: 
8066:             *-- grd_4c_GrdMatrizes: Grade de Matrizes (3 colunas)
8067:             *-- Original grdMatrizes: top=305, left=527, width=245, height=192, columnCount=3
8068:             loc_oPg.AddObject("grd_4c_GrdMatrizes", "Grid")
8069:             WITH loc_oPg.grd_4c_GrdMatrizes
8070:                 .Top               = 305
8071:                 .Left              = 527
8072:                 .Width             = 245
8073:                 .Height            = 192
8074:                 .FontName          = "Tahoma"
8075:                 .FontSize          = 8
8076:                 .RecordMark        = .F.
8077:                 .DeleteMark        = .F.
8078:                 .HeaderHeight      = 20
8079:                 .RowHeight         = 18
8080:                 .ScrollBars        = 2
8081:                 .GridLines         = 3
8082:                 .GridLineColor     = RGB(238, 238, 238)
8083:                 .HighlightBackColor = RGB(255, 255, 255)
8084:                 .HighlightForeColor = RGB(15, 41, 104)
8085:                 .HighlightStyle    = 2
8086:                 .AllowHeaderSizing = .F.
8087:                 .AllowRowSizing    = .F.
8088:                 .Visible           = .T.
8089:             ENDWITH
8090:             loc_oPg.grd_4c_GrdMatrizes.ColumnCount  = 3
8091:             loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
8092:             loc_oGrid2 = loc_oPg.grd_4c_GrdMatrizes
8093: 
8094:             *-- Column1: Matriz (cmats C14) - lookup, width=108
8095:             loc_oGrid2.Column1.ControlSource   = "cursor_4c_GrdMatrizes.cmats"
8096:             loc_oGrid2.Column1.Width           = 108
8097:             loc_oGrid2.Column1.ReadOnly        = .F.
8098:             loc_oGrid2.Column1.Movable         = .F.
8099:             loc_oGrid2.Column1.Resizable       = .F.
8100:             loc_oGrid2.Column1.Header1.Caption = "Matriz"
8101:             BINDEVENT(loc_oGrid2.Column1.Text1, "Valid", THIS, "GrdMatrizesCol1Valid")
8102: 
8103:             *-- Column2: Qtde (qtds N3,0) - width=34
8104:             loc_oGrid2.Column2.ControlSource   = "cursor_4c_GrdMatrizes.qtds"
8105:             loc_oGrid2.Column2.Width           = 34
8106:             loc_oGrid2.Column2.ReadOnly        = .F.
8107:             loc_oGrid2.Column2.Movable         = .F.
8108:             loc_oGrid2.Column2.Resizable       = .F.
8109:             loc_oGrid2.Column2.InputMask       = "9999"
8110:             loc_oGrid2.Column2.Header1.Caption = "Qtde"
8111: 
8112:             *-- Column3: Local (dpros C65) - somente leitura (descricao do produto matriz), width=80
8113:             loc_oGrid2.Column3.ControlSource   = "cursor_4c_GrdMatrizes.dpros"
8114:             loc_oGrid2.Column3.Width           = 80
8115:             loc_oGrid2.Column3.ReadOnly        = .T.
8116:             loc_oGrid2.Column3.Movable         = .F.
8117:             loc_oGrid2.Column3.Resizable       = .F.
8118:             loc_oGrid2.Column3.Header1.Caption = "Local"
8119: 
8120:             BINDEVENT(loc_oGrid2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8121: 
8122:         CATCH TO loc_oErro
8123:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Processos de Produ" + ;
8124:                 CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
8125:                 "FormProduto.ConfigurarPgPgDadosFaseP")
8126:         ENDTRY
8127:     ENDPROC
8128: 
8129:     *===========================================================================
8130:     * CarregarFaseP - Popula grids de FaseP do banco (SigCdPrf + SigPrMtz)
8131:     * Chamado de BOParaForm quando produto e carregado para edicao/visualizacao
8132:     *===========================================================================
8133:     PROTECTED PROCEDURE CarregarFaseP()
8134:         LOCAL loc_cCpros, loc_nRet, loc_oPg, loException
8135:         TRY
8136:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
8137:             IF EMPTY(loc_cCpros) OR TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8138:                 RETURN
8139:             ENDIF
8140:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8141: 
8142:             *-- Carregar GradFase de SigCdPrf
8143:             IF USED("cursor_4c_GradFase")
8144:                 USE IN cursor_4c_GradFase
8145:             ENDIF
8146:             loc_nRet = SQLEXEC(gnConnHandle, ;
8147:                 "SELECT cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs" + ;
8148:                 " FROM SigCdPrf WHERE produtos = " + EscaparSQL(loc_cCpros) + ;
8149:                 " ORDER BY ordems", "cursor_4c_GradFase")
8150:             IF loc_nRet <= 0
8151:                 CREATE CURSOR cursor_4c_GradFase ( ;
8152:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
8153:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
8154:             ENDIF
8155:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8156:                 loc_oPg.grd_4c_GradFase.ColumnCount = 5
8157:                 loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8158:                 loc_oPg.grd_4c_GradFase.Column1.ControlSource = "cursor_4c_GradFase.ordems"
8159:                 loc_oPg.grd_4c_GradFase.Column2.ControlSource = "cursor_4c_GradFase.grupos"
8160:                 loc_oPg.grd_4c_GradFase.Column3.ControlSource = "cursor_4c_GradFase.minutos"
8161:                 loc_oPg.grd_4c_GradFase.Column4.ControlSource = "cursor_4c_GradFase.uniprdts"
8162:                 loc_oPg.grd_4c_GradFase.Column5.ControlSource = "cursor_4c_GradFase.matprdts"
8163:                 loc_oPg.grd_4c_GradFase.Column1.Header1.Caption = "Ordem"
8164:                 loc_oPg.grd_4c_GradFase.Column2.Header1.Caption = "Fase"
8165:                 loc_oPg.grd_4c_GradFase.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8166:                 loc_oPg.grd_4c_GradFase.Column4.Header1.Caption = "Uni. Produtiva"
8167:                 loc_oPg.grd_4c_GradFase.Column5.Header1.Caption = "Material"
8168:                 loc_oPg.grd_4c_GradFase.Refresh()
8169:             ENDIF
8170: 
8171:             *-- Carregar grdMatrizes de SigPrMtz + SigCdPro (descricao do produto matriz)
8172:             IF USED("cursor_4c_GrdMatrizes")
8173:                 USE IN cursor_4c_GrdMatrizes
8174:             ENDIF
8175:             loc_nRet = SQLEXEC(gnConnHandle, ;
8176:                 "SELECT m.cidchaves, m.cmats, m.qtds, ISNULL(p.dpros,'') AS dpros" + ;
8177:                 " FROM SigPrMtz m LEFT JOIN SigCdPro p ON p.cpros = m.cmats" + ;
8178:                 " WHERE m.cpros = " + EscaparSQL(loc_cCpros) + ;
8179:                 " ORDER BY m.cmats", "cursor_4c_GrdMatrizes")
8180:             IF loc_nRet <= 0
8181:                 CREATE CURSOR cursor_4c_GrdMatrizes ( ;
8182:                     cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
8183:             ENDIF
8184:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
8185:                 loc_oPg.grd_4c_GrdMatrizes.ColumnCount = 3
8186:                 loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
8187:                 loc_oPg.grd_4c_GrdMatrizes.Column1.ControlSource = "cursor_4c_GrdMatrizes.cmats"
8188:                 loc_oPg.grd_4c_GrdMatrizes.Column2.ControlSource = "cursor_4c_GrdMatrizes.qtds"
8189:                 loc_oPg.grd_4c_GrdMatrizes.Column3.ControlSource = "cursor_4c_GrdMatrizes.dpros"
8190:                 loc_oPg.grd_4c_GrdMatrizes.Column1.Header1.Caption = "Matriz"
8191:                 loc_oPg.grd_4c_GrdMatrizes.Column2.Header1.Caption = "Qtde"
8192:                 loc_oPg.grd_4c_GrdMatrizes.Column3.Header1.Caption = "Local"
8193:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
8194:             ENDIF
8195: 
8196:         CATCH TO loException
8197:             MostrarErro("Erro ao carregar FaseP:" + CHR(13) + loException.Message + ;
8198:                 CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
8199:                 "FormProduto.CarregarFaseP")
8200:         ENDTRY
8201:     ENDPROC
8202: 
8203:     *===========================================================================
8204:     * GrdFaseBeforeRowColChange - Persiste obs do EditBox no cursor antes de mudar linha
8205:     * PUBLIC: BINDEVENT requer metodo publico
8206:     *===========================================================================
8207:     PROCEDURE GrdFaseBeforeRowColChange(par_nColIndex)
8208:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8209:             LOCAL loc_oPgBC
8210:             loc_oPgBC = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8211:             IF PEMSTATUS(loc_oPgBC, "edt_4c_Obs", 5)
8212:                 SELECT cursor_4c_GradFase
8213:                 REPLACE cursor_4c_GradFase.obs WITH loc_oPgBC.edt_4c_Obs.Value
8214:             ENDIF
8215:         ENDIF
8216:     ENDPROC
8217: 
8218:     *===========================================================================
8219:     * GrdFaseAfterRowColChange - Exibe imagem da fase e atualiza descricao
8220:     * PUBLIC: BINDEVENT requer metodo publico
8221:     *===========================================================================
8222:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
8223:         LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
8224:         TRY
8225:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8226:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5) OR !USED("cursor_4c_GradFase")
8227:                 RETURN
8228:             ENDIF
8229: 
8230:             CLEAR RESOURCES
8231:             loc_oPg.img_4c_ImgFig.Picture = ""
8232:             loc_oPg.img_4c_ImgFig.Visible = .F.
8233:             loc_oPg.txt_4c_Desc.Value     = ""
8234:             loc_oPg.edt_4c_Obs.Value      = ""
8235: 
8236:             IF !EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
8237:                 LOCAL loc_cGrupos, loc_cCidchaves
8238:                 SELECT cursor_4c_GradFase
8239:                 loc_cGrupos    = ALLTRIM(cursor_4c_GradFase.grupos)
8240:                 loc_cCidchaves = ALLTRIM(cursor_4c_GradFase.cidchaves)
8241: 
8242:                 *-- Carregar descricao do grupo/fase (SigCdGcr)
8243:                 IF !EMPTY(loc_cGrupos)
8244:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8245:                         "SELECT descrs FROM SigCdGcr WHERE codigos = '" + ;
8246:                         EscaparSQL(loc_cGrupos) + "", "cursor_4c_FaseGcrDesc")
8247:                     IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrDesc") AND !EOF("cursor_4c_FaseGcrDesc")
8248:                         SELECT cursor_4c_FaseGcrDesc
8249:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_FaseGcrDesc.descrs)
8250:                     ENDIF
8251:                     IF USED("cursor_4c_FaseGcrDesc")
8252:                         USE IN cursor_4c_FaseGcrDesc
8253:                     ENDIF
8254:                 ENDIF
8255: 
8256:                 *-- Obs vem do cursor (ja carregado em CarregarFaseP / gravado por BeforeRowColChange)
8257:                 SELECT cursor_4c_GradFase
8258:                 IF !ISNULL(cursor_4c_GradFase.obs)
8259:                     loc_oPg.edt_4c_Obs.Value = cursor_4c_GradFase.obs
8260:                 ENDIF
8261: 
8262:                 *-- Figura carregada do banco (campo figprocs - binario nao armazenado no cursor)
8263:                 IF !EMPTY(loc_cCidchaves)
8264:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8265:                         "SELECT figprocs FROM SigCdPrf WHERE cidchaves = '" + ;
8266:                         EscaparSQL(loc_cCidchaves) + "", "cursor_4c_FasePrfFig")
8267:                     IF loc_nRet > 0 AND USED("cursor_4c_FasePrfFig") AND !EOF("cursor_4c_FasePrfFig")
8268:                         SELECT cursor_4c_FasePrfFig
8269:                         IF !ISNULL(cursor_4c_FasePrfFig.figprocs) AND ;
8270:                                 !EMPTY(cursor_4c_FasePrfFig.figprocs)
8271:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8272:                             IF STRTOFILE(cursor_4c_FasePrfFig.figprocs, loc_lcArquivo) > 0
8273:                                 loc_oPg.img_4c_ImgFig.Visible = .T.
8274:                                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo

*-- Linhas 8289 a 10562:
8289: 
8290:     *===========================================================================
8291:     * GrdFaseCol1OrdValid - Valida coluna Ordem da GradFase
8292:     * PUBLIC: BINDEVENT requer metodo publico
8293:     *===========================================================================
8294:     PROCEDURE GrdFaseCol1OrdValid()
8295:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8296:             SELECT cursor_4c_GradFase
8297:             IF cursor_4c_GradFase.ordems <= 0
8298:                 MsgAviso("Ordem deve ser maior que zero.", "Fase")
8299:                 RETURN .F.
8300:             ENDIF
8301:         ENDIF
8302:         RETURN .T.
8303:     ENDPROC
8304: 
8305:     *===========================================================================
8306:     * GrdFaseCol2FaseValid - Lookup de fase/grupo (SigCdGcr) na GradFase
8307:     * PUBLIC: BINDEVENT requer metodo publico
8308:     *===========================================================================
8309:     PROCEDURE GrdFaseCol2FaseValid()
8310:         LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
8311:         TRY
8312:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8313:                 loc_lResultado = .T.
8314:             ENDIF
8315:             SELECT cursor_4c_GradFase
8316:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.grupos)
8317:             IF EMPTY(loc_cValAtual)
8318:                 loc_lResultado = .T.
8319:             ENDIF
8320: 
8321:             loc_nRet = SQLEXEC(gnConnHandle, ;
8322:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = '" + ;
8323:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseGcrBusca")
8324:             IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrBusca") AND !EOF("cursor_4c_FaseGcrBusca")
8325:                 IF USED("cursor_4c_FaseGcrBusca")
8326:                     USE IN cursor_4c_FaseGcrBusca
8327:                 ENDIF
8328:                 loc_lResultado = .T.
8329:             ENDIF
8330:             IF USED("cursor_4c_FaseGcrBusca")
8331:                 USE IN cursor_4c_FaseGcrBusca
8332:             ENDIF
8333: 
8334:             *-- Codigo nao encontrado: abrir busca
8335:             loc_nRet = SQLEXEC(gnConnHandle, ;
8336:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE '" + ;
8337:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY codigos", "cursor_4c_FaseGcrBusca")
8338:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseGcrBusca") OR EOF("cursor_4c_FaseGcrBusca")
8339:                 IF USED("cursor_4c_FaseGcrBusca")
8340:                     USE IN cursor_4c_FaseGcrBusca
8341:                 ENDIF
8342:                 SQLEXEC(gnConnHandle, ;
8343:                     "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
8344:                     "cursor_4c_FaseGcrBusca")
8345:             ENDIF
8346: 
8347:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8348:             IF VARTYPE(loc_oBusca) = "O"
8349:                 loc_oBusca.DefinirCursor("cursor_4c_FaseGcrBusca", "codigos", "descrs", ;
8350:                     "Selecionar Fase/Grupo")
8351:                 loc_oBusca.Mostrar()
8352:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8353:                     SELECT cursor_4c_GradFase
8354:                     REPLACE cursor_4c_GradFase.grupos WITH loc_oBusca.cCodigoSelecionado
8355:                 ENDIF
8356:                 loc_oBusca = .NULL.
8357:             ENDIF
8358: 
8359:             IF USED("cursor_4c_FaseGcrBusca")
8360:                 USE IN cursor_4c_FaseGcrBusca
8361:             ENDIF
8362: 
8363:         CATCH TO loException
8364:             IF USED("cursor_4c_FaseGcrBusca")
8365:                 USE IN cursor_4c_FaseGcrBusca
8366:             ENDIF
8367:             MostrarErro("Erro ao validar fase:" + CHR(13) + loException.Message, ;
8368:                 "FormProduto.GrdFaseCol2FaseValid")
8369:         ENDTRY
8370:         RETURN .T.
8371:     ENDPROC
8372: 
8373:     *===========================================================================
8374:     * GrdFaseCol4UniPrdtValid - Lookup de Unidade Produtiva (SigCdUpd) na GradFase
8375:     * PUBLIC: BINDEVENT requer metodo publico
8376:     *===========================================================================
8377:     PROCEDURE GrdFaseCol4UniPrdtValid()
8378:         LOCAL loc_cValAtual, loc_cGrupos, loc_nRet, loc_oBusca, loException
8379:         TRY
8380:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8381:                 loc_lResultado = .T.
8382:             ENDIF
8383:             SELECT cursor_4c_GradFase
8384:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.uniprdts)
8385:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8386:             IF EMPTY(loc_cValAtual)
8387:                 loc_lResultado = .T.
8388:             ENDIF
8389: 
8390:             loc_nRet = SQLEXEC(gnConnHandle, ;
8391:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = " + ;
8392:                 EscaparSQL(loc_cGrupos) + " AND uniprdts = " + ;
8393:                 EscaparSQL(loc_cValAtual), "cursor_4c_FaseUpdBusca")
8394:             IF loc_nRet > 0 AND USED("cursor_4c_FaseUpdBusca") AND !EOF("cursor_4c_FaseUpdBusca")
8395:                 IF USED("cursor_4c_FaseUpdBusca")
8396:                     USE IN cursor_4c_FaseUpdBusca
8397:                 ENDIF
8398:                 loc_lResultado = .T.
8399:             ENDIF
8400:             IF USED("cursor_4c_FaseUpdBusca")
8401:                 USE IN cursor_4c_FaseUpdBusca
8402:             ENDIF
8403: 
8404:             *-- Abrir busca das unidades produtivas para este grupo
8405:             loc_nRet = SQLEXEC(gnConnHandle, ;
8406:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = " + ;
8407:                 EscaparSQL(loc_cGrupos) + " ORDER BY uniprdts", "cursor_4c_FaseUpdBusca")
8408:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseUpdBusca") OR EOF("cursor_4c_FaseUpdBusca")
8409:                 IF USED("cursor_4c_FaseUpdBusca")
8410:                     USE IN cursor_4c_FaseUpdBusca
8411:                 ENDIF
8412:                 SQLEXEC(gnConnHandle, ;
8413:                     "SELECT DISTINCT uniprdts FROM SigCdUpd ORDER BY uniprdts", ;
8414:                     "cursor_4c_FaseUpdBusca")
8415:             ENDIF
8416: 
8417:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8418:             IF VARTYPE(loc_oBusca) = "O"
8419:                 loc_oBusca.DefinirCursor("cursor_4c_FaseUpdBusca", "uniprdts", "uniprdts", ;
8420:                     "Selecionar Uni. Produtiva")
8421:                 loc_oBusca.Mostrar()
8422:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8423:                     SELECT cursor_4c_GradFase
8424:                     REPLACE cursor_4c_GradFase.uniprdts WITH loc_oBusca.cCodigoSelecionado
8425:                 ENDIF
8426:                 loc_oBusca = .NULL.
8427:             ENDIF
8428: 
8429:             IF USED("cursor_4c_FaseUpdBusca")
8430:                 USE IN cursor_4c_FaseUpdBusca
8431:             ENDIF
8432: 
8433:         CATCH TO loException
8434:             IF USED("cursor_4c_FaseUpdBusca")
8435:                 USE IN cursor_4c_FaseUpdBusca
8436:             ENDIF
8437:             MostrarErro("Erro ao validar uni. produtiva:" + CHR(13) + loException.Message, ;
8438:                 "FormProduto.GrdFaseCol4UniPrdtValid")
8439:         ENDTRY
8440:         RETURN .T.
8441:     ENDPROC
8442: 
8443:     *===========================================================================
8444:     * GrdFaseCol5MatPrdtValid - Lookup de Material (SigOpOpt) na GradFase
8445:     * PUBLIC: BINDEVENT requer metodo publico
8446:     *===========================================================================
8447:     PROCEDURE GrdFaseCol5MatPrdtValid()
8448:         LOCAL loc_cValAtual, loc_cGrupos, loc_nRet, loc_oBusca, loException
8449:         TRY
8450:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8451:                 loc_lResultado = .T.
8452:             ENDIF
8453:             SELECT cursor_4c_GradFase
8454:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.matprdts)
8455:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8456:             IF EMPTY(loc_cValAtual)
8457:                 loc_lResultado = .T.
8458:             ENDIF
8459: 
8460:             loc_nRet = SQLEXEC(gnConnHandle, ;
8461:                 "SELECT cods, descs FROM SigOpOpt WHERE cods = '" + ;
8462:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseOptBusca")
8463:             IF loc_nRet > 0 AND USED("cursor_4c_FaseOptBusca") AND !EOF("cursor_4c_FaseOptBusca")
8464:                 IF USED("cursor_4c_FaseOptBusca")
8465:                     USE IN cursor_4c_FaseOptBusca
8466:                 ENDIF
8467:                 loc_lResultado = .T.
8468:             ENDIF
8469:             IF USED("cursor_4c_FaseOptBusca")
8470:                 USE IN cursor_4c_FaseOptBusca
8471:             ENDIF
8472: 
8473:             *-- Abrir busca filtrando pelo grupo da fase
8474:             loc_nRet = SQLEXEC(gnConnHandle, ;
8475:                 "SELECT cods, descs FROM SigOpOpt WHERE grupos = '" + ;
8476:                 EscaparSQL(loc_cGrupos) + " AND cods LIKE '" + ;
8477:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_FaseOptBusca")
8478:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseOptBusca") OR EOF("cursor_4c_FaseOptBusca")
8479:                 IF USED("cursor_4c_FaseOptBusca")
8480:                     USE IN cursor_4c_FaseOptBusca
8481:                 ENDIF
8482:                 SQLEXEC(gnConnHandle, ;
8483:                     "SELECT cods, descs FROM SigOpOpt ORDER BY cods", ;
8484:                     "cursor_4c_FaseOptBusca")
8485:             ENDIF
8486: 
8487:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8488:             IF VARTYPE(loc_oBusca) = "O"
8489:                 loc_oBusca.DefinirCursor("cursor_4c_FaseOptBusca", "cods", "descs", ;
8490:                     "Selecionar Material")
8491:                 loc_oBusca.Mostrar()
8492:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8493:                     SELECT cursor_4c_GradFase
8494:                     REPLACE cursor_4c_GradFase.matprdts WITH loc_oBusca.cCodigoSelecionado
8495:                 ENDIF
8496:                 loc_oBusca = .NULL.
8497:             ENDIF
8498: 
8499:             IF USED("cursor_4c_FaseOptBusca")
8500:                 USE IN cursor_4c_FaseOptBusca
8501:             ENDIF
8502: 
8503:         CATCH TO loException
8504:             IF USED("cursor_4c_FaseOptBusca")
8505:                 USE IN cursor_4c_FaseOptBusca
8506:             ENDIF
8507:             MostrarErro("Erro ao validar material:" + CHR(13) + loException.Message, ;
8508:                 "FormProduto.GrdFaseCol5MatPrdtValid")
8509:         ENDTRY
8510:         RETURN .T.
8511:     ENDPROC
8512: 
8513:     *===========================================================================
8514:     * BtnInserirFaseClick - Insere nova linha na GradFase (cursor_4c_GradFase)
8515:     * PUBLIC: BINDEVENT requer metodo publico
8516:     *===========================================================================
8517:     PROCEDURE BtnInserirFaseClick()
8518:         LOCAL loc_oPg, loc_nProxOrdem, loException
8519:         TRY
8520:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8521:                 RETURN
8522:             ENDIF
8523:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8524:             IF !USED("cursor_4c_GradFase")
8525:                 RETURN
8526:             ENDIF
8527: 
8528:             SELECT cursor_4c_GradFase
8529:             IF EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase") OR ;
8530:                     RECCOUNT("cursor_4c_GradFase") = 0
8531:                 loc_nProxOrdem = 1
8532:             ELSE
8533:                 GO BOTTOM IN cursor_4c_GradFase
8534:                 loc_nProxOrdem = cursor_4c_GradFase.ordems + 1
8535:             ENDIF
8536: 
8537:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8538:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8539: 
8540:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8541:                 loc_oPg.grd_4c_GradFase.Refresh()
8542:                 GO BOTTOM IN cursor_4c_GradFase
8543:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8544:             ENDIF
8545: 
8546:         CATCH TO loException
8547:             MostrarErro("Erro ao inserir fase:" + CHR(13) + loException.Message, ;
8548:                 "FormProduto.BtnInserirFaseClick")
8549:         ENDTRY
8550:     ENDPROC
8551: 
8552:     *===========================================================================
8553:     * BtnExcluirFaseClick - Exclui linha atual da GradFase
8554:     * PUBLIC: BINDEVENT requer metodo publico
8555:     *===========================================================================
8556:     PROCEDURE BtnExcluirFaseClick()
8557:         LOCAL loc_oPg, loException
8558:         TRY
8559:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8560:                 RETURN
8561:             ENDIF
8562:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8563:                 RETURN
8564:             ENDIF
8565: 
8566:             SELECT cursor_4c_GradFase
8567:             IF !MsgConfirma("Excluir esta fase de produ" + CHR(231) + CHR(227) + "o?")
8568:                 RETURN
8569:             ENDIF
8570:             DELETE IN cursor_4c_GradFase
8571:             IF !EOF("cursor_4c_GradFase")
8572:                 SKIP IN cursor_4c_GradFase
8573:             ENDIF
8574:             IF EOF("cursor_4c_GradFase") AND RECCOUNT("cursor_4c_GradFase") > 0
8575:                 GO BOTTOM IN cursor_4c_GradFase
8576:             ENDIF
8577: 
8578:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8579:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8580:                 loc_oPg.grd_4c_GradFase.Refresh()
8581:             ENDIF
8582: 
8583:         CATCH TO loException
8584:             MostrarErro("Erro ao excluir fase:" + CHR(13) + loException.Message, ;
8585:                 "FormProduto.BtnExcluirFaseClick")
8586:         ENDTRY
8587:     ENDPROC
8588: 
8589:     *===========================================================================
8590:     * BtnAlternativaFaseClick - Insere fase alternativa apos a fase atual
8591:     * PUBLIC: BINDEVENT requer metodo publico
8592:     *===========================================================================
8593:     PROCEDURE BtnAlternativaFaseClick()
8594:         LOCAL loc_oPg, loc_nOrdemAtual, loc_nProxOrdem, loException
8595:         TRY
8596:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8597:                 RETURN
8598:             ENDIF
8599:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8600:             IF !USED("cursor_4c_GradFase")
8601:                 RETURN
8602:             ENDIF
8603: 
8604:             SELECT cursor_4c_GradFase
8605:             IF EOF("cursor_4c_GradFase") OR RECCOUNT("cursor_4c_GradFase") = 0
8606:                 loc_nOrdemAtual = 0
8607:             ELSE
8608:                 loc_nOrdemAtual = cursor_4c_GradFase.ordems
8609:             ENDIF
8610:             loc_nProxOrdem = loc_nOrdemAtual + 1
8611: 
8612:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8613:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8614: 
8615:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8616:                 loc_oPg.grd_4c_GradFase.Refresh()
8617:                 GO BOTTOM IN cursor_4c_GradFase
8618:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8619:             ENDIF
8620: 
8621:         CATCH TO loException
8622:             MostrarErro("Erro ao inserir fase alternativa:" + CHR(13) + loException.Message, ;
8623:                 "FormProduto.BtnAlternativaFaseClick")
8624:         ENDTRY
8625:     ENDPROC
8626: 
8627:     *===========================================================================
8628:     * CmdFichaFasePClick - Abre formulario de Ficha Tecnica do produto
8629:     * PUBLIC: BINDEVENT requer metodo publico
8630:     *===========================================================================
8631:     PROCEDURE CmdFichaFasePClick()
8632:         LOCAL loc_cCpros, loException
8633:         TRY
8634:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
8635:             IF EMPTY(loc_cCpros)
8636:                 MsgAviso("Selecione um produto para abrir a Ficha T" + CHR(233) + "cnica.", ;
8637:                     "Ficha T" + CHR(233) + "cnica")
8638:                 RETURN
8639:             ENDIF
8640:             MsgInfo("Ficha T" + CHR(233) + "cnica: " + loc_cCpros)
8641:         CATCH TO loException
8642:             MostrarErro("Erro ao abrir Ficha T" + CHR(233) + "cnica:" + CHR(13) + ;
8643:                 loException.Message, "FormProduto.CmdFichaFasePClick")
8644:         ENDTRY
8645:     ENDPROC
8646: 
8647:     *===========================================================================
8648:     * CmdFiguraFasePClick - Captura imagem do produto via seletor de arquivo
8649:     * PUBLIC: BINDEVENT requer metodo publico
8650:     *===========================================================================
8651:     PROCEDURE CmdFiguraFasePClick()
8652:         LOCAL loc_lcFigura, loc_lcArquivo, loc_oPg, loException
8653:         TRY
8654:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8655:                 RETURN
8656:             ENDIF
8657:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8658:                 MsgAviso("Selecione uma fase na grade para associar a imagem.", "Imagem")
8659:                 RETURN
8660:             ENDIF
8661: 
8662:             loc_lcFigura = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", ;
8663:                 "Nome do Arquivo:", "Selecionar"))
8664:             IF EMPTY(loc_lcFigura) OR !FILE(loc_lcFigura)
8665:                 RETURN
8666:             ENDIF
8667: 
8668:             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8669:             COPY FILE (loc_lcFigura) TO (loc_lcArquivo)
8670: 
8671:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8672:             IF PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5)
8673:                 CLEAR RESOURCES
8674:                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
8675:                 loc_oPg.img_4c_ImgFig.Visible = .T.
8676:             ENDIF
8677: 
8678:         CATCH TO loException
8679:             MostrarErro("Erro ao capturar imagem:" + CHR(13) + loException.Message, ;
8680:                 "FormProduto.CmdFiguraFasePClick")
8681:         ENDTRY
8682:     ENDPROC
8683: 
8684:     *===========================================================================
8685:     * CmdFigCamFasePClick - Captura imagem do produto via WebCam (SigImage)
8686:     * PUBLIC: BINDEVENT requer metodo publico
8687:     *===========================================================================
8688:     PROCEDURE CmdFigCamFasePClick()
8689:         LOCAL loc_lcFigura, loc_lcArquivo, loc_oPg, loException
8690:         TRY
8691:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8692:                 RETURN
8693:             ENDIF
8694:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8695:                 MsgAviso("Selecione uma fase na grade para associar a imagem.", "Imagem WebCam")
8696:                 RETURN
8697:             ENDIF
8698: 
8699:             loc_lcFigura = ""
8700:             DO FORM SigImage TO loc_lcFigura
8701:             IF EMPTY(loc_lcFigura) OR !FILE(loc_lcFigura)
8702:                 RETURN
8703:             ENDIF
8704: 
8705:             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8706:             COPY FILE (loc_lcFigura) TO (loc_lcArquivo)
8707: 
8708:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8709:             IF PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5)
8710:                 CLEAR RESOURCES
8711:                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
8712:                 loc_oPg.img_4c_ImgFig.Visible = .T.
8713:             ENDIF
8714: 
8715:         CATCH TO loException
8716:             MostrarErro("Erro ao capturar imagem via WebCam:" + CHR(13) + loException.Message, ;
8717:                 "FormProduto.CmdFigCamFasePClick")
8718:         ENDTRY
8719:     ENDPROC
8720: 
8721:     *===========================================================================
8722:     * ValidarConquilhaFaseP - Lookup de Conquilha (sigcdcnq) em txt_4c_Conquilhas
8723:     * PUBLIC: BINDEVENT requer metodo publico
8724:     *===========================================================================
8725:     PROCEDURE ValidarConquilhaFaseP(par_nKeyCode, par_nShiftAltCtrl)
8726:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8727:         TRY
8728:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8729:             IF !PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
8730:                 loc_lResultado = .T.
8731:             ENDIF
8732:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value)
8733:             IF EMPTY(loc_cValAtual)
8734:                 loc_lResultado = .T.
8735:             ENDIF
8736: 
8737:             loc_nRet = SQLEXEC(gnConnHandle, ;
8738:                 "SELECT conquilhas FROM sigcdcnq WHERE conquilhas = " + ;
8739:                 EscaparSQL(loc_cValAtual), "cursor_4c_CnqBusca")
8740:             IF loc_nRet > 0 AND USED("cursor_4c_CnqBusca") AND !EOF("cursor_4c_CnqBusca")
8741:                 IF USED("cursor_4c_CnqBusca")
8742:                     USE IN cursor_4c_CnqBusca
8743:                 ENDIF
8744:                 loc_lResultado = .T.
8745:             ENDIF
8746:             IF USED("cursor_4c_CnqBusca")
8747:                 USE IN cursor_4c_CnqBusca
8748:             ENDIF
8749: 
8750:             loc_nRet = SQLEXEC(gnConnHandle, ;
8751:                 "SELECT DISTINCT conquilhas FROM sigcdcnq WHERE conquilhas LIKE " + ;
8752:                 EscaparSQL(ALLTRIM(loc_cValAtual) + "%") + " ORDER BY conquilhas", "cursor_4c_CnqBusca")
8753:             IF loc_nRet <= 0 OR !USED("cursor_4c_CnqBusca") OR EOF("cursor_4c_CnqBusca")
8754:                 IF USED("cursor_4c_CnqBusca")
8755:                     USE IN cursor_4c_CnqBusca
8756:                 ENDIF
8757:                 SQLEXEC(gnConnHandle, ;
8758:                     "SELECT DISTINCT conquilhas FROM sigcdcnq ORDER BY conquilhas", ;
8759:                     "cursor_4c_CnqBusca")
8760:             ENDIF
8761: 
8762:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8763:             IF VARTYPE(loc_oBusca) = "O"
8764:                 loc_oBusca.DefinirCursor("cursor_4c_CnqBusca", "conquilhas", "conquilhas", ;
8765:                     "Selecionar Conquilha")
8766:                 loc_oBusca.Mostrar()
8767:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8768:                     loc_oPg.txt_4c_Conquilhas.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8769:                 ENDIF
8770:                 loc_oBusca = .NULL.
8771:             ENDIF
8772: 
8773:             IF USED("cursor_4c_CnqBusca")
8774:                 USE IN cursor_4c_CnqBusca
8775:             ENDIF
8776: 
8777:         CATCH TO loException
8778:             IF USED("cursor_4c_CnqBusca")
8779:                 USE IN cursor_4c_CnqBusca
8780:             ENDIF
8781:             MostrarErro("Erro ao validar conquilha:" + CHR(13) + loException.Message, ;
8782:                 "FormProduto.ValidarConquilhaFaseP")
8783:         ENDTRY
8784:         RETURN .T.
8785:     ENDPROC
8786: 
8787:     *===========================================================================
8788:     * ValidarCorFaseP - Lookup de Cor Padrao (SigCdCor) em txt_4c_CodCorsFP
8789:     * PUBLIC: BINDEVENT requer metodo publico
8790:     *===========================================================================
8791:     PROCEDURE ValidarCorFaseP(par_nKeyCode, par_nShiftAltCtrl)
8792:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8793:         TRY
8794:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8795:             IF !PEMSTATUS(loc_oPg, "txt_4c_CodCorsFP", 5)
8796:                 loc_lResultado = .T.
8797:             ENDIF
8798:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodCorsFP.Value)
8799:             IF EMPTY(loc_cValAtual)
8800:                 loc_lResultado = .T.
8801:             ENDIF
8802: 
8803:             loc_nRet = SQLEXEC(gnConnHandle, ;
8804:                 "SELECT cods, descs FROM SigCdCor WHERE cods = '" + ;
8805:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_CorFPBusca")
8806:             IF loc_nRet > 0 AND USED("cursor_4c_CorFPBusca") AND !EOF("cursor_4c_CorFPBusca")
8807:                 IF USED("cursor_4c_CorFPBusca")
8808:                     USE IN cursor_4c_CorFPBusca
8809:                 ENDIF
8810:                 *-- Sincronizar com Page1
8811:                 LOCAL loc_oPg1
8812:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8813:                 IF PEMSTATUS(loc_oPg1, "txt_4c_CodCors", 5)
8814:                     loc_oPg1.txt_4c_CodCors.Value = loc_cValAtual
8815:                 ENDIF
8816:                 loc_lResultado = .T.
8817:             ENDIF
8818:             IF USED("cursor_4c_CorFPBusca")
8819:                 USE IN cursor_4c_CorFPBusca
8820:             ENDIF
8821: 
8822:             loc_nRet = SQLEXEC(gnConnHandle, ;
8823:                 "SELECT cods, descs FROM SigCdCor WHERE cods LIKE '" + ;
8824:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_CorFPBusca")
8825:             IF loc_nRet <= 0 OR !USED("cursor_4c_CorFPBusca") OR EOF("cursor_4c_CorFPBusca")
8826:                 IF USED("cursor_4c_CorFPBusca")
8827:                     USE IN cursor_4c_CorFPBusca
8828:                 ENDIF
8829:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCor ORDER BY cods", ;
8830:                     "cursor_4c_CorFPBusca")
8831:             ENDIF
8832: 
8833:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8834:             IF VARTYPE(loc_oBusca) = "O"
8835:                 loc_oBusca.DefinirCursor("cursor_4c_CorFPBusca", "cods", "descs", ;
8836:                     "Selecionar Cor Padr" + CHR(227) + "o")
8837:                 loc_oBusca.Mostrar()
8838:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8839:                     loc_oPg.txt_4c_CodCorsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8840:                     LOCAL loc_oPg1b
8841:                     loc_oPg1b = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8842:                     IF PEMSTATUS(loc_oPg1b, "txt_4c_CodCors", 5)
8843:                         loc_oPg1b.txt_4c_CodCors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8844:                     ENDIF
8845:                 ENDIF
8846:                 loc_oBusca = .NULL.
8847:             ENDIF
8848: 
8849:             IF USED("cursor_4c_CorFPBusca")
8850:                 USE IN cursor_4c_CorFPBusca
8851:             ENDIF
8852: 
8853:         CATCH TO loException
8854:             IF USED("cursor_4c_CorFPBusca")
8855:                 USE IN cursor_4c_CorFPBusca
8856:             ENDIF
8857:             MostrarErro("Erro ao validar cor padr" + CHR(227) + "o:" + CHR(13) + ;
8858:                 loException.Message, "FormProduto.ValidarCorFaseP")
8859:         ENDTRY
8860:         RETURN .T.
8861:     ENDPROC
8862: 
8863:     *===========================================================================
8864:     * ValidarTamFaseP - Lookup de Tamanho Padrao (SigCdTam) em txt_4c_CodTamsFP
8865:     * PUBLIC: BINDEVENT requer metodo publico
8866:     *===========================================================================
8867:     PROCEDURE ValidarTamFaseP(par_nKeyCode, par_nShiftAltCtrl)
8868:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8869:         TRY
8870:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8871:             IF !PEMSTATUS(loc_oPg, "txt_4c_CodTamsFP", 5)
8872:                 loc_lResultado = .T.
8873:             ENDIF
8874:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodTamsFP.Value)
8875:             IF EMPTY(loc_cValAtual)
8876:                 loc_lResultado = .T.
8877:             ENDIF
8878: 
8879:             loc_nRet = SQLEXEC(gnConnHandle, ;
8880:                 "SELECT cods, descs FROM SigCdTam WHERE cods = '" + ;
8881:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_TamFPBusca")
8882:             IF loc_nRet > 0 AND USED("cursor_4c_TamFPBusca") AND !EOF("cursor_4c_TamFPBusca")
8883:                 IF USED("cursor_4c_TamFPBusca")
8884:                     USE IN cursor_4c_TamFPBusca
8885:                 ENDIF
8886:                 LOCAL loc_oPg1c
8887:                 loc_oPg1c = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8888:                 IF PEMSTATUS(loc_oPg1c, "txt_4c_CodTams", 5)
8889:                     loc_oPg1c.txt_4c_CodTams.Value = loc_cValAtual
8890:                 ENDIF
8891:                 loc_lResultado = .T.
8892:             ENDIF
8893:             IF USED("cursor_4c_TamFPBusca")
8894:                 USE IN cursor_4c_TamFPBusca
8895:             ENDIF
8896: 
8897:             loc_nRet = SQLEXEC(gnConnHandle, ;
8898:                 "SELECT cods, descs FROM SigCdTam WHERE cods LIKE '" + ;
8899:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_TamFPBusca")
8900:             IF loc_nRet <= 0 OR !USED("cursor_4c_TamFPBusca") OR EOF("cursor_4c_TamFPBusca")
8901:                 IF USED("cursor_4c_TamFPBusca")
8902:                     USE IN cursor_4c_TamFPBusca
8903:                 ENDIF
8904:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdTam ORDER BY cods", ;
8905:                     "cursor_4c_TamFPBusca")
8906:             ENDIF
8907: 
8908:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8909:             IF VARTYPE(loc_oBusca) = "O"
8910:                 loc_oBusca.DefinirCursor("cursor_4c_TamFPBusca", "cods", "descs", ;
8911:                     "Selecionar Tamanho Padr" + CHR(227) + "o")
8912:                 loc_oBusca.Mostrar()
8913:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8914:                     loc_oPg.txt_4c_CodTamsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8915:                     LOCAL loc_oPg1d
8916:                     loc_oPg1d = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8917:                     IF PEMSTATUS(loc_oPg1d, "txt_4c_CodTams", 5)
8918:                         loc_oPg1d.txt_4c_CodTams.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8919:                     ENDIF
8920:                 ENDIF
8921:                 loc_oBusca = .NULL.
8922:             ENDIF
8923: 
8924:             IF USED("cursor_4c_TamFPBusca")
8925:                 USE IN cursor_4c_TamFPBusca
8926:             ENDIF
8927: 
8928:         CATCH TO loException
8929:             IF USED("cursor_4c_TamFPBusca")
8930:                 USE IN cursor_4c_TamFPBusca
8931:             ENDIF
8932:             MostrarErro("Erro ao validar tamanho padr" + CHR(227) + "o:" + CHR(13) + ;
8933:                 loException.Message, "FormProduto.ValidarTamFaseP")
8934:         ENDTRY
8935:         RETURN .T.
8936:     ENDPROC
8937: 
8938:     *===========================================================================
8939:     * ValidarAcabamentoFaseP - Lookup de Acabamento (SigCdAca) em txt_4c_CodAcbsFP
8940:     * PUBLIC: BINDEVENT requer metodo publico
8941:     *===========================================================================
8942:     PROCEDURE ValidarAcabamentoFaseP(par_nKeyCode, par_nShiftAltCtrl)
8943:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8944:         TRY
8945:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8946:             IF !PEMSTATUS(loc_oPg, "txt_4c_CodAcbsFP", 5)
8947:                 loc_lResultado = .T.
8948:             ENDIF
8949:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodAcbsFP.Value)
8950:             IF EMPTY(loc_cValAtual)
8951:                 loc_oPg.txt_4c_DacbFP.Value = ""
8952:                 loc_lResultado = .T.
8953:             ENDIF
8954: 
8955:             loc_nRet = SQLEXEC(gnConnHandle, ;
8956:                 "SELECT cods, descrs FROM SigCdAca WHERE cods = '" + ;
8957:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_AcaFPBusca")
8958:             IF loc_nRet > 0 AND USED("cursor_4c_AcaFPBusca") AND !EOF("cursor_4c_AcaFPBusca")
8959:                 SELECT cursor_4c_AcaFPBusca
8960:                 loc_oPg.txt_4c_DacbFP.Value = ALLTRIM(cursor_4c_AcaFPBusca.descrs)
8961:                 IF USED("cursor_4c_AcaFPBusca")
8962:                     USE IN cursor_4c_AcaFPBusca
8963:                 ENDIF
8964:                 LOCAL loc_oPg1e
8965:                 loc_oPg1e = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8966:                 IF PEMSTATUS(loc_oPg1e, "txt_4c_CodAcbs", 5)
8967:                     loc_oPg1e.txt_4c_CodAcbs.Value = loc_cValAtual
8968:                 ENDIF
8969:                 loc_lResultado = .T.
8970:             ENDIF
8971:             IF USED("cursor_4c_AcaFPBusca")
8972:                 USE IN cursor_4c_AcaFPBusca
8973:             ENDIF
8974: 
8975:             loc_nRet = SQLEXEC(gnConnHandle, ;
8976:                 "SELECT cods, descrs FROM SigCdAca WHERE cods LIKE '" + ;
8977:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_AcaFPBusca")
8978:             IF loc_nRet <= 0 OR !USED("cursor_4c_AcaFPBusca") OR EOF("cursor_4c_AcaFPBusca")
8979:                 IF USED("cursor_4c_AcaFPBusca")
8980:                     USE IN cursor_4c_AcaFPBusca
8981:                 ENDIF
8982:                 SQLEXEC(gnConnHandle, "SELECT cods, descrs FROM SigCdAca ORDER BY cods", ;
8983:                     "cursor_4c_AcaFPBusca")
8984:             ENDIF
8985: 
8986:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8987:             IF VARTYPE(loc_oBusca) = "O"
8988:                 loc_oBusca.DefinirCursor("cursor_4c_AcaFPBusca", "cods", "descrs", ;
8989:                     "Selecionar Acabamento")
8990:                 loc_oBusca.Mostrar()
8991:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8992:                     loc_oPg.txt_4c_CodAcbsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8993:                     loc_oPg.txt_4c_DacbFP.Value    = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
8994:                     LOCAL loc_oPg1f
8995:                     loc_oPg1f = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8996:                     IF PEMSTATUS(loc_oPg1f, "txt_4c_CodAcbs", 5)
8997:                         loc_oPg1f.txt_4c_CodAcbs.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8998:                     ENDIF
8999:                 ENDIF
9000:                 loc_oBusca = .NULL.
9001:             ENDIF
9002: 
9003:             IF USED("cursor_4c_AcaFPBusca")
9004:                 USE IN cursor_4c_AcaFPBusca
9005:             ENDIF
9006: 
9007:         CATCH TO loException
9008:             IF USED("cursor_4c_AcaFPBusca")
9009:                 USE IN cursor_4c_AcaFPBusca
9010:             ENDIF
9011:             MostrarErro("Erro ao validar acabamento:" + CHR(13) + loException.Message, ;
9012:                 "FormProduto.ValidarAcabamentoFaseP")
9013:         ENDTRY
9014:         RETURN .T.
9015:     ENDPROC
9016: 
9017:     *===========================================================================
9018:     * GrdMatrizesCol1Valid - Lookup de produto-matriz (SigCdPro) em grdMatrizes
9019:     * PUBLIC: BINDEVENT requer metodo publico
9020:     *===========================================================================
9021:     PROCEDURE GrdMatrizesCol1Valid()
9022:         LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
9023:         TRY
9024:             IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
9025:                 loc_lResultado = .T.
9026:             ENDIF
9027:             SELECT cursor_4c_GrdMatrizes
9028:             loc_cValAtual = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9029:             IF EMPTY(loc_cValAtual)
9030:                 loc_lResultado = .T.
9031:             ENDIF
9032: 
9033:             loc_nRet = SQLEXEC(gnConnHandle, ;
9034:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros = '" + ;
9035:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_MtzPrBusca")
9036:             IF loc_nRet > 0 AND USED("cursor_4c_MtzPrBusca") AND !EOF("cursor_4c_MtzPrBusca")
9037:                 SELECT cursor_4c_MtzPrBusca
9038:                 SELECT cursor_4c_GrdMatrizes
9039:                 REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(cursor_4c_MtzPrBusca.dpros)
9040:                 IF USED("cursor_4c_MtzPrBusca")
9041:                     USE IN cursor_4c_MtzPrBusca
9042:                 ENDIF
9043:                 loc_lResultado = .T.
9044:             ENDIF
9045:             IF USED("cursor_4c_MtzPrBusca")
9046:                 USE IN cursor_4c_MtzPrBusca
9047:             ENDIF
9048: 
9049:             *-- Codigo nao encontrado: abrir busca
9050:             loc_nRet = SQLEXEC(gnConnHandle, ;
9051:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros LIKE '" + ;
9052:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cpros", "cursor_4c_MtzPrBusca")
9053:             IF loc_nRet <= 0 OR !USED("cursor_4c_MtzPrBusca") OR EOF("cursor_4c_MtzPrBusca")
9054:                 IF USED("cursor_4c_MtzPrBusca")
9055:                     USE IN cursor_4c_MtzPrBusca
9056:                 ENDIF
9057:                 SQLEXEC(gnConnHandle, ;
9058:                     "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
9059:                     "cursor_4c_MtzPrBusca")
9060:             ENDIF
9061: 
9062:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9063:             IF VARTYPE(loc_oBusca) = "O"
9064:                 loc_oBusca.DefinirCursor("cursor_4c_MtzPrBusca", "cpros", "dpros", ;
9065:                     "Selecionar Produto Matriz")
9066:                 loc_oBusca.Mostrar()
9067:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdMatrizes")
9068:                     SELECT cursor_4c_GrdMatrizes
9069:                     REPLACE cursor_4c_GrdMatrizes.cmats WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
9070:                     REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
9071:                 ENDIF
9072:                 loc_oBusca = .NULL.
9073:             ENDIF
9074: 
9075:             IF USED("cursor_4c_MtzPrBusca")
9076:                 USE IN cursor_4c_MtzPrBusca
9077:             ENDIF
9078: 
9079:         CATCH TO loException
9080:             IF USED("cursor_4c_MtzPrBusca")
9081:                 USE IN cursor_4c_MtzPrBusca
9082:             ENDIF
9083:             MostrarErro("Erro ao validar matriz:" + CHR(13) + loException.Message, ;
9084:                 "FormProduto.GrdMatrizesCol1Valid")
9085:         ENDTRY
9086:         RETURN .T.
9087:     ENDPROC
9088: 
9089:     *===========================================================================
9090:     * GrdMatrizesAfterRowColChange - Exibe imagem do molde da matriz selecionada
9091:     * PUBLIC: BINDEVENT requer metodo publico
9092:     *===========================================================================
9093:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
9094:         LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
9095:         TRY
9096:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9097:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) OR !USED("cursor_4c_GrdMatrizes")
9098:                 RETURN
9099:             ENDIF
9100: 
9101:             CLEAR RESOURCES
9102:             loc_oPg.img_4c_ImgBorracha.Picture = ""
9103:             loc_oPg.img_4c_ImgBorracha.Visible = .F.
9104: 
9105:             IF !EOF("cursor_4c_GrdMatrizes") AND !BOF("cursor_4c_GrdMatrizes")
9106:                 SELECT cursor_4c_GrdMatrizes
9107:                 LOCAL loc_cCmats
9108:                 loc_cCmats = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9109:                 IF !EMPTY(loc_cCmats)
9110:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9111:                         "SELECT figprocs FROM SigCdPro WHERE cpros = '" + ;
9112:                         EscaparSQL(loc_cCmats) + "", "cursor_4c_MtzImgPro")
9113:                     IF loc_nRet > 0 AND USED("cursor_4c_MtzImgPro") AND !EOF("cursor_4c_MtzImgPro")
9114:                         SELECT cursor_4c_MtzImgPro
9115:                         IF !ISNULL(cursor_4c_MtzImgPro.figprocs) AND ;
9116:                                 !EMPTY(cursor_4c_MtzImgPro.figprocs)
9117:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9118:                             IF STRTOFILE(cursor_4c_MtzImgPro.figprocs, loc_lcArquivo) > 0
9119:                                 loc_oPg.img_4c_ImgBorracha.Visible = .T.
9120:                                 loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9121:                             ENDIF
9122:                         ENDIF
9123:                     ENDIF
9124:                     IF USED("cursor_4c_MtzImgPro")
9125:                         USE IN cursor_4c_MtzImgPro
9126:                     ENDIF
9127:                 ENDIF
9128:             ENDIF
9129: 
9130:         CATCH TO loException
9131:             MostrarErro("Erro ao atualizar imagem de matriz:" + CHR(13) + loException.Message, ;
9132:                 "FormProduto.GrdMatrizesAfterRowColChange")
9133:         ENDTRY
9134:     ENDPROC
9135: 
9136:     *===========================================================================
9137:     * BtnInserirMtzClick - Insere nova linha em grdMatrizes (cursor_4c_GrdMatrizes)
9138:     * PUBLIC: BINDEVENT requer metodo publico
9139:     *===========================================================================
9140:     PROCEDURE BtnInserirMtzClick()
9141:         LOCAL loc_oPg, loException
9142:         TRY
9143:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9144:                 RETURN
9145:             ENDIF
9146:             IF !USED("cursor_4c_GrdMatrizes")
9147:                 RETURN
9148:             ENDIF
9149: 
9150:             INSERT INTO cursor_4c_GrdMatrizes (cidchaves, cmats, qtds, dpros) ;
9151:                 VALUES (SYS(2015), "", 0, "")
9152: 
9153:             GO BOTTOM IN cursor_4c_GrdMatrizes
9154: 
9155:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9156:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9157:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9158:                 loc_oPg.grd_4c_GrdMatrizes.Column1.SetFocus()
9159:             ENDIF
9160: 
9161:         CATCH TO loException
9162:             MostrarErro("Erro ao inserir matriz:" + CHR(13) + loException.Message, ;
9163:                 "FormProduto.BtnInserirMtzClick")
9164:         ENDTRY
9165:     ENDPROC
9166: 
9167:     *===========================================================================
9168:     * BtnExcluirMtzClick - Exclui linha atual de grdMatrizes
9169:     * PUBLIC: BINDEVENT requer metodo publico
9170:     *===========================================================================
9171:     PROCEDURE BtnExcluirMtzClick()
9172:         LOCAL loc_oPg, loException
9173:         TRY
9174:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9175:                 RETURN
9176:             ENDIF
9177:             IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
9178:                 RETURN
9179:             ENDIF
9180: 
9181:             SELECT cursor_4c_GrdMatrizes
9182:             IF !MsgConfirma("Excluir este registro de matriz?")
9183:                 RETURN
9184:             ENDIF
9185:             DELETE IN cursor_4c_GrdMatrizes
9186:             IF !EOF("cursor_4c_GrdMatrizes")
9187:                 SKIP IN cursor_4c_GrdMatrizes
9188:             ENDIF
9189:             IF EOF("cursor_4c_GrdMatrizes") AND RECCOUNT("cursor_4c_GrdMatrizes") > 0
9190:                 GO BOTTOM IN cursor_4c_GrdMatrizes
9191:             ENDIF
9192: 
9193:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9194:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9195:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9196:             ENDIF
9197: 
9198:         CATCH TO loException
9199:             MostrarErro("Erro ao excluir matriz:" + CHR(13) + loException.Message, ;
9200:                 "FormProduto.BtnExcluirMtzClick")
9201:         ENDTRY
9202:     ENDPROC
9203: 
9204:     *===========================================================================
9205:     * Handlers de BINDEVENT para pgDadosFiscais (Page3 de pgf_4c_Dados)
9206:     * Todos PUBLIC - requerido pelo BINDEVENT
9207:     *===========================================================================
9208: 
9209:     *-- Classificacao Fiscal (clfiscals): Valid
9210:     PROCEDURE ValidarClfiscal(par_nKeyCode, par_nShiftAltCtrl)
9211:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9212:             RETURN
9213:         ENDIF
9214:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9215:         TRY
9216:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9217:             IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9218:                 RETURN
9219:             ENDIF
9220:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9221:             IF EMPTY(loc_cCod)
9222:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9223:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9224:                 ENDIF
9225:                 RETURN
9226:             ENDIF
9227:             loc_nRet = SQLEXEC(gnConnHandle, ;
9228:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
9229:                 "cursor_4c_ClfBusca")
9230:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9231:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9232:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9233:                 ENDIF
9234:                 IF USED("cursor_4c_ClfBusca")
9235:                     USE IN cursor_4c_ClfBusca
9236:                 ENDIF
9237:             ELSE
9238:                 IF USED("cursor_4c_ClfBusca")
9239:                     USE IN cursor_4c_ClfBusca
9240:                 ENDIF
9241:                 THIS.AbrirBuscaClfiscal()
9242:             ENDIF
9243:         CATCH TO loException
9244:             IF USED("cursor_4c_ClfBusca")
9245:                 USE IN cursor_4c_ClfBusca
9246:             ENDIF
9247:             MostrarErro("Erro ao validar Classif. Fiscal:" + CHR(13) + loException.Message, ;
9248:                 "FormProduto.ValidarClfiscal")
9249:         ENDTRY
9250:     ENDPROC
9251: 
9252:     PROCEDURE TxtClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9253:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9254:             THIS.ValidarClfiscal()
9255:         ENDIF
9256:     ENDPROC
9257: 
9258:     *-- Classificacao Fiscal descricao: When
9259:     PROCEDURE TxtDclfiscalWhen()
9260:         LOCAL loc_oPg
9261:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9262:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9263:             RETURN .F.
9264:         ENDIF
9265:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9266:                EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
9267:     ENDPROC
9268: 
9269:     *-- Classificacao Fiscal descricao: Valid (busca por descricao)
9270:     PROCEDURE ValidarDclfiscal(par_nKeyCode, par_nShiftAltCtrl)
9271:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9272:             RETURN
9273:         ENDIF
9274:         LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
9275:         TRY
9276:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9277:             IF !PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9278:                 RETURN
9279:             ENDIF
9280:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
9281:             IF EMPTY(loc_cDesc)
9282:                 THIS.AbrirBuscaClfiscal()
9283:                 RETURN
9284:             ENDIF
9285:             loc_nRet = SQLEXEC(gnConnHandle, ;
9286:                 "SELECT codigos, descricaos FROM SigCdClf WHERE descricaos LIKE " + ;
9287:                 EscaparSQL(loc_cDesc + "%"), ;
9288:                 "cursor_4c_ClfBusca")
9289:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9290:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9291:                     loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.codigos)
9292:                 ENDIF
9293:                 loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9294:                 IF USED("cursor_4c_ClfBusca")
9295:                     USE IN cursor_4c_ClfBusca
9296:                 ENDIF
9297:             ELSE
9298:                 IF USED("cursor_4c_ClfBusca")
9299:                     USE IN cursor_4c_ClfBusca
9300:                 ENDIF
9301:                 THIS.AbrirBuscaClfiscal()
9302:             ENDIF
9303:         CATCH TO loException
9304:             IF USED("cursor_4c_ClfBusca")
9305:                 USE IN cursor_4c_ClfBusca
9306:             ENDIF
9307:             MostrarErro("Erro ao buscar Classif. Fiscal:" + CHR(13) + loException.Message, ;
9308:                 "FormProduto.ValidarDclfiscal")
9309:         ENDTRY
9310:     ENDPROC
9311: 
9312:     PROCEDURE TxtDclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9313:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9314:             THIS.ValidarDclfiscal()
9315:         ENDIF
9316:     ENDPROC
9317: 
9318:     *-- Origem Mercadoria (origmercs): Valid
9319:     PROCEDURE ValidarOrigmerc(par_nKeyCode, par_nShiftAltCtrl)
9320:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9321:             RETURN
9322:         ENDIF
9323:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9324:         TRY
9325:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9326:             IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9327:                 RETURN
9328:             ENDIF
9329:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
9330:             IF EMPTY(loc_cCod)
9331:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9332:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
9333:                 ENDIF
9334:                 RETURN
9335:             ENDIF
9336:             loc_nRet = SQLEXEC(gnConnHandle, ;
9337:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
9338:                 "cursor_4c_OrgBusca")
9339:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9340:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9341:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9342:                 ENDIF
9343:                 IF USED("cursor_4c_OrgBusca")
9344:                     USE IN cursor_4c_OrgBusca
9345:                 ENDIF
9346:             ELSE
9347:                 IF USED("cursor_4c_OrgBusca")
9348:                     USE IN cursor_4c_OrgBusca
9349:                 ENDIF
9350:                 THIS.AbrirBuscaOrigmerc()
9351:             ENDIF
9352:         CATCH TO loException
9353:             IF USED("cursor_4c_OrgBusca")
9354:                 USE IN cursor_4c_OrgBusca
9355:             ENDIF
9356:             MostrarErro("Erro ao validar Origem Mercadoria:" + CHR(13) + loException.Message, ;
9357:                 "FormProduto.ValidarOrigmerc")
9358:         ENDTRY
9359:     ENDPROC
9360: 
9361:     PROCEDURE TxtOrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9362:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9363:             THIS.ValidarOrigmerc()
9364:         ENDIF
9365:     ENDPROC
9366: 
9367:     *-- Origem Mercadoria descricao: When
9368:     PROCEDURE TxtDorigmercWhen()
9369:         LOCAL loc_oPg
9370:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9371:         IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9372:             RETURN .F.
9373:         ENDIF
9374:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9375:                EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
9376:     ENDPROC
9377: 
9378:     *-- Origem Mercadoria descricao: Valid
9379:     PROCEDURE ValidarDorigmerc(par_nKeyCode, par_nShiftAltCtrl)
9380:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9381:             RETURN
9382:         ENDIF
9383:         LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
9384:         TRY
9385:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9386:             IF !PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9387:                 RETURN
9388:             ENDIF
9389:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)
9390:             IF EMPTY(loc_cDesc)
9391:                 THIS.AbrirBuscaOrigmerc()
9392:                 RETURN
9393:             ENDIF
9394:             loc_nRet = SQLEXEC(gnConnHandle, ;
9395:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE descricaos LIKE " + ;
9396:                 EscaparSQL(loc_cDesc + "%"), ;
9397:                 "cursor_4c_OrgBusca")
9398:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9399:                 IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9400:                     loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(cursor_4c_OrgBusca.codigos)
9401:                 ENDIF
9402:                 loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9403:                 IF USED("cursor_4c_OrgBusca")
9404:                     USE IN cursor_4c_OrgBusca
9405:                 ENDIF
9406:             ELSE
9407:                 IF USED("cursor_4c_OrgBusca")
9408:                     USE IN cursor_4c_OrgBusca
9409:                 ENDIF
9410:                 THIS.AbrirBuscaOrigmerc()
9411:             ENDIF
9412:         CATCH TO loException
9413:             IF USED("cursor_4c_OrgBusca")
9414:                 USE IN cursor_4c_OrgBusca
9415:             ENDIF
9416:             MostrarErro("Erro ao buscar Origem Mercadoria:" + CHR(13) + loException.Message, ;
9417:                 "FormProduto.ValidarDorigmerc")
9418:         ENDTRY
9419:     ENDPROC
9420: 
9421:     PROCEDURE TxtDorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9422:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9423:             THIS.ValidarDorigmerc()
9424:         ENDIF
9425:     ENDPROC
9426: 
9427:     *-- Situacao Tributaria ICMS (sittricms): Valid
9428:     PROCEDURE ValidarSittricm(par_nKeyCode, par_nShiftAltCtrl)
9429:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9430:             RETURN
9431:         ENDIF
9432:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9433:         TRY
9434:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9435:             IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9436:                 RETURN
9437:             ENDIF
9438:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
9439:             IF EMPTY(loc_cCod)
9440:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9441:                     loc_oPg.txt_4c_Dsittricm.Value = ""
9442:                 ENDIF
9443:                 RETURN
9444:             ENDIF
9445:             loc_nRet = SQLEXEC(gnConnHandle, ;
9446:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9447:                 "cursor_4c_IcmBusca")
9448:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9449:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9450:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9451:                 ENDIF
9452:                 IF USED("cursor_4c_IcmBusca")
9453:                     USE IN cursor_4c_IcmBusca
9454:                 ENDIF
9455:             ELSE
9456:                 IF USED("cursor_4c_IcmBusca")
9457:                     USE IN cursor_4c_IcmBusca
9458:                 ENDIF
9459:                 THIS.AbrirBuscaSittricm()
9460:             ENDIF
9461:         CATCH TO loException
9462:             IF USED("cursor_4c_IcmBusca")
9463:                 USE IN cursor_4c_IcmBusca
9464:             ENDIF
9465:             MostrarErro("Erro ao validar Sit. Tribut" + CHR(225) + "ria ICMS:" + ;
9466:                 CHR(13) + loException.Message, "FormProduto.ValidarSittricm")
9467:         ENDTRY
9468:     ENDPROC
9469: 
9470:     PROCEDURE TxtSittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9471:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9472:             THIS.ValidarSittricm()
9473:         ENDIF
9474:     ENDPROC
9475: 
9476:     *-- Situacao Tributaria ICMS descricao: When
9477:     PROCEDURE TxtDsittricmWhen()
9478:         LOCAL loc_oPg
9479:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9480:         IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9481:             RETURN .F.
9482:         ENDIF
9483:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9484:                EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricm.Value))
9485:     ENDPROC
9486: 
9487:     *-- Situacao Tributaria ICMS descricao: Valid
9488:     PROCEDURE ValidarDsittricm(par_nKeyCode, par_nShiftAltCtrl)
9489:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9490:             RETURN
9491:         ENDIF
9492:         LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
9493:         TRY
9494:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9495:             IF !PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9496:                 RETURN
9497:             ENDIF
9498:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value)
9499:             IF EMPTY(loc_cDesc)
9500:                 THIS.AbrirBuscaSittricm()
9501:                 RETURN
9502:             ENDIF
9503:             loc_nRet = SQLEXEC(gnConnHandle, ;
9504:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE descricaos LIKE " + ;
9505:                 EscaparSQL(loc_cDesc + "%"), ;
9506:                 "cursor_4c_IcmBusca")
9507:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9508:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9509:                     loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_IcmBusca.codigos)
9510:                 ENDIF
9511:                 loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9512:                 IF USED("cursor_4c_IcmBusca")
9513:                     USE IN cursor_4c_IcmBusca
9514:                 ENDIF
9515:             ELSE
9516:                 IF USED("cursor_4c_IcmBusca")
9517:                     USE IN cursor_4c_IcmBusca
9518:                 ENDIF
9519:                 THIS.AbrirBuscaSittricm()
9520:             ENDIF
9521:         CATCH TO loException
9522:             IF USED("cursor_4c_IcmBusca")
9523:                 USE IN cursor_4c_IcmBusca
9524:             ENDIF
9525:             MostrarErro("Erro ao buscar Sit. Tribut" + CHR(225) + "ria ICMS:" + ;
9526:                 CHR(13) + loException.Message, "FormProduto.ValidarDsittricm")
9527:         ENDTRY
9528:     ENDPROC
9529: 
9530:     PROCEDURE TxtDsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9531:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9532:             THIS.ValidarDsittricm()
9533:         ENDIF
9534:     ENDPROC
9535: 
9536:     *-- Codigo Servico Fiscal: Valid (lookup SIGCDICM, copia para Sittricm)
9537:     PROCEDURE ValidarCodServsFiscal(par_nKeyCode, par_nShiftAltCtrl)
9538:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9539:             RETURN
9540:         ENDIF
9541:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9542:         TRY
9543:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9544:             IF !PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
9545:                 RETURN
9546:             ENDIF
9547:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
9548:             IF EMPTY(loc_cCod)
9549:                 RETURN
9550:             ENDIF
9551:             loc_nRet = SQLEXEC(gnConnHandle, ;
9552:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9553:                 "cursor_4c_IcmServBusca")
9554:             IF loc_nRet > 0 AND USED("cursor_4c_IcmServBusca") AND !EOF("cursor_4c_IcmServBusca")
9555:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9556:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_IcmServBusca.codigos)
9557:                 ENDIF
9558:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9559:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmServBusca.descricaos)
9560:                 ENDIF
9561:                 IF USED("cursor_4c_IcmServBusca")
9562:                     USE IN cursor_4c_IcmServBusca
9563:                 ENDIF
9564:             ELSE
9565:                 IF USED("cursor_4c_IcmServBusca")
9566:                     USE IN cursor_4c_IcmServBusca
9567:                 ENDIF
9568:                 THIS.AbrirBuscaCodServsFiscal()
9569:             ENDIF
9570:         CATCH TO loException
9571:             IF USED("cursor_4c_IcmServBusca")
9572:                 USE IN cursor_4c_IcmServBusca
9573:             ENDIF
9574:             MostrarErro("Erro ao validar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal:" + ;
9575:                 CHR(13) + loException.Message, "FormProduto.ValidarCodServsFiscal")
9576:         ENDTRY
9577:     ENDPROC
9578: 
9579:     PROCEDURE TxtCodServsFiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9580:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9581:             THIS.ValidarCodServsFiscal()
9582:         ENDIF
9583:     ENDPROC
9584: 
9585:     *-- Tipo de Tributacao (tptribs): Valid
9586:     PROCEDURE ValidarTpTrib(par_nKeyCode, par_nShiftAltCtrl)
9587:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9588:             RETURN
9589:         ENDIF
9590:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9591:         TRY
9592:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9593:             IF !PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
9594:                 RETURN
9595:             ENDIF
9596:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
9597:             IF EMPTY(loc_cCod)
9598:                 RETURN
9599:             ENDIF
9600:             loc_nRet = SQLEXEC(gnConnHandle, ;
9601:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos = " + EscaparSQL(loc_cCod), ;
9602:                 "cursor_4c_TpTribBusca")
9603:             IF loc_nRet > 0 AND USED("cursor_4c_TpTribBusca") AND !EOF("cursor_4c_TpTribBusca")
9604:                 IF USED("cursor_4c_TpTribBusca")
9605:                     USE IN cursor_4c_TpTribBusca
9606:                 ENDIF
9607:             ELSE
9608:                 IF USED("cursor_4c_TpTribBusca")
9609:                     USE IN cursor_4c_TpTribBusca
9610:                 ENDIF
9611:                 THIS.AbrirBuscaTpTrib()
9612:             ENDIF
9613:         CATCH TO loException
9614:             IF USED("cursor_4c_TpTribBusca")
9615:                 USE IN cursor_4c_TpTribBusca
9616:             ENDIF
9617:             MostrarErro("Erro ao validar Tipo de Tributa" + CHR(231) + CHR(227) + "o:" + ;
9618:                 CHR(13) + loException.Message, "FormProduto.ValidarTpTrib")
9619:         ENDTRY
9620:     ENDPROC
9621: 
9622:     PROCEDURE TxtTpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9623:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9624:             THIS.ValidarTpTrib()
9625:         ENDIF
9626:     ENDPROC
9627: 
9628:     *-- IAT (iats): Valid - aceita 'A','T' ou vazio
9629:     PROCEDURE ValidarIat(par_nKeyCode, par_nShiftAltCtrl)
9630:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9631:             RETURN .T.
9632:         ENDIF
9633:         LOCAL loc_oPg, loc_cVal, loc_lSucesso, loException
9634:         loc_lSucesso = .T.
9635:         TRY
9636:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9637:             IF !PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
9638:                 loc_lSucesso = .T.
9639:             ENDIF
9640:             loc_cVal = ALLTRIM(loc_oPg.txt_4c_Iat.Value)
9641:             IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "A", "T")
9642:                 MsgAviso("IAT deve ser 'A' (Arredondamento) ou 'T' (Truncamento).")
9643:                 loc_oPg.txt_4c_Iat.SetFocus()
9644:                 loc_lSucesso = .F.
9645:             ENDIF
9646:         CATCH TO loException
9647:             MostrarErro("Erro ao validar IAT:" + CHR(13) + loException.Message, ;
9648:                 "FormProduto.ValidarIat")
9649:         ENDTRY
9650:         RETURN loc_lSucesso
9651:     ENDPROC
9652: 
9653:     PROCEDURE TxtIatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9654:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9655:             THIS.ValidarIat()
9656:         ENDIF
9657:     ENDPROC
9658: 
9659:     *-- Combo IPI (ipis): When - edicao somente em INCLUIR/ALTERAR
9660:     PROCEDURE CboIpiWhen()
9661:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9662:     ENDPROC
9663: 
9664:     *-- Aliquota IPI (nAliqipis): Valid - verifica contra padrao da clf fiscal
9665:     PROCEDURE ValidarAliqIPI(par_nKeyCode, par_nShiftAltCtrl)
9666:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9667:             RETURN
9668:         ENDIF
9669:         LOCAL loc_oPg, loc_cClf, loc_nAliq, loc_nAliqRef, loc_nRet, loException
9670:         TRY
9671:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9672:             IF !PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5) OR !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9673:                 RETURN
9674:             ENDIF
9675:             loc_nAliq = loc_oPg.txt_4c_AliqIPI.Value
9676:             loc_cClf  = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9677:             IF EMPTY(loc_cClf) OR loc_nAliq = 0
9678:                 RETURN
9679:             ENDIF
9680:             loc_nRet = SQLEXEC(gnConnHandle, ;
9681:                 "SELECT aipis FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9682:                 "cursor_4c_ClfAliq")
9683:             IF loc_nRet > 0 AND USED("cursor_4c_ClfAliq") AND !EOF("cursor_4c_ClfAliq")
9684:                 loc_nAliqRef = cursor_4c_ClfAliq.aipis
9685:                 IF loc_nAliqRef > 0 AND ABS(loc_nAliq - loc_nAliqRef) > 0.001
9686:                     MsgAviso("Al" + CHR(237) + "quota IPI informada (" + ;
9687:                         TRANSFORM(loc_nAliq) + "%) difere da padr" + CHR(227) + ;
9688:                         "o da classifica" + CHR(231) + CHR(227) + "o fiscal (" + ;
9689:                         TRANSFORM(loc_nAliqRef) + "%).")
9690:                 ENDIF
9691:             ENDIF
9692:             IF USED("cursor_4c_ClfAliq")
9693:                 USE IN cursor_4c_ClfAliq
9694:             ENDIF
9695:         CATCH TO loException
9696:             IF USED("cursor_4c_ClfAliq")
9697:                 USE IN cursor_4c_ClfAliq
9698:             ENDIF
9699:             MostrarErro("Erro ao validar Al" + CHR(237) + "quota IPI:" + ;
9700:                 CHR(13) + loException.Message, "FormProduto.ValidarAliqIPI")
9701:         ENDTRY
9702:     ENDPROC
9703: 
9704:     PROCEDURE TxtAliqIPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9705:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9706:             THIS.ValidarAliqIPI()
9707:         ENDIF
9708:     ENDPROC
9709: 
9710:     *-- Extensao IPI (extipi): When - habilitado quando clf fiscal tem ipiprods='S'
9711:     PROCEDURE TxtExtipipWhen()
9712:         LOCAL loc_oPg, loc_cClf, loc_nRet, loc_lPermite, loException
9713:         loc_lPermite = .F.
9714:         TRY
9715:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9716:                 loc_lResultado = .F.
9717:             ENDIF
9718:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9719:             IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9720:                 loc_lResultado = .F.
9721:             ENDIF
9722:             loc_cClf = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9723:             IF EMPTY(loc_cClf)
9724:                 loc_lResultado = .F.
9725:             ENDIF
9726:             loc_nRet = SQLEXEC(gnConnHandle, ;
9727:                 "SELECT ipiprods FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9728:                 "cursor_4c_ClfIpiProd")
9729:             IF loc_nRet > 0 AND USED("cursor_4c_ClfIpiProd") AND !EOF("cursor_4c_ClfIpiProd")
9730:                 loc_lPermite = (ALLTRIM(cursor_4c_ClfIpiProd.ipiprods) = "S")
9731:             ENDIF
9732:             IF USED("cursor_4c_ClfIpiProd")
9733:                 USE IN cursor_4c_ClfIpiProd
9734:             ENDIF
9735:         CATCH TO loException
9736:             IF USED("cursor_4c_ClfIpiProd")
9737:                 USE IN cursor_4c_ClfIpiProd
9738:             ENDIF
9739:         ENDTRY
9740:         RETURN loc_lPermite
9741:     ENDPROC
9742: 
9743:     *-- Botao Descricao Fiscal: Click - gera descricao fiscal via fGerDescFis
9744:     PROCEDURE CmdBtnDescFisClick()
9745:         LOCAL loc_oPg, loc_cCpros, loc_cDescFis, loc_oPg1, loException
9746:         TRY
9747:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9748:                 RETURN
9749:             ENDIF
9750:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9751:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9752:             IF EMPTY(loc_cCpros)
9753:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9754:                 IF PEMSTATUS(loc_oPg1, "txt_4c_Cpros", 5)
9755:                     loc_cCpros = ALLTRIM(loc_oPg1.txt_4c_Cpros.Value)
9756:                 ENDIF
9757:             ENDIF
9758:             IF EMPTY(loc_cCpros)
9759:                 MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.")
9760:                 RETURN
9761:             ENDIF
9762:             loc_cDescFis = fGerDescFis(0, loc_cCpros, go_4c_Sistema.cCodEmpresa, .F.)
9763:             IF !EMPTY(ALLTRIM(loc_cDescFis))
9764:                 IF PEMSTATUS(loc_oPg, "obj_4c_Mgetdescfi", 5)
9765:                     loc_oPg.obj_4c_Mgetdescfi.Value = loc_cDescFis
9766:                 ENDIF
9767:                 THIS.this_oBusinessObject.this_mDescfis = loc_cDescFis
9768:             ENDIF
9769:         CATCH TO loException
9770:             MostrarErro("Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal:" + ;
9771:                 CHR(13) + loException.Message, "FormProduto.CmdBtnDescFisClick")
9772:         ENDTRY
9773:     ENDPROC
9774: 
9775:     *-- Metal (metals): Valid - lookup SigCdMtl WHERE tipos='M'
9776:     PROCEDURE ValidarMetal(par_nKeyCode, par_nShiftAltCtrl)
9777:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9778:             RETURN
9779:         ENDIF
9780:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9781:         TRY
9782:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9783:             IF !PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
9784:                 RETURN
9785:             ENDIF
9786:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
9787:             IF EMPTY(loc_cCod)
9788:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
9789:                     loc_oPg.txt_4c_DesMetal.Value = ""
9790:                 ENDIF
9791:                 RETURN
9792:             ENDIF
9793:             loc_nRet = SQLEXEC(gnConnHandle, ;
9794:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9795:                 " AND tipos = 'M'", ;
9796:                 "cursor_4c_MetalBusca")
9797:             IF loc_nRet > 0 AND USED("cursor_4c_MetalBusca") AND !EOF("cursor_4c_MetalBusca")
9798:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
9799:                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(cursor_4c_MetalBusca.descs)
9800:                 ENDIF
9801:                 IF USED("cursor_4c_MetalBusca")
9802:                     USE IN cursor_4c_MetalBusca
9803:                 ENDIF
9804:             ELSE
9805:                 IF USED("cursor_4c_MetalBusca")
9806:                     USE IN cursor_4c_MetalBusca
9807:                 ENDIF
9808:                 THIS.AbrirBuscaMetal()
9809:             ENDIF
9810:         CATCH TO loException
9811:             IF USED("cursor_4c_MetalBusca")
9812:                 USE IN cursor_4c_MetalBusca
9813:             ENDIF
9814:             MostrarErro("Erro ao validar Metal:" + CHR(13) + loException.Message, ;
9815:                 "FormProduto.ValidarMetal")
9816:         ENDTRY
9817:     ENDPROC
9818: 
9819:     PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9820:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9821:             THIS.ValidarMetal()
9822:         ENDIF
9823:     ENDPROC
9824: 
9825:     *-- Teor (teors): Valid - lookup SigCdMtl WHERE tipos<>'M'
9826:     PROCEDURE ValidarTeor(par_nKeyCode, par_nShiftAltCtrl)
9827:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9828:             RETURN
9829:         ENDIF
9830:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9831:         TRY
9832:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9833:             IF !PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
9834:                 RETURN
9835:             ENDIF
9836:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
9837:             IF EMPTY(loc_cCod)
9838:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
9839:                     loc_oPg.txt_4c_DesTeor.Value = ""
9840:                 ENDIF
9841:                 RETURN
9842:             ENDIF
9843:             loc_nRet = SQLEXEC(gnConnHandle, ;
9844:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9845:                 " AND tipos <> 'M'", ;
9846:                 "cursor_4c_TeorBusca")
9847:             IF loc_nRet > 0 AND USED("cursor_4c_TeorBusca") AND !EOF("cursor_4c_TeorBusca")
9848:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
9849:                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(cursor_4c_TeorBusca.descs)
9850:                 ENDIF
9851:                 IF USED("cursor_4c_TeorBusca")
9852:                     USE IN cursor_4c_TeorBusca
9853:                 ENDIF
9854:             ELSE
9855:                 IF USED("cursor_4c_TeorBusca")
9856:                     USE IN cursor_4c_TeorBusca
9857:                 ENDIF
9858:                 THIS.AbrirBuscaTeor()
9859:             ENDIF
9860:         CATCH TO loException
9861:             IF USED("cursor_4c_TeorBusca")
9862:                 USE IN cursor_4c_TeorBusca
9863:             ENDIF
9864:             MostrarErro("Erro ao validar Teor:" + CHR(13) + loException.Message, ;
9865:                 "FormProduto.ValidarTeor")
9866:         ENDTRY
9867:     ENDPROC
9868: 
9869:     PROCEDURE TxtTeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9870:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9871:             THIS.ValidarTeor()
9872:         ENDIF
9873:     ENDPROC
9874: 
9875:     *-- Moeda Valor (moedas): Valid - lookup SigCdMoe
9876:     PROCEDURE ValidarMvalorFiscal(par_nKeyCode, par_nShiftAltCtrl)
9877:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9878:             RETURN
9879:         ENDIF
9880:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9881:         TRY
9882:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9883:             IF !PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
9884:                 RETURN
9885:             ENDIF
9886:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
9887:             IF EMPTY(loc_cCod)
9888:                 RETURN
9889:             ENDIF
9890:             loc_nRet = SQLEXEC(gnConnHandle, ;
9891:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds = " + EscaparSQL(loc_cCod), ;
9892:                 "cursor_4c_MoeFiscalBusca")
9893:             IF loc_nRet > 0 AND USED("cursor_4c_MoeFiscalBusca") AND !EOF("cursor_4c_MoeFiscalBusca")
9894:                 IF USED("cursor_4c_MoeFiscalBusca")
9895:                     USE IN cursor_4c_MoeFiscalBusca
9896:                 ENDIF
9897:             ELSE
9898:                 IF USED("cursor_4c_MoeFiscalBusca")
9899:                     USE IN cursor_4c_MoeFiscalBusca
9900:                 ENDIF
9901:                 THIS.AbrirBuscaMvalorFiscal()
9902:             ENDIF
9903:         CATCH TO loException
9904:             IF USED("cursor_4c_MoeFiscalBusca")
9905:                 USE IN cursor_4c_MoeFiscalBusca
9906:             ENDIF
9907:             MostrarErro("Erro ao validar Moeda Valor:" + CHR(13) + loException.Message, ;
9908:                 "FormProduto.ValidarMvalorFiscal")
9909:         ENDTRY
9910:     ENDPROC
9911: 
9912:     PROCEDURE TxtMvalorFiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9913:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9914:             THIS.ValidarMvalorFiscal()
9915:         ENDIF
9916:     ENDPROC
9917: 
9918:     *-- Centro de Custo: Grupo (gruccus): Valid
9919:     PROCEDURE TxtGruccusValid()
9920:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9921:             RETURN
9922:         ENDIF
9923:         LOCAL loc_oPg, loc_cGrp, loException
9924:         TRY
9925:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9926:                 RETURN
9927:             ENDIF
9928:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9929:             IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
9930:                 RETURN
9931:             ENDIF
9932:             loc_cGrp = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
9933:             IF EMPTY(loc_cGrp)
9934:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
9935:                     loc_oPg.txt_4c__dgruccus.Value = ""
9936:                 ENDIF
9937:                 RETURN
9938:             ENDIF
9939:             fAcessoContab(Usuar, "C", loc_cGrp)
9940:         CATCH TO loException
9941:             MostrarErro("Erro ao validar Grupo CC:" + CHR(13) + loException.Message, ;
9942:                 "FormProduto.TxtGruccusValid")
9943:         ENDTRY
9944:     ENDPROC
9945: 
9946:     PROCEDURE TxtGruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9947:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9948:             THIS.TxtGruccusValid()
9949:         ENDIF
9950:     ENDPROC
9951: 
9952:     *-- Centro de Custo: Descricao Grupo (dgruccus): When
9953:     PROCEDURE TxtDgruccusWhen()
9954:         LOCAL loc_oPg
9955:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9956:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
9957:             RETURN .F.
9958:         ENDIF
9959:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9960:                EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
9961:     ENDPROC
9962: 
9963:     *-- Centro de Custo: Descricao Grupo (dgruccus): Valid
9964:     PROCEDURE TxtDgruccusValid()
9965:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9966:             RETURN
9967:         ENDIF
9968:         LOCAL loc_oPg, loc_cDesc, loException
9969:         TRY
9970:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9971:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c__dgruccus.Value)
9972:             fAcessoContab(Usuar, "D", loc_cDesc)
9973:         CATCH TO loException
9974:             MostrarErro("Erro ao buscar Descri" + CHR(231) + CHR(227) + "o Grupo CC:" + ;
9975:                 CHR(13) + loException.Message, "FormProduto.TxtDgruccusValid")
9976:         ENDTRY
9977:     ENDPROC
9978: 
9979:     PROCEDURE TxtDgruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9980:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9981:             THIS.TxtDgruccusValid()
9982:         ENDIF
9983:     ENDPROC
9984: 
9985:     *-- Centro de Custo: Conta (contaccus): When
9986:     PROCEDURE TxtContaccusWhen()
9987:         LOCAL loc_oPg
9988:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9989:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
9990:             RETURN .F.
9991:         ENDIF
9992:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9993:                !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
9994:     ENDPROC
9995: 
9996:     *-- Centro de Custo: Conta (contaccus): Valid
9997:     PROCEDURE TxtContaccusValid()
9998:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9999:             RETURN
10000:         ENDIF
10001:         LOCAL loc_oPg, loc_cGrp, loc_cCta, loException
10002:         TRY
10003:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10004:                 RETURN
10005:             ENDIF
10006:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10007:             loc_cGrp = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10008:             loc_cCta = ALLTRIM(loc_oPg.txt_4c__contaccus.Value)
10009:             IF EMPTY(loc_cCta)
10010:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10011:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10012:                 ENDIF
10013:                 RETURN
10014:             ENDIF
10015:             fAcessoContas(Usuar, loc_cGrp, "C", loc_cCta)
10016:         CATCH TO loException
10017:             MostrarErro("Erro ao validar Conta CC:" + CHR(13) + loException.Message, ;
10018:                 "FormProduto.TxtContaccusValid")
10019:         ENDTRY
10020:     ENDPROC
10021: 
10022:     PROCEDURE TxtContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10023:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10024:             THIS.TxtContaccusValid()
10025:         ENDIF
10026:     ENDPROC
10027: 
10028:     *-- Centro de Custo: Descricao Conta (dcontaccus): When
10029:     PROCEDURE TxtDcontaccusWhen()
10030:         LOCAL loc_oPg
10031:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10032:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10033:             RETURN .F.
10034:         ENDIF
10035:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
10036:                !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value)) AND ;
10037:                EMPTY(ALLTRIM(loc_oPg.txt_4c__contaccus.Value))
10038:     ENDPROC
10039: 
10040:     *-- Centro de Custo: Descricao Conta (dcontaccus): Valid
10041:     PROCEDURE TxtDcontaccusValid()
10042:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10043:             RETURN
10044:         ENDIF
10045:         LOCAL loc_oPg, loc_cGrp, loc_cDesc, loException
10046:         TRY
10047:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10048:             loc_cGrp  = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10049:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c__dcontaccus.Value)
10050:             fAcessoContas(Usuar, loc_cGrp, "D", loc_cDesc)
10051:         CATCH TO loException
10052:             MostrarErro("Erro ao buscar Descri" + CHR(231) + CHR(227) + "o Conta CC:" + ;
10053:                 CHR(13) + loException.Message, "FormProduto.TxtDcontaccusValid")
10054:         ENDTRY
10055:     ENDPROC
10056: 
10057:     PROCEDURE TxtDcontaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10058:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10059:             THIS.TxtDcontaccusValid()
10060:         ENDIF
10061:     ENDPROC
10062: 
10063:     *===========================================================================
10064:     * AbrirBusca* - Helpers de lookup para pgDadosFiscais (Page3)
10065:     *===========================================================================
10066: 
10067:     *-- Classificacao Fiscal (SigCdClf: codigos/descricaos)
10068:     PROCEDURE AbrirBuscaClfiscal()
10069:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10070:         TRY
10071:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10072:             loc_cValAtual = ""
10073:             IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10074:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
10075:             ENDIF
10076:             loc_nRet = SQLEXEC(gnConnHandle, ;
10077:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos LIKE " + ;
10078:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10079:                 "cursor_4c_ClfBusca")
10080:             IF loc_nRet <= 0 OR !USED("cursor_4c_ClfBusca") OR EOF("cursor_4c_ClfBusca")
10081:                 IF USED("cursor_4c_ClfBusca")
10082:                     USE IN cursor_4c_ClfBusca
10083:                 ENDIF
10084:                 SQLEXEC(gnConnHandle, ;
10085:                     "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", ;
10086:                     "cursor_4c_ClfBusca")
10087:             ENDIF
10088:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10089:             IF VARTYPE(loc_oBusca) = "O"
10090:                 loc_oBusca.DefinirCursor("cursor_4c_ClfBusca", "codigos", "descricaos", ;
10091:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10092:                 loc_oBusca.Mostrar()
10093:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10094:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10095:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10096:                     ENDIF
10097:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
10098:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10099:                     ENDIF
10100:                 ENDIF
10101:                 loc_oBusca = .NULL.
10102:             ENDIF
10103:             IF USED("cursor_4c_ClfBusca")
10104:                 USE IN cursor_4c_ClfBusca
10105:             ENDIF
10106:         CATCH TO loException
10107:             IF USED("cursor_4c_ClfBusca")
10108:                 USE IN cursor_4c_ClfBusca
10109:             ENDIF
10110:             MostrarErro("Erro ao buscar Classif. Fiscal:" + CHR(13) + loException.Message, ;
10111:                 "FormProduto.AbrirBuscaClfiscal")
10112:         ENDTRY
10113:     ENDPROC
10114: 
10115:     *-- Origem Mercadoria (SIGCDORG: codigos/descricaos)
10116:     PROCEDURE AbrirBuscaOrigmerc()
10117:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10118:         TRY
10119:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10120:             loc_cValAtual = ""
10121:             IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10122:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
10123:             ENDIF
10124:             loc_nRet = SQLEXEC(gnConnHandle, ;
10125:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos LIKE " + ;
10126:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10127:                 "cursor_4c_OrgBusca")
10128:             IF loc_nRet <= 0 OR !USED("cursor_4c_OrgBusca") OR EOF("cursor_4c_OrgBusca")
10129:                 IF USED("cursor_4c_OrgBusca")
10130:                     USE IN cursor_4c_OrgBusca
10131:                 ENDIF
10132:                 SQLEXEC(gnConnHandle, ;
10133:                     "SELECT codigos, descricaos FROM SIGCDORG ORDER BY codigos", ;
10134:                     "cursor_4c_OrgBusca")
10135:             ENDIF
10136:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10137:             IF VARTYPE(loc_oBusca) = "O"
10138:                 loc_oBusca.DefinirCursor("cursor_4c_OrgBusca", "codigos", "descricaos", ;
10139:                     "Buscar Origem Mercadoria")
10140:                 loc_oBusca.Mostrar()
10141:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10142:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10143:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10144:                     ENDIF
10145:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
10146:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10147:                     ENDIF
10148:                 ENDIF
10149:                 loc_oBusca = .NULL.
10150:             ENDIF
10151:             IF USED("cursor_4c_OrgBusca")
10152:                 USE IN cursor_4c_OrgBusca
10153:             ENDIF
10154:         CATCH TO loException
10155:             IF USED("cursor_4c_OrgBusca")
10156:                 USE IN cursor_4c_OrgBusca
10157:             ENDIF
10158:             MostrarErro("Erro ao buscar Origem Mercadoria:" + CHR(13) + loException.Message, ;
10159:                 "FormProduto.AbrirBuscaOrigmerc")
10160:         ENDTRY
10161:     ENDPROC
10162: 
10163:     *-- Situacao Tributaria ICMS (SIGCDICM: codigos/descricaos)
10164:     PROCEDURE AbrirBuscaSittricm()
10165:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10166:         TRY
10167:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10168:             loc_cValAtual = ""
10169:             IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10170:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
10171:             ENDIF
10172:             loc_nRet = SQLEXEC(gnConnHandle, ;
10173:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10174:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10175:                 "cursor_4c_IcmBusca")
10176:             IF loc_nRet <= 0 OR !USED("cursor_4c_IcmBusca") OR EOF("cursor_4c_IcmBusca")
10177:                 IF USED("cursor_4c_IcmBusca")
10178:                     USE IN cursor_4c_IcmBusca
10179:                 ENDIF
10180:                 SQLEXEC(gnConnHandle, ;
10181:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10182:                     "cursor_4c_IcmBusca")
10183:             ENDIF
10184:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10185:             IF VARTYPE(loc_oBusca) = "O"
10186:                 loc_oBusca.DefinirCursor("cursor_4c_IcmBusca", "codigos", "descricaos", ;
10187:                     "Buscar Sit. Tributaria ICMS")
10188:                 loc_oBusca.Mostrar()
10189:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10190:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10191:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10192:                     ENDIF
10193:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
10194:                         loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10195:                     ENDIF
10196:                 ENDIF
10197:                 loc_oBusca = .NULL.
10198:             ENDIF
10199:             IF USED("cursor_4c_IcmBusca")
10200:                 USE IN cursor_4c_IcmBusca
10201:             ENDIF
10202:         CATCH TO loException
10203:             IF USED("cursor_4c_IcmBusca")
10204:                 USE IN cursor_4c_IcmBusca
10205:             ENDIF
10206:             MostrarErro("Erro ao buscar Sit. Tributaria ICMS:" + CHR(13) + loException.Message, ;
10207:                 "FormProduto.AbrirBuscaSittricm")
10208:         ENDTRY
10209:     ENDPROC
10210: 
10211:     *-- Codigo Servico Fiscal (SIGCDICM: codigos/descricaos)
10212:     PROCEDURE AbrirBuscaCodServsFiscal()
10213:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10214:         TRY
10215:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10216:             loc_cValAtual = ""
10217:             IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10218:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
10219:             ENDIF
10220:             loc_nRet = SQLEXEC(gnConnHandle, ;
10221:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10222:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10223:                 "cursor_4c_CodServBusca")
10224:             IF loc_nRet <= 0 OR !USED("cursor_4c_CodServBusca") OR EOF("cursor_4c_CodServBusca")
10225:                 IF USED("cursor_4c_CodServBusca")
10226:                     USE IN cursor_4c_CodServBusca
10227:                 ENDIF
10228:                 SQLEXEC(gnConnHandle, ;
10229:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10230:                     "cursor_4c_CodServBusca")
10231:             ENDIF
10232:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10233:             IF VARTYPE(loc_oBusca) = "O"
10234:                 loc_oBusca.DefinirCursor("cursor_4c_CodServBusca", "codigos", "descricaos", ;
10235:                     "Buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal")
10236:                 loc_oBusca.Mostrar()
10237:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10238:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10239:                         loc_oPg.txt_4c_Codigo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10240:                     ENDIF
10241:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10242:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10243:                     ENDIF
10244:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
10245:                         loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10246:                     ENDIF
10247:                 ENDIF
10248:                 loc_oBusca = .NULL.
10249:             ENDIF
10250:             IF USED("cursor_4c_CodServBusca")
10251:                 USE IN cursor_4c_CodServBusca
10252:             ENDIF
10253:         CATCH TO loException
10254:             IF USED("cursor_4c_CodServBusca")
10255:                 USE IN cursor_4c_CodServBusca
10256:             ENDIF
10257:             MostrarErro("Erro ao buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal:" + ;
10258:                 CHR(13) + loException.Message, "FormProduto.AbrirBuscaCodServsFiscal")
10259:         ENDTRY
10260:     ENDPROC
10261: 
10262:     *-- Tipo Tributacao (SigPrTri: tipos/descs)
10263:     PROCEDURE AbrirBuscaTpTrib()
10264:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10265:         TRY
10266:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10267:             loc_cValAtual = ""
10268:             IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10269:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
10270:             ENDIF
10271:             loc_nRet = SQLEXEC(gnConnHandle, ;
10272:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos LIKE " + ;
10273:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY tipos", ;
10274:                 "cursor_4c_TpTribBusca")
10275:             IF loc_nRet <= 0 OR !USED("cursor_4c_TpTribBusca") OR EOF("cursor_4c_TpTribBusca")
10276:                 IF USED("cursor_4c_TpTribBusca")
10277:                     USE IN cursor_4c_TpTribBusca
10278:                 ENDIF
10279:                 SQLEXEC(gnConnHandle, ;
10280:                     "SELECT tipos, descs FROM SigPrTri ORDER BY tipos", ;
10281:                     "cursor_4c_TpTribBusca")
10282:             ENDIF
10283:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10284:             IF VARTYPE(loc_oBusca) = "O"
10285:                 loc_oBusca.DefinirCursor("cursor_4c_TpTribBusca", "tipos", "descs", ;
10286:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10287:                 loc_oBusca.Mostrar()
10288:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10289:                     IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10290:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10291:                     ENDIF
10292:                 ENDIF
10293:                 loc_oBusca = .NULL.
10294:             ENDIF
10295:             IF USED("cursor_4c_TpTribBusca")
10296:                 USE IN cursor_4c_TpTribBusca
10297:             ENDIF
10298:         CATCH TO loException
10299:             IF USED("cursor_4c_TpTribBusca")
10300:                 USE IN cursor_4c_TpTribBusca
10301:             ENDIF
10302:             MostrarErro("Erro ao buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o:" + ;
10303:                 CHR(13) + loException.Message, "FormProduto.AbrirBuscaTpTrib")
10304:         ENDTRY
10305:     ENDPROC
10306: 
10307:     *-- Metal (SigCdMtl: codigos/descs WHERE tipos='M')
10308:     PROCEDURE AbrirBuscaMetal()
10309:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10310:         TRY
10311:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10312:             loc_cValAtual = ""
10313:             IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10314:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
10315:             ENDIF
10316:             loc_nRet = SQLEXEC(gnConnHandle, ;
10317:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10318:                 "WHERE tipos = 'M' AND codigos LIKE " + ;
10319:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10320:                 "cursor_4c_MetalBusca")
10321:             IF loc_nRet <= 0 OR !USED("cursor_4c_MetalBusca") OR EOF("cursor_4c_MetalBusca")
10322:                 IF USED("cursor_4c_MetalBusca")
10323:                     USE IN cursor_4c_MetalBusca
10324:                 ENDIF
10325:                 SQLEXEC(gnConnHandle, ;
10326:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos = 'M' ORDER BY codigos", ;
10327:                     "cursor_4c_MetalBusca")
10328:             ENDIF
10329:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10330:             IF VARTYPE(loc_oBusca) = "O"
10331:                 loc_oBusca.DefinirCursor("cursor_4c_MetalBusca", "codigos", "descs", "Buscar Metal")
10332:                 loc_oBusca.Mostrar()
10333:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10334:                     IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10335:                         loc_oPg.txt_4c_Metal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10336:                     ENDIF
10337:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
10338:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10339:                     ENDIF
10340:                 ENDIF
10341:                 loc_oBusca = .NULL.
10342:             ENDIF
10343:             IF USED("cursor_4c_MetalBusca")
10344:                 USE IN cursor_4c_MetalBusca
10345:             ENDIF
10346:         CATCH TO loException
10347:             IF USED("cursor_4c_MetalBusca")
10348:                 USE IN cursor_4c_MetalBusca
10349:             ENDIF
10350:             MostrarErro("Erro ao buscar Metal:" + CHR(13) + loException.Message, ;
10351:                 "FormProduto.AbrirBuscaMetal")
10352:         ENDTRY
10353:     ENDPROC
10354: 
10355:     *-- Teor (SigCdMtl: codigos/descs WHERE tipos<>'M')
10356:     PROCEDURE AbrirBuscaTeor()
10357:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10358:         TRY
10359:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10360:             loc_cValAtual = ""
10361:             IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10362:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
10363:             ENDIF
10364:             loc_nRet = SQLEXEC(gnConnHandle, ;
10365:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10366:                 "WHERE tipos <> 'M' AND codigos LIKE " + ;
10367:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10368:                 "cursor_4c_TeorBusca")
10369:             IF loc_nRet <= 0 OR !USED("cursor_4c_TeorBusca") OR EOF("cursor_4c_TeorBusca")
10370:                 IF USED("cursor_4c_TeorBusca")
10371:                     USE IN cursor_4c_TeorBusca
10372:                 ENDIF
10373:                 SQLEXEC(gnConnHandle, ;
10374:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos <> 'M' ORDER BY codigos", ;
10375:                     "cursor_4c_TeorBusca")
10376:             ENDIF
10377:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10378:             IF VARTYPE(loc_oBusca) = "O"
10379:                 loc_oBusca.DefinirCursor("cursor_4c_TeorBusca", "codigos", "descs", "Buscar Teor")
10380:                 loc_oBusca.Mostrar()
10381:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10382:                     IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10383:                         loc_oPg.txt_4c_Teor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10384:                     ENDIF
10385:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
10386:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10387:                     ENDIF
10388:                 ENDIF
10389:                 loc_oBusca = .NULL.
10390:             ENDIF
10391:             IF USED("cursor_4c_TeorBusca")
10392:                 USE IN cursor_4c_TeorBusca
10393:             ENDIF
10394:         CATCH TO loException
10395:             IF USED("cursor_4c_TeorBusca")
10396:                 USE IN cursor_4c_TeorBusca
10397:             ENDIF
10398:             MostrarErro("Erro ao buscar Teor:" + CHR(13) + loException.Message, ;
10399:                 "FormProduto.AbrirBuscaTeor")
10400:         ENDTRY
10401:     ENDPROC
10402: 
10403:     *-- Moeda Valor (SigCdMoe: cmoeds/dmoeds)
10404:     PROCEDURE AbrirBuscaMvalorFiscal()
10405:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10406:         TRY
10407:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10408:             loc_cValAtual = ""
10409:             IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10410:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
10411:             ENDIF
10412:             loc_nRet = SQLEXEC(gnConnHandle, ;
10413:                 "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds LIKE " + ;
10414:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY cmoeds", ;
10415:                 "cursor_4c_MoeFiscalBusca")
10416:             IF loc_nRet <= 0 OR !USED("cursor_4c_MoeFiscalBusca") OR EOF("cursor_4c_MoeFiscalBusca")
10417:                 IF USED("cursor_4c_MoeFiscalBusca")
10418:                     USE IN cursor_4c_MoeFiscalBusca
10419:                 ENDIF
10420:                 SQLEXEC(gnConnHandle, ;
10421:                     "SELECT cmoeds, dmoeds FROM SigCdMoe ORDER BY cmoeds", ;
10422:                     "cursor_4c_MoeFiscalBusca")
10423:             ENDIF
10424:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10425:             IF VARTYPE(loc_oBusca) = "O"
10426:                 loc_oBusca.DefinirCursor("cursor_4c_MoeFiscalBusca", "cmoeds", "dmoeds", ;
10427:                     "Buscar Moeda")
10428:                 loc_oBusca.Mostrar()
10429:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10430:                     IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10431:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10432:                     ENDIF
10433:                 ENDIF
10434:                 loc_oBusca = .NULL.
10435:             ENDIF
10436:             IF USED("cursor_4c_MoeFiscalBusca")
10437:                 USE IN cursor_4c_MoeFiscalBusca
10438:             ENDIF
10439:         CATCH TO loException
10440:             IF USED("cursor_4c_MoeFiscalBusca")
10441:                 USE IN cursor_4c_MoeFiscalBusca
10442:             ENDIF
10443:             MostrarErro("Erro ao buscar Moeda:" + CHR(13) + loException.Message, ;
10444:                 "FormProduto.AbrirBuscaMvalorFiscal")
10445:         ENDTRY
10446:     ENDPROC
10447: 
10448:     *===========================================================================
10449:     * ConfigurarPgpgDesigner - Configura Page7 "Designer" do pgf_4c_Dados
10450:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner
10451:     *===========================================================================
10452:     PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPg)
10453:         LOCAL loc_oPg, loc_oGrid, loc_oErro
10454:         TRY
10455:             loc_oPg = par_oPg
10456: 
10457:             *-- Cursors placeholder (preenchidos pelo BO ao carregar produto)
10458:             IF !USED("cursor_4c_GrdDesigner")
10459:                 CREATE CURSOR cursor_4c_GrdDesigner ( ;
10460:                     dtini D, dtfim D, usuarios C(10), codcads C(10))
10461:             ENDIF
10462:             IF !USED("cursor_4c_GrdArquivos")
10463:                 CREATE CURSOR cursor_4c_GrdArquivos (arqnome C(200))
10464:             ENDIF
10465:             IF !USED("crTarefas")
10466:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10467:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
10468:                     SQLEXEC(gnConnHandle, ;
10469:                         "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10470:                         "FROM SigCdCad ORDER BY codcads", ;
10471:                         "crTarefas")
10472:                 ENDIF
10473:             ENDIF
10474: 
10475:             *-- grdDesigner: grade historico de designer (4 colunas)
10476:             *-- Original: top=145, left=10, width=495, height=180
10477:             loc_oPg.AddObject("grd_4c_GrdDesigner", "Grid")
10478:             WITH loc_oPg.grd_4c_GrdDesigner
10479:                 .Top        = 145
10480:                 .Left       = 10
10481:                 .Width      = 495
10482:                 .Height     = 180
10483:                 .FontName   = "Tahoma"
10484:                 .FontSize   = 8
10485:                 .RecordMark = .F.
10486:                 .RowHeight  = 16
10487:                 .ScrollBars = 2
10488:                 .TabStop    = .F.
10489:                 .Visible    = .T.
10490:             ENDWITH
10491:             loc_oPg.grd_4c_GrdDesigner.ColumnCount  = 4
10492:             loc_oPg.grd_4c_GrdDesigner.RecordSource = "cursor_4c_GrdDesigner"
10493:             loc_oGrid = loc_oPg.grd_4c_GrdDesigner
10494: 
10495:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdDesigner.dtini"
10496:             loc_oGrid.Column1.Width           = 100
10497:             loc_oGrid.Column1.ColumnOrder     = 1
10498:             loc_oGrid.Column1.Movable         = .F.
10499:             loc_oGrid.Column1.Resizable       = .F.
10500:             loc_oGrid.Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
10501: 
10502:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdDesigner.dtfim"
10503:             loc_oGrid.Column2.Width           = 100
10504:             loc_oGrid.Column2.ColumnOrder     = 2
10505:             loc_oGrid.Column2.Movable         = .F.
10506:             loc_oGrid.Column2.Resizable       = .F.
10507:             loc_oGrid.Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
10508: 
10509:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdDesigner.usuarios"
10510:             loc_oGrid.Column3.Width           = 100
10511:             loc_oGrid.Column3.ColumnOrder     = 3
10512:             loc_oGrid.Column3.Movable         = .F.
10513:             loc_oGrid.Column3.Resizable       = .F.
10514:             loc_oGrid.Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
10515: 
10516:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GrdDesigner.codcads"
10517:             loc_oGrid.Column4.Width           = 193
10518:             loc_oGrid.Column4.ColumnOrder     = 4
10519:             loc_oGrid.Column4.Movable         = .F.
10520:             loc_oGrid.Column4.Resizable       = .F.
10521:             loc_oGrid.Column4.Header1.Caption = "Tarefa"
10522:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdDesignerCol4TarefaValid")
10523: 
10524:             *-- Say31: label "Observacao da Tarefa"
10525:             *-- Original: top=129, left=583, width=126, height=15
10526:             loc_oPg.AddObject("lbl_4c_Label31", "Label")
10527:             WITH loc_oPg.lbl_4c_Label31
10528:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
10529:                 .Top       = 129
10530:                 .Left      = 583
10531:                 .Width     = 126
10532:                 .Height    = 15
10533:                 .FontName  = "Tahoma"
10534:                 .FontSize  = 8
10535:                 .BackStyle = 0
10536:                 .ForeColor = RGB(90, 90, 90)
10537:                 .Visible   = .T.
10538:             ENDWITH
10539: 
10540:             *-- getObsTarefas: editbox (fwmemo) observacao da tarefa
10541:             *-- Original: top=145, left=584, width=407, height=113
10542:             loc_oPg.AddObject("obj_4c_GetObsTarefas", "EditBox")
10543:             WITH loc_oPg.obj_4c_GetObsTarefas
10544:                 .Top        = 145
10545:                 .Left       = 584
10546:                 .Width      = 407
10547:                 .Height     = 113
10548:                 .FontName   = "Tahoma"
10549:                 .FontSize   = 8
10550:                 .ScrollBars = 2
10551:                 .ReadOnly   = .F.
10552:                 .Visible    = .T.
10553:             ENDWITH
10554: 
10555:             *-- btnIniTarefa: botao Inicio de Tarefa
10556:             *-- Original: top=146, left=509, width=42, height=42
10557:             loc_oPg.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
10558:             WITH loc_oPg.cmd_4c_BtnIniTarefa
10559:                 .Caption       = "IN"
10560:                 .Top           = 146
10561:                 .Left          = 509
10562:                 .Width         = 42

*-- Linhas 10570 a 10659:
10570:                 .MousePointer  = 15
10571:                 .Visible       = .T.
10572:             ENDWITH
10573:             BINDEVENT(loc_oPg.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
10574: 
10575:             *-- btnFimTarefa: botao Fim de Tarefa
10576:             *-- Original: top=188, left=509, width=42, height=42
10577:             loc_oPg.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
10578:             WITH loc_oPg.cmd_4c_BtnFimTarefa
10579:                 .Caption       = "FI"
10580:                 .Top           = 188
10581:                 .Left          = 509
10582:                 .Width         = 42
10583:                 .Height        = 42
10584:                 .FontName      = "Tahoma"
10585:                 .FontSize      = 8
10586:                 .FontBold      = .T.
10587:                 .BackColor     = RGB(255, 255, 255)
10588:                 .Themes        = .F.
10589:                 .SpecialEffect = 0
10590:                 .MousePointer  = 15
10591:                 .Visible       = .T.
10592:             ENDWITH
10593:             BINDEVENT(loc_oPg.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
10594: 
10595:             *-- Say1: label "Inspiracao"
10596:             *-- Original: top=265, left=583, width=62, height=15
10597:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
10598:             WITH loc_oPg.lbl_4c_Label1
10599:                 .Caption   = "Inspira" + CHR(231) + CHR(227) + "o"
10600:                 .Top       = 265
10601:                 .Left      = 583
10602:                 .Width     = 62
10603:                 .Height    = 15
10604:                 .FontName  = "Tahoma"
10605:                 .FontSize  = 8
10606:                 .BackStyle = 0
10607:                 .ForeColor = RGB(90, 90, 90)
10608:                 .Visible   = .T.
10609:             ENDWITH
10610: 
10611:             *-- getObsInsp: editbox (fwmemo) observacao de inspiracao
10612:             *-- Original: top=281, left=584, width=407, height=113
10613:             loc_oPg.AddObject("obj_4c_GetObsInsp", "EditBox")
10614:             WITH loc_oPg.obj_4c_GetObsInsp
10615:                 .Top        = 281
10616:                 .Left       = 584
10617:                 .Width      = 407
10618:                 .Height     = 113
10619:                 .FontName   = "Tahoma"
10620:                 .FontSize   = 8
10621:                 .ScrollBars = 2
10622:                 .ReadOnly   = .F.
10623:                 .Visible    = .T.
10624:             ENDWITH
10625: 
10626:             *-- grdArquivos: grade de arquivos do designer (1 coluna)
10627:             *-- Original: top=334, left=10, width=495, height=164
10628:             loc_oPg.AddObject("grd_4c_GrdArquivos", "Grid")
10629:             WITH loc_oPg.grd_4c_GrdArquivos
10630:                 .Top        = 334
10631:                 .Left       = 10
10632:                 .Width      = 495
10633:                 .Height     = 164
10634:                 .FontName   = "Tahoma"
10635:                 .FontSize   = 8
10636:                 .RecordMark = .F.
10637:                 .RowHeight  = 16
10638:                 .ScrollBars = 2
10639:                 .TabStop    = .F.
10640:                 .Visible    = .T.
10641:             ENDWITH
10642:             loc_oPg.grd_4c_GrdArquivos.ColumnCount  = 1
10643:             loc_oPg.grd_4c_GrdArquivos.RecordSource = "cursor_4c_GrdArquivos"
10644:             loc_oPg.grd_4c_GrdArquivos.Column1.ControlSource   = "cursor_4c_GrdArquivos.arqnome"
10645:             loc_oPg.grd_4c_GrdArquivos.Column1.Width           = 493
10646:             loc_oPg.grd_4c_GrdArquivos.Column1.ColumnOrder     = 1
10647:             loc_oPg.grd_4c_GrdArquivos.Column1.Movable         = .F.
10648:             loc_oPg.grd_4c_GrdArquivos.Column1.Resizable       = .F.
10649:             loc_oPg.grd_4c_GrdArquivos.Column1.Header1.Caption = "Arquivos Para Designer"
10650: 
10651:             *-- btnInsArqs: botao Inserir Arquivo
10652:             *-- Original: top=335, left=509, width=42, height=42
10653:             loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
10654:             WITH loc_oPg.cmd_4c_BtnInsArqs
10655:                 .Caption       = "+"
10656:                 .Top           = 335
10657:                 .Left          = 509
10658:                 .Width         = 42
10659:                 .Height        = 42

*-- Linhas 10666 a 10749:
10666:                 .MousePointer  = 15
10667:                 .Visible       = .T.
10668:             ENDWITH
10669:             BINDEVENT(loc_oPg.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
10670: 
10671:             *-- btnExcArqs: botao Excluir Arquivo selecionado
10672:             *-- Original: top=377, left=509, width=42, height=42
10673:             loc_oPg.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
10674:             WITH loc_oPg.cmd_4c_BtnExcArqs
10675:                 .Caption       = "-"
10676:                 .Top           = 377
10677:                 .Left          = 509
10678:                 .Width         = 42
10679:                 .Height        = 42
10680:                 .FontName      = "Tahoma"
10681:                 .FontSize      = 12
10682:                 .FontBold      = .T.
10683:                 .BackColor     = RGB(255, 255, 255)
10684:                 .Themes        = .F.
10685:                 .SpecialEffect = 0
10686:                 .MousePointer  = 15
10687:                 .Visible       = .T.
10688:             ENDWITH
10689:             BINDEVENT(loc_oPg.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
10690: 
10691:             *-- btnOpnArqs: botao Abrir Arquivo selecionado
10692:             *-- Original: top=419, left=509, width=42, height=42
10693:             loc_oPg.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
10694:             WITH loc_oPg.cmd_4c_BtnOpnArqs
10695:                 .Caption       = "AB"
10696:                 .Top           = 419
10697:                 .Left          = 509
10698:                 .Width         = 42
10699:                 .Height        = 42
10700:                 .FontName      = "Tahoma"
10701:                 .FontSize      = 8
10702:                 .FontBold      = .T.
10703:                 .BackColor     = RGB(255, 255, 255)
10704:                 .Themes        = .F.
10705:                 .SpecialEffect = 0
10706:                 .MousePointer  = 15
10707:                 .Visible       = .T.
10708:             ENDWITH
10709:             BINDEVENT(loc_oPg.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
10710: 
10711:             *-- Shape1: retangulo decorativo sobre area de imagem
10712:             *-- Original: top=400, left=584, width=407, height=202
10713:             loc_oPg.AddObject("shp_4c_Shape1", "Shape")
10714:             WITH loc_oPg.shp_4c_Shape1
10715:                 .Top     = 400
10716:                 .Left    = 584
10717:                 .Width   = 407
10718:                 .Height  = 202
10719:                 .Visible = .T.
10720:             ENDWITH
10721: 
10722:             *-- imgArqJpg: imagem do arquivo selecionado (inicialmente oculta)
10723:             *-- Original: top=402, left=586, width=403, height=198, visible=false
10724:             loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
10725:             WITH loc_oPg.img_4c_ImgArqJpg
10726:                 .Top     = 402
10727:                 .Left    = 586
10728:                 .Width   = 403
10729:                 .Height  = 198
10730:                 .Visible = .F.
10731:             ENDWITH
10732: 
10733:             *-- Say19: label secao "Dados do Lancamento"
10734:             *-- Original: top=504, left=18, width=127, height=15
10735:             loc_oPg.AddObject("lbl_4c_Label19", "Label")
10736:             WITH loc_oPg.lbl_4c_Label19
10737:                 .Caption   = "Dados do Lan" + CHR(231) + "amento"
10738:                 .Top       = 504
10739:                 .Left      = 18
10740:                 .Width     = 127
10741:                 .Height    = 15
10742:                 .FontName  = "Tahoma"
10743:                 .FontSize  = 8
10744:                 .FontBold  = .T.
10745:                 .BackStyle = 0
10746:                 .ForeColor = RGB(90, 90, 90)
10747:                 .Visible   = .T.
10748:             ENDWITH
10749: 

*-- Linhas 10821 a 11438:
10821:                 .SpecialEffect = 1
10822:                 .Visible       = .T.
10823:             ENDWITH
10824:             BINDEVENT(loc_oPg.txt_4c_DesLacto, "KeyPress", THIS, "ValidarDesLacto")
10825: 
10826:             *-- Say5: label "Criado por :"
10827:             *-- Original: top=580, left=56, width=59, height=15
10828:             loc_oPg.AddObject("lbl_4c_Label5", "Label")
10829:             WITH loc_oPg.lbl_4c_Label5
10830:                 .Caption   = "Criado por :"
10831:                 .Top       = 580
10832:                 .Left      = 56
10833:                 .Width     = 59
10834:                 .Height    = 15
10835:                 .FontName  = "Tahoma"
10836:                 .FontSize  = 8
10837:                 .BackStyle = 0
10838:                 .ForeColor = RGB(90, 90, 90)
10839:                 .Visible   = .T.
10840:             ENDWITH
10841: 
10842:             *-- GetCriaLacto: textbox usuario criador (fwget -> SigCdUsu.usuarios)
10843:             *-- Original: top=576, left=118, width=91, height=22
10844:             loc_oPg.AddObject("txt_4c_CriaLacto", "TextBox")
10845:             WITH loc_oPg.txt_4c_CriaLacto
10846:                 .Top           = 576
10847:                 .Left          = 118
10848:                 .Width         = 91
10849:                 .Height        = 22
10850:                 .FontName      = "Tahoma"
10851:                 .FontSize      = 8
10852:                 .Value         = ""
10853:                 .MaxLength     = 10
10854:                 .SpecialEffect = 1
10855:                 .Visible       = .T.
10856:             ENDWITH
10857:             BINDEVENT(loc_oPg.txt_4c_CriaLacto, "KeyPress", THIS, "ValidarCriaLacto")
10858: 
10859:         CATCH TO loc_oErro
10860:             MostrarErro("Erro ao configurar pgDesigner:" + CHR(13) + ;
10861:                 loc_oErro.Message + CHR(13) + ;
10862:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
10863:                 "FormProduto.ConfigurarPgpgDesigner")
10864:         ENDTRY
10865:     ENDPROC
10866: 
10867:     *===========================================================================
10868:     * Handlers de BINDEVENT para pgDesigner (Page7)
10869:     * Todos PUBLIC - requerido pelo BINDEVENT
10870:     *===========================================================================
10871: 
10872:     *-- grdDesigner Column4 (Tarefa/CodCads): Valid - lookup crTarefas por CodCads
10873:     PROCEDURE GrdDesignerCol4TarefaValid()
10874:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10875:             RETURN .T.
10876:         ENDIF
10877:         LOCAL loc_cCodCads, loc_lSucesso, loException
10878:         loc_lSucesso = .T.
10879:         TRY
10880:             IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
10881:                 loc_cCodCads = ALLTRIM(cursor_4c_GrdDesigner.codcads)
10882:                 IF !EMPTY(loc_cCodCads)
10883:                     IF USED("crTarefas")
10884:                         SELECT crTarefas
10885:                         GO TOP
10886:                         LOCATE FOR ALLTRIM(CodCads) = loc_cCodCads
10887:                         IF EOF("crTarefas")
10888:                             THIS.AbrirBuscaTarefaDesigner()
10889:                         ENDIF
10890:                         IF USED("cursor_4c_GrdDesigner")
10891:                             SELECT cursor_4c_GrdDesigner
10892:                         ENDIF
10893:                     ELSE
10894:                         THIS.AbrirBuscaTarefaDesigner()
10895:                     ENDIF
10896:                 ENDIF
10897:             ENDIF
10898:         CATCH TO loException
10899:             MostrarErro("Erro ao validar Tarefa:" + CHR(13) + loException.Message, ;
10900:                 "FormProduto.GrdDesignerCol4TarefaValid")
10901:         ENDTRY
10902:         RETURN loc_lSucesso
10903:     ENDPROC
10904: 
10905:     PROCEDURE AbrirBuscaTarefaDesigner()
10906:         LOCAL loc_oBusca, loc_nRet, loException
10907:         TRY
10908:             IF !USED("crTarefas")
10909:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10910:                 loc_nRet = SQLEXEC(gnConnHandle, ;
10911:                     "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10912:                     "FROM SigCdCad ORDER BY codcads", ;
10913:                     "crTarefas")
10914:                 IF loc_nRet <= 0 OR EOF("crTarefas")
10915:                     MsgAviso("Sem tarefas cadastradas para selecionar.")
10916:                     RETURN
10917:                 ENDIF
10918:             ENDIF
10919:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10920:             IF VARTYPE(loc_oBusca) = "O"
10921:                 loc_oBusca.DefinirCursor("crTarefas", "CodCads", "DesCads", ;
10922:                     "Selecionar Tarefa")
10923:                 loc_oBusca.Mostrar()
10924:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND ;
10925:                     USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
10926:                     SELECT cursor_4c_GrdDesigner
10927:                     REPLACE cursor_4c_GrdDesigner.codcads WITH ;
10928:                         ALLTRIM(loc_oBusca.cCodigoSelecionado)
10929:                 ENDIF
10930:                 loc_oBusca = .NULL.
10931:             ENDIF
10932:         CATCH TO loException
10933:             MostrarErro("Erro ao buscar Tarefa:" + CHR(13) + loException.Message, ;
10934:                 "FormProduto.AbrirBuscaTarefaDesigner")
10935:         ENDTRY
10936:     ENDPROC
10937: 
10938:     *-- GetDesLacto (txt_4c_DesLacto): Valid - valida usuario desenvolvedor em SigCdUsu
10939:     PROCEDURE ValidarDesLacto(par_nKeyCode, par_nShiftAltCtrl)
10940:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10941:             RETURN
10942:         ENDIF
10943:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
10944:         TRY
10945:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
10946:             loc_cCod = ""
10947:             IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
10948:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
10949:             ENDIF
10950:             IF !EMPTY(loc_cCod)
10951:                 loc_nRet = SQLEXEC(gnConnHandle, ;
10952:                     "SELECT usuarios FROM SigCdUsu " + ;
10953:                     "WHERE usuarios = " + EscaparSQL(loc_cCod) + " AND cativos <> 'N'", ;
10954:                     "cursor_4c_DesLactoBusca")
10955:                 IF loc_nRet > 0 AND USED("cursor_4c_DesLactoBusca") AND !EOF("cursor_4c_DesLactoBusca")
10956:                     IF USED("cursor_4c_DesLactoBusca")
10957:                         USE IN cursor_4c_DesLactoBusca
10958:                     ENDIF
10959:                 ELSE
10960:                     IF USED("cursor_4c_DesLactoBusca")
10961:                         USE IN cursor_4c_DesLactoBusca
10962:                     ENDIF
10963:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
10964:                         loc_oPg.txt_4c_DesLacto.Value = ""
10965:                     ENDIF
10966:                     THIS.AbrirBuscaDesLacto()
10967:                 ENDIF
10968:             ENDIF
10969:         CATCH TO loException
10970:             IF USED("cursor_4c_DesLactoBusca")
10971:                 USE IN cursor_4c_DesLactoBusca
10972:             ENDIF
10973:             MostrarErro("Erro ao validar Desenvolvedor:" + CHR(13) + loException.Message, ;
10974:                 "FormProduto.ValidarDesLacto")
10975:         ENDTRY
10976:     ENDPROC
10977: 
10978:     PROCEDURE AbrirBuscaDesLacto()
10979:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10980:         TRY
10981:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
10982:             loc_cValAtual = ""
10983:             IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
10984:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
10985:             ENDIF
10986:             loc_nRet = SQLEXEC(gnConnHandle, ;
10987:                 "SELECT usuarios, ncomps FROM SigCdUsu " + ;
10988:                 "WHERE cativos <> 'N' AND usuarios LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
10989:                 " ORDER BY usuarios", ;
10990:                 "cursor_4c_DesLactoBusca")
10991:             IF loc_nRet <= 0 OR !USED("cursor_4c_DesLactoBusca") OR EOF("cursor_4c_DesLactoBusca")
10992:                 IF USED("cursor_4c_DesLactoBusca")
10993:                     USE IN cursor_4c_DesLactoBusca
10994:                 ENDIF
10995:                 SQLEXEC(gnConnHandle, ;
10996:                     "SELECT usuarios, ncomps FROM SigCdUsu WHERE cativos <> 'N' ORDER BY usuarios", ;
10997:                     "cursor_4c_DesLactoBusca")
10998:             ENDIF
10999:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11000:             IF VARTYPE(loc_oBusca) = "O"
11001:                 loc_oBusca.DefinirCursor("cursor_4c_DesLactoBusca", "usuarios", "ncomps", ;
11002:                     "Selecionar Desenvolvedor")
11003:                 loc_oBusca.Mostrar()
11004:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11005:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11006:                         loc_oPg.txt_4c_DesLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11007:                     ENDIF
11008:                 ENDIF
11009:                 loc_oBusca = .NULL.
11010:             ENDIF
11011:             IF USED("cursor_4c_DesLactoBusca")
11012:                 USE IN cursor_4c_DesLactoBusca
11013:             ENDIF
11014:         CATCH TO loException
11015:             IF USED("cursor_4c_DesLactoBusca")
11016:                 USE IN cursor_4c_DesLactoBusca
11017:             ENDIF
11018:             MostrarErro("Erro ao buscar Desenvolvedor:" + CHR(13) + loException.Message, ;
11019:                 "FormProduto.AbrirBuscaDesLacto")
11020:         ENDTRY
11021:     ENDPROC
11022: 
11023:     *-- GetCriaLacto (txt_4c_CriaLacto): Valid - valida usuario criador em SigCdUsu
11024:     PROCEDURE ValidarCriaLacto(par_nKeyCode, par_nShiftAltCtrl)
11025:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11026:             RETURN
11027:         ENDIF
11028:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
11029:         TRY
11030:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11031:             loc_cCod = ""
11032:             IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11033:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11034:             ENDIF
11035:             IF !EMPTY(loc_cCod)
11036:                 loc_nRet = SQLEXEC(gnConnHandle, ;
11037:                     "SELECT usuarios FROM SigCdUsu " + ;
11038:                     "WHERE usuarios = " + EscaparSQL(loc_cCod) + " AND cativos <> 'N'", ;
11039:                     "cursor_4c_CriaLactoBusca")
11040:                 IF loc_nRet > 0 AND USED("cursor_4c_CriaLactoBusca") AND !EOF("cursor_4c_CriaLactoBusca")
11041:                     IF USED("cursor_4c_CriaLactoBusca")
11042:                         USE IN cursor_4c_CriaLactoBusca
11043:                     ENDIF
11044:                 ELSE
11045:                     IF USED("cursor_4c_CriaLactoBusca")
11046:                         USE IN cursor_4c_CriaLactoBusca
11047:                     ENDIF
11048:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11049:                         loc_oPg.txt_4c_CriaLacto.Value = ""
11050:                     ENDIF
11051:                     THIS.AbrirBuscaCriaLacto()
11052:                 ENDIF
11053:             ENDIF
11054:         CATCH TO loException
11055:             IF USED("cursor_4c_CriaLactoBusca")
11056:                 USE IN cursor_4c_CriaLactoBusca
11057:             ENDIF
11058:             MostrarErro("Erro ao validar Criador:" + CHR(13) + loException.Message, ;
11059:                 "FormProduto.ValidarCriaLacto")
11060:         ENDTRY
11061:     ENDPROC
11062: 
11063:     PROCEDURE AbrirBuscaCriaLacto()
11064:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
11065:         TRY
11066:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11067:             loc_cValAtual = ""
11068:             IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11069:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11070:             ENDIF
11071:             loc_nRet = SQLEXEC(gnConnHandle, ;
11072:                 "SELECT usuarios, ncomps FROM SigCdUsu " + ;
11073:                 "WHERE cativos <> 'N' AND usuarios LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
11074:                 " ORDER BY usuarios", ;
11075:                 "cursor_4c_CriaLactoBusca")
11076:             IF loc_nRet <= 0 OR !USED("cursor_4c_CriaLactoBusca") OR EOF("cursor_4c_CriaLactoBusca")
11077:                 IF USED("cursor_4c_CriaLactoBusca")
11078:                     USE IN cursor_4c_CriaLactoBusca
11079:                 ENDIF
11080:                 SQLEXEC(gnConnHandle, ;
11081:                     "SELECT usuarios, ncomps FROM SigCdUsu WHERE cativos <> 'N' ORDER BY usuarios", ;
11082:                     "cursor_4c_CriaLactoBusca")
11083:             ENDIF
11084:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11085:             IF VARTYPE(loc_oBusca) = "O"
11086:                 loc_oBusca.DefinirCursor("cursor_4c_CriaLactoBusca", "usuarios", "ncomps", ;
11087:                     "Selecionar Criador")
11088:                 loc_oBusca.Mostrar()
11089:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11090:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11091:                         loc_oPg.txt_4c_CriaLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11092:                     ENDIF
11093:                 ENDIF
11094:                 loc_oBusca = .NULL.
11095:             ENDIF
11096:             IF USED("cursor_4c_CriaLactoBusca")
11097:                 USE IN cursor_4c_CriaLactoBusca
11098:             ENDIF
11099:         CATCH TO loException
11100:             IF USED("cursor_4c_CriaLactoBusca")
11101:                 USE IN cursor_4c_CriaLactoBusca
11102:             ENDIF
11103:             MostrarErro("Erro ao buscar Criador:" + CHR(13) + loException.Message, ;
11104:                 "FormProduto.AbrirBuscaCriaLacto")
11105:         ENDTRY
11106:     ENDPROC
11107: 
11108:     *-- btnIniTarefa: registra inicio de tarefa na linha corrente do grdDesigner
11109:     PROCEDURE BtnIniTarefaClick()
11110:         LOCAL loc_oPg, loException
11111:         TRY
11112:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11113:                 MsgAviso("Habilite Incluir ou Alterar para registrar tarefa.")
11114:             ELSE
11115:                 IF USED("cursor_4c_GrdDesigner")
11116:                     SELECT cursor_4c_GrdDesigner
11117:                     APPEND BLANK
11118:                     REPLACE cursor_4c_GrdDesigner.dtini    WITH DATE()
11119:                     REPLACE cursor_4c_GrdDesigner.usuarios WITH ALLTRIM(gc_4c_UsuarioLogado)
11120:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11121:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11122:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11123:                     ENDIF
11124:                 ENDIF
11125:             ENDIF
11126:         CATCH TO loException
11127:             MostrarErro("Erro ao registrar inicio de tarefa:" + CHR(13) + loException.Message, ;
11128:                 "FormProduto.BtnIniTarefaClick")
11129:         ENDTRY
11130:     ENDPROC
11131: 
11132:     *-- btnFimTarefa: registra data conclusao na linha corrente do grdDesigner
11133:     PROCEDURE BtnFimTarefaClick()
11134:         LOCAL loc_oPg, loException
11135:         TRY
11136:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11137:                 MsgAviso("Habilite Incluir ou Alterar para registrar conclus" + CHR(227) + "o.")
11138:             ELSE
11139:                 IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
11140:                     SELECT cursor_4c_GrdDesigner
11141:                     REPLACE cursor_4c_GrdDesigner.dtfim WITH DATE()
11142:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11143:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11144:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11145:                     ENDIF
11146:                 ELSE
11147:                     MsgAviso("Selecione um registro de tarefa para registrar conclus" + CHR(227) + "o.")
11148:                 ENDIF
11149:             ENDIF
11150:         CATCH TO loException
11151:             MostrarErro("Erro ao registrar fim de tarefa:" + CHR(13) + loException.Message, ;
11152:                 "FormProduto.BtnFimTarefaClick")
11153:         ENDTRY
11154:     ENDPROC
11155: 
11156:     *-- btnInsArqs: insere arquivo via dialogo na lista grdArquivos
11157:     PROCEDURE BtnInsArqsClick()
11158:         LOCAL loc_oPg, loc_cArquivo, loException
11159:         TRY
11160:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11161:                 MsgAviso("Habilite Incluir ou Alterar para inserir arquivo.")
11162:             ELSE
11163:                 loc_cArquivo = GETFILE("*", "Selecionar Arquivo")
11164:                 IF !EMPTY(loc_cArquivo) AND USED("cursor_4c_GrdArquivos")
11165:                     SELECT cursor_4c_GrdArquivos
11166:                     APPEND BLANK
11167:                     REPLACE cursor_4c_GrdArquivos.arqnome WITH ALLTRIM(loc_cArquivo)
11168:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11169:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11170:                         loc_oPg.grd_4c_GrdArquivos.Refresh()
11171:                     ENDIF
11172:                 ENDIF
11173:             ENDIF
11174:         CATCH TO loException
11175:             MostrarErro("Erro ao inserir arquivo:" + CHR(13) + loException.Message, ;
11176:                 "FormProduto.BtnInsArqsClick")
11177:         ENDTRY
11178:     ENDPROC
11179: 
11180:     *-- btnExcArqs: exclui arquivo selecionado da lista grdArquivos
11181:     PROCEDURE BtnExcArqsClick()
11182:         LOCAL loc_oPg, loc_lConfirm, loException
11183:         TRY
11184:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11185:                 MsgAviso("Habilite Incluir ou Alterar para excluir arquivo.")
11186:             ELSE
11187:                 IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
11188:                     loc_lConfirm = MsgConfirma("Confirma exclus" + CHR(227) + "o do arquivo selecionado?")
11189:                     IF loc_lConfirm
11190:                         SELECT cursor_4c_GrdArquivos
11191:                         DELETE
11192:                         PACK
11193:                         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11194:                         IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11195:                             loc_oPg.grd_4c_GrdArquivos.Refresh()
11196:                         ENDIF
11197:                     ENDIF
11198:                 ELSE
11199:                     MsgAviso("Selecione um arquivo para excluir.")
11200:                 ENDIF
11201:             ENDIF
11202:         CATCH TO loException
11203:             MostrarErro("Erro ao excluir arquivo:" + CHR(13) + loException.Message, ;
11204:                 "FormProduto.BtnExcArqsClick")
11205:         ENDTRY
11206:     ENDPROC
11207: 
11208:     *-- btnOpnArqs: abre arquivo selecionado com aplicativo associado do SO
11209:     PROCEDURE BtnOpnArqsClick()
11210:         LOCAL loc_cArquivo, loc_oPg, loException
11211:         TRY
11212:             IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
11213:                 loc_cArquivo = ALLTRIM(cursor_4c_GrdArquivos.arqnome)
11214:                 IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
11215:                     DECLARE INTEGER ShellExecute IN Shell32 ;
11216:                         INTEGER hwnd, STRING lpOp, STRING lpFile, ;
11217:                         STRING lpParams, STRING lpDir, INTEGER nShow
11218:                     ShellExecute(0, "open", loc_cArquivo, "", "", 1)
11219:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11220:                     IF PEMSTATUS(loc_oPg, "img_4c_ImgArqJpg", 5)
11221:                         IF INLIST(UPPER(RIGHT(ALLTRIM(loc_cArquivo), 4)), ".JPG", ".PNG") OR ;
11222:                             UPPER(RIGHT(ALLTRIM(loc_cArquivo), 5)) = ".JPEG"
11223:                             loc_oPg.img_4c_ImgArqJpg.Picture = loc_cArquivo
11224:                             loc_oPg.img_4c_ImgArqJpg.Visible = .T.
11225:                         ELSE
11226:                             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
11227:                         ENDIF
11228:                     ENDIF
11229:                 ELSE
11230:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArquivo)
11231:                 ENDIF
11232:             ELSE
11233:                 MsgAviso("Selecione um arquivo para abrir.")
11234:             ENDIF
11235:         CATCH TO loException
11236:             MostrarErro("Erro ao abrir arquivo:" + CHR(13) + loException.Message, ;
11237:                 "FormProduto.BtnOpnArqsClick")
11238:         ENDTRY
11239:     ENDPROC
11240: 
11241:     *===========================================================================
11242:     * ConfigurarPgpgServico - Configura Page8 "Servicos" do pgf_4c_Dados
11243:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgServico
11244:     * grdServico: top=171, left=339, width=320, height=387, 3 colunas
11245:     *   Column1 (ColumnOrder=2): Descs - editavel em INCLUIR/ALTERAR E Marcas=1
11246:     *   Column2 (ColumnOrder=3): Cods  - somente leitura
11247:     *   Column3 (ColumnOrder=1): Marcas (CheckBox) - editavel em INCLUIR/ALTERAR
11248:     *===========================================================================
11249:     PROTECTED PROCEDURE ConfigurarPgpgServico(par_oPg)
11250:         LOCAL loc_oPg, loc_oGrid, loc_oErro
11251:         TRY
11252:             loc_oPg = par_oPg
11253:             loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
11254: 
11255:             *-- Cursor placeholder ANTES de RecordSource (REGRA CRITICA VFP9)
11256:             IF !USED("cursor_4c_GrdServico")
11257:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11258:             ENDIF
11259: 
11260:             *-- grd_4c_Dados: grade de servicos associados
11261:             *-- Original grdServico: top=171, left=339, width=320, height=387
11262:             loc_oPg.AddObject("grd_4c_Dados", "Grid")
11263:             WITH loc_oPg.grd_4c_Dados
11264:                 .Top        = 171
11265:                 .Left       = 339
11266:                 .Width      = 320
11267:                 .Height     = 387
11268:                 .FontName   = "Tahoma"
11269:                 .FontSize   = 8
11270:                 .DeleteMark = .F.
11271:                 .RecordMark = .F.
11272:                 .RowHeight  = 16
11273:                 .ScrollBars = 2
11274:                 .Visible    = .T.
11275:             ENDWITH
11276:             loc_oPg.grd_4c_Dados.ColumnCount  = 3
11277:             loc_oPg.grd_4c_Dados.RecordSource = "cursor_4c_GrdServico"
11278:             loc_oGrid = loc_oPg.grd_4c_Dados
11279: 
11280:             *-- Column1: Descs/Descricao Servico (ColumnOrder=2 - exibida como 2a coluna)
11281:             *-- When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
11282:             *-- Valid: fAcessoEmpresa (validacao empresa por descricao de servico)
11283:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdServico.Descs"
11284:             loc_oGrid.Column1.Width           = 228
11285:             loc_oGrid.Column1.ColumnOrder     = 2
11286:             loc_oGrid.Column1.Movable         = .F.
11287:             loc_oGrid.Column1.Resizable       = .F.
11288:             loc_oGrid.Column1.Header1.Caption = "Servi" + CHR(231) + "os"
11289:             loc_oGrid.Column1.Text1.Alignment  = 3
11290:             loc_oGrid.Column1.Text1.BorderStyle = 0
11291:             loc_oGrid.Column1.Text1.Margin     = 0
11292:             BINDEVENT(loc_oGrid.Column1.Text1, "When",  THIS, "GrdServicoCol1When")
11293:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid",  THIS, "GrdServicoCol1Valid")
11294: 
11295:             *-- Column2: Cods/Codigo Servico (ColumnOrder=3, somente leitura)
11296:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdServico.Cods"
11297:             loc_oGrid.Column2.Width           = 50
11298:             loc_oGrid.Column2.ColumnOrder     = 3
11299:             loc_oGrid.Column2.Movable         = .F.
11300:             loc_oGrid.Column2.Resizable       = .F.
11301:             loc_oGrid.Column2.ReadOnly        = .T.
11302:             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
11303:             loc_oGrid.Column2.Text1.BorderStyle = 0
11304:             loc_oGrid.Column2.Text1.Margin     = 0
11305:             loc_oGrid.Column2.Text1.ReadOnly   = .T.
11306: 
11307:             *-- Column3: Marcas/CheckBox (ColumnOrder=1 - primeira coluna visualmente)
11308:             *-- Sparse=.F. obrigatorio para CheckBox funcionar em coluna de grid
11309:             *-- When: editavel em INCLUIR/ALTERAR
11310:             *-- KeyPress: Space(32) ou Enter(13) togla Marcas (0->1, 1->0)
11311:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdServico.Marcas"
11312:             loc_oGrid.Column3.Width           = 17
11313:             loc_oGrid.Column3.ColumnOrder     = 1
11314:             loc_oGrid.Column3.Movable         = .F.
11315:             loc_oGrid.Column3.Resizable       = .F.
11316:             loc_oGrid.Column3.Sparse          = .F.
11317:             loc_oGrid.Column3.Header1.Caption = ""
11318:             loc_oGrid.Column3.AddObject("Check1", "CheckBox")
11319:             WITH loc_oGrid.Column3.Check1
11320:                 .Caption   = ""
11321:                 .Alignment = 0
11322:                 .ReadOnly  = .F.
11323:                 .Visible   = .T.
11324:                 .Top       = 9
11325:                 .Left      = 2
11326:                 .Height    = 17
11327:                 .Width     = 22
11328:             ENDWITH
11329:             BINDEVENT(loc_oGrid.Column3.Check1, "When",     THIS, "GrdServicoChk3When")
11330:             BINDEVENT(loc_oGrid.Column3.Check1, "KeyPress", THIS, "GrdServicoChk3KeyPress")
11331: 
11332:         CATCH TO loc_oErro
11333:             MostrarErro("Erro ao configurar pgServico:" + CHR(13) + loc_oErro.Message, ;
11334:                 "FormProduto.ConfigurarPgpgServico")
11335:         ENDTRY
11336:     ENDPROC
11337: 
11338:     *===========================================================================
11339:     * CarregarServicos - Popula cursor_4c_GrdServico com todos os servicos
11340:     * de SigPrSer, marcando Marcas=1 para os associados ao produto em SigSerPr.
11341:     * Chamado de BOParaForm ao carregar registro existente.
11342:     *===========================================================================
11343:     PROTECTED PROCEDURE CarregarServicos()
11344:         LOCAL loc_cCpros, loc_nRet, loc_oPg, loc_oGrid, loException
11345:         TRY
11346:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11347:             IF EMPTY(loc_cCpros) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
11348:                 RETURN
11349:             ENDIF
11350: 
11351:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page8
11352: 
11353:             *-- Carregar todos os servicos com Marcas=0/1 via LEFT JOIN em SigSerPr
11354:             IF USED("cursor_4c_GrdServico")
11355:                 USE IN cursor_4c_GrdServico
11356:             ENDIF
11357:             loc_nRet = SQLEXEC(gnConnHandle, ;
11358:                 "SELECT CASE WHEN s.cods IS NOT NULL THEN 1 ELSE 0 END AS Marcas," + ;
11359:                 " p.cods, p.descs, p.qtdias" + ;
11360:                 " FROM SigPrSer p" + ;
11361:                 " LEFT JOIN SigSerPr s ON s.cods = p.cods AND s.cpros = " + EscaparSQL(loc_cCpros) + ;
11362:                 " ORDER BY p.descs", ;
11363:                 "cursor_4c_GrdServico")
11364:             IF loc_nRet <= 0
11365:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11366:             ENDIF
11367: 
11368:             *-- Reassociar RecordSource e ControlSources apos recarregar cursor
11369:             IF PEMSTATUS(loc_oPg, "grd_4c_Dados", 5)
11370:                 loc_oGrid = loc_oPg.grd_4c_Dados
11371:                 loc_oGrid.ColumnCount = 3
11372:                 loc_oGrid.RecordSource          = "cursor_4c_GrdServico"
11373:                 loc_oGrid.Column1.ControlSource = "cursor_4c_GrdServico.Descs"
11374:                 loc_oGrid.Column2.ControlSource = "cursor_4c_GrdServico.Cods"
11375:                 loc_oGrid.Column3.ControlSource = "cursor_4c_GrdServico.Marcas"
11376:                 loc_oGrid.Refresh()
11377:             ENDIF
11378: 
11379:         CATCH TO loException
11380:             MostrarErro("Erro ao carregar Servi" + CHR(231) + "os:" + CHR(13) + ;
11381:                 loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
11382:                 "FormProduto.CarregarServicos")
11383:         ENDTRY
11384:     ENDPROC
11385: 
11386:     *===========================================================================
11387:     * Handlers de BINDEVENT para pgServico (Page8)
11388:     * Todos PUBLIC - requerido pelo BINDEVENT
11389:     *===========================================================================
11390: 
11391:     *-- Column1 Text1 When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
11392:     PROCEDURE GrdServicoCol1When()
11393:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11394:             RETURN .F.
11395:         ENDIF
11396:         IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
11397:             RETURN cursor_4c_GrdServico.Marcas = 1
11398:         ENDIF
11399:         RETURN .F.
11400:     ENDPROC
11401: 
11402:     *-- Column1 Text1 Valid: fAcessoEmpresa (validacao de empresa por descricao de servico)
11403:     PROCEDURE GrdServicoCol1Valid()
11404:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11405:             RETURN .T.
11406:         ENDIF
11407:         LOCAL loc_cDescs, loException
11408:         loc_cDescs = ""
11409:         TRY
11410:             IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
11411:                 loc_cDescs = ALLTRIM(cursor_4c_GrdServico.Descs)
11412:             ENDIF
11413:             IF !EMPTY(loc_cDescs)
11414:                 *!! CORRETOR #110: fAcessoEmpresa() NAO existe na nova arquitetura. Substituir por bloco FormBuscaAuxiliar apontando SigCdEmp (chave Cemps modo C, Razas modo D). Ver Formsigatcrp.prg:2278-2378.
11415:                 fAcessoEmpresa(Usuar, "C", loc_cDescs, .NULL., "")
11416:             ENDIF
11417:         CATCH TO loException
11418:             MostrarErro("Erro na valida" + CHR(231) + CHR(227) + "o de empresa:" + ;
11419:                 CHR(13) + loException.Message, "FormProduto.GrdServicoCol1Valid")
11420:         ENDTRY
11421:         RETURN .T.
11422:     ENDPROC
11423: 
11424:     *-- Column3 Check1 When: editavel apenas em INCLUIR/ALTERAR
11425:     PROCEDURE GrdServicoChk3When()
11426:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11427:     ENDPROC
11428: 
11429:     *-- Column3 Check1 KeyPress: Space(32) ou Enter(13) togla Marcas (0->1 / 1->0)
11430:     PROCEDURE GrdServicoChk3KeyPress(par_nKeyCode, par_nShiftAltCtrl)
11431:         IF INLIST(par_nKeyCode, 13, 32)
11432:             IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
11433:                 REPLACE cursor_4c_GrdServico.Marcas WITH IIF(cursor_4c_GrdServico.Marcas = 0, 1, 0)
11434:             ENDIF
11435:         ENDIF
11436:     ENDPROC
11437: 
11438: ENDDEFINE

