# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (112)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_MTPRIMA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (11481 linhas total):

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

*-- Linhas 1436 a 1791:
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

*-- Linhas 1976 a 2051:
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

*-- Linhas 2061 a 2104:
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

*-- Linhas 8057 a 8206:
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
8184:                 SET NULL ON
8185:                 CREATE CURSOR cursor_4c_GradFase ( ;
8186:                     cidchaves C(20), ordems N(2,0), grupos C(10), ;
8187:                     minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
8188:                 SET NULL OFF
8189:             ENDIF
8190:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8191:                 loc_oPg.grd_4c_GradFase.ColumnCount = 5
8192:                 loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8193:                 loc_oPg.grd_4c_GradFase.Column1.ControlSource = "cursor_4c_GradFase.ordems"
8194:                 loc_oPg.grd_4c_GradFase.Column2.ControlSource = "cursor_4c_GradFase.grupos"
8195:                 loc_oPg.grd_4c_GradFase.Column3.ControlSource = "cursor_4c_GradFase.minutos"
8196:                 loc_oPg.grd_4c_GradFase.Column4.ControlSource = "cursor_4c_GradFase.uniprdts"
8197:                 loc_oPg.grd_4c_GradFase.Column5.ControlSource = "cursor_4c_GradFase.matprdts"
8198:                 loc_oPg.grd_4c_GradFase.Column1.Header1.Caption = "Ordem"
8199:                 loc_oPg.grd_4c_GradFase.Column2.Header1.Caption = "Fase"
8200:                 loc_oPg.grd_4c_GradFase.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8201:                 loc_oPg.grd_4c_GradFase.Column4.Header1.Caption = "Uni. Produtiva"
8202:                 loc_oPg.grd_4c_GradFase.Column5.Header1.Caption = "Material"
8203:                 loc_oPg.grd_4c_GradFase.Refresh()
8204:             ENDIF
8205: 
8206:             *-- Carregar grdMatrizes de SigPrMtz + SigCdPro (descricao do produto matriz)

*-- Linhas 8239 a 8299:
8239: 
8240:     *===========================================================================
8241:     * GrdFaseBeforeRowColChange - Persiste obs do EditBox no cursor antes de mudar linha
8242:     * PUBLIC: BINDEVENT requer metodo publico
8243:     *===========================================================================
8244:     PROCEDURE GrdFaseBeforeRowColChange(par_nColIndex)
8245:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8246:             LOCAL loc_oPgBC
8247:             loc_oPgBC = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8248:             IF PEMSTATUS(loc_oPgBC, "edt_4c_Obs", 5)
8249:                 SELECT cursor_4c_GradFase
8250:                 REPLACE cursor_4c_GradFase.obs WITH loc_oPgBC.edt_4c_Obs.Value
8251:             ENDIF
8252:         ENDIF
8253:     ENDPROC
8254: 
8255:     *===========================================================================
8256:     * GrdFaseAfterRowColChange - Exibe imagem da fase e atualiza descricao
8257:     * PUBLIC: BINDEVENT requer metodo publico
8258:     *===========================================================================
8259:     PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
8260:         LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
8261:         TRY
8262:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8263:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5) OR !USED("cursor_4c_GradFase")
8264:                 RETURN
8265:             ENDIF
8266: 
8267:             CLEAR RESOURCES
8268:             loc_oPg.img_4c_ImgFig.Picture = ""
8269:             loc_oPg.img_4c_ImgFig.Visible = .F.
8270:             loc_oPg.txt_4c_Desc.Value     = ""
8271:             loc_oPg.edt_4c_Obs.Value      = ""
8272: 
8273:             IF !EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
8274:                 LOCAL loc_cGrupos, loc_cCidchaves
8275:                 SELECT cursor_4c_GradFase
8276:                 loc_cGrupos    = ALLTRIM(cursor_4c_GradFase.grupos)
8277:                 loc_cCidchaves = ALLTRIM(cursor_4c_GradFase.cidchaves)
8278: 
8279:                 *-- Carregar descricao do grupo/fase (SigCdGcr)
8280:                 IF !EMPTY(loc_cGrupos)
8281:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8282:                         "SELECT descrs FROM SigCdGcr WHERE codigos = '" + ;
8283:                         EscaparSQL(loc_cGrupos) + "", "cursor_4c_FaseGcrDesc")
8284:                     IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrDesc") AND !EOF("cursor_4c_FaseGcrDesc")
8285:                         SELECT cursor_4c_FaseGcrDesc
8286:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_FaseGcrDesc.descrs)
8287:                     ENDIF
8288:                     IF USED("cursor_4c_FaseGcrDesc")
8289:                         USE IN cursor_4c_FaseGcrDesc
8290:                     ENDIF
8291:                 ENDIF
8292: 
8293:                 *-- Obs vem do cursor (ja carregado em CarregarFaseP / gravado por BeforeRowColChange)
8294:                 SELECT cursor_4c_GradFase
8295:                 IF !ISNULL(cursor_4c_GradFase.obs)
8296:                     loc_oPg.edt_4c_Obs.Value = cursor_4c_GradFase.obs
8297:                 ENDIF
8298: 
8299:                 *-- Figura carregada do banco (campo figprocs - binario nao armazenado no cursor)

