# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (115)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_MTPRIMA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GradFase' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdMatrizes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdServico' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_PrfExist' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (11475 linhas total):

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

*-- Linhas 1298 a 1392:
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
1330:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
1331:                    !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "CNT_4C_MTPRIMA")
1332:                     loc_oObjeto.Visible = .T.
1333:                 ENDIF
1334: 
1335:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1336:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1337:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1338:                     ENDFOR
1339:                 ENDIF
1340: 
1341:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1342:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1343:                 ENDIF
1344:             ENDIF
1345:         ENDFOR
1346:     ENDPROC
1347: 
1348:     *===========================================================================
1349:     * CarregarLista - Carrega dados no grid da Page1
1350:     * CRITICO: Definir ControlSources APOS RecordSource (auto-bind)
1351:     *===========================================================================
1352:     PROCEDURE CarregarLista()
1353:         LOCAL loc_lResultado, loc_oGrid
1354:         loc_lResultado = .F.
1355: 
1356:         TRY
1357:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1358:                 SET NULL ON
1359:                 CREATE CURSOR cursor_4c_Dados (cpros C(14), dpros C(65), cgrus C(3), ;
1360:                     sgrus C(6), linhas C(10), tipos C(1), situas N(1,0), ifors C(10), ;
1361:                     pvens N(11,5), pcuss N(11,5), custofs N(11,3), cunis C(3), ;
1362:                     matprincs C(14), codcors C(4), codtams C(4), reffs C(40), ;
1363:                     colecoes C(10), idpro N(10,0))
1364:                 SET NULL OFF
1365:                 loc_lResultado = .T.
1366:             ELSE
1367:                 IF !THIS.this_oBusinessObject.Buscar("")
1368:                     loc_lResultado = .F.
1369:                 ELSE
1370:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1371: 
1372:                 *-- RecordSource e ColumnCount FORA do WITH (auto-bind VFP9)
1373:                 loc_oGrid.ColumnCount  = 7
1374:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1375: 
1376:                 *-- ControlSources APOS RecordSource (OBRIGATORIO - auto-bind sobrescreve)
1377:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
1378:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
1379:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
1380:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
1381:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
1382:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.colecoes"
1383:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.situas"
1384: 
1385:                 *-- Widths (originais: 110, 408, 40, 70, 150, 100, 16)
1386:                 loc_oGrid.Column1.Width = 110
1387:                 loc_oGrid.Column2.Width = 408
1388:                 loc_oGrid.Column3.Width = 40
1389:                 loc_oGrid.Column4.Width = 70
1390:                 loc_oGrid.Column5.Width = 150
1391:                 loc_oGrid.Column6.Width = 100
1392:                 loc_oGrid.Column7.Width = 40

*-- Linhas 1436 a 1817:
1436:     *===========================================================================
1437:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1438:     *===========================================================================
1439:     PROCEDURE AlternarPagina(par_nPagina)
1440:         LOCAL loc_lResultado
1441:         loc_lResultado = .F.
1442: 
1443:         TRY
1444:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1445:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
1446:             ELSE
1447:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1448: 
1449:                 IF par_nPagina = 1
1450:                     THIS.this_cModoAtual = "LISTA"
1451:                     THIS.CarregarLista()
1452:                 ENDIF
1453: 
1454:                 loc_lResultado = .T.
1455:             ENDIF
1456: 
1457:         CATCH TO loException
1458:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
1459:                 "FormProduto.AlternarPagina")
1460:         ENDTRY
1461: 
1462:         RETURN loc_lResultado
1463:     ENDPROC
1464: 
1465:     *===========================================================================
1466:     * FormatarGridLista - Formata visual do grid de lista
1467:     *===========================================================================
1468:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1469:         TRY
1470:             WITH par_oGrid
1471:                 .FontName = "Tahoma"
1472:                 .FontSize = 8
1473:             ENDWITH
1474:         CATCH TO loException
1475:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
1476:                 "FormProduto.FormatarGridLista")
1477:         ENDTRY
1478:     ENDPROC
1479: 
1480:     *===========================================================================
1481:     * BtnIncluirClick - Abre Page2 para incluir novo produto
1482:     * PUBLIC: BINDEVENT requer metodo publico
1483:     *===========================================================================
1484:     PROCEDURE BtnIncluirClick()
1485:         THIS.this_oBusinessObject.NovoRegistro()
1486:         THIS.LimparCampos()
1487:         THIS.this_cModoAtual = "INCLUIR"
1488:         THIS.HabilitarCampos(.T.)
1489:         THIS.AjustarBotoesPorModo()
1490:         THIS.AlternarPagina(2)
1491:     ENDPROC
1492: 
1493:     *===========================================================================
1494:     * BtnVisualizarClick - Abre Page2 em modo somente leitura
1495:     * PUBLIC: BINDEVENT requer metodo publico
1496:     *===========================================================================
1497:     PROCEDURE BtnVisualizarClick()
1498:         LOCAL loc_cCodigo
1499:         loc_cCodigo = ""
1500: 
1501:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1502:             SELECT cursor_4c_Dados
1503:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1504:         ENDIF
1505: 
1506:         IF EMPTY(loc_cCodigo)
1507:             MsgAviso("Selecione um produto para visualizar.")
1508:         ELSE
1509:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1510:                 THIS.this_cModoAtual = "VISUALIZAR"
1511:                 THIS.BOParaForm()
1512:                 THIS.HabilitarCampos(.F.)
1513:                 THIS.AjustarBotoesPorModo()
1514:                 THIS.AlternarPagina(2)
1515:             ENDIF
1516:         ENDIF
1517:     ENDPROC
1518: 
1519:     *===========================================================================
1520:     * BtnAlterarClick - Abre Page2 para alterar produto selecionado
1521:     * PUBLIC: BINDEVENT requer metodo publico
1522:     *===========================================================================
1523:     PROCEDURE BtnAlterarClick()
1524:         LOCAL loc_cCodigo
1525:         loc_cCodigo = ""
1526: 
1527:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1528:             SELECT cursor_4c_Dados
1529:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
1530:         ENDIF
1531: 
1532:         IF EMPTY(loc_cCodigo)
1533:             MsgAviso("Selecione um produto para alterar.")
1534:         ELSE
1535:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1536:                 THIS.this_oBusinessObject.EditarRegistro()
1537:                 THIS.this_cModoAtual = "ALTERAR"
1538:                 THIS.BOParaForm()
1539:                 THIS.HabilitarCampos(.T.)
1540:                 THIS.AjustarBotoesPorModo()
1541:                 THIS.AlternarPagina(2)
1542:             ENDIF
1543:         ENDIF
1544:     ENDPROC
1545: 
1546:     *===========================================================================
1547:     * BtnExcluirClick - Exclui produto selecionado com confirmacao
1548:     * PUBLIC: BINDEVENT requer metodo publico
1549:     *===========================================================================
1550:     PROCEDURE BtnExcluirClick()
1551:         LOCAL loc_cCodigo, loc_cDescricao
1552:         loc_cCodigo    = ""
1553:         loc_cDescricao = ""
1554: 
1555:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1556:             SELECT cursor_4c_Dados
1557:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
1558:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)
1559:         ENDIF
1560: 
1561:         IF EMPTY(loc_cCodigo)
1562:             MsgAviso("Selecione um produto para excluir.")
1563:         ELSE
1564:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1565:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto [" + ;
1566:                     loc_cCodigo + "] - " + loc_cDescricao + "?", ;
1567:                     "Confirmar Exclus" + CHR(227) + "o")
1568:                     IF THIS.this_oBusinessObject.Excluir()
1569:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso!")
1570:                         THIS.CarregarLista()
1571:                     ENDIF
1572:                 ENDIF
1573:             ENDIF
1574:         ENDIF
1575:     ENDPROC
1576: 
1577:     *===========================================================================
1578:     * BtnBuscarClick - Busca produto pelo codigo ou descricao
1579:     * PUBLIC: BINDEVENT requer metodo publico
1580:     *===========================================================================
1581:     PROCEDURE BtnBuscarClick()
1582:         LOCAL loc_oBusca, loc_cCodigo, loc_nRet, loException
1583:         loc_cCodigo = ""
1584: 
1585:         TRY
1586:             loc_nRet = SQLEXEC(gnConnHandle, ;
1587:                 "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
1588:                 "cursor_4c_BuscaProduto")
1589: 
1590:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaProduto")
1591:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1592:                 IF VARTYPE(loc_oBusca) = "O"
1593:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProduto"
1594:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProduto", "cpros", "dpros", ;
1595:                         "Buscar Produto")
1596:                     loc_oBusca.Mostrar()
1597:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado)
1598:                         loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1599:                     ENDIF
1600:                     loc_oBusca = .NULL.
1601:                 ENDIF
1602:             ENDIF
1603: 
1604:             IF USED("cursor_4c_BuscaProduto")
1605:                 USE IN cursor_4c_BuscaProduto
1606:             ENDIF
1607: 
1608:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
1609:                 SELECT cursor_4c_Dados
1610:                 LOCATE FOR ALLTRIM(cpros) == loc_cCodigo
1611:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1612:             ENDIF
1613: 
1614:         CATCH TO loException
1615:             IF USED("cursor_4c_BuscaProduto")
1616:                 USE IN cursor_4c_BuscaProduto
1617:             ENDIF
1618:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
1619:                 "FormProduto.BtnBuscarClick")
1620:         ENDTRY
1621:     ENDPROC
1622: 
1623:     *===========================================================================
1624:     * BtnEncerrarClick - Fecha o formulario
1625:     * PUBLIC: BINDEVENT requer metodo publico
1626:     *===========================================================================
1627:     PROCEDURE BtnEncerrarClick()
1628:         THIS.Release()
1629:     ENDPROC
1630: 
1631:     *===========================================================================
1632:     * LimparCampos - Limpa todos os campos de entrada do pgDados.Page1
1633:     *===========================================================================
1634:     PROTECTED PROCEDURE LimparCampos()
1635:         LOCAL loc_oPg, loException
1636:         TRY
1637:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1638:             WITH loc_oPg
1639:                 .txt_4c_Cpros.Value     = ""
1640:                 .txt_4c_Dpros.Value     = ""
1641:                 .txt_4c_Cbars.Value     = 0
1642:                 .opt_4c_Situacao.Value  = 1
1643:                 .txt_4c_DtSituas.Value  = {}
1644:                 .txt_4c_Cgrus.Value     = ""
1645:                 .txt_4c_Dgrus.Value     = ""
1646:                 .txt_4c_SGrus.Value     = ""
1647:                 .txt_4c_DsGrus.Value    = ""
1648:                 .txt_4c_Linhas.Value    = ""
1649:                 .txt_4c_DLinhas.Value   = ""
1650:                 .txt_4c_Obspes.Value    = ""
1651:                 .txt_4c_Obspeds.Value   = ""
1652:                 .txt_4c_Colecoes.Value  = ""
1653:                 .txt_4c_DColecoes.Value = ""
1654:                 .txt_4c_Ifors.Value     = ""
1655:                 .txt_4c_Dfors.Value     = ""
1656:                 .txt_4c_Reffs.Value     = ""
1657:                 .txt_4c_CodCors.Value   = ""
1658:                 .txt_4c_CodTams.Value   = ""
1659:                 .txt_4c_Custofs.Value   = 0
1660:                 .txt_4c_MoeCusfs.Value  = ""
1661:                 .txt_4c_Pvens.Value     = 0
1662:                 .txt_4c_Moevs.Value     = ""
1663:                 .txt_4c_Fvendas.Value   = 0
1664:                 .txt_4c_Moepvs.Value    = ""
1665:                 .txt_4c_CodAcbs.Value   = ""
1666:                 .txt_4c_DAcbs.Value     = ""
1667:                 .txt_4c_Cunis.Value     = ""
1668:                 .txt_4c_Dunis.Value     = ""
1669:                 .txt_4c_DtIncs.Value    = {}
1670:                 .txt_4c_DtAlts.Value    = {}
1671:             ENDWITH
1672:         CATCH TO loException
1673:             MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, ;
1674:                 "FormProduto.LimparCampos")
1675:         ENDTRY
1676:     ENDPROC
1677: 
1678:     *===========================================================================
1679:     * HabilitarCampos - Habilita/desabilita campos de entrada por modo
1680:     * par_lHabilitar=.T. em INCLUIR/ALTERAR, .F. em VISUALIZAR
1681:     *===========================================================================
1682:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1683:         LOCAL loc_oPg, loc_lModoIncluir, loException
1684:         TRY
1685:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1686:             loc_lModoIncluir = (THIS.this_cModoAtual == "INCLUIR")
1687: 
1688:             WITH loc_oPg
1689:                 *-- Codigo do produto: somente editavel em INCLUIR (PK nao pode mudar em ALTERAR)
1690:                 .txt_4c_Cpros.Enabled    = par_lHabilitar AND loc_lModoIncluir
1691:                 *-- Demais campos de entrada
1692:                 .txt_4c_Dpros.Enabled    = par_lHabilitar
1693:                 .txt_4c_Cbars.Enabled    = par_lHabilitar
1694:                 .opt_4c_Situacao.Enabled = par_lHabilitar
1695:                 .txt_4c_Cgrus.Enabled    = par_lHabilitar
1696:                 .txt_4c_SGrus.Enabled    = par_lHabilitar
1697:                 .txt_4c_Linhas.Enabled   = par_lHabilitar
1698:                 .txt_4c_Obspes.Enabled   = par_lHabilitar
1699:                 .txt_4c_Obspeds.Enabled  = par_lHabilitar
1700:                 .txt_4c_Colecoes.Enabled = par_lHabilitar
1701:                 .txt_4c_Ifors.Enabled    = par_lHabilitar
1702:                 .txt_4c_Reffs.Enabled    = par_lHabilitar
1703:                 .txt_4c_CodCors.Enabled  = par_lHabilitar
1704:                 .txt_4c_CodTams.Enabled  = par_lHabilitar
1705:                 .txt_4c_CodAcbs.Enabled  = par_lHabilitar
1706:                 .txt_4c_Cunis.Enabled    = par_lHabilitar
1707:             ENDWITH
1708: 
1709:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5)
1710:                 WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1711:                     .cmd_4c_Salvar.Enabled = par_lHabilitar
1712:                     .Visible     = .T.
1713:                 ENDWITH
1714:             ENDIF
1715: 
1716:         CATCH TO loException
1717:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
1718:                 "FormProduto.HabilitarCampos")
1719:         ENDTRY
1720:     ENDPROC
1721: 
1722:     *===========================================================================
1723:     * AjustarBotoesPorModo - Ajusta botoes por modo atual
1724:     *===========================================================================
1725:     PROCEDURE AjustarBotoesPorModo()
1726:         LOCAL loc_lEhLista
1727:         loc_lEhLista = (THIS.this_cModoAtual == "LISTA")
1728: 
1729:         TRY
1730:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
1731:                 WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1732:                     IF PEMSTATUS(.cmd_4c_Incluir, "Enabled", 5)
1733:                         .cmd_4c_Incluir.Enabled   = loc_lEhLista
1734:                         .cmd_4c_Alterar.Enabled   = loc_lEhLista
1735:                         .cmd_4c_Excluir.Enabled   = loc_lEhLista
1736:                         .cmd_4c_Visualizar.Enabled = loc_lEhLista
1737:                         .cmd_4c_Buscar.Enabled    = loc_lEhLista
1738:                     ENDIF
1739:                     .Visible     = .T.
1740:                 ENDWITH
1741:             ENDIF
1742:         CATCH TO loException
1743:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
1744:                 "FormProduto.AjustarBotoesPorModo")
1745:         ENDTRY
1746:     ENDPROC
1747: 
1748:     *===========================================================================
1749:     * FormParaBO - Transfere valores do pgDados.Page1 para o BO
1750:     *===========================================================================
1751:     PROTECTED PROCEDURE FormParaBO()
1752:         LOCAL loc_oPg, loc_oBO, loException
1753:         TRY
1754:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1755:             loc_oBO = THIS.this_oBusinessObject
1756: 
1757:             loc_oBO.this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
1758:             loc_oBO.this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpros.Value)
1759:             loc_oBO.this_nCbars    = loc_oPg.txt_4c_Cbars.Value
1760:             loc_oBO.this_nSituas   = loc_oPg.opt_4c_Situacao.Value
1761:             loc_oBO.this_cCgrus    = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
1762:             loc_oBO.this_cSgrus    = ALLTRIM(loc_oPg.txt_4c_SGrus.Value)
1763:             loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
1764:             loc_oBO.this_cObspes   = ALLTRIM(loc_oPg.txt_4c_Obspes.Value)
1765:             loc_oBO.this_cObspeds  = ALLTRIM(loc_oPg.txt_4c_Obspeds.Value)
1766:             loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
1767:             loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
1768:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Reffs.Value)
1769:             loc_oBO.this_cCodcors  = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)
1770:             loc_oBO.this_cCodtams  = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
1771:             loc_oBO.this_nCustofs  = loc_oPg.txt_4c_Custofs.Value
1772:             loc_oBO.this_nPvens    = loc_oPg.txt_4c_Pvens.Value
1773:             loc_oBO.this_nFvendas  = loc_oPg.txt_4c_Fvendas.Value
1774:             loc_oBO.this_cCodacbs  = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
1775:             loc_oBO.this_cCunis    = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
1776: 
1777:             *-- Campos da aba FaseP (Page4 de pgf_4c_Dados)
1778:             LOCAL loc_oPgFP
1779:             loc_oPgFP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
1780:             IF PEMSTATUS(loc_oPgFP, "txt_4c_QminFabs", 5)
1781:                 loc_oBO.this_nQtminfabs  = loc_oPgFP.txt_4c_QminFabs.Value
1782:                 loc_oBO.this_cCodgarras  = ALLTRIM(loc_oPgFP.txt_4c_CodGarras.Value)
1783:                 loc_oBO.this_cConquilhas = ALLTRIM(loc_oPgFP.txt_4c_Conquilhas.Value)
1784:                 loc_oBO.this_nPesobris   = loc_oPgFP.txt_4c_PesoBris.Value
1785:                 loc_oBO.this_nPesometal  = loc_oPgFP.txt_4c_PesoMetal.Value
1786:                 loc_oBO.this_nPesopdrs   = loc_oPgFP.txt_4c_PesoPdrs.Value
1787:                 loc_oBO.this_cCodcors    = ALLTRIM(loc_oPgFP.txt_4c_CodCorsFP.Value)
1788:                 loc_oBO.this_cCodtams    = ALLTRIM(loc_oPgFP.txt_4c_CodTamsFP.Value)
1789:                 loc_oBO.this_cCodacbs    = ALLTRIM(loc_oPgFP.txt_4c_CodAcbsFP.Value)
1790:                 loc_oBO.this_nCravcers   = IIF(loc_oPgFP.chk_4c_CravCera.Value = 1, 1, 0)
1791:                 loc_oBO.this_nVarias     = IIF(loc_oPgFP.chk_4c_Varias.Value = 1, 1, 0)
1792:                 loc_oBO.this_nDiasgar    = loc_oPgFP.txt_4c_DiasGar.Value
1793:                 loc_oBO.this_nTents      = loc_oPgFP.txt_4c_TEnts.Value
1794:                 loc_oBO.this_nVolumes    = loc_oPgFP.txt_4c_Volumes.Value
1795:                 loc_oBO.this_nLtminsv    = loc_oPgFP.txt_4c_LtMinsV.Value
1796:                 loc_oBO.this_nProdvars   = loc_oPgFP.opt_4c_Prodvars.Value
1797: 
1798:                 *-- Flush obs do EditBox para o cursor da linha selecionada antes de salvar
1799:                 IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase") AND ;
1800:                         PEMSTATUS(loc_oPgFP, "edt_4c_Obs", 5)
1801:                     SELECT cursor_4c_GradFase
1802:                     REPLACE cursor_4c_GradFase.obs WITH loc_oPgFP.edt_4c_Obs.Value
1803:                 ENDIF
1804:             ENDIF
1805: 
1806:             *-- Campos da aba Dados Fiscais (Page3 de pgf_4c_Dados)
1807:             LOCAL loc_oPgFisc, loc_nIpiIdx
1808:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
1809:             IF PEMSTATUS(loc_oPgFisc, "txt_4c_Clfiscal", 5)
1810:                 loc_oBO.this_cClfiscals  = ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)
1811:                 loc_oBO.this_cOrigmercs  = ALLTRIM(loc_oPgFisc.txt_4c_Origmerc.Value)
1812:                 loc_oBO.this_cSittricms  = ALLTRIM(loc_oPgFisc.txt_4c_Sittricm.Value)
1813:                 loc_oBO.this_nIcms       = loc_oPgFisc.txt_4c_Icms.Value
1814:                 loc_oBO.this_cTptribs    = ALLTRIM(loc_oPgFisc.txt_4c_TpTrib.Value)
1815:                 loc_oBO.this_cIats       = ALLTRIM(loc_oPgFisc.txt_4c_Iat.Value)
1816:                 loc_oBO.this_nAliqipis   = loc_oPgFisc.txt_4c_AliqIPI.Value
1817:                 loc_oBO.this_cExtipi     = ALLTRIM(loc_oPgFisc.txt_4c_Extipi.Value)

*-- Linhas 1848 a 1891:
1848:     *===========================================================================
1849:     * BOParaForm - Transfere propriedades do BO para os campos do pgDados.Page1
1850:     *===========================================================================
1851:     PROTECTED PROCEDURE BOParaForm()
1852:         LOCAL loc_oPg, loc_oBO, loException
1853:         TRY
1854:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1855:             loc_oBO = THIS.this_oBusinessObject
1856: 
1857:             loc_oPg.txt_4c_Cpros.Value     = ALLTRIM(loc_oBO.this_cCpros)
1858:             loc_oPg.txt_4c_Dpros.Value     = ALLTRIM(loc_oBO.this_cDpros)
1859:             loc_oPg.txt_4c_Cbars.Value     = loc_oBO.this_nCbars
1860:             loc_oPg.opt_4c_Situacao.Value  = IIF(loc_oBO.this_nSituas = 1, 1, 2)
1861:             loc_oPg.txt_4c_DtSituas.Value  = IIF(EMPTY(loc_oBO.this_dDtsituas), {}, ;
1862:                 TTOD(loc_oBO.this_dDtsituas))
1863:             loc_oPg.txt_4c_Cgrus.Value     = ALLTRIM(loc_oBO.this_cCgrus)
1864:             loc_oPg.txt_4c_Dgrus.Value     = ""
1865:             loc_oPg.txt_4c_SGrus.Value     = ALLTRIM(loc_oBO.this_cSgrus)
1866:             loc_oPg.txt_4c_DsGrus.Value    = ""
1867:             loc_oPg.txt_4c_Linhas.Value    = ALLTRIM(loc_oBO.this_cLinhas)
1868:             loc_oPg.txt_4c_DLinhas.Value   = ""
1869:             loc_oPg.txt_4c_Obspes.Value    = ALLTRIM(loc_oBO.this_cObspes)
1870:             loc_oPg.txt_4c_Obspeds.Value   = ALLTRIM(loc_oBO.this_cObspeds)
1871:             loc_oPg.txt_4c_Colecoes.Value  = ALLTRIM(loc_oBO.this_cColecoes)
1872:             loc_oPg.txt_4c_DColecoes.Value = ""
1873:             loc_oPg.txt_4c_Ifors.Value     = ALLTRIM(loc_oBO.this_cIfors)
1874:             loc_oPg.txt_4c_Dfors.Value     = ""
1875:             loc_oPg.txt_4c_Reffs.Value     = ALLTRIM(loc_oBO.this_cReffs)
1876:             loc_oPg.txt_4c_CodCors.Value   = ALLTRIM(loc_oBO.this_cCodcors)
1877:             loc_oPg.txt_4c_CodTams.Value   = ALLTRIM(loc_oBO.this_cCodtams)
1878:             loc_oPg.txt_4c_Custofs.Value   = loc_oBO.this_nCustofs
1879:             loc_oPg.txt_4c_MoeCusfs.Value  = ALLTRIM(loc_oBO.this_cMoecusfs)
1880:             loc_oPg.txt_4c_Pvens.Value     = loc_oBO.this_nPvens
1881:             loc_oPg.txt_4c_Moevs.Value     = ALLTRIM(loc_oBO.this_cMoevs)
1882:             loc_oPg.txt_4c_Fvendas.Value   = loc_oBO.this_nFvendas
1883:             loc_oPg.txt_4c_Moepvs.Value    = ALLTRIM(loc_oBO.this_cMoepvs)
1884:             loc_oPg.txt_4c_CodAcbs.Value   = ALLTRIM(loc_oBO.this_cCodacbs)
1885:             loc_oPg.txt_4c_DAcbs.Value     = ""
1886:             loc_oPg.txt_4c_Cunis.Value     = ALLTRIM(loc_oBO.this_cCunis)
1887:             loc_oPg.txt_4c_Dunis.Value     = ""
1888:             loc_oPg.txt_4c_DtIncs.Value    = IIF(EMPTY(loc_oBO.this_dDtincs), {}, ;
1889:                 TTOD(loc_oBO.this_dDtincs))
1890:             loc_oPg.txt_4c_DtAlts.Value    = IIF(EMPTY(loc_oBO.this_dDtalts), {}, ;
1891:                 TTOD(loc_oBO.this_dDtalts))

*-- Linhas 1976 a 2104:
1976: 
1977:     *===========================================================================
1978:     * BtnSalvarClick - Confirma e salva o produto
1979:     * PUBLIC: BINDEVENT requer metodo publico
1980:     *===========================================================================
1981:     PROCEDURE BtnSalvarClick()
1982:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1983:             RETURN
1984:         ENDIF
1985: 
1986:         IF !THIS.ValidarCampos()
1987:             RETURN
1988:         ENDIF
1989: 
1990:         THIS.FormParaBO()
1991: 
1992:         IF THIS.this_oBusinessObject.Salvar()
1993:             MsgInfo("Produto salvo com sucesso!")
1994:             THIS.AlternarPagina(1)
1995:         ENDIF
1996:     ENDPROC
1997: 
1998:     *===========================================================================
1999:     * BtnCancelarClick - Cancela e volta para lista
2000:     * PUBLIC: BINDEVENT requer metodo publico
2001:     *===========================================================================
2002:     PROCEDURE BtnCancelarClick()
2003:         THIS.AlternarPagina(1)
2004:         THIS.this_cModoAtual = "LISTA"
2005:         THIS.CarregarLista()
2006:     ENDPROC
2007: 
2008:     *===========================================================================
2009:     * Destroy - Libera recursos ao fechar o formulario
2010:     *===========================================================================
2011:     PROCEDURE Destroy()
2012:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2013:             THIS.this_oBusinessObject = .NULL.
2014:         ENDIF
2015: 
2016:         IF USED("cursor_4c_Dados")
2017:             USE IN cursor_4c_Dados
2018:         ENDIF
2019: 
2020:         IF USED("cursor_4c_BuscaProduto")
2021:             USE IN cursor_4c_BuscaProduto
2022:         ENDIF
2023: 
2024:         IF USED("cursor_4c_GrdCompo")
2025:             USE IN cursor_4c_GrdCompo
2026:         ENDIF
2027:         IF USED("cursor_4c_GrdSubCp")
2028:             USE IN cursor_4c_GrdSubCp
2029:         ENDIF
2030:         IF USED("cursor_4c_GrdRelogios")
2031:             USE IN cursor_4c_GrdRelogios
2032:         ENDIF
2033:         IF USED("TotGrupo")
2034:             USE IN TotGrupo
2035:         ENDIF
2036: 
2037:         IF USED("cursor_4c_GrdConsP")
2038:             USE IN cursor_4c_GrdConsP
2039:         ENDIF
2040:         IF USED("cursor_4c_GrDTEMP")
2041:             USE IN cursor_4c_GrDTEMP
2042:         ENDIF
2043:         IF USED("cursor_4c_GradFase")
2044:             USE IN cursor_4c_GradFase
2045:         ENDIF
2046:         IF USED("cursor_4c_GrdMatrizes")
2047:             USE IN cursor_4c_GrdMatrizes
2048:         ENDIF
2049:         IF USED("cursor_4c_TotGrupo2")
2050:             USE IN cursor_4c_TotGrupo2
2051:         ENDIF
2052: 
2053:         IF USED("cursor_4c_GrdServico")
2054:             USE IN cursor_4c_GrdServico
2055:         ENDIF
2056: 
2057:         DODEFAULT()
2058:     ENDPROC
2059: 
2060:     *===========================================================================
2061:     * CarregarDescricoes - Popula campos de descricao lookup (silencioso, sem dialog)
2062:     * Chamado de BOParaForm para carregar descricoes ao exibir registro existente
2063:     *===========================================================================
2064:     PROTECTED PROCEDURE CarregarDescricoes()
2065:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2066:         TRY
2067:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2068: 
2069:             *-- Grupo (SigCdGrp: cgrus/dgrus)
2070:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2071:             IF !EMPTY(loc_cCod)
2072:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2073:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
2074:                     "cursor_4c_LkpDesc")
2075:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2076:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpDesc.dgrus)
2077:                 ENDIF
2078:                 IF USED("cursor_4c_LkpDesc")
2079:                     USE IN cursor_4c_LkpDesc
2080:                 ENDIF
2081:             ENDIF
2082: 
2083:             *-- Linha (SigCdLin: linhas/descs)
2084:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
2085:             IF !EMPTY(loc_cCod)
2086:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2087:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
2088:                     "cursor_4c_LkpDesc")
2089:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2090:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
2091:                 ENDIF
2092:                 IF USED("cursor_4c_LkpDesc")
2093:                     USE IN cursor_4c_LkpDesc
2094:                 ENDIF
2095:             ENDIF
2096: 
2097:             *-- Colecao/Grupo de Venda (SigCdCol: colecoes/descs)
2098:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
2099:             IF !EMPTY(loc_cCod)
2100:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2101:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
2102:                     "cursor_4c_LkpDesc")
2103:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
2104:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpDesc.descs)

*-- Linhas 2163 a 2206:
2163:     * CarregarDescricoesFiscais - Popula campos descricao da aba Dados Fiscais
2164:     * Chamado de BOParaForm ao exibir registro existente
2165:     *===========================================================================
2166:     PROTECTED PROCEDURE CarregarDescricoesFiscais()
2167:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2168:         TRY
2169:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
2170:             IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
2171:                 RETURN
2172:             ENDIF
2173: 
2174:             *-- Classificacao Fiscal (SigCdClf: codigos/descricaos)
2175:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
2176:             IF !EMPTY(loc_cCod)
2177:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2178:                     "SELECT descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
2179:                     "cursor_4c_LkpFiscDesc")
2180:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2181:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
2182:                 ENDIF
2183:                 IF USED("cursor_4c_LkpFiscDesc")
2184:                     USE IN cursor_4c_LkpFiscDesc
2185:                 ENDIF
2186:             ENDIF
2187: 
2188:             *-- Origem Mercadoria (SIGCDORG: codigos/descricaos)
2189:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
2190:             IF !EMPTY(loc_cCod)
2191:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2192:                     "SELECT descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
2193:                     "cursor_4c_LkpFiscDesc")
2194:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
2195:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
2196:                 ENDIF
2197:                 IF USED("cursor_4c_LkpFiscDesc")
2198:                     USE IN cursor_4c_LkpFiscDesc
2199:                 ENDIF
2200:             ENDIF
2201: 
2202:             *-- Situacao Tributaria ICMS (SIGCDICM: codigos/descricaos)
2203:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
2204:             IF !EMPTY(loc_cCod)
2205:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2206:                     "SELECT descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;

*-- Linhas 2255 a 2834:
2255:     *===========================================================================
2256:     * ValidarCampos - Valida campos obrigatorios antes de salvar
2257:     *===========================================================================
2258:     PROTECTED PROCEDURE ValidarCampos()
2259:         LOCAL loc_oPg, loc_lValido, loException
2260:         loc_lValido = .F.
2261:         TRY
2262:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2263: 
2264:             IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cpros.Value))
2265:                 MsgAviso("C" + CHR(243) + "digo do produto " + CHR(233) + " obrigat" + CHR(243) + "rio!")
2266:                 loc_oPg.txt_4c_Cpros.SetFocus()
2267:             ELSE
2268:                 IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Dpros.Value))
2269:                     MsgAviso("Descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria!")
2270:                     loc_oPg.txt_4c_Dpros.SetFocus()
2271:                 ELSE
2272:                     loc_lValido = .T.
2273:                 ENDIF
2274:             ENDIF
2275:         CATCH TO loException
2276:             MostrarErro("Erro ao validar campos:" + CHR(13) + loException.Message, ;
2277:                 "FormProduto.ValidarCampos")
2278:         ENDTRY
2279:         RETURN loc_lValido
2280:     ENDPROC
2281: 
2282:     *===========================================================================
2283:     * TxtCgrusKeyPress - F4 abre busca de grupo
2284:     * PUBLIC: BINDEVENT requer metodo publico
2285:     * KeyDown nao e bindavel via BINDEVENT em VFP9 - usar KeyPress
2286:     * F4 em KeyPress: par_nKeyCode = 0 (teclas de funcao nao tem ASCII)
2287:     *===========================================================================
2288:     PROCEDURE TxtCgrusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2289:         IF par_nKeyCode = 0
2290:             THIS.AbrirBuscaGrupo()
2291:         ENDIF
2292:     ENDPROC
2293: 
2294:     *===========================================================================
2295:     * TxtIforsKeyPress - F4 abre busca de fornecedor
2296:     * PUBLIC: BINDEVENT requer metodo publico
2297:     * KeyDown nao e bindavel via BINDEVENT em VFP9 - usar KeyPress
2298:     *===========================================================================
2299:     PROCEDURE TxtIforsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2300:         IF par_nKeyCode = 0
2301:             THIS.AbrirBuscaFornecedor()
2302:         ENDIF
2303:     ENDPROC
2304: 
2305:     *===========================================================================
2306:     * ValidarCgrus - LostFocus: valida cgrus e popula dgrus (SigCdGrp)
2307:     * PUBLIC: BINDEVENT requer metodo publico
2308:     *===========================================================================
2309:     PROCEDURE ValidarCgrus(par_nKeyCode, par_nShiftAltCtrl)
2310:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2311:         TRY
2312:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2313:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2314: 
2315:             IF EMPTY(loc_cCod)
2316:                 loc_oPg.txt_4c_Dgrus.Value = ""
2317:             ELSE
2318:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2319:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
2320:                     "cursor_4c_LkpCgrus")
2321: 
2322:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCgrus") AND !EOF("cursor_4c_LkpCgrus")
2323:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpCgrus.dgrus)
2324:                     USE IN cursor_4c_LkpCgrus
2325:                 ELSE
2326:                     IF USED("cursor_4c_LkpCgrus")
2327:                         USE IN cursor_4c_LkpCgrus
2328:                     ENDIF
2329:                     loc_oPg.txt_4c_Cgrus.Value = ""
2330:                     loc_oPg.txt_4c_Dgrus.Value = ""
2331:                     THIS.AbrirBuscaGrupo()
2332:                 ENDIF
2333:             ENDIF
2334: 
2335:         CATCH TO loException
2336:             IF USED("cursor_4c_LkpCgrus")
2337:                 USE IN cursor_4c_LkpCgrus
2338:             ENDIF
2339:             MostrarErro("Erro ao validar grupo:" + CHR(13) + loException.Message, ;
2340:                 "FormProduto.ValidarCgrus")
2341:         ENDTRY
2342:     ENDPROC
2343: 
2344:     *===========================================================================
2345:     * ValidarSGrus - LostFocus: sgrus sem tabela de descricao, apenas aceita valor
2346:     * PUBLIC: BINDEVENT requer metodo publico
2347:     *===========================================================================
2348:     PROCEDURE ValidarSGrus(par_nKeyCode, par_nShiftAltCtrl)
2349:         LOCAL loc_oPg
2350:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2351:         loc_oPg.txt_4c_DsGrus.Value = ""
2352:     ENDPROC
2353: 
2354:     *===========================================================================
2355:     * ValidarLinhas - LostFocus: valida linhas e popula DLinhas (SigCdLin)
2356:     * PUBLIC: BINDEVENT requer metodo publico
2357:     *===========================================================================
2358:     PROCEDURE ValidarLinhas(par_nKeyCode, par_nShiftAltCtrl)
2359:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2360:         TRY
2361:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2362:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
2363: 
2364:             IF EMPTY(loc_cCod)
2365:                 loc_oPg.txt_4c_DLinhas.Value = ""
2366:             ELSE
2367:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2368:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
2369:                     "cursor_4c_LkpLinha")
2370: 
2371:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpLinha") AND !EOF("cursor_4c_LkpLinha")
2372:                     loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpLinha.descs)
2373:                     USE IN cursor_4c_LkpLinha
2374:                 ELSE
2375:                     IF USED("cursor_4c_LkpLinha")
2376:                         USE IN cursor_4c_LkpLinha
2377:                     ENDIF
2378:                     loc_oPg.txt_4c_Linhas.Value  = ""
2379:                     loc_oPg.txt_4c_DLinhas.Value = ""
2380:                     MsgAviso("Linha n" + CHR(227) + "o encontrada.")
2381:                 ENDIF
2382:             ENDIF
2383: 
2384:         CATCH TO loException
2385:             IF USED("cursor_4c_LkpLinha")
2386:                 USE IN cursor_4c_LkpLinha
2387:             ENDIF
2388:             MostrarErro("Erro ao validar linha:" + CHR(13) + loException.Message, ;
2389:                 "FormProduto.ValidarLinhas")
2390:         ENDTRY
2391:     ENDPROC
2392: 
2393:     *===========================================================================
2394:     * ValidarColecoes - LostFocus: valida colecao e popula DColecoes (SigCdCol)
2395:     * PUBLIC: BINDEVENT requer metodo publico
2396:     *===========================================================================
2397:     PROCEDURE ValidarColecoes(par_nKeyCode, par_nShiftAltCtrl)
2398:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2399:         TRY
2400:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2401:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
2402: 
2403:             IF EMPTY(loc_cCod)
2404:                 loc_oPg.txt_4c_DColecoes.Value = ""
2405:             ELSE
2406:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2407:                     "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
2408:                     "cursor_4c_LkpColecao")
2409: 
2410:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpColecao") AND !EOF("cursor_4c_LkpColecao")
2411:                     loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpColecao.descs)
2412:                     USE IN cursor_4c_LkpColecao
2413:                 ELSE
2414:                     IF USED("cursor_4c_LkpColecao")
2415:                         USE IN cursor_4c_LkpColecao
2416:                     ENDIF
2417:                     loc_oPg.txt_4c_Colecoes.Value  = ""
2418:                     loc_oPg.txt_4c_DColecoes.Value = ""
2419:                     MsgAviso("Grupo de venda n" + CHR(227) + "o encontrado.")
2420:                 ENDIF
2421:             ENDIF
2422: 
2423:         CATCH TO loException
2424:             IF USED("cursor_4c_LkpColecao")
2425:                 USE IN cursor_4c_LkpColecao
2426:             ENDIF
2427:             MostrarErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
2428:                 loException.Message, "FormProduto.ValidarColecoes")
2429:         ENDTRY
2430:     ENDPROC
2431: 
2432:     *===========================================================================
2433:     * ValidarIfors - LostFocus: valida fornecedor e popula Dfors (SigCdFor)
2434:     * PUBLIC: BINDEVENT requer metodo publico
2435:     *===========================================================================
2436:     PROCEDURE ValidarIfors(par_nKeyCode, par_nShiftAltCtrl)
2437:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2438:         TRY
2439:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2440:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2441: 
2442:             IF EMPTY(loc_cCod)
2443:                 loc_oPg.txt_4c_Dfors.Value = ""
2444:             ELSE
2445:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2446:                     "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
2447:                     "cursor_4c_LkpForn")
2448: 
2449:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpForn") AND !EOF("cursor_4c_LkpForn")
2450:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpForn.dfors)
2451:                     USE IN cursor_4c_LkpForn
2452:                 ELSE
2453:                     IF USED("cursor_4c_LkpForn")
2454:                         USE IN cursor_4c_LkpForn
2455:                     ENDIF
2456:                     loc_oPg.txt_4c_Ifors.Value = ""
2457:                     loc_oPg.txt_4c_Dfors.Value = ""
2458:                     THIS.AbrirBuscaFornecedor()
2459:                 ENDIF
2460:             ENDIF
2461: 
2462:         CATCH TO loException
2463:             IF USED("cursor_4c_LkpForn")
2464:                 USE IN cursor_4c_LkpForn
2465:             ENDIF
2466:             MostrarErro("Erro ao validar fornecedor:" + CHR(13) + loException.Message, ;
2467:                 "FormProduto.ValidarIfors")
2468:         ENDTRY
2469:     ENDPROC
2470: 
2471:     *===========================================================================
2472:     * ValidarCodCors - LostFocus: valida codigo de cor (SigCdCor)
2473:     * PUBLIC: BINDEVENT requer metodo publico
2474:     *===========================================================================
2475:     PROCEDURE ValidarCodCors(par_nKeyCode, par_nShiftAltCtrl)
2476:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2477:         TRY
2478:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2479:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)
2480: 
2481:             IF !EMPTY(loc_cCod)
2482:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2483:                     "SELECT cods FROM SigCdCor WHERE cods = " + EscaparSQL(loc_cCod), ;
2484:                     "cursor_4c_LkpCor")
2485: 
2486:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpCor") AND !EOF("cursor_4c_LkpCor")
2487:                     USE IN cursor_4c_LkpCor
2488:                 ELSE
2489:                     IF USED("cursor_4c_LkpCor")
2490:                         USE IN cursor_4c_LkpCor
2491:                     ENDIF
2492:                     loc_oPg.txt_4c_CodCors.Value = ""
2493:                     MsgAviso("Cor n" + CHR(227) + "o encontrada.")
2494:                 ENDIF
2495:             ENDIF
2496: 
2497:         CATCH TO loException
2498:             IF USED("cursor_4c_LkpCor")
2499:                 USE IN cursor_4c_LkpCor
2500:             ENDIF
2501:             MostrarErro("Erro ao validar cor:" + CHR(13) + loException.Message, ;
2502:                 "FormProduto.ValidarCodCors")
2503:         ENDTRY
2504:     ENDPROC
2505: 
2506:     *===========================================================================
2507:     * ValidarCodTams - LostFocus: valida codigo de tamanho (SigCdTam)
2508:     * PUBLIC: BINDEVENT requer metodo publico
2509:     *===========================================================================
2510:     PROCEDURE ValidarCodTams(par_nKeyCode, par_nShiftAltCtrl)
2511:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2512:         TRY
2513:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2514:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
2515: 
2516:             IF !EMPTY(loc_cCod)
2517:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2518:                     "SELECT cods FROM SigCdTam WHERE cods = " + EscaparSQL(loc_cCod), ;
2519:                     "cursor_4c_LkpTam")
2520: 
2521:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpTam") AND !EOF("cursor_4c_LkpTam")
2522:                     USE IN cursor_4c_LkpTam
2523:                 ELSE
2524:                     IF USED("cursor_4c_LkpTam")
2525:                         USE IN cursor_4c_LkpTam
2526:                     ENDIF
2527:                     loc_oPg.txt_4c_CodTams.Value = ""
2528:                     MsgAviso("Tamanho n" + CHR(227) + "o encontrado.")
2529:                 ENDIF
2530:             ENDIF
2531: 
2532:         CATCH TO loException
2533:             IF USED("cursor_4c_LkpTam")
2534:                 USE IN cursor_4c_LkpTam
2535:             ENDIF
2536:             MostrarErro("Erro ao validar tamanho:" + CHR(13) + loException.Message, ;
2537:                 "FormProduto.ValidarCodTams")
2538:         ENDTRY
2539:     ENDPROC
2540: 
2541:     *===========================================================================
2542:     * ValidarCodAcbs - LostFocus: valida acabamento e popula DAcbs (SigCdAca)
2543:     * PUBLIC: BINDEVENT requer metodo publico
2544:     *===========================================================================
2545:     PROCEDURE ValidarCodAcbs(par_nKeyCode, par_nShiftAltCtrl)
2546:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2547:         TRY
2548:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2549:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
2550: 
2551:             IF EMPTY(loc_cCod)
2552:                 loc_oPg.txt_4c_DAcbs.Value = ""
2553:             ELSE
2554:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2555:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
2556:                     "cursor_4c_LkpAcab")
2557: 
2558:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpAcab") AND !EOF("cursor_4c_LkpAcab")
2559:                     loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpAcab.descrs)
2560:                     USE IN cursor_4c_LkpAcab
2561:                 ELSE
2562:                     IF USED("cursor_4c_LkpAcab")
2563:                         USE IN cursor_4c_LkpAcab
2564:                     ENDIF
2565:                     loc_oPg.txt_4c_CodAcbs.Value = ""
2566:                     loc_oPg.txt_4c_DAcbs.Value   = ""
2567:                     MsgAviso("Acabamento n" + CHR(227) + "o encontrado.")
2568:                 ENDIF
2569:             ENDIF
2570: 
2571:         CATCH TO loException
2572:             IF USED("cursor_4c_LkpAcab")
2573:                 USE IN cursor_4c_LkpAcab
2574:             ENDIF
2575:             MostrarErro("Erro ao validar acabamento:" + CHR(13) + loException.Message, ;
2576:                 "FormProduto.ValidarCodAcbs")
2577:         ENDTRY
2578:     ENDPROC
2579: 
2580:     *===========================================================================
2581:     * ValidarCunis - LostFocus: valida unidade e popula Dunis (SigCdUni)
2582:     * PUBLIC: BINDEVENT requer metodo publico
2583:     *===========================================================================
2584:     PROCEDURE ValidarCunis(par_nKeyCode, par_nShiftAltCtrl)
2585:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
2586:         TRY
2587:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2588:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
2589: 
2590:             IF EMPTY(loc_cCod)
2591:                 loc_oPg.txt_4c_Dunis.Value = ""
2592:             ELSE
2593:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2594:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
2595:                     "cursor_4c_LkpUni")
2596: 
2597:                 IF loc_nRet > 0 AND USED("cursor_4c_LkpUni") AND !EOF("cursor_4c_LkpUni")
2598:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpUni.dunis)
2599:                     USE IN cursor_4c_LkpUni
2600:                 ELSE
2601:                     IF USED("cursor_4c_LkpUni")
2602:                         USE IN cursor_4c_LkpUni
2603:                     ENDIF
2604:                     loc_oPg.txt_4c_Cunis.Value = ""
2605:                     loc_oPg.txt_4c_Dunis.Value = ""
2606:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada.")
2607:                 ENDIF
2608:             ENDIF
2609: 
2610:         CATCH TO loException
2611:             IF USED("cursor_4c_LkpUni")
2612:                 USE IN cursor_4c_LkpUni
2613:             ENDIF
2614:             MostrarErro("Erro ao validar unidade:" + CHR(13) + loException.Message, ;
2615:                 "FormProduto.ValidarCunis")
2616:         ENDTRY
2617:     ENDPROC
2618: 
2619:     *===========================================================================
2620:     * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para selecionar grupo (SigCdGrp)
2621:     * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
2622:     *===========================================================================
2623:     PROCEDURE AbrirBuscaGrupo()
2624:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
2625:         TRY
2626:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2627:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
2628: 
2629:             loc_nRet = SQLEXEC(gnConnHandle, ;
2630:                 "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus LIKE '" + ;
2631:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cgrus", ;
2632:                 "cursor_4c_GrpBusca")
2633: 
2634:             IF loc_nRet <= 0 OR !USED("cursor_4c_GrpBusca") OR EOF("cursor_4c_GrpBusca")
2635:                 IF USED("cursor_4c_GrpBusca")
2636:                     USE IN cursor_4c_GrpBusca
2637:                 ENDIF
2638:                 SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", ;
2639:                     "cursor_4c_GrpBusca")
2640:             ENDIF
2641: 
2642:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2643:             IF VARTYPE(loc_oBusca) = "O"
2644:                 loc_oBusca.this_cCursorDestino = "cursor_4c_GrpBusca"
2645:                 loc_oBusca.DefinirCursor("cursor_4c_GrpBusca", "cgrus", "dgrus", ;
2646:                     "Buscar Grupo de Produto")
2647:                 loc_oBusca.Mostrar()
2648: 
2649:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2650:                     loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2651:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2652:                 ENDIF
2653:                 loc_oBusca = .NULL.
2654:             ENDIF
2655: 
2656:             IF USED("cursor_4c_GrpBusca")
2657:                 USE IN cursor_4c_GrpBusca
2658:             ENDIF
2659: 
2660:         CATCH TO loException
2661:             IF USED("cursor_4c_GrpBusca")
2662:                 USE IN cursor_4c_GrpBusca
2663:             ENDIF
2664:             MostrarErro("Erro ao buscar grupo:" + CHR(13) + loException.Message, ;
2665:                 "FormProduto.AbrirBuscaGrupo")
2666:         ENDTRY
2667:     ENDPROC
2668: 
2669:     *===========================================================================
2670:     * AbrirBuscaFornecedor - Abre FormBuscaAuxiliar para selecionar fornecedor
2671:     * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
2672:     *===========================================================================
2673:     PROCEDURE AbrirBuscaFornecedor()
2674:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
2675:         TRY
2676:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2677:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
2678: 
2679:             loc_nRet = SQLEXEC(gnConnHandle, ;
2680:                 "SELECT ifors, dfors FROM SigCdFor WHERE ifors LIKE '" + ;
2681:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY dfors", ;
2682:                 "cursor_4c_FornBusca")
2683: 
2684:             IF loc_nRet <= 0 OR !USED("cursor_4c_FornBusca") OR EOF("cursor_4c_FornBusca")
2685:                 IF USED("cursor_4c_FornBusca")
2686:                     USE IN cursor_4c_FornBusca
2687:                 ENDIF
2688:                 SQLEXEC(gnConnHandle, "SELECT ifors, dfors FROM SigCdFor ORDER BY dfors", ;
2689:                     "cursor_4c_FornBusca")
2690:             ENDIF
2691: 
2692:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2693:             IF VARTYPE(loc_oBusca) = "O"
2694:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FornBusca"
2695:                 loc_oBusca.DefinirCursor("cursor_4c_FornBusca", "ifors", "dfors", ;
2696:                     "Buscar Fornecedor")
2697:                 loc_oBusca.Mostrar()
2698: 
2699:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
2700:                     loc_oPg.txt_4c_Ifors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2701:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
2702:                 ENDIF
2703:                 loc_oBusca = .NULL.
2704:             ENDIF
2705: 
2706:             IF USED("cursor_4c_FornBusca")
2707:                 USE IN cursor_4c_FornBusca
2708:             ENDIF
2709: 
2710:         CATCH TO loException
2711:             IF USED("cursor_4c_FornBusca")
2712:                 USE IN cursor_4c_FornBusca
2713:             ENDIF
2714:             MostrarErro("Erro ao buscar fornecedor:" + CHR(13) + loException.Message, ;
2715:                 "FormProduto.AbrirBuscaFornecedor")
2716:         ENDTRY
2717:     ENDPROC
2718: 
2719:     *===========================================================================
2720:     * OptSituacaoInteractiveChange - Atualiza DtSituas ao mudar Situacao
2721:     * PUBLIC: BINDEVENT requer metodo publico
2722:     *===========================================================================
2723:     PROCEDURE OptSituacaoInteractiveChange()
2724:         LOCAL loc_oPg, loException
2725:         TRY
2726:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2727:             IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
2728:                 loc_oPg.txt_4c_DtSituas.Value = DATE()
2729:             ENDIF
2730:         CATCH TO loException
2731:             MostrarErro("Erro ao atualizar data da situa" + CHR(231) + CHR(227) + "o:" + ;
2732:                 CHR(13) + loException.Message, "FormProduto.OptSituacaoInteractiveChange")
2733:         ENDTRY
2734:     ENDPROC
2735: 
2736:     *===========================================================================
2737:     * OptProdvarsInteractiveChange - Propaga variacao e-commerce para BO
2738:     * PUBLIC: BINDEVENT requer metodo publico
2739:     *===========================================================================
2740:     PROCEDURE OptProdvarsInteractiveChange()
2741:         LOCAL loc_oPg, loException
2742:         TRY
2743:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
2744:             IF PEMSTATUS(loc_oPg, "opt_4c_Prodvars", 5) AND VARTYPE(THIS.this_oBusinessObject) = "O"
2745:                 THIS.this_oBusinessObject.this_nProdvars = loc_oPg.opt_4c_Prodvars.Value
2746:             ENDIF
2747:         CATCH TO loException
2748:             MostrarErro("Erro ao atualizar Prodvars:" + CHR(13) + loException.Message, ;
2749:                 "FormProduto.OptProdvarsInteractiveChange")
2750:         ENDTRY
2751:     ENDPROC
2752: 
2753:     *===========================================================================
2754:     * ConfigurarPgpgDadosFiscais - Configura Page3 "Dados Fiscais" do pgf_4c_Dados
2755:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais
2756:     * 64 objetos: labels, textboxes, editbox, combobox, optiongroup, grid, button
2757:     *===========================================================================
2758:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais(par_oPg)
2759:         LOCAL loc_oPg, loc_oGrid, loc_oErro
2760:         TRY
2761:             loc_oPg = par_oPg
2762:             loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
2763: 
2764:             *-- Cursor placeholder para grd_4c_Cmv (RecordSource = TotGrupo2)
2765:             IF !USED("cursor_4c_TotGrupo2")
2766:                 SET NULL ON
2767:                 CREATE CURSOR cursor_4c_TotGrupo2 ( ;
2768:                     Grupo    C(3), ValGrupo N(12,3), Moeda C(3), Estimado N(1,0))
2769:                 SET NULL OFF
2770:             ENDIF
2771: 
2772:             *====================================================================
2773:             *  SECAO: Configuracao / Tipo produto (topo)
2774:             *====================================================================
2775: 
2776:             *-- lbl_4c_Label29: "Configuracao :" (Say29, top=128, left=129)
2777:             loc_oPg.AddObject("lbl_4c_Label29", "Label")
2778:             WITH loc_oPg.lbl_4c_Label29
2779:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o :"
2780:                 .Top       = 128
2781:                 .Left      = 129
2782:                 .Width     = 73
2783:                 .Height    = 15
2784:                 .FontName  = "Tahoma"
2785:                 .FontSize  = 8
2786:                 .ForeColor = RGB(90, 90, 90)
2787:                 .BackStyle = 0
2788:                 .AutoSize  = .T.
2789:                 .Visible   = .T.
2790:             ENDWITH
2791: 
2792:             *-- obj_4c_Fwoption1: OptionGroup "Importado / Nacional" (Fwoption1, top=123, left=204)
2793:             *-- ControlSource: TpCodPro (nao existe no schema atual - UI-only)
2794:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
2795:             WITH loc_oPg.obj_4c_Fwoption1
2796:                 .ButtonCount  = 2
2797:                 .Top          = 123
2798:                 .Left         = 204
2799:                 .Width        = 151
2800:                 .Height       = 24
2801:                 .BackStyle    = 0
2802:                 .BorderStyle  = 0
2803:                 .Value        = 1
2804:                 .AutoSize     = .F.
2805:                 .Visible      = .T.
2806: 
2807:                 .Buttons(1).Caption   = "Importado"
2808:                 .Buttons(1).FontName  = "Tahoma"
2809:                 .Buttons(1).FontSize  = 8
2810:                 .Buttons(1).ForeColor = RGB(90, 90, 90)
2811:                 .Buttons(1).BackStyle = 0
2812:                 .Buttons(1).Left      = 5
2813:                 .Buttons(1).Top       = 5
2814:                 .Buttons(1).Height    = 15
2815:                 .Buttons(1).AutoSize  = .T.
2816: 
2817:                 .Buttons(2).Caption   = "Nacional"
2818:                 .Buttons(2).FontName  = "Tahoma"
2819:                 .Buttons(2).FontSize  = 8
2820:                 .Buttons(2).ForeColor = RGB(90, 90, 90)
2821:                 .Buttons(2).BackStyle = 0
2822:                 .Buttons(2).Left      = 86
2823:                 .Buttons(2).Top       = 5
2824:                 .Buttons(2).Height    = 15
2825:                 .Buttons(2).AutoSize  = .T.
2826:             ENDWITH
2827: 
2828:             *====================================================================
2829:             *  SECAO: Codigo Importado / Nacional / DCR
2830:             *====================================================================
2831: 
2832:             *-- lbl_4c_Label14: "Codigo Importado :" (Say14, top=154, left=107)
2833:             loc_oPg.AddObject("lbl_4c_Label14", "Label")
2834:             WITH loc_oPg.lbl_4c_Label14

*-- Linhas 2976 a 3260:
2976:                 .SpecialEffect = 1
2977:                 .Visible       = .T.
2978:             ENDWITH
2979:             BINDEVENT(loc_oPg.txt_4c__gruccus, "LostFocus",    THIS, "TxtGruccusValid")
2980:             BINDEVENT(loc_oPg.txt_4c__gruccus, "KeyPress", THIS, "TxtGruccusKeyPress")
2981: 
2982:             *-- txt_4c__dgruccus: Descricao Grupo CC (get_dgruccus, top=225, left=288)
2983:             loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
2984:             WITH loc_oPg.txt_4c__dgruccus
2985:                 .Top           = 225
2986:                 .Left          = 288
2987:                 .Width         = 318
2988:                 .Height        = 23
2989:                 .FontName      = "Tahoma"
2990:                 .FontSize      = 8
2991:                 .SpecialEffect = 1
2992:                 .Visible       = .T.
2993:             ENDWITH
2994:             BINDEVENT(loc_oPg.txt_4c__dgruccus, "When",    THIS, "TxtDgruccusWhen")
2995:             BINDEVENT(loc_oPg.txt_4c__dgruccus, "LostFocus",   THIS, "TxtDgruccusValid")
2996:             BINDEVENT(loc_oPg.txt_4c__dgruccus, "KeyPress",THIS, "TxtDgruccusKeyPress")
2997: 
2998:             *-- lbl_4c_Label17: "Conta C.C. :" (Say17, top=253, left=139)
2999:             loc_oPg.AddObject("lbl_4c_Label17", "Label")
3000:             WITH loc_oPg.lbl_4c_Label17
3001:                 .Caption   = "Conta C.C. :"
3002:                 .Top       = 253
3003:                 .Left      = 139
3004:                 .Width     = 63
3005:                 .Height    = 15
3006:                 .FontName  = "Tahoma"
3007:                 .FontSize  = 8
3008:                 .ForeColor = RGB(90, 90, 90)
3009:                 .BackStyle = 0
3010:                 .AutoSize  = .T.
3011:                 .Visible   = .T.
3012:             ENDWITH
3013: 
3014:             *-- txt_4c__contaccus: Conta CC (get_contaccus, top=250, left=206)
3015:             loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
3016:             WITH loc_oPg.txt_4c__contaccus
3017:                 .Top           = 250
3018:                 .Left          = 206
3019:                 .Width         = 80
3020:                 .Height        = 23
3021:                 .FontName      = "Tahoma"
3022:                 .FontSize      = 8
3023:                 .SpecialEffect = 1
3024:                 .Visible       = .T.
3025:             ENDWITH
3026:             BINDEVENT(loc_oPg.txt_4c__contaccus, "When",    THIS, "TxtContaccusWhen")
3027:             BINDEVENT(loc_oPg.txt_4c__contaccus, "LostFocus",   THIS, "TxtContaccusValid")
3028:             BINDEVENT(loc_oPg.txt_4c__contaccus, "KeyPress",THIS, "TxtContaccusKeyPress")
3029: 
3030:             *-- txt_4c__dcontaccus: Descricao Conta CC (get_dcontaccus, top=250, left=288)
3031:             loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
3032:             WITH loc_oPg.txt_4c__dcontaccus
3033:                 .Top           = 250
3034:                 .Left          = 288
3035:                 .Width         = 318
3036:                 .Height        = 23
3037:                 .FontName      = "Tahoma"
3038:                 .FontSize      = 8
3039:                 .SpecialEffect = 1
3040:                 .Visible       = .T.
3041:             ENDWITH
3042:             BINDEVENT(loc_oPg.txt_4c__dcontaccus, "When",    THIS, "TxtDcontaccusWhen")
3043:             BINDEVENT(loc_oPg.txt_4c__dcontaccus, "LostFocus",   THIS, "TxtDcontaccusValid")
3044:             BINDEVENT(loc_oPg.txt_4c__dcontaccus, "KeyPress",THIS, "TxtDcontaccusKeyPress")
3045: 
3046:             *====================================================================
3047:             *  SECAO: Classificacao Fiscal / Origem Mercadoria / ICMS
3048:             *====================================================================
3049: 
3050:             *-- lbl_4c_Label1: "Classificacao Fiscal :" (Say1, top=280, left=103)
3051:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
3052:             WITH loc_oPg.lbl_4c_Label1
3053:                 .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
3054:                 .Top       = 280
3055:                 .Left      = 103
3056:                 .Width     = 99
3057:                 .FontName  = "Tahoma"
3058:                 .FontSize  = 8
3059:                 .ForeColor = RGB(90, 90, 90)
3060:                 .BackStyle = 0
3061:                 .AutoSize  = .T.
3062:                 .Visible   = .T.
3063:             ENDWITH
3064: 
3065:             *-- txt_4c_Clfiscal: Classificacao Fiscal (getClfiscal, top=275, left=206)
3066:             loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
3067:             WITH loc_oPg.txt_4c_Clfiscal
3068:                 .Top           = 275
3069:                 .Left          = 206
3070:                 .Width         = 94
3071:                 .Height        = 23
3072:                 .FontName      = "Tahoma"
3073:                 .FontSize      = 8
3074:                 .SpecialEffect = 1
3075:                 .MaxLength     = 10
3076:                 .Visible       = .T.
3077:             ENDWITH
3078:             BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress",    THIS, "ValidarClfiscal")
3079:             BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TxtClfiscalKeyPress")
3080: 
3081:             *-- txt_4c_Dclfiscal: Descricao Classificacao Fiscal (getDclfiscal, top=275, left=303)
3082:             loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
3083:             WITH loc_oPg.txt_4c_Dclfiscal
3084:                 .Top           = 275
3085:                 .Left          = 303
3086:                 .Width         = 303
3087:                 .Height        = 23
3088:                 .FontName      = "Tahoma"
3089:                 .FontSize      = 8
3090:                 .SpecialEffect = 1
3091:                 .Visible       = .T.
3092:             ENDWITH
3093:             BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "When",    THIS, "TxtDclfiscalWhen")
3094:             BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress",   THIS, "ValidarDclfiscal")
3095:             BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress",THIS, "TxtDclfiscalKeyPress")
3096: 
3097:             *-- lbl_4c_Label2: "Origem da Mercadoria :" (Say2, top=305, left=88)
3098:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
3099:             WITH loc_oPg.lbl_4c_Label2
3100:                 .Caption   = "Origem da Mercadoria :"
3101:                 .Top       = 305
3102:                 .Left      = 88
3103:                 .Width     = 114
3104:                 .FontName  = "Tahoma"
3105:                 .FontSize  = 8
3106:                 .ForeColor = RGB(90, 90, 90)
3107:                 .BackStyle = 0
3108:                 .AutoSize  = .T.
3109:                 .Visible   = .T.
3110:             ENDWITH
3111: 
3112:             *-- txt_4c_Origmerc: Origem Mercadoria (getOrigmerc, top=300, left=206)
3113:             loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
3114:             WITH loc_oPg.txt_4c_Origmerc
3115:                 .Top           = 300
3116:                 .Left          = 206
3117:                 .Width         = 17
3118:                 .Height        = 23
3119:                 .FontName      = "Tahoma"
3120:                 .FontSize      = 8
3121:                 .SpecialEffect = 1
3122:                 .MaxLength     = 1
3123:                 .Visible       = .T.
3124:             ENDWITH
3125:             BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress",    THIS, "ValidarOrigmerc")
3126:             BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress", THIS, "TxtOrigmercKeyPress")
3127: 
3128:             *-- txt_4c_Dorigmerc: Descricao Origem (getDorigmerc, top=300, left=226)
3129:             loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
3130:             WITH loc_oPg.txt_4c_Dorigmerc
3131:                 .Top           = 300
3132:                 .Left          = 226
3133:                 .Width         = 380
3134:                 .Height        = 23
3135:                 .FontName      = "Tahoma"
3136:                 .FontSize      = 8
3137:                 .SpecialEffect = 1
3138:                 .Visible       = .T.
3139:             ENDWITH
3140:             BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "When",    THIS, "TxtDorigmercWhen")
3141:             BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress",   THIS, "ValidarDorigmerc")
3142:             BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress",THIS, "TxtDorigmercKeyPress")
3143: 
3144:             *-- lbl_4c_Label3: "Situacao Tributaria ICMS :" (Say3, top=330, left=75)
3145:             loc_oPg.AddObject("lbl_4c_Label3", "Label")
3146:             WITH loc_oPg.lbl_4c_Label3
3147:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
3148:                 .Top       = 330
3149:                 .Left      = 75
3150:                 .Width     = 127
3151:                 .FontName  = "Tahoma"
3152:                 .FontSize  = 8
3153:                 .ForeColor = RGB(90, 90, 90)
3154:                 .BackStyle = 0
3155:                 .AutoSize  = .T.
3156:                 .Visible   = .T.
3157:             ENDWITH
3158: 
3159:             *-- txt_4c_Sittricm: Situacao Tributaria ICMS (getSittricm, top=325, left=206)
3160:             loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
3161:             WITH loc_oPg.txt_4c_Sittricm
3162:                 .Top           = 325
3163:                 .Left          = 206
3164:                 .Width         = 31
3165:                 .Height        = 23
3166:                 .FontName      = "Tahoma"
3167:                 .FontSize      = 8
3168:                 .SpecialEffect = 1
3169:                 .MaxLength     = 3
3170:                 .Visible       = .T.
3171:             ENDWITH
3172:             BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress",    THIS, "ValidarSittricm")
3173:             BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress", THIS, "TxtSittricmKeyPress")
3174: 
3175:             *-- txt_4c_Dsittricm: Descricao Situacao ICMS (getDsittricm, top=325, left=240)
3176:             loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
3177:             WITH loc_oPg.txt_4c_Dsittricm
3178:                 .Top           = 325
3179:                 .Left          = 240
3180:                 .Width         = 366
3181:                 .Height        = 23
3182:                 .FontName      = "Tahoma"
3183:                 .FontSize      = 8
3184:                 .SpecialEffect = 1
3185:                 .Visible       = .T.
3186:             ENDWITH
3187:             BINDEVENT(loc_oPg.txt_4c_Dsittricm, "When",    THIS, "TxtDsittricmWhen")
3188:             BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress",   THIS, "ValidarDsittricm")
3189:             BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress",THIS, "TxtDsittricmKeyPress")
3190: 
3191:             *-- lbl_4c_Label6: "Codigo de Servicos para ICMS :" (Say6, top=355, left=49)
3192:             loc_oPg.AddObject("lbl_4c_Label6", "Label")
3193:             WITH loc_oPg.lbl_4c_Label6
3194:                 .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
3195:                 .Top       = 355
3196:                 .Left      = 49
3197:                 .Width     = 153
3198:                 .FontName  = "Tahoma"
3199:                 .FontSize  = 8
3200:                 .ForeColor = RGB(90, 90, 90)
3201:                 .BackStyle = 0
3202:                 .AutoSize  = .T.
3203:                 .Visible   = .T.
3204:             ENDWITH
3205: 
3206:             *-- txt_4c_Codigo: Codigo Servicos (Get_CodServs, top=350, left=206)
3207:             loc_oPg.AddObject("txt_4c_Codigo", "TextBox")
3208:             WITH loc_oPg.txt_4c_Codigo
3209:                 .Top           = 350
3210:                 .Left          = 206
3211:                 .Width         = 38
3212:                 .Height        = 23
3213:                 .FontName      = "Tahoma"
3214:                 .FontSize      = 8
3215:                 .SpecialEffect = 1
3216:                 .MaxLength     = 4
3217:                 .Visible       = .T.
3218:             ENDWITH
3219:             BINDEVENT(loc_oPg.txt_4c_Codigo, "KeyPress",    THIS, "ValidarCodServsFiscal")
3220:             BINDEVENT(loc_oPg.txt_4c_Codigo, "KeyPress", THIS, "TxtCodServsFiscalKeyPress")
3221: 
3222:             *-- lbl_4c_Label8: "Aliquota ICMS :" (Say8, top=355, left=263)
3223:             loc_oPg.AddObject("lbl_4c_Label8", "Label")
3224:             WITH loc_oPg.lbl_4c_Label8
3225:                 .Caption   = "Al" + CHR(237) + "quota ICMS :"
3226:                 .Top       = 355
3227:                 .Left      = 263
3228:                 .Width     = 76
3229:                 .Height    = 15
3230:                 .FontName  = "Tahoma"
3231:                 .FontSize  = 8
3232:                 .ForeColor = RGB(90, 90, 90)
3233:                 .BackStyle = 0
3234:                 .AutoSize  = .T.
3235:                 .Visible   = .T.
3236:             ENDWITH
3237: 
3238:             *-- txt_4c_Icms: Aliquota ICMS (getIcms, top=350, left=342)
3239:             loc_oPg.AddObject("txt_4c_Icms", "TextBox")
3240:             WITH loc_oPg.txt_4c_Icms
3241:                 .Top           = 350
3242:                 .Left          = 342
3243:                 .Width         = 45
3244:                 .Height        = 23
3245:                 .FontName      = "Tahoma"
3246:                 .FontSize      = 8
3247:                 .SpecialEffect = 1
3248:                 .InputMask     = "99.99"
3249:                 .Value         = 0
3250:                 .Visible       = .T.
3251:             ENDWITH
3252: 
3253:             *-- lbl_4c_Label4: "Tipo de Tributacao :" (Say4, top=355, left=411)
3254:             loc_oPg.AddObject("lbl_4c_Label4", "Label")
3255:             WITH loc_oPg.lbl_4c_Label4
3256:                 .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
3257:                 .Top       = 355
3258:                 .Left      = 411
3259:                 .Width     = 98
3260:                 .FontName  = "Tahoma"

*-- Linhas 3278 a 3354:
3278:                 .MaxLength     = 4
3279:                 .Visible       = .T.
3280:             ENDWITH
3281:             BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress",    THIS, "ValidarTpTrib")
3282:             BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress", THIS, "TxtTpTribKeyPress")
3283: 
3284:             *-- lbl_4c_Label41: "IAT :" (Say41, top=354, left=558)
3285:             loc_oPg.AddObject("lbl_4c_Label41", "Label")
3286:             WITH loc_oPg.lbl_4c_Label41
3287:                 .Caption   = "IAT :"
3288:                 .Top       = 354
3289:                 .Left      = 558
3290:                 .Width     = 26
3291:                 .Height    = 15
3292:                 .FontName  = "Tahoma"
3293:                 .FontSize  = 8
3294:                 .ForeColor = RGB(90, 90, 90)
3295:                 .BackStyle = 0
3296:                 .AutoSize  = .T.
3297:                 .Visible   = .T.
3298:             ENDWITH
3299: 
3300:             *-- txt_4c_Iat: IAT - Indicador Arredondamento/Truncamento (getiat, top=350, left=589)
3301:             loc_oPg.AddObject("txt_4c_Iat", "TextBox")
3302:             WITH loc_oPg.txt_4c_Iat
3303:                 .Top           = 350
3304:                 .Left          = 589
3305:                 .Width         = 17
3306:                 .Height        = 23
3307:                 .FontName      = "Tahoma"
3308:                 .FontSize      = 8
3309:                 .SpecialEffect = 1
3310:                 .MaxLength     = 1
3311:                 .Visible       = .T.
3312:             ENDWITH
3313:             BINDEVENT(loc_oPg.txt_4c_Iat, "KeyPress",    THIS, "ValidarIat")
3314:             BINDEVENT(loc_oPg.txt_4c_Iat, "KeyPress", THIS, "TxtIatKeyPress")
3315: 
3316:             *-- lbl_4c_Label42: "[A]rredondamento [T]runcamento" (Say42, top=354, left=609)
3317:             loc_oPg.AddObject("lbl_4c_Label42", "Label")
3318:             WITH loc_oPg.lbl_4c_Label42
3319:                 .Caption   = "[A]rredondamento [T]runcamento"
3320:                 .Top       = 354
3321:                 .Left      = 609
3322:                 .Width     = 165
3323:                 .Height    = 15
3324:                 .FontName  = "Tahoma"
3325:                 .FontSize  = 8
3326:                 .ForeColor = RGB(90, 90, 90)
3327:                 .BackStyle = 0
3328:                 .AutoSize  = .T.
3329:                 .Visible   = .T.
3330:             ENDWITH
3331: 
3332:             *====================================================================
3333:             *  SECAO: IPI (Situacao Tributaria / Aliquota / Excecao TIPI)
3334:             *====================================================================
3335: 
3336:             *-- lbl_4c_Label5: "Situacao Tributaria IPI :" (Say5, top=380, left=86)
3337:             loc_oPg.AddObject("lbl_4c_Label5", "Label")
3338:             WITH loc_oPg.lbl_4c_Label5
3339:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
3340:                 .Top       = 380
3341:                 .Left      = 86
3342:                 .Width     = 116
3343:                 .Height    = 15
3344:                 .FontName  = "Tahoma"
3345:                 .FontSize  = 8
3346:                 .ForeColor = RGB(90, 90, 90)
3347:                 .BackStyle = 0
3348:                 .AutoSize  = .T.
3349:                 .Visible   = .T.
3350:             ENDWITH
3351: 
3352:             *-- cbo_4c_CmbIpi: Situacao Tributaria IPI combo (cmbIpi, top=375, left=206)
3353:             *-- Itens: "", "Tributado" (T), "Isento" (I), "Outros" (O)
3354:             loc_oPg.AddObject("cbo_4c_CmbIpi", "ComboBox")

*-- Linhas 3368 a 3476:
3368:             loc_oPg.cbo_4c_CmbIpi.AddItem("\<" + PADR("Tributado", 9))
3369:             loc_oPg.cbo_4c_CmbIpi.AddItem("\<" + PADR("Isento", 9))
3370:             loc_oPg.cbo_4c_CmbIpi.AddItem("\<" + PADR("Outros", 9))
3371:             BINDEVENT(loc_oPg.cbo_4c_CmbIpi, "When", THIS, "CboIpiWhen")
3372: 
3373:             *-- lbl_4c__AliqIPI: "Aliquota de IPI :" (Say_AliqIPI, top=380, left=340)
3374:             loc_oPg.AddObject("lbl_4c__AliqIPI", "Label")
3375:             WITH loc_oPg.lbl_4c__AliqIPI
3376:                 .Caption   = "Al" + CHR(237) + "quota de IPI :"
3377:                 .Top       = 380
3378:                 .Left      = 340
3379:                 .Width     = 80
3380:                 .Height    = 15
3381:                 .FontName  = "Tahoma"
3382:                 .FontSize  = 8
3383:                 .ForeColor = RGB(90, 90, 90)
3384:                 .BackStyle = 0
3385:                 .AutoSize  = .T.
3386:                 .Visible   = .T.
3387:             ENDWITH
3388: 
3389:             *-- txt_4c_AliqIPI: Aliquota IPI (Get_AliqIPI, top=375, left=425)
3390:             loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
3391:             WITH loc_oPg.txt_4c_AliqIPI
3392:                 .Top           = 375
3393:                 .Left          = 425
3394:                 .Width         = 45
3395:                 .Height        = 25
3396:                 .FontName      = "Tahoma"
3397:                 .FontSize      = 8
3398:                 .SpecialEffect = 1
3399:                 .InputMask     = "99.99"
3400:                 .Value         = 0
3401:                 .Visible       = .T.
3402:             ENDWITH
3403:             BINDEVENT(loc_oPg.txt_4c_AliqIPI, "KeyPress",    THIS, "ValidarAliqIPI")
3404:             BINDEVENT(loc_oPg.txt_4c_AliqIPI, "KeyPress", THIS, "TxtAliqIPIKeyPress")
3405: 
3406:             *-- lbl_4c_Label13: "Excecao da TIPI :" (Say13, top=380, left=511)
3407:             loc_oPg.AddObject("lbl_4c_Label13", "Label")
3408:             WITH loc_oPg.lbl_4c_Label13
3409:                 .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
3410:                 .Top       = 380
3411:                 .Left      = 511
3412:                 .Width     = 87
3413:                 .Height    = 15
3414:                 .FontName  = "Tahoma"
3415:                 .FontSize  = 8
3416:                 .ForeColor = RGB(90, 90, 90)
3417:                 .BackStyle = 0
3418:                 .AutoSize  = .T.
3419:                 .Visible   = .T.
3420:             ENDWITH
3421: 
3422:             *-- txt_4c_Extipi: Excecao TIPI (getextipi, top=375, left=601)
3423:             *-- When: enabled only when SigCdClf.IpiProds = 'S'
3424:             loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
3425:             WITH loc_oPg.txt_4c_Extipi
3426:                 .Top           = 375
3427:                 .Left          = 601
3428:                 .Width         = 35
3429:                 .Height        = 25
3430:                 .FontName      = "Tahoma"
3431:                 .FontSize      = 8
3432:                 .SpecialEffect = 1
3433:                 .MaxLength     = 3
3434:                 .Visible       = .T.
3435:             ENDWITH
3436:             BINDEVENT(loc_oPg.txt_4c_Extipi, "When", THIS, "TxtExtipipWhen")
3437: 
3438:             *====================================================================
3439:             *  SECAO: Descricao Fiscal (memo) + Botao gerar descricao
3440:             *====================================================================
3441: 
3442:             *-- lbl_4c_Label18: "Descricao Fiscal :" (Say18, top=405, left=118)
3443:             loc_oPg.AddObject("lbl_4c_Label18", "Label")
3444:             WITH loc_oPg.lbl_4c_Label18
3445:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
3446:                 .Top       = 405
3447:                 .Left      = 118
3448:                 .Width     = 84
3449:                 .Height    = 15
3450:                 .FontName  = "Tahoma"
3451:                 .FontSize  = 8
3452:                 .ForeColor = RGB(90, 90, 90)
3453:                 .BackStyle = 0
3454:                 .AutoSize  = .T.
3455:                 .Visible   = .T.
3456:             ENDWITH
3457: 
3458:             *-- obj_4c_Mgetdescfi: Descricao Fiscal editbox/memo (mgetdescfi, top=402, left=206)
3459:             loc_oPg.AddObject("obj_4c_Mgetdescfi", "EditBox")
3460:             WITH loc_oPg.obj_4c_Mgetdescfi
3461:                 .Top           = 402
3462:                 .Left          = 206
3463:                 .Width         = 509
3464:                 .Height        = 89
3465:                 .FontName      = "Tahoma"
3466:                 .FontSize      = 8
3467:                 .ScrollBars    = 2
3468:                 .Visible       = .T.
3469:             ENDWITH
3470: 
3471:             *-- cmd_4c_BtnDescFis: Botao gerar descricao fiscal (btnDescFis, top=423, left=162)
3472:             loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
3473:             WITH loc_oPg.cmd_4c_BtnDescFis
3474:                 .Caption         = ""
3475:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
3476:                 .PicturePosition = 0

*-- Linhas 3484 a 3527:
3484:                 .MousePointer    = 15
3485:                 .Visible         = .T.
3486:             ENDWITH
3487:             BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "CmdBtnDescFisClick")
3488: 
3489:             *====================================================================
3490:             *  SECAO: Valor Grama / Grid CMV (Custo Medio Vendido)
3491:             *====================================================================
3492: 
3493:             *-- lbl_4c_Label9: "Valor do Grama Produzido" (Say9, top=384, left=756)
3494:             loc_oPg.AddObject("lbl_4c_Label9", "Label")
3495:             WITH loc_oPg.lbl_4c_Label9
3496:                 .Caption   = "Valor do Grama Produzido"
3497:                 .Top       = 384
3498:                 .Left      = 756
3499:                 .Width     = 125
3500:                 .Height    = 15
3501:                 .FontName  = "Tahoma"
3502:                 .FontSize  = 8
3503:                 .ForeColor = RGB(90, 90, 90)
3504:                 .BackStyle = 0
3505:                 .AutoSize  = .T.
3506:                 .Visible   = .T.
3507:             ENDWITH
3508: 
3509:             *-- grd_4c_Cmv: Grid Custo Medio Vendido (grdCmv, top=402, left=754, 3 colunas)
3510:             *-- ReadOnly: todos os When retornam .F. (grid somente leitura)
3511:             loc_oPg.AddObject("grd_4c_Cmv", "Grid")
3512:             WITH loc_oPg.grd_4c_Cmv
3513:                 .Top        = 402
3514:                 .Left       = 754
3515:                 .Width      = 223
3516:                 .Height     = 141
3517:                 .FontName   = "Courier New"
3518:                 .FontSize   = 8
3519:                 .RecordMark = .T.
3520:                 .RowHeight  = 17
3521:                 .DeleteMark = .F.
3522:                 .ReadOnly   = .T.
3523:                 .Visible    = .T.
3524:             ENDWITH
3525:             loc_oPg.grd_4c_Cmv.ColumnCount  = 3
3526:             loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_TotGrupo2"
3527:             loc_oGrid = loc_oPg.grd_4c_Cmv

*-- Linhas 3612 a 3701:
3612:                 .MaxLength     = 2
3613:                 .Visible       = .T.
3614:             ENDWITH
3615:             BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress",    THIS, "ValidarMetal")
3616:             BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TxtMetalKeyPress")
3617: 
3618:             *-- txt_4c_DesMetal: Descricao Metal (Get_DesMetal, top=493, left=564)
3619:             loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
3620:             WITH loc_oPg.txt_4c_DesMetal
3621:                 .Top           = 493
3622:                 .Left          = 564
3623:                 .Width         = 150
3624:                 .Height        = 23
3625:                 .FontName      = "Tahoma"
3626:                 .FontSize      = 8
3627:                 .SpecialEffect = 1
3628:                 .ReadOnly      = .T.
3629:                 .Visible       = .T.
3630:             ENDWITH
3631: 
3632:             *-- lbl_4c_Label15: "Teor :" (Say15, top=522, left=502)
3633:             loc_oPg.AddObject("lbl_4c_Label15", "Label")
3634:             WITH loc_oPg.lbl_4c_Label15
3635:                 .Caption   = "Teor :"
3636:                 .Top       = 522
3637:                 .Left      = 502
3638:                 .Width     = 31
3639:                 .FontName  = "Tahoma"
3640:                 .FontSize  = 8
3641:                 .ForeColor = RGB(90, 90, 90)
3642:                 .BackStyle = 0
3643:                 .AutoSize  = .T.
3644:                 .Visible   = .T.
3645:             ENDWITH
3646: 
3647:             *-- txt_4c_Teor: Codigo Teor (Get_teor, top=518, left=537)
3648:             loc_oPg.AddObject("txt_4c_Teor", "TextBox")
3649:             WITH loc_oPg.txt_4c_Teor
3650:                 .Top           = 518
3651:                 .Left          = 537
3652:                 .Width         = 24
3653:                 .Height        = 23
3654:                 .FontName      = "Tahoma"
3655:                 .FontSize      = 8
3656:                 .SpecialEffect = 1
3657:                 .MaxLength     = 2
3658:                 .Visible       = .T.
3659:             ENDWITH
3660:             BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress",    THIS, "ValidarTeor")
3661:             BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TxtTeorKeyPress")
3662: 
3663:             *-- txt_4c_DesTeor: Descricao Teor (Get_DesTeor, top=518, left=564)
3664:             loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
3665:             WITH loc_oPg.txt_4c_DesTeor
3666:                 .Top           = 518
3667:                 .Left          = 564
3668:                 .Width         = 150
3669:                 .Height        = 23
3670:                 .FontName      = "Tahoma"
3671:                 .FontSize      = 8
3672:                 .SpecialEffect = 1
3673:                 .ReadOnly      = .T.
3674:                 .Visible       = .T.
3675:             ENDWITH
3676: 
3677:             *====================================================================
3678:             *  SECAO: Valor Estimado / Moeda / IPPT/CST
3679:             *====================================================================
3680: 
3681:             *-- lbl_4c_Label7: "Valor Estimado :" (Say7, top=522, left=123)
3682:             loc_oPg.AddObject("lbl_4c_Label7", "Label")
3683:             WITH loc_oPg.lbl_4c_Label7
3684:                 .Caption   = "Valor Estimado :"
3685:                 .Top       = 522
3686:                 .Left      = 123
3687:                 .Width     = 79
3688:                 .Height    = 15
3689:                 .FontName  = "Tahoma"
3690:                 .FontSize  = 8
3691:                 .ForeColor = RGB(90, 90, 90)
3692:                 .BackStyle = 0
3693:                 .AutoSize  = .T.
3694:                 .Visible   = .T.
3695:             ENDWITH
3696: 
3697:             *-- txt_4c_Valor: Valor Estimado (getValor, top=518, left=206)
3698:             loc_oPg.AddObject("txt_4c_Valor", "TextBox")
3699:             WITH loc_oPg.txt_4c_Valor
3700:                 .Top           = 518
3701:                 .Left          = 206

*-- Linhas 3723 a 3813:
3723:                 .MaxLength     = 3
3724:                 .Visible       = .T.
3725:             ENDWITH
3726:             BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress",    THIS, "ValidarMvalorFiscal")
3727:             BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress", THIS, "TxtMvalorFiscalKeyPress")
3728: 
3729:             *-- lbl_4c_Label10: "IPPT/CST :" (Say10, top=547, left=148)
3730:             loc_oPg.AddObject("lbl_4c_Label10", "Label")
3731:             WITH loc_oPg.lbl_4c_Label10
3732:                 .Caption   = "IPPT/CST :"
3733:                 .Top       = 547
3734:                 .Left      = 148
3735:                 .Width     = 54
3736:                 .Height    = 15
3737:                 .FontName  = "Tahoma"
3738:                 .FontSize  = 8
3739:                 .ForeColor = RGB(90, 90, 90)
3740:                 .BackStyle = 0
3741:                 .AutoSize  = .T.
3742:                 .Visible   = .T.
3743:             ENDWITH
3744: 
3745:             *-- txt_4c_IPPTCST: IPPT/CST (getIPPTCST, top=543, left=206)
3746:             *-- ReadOnly: When retorna .F. no legado
3747:             loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
3748:             WITH loc_oPg.txt_4c_IPPTCST
3749:                 .Top           = 543
3750:                 .Left          = 206
3751:                 .Width         = 108
3752:                 .Height        = 23
3753:                 .FontName      = "Tahoma"
3754:                 .FontSize      = 8
3755:                 .SpecialEffect = 1
3756:                 .ReadOnly      = .T.
3757:                 .Visible       = .T.
3758:             ENDWITH
3759: 
3760:         CATCH TO loc_oErro
3761:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Dados Fiscais:" + ;
3762:                 CHR(13) + loc_oErro.Message + CHR(13) + ;
3763:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
3764:                 "FormProduto.ConfigurarPgpgDadosFiscais")
3765:         ENDTRY
3766:     ENDPROC
3767: 
3768:     *===========================================================================
3769:     * ConfigurarPgpgCusto - Configura Page2 "Custos" do pgf_4c_Dados
3770:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
3771:     * grdCompo(12 colunas) + cmdgCompo(2 botoes) + cmbTipos + GradeGRUPO2(3 colunas)
3772:     *===========================================================================
3773:     PROTECTED PROCEDURE ConfigurarPgpgCusto(par_oPg)
3774:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oErro
3775:         TRY
3776:             loc_oPg = par_oPg
3777: 
3778:             *-- Cursors placeholder para os grids (ANTES de RecordSource)
3779:             *-- Reutiliza cursor_4c_GrdCompo e TotGrupo criados por pgComposicao se existirem
3780:             IF !USED("cursor_4c_GrdCompo")
3781:                 SET NULL ON
3782:                 CREATE CURSOR cursor_4c_GrdCompo ( ;
3783:                     cpros    C(14), dpros    C(65),  cunis  C(5),  ;
3784:                     valor    N(14,3), qtdes  N(10,3), total N(14,3), ;
3785:                     moeda    C(3),  obs      C(80),  estoc  C(1),   ;
3786:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
3787:                     ords     N(5,0), matprinc C(14))
3788:                 SET NULL OFF
3789:             ENDIF
3790:             IF !USED("TotGrupo")
3791:                 CREATE CURSOR TotGrupo (Grupo C(10), ValGrupo N(14,3), Moeda C(3))
3792:             ENDIF
3793: 
3794:             *-- lbl_4c_Label1: "Tipo :" (Say1, top=159, left=107)
3795:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
3796:             WITH loc_oPg.lbl_4c_Label1
3797:                 .Caption   = "Tipo :"
3798:                 .Top       = 159
3799:                 .Left      = 107
3800:                 .Width     = 29
3801:                 .Height    = 15
3802:                 .FontName  = "Tahoma"
3803:                 .FontSize  = 8
3804:                 .ForeColor = RGB(90, 90, 90)
3805:                 .BackStyle = 0
3806:                 .AutoSize  = .T.
3807:                 .Visible   = .T.
3808:             ENDWITH
3809: 
3810:             *-- cbo_4c_CmbTipos: combo de tipos de composicao (cmbTipos, top=154, left=143)
3811:             loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
3812:             WITH loc_oPg.cbo_4c_CmbTipos
3813:                 .Top           = 154

*-- Linhas 3820 a 3863:
3820:                 .Style         = 2
3821:                 .Visible       = .T.
3822:             ENDWITH
3823:             BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
3824: 
3825:             *-- grd_4c_GrdCusto: grade principal de custo (grdCompo, top=178, left=34, 12 colunas)
3826:             loc_oPg.AddObject("grd_4c_GrdCusto", "Grid")
3827:             WITH loc_oPg.grd_4c_GrdCusto
3828:                 .Top        = 178
3829:                 .Left       = 34
3830:                 .Width      = 813
3831:                 .Height     = 230
3832:                 .FontName   = "Tahoma"
3833:                 .FontSize   = 8
3834:                 .RecordMark = .F.
3835:                 .RowHeight  = 16
3836:                 .ScrollBars = 2
3837:                 .DeleteMark = .F.
3838:                 .Visible    = .T.
3839:             ENDWITH
3840:             loc_oPg.grd_4c_GrdCusto.ColumnCount  = 12
3841:             loc_oPg.grd_4c_GrdCusto.RecordSource = "cursor_4c_GrdCompo"
3842:             loc_oGrid = loc_oPg.grd_4c_GrdCusto
3843: 
3844:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdCompo.cpros"
3845:             loc_oGrid.Column1.Width           = 90
3846:             loc_oGrid.Column1.ColumnOrder     = 1
3847:             loc_oGrid.Column1.Movable         = .F.
3848:             loc_oGrid.Column1.Resizable       = .F.
3849:             loc_oGrid.Column1.Header1.Caption = "Item"
3850: 
3851:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdCompo.dpros"
3852:             loc_oGrid.Column2.Width           = 175
3853:             loc_oGrid.Column2.ColumnOrder     = 2
3854:             loc_oGrid.Column2.Movable         = .F.
3855:             loc_oGrid.Column2.Resizable       = .F.
3856:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3857: 
3858:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdCompo.cunis"
3859:             loc_oGrid.Column3.Width           = 30
3860:             loc_oGrid.Column3.ColumnOrder     = 3
3861:             loc_oGrid.Column3.Movable         = .F.
3862:             loc_oGrid.Column3.Resizable       = .F.
3863:             loc_oGrid.Column3.Header1.Caption = "Un"

*-- Linhas 3924 a 4005:
3924:             loc_oGrid.Column12.ReadOnly        = .T.
3925:             loc_oGrid.Column12.Header1.Caption = "Un"
3926: 
3927:             BINDEVENT(loc_oPg.grd_4c_GrdCusto, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
3928: 
3929:             *-- cmg_4c_CmdgCusto: 2 botoes de controle (cmdgCompo, top=240, left=851)
3930:             loc_oPg.AddObject("cmg_4c_CmdgCusto", "CommandGroup")
3931:             WITH loc_oPg.cmg_4c_CmdgCusto
3932:                 .Top         = 240
3933:                 .Left        = 851
3934:                 .Width       = 50
3935:                 .Height      = 90
3936:                 .BackStyle   = 0
3937:                 .BorderStyle = 0
3938:                 .Value       = 1
3939:                 .BackColor   = RGB(162, 214, 242)
3940:                 .ButtonCount = 2
3941:                 .Visible     = .T.
3942:             ENDWITH
3943:             WITH loc_oPg.cmg_4c_CmdgCusto
3944:                 .Command1.Top          = 5
3945:                 .Command1.Left         = 5
3946:                 .Command1.Height       = 40
3947:                 .Command1.Width        = 40
3948:                 .Command1.Caption      = ""
3949:                 .Command1.Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
3950:                 .Command1.ToolTipText  = "Inserir Item"
3951:                 .Command1.Style        = 0
3952:                 .Command1.SpecialEffect = 0
3953:                 .Command1.BackColor    = RGB(255, 255, 255)
3954:                 .Command2.Top          = 45
3955:                 .Command2.Left         = 5
3956:                 .Command2.Height       = 40
3957:                 .Command2.Width        = 40
3958:                 .Command2.Caption      = ""
3959:                 .Command2.Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3960:                 .Command2.ToolTipText  = "Excluir Item"
3961:                 .Command2.Style        = 0
3962:                 .Command2.SpecialEffect = 0
3963:                 .Command2.BackColor    = RGB(255, 255, 255)
3964:             ENDWITH
3965:             BINDEVENT(loc_oPg.cmg_4c_CmdgCusto, "Click", THIS, "CmgCustoClick")
3966: 
3967:             *-- lbl_4c_Label16: "Descricao :" (Say16, top=415, left=53)
3968:             loc_oPg.AddObject("lbl_4c_Label16", "Label")
3969:             WITH loc_oPg.lbl_4c_Label16
3970:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3971:                 .Top       = 415
3972:                 .Left      = 53
3973:                 .Width     = 55
3974:                 .Height    = 15
3975:                 .FontName  = "Tahoma"
3976:                 .FontSize  = 8
3977:                 .ForeColor = RGB(90, 90, 90)
3978:                 .BackStyle = 0
3979:                 .AutoSize  = .T.
3980:                 .Visible   = .T.
3981:             ENDWITH
3982: 
3983:             *-- txt_4c_Desc: descricao do material (Get_Desc, top=412, left=116, readonly)
3984:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
3985:             WITH loc_oPg.txt_4c_Desc
3986:                 .Top           = 412
3987:                 .Left          = 116
3988:                 .Width         = 304
3989:                 .Height        = 21
3990:                 .FontName      = "Tahoma"
3991:                 .FontSize      = 8
3992:                 .SpecialEffect = 1
3993:                 .ReadOnly      = .T.
3994:                 .BackColor     = RGB(240, 240, 240)
3995:                 .Value         = ""
3996:                 .Visible       = .T.
3997:             ENDWITH
3998: 
3999:             *-- lbl_4c_Label2: "Grupo :" (Say2, top=415, left=480)
4000:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
4001:             WITH loc_oPg.lbl_4c_Label2
4002:                 .Caption   = "Grupo :"
4003:                 .Top       = 415
4004:                 .Left      = 480
4005:                 .Width     = 38

*-- Linhas 4054 a 4092:
4054:                 .BorderWidth = 1
4055:                 .BackStyle   = 1
4056:                 .Visible     = .T.
4057:             ENDWITH
4058: 
4059:             *-- grd_4c_GradeGrupo2: grade de resumo por grupo (GradeGRUPO2, top=468, left=35)
4060:             loc_oPg.AddObject("grd_4c_GradeGrupo2", "Grid")
4061:             WITH loc_oPg.grd_4c_GradeGrupo2
4062:                 .Top          = 468
4063:                 .Left         = 35
4064:                 .Width        = 195
4065:                 .Height       = 141
4066:                 .FontName     = "Verdana"
4067:                 .FontSize     = 8
4068:                 .DeleteMark   = .F.
4069:                 .HeaderHeight = 14
4070:                 .ReadOnly     = .T.
4071:                 .RecordMark   = .F.
4072:                 .RowHeight    = 16
4073:                 .Visible      = .T.
4074:             ENDWITH
4075:             loc_oPg.grd_4c_GradeGrupo2.ColumnCount  = 3
4076:             loc_oPg.grd_4c_GradeGrupo2.RecordSource = "TotGrupo"
4077:             loc_oGrid2 = loc_oPg.grd_4c_GradeGrupo2
4078: 
4079:             loc_oGrid2.Column1.ControlSource   = "TotGrupo.Grupo"
4080:             loc_oGrid2.Column1.Width           = 35
4081:             loc_oGrid2.Column1.Movable         = .F.
4082:             loc_oGrid2.Column1.Resizable       = .F.
4083:             loc_oGrid2.Column1.ReadOnly        = .T.
4084:             loc_oGrid2.Column1.Header1.Caption = "Grp"
4085: 
4086:             loc_oGrid2.Column2.ControlSource   = "TotGrupo.ValGrupo"
4087:             loc_oGrid2.Column2.Width           = 120
4088:             loc_oGrid2.Column2.Movable         = .F.
4089:             loc_oGrid2.Column2.Resizable       = .F.
4090:             loc_oGrid2.Column2.ReadOnly        = .T.
4091:             loc_oGrid2.Column2.InputMask       = "999,999,999.999"
4092:             loc_oGrid2.Column2.Header1.Caption = "Total"

*-- Linhas 4108 a 4179:
4108:     * ConfigurarPgpgComposicao - Configura Page6 "Composicao" do pgf_4c_Dados
4109:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao
4110:     *===========================================================================
4111:     PROTECTED PROCEDURE ConfigurarPgpgComposicao(par_oPg)
4112:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oGrid3, loc_oGradeGrupo, loc_oCnt, loc_oErro
4113:         TRY
4114:             loc_oPg = par_oPg
4115: 
4116:             *-- Cursors placeholder para os grids (ANTES de RecordSource)
4117:             IF !USED("cursor_4c_GrdCompo")
4118:                 SET NULL ON
4119:                 CREATE CURSOR cursor_4c_GrdCompo ( ;
4120:                     cpros    C(14), dpros   C(65), cunis   C(5),  ;
4121:                     valor    N(14,3), qtdes N(10,3), total  N(14,3), ;
4122:                     moeda    C(3),  obs    C(80),  estoc   C(1),  ;
4123:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
4124:                     ords     N(5,0), matprinc C(14))
4125:                 SET NULL OFF
4126:             ENDIF
4127:             IF !USED("cursor_4c_GrdSubCp")
4128:                 SET NULL ON
4129:                 CREATE CURSOR cursor_4c_GrdSubCp ( ;
4130:                     cpros    C(14), dpros   C(65), cunis   C(5),  ;
4131:                     valor    N(14,3), qtdes N(10,3), total  N(14,3), ;
4132:                     moeda    C(3),  obs    C(80),  estoc   C(1),  ;
4133:                     consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
4134:                     ords     N(5,0), matprinc C(14), tamanho C(10))
4135:                 SET NULL OFF
4136:             ENDIF
4137:             IF !USED("cursor_4c_GrdRelogios")
4138:                 SET NULL ON
4139:                 CREATE CURSOR cursor_4c_GrdRelogios ( ;
4140:                     grp C(5), descricao C(60), produto C(14), descprod C(60))
4141:                 SET NULL OFF
4142:             ENDIF
4143:             IF !USED("TotGrupo")
4144:                 CREATE CURSOR TotGrupo (Grupo C(10), ValGrupo N(14,3), Moeda C(3))
4145:             ENDIF
4146: 
4147:             *-- grdCompo: grade principal de composicao (14 colunas)
4148:             loc_oPg.AddObject("grd_4c_GrdCompo", "Grid")
4149:             WITH loc_oPg.grd_4c_GrdCompo
4150:                 .Top        = 117
4151:                 .Left       = 6
4152:                 .Width      = 943
4153:                 .Height     = 147
4154:                 .FontName   = "Tahoma"
4155:                 .FontSize   = 8
4156:                 .RecordMark = .F.
4157:                 .RowHeight  = 16
4158:                 .ScrollBars = 2
4159:                 .TabStop    = .F.
4160:                 .Visible    = .T.
4161:             ENDWITH
4162:             loc_oPg.grd_4c_GrdCompo.ColumnCount  = 14
4163:             loc_oPg.grd_4c_GrdCompo.RecordSource = "cursor_4c_GrdCompo"
4164:             loc_oGrid = loc_oPg.grd_4c_GrdCompo
4165: 
4166:             loc_oGrid.Column1.ControlSource  = "cursor_4c_GrdCompo.cpros"
4167:             loc_oGrid.Column1.Width          = 108
4168:             loc_oGrid.Column1.ColumnOrder    = 1
4169:             loc_oGrid.Column1.Movable        = .F.
4170:             loc_oGrid.Column1.Resizable      = .F.
4171:             loc_oGrid.Column1.Header1.Caption = "Material"
4172: 
4173:             loc_oGrid.Column2.ControlSource  = "cursor_4c_GrdCompo.dpros"
4174:             loc_oGrid.Column2.Width          = 187
4175:             loc_oGrid.Column2.ColumnOrder    = 2
4176:             loc_oGrid.Column2.Movable        = .F.
4177:             loc_oGrid.Column2.Resizable      = .F.
4178:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4179: 

*-- Linhas 4319 a 4362:
4319:                 .Command5.ToolTipText = "Atualizar Pesos"
4320:                 .Command5.BackColor = RGB(255, 255, 255)
4321:             ENDWITH
4322:             BINDEVENT(loc_oPg.cmg_4c_CmdgCompo, "Click", THIS, "CmgCompoClick")
4323: 
4324:             *-- grdsubcp: grade de subcomposicao (15 colunas)
4325:             loc_oPg.AddObject("grd_4c_GrdSubCp", "Grid")
4326:             WITH loc_oPg.grd_4c_GrdSubCp
4327:                 .Top        = 317
4328:                 .Left       = 6
4329:                 .Width      = 943
4330:                 .Height     = 83
4331:                 .FontName   = "Tahoma"
4332:                 .FontSize   = 8
4333:                 .RecordMark = .F.
4334:                 .RowHeight  = 16
4335:                 .ScrollBars = 2
4336:                 .TabStop    = .F.
4337:                 .Visible    = .T.
4338:             ENDWITH
4339:             loc_oPg.grd_4c_GrdSubCp.ColumnCount  = 15
4340:             loc_oPg.grd_4c_GrdSubCp.RecordSource = "cursor_4c_GrdSubCp"
4341:             loc_oGrid2 = loc_oPg.grd_4c_GrdSubCp
4342: 
4343:             loc_oGrid2.Column1.ControlSource  = "cursor_4c_GrdSubCp.cpros"
4344:             loc_oGrid2.Column1.Width          = 108
4345:             loc_oGrid2.Column1.ColumnOrder    = 1
4346:             loc_oGrid2.Column1.Movable        = .F.
4347:             loc_oGrid2.Column1.Resizable      = .F.
4348:             loc_oGrid2.Column1.Header1.Caption = "Material"
4349: 
4350:             loc_oGrid2.Column2.ControlSource  = "cursor_4c_GrdSubCp.dpros"
4351:             loc_oGrid2.Column2.Width          = 149
4352:             loc_oGrid2.Column2.ColumnOrder    = 2
4353:             loc_oGrid2.Column2.Movable        = .F.
4354:             loc_oGrid2.Column2.Resizable      = .F.
4355:             loc_oGrid2.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4356: 
4357:             loc_oGrid2.Column3.ControlSource  = "cursor_4c_GrdSubCp.cunis"
4358:             loc_oGrid2.Column3.Width          = 24
4359:             loc_oGrid2.Column3.ColumnOrder    = 4
4360:             loc_oGrid2.Column3.Movable        = .F.
4361:             loc_oGrid2.Column3.Resizable      = .F.
4362:             loc_oGrid2.Column3.Header1.Caption = "Un"

*-- Linhas 4474 a 4517:
4474:                 .Command2.SpecialEffect = 0
4475:                 .Command2.BackColor = RGB(255, 255, 255)
4476:             ENDWITH
4477:             BINDEVENT(loc_oPg.cmg_4c_CmdgSubCp, "Click", THIS, "CmgSubCpClick")
4478: 
4479:             *-- grdRelogios: grade de relogios (inicialmente oculta)
4480:             loc_oPg.AddObject("grd_4c_GrdRelogios", "Grid")
4481:             WITH loc_oPg.grd_4c_GrdRelogios
4482:                 .Top        = 117
4483:                 .Left       = 6
4484:                 .Width      = 943
4485:                 .Height     = 307
4486:                 .FontName   = "Verdana"
4487:                 .FontSize   = 8
4488:                 .RecordMark = .F.
4489:                 .RowHeight  = 16
4490:                 .ScrollBars = 2
4491:                 .TabStop    = .F.
4492:                 .Visible    = .F.
4493:             ENDWITH
4494:             loc_oPg.grd_4c_GrdRelogios.ColumnCount  = 4
4495:             loc_oPg.grd_4c_GrdRelogios.RecordSource = "cursor_4c_GrdRelogios"
4496:             loc_oGrid3 = loc_oPg.grd_4c_GrdRelogios
4497: 
4498:             loc_oGrid3.Column1.ControlSource  = "cursor_4c_GrdRelogios.grp"
4499:             loc_oGrid3.Column1.Width          = 31
4500:             loc_oGrid3.Column1.ColumnOrder    = 1
4501:             loc_oGrid3.Column1.Movable        = .F.
4502:             loc_oGrid3.Column1.Resizable      = .F.
4503:             loc_oGrid3.Column1.Header1.Caption = "Grp"
4504: 
4505:             loc_oGrid3.Column2.ControlSource  = "cursor_4c_GrdRelogios.descricao"
4506:             loc_oGrid3.Column2.Width          = 150
4507:             loc_oGrid3.Column2.Movable        = .F.
4508:             loc_oGrid3.Column2.Resizable      = .F.
4509:             loc_oGrid3.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4510: 
4511:             loc_oGrid3.Column3.ControlSource  = "cursor_4c_GrdRelogios.produto"
4512:             loc_oGrid3.Column3.Width          = 115
4513:             loc_oGrid3.Column3.ColumnOrder    = 3
4514:             loc_oGrid3.Column3.Movable        = .F.
4515:             loc_oGrid3.Column3.Resizable      = .F.
4516:             loc_oGrid3.Column3.Header1.Caption = "Produto"
4517: 

*-- Linhas 4563 a 4643:
4563:             loc_oGradeGrupo.Column3.Resizable      = .F.
4564:             loc_oGradeGrupo.Column3.ReadOnly       = .T.
4565:             loc_oGradeGrupo.Column3.Header1.Caption = "Moeda"
4566: 
4567:             *-- BINDEVENT para grids
4568:             BINDEVENT(loc_oPg.grd_4c_GrdCompo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
4569:             BINDEVENT(loc_oPg.grd_4c_GrdSubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
4570: 
4571:             *-- Say4: "Obs. da OF :"
4572:             loc_oPg.AddObject("lbl_4c_Label4", "Label")
4573:             WITH loc_oPg.lbl_4c_Label4
4574:                 .Caption   = "Obs. da OF :"
4575:                 .FontName  = "Tahoma"
4576:                 .FontSize  = 8
4577:                 .BackStyle = 0
4578:                 .Height    = 15
4579:                 .Left      = 33
4580:                 .Top       = 269
4581:                 .Width     = 64
4582:                 .ForeColor = RGB(90, 90, 90)
4583:                 .Visible   = .T.
4584:             ENDWITH
4585: 
4586:             *-- getObsOFs: observacao da ordem de fabricacao
4587:             loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
4588:             WITH loc_oPg.txt_4c_ObsOFs
4589:                 .FontName  = "Tahoma"
4590:                 .FontSize  = 8
4591:                 .Format    = "K!"
4592:                 .Height    = 21
4593:                 .Left      = 99
4594:                 .MaxLength = 120
4595:                 .SpecialEffect = 1
4596:                 .Top       = 266
4597:                 .Width     = 850
4598:                 .BackColor = RGB(240, 240, 240)
4599:                 .Value     = ""
4600:                 .Visible   = .T.
4601:             ENDWITH
4602:             BINDEVENT(loc_oPg.txt_4c_ObsOFs, "When", THIS, "TxtObsOFsWhen")
4603:             BINDEVENT(loc_oPg.txt_4c_ObsOFs, "KeyPress", THIS, "TxtObsOFsKeyPress")
4604: 
4605:             *-- Say16: "Descricao :" (para Get_Desc)
4606:             loc_oPg.AddObject("lbl_4c_Label16", "Label")
4607:             WITH loc_oPg.lbl_4c_Label16
4608:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4609:                 .FontName  = "Tahoma"
4610:                 .FontSize  = 8
4611:                 .BackStyle = 0
4612:                 .Height    = 15
4613:                 .Left      = 40
4614:                 .Top       = 293
4615:                 .Width     = 55
4616:                 .ForeColor = RGB(90, 90, 90)
4617:                 .Visible   = .T.
4618:             ENDWITH
4619: 
4620:             *-- Get_Desc: descricao do produto na composicao principal
4621:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
4622:             WITH loc_oPg.txt_4c_Desc
4623:                 .FontName  = "Tahoma"
4624:                 .FontSize  = 8
4625:                 .Height    = 21
4626:                 .Left      = 99
4627:                 .SpecialEffect = 1
4628:                 .Top       = 290
4629:                 .Width     = 298
4630:                 .BackColor = RGB(240, 240, 240)
4631:                 .Value     = ""
4632:                 .Visible   = .T.
4633:             ENDWITH
4634: 
4635:             *-- Say15: "Material Principal :"
4636:             loc_oPg.AddObject("lbl_4c_Label15", "Label")
4637:             WITH loc_oPg.lbl_4c_Label15
4638:                 .Caption   = "Material Principal :"
4639:                 .FontName  = "Tahoma"
4640:                 .FontSize  = 8
4641:                 .BackStyle = 0
4642:                 .Height    = 15
4643:                 .Left      = 418

*-- Linhas 4797 a 4858:
4797:                 .BackColor     = RGB(255, 255, 255)
4798:                 .Visible       = .T.
4799:             ENDWITH
4800:             BINDEVENT(loc_oPg.chk_4c_ChkLiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
4801: 
4802:             *-- chkLiberaVenda: cadeado de liberacao de edicao de venda
4803:             loc_oPg.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
4804:             WITH loc_oPg.chk_4c_ChkLiberaVenda
4805:                 .Top           = 431
4806:                 .Left          = 383
4807:                 .Height        = 35
4808:                 .Width         = 35
4809:                 .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
4810:                 .Alignment     = 0
4811:                 .Caption       = ""
4812:                 .Value         = 0
4813:                 .SpecialEffect = 0
4814:                 .Style         = 1
4815:                 .BackColor     = RGB(255, 255, 255)
4816:                 .Visible       = .T.
4817:             ENDWITH
4818:             BINDEVENT(loc_oPg.chk_4c_ChkLiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
4819: 
4820:             *==============================================================
4821:             *-- SECAO CUSTO (Left < 380)
4822:             *==============================================================
4823: 
4824:             *-- lblCompra: "Preco de Custo (Moeda 1)"
4825:             loc_oPg.AddObject("lbl_4c_LblCompra", "Label")
4826:             WITH loc_oPg.lbl_4c_LblCompra
4827:                 .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
4828:                 .FontName  = "Tahoma"
4829:                 .FontSize  = 8
4830:                 .BackStyle = 0
4831:                 .Height    = 15
4832:                 .Left      = 7
4833:                 .Top       = 474
4834:                 .Width     = 127
4835:                 .ForeColor = RGB(90, 90, 90)
4836:                 .Visible   = .T.
4837:             ENDWITH
4838: 
4839:             *-- getPcus: preco de custo
4840:             loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
4841:             WITH loc_oPg.txt_4c_Pcus
4842:                 .Alignment     = 3
4843:                 .Format        = "K"
4844:                 .Height        = 23
4845:                 .InputMask     = "999,999.99999"
4846:                 .Left          = 7
4847:                 .SpecialEffect = 1
4848:                 .Top           = 489
4849:                 .Width         = 115
4850:                 .Value         = 0
4851:                 .Visible       = .T.
4852:             ENDWITH
4853: 
4854:             *-- txt_4c_Moec: moeda de custo (lookup SigCdMoe)
4855:             loc_oPg.AddObject("txt_4c_Moec", "TextBox")
4856:             WITH loc_oPg.txt_4c_Moec
4857:                 .Format        = "K"
4858:                 .Height        = 23

*-- Linhas 4864 a 4956:
4864:                 .Value         = ""
4865:                 .Visible       = .T.
4866:             ENDWITH
4867:             BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress", THIS, "ValidarMoec")
4868:             BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress", THIS, "TxtMoecKeyPress")
4869: 
4870:             *-- Say22: "MKP" (custo)
4871:             loc_oPg.AddObject("lbl_4c_Label22", "Label")
4872:             WITH loc_oPg.lbl_4c_Label22
4873:                 .Caption   = "MKP"
4874:                 .FontName  = "Tahoma"
4875:                 .FontSize  = 8
4876:                 .BackStyle = 0
4877:                 .Height    = 15
4878:                 .Left      = 7
4879:                 .Top       = 514
4880:                 .Width     = 22
4881:                 .ForeColor = RGB(90, 90, 90)
4882:                 .Visible   = .T.
4883:             ENDWITH
4884: 
4885:             *-- Get_cmkpc: codigo MKP custo (lookup SigPrFti)
4886:             loc_oPg.AddObject("txt_4c_Cmkpc", "TextBox")
4887:             WITH loc_oPg.txt_4c_Cmkpc
4888:                 .Height        = 23
4889:                 .Left          = 7
4890:                 .MaxLength     = 2
4891:                 .SpecialEffect = 1
4892:                 .Top           = 529
4893:                 .Width         = 24
4894:                 .Value         = ""
4895:                 .Visible       = .T.
4896:             ENDWITH
4897:             BINDEVENT(loc_oPg.txt_4c_Cmkpc, "KeyPress", THIS, "ValidarCmkpc")
4898:             BINDEVENT(loc_oPg.txt_4c_Cmkpc, "KeyPress", THIS, "TxtCmkpcKeyPress")
4899: 
4900:             *-- chkPlanCus: planejamento custo
4901:             loc_oPg.AddObject("chk_4c_ChkPlanCus", "CheckBox")
4902:             WITH loc_oPg.chk_4c_ChkPlanCus
4903:                 .Top           = 528
4904:                 .Left          = 34
4905:                 .Height        = 25
4906:                 .Width         = 25
4907:                 .Picture       = gc_4c_CaminhoIcones + "geral_datas_26.jpg"
4908:                 .Alignment     = 0
4909:                 .Caption       = ""
4910:                 .Value         = 0
4911:                 .SpecialEffect = 1
4912:                 .Style         = 1
4913:                 .BackColor     = RGB(162, 214, 242)
4914:                 .Visible       = .T.
4915:             ENDWITH
4916:             BINDEVENT(loc_oPg.chk_4c_ChkPlanCus, "Click", THIS, "ChkPlanCusClick")
4917: 
4918:             *-- lblValAdics: "Valor Adicional" (custo)
4919:             loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
4920:             WITH loc_oPg.lbl_4c_LblValAdics
4921:                 .Caption   = "Valor Adicional"
4922:                 .FontName  = "Tahoma"
4923:                 .FontSize  = 8
4924:                 .BackStyle = 0
4925:                 .Height    = 15
4926:                 .Left      = 62
4927:                 .Top       = 514
4928:                 .Width     = 71
4929:                 .ForeColor = RGB(90, 90, 90)
4930:                 .Visible   = .T.
4931:             ENDWITH
4932: 
4933:             *-- get_pftioc: valor adicional custo
4934:             loc_oPg.AddObject("txt_4c__pftioc", "TextBox")
4935:             WITH loc_oPg.txt_4c__pftioc
4936:                 .Alignment     = 3
4937:                 .Height        = 23
4938:                 .InputMask     = "999,999.99999"
4939:                 .Left          = 62
4940:                 .SpecialEffect = 1
4941:                 .Top           = 529
4942:                 .Width         = 94
4943:                 .Value         = 0
4944:                 .Visible       = .T.
4945:             ENDWITH
4946: 
4947:             *-- lblCuVda: "Fator de Custo (Moeda 2)"
4948:             loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
4949:             WITH loc_oPg.lbl_4c_LblCuVda
4950:                 .Caption   = "Fator de Custo (Moeda 2)"
4951:                 .FontName  = "Tahoma"
4952:                 .FontSize  = 8
4953:                 .BackStyle = 0
4954:                 .Height    = 15
4955:                 .Left      = 158
4956:                 .Top       = 474

*-- Linhas 4986 a 5074:
4986:                 .Value         = ""
4987:                 .Visible       = .T.
4988:             ENDWITH
4989:             BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress", THIS, "ValidarMoepc")
4990:             BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress", THIS, "TxtMoepcKeyPress")
4991: 
4992:             *-- Say8: "Total "
4993:             loc_oPg.AddObject("lbl_4c_Label8", "Label")
4994:             WITH loc_oPg.lbl_4c_Label8
4995:                 .Caption   = "Total "
4996:                 .FontName  = "Tahoma"
4997:                 .FontSize  = 8
4998:                 .BackStyle = 0
4999:                 .Height    = 15
5000:                 .Left      = 158
5001:                 .Top       = 514
5002:                 .Width     = 29
5003:                 .ForeColor = RGB(90, 90, 90)
5004:                 .Visible   = .T.
5005:             ENDWITH
5006: 
5007:             *-- getCustof: total custo
5008:             loc_oPg.AddObject("txt_4c_Custof", "TextBox")
5009:             WITH loc_oPg.txt_4c_Custof
5010:                 .Alignment     = 3
5011:                 .Height        = 23
5012:                 .InputMask     = "999,999.99999"
5013:                 .Left          = 159
5014:                 .SpecialEffect = 1
5015:                 .Top           = 529
5016:                 .Width         = 109
5017:                 .Value         = 0
5018:                 .Visible       = .T.
5019:             ENDWITH
5020: 
5021:             *-- txt_4c_Moecusf: moeda total custo (lookup SigCdMoe)
5022:             loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
5023:             WITH loc_oPg.txt_4c_Moecusf
5024:                 .Height        = 23
5025:                 .Left          = 270
5026:                 .MaxLength     = 3
5027:                 .SpecialEffect = 1
5028:                 .Top           = 529
5029:                 .Width         = 31
5030:                 .Value         = ""
5031:                 .Visible       = .T.
5032:             ENDWITH
5033:             BINDEVENT(loc_oPg.txt_4c_Moecusf, "KeyPress", THIS, "ValidarMoecusf")
5034:             BINDEVENT(loc_oPg.txt_4c_Moecusf, "KeyPress", THIS, "TxtMoecusfKeyPress")
5035: 
5036:             *-- Say6: "Peso Medio"
5037:             loc_oPg.AddObject("lbl_4c_Label6", "Label")
5038:             WITH loc_oPg.lbl_4c_Label6
5039:                 .Caption   = "Peso M" + CHR(233) + "dio"
5040:                 .FontName  = "Tahoma"
5041:                 .FontSize  = 8
5042:                 .BackStyle = 0
5043:                 .Height    = 15
5044:                 .Left      = 8
5045:                 .Top       = 553
5046:                 .Width     = 56
5047:                 .ForeColor = RGB(90, 90, 90)
5048:                 .Visible   = .T.
5049:             ENDWITH
5050: 
5051:             *-- getPesom: peso medio
5052:             loc_oPg.AddObject("txt_4c_Peso", "TextBox")
5053:             WITH loc_oPg.txt_4c_Peso
5054:                 .Alignment     = 3
5055:                 .Format        = "K"
5056:                 .Height        = 23
5057:                 .InputMask     = "99,999.999"
5058:                 .Left          = 8
5059:                 .MaxLength     = 10
5060:                 .SpecialEffect = 1
5061:                 .Top           = 568
5062:                 .Width         = 79
5063:                 .Value         = 0
5064:                 .Visible       = .T.
5065:             ENDWITH
5066: 
5067:             *-- Say10: "Var. Peso %"
5068:             loc_oPg.AddObject("lbl_4c_Label10", "Label")
5069:             WITH loc_oPg.lbl_4c_Label10
5070:                 .Caption   = "Var. Peso %"
5071:                 .FontName  = "Tahoma"
5072:                 .FontSize  = 8
5073:                 .BackStyle = 0
5074:                 .Height    = 15

*-- Linhas 5214 a 5428:
5214:                 .Value         = ""
5215:                 .Visible       = .T.
5216:             ENDWITH
5217:             BINDEVENT(loc_oPg.txt_4c_Ftio, "KeyPress", THIS, "ValidarFtio")
5218:             BINDEVENT(loc_oPg.txt_4c_Ftio, "KeyPress", THIS, "TxtFtioKeyPress")
5219: 
5220:             *-- getStatus: status do produto (lookup SigCdPst)
5221:             loc_oPg.AddObject("txt_4c_Status", "TextBox")
5222:             WITH loc_oPg.txt_4c_Status
5223:                 .Format        = "K"
5224:                 .Height        = 23
5225:                 .Left          = 384
5226:                 .MaxLength     = 3
5227:                 .SpecialEffect = 1
5228:                 .Top           = 529
5229:                 .Width         = 31
5230:                 .Value         = ""
5231:                 .Visible       = .T.
5232:             ENDWITH
5233:             BINDEVENT(loc_oPg.txt_4c_Status, "KeyPress", THIS, "ValidarStatus")
5234:             BINDEVENT(loc_oPg.txt_4c_Status, "KeyPress", THIS, "TxtStatusKeyPress")
5235: 
5236:             *-- Say24: "Sts"
5237:             loc_oPg.AddObject("lbl_4c_Label24", "Label")
5238:             WITH loc_oPg.lbl_4c_Label24
5239:                 .Caption   = "Sts"
5240:                 .FontName  = "Tahoma"
5241:                 .FontSize  = 8
5242:                 .BackStyle = 0
5243:                 .Height    = 15
5244:                 .Left      = 384
5245:                 .Top       = 514
5246:                 .Width     = 17
5247:                 .ForeColor = RGB(90, 90, 90)
5248:                 .Visible   = .T.
5249:             ENDWITH
5250: 
5251:             *-- chkPlanVen: planejamento venda
5252:             loc_oPg.AddObject("chk_4c_ChkPlanVen", "CheckBox")
5253:             WITH loc_oPg.chk_4c_ChkPlanVen
5254:                 .Top           = 528
5255:                 .Left          = 447
5256:                 .Height        = 25
5257:                 .Width         = 25
5258:                 .Picture       = gc_4c_CaminhoIcones + "geral_datas_26.jpg"
5259:                 .Alignment     = 0
5260:                 .Caption       = ""
5261:                 .Value         = 0
5262:                 .SpecialEffect = 0
5263:                 .Style         = 1
5264:                 .BackColor     = RGB(162, 214, 242)
5265:                 .Visible       = .T.
5266:             ENDWITH
5267:             BINDEVENT(loc_oPg.chk_4c_ChkPlanVen, "Click", THIS, "ChkPlanVenClick")
5268: 
5269:             *-- Chk_Pvenda: copia preco ideal para atual
5270:             loc_oPg.AddObject("chk_4c_Chk_Pvenda", "CheckBox")
5271:             WITH loc_oPg.chk_4c_Chk_Pvenda
5272:                 .Top           = 567
5273:                 .Left          = 447
5274:                 .Height        = 25
5275:                 .Width         = 25
5276:                 .Picture       = gc_4c_CaminhoIcones + "a_arrow1.bmp"
5277:                 .Alignment     = 0
5278:                 .Caption       = ""
5279:                 .Value         = 0
5280:                 .SpecialEffect = 0
5281:                 .Style         = 1
5282:                 .BackColor     = RGB(255, 255, 255)
5283:                 .Visible       = .T.
5284:             ENDWITH
5285:             BINDEVENT(loc_oPg.chk_4c_Chk_Pvenda, "Click", THIS, "ChkPvendaClick")
5286: 
5287:             *-- Say13: "Valor Adicional" (venda)
5288:             loc_oPg.AddObject("lbl_4c_Label13", "Label")
5289:             WITH loc_oPg.lbl_4c_Label13
5290:                 .Caption   = "Valor Adicional"
5291:                 .FontName  = "Tahoma"
5292:                 .FontSize  = 8
5293:                 .BackStyle = 0
5294:                 .Height    = 15
5295:                 .Left      = 476
5296:                 .Top       = 514
5297:                 .Width     = 71
5298:                 .ForeColor = RGB(90, 90, 90)
5299:                 .Visible   = .T.
5300:             ENDWITH
5301: 
5302:             *-- Get_Pftio: valor adicional venda
5303:             loc_oPg.AddObject("txt_4c_Pftio", "TextBox")
5304:             WITH loc_oPg.txt_4c_Pftio
5305:                 .Alignment     = 3
5306:                 .Height        = 23
5307:                 .InputMask     = "999,999.99999"
5308:                 .Left          = 476
5309:                 .SpecialEffect = 1
5310:                 .Top           = 529
5311:                 .Width         = 105
5312:                 .Value         = 0
5313:                 .Visible       = .T.
5314:             ENDWITH
5315: 
5316:             *-- Get_mftio: moeda valor adicional venda (lookup SigCdMoe)
5317:             loc_oPg.AddObject("txt_4c_Mftio", "TextBox")
5318:             WITH loc_oPg.txt_4c_Mftio
5319:                 .Height        = 23
5320:                 .Left          = 584
5321:                 .MaxLength     = 3
5322:                 .SpecialEffect = 1
5323:                 .Top           = 529
5324:                 .Width         = 31
5325:                 .Value         = ""
5326:                 .Visible       = .T.
5327:             ENDWITH
5328:             BINDEVENT(loc_oPg.txt_4c_Mftio, "KeyPress", THIS, "ValidarMftio")
5329:             BINDEVENT(loc_oPg.txt_4c_Mftio, "KeyPress", THIS, "TxtMftioKeyPress")
5330: 
5331:             *-- Say12: "Fator"
5332:             loc_oPg.AddObject("lbl_4c_Label12", "Label")
5333:             WITH loc_oPg.lbl_4c_Label12
5334:                 .Caption   = "Fator"
5335:                 .FontName  = "Tahoma"
5336:                 .FontSize  = 8
5337:                 .BackStyle = 0
5338:                 .Height    = 15
5339:                 .Left      = 618
5340:                 .Top       = 514
5341:                 .Width     = 28
5342:                 .ForeColor = RGB(90, 90, 90)
5343:                 .Visible   = .T.
5344:             ENDWITH
5345: 
5346:             *-- getFvenda: fator de venda
5347:             loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
5348:             WITH loc_oPg.txt_4c_Fvenda
5349:                 .Alignment     = 3
5350:                 .Height        = 23
5351:                 .InputMask     = "99,999.99999"
5352:                 .Left          = 618
5353:                 .SpecialEffect = 1
5354:                 .Top           = 529
5355:                 .Width         = 105
5356:                 .Value         = 0
5357:                 .Visible       = .T.
5358:             ENDWITH
5359: 
5360:             *-- getMoepv: moeda fator de venda (lookup SigCdMoe)
5361:             loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
5362:             WITH loc_oPg.txt_4c_Moepv
5363:                 .Height        = 23
5364:                 .Left          = 726
5365:                 .MaxLength     = 3
5366:                 .SpecialEffect = 1
5367:                 .Top           = 529
5368:                 .Width         = 31
5369:                 .Value         = ""
5370:                 .Visible       = .T.
5371:             ENDWITH
5372:             BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "ValidarMoepv")
5373:             BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "TxtMoepvKeyPress")
5374: 
5375:             *-- getMoeda: moeda de venda ideal (lookup SigCdMoe)
5376:             loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
5377:             WITH loc_oPg.txt_4c_Moeda
5378:                 .Height        = 23
5379:                 .Left          = 584
5380:                 .MaxLength     = 3
5381:                 .SpecialEffect = 1
5382:                 .Top           = 489
5383:                 .Width         = 31
5384:                 .Value         = ""
5385:                 .Visible       = .T.
5386:             ENDWITH
5387:             BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
5388:             BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaKeyPress")
5389: 
5390:             *-- lblIdeal: "Preco Ideal (Moeda 1)"
5391:             loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
5392:             WITH loc_oPg.lbl_4c_LblIdeal
5393:                 .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
5394:                 .FontName  = "Tahoma"
5395:                 .FontSize  = 8
5396:                 .BackStyle = 0
5397:                 .Height    = 15
5398:                 .Left      = 476
5399:                 .Top       = 475
5400:                 .Width     = 111
5401:                 .ForeColor = RGB(90, 90, 90)
5402:                 .Visible   = .T.
5403:             ENDWITH
5404: 
5405:             *-- getPvideal: preco ideal
5406:             loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
5407:             WITH loc_oPg.txt_4c_Pvideal
5408:                 .Alignment     = 3
5409:                 .Height        = 23
5410:                 .InputMask     = "999,999.99999"
5411:                 .Left          = 476
5412:                 .SpecialEffect = 1
5413:                 .Top           = 489
5414:                 .Width         = 105
5415:                 .Value         = 0
5416:                 .Visible       = .T.
5417:             ENDWITH
5418: 
5419:             *-- lblFIdeals: "Fator Ideal"
5420:             loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
5421:             WITH loc_oPg.lbl_4c_LblFIdeals
5422:                 .Caption   = "Fator Ideal"
5423:                 .FontName  = "Tahoma"
5424:                 .FontSize  = 8
5425:                 .BackStyle = 0
5426:                 .Height    = 15
5427:                 .Left      = 618
5428:                 .Top       = 475

*-- Linhas 5515 a 5559:
5515:                 .Value         = ""
5516:                 .Visible       = .T.
5517:             ENDWITH
5518:             BINDEVENT(loc_oPg.txt_4c_Moev, "KeyPress", THIS, "ValidarMoev")
5519:             BINDEVENT(loc_oPg.txt_4c_Moev, "KeyPress", THIS, "TxtMoevKeyPress")
5520: 
5521:             *-- lblFAtuals: "Fator Atual"
5522:             loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
5523:             WITH loc_oPg.lbl_4c_LblFAtuals
5524:                 .Caption   = "Fator Atual"
5525:                 .FontName  = "Tahoma"
5526:                 .FontSize  = 8
5527:                 .BackStyle = 0
5528:                 .Height    = 15
5529:                 .Left      = 618
5530:                 .Top       = 553
5531:                 .Width     = 56
5532:                 .ForeColor = RGB(90, 90, 90)
5533:                 .Visible   = .T.
5534:             ENDWITH
5535: 
5536:             *-- getFAtuals: fator atual
5537:             loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
5538:             WITH loc_oPg.txt_4c_FAtuals
5539:                 .Alignment     = 3
5540:                 .Height        = 23
5541:                 .InputMask     = "999,999.99999"
5542:                 .Left          = 618
5543:                 .SpecialEffect = 1
5544:                 .Top           = 568
5545:                 .Width         = 105
5546:                 .Value         = 0
5547:                 .Visible       = .T.
5548:             ENDWITH
5549: 
5550:             *-- Say25: "Financeiro"
5551:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
5552:             WITH loc_oPg.lbl_4c_Label25
5553:                 .Caption   = "Financeiro"
5554:                 .FontName  = "Tahoma"
5555:                 .FontSize  = 8
5556:                 .BackStyle = 0
5557:                 .Height    = 15
5558:                 .Left      = 727
5559:                 .Top       = 553

*-- Linhas 5593 a 5636:
5593:                 .BackColor     = RGB(255, 255, 255)
5594:                 .Visible       = .T.
5595:             ENDWITH
5596:             BINDEVENT(loc_oPg.cmd_4c_CmdCalcVals, "Click", THIS, "CmdCalcValsClick")
5597: 
5598:             *==============================================================
5599:             *-- cntMtPrima: container de informacoes de materia prima
5600:             *==============================================================
5601:             loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
5602:             WITH loc_oPg.cnt_4c_MtPrima
5603:                 .Top           = 471
5604:                 .Left          = 785
5605:                 .Width         = 211
5606:                 .Height        = 124
5607:                 .BackStyle     = 0
5608:                 .BorderWidth   = 0
5609:                 .SpecialEffect = 0
5610:                 .Visible       = .T.
5611:             ENDWITH
5612:             loc_oCnt = loc_oPg.cnt_4c_MtPrima
5613: 
5614:             loc_oCnt.AddObject("lbl_4c_LblCompos", "Label")
5615:             WITH loc_oCnt.lbl_4c_LblCompos
5616:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
5617:                 .FontBold  = .F.
5618:                 .FontName  = "Tahoma"
5619:                 .FontSize  = 8
5620:                 .BackStyle = 0
5621:                 .Height    = 15
5622:                 .Left      = 6
5623:                 .Top       = 6
5624:                 .Width     = 66
5625:                 .ForeColor = RGB(90, 90, 90)
5626:                 .Visible   = .T.
5627:             ENDWITH
5628: 
5629:             loc_oCnt.AddObject("txt_4c_Compos", "TextBox")
5630:             WITH loc_oCnt.txt_4c_Compos
5631:                 .FontName            = "Tahoma"
5632:                 .Height              = 23
5633:                 .Left                = 6
5634:                 .SpecialEffect       = 1
5635:                 .Top                 = 20
5636:                 .Width               = 202

*-- Linhas 5775 a 5818:
5775:     * GrdCons: 9 colunas (top=149, left=6, width=987, height=347)
5776:     * grDTEMP: 2 colunas (top=500, left=821, width=172, height=107)
5777:     *===========================================================================
5778:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPg)
5779:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oErro
5780:         TRY
5781:             loc_oPg = par_oPg
5782:             loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
5783: 
5784:             *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
5785:             IF !USED("cursor_4c_GrdConsP")
5786:                 SET NULL ON
5787:                 CREATE CURSOR cursor_4c_GrdConsP ( ;
5788:                     mats      C(14), qtds     N(8,3),  unicompos C(3), ;
5789:                     grupos    C(10), dscgrp   C(20),   ordems    N(2,0), ;
5790:                     qtscons   N(8,3), cats    C(6),    dcats     C(15))
5791:                 SET NULL OFF
5792:             ENDIF
5793:             IF !USED("cursor_4c_GrDTEMP")
5794:                 SET NULL ON
5795:                 CREATE CURSOR cursor_4c_GrDTEMP (grupos C(10), tempopct N(8,3))
5796:                 SET NULL OFF
5797:             ENDIF
5798: 
5799:             *-- grd_4c_GrdConsP: grade principal de consumo por processo (9 colunas)
5800:             *-- Original GrdCons: top=149, left=6, width=987, height=347, columnCount=9
5801:             loc_oPg.AddObject("grd_4c_GrdConsP", "Grid")
5802:             WITH loc_oPg.grd_4c_GrdConsP
5803:                 .Top        = 149
5804:                 .Left       = 6
5805:                 .Width      = 987
5806:                 .Height     = 347
5807:                 .FontName   = "Tahoma"
5808:                 .FontSize   = 8
5809:                 .RecordMark = .F.
5810:                 .DeleteMark = .F.
5811:                 .RowHeight  = 18
5812:                 .ScrollBars = 3
5813:                 .GridLines  = 3
5814:                 .GridLineColor      = RGB(238, 238, 238)
5815:                 .HighlightBackColor = RGB(255, 255, 255)
5816:                 .HighlightForeColor = RGB(15, 41, 104)
5817:                 .HighlightStyle     = 2
5818:                 .AllowHeaderSizing  = .F.

*-- Linhas 5856 a 6001:
5856:             loc_oGrid.Column4.Movable          = .F.
5857:             loc_oGrid.Column4.Resizable        = .F.
5858:             loc_oGrid.Column4.Header1.Caption  = "Fase"
5859:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdConsPCol4FaseValid")
5860: 
5861:             *-- Column5: Descricao fase (dscgrp C20) - editavel, lookup SigCdGcr por descrs
5862:             *-- Original When: Return(Inlist(...) And Empty(Column4.Text1.Value))
5863:             loc_oGrid.Column5.ControlSource    = "cursor_4c_GrdConsP.dscgrp"
5864:             loc_oGrid.Column5.Width            = 180
5865:             loc_oGrid.Column5.ReadOnly         = .F.
5866:             loc_oGrid.Column5.Movable          = .F.
5867:             loc_oGrid.Column5.Resizable        = .F.
5868:             loc_oGrid.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
5869:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdConsPCol5DescFaseValid")
5870: 
5871:             *-- Column6: Ord. (ordems N2) - somente leitura (When=.F. original)
5872:             loc_oGrid.Column6.ControlSource    = "cursor_4c_GrdConsP.ordems"
5873:             loc_oGrid.Column6.Width            = 40
5874:             loc_oGrid.Column6.ReadOnly         = .T.
5875:             loc_oGrid.Column6.Movable          = .F.
5876:             loc_oGrid.Column6.Resizable        = .F.
5877:             loc_oGrid.Column6.InputMask        = "99"
5878:             loc_oGrid.Column6.Header1.Caption  = "Ord."
5879: 
5880:             *-- Column7: Consumo (qtscons N8.3) - editavel
5881:             *-- Original When: Return Inlist(ThisForm.pcEscolha,'INSERIR','ALTERAR')
5882:             loc_oGrid.Column7.ControlSource    = "cursor_4c_GrdConsP.qtscons"
5883:             loc_oGrid.Column7.Width            = 75
5884:             loc_oGrid.Column7.ReadOnly         = .F.
5885:             loc_oGrid.Column7.Movable          = .F.
5886:             loc_oGrid.Column7.Resizable        = .F.
5887:             loc_oGrid.Column7.InputMask        = "9999.999"
5888:             loc_oGrid.Column7.Header1.Caption  = "Consumo"
5889: 
5890:             *-- Column8: Cat. (cats C6) - editavel, lookup SigCdCat por Cods
5891:             *-- Original When: Return(InList(ThisForm.pcEscolha,"INSERIR","ALTERAR"))
5892:             loc_oGrid.Column8.ControlSource    = "cursor_4c_GrdConsP.cats"
5893:             loc_oGrid.Column8.Width            = 55
5894:             loc_oGrid.Column8.ReadOnly         = .F.
5895:             loc_oGrid.Column8.Movable          = .F.
5896:             loc_oGrid.Column8.Resizable        = .F.
5897:             loc_oGrid.Column8.Header1.Caption  = "Cat."
5898:             BINDEVENT(loc_oGrid.Column8.Text1, "Valid", THIS, "GrdConsPCol8CatValid")
5899: 
5900:             *-- Column9: Descricao Cat. (dcats C15) - somente leitura
5901:             loc_oGrid.Column9.ControlSource    = "cursor_4c_GrdConsP.dcats"
5902:             loc_oGrid.Column9.Width            = 185
5903:             loc_oGrid.Column9.ReadOnly         = .T.
5904:             loc_oGrid.Column9.Movable          = .F.
5905:             loc_oGrid.Column9.Resizable        = .F.
5906:             loc_oGrid.Column9.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
5907: 
5908:             BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdConsPAfterRowColChange")
5909: 
5910:             *-- lbl_4c_Label7: "Qtde Componentes :" (Say7: top=505, left=23, w=105)
5911:             loc_oPg.AddObject("lbl_4c_Label7", "Label")
5912:             WITH loc_oPg.lbl_4c_Label7
5913:                 .Caption   = "Qtde Componentes : "
5914:                 .Top       = 505
5915:                 .Left      = 23
5916:                 .Width     = 105
5917:                 .Height    = 15
5918:                 .FontName  = "Tahoma"
5919:                 .FontSize  = 8
5920:                 .ForeColor = RGB(90, 90, 90)
5921:                 .BackStyle = 0
5922:                 .Visible   = .T.
5923:             ENDWITH
5924: 
5925:             *-- txt_4c_Qtcpnt: quantidade componentes (Getqtcpnt: top=500, left=132, w=31, h=23)
5926:             *-- Original When: Return InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
5927:             loc_oPg.AddObject("txt_4c_Qtcpnt", "TextBox")
5928:             WITH loc_oPg.txt_4c_Qtcpnt
5929:                 .Top               = 500
5930:                 .Left              = 132
5931:                 .Width             = 31
5932:                 .Height            = 23
5933:                 .FontName          = "Tahoma"
5934:                 .FontSize          = 8
5935:                 .SpecialEffect     = 1
5936:                 .InputMask         = "99"
5937:                 .Value             = 0
5938:                 .Enabled           = .F.
5939:                 .DisabledBackColor = RGB(255, 255, 255)
5940:                 .DisabledForeColor = RGB(0, 0, 0)
5941:                 .Visible           = .T.
5942:             ENDWITH
5943:             BINDEVENT(loc_oPg.txt_4c_Qtcpnt, "When", THIS, "TxtQtcpntWhen")
5944: 
5945:             *-- chk_4c_ChkFund: (chkFund: top=525, left=11, w=182, h=15)
5946:             *-- Original caption: "Nao Checar Cadastro de Fundicao"
5947:             loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
5948:             WITH loc_oPg.chk_4c_ChkFund
5949:                 .Caption   = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
5950:                 .Top       = 525
5951:                 .Left      = 11
5952:                 .Width     = 182
5953:                 .Height    = 15
5954:                 .FontName  = "Tahoma"
5955:                 .FontSize  = 8
5956:                 .ForeColor = RGB(90, 90, 90)
5957:                 .BackStyle = 0
5958:                 .Value     = 0
5959:                 .Visible   = .T.
5960:             ENDWITH
5961:             BINDEVENT(loc_oPg.chk_4c_ChkFund, "Click", THIS, "ChkFundClick")
5962: 
5963:             *-- lbl_4c_Label1: "Tempo Producao por Agrupamento :" (Say1: top=501, left=643, w=176)
5964:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
5965:             WITH loc_oPg.lbl_4c_Label1
5966:                 .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
5967:                 .Top       = 501
5968:                 .Left      = 643
5969:                 .Width     = 176
5970:                 .Height    = 15
5971:                 .FontName  = "Tahoma"
5972:                 .FontSize  = 8
5973:                 .ForeColor = RGB(90, 90, 90)
5974:                 .BackStyle = 0
5975:                 .Visible   = .T.
5976:             ENDWITH
5977: 
5978:             *-- grd_4c_GrDTEMP: grade tempo producao por agrupamento
5979:             *-- Original grDTEMP: top=500, left=821, w=172, h=107, 2 colunas (ambas readonly)
5980:             loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
5981:             WITH loc_oPg.grd_4c_GrDTEMP
5982:                 .Top        = 500
5983:                 .Left       = 821
5984:                 .Width      = 172
5985:                 .Height     = 107
5986:                 .FontName   = "Tahoma"
5987:                 .FontSize   = 8
5988:                 .RecordMark = .F.
5989:                 .DeleteMark = .F.
5990:                 .RowHeight  = 18
5991:                 .ScrollBars = 2
5992:                 .GridLines  = 3
5993:                 .AllowHeaderSizing = .F.
5994:                 .AllowRowSizing    = .F.
5995:                 .Visible    = .T.
5996:             ENDWITH
5997:             loc_oPg.grd_4c_GrDTEMP.ColumnCount  = 2
5998:             loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
5999:             loc_oGrid2 = loc_oPg.grd_4c_GrDTEMP
6000: 
6001:             *-- Column1: Agrupamento (grupos C10) - somente leitura (When=.F. original)

*-- Linhas 6018 a 6206:
6018:     ENDPROC
6019: 
6020:     *===========================================================================
6021:     * Handlers de BINDEVENT para pgDadosConsP (Page5)
6022:     * Todos PUBLIC - requerido pelo BINDEVENT
6023:     *===========================================================================
6024: 
6025:     *-- Controla acesso ao campo Qtde Componentes
6026:     *-- Original When: Return InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
6027:     PROCEDURE TxtQtcpntWhen()
6028:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
6029:     ENDPROC
6030: 
6031:     *-- Checkbox "Nao Checar Cadastro de Fundicao"
6032:     PROCEDURE ChkFundClick()
6033:         LOCAL loc_oPg, loException
6034:         TRY
6035:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
6036:             IF PEMSTATUS(loc_oPg, "chk_4c_ChkFund", 5) AND VARTYPE(THIS.this_oBusinessObject) = "O"
6037:                 THIS.this_oBusinessObject.this_lChkfunds = (loc_oPg.chk_4c_ChkFund.Value = 1)
6038:             ENDIF
6039:         CATCH TO loException
6040:             MostrarErro("Erro ao atualizar ChkFund:" + CHR(13) + loException.Message, ;
6041:                 "FormProduto.ChkFundClick")
6042:         ENDTRY
6043:     ENDPROC
6044: 
6045:     *-- Column4 (Fase/Grupos): Valid - lookup SigCdGcr por codigos
6046:     *-- Original: fwBuscaInt crSigCdPrf GrpOrdem (Grupos+Ordems)
6047:     PROCEDURE GrdConsPCol4FaseValid()
6048:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6049:             RETURN .T.
6050:         ENDIF
6051:         LOCAL loc_cGrupos, loc_nRet, loc_lSucesso, loException
6052:         loc_lSucesso = .T.
6053:         TRY
6054:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6055:                 loc_cGrupos = ALLTRIM(cursor_4c_GrdConsP.grupos)
6056:                 IF !EMPTY(loc_cGrupos)
6057:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6058:                         "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupos), ;
6059:                         "cursor_4c_GcrFase")
6060:                     IF loc_nRet > 0 AND USED("cursor_4c_GcrFase") AND !EOF("cursor_4c_GcrFase")
6061:                         SELECT cursor_4c_GrdConsP
6062:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(cursor_4c_GcrFase.descrs)
6063:                         IF USED("cursor_4c_GcrFase")
6064:                             USE IN cursor_4c_GcrFase
6065:                         ENDIF
6066:                     ELSE
6067:                         IF USED("cursor_4c_GcrFase")
6068:                             USE IN cursor_4c_GcrFase
6069:                         ENDIF
6070:                         THIS.AbrirBuscaFaseConsP()
6071:                     ENDIF
6072:                 ENDIF
6073:             ENDIF
6074:         CATCH TO loException
6075:             IF USED("cursor_4c_GcrFase")
6076:                 USE IN cursor_4c_GcrFase
6077:             ENDIF
6078:             MostrarErro("Erro ao validar Fase:" + CHR(13) + loException.Message, ;
6079:                 "FormProduto.GrdConsPCol4FaseValid")
6080:         ENDTRY
6081:         RETURN loc_lSucesso
6082:     ENDPROC
6083: 
6084:     *-- Column5 (Descricao Fase/dscgrp): Valid - lookup SigCdGcr por descrs
6085:     *-- Original: fwBuscaInt crSigCdPrf Descrs
6086:     PROCEDURE GrdConsPCol5DescFaseValid()
6087:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6088:             RETURN .T.
6089:         ENDIF
6090:         LOCAL loc_cDescrs, loc_nRet, loc_lSucesso, loException
6091:         loc_lSucesso = .T.
6092:         TRY
6093:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6094:                 loc_cDescrs = ALLTRIM(cursor_4c_GrdConsP.dscgrp)
6095:                 IF !EMPTY(loc_cDescrs)
6096:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6097:                         "SELECT codigos, descrs FROM SigCdGcr WHERE descrs = " + EscaparSQL(loc_cDescrs), ;
6098:                         "cursor_4c_GcrDescFase")
6099:                     IF loc_nRet > 0 AND USED("cursor_4c_GcrDescFase") AND !EOF("cursor_4c_GcrDescFase")
6100:                         SELECT cursor_4c_GrdConsP
6101:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(cursor_4c_GcrDescFase.codigos)
6102:                         IF USED("cursor_4c_GcrDescFase")
6103:                             USE IN cursor_4c_GcrDescFase
6104:                         ENDIF
6105:                     ELSE
6106:                         IF USED("cursor_4c_GcrDescFase")
6107:                             USE IN cursor_4c_GcrDescFase
6108:                         ENDIF
6109:                         THIS.AbrirBuscaDescFaseConsP()
6110:                     ENDIF
6111:                 ENDIF
6112:             ENDIF
6113:         CATCH TO loException
6114:             IF USED("cursor_4c_GcrDescFase")
6115:                 USE IN cursor_4c_GcrDescFase
6116:             ENDIF
6117:             MostrarErro("Erro ao validar Descri" + CHR(231) + CHR(227) + "o Fase:" + ;
6118:                 CHR(13) + loException.Message, "FormProduto.GrdConsPCol5DescFaseValid")
6119:         ENDTRY
6120:         RETURN loc_lSucesso
6121:     ENDPROC
6122: 
6123:     *-- Column8 (Cat./cats): Valid - lookup SigCdCat por Cods
6124:     *-- Original: fwBuscaExt SigCdCat CrListaRemota Cods
6125:     PROCEDURE GrdConsPCol8CatValid()
6126:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6127:             RETURN .T.
6128:         ENDIF
6129:         LOCAL loc_cCats, loc_nRet, loc_lSucesso, loException
6130:         loc_lSucesso = .T.
6131:         TRY
6132:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6133:                 loc_cCats = ALLTRIM(cursor_4c_GrdConsP.cats)
6134:                 IF EMPTY(loc_cCats)
6135:                     SELECT cursor_4c_GrdConsP
6136:                     REPLACE cursor_4c_GrdConsP.dcats WITH ""
6137:                 ELSE
6138:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6139:                         "SELECT cods, descs FROM SigCdCat WHERE cods = " + EscaparSQL(loc_cCats), ;
6140:                         "cursor_4c_CatBusca")
6141:                     IF loc_nRet > 0 AND USED("cursor_4c_CatBusca") AND !EOF("cursor_4c_CatBusca")
6142:                         SELECT cursor_4c_GrdConsP
6143:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(cursor_4c_CatBusca.descs)
6144:                         IF USED("cursor_4c_CatBusca")
6145:                             USE IN cursor_4c_CatBusca
6146:                         ENDIF
6147:                     ELSE
6148:                         IF USED("cursor_4c_CatBusca")
6149:                             USE IN cursor_4c_CatBusca
6150:                         ENDIF
6151:                         THIS.AbrirBuscaCatConsP()
6152:                     ENDIF
6153:                 ENDIF
6154:             ENDIF
6155:         CATCH TO loException
6156:             IF USED("cursor_4c_CatBusca")
6157:                 USE IN cursor_4c_CatBusca
6158:             ENDIF
6159:             MostrarErro("Erro ao validar Categoria:" + CHR(13) + loException.Message, ;
6160:                 "FormProduto.GrdConsPCol8CatValid")
6161:         ENDTRY
6162:         RETURN loc_lSucesso
6163:     ENDPROC
6164: 
6165:     *-- AfterRowColChange: atualiza colunas de descricao ao navegar no grid
6166:     PROCEDURE GrdConsPAfterRowColChange(par_nColIndex)
6167:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6168:             RETURN
6169:         ENDIF
6170:         LOCAL loc_nRet, loException
6171:         TRY
6172:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6173:                 *-- Atualizar dcats (Column9) se cats (Column8) foi preenchido
6174:                 IF !EMPTY(ALLTRIM(cursor_4c_GrdConsP.cats)) AND EMPTY(ALLTRIM(cursor_4c_GrdConsP.dcats))
6175:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6176:                         "SELECT descs FROM SigCdCat WHERE cods = " + EscaparSQL(ALLTRIM(cursor_4c_GrdConsP.cats)), ;
6177:                         "cursor_4c_GCatDesc")
6178:                     IF loc_nRet > 0 AND USED("cursor_4c_GCatDesc") AND !EOF("cursor_4c_GCatDesc")
6179:                         SELECT cursor_4c_GrdConsP
6180:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(cursor_4c_GCatDesc.descs)
6181:                     ENDIF
6182:                     IF USED("cursor_4c_GCatDesc")
6183:                         USE IN cursor_4c_GCatDesc
6184:                     ENDIF
6185:                 ENDIF
6186:                 *-- Atualizar dscgrp (Column5) se grupos (Column4) foi preenchido e dscgrp vazio
6187:                 IF !EMPTY(ALLTRIM(cursor_4c_GrdConsP.grupos)) AND EMPTY(ALLTRIM(cursor_4c_GrdConsP.dscgrp))
6188:                     loc_nRet = SQLEXEC(gnConnHandle, ;
6189:                         "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(ALLTRIM(cursor_4c_GrdConsP.grupos)), ;
6190:                         "cursor_4c_GFaseDesc")
6191:                     IF loc_nRet > 0 AND USED("cursor_4c_GFaseDesc") AND !EOF("cursor_4c_GFaseDesc")
6192:                         SELECT cursor_4c_GrdConsP
6193:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(cursor_4c_GFaseDesc.descrs)
6194:                     ENDIF
6195:                     IF USED("cursor_4c_GFaseDesc")
6196:                         USE IN cursor_4c_GFaseDesc
6197:                     ENDIF
6198:                 ENDIF
6199:             ENDIF
6200:         CATCH TO loException
6201:             IF USED("cursor_4c_GCatDesc")
6202:                 USE IN cursor_4c_GCatDesc
6203:             ENDIF
6204:             IF USED("cursor_4c_GFaseDesc")
6205:                 USE IN cursor_4c_GFaseDesc
6206:             ENDIF

*-- Linhas 6213 a 6406:
6213:     * AbrirBuscaFaseConsP - Lookup de fase/processo para Column4 de GrdConsP
6214:     * Tabela: SigCdGcr (codigos C10, descrs C40)
6215:     *===========================================================================
6216:     PROCEDURE AbrirBuscaFaseConsP()
6217:         LOCAL loc_oBusca, loc_cValAtual, loc_nRet, loException
6218:         TRY
6219:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6220:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.grupos)
6221: 
6222:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6223:                     "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE " + ;
6224:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
6225:                     "cursor_4c_FaseBusca")
6226: 
6227:                 IF loc_nRet <= 0 OR !USED("cursor_4c_FaseBusca") OR EOF("cursor_4c_FaseBusca")
6228:                     IF USED("cursor_4c_FaseBusca")
6229:                         USE IN cursor_4c_FaseBusca
6230:                     ENDIF
6231:                     SQLEXEC(gnConnHandle, "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
6232:                         "cursor_4c_FaseBusca")
6233:                 ENDIF
6234: 
6235:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6236:                 IF VARTYPE(loc_oBusca) = "O"
6237:                     loc_oBusca.this_cCursorDestino = "cursor_4c_FaseBusca"
6238:                     loc_oBusca.DefinirCursor("cursor_4c_FaseBusca", "codigos", "descrs", ;
6239:                         "Buscar Fase/Processo")
6240:                     loc_oBusca.Mostrar()
6241:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6242:                         SELECT cursor_4c_GrdConsP
6243:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6244:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6245:                     ENDIF
6246:                     loc_oBusca = .NULL.
6247:                 ENDIF
6248: 
6249:                 IF USED("cursor_4c_FaseBusca")
6250:                     USE IN cursor_4c_FaseBusca
6251:                 ENDIF
6252:             ENDIF
6253:         CATCH TO loException
6254:             IF USED("cursor_4c_FaseBusca")
6255:                 USE IN cursor_4c_FaseBusca
6256:             ENDIF
6257:             MostrarErro("Erro ao buscar Fase:" + CHR(13) + loException.Message, ;
6258:                 "FormProduto.AbrirBuscaFaseConsP")
6259:         ENDTRY
6260:     ENDPROC
6261: 
6262:     *===========================================================================
6263:     * AbrirBuscaDescFaseConsP - Lookup de fase por descricao para Column5 de GrdConsP
6264:     * Tabela: SigCdGcr (codigos C10, descrs C40)
6265:     *===========================================================================
6266:     PROCEDURE AbrirBuscaDescFaseConsP()
6267:         LOCAL loc_oBusca, loc_cValAtual, loc_nRet, loException
6268:         TRY
6269:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6270:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.dscgrp)
6271: 
6272:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6273:                     "SELECT descrs, codigos FROM SigCdGcr WHERE descrs LIKE " + ;
6274:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY descrs", ;
6275:                     "cursor_4c_DescFaseBusca")
6276: 
6277:                 IF loc_nRet <= 0 OR !USED("cursor_4c_DescFaseBusca") OR EOF("cursor_4c_DescFaseBusca")
6278:                     IF USED("cursor_4c_DescFaseBusca")
6279:                         USE IN cursor_4c_DescFaseBusca
6280:                     ENDIF
6281:                     SQLEXEC(gnConnHandle, "SELECT descrs, codigos FROM SigCdGcr ORDER BY descrs", ;
6282:                         "cursor_4c_DescFaseBusca")
6283:                 ENDIF
6284: 
6285:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6286:                 IF VARTYPE(loc_oBusca) = "O"
6287:                     loc_oBusca.this_cCursorDestino = "cursor_4c_DescFaseBusca"
6288:                     loc_oBusca.DefinirCursor("cursor_4c_DescFaseBusca", "descrs", "codigos", ;
6289:                         "Buscar Fase por Descri" + CHR(231) + CHR(227) + "o")
6290:                     loc_oBusca.Mostrar()
6291:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6292:                         SELECT cursor_4c_GrdConsP
6293:                         REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6294:                         REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6295:                     ENDIF
6296:                     loc_oBusca = .NULL.
6297:                 ENDIF
6298: 
6299:                 IF USED("cursor_4c_DescFaseBusca")
6300:                     USE IN cursor_4c_DescFaseBusca
6301:                 ENDIF
6302:             ENDIF
6303:         CATCH TO loException
6304:             IF USED("cursor_4c_DescFaseBusca")
6305:                 USE IN cursor_4c_DescFaseBusca
6306:             ENDIF
6307:             MostrarErro("Erro ao buscar Fase por descri" + CHR(231) + CHR(227) + "o:" + ;
6308:                 CHR(13) + loException.Message, "FormProduto.AbrirBuscaDescFaseConsP")
6309:         ENDTRY
6310:     ENDPROC
6311: 
6312:     *===========================================================================
6313:     * AbrirBuscaCatConsP - Lookup de categoria para Column8 de GrdConsP
6314:     * Tabela: SigCdCat (cods C6, descs C15)
6315:     *===========================================================================
6316:     PROCEDURE AbrirBuscaCatConsP()
6317:         LOCAL loc_oBusca, loc_cValAtual, loc_nRet, loException
6318:         TRY
6319:             IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6320:                 loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.cats)
6321: 
6322:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6323:                     "SELECT cods, descs FROM SigCdCat WHERE cods LIKE " + ;
6324:                     EscaparSQL(loc_cValAtual + "%") + " ORDER BY cods", ;
6325:                     "cursor_4c_CatBusca")
6326: 
6327:                 IF loc_nRet <= 0 OR !USED("cursor_4c_CatBusca") OR EOF("cursor_4c_CatBusca")
6328:                     IF USED("cursor_4c_CatBusca")
6329:                         USE IN cursor_4c_CatBusca
6330:                     ENDIF
6331:                     SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCat ORDER BY cods", ;
6332:                         "cursor_4c_CatBusca")
6333:                 ENDIF
6334: 
6335:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6336:                 IF VARTYPE(loc_oBusca) = "O"
6337:                     loc_oBusca.this_cCursorDestino = "cursor_4c_CatBusca"
6338:                     loc_oBusca.DefinirCursor("cursor_4c_CatBusca", "cods", "descs", "Buscar Categoria")
6339:                     loc_oBusca.Mostrar()
6340:                     IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
6341:                         SELECT cursor_4c_GrdConsP
6342:                         REPLACE cursor_4c_GrdConsP.cats  WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
6343:                         REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
6344:                     ENDIF
6345:                     loc_oBusca = .NULL.
6346:                 ENDIF
6347: 
6348:                 IF USED("cursor_4c_CatBusca")
6349:                     USE IN cursor_4c_CatBusca
6350:                 ENDIF
6351:             ENDIF
6352:         CATCH TO loException
6353:             IF USED("cursor_4c_CatBusca")
6354:                 USE IN cursor_4c_CatBusca
6355:             ENDIF
6356:             MostrarErro("Erro ao buscar Categoria:" + CHR(13) + loException.Message, ;
6357:                 "FormProduto.AbrirBuscaCatConsP")
6358:         ENDTRY
6359:     ENDPROC
6360: 
6361:     *===========================================================================
6362:     * Handlers de BINDEVENT para pgCusto (Page2)
6363:     * Todos PUBLIC - requerido pelo BINDEVENT
6364:     *===========================================================================
6365: 
6366:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
6367:         LOCAL loc_oPg, loc_nRet, loException
6368:         TRY
6369:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
6370:             IF !USED("cursor_4c_GrdCompo") OR EOF("cursor_4c_GrdCompo")
6371:                 RETURN
6372:             ENDIF
6373:             IF !EMPTY(cursor_4c_GrdCompo.cpros)
6374:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6375:                     "SELECT dpros FROM SigCdPro WHERE cpros = '" + ;
6376:                     EscaparSQL(ALLTRIM(cursor_4c_GrdCompo.cpros)) + "", ;
6377:                     "cursor_4c_DescCusto")
6378:                 IF loc_nRet > 0 AND USED("cursor_4c_DescCusto") AND !EOF("cursor_4c_DescCusto")
6379:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6380:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_DescCusto.dpros)
6381:                     ENDIF
6382:                     USE IN cursor_4c_DescCusto
6383:                 ENDIF
6384:             ELSE
6385:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6386:                     loc_oPg.txt_4c_Desc.Value = ""
6387:                 ENDIF
6388:             ENDIF
6389:             IF !EMPTY(cursor_4c_GrdCompo.cpros)
6390:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6391:                     "SELECT b.dgrus FROM SigCdPro a " + ;
6392:                     "INNER JOIN SigCdGrp b ON a.cgrus = b.cgrus " + ;
6393:                     "WHERE a.cpros = " + EscaparSQL(ALLTRIM(cursor_4c_GrdCompo.cpros)) + "", ;
6394:                     "cursor_4c_GruCusto")
6395:                 IF loc_nRet > 0 AND USED("cursor_4c_GruCusto") AND !EOF("cursor_4c_GruCusto")
6396:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
6397:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCusto.dgrus)
6398:                     ENDIF
6399:                     USE IN cursor_4c_GruCusto
6400:                 ENDIF
6401:             ELSE
6402:                 IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
6403:                     loc_oPg.txt_4c_DGruCompos.Value = ""
6404:                 ENDIF
6405:             ENDIF
6406:         CATCH TO loException

*-- Linhas 6415 a 7143:
6415:         ENDTRY
6416:     ENDPROC
6417: 
6418:     PROCEDURE CmgCustoClick()
6419:         LOCAL loc_oPg, loc_nBotao
6420:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
6421:         loc_nBotao = loc_oPg.cmg_4c_CmdgCusto.Value
6422:         DO CASE
6423:         CASE loc_nBotao = 1
6424:             THIS.CmdCustoInserirClick()
6425:         CASE loc_nBotao = 2
6426:             THIS.CmdCustoExcluirClick()
6427:         ENDCASE
6428:     ENDPROC
6429: 
6430:     PROCEDURE CmdCustoInserirClick()
6431:         LOCAL loException
6432:         TRY
6433:             IF !USED("cursor_4c_GrdCompo")
6434:                 RETURN
6435:             ENDIF
6436:             SELECT cursor_4c_GrdCompo
6437:             APPEND BLANK
6438:         CATCH TO loException
6439:             MostrarErro("Erro ao inserir item de custo:" + CHR(13) + loException.Message, ;
6440:                 "FormProduto.CmdCustoInserirClick")
6441:         ENDTRY
6442:     ENDPROC
6443: 
6444:     PROCEDURE CmdCustoExcluirClick()
6445:         LOCAL loc_lConfirma, loException
6446:         TRY
6447:             IF !USED("cursor_4c_GrdCompo") OR EOF("cursor_4c_GrdCompo")
6448:                 RETURN
6449:             ENDIF
6450:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste item de custo?")
6451:             IF loc_lConfirma
6452:                 SELECT cursor_4c_GrdCompo
6453:                 DELETE
6454:                 IF !EOF()
6455:                     SKIP
6456:                     SKIP -1
6457:                 ENDIF
6458:             ENDIF
6459:         CATCH TO loException
6460:             MostrarErro("Erro ao excluir item de custo:" + CHR(13) + loException.Message, ;
6461:                 "FormProduto.CmdCustoExcluirClick")
6462:         ENDTRY
6463:     ENDPROC
6464: 
6465:     PROCEDURE CboTiposCustoInteractiveChange()
6466:         LOCAL loc_oPg, loc_cTipo, loException
6467:         TRY
6468:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
6469:             IF PEMSTATUS(loc_oPg, "cbo_4c_CmbTipos", 5) AND USED("cursor_4c_GrdCompo")
6470:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
6471:                 SELECT cursor_4c_GrdCompo
6472:                 IF EMPTY(loc_cTipo)
6473:                     SET FILTER TO
6474:                 ELSE
6475:                     SET FILTER TO ALLTRIM(cursor_4c_GrdCompo.cunis) = loc_cTipo
6476:                 ENDIF
6477:                 GO TOP
6478:                 IF PEMSTATUS(loc_oPg, "grd_4c_GrdCusto", 5)
6479:                     loc_oPg.grd_4c_GrdCusto.Refresh()
6480:                 ENDIF
6481:             ENDIF
6482:         CATCH TO loException
6483:             MostrarErro("Erro ao filtrar tipos de custo:" + CHR(13) + loException.Message, ;
6484:                 "FormProduto.CboTiposCustoInteractiveChange")
6485:         ENDTRY
6486:     ENDPROC
6487: 
6488:     *===========================================================================
6489:     * Handlers de BINDEVENT para pgComposicao
6490:     * Todos PUBLIC - requerido pelo BINDEVENT
6491:     *===========================================================================
6492: 
6493:     PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
6494:         LOCAL loc_oPg, loException
6495:         TRY
6496:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6497:             IF USED("cursor_4c_GrdCompo") AND !EOF("cursor_4c_GrdCompo") AND !BOF("cursor_4c_GrdCompo")
6498:                 SELECT cursor_4c_GrdCompo
6499:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
6500:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_GrdCompo.dpros)
6501:                 ENDIF
6502:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
6503:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_GrdCompo.matprinc)
6504:                 ENDIF
6505:             ENDIF
6506:         CATCH TO loException
6507:             MostrarErro("Erro ao navegar composicao:" + CHR(13) + loException.Message, ;
6508:                 "FormProduto.GrdCompoAfterRowColChange")
6509:         ENDTRY
6510:     ENDPROC
6511: 
6512:     PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
6513:         LOCAL loc_oPg, loException
6514:         TRY
6515:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6516:             IF USED("cursor_4c_GrdSubCp") AND !EOF("cursor_4c_GrdSubCp") AND !BOF("cursor_4c_GrdSubCp")
6517:                 SELECT cursor_4c_GrdSubCp
6518:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
6519:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_GrdSubCp.dpros)
6520:                 ENDIF
6521:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
6522:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_GrdSubCp.matprinc)
6523:                 ENDIF
6524:             ENDIF
6525:         CATCH TO loException
6526:             MostrarErro("Erro ao navegar subcomposicao:" + CHR(13) + loException.Message, ;
6527:                 "FormProduto.GrdSubCpAfterRowColChange")
6528:         ENDTRY
6529:     ENDPROC
6530: 
6531:     PROCEDURE CmgCompoClick()
6532:         LOCAL loc_oPg, loc_nBotao
6533:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6534:         loc_nBotao = loc_oPg.cmg_4c_CmdgCompo.Value
6535:         DO CASE
6536:         CASE loc_nBotao = 1
6537:             THIS.CmdCompoInserirClick()
6538:         CASE loc_nBotao = 2
6539:             THIS.CmdCompoExcluirClick()
6540:         CASE loc_nBotao = 3
6541:             THIS.CmdCompoAtualizaClick()
6542:         CASE loc_nBotao = 4
6543:             THIS.CmdCompoPrecoClick()
6544:         CASE loc_nBotao = 5
6545:             THIS.CmdAtuPesosClick()
6546:         ENDCASE
6547:     ENDPROC
6548: 
6549:     PROCEDURE CmgSubCpClick()
6550:         LOCAL loc_oPg, loc_nBotao
6551:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6552:         loc_nBotao = loc_oPg.cmg_4c_CmdgSubCp.Value
6553:         DO CASE
6554:         CASE loc_nBotao = 1
6555:             THIS.CmdSubCpInserirClick()
6556:         CASE loc_nBotao = 2
6557:             THIS.CmdSubCpExcluirClick()
6558:         ENDCASE
6559:     ENDPROC
6560: 
6561:     PROCEDURE CmdCompoInserirClick()
6562:         MsgInfo("Inserir item de composi" + CHR(231) + CHR(227) + "o - a implementar")
6563:     ENDPROC
6564: 
6565:     PROCEDURE CmdCompoExcluirClick()
6566:         MsgInfo("Excluir item de composi" + CHR(231) + CHR(227) + "o - a implementar")
6567:     ENDPROC
6568: 
6569:     PROCEDURE CmdCompoAtualizaClick()
6570:         MsgInfo("Atualizar custo da composi" + CHR(231) + CHR(227) + "o - a implementar")
6571:     ENDPROC
6572: 
6573:     PROCEDURE CmdCompoPrecoClick()
6574:         MsgInfo("Atualizar pre" + CHR(231) + "o da composi" + CHR(231) + CHR(227) + "o - a implementar")
6575:     ENDPROC
6576: 
6577:     PROCEDURE CmdAtuPesosClick()
6578:         MsgInfo("Atualizar pesos - a implementar")
6579:     ENDPROC
6580: 
6581:     PROCEDURE CmdSubCpInserirClick()
6582:         MsgInfo("Inserir subcomponente - a implementar")
6583:     ENDPROC
6584: 
6585:     PROCEDURE CmdSubCpExcluirClick()
6586:         MsgInfo("Excluir subcomponente - a implementar")
6587:     ENDPROC
6588: 
6589:     PROCEDURE ChkLiberaCustoClick()
6590:         LOCAL loc_oPg, loc_lLibera, loException
6591:         TRY
6592:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6593:             loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1)
6594:             IF loc_lLibera
6595:                 loc_oPg.chk_4c_ChkLiberaCusto.Picture = gc_4c_CaminhoIcones + "geral_lock_off_34.jpg"
6596:             ELSE
6597:                 loc_oPg.chk_4c_ChkLiberaCusto.Picture = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
6598:             ENDIF
6599:             IF PEMSTATUS(loc_oPg, "txt_4c_Pcus", 5)
6600:                 loc_oPg.txt_4c_Pcus.ReadOnly   = !loc_lLibera
6601:             ENDIF
6602:             IF PEMSTATUS(loc_oPg, "txt_4c_Fcusto", 5)
6603:                 loc_oPg.txt_4c_Fcusto.ReadOnly = !loc_lLibera
6604:             ENDIF
6605:             IF PEMSTATUS(loc_oPg, "txt_4c_Custof", 5)
6606:                 loc_oPg.txt_4c_Custof.ReadOnly = !loc_lLibera
6607:             ENDIF
6608:             IF PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
6609:                 loc_oPg.txt_4c_Cmkpc.ReadOnly  = !loc_lLibera
6610:             ENDIF
6611:         CATCH TO loException
6612:             MostrarErro("Erro ao alternar bloqueio de custo:" + CHR(13) + loException.Message, ;
6613:                 "FormProduto.ChkLiberaCustoClick")
6614:         ENDTRY
6615:     ENDPROC
6616: 
6617:     PROCEDURE ChkLiberaVendaClick()
6618:         LOCAL loc_oPg, loc_lLibera, loException
6619:         TRY
6620:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6621:             loc_lLibera = (loc_oPg.chk_4c_ChkLiberaVenda.Value = 1)
6622:             IF loc_lLibera
6623:                 loc_oPg.chk_4c_ChkLiberaVenda.Picture = gc_4c_CaminhoIcones + "geral_lock_off_34.jpg"
6624:             ELSE
6625:                 loc_oPg.chk_4c_ChkLiberaVenda.Picture = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
6626:             ENDIF
6627:             IF PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
6628:                 loc_oPg.txt_4c_Pven.ReadOnly   = !loc_lLibera
6629:             ENDIF
6630:             IF PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
6631:                 loc_oPg.txt_4c_Fvenda.ReadOnly = !loc_lLibera
6632:             ENDIF
6633:             IF PEMSTATUS(loc_oPg, "txt_4c_Margem", 5)
6634:                 loc_oPg.txt_4c_Margem.ReadOnly = !loc_lLibera
6635:             ENDIF
6636:             IF PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
6637:                 loc_oPg.txt_4c_Ftio.ReadOnly   = !loc_lLibera
6638:             ENDIF
6639:         CATCH TO loException
6640:             MostrarErro("Erro ao alternar bloqueio de venda:" + CHR(13) + loException.Message, ;
6641:                 "FormProduto.ChkLiberaVendaClick")
6642:         ENDTRY
6643:     ENDPROC
6644: 
6645:     PROCEDURE ChkPlanCusClick()
6646:         LOCAL loc_oPg, loc_lAtivo, loException
6647:         TRY
6648:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6649:             loc_lAtivo = (loc_oPg.chk_4c_ChkPlanCus.Value = 1)
6650:             IF PEMSTATUS(loc_oPg, "txt_4c__pftioc", 5)
6651:                 IF loc_lAtivo
6652:                     loc_oPg.txt_4c__pftioc.BackColor = RGB(255, 255, 0)
6653:                     loc_oPg.txt_4c__pftioc.ReadOnly  = .F.
6654:                 ELSE
6655:                     loc_oPg.txt_4c__pftioc.BackColor = RGB(240, 240, 240)
6656:                     loc_oPg.txt_4c__pftioc.ReadOnly  = .T.
6657:                 ENDIF
6658:             ENDIF
6659:         CATCH TO loException
6660:             MostrarErro("Erro ao alternar planejamento de custo:" + CHR(13) + loException.Message, ;
6661:                 "FormProduto.ChkPlanCusClick")
6662:         ENDTRY
6663:     ENDPROC
6664: 
6665:     PROCEDURE ChkPlanVenClick()
6666:         LOCAL loc_oPg, loc_lAtivo, loException
6667:         TRY
6668:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6669:             loc_lAtivo = (loc_oPg.chk_4c_ChkPlanVen.Value = 1)
6670:             IF PEMSTATUS(loc_oPg, "txt_4c_Pftio", 5)
6671:                 IF loc_lAtivo
6672:                     loc_oPg.txt_4c_Pftio.BackColor = RGB(255, 255, 0)
6673:                     loc_oPg.txt_4c_Pftio.ReadOnly  = .F.
6674:                 ELSE
6675:                     loc_oPg.txt_4c_Pftio.BackColor = RGB(240, 240, 240)
6676:                     loc_oPg.txt_4c_Pftio.ReadOnly  = .T.
6677:                 ENDIF
6678:             ENDIF
6679:         CATCH TO loException
6680:             MostrarErro("Erro ao alternar planejamento de venda:" + CHR(13) + loException.Message, ;
6681:                 "FormProduto.ChkPlanVenClick")
6682:         ENDTRY
6683:     ENDPROC
6684: 
6685:     PROCEDURE ChkPvendaClick()
6686:         LOCAL loc_oPg, loException
6687:         TRY
6688:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6689:             IF PEMSTATUS(loc_oPg, "txt_4c_Pvideal", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
6690:                 loc_oPg.txt_4c_Pven.Value = loc_oPg.txt_4c_Pvideal.Value
6691:             ENDIF
6692:             IF PEMSTATUS(loc_oPg, "txt_4c_FIdeals", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
6693:                 loc_oPg.txt_4c_Fvenda.Value = loc_oPg.txt_4c_FIdeals.Value
6694:             ENDIF
6695:             IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Moec", 5)
6696:                 loc_oPg.txt_4c_Moev.Value = loc_oPg.txt_4c_Moec.Value
6697:             ENDIF
6698:             IF PEMSTATUS(loc_oPg, "chk_4c_Chk_Pvenda", 5)
6699:                 loc_oPg.chk_4c_Chk_Pvenda.Value = 0
6700:             ENDIF
6701:         CATCH TO loException
6702:             MostrarErro("Erro ao copiar pre" + CHR(231) + "o ideal:" + CHR(13) + loException.Message, ;
6703:                 "FormProduto.ChkPvendaClick")
6704:         ENDTRY
6705:     ENDPROC
6706: 
6707:     PROCEDURE CmdCalcValsClick()
6708:         MsgInfo("Calcular valores pelas moedas - a implementar")
6709:     ENDPROC
6710: 
6711:     PROCEDURE TxtObsOFsWhen()
6712:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
6713:     ENDPROC
6714: 
6715:     PROCEDURE TxtObsOFsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6716:         LOCAL loc_oPg, loException
6717:         IF par_nKeyCode = 13
6718:             TRY
6719:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6720:                 IF USED("cursor_4c_GrdCompo") AND !EOF("cursor_4c_GrdCompo") AND ;
6721:                         PEMSTATUS(loc_oPg, "txt_4c_ObsOFs", 5)
6722:                     SELECT cursor_4c_GrdCompo
6723:                     REPLACE cursor_4c_GrdCompo.obs WITH ;
6724:                         ALLTRIM(loc_oPg.txt_4c_ObsOFs.Value)
6725:                 ENDIF
6726:             CATCH TO loException
6727:                 MostrarErro("Erro ao salvar obs OFs:" + CHR(13) + loException.Message, ;
6728:                     "FormProduto.TxtObsOFsKeyPress")
6729:             ENDTRY
6730:         ENDIF
6731:     ENDPROC
6732: 
6733:     *-- Validacoes/lookups de moeda (SigCdMoe: cmoeds, dmoeds)
6734: 
6735:     PROCEDURE ValidarMoec(par_nKeyCode, par_nShiftAltCtrl)
6736:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6737:             RETURN
6738:         ENDIF
6739:         LOCAL loc_oPg, loc_cCod
6740:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6741:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moec", 5)
6742:             RETURN
6743:         ENDIF
6744:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moec.Value)
6745:         IF EMPTY(loc_cCod)
6746:             RETURN
6747:         ENDIF
6748:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moec")
6749:     ENDPROC
6750: 
6751:     PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6752:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6753:             THIS.ValidarMoec()
6754:         ENDIF
6755:     ENDPROC
6756: 
6757:     PROCEDURE ValidarMoepc(par_nKeyCode, par_nShiftAltCtrl)
6758:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6759:             RETURN
6760:         ENDIF
6761:         LOCAL loc_oPg, loc_cCod
6762:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6763:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moepc", 5)
6764:             RETURN
6765:         ENDIF
6766:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepc.Value)
6767:         IF EMPTY(loc_cCod)
6768:             RETURN
6769:         ENDIF
6770:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moepc")
6771:     ENDPROC
6772: 
6773:     PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6774:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6775:             THIS.ValidarMoepc()
6776:         ENDIF
6777:     ENDPROC
6778: 
6779:     PROCEDURE ValidarMoecusf(par_nKeyCode, par_nShiftAltCtrl)
6780:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6781:             RETURN
6782:         ENDIF
6783:         LOCAL loc_oPg, loc_cCod
6784:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6785:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moecusf", 5)
6786:             RETURN
6787:         ENDIF
6788:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moecusf.Value)
6789:         IF EMPTY(loc_cCod)
6790:             RETURN
6791:         ENDIF
6792:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moecusf")
6793:     ENDPROC
6794: 
6795:     PROCEDURE TxtMoecusfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6796:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6797:             THIS.ValidarMoecusf()
6798:         ENDIF
6799:     ENDPROC
6800: 
6801:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
6802:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6803:             RETURN
6804:         ENDIF
6805:         LOCAL loc_oPg, loc_cCod
6806:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6807:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
6808:             RETURN
6809:         ENDIF
6810:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
6811:         IF EMPTY(loc_cCod)
6812:             RETURN
6813:         ENDIF
6814:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moeda")
6815:     ENDPROC
6816: 
6817:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6818:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6819:             THIS.ValidarMoeda()
6820:         ENDIF
6821:     ENDPROC
6822: 
6823:     PROCEDURE ValidarMoepv(par_nKeyCode, par_nShiftAltCtrl)
6824:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6825:             RETURN
6826:         ENDIF
6827:         LOCAL loc_oPg, loc_cCod
6828:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6829:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
6830:             RETURN
6831:         ENDIF
6832:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepv.Value)
6833:         IF EMPTY(loc_cCod)
6834:             RETURN
6835:         ENDIF
6836:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moepv")
6837:     ENDPROC
6838: 
6839:     PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6840:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6841:             THIS.ValidarMoepv()
6842:         ENDIF
6843:     ENDPROC
6844: 
6845:     PROCEDURE ValidarMoev(par_nKeyCode, par_nShiftAltCtrl)
6846:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6847:             RETURN
6848:         ENDIF
6849:         LOCAL loc_oPg, loc_cCod
6850:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6851:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
6852:             RETURN
6853:         ENDIF
6854:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moev.Value)
6855:         IF EMPTY(loc_cCod)
6856:             RETURN
6857:         ENDIF
6858:         THIS.AbrirBuscaMoedaCompo("txt_4c_Moev")
6859:     ENDPROC
6860: 
6861:     PROCEDURE TxtMoevKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6862:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6863:             THIS.ValidarMoev()
6864:         ENDIF
6865:     ENDPROC
6866: 
6867:     PROCEDURE ValidarMftio(par_nKeyCode, par_nShiftAltCtrl)
6868:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6869:             RETURN
6870:         ENDIF
6871:         LOCAL loc_oPg, loc_cCod
6872:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6873:         IF !PEMSTATUS(loc_oPg, "txt_4c_Mftio", 5)
6874:             RETURN
6875:         ENDIF
6876:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Mftio.Value)
6877:         IF EMPTY(loc_cCod)
6878:             RETURN
6879:         ENDIF
6880:         THIS.AbrirBuscaMoedaCompo("txt_4c_Mftio")
6881:     ENDPROC
6882: 
6883:     PROCEDURE TxtMftioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6884:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6885:             THIS.ValidarMftio()
6886:         ENDIF
6887:     ENDPROC
6888: 
6889:     *-- Validacoes/lookups de feitio/markup (SigPrFti: cods, descs)
6890: 
6891:     PROCEDURE ValidarFtio(par_nKeyCode, par_nShiftAltCtrl)
6892:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6893:             RETURN
6894:         ENDIF
6895:         LOCAL loc_oPg, loc_cCod
6896:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6897:         IF !PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
6898:             RETURN
6899:         ENDIF
6900:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ftio.Value)
6901:         IF EMPTY(loc_cCod)
6902:             RETURN
6903:         ENDIF
6904:         THIS.AbrirBuscaFeitioCompo("txt_4c_Ftio")
6905:     ENDPROC
6906: 
6907:     PROCEDURE TxtFtioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6908:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6909:             THIS.ValidarFtio()
6910:         ENDIF
6911:     ENDPROC
6912: 
6913:     PROCEDURE ValidarCmkpc(par_nKeyCode, par_nShiftAltCtrl)
6914:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6915:             RETURN
6916:         ENDIF
6917:         LOCAL loc_oPg, loc_cCod
6918:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6919:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
6920:             RETURN
6921:         ENDIF
6922:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value)
6923:         IF EMPTY(loc_cCod)
6924:             RETURN
6925:         ENDIF
6926:         THIS.AbrirBuscaFeitioCompo("txt_4c_Cmkpc")
6927:     ENDPROC
6928: 
6929:     PROCEDURE TxtCmkpcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6930:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6931:             THIS.ValidarCmkpc()
6932:         ENDIF
6933:     ENDPROC
6934: 
6935:     *-- Validacao/lookup de status (SigCdPst: cods, descs)
6936: 
6937:     PROCEDURE ValidarStatus(par_nKeyCode, par_nShiftAltCtrl)
6938:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
6939:             RETURN
6940:         ENDIF
6941:         LOCAL loc_oPg, loc_cCod
6942:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6943:         IF !PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
6944:             RETURN
6945:         ENDIF
6946:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Status.Value)
6947:         IF EMPTY(loc_cCod)
6948:             RETURN
6949:         ENDIF
6950:         THIS.AbrirBuscaStatusCompo()
6951:     ENDPROC
6952: 
6953:     PROCEDURE TxtStatusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
6954:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
6955:             THIS.ValidarStatus()
6956:         ENDIF
6957:     ENDPROC
6958: 
6959:     *===========================================================================
6960:     * AbrirBuscaMoedaCompo - Lookup de moeda para campos da pgComposicao
6961:     * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
6962:     *===========================================================================
6963:     PROCEDURE AbrirBuscaMoedaCompo(par_cCampoDestino)
6964:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
6965:         TRY
6966:             loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
6967:             loc_cValAtual = ""
6968:             IF PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
6969:                 loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
6970:             ENDIF
6971: 
6972:             loc_nRet = SQLEXEC(gnConnHandle, ;
6973:                 "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes", ;
6974:                 "cursor_4c_MoedaBusca")
6975: 
6976:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
6977:             IF VARTYPE(loc_oBusca) = "O"
6978:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MoedaBusca"
6979:                 loc_oBusca.DefinirCursor("cursor_4c_MoedaBusca", "cmoes", "dmoes", "Buscar Moeda")
6980:                 loc_oBusca.Mostrar()
6981:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
6982:                     loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
6983:                 ENDIF
6984:                 loc_oBusca = .NULL.
6985:             ENDIF
6986: 
6987:             IF USED("cursor_4c_MoedaBusca")
6988:                 USE IN cursor_4c_MoedaBusca
6989:             ENDIF
6990:         CATCH TO loException
6991:             IF USED("cursor_4c_MoedaBusca")
6992:                 USE IN cursor_4c_MoedaBusca
6993:             ENDIF
6994:             MostrarErro("Erro ao buscar moeda:" + CHR(13) + loException.Message, ;
6995:                 "FormProduto.AbrirBuscaMoedaCompo")
6996:         ENDTRY
6997:     ENDPROC
6998: 
6999:     *===========================================================================
7000:     * AbrirBuscaFeitioCompo - Lookup de feitio/markup para campos da pgComposicao
7001:     * SigPrFti: cods (char 2), descs (char 20)
7002:     *===========================================================================
7003:     PROCEDURE AbrirBuscaFeitioCompo(par_cCampoDestino)
7004:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
7005:         TRY
7006:             loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7007:             loc_cValAtual = ""
7008:             IF PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
7009:                 loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
7010:             ENDIF
7011: 
7012:             loc_nRet = SQLEXEC(gnConnHandle, ;
7013:                 "SELECT cods, descs FROM SigPrFti WHERE cods LIKE '" + ;
7014:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
7015:                 "cursor_4c_FeitioBusca")
7016: 
7017:             IF loc_nRet <= 0 OR !USED("cursor_4c_FeitioBusca") OR EOF("cursor_4c_FeitioBusca")
7018:                 IF USED("cursor_4c_FeitioBusca")
7019:                     USE IN cursor_4c_FeitioBusca
7020:                 ENDIF
7021:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigPrFti ORDER BY cods", ;
7022:                     "cursor_4c_FeitioBusca")
7023:             ENDIF
7024: 
7025:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
7026:             IF VARTYPE(loc_oBusca) = "O"
7027:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FeitioBusca"
7028:                 loc_oBusca.DefinirCursor("cursor_4c_FeitioBusca", "cods", "descs", "Buscar Feitio/MKP")
7029:                 loc_oBusca.Mostrar()
7030:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
7031:                     loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
7032:                 ENDIF
7033:                 loc_oBusca = .NULL.
7034:             ENDIF
7035: 
7036:             IF USED("cursor_4c_FeitioBusca")
7037:                 USE IN cursor_4c_FeitioBusca
7038:             ENDIF
7039:         CATCH TO loException
7040:             IF USED("cursor_4c_FeitioBusca")
7041:                 USE IN cursor_4c_FeitioBusca
7042:             ENDIF
7043:             MostrarErro("Erro ao buscar feitio:" + CHR(13) + loException.Message, ;
7044:                 "FormProduto.AbrirBuscaFeitioCompo")
7045:         ENDTRY
7046:     ENDPROC
7047: 
7048:     *===========================================================================
7049:     * AbrirBuscaStatusCompo - Lookup de status para campo txt_4c_Status
7050:     * SigCdPst: cods (char 3), descs (char 20)
7051:     *===========================================================================
7052:     PROCEDURE AbrirBuscaStatusCompo()
7053:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
7054:         TRY
7055:             loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
7056:             loc_cValAtual = ""
7057:             IF PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
7058:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Status.Value)
7059:             ENDIF
7060: 
7061:             loc_nRet = SQLEXEC(gnConnHandle, ;
7062:                 "SELECT cods, descs FROM SigCdPst WHERE cods LIKE '" + ;
7063:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
7064:                 "cursor_4c_StatusBusca")
7065: 
7066:             IF loc_nRet <= 0 OR !USED("cursor_4c_StatusBusca") OR EOF("cursor_4c_StatusBusca")
7067:                 IF USED("cursor_4c_StatusBusca")
7068:                     USE IN cursor_4c_StatusBusca
7069:                 ENDIF
7070:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdPst ORDER BY cods", ;
7071:                     "cursor_4c_StatusBusca")
7072:             ENDIF
7073: 
7074:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
7075:             IF VARTYPE(loc_oBusca) = "O"
7076:                 loc_oBusca.this_cCursorDestino = "cursor_4c_StatusBusca"
7077:                 loc_oBusca.DefinirCursor("cursor_4c_StatusBusca", "cods", "descs", "Buscar Status")
7078:                 loc_oBusca.Mostrar()
7079:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
7080:                     loc_oPg.txt_4c_Status.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
7081:                 ENDIF
7082:                 loc_oBusca = .NULL.
7083:             ENDIF
7084: 
7085:             IF USED("cursor_4c_StatusBusca")
7086:                 USE IN cursor_4c_StatusBusca
7087:             ENDIF
7088:         CATCH TO loException
7089:             IF USED("cursor_4c_StatusBusca")
7090:                 USE IN cursor_4c_StatusBusca
7091:             ENDIF
7092:             MostrarErro("Erro ao buscar status:" + CHR(13) + loException.Message, ;
7093:                 "FormProduto.AbrirBuscaStatusCompo")
7094:         ENDTRY
7095:     ENDPROC
7096: 
7097:     *===========================================================================
7098:     * ConfigurarPgPgDadosFaseP - Configura Page4 "Processos" do pgf_4c_Dados
7099:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP
7100:     * GradFase: 5 colunas (top=129, left=527, width=420, height=168)
7101:     * grdMatrizes: 3 colunas (top=305, left=527, width=245, height=192)
7102:     *===========================================================================
7103:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPg)
7104:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oErro
7105:         TRY
7106:             loc_oPg = par_oPg
7107:             loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
7108: 
7109:             *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
7110:             IF !USED("cursor_4c_GradFase")
7111:                 SET NULL ON
7112:                 CREATE CURSOR cursor_4c_GradFase ( ;
7113:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
7114:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
7115:                 SET NULL OFF
7116:             ENDIF
7117:             IF !USED("cursor_4c_GrdMatrizes")
7118:                 SET NULL ON
7119:                 CREATE CURSOR cursor_4c_GrdMatrizes ( ;
7120:                     cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
7121:                 SET NULL OFF
7122:             ENDIF
7123: 
7124:             *-- shp_4c_Fig: Shape moldura da figura do produto
7125:             *-- Original shpFig: top=129, left=231, width=244, height=148
7126:             loc_oPg.AddObject("shp_4c_Fig", "Shape")
7127:             WITH loc_oPg.shp_4c_Fig
7128:                 .Top           = 129
7129:                 .Left          = 231
7130:                 .Width         = 244
7131:                 .Height        = 148
7132:                 .BackStyle     = 0
7133:                 .BorderWidth   = 2
7134:                 .SpecialEffect = 0
7135:                 .Visible       = .T.
7136:             ENDWITH
7137: 
7138:             *-- img_4c_ImgFig: Imagem da figura do produto
7139:             *-- Original ImgFigJpg: top=130, left=232, width=241, height=146
7140:             loc_oPg.AddObject("img_4c_ImgFig", "Image")
7141:             WITH loc_oPg.img_4c_ImgFig
7142:                 .Top     = 130
7143:                 .Left    = 232

*-- Linhas 7164 a 7377:
7164:                 .Themes          = .F.
7165:                 .Visible         = .T.
7166:             ENDWITH
7167:             BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaFasePClick")
7168: 
7169:             *-- cmd_4c_Figura: Capturar imagem do produto (arquivo)
7170:             *-- Original cmdgFigura: top=169, left=482, width=40, height=40
7171:             loc_oPg.AddObject("cmd_4c_Figura", "CommandButton")
7172:             WITH loc_oPg.cmd_4c_Figura
7173:                 .Top             = 169
7174:                 .Left            = 482
7175:                 .Width           = 40
7176:                 .Height          = 40
7177:                 .Caption         = ""
7178:                 .Picture         = gc_4c_CaminhoIcones + "geral_picture_26.jpg"
7179:                 .PicturePosition = 14
7180:                 .SpecialEffect   = 0
7181:                 .MousePointer    = 15
7182:                 .ToolTipText     = "Capturar Imagem do Produto"
7183:                 .Themes          = .F.
7184:                 .Visible         = .T.
7185:             ENDWITH
7186:             BINDEVENT(loc_oPg.cmd_4c_Figura, "Click", THIS, "CmdFiguraFasePClick")
7187: 
7188:             *-- cmd_4c_FigCam: Capturar imagem via WebCam
7189:             *-- Original cmdgFigCam: top=209, left=482, width=40, height=40
7190:             loc_oPg.AddObject("cmd_4c_FigCam", "CommandButton")
7191:             WITH loc_oPg.cmd_4c_FigCam
7192:                 .Top             = 209
7193:                 .Left            = 482
7194:                 .Width           = 40
7195:                 .Height          = 40
7196:                 .Caption         = ""
7197:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
7198:                 .PicturePosition = 14
7199:                 .SpecialEffect   = 0
7200:                 .MousePointer    = 15
7201:                 .ToolTipText     = "Capturar Imagem do Produto - WebCam"
7202:                 .Themes          = .F.
7203:                 .Visible         = .T.
7204:             ENDWITH
7205:             BINDEVENT(loc_oPg.cmd_4c_FigCam, "Click", THIS, "CmdFigCamFasePClick")
7206: 
7207:             *-- grd_4c_GradFase: Grade de Fases de Producao (5 colunas)
7208:             *-- Original GradFase: top=129, left=527, width=420, height=168, columnCount=5
7209:             loc_oPg.AddObject("grd_4c_GradFase", "Grid")
7210:             WITH loc_oPg.grd_4c_GradFase
7211:                 .Top               = 129
7212:                 .Left              = 527
7213:                 .Width             = 420
7214:                 .Height            = 168
7215:                 .FontName          = "Tahoma"
7216:                 .FontSize          = 8
7217:                 .RecordMark        = .F.
7218:                 .DeleteMark        = .F.
7219:                 .HeaderHeight      = 20
7220:                 .RowHeight         = 18
7221:                 .ScrollBars        = 2
7222:                 .GridLines         = 3
7223:                 .GridLineColor     = RGB(238, 238, 238)
7224:                 .HighlightBackColor = RGB(255, 255, 255)
7225:                 .HighlightForeColor = RGB(15, 41, 104)
7226:                 .HighlightStyle    = 2
7227:                 .AllowHeaderSizing = .F.
7228:                 .AllowRowSizing    = .F.
7229:                 .Visible           = .T.
7230:             ENDWITH
7231:             loc_oPg.grd_4c_GradFase.ColumnCount  = 5
7232:             loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
7233:             loc_oGrid = loc_oPg.grd_4c_GradFase
7234: 
7235:             *-- Column1: Ordem (ordems N2,0) - width=45
7236:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GradFase.ordems"
7237:             loc_oGrid.Column1.Width           = 45
7238:             loc_oGrid.Column1.ReadOnly        = .F.
7239:             loc_oGrid.Column1.Movable         = .F.
7240:             loc_oGrid.Column1.Resizable       = .F.
7241:             loc_oGrid.Column1.Header1.Caption = "Ordem"
7242:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "GrdFaseCol1OrdValid")
7243: 
7244:             *-- Column2: Fase/Grupo (grupos C10) - lookup SigCdGcr, width=80
7245:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GradFase.grupos"
7246:             loc_oGrid.Column2.Width           = 80
7247:             loc_oGrid.Column2.ReadOnly        = .F.
7248:             loc_oGrid.Column2.Movable         = .F.
7249:             loc_oGrid.Column2.Resizable       = .F.
7250:             loc_oGrid.Column2.Header1.Caption = "Fase"
7251:             BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "GrdFaseCol2FaseValid")
7252: 
7253:             *-- Column3: Utilizacao (minutos N9,1) - width=70
7254:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GradFase.minutos"
7255:             loc_oGrid.Column3.Width           = 70
7256:             loc_oGrid.Column3.ReadOnly        = .F.
7257:             loc_oGrid.Column3.Movable         = .F.
7258:             loc_oGrid.Column3.Resizable       = .F.
7259:             loc_oGrid.Column3.InputMask       = "99,999.9"
7260:             loc_oGrid.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
7261: 
7262:             *-- Column4: Uni. Produtiva (uniprdts C10) - lookup SigCdUpd, width=84
7263:             loc_oGrid.Column4.ControlSource   = "cursor_4c_GradFase.uniprdts"
7264:             loc_oGrid.Column4.Width           = 84
7265:             loc_oGrid.Column4.ReadOnly        = .F.
7266:             loc_oGrid.Column4.Movable         = .F.
7267:             loc_oGrid.Column4.Resizable       = .F.
7268:             loc_oGrid.Column4.Header1.Caption = "Uni. Produtiva"
7269:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdFaseCol4UniPrdtValid")
7270: 
7271:             *-- Column5: Material (matprdts C15) - lookup SigOpOpt, width=115
7272:             loc_oGrid.Column5.ControlSource   = "cursor_4c_GradFase.matprdts"
7273:             loc_oGrid.Column5.Width           = 115
7274:             loc_oGrid.Column5.ReadOnly        = .F.
7275:             loc_oGrid.Column5.Movable         = .F.
7276:             loc_oGrid.Column5.Resizable       = .F.
7277:             loc_oGrid.Column5.Header1.Caption = "Material"
7278:             BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdFaseCol5MatPrdtValid")
7279: 
7280:             BINDEVENT(loc_oGrid, "BeforeRowColChange", THIS, "GrdFaseBeforeRowColChange")
7281:             BINDEVENT(loc_oGrid, "AfterRowColChange",  THIS, "GrdFaseAfterRowColChange")
7282: 
7283:             *-- cmd_4c_InserirFase: Inserir fase na GradFase
7284:             *-- Original inserir: top=129, left=950, width=40, height=40
7285:             loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
7286:             WITH loc_oPg.cmd_4c_InserirFase
7287:                 .Top             = 129
7288:                 .Left            = 950
7289:                 .Width           = 40
7290:                 .Height          = 40
7291:                 .Caption         = ""
7292:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
7293:                 .PicturePosition = 14
7294:                 .SpecialEffect   = 0
7295:                 .MousePointer    = 15
7296:                 .Themes          = .F.
7297:                 .Visible         = .T.
7298:             ENDWITH
7299:             BINDEVENT(loc_oPg.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")
7300: 
7301:             *-- cmd_4c_ExcluirFase: Excluir fase da GradFase
7302:             *-- Original excluir: top=169, left=950, width=40, height=40
7303:             loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
7304:             WITH loc_oPg.cmd_4c_ExcluirFase
7305:                 .Top             = 169
7306:                 .Left            = 950
7307:                 .Width           = 40
7308:                 .Height          = 40
7309:                 .Caption         = ""
7310:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
7311:                 .PicturePosition = 14
7312:                 .SpecialEffect   = 0
7313:                 .MousePointer    = 15
7314:                 .ToolTipText     = "Excluir"
7315:                 .Themes          = .F.
7316:                 .Visible         = .T.
7317:             ENDWITH
7318:             BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")
7319: 
7320:             *-- cmd_4c_Alternativa: Alternativa de insercao na GradFase
7321:             *-- Original Alternativa: top=209, left=950, width=40, height=40
7322:             loc_oPg.AddObject("cmd_4c_Alternativa", "CommandButton")
7323:             WITH loc_oPg.cmd_4c_Alternativa
7324:                 .Top             = 209
7325:                 .Left            = 950
7326:                 .Width           = 40
7327:                 .Height          = 40
7328:                 .Caption         = ""
7329:                 .Picture         = gc_4c_CaminhoIcones + "geral_pn_cfg_26.jpg"
7330:                 .PicturePosition = 14
7331:                 .SpecialEffect   = 0
7332:                 .MousePointer    = 15
7333:                 .ToolTipText     = "Alternativa"
7334:                 .Themes          = .F.
7335:                 .Visible         = .T.
7336:             ENDWITH
7337:             BINDEVENT(loc_oPg.cmd_4c_Alternativa, "Click", THIS, "BtnAlternativaFaseClick")
7338: 
7339:             *--------------------------------------------------------------
7340:             *-- Area esquerda: campos do produto (pesos, tamanhos, etc.)
7341:             *--------------------------------------------------------------
7342: 
7343:             *-- lbl_4c_Say13: "Qtd. Min. Producao :"
7344:             *-- Original Say13: top=133, left=32, width=102
7345:             loc_oPg.AddObject("lbl_4c_Say13", "Label")
7346:             WITH loc_oPg.lbl_4c_Say13
7347:                 .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
7348:                 .FontName  = "Tahoma"
7349:                 .FontSize  = 8
7350:                 .BackStyle = 0
7351:                 .Height    = 15
7352:                 .Left      = 32
7353:                 .Top       = 133
7354:                 .Width     = 102
7355:                 .ForeColor = RGB(90, 90, 90)
7356:                 .Visible   = .T.
7357:             ENDWITH
7358: 
7359:             *-- txt_4c_QminFabs: Quantidade minima de fabricacao (getQmin)
7360:             *-- Original getQmin: top=129, left=137, width=80, height=23, ControlSource=crSigCdPro.qtminFabs
7361:             loc_oPg.AddObject("txt_4c_QminFabs", "TextBox")
7362:             WITH loc_oPg.txt_4c_QminFabs
7363:                 .Top           = 129
7364:                 .Left          = 137
7365:                 .Width         = 80
7366:                 .Height        = 23
7367:                 .FontName      = "Tahoma"
7368:                 .FontSize      = 8
7369:                 .InputMask     = "999,999.99"
7370:                 .MaxLength     = 10
7371:                 .SpecialEffect = 1
7372:                 .Value         = 0
7373:                 .Visible       = .T.
7374:             ENDWITH
7375: 
7376:             *-- lbl_4c_Say5: "Garra :"
7377:             *-- Original Say5: top=158, left=98, width=36

*-- Linhas 7435 a 7478:
7435:                 .Value         = ""
7436:                 .Visible       = .T.
7437:             ENDWITH
7438:             BINDEVENT(loc_oPg.txt_4c_Conquilhas, "KeyPress", THIS, "ValidarConquilhaFaseP")
7439: 
7440:             *-- lbl_4c_Say9: "Peso Brilhante :"
7441:             *-- Original Say9: top=208, left=57, width=77
7442:             loc_oPg.AddObject("lbl_4c_Say9", "Label")
7443:             WITH loc_oPg.lbl_4c_Say9
7444:                 .Caption   = "Peso Brilhante :"
7445:                 .FontName  = "Tahoma"
7446:                 .FontSize  = 8
7447:                 .BackStyle = 0
7448:                 .Height    = 15
7449:                 .Left      = 57
7450:                 .Top       = 208
7451:                 .Width     = 77
7452:                 .ForeColor = RGB(90, 90, 90)
7453:                 .Visible   = .T.
7454:             ENDWITH
7455: 
7456:             *-- txt_4c_PesoBris: Peso Brilhante (getPesoBris)
7457:             *-- Original getPesoBris: top=204, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoBris
7458:             loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
7459:             WITH loc_oPg.txt_4c_PesoBris
7460:                 .Top           = 204
7461:                 .Left          = 137
7462:                 .Width         = 80
7463:                 .Height        = 23
7464:                 .FontName      = "Tahoma"
7465:                 .FontSize      = 8
7466:                 .InputMask     = "99,999.999"
7467:                 .MaxLength     = 10
7468:                 .SpecialEffect = 1
7469:                 .Value         = 0
7470:                 .Visible       = .T.
7471:             ENDWITH
7472: 
7473:             *-- lbl_4c_Say10: "Peso Metal :"
7474:             *-- Original Say10: top=233, left=73, width=61
7475:             loc_oPg.AddObject("lbl_4c_Say10", "Label")
7476:             WITH loc_oPg.lbl_4c_Say10
7477:                 .Caption   = "Peso Metal :"
7478:                 .FontName  = "Tahoma"

*-- Linhas 7565 a 7608:
7565:                 .Value         = ""
7566:                 .Visible       = .T.
7567:             ENDWITH
7568:             BINDEVENT(loc_oPg.txt_4c_CodCorsFP, "KeyPress", THIS, "ValidarCorFaseP")
7569: 
7570:             *-- chk_4c_CravCera: Cravacao em Cera (opc_CravCera)
7571:             *-- Original opc_CravCera: top=283, left=180, ControlSource=crSigCdPro.CravCers
7572:             loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
7573:             WITH loc_oPg.chk_4c_CravCera
7574:                 .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
7575:                 .Top           = 283
7576:                 .Left          = 180
7577:                 .FontName      = "Tahoma"
7578:                 .FontSize      = 8
7579:                 .BackStyle     = 0
7580:                 .AutoSize      = .T.
7581:                 .Alignment     = 0
7582:                 .Value         = 0
7583:                 .SpecialEffect = 1
7584:                 .ForeColor     = RGB(90, 90, 90)
7585:                 .Visible       = .T.
7586:             ENDWITH
7587: 
7588:             *-- lbl_4c_Say2: "Tamanho Padrao :"
7589:             *-- Original Say2: top=308, left=44
7590:             loc_oPg.AddObject("lbl_4c_Say2", "Label")
7591:             WITH loc_oPg.lbl_4c_Say2
7592:                 .Caption   = "Tamanho Padr" + CHR(227) + "o :"
7593:                 .FontName  = "Tahoma"
7594:                 .FontSize  = 8
7595:                 .BackStyle = 0
7596:                 .Left      = 44
7597:                 .Top       = 308
7598:                 .ForeColor = RGB(90, 90, 90)
7599:                 .Visible   = .T.
7600:             ENDWITH
7601: 
7602:             *-- txt_4c_CodTamsFP: Tamanho Padrao (getTam) - espelha Page1 CodTams
7603:             *-- Original getTam: top=304, left=137, width=38, ControlSource=crSigCdPro.CodTams
7604:             loc_oPg.AddObject("txt_4c_CodTamsFP", "TextBox")
7605:             WITH loc_oPg.txt_4c_CodTamsFP
7606:                 .Top           = 304
7607:                 .Left          = 137
7608:                 .Width         = 38

*-- Linhas 7614 a 7657:
7614:                 .Value         = ""
7615:                 .Visible       = .T.
7616:             ENDWITH
7617:             BINDEVENT(loc_oPg.txt_4c_CodTamsFP, "KeyPress", THIS, "ValidarTamFaseP")
7618: 
7619:             *-- chk_4c_Varias: Peso Variavel (fwoption1)
7620:             *-- Original fwoption1: top=308, left=180, ControlSource=crSigCdPro.Varias
7621:             loc_oPg.AddObject("chk_4c_Varias", "CheckBox")
7622:             WITH loc_oPg.chk_4c_Varias
7623:                 .Caption       = "Peso Vari" + CHR(225) + "vel"
7624:                 .Top           = 308
7625:                 .Left          = 180
7626:                 .FontName      = "Tahoma"
7627:                 .FontSize      = 8
7628:                 .BackStyle     = 0
7629:                 .AutoSize      = .T.
7630:                 .Alignment     = 0
7631:                 .Value         = 0
7632:                 .SpecialEffect = 1
7633:                 .ForeColor     = RGB(90, 90, 90)
7634:                 .Visible       = .T.
7635:             ENDWITH
7636: 
7637:             *-- lbl_4c_Acabamento: "Acabamento :"
7638:             *-- Original lblAcabamento: top=333, left=15, width=119, Alignment=1
7639:             loc_oPg.AddObject("lbl_4c_Acabamento", "Label")
7640:             WITH loc_oPg.lbl_4c_Acabamento
7641:                 .Caption   = "Acabamento :"
7642:                 .FontName  = "Tahoma"
7643:                 .FontSize  = 8
7644:                 .BackStyle = 0
7645:                 .Alignment = 1
7646:                 .Height    = 15
7647:                 .Left      = 15
7648:                 .Top       = 333
7649:                 .Width     = 119
7650:                 .ForeColor = RGB(90, 90, 90)
7651:                 .Visible   = .T.
7652:             ENDWITH
7653: 
7654:             *-- txt_4c_CodAcbsFP: Codigo de Acabamento (get_codacb)
7655:             *-- Original get_codacb: top=329, left=137, width=38, ControlSource=crSigCdPro.codAcbs
7656:             loc_oPg.AddObject("txt_4c_CodAcbsFP", "TextBox")
7657:             WITH loc_oPg.txt_4c_CodAcbsFP

*-- Linhas 7666 a 7709:
7666:                 .Value         = ""
7667:                 .Visible       = .T.
7668:             ENDWITH
7669:             BINDEVENT(loc_oPg.txt_4c_CodAcbsFP, "KeyPress", THIS, "ValidarAcabamentoFaseP")
7670: 
7671:             *-- txt_4c_DacbFP: Descricao Acabamento (get_Dacb) - somente leitura
7672:             *-- Original get_Dacb: top=329, left=177, width=207, height=23
7673:             loc_oPg.AddObject("txt_4c_DacbFP", "TextBox")
7674:             WITH loc_oPg.txt_4c_DacbFP
7675:                 .Top           = 329
7676:                 .Left          = 177
7677:                 .Width         = 207
7678:                 .Height        = 23
7679:                 .FontName      = "Tahoma"
7680:                 .FontSize      = 8
7681:                 .SpecialEffect = 1
7682:                 .ReadOnly      = .T.
7683:                 .Value         = ""
7684:                 .Visible       = .T.
7685:             ENDWITH
7686: 
7687:             *-- lbl_4c_Label9: "Entrega :"
7688:             *-- Original Label9: top=359, left=87, width=47
7689:             loc_oPg.AddObject("lbl_4c_Label9", "Label")
7690:             WITH loc_oPg.lbl_4c_Label9
7691:                 .Caption   = "Entrega :"
7692:                 .FontName  = "Tahoma"
7693:                 .FontSize  = 8
7694:                 .BackStyle = 0
7695:                 .Height    = 15
7696:                 .Left      = 87
7697:                 .Top       = 359
7698:                 .Width     = 47
7699:                 .ForeColor = RGB(90, 90, 90)
7700:                 .Visible   = .T.
7701:             ENDWITH
7702: 
7703:             *-- txt_4c_TEnts: Tempo de Entrega em Dias (getTEnts)
7704:             *-- Original getTEnts: top=355, left=137, width=31, height=23, ControlSource=crSigCdPro.tents
7705:             loc_oPg.AddObject("txt_4c_TEnts", "TextBox")
7706:             WITH loc_oPg.txt_4c_TEnts
7707:                 .Top           = 355
7708:                 .Left          = 137
7709:                 .Width         = 31

*-- Linhas 7944 a 8019:
7944: 
7945:             *-- opt_4c_Prodvars: Variacao p/ e-commerce Sim/Nao (Fwoption2)
7946:             *-- Original Fwoption2: top=482, left=132, width=93, height=15, ControlSource=crSigCdPro.prodvars
7947:             loc_oPg.AddObject("opt_4c_Prodvars", "OptionGroup")
7948:             WITH loc_oPg.opt_4c_Prodvars
7949:                 .ButtonCount = 2
7950:                 .Value       = 1
7951:                 .Top         = 482
7952:                 .Left        = 132
7953:                 .Width       = 93
7954:                 .Height      = 15
7955:                 .BackStyle   = 0
7956:                 .BorderStyle = 0
7957:                 .Visible     = .T.
7958:                 .Option1.Caption   = "Sim"
7959:                 .Option1.FontName  = "Tahoma"
7960:                 .Option1.FontSize  = 8
7961:                 .Option1.BackStyle = 0
7962:                 .Option1.ForeColor = RGB(90, 90, 90)
7963:                 .Option1.Alignment = 2
7964:                 .Option1.Top       = 0
7965:                 .Option1.Left      = 5
7966:                 .Option1.Height    = 15
7967:                 .Option1.AutoSize  = .T.
7968:                 .Option2.Caption   = "N" + CHR(227) + "o"
7969:                 .Option2.FontName  = "Tahoma"
7970:                 .Option2.FontSize  = 8
7971:                 .Option2.BackStyle = 0
7972:                 .Option2.ForeColor = RGB(90, 90, 90)
7973:                 .Option2.Alignment = 2
7974:                 .Option2.Top       = 0
7975:                 .Option2.Left      = 47
7976:                 .Option2.Height    = 15
7977:                 .Option2.AutoSize  = .T.
7978:             ENDWITH
7979:             BINDEVENT(loc_oPg.opt_4c_Prodvars, "InteractiveChange", THIS, "OptProdvarsInteractiveChange")
7980: 
7981:             *--------------------------------------------------------------
7982:             *-- Area direita: descricao da fase, observacoes
7983:             *--------------------------------------------------------------
7984: 
7985:             *-- lbl_4c_Say1Desc: "Descricao :" (rotulo de Get_Desc)
7986:             *-- Original Say1: top=508, left=527, width=67
7987:             loc_oPg.AddObject("lbl_4c_Say1Desc", "Label")
7988:             WITH loc_oPg.lbl_4c_Say1Desc
7989:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
7990:                 .FontName  = "Tahoma"
7991:                 .FontSize  = 8
7992:                 .BackStyle = 0
7993:                 .Height    = 17
7994:                 .Left      = 527
7995:                 .Top       = 508
7996:                 .Width     = 67
7997:                 .ForeColor = RGB(90, 90, 90)
7998:                 .Visible   = .T.
7999:             ENDWITH
8000: 
8001:             *-- txt_4c_Desc: Descricao da fase selecionada (Get_Desc) - somente leitura
8002:             *-- Original Get_Desc: top=505, left=595, width=395, height=23, ControlSource=crSigCdGcr.descrs
8003:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
8004:             WITH loc_oPg.txt_4c_Desc
8005:                 .Top           = 505
8006:                 .Left          = 595
8007:                 .Width         = 395
8008:                 .Height        = 23
8009:                 .FontName      = "Tahoma"
8010:                 .FontSize      = 8
8011:                 .SpecialEffect = 1
8012:                 .ReadOnly      = .T.
8013:                 .Value         = ""
8014:                 .Visible       = .T.
8015:             ENDWITH
8016: 
8017:             *-- edt_4c_Obs: Observacoes da fase (Get_Obs - fwmemo)
8018:             *-- Original Get_Obs: top=531, left=527, width=463, height=92, ControlSource=crSigCdPrf.Obs
8019:             loc_oPg.AddObject("edt_4c_Obs", "EditBox")

*-- Linhas 8057 a 8307:
8057:                 .Height  = 110
8058:                 .Stretch = 1
8059:                 .Visible = .T.
8060:             ENDWITH
8061: 
8062:             *-- cmd_4c_InserirMtz: Inserir linha na grdMatrizes
8063:             *-- Original btnInsereMtx: top=302, left=778, width=39, height=40
8064:             loc_oPg.AddObject("cmd_4c_InserirMtz", "CommandButton")
8065:             WITH loc_oPg.cmd_4c_InserirMtz
8066:                 .Top             = 302
8067:                 .Left            = 778
8068:                 .Width           = 39
8069:                 .Height          = 40
8070:                 .Caption         = ""
8071:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
8072:                 .PicturePosition = 14
8073:                 .SpecialEffect   = 0
8074:                 .MousePointer    = 15
8075:                 .Themes          = .F.
8076:                 .Visible         = .T.
8077:             ENDWITH
8078:             BINDEVENT(loc_oPg.cmd_4c_InserirMtz, "Click", THIS, "BtnInserirMtzClick")
8079: 
8080:             *-- cmd_4c_ExcluirMtz: Excluir linha da grdMatrizes
8081:             *-- Original btnExcluiMtz: top=342, left=778, width=39, height=40
8082:             loc_oPg.AddObject("cmd_4c_ExcluirMtz", "CommandButton")
8083:             WITH loc_oPg.cmd_4c_ExcluirMtz
8084:                 .Top             = 342
8085:                 .Left            = 778
8086:                 .Width           = 39
8087:                 .Height          = 40
8088:                 .Caption         = ""
8089:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
8090:                 .PicturePosition = 14
8091:                 .SpecialEffect   = 0
8092:                 .MousePointer    = 15
8093:                 .ToolTipText     = "Excluir"
8094:                 .Themes          = .F.
8095:                 .Visible         = .T.
8096:             ENDWITH
8097:             BINDEVENT(loc_oPg.cmd_4c_ExcluirMtz, "Click", THIS, "BtnExcluirMtzClick")
8098: 
8099:             *-- grd_4c_GrdMatrizes: Grade de Matrizes (3 colunas)
8100:             *-- Original grdMatrizes: top=305, left=527, width=245, height=192, columnCount=3
8101:             loc_oPg.AddObject("grd_4c_GrdMatrizes", "Grid")
8102:             WITH loc_oPg.grd_4c_GrdMatrizes
8103:                 .Top               = 305
8104:                 .Left              = 527
8105:                 .Width             = 245
8106:                 .Height            = 192
8107:                 .FontName          = "Tahoma"
8108:                 .FontSize          = 8
8109:                 .RecordMark        = .F.
8110:                 .DeleteMark        = .F.
8111:                 .HeaderHeight      = 20
8112:                 .RowHeight         = 18
8113:                 .ScrollBars        = 2
8114:                 .GridLines         = 3
8115:                 .GridLineColor     = RGB(238, 238, 238)
8116:                 .HighlightBackColor = RGB(255, 255, 255)
8117:                 .HighlightForeColor = RGB(15, 41, 104)
8118:                 .HighlightStyle    = 2
8119:                 .AllowHeaderSizing = .F.
8120:                 .AllowRowSizing    = .F.
8121:                 .Visible           = .T.
8122:             ENDWITH
8123:             loc_oPg.grd_4c_GrdMatrizes.ColumnCount  = 3
8124:             loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
8125:             loc_oGrid2 = loc_oPg.grd_4c_GrdMatrizes
8126: 
8127:             *-- Column1: Matriz (cmats C14) - lookup, width=108
8128:             loc_oGrid2.Column1.ControlSource   = "cursor_4c_GrdMatrizes.cmats"
8129:             loc_oGrid2.Column1.Width           = 108
8130:             loc_oGrid2.Column1.ReadOnly        = .F.
8131:             loc_oGrid2.Column1.Movable         = .F.
8132:             loc_oGrid2.Column1.Resizable       = .F.
8133:             loc_oGrid2.Column1.Header1.Caption = "Matriz"
8134:             BINDEVENT(loc_oGrid2.Column1.Text1, "Valid", THIS, "GrdMatrizesCol1Valid")
8135: 
8136:             *-- Column2: Qtde (qtds N3,0) - width=34
8137:             loc_oGrid2.Column2.ControlSource   = "cursor_4c_GrdMatrizes.qtds"
8138:             loc_oGrid2.Column2.Width           = 34
8139:             loc_oGrid2.Column2.ReadOnly        = .F.
8140:             loc_oGrid2.Column2.Movable         = .F.
8141:             loc_oGrid2.Column2.Resizable       = .F.
8142:             loc_oGrid2.Column2.InputMask       = "9999"
8143:             loc_oGrid2.Column2.Header1.Caption = "Qtde"
8144: 
8145:             *-- Column3: Local (dpros C65) - somente leitura (descricao do produto matriz), width=80
8146:             loc_oGrid2.Column3.ControlSource   = "cursor_4c_GrdMatrizes.dpros"
8147:             loc_oGrid2.Column3.Width           = 80
8148:             loc_oGrid2.Column3.ReadOnly        = .T.
8149:             loc_oGrid2.Column3.Movable         = .F.
8150:             loc_oGrid2.Column3.Resizable       = .F.
8151:             loc_oGrid2.Column3.Header1.Caption = "Local"
8152: 
8153:             BINDEVENT(loc_oGrid2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8154: 
8155:         CATCH TO loc_oErro
8156:             MostrarErro("Erro ao configurar p" + CHR(225) + "gina Processos de Produ" + ;
8157:                 CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
8158:                 "FormProduto.ConfigurarPgPgDadosFaseP")
8159:         ENDTRY
8160:     ENDPROC
8161: 
8162:     *===========================================================================
8163:     * CarregarFaseP - Popula grids de FaseP do banco (SigCdPrf + SigPrMtz)
8164:     * Chamado de BOParaForm quando produto e carregado para edicao/visualizacao
8165:     *===========================================================================
8166:     PROTECTED PROCEDURE CarregarFaseP()
8167:         LOCAL loc_cCpros, loc_nRet, loc_oPg, loException
8168:         TRY
8169:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
8170:             IF EMPTY(loc_cCpros) OR TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
8171:                 RETURN
8172:             ENDIF
8173:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8174: 
8175:             *-- Carregar GradFase de SigCdPrf
8176:             IF USED("cursor_4c_GradFase")
8177:                 USE IN cursor_4c_GradFase
8178:             ENDIF
8179:             loc_nRet = SQLEXEC(gnConnHandle, ;
8180:                 "SELECT cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs" + ;
8181:                 " FROM SigCdPrf WHERE produtos = " + EscaparSQL(loc_cCpros) + ;
8182:                 " ORDER BY ordems", "cursor_4c_GradFase")
8183:             IF loc_nRet <= 0
8184:                 CREATE CURSOR cursor_4c_GradFase ( ;
8185:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
8186:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
8187:             ENDIF
8188:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8189:                 loc_oPg.grd_4c_GradFase.ColumnCount = 5
8190:                 loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8191:                 loc_oPg.grd_4c_GradFase.Column1.ControlSource = "cursor_4c_GradFase.ordems"
8192:                 loc_oPg.grd_4c_GradFase.Column2.ControlSource = "cursor_4c_GradFase.grupos"
8193:                 loc_oPg.grd_4c_GradFase.Column3.ControlSource = "cursor_4c_GradFase.minutos"
8194:                 loc_oPg.grd_4c_GradFase.Column4.ControlSource = "cursor_4c_GradFase.uniprdts"
8195:                 loc_oPg.grd_4c_GradFase.Column5.ControlSource = "cursor_4c_GradFase.matprdts"
8196:                 loc_oPg.grd_4c_GradFase.Column1.Header1.Caption = "Ordem"
8197:                 loc_oPg.grd_4c_GradFase.Column2.Header1.Caption = "Fase"
8198:                 loc_oPg.grd_4c_GradFase.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8199:                 loc_oPg.grd_4c_GradFase.Column4.Header1.Caption = "Uni. Produtiva"
8200:                 loc_oPg.grd_4c_GradFase.Column5.Header1.Caption = "Material"
8201:                 loc_oPg.grd_4c_GradFase.Refresh()
8202:             ENDIF
8203: 
8204:             *-- Carregar grdMatrizes de SigPrMtz + SigCdPro (descricao do produto matriz)
8205:             IF USED("cursor_4c_GrdMatrizes")
8206:                 USE IN cursor_4c_GrdMatrizes
8207:             ENDIF
8208:             loc_nRet = SQLEXEC(gnConnHandle, ;
8209:                 "SELECT m.cidchaves, m.cmats, m.qtds, ISNULL(p.dpros,'') AS dpros" + ;
8210:                 " FROM SigPrMtz m LEFT JOIN SigCdPro p ON p.cpros = m.cmats" + ;
8211:                 " WHERE m.cpros = " + EscaparSQL(loc_cCpros) + ;
8212:                 " ORDER BY m.cmats", "cursor_4c_GrdMatrizes")
8213:             IF loc_nRet <= 0
8214:                 CREATE CURSOR cursor_4c_GrdMatrizes ( ;
8215:                     cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
8216:             ENDIF
8217:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
8218:                 loc_oPg.grd_4c_GrdMatrizes.ColumnCount = 3
8219:                 loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
8220:                 loc_oPg.grd_4c_GrdMatrizes.Column1.ControlSource = "cursor_4c_GrdMatrizes.cmats"
8221:                 loc_oPg.grd_4c_GrdMatrizes.Column2.ControlSource = "cursor_4c_GrdMatrizes.qtds"
8222:                 loc_oPg.grd_4c_GrdMatrizes.Column3.ControlSource = "cursor_4c_GrdMatrizes.dpros"
8223:                 loc_oPg.grd_4c_GrdMatrizes.Column1.Header1.Caption = "Matriz"
8224:                 loc_oPg.grd_4c_GrdMatrizes.Column2.Header1.Caption = "Qtde"
8225:                 loc_oPg.grd_4c_GrdMatrizes.Column3.Header1.Caption = "Local"
8226:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
8227:             ENDIF
8228: 
8229:         CATCH TO loException
8230:             MostrarErro("Erro ao carregar FaseP:" + CHR(13) + loException.Message + ;
8231:                 CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
8232:                 "FormProduto.CarregarFaseP")
8233:         ENDTRY
8234:     ENDPROC
8235: 
8236:     *===========================================================================
8237:     * GrdFaseBeforeRowColChange - Persiste obs do EditBox no cursor antes de mudar linha
8238:     * PUBLIC: BINDEVENT requer metodo publico
8239:     *===========================================================================
8240:     PROCEDURE GrdFaseBeforeRowColChange(par_nColIndex)
8241:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8242:             LOCAL loc_oPgBC
8243:             loc_oPgBC = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8244:             IF PEMSTATUS(loc_oPgBC, "edt_4c_Obs", 5)
8245:                 SELECT cursor_4c_GradFase
8246:                 REPLACE cursor_4c_GradFase.obs WITH loc_oPgBC.edt_4c_Obs.Value
8247:             ENDIF
8248:         ENDIF
8249:     ENDPROC
8250: 
8251:     *===========================================================================
8252:     * GrdFaseAfterRowColChange - Exibe imagem da fase e atualiza descricao
8253:     * PUBLIC: BINDEVENT requer metodo publico
8254:     *===========================================================================
8255:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
8256:         LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
8257:         TRY
8258:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8259:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5) OR !USED("cursor_4c_GradFase")
8260:                 RETURN
8261:             ENDIF
8262: 
8263:             CLEAR RESOURCES
8264:             loc_oPg.img_4c_ImgFig.Picture = ""
8265:             loc_oPg.img_4c_ImgFig.Visible = .F.
8266:             loc_oPg.txt_4c_Desc.Value     = ""
8267:             loc_oPg.edt_4c_Obs.Value      = ""
8268: 
8269:             IF !EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
8270:                 LOCAL loc_cGrupos, loc_cCidchaves
8271:                 SELECT cursor_4c_GradFase
8272:                 loc_cGrupos    = ALLTRIM(cursor_4c_GradFase.grupos)
8273:                 loc_cCidchaves = ALLTRIM(cursor_4c_GradFase.cidchaves)
8274: 
8275:                 *-- Carregar descricao do grupo/fase (SigCdGcr)
8276:                 IF !EMPTY(loc_cGrupos)
8277:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8278:                         "SELECT descrs FROM SigCdGcr WHERE codigos = '" + ;
8279:                         EscaparSQL(loc_cGrupos) + "", "cursor_4c_FaseGcrDesc")
8280:                     IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrDesc") AND !EOF("cursor_4c_FaseGcrDesc")
8281:                         SELECT cursor_4c_FaseGcrDesc
8282:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_FaseGcrDesc.descrs)
8283:                     ENDIF
8284:                     IF USED("cursor_4c_FaseGcrDesc")
8285:                         USE IN cursor_4c_FaseGcrDesc
8286:                     ENDIF
8287:                 ENDIF
8288: 
8289:                 *-- Obs vem do cursor (ja carregado em CarregarFaseP / gravado por BeforeRowColChange)
8290:                 SELECT cursor_4c_GradFase
8291:                 IF !ISNULL(cursor_4c_GradFase.obs)
8292:                     loc_oPg.edt_4c_Obs.Value = cursor_4c_GradFase.obs
8293:                 ENDIF
8294: 
8295:                 *-- Figura carregada do banco (campo figprocs - binario nao armazenado no cursor)
8296:                 IF !EMPTY(loc_cCidchaves)
8297:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8298:                         "SELECT figprocs FROM SigCdPrf WHERE cidchaves = '" + ;
8299:                         EscaparSQL(loc_cCidchaves) + "", "cursor_4c_FasePrfFig")
8300:                     IF loc_nRet > 0 AND USED("cursor_4c_FasePrfFig") AND !EOF("cursor_4c_FasePrfFig")
8301:                         SELECT cursor_4c_FasePrfFig
8302:                         IF !ISNULL(cursor_4c_FasePrfFig.figprocs) AND ;
8303:                                 !EMPTY(cursor_4c_FasePrfFig.figprocs)
8304:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8305:                             IF STRTOFILE(cursor_4c_FasePrfFig.figprocs, loc_lcArquivo) > 0
8306:                                 loc_oPg.img_4c_ImgFig.Visible = .T.
8307:                                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo

*-- Linhas 8322 a 10540:
8322: 
8323:     *===========================================================================
8324:     * GrdFaseCol1OrdValid - Valida coluna Ordem da GradFase
8325:     * PUBLIC: BINDEVENT requer metodo publico
8326:     *===========================================================================
8327:     PROCEDURE GrdFaseCol1OrdValid()
8328:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8329:             SELECT cursor_4c_GradFase
8330:             IF cursor_4c_GradFase.ordems <= 0
8331:                 MsgAviso("Ordem deve ser maior que zero.", "Fase")
8332:                 RETURN .F.
8333:             ENDIF
8334:         ENDIF
8335:         RETURN .T.
8336:     ENDPROC
8337: 
8338:     *===========================================================================
8339:     * GrdFaseCol2FaseValid - Lookup de fase/grupo (SigCdGcr) na GradFase
8340:     * PUBLIC: BINDEVENT requer metodo publico
8341:     *===========================================================================
8342:     PROCEDURE GrdFaseCol2FaseValid()
8343:         LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
8344:         TRY
8345:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8346:                 loc_lResultado = .T.
8347:             ENDIF
8348:             SELECT cursor_4c_GradFase
8349:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.grupos)
8350:             IF EMPTY(loc_cValAtual)
8351:                 loc_lResultado = .T.
8352:             ENDIF
8353: 
8354:             loc_nRet = SQLEXEC(gnConnHandle, ;
8355:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = '" + ;
8356:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseGcrBusca")
8357:             IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrBusca") AND !EOF("cursor_4c_FaseGcrBusca")
8358:                 IF USED("cursor_4c_FaseGcrBusca")
8359:                     USE IN cursor_4c_FaseGcrBusca
8360:                 ENDIF
8361:                 loc_lResultado = .T.
8362:             ENDIF
8363:             IF USED("cursor_4c_FaseGcrBusca")
8364:                 USE IN cursor_4c_FaseGcrBusca
8365:             ENDIF
8366: 
8367:             *-- Codigo nao encontrado: abrir busca
8368:             loc_nRet = SQLEXEC(gnConnHandle, ;
8369:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE '" + ;
8370:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY codigos", "cursor_4c_FaseGcrBusca")
8371:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseGcrBusca") OR EOF("cursor_4c_FaseGcrBusca")
8372:                 IF USED("cursor_4c_FaseGcrBusca")
8373:                     USE IN cursor_4c_FaseGcrBusca
8374:                 ENDIF
8375:                 SQLEXEC(gnConnHandle, ;
8376:                     "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
8377:                     "cursor_4c_FaseGcrBusca")
8378:             ENDIF
8379: 
8380:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8381:             IF VARTYPE(loc_oBusca) = "O"
8382:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseGcrBusca"
8383:                 loc_oBusca.DefinirCursor("cursor_4c_FaseGcrBusca", "codigos", "descrs", ;
8384:                     "Selecionar Fase/Grupo")
8385:                 loc_oBusca.Mostrar()
8386:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8387:                     SELECT cursor_4c_GradFase
8388:                     REPLACE cursor_4c_GradFase.grupos WITH loc_oBusca.cCodigoSelecionado
8389:                 ENDIF
8390:                 loc_oBusca = .NULL.
8391:             ENDIF
8392: 
8393:             IF USED("cursor_4c_FaseGcrBusca")
8394:                 USE IN cursor_4c_FaseGcrBusca
8395:             ENDIF
8396: 
8397:         CATCH TO loException
8398:             IF USED("cursor_4c_FaseGcrBusca")
8399:                 USE IN cursor_4c_FaseGcrBusca
8400:             ENDIF
8401:             MostrarErro("Erro ao validar fase:" + CHR(13) + loException.Message, ;
8402:                 "FormProduto.GrdFaseCol2FaseValid")
8403:         ENDTRY
8404:         RETURN .T.
8405:     ENDPROC
8406: 
8407:     *===========================================================================
8408:     * GrdFaseCol4UniPrdtValid - Lookup de Unidade Produtiva (SigCdUpd) na GradFase
8409:     * PUBLIC: BINDEVENT requer metodo publico
8410:     *===========================================================================
8411:     PROCEDURE GrdFaseCol4UniPrdtValid()
8412:         LOCAL loc_cValAtual, loc_cGrupos, loc_nRet, loc_oBusca, loException
8413:         TRY
8414:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8415:                 loc_lResultado = .T.
8416:             ENDIF
8417:             SELECT cursor_4c_GradFase
8418:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.uniprdts)
8419:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8420:             IF EMPTY(loc_cValAtual)
8421:                 loc_lResultado = .T.
8422:             ENDIF
8423: 
8424:             loc_nRet = SQLEXEC(gnConnHandle, ;
8425:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = " + ;
8426:                 EscaparSQL(loc_cGrupos), "cursor_4c_FaseUpdBusca")
8427:             IF loc_nRet > 0 AND USED("cursor_4c_FaseUpdBusca")
8428:                 LOCATE FOR ALLTRIM(cursor_4c_FaseUpdBusca.uniprdts) == ALLTRIM(loc_cValAtual)
8429:                 IF !EOF("cursor_4c_FaseUpdBusca")
8430:                     loc_lResultado = .T.
8431:                 ENDIF
8432:                 USE IN cursor_4c_FaseUpdBusca
8433:             ENDIF
8434:             IF USED("cursor_4c_FaseUpdBusca")
8435:                 USE IN cursor_4c_FaseUpdBusca
8436:             ENDIF
8437: 
8438:             *-- Abrir busca das unidades produtivas para este grupo
8439:             loc_nRet = SQLEXEC(gnConnHandle, ;
8440:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = " + ;
8441:                 EscaparSQL(loc_cGrupos) + " ORDER BY uniprdts", "cursor_4c_FaseUpdBusca")
8442:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseUpdBusca") OR EOF("cursor_4c_FaseUpdBusca")
8443:                 IF USED("cursor_4c_FaseUpdBusca")
8444:                     USE IN cursor_4c_FaseUpdBusca
8445:                 ENDIF
8446:                 SQLEXEC(gnConnHandle, ;
8447:                     "SELECT DISTINCT uniprdts FROM SigCdUpd ORDER BY uniprdts", ;
8448:                     "cursor_4c_FaseUpdBusca")
8449:             ENDIF
8450: 
8451:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8452:             IF VARTYPE(loc_oBusca) = "O"
8453:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseUpdBusca"
8454:                 loc_oBusca.DefinirCursor("cursor_4c_FaseUpdBusca", "uniprdts", "uniprdts", ;
8455:                     "Selecionar Uni. Produtiva")
8456:                 loc_oBusca.Mostrar()
8457:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8458:                     SELECT cursor_4c_GradFase
8459:                     REPLACE cursor_4c_GradFase.uniprdts WITH loc_oBusca.cCodigoSelecionado
8460:                 ENDIF
8461:                 loc_oBusca = .NULL.
8462:             ENDIF
8463: 
8464:             IF USED("cursor_4c_FaseUpdBusca")
8465:                 USE IN cursor_4c_FaseUpdBusca
8466:             ENDIF
8467: 
8468:         CATCH TO loException
8469:             IF USED("cursor_4c_FaseUpdBusca")
8470:                 USE IN cursor_4c_FaseUpdBusca
8471:             ENDIF
8472:             MostrarErro("Erro ao validar uni. produtiva:" + CHR(13) + loException.Message, ;
8473:                 "FormProduto.GrdFaseCol4UniPrdtValid")
8474:         ENDTRY
8475:         RETURN .T.
8476:     ENDPROC
8477: 
8478:     *===========================================================================
8479:     * GrdFaseCol5MatPrdtValid - Lookup de Material (SigOpOpt) na GradFase
8480:     * PUBLIC: BINDEVENT requer metodo publico
8481:     *===========================================================================
8482:     PROCEDURE GrdFaseCol5MatPrdtValid()
8483:         LOCAL loc_cValAtual, loc_cGrupos, loc_nRet, loc_oBusca, loException
8484:         TRY
8485:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8486:                 loc_lResultado = .T.
8487:             ENDIF
8488:             SELECT cursor_4c_GradFase
8489:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.matprdts)
8490:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8491:             IF EMPTY(loc_cValAtual)
8492:                 loc_lResultado = .T.
8493:             ENDIF
8494: 
8495:             loc_nRet = SQLEXEC(gnConnHandle, ;
8496:                 "SELECT cods, descs FROM SigOpOpt WHERE cods = '" + ;
8497:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseOptBusca")
8498:             IF loc_nRet > 0 AND USED("cursor_4c_FaseOptBusca") AND !EOF("cursor_4c_FaseOptBusca")
8499:                 IF USED("cursor_4c_FaseOptBusca")
8500:                     USE IN cursor_4c_FaseOptBusca
8501:                 ENDIF
8502:                 loc_lResultado = .T.
8503:             ENDIF
8504:             IF USED("cursor_4c_FaseOptBusca")
8505:                 USE IN cursor_4c_FaseOptBusca
8506:             ENDIF
8507: 
8508:             *-- Abrir busca filtrando pelo grupo da fase
8509:             loc_nRet = SQLEXEC(gnConnHandle, ;
8510:                 "SELECT cods, descs FROM SigOpOpt WHERE grupos = '" + ;
8511:                 EscaparSQL(loc_cGrupos) + " AND cods LIKE '" + ;
8512:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_FaseOptBusca")
8513:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseOptBusca") OR EOF("cursor_4c_FaseOptBusca")
8514:                 IF USED("cursor_4c_FaseOptBusca")
8515:                     USE IN cursor_4c_FaseOptBusca
8516:                 ENDIF
8517:                 SQLEXEC(gnConnHandle, ;
8518:                     "SELECT cods, descs FROM SigOpOpt ORDER BY cods", ;
8519:                     "cursor_4c_FaseOptBusca")
8520:             ENDIF
8521: 
8522:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8523:             IF VARTYPE(loc_oBusca) = "O"
8524:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseOptBusca"
8525:                 loc_oBusca.DefinirCursor("cursor_4c_FaseOptBusca", "cods", "descs", ;
8526:                     "Selecionar Material")
8527:                 loc_oBusca.Mostrar()
8528:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8529:                     SELECT cursor_4c_GradFase
8530:                     REPLACE cursor_4c_GradFase.matprdts WITH loc_oBusca.cCodigoSelecionado
8531:                 ENDIF
8532:                 loc_oBusca = .NULL.
8533:             ENDIF
8534: 
8535:             IF USED("cursor_4c_FaseOptBusca")
8536:                 USE IN cursor_4c_FaseOptBusca
8537:             ENDIF
8538: 
8539:         CATCH TO loException
8540:             IF USED("cursor_4c_FaseOptBusca")
8541:                 USE IN cursor_4c_FaseOptBusca
8542:             ENDIF
8543:             MostrarErro("Erro ao validar material:" + CHR(13) + loException.Message, ;
8544:                 "FormProduto.GrdFaseCol5MatPrdtValid")
8545:         ENDTRY
8546:         RETURN .T.
8547:     ENDPROC
8548: 
8549:     *===========================================================================
8550:     * BtnInserirFaseClick - Insere nova linha na GradFase (cursor_4c_GradFase)
8551:     * PUBLIC: BINDEVENT requer metodo publico
8552:     *===========================================================================
8553:     PROCEDURE BtnInserirFaseClick()
8554:         LOCAL loc_oPg, loc_nProxOrdem, loException
8555:         TRY
8556:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8557:                 RETURN
8558:             ENDIF
8559:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8560:             IF !USED("cursor_4c_GradFase")
8561:                 RETURN
8562:             ENDIF
8563: 
8564:             SELECT cursor_4c_GradFase
8565:             IF EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase") OR ;
8566:                     RECCOUNT("cursor_4c_GradFase") = 0
8567:                 loc_nProxOrdem = 1
8568:             ELSE
8569:                 GO BOTTOM IN cursor_4c_GradFase
8570:                 loc_nProxOrdem = cursor_4c_GradFase.ordems + 1
8571:             ENDIF
8572: 
8573:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8574:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8575: 
8576:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8577:                 loc_oPg.grd_4c_GradFase.Refresh()
8578:                 GO BOTTOM IN cursor_4c_GradFase
8579:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8580:             ENDIF
8581: 
8582:         CATCH TO loException
8583:             MostrarErro("Erro ao inserir fase:" + CHR(13) + loException.Message, ;
8584:                 "FormProduto.BtnInserirFaseClick")
8585:         ENDTRY
8586:     ENDPROC
8587: 
8588:     *===========================================================================
8589:     * BtnExcluirFaseClick - Exclui linha atual da GradFase
8590:     * PUBLIC: BINDEVENT requer metodo publico
8591:     *===========================================================================
8592:     PROCEDURE BtnExcluirFaseClick()
8593:         LOCAL loc_oPg, loException
8594:         TRY
8595:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8596:                 RETURN
8597:             ENDIF
8598:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8599:                 RETURN
8600:             ENDIF
8601: 
8602:             SELECT cursor_4c_GradFase
8603:             IF !MsgConfirma("Excluir esta fase de produ" + CHR(231) + CHR(227) + "o?")
8604:                 RETURN
8605:             ENDIF
8606:             DELETE IN cursor_4c_GradFase
8607:             IF !EOF("cursor_4c_GradFase")
8608:                 SKIP IN cursor_4c_GradFase
8609:             ENDIF
8610:             IF EOF("cursor_4c_GradFase") AND RECCOUNT("cursor_4c_GradFase") > 0
8611:                 GO BOTTOM IN cursor_4c_GradFase
8612:             ENDIF
8613: 
8614:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8615:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8616:                 loc_oPg.grd_4c_GradFase.Refresh()
8617:             ENDIF
8618: 
8619:         CATCH TO loException
8620:             MostrarErro("Erro ao excluir fase:" + CHR(13) + loException.Message, ;
8621:                 "FormProduto.BtnExcluirFaseClick")
8622:         ENDTRY
8623:     ENDPROC
8624: 
8625:     *===========================================================================
8626:     * BtnAlternativaFaseClick - Insere fase alternativa apos a fase atual
8627:     * PUBLIC: BINDEVENT requer metodo publico
8628:     *===========================================================================
8629:     PROCEDURE BtnAlternativaFaseClick()
8630:         LOCAL loc_oPg, loc_nOrdemAtual, loc_nProxOrdem, loException
8631:         TRY
8632:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8633:                 RETURN
8634:             ENDIF
8635:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8636:             IF !USED("cursor_4c_GradFase")
8637:                 RETURN
8638:             ENDIF
8639: 
8640:             SELECT cursor_4c_GradFase
8641:             IF EOF("cursor_4c_GradFase") OR RECCOUNT("cursor_4c_GradFase") = 0
8642:                 loc_nOrdemAtual = 0
8643:             ELSE
8644:                 loc_nOrdemAtual = cursor_4c_GradFase.ordems
8645:             ENDIF
8646:             loc_nProxOrdem = loc_nOrdemAtual + 1
8647: 
8648:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8649:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8650: 
8651:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8652:                 loc_oPg.grd_4c_GradFase.Refresh()
8653:                 GO BOTTOM IN cursor_4c_GradFase
8654:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8655:             ENDIF
8656: 
8657:         CATCH TO loException
8658:             MostrarErro("Erro ao inserir fase alternativa:" + CHR(13) + loException.Message, ;
8659:                 "FormProduto.BtnAlternativaFaseClick")
8660:         ENDTRY
8661:     ENDPROC
8662: 
8663:     *===========================================================================
8664:     * CmdFichaFasePClick - Abre formulario de Ficha Tecnica do produto
8665:     * PUBLIC: BINDEVENT requer metodo publico
8666:     *===========================================================================
8667:     PROCEDURE CmdFichaFasePClick()
8668:         LOCAL loc_cCpros, loException
8669:         TRY
8670:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
8671:             IF EMPTY(loc_cCpros)
8672:                 MsgAviso("Selecione um produto para abrir a Ficha T" + CHR(233) + "cnica.", ;
8673:                     "Ficha T" + CHR(233) + "cnica")
8674:                 RETURN
8675:             ENDIF
8676:             MsgInfo("Ficha T" + CHR(233) + "cnica: " + loc_cCpros)
8677:         CATCH TO loException
8678:             MostrarErro("Erro ao abrir Ficha T" + CHR(233) + "cnica:" + CHR(13) + ;
8679:                 loException.Message, "FormProduto.CmdFichaFasePClick")
8680:         ENDTRY
8681:     ENDPROC
8682: 
8683:     *===========================================================================
8684:     * CmdFiguraFasePClick - Captura imagem do produto via seletor de arquivo
8685:     * PUBLIC: BINDEVENT requer metodo publico
8686:     *===========================================================================
8687:     PROCEDURE CmdFiguraFasePClick()
8688:         LOCAL loc_lcFigura, loc_lcArquivo, loc_oPg, loException
8689:         TRY
8690:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8691:                 RETURN
8692:             ENDIF
8693:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8694:                 MsgAviso("Selecione uma fase na grade para associar a imagem.", "Imagem")
8695:                 RETURN
8696:             ENDIF
8697: 
8698:             loc_lcFigura = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", ;
8699:                 "Nome do Arquivo:", "Selecionar"))
8700:             IF EMPTY(loc_lcFigura) OR !FILE(loc_lcFigura)
8701:                 RETURN
8702:             ENDIF
8703: 
8704:             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8705:             COPY FILE (loc_lcFigura) TO (loc_lcArquivo)
8706: 
8707:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8708:             IF PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5)
8709:                 CLEAR RESOURCES
8710:                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
8711:                 loc_oPg.img_4c_ImgFig.Visible = .T.
8712:             ENDIF
8713: 
8714:         CATCH TO loException
8715:             MostrarErro("Erro ao capturar imagem:" + CHR(13) + loException.Message, ;
8716:                 "FormProduto.CmdFiguraFasePClick")
8717:         ENDTRY
8718:     ENDPROC
8719: 
8720:     *===========================================================================
8721:     * CmdFigCamFasePClick - Captura imagem do produto via WebCam (SigImage)
8722:     * PUBLIC: BINDEVENT requer metodo publico
8723:     *===========================================================================
8724:     PROCEDURE CmdFigCamFasePClick()
8725:         LOCAL loc_lcFigura, loc_lcArquivo, loc_oPg, loException
8726:         TRY
8727:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8728:                 RETURN
8729:             ENDIF
8730:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8731:                 MsgAviso("Selecione uma fase na grade para associar a imagem.", "Imagem WebCam")
8732:                 RETURN
8733:             ENDIF
8734: 
8735:             loc_lcFigura = ""
8736:             DO FORM SigImage TO loc_lcFigura
8737:             IF EMPTY(loc_lcFigura) OR !FILE(loc_lcFigura)
8738:                 RETURN
8739:             ENDIF
8740: 
8741:             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8742:             COPY FILE (loc_lcFigura) TO (loc_lcArquivo)
8743: 
8744:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8745:             IF PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5)
8746:                 CLEAR RESOURCES
8747:                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
8748:                 loc_oPg.img_4c_ImgFig.Visible = .T.
8749:             ENDIF
8750: 
8751:         CATCH TO loException
8752:             MostrarErro("Erro ao capturar imagem via WebCam:" + CHR(13) + loException.Message, ;
8753:                 "FormProduto.CmdFigCamFasePClick")
8754:         ENDTRY
8755:     ENDPROC
8756: 
8757:     *===========================================================================
8758:     * ValidarConquilhaFaseP - Lookup de Conquilha (sigcdcnq) em txt_4c_Conquilhas
8759:     * PUBLIC: BINDEVENT requer metodo publico
8760:     *===========================================================================
8761:     PROCEDURE ValidarConquilhaFaseP(par_nKeyCode, par_nShiftAltCtrl)
8762:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8763:         TRY
8764:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8765:             IF !PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
8766:                 loc_lResultado = .T.
8767:             ENDIF
8768:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value)
8769:             IF EMPTY(loc_cValAtual)
8770:                 loc_lResultado = .T.
8771:             ENDIF
8772: 
8773:             loc_nRet = SQLEXEC(gnConnHandle, ;
8774:                 "SELECT DISTINCT conquilhas FROM sigcdcnq ORDER BY conquilhas", ;
8775:                 "cursor_4c_CnqBusca")
8776:             IF loc_nRet > 0 AND USED("cursor_4c_CnqBusca")
8777:                 LOCATE FOR ALLTRIM(cursor_4c_CnqBusca.conquilhas) == ALLTRIM(loc_cValAtual)
8778:                 IF !EOF("cursor_4c_CnqBusca")
8779:                     loc_lResultado = .T.
8780:                 ENDIF
8781:                 USE IN cursor_4c_CnqBusca
8782:             ENDIF
8783:             IF USED("cursor_4c_CnqBusca")
8784:                 USE IN cursor_4c_CnqBusca
8785:             ENDIF
8786: 
8787:             loc_nRet = SQLEXEC(gnConnHandle, ;
8788:                 "SELECT DISTINCT conquilhas FROM sigcdcnq ORDER BY conquilhas", ;
8789:                 "cursor_4c_CnqBusca")
8790: 
8791:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8792:             IF VARTYPE(loc_oBusca) = "O"
8793:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CnqBusca"
8794:                 loc_oBusca.DefinirCursor("cursor_4c_CnqBusca", "conquilhas", "conquilhas", ;
8795:                     "Selecionar Conquilha")
8796:                 loc_oBusca.Mostrar()
8797:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8798:                     loc_oPg.txt_4c_Conquilhas.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8799:                 ENDIF
8800:                 loc_oBusca = .NULL.
8801:             ENDIF
8802: 
8803:             IF USED("cursor_4c_CnqBusca")
8804:                 USE IN cursor_4c_CnqBusca
8805:             ENDIF
8806: 
8807:         CATCH TO loException
8808:             IF USED("cursor_4c_CnqBusca")
8809:                 USE IN cursor_4c_CnqBusca
8810:             ENDIF
8811:             MostrarErro("Erro ao validar conquilha:" + CHR(13) + loException.Message, ;
8812:                 "FormProduto.ValidarConquilhaFaseP")
8813:         ENDTRY
8814:         RETURN .T.
8815:     ENDPROC
8816: 
8817:     *===========================================================================
8818:     * ValidarCorFaseP - Lookup de Cor Padrao (SigCdCor) em txt_4c_CodCorsFP
8819:     * PUBLIC: BINDEVENT requer metodo publico
8820:     *===========================================================================
8821:     PROCEDURE ValidarCorFaseP(par_nKeyCode, par_nShiftAltCtrl)
8822:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8823:         TRY
8824:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8825:             IF !PEMSTATUS(loc_oPg, "txt_4c_CodCorsFP", 5)
8826:                 loc_lResultado = .T.
8827:             ENDIF
8828:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodCorsFP.Value)
8829:             IF EMPTY(loc_cValAtual)
8830:                 loc_lResultado = .T.
8831:             ENDIF
8832: 
8833:             loc_nRet = SQLEXEC(gnConnHandle, ;
8834:                 "SELECT cods, descs FROM SigCdCor WHERE cods = '" + ;
8835:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_CorFPBusca")
8836:             IF loc_nRet > 0 AND USED("cursor_4c_CorFPBusca") AND !EOF("cursor_4c_CorFPBusca")
8837:                 IF USED("cursor_4c_CorFPBusca")
8838:                     USE IN cursor_4c_CorFPBusca
8839:                 ENDIF
8840:                 *-- Sincronizar com Page1
8841:                 LOCAL loc_oPg1
8842:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8843:                 IF PEMSTATUS(loc_oPg1, "txt_4c_CodCors", 5)
8844:                     loc_oPg1.txt_4c_CodCors.Value = loc_cValAtual
8845:                 ENDIF
8846:                 loc_lResultado = .T.
8847:             ENDIF
8848:             IF USED("cursor_4c_CorFPBusca")
8849:                 USE IN cursor_4c_CorFPBusca
8850:             ENDIF
8851: 
8852:             loc_nRet = SQLEXEC(gnConnHandle, ;
8853:                 "SELECT cods, descs FROM SigCdCor WHERE cods LIKE '" + ;
8854:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_CorFPBusca")
8855:             IF loc_nRet <= 0 OR !USED("cursor_4c_CorFPBusca") OR EOF("cursor_4c_CorFPBusca")
8856:                 IF USED("cursor_4c_CorFPBusca")
8857:                     USE IN cursor_4c_CorFPBusca
8858:                 ENDIF
8859:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCor ORDER BY cods", ;
8860:                     "cursor_4c_CorFPBusca")
8861:             ENDIF
8862: 
8863:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8864:             IF VARTYPE(loc_oBusca) = "O"
8865:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CorFPBusca"
8866:                 loc_oBusca.DefinirCursor("cursor_4c_CorFPBusca", "cods", "descs", ;
8867:                     "Selecionar Cor Padr" + CHR(227) + "o")
8868:                 loc_oBusca.Mostrar()
8869:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8870:                     loc_oPg.txt_4c_CodCorsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8871:                     LOCAL loc_oPg1b
8872:                     loc_oPg1b = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8873:                     IF PEMSTATUS(loc_oPg1b, "txt_4c_CodCors", 5)
8874:                         loc_oPg1b.txt_4c_CodCors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8875:                     ENDIF
8876:                 ENDIF
8877:                 loc_oBusca = .NULL.
8878:             ENDIF
8879: 
8880:             IF USED("cursor_4c_CorFPBusca")
8881:                 USE IN cursor_4c_CorFPBusca
8882:             ENDIF
8883: 
8884:         CATCH TO loException
8885:             IF USED("cursor_4c_CorFPBusca")
8886:                 USE IN cursor_4c_CorFPBusca
8887:             ENDIF
8888:             MostrarErro("Erro ao validar cor padr" + CHR(227) + "o:" + CHR(13) + ;
8889:                 loException.Message, "FormProduto.ValidarCorFaseP")
8890:         ENDTRY
8891:         RETURN .T.
8892:     ENDPROC
8893: 
8894:     *===========================================================================
8895:     * ValidarTamFaseP - Lookup de Tamanho Padrao (SigCdTam) em txt_4c_CodTamsFP
8896:     * PUBLIC: BINDEVENT requer metodo publico
8897:     *===========================================================================
8898:     PROCEDURE ValidarTamFaseP(par_nKeyCode, par_nShiftAltCtrl)
8899:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8900:         TRY
8901:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8902:             IF !PEMSTATUS(loc_oPg, "txt_4c_CodTamsFP", 5)
8903:                 loc_lResultado = .T.
8904:             ENDIF
8905:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodTamsFP.Value)
8906:             IF EMPTY(loc_cValAtual)
8907:                 loc_lResultado = .T.
8908:             ENDIF
8909: 
8910:             loc_nRet = SQLEXEC(gnConnHandle, ;
8911:                 "SELECT cods, descs FROM SigCdTam WHERE cods = '" + ;
8912:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_TamFPBusca")
8913:             IF loc_nRet > 0 AND USED("cursor_4c_TamFPBusca") AND !EOF("cursor_4c_TamFPBusca")
8914:                 IF USED("cursor_4c_TamFPBusca")
8915:                     USE IN cursor_4c_TamFPBusca
8916:                 ENDIF
8917:                 LOCAL loc_oPg1c
8918:                 loc_oPg1c = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8919:                 IF PEMSTATUS(loc_oPg1c, "txt_4c_CodTams", 5)
8920:                     loc_oPg1c.txt_4c_CodTams.Value = loc_cValAtual
8921:                 ENDIF
8922:                 loc_lResultado = .T.
8923:             ENDIF
8924:             IF USED("cursor_4c_TamFPBusca")
8925:                 USE IN cursor_4c_TamFPBusca
8926:             ENDIF
8927: 
8928:             loc_nRet = SQLEXEC(gnConnHandle, ;
8929:                 "SELECT cods, descs FROM SigCdTam WHERE cods LIKE '" + ;
8930:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_TamFPBusca")
8931:             IF loc_nRet <= 0 OR !USED("cursor_4c_TamFPBusca") OR EOF("cursor_4c_TamFPBusca")
8932:                 IF USED("cursor_4c_TamFPBusca")
8933:                     USE IN cursor_4c_TamFPBusca
8934:                 ENDIF
8935:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdTam ORDER BY cods", ;
8936:                     "cursor_4c_TamFPBusca")
8937:             ENDIF
8938: 
8939:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8940:             IF VARTYPE(loc_oBusca) = "O"
8941:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TamFPBusca"
8942:                 loc_oBusca.DefinirCursor("cursor_4c_TamFPBusca", "cods", "descs", ;
8943:                     "Selecionar Tamanho Padr" + CHR(227) + "o")
8944:                 loc_oBusca.Mostrar()
8945:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8946:                     loc_oPg.txt_4c_CodTamsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8947:                     LOCAL loc_oPg1d
8948:                     loc_oPg1d = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8949:                     IF PEMSTATUS(loc_oPg1d, "txt_4c_CodTams", 5)
8950:                         loc_oPg1d.txt_4c_CodTams.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8951:                     ENDIF
8952:                 ENDIF
8953:                 loc_oBusca = .NULL.
8954:             ENDIF
8955: 
8956:             IF USED("cursor_4c_TamFPBusca")
8957:                 USE IN cursor_4c_TamFPBusca
8958:             ENDIF
8959: 
8960:         CATCH TO loException
8961:             IF USED("cursor_4c_TamFPBusca")
8962:                 USE IN cursor_4c_TamFPBusca
8963:             ENDIF
8964:             MostrarErro("Erro ao validar tamanho padr" + CHR(227) + "o:" + CHR(13) + ;
8965:                 loException.Message, "FormProduto.ValidarTamFaseP")
8966:         ENDTRY
8967:         RETURN .T.
8968:     ENDPROC
8969: 
8970:     *===========================================================================
8971:     * ValidarAcabamentoFaseP - Lookup de Acabamento (SigCdAca) em txt_4c_CodAcbsFP
8972:     * PUBLIC: BINDEVENT requer metodo publico
8973:     *===========================================================================
8974:     PROCEDURE ValidarAcabamentoFaseP(par_nKeyCode, par_nShiftAltCtrl)
8975:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8976:         TRY
8977:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8978:             IF !PEMSTATUS(loc_oPg, "txt_4c_CodAcbsFP", 5)
8979:                 loc_lResultado = .T.
8980:             ENDIF
8981:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodAcbsFP.Value)
8982:             IF EMPTY(loc_cValAtual)
8983:                 loc_oPg.txt_4c_DacbFP.Value = ""
8984:                 loc_lResultado = .T.
8985:             ENDIF
8986: 
8987:             loc_nRet = SQLEXEC(gnConnHandle, ;
8988:                 "SELECT cods, descrs FROM SigCdAca WHERE cods = '" + ;
8989:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_AcaFPBusca")
8990:             IF loc_nRet > 0 AND USED("cursor_4c_AcaFPBusca") AND !EOF("cursor_4c_AcaFPBusca")
8991:                 SELECT cursor_4c_AcaFPBusca
8992:                 loc_oPg.txt_4c_DacbFP.Value = ALLTRIM(cursor_4c_AcaFPBusca.descrs)
8993:                 IF USED("cursor_4c_AcaFPBusca")
8994:                     USE IN cursor_4c_AcaFPBusca
8995:                 ENDIF
8996:                 LOCAL loc_oPg1e
8997:                 loc_oPg1e = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8998:                 IF PEMSTATUS(loc_oPg1e, "txt_4c_CodAcbs", 5)
8999:                     loc_oPg1e.txt_4c_CodAcbs.Value = loc_cValAtual
9000:                 ENDIF
9001:                 loc_lResultado = .T.
9002:             ENDIF
9003:             IF USED("cursor_4c_AcaFPBusca")
9004:                 USE IN cursor_4c_AcaFPBusca
9005:             ENDIF
9006: 
9007:             loc_nRet = SQLEXEC(gnConnHandle, ;
9008:                 "SELECT cods, descrs FROM SigCdAca WHERE cods LIKE '" + ;
9009:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_AcaFPBusca")
9010:             IF loc_nRet <= 0 OR !USED("cursor_4c_AcaFPBusca") OR EOF("cursor_4c_AcaFPBusca")
9011:                 IF USED("cursor_4c_AcaFPBusca")
9012:                     USE IN cursor_4c_AcaFPBusca
9013:                 ENDIF
9014:                 SQLEXEC(gnConnHandle, "SELECT cods, descrs FROM SigCdAca ORDER BY cods", ;
9015:                     "cursor_4c_AcaFPBusca")
9016:             ENDIF
9017: 
9018:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9019:             IF VARTYPE(loc_oBusca) = "O"
9020:                 loc_oBusca.this_cCursorDestino = "cursor_4c_AcaFPBusca"
9021:                 loc_oBusca.DefinirCursor("cursor_4c_AcaFPBusca", "cods", "descrs", ;
9022:                     "Selecionar Acabamento")
9023:                 loc_oBusca.Mostrar()
9024:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
9025:                     loc_oPg.txt_4c_CodAcbsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
9026:                     loc_oPg.txt_4c_DacbFP.Value    = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
9027:                     LOCAL loc_oPg1f
9028:                     loc_oPg1f = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9029:                     IF PEMSTATUS(loc_oPg1f, "txt_4c_CodAcbs", 5)
9030:                         loc_oPg1f.txt_4c_CodAcbs.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
9031:                     ENDIF
9032:                 ENDIF
9033:                 loc_oBusca = .NULL.
9034:             ENDIF
9035: 
9036:             IF USED("cursor_4c_AcaFPBusca")
9037:                 USE IN cursor_4c_AcaFPBusca
9038:             ENDIF
9039: 
9040:         CATCH TO loException
9041:             IF USED("cursor_4c_AcaFPBusca")
9042:                 USE IN cursor_4c_AcaFPBusca
9043:             ENDIF
9044:             MostrarErro("Erro ao validar acabamento:" + CHR(13) + loException.Message, ;
9045:                 "FormProduto.ValidarAcabamentoFaseP")
9046:         ENDTRY
9047:         RETURN .T.
9048:     ENDPROC
9049: 
9050:     *===========================================================================
9051:     * GrdMatrizesCol1Valid - Lookup de produto-matriz (SigCdPro) em grdMatrizes
9052:     * PUBLIC: BINDEVENT requer metodo publico
9053:     *===========================================================================
9054:     PROCEDURE GrdMatrizesCol1Valid()
9055:         LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
9056:         TRY
9057:             IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
9058:                 loc_lResultado = .T.
9059:             ENDIF
9060:             SELECT cursor_4c_GrdMatrizes
9061:             loc_cValAtual = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9062:             IF EMPTY(loc_cValAtual)
9063:                 loc_lResultado = .T.
9064:             ENDIF
9065: 
9066:             loc_nRet = SQLEXEC(gnConnHandle, ;
9067:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros = '" + ;
9068:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_MtzPrBusca")
9069:             IF loc_nRet > 0 AND USED("cursor_4c_MtzPrBusca") AND !EOF("cursor_4c_MtzPrBusca")
9070:                 SELECT cursor_4c_MtzPrBusca
9071:                 SELECT cursor_4c_GrdMatrizes
9072:                 REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(cursor_4c_MtzPrBusca.dpros)
9073:                 IF USED("cursor_4c_MtzPrBusca")
9074:                     USE IN cursor_4c_MtzPrBusca
9075:                 ENDIF
9076:                 loc_lResultado = .T.
9077:             ENDIF
9078:             IF USED("cursor_4c_MtzPrBusca")
9079:                 USE IN cursor_4c_MtzPrBusca
9080:             ENDIF
9081: 
9082:             *-- Codigo nao encontrado: abrir busca
9083:             loc_nRet = SQLEXEC(gnConnHandle, ;
9084:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros LIKE '" + ;
9085:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cpros", "cursor_4c_MtzPrBusca")
9086:             IF loc_nRet <= 0 OR !USED("cursor_4c_MtzPrBusca") OR EOF("cursor_4c_MtzPrBusca")
9087:                 IF USED("cursor_4c_MtzPrBusca")
9088:                     USE IN cursor_4c_MtzPrBusca
9089:                 ENDIF
9090:                 SQLEXEC(gnConnHandle, ;
9091:                     "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
9092:                     "cursor_4c_MtzPrBusca")
9093:             ENDIF
9094: 
9095:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9096:             IF VARTYPE(loc_oBusca) = "O"
9097:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MtzPrBusca"
9098:                 loc_oBusca.DefinirCursor("cursor_4c_MtzPrBusca", "cpros", "dpros", ;
9099:                     "Selecionar Produto Matriz")
9100:                 loc_oBusca.Mostrar()
9101:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdMatrizes")
9102:                     SELECT cursor_4c_GrdMatrizes
9103:                     REPLACE cursor_4c_GrdMatrizes.cmats WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
9104:                     REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
9105:                 ENDIF
9106:                 loc_oBusca = .NULL.
9107:             ENDIF
9108: 
9109:             IF USED("cursor_4c_MtzPrBusca")
9110:                 USE IN cursor_4c_MtzPrBusca
9111:             ENDIF
9112: 
9113:         CATCH TO loException
9114:             IF USED("cursor_4c_MtzPrBusca")
9115:                 USE IN cursor_4c_MtzPrBusca
9116:             ENDIF
9117:             MostrarErro("Erro ao validar matriz:" + CHR(13) + loException.Message, ;
9118:                 "FormProduto.GrdMatrizesCol1Valid")
9119:         ENDTRY
9120:         RETURN .T.
9121:     ENDPROC
9122: 
9123:     *===========================================================================
9124:     * GrdMatrizesAfterRowColChange - Exibe imagem do molde da matriz selecionada
9125:     * PUBLIC: BINDEVENT requer metodo publico
9126:     *===========================================================================
9127:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
9128:         LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
9129:         TRY
9130:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9131:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) OR !USED("cursor_4c_GrdMatrizes")
9132:                 RETURN
9133:             ENDIF
9134: 
9135:             CLEAR RESOURCES
9136:             loc_oPg.img_4c_ImgBorracha.Picture = ""
9137:             loc_oPg.img_4c_ImgBorracha.Visible = .F.
9138: 
9139:             IF !EOF("cursor_4c_GrdMatrizes") AND !BOF("cursor_4c_GrdMatrizes")
9140:                 SELECT cursor_4c_GrdMatrizes
9141:                 LOCAL loc_cCmats
9142:                 loc_cCmats = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9143:                 IF !EMPTY(loc_cCmats)
9144:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9145:                         "SELECT figprocs FROM SigCdPro WHERE cpros = '" + ;
9146:                         EscaparSQL(loc_cCmats) + "", "cursor_4c_MtzImgPro")
9147:                     IF loc_nRet > 0 AND USED("cursor_4c_MtzImgPro") AND !EOF("cursor_4c_MtzImgPro")
9148:                         SELECT cursor_4c_MtzImgPro
9149:                         IF !ISNULL(cursor_4c_MtzImgPro.figprocs) AND ;
9150:                                 !EMPTY(cursor_4c_MtzImgPro.figprocs)
9151:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9152:                             IF STRTOFILE(cursor_4c_MtzImgPro.figprocs, loc_lcArquivo) > 0
9153:                                 loc_oPg.img_4c_ImgBorracha.Visible = .T.
9154:                                 loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9155:                             ENDIF
9156:                         ENDIF
9157:                     ENDIF
9158:                     IF USED("cursor_4c_MtzImgPro")
9159:                         USE IN cursor_4c_MtzImgPro
9160:                     ENDIF
9161:                 ENDIF
9162:             ENDIF
9163: 
9164:         CATCH TO loException
9165:             MostrarErro("Erro ao atualizar imagem de matriz:" + CHR(13) + loException.Message, ;
9166:                 "FormProduto.GrdMatrizesAfterRowColChange")
9167:         ENDTRY
9168:     ENDPROC
9169: 
9170:     *===========================================================================
9171:     * BtnInserirMtzClick - Insere nova linha em grdMatrizes (cursor_4c_GrdMatrizes)
9172:     * PUBLIC: BINDEVENT requer metodo publico
9173:     *===========================================================================
9174:     PROCEDURE BtnInserirMtzClick()
9175:         LOCAL loc_oPg, loException
9176:         TRY
9177:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9178:                 RETURN
9179:             ENDIF
9180:             IF !USED("cursor_4c_GrdMatrizes")
9181:                 RETURN
9182:             ENDIF
9183: 
9184:             INSERT INTO cursor_4c_GrdMatrizes (cidchaves, cmats, qtds, dpros) ;
9185:                 VALUES (SYS(2015), "", 0, "")
9186: 
9187:             GO BOTTOM IN cursor_4c_GrdMatrizes
9188: 
9189:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9190:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9191:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9192:                 loc_oPg.grd_4c_GrdMatrizes.Column1.SetFocus()
9193:             ENDIF
9194: 
9195:         CATCH TO loException
9196:             MostrarErro("Erro ao inserir matriz:" + CHR(13) + loException.Message, ;
9197:                 "FormProduto.BtnInserirMtzClick")
9198:         ENDTRY
9199:     ENDPROC
9200: 
9201:     *===========================================================================
9202:     * BtnExcluirMtzClick - Exclui linha atual de grdMatrizes
9203:     * PUBLIC: BINDEVENT requer metodo publico
9204:     *===========================================================================
9205:     PROCEDURE BtnExcluirMtzClick()
9206:         LOCAL loc_oPg, loException
9207:         TRY
9208:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9209:                 RETURN
9210:             ENDIF
9211:             IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
9212:                 RETURN
9213:             ENDIF
9214: 
9215:             SELECT cursor_4c_GrdMatrizes
9216:             IF !MsgConfirma("Excluir este registro de matriz?")
9217:                 RETURN
9218:             ENDIF
9219:             DELETE IN cursor_4c_GrdMatrizes
9220:             IF !EOF("cursor_4c_GrdMatrizes")
9221:                 SKIP IN cursor_4c_GrdMatrizes
9222:             ENDIF
9223:             IF EOF("cursor_4c_GrdMatrizes") AND RECCOUNT("cursor_4c_GrdMatrizes") > 0
9224:                 GO BOTTOM IN cursor_4c_GrdMatrizes
9225:             ENDIF
9226: 
9227:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9228:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9229:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9230:             ENDIF
9231: 
9232:         CATCH TO loException
9233:             MostrarErro("Erro ao excluir matriz:" + CHR(13) + loException.Message, ;
9234:                 "FormProduto.BtnExcluirMtzClick")
9235:         ENDTRY
9236:     ENDPROC
9237: 
9238:     *===========================================================================
9239:     * Handlers de BINDEVENT para pgDadosFiscais (Page3 de pgf_4c_Dados)
9240:     * Todos PUBLIC - requerido pelo BINDEVENT
9241:     *===========================================================================
9242: 
9243:     *-- Classificacao Fiscal (clfiscals): Valid
9244:     PROCEDURE ValidarClfiscal(par_nKeyCode, par_nShiftAltCtrl)
9245:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9246:             RETURN
9247:         ENDIF
9248:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9249:         TRY
9250:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9251:             IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9252:                 RETURN
9253:             ENDIF
9254:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9255:             IF EMPTY(loc_cCod)
9256:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9257:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9258:                 ENDIF
9259:                 RETURN
9260:             ENDIF
9261:             loc_nRet = SQLEXEC(gnConnHandle, ;
9262:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
9263:                 "cursor_4c_ClfBusca")
9264:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9265:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9266:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9267:                 ENDIF
9268:                 IF USED("cursor_4c_ClfBusca")
9269:                     USE IN cursor_4c_ClfBusca
9270:                 ENDIF
9271:             ELSE
9272:                 IF USED("cursor_4c_ClfBusca")
9273:                     USE IN cursor_4c_ClfBusca
9274:                 ENDIF
9275:                 THIS.AbrirBuscaClfiscal()
9276:             ENDIF
9277:         CATCH TO loException
9278:             IF USED("cursor_4c_ClfBusca")
9279:                 USE IN cursor_4c_ClfBusca
9280:             ENDIF
9281:             MostrarErro("Erro ao validar Classif. Fiscal:" + CHR(13) + loException.Message, ;
9282:                 "FormProduto.ValidarClfiscal")
9283:         ENDTRY
9284:     ENDPROC
9285: 
9286:     PROCEDURE TxtClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9287:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9288:             THIS.ValidarClfiscal()
9289:         ENDIF
9290:     ENDPROC
9291: 
9292:     *-- Classificacao Fiscal descricao: When
9293:     PROCEDURE TxtDclfiscalWhen()
9294:         LOCAL loc_oPg
9295:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9296:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9297:             RETURN .F.
9298:         ENDIF
9299:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9300:                EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
9301:     ENDPROC
9302: 
9303:     *-- Classificacao Fiscal descricao: Valid (busca por descricao)
9304:     PROCEDURE ValidarDclfiscal(par_nKeyCode, par_nShiftAltCtrl)
9305:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9306:             RETURN
9307:         ENDIF
9308:         LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
9309:         TRY
9310:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9311:             IF !PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9312:                 RETURN
9313:             ENDIF
9314:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
9315:             IF EMPTY(loc_cDesc)
9316:                 THIS.AbrirBuscaClfiscal()
9317:                 RETURN
9318:             ENDIF
9319:             loc_nRet = SQLEXEC(gnConnHandle, ;
9320:                 "SELECT codigos, descricaos FROM SigCdClf ORDER BY descricaos", ;
9321:                 "cursor_4c_ClfBusca")
9322:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca")
9323:                 LOCATE FOR LIKE(UPPER(ALLTRIM(loc_cDesc)) + "*", UPPER(ALLTRIM(cursor_4c_ClfBusca.descricaos)))
9324:             ENDIF
9325:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9326:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9327:                     loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.codigos)
9328:                 ENDIF
9329:                 loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9330:                 IF USED("cursor_4c_ClfBusca")
9331:                     USE IN cursor_4c_ClfBusca
9332:                 ENDIF
9333:             ELSE
9334:                 IF USED("cursor_4c_ClfBusca")
9335:                     USE IN cursor_4c_ClfBusca
9336:                 ENDIF
9337:                 THIS.AbrirBuscaClfiscal()
9338:             ENDIF
9339:         CATCH TO loException
9340:             IF USED("cursor_4c_ClfBusca")
9341:                 USE IN cursor_4c_ClfBusca
9342:             ENDIF
9343:             MostrarErro("Erro ao buscar Classif. Fiscal:" + CHR(13) + loException.Message, ;
9344:                 "FormProduto.ValidarDclfiscal")
9345:         ENDTRY
9346:     ENDPROC
9347: 
9348:     PROCEDURE TxtDclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9349:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9350:             THIS.ValidarDclfiscal()
9351:         ENDIF
9352:     ENDPROC
9353: 
9354:     *-- Origem Mercadoria (origmercs): Valid
9355:     PROCEDURE ValidarOrigmerc(par_nKeyCode, par_nShiftAltCtrl)
9356:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9357:             RETURN
9358:         ENDIF
9359:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9360:         TRY
9361:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9362:             IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9363:                 RETURN
9364:             ENDIF
9365:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
9366:             IF EMPTY(loc_cCod)
9367:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9368:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
9369:                 ENDIF
9370:                 RETURN
9371:             ENDIF
9372:             loc_nRet = SQLEXEC(gnConnHandle, ;
9373:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
9374:                 "cursor_4c_OrgBusca")
9375:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9376:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9377:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9378:                 ENDIF
9379:                 IF USED("cursor_4c_OrgBusca")
9380:                     USE IN cursor_4c_OrgBusca
9381:                 ENDIF
9382:             ELSE
9383:                 IF USED("cursor_4c_OrgBusca")
9384:                     USE IN cursor_4c_OrgBusca
9385:                 ENDIF
9386:                 THIS.AbrirBuscaOrigmerc()
9387:             ENDIF
9388:         CATCH TO loException
9389:             IF USED("cursor_4c_OrgBusca")
9390:                 USE IN cursor_4c_OrgBusca
9391:             ENDIF
9392:             MostrarErro("Erro ao validar Origem Mercadoria:" + CHR(13) + loException.Message, ;
9393:                 "FormProduto.ValidarOrigmerc")
9394:         ENDTRY
9395:     ENDPROC
9396: 
9397:     PROCEDURE TxtOrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9398:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9399:             THIS.ValidarOrigmerc()
9400:         ENDIF
9401:     ENDPROC
9402: 
9403:     *-- Origem Mercadoria descricao: When
9404:     PROCEDURE TxtDorigmercWhen()
9405:         LOCAL loc_oPg
9406:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9407:         IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9408:             RETURN .F.
9409:         ENDIF
9410:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9411:                EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
9412:     ENDPROC
9413: 
9414:     *-- Origem Mercadoria descricao: Valid
9415:     PROCEDURE ValidarDorigmerc(par_nKeyCode, par_nShiftAltCtrl)
9416:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9417:             RETURN
9418:         ENDIF
9419:         LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
9420:         TRY
9421:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9422:             IF !PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9423:                 RETURN
9424:             ENDIF
9425:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)
9426:             IF EMPTY(loc_cDesc)
9427:                 THIS.AbrirBuscaOrigmerc()
9428:                 RETURN
9429:             ENDIF
9430:             loc_nRet = SQLEXEC(gnConnHandle, ;
9431:                 "SELECT codigos, descricaos FROM SIGCDORG ORDER BY descricaos", ;
9432:                 "cursor_4c_OrgBusca")
9433:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca")
9434:                 LOCATE FOR LIKE(UPPER(ALLTRIM(loc_cDesc)) + "*", UPPER(ALLTRIM(cursor_4c_OrgBusca.descricaos)))
9435:             ENDIF
9436:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9437:                 IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9438:                     loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(cursor_4c_OrgBusca.codigos)
9439:                 ENDIF
9440:                 loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9441:                 IF USED("cursor_4c_OrgBusca")
9442:                     USE IN cursor_4c_OrgBusca
9443:                 ENDIF
9444:             ELSE
9445:                 IF USED("cursor_4c_OrgBusca")
9446:                     USE IN cursor_4c_OrgBusca
9447:                 ENDIF
9448:                 THIS.AbrirBuscaOrigmerc()
9449:             ENDIF
9450:         CATCH TO loException
9451:             IF USED("cursor_4c_OrgBusca")
9452:                 USE IN cursor_4c_OrgBusca
9453:             ENDIF
9454:             MostrarErro("Erro ao buscar Origem Mercadoria:" + CHR(13) + loException.Message, ;
9455:                 "FormProduto.ValidarDorigmerc")
9456:         ENDTRY
9457:     ENDPROC
9458: 
9459:     PROCEDURE TxtDorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9460:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9461:             THIS.ValidarDorigmerc()
9462:         ENDIF
9463:     ENDPROC
9464: 
9465:     *-- Situacao Tributaria ICMS (sittricms): Valid
9466:     PROCEDURE ValidarSittricm(par_nKeyCode, par_nShiftAltCtrl)
9467:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9468:             RETURN
9469:         ENDIF
9470:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9471:         TRY
9472:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9473:             IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9474:                 RETURN
9475:             ENDIF
9476:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
9477:             IF EMPTY(loc_cCod)
9478:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9479:                     loc_oPg.txt_4c_Dsittricm.Value = ""
9480:                 ENDIF
9481:                 RETURN
9482:             ENDIF
9483:             loc_nRet = SQLEXEC(gnConnHandle, ;
9484:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9485:                 "cursor_4c_IcmBusca")
9486:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9487:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9488:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9489:                 ENDIF
9490:                 IF USED("cursor_4c_IcmBusca")
9491:                     USE IN cursor_4c_IcmBusca
9492:                 ENDIF
9493:             ELSE
9494:                 IF USED("cursor_4c_IcmBusca")
9495:                     USE IN cursor_4c_IcmBusca
9496:                 ENDIF
9497:                 THIS.AbrirBuscaSittricm()
9498:             ENDIF
9499:         CATCH TO loException
9500:             IF USED("cursor_4c_IcmBusca")
9501:                 USE IN cursor_4c_IcmBusca
9502:             ENDIF
9503:             MostrarErro("Erro ao validar Sit. Tribut" + CHR(225) + "ria ICMS:" + ;
9504:                 CHR(13) + loException.Message, "FormProduto.ValidarSittricm")
9505:         ENDTRY
9506:     ENDPROC
9507: 
9508:     PROCEDURE TxtSittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9509:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9510:             THIS.ValidarSittricm()
9511:         ENDIF
9512:     ENDPROC
9513: 
9514:     *-- Situacao Tributaria ICMS descricao: When
9515:     PROCEDURE TxtDsittricmWhen()
9516:         LOCAL loc_oPg
9517:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9518:         IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9519:             RETURN .F.
9520:         ENDIF
9521:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9522:                EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricm.Value))
9523:     ENDPROC
9524: 
9525:     *-- Situacao Tributaria ICMS descricao: Valid
9526:     PROCEDURE ValidarDsittricm(par_nKeyCode, par_nShiftAltCtrl)
9527:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9528:             RETURN
9529:         ENDIF
9530:         LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
9531:         TRY
9532:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9533:             IF !PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9534:                 RETURN
9535:             ENDIF
9536:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value)
9537:             IF EMPTY(loc_cDesc)
9538:                 THIS.AbrirBuscaSittricm()
9539:                 RETURN
9540:             ENDIF
9541:             loc_nRet = SQLEXEC(gnConnHandle, ;
9542:                 "SELECT codigos, descricaos FROM SIGCDICM ORDER BY descricaos", ;
9543:                 "cursor_4c_IcmBusca")
9544:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca")
9545:                 LOCATE FOR LIKE(UPPER(ALLTRIM(loc_cDesc)) + "*", UPPER(ALLTRIM(cursor_4c_IcmBusca.descricaos)))
9546:             ENDIF
9547:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9548:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9549:                     loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_IcmBusca.codigos)
9550:                 ENDIF
9551:                 loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9552:                 IF USED("cursor_4c_IcmBusca")
9553:                     USE IN cursor_4c_IcmBusca
9554:                 ENDIF
9555:             ELSE
9556:                 IF USED("cursor_4c_IcmBusca")
9557:                     USE IN cursor_4c_IcmBusca
9558:                 ENDIF
9559:                 THIS.AbrirBuscaSittricm()
9560:             ENDIF
9561:         CATCH TO loException
9562:             IF USED("cursor_4c_IcmBusca")
9563:                 USE IN cursor_4c_IcmBusca
9564:             ENDIF
9565:             MostrarErro("Erro ao buscar Sit. Tribut" + CHR(225) + "ria ICMS:" + ;
9566:                 CHR(13) + loException.Message, "FormProduto.ValidarDsittricm")
9567:         ENDTRY
9568:     ENDPROC
9569: 
9570:     PROCEDURE TxtDsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9571:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9572:             THIS.ValidarDsittricm()
9573:         ENDIF
9574:     ENDPROC
9575: 
9576:     *-- Codigo Servico Fiscal: Valid (lookup SIGCDICM, copia para Sittricm)
9577:     PROCEDURE ValidarCodServsFiscal(par_nKeyCode, par_nShiftAltCtrl)
9578:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9579:             RETURN
9580:         ENDIF
9581:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9582:         TRY
9583:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9584:             IF !PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
9585:                 RETURN
9586:             ENDIF
9587:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
9588:             IF EMPTY(loc_cCod)
9589:                 RETURN
9590:             ENDIF
9591:             loc_nRet = SQLEXEC(gnConnHandle, ;
9592:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9593:                 "cursor_4c_IcmServBusca")
9594:             IF loc_nRet > 0 AND USED("cursor_4c_IcmServBusca") AND !EOF("cursor_4c_IcmServBusca")
9595:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9596:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_IcmServBusca.codigos)
9597:                 ENDIF
9598:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9599:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmServBusca.descricaos)
9600:                 ENDIF
9601:                 IF USED("cursor_4c_IcmServBusca")
9602:                     USE IN cursor_4c_IcmServBusca
9603:                 ENDIF
9604:             ELSE
9605:                 IF USED("cursor_4c_IcmServBusca")
9606:                     USE IN cursor_4c_IcmServBusca
9607:                 ENDIF
9608:                 THIS.AbrirBuscaCodServsFiscal()
9609:             ENDIF
9610:         CATCH TO loException
9611:             IF USED("cursor_4c_IcmServBusca")
9612:                 USE IN cursor_4c_IcmServBusca
9613:             ENDIF
9614:             MostrarErro("Erro ao validar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal:" + ;
9615:                 CHR(13) + loException.Message, "FormProduto.ValidarCodServsFiscal")
9616:         ENDTRY
9617:     ENDPROC
9618: 
9619:     PROCEDURE TxtCodServsFiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9620:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9621:             THIS.ValidarCodServsFiscal()
9622:         ENDIF
9623:     ENDPROC
9624: 
9625:     *-- Tipo de Tributacao (tptribs): Valid
9626:     PROCEDURE ValidarTpTrib(par_nKeyCode, par_nShiftAltCtrl)
9627:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9628:             RETURN
9629:         ENDIF
9630:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9631:         TRY
9632:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9633:             IF !PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
9634:                 RETURN
9635:             ENDIF
9636:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
9637:             IF EMPTY(loc_cCod)
9638:                 RETURN
9639:             ENDIF
9640:             loc_nRet = SQLEXEC(gnConnHandle, ;
9641:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos = " + EscaparSQL(loc_cCod), ;
9642:                 "cursor_4c_TpTribBusca")
9643:             IF loc_nRet > 0 AND USED("cursor_4c_TpTribBusca") AND !EOF("cursor_4c_TpTribBusca")
9644:                 IF USED("cursor_4c_TpTribBusca")
9645:                     USE IN cursor_4c_TpTribBusca
9646:                 ENDIF
9647:             ELSE
9648:                 IF USED("cursor_4c_TpTribBusca")
9649:                     USE IN cursor_4c_TpTribBusca
9650:                 ENDIF
9651:                 THIS.AbrirBuscaTpTrib()
9652:             ENDIF
9653:         CATCH TO loException
9654:             IF USED("cursor_4c_TpTribBusca")
9655:                 USE IN cursor_4c_TpTribBusca
9656:             ENDIF
9657:             MostrarErro("Erro ao validar Tipo de Tributa" + CHR(231) + CHR(227) + "o:" + ;
9658:                 CHR(13) + loException.Message, "FormProduto.ValidarTpTrib")
9659:         ENDTRY
9660:     ENDPROC
9661: 
9662:     PROCEDURE TxtTpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9663:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9664:             THIS.ValidarTpTrib()
9665:         ENDIF
9666:     ENDPROC
9667: 
9668:     *-- IAT (iats): Valid - aceita 'A','T' ou vazio
9669:     PROCEDURE ValidarIat(par_nKeyCode, par_nShiftAltCtrl)
9670:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9671:             RETURN .T.
9672:         ENDIF
9673:         LOCAL loc_oPg, loc_cVal, loc_lSucesso, loException
9674:         loc_lSucesso = .T.
9675:         TRY
9676:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9677:             IF !PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
9678:                 loc_lSucesso = .T.
9679:             ENDIF
9680:             loc_cVal = ALLTRIM(loc_oPg.txt_4c_Iat.Value)
9681:             IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "A", "T")
9682:                 MsgAviso("IAT deve ser 'A' (Arredondamento) ou 'T' (Truncamento).")
9683:                 loc_oPg.txt_4c_Iat.SetFocus()
9684:                 loc_lSucesso = .F.
9685:             ENDIF
9686:         CATCH TO loException
9687:             MostrarErro("Erro ao validar IAT:" + CHR(13) + loException.Message, ;
9688:                 "FormProduto.ValidarIat")
9689:         ENDTRY
9690:         RETURN loc_lSucesso
9691:     ENDPROC
9692: 
9693:     PROCEDURE TxtIatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9694:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9695:             THIS.ValidarIat()
9696:         ENDIF
9697:     ENDPROC
9698: 
9699:     *-- Combo IPI (ipis): When - edicao somente em INCLUIR/ALTERAR
9700:     PROCEDURE CboIpiWhen()
9701:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9702:     ENDPROC
9703: 
9704:     *-- Aliquota IPI (nAliqipis): Valid - verifica contra padrao da clf fiscal
9705:     PROCEDURE ValidarAliqIPI(par_nKeyCode, par_nShiftAltCtrl)
9706:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9707:             RETURN
9708:         ENDIF
9709:         LOCAL loc_oPg, loc_cClf, loc_nAliq, loc_nAliqRef, loc_nRet, loException
9710:         TRY
9711:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9712:             IF !PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5) OR !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9713:                 RETURN
9714:             ENDIF
9715:             loc_nAliq = loc_oPg.txt_4c_AliqIPI.Value
9716:             loc_cClf  = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9717:             IF EMPTY(loc_cClf) OR loc_nAliq = 0
9718:                 RETURN
9719:             ENDIF
9720:             loc_nRet = SQLEXEC(gnConnHandle, ;
9721:                 "SELECT aipis FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9722:                 "cursor_4c_ClfAliq")
9723:             IF loc_nRet > 0 AND USED("cursor_4c_ClfAliq") AND !EOF("cursor_4c_ClfAliq")
9724:                 loc_nAliqRef = cursor_4c_ClfAliq.aipis
9725:                 IF loc_nAliqRef > 0 AND ABS(loc_nAliq - loc_nAliqRef) > 0.001
9726:                     MsgAviso("Al" + CHR(237) + "quota IPI informada (" + ;
9727:                         TRANSFORM(loc_nAliq) + "%) difere da padr" + CHR(227) + ;
9728:                         "o da classifica" + CHR(231) + CHR(227) + "o fiscal (" + ;
9729:                         TRANSFORM(loc_nAliqRef) + "%).")
9730:                 ENDIF
9731:             ENDIF
9732:             IF USED("cursor_4c_ClfAliq")
9733:                 USE IN cursor_4c_ClfAliq
9734:             ENDIF
9735:         CATCH TO loException
9736:             IF USED("cursor_4c_ClfAliq")
9737:                 USE IN cursor_4c_ClfAliq
9738:             ENDIF
9739:             MostrarErro("Erro ao validar Al" + CHR(237) + "quota IPI:" + ;
9740:                 CHR(13) + loException.Message, "FormProduto.ValidarAliqIPI")
9741:         ENDTRY
9742:     ENDPROC
9743: 
9744:     PROCEDURE TxtAliqIPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9745:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9746:             THIS.ValidarAliqIPI()
9747:         ENDIF
9748:     ENDPROC
9749: 
9750:     *-- Extensao IPI (extipi): When - habilitado quando clf fiscal tem ipiprods='S'
9751:     PROCEDURE TxtExtipipWhen()
9752:         LOCAL loc_oPg, loc_cClf, loc_nRet, loc_lPermite, loException
9753:         loc_lPermite = .F.
9754:         TRY
9755:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9756:                 loc_lResultado = .F.
9757:             ENDIF
9758:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9759:             IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9760:                 loc_lResultado = .F.
9761:             ENDIF
9762:             loc_cClf = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9763:             IF EMPTY(loc_cClf)
9764:                 loc_lResultado = .F.
9765:             ENDIF
9766:             loc_nRet = SQLEXEC(gnConnHandle, ;
9767:                 "SELECT ipiprods FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9768:                 "cursor_4c_ClfIpiProd")
9769:             IF loc_nRet > 0 AND USED("cursor_4c_ClfIpiProd") AND !EOF("cursor_4c_ClfIpiProd")
9770:                 loc_lPermite = (ALLTRIM(cursor_4c_ClfIpiProd.ipiprods) = "S")
9771:             ENDIF
9772:             IF USED("cursor_4c_ClfIpiProd")
9773:                 USE IN cursor_4c_ClfIpiProd
9774:             ENDIF
9775:         CATCH TO loException
9776:             IF USED("cursor_4c_ClfIpiProd")
9777:                 USE IN cursor_4c_ClfIpiProd
9778:             ENDIF
9779:         ENDTRY
9780:         RETURN loc_lPermite
9781:     ENDPROC
9782: 
9783:     *-- Botao Descricao Fiscal: Click - gera descricao fiscal via fGerDescFis
9784:     PROCEDURE CmdBtnDescFisClick()
9785:         LOCAL loc_oPg, loc_cCpros, loc_cDescFis, loc_oPg1, loException
9786:         TRY
9787:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9788:                 RETURN
9789:             ENDIF
9790:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9791:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9792:             IF EMPTY(loc_cCpros)
9793:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9794:                 IF PEMSTATUS(loc_oPg1, "txt_4c_Cpros", 5)
9795:                     loc_cCpros = ALLTRIM(loc_oPg1.txt_4c_Cpros.Value)
9796:                 ENDIF
9797:             ENDIF
9798:             IF EMPTY(loc_cCpros)
9799:                 MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.")
9800:                 RETURN
9801:             ENDIF
9802:             loc_cDescFis = fGerDescFis(0, loc_cCpros, go_4c_Sistema.cCodEmpresa, .F.)
9803:             IF !EMPTY(ALLTRIM(loc_cDescFis))
9804:                 IF PEMSTATUS(loc_oPg, "obj_4c_Mgetdescfi", 5)
9805:                     loc_oPg.obj_4c_Mgetdescfi.Value = loc_cDescFis
9806:                 ENDIF
9807:                 THIS.this_oBusinessObject.this_mDescfis = loc_cDescFis
9808:             ENDIF
9809:         CATCH TO loException
9810:             MostrarErro("Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal:" + ;
9811:                 CHR(13) + loException.Message, "FormProduto.CmdBtnDescFisClick")
9812:         ENDTRY
9813:     ENDPROC
9814: 
9815:     *-- Metal (metals): Valid - lookup SigCdMtl WHERE tipos='M'
9816:     PROCEDURE ValidarMetal(par_nKeyCode, par_nShiftAltCtrl)
9817:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9818:             RETURN
9819:         ENDIF
9820:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9821:         TRY
9822:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9823:             IF !PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
9824:                 RETURN
9825:             ENDIF
9826:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
9827:             IF EMPTY(loc_cCod)
9828:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
9829:                     loc_oPg.txt_4c_DesMetal.Value = ""
9830:                 ENDIF
9831:                 RETURN
9832:             ENDIF
9833:             loc_nRet = SQLEXEC(gnConnHandle, ;
9834:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9835:                 " AND tipos = 'M'", ;
9836:                 "cursor_4c_MetalBusca")
9837:             IF loc_nRet > 0 AND USED("cursor_4c_MetalBusca") AND !EOF("cursor_4c_MetalBusca")
9838:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
9839:                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(cursor_4c_MetalBusca.descs)
9840:                 ENDIF
9841:                 IF USED("cursor_4c_MetalBusca")
9842:                     USE IN cursor_4c_MetalBusca
9843:                 ENDIF
9844:             ELSE
9845:                 IF USED("cursor_4c_MetalBusca")
9846:                     USE IN cursor_4c_MetalBusca
9847:                 ENDIF
9848:                 THIS.AbrirBuscaMetal()
9849:             ENDIF
9850:         CATCH TO loException
9851:             IF USED("cursor_4c_MetalBusca")
9852:                 USE IN cursor_4c_MetalBusca
9853:             ENDIF
9854:             MostrarErro("Erro ao validar Metal:" + CHR(13) + loException.Message, ;
9855:                 "FormProduto.ValidarMetal")
9856:         ENDTRY
9857:     ENDPROC
9858: 
9859:     PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9860:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9861:             THIS.ValidarMetal()
9862:         ENDIF
9863:     ENDPROC
9864: 
9865:     *-- Teor (teors): Valid - lookup SigCdMtl WHERE tipos<>'M'
9866:     PROCEDURE ValidarTeor(par_nKeyCode, par_nShiftAltCtrl)
9867:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9868:             RETURN
9869:         ENDIF
9870:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9871:         TRY
9872:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9873:             IF !PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
9874:                 RETURN
9875:             ENDIF
9876:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
9877:             IF EMPTY(loc_cCod)
9878:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
9879:                     loc_oPg.txt_4c_DesTeor.Value = ""
9880:                 ENDIF
9881:                 RETURN
9882:             ENDIF
9883:             loc_nRet = SQLEXEC(gnConnHandle, ;
9884:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9885:                 " AND tipos <> 'M'", ;
9886:                 "cursor_4c_TeorBusca")
9887:             IF loc_nRet > 0 AND USED("cursor_4c_TeorBusca") AND !EOF("cursor_4c_TeorBusca")
9888:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
9889:                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(cursor_4c_TeorBusca.descs)
9890:                 ENDIF
9891:                 IF USED("cursor_4c_TeorBusca")
9892:                     USE IN cursor_4c_TeorBusca
9893:                 ENDIF
9894:             ELSE
9895:                 IF USED("cursor_4c_TeorBusca")
9896:                     USE IN cursor_4c_TeorBusca
9897:                 ENDIF
9898:                 THIS.AbrirBuscaTeor()
9899:             ENDIF
9900:         CATCH TO loException
9901:             IF USED("cursor_4c_TeorBusca")
9902:                 USE IN cursor_4c_TeorBusca
9903:             ENDIF
9904:             MostrarErro("Erro ao validar Teor:" + CHR(13) + loException.Message, ;
9905:                 "FormProduto.ValidarTeor")
9906:         ENDTRY
9907:     ENDPROC
9908: 
9909:     PROCEDURE TxtTeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9910:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9911:             THIS.ValidarTeor()
9912:         ENDIF
9913:     ENDPROC
9914: 
9915:     *-- Moeda Valor (moedas): Valid - lookup SigCdMoe
9916:     PROCEDURE ValidarMvalorFiscal(par_nKeyCode, par_nShiftAltCtrl)
9917:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9918:             RETURN
9919:         ENDIF
9920:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9921:         TRY
9922:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9923:             IF !PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
9924:                 RETURN
9925:             ENDIF
9926:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
9927:             IF EMPTY(loc_cCod)
9928:                 RETURN
9929:             ENDIF
9930:             loc_nRet = SQLEXEC(gnConnHandle, ;
9931:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCod), ;
9932:                 "cursor_4c_MoeFiscalBusca")
9933:             IF loc_nRet > 0 AND USED("cursor_4c_MoeFiscalBusca") AND !EOF("cursor_4c_MoeFiscalBusca")
9934:                 IF USED("cursor_4c_MoeFiscalBusca")
9935:                     USE IN cursor_4c_MoeFiscalBusca
9936:                 ENDIF
9937:             ELSE
9938:                 IF USED("cursor_4c_MoeFiscalBusca")
9939:                     USE IN cursor_4c_MoeFiscalBusca
9940:                 ENDIF
9941:                 THIS.AbrirBuscaMvalorFiscal()
9942:             ENDIF
9943:         CATCH TO loException
9944:             IF USED("cursor_4c_MoeFiscalBusca")
9945:                 USE IN cursor_4c_MoeFiscalBusca
9946:             ENDIF
9947:             MostrarErro("Erro ao validar Moeda Valor:" + CHR(13) + loException.Message, ;
9948:                 "FormProduto.ValidarMvalorFiscal")
9949:         ENDTRY
9950:     ENDPROC
9951: 
9952:     PROCEDURE TxtMvalorFiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9953:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9954:             THIS.ValidarMvalorFiscal()
9955:         ENDIF
9956:     ENDPROC
9957: 
9958:     *-- Centro de Custo: Grupo (gruccus): Valid
9959:     PROCEDURE TxtGruccusValid()
9960:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9961:             RETURN
9962:         ENDIF
9963:         LOCAL loc_oPg, loc_cGrp, loException
9964:         TRY
9965:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9966:                 RETURN
9967:             ENDIF
9968:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9969:             IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
9970:                 RETURN
9971:             ENDIF
9972:             loc_cGrp = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
9973:             IF EMPTY(loc_cGrp)
9974:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
9975:                     loc_oPg.txt_4c__dgruccus.Value = ""
9976:                 ENDIF
9977:                 RETURN
9978:             ENDIF
9979:             fAcessoContab(Usuar, "C", loc_cGrp)
9980:         CATCH TO loException
9981:             MostrarErro("Erro ao validar Grupo CC:" + CHR(13) + loException.Message, ;
9982:                 "FormProduto.TxtGruccusValid")
9983:         ENDTRY
9984:     ENDPROC
9985: 
9986:     PROCEDURE TxtGruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9987:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9988:             THIS.TxtGruccusValid()
9989:         ENDIF
9990:     ENDPROC
9991: 
9992:     *-- Centro de Custo: Descricao Grupo (dgruccus): When
9993:     PROCEDURE TxtDgruccusWhen()
9994:         LOCAL loc_oPg
9995:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9996:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
9997:             RETURN .F.
9998:         ENDIF
9999:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
10000:                EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
10001:     ENDPROC
10002: 
10003:     *-- Centro de Custo: Descricao Grupo (dgruccus): Valid
10004:     PROCEDURE TxtDgruccusValid()
10005:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10006:             RETURN
10007:         ENDIF
10008:         LOCAL loc_oPg, loc_cDesc, loException
10009:         TRY
10010:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10011:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c__dgruccus.Value)
10012:             fAcessoContab(Usuar, "D", loc_cDesc)
10013:         CATCH TO loException
10014:             MostrarErro("Erro ao buscar Descri" + CHR(231) + CHR(227) + "o Grupo CC:" + ;
10015:                 CHR(13) + loException.Message, "FormProduto.TxtDgruccusValid")
10016:         ENDTRY
10017:     ENDPROC
10018: 
10019:     PROCEDURE TxtDgruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10020:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10021:             THIS.TxtDgruccusValid()
10022:         ENDIF
10023:     ENDPROC
10024: 
10025:     *-- Centro de Custo: Conta (contaccus): When
10026:     PROCEDURE TxtContaccusWhen()
10027:         LOCAL loc_oPg
10028:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10029:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10030:             RETURN .F.
10031:         ENDIF
10032:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
10033:                !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
10034:     ENDPROC
10035: 
10036:     *-- Centro de Custo: Conta (contaccus): Valid
10037:     PROCEDURE TxtContaccusValid()
10038:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10039:             RETURN
10040:         ENDIF
10041:         LOCAL loc_oPg, loc_cGrp, loc_cCta, loException
10042:         TRY
10043:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10044:                 RETURN
10045:             ENDIF
10046:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10047:             loc_cGrp = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10048:             loc_cCta = ALLTRIM(loc_oPg.txt_4c__contaccus.Value)
10049:             IF EMPTY(loc_cCta)
10050:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10051:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10052:                 ENDIF
10053:                 RETURN
10054:             ENDIF
10055:             fAcessoContas(Usuar, loc_cGrp, "C", loc_cCta)
10056:         CATCH TO loException
10057:             MostrarErro("Erro ao validar Conta CC:" + CHR(13) + loException.Message, ;
10058:                 "FormProduto.TxtContaccusValid")
10059:         ENDTRY
10060:     ENDPROC
10061: 
10062:     PROCEDURE TxtContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10063:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10064:             THIS.TxtContaccusValid()
10065:         ENDIF
10066:     ENDPROC
10067: 
10068:     *-- Centro de Custo: Descricao Conta (dcontaccus): When
10069:     PROCEDURE TxtDcontaccusWhen()
10070:         LOCAL loc_oPg
10071:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10072:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10073:             RETURN .F.
10074:         ENDIF
10075:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
10076:                !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value)) AND ;
10077:                EMPTY(ALLTRIM(loc_oPg.txt_4c__contaccus.Value))
10078:     ENDPROC
10079: 
10080:     *-- Centro de Custo: Descricao Conta (dcontaccus): Valid
10081:     PROCEDURE TxtDcontaccusValid()
10082:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10083:             RETURN
10084:         ENDIF
10085:         LOCAL loc_oPg, loc_cGrp, loc_cDesc, loException
10086:         TRY
10087:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10088:             loc_cGrp  = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10089:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c__dcontaccus.Value)
10090:             fAcessoContas(Usuar, loc_cGrp, "D", loc_cDesc)
10091:         CATCH TO loException
10092:             MostrarErro("Erro ao buscar Descri" + CHR(231) + CHR(227) + "o Conta CC:" + ;
10093:                 CHR(13) + loException.Message, "FormProduto.TxtDcontaccusValid")
10094:         ENDTRY
10095:     ENDPROC
10096: 
10097:     PROCEDURE TxtDcontaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10098:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10099:             THIS.TxtDcontaccusValid()
10100:         ENDIF
10101:     ENDPROC
10102: 
10103:     *===========================================================================
10104:     * AbrirBusca* - Helpers de lookup para pgDadosFiscais (Page3)
10105:     *===========================================================================
10106: 
10107:     *-- Classificacao Fiscal (SigCdClf: codigos/descricaos)
10108:     PROCEDURE AbrirBuscaClfiscal()
10109:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10110:         TRY
10111:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10112:             loc_cValAtual = ""
10113:             IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10114:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
10115:             ENDIF
10116:             loc_nRet = SQLEXEC(gnConnHandle, ;
10117:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos LIKE " + ;
10118:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10119:                 "cursor_4c_ClfBusca")
10120:             IF loc_nRet <= 0 OR !USED("cursor_4c_ClfBusca") OR EOF("cursor_4c_ClfBusca")
10121:                 IF USED("cursor_4c_ClfBusca")
10122:                     USE IN cursor_4c_ClfBusca
10123:                 ENDIF
10124:                 SQLEXEC(gnConnHandle, ;
10125:                     "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", ;
10126:                     "cursor_4c_ClfBusca")
10127:             ENDIF
10128:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10129:             IF VARTYPE(loc_oBusca) = "O"
10130:                 loc_oBusca.this_cCursorDestino = "cursor_4c_ClfBusca"
10131:                 loc_oBusca.DefinirCursor("cursor_4c_ClfBusca", "codigos", "descricaos", ;
10132:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10133:                 loc_oBusca.Mostrar()
10134:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10135:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10136:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10137:                     ENDIF
10138:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
10139:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10140:                     ENDIF
10141:                 ENDIF
10142:                 loc_oBusca = .NULL.
10143:             ENDIF
10144:             IF USED("cursor_4c_ClfBusca")
10145:                 USE IN cursor_4c_ClfBusca
10146:             ENDIF
10147:         CATCH TO loException
10148:             IF USED("cursor_4c_ClfBusca")
10149:                 USE IN cursor_4c_ClfBusca
10150:             ENDIF
10151:             MostrarErro("Erro ao buscar Classif. Fiscal:" + CHR(13) + loException.Message, ;
10152:                 "FormProduto.AbrirBuscaClfiscal")
10153:         ENDTRY
10154:     ENDPROC
10155: 
10156:     *-- Origem Mercadoria (SIGCDORG: codigos/descricaos)
10157:     PROCEDURE AbrirBuscaOrigmerc()
10158:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10159:         TRY
10160:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10161:             loc_cValAtual = ""
10162:             IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10163:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
10164:             ENDIF
10165:             loc_nRet = SQLEXEC(gnConnHandle, ;
10166:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos LIKE " + ;
10167:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10168:                 "cursor_4c_OrgBusca")
10169:             IF loc_nRet <= 0 OR !USED("cursor_4c_OrgBusca") OR EOF("cursor_4c_OrgBusca")
10170:                 IF USED("cursor_4c_OrgBusca")
10171:                     USE IN cursor_4c_OrgBusca
10172:                 ENDIF
10173:                 SQLEXEC(gnConnHandle, ;
10174:                     "SELECT codigos, descricaos FROM SIGCDORG ORDER BY codigos", ;
10175:                     "cursor_4c_OrgBusca")
10176:             ENDIF
10177:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10178:             IF VARTYPE(loc_oBusca) = "O"
10179:                 loc_oBusca.this_cCursorDestino = "cursor_4c_OrgBusca"
10180:                 loc_oBusca.DefinirCursor("cursor_4c_OrgBusca", "codigos", "descricaos", ;
10181:                     "Buscar Origem Mercadoria")
10182:                 loc_oBusca.Mostrar()
10183:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10184:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10185:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10186:                     ENDIF
10187:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
10188:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10189:                     ENDIF
10190:                 ENDIF
10191:                 loc_oBusca = .NULL.
10192:             ENDIF
10193:             IF USED("cursor_4c_OrgBusca")
10194:                 USE IN cursor_4c_OrgBusca
10195:             ENDIF
10196:         CATCH TO loException
10197:             IF USED("cursor_4c_OrgBusca")
10198:                 USE IN cursor_4c_OrgBusca
10199:             ENDIF
10200:             MostrarErro("Erro ao buscar Origem Mercadoria:" + CHR(13) + loException.Message, ;
10201:                 "FormProduto.AbrirBuscaOrigmerc")
10202:         ENDTRY
10203:     ENDPROC
10204: 
10205:     *-- Situacao Tributaria ICMS (SIGCDICM: codigos/descricaos)
10206:     PROCEDURE AbrirBuscaSittricm()
10207:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10208:         TRY
10209:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10210:             loc_cValAtual = ""
10211:             IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10212:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
10213:             ENDIF
10214:             loc_nRet = SQLEXEC(gnConnHandle, ;
10215:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10216:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10217:                 "cursor_4c_IcmBusca")
10218:             IF loc_nRet <= 0 OR !USED("cursor_4c_IcmBusca") OR EOF("cursor_4c_IcmBusca")
10219:                 IF USED("cursor_4c_IcmBusca")
10220:                     USE IN cursor_4c_IcmBusca
10221:                 ENDIF
10222:                 SQLEXEC(gnConnHandle, ;
10223:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10224:                     "cursor_4c_IcmBusca")
10225:             ENDIF
10226:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10227:             IF VARTYPE(loc_oBusca) = "O"
10228:                 loc_oBusca.this_cCursorDestino = "cursor_4c_IcmBusca"
10229:                 loc_oBusca.DefinirCursor("cursor_4c_IcmBusca", "codigos", "descricaos", ;
10230:                     "Buscar Sit. Tributaria ICMS")
10231:                 loc_oBusca.Mostrar()
10232:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10233:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10234:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10235:                     ENDIF
10236:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
10237:                         loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10238:                     ENDIF
10239:                 ENDIF
10240:                 loc_oBusca = .NULL.
10241:             ENDIF
10242:             IF USED("cursor_4c_IcmBusca")
10243:                 USE IN cursor_4c_IcmBusca
10244:             ENDIF
10245:         CATCH TO loException
10246:             IF USED("cursor_4c_IcmBusca")
10247:                 USE IN cursor_4c_IcmBusca
10248:             ENDIF
10249:             MostrarErro("Erro ao buscar Sit. Tributaria ICMS:" + CHR(13) + loException.Message, ;
10250:                 "FormProduto.AbrirBuscaSittricm")
10251:         ENDTRY
10252:     ENDPROC
10253: 
10254:     *-- Codigo Servico Fiscal (SIGCDICM: codigos/descricaos)
10255:     PROCEDURE AbrirBuscaCodServsFiscal()
10256:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10257:         TRY
10258:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10259:             loc_cValAtual = ""
10260:             IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10261:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
10262:             ENDIF
10263:             loc_nRet = SQLEXEC(gnConnHandle, ;
10264:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10265:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10266:                 "cursor_4c_CodServBusca")
10267:             IF loc_nRet <= 0 OR !USED("cursor_4c_CodServBusca") OR EOF("cursor_4c_CodServBusca")
10268:                 IF USED("cursor_4c_CodServBusca")
10269:                     USE IN cursor_4c_CodServBusca
10270:                 ENDIF
10271:                 SQLEXEC(gnConnHandle, ;
10272:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10273:                     "cursor_4c_CodServBusca")
10274:             ENDIF
10275:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10276:             IF VARTYPE(loc_oBusca) = "O"
10277:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CodServBusca"
10278:                 loc_oBusca.DefinirCursor("cursor_4c_CodServBusca", "codigos", "descricaos", ;
10279:                     "Buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal")
10280:                 loc_oBusca.Mostrar()
10281:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10282:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10283:                         loc_oPg.txt_4c_Codigo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10284:                     ENDIF
10285:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10286:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10287:                     ENDIF
10288:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
10289:                         loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10290:                     ENDIF
10291:                 ENDIF
10292:                 loc_oBusca = .NULL.
10293:             ENDIF
10294:             IF USED("cursor_4c_CodServBusca")
10295:                 USE IN cursor_4c_CodServBusca
10296:             ENDIF
10297:         CATCH TO loException
10298:             IF USED("cursor_4c_CodServBusca")
10299:                 USE IN cursor_4c_CodServBusca
10300:             ENDIF
10301:             MostrarErro("Erro ao buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal:" + ;
10302:                 CHR(13) + loException.Message, "FormProduto.AbrirBuscaCodServsFiscal")
10303:         ENDTRY
10304:     ENDPROC
10305: 
10306:     *-- Tipo Tributacao (SigPrTri: tipos/descs)
10307:     PROCEDURE AbrirBuscaTpTrib()
10308:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10309:         TRY
10310:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10311:             loc_cValAtual = ""
10312:             IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10313:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
10314:             ENDIF
10315:             loc_nRet = SQLEXEC(gnConnHandle, ;
10316:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos LIKE " + ;
10317:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY tipos", ;
10318:                 "cursor_4c_TpTribBusca")
10319:             IF loc_nRet <= 0 OR !USED("cursor_4c_TpTribBusca") OR EOF("cursor_4c_TpTribBusca")
10320:                 IF USED("cursor_4c_TpTribBusca")
10321:                     USE IN cursor_4c_TpTribBusca
10322:                 ENDIF
10323:                 SQLEXEC(gnConnHandle, ;
10324:                     "SELECT tipos, descs FROM SigPrTri ORDER BY tipos", ;
10325:                     "cursor_4c_TpTribBusca")
10326:             ENDIF
10327:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10328:             IF VARTYPE(loc_oBusca) = "O"
10329:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TpTribBusca"
10330:                 loc_oBusca.DefinirCursor("cursor_4c_TpTribBusca", "tipos", "descs", ;
10331:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10332:                 loc_oBusca.Mostrar()
10333:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10334:                     IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10335:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10336:                     ENDIF
10337:                 ENDIF
10338:                 loc_oBusca = .NULL.
10339:             ENDIF
10340:             IF USED("cursor_4c_TpTribBusca")
10341:                 USE IN cursor_4c_TpTribBusca
10342:             ENDIF
10343:         CATCH TO loException
10344:             IF USED("cursor_4c_TpTribBusca")
10345:                 USE IN cursor_4c_TpTribBusca
10346:             ENDIF
10347:             MostrarErro("Erro ao buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o:" + ;
10348:                 CHR(13) + loException.Message, "FormProduto.AbrirBuscaTpTrib")
10349:         ENDTRY
10350:     ENDPROC
10351: 
10352:     *-- Metal (SigCdMtl: codigos/descs WHERE tipos='M')
10353:     PROCEDURE AbrirBuscaMetal()
10354:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10355:         TRY
10356:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10357:             loc_cValAtual = ""
10358:             IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10359:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
10360:             ENDIF
10361:             loc_nRet = SQLEXEC(gnConnHandle, ;
10362:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10363:                 "WHERE tipos = 'M' AND codigos LIKE " + ;
10364:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10365:                 "cursor_4c_MetalBusca")
10366:             IF loc_nRet <= 0 OR !USED("cursor_4c_MetalBusca") OR EOF("cursor_4c_MetalBusca")
10367:                 IF USED("cursor_4c_MetalBusca")
10368:                     USE IN cursor_4c_MetalBusca
10369:                 ENDIF
10370:                 SQLEXEC(gnConnHandle, ;
10371:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos = 'M' ORDER BY codigos", ;
10372:                     "cursor_4c_MetalBusca")
10373:             ENDIF
10374:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10375:             IF VARTYPE(loc_oBusca) = "O"
10376:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MetalBusca"
10377:                 loc_oBusca.DefinirCursor("cursor_4c_MetalBusca", "codigos", "descs", "Buscar Metal")
10378:                 loc_oBusca.Mostrar()
10379:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10380:                     IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10381:                         loc_oPg.txt_4c_Metal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10382:                     ENDIF
10383:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
10384:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10385:                     ENDIF
10386:                 ENDIF
10387:                 loc_oBusca = .NULL.
10388:             ENDIF
10389:             IF USED("cursor_4c_MetalBusca")
10390:                 USE IN cursor_4c_MetalBusca
10391:             ENDIF
10392:         CATCH TO loException
10393:             IF USED("cursor_4c_MetalBusca")
10394:                 USE IN cursor_4c_MetalBusca
10395:             ENDIF
10396:             MostrarErro("Erro ao buscar Metal:" + CHR(13) + loException.Message, ;
10397:                 "FormProduto.AbrirBuscaMetal")
10398:         ENDTRY
10399:     ENDPROC
10400: 
10401:     *-- Teor (SigCdMtl: codigos/descs WHERE tipos<>'M')
10402:     PROCEDURE AbrirBuscaTeor()
10403:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10404:         TRY
10405:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10406:             loc_cValAtual = ""
10407:             IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10408:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
10409:             ENDIF
10410:             loc_nRet = SQLEXEC(gnConnHandle, ;
10411:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10412:                 "WHERE tipos <> 'M' AND codigos LIKE " + ;
10413:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10414:                 "cursor_4c_TeorBusca")
10415:             IF loc_nRet <= 0 OR !USED("cursor_4c_TeorBusca") OR EOF("cursor_4c_TeorBusca")
10416:                 IF USED("cursor_4c_TeorBusca")
10417:                     USE IN cursor_4c_TeorBusca
10418:                 ENDIF
10419:                 SQLEXEC(gnConnHandle, ;
10420:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos <> 'M' ORDER BY codigos", ;
10421:                     "cursor_4c_TeorBusca")
10422:             ENDIF
10423:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10424:             IF VARTYPE(loc_oBusca) = "O"
10425:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TeorBusca"
10426:                 loc_oBusca.DefinirCursor("cursor_4c_TeorBusca", "codigos", "descs", "Buscar Teor")
10427:                 loc_oBusca.Mostrar()
10428:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10429:                     IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10430:                         loc_oPg.txt_4c_Teor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10431:                     ENDIF
10432:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
10433:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10434:                     ENDIF
10435:                 ENDIF
10436:                 loc_oBusca = .NULL.
10437:             ENDIF
10438:             IF USED("cursor_4c_TeorBusca")
10439:                 USE IN cursor_4c_TeorBusca
10440:             ENDIF
10441:         CATCH TO loException
10442:             IF USED("cursor_4c_TeorBusca")
10443:                 USE IN cursor_4c_TeorBusca
10444:             ENDIF
10445:             MostrarErro("Erro ao buscar Teor:" + CHR(13) + loException.Message, ;
10446:                 "FormProduto.AbrirBuscaTeor")
10447:         ENDTRY
10448:     ENDPROC
10449: 
10450:     *-- Moeda Valor (SigCdMoe: cmoeds/dmoeds)
10451:     PROCEDURE AbrirBuscaMvalorFiscal()
10452:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10453:         TRY
10454:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10455:             loc_cValAtual = ""
10456:             IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10457:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
10458:             ENDIF
10459:             loc_nRet = SQLEXEC(gnConnHandle, ;
10460:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes LIKE " + ;
10461:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY cmoes", ;
10462:                 "cursor_4c_MoeFiscalBusca")
10463:             IF loc_nRet <= 0 OR !USED("cursor_4c_MoeFiscalBusca") OR EOF("cursor_4c_MoeFiscalBusca")
10464:                 IF USED("cursor_4c_MoeFiscalBusca")
10465:                     USE IN cursor_4c_MoeFiscalBusca
10466:                 ENDIF
10467:                 SQLEXEC(gnConnHandle, ;
10468:                     "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes", ;
10469:                     "cursor_4c_MoeFiscalBusca")
10470:             ENDIF
10471:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10472:             IF VARTYPE(loc_oBusca) = "O"
10473:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MoeFiscalBusca"
10474:                 loc_oBusca.DefinirCursor("cursor_4c_MoeFiscalBusca", "cmoes", "dmoes", ;
10475:                     "Buscar Moeda")
10476:                 loc_oBusca.Mostrar()
10477:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10478:                     IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10479:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10480:                     ENDIF
10481:                 ENDIF
10482:                 loc_oBusca = .NULL.
10483:             ENDIF
10484:             IF USED("cursor_4c_MoeFiscalBusca")
10485:                 USE IN cursor_4c_MoeFiscalBusca
10486:             ENDIF
10487:         CATCH TO loException
10488:             IF USED("cursor_4c_MoeFiscalBusca")
10489:                 USE IN cursor_4c_MoeFiscalBusca
10490:             ENDIF
10491:             MostrarErro("Erro ao buscar Moeda:" + CHR(13) + loException.Message, ;
10492:                 "FormProduto.AbrirBuscaMvalorFiscal")
10493:         ENDTRY
10494:     ENDPROC
10495: 
10496:     *===========================================================================
10497:     * ConfigurarPgpgDesigner - Configura Page7 "Designer" do pgf_4c_Dados
10498:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner
10499:     *===========================================================================
10500:     PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPg)
10501:         LOCAL loc_oPg, loc_oGrid, loc_oErro
10502:         TRY
10503:             loc_oPg = par_oPg
10504: 
10505:             *-- Cursors placeholder (preenchidos pelo BO ao carregar produto)
10506:             IF !USED("cursor_4c_GrdDesigner")
10507:                 SET NULL ON
10508:                 CREATE CURSOR cursor_4c_GrdDesigner ( ;
10509:                     dtini D, dtfim D, usuarios C(10), codcads C(10))
10510:                 SET NULL OFF
10511:             ENDIF
10512:             IF !USED("cursor_4c_GrdArquivos")
10513:                 SET NULL ON
10514:                 CREATE CURSOR cursor_4c_GrdArquivos (arqnome C(200))
10515:                 SET NULL OFF
10516:             ENDIF
10517:             IF !USED("crTarefas")
10518:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10519:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
10520:                     SQLEXEC(gnConnHandle, ;
10521:                         "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10522:                         "FROM SigCdCad ORDER BY codcads", ;
10523:                         "crTarefas")
10524:                 ENDIF
10525:             ENDIF
10526: 
10527:             *-- grdDesigner: grade historico de designer (4 colunas)
10528:             *-- Original: top=145, left=10, width=495, height=180
10529:             loc_oPg.AddObject("grd_4c_GrdDesigner", "Grid")
10530:             WITH loc_oPg.grd_4c_GrdDesigner
10531:                 .Top        = 145
10532:                 .Left       = 10
10533:                 .Width      = 495
10534:                 .Height     = 180
10535:                 .FontName   = "Tahoma"
10536:                 .FontSize   = 8
10537:                 .RecordMark = .F.
10538:                 .RowHeight  = 16
10539:                 .ScrollBars = 2
10540:                 .TabStop    = .F.

*-- Linhas 10571 a 10614:
10571:             loc_oGrid.Column4.Movable         = .F.
10572:             loc_oGrid.Column4.Resizable       = .F.
10573:             loc_oGrid.Column4.Header1.Caption = "Tarefa"
10574:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdDesignerCol4TarefaValid")
10575: 
10576:             *-- Say31: label "Observacao da Tarefa"
10577:             *-- Original: top=129, left=583, width=126, height=15
10578:             loc_oPg.AddObject("lbl_4c_Label31", "Label")
10579:             WITH loc_oPg.lbl_4c_Label31
10580:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
10581:                 .Top       = 129
10582:                 .Left      = 583
10583:                 .Width     = 126
10584:                 .Height    = 15
10585:                 .FontName  = "Tahoma"
10586:                 .FontSize  = 8
10587:                 .BackStyle = 0
10588:                 .ForeColor = RGB(90, 90, 90)
10589:                 .Visible   = .T.
10590:             ENDWITH
10591: 
10592:             *-- getObsTarefas: editbox (fwmemo) observacao da tarefa
10593:             *-- Original: top=145, left=584, width=407, height=113
10594:             loc_oPg.AddObject("obj_4c_GetObsTarefas", "EditBox")
10595:             WITH loc_oPg.obj_4c_GetObsTarefas
10596:                 .Top        = 145
10597:                 .Left       = 584
10598:                 .Width      = 407
10599:                 .Height     = 113
10600:                 .FontName   = "Tahoma"
10601:                 .FontSize   = 8
10602:                 .ScrollBars = 2
10603:                 .ReadOnly   = .F.
10604:                 .Visible    = .T.
10605:             ENDWITH
10606: 
10607:             *-- btnIniTarefa: botao Inicio de Tarefa
10608:             *-- Original: top=146, left=509, width=42, height=42
10609:             loc_oPg.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
10610:             WITH loc_oPg.cmd_4c_BtnIniTarefa
10611:                 .Caption       = "IN"
10612:                 .Top           = 146
10613:                 .Left          = 509
10614:                 .Width         = 42

*-- Linhas 10622 a 10685:
10622:                 .MousePointer  = 15
10623:                 .Visible       = .T.
10624:             ENDWITH
10625:             BINDEVENT(loc_oPg.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
10626: 
10627:             *-- btnFimTarefa: botao Fim de Tarefa
10628:             *-- Original: top=188, left=509, width=42, height=42
10629:             loc_oPg.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
10630:             WITH loc_oPg.cmd_4c_BtnFimTarefa
10631:                 .Caption       = "FI"
10632:                 .Top           = 188
10633:                 .Left          = 509
10634:                 .Width         = 42
10635:                 .Height        = 42
10636:                 .FontName      = "Tahoma"
10637:                 .FontSize      = 8
10638:                 .FontBold      = .T.
10639:                 .BackColor     = RGB(255, 255, 255)
10640:                 .Themes        = .F.
10641:                 .SpecialEffect = 0
10642:                 .MousePointer  = 15
10643:                 .Visible       = .T.
10644:             ENDWITH
10645:             BINDEVENT(loc_oPg.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
10646: 
10647:             *-- Say1: label "Inspiracao"
10648:             *-- Original: top=265, left=583, width=62, height=15
10649:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
10650:             WITH loc_oPg.lbl_4c_Label1
10651:                 .Caption   = "Inspira" + CHR(231) + CHR(227) + "o"
10652:                 .Top       = 265
10653:                 .Left      = 583
10654:                 .Width     = 62
10655:                 .Height    = 15
10656:                 .FontName  = "Tahoma"
10657:                 .FontSize  = 8
10658:                 .BackStyle = 0
10659:                 .ForeColor = RGB(90, 90, 90)
10660:                 .Visible   = .T.
10661:             ENDWITH
10662: 
10663:             *-- getObsInsp: editbox (fwmemo) observacao de inspiracao
10664:             *-- Original: top=281, left=584, width=407, height=113
10665:             loc_oPg.AddObject("obj_4c_GetObsInsp", "EditBox")
10666:             WITH loc_oPg.obj_4c_GetObsInsp
10667:                 .Top        = 281
10668:                 .Left       = 584
10669:                 .Width      = 407
10670:                 .Height     = 113
10671:                 .FontName   = "Tahoma"
10672:                 .FontSize   = 8
10673:                 .ScrollBars = 2
10674:                 .ReadOnly   = .F.
10675:                 .Visible    = .T.
10676:             ENDWITH
10677: 
10678:             *-- grdArquivos: grade de arquivos do designer (1 coluna)
10679:             *-- Original: top=334, left=10, width=495, height=164
10680:             loc_oPg.AddObject("grd_4c_GrdArquivos", "Grid")
10681:             WITH loc_oPg.grd_4c_GrdArquivos
10682:                 .Top        = 334
10683:                 .Left       = 10
10684:                 .Width      = 495
10685:                 .Height     = 164

*-- Linhas 10718 a 10801:
10718:                 .MousePointer  = 15
10719:                 .Visible       = .T.
10720:             ENDWITH
10721:             BINDEVENT(loc_oPg.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
10722: 
10723:             *-- btnExcArqs: botao Excluir Arquivo selecionado
10724:             *-- Original: top=377, left=509, width=42, height=42
10725:             loc_oPg.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
10726:             WITH loc_oPg.cmd_4c_BtnExcArqs
10727:                 .Caption       = "-"
10728:                 .Top           = 377
10729:                 .Left          = 509
10730:                 .Width         = 42
10731:                 .Height        = 42
10732:                 .FontName      = "Tahoma"
10733:                 .FontSize      = 12
10734:                 .FontBold      = .T.
10735:                 .BackColor     = RGB(255, 255, 255)
10736:                 .Themes        = .F.
10737:                 .SpecialEffect = 0
10738:                 .MousePointer  = 15
10739:                 .Visible       = .T.
10740:             ENDWITH
10741:             BINDEVENT(loc_oPg.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
10742: 
10743:             *-- btnOpnArqs: botao Abrir Arquivo selecionado
10744:             *-- Original: top=419, left=509, width=42, height=42
10745:             loc_oPg.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
10746:             WITH loc_oPg.cmd_4c_BtnOpnArqs
10747:                 .Caption       = "AB"
10748:                 .Top           = 419
10749:                 .Left          = 509
10750:                 .Width         = 42
10751:                 .Height        = 42
10752:                 .FontName      = "Tahoma"
10753:                 .FontSize      = 8
10754:                 .FontBold      = .T.
10755:                 .BackColor     = RGB(255, 255, 255)
10756:                 .Themes        = .F.
10757:                 .SpecialEffect = 0
10758:                 .MousePointer  = 15
10759:                 .Visible       = .T.
10760:             ENDWITH
10761:             BINDEVENT(loc_oPg.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
10762: 
10763:             *-- Shape1: retangulo decorativo sobre area de imagem
10764:             *-- Original: top=400, left=584, width=407, height=202
10765:             loc_oPg.AddObject("shp_4c_Shape1", "Shape")
10766:             WITH loc_oPg.shp_4c_Shape1
10767:                 .Top     = 400
10768:                 .Left    = 584
10769:                 .Width   = 407
10770:                 .Height  = 202
10771:                 .Visible = .T.
10772:             ENDWITH
10773: 
10774:             *-- imgArqJpg: imagem do arquivo selecionado (inicialmente oculta)
10775:             *-- Original: top=402, left=586, width=403, height=198, visible=false
10776:             loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
10777:             WITH loc_oPg.img_4c_ImgArqJpg
10778:                 .Top     = 402
10779:                 .Left    = 586
10780:                 .Width   = 403
10781:                 .Height  = 198
10782:                 .Visible = .F.
10783:             ENDWITH
10784: 
10785:             *-- Say19: label secao "Dados do Lancamento"
10786:             *-- Original: top=504, left=18, width=127, height=15
10787:             loc_oPg.AddObject("lbl_4c_Label19", "Label")
10788:             WITH loc_oPg.lbl_4c_Label19
10789:                 .Caption   = "Dados do Lan" + CHR(231) + "amento"
10790:                 .Top       = 504
10791:                 .Left      = 18
10792:                 .Width     = 127
10793:                 .Height    = 15
10794:                 .FontName  = "Tahoma"
10795:                 .FontSize  = 8
10796:                 .FontBold  = .T.
10797:                 .BackStyle = 0
10798:                 .ForeColor = RGB(90, 90, 90)
10799:                 .Visible   = .T.
10800:             ENDWITH
10801: 

*-- Linhas 10873 a 11475:
10873:                 .SpecialEffect = 1
10874:                 .Visible       = .T.
10875:             ENDWITH
10876:             BINDEVENT(loc_oPg.txt_4c_DesLacto, "KeyPress", THIS, "ValidarDesLacto")
10877: 
10878:             *-- Say5: label "Criado por :"
10879:             *-- Original: top=580, left=56, width=59, height=15
10880:             loc_oPg.AddObject("lbl_4c_Label5", "Label")
10881:             WITH loc_oPg.lbl_4c_Label5
10882:                 .Caption   = "Criado por :"
10883:                 .Top       = 580
10884:                 .Left      = 56
10885:                 .Width     = 59
10886:                 .Height    = 15
10887:                 .FontName  = "Tahoma"
10888:                 .FontSize  = 8
10889:                 .BackStyle = 0
10890:                 .ForeColor = RGB(90, 90, 90)
10891:                 .Visible   = .T.
10892:             ENDWITH
10893: 
10894:             *-- GetCriaLacto: textbox usuario criador (fwget -> SigCdUsu.usuarios)
10895:             *-- Original: top=576, left=118, width=91, height=22
10896:             loc_oPg.AddObject("txt_4c_CriaLacto", "TextBox")
10897:             WITH loc_oPg.txt_4c_CriaLacto
10898:                 .Top           = 576
10899:                 .Left          = 118
10900:                 .Width         = 91
10901:                 .Height        = 22
10902:                 .FontName      = "Tahoma"
10903:                 .FontSize      = 8
10904:                 .Value         = ""
10905:                 .MaxLength     = 10
10906:                 .SpecialEffect = 1
10907:                 .Visible       = .T.
10908:             ENDWITH
10909:             BINDEVENT(loc_oPg.txt_4c_CriaLacto, "KeyPress", THIS, "ValidarCriaLacto")
10910: 
10911:         CATCH TO loc_oErro
10912:             MostrarErro("Erro ao configurar pgDesigner:" + CHR(13) + ;
10913:                 loc_oErro.Message + CHR(13) + ;
10914:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
10915:                 "FormProduto.ConfigurarPgpgDesigner")
10916:         ENDTRY
10917:     ENDPROC
10918: 
10919:     *===========================================================================
10920:     * Handlers de BINDEVENT para pgDesigner (Page7)
10921:     * Todos PUBLIC - requerido pelo BINDEVENT
10922:     *===========================================================================
10923: 
10924:     *-- grdDesigner Column4 (Tarefa/CodCads): Valid - lookup crTarefas por CodCads
10925:     PROCEDURE GrdDesignerCol4TarefaValid()
10926:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10927:             RETURN .T.
10928:         ENDIF
10929:         LOCAL loc_cCodCads, loc_lSucesso, loException
10930:         loc_lSucesso = .T.
10931:         TRY
10932:             IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
10933:                 loc_cCodCads = ALLTRIM(cursor_4c_GrdDesigner.codcads)
10934:                 IF !EMPTY(loc_cCodCads)
10935:                     IF USED("crTarefas")
10936:                         SELECT crTarefas
10937:                         GO TOP
10938:                         LOCATE FOR ALLTRIM(CodCads) = loc_cCodCads
10939:                         IF EOF("crTarefas")
10940:                             THIS.AbrirBuscaTarefaDesigner()
10941:                         ENDIF
10942:                         IF USED("cursor_4c_GrdDesigner")
10943:                             SELECT cursor_4c_GrdDesigner
10944:                         ENDIF
10945:                     ELSE
10946:                         THIS.AbrirBuscaTarefaDesigner()
10947:                     ENDIF
10948:                 ENDIF
10949:             ENDIF
10950:         CATCH TO loException
10951:             MostrarErro("Erro ao validar Tarefa:" + CHR(13) + loException.Message, ;
10952:                 "FormProduto.GrdDesignerCol4TarefaValid")
10953:         ENDTRY
10954:         RETURN loc_lSucesso
10955:     ENDPROC
10956: 
10957:     PROCEDURE AbrirBuscaTarefaDesigner()
10958:         LOCAL loc_oBusca, loc_nRet, loException
10959:         TRY
10960:             IF !USED("crTarefas")
10961:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10962:                 loc_nRet = SQLEXEC(gnConnHandle, ;
10963:                     "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10964:                     "FROM SigCdCad ORDER BY codcads", ;
10965:                     "crTarefas")
10966:                 IF loc_nRet <= 0 OR EOF("crTarefas")
10967:                     MsgAviso("Sem tarefas cadastradas para selecionar.")
10968:                     RETURN
10969:                 ENDIF
10970:             ENDIF
10971:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10972:             IF VARTYPE(loc_oBusca) = "O"
10973:                 loc_oBusca.this_cCursorDestino = "crTarefas"
10974:                 loc_oBusca.DefinirCursor("crTarefas", "CodCads", "DesCads", ;
10975:                     "Selecionar Tarefa")
10976:                 loc_oBusca.Mostrar()
10977:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND ;
10978:                     USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
10979:                     SELECT cursor_4c_GrdDesigner
10980:                     REPLACE cursor_4c_GrdDesigner.codcads WITH ;
10981:                         ALLTRIM(loc_oBusca.cCodigoSelecionado)
10982:                 ENDIF
10983:                 loc_oBusca = .NULL.
10984:             ENDIF
10985:         CATCH TO loException
10986:             MostrarErro("Erro ao buscar Tarefa:" + CHR(13) + loException.Message, ;
10987:                 "FormProduto.AbrirBuscaTarefaDesigner")
10988:         ENDTRY
10989:     ENDPROC
10990: 
10991:     *-- GetDesLacto (txt_4c_DesLacto): Valid - valida usuario desenvolvedor em SigCdUsu
10992:     PROCEDURE ValidarDesLacto(par_nKeyCode, par_nShiftAltCtrl)
10993:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10994:             RETURN
10995:         ENDIF
10996:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
10997:         TRY
10998:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
10999:             loc_cCod = ""
11000:             IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11001:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
11002:             ENDIF
11003:             IF !EMPTY(loc_cCod)
11004:                 loc_nRet = SQLEXEC(gnConnHandle, ;
11005:                     "SELECT usuarios FROM SigCdUsu " + ;
11006:                     "WHERE usuarios = " + EscaparSQL(loc_cCod), ;
11007:                     "cursor_4c_DesLactoBusca")
11008:                 IF loc_nRet > 0 AND USED("cursor_4c_DesLactoBusca") AND !EOF("cursor_4c_DesLactoBusca")
11009:                     IF USED("cursor_4c_DesLactoBusca")
11010:                         USE IN cursor_4c_DesLactoBusca
11011:                     ENDIF
11012:                 ELSE
11013:                     IF USED("cursor_4c_DesLactoBusca")
11014:                         USE IN cursor_4c_DesLactoBusca
11015:                     ENDIF
11016:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11017:                         loc_oPg.txt_4c_DesLacto.Value = ""
11018:                     ENDIF
11019:                     THIS.AbrirBuscaDesLacto()
11020:                 ENDIF
11021:             ENDIF
11022:         CATCH TO loException
11023:             IF USED("cursor_4c_DesLactoBusca")
11024:                 USE IN cursor_4c_DesLactoBusca
11025:             ENDIF
11026:             MostrarErro("Erro ao validar Desenvolvedor:" + CHR(13) + loException.Message, ;
11027:                 "FormProduto.ValidarDesLacto")
11028:         ENDTRY
11029:     ENDPROC
11030: 
11031:     PROCEDURE AbrirBuscaDesLacto()
11032:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
11033:         TRY
11034:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11035:             loc_cValAtual = ""
11036:             IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11037:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
11038:             ENDIF
11039:             loc_nRet = SQLEXEC(gnConnHandle, ;
11040:                 "SELECT usuarios, ncomps FROM SigCdUsu ORDER BY usuarios", ;
11041:                 "cursor_4c_DesLactoBusca")
11042:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11043:             IF VARTYPE(loc_oBusca) = "O"
11044:                 loc_oBusca.this_cCursorDestino = "cursor_4c_DesLactoBusca"
11045:                 loc_oBusca.DefinirCursor("cursor_4c_DesLactoBusca", "usuarios", "ncomps", ;
11046:                     "Selecionar Desenvolvedor")
11047:                 loc_oBusca.Mostrar()
11048:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11049:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11050:                         loc_oPg.txt_4c_DesLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11051:                     ENDIF
11052:                 ENDIF
11053:                 loc_oBusca = .NULL.
11054:             ENDIF
11055:             IF USED("cursor_4c_DesLactoBusca")
11056:                 USE IN cursor_4c_DesLactoBusca
11057:             ENDIF
11058:         CATCH TO loException
11059:             IF USED("cursor_4c_DesLactoBusca")
11060:                 USE IN cursor_4c_DesLactoBusca
11061:             ENDIF
11062:             MostrarErro("Erro ao buscar Desenvolvedor:" + CHR(13) + loException.Message, ;
11063:                 "FormProduto.AbrirBuscaDesLacto")
11064:         ENDTRY
11065:     ENDPROC
11066: 
11067:     *-- GetCriaLacto (txt_4c_CriaLacto): Valid - valida usuario criador em SigCdUsu
11068:     PROCEDURE ValidarCriaLacto(par_nKeyCode, par_nShiftAltCtrl)
11069:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11070:             RETURN
11071:         ENDIF
11072:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
11073:         TRY
11074:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11075:             loc_cCod = ""
11076:             IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11077:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11078:             ENDIF
11079:             IF !EMPTY(loc_cCod)
11080:                 loc_nRet = SQLEXEC(gnConnHandle, ;
11081:                     "SELECT usuarios FROM SigCdUsu " + ;
11082:                     "WHERE usuarios = " + EscaparSQL(loc_cCod), ;
11083:                     "cursor_4c_CriaLactoBusca")
11084:                 IF loc_nRet > 0 AND USED("cursor_4c_CriaLactoBusca") AND !EOF("cursor_4c_CriaLactoBusca")
11085:                     IF USED("cursor_4c_CriaLactoBusca")
11086:                         USE IN cursor_4c_CriaLactoBusca
11087:                     ENDIF
11088:                 ELSE
11089:                     IF USED("cursor_4c_CriaLactoBusca")
11090:                         USE IN cursor_4c_CriaLactoBusca
11091:                     ENDIF
11092:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11093:                         loc_oPg.txt_4c_CriaLacto.Value = ""
11094:                     ENDIF
11095:                     THIS.AbrirBuscaCriaLacto()
11096:                 ENDIF
11097:             ENDIF
11098:         CATCH TO loException
11099:             IF USED("cursor_4c_CriaLactoBusca")
11100:                 USE IN cursor_4c_CriaLactoBusca
11101:             ENDIF
11102:             MostrarErro("Erro ao validar Criador:" + CHR(13) + loException.Message, ;
11103:                 "FormProduto.ValidarCriaLacto")
11104:         ENDTRY
11105:     ENDPROC
11106: 
11107:     PROCEDURE AbrirBuscaCriaLacto()
11108:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
11109:         TRY
11110:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11111:             loc_cValAtual = ""
11112:             IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11113:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11114:             ENDIF
11115:             loc_nRet = SQLEXEC(gnConnHandle, ;
11116:                 "SELECT usuarios, ncomps FROM SigCdUsu ORDER BY usuarios", ;
11117:                 "cursor_4c_CriaLactoBusca")
11118:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11119:             IF VARTYPE(loc_oBusca) = "O"
11120:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CriaLactoBusca"
11121:                 loc_oBusca.DefinirCursor("cursor_4c_CriaLactoBusca", "usuarios", "ncomps", ;
11122:                     "Selecionar Criador")
11123:                 loc_oBusca.Mostrar()
11124:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11125:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11126:                         loc_oPg.txt_4c_CriaLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11127:                     ENDIF
11128:                 ENDIF
11129:                 loc_oBusca = .NULL.
11130:             ENDIF
11131:             IF USED("cursor_4c_CriaLactoBusca")
11132:                 USE IN cursor_4c_CriaLactoBusca
11133:             ENDIF
11134:         CATCH TO loException
11135:             IF USED("cursor_4c_CriaLactoBusca")
11136:                 USE IN cursor_4c_CriaLactoBusca
11137:             ENDIF
11138:             MostrarErro("Erro ao buscar Criador:" + CHR(13) + loException.Message, ;
11139:                 "FormProduto.AbrirBuscaCriaLacto")
11140:         ENDTRY
11141:     ENDPROC
11142: 
11143:     *-- btnIniTarefa: registra inicio de tarefa na linha corrente do grdDesigner
11144:     PROCEDURE BtnIniTarefaClick()
11145:         LOCAL loc_oPg, loException
11146:         TRY
11147:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11148:                 MsgAviso("Habilite Incluir ou Alterar para registrar tarefa.")
11149:             ELSE
11150:                 IF USED("cursor_4c_GrdDesigner")
11151:                     SELECT cursor_4c_GrdDesigner
11152:                     APPEND BLANK
11153:                     REPLACE cursor_4c_GrdDesigner.dtini    WITH DATE()
11154:                     REPLACE cursor_4c_GrdDesigner.usuarios WITH ALLTRIM(gc_4c_UsuarioLogado)
11155:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11156:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11157:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11158:                     ENDIF
11159:                 ENDIF
11160:             ENDIF
11161:         CATCH TO loException
11162:             MostrarErro("Erro ao registrar inicio de tarefa:" + CHR(13) + loException.Message, ;
11163:                 "FormProduto.BtnIniTarefaClick")
11164:         ENDTRY
11165:     ENDPROC
11166: 
11167:     *-- btnFimTarefa: registra data conclusao na linha corrente do grdDesigner
11168:     PROCEDURE BtnFimTarefaClick()
11169:         LOCAL loc_oPg, loException
11170:         TRY
11171:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11172:                 MsgAviso("Habilite Incluir ou Alterar para registrar conclus" + CHR(227) + "o.")
11173:             ELSE
11174:                 IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
11175:                     SELECT cursor_4c_GrdDesigner
11176:                     REPLACE cursor_4c_GrdDesigner.dtfim WITH DATE()
11177:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11178:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11179:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11180:                     ENDIF
11181:                 ELSE
11182:                     MsgAviso("Selecione um registro de tarefa para registrar conclus" + CHR(227) + "o.")
11183:                 ENDIF
11184:             ENDIF
11185:         CATCH TO loException
11186:             MostrarErro("Erro ao registrar fim de tarefa:" + CHR(13) + loException.Message, ;
11187:                 "FormProduto.BtnFimTarefaClick")
11188:         ENDTRY
11189:     ENDPROC
11190: 
11191:     *-- btnInsArqs: insere arquivo via dialogo na lista grdArquivos
11192:     PROCEDURE BtnInsArqsClick()
11193:         LOCAL loc_oPg, loc_cArquivo, loException
11194:         TRY
11195:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11196:                 MsgAviso("Habilite Incluir ou Alterar para inserir arquivo.")
11197:             ELSE
11198:                 loc_cArquivo = GETFILE("*", "Selecionar Arquivo")
11199:                 IF !EMPTY(loc_cArquivo) AND USED("cursor_4c_GrdArquivos")
11200:                     SELECT cursor_4c_GrdArquivos
11201:                     APPEND BLANK
11202:                     REPLACE cursor_4c_GrdArquivos.arqnome WITH ALLTRIM(loc_cArquivo)
11203:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11204:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11205:                         loc_oPg.grd_4c_GrdArquivos.Refresh()
11206:                     ENDIF
11207:                 ENDIF
11208:             ENDIF
11209:         CATCH TO loException
11210:             MostrarErro("Erro ao inserir arquivo:" + CHR(13) + loException.Message, ;
11211:                 "FormProduto.BtnInsArqsClick")
11212:         ENDTRY
11213:     ENDPROC
11214: 
11215:     *-- btnExcArqs: exclui arquivo selecionado da lista grdArquivos
11216:     PROCEDURE BtnExcArqsClick()
11217:         LOCAL loc_oPg, loc_lConfirm, loException
11218:         TRY
11219:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11220:                 MsgAviso("Habilite Incluir ou Alterar para excluir arquivo.")
11221:             ELSE
11222:                 IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
11223:                     loc_lConfirm = MsgConfirma("Confirma exclus" + CHR(227) + "o do arquivo selecionado?")
11224:                     IF loc_lConfirm
11225:                         SELECT cursor_4c_GrdArquivos
11226:                         DELETE
11227:                         PACK
11228:                         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11229:                         IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11230:                             loc_oPg.grd_4c_GrdArquivos.Refresh()
11231:                         ENDIF
11232:                     ENDIF
11233:                 ELSE
11234:                     MsgAviso("Selecione um arquivo para excluir.")
11235:                 ENDIF
11236:             ENDIF
11237:         CATCH TO loException
11238:             MostrarErro("Erro ao excluir arquivo:" + CHR(13) + loException.Message, ;
11239:                 "FormProduto.BtnExcArqsClick")
11240:         ENDTRY
11241:     ENDPROC
11242: 
11243:     *-- btnOpnArqs: abre arquivo selecionado com aplicativo associado do SO
11244:     PROCEDURE BtnOpnArqsClick()
11245:         LOCAL loc_cArquivo, loc_oPg, loException
11246:         TRY
11247:             IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
11248:                 loc_cArquivo = ALLTRIM(cursor_4c_GrdArquivos.arqnome)
11249:                 IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
11250:                     DECLARE INTEGER ShellExecute IN Shell32 ;
11251:                         INTEGER hwnd, STRING lpOp, STRING lpFile, ;
11252:                         STRING lpParams, STRING lpDir, INTEGER nShow
11253:                     ShellExecute(0, "open", loc_cArquivo, "", "", 1)
11254:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11255:                     IF PEMSTATUS(loc_oPg, "img_4c_ImgArqJpg", 5)
11256:                         IF INLIST(UPPER(RIGHT(ALLTRIM(loc_cArquivo), 4)), ".JPG", ".PNG") OR ;
11257:                             UPPER(RIGHT(ALLTRIM(loc_cArquivo), 5)) = ".JPEG"
11258:                             loc_oPg.img_4c_ImgArqJpg.Picture = loc_cArquivo
11259:                             loc_oPg.img_4c_ImgArqJpg.Visible = .T.
11260:                         ELSE
11261:                             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
11262:                         ENDIF
11263:                     ENDIF
11264:                 ELSE
11265:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArquivo)
11266:                 ENDIF
11267:             ELSE
11268:                 MsgAviso("Selecione um arquivo para abrir.")
11269:             ENDIF
11270:         CATCH TO loException
11271:             MostrarErro("Erro ao abrir arquivo:" + CHR(13) + loException.Message, ;
11272:                 "FormProduto.BtnOpnArqsClick")
11273:         ENDTRY
11274:     ENDPROC
11275: 
11276:     *===========================================================================
11277:     * ConfigurarPgpgServico - Configura Page8 "Servicos" do pgf_4c_Dados
11278:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgServico
11279:     * grdServico: top=171, left=339, width=320, height=387, 3 colunas
11280:     *   Column1 (ColumnOrder=2): Descs - editavel em INCLUIR/ALTERAR E Marcas=1
11281:     *   Column2 (ColumnOrder=3): Cods  - somente leitura
11282:     *   Column3 (ColumnOrder=1): Marcas (CheckBox) - editavel em INCLUIR/ALTERAR
11283:     *===========================================================================
11284:     PROTECTED PROCEDURE ConfigurarPgpgServico(par_oPg)
11285:         LOCAL loc_oPg, loc_oGrid, loc_oErro
11286:         TRY
11287:             loc_oPg = par_oPg
11288:             loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
11289: 
11290:             *-- Cursor placeholder ANTES de RecordSource (REGRA CRITICA VFP9)
11291:             IF !USED("cursor_4c_GrdServico")
11292:                 SET NULL ON
11293:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11294:                 SET NULL OFF
11295:             ENDIF
11296: 
11297:             *-- grd_4c_Dados: grade de servicos associados
11298:             *-- Original grdServico: top=171, left=339, width=320, height=387
11299:             loc_oPg.AddObject("grd_4c_Dados", "Grid")
11300:             WITH loc_oPg.grd_4c_Dados
11301:                 .Top        = 171
11302:                 .Left       = 339
11303:                 .Width      = 320
11304:                 .Height     = 387
11305:                 .FontName   = "Tahoma"
11306:                 .FontSize   = 8
11307:                 .DeleteMark = .F.
11308:                 .RecordMark = .F.
11309:                 .RowHeight  = 16
11310:                 .ScrollBars = 2
11311:                 .Visible    = .T.
11312:             ENDWITH
11313:             loc_oPg.grd_4c_Dados.ColumnCount  = 3
11314:             loc_oPg.grd_4c_Dados.RecordSource = "cursor_4c_GrdServico"
11315:             loc_oGrid = loc_oPg.grd_4c_Dados
11316: 
11317:             *-- Column1: Descs/Descricao Servico (ColumnOrder=2 - exibida como 2a coluna)
11318:             *-- When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
11319:             *-- Valid: fAcessoEmpresa (validacao empresa por descricao de servico)
11320:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdServico.Descs"
11321:             loc_oGrid.Column1.Width           = 228
11322:             loc_oGrid.Column1.ColumnOrder     = 2
11323:             loc_oGrid.Column1.Movable         = .F.
11324:             loc_oGrid.Column1.Resizable       = .F.
11325:             loc_oGrid.Column1.Header1.Caption = "Servi" + CHR(231) + "os"
11326:             loc_oGrid.Column1.Text1.Alignment  = 3
11327:             loc_oGrid.Column1.Text1.BorderStyle = 0
11328:             loc_oGrid.Column1.Text1.Margin     = 0
11329:             BINDEVENT(loc_oGrid.Column1.Text1, "When",  THIS, "GrdServicoCol1When")
11330:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid",  THIS, "GrdServicoCol1Valid")
11331: 
11332:             *-- Column2: Cods/Codigo Servico (ColumnOrder=3, somente leitura)
11333:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdServico.Cods"
11334:             loc_oGrid.Column2.Width           = 50
11335:             loc_oGrid.Column2.ColumnOrder     = 3
11336:             loc_oGrid.Column2.Movable         = .F.
11337:             loc_oGrid.Column2.Resizable       = .F.
11338:             loc_oGrid.Column2.ReadOnly        = .T.
11339:             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
11340:             loc_oGrid.Column2.Text1.BorderStyle = 0
11341:             loc_oGrid.Column2.Text1.Margin     = 0
11342:             loc_oGrid.Column2.Text1.ReadOnly   = .T.
11343: 
11344:             *-- Column3: Marcas/CheckBox (ColumnOrder=1 - primeira coluna visualmente)
11345:             *-- Sparse=.F. obrigatorio para CheckBox funcionar em coluna de grid
11346:             *-- When: editavel em INCLUIR/ALTERAR
11347:             *-- KeyPress: Space(32) ou Enter(13) togla Marcas (0->1, 1->0)
11348:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdServico.Marcas"
11349:             loc_oGrid.Column3.Width           = 17
11350:             loc_oGrid.Column3.ColumnOrder     = 1
11351:             loc_oGrid.Column3.Movable         = .F.
11352:             loc_oGrid.Column3.Resizable       = .F.
11353:             loc_oGrid.Column3.Sparse          = .F.
11354:             loc_oGrid.Column3.Header1.Caption = ""
11355:             loc_oGrid.Column3.AddObject("Check1", "CheckBox")
11356:             WITH loc_oGrid.Column3.Check1
11357:                 .Caption   = ""
11358:                 .Alignment = 0
11359:                 .ReadOnly  = .F.
11360:                 .Visible   = .T.
11361:                 .Top       = 9
11362:                 .Left      = 2
11363:                 .Height    = 17
11364:                 .Width     = 22
11365:             ENDWITH
11366:             BINDEVENT(loc_oGrid.Column3.Check1, "When",     THIS, "GrdServicoChk3When")
11367:             BINDEVENT(loc_oGrid.Column3.Check1, "KeyPress", THIS, "GrdServicoChk3KeyPress")
11368: 
11369:         CATCH TO loc_oErro
11370:             MostrarErro("Erro ao configurar pgServico:" + CHR(13) + loc_oErro.Message, ;
11371:                 "FormProduto.ConfigurarPgpgServico")
11372:         ENDTRY
11373:     ENDPROC
11374: 
11375:     *===========================================================================
11376:     * CarregarServicos - Popula cursor_4c_GrdServico com todos os servicos
11377:     * de SigPrSer, marcando Marcas=1 para os associados ao produto em SigSerPr.
11378:     * Chamado de BOParaForm ao carregar registro existente.
11379:     *===========================================================================
11380:     PROTECTED PROCEDURE CarregarServicos()
11381:         LOCAL loc_cCpros, loc_nRet, loc_oPg, loc_oGrid, loException
11382:         TRY
11383:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11384:             IF EMPTY(loc_cCpros) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
11385:                 RETURN
11386:             ENDIF
11387: 
11388:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page8
11389: 
11390:             *-- Carregar todos os servicos com Marcas=0/1 via LEFT JOIN em SigSerPr
11391:             IF USED("cursor_4c_GrdServico")
11392:                 USE IN cursor_4c_GrdServico
11393:             ENDIF
11394:             loc_nRet = SQLEXEC(gnConnHandle, ;
11395:                 "SELECT CASE WHEN s.cods IS NOT NULL THEN 1 ELSE 0 END AS Marcas," + ;
11396:                 " p.cods, p.descs, p.qtdias" + ;
11397:                 " FROM SigPrSer p" + ;
11398:                 " LEFT JOIN SigSerPr s ON s.cods = p.cods AND s.cpros = " + EscaparSQL(loc_cCpros) + ;
11399:                 " ORDER BY p.descs", ;
11400:                 "cursor_4c_GrdServico")
11401:             IF loc_nRet <= 0
11402:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11403:             ENDIF
11404: 
11405:             *-- Reassociar RecordSource e ControlSources apos recarregar cursor
11406:             IF PEMSTATUS(loc_oPg, "grd_4c_Dados", 5)
11407:                 loc_oGrid = loc_oPg.grd_4c_Dados
11408:                 loc_oGrid.ColumnCount = 3
11409:                 loc_oGrid.RecordSource          = "cursor_4c_GrdServico"
11410:                 loc_oGrid.Column1.ControlSource = "cursor_4c_GrdServico.Descs"
11411:                 loc_oGrid.Column2.ControlSource = "cursor_4c_GrdServico.Cods"
11412:                 loc_oGrid.Column3.ControlSource = "cursor_4c_GrdServico.Marcas"
11413:                 loc_oGrid.Refresh()
11414:             ENDIF
11415: 
11416:         CATCH TO loException
11417:             MostrarErro("Erro ao carregar Servi" + CHR(231) + "os:" + CHR(13) + ;
11418:                 loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
11419:                 "FormProduto.CarregarServicos")
11420:         ENDTRY
11421:     ENDPROC
11422: 
11423:     *===========================================================================
11424:     * Handlers de BINDEVENT para pgServico (Page8)
11425:     * Todos PUBLIC - requerido pelo BINDEVENT
11426:     *===========================================================================
11427: 
11428:     *-- Column1 Text1 When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
11429:     PROCEDURE GrdServicoCol1When()
11430:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11431:             RETURN .F.
11432:         ENDIF
11433:         IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
11434:             RETURN cursor_4c_GrdServico.Marcas = 1
11435:         ENDIF
11436:         RETURN .F.
11437:     ENDPROC
11438: 
11439:     *-- Column1 Text1 Valid: fAcessoEmpresa (validacao de empresa por descricao de servico)
11440:     PROCEDURE GrdServicoCol1Valid()
11441:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11442:             RETURN .T.
11443:         ENDIF
11444:         LOCAL loc_cDescs, loException
11445:         loc_cDescs = ""
11446:         TRY
11447:             IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
11448:                 loc_cDescs = ALLTRIM(cursor_4c_GrdServico.Descs)
11449:             ENDIF
11450:             IF !EMPTY(loc_cDescs)
11451:                 *!! CORRETOR #110: fAcessoEmpresa() NAO existe na nova arquitetura. Substituir por bloco FormBuscaAuxiliar apontando SigCdEmp (chave Cemps modo C, Razas modo D). Ver Formsigatcrp.prg:2278-2378.
11452:                 fAcessoEmpresa(Usuar, "C", loc_cDescs, .NULL., "")
11453:             ENDIF
11454:         CATCH TO loException
11455:             MostrarErro("Erro na valida" + CHR(231) + CHR(227) + "o de empresa:" + ;
11456:                 CHR(13) + loException.Message, "FormProduto.GrdServicoCol1Valid")
11457:         ENDTRY
11458:         RETURN .T.
11459:     ENDPROC
11460: 
11461:     *-- Column3 Check1 When: editavel apenas em INCLUIR/ALTERAR
11462:     PROCEDURE GrdServicoChk3When()
11463:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11464:     ENDPROC
11465: 
11466:     *-- Column3 Check1 KeyPress: Space(32) ou Enter(13) togla Marcas (0->1 / 1->0)
11467:     PROCEDURE GrdServicoChk3KeyPress(par_nKeyCode, par_nShiftAltCtrl)
11468:         IF INLIST(par_nKeyCode, 13, 32)
11469:             IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
11470:                 REPLACE cursor_4c_GrdServico.Marcas WITH IIF(cursor_4c_GrdServico.Marcas = 0, 1, 0)
11471:             ENDIF
11472:         ENDIF
11473:     ENDPROC
11474: 
11475: ENDDEFINE