*-- Linhas 8326 a 10544:
8326: 
8327:     *===========================================================================
8328:     * GrdFaseCol1OrdValid - Valida coluna Ordem da GradFase
8329:     * PUBLIC: BINDEVENT requer metodo publico
8330:     *===========================================================================
8331:     PROCEDURE GrdFaseCol1OrdValid()
8332:         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
8333:             SELECT cursor_4c_GradFase
8334:             IF cursor_4c_GradFase.ordems <= 0
8335:                 MsgAviso("Ordem deve ser maior que zero.", "Fase")
8336:                 RETURN .F.
8337:             ENDIF
8338:         ENDIF
8339:         RETURN .T.
8340:     ENDPROC
8341: 
8342:     *===========================================================================
8343:     * GrdFaseCol2FaseValid - Lookup de fase/grupo (SigCdGcr) na GradFase
8344:     * PUBLIC: BINDEVENT requer metodo publico
8345:     *===========================================================================
8346:     PROCEDURE GrdFaseCol2FaseValid()
8347:         LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
8348:         TRY
8349:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8350:                 loc_lResultado = .T.
8351:             ENDIF
8352:             SELECT cursor_4c_GradFase
8353:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.grupos)
8354:             IF EMPTY(loc_cValAtual)
8355:                 loc_lResultado = .T.
8356:             ENDIF
8357: 
8358:             loc_nRet = SQLEXEC(gnConnHandle, ;
8359:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = '" + ;
8360:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseGcrBusca")
8361:             IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrBusca") AND !EOF("cursor_4c_FaseGcrBusca")
8362:                 IF USED("cursor_4c_FaseGcrBusca")
8363:                     USE IN cursor_4c_FaseGcrBusca
8364:                 ENDIF
8365:                 loc_lResultado = .T.
8366:             ENDIF
8367:             IF USED("cursor_4c_FaseGcrBusca")
8368:                 USE IN cursor_4c_FaseGcrBusca
8369:             ENDIF
8370: 
8371:             *-- Codigo nao encontrado: abrir busca
8372:             loc_nRet = SQLEXEC(gnConnHandle, ;
8373:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE '" + ;
8374:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY codigos", "cursor_4c_FaseGcrBusca")
8375:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseGcrBusca") OR EOF("cursor_4c_FaseGcrBusca")
8376:                 IF USED("cursor_4c_FaseGcrBusca")
8377:                     USE IN cursor_4c_FaseGcrBusca
8378:                 ENDIF
8379:                 SQLEXEC(gnConnHandle, ;
8380:                     "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
8381:                     "cursor_4c_FaseGcrBusca")
8382:             ENDIF
8383: 
8384:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8385:             IF VARTYPE(loc_oBusca) = "O"
8386:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseGcrBusca"
8387:                 loc_oBusca.DefinirCursor("cursor_4c_FaseGcrBusca", "codigos", "descrs", ;
8388:                     "Selecionar Fase/Grupo")
8389:                 loc_oBusca.Mostrar()
8390:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8391:                     SELECT cursor_4c_GradFase
8392:                     REPLACE cursor_4c_GradFase.grupos WITH loc_oBusca.cCodigoSelecionado
8393:                 ENDIF
8394:                 loc_oBusca = .NULL.
8395:             ENDIF
8396: 
8397:             IF USED("cursor_4c_FaseGcrBusca")
8398:                 USE IN cursor_4c_FaseGcrBusca
8399:             ENDIF
8400: 
8401:         CATCH TO loException
8402:             IF USED("cursor_4c_FaseGcrBusca")
8403:                 USE IN cursor_4c_FaseGcrBusca
8404:             ENDIF
8405:             MostrarErro("Erro ao validar fase:" + CHR(13) + loException.Message, ;
8406:                 "FormProduto.GrdFaseCol2FaseValid")
8407:         ENDTRY
8408:         RETURN .T.
8409:     ENDPROC
8410: 
8411:     *===========================================================================
8412:     * GrdFaseCol4UniPrdtValid - Lookup de Unidade Produtiva (SigCdUpd) na GradFase
8413:     * PUBLIC: BINDEVENT requer metodo publico
8414:     *===========================================================================
8415:     PROCEDURE GrdFaseCol4UniPrdtValid()
8416:         LOCAL loc_cValAtual, loc_cGrupos, loc_nRet, loc_oBusca, loException
8417:         TRY
8418:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8419:                 loc_lResultado = .T.
8420:             ENDIF
8421:             SELECT cursor_4c_GradFase
8422:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.uniprdts)
8423:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8424:             IF EMPTY(loc_cValAtual)
8425:                 loc_lResultado = .T.
8426:             ENDIF
8427: 
8428:             loc_nRet = SQLEXEC(gnConnHandle, ;
8429:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = " + ;
8430:                 EscaparSQL(loc_cGrupos), "cursor_4c_FaseUpdBusca")
8431:             IF loc_nRet > 0 AND USED("cursor_4c_FaseUpdBusca")
8432:                 LOCATE FOR ALLTRIM(cursor_4c_FaseUpdBusca.uniprdts) == ALLTRIM(loc_cValAtual)
8433:                 IF !EOF("cursor_4c_FaseUpdBusca")
8434:                     loc_lResultado = .T.
8435:                 ENDIF
8436:                 USE IN cursor_4c_FaseUpdBusca
8437:             ENDIF
8438:             IF USED("cursor_4c_FaseUpdBusca")
8439:                 USE IN cursor_4c_FaseUpdBusca
8440:             ENDIF
8441: 
8442:             *-- Abrir busca das unidades produtivas para este grupo
8443:             loc_nRet = SQLEXEC(gnConnHandle, ;
8444:                 "SELECT uniprdts FROM SigCdUpd WHERE codigos = " + ;
8445:                 EscaparSQL(loc_cGrupos) + " ORDER BY uniprdts", "cursor_4c_FaseUpdBusca")
8446:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseUpdBusca") OR EOF("cursor_4c_FaseUpdBusca")
8447:                 IF USED("cursor_4c_FaseUpdBusca")
8448:                     USE IN cursor_4c_FaseUpdBusca
8449:                 ENDIF
8450:                 SQLEXEC(gnConnHandle, ;
8451:                     "SELECT DISTINCT uniprdts FROM SigCdUpd ORDER BY uniprdts", ;
8452:                     "cursor_4c_FaseUpdBusca")
8453:             ENDIF
8454: 
8455:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8456:             IF VARTYPE(loc_oBusca) = "O"
8457:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseUpdBusca"
8458:                 loc_oBusca.DefinirCursor("cursor_4c_FaseUpdBusca", "uniprdts", "uniprdts", ;
8459:                     "Selecionar Uni. Produtiva")
8460:                 loc_oBusca.Mostrar()
8461:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8462:                     SELECT cursor_4c_GradFase
8463:                     REPLACE cursor_4c_GradFase.uniprdts WITH loc_oBusca.cCodigoSelecionado
8464:                 ENDIF
8465:                 loc_oBusca = .NULL.
8466:             ENDIF
8467: 
8468:             IF USED("cursor_4c_FaseUpdBusca")
8469:                 USE IN cursor_4c_FaseUpdBusca
8470:             ENDIF
8471: 
8472:         CATCH TO loException
8473:             IF USED("cursor_4c_FaseUpdBusca")
8474:                 USE IN cursor_4c_FaseUpdBusca
8475:             ENDIF
8476:             MostrarErro("Erro ao validar uni. produtiva:" + CHR(13) + loException.Message, ;
8477:                 "FormProduto.GrdFaseCol4UniPrdtValid")
8478:         ENDTRY
8479:         RETURN .T.
8480:     ENDPROC
8481: 
8482:     *===========================================================================
8483:     * GrdFaseCol5MatPrdtValid - Lookup de Material (SigOpOpt) na GradFase
8484:     * PUBLIC: BINDEVENT requer metodo publico
8485:     *===========================================================================
8486:     PROCEDURE GrdFaseCol5MatPrdtValid()
8487:         LOCAL loc_cValAtual, loc_cGrupos, loc_nRet, loc_oBusca, loException
8488:         TRY
8489:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8490:                 loc_lResultado = .T.
8491:             ENDIF
8492:             SELECT cursor_4c_GradFase
8493:             loc_cValAtual = ALLTRIM(cursor_4c_GradFase.matprdts)
8494:             loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
8495:             IF EMPTY(loc_cValAtual)
8496:                 loc_lResultado = .T.
8497:             ENDIF
8498: 
8499:             loc_nRet = SQLEXEC(gnConnHandle, ;
8500:                 "SELECT cods, descs FROM SigOpOpt WHERE cods = '" + ;
8501:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseOptBusca")
8502:             IF loc_nRet > 0 AND USED("cursor_4c_FaseOptBusca") AND !EOF("cursor_4c_FaseOptBusca")
8503:                 IF USED("cursor_4c_FaseOptBusca")
8504:                     USE IN cursor_4c_FaseOptBusca
8505:                 ENDIF
8506:                 loc_lResultado = .T.
8507:             ENDIF
8508:             IF USED("cursor_4c_FaseOptBusca")
8509:                 USE IN cursor_4c_FaseOptBusca
8510:             ENDIF
8511: 
8512:             *-- Abrir busca filtrando pelo grupo da fase
8513:             loc_nRet = SQLEXEC(gnConnHandle, ;
8514:                 "SELECT cods, descs FROM SigOpOpt WHERE grupos = '" + ;
8515:                 EscaparSQL(loc_cGrupos) + " AND cods LIKE '" + ;
8516:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_FaseOptBusca")
8517:             IF loc_nRet <= 0 OR !USED("cursor_4c_FaseOptBusca") OR EOF("cursor_4c_FaseOptBusca")
8518:                 IF USED("cursor_4c_FaseOptBusca")
8519:                     USE IN cursor_4c_FaseOptBusca
8520:                 ENDIF
8521:                 SQLEXEC(gnConnHandle, ;
8522:                     "SELECT cods, descs FROM SigOpOpt ORDER BY cods", ;
8523:                     "cursor_4c_FaseOptBusca")
8524:             ENDIF
8525: 
8526:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8527:             IF VARTYPE(loc_oBusca) = "O"
8528:                 loc_oBusca.this_cCursorDestino = "cursor_4c_FaseOptBusca"
8529:                 loc_oBusca.DefinirCursor("cursor_4c_FaseOptBusca", "cods", "descs", ;
8530:                     "Selecionar Material")
8531:                 loc_oBusca.Mostrar()
8532:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
8533:                     SELECT cursor_4c_GradFase
8534:                     REPLACE cursor_4c_GradFase.matprdts WITH loc_oBusca.cCodigoSelecionado
8535:                 ENDIF
8536:                 loc_oBusca = .NULL.
8537:             ENDIF
8538: 
8539:             IF USED("cursor_4c_FaseOptBusca")
8540:                 USE IN cursor_4c_FaseOptBusca
8541:             ENDIF
8542: 
8543:         CATCH TO loException
8544:             IF USED("cursor_4c_FaseOptBusca")
8545:                 USE IN cursor_4c_FaseOptBusca
8546:             ENDIF
8547:             MostrarErro("Erro ao validar material:" + CHR(13) + loException.Message, ;
8548:                 "FormProduto.GrdFaseCol5MatPrdtValid")
8549:         ENDTRY
8550:         RETURN .T.
8551:     ENDPROC
8552: 
8553:     *===========================================================================
8554:     * BtnInserirFaseClick - Insere nova linha na GradFase (cursor_4c_GradFase)
8555:     * PUBLIC: BINDEVENT requer metodo publico
8556:     *===========================================================================
8557:     PROCEDURE BtnInserirFaseClick()
8558:         LOCAL loc_oPg, loc_nProxOrdem, loException
8559:         TRY
8560:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8561:                 RETURN
8562:             ENDIF
8563:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8564:             IF !USED("cursor_4c_GradFase")
8565:                 RETURN
8566:             ENDIF
8567: 
8568:             SELECT cursor_4c_GradFase
8569:             IF EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase") OR ;
8570:                     RECCOUNT("cursor_4c_GradFase") = 0
8571:                 loc_nProxOrdem = 1
8572:             ELSE
8573:                 GO BOTTOM IN cursor_4c_GradFase
8574:                 loc_nProxOrdem = cursor_4c_GradFase.ordems + 1
8575:             ENDIF
8576: 
8577:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8578:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8579: 
8580:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8581:                 loc_oPg.grd_4c_GradFase.Refresh()
8582:                 GO BOTTOM IN cursor_4c_GradFase
8583:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8584:             ENDIF
8585: 
8586:         CATCH TO loException
8587:             MostrarErro("Erro ao inserir fase:" + CHR(13) + loException.Message, ;
8588:                 "FormProduto.BtnInserirFaseClick")
8589:         ENDTRY
8590:     ENDPROC
8591: 
8592:     *===========================================================================
8593:     * BtnExcluirFaseClick - Exclui linha atual da GradFase
8594:     * PUBLIC: BINDEVENT requer metodo publico
8595:     *===========================================================================
8596:     PROCEDURE BtnExcluirFaseClick()
8597:         LOCAL loc_oPg, loException
8598:         TRY
8599:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8600:                 RETURN
8601:             ENDIF
8602:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8603:                 RETURN
8604:             ENDIF
8605: 
8606:             SELECT cursor_4c_GradFase
8607:             IF !MsgConfirma("Excluir esta fase de produ" + CHR(231) + CHR(227) + "o?")
8608:                 RETURN
8609:             ENDIF
8610:             DELETE IN cursor_4c_GradFase
8611:             IF !EOF("cursor_4c_GradFase")
8612:                 SKIP IN cursor_4c_GradFase
8613:             ENDIF
8614:             IF EOF("cursor_4c_GradFase") AND RECCOUNT("cursor_4c_GradFase") > 0
8615:                 GO BOTTOM IN cursor_4c_GradFase
8616:             ENDIF
8617: 
8618:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8619:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8620:                 loc_oPg.grd_4c_GradFase.Refresh()
8621:             ENDIF
8622: 
8623:         CATCH TO loException
8624:             MostrarErro("Erro ao excluir fase:" + CHR(13) + loException.Message, ;
8625:                 "FormProduto.BtnExcluirFaseClick")
8626:         ENDTRY
8627:     ENDPROC
8628: 
8629:     *===========================================================================
8630:     * BtnAlternativaFaseClick - Insere fase alternativa apos a fase atual
8631:     * PUBLIC: BINDEVENT requer metodo publico
8632:     *===========================================================================
8633:     PROCEDURE BtnAlternativaFaseClick()
8634:         LOCAL loc_oPg, loc_nOrdemAtual, loc_nProxOrdem, loException
8635:         TRY
8636:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8637:                 RETURN
8638:             ENDIF
8639:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8640:             IF !USED("cursor_4c_GradFase")
8641:                 RETURN
8642:             ENDIF
8643: 
8644:             SELECT cursor_4c_GradFase
8645:             IF EOF("cursor_4c_GradFase") OR RECCOUNT("cursor_4c_GradFase") = 0
8646:                 loc_nOrdemAtual = 0
8647:             ELSE
8648:                 loc_nOrdemAtual = cursor_4c_GradFase.ordems
8649:             ENDIF
8650:             loc_nProxOrdem = loc_nOrdemAtual + 1
8651: 
8652:             INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
8653:                 VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")
8654: 
8655:             IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
8656:                 loc_oPg.grd_4c_GradFase.Refresh()
8657:                 GO BOTTOM IN cursor_4c_GradFase
8658:                 loc_oPg.grd_4c_GradFase.Column2.SetFocus()
8659:             ENDIF
8660: 
8661:         CATCH TO loException
8662:             MostrarErro("Erro ao inserir fase alternativa:" + CHR(13) + loException.Message, ;
8663:                 "FormProduto.BtnAlternativaFaseClick")
8664:         ENDTRY
8665:     ENDPROC
8666: 
8667:     *===========================================================================
8668:     * CmdFichaFasePClick - Abre formulario de Ficha Tecnica do produto
8669:     * PUBLIC: BINDEVENT requer metodo publico
8670:     *===========================================================================
8671:     PROCEDURE CmdFichaFasePClick()
8672:         LOCAL loc_cCpros, loException
8673:         TRY
8674:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
8675:             IF EMPTY(loc_cCpros)
8676:                 MsgAviso("Selecione um produto para abrir a Ficha T" + CHR(233) + "cnica.", ;
8677:                     "Ficha T" + CHR(233) + "cnica")
8678:                 RETURN
8679:             ENDIF
8680:             MsgInfo("Ficha T" + CHR(233) + "cnica: " + loc_cCpros)
8681:         CATCH TO loException
8682:             MostrarErro("Erro ao abrir Ficha T" + CHR(233) + "cnica:" + CHR(13) + ;
8683:                 loException.Message, "FormProduto.CmdFichaFasePClick")
8684:         ENDTRY
8685:     ENDPROC
8686: 
8687:     *===========================================================================
8688:     * CmdFiguraFasePClick - Captura imagem do produto via seletor de arquivo
8689:     * PUBLIC: BINDEVENT requer metodo publico
8690:     *===========================================================================
8691:     PROCEDURE CmdFiguraFasePClick()
8692:         LOCAL loc_lcFigura, loc_lcArquivo, loc_oPg, loException
8693:         TRY
8694:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8695:                 RETURN
8696:             ENDIF
8697:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8698:                 MsgAviso("Selecione uma fase na grade para associar a imagem.", "Imagem")
8699:                 RETURN
8700:             ENDIF
8701: 
8702:             loc_lcFigura = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", ;
8703:                 "Nome do Arquivo:", "Selecionar"))
8704:             IF EMPTY(loc_lcFigura) OR !FILE(loc_lcFigura)
8705:                 RETURN
8706:             ENDIF
8707: 
8708:             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8709:             COPY FILE (loc_lcFigura) TO (loc_lcArquivo)
8710: 
8711:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8712:             IF PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5)
8713:                 CLEAR RESOURCES
8714:                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
8715:                 loc_oPg.img_4c_ImgFig.Visible = .T.
8716:             ENDIF
8717: 
8718:         CATCH TO loException
8719:             MostrarErro("Erro ao capturar imagem:" + CHR(13) + loException.Message, ;
8720:                 "FormProduto.CmdFiguraFasePClick")
8721:         ENDTRY
8722:     ENDPROC
8723: 
8724:     *===========================================================================
8725:     * CmdFigCamFasePClick - Captura imagem do produto via WebCam (SigImage)
8726:     * PUBLIC: BINDEVENT requer metodo publico
8727:     *===========================================================================
8728:     PROCEDURE CmdFigCamFasePClick()
8729:         LOCAL loc_lcFigura, loc_lcArquivo, loc_oPg, loException
8730:         TRY
8731:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8732:                 RETURN
8733:             ENDIF
8734:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
8735:                 MsgAviso("Selecione uma fase na grade para associar a imagem.", "Imagem WebCam")
8736:                 RETURN
8737:             ENDIF
8738: 
8739:             loc_lcFigura = ""
8740:             DO FORM SigImage TO loc_lcFigura
8741:             IF EMPTY(loc_lcFigura) OR !FILE(loc_lcFigura)
8742:                 RETURN
8743:             ENDIF
8744: 
8745:             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
8746:             COPY FILE (loc_lcFigura) TO (loc_lcArquivo)
8747: 
8748:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8749:             IF PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5)
8750:                 CLEAR RESOURCES
8751:                 loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
8752:                 loc_oPg.img_4c_ImgFig.Visible = .T.
8753:             ENDIF
8754: 
8755:         CATCH TO loException
8756:             MostrarErro("Erro ao capturar imagem via WebCam:" + CHR(13) + loException.Message, ;
8757:                 "FormProduto.CmdFigCamFasePClick")
8758:         ENDTRY
8759:     ENDPROC
8760: 
8761:     *===========================================================================
8762:     * ValidarConquilhaFaseP - Lookup de Conquilha (sigcdcnq) em txt_4c_Conquilhas
8763:     * PUBLIC: BINDEVENT requer metodo publico
8764:     *===========================================================================
8765:     PROCEDURE ValidarConquilhaFaseP(par_nKeyCode, par_nShiftAltCtrl)
8766:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8767:         TRY
8768:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8769:             IF !PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
8770:                 loc_lResultado = .T.
8771:             ENDIF
8772:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value)
8773:             IF EMPTY(loc_cValAtual)
8774:                 loc_lResultado = .T.
8775:             ENDIF
8776: 
8777:             loc_nRet = SQLEXEC(gnConnHandle, ;
8778:                 "SELECT DISTINCT conquilhas FROM sigcdcnq ORDER BY conquilhas", ;
8779:                 "cursor_4c_CnqBusca")
8780:             IF loc_nRet > 0 AND USED("cursor_4c_CnqBusca")
8781:                 LOCATE FOR ALLTRIM(cursor_4c_CnqBusca.conquilhas) == ALLTRIM(loc_cValAtual)
8782:                 IF !EOF("cursor_4c_CnqBusca")
8783:                     loc_lResultado = .T.
8784:                 ENDIF
8785:                 USE IN cursor_4c_CnqBusca
8786:             ENDIF
8787:             IF USED("cursor_4c_CnqBusca")
8788:                 USE IN cursor_4c_CnqBusca
8789:             ENDIF
8790: 
8791:             loc_nRet = SQLEXEC(gnConnHandle, ;
8792:                 "SELECT DISTINCT conquilhas FROM sigcdcnq ORDER BY conquilhas", ;
8793:                 "cursor_4c_CnqBusca")
8794: 
8795:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8796:             IF VARTYPE(loc_oBusca) = "O"
8797:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CnqBusca"
8798:                 loc_oBusca.DefinirCursor("cursor_4c_CnqBusca", "conquilhas", "conquilhas", ;
8799:                     "Selecionar Conquilha")
8800:                 loc_oBusca.Mostrar()
8801:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8802:                     loc_oPg.txt_4c_Conquilhas.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8803:                 ENDIF
8804:                 loc_oBusca = .NULL.
8805:             ENDIF
8806: 
8807:             IF USED("cursor_4c_CnqBusca")
8808:                 USE IN cursor_4c_CnqBusca
8809:             ENDIF
8810: 
8811:         CATCH TO loException
8812:             IF USED("cursor_4c_CnqBusca")
8813:                 USE IN cursor_4c_CnqBusca
8814:             ENDIF
8815:             MostrarErro("Erro ao validar conquilha:" + CHR(13) + loException.Message, ;
8816:                 "FormProduto.ValidarConquilhaFaseP")
8817:         ENDTRY
8818:         RETURN .T.
8819:     ENDPROC
8820: 
8821:     *===========================================================================
8822:     * ValidarCorFaseP - Lookup de Cor Padrao (SigCdCor) em txt_4c_CodCorsFP
8823:     * PUBLIC: BINDEVENT requer metodo publico
8824:     *===========================================================================
8825:     PROCEDURE ValidarCorFaseP(par_nKeyCode, par_nShiftAltCtrl)
8826:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8827:         TRY
8828:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8829:             IF !PEMSTATUS(loc_oPg, "txt_4c_CodCorsFP", 5)
8830:                 loc_lResultado = .T.
8831:             ENDIF
8832:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodCorsFP.Value)
8833:             IF EMPTY(loc_cValAtual)
8834:                 loc_lResultado = .T.
8835:             ENDIF
8836: 
8837:             loc_nRet = SQLEXEC(gnConnHandle, ;
8838:                 "SELECT cods, descs FROM SigCdCor WHERE cods = '" + ;
8839:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_CorFPBusca")
8840:             IF loc_nRet > 0 AND USED("cursor_4c_CorFPBusca") AND !EOF("cursor_4c_CorFPBusca")
8841:                 IF USED("cursor_4c_CorFPBusca")
8842:                     USE IN cursor_4c_CorFPBusca
8843:                 ENDIF
8844:                 *-- Sincronizar com Page1
8845:                 LOCAL loc_oPg1
8846:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8847:                 IF PEMSTATUS(loc_oPg1, "txt_4c_CodCors", 5)
8848:                     loc_oPg1.txt_4c_CodCors.Value = loc_cValAtual
8849:                 ENDIF
8850:                 loc_lResultado = .T.
8851:             ENDIF
8852:             IF USED("cursor_4c_CorFPBusca")
8853:                 USE IN cursor_4c_CorFPBusca
8854:             ENDIF
8855: 
8856:             loc_nRet = SQLEXEC(gnConnHandle, ;
8857:                 "SELECT cods, descs FROM SigCdCor WHERE cods LIKE '" + ;
8858:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_CorFPBusca")
8859:             IF loc_nRet <= 0 OR !USED("cursor_4c_CorFPBusca") OR EOF("cursor_4c_CorFPBusca")
8860:                 IF USED("cursor_4c_CorFPBusca")
8861:                     USE IN cursor_4c_CorFPBusca
8862:                 ENDIF
8863:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCor ORDER BY cods", ;
8864:                     "cursor_4c_CorFPBusca")
8865:             ENDIF
8866: 
8867:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8868:             IF VARTYPE(loc_oBusca) = "O"
8869:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CorFPBusca"
8870:                 loc_oBusca.DefinirCursor("cursor_4c_CorFPBusca", "cods", "descs", ;
8871:                     "Selecionar Cor Padr" + CHR(227) + "o")
8872:                 loc_oBusca.Mostrar()
8873:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8874:                     loc_oPg.txt_4c_CodCorsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8875:                     LOCAL loc_oPg1b
8876:                     loc_oPg1b = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8877:                     IF PEMSTATUS(loc_oPg1b, "txt_4c_CodCors", 5)
8878:                         loc_oPg1b.txt_4c_CodCors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8879:                     ENDIF
8880:                 ENDIF
8881:                 loc_oBusca = .NULL.
8882:             ENDIF
8883: 
8884:             IF USED("cursor_4c_CorFPBusca")
8885:                 USE IN cursor_4c_CorFPBusca
8886:             ENDIF
8887: 
8888:         CATCH TO loException
8889:             IF USED("cursor_4c_CorFPBusca")
8890:                 USE IN cursor_4c_CorFPBusca
8891:             ENDIF
8892:             MostrarErro("Erro ao validar cor padr" + CHR(227) + "o:" + CHR(13) + ;
8893:                 loException.Message, "FormProduto.ValidarCorFaseP")
8894:         ENDTRY
8895:         RETURN .T.
8896:     ENDPROC
8897: 
8898:     *===========================================================================
8899:     * ValidarTamFaseP - Lookup de Tamanho Padrao (SigCdTam) em txt_4c_CodTamsFP
8900:     * PUBLIC: BINDEVENT requer metodo publico
8901:     *===========================================================================
8902:     PROCEDURE ValidarTamFaseP(par_nKeyCode, par_nShiftAltCtrl)
8903:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8904:         TRY
8905:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8906:             IF !PEMSTATUS(loc_oPg, "txt_4c_CodTamsFP", 5)
8907:                 loc_lResultado = .T.
8908:             ENDIF
8909:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodTamsFP.Value)
8910:             IF EMPTY(loc_cValAtual)
8911:                 loc_lResultado = .T.
8912:             ENDIF
8913: 
8914:             loc_nRet = SQLEXEC(gnConnHandle, ;
8915:                 "SELECT cods, descs FROM SigCdTam WHERE cods = '" + ;
8916:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_TamFPBusca")
8917:             IF loc_nRet > 0 AND USED("cursor_4c_TamFPBusca") AND !EOF("cursor_4c_TamFPBusca")
8918:                 IF USED("cursor_4c_TamFPBusca")
8919:                     USE IN cursor_4c_TamFPBusca
8920:                 ENDIF
8921:                 LOCAL loc_oPg1c
8922:                 loc_oPg1c = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8923:                 IF PEMSTATUS(loc_oPg1c, "txt_4c_CodTams", 5)
8924:                     loc_oPg1c.txt_4c_CodTams.Value = loc_cValAtual
8925:                 ENDIF
8926:                 loc_lResultado = .T.
8927:             ENDIF
8928:             IF USED("cursor_4c_TamFPBusca")
8929:                 USE IN cursor_4c_TamFPBusca
8930:             ENDIF
8931: 
8932:             loc_nRet = SQLEXEC(gnConnHandle, ;
8933:                 "SELECT cods, descs FROM SigCdTam WHERE cods LIKE '" + ;
8934:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_TamFPBusca")
8935:             IF loc_nRet <= 0 OR !USED("cursor_4c_TamFPBusca") OR EOF("cursor_4c_TamFPBusca")
8936:                 IF USED("cursor_4c_TamFPBusca")
8937:                     USE IN cursor_4c_TamFPBusca
8938:                 ENDIF
8939:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdTam ORDER BY cods", ;
8940:                     "cursor_4c_TamFPBusca")
8941:             ENDIF
8942: 
8943:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
8944:             IF VARTYPE(loc_oBusca) = "O"
8945:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TamFPBusca"
8946:                 loc_oBusca.DefinirCursor("cursor_4c_TamFPBusca", "cods", "descs", ;
8947:                     "Selecionar Tamanho Padr" + CHR(227) + "o")
8948:                 loc_oBusca.Mostrar()
8949:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
8950:                     loc_oPg.txt_4c_CodTamsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8951:                     LOCAL loc_oPg1d
8952:                     loc_oPg1d = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8953:                     IF PEMSTATUS(loc_oPg1d, "txt_4c_CodTams", 5)
8954:                         loc_oPg1d.txt_4c_CodTams.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
8955:                     ENDIF
8956:                 ENDIF
8957:                 loc_oBusca = .NULL.
8958:             ENDIF
8959: 
8960:             IF USED("cursor_4c_TamFPBusca")
8961:                 USE IN cursor_4c_TamFPBusca
8962:             ENDIF
8963: 
8964:         CATCH TO loException
8965:             IF USED("cursor_4c_TamFPBusca")
8966:                 USE IN cursor_4c_TamFPBusca
8967:             ENDIF
8968:             MostrarErro("Erro ao validar tamanho padr" + CHR(227) + "o:" + CHR(13) + ;
8969:                 loException.Message, "FormProduto.ValidarTamFaseP")
8970:         ENDTRY
8971:         RETURN .T.
8972:     ENDPROC
8973: 
8974:     *===========================================================================
8975:     * ValidarAcabamentoFaseP - Lookup de Acabamento (SigCdAca) em txt_4c_CodAcbsFP
8976:     * PUBLIC: BINDEVENT requer metodo publico
8977:     *===========================================================================
8978:     PROCEDURE ValidarAcabamentoFaseP(par_nKeyCode, par_nShiftAltCtrl)
8979:         LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
8980:         TRY
8981:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8982:             IF !PEMSTATUS(loc_oPg, "txt_4c_CodAcbsFP", 5)
8983:                 loc_lResultado = .T.
8984:             ENDIF
8985:             loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodAcbsFP.Value)
8986:             IF EMPTY(loc_cValAtual)
8987:                 loc_oPg.txt_4c_DacbFP.Value = ""
8988:                 loc_lResultado = .T.
8989:             ENDIF
8990: 
8991:             loc_nRet = SQLEXEC(gnConnHandle, ;
8992:                 "SELECT cods, descrs FROM SigCdAca WHERE cods = '" + ;
8993:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_AcaFPBusca")
8994:             IF loc_nRet > 0 AND USED("cursor_4c_AcaFPBusca") AND !EOF("cursor_4c_AcaFPBusca")
8995:                 SELECT cursor_4c_AcaFPBusca
8996:                 loc_oPg.txt_4c_DacbFP.Value = ALLTRIM(cursor_4c_AcaFPBusca.descrs)
8997:                 IF USED("cursor_4c_AcaFPBusca")
8998:                     USE IN cursor_4c_AcaFPBusca
8999:                 ENDIF
9000:                 LOCAL loc_oPg1e
9001:                 loc_oPg1e = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9002:                 IF PEMSTATUS(loc_oPg1e, "txt_4c_CodAcbs", 5)
9003:                     loc_oPg1e.txt_4c_CodAcbs.Value = loc_cValAtual
9004:                 ENDIF
9005:                 loc_lResultado = .T.
9006:             ENDIF
9007:             IF USED("cursor_4c_AcaFPBusca")
9008:                 USE IN cursor_4c_AcaFPBusca
9009:             ENDIF
9010: 
9011:             loc_nRet = SQLEXEC(gnConnHandle, ;
9012:                 "SELECT cods, descrs FROM SigCdAca WHERE cods LIKE '" + ;
9013:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_AcaFPBusca")
9014:             IF loc_nRet <= 0 OR !USED("cursor_4c_AcaFPBusca") OR EOF("cursor_4c_AcaFPBusca")
9015:                 IF USED("cursor_4c_AcaFPBusca")
9016:                     USE IN cursor_4c_AcaFPBusca
9017:                 ENDIF
9018:                 SQLEXEC(gnConnHandle, "SELECT cods, descrs FROM SigCdAca ORDER BY cods", ;
9019:                     "cursor_4c_AcaFPBusca")
9020:             ENDIF
9021: 
9022:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9023:             IF VARTYPE(loc_oBusca) = "O"
9024:                 loc_oBusca.this_cCursorDestino = "cursor_4c_AcaFPBusca"
9025:                 loc_oBusca.DefinirCursor("cursor_4c_AcaFPBusca", "cods", "descrs", ;
9026:                     "Selecionar Acabamento")
9027:                 loc_oBusca.Mostrar()
9028:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
9029:                     loc_oPg.txt_4c_CodAcbsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
9030:                     loc_oPg.txt_4c_DacbFP.Value    = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
9031:                     LOCAL loc_oPg1f
9032:                     loc_oPg1f = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9033:                     IF PEMSTATUS(loc_oPg1f, "txt_4c_CodAcbs", 5)
9034:                         loc_oPg1f.txt_4c_CodAcbs.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
9035:                     ENDIF
9036:                 ENDIF
9037:                 loc_oBusca = .NULL.
9038:             ENDIF
9039: 
9040:             IF USED("cursor_4c_AcaFPBusca")
9041:                 USE IN cursor_4c_AcaFPBusca
9042:             ENDIF
9043: 
9044:         CATCH TO loException
9045:             IF USED("cursor_4c_AcaFPBusca")
9046:                 USE IN cursor_4c_AcaFPBusca
9047:             ENDIF
9048:             MostrarErro("Erro ao validar acabamento:" + CHR(13) + loException.Message, ;
9049:                 "FormProduto.ValidarAcabamentoFaseP")
9050:         ENDTRY
9051:         RETURN .T.
9052:     ENDPROC
9053: 
9054:     *===========================================================================
9055:     * GrdMatrizesCol1Valid - Lookup de produto-matriz (SigCdPro) em grdMatrizes
9056:     * PUBLIC: BINDEVENT requer metodo publico
9057:     *===========================================================================
9058:     PROCEDURE GrdMatrizesCol1Valid()
9059:         LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
9060:         TRY
9061:             IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
9062:                 loc_lResultado = .T.
9063:             ENDIF
9064:             SELECT cursor_4c_GrdMatrizes
9065:             loc_cValAtual = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9066:             IF EMPTY(loc_cValAtual)
9067:                 loc_lResultado = .T.
9068:             ENDIF
9069: 
9070:             loc_nRet = SQLEXEC(gnConnHandle, ;
9071:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros = '" + ;
9072:                 EscaparSQL(loc_cValAtual) + "", "cursor_4c_MtzPrBusca")
9073:             IF loc_nRet > 0 AND USED("cursor_4c_MtzPrBusca") AND !EOF("cursor_4c_MtzPrBusca")
9074:                 SELECT cursor_4c_MtzPrBusca
9075:                 SELECT cursor_4c_GrdMatrizes
9076:                 REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(cursor_4c_MtzPrBusca.dpros)
9077:                 IF USED("cursor_4c_MtzPrBusca")
9078:                     USE IN cursor_4c_MtzPrBusca
9079:                 ENDIF
9080:                 loc_lResultado = .T.
9081:             ENDIF
9082:             IF USED("cursor_4c_MtzPrBusca")
9083:                 USE IN cursor_4c_MtzPrBusca
9084:             ENDIF
9085: 
9086:             *-- Codigo nao encontrado: abrir busca
9087:             loc_nRet = SQLEXEC(gnConnHandle, ;
9088:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros LIKE '" + ;
9089:                 EscaparSQL(loc_cValAtual) + "%' ORDER BY cpros", "cursor_4c_MtzPrBusca")
9090:             IF loc_nRet <= 0 OR !USED("cursor_4c_MtzPrBusca") OR EOF("cursor_4c_MtzPrBusca")
9091:                 IF USED("cursor_4c_MtzPrBusca")
9092:                     USE IN cursor_4c_MtzPrBusca
9093:                 ENDIF
9094:                 SQLEXEC(gnConnHandle, ;
9095:                     "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
9096:                     "cursor_4c_MtzPrBusca")
9097:             ENDIF
9098: 
9099:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
9100:             IF VARTYPE(loc_oBusca) = "O"
9101:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MtzPrBusca"
9102:                 loc_oBusca.DefinirCursor("cursor_4c_MtzPrBusca", "cpros", "dpros", ;
9103:                     "Selecionar Produto Matriz")
9104:                 loc_oBusca.Mostrar()
9105:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdMatrizes")
9106:                     SELECT cursor_4c_GrdMatrizes
9107:                     REPLACE cursor_4c_GrdMatrizes.cmats WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
9108:                     REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
9109:                 ENDIF
9110:                 loc_oBusca = .NULL.
9111:             ENDIF
9112: 
9113:             IF USED("cursor_4c_MtzPrBusca")
9114:                 USE IN cursor_4c_MtzPrBusca
9115:             ENDIF
9116: 
9117:         CATCH TO loException
9118:             IF USED("cursor_4c_MtzPrBusca")
9119:                 USE IN cursor_4c_MtzPrBusca
9120:             ENDIF
9121:             MostrarErro("Erro ao validar matriz:" + CHR(13) + loException.Message, ;
9122:                 "FormProduto.GrdMatrizesCol1Valid")
9123:         ENDTRY
9124:         RETURN .T.
9125:     ENDPROC
9126: 
9127:     *===========================================================================
9128:     * GrdMatrizesAfterRowColChange - Exibe imagem do molde da matriz selecionada
9129:     * PUBLIC: BINDEVENT requer metodo publico
9130:     *===========================================================================
9131:     PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
9132:         LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
9133:         TRY
9134:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9135:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) OR !USED("cursor_4c_GrdMatrizes")
9136:                 RETURN
9137:             ENDIF
9138: 
9139:             CLEAR RESOURCES
9140:             loc_oPg.img_4c_ImgBorracha.Picture = ""
9141:             loc_oPg.img_4c_ImgBorracha.Visible = .F.
9142: 
9143:             IF !EOF("cursor_4c_GrdMatrizes") AND !BOF("cursor_4c_GrdMatrizes")
9144:                 SELECT cursor_4c_GrdMatrizes
9145:                 LOCAL loc_cCmats
9146:                 loc_cCmats = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
9147:                 IF !EMPTY(loc_cCmats)
9148:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9149:                         "SELECT figprocs FROM SigCdPro WHERE cpros = '" + ;
9150:                         EscaparSQL(loc_cCmats) + "", "cursor_4c_MtzImgPro")
9151:                     IF loc_nRet > 0 AND USED("cursor_4c_MtzImgPro") AND !EOF("cursor_4c_MtzImgPro")
9152:                         SELECT cursor_4c_MtzImgPro
9153:                         IF !ISNULL(cursor_4c_MtzImgPro.figprocs) AND ;
9154:                                 !EMPTY(cursor_4c_MtzImgPro.figprocs)
9155:                             loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9156:                             IF STRTOFILE(cursor_4c_MtzImgPro.figprocs, loc_lcArquivo) > 0
9157:                                 loc_oPg.img_4c_ImgBorracha.Visible = .T.
9158:                                 loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9159:                             ENDIF
9160:                         ENDIF
9161:                     ENDIF
9162:                     IF USED("cursor_4c_MtzImgPro")
9163:                         USE IN cursor_4c_MtzImgPro
9164:                     ENDIF
9165:                 ENDIF
9166:             ENDIF
9167: 
9168:         CATCH TO loException
9169:             MostrarErro("Erro ao atualizar imagem de matriz:" + CHR(13) + loException.Message, ;
9170:                 "FormProduto.GrdMatrizesAfterRowColChange")
9171:         ENDTRY
9172:     ENDPROC
9173: 
9174:     *===========================================================================
9175:     * BtnInserirMtzClick - Insere nova linha em grdMatrizes (cursor_4c_GrdMatrizes)
9176:     * PUBLIC: BINDEVENT requer metodo publico
9177:     *===========================================================================
9178:     PROCEDURE BtnInserirMtzClick()
9179:         LOCAL loc_oPg, loException
9180:         TRY
9181:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9182:                 RETURN
9183:             ENDIF
9184:             IF !USED("cursor_4c_GrdMatrizes")
9185:                 RETURN
9186:             ENDIF
9187: 
9188:             INSERT INTO cursor_4c_GrdMatrizes (cidchaves, cmats, qtds, dpros) ;
9189:                 VALUES (SYS(2015), "", 0, "")
9190: 
9191:             GO BOTTOM IN cursor_4c_GrdMatrizes
9192: 
9193:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9194:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9195:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9196:                 loc_oPg.grd_4c_GrdMatrizes.Column1.SetFocus()
9197:             ENDIF
9198: 
9199:         CATCH TO loException
9200:             MostrarErro("Erro ao inserir matriz:" + CHR(13) + loException.Message, ;
9201:                 "FormProduto.BtnInserirMtzClick")
9202:         ENDTRY
9203:     ENDPROC
9204: 
9205:     *===========================================================================
9206:     * BtnExcluirMtzClick - Exclui linha atual de grdMatrizes
9207:     * PUBLIC: BINDEVENT requer metodo publico
9208:     *===========================================================================
9209:     PROCEDURE BtnExcluirMtzClick()
9210:         LOCAL loc_oPg, loException
9211:         TRY
9212:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9213:                 RETURN
9214:             ENDIF
9215:             IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
9216:                 RETURN
9217:             ENDIF
9218: 
9219:             SELECT cursor_4c_GrdMatrizes
9220:             IF !MsgConfirma("Excluir este registro de matriz?")
9221:                 RETURN
9222:             ENDIF
9223:             DELETE IN cursor_4c_GrdMatrizes
9224:             IF !EOF("cursor_4c_GrdMatrizes")
9225:                 SKIP IN cursor_4c_GrdMatrizes
9226:             ENDIF
9227:             IF EOF("cursor_4c_GrdMatrizes") AND RECCOUNT("cursor_4c_GrdMatrizes") > 0
9228:                 GO BOTTOM IN cursor_4c_GrdMatrizes
9229:             ENDIF
9230: 
9231:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9232:             IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
9233:                 loc_oPg.grd_4c_GrdMatrizes.Refresh()
9234:             ENDIF
9235: 
9236:         CATCH TO loException
9237:             MostrarErro("Erro ao excluir matriz:" + CHR(13) + loException.Message, ;
9238:                 "FormProduto.BtnExcluirMtzClick")
9239:         ENDTRY
9240:     ENDPROC
9241: 
9242:     *===========================================================================
9243:     * Handlers de BINDEVENT para pgDadosFiscais (Page3 de pgf_4c_Dados)
9244:     * Todos PUBLIC - requerido pelo BINDEVENT
9245:     *===========================================================================
9246: 
9247:     *-- Classificacao Fiscal (clfiscals): Valid
9248:     PROCEDURE ValidarClfiscal(par_nKeyCode, par_nShiftAltCtrl)
9249:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9250:             RETURN
9251:         ENDIF
9252:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9253:         TRY
9254:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9255:             IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9256:                 RETURN
9257:             ENDIF
9258:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9259:             IF EMPTY(loc_cCod)
9260:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9261:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9262:                 ENDIF
9263:                 RETURN
9264:             ENDIF
9265:             loc_nRet = SQLEXEC(gnConnHandle, ;
9266:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
9267:                 "cursor_4c_ClfBusca")
9268:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9269:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9270:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9271:                 ENDIF
9272:                 IF USED("cursor_4c_ClfBusca")
9273:                     USE IN cursor_4c_ClfBusca
9274:                 ENDIF
9275:             ELSE
9276:                 IF USED("cursor_4c_ClfBusca")
9277:                     USE IN cursor_4c_ClfBusca
9278:                 ENDIF
9279:                 THIS.AbrirBuscaClfiscal()
9280:             ENDIF
9281:         CATCH TO loException
9282:             IF USED("cursor_4c_ClfBusca")
9283:                 USE IN cursor_4c_ClfBusca
9284:             ENDIF
9285:             MostrarErro("Erro ao validar Classif. Fiscal:" + CHR(13) + loException.Message, ;
9286:                 "FormProduto.ValidarClfiscal")
9287:         ENDTRY
9288:     ENDPROC
9289: 
9290:     PROCEDURE TxtClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9291:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9292:             THIS.ValidarClfiscal()
9293:         ENDIF
9294:     ENDPROC
9295: 
9296:     *-- Classificacao Fiscal descricao: When
9297:     PROCEDURE TxtDclfiscalWhen()
9298:         LOCAL loc_oPg
9299:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9300:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9301:             RETURN .F.
9302:         ENDIF
9303:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9304:                EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
9305:     ENDPROC
9306: 
9307:     *-- Classificacao Fiscal descricao: Valid (busca por descricao)
9308:     PROCEDURE ValidarDclfiscal(par_nKeyCode, par_nShiftAltCtrl)
9309:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9310:             RETURN
9311:         ENDIF
9312:         LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
9313:         TRY
9314:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9315:             IF !PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9316:                 RETURN
9317:             ENDIF
9318:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
9319:             IF EMPTY(loc_cDesc)
9320:                 THIS.AbrirBuscaClfiscal()
9321:                 RETURN
9322:             ENDIF
9323:             loc_nRet = SQLEXEC(gnConnHandle, ;
9324:                 "SELECT codigos, descricaos FROM SigCdClf ORDER BY descricaos", ;
9325:                 "cursor_4c_ClfBusca")
9326:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca")
9327:                 LOCATE FOR LIKE(UPPER(ALLTRIM(loc_cDesc)) + "*", UPPER(ALLTRIM(cursor_4c_ClfBusca.descricaos)))
9328:             ENDIF
9329:             IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
9330:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9331:                     loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.codigos)
9332:                 ENDIF
9333:                 loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
9334:                 IF USED("cursor_4c_ClfBusca")
9335:                     USE IN cursor_4c_ClfBusca
9336:                 ENDIF
9337:             ELSE
9338:                 IF USED("cursor_4c_ClfBusca")
9339:                     USE IN cursor_4c_ClfBusca
9340:                 ENDIF
9341:                 THIS.AbrirBuscaClfiscal()
9342:             ENDIF
9343:         CATCH TO loException
9344:             IF USED("cursor_4c_ClfBusca")
9345:                 USE IN cursor_4c_ClfBusca
9346:             ENDIF
9347:             MostrarErro("Erro ao buscar Classif. Fiscal:" + CHR(13) + loException.Message, ;
9348:                 "FormProduto.ValidarDclfiscal")
9349:         ENDTRY
9350:     ENDPROC
9351: 
9352:     PROCEDURE TxtDclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9353:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9354:             THIS.ValidarDclfiscal()
9355:         ENDIF
9356:     ENDPROC
9357: 
9358:     *-- Origem Mercadoria (origmercs): Valid
9359:     PROCEDURE ValidarOrigmerc(par_nKeyCode, par_nShiftAltCtrl)
9360:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9361:             RETURN
9362:         ENDIF
9363:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9364:         TRY
9365:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9366:             IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9367:                 RETURN
9368:             ENDIF
9369:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
9370:             IF EMPTY(loc_cCod)
9371:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9372:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
9373:                 ENDIF
9374:                 RETURN
9375:             ENDIF
9376:             loc_nRet = SQLEXEC(gnConnHandle, ;
9377:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
9378:                 "cursor_4c_OrgBusca")
9379:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9380:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9381:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9382:                 ENDIF
9383:                 IF USED("cursor_4c_OrgBusca")
9384:                     USE IN cursor_4c_OrgBusca
9385:                 ENDIF
9386:             ELSE
9387:                 IF USED("cursor_4c_OrgBusca")
9388:                     USE IN cursor_4c_OrgBusca
9389:                 ENDIF
9390:                 THIS.AbrirBuscaOrigmerc()
9391:             ENDIF
9392:         CATCH TO loException
9393:             IF USED("cursor_4c_OrgBusca")
9394:                 USE IN cursor_4c_OrgBusca
9395:             ENDIF
9396:             MostrarErro("Erro ao validar Origem Mercadoria:" + CHR(13) + loException.Message, ;
9397:                 "FormProduto.ValidarOrigmerc")
9398:         ENDTRY
9399:     ENDPROC
9400: 
9401:     PROCEDURE TxtOrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9402:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9403:             THIS.ValidarOrigmerc()
9404:         ENDIF
9405:     ENDPROC
9406: 
9407:     *-- Origem Mercadoria descricao: When
9408:     PROCEDURE TxtDorigmercWhen()
9409:         LOCAL loc_oPg
9410:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9411:         IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9412:             RETURN .F.
9413:         ENDIF
9414:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9415:                EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
9416:     ENDPROC
9417: 
9418:     *-- Origem Mercadoria descricao: Valid
9419:     PROCEDURE ValidarDorigmerc(par_nKeyCode, par_nShiftAltCtrl)
9420:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9421:             RETURN
9422:         ENDIF
9423:         LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
9424:         TRY
9425:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9426:             IF !PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9427:                 RETURN
9428:             ENDIF
9429:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)
9430:             IF EMPTY(loc_cDesc)
9431:                 THIS.AbrirBuscaOrigmerc()
9432:                 RETURN
9433:             ENDIF
9434:             loc_nRet = SQLEXEC(gnConnHandle, ;
9435:                 "SELECT codigos, descricaos FROM SIGCDORG ORDER BY descricaos", ;
9436:                 "cursor_4c_OrgBusca")
9437:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca")
9438:                 LOCATE FOR LIKE(UPPER(ALLTRIM(loc_cDesc)) + "*", UPPER(ALLTRIM(cursor_4c_OrgBusca.descricaos)))
9439:             ENDIF
9440:             IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
9441:                 IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9442:                     loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(cursor_4c_OrgBusca.codigos)
9443:                 ENDIF
9444:                 loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
9445:                 IF USED("cursor_4c_OrgBusca")
9446:                     USE IN cursor_4c_OrgBusca
9447:                 ENDIF
9448:             ELSE
9449:                 IF USED("cursor_4c_OrgBusca")
9450:                     USE IN cursor_4c_OrgBusca
9451:                 ENDIF
9452:                 THIS.AbrirBuscaOrigmerc()
9453:             ENDIF
9454:         CATCH TO loException
9455:             IF USED("cursor_4c_OrgBusca")
9456:                 USE IN cursor_4c_OrgBusca
9457:             ENDIF
9458:             MostrarErro("Erro ao buscar Origem Mercadoria:" + CHR(13) + loException.Message, ;
9459:                 "FormProduto.ValidarDorigmerc")
9460:         ENDTRY
9461:     ENDPROC
9462: 
9463:     PROCEDURE TxtDorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9464:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9465:             THIS.ValidarDorigmerc()
9466:         ENDIF
9467:     ENDPROC
9468: 
9469:     *-- Situacao Tributaria ICMS (sittricms): Valid
9470:     PROCEDURE ValidarSittricm(par_nKeyCode, par_nShiftAltCtrl)
9471:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9472:             RETURN
9473:         ENDIF
9474:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9475:         TRY
9476:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9477:             IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9478:                 RETURN
9479:             ENDIF
9480:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
9481:             IF EMPTY(loc_cCod)
9482:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9483:                     loc_oPg.txt_4c_Dsittricm.Value = ""
9484:                 ENDIF
9485:                 RETURN
9486:             ENDIF
9487:             loc_nRet = SQLEXEC(gnConnHandle, ;
9488:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9489:                 "cursor_4c_IcmBusca")
9490:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9491:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9492:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9493:                 ENDIF
9494:                 IF USED("cursor_4c_IcmBusca")
9495:                     USE IN cursor_4c_IcmBusca
9496:                 ENDIF
9497:             ELSE
9498:                 IF USED("cursor_4c_IcmBusca")
9499:                     USE IN cursor_4c_IcmBusca
9500:                 ENDIF
9501:                 THIS.AbrirBuscaSittricm()
9502:             ENDIF
9503:         CATCH TO loException
9504:             IF USED("cursor_4c_IcmBusca")
9505:                 USE IN cursor_4c_IcmBusca
9506:             ENDIF
9507:             MostrarErro("Erro ao validar Sit. Tribut" + CHR(225) + "ria ICMS:" + ;
9508:                 CHR(13) + loException.Message, "FormProduto.ValidarSittricm")
9509:         ENDTRY
9510:     ENDPROC
9511: 
9512:     PROCEDURE TxtSittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9513:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9514:             THIS.ValidarSittricm()
9515:         ENDIF
9516:     ENDPROC
9517: 
9518:     *-- Situacao Tributaria ICMS descricao: When
9519:     PROCEDURE TxtDsittricmWhen()
9520:         LOCAL loc_oPg
9521:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9522:         IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9523:             RETURN .F.
9524:         ENDIF
9525:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
9526:                EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricm.Value))
9527:     ENDPROC
9528: 
9529:     *-- Situacao Tributaria ICMS descricao: Valid
9530:     PROCEDURE ValidarDsittricm(par_nKeyCode, par_nShiftAltCtrl)
9531:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9532:             RETURN
9533:         ENDIF
9534:         LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
9535:         TRY
9536:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9537:             IF !PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9538:                 RETURN
9539:             ENDIF
9540:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value)
9541:             IF EMPTY(loc_cDesc)
9542:                 THIS.AbrirBuscaSittricm()
9543:                 RETURN
9544:             ENDIF
9545:             loc_nRet = SQLEXEC(gnConnHandle, ;
9546:                 "SELECT codigos, descricaos FROM SIGCDICM ORDER BY descricaos", ;
9547:                 "cursor_4c_IcmBusca")
9548:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca")
9549:                 LOCATE FOR LIKE(UPPER(ALLTRIM(loc_cDesc)) + "*", UPPER(ALLTRIM(cursor_4c_IcmBusca.descricaos)))
9550:             ENDIF
9551:             IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
9552:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9553:                     loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_IcmBusca.codigos)
9554:                 ENDIF
9555:                 loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
9556:                 IF USED("cursor_4c_IcmBusca")
9557:                     USE IN cursor_4c_IcmBusca
9558:                 ENDIF
9559:             ELSE
9560:                 IF USED("cursor_4c_IcmBusca")
9561:                     USE IN cursor_4c_IcmBusca
9562:                 ENDIF
9563:                 THIS.AbrirBuscaSittricm()
9564:             ENDIF
9565:         CATCH TO loException
9566:             IF USED("cursor_4c_IcmBusca")
9567:                 USE IN cursor_4c_IcmBusca
9568:             ENDIF
9569:             MostrarErro("Erro ao buscar Sit. Tribut" + CHR(225) + "ria ICMS:" + ;
9570:                 CHR(13) + loException.Message, "FormProduto.ValidarDsittricm")
9571:         ENDTRY
9572:     ENDPROC
9573: 
9574:     PROCEDURE TxtDsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9575:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9576:             THIS.ValidarDsittricm()
9577:         ENDIF
9578:     ENDPROC
9579: 
9580:     *-- Codigo Servico Fiscal: Valid (lookup SIGCDICM, copia para Sittricm)
9581:     PROCEDURE ValidarCodServsFiscal(par_nKeyCode, par_nShiftAltCtrl)
9582:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9583:             RETURN
9584:         ENDIF
9585:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9586:         TRY
9587:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9588:             IF !PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
9589:                 RETURN
9590:             ENDIF
9591:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
9592:             IF EMPTY(loc_cCod)
9593:                 RETURN
9594:             ENDIF
9595:             loc_nRet = SQLEXEC(gnConnHandle, ;
9596:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
9597:                 "cursor_4c_IcmServBusca")
9598:             IF loc_nRet > 0 AND USED("cursor_4c_IcmServBusca") AND !EOF("cursor_4c_IcmServBusca")
9599:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
9600:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_IcmServBusca.codigos)
9601:                 ENDIF
9602:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
9603:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmServBusca.descricaos)
9604:                 ENDIF
9605:                 IF USED("cursor_4c_IcmServBusca")
9606:                     USE IN cursor_4c_IcmServBusca
9607:                 ENDIF
9608:             ELSE
9609:                 IF USED("cursor_4c_IcmServBusca")
9610:                     USE IN cursor_4c_IcmServBusca
9611:                 ENDIF
9612:                 THIS.AbrirBuscaCodServsFiscal()
9613:             ENDIF
9614:         CATCH TO loException
9615:             IF USED("cursor_4c_IcmServBusca")
9616:                 USE IN cursor_4c_IcmServBusca
9617:             ENDIF
9618:             MostrarErro("Erro ao validar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal:" + ;
9619:                 CHR(13) + loException.Message, "FormProduto.ValidarCodServsFiscal")
9620:         ENDTRY
9621:     ENDPROC
9622: 
9623:     PROCEDURE TxtCodServsFiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9624:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9625:             THIS.ValidarCodServsFiscal()
9626:         ENDIF
9627:     ENDPROC
9628: 
9629:     *-- Tipo de Tributacao (tptribs): Valid
9630:     PROCEDURE ValidarTpTrib(par_nKeyCode, par_nShiftAltCtrl)
9631:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9632:             RETURN
9633:         ENDIF
9634:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9635:         TRY
9636:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9637:             IF !PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
9638:                 RETURN
9639:             ENDIF
9640:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
9641:             IF EMPTY(loc_cCod)
9642:                 RETURN
9643:             ENDIF
9644:             loc_nRet = SQLEXEC(gnConnHandle, ;
9645:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos = " + EscaparSQL(loc_cCod), ;
9646:                 "cursor_4c_TpTribBusca")
9647:             IF loc_nRet > 0 AND USED("cursor_4c_TpTribBusca") AND !EOF("cursor_4c_TpTribBusca")
9648:                 IF USED("cursor_4c_TpTribBusca")
9649:                     USE IN cursor_4c_TpTribBusca
9650:                 ENDIF
9651:             ELSE
9652:                 IF USED("cursor_4c_TpTribBusca")
9653:                     USE IN cursor_4c_TpTribBusca
9654:                 ENDIF
9655:                 THIS.AbrirBuscaTpTrib()
9656:             ENDIF
9657:         CATCH TO loException
9658:             IF USED("cursor_4c_TpTribBusca")
9659:                 USE IN cursor_4c_TpTribBusca
9660:             ENDIF
9661:             MostrarErro("Erro ao validar Tipo de Tributa" + CHR(231) + CHR(227) + "o:" + ;
9662:                 CHR(13) + loException.Message, "FormProduto.ValidarTpTrib")
9663:         ENDTRY
9664:     ENDPROC
9665: 
9666:     PROCEDURE TxtTpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9667:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9668:             THIS.ValidarTpTrib()
9669:         ENDIF
9670:     ENDPROC
9671: 
9672:     *-- IAT (iats): Valid - aceita 'A','T' ou vazio
9673:     PROCEDURE ValidarIat(par_nKeyCode, par_nShiftAltCtrl)
9674:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9675:             RETURN .T.
9676:         ENDIF
9677:         LOCAL loc_oPg, loc_cVal, loc_lSucesso, loException
9678:         loc_lSucesso = .T.
9679:         TRY
9680:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9681:             IF !PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
9682:                 loc_lSucesso = .T.
9683:             ENDIF
9684:             loc_cVal = ALLTRIM(loc_oPg.txt_4c_Iat.Value)
9685:             IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "A", "T")
9686:                 MsgAviso("IAT deve ser 'A' (Arredondamento) ou 'T' (Truncamento).")
9687:                 loc_oPg.txt_4c_Iat.SetFocus()
9688:                 loc_lSucesso = .F.
9689:             ENDIF
9690:         CATCH TO loException
9691:             MostrarErro("Erro ao validar IAT:" + CHR(13) + loException.Message, ;
9692:                 "FormProduto.ValidarIat")
9693:         ENDTRY
9694:         RETURN loc_lSucesso
9695:     ENDPROC
9696: 
9697:     PROCEDURE TxtIatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9698:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9699:             THIS.ValidarIat()
9700:         ENDIF
9701:     ENDPROC
9702: 
9703:     *-- Combo IPI (ipis): When - edicao somente em INCLUIR/ALTERAR
9704:     PROCEDURE CboIpiWhen()
9705:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9706:     ENDPROC
9707: 
9708:     *-- Aliquota IPI (nAliqipis): Valid - verifica contra padrao da clf fiscal
9709:     PROCEDURE ValidarAliqIPI(par_nKeyCode, par_nShiftAltCtrl)
9710:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9711:             RETURN
9712:         ENDIF
9713:         LOCAL loc_oPg, loc_cClf, loc_nAliq, loc_nAliqRef, loc_nRet, loException
9714:         TRY
9715:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9716:             IF !PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5) OR !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9717:                 RETURN
9718:             ENDIF
9719:             loc_nAliq = loc_oPg.txt_4c_AliqIPI.Value
9720:             loc_cClf  = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9721:             IF EMPTY(loc_cClf) OR loc_nAliq = 0
9722:                 RETURN
9723:             ENDIF
9724:             loc_nRet = SQLEXEC(gnConnHandle, ;
9725:                 "SELECT aipis FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9726:                 "cursor_4c_ClfAliq")
9727:             IF loc_nRet > 0 AND USED("cursor_4c_ClfAliq") AND !EOF("cursor_4c_ClfAliq")
9728:                 loc_nAliqRef = cursor_4c_ClfAliq.aipis
9729:                 IF loc_nAliqRef > 0 AND ABS(loc_nAliq - loc_nAliqRef) > 0.001
9730:                     MsgAviso("Al" + CHR(237) + "quota IPI informada (" + ;
9731:                         TRANSFORM(loc_nAliq) + "%) difere da padr" + CHR(227) + ;
9732:                         "o da classifica" + CHR(231) + CHR(227) + "o fiscal (" + ;
9733:                         TRANSFORM(loc_nAliqRef) + "%).")
9734:                 ENDIF
9735:             ENDIF
9736:             IF USED("cursor_4c_ClfAliq")
9737:                 USE IN cursor_4c_ClfAliq
9738:             ENDIF
9739:         CATCH TO loException
9740:             IF USED("cursor_4c_ClfAliq")
9741:                 USE IN cursor_4c_ClfAliq
9742:             ENDIF
9743:             MostrarErro("Erro ao validar Al" + CHR(237) + "quota IPI:" + ;
9744:                 CHR(13) + loException.Message, "FormProduto.ValidarAliqIPI")
9745:         ENDTRY
9746:     ENDPROC
9747: 
9748:     PROCEDURE TxtAliqIPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9749:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9750:             THIS.ValidarAliqIPI()
9751:         ENDIF
9752:     ENDPROC
9753: 
9754:     *-- Extensao IPI (extipi): When - habilitado quando clf fiscal tem ipiprods='S'
9755:     PROCEDURE TxtExtipipWhen()
9756:         LOCAL loc_oPg, loc_cClf, loc_nRet, loc_lPermite, loException
9757:         loc_lPermite = .F.
9758:         TRY
9759:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9760:                 loc_lResultado = .F.
9761:             ENDIF
9762:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9763:             IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9764:                 loc_lResultado = .F.
9765:             ENDIF
9766:             loc_cClf = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9767:             IF EMPTY(loc_cClf)
9768:                 loc_lResultado = .F.
9769:             ENDIF
9770:             loc_nRet = SQLEXEC(gnConnHandle, ;
9771:                 "SELECT ipiprods FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
9772:                 "cursor_4c_ClfIpiProd")
9773:             IF loc_nRet > 0 AND USED("cursor_4c_ClfIpiProd") AND !EOF("cursor_4c_ClfIpiProd")
9774:                 loc_lPermite = (ALLTRIM(cursor_4c_ClfIpiProd.ipiprods) = "S")
9775:             ENDIF
9776:             IF USED("cursor_4c_ClfIpiProd")
9777:                 USE IN cursor_4c_ClfIpiProd
9778:             ENDIF
9779:         CATCH TO loException
9780:             IF USED("cursor_4c_ClfIpiProd")
9781:                 USE IN cursor_4c_ClfIpiProd
9782:             ENDIF
9783:         ENDTRY
9784:         RETURN loc_lPermite
9785:     ENDPROC
9786: 
9787:     *-- Botao Descricao Fiscal: Click - gera descricao fiscal via fGerDescFis
9788:     PROCEDURE CmdBtnDescFisClick()
9789:         LOCAL loc_oPg, loc_cCpros, loc_cDescFis, loc_oPg1, loException
9790:         TRY
9791:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9792:                 RETURN
9793:             ENDIF
9794:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9795:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9796:             IF EMPTY(loc_cCpros)
9797:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9798:                 IF PEMSTATUS(loc_oPg1, "txt_4c_Cpros", 5)
9799:                     loc_cCpros = ALLTRIM(loc_oPg1.txt_4c_Cpros.Value)
9800:                 ENDIF
9801:             ENDIF
9802:             IF EMPTY(loc_cCpros)
9803:                 MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.")
9804:                 RETURN
9805:             ENDIF
9806:             loc_cDescFis = fGerDescFis(0, loc_cCpros, go_4c_Sistema.cCodEmpresa, .F.)
9807:             IF !EMPTY(ALLTRIM(loc_cDescFis))
9808:                 IF PEMSTATUS(loc_oPg, "obj_4c_Mgetdescfi", 5)
9809:                     loc_oPg.obj_4c_Mgetdescfi.Value = loc_cDescFis
9810:                 ENDIF
9811:                 THIS.this_oBusinessObject.this_mDescfis = loc_cDescFis
9812:             ENDIF
9813:         CATCH TO loException
9814:             MostrarErro("Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal:" + ;
9815:                 CHR(13) + loException.Message, "FormProduto.CmdBtnDescFisClick")
9816:         ENDTRY
9817:     ENDPROC
9818: 
9819:     *-- Metal (metals): Valid - lookup SigCdMtl WHERE tipos='M'
9820:     PROCEDURE ValidarMetal(par_nKeyCode, par_nShiftAltCtrl)
9821:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9822:             RETURN
9823:         ENDIF
9824:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9825:         TRY
9826:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9827:             IF !PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
9828:                 RETURN
9829:             ENDIF
9830:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
9831:             IF EMPTY(loc_cCod)
9832:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
9833:                     loc_oPg.txt_4c_DesMetal.Value = ""
9834:                 ENDIF
9835:                 RETURN
9836:             ENDIF
9837:             loc_nRet = SQLEXEC(gnConnHandle, ;
9838:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9839:                 " AND tipos = 'M'", ;
9840:                 "cursor_4c_MetalBusca")
9841:             IF loc_nRet > 0 AND USED("cursor_4c_MetalBusca") AND !EOF("cursor_4c_MetalBusca")
9842:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
9843:                     loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(cursor_4c_MetalBusca.descs)
9844:                 ENDIF
9845:                 IF USED("cursor_4c_MetalBusca")
9846:                     USE IN cursor_4c_MetalBusca
9847:                 ENDIF
9848:             ELSE
9849:                 IF USED("cursor_4c_MetalBusca")
9850:                     USE IN cursor_4c_MetalBusca
9851:                 ENDIF
9852:                 THIS.AbrirBuscaMetal()
9853:             ENDIF
9854:         CATCH TO loException
9855:             IF USED("cursor_4c_MetalBusca")
9856:                 USE IN cursor_4c_MetalBusca
9857:             ENDIF
9858:             MostrarErro("Erro ao validar Metal:" + CHR(13) + loException.Message, ;
9859:                 "FormProduto.ValidarMetal")
9860:         ENDTRY
9861:     ENDPROC
9862: 
9863:     PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9864:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9865:             THIS.ValidarMetal()
9866:         ENDIF
9867:     ENDPROC
9868: 
9869:     *-- Teor (teors): Valid - lookup SigCdMtl WHERE tipos<>'M'
9870:     PROCEDURE ValidarTeor(par_nKeyCode, par_nShiftAltCtrl)
9871:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9872:             RETURN
9873:         ENDIF
9874:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9875:         TRY
9876:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9877:             IF !PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
9878:                 RETURN
9879:             ENDIF
9880:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
9881:             IF EMPTY(loc_cCod)
9882:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
9883:                     loc_oPg.txt_4c_DesTeor.Value = ""
9884:                 ENDIF
9885:                 RETURN
9886:             ENDIF
9887:             loc_nRet = SQLEXEC(gnConnHandle, ;
9888:                 "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
9889:                 " AND tipos <> 'M'", ;
9890:                 "cursor_4c_TeorBusca")
9891:             IF loc_nRet > 0 AND USED("cursor_4c_TeorBusca") AND !EOF("cursor_4c_TeorBusca")
9892:                 IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
9893:                     loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(cursor_4c_TeorBusca.descs)
9894:                 ENDIF
9895:                 IF USED("cursor_4c_TeorBusca")
9896:                     USE IN cursor_4c_TeorBusca
9897:                 ENDIF
9898:             ELSE
9899:                 IF USED("cursor_4c_TeorBusca")
9900:                     USE IN cursor_4c_TeorBusca
9901:                 ENDIF
9902:                 THIS.AbrirBuscaTeor()
9903:             ENDIF
9904:         CATCH TO loException
9905:             IF USED("cursor_4c_TeorBusca")
9906:                 USE IN cursor_4c_TeorBusca
9907:             ENDIF
9908:             MostrarErro("Erro ao validar Teor:" + CHR(13) + loException.Message, ;
9909:                 "FormProduto.ValidarTeor")
9910:         ENDTRY
9911:     ENDPROC
9912: 
9913:     PROCEDURE TxtTeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9914:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9915:             THIS.ValidarTeor()
9916:         ENDIF
9917:     ENDPROC
9918: 
9919:     *-- Moeda Valor (moedas): Valid - lookup SigCdMoe
9920:     PROCEDURE ValidarMvalorFiscal(par_nKeyCode, par_nShiftAltCtrl)
9921:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9922:             RETURN
9923:         ENDIF
9924:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
9925:         TRY
9926:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9927:             IF !PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
9928:                 RETURN
9929:             ENDIF
9930:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
9931:             IF EMPTY(loc_cCod)
9932:                 RETURN
9933:             ENDIF
9934:             loc_nRet = SQLEXEC(gnConnHandle, ;
9935:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCod), ;
9936:                 "cursor_4c_MoeFiscalBusca")
9937:             IF loc_nRet > 0 AND USED("cursor_4c_MoeFiscalBusca") AND !EOF("cursor_4c_MoeFiscalBusca")
9938:                 IF USED("cursor_4c_MoeFiscalBusca")
9939:                     USE IN cursor_4c_MoeFiscalBusca
9940:                 ENDIF
9941:             ELSE
9942:                 IF USED("cursor_4c_MoeFiscalBusca")
9943:                     USE IN cursor_4c_MoeFiscalBusca
9944:                 ENDIF
9945:                 THIS.AbrirBuscaMvalorFiscal()
9946:             ENDIF
9947:         CATCH TO loException
9948:             IF USED("cursor_4c_MoeFiscalBusca")
9949:                 USE IN cursor_4c_MoeFiscalBusca
9950:             ENDIF
9951:             MostrarErro("Erro ao validar Moeda Valor:" + CHR(13) + loException.Message, ;
9952:                 "FormProduto.ValidarMvalorFiscal")
9953:         ENDTRY
9954:     ENDPROC
9955: 
9956:     PROCEDURE TxtMvalorFiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9957:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9958:             THIS.ValidarMvalorFiscal()
9959:         ENDIF
9960:     ENDPROC
9961: 
9962:     *-- Centro de Custo: Grupo (gruccus): Valid
9963:     PROCEDURE TxtGruccusValid()
9964:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
9965:             RETURN
9966:         ENDIF
9967:         LOCAL loc_oPg, loc_cGrp, loException
9968:         TRY
9969:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9970:                 RETURN
9971:             ENDIF
9972:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9973:             IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
9974:                 RETURN
9975:             ENDIF
9976:             loc_cGrp = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
9977:             IF EMPTY(loc_cGrp)
9978:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
9979:                     loc_oPg.txt_4c__dgruccus.Value = ""
9980:                 ENDIF
9981:                 RETURN
9982:             ENDIF
9983:             fAcessoContab(Usuar, "C", loc_cGrp)
9984:         CATCH TO loException
9985:             MostrarErro("Erro ao validar Grupo CC:" + CHR(13) + loException.Message, ;
9986:                 "FormProduto.TxtGruccusValid")
9987:         ENDTRY
9988:     ENDPROC
9989: 
9990:     PROCEDURE TxtGruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9991:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
9992:             THIS.TxtGruccusValid()
9993:         ENDIF
9994:     ENDPROC
9995: 
9996:     *-- Centro de Custo: Descricao Grupo (dgruccus): When
9997:     PROCEDURE TxtDgruccusWhen()
9998:         LOCAL loc_oPg
9999:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10000:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10001:             RETURN .F.
10002:         ENDIF
10003:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
10004:                EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
10005:     ENDPROC
10006: 
10007:     *-- Centro de Custo: Descricao Grupo (dgruccus): Valid
10008:     PROCEDURE TxtDgruccusValid()
10009:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10010:             RETURN
10011:         ENDIF
10012:         LOCAL loc_oPg, loc_cDesc, loException
10013:         TRY
10014:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10015:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c__dgruccus.Value)
10016:             fAcessoContab(Usuar, "D", loc_cDesc)
10017:         CATCH TO loException
10018:             MostrarErro("Erro ao buscar Descri" + CHR(231) + CHR(227) + "o Grupo CC:" + ;
10019:                 CHR(13) + loException.Message, "FormProduto.TxtDgruccusValid")
10020:         ENDTRY
10021:     ENDPROC
10022: 
10023:     PROCEDURE TxtDgruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10024:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10025:             THIS.TxtDgruccusValid()
10026:         ENDIF
10027:     ENDPROC
10028: 
10029:     *-- Centro de Custo: Conta (contaccus): When
10030:     PROCEDURE TxtContaccusWhen()
10031:         LOCAL loc_oPg
10032:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10033:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10034:             RETURN .F.
10035:         ENDIF
10036:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
10037:                !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
10038:     ENDPROC
10039: 
10040:     *-- Centro de Custo: Conta (contaccus): Valid
10041:     PROCEDURE TxtContaccusValid()
10042:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10043:             RETURN
10044:         ENDIF
10045:         LOCAL loc_oPg, loc_cGrp, loc_cCta, loException
10046:         TRY
10047:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10048:                 RETURN
10049:             ENDIF
10050:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10051:             loc_cGrp = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10052:             loc_cCta = ALLTRIM(loc_oPg.txt_4c__contaccus.Value)
10053:             IF EMPTY(loc_cCta)
10054:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10055:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10056:                 ENDIF
10057:                 RETURN
10058:             ENDIF
10059:             fAcessoContas(Usuar, loc_cGrp, "C", loc_cCta)
10060:         CATCH TO loException
10061:             MostrarErro("Erro ao validar Conta CC:" + CHR(13) + loException.Message, ;
10062:                 "FormProduto.TxtContaccusValid")
10063:         ENDTRY
10064:     ENDPROC
10065: 
10066:     PROCEDURE TxtContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10067:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10068:             THIS.TxtContaccusValid()
10069:         ENDIF
10070:     ENDPROC
10071: 
10072:     *-- Centro de Custo: Descricao Conta (dcontaccus): When
10073:     PROCEDURE TxtDcontaccusWhen()
10074:         LOCAL loc_oPg
10075:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10076:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10077:             RETURN .F.
10078:         ENDIF
10079:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
10080:                !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value)) AND ;
10081:                EMPTY(ALLTRIM(loc_oPg.txt_4c__contaccus.Value))
10082:     ENDPROC
10083: 
10084:     *-- Centro de Custo: Descricao Conta (dcontaccus): Valid
10085:     PROCEDURE TxtDcontaccusValid()
10086:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10087:             RETURN
10088:         ENDIF
10089:         LOCAL loc_oPg, loc_cGrp, loc_cDesc, loException
10090:         TRY
10091:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10092:             loc_cGrp  = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10093:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c__dcontaccus.Value)
10094:             fAcessoContas(Usuar, loc_cGrp, "D", loc_cDesc)
10095:         CATCH TO loException
10096:             MostrarErro("Erro ao buscar Descri" + CHR(231) + CHR(227) + "o Conta CC:" + ;
10097:                 CHR(13) + loException.Message, "FormProduto.TxtDcontaccusValid")
10098:         ENDTRY
10099:     ENDPROC
10100: 
10101:     PROCEDURE TxtDcontaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10102:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
10103:             THIS.TxtDcontaccusValid()
10104:         ENDIF
10105:     ENDPROC
10106: 
10107:     *===========================================================================
10108:     * AbrirBusca* - Helpers de lookup para pgDadosFiscais (Page3)
10109:     *===========================================================================
10110: 
10111:     *-- Classificacao Fiscal (SigCdClf: codigos/descricaos)
10112:     PROCEDURE AbrirBuscaClfiscal()
10113:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10114:         TRY
10115:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10116:             loc_cValAtual = ""
10117:             IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10118:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
10119:             ENDIF
10120:             loc_nRet = SQLEXEC(gnConnHandle, ;
10121:                 "SELECT codigos, descricaos FROM SigCdClf WHERE codigos LIKE " + ;
10122:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10123:                 "cursor_4c_ClfBusca")
10124:             IF loc_nRet <= 0 OR !USED("cursor_4c_ClfBusca") OR EOF("cursor_4c_ClfBusca")
10125:                 IF USED("cursor_4c_ClfBusca")
10126:                     USE IN cursor_4c_ClfBusca
10127:                 ENDIF
10128:                 SQLEXEC(gnConnHandle, ;
10129:                     "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", ;
10130:                     "cursor_4c_ClfBusca")
10131:             ENDIF
10132:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10133:             IF VARTYPE(loc_oBusca) = "O"
10134:                 loc_oBusca.this_cCursorDestino = "cursor_4c_ClfBusca"
10135:                 loc_oBusca.DefinirCursor("cursor_4c_ClfBusca", "codigos", "descricaos", ;
10136:                     "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
10137:                 loc_oBusca.Mostrar()
10138:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10139:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10140:                         loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10141:                     ENDIF
10142:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
10143:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10144:                     ENDIF
10145:                 ENDIF
10146:                 loc_oBusca = .NULL.
10147:             ENDIF
10148:             IF USED("cursor_4c_ClfBusca")
10149:                 USE IN cursor_4c_ClfBusca
10150:             ENDIF
10151:         CATCH TO loException
10152:             IF USED("cursor_4c_ClfBusca")
10153:                 USE IN cursor_4c_ClfBusca
10154:             ENDIF
10155:             MostrarErro("Erro ao buscar Classif. Fiscal:" + CHR(13) + loException.Message, ;
10156:                 "FormProduto.AbrirBuscaClfiscal")
10157:         ENDTRY
10158:     ENDPROC
10159: 
10160:     *-- Origem Mercadoria (SIGCDORG: codigos/descricaos)
10161:     PROCEDURE AbrirBuscaOrigmerc()
10162:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10163:         TRY
10164:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10165:             loc_cValAtual = ""
10166:             IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10167:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
10168:             ENDIF
10169:             loc_nRet = SQLEXEC(gnConnHandle, ;
10170:                 "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos LIKE " + ;
10171:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10172:                 "cursor_4c_OrgBusca")
10173:             IF loc_nRet <= 0 OR !USED("cursor_4c_OrgBusca") OR EOF("cursor_4c_OrgBusca")
10174:                 IF USED("cursor_4c_OrgBusca")
10175:                     USE IN cursor_4c_OrgBusca
10176:                 ENDIF
10177:                 SQLEXEC(gnConnHandle, ;
10178:                     "SELECT codigos, descricaos FROM SIGCDORG ORDER BY codigos", ;
10179:                     "cursor_4c_OrgBusca")
10180:             ENDIF
10181:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10182:             IF VARTYPE(loc_oBusca) = "O"
10183:                 loc_oBusca.this_cCursorDestino = "cursor_4c_OrgBusca"
10184:                 loc_oBusca.DefinirCursor("cursor_4c_OrgBusca", "codigos", "descricaos", ;
10185:                     "Buscar Origem Mercadoria")
10186:                 loc_oBusca.Mostrar()
10187:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10188:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10189:                         loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10190:                     ENDIF
10191:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
10192:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10193:                     ENDIF
10194:                 ENDIF
10195:                 loc_oBusca = .NULL.
10196:             ENDIF
10197:             IF USED("cursor_4c_OrgBusca")
10198:                 USE IN cursor_4c_OrgBusca
10199:             ENDIF
10200:         CATCH TO loException
10201:             IF USED("cursor_4c_OrgBusca")
10202:                 USE IN cursor_4c_OrgBusca
10203:             ENDIF
10204:             MostrarErro("Erro ao buscar Origem Mercadoria:" + CHR(13) + loException.Message, ;
10205:                 "FormProduto.AbrirBuscaOrigmerc")
10206:         ENDTRY
10207:     ENDPROC
10208: 
10209:     *-- Situacao Tributaria ICMS (SIGCDICM: codigos/descricaos)
10210:     PROCEDURE AbrirBuscaSittricm()
10211:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10212:         TRY
10213:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10214:             loc_cValAtual = ""
10215:             IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10216:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
10217:             ENDIF
10218:             loc_nRet = SQLEXEC(gnConnHandle, ;
10219:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10220:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10221:                 "cursor_4c_IcmBusca")
10222:             IF loc_nRet <= 0 OR !USED("cursor_4c_IcmBusca") OR EOF("cursor_4c_IcmBusca")
10223:                 IF USED("cursor_4c_IcmBusca")
10224:                     USE IN cursor_4c_IcmBusca
10225:                 ENDIF
10226:                 SQLEXEC(gnConnHandle, ;
10227:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10228:                     "cursor_4c_IcmBusca")
10229:             ENDIF
10230:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10231:             IF VARTYPE(loc_oBusca) = "O"
10232:                 loc_oBusca.this_cCursorDestino = "cursor_4c_IcmBusca"
10233:                 loc_oBusca.DefinirCursor("cursor_4c_IcmBusca", "codigos", "descricaos", ;
10234:                     "Buscar Sit. Tributaria ICMS")
10235:                 loc_oBusca.Mostrar()
10236:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10237:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10238:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10239:                     ENDIF
10240:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
10241:                         loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10242:                     ENDIF
10243:                 ENDIF
10244:                 loc_oBusca = .NULL.
10245:             ENDIF
10246:             IF USED("cursor_4c_IcmBusca")
10247:                 USE IN cursor_4c_IcmBusca
10248:             ENDIF
10249:         CATCH TO loException
10250:             IF USED("cursor_4c_IcmBusca")
10251:                 USE IN cursor_4c_IcmBusca
10252:             ENDIF
10253:             MostrarErro("Erro ao buscar Sit. Tributaria ICMS:" + CHR(13) + loException.Message, ;
10254:                 "FormProduto.AbrirBuscaSittricm")
10255:         ENDTRY
10256:     ENDPROC
10257: 
10258:     *-- Codigo Servico Fiscal (SIGCDICM: codigos/descricaos)
10259:     PROCEDURE AbrirBuscaCodServsFiscal()
10260:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10261:         TRY
10262:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10263:             loc_cValAtual = ""
10264:             IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10265:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
10266:             ENDIF
10267:             loc_nRet = SQLEXEC(gnConnHandle, ;
10268:                 "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
10269:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10270:                 "cursor_4c_CodServBusca")
10271:             IF loc_nRet <= 0 OR !USED("cursor_4c_CodServBusca") OR EOF("cursor_4c_CodServBusca")
10272:                 IF USED("cursor_4c_CodServBusca")
10273:                     USE IN cursor_4c_CodServBusca
10274:                 ENDIF
10275:                 SQLEXEC(gnConnHandle, ;
10276:                     "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
10277:                     "cursor_4c_CodServBusca")
10278:             ENDIF
10279:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10280:             IF VARTYPE(loc_oBusca) = "O"
10281:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CodServBusca"
10282:                 loc_oBusca.DefinirCursor("cursor_4c_CodServBusca", "codigos", "descricaos", ;
10283:                     "Buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal")
10284:                 loc_oBusca.Mostrar()
10285:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10286:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
10287:                         loc_oPg.txt_4c_Codigo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10288:                     ENDIF
10289:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
10290:                         loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10291:                     ENDIF
10292:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
10293:                         loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10294:                     ENDIF
10295:                 ENDIF
10296:                 loc_oBusca = .NULL.
10297:             ENDIF
10298:             IF USED("cursor_4c_CodServBusca")
10299:                 USE IN cursor_4c_CodServBusca
10300:             ENDIF
10301:         CATCH TO loException
10302:             IF USED("cursor_4c_CodServBusca")
10303:                 USE IN cursor_4c_CodServBusca
10304:             ENDIF
10305:             MostrarErro("Erro ao buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal:" + ;
10306:                 CHR(13) + loException.Message, "FormProduto.AbrirBuscaCodServsFiscal")
10307:         ENDTRY
10308:     ENDPROC
10309: 
10310:     *-- Tipo Tributacao (SigPrTri: tipos/descs)
10311:     PROCEDURE AbrirBuscaTpTrib()
10312:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10313:         TRY
10314:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10315:             loc_cValAtual = ""
10316:             IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10317:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
10318:             ENDIF
10319:             loc_nRet = SQLEXEC(gnConnHandle, ;
10320:                 "SELECT tipos, descs FROM SigPrTri WHERE tipos LIKE " + ;
10321:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY tipos", ;
10322:                 "cursor_4c_TpTribBusca")
10323:             IF loc_nRet <= 0 OR !USED("cursor_4c_TpTribBusca") OR EOF("cursor_4c_TpTribBusca")
10324:                 IF USED("cursor_4c_TpTribBusca")
10325:                     USE IN cursor_4c_TpTribBusca
10326:                 ENDIF
10327:                 SQLEXEC(gnConnHandle, ;
10328:                     "SELECT tipos, descs FROM SigPrTri ORDER BY tipos", ;
10329:                     "cursor_4c_TpTribBusca")
10330:             ENDIF
10331:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10332:             IF VARTYPE(loc_oBusca) = "O"
10333:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TpTribBusca"
10334:                 loc_oBusca.DefinirCursor("cursor_4c_TpTribBusca", "tipos", "descs", ;
10335:                     "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10336:                 loc_oBusca.Mostrar()
10337:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10338:                     IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
10339:                         loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10340:                     ENDIF
10341:                 ENDIF
10342:                 loc_oBusca = .NULL.
10343:             ENDIF
10344:             IF USED("cursor_4c_TpTribBusca")
10345:                 USE IN cursor_4c_TpTribBusca
10346:             ENDIF
10347:         CATCH TO loException
10348:             IF USED("cursor_4c_TpTribBusca")
10349:                 USE IN cursor_4c_TpTribBusca
10350:             ENDIF
10351:             MostrarErro("Erro ao buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o:" + ;
10352:                 CHR(13) + loException.Message, "FormProduto.AbrirBuscaTpTrib")
10353:         ENDTRY
10354:     ENDPROC
10355: 
10356:     *-- Metal (SigCdMtl: codigos/descs WHERE tipos='M')
10357:     PROCEDURE AbrirBuscaMetal()
10358:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10359:         TRY
10360:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10361:             loc_cValAtual = ""
10362:             IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10363:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
10364:             ENDIF
10365:             loc_nRet = SQLEXEC(gnConnHandle, ;
10366:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10367:                 "WHERE tipos = 'M' AND codigos LIKE " + ;
10368:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10369:                 "cursor_4c_MetalBusca")
10370:             IF loc_nRet <= 0 OR !USED("cursor_4c_MetalBusca") OR EOF("cursor_4c_MetalBusca")
10371:                 IF USED("cursor_4c_MetalBusca")
10372:                     USE IN cursor_4c_MetalBusca
10373:                 ENDIF
10374:                 SQLEXEC(gnConnHandle, ;
10375:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos = 'M' ORDER BY codigos", ;
10376:                     "cursor_4c_MetalBusca")
10377:             ENDIF
10378:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10379:             IF VARTYPE(loc_oBusca) = "O"
10380:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MetalBusca"
10381:                 loc_oBusca.DefinirCursor("cursor_4c_MetalBusca", "codigos", "descs", "Buscar Metal")
10382:                 loc_oBusca.Mostrar()
10383:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10384:                     IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
10385:                         loc_oPg.txt_4c_Metal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10386:                     ENDIF
10387:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
10388:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10389:                     ENDIF
10390:                 ENDIF
10391:                 loc_oBusca = .NULL.
10392:             ENDIF
10393:             IF USED("cursor_4c_MetalBusca")
10394:                 USE IN cursor_4c_MetalBusca
10395:             ENDIF
10396:         CATCH TO loException
10397:             IF USED("cursor_4c_MetalBusca")
10398:                 USE IN cursor_4c_MetalBusca
10399:             ENDIF
10400:             MostrarErro("Erro ao buscar Metal:" + CHR(13) + loException.Message, ;
10401:                 "FormProduto.AbrirBuscaMetal")
10402:         ENDTRY
10403:     ENDPROC
10404: 
10405:     *-- Teor (SigCdMtl: codigos/descs WHERE tipos<>'M')
10406:     PROCEDURE AbrirBuscaTeor()
10407:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10408:         TRY
10409:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10410:             loc_cValAtual = ""
10411:             IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10412:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
10413:             ENDIF
10414:             loc_nRet = SQLEXEC(gnConnHandle, ;
10415:                 "SELECT codigos, descs FROM SigCdMtl " + ;
10416:                 "WHERE tipos <> 'M' AND codigos LIKE " + ;
10417:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
10418:                 "cursor_4c_TeorBusca")
10419:             IF loc_nRet <= 0 OR !USED("cursor_4c_TeorBusca") OR EOF("cursor_4c_TeorBusca")
10420:                 IF USED("cursor_4c_TeorBusca")
10421:                     USE IN cursor_4c_TeorBusca
10422:                 ENDIF
10423:                 SQLEXEC(gnConnHandle, ;
10424:                     "SELECT codigos, descs FROM SigCdMtl WHERE tipos <> 'M' ORDER BY codigos", ;
10425:                     "cursor_4c_TeorBusca")
10426:             ENDIF
10427:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10428:             IF VARTYPE(loc_oBusca) = "O"
10429:                 loc_oBusca.this_cCursorDestino = "cursor_4c_TeorBusca"
10430:                 loc_oBusca.DefinirCursor("cursor_4c_TeorBusca", "codigos", "descs", "Buscar Teor")
10431:                 loc_oBusca.Mostrar()
10432:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10433:                     IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
10434:                         loc_oPg.txt_4c_Teor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10435:                     ENDIF
10436:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
10437:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
10438:                     ENDIF
10439:                 ENDIF
10440:                 loc_oBusca = .NULL.
10441:             ENDIF
10442:             IF USED("cursor_4c_TeorBusca")
10443:                 USE IN cursor_4c_TeorBusca
10444:             ENDIF
10445:         CATCH TO loException
10446:             IF USED("cursor_4c_TeorBusca")
10447:                 USE IN cursor_4c_TeorBusca
10448:             ENDIF
10449:             MostrarErro("Erro ao buscar Teor:" + CHR(13) + loException.Message, ;
10450:                 "FormProduto.AbrirBuscaTeor")
10451:         ENDTRY
10452:     ENDPROC
10453: 
10454:     *-- Moeda Valor (SigCdMoe: cmoeds/dmoeds)
10455:     PROCEDURE AbrirBuscaMvalorFiscal()
10456:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
10457:         TRY
10458:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
10459:             loc_cValAtual = ""
10460:             IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10461:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
10462:             ENDIF
10463:             loc_nRet = SQLEXEC(gnConnHandle, ;
10464:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes LIKE " + ;
10465:                 EscaparSQL(loc_cValAtual + "%") + " ORDER BY cmoes", ;
10466:                 "cursor_4c_MoeFiscalBusca")
10467:             IF loc_nRet <= 0 OR !USED("cursor_4c_MoeFiscalBusca") OR EOF("cursor_4c_MoeFiscalBusca")
10468:                 IF USED("cursor_4c_MoeFiscalBusca")
10469:                     USE IN cursor_4c_MoeFiscalBusca
10470:                 ENDIF
10471:                 SQLEXEC(gnConnHandle, ;
10472:                     "SELECT cmoes, dmoes FROM SigCdMoe ORDER BY cmoes", ;
10473:                     "cursor_4c_MoeFiscalBusca")
10474:             ENDIF
10475:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10476:             IF VARTYPE(loc_oBusca) = "O"
10477:                 loc_oBusca.this_cCursorDestino = "cursor_4c_MoeFiscalBusca"
10478:                 loc_oBusca.DefinirCursor("cursor_4c_MoeFiscalBusca", "cmoes", "dmoes", ;
10479:                     "Buscar Moeda")
10480:                 loc_oBusca.Mostrar()
10481:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
10482:                     IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
10483:                         loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
10484:                     ENDIF
10485:                 ENDIF
10486:                 loc_oBusca = .NULL.
10487:             ENDIF
10488:             IF USED("cursor_4c_MoeFiscalBusca")
10489:                 USE IN cursor_4c_MoeFiscalBusca
10490:             ENDIF
10491:         CATCH TO loException
10492:             IF USED("cursor_4c_MoeFiscalBusca")
10493:                 USE IN cursor_4c_MoeFiscalBusca
10494:             ENDIF
10495:             MostrarErro("Erro ao buscar Moeda:" + CHR(13) + loException.Message, ;
10496:                 "FormProduto.AbrirBuscaMvalorFiscal")
10497:         ENDTRY
10498:     ENDPROC
10499: 
10500:     *===========================================================================
10501:     * ConfigurarPgpgDesigner - Configura Page7 "Designer" do pgf_4c_Dados
10502:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner
10503:     *===========================================================================
10504:     PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPg)
10505:         LOCAL loc_oPg, loc_oGrid, loc_oErro
10506:         TRY
10507:             loc_oPg = par_oPg
10508: 
10509:             *-- Cursors placeholder (preenchidos pelo BO ao carregar produto)
10510:             IF !USED("cursor_4c_GrdDesigner")
10511:                 SET NULL ON
10512:                 CREATE CURSOR cursor_4c_GrdDesigner ( ;
10513:                     dtini D, dtfim D, usuarios C(10), codcads C(10))
10514:                 SET NULL OFF
10515:             ENDIF
10516:             IF !USED("cursor_4c_GrdArquivos")
10517:                 SET NULL ON
10518:                 CREATE CURSOR cursor_4c_GrdArquivos (arqnome C(200))
10519:                 SET NULL OFF
10520:             ENDIF
10521:             IF !USED("crTarefas")
10522:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10523:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
10524:                     SQLEXEC(gnConnHandle, ;
10525:                         "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10526:                         "FROM SigCdCad ORDER BY codcads", ;
10527:                         "crTarefas")
10528:                 ENDIF
10529:             ENDIF
10530: 
10531:             *-- grdDesigner: grade historico de designer (4 colunas)
10532:             *-- Original: top=145, left=10, width=495, height=180
10533:             loc_oPg.AddObject("grd_4c_GrdDesigner", "Grid")
10534:             WITH loc_oPg.grd_4c_GrdDesigner
10535:                 .Top        = 145
10536:                 .Left       = 10
10537:                 .Width      = 495
10538:                 .Height     = 180
10539:                 .FontName   = "Tahoma"
10540:                 .FontSize   = 8
10541:                 .RecordMark = .F.
10542:                 .RowHeight  = 16
10543:                 .ScrollBars = 2
10544:                 .TabStop    = .F.

*-- Linhas 10575 a 10618:
10575:             loc_oGrid.Column4.Movable         = .F.
10576:             loc_oGrid.Column4.Resizable       = .F.
10577:             loc_oGrid.Column4.Header1.Caption = "Tarefa"
10578:             BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdDesignerCol4TarefaValid")
10579: 
10580:             *-- Say31: label "Observacao da Tarefa"
10581:             *-- Original: top=129, left=583, width=126, height=15
10582:             loc_oPg.AddObject("lbl_4c_Label31", "Label")
10583:             WITH loc_oPg.lbl_4c_Label31
10584:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
10585:                 .Top       = 129
10586:                 .Left      = 583
10587:                 .Width     = 126
10588:                 .Height    = 15
10589:                 .FontName  = "Tahoma"
10590:                 .FontSize  = 8
10591:                 .BackStyle = 0
10592:                 .ForeColor = RGB(90, 90, 90)
10593:                 .Visible   = .T.
10594:             ENDWITH
10595: 
10596:             *-- getObsTarefas: editbox (fwmemo) observacao da tarefa
10597:             *-- Original: top=145, left=584, width=407, height=113
10598:             loc_oPg.AddObject("obj_4c_GetObsTarefas", "EditBox")
10599:             WITH loc_oPg.obj_4c_GetObsTarefas
10600:                 .Top        = 145
10601:                 .Left       = 584
10602:                 .Width      = 407
10603:                 .Height     = 113
10604:                 .FontName   = "Tahoma"
10605:                 .FontSize   = 8
10606:                 .ScrollBars = 2
10607:                 .ReadOnly   = .F.
10608:                 .Visible    = .T.
10609:             ENDWITH
10610: 
10611:             *-- btnIniTarefa: botao Inicio de Tarefa
10612:             *-- Original: top=146, left=509, width=42, height=42
10613:             loc_oPg.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
10614:             WITH loc_oPg.cmd_4c_BtnIniTarefa
10615:                 .Caption       = "IN"
10616:                 .Top           = 146
10617:                 .Left          = 509
10618:                 .Width         = 42

*-- Linhas 10626 a 10689:
10626:                 .MousePointer  = 15
10627:                 .Visible       = .T.
10628:             ENDWITH
10629:             BINDEVENT(loc_oPg.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
10630: 
10631:             *-- btnFimTarefa: botao Fim de Tarefa
10632:             *-- Original: top=188, left=509, width=42, height=42
10633:             loc_oPg.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
10634:             WITH loc_oPg.cmd_4c_BtnFimTarefa
10635:                 .Caption       = "FI"
10636:                 .Top           = 188
10637:                 .Left          = 509
10638:                 .Width         = 42
10639:                 .Height        = 42
10640:                 .FontName      = "Tahoma"
10641:                 .FontSize      = 8
10642:                 .FontBold      = .T.
10643:                 .BackColor     = RGB(255, 255, 255)
10644:                 .Themes        = .F.
10645:                 .SpecialEffect = 0
10646:                 .MousePointer  = 15
10647:                 .Visible       = .T.
10648:             ENDWITH
10649:             BINDEVENT(loc_oPg.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")
10650: 
10651:             *-- Say1: label "Inspiracao"
10652:             *-- Original: top=265, left=583, width=62, height=15
10653:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
10654:             WITH loc_oPg.lbl_4c_Label1
10655:                 .Caption   = "Inspira" + CHR(231) + CHR(227) + "o"
10656:                 .Top       = 265
10657:                 .Left      = 583
10658:                 .Width     = 62
10659:                 .Height    = 15
10660:                 .FontName  = "Tahoma"
10661:                 .FontSize  = 8
10662:                 .BackStyle = 0
10663:                 .ForeColor = RGB(90, 90, 90)
10664:                 .Visible   = .T.
10665:             ENDWITH
10666: 
10667:             *-- getObsInsp: editbox (fwmemo) observacao de inspiracao
10668:             *-- Original: top=281, left=584, width=407, height=113
10669:             loc_oPg.AddObject("obj_4c_GetObsInsp", "EditBox")
10670:             WITH loc_oPg.obj_4c_GetObsInsp
10671:                 .Top        = 281
10672:                 .Left       = 584
10673:                 .Width      = 407
10674:                 .Height     = 113
10675:                 .FontName   = "Tahoma"
10676:                 .FontSize   = 8
10677:                 .ScrollBars = 2
10678:                 .ReadOnly   = .F.
10679:                 .Visible    = .T.
10680:             ENDWITH
10681: 
10682:             *-- grdArquivos: grade de arquivos do designer (1 coluna)
10683:             *-- Original: top=334, left=10, width=495, height=164
10684:             loc_oPg.AddObject("grd_4c_GrdArquivos", "Grid")
10685:             WITH loc_oPg.grd_4c_GrdArquivos
10686:                 .Top        = 334
10687:                 .Left       = 10
10688:                 .Width      = 495
10689:                 .Height     = 164

*-- Linhas 10722 a 10805:
10722:                 .MousePointer  = 15
10723:                 .Visible       = .T.
10724:             ENDWITH
10725:             BINDEVENT(loc_oPg.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
10726: 
10727:             *-- btnExcArqs: botao Excluir Arquivo selecionado
10728:             *-- Original: top=377, left=509, width=42, height=42
10729:             loc_oPg.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
10730:             WITH loc_oPg.cmd_4c_BtnExcArqs
10731:                 .Caption       = "-"
10732:                 .Top           = 377
10733:                 .Left          = 509
10734:                 .Width         = 42
10735:                 .Height        = 42
10736:                 .FontName      = "Tahoma"
10737:                 .FontSize      = 12
10738:                 .FontBold      = .T.
10739:                 .BackColor     = RGB(255, 255, 255)
10740:                 .Themes        = .F.
10741:                 .SpecialEffect = 0
10742:                 .MousePointer  = 15
10743:                 .Visible       = .T.
10744:             ENDWITH
10745:             BINDEVENT(loc_oPg.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")
10746: 
10747:             *-- btnOpnArqs: botao Abrir Arquivo selecionado
10748:             *-- Original: top=419, left=509, width=42, height=42
10749:             loc_oPg.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
10750:             WITH loc_oPg.cmd_4c_BtnOpnArqs
10751:                 .Caption       = "AB"
10752:                 .Top           = 419
10753:                 .Left          = 509
10754:                 .Width         = 42
10755:                 .Height        = 42
10756:                 .FontName      = "Tahoma"
10757:                 .FontSize      = 8
10758:                 .FontBold      = .T.
10759:                 .BackColor     = RGB(255, 255, 255)
10760:                 .Themes        = .F.
10761:                 .SpecialEffect = 0
10762:                 .MousePointer  = 15
10763:                 .Visible       = .T.
10764:             ENDWITH
10765:             BINDEVENT(loc_oPg.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")
10766: 
10767:             *-- Shape1: retangulo decorativo sobre area de imagem
10768:             *-- Original: top=400, left=584, width=407, height=202
10769:             loc_oPg.AddObject("shp_4c_Shape1", "Shape")
10770:             WITH loc_oPg.shp_4c_Shape1
10771:                 .Top     = 400
10772:                 .Left    = 584
10773:                 .Width   = 407
10774:                 .Height  = 202
10775:                 .Visible = .T.
10776:             ENDWITH
10777: 
10778:             *-- imgArqJpg: imagem do arquivo selecionado (inicialmente oculta)
10779:             *-- Original: top=402, left=586, width=403, height=198, visible=false
10780:             loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
10781:             WITH loc_oPg.img_4c_ImgArqJpg
10782:                 .Top     = 402
10783:                 .Left    = 586
10784:                 .Width   = 403
10785:                 .Height  = 198
10786:                 .Visible = .F.
10787:             ENDWITH
10788: 
10789:             *-- Say19: label secao "Dados do Lancamento"
10790:             *-- Original: top=504, left=18, width=127, height=15
10791:             loc_oPg.AddObject("lbl_4c_Label19", "Label")
10792:             WITH loc_oPg.lbl_4c_Label19
10793:                 .Caption   = "Dados do Lan" + CHR(231) + "amento"
10794:                 .Top       = 504
10795:                 .Left      = 18
10796:                 .Width     = 127
10797:                 .Height    = 15
10798:                 .FontName  = "Tahoma"
10799:                 .FontSize  = 8
10800:                 .FontBold  = .T.
10801:                 .BackStyle = 0
10802:                 .ForeColor = RGB(90, 90, 90)
10803:                 .Visible   = .T.
10804:             ENDWITH
10805: 

*-- Linhas 10877 a 11481:
10877:                 .SpecialEffect = 1
10878:                 .Visible       = .T.
10879:             ENDWITH
10880:             BINDEVENT(loc_oPg.txt_4c_DesLacto, "KeyPress", THIS, "ValidarDesLacto")
10881: 
10882:             *-- Say5: label "Criado por :"
10883:             *-- Original: top=580, left=56, width=59, height=15
10884:             loc_oPg.AddObject("lbl_4c_Label5", "Label")
10885:             WITH loc_oPg.lbl_4c_Label5
10886:                 .Caption   = "Criado por :"
10887:                 .Top       = 580
10888:                 .Left      = 56
10889:                 .Width     = 59
10890:                 .Height    = 15
10891:                 .FontName  = "Tahoma"
10892:                 .FontSize  = 8
10893:                 .BackStyle = 0
10894:                 .ForeColor = RGB(90, 90, 90)
10895:                 .Visible   = .T.
10896:             ENDWITH
10897: 
10898:             *-- GetCriaLacto: textbox usuario criador (fwget -> SigCdUsu.usuarios)
10899:             *-- Original: top=576, left=118, width=91, height=22
10900:             loc_oPg.AddObject("txt_4c_CriaLacto", "TextBox")
10901:             WITH loc_oPg.txt_4c_CriaLacto
10902:                 .Top           = 576
10903:                 .Left          = 118
10904:                 .Width         = 91
10905:                 .Height        = 22
10906:                 .FontName      = "Tahoma"
10907:                 .FontSize      = 8
10908:                 .Value         = ""
10909:                 .MaxLength     = 10
10910:                 .SpecialEffect = 1
10911:                 .Visible       = .T.
10912:             ENDWITH
10913:             BINDEVENT(loc_oPg.txt_4c_CriaLacto, "KeyPress", THIS, "ValidarCriaLacto")
10914: 
10915:         CATCH TO loc_oErro
10916:             MostrarErro("Erro ao configurar pgDesigner:" + CHR(13) + ;
10917:                 loc_oErro.Message + CHR(13) + ;
10918:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
10919:                 "FormProduto.ConfigurarPgpgDesigner")
10920:         ENDTRY
10921:     ENDPROC
10922: 
10923:     *===========================================================================
10924:     * Handlers de BINDEVENT para pgDesigner (Page7)
10925:     * Todos PUBLIC - requerido pelo BINDEVENT
10926:     *===========================================================================
10927: 
10928:     *-- grdDesigner Column4 (Tarefa/CodCads): Valid - lookup crTarefas por CodCads
10929:     PROCEDURE GrdDesignerCol4TarefaValid()
10930:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10931:             RETURN .T.
10932:         ENDIF
10933:         LOCAL loc_cCodCads, loc_lSucesso, loException
10934:         loc_lSucesso = .T.
10935:         TRY
10936:             IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
10937:                 loc_cCodCads = ALLTRIM(cursor_4c_GrdDesigner.codcads)
10938:                 IF !EMPTY(loc_cCodCads)
10939:                     IF USED("crTarefas")
10940:                         SELECT crTarefas
10941:                         GO TOP
10942:                         LOCATE FOR ALLTRIM(CodCads) = loc_cCodCads
10943:                         IF EOF("crTarefas")
10944:                             THIS.AbrirBuscaTarefaDesigner()
10945:                         ENDIF
10946:                         IF USED("cursor_4c_GrdDesigner")
10947:                             SELECT cursor_4c_GrdDesigner
10948:                         ENDIF
10949:                     ELSE
10950:                         THIS.AbrirBuscaTarefaDesigner()
10951:                     ENDIF
10952:                 ENDIF
10953:             ENDIF
10954:         CATCH TO loException
10955:             MostrarErro("Erro ao validar Tarefa:" + CHR(13) + loException.Message, ;
10956:                 "FormProduto.GrdDesignerCol4TarefaValid")
10957:         ENDTRY
10958:         RETURN loc_lSucesso
10959:     ENDPROC
10960: 
10961:     PROCEDURE AbrirBuscaTarefaDesigner()
10962:         LOCAL loc_oBusca, loc_nRet, loException
10963:         TRY
10964:             IF !USED("crTarefas")
10965:                 CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
10966:                 loc_nRet = SQLEXEC(gnConnHandle, ;
10967:                     "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
10968:                     "FROM SigCdCad ORDER BY codcads", ;
10969:                     "crTarefas")
10970:                 IF loc_nRet <= 0 OR EOF("crTarefas")
10971:                     MsgAviso("Sem tarefas cadastradas para selecionar.")
10972:                     RETURN
10973:                 ENDIF
10974:             ENDIF
10975:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
10976:             IF VARTYPE(loc_oBusca) = "O"
10977:                 loc_oBusca.this_cCursorDestino = "crTarefas"
10978:                 loc_oBusca.DefinirCursor("crTarefas", "CodCads", "DesCads", ;
10979:                     "Selecionar Tarefa")
10980:                 loc_oBusca.Mostrar()
10981:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND ;
10982:                     USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
10983:                     SELECT cursor_4c_GrdDesigner
10984:                     REPLACE cursor_4c_GrdDesigner.codcads WITH ;
10985:                         ALLTRIM(loc_oBusca.cCodigoSelecionado)
10986:                 ENDIF
10987:                 loc_oBusca = .NULL.
10988:             ENDIF
10989:         CATCH TO loException
10990:             MostrarErro("Erro ao buscar Tarefa:" + CHR(13) + loException.Message, ;
10991:                 "FormProduto.AbrirBuscaTarefaDesigner")
10992:         ENDTRY
10993:     ENDPROC
10994: 
10995:     *-- GetDesLacto (txt_4c_DesLacto): Valid - valida usuario desenvolvedor em SigCdUsu
10996:     PROCEDURE ValidarDesLacto(par_nKeyCode, par_nShiftAltCtrl)
10997:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
10998:             RETURN
10999:         ENDIF
11000:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
11001:         TRY
11002:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11003:             loc_cCod = ""
11004:             IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11005:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
11006:             ENDIF
11007:             IF !EMPTY(loc_cCod)
11008:                 loc_nRet = SQLEXEC(gnConnHandle, ;
11009:                     "SELECT usuarios FROM SigCdUsu " + ;
11010:                     "WHERE usuarios = " + EscaparSQL(loc_cCod), ;
11011:                     "cursor_4c_DesLactoBusca")
11012:                 IF loc_nRet > 0 AND USED("cursor_4c_DesLactoBusca") AND !EOF("cursor_4c_DesLactoBusca")
11013:                     IF USED("cursor_4c_DesLactoBusca")
11014:                         USE IN cursor_4c_DesLactoBusca
11015:                     ENDIF
11016:                 ELSE
11017:                     IF USED("cursor_4c_DesLactoBusca")
11018:                         USE IN cursor_4c_DesLactoBusca
11019:                     ENDIF
11020:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11021:                         loc_oPg.txt_4c_DesLacto.Value = ""
11022:                     ENDIF
11023:                     THIS.AbrirBuscaDesLacto()
11024:                 ENDIF
11025:             ENDIF
11026:         CATCH TO loException
11027:             IF USED("cursor_4c_DesLactoBusca")
11028:                 USE IN cursor_4c_DesLactoBusca
11029:             ENDIF
11030:             MostrarErro("Erro ao validar Desenvolvedor:" + CHR(13) + loException.Message, ;
11031:                 "FormProduto.ValidarDesLacto")
11032:         ENDTRY
11033:     ENDPROC
11034: 
11035:     PROCEDURE AbrirBuscaDesLacto()
11036:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
11037:         TRY
11038:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11039:             loc_cValAtual = ""
11040:             IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11041:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
11042:             ENDIF
11043:             loc_nRet = SQLEXEC(gnConnHandle, ;
11044:                 "SELECT usuarios, ncomps FROM SigCdUsu ORDER BY usuarios", ;
11045:                 "cursor_4c_DesLactoBusca")
11046:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11047:             IF VARTYPE(loc_oBusca) = "O"
11048:                 loc_oBusca.this_cCursorDestino = "cursor_4c_DesLactoBusca"
11049:                 loc_oBusca.DefinirCursor("cursor_4c_DesLactoBusca", "usuarios", "ncomps", ;
11050:                     "Selecionar Desenvolvedor")
11051:                 loc_oBusca.Mostrar()
11052:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11053:                     IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
11054:                         loc_oPg.txt_4c_DesLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11055:                     ENDIF
11056:                 ENDIF
11057:                 loc_oBusca = .NULL.
11058:             ENDIF
11059:             IF USED("cursor_4c_DesLactoBusca")
11060:                 USE IN cursor_4c_DesLactoBusca
11061:             ENDIF
11062:         CATCH TO loException
11063:             IF USED("cursor_4c_DesLactoBusca")
11064:                 USE IN cursor_4c_DesLactoBusca
11065:             ENDIF
11066:             MostrarErro("Erro ao buscar Desenvolvedor:" + CHR(13) + loException.Message, ;
11067:                 "FormProduto.AbrirBuscaDesLacto")
11068:         ENDTRY
11069:     ENDPROC
11070: 
11071:     *-- GetCriaLacto (txt_4c_CriaLacto): Valid - valida usuario criador em SigCdUsu
11072:     PROCEDURE ValidarCriaLacto(par_nKeyCode, par_nShiftAltCtrl)
11073:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11074:             RETURN
11075:         ENDIF
11076:         LOCAL loc_oPg, loc_cCod, loc_nRet, loException
11077:         TRY
11078:             loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11079:             loc_cCod = ""
11080:             IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11081:                 loc_cCod = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11082:             ENDIF
11083:             IF !EMPTY(loc_cCod)
11084:                 loc_nRet = SQLEXEC(gnConnHandle, ;
11085:                     "SELECT usuarios FROM SigCdUsu " + ;
11086:                     "WHERE usuarios = " + EscaparSQL(loc_cCod), ;
11087:                     "cursor_4c_CriaLactoBusca")
11088:                 IF loc_nRet > 0 AND USED("cursor_4c_CriaLactoBusca") AND !EOF("cursor_4c_CriaLactoBusca")
11089:                     IF USED("cursor_4c_CriaLactoBusca")
11090:                         USE IN cursor_4c_CriaLactoBusca
11091:                     ENDIF
11092:                 ELSE
11093:                     IF USED("cursor_4c_CriaLactoBusca")
11094:                         USE IN cursor_4c_CriaLactoBusca
11095:                     ENDIF
11096:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11097:                         loc_oPg.txt_4c_CriaLacto.Value = ""
11098:                     ENDIF
11099:                     THIS.AbrirBuscaCriaLacto()
11100:                 ENDIF
11101:             ENDIF
11102:         CATCH TO loException
11103:             IF USED("cursor_4c_CriaLactoBusca")
11104:                 USE IN cursor_4c_CriaLactoBusca
11105:             ENDIF
11106:             MostrarErro("Erro ao validar Criador:" + CHR(13) + loException.Message, ;
11107:                 "FormProduto.ValidarCriaLacto")
11108:         ENDTRY
11109:     ENDPROC
11110: 
11111:     PROCEDURE AbrirBuscaCriaLacto()
11112:         LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
11113:         TRY
11114:             loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11115:             loc_cValAtual = ""
11116:             IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11117:                 loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
11118:             ENDIF
11119:             loc_nRet = SQLEXEC(gnConnHandle, ;
11120:                 "SELECT usuarios, ncomps FROM SigCdUsu ORDER BY usuarios", ;
11121:                 "cursor_4c_CriaLactoBusca")
11122:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
11123:             IF VARTYPE(loc_oBusca) = "O"
11124:                 loc_oBusca.this_cCursorDestino = "cursor_4c_CriaLactoBusca"
11125:                 loc_oBusca.DefinirCursor("cursor_4c_CriaLactoBusca", "usuarios", "ncomps", ;
11126:                     "Selecionar Criador")
11127:                 loc_oBusca.Mostrar()
11128:                 IF !EMPTY(loc_oBusca.cCodigoSelecionado)
11129:                     IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
11130:                         loc_oPg.txt_4c_CriaLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
11131:                     ENDIF
11132:                 ENDIF
11133:                 loc_oBusca = .NULL.
11134:             ENDIF
11135:             IF USED("cursor_4c_CriaLactoBusca")
11136:                 USE IN cursor_4c_CriaLactoBusca
11137:             ENDIF
11138:         CATCH TO loException
11139:             IF USED("cursor_4c_CriaLactoBusca")
11140:                 USE IN cursor_4c_CriaLactoBusca
11141:             ENDIF
11142:             MostrarErro("Erro ao buscar Criador:" + CHR(13) + loException.Message, ;
11143:                 "FormProduto.AbrirBuscaCriaLacto")
11144:         ENDTRY
11145:     ENDPROC
11146: 
11147:     *-- btnIniTarefa: registra inicio de tarefa na linha corrente do grdDesigner
11148:     PROCEDURE BtnIniTarefaClick()
11149:         LOCAL loc_oPg, loException
11150:         TRY
11151:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11152:                 MsgAviso("Habilite Incluir ou Alterar para registrar tarefa.")
11153:             ELSE
11154:                 IF USED("cursor_4c_GrdDesigner")
11155:                     SELECT cursor_4c_GrdDesigner
11156:                     APPEND BLANK
11157:                     REPLACE cursor_4c_GrdDesigner.dtini    WITH DATE()
11158:                     REPLACE cursor_4c_GrdDesigner.usuarios WITH ALLTRIM(gc_4c_UsuarioLogado)
11159:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11160:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11161:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11162:                     ENDIF
11163:                 ENDIF
11164:             ENDIF
11165:         CATCH TO loException
11166:             MostrarErro("Erro ao registrar inicio de tarefa:" + CHR(13) + loException.Message, ;
11167:                 "FormProduto.BtnIniTarefaClick")
11168:         ENDTRY
11169:     ENDPROC
11170: 
11171:     *-- btnFimTarefa: registra data conclusao na linha corrente do grdDesigner
11172:     PROCEDURE BtnFimTarefaClick()
11173:         LOCAL loc_oPg, loException
11174:         TRY
11175:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11176:                 MsgAviso("Habilite Incluir ou Alterar para registrar conclus" + CHR(227) + "o.")
11177:             ELSE
11178:                 IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
11179:                     SELECT cursor_4c_GrdDesigner
11180:                     REPLACE cursor_4c_GrdDesigner.dtfim WITH DATE()
11181:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11182:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
11183:                         loc_oPg.grd_4c_GrdDesigner.Refresh()
11184:                     ENDIF
11185:                 ELSE
11186:                     MsgAviso("Selecione um registro de tarefa para registrar conclus" + CHR(227) + "o.")
11187:                 ENDIF
11188:             ENDIF
11189:         CATCH TO loException
11190:             MostrarErro("Erro ao registrar fim de tarefa:" + CHR(13) + loException.Message, ;
11191:                 "FormProduto.BtnFimTarefaClick")
11192:         ENDTRY
11193:     ENDPROC
11194: 
11195:     *-- btnInsArqs: insere arquivo via dialogo na lista grdArquivos
11196:     PROCEDURE BtnInsArqsClick()
11197:         LOCAL loc_oPg, loc_cArquivo, loException
11198:         TRY
11199:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11200:                 MsgAviso("Habilite Incluir ou Alterar para inserir arquivo.")
11201:             ELSE
11202:                 loc_cArquivo = GETFILE("*", "Selecionar Arquivo")
11203:                 IF !EMPTY(loc_cArquivo) AND USED("cursor_4c_GrdArquivos")
11204:                     SELECT cursor_4c_GrdArquivos
11205:                     APPEND BLANK
11206:                     REPLACE cursor_4c_GrdArquivos.arqnome WITH ALLTRIM(loc_cArquivo)
11207:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11208:                     IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11209:                         loc_oPg.grd_4c_GrdArquivos.Refresh()
11210:                     ENDIF
11211:                 ENDIF
11212:             ENDIF
11213:         CATCH TO loException
11214:             MostrarErro("Erro ao inserir arquivo:" + CHR(13) + loException.Message, ;
11215:                 "FormProduto.BtnInsArqsClick")
11216:         ENDTRY
11217:     ENDPROC
11218: 
11219:     *-- btnExcArqs: exclui arquivo selecionado da lista grdArquivos
11220:     PROCEDURE BtnExcArqsClick()
11221:         LOCAL loc_oPg, loc_lConfirm, loException
11222:         TRY
11223:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11224:                 MsgAviso("Habilite Incluir ou Alterar para excluir arquivo.")
11225:             ELSE
11226:                 IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
11227:                     loc_lConfirm = MsgConfirma("Confirma exclus" + CHR(227) + "o do arquivo selecionado?")
11228:                     IF loc_lConfirm
11229:                         SELECT cursor_4c_GrdArquivos
11230:                         DELETE
11231:                         PACK
11232:                         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11233:                         IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
11234:                             loc_oPg.grd_4c_GrdArquivos.Refresh()
11235:                         ENDIF
11236:                     ENDIF
11237:                 ELSE
11238:                     MsgAviso("Selecione um arquivo para excluir.")
11239:                 ENDIF
11240:             ENDIF
11241:         CATCH TO loException
11242:             MostrarErro("Erro ao excluir arquivo:" + CHR(13) + loException.Message, ;
11243:                 "FormProduto.BtnExcArqsClick")
11244:         ENDTRY
11245:     ENDPROC
11246: 
11247:     *-- btnOpnArqs: abre arquivo selecionado com aplicativo associado do SO
11248:     PROCEDURE BtnOpnArqsClick()
11249:         LOCAL loc_cArquivo, loc_oPg, loException
11250:         TRY
11251:             IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
11252:                 loc_cArquivo = ALLTRIM(cursor_4c_GrdArquivos.arqnome)
11253:                 IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
11254:                     DECLARE INTEGER ShellExecute IN Shell32 ;
11255:                         INTEGER hwnd, STRING lpOp, STRING lpFile, ;
11256:                         STRING lpParams, STRING lpDir, INTEGER nShow
11257:                     ShellExecute(0, "open", loc_cArquivo, "", "", 1)
11258:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
11259:                     IF PEMSTATUS(loc_oPg, "img_4c_ImgArqJpg", 5)
11260:                         IF INLIST(UPPER(RIGHT(ALLTRIM(loc_cArquivo), 4)), ".JPG", ".PNG") OR ;
11261:                             UPPER(RIGHT(ALLTRIM(loc_cArquivo), 5)) = ".JPEG"
11262:                             loc_oPg.img_4c_ImgArqJpg.Picture = loc_cArquivo
11263:                             loc_oPg.img_4c_ImgArqJpg.Visible = .T.
11264:                         ELSE
11265:                             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
11266:                         ENDIF
11267:                     ENDIF
11268:                 ELSE
11269:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArquivo)
11270:                 ENDIF
11271:             ELSE
11272:                 MsgAviso("Selecione um arquivo para abrir.")
11273:             ENDIF
11274:         CATCH TO loException
11275:             MostrarErro("Erro ao abrir arquivo:" + CHR(13) + loException.Message, ;
11276:                 "FormProduto.BtnOpnArqsClick")
11277:         ENDTRY
11278:     ENDPROC
11279: 
11280:     *===========================================================================
11281:     * ConfigurarPgpgServico - Configura Page8 "Servicos" do pgf_4c_Dados
11282:     * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgServico
11283:     * grdServico: top=171, left=339, width=320, height=387, 3 colunas
11284:     *   Column1 (ColumnOrder=2): Descs - editavel em INCLUIR/ALTERAR E Marcas=1
11285:     *   Column2 (ColumnOrder=3): Cods  - somente leitura
11286:     *   Column3 (ColumnOrder=1): Marcas (CheckBox) - editavel em INCLUIR/ALTERAR
11287:     *===========================================================================
11288:     PROTECTED PROCEDURE ConfigurarPgpgServico(par_oPg)
11289:         LOCAL loc_oPg, loc_oGrid, loc_oErro
11290:         TRY
11291:             loc_oPg = par_oPg
11292:             loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
11293: 
11294:             *-- Cursor placeholder ANTES de RecordSource (REGRA CRITICA VFP9)
11295:             IF !USED("cursor_4c_GrdServico")
11296:                 SET NULL ON
11297:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11298:                 SET NULL OFF
11299:             ENDIF
11300: 
11301:             *-- grd_4c_Dados: grade de servicos associados
11302:             *-- Original grdServico: top=171, left=339, width=320, height=387
11303:             loc_oPg.AddObject("grd_4c_Dados", "Grid")
11304:             WITH loc_oPg.grd_4c_Dados
11305:                 .Top        = 171
11306:                 .Left       = 339
11307:                 .Width      = 320
11308:                 .Height     = 387
11309:                 .FontName   = "Tahoma"
11310:                 .FontSize   = 8
11311:                 .DeleteMark = .F.
11312:                 .RecordMark = .F.
11313:                 .RowHeight  = 16
11314:                 .ScrollBars = 2
11315:                 .Visible    = .T.
11316:             ENDWITH
11317:             loc_oPg.grd_4c_Dados.ColumnCount  = 3
11318:             loc_oPg.grd_4c_Dados.RecordSource = "cursor_4c_GrdServico"
11319:             loc_oGrid = loc_oPg.grd_4c_Dados
11320: 
11321:             *-- Column1: Descs/Descricao Servico (ColumnOrder=2 - exibida como 2a coluna)
11322:             *-- When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
11323:             *-- Valid: fAcessoEmpresa (validacao empresa por descricao de servico)
11324:             loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdServico.Descs"
11325:             loc_oGrid.Column1.Width           = 228
11326:             loc_oGrid.Column1.ColumnOrder     = 2
11327:             loc_oGrid.Column1.Movable         = .F.
11328:             loc_oGrid.Column1.Resizable       = .F.
11329:             loc_oGrid.Column1.Header1.Caption = "Servi" + CHR(231) + "os"
11330:             loc_oGrid.Column1.Text1.Alignment  = 3
11331:             loc_oGrid.Column1.Text1.BorderStyle = 0
11332:             loc_oGrid.Column1.Text1.Margin     = 0
11333:             BINDEVENT(loc_oGrid.Column1.Text1, "When",  THIS, "GrdServicoCol1When")
11334:             BINDEVENT(loc_oGrid.Column1.Text1, "Valid",  THIS, "GrdServicoCol1Valid")
11335: 
11336:             *-- Column2: Cods/Codigo Servico (ColumnOrder=3, somente leitura)
11337:             loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdServico.Cods"
11338:             loc_oGrid.Column2.Width           = 50
11339:             loc_oGrid.Column2.ColumnOrder     = 3
11340:             loc_oGrid.Column2.Movable         = .F.
11341:             loc_oGrid.Column2.Resizable       = .F.
11342:             loc_oGrid.Column2.ReadOnly        = .T.
11343:             loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
11344:             loc_oGrid.Column2.Text1.BorderStyle = 0
11345:             loc_oGrid.Column2.Text1.Margin     = 0
11346:             loc_oGrid.Column2.Text1.ReadOnly   = .T.
11347: 
11348:             *-- Column3: Marcas/CheckBox (ColumnOrder=1 - primeira coluna visualmente)
11349:             *-- Sparse=.F. obrigatorio para CheckBox funcionar em coluna de grid
11350:             *-- When: editavel em INCLUIR/ALTERAR
11351:             *-- KeyPress: Space(32) ou Enter(13) togla Marcas (0->1, 1->0)
11352:             loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdServico.Marcas"
11353:             loc_oGrid.Column3.Width           = 17
11354:             loc_oGrid.Column3.ColumnOrder     = 1
11355:             loc_oGrid.Column3.Movable         = .F.
11356:             loc_oGrid.Column3.Resizable       = .F.
11357:             loc_oGrid.Column3.Sparse          = .F.
11358:             loc_oGrid.Column3.Header1.Caption = ""
11359:             loc_oGrid.Column3.AddObject("Check1", "CheckBox")
11360:             WITH loc_oGrid.Column3.Check1
11361:                 .Caption   = ""
11362:                 .Alignment = 0
11363:                 .ReadOnly  = .F.
11364:                 .Visible   = .T.
11365:                 .Top       = 9
11366:                 .Left      = 2
11367:                 .Height    = 17
11368:                 .Width     = 22
11369:             ENDWITH
11370:             BINDEVENT(loc_oGrid.Column3.Check1, "When",     THIS, "GrdServicoChk3When")
11371:             BINDEVENT(loc_oGrid.Column3.Check1, "KeyPress", THIS, "GrdServicoChk3KeyPress")
11372: 
11373:         CATCH TO loc_oErro
11374:             MostrarErro("Erro ao configurar pgServico:" + CHR(13) + loc_oErro.Message, ;
11375:                 "FormProduto.ConfigurarPgpgServico")
11376:         ENDTRY
11377:     ENDPROC
11378: 
11379:     *===========================================================================
11380:     * CarregarServicos - Popula cursor_4c_GrdServico com todos os servicos
11381:     * de SigPrSer, marcando Marcas=1 para os associados ao produto em SigSerPr.
11382:     * Chamado de BOParaForm ao carregar registro existente.
11383:     *===========================================================================
11384:     PROTECTED PROCEDURE CarregarServicos()
11385:         LOCAL loc_cCpros, loc_nRet, loc_oPg, loc_oGrid, loException
11386:         TRY
11387:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11388:             IF EMPTY(loc_cCpros) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
11389:                 RETURN
11390:             ENDIF
11391: 
11392:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page8
11393: 
11394:             *-- Carregar todos os servicos com Marcas=0/1 via LEFT JOIN em SigSerPr
11395:             IF USED("cursor_4c_GrdServico")
11396:                 USE IN cursor_4c_GrdServico
11397:             ENDIF
11398:             loc_nRet = SQLEXEC(gnConnHandle, ;
11399:                 "SELECT CASE WHEN s.cods IS NOT NULL THEN 1 ELSE 0 END AS Marcas," + ;
11400:                 " p.cods, p.descs, p.qtdias" + ;
11401:                 " FROM SigPrSer p" + ;
11402:                 " LEFT JOIN SigSerPr s ON s.cods = p.cods AND s.cpros = " + EscaparSQL(loc_cCpros) + ;
11403:                 " ORDER BY p.descs", ;
11404:                 "cursor_4c_GrdServico")
11405:             IF loc_nRet <= 0
11406:                 SET NULL ON
11407:                 CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
11408:                 SET NULL OFF
11409:             ENDIF
11410: 
11411:             *-- Reassociar RecordSource e ControlSources apos recarregar cursor
11412:             IF PEMSTATUS(loc_oPg, "grd_4c_Dados", 5)
11413:                 loc_oGrid = loc_oPg.grd_4c_Dados
11414:                 loc_oGrid.ColumnCount = 3
11415:                 loc_oGrid.RecordSource          = "cursor_4c_GrdServico"
11416:                 loc_oGrid.Column1.ControlSource = "cursor_4c_GrdServico.Descs"
11417:                 loc_oGrid.Column2.ControlSource = "cursor_4c_GrdServico.Cods"
11418:                 loc_oGrid.Column3.ControlSource = "cursor_4c_GrdServico.Marcas"
11419:                 loc_oGrid.Refresh()
11420:             ENDIF
11421: 
11422:         CATCH TO loException
11423:             MostrarErro("Erro ao carregar Servi" + CHR(231) + "os:" + CHR(13) + ;
11424:                 loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
11425:                 "FormProduto.CarregarServicos")
11426:         ENDTRY
11427:     ENDPROC
11428: 
11429:     *===========================================================================
11430:     * Handlers de BINDEVENT para pgServico (Page8)
11431:     * Todos PUBLIC - requerido pelo BINDEVENT
11432:     *===========================================================================
11433: 
11434:     *-- Column1 Text1 When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
11435:     PROCEDURE GrdServicoCol1When()
11436:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11437:             RETURN .F.
11438:         ENDIF
11439:         IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
11440:             RETURN cursor_4c_GrdServico.Marcas = 1
11441:         ENDIF
11442:         RETURN .F.
11443:     ENDPROC
11444: 
11445:     *-- Column1 Text1 Valid: fAcessoEmpresa (validacao de empresa por descricao de servico)
11446:     PROCEDURE GrdServicoCol1Valid()
11447:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11448:             RETURN .T.
11449:         ENDIF
11450:         LOCAL loc_cDescs, loException
11451:         loc_cDescs = ""
11452:         TRY
11453:             IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
11454:                 loc_cDescs = ALLTRIM(cursor_4c_GrdServico.Descs)
11455:             ENDIF
11456:             IF !EMPTY(loc_cDescs)
11457:                 *!! CORRETOR #110: fAcessoEmpresa() NAO existe na nova arquitetura. Substituir por bloco FormBuscaAuxiliar apontando SigCdEmp (chave Cemps modo C, Razas modo D). Ver Formsigatcrp.prg:2278-2378.
11458:                 fAcessoEmpresa(Usuar, "C", loc_cDescs, .NULL., "")
11459:             ENDIF
11460:         CATCH TO loException
11461:             MostrarErro("Erro na valida" + CHR(231) + CHR(227) + "o de empresa:" + ;
11462:                 CHR(13) + loException.Message, "FormProduto.GrdServicoCol1Valid")
11463:         ENDTRY
11464:         RETURN .T.
11465:     ENDPROC
11466: 
11467:     *-- Column3 Check1 When: editavel apenas em INCLUIR/ALTERAR
11468:     PROCEDURE GrdServicoChk3When()
11469:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11470:     ENDPROC
11471: 
11472:     *-- Column3 Check1 KeyPress: Space(32) ou Enter(13) togla Marcas (0->1 / 1->0)
11473:     PROCEDURE GrdServicoChk3KeyPress(par_nKeyCode, par_nShiftAltCtrl)
11474:         IF INLIST(par_nKeyCode, 13, 32)
11475:             IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
11476:                 REPLACE cursor_4c_GrdServico.Marcas WITH IIF(cursor_4c_GrdServico.Marcas = 0, 1, 0)
11477:             ENDIF
11478:         ENDIF
11479:     ENDPROC
11480: 
11481: ENDDEFINE

